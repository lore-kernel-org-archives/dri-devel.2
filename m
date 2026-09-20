Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247DBC982F3
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AEEB10E36C;
	Sun, 20 Sep 2026 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D7CittKQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dAcRXu50";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A3D10E2EC
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:01:41 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68KBo29N2287716
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XXWAWnwnkyxJNop1YmIHyAiC0W2g9ZZFzjEZKgzs1qI=; b=D7CittKQZRPVq5UC
 NzezV2mRx7HM5unMGn4yWg0e9QyT7guxtZ2apeq28m24DXT5UVEUSSLkto3AZaoX
 RR6aTlY0GH1tuA9eBSBw49k783rdUKHLw2x9fhmdHVwfvPuaYkS/gcRs6S50dme1
 jd4Ue4hnc4uvbP4KiBFqn2EsF/7eMpG87+y9f7zUiJoEcByyQSzcu59i1nNfh/TO
 THdX2yS3N4edXwkhE7gYvpS2NuPU7zzwi9G6LEPPI1zVWTp0mXf7hi/cAFnMX6wr
 X37003zGJy0bCbxvWcIkiqQVzxhsS/fI3GomsRvVQu5lASoN1ykXMI/H35arImx/
 EA2SRQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsfrnujgx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:01:40 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-980c3b71002so1813539241.3
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789916500; x=1790521300;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XXWAWnwnkyxJNop1YmIHyAiC0W2g9ZZFzjEZKgzs1qI=;
 b=dAcRXu50Qn2IkaJnrbXHF00KU0lqf3pkX7EeOizjknR6kxVpQjKGdk136mhcg6YT3s
 Ix4hi0nD60TTVWuxZMs0sidtwXwevmUGZivHmSvbVokbU4xXGTq12uOrKATnSTGM8fPj
 /Rtd8YpzwNj6apnAo1Fr/wnTapZbYvxC6Wwirp2CPWkVy8AjpzqGPlA7266eb/U3aevX
 /1kAi98j7XXVAG9bXa7BpoUHHbTFqq4BuusYzcWYxWF4i3DHP13Gft5wcBmuEpd1cOaJ
 c3E6HC6XdR+GS2ais1lhneIq1nLE1P9kccerHpHDLFAyxoZV5HVkrmwiuUfYtU2/b1Qm
 UcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789916500; x=1790521300;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XXWAWnwnkyxJNop1YmIHyAiC0W2g9ZZFzjEZKgzs1qI=;
 b=zi7S7lfJGc+ZWBsaStffWIIbeNfzImbQdmP2LOhaQFas8UKz3aQVQ1BjtrEiwRKyIt
 /QUGS3DCmm57/+PgxncOES5iX1CMo5YlHBFoK1SA8N/an6cASh9V1xyxQF3jyBS79PoF
 ktGzAwMUOQPUroqwnjm7oWa6d8UaKH8FiUqTho0GR7XU3zjeB70/puQe5sSFYD3FUfFP
 FzojrCtZoISpdTU8WwV1kHiYwwF4bHrU6zZZTQJ3j1pR5g1s2XmZqUv9V7tWihi6ZlsG
 UVsQfTr9YcjI+auJsX6tdZIGNvwjM30SEJcSJ746eUJWFPIxRRV22xbRDGZ7pM0MRYAV
 Shbw==
X-Gm-Message-State: AFuF++lo2BFF1vDQwpR2UDN6PYZqOB86wcw0qE0VvssZI9zX241Nd393
 Y8c84C26QD6t5VJhdFpDrLxCLt6F/OEp+/ShSlx59u1IVKPxeeoNwyrlqKo/YWJvCbxLeaxgyng
 BmcFl5yEQGR1oa8TfAJydydFtjmfNszfjMs9RqQtY48EAaqiD2VDeRFOLhDZ1M4fUXwDZTos=
