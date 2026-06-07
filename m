Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F02CCD8C9F
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C9F310E5BE;
	Sun,  7 Jun 2026 21:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WHdctld3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BQ7RH9nj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C75210E14A
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:33:15 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657Katsm1584397
 for <dri-devel@lists.freedesktop.org>; Sun, 7 Jun 2026 21:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nPk71TxUUS622Q42M+kOUQRMtPhEpU+4iMVusC4zd94=; b=WHdctld3N1fGm8EG
 mZ77MjfOxyfU5m6Xxu/TTYA61rf26sZ6xM8Wse22MDmtlbt4BlCk0DseZXo+ARvb
 AVN9QYUlNv+efr3KVnJ4tSnx0u2+19cMHTTewq+VRDVd3BDxT5ih7SD1s6agtQZZ
 96tkNd/f/LCBEJrkBDDCPz9j+n6kde5hd70Zjql90Y+zBBjzGZrAjywmcgoNp6RF
 8gFykOT980t+QyTtonKFzOS4G35hEK5x8QWf7jKdGWOsNKL6AtFdTvRg56NXMzpy
 e6J45vR5d1w/Juqmwq7KZyD8KKA2/YbyEdM8OsZrObgE9A717/2jPMCcfXcfewQP
 UFE/ig==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmrcv4v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:33:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51760f997fdso118098301cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780867993; x=1781472793;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nPk71TxUUS622Q42M+kOUQRMtPhEpU+4iMVusC4zd94=;
 b=BQ7RH9njzOJvqFgRXMCF6cEIZ0lH8iM6XL2D42I0rchsUtaswlUDrMvWxjjzcgN8LO
 mcJjMQQr/a4tmv0n2lG2BrUq6l94nf70l/rEofy34jDBs9dQE0jAD/tau9J/BnjNkhOr
 SrrI3GQGE0G+XQ+XG18dQb5VKn1GiVpsCQ9J67qNrxAvnbL2qiYwv1Ustsxwz6cds5mT
 iAjTX6c0Wo/wG5TLH2U7Cq6WyRnxL5II0enZfn5yOUDX6cNPF2qIhZ40Xt6ALvyepxJQ
 ycdAaxm3/EGerhdiUplY72cymKa4dohNmo+1ZGJsOxmrf03PiwSISBjsShcNoIV6mv8k
 V0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780867993; x=1781472793;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nPk71TxUUS622Q42M+kOUQRMtPhEpU+4iMVusC4zd94=;
 b=D9/naGk/lqYX2M6i8pzgXNFgFCFdwol7fNMSn3TJ3XaS2rSa4bd4ugqZ4mWzs16Zd1
 jn2feuANiPBBW8PzMiuMIsROlLzNhtO+PtzuN07RhPGP6j3H7jqRyDB6KZJnU+iNtkRc
 L0w4RtkKOenZmrCPnJY1VvKIGWVC5qZBqz0Js9qmJ9JT/HsoCThIvCI5cREkxS0/53e8
 1+zNMafN+7yocqRocj1hqhhxgKonyO1rH/1xL8CMI8qUW7a0iUCsfGyWisEcn0fVwSdX
 VhiSxfYyMINYyu7sC8bXiIcovIIYeWr+MFn6S4H0/vSXWWs7WTMQc9XylqSnEKxp6sCm
 Nk8A==
X-Gm-Message-State: AOJu0Yyioptn4Ph1bH5g7O9HktrBiYXoml14tXDM+VnPzgtYXmgjhLzK
 5wNl6CrH7u4gR5z62V+r7KDdHwek9VC7k73W4ylIcyr3G5n9ZlBrEpkMso4g/GoIyTdFi/r56/I
 wwHWlg+bYYHiPhPaXrdqpdQK2Tj2jm0I3FScfZCoS4XF0rGyis2Bbfxne1DaWpr21B9ZTbeE=
X-Gm-Gg: Acq92OGcSSao5DCmxwLJ0ilB2EBeyiCZs5+axLFeOeT09n/cBAIaoNIMurdsKcBG2PJ
 CDHXsX/2RMU4N6RYGqip9Z5CEq11nbXm+w7obtrJEEgj0BzIgK5q6YXmwgCiqLt/g3exJ1LX2qu
 BboegG7nH2DynXqhbfopouJXHaI7mDZ11UiyoNXask08tJCrQswHf5w3RnuMoEKq1Go3PZDRtP/
 0B9fayDDyP8zJ5sCtTrVfDwtR8NG9fkszdhpEobbcpRjFjIVqCeHdxTlynnMuneQPhi/Drf/jSx
 AsQs82qy5uXHpzegBCNPEFx/ThUhqVSTgeYAmHcrDU0pDx2TqinVwYIT6dTy1Nk96WQiuPYFTh2
 nGxwfBtPObyebysn4eqem4/Dr1A/4DzpNQ/bNcwD3FE+uNd/WDsQKO4ZsHyjhwVRI/Fvn1kP00p
 absL3jHYTidEpi9QOBD4TsCgpzJ4VE60Awej75uRQc63AkSw==
