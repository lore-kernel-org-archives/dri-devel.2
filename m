Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD79F3ED50
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 18:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FEE710E22A;
	Sat, 11 Apr 2026 18:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GOgrOWgv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hE9gL+cr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 904BE10E1ED
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:07:56 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B435uG2736610
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yQDuX/vawvkYbkeyVpkFhSB279SWYSpgK1fT4HJGYbU=; b=GOgrOWgvTDtt3l1S
 CXhZZ3ukiDU6FJcJKY80vSNz6Y4p1NnpJOphLTdcutMMTW++h5mXZyLe9uHiSpTL
 DEwetqOmwsdOqFbAy116C8GDkOfTCttSlI0Ja+g+yznJNA3miNWNpdUNH+67tQor
 S/sY53bSU6rDDvRC4VPH5/U+nn2wF9wpoe2M9GSBg+hjlG1vDc+2OGMN8ZzPjDtX
 WCTmE78KdpDPgPG7/T5mhfITienLhkMJHUq6Ky/qAJDHPT1zjiSTA38BI+cZACSR
 pmMjDitYLXssMs7qK0TAAvxPKzp5YyZdrR8ZJ/1nlBEurWJUXA6IHoyq/FR/7zhf
 Tpvugw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexcs63e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:07:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d984c74a8so73151381cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775930875; x=1776535675;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yQDuX/vawvkYbkeyVpkFhSB279SWYSpgK1fT4HJGYbU=;
 b=hE9gL+crBwCKaR22hq+FMThIfwSI4EjhxZ7O1etkoDKrCp4eUID8AaPGePEIpHsbai
 W/a0m3ehNezRe2yIV41HjMQWzQdp27+zNTU5vAZwF62CVvBZm6osTQY/+o1O0R84zQll
 SmBOI4XRJdbQuMsFGnuE4RdvXYCeid3xtJPjboqoFjyxl6Bt+8GHFBKketgDMJTK7Xl0
 9QXGT54nSIic1mkCh47G3PRoGr4FCrzXwnj8wPLV9KBg79QdiN0N4ursb6nDsYK3MZQo
 3PaupYSqWSSkE6gnKmZat5pHRl2aX+w7TWDO+6ebDOoOc4oq/ofLKJj2o89wflOLCa0X
 tAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775930875; x=1776535675;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yQDuX/vawvkYbkeyVpkFhSB279SWYSpgK1fT4HJGYbU=;
 b=TDQcNn7h+v6usbQOxR04veKReca1qMSfFfu+ZIwPpt0ZHg4kmCYeU5otA3fOFlbRjs
 2NZQioXZQLL1uPv+mbT7XYESozFZpxSbHY/svLWjPYKXdlQtb/ARFHd/ZV0gnBrT60Ex
 ddwdITQDDb40OOg8AC/wTNja3bYf212d2T3BLhHAjGx/q0kHI6EQolYMWjrSerwiXunt
 x8QcVDe7FXQq5FsJ3z4iXQqPe2mQq8Hyk3vRpLxwp86xfh42hPZ+vfmq1bPZaeB90gcG
 /ws5qim+M8h9ALxVYUjMD3xzFqU8yHY/IkvEVGDchSWpoETEBC9UiVzxFYRO5t3secKO
 rS0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWelmuLgkAei38hGLOWSLglVY1IEPOFq7SsftJRhxUuNvgpC4ActD9pNzwqjhs7Hj4/OAHQmO2FI3c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/lmiqCM6GfiWFOh1Rg4DiY7c6+7k9iG7o5h1vr220EjXT+YEP
 OJdNIlXT013bF95whQb13g3wDB00EbsKt680KavxejAVR87btTs1zY5Bucty0G0cQ2kjykBOKbL
 /sXkXiQ+5vBr9Xb4CBLl0jRwVkVNRBb0LTW5vqES+9u9O+wbVRw0z4Y69KGQkZEWO7eK6/ho=
