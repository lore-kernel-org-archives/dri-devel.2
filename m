Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73358CD4F25
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B7E10E356;
	Sat, 16 May 2026 11:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YsYbrPfn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVwlDUWK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F2210E356
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:34:01 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64G3mG1i3574152
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EGAbnTi4v8/K8BXWQ8fTbV4x
 t9A1k5FW2Sg09trRd5c=; b=YsYbrPfn1bZCXumJC9ISc2eSa0f38KNA4pyqjLE8
 Xwb3JLCQl7mqGcMCshOofXZsQAQfc5fg/swBJlkt32JBzllgmi87kfjKjVTdmaVF
 g0eVJ4RzJhL3N5WOZbOVGN/gJ8J8gKBOf3eLhi9pSmPLqB1uL2dRuY2+Xdl5k4xP
 HzVsIE1QoahKBNMMRRXV26LwY/ZMovTj2Sl9El77VN5nIR4JLtd46bBaeQ746i0K
 frI5/HIXEGyqIevDXyJeGoJ+dSmbroCMVnv5r6Oc1ZVj5yUQr+99sz0LFCfidbw/
 wp8Qd3PyeqJ5bddDe5Lc0iYVuQ9466Gq2zC1Hyc7jsJ2Aw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h01grfj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:34:00 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b46c014a26so23215266d6.0
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778931240; x=1779536040;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EGAbnTi4v8/K8BXWQ8fTbV4xt9A1k5FW2Sg09trRd5c=;
 b=WVwlDUWKgVYwkxvCFDjm+/PygLFfc4XPArikBQ+xp7ESXHKVV1BQsuGKFhXRsLY4XU
 l5k1LY4Nd9Pe85ve0nA5giajRpGPYpQjfxOlt2vzltg7L9NYFMy70ip16X/01+E/lk1m
 bOyZOMpHMWAju4zpuz/jVgG+zZVJo0BcbKci7ba5S4VTb9RWxZHmTjEF53KVudeZVa5H
 bXUrI8iH+RtQQkNVcjrXrcievqJmAaqCEa4GCTlLdAcE2gurjmQP+to5R9KpIRoGTkO9
 si976R9I9Hjvms6hYrJwD/s0ZXrzSkVdGbnV0wH5WamXiGBYcwdGaL0Zds8kdG28VUHG
 E75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778931240; x=1779536040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGAbnTi4v8/K8BXWQ8fTbV4xt9A1k5FW2Sg09trRd5c=;
 b=EyrmGyHKgZrrQ14byjMXNU6FnlATYX98Ie2b+E0OAB03TDNY94jI2AoHxTP4pW1B/T
 nawhBh9N57vA9T6ARn91ouEjSeAwuCtzlfZMevsSEwv+BOhILtxjXZEGEALcuNUR+ob2
 FImtq8NSl1eYEncmy+vr24e/7HpCf7FW7sWqxueiN9IVozswBWgU4npwsPFYPIg7TunE
 lDDz4c1aohWIpB3M+puPw3Mik2M10yJ+X5Zr+VDo8+5vXiF7pCyZBzGe41HbQq11z/me
 EtwFpeWQqDDww7q0Vupd8eVDYYxgpv3tyZEaBXoG6DEYvXkaCuoyU2rkWiS63cWlfsKq
 vaZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YYv5aFf4m68jt4c29YmKMO2tuka8jY2KgTyFR6P4tbr6uI24XKmSmNzuikhwFb/LoOTxIJOyinHE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOWXCU4q5MmC9SqEU38enkh4iR385P+GjbX2oMk2ecVUbZ98a9
 cOh3mFmS1NRtoCIK3TORtKw2bJLnLGQhQktddUhRZ6k352CVaA8OPJ8gXO6amSuFR2jsno7B++/
 l6SKAQ2kqq+U1xxtM31cMA2J4YvfgWimZoGD6yVsWCGHlliJlDg5PZIuXJZGcwT3ghyytnW0=
