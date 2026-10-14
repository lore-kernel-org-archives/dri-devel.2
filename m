Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB80CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E1010FEC9;
	Wed, 14 Oct 2026 17:28:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CBA10FEA9
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 38B1543FDE;
 Wed, 14 Oct 2026 17:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A30E1F000C5;
 Wed, 14 Oct 2026 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998912;
 bh=biitwIZSQb9FfmC3ocXv13x5I0FGRj9CyXU8MFKnqWM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TiSiKq0ycGwyCK3Kb70HehwUS/hbwBMkUr5MO82YKnkObkiqk1rwHA8cWip8tMsQj
 e3V+NflDkxZhY7gVRlksFVpACASou3BCNdI/d4PVLUEwJuByuSW4MOq001VE0FVW/M
 IdVBQ69R8TRolTAdVgJqKot9pPmKZ0O5TMx3wFa8SrI616P2pSptPdmr3XDDAY5D13
 iw3l6humFIznBj1mGoYsAm6iwKibMMlj0nvu10toKLRUR3TdrcsxK5Zka0yjdCz259
 iiJjuKYAlmAy3c2Zh1Y0XpDNSWhZQaSP9iOC+73aTdztRVmSkcPZgONalRayeJCMUr
 elaR+MYcsz8/Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:45 +0200
Subject: [PATCH 22/75] drm/fsl-dcu: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-22-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=mripard@kernel.org;
 h=from:subject:message-id; bh=qryj+u6zvsWPEn+goi+vNW3f/wp1XwiKrVgTPqjuyEU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd4csdStmsji6fl7IBtGAh97fnBQm3eu7Zxt0ctFbh
 XnlVzbM65jKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATidJmrDOWbP16KH6J6b54
 LpVda7Tkyt/8+72UXSLne99jNsnrBn3iBst26sil6TrbtwTN4WF+zVjvcz/ue8fkByJ7xC7u+L1
 bQtVVQdk5/ecdnZ9bY04Hdgks80v0TPS4Kubg8bzmV2+86B0A
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

The fsl-dcu connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alison Wang <alison.wang@nxp.com>
Cc: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index c64264541fe2..258bc556dde0 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -52,11 +52,11 @@ static void fsl_dcu_drm_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_funcs fsl_dcu_drm_connector_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.destroy = fsl_dcu_drm_connector_destroy,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 };
 
 static int fsl_dcu_drm_connector_get_modes(struct drm_connector *connector)
 {
 	struct fsl_dcu_drm_connector *fsl_connector;

-- 
2.55.0

