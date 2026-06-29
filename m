Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4E0C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6203210E936;
	Mon, 29 Jun 2026 14:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MLD9EApN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L78ur/AY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6687110E939
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:19 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT75R2604444
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h/u6JPc641J8wBzj5j0oNFgP8pVVYegd9kCes0Z3CLU=; b=MLD9EApNBZEhayGF
 s3WgMec8Ij1hV63HGQZvte56NS0Ex9PbhVDV1mZPYFKhgSJktvrMLNBkExLP6v6y
 gVl9b4ct1hVicSTLeNW7LQnEGvDPWboZOrIG/itXcxtyHPbTyOXL1OFLWcUd1xAK
 MnlN6kEPvIZGEHeYa2svab8Lz6UBtJQKZV+pLAuo+1ZWj+A0mpn4BHLWo6uPOCl2
 7n2VWlvAH2qkmqM9JVTAoe+Bpgt/lUvH4Y6Ajt81mzP748H5re8xK2fQ8TzGI9r+
 blfh4NcGqZ+UyFlUD0mtwTs8ICceDuiUTElL2n/TYUvPUG3xqAZovFbOCXJVyneT
 gqFA3g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq89788-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:18 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8efe7db1c42so23836556d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742638; x=1783347438;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/u6JPc641J8wBzj5j0oNFgP8pVVYegd9kCes0Z3CLU=;
 b=L78ur/AYAnAl2gOL1BvYltndpk0kyV7H1NEXPSXSQ+nWQ8yemkxk4KB13PLdLNzZzd
 YRnW3n3sQ3pKL46yJ+LUKRnjQjPqtZNMCUTtq/duX19gtcmXP1WLlASWu37xeBwqlKLj
 r3pF8IHIVALcPjPb/X0pk4+yqSEP3Wl3QmYTPtlWG/N04Mv/OQJl0TEpV0AdtsUW2HQP
 nlpY3U3z1b4e/ObSps/0lyx778QxGV7pZT5ZdYfDhTW6nRd6puAmIVwqR43lXJSi4caG
 SVk3bosUdGSyCFjTEV1nwTr2PGn0IDKa6A7foN0ZXim4h+/eJH+PlnfE1vVWQdBqnsmk
 uh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742638; x=1783347438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h/u6JPc641J8wBzj5j0oNFgP8pVVYegd9kCes0Z3CLU=;
 b=CiH7XlqiBcOQj/slVwmj6dPbXMbhGzQyb2nIbGalva7+x2zdEYc+QTp61uWUxDTllQ
 npFO/yz5fkZ+Mx381hWBcVi76ylfBq2tHwp1nxxB/6CrA0Wao3SyrRcxnl652bjDHmX4
 EYWHEFPM1GM0MwtpM6GFEJj3bNMAHJBvEIgGGODfrOyLUneiOGpfjX6v0g5FJChwhPrb
 v1GNs8XyAdEOoNQP2aOhPOUnpA8qYIEGiCrAGnVL/EgTQMirTNxJqnXuEyfel7q9kj6Q
 gTUpBz9W62b83i/9Aj+pjfNYYtU79yiJh9uadmj3AciF52E548U1Xeoqv7P7Jw7bez4h
 +ULA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TROLDeczc2xb2FSfHxzDcVmDjyA2R02GPcPQU0OjdGgfPP2nqHl39jL6dZoMCLqVDyFGbl89/1ME=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyn7JWFuYjIeXdIfVmpNQqT42ylHiF1j6PJwN+0pleDHTUTsbLo
 UIod0EdS5aNgGGhpf8SYWc5eTi5YXccac2xnzdBBFu9SmPRIrUnKj+gCjQLNnztrKK+ShLH7L8B
 pPsMtv8XFYEh0tp5E+TxUzsyQbx77DR7Bniie6GsiZ31ublmT7eJ+Du5X8SDMA9hWCPs1lLc=
X-Gm-Gg: AfdE7cnFVrBQ+STqET5r7smSfU2C3YaziEqs5nNCk1hShKs0pjxITALz1Izx8O2vmBw
 8PjTcOVXpX2NYgS+eeQPWrxiPYiELvgRycr+ny10E1u1Ccyg/iXe31SHiY9xUTz+2+NOK//PSG4
 zr+yGIORHIRp5UdZHExAk6zwAHgt2qXQjoAlsxV4yQo3E1V9wvF/WGy4eSM7x/yv7/2d12L/9oG
 cXOQDyZUxoTsjKkMzgKe8WN2yP81/sgeW6gArmi+XIsVJBA5RR6KZRi7Dm/BohtvC/W6MMXbp/2
 balbLKuHOMRH8BgxLBPTIJN/EAf03ZUT96migbBWAQoiOguLJfc611qD33Qin6fGqZEGFNGnREr
 9FSBb9TYiSm/imGDX6Yc/GbW4PhA16QFiSXZVCu5nBy+AjdDfWX8HL2hIAjp1IdveuvFWDA==
X-Received: by 2002:a05:620a:7113:b0:92d:d721:3fd1 with SMTP id
 af79cd13be357-92dd721454emr1060537785a.74.1782742637677; 
 Mon, 29 Jun 2026 07:17:17 -0700 (PDT)
