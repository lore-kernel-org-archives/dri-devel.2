Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818BBC43602
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A59B10E280;
	Sun,  5 Jul 2026 19:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BbBSGLsA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RlNm0il5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD1E10E280
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:40:41 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HhsAK2168636
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 19:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WZiFjnWLtnN
 smK5dA/42zGQp+sVNdR8iWt1Gg293cw0=; b=BbBSGLsAqnWOATGTpRNCO1gHtgn
 +/zw/8wXZTNlV0J3BkwSreM5wcmTjEIf/OTa3q53G3k+GmVKk2WvAcGb1Ew8Q+8E
 QrpYExNDDivaknI9UzYxo3JTDkbOWqzrVRq+0pWix+SzBwl+OC9alMamMCk86nPx
 bmTcN5MVq2c1dhjwDSCMvlPP+5gNlCOpgfXdThV6SMKQM+0ZTQPkQ4Udmvt+mimB
 /CiyDPPnOPppMy7keT4n98UkPZmn2g6GcpUmf3hrAlfVAqeyUVB9oeO42PhzzgZB
 p0LNoVgtCvusL9jOPJlKPYe4pVrl4XUBs3oqCO5q6awivbcuGKDA559+r1g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6tj8k8s5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 19:40:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cac01e89e3so27436485ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783280440; x=1783885240;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZiFjnWLtnNsmK5dA/42zGQp+sVNdR8iWt1Gg293cw0=;
 b=RlNm0il5p/j7g5xRcT18cmnlNknCOdUd9S2YWkquABn3YLKhvirQ8upzCBxpHDuZzG
 G9MiUOyLHOsAmljAOFht61O0CztqCbzNFHmQ/wvf93umhkregtKKzyj2WjDhnkwn1i8C
 5Khp8U1yB3W2pFAlAg/K9y+uSK88mDBUW4U5RdDol6R9k+rmG5uzKUjzwadx429+1ZRL
 X+D9+RycmIgoGDjAKc6jRpq7hN1VuZCVshvQ8IUTC8UzHFFyMWxRKFZBOpy5Y7sKzoh3
 Y3X8cw5bfLMaHJvj8jf1qY9ksnL4tAyA9MfFdSIJ8YeHOdicnsH1R6WUYg2JGogGa8Mj
 uscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280440; x=1783885240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WZiFjnWLtnNsmK5dA/42zGQp+sVNdR8iWt1Gg293cw0=;
 b=PejuptuvH+hPyT2TblbS3rYP0TjrWEYvc2yMrxmGntoUCA4qD3rYBrqG+1gdkc9ak+
 iPuKiFMOjYGOaWYubADkfw6rmaiGuQoqd+bEA3O25F0hc9MhnuTXNihR7P/1y3iBJdHp
 lhg4wxtoLP5ZbOnMkPrlClLXWPXJfsYw2PHZjgehYG+86qbcSPZ3d2yNJqwlZzSmh9Zh
 V1AwrBZa6otIVm4HhCgnUCbYh7oCHfRcN7lXjhOfYxsy8SxPJnO+YrN4V8k4k+1acCWb
 4fptnDUzn6tsqzm+hHQ4oQH037gTyvxai3L+3VQKlUVQpKbcQM2Ts4uEj4rxl3NMf1LM
 cguw==
X-Forwarded-Encrypted: i=1;
 AHgh+RphP9eh/+FCZlJjx+34M0c+IX7bGN0c7lMEUO7dhODHbfHaxZkgIfHb1ykjX77CTD5n42JZYrPyZuM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywn7dosg8I3+Y7obqz4nyyNo7AsSi/3xwI8x1NhpZXHaiBBtJuX
 gLfkiq4rUQGL+u4ljOqod9FCnY0yi0nHKsVyKkgNTtYmGXpnYiFvAoTUT0+/8Vme4Adl2ra8Ebu
 YQ+mLpBZ7dN8NoH2234cryE4UN0+6ZRFc5Roq94FtssgrGB7cqPwoHNY3uFZTzjF8w2MSwks=
