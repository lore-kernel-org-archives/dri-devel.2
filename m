Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681C5C79FB8
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD5510EF0D;
	Wed,  9 Sep 2026 06:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jWIBklhE";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82F810EAE6
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:29:10 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-39675172593so3470154a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788859750; x=1789464550; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0r+H74wyT2+5oikV/msCZxyt9ampGlRBgpuDqDj2ToI=;
 b=jWIBklhECyHioSIesnXcqMy/LPEtJKklt6gIV/Xp5d6rIz8CiA344UwfDZRYtEyGpq
 Fofr3xe50q90T4yllstyleK3eDCYgJtgLupH1pbFsSIVL7J4zthTJF0DWMXpS7/TIUgt
 ZWBdvsE3mzjvo7yLB8Wo9aOKOH/diGuyyQpnQLdlxtfoG+zzSY8Fug0BWP4KeIa4orXg
 CHT9+VpKIAsjyzavxrwMBUPBYyXNxBE3Jfq2vmXzZrYpCTpMm/zqDP0eLQppgytBvtvC
 llCjXs29J7RCkrdeq88nRHcHALk7l/+zAAxSq6HGnedcrp3PRXgXAJ6qDopfADs9tFaw
 EIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788859750; x=1789464550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0r+H74wyT2+5oikV/msCZxyt9ampGlRBgpuDqDj2ToI=;
 b=edXlHEhSNfHfBmU1J+MbROkAJvmbvHwt1j3G9+smACPv2jiSjuoE4cA7yUTdhi3YWF
 /bi0c9jGzlJvwix+9XELGDaaS1+yS1kpd3YIy0LR+Sy+mxBYNm/dqyq7T45biZmQ5V3h
 yHeHsH48zN8h7RK16eUyyQY+fU+M7cu6jhFPnJEJGEZvP7Ko3JrVt5hCWz2JJN7mTfCG
 w2qU44kuhdNml6N9XaUywZ3+Ly1UjEERisizopqS476d7IhCx/BuylNRw3pUeyyZ3dDY
 uGKAal6DUX5oMfDtf47zwLBNczVXfxsmSBel0DvIjqo/Kb4JQeN5w2t1pg8UXLdUi9RG
 CGjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoCRv37yyXgM2388Hbb1AZYN9/yOu72UjQ2TmNEuiIXNA6Cv1FBkCg9LJdI683Oe61mu3UUMqXcU8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mZdN1Wc5gHfGnNtyWyMtULDeoLlC+mw2fBPUaiq4eJTyS5BsUs
 MbyMZ0L4d1e0LGrpEPR3VEGvCtVleXwLfrqa3d47FkW1RLRZbuVaCCW1
X-Gm-Gg: AYBFou0z1BZBmFIFa8h4tLLNMtqb6PdLESehPGV85M4bWR6lLBid/wH+IkhveF9Ilwm
 32IFyI/q1chywhHvW6ENqlG1H4sBp8TCkDTXm7KJFpJMLO2GBB+w08POdAV2Kic3q1UZf9j9fbR
 TXFELASX5iWz7fmi6CYwTbEY+KAJGOeUICO0Spxo2gRBLh3z3X7fm7VrF/0CgRWTisS3d13buOz
 Knep3pmTIZHx09uRANYPIIWCfQW8OCEpDqin8HU2YiY/oVCVkSvNQWch4BEyCgoedcOQs43iJbO
 nr5UCabQB8vO+Xotx80AZofzRKWIN0Bwq3wwOl6MO6m7nUk3Chm19AlsGwh11I7vaHpNdgGSgvG
 MhpebIPw3+2+Exa6o5+ApZWsV5VvONPGP/XkhrbA/+7XQpc53BcxxLvqstayNoAgRpP21ckxmcL
 HhWZfbWMxpfkXR3nGJKYVFv0YcYUjjez83OsZQMi/+sqt8vYryxa+tQxERd4R6pugDXrIIuwJ53
 TDwGPDq28dLiUJdQq9jqK377s6kcR6CatP8FlkWbA2oYx2N9q89
X-Received: by 2002:a17:90a:d644:b0:398:9c00:29ec with SMTP id
 98e67ed59e1d1-39b26245cfcmr43975973a91.20.1788859750448; 
 Tue, 08 Sep 2026 02:29:10 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c39227sm32109846a91.9.2026.09.08.02.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:29:09 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v6 6/6] drm/verisilicon: extend Kconfig to support ARCH_MA35
 platforms
Date: Tue,  8 Sep 2026 17:28:40 +0800
Message-ID: <20260908092840.225220-7-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908092840.225220-1-a0987203069@gmail.com>
References: <20260908092840.225220-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

Add ARCH_MA35 to the platform dependencies to allow the driver to be
built for Nuvoton MA35D1.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/verisilicon/Kconfig b/drivers/gpu/drm/verisilicon/Kconfig
index 7cce86ec8603c..295d246eb4b40 100644
--- a/drivers/gpu/drm/verisilicon/Kconfig
+++ b/drivers/gpu/drm/verisilicon/Kconfig
@@ -2,7 +2,7 @@
 config DRM_VERISILICON_DC
 	tristate "DRM Support for Verisilicon DC-series display controllers"
 	depends on DRM && COMMON_CLK
-	depends on RISCV || COMPILE_TEST
+	depends on RISCV || ARCH_MA35 || COMPILE_TEST
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_CLIENT_SELECTION
 	select DRM_DISPLAY_HELPER
-- 
2.43.0

