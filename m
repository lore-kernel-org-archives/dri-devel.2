Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36666C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 21:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0BE10E0CD;
	Sun, 12 Jul 2026 21:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oFtkCmE6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lj8X0b7/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C430B10E0CD
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 21:36:02 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CLEQlO3684410
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 21:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DbX44780az2Dh7hJRLP+co5T
 vYgmS7V+sl8d/t55O3E=; b=oFtkCmE6OzOxiNxP2mDHKBkbAn2NyrSZY9/Gps9w
 48Oof23c4iYB7OazkryklnDsyw50oc8gdrBp4a5xLi9JVsrEQio5MuztCjMTxrZr
 voMa9UR0Z9cInimombSn2Cjvt6KSK6gDu+8yBc6d1cEpXyX7JnCr0smuAFjPnu3/
 ShgFJ32aFhNy2d73s/Uv+sReYwnEYwX6ag7XHWz7ErqP5SXHZE+rV84B16xcdBQK
 JX8pviD9it++P5PKFiPG8U8o+mCfWeYMCrOGWe4LhdSYJ/u2nbbg7AhOuGbZdp8L
 l6IzKx0Rlghb9J6RU07O8V8QEjT/zopYnHpcMtWH7a4r6g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjnm010g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 21:36:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e695a3b28so372840985a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783892161; x=1784496961;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DbX44780az2Dh7hJRLP+co5TvYgmS7V+sl8d/t55O3E=;
 b=Lj8X0b7/kQH6NK/0LO2NGFzH72g12qArJStNAhd39Fcg1lsjE+IBbB6jTNxpnKJXPx
 CH14COzYTiPEu94ahQMjKBLVpEar0IupmsHWk0BgysB09JtcvcSWTMaJW+D2bdI+mD9o
 jDHxFLF27j6e+edKLr5Os9TJdT2V+B/aBuF14mS2VNRUwt5LTQ0MTT/Q41t0yBfPxhKy
 974MoVdFsrLvJ3TF/PYDVAN3mqirkmLTlobYbRy098vvyghy72WSTOY5GPVCmwlOsfM2
 DHVt7sOfnYmUD8/eGsjzbyxBlOiW9vc2jGYgseTUC8aAyUkvuCKW8Gopa0ZcOUtInzIz
 TFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783892161; x=1784496961;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DbX44780az2Dh7hJRLP+co5TvYgmS7V+sl8d/t55O3E=;
 b=pLbYXB+wKiM/CjIZBwFz4PhVtvSXNGS5kS7TNUDrjLIIK0dsLDZDqXuZw6bzG5Kj+u
 sFE18gAyqPA+av6PD9NMiI3f90k2coYv1pIlUMydmkuQJlS9FOJI1smEW3XSYz8ur1B5
 ztN0SwtTE2wUwHT5NE38w5yy0chgm5Y+3S5ex3vzfDdDz2tPEuuL1WzMuS5+NFWzJYqF
 3tCMUL0CPCtnHz4YrOD0Xg0T+7M/3YRQ1uLKXezSGw0av38irfjIyq8ZUXVXrV0g6aiN
 FhQw5dNxllRoQBauIHWrODLvibJNOvKz2mXc9u/Z6uVkfoms63i2BwlW5H3ZjxnTXs8+
 jtuw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7ZDhR8QC/J9zUf5GsxHqMVFNWZt/6PGBrkVres5MudOg32QxhaLknceTP5ZeELCvfrwBqGRusBMw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXlO/bGyxt1fTRvlsDrLeHuwTOXCiAN5Go+FT5pQpv6ednN1ez
 COlHfYDt/tLwWRT3O7da5DFSzjbV87DrJx412M6RrTBOfJATJHVclTyKLe+y2+Vvjdj9/OZsrbJ
 0hzG0nh7Qd0JYEkzioDdtVEi6A8LjjaDue+wVO6BRDBbrsd8JsLt7jxUSCkS74t6XReb9j3w=
