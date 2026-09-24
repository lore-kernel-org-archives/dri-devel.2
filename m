Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888BFC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F9310E08C;
	Thu, 24 Sep 2026 19:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CUSP9Kih";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C71110E08C
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 19:55:37 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so2162335e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790279735; x=1790884535; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=enCFhbXwk6dv8V+Qy1/Wb32GY2e39ckcjINn4OP9c1c=;
 b=CUSP9Kih8ja8BpqGbOkxV98jel7ThMrPpxIDAm97Dz1QZxbz4J95ji4wUZnmhpACo/
 kCpncdaQtjYEjyUFZJEzoCa339Kl/Ya+STfAgLemJx42PkmJP3G6KhCL8vQkYXUhZRQJ
 sgqUNN3iWnd6BjzFl8DRB3h/tCOESk/sesCduL0/DTCTymeQ8pAgEzmzus+oAua95KWA
 uslrSudPITDUgqSXj6Byou5LUzX+BBgys6mys2K+zRgEN0z2GccWlcIbfUcJnhITF/yq
 4WxgEtCFSeMVMQRB5rKlzEiMCOeZdk7FIFVbq7IAJ1ZfeIpr9BPjm4Kn7k+H+K+ktakh
 Vd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279735; x=1790884535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=enCFhbXwk6dv8V+Qy1/Wb32GY2e39ckcjINn4OP9c1c=;
 b=zZErpyQe/wKe+x/9szh/nFkJA4GEY8ZbJC90HP/SX3MtcCH1S4nxNK16pet31yrYqO
 bjjpBDp7s9sfwuYg3O4vDk1lXdMMRqyCYvdhD61aMrV4bO120Uooupzz/qmDTROqvfPs
 aSx9xsZ6pgfIGdyj1E6J4yMRclN7QmxPQeCEMtxKVs+9yW7vM/TrJxoB5oVk6lGmQTTx
 A3+tC5ea5haqYtQlW9v4Syc/0bIUDNHI69SxgCjfEkYmJ9BZA7VYcfI14xHbP+9Re3UA
 Vlb9Sk2tQUfscgiTYQ8pzQ83tYNFnby/GQhIQGEgBuXz7JLDGkQiy3rD4b+/pDjKPNqu
 EhLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsY9dIG3TFAVbIGW4gAstqYsOidPObSH4LSNXMUh9ANkvfKOplIjoUQ8tXyzTyCOF9D4x9iFBVlog=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lyBnlxfSxZt8sNaLge3DpVNXl17vMKDv+ht358pyYGox+OkNct
 p1dgZLPYANNEdMidVmfQd0ybeYBsCkZAGWNHxoXzsDBGrqGO8qaaQjOK
X-Gm-Gg: AYBFou0p+A9VAh+4V8SVPnh/esxe4KkOq1qXcvOLRgvjcaKm/+1g3s5IHbivziwJNPa
 FpVIOLGnpsk5VZYFvLeHx1bqCDB09GxFgXRGQv/SSvkF+FQJR36U0W/K+S1I4PJo7QZNwJ1YwAj
 VWs+c/JqVASGLQ4aIou4hfKiz+H8i3SVndATufwDCsPxNwT/LsBuXlUcXNfDsA0f4lTZm8WMy/P
 dQbZftVng1kqvjpAMdpO+Z2iLLRGUuWezYFlD7z6h7+rRVyk8ANh5/9889/RfQvk4DGpbJ7bAid
 BR3k6GIOKIg4x8m2EmsnL5S2Rx3uyLPXT4W0d3YtYAs76lSZWsA/DDRgPd3yeZEbceYcle8aGuq
 9pCVQJ254e5w8b0rjpLWoHe6M+OWEmKJJWeMuCm641dShe0ewQLT5aTHDCDiOQpbtSC5Cg0S4Xh
 Oyckkmu8W1CdZQhM1tJGTPBvON5IcATcUXDxjy7Wk83cTKR1aKtaAVn9QD+LogFYuEsTTidtARQ
 eUQUdAmsJprYILRC3KP9KRkW2M7+o5Drfepq1RL9UHm8UzD6A+v
X-Received: by 2002:a05:600c:6290:b0:49e:799a:8969 with SMTP id
 5b1f17b1804b1-49fe6707bb7mr68120475e9.30.1790279735177; 
 Thu, 24 Sep 2026 12:55:35 -0700 (PDT)
Received: from fedora ([202.47.63.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff06cbd2dsm1277235e9.12.2026.09.24.12.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:55:34 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] drm/panel: tdo-tl070wsh30: Remove panel on attach failure
Date: Fri, 25 Sep 2026 00:55:12 +0500
Message-ID: <20260924195512.336690-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <message-id-of-your-v1-email>
References: <message-id-of-your-v1-email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

tdo_tl070wsh30_panel_add() calls drm_panel_add() to link the panel
into the global panel_list before tdo_tl070wsh30_panel_probe() calls
mipi_dsi_attach(). The panel object itself is allocated with
devm_drm_panel_alloc(), which only arranges for an automatic
drm_panel_put() (via devm_add_action_or_reset()) when the DSI device
is torn down; unlike devm_drm_panel_add(), it does not call
drm_panel_remove() for you.

If mipi_dsi_attach() fails, probe() returns the error directly:

        return mipi_dsi_attach(dsi);

Once probe() returns an error, the driver core releases devres
resources for the device, which drops the allocation's own
reference. But drm_panel_add() had already taken its own reference
and linked panel->list into the global panel_list, and nothing
undoes that. The panel is left registered in panel_list pointing at
a device that failed to bind, where it can still be found and
dereferenced by later lookups/iterations such as
of_drm_find_panel() or find_panel_by_fwnode().

Switch to devm_mipi_dsi_attach() so mipi_dsi_detach() is handled
automatically on unbind and tdo_tl070wsh30_panel_remove() no longer
needs the manual call. It still returns directly on failure without
touching panel_list, so drm_panel_remove() stays on that path.

Fixes: cf40c6600592 ("drm: panel: add TDO tl070wsh30 panel driver")
Cc: stable@vger.kernel.org
Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v2:
- Switch to devm_mipi_dsi_attach(), as suggested by Neil. Drop the
  now-redundant mipi_dsi_detach() call from remove().
- Keep drm_panel_remove() on the attach failure path, since
  devm_mipi_dsi_attach() doesn't touch panel_list on its own.

 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index fa961abdd2d7..ea59d4993ff5 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -179,17 +179,16 @@ static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	return mipi_dsi_attach(dsi);
+	err = devm_mipi_dsi_attach(&dsi->dev, dsi);
+	if (err < 0)
+		drm_panel_remove(&tdo_tl070wsh30->base);
+
+	return err;
 }
 
 static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
 {
 	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
-	int err;
-
-	err = mipi_dsi_detach(dsi);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
 
 	drm_panel_remove(&tdo_tl070wsh30->base);
 }
--
2.55.0
