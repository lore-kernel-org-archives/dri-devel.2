Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340ECC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 23:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CD710E4FF;
	Sun, 12 Jul 2026 23:55:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ruat+foT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y1d/Rbdy";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF8610E4FF
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:55:19 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CNUCOj3911037
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=M37f/ktR12Rc/Gd2GeEwEeJf
 uiXAWLubgkB5QLF2DKM=; b=Ruat+foT6CczYLmnczwmwypYAEgwi8UX9b/+Zn+/
 /efUPg9yewztxs45XV44fuBLioNtHt125GgFqpApo8/dtixlEa2OWREDsAHM+qm5
 JMHjbNtRFTfjCOA3KJ6bbuoSJvnVZBVkDRcgq2rp1C45KUW0BDNf7ovgUqN0bZ0m
 j+r0o0JIOYUgrCwOeb2FHv9VEpYI4ZIbo+1+FJgpfavbuQQMQaBnoUOh8zEig7Op
 UlrjCoq66vBfo9I/LuCsVwjhgAOMfp4VOHMONT7ym/3PpVx+RLyNdhTllJs9duDH
 23M6A3UwEh9Q6RH2CqDsSryUsSiP2wgKhuT2F9s8L7mZTA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeamuryf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:55:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c083f1818so34631981cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 16:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783900518; x=1784505318;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M37f/ktR12Rc/Gd2GeEwEeJfuiXAWLubgkB5QLF2DKM=;
 b=Y1d/RbdyD9Zn+ncFGlj9pZHwFgZ3/2xLPBv7y69vxuJ9spJdhcwoN8fIVZxrsH4BUh
 YNitK4bHqtMQTueT8IswIVkkPiVElOjcrwN+mcOGa5D+gKwacQmTP0thpy3VojBEBwYa
 il4PfPJpsx7c8rWocgKOL1Ad6xvQre0jJn3j5+VV5r8xbkVIl/giwU6Zv9uCN4zlHwta
 lyL/gi5BdslZsu2cprCScAp1toTH4XPbxNKRbm8nnle7dJthROeuY87AoXYnNK6iVAMW
 Yy5v12wXyRtXxZKpKKLybtgY2a8ET6UfRfQixgNSoNh59Dp+ryCel3fDmHDbantXaf2l
 9hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783900518; x=1784505318;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M37f/ktR12Rc/Gd2GeEwEeJfuiXAWLubgkB5QLF2DKM=;
 b=dKnDHvLlukTWFWBqj9GnAVtDg9uYIBCMRO0OOeQ5QyTzpGiY6aJ5/eSxFyWkr5wHlg
 8/6z/M5zU6RyKBDRg/c9Q3RhwHg27ynbkGcXQFI0P96VvXfs4hkwxxB/4TUoqEjMjAHn
 vVLfrNsmhs2s2p2EU5CaJ4ruCVPPPxSGwaSHEvB2HmWL5VBXG54J73ow4pwnxjEw/ROJ
 jmB6DjJ1IVl7TcuuJNyxLoso+iX+6wILQfPGFkz4F32LZDBXT8ZOyvCM1yrksBF1uvVp
 HQtDMgY82buUI8qRvLaq/uotFkK9KePVFeNzoRSyYtEsbAVsGkpJuOBQPFefgSW1Cypg
 ql+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnJnO7y96InLL/p6F3oiNPEVZK+uim5c4YOqeJlay/yw6ED9QpVrAku16aW7gIQ7qR6ez1d52uQeE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxu3GHAAdB067fqdPnwz/K3o5Csz+0Aw345VcBPqS0+GkdzQKx/
 ZUkpQ2mP2Px/iPGYRmj2lW16pW8FjK8fhJtQKbu5YsTl3abengdW0lCJNiat1j9031pJ5zPjddh
 IFQ8U/vxWkxr4vH9hBnAJKvB9I8ndKBQOHJHbCFkTHuEtm6YDqJqTVNSZuu2m5fncDab4bRg=
X-Gm-Gg: AfdE7cn12G5pka/wAi/5/cTDIi7ypr8d3z64xoJMOgVW6cOThadeDIBUTg/QHFso9Bz
 UJOuTo70zazBxd/XJmJDeKMARtT6na+bJCj1yzxxYu7c/QjvBD7HLhospxzbZRmkDYzp1kqgUNH
 GYmuN27ZGgizmohyecYwMA6+8WNtlSil8YDFbLUVKs5xqetmCcNYJx7CfXIogyCkkZaJLYAS6EM
 SaWXRswDfes94RcZWHj6Ebms/DlQqpIKJLiLfz80YqE2cJgY8KpRRXojSWFhMrheIPsoOrkIpG8
 M5Ks59ORzcGjQvGBJy1cX7gAVbUUUnwXQkPdjjWPIEe6S+bsJz2sjTsn2suVZjxb3ZALJgksmqw
 S45WYeO+8ZkfCKoq7AuXMA0s3oTTieU9Z0KRj3+ZkSxppqV/o364ZViyEHLJtgnMUjXymvClRMK
 f9dO9mWlUG/eAuqcrMcio/85TK
