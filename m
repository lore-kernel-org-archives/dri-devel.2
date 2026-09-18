Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C96C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761E910E84B;
	Fri, 18 Sep 2026 07:13:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iISJIkdZ";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF22610F147
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:01:51 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2dd68a16955so13779895ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789700511; x=1790305311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QPg1uLKI5p/H7J2E4b3w0DPqeVInWxkk5y+GYwVR13I=;
 b=iISJIkdZnf+5GzMC0BqFMZaMrdW0CYrVJdweUOiX6UNmQPgndcVtWFKBog2P8/I7Tc
 aaI41zOnFYFRvCNSI569wKQT9mHeJw6pQH1Dt/R5y5OwRl7dOxlNva9nU5fzOpY0XH6P
 dxD8tpNvxhiE811xpq4rymIHZ8Yu+j6oz5ZsArRNf4KY005liBUcSQ5AD4HMBRcC/I99
 TbiiV+3tSHyCCaMYuf9tTwQdYmDC64WMjamcveqE76WPgwn3obQVqoeAscfsZ7QuX7ZN
 OVJyvbKXQYZk9SIW0r0LTI9Ek0SFZH8JLsp6jLiRTsk1DdFpoEOwfVFUukQ53wPbL9C7
 92sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789700511; x=1790305311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QPg1uLKI5p/H7J2E4b3w0DPqeVInWxkk5y+GYwVR13I=;
 b=pVA10cJA+eTIJzK4jGWgNuowQ+Y19AE96wYoB+CVWMg0vcKfRKOpsWsOP2JQkAElM+
 X4llEab6IzOqHK9FpD3MOgdaj/2RUgBZK3TDSNCsr1pNw/vxyEPV6/wufil16u+ANFTD
 wGz5lDviQDQOaKkMjKt2DlnpJHvJamSDNelJPE+8E7a4RyAwcX/9E86q45/6AnqmCXBN
 ZuV2u7i8iE8PXZgod3feFZalsvJ+WJ/MvRWB3H+2CHkSfglt6toeZwjNZlp7dNlsD5Hq
 Neqqm1FdWxWAVa06svmCky+iemKqdVjJG/1EWlvsfWjR0qOD+Ema5RhV3sUFfQx8yAxF
 Bhvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIiS6HX7RubQWJ4egH9v+LhDWWCAWcrZCBp7AcUJ/BWauKHOOX9NodZu+6Iv0ZcDB8439092ywiCw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n1NRCVTZ5KIbbN5a3yyIt7PNTGBh5+iXrtx9C2Y1/DvUEyqX+g
 YGs4RrXOKIL80v+7ksXOhp96wWOBbUle6jws0yXbHbIn+4YwzmCri5JCYoXnXQ==
X-Gm-Gg: AYBFou19xiYkavlhM7fAzubi8SiT0mFJ+wbH8l3rxbEBuxCytOsdzBGRS5oddh/BZM5
 po88RKh5T4Qa37Amaix8oYko+5k1YurWfB/DlPu25X7DuWnaQw/Q7aABY6weOPb22iTTxnzdv+4
 RCvlvCtONOu5tKGmIxp2n7AJnX9BlIOeOAaMl7Rn5Hb7octrZvKOJAj1VAf48yih+RRLpSS6kgk
 QFV127ZycTmoGckuQYoJhYAlfg56PCzploSK/vX0ZnjMsmHPHj/pcL7hQDDjQ/eEBwveLrbqZs1
 cgPmpS6iAVN9nYED8MLxbQ4w3jzbCrongnk7It9ZukZ+RDlaXiJpoE3UUup1Nzjm995SEDwj3Z8
 4KlD6VcmGe0bJ20TVjfu351YNs+G/65ZDIw/+5PXYVofMzg6h0RQpn8zLnAhH904JrvoUP9j40e
 lYhcuEewaQ+yJnfnPfgh/VLuh94Y1guvAISysH0UF3z1ogWl0kVJxaAvawYpiRZiJY4qKhvcYzf
 EzIiTiMQuLym67MoUPG58oMcWN7d1g2j2vIx5ktFYJB0XbRe8T2VPM9MREhY1Y5u2RwY54/4w==
X-Received: by 2002:a17:90b:3f0d:b0:39e:2c5c:a689 with SMTP id
 98e67ed59e1d1-39e361ab7dbmr7741778a91.30.1789700511242; 
 Thu, 17 Sep 2026 20:01:51 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e362e9402sm7969141a91.15.2026.09.17.20.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:01:50 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v7 5/7] drm/verisilicon: add DCUltraLite chip identity to HWDB
Date: Fri, 18 Sep 2026 11:01:23 +0800
Message-ID: <20260918030125.315978-6-a0987203069@gmail.com>
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

The Nuvoton MA35D1 chip contains a DCUltraLite display controller with
model number 0x0 (sic, the model name contains no number either),
revision 0x5560 and customer ID 0x305.  It has a similar register map
with DC8000, only one display output and only 32x32 cursor supported.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/vs_hwdb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/verisilicon/vs_hwdb.c
index 91524d16f7785..7d630a667a3f0 100644
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

