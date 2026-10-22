Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93108606A323
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dx5v7mYl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UPNH+w9Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2716112643;
	Thu, 22 Oct 2026 13:28:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A77112630
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:28:15 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MDPs5j3959664
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OZrc/wG/9lHikRt/e8zpLrOauprcAJDgDD5YeisSoz8=; b=Dx5v7mYlAORcKITC
 6y9KvrE7AnZpoGxuSQhsvp21uG/gDTAvDKH0bJsvKNUbicpQefEHGjvVfKuyPXYT
 0ZjlLiRcJrI1OZ9ZWFzTWgEfU+lXojFMDURQ+gs19MHg6jItXJer0l/5+WExE12P
 z40mILbs9ghjaxXckIxJ8uCSAkQsaYNOg7NsSV6KatszOpG7A4fRHVNx/OOrAfey
 p3+rYG/4fSu19gPe7ubSRxPZKBBoEyS9DP9UdHmT02k7VwaB91c1WPGmLjSWk37T
 sJ8ORKzr2XdLNC+dAjmVb+W3uMZ0bJ044F6a22PR7WqpQicmKZ//gvB/xssqZG1A
 vKFaDg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93auqht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:28:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb93c874bso171722885a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792675694; x=1793280494;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OZrc/wG/9lHikRt/e8zpLrOauprcAJDgDD5YeisSoz8=;
 b=UPNH+w9Qo7d+7fisWXUxlwdC5QVfO6HAk9ID9J5azzO4Ha/0scMG4iHJ1csOt+cvg7
 ItP5GSuD6jMjSM1AncGKkE1VAthL6ylt46fCJNG+/SMDottAb5jesbk0f3ibggDiRzfl
 4TRyCMHZjgnNZ6Z4Kpz+ePJNwW0RK00iTglnA4/9ELLxRi3/ODRy+sxQePwcyix+Zy48
 ddPweO4QBVgpviuZEQw4ZMdvjhCN0DlvMF7FrNxOFF8AFmu4gPB5H5WFGX7Khk4IQKaL
 SaA5GOICYIN1eUAYIuc/rcanqk1pDra0qYbC9rrCciOgoXnieUeBv1seuRU7M/VfolFW
 hFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675694; x=1793280494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OZrc/wG/9lHikRt/e8zpLrOauprcAJDgDD5YeisSoz8=;
 b=i71FdW859YCqiNtmonOGfHgxsxogKXqbedyqbO+u0Gp6qpNiBcVRebk5viUAzE+lkN
 3VIlpjLJ1ZDbIMFR/0czLdFNDncBRlpjWVIWZtX+sPg7n9yb7o6OaOkzEE3DhJ21mLkn
 JubpWCELBym3a43e3FnOgNlOoUkrSUDZd57rL0svYYDaf2qtl1ies57aTftwuMCo9FOM
 C0c1ym+rNJHPu45remmWL6Hah/MnoWMTkFLXRla2xCoRFysXioIz/5VnOoZuDxNgjEGd
 aLY2bTwLZJiXF2ml9wRxCJugsCxUSRQS1BIwmVj99RQht/ySqfO4MN/dFzlwWNxwHWdG
 eMnA==
X-Gm-Message-State: AFq9FYJpv2e3iSZxBdV/s6L7p1uPL02vHYIr6fgb2Xy1Jg2VS096zVFK
 krsv7Z4cYTTx6fC3TSEcEPEB2Z0Tq22ZmBINN+FUbfm6/xNjwXCEa4rGJYC30rHP/dXsWnsmgjv
 F26HYqehs+bewRGOL96ZsW0w0h56YdKqKq8Q0xcIpr9I/qHCMz/HX5HyVg/RtCdiWjTmdMn4=
X-Gm-Gg: AYBFou1GZb3TCFULhs2d6JeeT+VRWc/q7INDvLh1HgA6mjE9qfX0exLzHD2/xFnVPB0
 sg0s6jImtLT06OqJ/Ze4GOIiNjPpTovXjAb69gzHcrVwsPZ/nwQQVZ+JA9AvxU9eYbyIqUWblsS
 ANDADNe7tehC7E7IYKLPv6z6++YnZzRPcK02Jep7NGvy/h+ckhllriTe8NQIraIHz0tUtAasuX5
 mVNVZAg4gI34CoB80f+6CEnmV7ehtA77Yf/GfPkQQBwDyK5z4De+njuaLP6XdSWCUeVe4yWdR29
 Q32O5MwfJuuuN/d5zEr0eVIW9oHisQ78LJxgD9nd4/0WY9nFWLzWodnXkIBx+piW1olYpGPoU4x
 GMEwkAXeC3OxJE6GkiaLXfKdKa+pZGt4RorhbJuJB8C2n7veyf8DOivrCYneB37ygNRHNwkRiZC
 MyN7fzW+C9TySH
X-Received: by 2002:a05:620a:25c7:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-93f6235c83dmr389696785a.0.1792675693408; 
 Thu, 22 Oct 2026 06:28:13 -0700 (PDT)
X-Received: by 2002:a05:620a:25c7:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-93f6235c83dmr389689485a.0.1792675692727; 
 Thu, 22 Oct 2026 06:28:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac4f6683edsm8762201fa.22.2026.10.22.06.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:28:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 16:27:56 +0300
