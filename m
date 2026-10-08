Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19C8CA6011
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F085810FAB7;
	Thu,  8 Oct 2026 17:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Emzi9NQ6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LM/5OVe0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B6E510FAA1
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:24:50 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EVsQL3517922
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 17:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kXOB6HSENlgLJ01CymQ95n8hmSw8nebKPmjVVOMcZrI=; b=Emzi9NQ66f94ePkr
 eyA8pLJNCNTJl8KPL0ursay6sOlmqUSIH8cfA4wJqXHIYpEK4k2mQX6v6vE/zp4o
 CIXTgsvJVW3+8uQTs07fB0kjVxGY7NJARyNGQ2ud8AdhVzvA0+wgxKFgkJtLV58L
 hc6ouROcwtUYTBAKy115lamD7inVjj15nwLCImMDhlaGGaSZxq8efyCUmztH9uOk
 pLdzHFBHty/c1NS4DZ55rrWfvIEmyX98YNJt1UTUE4sCyqN2lO6OK2YQF3pDmO6e
 unuE3ofUINt6PH6DQzpCLoC0GH2vxi9igfHSsfRxtnyXQluWWX/ZpM3xgR/bU4hm
 rWBK/w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe83wjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 17:24:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso6906708a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791480289; x=1792085089;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kXOB6HSENlgLJ01CymQ95n8hmSw8nebKPmjVVOMcZrI=;
 b=LM/5OVe070z9CQYZA+9Vgf4uzz+Laf+og0GUqpNQcEefnIt7isG3ih5KtguRn05Z8n
 kato9JyxTIxJ6Vln3kdB0UlJ7B9/vjUkYj2IwJ6nNiHtj9AXl/8WFbV/W4L8IfLCkGRr
 OZkw1CvSPNBVou79Imw17Fhxo5h4dMBn9r9ZhCwREYHZ56v0hD44hZAm5VEEBzk3LEhR
 lXTE+TFgv7FvQCrddjTZJsY1UEaFSuUmq704y5DAw5LEDaK/ZHf4dLX3TnnPt5ZsplRQ
 VGPXAluFn6Zk/lJJlsmIVX1BvId3YRwUJBDbfOJfZMJXVc2J9XfUrGa5r8l8tr/AbN26
 BR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480289; x=1792085089;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kXOB6HSENlgLJ01CymQ95n8hmSw8nebKPmjVVOMcZrI=;
 b=EMuXctCNmb+g56o4dzsZwsVJcDg8AFI0w1IXDcG6nkgXeS/h76gGdwpWcSr/wxicm0
 1WgGZm08cReXbVJ2n3w99uRORFVWvJjxWXiwe3RqvjVWq8O/CCh55TO8rV6B+yC1eF5y
 b4G8pe7G/jtDto8twgicj9zcDaP9xqANAhCH5henFEV6W97bHoPtQvUAYvxixR8BWTZM
 JebBbLz2QkU1QVlvin3m2NrN089Dj3GF22uM6XvEFvVCruoG99vCm9v+oBmEdYIWs0jQ
 kXU0tSW2LSku/2WOT+KPjZsrMXQO+/XoFq7GdM+HsKZu7LLr4ZB2EvuYBmNswI87QG9J
 HsHw==
X-Forwarded-Encrypted: i=1;
 AKwUvByAnnFD9FbbEbdNAP2Nptmm1ml2212HbFkf0k/z3HbwrSdt/kR/AH8okSNt6awhGo4++zJSQ7LmQCQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLgGLZpD85shVwqR9RgQ7gZJOTOxz9MQZw/vOa8vsuo9i+3NRsW
 Ati97dq19nHdrD3o1HIqWu2anmO4tm0G+CUVPvbNG7XpZQd1lf+ZpLqNGpznMpTfC0qW2gvCTEh
 T91CHzpGLL3LdSrD4K7WuyUmnGffSxpu7sig9Lf1Au/ojqEMrQZBrA6vvk3LD610+yZUkkuQ=
X-Gm-Gg: AYBFou3tq0zLWQM7PlihABMp3N9ivOyq4zpmu13O3RsK7sg1M8P42S5o4PIfhakTaUN
 dOZSFZOJSYAzkldQZvKdoW3/WoIDCgYXX8Rrpx51UAIaiuo4Hnjomt9zibXf8fgJ5kyIPMB9A3L
 HiBoXw8kjCqnj77WrmMIux+Xd6dfwUPYccx4wyiD6ems1xkaV4PP/1Y9Ufy6GPfn0+IRin8/Kwv
 2ZuoHtXGB0dMWWBpJ5HZSUfDAk9lGKXaU5zi5oPOaRwCa9r1k+VjO0lAejT95HgkPBhmfbOUn0g
 diM+mG91sphej5iIkdB1tVG/vAB3JT/ccJJse43CRMx/5LAcP6HLXVaF406miSNL2FysfTnCCKT
 r12RzbtoOD0VxkmB8x/D6V1Jg/A==
