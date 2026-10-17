Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7C606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EmiuOLgc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD5410F31B;
	Tue, 20 Oct 2026 07:36:45 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A511F10E107
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 14:08:40 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso6173815e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792246119; x=1792850919; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H2Dcg4q4de62PcVyE302T3A2E9kOAxLGWxlSec6cjn8=;
 b=EmiuOLgcbZI+0dCGRrXyYXQyl1G2psFSSexWwUaNSvGTiIHuQiSulJLFtAM5cZzz5o
 vKNtsL53l2Z3jwqCmq7EQKEAFq0XkXDleq0Rofx3eaeEOtIfIKO29z9zsDUABjzS9G87
 /RnIGubZ9jN60SLZJ4RxL0cpifs/MlrV4aciISjHEEdPGRze0iPNeJ8TKX1nCGlMkc3d
 3sZbVZ/thGfKy6qGKF74NIPVm1yl2bWtp/tfXe2+N25iGs3j8V+4qyG1y/T1k89nDASZ
 08VrhugVokrxS308gUJ0pFgGCQCpyz9dGD5JdpYPnEPLACT5HLadK2lthqx9PLByH/6Y
 hDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792246119; x=1792850919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H2Dcg4q4de62PcVyE302T3A2E9kOAxLGWxlSec6cjn8=;
 b=0NYGyEa8PvMsesyebsJgqCXqdfExUlQXyND/cjRSYcfTp1m5RJV7BMRjIZWLTO9aMx
 o+iOHbRZaz9YWRpnLruu7p4mNrcBssL6hkHEVBr/qGa174m4jPfUBwu0lFcB1WAvW+dL
 W4ZbPSyKwpN/RYFkkKVzMgr6Jk4aoErQ3fsiDJOjUyvccS6pVc3qTNYvyhh88WuNl+HD
 N4p+NWJimOj0nZxm23I5TbxSzJefGEsNIcpAs466kxQRxfOPmmu/1a6kRU+1LAuw01Fn
 Y/SEM8m1pwr4adB5z5mTNcIOp/Tsbrq4FVkrLHgV1Ixi1UX5Rrg5ZPb9mTXq6WwcVDMl
 b5Dg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3nFFORmP5EIE67/eMQq7hDx73iwwDlJW9XPpWM6u5EUWqUMXDbamxVHo1xznyQsT4o0elgCsMolc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLr9WsiK2ex0IRGEFu3ySSYot3B/lAWXDIcK0faDJE568NypceX
 J+dIl5Nu0q1hqOyEsP8wxlxoExu9VoQiYT6P8EoySFbZzMgurY0k94/T
X-Gm-Gg: AYBFou3eP+1y2vRaw3Tr2Q08C81WTj3px6gkO6FUYurJzj/Vuw/3onW9vNKUYdYEfcZ
 4VY/yM7PSwUxkwKK56C/AMQiy47bHEQnpW09LTEXXvVn2AbDQf5wTPjdnLASgy1414Fp8LqSsDe
 zYdqWGHcOX9yAJhDYYTymqn4LRTBiVHT6i9k8PWf5iast7xK0CtVc+1QmPg3PNS9ucsd72q3D3a
 3wevR2yPLQ6kp1hUFVXmaIq5MEomAj3sZOzYObnl45wdKqywWqUKqSTNXVZ+MekFAV7TZf88b1v
 5Dx/GZ2DLDVJZO8HqYDjTLiDGa+b48STqBKH/0GnF2OAgep1NdTPATTbfgpRlvw0pxdAZO15UMy
 x+JP0/irCIqbnr9gLiyCkVsXOgRFOdag2cna6PhZDlxeUJHlOrC0ABhug0evCLrVeM7pM/uNObN
 xMcu8ETqfZlClyw6RUR1ONizrZkVpbvx3WRA+ik4os62n1OPc4KoUjsKB+0hRaYcHaHbfZM4v82
 Ou1NsAG48iTtANk5EF85rgMIUAOI/PNlOThdLrRK/SC7+j4VmISx17jKgfaS1Oba/vMeousph5S
 Gww=