X-Gm-Gg: AfdE7ckzki3QwfynIJaVpE9110XAO/ciFfJB6Z8Qknx4vyyn/86kMwO8GDvriAH7rGW
 ya/geBLGtJ2NYjKhHz1YpQg3r1rjt63+dRAv1ACDo+3RLYEYBOW83cP+O9ge7fNFtj2Fcwq21AG
 gy37wYBJIIzpbdLJrMUs3B+owLOSAZaiTargJXsMSNj5/vpO9b+/Atz7dA6HtIx26UHKNUqePuM
 CtBWluKf5BqYjNgusejs+BpH50zCZ2TD0kNw2KyG+7Fu0rmbjI7BGVwVCALvm2cRp4O/DiHUgo4
 5/008UakTBLyk1XcxQATGD/KeQ5mKlrWr1LTLbnu9Wjwc6wEWktdaSwG9z4JT2//eWiJZuTN4QA
 Hl1UDYCgUiJ6bSOGUz985GNJuQsnCKZ0bLIykvA==
X-Received: by 2002:a17:902:d591:b0:2bd:5ae4:26d1 with SMTP id
 d9443c01a7336-2cacb06f287mr116872315ad.17.1783280439591; 
 Sun, 05 Jul 2026 12:40:39 -0700 (PDT)
X-Received: by 2002:a17:902:d591:b0:2bd:5ae4:26d1 with SMTP id
 d9443c01a7336-2cacb06f287mr116871975ad.17.1783280439045; 
 Sun, 05 Jul 2026 12:40:39 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:40:38 -0700 (PDT)
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
Subject: [PATCH 34/42] ASoC: mediatek: mt8173: Use
 devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:10 +0530
Message-ID: <20260705194019.2565498-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX+dVczqxuY/qR
 eClcdXALUH2n51RS1nSJL4o8Sy3g01jwj31b1gZWLB05V4OzrSvSFFzuCEAYHX3JMbNeTsjYZzX
 WjC0hxIM8BoN+B/uKpaUfDjWXVPAbh5yTLUOez7C3CBG0olR8Qc6n0tL82VvBbpFHEKWZgOqS85
 b/eVnTY2svJcyWm463KZHWCphKL6dXagkudI5YzFTCL5afRH4Vwl616XhWetnDZBJxaJRL7C4D6
 oA51yDwtTyAbbs2zqaYEJnldBfYDsnkYJUHpLedcTYPK+iLod+8QgmsxA0RESSmJoc0VoZvPlM6
 aZpUoocAktTviijpxmGuIBTimhcHe1nZGyzHAxVWGOZruMn2Txiq0hBjxiVqvnOVDuS/nTbQ1rW
 3i2L/+VLe903PeRHNgHEOTkSypUIO9ORDBBIlCbZ7/xpMXXe8o6EbV1DFN1wn4NtAEjybgbbU7S
 4/w8MJpIwGgXmHlN+lw==
X-Proofpoint-ORIG-GUID: arGegl5yHBdQXKazzPp2paekD0wBb3en
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX4Gvstvmkwzso
 s9n/JozXNHfBorKeCczus6nCS92ncoxq+EXkyPnXhOKZCS5DOWeZ/eEW2YJSz9ZBg/k2GQb3GhB
 Zq9MQ/lzpkm5McUyC0QfziAqbEWG/8I=
X-Proofpoint-GUID: arGegl5yHBdQXKazzPp2paekD0wBb3en
X-Authority-Analysis: v=2.4 cv=H6TrBeYi c=1 sm=1 tr=0 ts=6a4ab338 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=2-kJ_DxirqQsj2pPc2sA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050212
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
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 69cadc91c97f..0424d79bc9b0 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1072,7 +1072,7 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	afe->dev = dev;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_info(dev, "no reserved memory found, pre-allocating buffers instead\n");
 		afe->preallocate_buffers = true;
-- 
2.53.0

