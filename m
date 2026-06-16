Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CEBCD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1963110E1B6;
	Tue, 16 Jun 2026 10:56:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="qwvS5XvE";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B8D10E1B6
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 10:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1781607371; x=1781866571;
 bh=do+xM1SWjPjLOlVlRqJ9yLYHrp4GONBqxZljStn6UVs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=qwvS5XvERtFswiyzxUAcN+Beu/XHh6rvVzyJ2ahysjV60++dzTKacCWFKHlSUJNaa
 CSI6WpvEKwMigRI7NzyhIBYa19/An96/1h4lDDiheHE3VV+MLhVjP6UDcsb5830jbi
 kH4DXPhnjizt4T6prC+7l9qo3WrCK5zrmWRUWsYTvgtzhNVVsU2CuJBvStSwDB99Z6
 CxQqwWDhISpFQGmym688j2Obgc3Mr+W1qPCgIm78RKW8CFb3BR8l7wxVg5Qhz7J5Di
 puVd14MpXYsQuIMqV9B/4qpD0IXUM50vnn5VVe3hZmS4BJ/5NPzmbRpec05/wjiHD5
 pyzB0qzu0+dYg==
Date: Tue, 16 Jun 2026 10:56:06 +0000
To: amd-gfx@lists.freedesktop.org
From: Gerhard Schwanzer <geschw@pm.me>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xiaogang Chen <xiaogang.chen@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 regressions@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amdkfd: Use exclusive bounds for SVM split alignment
 checks
Message-ID: <20260616105553.13062-1-geschw@pm.me>
In-Reply-To: <20260616091050.110064-1-geschw@pm.me>
References: <20260616091050.110064-1-geschw@pm.me>
Feedback-ID: 110185885:user:proton
X-Pm-Message-ID: 1d22fdbfda11a879d55aefe475533cc416384fe6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

SVM ranges use inclusive page indices: prange->last is the last page in
the range. The split-remap logic introduced by commit 448ee45353ef
("drm/amdkfd: Use huge page size to check split svm range alignment")
uses ALIGN_DOWN(prange->last, 512) to determine whether the original
range can contain a 2MB huge-page mapping.

That aligns the last page itself down. Thus a range ending one page
before the next 2MB boundary is classified as if the final 2MB block did
not exist. When such a range is split inside that final block, the
split head or tail can be left off the remap list even though it was
derived from an original range that may have PMD mappings.

Use prange->last + 1 as the exclusive upper bound when computing the
original range's last 2MB-aligned boundary. Then use the actual split
boundary for the head and tail alignment checks: tail->start for a tail
split, and new_start for a head split. new_start is equivalent to
head->last + 1 and directly names the exclusive end of the split head.

Using head->last for the head-side check can both remap a head that ends
exactly one page before a 2MB boundary and miss a head whose split
boundary is one page after such a boundary. Philip Yang pointed out in
the review of the original change that this condition should use
head->last + 1 or new_start.

Xiaogang Chen identified the inclusive-last cause and posted the
candidate fix in the regression thread. With the culprit change active
and the local revert not applied, the unchanged C/HSA reproducer
completes 10/10 runs with this change on an RX 7600 XT.

Fixes: 448ee45353ef ("drm/amdkfd: Use huge page size to check split svm ran=
ge alignment")
Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
Link: https://lore.kernel.org/stable/IA1PR12MB85172F7FE9157C092EDA46A0E3112=
@IA1PR12MB8517.namprd12.prod.outlook.com/
Link: https://lore.kernel.org/all/32ce2b72-aa16-4202-9f99-92e3cd4408bc@amd.=
com/
Suggested-by: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Gerhard Schwanzer <geschw@pm.me>
---
Changes in v2:
- Use new_start for the head-side split-boundary checks, matching Philip
  Yang's original v4 review guidance and avoiding aligned-head false
  positives / unaligned-head false negatives.
- Keep the tail-side last + 1 exclusive-bound fix from Xiaogang's public
  candidate, which fixes the reproduced RX 7600 XT SDMA0 fault.

 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 72cfb4a..59b15d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1144,7 +1144,7 @@ static int
 svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 =09=09     struct list_head *insert_list, struct list_head *remap_list)
 {
-=09unsigned long last_align_down =3D ALIGN_DOWN(prange->last, 512);
+=09unsigned long last_align_down =3D ALIGN_DOWN(prange->last + 1, 512);
 =09unsigned long start_align =3D ALIGN(prange->start, 512);
 =09bool huge_page_mapping =3D last_align_down > start_align;
 =09struct svm_range *tail =3D NULL;
@@ -1168,7 +1168,7 @@ static int
 svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 =09=09     struct list_head *insert_list, struct list_head *remap_list)
 {
-=09unsigned long last_align_down =3D ALIGN_DOWN(prange->last, 512);
+=09unsigned long last_align_down =3D ALIGN_DOWN(prange->last + 1, 512);
 =09unsigned long start_align =3D ALIGN(prange->start, 512);
 =09bool huge_page_mapping =3D last_align_down > start_align;
 =09struct svm_range *head =3D NULL;
@@ -1181,8 +1181,8 @@ svm_range_split_head(struct svm_range *prange, uint64=
_t new_start,
=20
 =09list_add(&head->list, insert_list);
=20
-=09if (huge_page_mapping && head->last + 1 > start_align &&
-=09    head->last + 1 < last_align_down && (!IS_ALIGNED(head->last, 512)))
+=09if (huge_page_mapping && new_start > start_align &&
+=09    new_start < last_align_down && !IS_ALIGNED(new_start, 512))
 =09=09list_add(&head->update_list, remap_list);
=20
 =09return 0;

base-commit: 2c7d5b0a5ec0fc713a7f350806553643e87e6f43
--=20
2.54.0


