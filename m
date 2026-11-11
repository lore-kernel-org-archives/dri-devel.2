Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0553606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WJU1cLp+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O3XHw91s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D9710E92B;
	Wed, 11 Nov 2026 16:53:27 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1034510EA94
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:53:16 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0Z2B2594124
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7lWeOV9IjYiGNbkklH7++lso
 UrJceNa8llVVsVssTr0=; b=WJU1cLp+YpPvMnX+2WrEqieAhymCJI3DZsfYb6Ik
 dIWfqHO4uDNn3KEl69NPcN8Mg2gOOvHcmEx7hmGyjWoz6lLqMNUjmqxomwUwfOk+
 qNCVtL/ymnON4otGXKP2V3TRL1YAbQ+38Gz2LrkcI5qRZNhMjXInNapxaeOXuinB
 SO5bggvMNmf80PJaM58kA+atFEU2M/3d17lEYg2USobLR7DT4P7R8FFuT/sQSbm8
 3ohbrF5bb9HsvZT9WBrnbxLbTDjdM038jfzO2pRAx+q/MTFH/EMnq2epa84xRD3G
 7ma2abWVuJyoqbDBADjLs/h3Rppl3Es9euHJGGsx5K9/sg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksma7d4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:53:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cbf2fd504so648488685a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794415994; x=1795020794;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7lWeOV9IjYiGNbkklH7++lsoUrJceNa8llVVsVssTr0=;
 b=O3XHw91sPVCWeoG9+EYgt57Um2JGt0qY6wwSY/3Go5Itp0Rp+ucOOWRVw3nmGgV93a
 Lru+G15MQtBmOP5Px3LwUwz1p4GIHG9Zaigs8R7af9Lz9Y/jcHpwHXMycQqaS7C/YLT3
 KXZTMz9nFHHb/AF1ykblhghvAx6f8VXSSKbwSBXCootgS+MjqOIGANrk8vYkbUdITCB5
 Q3I3SsYbPD32PH1WbgU1EGb8ZCnWjqagXurWOAOZO59Gt/0bRr1HVOjWE3+YkWBZthK/
 6xbaaE3LUalOSokRup/LjrJhJHtq0KM0adc+oGrZBMtsK27aEkQIrEVkFDKtZnGPWUfI
 82Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794415994; x=1795020794;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7lWeOV9IjYiGNbkklH7++lsoUrJceNa8llVVsVssTr0=;
 b=TN+Mcevqf8wj8seUeMuScjLVkkEV4+hC+6ZOBQQ1icOCm1xQbNgSf4pXCVO9OzcRoC
 U7puCJuGH6lsddMW8Ri6Xt05vMbueJ9jOGcTOtyYzq4y3Y7ldivKddXxZrEWx4Lbbt+9
 bSf6FoYy7zghgI940e3cejRgJbCPrkouh3CuwuLmAUpxUoKTrhT7w0rlyDqZyYP6DznE
 1831YSvhmRuKN46JHdkkXVQTM0y695yyhwzRBmZbHrgNALamaWmVPHKRmpDyg0syULVk
 cKamnVK4UzvLSXFYAL55LslA5LPCcgVp1Xn/Ome2T0Mvz4pvGFf6nicQb//wuEPI1YrF
 nMCg==
X-Forwarded-Encrypted: i=1;
 AL+hErHZBaZQK6W2Q0wjbUa25uPr8l55yr9CjhU9DjhP5TrO1nSYVD8l0UwBNQAT9J/G62nDiVEzVybm6LQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8GLqpH1CgF4vrpZczgfQ42/cY6yvTc7C8gFxFBAfELNA7zgGrR
 l/qinLQqk17dnQpPboEyogz3Dg5pBVEv3XRUWka4gswKQ3oVTiL6NtKBi/GWvzAZNmYHrWY95po
 iyvcoWl1ebdaeNQxeTHVbpDnJfLLw4/uF9HUAWJoVFLiArOMNopVui+TbT0WSZHcPUWTMlnw=
