Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5C4C43602
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65A4B10E2EA;
	Sun,  5 Jul 2026 19:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lc/WGFTE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CY14EGVF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 455F210E2EA
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:40:48 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665Hhmbc2341830
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 19:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7OthzF5yzbE
 g8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=; b=Lc/WGFTEsBR6FyBf8pb2q2cTo/S
 IRTkAnMpy4BZluObjv10Ds1+8wWUnkRZLMFnZfxn4lwUf9wNpTCxvblYHfxq/YKl
 Ovc/Cj5jLSEuk8ulecmXZk1CDgTUxGIQtjZKnuWR+K1jUu+ftDDZonwnoZEjSzlk
 ct1xTk+NVIo42IekyeGwdAr5vq+YHarJ6RB16P36dz97W6pvhWCceSyR2czSTYp6
 hSXnIp2oW/ZkZTxzubwpV++50pKMPkSorshnXRFfqderNm50KPgm9F/0EgLX4x+X
 hMm6Gy4Wmztc6y63i7GrlHroXX0TGdaLddDcR9h9VbzCKd2rrL7p6658Gqg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvkbuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 19:40:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88fc985a65so3719793a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783280446; x=1783885246;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OthzF5yzbEg8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=;
 b=CY14EGVFWU6Qi4kDnwx6/foPZ2iTQlbCBZ4pFvGsgzKYjSUNxnN1ulTEn/juKS3PNS
 Vxmk0nR9VMcrmW+a/i/GGGjXl0BBqp9sMf5xpsqkB2CbR8z25RR9doF7BhNWVO66yTeG
 6sM8f5IfrrSAfiBBonf+phuayZAX/CiEljIpnDKoymPzol/OU5Agq4sKaITOfil5i62W
 xhfgKjPKhIbCtaqY48pcdOX9e+GUPhzbCvJPSg+IVfxgoulUZz7jUPKaNz1TOjXFuJF1
 Tp4mjORxFy6JUPHwYuQfiasfdYiQdaeT7txGjBwpQt+c7XH5EJ+cBINNTqRQn+DAePTG
 aGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280446; x=1783885246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7OthzF5yzbEg8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=;
 b=NT7y6jpBsGqh/aDFdwTTZHLsu4gtsaVNfBM1yTxgCLQnwwaV22JU5i19t5SO1hsgPZ
 oRKALtqTeuJSmCfNM55zLfhBeS4PcELJbceKSr/ITCS7jcs++0RO6x4od6ahn+Hqu/QR
 OdobPy4w7F7bBdf9uF79gJNW1BSJ/InzSZvN2Pa1UAgLRUp1UPN7iUgqCy9/RfytmIbj
 e5Qf2GHGEhv6EOfO8POHsR/H2e9LcWvbEwomWe44TY+QqJVgMKnlTb0jDdHar+T9InYn
 zF2n/DNxpE2P/ScCoRnDg96FUJclb+CxwIvV75jLhVZebNR6PkixTDg9giezcWTQYGuV
 jEvg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpW6qP6RwbvI3PDbrdY5f9jv7kWgkLewMQm+thR213133gfNyicmIMkaVm7fN9g63HPHNJ4Dp32sgQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+Bduy3HHP8DIeDhcpqMjHWGacDVnIXBXZeA5D0H36sgB7Gu3Z
 NZyBhPgazaOh/VfwbBpV23kF8OYFAcR6vS4Kgf5598DTYqICMTjgC3K+ohbKPlJ/VcHJLVrgK4w
 EZ9ccMeVVLUtAQtrTnJDJugKpaHZ9JP3aTuVs9mmwZLbVZDyyyZev3/esziD0mzwLq0WcNjU=
X-Gm-Gg: AfdE7cm/8vkNtwM42IOZ8hDJHde9DVGxXc8CTr+Ex61lC2Gh7NWzQabmdVFzjilMFjU
 zKODNOGI4B4sIyDnUqyKb6Nbc94HpYX+hRN3UaHz/DoRCiN0s5L+YMlWnP9H+vpNpNu7Oyzv7NU
 eqykNy/e475J52ImQj4HJtPRuYH7w60R3KRv3tLY46ODxVYqfGfpYLW5Wlw9xHiB2Y7xYiu8Xz8
 VkAIh2VEo3iqAJJ/+i5uKmS9UsNGH8/LfAqeB4F6LdUKJoyI/sVS1ef2yfIA+KJHXBvojByGnsy
 5Lp+tAM2773vWbqENQdY93mSRmFnP/I80dAup//1Qe9HaGW6sI/7zW/YAA8zjvS3ogInmoEveSg
 pUUEBt7wr0Tnsb2nTIJqcbeQ5EJ7x++EMF35XVg==
X-Received: by 2002:a05:6300:2211:b0:3bf:6c08:fb8c with SMTP id
 adf61e73a8af0-3c03e521435mr7049925637.60.1783280445923; 
 Sun, 05 Jul 2026 12:40:45 -0700 (PDT)
X-Received: by 2002:a05:6300:2211:b0:3bf:6c08:fb8c with SMTP id
 adf61e73a8af0-3c03e521435mr7049907637.60.1783280445455; 
 Sun, 05 Jul 2026 12:40:45 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:40:45 -0700 (PDT)
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
Subject: [PATCH 35/42] ASoC: mediatek: mt8186: Use
 devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:11 +0530
Message-ID: <20260705194019.2565498-3-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4ab33e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: sLQIL0TPXQedSYBHWyQ36pQ1YVYwvL2a
X-Proofpoint-GUID: sLQIL0TPXQedSYBHWyQ36pQ1YVYwvL2a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX2xBQfbfNbzXI
 GgMTXO6hMgCObLgPiMg6SrVj9e+W1CUDMkfDq7dnEfbK0Yhqhlsj8ZDrekMmc0MGzVYvxQwG/GB
 8wsnq7FoLsmxHHpisPzJpU08b3WZpgbeIpDlZj376pd/yIr3sT3SF+fxAVNjvfI/lFG8QCeYMwI
 9RkUIgqCRAkXKKvd1eQcn5wJmMocrU2+Kt94QQqZue8+Df0Tm+34505TeN5SiGAGwihFai5ag/o
 vrf8iveIN1NdNt5SKKZ7Rj1BQ5uOlhoFaFWHo+F5jOT+PseQjnI7B0ECfj+b2jYHYYGtE9CqpqX
 15hQdkUPGm7nZPU62KjQkL1BNPUwGOSaZPyUKLszi6G3Pn5We6Q75ed34pOSawq842Mbv0e3imz
 NafUwePziC/mbKkKGaSjOtB0dpU/eju76TMsXjrooiKqxRxpeDXXOs+joNYKSP9mpiVBhKZUfx/
 /CD92b3EtGpBBno9CQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXxMdivOqgEEaN
 sy3IG1VIPz9IJhT1KdOEixsEc9FZH3hILkK5FhQVXzHieSBQ0fep6fY1052FS/mKVO6trjnmjfl
 yQglA+OgBZLqdqXXc+xigOhOiPzglPM=
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
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
index 44a521c3a610..60576f885acd 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -2836,7 +2836,7 @@ static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe_priv = afe->platform_priv;
 	afe->dev = &pdev->dev;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_info(dev, "no reserved memory found, pre-allocating buffers instead\n");
 		afe->preallocate_buffers = true;
-- 
2.53.0

