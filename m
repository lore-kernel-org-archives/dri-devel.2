Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818CDCD4F41
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677FB10F00B;
	Wed, 13 May 2026 18:24:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="adOOFUnq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pv5tm7uM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE1C10EFE9
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:24:04 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DGAq7d2524309
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MbKgvVuxEIwEzMcmEacPjVXRL9Yz3CCmKCNgvBxdDkI=; b=adOOFUnqD/cK+eQt
 lzJ7pMMU0fq91KwakaSBkYOagBIE6/8cH83nWlAgh3JSK+ZkPY4lAYueqom0Oa9f
 wc0pEl0e0UaS0c+Kynn1xjQhLjmV7cdGToDW1gWuSiqaiuWP4AmvLFddcO31vAPI
 WxptBTOrewx+2AHw1RuIc5ZHyq9RjarZWhCQo7wYpRN/X2Jy3TUYWOAnur1+AhRP
 8/4VE+NdttnJicMKGweDNaMHGF0o0bkdvpC0g0eExp34w0X2Tt7qclAjhSXjw2ih
 g1GEQyi5cDWpRFm3VROExFq1gsIisJCw1lhQn4ZCAxW+/hJapsL2ANbARxN8JZyS
 XyYgDA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjghh1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:24:03 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-95cfe3d4c16so10952945241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778696643; x=1779301443;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MbKgvVuxEIwEzMcmEacPjVXRL9Yz3CCmKCNgvBxdDkI=;
 b=Pv5tm7uMCAoNtCg08xpEP0AwqTIoEEUbaXkdn7mVoQteH13cYl358K44M6jBC68bAg
 vfCM3mnmDa5cltUP5DRcJ3i2OCEGAYffb2JLKQzKHON96HGj832Ore6zGDRDqr+gMByp
 aSn/VYIV9AgjOdukM6UjpeI3s79oOH8dMsZdaWCwM9QJ75gkIHR3lNi1zFOOFb1K0zjL
 fXE6cW+Lxsydd1AptZ29mkH8YzgNqUDWFbCrH0aF4yFA5UbM+Mlyr12eGc6vMxEmKrmT
 Uu8V9MqJ1GRGbhwI5M8iBb33HYZTb41ljaNusE/6L7CyI2JrBdZjoamx0pjcnq+WppWW
 AmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696643; x=1779301443;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MbKgvVuxEIwEzMcmEacPjVXRL9Yz3CCmKCNgvBxdDkI=;
 b=RNs11c9LfJAw8nglxHxmplubwEWGv1WfnfRRImuPfQAwDfa6Z1+9SlM6FJ3O0GaDq2
 XYGCIiPcMWeSSHjs2ZY2A/UnHKLjQDLVS6qneRqomVcH5nbkI6Dm3oOoAwTHA4OE3wzA
 G8RuspoSuzg/nYbpDkhP8CAfDagwlPyInwev79ChzpVE0O9o+pqwITybUkHmPEE4DqOS
 rmLq7CkYrz1HwYQORckotLJP4jr8pYfLdshdRz8gxEiyUyjjI9mOTY0JoXpNgCAgXKZP
 bt+5jc12aPp2wZ1GEosr8oozFfVYW8wcsX2mrqq6Quv+pHhylkcxQRXZZVN8USc7VkGk
 cZ4g==
X-Gm-Message-State: AOJu0YxNSEbjlVkDSTJ/MZMREgYjOg2XE6nXlE4YqsGJKLkU/VC17xCJ
 /k/2VzHVZM5fQqu/hG9IsREx56PFgKLIZQGE56lRfPm34BshKFGMQmxX3DP65gFPIXdPW84C1F9
 NZe6oX3zgjt0f0EGQVnfysDyU6IztcdlcVVwszfUMXpHsERxw684CulUskIlAa0n3BvnwplM=
X-Gm-Gg: Acq92OEAdnqrk3ttGiOj2tDIplbmQxyftaINOac1jaDKyeGyI2RoFEWy7Bxr2H1FbDu
 RyLL0jHFFLY+30rAF8pyWZHKxbuZ3oPnizVjBAz2LXgmiR+7tLnJNf36yXC03m9jlI3SPIwFyif
 7VKF0KtQaMEYyRp2N6BkHULxuJoA6LgBxo4/5Wsyc9QC5yIQYS3HY/Kn8gX+TINDmiRsju1LZO/
 k+9HAdT6A3J3ktuUFpB4PsEoBhcBBIHKbUQmlMAHfDDw+qG4tY2Yz9bVeeTt52ZXyVcaLrhW0rf
 Ersp8MBdHx9GSt38EE7ugFKvD1tKzs5PymHtnttUFZn0EBAY3yWxMyfeZ1BfcK2bi6x0MHJplnn
 p/chvl7f8w8qnd390+YetPimgu1qjIllKls3XRLeYFJI7xp1SXEcUT8oChMAIQEl1PqUb8cMI2Z
 eA8k9N3HzjOoqEm3vROTY5cVPvMJiZEBOk7P0=