X-Gm-Gg: AYBFou2yAc+HM9VeIOQxTxtAIDMZUOA/Vy9UpavAPLjSW1hi/f/J5WuLJ8F5xWqhkue
 S0Sen/yXpgN7euftAe1/CcNOaCF9gGbEcpw5DxTb9ox0rWGQz62IKAQILoi5zpFs53j7tja7lEQ
 1jmtqmu2YQIO2BjlJnHTakjDbBtbJq5cK/ZdMNIeH3iIv/6WsubOyXHa3AytiHZdQ9EMjts3y++
 l2ctv92vLrWYDFf2ftoIOugagazY+scjPLhC3l8h3gbpL0/KcZJFlaVifkWp459LJdoRZ/nXGHK
 ulSt4zh8jt7V7L8eLdu26t87zKE3zPuPjhT3aOY1pANWujWzKhECiFg/Bd3c3+z50yOZWOT+bkm
 KjELp05HRry3Sl/S0cc+RZMM3LAIZG1HcyIl8Ezxsjf6dfsEeV61aH4tyGwcBuh1fR8coRVQyjR
 GRmCR7WMPVx4Mf/Kgt1vL72KJIiV0sEM9vi5yLOwdLi4TZtaRhg+8oXoFSa/dBiQ==
X-Received: by 2002:a05:620a:1a02:b0:947:7691:7316 with SMTP id
 af79cd13be357-947b00317damr467213085a.81.1794415994276; 
 Wed, 11 Nov 2026 08:53:14 -0800 (PST)
X-Received: by 2002:a05:620a:1a02:b0:947:7691:7316 with SMTP id
 af79cd13be357-947b00317damr467207285a.81.1794415993546; 
 Wed, 11 Nov 2026 08:53:13 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae0922925fsm12779561fa.15.2026.11.11.08.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 08:53:12 -0800 (PST)
Date: Wed, 11 Nov 2026 18:53:10 +0200
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
Subject: Re: [PATCH 2/4] drm/msm/dpu: add SSPP op to program the source split
 order
Message-ID: <3b2yzvkwzveujzg6kyedvqlcddiqqmjzrumagiinzovhwqttsi@q53rugd3zkxk>
References: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
 <20261010-pipe_order-v1-2-9d8bd29fd78a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010-pipe_order-v1-2-9d8bd29fd78a@oss.qualcomm.com>
X-Proofpoint-GUID: 2PzrtW1a4nhKoOVVC-tRk5mC-etqAvr6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX4Y/iFLz7rtFC
 bYGyDIoR97U1SPVGcgB+a/Umq4qzARoLexLNvthcwzHdUBHb5ix8T5uVqEf/ILHug8VDQwYLPNs
 pvQ7qoLAi+levpiheBOun9VeLOsS8ypx++nXRH7+DOEjset0D9COq+MHOC7muuXjleYSYQaYkYe
 CiOJUndm96CTx5BfVbLXnYtUb2XhP6LY12fjNV7dXpIcVdaa5MMTcluCg4SoHYV0evwZBf5R4cV
 nKz1IbnYom/8Te6ai5sj0UvDPLLw5IprKwHUNQu/Loykqoywow5n41W81I3603JnDbrUQe86g/v
 nOti6QsMslr+2U7TiwP05/VUCcpIzZN658orkkwYx87gy+rEAcD3iVskpSSzCACGUW6U4OHa9jR
 4bE68EF4BSlvn7dYzNEqo+PA1rz/kcZ+3utEmZAk+85KkTq8LdKo3GqdgXkqiKNOe98Y5maLnTu
 g8SlOgFWcHMpyCUBbUQ==
