Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE41EC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8D010FEBE;
	Wed, 14 Oct 2026 17:28:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E5910FEC2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E52A4184E;
 Wed, 14 Oct 2026 17:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1281F000C5;
 Wed, 14 Oct 2026 17:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998922;
 bh=iL1pLBrM9ZdS/cqjkt/ledQ90OPfQIJDmiHTcQBbMGc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZBu2ZwOyqjnrvnANKqhWqvRcVEPsGL1jDi1aptVezbojQ7p8coT9EaHA75H25mZfe
 SD4Pb4GWk5qTpggUO8ieAleGmhjhtKUbbPZpxg+MoE4xp13b+YDqUfCCB+aOmqxg2C
 dROiTg45OIzle+iZPHjZJ6hNS77CHh97Wz47Q0b8q977wKb+4PVF9sBT1/e56yEwpi
 WtJ+K1ifQpNzZnnfhTbb8ZEjj3yHiJ3uhhgMIsCjGVdaHwPbyJrWKmkS9WAS40aazb
 IpuVtvmGAbOUTaTWvqqMwLLufsVFRDxVg5i9aco+eJjemhlgZdRtlIuQgej/2j2yJa
 JLkRhaX+i9rfQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:48 +0200
Subject: [PATCH 25/75] drm/imx: ipuv3: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-25-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QmpK7b1SjWD58nM5X8keIxLZmz1csaDjJVEvYgqprx0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd4e+U7zb+NxFSWVl17be+rWzJFkm/+pa0ejy+v6zk
 kKfnhn7OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEku8zNvy5nvX6h0tg/UOH
 c1+iGxISjZQVN838c/L47qjPh899XvKEf/qs2hqlRD6mlG/Hspn3OzA2fEvSTfxZV1NlPC0+zqb
 b4mBxxj/P0K3flzn8s+bJ143ZZ+3Ruv/Xy1BN27M/bdybCr8AAA==
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

The imx: ipuv3 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: imx@lists.linux.dev
---
 drivers/gpu/drm/imx/ipuv3/imx-tve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
index e861b8b9d8fa..4ece79374372 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
@@ -312,11 +312,11 @@ static void imx_tve_connector_destroy(struct drm_connector *connector)
 }
 
 static const struct drm_connector_funcs imx_tve_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = imx_tve_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static const struct drm_connector_helper_funcs imx_tve_connector_helper_funcs = {

-- 
2.55.0

