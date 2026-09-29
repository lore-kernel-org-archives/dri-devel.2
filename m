Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7425CCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA5110ECB2;
	Tue, 29 Sep 2026 04:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="G1FcWL3L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P4+oXdF9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1CA10ECAB
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:27 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47Z9M2775351
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oY0q5XC0pkiZTt3/6qdFj9UfGA4NLUgl/6Lw3RihIkc=; b=G1FcWL3LUzMF6QQq
 ShYzlXluMhTr1R6X/1x9xtbsXocuC4HMfp3TMEItPOEDASJoECu5C9hsdq1cuHg2
 OaU2wWss7tXQBk6c74Rm/Y4qy+UMeCBS90dTLoNkGi8/7CTF57DZyI/HIkk5lDyB
 frsZBRQD6JbczioLw6yEf6WxXmMlfVhkDd7D/F0zpwnXw76HQzg4zXTUB2a0YFcl
 TtBd03EQs+As8vbXEn8kCoSLjl+Jhb6EF3mhHzfEdeZh4wGtY+d8RHgItaq5QQga
 TfXFKoD0W5LCmkDtyiARpZxcPesKEnuKNgmf1BoZDvtBtqcZstTo9m3M8h7yZuve
 3UVF0g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw224ca-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-915e6c351f3so30826686d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656105; x=1791260905;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oY0q5XC0pkiZTt3/6qdFj9UfGA4NLUgl/6Lw3RihIkc=;
 b=P4+oXdF90RBj9QeYY4p1kl6suixW9jiSYZFj8WgMCMBLwn4Ac4VmvdqgvAABhMu6FR
 AWx+Kw98bPXR/XHAmbmG2xEizJ0ul4fGlNE6a0tEw0WxtEeIjgD3RfTB9Ssl3nSV8O7o
 BVsSNQxpigFVGHB8olBc0xUu6uqWGKoTT5MxLDmnRhlIRno6/r6Uyvy1EyV2dQx5aj88
 qh9J5VuRM+fTnb9L9795vz0y4NEFryJdUWDZZ3wZ7xYmLoEyDCobHvX9m4OqOUfNKBD9
 OnYUfOgLHdXEpxSqK6b9ZBQKh202QPb5H5fEad+enFhwIOGBH0fYYRHjgVW+mfLBGuEA
 Dg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656105; x=1791260905;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oY0q5XC0pkiZTt3/6qdFj9UfGA4NLUgl/6Lw3RihIkc=;
 b=KLOo4bG9iOuz/dJzHuvQ+sgQDrbPnmXsQMTGJJmKmYI12kTnGIz/NAOvmdZOzojL3b
 nrAkmgvsLGtCsG60HqhPcLH7pz5guQ+OcENvGc1AQ4k4muqi2i01KSfJN64y/CMJ0NB2
 gjeFzYVdmaK9EQsQ+JG7nrNtwiT6uuLawhm0kg27er4Fi0e9E6xYivJd+C/29bmexxb0
 Avw+qVOYFyEAQJmn7eStRN1AgjPNTxteeFFVLrlFZvCEJWi5QDIUdyodz7sR/8DkMXEb
 4W/amv+/6XbfhOWyCRvpafLeZRZ1oJ7KYtS0ipnQxzKs4HC9GYIyRv7APSbvqzmAzCSQ
 g+YQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzt4sjEwRCIEaB4jIBtc9CTYkvTTIA+euU2Yc2f/djGgsITSa3kXUeBEJqcBhcIuztQpevPDQPhBxQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++klTwC8QmXhLpQf9W+ESvVQ9CBgttvb9gmDVhORUXKdsZZIM0O6
 wa7EFFK3rx9rhgnBJ1Zas3C2P6Mgs/7lPIy1fOtVjAatI0D6AItEbbRDcaD2CxkAP/QKlkqqxkG
 C08jf+MQ2LOth/k98SyiLJoYaE01eSeFDIjhHbHgBl/w3XVQh1LC9dacCIraDNWmQfbE22MI=
