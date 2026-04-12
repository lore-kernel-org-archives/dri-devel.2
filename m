Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8006F3ED6B
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C8A10E265;
	Sun, 12 Apr 2026 00:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eKzFu8L+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B8Z5q5xf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5BE410E265
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:15:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BNN8D62964984
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=jxT+ezVQFqvL0qhq3TEQ7PNG
 qa40HwvJ6vHkB4vN5Is=; b=eKzFu8L+nZRkz8D5b9prDJBdSsFlaKvN/sSrgNKT
 hz65wIg1XJpBAI0Plon8D5ODFUbLLQyvPJ9hVsb1p22GD2lZTnceeEe0axRwZGc8
 hUUcrmsKVtvVcZJ4lGvJfxhlullctUUomjgjLY0CweTQXsbadaO8hY0WrU2NHVrB
 OIAZUv5RJExR/wzPvLgGNX39kxqz6txiXiyzEdbCHDeh23Fb7h97En1C0jBjIrUF
 sV0v38d2l8Ub45yqOWsB5e9a9GT0hX6kX3Sl8OnwqXoLgLhXBJHKW3etGHSOqtci
 uHFRHLz6YfY9GSYHvimuNguxYHz0cLEEboDSrtymRKP4oA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff2b9hnb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:15:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so33344151cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775952944; x=1776557744;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jxT+ezVQFqvL0qhq3TEQ7PNGqa40HwvJ6vHkB4vN5Is=;
 b=B8Z5q5xfNw/UKX4b51QIsMKmfwmax2BVh/xfZQsT2qjuEHjAPR29iXqiDCb+KzHD/R
 m09LVqDABduIsU3Dit7elIx8DqagFNjFEeQIn5zcudE5bF28vdfuYpzGU8L1H79XDbhQ
 UHGScV581IwgAEJCf5cUN0eFnZAOPrJIIkcgvAbBJ/TtQJ1QSxIrie+efxcMlTSALr7E
 R3sBGSTBoNO72jzrzNF6ATWwKhdVR7zSmdvzJU17Z2hI/5mpdi+ZAHh1Irq1kjX6uOIi
 R1KppwZ7mfXOZaJUA6Fz1ks0NPftFZ5Os0G0q2O52pfhp9ZBRfeE+PZbSqdz9tVnFJEk
 L4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775952944; x=1776557744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxT+ezVQFqvL0qhq3TEQ7PNGqa40HwvJ6vHkB4vN5Is=;
 b=b39dhqXIeObbfqa5M3B42MeXc9inEGcPPYEuSvqvns+uqMG9T1ooX82+jU0zoj4lPC
 Y1hNg2JMZN3MjUFvaAfE8JflAF9yqeDo3+thBIImdPKSXS522vtH1vKbPZJBFUeShnIo
 nlMLXzI3HKgYvqDawZQciweu9YBO1TMKEHh2KKuCIunT/ZO7maQqcH1eX9d7GNTc4d5A
 p877d89dgCHoKAoAif06D8mrldmsC1ad51OkVoSd8uGw8s38srTa8DylwfziWpBXbbI9
 DstcwjJeC90fx+lJLJ1DF9lkePmNbhpJ2XqIy0IYABsdA7XZcAMCJolt8faA/8+quxFb
 NPfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeX/HjA6lYwTO3RgIivT7domDhls5sncUxrRn7LlcWLUG6Lb5zXJEVMg+dbGWBeGgjUC4OokeDjzk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycEZyw2U7o2tiz4MAXUhs0QeT/t0ARbCHZ5YLp4D4cIzzfWW/s
 bZsYvg5A1fcN4UxRCq+FaJXT1L98BEAkZbMxb6MZUoNEq3G5z+03OHlMYUfOcq1pIwtKvO0CAk+
 CcwHbUGbpS7D7oD5qdQwbpQsRgn1qrJfnEABcXn/SAAvXMKpe6Q89xxRhAAjsJiV/ktSUptM=
X-Gm-Gg: AeBDietsYr8v1YhujZWuyNuKU66ys4VAaYGU/CVzuoQMSAV2gHcdmKf83rVIHQO2/cH
 Q5pdhN6DnXfhw4pGe1sJ6hk8tUuB3RhVOqp8CSQR4RU3LFiQDd/54R6xTqWyW36LynCG3jxyerR
 tuMXJVhKFbpim36aov79sVfI043ABaSJZH8UlQFbK/uMO4zYsyH0vmywwnwP0I6fw/W1hkTD8yO
 5rhP2cThgs2aDHX/UEpMO8HWxRwlyp3aA+neNnlEldlcyMGbKdHxFDcr9qZJQiPY2SfbUQsdspM
 xFRJ/ldqOBC5mXTOfLOx6poXas7K5qReBJJmSG+4vlgaIKLdazEKUgnfFVMRRgfItBgMMm0hLd6
 2JClvTODqEQg5QIKbWG/sYQFDtxwUm0ex8cwRXHfZM+IfHh7zpw6sj2cQyMudg9NdLAYy1VlMOn
 BGZT6dOwAxvGkevvhNxujZvODZpb5ANg/fzDs=
X-Received: by 2002:a05:622a:30f:b0:50d:8350:9a15 with SMTP id
 d75a77b69052e-50dd5750e53mr138011841cf.0.1775952944037; 
 Sat, 11 Apr 2026 17:15:44 -0700 (PDT)
X-Received: by 2002:a05:622a:30f:b0:50d:8350:9a15 with SMTP id
 d75a77b69052e-50dd5750e53mr138011471cf.0.1775952943608; 
 Sat, 11 Apr 2026 17:15:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eef071cbsm1700379e87.80.2026.04.11.17.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 17:15:42 -0700 (PDT)
