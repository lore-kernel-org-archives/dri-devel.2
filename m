Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9170DC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A1010E505;
	Wed,  2 Sep 2026 20:17:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YH71TVQX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gZuUWyNH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5317F10E505
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:17:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682HrrOc2731186
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 20:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5pBRbhbzo1P
 cOFREec6Gs1n8ea1WgM8d8Z6/KvlnlrA=; b=YH71TVQXwSMcn3Fu/Uff9SK4nzC
 54IULE63yNKCuMTPEd49MGBUR9KKNNIN/QVTquPXtzIjMppcDurhMW02H3mw/HoK
 QpIWWpHShP1aC26/5Elx8gXqpOsaRWjvdKkLXCUSyLf1mZfjfZiZSS4H+mV1c8Id
 88ruhQ6RqKJIryjdqDsY4tS8gLQX3HTIOvazfZQQPjxVQiBY+Ozb/umbSbvelZan
 fwT6i3hl7FkpHSIJoP7vd8T9SpNtUG5AcXWPwBduK7YLtF34TKGVzNjoOtZ3ZMdN
 eB2EhtinE7Jy1HoAhoeMJRx0yJorifYNZ8msk5ykeSvB8lt2qUSCYqN0DjA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy2t57-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:17:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb92868263so1334907a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788380231; x=1788985031;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5pBRbhbzo1PcOFREec6Gs1n8ea1WgM8d8Z6/KvlnlrA=;
 b=gZuUWyNH4SEYTK8z9wVNyuuL0E9Diu9///LZR0HwohP24gBSS7n50MzcOgbCPGYvD/
 C8tPpjavdD8NPEF98W6e3kbOVw+reuZ8ooO8/hPePCbbuuPhuDynGJYZee2s79ibMAFn
 2ulRAQo1MwWofzP5Sq3XtdooZWBczlD9cUn1sI+Fcn0DG/lImjQiFdQfYmWIIBQVZvUm
 5lUC9s90hCsUClEE40JYEF2pjlmkJdXaTgGmxFn50VPYkTJav6EelJZmpLyOl44LvkeL
 FfIytXCEvbfegbX89N64FILfSYnrwzzD/oer7BbuUY5Vmt03FWuR3DyLL0OpnDESNsPa
 xfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788380231; x=1788985031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5pBRbhbzo1PcOFREec6Gs1n8ea1WgM8d8Z6/KvlnlrA=;
 b=jI4VdyGWVpumz//DCAW9nlPl3JfqqFdQbWbyzCgEyaRQUKcEb8wP+tHh4EKfUnfPHR
 lm1+A8OG/Q+5Ks3QNlkUVVy5AdrZ6ZBAUYxMahfmYc2LNQGkbi2VyjiG1NLBgEBl+Rxz
 s7S4d3ZtpVeLmiSm2AHFf9TPiO3unuWVmW0X34k0eAMcFjLDP3riM/9ynGD5c344cDfl
 30wHIA5vRpEzRLD+nFb1q95u+vQgZOxWoEe901b3Uw40BSWxTmxcmx61u2GdZFUn2tRK
 eo57UnU1TDRMbji4K0GhKJF1iYwI7go9VvkpmYjOo+t+xilWBYnjZM7qOrv5+XEAOreE
 kPmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIBBZqNWvJ+Oc9VxXVKoJwdmaCvDIr6v6K7OjVwR8y2wkI2FRJMOG4LeZy6is9IZ5xKkNKNPNODY0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ktnIM/XfHiH98YS/OolZHMW8ekDnQPqj+obugN7RGO5xy+L5vC
 pHRTZUM3oewDV8K54Kyrnjbp6BX3/JMw6LfpCGuNvmKgT2UhMoB8/zzaHZgTvy9ueGB4GdJS2nt
 pwCkDinVLEhS8YTwlRu2YFsZcr7bGvTDjcdGBXhsME/n/I+skVERfs1uhgwt2UbnSvDp27ZU=
