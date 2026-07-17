Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D901C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E2D10E496;
	Fri, 17 Jul 2026 14:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Vorczt1P";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A977210E496
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:51:41 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493f25d47dcso29406335e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784299900; x=1784904700;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IVNSEzVeVDEr/t5gffuEITndGKVn2+8lXoaYf3eYvUM=;
 b=Vorczt1P7CWKEN/yDR6WnHbtinZglz9zVketDFmxtzCG+2YRiB5vaufb09ZzhD7H6N
 BI8SrRhWixJ6Zv9bz0d5G2bOFaS/GuLf1Rzhb3eKNnCxZSHyT4RHckCxwPzeUDHmfWuN
 d1JLSVu+y0WwB+tfIruz7DrZqOuuULYwn8UCHnIOzpjKGTeKB42FTpoQrmS+zhEsY66R
 2eMe6c+uzEUCB45qVcqATvt2s3Q7S+aB++Ry11GJG6fVU8pRuI5r7XdlcwJTZhLK4E9x
 Cfa0z7IpA2Oszekam4ILqQUEmrwO1zSBU9nBmsOCzWC0+jg+9Txp70/NCayfPzS7iBZ/
 49hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784299900; x=1784904700;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IVNSEzVeVDEr/t5gffuEITndGKVn2+8lXoaYf3eYvUM=;
 b=ACpHCu0c9wjcyQZc5YaoXBooYScoBS3KPMBEykLZ+g4WwQXcjQEg6u6zeSfKv5fm0A
 Q+waMRVCjRfCD1cGlIbkvBxoIYpB5jpmYBI5VJ+K4Qajdh4CdbXszDLkXDGZFS6EKBqm
 E9sj1zkhEZEd45a/p709qS9ux5PF58UQwlFHlghlrlD3KTPptegAmI0XdP9qzitkSFcv
 2n5tkGwgEirzbrrce9B9ePCVQi4/6QMsYK4XZt+ACHjM+W8qIuTlB3gcedWWUGa6nA2f
 Mg8jWpaBK0VrHs4aa3If++o0TK/Mp0r9IY0VXdvBz/iuwqUhl5x1am0O+Hh4LILrbs7y
 slng==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTvijt7sqsIiobU5WCnq7f8T3rL79tdwby0OMTXZ2OThpc6Frqil5QwdSHw/mpWfRVB3BLUf8JllY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzjh2UC1NNdS2Rt6v4lpEW1V50uog0SRdGknEHdL1zOioqE4gQm
 CdjgCgXCu/+1DHqZc2+oiyN7Nq0wrMQQs3oJiFVGANoHF7tOVnhmKComIrZQOR83Tjw=
X-Gm-Gg: AfdE7cnnz8JS4eB0fajJu0HoLKWGB6oiAuzOOPTwvy7Ln3poYM/gYJRmwXwCb5156IW
 xwy88UlLKITblat3xYnnw4alcqCox6TLQsJKQKc5znc0Z20btVaw0O2Wk85T+ghYDWG3rkSw3Zg
 vFKfDBfYCBSK1Y96niUh+nnbx9IPPJOdoHTiTbsiDZ0dW1bsDk3IRBunS6r/bgix7j862HBmA88
 MP2MHHr5XF+Ijs3N2TXBmsl3MclJLw6CNgzSSzfpOkSymIUPmiPydn7vaoXITJcRtbK88M2fzjU
 2YG0PUsV8xn7B4jDxwrzEy15WygOe90wR2PzySX9gtIgUVm/TyyKrVfu3Hu4bWJW4UtNXecEClJ
 GqzLtCpBAJsOtZWC/PQfqFhoKi9FaQR8R2ouvGg8R5A+qob6GStDQ+VP8trSVVzgWQ90SV5ouTW
 WiwW9TC+6wK/kQ80dFFRzvE1BdT0vQ7zl7ZjHg9Ue4u9+Xr1j4wL6VNq1JJh/x3RkAIA==
X-Received: by 2002:a05:600c:4685:b0:495:4a77:1327 with SMTP id
 5b1f17b1804b1-4954a771521mr35673365e9.33.1784299899945; 
 Fri, 17 Jul 2026 07:51:39 -0700 (PDT)
