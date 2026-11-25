Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D5606A688
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=01JPzDcM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4DE10E4D4;
	Wed, 25 Nov 2026 11:26:44 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFB5510FB99
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:26:37 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6b87408c797so7657553a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605996; x=1796210796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rWpbX/vYwiebhQRZPaBF9yNLbUVowat2Q+uVt+ng6uo=;
 b=01JPzDcMK+30/T5wHOiptAIaH4YbjPUo7SCw+ca9/XWOr66FbXnqo4/v7ZVraw0LZn
 7hE34wMkFCROswpeNhjO3iLpuU51Cc98g2BAmhNF0qfXsXs4SmTzDutlYHod/kXfETyF
 W+w54iqYAfOjhO1cl8pxq9cgeIY5vdIqdfGovV8C4OJ5r67yysqakWFkFV0KzqZ6bkZQ
 kk9uZgxRcoieltcBSlNo7rVqqSn999gWyg0tIbM7GAgNKFzfFGyiEwdwa+mwUA0M1+Rd
 1XHrX3dTT0HhaNO9exSADixIUYSOnY/jE8DGi4+McjesIKfmhuHJhHxC0l7gqMA9v/es
 c+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605996; x=1796210796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rWpbX/vYwiebhQRZPaBF9yNLbUVowat2Q+uVt+ng6uo=;
 b=B0ftX6pfutUds4UQoiiI8hgMRu7SxnocIXd9tWkwrXTLaHynFKkNHRU4w9feCOwPWC
 G2rgmA3ZvMX3BebpuNLP8MF9bcYYbsbe2Kg1nNDVv/GJ14XYKebqT+81MFTbYOptzCQu
 mdOtM8Ooz09w391RoeSY6zYRq8wnukosEzyt4uaDNsoaHYFY08lNlvqA41sQMc4lMteq
 ExENsoC4eoC7oV53WRUHF6A51dG495ZRF5mplDhY4SZZcMMkRVytnWB3aaEcqnnZiYwF
 rRSLkQzbFI2WsJHNfOx2pCzk6fcVl3dqxLO60vjB1EPYFwKEfQoaysRZZgGXF4Ub+kE/
 httg==
X-Forwarded-Encrypted: i=1;
 AL+hErF+pyEnNEH/DlfYCktSKXCO6AgassCPbrQ1h4rwkRHLJWjPkXjAX7VPGDZ0N2xM1TfEK4GUQvAn7Rk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/zx64QM3WaVQUjo71De4LcMO2JE7N7dj57ouCflGUwa+HGPhza
 tCTQvv5wwzIuLXBT1q3vJqn+PKS58L5gS1tyFE3bQASm3B/lcGAsL0S8
X-Gm-Gg: AZFdTZdHXoxZ753JXRaXKAzxtuRp1R8vJNjE0+crumRSC8JoR1u072z5m/G+m+aZali
 Dvoprp4qVCJKrZiFmv69sh0uWoZljPltQK9Pnx3TBCy/+qk2DNkDkWJKf9/EO01YM3eLnIJSC8R
 hxh3pcwLRMfhIwGVI4Hc/EpUgENBJllImYQZVUNoQyToYWbSDYN8xlxkTgalulVzsGrNEIWCG3K
 2RRl9lxWc2KLpRqVsQjOKHQGEX1KRz0fzPqcm1f9tyO7ZmjFVxe9N/6Y2M5GFKQOzP1SkMlTTgx
 4126aToq+MRwYrPR3Y2/QDDnAT4uNa57e+TOerI514+rjjzlksGnkozSDOWnB93/VrfeYRGpDAf
 Tvz5JQEwff7E9WO9+bAhfZrUi2HFhwOJg1JMcHOPO5cieC7Pvdqlg17g+s2HQkIYbnVC+6igZkv
 o2zcbAl0tSs1SLaK9Vjvn93iEuS8pTUIDrf38YUVUT5DQoy4cDybD6PJVhvJgdqAtA4YpQHAyi8
 MX2BQrkH/id51oUf7Vi0sxiOLfj5zivEVyVfieKXKxxdffSDB57VaUfW26zVlD11JCDFF1tYilL
 GZJr1gJW/bLZpVXYWvpdQeZ3hyqV3xWyyWy/J0Mg4z1HSTSxSJohXDdeBi/lNmWTNdGnuinwV1F
 Yb/GBLRsw6A==
