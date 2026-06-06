Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE969CD8C8E
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 12:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A85E10E770;
	Sat,  6 Jun 2026 12:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZuAAY2AJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FaOwE/sM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF30710E76C
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 12:05:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656BEim81328741
 for <dri-devel@lists.freedesktop.org>; Sat, 6 Jun 2026 12:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=8HBzGlX6MFZLSmVg9ZtYUP
 IQ9RoPtWcjeoYSCL3J7w8=; b=ZuAAY2AJkDEQ1npBxasm+RFL8z01sBXgjTMNee
 LkjWMSn7xjaKheqZ3yyoGbQGbPBgeyXSLFFJ+MV51PKN52wtCMqjs5OdgdpxYN96
 5dzDC34h9+Uii1aYqYRe084OH5PTrTk2B2JlN8hxFSAYmd1eIF8w5i4ZSOzxynzk
 hM96JQBay47JXsMlWJ+gRSvfh7i4K1U3VmsWgW+6KjM6DWQ9tv/JNErVZGJJvyyT
 pJHiO4aVyvk8hNpyWkq6+t9DDDID3v8jRDY3tWoqo5knSi+zeSR5IYTFoAWYt2Yz
 pGrV1n6Rz7mmhOjJqGrzv2OW8i1sFQwIVHTpd308oRA3vY3w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8rs48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:05:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ccd719a2f2so65121076d6.0
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780747545; x=1781352345;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8HBzGlX6MFZLSmVg9ZtYUPIQ9RoPtWcjeoYSCL3J7w8=;
 b=FaOwE/sMECjZ6LgYcUDkpqpOhsw53OL38fKXrH1ug4Ig5XhktZThCq5naLBwFHITR5
 g3UuZkVVa2XnHgaZ/hDXiM9eUAIc2ddepZHdV16AR5TQOVuSZPGdIGpuBi02FeqmEW8o
 0Cxzj3T3iaEYCg6y0mM8CgLDy82aodMzOSXWSQ4+U0XKQmBOxzK0dKjcLB9x3vfKd8aD
 ul8tGTQZSTp6rIw9SSt26DHkYqZexsEGoblLGdGk1dlBeQzCgqM/WmX3ACpTBhmqTfmv
 Q0oRfr9YmRarVe/Ou7UyxPbxW+Nqz9aO+aWpy7RK9+Li9oE6jwd4OreTPjF9pLLeFI6t
 4P2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780747545; x=1781352345;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HBzGlX6MFZLSmVg9ZtYUPIQ9RoPtWcjeoYSCL3J7w8=;
 b=Kz0M/Ev4edlx1r9G3fp7wHsvK5Rucf6oy+tcZ9cYW3kFmKhuL+wd3LuXFsuH9rmyEz
 vnakSxRCY5iboyJ/82LruoL4iXIYCNVA8BXPWwRbjGK/OWQhYca10lC8f70FSEOuUGW/
 25ECYDLsRJaRMY+2XvNHnGef89mHUIRW6Zi5wK0AmD10pz8jLTNsu4iDbuGcrzTwvqkg
 jcbOhJ5SPwq9pnjSloaUJt4XpN7hsU17y7GsM4QEOZUSVkdBz2V1QXPW+OWaRm8YttUb
 gvdNF9IRJIXPLTdLQ9UWUjkHGEqtNxndU7WFxDtReuYp85IK6nSWSkniI1pStIsxth61
 9OTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ctYzFTtVXdEAfUAHddfrzHi67MAkGcfhRC8SNLOjQN2PKGVF3d0F78CbE32LLUFuZCEe26qK7Wio=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyrs3+djGtdgc3HFfY7eTT1JF7sy/tzX9MSeNPkGmvn0TaiBq75
 nazAsd1MCd5klpwSshRATV/DgT/I2W+/GZxyGhUnV8CrkUO94PKQUXih3QUj0qrX9/KI29VVrWw
 IKs1z3zwC6JSVraid2HDbIvdrvntk+yEUHD1h49Ouln15UCdERgUNmvwDz/KhmFhNmrfZIYk=
