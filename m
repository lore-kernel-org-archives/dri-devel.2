Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EF6F433CD
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A3B10E792;
	Wed, 15 Apr 2026 23:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HN9jqGQm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IWmVxveE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9898910E781
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:22:42 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FGEpTf506785
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iT4ySHxd8iMiHVjfS/Pg8NfDAUzunyhUM2tZEku061M=; b=HN9jqGQmz0rOg6qq
 gM7Ah4W9Y7kaF29tucblX1H2+R1u9HMVdLhD4pohGhFPwRkMBxkDz43FDkLMQoLN
 jQkAjCv5F8SxaZTZS/FjIzwzRcQHO4DByVL1mJ86ZL/F/QB+5BBEnAXmjnYKsKJB
 VgL0Bgi15wvGsmuL9cz99m8I2UoaMBaPjB90kxh+yJGJDBwcQJlndgmNoQSOq5lG
 MwNjxpGuAyTfHllF3pAV5L5yZc0RF+gc9AXbHSbIFskv2VOaQ2sbmiiSjOIyl98o
 JrQLvEZy2eW/FpHX4FJwnaEiJzTKcmiavrDodZqk56xfxpH7na6bVJRXKflYmCdf
 FsfsIQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dje1e16yh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:22:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d812c898cso195383691cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 16:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776295361; x=1776900161;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iT4ySHxd8iMiHVjfS/Pg8NfDAUzunyhUM2tZEku061M=;
 b=IWmVxveEU53+D775jy8kuU3pE8vJfCOpGqvU0qsGrKfxy6Gxe/dwIDMVZF4WhV3o0d
 M4JNl+86u+0zAOTnYeVLQTTSYjCg/OIwxDnnHObRV9z5e98dvtt7MybmMospKaSCa6Z0
 7bS3wQaoEj3XIov/khXjL9a++9tzwWtIVdleAtVpPoPYsoYTw1fpgWb/bYv2amm4kqhZ
 BfPEMsYgN7WOWjP5StyfHZHaKzHC9qR7clX27OjYGjFuSH/AiO3fEO5Ni5f9DWAYWJH2
 3xeis9paJh+sVT0m/gqCHgzTFuvk56GkKnRifu84wMnUziUos24PggPHj4Cyh7cPCBWv
 1kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776295361; x=1776900161;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iT4ySHxd8iMiHVjfS/Pg8NfDAUzunyhUM2tZEku061M=;
 b=O1eUmQG/RFWTMkuwvJHl+8qCt5jBtR9mY1UwkBUOKph+1/gi90rkES2FgooOEl48cg
 8ZxXmCop0On59l8PO+x5rbXJ65WF7qNsZdNbddtO5bVJ2cABdCKFPf4SX0zju9VEqTpn
 BBV1L7p+AXINNTuSaj57EQeWad1suJRV78yL4M9MwOmqxsFueie15m//h9py7/t67S3A
 GGAxKefSxeLMdkx8k8k8Q3y8heqY8R5uzvs48p5mEYO6XWv8eUpFra2b24HXZ2XzirKK
 K4rSQl8GZb+FqZXOT3fRopdHCGfgAHW6GaI7qbTH1Qz0S+bObtkTxwlcse1S956jfS+M
 frNw==
X-Gm-Message-State: AOJu0Yykok+ZkkTP6rvDO6FZhCw/qqrslDc971ECTYQxlxietkBpVIln
 pYI9h0QDaXsK43qnvTDSZ5WcL0+TnjohZ0Z1iyXE/47qpvlO2ogNhrtIz6SQxKX938KZ9Y3BsJ0
 g7nhnyGOXGvTAq4HBtKevJ2s6iEI+SGQLz3r0GsHta7YJB2EkdgrdjW5RY9lvOYGzeFw3UEtWBw
 Sj+oU=
X-Gm-Gg: AeBDiet+OhTX2MdOHH8D2xL8vDZgPl9KkC9LcK98LB7qkbqumuMrN9xPBdN+apaQl2j
 8boq4hqS4C5ddNPLDUH6hu9LRGf3u8/oau5s4uxhjraZe6VXC3mHdHczKJrhSoM21mtfq7BGl3P
 Q6lsuctI2OLw61KVt2MLycY9BNg/i26e/2i/DKAfT6z0vjPAEXahujpjrFB+MY4L4fjlB4z+Bpb
 EFR1wcH/zmsVkUFwyb5SAMchICGn3fFMFxnbCCt8PnqkyGbo1EZihz3/bRmshuwSFP1EZHBFasB
 zH1+Z0y6puRFxgtsgw5oM51kGEV/sfHPHXzKWEDBXzcthkG2ohBugVbaufnxak2Ztw1bDryEb0V
 8tMqkiqCF3ASUuhE4zzLgfmQmjFTo+oavveR0xUDNLfWG7+OAjBBs/0bvITBHHM7tGlfYuxbSRw
 O+FedIkUGsV57EGDKgisZZnbKxACHoPWCPVEirHMcR13nDQA==
X-Received: by 2002:a05:622a:13cd:b0:50d:c0c9:c985 with SMTP id
 d75a77b69052e-50dd5b30efcmr356728641cf.2.1776295360529; 
 Wed, 15 Apr 2026 16:22:40 -0700 (PDT)
X-Received: by 2002:a05:622a:13cd:b0:50d:c0c9:c985 with SMTP id
 d75a77b69052e-50dd5b30efcmr356728031cf.2.1776295359994; 
 Wed, 15 Apr 2026 16:22:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a40a272852sm817054e87.10.2026.04.15.16.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 16:22:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 02:22:32 +0300
