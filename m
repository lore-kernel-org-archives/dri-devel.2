Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D06CC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC53610E73E;
	Mon, 31 Aug 2026 08:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fyv/AhFA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JM8+itna";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5AA710E734
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:47 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xmPN2824646
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jRrYtPpvJzgEakEY+PJv1lS94KQBDZX5lsEjbKy3Gyo=; b=fyv/AhFANsIOc2Bz
 Z1kJMi9qCtRIDwMSP+86tDEP3ULMnn98kW9eQj6KGOOhF0ZgIckVTJhsL1bJkGag
 NtTKavgOEDpSzyiLgR/aKZbDhcYyx8Osv7N2/9IPoZmx0o6tr/H6oVku1E0Eo0tR
 r98eNpXiTYKbmEMczEtjGcZfJQk9AfCbezNIHiUQW9gQRl6NSjpaZA9FZTOlpLlI
 LG5mqIzY6uy/N8tCg4PLfCF1pjqipw2LcJBZncVjWthE4nQ8tRhiuQA0Y5kwm/hl
 XKIiVwZmAZx4RFlG1pmQD7QxOF/4m4sCsOtnrYv/SXopXdzZKmf8BHKaR9VI7yX8
 1hkX9w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqe2ddf8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93903622880so640040485a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164386; x=1788769186;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jRrYtPpvJzgEakEY+PJv1lS94KQBDZX5lsEjbKy3Gyo=;
 b=JM8+itnauoJwlwjxHEsGC4k43+0C4v25T3afjus+viAVWdTJjiCTyraNWVUzM+Y1w3
 Oa0ZzcJ6aSBrQVEgzsapP2sGqqJUb7gicEZOjFXoLK3oOXexkrHvR0eTQyW85kYqx1o9
 ZXQjVwTAT1maSefpFJq3qT6q9ruSaj9JWo1FgRg3tQ7cZ1u4my+CgRn/8mMrpSC5DVbI
 JlFhQSHPAPGJ6c4hCxPh/qHbkFxW6vEPzNxXNU6EYw3U9vSLbUsBoigNYbRHArLo+MtD
 wuLI+mymlH6eNh5BTZVFqduP4ziSGnNLJ54PuNyIGgKNWyJbjOwLD6SOKwE6qFV2rIgg
 K8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164386; x=1788769186;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jRrYtPpvJzgEakEY+PJv1lS94KQBDZX5lsEjbKy3Gyo=;
 b=NQ2/PHpBfX8cBAu9XcPREN8xz3F32SNjinUaStCIzl2HBQxaSaSt2qtfkBlQk2Tv9h
 QXwSv+n+MusYSf0VOkp/yRYnBC38ro1blbWRf8WwZlR54HGB9ueeutj/TMy6ao4d0ux7
 lsBCvodK2e3U4rlHXzjEtlzXgAY8wXdzMQCAyxISRsXPxKl+zhCgug9S6IGsU19zNSHu
 /FFhrcFl9mQdNPmuwcxFZGtpHGdRu7HZ/7sIzDkJhMmWcHlNEETQ1ER6LWTwaJI3Tjbt
 W2wEDAPvIemansc434zc8fpQAFOqz0TOPGFM+ofRrFTMPnQPJUaoKnfjSTk97+BSb/tZ
 F3lw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiyW23d5hLWvVJQb53Ihk3CHjM4J2kWYaZZTQua6PuiyqqVWjxzjww9Tv40ht6Sw9oS2tu0xLxOUg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nKr1phB5U9ES6R9D8R/c+Z36GWq4A09t1mhqUIKKLV3RO9boQK
 ibM9U506fB3elSz2nwKPMUU5MuBBG+ViT9cWfcKakHPg3oeIelNYyQJmI772jIB8UPKFDJmZzfW
 4QicMnfY7dOb0Nru91WH+eWZEJmJ8/q92VsLckZpN0VLXlYt+8g5i85dpSae5OaV5ViST0Ds=
