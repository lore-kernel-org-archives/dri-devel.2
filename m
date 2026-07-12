Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FCCC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 18:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E964F10E2F4;
	Sun, 12 Jul 2026 18:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iEfFRMd2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QiqOQhdK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FECF10E2F4
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 18:21:01 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CGs78B3175708
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 18:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=cOa4nmmTOHFlx3MF2totcfZK
 vZun53wwDDNf/M+wpes=; b=iEfFRMd2fwtH/n/CCHTaR49V23rHWxAkFgkrnDwK
 kKTpNiN4nkSswUIYQlboo3MGdsIzgD8EjJnnOm+ZvZ2N972Umw+y6Tawn5AgFOK4
 0kxQrA/XeKSnsWQxn1eEwbW14KKDUPjhKUzYsJkQ99kc4LkcQ+MH2xgxn4clbLlA
 kPPe3Feg570kX+4r9E3MXnCpdGe+A90b/Vjz56CHIl11bma/R8BW015pPDpoCnfI
 35OvIEiK1PI4MBMKNFPUFIQYasQYtQBhoyoulQyT9Dl4sjAaNB9sP11UdvO2PBPc
 Ejpwgm4sKNjGzf4OuNyEG4J/wN7PVS4OuU06JFxq/XnlXw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe9hkbbg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 18:20:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8db414c7so35027321cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783880459; x=1784485259;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cOa4nmmTOHFlx3MF2totcfZKvZun53wwDDNf/M+wpes=;
 b=QiqOQhdK/t8GeDoZPBlwU76MHmaDAFtM19k5+JD1YwwKonjCqERc/8InRtfXonCzlA
 1HcG5OrrggMphB6gNlkuRYzz9UyVWo82G9+NWbYJBxU86Fiyp4TrJtWZ+ULuL+26zcFy
 8ll34J33A5YTxHLS6ksRg3aLXuPFoyDmwASQBpQ9d7fi5drE371zWPt2eA1jzF6kBcsd
 Qh35fGgbXBBfS3DKCcKKEtcTkl2tRGMDTv+KfWw2pscncDL53NbezuBpr+/ERGDwyBgN
 0knrCQ1Usi9G+W4UZLSmHHPM8ze/1jnGt4GfJ7mw+goQtr6B3o58T8hIe7AOfOtr0Zts
 Y+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783880459; x=1784485259;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cOa4nmmTOHFlx3MF2totcfZKvZun53wwDDNf/M+wpes=;
 b=IHfi36JEvoHCEEYtVjQ2XmabI9gCXHu9jlZYrjbtdmIIFiGZ4YH9k9SPzCRGm67b20
 ezhEFc2QjzmpF6GfMJwdIOI6Vhr/eBXO//zV2plJ46KBDwyiRj7+7b/t3400fa/cYrZf
 ebTKd8a66n8/HOqBGMO+Xnh3sVKCya64php+LSrHNupjppnHqf46usH97bB8Uo0My3f1
 l/u6axGfHBsqxTn+G+gZk69FufErO9otIaVMEOnoBe261pi/8q/lP4jdJvg6E5bl2Z3X
 vWM3AKzTlNhq1Zp6+O7NGt2maI3/whQzkZ9vWEeaiJAQUOr4T07f+pYIo2Aqia4HWuuy
 id1g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrqsi2bJDMNUfHVbOSGpwRg7ml6A8FM5MZIJMni3lwnPlWwnS7p8I0pXZaph8RBthvy6GMIarqR6nI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yymssjxxmw6nzNr+p9EwbPlw2mwBdxtTzhHOJ25lvOvLpFWyv0M
 3uXTzWzIg8z0CeDD0+4l5e6vqKhjhJUk2H0VRQ7OfrCtQsGHaarhsveGaEamMGsocsM5wNVd8PX
 2QVYpNhWnMOTX9DwF6xWyhWNYeV+yIdkKWKFh14grWqmx+FEnmIonfoxGDxgWIJKcLyesG34=
X-Gm-Gg: AfdE7cl3QPIo/70phoALoSWQwWH9tgYWuIJlwEaUgn62V15LPcM+iuDStklS+y/JWdf
 /NkyyezFIH4T3Bsf30uVzC9Z2W8eYcCk5ApD8uBi6Pw7aPCo43Gkb/QIp5VUeW1W0daTev55SNv
 RKxfPMxmhDGHXlR+sa3eRAVeD/4yeN7uOYd1Q2PdRsjihBZV20m8DUp6Mg2zuDG1rE+lAI1iSlx
 Fy9Xiw1XrlQ5mKC0q+K8VL8RmMMDbXA9mvGQTEDfO7NycD1LJIvLdSWCkXJNLEGk0UeOQv530yj
 RMBKnVSyx7T4Ywtw0BGZjQCvtdBOPvcEFV4ab6LY9GwAaOIqeBBFnyytduf/9rfO6UGcFYQLbE8
 HNjvQBFCfko4pfstSdKcF0+D+vhR6JdhsJX2T4fj+1SEm0E6t9BzVZnIOpKrWpDqOi/dMlaJVw+
 OyDdGb4VEc3HkbrokTDVDsGhdw
