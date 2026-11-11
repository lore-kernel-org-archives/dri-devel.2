Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B594606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d4EZw+gQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hSzRrSrj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A558E10FCE9;
	Wed, 11 Nov 2026 16:55:48 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2484510FC87
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:55:37 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0HGX2651040
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dtuAsIkr78INIV8Z/BdZHzuI
 PXa1ZLTXYhrmp5rxHFQ=; b=d4EZw+gQL5DGX2yL82ISR0t9g0drEtP6obCGwdLG
 kV1OOPl8npl1GABt09UbhmK55gss7ZfLf0ZTcBi6XIRw4OwH+0WM3jlNGw5BCDdL
 PflQTMNzhigl7sx9rmuIBVIu9bcSeI+YWjyTWPwPDNHCZ+xDmCPDQXnpiD9qCZl2
 QsIDpT3UdI5FvihPXz042kU81XnnEZSk7rBfKHj0FOVnhvtrMbZShLWmat2f1196
 hNxDx2zyZUmmEQRek0q3pAAjItYImCB9XekENwJOcQ7cVoPCeKH4zv6H0CkJ65ua
 v4GRskxC21h44bX24S7RAF8bb4sWUlQ1cbio0pxxgtnQNw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnmbrvm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:55:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f3969a2a7so554433985a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794416135; x=1795020935;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dtuAsIkr78INIV8Z/BdZHzuIPXa1ZLTXYhrmp5rxHFQ=;
 b=hSzRrSrjNu2BJImBAw012pFeFoia5fMfDdq4ty0r42TNn9JTUXeAyd2fEULyAUD+aO
 lrDmefFwz0BHYiETyxA74d/7qD4m8IgplncXUrohjGtJZKf+5sN5SsuiPD7yDfkBvpct
 Gs7GqyngJC+L5NTnANU3twt/cr5TJg/I9JyB2bFHcvO+ndGrVIEgeygWKq7vdlqbF2hR
 9BXp5qexUdfO9TqYwlAWPLNPft8nPNXn9Tz/FHRdMKKbZXLuxe075Iv8vyGwhuNQv5DD
 D1U1HGGhDWBvGg3hcUJc6aEkY18s5KAVZdAT6osExlXRsJu74jAjlvQPJ3zV+4ADVD41
 /oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416135; x=1795020935;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dtuAsIkr78INIV8Z/BdZHzuIPXa1ZLTXYhrmp5rxHFQ=;
 b=Jie/6c42NgOyXV/DoefhuvIkaWYs4766hk4PSpiMMvZ/b1k01UJkDl0ZKHzCCrJ88K
 +OiAVLt80efXyZSGCX8jn1uzT3FGdYrsJc0VYUtuSWOhBKfz8BpO1CmbwNVMvvp2u0dW
 8xmkua2dvNWShczSpvgW4e8zVLwuxMD4LWqAZetfP/jUxK02hhNbkWZLX6OAFQH41Xh+
 B7EGcq0TeH8hHbMtIQdBSAWKvNhWq5egw9fo2y4mGKFQMNYaLft5xYNaYFfT+CgKtdJu
 OYu+NvZXc1pH8VVm4KfVdWHtiENybg3nUJZyC4hVlLBZ1vP5PC33oL5/M+hEQ4IyVDD4
 F4jg==
X-Forwarded-Encrypted: i=1;
 AL+hErFZokTot0qAGcaxh7NBn+zSZwkq2G3veKpVPFn7XqZ9bIT5JbZl+SV/JdnMQeZeUyCH3/duHnjodQk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/e4QiOQI0yWsx2tRjsVr5i4yZ6SrZRCR5FyipM1APIuxFdW8Xk
 BppvZSpQBSOQfmY4nzg6oJHrqolY7+r2Rdc72JYkDpR1MPLwzc7pIV3/g797hBgp38nXM65fkq5
 jySkFEq6WJd0cqjuU0gvVB0rJs3Y6Jj7NQE3UbQEZaulWZMcx/T1YhS5XvAsQMeHJc/NILGY=
X-Gm-Gg: AYBFou0SmSkTbN5Jm65hSiF6SoZsHwaBD81gDXd/C83WHypgmbum1ZavRlXcNTVKCAI
 9YfWYponzqG6sMWS2Worhp1/vfzTt8Fcniobp/knUCWkAL6joMgnxiJhbhyLVsJ7tmWN3PnBlDq
 75s+s68Tu7u1YK3PIpOvkFXlA2+YLvXQU9FztTGrinZjTTBzqnoJ/D+Ifvp58Pknq7gkEqSZWSU
 TedpOqkzz1fL7LPH5TaVq7jIIc2s4bMAElBjkSUmJoWAy7Nvyi++72UDc8c1PQxxOoA6aNjzM6J
 T0yuLU10q7PnBxvgt7lwzN2SyAy4S57lAq7HGtSN8aEUhiJc4rdHmPk0niztl07qXqKyZfVKVkx
 nfhrMkYyZLwxGNCJoP+fTIK126G+yuBddp2wo7pKKwZvewYmwvGfVx7WSJwMP6JwrC9I0Mcyxa0
 A4FYDwF9yjnUVs8qP2j0VPk+46a8lkUeXdstjkg74p07HfmxJ+nIl5Lcc+mzOdFA==
X-Received: by 2002:a05:620a:710c:b0:93f:2eaf:64cd with SMTP id
 af79cd13be357-947b004700emr479801585a.50.1794416135119; 
 Wed, 11 Nov 2026 08:55:35 -0800 (PST)
