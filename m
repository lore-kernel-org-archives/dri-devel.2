Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18C3C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 13:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF1F10E47A;
	Sun, 12 Jul 2026 13:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldf9EwfD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kTjLhRRx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1F910E474
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 13:56:47 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CDZl4S2564504
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 13:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Vj30YTOjkM+90gThnC3K2ENN
 keFiZ0gtgxaGsvN7hRY=; b=ldf9EwfDkH6ekhEKCcUvC2HkTjfXi8jNKkC5RrHo
 717JihnFsj3zyVVByFl0jwlVvVAKYfG0WqiD8IUH3cYqz1JWpG8yeR7juyylU4gc
 z6ANMVNjdsmcTYXNVSX0gdhebzkwOnN39C474H9MCWhfldEinDvwx4A+0SLwcdOm
 FVy3Ztru+davNw8r8vWoegHrhDjqoac7gzPDu+YWfnYm+4cAi46GJeT0eCzoxQVU
 GCAdndqGDmKl8zPRAoBCM4s/XCZl7OdgjF4nVsbK8OYTTeZKSG3vySXHSatL7hPP
 Bybc9nX0KX6Iy9IiJ00unL8SPhQXMpZxsmOV3XaH2vFC+A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf482rd2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 13:56:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c075c1e25so21975581cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783864606; x=1784469406;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vj30YTOjkM+90gThnC3K2ENNkeFiZ0gtgxaGsvN7hRY=;
 b=kTjLhRRxVh/HXRs9FdrbVrm/otrLcVR2kvSLNHd0HZj5UiWQRtXSIMjzYVoqJnZO1j
 Vq0NcCSyspBN9B187+fhrO4NSgEwRqNXEwfhaiiiaf+fMGcPK/QjNHmoHib5v7ZORhi2
 jhtJtC/g0gMJE58DEddKAGYGkgP2YAa/sQZ2htf26IkV/z2+m8Ah+gWzqs7JlCTxzgO5
 d0Qk/XvibunHoUg+8LHLLHBfSL9nemMgxKDQgSykcyEEyMNoIsZ0uu+XJgSc3aPUTpkq
 hZqCm6hsF0uEeE3g48Xv0i64w4fXQhSJNto3jdIub56ZNus7jrtoSr6M9tYzDtwxSDWW
 f/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783864606; x=1784469406;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vj30YTOjkM+90gThnC3K2ENNkeFiZ0gtgxaGsvN7hRY=;
 b=CsxCLteMY/Vd1KvKSkltgVQ881lt7OvsSOqadlGaHsXkg30I/XBk1Qjl7jh90+GaHl
 TKii2huw+g77YTkqKjLl+0KPxLmQ1W3K8yRLnQizmqdylQRg1M9JC9s5bt3NJ0wOUYO8
 s5G3elcCAylwU5ZmIdtccY+VGnKp165Cn0CkOvdKy1cCI509adN2Vug89RRL3aBnH9V+
 Hd5p8UtOdwPI3obfNAP0/RbVDyK02SaW3oWohILTA3SERs3lSoB/wVElLTa/Pt00hd3B
 nzQcGoHhM/t/B1YoEf+K5EL8xeGBjHiyBvo4n7fP8f0IvoMWJM+u0Y6fj8e/a9ekhSZT
 a4zw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/rx7MPQgQg0bAgGYgjWD1KexEccM7ScGufTPbmnKL8xakn7+3Wb/i6KTmaH+rnI3WxzcgGzzWJfg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUvY6uH9oUrqqlfUGHjfA1s0cLQpu66Z2OHSvGs/HyWPWNkjd2
 xRe7IAYK0sUau7LgPWu9O2voTdKaF2nQEl0rvNQ+kMiH3m0dJtvDyKFiTW3waDYaCI/+Gl04MGT
 UBHLz98Th8JskrJ2bDzizKJ95a6VkGzJa0iScSKVAOp/ZWsW5g9X3IopcX/OSXtwAwXnYrsg=
X-Gm-Gg: AfdE7ckrVu6dSOpKGAW+2JlRD7Zm8zn+bmFcaEvBQVKlzVxAUfIzrNpD+JsFZrwBJ8e
 egpT80VzNa1nJVKEEmqoWYW5n6hBA92ZVX5SvGTRB2qKD3kVsbrhiWjY6x5KqnuyDl1UC+ZnAUg
 ZJWsJs0gbuSPi9dlZ5bStU3iJJJiYGTrhVHEFZ6X1rKK7sNiO0XsabFvenI6V0qCcVhcKOJZHg0
 p0MV6npanffWijY3RVNptFMN3s/0G6anO05VCtt1q+g+xrOF6qvW+Lb/BHhC1bMvGLZSvrRTrpD
 zCy862zxIBXuJYLNOsUZlVUABWxQxVuqXeWZztI/Tnzf475UWEFTaX5nyV7hgnfkNl8rKQ9og9j
 0zuppXYcZAO+o7NubQtnxSpeJVDiNq9xzkMRVNdiGW4vvnWUJSdRVWipyuwThDnY7QRdXtN3VlK
 fG/pFkQ9JsH2eCDuwUN9mY8tTP
