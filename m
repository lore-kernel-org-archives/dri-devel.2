Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68501FED3F2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C6A10F662;
	Fri, 24 Apr 2026 17:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P7b43wbM";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E25FF10E3CB
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:59:43 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so32356165ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 04:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777031983; x=1777636783; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QNk5Ee0nueO8NOVwzsWGTQAVezpG2J9JCi8Bol9c8Is=;
 b=P7b43wbM0z/pgDDE/E9LolF6iVBCQG5trjtXJMYbtL8c6OxQM8xp8OdSU2jsMCj5p5
 BmMDD6LjMKGbpKXoXblX//Z7FS91VnBjUyyCmZZqZ6AZB7FJwrDXOV0PV0f1oNjvj2ri
 kAcfwtwpBByB28E0wS1rwLBZ6yf6NDCreZh8mhF1yNbYWFN5EYJ2yAr1lopaFb9MYQVX
 2vj3npC9sEiwyO2yC0+bXcYTPwZciQUmsV6uuZ8W1/rBx8ayPrY/7Zw3SBp+u0ubCXqG
 6S/PPQ2TazswMEH+B+4TSv5vU6XleCGF9Lyq/AOOwjZM1qhDQDiQrnxAdD+GHi35y3wP
 oLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777031983; x=1777636783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNk5Ee0nueO8NOVwzsWGTQAVezpG2J9JCi8Bol9c8Is=;
 b=RMtIlZBRbFVf77JJDV6XcKjE6joLvQkaCiLnchRNixQGYKzkHoCIdvvEQsR8/3FmwF
 d8QGF49a7fwVqwbvhV8268Wbww0/WaDx2C0C5kDIa0zBBklgQQWfnk7xlF977Vg8le8X
 WF1BZ/SXvqb8wXV/9c+h90apLJQFs4iGqlMXDUZnCdTVkJ8hEQIUimdUjLPNLYlHsRZX
 HObhkaM/0HJ3xb4IQ5n9Bnfz8LqR0VEhOv7VWDZgu/05qhMl1t1VCRLeOq4qOrTVxyba
 POM1htIJysUnfcll4SP9JVnSSlqsGUqbbddIKxPmlmv6PRiNVuHkabEFAylALMhPXCay
 I05Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4CphLTMokobdLDqcG3Js2qmqm9zT/0/GTRIihZ9x4N+4hMVzBgPgab+W5TcX4ewDYluszZOAWDV4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxshpR756wBtJKG9CkrgtG2Y5l9FnV9x/6RDeEeku8kBM6xNZf1
 R++eHZtbCI5ue9fLbGiY/hBqfgDpTFHBbnWrwJGYCcaxmHieG73ceNo=
X-Gm-Gg: AeBDieuMYMn/J5oJ+e4WCcZJ4tA/GIeOYUx3ywv6PrBohM4iggbSlEKhgt0hlvbF/fp
 bUx851WIwSyvgJApbvt4MqbSn2OnSM4sfeOYaRR7CoSY7S5+nF/FpxUDgWULdRJy/C7e3D5qhrS
 wS0Unf57DtY/vgnRfmgYmDTcSBvyP8x2yhSmRwWkGvPdvnaMutHlgjMBeWvYs9g+CB5H/FnvlZh
 OkTQG1l455KUI7pwn3Z9n/rdcoKOlLE9Ieh2W2BAXvhxBKnrgi+tFLFAbvB5UisJkGXB+oT+bJm
 xeinG/WEQIrZStHGzYslgMo91FMKU/dNlpYMCTKoQvLyIHb38LwxXi1EURnmubS2+reIpLT3gGR
 uILKUMr3oUl2C9QRstlykQxYkKbr/L896PtjT51JwB3Apy/Z6JaBlDe7pjEF8zBMGGOtrt5zQW0
 XG1nGsrulUtrgPqRDvc67Tr8ElRsKt114nEU8G/Q/rl3aWhl1sIRYKeHcGN8sBe00Y0ygGuQQyw
 p8sSU/CjeFC2t+39i8i
X-Received: by 2002:a17:902:6905:b0:2b2:49a7:a5bd with SMTP id
 d9443c01a7336-2b5f9e770c5mr229435215ad.1.1777031983329; 
 Fri, 24 Apr 2026 04:59:43 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff90dsm222858185ad.11.2026.04.24.04.59.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 04:59:42 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] drm/renesas: rz-du: Fix MIPI DSI host leak on probe failure
Date: Fri, 24 Apr 2026 20:59:00 +0900
Message-ID: <20260424115936.7930-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

rzg2l_mipi_dsi_probe() registers the MIPI DSI host before allocating the
DCS buffer. If dma_alloc_coherent() fails, probe returns -ENOMEM directly
and leaves the host registered.

The remove callback unregisters the host, but remove is only called after
a successful probe. Add a local unwind path that unregisters the host
before disabling runtime PM on the DCS buffer allocation failure path.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 29f2b7d24f..309fae1459 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -1476,14 +1476,19 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 
 	dsi->dcs_buf_virt = dma_alloc_coherent(dsi->host.dev, RZG2L_DCS_BUF_SIZE,
 					       &dsi->dcs_buf_phys, GFP_KERNEL);
-	if (!dsi->dcs_buf_virt)
-		return -ENOMEM;
+	if (!dsi->dcs_buf_virt) {
+		ret = -ENOMEM;
+		goto err_host_unregister;
+	}
 
 	return 0;
 
 err_phy:
 	dsi->info->dphy_exit(dsi);
 	pm_runtime_put(dsi->dev);
+	goto err_pm_disable;
+err_host_unregister:
+	mipi_dsi_host_unregister(&dsi->host);
 err_pm_disable:
 	pm_runtime_disable(dsi->dev);
 	return ret;
-- 
