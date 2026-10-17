Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8F606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RrlGyr03
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0017A10F316;
	Tue, 20 Oct 2026 07:36:44 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035A010E38E
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 14:08:41 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso11666855e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792246120; x=1792850920; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oNxk/T2LUY8i3MRxnTeuyFwAKCAvPmVRbJValg45Ois=;
 b=RrlGyr03cnJutacC6zt0QniU4hzoSumeJdPM5wge5dfkBRgrOlEr/MnRUBoEwrxjtg
 z3NFIPW/Kjjl1hxJnHHAMvIBi1L8Uzb1j9gC25oa+d31+ZvrXYfCO1gWgF3ZyxPQa4Sm
 CFUK5FIYFj9sfXmhXJiOui2lqGFmODtlwUoOgwxMbWP+XVSObsiNTMKOOnmxu9cKkfxU
 TT6q4/Aaqg+jHT+S39Db5JKSpQaXMfNG9VRuAPpRfFOdwH2w8W3xFAA3UJXDxbM5EXQK
 GMXLjdUMq8bs6NrmCrHuyg69XZ5hBsnyHNRSNHiPIteCk06drMkV8ZH87neaSFz8HhYn
 2ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792246120; x=1792850920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oNxk/T2LUY8i3MRxnTeuyFwAKCAvPmVRbJValg45Ois=;
 b=iK/yKTTAN2vAlxHGQlpmXAkxHSu3tLnWiOdjBUZW9mTZDtTXrRiWtr6Q2BUD/Pz/AR
 l3uODV9ua2aqpOQL3RXSUommTUNH+gTS5Xqk73UKvJ9dQhHsXZnz02NFd9aVLhghrnWe
 bh+6bCYknWW8KLY+spr7Vm1P3NGJOhNjxb7z7IczFgLQH5fznQ3llOtcM6YAAEtKgbR1
 mdQ9wiF9DKigQT01K92CY5kufiQqmVTGMoQERitgKvgXFuuEGn1br9htiufwU+57xxRc
 zjc/DRoTo9kThJl+sR5+O5ocGdZyC1gVD+lUkmoxICvG78JE08Mtk9FnPNLUavt/Cuxc
 oPig==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHkDCqBo2hMuQUckOD3I7FTvVo8xzgw+HHNymTTj6w0F6SpXirzI6u3X5wRreGTM61n89N2MHRR5s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL2FknqQDpmuDacS+ktDQ8sfX6P2PiOj78ceYYJrad7+4/pWpg3
 6SsjDHXf7i6Zh20zlqXeBe4P+cnQJjs2rYkkeloIPFBTa8y5gJbvoWpvn16ZjNODjSw=
X-Gm-Gg: AYBFou2q4yiivgtCgeI32RA/8zpu0VhjtiLkly7NjZSb9aQvZsaIyw7LjXcDxv8L/xc
 FOcwqEmwN5xzqWd7idRVtbCZDOuVzJAla4VCdt3tUcTIW9ey6P3y8bO1cGF55uy2yz5wMcODMWa
 1xWgbkndf0HLNK0NIDI55/LgWgTLAvv7rQ4fgl646u5HzMj0YOo2Ttyi2Pq9+EElz4TERGOs6KI
 rZ/UP1woiJxJ2FDFMWYcEFfPxzE/M+yASdgapTOL5QP6Ml+BQ7K665/pQmWlFHRCjKJO47Anb7D
 pwEuWwFo5nEtbZ+4bDOGf1jxE+3k+DX7XF5phkujM1svsrnP79BbiYpAS47DxxOUV3tbJo5qzMx
 5j2tASgqtCIHgdfZ+e1l1LwRclGplSZcCPOLtFh8BOu0tz9QY8qKL004OQvTfaAggcpepvXybzC
 oz7MxrjOLwP4sPnnNB9hVJyj/6o0XNDvFrDEZKhBD3MvbPptO9T999g0q8e902bX0bwDODkulWW
 gc17AKmNJV8ZKfTRamxR6o6pYEEUjTn6JLe2ZfUfsAPnKRwUdreevOmxxy6NMVLHfutypDGw3K1
 7w==
