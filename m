Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE45FF5A8D3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 23:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D4E10E7C0;
	Mon, 20 Apr 2026 23:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dzQXAuQd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AKSLpv6L";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 541EB10E7AD
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:33:43 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KGjZOA2980973
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lUxjcmVB1mry2JFOZUVE65+ZJk/cVp6zUgik6yCWYSo=; b=dzQXAuQdlW4iR2ry
 TsRnz38gOK2mtMk6dIx5AT1dACjOU2lDQez6DPEiozt9Gn/gNZG02jTIjV7nI7be
 4pwYs2jhKOX3WDX2gqYOD5OpLVtqwoLEv9X6eXs8YvnsQWFaU5BYH6tMU6Hijngm
 9V7yU1tKDtnxZvdxxcxRmxNnYKEzlVwQcI21op+XmRfwka+KUllAJR4TN+yFmprl
 P9ArwTDdJcD7wHcha9M/4AKPegHBcq2AeKhLwqjsLvSFOp+QGxwxsbN0MMBGo/30
 W2PARFyHCho4KV9vIJ2RahcfYEC99h6Kte0oyOwKf7QtKl7QlOc/OTIWeJ07B1Bx
 +HsMvw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnj2ptp5s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:33:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50e5ca8ffe7so28322411cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776728022; x=1777332822;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lUxjcmVB1mry2JFOZUVE65+ZJk/cVp6zUgik6yCWYSo=;
 b=AKSLpv6Lvg6+Txb/tjVEl0EqYgUAPOf0Y1jSkidnFTA0x9r5sZaGIXRiyi+YtADLmr
 jpQRA6czkE/SryCFvnokAaiCiCn6ts8eksfgwmK9oTHhAxCvU5Z51aEq41jrTf5rgHen
 SrClfItXoGP47IYM+lheKsSqkkP+TyC4NdNts1m5/zPx//Yl3s9sWA7Fs1NxkFIxufHa
 tYuag8LVbANGwd37xGh4Sxs8aFPtQftTG6C/3YtVm0EkPGwqsUNYhi+1q/kBA7V4PHu3
 30NEVA1DciZcaMyBgey3oCkvwH9bsYsgIPrnwAM5EoMZUKFj4CXxG+wU2oQDWCls7WL4
 H43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776728022; x=1777332822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lUxjcmVB1mry2JFOZUVE65+ZJk/cVp6zUgik6yCWYSo=;
 b=i67a9cQ07yfiepCv+6065jVKU/QffaN4H4q2t1CAXe8mKq1hATLYJqdX8zNH011pZB
 1b/+IBnYJ6VI1g8Z0MG5ah//X9JFKOsR8pkKUf2tKgOLWXMjqIGeerjT15atCR7SMRJI
 +j59uP0DDgf0Ta6IX0yvdCjofZZA/aX1u4nQIiBDOM2i2E44979HOUFYKVPY2atG0IPO
 x8SIKvBIwekivFfQGJOFxyP2hPPPVZXxT3YdWmIAkPnUqVHgYPGTX0z9GFtyaDZSQHDn
 B2aKlS0z3wb1GUmfX15HYlNR5DLluGysumbGQJwGAVVh77RWWd7AsVfUTKH+ibC1nFcO
 XoiQ==
X-Gm-Message-State: AOJu0YywetYeyCMIjSnv+U0OcmAI+s/3zwsDJUwUxC14FO4zXkS/Z7Fs
 GUkIlzHnRTOtImEbB48hWyr8S6/VNZr3mA2XquN/nvV0U9XJPdnI2/dX6wr47L83o9sIHuT2N+v
 7jUpylnbxNzqIWeL4ND1sMzhdoNgr0t9BFNK0GunlVlY+d3br/rk4A1mYJpwcUXb/oA/Ok7k=
