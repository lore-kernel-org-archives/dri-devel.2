Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A7AC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C429310FEBF;
	Wed, 14 Oct 2026 17:28:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 560D410FEA7
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3EC364184E;
 Wed, 14 Oct 2026 17:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C571F000C4;
 Wed, 14 Oct 2026 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998894;
 bh=012WCexuXVEHvDZf3uBWHDjCcHOxmF1VJPvt+qGnM0k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=bfPhwu0je7WwTGRypn+/wsaEUWdUyiB5ML5MeR+xUUjlvWpAsl+2FkII7VTjKm5b5
 DwgeVpmGOpwQzkJnJ8Wo829Gjp4S5dKrq1mU/0BhZ4uuBWWOUxM/gXmYy7oKU00p0H
 8eT9QJ5ZvWNbxp3QCBLAUyjub9FdcoE3zN9vsCB92TdS1E5rnYwYz6QlZyOhU8b/bq
 yK7TcA0NLw7BIGPI4z3UD8Nd68r02iu31+JfyPzmceNFwPyeMywyEIJpsrBPot4unb
 22yVCnWgk5Xjbi7q2U3gNkmwGPfkKGgvrSdcppCNfLLqg2rWA9tTBNzgeZr4lT09Tg
 H5hqGNmcl8jpw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:40 +0200
Subject: [PATCH 17/75] drm/bridge: synopsys: dw-hdmi: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-17-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BUQaxFJjoJmOV4vgmA/Dlyke9Lsh4y6qrCtqe21jNys=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrPu1Kg3Zh0XgOtjSNFqXWjCSpdlvE50FZK6SnjeZPGyovJ+
 IiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrPu1IACgkQJ1/OGaI9vnZ11gF+KUyy
 EWJ2nCSe78jwXu8h8SbxI3j8lYb22xujgUdkiN1Jjlvji0fEh8EAP5PtHMmbAYC6p9YpXzEzah9
 UXj0aEDNpKfNfZTNkKbp9Zy0jfgFTnB/NFCClbOPSmph9DyMAG/s=
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

The bridge: synopsys: dw-hdmi connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 937d61c42b58..917cf764c9c5 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2567,11 +2567,11 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
 static const struct drm_connector_funcs dw_hdmi_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = dw_hdmi_connector_detect,
 	.destroy = drm_connector_cleanup,
 	.force = dw_hdmi_connector_force,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {

-- 
2.55.0

