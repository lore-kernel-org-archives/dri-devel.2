Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB62FC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B60510E4E2;
	Wed,  2 Sep 2026 20:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CvbVC+q9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bGswkUVY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E3610E4E2
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:17:03 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682Hr4mA2104995
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 20:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AzXtSV/WWty
 dTYO3EmejDkL+S0H/FVtNGv1YBW4SI2s=; b=CvbVC+q9kQRRtFSCnNcyzsAX5tj
 yTWXuwhhl+7w/PCwuugp+uPc+vbrzE7anfZtzqn3uf46kLo72QjQf86fmd1F4AHh
 YZz5UIP4/Sl0EbR391MOBU/DWnz+wNtMd2+J6UiEf06DeZJ9UcSFFesMDBHrLTuo
 nyo+CJtNOEw4++m2/oAxc2OmlDoocqY5bhZkHlq6VkXFFqQrcYA3RFW8MxWkdwy5
 u4Daiw3zhz6A0Wd1VQbtsPS+efAub9dHQaYctpfIgSP8G4jPWB0Umbn3Ul2wHZvW
 Cnp59SwGnFPZwPQ09iNce1ycNwr4B7tBac3ES/O25zXm9HWjJ9tn9m4Zt7w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdsekc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:17:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398d7e0f3b4so2058269a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788380221; x=1788985021;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AzXtSV/WWtydTYO3EmejDkL+S0H/FVtNGv1YBW4SI2s=;
 b=bGswkUVYwEk+EgzM6p3fc1z5IXTaz2yfPNhSSzU3DosOw52+E2rvpGvOondzLibqOr
 ve7vSOyN5/1mcLeK6uugJLKkTqrTSA5tKxu/qhuZroSMVWjPyMhH9X8/VXp/3MDEMtxk
 /eZ/U813yLypw/Ns0+bK2ow1+leUUuwD+UMp+b81Ds1t4jbLetQU6NFZhfxa4YbOcbye
 Q34UmLTvLnzigtNfO8AKrV+szhxfH35FnEmbJ4HcBA7FDyieC0ZnXJiOJC/myrHBzumw
 10ycKrMzgSRfduooXTMBBO4IeokLSjIVLIrT9MshPY4lgqVqkyC9TiifnnD5S5EoS/S1
 D72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788380221; x=1788985021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AzXtSV/WWtydTYO3EmejDkL+S0H/FVtNGv1YBW4SI2s=;
 b=bElgwU1eQPw0wU9beQJxL/ID546g6DKw3tVErpYEp/eV2nWkOOQcMWfWgUmCbLRXck
 9wCMrjNd3kkILWPhzeyOVs+rzeNlE+BI4/hPBMXpbjrc0yS2T3gR93E2h3LZU09AQFqA
 69RKhvqIzfrtlPg5xfurQjT4PG9rmBH11/4tQzoURTweFbiZNgnjSIDsdmanY6IxiVju
 tqhi1TU1cmCj6SaIXEWMYG1TLQh8s9WyoXEm09xg9Jbg6NajR+jrGz+jSPtVTiRLpKOv
 TMOG5iq7dOw3Uweeou1D2MgX7Q2T0zscVOzFgS26jyjAoU9FCQCUHCEqrG1TgaXVHkFo
 kUlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIgVo14ez8jd7r3FUJspS+aAJ+yqtXMcDavfF4m8P5Zg609RcTl03+qlZqdW4+P+wmAEI+s28HmQ0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqnYTIXDtY3yPSYzyqmmygBBanqH0QBfC0zXEfyDQn51TSl1Nv
 yYCDeCyxK26HGnfDXO3UT6Q2DhVvxviAXd7O8Wk+Dj5j+FFfGVeO/4VRHM6zU/0pEvwEUJ/yF/0
 FncjlOhzLrAsxyMvdtYh/W8q2Oi4fI+P+IN0hta27umJwp/gWSIAc4QV2Mh7UJPhiAk13+h4=
X-Gm-Gg: AYBFou1W/m2frylaXjsW50G6i7cN0goyrolaHUNh1LuyFUToFJm0dQ6sVnX8ec2oj8E
 zo4jZF+wiSLJQJqnkWSC8VNVFHdnjDaQugzQSJ3ZDJ7b15/mtscJWxuFtcqVutkIMu21T5a3C2v
 F2fVh4C1oBXIqMZD/4zjt1HIzj0j1XDRT4M5+yln2BeHt0zPHAZR6m9LBqiq3yHlTe+gjO4SqxW
 En93xMq2WzcF0NV2hMFq6/uYh587LR4PhBTVFG7knELGnLqLbJhqCrll/OwRZgvSUlgN+oSIDet
 BzhB8USHac2COURBsQdw6GM/42cSxjnBuSirPrxAjBJrkkjQiB70e1Iw24IacSFWrxDX4hRUuar
 pms5/z4V8Olzauras5BE4B/YiR3s=
