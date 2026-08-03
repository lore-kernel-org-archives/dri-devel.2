Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC184C5518E
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 390F810E3FA;
	Mon,  3 Aug 2026 09:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DshCaFom";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42ACB10E3FA
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 09:35:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 48DED60A6A;
 Mon,  3 Aug 2026 09:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5EAEC2BCF4;
 Mon,  3 Aug 2026 09:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785749722;
 bh=pEhdubdwQhXLBA4KlTkM0Pj/hAXqDs67/ox0ZY9gVdI=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=DshCaFomi9EV93fQWqzCjCsSZ3LUkA2c7edji9d1dNk54BHaYdGq3cWMmbNlxlI4G
 fJUFudW8rudVBsC/cQngqoKmgRijQP7CBlRK/S3YP1ZUj3dTE6lUqtJVfQxbPuTZR2
 PC8KN4PkWCB93dxXJQFLGsKpbn2oDs/2KtjTjKbaVbmlashDcd7bEKjEgd0ng18+SV
 IDmQ7uvyNTGliw2cV1mijA8G30dHGaTZvqEW2RztS6P37hLbUvKOzBk8YOwINTlSQM
 jCufC/0FTjG6m92UJ8+vUBtrhFRmKzHOEhTvaTIACB5z+LbiT995DXR8naV358OfIf
 yHhuKcb8q+IWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D3A26C5518E;
 Mon,  3 Aug 2026 09:35:21 +0000 (UTC)
From: Markuss Broks via B4 Relay <devnull+markuss.broks.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 12:35:20 +0300
Subject: [PATCH] drm/panfrost: add Mali-G68 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-staging-mainline-v1-1-5071dc782149@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWduktkDQqxgWLf7WMTqaDhASw
 t2tsvwW762kyAylc7VSxszKbyk4Hioa7kESDF+LyVnX2s56o2NILMm8AsuTBQYR3ampfWy9o5J
 9Mm68/JeXfrdO8YFh/H1o276AUGJddAAAAA==
X-Change-ID: 20260803-staging-mainline-ebe89543b632
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785749721; l=2284;
 i=markuss.broks@gmail.com; s=20260803; h=from:subject:message-id;
 bh=zQVxjMJtITy41A+IcC52/FUWFw7jC+G0clbf2HLVuYM=;
 b=fvHu/gkWgO0W0WtruK/CG5K4YBiMRZZckWUWdyak5vKrg0BS2uBKssba19WFr1IG1XczflJjL
 uILvCc8Wf4aA/3q6+8GLRgj5IgqTY6hg4qoSMtqGanz9XaM4OhXSMRo
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=oKzGUTm30BCDqinRMpiHQqByOx1mp2mwmhg80Mv7Zg4=
X-Endpoint-Received: by B4 Relay for markuss.broks@gmail.com/20260803 with
 auth_id=911
X-Original-From: Markuss Broks <markuss.broks@gmail.com>
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
Reply-To: markuss.broks@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Markuss Broks <markuss.broks@gmail.com>

Add the features, issues, and ID for Mali-G68, a first-generation
(v9) Valhall GPU.
Tested on Exynos8835: the GPU reports GPU_ID 0x9204 (G68 r1p1).

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_features.h | 2 ++
 drivers/gpu/drm/panfrost/panfrost_gpu.c      | 3 +++
 drivers/gpu/drm/panfrost/panfrost_issues.h   | 8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_features.h b/drivers/gpu/drm/panfrost/panfrost_features.h
index 52f9d69f6db9..34c65847192f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_features.h
+++ b/drivers/gpu/drm/panfrost/panfrost_features.h
@@ -121,6 +121,8 @@ enum panfrost_hw_feature {
 	BIT_ULL(HW_FEATURE_IDVS_GROUP_SIZE) | \
 	BIT_ULL(HW_FEATURE_CLEAN_ONLY_SAFE))
 
+#define hw_features_g68 hw_features_g57
+
 static inline bool panfrost_has_hw_feature(struct panfrost_device *pfdev,
 					   enum panfrost_hw_feature feat)
 {
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 7d555e63e21a..83223192a544 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -242,6 +242,9 @@ static const struct panfrost_model gpu_models[] = {
 	/* MediaTek MT8188 Mali-G57 MC3 */
 	GPU_MODEL(g57, 0x9093,
 		GPU_REV(g57, 0, 0)),
+
+	GPU_MODEL(g68, 0x9004,
+		GPU_REV(g68, 1, 0), GPU_REV(g68, 1, 1)),
 	{0},
 };
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_issues.h b/drivers/gpu/drm/panfrost/panfrost_issues.h
index eb60cb83667a..dd39946bb572 100644
--- a/drivers/gpu/drm/panfrost/panfrost_issues.h
+++ b/drivers/gpu/drm/panfrost/panfrost_issues.h
@@ -265,6 +265,14 @@ enum panfrost_hw_issue {
 #define hw_issues_g57_r0p0 (\
 	BIT_ULL(HW_ISSUE_TTRX_3485))
 
+#define hw_issues_g68 (\
+	BIT_ULL(HW_ISSUE_TTRX_2968_TTRX_3162))
+
+#define hw_issues_g68_r1p0 (\
+	BIT_ULL(HW_ISSUE_TTRX_3485))
+
+#define hw_issues_g68_r1p1 0
+
 static inline bool panfrost_has_hw_issue(const struct panfrost_device *pfdev,
 					 enum panfrost_hw_issue issue)
 {

---
base-commit: 415606a7be939835db9b0d6b711887586646346d
change-id: 20260803-staging-mainline-ebe89543b632

Best regards,
--  
Markuss Broks <markuss.broks@gmail.com>


