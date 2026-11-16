Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B58606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RkBITuQi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64EC010F24F;
	Mon, 16 Nov 2026 15:11:10 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5222710E409
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:10:46 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6b757029223so4361228a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794841844; x=1795446644; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/0T454X8zS9zgz5ElLHh1sft/p08/5DBKrLhd6S46iM=;
 b=RkBITuQilOP76Pfy/7nlvyBa0plwLcKCaH2SJfezdn3HZQXGj+2+LJZJQecwyF6HgD
 zTK9y8K54tG0x8MHstOFJEBfjyEBMaV+5pVK8SsLFNpeHk209dhXTaJCrf5rNkPKZ5y9
 DJawNpw/5042UIumLj/HDC0JfzZ26KZUunykA5DvhxaMJL/eVmBJcofyv47ClTQefokC
 5rq0+ml7Mkdw915E0oyNSi4U3AM8962PvhMRNYj2L/aihGm56OGbTCHBkwE/pCdE9GDa
 xlT6G8j6USPAN/GF3duFV/dJ/3PKrxB/8KfMSK0btv3/AT43oT3CpeoQTcZcLUWhVpMO
 syCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841844; x=1795446644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/0T454X8zS9zgz5ElLHh1sft/p08/5DBKrLhd6S46iM=;
 b=AaNvlIMGUtHRHpJE2mlwbhMQbIHyoSuzoRZ5MCQN08aP66ul7eJV8gHSUGku8ltId4
 SzJglNidef3iVFRbHyXBStnI0ZwmqrDZqeOpKhZWluMrgoArrpqUW0YFZhSEzlMQ8Qha
 UwJb5k1Wew1SjBPFcoLJfsCznfwNwvhFFPQsQLb0cLtDQt6WC1g8/sVW24ZoDjDB7IdL
 dP5dG4lJXrhd63+s9UUI7AuCzQ+fTPak8q0SBRJS/6tM7hCL63ktur36aZilDadScA25
 ab4rbL+cBKI2IzuXbqxjExVsTUdIyyMFghi1hQOjQBpmLs/+ZfRPD6iVeLMPvxNCP1oq
 uaIw==
X-Gm-Message-State: APuU4Z8ynYu8ZJMlgP0bh2KLHJrJ0hTzvKMV9qqRlT7xg7GjxJVzWNjX
 Qo4U9v4mrUf1+ysuMOqCUsMvUIsZaXv8RhnhWCzkAfQH4rxyTutlY8qf
X-Gm-Gg: AYBFou0y3UNWtqJAJKN2LoyOUCvEaWXSvElbVFwLamnAKqc90ZZ7AGk1yjRXdI3Fkis
 9Ryzq7+FetmJgfmBRsXr6t19vh00BDkEm5/94q0oM4FJfKJ6nbkrIuURTSOweWwcopbw07KBXly
 U5X7fUJc1fTmnyctXGqA+i4sj/FDDn5bML/+mJPhhiyd/RsEQ+gTZH29u2YLKP/O7Up052QSQFu
 LSjVkWKKjJy4+qOZSSvdD5kGs6PI+rcG+7i0QaaPjjB4z0AMKsKK117AdzpEIGxTqPKVqMVqT2l
 omXiKMsSIgf7mIAJcMvSBR3009yoHlL/f40b9HvjCniNUX1f7S7sk4h1Bz66Piic+NnHW4qAzUX
 m4yhOzawQExYAxrmJ49XCluG3VbgYf29wqMxhibEkfAdhSXdX+vAylyQOkbKDmwjR6skYRnQP9k
 NtdxIBCtrHczsaHbGvVIG86IquW05/7uKgwAcoc9wVYlzSBsd/73YOqlVv6QubwUnkLYvYVz5Hk
 9SZL2AZUiHbc+zaZeJgrOwsy0w9Rc/Qxoos9hqwz+Ua1XJKIRtnSF1XbGaloWgFrJw/Sn8YSxpP
 wI9hYm/TDHwWnG184un8aBarh/nptBw3tsLqmdCNa543CFhQ8XYZj4QG8sOUcbUxFV6y98jIto8
 m7GoRT5JpGQ==
