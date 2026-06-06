Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E33DCD6E75
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C81112CFB;
	Sat,  6 Jun 2026 04:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vswcm+mN";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5794112CF9
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:58:13 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-bec449cf976so352344166b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780721892; x=1781326692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIXOvbsU7+o0n1Qu63VvvDhjmq7U5oR0cXTC0wZz+Oo=;
 b=Vswcm+mNGXcLT+A5guNT4GNeinS/gUG+ZgkAt/IHjqE9XZffWJpyJlVO67mTaD8H9x
 PdQ7EwiacmnJsLH0vmM/h2QTr8Lq1/gu8dHwMR6yf7z0UwHboOxim/tyj9Mh1YxXgGn9
 8o9gstqRimuWa0qoH9lRg3bqzTlYBccByRv3MEdA0JUJQ2UEdyZBJkOTQX91S8SqmOtS
 mwFTyeDVY2B3ERMnRvrXOPCYhhnfSEB9Z+b9TGVA79BZW44LzC0liePgsTGIM1/pPr03
 Usc8gFTtBw36MiJoCoaEBFLzb6KZAM9VZ3XdnxIpT+4GKTlBN4YS3w/FkLXwQR1M3rUA
 PWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780721892; x=1781326692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VIXOvbsU7+o0n1Qu63VvvDhjmq7U5oR0cXTC0wZz+Oo=;
 b=QUajCg7JAK9JeFXIYN4OzBbRCBrrq+CNd6r7UMIqgbLQI626BmjxZgJe5Iz45J0hNS
 sjtv/2UlPiSdQh86VEiYae6e3zcQ6/sDWr3DclPy2Fkz9h0eFJVyZWXdLzOZuTTqI4Zs
 TsAhC3ZOP64DOqDcBNylrQ02Bd7pXZV7nfhX1p1Ji3O+/jXL0I+PYhQQJ3dflqSRqw/A
 MEPnjTSz/6D87NttZ8q6UAjQLOKX6iCaCf83Cj/baBbEYcc9lAolSVvdI7T20lwmnIRx
 ae4myzzuoUNWi1GSg9RFEw/tb6EVfJZVpTWqqpqW/YQhDQ0PvtRgvIkyNo58yvCex97a
 GNkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/goEmiXibyode7LKQntzEGAssZXUawB3FK+Gy6VMLpXHXtJIG52b7Cv9hrNQZwmuQN9GIJKbzl5wg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcJe5YCARGTcCw5En/kS86kkx27scBuS8tB8XSDrTVUzmwsqU3
 YexJIDCV5798IIKUUSwevpvH8TfV3IvBthDR+nFcSAx0LlK1DyBqkqGH
X-Gm-Gg: Acq92OGwdUqL7Ta2GosVDfAvphCQJCQ0L2Is+BZEpbqzZP63s6VTs6eG4EYpprO459P
 URJi6rr5hSFur9utm9bAtZU1f6Qp/UdrKUWbJnWiZMfCSpZMQ3QoTGzcZW5IGrV1Lg2pmxHSeiG
 F+Bc5/6sYAtIPTs0ofOmMVx0sQmxTlh2KUz41YahuHkkjSt8yW7JHtV9IkAJfsJTc7QxgvVy9IY
 N7C7rK8wN/sdIps8hPBziLya4Tq8HjKStB96v9OIE0uM4NWK3YartTsFqGwzixDNOK7YMifGu8Y
 QGJHsrWd7TesJeaTyL5PeQnjweMWgTnfhOSY/oc9XpaGnfhTbtLS6fM2it3R/uahhGnw7uA01u6
 zhKGC5YHiIQ1tgznYuY680ctxJi0ce6UXcXVhnSTg/ahz4/eFHOrEr1wwzlbjTkWBz3+z0MkM+W
 zgqqI15kS4gRXfD/STm+veV04pF5vg+qVgHg==
X-Received: by 2002:a17:907:75c2:b0:bec:db41:e4ae with SMTP id
 a640c23a62f3a-bf3737ebea2mr248152866b.43.1780721892058; 
 Fri, 05 Jun 2026 21:58:12 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:58:10 -0700 (PDT)
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
 linux-fbdev@vger.kernel.org
Subject: [PATCH v4 03/14] mfd: lm3533: Remove extern from shared functions in
 the header
Date: Sat,  6 Jun 2026 07:57:27 +0300
Message-ID: <20260606045738.21050-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606045738.21050-1-clamor95@gmail.com>
References: <20260606045738.21050-1-clamor95@gmail.com>
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
---
 include/linux/mfd/lm3533.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index db0a5e5c9e39..aab8f08dfcb0 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -82,14 +82,13 @@ struct lm3533_platform_data {
 	int num_leds;
 };
 
-extern int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
-extern int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
-
-extern int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u8 val);
-extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
-extern int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb,
-								u16 imax);
-extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val);
-extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
+int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
+
+int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u8 val);
+int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u16 imax);
+int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val);
+int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
 
 #endif	/* __LINUX_MFD_LM3533_H */
-- 
2.53.0

