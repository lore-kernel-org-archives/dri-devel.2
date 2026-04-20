Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B02F588EA
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC6F10E6C1;
	Mon, 20 Apr 2026 15:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lUIbGvQZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XsdXYr4d";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0139C10E6B3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:31:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63K9J4Nf785491
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lUxjcmVB1mry2JFOZUVE65+ZJk/cVp6zUgik6yCWYSo=; b=lUIbGvQZ5qpNp4Gr
 QY6vrMBwk+A6tYOPjjoOHnbdSdN3EyYfSEgfbOzFlvu/aTF87y02bKmkxi3fhzyp
 ZLqsTfOcH7bUoEfoDkeQdsfcrL/2WeOKCs5wzHFizkFr1jcHuW/DkpzDvgs8D8TL
 m2KsoVMlz7UD+hSPF9Sjown2QTRx03z8jYu7KvlbH5Rqm6hn6lViKzI4O1Pl8sDG
 o1MP1usTGTfAD5l5lQuVBoCYh8k2z37Wbhvz6YbAXZy6BsuSJ6EDfL7lQ5RZP1Nr
 yu0VyVqqrDy56UkKqn36L/WUrK0SoUC0KJzEM78z0PIC2Y+hZ+8s4m24sKJIanIh
 Wnoe6w==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnhdhhatb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:31:46 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-467e00b684eso3794027b6e.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776699105; x=1777303905;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lUxjcmVB1mry2JFOZUVE65+ZJk/cVp6zUgik6yCWYSo=;
 b=XsdXYr4d+WhUV6qw8jThq8i5CxtjhV4ay4CVKNqGO/29A3iVE11ZptdNxhpyVT63b4
 QiOg0rCOfv9mJZaO2N4f3gscmMJgvpOjXbfqyoFpnk5NZO1mz2TD5w6M89M3pFAvL1jA
 w6y1Ajk6xiO1U+eu170KMXnboVKK0sIpCo/1Y2+4pywOmBpNT5lKVhox0zi+XoM58WlX
 8Icbc5RZE+T0IO8uR6fAw1EDBrvfvudQOT1Whbw29USIJ/GUblcrtIMYtGkVcK5BSlTk
 ziqsmvJKQcTbvAAr5B1mHJBPpffczBIw3m8Zcu5i2gLoTY9GVB+ELIAUc6eGh8V/4Y1b
 /5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776699105; x=1777303905;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lUxjcmVB1mry2JFOZUVE65+ZJk/cVp6zUgik6yCWYSo=;
 b=SI4IrRDVRrKwAxTa5Fi5GsaFN/s43AKuBQuZL27/J106cE93k8/GaQK/JQg3C4zzej
 2dyGvyT3Uvz6FR593NEXCAm39ayKAEVoT1eDJ3cyl3FgMKNlV0K+0GbhkymZKHp7hLrh
 LX0gMi/5O3wvtS39iFSfqYk7C8GkqGHn3auOBluMRjgUviC2glz53ZPKWng+9tdkkesy
 SHpiWu2LSnQe1UimrjkLD5+G5deYBCNwZoe92qzU8qtg84GUMEomn7RdlT5crytOboUy
 3LuIZCA079xGCw6hvoDn0/ctEc/rvhp69DUfKZt7r0u5fE7komgopZnEMAl9F9TO6LlD
 3LQA==
X-Gm-Message-State: AOJu0Yy0ThcOmf67mgWDlaWYnA2mtWgZObSue78XXeNc+Vrykc7qJWin
 gEoH8/bv4wKpGR/En/bsQLisqAkrhuSAFopxxyxVbxlzBZ5kqmY1XN/Nkzh8svZaCPbLg6zFxqu
 7RlYQZxxRYITGFdo8aEO/YhRUf9mjyacOYvGIR1Axv35moN8+uMnWn5NhErWAI4zc6mr5ksg=