X-Received: by 2002:a05:622a:8c3:b0:51a:8c9c:7f3b with SMTP id
 d75a77b69052e-51cbf26c01emr59435521cf.62.1783864605448; 
 Sun, 12 Jul 2026 06:56:45 -0700 (PDT)
X-Received: by 2002:a05:622a:8c3:b0:51a:8c9c:7f3b with SMTP id
 d75a77b69052e-51cbf26c01emr59435291cf.62.1783864604924; 
 Sun, 12 Jul 2026 06:56:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01cab1491sm2057788e87.82.2026.07.12.06.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 06:56:42 -0700 (PDT)
Date: Sun, 12 Jul 2026 16:56:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH RESEND v5 05/25] drm/msm/dp: add support to send ACT
 packets for MST
Message-ID: <is5m5apuf3mujjm7y2edxbjjygc4w4wpp4i33vj2cyh4lzte73@heinwvrqnaur>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-5-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-5-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDE0NyBTYWx0ZWRfX4pc53wlxLkeM
 6RgZHugxF20GS02I69qJRgP5Unad5jLr6kCCyaig9dZR4xIgM+30KNbbjapw5PNwn0SfmZz7Ttd
 Qe6HPczU7OBlTVSuMozOdfLeTJqJFTc=
X-Authority-Analysis: v=2.4 cv=OsJ/DS/t c=1 sm=1 tr=0 ts=6a539d1e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Qdi8XrqBvsyCqcF2G-kA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDE0NyBTYWx0ZWRfXzfJQbXzJgtVP
 xrmBY8Lm9ECNR1PcuAIT6paFno5buSpww6yGlmLLWNrZxCyilNKtC45KSnoxArrMnzk1zoxqPky
 4o556D8WnwbtTPLPQVNi4h1pF1MadgXc75nzENhNDG0YUhu/jZIgt2KvThcRGsGsd6q8naEDQAy
 wbBpUlMClOHwj42rKkgAiTP+UI0XbZ2vQ9bFg+NQV8rIWfSIfbr4exXiiwYjCkxYCuciBgU/jtb
 fVsDHwYkBsu/rjNY6p2GsKSfP/si1YGsJY6SkQVy6bJ7na44bK8AsS+EHB8Hz304YFUNAAXs+kJ
 Nre9JHygnL96XqpEJC1T34e0EkipDGmI6Qq4UeKwoj5k2Bc0tgomtRAgUrI6n7pbhhyd66X1PQt
 n19E8hfVbYyqvnn9q7yvxv1tbtISxnUFReJf51iaN5j+ZYvqa+n3k4V5VVUXkYWBsfIKtkMND3p
 BMdCRgDdu9wIFEB0YjQ==
X-Proofpoint-GUID: Pyy4dAI6MfkC8lNc6XHncoUlBahTjmsl
X-Proofpoint-ORIG-GUID: Pyy4dAI6MfkC8lNc6XHncoUlBahTjmsl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120147
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

On Mon, Jun 29, 2026 at 10:14:26PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Whenever virtual channel slot allocation changes, the DP
> source must send the action control trigger sequence to notify
> the sink about the same. This would be applicable during the
> start and stop of the pixel stream. Add the infrastructure
> to be able to send ACT packets for the DP controller when
> operating in MST mode.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 44 ++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 ++++-
>  drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
>  5 files changed, 52 insertions(+), 3 deletions(-)
> 
> @@ -2623,6 +2656,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  
>  	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>  
> +	ctrl->mst_active = mst_active;
> +
>  	pixel_rate_orig = panel->msm_dp_mode.drm_mode.clock;
>  	pixel_rate = pixel_rate_orig;
>  
> @@ -2658,6 +2693,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  
>  	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>  
> +	ret = msm_dp_ctrl_mst_send_act(msm_dp_ctrl, panel);
> +	if (ret)
> +		return ret;

Should not we mark mst_active only here?

> +
>  	ret = msm_dp_ctrl_wait4video_ready(ctrl);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> index 310e5a1cc934..6808965878d4 100644
> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> @@ -156,6 +156,8 @@
>  #define DP_CONFIGURATION_CTRL_BPC_SHIFT		(0x08)
>  #define DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT	(0x0D)
>  
> +#define REG_DP_MST_ACT				(0x00000500)

It's not that it is a register in its own register space.

> +
>  #define REG_DP_SOFTWARE_MVID			(0x00000010)
>  #define REG_DP_SOFTWARE_NVID			(0x00000018)
>  #define REG_DP_TOTAL_HOR_VER			(0x0000001C)
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
