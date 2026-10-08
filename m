Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF260CA6011
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CB710E100;
	Thu,  8 Oct 2026 17:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dVexsgrQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EqB6fAH6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D9A10E100
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:24:23 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EVt7x3517944
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 17:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vh0YPgpHG08+z15G0fuaIz52HDEGHaPT1TQypFpPpMA=; b=dVexsgrQ2Lg9mBkD
 xRro/PMYDSTp6rJV8KrfrIneH1cqSkAzzqvdIOIg2ZNVKgduqQC/rGe5B0+WPzyT
 Gu7rXLNTxk0KGJO+6HSJMYAPcuk2TP6M6KVAhg4WuFdbrqCI/qKfUHPAFolNkAzA
 +Erhzore2+aWx87cnCkQholEGaclD4YvBU+FjPcCvzsCMSuggjC2yY+Hlu0ATjfu
 wrZbMTgKFSW9OC2F7Xvqq3ZIYYCRB/9Qg31qxWwKRtsgH3XG4qbn3Xs69SGmbpNB
 dyKZDUmw2zFFj/tRviVNAE4AJk/KbEgGXCQbQ1vkLmBLk4tXgrUH/IX8+ow+0Zjm
 K5I6+A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe83wgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 17:24:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a47a81e70bso5584378a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791480261; x=1792085061;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vh0YPgpHG08+z15G0fuaIz52HDEGHaPT1TQypFpPpMA=;
 b=EqB6fAH6G+AQPsOlBOCuro3MHQundLh5jVWUG3O/Ch+oJBZv6gfn1/FvdO4u+HraRc
 yGsD4UBeF2PyFGYwosA/ItuXN8E9aFLq/PTwuHO3/g1UjE7hHxL+IC3+F+S8WoRUh983
 cw9z3gAO83Xu4I56xA3yZumDjF+PxcQ26MpAArVnSa+1a5Ud9UVWl9SKrjBEB6HZyh2T
 WR+y/h1KtAg//g8mBNN+14XqbW2tqnWeUpuIGg574YUYhPrDi4FBj2wsiRWiujTm3vVF
 8HIgdpacw4OApeoLfZ+6/lhfUTrjbSl6XUW+uCAcaO2IQl7tqsFB7Nu/PPB8COWU0DC8
 iNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480261; x=1792085061;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vh0YPgpHG08+z15G0fuaIz52HDEGHaPT1TQypFpPpMA=;
 b=dN8E+cBmXk8UU4Fl75fboDJvV/2PMEBVzk31RK+zaidHhy6WXJ4BZ19kQZwZyv7RQi
 86TfE/TW7mOlLy8vqR+IRc7MDFtvipeV5GEUu77DTH0ZYJdQ9rjUGAIQ8zCiOh9GS6Wa
 7PMWhywlKhrWKh/frjMIxHE9X81CXnaYSGkpypkJjgUx1AaMgSxTqJoqXbDQwBpSB0SI
 oOZ+o4157xHXxukXls9WqCMrW1SadqyQ6EE8UjlA+34h2+MjBVpDqFApMb0PYZxWj4qe
 kEMsPWn9/EcSJ50K3mMmtzhXrTSJTnAf0ih4pCiyd2cdPrNiKp4PgW5kjmbLLBV9npyb
 Ui9g==
X-Forwarded-Encrypted: i=1;
 AKwUvByPfOFQGlPX1KTmgzc2ilXhgsQqkDUa1gCw/b66OKPs2Abe1mM1NTGo6CZft0vsvWMqvRE9ktTuZ84=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJT0KN70p1jH4qqx2uTAWSrl2oCsJWDyxuyn/W6+CXnTrK/XmkO
 Y2RElKThjXQOLcWMvBykElAdWil4qaw2RTKKOhY9FJOkHKIsr4iDtXOF/g2mwMk530+DsZSk13F
 9xOK9asI/aHuziYSSzdtXI4IkNhvOsmRa3ZAnLqWMO/TcAxQKm4tEBxOnea4cnqLKOD30IG8=
X-Gm-Gg: AYBFou1GM36sZYnwhhjOUX+RAcRVMYuydXq8HIbfsiH44jZ+BPCxXVuSCv18mW0z4q+
 bL9uICZE2h5+7esDhSaSwIxZ1mxmOOWSQX+upI7aKO4taXrCBjb1brQEzhmYgJpET8EiijwtwIp
 lsQ0Zlq0r/ryKgFn5XjFNqZwYaj4I9GrPpF0vg5NjACNsJR61rwrRsDXNthBRK46OQ2wvMdEKGo
 9JEb+HLb2Qxao5PeD1xL38SkjXLk4DpqhzJKAXvh7ku52qWAHujY+y7PHUi0+XKQ1Xd60TzZM3v
 um1Kplh+vxxukKo7XxU4MvfS4YTD0Q3Y7G0XBnyeYWEvfri06V0eQ8fe2InANIFENJdIXyHWbv6
 9/TXEZcZcJlBUed9tpEXtwkqDgQ==
X-Received: by 2002:a17:90b:2884:b0:3ab:3131:5c65 with SMTP id
 98e67ed59e1d1-3ab31315f95mr225652a91.8.1791480261399; 
 Thu, 08 Oct 2026 10:24:21 -0700 (PDT)
X-Received: by 2002:a17:90b:2884:b0:3ab:3131:5c65 with SMTP id
 98e67ed59e1d1-3ab31315f95mr225622a91.8.1791480260876; 
 Thu, 08 Oct 2026 10:24:20 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3277c459sm47228a91.16.2026.10.08.10.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 10:24:20 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 22:53:47 +0530
