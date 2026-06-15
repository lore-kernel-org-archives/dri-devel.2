Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A596ECD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A6910E21B;
	Mon, 15 Jun 2026 07:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Idg6KJh7";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C521C10E200
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:50:29 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-304ec41197bso3267420eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 23:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781506229; x=1782111029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7XA/vKBHH8dmFPLF0CvhcWERh05nFE3P6i58kyZClA=;
 b=Idg6KJh7C/nBZQrmxn3Aap/p28YaVhKgFIfHzfN7m3Tg1vqI2mTYjC/ORQJcEGpj8W
 9aPiSL6/vAuDj5smuwHishq/QU7ij1lJpm/YpBq71/f+Y+Cynm9izB0uz57wlMqVzAJC
 XCx4ZVSr/RI1g84qecs57msQLr9L2awZstSHhkGAhQ8swP0CYtL/TVwwNt3M2uJUBbJM
 KRxyimsOR4B9Hmd9P07rR3zEABvrEkT/Yr4oh5poePKJmdnBT+knfwtgPXs6KXBTGTdE
 aNBlTi8zTJpRzR+PftYu/GFvngGFlQSpET52YNsMqLc/Gr/1/e4FHsbN11hxJvvx/MYY
 SzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506229; x=1782111029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C7XA/vKBHH8dmFPLF0CvhcWERh05nFE3P6i58kyZClA=;
 b=IFwiR1a3+b0c/hff8PPmgFe5VQVcKvVbDuNvX6lJ4WkpxSNGvhufIfk/XNvWP5Oe6O
 8vzXi1H/tumhEleEDFJJPc/El7o1k5+8UwBdiu7Vgzw7bHAlDKAp/1Yfg4AxIH+fmaH1
 xB/HdBRNEJvOSLtcpco67WtSPTSiSIAukBKysksfLDoBnmkSlAdhoDLtBfi0a/jlYv6h
 Np+FGMDYqpkW09n+Yi721mFuIAkA177Dc5Z0Q+E6xEfd693iqYU84/GwC7eiArhBK9Se
 3qeYjFKiA5d/JWQJ4VFXYisNYzt2/MP2Eg++F7N+S0bTUK+U9fBewhZoD4G2y1QHl7BE
 bAJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/sk4IiiX/15V2OTCHAqEdGCbiFWWlbSsdElJYbanxIq+z79xZoF/I131xOTYyorba2iDpL9F6aAjA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUJbdTkxeu94JrGCzUEdpMiQOZhTOW/b7PbtYm4SJ296QwgjqM
 bLEkwzVYdOVZk82ZMxPBks/nIDjqn2Vr9ZS+elxRiLcmA/EhzEau+U6k
X-Gm-Gg: Acq92OGxGJGtgl7+AWJC3OBv2lMwBvJnwuYiIgmYQpjRKulQY6LPvQ6toZMNOP9bX5Q
 fKd/3NO3XtVflPeBeNaB+0adPDQmI70nwMl6QU4CqVn709eidxZZXwu6TTxXi0NeiJ4LU1fDeLC
 K4hOzC8xNVaRVCp2cH5MLWfIyNvkgEUeqLqjhUt3XWxrQT0G0minpdsfMFwL8kfEWQDfq+keK7A
 BqWpgz/szsfx1PzPwdop42Fidte3mCQ6w2y4dflYWRbJvNcZYxONhTaG3waEqKOUWkEW2gjlAAC
 P8HFIFD3CVDOFyXVnVxdaX3RNOniWzAVyk3Coeqln7lkJc/1Y/vgvY9Q5po9m75Cp0NtDAksCyn
 HWqGknNWJ1Aur19fnrICqaKmF4UmCIf/TuB0tK5X2QoqovJToF8B4XxOFGTM5uZOo9JglGqXjb7
 64xkSHD2bdwCkUdQAbIqtFKz4zHytuAD7/TZpmzuPkPPLd1Do5sm337Qj40I3ZANG2hGLkeE7Ya
 aOfBvAIyDsA
X-Received: by 2002:a05:7300:6426:b0:2da:1874:f3bd with SMTP id
 5a478bee46e88-3082004a336mr6289586eec.16.1781506229088; 
 Sun, 14 Jun 2026 23:50:29 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb9a2e7sm13516812eec.30.2026.06.14.23.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 23:50:28 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v4 5/6] drm/verisilicon: add DCUltraLite chip identity to HWDB
Date: Mon, 15 Jun 2026 14:50:02 +0800
Message-ID: <20260615065003.76661-6-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615065003.76661-1-a0987203069@gmail.com>
References: <20260615065003.76661-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Jun 2026 07:58:00 +0000
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
  model       = 0x0   (DCUltraLite; Verisilicon uses 0 for this IP)
  revision    = 0x5560
  customer_id = 0x305
  generation  = VSDC_GEN_DC8000
  display_count = 1
  max_cursor_size = 32

Placing this entry last makes it the gate that enables MA35D1 hardware
recognition only after all the supporting ops and DT binding changes are
in place.

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

