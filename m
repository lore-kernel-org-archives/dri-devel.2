Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AC5F433D3
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C283D10E7AE;
	Wed, 15 Apr 2026 23:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bPaBuvxP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I/+SvFNC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B4210E7AA
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:22:58 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FFQDCk1702344
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1TlTaPnDMsSjHelLBIYtNHmZZl9OCynI6YeLwhyIsxc=; b=bPaBuvxP/CTH3RFI
 DdDJB18yMTWJ5vbg2oW6dD6oPcLf8r3baGiH1RKX22NwrNJkhXudtwy2w14nHIQc
 IW+xHLBl+PAblH0/sNsPEZUK3kZWi5Pa0jb/bWtjdPNX9DMi/5zOm7YbUXklHcp0
 HczNEKwrvkLFURo9haQXFouBjQAq8h8/xqv7A+6cA7GX9GnnI1LL0tfqMvZrHe1A
 wir+iwaHENGIdo4dJisSlMUiu4F0H+twDs35X1K4H5NrOHhejFXbuooaVoXVXdTh
 +hjYzWVu1ocq7rUQIvj+O43EjHzj6Hslfljy3f/eYQuGCzyQnybAekIe/hwVP2QD
 xkgxlw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djdamhd27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:22:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so148224361cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 16:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776295377; x=1776900177;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1TlTaPnDMsSjHelLBIYtNHmZZl9OCynI6YeLwhyIsxc=;
 b=I/+SvFNCDLlE5FdZYxdGfm1jn2vQKGrq/FOMewMQhQXLuqLVbEiWgtrwhumodN3sEf
 JVNg/NRdwPT+nKoV9Kc52sL9/m3XZQOkxN3xqbFc2VGQvEzCVHziglnXi8Sr2CkU3alq
 Plx7PnbvVTPLAS6uRWw6J/ojb79CuNHnkfL1B0EwRWNPvrjU84dC+8PAQpb0m3LtDGPK
 cfiZmFyp6c2jYKwuKRVgC2moSTsAqLJzjAAcKDpA/7B9R62DS+Js5nPKWvKVx+Zk00rk
 igMcXUFRqyOb2EWQ5HlK81fYNSxyp+UmukKLDfDTnRXj0aR9df3Guc9u7NddMnCeQnfn
 W2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776295377; x=1776900177;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1TlTaPnDMsSjHelLBIYtNHmZZl9OCynI6YeLwhyIsxc=;
 b=gJ/rVqP9GL4mNF/M0MQgSF+Pgi5skDO7aYkZqyya+hHV/cFjnVo371/FUlzdXWFzSf
 GLTW/QeU+y0A5Cm1VhXF5oAR6EhNUoQBB0nyr5U5ROA8fG6ydIHTBqFznUX9Y7AM2Cr8
 MGg8J9iTmJ+KohZxrJgbfC20/XepsAleB0X31iJDItvqQB7XJYwgt9igyW7wyOO/jPXL
 LNjbI0CdmC4Idi8Ln6vTM1n9QSJUW5Xl+UXUzf8HJ6ksYWZgXOHCog0iPJTmNd+hTIk3
 53jX+AckzPk6hfyT+DWwMnoV93odOfGXm2ExDV2OmSG40ynXgEGdcKiGWDdy5hp/hPr8
 qhIA==
X-Gm-Message-State: AOJu0YyQkWtOYgJhQUqnN+m3u1gDjkhi4XYIomqjolPSmDEHgsmCKjcG
 qEuzu7uFcJpkC79P5MqmmV4llwStCa70BrDx5xnQZeQOb6UBERXzgIAJYrc3GsMrcqCptYclPVC
 TEkdIztA+t9A7UKrmvaqGdS3fXOQoONa4t/SMl/VT8SFTTAGYveegWreqY6RM/hWQYyzghICOZ4
 OErp8=
X-Gm-Gg: AeBDieu45S9PTRbPBFBdnfSb/Dpmd8gaxZucUdWzacp/A38xZL5tYnJMnpLMmcVFPjQ
 s7e95hrmuIcqD5bffv3h2/RkOLCn+oGi+wL2w4ZVq3kwcnAy0TvGGt9CHNHUA8AP9tcKphuwP7e
 pT4m1E5VKDj/saHaJKzgg0t5+b0WwfBiqwp/m89RJgEpws9/Om3Y+ek24jcGb2NUesO9Wu0H2NK
 XIuaK70TObwfp803sqEo1wPBwEue+qEt7jsJ4f27FOFVt6KNw5y3M/jHbyRFPa5Sicc1g++LN2C
 hd+YyNjUwMc5E7qDHbDo6KXKAQ9AjI1YhkbMfQJ9Sz5RUmi4IqKJB5WynWPs/7rxx1XcMP+n7Em
 l+QtRD1o3lm3U93gjdnPOLYdywaUpQLJ/gT5yrO4u293kR9svbbgZJhXVRYO4jIiPD8t3z1AnMa
 RNsqLtvWW0m56onKRF6S62F8tqHLhvf30S6BnR+MBP32GRAA==