X-Gm-Gg: AYBFou38Ry65DH10Q0snPzK3m3NzxaSd8tL9GT4DWYLnGQ0GyF84GnARKeieOvwxF+m
 xWXf+ntqyhTX+PlUJJkclEVJ4fnIInEUjkx9xp/r7elFFdNuJQ3Dvj9j7Kq5IZpkVfzW3Dhsyt8
 c4bAka7AJw3pbqVahHFEDQ0GnUJKKQN5P5KqdzvSQYSUElqYRX4uJxooToFTRLwzSDI2UM1iNm4
 E1bvjjfRgBI1Z3FIJVL3aL52/nBqo+IfV0DL1rDVGTpCER+M8oUjpxVSDS9vbzYntApk0nfQKbm
 0d2QK44O7O5uCREk0zUmhC0H2rVoCn7hz4JfreGs5qS4Np9ddOGhhA88bNSv/iz7Mgs675hQVYw
 KywKUZ0F7aFujhf+J0zSUHYIVdAY6W63m6fbt2pBXqmS9KYKbwYydsMa6zsXtxCcSMAehpf7aoJ
 HpdjcJ7v9g3izk
X-Received: by 2002:a05:6102:689a:b0:7a7:3485:33e4 with SMTP id
 ada2fe7eead31-7a7348549b8mr1492143137.33.1789916499580; 
 Sun, 20 Sep 2026 08:01:39 -0700 (PDT)
X-Received: by 2002:a05:6102:689a:b0:7a7:3485:33e4 with SMTP id
 ada2fe7eead31-7a7348549b8mr1492036137.33.1789916499090; 
 Sun, 20 Sep 2026 08:01:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a6163d7119sm4090061fa.30.2026.09.20.08.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 08:01:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 20 Sep 2026 18:01:28 +0300
Subject: [PATCH v5 3/8] drm/bridge: aux-hpd: let drivers pass IRQ_HPD
 events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-hpd-irq-events-v5-3-ff1de0090c72@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7277;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=EVgrHj1tZBs51ETDgVLuzBSX1Fd5Ddi56a5fYfUb7ro=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqr/VHviHGAAVv1soXfol+wXO8U14A018aUgzNM
 6gy+9RNhzWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaq/1RwAKCRCLPIo+Aiko
 1VhPCACAVzX19JL6817I0MNCd9lLSKxJ0lJ09Zepji5qaM+gFtbZqkuEDfCk9lzBBeE1X6ktlRS
 t51CPFACafuD37D5RZzVdDqLyEYtYcK4HJdPVflqA3dVEKSCohuSN+uNHVvii1pjZML2RPYSONb
 VlbGrUki/IQDwoEwHkWg4fymUWBCWxDy2y+AHxLgOdNKQPm9hVhvIzGFt7poSRLbd/KzEjDBAJX
 AN45X6Ux5Syo5KWeuqXn5sNIyKi5cT0Jgwgj4vfGR4Z+pAcLdFp/TvTOnnVb2GKZiJB0xiM2OBS
 IiE4j2cUIW1hJsyQTkWakDw77VpN9/agr7urnRFJFnUhD9Hf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=W9mtxhWk c=1 sm=1 tr=0 ts=6aaff554 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=sF2-0BiPaN5ps1Od_V4A:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDIxOSBTYWx0ZWRfX+rZAPV7XfmX2
 ThG4t/Bcg/iYFT5Sq9+yE/M7Cmf5IrGCIy+ifIATTuSXDq28pqgvpABGdjDg7mc6z5V638Zdjz5
 7EYkugC26CjPd4W89mR1dQziUk1dnY8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDIxOSBTYWx0ZWRfX4LrVs+1TeIa2
 tHo4DkfAFdazDozT23noVsSY6tjiKTSfA1H3JjbNMndpemnglDY0OYc6Olm5uTQAo3i8/7gYlAw
 pSXwJduBlgNo/4C6ZBkogfSoN2DN6E4M0snjVywAZij/tmTrjZhd8fGUKR/YGZGnvIT5ibPqvYr
 uAjZ/2oRgyASdUpeM209NO8k8tWhccLqMc0f7PM3VIKOvl8aVmvcs7VcbugGHh5xE3iSOiyxD6M
 T47oW0H2cBNNSJuNvwEMjhoVQYswIJlkB5z2wo+/y6B4NPWcfTv/O1M9t0nrn2B/9iG4oqAPIpr
 lDYWE4sSbHvvKBlwmv70vdkHjhWd5j5NwacMYTDiUuk8rXUf7BVSEoX/pmWTYfo7/cu+r4YUuTm
 W9AhHqxZCP1gQy/VHEmDehj1jqrfm29TLMRjF03XbeoumeEVcmlReSYHfPZwKPZFkV4nN12WMzY
 VJjhJ2cq+YlUJupDOqg==