Date: Sun, 12 Apr 2026 03:15:38 +0300
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
Subject: Re: [PATCH v4 29/39] drm/msm/dp: add an API to initialize MST on
 sink side
Message-ID: <32jtwnkusxultvsgvnalrvccfkcyk7744yf4d42pqm7wudysvt@l4pnrzfxh2f4>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-29-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-29-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDAwMCBTYWx0ZWRfX5AOMviH6b2Wu
 NvmYXIq8jb732PErpoY8BKAnsPpzLDEQE/kqmQIjeMoqFkzXsqwYRdBhNtlljXtzDXXZruSN+3O
 5b8s3YaG1ycbUPrmk+lHm6OvM9d4AHYXRfXKqFwAieNZzAWsJQZh44wFoLq2qTFmgLiu44DOafI
 K30xiEWZUGgkI28CD0KrCC1TPJZO6lq6Hf1dOwReYhM+Pm9VqbHyxs8ssAryuFKjqUleldGtBwP
 vUguaRdAqRt1VNWMOFVW3HPajjn1E4vgaMKVvnUw2MJYNoPBV4L/pG9wzZ3yuG6/O5GOgCI11df
 qY9EvC9LxpyX2+9j495PA+zo1XdZO7G1YKdMLbx0EHZIUU4rmGq6jlhTR5+j/R9xFlVGKQbhg4t
 8KOsevLNXHZMNmpbIi8ji0eE1nJ3vNyiV05Pf9DnFZxWHvBKSwp2c/QE3R4oqHywkwWpollq7dY
 DhhF2gsKEVp8Oqvxc0g==
X-Proofpoint-GUID: xk_qXXYvnMu1LBD4b8eYUhVvaZNrsLZD
X-Proofpoint-ORIG-GUID: xk_qXXYvnMu1LBD4b8eYUhVvaZNrsLZD
X-Authority-Analysis: v=2.4 cv=W4gIkxWk c=1 sm=1 tr=0 ts=69dae431 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=FHX0uZl4Zi1gEOnxAXAA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604120000
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

On Fri, Apr 10, 2026 at 05:34:04PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> If the DP controller is capable of supporting multiple streams
> then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
> DPCD register to enable MST mode.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 57 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 8ae690ce2b9f..abf26951819a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -14,6 +14,7 @@
>  #include <linux/string_choices.h>
>  #include <drm/display/drm_dp_aux_bus.h>
>  #include <drm/display/drm_hdmi_audio_helper.h>
> +#include <drm/display/drm_dp_mst_helper.h>
>  #include <drm/drm_edid.h>
>  
>  #include "msm_drv.h"
> @@ -270,6 +271,40 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
>  	return lttpr_count;
>  }
>  
> +static void msm_dp_display_mst_init(struct msm_dp_display_private *dp)
> +{
> +	const unsigned long clear_mstm_ctrl_timeout_us = 100000;
> +	u8 old_mstm_ctrl;
> +	struct msm_dp *msm_dp = &dp->msm_dp_display;
> +	int ret;
> +
> +	/* clear sink MST state */
> +	drm_dp_dpcd_read_byte(dp->aux, DP_MSTM_CTRL, &old_mstm_ctrl);
> +
> +	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL, 0);
> +	if (ret < 0) {
> +		DRM_ERROR("failed to clear DP_MSTM_CTRL, ret=%d\n", ret);
> +		return;
> +	}
> +
> +	/* add extra delay if MST old state is on*/
> +	if (old_mstm_ctrl) {
> +		drm_dbg_dp(dp->drm_dev, "wait %luus to set DP_MSTM_CTRL set 0\n",
> +			   clear_mstm_ctrl_timeout_us);
> +		usleep_range(clear_mstm_ctrl_timeout_us,
> +			     clear_mstm_ctrl_timeout_us + 1000);

For 100 ms you should be using msleep() instead. But where is that
timeout coming from?

> +	}
> +
> +	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL,
> +				     DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);

Isn't it too early to enable MST? (I don't remember this part of the
standard).

> +	if (ret < 0) {
> +		DRM_ERROR("sink MST enablement failed\n");
> +		return;
> +	}
> +
> +	msm_dp->mst_active = true;
> +}
> +
>  static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  {
>  	struct drm_connector *connector = dp->msm_dp_display.connector;
> @@ -288,14 +323,19 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	if (rc)
>  		goto end;
>  
> -	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
> -	drm_edid_connector_update(connector, drm_edid);
> +	if (!(dp->max_stream > 1) || !drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd)) {
> +		drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
> +		drm_edid_connector_update(connector, drm_edid);
>  
> -	if (!drm_edid) {
> -		DRM_ERROR("panel edid read failed\n");
> -		/* check edid read fail is due to unplug */
> -		if (!msm_dp_aux_is_link_connected(dp->aux))
> -			return -ETIMEDOUT;
> +		if (!drm_edid) {
> +			DRM_ERROR("panel edid read failed\n");
> +			/* check edid read fail is due to unplug */
> +			if (!msm_dp_aux_is_link_connected(dp->aux))
> +				return -ETIMEDOUT;
> +		}
> +
> +		if (rc)
> +			goto end;
>  	}
>  
>  	msm_dp_link_process_request(dp->link);
> @@ -317,6 +357,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	 */
>  	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>  
> +	if (dp->max_stream > 1 && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
> +		msm_dp_display_mst_init(dp);
> +
>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
>  
>  end:
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