X-Received: by 2002:a05:600c:1c09:b0:4a1:df2f:ae8f with SMTP id
 5b1f17b1804b1-4a1df2fb8abmr22004175e9.6.1792246118623; 
 Sat, 17 Oct 2026 07:08:38 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::1046])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce3302b5sm84430745e9.4.2026.10.17.07.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 07:08:38 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 2/7] Input: edt-ft5x06 - move the controller bring-up into a
 helper
Date: Sat, 17 Oct 2026 16:07:50 +0200
Message-ID: <20261017140827.290666-3-lukapanio@gmail.com>
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

Move the part of probe that takes the controller out of reset,
identifies it and registers the input device into a helper, so it
can also be run after the probe.

Signed-off-by: Luka Panio <lukapanio@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 154 ++++++++++++++-----------
 1 file changed, 86 insertions(+), 68 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 543cc62088c7..536d633d97a7 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1116,16 +1116,96 @@ static void edt_ft5x06_disable_regulators(void *arg)
 	regulator_disable(data->iovcc);
 }
 
+/*
+ * Take the controller out of reset, identify it and register the input
+ * device.
+ */
+static int edt_ft5x06_ts_init_hw(struct edt_ft5x06_ts_data *tsdata)
+{
+	struct device *dev = tsdata->dev;
+	struct input_dev *input = tsdata->input;
+	unsigned int val;
+	u32 report_rate;
+	int error;
+
+	if (tsdata->reset_gpio) {
+		usleep_range(5000, 6000);
+		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
+		msleep(300);
+	}
+
+	error = edt_ft5x06_ts_identify(tsdata);
+	if (error) {
+		dev_err(dev, "touchscreen probe failed\n");
+		return error;
+	}
+
+	/*
+	 * Dummy read access. EP0700MLP1 returns bogus data on the first
+	 * register read access and ignores writes.
+	 */
+	regmap_read(tsdata->regmap, 0x00, &val);
+
+	edt_ft5x06_ts_set_tdata_parameters(tsdata);
+	edt_ft5x06_ts_set_regs(tsdata);
+	edt_ft5x06_ts_get_defaults(dev, tsdata);
+	edt_ft5x06_ts_get_parameters(tsdata);
+
+	if (tsdata->reg_addr.reg_report_rate != NO_REGISTER &&
+	    !device_property_read_u32(dev, "report-rate-hz", &report_rate)) {
+		if (tsdata->version == EDT_M06)
+			tsdata->report_rate = clamp_val(report_rate, 30, 140);
+		else
+			tsdata->report_rate = clamp_val(report_rate, 1, 255);
+
+		if (report_rate != tsdata->report_rate)
+			dev_warn(dev,
+				 "report-rate %dHz is unsupported, use %dHz\n",
+				 report_rate, tsdata->report_rate);
+
+		if (tsdata->version == EDT_M06)
+			tsdata->report_rate /= 10;
+
+		regmap_write(tsdata->regmap, tsdata->reg_addr.reg_report_rate,
+			     tsdata->report_rate);
+	}
+
+	dev_dbg(dev, "Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
+		tsdata->name, tsdata->fw_version, tsdata->num_x, tsdata->num_y);
+
+	input->name = tsdata->name;
+
+	input_set_abs_params(input, ABS_MT_POSITION_X,
+			     0, tsdata->num_x * 64 - 1, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y,
+			     0, tsdata->num_y * 64 - 1, 0, 0);
+
+	touchscreen_parse_properties(input, true, &tsdata->prop);
+
+	error = input_mt_init_slots(input, tsdata->max_support_points,
+				    INPUT_MT_DIRECT);
+	if (error) {
+		dev_err(dev, "Unable to init MT slots.\n");
+		return error;
+	}
+
+	error = input_register_device(input);
+	if (error)
+		return error;
+
+	edt_ft5x06_ts_prepare_debugfs(tsdata);
+
+	return 0;
+}
+
 int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
 		     const struct edt_ft5x06_chip_data *chip_data, u16 bustype,
 		     struct dentry *debugfs)
 {
 	struct edt_ft5x06_ts_data *tsdata;
-	unsigned int val;
 	struct input_dev *input;
 	unsigned long irq_flags;
 	int error;
-	u32 report_rate;
 
 	tsdata = devm_kzalloc(dev, sizeof(*tsdata), GFP_KERNEL);
 	if (!tsdata) {
@@ -1225,78 +1305,22 @@ int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
 		usleep_range(5000, 6000);
 	}
 
-	if (tsdata->reset_gpio) {
-		usleep_range(5000, 6000);
-		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
-		msleep(300);
-	}
-
 	input = devm_input_allocate_device(dev);
 	if (!input) {
 		dev_err(dev, "failed to allocate input device.\n");
 		return -ENOMEM;
 	}
 
+	input->id.bustype = bustype;
+
 	mutex_init(&tsdata->mutex);
 	tsdata->input = input;
 	tsdata->factory_mode = false;
 	dev_set_drvdata(dev, tsdata);
 
-	error = edt_ft5x06_ts_identify(tsdata);
-	if (error) {
-		dev_err(dev, "touchscreen probe failed\n");
-		return error;
-	}
-
-	/*
-	 * Dummy read access. EP0700MLP1 returns bogus data on the first
-	 * register read access and ignores writes.
-	 */
-	regmap_read(tsdata->regmap, 0x00, &val);
-
-	edt_ft5x06_ts_set_tdata_parameters(tsdata);
-	edt_ft5x06_ts_set_regs(tsdata);
-	edt_ft5x06_ts_get_defaults(dev, tsdata);
-	edt_ft5x06_ts_get_parameters(tsdata);
-
-	if (tsdata->reg_addr.reg_report_rate != NO_REGISTER &&
-	    !device_property_read_u32(dev, "report-rate-hz", &report_rate)) {
-		if (tsdata->version == EDT_M06)
-			tsdata->report_rate = clamp_val(report_rate, 30, 140);
-		else
-			tsdata->report_rate = clamp_val(report_rate, 1, 255);
-
-		if (report_rate != tsdata->report_rate)
-			dev_warn(dev,
-				 "report-rate %dHz is unsupported, use %dHz\n",
-				 report_rate, tsdata->report_rate);
-
-		if (tsdata->version == EDT_M06)
-			tsdata->report_rate /= 10;
-
-		regmap_write(tsdata->regmap, tsdata->reg_addr.reg_report_rate,
-			     tsdata->report_rate);
-	}
-
-	dev_dbg(dev, "Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
-		tsdata->name, tsdata->fw_version, tsdata->num_x, tsdata->num_y);
-
-	input->name = tsdata->name;
-	input->id.bustype = bustype;
-
-	input_set_abs_params(input, ABS_MT_POSITION_X,
-			     0, tsdata->num_x * 64 - 1, 0, 0);
-	input_set_abs_params(input, ABS_MT_POSITION_Y,
-			     0, tsdata->num_y * 64 - 1, 0, 0);
-
-	touchscreen_parse_properties(input, true, &tsdata->prop);
-
-	error = input_mt_init_slots(input, tsdata->max_support_points,
-				    INPUT_MT_DIRECT);
-	if (error) {
-		dev_err(dev, "Unable to init MT slots.\n");
+	error = edt_ft5x06_ts_init_hw(tsdata);
+	if (error)
 		return error;
-	}
 
 	irq_flags = irq_get_trigger_type(irq);
 	if (irq_flags == IRQF_TRIGGER_NONE)
@@ -1310,12 +1334,6 @@ int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
 		return error;
 	}
 
-	error = input_register_device(input);
-	if (error)
-		return error;
-
-	edt_ft5x06_ts_prepare_debugfs(tsdata);
-
 	dev_dbg(dev,
 		"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
 		irq,
-- 
2.55.0

