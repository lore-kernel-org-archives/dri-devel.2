Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32757C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CDEC10E494;
	Sun,  5 Jul 2026 19:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gu2AUpMP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bn685pPw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 126DA10E494
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:41:07 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665Hi3pr2200997
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 19:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YE6y7UueLsf
 6Wosu2MYgZO8ntkoAFUpog26frL0IVlI=; b=Gu2AUpMPsdWihBeIKFaHZTQdE6w
 3hlEj5FaB6LO25HrrwgnnnhbotR4nd9Z4wSGwf4UfkCGQV/6ByGXzYxc9t77t1UR
 KxydvfiZRzO7LVQt12P9iUwRudBr1BpCa8xRlWA11APsaC65cFh9VkqkdXLfhVEu
 RS7FUpWGXF4DoGxxuONB7a1iHQSW5kUybFXNTGlhVzncQd/ITVBR3Qzh2FEbhv44
 Ssss7TOOyxh8WnUK7ITPBb/1fcoeLek05gTbaYXanK/TXcrfcsX30aor/3gRRzD7
 xH/7V5eC+aAPsHQJS4BlpVVOM2yO5umWhzidCMbdBGwQ6NruQAfsY+kAKHw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txek768-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 19:41:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ca0481106cso24488075ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783280465; x=1783885265;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YE6y7UueLsf6Wosu2MYgZO8ntkoAFUpog26frL0IVlI=;
 b=Bn685pPwKFPQQiujM+tqos6JNoYRl9Re9A+iYGxg1LS64SL5c14kHEJ6VfULb0xZIN
 btgDGdWzviRdirlLp/7/a8CK1D+AnEjmTqdGnEThZ+frgzd5nrNt27ZDxCK5HV5gAXqZ
 qDKBZLOW2TrcA7FuwrOLYYi9ustr+UzHlnCTKDFbLraIsIpRzOaot2sEutzAOTYe0xBy
 9+XgI5D86HiP6w+HGVyLKDfgzyc8owQ45novpXfE1xa9cBjaikVYdeV5NFOVYVxXUp9V
 4wxnQxnjqmiDe+GmjLwkKC69APUmMkKnz9hRxVEoENxzl79j8OObUn/YtbeCy68ZuvfB
 whgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280465; x=1783885265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YE6y7UueLsf6Wosu2MYgZO8ntkoAFUpog26frL0IVlI=;
 b=GRoYECzMywQmMF8rLNReQnDpNLpYKz8KDijHHhmTAJuQrtBDDtorHR+FwYa700eTXq
 PvVdgeoIuk3M4eWh8tPdwC4Y/tgCw0S2IZ6+4kDOh9CxPRT2VS9Ob5ypZklNmgOGSftZ
 PdDHlrcjmy/mj7j5flEF212O0351bnE/K0m65wKCs97MswHl6u60tOQ95XTwX1EhiEsr
 PpOr4ordOUw7+KtI7PhYyLJvYftA0F1Y2Gns1HvWaza+Il5KtzELKQt3wGDLpF9Pk4J9
 m4Y+xmlDdpQNQakPV44doSQeAvnWH6gKGDAbrJVq05j7SsRQ0OyoZfr6VNYixvMN1e1b
 /5lA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDDHr+YY2Xz0cAqyl1EHnkExSYsQ6Ds2uYtnHjh98VBikGG6KeLtMIY+Cd0Ajqbxvk+dDbvWgRIdY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrrDSBOOpSwOUI4ee81CSApsJ3tYN9VwKE9Tc+JFt3DGqtB8gy
 Ubfv9QpGPg1zE1Oo/vCl7oOkOuI8jzU9nAwss9K787+S1jlHMCxxMdeYIkzdJKiQnKzKxPBkMAa
 Z4594cUsd6S5LktNcOHLi9WqhKfWz3ISsSSFBkisA6yPuvLuC27bEf7hUg9clMH21KSrjt48=
