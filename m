Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4844606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKjPme9F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F6891123DA;
	Thu, 29 Oct 2026 15:29:51 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A851123D3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:29:42 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c3fd91337baso394371466b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793287781; x=1793892581; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G14psYDKSHk+SyCF1SQKUJmEpjbErI6KqWDdekKYC9w=;
 b=FKjPme9F8aFBE/gxf3SJHgUp4Qxy3R3bZr4OD+3aF1Ch2S5Yu5vk3QvxHgmE3oCdah
 /Cx0nFt0bVgjA9B7Q3Xh/2P/2gL0IKECTCOjfXv0Ki2MZ7H1+XQEeQZDPsvvDm0rijK4
 btHP8MS+SnJGFYyDDHuWYcHWjs955PX3+rBuZKjRmY4Xe7k5YwaS56/xXgl0ZVgyE5gF
 ECbINDJIZ084GkWeMuzCiDvakIrIh+5cO0rRpf5PRadvh3E/WC48Vcu6xMl+iju4Sarx
 RiNCTie+iCiNWU3zcTrrhsxBx/emgpFj6gSv9S63V/6VthDXNnh2ArxAwEt8AgeRIzR0
 x2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287781; x=1793892581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G14psYDKSHk+SyCF1SQKUJmEpjbErI6KqWDdekKYC9w=;
 b=KezUnEnppdtSy9jTMM2vgQ5qAbtRdmSRJF5LLmrVrNVEhAnhUs3PzGbcnsHlNrP4+W
 ymOd/7AOsB7cxwbjzprZ1EZjL8R6pWukTvdqPqSeS96+PEyo11hFZ6yg3bYgUoJagxh5
 Bs/9KObRGHHMuOHgJGzdjb1RifQyuf2K1zZo6GIfssDghDT+x0JePMYAB2ORBVqB/Lxe
 06Al+wNx5FOdOZFSbltcalw9nwhAJe+TGCrTLrZgJNs+JASdh6EDEu3yYvi7vmmX5VWc
 /lN8Lz9dFHdJis72NCQBrBoG4pxiapYLu7IJ+qWlS4THMBaqWPX4sfVSNGWIyQAeyThl
 kg2g==
X-Gm-Message-State: AFq9FYIqEA8+YP5IM0/U4Gg3WASk82pKzZzEHN147YF7CZIQyoPHEmlW
 H6IM+VSSBCATHF7u0b7RKOzXMGpAE2IRlt4cWBpG5+kr03oQJeukT4PP
X-Gm-Gg: AYBFou0AdbVVHFnjh+G+V15469gpklL7VRKe0Vtm+FWnkGlRPTsk65XvzcO2CDJZk39
 gF+XW/xuezym36gEaJmzuMpaf992hFqyo+qtMrxfakzI4+T4U2SB4Sq4xXPQlNU2izzKFkYB1Yh
 EPROfqT8f2B07h186k2B1VqbNfe5YqBrbs+Bdxe+LFqTdm1O4HU9Y2SN1G2uEWdKmRe/PsZoWtr
 mx7Zv87rOceo+VeGxSXeXFr4k5eM2X6LvzWBsmwg9jxoZc/SPOMabUDO+N+umS4DaQXn6GqNBLz
 4r7T1M1TGKo+W7v3ZT77LHDicjmdt8nxgH/c3ranzGYtmOWxaLLz2Q/dOiqV3SWNNZei1iUg8CD
 /qn9irtVsVYClsFmdv4zWc3Z2m/ah4mcULY3dPjBS1r6MvYMEnqfwJ2OX3GLuJlbXdnQtWwkN1C
 fkbm01Rq2FGXEy8g3h3T2J4KmgFd7RRUIe30uQ/p6MPnhWe05b49tVbRwfoPuUc3C+U5pavXZ+6
 UAZKcw6lV+U8mQsp2ZslSRWxC00c4L+acOkcKTlUr6Dov5FPdaFppoqlZZ3WQlGXulvbZY/SkU1
 PILVp3E39pzrPeuF98ppu8DLwm4x1ZbGV9nbuN3pt4lUVqYein0S5u2sHQLswPR5l9RBNUU=
X-Received: by 2002:a17:907:86a4:b0:c46:9d7b:37d with SMTP id
 a640c23a62f3a-c49bdecee42mr519047666b.17.1793287779812; 
 Thu, 29 Oct 2026 08:29:39 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4ca27984f8sm1252166b.80.2026.10.29.08.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:29:39 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 05/11] drm/tegra: dc: Refactor and expand header
Date: Thu, 29 Oct 2026 17:29:03 +0200
Message-ID: <20261029152909.234584-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029152909.234584-1-clamor95@gmail.com>
References: <20261029152909.234584-1-clamor95@gmail.com>
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

