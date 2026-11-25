Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7738E606A334
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ddcgk1yH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC06010FB93;
	Wed, 25 Nov 2026 11:26:55 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A940810FB93
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:26:34 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6bab377105dso4097265a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605992; x=1796210792; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+V+MlFiMVbooH1RFDYNaob+l7nWjCw8PYj3aOGxI4TY=;
 b=Ddcgk1yHt4umpaVPPAisjU87qsr823X6wCfeCrVSA0xnl5SFdNl83OU7YNeCy7vEpO
 aqkdGAEPyhNhihlmoCAlL4VouiegXz9QGMX+QwLlhkpJxdLyYaXGRNbFQhHkJw3Ekizs
 vkQw4tXKO6jBXvImEs3roLrRlxOLKAJ3ecU+/yaa/6VA4OPlPSm+vRE7L8Z028Q7VqKE
 p2uIzSIr2lx3cfATzwulZKR8rRVGHUur4RNrDl3MYxAhDenCh0y24eevb1UJMY+KO9Wb
 vIvEhI7pI5eq3uuW5uB2E3avYlMVX0U8Ok2o1A1GoFHjVvHJ9TTeBg0Ao/N1w+xZ6Wi8
 fU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605992; x=1796210792;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+V+MlFiMVbooH1RFDYNaob+l7nWjCw8PYj3aOGxI4TY=;
 b=m7mgMNaQUtq46NF/xXzuS0/gHlUuke61gmgbao4o2s1731Bdr/KXiMBM048T4JKjbk
 yg1e2HEtS51h3Tpd+8RERhWYB3ycbDBtFSvTRi6B4/PLYa+EE4jvEUTl4/pccvGuH4CE
 pq2u2lyYMXLZ6mb6eI4Z5iH7sb2M3t2N8sue3Ow49A2iAVFHm/gJctEXV283sGWyi/I3
 alPe0FioqgwfHGDR8YIZHzNjwwHukZSsACKyfPM8r9VSUJ6aMX1jz5rRpjRUsMRyfqED
 spTMrgsYmF0STGA7Z+AKgiwrSI2uBBN3MGNCctp9SK9TsCuhxD2JkQTayGa8XWOn5OL1
 T+0w==
X-Forwarded-Encrypted: i=1;
 AL+hErEeHrzUHvoY9LVPlYoWAvxCWpYqkLaE2VvRdiDuU3tnYg+MJoVbs+W6ZVMCZsr43Vmh1n4VcgocMUM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9YuYoklK/ymUfhc/fp4hpmewRVKmIPvrmS1aJDlt9nvgGw4RP9
 HQUKO464LdkNP3GAbOb0daGZphlk2Xj9PLWnjo/ZMX3tfE4rQOxhd4RLiD6A8w==
X-Gm-Gg: AZFdTZeHzp3jhLRQAkTr7DGtP5nGQLrqx64LBY8G/7HatHTEBO1/ml1JeyH3z3MC6Q5
 QWGz2CeLdcfPHoLg/eWv6Ayxk6yXkwteKbM6HenYgkPbpLtPh58kN9j2OpnmJyLr9dlSi1CSyWp
 cs9uOB2HBb8gTtrV1G3ixQYs2HMVORzug0gR9h3CAKw2QxSs18PeRpZqlAQpZTB9E0JpIfkAO2R
 4Lm90OIHBS82nWZfbhklwgvIBh+fvcIS1snnvGmP81e2qS2Yp4KjyNdXrra6EFxttTbv5nHnfuJ
 3iXcoePVIMNa+C43VGADSMHBB6di6PVTZjYQY9UvrVspqLLMKie+XUOZRncGLTG6YLowc5Hqxeo
 jFuP1+ev38G9Eg82tpsn3By/BVZVBQcnhTK2X9hJGOgvWQjtBO+8LsNgRiQjEUC7uoAoS5x4l+7
 pg78/D1m6rgO98LvSrkAmaGWXefVTPMMkSe9o1DZSo4ZlCOBd13UYf1MdtDknrUHBB2LLEyUs7y
 RB0F5RhsWRjRakohWhxbvND749TfQFYs3AzOxn56mXxcZi4o9D2U1mdJfkTzeK7XMHu0ckJvhmJ
 5Ka8gBpq/tq+1AhXsNev3T6bNK+ia3+Sh10yas/reTLTR0Z9SV42O42kbGQN+ltfDIiIqqwcv9D
 rzlGjmosR5A==
