Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB4606A338
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jU+F7Kaa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF91710FC76;
	Wed, 11 Nov 2026 16:22:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5566910FC70
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:22:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E953477A7;
 Wed, 11 Nov 2026 16:22:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794414162;
 b=Wc1827rM0dE6gqjVcU5W0JlEUv8F0VWRlE/5bM8vtX0lIyURQITLJoNO56RBW7lJoul6
 AWt04WfZckpTuQJbN6kQY3jIfqXXOkmLPFh6ayYQjKp55WH6fyhfHc9w4DvXS/S33cTBN
 RnCb0T7bZTHwxZZIO+GwAOMw3MfejTlZruBtr61O2mLR4Blw1XcFhdXorZW76EDhGUOVc
 dYToIPTvLvEUYQVcD1uB8w48TssCNjrZqnCqFUMhF4juiTMAF8XkuFuMYpHHEzrDfmnv6
 9Zg0gOGsTUOtrkbj9qlwuo+CaOopfdVxu5TwGLv6bh6hZRGiLidlaPsfVZgQEK/sjGg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794414162;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=KLNhZsOZO6tTwWVA3EvqxE7uAVIt4SVNmhY1DO4o9K8=;
 b=XE2gK+yliRaOvS3BJXGc99zEuLDoCzt2hnx0QNMYb+EzZSvZbemEW+dRtJ6tdZChRcun
 vpo6+7a0DR5grPcldfAAO/uKW73hWFjvi3hropPBL6gspyGBruUwkniqhS/S8JIuHWswc
 qICb9b9dhH162brJG3AR8tDO6fTmJwDLs4+sH6q5CjZ8nRldeLi1wlBHcLMg8wf+Myq2U
 JzUVpxq4WxHmEwDzFq9lqgl27w+KrvfuRlbhbJwOXCDNhAp4AoyMTDFyFsQo56xEeDV2i
 GgB2Fq4ZfOo+ljcg624j3C/y32Uiu/mmNj4mjZdxaLH/BVzuVGV0ecIhYaY74I4+bTw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4EAEE1F00A08;
 Wed, 11 Nov 2026 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794414162;
 bh=KLNhZsOZO6tTwWVA3EvqxE7uAVIt4SVNmhY1DO4o9K8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=jU+F7KaaRh7E+Cv8AFgcL11n55WHRcQyTjVzt9KhFCxztvLncfpQC2a+q49Z21F2B
 HQCRUsYAMOfg84P+hkEQHPKm9Ws7G5ikIb6vSFZOnIz8agCoiHoKH00d3F5fdcfYE/
 mTXpNplWKNHst9zFmGsJQ3ZwzWwPwzCrjnwgil6rGWlqankG7/II+EP0rJfWsXtVXs
 HJlQmPiRfkTMsT7hGTzQNUBC488mTLo04JvNXXsqUmJsC+Pl/feo9ZjPe1/Whzra5R
 PVpe8UE0UjSH6NndP91xHnAotjObGY+1QiOuN3zeDsiYyGCodOiRoAJGtIGgVT//X8
 NsAbtpvFgnG1w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CEE3549037;
 Wed, 11 Nov 2026 16:22:40 +0000 (UTC)
From: Michiel van Beers via B4 Relay
 <devnull+michielvanbeers.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 17:21:42 +0100
Subject: [PATCH v2 2/2] backlight: lm3630a: Allow setting the full-scale
 current per bank
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-lm3630a-led-max-microamp-v2-2-aff11756e7be@gmail.com>
References: <20261111-lm3630a-led-max-microamp-v2-0-aff11756e7be@gmail.com>
In-Reply-To: <20261111-lm3630a-led-max-microamp-v2-0-aff11756e7be@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Michiel van Beers <michielvanbeers@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794414160; l=4765;
 i=michielvanbeers@gmail.com; s=20261107; h=from:subject:message-id;
 bh=YrzYv6G6kHsv+ddU+T8TW/TH8CUbRepEUJYvTRcaRMI=;
 b=JVfzfKGbjd7roYgiWd7DpAOH1JdyHKa09w8DtY57g5BGiqeHo0T4K+KllY8o3TX+XGepDjRSV
 ultsVhs2ntNDpOEr2bfDmLKeRGCaBKVCyz7Khhxji248h3hmSyWNWjy
X-Developer-Key: i=michielvanbeers@gmail.com; a=ed25519;
 pk=C+lOje7u3+2x3o2NLMXrwz2veP2++eXfIi9MtYsUo4k=
X-Endpoint-Received: by B4 Relay for michielvanbeers@gmail.com/20261107
 with auth_id=1444
X-Original-From: Michiel van Beers <michielvanbeers@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: michielvanbeers@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michiel van Beers <michielvanbeers@gmail.com>

The driver always programs the full-scale current of both control banks
to the maximum of 28.25 mA (code 0x1F). Boards whose LED strings are
rated for less have no way to lower it.

Read the optional led-max-microamp property of each led@ node and
program the full-scale current register of that bank with the matching
code, I_FS = 5 mA + code * 0.75 mA (datasheet SNVS974B, 7.3.1.11). The
code is rounded down, so the current never exceeds the requested value.
Values outside 5000 to 28250 uA are rejected with -EINVAL.

