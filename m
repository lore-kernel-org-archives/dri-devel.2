Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84049606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFBBHObc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE410112324;
	Thu, 29 Oct 2026 13:53:50 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7057112324
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:35 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so1696192f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793282014; x=1793886814; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IhFC/E+vn7Ne1GmfoUxjx/snlj06M4a6yUZTElbwzmM=;
 b=cFBBHObcckSHm+GDFwl5WQ6kttl2UP0BEJfnnZFixb9c7xUb6vQIU/m0aWVcEP7xpv
 I8HbhxSQZls+4zl3FKFj+ZTkLfTMxPefmoidafUbR7fYraxVJNRaqiyn69vxyDnmjz6O
 KM1iTZDSJ5Hox5lGM6GBXN/9+8SDUf/Q2DNI3ryE0+YocjHOv0UCdHoCBs+8uaJQ5+gm
 nSXr7z8t63HEAQykr2kP1FUigV00Lq5XbukkhgSZ46Pz8yCliabkVtzmqUhCwhgoEZo0
 UtTF605Remi1YcuwJ/xxK7UJKj4iJVzTr0ZXpGjHzLI0EWpGfUggiGQF/Y2azrTidckF
 +AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793282014; x=1793886814;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IhFC/E+vn7Ne1GmfoUxjx/snlj06M4a6yUZTElbwzmM=;
 b=Rrt7Uicwb16i0woR0/iHMZqiROgr5o729eK9dZDCSM3b/jKHt8wgzaW+MfZWv+OcE/
 9hP27qfWLs4oZRbEfJoEajktbMXaJ9wekG9TFQt34db2bdr8itoM9I+Av7+NBV+gyKtN
 8BsfkFW0FEPYdrhf2n/BZNBE3FFuDVmvll3umiY0M2ufsDwE3qZBLULvakzVR7YJP4pz
 aWe0cGO7rQZqKolS304Mmojq169c1HPTtDCHmIje6ybF0XyypvNs3VwG5rdhTGq7tFuA
 raSHFyiP2jA/pRvoeQ3nPgS9qA7i7Hl3JrA0zsZ670p5PNJFgUeCyTdFDVNt+JtnSifB
 BknA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSvZHxMRjxJTDEEoZdoqmkzFLm/eISZI00ryQiPXX7CNoXCymd6mwhj9MQmL2UScTlcRtMoFdIAdw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLwX+BK8LjrdLFQbDeENUacs8oh5Rna++tZ73rdHKc5THp9RfOU
 15hE8FXY30kCDmOnE/1KgVkh9x70DOkGn59R5iunsQeoySaVjDQiZlw=
X-Gm-Gg: AYBFou1tJUDIHIcLnF5yqtg5NuBUUnOKNbfR9FLV3sHaUCxClk8y0kwi1m5uH8YLprA
 +jAo7nYN9RyQSZNLvi/MfZ/7hxoZjoNKSJ9q87ev5L+jHirg0mpLic8+bb2k4Te7mJy7u/7jmZq
 vsPc3v0G8ELMVw+uyp8QDAIfThRP+BwwW9uigQL4U7SyxlKSxXDStvL25nODhMMhY3G+cY6nDln
 wTxZdTWehtlAP2iaI446n2fAwk5pcRZSvm0Y+DM1o5nvIaZjZSJvUxc/kXjVJ1OSuC6EXyj0pRJ
 HRiqBYUUyT9Btf6q/MpxYqHv51Un83VI2jzN7MtSgWsMwpbTsQ7liXjPqe070viCR0Tkg9NlKCq
 /TdNEQVQDVG17jjSDwJIOicixzX0nlyoOFwgXq4JGY7ry6tw8CrAlQMb0vZY0Jh7R2ytzvCyV0J
 6pupEuhsBcRxYSpMA6l0R410HPC8x9qErEZXhSQbdbfDE6ti3jw4y3suFuCzJ/K9ktIbFJpeKTs
 HYgOV+id70BL+qqgxMUChgPrcjjdAf0TmkEl2dOckbrI1Vc7c1qo74k3QT/T0FPbheK+MWMq/LD
 IcJwJv772njWA53DZEbr6axRFi5UHugWlmDEk+rb5P5iUA==
X-Received: by 2002:adf:f491:0:b0:48e:1421:ed49 with SMTP id
 ffacd0b85a97d-48e5d5909aamr9182569f8f.18.1793282014126; 
 Thu, 29 Oct 2026 06:53:34 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:53:33 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:50 +0100
Subject: [PATCH RFC v2 13/14] drm/msm: gate lpac behind modparam
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-13-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=1928;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=ZEwODnTsRSIiQzAvYlWfm8pmWhNZkrTmOspw3E7UZvA=;
 b=Z9dhvvnQgx4S38zM+b46UTdfg9SThPOIVSdAoOz7EGATYLcY7dL9exHHWjN9XuX2BOku7wLrT
 FTPWSEv0DrrDpKLv4feGQ8Wj41R/cQfHXOM+Z/TSHsGDJf0un1xYOaN
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a mod param to allow initializing and exposing the LPAC ring.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 4 ++++
 drivers/gpu/drm/msm/msm_gpu.c              | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 6e2333466d7f..51781a2e8a00 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -30,6 +30,10 @@ static bool skip_gpu;
 MODULE_PARM_DESC(no_gpu, "Disable GPU driver register (0=enable GPU driver register (default), 1=skip GPU driver register");
 module_param(skip_gpu, bool, 0400);
 
+int enable_lpac = 0;
+MODULE_PARM_DESC(enable_lpac, "Enable LPAC (A7xx+ only) (1=on , 0=disable, -1=auto (default))");
+module_param(enable_lpac, int, 0600);
+
 extern const struct adreno_gpulist a2xx_gpulist;
 extern const struct adreno_gpulist a3xx_gpulist;
 extern const struct adreno_gpulist a4xx_gpulist;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 4244d9324cda..f6927c797fa5 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -889,6 +889,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		const char *name, struct msm_gpu_config *config)
 {
 	struct msm_drm_private *priv = drm->dev_private;
+	extern int enable_lpac;
 	int i, ret, nr_rings = config->nr_rings;
 	void *memptrs;
 	uint64_t memptrs_iova;
@@ -1012,7 +1013,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		memptrs_iova += sizeof(struct msm_rbmemptrs);
 	}
 
-	if (config->has_lpac) {
+	if (config->has_lpac && enable_lpac != 0) {
 		gpu->lpac_rb = msm_ringbuffer_new(gpu, nr_rings, memptrs, memptrs_iova);
 
 		if (IS_ERR(gpu->lpac_rb)) {

-- 
2.56.0

