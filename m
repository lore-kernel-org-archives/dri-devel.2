Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40361606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j7zzZ9PD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DtR8qFPp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584AD11215D;
	Thu, 19 Nov 2026 08:26:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD51112179
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6wK0K1007323
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y4rHtjcLoEgHmTrIQMGqgohiSxebHUZsCfl7SswHqEc=; b=j7zzZ9PD1VQA0Ed8
 pPMQmJnYDtKptd1xQvebwue/yI8DyMX3NafLoMWsyUWLVzgy3+WAVAGa0g1C/XyN
 iDXbj28EyInn6PFCSPusH8N/M0s25nE76OWOBMa4y1PCKrgRCuDE4jq3URANolKd
 fERoI+dvMYvTirfcHMTnAh/VyLJgo2sJ/kqG8zzFIdpHx8sjmmGH0dd2rdIJ/hL5
 Wn+saNCr8rh+0BaJTwT2clDuOm6V9PEjNpV5U48ZdVo8UYzqHal2NBbh0C8l6+Gw
 kIh2GFyJl1gMDgWvNjL46f54gjOL/YuXOF/HO5KmFHPxX9Mo4Sk6bXfx4cOL8vRy
 NYW7Fw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1etnusjt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f6f4fe531so323102085a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076767; x=1795681567;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y4rHtjcLoEgHmTrIQMGqgohiSxebHUZsCfl7SswHqEc=;
 b=DtR8qFPpZedmCKghzYYHgb0WEaYv3a21i894+QJUqBNfr1XNgK3nM059whHgQPoKoW
 dMOog6mHwvUAvzDBuqCGArBvG1jTwqhM+5U6BZE58seJNIpzsJBRbN9/4mEawOwUqIc1
 eQT10glksxHOBrEuJO8HmC2/j+DHs6yTI49uiEocj/GKaJmBlvTVRf/THs97zvWBPVIj
 qbXkE5geNV98vpZ54/iEzBWo7U+88lQeo7Og3W8SoJHh19mOb4EFRO6A6S5JDpCBgwij
 HzGlxr+karLJYPOTFZkzGb3mLb5f9vR+txPAip/9uIP+q+MX6qnbxIJSfkLTi/Ov1QwN
 K2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076767; x=1795681567;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y4rHtjcLoEgHmTrIQMGqgohiSxebHUZsCfl7SswHqEc=;
 b=DB3QE8QfJqfbn6oUnfubDhjxQa3pJPe6AT9e0T2yK8MMyTpBruduPxRik/lfT+D+Rl
 9wcexNg3hcVZCjRmVoLw/pj3U3ri0W/Xq66vUNTqDUvyZ6uYhNMyThTJHG1pSLS/16xb
 KwzTKnYaifLdMFF6U1C8wkRm5mPDMbj61r6mDCUWZUgzyW9zcV7SSfPbsy2I63tWPSLQ
 nHlsPyRAvOVk9r830GXnUEYM8dlegAf1PcsA2PhvKjBs5qhxn2zNO354nYhTRW9yl/Or
 sf8EhGe+WK5DLVyiUmY9QkDdLr8jCXyq62zBsi/ZKuC+Ip93mYbK+pz7861eLI2MlYKy
 X3fA==
X-Forwarded-Encrypted: i=1;
 AL+hErF3aSSQbF1hllIhOGUlYovbe3rYtj/FaP1so70DCMmvArfMkAwqPTWETwPTwKNGuMwyc2kzMA/WLAU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+OSc38xv4zsg/Q33vtCfiu7eYbUpVGal6SwNkHOK+Ojq//80rV
 rFLe0jQ55vuVBfNR095DMETnFcqtDI0cMP/ZzMLOmkG9ihQf6Sp9I7vcSGmg8P5WQdVaaMbWgVx
 OW03gzbEq27mca78WCjXY8hY+kDCPwxKIkeULbOHuUm32nB75Kx0zg90MH6DgTan4T8kzr7A=
X-Gm-Gg: AYBFou0VZDdNxWaIFfplbaDAJb23fNfNLrEBM6QpwkP6l/RP9YWmcZIgoqFIp23Zeaw
 fRfdpMdFhIYKW5KIdtLI+mNb9A2GVXbch15SyOYm9exoxy4C1f5TYVCQ0fb+gYyQDFLabiIh/Rb
 0tL/MFXENRVOG4L2CniPRu2K3NVSZrKP8e20afMlHcQUCZoGJnqbeKLWtxSxnOmV2Ma60+v41TF
 UDvTiej77xwZ6d+mQLEv5M7cTZVi2tqJ4AY4T+ZdOmX9YJZflNnyAE6/DTfPjHiVb+t2we3gJ2W
 3gobl7upCPSD40tfN72bpv70GCvo3fvtqxR/NmGk7tm0pmWFh/U85FQz7oMTD5EHz6IVtlkIaJc
 +YXSVHqvPEk9aRqrEBejhlIg3Detcu56B9xeEU2pFc0yZYE0/GyvgP9gb1QUOgzqDPU+P5bWhbF
 gpjgYvFBE7criHWqC7Y72CQn1p8knPQVKDsWaz