Received: from localhost
 (p200300f65f47db047d2d8b161e35ab77.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:7d2d:8b16:1e35:ab77])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f63e519f4sm4299068f8f.14.2026.07.17.07.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:51:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 John Stultz <jstultz@google.com>, Eric Piel <eric.piel@tremplin-utc.net>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 11/12] misc: Unify style of of_device_id arrays
Date: Fri, 17 Jul 2026 16:50:57 +0200
Message-ID: <fbf51b8f413c516977e2c8a81896221795df77e4.1784299069.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1784299069.git.u.kleine-koenig@baylibre.com>
References: <cover.1784299069.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6864;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=HHmWBx8/WEy0P+2R3GXn3gqnRQXJL8NR17O07WlcvG4=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqWkFheLOxpzkeXb41Of5vsSxAFSWsNYn3qoDLa
 sVQVyuD1KOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalpBYQAKCRCPgPtYfRL+
 TtQ2B/40I147YY2V/Z/qLnO9Ezo8Zc72HgCjFbi//E3M9gtm6YpPq6tuye/pWfJ3YBUbO74D1Ay
 3knvQXFIbD7y0mOguO11kx0e9cdEc5cG2+nlocq3475zdQPdlg/PS3DItckLAnQ46gkMofqu/0c
 HFXMGEhTHcCjIIhcFzdl2m+C1bM1CbJaysivoHYxX8XrhZ7TB5nekeUD7VDiCIEp5fMzOzChC1l
 rElel9cvpiwBYERH4GPxpfgEKe5ftez6Xr/af9+5sesGr5W/7PuF9n8HpniRRG8rx9UhVsu8ZKr
 aqnMDQIzWdMbpcrbhrMnsGNlTWlYqcZ2wb6ZD4+pwe4WN7CY
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

Update the various of_device_id arrays to conform to the most used and
generally recommended coding style. That is:

 - No comma after the list terminator;
 - A comma after an initializer if (and only if) the closing } is not
   directly following;
 - No explicit zeros in the list terminator;
 - A space after an opening { and before a closing }, a single space in
   the list terminator;

Adapt the few offenders accordingly.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/misc/ds1682.c                  | 4 ++--
 drivers/misc/fastrpc.c                 | 6 +++---
 drivers/misc/hisi_hikey_usb.c          | 2 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 2 +-
 drivers/misc/lis3lv02d/lis3lv02d_spi.c | 2 +-
 drivers/misc/open-dice.c               | 2 +-
 drivers/misc/pvpanic/pvpanic-mmio.c    | 4 ++--
 drivers/misc/qcom-coincell.c           | 4 ++--
 drivers/misc/sram.c                    | 2 +-
 drivers/misc/ti_fpc202.c               | 2 +-
 drivers/misc/vcpu_stall_detector.c     | 4 ++--
 11 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
