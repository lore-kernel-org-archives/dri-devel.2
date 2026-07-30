Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E050C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A4410EEB6;
	Thu, 30 Jul 2026 12:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o+Srbpp6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gn1y3JGf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DC110EEB6
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:46:45 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UBWPcA1144791
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=BqbrmHoDLhgXhTFX5QmIyC
 tjQJ8YVIbFwSlJNmOQKlk=; b=o+Srbpp6NQVjwn7F7wSHgxJCd1fHqMQ0Kpz3H5
 W5T++fttx3gpwLCiaRFoQRS8BYHK0Z8MGodB9+OAWskvSMLFvQZ09MY4gt7DLPcl
 UV4+HavGsw31ITktZNT1Jvkxbj23oJcQA3uZTkZQJVYWW+0igybwnQcNXY+UtYb/
 fLAT8SzF1inBPk8WM3g2gsBjlNcJZcydolznKeLi/cWGv7SYS0N80XSjzER8PKGw
 YjohthjT1FPIcmlH7dlBge+VZmu0RMYWYO0KRBDX6wYAZaSQ4fenXIxuxEYiUD8+
 yyyjCRPK9qk9CHDIeMslWMXAievamMtKEkZEjB/Eo0QM7D0Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr5tvr8xb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:46:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so1723337a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 05:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785415604; x=1786020404;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BqbrmHoDLhgXhTFX5QmIyCtjQJ8YVIbFwSlJNmOQKlk=;
 b=Gn1y3JGfmGN9NFs2kVcBWXTl4e7uzT1B/uKYEfdbRHPuVLlMkd81mrr6w1mViyqiTW
 2odOtAHO2yWz4tjNJ2ex5TuriWI7rVrFUFKnjLli8Kefho10K55uMMF059q6s68muTN6
 D0TByXtl8d1mw5ySeoYmaNW3NYLJOBPBJoGuQVa+ixhvDe1mkj6n3xPXJm3H8mS2eQIN
 X7Z9Jx7OReaAUQ681eo6qAJtsBK+hcX/Ey2vuMHzDGpQnXM77rQnWOkBum+B8KS6WHih
 AkZpIheS8zxVEtGMfiNGnDX3ttqkZmtvbsr7oFsDQTSoJ5be9qdqQVzrvGJs1hrwnha8
 yGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785415604; x=1786020404;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BqbrmHoDLhgXhTFX5QmIyCtjQJ8YVIbFwSlJNmOQKlk=;
 b=JtBuQfk0uF4cmqoie09fWz3cRSXGQaoEr/kmajSzvB8cs9xIy/MFw8uVvp/9JiRCir
 oVrCJAI4SrViwZIUpvhn2U/dloBZnENl6QFifyztyoKNg/h8Z5b/CHqAf0i8rQokgttu
 U+xRtD4IbmJ3uNVAYE82bbXY4lRJUIf0d70gTMOu6zNbTL2LfiKZe61Og+k/y4kBBZog
 y8wBdJqbNJdXeIpWw2dPq+5wWNGRaf+vGZu/95BiR0jcyBdYuyC3PlqNCM5jbkwxVj0z
 FJ+SCQeRVr32pqEupaNk3XOudxD/W8FdtrdJAQiWQ22lyyAmff7xN1SD/X+evkAoOwDR
 kWPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDbpZFnb406heJYw75N4wxCWwpbNAJT+u/Bb52baVPFkZbDY49tUjqv2hMqz9uIBIJT8z4vRB04/c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNX1QQhflxLRI8aqzgOXd2SlIxWPPQo7w0Q9on22dGKJiFfWpo
 t9omOn6rPOIa6bKTn7y5cyf6DOouQt/0aicMlwZf6ouA1BcquvoPBBhGqxQbG7R+G62GQBBBZHC
 4X7LqRN1WwafL9r+CECAdhH90gL559HclS/NFKvzwgUQ1rK/sPbDJNLDy8XTtBpWoFG6QIpw=
X-Gm-Gg: AR+sD13YE77x00IB/YTXfJYt6/xVCDeaefSC2ADAimXnstL6OsdEdJrMR54Lr21NBY3
 rjRdk1QHs4qBEJIu2NbY9Mr/6pXcXpdW1OTa75i8J7FySzrrNYx+eZlGq+lwvLl6XCVrzGR4ssG
 aF5XpJdxIw2ex01KiLBemMlaKjXQAeh1PpFXhG8TW6iBhEfASiPgurLoqgSt2L5t/XVFqZWGmmY
 Gglx99oSi2qMmvcupcHz4sj9PcW0DhqsyZ5wDrWwDkLIzUWhbZfiKGATTAHkTWzVS33hEZm1W5s
 9r05zQTGSkbUEVgw7EaZ/JLnkti5aqfKxDmbN0Jl7GrILp+3HUG/N2EUWeqHO9lDWPCxuVsQsPb
 37BTjOs69sZVt76QWFW+a34Jc1hc=