X-Gm-Gg: AfdE7cnf0Gx3uQtOHKfwjvCiklayGgh9W6n6VbklJRKYOruGd6edXKp5NlJyt4AWexZ
 ef9B9uEOlpwjHh/BeAieC7oxQGMIn4FBKhoFCfLe2vfuavHKlyYGm1wQEup9+KBHFZ7i37XGPlW
 kGdDeE2a1aDq+29yc7JmiL9IPLAFcHm3vwbjpRC9bmeh1R9QixOu5xxFWeS0YEHoFD/HXrqrH9j
 Qe9Dqi9XnD4JyfwV2L6HWk5RH3qo5Mqm3o9eKVagseVm5i3D8WXFWViMQG7SQP909Rcm9Jz7FVR
 tDvvqG7k7uU/CY9Y2d47qRGKbdX1AHSdhdZUa0Mc7Sndi4W01b1mZPs5eCtYR/Obe+qwgGRB8SQ
 l0ikpCrR+XBSzt7yobB6uSLxmfClJHeYIx9jzjZE5VTWkz34N0yxJOunvpgno5u7Q+zJc4vqFex
 9Nb3Jsgz86ETNpH1Q/UEK6b7HP
X-Received: by 2002:a05:622a:2511:b0:51b:fb5f:b263 with SMTP id
 d75a77b69052e-51caa02c6camr112302471cf.4.1783892160948; 
 Sun, 12 Jul 2026 14:36:00 -0700 (PDT)
X-Received: by 2002:a05:622a:2511:b0:51b:fb5f:b263 with SMTP id
 d75a77b69052e-51caa02c6camr112302261cf.4.1783892160488; 
 Sun, 12 Jul 2026 14:36:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01ca4f80esm2388024e87.24.2026.07.12.14.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 14:35:58 -0700 (PDT)
Date: Mon, 13 Jul 2026 00:35:55 +0300
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
Subject: Re: [PATCH RESEND v5 15/25] drm/msm/dp: add an API to initialize MST
 on sink side
Message-ID: <esaigelvp2o7hw3z32mmtlmy4jzvb6v2uofmsvububwbn5oybt@hymmfbamhlki>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-15-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-15-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ENVrNttqqePRyCob1C8MbOj1a1avzGqD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDIzMyBTYWx0ZWRfX2LfXNn/r9Y1Q
 qHBo74kQckcP64ygCb58rnWfZACqqvFHfO9U0+l7p/ceEsHBGuMNh7Mymsr/vLBBaN0KDtfcj2I
 hppB0Uh5OwUCHgCeBEdESQmp1SzW6Yf1sGvmgrtuFcH+cWp7DOtsVBYeliIxAF38+5CbphfGN07
 xIsxbgqKWdPmzJ/fGmVpScu9fF3DIZkmQb+PVA7KPjFEkTfbVi/aVXEE41qUYh1u9XUKPEVC3Oz
 43HAh7FWDWRG49GToEYf2oqROQGDdPJZQncDCAsqOAsGnDHFnt+GH+x6sN4CPcMSxn5VoMpDKqH
 NhcC+U3/MPVxt3eJXUi20VCW71oO37VC6XiEOUzSPH2vlqrgsvkmzE8xxGCLnvZadhDq2Zu3UFn
 VXpoAkmJcxkz/rvuVt98sLkrJJLsr+zca0RMlzOs5gz8zEoU+ZLrOmmqNM7wVLlMXttf4fQh7dH
 b7uLJ5hrHwWdCOiwWkw==
X-Proofpoint-GUID: ENVrNttqqePRyCob1C8MbOj1a1avzGqD
X-Authority-Analysis: v=2.4 cv=AfmB2XXG c=1 sm=1 tr=0 ts=6a5408c2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=FHX0uZl4Zi1gEOnxAXAA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDIzMyBTYWx0ZWRfX6/Qgl4IPyzk6
 tsyh2JJNOo1sTU9IE7MgkQfDqMXmjUeP2WZXsynPnUWC/cDQq6vUC5QHzSz6NM8GkTTBgEM5eWc
 f+S3O8T4/HDqg28efPpTOQX30zlAbGI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_07,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607120233
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

On Mon, Jun 29, 2026 at 10:14:36PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> If the DP controller is capable of supporting multiple streams
> then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
> DPCD register to enable MST mode.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 48 +++++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 5786e598a406..c3be656f10ee 100644
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
> @@ -270,6 +271,31 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
>  	return lttpr_count;
>  }
>  
> +static void msm_dp_display_mst_init(struct msm_dp_display_private *dp)
> +{
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

Is it not enough to write the new value? Please add a small comment,
why (reference DP standard in the commit message, please).

> +
> +	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL,
> +				     DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
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
> @@ -288,14 +314,19 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
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

This also is going to break DP. If you are using dp->max_streams as a
determining factor, rearrange commits so that max_streams are parseed
and set only after the rest of the commits are in place (and the driver
is ready for DP MST).

>  	}
>  
>  	msm_dp_link_process_request(dp->link);
> @@ -317,6 +348,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
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
