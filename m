Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA12F433D2
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9A210E798;
	Wed, 15 Apr 2026 23:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p39owSCc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EhqymfKv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC6310E786
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:22:52 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FELjDH2973038
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uKmkX6HdG5E0XhMW9mQBc2MQ7gsubs6yKCHbbKdVCv0=; b=p39owSCcXynLz3bQ
 0sXd2/RZo42YgF4RdkeoB5+bVJ3PHFhmYxYJYrmL6t2MRSnKCo/rGSlP6ZMFJ4Wq
 LsUAeJv6XqrXETI/QujxoW8J9kPmLgs5xoWCjQ+kO9IWKnLqTzPLEHd5TPZUd75I
 BXehNMtw98TF2e5SZcuHaSnRiXT2gq3zk9lWEDIZMPKJBY6R28qx73IYfjDKdA7K
 r8thAcaDUyAuVKzEQGsOP57jdvxX16et6Eyt8jhjGh3LwZcT6VCdewRMT3SUJfPi
 MofNygE6++CzV2U+8HRHdpJBjEABISEt1dZjkP0ATswnidAjP4dKQPUYontB1AOg
 PKlhQA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj74gaxcc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:22:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8d4c2906fdfso820686985a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 16:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776295370; x=1776900170;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uKmkX6HdG5E0XhMW9mQBc2MQ7gsubs6yKCHbbKdVCv0=;
 b=EhqymfKvpwr7B3O67OvjWUPsBPERkI907bwH//GiHg/BDKpRpLc1iw2IaMz+toUoKD
 pGEGO7T8A1tKWpoOnwuS1EAMC+ChPVw0xe4CbB7l4An0HWAdVJ7cy5/hdc3peEmyMluh
 ME0iU/yn52JkjS39bvdpD8DYmw4ybZJibURO+cYDEEOXLHuf6QC8XYFrEY3LNRwRYMI4
 QssfG4nnevc54HZAf2eF+QKlPpxmlL1pJDDxeQX46IENFlhw9MROOAdxCMpWYiJlDtry
 DY7aKEBxsHhL/+RPlZuVFbENUUZfUednR19pjyYcWogrTeUuaPCWngm606zmHQ4x6hvd
 s+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776295370; x=1776900170;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uKmkX6HdG5E0XhMW9mQBc2MQ7gsubs6yKCHbbKdVCv0=;
 b=FatDYpGkUtCGYHp2aJhUAuSQ5LtV75bqdZu1JCNkB6Eb4t/Xetz077J+zNaiEbcmuu
 D0hJvbBs7Y3lmLQ5xe9fKwjaL4MNDhVA8EIrUFtrNc5xdfdeURlDTdZ33j7x+vRHm8yY
 akFx4nAMtrJiWCnNwIUAFlLmqXdNO00B9AtemrrI7gvmrHwaZPVN1w6iRFr08wOG0t1o
 gi4BHDCjmiePvWPtkSuwUDfV8UshrT770MVzAKdse9Cf52i7bDnfqzdMt9SDhhunXx7m
 +6cJ6uUG1WoUyjjb8X5niHBD+bbSkjr6djdAU10PbG17Yvyp61oaAR2zRD6XX4xPiB75
 QRGA==
X-Gm-Message-State: AOJu0YwOq4IqZ/OHLTQZgud/b7WbBF0Ar1ngqko26i3BVb1u2g0/JgnO
 YX3uvUjOuFCLro8Dr/dpaqh4PvVmu++pXNf6afH/RkhPbJbiBksgcS+QY5dqBhDb977nEzsQ5tz
 9BRbrK+x2cMbNTVxRDt875442+eSd/r78CxZ/A5W0FP//2MRMW1MOmEg2cMsD3RduBEv0pXibX+
 OyL74=
X-Gm-Gg: AeBDieuHhvBds3wnxX4vpsdtWC8KVzNrSFK27ssqZf+DIAzRHBDn+lNSkiMov6dBopR
 XzCqjxR6Uw9zOVTUwrJIUi//3ilYtFrLwYHXUpBv5BnD+jdF3lfFYnnEX493wmxF6kU/1Sgh8ss
 p2ItmNqUYWVgl9sMAVIXLWwJCifk/h+DIvXnaKtl6ujjbqyXuYDyA/garcmGqAW7WTqKcMyyFYF
 S8ZiRMDpmXFsDbE3XO5BzIn5Jv3mdGHbug7lMTMZ0BOTs8IJQULM/IBvKe34pF+mla2ekWCZdiY
 hk+T9bFX4tKOHV4mS/6H9s8DhQpe7nE8pg1D6xEQGvzfLSi3alFl6b92UL1/PZCmfXNyTl4mjxE
 KXBK1B7/nzIoEottIpjHwIutMhIrYSnKRXLHJjxEMkj83Lk71Y1gRdyLBqi0iyyskrKcwnpJLZ6
 H265NoapJfAzV3mn8JJGWDhguUfnnzcVi55CJwMUkZwFxrsA==
