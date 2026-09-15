Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A3DC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A989710EFEC;
	Tue, 15 Sep 2026 14:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mXSIoccS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80C010EFEC
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:25:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5AE7F600C8;
 Tue, 15 Sep 2026 14:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CA81F000FF;
 Tue, 15 Sep 2026 14:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789482320;
 bh=SJKoMvRgKD0Ur2jBFAOhr1o9qGNtypB7pibVa299A/M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mXSIoccScIK01YAVbRgqRRH4MTPBtll5lqsLIrppdrgTu1SxRpKIzG13op6ujGVQ1
 4nb8zq5Qn8pf5BubOY7D8Ola6Cf+MmmK+/S1/ieF4oSB/2FCpwZ4jy4iL5BN8WZdkh
 pe6JQkaZT++3aQ4greW8GA7OV6irhE0osrZ/yTJKVSvldgURowV+xU6Y7I3iAHnKf7
 Rxi9mPRFsPdQrcnvE1ao1hAyRqG0TytDA5Ur1jksgQncqjyuHrx9fTpiqqWESy1dmQ
 vz5ZnJDbowRowrbmcqY55yWPs0oTv8txO5iazVGv7h31Xn7pU3gvNt4y4G4TwJoWSj
 rj2AzwqOWIGOg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 15 Sep 2026 16:24:48 +0200
Subject: [PATCH v5 07/11] drm/tve200: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-drm-no-more-crtc-reset-v5-7-bda007735748@kernel.org>
References: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
In-Reply-To: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xUkz0erv+c8y9/L8B+eSc1myMePiK1wN2/YyQyR8nfQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkrQ/Xva0vvsL2okJWtHn9qntLeoy8+qSw/GPanb380l
 /s0j2CWjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRJwKMDee88ioOqFinrt33
 We9F7SWRo2uvF/4P0vj1N/6pENsvudgPEfzsnGFSyl6ZZ8ztNNaZM9bnuFy/9cZK1Ff1iOT0x//
 61v949qpWw/fJ7QCLWxwT7qrrV5RdEfzEPGmpT9T6SctX73QCAA==
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

The tve200 crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tve200/tve200_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tve200/tve200_display.c b/drivers/gpu/drm/tve200/tve200_display.c
index beb3a5a63b5d..90771464ac12 100644
--- a/drivers/gpu/drm/tve200/tve200_display.c
+++ b/drivers/gpu/drm/tve200/tve200_display.c
@@ -373,11 +373,11 @@ static const struct drm_crtc_helper_funcs tve200_crtc_helper_funcs = {
 	.atomic_disable	= tve200_crtc_helper_atomic_disable,
 	.atomic_flush	= tve200_crtc_helper_atomic_flush,
 };
 
 static const struct drm_crtc_funcs tve200_crtc_funcs = {
-	.reset			= drm_atomic_helper_crtc_reset,
+	.atomic_create_state	= drm_atomic_helper_crtc_create_state,
 	.destroy		= drm_crtc_cleanup,
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

