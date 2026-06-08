Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D90CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D49510EFC8;
	Mon,  8 Jun 2026 08:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bopm/oSi";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A052610EC3A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 02:33:01 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2c27fc587ebso564935ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 19:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780885981; x=1781490781; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j20V0GuPV7rBgGUjbhfpY7XnYJHwynd15A65eNviT9Q=;
 b=bopm/oSiqsTkbSeHr1rvjiD938wE3y0ZytcjXurXWPqsHxcE/TyIHLTSLHJQR5klQg
 sflAyHXQlpxaYocvj92bXRjBvoE2W+yKVzgglwiZYZ8r8/PXd/PDrdkF2mre5uwbJlwS
 z2IX6ma5mLh57ggvrLj+fN//FSI8+EjeMqmnkNoIQYOlUa1igkYBUWoqeBY5AQJo9pRq
 wwrvXzcRwUgZ/T3wcndN/z4WIrZVu/kB28ekqThNQ+beo7e9B3PGaVndMkqdpeML5Sb3
 JPn7Rk9miP+zB2ziZsYyiT0fAm/Nt4L+sIwAoOQW8GIe3vVodnEud767b53f7NSW2o1l
 r0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780885981; x=1781490781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j20V0GuPV7rBgGUjbhfpY7XnYJHwynd15A65eNviT9Q=;
 b=bo4RUUoefVDdepaTknfRaCVmwmVGv8Y7nEWbOZzybJQ4+IigLajXD0J6vQk5frU0lr
 DNxkzzy1vqUu78Tppfr3LR2CObg6NSq72HfvU2S32mKbGxY16ASAqACA9X4Dqt9N45hz
 1GqldCo98aSOhH2VE0B8c62IGD6qTz+DTV+ieSO5OnmLD8POMvLDi8bOOsAHNu2QO2Ie
 tK6/4sGvz4y+h+YaxPufqQ0dISwCPzZSn4xgaddRn7Y0Yl2+BmvNjYjxmgvb5f4EBfRh
 QsS+6vFNLqTdXIxE9ZVK22aa+OYP1B0gsFs3o+/f4gX4KLCSvWcH8zkM69+sP+JrV28O
 dctg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8p3n1znoG4c8lyRvlsL4xGtW/lzB8J10bI+fo78PA36236ToTsZDa2FqS41il+Dw6VVGuNssEXikw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/KQKpiaqusX5P1V0/MJu4DiV0GfWwPgSPJMn4sU774Nvn0glN
 DzMxUxhQwn3u0iezs0d4LNGRgRKhVvZWWYONTcRtKFZIdDYV6IEEXysG
X-Gm-Gg: Acq92OGj0hEz6jgFCL1OhFPyGSrVcaBTwK57EMa77nnCOa/dILAyVBfXT+SymcrJ/t0
 qg8PauLwaer+0MYo4vX6ex9+cazlFal1wuoWFSXGSu2HsKoRhRztciqnoQcr/ZJbNlqWdp0WrPW
 Yapb4faJ+ePb0NsR6SWKW5/7Leys+MuPFxQa57Jfjk5MWovK1HzQQ7kfPtiTiNGIoZ+OFhekKvK
 sN+g8Ox+7HMDNQv3Fw8z04NyRKQ1bLayOB7igPIPk/QhT6Z5fZ2oue6x8s17WpLxaZj+DcuWpKD
 xm3K6lBw6oi+bjIw5AZMuGC8yjJAhijonrU6A0Qm9kTpJ6HYXqad5/nBhVU1DRjig5sXrrX9DJS
 P/3QSeZ/jjNnqYn4F5NGUT6JzNSjUejiWZHmbfN7HhLZluxbJO0FUyH48KVLEPwIwte7FQqamqE
 /QgfB5bvdLIVxmEvSGSBy4780Ttid7EihHWl7WSas/a74zEkA/7ypjz6LIWP6/rFqEKPfkYooFo
 LUF88DdKBbBVq9s6OvKFfU=
X-Received: by 2002:a17:902:d2c6:b0:2c2:245a:3360 with SMTP id
 d9443c01a7336-2c2245a33c4mr100349275ad.6.1780885981043; 
 Sun, 07 Jun 2026 19:33:01 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c245dd3b5dsm38143485ad.81.2026.06.07.19.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 19:33:00 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v3 5/5] drm/verisilicon: add DCUltraLite chip identity to HWDB
Date: Mon,  8 Jun 2026 10:32:37 +0800
Message-ID: <20260608023237.305036-6-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608023237.305036-1-a0987203069@gmail.com>
References: <20260608023237.305036-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Jun 2026 08:58:33 +0000
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

Register the Nuvoton MA35D1 DCUltraLite chip identity in
vs_chip_identities[]:
  model      = 0x0   (DCUltraLite; Verisilicon uses 0 for this IP)
  revision   = 0x5560
  customer_id = 0x305
  generation = VSDC_GEN_DC8000
  display_count = 1
  max_cursor_size = 32

Placing this entry last makes it the gate that enables MA35D1 hardware
recognition only after all the supporting ops and DTS changes are in
place.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/gpu/drm/verisilicon/vs_hwdb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/verisilicon/vs_hwdb.c
index 91524d16f778..7d630a667a3f 100644
--- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
+++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
@@ -129,6 +129,16 @@ static struct vs_chip_identity vs_chip_identities[] = {
 		.max_cursor_size = 64,
 		.formats = &vs_formats_no_yuv444,
 	},
+	{
+		.model = 0x0,		/* DCUltraLite */
+		.revision = 0x5560,
+		.customer_id = 0x305,
+
+		.generation = VSDC_GEN_DC8000,
+		.display_count = 1,
+		.max_cursor_size = 32,
+		.formats = &vs_formats_no_yuv444,
+	},
 };
 
 int vs_fill_chip_identity(struct regmap *regs,
-- 
2.43.0