X-Received: by 2002:a05:620a:710c:b0:93f:2eaf:64cd with SMTP id
 af79cd13be357-947b004700emr479796085a.50.1794416134544; 
 Wed, 11 Nov 2026 08:55:34 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae0923c164sm12879141fa.20.2026.11.11.08.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 08:55:33 -0800 (PST)
Date: Wed, 11 Nov 2026 18:55:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] drm/msm/dpu: program the source split order for
 split planes
Message-ID: <fexhbxknsxgpvgtziubvp3ynoomwppzy7fl53ycynskebk6q5h@hxzunshclscj>
References: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
 <20261010-pipe_order-v1-3-9d8bd29fd78a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010-pipe_order-v1-3-9d8bd29fd78a@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: aQ7zJ0iAJcrqnZHGwOysbwtCxwg7Iv88
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX5EgsZNGL2tlU
 ue9bkWIlUHA2rT33LCeU8gDxQRNzKesfNVn+QgNwCDGKxEGsNBWC3g8gu+UTEzlhrHhABquVtfP
 fxnYO+G9AXIOL6irP6lkv5Jf+mVsVQI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX+MJsd4RAsMhQ
 JenweJ0LUaulsbn/bsMz7jFHEcnTr7H4ej6d9gJIbMkVlmNEbbjgI1jQ0pPboNVKdHY40NtCHIg
 q4xGuERO41J0p3m30d7dHK462dJErl7/AWFPv+aQoJsKoOvib6lnbJPDC6BMdsQPgyZSIkzPDhF
 6UWHKzvFSuGydqq4I2wtDXWdf5z2fxx9oCyK62inIr427MrUxT73P2QRAe7NzcM2N6kvfhxRADx
 10E49acmDMkpH2p9E71Zz865xJjmMP53xVp5pnatJdi1L0FESOQnaH+k0tWFyEas3CyvsJYQ99i
 rY9pFeOXOPxQ6OHLuUkXAZ1fpbXR1bHjLhQ4w7VkxFxU6vH5NK5hzsiaEYA0I5delT8cERuq/pt
 he1NVdrSZv3+oEZN5IGC+mQ9LDB3mT8md7GToOBld9hIbsHJuVRGC1soGPO9xQ9X0ConR8XdRXj
 VV72HQcIm2xcdCSBrNA==
X-Proofpoint-GUID: aQ7zJ0iAJcrqnZHGwOysbwtCxwg7Iv88
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af49e07 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=rjQCQlUSGl8ILNuVy7EA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110067
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 10, 2026 at 07:08:23PM +0530, Mahadevan P wrote:
> Virtual planes can use two SSPPs when a plane exceeds the single-pipe
> width or clock limit and parallel multirect cannot be used.
> 
> Program SRC_SPLIT_ORDER during mixer setup from the pipes' destination
> X positions. Set the bit for the right source and clear it for the
> left source or a source without a sibling.
> 
> Fixes: 8c62a31607f6 ("drm/msm/dpu: allow using two SSPP blocks for a single plane")
> Assisted-by: LLM
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 77a2d1f6700d..91152d937ba3 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -434,6 +434,18 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
>  		mixer[lm_idx].lm_ctl->ops.update_pending_flush_sspp(mixer[lm_idx].lm_ctl, sspp_idx);
>  }
>  
> +static bool _dpu_crtc_pipe_is_right(const struct dpu_plane_state *pstate,
> +				    unsigned int pipe_idx)
> +{
> +	unsigned int other_idx = pipe_idx ^ 1;
> +
> +	if (!pstate->pipe[other_idx].sspp)
> +		return false;
> +
> +	return pstate->pipe_cfg[pipe_idx].dst_rect.x1 >
> +	       pstate->pipe_cfg[other_idx].dst_rect.x1;

We know that the right plane has odd index. This is a total overkill.

> +}
> +
>  static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>  	struct dpu_crtc *dpu_crtc, struct dpu_crtc_mixer *mixer,
>  	struct dpu_hw_stage_cfg *stage_cfg)
> @@ -443,10 +455,13 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>  	struct drm_plane_state *state;
>  	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc->state);
>  	struct dpu_plane_state *pstate = NULL;
> +	struct dpu_sw_pipe *pipe;
>  	const struct msm_format *format;
>  	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
>  	u32 lm_idx, stage, i, pipe_idx, head_pipe_in_stage, lms_in_pair;
>  	bool bg_alpha_enable = false;
> +	bool src_split = test_bit(DPU_MIXER_SOURCESPLIT,
> +				  &mixer->hw_lm->cap->features);
>  	DECLARE_BITMAP(active_fetch, SSPP_MAX);
>  	DECLARE_BITMAP(active_pipes, SSPP_MAX);
>  
> @@ -475,6 +490,10 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>  				pipe_idx = i + head_pipe_in_stage;
>  				if (!pstate->pipe[pipe_idx].sspp)
>  					continue;
> +				pipe = &pstate->pipe[pipe_idx];
> +				if (src_split && pipe->sspp->ops.setup_src_split_order)
> +					pipe->sspp->ops.setup_src_split_order(pipe,
> +						_dpu_crtc_pipe_is_right(pstate, pipe_idx));
>  				lms_in_pair = min(cstate->num_mixers - (stage * PIPES_PER_STAGE),
>  						  PIPES_PER_STAGE);
>  				set_bit(pstate->pipe[pipe_idx].sspp->idx, active_fetch);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