X-Received: by 2002:ac8:5986:0:b0:517:9f43:4732 with SMTP id
 d75a77b69052e-5179f434867mr149873221cf.11.1780867993178; 
 Sun, 07 Jun 2026 14:33:13 -0700 (PDT)
X-Received: by 2002:ac8:5986:0:b0:517:9f43:4732 with SMTP id
 d75a77b69052e-5179f434867mr149872941cf.11.1780867992778; 
 Sun, 07 Jun 2026 14:33:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2d5ea9sm40374041fa.32.2026.06.07.14.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 14:33:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 00:33:02 +0300
Subject: [PATCH v4 1/8] drm/connector: report out-of-band IRQ_HPD events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-hpd-irq-events-v4-1-30b62b335487@oss.qualcomm.com>
References: <20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com>
In-Reply-To: <20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Francesco Dolcini <francesco@dolcini.it>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6880;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=xbTDhi2tp6aIbxxzE2FCVTK2nYgOD8sjf8SKhUk27v0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJeOPemWBxW+eP+MfHReYGxm2pBOMLLACcpqbh
 a+bnF4n5pyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiXjjwAKCRCLPIo+Aiko
 1VzPB/0cO0/y6RIZKyhdFY9GpP8e3L7D6nujrtjidCfu3o4XzwLnmrs1tMT0xKo9Tj4+zNlLtwh
 kmPvx0BwUsvO+YGd24mrwjlbLOrPIWlIcU6Ecew9+pKZhpdB/lE4I3dRkJAxkvntXeBy6wfyo/n
 g/cr9AegIwEsVDEXzAjz+ZU8bfZ3BZA35aYuHc68wKsjvNGU1VP9fRi8dTlu+3cUXBjc3mRoWHj
 J9ly8vXi/+sHqkb3wwVlLoHUX4+7AR1fmQNh+oGMXiE3JP8wctqmE5kw0cVaXSGRoK0rCHkGMuG
 0gvgm8tN3i823dYQp6fD8IcGt/EwdmMIPpTDIlbPNdeAl/JR
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxNyBTYWx0ZWRfX+iLdX8SeKpa1
 i2JsnKqCKYCzqGVKUXkR478EIIWGkCutvYjmzEzqkJBm28dkXcOzkPJSEpuYKPqgA626kP1qYTH
 UvNJmHbD96jF4k4g4KEJ+E9io02hOUXTWuNj5CNlJWLvY+ndEtQBqtmY4h8H5eEMErcLgKtwLDm
 atXm2ciyR8cFHdBSTkY1n2Afo8r7bt4T5Iso8+f7frIhR4ZWqaCoIVAs2/5XemJBNmsn/SMVlYq
 wblrd0K92tpzwRDmEnGNy1I4qSYY18sQtVZ52Liuq8Ww6iDhaSkdvHJo0F0VfF9tNISf0uwSLxU
 boY9g//7Nd18WbfmXF9fxy2KSM8RC5h6wLNFvMfisw/W8aTQ5973iUXwrhMQPzAHUwX4Yr6FIDR
 MMNS81IBDA/ibft4p1xnjEz7DyHXFqWmYXso7n56ws047nuD04PkH0D9O3XLNYRJTjiCyh0rlY5
 9ffsXS0Ujqqkx5Cocbg==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a25e39a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=m8VRbRV2F-575zZTFkcA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: QMqqx4YkYl2PvXTMXSLuCYfAUUPURINe
X-Proofpoint-ORIG-GUID: QMqqx4YkYl2PvXTMXSLuCYfAUUPURINe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070217
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

The DisplayPort standard defines a special kind of events called IRQ.
These events are used to notify DP Source about the events on the Sink
side. It is extremely important for DP MST handling, where the MST
events are reported through this IRQ.

In case of the USB-C DP AltMode there is no actual HPD pulse, but the
events are reported through the bits in the AltMode VDOs.

Rename drm_connector_oob_hotplug_event() to drm_connector_dp_oob_status()
and extend its interface to report IRQ events to the DisplayPort Sink
drivers.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_connector.c          | 20 ++++++++++++--------
 drivers/usb/typec/altmodes/displayport.c | 23 +++++++++++++++--------
 include/drm/drm_connector.h              | 21 +++++++++++++++++++--
 3 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 3fa4d2082cd7..bb128dd0263a 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3502,20 +3502,24 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
 }
 
 /**
- * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
+ * drm_connector_dp_oob_status - Report out-of-band hotplug event to DisplayPort connector
  * @connector_fwnode: fwnode_handle to report the event on
  * @status: hot plug detect logical state
+ * @extra_status: additional information provided by the sink without changing
+ * the HPD state (or in addition to such a change).
  *
- * On some hardware a hotplug event notification may come from outside the display
- * driver / device. An example of this is some USB Type-C setups where the hardware
- * muxes the DisplayPort data and aux-lines but does not pass the altmode HPD
- * status bit to the GPU's DP HPD pin.
+ * In some cases when DisplayPort signals are being routed through the USB
+ * Type-C port the hotplug event notifications come from outside of the display
+ * driver / device. In this case hardware muxes the DisplayPort data and
+ * AUX-lines but does not pass the altmode HPD status bit to the GPU's DP HPD
+ * pin.
  *
  * This function can be used to report these out-of-band events after obtaining
  * a drm_connector reference through calling drm_connector_find_by_fwnode().
  */