X-Received: by 2002:a17:907:c13:b0:c29:f5d5:5a97 with SMTP id
 a640c23a62f3a-c5096442d6bmr855991066b.33.1794841844356; 
 Mon, 16 Nov 2026 07:10:44 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b93a85sm420868466b.84.2026.11.16.07.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:10:43 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/12] drm/tegra: dc: Add elements required by Tegra MIPI
 DBI
Date: Mon, 16 Nov 2026 17:10:11 +0200
Message-ID: <20261116151017.274764-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116151017.274764-1-clamor95@gmail.com>
References: <20261116151017.274764-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add DC register definitions with additional fields in preparation for
adding the 8-bit CPU interface (MIPI DBI).

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/dc.h | 194 ++++++++++++++++++++++++++++++++++---
 1 file changed, 183 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 0cb0515968b35..e8913c5530a2d 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -272,14 +272,150 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define  DC_COM_CRC_CONTROL_WAIT (1 << 1)
 #define  DC_COM_CRC_CONTROL_ENABLE (1 << 0)
 #define DC_COM_CRC_CHECKSUM			0x301
-#define DC_COM_PIN_OUTPUT_ENABLE(x) (0x302 + (x))
-#define DC_COM_PIN_OUTPUT_POLARITY(x) (0x306 + (x))
-#define LVS_OUTPUT_POLARITY_LOW (1 << 28)
-#define LHS_OUTPUT_POLARITY_LOW (1 << 30)
-#define DC_COM_PIN_OUTPUT_DATA(x) (0x30a + (x))
-#define DC_COM_PIN_INPUT_ENABLE(x) (0x30e + (x))
-#define DC_COM_PIN_INPUT_DATA(x) (0x312 + (x))
-#define DC_COM_PIN_OUTPUT_SELECT(x) (0x314 + (x))
+
+#define DC_COM_PIN_OUTPUT_ENABLE(x)		(0x302 + (x))
+#define DC_COM_PIN_OUTPUT_POLARITY(x)		(0x306 + (x))
+#define LVS_OUTPUT_POLARITY_LOW			BIT(28)
+#define LHS_OUTPUT_POLARITY_LOW			BIT(30)
+#define DC_COM_PIN_OUTPUT_DATA(x)		(0x30a + (x))
+/* Pin unmask is 1 bit above position of the pin in the OUTPUT_DATA register */
+#define PIN_UNMASK(x)				BIT((x) + 1)
+#define DC_COM_PIN_INPUT_ENABLE(x)		(0x30e + (x))
+
+/*
+ * The definitions below describe pin positions in the DC_COM_PIN_OUTPUT_ENABLE(x),
+ * DC_COM_PIN_OUTPUT_POLARITY(x), DC_COM_PIN_OUTPUT_DATA(x), and
+ * DC_COM_PIN_INPUT_ENABLE(x) registers. The comment before each group indicates
+ * the index of the register (the x value).
+ */
+
+/* 0 */
+#define PIN_LD0					0
+#define PIN_LD1					2
+#define PIN_LD2					4
+#define PIN_LD3					6
+#define PIN_LD4					8
+#define PIN_LD5					10
+#define PIN_LD6					12
+#define PIN_LD7					14
+#define PIN_LD8					16
+#define PIN_LD9					18
+#define PIN_LD10				20
+#define PIN_LD11				22
+#define PIN_LD12				24
+#define PIN_LD13				26
+#define PIN_LD14				28
+#define PIN_LD15				30
+
+/* 1 */
+#define PIN_LD16				0
+#define PIN_LD17				2
+#define PIN_LPW0				16
+#define PIN_LPW1				18
+#define PIN_LPW2				20
+#define PIN_LSC0				24
+#define PIN_LSC1				26
+#define PIN_LVS					28
+#define PIN_LHS					30
+
+/* 2 */
+#define PIN_LHP0				0
+#define PIN_LHP1				2
+#define PIN_LHP2				4
+#define PIN_LVP0				8
+#define PIN_LVP1				10
+#define PIN_LM0					16
+#define PIN_LM1					18
+#define PIN_LDI					20
+#define PIN_LPP					22
+
+/* 3 */
+#define PIN_LSCK				0
+#define PIN_LSDA				2
+#define PIN_LCSN				4
+#define PIN_LDC					6
+#define PIN_LSPI				8
+#define PIN_LSDI				10
+
+#define DC_COM_PIN_INPUT_DATA(x)		(0x312 + (x))
+
+/*
+ * DC_COM_PIN_OUTPUT_SELECT(x) is a set of 7 registers that allow selecting
+ * one of 7 functions for each pin using 3 bits. Clearing all bits sets
+ * the pin to its primary function, while setting them to 1 configures it
+ * as a GPIO output. Other functions are unique to each pin. For details,
+ * check "23.7.17 DC_COM_PIN_OUTPUT_SELECT0_0" in the Tegra30 TRM.
+ */
+#define DC_COM_PIN_OUTPUT_SELECT(x)		(0x314 + (x))
+#define PIN_OUTPUT_SELECT_MASK(x)		(0x7 << (x))
+#define PIN_OUTPUT_SELECT_PRIM(x)		(0 << (x))
+#define PIN_OUTPUT_SELECT_OUT(x)		(1 << (x))
+#define PIN_OUTPUT_SELECT_F2(x)			(2 << (x))
+#define PIN_OUTPUT_SELECT_F3(x)			(3 << (x))
+#define PIN_OUTPUT_SELECT_F4(x)			(4 << (x))
+#define PIN_OUTPUT_SELECT_F5(x)			(5 << (x))
+#define PIN_OUTPUT_SELECT_F6(x)			(6 << (x))
+#define PIN_OUTPUT_SELECT_F7(x)			(7 << (x))
+
+/*
+ * The definitions below describe pin offset in the DC_COM_PIN_OUTPUT_SELECT(x)
+ * registers. The comment before each group indicates the index of the register
+ * (the x value).
+ */
+
+/* 0 */
+#define PIN_OUTPUT_SELECT_LD0			0
+#define PIN_OUTPUT_SELECT_LD1			4
+#define PIN_OUTPUT_SELECT_LD2			8
+#define PIN_OUTPUT_SELECT_LD3			12
+#define PIN_OUTPUT_SELECT_LD4			16
+#define PIN_OUTPUT_SELECT_LD5			20
+#define PIN_OUTPUT_SELECT_LD6			24
+#define PIN_OUTPUT_SELECT_LD7			28
+
+/* 1 */
+#define PIN_OUTPUT_SELECT_LD8			0
+#define PIN_OUTPUT_SELECT_LD9			4
+#define PIN_OUTPUT_SELECT_LD10			8
+#define PIN_OUTPUT_SELECT_LD11			12
+#define PIN_OUTPUT_SELECT_LD12			16
+#define PIN_OUTPUT_SELECT_LD13			20
+#define PIN_OUTPUT_SELECT_LD14			24
+#define PIN_OUTPUT_SELECT_LD15			28
+
+/* 2 */
+#define PIN_OUTPUT_SELECT_LD16			0
+#define PIN_OUTPUT_SELECT_LD17			4
+
+/* 3 */
+#define PIN_OUTPUT_SELECT_LPW0			0
+#define PIN_OUTPUT_SELECT_LPW1			4
+#define PIN_OUTPUT_SELECT_LPW2			8
+#define PIN_OUTPUT_SELECT_LSC0			16
+#define PIN_OUTPUT_SELECT_LSC1			20
+#define PIN_OUTPUT_SELECT_LVS			24
+#define PIN_OUTPUT_SELECT_LHS			28
+
+/* 4 */
+#define PIN_OUTPUT_SELECT_LHP0			0
+#define PIN_OUTPUT_SELECT_LHP1			4
+#define PIN_OUTPUT_SELECT_LHP2			8
+#define PIN_OUTPUT_SELECT_LVP0			16
+#define PIN_OUTPUT_SELECT_LVP1			20
+
+/* 5 */
+#define PIN_OUTPUT_SELECT_LM0			0
+#define PIN_OUTPUT_SELECT_LM1			4
+#define PIN_OUTPUT_SELECT_LDI			8
+#define PIN_OUTPUT_SELECT_LPP			12
+
+/* 6 */
+#define PIN_OUTPUT_SELECT_LSCK			0
+#define PIN_OUTPUT_SELECT_LSDA			4
+#define PIN_OUTPUT_SELECT_LCSN			8
+#define PIN_OUTPUT_SELECT_LDC			12
+#define PIN_OUTPUT_SELECT_LSPI			16
+#define PIN_OUTPUT_SELECT_LSDI			20
 
 #define DC_COM_PIN_MISC_CONTROL			0x31b
 #define DC_COM_PIN_PM0_CONTROL			0x31c
