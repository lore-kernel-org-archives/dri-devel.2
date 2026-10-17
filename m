Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264F606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bKjd1rrJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97DE10F2FB;
	Tue, 20 Oct 2026 07:36:32 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F7310E0BD
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 14:08:43 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so7736005e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792246122; x=1792850922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B9YVPWXQ1AxunRapx6pi/difSuiJYO0pfCJBVjjClPo=;
 b=bKjd1rrJmbbht0o9F5y08g/tZsP8Pi7aK6xoGU9xUFRMw7lINQT58f1uX2R0JfRcK/
 Do6hRtHKBHuAwnM2mIR4HE6pwTVmhO59pjkOc+ZXjzNbvJmXzWnwhDQtHMTOuX32aydI
 gwEXKtvEK/ubwRXjmEa7wTfnWULi5/d7jAuoVbFKeNmekWF9NOvefB53QDpvqaPKGEK8
 IYB4zLCjMRUHgjjKSQDFGaT8j/dVy8HHcTPryBPisHAjnWyb7XY+zXF8s/Nw0zba2AD+
 POLMGyz8t/QR87nsdWYwXOMBCGv/xgfjG01HsIFvITbFVy+kksdureGuLdTmfdiRyIPL
 vFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792246122; x=1792850922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B9YVPWXQ1AxunRapx6pi/difSuiJYO0pfCJBVjjClPo=;
 b=u4xMKJBmUbwTr9bMzbQMVHOM5dlK6CEx6QnSgrbWZJIN9Wb4JdkNTK4dmRn15v4VWZ
 MIJqyh6sS//5ZxmARgnfJnCCCLbhlHc77dQiyviUBjdyEloBefQOW5JzEdLiKwuROQz4
 ATEnTbRW8XiV7cX/Dl7ABVWt/b+quf+zsq5mTdNi7fxlJUkVY6qn1gzA1lPejOp99VlV
 whR5Dom5WyfC8WPmowopRwHhcnh84ETkCWxJWQhUneV+pc1M2/7sBnUGY1issIEuYd5R
 AzHIJ8FDD4arECDd5WgAuaTiMVXobEuQE271boNWCRO8zEL6I5N7V3SbCUKS7YMekctb
 TYlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0z1UxEXX+VtY7TDcH3Rq/3NmuNxDofBPFpsCyXTf1nRnQGGC4XmWf5m8UWBgbBhRc6n0Efbm/CBU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKlEDzKHXvOJ78lhwjK5AWcaTWth8IqxlNfO4LFzgLgecp9ZEpJ
 +ZrRieZ+fV/yZuqM9gmayRwM9A0mtJR7+Pe7LX72L96a/hkGMVJk8Q2a
X-Gm-Gg: AYBFou2qL7nzzrYDWLt1WL6kbrFGKITSZQ/7a5p0qA2DnbvMMczKQCHk2wz0/m0pha6
 TTS6zIrqRVn3TbvDiHXVWeGtUs+Asi0Ymtmf2Uxw59iSGeVqArDELzM8YqAa0kR8q1RN75qkqHv
 YtKbR7VWX8wKcOrf/JTHWscDr//7kSxhEUA7NCIZqUO94qzQKWSyT6tzHxCbfaHXkhV2x2rcV2j
 IBFCyqB/l2DpQGnQ4p3WV++PXEo0GWWG5HLWLxe85WBQl3RxfALz4U9gbR7zcIQu1/WRgMmd82y
 gwOT6Bk8ZOBy0RV9YveUnHp8cr1l51Z97Q/F/RErQoJ9iMAaSqYhqG+uEQXtJgQ+0lT4o+quhNb
 FoApohFtu7SmgIf4GiFIgoX65YK9uvzT6pDuy15KIRop3VNf8fXSo3z5qIY7RjxgmIHO5BmmPHV
 I6od1zu2l1E3svBXF5ff8XNG8ofXm1p6IJavwuGi/kfm4UTs/Tj1LtfntvdE0iEIotGFAIZwyzs
 t9MrUJYrp9W0W+jVYB0Y48Mw9b5JAFVWXKakJwUgG7JfL/WcxzgOtuCDvKCGEG+Q3dOuYEE0zo0
 /g==
X-Received: by 2002:a05:600c:8a0d:20b0:49c:fed6:cd3f with SMTP id
 5b1f17b1804b1-4a1d7616d29mr40954785e9.23.1792246121666; 
 Sat, 17 Oct 2026 07:08:41 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::1046])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce3302b5sm84430745e9.4.2026.10.17.07.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 07:08:40 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 4/7] Input: edt-ft5x06 - allow a chip specific touch data
 register
Date: Sat, 17 Oct 2026 16:07:52 +0200
Message-ID: <20261017140827.290666-5-lukapanio@gmail.com>
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

The generic FocalTech path reads the touch report starting at register
0x00 and expects the points from register 0x03 onwards. Over SPI the
FT8722 only returns the report when the read starts at register 0x01;
a read from 0x00 returns the static register block instead, the
interrupt is never acknowledged and no further touch events arrive.

Let the chip data select the register the report is read from, keeping
the points at register 0x03.

Signed-off-by: Luka Panio <lukapanio@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 6 ++++--
 drivers/input/touchscreen/edt-ft5x06.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index e57611e48217..7bcc48e07d62 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -149,6 +149,7 @@ struct edt_ft5x06_ts_data {
 	struct edt_reg_addr reg_addr;
 	enum edt_ver version;
 	int (*boot)(struct device *dev, struct gpio_desc *reset_gpio);
+	u8 tdata_reg;
 	unsigned int crc_errors;
 	unsigned int header_errors;
 };
@@ -1037,8 +1038,8 @@ static void edt_ft5x06_ts_set_tdata_parameters(struct edt_ft5x06_ts_data *tsdata
 		tsdata->point_len = 4;
 		crclen = 1;
 	} else {
-		tsdata->tdata_cmd = 0x0;
-		tsdata->tdata_offset = 3;
+		tsdata->tdata_cmd = tsdata->tdata_reg;
+		tsdata->tdata_offset = 3 - tsdata->tdata_reg;
 		tsdata->point_len = 6;
 		crclen = 0;
 	}
@@ -1244,6 +1245,7 @@ int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	tsdata->max_support_points = chip_data->max_support_points;
 	tsdata->boot = chip_data->boot;
+	tsdata->tdata_reg = chip_data->tdata_reg;
 
 	tsdata->vcc = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(tsdata->vcc))
diff --git a/drivers/input/touchscreen/edt-ft5x06.h b/drivers/input/touchscreen/edt-ft5x06.h
index 7eaeb562d11f..c55686e288b6 100644
--- a/drivers/input/touchscreen/edt-ft5x06.h
+++ b/drivers/input/touchscreen/edt-ft5x06.h
@@ -18,6 +18,7 @@ struct regmap;
 
 struct edt_ft5x06_chip_data {
 	int max_support_points;
+	u8 tdata_reg;
 	int (*boot)(struct device *dev, struct gpio_desc *reset_gpio);
 };
 
-- 
2.55.0

