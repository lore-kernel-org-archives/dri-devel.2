Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590BDCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB09B10ECE1;
	Thu, 28 May 2026 07:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MBQpi9Xj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S0OKDnMX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D0B910ECDE
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:10:55 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKmqQ71638534
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z4WR6er5Of2+cYSqZtXfmLTmM3uBh8TuLkr2F/P1cso=; b=MBQpi9XjJL5i/Sh7
 DlRy4uBomLJLCvH38w9I3bOuYEI8S+R4WpMIB42ynTP1a5O6BSfZlkhJZcJSv8Ev
 71spqNLw8Iuj5Uk6D5quNFE1vbwP51vKStWFRXudDAfWBi3NdteXZzB23n9u3cUp
 nT4cPnN0WyAos4j9TPk3kbL70EzA9rlfUCyLZL0q9HY//Oj1m6sbWWqhBuvTI1e5
 jczzRJzmieSfTEBQAXZTQtbLibE8+v2R8RDN4qw+TvgbLIukXsh8o6edBLSEw/i6
 7L9e+wDjMC1yFeVViD9XOGjl+Cj8QhfclBJyM8UGpy9W0Ox2ax0TcbFqT90OBMFk
 OlNAjA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynhqtm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:10:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50fb3403e99so82475441cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 00:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779952253; x=1780557053;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z4WR6er5Of2+cYSqZtXfmLTmM3uBh8TuLkr2F/P1cso=;
 b=S0OKDnMX8S4A/JEImH/2sGmiy4VvBHMmSVEtvFLe6B020qjsql3N8p32KlNTmdpt8D
 VLYNxYTraEnU2TZY4N+zwC/+RrjxQPuVRksGtyCpERP43SnC4r2QNPreWNuRxCaaIVLw
 HD64jzhHcyN6Nf4LHILylBhYnDH5zS2pO32KRuIDBz3uVegsb8mm845IJWsrhNTVq40V
 yL50J5rUHKeoQHK+qObctgOd6Ay6HA5i1IRsSOJbLSIBrekkoq2vrT/1hD19LhWhuX5o
 nkId4PU2Je5sOXDBYVqWswez2uBFSsVbTdZbAUi5im4FTQMP5Apl4uOJM8XPQh1vjlY0
 QbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779952253; x=1780557053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z4WR6er5Of2+cYSqZtXfmLTmM3uBh8TuLkr2F/P1cso=;
 b=lq+LkPgUP8khrTsC11tnRgMJqgG2SHVMmqRrFUbDr/9AIzxAOhr864o3TW0tzePZWy
 IH/ccx1/63wvJwXWLkY5YNyAX4SFAV3LUMX09wczm9TLeqFImXOLVJUxI/zTZd5eFb3i
 ugwQWP5C4NXkWsVHNek9MkidON2QSxWd8ujoPc9M1/dj0XQRHHdgNxyT50IPZwX7Dgjj
 iKk97kSWyYrxSqvHo/K13PuRkaF01iOZ0dwd4WNAHWbjByL2EgjP/K/1GK/c3GIncM/e
 cTKhuudbHebL+9z/QLl+SjO77SntiCPHQrCPAvR51AUqFd4HxDv6CeH4tH6vUfYpBaq8
 emag==
X-Gm-Message-State: AOJu0Yw1k2d0CjF6ITVowfykkyaviMYCcfZ0bYYnuqSSuLHfKB9kBMnm
 xVFAfyEZ2YO7grFqhJIScVUsNjeUxTT/wrXLNppvtFQB/vruiFAplXpaSC5ee3puqbR/gHPX8ty
 thez42UBreTvQOtD55cUanmrnntEXRdNGc0BN+FZSEuT1XvNLq5istSHL8njgkxePBQs74Nk=