X-Received: by 2002:a05:600c:8b65:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a1d75f2574mr69075175e9.5.1792246119996; 
 Sat, 17 Oct 2026 07:08:39 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::1046])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce3302b5sm84430745e9.4.2026.10.17.07.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 07:08:39 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 3/7] Input: edt-ft5x06 - add an optional controller boot hook
Date: Sat, 17 Oct 2026 16:07:51 +0200
Message-ID: <20261017140827.290666-4-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017140827.290666-1-lukapanio@gmail.com>
References: <20261017140827.290666-1-lukapanio@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some FocalTech TDDI controllers have no flash and run their firmware
from RAM, which is lost whenever the controller is reset or powered
down. Allow the chip data to provide a boot callback that is run right
after the controller is taken out of reset, both at probe time before
the controller is identified and when resuming from the power-off sleep
mode before the register settings are restored.

The boot ROM of these controllers only accepts commands shortly after
reset, so skip the 300 ms settle delay for them and pass the reset GPIO
to the callback, letting it restart the boot ROM when it retries.

Signed-off-by: Luka Panio <lukapanio@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 25 +++++++++++++++++++++++--
 drivers/input/touchscreen/edt-ft5x06.h |  2 ++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 536d633d97a7..e57611e48217 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -148,6 +148,7 @@ struct edt_ft5x06_ts_data {
 
 	struct edt_reg_addr reg_addr;
 	enum edt_ver version;
+	int (*boot)(struct device *dev, struct gpio_desc *reset_gpio);
 	unsigned int crc_errors;
 	unsigned int header_errors;
 };
@@ -1131,7 +1132,16 @@ static int edt_ft5x06_ts_init_hw(struct edt_ft5x06_ts_data *tsdata)
 	if (tsdata->reset_gpio) {
 		usleep_range(5000, 6000);
 		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
-		msleep(300);
+		/* Controllers with a boot callback handle their own timing */
+		if (!tsdata->boot)
+			msleep(300);
+	}
+
+	if (tsdata->boot) {
+		error = tsdata->boot(dev, tsdata->reset_gpio);
+		if (error)
+			return dev_err_probe(dev, error,
+					     "failed to boot the controller\n");
 	}
 
 	error = edt_ft5x06_ts_identify(tsdata);
@@ -1233,6 +1243,7 @@ int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
 	}
 
 	tsdata->max_support_points = chip_data->max_support_points;
+	tsdata->boot = chip_data->boot;
 
 	tsdata->vcc = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(tsdata->vcc))
@@ -1437,7 +1448,17 @@ static int edt_ft5x06_ts_resume(struct device *dev)
 
 		usleep_range(1000, 2000);
 		gpiod_set_value_cansleep(reset_gpio, 0);
-		msleep(300);
+
+		if (tsdata->boot) {
+			ret = tsdata->boot(dev, reset_gpio);
+			if (ret) {
+				dev_err(dev, "Failed to boot the controller: %d\n",
+					ret);
+				return ret;
+			}
+		} else {
+			msleep(300);
+		}
 
 		edt_ft5x06_restore_reg_parameters(tsdata);
 		enable_irq(tsdata->irq);
diff --git a/drivers/input/touchscreen/edt-ft5x06.h b/drivers/input/touchscreen/edt-ft5x06.h
index deadc756cd74..7eaeb562d11f 100644
--- a/drivers/input/touchscreen/edt-ft5x06.h
+++ b/drivers/input/touchscreen/edt-ft5x06.h
@@ -13,10 +13,12 @@ struct attribute_group;
 struct dentry;
 struct dev_pm_ops;
 struct device;
+struct gpio_desc;
 struct regmap;
 
 struct edt_ft5x06_chip_data {
 	int max_support_points;
+	int (*boot)(struct device *dev, struct gpio_desc *reset_gpio);
 };
 
 int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
-- 
2.55.0