X-Received: by 2002:ac8:59d6:0:b0:51b:60f1:689a with SMTP id
 d75a77b69052e-51cbf0c47b3mr71093071cf.7.1783880459213; 
 Sun, 12 Jul 2026 11:20:59 -0700 (PDT)
X-Received: by 2002:ac8:59d6:0:b0:51b:60f1:689a with SMTP id
 d75a77b69052e-51cbf0c47b3mr71092781cf.7.1783880458706; 
 Sun, 12 Jul 2026 11:20:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01ca4a382sm2275808e87.16.2026.07.12.11.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 11:20:55 -0700 (PDT)
Date: Sun, 12 Jul 2026 21:20:52 +0300
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
Subject: Re: [PATCH RESEND v5 11/25] drm/msm/dp: move link-level teardown
 from display_disable to display_unprepare
Message-ID: <4las62mpvcuud6m6yo2mz6hiijv73zt27hnha4tlaejubt25x5@gxralblac3m4>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-11-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-11-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-GUID: t_-NlzGeO7KUc5HzBuK8h45cQA0pw1DP
X-Authority-Analysis: v=2.4 cv=SajHsPRu c=1 sm=1 tr=0 ts=6a53db0b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=MGG9Fet2FOA5F7jA1VkA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: t_-NlzGeO7KUc5HzBuK8h45cQA0pw1DP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDE5NiBTYWx0ZWRfX1xx1opCj6Rrr
 31lqERf13fvOpbRxGWrNpA2rnIkb3DRjOXagVAsz0HCwjdLHuXhDh0UQOqIv9st45b3up9HMJBN
 bqWCeQjgaIYfbfQU/0LyTbCNqlCo/GX28EE8TIm8rqJs3vAgMtEabfKSRzHca5J+n/M1uEByuJp
 mzBbShLc41ct0034MIFhuS7Q+FO4X8ZToN5gAP11rDNUrjeIgetqH1F0D+y61E4Joy7sk/NtYbs
 fNQ0GDPOU6VSEf94xli8aT7v3tsYzppbFxvDko2KcczbDydPBG2C5ro4Myiyj1yH4nBw0bzBubO
 ttDO+SqTSZkmpYuVW8ZZx8oe1eg2VRxQ5TsGAV2X3EhE3TF2VAxrlZ/ldgIhu5AUwZldoeS9pJF
 CIt1ZIgvAK5viSMcSt2AWj8Dsxt8XQAfma4hf1BPs+O4uKccDCc/p5tjqCpqMjeSjI3mHC+pV+Y
 CTHI8TpUOoDBC+HBVHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDE5NiBTYWx0ZWRfXwPUvmiuRKByd
 Y15eob/MUwAM54oWhqQj2dMzCg09P5C1ascWefByOw7nD9ltix9p6WyyD2VC1yQgOKmXSMFdl8X
 AZvYXnzHn6ry2NMBVnW/f50pz/8AdjE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120196
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

On Mon, Jun 29, 2026 at 10:14:32PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> msm_dp_display_disable() currently mixes stream-level shutdown
> (disable VSC SDP, off pixel clk, clear power_on) with link-level
> teardown (PSM config when sink_count==0, off_link, PHY re-init or
> host PHY exit).
> 
> For DP MST the same link is shared across multiple streams, so
> disabling one stream must not tear down the link. Move the
> link-level steps into msm_dp_display_unprepare() so that
> display_disable() handles only the per-stream sequence, mirroring
> the split already present on the prepare path
> (display_prepare_link vs display_set_mode / display_enable).
> 
> SST behaviour is unchanged: atomic_post_disable() still calls
> display_disable() followed by display_unprepare() in the same
> order, and the cached dp->panel used inside unprepare is the same
> panel that was previously passed in.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 1af56c84b82e..1680a67284a7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -731,18 +731,6 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
>  
>  	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
>  
> -	/* dongle is still connected but sinks are disconnected */
> -	if (dp->link->sink_count == 0)
> -		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
> -
> -	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> -
> -	if (dp->link->sink_count == 0)
> -		/* re-init the PHY so that we can listen to Dongle disconnect */
> -		msm_dp_ctrl_reinit_phy(dp->ctrl);
> -	else
> -		msm_dp_display_host_phy_exit(dp);
> -
>  	msm_dp_display->power_on = false;

The list is no longer powred on at this point. So, this is wrong.

>  
>  	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
> @@ -1533,6 +1521,18 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
>  {
>  	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>  
> +	/* dongle is still connected but sinks are disconnected */
> +	if (dp->link->sink_count == 0)
> +		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> +
> +	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> +
> +	if (dp->link->sink_count == 0)
> +		/* re-init the PHY so that we can listen to Dongle disconnect */
> +		msm_dp_ctrl_reinit_phy(dp->ctrl);
> +	else
> +		msm_dp_display_host_phy_exit(dp);
> +
>  	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
>  
>  	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
