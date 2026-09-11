Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42983C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807EF10F5F5;
	Fri, 11 Sep 2026 13:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LFq0BgzS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2398F10F5E3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:21:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 989FB60A57;
 Fri, 11 Sep 2026 13:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3051F000FF;
 Fri, 11 Sep 2026 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789132881;
 bh=qSx+Tol941lisSO9yGyeqt60xyXbwAFpePufaZhJ3jU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LFq0BgzSWQHm2aQuVIp0UuDAldQLxCDpMGe8FbIqpdji/bZtvCXuYMVSjKkPG8Z5j
 enUyrKJcVMmbjM/fDRYrf9V/QdgZSkV4VYEYf6a431MAWDkjdBJoNBnq0I+mOqPV9q
 obHJ+eEY0/w8sPuPAxgasIFpqcXFixtMKs248sdXZgh6ueq7q0fqzwf7mGSUifhqTY
 HdHDj8AB5ukgXWgdJboJkkPLBQ8wAVbIUpaJTQRq84Z91SZb47tMgDWjhaR7FB/RdI
 CnCm9krjJr4eAe0vDxKUSk9cvr7N+ALFFZ95+/9qseDVA0YdhixvnWSnQHwUtxtk7U
 QnUF03GKtnDmA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 11 Sep 2026 15:21:08 +0200
Subject: [PATCH v4 1/4] drm/gm12u320: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-no-more-crtc-reset-v4-1-662e0ccd815c@kernel.org>
References: <20260911-drm-no-more-crtc-reset-v4-0-662e0ccd815c@kernel.org>
In-Reply-To: <20260911-drm-no-more-crtc-reset-v4-0-662e0ccd815c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Hans de Goede <hansg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Z/lWSidDo0OwPzGwkt2pYU65mbcUnFX6T3yE/9a28oQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlLGNxTuBbwsqluqJx87/7x4+quy7pPnHvmmrpIfJXIe
 0vvRZW+HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiYj8Zazju9tz5u/e1XKbG
 8veMk1TCDnL8PsxlMW118rMLb1dbzov5013V/WsHj+GJa+at/zcyTWCsFfSb+DiPMfR2bTpTq4y
 +6pkd6ta/n1bnv+F3My/zedl27GVvtbOnR1bNmlSnbMW/vssA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The tilcdc crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---

Cc: Hans de Goede <hansg@kernel.org>
---
 drivers/gpu/drm/tiny/gm12u320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 754617722a0d..ddc19cd3e03c 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -650,12 +650,12 @@ static const struct drm_crtc_helper_funcs gm12u320_crtc_helper_funcs = {
 };
 
 static const struct drm_crtc_funcs gm12u320_crtc_funcs = {
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
-	.reset			= drm_atomic_helper_crtc_reset,
 	.destroy		= drm_crtc_cleanup,
+	.atomic_create_state	= drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
 };
 
 static const struct drm_encoder_funcs gm12u320_encoder_funcs = {

-- 
2.55.0