X-Gm-Gg: AeBDieu7kF0Gq7dk4ZYu/f/w0lPb+n4qh40Gknf3hz6pG9mf7yaqwQjCNJvqqf7c8gR
 fmGcHRLAzuZhqc+HvAF+a/3ZYi35qmcZK/Rb07uGJKIw1h0XInWY6Pqsxc62xqUf0Q5NhT3S512
 FxwgGm1hWIMxz4dzEWQXpnnnzrFH9GtLnEYI0HBotibmZuhYfDq6V8goFTIhNkubO4cO61t/MUb
 aR33sqinVep+1pcFhFbdk58vQyJnhhhtVPb0IyJiEJR/nFXz+qao3cex4y7UL7USVlFVTk5w8Tc
 itqhfKCycdIvulscLKq829bBTTzFNAnv1RzzHCAaB+UwZ0Q/25G5nYIxmqsPPFngheaqnhWIAr3
 hVYa+yHWY4jNhfn5eGgJoj4TC0KiaZM2YpM6Eq+VJKIJQCGTzMGrQiIJR7DgjGjskiPPrA3WSZ4
 S2TnzGNT5B3ayU9N86swZYSz/bABGccswlrgw=
X-Received: by 2002:ac8:590a:0:b0:50d:6557:5cb1 with SMTP id
 d75a77b69052e-50dd5aed289mr127199931cf.27.1775930874746; 
 Sat, 11 Apr 2026 11:07:54 -0700 (PDT)
X-Received: by 2002:ac8:590a:0:b0:50d:6557:5cb1 with SMTP id
 d75a77b69052e-50dd5aed289mr127199631cf.27.1775930874276; 
 Sat, 11 Apr 2026 11:07:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495ae96fsm13148481fa.39.2026.04.11.11.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 11:07:53 -0700 (PDT)
Date: Sat, 11 Apr 2026 21:07:50 +0300
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
Subject: Re: [PATCH v4 15/39] drm/msm/dp: Add support for programming
 p1/p2/p3 register blocks
Message-ID: <zputabw52nsba4ddwg7gd22tyouobkmlpq6blos7w3kx457otx@gitmjwroo7ou>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-15-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410-msm-dp-mst-v4-15-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE2MCBTYWx0ZWRfX6+v/TljD6xCH
 f6SLKdb1fmRW2Yfw1I51kRnd61zzZJHoiFhb2VuosffDOkHvXY1V2paXBieRKIslsr75ruUk4Tf
 Lmu9cjM0NyRBHD1jzq3MqNQY5i7AjP9bskDFQdiKzujNWtI78p2cPurAVdHXpMJv/l5/nRBSmDJ
 m2UNX11pVK+ALyqRPg5Wmejg/ecG57f1A5DtUYtwKyQQf9ErxU0n0eu54iSlHCP0qb0iE7n5jPr
 U1IIc8NRCw5BfTAFmorBMBaGu+FJJkFmAM9wKdP/ZssAlJV9VmSrxlaqWJwHWuAmca6C5oF8DyN
 cWUkCYfHKoEk7wqTylnES3fqCaeaBdGs4bV4FjjDlx07dp7DebMNWxUvxH989HklFAYjGOHpF4n
 Qg3KVzN+UyohSvE20+7zmWJ8jcsxGsM5dqlfiE5WWsNPHy5UfA2Y5JEqsukPbW/7DtEOjUlZSCM
 oGoAm8AvWRPLu0trswQ==
X-Proofpoint-GUID: m7BiAeFi3v0CWfoIk_VrqX2zJ0y9TzSh
X-Authority-Analysis: v=2.4 cv=MqliLWae c=1 sm=1 tr=0 ts=69da8dfb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=vYM-Xb_pCo5HwlhjwkgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: m7BiAeFi3v0CWfoIk_VrqX2zJ0y9TzSh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110160
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

On Fri, Apr 10, 2026 at 05:33:50PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Add support for additional pixel register blocks (p1, p2, p3) to enable
> 4‑stream MST pixel clocks. Introduce the helper functions msm_dp_read_pn
> and msm_dp_write_pn for pixel register programming. All pixel clocks
> share the same register layout but use different base addresses.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 40 ++++++++++++-----
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 89 ++++++++++++++++++++-----------------
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  3 +-
>  3 files changed, 79 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 7984a0f9e938..ff506064a3fa 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -85,8 +85,8 @@ struct msm_dp_display_private {
>  	void __iomem *link_base;
>  	size_t link_len;
>  
> -	void __iomem *p0_base;
> -	size_t p0_len;
> +	void __iomem *pixel_base[DP_STREAM_MAX];
> +	size_t pixel_len;
>  
>  	int max_stream;
>  };
> @@ -561,7 +561,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>  		goto error_link;
>  	}
>  
> -	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->p0_base);
> +	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base[0]);
>  	if (IS_ERR(dp->panel)) {
>  		rc = PTR_ERR(dp->panel);
>  		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
> @@ -769,6 +769,7 @@ int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display,
>  	}
>  
>  	panel->stream_id = stream_id;
> +	msm_dp_panel_set_pixel_base(panel, dp->pixel_base[stream_id]);

