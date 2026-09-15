Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EEDC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3987810F06E;
	Tue, 15 Sep 2026 14:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jD7wDrLr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E15910F037
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:25:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22B82602C3;
 Tue, 15 Sep 2026 14:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D071F00893;
 Tue, 15 Sep 2026 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789482323;
 bh=LU1MyyOnP/PBo2AdSDEMlKy2I5/qO0dxsy8AN2Sik8E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jD7wDrLrLwCo1zHyHxQkvMhFJFN/ZFh7m8tytnbCBCna0izZRAIU8Wirtzi/rV96w
 8GiAqJY2wt0j8EBDscJLbZQm/TFFanWH05GkMn+LXSK1X3OdUfw+Om4ysVPDhrXtmN
 dhNkuSjjfn53rde+M5AyFdOKWmD7Jg0npJxystO1o3jHEIYOYadEI4zUiPJ/Wo7KlF
 +G1zKJ36Oozx4GfODcKE6gawjBtvxZYyNRgN2xVczhudhr8GSdf//DN8G3RONuwPJc
 UYhpC4x4qAgpf3MJTPxvtFTQoUVy9Oq2jhp/f1M4NbDNFGV53at/i8mg8oFGTvvPl0
 FaiVRqJTXNqYw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 15 Sep 2026 16:24:49 +0200
Subject: [PATCH v5 08/11] drm/xen: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-drm-no-more-crtc-reset-v5-8-bda007735748@kernel.org>
References: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
In-Reply-To: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=mripard@kernel.org;
 h=from:subject:message-id; bh=q2+xANHtIOCsFPQCtVmgXNdiNNKptYCCvnzvf6xt8lY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkrQw2Eyz6rNm2/ufC8t8zKRTLVcxZ8Dv42z36luYyp9
 F9P7aWrO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEjn9nbDhQuj+3/vGHOTof
 spSfv+F8PnV5hc+tDsGwTuMvep7HLGvuGd8PY5wsKD7FdfGlx8LHdRkbdmUdP32KI5fld6597KT
 k50lHUy7e+Pu4wGEvd97/F0Hv/qUbLX1X0HTrfYeG/nn5z8X7AQ==
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

The xen crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/xen/xen_drm_front_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index 9896ea35b743..1f65fc407d77 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -356,11 +356,11 @@ static const struct drm_crtc_helper_funcs display_crtc_helper_funcs = {
 	.atomic_enable	= xen_drm_crtc_helper_atomic_enable,
 	.atomic_disable	= xen_drm_crtc_helper_atomic_disable,
 };
 
 static const struct drm_crtc_funcs display_crtc_funcs = {
-	.reset			= drm_atomic_helper_crtc_reset,
+	.atomic_create_state	= drm_atomic_helper_crtc_create_state,
 	.destroy		= drm_crtc_cleanup,
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