index f073a5067fc8..4500d7d0ea77 100644
--- a/drivers/misc/ds1682.c
+++ b/drivers/misc/ds1682.c
@@ -277,8 +277,8 @@ static const struct i2c_device_id ds1682_id[] = {
 MODULE_DEVICE_TABLE(i2c, ds1682_id);
 
 static const struct of_device_id ds1682_of_match[] = {
-	{ .compatible = "dallas,ds1682", },
-	{}
+	{ .compatible = "dallas,ds1682" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ds1682_of_match);
 
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d86e79134c68..f7b6aba8b71d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2299,8 +2299,8 @@ static void fastrpc_cb_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id fastrpc_match_table[] = {
-	{ .compatible = "qcom,fastrpc-compute-cb", },
-	{}
+	{ .compatible = "qcom,fastrpc-compute-cb" },
+	{ }
 };
 
 static struct platform_driver fastrpc_cb_driver = {
@@ -2579,7 +2579,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 static const struct of_device_id fastrpc_rpmsg_of_match[] = {
 	{ .compatible = "qcom,kaanapali-fastrpc", .data = &kaanapali_soc_data },
 	{ .compatible = "qcom,fastrpc", .data = &default_soc_data },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, fastrpc_rpmsg_of_match);
 
diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 79f06001259b..e68bc6e384d5 100644
--- a/drivers/misc/hisi_hikey_usb.c
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -254,7 +254,7 @@ static void hisi_hikey_usb_remove(struct platform_device *pdev)
 
 static const struct of_device_id id_table_hisi_hikey_usb[] = {
 	{ .compatible = "hisilicon,usbhub" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, id_table_hisi_hikey_usb);
 
diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
index 36032fc125f3..7c3ca6d604d1 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -95,7 +95,7 @@ static union axis_conversion lis3lv02d_axis_map =
 #ifdef CONFIG_OF
 static const struct of_device_id lis3lv02d_i2c_dt_ids[] = {
 	{ .compatible = "st,lis3lv02d" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lis3lv02d_i2c_dt_ids);
 #endif
diff --git a/drivers/misc/lis3lv02d/lis3lv02d_spi.c b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
index 203a108b8883..5bf95176a00e 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_spi.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
@@ -60,7 +60,7 @@ static union axis_conversion lis3lv02d_axis_normal =
 #ifdef CONFIG_OF
 static const struct of_device_id lis302dl_spi_dt_ids[] = {
 	{ .compatible = "st,lis302dl-spi" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lis302dl_spi_dt_ids);
 #endif
diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
index 45060fb4ea27..77ab0c1e83d3 100644
--- a/drivers/misc/open-dice.c
+++ b/drivers/misc/open-dice.c
@@ -177,7 +177,7 @@ static void open_dice_remove(struct platform_device *pdev)
 
 static const struct of_device_id open_dice_of_match[] = {
 	{ .compatible = "google,open-dice" },
-	{},
+	{ }
 };
 
 static struct platform_driver open_dice_driver = {
diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index 43a094bfdaec..724dfddf69e4 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -51,8 +51,8 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id pvpanic_mmio_match[] = {
-	{ .compatible = "qemu,pvpanic-mmio", },
-	{}
+	{ .compatible = "qemu,pvpanic-mmio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pvpanic_mmio_match);
 
diff --git a/drivers/misc/qcom-coincell.c b/drivers/misc/qcom-coincell.c
index 3c57f7429147..b58bd34fc471 100644
--- a/drivers/misc/qcom-coincell.c
+++ b/drivers/misc/qcom-coincell.c
@@ -124,8 +124,8 @@ static int qcom_coincell_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_coincell_match_table[] = {
-	{ .compatible = "qcom,pm8941-coincell", },
-	{}
+	{ .compatible = "qcom,pm8941-coincell" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, qcom_coincell_match_table);
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 1919d24c8236..c8990e83a65a 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -370,7 +370,7 @@ static const struct of_device_id sram_dt_ids[] = {
 	{ .compatible = "nvidia,tegra186-sysram", .data = &tegra_sysram_config },
 	{ .compatible = "nvidia,tegra194-sysram", .data = &tegra_sysram_config },
 	{ .compatible = "nvidia,tegra234-sysram", .data = &tegra_sysram_config },
-	{}
+	{ }
 };
 
 static int sram_probe(struct platform_device *pdev)
diff --git a/drivers/misc/ti_fpc202.c b/drivers/misc/ti_fpc202.c
index 2aac83ec4a39..9e2d24f89457 100644
--- a/drivers/misc/ti_fpc202.c
+++ b/drivers/misc/ti_fpc202.c
@@ -718,7 +718,7 @@ static void fpc202_remove(struct i2c_client *client)
 
 static const struct of_device_id fpc202_of_match[] = {
 	{ .compatible = "ti,fpc202" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, fpc202_of_match);
 
diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_detector.c
index 26166357b255..1306b2c1ef99 100644
--- a/drivers/misc/vcpu_stall_detector.c
+++ b/drivers/misc/vcpu_stall_detector.c
@@ -224,8 +224,8 @@ static void vcpu_stall_detect_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id vcpu_stall_detect_of_match[] = {
-	{ .compatible = "qemu,vcpu-stall-detector", },
-	{}
+	{ .compatible = "qemu,vcpu-stall-detector" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, vcpu_stall_detect_of_match);
-- 
2.55.0.11.g153666a7d9bb

