Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0D8C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9591210E25C;
	Sun,  5 Jul 2026 19:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EDqYFdv4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KAmUP1rN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B814110E25C
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:40:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HwYZe2356825
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 19:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=03p+FFlmwi4
 5suRC+aZpApiuhNt9KA4gObs4WxBM+z8=; b=EDqYFdv4Pmeqy9IR99dcNiLiDAT
 /yuTE7Ljg9Hev+D7GIua619X8FUaXVlexko06UWo2I1UG1HwTHa/3pcOiO1FNKdk
 YiY1UO4+AP6rm2LO5F78feakLwRgePs5DdWtrzsXwhYCgTfecFqPFRL/MQqcfyO9
 pb9r2UQAkfcA5gru+dfTHa2mdfv7340zDAANejxt7cH1lKuJqEenlOMOzxtkjth3
 hBP3jcZzSc9vRDjWjL0r4gMT/svWmjZh1dvVGSJdpYFTDJ+ZtuRTINMxgHG6Wmig
 3zizUVw2wRtMv7D6VUvWZqVy2hRD9jXlwyfLqvXinpJSMddoU1sfRGdzOYQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh3cs3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 19:40:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so1730101a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783280430; x=1783885230;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03p+FFlmwi45suRC+aZpApiuhNt9KA4gObs4WxBM+z8=;
 b=KAmUP1rNfopiy4kl+iq00Xsf9Mb8imI2NGzwf0g2DMKlm6+3iU1GdqarIZRyZkXX5A
 rnCV/SvP66O1qC/aF+K72eMJl4Co6MfB4oRR7tQSetVHQ9P7s4v3yql0AqLJwH4f50gJ
 sy2oWtSWidt4Z7JHSfMm15bYmM+QkbR2pIe3k307RW1W3trXECvWPVHFaPkUuWSZOYVG
 M2YvgogWxYxoJGGWbrJzv67MYVV8NmIkR/1gMP9cMNb8dA0oXQ6/Cy3T1R2KDwFxtmF+
 hqp0Ypzzu05zO2M7XgIkS1rR1pPOJDNAcdjE5l0yFp+jh6V4D6qveaxKJYFFPCV91rBY
 Zblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280430; x=1783885230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=03p+FFlmwi45suRC+aZpApiuhNt9KA4gObs4WxBM+z8=;
 b=AtmhgjgQNqT9k6DzJha5LoAFR4TEM6065819SrUJDWFfJM00XTZ/kks0hEzlGIcAks
 u3MYDOU9Ncfq+lzD8CEvM5caPcWEFv7GHIBLLfvqUF6oq5b8BFoJ/PbkiTBNaxCrttv1
 Q1KJhjlYvDXKyKBc0mCHwAFJZ/Otri6giQ3P8FdKLO/VIPAD7YzBKkHVRbk5k+e5/iQp
 78DZPQC5wzFC87bvZvmLtzZwlK87cUjHOTAhpPnW+yrJDLI4LQnzlXe8Dl2C+1fHLiiC
 ydNeAH/Ms1ARSjYqPL2jdVVrMiD+oxZ+n9CflruZF6bITE5El5Ywg8XI8mUji8dCSmnC
 VRnw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9Igb5AWWwUz4QbvlTH4nsxYDVYmdF9FkNQlVR6qn6Ygo+khE6IiKNCo+A/2rHcLh8eAOI8HVYkfA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzzqLF0gbRN9mZa5kP74EwXuLfR+xJwfPhLJG24HBCFu2gf96B
 WB/Hg+/LL4eIwEVnwnSoztdcnyY4OLzx2Ne93nUnFdIhnR/jzlRyT92jfj+0X0fpIJrVvuJDolt
 Riehr6Og+TznnU2wAo4XDVkx2VGAUgxI68GUqGJQQr37OxMd1v3ksAtG8wLrkbeqRWqoDuCY=
X-Gm-Gg: AfdE7ckIJh2LKsbhtiEDilzzdYeHa8eVw+yNAOgwZauP40mRSE+Hw8omkDL9oaysvVu
 RuYaD1J155EHiHjs+cyeWbNgZ/d3NaCWrZL5JfC4WTxHhCEVuenheliX4yATVic3+x3aYyozOMr
 HCYGzDdvaQLUaRxKFLZIdQRWW6FMWEyh+NikSWKdIjpFJ64YTWyX6gjWn4pEkJfZXp2LTFcoXQO
 VA4j+pO5a5/FlSHlriPu30CADPe4sgNoOi7/2aSvrop2ac495nTNncKweWHTEiqpar9uAzHOyiW
 sf+MgP5fABAAZHIzlbg3wJR7qtqd1MUkcGrgWTYQ2qehVNPuohxiYDHOStFW+w1Z1bef3Xwa/Ie
 NSheTRVwkth7sVP16PjvjVyth9IfiMAaOYJTibA==
X-Received: by 2002:a05:6a20:a122:b0:3bf:9944:a8d8 with SMTP id
 adf61e73a8af0-3c03e3ed638mr7693672637.34.1783280430280; 
 Sun, 05 Jul 2026 12:40:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:a122:b0:3bf:9944:a8d8 with SMTP id
 adf61e73a8af0-3c03e3ed638mr7693658637.34.1783280429779; 
 Sun, 05 Jul 2026 12:40:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:40:29 -0700 (PDT)
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
Subject: [PATCH 33/42] drm: arcpgu: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:09 +0530
Message-ID: <20260705194019.2565498-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4ab32f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=lEtn7xO9CsvGDZioIccA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXzvi8ObvDRIq8
 KyNkTa9EZozCrhxWOBLVl7nG0AqS+k8f3m88CtbVdBtYt6GUoifzach3uJC1lJWnvzJhtcD4FLf
 o63jII3sc0QvCrwl15+csYKjpbdUXMUVM9GgQ52KlETYJOmtLzZgRkIar+jikBWKq37n4ojd/nu
 Ik6QAF4eDvsdJkBXcAfKCcmwBL/IXc+xjd1b9vrvWJCbSCf0iYu8Z3k56BwhpPOp8R1cz/IAVpO
 pqXJGPY3TOMRaBIuf4ALQiDOpPkxMoM9ZW3qGQUjNIt0+O/X3SIWZ5/LqbYZFcpeKFnod43Lt8F
 PzwCMnmw7Z7F+RE5J0wIYnrvZXScI10MafV6us4Auzs7Yb0PScj90Qw/xOIRbcRkU3bHhihQwei
 +S1OKMdhYMLXAm+LtpvnUKRFd6non+fkphnGBR9BBmvEUEzO/IEM2PBR8A8T1uMKoOqR+lG/1w4
 VRG5uKQm2AWuv11Hlnw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX839o/hgWJCjA
 fzF8UXk/2Zue1kr2E9monIgLs/EnM+/ojEuiQrVBOMjsNWWB9lmREtebI8XAhdcFC4+u3c9Oho9
 wLTbjx/BydfbRsSjtRVtdGlVTZjjBfM=
X-Proofpoint-ORIG-GUID: klo9Inq8lWGNRcplxtlEXcjAZ6JvWi1m
X-Proofpoint-GUID: klo9Inq8lWGNRcplxtlEXcjAZ6JvWi1m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
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
the optional reserved memory region is released on device removal,
fixing a missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index c93d61ac0bb7..fa01407570a8 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -278,7 +278,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 		 arc_pgu_read(arcpgu, ARCPGU_REG_ID));
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
-- 
2.53.0

