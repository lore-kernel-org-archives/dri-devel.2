Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D763CA6017
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6CA410E85E;
	Sat, 10 Oct 2026 13:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="icTViPJY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="inHIt0wD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADDF910E85E
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:46 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ACUcnh3787113
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NVuepAtG3yFBy75PO2yidtbiFp0Pms1pBm5Hoccl02A=; b=icTViPJYJ8oZPqu7
 sF/InkucD+9yOsQPitDkhQM2SG6g54Vqkx5Go2Uu1/kCser23O0MJ2exEDsoK5R2
 x2mMyq0WvCplChqEFNulus8AFRX7MlrGAQ2NdK3GULHGMIUaOSZx54nRpRDnNRhj
 7v0UzFpDvPP5f3w6Qx3l9rPPzqajuK2U1IjRzlFCwseQxUcB9d9miCXega6Q7716
 T4IK82yGrL1iJIHGgKzc696jPyfVDRGSvUJiuzO4QgUNqappOgKGY3CKuV+D2yul
 ztOg5Gwk6i4p29YeJGd4Bb5bqv8vufBehzZbix/KrXnUOAotb3nv5qlSdZ5V81eT
 WlLuaA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dr7h2au-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-358856e5105so2293059eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791639525; x=1792244325;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NVuepAtG3yFBy75PO2yidtbiFp0Pms1pBm5Hoccl02A=;
 b=inHIt0wDWSBWkCD33gUEYKA2AYH8Q4U+InUWjhgTVHCX4OFteZ/VRRsifZa7gcxIpx
 /zYJkTrlOHdsfbTs02Pcyne+HQVBK9FHog7pXXcQRd7vdjVfsISVkAlxPOgN0B/i6Vx7
 mgjFtbjpMgez/ARipv1RKtf/yny+4gp2QeuA0Hkn7PgB3bBFiK7DXGwtrhExTUVqMdUq
 ofWrgHnhNjwnCIdApR8b4BlbBkpmXBf6luy3jcivWAsPW4d+RPYR6ZqNGycSXASOjZ/C
 OstN+zlAwPTrapTXGA3g/PUUzW8hKqBUeUmtHYZVcVbAWJPqzThKCbO3xRKjDbPcyYbR
 ymng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791639525; x=1792244325;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NVuepAtG3yFBy75PO2yidtbiFp0Pms1pBm5Hoccl02A=;
 b=tzSwjpllJJb4Spy6IdS6s+iC+nBrDRpstQs3xZwmgnbqv2gFvWhAMdhnWTC/etZUU9
 nTmkie1hvowfryi6tmFUF88N9gBkERPYS3dZ8INIQf7C2oZSg1OlPLIlQaVvj2oOZqH/
 QrHnlNVuDKF84vEii6Mwpotsb1uPbsCLNcu6kjeGVZ7NpQt+u2NbBpFnauB0g6SwI+aI
 3nJJp5384qys9pQIKdYBCTcLpjv0GWUh1kSZWwYlgb+1+F42Oz8lHfVF6wz/jX7A42BJ
 v5pTvUrTTB01RA0gljhXU4+670LPTX2OM7/ty46ntDbYK17MSVAHSJ8m1/dfvUdcmN0c
 jE1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxml9z/ZDeIotxFgXrZVq1SeawNQCUg7x3weJ3KAL6/M4dInyAkVy7FjMUPDUIZOk5mT8CldVT1Cjo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ6noTlQAK92bgN6Hyws8nkrnL+pCHAgzZODZk2gkgKotVZeKTf
 UbFzj3sYSOTL5rMVU7//uQtVpEuiqzwq7tv7ThgtX+Wi5/zceYmdPSUiry4g/DM2P5tT/J+bG26
 SOkkO3YP4yQg/t6IJefRvDYsig4AmzlJEFlpb7fvpZJc7wHNZy/F/+Zs2cPq5Uun59XZNccU=
X-Gm-Gg: AYBFou3ciRPkPueCP+NEn6RG10jc8CpKUhTnqj98fSlQYlXV3iBW+X7lXP81eEoAKPJ
 xEnUE7tPPVM7P7JFuWE+c0JE5tz5JzX61Fphdh9SlzCP6a7pYq4fb/Q0KtYkrqvb2lT3mDUkxYY
 M14GBPiw+zTr31U2LtREV7P4Z3jEiENykudj6glbCLqdCejZYL6vVGtgCcA2JO+BRMhxuq285uy
 0EUr4ZsBia1EowTqXDkvpWx0kfIBIicP2D/fSP+Rz6jRLGKUzIYO6TN0gJnZ8hARkKx9DoDOoES
 ro5+aYM+ZlxnBlZWrr/lTkAtDSo8tu7kiGXoMOW2koJazfXC7+30QIiNqfQDMUriKFGXJ0Mb7Q+
 Ho6SFns0KOM4c1Z8qFO+4U0xhUA==
X-Received: by 2002:a05:7301:6494:b0:341:225b:d6f with SMTP id
 5a478bee46e88-3537dfd8d79mr7074548eec.19.1791639524455; 
 Sat, 10 Oct 2026 06:38:44 -0700 (PDT)
X-Received: by 2002:a05:7301:6494:b0:341:225b:d6f with SMTP id
 5a478bee46e88-3537dfd8d79mr7074504eec.19.1791639523691; 
 Sat, 10 Oct 2026 06:38:43 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841579sm15232827eec.4.2026.10.10.06.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:38:43 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Sat, 10 Oct 2026 19:08:23 +0530
