Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A156C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5ED110EFD4;
	Tue, 15 Sep 2026 14:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fnoe0VyB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E39D10EFD4
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:25:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E51DF602D1;
 Tue, 15 Sep 2026 14:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEA91F00898;
 Tue, 15 Sep 2026 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789482316;
 bh=1mY9aIbVabfFQp57iun5YvcFa8blgFMRujAydjEzeSE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fnoe0VyBJYfMl2Bdc/eFjNyzMaJRJskpYR8a0x71lqOxs0cTy+1lPPRxD8Ijawif+
 bzNdoy1g1SbhacUHzcuDV0OTmgL+EqG0vLMyk61tbQiIqdHWe0CcXXNR6JUhY5nmzc
 KoiekNk4r/Y3qR8iL5vIbFLWyXR/lNIzezq+73njmuSq7hevTaq3oa+Yz6r8X8+fmi
 7Mv35KgeRpXX3n0Xv/Al/7k71HqPJtk/NOLGe7PuV7LOdSumG4uOFCsMoKwVXTuZ+n
 KP6k3JrMpP/4kFTEmmDtCEYGBzarK6JgDrSeAXJhFIqXr+L9/cQj9YI6zacfTpJXk2
 TgdB4biz99NOQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 15 Sep 2026 16:24:47 +0200
Subject: [PATCH v5 06/11] drm/repaper: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-drm-no-more-crtc-reset-v5-6-bda007735748@kernel.org>
References: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
In-Reply-To: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UgK6Pu+6pG3MOgsOsb+CCg2s4AJg9koLLJu05QyM/Rk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkrQ/XFrq3lep7D9mzF4at3cm7M7Cq5ElV8U9xRx/Urc
 8zUiM9KHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAizn2M9SEbd37REqpwviOx
 +deN51pWNkt21LYtUbj68sN9lhKxFSLhLJOvXXcM0m46epXl0eWQWMY6HREr5mbjRfyfIkyL9k/
 6xMCp5HNuCXPR7/0NDjNu3X344sMrIeE/CqGXQ1Yf0PwyP1QfAA==
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

The repaper crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tiny/repaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index f225e38fd404..82c99d86656f 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -902,11 +902,11 @@ static const struct drm_crtc_helper_funcs repaper_crtc_helper_funcs = {
 };
 
 static const struct drm_crtc_funcs repaper_crtc_funcs = {
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
-	.reset			= drm_atomic_helper_crtc_reset,
+	.atomic_create_state	= drm_atomic_helper_crtc_create_state,
 	.destroy		= drm_crtc_cleanup,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
 };
 

-- 
2.55.0