Subject: [PATCH 1/6] drm/connector: report IRQ_HPD events to
 drm_connector_oob_hotplug_event()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-hpd-irq-events-v1-1-1ab1f1cfb2b2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4349;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=J3Awa0W9x47e9VDImgKb//FhRzSC+4krtGr/Wy12gno=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+YD2Z0/KxXy+84z8JxSP2aQ1M3eUcvU9ilBtXjR/aqj+
 2Z3LuboZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEegXY/0d62BYrmU3n/7zq
 w+ajokINzO7HGphf9f7u+KVYY9GZPPPd+dPrFkd72JYIiEYv+Cgyof3QC9HYhe8y7N7v8o55f8f
 3X2Ke4BGewnim+rd2rxrcf07ba/hJLfSBAqcl671TPhwNIbvfN0euXzJFsjR5bzDT9YdzJh+Ym/
 DrT8lMr/j1XxkOpW5ULS/5e7N5VoX432Vz5+0VLIppu617LG7ZrHzlp8d/Zss9j9FTmRRq5zq/c
 aVoRAqT3bZowYyZno1Hlf17Mu6zn+s/mVhZfvShDm/vs2P85XszgkUDjLKetR15xhyY5ufn1Hkv
 c23zbjeWi9birs2+dzzKg7olbd5uy6nRu3vQ1+Tx4h1/AA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=HZwkiCE8 c=1 sm=1 tr=0 ts=69e01dc1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=TP8XqTAxF71JeV6NEI0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDIxOSBTYWx0ZWRfXxLuyUcod+F+r
 2FuSoMCSCcwy8KKJMyXGYG2N5jkFdFmgKj7qwq+++OFMqx2cBt/MkfZOpBnSydLyNrdeYQpsv5k
 4uDS0Yz3dOQl2quyrUo7La+LaFMvpG+MOEg66TCUTAvho+p6TjvKmKByKNiiGZmi1N5IjrMPCwy
 /5JhNJL+hjcZsPqDrMqa5J6mImj4IV6OFEL7qtQysXVeiLZi5GIWhTAaxoTrkzgMXKksl/oBdGX
 uLabl453C2iXy9J48R/9EWVin2+2LN5wgO3CCfQ7fQu+X7lgL0n+woy9ai7i5TlwLC3+cUOYfdz
 oPtJaf8s6kyz5ogd6Oeq35vHtNkbj0z+yDlbKaLOFlZajdy3mPjMIk/fkiHKwfPNT2cekCSA1Ef
 OODCsPp/sAsm8Ry+3aq+xmYZRt4oQzqEeqYAWyaRAYcRRLBKjmHRxMIuq35Kif8OiubwCJra2Em
 fp+iVIxVzOely4DLsQw==
X-Proofpoint-ORIG-GUID: sLFSL8sX5XaN0Wf-PalXneIUj2OBBRBZ
X-Proofpoint-GUID: sLFSL8sX5XaN0Wf-PalXneIUj2OBBRBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
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
 drivers/gpu/drm/drm_connector.c          |  4 +++-
 drivers/usb/typec/altmodes/displayport.c | 12 ++++++++----
 include/drm/drm_connector.h              |  3 ++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 47dc53c4a738..5fdacbd84bd7 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3510,6 +3510,7 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
  * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
  * @connector_fwnode: fwnode_handle to report the event on
  * @status: hot plug detect logical state
+ * @irq_hpd: HPD pulse detected
  *
  * On some hardware a hotplug event notification may come from outside the display
  * driver / device. An example of this is some USB Type-C setups where the hardware
@@ -3520,7 +3521,8 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
  * a drm_connector reference through calling drm_connector_find_by_fwnode().
  */
 void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
-				     enum drm_connector_status status)
+				     enum drm_connector_status status,
+				     bool irq_hpd)
 {
 	struct drm_connector *connector;
 
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 35d9c3086990..0cade62da905 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -189,7 +189,8 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
 	} else {
 		drm_connector_oob_hotplug_event(dp->connector_fwnode,
 						hpd ? connector_status_connected :
-						      connector_status_disconnected);
+						      connector_status_disconnected,
+						hpd && irq_hpd);
 		dp->hpd = hpd;
 		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 		if (hpd && irq_hpd) {
@@ -212,7 +213,8 @@ static int dp_altmode_configured(struct dp_altmode *dp)
 	 */
 	if (dp->pending_hpd) {
 		drm_connector_oob_hotplug_event(dp->connector_fwnode,
-						connector_status_connected);
+						connector_status_connected,
+						dp->pending_irq_hpd);
 		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 		dp->pending_hpd = false;
 		if (dp->pending_irq_hpd) {
@@ -397,7 +399,8 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 			dp->data.conf = 0;
 			if (dp->hpd) {
 				drm_connector_oob_hotplug_event(dp->connector_fwnode,
-								connector_status_disconnected);
+								connector_status_disconnected,
+								false);
 				dp->hpd = false;
 				sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 			}
@@ -827,7 +830,8 @@ void dp_altmode_remove(struct typec_altmode *alt)
 
 	if (dp->connector_fwnode) {
 		drm_connector_oob_hotplug_event(dp->connector_fwnode,
-						connector_status_disconnected);
+						connector_status_disconnected,
+						false);
 
 		fwnode_handle_put(dp->connector_fwnode);
 	}
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f83f28cae207..e8e7e6c9eb5c 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2521,7 +2521,8 @@ drm_connector_is_unregistered(struct drm_connector *connector)
 }
 
 void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
-				     enum drm_connector_status status);
+				     enum drm_connector_status status,
+				     bool irq_hpd);
 const char *drm_get_connector_type_name(unsigned int connector_type);
 const char *drm_get_connector_status_name(enum drm_connector_status status);
 const char *drm_get_subpixel_order_name(enum subpixel_order order);

-- 
2.47.3

