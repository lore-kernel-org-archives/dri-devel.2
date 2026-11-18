Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE35606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OgChQQ+E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F0310EBBA;
	Wed, 18 Nov 2026 08:23:12 +0000 (UTC)
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com
 [203.205.221.209])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A4310E76F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1794989105; bh=M5wwNtcSwCCuFRaN/YHEyxRzLvnOw1K+Y8QAK1VYBD8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OgChQQ+EZlwPmEzuo5epdjIIrNljxvt7jfvr81T47lId5Sangjm0b4GRIGDp/oJLn
 SUEOWq1lfxfXYuM6d1fuRnJblCdSjK8azy7waKFxA6RMnAKjW7V0XhREREP1ePGovw
 xDSPjgvObCh9tnnJH2QQ8H7nONJwHBsXAqXa/UDs=
Received: from pjhArchLinux ([211.64.159.150])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id EC246C4; Wed, 18 Nov 2026 16:03:44 +0800
X-QQ-mid: xmsmtpt1794989032tx457084f
Message-ID: <tencent_4499382AA896319EAA2244D239B92371C207@qq.com>
X-QQ-XMAILINFO: MyKs8SpF7LAKeRlN6cKFdiafOdbzJ0bIKZEuspZ7xi9mVE1oSHypzpEUSfT/CN
 d1YEzyfK4T9NR1Eksl3fW+Kt8nVnIGBhK9ubi6FvZjTy2X0+b1ONwxWsFjCJA7l9ejpJVS0cYZ9s
 hCbqTZoq3E9ek1Io3pUXjfoyPsXDi3pgsHaGC/IMBjq+HHjPRv73gyHjShaqwXMQXRpFHXq/I6tN
 qald2hM3KwM9ek3FE1d1CtOfam4V5uPB0PWf1tADu6YsS1ywrlnnsr3rluCf1Z/hOpjyz06nwn9R
 7RusWEqyO0CjcYcumPQ4srS1g9gi/16J7zqLED7afZaLsXDU4h0d5LbCwnxYcYBbpGLwHx9ZRA0N
 ncZ90oLuVTVZivwPggnmP2TaojphOrO7xstkAm2wNfYI4lh/OB91tONmEXDTE//q8TcsmREVvWU2
 l8bzUmNgS76Yj27VplM3UvmpMjWwaYWyTo5pddlhKJ/ZGozUjhTN0bL3Mscx2sBK7UurmBPmOFqk
 oCJERne0BMFQOe+q3HPnlZcCixctOUx8nK84RqekW9ayjXfdZn83mNJwypSfonLYJ+Q795E2gJuy
 uqE2BAhFX1uURr6L4BwA5Q08wr4hdlJUdiYa+C+GQkHEpMSt/i0JouQelxtAUuZcRC1XH6pEYZfb
 nh9QzzZwjX910RgeQbuyBjoQgKgkLAe4UE1UijJyv0bxwcQBqfBxwQRuJhteDZiEx0wkpaUw1K9G
 MTVp9cQek6JDa+J0cNMMX+KVBEpGKVhEpCrACQ6LthY0bhJIHbUiy5wfOLxuLtBV/aPpCOgaW4Aa
 MwrGlwf6DzAjK7T9fjDRF/s1WCPJBCLS8mp3fR+nfjfrSloOJrBLudKO5wVwgxNKwrl7ktRm6JLL
 yYb9avxqbC936f7S1mFU6MybJjeRBjJagBxoZqlJoWmQTUpEQsaTmJjMrdM67ZnEyldihYEXKDYa
 rOE6lM+9GQW8RlAa77aDkL8uJgV/6ySIgr6gQP9CMSqtgj4bK5icBjzNxVTmIKjraL6RpfENDkda
 Q2Fow2UGvW5+uZnDCWI0cdq+szpKJ+GMTrmqdNHBSunmD6ja5RR4r6css8orI+I71VA/dKq6mrku
 s+xp3KNRcw975ya/t3gt4CJWLBfhDlD6+qEZ44
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: pjh456 <147148383@qq.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 2/2] drm/panel: ilitek-ili9881c: add Industio Purple Pi OH
 panel