X-Received: by 2002:a05:622a:2299:b0:4f1:ba0b:90 with SMTP id
 d75a77b69052e-50dd5a91f78mr350845751cf.8.1776295370095; 
 Wed, 15 Apr 2026 16:22:50 -0700 (PDT)
X-Received: by 2002:a05:622a:2299:b0:4f1:ba0b:90 with SMTP id
 d75a77b69052e-50dd5a91f78mr350845381cf.8.1776295369619; 
 Wed, 15 Apr 2026 16:22:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a40a272852sm817054e87.10.2026.04.15.16.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 16:22:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 02:22:35 +0300
Subject: [PATCH 4/6] drm/msm: dp: handle the IRQ_HPD events reported by USB-C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-hpd-irq-events-v1-4-1ab1f1cfb2b2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=858;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HBn2IVrDryFscwmmHLMRDSDtMBdYMWmMptzpyjE6O38=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp4B252fbaBj4KSv5jQsAVOrf3j/7BJx59z+n3I
 2IJBSzoVheJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaeAduQAKCRCLPIo+Aiko
 1WgwB/sEuMF29EEIY8rUMvncti+cVVAyI6rgeZiDtGdvlblf3XLLbOaC9cejNALy1z2TbL7VrWh
 96BGbQvXZrHw8bhWepW+KvH6Ejb7YLEoIpTanNPUNrpqbDTi81/xL+Ym7GTB92LnzaGwYKFozsl
 EGu3ok8Wfu3ICWI1jxGzO576N4RtHf6XrFxeyMxQkoAXIuzMFlfFN/yI7+5rs4bwUXRuhj3uBgI
 aJtwdV+Mh4sT4Xny0ZWfjQKfu2V8F2wrGSAvwLpTVcuT+LTQ2bmX19aFpZSE2qOVk1NtRId069g
 qbZxCfPnkPai+rrXVEEsa0rYtqISVnMD87C00uxhQTT6mlPP
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDIxOSBTYWx0ZWRfX+j+/L3+TsY+4
 gpaTqpP/XlKDhdsv2yhsfcG0c62FO+1a8SfDfcmVFPUNPvP1RpFiSFMTFzIwCA7qgaUWjMG6oSp
 NAuFljj9mfjeKrh91YAInh0d+ZGn++/wmiNUM0OLOEXmoYU6WRuMALshzSNr3RzcHgYT4cRD4OS
 oIA/nViGokVm+8U+swRpLw6CUWF3oav3egHv7CbOo66ITR2BypbssegohROym/I2w7ay8qkxusO
 VoMQtJ9JgWueUhQzW9H491D8aMxhXCpYS6iUZItcA458CcDrBPBttVYEOZcJI9xu68a4RBVtPa/
 sQBBeeXwBb37ZnUiLoAC/KCrBj21yc1D+qkhjypWFqIRUqrveQBarg9hfLPdTYkHclyoW0lrVSv
 gVJV5YlPk+nNr8h3K09y5PmQXMU3vIMC6ozgsLU+btlQcVDWf532H9eC867XEz7StHfOIDiURMe
 aLgrrs3QFvgSKK3outg==
X-Proofpoint-ORIG-GUID: rOXy2KoU-tN5ZW3NQ-8KHwsE9yF98UHU
X-Authority-Analysis: v=2.4 cv=ZIfnX37b c=1 sm=1 tr=0 ts=69e01dcb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=3ML_fINe3tzxlWvVV4AA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: rOXy2KoU-tN5ZW3NQ-8KHwsE9yF98UHU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
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

Let the MSM DisplayPort driver properly track and handle IRQ_HPD
delivered over the OOB events (e.g. from the USB-C AltMode handler).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 45e14a0010c2..390a967a53f0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1800,4 +1800,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
 	else if (msm_dp_display->link_ready && status == connector_status_disconnected)
 		msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
+
+	if (irq_hpd)
+		msm_dp_add_event(dp, EV_IRQ_HPD_INT, 0, 0);
 }

-- 
2.47.3

