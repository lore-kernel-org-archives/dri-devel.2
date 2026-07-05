Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88437C44501
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DED510E3D8;
	Sun,  5 Jul 2026 19:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPcw2XE0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UHQ9806T";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FD010E3D8
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:41:00 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HjBMY2345290
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 19:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3J7+oNMk7WM
 Q4KOiVM1+PpfhqlleI9nCGCg735LegyU=; b=hPcw2XE00hJiXGUlPJdzgAHVQzT
 3IKBxTpsdM3YltXY0Gb00tp8cyyqr2jLji+CKNDBWau5JTu+BreuyR01af4GFyfv
 ngpGWe//C62ZWMgkGJk4zSl0S0wOJ9lpQw3JAKnLg2fIs5pZCB7N4aamjssEjqJr
 56eMgt2RR1Wu9uGyx458onBujfZX4GqD+UxQKYZvfMFk6K6CooiLxTXLejKO9W0R
 0jkXD7cR55aEXj06BsfreVAtJNhMuxZgvDsgw5Rbn8a2yz3zzklaCOw3S6PIDyNi
 LSZAc2ZKjYucaa8JgIZQNxudHkYVpBDXyT4e5CmqkA1zH01od7f0TWn9fNw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvkbvj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 19:40:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c804e38c65so45319185ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783280459; x=1783885259;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3J7+oNMk7WMQ4KOiVM1+PpfhqlleI9nCGCg735LegyU=;
 b=UHQ9806TMNkWsWRIJpHlb8SjF06+43iCSR7gNB9URWX7FYtHDhwkHLAmqZ8+4m9OEz
 5L9HCXlvGRHPGxmRPL6Xt1UXsE8VXoI8lzlA7bYx3PgpdG0fJEKS9yx0QcrLCJyvLU5b
 qQnfW+ylJjCnL8nmL6Av/XVCSkiz7ou1u8O40Vnu7gfqGD1psGNZX+p98/wOu3Jv8g1M
 JXskhloMy4GzbmP50Daal07BV/fgo61tSmRgbpAs3SS8RpQuseliKiFo/pzEJxO+sUIo
 Glw1ac/b/SkS1Un0uIBkuzgZo0oX2qsSwJsMuAw0886lqy2iNPd7bdY3/Z3WnBV9r+Y3
 enzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280459; x=1783885259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3J7+oNMk7WMQ4KOiVM1+PpfhqlleI9nCGCg735LegyU=;
 b=UvH6uwMCbogj/BVm/qe/F/FWCaI+Y1XvsJ4jMYB7RlzENVN0dUolmODXmfT0TFqbez
 Lt5JUhHVTFuWryMmi8WaieN//o7GbdZ1WMUrsyBtBhwaW2LAo0NdoRLlhPAL0EkUNugY
 G4Q8SbQg1H1DXDy6SPknNPum7CryaYUexSrgBhn+pJk4jRrpLbVovRaz4KRYcdGf9iwL
 xXQYWmfQnqgk9pLeZ1ha7EFdCMSGrRpG0zTvvUsX7eCOwvlEWbT/wIJU9bmRP309U7Sf
 vDPu7MpAbA2hlwNHaSfwAVQ/WANwOJ8vINJ+n+yHstwzKi3ch78ILQ3BWWAbV93Z+Zsz
 0Alw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGfRTbnJdhs9nFo5wmv0hYvsTSXX896o/JTYx3yGNQ1W2OQDDYaE0k0sy8iWvS7Hj7RK10EvmCUd8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFa4v/1SiLWWnsjhIKgNsKRHgw+W8cgW61NbALGW+yEUkY9AGS
 JqqWzOe4byky2nT2qFgPo0zT7x2klbixf20Pl1JpgzbElzwtQKCGA8duPAlNFLUyIT1zsMxqHqe
 +zZL3phSgGJvw2ULFaXOrQuO8ZeZ3bk2qBJLbjLgl4/eTGBbY1r0MUmJYDK3NhGTFQ/0t/ngCt2
 L/Mjc=
X-Gm-Gg: AfdE7clFHoe7R0Pf9rVN432W+btO57XlbdF1+3ClyjkvpafpkEqMg1h0q7CFVn+43Sj
 Z8a0nmGiG7XLqpDzTm6k4DZ3obfBEQsl9JyZZhkVEzuFklrrdRn1nmzUb/fVQ7Eu5o/6kkXbAwH
 CTpVLyFFN8tVI2zanpPsQ3FIt1CKxrgua5sIPSjNBQKSV6WGJkb0UjnD/rDexpJHv6JS7pRmt4t
 8x20SGC0EeTK9JSgKjs4xzlwJ+yvYO8o75pFSX4d8Taw5l/tupxFTzkk15smAWSYEnbD932/ImN
 iic8twNE9PHSpqch9tW5hybBmCfQnAuRfWtRt3g42tZCqgYOdShI0rsliF661GYSzY5gGuBN9sX
 PaU/rce1UCdOF2l2zsAnoSIJvjJn4oLBM1NQq0w==
X-Received: by 2002:a17:902:db05:b0:2c8:1f1e:6922 with SMTP id
 d9443c01a7336-2cbb9ee11admr72369415ad.37.1783280458794; 
 Sun, 05 Jul 2026 12:40:58 -0700 (PDT)
X-Received: by 2002:a17:902:db05:b0:2c8:1f1e:6922 with SMTP id
 d9443c01a7336-2cbb9ee11admr72369145ad.37.1783280458256; 
 Sun, 05 Jul 2026 12:40:58 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:40:58 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, sound-open-firmware@alsa-project.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 37/42] ASoC: mediatek: mt8195: Use
 devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:13 +0530
Message-ID: <20260705194019.2565498-5-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4ab34b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=FVZLpNCcgjzkSGVc8gUA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: KTJ1YlWHyE0gucorDDK3mq5CaffPukcr
X-Proofpoint-GUID: KTJ1YlWHyE0gucorDDK3mq5CaffPukcr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX5Mt3Rk9Z+dAr
 JncPkUlEZYh1mduBK8n7mU3F0Tdx7/PGBvaaQWOAU03JUPrR0oG63zvCZyXLf/QUhhIYxDK6kof
 ohXmXqWEHsCl2G10fIhtSVn5Rm8sdhySfJZn8vpy23TqMLHJqIFoXDrYk/DbRAjs30g3KvGK22M
 qFkEtp/FBnn3yfmWDe0Xftdpy+TptfP5cHlx8zXs+poQXrX+b9venjhj5nKlmLfFqJ4kENPS6aV
 mqcw68UC5AfHGt3B1DxhgofAVV9J4BtUqZLSL7jvVhmzqlw5qBJxjfZCE8O5n6xm6npbUkKE2Hd
 7GC0TUmfha68g7pn+e4xeb3YCJbwrdU/NOH8lA8o9I8fame0mYFA7EShWodRm0S3DiOvffFXyWA
 333rd2ZeQ3BKr7TaBV2NJVrh2fnM4LV/eE4txH5Z9HVU7cHwZNbZdIUT5fGHxkw41DwVyP31xBp
 ZRJ3AO/6LlrVXU++OOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX4tiQ8QuL++My
 oXxFXrmK4Jzacl01oaxHQNY35R1Dp1dJKByjZxclqkocw3UKa+sNwCyRHKicjvy5RqxfNyQFN00
 ySmZKogPYkOxeL7bUdreaW/CKi7htN4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212
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

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index bc0a63457cd7..52c3381e6766 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3013,7 +3013,7 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct reset_control *rstc;
 	int i, irq_id, ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to assign memory region\n");
 
-- 
2.53.0

