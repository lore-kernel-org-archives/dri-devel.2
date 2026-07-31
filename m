Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EC1C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA34310F22A;
	Fri, 31 Jul 2026 11:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q6jl8Q0L";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7134810F227
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:36:57 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f707e5d75so650744f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785497816; x=1786102616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WwovEeXaCAdfULQBEy/htRRSiSsUVEDD/fWA6pMEZ8M=;
 b=q6jl8Q0LcroqRdNArBAESVOl+WJ9ffvwamcHTdDaX/f5XWKUPMf+PDYPmst8aFu2oZ
 1agv/rzB2fx/gawcUoipdNudBJzSzFW9WTCb21ngPsZvyXmKn5BWudm8gfXgO4TblSMg
 wpFTEpZ0zFEF3N9PE97zrUCU3wYI0Bs+E5Dy23kwxxkLaLxImlZMwVV+YfM9BVSbKGMU
 EYRS6KK8taEggHrBK+6SJhDXm9pQjlQ7sSn1txm3kScq2fFUGNz+NmVYkCTyanIcSs6y
 i6ckm+UE5DJtDl09qcjEeaO5BtPcO1u65Epk9/jGPGtXSbEGSosHxwI9qFhDw+XUQ5DQ
 0dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785497816; x=1786102616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WwovEeXaCAdfULQBEy/htRRSiSsUVEDD/fWA6pMEZ8M=;
 b=EW673k5Vayc6NRhJYtXpv/0BHi693zfiB6KflRq+gKTcClgmXsQbKRIgak4m3ltSoe
 NElK1F9Ym3RM9qmGMpcbAJNkqr+jjWPvAN0ZWcR6+1qKitgK6qjFJ397r5nuc52jWmod
 0bVOrIecbr3uPm1i85ZySEsxaIo5ciWVLgTwx2Of20d894RJjXc6dfGYoTNkdRD3O67D
 SfiXZ8/l9F3Ugo+1RqXl2gr1A7oBdh1Suh1s8A5ENnAFjjIILhExFZU1GBk5JMDgUDn3
 dOdNL97FJD8qdoJ6MRAdCGDqhgR9umnCnMcIA6eCKWjgJi3O2V/NLjrVI8bKuke8VBlg
 wPxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmWFGL5sSJgHnKugb+USS2eXvBsIZCyR21k8d5VXvp37AsoHUzP4V2ShGAozgBA+kR6erJaqQJ6v8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2EFwlrIfP5JxcnUV0tssj2TuShr9wAWF8PDoYvd686gLM4Zk2
 KvByXHYQC23LNMwYccVGLq7SHTV8xSioXEmmmBpV+7N8WXYgfIVZmKRk
X-Gm-Gg: AR+sD13+bVCISOzxcd7rECILE8RupiLFzFkW12pCykNXmXX6a1IT7g4FfoEycEi9z+w
 6pZScAwQ5LTu0wNAcbXvYym19Ckyitz2jQ5LL/4NW3KszJeJbxk7GTOcSq58nj4lZIxjAOVXH3m
 dMqFqLlWZqau8+lLoKCWJhk65ks2o1AZAiu2QSV5GkKF/CzvMocZvJdvN7XJ8t3aHoVxHm1z00O
 orM0lAMg/bpkBK4OUdR2YrOAXx7wx+59fK2DVEmevLlG0PVyuADR9wHuDpY9Du18n81YT8o9S1F
 s6bqb4IINLO85gFimxlJJxQPzJ4Ssbxb/pldC+EyhB7Zi5g0+y6AYFQWVtZeGpKDKLy9KXq2W0/
 D5kYUHIwQvvLzWTqBhkXTUQC/kr+txcxPw4/yHoSfAU4ZwORoPXy1IwCziZQ3LMeKD/1mmGZYuw
 z1Zj6WJuh9tK8ZJWXSS6n201+J1tC1AgNedDG66qNPk6MxpjLbogKIbzdrY9BjKBcWKxIg3uX1Q
 Fqa4eeIhQ==
X-Received: by 2002:a05:6000:41c9:b0:47f:86af:8fdd with SMTP id
 ffacd0b85a97d-47fd2abad19mr3920947f8f.3.1785497815591; 
 Fri, 31 Jul 2026 04:36:55 -0700 (PDT)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:36:53 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: [PATCH v6 03/14] mfd: lm3533: Remove extern from shared functions in
 the header
Date: Fri, 31 Jul 2026 14:36:21 +0300
Message-ID: <20260731113632.158440-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
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

Using 'extern' is not required, drop them.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 include/linux/mfd/lm3533.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 3463b164d0c17..c4c38876c09bb 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -82,13 +82,13 @@ struct lm3533_platform_data {
 	int num_leds;
 };
 
-extern int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
-extern int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
-
-extern int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u32 val);
-extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
-extern int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u32 imax);
-extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u32 val);
-extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
+int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
+
+int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u32 val);
+int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u32 imax);
+int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u32 val);
+int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
 
 #endif	/* __LINUX_MFD_LM3533_H */
-- 
2.53.0

