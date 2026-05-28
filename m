Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7142CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2CD10ECE0;
	Thu, 28 May 2026 07:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZeFtYDA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VZiMTzfW";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E36B10ECDE
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:10:53 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S79oVc4188409
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=XMdK/Ru2h2Nx7YGhWziv9I
 za1rcjudJfVl0gyxqRxrU=; b=AZeFtYDAycF8dnjuVTdliDrtW8HK848aKjNdjW
 NE2qJXB0V4nF0GCd5diR20Nfza9tzCsRdNuq04uoOi9MdMH628IUV78AgSMtEgs4
 B82PexbXEEPzLHP84AX552QdRht6VOMVNuGNMRejK5qFy+ldfabqo8YwwDS7oWJx
 h8bErGEG7YHJPdQULYn+WumNlzyuBQna37Jinf3ke2weWukO2lWDmKTmj2wbqvlQ
 ijmpIgG1CgW+AGz9oZG9o9lVpJ+EQ2m2B5tAzaOm6/3LD9XwwwBxPxAmUEXcDqaG
 1hWE5RbI9p65BH4z7IeqZN1MlD61b9IJUck+i7xbSHjNdTcg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y2spy1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:10:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-516ccfa109dso130515121cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 00:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779952252; x=1780557052;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XMdK/Ru2h2Nx7YGhWziv9Iza1rcjudJfVl0gyxqRxrU=;
 b=VZiMTzfWrj9UFFA+XPVAU3NzCaQ3euZCY6luOGUQdtjD4Jlk38uvPvgQxmBpaNsqtt
 wlQGoo7XX0X5QHE+VtEMSTfSB2kcBMJSnrGqfWw4NYKjZMushD4N9P3NIA0Z+MdUHKcR
 dQzmcopgdpk1/RGL+eCnG8jEQWum7ulDHxZb1pvI922gJ6nN5p7ZzxPwbgdW3skjw9mv
 Q3d3PAxeyScBsRS1HtXTFqe64Ddc0q8ghxKC1mccoJBOgpIqZVMcAYU5ErF6yzCKiQcy
 nTquxPwehiBIx0DB4HL9IJRnPceIz+NaE1u54KyevPiewf93LH++UzgsGlCPO0omOqBV
 fO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779952252; x=1780557052;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMdK/Ru2h2Nx7YGhWziv9Iza1rcjudJfVl0gyxqRxrU=;
 b=ACX3moYogE9/QMyhA0BMsnXUu6vBg+7mq9AtUzaj6FD73cRchZ3PzK4ApQFnIkDdhH
 LKEqMVFE6bzVmJaeuFuT2BII8rOUrzOSmOoy3Moqd1SQMMxcyeyZTH2NGkQveWZ6RcIr
 OZJAETKgPV1QBERfK1S2LfLtvnm/iBnMCh/+vpLbot07yZPUmGsqx87toXu8M7lJJBTc
 lyotmdAa1RzTP1QQj1lf/N+6vAqwWrObzJjs/A+CmDYK1H/6XqcFYFN+QW07qS2JXbzE
 eC8N2AuzKKFv9MbGhdsv527tpkyOF2FCtAntNsk0yU0NZFo2kQElfMwwuzp1bMfpQEi7
 Z4ew==
X-Gm-Message-State: AOJu0YxJagGmr9REpzohCjoLunT3U4RALTMOSC4lTJ35cAO6qXiREQLh
 Dd9+1FjdMRccMwpftdnIImJ35DjupTXRaZvL//gaNePpeMzPEemzS+I13kah5itL749k1u5qZaz
 O8JORiNanFXVBKLBk/jsbGr+m9gGnE5mdnSeQk/lgN2cBo6Gbl6p07efPYl52PMBrEe85mys=
X-Gm-Gg: Acq92OG/I8FXHSeTTydeD/OTTREm7cHbTt2Wvj969ts/OTFnelf3Ueewzzzs9gYg8bm
 zM96AQbw3sDhPFFj75bsHH6PzF7x2TXobaPQjDzKzqp91Zdkmbn8MURziTXFzugvbwyJjM6jAsg
 vTbdygQhWq2667RKI0+bxffKl1c756NX70QdQqdsnamaOyHkyNVuYMxE0m9o8c2Aq/TVPWPGv49
 PuR6jhzlJT0PWo1u+rQXcvmQFuKILpHYLYts++hck9rdCWRAADIOXXtf6it/mId4AyQKC6GZRoc
 4bAREPIJwPcuaeDXbvWckvP9WTonxpqiUxy06J9DkkhtfOjO6sE3J0z9QJIi8i/daOz7QS7Kqmu
 TdkWQvNYLIWKOdVnSJf/qqOhX6oltSBbCb4qtbxuBkarGZGawehk4nD1jAGjiZBj+M9LMVOfL/R
 TvrplN9ye2ZjD7eas7a696Q9UPJvx0paIjeecM1Nvol9nUMw==
X-Received: by 2002:ac8:7c4c:0:b0:50e:631c:c390 with SMTP id
 d75a77b69052e-516d467ee64mr346325951cf.44.1779952251977; 
 Thu, 28 May 2026 00:10:51 -0700 (PDT)