Subject: [PATCH v6 1/9] drm/connector: report out-of-band IRQ_HPD events
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-hpd-irq-events-v6-1-337ea3ddaa62@oss.qualcomm.com>
References: <20261022-hpd-irq-events-v6-0-337ea3ddaa62@oss.qualcomm.com>
In-Reply-To: <20261022-hpd-irq-events-v6-0-337ea3ddaa62@oss.qualcomm.com>
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Francesco Dolcini <francesco@dolcini.it>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6997;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=saKTuWGNmEwpJovWRzupqEzCaC/rm4ThXYLAzUmpGxA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2g9kny+ts34CTm9BWKo5GDTM24nf/7A2XV9WK
 1998Mqse1mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatoPZAAKCRCLPIo+Aiko
 1XjoB/90leBj6+ttZ9ENUWIrRmh6Qul0u4JQ1rlyBSs+X6x+4HPszkbjNlaXcvRh6lBhFTHYr72
 o8+uKwCYsilq9KBl0pn3RokDSR/t6CGDv2nZBZgrWl+AOYzckNpUWr9OXO9PhFZ1uhFoGm2I8uP
 CTR/g/RitLbGdosAKt/bU89gBOe+gvLJQNytuk6/OcANQYchPYByUtrDEZnZA7W30RjMOQ7fNR2
 xYQe596N6+RCmX2JQkA41jO1+M4J1ZlH2MQHg3bnFgdFsdAn0tAJffID0Fdh7jw8W4S6kU3jtgg
 d71T8dsrsJCaPQ/lv+Nlc9z0MPTFnMi40V0bwAMn+09P124k
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1MyBTYWx0ZWRfXyaSEiOBStps1
 x2MJORmei/2GMavNKtlj3PUJlzHUE2ttSpmde2a1k1TDGwJtgPRtQfgBIpKhWkdObpZkFyrcZ1o
 XFapiTqug23IiVE4tzi4GWr3799CK/sq0Dte4k7WF62gzfy8/gnKyR1gC8J3auDFE2f9nXaRek/
 UDSmMrNnDB28hZhnvpAqQH8oyvPZ/eWV+CIu9cjJ+hHELL1pHkytzmKoKkOMkBERzae0s4SitlD
 SetOHGXkA+FInvlqrz/PFIGymFKp27LslRvVDENqV0YZM1IcWuLLUvFINhp6eeL/TYQazXJgtaQ
 oEjPLeG/JsKjKWqNArnOCWXrAADUohvJzuVsbDonZ/Yuf+oT6fuj6w1qgU2qBOgZ2JFcIyBkES4
 CxJF04POZA/k/2TglAmTpMPzIhfO+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1MyBTYWx0ZWRfX33EiwSIsiZMu
 GTYZaDw1XJu/0HzPDQyp38kz22vZ3a39QzOjBVnv/7GLoiy63Yo5jwu78XZeJVWDyCpgG4v9Zft
 2IF7XfZqfcYAEXlW1pEHc34DMmdKcSY=
X-Authority-Analysis: v=2.4 cv=QPn91QLL c=1 sm=1 tr=0 ts=6ada0f6e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=IejCAnqV6A546-KFDggA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: suvx8ttdXUvQjZ_T3XT1YfpXXM_aNb6J
X-Proofpoint-ORIG-GUID: suvx8ttdXUvQjZ_T3XT1YfpXXM_aNb6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610220053
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 drivers/usb/typec/altmodes/displayport.c | 25 ++++++++++++++++---------
 include/drm/drm_connector.h              | 21 +++++++++++++++++++--
 3 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 893716a9e489..e3c8181df6bd 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3821,20 +3821,24 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
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
 
@@ -3847,7 +3851,7 @@ void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
 
 	drm_connector_put(connector);
 }
-EXPORT_SYMBOL(drm_connector_oob_hotplug_event);
+EXPORT_SYMBOL(drm_connector_dp_oob_status);
 
 /**
  * drm_connector_get_color_format - Return connector color format of @conn_state
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 51c92dd887ab..2106074417d6 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -187,9 +187,11 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
 				dp->pending_irq_hpd = true;
 		}
 	} else {
-		drm_connector_oob_hotplug_event(dp->connector_fwnode,
-						hpd ? connector_status_connected :
-						      connector_status_disconnected);
+		drm_connector_dp_oob_status(dp->connector_fwnode,
+					    hpd ? connector_status_connected :
+						  connector_status_disconnected,
+					    (hpd && irq_hpd) ? DRM_CONNECTOR_DP_IRQ_HPD :
+							       DRM_CONNECTOR_NO_EXTRA_STATUS);
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
+					    connector_status_connected,
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
+							    connector_status_disconnected,
+							    DRM_CONNECTOR_NO_EXTRA_STATUS);
 				dp->hpd = false;
 				sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 			}
@@ -844,8 +850,9 @@ void dp_altmode_remove(struct typec_altmode *alt)
 	typec_altmode_put_plug(dp->plug_prime);
 
 	if (dp->connector_fwnode) {
-		drm_connector_oob_hotplug_event(dp->connector_fwnode,
-						connector_status_disconnected);
+		drm_connector_dp_oob_status(dp->connector_fwnode,
+					    connector_status_disconnected,
+					    DRM_CONNECTOR_NO_EXTRA_STATUS);
 
 		fwnode_handle_put(dp->connector_fwnode);
 	}
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aa..4f65c97a89ae 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -92,6 +92,22 @@ enum drm_connector_status {
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
@@ -2848,8 +2864,9 @@ drm_connector_hdmi_scrambler_supported(const struct drm_connector *connector)
 		connector->hdmi.funcs->supported_hdmi_ver >= HDMI_VERSION_2_0;
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