X-Gm-Gg: Acq92OGo5DvSaPZsmPbpSgFe3aX/TBD5KwwBWTmVD5mIEE/EJTmZT4uOUk98olUDgDq
 cQa4kF1nYEKiThIVvDbyGXmoCgcyXBLqQ5CYIcJ7rD7IqQE1wwRouifQ9UiCGrzgq6+BosQc8Eb
 VwVKiPPBAdxeQlrRGHLm57Ig/gYki+j2ZGQHHNmfiCql8LWFcNvcu5Vw7oDxrjE9hG0QKdMW9DL
 XPlnoQ9WFyKKCPQuPfiybDIotbpEi48+bksgs+UrTAzsOqfkSCJWd3RkZxHrx4DpSkNWvcC2YEp
 myIHeBXwvinALGMhD2hfsg5aNSRG1D+LzasHTyUnIVqvywP2xnCf6CVMhMQswWLwqBWUXZH8k4o
 sD4UfYlreGQOMjq+aGwHneNBP64XP8+A60O08aLO0XcdmyX6YHzo6RP7F9BrfCu55rEkAvvxNRE
 3Iio+K/L59BmbU54mJgPpQCqvrpKFsi+ZLND1LqIlpW720Ww==
X-Received: by 2002:a05:622a:4887:b0:516:e033:f5ae with SMTP id
 d75a77b69052e-516e033f8cemr321262431cf.44.1779952253574; 
 Thu, 28 May 2026 00:10:53 -0700 (PDT)
X-Received: by 2002:a05:622a:4887:b0:516:e033:f5ae with SMTP id
 d75a77b69052e-516e033f8cemr321262171cf.44.1779952253158; 
 Thu, 28 May 2026 00:10:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dcc0a54fsm37416161fa.20.2026.05.28.00.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 00:10:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 28 May 2026 10:10:48 +0300
Subject: [PATCH v3 1/3] drm/bridge: split hpd_mutex into two mutexes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp-connector-hpd-v3-1-d656eb1079b7@oss.qualcomm.com>
References: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
In-Reply-To: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3574;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=phX0hoWrp4DgbArchKl0E80WtBWi5e+YAzu85nwWVGM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqF+p5IJ+rnEcMiFWwgBOxHfygnrnynCeaYG3Mr
 zSc4VYPIB6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahfqeQAKCRCLPIo+Aiko
 1cM5B/4kBpZwfdyjUejj1x1kNZzAO6PqH6cI4EpA/WLFkKgdvJipSUyL+6eLSW51xBKjFndorDX
 O4b0moLZ2v4VgzEMUppDl4UUsoqhE8+XoIMJ71CPiEBz2rSfug2Mj5ljJv72CoPh9pYgb8P5Vdl
 3Xz7G6t8ACnzfSkBj1tpeqc75xZ3ESISh72Pks+XmEH0+FQthTSgGKAhs8OELrJMGjhn+Cup1q8
 nEpKOH9n6PL+uqUWHYN5pYmqWF3gYN1XvpaH3ol65wojWIBuuAlJLwVOkNqmWNIi3T/WlHcLZ3C
 4+O9dd0lmzq/97lYHye6RfAUDOH1azKM/D+YC/PQFqyFmxR2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA2OSBTYWx0ZWRfXxF7dq1kb91i3
 bniyAYdSZ0D2QwMS4i+LJy5Fs0assgR08j1mT+ceO4lqvpUm6LWB7dbJH8ZSq7mBxbNZ7/pMO18
 Rj1SgTlCixFofebpLZpnBuK+TQt1jX8SfLKKs7l7ign4y/seRnP2q2KzE/0OAf8BDHh85zDLhOy
 ldn5n78BaYTeyWUCPHHRdXSemfH6LelzaUo3DRmqPnqGLOMx6p9/su7WgK9E5a1wucP8MYvES8V
 AWveFLtA/FbV3UN+wMkJ7sBuDiDQkAk2CZ0Wd78tuImpPXjHfmGJQgIr/zn2gyadMVfZptiY4hv
 BXokCl9fMhYaWHw2/+nMsyS3kp9Pnn3jtEqhQa0Jh4BAxwsd0M1t3nPmbzmFXHgvnYXaXiVIFNr
 GJ0GcXe02sN5cGpmlrBuroNnM4YTYqCFP9Nm7zREIxsSGp/vgDVjkXEx60Pu0OP5C6edA+3RO4v
 oXPC8ZBZa14Zmlew+Tw==
X-Proofpoint-ORIG-GUID: LyCO-0raoYMet2RE_duKXe4G3vVhSCQ5
X-Proofpoint-GUID: LyCO-0raoYMet2RE_duKXe4G3vVhSCQ5
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a17ea7e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=TrWYt3Gvp2KaBVO9iIIA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
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

