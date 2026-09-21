Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149DCC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D62C110E1DA;
	Mon, 21 Sep 2026 11:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EdCdpnY3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Krk3n+52";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8C510E1DA
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:20:00 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAduZU2091279
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=QaRYYlHdJR0pZuCfEcUByL
 7RAlyPg9Deju/matmfvSg=; b=EdCdpnY38vnM4TygRqLFLbGpL60VuXlxdJk3OW
 hhHtKk/aYMgt39PySPoOMEVqbbaruMxH/w/nfuIK0CgIk3BprjuWnoYFcmzGkawC
 suMuV6E2rcXjK5YZpF7QGjiykEq3bi0EF+F2hWkqkMhv1nbWUS28jwSIgswjFqap
 3xXlkifzqO0/ExMV6RDbUhvnHDQ9LCT477rpYkWWeeimG14ATqFtyxK/hgVJZJm5
 MwkbWEETDhdmzY8QNCj4/yvUMSJjLyVlO2DMOSL2SoLi7go3scZ5kVH+sdWRwX7f
 cJ0T0h5haf4e32onnM5DVdrWXc945xY4DzK7h5os4ZNrWWCA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3wt2tv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:19:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39aee9b4cf2so5275285a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 04:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789989599; x=1790594399;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QaRYYlHdJR0pZuCfEcUByL7RAlyPg9Deju/matmfvSg=;
 b=Krk3n+52LhUgl/pmrglUiyjgrCwdyrc2RCmN4ZPbn1W32cdwmAd/XluviubA3WCxZb
 bAQ0jKzGusqT4kVVQj/Kwl6prKs/vMcdICkvYgArsChZUaSBA5LT5F8sF3FcptJ62Uyz
 8OxXv6Rnxl4A7GyBja90ACWwLw0D3qfmVsHD484TvmON36SCkuK55+y26VZ+O3dkGKFw
 LfyIH/9HHiYsZG9FIqFJjUMOoKmi4lav6II9VcVSiXVjEhFu0vC3YggQFIDmxWDkKKHu
 spfpj/RjxCb7zKa0bFihmlvC4mC/9sUxwSoLDMX9wLHjjySSWhhBQnrNuqHSYciEU7Yf
 cYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789989599; x=1790594399;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QaRYYlHdJR0pZuCfEcUByL7RAlyPg9Deju/matmfvSg=;
 b=T3HEbp2h179vGoyD2FdzvVChRcy5GyH3EoCYNp0YEQcK9rfmtXFkT5POQL9znPjmtj
 ZPeljdeWeOzwcfYKodgfQeDVLzkvUEVXIDihPtXostsXKwBbpaBep3bbTBN+UFOy0AwX
 E/o6HiTZQ7D8kzErY/GQNPOAKV8G844gpICLvTRhLmbDLRUAubBGo6FbaX5az7JADym3
 2h6tSBZoUcdXEdOwhmNOWuFHpTe5PJlUA+I+au6lSpbtrX3AU9/vjhkJ6a0dwew6v17Q
 A3FI9D4VQFkLq5g8I/EUKbsGzCHj9nqIIEXqRQ0oaslO/jJGhE8H22Q5mM+duuo0LIbp
 H0tA==
X-Forwarded-Encrypted: i=1;
 AKwUvBySkCsox5+Di0TVhvfmN6eM6qpeRbskSHqMzds/oN4L0ngJigUR3riSPiskXrOY1BZjMZel9bNbOg0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kNsYplaz9SNvtGiUam3fA7/A2pgZi+yJDp1bAgO9MrS1jbaY6Q
 d1k7qaJwizGaJ27scLmeP3Trvwu+NufQFHtChGj26lYtoy+GOeTU+v3Kpmm/cVGanyJatTW1mtr
 S0jABnErCGrHafuOKEpfRgZIH443vgqM4xhx2Lqsnhkmbwi+CIfjJXitCQmjRJ8Qx/PYofb4=
X-Gm-Gg: AYBFou39VC3QsXdDt9SmvV8hEKwLeb0bdg/I581EFAntg04AxrFVQcIhlANsr93rJP4
 IC1Ic0lfxgHKC3mzdnMVaH09hWYH0QMWxZu5AC7t4l4TQMvEZhi6z7wH8F0RnYElj1zSi2nq739
 X68USjzpr5U6SJBx6+9r3JogT36y5l7wV9u1XQkuN0td3WqYSjm9+uEou41Ha80imj5zS5cet6C
 FRuWvjce59ymVZs37Am6BqsQ9N0wldygcfTibZckvu7XJcqVLcI1dQz9mha2jfI7u0Q5tU0BeiF
 Vpl5aJlzoV7ylJr7KPEY+gSNJvxpxOJrf3VW63J/SWX4KdAavjqEaBkPDuaTxt6GaOsYjLzB530
 0TtRhcEojqdX4pg4icLAWrriANg==
