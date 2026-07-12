Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA9EC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 00:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0421910E3D3;
	Sun, 12 Jul 2026 00:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ULkA6Q7U";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35DB10E3D3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 00:15:18 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4759b4f0897so1082064f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 17:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783815317; x=1784420117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KO+WnRSeMDTSFcDex1uY+8/F27tPzHGIoy4i1Dc52M4=;
 b=ULkA6Q7U24FMjnursMLo5nfgYEqYN6fJ0NbzUtMMs58L65j3UTK/G9MwiAC9itbRQn
 eNQut65t2/RbWeuN3uQ7CiitoO3Cyf4JjtnAvxUw7S6TxzP1RuCVlPDFpM/tVrSrPVkq
 uwyZUfjyGkkRn7l2+NIdFUp1AMLUhG7Cl18iGHQO0+B8Saewa6y5C9ZDhVr64tjvQZUP
 mwcviAfVISibAOKKFWQgAFXlBMm/5U95b4heQXO9q2mTBS1O7gmQjsml0skcyEo8eXx8
 ylmUpM+xPBAoAdMP1F1/Vl9obqWzfvyS/Z4+d1kLonSiY96EI5t8Zq2Tk+wTrLWuA2DF
 Nz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783815317; x=1784420117;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KO+WnRSeMDTSFcDex1uY+8/F27tPzHGIoy4i1Dc52M4=;
 b=Vq+EVSXey3jXqz/+XnNJnn4FpWSwxItWg5WIw7eWYlaJX+3n8gvFM+omcL+JqXtiEw
 WXYpukLXvoXcW9+AuQ1jT6l5onoXJbcGgqbaq9rcgqWZ0g8/nShh6KUUYutknaHunDKo
 PO9gSfNOelXZFXGRoi9+GaNxaQjtBCs6KdLZS8x9HpIpgCLF30J1n+Ryc45T5fO92JIc
 hQDF53fDpeAST1gNXr8yUmmgW+nG7t4fDCXFG7vwyxfTt8qxt5Z16/rOvUf2h1o2BpUu
 w6PpFkde/uE6dK+iEom5i6fbjLMHs6x57Kq5GNCnTaEUaxcK03FuUlLCvSwez0cJrK9d
 p8IA==
X-Forwarded-Encrypted: i=1;
 AHgh+RozpvhoWK4QoZoc518ekFZ0FsrTk6AdmnZTw2e5Ou7vqUOoXyIExmwD+tjo/avICw4FjvycNbkIKUU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcgEcvhoWOrgsfxU0syWtvx8k6i3H2VXiw2yGR9S+05p80nMin
 vf57HwZG0TmpKd27LWseneWr2JckCbEFIdkQKXvs+3u5LzuCC3VWRb1k
X-Gm-Gg: AfdE7ck5M+nbPsLDskjqwDTSo5GQOJyCwSk6Z4JBtVtX0ahhPVAMT1WInVF1oWn80eN
 LTw521yC3FccJgQ04h5u+hHz7qf7uRfHlwuIrizCgDMCOvfZnbCOaMWw6aEDElY70uBlaYmfPfW
 pa6Wp/h1ymu546HzESi07w3AXh9vwheAgrErCnc0S93g9rmtCOYeMFykyvFKPU1fRAGjPkJDC7M
 7+cpH/5Y7ZgjB907qR0vlnh5m8zsg07WKnT4E7vLftwmfrozqdBrUv4FLNKnmScw8SyeLe2pfN7
 +LKwRtmj43K+esPT7N6JwWmxSCc7wNf2SU7Q9uGuw9fvCXQ54LBsR5h2Fjc4lGMchp6bLsma7mw
 gEyg08jKYaruj7w6KfoEft1NbHF2SqrPthvwP5gQEEyPImLzPp0lIrOEvtFjIU+Ga7pkfNIcai4
 SeaFR9xbBumPUx/ElZ45wqrrhBOAFLmVLqroBFcxJQ/6RUqn2e5ARCUrcPtrXaaNDmom/cPlgDq
 MjQt63o/Xu8t0E=
X-Received: by 2002:a05:6000:2404:b0:475:f0f0:9ed0 with SMTP id
 ffacd0b85a97d-47f2dcf97e4mr4540494f8f.59.1783815317033; 
 Sat, 11 Jul 2026 17:15:17 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d905sm74818683f8f.2.2026.07.11.17.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 17:15:16 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: jesszhan0024@gmail.com, arnd@arndb.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] drm/panel: s6e3ha8: fix unmet dependency on DRM_DISPLAY_HELPER
Date: Sun, 12 Jul 2026 01:15:14 +0100
Message-ID: <20260712001514.2318597-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Currently, DRM_PANEL_SAMSUNG_S6E3HA8 selects DRM_DISPLAY_DSC_HELPER
without ensuring its dependency, DRM_DISPLAY_HELPER, is enabled,
causing an unmet dependency.

Let's select DRM_DISPLAY_HELPER as other similar options do.

This unmet dependency bug was found by kconfirm, a static analysis tool
for Kconfig.

Fixes: fd3b2c5f40a1 ("drm/panel: s6e3ha8: select CONFIG_DRM_DISPLAY_DSC_HELPER")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 103f1d09a989..ecff57ceeef1 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -1010,6 +1010,7 @@ config DRM_PANEL_SAMSUNG_S6E3HA8
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_HELPER
 	select DRM_DISPLAY_DSC_HELPER
 	help
 	  Say Y or M here if you want to enable support for the
-- 
2.54.0