Subject: [PATCH 3/4] drm/msm/dpu: program the source split order for split
 planes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-pipe_order-v1-3-9d8bd29fd78a@oss.qualcomm.com>
References: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
In-Reply-To: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791639504; l=2679;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=p2JPtZc0aH2VqHHjrjpm5Ky/B1p6VEk1UEgl8YRNRVA=;
 b=jYsetJYzPBSCcEqXgN4RMOUE3NCK5Z67bnYMoYhCpSgesyRXkRNlTDuYahkh4EHWtdwaU1UJQ
 f383vCv6vAxAQCq2H8sQ4fx4S8mtxQGFlSdMghlO3tTV2BBb2gMsoCg
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-ORIG-GUID: jRuy8hYuLpyr_y9FUb_J6NCRxKkUhzQF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NCBTYWx0ZWRfXwwTZ1CeQ6AW7
 4Dv9hoHN6uRXlEJA/slBackyQEq3jBMG+9WLU9whnWYUscqL8ALol6AF/r5FInhsgsIGyWpgL6k
 4+3X24YAmCQnjGzc+gyVIOejpR6q96w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NCBTYWx0ZWRfXylkNp7HhMToB
 V1/Wrs8i4X8uUHfxtFmHiHXt0pqGrY6CuPDeoTmxNiC6nHUcn0uSULRRIFQHAPTcyhLEselQCNu
 O2+y+htMOuleqgxErMy28tZ9o2o5oMLDGYb8g8VciUo3S2387o1B7JAzkDY63KSDx+WBCpDzQeq
 OcWtCJSNa1UUO0uMXYDnbX1xptwgF/b1oQQ1LenUuIHnTvtRen8IBmJYD6GerA8zCBt2b6glZkS
 jL9MII86xESeGIWCfaObQQAtzWe3Ji9w9XZKlmYrO9b+ib7AKAC3zeQ8KsCUBm91Ohft+U/9Kdr
 PYqLotvK13Go60oh67XuYZ68+tt/ko6V1rM5a61VmQVNrmJDUTE3h1FmzD8qwJTvCFGZ7F7gT2c
 qgjZ3gYhl4skpqdWb7FTAQqS/0vri8K5GimZlYQFlamkfe0edYvvZ7fCraz17ypAlkaTqKwzCK1
 TyA0mm1uBwNdjt3jAMA==
X-Proofpoint-GUID: jRuy8hYuLpyr_y9FUb_J6NCRxKkUhzQF
X-Authority-Analysis: v=2.4 cv=asknmiZV c=1 sm=1 tr=0 ts=6aca3fe5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=MVEwI48i6TzORs2vkrQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100054
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

Virtual planes can use two SSPPs when a plane exceeds the single-pipe
width or clock limit and parallel multirect cannot be used.

Program SRC_SPLIT_ORDER during mixer setup from the pipes' destination
X positions. Set the bit for the right source and clear it for the
left source or a source without a sibling.

Fixes: 8c62a31607f6 ("drm/msm/dpu: allow using two SSPP blocks for a single plane")
Assisted-by: LLM
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 77a2d1f6700d..91152d937ba3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -434,6 +434,18 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
 		mixer[lm_idx].lm_ctl->ops.update_pending_flush_sspp(mixer[lm_idx].lm_ctl, sspp_idx);
 }
 
+static bool _dpu_crtc_pipe_is_right(const struct dpu_plane_state *pstate,
+				    unsigned int pipe_idx)
+{
+	unsigned int other_idx = pipe_idx ^ 1;
+
+	if (!pstate->pipe[other_idx].sspp)
+		return false;
+
+	return pstate->pipe_cfg[pipe_idx].dst_rect.x1 >
+	       pstate->pipe_cfg[other_idx].dst_rect.x1;
+}
+
 static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	struct dpu_crtc *dpu_crtc, struct dpu_crtc_mixer *mixer,
 	struct dpu_hw_stage_cfg *stage_cfg)
@@ -443,10 +455,13 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	struct drm_plane_state *state;
 	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc->state);
 	struct dpu_plane_state *pstate = NULL;
+	struct dpu_sw_pipe *pipe;
 	const struct msm_format *format;
 	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
 	u32 lm_idx, stage, i, pipe_idx, head_pipe_in_stage, lms_in_pair;
 	bool bg_alpha_enable = false;
+	bool src_split = test_bit(DPU_MIXER_SOURCESPLIT,
+				  &mixer->hw_lm->cap->features);
 	DECLARE_BITMAP(active_fetch, SSPP_MAX);
 	DECLARE_BITMAP(active_pipes, SSPP_MAX);
 
@@ -475,6 +490,10 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 				pipe_idx = i + head_pipe_in_stage;
 				if (!pstate->pipe[pipe_idx].sspp)
 					continue;
+				pipe = &pstate->pipe[pipe_idx];
+				if (src_split && pipe->sspp->ops.setup_src_split_order)
+					pipe->sspp->ops.setup_src_split_order(pipe,
+						_dpu_crtc_pipe_is_right(pstate, pipe_idx));
 				lms_in_pair = min(cstate->num_mixers - (stage * PIPES_PER_STAGE),
 						  PIPES_PER_STAGE);
 				set_bit(pstate->pipe[pipe_idx].sspp->idx, active_fetch);

-- 
2.34.1