X-Received: by 2002:a05:6a21:3212:b0:3c3:8315:80b7 with SMTP id
 adf61e73a8af0-3c90066cd34mr2432468637.9.1785415604058; 
 Thu, 30 Jul 2026 05:46:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:3212:b0:3c3:8315:80b7 with SMTP id
 adf61e73a8af0-3c90066cd34mr2432429637.9.1785415603465; 
 Thu, 30 Jul 2026 05:46:43 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb824d421sm2137336a12.10.2026.07.30.05.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:46:42 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:16:26 +0530
Subject: [PATCH v2] drm/atomic-helper: tear down HPD/polling in
 drm_atomic_helper_shutdown()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-dpshutdown-v2-1-441fc5543bed@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKFHa2oC/22MywrDIBQFfyXcdQ0qRWlX/Y+SRXxVodHUm5iW4
 L/XZt3NgTkwswPaHCzCtdsh2xIwpNiAnzrQfowPS4JpDJxyQSWTxMzo18WkLRJ6lhfGnXaCKmj
 CnK0L7yN2Hxr7gEvKn6Nd2O/9mymMMKKo4Jo7aZxit4TYv9bxqdM09W1gqLV+AfXYiAKrAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785415598; l=3268;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=EFGTEjAar5YhWvy8+yn14BXjJJUj+nzWsgy1UuC08vU=;
 b=Eny1S2NirVpYVYcbGMfZ4+XgUkdnQhmG/cIII5qgjK70slzsbxMRLPZkzT6DqbbzX/nCsSBt5
 bRJTZ7HzH5ZDfzRraZnrlLkGiGyPT8FH7L7tWVfTYzb4gmVWCg2Yaoz
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfX38OPq4TGyxCZ
 jeiFvhNdVnqS7mh5Hmh8dRzLe1LO2wTcSAgvB6UDNeIOn+latKWVQeMQTd2lfnsg+jXvY+60iAh
 xKvqosJoPzMothbluL44vcHklkPVLp4=
X-Proofpoint-ORIG-GUID: tlo3noJ2TSiDA_xBBBXh7DdBp1-Hyxfe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfXxt5S/l8SNPGs
 BtTnMWIOjiCBsviOu/wKxJGqCwlD6+zCwLpxnygAVov27OOXiTcgB4nrzPlmD82TrRd+mPbXcI5
 AqNWfjjUXU2p+MXXvlHv3u3wqopVhLuHiF4zQbN/5nZmPOdHNMwppM4DdQ7XP+1N3tfsurp75OD
 8+JKFdcqnTgD6lHMW8DbLws2Kw0QU/yTckbH6T3CT1YKVqpN6H3w2agm9YjtuEaXzx77e6gd/+j
 aVulC9hdDGn24ziRYYsQgrZDcW7ibqfqBNLgqPpbBK4oQIJF3TrNnAK/Dz+kxGBLDrmDQSVTRnw
 TQbFBR2ZKlx23TodIU531RAhY9WOYPu8Dxem0VLPt9SiTfHLDfDG3TDbIKRVuvW1SauFN+0mIdL
 OBqIFm/hxDZwb624ahKPlP9AakiKmO8rHHwvHonTTFtLLaFDcn2jStRoiBwYPon7rLsH8iy6JbT
 yCgKRJ1R7qBUU1BjX7w==
X-Authority-Analysis: v=2.4 cv=ULPt2ify c=1 sm=1 tr=0 ts=6a6b47b4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-dNxFGlIl_otlAVcVrYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: tlo3noJ2TSiDA_xBBBXh7DdBp1-Hyxfe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300096
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

drm_kms_helper_poll_fini() tears down this: it stops the output poll
worker and calls each connector's &drm_connector_helper_funcs.disable_hpd,
which for HPD-capable bridges masks the interrupt in hardware.

Reported on Qualcomm platforms such as lemans-evk and monaco-evk
during reboot stress testing.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
Changes in v2:
- Dropped the drm/msm/dp local .shutdown patch (disable_irq()/
  synchronize_irq() in dp_display.c)., fixed this at the DRM core
  level instead so every driver benefits, not just msm_dp.(Dmitry).
- Link to v1: https://lore.kernel.org/r/20260717-dpshutdown-v1-1-b062c2f7dfb1@oss.qualcomm.com
---
 drivers/gpu/drm/drm_atomic_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 285aac3554df..80c67623180a 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -43,6 +43,7 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_panic.h>
 #include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_self_refresh_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_writeback.h>
@@ -3676,6 +3677,8 @@ EXPORT_SYMBOL(drm_atomic_helper_reset_crtc);
  *
  * This is just a convenience wrapper around drm_atomic_helper_disable_all(),
  * and it is the atomic version of drm_helper_force_disable_all().
+ *
+ * This also tears down output polling and HPD via drm_kms_helper_poll_fini().
  */
 void drm_atomic_helper_shutdown(struct drm_device *dev)
 {
@@ -3685,6 +3688,8 @@ void drm_atomic_helper_shutdown(struct drm_device *dev)
 	if (dev == NULL)
 		return;
 
+	drm_kms_helper_poll_fini(dev);
+
 	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
 
 	ret = drm_atomic_helper_disable_all(dev, &ctx);

---
base-commit: 1a1757b76427f6201bfe0bf1bea9f7574f332a93
change-id: 20260717-dpshutdown-047912fcf60b

Best regards,
-- 
Mahadevan P <mahadevan.p@oss.qualcomm.com>

