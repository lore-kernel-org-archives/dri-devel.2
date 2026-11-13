Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E129606A881
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teErNlfd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 431F41126A5;
	Fri, 13 Nov 2026 16:19:20 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB55E10EC33
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:18:53 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c4cb6834eaaso268356466b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794586732; x=1795191532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3uheoZqKSe+Qa8Rhr1Yml0QAXpH3QvZRuhTv2QAVUqE=;
 b=teErNlfduwrL4laeYup/f6Txdsmk6D9onL0sDRHwDZ0TLMsRh3YYsbjb1UdkgRRz3f
 q8LZxVQfE0jJtVV5YaLyd0G/C3ytjzVOx8MBRbhdgLZzKHCYg9fXGy175NU86yfysP1f
 MlsXOpuFk0MzN/75IfERya6N+N7AKNa4C4+54Fi3wstCJ/KnWsmHfP64BZLzgeNHxwo1
 QtnNX6hOEhXVdeAuVsUiroZ4aOtkBUn4Q21sipj0fiC5uJ79aCcABxm6jc8iyMqDqcIV
 0mXu7Inc6mpqbtZNcL5DS1apBqtPGNOx8Ay3otynIFAYI1CdvC+X8owwShKQDdZ/ryHC
 nW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586732; x=1795191532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3uheoZqKSe+Qa8Rhr1Yml0QAXpH3QvZRuhTv2QAVUqE=;
 b=CWnLCeEh8wYJdbwNCz87NPZCoxaaRWCkdYOpmcr7Cj90g1cDyqla6JBQ0zeYJ10eG/
 xgF8Lw28xGlciQ0y/7vEYwsWwZSHkS59oRNZs3vDj7v2UYkWgFgiauQe+gR/aeScvonr
 xtwEzEfM4gauuzj6QLGlqddVnGAty3g0YY5ZSgtLscpXWrF0XZUalQn2Pfrm8m4e3Rg6
 zFil0UUSvcKeLinU8EKwR7gwbx7LdEOGE+gCsawS0JwqJ5Q82nfYmVM3jSbcjFKjldkw
 rT1DuBQBwyeRHCq9Hy5ZsGCph74c0PcjFNc1q677QjFbyxv3tTIhraOk568bHN8ura17
 xdiA==
X-Forwarded-Encrypted: i=1;
 AL+hErEwu34X+rtRXXMUfi2kGe3XG67XIa1FFjsJbqT2gCqKDLsbtOt7W+Ker3eLA9T4oWH9waV6S4SlsR0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/x/IO8ae0G2ffV+NjPMMI93vFPvmtgFGtwPoA0u38xKo4eRpsr
 ZYrKp7AY6DJUyxfUfds1fiB7JHw6EnKeAdxWD9Xez9tGGXIxtXzk3W9B
X-Gm-Gg: AYBFou38nvbYG/2eN4MfbLg39cQsrGtC2TIXk+WhELe0OWTJj9Cp3fjwAw1rY1o2j5p
 yBPniX3domMPj34JE51Kx22lPgFfJZFf3qhbQn79vvP/8+o/cdm3F/UYt5Xrp4wM+ZFYiTuxYNN
 dgkQqiIYj7PJw9Q5UCR9PI/yexrrpXOhRx3ywYpNIAQtUxeyKjM6+sclixWpo/MzEdFXy6q6/UK
 wqkXz6aDqw10rQRKDsK5v1NKCMKq4GNomXOfAtKt6UGKUG4H5k3zJ0ndiDItXiXd/loHTotJTYi
 H2V0YGU5CBrsddrXQAzXHswQrk0xdVLcq3oe3sZIkjwPtfLdgMIVowWgqYPilPBKNQAcxhoD3S/
 gK/CcKPT+CVXDub2wCdq81n4gHoVahVbasKELz0u7+UG8D6NzHO7+/BIBbkE32NS42z2lsrsvYk
 vs8aubcBb+uR1B/vG3b/FCgLfVixHi9caJ21sXh174Q5odQjCeitBayhsBeeZs4NY7nLauiFG9E
 cummhnCcZTX3AgAOB/riL0cwI85nhQ1ipZZFn+WpXs+gK7SD2wV/oKtTMxH+CTDlJ4gdmcP/6dc
 80OugiEg/RBdaEqLK40IYya0EOzx6mMhAL7xol3vHsqUDN/ENaS//BLWgBJjmJtLn3DUDjiNske
 QRDUmv1aCRg==
X-Received: by 2002:a17:907:3f93:b0:c50:4a71:cb5 with SMTP id
 a640c23a62f3a-c5096325a62mr275095266b.15.1794586732058; 
 Fri, 13 Nov 2026 08:18:52 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b24b88sm122297266b.16.2026.11.13.08.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:18:50 -0800 (PST)
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
Subject: [PATCH v1 06/10] media: tegra-video: vi: Adjust pad assignment logic
Date: Fri, 13 Nov 2026 18:18:15 +0200
Message-ID: <20261113161819.36847-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113161819.36847-1-clamor95@gmail.com>
References: <20261113161819.36847-1-clamor95@gmail.com>
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

The VI driver does not populate the pad entry in v4l2_subdev_*_enum
structures that contain it. Leaving it unpopulated assumes that the source
pad will always have index 0, which may not be true for more complex
sensor drivers.