X-Proofpoint-ORIG-GUID: Sl9cSAobhrnwl3EnFSr2eUV6gnsiW2Gw
X-Proofpoint-GUID: Sl9cSAobhrnwl3EnFSr2eUV6gnsiW2Gw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
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

The DisplayPort standard defines a special kind of HPD events called
IRQ_HPD. These events are used to notify DP Source about the events on
the Sink side.

Let users of aux-hpd, the UCSI and PMIC GLINK drivers pass the IRQ_HPD
events to the DisplayPort drivers.

The drm_aux_hpd_bridge_notify() is kept to ease merging of the series,
preventing extra cross-tree merges. It will be removed once all
drivers are converted. The drm_bridge_hpd_notify() function is kept for
the drivers which only care about the connector status and will always
pass DRM_CONNECTOR_NO_EXTRA_STATUS as the extra status.

Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/aux-hpd-bridge.c | 11 +++++++----
 drivers/gpu/drm/drm_bridge.c            | 15 +++++++++------
 include/drm/bridge/aux-bridge.h         | 13 +++++++++++--
 include/drm/drm_bridge.h                | 22 ++++++++++++++++++++--
 4 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
index a2e525aa5788..930a03496ac5 100644
--- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
@@ -137,16 +137,19 @@ struct device *drm_dp_hpd_bridge_register(struct device *parent, struct device_n
 EXPORT_SYMBOL_GPL(drm_dp_hpd_bridge_register);
 
 /**
- * drm_aux_hpd_bridge_notify - notify hot plug detection events
+ * drm_aux_hpd_bridge_notify_extra - notify hot plug detection events
  * @dev: device created for the HPD bridge
  * @status: output connection status
+ * @event: extra status bits like DRM_CONNECTOR_DP_IRQ_HPD
  *
  * A wrapper around drm_bridge_hpd_notify() that is used to report hot plug
  * detection events for bridges created via drm_dp_hpd_bridge_register().
  *
  * This function shall be called in a context that can sleep.
  */
-void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status status)
+void drm_aux_hpd_bridge_notify_extra(struct device *dev,
+				     enum drm_connector_status status,
+				     enum drm_connector_dp_event event)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
 	struct drm_aux_hpd_bridge_data *data = auxiliary_get_drvdata(adev);
@@ -154,9 +157,9 @@ void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status sta
 	if (!data)
 		return;
 
-	drm_bridge_hpd_notify(&data->bridge, status);
+	drm_bridge_hpd_notify_extra(&data->bridge, status, event);
 }
-EXPORT_SYMBOL_GPL(drm_aux_hpd_bridge_notify);
+EXPORT_SYMBOL_GPL(drm_aux_hpd_bridge_notify_extra);
 
 static int drm_aux_hpd_bridge_attach(struct drm_bridge *bridge,
 				     struct drm_encoder *encoder,
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 649f6b6ab5c8..58927e0d0191 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1607,25 +1607,28 @@ void drm_bridge_hpd_disable(struct drm_bridge *bridge)
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_disable);
 
 /**
- * drm_bridge_hpd_notify - notify hot plug detection events
+ * drm_bridge_hpd_notify_extra - notify hot plug detection and sink IRQ events
  * @bridge: bridge control structure
  * @status: output connection status
+ * @event: additional status recorded by the sink
  *
  * Bridge drivers shall call this function to report hot plug events when they
- * detect a change in the output status, when hot plug detection has been
- * enabled by drm_bridge_hpd_enable().
+ * detect a change in the output status or when the sink has reported extra HPD
+ * status events (like the IRQ_HPD in case of the DisplayPort), when hot plug
+ * detection has been enabled by drm_bridge_hpd_enable().
  *
  * This function shall be called in a context that can sleep.
  */