Subject: [PATCH v4 1/6] drm/msm/dpu: split modes a single layer mixer
 cannot clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-lm_fixes_final-v4-1-fa986071c3c1@oss.qualcomm.com>
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
In-Reply-To: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791480250; l=2937;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=MnyWJ+SO3iVE/KBDqM+VhT8LcMf8ChXq7BB83zMO3hk=;
 b=4c6pDXhR1kZ5t5q72Ly3Q/VqiVwkXneHI9x6vfrwARO/BKVLjo3GdiTa1UiLNQQnZtdisKxtN
 4Ry5ZxmvsfyCxnAq8C/gzrgTzC4M0U+1yjdLDCaxJeNqNYcYLFqzRF9
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2OSBTYWx0ZWRfXw8KA1JrnpCJZ
 rkeIU385LUv5Z/tHWT+sVuP3YG2gkxGdjZDZqS9ASeUzcwEy2PVfeHORdlTfILaDpFGTutqPjsa
 nGcj289b6FzY6B9ZxYtrRVz1d3XntNV8j0aupKILDf8lRxSRqXHNnxy/ZBVFJJy+P9IMC+49pg3
 J8Sy65d+ItR7LWZysASf/MFTte00COx5gJ/AMDjJQ4+jncZChDnaK6iUuFU1bHJE7auwyPIWDBA
 vcdoOSyPrBGzZsT07gMXgUFed0cFu0lDf5jYvMhVWHq3zmHtVVi+fy2a8CvmNeeOeXuYrIsZb2R
 P/eSOhV3rN708uCI1Jk8YlQW28E2qHlxGGqFd8MeIG1889anOdcyN2qugIb4FSTY1+yJnPxczUh
 aacdmrl4wR1rTmPChjwAsr2xWQslam0/YOgQjfFdpwHQoGegDphUiIT13rAW19zmphpVwJzQHVd
 u9/vctiyCxToi3vqqZA==
X-Proofpoint-GUID: Vg1UhhT7h6_z_S4uH4aBPNreT1ElPDj8
X-Proofpoint-ORIG-GUID: Vg1UhhT7h6_z_S4uH4aBPNreT1ElPDj8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2OSBTYWx0ZWRfX93LepFckPRdO
 ROI+SdAMozz3/KJzMFxQrrAAp3GM3JaAFr6KJMptx/5ffC/e22CmZcTe8FAzyn60ewCzMfjK2RR
 1iGACxgJTANhsuV3bAV94+aL89Qgkio=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac7d1c6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=hBLlU2GVctrw3cDPktIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080069
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

The layer mixer count is picked purely from the mode width, via the
MAX_HDISPLAY_SPLIT threshold. Width is only half of what constrains a
mixer: it also processes one pixel per core clock cycle, so a mode narrow
enough to stay under the width threshold can still demand a higher pixel
rate than one mixer sustains. A 1080 wide panel at a few hundred Hz is
enough to get there.

Such a mode is currently given a single mixer and then has to be clocked
past the maximum core clock rate, which that mixer cannot do.

Factor the decision out into dpu_crtc_num_lm_for_mode() and have it ask
for a second mixer when the adjusted mode clock does not fit the maximum
core clock rate, in addition to the existing width test. Modes that
already fit within one mixer are unaffected, so the only decisions that
change are the ones that could not be driven as they were.

Assisted-by: LLM
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 77a2d1f6700d..0b51a4c5db57 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1376,6 +1376,25 @@ static int dpu_crtc_reassign_planes(struct drm_crtc *crtc, struct drm_crtc_state
 #define MAX_CHANNELS_PER_CRTC PIPES_PER_PLANE
 #define MAX_HDISPLAY_SPLIT 1080
 
+static u32 dpu_crtc_num_lm_for_mode(struct dpu_kms *dpu_kms,
+				    const struct drm_display_mode *mode)
+{
+	u64 mode_clk;
+
+	if (!dpu_kms->catalog->caps->has_3d_merge)
+		return 1;
+
+	if (mode->hdisplay > MAX_HDISPLAY_SPLIT)
+		return 2;
+
+	mode_clk = dpu_core_perf_adjusted_mode_clk(mode->clock,
+						   dpu_kms->perf.perf_cfg);
+	if (mode_clk * 1000 > dpu_kms->perf.max_core_clk_rate)
+		return 2;
+
+	return 1;
+}
+
 static struct msm_display_topology dpu_crtc_get_topology(
 		struct drm_crtc *crtc,
 		struct dpu_kms *dpu_kms,
@@ -1409,8 +1428,8 @@ static struct msm_display_topology dpu_crtc_get_topology(
 	 * enabled. This is because in cases where CWB is enabled, num_intf will
 	 * count both the WB and real-time phys encoders.
 	 *
-	 * For non-DSC CWB usecases, have the num_lm be decided by the
-	 * (mode->hdisplay > MAX_HDISPLAY_SPLIT) check.
+	 * For non-DSC CWB usecases, have the num_lm be decided by
+	 * dpu_crtc_num_lm_for_mode().
 	 */
 
 	if (topology.num_intf == 2 && !topology.cwb_enabled)
@@ -1419,7 +1438,7 @@ static struct msm_display_topology dpu_crtc_get_topology(
 		topology.num_lm = 2;
 	else if (dpu_kms->catalog->caps->has_3d_merge &&
 		 topology.num_dsc == 0)
-		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
+		topology.num_lm = dpu_crtc_num_lm_for_mode(dpu_kms, mode);
 	else
 		topology.num_lm = 1;
 

-- 
2.34.1

