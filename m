Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BD6CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1278010FEBD;
	Wed, 14 Oct 2026 17:28:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD5410FEB0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E08044049;
 Wed, 14 Oct 2026 17:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64C81F000C4;
 Wed, 14 Oct 2026 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998919;
 bh=cCixLrEpVO0ikUgNOqkoErMEMOZi2q4QJtVdxN1QvaY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=m58xpQk0cyYYcmvLGrLraD3mabCeZq8aOn885LAk+DXhfCr25tkS9Juej2ym5dkt1
 pnt4qw0HIDbZOHfhiPHZAAsC8EO8R94JXQWzmi5FwHeoy32MizYQbHIkCv6m0hsqac
 ECNQQgFcdh6e3bG8d/4nlIPIP3BkT12qNZ3M3EJS8Ex2VrQ9j4lzpumhhMiI4LfS3A
 h4sMSvBd5jxs4278402IeJPEktbGlW19aELxKUTwIPFrTysCWd20vZoQ0XAawTpOXl
 YDhqniVqLPyGs71f5Y9qOYBP+chW2ibFedDK/19IWHlaKqD89XZhoizkVlr7uVC3Yv
 o/rS30avSib/w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:47 +0200
Subject: [PATCH 24/75] drm/hyperv: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-24-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ugtlh+MIfLszXFGE6m0yvcym1HwdCOM9fcPrb9p7Ius=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd4fKp29hipyqpXNFP6XCJCrolarPGmtl3yYeW+UpS
 s++us/tmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABOJOMLY8CBm0b3t5WxOBWdP
 /+mMNjxr4SDl9C1CnZlpTuFNVc3gGJvioK1n3twufblj1XO54KeujPWB9W9uf7py1sYjpG3156X
 ZmUYfJybua4n30U/blZa+Qdfh99nu7EMz2Fwc6+YrrjrndBUA
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

The hyperv connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 523d1c7ea072..da399cb951a5 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -64,11 +64,11 @@ static const struct drm_connector_helper_funcs hv_drm_connector_helper_funcs = {
 };
 
 static const struct drm_connector_funcs hv_drm_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static inline int hv_drm_conn_init(struct hv_drm_device *hv)

-- 
2.55.0