X-Received: by 2002:ac8:7c4c:0:b0:50e:631c:c390 with SMTP id
 d75a77b69052e-516d467ee64mr346325661cf.44.1779952251521; 
 Thu, 28 May 2026 00:10:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dcc0a54fsm37416161fa.20.2026.05.28.00.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 00:10:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 0/3] drm/bridge: display-connector: detect DP state if
 cable is plugged on boot
Date: Thu, 28 May 2026 10:10:47 +0300
Message-Id: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHfqF2oC/33NQQ7CIBAF0Ks0rKUBSsG68h7GRTsdLImFCko0T
 e8u7cZN42aSP/nzZiYRg8VITsVMAiYbrXc5VIeCwNC6G1Lb50wEE4pVXNJ+ouCdQ3j6QIepp4a
 pBpXqQLWG5LMpoLHvjbxccx5szNXP9iHxdfsHS5wyqo+KSQnYA9dnH2P5eLV38ONY5kFWM4mfU
 /NqxxHZkcLoWncGOtPsOMuyfAHF1AJC/wAAAA==
X-Change-ID: 20260314-dp-connector-hpd-f069e66bc6af
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ih484UDYen/63hBw52928pSd7WX7ladARNVDTpU8cOs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqF+p5QotsYRMq7tM8hJnVqJEGEsJvK1QOeVwuW
 5iiaa9NS5iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahfqeQAKCRCLPIo+Aiko
 1V4FB/0YfR25fz6X+7K8+iXES/ZScHpyS1rvF8GggNhCyt+N1F5csWFefMIqumtV3Zejq9ZjFTz
 9WcMP73LnEQ6X1IEn7QRP22UPffM+6QMwzSyf/9WkbqZm/MDZ+INOSEDtf12OBENwMuOOL/9GNF
 ROl6QWsMIZ314EOeSZbA+RxJXa/GvP8xK1pF2OXSSpXe+HPySbQVwlj59pz7CqBzhov6Pz4OHK5
 SoMSQAin6Zz4uJgzOmEqZmww5aSa4l7Hp36AvyCynK5W5wyz6SpwpwM1Xb8Q7aBm7JwnPvDjJMQ
 Xu5TObQEW5RNoUumd7xst9T/Uc/CQvUI3czKLLdVY1mCX5wW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=VeXH+lp9 c=1 sm=1 tr=0 ts=6a17ea7c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=QdDM1--rjLhOk84JmKIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA2OSBTYWx0ZWRfXzFVDpP8Bu3Ib
 A12MRDM2f/b85yXne5HLuglA/D4ki3VFQ6tssdV9pzABYaH9b+yOLDiq5Vm45Z7xfqodpiwdTOx
 0IBgJluyYjxx5avt0LmfN75KOUjDFUjY4rW+2u8rfPuzvT3Lri8Cqpa5e7TP12UFPcEdniWkRsV
 bhdWTx08gDNA+OHWjT7tT+F9UDP5/duviwYtBV+2YRbyhRW6BO/N5zh0VSjKjM57pj/PzKrr9bZ
 x7AMHRrSRLWbL/p8+oxPXiGu7aPahuRkW5v45tmHlSq/H/Bw6wPXci7+FWZ7jSzkutzvvIpYb3G
 RZYjvg0fEK4B5gKCcPqTf4a1+I1bD+8qbeiPApPJoqKouIoFxI1Of30wRUpBW3Mzpkaeq0bjc1H
 V1mi/UArkIIok8qxOPZlAAl51bttY6HPpavdcFo7/NlxKpVHuJvPBaS6mRHA4joqO4egTDQhq9N
 kZAJfI6oJkSTCsXl4Iw==
X-Proofpoint-GUID: jxONR5joxtPQ6b4vp6qUXNHd4vFegO8o
X-Proofpoint-ORIG-GUID: jxONR5joxtPQ6b4vp6qUXNHd4vFegO8o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280069
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

Unlike the USB-C AltMode handling and unlike the DP controller handling
the HPD on its own, if the display-connector is being used to handle the
HPD pin, DP controller might not be able to get either the HPD
notification nor detect the cable state if the cable is plugged in
before the system has booted.

Make the display-connector send the HPD notifications during system
startup for DisplayPort connectors.

It's typically not a problem for other types of display connectors since
there is no special procedure to detect if the monitor is actually
plugged in or not.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v3:
- Corrected typos in the commit message (Sashiko)
- Reworked HPD-related bridge locking to remove AB-BA deadlock (Jonas,
  Sashiko)
- Link to v2: https://patch.msgid.link/20260513-dp-connector-hpd-v2-0-42f757bfcbf9@oss.qualcomm.com

Changes in v2:
- Expanded commit message, explaining difference from HDMI (Laurent)
- Link to v1: https://lore.kernel.org/r/20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com

---
Dmitry Baryshkov (3):
      drm/bridge: split hpd_mutex into two mutexes
      drm/bridge: display-connector: don't autoenable HPD IRQ
      drm/bridge: display-connector: trigger initial HPD event for DP

 drivers/gpu/drm/bridge/display-connector.c | 36 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_bridge.c               | 16 ++++++++++---
 include/drm/drm_bridge.h                   |  4 ++++
 3 files changed, 53 insertions(+), 3 deletions(-)
---
base-commit: 687da68900cd1a46549f7d9430c7d40346cb86a0
change-id: 20260314-dp-connector-hpd-f069e66bc6af

Best regards,
--  
With best wishes
Dmitry