X-Received: by 2002:a05:6402:3222:b0:6b2:2339:370d with SMTP id
 4fb4d7f45d1cf-6ba37ec485cmr14832157a12.39.1795605991602; 
 Wed, 25 Nov 2026 03:26:31 -0800 (PST)
Received: from xeon ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6bb1b93a8efsm1202907a12.7.2026.11.25.03.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:26:31 -0800 (PST)
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
Subject: [PATCH v2 2/7] media: tegra-video: vi: Diverge Tegra20 and Tegra30 VI
 SoC descriptions
Date: Wed, 25 Nov 2026 13:26:08 +0200
Message-ID: <20261125112613.237333-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125112613.237333-1-clamor95@gmail.com>
References: <20261125112613.237333-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Further investigation shows that the current maximum VI clock rate is too
high for Tegra20 and is better suited for Tegra30. The correct clock
frequency for Tegra20 should be 150 MHz, as it was set prior to the
addition of Tegra30 VI support — a value backed up by the current Tegra20
peripheral OPP table. Tegra30 supports up to 470 MHz for the VI clock,
but this rate is available only on higher-end Tegra30 SoC variants. The
highest clock rate supported across all SoC variants is 300 MHz.

Diverge the Tegra20 and Tegra30 VI SoC descriptions to account for maximum VI
clock limits, setting 150 MHz for Tegra20 and 300 MHz for Tegra30.
Additionally, remove the APB_MISC workaround for Tegra30, as it is Tegra20
specific.

Fixes: 071fa83ded5e ("staging: media: tegra-video: tegra20: increase maximum VI clock frequency")
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../platform/nvidia/tegra-video/tegra20.c     | 22 ++++++++++++++++++-
 .../media/platform/nvidia/tegra-video/vi.c    |  5 ++++-
 .../media/platform/nvidia/tegra-video/vi.h    |  5 ++++-
 .../media/platform/nvidia/tegra-video/video.c |  3 ++-
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/nvidia/tegra-video/tegra20.c b/drivers/media/platform/nvidia/tegra-video/tegra20.c
index f8d2b5e1b4131..c8a8fb3cbba0f 100644
--- a/drivers/media/platform/nvidia/tegra-video/tegra20.c
+++ b/drivers/media/platform/nvidia/tegra-video/tegra20.c
@@ -825,6 +825,15 @@ static const struct tegra_vi_ops tegra20_vi_ops = {
 	.vi_stop_streaming = tegra20_vi_stop_streaming,
 };
 