X-Received: by 2002:a05:6402:44d2:b0:6b4:5d8c:95e2 with SMTP id
 4fb4d7f45d1cf-6ba37c7a0dfmr10119116a12.4.1795605995977; 
 Wed, 25 Nov 2026 03:26:35 -0800 (PST)
Received: from xeon ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6bb1b93a8efsm1202907a12.7.2026.11.25.03.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:26:35 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 5/7] media: tegra-video: Add CSI support for Tegra114
Date: Wed, 25 Nov 2026 13:26:11 +0200
Message-ID: <20261125112613.237333-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125112613.237333-1-clamor95@gmail.com>
References: <20261125112613.237333-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The VI implementation used in previous generations is fully compatible
with Tegra114 and remains hardware revision 1, making this a relatively
small patch. Tegra114 supports a higher maximum VI clock frequency of
408 MHz, meaning the Tegra30 compatible cannot be used as a fallback.

The CSI block in Tegra114 is more advanced than the one in Tegra30. It
has three additional lane clocks, both CSI A and B ports have two CIL
pads per port, and the MIPI calibration logic has been moved into a
dedicated block. The Tegra114 CSI also supports an additional CSI-C
output, but since there are no known hardware configurations using it,
it is omitted due to a lack of test hardware.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../platform/nvidia/tegra-video/Makefile      |   1 +
 .../media/platform/nvidia/tegra-video/csi.c   |   3 +
 .../media/platform/nvidia/tegra-video/csi.h   |   6 +
 .../platform/nvidia/tegra-video/tegra20.c     | 149 ++++++++++++++++--
 .../platform/nvidia/tegra-video/tegra210.c    |   1 +
 .../media/platform/nvidia/tegra-video/vi.c    |   3 +
 .../media/platform/nvidia/tegra-video/vi.h    |   3 +
 .../media/platform/nvidia/tegra-video/video.c |   4 +
 8 files changed, 156 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/nvidia/tegra-video/Makefile b/drivers/media/platform/nvidia/tegra-video/Makefile
index 96380b5dbd8bb..787496ad2f442 100644
--- a/drivers/media/platform/nvidia/tegra-video/Makefile
+++ b/drivers/media/platform/nvidia/tegra-video/Makefile
@@ -7,5 +7,6 @@ tegra-video-objs := \
 
 tegra-video-$(CONFIG_ARCH_TEGRA_2x_SOC)  += tegra20.o
 tegra-video-$(CONFIG_ARCH_TEGRA_3x_SOC)  += tegra20.o
+tegra-video-$(CONFIG_ARCH_TEGRA_114_SOC) += tegra20.o
 tegra-video-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210.o
 obj-$(CONFIG_VIDEO_TEGRA) += tegra-video.o