X-Gm-Gg: AR+sD12rWlRj1EQjPxHdZNi8lUBgqc+Qah2iTyI7xNmpZ14/rmt/tUUX9vMCa/Q2L+r
 LdM1fuO68bvvcy1qFwAdwJuARd0ZavJbSBSoVU25FkbjkSKPkSsOCj9jUcP9Ti2EMcD4KKBf/Uj
 IJsn4Wwpr3+Th/5Y2+uLh0ha4Bguy80yONHnJcANsb2oZfj9IwWVZevY5151grtMqeNW6USVV+X
 iXqv2BVY2pEQV/4Gb3QcG18APNrN5/eJj7b3x0oHwlXqhvTxeaAOq9cyoO5xdiMo9EyPeZNNxUJ
 YerUrz6eHADeJnQ8M+MAzJm3rYvF+pylTPLh6IfpyHsVELIzn774uGkas2jH/yClRtmV+e+u48f
 u5Rkc5daX/I3sbea0ZBqAIUHfm8qm1SpGl9UFRK1lp1RFyNBdsmt/rR1eQMm5WQ0=
X-Received: by 2002:a05:620a:4405:b0:934:b798:c245 with SMTP id
 af79cd13be357-93936d0293emr611178185a.16.1788164386234; 
 Mon, 31 Aug 2026 01:19:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4405:b0:934:b798:c245 with SMTP id
 af79cd13be357-93936d0293emr611175285a.16.1788164385790; 
 Mon, 31 Aug 2026 01:19:45 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:19:45 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:41 +0800
Subject: [PATCH v6 24/29] drm/msm/dp: add HPD callback for dp MST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-24-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=5866;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=BbNlDqCJNiGbUB7FO4KoLqLxFy+/jxUEkwHF+8lImVQ=;
 b=+sq47yHGy9lKZu3Jf5gVP2ZS5N9oOOOf7FlvlLNtHA5RrL9sNU9+ozhC6HiCWz0lFsVz2NUoq
 8qP9lH5R70zBoYSVMp5uLJK5E0z5k7VLNz11uh7hl8upJ6Z7VckSSwA
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=Iskutr/g c=1 sm=1 tr=0 ts=6a953922 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=aoVTMipVTiCx4Xnk7jUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Lo4bbFes-VBEd2rxPoSRVc-lWx-igZbU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX/8yIOFry6/EI
 9e9+Me2N1vc+dND9xJtXHDC12Uz2/UBS6VOFWPNU8wR1OkviXM4Igh5y6CoTEnGck6cE6wTmXEg
 Um2J9crSu0rw8t1GVBX3/z1CATfX7GW22LAW9w+GJhlkGKsyRE0tfvKk56nATpPx03hwUXEu6cs
 6jI9ucIfznPt936rF6m9qlMtrllqT+iQmZElrmZpbngG9J4sHbhJYba4bZiun0GhQxw8MtUULQf
 7lv+yWdL6JFhykQ5VxP18HG00BHA02KXARCH/0j3mGTaFzTDKkDjRDqkp2RtK6NCtUivEC3b9lB
 AqC4gCL0zsnm0FOwLJW8JzXTdR8p/GHVBeOXaDl/Acxe8IMt+87yvQy5tFD/dPkjFXtpyiIVKov
 3VxB+vkd7cjHuJlpj2PvDhjyPoytbdKgi40Pgnw9RzqfI8TE6apbVNkxmyraE+dZZdk3RSt0fZh
 iT8QGNXLxltreLfCeeQ==
X-Proofpoint-ORIG-GUID: Lo4bbFes-VBEd2rxPoSRVc-lWx-igZbU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX1v4jt34SQIvO
 ftKAX4ckrsiX0KegJKfkEmY2/6g9Uy9T3JAaMJpQAo4SQO5w5KVFweN1hyb6waKkq6syq53zOqp
 CW+l1YoeaqFYfseBY381HW9a5UKPTcY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310070
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Add HPD callback for the MST module which shall be invoked from the
dp_display's HPD handler to perform MST specific operations in case
of HPD. In MST case, route the HPD messages to MST module.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++++++++++-----
 drivers/gpu/drm/msm/dp/dp_mst_drm.c | 44 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
 3 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c015af868801..22b925277462 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -416,6 +416,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
+	if (dp->plugged && dp->msm_dp_display.mst_active)
+		return 0;
+
 	guard(mutex)(&dp->plugged_lock);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