Refactor and expand existing DC register definitions with additional
fields in preparation for adding the 8-bit CPU interface.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c  |  11 +-
 drivers/gpu/drm/tegra/dc.h  | 856 +++++++++++++++++++++---------------
 drivers/gpu/drm/tegra/rgb.c |   8 +-
 3 files changed, 514 insertions(+), 361 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index b0bfa946e6979..5bbf2c028edd8 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1591,10 +1591,10 @@ static const struct debugfs_reg32 tegra_dc_regs[] = {
 	DEBUGFS_REG32(DC_COM_PIN_OUTPUT_SELECT(5)),
 	DEBUGFS_REG32(DC_COM_PIN_OUTPUT_SELECT(6)),
 	DEBUGFS_REG32(DC_COM_PIN_MISC_CONTROL),
-	DEBUGFS_REG32(DC_COM_PIN_PM0_CONTROL),
-	DEBUGFS_REG32(DC_COM_PIN_PM0_DUTY_CYCLE),
-	DEBUGFS_REG32(DC_COM_PIN_PM1_CONTROL),
-	DEBUGFS_REG32(DC_COM_PIN_PM1_DUTY_CYCLE),
+	DEBUGFS_REG32(DC_COM_PM_CONTROL(0)),
+	DEBUGFS_REG32(DC_COM_PM_DUTY_CYCLE(0)),
+	DEBUGFS_REG32(DC_COM_PM_CONTROL(1)),
+	DEBUGFS_REG32(DC_COM_PM_DUTY_CYCLE(1)),
 	DEBUGFS_REG32(DC_COM_SPI_CONTROL),
 	DEBUGFS_REG32(DC_COM_SPI_START_BYTE),
 	DEBUGFS_REG32(DC_COM_HSPI_WRITE_DATA_AB),
@@ -2384,7 +2384,8 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	if (dc->rgb) {
 		/* XXX: parameterize? */
-		value = SC0_H_QUALIFIER_NONE | SC1_H_QUALIFIER_NONE;
+		value = SC0_H_QUALIFIER(SC_H_QUALIFIER_NONE) |
+			SC1_H_QUALIFIER(SC_H_QUALIFIER_NONE);
 		tegra_dc_writel(dc, value, DC_DISP_SHIFT_CLOCK_OPTIONS);
 	}
 
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 0cb0515968b35..2b87bb675d4cf 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -178,9 +178,11 @@ int tegra_dc_rgb_init(struct drm_device *drm, struct tegra_dc *dc);
 int tegra_dc_rgb_exit(struct tegra_dc *dc);
 
 #define DC_CMD_GENERAL_INCR_SYNCPT		0x000
+
 #define DC_CMD_GENERAL_INCR_SYNCPT_CNTRL	0x001
-#define  SYNCPT_CNTRL_NO_STALL   (1 << 8)
-#define  SYNCPT_CNTRL_SOFT_RESET (1 << 0)
+#define  SYNCPT_CNTRL_NO_STALL			BIT(8)
+#define  SYNCPT_CNTRL_SOFT_RESET		BIT(0)
+
 #define DC_CMD_GENERAL_INCR_SYNCPT_ERROR	0x002
 #define DC_CMD_WIN_A_INCR_SYNCPT		0x008
 #define DC_CMD_WIN_A_INCR_SYNCPT_CNTRL		0x009
@@ -191,101 +193,226 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_CMD_WIN_C_INCR_SYNCPT		0x018
 #define DC_CMD_WIN_C_INCR_SYNCPT_CNTRL		0x019
 #define DC_CMD_WIN_C_INCR_SYNCPT_ERROR		0x01a
+
 #define DC_CMD_CONT_SYNCPT_VSYNC		0x028
-#define  SYNCPT_VSYNC_ENABLE (1 << 8)
+#define  SYNCPT_VSYNC_ENABLE			BIT(8)
+
 #define DC_CMD_DISPLAY_COMMAND_OPTION0		0x031
+
 #define DC_CMD_DISPLAY_COMMAND			0x032
-#define DISP_CTRL_MODE_STOP (0 << 5)
-#define DISP_CTRL_MODE_C_DISPLAY (1 << 5)
-#define DISP_CTRL_MODE_NC_DISPLAY (2 << 5)
-#define DISP_CTRL_MODE_MASK (3 << 5)
+#define  DISP_CTRL_MODE_STOP			(0 << 5)
+#define  DISP_CTRL_MODE_C_DISPLAY		(1 << 5)
+#define  DISP_CTRL_MODE_NC_DISPLAY		(2 << 5)
+#define  DISP_CTRL_MODE_MASK			(3 << 5)
+
 #define DC_CMD_SIGNAL_RAISE			0x033
+
 #define DC_CMD_DISPLAY_POWER_CONTROL		0x036
-#define PW0_ENABLE (1 <<  0)
-#define PW1_ENABLE (1 <<  2)
-#define PW2_ENABLE (1 <<  4)
-#define PW3_ENABLE (1 <<  6)
-#define PW4_ENABLE (1 <<  8)
-#define PM0_ENABLE (1 << 16)
-#define PM1_ENABLE (1 << 18)
+#define  PW0_ENABLE				BIT(0)
+#define  PW1_ENABLE				BIT(2)
+#define  PW2_ENABLE				BIT(4)
+#define  PW3_ENABLE				BIT(6)
+#define  PW4_ENABLE				BIT(8)
+#define  PM0_ENABLE				BIT(16)
+#define  PM1_ENABLE				BIT(18)
 
 #define DC_CMD_INT_STATUS			0x037
 #define DC_CMD_INT_MASK				0x038
 #define DC_CMD_INT_ENABLE			0x039
 #define DC_CMD_INT_TYPE				0x03a
+
 #define DC_CMD_INT_POLARITY			0x03b
-#define CTXSW_INT                (1 << 0)
-#define FRAME_END_INT            (1 << 1)
-#define VBLANK_INT               (1 << 2)
-#define V_PULSE3_INT             (1 << 4)
-#define V_PULSE2_INT             (1 << 5)
-#define REGION_CRC_INT           (1 << 6)
-#define REG_TMOUT_INT            (1 << 7)
-#define WIN_A_UF_INT             (1 << 8)
-#define WIN_B_UF_INT             (1 << 9)
-#define WIN_C_UF_INT             (1 << 10)
-#define MSF_INT                  (1 << 12)
-#define WIN_A_OF_INT             (1 << 14)
-#define WIN_B_OF_INT             (1 << 15)
-#define WIN_C_OF_INT             (1 << 16)
-#define HEAD_UF_INT              (1 << 23)
-#define SD3_BUCKET_WALK_DONE_INT (1 << 24)
-#define DSC_OBUF_UF_INT          (1 << 26)
-#define DSC_RBUF_UF_INT          (1 << 27)
-#define DSC_BBUF_UF_INT          (1 << 28)
-#define DSC_TO_UF_INT            (1 << 29)
+#define  CTXSW_INT				BIT(0)
+#define  FRAME_END_INT				BIT(1)
+#define  VBLANK_INT				BIT(2)
+#define  V_PULSE3_INT				BIT(4)
+#define  V_PULSE2_INT				BIT(5)
+#define  REGION_CRC_INT				BIT(6)
+#define  REG_TMOUT_INT				BIT(7)
+#define  WIN_A_UF_INT				BIT(8)
+#define  WIN_B_UF_INT				BIT(9)
+#define  WIN_C_UF_INT				BIT(10)
+#define  MSF_INT				BIT(12)
+#define  WIN_A_OF_INT				BIT(14)
+#define  WIN_B_OF_INT				BIT(15)
+#define  WIN_C_OF_INT				BIT(16)
+#define  HEAD_UF_INT				BIT(23)
+#define  SD3_BUCKET_WALK_DONE_INT		BIT(24)
+#define  DSC_OBUF_UF_INT			BIT(26)
+#define  DSC_RBUF_UF_INT			BIT(27)
+#define  DSC_BBUF_UF_INT			BIT(28)
+#define  DSC_TO_UF_INT				BIT(29)
 
 #define DC_CMD_SIGNAL_RAISE1			0x03c
 #define DC_CMD_SIGNAL_RAISE2			0x03d
 #define DC_CMD_SIGNAL_RAISE3			0x03e
 
 #define DC_CMD_STATE_ACCESS			0x040
-#define READ_MUX  (1 << 0)
-#define WRITE_MUX (1 << 2)
+#define  READ_MUX				BIT(0)
+#define  WRITE_MUX				BIT(2)
 
 #define DC_CMD_STATE_CONTROL			0x041
-#define GENERAL_ACT_REQ (1 <<  0)
-#define WIN_A_ACT_REQ   (1 <<  1)
-#define WIN_B_ACT_REQ   (1 <<  2)
-#define WIN_C_ACT_REQ   (1 <<  3)
-#define CURSOR_ACT_REQ  (1 <<  7)
-#define GENERAL_UPDATE  (1 <<  8)
-#define WIN_A_UPDATE    (1 <<  9)
-#define WIN_B_UPDATE    (1 << 10)
-#define WIN_C_UPDATE    (1 << 11)
-#define CURSOR_UPDATE   (1 << 15)
-#define COMMON_ACTREQ   (1 << 16)
-#define COMMON_UPDATE   (1 << 17)
-#define NC_HOST_TRIG    (1 << 24)
+#define  GENERAL_ACT_REQ			BIT(0)
+#define  WIN_A_ACT_REQ				BIT(1)
+#define  WIN_B_ACT_REQ				BIT(2)
+#define  WIN_C_ACT_REQ				BIT(3)
+#define  CURSOR_ACT_REQ				BIT(7)
+#define  GENERAL_UPDATE				BIT(8)
+#define  WIN_A_UPDATE				BIT(9)
+#define  WIN_B_UPDATE				BIT(10)
+#define  WIN_C_UPDATE				BIT(11)
+#define  CURSOR_UPDATE				BIT(15)
+#define  COMMON_ACTREQ				BIT(16)
+#define  COMMON_UPDATE				BIT(17)
+#define  NC_HOST_TRIG				BIT(24)
 
 #define DC_CMD_DISPLAY_WINDOW_HEADER		0x042
-#define WINDOW_A_SELECT (1 << 4)
-#define WINDOW_B_SELECT (1 << 5)
-#define WINDOW_C_SELECT (1 << 6)
+#define  WINDOW_A_SELECT			BIT(4)
+#define  WINDOW_B_SELECT			BIT(5)
+#define  WINDOW_C_SELECT			BIT(6)
 
 #define DC_CMD_REG_ACT_CONTROL			0x043
 
 #define DC_COM_CRC_CONTROL			0x300
-#define  DC_COM_CRC_CONTROL_ALWAYS (1 << 3)
-#define  DC_COM_CRC_CONTROL_FULL_FRAME  (0 << 2)
-#define  DC_COM_CRC_CONTROL_ACTIVE_DATA (1 << 2)
-#define  DC_COM_CRC_CONTROL_WAIT (1 << 1)
-#define  DC_COM_CRC_CONTROL_ENABLE (1 << 0)
+#define  DC_COM_CRC_CONTROL_ALWAYS		BIT(3)
+#define  DC_COM_CRC_CONTROL_FULL_FRAME		(0 << 2)
+#define  DC_COM_CRC_CONTROL_ACTIVE_DATA		BIT(2)
+#define  DC_COM_CRC_CONTROL_WAIT		BIT(1)
+#define  DC_COM_CRC_CONTROL_ENABLE		BIT(0)
+
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
+/* Defines in PIN_OUTPUT/INPUT_* describe pin position, not state */
+#define DC_COM_PIN_OUTPUT_ENABLE(x)		(0x302 + (x))
+#define DC_COM_PIN_OUTPUT_POLARITY(x)		(0x306 + (x))
+#define DC_COM_PIN_OUTPUT_DATA(x)		(0x30a + (x))
+#define  PIN_UNMASK(x)				BIT((x) + 1)
+#define DC_COM_PIN_INPUT_ENABLE(x)		(0x30e + (x))
+
+/* DC_COM_PIN_OUTPUT/INPUT_*_0 */
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
+/* DC_COM_PIN_OUTPUT/INPUT_*_1 */
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
+/* DC_COM_PIN_OUTPUT/INPUT_*_2 */
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
+/* DC_COM_PIN_OUTPUT/INPUT_*_3 */
+#define PIN_LSCK				0
+#define PIN_LSDA				2
+#define PIN_LCSN				4
+#define PIN_LDC					6
+#define PIN_LSPI				8
+#define PIN_LSDI				10
+
+#define DC_COM_PIN_INPUT_DATA(x)		(0x312 + (x))
+#define DC_COM_PIN_OUTPUT_SELECT(x)		(0x314 + (x))
+#define  PIN_OUTPUT_SELECT_MASK(x)		(0x7 << (x))
+#define  PIN_OUTPUT_SELECT_PRIM(x)		(0 << (x))
+#define  PIN_OUTPUT_SELECT_OUT(x)		(1 << (x))
+#define  PIN_OUTPUT_SELECT_F2(x)		(2 << (x))
+#define  PIN_OUTPUT_SELECT_F3(x)		(3 << (x))
+#define  PIN_OUTPUT_SELECT_F4(x)		(4 << (x))
+#define  PIN_OUTPUT_SELECT_F5(x)		(5 << (x))
+#define  PIN_OUTPUT_SELECT_F6(x)		(6 << (x))
+#define  PIN_OUTPUT_SELECT_F7(x)		(7 << (x))
+
+/* DC_COM_PIN_OUTPUT_SELECT0 */
+#define PIN_OUTPUT_SELECT_LD0			0
+#define PIN_OUTPUT_SELECT_LD1			4
+#define PIN_OUTPUT_SELECT_LD2			8
+#define PIN_OUTPUT_SELECT_LD3			12
+#define PIN_OUTPUT_SELECT_LD4			16
+#define PIN_OUTPUT_SELECT_LD5			20
+#define PIN_OUTPUT_SELECT_LD6			24
+#define PIN_OUTPUT_SELECT_LD7			28
+
+/* DC_COM_PIN_OUTPUT_SELECT1 */
+#define PIN_OUTPUT_SELECT_LD8			0
+#define PIN_OUTPUT_SELECT_LD9			4
+#define PIN_OUTPUT_SELECT_LD10			8
+#define PIN_OUTPUT_SELECT_LD11			12
+#define PIN_OUTPUT_SELECT_LD12			16
+#define PIN_OUTPUT_SELECT_LD13			20
+#define PIN_OUTPUT_SELECT_LD14			24
+#define PIN_OUTPUT_SELECT_LD15			28
+
+/* DC_COM_PIN_OUTPUT_SELECT2 */
+#define PIN_OUTPUT_SELECT_LD16			0
+#define PIN_OUTPUT_SELECT_LD17			4
+
+/* DC_COM_PIN_OUTPUT_SELECT3 */
+#define PIN_OUTPUT_SELECT_LPW0			0
+#define PIN_OUTPUT_SELECT_LPW1			4
+#define PIN_OUTPUT_SELECT_LPW2			8
+#define PIN_OUTPUT_SELECT_LSC0			16
+#define PIN_OUTPUT_SELECT_LSC1			20
+#define PIN_OUTPUT_SELECT_LVS			24
+#define PIN_OUTPUT_SELECT_LHS			28
+
+/* DC_COM_PIN_OUTPUT_SELECT4 */
+#define PIN_OUTPUT_SELECT_LHP0			0
+#define PIN_OUTPUT_SELECT_LHP1			4
+#define PIN_OUTPUT_SELECT_LHP2			8
+#define PIN_OUTPUT_SELECT_LVP0			16
+#define PIN_OUTPUT_SELECT_LVP1			20
+
+/* DC_COM_PIN_OUTPUT_SELECT5 */
+#define PIN_OUTPUT_SELECT_LM0			0
+#define PIN_OUTPUT_SELECT_LM1			4
+#define PIN_OUTPUT_SELECT_LDI			8
+#define PIN_OUTPUT_SELECT_LPP			12
+
+/* DC_COM_PIN_OUTPUT_SELECT6 */
+#define PIN_OUTPUT_SELECT_LSCK			0
+#define PIN_OUTPUT_SELECT_LSDA			4
+#define PIN_OUTPUT_SELECT_LCSN			8
+#define PIN_OUTPUT_SELECT_LDC			12
+#define PIN_OUTPUT_SELECT_LSPI			16
+#define PIN_OUTPUT_SELECT_LSDI			20
 
 #define DC_COM_PIN_MISC_CONTROL			0x31b
-#define DC_COM_PIN_PM0_CONTROL			0x31c
-#define DC_COM_PIN_PM0_DUTY_CYCLE		0x31d
-#define DC_COM_PIN_PM1_CONTROL			0x31e
-#define DC_COM_PIN_PM1_DUTY_CYCLE		0x31f
+#define DC_COM_PM_CONTROL(x)			(0x31c + (x) * 2)
+#define   PM_CLOCK_SELECT_SHIFT_DIV		0
+#define   PM_CLOCK_SELECT_PIX_CLK		1
+#define   PM_CLOCK_SELECT_LINE_CLK		2
+#define   PM_CLOCK_SELECT_FRAME_CLK		3
+#define   PM_CLOCK_DIVIDER(x)			(((x) & 0x3f) << 4)
+#define   PM_PERIOD(x)				(((x) & 0x3f) << 18)
+#define DC_COM_PM_DUTY_CYCLE(x)			(0x31d + (x) * 2)
+#define   PM_DUTY_CYCLE_MASK(x)			((x) & 0xff)
 
 #define DC_COM_SPI_CONTROL			0x320
 #define DC_COM_SPI_START_BYTE			0x321
@@ -299,38 +426,43 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_COM_CRC_CHECKSUM_LATCHED		0x329
 
 #define DC_COM_RG_UNDERFLOW			0x365
-#define  UNDERFLOW_MODE_RED      (1 << 8)
-#define  UNDERFLOW_REPORT_ENABLE (1 << 0)
+#define  UNDERFLOW_MODE_RED			BIT(8)
+#define  UNDERFLOW_REPORT_ENABLE		BIT(0)
 
 #define DC_DISP_DISP_SIGNAL_OPTIONS0		0x400
-#define H_PULSE0_ENABLE (1 <<  8)
-#define H_PULSE1_ENABLE (1 << 10)
-#define H_PULSE2_ENABLE (1 << 12)
+#define  H_PULSE0_ENABLE			BIT(8)
+#define  H_PULSE1_ENABLE			BIT(10)
+#define  H_PULSE2_ENABLE			BIT(12)
+#define  V_PULSE0_ENABLE			BIT(16)
+#define  V_PULSE1_ENABLE			BIT(18)
+#define  V_PULSE2_ENABLE			BIT(19)
+#define  V_PULSE3_ENABLE			BIT(20)
+#define  M0_ENABLE				BIT(24)
+#define  M1_ENABLE				BIT(26)
 
 #define DC_DISP_DISP_SIGNAL_OPTIONS1		0x401
 
 #define DC_DISP_DISP_WIN_OPTIONS		0x402
-#define HDMI_ENABLE	(1 << 30)
-#define DSI_ENABLE	(1 << 29)
-#define SOR1_TIMING_CYA	(1 << 27)
-#define CURSOR_ENABLE	(1 << 16)
-
-#define SOR_ENABLE(x)	(1 << (25 + (((x) > 1) ? ((x) + 1) : (x))))
+#define  HDMI_ENABLE				BIT(30)
+#define  DSI_ENABLE				BIT(29)
+#define  SOR1_TIMING_CYA			BIT(27)
+#define  SOR_ENABLE(x)				BIT((25 + (((x) > 1) ? ((x) + 1) : (x))))
+#define  CURSOR_ENABLE				BIT(16)
 
 #define DC_DISP_DISP_MEM_HIGH_PRIORITY		0x403
-#define CURSOR_THRESHOLD(x)   (((x) & 0x03) << 24)
-#define WINDOW_A_THRESHOLD(x) (((x) & 0x7f) << 16)
-#define WINDOW_B_THRESHOLD(x) (((x) & 0x7f) <<  8)
-#define WINDOW_C_THRESHOLD(x) (((x) & 0xff) <<  0)
+#define  CURSOR_THRESHOLD(x)			(((x) & 0x03) << 24)
+#define  WINDOW_A_THRESHOLD(x)			(((x) & 0x7f) << 16)
+#define  WINDOW_B_THRESHOLD(x)			(((x) & 0x7f) <<  8)
+#define  WINDOW_C_THRESHOLD(x)			(((x) & 0xff) <<  0)
 
 #define DC_DISP_DISP_MEM_HIGH_PRIORITY_TIMER	0x404
-#define CURSOR_DELAY(x)   (((x) & 0x3f) << 24)
-#define WINDOW_A_DELAY(x) (((x) & 0x3f) << 16)
-#define WINDOW_B_DELAY(x) (((x) & 0x3f) <<  8)
-#define WINDOW_C_DELAY(x) (((x) & 0x3f) <<  0)
+#define  CURSOR_DELAY(x)			(((x) & 0x3f) << 24)
+#define  WINDOW_A_DELAY(x)			(((x) & 0x3f) << 16)
+#define  WINDOW_B_DELAY(x)			(((x) & 0x3f) <<  8)
+#define  WINDOW_C_DELAY(x)			(((x) & 0x3f) <<  0)
 
 #define DC_DISP_DISP_TIMING_OPTIONS		0x405
-#define VSYNC_H_POSITION(x) ((x) & 0xfff)
+#define  VSYNC_H_POSITION(x)			((x) & 0xfff)
 
 #define DC_DISP_REF_TO_SYNC			0x406
 #define DC_DISP_SYNC_WIDTH			0x407
@@ -373,99 +505,105 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_DISP_PP_SELECT_C			0x42c
 #define DC_DISP_PP_SELECT_D			0x42d
 
-#define PULSE_MODE_NORMAL    (0 << 3)
-#define PULSE_MODE_ONE_CLOCK (1 << 3)
-#define PULSE_POLARITY_HIGH  (0 << 4)
-#define PULSE_POLARITY_LOW   (1 << 4)
-#define PULSE_QUAL_ALWAYS    (0 << 6)
-#define PULSE_QUAL_VACTIVE   (2 << 6)
-#define PULSE_QUAL_VACTIVE1  (3 << 6)
-#define PULSE_LAST_START_A   (0 << 8)
-#define PULSE_LAST_END_A     (1 << 8)
-#define PULSE_LAST_START_B   (2 << 8)
-#define PULSE_LAST_END_B     (3 << 8)
-#define PULSE_LAST_START_C   (4 << 8)
-#define PULSE_LAST_END_C     (5 << 8)
-#define PULSE_LAST_START_D   (6 << 8)
-#define PULSE_LAST_END_D     (7 << 8)
-
-#define PULSE_START(x) (((x) & 0xfff) <<  0)
-#define PULSE_END(x)   (((x) & 0xfff) << 16)
+/* DC_DISP_H/V_PULSE_CONTROL */
+#define  PULSE_MODE_NORMAL			(0 << 3)
+#define  PULSE_MODE_ONE_CLOCK			BIT(3)
+#define  PULSE_POLARITY_HIGH			(0 << 4)
+#define  PULSE_POLARITY_LOW			BIT(4)
+#define  PULSE_QUAL_ALWAYS			(0 << 6)
+#define  PULSE_QUAL_VACTIVE			(2 << 6)
+#define  PULSE_QUAL_VACTIVE1			(3 << 6)
+#define  PULSE_LAST_START_A			(0 << 8)
+#define  PULSE_LAST_END_A			(1 << 8)
+#define  PULSE_LAST_START_B			(2 << 8)
+#define  PULSE_LAST_END_B			(3 << 8)
+#define  PULSE_LAST_START_C			(4 << 8)
+#define  PULSE_LAST_END_C			(5 << 8)
+#define  PULSE_LAST_START_D			(6 << 8)
+#define  PULSE_LAST_END_D			(7 << 8)
+
+/* DC_DISP_H/V_PULSE_POSITION */
+#define  PULSE_START(x)				(((x) & 0xfff) <<  0)
+#define  PULSE_END(x)				(((x) & 0xfff) << 16)
 
 #define DC_DISP_DISP_CLOCK_CONTROL		0x42e
-#define PIXEL_CLK_DIVIDER_PCD1  (0 << 8)
-#define PIXEL_CLK_DIVIDER_PCD1H (1 << 8)
-#define PIXEL_CLK_DIVIDER_PCD2  (2 << 8)
-#define PIXEL_CLK_DIVIDER_PCD3  (3 << 8)
-#define PIXEL_CLK_DIVIDER_PCD4  (4 << 8)
-#define PIXEL_CLK_DIVIDER_PCD6  (5 << 8)
-#define PIXEL_CLK_DIVIDER_PCD8  (6 << 8)
-#define PIXEL_CLK_DIVIDER_PCD9  (7 << 8)
-#define PIXEL_CLK_DIVIDER_PCD12 (8 << 8)
-#define PIXEL_CLK_DIVIDER_PCD16 (9 << 8)
-#define PIXEL_CLK_DIVIDER_PCD18 (10 << 8)
-#define PIXEL_CLK_DIVIDER_PCD24 (11 << 8)
-#define PIXEL_CLK_DIVIDER_PCD13 (12 << 8)
-#define SHIFT_CLK_DIVIDER(x)    ((x) & 0xff)
+#define  PIXEL_CLK_DIVIDER_PCD1			(0 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD1H		(1 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD2			(2 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD3			(3 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD4			(4 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD6			(5 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD8			(6 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD9			(7 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD12		(8 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD16		(9 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD18		(10 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD24		(11 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD13		(12 << 8)
+#define  SHIFT_CLK_DIVIDER(x)			((x) & 0xff)
 
 #define DC_DISP_DISP_INTERFACE_CONTROL		0x42f
-#define DISP_DATA_FORMAT_DF1P1C    (0 << 0)
-#define DISP_DATA_FORMAT_DF1P2C24B (1 << 0)
-#define DISP_DATA_FORMAT_DF1P2C18B (2 << 0)
-#define DISP_DATA_FORMAT_DF1P2C16B (3 << 0)
-#define DISP_DATA_FORMAT_DF2S      (4 << 0)
-#define DISP_DATA_FORMAT_DF3S      (5 << 0)
-#define DISP_DATA_FORMAT_DFSPI     (6 << 0)
-#define DISP_DATA_FORMAT_DF1P3C24B (7 << 0)
-#define DISP_DATA_FORMAT_DF1P3C18B (8 << 0)
-#define DISP_ALIGNMENT_MSB         (0 << 8)
-#define DISP_ALIGNMENT_LSB         (1 << 8)
-#define DISP_ORDER_RED_BLUE        (0 << 9)
-#define DISP_ORDER_BLUE_RED        (1 << 9)
+#define  DISP_DATA_FORMAT_DF1P1C		0
+#define  DISP_DATA_FORMAT_DF1P2C24B		1
+#define  DISP_DATA_FORMAT_DF1P2C18B		2
+#define  DISP_DATA_FORMAT_DF1P2C16B		3
+#define  DISP_DATA_FORMAT_DF2S			4
+#define  DISP_DATA_FORMAT_DF3S			5
+#define  DISP_DATA_FORMAT_DFSPI			6
+#define  DISP_DATA_FORMAT_DF1P3C24B		7
+#define  DISP_DATA_FORMAT_DF1P3C18B		8
+#define  DISP_ALIGNMENT_MSB			(0 << 8)
+#define  DISP_ALIGNMENT_LSB			BIT(8)
+#define  DISP_ORDER_RED_BLUE			(0 << 9)
+#define  DISP_ORDER_BLUE_RED			BIT(9)
 
 #define DC_DISP_DISP_COLOR_CONTROL		0x430
-#define BASE_COLOR_SIZE666     ( 0 << 0)
-#define BASE_COLOR_SIZE111     ( 1 << 0)
-#define BASE_COLOR_SIZE222     ( 2 << 0)
-#define BASE_COLOR_SIZE333     ( 3 << 0)
-#define BASE_COLOR_SIZE444     ( 4 << 0)
-#define BASE_COLOR_SIZE555     ( 5 << 0)
-#define BASE_COLOR_SIZE565     ( 6 << 0)
-#define BASE_COLOR_SIZE332     ( 7 << 0)
-#define BASE_COLOR_SIZE888     ( 8 << 0)
-#define BASE_COLOR_SIZE101010  (10 << 0)
-#define BASE_COLOR_SIZE121212  (12 << 0)
-#define DITHER_CONTROL_MASK    (3 << 8)
-#define DITHER_CONTROL_DISABLE (0 << 8)
-#define DITHER_CONTROL_ORDERED (2 << 8)
-#define DITHER_CONTROL_ERRDIFF (3 << 8)
-#define BASE_COLOR_SIZE_MASK   (0xf << 0)
-#define BASE_COLOR_SIZE_666    (  0 << 0)
-#define BASE_COLOR_SIZE_111    (  1 << 0)
-#define BASE_COLOR_SIZE_222    (  2 << 0)
-#define BASE_COLOR_SIZE_333    (  3 << 0)
-#define BASE_COLOR_SIZE_444    (  4 << 0)
-#define BASE_COLOR_SIZE_555    (  5 << 0)
-#define BASE_COLOR_SIZE_565    (  6 << 0)
-#define BASE_COLOR_SIZE_332    (  7 << 0)
-#define BASE_COLOR_SIZE_888    (  8 << 0)
-#define BASE_COLOR_SIZE_101010 ( 10 << 0)
-#define BASE_COLOR_SIZE_121212 ( 12 << 0)
-#define CMU_ENABLE_ENABLE      (1 << 20)
+#define  BASE_COLOR_SIZE_MASK			0xf
+#define  BASE_COLOR_SIZE_666			0
+#define  BASE_COLOR_SIZE_111			1
+#define  BASE_COLOR_SIZE_222			2
+#define  BASE_COLOR_SIZE_333			3
+#define  BASE_COLOR_SIZE_444			4
+#define  BASE_COLOR_SIZE_555			5
+#define  BASE_COLOR_SIZE_565			6
+#define  BASE_COLOR_SIZE_332			7
+#define  BASE_COLOR_SIZE_888			8
+#define  BASE_COLOR_SIZE_101010			10
+#define  BASE_COLOR_SIZE_121212			12
+#define  DITHER_CONTROL_MASK			(3 << 8)
+#define  DITHER_CONTROL_DISABLE			(0 << 8)
+#define  DITHER_CONTROL_ORDERED			(2 << 8)
+#define  DITHER_CONTROL_ERRDIFF			(3 << 8)
+#define  DISP_COLOR_SWAP_BGR			BIT(16)
+#define  CMU_ENABLE_ENABLE			BIT(20)
 
 #define DC_DISP_SHIFT_CLOCK_OPTIONS		0x431
-#define  SC1_H_QUALIFIER_NONE	(1 << 16)
-#define  SC0_H_QUALIFIER_NONE	(1 <<  0)
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
-#define DE_SELECT_ACTIVE_BLANK  (0 << 0)
-#define DE_SELECT_ACTIVE        (1 << 0)
-#define DE_SELECT_ACTIVE_IS     (2 << 0)
-#define DE_CONTROL_ONECLK       (0 << 2)
-#define DE_CONTROL_NORMAL       (1 << 2)
-#define DE_CONTROL_EARLY_EXT    (2 << 2)
-#define DE_CONTROL_EARLY        (3 << 2)
-#define DE_CONTROL_ACTIVE_BLANK (4 << 2)
+#define  DE_SELECT_ACTIVE_BLANK			0
+#define  DE_SELECT_ACTIVE			1
+#define  DE_SELECT_ACTIVE_IS			2
+#define  DE_CONTROL_ONECLK			(0 << 2)
+#define  DE_CONTROL_NORMAL			(1 << 2)
+#define  DE_CONTROL_EARLY_EXT			(2 << 2)
+#define  DE_CONTROL_EARLY			(3 << 2)
+#define  DE_CONTROL_ACTIVE_BLANK		(4 << 2)
 
 #define DC_DISP_SERIAL_INTERFACE_OPTIONS	0x433
 #define DC_DISP_LCD_SPI_OPTIONS			0x434
@@ -479,20 +617,34 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_DISP_CURSOR_BACKGROUND		0x43d
 
 #define DC_DISP_CURSOR_START_ADDR		0x43e
-#define CURSOR_CLIP_DISPLAY	(0 << 28)
-#define CURSOR_CLIP_WIN_A	(1 << 28)
-#define CURSOR_CLIP_WIN_B	(2 << 28)
-#define CURSOR_CLIP_WIN_C	(3 << 28)
-#define CURSOR_SIZE_32x32	(0 << 24)
-#define CURSOR_SIZE_64x64	(1 << 24)
-#define CURSOR_SIZE_128x128	(2 << 24)
-#define CURSOR_SIZE_256x256	(3 << 24)
+#define  CURSOR_CLIP_DISPLAY			(0 << 28)
+#define  CURSOR_CLIP_WIN_A			(1 << 28)
+#define  CURSOR_CLIP_WIN_B			(2 << 28)
+#define  CURSOR_CLIP_WIN_C			(3 << 28)
+#define  CURSOR_SIZE_32x32			(0 << 24)
+#define  CURSOR_SIZE_64x64			(1 << 24)
+#define  CURSOR_SIZE_128x128			(2 << 24)
+#define  CURSOR_SIZE_256x256			(3 << 24)
 #define DC_DISP_CURSOR_START_ADDR_NS		0x43f
 
 #define DC_DISP_CURSOR_POSITION			0x440
 #define DC_DISP_CURSOR_POSITION_NS		0x441
 
 #define DC_DISP_INIT_SEQ_CONTROL		0x442
+#define  SEND_INIT_SEQUENCE			BIT(0)
+#define  INIT_SEQUENCE_MODE_SPI			BIT(1)
+#define  INIT_SEQUENCE_MODE_PLCD		0
+#define  INIT_SEQ_DC_SIGNAL_SHIFT		4
+#define  INIT_SEQ_DC_SIGNAL_MASK		(0x7 << INIT_SEQ_DC_SIGNAL_SHIFT)
+#define  NO_DC_SIGNAL				0
+#define  DC_SIGNAL_VSYNC			1
+#define  DC_SIGNAL_VPULSE0			2
+#define  DC_SIGNAL_VPULSE1			3
+#define  DC_SIGNAL_VPULSE2			4
+#define  DC_SIGNAL_VPULSE3			5
+#define  INIT_SEQ_DC_CONTROL_SHIFT		7
+#define  FRAME_INIT_SEQ_CYCLES_SHIFT		8
+
 #define DC_DISP_SPI_INIT_SEQ_DATA_A		0x443
 #define DC_DISP_SPI_INIT_SEQ_DATA_B		0x444
 #define DC_DISP_SPI_INIT_SEQ_DATA_C		0x445
@@ -519,22 +671,22 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_DISP_SD_MAN_K_VALUES			0x4de
 
 #define DC_DISP_BLEND_BACKGROUND_COLOR		0x4e4
-#define  BACKGROUND_COLOR_ALPHA(x) (((x) & 0xff) << 24)
-#define  BACKGROUND_COLOR_BLUE(x)  (((x) & 0xff) << 16)
-#define  BACKGROUND_COLOR_GREEN(x) (((x) & 0xff) << 8)
-#define  BACKGROUND_COLOR_RED(x)   (((x) & 0xff) << 0)
+#define  BACKGROUND_COLOR_ALPHA(x)		(((x) & 0xff) << 24)
+#define  BACKGROUND_COLOR_BLUE(x)		(((x) & 0xff) << 16)
+#define  BACKGROUND_COLOR_GREEN(x)		(((x) & 0xff) << 8)
+#define  BACKGROUND_COLOR_RED(x)		((x) & 0xff)
 
 #define DC_DISP_INTERLACE_CONTROL		0x4e5
-#define  INTERLACE_STATUS (1 << 2)
-#define  INTERLACE_START  (1 << 1)
-#define  INTERLACE_ENABLE (1 << 0)
+#define  INTERLACE_STATUS			BIT(2)
+#define  INTERLACE_START			BIT(1)
+#define  INTERLACE_ENABLE			BIT(0)
 
 #define DC_DISP_CURSOR_START_ADDR_HI		0x4ec
 #define DC_DISP_BLEND_CURSOR_CONTROL		0x4f1
 #define CURSOR_COMPOSITION_MODE_BLEND		(0 << 25)
-#define CURSOR_COMPOSITION_MODE_XOR		(1 << 25)
+#define CURSOR_COMPOSITION_MODE_XOR		BIT(25)
 #define CURSOR_MODE_LEGACY			(0 << 24)
-#define CURSOR_MODE_NORMAL			(1 << 24)
+#define CURSOR_MODE_NORMAL			BIT(24)
 #define CURSOR_DST_BLEND_ZERO			(0 << 16)
 #define CURSOR_DST_BLEND_K1			(1 << 16)
 #define CURSOR_DST_BLEND_NEG_K1_TIMES_SRC	(2 << 16)
@@ -544,34 +696,34 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define CURSOR_SRC_BLEND_MASK			(3 << 8)
 #define CURSOR_ALPHA				0xff
 
-#define DC_WIN_CORE_ACT_CONTROL 0x50e
-#define  VCOUNTER (0 << 0)
-#define  HCOUNTER (1 << 0)
+#define DC_WIN_CORE_ACT_CONTROL			0x50e
+#define  VCOUNTER				0
+#define  HCOUNTER				BIT(0)
 
-#define DC_WIN_CORE_IHUB_WGRP_LATENCY_CTLA 0x543
-#define  LATENCY_CTL_MODE_ENABLE (1 << 2)
+#define DC_WIN_CORE_IHUB_WGRP_LATENCY_CTLA	0x543
+#define  LATENCY_CTL_MODE_ENABLE		BIT(2)
 
-#define DC_WIN_CORE_IHUB_WGRP_LATENCY_CTLB 0x544
-#define  WATERMARK_MASK 0x1fffffff
+#define DC_WIN_CORE_IHUB_WGRP_LATENCY_CTLB	0x544
+#define  WATERMARK_MASK				0x1fffffff
 
-#define DC_WIN_CORE_PRECOMP_WGRP_PIPE_METER 0x560
-#define  PIPE_METER_INT(x)  (((x) & 0xff) << 8)
-#define  PIPE_METER_FRAC(x) (((x) & 0xff) << 0)
+#define DC_WIN_CORE_PRECOMP_WGRP_PIPE_METER	0x560
+#define  PIPE_METER_INT(x)			(((x) & 0xff) << 8)
+#define  PIPE_METER_FRAC(x)			((x) & 0xff)
 
-#define DC_WIN_CORE_IHUB_WGRP_POOL_CONFIG 0x561
-#define  MEMPOOL_ENTRIES(x) (((x) & 0xffff) << 0)
+#define DC_WIN_CORE_IHUB_WGRP_POOL_CONFIG	0x561
+#define  MEMPOOL_ENTRIES(x)			((x) & 0xffff)
 
-#define DC_WIN_CORE_IHUB_WGRP_FETCH_METER 0x562
-#define  SLOTS(x) (((x) & 0xff) << 0)
+#define DC_WIN_CORE_IHUB_WGRP_FETCH_METER	0x562
+#define  SLOTS(x)				((x) & 0xff)
 
-#define DC_WIN_CORE_IHUB_LINEBUF_CONFIG 0x563
-#define  MODE_TWO_LINES  (0 << 14)
-#define  MODE_FOUR_LINES (1 << 14)
+#define DC_WIN_CORE_IHUB_LINEBUF_CONFIG		0x563
+#define  MODE_TWO_LINES				(0 << 14)
+#define  MODE_FOUR_LINES			BIT(14)
 
-#define DC_WIN_CORE_IHUB_THREAD_GROUP 0x568
-#define  THREAD_NUM_MASK (0x1f << 1)
-#define  THREAD_NUM(x) (((x) & 0x1f) << 1)
-#define  THREAD_GROUP_ENABLE (1 << 0)
+#define DC_WIN_CORE_IHUB_THREAD_GROUP		0x568
+#define  THREAD_NUM_MASK			(0x1f << 1)
+#define  THREAD_NUM(x)				(((x) & 0x1f) << 1)
+#define  THREAD_GROUP_ENABLE			BIT(0)
 
 #define DC_WIN_H_FILTER_P(p)			(0x601 + (p))
 #define DC_WIN_V_FILTER_P(p)			(0x619 + (p))
@@ -586,115 +738,115 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_WIN_CSC_KVB				0x618
 
 #define DC_WIN_WIN_OPTIONS			0x700
-#define H_DIRECTION  (1 <<  0)
-#define V_DIRECTION  (1 <<  2)
-#define COLOR_EXPAND (1 <<  6)
-#define H_FILTER     (1 <<  8)
-#define V_FILTER     (1 << 10)
-#define CSC_ENABLE   (1 << 18)
-#define WIN_ENABLE   (1 << 30)
+#define  H_DIRECTION				BIT(0)
+#define  V_DIRECTION				BIT(2)
+#define  COLOR_EXPAND				BIT(6)
+#define  H_FILTER				BIT(8)
+#define  V_FILTER				BIT(10)
+#define  CSC_ENABLE				BIT(18)
+#define  WIN_ENABLE				BIT(30)
 
 #define DC_WIN_BYTE_SWAP			0x701
-#define BYTE_SWAP_NOSWAP  (0 << 0)
-#define BYTE_SWAP_SWAP2   (1 << 0)
-#define BYTE_SWAP_SWAP4   (2 << 0)
-#define BYTE_SWAP_SWAP4HW (3 << 0)
+#define  BYTE_SWAP_NOSWAP			0
+#define  BYTE_SWAP_SWAP2			1
+#define  BYTE_SWAP_SWAP4			2
+#define  BYTE_SWAP_SWAP4HW			3
 
 #define DC_WIN_BUFFER_CONTROL			0x702
-#define BUFFER_CONTROL_HOST  (0 << 0)
-#define BUFFER_CONTROL_VI    (1 << 0)
-#define BUFFER_CONTROL_EPP   (2 << 0)
-#define BUFFER_CONTROL_MPEGE (3 << 0)
-#define BUFFER_CONTROL_SB2D  (4 << 0)
+#define  BUFFER_CONTROL_HOST			0
+#define  BUFFER_CONTROL_VI			1
+#define  BUFFER_CONTROL_EPP			2
+#define  BUFFER_CONTROL_MPEGE			3
+#define  BUFFER_CONTROL_SB2D			4
 
 #define DC_WIN_COLOR_DEPTH			0x703
-#define WIN_COLOR_DEPTH_P1              0
-#define WIN_COLOR_DEPTH_P2              1
-#define WIN_COLOR_DEPTH_P4              2
-#define WIN_COLOR_DEPTH_P8              3
-#define WIN_COLOR_DEPTH_B4G4R4A4        4
-#define WIN_COLOR_DEPTH_B5G5R5A1        5
-#define WIN_COLOR_DEPTH_B5G6R5          6
-#define WIN_COLOR_DEPTH_A1B5G5R5        7
-#define WIN_COLOR_DEPTH_B8G8R8A8       12
-#define WIN_COLOR_DEPTH_R8G8B8A8       13
-#define WIN_COLOR_DEPTH_B6x2G6x2R6x2A8 14
-#define WIN_COLOR_DEPTH_R6x2G6x2B6x2A8 15
-#define WIN_COLOR_DEPTH_YCbCr422       16
-#define WIN_COLOR_DEPTH_YUV422         17
-#define WIN_COLOR_DEPTH_YCbCr420P      18
-#define WIN_COLOR_DEPTH_YUV420P        19
-#define WIN_COLOR_DEPTH_YCbCr422P      20
-#define WIN_COLOR_DEPTH_YUV422P        21
-#define WIN_COLOR_DEPTH_YCbCr422R      22
-#define WIN_COLOR_DEPTH_YUV422R        23
-#define WIN_COLOR_DEPTH_YCbCr422RA     24
-#define WIN_COLOR_DEPTH_YUV422RA       25
-#define WIN_COLOR_DEPTH_R4G4B4A4       27
-#define WIN_COLOR_DEPTH_R5G5B5A        28
-#define WIN_COLOR_DEPTH_AR5G5B5        29
-#define WIN_COLOR_DEPTH_B5G5R5X1       30
-#define WIN_COLOR_DEPTH_X1B5G5R5       31
-#define WIN_COLOR_DEPTH_R5G5B5X1       32
-#define WIN_COLOR_DEPTH_X1R5G5B5       33
-#define WIN_COLOR_DEPTH_R5G6B5         34
-#define WIN_COLOR_DEPTH_A8R8G8B8       35
-#define WIN_COLOR_DEPTH_A8B8G8R8       36
-#define WIN_COLOR_DEPTH_B8G8R8X8       37
-#define WIN_COLOR_DEPTH_R8G8B8X8       38
-#define WIN_COLOR_DEPTH_YCbCr444P      41
-#define WIN_COLOR_DEPTH_YCrCb420SP     42
-#define WIN_COLOR_DEPTH_YCbCr420SP     43
-#define WIN_COLOR_DEPTH_YCrCb422SP     44
-#define WIN_COLOR_DEPTH_YCbCr422SP     45
-#define WIN_COLOR_DEPTH_YCrCb444SP     48
-#define WIN_COLOR_DEPTH_YCbCr444SP     49
-#define WIN_COLOR_DEPTH_X8B8G8R8       65
-#define WIN_COLOR_DEPTH_X8R8G8B8       66
+#define  WIN_COLOR_DEPTH_P1			0
+#define  WIN_COLOR_DEPTH_P2			1
+#define  WIN_COLOR_DEPTH_P4			2
+#define  WIN_COLOR_DEPTH_P8			3
+#define  WIN_COLOR_DEPTH_B4G4R4A4		4
+#define  WIN_COLOR_DEPTH_B5G5R5A1		5
+#define  WIN_COLOR_DEPTH_B5G6R5			6
+#define  WIN_COLOR_DEPTH_A1B5G5R5		7
+#define  WIN_COLOR_DEPTH_B8G8R8A8		12
+#define  WIN_COLOR_DEPTH_R8G8B8A8		13
+#define  WIN_COLOR_DEPTH_B6x2G6x2R6x2A8		14
+#define  WIN_COLOR_DEPTH_R6x2G6x2B6x2A8		15
+#define  WIN_COLOR_DEPTH_YCbCr422		16
+#define  WIN_COLOR_DEPTH_YUV422			17
+#define  WIN_COLOR_DEPTH_YCbCr420P		18
+#define  WIN_COLOR_DEPTH_YUV420P		19
+#define  WIN_COLOR_DEPTH_YCbCr422P		20
+#define  WIN_COLOR_DEPTH_YUV422P		21
+#define  WIN_COLOR_DEPTH_YCbCr422R		22
+#define  WIN_COLOR_DEPTH_YUV422R		23
+#define  WIN_COLOR_DEPTH_YCbCr422RA		24
+#define  WIN_COLOR_DEPTH_YUV422RA		25
+#define  WIN_COLOR_DEPTH_R4G4B4A4		27
+#define  WIN_COLOR_DEPTH_R5G5B5A		28
+#define  WIN_COLOR_DEPTH_AR5G5B5		29
+#define  WIN_COLOR_DEPTH_B5G5R5X1		30
+#define  WIN_COLOR_DEPTH_X1B5G5R5		31
+#define  WIN_COLOR_DEPTH_R5G5B5X1		32
+#define  WIN_COLOR_DEPTH_X1R5G5B5		33
+#define  WIN_COLOR_DEPTH_R5G6B5			34
+#define  WIN_COLOR_DEPTH_A8R8G8B8		35
+#define  WIN_COLOR_DEPTH_A8B8G8R8		36
+#define  WIN_COLOR_DEPTH_B8G8R8X8		37
+#define  WIN_COLOR_DEPTH_R8G8B8X8		38
+#define  WIN_COLOR_DEPTH_YCbCr444P		41
+#define  WIN_COLOR_DEPTH_YCrCb420SP		42
+#define  WIN_COLOR_DEPTH_YCbCr420SP		43
+#define  WIN_COLOR_DEPTH_YCrCb422SP		44
+#define  WIN_COLOR_DEPTH_YCbCr422SP		45
+#define  WIN_COLOR_DEPTH_YCrCb444SP		48
+#define  WIN_COLOR_DEPTH_YCbCr444SP		49
+#define  WIN_COLOR_DEPTH_X8B8G8R8		65
+#define  WIN_COLOR_DEPTH_X8R8G8B8		66
 
 #define DC_WIN_POSITION				0x704
-#define H_POSITION(x) (((x) & 0x1fff) <<  0) /* XXX 0x7fff on Tegra186 */
-#define V_POSITION(x) (((x) & 0x1fff) << 16) /* XXX 0x7fff on Tegra186 */
+#define  H_POSITION(x)				(((x) & 0x1fff) <<  0) /* XXX 0x7fff on Tegra186 */
+#define  V_POSITION(x)				(((x) & 0x1fff) << 16) /* XXX 0x7fff on Tegra186 */
 
 #define DC_WIN_SIZE				0x705
-#define H_SIZE(x) (((x) & 0x1fff) <<  0) /* XXX 0x7fff on Tegra186 */
-#define V_SIZE(x) (((x) & 0x1fff) << 16) /* XXX 0x7fff on Tegra186 */
+#define  H_SIZE(x)				(((x) & 0x1fff) <<  0) /* XXX 0x7fff on Tegra186 */
+#define  V_SIZE(x)				(((x) & 0x1fff) << 16) /* XXX 0x7fff on Tegra186 */
 
 #define DC_WIN_PRESCALED_SIZE			0x706
-#define H_PRESCALED_SIZE(x) (((x) & 0x7fff) <<  0)
-#define V_PRESCALED_SIZE(x) (((x) & 0x1fff) << 16) /* XXX 0x7fff on Tegra186 */
+#define  H_PRESCALED_SIZE(x)			(((x) & 0x7fff) <<  0)
+#define  V_PRESCALED_SIZE(x)			(((x) & 0x1fff) << 16) /* XXX 0x7fff on Tegra186 */
 
 #define DC_WIN_H_INITIAL_DDA			0x707
 #define DC_WIN_V_INITIAL_DDA			0x708
 #define DC_WIN_DDA_INC				0x709
-#define H_DDA_INC(x) (((x) & 0xffff) <<  0)
-#define V_DDA_INC(x) (((x) & 0xffff) << 16)
+#define  H_DDA_INC(x)				(((x) & 0xffff) <<  0)
+#define  V_DDA_INC(x)				(((x) & 0xffff) << 16)
 
 #define DC_WIN_LINE_STRIDE			0x70a
 #define DC_WIN_BUF_STRIDE			0x70b
 #define DC_WIN_UV_BUF_STRIDE			0x70c
 #define DC_WIN_BUFFER_ADDR_MODE			0x70d
-#define DC_WIN_BUFFER_ADDR_MODE_LINEAR		(0 <<  0)
-#define DC_WIN_BUFFER_ADDR_MODE_TILE		(1 <<  0)
-#define DC_WIN_BUFFER_ADDR_MODE_LINEAR_UV	(0 << 16)
-#define DC_WIN_BUFFER_ADDR_MODE_TILE_UV		(1 << 16)
+#define  DC_WIN_BUFFER_ADDR_MODE_LINEAR		(0 << 0)
+#define  DC_WIN_BUFFER_ADDR_MODE_TILE		BIT(0)
+#define  DC_WIN_BUFFER_ADDR_MODE_LINEAR_UV	(0 << 16)
+#define  DC_WIN_BUFFER_ADDR_MODE_TILE_UV	BIT(16)
 
 #define DC_WIN_DV_CONTROL			0x70e
 
 #define DC_WIN_BLEND_NOKEY			0x70f
-#define  BLEND_WEIGHT1(x) (((x) & 0xff) << 16)
-#define  BLEND_WEIGHT0(x) (((x) & 0xff) <<  8)
+#define  BLEND_WEIGHT1(x)			(((x) & 0xff) << 16)
+#define  BLEND_WEIGHT0(x)			(((x) & 0xff) <<  8)
 
 #define DC_WIN_BLEND_1WIN			0x710
-#define  BLEND_CONTROL_FIX    (0 << 2)
-#define  BLEND_CONTROL_ALPHA  (1 << 2)
-#define  BLEND_COLOR_KEY_NONE (0 << 0)
-#define  BLEND_COLOR_KEY_0    (1 << 0)
-#define  BLEND_COLOR_KEY_1    (2 << 0)
-#define  BLEND_COLOR_KEY_BOTH (3 << 0)
+#define  BLEND_CONTROL_FIX			(0 << 2)
+#define  BLEND_CONTROL_ALPHA			BIT(2)
+#define  BLEND_COLOR_KEY_NONE			0
+#define  BLEND_COLOR_KEY_0			1
+#define  BLEND_COLOR_KEY_1			2
+#define  BLEND_COLOR_KEY_BOTH			3
 
 #define DC_WIN_BLEND_2WIN_X			0x711
-#define  BLEND_CONTROL_DEPENDENT (2 << 2)
+#define  BLEND_CONTROL_DEPENDENT		(2 << 2)
 
 #define DC_WIN_BLEND_2WIN_Y			0x712
 #define DC_WIN_BLEND_3WIN_XY			0x713
@@ -715,10 +867,10 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 
 #define DC_WINBUF_UFLOW_STATUS			0x80a
 #define DC_WINBUF_SURFACE_KIND			0x80b
-#define DC_WINBUF_SURFACE_KIND_PITCH	(0 << 0)
-#define DC_WINBUF_SURFACE_KIND_TILED	(1 << 0)
-#define DC_WINBUF_SURFACE_KIND_BLOCK	(2 << 0)
-#define DC_WINBUF_SURFACE_KIND_BLOCK_HEIGHT(x) (((x) & 0x7) << 4)
+#define DC_WINBUF_SURFACE_KIND_PITCH		0
+#define DC_WINBUF_SURFACE_KIND_TILED		1
+#define DC_WINBUF_SURFACE_KIND_BLOCK		2
+#define DC_WINBUF_SURFACE_KIND_BLOCK_HEIGHT(x)	(((x) & 0x7) << 4)
 
 #define DC_WINBUF_START_ADDR_HI			0x80d
 
@@ -726,7 +878,7 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_WINBUF_START_ADDR_HI_V		0x811
 
 #define DC_WINBUF_CDE_CONTROL			0x82f
-#define  ENABLE_SURFACE (1 << 0)
+#define  ENABLE_SURFACE				BIT(0)
 
 #define DC_WINBUF_AD_UFLOW_STATUS		0xbca
 #define DC_WINBUF_BD_UFLOW_STATUS		0xdca
@@ -734,14 +886,14 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 
 /* Tegra186 and later */
 #define DC_DISP_CORE_SOR_SET_CONTROL(x)		(0x403 + (x))
-#define PROTOCOL_MASK (0xf << 8)
-#define PROTOCOL_SINGLE_TMDS_A (0x1 << 8)
+#define PROTOCOL_MASK				(0xf << 8)
+#define PROTOCOL_SINGLE_TMDS_A			(0x1 << 8)
 
 #define DC_DISP_CORE_HEAD_SET_CONTROL_OUTPUT_LUT	0x431
-#define  OUTPUT_LUT_MODE_MASK        (3 << 5)
-#define  OUTPUT_LUT_MODE_INTERPOLATE (1 << 5)
-#define  OUTPUT_LUT_SIZE_MASK        (3 << 1)
-#define  OUTPUT_LUT_SIZE_SIZE_1025   (2 << 1)
+#define  OUTPUT_LUT_MODE_MASK			(3 << 5)
+#define  OUTPUT_LUT_MODE_INTERPOLATE		(1 << 5)
+#define  OUTPUT_LUT_SIZE_MASK			(3 << 1)
+#define  OUTPUT_LUT_SIZE_SIZE_1025		(2 << 1)
 
 #define DC_DISP_COREPVT_HEAD_SET_OUTPUT_LUT_BASE	0x432
 #define DC_DISP_COREPVT_HEAD_SET_OUTPUT_LUT_BASE_HI	0x433
@@ -749,18 +901,18 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_DISP_PCALC_HEAD_SET_CROPPED_POINT_IN_CURSOR	0x442
 #define DC_DISP_PCALC_HEAD_SET_CROPPED_SIZE_IN_CURSOR	0x446
 
-#define DC_WINC_PRECOMP_WGRP_PIPE_CAPA 0x500
-#define DC_WINC_PRECOMP_WGRP_PIPE_CAPB 0x501
-#define DC_WINC_PRECOMP_WGRP_PIPE_CAPC 0x502
-#define  MAX_PIXELS_5TAP444(x) ((x) & 0xffff)
-#define DC_WINC_PRECOMP_WGRP_PIPE_CAPD 0x503
-#define DC_WINC_PRECOMP_WGRP_PIPE_CAPE 0x504
-#define  MAX_PIXELS_2TAP444(x) ((x) & 0xffff)
-#define DC_WINC_PRECOMP_WGRP_PIPE_CAPF 0x505
+#define DC_WINC_PRECOMP_WGRP_PIPE_CAPA		0x500
+#define DC_WINC_PRECOMP_WGRP_PIPE_CAPB		0x501
+#define DC_WINC_PRECOMP_WGRP_PIPE_CAPC		0x502
+#define  MAX_PIXELS_5TAP444(x)			((x) & 0xffff)
+#define DC_WINC_PRECOMP_WGRP_PIPE_CAPD		0x503
+#define DC_WINC_PRECOMP_WGRP_PIPE_CAPE		0x504
+#define  MAX_PIXELS_2TAP444(x)			((x) & 0xffff)
+#define DC_WINC_PRECOMP_WGRP_PIPE_CAPF		0x505
 
 #define DC_WIN_CORE_WINDOWGROUP_SET_CONTROL	0x702
-#define OWNER_MASK (0xf << 0)
-#define OWNER(x) (((x) & 0xf) << 0)
+#define OWNER_MASK				0xf
+#define OWNER(x)				((x) & 0xf)
 
 #define DC_WIN_CROPPED_SIZE			0x706
 
@@ -768,52 +920,52 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define DC_WIN_SET_INPUT_SCALER_V_START_PHASE	0x708
 
 #define DC_WIN_PLANAR_STORAGE			0x709
-#define PITCH(x) (((x) >> 6) & 0x1fff)
+#define PITCH(x)				(((x) >> 6) & 0x1fff)
 
 #define DC_WIN_PLANAR_STORAGE_UV		0x70a
-#define  PITCH_U(x) ((((x) >> 6) & 0x1fff) <<  0)
-#define  PITCH_V(x) ((((x) >> 6) & 0x1fff) << 16)
+#define  PITCH_U(x)				((((x) >> 6) & 0x1fff) <<  0)
+#define  PITCH_V(x)				((((x) >> 6) & 0x1fff) << 16)
 
 #define DC_WIN_SET_INPUT_SCALER_HPHASE_INCR	0x70b
 #define DC_WIN_SET_INPUT_SCALER_VPHASE_INCR	0x70c
 
 #define DC_WIN_SET_PARAMS			0x70d
-#define  CLAMP_BEFORE_BLEND (1 << 15)
-#define  DEGAMMA_NONE (0 << 13)
-#define  DEGAMMA_SRGB (1 << 13)
-#define  DEGAMMA_YUV8_10 (2 << 13)
-#define  DEGAMMA_YUV12 (3 << 13)
-#define  INPUT_RANGE_BYPASS (0 << 10)
-#define  INPUT_RANGE_LIMITED (1 << 10)
-#define  INPUT_RANGE_FULL (2 << 10)
-#define  COLOR_SPACE_RGB (0 << 8)
-#define  COLOR_SPACE_YUV_601 (1 << 8)
-#define  COLOR_SPACE_YUV_709 (2 << 8)
-#define  COLOR_SPACE_YUV_2020 (3 << 8)
+#define  CLAMP_BEFORE_BLEND			BIT(15)
+#define  DEGAMMA_NONE				(0 << 13)
+#define  DEGAMMA_SRGB				(1 << 13)
+#define  DEGAMMA_YUV8_10			(2 << 13)
+#define  DEGAMMA_YUV12				(3 << 13)
+#define  INPUT_RANGE_BYPASS			(0 << 10)
+#define  INPUT_RANGE_LIMITED			(1 << 10)
+#define  INPUT_RANGE_FULL			(2 << 10)
+#define  COLOR_SPACE_RGB			(0 << 8)
+#define  COLOR_SPACE_YUV_601			(1 << 8)
+#define  COLOR_SPACE_YUV_709			(2 << 8)
+#define  COLOR_SPACE_YUV_2020			(3 << 8)
 
 #define DC_WIN_WINDOWGROUP_SET_CONTROL_INPUT_SCALER	0x70e
-#define  HORIZONTAL_TAPS_2 (1 << 3)
-#define  HORIZONTAL_TAPS_5 (4 << 3)
-#define  VERTICAL_TAPS_2 (1 << 0)
-#define  VERTICAL_TAPS_5 (4 << 0)
+#define  HORIZONTAL_TAPS_2			(1 << 3)
+#define  HORIZONTAL_TAPS_5			(4 << 3)
+#define  VERTICAL_TAPS_2			1
+#define  VERTICAL_TAPS_5			4
 
 #define DC_WIN_WINDOWGROUP_SET_INPUT_SCALER_COEFF 0x70f
-#define  COEFF_INDEX(x) (((x) & 0xff) << 15)
-#define  COEFF_DATA(x) (((x) & 0x3ff) << 0)
+#define  COEFF_INDEX(x)				(((x) & 0xff) << 15)
+#define  COEFF_DATA(x)				((x) & 0x3ff)
 
 #define DC_WIN_WINDOWGROUP_SET_INPUT_SCALER_USAGE	0x711
-#define  INPUT_SCALER_USE422  (1 << 2)
-#define  INPUT_SCALER_VBYPASS (1 << 1)
-#define  INPUT_SCALER_HBYPASS (1 << 0)
+#define  INPUT_SCALER_USE422			BIT(2)
+#define  INPUT_SCALER_VBYPASS			BIT(1)
+#define  INPUT_SCALER_HBYPASS			BIT(0)
 
 #define DC_WIN_BLEND_LAYER_CONTROL		0x716
-#define  COLOR_KEY_NONE (0 << 25)
-#define  COLOR_KEY_SRC (1 << 25)
-#define  COLOR_KEY_DST (2 << 25)
-#define  BLEND_BYPASS (1 << 24)
-#define  K2(x) (((x) & 0xff) << 16)
-#define  K1(x) (((x) & 0xff) << 8)
-#define  WINDOW_LAYER_DEPTH(x) (((x) & 0xff) << 0)
+#define  COLOR_KEY_NONE				(0 << 25)
+#define  COLOR_KEY_SRC				(1 << 25)
+#define  COLOR_KEY_DST				(2 << 25)
+#define  BLEND_BYPASS				BIT(24)
+#define  K2(x)					(((x) & 0xff) << 16)
+#define  K1(x)					(((x) & 0xff) << 8)
+#define  WINDOW_LAYER_DEPTH(x)			((x) & 0xff)
 
 #define DC_WIN_BLEND_MATCH_SELECT		0x717
 #define  BLEND_FACTOR_DST_ALPHA_ZERO			(0 << 12)
@@ -832,23 +984,23 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define  BLEND_FACTOR_DST_COLOR_NEG_K1_TIMES_DST	(5 << 4)
 #define  BLEND_FACTOR_DST_COLOR_NEG_K1_TIMES_SRC	(6 << 4)
 #define  BLEND_FACTOR_DST_COLOR_NEG_K1			(7 << 4)
-#define  BLEND_FACTOR_SRC_COLOR_ZERO			(0 << 0)
-#define  BLEND_FACTOR_SRC_COLOR_ONE			(1 << 0)
-#define  BLEND_FACTOR_SRC_COLOR_K1			(2 << 0)
-#define  BLEND_FACTOR_SRC_COLOR_K1_TIMES_DST		(3 << 0)
-#define  BLEND_FACTOR_SRC_COLOR_NEG_K1_TIMES_DST	(4 << 0)
-#define  BLEND_FACTOR_SRC_COLOR_K1_TIMES_SRC		(5 << 0)
+#define  BLEND_FACTOR_SRC_COLOR_ZERO			0
+#define  BLEND_FACTOR_SRC_COLOR_ONE			1
+#define  BLEND_FACTOR_SRC_COLOR_K1			2
+#define  BLEND_FACTOR_SRC_COLOR_K1_TIMES_DST		3
+#define  BLEND_FACTOR_SRC_COLOR_NEG_K1_TIMES_DST	4
+#define  BLEND_FACTOR_SRC_COLOR_K1_TIMES_SRC		5
 
 #define DC_WIN_BLEND_NOMATCH_SELECT		0x718
 
 #define DC_WIN_PRECOMP_WGRP_PARAMS		0x724
-#define  SWAP_UV (1 << 0)
+#define  SWAP_UV				BIT(0)
 
 #define DC_WIN_WINDOW_SET_CONTROL		0x730
-#define  CONTROL_CSC_ENABLE (1 << 5)
+#define  CONTROL_CSC_ENABLE			BIT(5)
 
 #define DC_WINBUF_CROPPED_POINT			0x806
-#define OFFSET_Y(x) (((x) & 0xffff) << 16)
-#define OFFSET_X(x) (((x) & 0xffff) << 0)
+#define  OFFSET_Y(x)				(((x) & 0xffff) << 16)
+#define  OFFSET_X(x)				((x) & 0xffff)
 
 #endif /* TEGRA_DC_H */
diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index b6d09a8d8e5ea..addcecf8592b1 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -115,14 +115,14 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
 	value = tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(1));
 
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
-		value |= LHS_OUTPUT_POLARITY_LOW;
+		value |= BIT(PIN_LHS);
 	else
-		value &= ~LHS_OUTPUT_POLARITY_LOW;
+		value &= ~BIT(PIN_LHS);
 
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
-		value |= LVS_OUTPUT_POLARITY_LOW;
+		value |= BIT(PIN_LVS);
 	else
-		value &= ~LVS_OUTPUT_POLARITY_LOW;
+		value &= ~BIT(PIN_LVS);
 
 	tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(1));
 
-- 
2.53.0