X-Received: by 2002:a05:6102:2927:b0:62f:31d9:7bf with SMTP id
 ada2fe7eead31-637754eace2mr2861794137.17.1778696642556; 
 Wed, 13 May 2026 11:24:02 -0700 (PDT)
X-Received: by 2002:a05:6102:2927:b0:62f:31d9:7bf with SMTP id
 ada2fe7eead31-637754eace2mr2861750137.17.1778696642033; 
 Wed, 13 May 2026 11:24:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a951d1f6sm4212851e87.23.2026.05.13.11.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:24:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 13 May 2026 21:23:25 +0300
Subject: [PATCH RESEND v3 5/6] soc: qcom: pmic-glink-altmode: pass down
 HPD_IRQ events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-hpd-irq-events-v3-5-086857017f16@oss.qualcomm.com>
References: <20260513-hpd-irq-events-v3-0-086857017f16@oss.qualcomm.com>
In-Reply-To: <20260513-hpd-irq-events-v3-0-086857017f16@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=g2eHBnhqeprT5L86a/SxcLn20kIiQiAhlBDTRdUq0LE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqBMG0drlwCbTuEWcWCuHk7pQDuuarVA3oztNqH
 T7Bd2hVw3KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagTBtAAKCRCLPIo+Aiko
 1RL7B/4jgrhGIEZynL+WT5KesqjMHxOK4WlzF0fcjJVPHChMLdUytHaxmufdMqTgSy0mcUbDBn9
 6q+vvyQ6qYt0ElA3eZFhzZswAyCgcR8e4VTK8o8hpdhNHHqN0OnWTYPFN2SHs8+2VNdnQpl3rl6
 nMO0qA5XZZ0N0MW59OPPIDbL7bNNmFqUKmIe2WCRfvquF0In8ReMbRiQJj7LkMVsU4X/WUHvw1c
 D8V8E3vb27NV4op4UtcX7LQjtY/tpC3kuvEBz1k0eDC+LlEa/A9pzrNHGsDflhVd9anRh7OF2dP
 6y+RL8SzW1ovqNGn+6AgKDUbs46tJjRUUkfsmEfNEOEnsmEN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: IHykhn0uw6wNSRuMWeByA5h0izhfmVIu
X-Proofpoint-ORIG-GUID: IHykhn0uw6wNSRuMWeByA5h0izhfmVIu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4MyBTYWx0ZWRfXz05il0tl4vk7
 1WjM4ee05UF80aNHqt7R5lX5cDPAaqK5VhhL3AzAyv3V2of/rCtYg+4wF5KptOyF1oVNzNKy51Q
 GWk72dM69KwQ/2QNACcqMJAkkOPgHOdKkmI1IuZ3nakNYEjs4iZt3aoIzJJHgR87sjeQjq4ErLW
 J3EU8mYmhZbSwXSnJAL+tBsMLJmTiVUhiIlHffqHa7fwyHKOhJnKuFi6jK7nIDkzCGOQhwa0Kka
 h4lAyOP0Efydlaus15U3VLrX9N5b8ydHE9VJd47JE8ADM0esojLHEduLAA1LsN25u0MYue/Uc/H
 iVoILLiPBtGtpyL8sgCVDnepklcEetlASSrGCR/JMWXTJ0AP66uqf36Ua9XQw8+OzNZkPOpVkbO
 byn1IZXQd4tYSZzom62KD29EK7z6Jx/0hVMW3Pl4SurAbG1VY6EXSbdr/mBHNn571wcTYR2JhN/
 92KCqAIhBTWendojRdw==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04c1c3 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=QzDdqdBtNhq9Kz3vvWgA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130183
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
 drivers/soc/qcom/pmic_glink_altmode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 619bad2c27ee..946eb20b8f83 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -373,7 +373,11 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
 		else
 			conn_status = connector_status_disconnected;
 
-		drm_aux_hpd_bridge_notify(&alt_port->bridge->dev, conn_status);
+		drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
+						conn_status,
+						alt_port->hpd_irq ?
+						DRM_CONNECTOR_DP_IRQ_HPD :
+						DRM_CONNECTOR_NO_EXTRA_STATUS);
 	} else if (alt_port->mux_ctrl == MUX_CTRL_STATE_TUNNELING) {
 		if (alt_port->svid == USB_TYPEC_TBT_SID)
 			pmic_glink_altmode_enable_tbt(altmode, alt_port);

-- 
2.47.3

