Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C694606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=kbvw94+K;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=d5P2uTrX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F381127FC;
	Fri, 27 Nov 2026 08:29:10 +0000 (UTC)
X-Greylist: delayed 581 seconds by postgrey-1.36 at gabe;
 Thu, 26 Nov 2026 14:26:15 UTC
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7061D112498
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:26:15 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 8B3821D00496
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:16:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Thu, 26 Nov 2026 09:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1795702592; x=1795788992; bh=0jJSJ14/au0I5tvGdZLv3
 VBdYXYm14UxYMphMpPpqg0=; b=kbvw94+KqF0gfli8MChPdVX2dzxaiiDdkGNrX
 XA8rrai4Js67jKetb6X2w8WrlRWJFxagkosdzgWKzW+Evg9GBlw0AjbmL8JGhPXX
 R0pjmEh6Ldtm4Q/chyzW3mBupeazVC8mDRXdTmt79eVlzw1II2QppIlDjQpD8+a1
 uNquvc9K3JUF0LId5jra+HQvGLsmkjB4Bjxyk8YqVmvh+YSpeJfPIDth5Fg1Eej5
 VMl6gRhXpAk1Rhd66vi+CAKBRu/EmXKG6ER1fVEsmzZeMPQ3Rrcl1we3+dpzc4VN
 il4mAJlQ3FEkeU873+rbrBwHZnLqW57+aA47/7nYzJuCYmt5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795702592; x=1795788992; bh=0jJSJ14/au0I5tvGdZLv3VBdYXYm14UxYMp
 hMpPpqg0=; b=d5P2uTrXB70WVfA7IXJR47EdHHzwbVm5+ZWfc9o3wnYKiXG3+LA
 7cWLPJ+6cLPTsuwwHrrpngwy/0TqwMIWEOrMlREfK9CHtaO2rr3tfBs4eQKPYR0K
 hZ2UC9IYKnt77rTu28irZlT8621KDkUKHt2iV63ZWKGt6VeJDiT4v6/rGsUMafgG
 4HhcLWihKOW3zH3Q9bohqikrfMOUPJ8ocL+rR9k0bcbOA5gKsyMUYJNZIQsM4/f0
 Gp292IKrMQe77xUBF2oluDD+U6z2feh5AV/lJN1A49TI0U9Gbjy7bGsJtbWWKBdx
 n0MyUKl1wW6TBcX7Vf2n8Yr7HQLd7U4Bp0A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795702592; d=fastmail.com;
 mf=PGJhcmFudEBmYXN0bWFpbC5jb20+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm3:rsa-sha256:WBsZiOxAPGzNjVonvMb9tmtqmPVKG52MZDkLZIE5e7bgf9p
 3gkw7/gKxvKySWKlUBkJk4lXsJ/iZMynms4rzkYax09ONm+PquvQuxJHvvAAYuYS
 CGHTE3PXZp3KdOnz4JwLpTkTZ2IRhx35TP3moUZbDO38k43SZMUM6N8Zh1DPbgo1
 KSiVlnndZrr4+8rYl1brhg7YJbg4jGlpQvyEz64fKbbdO/CxYxtSdX13fpQqdE/G
 PTdBbpnzGKIsYvd9HRgjpxPAlzM1IjqwN7YVAhVMzR+616mFRBM9vE03zZj7Q8L3
 oQimhph9H7lwvw4xs9HRghrB1lq5dUwbc6YuX4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:decYHEp1do/N1tLYzQVUe3iGZipOzmD6xPUvkPHPia0=:vQqCiOEAJ5fdy/X2Eu1ZZCDteP3JyJpjgB8/9HEG7Pw=;
X-ME-Sender: <xms:Pz8Ia7aSol5PN-y4nT6Cq3QQ6_fj6bdKgIcIdhSKsiGuGHpccKCYNg>
 <xme:Pz8Ia_WwXHxEMY3XWvS6VOpSZRo0QKKkRlWvuQ5VLexnZ2cbtMc0KP7sfXnOKZVm_
 RrblkH_BdBO6d2VbgFzbxkeDtkaR_wA7N-K0-Xo-V9MR371yqvFE9Eg>