Date: Wed, 18 Nov 2026 16:03:38 +0800
X-OQ-MSGID: <20261118080338.523572-3-147148383@qq.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118080338.523572-1-147148383@qq.com>
References: <20261118080338.523572-1-147148383@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the 7-inch 800x1280 MIPI-DSI panel found on the Industio
Purple Pi OH (RK3566).  It is a 4-lane ILI9881C panel whose
initialisation sequence was taken from the vendor device tree.  The
module is marked ZC-700010BH and the vendor DTB only describes it as a
generic "simple-panel-dsi", so the init sequence is its only
provenance.

The existing am8001280g entry (another 7-inch 800x1280 ILI9881C panel)
was tested on this hardware and only lights the backlight without a
picture, so a dedicated entry with the vendor sequence is required.

The panel is reset through GPIO0_D6 and its backlight is driven by
PWM4.

The init sequence was mechanically converted from the vendor device
tree's panel-init-sequence property with the help of an AI coding
assistant; the resulting driver was reviewed and tested on hardware by
the submitter.

Assisted-by: DeepSeek:deepseek-v4.1-flash
Assisted-by: Qwen:Qwen3.8-Flash-Next
Signed-off-by: pjh456 <147148383@qq.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 222 ++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 7bf38e96678a..5f1270d78082 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -1424,6 +1424,201 @@ static const struct ili9881c_instr am8001280g_init[] = {
 	ILI9881C_COMMAND_INSTR(MIPI_DCS_WRITE_POWER_SAVE, 0x00),
 };
 
