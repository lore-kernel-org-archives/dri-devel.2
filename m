Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1ADC982F2
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D6510E365;
	Sun, 20 Sep 2026 15:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VRBBz23x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TDTGfBSr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D7810E26D
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:01:38 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68KBoExR1572678
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SknP0ek61nWxcALGWerlRGpQ+hsm6XCBNnS1Dt62yI8=; b=VRBBz23x/lhTLFHq
 vbgWnynOvIuNGZfKl60nmBA/CnhuqEgT1wDLlE/pqvtl1N5tyZwRdSw1YmxX2UOC
 VrlnWiiVFbnfLfbji0ASw2xVlZlB60g1ZjUCbdrWfUdf+MbR+mSO171p57OQv0cP
 5VL4aZSAMNaIH93DLVFl6Th6V6XyNJgztZYWHEECcZUM/ZxFs/48KsWYp6Bcy1Tl
 qB0ysSK1O1QIin1qYKSA1u95cBe7RjXBRoh1FajDvkvTIyOyHvxp3/ngoa3kqhpH
 wgGIUF7WtadnN6vdCDRXxwxm2/Ju5YAV3j6+5xg86otCMPEhi9FmG7hl8zcqaRrX
 41EkPg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gskp9u2ct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:01:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c26012cd0so45378801cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789916496; x=1790521296;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SknP0ek61nWxcALGWerlRGpQ+hsm6XCBNnS1Dt62yI8=;
 b=TDTGfBSry1mjgYRQSRLND86CvlZUnnYY+KdtMYbPcoSVgVr4tIthLi3LbyWoohZ0vm
 jbJDDL3Lb5i1emG/7iCuo0mNuWQbLJp+dDTBZihTEW+/toDRdHRR4kzmGs805Bc4/AdD
 8q8SnAgF86NKeo2EFXcddkJOIhuGnUNIYtuY0pk/FZuhip/bRX6FRdGPmqZALzhS4aks
 nfoF9XVYjJkdhaNQqOREskMZgeXFeZF9aJuXAHzuicJWmWdXbq3pgRrSMf8CPeaOarJk
 DANZ0H9LVNogbozd/5e+ogV4FM5qTP4LBTBjodMumIHpneiMQozlDjjmRAHzAc99wm00
 pUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789916496; x=1790521296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SknP0ek61nWxcALGWerlRGpQ+hsm6XCBNnS1Dt62yI8=;
 b=KfOvv3rnBgHHITpvx/4zOBTRHuzitAQwczFtJSn4UNXvUmuyeFcOjwA38Xd6aSEcap
 QXUWH4WuTUWiNAGq6BM2Zg+Zd61UFWFN0KRyd02SCBg9dwfHFZdOyFgObV9aB1IecIXv
 kDQp3l9jKyMV/yG4mnmXjSgX4WHznK4zxhdeywJG3vLHmPT4pu5SKDQwtsnRd36mtVn2
 4XQXY5P9oN2L5aCWnmC+HqvMmR64H7nPxsf07glJ0pzGXw9rtMrE/6V+mhjLPk958RjZ
 nbES+CW/2rTovoAvjnSsXAkCAbtDqGvOwvJv+LS+kZwUe4+FwV+9MCDUUAZtm5/n3YF+
 daTQ==
X-Gm-Message-State: AFuF++nlxlVgGjJkvEJjrWxtnwB+WvWI5trbmMKBBjj8oYPRJFJt6ixW
 jpO5YtyvUfPBR8z6WtICSbVuBj26Nvb7ySc5J5w5E+I6HmlTMKHaQqRMDu/9tBXokrLOgRyvtnn
 ASD7tbDFw6p0RDuVMSPZxTExjhQAu8wlbdC9KzoIbyaTOEv54onJQYtWXxnjqctWwH+1i+yk=
X-Gm-Gg: AYBFou3pcD5/3jQ22YuTnNL7/hHY+tLw5SwpjG8Q21oIS7NpIMKKb09atA9OBgy+sVi
 X8SOtGSgGawJRNudV6+BTkHjfAIlUysy5EmbjJsg4cmWFpZHedS7DwaLR8XOyK5SMEsskM6T60m
 3x+6D+Zq0TLORuKuY0IJ/c58jHU0McXr4mOKUlDzS77WzVYOFAIPNUL6icOg/48vBnuoHkugOrg
 KM5aVCM3/6fJ7+YWEoNtjA+gETsAdsHCg6FMIOAEN+GuASY9ye1PtBcMybe8aQBIzkGw8lL5oUK
 sfF7dcd0nhcZziO/lMuxWAhYw9iJ01n8PLvLgHVvZ3+ORPpx5ZT8iVMqBPt5HmLdXp+L2aR2czz
 SbCEG5k7/sw3K4BZtXDEC8XyTeHwxqAkLXZqkKP86VhvkOtHqrt7AwMrKlH3LVKxbsC6+Ny7kgC
 70w4UPltymu6zu
X-Received: by 2002:a05:622a:4d4d:b0:532:9f22:3072 with SMTP id
 d75a77b69052e-532b732a721mr69391531cf.48.1789916496006; 
 Sun, 20 Sep 2026 08:01:36 -0700 (PDT)
X-Received: by 2002:a05:622a:4d4d:b0:532:9f22:3072 with SMTP id
 d75a77b69052e-532b732a721mr69390801cf.48.1789916495488; 
 Sun, 20 Sep 2026 08:01:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a6163d7119sm4090061fa.30.2026.09.20.08.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 08:01:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 20 Sep 2026 18:01:26 +0300