X-Gm-Gg: AeBDietVaI5eDH92dzHDJ+6W2UhPzFDv4ESCydIQreXSz8PURcEoeDaPJStMaxmB2aP
 hyaAAXizDh9fIaPyp/H+KjZHzNeBa0LDA2xykVIXuMZ8sztpryfyv0rl7fKJeY+FNzGi8+O9h6/
 qtLDHjms9q2NRhFm3nE98GzvWqhNe54m3haQRXGOq4FbuN3MQ+nhMCm+TLnuF5Za1+V8nFe0VDo
 O4lRx4BFiJx6kw3t86DsgNttkJ/jIdlBAnZRrLSwuKZP7lMxXJgSwa0ugKWruSvr94m2yp6I1Wc
 hfSREglg2JK5+29x+wI9QXPtu2JbXs5Z8B5GY1hvDVWRxq/VomqsCk3q1/yu5cyede55Ve7scIL
 CoSh3RYtQN3Pi4PK15Czr5Z7xQkNMPsPf/uEkH5XPVlna1G/dWcr3nnmpyTJi70lmrnnNratFtm
 DoZL+Y03JEqGZJnVvlseHQIgbZwJFyO/UFJtgD6DsNjU2W6Q==
X-Received: by 2002:a05:622a:11ca:b0:50d:41fa:80fe with SMTP id
 d75a77b69052e-50e36c74d5amr235550381cf.53.1776728021604; 
 Mon, 20 Apr 2026 16:33:41 -0700 (PDT)
X-Received: by 2002:a05:622a:11ca:b0:50d:41fa:80fe with SMTP id
 d75a77b69052e-50e36c74d5amr235549691cf.53.1776728021109; 
 Mon, 20 Apr 2026 16:33:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc627sm3320714e87.29.2026.04.20.16.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 16:33:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 02:33:31 +0300
Subject: [PATCH v3 1/6] drm/connector: report IRQ_HPD events to
 drm_connector_oob_hotplug_event()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-hpd-irq-events-v3-1-44d2bf40dfc2@oss.qualcomm.com>
References: <20260421-hpd-irq-events-v3-0-44d2bf40dfc2@oss.qualcomm.com>
In-Reply-To: <20260421-hpd-irq-events-v3-0-44d2bf40dfc2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5422;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=lnVODOLTo2WpHrvqFht5FXa9gKD0IeWSjwE7+hKxwmM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp5rfN9qVkcYl9KlTfgDparsbRrCWpcXopk8vuW
 GUdzBXPSXiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaea3zQAKCRCLPIo+Aiko
 1d1zCACrM1rSnOWM/ansjd2L0dlEIFNtiy0HcCmU29ncv+aHHP/gwemRhujKNggpqM10Xv/vUQG
 Ye+SQyG369jmy5xs4UViG3QvpUxYP5IyWXEu8/j9E/YXe1UjYr4QnPO7M1bWNqxYcw7cQ7jvOuQ
 IVrlZf74JvyhWDOXkFAhZf5wtAKeLWc7+43FJlgw3qQWu8s9HHnNRvZuSSd2BtrnmAvUIjtjwZ7
 Jc7cF38VU8CFgmmWGghTzspdneM6lUl1VI0roh/CbwH+TdS1SrF3HdPe5GczhNCuZsqMRIh15FK
 5IfGYE51m6R2SPeO8rvSUf02COXnmuxI8QsXfNwmzGtedb0X
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: r57Tk_cN4mBxkUqyysKEYHJjoJv1laua
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIzMCBTYWx0ZWRfX39nUOWTVjBz7
 dnVYlrejIzdxLf51foZHc17LCLePytrMDQ15jSTZVw9VFcPLtxgOnA5xOwQWBo7PHWUsVaD/jOJ
 WXnm229bFKIllGl9Jm6omNt6Dn0c6s8iZSkb6pWYaki9tnX4J4sBH9fvGTURpk97Y7QJJThlrGA
 RzQxMEz25Pk9k6TyRr1RSjl0H6bdMzZZwGQHLLtUOSfn3T3XHl8lGz0BPCq9L5h3t1d2Rw52nWR
 85d5KXtZOxx47x13yGwzvDFfxyMY8SepwqWWaieRuugj9qgmDSQToTlwYl4gQX9QdHizUXR27W7
 htBV2FCI2V+UX+iMHq1JmwP36WNNEIas54Odxde8lCvCmeQ/YzRzlTl0Y7uSVIp2K7xzOajaEzP
 NlYCd5dMHzlqga8QZnbUCmYzPDcHeU8naiMnoNd2PlqTB28CarxhQ1mYJTDnUyH5NzpkzRPqhL4
 3YkQNEKJoMDUAhhkj3Q==
