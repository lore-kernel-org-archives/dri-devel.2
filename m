Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE23CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083E910FEFA;
	Wed, 14 Oct 2026 17:30:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A050510FEF5
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 23D3960229;
 Wed, 14 Oct 2026 17:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519601F000C5;
 Wed, 14 Oct 2026 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999028;
 bh=jJT3keQflSBhSQY1EbiDS+GmPlqtnZaMoMn8L9LQnss=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=b596fPDDF38NS0pXq/2cuNjMjwXmm5yDPXyFrY6KWVCHgsd83HjE76VqezLle49SN
 eudy25Gl1WajM4gLnmCu5GdRVZCXPTcnbkiWNnp6iu7sYxTOsyxRjodLX7v8YUXPcP
 69UDaLbJjk3VqrG8pJ3o8uVK2o15aSxbuA7e28Ab4oHiHwaDqcS4PCqv2pbIGTJwV+
 6KtIpA+9/dd9KLEjmYXbM10/veugksBzuVBL5nm1NrUTX/eKrfaA7L+nObY33Ca4MP
 aPJ75LiMME4eXz0+/v9/XB+i+DgeYu9ny0YSUcp2r/0YhRza6rh5OPhRIyCS+zvVuO
 oJ5S94BpdTlrA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:17 +0200
Subject: [PATCH 54/75] drm/xen: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-54-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rPGf0IrTc8IQVJ2W52OaNnWD/rsewfk92GCxK1oKPrY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndye9tWqYGr1EmPXrLvuaNnHupK/1XBVTDi9tWXW9T
 rRy4cONHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiPWaM9WXvFeY+85Bl+t4U
 p98unPR0S+yp3V43tDpXH1FZ5memuGL1Oo03q8/oX1wlbruidIeRPGN9fMeWnSt3MIfP9nuoyHN
 O+67P6tw9Ln2H926d+epHA7NyWHhayKQZGgevTdsYcckkSI8ZAA==
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

The xen connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_conn.c b/drivers/gpu/drm/xen/xen_drm_front_conn.c
index a1ba6d3d0568..8ceac0947be2 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_conn.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_conn.c
@@ -92,11 +92,11 @@ static const struct drm_connector_helper_funcs connector_helper_funcs = {
 };
 
 static const struct drm_connector_funcs connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 int xen_drm_front_conn_init(struct xen_drm_front_drm_info *drm_info,

-- 
2.55.0

