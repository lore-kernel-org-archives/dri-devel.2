Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD121C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 11:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0624B10E2CC;
	Sun, 12 Jul 2026 11:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LwGs31om";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WqRbGCiH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA91210E2BB
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:11:17 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CAdjWl2247146
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=LY8nTUIx9LtyTOuym7nrEjxt
 tDVZI/m/HtVz939s7qY=; b=LwGs31omgyQ09eM88G1hjEjWhQsYorfgkPZyt5/t
 aJ7bOIIRU3fOxmJ/GjR3sRmsaFr5zaYVE3GajRDiz79iqn8xCqynsyAD6ZOvDGV1
 4k2xm1n63YFQRtyWbcEgVnnOBGaUlBI7EFO9IUa7sszwO5muw+pCv43nuQzNA582
 lQpbHVjJxPMxWxBsVSelZewqXnHkJmwEMh2+j267zEeM/4u57Ek4sUPoFXEIIJcu
 314PUR+tQVQQ9CyQ/eYGZD4E3wZl4wYk8Wl0n0M4yjJo6T6TxtpIQKpswdoQhLGk
 7qhVK9uffzRWPzX0ZHefTFBs8BiM6nasBvYCbZcRmWoI/w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbekcjkq8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:11:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1852a86fso26151381cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 04:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783854676; x=1784459476;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LY8nTUIx9LtyTOuym7nrEjxttDVZI/m/HtVz939s7qY=;
 b=WqRbGCiHSn599lQWu2jwkQDo+F9BZVmnoXjlJf9hmfOFchRxDwq5B/xBHoyN7x+97u
 B09r64HIqwSgHoHT34EVZdnANZ+9Hdn9qWLsMszFehDCVomL0hzEq9tnQ7s8+7mzSY/G
 rgS31LwbxBmMr5x510BEcYlG/uKAkUsCiojaAyXtnR1Ad1VvzEufNghCPHbIPYphjJaB
 Ih9+wE0Zh8gEVUYhxJz8WIj8FzKFLJk3xAEa9xGn7VyA9OIl6AJsnI0JEN7dAPTNZZPU
 qxjA/RTGc1/1nqqVG/Y5Wi78De2j/OZ5DbqLSX2UwCvQhPQvFC9vPxyjTlhU3SkTxXYQ
 WDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783854676; x=1784459476;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LY8nTUIx9LtyTOuym7nrEjxttDVZI/m/HtVz939s7qY=;
 b=s9nsTqJGxtg3XAiIcWWkjv6IgFDRCAmUNxwDEvXHziOJm3ymR7Ln5RRdXUMD117+PH
 DzQ8RcVFiuqW3LBWnS4iz/kWP8dalKb6dqHPs/DQOp+Xzdy3o9+xOjRHenxI+Nor39yz
 dpFA0cwFHXYYVTPR3GwOgEwHVEmqDNxKwX6LpTRXz/XC932qBb+bPpoWGeub9qJm6eN9
 l6eQTh+bWgzof3fvtvLg3lTvwfuILqU31LvqK94301EhQc8gdYZ576dC1IaHnVK7w2tk
 ZYR/acJy0DjWqBZOJvPKMxzqIdfUIfHUedGy+nENdgRC7RagF6dmQyYCq9GJsc4IQFnm
 WLgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGXMyDLvN6A49sf1kVVhHhmPnaVMBtEAEIi9ICRDQyUHq2zPDSLjRH5NxoqZWJ33vOvS/bIPYg3EU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRlYAFSJeaEwqe3MzLbJgtUHM3sPjuU+gyEEAitYviMmYJv7Fl
 c9BTLZ0HMul1bgyZ+jOC4ym1n6iwGP4U4QJzBGnLykRfhftHGTO8WmdqI5EsTUv0hvjXhAQbIgN
 W+DC1f4cnAk4P3BROhdrxLtFXUtJ2eVJ8nxuZTuz0bCWEpWi6fUZUTHWTrQFML+w9xHiTFNM=
X-Gm-Gg: AfdE7cnCrHonM2glKHiQMMZEGQzMs5xwikCliMDfE51yvfnWB86PIPWcNjVgdl3o2jc
 +oMaEh+nRycKSLV84F+Qe8xCPBq/TRCYMaMZXe1cafVTGOTnfl3ya2E3vrY4imQQN9bHfjW4Y58
 XsNdJdIiiCiGmuJqbvgzv9suQgmCyk9n5WtUredN52YOMoEec9wtgemlwspeY3MTyvKWzoCYx6R
 uzqG76d5qacL+cPT2EwHitB9avpGHpBxlNb/PBD5zhssmGPVExerm9saQr0vwR8yidNsq1e5d/U
 3ACCLTDdMzZhqmQw1NgfM1nlzeVHqDzQbjrx+Xm9rZTXB/nGi7tRZWKxkY+oH+WECJGRpedBES7
 IX6erWuedjvmVs0iJvgifgdpN2F4E2kqkkAGqmWFcX2G7FR5krZh4ixXHMP3oQ640T6Bz9ET9eT
 8b9VTC1FwJwXDqCc5WddRHk+UN