Without the property the driver still programs 0x1F, so existing boards
are unaffected.

Signed-off-by: Michiel van Beers <michielvanbeers@gmail.com>
---
checkpatch --strict reports errors on the two new kernel-doc lines in
lm3630a_bl.h; the hunk does not include the comment delimiters. With
-U15 it is clean.
---
 drivers/video/backlight/lm3630a_bl.c     | 40 ++++++++++++++++++++++++++++----
 include/linux/platform_data/lm3630a_bl.h |  4 ++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 8ef8163c7fef..1189011bb89d 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -80,6 +80,25 @@ static int lm3630a_update(struct lm3630a_chip *pchip,
 	return regmap_update_bits(pchip->regmap, reg, mask, data);
 }
 
+/*
+ * Full-scale current register code: I = 5 mA + code * 0.75 mA, code 0..31
+ * (datasheet SNVS974B, 7.3.1.11). Rounds down, so the result never exceeds
+ * the requested current. 0 means "not set" and keeps the chip default 0x1F.
+ */
+#define LM3630A_FS_CURRENT_MIN_UA	5000
+#define LM3630A_FS_CURRENT_STEP_UA	750
+#define LM3630A_FS_CURRENT_MAX_UA	28250
+#define LM3630A_FS_CURRENT_MAX_CODE	0x1F
+
+static unsigned int lm3630a_fs_current_code(unsigned int microamp)
+{
+	if (!microamp)
+		return LM3630A_FS_CURRENT_MAX_CODE;
+
+	return (microamp - LM3630A_FS_CURRENT_MIN_UA) /
+	       LM3630A_FS_CURRENT_STEP_UA;
+}
+
 /* initialize chip */
 static int lm3630a_chip_init(struct lm3630a_chip *pchip)
 {
@@ -93,10 +112,12 @@ static int lm3630a_chip_init(struct lm3630a_chip *pchip)
 	rval |= lm3630a_update(pchip, REG_CONFIG, 0x07, pdata->pwm_ctrl);
 	/* set boost control */
 	rval |= lm3630a_write(pchip, REG_BOOST, 0x38);
-	/* set current A */
-	rval |= lm3630a_update(pchip, REG_I_A, 0x1F, 0x1F);
-	/* set current B */
-	rval |= lm3630a_write(pchip, REG_I_B, 0x1F);
+	/* set full-scale current A */
+	rval |= lm3630a_update(pchip, REG_I_A, 0x1F,
+			lm3630a_fs_current_code(pdata->leda_max_microamp));
+	/* set full-scale current B */
+	rval |= lm3630a_write(pchip, REG_I_B,
+			lm3630a_fs_current_code(pdata->ledb_max_microamp));
 	/* set control */
 	rval |= lm3630a_update(pchip, REG_CTRL, 0x14, pdata->leda_ctrl);
 	rval |= lm3630a_update(pchip, REG_CTRL, 0x0B, pdata->ledb_ctrl);
@@ -472,6 +493,17 @@ static int lm3630a_parse_bank(struct lm3630a_platform_data *pdata,
 			pdata->leda_max_brt = val;
 	}
 
+	ret = fwnode_property_read_u32(node, "led-max-microamp", &val);
+	if (!ret) {
+		if (val < LM3630A_FS_CURRENT_MIN_UA ||
+		    val > LM3630A_FS_CURRENT_MAX_UA)
+			return -EINVAL;
+		if (bank)
+			pdata->ledb_max_microamp = val;
+		else
+			pdata->leda_max_microamp = val;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/platform_data/lm3630a_bl.h b/include/linux/platform_data/lm3630a_bl.h
index 530be9318711..43383c476c09 100644
--- a/include/linux/platform_data/lm3630a_bl.h
+++ b/include/linux/platform_data/lm3630a_bl.h
@@ -37,10 +37,12 @@ enum lm3630a_ledb_ctrl {
  *@leda_label    : optional led a label.
  *@leda_init_brt : led a init brightness. 4~255
  *@leda_max_brt  : led a max brightness.  4~255
+ *@leda_max_microamp : led a full-scale current, 5000~28250 uA (0: default)
  *@leda_ctrl     : led a disable, enable linear, enable exponential
  *@ledb_label    : optional led b label.
  *@ledb_init_brt : led b init brightness. 4~255
  *@ledb_max_brt  : led b max brightness.  4~255
+ *@ledb_max_microamp : led b full-scale current, 5000~28250 uA (0: default)
  *@ledb_ctrl     : led b disable, enable linear, enable exponential
  *@pwm_period    : pwm period
  *@pwm_ctrl      : pwm disable, bank a or b, active high or low
@@ -51,11 +53,13 @@ struct lm3630a_platform_data {
 	const char *leda_label;
 	int leda_init_brt;
 	int leda_max_brt;
+	unsigned int leda_max_microamp;
 	enum lm3630a_leda_ctrl leda_ctrl;
 	/* led b config. */
 	const char *ledb_label;
 	int ledb_init_brt;
 	int ledb_max_brt;
+	unsigned int ledb_max_microamp;
 	enum lm3630a_ledb_ctrl ledb_ctrl;
 	/* pwm config. */
 	unsigned int pwm_period;

-- 
2.43.0


