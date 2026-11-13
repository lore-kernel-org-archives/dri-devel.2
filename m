Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63311606BAAE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oaHWKXZ7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D3A10EC33;
	Fri, 13 Nov 2026 16:19:00 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF7610EC33
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:18:48 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c50abd5b4fcso32968066b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794586726; x=1795191526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XtCH8WwTweMS9Ucgtu2uo1F4H13X1qJECuCGrC2rDzw=;
 b=oaHWKXZ7X1WqQpkuCpr3iCtaByc4BWGd7JvugU0RSPUwHOjGpWtdx3bwVSfmuEq3EN
 BDcGGwjRhvDxbVioyWDYYBNlNgDdvY+FFzOfnN0UsiMFqkXjcm0OfF05vF2p7lwnQxpl
 SS0kDxBPHLYE6btyH4nRMVlcSHMVcS4EAoFBCriUvlf/VidclUDfqSCjM6yN9jBZNrwV
 BmXBXwq748tKB1XJfUDwXJbYvZGCANRklUU3aRhuCo/Ecp7SMs8jr8LOQqbE31z7Al6x
 cFcBkDhyos7RcUptYAxhqpWOJWT11E4AUB+UqjahxzDNwUU+DRlM7d/VfoS6aXXU1BY6
 zRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586726; x=1795191526;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XtCH8WwTweMS9Ucgtu2uo1F4H13X1qJECuCGrC2rDzw=;
 b=2qcDCRu5FQEf/v8tDkNjKAFsUeC2HZHcjCmb4/CMdoKN8UTm0NzdslNZveukViZDvc
 IgE+TB4x30HfZ0b/Nu5IGEtw2Hvqy7HG5RowVomxeVMYvmfI2hKSBvbft4CXd0UKomAT
 j5tPIYRxaLhQJSpRbP1N/euj6CVhAVHzYcWTgEArVRLR1xTQ9KZSq/ISBf369ty2c2zd
 zgmzk619fVfYU9KDl7FG0kuYGfeerkBpbcbBdrNJy7aKukqMyOu2oQtpvCZDjMLbog1k
 bZO3g4W0lbaxgj/9ytkjLZ83Em4Eqg9WazXzzvBSb1ttu+fhHFma3r7g/i8XlMpLfxTY
 +Lkw==
X-Forwarded-Encrypted: i=1;
 AL+hErGaPKBgFebLKZ20XvB1u1JjL1ozGnu+nZdaV1lJGrXN5tx+qEbJ+4yEHQh0083Av8CGhH2PYF3rjQQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z++wap4N8lZ/oJZ+Es1Zxw5Xeye5gh+WIJZVUh3Jo53u8fFgHj6
 hK1yvNlUoT3F4+6EsJqpyB90OFdjzHx1Cogn7dnnV37xStlgIyLo6T5c
X-Gm-Gg: AYBFou1ZZ/zq2GnE/gPV7St9qLne6u04n2zvy70kpyGjPdEN1lssbUZU/DWaGoBTOx3
 VLigBq/f9D85imdaVzLiSAj7eNXOBfAa+2o14fdmBOZGWbiJ5wn3rKGl75kkHU7kU2Kk8Bu/Oc9
 9zx986FwxNiHWVgKvrYGyZAUSKLpt/XupNoavlNy4r8EkBiuJ8pD3jjElDUp3R/gG2bjPvxUw1r
 P+GJDL/vOtkLvv2b5neAdCfO+VYlcXmC4TfTaDYvXd0ka7njD4+UopObs6a3PzHoLMeljQuGkEk
 Tuav3j+yK996wPJy8JpAm6EE9N1qnDDeSNncBmA7bnd8EfeoKs/o/cg6Gjqm+YIn+L5Nc19vTK6
 ZT+apP3qe2twr06j6tjjbjq+mCUSIvp7RKXf+bjEaDJNFYfx78O0ejVME1X58xTkXW1Dnh24wf3
 hPHwoIEPbM2nzicGFmvjo+/grKGbCWYEBQvbS7mY3vy/IAkH47zaTyVFuEhC64A6eINblXwJSdB
 Dip+wjLWcrylwziLDQtPJFLJA8e7uHaQLFIIxjaWCQf+HNRwQVP89xO1gSXjr+ml/RMMNd3vxue
 /Z6Jvtt41jFnuR+9VuRxHkZ1NLuRcZIrEPfst2S2R5E8AKku2Ddf9OE97nEt0dG6L2iNwyPc+LS
 XEG8XyCpiVA==
X-Received: by 2002:a17:906:4795:b0:c42:2f4e:522a with SMTP id
 a640c23a62f3a-c509636a806mr256654266b.25.1794586726178; 
 Fri, 13 Nov 2026 08:18:46 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b24b88sm122297266b.16.2026.11.13.08.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:18:45 -0800 (PST)
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
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Cong Nguyen <congnt264@gmail.com>,
 Faisal Mukhtar <mukhtarfaisal03@gmail.com>,
 Dan Carpenter <error27@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
 Hao-Qun Huang <alvinhuang0603@gmail.com>, Yury Norov <ynorov@nvidia.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v1 03/10] media: tegra-video: vi: Diverge Tegra20 and Tegra30
 VI SoC descriptions
Date: Fri, 13 Nov 2026 18:18:12 +0200
Message-ID: <20261113161819.36847-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113161819.36847-1-clamor95@gmail.com>
References: <20261113161819.36847-1-clamor95@gmail.com>
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
index cdadff98eae75..f27ecb1ba29a7 100644
--- a/drivers/media/platform/nvidia/tegra-video/tegra20.c
+++ b/drivers/media/platform/nvidia/tegra-video/tegra20.c
@@ -809,6 +809,15 @@ static const struct tegra_vi_ops tegra20_vi_ops = {
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
@@ -852,7 +861,18 @@ const struct tegra_vi_soc tegra20_vi_soc = {
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
index d8c77d1290efd..12eaa89304e84 100644
--- a/drivers/media/platform/nvidia/tegra-video/vi.c
+++ b/drivers/media/platform/nvidia/tegra-video/vi.c
@@ -1935,9 +1935,12 @@ static void tegra_vi_remove(struct platform_device *pdev)
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
index 46328e488aa38..ff5c9deed4c88 100644
--- a/drivers/media/platform/nvidia/tegra-video/vi.h
+++ b/drivers/media/platform/nvidia/tegra-video/vi.h
@@ -292,9 +292,12 @@ struct tegra_video_format {
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

