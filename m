Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C147360A2612
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NyS/gIV2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 042C711231D;
	Thu, 29 Oct 2026 13:54:00 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 845D8112301
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:37 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1601506f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793282016; x=1793886816; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hjD6VzzjtnD3e9erzE1FqqRgAbYyuZXKrgqZLwMhAKA=;
 b=NyS/gIV2BPQxW2u2mehTlPjU55lsndo5AknYAW9wtOVnWLblGvpTdvunJW7kRr3J+F
 3gNuLWqQUqjM8+ruAasj5MFvSsd6LtdU9MtKXVTNUvtucv3+9ZlN44BMYeiE/V6kvM97
 qYf+umIBmE8eq8gkFSPeOv+2j0jz1IT9bFF2lsPKxsYoM9brdeoM5oJzIDc2H4DY1lq4
 9xpY5bZ2R+Yda4Zo6zGQXObFfhKnj7fKIPAv4r/7su28zj+BGfSvqDqp6Nn0vkYdA1I7
 +skK2odBf576Qw0TzfTwZh4BOrEfd9sSGDxDXT8Wjcj5BKW3vuAHB2GwhhCW349EEgQm
 EMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793282016; x=1793886816;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hjD6VzzjtnD3e9erzE1FqqRgAbYyuZXKrgqZLwMhAKA=;
 b=qozICEvkeTus6JlgIUyyv287JDuOItkv94eE5bBwhR6D92vo+hxhPdwPXzVevddFL5
 4cvtHuzXP304UTxrxQEFSB/1x4qvSrRUqjZvFJ1Th8jY66ei9yZizNcFchIhNNKl2I+B
 WeE5u1HgReR7wHlv4ZckXUcLGnG4ccmJ8GczRXKkynQS1r/yM7NVwKPTk7d4wjhgN0py
 16tlGNqWPhE83LTW0phrrXRIbAKzoEMapIJJqMRXryrKltHrEbbOa3AHxOfq1VEXDNRN
 pozUqtdlWdt3JDPmXAYSh6ESo4Wl0BiM1BLH6ojtNhn3oSw9IPcL2w9RMDUqdhR+ryz0
 7rcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIL9TF/sa875ad438QHMMacwDA3NjiynU+eiz7Y03OGHJx9/80jrmIzEvVTK3GVBHqlb6O2CTMUhU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKRfwUfG9+OW8+KrzuRWnNFZI8xUQeyJNswOcrVshF0QgAFl1dk
 oacXNYq2dF0eWhc1+TPX0lYHDFAWLDmVcRG2jxZTBUgRtzJK55DN9hA=
X-Gm-Gg: AYBFou2e0wKhcrN+El4JJh9IzLx1BEOwewbeNYWUYLBtOMurczpOxOkEwkLcISUue/6
 plZZ7UYg8KOhC81tanR6hvqDNyBRxgW7AF1IQVfRRqUvnMTztdMCUh7FihZ/mXTPk8QPwcCtuuG
 XW+Qw8mo9fNJJPowX4Dxjfjq+75lVEiIeL159nitzAZ1v8BJ8RVQGqroWriyV+tS3LMQ5oJTJ7M
 AldJOEmti3hIpT0MNE0ipxcYAr+GQ+E5C40QDMcAzQ9ZKGK2MtI3JDaciXvhDTAk3dR7pUD94YH
 ztums/NnPU1Dzb4sq1TvikokNldJMQ8v8D9lyfzkGdShKHdS7iz3zCmGoyeACNsDqcZFm/8P1hb
 CehthW5tfvOpEWmmbk0F2Y37jEr4RujDdjvOnWgQw25GVFtqBL6PTr6dcts5LYCrXVRNUbJO/DU
 tpbx2UMS7nt73mR7n/DIGzu3y+aKhWqi56zB/9fiDVtOmNoyNalekcfyobViQEf2tYAHMyzD/4o
 ZcQ3i9sA1aa5Xrf2GPeyqAlr8m8Gk3fFLu9NxqgOxoB1WrWQvuUqx4ro3wrs3iCYrwhLqQZW6Dp
 MixBMDk20R5FD5GpR0tl8phPpaQFdOh5W+kKXXHOwUTX8A8fWZW1sJn1iPeVbCo+Ilo=
X-Received: by 2002:a05:6000:178a:b0:48e:56fa:9645 with SMTP id
 ffacd0b85a97d-48e5d5cf38fmr12439039f8f.29.1793282015845; 
 Thu, 29 Oct 2026 06:53:35 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:53:35 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:51 +0100
Subject: [PATCH RFC v2 14/14] drm/msm: enable LPAC on gen70900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-14-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=982;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=zftBrxFOdArPW4SDW/zPbLM/dW8N0ZZjr0f9slsMd44=;
 b=drJK44c9MU6MO0yKK3/YNJmZlff0GX8bkfJNHj78s+gEdYZMo0J9ar0ZFCpDUnU9s9p/mTv9U
 QEVDlUzSQ7wDLCQ28Hd4GN503IJPB36U2UQmXnTQDK6NcMLz/o9Mfkc
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the enable_lpac mod param is left on auto (-1) LPAC will be enabled
for targets that are known to support it and are known to work.

gen70900 (Adreno 750) is one such target.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 5ee00eead14c..cd1bdb54429d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1591,7 +1591,8 @@ static const struct adreno_info a7xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_HAS_HW_APRIV |
 			  ADRENO_QUIRK_PREEMPTION |
-			  ADRENO_QUIRK_IFPC,
+			  ADRENO_QUIRK_IFPC |
+			  ADRENO_QUIRK_LPAC,
 		.funcs = &a7xx_gpu_funcs,
 		.zapfw = "gen70900_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {

-- 
2.56.0

