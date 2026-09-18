Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F881C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D19010F00A;
	Fri, 18 Sep 2026 07:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WmZMoIxj";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4D610F147
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:01:55 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso204786a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789700515; x=1790305315; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0r+H74wyT2+5oikV/msCZxyt9ampGlRBgpuDqDj2ToI=;
 b=WmZMoIxjm68POlp9nECgZLn7jrVWhsQNJxZNIQSDK1yAnsqVQxLZbBvVW/ojOYAkRE
 Avyc6KxAxQ31rJiK8X0SvqFbz71aNHbyGrwkscRM+g9Tncty+qc/lcFB+J5ToemAUkfG
 wF8/Pi2cyMGj4K1ZrwjjgwFbqD8bUlg4tP8QZ3PdlvjnsBU8zurJhlUtqCCw5FsbQTgq
 KoO6yRp0mvBaBKOR+L48IPAvlkFJUXvNMr522y5OnbLboIZrb0ZoZz0Du1EGzu+b1Ovn
 AcCJSbdNre8odx228huxesceqnBVBQ4h6WvvA/NZrWfYKcaHENnhCrSifVirXJj7rNpH
 zydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789700515; x=1790305315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0r+H74wyT2+5oikV/msCZxyt9ampGlRBgpuDqDj2ToI=;
 b=geya9JILCaNJmY9V7B6DbstVWCu6Kj5TO/r5kqsa/GwdeYNQtTp6mLJD/hcBcE6GMc
 4J5v7oucyYax+5Oqp03REBxwNv7U2diAh/qh5uLBklCPdqcZ9huL9J3n59NDa/Q2758i
 R/Gc4XxWgNYuXuswXAJlTdE8qD9yEns7eahPEAIV20xGCK+n+t403CWThTL/ug5ssMxP
 gpeQWMSXOOtjKgcUbHA294VNbRm+LgjOkK6M/zvQOLosDdzXR+q/rAx6PU2qQ+W/GWzo
 rQR9FeaEvNbkYgATt8R4Iy6nmje1y1YnqIki7cpiMOqY7gFP8gAxEO8YYyyrvfsQIbMu
 HOlg==
X-Forwarded-Encrypted: i=1;
 AKwUvByapLutaSsdCGA7THtZfyjeDN5FUPycgUaZsicJxI71xroJwbvSEgyw+8kJ5RkjgQQwQc9Zi/ChVM8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ke2qTfj+noAyyYpi8eFWLd2eTIVsbwbavqjszRzCVgW3oYHldJ
 i8+TxzLFDzoO4tc/AGZRXGNdn+x8KiF0Odz1w/o6ssa7WQmQdDE6WuBY4IPMqQ==
X-Gm-Gg: AYBFou1eoWLykN4yXzADAb/5B37KoloAxYI/ojXhkdi6Y7epmnNVdmZfZHpeiwUKuj5
 wU53nk88oku6v3EfdENuN8HEh0q/kj+YQVOZE4Bf4TtvQCyjFTWbq/aTZPRIYqXS+evDtdh292b
 sDZRMvmh6vEUik96WS63MyT7Xxr8QYkRyIUkkCneBIJlG7uNbbV+G4S6sU6GkjpSMt+kCq3oKe3
 ZM+tjj6l95HW6jAnjkJflA8szBRJOyKN4o6cIjqfaOOkROzciXJ2dn0BWopgjtA3rfD1pM0ybmA
 btzQhtOPMBzl9Q74T8+Z+qbRJSGCkz2KmVdoIt9pYHMcNhp01/Mj+1iLGvBaqwR4NzM5hhZvgjm
 T0joSOuTlg4dvhkZ3tVrxq34aYwypoa4iIs8DnF5T64Ols/iE+Ky0UJD1uCopcmYKqQuHNJL2nb
 8zBk/0ZJRZxyLVQSFyJgDbKWhNVDwE31npEjwohqTflxgLaY7mp8kn6snzOAwoKUiOo3NlV+iUD
 zWTie6d03dMds2I9vIIk6gxWr5NVGs4FRtA5eALq4Py+L+ppxVd0GfLuosvAgs=
X-Received: by 2002:a17:90b:4b87:b0:39e:345b:3323 with SMTP id
 98e67ed59e1d1-39e54fb121dmr2271373a91.22.1789700514999; 
 Thu, 17 Sep 2026 20:01:54 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e362e9402sm7969141a91.15.2026.09.17.20.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:01:54 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v7 6/7] drm/verisilicon: extend Kconfig to support ARCH_MA35
 platforms
Date: Fri, 18 Sep 2026 11:01:24 +0800
Message-ID: <20260918030125.315978-7-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918030125.315978-1-a0987203069@gmail.com>
References: <20260918030125.315978-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:09:59 +0000
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