-void drm_bridge_hpd_notify(struct drm_bridge *bridge,
-			   enum drm_connector_status status)
+void drm_bridge_hpd_notify_extra(struct drm_bridge *bridge,
+				 enum drm_connector_status status,
+				 enum drm_connector_dp_event event)
 {
 	mutex_lock(&bridge->hpd_mutex);
 	if (bridge->hpd_cb)
 		bridge->hpd_cb(bridge->hpd_data, status);
 	mutex_unlock(&bridge->hpd_mutex);
 }
-EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
+EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify_extra);
 
 #ifdef CONFIG_OF
 /**
diff --git a/include/drm/bridge/aux-bridge.h b/include/drm/bridge/aux-bridge.h
index c2f5a855512f..233ca885736f 100644
--- a/include/drm/bridge/aux-bridge.h
+++ b/include/drm/bridge/aux-bridge.h
@@ -25,7 +25,9 @@ struct auxiliary_device *devm_drm_dp_hpd_bridge_alloc(struct device *parent, str
 int devm_drm_dp_hpd_bridge_add(struct device *dev, struct auxiliary_device *adev);
 struct device *drm_dp_hpd_bridge_register(struct device *parent,
 					  struct device_node *np);
-void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status status);
+void drm_aux_hpd_bridge_notify_extra(struct device *dev,
+				     enum drm_connector_status status,
+				     enum drm_connector_dp_event event);
 #else
 static inline struct auxiliary_device *devm_drm_dp_hpd_bridge_alloc(struct device *parent,
 								    struct device_node *np)
@@ -44,9 +46,16 @@ static inline struct device *drm_dp_hpd_bridge_register(struct device *parent,
 	return NULL;
 }
 
-static inline void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status status)
+static inline void drm_aux_hpd_bridge_notify_extra(struct device *dev,
+						   enum drm_connector_status status,
+						   enum drm_connector_dp_event event)
 {
 }
 #endif
 
+static inline void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status status)
+{
+	drm_aux_hpd_bridge_notify_extra(dev, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
+}
+
 #endif
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 58fff047f43b..d64a0ab02c90 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1470,8 +1470,26 @@ void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 				      enum drm_connector_status status),
 			   void *data);
 void drm_bridge_hpd_disable(struct drm_bridge *bridge);
-void drm_bridge_hpd_notify(struct drm_bridge *bridge,
-			   enum drm_connector_status status);
+void drm_bridge_hpd_notify_extra(struct drm_bridge *bridge,
+				 enum drm_connector_status status,
+				 enum drm_connector_dp_event event);
+
+/**
+ * drm_bridge_hpd_notify - notify hot plug detection events
+ * @bridge: bridge control structure
+ * @status: output connection status
+ *
+ * Bridge drivers shall call this function to report hot plug events when they
+ * detect a change in the output status, when hot plug detection has been
+ * enabled by drm_bridge_hpd_enable().
+ *
+ * This function shall be called in a context that can sleep.
+ */
+static inline void drm_bridge_hpd_notify(struct drm_bridge *bridge,
+					 enum drm_connector_status status)
+{
+	drm_bridge_hpd_notify_extra(bridge, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
+}
 
 #ifdef CONFIG_DRM_PANEL_BRIDGE
 bool drm_bridge_is_panel(const struct drm_bridge *bridge);

-- 
2.47.3