X-Gm-Gg: Acq92OGG+/PFcQcw8JLAqiDeJBe2bDeHyA8RGJp2YdGMRn3ZeNwF/Z7RzP0L8a1kPr/
 cgG9+hl2M412UeqFyAiQ+IJnsosB0lwagdEu+SDEvxEcLVkgzo5B3KdpE0Glh/Q/LtFKlnPqBI/
 qelA5kY9C6SrTmxc946cto5k4phrcsleVtSF6r3QJKgBMa7VOTK2k/ng1OcliBDzvqAoYJjZsVp
 Zlcp+31G+JwCtICRexi9DIxlSLsh0Y1UcyN+b5IkI/oUbzUGhA5tzN8Y7/3p/HSR3whFLTmQN9C
 rngxW2h2i4fnpi+89z+8N1z4nLFLZhJOQ2oExq1uFlf3TQnyIMO+aczivC4FxAJyr86pmIxzX/S
 SFnDt9d9I7NMboUjq8a++HuYZusxLpEhNDL3D6uLUaSO3l3fpHRncHI6znl7dsMWQJiCDL0sCvj
 nUxrOAynjbMaLMIrhtMAHlcQXnOZnqD4CinDg=
X-Received: by 2002:a05:622a:428d:b0:514:6667:73b8 with SMTP id
 d75a77b69052e-5165a1db12bmr100939281cf.37.1778931240424; 
 Sat, 16 May 2026 04:34:00 -0700 (PDT)
X-Received: by 2002:a05:622a:428d:b0:514:6667:73b8 with SMTP id
 d75a77b69052e-5165a1db12bmr100938941cf.37.1778931239947; 
 Sat, 16 May 2026 04:33:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3945cab4a48sm22255751fa.26.2026.05.16.04.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:33:58 -0700 (PDT)
Date: Sat, 16 May 2026 14:33:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Salendarsingh Gaud <sgaud@qti.qualcomm.com>
Subject: Re: [PATCH] drm/msm/snapshot: fix dumping of the unaligned regions
Message-ID: <hx4wermsrgbnnzukzj565subelf6hjireabjvszfbc4ataptnu@t2pk3hqrvsk6>
References: <20260516-msm-fix-dsi-dump-2-v1-1-43928094d25b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516-msm-fix-dsi-dump-2-v1-1-43928094d25b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: oIJc-TggyaUNxyVRgAHWCo23ikn8EgFF
X-Authority-Analysis: v=2.4 cv=XbG5Co55 c=1 sm=1 tr=0 ts=6a085629 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=cBU2fVVTaiHfvuHJ6MQA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: oIJc-TggyaUNxyVRgAHWCo23ikn8EgFF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDExMyBTYWx0ZWRfX8WZjoXpTaxSc
 mTtFAjv8XpsNpyGk45Cud5UCDZfbKOxe4W/2glwkvvEggLN9UqO9ggymayA9DaBip8m6vcfSdBQ
 aRiRzsNnVwgOEztR9rBjVODdIbnQCFkQ6V2AqT0zigabc+wsnD6iFWcH+eE9nYhYLvmTLkqoWMc
 FxUAOfVjNO+o82MHGt7W+Qxkbz1X42+/aNcQeS4tX0LMyPbXbu6ynR7Yvw8rvFYf/i39r4CwDuw
 mRZlfg3Z16KGWTgtPUZE6VYZfGripn6TzzWBCzjjWdWs69+8/ecJgt/38QD7DH9uqBhFH5DKPd9
 IdJWQJhTiqYsEMrztU957skKvA/BBD9qsO19FoeMBhJnL/l9mVBnH76X73azyN5/wA/3kBo43ku
 7S39YF0m3TeIXazzoX9G5K6qAl3kXbPu/BcN3lgM5GVFGMD9D2XO917OBdcMASpHWLf/URNOaAh
 xGJCQv1rjgklqwcJ9og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160113
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

On Sat, May 16, 2026 at 12:40:10AM +0300, Dmitry Baryshkov wrote:
> The snapshotting code internally aligns data segment to 16 bytes. This
> works fine for DPU code (where most of the regions are aligned), but
> fails for snapshotting of the DSI data (because DSI data region is
> shifted by 4 bytes). Fix the code by removing length alignment and by
> accurately printing last registers in the region. While reworking the
> code also fix the 16x memory overallocation in
> msm_disp_state_dump_regs().
> 
> Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
> Reported-by: Salendarsingh Gaud <sgaud@qti.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 27 ++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> @@ -172,6 +184,9 @@ void msm_disp_snapshot_add_block(struct msm_disp_state *disp_state, u32 len,
>  	struct va_format vaf;
>  	va_list va;
>  
> +	if (strcmp(fmt, "dsi%d_ctrl"))
> +		return;
> +

And this is a debugging change, which I forgot to remove. I'll send v2.

>  	new_blk = kzalloc_obj(struct msm_disp_state_block);
>  	if (!new_blk)
>  		return;

-- 
With best wishes
Dmitry
