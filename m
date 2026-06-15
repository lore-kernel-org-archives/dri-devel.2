Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603C3CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9162310E18D;
	Mon, 15 Jun 2026 04:49:04 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E871010E192
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 04:49:02 +0000 (UTC)
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-WlUcO-ttP4aLI4DqDrlygg-1; Mon,
 15 Jun 2026 00:47:43 -0400
X-MC-Unique: WlUcO-ttP4aLI4DqDrlygg-1
X-Mimecast-MFC-AGG-ID: WlUcO-ttP4aLI4DqDrlygg_1781498862
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7085819560BB; Mon, 15 Jun 2026 04:47:42 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.57])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3431A3008B37; Mon, 15 Jun 2026 04:47:39 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org,
	dakr@kernel.org
Subject: [PATCH] nouveau/vmm: fix another SPT/LPT race
Date: Mon, 15 Jun 2026 14:47:37 +1000
Message-ID: <20260615044737.3419585-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YjzasYK5thti3Y-CSE1C40I_oZ3O9qRUNHOt4-lIBrg_1781498862
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Dave Airlie <airlied@redhat.com>

We've had an unknown Turing issue for a while with page faults since large =
pages and compression.

I've got a patch series that syncs all our L2 handling with ogkm and it mad=
e this fault happen more.

After writing a bunch of debugging patches, I spotted an invalid LPT entry =
where there should have been a valid one.

A 64K MAP succeeds on a range, but a subsequent SPT put drops SPT refs acro=
ss multiple ranges,

We shouldn't assume all ranges where SPTEs go away will have the same spars=
e/invalid/valid state,
just iterate over each instead and do the right thing.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Fixes: d19512f5abb1 ("nouveau/vmm: start tracking if the LPT PTE is valid. =
(v6)")
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 31 +++++++++----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/dr=
m/nouveau/nvkm/subdev/mmu/vmm.c
index 8c9fd86b2596..f808a0679a3f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -234,29 +234,26 @@ nvkm_vmm_unref_sptes(struct nvkm_vmm_iter *it, struct=
 nvkm_vmm_pt *pgt,
 =09=09 * covered by a number of LPTEs, the LPTEs once again take
 =09=09 * control over their address range.
 =09=09 *
-=09=09 * Determine how many LPTEs need to transition state.
+=09=09 * Transition each LPTE individually as each may have a
+=09=09 * different target state (sparse, invalid, or valid).
 =09=09 */
-=09=09pgt->pte[ptei].s.spte_valid =3D false;
-=09=09for (ptes =3D 1, ptei++; ptei < lpti; ptes++, ptei++) {
+=09=09for (ptei++; ptei < lpti; ptei++) {
 =09=09=09if (pgt->pte[ptei].s.sptes)
 =09=09=09=09break;
-=09=09=09pgt->pte[ptei].s.spte_valid =3D false;
 =09=09}
=20
-=09=09if (pgt->pte[pteb].s.sparse) {
-=09=09=09TRA(it, "LPTE %05x: U -> S %d PTEs", pteb, ptes);
-=09=09=09pair->func->sparse(vmm, pgt->pt[0], pteb, ptes);
-=09=09} else if (!pgt->pte[pteb].s.lpte_valid) {
-=09=09=09if (pair->func->invalid) {
-=09=09=09=09/* If the MMU supports it, restore the LPTE to the
-=09=09=09=09 * INVALID state to tell the MMU there is no point
-=09=09=09=09 * trying to fetch the corresponding SPTEs.
-=09=09=09=09 */
-=09=09=09=09TRA(it, "LPTE %05x: U -> I %d PTEs", pteb, ptes);
-=09=09=09=09pair->func->invalid(vmm, pgt->pt[0], pteb, ptes);
+=09=09while (pteb < ptei) {
+=09=09=09pgt->pte[pteb].s.spte_valid =3D false;
+=09=09=09if (pgt->pte[pteb].s.sparse) {
+=09=09=09=09TRA(it, "LPTE %05x: U -> S", pteb);
+=09=09=09=09pair->func->sparse(vmm, pgt->pt[0], pteb, 1);
+=09=09=09} else if (!pgt->pte[pteb].s.lpte_valid) {
+=09=09=09=09if (pair->func->invalid) {
+=09=09=09=09=09TRA(it, "LPTE %05x: U -> I", pteb);
+=09=09=09=09=09pair->func->invalid(vmm, pgt->pt[0], pteb, 1);
+=09=09=09=09}
 =09=09=09}
-=09=09} else {
-=09=09=09TRA(it, "LPTE %05x: V %d PTEs", pteb, ptes);
+=09=09=09pteb++;
 =09=09}
 =09}
 }
--=20
2.54.0