@@ -303,9 +439,15 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define  UNDERFLOW_REPORT_ENABLE (1 << 0)
 
 #define DC_DISP_DISP_SIGNAL_OPTIONS0		0x400
-#define H_PULSE0_ENABLE (1 <<  8)
-#define H_PULSE1_ENABLE (1 << 10)
-#define H_PULSE2_ENABLE (1 << 12)
+#define H_PULSE0_ENABLE				BIT(8)
+#define H_PULSE1_ENABLE				BIT(10)
+#define H_PULSE2_ENABLE				BIT(12)
+#define V_PULSE0_ENABLE				BIT(16)
+#define V_PULSE1_ENABLE				BIT(18)
+#define V_PULSE2_ENABLE				BIT(19)
+#define V_PULSE3_ENABLE				BIT(20)
+#define M0_ENABLE				BIT(24)
+#define M1_ENABLE				BIT(26)
 
 #define DC_DISP_DISP_SIGNAL_OPTIONS1		0x401
 
@@ -456,6 +598,22 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_DISP_SHIFT_CLOCK_OPTIONS		0x431
 #define  SC1_H_QUALIFIER_NONE	(1 << 16)
 #define  SC0_H_QUALIFIER_NONE	(1 <<  0)
+#define  SC0_H_QUALIFIER(x)			(((x) & 0x7) <<  0)
+#define  SC1_H_QUALIFIER(x)			(((x) & 0x7) << 16)
+#define  SC_H_QUALIFIER_DISABLE			0
+#define  SC_H_QUALIFIER_NONE			1
+#define  SC_H_QUALIFIER_HACTIVE			2
+#define  SC_H_QUALIFIER_EXT_HACTIVE		3
+#define  SC_H_QUALIFIER_HPULSE			4
+#define  SC_H_QUALIFIER_EXT_HPULSE		5
+#define  SC0_V_QUALIFIER(x)			(((x) & 0x7) <<  3)
+#define  SC1_V_QUALIFIER(x)			(((x) & 0x7) <<  19)
+#define  SC_V_QUALIFIER_NONE			0
+#define  SC_V_QUALIFIER_RSVD			1
+#define  SC_V_QUALIFIER_VACTIVE			2
+#define  SC_V_QUALIFIER_EXT_VACTIVE		3
+#define  SC_V_QUALIFIER_VPULSE			4
+#define  SC_V_QUALIFIER_EXT_VPULSE		5
 
 #define DC_DISP_DATA_ENABLE_OPTIONS		0x432
 #define DE_SELECT_ACTIVE_BLANK  (0 << 0)