X-Authority-Analysis: v=2.4 cv=XMoAjwhE c=1 sm=1 tr=0 ts=69e6b7d6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=-JEBqWJC5KD3P7x9m9UA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: r57Tk_cN4mBxkUqyysKEYHJjoJv1laua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_04,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200230
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
events are ported through the bits in the AltMode VDOs.

Extend the drm_connector_oob_hotplug_event() interface and report IRQ
events to the DisplayPort Sink drivers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_connector.c          |  5 ++++-
 drivers/usb/typec/altmodes/displayport.c | 15 +++++++++++----
 include/drm/drm_connector.h              | 19 ++++++++++++++++++-
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 47dc53c4a738..edee9daccd51 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3510,6 +3510,8 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
  * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
  * @connector_fwnode: fwnode_handle to report the event on
  * @status: hot plug detect logical state
+ * @extra_status: additional information provided by the sink without changing
+ * the HPD state (or in addition to such a change).
  *
  * On some hardware a hotplug event notification may come from outside the display
  * driver / device. An example of this is some USB Type-C setups where the hardware
@@ -3520,7 +3522,8 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
  * a drm_connector reference through calling drm_connector_find_by_fwnode().
  */
 void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
-				     enum drm_connector_status status)
+				     enum drm_connector_status status,
+				     enum drm_connector_status_extra extra_status)
 {
 	struct drm_connector *connector;
 
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 35d9c3086990..7182a8e2e710 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -189,7 +189,9 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
 	} else {
 		drm_connector_oob_hotplug_event(dp->connector_fwnode,
 						hpd ? connector_status_connected :
-						      connector_status_disconnected);
+						      connector_status_disconnected,
+						(hpd && irq_hpd) ? DRM_CONNECTOR_DP_IRQ_HPD :
+								   DRM_CONNECTOR_NO_EXTRA_STATUS);
 		dp->hpd = hpd;
 		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 		if (hpd && irq_hpd) {
@@ -212,7 +214,10 @@ static int dp_altmode_configured(struct dp_altmode *dp)
 	 */
 	if (dp->pending_hpd) {
 		drm_connector_oob_hotplug_event(dp->connector_fwnode,
-						connector_status_connected);
+						connector_status_connected,
+						dp->pending_irq_hpd ?
+						DRM_CONNECTOR_DP_IRQ_HPD :
+						DRM_CONNECTOR_NO_EXTRA_STATUS);
 		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 		dp->pending_hpd = false;
 		if (dp->pending_irq_hpd) {
@@ -397,7 +402,8 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 			dp->data.conf = 0;
 			if (dp->hpd) {
 				drm_connector_oob_hotplug_event(dp->connector_fwnode,
-								connector_status_disconnected);
+								connector_status_disconnected,
+								DRM_CONNECTOR_NO_EXTRA_STATUS);
 				dp->hpd = false;
 				sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 			}
@@ -827,7 +833,8 @@ void dp_altmode_remove(struct typec_altmode *alt)
 
 	if (dp->connector_fwnode) {
 		drm_connector_oob_hotplug_event(dp->connector_fwnode,
-						connector_status_disconnected);
+						connector_status_disconnected,
+						DRM_CONNECTOR_NO_EXTRA_STATUS);
 
 		fwnode_handle_put(dp->connector_fwnode);
 	}
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f83f28cae207..e05197e970d3 100644
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
@@ -2521,7 +2537,8 @@ drm_connector_is_unregistered(struct drm_connector *connector)
 }
 
 void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
-				     enum drm_connector_status status);
+				     enum drm_connector_status status,
+				     enum drm_connector_status_extra extra_status);
 const char *drm_get_connector_type_name(unsigned int connector_type);
 const char *drm_get_connector_status_name(enum drm_connector_status status);
 const char *drm_get_subpixel_order_name(enum subpixel_order order);

-- 
2.47.3