diff --git a/drivers/media/platform/nvidia/tegra-video/csi.c b/drivers/media/platform/nvidia/tegra-video/csi.c
index fb4b4c0c7cfcd..617ca44d23026 100644
--- a/drivers/media/platform/nvidia/tegra-video/csi.c
+++ b/drivers/media/platform/nvidia/tegra-video/csi.c
@@ -1017,6 +1017,9 @@ static const struct of_device_id tegra_csi_of_id_table[] = {
 #if defined(CONFIG_ARCH_TEGRA_3x_SOC)
 	{ .compatible = "nvidia,tegra30-csi", .data = &tegra30_csi_soc },
 #endif
+#if defined(CONFIG_ARCH_TEGRA_114_SOC)
+	{ .compatible = "nvidia,tegra114-csi", .data = &tegra114_csi_soc },
+#endif
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
 	{ .compatible = "nvidia,tegra210-csi", .data = &tegra210_csi_soc },
 #endif
diff --git a/drivers/media/platform/nvidia/tegra-video/csi.h b/drivers/media/platform/nvidia/tegra-video/csi.h
index addd1b82685e9..51667bba74e0b 100644
--- a/drivers/media/platform/nvidia/tegra-video/csi.h
+++ b/drivers/media/platform/nvidia/tegra-video/csi.h
@@ -119,6 +119,8 @@ struct tegra_csi_ops {
  * @num_clks: total clocks count
  * @tpg_frmrate_table: csi tpg frame rate table with blanking intervals
  * @tpg_frmrate_table_size: size of frame rate table
+ * @has_paired_cil: indicates that cil pads are paired per port, this is
+ *		    specific for Tegra114 where each port has 2 cil pads
  */
 struct tegra_csi_soc {
 	const struct tegra_csi_ops *ops;
@@ -128,6 +130,7 @@ struct tegra_csi_soc {
 	unsigned int num_clks;
 	const struct tpg_framerate *tpg_frmrate_table;
 	unsigned int tpg_frmrate_table_size;
+	bool has_paired_cil;
 };
 
 #if defined(CONFIG_ARCH_TEGRA_2x_SOC)
@@ -136,6 +139,9 @@ extern const struct tegra_csi_soc tegra20_csi_soc;
 #if defined(CONFIG_ARCH_TEGRA_3x_SOC)
 extern const struct tegra_csi_soc tegra30_csi_soc;
 #endif
+#if defined(CONFIG_ARCH_TEGRA_114_SOC)
+extern const struct tegra_csi_soc tegra114_csi_soc;
+#endif
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
 extern const struct tegra_csi_soc tegra210_csi_soc;
 #endif
diff --git a/drivers/media/platform/nvidia/tegra-video/tegra20.c b/drivers/media/platform/nvidia/tegra-video/tegra20.c
index c8a8fb3cbba0f..31cd503df9fa6 100644
--- a/drivers/media/platform/nvidia/tegra-video/tegra20.c
+++ b/drivers/media/platform/nvidia/tegra-video/tegra20.c
@@ -217,8 +217,21 @@ enum tegra_vi_out {
 #define       CSI_B_PHY_CIL_ENABLE			(0x1 << 16)
 #define       CSI_B_PHY_CIL_DISABLE			(0x2 << 16)
 #define       CSI_B_PHY_CIL_ENABLE_MASK			(0x3 << 16)
+#define       CSI_C_PHY_CIL_NOP				(0x0 << 20)
+#define       CSI_C_PHY_CIL_ENABLE			(0x1 << 20)
+#define       CSI_C_PHY_CIL_DISABLE			(0x2 << 20)
+#define       CSI_C_PHY_CIL_ENABLE_MASK			(0x3 << 20)
+#define       CSI_D_PHY_CIL_NOP				(0x0 << 24)
+#define       CSI_D_PHY_CIL_ENABLE			(0x1 << 24)
+#define       CSI_D_PHY_CIL_DISABLE			(0x2 << 24)
+#define       CSI_D_PHY_CIL_ENABLE_MASK			(0x3 << 24)
+#define       CSI_E_PHY_CIL_NOP				(0x0 << 28)
+#define       CSI_E_PHY_CIL_ENABLE			(0x1 << 28)
+#define       CSI_E_PHY_CIL_DISABLE			(0x2 << 28)
+#define       CSI_E_PHY_CIL_ENABLE_MASK			(0x3 << 28)
 #define TEGRA_CSI_PHY_CIL_CONTROL0(n)			(0x006c + (n) * 4)
 #define       CSI_CONTINUOUS_CLOCK_MODE_ENABLE		BIT(5)
+#define       CSI_DEFAULT_CLOCK_SETTLE_TIME		0x5
 #define TEGRA_CSI_CSI_PIXEL_PARSER_STATUS		0x0078
 #define TEGRA_CSI_CSI_CIL_STATUS			0x007c
 #define       CSI_MIPI_AUTO_CAL_DONE			BIT(15)
@@ -262,6 +275,19 @@ enum tegra_vi_out {
 #define       CSI_PAD_TERM_REF(n)			(((n) & 0x7) << 0)
 #define TEGRA_CSI_CSI_CILA_STATUS			0x00d8
 #define TEGRA_CSI_CSI_CILB_STATUS			0x00dc
+#define TEGRA_CSI_CSI_CILC_STATUS			0x00e4
+#define TEGRA_CSI_CSI_CILD_STATUS			0x00e8
+#define TEGRA_CSI_PHY_CILC_CONTROL0			0x00f8
+#define TEGRA_CSI_PHY_CILD_CONTROL0			0x00fc
+#define TEGRA_CSI_PHY_CILE_CONTROL0			0x010c
+#define TEGRA_CSI_CSI_CIL_STATUS_2			0x0110
+#define TEGRA_CSI_CSI_CIL_INTERRUPT_MASK_2		0x0114
+#define TEGRA_CSI_CILC_PAD_CONFIG0			0x0128
+#define TEGRA_CSI_CILC_PAD_CONFIG1			0x012c
+#define TEGRA_CSI_CILD_PAD_CONFIG0			0x0130
+#define TEGRA_CSI_CILD_PAD_CONFIG1			0x0134
+#define TEGRA_CSI_CILE_PAD_CONFIG0			0x0138
+#define TEGRA_CSI_CILE_PAD_CONFIG1			0x013c
 
 /* --------------------------------------------------------------------------
  * Read and Write helpers
@@ -892,6 +918,17 @@ const struct tegra_vi_soc tegra30_vi_soc = {
 	.has_h_v_flip = true,
 };
 
+const struct tegra_vi_soc tegra114_vi_soc = {
+	.video_formats = tegra20_video_formats,
+	.nformats = ARRAY_SIZE(tegra20_video_formats),
+	.default_video_format = &tegra20_video_formats[0],
+	.ops = &tegra30_vi_ops,
+	.hw_revision = 1,
+	.vi_max_channels = 2,
+	.vi_max_clk_hz = 408000000,
+	.has_h_v_flip = true,
+};
+
 /* --------------------------------------------------------------------------
  * MIPI Calibration
  */
@@ -1019,6 +1056,8 @@ static const struct tegra_mipi_ops tegra20_mipi_ops = {
  */
 static void tegra20_csi_capture_clean(struct tegra_csi_channel *csi_chan)
 {
+	struct tegra_csi *csi = csi_chan->csi;
+
 	tegra20_csi_write(csi_chan, TEGRA_CSI_VI_INPUT_STREAM_CONTROL, 0);
 	tegra20_csi_write(csi_chan, TEGRA_CSI_HOST_INPUT_STREAM_CONTROL, 0);
 
@@ -1034,6 +1073,11 @@ static void tegra20_csi_capture_clean(struct tegra_csi_channel *csi_chan)
 	tegra20_csi_write(csi_chan, TEGRA_CSI_CIL_MIPI_CAL_STATUS, 0);
 	tegra20_csi_write(csi_chan, TEGRA_CSI_CLKEN_OVERRIDE, 0);
 
+	if (csi->soc->has_paired_cil) {
+		tegra20_csi_write(csi_chan, TEGRA_CSI_CSI_CIL_STATUS_2, 0);
+		tegra20_csi_write(csi_chan, TEGRA_CSI_CSI_CIL_INTERRUPT_MASK_2, 0);
+	}
+
 	tegra20_csi_write(csi_chan, TEGRA_CSI_DEBUG_CONTROL,
 			  CSI_DEBUG_CONTROL_CLR_DBG_CNT_0 |
 			  CSI_DEBUG_CONTROL_CLR_DBG_CNT_1 |
@@ -1044,6 +1088,7 @@ static int tegra20_csi_port_start_streaming(struct tegra_csi_channel *csi_chan,
 					    u8 portno)
 {
 	struct tegra_vi_channel *vi_chan = v4l2_get_subdev_hostdata(&csi_chan->subdev);
+	struct tegra_csi *csi = csi_chan->csi;
 	int width  = vi_chan->format.width;
 	int height = vi_chan->format.height;
 	u32 data_type = vi_chan->fmtinfo->img_dt;
@@ -1077,9 +1122,30 @@ static int tegra20_csi_port_start_streaming(struct tegra_csi_channel *csi_chan,
 	tegra20_csi_write(csi_chan, TEGRA_CSI_PIXEL_STREAM_GAP(port), 0);
 	tegra20_csi_write(csi_chan, TEGRA_CSI_PIXEL_STREAM_PP_COMMAND(port), 0);
 	tegra20_csi_write(csi_chan, TEGRA_CSI_PIXEL_STREAM_EXPECTED_FRAME(port), 0);
-	tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_CONTROL0(port), 0);
-	tegra20_csi_write(csi_chan, TEGRA_CSI_CIL_PAD_CONFIG0(port), 0);
-	tegra20_csi_write(csi_chan, TEGRA_CSI_CIL_PAD_CONFIG1(port), 0);
+
+	if (csi->soc->has_paired_cil) {
+		if (port == PORT_A) {
+			tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_CONTROL0(port), 0);
+			tegra20_csi_write(csi_chan, TEGRA_CSI_CIL_PAD_CONFIG0(port), 0);
+			tegra20_csi_write(csi_chan, TEGRA_CSI_CIL_PAD_CONFIG1(port), 0);
+
+			tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_CONTROL0(port + 1), 0);
+			tegra20_csi_write(csi_chan, TEGRA_CSI_CIL_PAD_CONFIG0(port + 1), 0);
+			tegra20_csi_write(csi_chan, TEGRA_CSI_CIL_PAD_CONFIG1(port + 1), 0);
+		} else {
+			tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CILC_CONTROL0, 0);
+			tegra20_csi_write(csi_chan, TEGRA_CSI_CILC_PAD_CONFIG0, 0);
+			tegra20_csi_write(csi_chan, TEGRA_CSI_CILC_PAD_CONFIG1, 0);
+
+			tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CILD_CONTROL0, 0);
+			tegra20_csi_write(csi_chan, TEGRA_CSI_CILD_PAD_CONFIG0, 0);
+			tegra20_csi_write(csi_chan, TEGRA_CSI_CILD_PAD_CONFIG1, 0);
+		}
+	} else {
+		tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_CONTROL0(port), 0);
+		tegra20_csi_write(csi_chan, TEGRA_CSI_CIL_PAD_CONFIG0(port), 0);
+		tegra20_csi_write(csi_chan, TEGRA_CSI_CIL_PAD_CONFIG1(port), 0);
+	}
 
 	tegra20_vi_write(vi_chan, TEGRA_VI_VI_CORE_CONTROL, BIT(25 + port)); /* CSI_PP_YUV422 */
 
@@ -1113,9 +1179,18 @@ static int tegra20_csi_port_start_streaming(struct tegra_csi_channel *csi_chan,
 			  CSI_SKIP_PACKET_THRESHOLD(0x3f) |
 			  (csi_chan->numlanes - 1));
 
-	tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_CONTROL0(port),
-			  CSI_CONTINUOUS_CLOCK_MODE_ENABLE |
-			  0x5); /* Clock settle time */
+	value = CSI_CONTINUOUS_CLOCK_MODE_ENABLE | CSI_DEFAULT_CLOCK_SETTLE_TIME;
+	if (csi->soc->has_paired_cil) {
+		if (port == PORT_A) {
+			tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_CONTROL0(port), value);
+			tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_CONTROL0(port + 1), value);
+		} else {
+			tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CILC_CONTROL0, value);
+			tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CILD_CONTROL0, value);
+		}
+	} else {
+		tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_CONTROL0(port), value);
+	}
 
 	tegra20_vi_write(vi_chan, TEGRA_VI_CONT_SYNCPT_CSI_PP_FRAME_START(port),
 			 VI_CONT_SYNCPT_OUT_CONTINUOUS_SYNCPT |
@@ -1127,8 +1202,18 @@ static int tegra20_csi_port_start_streaming(struct tegra_csi_channel *csi_chan,
 			 host1x_syncpt_id(vi_chan->mw_ack_sp[0])
 			 << VI_CONT_SYNCPT_OUT_SYNCPT_IDX_SFT);
 
-	value = (port == PORT_A) ? CSI_A_PHY_CIL_ENABLE | CSI_B_PHY_CIL_DISABLE :
-		CSI_B_PHY_CIL_ENABLE | CSI_A_PHY_CIL_DISABLE;
+	if (csi->soc->has_paired_cil) {
+		if (port == PORT_A)
+			value = CSI_A_PHY_CIL_ENABLE | CSI_B_PHY_CIL_ENABLE |
+				CSI_C_PHY_CIL_DISABLE | CSI_D_PHY_CIL_DISABLE;
+		else
+			value = CSI_A_PHY_CIL_DISABLE | CSI_B_PHY_CIL_DISABLE |
+				CSI_C_PHY_CIL_ENABLE | CSI_D_PHY_CIL_ENABLE;
+	} else {
+		value = (port == PORT_A) ? CSI_A_PHY_CIL_ENABLE | CSI_B_PHY_CIL_DISABLE :
+			CSI_B_PHY_CIL_ENABLE | CSI_A_PHY_CIL_DISABLE;
+	}
+
 	tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_COMMAND, value);
 
 	tegra20_csi_write(csi_chan, TEGRA_CSI_PIXEL_STREAM_PP_COMMAND(port),
@@ -1157,17 +1242,34 @@ static void tegra20_csi_port_stop_streaming(struct tegra_csi_channel *csi_chan,
 	dev_dbg(csi->dev, "TEGRA_CSI_CSI_CIL_STATUS 0x%08x\n", value);
 	tegra20_csi_write(csi_chan, TEGRA_CSI_CSI_CIL_STATUS, value);
 
+	if (csi->soc->has_paired_cil) {
+		value = tegra20_csi_read(csi_chan, TEGRA_CSI_CSI_CIL_STATUS_2);
+		dev_dbg(csi->dev, "TEGRA_CSI_CSI_CIL_STATUS_2 0x%08x\n", value);
+		tegra20_csi_write(csi_chan, TEGRA_CSI_CSI_CIL_STATUS_2, value);
+	}
+
 	tegra20_csi_write(csi_chan, TEGRA_CSI_PIXEL_STREAM_PP_COMMAND(port),
 			  CSI_PP_START_MARKER_FRAME_MAX(0xf) |
 			  CSI_PP_DISABLE);
 
-	if (csi_chan->numlanes == 4) {
-		tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_COMMAND,
-				  CSI_A_PHY_CIL_DISABLE | CSI_B_PHY_CIL_DISABLE);
-	} else {
-		value = (port == PORT_A) ? CSI_A_PHY_CIL_DISABLE | CSI_B_PHY_CIL_NOP :
-			CSI_B_PHY_CIL_DISABLE | CSI_A_PHY_CIL_NOP;
+	if (csi->soc->has_paired_cil) {
+		if (port == PORT_A)
+			value = CSI_A_PHY_CIL_DISABLE | CSI_B_PHY_CIL_DISABLE |
+				CSI_C_PHY_CIL_NOP | CSI_D_PHY_CIL_NOP;
+		else
+			value = CSI_A_PHY_CIL_NOP | CSI_B_PHY_CIL_NOP |
+				CSI_C_PHY_CIL_DISABLE | CSI_D_PHY_CIL_DISABLE;
+
 		tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_COMMAND, value);
+	} else {
+		if (csi_chan->numlanes == 4) {
+			tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_COMMAND,
+					  CSI_A_PHY_CIL_DISABLE | CSI_B_PHY_CIL_DISABLE);
+		} else {
+			value = (port == PORT_A) ? CSI_A_PHY_CIL_DISABLE | CSI_B_PHY_CIL_NOP :
+				CSI_B_PHY_CIL_DISABLE | CSI_A_PHY_CIL_NOP;
+			tegra20_csi_write(csi_chan, TEGRA_CSI_PHY_CIL_COMMAND, value);
+		}
 	}
 }
 
