Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8AFC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E1910E50F;
	Sun,  5 Jul 2026 19:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LEH8gBGq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kHravEtt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A54310E50F
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:41:32 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665IShGZ2443705
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 19:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 keNlL6A8+I5pnaNawbDLPC3Skjo9l1+hFMmFLmQIfDI=; b=LEH8gBGqre98aZ5S
 R+gXIdM13wWVBKCaHBPzQIy3YO16XtaM2Yeu1rWWcKE8Ahh7phGi5PdgSe6faHYh
 NZ6WuJayU3dm2BjN9bw+VBE+ZM79Gb5/VMy0wrJmVG9PAL4oi/vWr8CCwZvut6LG
 bgx8kYmZdMLIw+hO7G1imKVsWOK46Uaj/pGQFCjPL0CK5llMYjmxUaWFjupRdJAp
 DojiJvRtFxtp1fbC0Y51KdHDxd4iTgLcudGv/2y9joceF7NK21EqPuFhp9vBp/DG
 Mr1h6o1uwl/xqAgXXnlbwqyx/z4fTFXUP1+eeaAFH0RCQyOQiLqKrFrdvXcDdzoo
 l70Dvg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4sudwt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 19:41:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9151bf6ce7so2626891a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783280491; x=1783885291;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=keNlL6A8+I5pnaNawbDLPC3Skjo9l1+hFMmFLmQIfDI=;
 b=kHravEtt/BecarX+Zcyi2AfkpcoMEgayGPRJk8NSASqUXXDGgH5OccP71/zx2xbs73
 om5gym6PsPJLzNN6ZGD8Up2N453vYU6qP3CFoADLNqL3NvzgvHeoy42krKDIyBCaO7ZK
 uz+0TCcnDMnL4qjcT0sLeGk0neiDFWuVA50/qElUdSti8NqH+aezAghTNv83IBSdfB6L
 S/KpUonfkcL/sxdVtvfg0wiAmTWmncCzyhhQAXzR8RGYOILtRVEJ8j3aJmHzxUD3kxxN
 S82sWeVs65GD7ZZ9c8333S25L5siOI5HS1InLvz5KlxcUsLtnxB752sdwRdR6qDzDR/8
 Qvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280491; x=1783885291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=keNlL6A8+I5pnaNawbDLPC3Skjo9l1+hFMmFLmQIfDI=;
 b=RCzAPvAwF/X7MGNnj3eUpYQGK+yH/9ZE0ZQGGQg7m/Bl3Fju8927w9ovlm2Td1go0R
 D1IsCbiBUi9Va5/dZlfkgHHL2QXRb5CTXe1eH+ye/NYzT7dWuvTtDoiFN13kfjLxjVR6
 Lhhp4QjreivQeg14v2NK5FJJUe8vU3UWTkrftXP1erfhKRY6TenMchoj3S45YePjT4NN
 KE39ypu+jLQbkJ9MjDwOW1Nagwttz9lgY67SctdWdu7cLfqBVPRF28q/+9u+fCMyNfjI
 UYS5FQN39dua7dnGNqan5jH371XppG9lyafpOoGXGbvPVrJXdbJ+3jRm1s1S+UiUNqD+
 AU9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIXElOlL7vhNFd53f1Y5s0AbaojH3X2VtfF94S1nJ3usMxa/U0L9bnOGaOnNcL6yd7S6mgGnAcctA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyy6dG9UUXkDfsmyn2WLEo408pqWSVtuXzkXOrk0MLQQjTkO+uO
 50yS+vBsqby6VNtVqYL8tzs7T27l4fmnXsSqaomdUy+obhxITvpoSdne5HkclithNCEELobi0HI
 WLzSi3NJp0DZ2WlmTFNIgLFQG4jakDVkjx4JqoOG/MFqnmw5bD+lWE4o5/O0uhqFz50P8fXE=