X-Received: by 2002:a05:622a:1e18:b0:51c:2075:afd5 with SMTP id
 d75a77b69052e-51cbf3953eamr71132381cf.72.1783900518143; 
 Sun, 12 Jul 2026 16:55:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1e18:b0:51c:2075:afd5 with SMTP id
 d75a77b69052e-51cbf3953eamr71132191cf.72.1783900517711; 
 Sun, 12 Jul 2026 16:55:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01ca9dd79sm2378160e87.52.2026.07.12.16.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 16:55:15 -0700 (PDT)
Date: Mon, 13 Jul 2026 02:55:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 18/25] drm/msm/dpu: initialize encoders per
 stream for DP MST
Message-ID: <yvriev2yh73wl6zdya36q43ffz4kx5xdfjlkvlu2vwoefyosmy@6psqndhdl3yu>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-18-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-18-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDI1OSBTYWx0ZWRfXxg84OWdQmc1P
 WeWbG/2HwV+0Rbq16O1GNloS5Mx05CEYj1w6lI4IU3H7Q0TYfBFVWXCaxDBpH1ABrRs7tHAa2Ux
 O6kdO7UDVJZoY2PtsyXEfePkjFwuYTY=
X-Proofpoint-GUID: COPgSdTv9D1aXGY6EiilF9SDR659TSPh
X-Proofpoint-ORIG-GUID: COPgSdTv9D1aXGY6EiilF9SDR659TSPh
X-Authority-Analysis: v=2.4 cv=dJSWXuZb c=1 sm=1 tr=0 ts=6a542966 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=hU-Az2_SeSDlFTkWwngA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDI1OSBTYWx0ZWRfX+ueb8Js5vcIG
 R2/bBd3XcVEn4Y8y5MQz1bMkZDPDCq30NLKnM8G4/jJrAlQFLcj1GIihGQYx9aYDhNes3/BvMKk
 Zukv0qKbtrcXV4c9/dyVTavmXBPmHG/nq8QAZSQNxLjvuhRTH4aNf56NQ1A3HeWoyI+nf4coxvY
 GtVc6jboJRjrbI6NLG1MQIPPrdIt+FJMSCcpNV9ilmqnSJsNF3eOXLrrfft8PusOujS4Wo+aHnx
 8HcPt7yZlrmwLEwfjy5Gr9oX22GovaAmIk1o1r3kcDEvhpyM9g49pS2spIveK+x/etjqQNmsY7D
 3P0OQxKrcITIas7UtI87AJQB+BoeqIK9S8FWxhFR0V7BeK6LpiGqq7upzD7tEgEbrLWb/H1bokS
 JVC7LKcBebRBFC00ESafdK8+hb6e3xdLSA5oWL1Ar4SFZv1yFdYkCtU1wDs+sLNU3fTgXsgvLpP
 7MO/EWTJ5nTn1i830ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120259
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

On Mon, Jun 29, 2026 at 10:14:39PM +0800, Yongxing Mou wrote:
> Simply initialize MST encoders for MST-capable DP controllers, and
> introduce msm_dp_get_mst_max_stream to query MST streams.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 14 +++++++++++++-
>  drivers/gpu/drm/msm/msm_drv.h           |  7 ++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index da3556eb6ecc..7a00c4094d5c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -655,7 +655,7 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>  	struct msm_display_info info;
>  	bool yuv_supported;
>  	int rc;
> -	int i;
> +	int i, stream_id, stream_cnt;
>  
>  	for (i = 0; i < ARRAY_SIZE(priv->kms->dp); i++) {
>  		if (!priv->kms->dp[i])
> @@ -678,6 +678,18 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>  			DPU_ERROR("modeset_init failed for DP, rc = %d\n", rc);
>  			return rc;
>  		}
> +
> +		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
> +
> +		if (stream_cnt > 1) {
> +			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {


for (int stream_id = 0;
     stream_cnt > 1 && stream_id < stream_cnt;
     stream_id ++) {
		// foo
	}

> +				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
> +				if (IS_ERR(encoder)) {
> +					DPU_ERROR("encoder init failed for dp mst display\n");
> +					return PTR_ERR(encoder);
> +				}
> +			}
> +		}
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index c3fb3205f683..5fee0b291059 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -355,7 +355,7 @@ bool msm_dp_is_yuv_420_enabled(const struct msm_dp *dp_display,
>  bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
>  			       const struct drm_display_mode *mode);
>  bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
> -
> +int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);

This should be a part of the patch, introducing the function.

>  #else
>  static inline int __init msm_dp_register(void)
>  {
> @@ -372,6 +372,11 @@ static inline int msm_dp_modeset_init(struct msm_dp *dp_display,
>  	return -EINVAL;
>  }
>  
> +static inline int msm_dp_get_mst_max_stream(struct msm_dp *dp_display)

And this one too.

> +{
> +	return -EINVAL;
> +}
> +
>  static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
>  {
>  }
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