X-ME-Received: <xmr:Pz8IayOmz1MGkevWRuhJFAfidiZC77tlSTDJO_hAMcMYiyCb3y-tZ2K5>
X-ME-Proxy-Cause: dmFkZTEcC6pu7LwrB/ySbP3kl6e61I652LHUGBMkCQxxjnqHtpZRQ1RSAqJ7nLzncMfvcZ
 GGRPVTlArz6DghdWIR6nJjRpetdZcbYJA9sobWt5l+OE8E76RfbwE4v30gzpdXpOX+X2rO
 d2CO0GInVpNDtde4phNqKkOCWW/28/sysC+2sdQetpH55hDYXZ1Dt6FQ8NLurJ8Eyzstl4
 9WRVQyp8Ag+Vm3Lssktpbyy2P9/B8yOpCGGyM4LzeKOxr8wa7pXr/3TaTYC79qH10i5UqI
 pGNF7xS7yiICDcXiw6h7UI+wnqPP71fPBLGm9qWecX7hx3Zub/dwMPgSydzq6yZ2/KVOGv
 wel4e8lYHTHi8bjYtdBnXeEeL9sEXapXGlNOjK6a6ps1EqDDuqbVN3NecG3qzRzj6BX42K
 HeWYUjQgr1VPT9dn3pAbTEraMt6wO4jeCwOcL8GS3OKeSB1oubn2yZtsr2W1yRUimut8Sb
 2Y5qYv9tq8mDsduYyGN4pIO7vlmoXX4tai0ExI4HbMG3/2IzBNkX5CyGZXHV8kulQ8NxEM
 ZB1ydAWtsXXXxbnL1WSNaNeHFJgTgX0hMvZa/mk3OK321jwL2NbCm00i8VGUhgEE2rINDC
 7QR+IkZcQgBJsw/AMpLwycyixJAkJ2Rchwp9I7T6YdMvrb7InP2lqgb3lAcg
X-ME-Proxy: <xmx:Pz8IaxblktLcODS1n2BeIfjgcLiFGqWgOFSXJE8arIc5b3yPgkxNYg>
 <xmx:Pz8Ia59KrK9pD7ZI1lbSpO0O5xvLTNI_LUl19mPibbtqAsTyCbxcbw>
 <xmx:Pz8Ia6SGxrucul4l4HU1FeEoLv2mfc2xHaFEyzWFSYNXWVQsD_ZZVw>
 <xmx:Pz8Ia7fkVBsnZqUdpAI7VeXfCSBGyohov-r3FGpWXPtnKuGETSg2Zw>
 <xmx:QD8Ia-4GAZ5HkUbB188TlSffRIpU7DE2iQPv-TJv5133ZKcPbEQtiiaA>
Feedback-ID: i9dce4b48:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 09:16:29 -0500 (EST)
From: Baran Tuna <barant@fastmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Use str_enable_disable() helper
Date: Thu, 26 Nov 2026 17:16:17 +0300
Message-ID: <321392d0d9dba36777ec771663c677509fb49c15.1795702369.git.barant@fastmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the open-coded enable ? "enable" : "disable" ternary with
the str_enable_disable() helper from <linux/string_choices.h>.

Found by scripts/coccinelle/api/string_choices.cocci.

Signed-off-by: Baran Tuna <barant@fastmail.com>
---
Compile-tested only.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5d1b010bec9b..870b4653314f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -85,6 +85,7 @@
 #include <linux/firmware.h>
 #include <linux/component.h>
 #include <linux/sort.h>
+#include <linux/string_choices.h>
 
 #include <drm/drm_privacy_screen_consumer.h>
 #include <drm/display/drm_dp_mst_helper.h>
@@ -1468,7 +1469,7 @@ STATIC_IFN_KUNIT void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 			rc = amdgpu_dm_irq_set(adev, irq_source, enable) ? 0 : -EBUSY;
 			if (rc)
 				drm_warn(adev_to_drm(adev), "Failed to %s pflip interrupts\n",
-					 enable ? "enable" : "disable");
+					 str_enable_disable(enable));
 
 			if (dc_supports_vrr(adev->dm.dc->ctx->dce_version)) {
 				if (enable) {

base-commit: 25faec9ce61c01fb45abf812a222c5b43c3cd5c5
-- 
2.53.0