-void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
-				     enum drm_connector_status status)
+void drm_connector_dp_oob_status(struct fwnode_handle *connector_fwnode,
+				 enum drm_connector_status status,
+				 enum drm_connector_status_extra extra_status)
 {
 	struct drm_connector *connector;
 
@@ -3528,7 +3532,7 @@ void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
 
 	drm_connector_put(connector);
 }
-EXPORT_SYMBOL(drm_connector_oob_hotplug_event);
+EXPORT_SYMBOL(drm_connector_dp_oob_status);
 
 
 /**
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 263a89c5f324..ff3659b8f5a2 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -187,9 +187,11 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
 				dp->pending_irq_hpd = true;
 		}
 	} else {
-		drm_connector_oob_hotplug_event(dp->connector_fwnode,
+		drm_connector_dp_oob_status(dp->connector_fwnode,
 						hpd ? connector_status_connected :
-						      connector_status_disconnected);
+						      connector_status_disconnected,
+						(hpd && irq_hpd) ? DRM_CONNECTOR_DP_IRQ_HPD :
+								   DRM_CONNECTOR_NO_EXTRA_STATUS);
 		dp->hpd = hpd;
 		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 		if (hpd && irq_hpd) {
@@ -211,8 +213,11 @@ static int dp_altmode_configured(struct dp_altmode *dp)
 	 * configuration is complete to signal HPD.
 	 */
 	if (dp->pending_hpd) {
-		drm_connector_oob_hotplug_event(dp->connector_fwnode,
-						connector_status_connected);
+		drm_connector_dp_oob_status(dp->connector_fwnode,
+						connector_status_connected,
+						dp->pending_irq_hpd ?
+						DRM_CONNECTOR_DP_IRQ_HPD :
+						DRM_CONNECTOR_NO_EXTRA_STATUS);
 		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 		dp->pending_hpd = false;
 		if (dp->pending_irq_hpd) {
@@ -396,8 +401,9 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 			dp->data.status = 0;
 			dp->data.conf = 0;
 			if (dp->hpd) {
-				drm_connector_oob_hotplug_event(dp->connector_fwnode,
-								connector_status_disconnected);
+				drm_connector_dp_oob_status(dp->connector_fwnode,
+								connector_status_disconnected,
+								DRM_CONNECTOR_NO_EXTRA_STATUS);
 				dp->hpd = false;
 				sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 			}
@@ -828,8 +834,9 @@ void dp_altmode_remove(struct typec_altmode *alt)
 	typec_altmode_put_plug(dp->plug_prime);
 
 	if (dp->connector_fwnode) {
-		drm_connector_oob_hotplug_event(dp->connector_fwnode,
-						connector_status_disconnected);
+		drm_connector_dp_oob_status(dp->connector_fwnode,
+						connector_status_disconnected,
+						DRM_CONNECTOR_NO_EXTRA_STATUS);
 
 		fwnode_handle_put(dp->connector_fwnode);
 	}
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5ad62c207d00..105da7c94910 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -91,6 +91,22 @@ enum drm_connector_status {
 	connector_status_unknown = 3,
 };
 
+/**
+ * enum drm_connector_status_extra - additional events sent by the sink /
+ * display together or in replacement of the HPD status changes.
+ */
+enum drm_connector_status_extra {
+	/**
+	 * @DRM_CONNECTOR_NO_EXTRA_STATUS: No additional status reported.
+	 */
+	DRM_CONNECTOR_NO_EXTRA_STATUS,
+	/**
+	 * @DRM_CONNECTOR_DP_IRQ_HPD: DisplayPort Sink has sent the
+	 * IRQ_HPD (either by the HPD short pulse or via the AltMode event).
+	 */
+	DRM_CONNECTOR_DP_IRQ_HPD,
+};
+
 /**
  * enum drm_connector_registration_state - userspace registration status for
  * a &drm_connector
@@ -2520,8 +2536,9 @@ drm_connector_is_unregistered(struct drm_connector *connector)
 		DRM_CONNECTOR_UNREGISTERED;
 }
 
-void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
-				     enum drm_connector_status status);
+void drm_connector_dp_oob_status(struct fwnode_handle *connector_fwnode,
+				 enum drm_connector_status status,
+				 enum drm_connector_status_extra extra_status);
 const char *drm_get_connector_type_name(unsigned int connector_type);
 const char *drm_get_connector_status_name(enum drm_connector_status status);
 const char *drm_get_subpixel_order_name(enum subpixel_order order);

-- 
2.47.3