@@ -1215,6 +1317,7 @@ const struct tegra_csi_soc tegra20_csi_soc = {
 	.csi_max_channels = 2, /* CSI-A and CSI-B */
 	.clk_names = tegra20_csi_clks,
 	.num_clks = ARRAY_SIZE(tegra20_csi_clks),
+	.has_paired_cil = false,
 };
 
 static const char * const tegra30_csi_clks[] = {
@@ -1229,6 +1332,24 @@ const struct tegra_csi_soc tegra30_csi_soc = {
 	.csi_max_channels = 2, /* CSI-A and CSI-B */
 	.clk_names = tegra30_csi_clks,
 	.num_clks = ARRAY_SIZE(tegra30_csi_clks),
+	.has_paired_cil = false,
+};
+
+static const char * const tegra114_csi_clks[] = {
+	"csi",
+	"csia-pad",
+	"csib-pad",
+	"cilab",
+	"cilcd",
+	"cile",
+};
+
+const struct tegra_csi_soc tegra114_csi_soc = {
+	.ops = &tegra20_csi_ops,
+	.csi_max_channels = 2, /* CSI-A and CSI-B */
+	.clk_names = tegra114_csi_clks,
+	.num_clks = ARRAY_SIZE(tegra114_csi_clks),
+	.has_paired_cil = true,
 };
 
 /* --------------------------------------------------------------------------
diff --git a/drivers/media/platform/nvidia/tegra-video/tegra210.c b/drivers/media/platform/nvidia/tegra-video/tegra210.c
index 474f906e8bcc6..5b2a798fc5b09 100644
--- a/drivers/media/platform/nvidia/tegra-video/tegra210.c
+++ b/drivers/media/platform/nvidia/tegra-video/tegra210.c
@@ -1304,4 +1304,5 @@ const struct tegra_csi_soc tegra210_csi_soc = {
 	.num_clks = ARRAY_SIZE(tegra210_csi_cil_clks),
 	.tpg_frmrate_table = tegra210_tpg_frmrate_table,
 	.tpg_frmrate_table_size = ARRAY_SIZE(tegra210_tpg_frmrate_table),
+	.has_paired_cil = false,
 };
diff --git a/drivers/media/platform/nvidia/tegra-video/vi.c b/drivers/media/platform/nvidia/tegra-video/vi.c
index 52384af92d8a6..3cbec543c5d86 100644
--- a/drivers/media/platform/nvidia/tegra-video/vi.c
+++ b/drivers/media/platform/nvidia/tegra-video/vi.c
@@ -1414,6 +1414,9 @@ static const struct of_device_id tegra_vi_of_id_table[] = {
 #if defined(CONFIG_ARCH_TEGRA_3x_SOC)
 	{ .compatible = "nvidia,tegra30-vi",  .data = &tegra30_vi_soc },
 #endif
+#if defined(CONFIG_ARCH_TEGRA_114_SOC)
+	{ .compatible = "nvidia,tegra114-vi", .data = &tegra114_vi_soc },
+#endif
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
 	{ .compatible = "nvidia,tegra210-vi", .data = &tegra210_vi_soc },
 #endif
diff --git a/drivers/media/platform/nvidia/tegra-video/vi.h b/drivers/media/platform/nvidia/tegra-video/vi.h
index 965357ebaf0a3..3927f1d827ec5 100644
--- a/drivers/media/platform/nvidia/tegra-video/vi.h
+++ b/drivers/media/platform/nvidia/tegra-video/vi.h
@@ -297,6 +297,9 @@ extern const struct tegra_vi_soc tegra20_vi_soc;
 #if defined(CONFIG_ARCH_TEGRA_3x_SOC)
 extern const struct tegra_vi_soc tegra30_vi_soc;
 #endif
+#if defined(CONFIG_ARCH_TEGRA_114_SOC)
+extern const struct tegra_vi_soc tegra114_vi_soc;
+#endif
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
 extern const struct tegra_vi_soc tegra210_vi_soc;
 #endif
diff --git a/drivers/media/platform/nvidia/tegra-video/video.c b/drivers/media/platform/nvidia/tegra-video/video.c
index d483fb709d127..55c17e7c930a2 100644
--- a/drivers/media/platform/nvidia/tegra-video/video.c
+++ b/drivers/media/platform/nvidia/tegra-video/video.c
@@ -132,6 +132,10 @@ static const struct of_device_id host1x_video_subdevs[] = {
 	{ .compatible = "nvidia,tegra30-csi", },
 	{ .compatible = "nvidia,tegra30-vi", },
 #endif
+#if defined(CONFIG_ARCH_TEGRA_114_SOC)
+	{ .compatible = "nvidia,tegra114-csi", },
+	{ .compatible = "nvidia,tegra114-vi", },
+#endif
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
 	{ .compatible = "nvidia,tegra210-csi", },
 	{ .compatible = "nvidia,tegra210-vi", },
-- 
2.53.0