X-Gm-Gg: Acq92OF3r8h93UJMYsE7Oj+nAjYQWFuSa3QqmPpTQAMKtElnWHXkSCgI+q7dzIuslvK
 k0AoEZWgH1n3TQw7Tb0ls05d0EiW/oDTptdiQLdJyiLDu+NIz/2UGI0L70lDcBPgIfv4HT1BV8r
 We7sxFtUI9Mctc8nhtfr+TF/4VoFsqiC4GifYfntgp7ffXXfvzi6NTCNFmGYFklnO64V0FszOpt
 gYRfmhCEeu8/38zjwNR3RVM5sQcsvd/Lvb3lWX+Oai4xN4sQbbWA37T4uLjd5nBTRxDZRAl9vgD
 rKGBfe9tlz/JOnASx0/X8Wk6VxiTErdogln40DeoU9aA/9SZ53Et8qcEhSRrmIfyD1lJ2xvpMaN
 k+S4Z+H89NPZs4ho6WdWOaiD5R/wV7Trytd0mI+wbO0rkjsuQldviC2ZhSK2wcKFarHNl+iOcVq
 QeRMPmqSKFZZhcZ7+nJg==
X-Received: by 2002:a05:6214:6017:b0:8cc:cf1e:1fde with SMTP id
 6a1803df08f44-8cee611fb96mr123871486d6.26.1780747544977; 
 Sat, 06 Jun 2026 05:05:44 -0700 (PDT)
X-Received: by 2002:a05:6214:6017:b0:8cc:cf1e:1fde with SMTP id
 6a1803df08f44-8cee611fb96mr123870846d6.26.1780747544603; 
 Sat, 06 Jun 2026 05:05:44 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccdcc968sm113138306d6.22.2026.06.06.05.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 05:05:44 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 20:05:29 +0800
Subject: [PATCH] drm/msm/dp: Introduce poll_hpd_irq callback for MST
 sideband handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-mst_irq-v1-1-98bd86445c03@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAgNJGoC/0XMTQrDIBCG4asE1xX8V7xKCUXN2LowSTUNhZC71
 ySLMqt3+Hg2VKEkqMh2GyqwppqmsQW9dSi83PgEnIbWiBGmSDuc6/JI5Y3FIBRoRrl2DrX1XCC
 m7ynd+6sLvD8NXK7n37PdqQlKmpbxMB8o5pJy4hUYb4RdxWF6VwGHKee02I5DJMZ4EqTWzKmop
 eICpHCOiyhjII6FZgbU7/sPKZqTztcAAAA=
X-Change-ID: 20260606-mst_irq-4d46e72137aa
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780747540; l=6713;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=zSMfT0DMwD/4+ok/8u9Mp2oYCqapDw71VhgCXriIqtk=;
 b=fMY4OsRWOqrHDWz1/ZrLJ4mxxNmK+ADiU5kpLHNfGmZTvYefcAynCxtc8po+CSN/uZjy3/sPB
 BUHi+56B/eNASfrFei8sQsFj4DzA5guK5BFhWh0yiMf3JyUbZTUoLaz
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: fnBq9_CI1Xx4xJjt7kkBHLnoNUa4UkWd
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a240d1a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=MOQejHObSoPVBmRpUXQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyMCBTYWx0ZWRfX6saKiGPd0jjp
 XRGryik2KATYvdLWr+/vPBL1Pl+KeoOe4aNl3LLbAiyv3OV8DkgDC/br46IPizZl0oz6rB4H+Ew
 ZjHt/PvAwmzjeeoOZHYjYYQ+dewj1ptellStyN8sCL6ePwf8DXV+3D0TUEQ1qfxUrwvkj9vP4VS
 sH/zNeVlP1GGky6d3Mztto7Zm/gXjqa4LlPI6XVkBgrVITvQQAiP4EvK34WRSzCaqCtbQ7Yj8Sd
 VonBgOgUEZnRSWmw/VzbDcAiCPiy5UslT+sfVm++IqSIEmabUUHImv/fKssgbSf53qDXzO8pvA1
 hM1ul+Kq5a0AoCCeVTxWtvk9/+A5/tCcmU3GusBW8qH167VYyB7NmLn7dqTYmfkmTSc4SgJ5CEp
 PVnV0zahyPY0v6NzHaNAlgVRDyrD7659tZxM2Wt+fYzIj+q7wjjFrYutMFuxBro5LT7WkhgNO08
 OGLkeCXl466Z4cOvLkw==