Subject: [PATCH v5 1/8] drm/connector: report out-of-band IRQ_HPD events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-hpd-irq-events-v5-1-ff1de0090c72@oss.qualcomm.com>
References: <20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com>
In-Reply-To: <20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com>
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
 Francesco Dolcini <francesco@dolcini.it>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6882;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WQsv8QazF+E5QQ9hUw9l40V69yXFmn0I2Nu5uJ04hXo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqr/VH7SDFu/E9XO4Ljq+GFlzDqUHCr1Atofft3
 XNL0tySY9CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaq/1RwAKCRCLPIo+Aiko
 1WqsCACd+ETHhlHes6LYxN908aTCxnlg8YPDwcAKEl6ccZM/R905V27dwX3LkSnwi67C8bbG7yo
 6Sz7dGScskcTUID4khs3iJVPJclCXA3GP+P+f27/HhozuwQqbrSXhI7oFP147QdJkrW9314X3oh
 qHB2c3dQ51Lrcop2wOnPS7CthWnRqjR7xh0bJNP/golUD+FZ+zOxyPkMApKfehCTNn/6l3kaT6G
 RK04ujgV9DXHYgfhNXajrWrhFopVdRQDqiucqCGGNR4NgzjVQCay+H1Ok0jqJ05MpyCj36wIEcS
 pnjwTo+kxGzrCrgMZ9G3mrP+FF+AhQ+7pS4JAuhkR6+dgHjh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: Lxulcr-CByRlbb3dtMHmcxF2RTBeM47D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDIxOSBTYWx0ZWRfX0uB0pNJSdKfK
 NYitsnAT7qZsY7NNh27zi0IHUw5vZPfOMZld3DwEt/Xhi4K3MyvZ/QbXoPQDmid7FSJnBiVcFRn
 XgM8bixjG34rs6blPfjuhZIOCW9g3gl9ezE4UhZJdcnynTJg9ECRK9sqEbQ5Ni3nnvtmgyhAUOT
 Yo6ku1BvKMpwdhjVspDkoGa4ah3aFJauc4qzTt5nYBBrnibuJByBLCMNb4WHLdmzkkKhjTznZet
 4JPeQwYu/fb5MTDPf2MBBA7+3QUogdAlzirRP7FBQx9BPVvUwMzrRFDq/nL+ptdFcvfiFobS3bL
 /zPPVKoiuHzTiL9468iMHZU7D2lgqsmW00P3/gIUdgYfTVZvulOcWPJdvtPLiXU8bujXNz1xUKV
 Xo7r08e1bx1npNFc3LraOsuqNnuw3q4y8jM5zoC/5T0GcH5jX7wX3UIBY+0NVrfx7Rs1IHoxZ2w
 fZSfZo4JVA0D3n8bvug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDIxOSBTYWx0ZWRfX+jkvQ6mqRVFS
 Amyc88JKXdSCxYztML7gW3kkNkwtJeJfWAQvBCfwMXD5MExRpmRrIzFZN87FWx/F2uxZ8uww9if
 FLKUzYBj+bpSESKSCd6M58fua5gwffs=
X-Authority-Analysis: v=2.4 cv=BKAmP1QG c=1 sm=1 tr=0 ts=6aaff551 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=m8VRbRV2F-575zZTFkcA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Lxulcr-CByRlbb3dtMHmcxF2RTBeM47D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200219
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
index 8b4baed060f3..5d4945ea1e95 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3672,20 +3672,24 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
 }
 
 /**
- * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
+ * drm_connector_dp_oob_status - Report out-of-band hotplug event to DisplayPort connector
  * @connector_fwnode: fwnode_handle to report the event on
  * @status: hot plug detect logical state
+ * @event: additional event reported by the sink without changing the HPD state
+ * (or in addition to such a change).
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
+				 enum drm_connector_dp_event event)
 {
 	struct drm_connector *connector;
 
@@ -3698,7 +3702,7 @@ void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
 
 	drm_connector_put(connector);
 }
-EXPORT_SYMBOL(drm_connector_oob_hotplug_event);
+EXPORT_SYMBOL(drm_connector_dp_oob_status);
 
 /**
  * drm_connector_get_color_format - Return connector color format of @conn_state
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 51c92dd887ab..344a13c2a296 100644
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
@@ -844,8 +850,9 @@ void dp_altmode_remove(struct typec_altmode *alt)
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
index c61345e6fb08..906aaefca7e1 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -91,6 +91,22 @@ enum drm_connector_status {
 	connector_status_unknown = 3,
 };
 
+/**
+ * enum drm_connector_dp_event - additional events sent by the sink /
+ * display together or in replacement of the HPD status changes.
+ */
+enum drm_connector_dp_event {
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
@@ -2703,8 +2719,9 @@ drm_connector_is_unregistered(struct drm_connector *connector)
 		DRM_CONNECTOR_UNREGISTERED;
 }
 
-void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
-				     enum drm_connector_status status);
+void drm_connector_dp_oob_status(struct fwnode_handle *connector_fwnode,
+				 enum drm_connector_status status,
+				 enum drm_connector_dp_event event);
 enum drm_connector_color_format
 drm_connector_get_color_format(const struct drm_connector_state *conn_state);
 const char *drm_get_connector_type_name(unsigned int connector_type);

-- 
2.47.3