X-Gm-Gg: AYBFou3niNa2NG/7QRVABQiFzwxIZNsY8H/cf9i2y+7ar5Iw9hqe+qkgV/+AsxotfT2
 UGbDUBR0liX8IVzJFmdK6+tUbv7pv6o6VESRrcPjw6ChvbzrRz7/Vp9guCpk30d/ZsUunGj2Bas
 xSmmBy4oE0mWBBpOKJwYPY4jJvpv2J2aVO3UwvsJ+LdMMLBmbTlALUj4+GOnhiWd4C66qR4KGXA
 gz+mX19VyjDKDYy37iEDWT5urSRr0ofsPtGRSS+LSlnxzNDl4zSSa+8Ze/8xj0EsPd8Pjv5Tpgd
 xAPGgcwXoXkK1ijBGbREiTN74uP/vOf9z30YnLR5kcVcIM9pZobFRjud6E6J/L4vys3AucgMEyn
 kHUBVej76k/RFZTtFlHDC4wHCg5c=
X-Received: by 2002:a17:90b:2785:b0:396:5cdc:4bea with SMTP id
 98e67ed59e1d1-39aedeb83e0mr11608225a91.5.1788380230684; 
 Wed, 02 Sep 2026 13:17:10 -0700 (PDT)
X-Received: by 2002:a17:90b:2785:b0:396:5cdc:4bea with SMTP id
 98e67ed59e1d1-39aedeb83e0mr11607901a91.5.1788380228811; 
 Wed, 02 Sep 2026 13:17:08 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 13:17:08 -0700 (PDT)
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
Subject: [PATCH v2 2/11] drm: hdlcd: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:31 +0530
Message-ID: <20260902201640.2024648-3-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a988448 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=zu8Q1U5i7KxegdXecekA:9 a=bFCP_H2QrGi7Okbo017w:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: MQ8q4sKQlBaQMwAFGYr5LQ1Qy1GmqDqx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX038wjpULEM5j
 3d+6vnZZmOctCrvPmci74G5jBDRNCX2MtE4qsdgqI8TamSLThX1RsrdYFDdRcpS9I2ibrMMfzfw
 uQ1fEm4NWf2Cc+bMjNunzFWv0rUguS0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX4zC93bFywuIL
 p6B2VA6gVvOcnEBsJfP9ZEs4NexH/uCPKLKzGTDIEeLleiEwYytHueZaB1XizmP2nRngAdLZ1Sa
 oOlss2AxtJ2RQ2MGkTs4Q67NIm27sBcsR2JHFv2U8N7PrX9kRPO+zYgKbFpRXv3tRtmbJF1tc0Z
 iebC57GKwsppO606JO0+/vI8+i6u/vZDA9Nx7MfDnc6rJKnRbpDesMZPxnZ1W73QG0vWLh7J8zA
 sCO9vaEtXDfgxEiLbhcZOlzb7O/YcHL9WALTzx7exbcRzrZviEwuAnvI91lfZWVaJKYLZUmYvU/
 V3hW4R5o0zsAauDItT0OcBekgQz1QdFOE7f4dJYyfXGUXpFYGtPreNZfz6KkHH6LL13Nu6CPkK/
 jEUHIgDSkPKbvvWxf44CMYOmMhEv8b0ViqL8hTZTvBtspakiw5eeu3AWsr31VSwLeO3YHkICAaQ
 44zu/YG+qtPHDsfLBbg==
X-Proofpoint-ORIG-GUID: MQ8q4sKQlBaQMwAFGYr5LQ1Qy1GmqDqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
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
Remove the three explicit of_reserved_mem_device_release() calls in
the setup_fail error path, the bind error path, and hdlcd_drm_unbind().

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 81d45f2dd6a7..67466fd441d5 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -134,7 +134,7 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 		version & HDLCD_VERSION_MINOR_MASK);
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
@@ -164,8 +164,6 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 irq_fail:
 	drm_crtc_cleanup(&hdlcd->crtc);
 setup_fail:
-	of_reserved_mem_device_release(drm->dev);
-
 	return ret;
 }
 
@@ -316,7 +314,6 @@ static int hdlcd_drm_bind(struct device *dev)
 	of_node_put(hdlcd->crtc.port);
 	hdlcd->crtc.port = NULL;
 	hdlcd_irq_uninstall(hdlcd);
-	of_reserved_mem_device_release(drm->dev);
 err_free:
 	dev_set_drvdata(dev, NULL);
 	return ret;
@@ -338,7 +335,6 @@ static void hdlcd_drm_unbind(struct device *dev)
 	pm_runtime_put(dev);
 	if (pm_runtime_enabled(dev))
 		pm_runtime_disable(dev);
-	of_reserved_mem_device_release(dev);
 	dev_set_drvdata(dev, NULL);
 }
 
-- 
2.55.0

