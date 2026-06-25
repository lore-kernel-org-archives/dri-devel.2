Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE110CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 116FE10F487;
	Fri, 26 Jun 2026 07:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="do3x454C";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C89C10F1FF
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:45:19 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2c7ecaadddfso8520815ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782380718; x=1782985518; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97AWU0M7d8gQpSwlhcAT1m8L/c8BayOz7rqc48tFI0o=;
 b=do3x454CbNt8xj9ZBqVYtzbBHa6tP1KuSQTxP1MPnirShupBUiSTeGkOOfMlWr6Tll
 TphcWM532xZdJL/g9iEEZBQCL5QovpuW0O5cyuEtBz4oJm81+e8rBpmqtUk/QENyWgqw
 bzLHn7YCF4zimC+qpM77q91Mjyik5Q/qJM9b8ARbzK2Z9T/I1QR6zjQtf34Nc7vCO5+U
 ISHzbt+7YfimV8OiOJMeEXX5cdsRBYdVDDetmjKp6u4UCu2L68z6iCTRiLkMBg6wg997
 siDL5ZRvLKg5UeylteTd3dKlvWSH/UGbFzIs3DW53ZRQQZOGUpx0gJdvvd1fD2SviG4x
 e7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782380718; x=1782985518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=97AWU0M7d8gQpSwlhcAT1m8L/c8BayOz7rqc48tFI0o=;
 b=P6EO6/VWpjJq/D4nhWpgkUKdDcPsjXS5qF/o2HoUV56JgnZo+nv9X4vDZtNPShbUvz
 BBHMCdzzr8EPfOeUH0OJxkQD3C2sjUUnPybDEs45swPFIJez3+4q0GGehBKdF2ookjrz
 EHAW+m7YQ5QugsGQKBbATR4nVmseFkvEzU5hL2W7iYM3pxdlEQL4PtRI38Ewadk00K+Q
 3hu9qr0VZNF8WjT1QbGcAFBAVA2DUnY4or9jRLSJGtQdwv1RrSZksx5iCBspCLDm56fD
 NH2djYIFV5hUS6QCQmfAwpzmM7m7cDxdJJAuoInmQQVhLM7cofFAO6Ezzh+YlFvFqZvL
 0RSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RraJojG5kyIfO5WJBJcEX4anpYH+goc5VbaJl0yP3XG4qYR8FaUHXUuwmNbYoFXvWp2OIpry8S8G8I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5gbMmaBQMIRxVY8dkceXo17jkVWWDYF9y15lBUaXTramnpt0b
 lrXL9TVgTOYjjYjhuyJeXbPumX5P9AfePKOfB8r7pw3Z0tIPAEewfjxg
X-Gm-Gg: AfdE7ckCN4k0N7cxIVQILnB+5x23mcPLhQEw//VMllOR5aEGxmxuuWSmxfgMnbvxET9
 1TeMtQOOfHpWPzGj5tJPW5RfLzQ7RlEUlOloY6mmUSZWQ4wdtB9Nqe2K3Wsc3S9ho0lZe3+0zPC
 idMx19NxSvWEhh2ell5NoWg4sLTUyYxqhxsWHoVQd+ZBbDF6coqfvEawnb9qoTR4OK6YssN+6Xo
 yX2CPfyluhA3W8MA6HUn/q2YsjeIUBF9RMZnSQsKK4cnkGjUdBEpBvxq51eDu3a94XEpq/J9Lgg
 67tTVIaFDWpnC0d2Vsh6nrje2h5YIqFUpMpMpRiha9h/jR3299X58cuwLPevUnG5bCyjcJzAuxD
 yjN+xo55woWoIkKYMh6JNc/3m5tb3bnyuMv4PicpvioBEs8i5bLdbeKsAu3Chb/l053rVMXZVOG
 wCfLAar1qusL/F1OKAqvrGWELhqn/y/6zD8l3XuB9bMi6YisKX1ytRbB7ppK3Z9/w8DK5ynrFfq
 G65JukB3gxi
X-Received: by 2002:a17:902:dac7:b0:2c7:f520:45d7 with SMTP id
 d9443c01a7336-2c7fc759236mr19628235ad.31.1782380718561; 
 Thu, 25 Jun 2026 02:45:18 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8c26sm16614995ad.1.2026.06.25.02.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:45:18 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v5 6/7] drm/verisilicon: add DCUltraLite chip identity to HWDB
Date: Thu, 25 Jun 2026 17:44:48 +0800
Message-ID: <20260625094449.708386-7-a0987203069@gmail.com>
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

The Nuvoton MA35D1 chip contains a DCUltraLite display controller with
model number 0x0 (sic, the model name contains no number either),
revision 0x5560 and customer ID 0x305.  It has a similar register map
with DC8000, only one display output and only 32x32 cursor supported.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
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

