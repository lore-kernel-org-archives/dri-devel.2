Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1B606A336
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 00:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKfIg4+T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A8910E098;
	Mon, 23 Nov 2026 00:25:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7408410E098;
 Mon, 23 Nov 2026 00:25:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C01061811;
 Mon, 23 Nov 2026 00:25:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795393538;
 b=ng66N8noSd7TP7mn547F+IOwNf7WsOAsMJhDITEQsZ/sSwAZKeGu8RMdbhYyMaeHzxfj
 QGO/VHSP2ziqFUgVB70WpgAURB+K0Ry5Y+SvuDhAXNWH889eZnNGsemBSmQi5oov2td/j
 LbqaI+dQCI5OvOopBFjVKPO3PYz90mUfds8fQHmn5VRvOxqfg7IK7od1WzsP9yrgI176y
 HAfqyjeB/JYNt8EJ5u2eIgqLU9FrquTUid3vBTrDK8/s/NqtH01JdTzc49eodihQ3KjpU
 NW40b2Vzmb8GrNpYxV8CAc4cIRQKkh7rohORh3TpR2OvGdQf4NI9QKE9wVUs/URtdsA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795393538;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=+fTRlpWPAGw65ywOTuFMTMS1pyXlFiqbrJNGcRe7pm8=;
 b=YDEKSKsiRyTL6RW5lwZXpvfQqq66rp3KkMJDCow1qTe7fPvhM+bDJMGm7W66hB2sqY2N
 lTVFW5mMERWfK2OfbvmQWpb6qJDilYSrz26BYll1xzfvYU5YVs7z3ACITeIJTmj8uCzE7
 D+uHmiDphqkyxgavyfKaGrjWKfMMandgsyqIg18gDVvbZvjN18IONViRCW4KgDVodRrKR
 5VngWE7yCj9y8AeaKNzYt00E3Z2QVodJic9cuqX389+0GE0zPo6rzRNZV9LfNuK43HHs4
 k32Sy38EAJjxJsZ21Ohjzf10CMbW839ebiW8CHjW9ARtolowWfen8pMS6+eXRTb6wrA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D4F021F000D4;
 Mon, 23 Nov 2026 00:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795393538;
 bh=+fTRlpWPAGw65ywOTuFMTMS1pyXlFiqbrJNGcRe7pm8=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=AKfIg4+Ts8rnb55XWxA6N68f8jzuRWtRuw9xtMSgWkHqYgfq9NC6z0MVPgXbegk2R
 X1si7PmfdOx2TGDf1Ta+mXoi0skPN1lwurJmWH5z4LW9BXYnyz/ClVqK+Nyul+cx1B
 cCJ/i/J3lPF3t5S6qy7qcctLhI/5G/5naRUSryrWaJLuy2Rwr5hlDkPnWi/y16Ppwe
 JomadweDfwiY5simOh5Z1Z9SxhGe9wO5rlyY0UTaZpDaFLk6Y+KVZmpkSxHa7j1FbG
 ndIGXdIDh5BibiynUvBq1hXJLZDb0/ZRui6E6ijmVXDJMrc5aOT5qgIhHrH0U7w9E8
 Al+anoY1cXoBw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 663F74C243;
 Mon, 23 Nov 2026 00:25:33 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Mon, 23 Nov 2026 10:25:26 +1000
Subject: [PATCH] drm/nouveau/devinit/gf100-: fix double vbios init checks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-nouveau-fix-disp-v1-1-ebdc525287ce@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7biGNBPtKdJBcay8qihGIf086D
 sNMg0KZqcAmGmR6uHAMA+Qk4LxtuAjZDQY1Ky2lWjDE+pCt6PlFxyWhVn413hntiWBkKdNw/3I
 /ev8Aaxn27mIAAAA=
X-Change-ID: 20261123-nouveau-fix-disp-62f59fd96fee
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=fLgUkfu8VDBsHKAcmadqaVH0gSOhunpVuhNXOsf7LQ0=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBrA4f4Li9p2SfqLVkMRYpuSKzNDxRgsYBBuKP6r
 yBJoSLEYqqJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCawOH+AAKCRAMdPNZecSG
 vtJUEACnc96+K4mI4B03aLzxP3BEnCThCmG7zw4qa85DUJtAyA0go0Tklhwt4lkU7b6UQMTt4Vh
 g2AFJzUNF2h8874mF91QgkbVP601i4jXjboTZX6l0FcGYj479/LIwaWgkah1CEGC/VOLv7ZwLyN
 GT315QlkK97hwrc8K2YmKLj9fqO8Fk4fNg+EQZJSg5ipS2akDolnKW+267Yugu9M4n2Jwhol6IF
 7U23DJyqNq7XvLww2quVo1Jd6/La0NZbaihOeo9Z476Y7o3Ns43ZEEnxPAFhC2KgI2g0qM8ge/k
 1puseARHoo/x0hg86LahzQCI8brwk9NOwXufCISXCvU9gizPY4WP/XewKFDw2w/BYMqKNfMJgLm
 gK/CffNVkrl3g13YFWZp+6LaLBrT2C7YKc9o6uUcTs3cmILZ/JvGVC9fne+TDtQDFP5l0qEtfsw
 O00LVRmsU7utMy5/R2f7XkuTo/bQ3bKpW9GDOuShsq8LsCPLUth8xorDn7UH60J3Vt1Pnm3yqJx
 sBycnRlMO9HpJPDARAKEf0IQIzWRDcOWfId7FX0TNgcvdD+K+qqixjw5aoZADi+xpFj4z5VKqi5
 GMb90cCLJyRNS8Tm0Z9cmxzIl70mA4RLAeau+1N7rmuCQAdt60OWeO6dRsiF8sIecKL+UkXbGaY
 TUUJE1ZfqkRcjbQ==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: airlied@redhat.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Airlie <airlied@redhat.com>

The initial fix from 2017 wasn't updated for modern nouveau devinit
disable paths.

Fix that and just check if display exists instead.

Fixes: 2139cb633d48 ("drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts")
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
index 186e09ea0cb1..b256404c2454 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
@@ -107,12 +107,12 @@ gf100_devinit_preinit(struct nvkm_devinit *base)
 	 * VBIOS multiple times may have detrimental effects.
 	 */
 	if (base->post) {
-		u64 disable = nvkm_devinit_disable(base);
+		nvkm_devinit_disable(base);
 		/* magic to detect whether or not x86 vbios code has
 		 * executed the devinit scripts to initialise the
 		 * board. only works if there's a display engine.
 		 */
-		if (!(disable & (1ULL << NVKM_ENGINE_DISP))) {
+		if (device->disp) {
 			if (nvkm_rdvgac(device, 0, 0x00) ||
 			    nvkm_rdvgac(device, 0, 0x1a)) {
 				base->post = false;

---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261123-nouveau-fix-disp-62f59fd96fee

Best regards,
-- 
Dave Airlie <airlied@redhat.com>