X-Gm-Gg: AeBDietsC9HWynBNqiNSpyy+Hc3Mu5PPuZHC+8SkNf3N8xJ2v0iqelbFW+zUt5ZBjDO
 hIdf1Dir0jYRsCPLVSKo6CbLVjetsODaa9jsxjEJju9TtzMHXSQ9GGDxt0S5Ql4jnR+d1TUo1SU
 vDxZ2kVDSZOqC90ahba/7pTvOznxr4r8xeifVk4H1vKMUPJvDxualZ2anrh9c2NYulaqjr/lO3D
 Enx/LvxfsZhZTJveuvYVtYYfPDXjrLJvxVTJms8Fnv0uSJ6MQhETXKgnU9bEWBc5zfYos0XvdIy
 Gj2J+3y9s28u/TsWqTqxI9MJ6u1mqOxo56qtq1w2NLxho75AR3Wf9pjhoH2JTOBfyWqZgmBd3Mg
 vDanpiLgjrK4IJwXp4oph0ZcXPXXB/O7g/3Vi7yAeiVdOA9p/yKJghAIMqvH8TCqJQIm3fzhOVs
 hZbVHKUnE4hvyz1JWuPwf7dqeRdBJcxCFj31qgun+q6zlxFw==
X-Received: by 2002:a05:6808:2448:b0:467:db23:25c with SMTP id
 5614622812f47-4799ca83a59mr7243572b6e.46.1776699105165; 
 Mon, 20 Apr 2026 08:31:45 -0700 (PDT)
X-Received: by 2002:a05:6808:2448:b0:467:db23:25c with SMTP id
 5614622812f47-4799ca83a59mr7243507b6e.46.1776699104557; 
 Mon, 20 Apr 2026 08:31:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc31dsm3071171e87.22.2026.04.20.08.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 08:31:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 18:31:39 +0300
Subject: [PATCH v2 1/6] drm/connector: report IRQ_HPD events to
 drm_connector_oob_hotplug_event()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-hpd-irq-events-v2-1-402ffe27e9e9@oss.qualcomm.com>
References: <20260420-hpd-irq-events-v2-0-402ffe27e9e9@oss.qualcomm.com>
In-Reply-To: <20260420-hpd-irq-events-v2-0-402ffe27e9e9@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp5kbc/UNMXpIQgQu+RMvj2dYIBCbr7675k+ZbB
 1bJy3KI4xuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaeZG3AAKCRCLPIo+Aiko
 1ZEhB/40fMwfOsuT8UnELg06dXKJmgx9BwjiERV+6ig4vkQlD1N3pMzFrTpR7ZV19GcfER4uBAb
 mhH1u4t1lQPCH/rYzpC8djiuPi598d6eQCICO45jiYBrWW2m/5hWcc1ACFO6LwpEJNAMZS9AJTE
 j+Zl4yyKkFLCFRwPOIKR88dQp2S5TYCbs9dHrEQPeNXrhvp3LouEZ6NXq0xRvDGczDb4zKk4GNc
 a4TA9/WzbbmISLLs1bNG76+FGXHvATVLYt+Q/LC+/CBuA1b4WSZzkymfPFtaT3QUMDhR2DHmk9D
 4iKNimC7DYMtYIj+iG+/H2jJk00Ad7W3ys+v2IZuw5LMMjFa
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: hzI298x2SCP0uQSP_AUyw1Mm4taoMLwY
X-Authority-Analysis: v=2.4 cv=IMgyzAvG c=1 sm=1 tr=0 ts=69e646e2 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=-JEBqWJC5KD3P7x9m9UA:9 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: hzI298x2SCP0uQSP_AUyw1Mm4taoMLwY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE1MSBTYWx0ZWRfX2S6gSXAVJ8AY
 6VwKMXT2eZ7P+0DgouoVKKgZtBPCqbkNEcAYd5vKtTcIAN5fC3K3Gddj/wWYtYSDZTPYdepZiYi
 YYJzKxpUFX6rMOunZ7m76la8AQNh6wq/2N1okMAsCzM2RA/wt+BXMF6vPkNJmlZDudtSjfYQ2vG
 n8iR1JiJIwNdSMHkPcJvyR6ScSOBBSe20D6mQe1FK7zgdPW8RwXHABIpS6+vnHdx0dZYTiC9f+9
 JdD6IHJXmDFNtaqZ8kSsdnuAPa3XXk+ujHpJZ+OSJO8/0OjsVYjPHjzIuex/VNEhEyE8A84tuDq
 xqfzOg+DIlnQ8bJtoXG3idFi00Gw730HtC0U0PLdD1OAyXirTm51v3dt2ag2yyPuuEd+qlxaZXF
 IpbvCaFTan2zZhJ7JhfJBW1bmUjIinp2dHBW8UpVuAmWWAVMOustMj+feBKeVKFGZ8ticu2I8+/
 JEZtmoWCGCvUGMjnmGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200151
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