To resolve this, assign the pad value in v4l2_subdev_*_enum using the
source pad index obtained via media_get_pad_index() from the source
subdev.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../media/platform/nvidia/tegra-video/vi.c    | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/nvidia/tegra-video/vi.c b/drivers/media/platform/nvidia/tegra-video/vi.c
index 5c649e3162fe3..0228a11013b05 100644
--- a/drivers/media/platform/nvidia/tegra-video/vi.c
+++ b/drivers/media/platform/nvidia/tegra-video/vi.c
@@ -348,6 +348,9 @@ static int tegra_channel_enum_framesizes(struct file *file, void *fh,
 	fse.code = fmtinfo->code;
 
 	subdev = tegra_channel_get_remote_source_subdev(chan);
+	fse.pad = media_get_pad_index(&subdev->entity, MEDIA_PAD_FL_SOURCE,
+				      PAD_SIGNAL_DEFAULT);
+
 	ret = v4l2_subdev_call(subdev, pad, enum_frame_size, NULL, &fse);
 	if (ret)
 		return ret;
@@ -380,6 +383,9 @@ static int tegra_channel_enum_frameintervals(struct file *file, void *fh,
 	fie.code = fmtinfo->code;
 
 	subdev = tegra_channel_get_remote_source_subdev(chan);
+	fie.pad = media_get_pad_index(&subdev->entity, MEDIA_PAD_FL_SOURCE,
+				      PAD_SIGNAL_DEFAULT);
+
 	ret = v4l2_subdev_call(subdev, pad, enum_frame_interval, NULL, &fie);
 	if (ret)
 		return ret;
@@ -465,7 +471,9 @@ static int __tegra_channel_try_format(struct tegra_vi_channel *chan,
 	}
 
 	pix->field = V4L2_FIELD_NONE;
-	fmt.pad = 0;
+	fmt.pad = media_get_pad_index(&subdev->entity, MEDIA_PAD_FL_SOURCE,
+				      PAD_SIGNAL_DEFAULT);
+
 	v4l2_fill_mbus_format(&fmt.format, pix, fmtinfo->code);
 
 	/*
@@ -540,9 +548,11 @@ static int tegra_channel_set_format(struct file *file, void *fh,
 
 	fmtinfo = tegra_get_format_by_fourcc(chan->vi, pix->pixelformat);
 
-	fmt.pad = 0;
 	v4l2_fill_mbus_format(&fmt.format, pix, fmtinfo->code);
 	subdev = tegra_channel_get_remote_source_subdev(chan);
+	fmt.pad = media_get_pad_index(&subdev->entity, MEDIA_PAD_FL_SOURCE,
+				      PAD_SIGNAL_DEFAULT);
+
 	ret = v4l2_subdev_call(subdev, pad, set_fmt, NULL, NULL, &fmt);
 	if (ret < 0)
 		return ret;
@@ -570,6 +580,9 @@ static int tegra_channel_set_subdev_active_fmt(struct tegra_vi_channel *chan)
 	 * is corresponding match in the Tegra supported video formats.
 	 */
 	subdev = tegra_channel_get_remote_source_subdev(chan);
+	fmt.pad = media_get_pad_index(&subdev->entity, MEDIA_PAD_FL_SOURCE,
+				      PAD_SIGNAL_DEFAULT);
+
 	ret = v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt);
 	if (ret)
 		return ret;
@@ -614,6 +627,7 @@ static int tegra_channel_g_selection(struct file *file, void *priv,
 		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
 		.target = sel->target,
 	};
+	u32 pad;
 	int ret;
 
 	subdev = tegra_channel_get_remote_source_subdev(chan);
@@ -622,6 +636,12 @@ static int tegra_channel_g_selection(struct file *file, void *priv,
 
 	if (sel->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		return -EINVAL;
+
+	pad = media_get_pad_index(&subdev->entity, MEDIA_PAD_FL_SOURCE,
+				  PAD_SIGNAL_DEFAULT);
+	fmt.pad = pad;
+	sdsel.pad = pad;
+
 	/*
 	 * Try the get selection operation and fallback to get format if not
 	 * implemented.
@@ -667,6 +687,9 @@ static int tegra_channel_s_selection(struct file *file, void *fh,
 	if (vb2_is_busy(&chan->queue))
 		return -EBUSY;
 
+	sdsel.pad = media_get_pad_index(&subdev->entity, MEDIA_PAD_FL_SOURCE,
+					PAD_SIGNAL_DEFAULT);
+
 	ret = v4l2_subdev_call(subdev, pad, set_selection, NULL, NULL, &sdsel);
 	if (!ret) {
 		sel->r = sdsel.r;
@@ -1041,6 +1064,9 @@ static int vi_fmts_bitmap_init(struct tegra_vi_channel *chan)
 	 * supported video formats.
 	 */
 	subdev = tegra_channel_get_remote_source_subdev(chan);
+	code.pad = media_get_pad_index(&subdev->entity, MEDIA_PAD_FL_SOURCE,
+				       PAD_SIGNAL_DEFAULT);
+
 	while (1) {
 		ret = v4l2_subdev_call(subdev, pad, enum_mbus_code,
 				       NULL, &code);
-- 
2.53.0