@@ -493,6 +651,20 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_DISP_CURSOR_POSITION_NS		0x441
 
 #define DC_DISP_INIT_SEQ_CONTROL		0x442
+#define SEND_INIT_SEQUENCE			BIT(0)
+#define INIT_SEQUENCE_MODE_SPI			BIT(1)
+#define INIT_SEQUENCE_MODE_PLCD			0
+#define INIT_SEQ_DC_SIGNAL_SHIFT		4
+#define INIT_SEQ_DC_SIGNAL_MASK			(0x7 << INIT_SEQ_DC_SIGNAL_SHIFT)
+#define NO_DC_SIGNAL				0
+#define DC_SIGNAL_VSYNC				1
+#define DC_SIGNAL_VPULSE0			2
+#define DC_SIGNAL_VPULSE1			3
+#define DC_SIGNAL_VPULSE2			4
+#define DC_SIGNAL_VPULSE3			5
+#define INIT_SEQ_DC_CONTROL_SHIFT		7
+#define FRAME_INIT_SEQ_CYCLES_SHIFT		8
+
 #define DC_DISP_SPI_INIT_SEQ_DATA_A		0x443
 #define DC_DISP_SPI_INIT_SEQ_DATA_B		0x444
 #define DC_DISP_SPI_INIT_SEQ_DATA_C		0x445
-- 
2.53.0