X-Received: by 2002:a17:90b:134d:b0:3a4:ee64:b880 with SMTP id
 98e67ed59e1d1-3a8a0dfb941mr4586256a91.32.1791480287620; 
 Thu, 08 Oct 2026 10:24:47 -0700 (PDT)
X-Received: by 2002:a17:90b:134d:b0:3a4:ee64:b880 with SMTP id
 98e67ed59e1d1-3a8a0dfb941mr4586236a91.32.1791480287115; 
 Thu, 08 Oct 2026 10:24:47 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3277c459sm47228a91.16.2026.10.08.10.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 10:24:46 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 22:53:52 +0530
Subject: [PATCH v4 6/6] drm/msm/dpu: limit the mode width to a pipe if the
 LM has no source split
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-lm_fixes_final-v4-6-fa986071c3c1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791480250; l=1679;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=ffK+sgwIxa0nxxdTwedAg7jsF/07q/HMTOzQUsBHFFY=;
 b=VM0cIPXc3RlKPNnSljZP7as8ig45IsRGPJpT6qKIh9HH00akRjuibYAvs7G0QY03xQFqfmsPI
 4PZkw+2QcotDKvVpPGBJsqo/jeq6vsDvjrq9KyipQcs/bbwdj05JrHl
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2OSBTYWx0ZWRfX0Qha76gXmIrs
 lYmKZFB0j7FC80Rk7G6N7MMZcdJd5zSCpM9xDhfXx2v1+zMfLKoAThIiVV6Fpndk4zaWjRuIiFa
 HAhGPVnxjbuudF2UmiGO4CyGePxSUYLy0aKedv/DIqz/GHx8z9ipGgREyDHWapXvKHrU+Ks3PKL
 CMxuDmiW2EqYRHFtc6y04HEuzpLVtKoYg5Q+oFGiefvdrGgqSERleR4leYnRlgFBjcOWiax+Kku
 moLZsOQP7Wrw35eyKqPAurRwPwlHq9StM3rPwpep7C+tD7WsueLNQRT3n6zVUL7Vuzz9WfivwX5
 dAASg7IKpJPaPftWP5wxRS2FKwJR/wcSW0lUtCsTX2mweDuUUCZEWmqYq+Ba6ZNVrBcmDn9ELlu
 H3bk3zirLYHa65khwXlAv1X6KlNEjh/2DEry/2W7PcYn8On9ZurT6VR2sklc+AVoUxDOZIBV4Dd
 z+EwB+sNOh86Hf53sLw==
X-Proofpoint-GUID: 2UesdSuv3wA0yi4NyxFb8r_TIQpYQ0BL
X-Proofpoint-ORIG-GUID: 2UesdSuv3wA0yi4NyxFb8r_TIQpYQ0BL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2OSBTYWx0ZWRfX2tlhtEFAlf4I
 uTY53MpNNNwtZjIQBN0CIm6Q901QRHD1fxQclk5WX+ZEvO34UcgR5miYJHPL78m0W7XQ404iTsF
 uirYxHehhGsK+x8L4ujWAlAXvP6omlE=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac7d1e1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RCAr_VjVQrktO2oC:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=67skgTjD9neFK7rYSF4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
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

Layer mixers without DPU_MIXER_SOURCESPLIT stage one pipe per blend level,
so a plane is fetched by a single pipe of at most max_linewidth pixels.

max_mixer_width used to reject wider modes. Now that the mode is checked
against the PINGPONG width (4096/5120), keep max_linewidth as an extra
bound when source split isn't available.

Assisted-by: LLM
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 41f986ca2a68..c2ebeef0b01f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -791,6 +791,10 @@ static int _dpu_crtc_check_and_setup_lm_bounds(struct drm_crtc *crtc,
 	    adj_mode->hdisplay > max_pingpong_width)
 		return -E2BIG;
 
+	if (!test_bit(DPU_MIXER_SOURCESPLIT, &dpu_kms->catalog->mixer[0].features) &&
+	    adj_mode->hdisplay > dpu_kms->catalog->caps->max_linewidth)
+		return -E2BIG;
+
 	for (i = 0; i < cstate->num_mixers; i++) {
 		struct drm_rect *r = &cstate->lm_bounds[i];
 		r->x1 = crtc_split_width * i;
@@ -1661,6 +1665,10 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
 	    mode->hdisplay > max_pingpong_width)
 		return MODE_BAD_HVALUE;
 
+	if (!test_bit(DPU_MIXER_SOURCESPLIT, &dpu_kms->catalog->mixer[0].features) &&
+	    mode->hdisplay > dpu_kms->catalog->caps->max_linewidth)
+		return MODE_BAD_HVALUE;
+
 	adjusted_mode_clk = dpu_core_perf_adjusted_mode_clk(mode->clock,
 							    dpu_kms->perf.perf_cfg);
 

-- 
2.34.1