X-Gm-Gg: AYBFou3mFxImgss/pPR68lH4ff7//Ejwl+et6rklXuExvbDKP+fKEvRCJQT1Xc9KUrR
 qr4IdeuMWdEcY6SQ065kKHe5VRrZNdPPs1M+9O0SHHC2QjIJzZNs9BgPru9PIdcsOL8hkM8cUg0
 OTdnYQErpYM2I/BL6YPFHkp+JhZ5PiPgxFl5pi1pjMxrvgzbqsiyZyDYL7FQhvUcYZqalnrdj8t
 8KplSWCK1bjhhuNP6l1J96NY0kbDbwmeKVPo8t2Sulqj96O+Zg+wAULCAbk+I+8nq9PJKzFaD6C
 isggt14qij/tO/YJu7R8wBVH8KOwmoyB8suYqMyi4kthjLMkB7Bsql1K/WVkvn1fm04iwzJ0VBQ
 y0piOXYYN2DDcY+gH6BJfFIxul+fDA4Jh7Quwq44Vz2rYNRHuTkR4GkCITHDJ384=
X-Received: by 2002:a05:6214:5345:b0:912:517b:8f9 with SMTP id
 6a1803df08f44-9142f961a9emr247433536d6.43.1790656105438; 
 Mon, 28 Sep 2026 21:28:25 -0700 (PDT)
X-Received: by 2002:a05:6214:5345:b0:912:517b:8f9 with SMTP id
 6a1803df08f44-9142f961a9emr247433326d6.43.1790656104895; 
 Mon, 28 Sep 2026 21:28:24 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:28:24 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:49 +0800
Subject: [PATCH v7 25/35] drm/bridge_connector: suppress hotplug for
 IRQ_HPD without status changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-25-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=2991;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=CLbVVBYelNsj8sdE7+NVQ8dLNUaav0lNbJrTunVQ/Ew=;
 b=A0b+oBrA0/U/ti9lb6u9TS+Eh3+rRxrFXVCwDgyk2OouZVBR6YzUksss304F1pK4XUt0HPdnK
 Ik6bnZJZ/IuAYsRyEu3im0021tTAqeR4Um/eGzupa5Slnufy2rvYzZe
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abb3e6a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XU51oE-CMt0mn-qX91oA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: YaxgE3AiuVlzj_DSjjI9mXWcdOzXQ-Ei
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXz1o5YtMqVEfQ
 YRkUQZPYspxkGH4Ivu+XHUkyjQDwz7bFbphhWDKF9IBq91fu9hUP0YJBQkzaWPqXPqiV3Le81Ci
 Rb2sXmHXIoiaod1h2q/4Vqa4XOLWDOPnNNz6zIezhjL7PSydeMxUY669EJgoXoQbW7XFr8pYmFx
 /xRVNEDXU6Yp0y+U8DatS31V8nR/iu9lS/Pk6ywBO449dvbw7MmqHhdSn8mv2eUwO0U/OKM1h8D
 NyhegSfNMZEAVKg+t7iXuBe5HuHVYWFB8+waz5aIIIZU/iftpO1XI0xh7nHNLguoXh6kPbXJn/E
 jYK5r4XpbqNcFlQskT4PYrD11o0fTUGYbE9UZEAQOEBi4+xWRSF/xnhF+5GswY3167PPCy5JvaO
 Nd8MWqAQJjgV4jonvKOuqu6zKj+ICypQmF7LRUN9+qnkAdnyt0uo/RPOQA3TUj3I/NlYDXO/N7O
 xq0XkSPHHeoiEm+NzOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXww+HOpU5w4tp
 eRKN1waCQmSu35LLcIkGY/sQfk0fE4IKrEJtLIJquWQlVuBpcBRB2Ve7HbJk5SrN8r7lEQ5s8ta
 MCo2inYdmbDdNoE6j8NpM5Q1WU+UZoY=
X-Proofpoint-GUID: YaxgE3AiuVlzj_DSjjI9mXWcdOzXQ-Ei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
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
 drivers/gpu/drm/display/drm_bridge_connector.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 083d70017f02..d27ce59ca32b 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -159,15 +159,28 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
 					    enum drm_connector_dp_event event)
 {
 	struct drm_connector *connector = &drm_bridge_connector->base;
+	struct drm_bridge *detect = drm_bridge_connector->bridge_detect;
 	struct drm_device *dev = connector->dev;
+	enum drm_connector_status old_status, new_status;
+	bool level_hpd;
+	bool changed;
+
+	level_hpd = event == DRM_CONNECTOR_NO_EXTRA_STATUS;
 
 	mutex_lock(&dev->mode_config.mutex);
-	connector->status = status;
+	old_status = connector->status;
 	mutex_unlock(&dev->mode_config.mutex);
 
 	drm_bridge_connector_hpd_notify(connector, status, event);
 
-	drm_kms_helper_connector_hotplug_event(connector);
+	mutex_lock(&dev->mode_config.mutex);
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