X-Received: by 2002:ac8:7c42:0:b0:51c:2149:52e8 with SMTP id
 d75a77b69052e-51cbf279432mr52411951cf.70.1783854676173; 
 Sun, 12 Jul 2026 04:11:16 -0700 (PDT)
X-Received: by 2002:ac8:7c42:0:b0:51c:2149:52e8 with SMTP id
 d75a77b69052e-51cbf279432mr52411781cf.70.1783854675702; 
 Sun, 12 Jul 2026 04:11:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01ca4a297sm2057513e87.7.2026.07.12.04.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 04:11:13 -0700 (PDT)
Date: Sun, 12 Jul 2026 14:11:10 +0300
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
Subject: Re: [PATCH RESEND v5 01/25] drm/msm/dp: introduce stream_id for each
 DP panel
Message-ID: <7fjeip5h4jzvsuowvfgmnm6krh7tvulrv3l3laa65quscq2jzp@lor2elvhmhia>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-1-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-1-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDExNSBTYWx0ZWRfXzPsBOMrOPPpK
 lRGv4HEj5kkuOTBQBlgH0WQMQkh5UhozZom5Ditd7EoJH9QZVFZNK9kGyRcTveQe/nCrhUzZTDg
 ZVtnAUrgDn0CyUZLXSgxWzkyFcZxWfZVU6hBlJcNX22hs41lshQeul0crk4igjV0xmeQD80eNSo
 21M85xAZA548/gGhm/kdPUHMwe9Rhyo50TRz1uUNLHLolMESzwXSXmQ0n3vXF1WitoiEUUI4J7K
 gdC55loaZuefUlcCi+wXYaKe8+AcAHZ02PWZB+AgpHA/R8RksFOmHI5e2GVCPNlL5DzDZrR06vQ
 0mJW9s1fjsdCiAzjih+i92M8EPF31moI4TWgq5RUlDZEvKlScr3qDvlaY1NGXZ2uLc1aniFIhC8
 XHMyP5Fmd+q7Evz6z0Wvps3fNwImiRHtPTJ0jj7TO+us77tLd0kdWrToPC0+gJKRwJWHd0eBBBl
 NqpqXFn99mOHG7qkeVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDExNSBTYWx0ZWRfXwltzvE74jaRO
 Y9WKSxQkwBIFrrPvoexud5D8mG/dTOoi1BgqVYHuwWpjHnhRYvSibFtKwC3LoTaHrkIDEwgIThg
 tgtGX3M0omECqA3pu8M76jglRR2hSI0=
X-Proofpoint-GUID: cFbyTqNTKLkFd6B2najymkUo7m5NZP4g
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a537655 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=GwlwfuPo3DdifNSfN00A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: cFbyTqNTKLkFd6B2najymkUo7m5NZP4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120115
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

On Mon, Jun 29, 2026 at 10:14:22PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> With MST, each DP controller can handle multiple streams. There shall be
> one dp_panel for each stream but the dp_display object shall be shared
> among them. To represent this abstraction, create a stream_id for each DP

You are not creating IDs.

> panel which shall be dynamically assigned to actual stream IDs by the MST
> path. For SST, default this to stream 0.
> 
> In the MST path, panels are dynamically assigned to actual stream IDs at
> stream enable time by the MST layer.
> 
> Use the stream ID to control the pixel clock of that respective stream by
> extending the clock handles and state tracking of the DP pixel clock to
> an array of max supported streams. The maximum streams currently is 4.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 67 +++++++++++++++++++++++--------------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
>  drivers/gpu/drm/msm/dp/dp_panel.c   |  1 +
>  drivers/gpu/drm/msm/dp/dp_panel.h   | 11 ++++++
>  5 files changed, 55 insertions(+), 28 deletions(-)
> 
> @@ -2188,38 +2188,39 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
>  	return success;
>  }
>  
> -static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
> +static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate,
> +				    enum msm_dp_stream_id stream_id)
>  {
>  	int ret;
>  
> -	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
> +	ret = clk_set_rate(ctrl->pixel_clk[stream_id], pixel_rate * 1000);
>  	if (ret) {
>  		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
>  		return ret;
>  	}
>  
> -	if (WARN_ON_ONCE(ctrl->stream_clks_on))
> +	if (WARN_ON_ONCE(ctrl->stream_clks_on[stream_id]))
>  		return 0;

Is it an error, defensive coding, DT mismatch or something else? Why are
we warning the users _and_ returning success here?

>  
> -	ret = clk_prepare_enable(ctrl->pixel_clk);
> +	ret = clk_prepare_enable(ctrl->pixel_clk[stream_id]);
>  	if (ret) {
>  		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
>  		return ret;
>  	}
> -	ctrl->stream_clks_on = true;
> +	ctrl->stream_clks_on[stream_id] = true;
>  
>  	return ret;
>  }
>  

-- 
With best wishes
Dmitry