X-Received: by 2002:a05:620a:7113:b0:92d:d721:3fd1 with SMTP id
 af79cd13be357-92dd721454emr1060530685a.74.1782742637124; 
 Mon, 29 Jun 2026 07:17:17 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:17:16 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [PATCH RESEND v5 25/25] drm/msm/dp: add HPD callback for dp MST
Date: Mon, 29 Jun 2026 22:14:46 +0800
Message-ID: <20260629-msm-dp-mst-v5-25-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=5643;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=b+G2f0mUuFh+XGa6ykrKQSB0dIdAdRaLzVWlRhztVIc=;
 b=pMp9/Trp/gclufRffFOYc6B9d49s9r7PIzdz4dDQACGjyqvLHFUEMD3EnEcqyZ4eyM5Yz21EE
 0NAmDEiTz71CqgJj59RBm/9Umty2mnt78AADKZo6CL5r7lY04OHnFLP
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HUV42LiA8aXVVz-HR0XvaeGukq2dJ5xk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX/rbYWhIZUesQ
 HDmrvIg6tlhiqWOdGUAJyFBsySIHBFcJR+YgCGwiUkq3ZKxzHefZtlAGg1gQCknbPKjBS+Q3t3m
 Ze6Y1LW9B92L0FOWq3dtqA2gKvahsPQ=
X-Proofpoint-ORIG-GUID: HUV42LiA8aXVVz-HR0XvaeGukq2dJ5xk
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a427e6e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=cF23hRJ9h-J1zlJA4xMA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX5WpdM587yk+e
 2ICybjUpMMWEm/MEXg5+mN/Y0WtsMUmMFXf+qDnvDcGvt8JpYUZ9u0TUKd0WwADQM5vppbWj5OM
 rAe/d5czyph3/DBjwjbCk15aO8ejmT8Q69DZPPYa7aZcPhgcwdvIg7u7QIkt6op2mYxJRRXquKC
 y/CzjFV62LFIttopAk9RAyHBge9A8TsKIzyyulrERwrpdcQCTZaKkhepkEjW1PtFc8Q5OGbR6tw
 EtvM2TiWvCmAOmiu9uEpur0U9AtZDgeDAgDzCs804qQnQVxk02SC61s+1xus/X4TV0Gwf1m0hCn
 44eMV8wVhSIKW0xESOEBi51Hmqk7MawXscXbv12ghImHU28M8jiCZ1qezZX+ig4cf0NncaPX5Gs
 wPW8QUsHvWMl4Zd72Xmq9SdM2gFFMy1EoIwhTQZU9wGPFNP3gQmrdJoBPAGzTyuwlrsViEg5BIF
 k0IHDhMUBsOhil4/NCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290118
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
 drivers/gpu/drm/msm/dp/dp_display.c | 22 ++++++++++++++----
 drivers/gpu/drm/msm/dp/dp_mst_drm.c | 46 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6eac390af2e0..49a7bc5e031e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -455,6 +455,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
+	if (dp->plugged && dp->msm_dp_display.mst_active)
+		return 0;
+
 	guard(mutex)(&dp->plugged_lock);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
@@ -550,12 +553,18 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
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
@@ -1111,9 +1120,13 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
 				      connector_status_connected);
 
 	/* Send HPD as connected and distinguish it in the notifier */
-	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
-		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
-				      connector_status_connected);
+	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
+		if (dp->msm_dp_display.mst_active)
+			msm_dp_irq_hpd_handle(dp);
+		else
+			drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
+					      connector_status_connected);
+	}
 
 	ret = IRQ_HANDLED;
 
@@ -1776,7 +1789,8 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			msm_dp_hpd_plug_handle(dp);
 		}
 	} else {
-		msm_dp_hpd_unplug_handle(dp);
+		if (hpd_link_status == ISR_DISCONNECTED)
+			msm_dp_hpd_unplug_handle(dp);
 	}
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index 12b47a413793..56f7a84e77d1 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -36,6 +36,8 @@ struct msm_dp_mst {
 	struct drm_dp_aux *dp_aux;
 	u32 max_streams;
 	struct mutex mst_lock;
+	/* Serializes HPD IRQ handling between IRQ handler and poll_hpd_irq. */
+	struct mutex hpd_irq_lock;
 	struct msm_dp_link_info link_info;
 };
 
@@ -288,6 +290,41 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
 	return rc;
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
+	drm_dbg_dp(dp_display->drm_dev, "MST irq: esi1[0x%x] esi2[0x%x] esi3[%x]\n",
+		   esi[1], esi[2], esi[3]);
+
+	rc = drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handled);
+
+	/* ack the request */
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
 /* DP MST Connector OPs */
 static int
 msm_dp_mst_connector_detect(struct drm_connector *connector,
@@ -502,8 +539,16 @@ msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
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
 
 int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
@@ -532,6 +577,7 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_au
 	}
 
 	mutex_init(&mst->mst_lock);
+	mutex_init(&mst->hpd_irq_lock);
 	dp_display->msm_dp_mst = mst;
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
index 5d411529f681..08e145399cfc 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -9,5 +9,6 @@
 
 int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
 int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state);
+void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
 
 #endif /* _DP_MST_DRM_H_ */

-- 
2.43.0