X-Proofpoint-GUID: fnBq9_CI1Xx4xJjt7kkBHLnoNUa4UkWd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060120
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

On RB8 hardware, after drm_dp_add_payload_part2() completes, the
downstream MST dongle has a high probability of silently dropping the
short-pulse IRQ at specific timing windows.

Implement the .poll_hpd_irq topology callback so that the DRM MST core can
proactively poll for unhandled sideband events whenever it suspects a
missed IRQ.

Note: The new MST series will integrate this change into the introduce MST
IRQ patch

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_mst_drm.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index c8623849c001..8cc44dcc37cd 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -60,6 +60,8 @@ struct msm_dp_mst {
 	u32 max_streams;
 	/* Protects MST bridge enable/disable handling. */
 	struct mutex mst_lock;
+	/* Serializes HPD IRQ handling between IRQ handler and poll_hpd_irq. */
+	struct mutex hpd_irq_lock;
 };
 
 static struct drm_private_state *msm_dp_mst_duplicate_bridge_state(struct drm_private_obj *obj)
@@ -500,10 +502,12 @@ void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
 	unsigned int esi_res = DP_SINK_COUNT_ESI + 1;
 	bool handled;
 
+	mutex_lock(&mst->hpd_irq_lock);
+
 	rc = drm_dp_dpcd_read_data(mst->dp_aux, DP_SINK_COUNT_ESI, esi, 4);
 	if (rc < 0) {
 		DRM_ERROR("DPCD sink status read failed, rlen=%d\n", rc);
-		return;
+		goto out_unlock;
 	}
 
 	drm_dbg_dp(dp_display->drm_dev, "MST irq: esi1[0x%x] esi2[0x%x] esi3[%x]\n",
@@ -516,12 +520,15 @@ void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
 		rc = drm_dp_dpcd_write_byte(mst->dp_aux, esi_res, ack[1]);
 		if (rc < 0) {
 			DRM_ERROR("DPCD esi_res failed. rc=%d\n", rc);
-			return;
+			goto out_unlock;
 		}
 
 		drm_dp_mst_hpd_irq_send_new_request(&mst->mst_mgr);
 	}
 	drm_dbg_dp(dp_display->drm_dev, "MST display hpd_irq handled:%d rc:%d\n", handled, rc);
+
+out_unlock:
+	mutex_unlock(&mst->hpd_irq_lock);
 }
 
 /* DP MST Connector OPs */
@@ -749,8 +756,16 @@ msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
 	return connector;
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
@@ -791,5 +806,6 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_au
 	dp_display->msm_dp_mst = msm_dp_mst;
 
 	mutex_init(&msm_dp_mst->mst_lock);
+	mutex_init(&msm_dp_mst->hpd_irq_lock);
 	return ret;
 }