X-Received: by 2002:a17:90b:3907:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-39aee066e04mr8860751a91.14.1788380220862; 
 Wed, 02 Sep 2026 13:17:00 -0700 (PDT)
X-Received: by 2002:a17:90b:3907:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-39aee066e04mr8860691a91.14.1788380220414; 
 Wed, 02 Sep 2026 13:17:00 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 13:16:59 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 1/11] drm: logicvc: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:30 +0530
Message-ID: <20260902201640.2024648-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a98843e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ReI0EElcLHst8dYcsfAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 0oscMam6NWXxAhbOUFoFcpUo8QF2iVBN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX6z5AamOxbEd5
 68x1ILG1kg1rqD05Mu+oA6CPJNE7HfBeUnFeOlOEUafzP1+s1gmsL/n3N3JgQEX1cIwjwGMCoLe
 3lWtRjy3uMwVRFvVT1dxJVrx8uYE2RNut+xKnQohuZzPEAOess3EzAN23DjLUUMWoeS3qg4Yd1b
 3n7VDMYJ3phrPaJh3kF5pBZI+UKsYYg5fTE3LoPCd6tV2m62Iu6rmsxOe1d598cibqIa/kwNlWi
 mnqEG4s9ka+b+544mcZED/jTcAA7PRWqGXDUBi3ws88XhFLfekoiWfzTCOVsW6Aw6WfB6lXgTjT
 V7Tm5EYBgEqfZmoSi2GqL+U+KSe3cBpERVP1Qd7LTC9aheNRpz6qgh8VFT4xud14Kbx/N8CzMES
 VfJIpC76ZX7KIwQOQ7699WejRz8NaIl3vd/kXVzFUF7Aoj58wYftI4oLMDC7oHeTNFUKyBBB5GB
 JL1nHTIrdQzcMzPYdHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXztnk7umF3Kkl
 X5DM2BLX+u9pIjodO4IbSslVu9cSz6B4fpJ5EM4thCxrsm4qssbGyQJEsMP9k3T5L1L2WZ7L0Eh
 3Z8WmDT8Qf2nVKSkFclsJFsCRky4uuM=
X-Proofpoint-ORIG-GUID: 0oscMam6NWXxAhbOUFoFcpUo8QF2iVBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179
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

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device unbind.
Replace all error paths that jumped to error_reserved_mem: with
error_early: since the manual cleanup label is no longer needed, and
remove the explicit of_reserved_mem_device_release() call in the remove
function.

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>
Acked-by: Paul Kocialkowski <paulk@sys-base.io>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/logicvc/logicvc_drm.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logicvc/logicvc_drm.c
index bbebf4fc7f51..d6dbe52ff0a9 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.c
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
@@ -306,7 +306,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(dev, "Failed to init memory region\n");
 		goto error_early;
@@ -327,14 +327,14 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 		ret = of_address_to_resource(of_node, 0, &res);
 		if (ret) {
 			dev_err(dev, "Failed to get resource from address\n");
-			goto error_reserved_mem;
+			goto error_early;
 		}
 
 		base = devm_ioremap_resource(dev, &res);
 		if (IS_ERR(base)) {
 			dev_err(dev, "Failed to map I/O base\n");
 			ret = PTR_ERR(base);
-			goto error_reserved_mem;
+			goto error_early;
 		}
 
 		logicvc_drm_regmap_config.max_register = resource_size(&res) -
@@ -345,21 +345,21 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 		if (IS_ERR(regmap)) {
 			dev_err(dev, "Failed to create regmap for I/O\n");
 			ret = PTR_ERR(regmap);
-			goto error_reserved_mem;
+			goto error_early;
 		}
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = -ENODEV;
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	logicvc = devm_drm_dev_alloc(dev, &logicvc_drm_driver,
 				     struct logicvc_drm, drm_dev);
 	if (IS_ERR(logicvc)) {
 		ret = PTR_ERR(logicvc);
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	platform_set_drvdata(pdev, logicvc);
@@ -371,7 +371,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	caps = logicvc_drm_caps_match(logicvc);
 	if (!caps) {
 		ret = -EINVAL;
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	logicvc->caps = caps;
@@ -382,7 +382,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	ret = logicvc_clocks_prepare(logicvc);
 	if (ret) {
 		drm_err(drm_dev, "Failed to prepare clocks\n");
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	ret = devm_request_irq(dev, irq, logicvc_drm_irq_handler, 0,
@@ -450,9 +450,6 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 error_clocks:
 	logicvc_clocks_unprepare(logicvc);
 
-error_reserved_mem:
-	of_reserved_mem_device_release(dev);
-
 error_early:
 	return ret;
 }
@@ -469,8 +466,6 @@ static void logicvc_drm_remove(struct platform_device *pdev)
 	logicvc_mode_fini(logicvc);
 
 	logicvc_clocks_unprepare(logicvc);
-
-	of_reserved_mem_device_release(dev);
 }
 
 static void logicvc_drm_shutdown(struct platform_device *pdev)
-- 
2.55.0