X-Received: by 2002:a17:90b:4b85:b0:3a0:42a9:9c73 with SMTP id
 98e67ed59e1d1-3a042a99fd2mr3762017a91.38.1789989599204; 
 Mon, 21 Sep 2026 04:19:59 -0700 (PDT)
X-Received: by 2002:a17:90b:4b85:b0:3a0:42a9:9c73 with SMTP id
 98e67ed59e1d1-3a042a99fd2mr3761984a91.38.1789989598664; 
 Mon, 21 Sep 2026 04:19:58 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3318c49dsm18841601eec.22.2026.09.21.04.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 04:19:58 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:49:52 +0530
Subject: [PATCH v3] drm/atomic-helper: tear down HPD/polling in
 drm_atomic_helper_shutdown()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-dpshutdown-v3-1-e456ff7fbe4c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANcSsWoC/23MTQ6CMBCG4auQri1ph0KjK+9hXNA/aaIUO1A1h
 LtbWGnCZpJ3ku+ZCdroLZJTMZNok0cf+hzVoSC6a/ubpd7kJsCgYZJLagbsptGEV0+ZkEcOTru
 GKZIHQ7TOvzfscs3deRxD/Gx24ut3l0mccqpYAxqcNE7xc0Asn1N71+HxKPMhq5bgR6jYnwBZE
 II7XdeiUtbsCMuyfAF2Vfsb7QAAAA==
X-Change-ID: 20260717-dpshutdown-047912fcf60b
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789989593; l=4926;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=Q0G7YNbj2kfMO1cVV8mx/fxMq/j/xlphxp53srsMh3I=;
 b=b9aBRD5L+zkU1K8wu9nPTEKi0SNETznDzFKwF8EzrwNJ6bnMOaMco77WyLhIszFEPtV/QZCQ6
 nmQJiG+8FWjB5ojpKLbNR/KnLsTIgCdEtXT8VxQ/bljDQZNa0bdgqJg
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2NCBTYWx0ZWRfX2O6VsSMdAgDF
 TMIgWaCox71XJwhnpCeJio5oW4o/buM0pYBlNUjpaQ4IGs+YoTxT7bWhCfKnznuFdp5xcaShoGb
 HstuCYG8jUJJV/PET/Qs248gYPaGsoAB1pGv4O2sN89FgXrHxNi8iDHQu1AC7Wpr0BG7EAlgGbt
 YVQJaaHIE788Hq2l8HYasy4vAk2FXahmrswkipsv2wWCfI7WmUzx2aZGaDSA2En5LPMk02Ndv//
 DNJz6O08BuWYZ+bePcjj3e2dG+Pgb7k6h2C93KNu/yqsDObCUqNZ/LV2184I9aAQdJX8f+wKnuh
 o9LKzEZojJ2820HY3AVygIanV9q2JGUBryEDdFHuUOZS5mQGpGubbjKyfwvJDrcDrmfshK619s4
 P1FHUe3uvHsHLnT96qMGGGrj7KfhsieR013F07/soaO6c2q8+GTND74J1Yn0HS36N0vfR9QeGGH
 i3tIccaaTSEaMQ8xCrA==
X-Proofpoint-ORIG-GUID: JriNKY9cuimZ-OwdCMH09PQquNb__72o
X-Proofpoint-GUID: JriNKY9cuimZ-OwdCMH09PQquNb__72o
X-Authority-Analysis: v=2.4 cv=dakVTnXe c=1 sm=1 tr=0 ts=6ab112df cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=olRUzlJ4id4ZNEiLAuQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2NCBTYWx0ZWRfX4ZHsHug+L0Gz
 GnSLvQ7Wx381nG0+HS8mQD6jBl2h8EDCKjKa7P0ikdamD/Sy1684noFKncpjEy0bgVUw42q7gK+
 uNJqKFaG7nqr+XevHxcE+GDJM/kQPNo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210164
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

drm_atomic_helper_shutdown() disables all CRTCs but leaves output
polling and IRQ-driven hot-plug detection running. On reboot, a late
DP hot-plug-detect (HPD) IRQ can fire after apps_smmu has already
disabled translation for the display subsystem, causing the HPD
thread to kick off a new modeset that drives DPU/DP hardware and DMA
through a stale IOMMU mapping.