X-Gm-Gg: AfdE7ckYBMRZ++EKuu6HR9gVzuh4cSMj2NPJmJHm279PS9EJqn4mZ9F0zXi+SlAbHQq
 cXW8XsqY/l/hHugbSQlsbSpBMpbtID5/EbXOJvcGuEH5Y6BqVbJKQoPks0XMwhGvfU9XVpN07//
 B3TVdTmMvirOr/tkptSwD+Xx87PSjlUeK6VNXsSb0UGpQBj1lvUrp06NdE2+/OD94L+id3QSR2S
 Or4I7Q7YqNcbE71PBac/SA7XTVW21ctSfJhWrPoK5IsNAOB57EHSVzZmXOXEtojr8cfCuW3dKoM
 xysUogupDdACPOlp+zOhWo49PcKiUvNmaoTGVbtci5Y72TLnPLZVTdkajWPMCJc68xmTmZpdnwt
 QT6OTCtKYb4WXvFUn+Bu0XOKWshwMyxNk0fJo9A==
X-Received: by 2002:a17:902:f60a:b0:2c7:f12d:5d37 with SMTP id
 d9443c01a7336-2cbb9e264d9mr68673715ad.17.1783280465201; 
 Sun, 05 Jul 2026 12:41:05 -0700 (PDT)
X-Received: by 2002:a17:902:f60a:b0:2c7:f12d:5d37 with SMTP id
 d9443c01a7336-2cbb9e264d9mr68673415ad.17.1783280464710; 
 Sun, 05 Jul 2026 12:41:04 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:41:04 -0700 (PDT)
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
Subject: [PATCH 38/42] ASoC: SOF: mediatek: mt8186: Use
 devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:14 +0530
Message-ID: <20260705194019.2565498-6-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXxcmG7q1m3kTY
 snGrtaLgsTMD51u8qlvIabCDrWQQOf/+51C7PrrduiGQB/G+d5hSWpZD07FlPBBeAhn2vAhe5fi
 hIvyR/+Sf4o5bOlOH05R0N1oM3hzrRo=
X-Proofpoint-GUID: O41Gcwm0hoPJll-F6p9DmsT-Q4l2Oajt
X-Proofpoint-ORIG-GUID: O41Gcwm0hoPJll-F6p9DmsT-Q4l2Oajt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX0Pxi2ZnFDKCi
 qZFD2nXWGYXV1XhKJ10kToOec5HxgtpgkGsvDqJhORXRlQpvQcuZQEzAE8P/q8EB1qW9+8TLoFo
 CMHXB5tw1pa+ec5A1r0qfLdQGfnJRCTGLERF9lj4RHxYCqc/hzrlqU5OYvlX2Nl6MHAutmYQrEQ
 CKkvJfO/7PKCt/+fsMdPmW4U8mmJQrOuUq067C9hfRGi6/fvatWqoq2oEw7EqOM/J+ZVdGY7+Xg
 VTkO0NiUzndnsDiCRi7lML/jk0XgRP6WwL4Sqfb6mmbO4098OAxbtHDbYErk+D7cIjeXD+SJd9Q
 VjKqpLOjyRdUujTzeJeG3xAUZVnBI6REJoYK7XMgeUhBgvUDnv/266mnw5P2co7zinDjtEzkiuB
 WiZjzkRFW+wxFlQSmLfnlsGLFD+pfXFNuKyh/55uW4BWOefc3Tep1V0paz0x4iY6bPoAL27itO6
 s6wDxfz06bcMt2faWMw==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4ab352 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
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
 sound/soc/sof/mediatek/mt8186/mt8186.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index c1bea967737d..a5ccee87e684 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -49,7 +49,7 @@ static int platform_parse_resource(struct platform_device *pdev, void *data)
 	struct mtk_adsp_chip_info *adsp = data;
 	int ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_err(dev, "of_reserved_mem_device_init failed\n");
 		return ret;
-- 
2.53.0