Hmmm.... Would it be better to set it up differently? Allocate one panel
per the stream from the beginning and then simply get the first
available panel when required? This would require some minimal resource
manager, but then we won't have to pass dummy register base to the panel
code. Or actually allocate a panel when it is required? Do we need a
panel before atomic_enable()?

>  
>  	return rc;
>  }
> @@ -882,8 +883,14 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>  				    msm_dp_display->aux_base, "dp_aux");
>  	msm_disp_snapshot_add_block(disp_state, msm_dp_display->link_len,
>  				    msm_dp_display->link_base, "dp_link");
> -	msm_disp_snapshot_add_block(disp_state, msm_dp_display->p0_len,
> -				    msm_dp_display->p0_base, "dp_p0");
> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
> +				    msm_dp_display->pixel_base[0], "dp_p0");
> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
> +				    msm_dp_display->pixel_base[1], "dp_p1");
> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
> +				    msm_dp_display->pixel_base[2], "dp_p2");
> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
> +				    msm_dp_display->pixel_base[3], "dp_p3");
>  }
>  
>  void msm_dp_display_set_psr(struct msm_dp *msm_dp_display, bool enter)
> @@ -1163,6 +1170,7 @@ static void __iomem *msm_dp_ioremap(struct platform_device *pdev, int idx, size_
>  static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>  {
>  	struct platform_device *pdev = display->msm_dp_display.pdev;
> +	int i;
>  
>  	display->ahb_base = msm_dp_ioremap(pdev, 0, &display->ahb_len);
>  	if (IS_ERR(display->ahb_base))
> @@ -1192,8 +1200,8 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>  		display->aux_len = DP_DEFAULT_AUX_SIZE;
>  		display->link_base = display->ahb_base + DP_DEFAULT_LINK_OFFSET;
>  		display->link_len = DP_DEFAULT_LINK_SIZE;
> -		display->p0_base = display->ahb_base + DP_DEFAULT_P0_OFFSET;
> -		display->p0_len = DP_DEFAULT_P0_SIZE;
> +		display->pixel_base[0] = display->ahb_base + DP_DEFAULT_P0_OFFSET;
> +		display->pixel_len = DP_DEFAULT_P0_SIZE;
>  
>  		return 0;
>  	}
> @@ -1204,10 +1212,20 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>  		return PTR_ERR(display->link_base);
>  	}
>  
> -	display->p0_base = msm_dp_ioremap(pdev, 3, &display->p0_len);
> -	if (IS_ERR(display->p0_base)) {
> -		DRM_ERROR("unable to remap p0 region: %pe\n", display->p0_base);
> -		return PTR_ERR(display->p0_base);
> +	display->pixel_base[0] = msm_dp_ioremap(pdev, 3, &display->pixel_len);
> +	if (IS_ERR(display->pixel_base[0])) {
> +		DRM_ERROR("unable to remap p0 region: %pe\n", display->pixel_base[0]);
> +		return PTR_ERR(display->pixel_base[0]);
> +	}
> +
> +	for (i = DP_STREAM_1; i < display->max_stream; i++) {
> +		/* pixels clk reg index start from 3*/
> +		display->pixel_base[i] = msm_dp_ioremap(pdev, i + 3, &display->pixel_len);
> +		if (IS_ERR(display->pixel_base[i])) {
> +			DRM_DEBUG_DP("unable to remap p%d region: %pe\n", i,
> +				     display->pixel_base[i]);
> +			break;

No, return an error.

> +		}
>  	}
>  
>  	return 0;

-- 
With best wishes
Dmitry