X-Gm-Gg: AfdE7cmr3nXyRsbuDitihgobI+/JvbB5Nk1RCUDYpe7iLY+zYqraEUPfi5pBS3YJA2C
 ZhgckI5qADv3pRmrFDj0HnJSYapm061XVrFVsUR3Ui+oQAQKbUi58Urr1WeBkQ2EiD4wjiU1Y1y
 v+f1enQKAc9g8YPFiFBE+H4jnTGr08biGcsUuD//KFLownuU95HrsiLRd58MVL3weGgbhZGgjHa
 Fxk7XuS/xZfkU68osHH2ocqL0xqFIReMvk/uFKPx0NQXbuTmLuQJe+6otnyEhLNi5Rs5tnYAeDM
 eoMT6UfRHOl5gsEc5bwLqK3LJgVV8zPrXL9RvnT1JvWM8FeWOXbJ3S/l4aEYxHacrm5MKbbCq1N
 X0LkVJAQBbyOQUyZnebZyzCAaGAZoASAizoo24w==
X-Received: by 2002:a05:6a21:4cc6:b0:3bf:a0e5:99a5 with SMTP id
 adf61e73a8af0-3c03e509089mr7554480637.47.1783280490845; 
 Sun, 05 Jul 2026 12:41:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc6:b0:3bf:a0e5:99a5 with SMTP id
 adf61e73a8af0-3c03e509089mr7554455637.47.1783280490326; 
 Sun, 05 Jul 2026 12:41:30 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:41:30 -0700 (PDT)
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
Subject: [PATCH 42/42] ASoC: sprd: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:18 +0530
Message-ID: <20260705194019.2565498-10-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX2rkWPTgUQeSd
 n1vQVxVEFo51314Qq/cUg3fVWSS6LAy0wxXmWtfDESze5ujMo4MFD3ALoRwF/l+/tsz0VmZ6LhB
 126Pe3ApRJWlVP8EYAjgY9euYYIKkNw=
X-Proofpoint-ORIG-GUID: MBFi2V4W36hWt1HSHCkmZ9oFGAvYRAzV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX1I8PV++9JMNI
 PL30ZPYthEwab8+gVns/Ns7ZgKFj/KebMy4ftFJaBlXwlzvsS0Amjs/NMJCyO4OvKVGMRJRUhkA
 KzHtSqHiPzUrSBKfL3IunZM6YFqhaZklaUv8v6512iNegym/aFHMhXa09bu8EXHppczw+dZVU2G
 UP4FwD6FKc4PwsrKb50udm0Lb+aS0jpP6tYpPWvgAb93Ho3xG/TdWnKR/BM0RFw47L7lil+jIjC
 5IOWFFxTd40DlmJRlHI0KkNuoMb/kOlTcoeN3BKeSk4YePXyzk0OsgrsqgNBOdVmTYt3JgAV1hX
 Wecu1WIj2ugGLzZD9bt6Ss6JI045YZT/o/iDrW7/URC760A20s8jIMvMgiZWJmzOsbmy9NbA2lq
 QV74AI8laqua2UH8sxiIHg9BKYWOdrvf7oWfasi8YTFbdl1k/Z88nl/JFSOdMFFSw/LulPx8EJH
 8E9TRVhF5iiyLMcGSQw==
X-Proofpoint-GUID: MBFi2V4W36hWt1HSHCkmZ9oFGAvYRAzV
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4ab36b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=99hAX-h0IAisWkWT3OgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
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
missing cleanup — the driver has no remove function. Also drop the
now-unused local variable np.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/sprd/sprd-pcm-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
index cbf5bf82d96e..220f55d475af 100644
--- a/sound/soc/sprd/sprd-pcm-dma.c
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -459,10 +459,9 @@ static const struct snd_soc_component_driver sprd_soc_component = {
 
 static int sprd_soc_platform_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
+	ret = devm_of_reserved_mem_device_init(&pdev->dev);
 	if (ret)
 		dev_warn(&pdev->dev,
 			 "no reserved DMA memory for audio platform device\n");
-- 
2.53.0