drm_atomic_helper_shutdown() disables all CRTCs first, but a pending
HPD IRQ thread wakes up afterwards, reads the DPCD, and fires an
unsolicited hotplug event that triggers a second atomic commit
turning the display back on -- right as the IOMMU is disabling
translation:

  systemd-shutdown[1]: Rebooting.
  msm_dpu: drm_atomic_commit: committing (shutdown disabling CRTCs)
  arm-smmu 3da0000.iommu: disabling translation
  msm_dpu: drm_dp_read_dpcd_caps (late HPD IRQ thread wakes up)
  msm_dpu: drm_sysfs_connector_hotplug_event: DP-1 hotplug event
  msm_dpu: drm_client_modeset_probe: DP-1 found preferred mode
  msm_dpu: drm_atomic_commit: committing (unsolicited, re-enables display)
  dpu_crtc_commit_kickoff: crtc94 first commit
  arm-smmu 15200000.iommu: disabling translation

Call drm_kms_helper_poll_disable() to tear this down: it stops the
output poll worker and calls each connector's
&drm_connector_helper_funcs.disable_hpd, which for HPD-capable bridges
masks the interrupt in hardware and then waits for an in-flight HPD
handler under bridge->hpd_mutex. Suspend the in-kernel clients as
well, so that a hotplug event which still gets through is recorded in
client->hotplug_pending instead of being probed and committed.

Reported on Qualcomm platforms such as lemans-evk and monaco-evk
during reboot stress testing.

Assisted-by: LLM
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
Changes in v3:
- Use drm_kms_helper_poll_disable() instead of drm_kms_helper_poll_fini(),
  guarded on mode_config.poll_enabled. (Sashiko AI review)
- Also suspend the in-kernel clients. Masking HPD is not sufficient on its
  own: it only covers connectors notifying through drm_bridge_hpd_notify(),
  and a forced GETCONNECTOR re-arms HPD via
  drm_helper_probe_single_connector_modes() while poll_enabled is still set.
  drm_client_dev_suspend() keeps the resulting event from reaching a commit,
  which is the drm_client_modeset_probe() path. (Sashiko AI review)
- Reworded the kerneldoc; v2 claimed only that polling and HPD were torn down
  via drm_kms_helper_poll_fini().
- Link to v2: https://lore.kernel.org/r/20260730-dpshutdown-v2-1-441fc5543bed@oss.qualcomm.com

Changes in v2:
- Dropped the drm/msm/dp local .shutdown patch (disable_irq()/
  synchronize_irq() in dp_display.c)., fixed this at the DRM core
  level instead so every driver benefits, not just msm_dp.(Dmitry).
- Link to v1: https://lore.kernel.org/r/20260717-dpshutdown-v1-1-b062c2f7dfb1@oss.qualcomm.com
---
 drivers/gpu/drm/drm_atomic_helper.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 9d006f98413a..3a23777aa00f 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -35,6 +35,7 @@
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_client_event.h>
 #include <drm/drm_colorop.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_device.h>
@@ -42,6 +43,7 @@
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_self_refresh_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_writeback.h>
@@ -3676,6 +3678,11 @@ EXPORT_SYMBOL(drm_atomic_helper_reset_crtc);
  *
  * This is just a convenience wrapper around drm_atomic_helper_disable_all(),
  * and it is the atomic version of drm_helper_force_disable_all().
+ *
+ * Before disabling the CRTCs this stops output polling, masks hot-plug
+ * detection and suspends the in-kernel clients, so that a hotplug event cannot
+ * probe and commit a new mode once the CRTCs are down. Polling is disabled but
+ * not finalized; drivers must still call drm_kms_helper_poll_fini().
  */
 void drm_atomic_helper_shutdown(struct drm_device *dev)
 {
@@ -3685,6 +3692,14 @@ void drm_atomic_helper_shutdown(struct drm_device *dev)
 	if (dev == NULL)
 		return;
 
+	/*
+	 * Don't disable polling if it was never initialized
+	 */
+	if (dev->mode_config.poll_enabled)
+		drm_kms_helper_poll_disable(dev);
+
+	drm_client_dev_suspend(dev);
+
 	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
 
 	ret = drm_atomic_helper_disable_all(dev, &ctx);

---
base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
change-id: 20260717-dpshutdown-047912fcf60b

Best regards,
-- 
Mahadevan P <mahadevan.p@oss.qualcomm.com>

