Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBEDCDE016
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF7710F4A9;
	Fri, 26 Jun 2026 07:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WLmzjG4o";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE48110F1FF
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:45:11 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2c7f11150cfso7004515ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782380711; x=1782985511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3I9Z8wqgofyuO3+w6/YgxBgJq5JW6cTK82PfLZ4BPc=;
 b=WLmzjG4ovA6R0p66czdE6h+dSuXa5KC7YZRwrLIolHNLr35BY7f92DCRObIuj0R6GU
 SKRrYGrxGj14w7Cp3PSGJ0038R7yLqvK3ZeyyDGgELB3BoY5FoeU5BGD9F4qfztoKDjR
 YpUPJwaew59FHL7kMUeac8ni2DuKVJYKjXWWEY0zALGsmDvFuq39NqSvkI+xoYFSRM7D
 5yqeMc7fIAsWmRrl21STI1GePuL9MVU0HugdR8eZCpmFHfNj8jbgTlU/TXe8mmHs9C5e
 fkthxfYS7G6ldRDSDU0A3P9OQYA2lqt40b8PAyk4A98eN5rKgsomQw3HI22hFo/fvZsN
 r/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782380711; x=1782985511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z3I9Z8wqgofyuO3+w6/YgxBgJq5JW6cTK82PfLZ4BPc=;
 b=TowuM5wm4bGwrIlbpagN8S1l7Z9GfDV2X9ffOqcrQ2SmaV9c++zg9cADFR1dKNB8e5
 tgoDFcS9aAqFJiT+cmrDM5HpMEsv8Isygzfgqj/Rf4on2d0S06vKnoprqxTV/A5ETLw3
 a+zLLTLhd1TVS2heegYrk0/WrIGxHfbxav43ZGU26IxRTN88hXbTVbIb/wRhqXVhodwB
 t0SPWBpH8UIcvHnlSnim+5geBhL9wBMNxHS3RajvOIUL4QmLdHnN+T6c8eWEzipxpQAu
 xoOlQkO9ni+kE1k0awdKEbbS+LhlIMU0VDfgkql3+42BkrQCWhw8ghQS7uNF9bjEYWtj
 6gnw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGYIVnmHHHNgzzv8ixdj+yQq4Rgq/Q8emH7R7LiiJWFzzhTFMG00dbnEOsNmacQMQ/jrOItWhrYGE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwegqQVTOOQIVsXmWn9DBSwYzfqlw5vc37b1ZiId+ZZzvilcEG3
 y0eYjhcwA6fx1tiB9RITvn7RdCPa5e9i+2ELtzPw409FeTBcwGH2ocz7
X-Gm-Gg: AfdE7cn1+7COUz/YAyqCKRtCMDhwpmFGBSOxlZiltie09hkMs59RbYATRZxy0AKMIQ5
 9UVAnbyHqm63aK4/fiFYL4+S2J3iBU585i2l6gQtUxoRFtG1kYhUuIaIZfFiRaTo5uyci18llkU
 Wo9hVpKKAbKadcqkCy3aJaTYF85JOZ3Und9rDBofMZHD3q2Ya1G3NelKCfr6/INymiNpKz3D98j
 58jHf5G6dkvfhpTjE3LvzA3xE377zdz2uaBK6fjLwaiG+aOwBv6ZbvkoGG+/jjy/ZY+Qqnk3a1K
 bxCTW6oxsuH0FWrIJc/DCK2jpDMHD8z1dFYy4XpZt5snxyzpBZeKV7Pqp8+p+C91jgzHvQAWdeM
 iHSM2t3SoPWO5pgDvBZ0TMZaG8DzgEC7Wt/dPWUGPxA7/azkXCZJ5lZEvFyPQPkQFI/WWMgQaXD
 JII9YA8gUDSGvjwWu35ocrZ99kRqvymE+HRR+rvCBC3WVy/i9W6CmYCyWGKBDNosz1TU8o3mLr2
 w==
X-Received: by 2002:a17:902:d4ce:b0:2c0:a746:7b16 with SMTP id
 d9443c01a7336-2c7fc73b753mr20074445ad.22.1782380711366; 
 Thu, 25 Jun 2026 02:45:11 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8c26sm16614995ad.1.2026.06.25.02.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:45:10 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v5 4/7] drm/verisilicon: make axi and ahb clocks optional
Date: Thu, 25 Jun 2026 17:44:46 +0800
Message-ID: <20260625094449.708386-5-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625094449.708386-1-a0987203069@gmail.com>
References: <20260625094449.708386-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

The Nuvoton MA35D1 SoC integrates a DCUltraLite display controller whose
AXI and AHB bus clocks share a single gate enable bit with the display
core clock, so the clock driver does not expose them separately. This
patch makes the axi and ahb clocks optional in the probe.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/gpu/drm/verisilicon/vs_dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisilicon/vs_dc.c
index 9729b693d360..fd1f5fe67a68 100644
--- a/drivers/gpu/drm/verisilicon/vs_dc.c
+++ b/drivers/gpu/drm/verisilicon/vs_dc.c
@@ -90,13 +90,13 @@ static int vs_dc_probe(struct platform_device *pdev)
 		return PTR_ERR(dc->core_clk);
 	}
 
-	dc->axi_clk = devm_clk_get_enabled(dev, "axi");
+	dc->axi_clk = devm_clk_get_optional_enabled(dev, "axi");
 	if (IS_ERR(dc->axi_clk)) {
 		dev_err(dev, "can't get axi clock\n");
 		return PTR_ERR(dc->axi_clk);
 	}
 
-	dc->ahb_clk = devm_clk_get_enabled(dev, "ahb");
+	dc->ahb_clk = devm_clk_get_optional_enabled(dev, "ahb");
 	if (IS_ERR(dc->ahb_clk)) {
 		dev_err(dev, "can't get ahb clock\n");
 		return PTR_ERR(dc->ahb_clk);
-- 
2.43.0