---
base-commit: 3ef088b0c5772a6f75634e54aa34f5fc0a2c041c
change-id: 20260606-mst_irq-4d46e72137aa
prerequisite-change-id: 20260410-msm-dp-mst-35130b6e8b84:v4
prerequisite-patch-id: 8b3f7f40025e7a10c4646435e9cfec4f9e275871
prerequisite-patch-id: 017d8e6efd9c8f120d0a7dd89b3e6c358fdc2126
prerequisite-patch-id: 010d0a4f1a67dcbcd29ff183e8bcb0d043e2c26d
prerequisite-patch-id: 547db98962f20218380e966b976aede824ff8433
prerequisite-patch-id: 1867c344ef6ead1034523ba65d2640f9ad0606cd
prerequisite-patch-id: a58ebaf429385c622869c83e83ce7ffdfe9ea27e
prerequisite-patch-id: d0f570e57559248ba6ca733f96fdb02af29f3055
prerequisite-patch-id: 44d390f5319068ad534c4be698dd8dba99c0bfd1
prerequisite-patch-id: 85438690573583cf62065f43531dbb4e221e9dd0
prerequisite-patch-id: b37db0f0b10f16ed45ab056aa87f2275bb02df94
prerequisite-patch-id: dcccd204ee8a979328719d41334453474bcfdf98
prerequisite-patch-id: db07c3aa80a597c91ae2329bc677bfd72b63716a
prerequisite-patch-id: 9778cc1ab60a0870a74d58ff220bb01011fdf1c0
prerequisite-patch-id: 95692a605647e51bdaf8d5b2e61635a6978121f0
prerequisite-patch-id: af51d259753df3795c9fe16bc1f8f98d0f525bd5
prerequisite-patch-id: 68f5e67439fb83ea39fd82dd8559a20c99e56b6e
prerequisite-patch-id: be0f4b80697df7224c80362b161b8a9f0a542184
prerequisite-patch-id: 0af9e48f1e0b698557303ada9aeb226e5b7f7561
prerequisite-patch-id: 3887553893357c1ffbda99eb010801bc2166cbad
prerequisite-patch-id: 3ce7fe5264dcef7ff752837c525791de84f2669c
prerequisite-patch-id: 3e635f008f9b56823101abd9253905f078fcb3b5
prerequisite-patch-id: e39e0dc124ed043c7a419610ebe03ad105da27db
prerequisite-patch-id: 85bca44976ae5e7f2f2aaff91478dce62c65a9b0
prerequisite-patch-id: 4f87805ca60f2c816cb8e20eb1bcde5f1ab1f809
prerequisite-patch-id: 755afef095a10fc5fb6d5946cb9af5026cc3f34f
prerequisite-patch-id: ee83dcca3c614dda1073ee42a07c48d9f8424e5d
prerequisite-patch-id: 68b1b8605e582f6ba826bbec74eea643e7eb7116
prerequisite-patch-id: ab8fc659c8805c19ed0d97ababf47a98efe17b6a
prerequisite-patch-id: 8d84e97e9abb207e151fa3437d57dd3261e80413
prerequisite-patch-id: 27038c091f1176d8ab9b28551eca3fa4d60964f2
prerequisite-patch-id: cd061c6c74c5ef1326d91b8bcac2ab1f0afc025d
prerequisite-patch-id: 68aa5463159f226f33ad4d59b38779cbcb65a3ce
prerequisite-patch-id: a6b78895c4b94c5508312028e0f6bc97b331821e
prerequisite-patch-id: 52f00ae0a5c7fdca8c8d026be2ad4078c229691a
prerequisite-patch-id: 4cf62cd1cf74ec67c8d3f3d0857c522d24f87cd5
prerequisite-patch-id: 59a643104d4d88f5f7513b026c3743873af89c51
prerequisite-patch-id: 81cb1cae4c4563a2cb96327a3d4e0bd18ea5a8f5
prerequisite-patch-id: c5ea571615b6728f3622104e726f62f383c6e607
prerequisite-patch-id: 7dc0efb1bafa6752af3ed46c99b34bacb14388bc
prerequisite-patch-id: e84e884e747390a7b7a0f1481fae91ac5a8809da
prerequisite-patch-id: 56d282f6950ea9b3c6737da0e2ca78ebde8b199a
prerequisite-patch-id: c19b234de6e7c0f505148386f201e653da1052c3
prerequisite-patch-id: 7859b691e9019d31d167adb10cbad3e39af33489
prerequisite-patch-id: 5685ad34e365343c03d13fed0a20ed4a4afe7f7e
prerequisite-patch-id: a1722149fbd725c1b5d3a610b2532fe588461cc8
prerequisite-patch-id: 0e8158a6e2c8b54e308e0ea75de91f823aebe1bc
prerequisite-patch-id: e12fd2908ca33de1f1265fd40190eaad8637e569
prerequisite-patch-id: 1d8af90cb7cc47ba27877637262c4046927aba6c
prerequisite-patch-id: fe50641762421af252fabb41b97b496539798151
prerequisite-patch-id: 915722dd72c8d485c33068cbf2ad2a87c783bcf0
prerequisite-patch-id: 45c0b5cf8735cf36c4b484edecaf8214f8b5a020
prerequisite-patch-id: e593f6149a649effe3252f663249c70b41d8d684
prerequisite-patch-id: c8d444e2a6512f106da2675d4a42a92208d5c6f1
prerequisite-patch-id: 85222573dc5e5bdb529de33fe19185338c154fe2

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

