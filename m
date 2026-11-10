Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269D160A3806
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YHR3wYzQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b/Wdord4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5312C10EDA7;
	Tue, 10 Nov 2026 04:56:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6746910EDC5
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A8CI1957693
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y4rHtjcLoEgHmTrIQMGqgohiSxebHUZsCfl7SswHqEc=; b=YHR3wYzQSEvp8hiq
 8+pZd/VLF32qWUtiQZwP76usI6A2RbG5YNx1DvUlbA3aZtXbs+pP31dwh6e8lA+Q
 Zt+c13J6GDnb5ZSwyYBYNXSRg1OnyKx0wk+s83brmvIMS1mhnpLx0NkxY23pY2ax
 LIG5cPfV4DoyGLcvia75UQGkT88JyJwFM3M5hmu/UkaGEBTOrYMNvgqAboRakjHv
 yAaP6qt9lgpVtarKOmNZC+j08TsUocIq/RH4TiWRX4BD6Wgz5nZ9j/j2BUCMVniQ
 HWcnwACveZd8vt0NynrxLdPZvOQ28obWQLihFeuEnLVjW6JungUOGZnCEoNu/loM
 r85MXA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydknk7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844cb60so324648285a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286567; x=1794891367;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y4rHtjcLoEgHmTrIQMGqgohiSxebHUZsCfl7SswHqEc=;
 b=b/Wdord4YMcIF8mDRtahPnaalysFY37qYbgsy4HyTJo2dMcmfYsFydr16n9Awdj2Hb
 uvmXgEjFo+r8X1zj8Xi3GTliP6WqT3ACzLB1x2KrrlVhN7pfhc2EonewXvoTiylY+/dy
 /PJVta4wOGB9PUylxXYUrE6ScdItMCPcmM956Eeeo9q7K/7SkF18gXc/wuDNvnP7n9HZ
 CIwd+ab4KzQSRgW+uX57JVMsOMD11IHyiC9DFUsl+7hfMpmPcdt1lZd8ACGuBbCxOLh6
 6oJwA0mc502wBrkii4zKcomFkAkwpQ8C7ysDc3gkzmnZS22PoOnO+S449bJ4INZ7a+vZ
 RD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286567; x=1794891367;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y4rHtjcLoEgHmTrIQMGqgohiSxebHUZsCfl7SswHqEc=;
 b=Nux73ycVW4tD3H5vdxT7B6c3/2qAMjk4ws8DwrBnfpYvBmZRes8tSMTZ+FzqMHhAg8
 3COg+hN5a8LXJ06LaXs9dko5KkyfMR2nssX9pBGNZj9Q/Qe2l9RS8y59H9Owwa2RszsS
 urfupW6Rzlcmsofmv/fTSBQkiSQUEFx4MuiBdKCBZTXs0N2X7PWkI/hGqGJXUASys6JE
 J9Fhl6iWvyEbMlgQLhr7ZhZlRFVZk3JagRHTTaYtOvOJ5ZOo6B4Nts0PMu8H/BBSjypq
 AJj+4csYPZoBbNuZHEmMM502gzvL7SPmV0252qsgJRvE0n5vdLzUs9fSMZVXxBQz117i
 91+g==
X-Forwarded-Encrypted: i=1;
 AL+hErGsrbZWjWUDR94QUiCmn3Ydb53XUf5U2oDiXERcEzBUsnVMXk4BSC12olQTaqHUwvR+//eMqZXJTOM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9lB7wPKOkXjnC0De4Fz6YyqkxtADlBz3E55tbYcSb9OXxhThWH
 sIaR4jjzQN+Nt07Si1NRzRG77GxzvWnx4ntKhQccwH2YYJgSi3dbWVnDuWwRlpuDSw6pGP6XrT6
 +lNcA5QZ4oo9OEh5Q8E0oMrERmhm8jkSkRYGFZ1jGmTZZLAMMaxw/2LWTgVvNYEO9jz74LOk=