Currently almost all bridge drivers which implement hpd_enable /
hpd_disable callbacks simply toggle the hardware registers generating
the interrupt. However, as pointed out by Jonas Karlman and Sashiko bot,
using those callbacks for enable_irq() / disable_irq() calls or
scheduling and cancelling the work can cause a AB-BA deadlock (between
hpd_mutex lock and the corresponding lock).

Split the hpd_mutex into two locks: one simply making sure that hpd_cb /
hpd_data are consistent and another one, hpd_state_mutex, making sure
that concurrent drm_bridge_hpd_enable() / drm_bridge_hpd_disable() calls
can't end up with inconsistency between hpd_cb/_data and bridge's
internal state.

Link: https://lore.kernel.org/dri-devel/9aa4bd35-bff6-4009-a959-ce31010c7b35@kwiboo.se
Link: https://sashiko.dev/#/patchset/20260513-dp-connector-hpd-v2-0-42f757bfcbf9%40oss.qualcomm.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_bridge.c | 16 +++++++++++++---
 include/drm/drm_bridge.h     |  4 ++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 687b36eea0c7..9a185032a3bd 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -417,6 +417,7 @@ void drm_bridge_add(struct drm_bridge *bridge)
 	if (!list_empty(&bridge->list))
 		list_del_init(&bridge->list);
 
+	mutex_init(&bridge->hpd_state_mutex);
 	mutex_init(&bridge->hpd_mutex);
 
 	if (bridge->ops & DRM_BRIDGE_OP_HDMI)
@@ -469,6 +470,7 @@ void drm_bridge_remove(struct drm_bridge *bridge)
 	mutex_unlock(&bridge_lock);
 
 	mutex_destroy(&bridge->hpd_mutex);
+	mutex_destroy(&bridge->hpd_state_mutex);
 
 	drm_bridge_put(bridge);
 }
@@ -1451,19 +1453,25 @@ void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 	if (!(bridge->ops & DRM_BRIDGE_OP_HPD))
 		return;
 
+	mutex_lock(&bridge->hpd_state_mutex);
+
 	mutex_lock(&bridge->hpd_mutex);
 
-	if (WARN(bridge->hpd_cb, "Hot plug detection already enabled\n"))
+	if (WARN(bridge->hpd_cb, "Hot plug detection already enabled\n")) {
+		mutex_unlock(&bridge->hpd_mutex);
 		goto unlock;
+	}
 
 	bridge->hpd_cb = cb;
 	bridge->hpd_data = data;
 
+	mutex_unlock(&bridge->hpd_mutex);
+
 	if (bridge->funcs->hpd_enable)
 		bridge->funcs->hpd_enable(bridge);
 
 unlock:
-	mutex_unlock(&bridge->hpd_mutex);
+	mutex_unlock(&bridge->hpd_state_mutex);
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_enable);
 
@@ -1484,13 +1492,15 @@ void drm_bridge_hpd_disable(struct drm_bridge *bridge)
 	if (!(bridge->ops & DRM_BRIDGE_OP_HPD))
 		return;
 
-	mutex_lock(&bridge->hpd_mutex);
+	mutex_lock(&bridge->hpd_state_mutex);
 	if (bridge->funcs->hpd_disable)
 		bridge->funcs->hpd_disable(bridge);
 
+	mutex_lock(&bridge->hpd_mutex);
 	bridge->hpd_cb = NULL;
 	bridge->hpd_data = NULL;
 	mutex_unlock(&bridge->hpd_mutex);
+	mutex_unlock(&bridge->hpd_state_mutex);
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_disable);
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 4ba3a5deef9a..00a95f927e34 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1256,6 +1256,10 @@ struct drm_bridge {
 	 * @hpd_mutex: Protects the @hpd_cb and @hpd_data fields.
 	 */
 	struct mutex hpd_mutex;
+	/**
+	 * @hpd_state_mutex: Protects the HPD en/disablement state for the bridge.
+	 */
+	struct mutex hpd_state_mutex;
 	/**
 	 * @hpd_cb: Hot plug detection callback, registered with
 	 * drm_bridge_hpd_enable().

-- 
2.47.3

