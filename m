Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC76C10AB819
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 20:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D3E10EB5F;
	Thu, 26 Mar 2026 20:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SLW3XEKj";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 341FE10EC13
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 20:10:29 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-43b7481f9d3so831981f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774555828; x=1775160628; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IZlpFAd1bDLyyk1KJZ+xsptLXG1EfpfxvxYR58kTEMk=;
 b=SLW3XEKj2Qd1Mo6Xv88xFzezGzL0ZQ3sIspTGvUaBuxPlk7qdrvhy+ElEy0fo2X6Yx
 KkhK7Z4Gh/SWHQ4fDLbfaPzx5ery0D25Pe2DUZNUCSOnICsu9XEO25B7eG+PUCi/kh5C
 N1gXqkoy9xkqva0Zdjpai/v+s6g1b81ZONJkH80RbCuU/4k9lPbyqAO5YgQvzU5JQvT5
 T1/kKoSqYr2l8Xg+okaUI7c8BYTLSsah6Nfm9zaW8XV0LvtamSVcupwqfeVG2I5qqyDk
 pI8F7R3d4g2lf+Rgv5NB3kWsB8Hce06jo4LXLb8O45AU8x0M0znyZgnSvKS9l61p2CqD
 uLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774555828; x=1775160628;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZlpFAd1bDLyyk1KJZ+xsptLXG1EfpfxvxYR58kTEMk=;
 b=icQqXfUcQdEdQNnJQoSQK/rP/Apf4cFpNFF9f7hQhloTIphmhrMHe+xO/a41Ee7152
 krObWfLILh4RUK8CAohFvWXQVAIBBV7luG8PEDjptUJtZ4oH4y+t588af3QtocdubZiy
 8+AWD3ss+zFVf9qXI24FFRNOMEqvVEhdj4FvyCKGEfgCp/fQ6fNG1KYa8U+/KrlCW/kP
 pTHNQ1DNIlaST67ACInly4J4HKBE3ylPi4G/QiR3vVhAO9y8fSO8cP3sv3Gwx2NcLwCV
 5ABej+Fai3S/sABP6iInP0G96odp6AijPFa7wH18gfPE1UP4Eov3SfH8wLQnUYA5r6TO
 RVEw==
X-Gm-Message-State: AOJu0YwKgvPptPj3NEYJWH4yKaeU9oshJA6+9Gg42cU3zLJSysTYBrsq
 AF9yuNFqLC9VKoBTZwBxYQaXjE+pfC8/8dgP/Mpxr0Vlk1Gc1tPfKAFg
X-Gm-Gg: ATEYQzx8y4nwHPABDQ59ON8I6BiXheSiIQbJyXQcpq6oTxqAU5fvb/cuMRPXmJYhZxF
 ly60vSEAjsHbMjog9nqK8DO6ZOnm+Lunp+eKcSwbw5+LJTuDvZWbxU7YZB4RVS8oa5I1Gv0RHHl
 xuBwfJJuIGYHGDLIjTJwR/Dah1s2Tyk5cBBCwB6WC3/mZyyrkvUPaaoDTxWsh982oAlqq0SyMzY
 IzwBe0TcQgxpp69lct0G3zPF0CF9I7zpEhAe5zsWR6lRMKsxWRl3nmhGRJCWVsgUJEOdwm6gD54
 dTeBKuYqUwqy4jUEBu7dLlSCVrjvvexCIQwcQSRoyGsTSC5uDqhMU0slX9vcpkiqEp4gaRSDjtJ
 PNWUDouzI/t2SpSJjW1eZl2REO50rcKGj7x7AqGC/dKkL6xQmpgJdqo3iqVm3Kyz7uk07FcWG1X
 P3mMHN7PdbzoPllIs+5yJiWlBq8BXeI2aES3u9CV7p/p4=
X-Received: by 2002:a5d:55c5:0:b0:43b:8f30:39bb with SMTP id
 ffacd0b85a97d-43b8f303a7cmr8813334f8f.24.1774555827404; 
 Thu, 26 Mar 2026 13:10:27 -0700 (PDT)
Received: from Gattout.localdomain ([90.90.41.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919e265csm10770027f8f.32.2026.03.26.13.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 13:10:26 -0700 (PDT)
From: Amin GATTOUT <amin.gattout@gmail.com>
Date: Thu, 26 Mar 2026 21:10:15 +0100
Subject: [PATCH] drm/rcar-du: Convert to of_drm_find_and_get_bridge()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-bridge-v1-1-c0c44b53f7b6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKaSxWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMz3aSizBSgqIlxanJSapplirFlmhJQcUFRalpmBdig6NjaWgBFnDL
 LWAAAAA==
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Amin GATTOUT <amin.gattout@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774555826; l=1018;
 i=amin.gattout@gmail.com; s=20260326; h=from:subject:message-id;
 bh=wVpCKFixwVvIFTAExhaQlW8sEoNllF0+EqWgRpRXDjM=;
 b=NOKuhLSsAxhcL7CZTAmS43VqHadaUFxCot50JKLhaF/LiRNsS4QcEfHbcCYKI6z/LSfPXY+oo
 QGuxg8H3aALAtJWx74ppTozTdm+121TGPzcE2tPYIMjI9MWPEAQLVpP
X-Developer-Key: i=amin.gattout@gmail.com; a=ed25519;
 pk=BnWtaSL6rBEMWInyLFWt97n6yImdAKsf/0S5K7jcwQI=
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

of_drm_find_bridge() is deprecated.
Replace it with of_drm_find_and_get_bridge() which increments
the bridge refcount as required.

Signed-off-by: Amin GATTOUT <amin.gattout@gmail.com>
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
index 7ecec7b04a8d..42253c1251b5 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
@@ -72,7 +72,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 		if (IS_ERR(bridge))
 			return PTR_ERR(bridge);
 	} else {
-		bridge = of_drm_find_bridge(enc_node);
+		bridge = of_drm_find_and_get_bridge(enc_node);
 		if (!bridge)
 			return -EPROBE_DEFER;
 

---
base-commit: d813f421930c5b01b9f61043932de02602dd6ae3
change-id: 20260326-bridge-43ecbef9d39f

Best regards,
-- 
Amin GATTOUT <amin.gattout@gmail.com>