@@ -506,12 +509,18 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 {
 	u32 sink_request;
 	int rc = 0;
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	/* irq_hpd can happen at either connected or disconnected state */
 	drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
+	if (msm_dp_display->mst_active) {
+		msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
+		return 0;
+	}
+
 	/* check for any test request issued by sink */
 	rc = msm_dp_link_process_request(dp->link);
 	if (!rc) {
@@ -1056,10 +1065,16 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
 		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
 				      connector_status_connected);
 
-	/* Send HPD as connected and distinguish it in the notifier */
-	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
-		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
-				      connector_status_connected);
+	/* Temporary until DRM IRQ support is finalized, then switch to
+	 * drm_bridge_hpd_notify().
+	 */
+	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
+		if (dp->msm_dp_display.mst_active)
+			msm_dp_irq_hpd_handle(dp);
+		else
+			drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
+					      connector_status_connected);
+	}
 
 	ret = IRQ_HANDLED;
 
@@ -1717,7 +1732,8 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			msm_dp_hpd_plug_handle(dp);
 		}
 	} else {
-		msm_dp_hpd_unplug_handle(dp);
+		if (hpd_link_status == ISR_DISCONNECTED)
+			msm_dp_hpd_unplug_handle(dp);
 	}
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index 03f9c95ca686..2e625a7db981 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -35,6 +35,8 @@ struct msm_dp_mst {
 	u32 max_streams;
 	/* Serializes concurrent stream link-state access across streams. */
 	struct mutex mst_lock;
+	/* Serializes HPD IRQ handling between IRQ handler and poll_hpd_irq. */
+	struct mutex hpd_irq_lock;
 	struct msm_dp_link_info link_info;
 };
 
@@ -326,6 +328,39 @@ int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 	return 0;
 }
 
+void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
+{
+	int rc;
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	u8 ack[8] = {};
+	u8 esi[4];
+	unsigned int esi_res = DP_SINK_COUNT_ESI + 1;
+	bool handled;
+
+	guard(mutex)(&mst->hpd_irq_lock);
+
+	rc = drm_dp_dpcd_read_data(mst->dp_aux, DP_SINK_COUNT_ESI, esi, 4);
+	if (rc < 0) {
+		DRM_ERROR("DPCD sink status read failed, rlen=%d\n", rc);
+		return;
+	}
+
+	drm_dbg_dp(dp_display->drm_dev, "MST HPD IRQ: esi=%*ph\n", 4, esi);
+
+	rc = drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handled);
+
+	if (handled) {
+		rc = drm_dp_dpcd_write_byte(mst->dp_aux, esi_res, ack[1]);
+		if (rc < 0) {
+			DRM_ERROR("DPCD esi_res failed. rc=%d\n", rc);
+			return;
+		}
+
+		drm_dp_mst_hpd_irq_send_new_request(&mst->mst_mgr);
+	}
+	drm_dbg_dp(dp_display->drm_dev, "MST display hpd_irq handled:%d rc:%d\n", handled, rc);
+}
+
 static struct drm_encoder *
 msm_dp_mst_atomic_best_encoder(struct drm_connector *connector, struct drm_atomic_commit *state)
 {
@@ -441,8 +476,16 @@ msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
 	return NULL;
 }
 
+static void msm_dp_mst_poll_hpd_irq(struct drm_dp_mst_topology_mgr *mgr)
+{
+	struct msm_dp_mst *mst = container_of(mgr, struct msm_dp_mst, mst_mgr);
+
+	msm_dp_mst_display_hpd_irq(mst->msm_dp);
+}
+
 static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
 	.add_connector = msm_dp_mst_add_connector,
+	.poll_hpd_irq  = msm_dp_mst_poll_hpd_irq,
 };
 
 int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
@@ -471,6 +514,7 @@ int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_d
 	}
 
 	mutex_init(&mst->mst_lock);
+	mutex_init(&mst->hpd_irq_lock);
 	dp_display->msm_dp_mst = mst;
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
index 89f73b1db2e7..8546214cbca1 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -10,5 +10,6 @@
 int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
 int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 			      struct drm_encoder *encoder);
+void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
 
 #endif /* _DP_MST_DRM_H_ */

-- 
2.43.0