X-Received: by 2002:a05:620a:8086:b0:945:d852:1618 with SMTP id
 af79cd13be357-949997b027dmr874903285a.70.1795076767457; 
 Thu, 19 Nov 2026 00:26:07 -0800 (PST)
X-Received: by 2002:a05:620a:8086:b0:945:d852:1618 with SMTP id
 af79cd13be357-949997b027dmr874901885a.70.1795076766978; 
 Thu, 19 Nov 2026 00:26:06 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:26:06 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:21 +0800
Subject: [PATCH v9 19/29] drm/bridge_connector: suppress hotplug for
 IRQ_HPD without status changes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-19-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=2989;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=kGM6WlVxmPmHaLD/xSO0chVTuHvRgAil4JXoPE4JTA8=;
 b=QyGEOnbfqUEyh4z4URkbSIR1JBEwHjBBZvQHuAxvag3MSPjsw+ttQQZg7TVpKjLt45fiq4gWt
 hB1iMfZJtsZA5TlDwUjQdzMrZzPaSxRO9FdJL92CuzuHxLnFJZ95efS
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=b8UncdGx c=1 sm=1 tr=0 ts=6afeb2a0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XU51oE-CMt0mn-qX91oA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: RUYp2DodIxGZFt1X6m3Rcp1VKkbCq0St
X-Proofpoint-ORIG-GUID: RUYp2DodIxGZFt1X6m3Rcp1VKkbCq0St
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX8YIeLJIVnBjG
 ENtZAalvWn9LjkZHitOi8d7w3iHcrgG9TeZAZKognJJC6UUMmwgbO5WBW4TTqPrJwfWa/uW9i09
 4rLJ+bLy5ehkY0dgthBRiawJ2O4XDTk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX5CKJScVtYRa6
 m2c/AbMXUuIgnDqXEDi9o+Kdm+RzQVHeuFK9HTMFkDCvlMU9/iocVO98R3n2hxRHIhmmTHkY6jB
 K6wCjNxcOPyuHAgj/CJhcO52xv4ZddRJEFyYj3DUbp1FCi+84pny6PQSTLy+O0Pp79WpqL31MHq
 QTZcEtYf0u6E3X3qz1wX+EOgArOdwpNlDKbZVJqAIs1rgEnEXstwBjg8q14xShVGa+L44BXbbKQ
 VWgFv9sY77ST/7lDDpLplfMJ+En1pwxPuJ3rnuJZZ2aYoV9R6KbJqK/TRMuXr7hpBw6+6ljBOhd
 bHopbjW6UHU7O12CmmmCv6gf8a3GjXEmOJSN+RkKMzsjdELfSOOuHQl3fsriAdFIpp05IS3Ht6n
 N6c6ZWDipVsvkwl02fqV1C2HT92PWy/KHGXvrJekHSyVqohIkwYW8DMXHJ7EljIn3wjJrA6TWOB
 BXEEH6PklGvYpCb0/Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
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

DP IRQ_HPD does not necessarily indicate a display connection change.
It can also signal link status changes or pending MST messages, which
need bridge-side handling but do not necessarily require userspace to
reprobe the connector.

Currently, the HPD handler sends a hotplug event for every notification,
without distinguishing ordinary HPD from IRQ_HPD. This causes IRQ_HPD
notifications with no connection change to trigger unnecessary connector
reprobes.

However, filtering out all IRQ_HPD notifications would also discard
hotplug events for downstream display connection changes on a DP branch,
where upstream HPD can remain asserted. The decision therefore needs to
use the actual connector status after handling the notification, rather
than the raw HPD status reported by the event.

Pass the event to the bridge chain first, then call the bridge .detect()
callback to update connector->status. Fall back to the reported status
when no .detect() callback is available. For IRQ_HPD, send a hotplug event
only when the connector status changes, suppressing IRQ-only notifications
while preserving notifications for downstream connection changes.

Keep hotplug events unconditional for ordinary HPD notifications. An
earlier detect may already have updated the connection status before
subsequent plug handling reads the EDID, so a reprobe is still needed.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 4ade63306653..1d4502126bff 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -160,15 +160,25 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
 					    enum drm_connector_dp_event event)
 {
 	struct drm_connector *connector = &drm_bridge_connector->base;
+	struct drm_bridge *detect = drm_bridge_connector->bridge_detect;
 	struct drm_device *dev = connector->dev;
+	enum drm_connector_status old_status, new_status;
+	bool level_hpd;
+	bool changed;
 
-	mutex_lock(&dev->mode_config.mutex);
-	connector->status = status;
-	mutex_unlock(&dev->mode_config.mutex);
+	level_hpd = event == DRM_CONNECTOR_NO_EXTRA_STATUS;
 
 	drm_bridge_connector_hpd_notify(connector, status, event);
 
-	drm_kms_helper_connector_hotplug_event(connector);
+	mutex_lock(&dev->mode_config.mutex);
+	old_status = connector->status;
+	new_status = detect ? detect->funcs->detect(detect, connector) : status;
+	connector->status = new_status;
+	changed = new_status != old_status;
+	mutex_unlock(&dev->mode_config.mutex);
+
+	if (changed || level_hpd)
+		drm_kms_helper_connector_hotplug_event(connector);
 }
 
 static void drm_bridge_connector_hpd_cb(void *cb_data,

-- 
2.43.0