X-Proofpoint-ORIG-GUID: 2PzrtW1a4nhKoOVVC-tRk5mC-etqAvr6
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af49d7b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=zXlURQC4rpLtYXS3vwUA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfXwQBG8TI5OzC4
 CNxDwP1Cjm2bPJvbBBkhyy53B/m+ytcUJpTxlhqeSl+a70ScsXzY47ZPZppbFIbfCqgkhxCDlSA
 NdKJe7nbrdtrPrLSZd1yZhl8S86RDSU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
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

On Sat, Oct 10, 2026 at 07:08:22PM +0530, Mahadevan P wrote:
> DPU 5.0 introduced SRC_SPLIT_ORDER in bit 4 of SSPP_SRC_OP_MODE and
> SSPP_SRC_OP_MODE_REC1. For source-split pairs using legacy CTL routing,
> this field identifies the left source with 0 and the right source with 1.
> 
> Add a setup_src_split_order() operation for the SSPP register layout
> used on DPU 5.0 through 12.x. Select SSPP_SRC_OP_MODE for SOLO or RECT0
> and SSPP_SRC_OP_MODE_REC1 for RECT1, and update only the ordering bit.
> 
> Assisted-by: LLM
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c | 35 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h | 11 +++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
> index b5e50fc1916f..f6ec883f9066 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
> @@ -84,6 +84,7 @@
>  #define MDSS_MDP_OP_IGC_EN                 BIT(16)
>  #define MDSS_MDP_OP_FLIP_UD                BIT(14)
>  #define MDSS_MDP_OP_FLIP_LR                BIT(13)
> +#define MDSS_MDP_OP_SRC_SPLIT_ORDER        BIT(4)
>  #define MDSS_MDP_OP_BWC_EN                 BIT(0)
>  #define MDSS_MDP_OP_PE_OVERRIDE            BIT(31)
>  #define MDSS_MDP_OP_BWC_LOSSLESS           (0 << 1)
> @@ -260,6 +261,38 @@ static void dpu_hw_sspp_setup_format(struct dpu_sw_pipe *pipe,
>  				 ubwc_ctrl_off, ubwc_error_off);
>  }
>  
> +void dpu_hw_setup_src_split_order_impl(struct dpu_hw_sspp *ctx,
> +				       u32 op_mode_off, bool right)

static

> +{
> +	u32 opmode;
> +
> +	opmode = DPU_REG_READ(&ctx->hw, op_mode_off);
> +	if (right)
> +		opmode |= MDSS_MDP_OP_SRC_SPLIT_ORDER;
> +	else
> +		opmode &= ~MDSS_MDP_OP_SRC_SPLIT_ORDER;
> +
> +	DPU_REG_WRITE(&ctx->hw, op_mode_off, opmode);
> +}
> +
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
> index 69d68cc916b2..9b9ea2e00a00 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
> @@ -236,6 +236,14 @@ struct dpu_hw_sspp_ops {
>  
>  	void (*setup_multirect)(struct dpu_sw_pipe *pipe);
>  
> +	/**
> +	 * @setup_src_split_order: program the position of the pipe within
> +	 *                         a source split pair
> +	 * @pipe: Pointer to pipe context
> +	 * @right: true if the pipe fetches the right half of the pair
> +	 */
> +	void (*setup_src_split_order)(struct dpu_sw_pipe *pipe, bool right);
> +
>  	/**
>  	 * @setup_sharpening: setup sharpening
>  	 * @ctx: Pointer to pipe context
> @@ -349,6 +357,9 @@ void dpu_hw_setup_multirect_impl(struct dpu_sw_pipe *pipe,
>  				 struct dpu_hw_sspp *ctx,
>  				 u32 op_mode_off);
>  
> +void dpu_hw_setup_src_split_order_impl(struct dpu_hw_sspp *ctx,
> +				       u32 op_mode_off, bool right);

It's not used outside of the original file, drop.

> +
>  void dpu_hw_setup_format_impl(struct dpu_sw_pipe *pipe, const struct msm_format *fmt,
>  			      u32 flags, struct dpu_hw_sspp *ctx,
>  			      u32 op_mode_off, u32 unpack_pat_off, u32 format_off,
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