+static const struct tegra_vi_ops tegra30_vi_ops = {
+	.channel_host1x_syncpt_init = tegra20_channel_host1x_syncpt_init,
+	.channel_host1x_syncpt_free = tegra20_channel_host1x_syncpt_free,
+	.vi_fmt_align = tegra20_fmt_align,
+	.channel_queue_setup = tegra20_channel_queue_setup,
+	.vi_start_streaming = tegra20_vi_start_streaming,
+	.vi_stop_streaming = tegra20_vi_stop_streaming,
+};
+
 #define TEGRA20_VIDEO_FMT(DATA_TYPE, BIT_WIDTH, MBUS_CODE, BPP, FOURCC)	\
 {									\
 	.img_dt		= TEGRA_IMAGE_DT_##DATA_TYPE,			\
@@ -868,7 +877,18 @@ const struct tegra_vi_soc tegra20_vi_soc = {
 	.ops = &tegra20_vi_ops,
 	.hw_revision = 1,
 	.vi_max_channels = 2, /* TEGRA_VI_OUT_1 and TEGRA_VI_OUT_2 */
-	.vi_max_clk_hz = 450000000,
+	.vi_max_clk_hz = 150000000,
+	.has_h_v_flip = true,
+};
+
+const struct tegra_vi_soc tegra30_vi_soc = {
+	.video_formats = tegra20_video_formats,
+	.nformats = ARRAY_SIZE(tegra20_video_formats),
+	.default_video_format = &tegra20_video_formats[0],
+	.ops = &tegra30_vi_ops,
+	.hw_revision = 1,
+	.vi_max_channels = 2,
+	.vi_max_clk_hz = 300000000,
 	.has_h_v_flip = true,
 };
 
diff --git a/drivers/media/platform/nvidia/tegra-video/vi.c b/drivers/media/platform/nvidia/tegra-video/vi.c
index 98411c3f4a037..52384af92d8a6 100644
--- a/drivers/media/platform/nvidia/tegra-video/vi.c
+++ b/drivers/media/platform/nvidia/tegra-video/vi.c
@@ -1408,9 +1408,12 @@ static void tegra_vi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tegra_vi_of_id_table[] = {
-#if defined(CONFIG_ARCH_TEGRA_2x_SOC) || defined(CONFIG_ARCH_TEGRA_3x_SOC)
+#if defined(CONFIG_ARCH_TEGRA_2x_SOC)
 	{ .compatible = "nvidia,tegra20-vi",  .data = &tegra20_vi_soc },
 #endif
+#if defined(CONFIG_ARCH_TEGRA_3x_SOC)
+	{ .compatible = "nvidia,tegra30-vi",  .data = &tegra30_vi_soc },
+#endif
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
 	{ .compatible = "nvidia,tegra210-vi", .data = &tegra210_vi_soc },
 #endif
diff --git a/drivers/media/platform/nvidia/tegra-video/vi.h b/drivers/media/platform/nvidia/tegra-video/vi.h
index 44893c5c6e651..965357ebaf0a3 100644
--- a/drivers/media/platform/nvidia/tegra-video/vi.h
+++ b/drivers/media/platform/nvidia/tegra-video/vi.h
@@ -291,9 +291,12 @@ struct tegra_video_format {
 	u32 fourcc;
 };
 
-#if defined(CONFIG_ARCH_TEGRA_2x_SOC) || defined(CONFIG_ARCH_TEGRA_3x_SOC)
+#if defined(CONFIG_ARCH_TEGRA_2x_SOC)
 extern const struct tegra_vi_soc tegra20_vi_soc;
 #endif
+#if defined(CONFIG_ARCH_TEGRA_3x_SOC)
+extern const struct tegra_vi_soc tegra30_vi_soc;
+#endif
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
 extern const struct tegra_vi_soc tegra210_vi_soc;
 #endif
diff --git a/drivers/media/platform/nvidia/tegra-video/video.c b/drivers/media/platform/nvidia/tegra-video/video.c
index 2e84385708bac..d483fb709d127 100644
--- a/drivers/media/platform/nvidia/tegra-video/video.c
+++ b/drivers/media/platform/nvidia/tegra-video/video.c
@@ -123,13 +123,14 @@ static void host1x_video_remove(struct host1x_device *dev)
 static const struct of_device_id host1x_video_subdevs[] = {
 #if defined(CONFIG_ARCH_TEGRA_2x_SOC) || defined(CONFIG_ARCH_TEGRA_3x_SOC)
 	{ .compatible = "nvidia,tegra20-vip", },
-	{ .compatible = "nvidia,tegra20-vi", },
 #endif
 #if defined(CONFIG_ARCH_TEGRA_2x_SOC)
 	{ .compatible = "nvidia,tegra20-csi", },
+	{ .compatible = "nvidia,tegra20-vi", },
 #endif
 #if defined(CONFIG_ARCH_TEGRA_3x_SOC)
 	{ .compatible = "nvidia,tegra30-csi", },
+	{ .compatible = "nvidia,tegra30-vi", },
 #endif
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
 	{ .compatible = "nvidia,tegra210-csi", },
-- 
2.53.0

