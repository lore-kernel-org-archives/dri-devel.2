Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA65C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E79B510EBE4;
	Tue,  8 Sep 2026 13:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QSdDQmO3";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D272410EBE3
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:24:24 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso49978825e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788873863; x=1789478663; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RUOCLyyP/3BZIr82/UOzgNVAzirKVjkOzIoxcnIj0kg=;
 b=QSdDQmO3B0o3sxmV4gvQWJ/Qr75JOCEC4m2gu581S8CDGOSZJ8qE9PTsUUoL7vyUFE
 lhEEfVBBzrh//GcKQdne5SiSIpkdlu+WTP+wDJc44n+eqq+3CH3tIW1eG9p8Ss57c+4o
 3cg9RWv3FSSUl/BLkqRE2NEQAZ6hPtOIUvxvwFrHg3+UAt2WQCbLw/YA85fkNQl1CuLk
 2lGGfZhqP7w0t86QBr3MmAB7f1iY598R+LTpM5jkiNfdlxoUGU33q/C+ZDnT050U/k/T
 XUFLAJYqvd2xyfIPKPVEszwlF76T3eo5eVktdHyFNCV+1Bn848ltkKhlm4/ocJL+NreP
 35bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788873863; x=1789478663;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RUOCLyyP/3BZIr82/UOzgNVAzirKVjkOzIoxcnIj0kg=;
 b=OsgoNwag3vT9uBhYJFIJBcHc5+b6c10CPOWu/rF/XgBvAJUZ8AeKU/dcJlacLRsRzV
 HRRXX+5NS3HPVUxiexgQiQwe893UR55ozHdezr5bprGDhT9y3ecbdiO+h8QnQJXes8JR
 5yx+E6qf6pxnnWowmU0RAai2JzmksZjQ2WXeVCbTCP4qvZHC9yNxC2ZcsLaPHI2d+HdZ
 tnJpEnfC4jVCLYqIBm7crHsiHmx0YQAQMNJQ/BKJGHH9UfFqs/c3xSWMjdAl5xtYVZ1R
 VC5Ydh7NcvxsZI3SUTHf5WMSxG8HRi9Hwq1e02r5FkOybwecGsz6onodTjHEucVOb4Eq
 yRCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOP90oeEsf5rDGUxffIeQ0X58Lgpjye0zjBdMEAmpAVURYwj+Ou/xq/VLe22lqIkIiMZzU8wsZ9Sg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lOwx2kGVZzcA9Ey74spr3TIjisIixPY3hSqtYJd+NDa62egwTb
 /kNghgVoiiyZV3RL2wvQQheYX90YUG3yVFkcRVtaUzX7Vg4R7fmLwEO5H5QCND6Gmb8=
X-Gm-Gg: AYBFou0Fr2qjl0yBZrx/5r44uqHdfcgK5xb5yYsruQwr55weBwwPJHig9eYEPLFfsEX
 ESxYbtizYPbI29SpbSPagcdrQ7NSR4pkjf0MYDWKmJtVzn8Q8lc21bsRR5ygOBj76NScCkuyjrv
 cGkBrP3UycnAmIN1SCd3VfS48BQ+ShKJ3/WlrX+NzO/U1vCy8e2nDBRHsFvAc3n3gbni4m17x2g
 1MZVJtfBAAc0MVe7pk01BSRfo2X1iNWa47ODk5/miJAjEfhviHL/vv039rq5olyaNHXNt35Fuv0
 zDGSapEVnPUjTuylIaAjwr2QoHhv2GrdfXQAJHar/mqEbr+H5C9D3VUB+PCI7i1+hg6rFu7J9BP
 IcH81mheGUANtf9z3l0YqUHC9vsBfWoNDhTLpaJcVJyd6whol1mqAwZV2UaapM9wMO1E8GXyTiT
 4321XJxOvoogL8QmVDYi7cu7e5+395+0kICteKKnL+zolymdF6nw/hGnPjRvCYQeCLlGWV3ZXc+
 rgOR69A
X-Received: by 2002:a05:600c:4e46:b0:49c:fc6e:8cb4 with SMTP id
 5b1f17b1804b1-49cfc6e8e51mr249810395e9.24.1788873862925; 
 Tue, 08 Sep 2026 06:24:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d07b371afsm298959475e9.9.2026.09.08.06.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 06:24:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 08 Sep 2026 15:24:13 +0200
Subject: [PATCH 1/2] drm/msm/a6xx: Add CX AO Counter registers used for
 a750 GPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-1-284880d6e68b@linaro.org>
References: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
In-Reply-To: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=yYvWPIkjUnOSxNsW0N2YuVeYUdVZYIlPEps6riY11G0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqoAyAvByARiXpF/WkqKGE4OSrNQy1qbMA0R+Bxpif
 6NCOXWWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaqAMgAAKCRB33NvayMhJ0bvwEA
 CtKuYZJw+MpFqDcZ/vp5yplaR9VEFBLXXkirgGqhNVptMv0sDDn1j/yRXTnGDhVIK5Bg+zP9C9eysJ
 T3n8rkEhg0/bz2wXTxHsOrK2xMr1Wuvg22XAJ5KQFI3Ba3+9/pRJU4jF4DM8x1puKpFt5u2I48CucI
 6G095COra/sqM/3Qq/FyTpE0qGsMN9XptEnla9MDq+VS6TqPy+t4xUB2fBVjlhNPITo+WzVblYN2w4
 6XeDENjqlENTlVdIYrMoAYbTZEtq2jvVJOik8g8RuMZaZZZHEo/Jp8RsSd1BmxwNP5fMwNtdXxZliB
 ytWq7FByzX6DytKetUWiy6NfjuoWv7Fa1NWbJE+ubLcd9apF/sO0avrZEnhgAbf4846JUoKROsPTDf
 QqER6w7io/mfIeFzoLyuwwQPzykcgTnWEcPm3sXy+3Qd0UkflAhgiKMzIgtVRdDrWIy6HJuAVDScVD
 TIku4croTpsNMhw5vrtYG4AFKjF2xZqy0x/QrD1zzdANlGBXlPPubaivOU3zcHQHj+pmMMijYRMuLL
 6Z7jaIJ1sqJbtHIeCcDqpePVuL//BC7aV5Kc51SwBFh1PvSUOjUC6cVYFQbaLn10S/PSp/xP5qHH3X
 zY80z89nnKkUUWYClwRa02wAmeU3DX+C521L6rkiZ+nVW2ps92FvS0NgMPRQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
register on A6xx and other A7xx GPUs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
index 33404eb18fd0..3fe7bc3ea93d 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
@@ -141,6 +141,8 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x1f9f0" name="GMU_BOOT_KMD_LM_HANDSHAKE"/>
 	<reg32 offset="0x1f957" name="GMU_LLM_GLM_SLEEP_CTRL"/>
 	<reg32 offset="0x1f958" name="GMU_LLM_GLM_SLEEP_STATUS"/>
+	<reg32 offset="0x1f880" name="GMU_CX_AO_COUNTER_H" variants="A7XX"/>
+	<reg32 offset="0x1f881" name="GMU_CX_AO_COUNTER_L" variants="A7XX"/>
 	<reg32 offset="0x1f888" name="GMU_ALWAYS_ON_COUNTER_L" variants="A6XX-A7XX"/>
 	<reg32 offset="0x1f840" name="GMU_ALWAYS_ON_COUNTER_L" variants="A8XX-"/>
 	<reg32 offset="0x1f889" name="GMU_ALWAYS_ON_COUNTER_H" variants="A6XX-A7XX"/>

-- 
2.34.1