X-Gm-Gg: AYBFou22y6KuwH23G6GnOq/yE554T492VbbllSqlhr8meMdh/DapcAfvfPrnKtpqNf7
 yFNKfXG68WPOBhgCbNFgxR63J9BcZj0MpdRzcMa4tolxBbDmoROk3d3N9dyMqcIUxCAWiq9PD55
 BmUUSaCmEGlN7X5j+w18vpx9YNN8fOyGthDy5gJR+nZns7xgZdhb6A8uta648ii2BE5KZkbFtYX
 P2dUT7E/Gkzq24ITfs8VcZshxJYe4SzLMgs/DqIe1yeto+p0/eoOLAbdzDOHafN9Lv4s/qOX3Mh
 krRaZ8VfhPj/7NKLDTcBuNFfv9kn73PbrJYGQfR1pC5j/lP3ECClDOm0x/OfjwZO3U6eY3p/FWx
 xPp/3GblTKzc24gKjhLoDo144k9cT3TXEJ13pWuxuuGNp8ghfoVzlt5axuNwkPL908034xOi81H
 TQy+mUVVVbve+/gtm/41bDBkNCrFHiVJj08gfg
X-Received: by 2002:a05:620a:46a7:b0:93e:53db:d59e with SMTP id
 af79cd13be357-9479f1e8436mr256100185a.23.1794286567467; 
 Mon, 09 Nov 2026 20:56:07 -0800 (PST)
X-Received: by 2002:a05:620a:46a7:b0:93e:53db:d59e with SMTP id
 af79cd13be357-9479f1e8436mr256097185a.23.1794286566975; 
 Mon, 09 Nov 2026 20:56:06 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:56:06 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:40 +0800
Subject: [PATCH v8 19/29] drm/bridge_connector: suppress hotplug for
 IRQ_HPD without status changes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-19-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=2989;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=kGM6WlVxmPmHaLD/xSO0chVTuHvRgAil4JXoPE4JTA8=;
 b=8bc0gtObWWBr48PlvW73gguPpwsu+5HEpzjCr6F4hIY3Wfdk49PR5EXvKzOk87iwF0MiTJ4Y+
 o9xrx+nvqv+AufuLO2jgAimhjGFQ3I+/dnJOOyhmKUo0iR1u+9PJxET
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX5TIQLhox7Xyy
 PuThecLaopx9s7EV/7mkIx4agpPyuy8D6A+DKfNxwD60XehWNLrqQA14/kORKXGk7fSmrsaggPS
 pEA4ewvKIfebvKlCD68nfqpysYbjwLw=
X-Proofpoint-GUID: wHkbhjiOZDwCXwfd2mT9lNHszQl0Dmqh
X-Proofpoint-ORIG-GUID: wHkbhjiOZDwCXwfd2mT9lNHszQl0Dmqh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfXy0tC9GDcnfAW
 wVXHCpqH1yLesfMd5Je74qBhZNIR9v9dR+uxJmaLXzerijJvHDGUJOk0FrwApaa7FbGshBk/Msm
 NdUOY06brdGBstif5FOOSGLIQI6f0ms4bsM4Qm/h11HI/NybUdHNqiZBAXlkHZOXVhWXBxT9A3Y
 oikSYSwF1iqOgizXFunYDe8pCiFRlJQOb5VfE2gX3aOK7q2kIkM9A76SjQGE+2BG3KChNubo0oF
 rIcAGv+4CaYNFFNziCzDIJmpHB3KxQfZLXn3Z2vyye+0cNvKTfTQW/wCit0Kg4OnvEI615ql91I
 6yUJWpeV3upqxP7rYOVZ3cyOlxT8PEvODHhxoBtjMvKO6h5nBMyoMBeaujo2dwV9obLg4vrk0MY
 baTj3ErKDFE+PmKNndOcswNjXL6Hix7W5AEvbDNLTNNjwcfToFFKNvxoNp/Uxs3wZFfy3LGU1d8
 IDXwKTCmeN1qU/AbL4A==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af2a3e8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=XU51oE-CMt0mn-qX91oA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100019
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