+static const struct ili9881c_instr ppoh_init[] = {
+	ILI9881C_SWITCH_PAGE_INSTR(0x03),
+	ILI9881C_COMMAND_INSTR(0x01, 0x00),
+	ILI9881C_COMMAND_INSTR(0x02, 0x00),
+	ILI9881C_COMMAND_INSTR(0x03, 0x73),
+	ILI9881C_COMMAND_INSTR(0x04, 0x13),
+	ILI9881C_COMMAND_INSTR(0x05, 0x00),
+	ILI9881C_COMMAND_INSTR(0x06, 0x0a),
+	ILI9881C_COMMAND_INSTR(0x07, 0x05),
+	ILI9881C_COMMAND_INSTR(0x08, 0x00),
+	ILI9881C_COMMAND_INSTR(0x09, 0x28),
+	ILI9881C_COMMAND_INSTR(0x0a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0d, 0x28),
+	ILI9881C_COMMAND_INSTR(0x0e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0f, 0x28),
+	ILI9881C_COMMAND_INSTR(0x10, 0x28),
+	ILI9881C_COMMAND_INSTR(0x11, 0x00),
+	ILI9881C_COMMAND_INSTR(0x12, 0x00),
+	ILI9881C_COMMAND_INSTR(0x13, 0x00),
+	ILI9881C_COMMAND_INSTR(0x14, 0x00),
+	ILI9881C_COMMAND_INSTR(0x15, 0x00),
+	ILI9881C_COMMAND_INSTR(0x16, 0x00),
+	ILI9881C_COMMAND_INSTR(0x17, 0x00),
+	ILI9881C_COMMAND_INSTR(0x18, 0x00),
+	ILI9881C_COMMAND_INSTR(0x19, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1e, 0x40),
+	ILI9881C_COMMAND_INSTR(0x1f, 0x80),
+	ILI9881C_COMMAND_INSTR(0x20, 0x06),
+	ILI9881C_COMMAND_INSTR(0x21, 0x01),
+	ILI9881C_COMMAND_INSTR(0x22, 0x00),
+	ILI9881C_COMMAND_INSTR(0x23, 0x00),
+	ILI9881C_COMMAND_INSTR(0x24, 0x00),
+	ILI9881C_COMMAND_INSTR(0x25, 0x00),
+	ILI9881C_COMMAND_INSTR(0x26, 0x00),
+	ILI9881C_COMMAND_INSTR(0x27, 0x00),
+	ILI9881C_COMMAND_INSTR(0x28, 0x33),
+	ILI9881C_COMMAND_INSTR(0x29, 0x33),
+	ILI9881C_COMMAND_INSTR(0x2a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2c, 0x04),
+	ILI9881C_COMMAND_INSTR(0x2d, 0x04),
+	ILI9881C_COMMAND_INSTR(0x2e, 0x05),
+	ILI9881C_COMMAND_INSTR(0x2f, 0x05),
+	ILI9881C_COMMAND_INSTR(0x30, 0x00),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0x32, 0x31),
+	ILI9881C_COMMAND_INSTR(0x33, 0x00),
+	ILI9881C_COMMAND_INSTR(0x34, 0x00),
+	ILI9881C_COMMAND_INSTR(0x35, 0x0a),
+	ILI9881C_COMMAND_INSTR(0x36, 0x00),
+	ILI9881C_COMMAND_INSTR(0x37, 0x08),
+	ILI9881C_COMMAND_INSTR(0x38, 0x00),
+	ILI9881C_COMMAND_INSTR(0x39, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3f, 0x00),
+	ILI9881C_COMMAND_INSTR(0x40, 0x00),
+	ILI9881C_COMMAND_INSTR(0x41, 0x00),
+	ILI9881C_COMMAND_INSTR(0x42, 0x00),
+	ILI9881C_COMMAND_INSTR(0x43, 0x08),
+	ILI9881C_COMMAND_INSTR(0x44, 0x00),
+	ILI9881C_COMMAND_INSTR(0x50, 0x01),
+	ILI9881C_COMMAND_INSTR(0x51, 0x23),
+	ILI9881C_COMMAND_INSTR(0x52, 0x44),
+	ILI9881C_COMMAND_INSTR(0x53, 0x67),
+	ILI9881C_COMMAND_INSTR(0x54, 0x89),
+	ILI9881C_COMMAND_INSTR(0x55, 0xab),
+	ILI9881C_COMMAND_INSTR(0x56, 0x01),
+	ILI9881C_COMMAND_INSTR(0x57, 0x23),
+	ILI9881C_COMMAND_INSTR(0x58, 0x45),
+	ILI9881C_COMMAND_INSTR(0x59, 0x67),
+	ILI9881C_COMMAND_INSTR(0x5a, 0x89),
+	ILI9881C_COMMAND_INSTR(0x5b, 0xab),
+	ILI9881C_COMMAND_INSTR(0x5c, 0xcd),
+	ILI9881C_COMMAND_INSTR(0x5d, 0xef),
+	ILI9881C_COMMAND_INSTR(0x5e, 0x11),
+	ILI9881C_COMMAND_INSTR(0x5f, 0x02),
+	ILI9881C_COMMAND_INSTR(0x60, 0x08),
+	ILI9881C_COMMAND_INSTR(0x61, 0x0e),
+	ILI9881C_COMMAND_INSTR(0x62, 0x0f),
+	ILI9881C_COMMAND_INSTR(0x63, 0x0c),
+	ILI9881C_COMMAND_INSTR(0x64, 0x0d),
+	ILI9881C_COMMAND_INSTR(0x65, 0x17),
+	ILI9881C_COMMAND_INSTR(0x66, 0x01),
+	ILI9881C_COMMAND_INSTR(0x67, 0x01),
+	ILI9881C_COMMAND_INSTR(0x68, 0x02),
+	ILI9881C_COMMAND_INSTR(0x69, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x6b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x6c, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6d, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6e, 0x16),
+	ILI9881C_COMMAND_INSTR(0x6f, 0x16),
+	ILI9881C_COMMAND_INSTR(0x70, 0x06),
+	ILI9881C_COMMAND_INSTR(0x71, 0x06),
+	ILI9881C_COMMAND_INSTR(0x72, 0x07),
+	ILI9881C_COMMAND_INSTR(0x73, 0x07),
+	ILI9881C_COMMAND_INSTR(0x74, 0x02),
+	ILI9881C_COMMAND_INSTR(0x75, 0x02),
+	ILI9881C_COMMAND_INSTR(0x76, 0x08),
+	ILI9881C_COMMAND_INSTR(0x77, 0x0e),
+	ILI9881C_COMMAND_INSTR(0x78, 0x0f),
+	ILI9881C_COMMAND_INSTR(0x79, 0x0c),
+	ILI9881C_COMMAND_INSTR(0x7a, 0x0d),
+	ILI9881C_COMMAND_INSTR(0x7b, 0x17),
+	ILI9881C_COMMAND_INSTR(0x7c, 0x01),
+	ILI9881C_COMMAND_INSTR(0x7d, 0x01),
+	ILI9881C_COMMAND_INSTR(0x7e, 0x02),
+	ILI9881C_COMMAND_INSTR(0x7f, 0x02),
+	ILI9881C_COMMAND_INSTR(0x80, 0x00),
+	ILI9881C_COMMAND_INSTR(0x81, 0x00),
+	ILI9881C_COMMAND_INSTR(0x82, 0x02),
+	ILI9881C_COMMAND_INSTR(0x83, 0x02),
+	ILI9881C_COMMAND_INSTR(0x84, 0x16),
+	ILI9881C_COMMAND_INSTR(0x85, 0x16),
+	ILI9881C_COMMAND_INSTR(0x86, 0x06),
+	ILI9881C_COMMAND_INSTR(0x87, 0x06),
+	ILI9881C_COMMAND_INSTR(0x88, 0x07),
+	ILI9881C_COMMAND_INSTR(0x89, 0x07),
+	ILI9881C_COMMAND_INSTR(0x8a, 0x02),
+	ILI9881C_SWITCH_PAGE_INSTR(0x04),
+	ILI9881C_COMMAND_INSTR(0x6e, 0x1a),
+	ILI9881C_COMMAND_INSTR(0x6f, 0x37),
+	ILI9881C_COMMAND_INSTR(0x3a, 0xa4),
+	ILI9881C_COMMAND_INSTR(0x8d, 0x1f),
+	ILI9881C_COMMAND_INSTR(0x87, 0xba),
+	ILI9881C_COMMAND_INSTR(0xb2, 0xd1),
+	ILI9881C_COMMAND_INSTR(0x88, 0x0b),
+	ILI9881C_COMMAND_INSTR(0x38, 0x01),
+	ILI9881C_COMMAND_INSTR(0x39, 0x00),
+	ILI9881C_COMMAND_INSTR(0xb5, 0x02),
+	ILI9881C_COMMAND_INSTR(0x31, 0x25),
+	ILI9881C_COMMAND_INSTR(0x3b, 0x98),
+	ILI9881C_SWITCH_PAGE_INSTR(0x01),
+	ILI9881C_COMMAND_INSTR(0x22, 0x0a),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0x53, 0x5a),
+	ILI9881C_COMMAND_INSTR(0x55, 0x3d),
+	ILI9881C_COMMAND_INSTR(0x50, 0x9e),
+	ILI9881C_COMMAND_INSTR(0x51, 0x99),
+	ILI9881C_COMMAND_INSTR(0x60, 0x06),
+	ILI9881C_COMMAND_INSTR(0x62, 0x20),
+	ILI9881C_COMMAND_INSTR(0xa0, 0x00),
+	ILI9881C_COMMAND_INSTR(0xa1, 0x17),
+	ILI9881C_COMMAND_INSTR(0xa2, 0x26),
+	ILI9881C_COMMAND_INSTR(0xa3, 0x13),
+	ILI9881C_COMMAND_INSTR(0xa4, 0x16),
+	ILI9881C_COMMAND_INSTR(0xa5, 0x29),
+	ILI9881C_COMMAND_INSTR(0xa6, 0x1e),
+	ILI9881C_COMMAND_INSTR(0xa7, 0x1f),
+	ILI9881C_COMMAND_INSTR(0xa8, 0x8b),
+	ILI9881C_COMMAND_INSTR(0xa9, 0x1d),
+	ILI9881C_COMMAND_INSTR(0xaa, 0x2a),
+	ILI9881C_COMMAND_INSTR(0xab, 0x7b),
+	ILI9881C_COMMAND_INSTR(0xac, 0x1a),
+	ILI9881C_COMMAND_INSTR(0xad, 0x19),
+	ILI9881C_COMMAND_INSTR(0xae, 0x4e),
+	ILI9881C_COMMAND_INSTR(0xaf, 0x24),
+	ILI9881C_COMMAND_INSTR(0xb0, 0x29),
+	ILI9881C_COMMAND_INSTR(0xb1, 0x4f),
+	ILI9881C_COMMAND_INSTR(0xb2, 0x5c),
+	ILI9881C_COMMAND_INSTR(0xb3, 0x23),
+	ILI9881C_COMMAND_INSTR(0xc0, 0x00),
+	ILI9881C_COMMAND_INSTR(0xc1, 0x17),
+	ILI9881C_COMMAND_INSTR(0xc2, 0x26),
+	ILI9881C_COMMAND_INSTR(0xc3, 0x13),
+	ILI9881C_COMMAND_INSTR(0xc4, 0x16),
+	ILI9881C_COMMAND_INSTR(0xc5, 0x29),
+	ILI9881C_COMMAND_INSTR(0xc6, 0x1e),
+	ILI9881C_COMMAND_INSTR(0xc7, 0x1f),
+	ILI9881C_COMMAND_INSTR(0xc8, 0x8b),
+	ILI9881C_COMMAND_INSTR(0xc9, 0x1d),
+	ILI9881C_COMMAND_INSTR(0xca, 0x2a),
+	ILI9881C_COMMAND_INSTR(0xcb, 0x7b),
+	ILI9881C_COMMAND_INSTR(0xcc, 0x1a),
+	ILI9881C_COMMAND_INSTR(0xcd, 0x19),
+	ILI9881C_COMMAND_INSTR(0xce, 0x4e),
+	ILI9881C_COMMAND_INSTR(0xcf, 0x24),
+	ILI9881C_COMMAND_INSTR(0xd0, 0x29),
+	ILI9881C_COMMAND_INSTR(0xd1, 0x4f),
+	ILI9881C_COMMAND_INSTR(0xd2, 0x5c),
+	ILI9881C_COMMAND_INSTR(0xd3, 0x23),
+	ILI9881C_SWITCH_PAGE_INSTR(0x00),
+	ILI9881C_COMMAND_INSTR(0x35, 0x00),
+};
+
 static const struct ili9881c_instr rpi_5inch_init[] = {
 	ILI9881C_SWITCH_PAGE_INSTR(3),
 	ILI9881C_COMMAND_INSTR(0x01, 0x00),
@@ -2425,6 +2620,23 @@ static const struct drm_display_mode am8001280g_default_mode = {
 	.height_mm	= 151,
 };
 
+static const struct drm_display_mode ppoh_default_mode = {
+	.clock		= 73400,
+
+	.hdisplay	= 800,
+	.hsync_start	= 800 + 52,
+	.hsync_end	= 800 + 52 + 4,
+	.htotal		= 800 + 52 + 4 + 12,
+
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 60,
+	.vsync_end	= 1280 + 60 + 18,
+	.vtotal		= 1280 + 60 + 18 + 50,
+
+	.width_mm	= 94,
+	.height_mm	= 151,
+};
+
 static const struct drm_display_mode rpi_5inch_default_mode = {
 	.clock		= 83333,
 
@@ -2664,6 +2876,15 @@ static const struct ili9881c_desc am8001280g_desc = {
 		      MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM,
 };
 
+static const struct ili9881c_desc ppoh_desc = {
+	.init = ppoh_init,
+	.init_length = ARRAY_SIZE(ppoh_init),
+	.mode = &ppoh_default_mode,
+	.lanes = 4,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+		      MIPI_DSI_MODE_NO_EOT_PACKET | MIPI_DSI_MODE_LPM,
+};
+
 static const struct ili9881c_desc rpi_5inch_desc = {
 	.init = rpi_5inch_init,
 	.init_length = ARRAY_SIZE(rpi_5inch_init),
@@ -2708,6 +2929,7 @@ static const struct of_device_id ili9881c_of_match[] = {
 	{ .compatible = "wanchanglong,w552946aba", .data = &w552946aba_desc },
 	{ .compatible = "waveshare,7.0-dsi-touch-a", .data = &waveshare_7inch_a_desc },
 	{ .compatible = "ampire,am8001280g", .data = &am8001280g_desc },
+	{ .compatible = "industio,purple-pi-oh-panel", .data = &ppoh_desc },
 	{ .compatible = "raspberrypi,dsi-5inch", &rpi_5inch_desc },
 	{ .compatible = "raspberrypi,dsi-7inch", &rpi_7inch_desc },
 	{ }
-- 
2.56.1