X-Received: by 2002:a05:622a:13c9:b0:509:1590:f5b3 with SMTP id
 d75a77b69052e-50dd5bcdc20mr342487981cf.35.1776295376967; 
 Wed, 15 Apr 2026 16:22:56 -0700 (PDT)
X-Received: by 2002:a05:622a:13c9:b0:509:1590:f5b3 with SMTP id
 d75a77b69052e-50dd5bcdc20mr342487371cf.35.1776295376486; 
 Wed, 15 Apr 2026 16:22:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a40a272852sm817054e87.10.2026.04.15.16.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 16:22:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 02:22:37 +0300
Subject: [PATCH 6/6] usb: typec: ucsi: huawei-gaokun: pass down HPD_IRQ events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-hpd-irq-events-v1-6-1ab1f1cfb2b2@oss.qualcomm.com>
References: <20260416-hpd-irq-events-v1-0-1ab1f1cfb2b2@oss.qualcomm.com>
In-Reply-To: <20260416-hpd-irq-events-v1-0-1ab1f1cfb2b2@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=SEN/GR0hrR1a9DBG9m1Xo1QGkgnSMHduOhSuiYVFnL8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp4B269bBlbJtFKVMj9cfKSjxyfAMo/avZojzn9
 1S4hJysf3GJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaeAdugAKCRCLPIo+Aiko
 1WirCACLulVg6ZpKOCltCebHzmh/eMf3t3bLRta2jkwQIXM8sIkvuLAXeTER8cd0ZDj5c+cGKqt
 mUZIMEpnhLP5RxelE1DCRtytDCjOETI4dg6Pehe9ONh0k8ZP94zzn2aZZgG1tNW1iqFGdHkTLSX
 +Q183rOGj4kJV8ubUk9o/0bRMn1QgmeITH9IJBYHAiKFDogK2LrgZigISt4W7j2RyjDn7rP6CMZ
 2eB2RZhtQHZG9yfT1RptN+ZXG68VayMJq7tV44jasBlZP0lR5KPlwE14F+15fCMJ6GRO4YmuwW+
 PDBdXKXcOpw3cco8JkjI2YgI3hWMdCYFYFYelO5aQ09670Q6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: nwP2wY1xa7S4IffHsJ3PasUUTyt7XW_6
X-Authority-Analysis: v=2.4 cv=HMjz0Itv c=1 sm=1 tr=0 ts=69e01dd1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=QzDdqdBtNhq9Kz3vvWgA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: nwP2wY1xa7S4IffHsJ3PasUUTyt7XW_6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDIxOSBTYWx0ZWRfX1qRftL0ss/uW
 HQlO8vSkFxEMrY70z4wbl71zS5E3AitzXc69ZlEGpfl2TKJ1v/JpQxhWKgf+2OtL6yLC1ZnzuVi
 uKUmDfChQWwnrxItcqPg4h419fD5UqjhHYxNpFpHSEfSvUO7mysYCDTtH3082W0EQNRqpvenrGV
 UGHl69H6QI41rffnmNnocqBVq6ZUF9bpgA2e+xUcIONJtCPaABsLUrCc1BywLC6EEbWTxAcnwJk
 msB4hBwP8kp9VFgSId0ZzAfRhwFIiS1JXUzaChhOzDdz6EKqXwoXpWddb5Fa5kceGafnroxqYVj
 XLEJhOsXRkDwFzvnzJkfHmMdN+/OsYyiAgWHUjGTl6fz4mgn2VZcXfXPNcvh/nLII0kbjbuzgyf
 Sr47Me58xEAzp8yvDP8kbFG3LMjkqC7VwzwZbRIk6y9LjtGKy757UtclWjLB5o1/+7FEbRljebu
 09zSryfMqEgh9u3X4NQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150219
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

Pass IRQ_HPD events to the HPD bridge, letting those to be delivered to
the DisplayPort driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
index ca749fde49bd..328ba92e1b44 100644
--- a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
+++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
@@ -299,10 +299,11 @@ static void gaokun_ucsi_handle_altmode(struct gaokun_ucsi_port *port)
 
 	/* UCSI callback .connector_status() have set orientation */
 	if (port->bridge)
-		drm_aux_hpd_bridge_notify(&port->bridge->dev,
-					  port->hpd_state ?
-					  connector_status_connected :
-					  connector_status_disconnected);
+		drm_aux_hpd_bridge_notify_with_irq(&port->bridge->dev,
+						   port->hpd_state ?
+						   connector_status_connected :
+						   connector_status_disconnected,
+						   port->hpd_irq);
 
 	gaokun_ec_ucsi_pan_ack(uec->ec, port->idx);
 }

-- 
2.47.3

