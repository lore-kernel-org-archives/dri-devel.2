Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A07C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 11:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0873610E43D;
	Sun, 12 Jul 2026 11:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RBT1c7RP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kQ8+zwH9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A316810E2C9
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:35:20 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CAceBl2195992
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=C/wSXBBN4gDQlGAHKupNpiLX
 9M+PtyJNTEFTUsKADHs=; b=RBT1c7RPzYBAedGXHdXmBTnwN5FnPZpHPQNSL5G1
 hyEafsAKOXd+T/QugnDyvL8xPk2jEO/eOLfLu7nJXq4VxouQjy5+6MpVnXDO37Qg
 BqKwlulzJOCN65RxXSTeOzbQOmEyDRIdFvoDSYcXD153X41BvoNKeVh6TJ5apDkK
 /x9V4o7LjHyiihA1WyhZAazmRt/PIYvH8P89oe9QH8//OB8XNQu9TswnO9QwhRD8
 /8yhKklJcUEu/btJ/L7k1XGJg0d/ZbLPZXevRRSkxzgeGnkAEc2+0ijkVqKVhwqc
 kWJxoaI+RyTKV2QMsl85uQrt2151mjqmli1aH1/1Uhqmlg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbee9jqyc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:35:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso34698481cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 04:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783856119; x=1784460919;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C/wSXBBN4gDQlGAHKupNpiLX9M+PtyJNTEFTUsKADHs=;
 b=kQ8+zwH9vftljXqB2TccZE3h+x3HBUUSZ7KjzbuHh2mtdEhQVP0gd6A/NULo3P/Et8
 ce2uAsMbeWFHmzQqDBrbQSf9GG+E7/XE+Uzyfn7G31hgV0Wh2yEIGWFKgVmrUT2xng1q
 uLpQXvdmn8V8r8uNKYz37GEDtulVg3HtEDLx+61JuvrkvmjnYVZxZlPoLQLoKKS09uci
 xCh07qptCJQNKWtQALHdzymHcLrd+eiUkk6hS0iFv5PhQw+n3H8Vo3G6LxyPfb7RuoRv
 CRE+8oLLAx/GCnWtLRLHuLAW2jaIewB9sFFY3w6sW7uetoMXcsU/Nnh2XBe9oZA802Pr
 Ntlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783856119; x=1784460919;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C/wSXBBN4gDQlGAHKupNpiLX9M+PtyJNTEFTUsKADHs=;
 b=huTKOoOsHmAVzDqVyzlM7EpQnNnHIorgKuaTALeLGaRJ0c4B1s78MSzySE2H4cBYLF
 EUMeblGUb8lksBVg3lMfIyYS/D4DUG7jvrEel3oLz6VhISoeKW9J7AcoWXbFgw0C2fWC
 sNJ9otwgzVVtz025tV9IVW/0dbzU1GZS2eDQnfH/zfvkVY3n80zPXJCYjdV196G0YF3x
 9MRVK7/pkfYz+Kh9jodntVmpUaEvypiFWXaB51quqnbQmdPrGVgFgtKKAbbj/hfwLTaz
 gT+KVWDcwtVZpZflLS/Fzvv4qwgtcyN4p5n+5tDOZ5DhW6Kpn0fpN2lpRovHH/OgjctV
 U7Fw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqctqdDoBw1uhkqCVqMrN2eCPcqpUlbo2Nrl7t9cKb0lBlmh7mErdPpwi4KfhgmsnsdqsfqvkA5LEg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwU2AZsE2hWQCm0KreM2NzlOJHIM/oqDK0Yr7b9HcOH08Nxe5D/
 vnURtn30KKGwGrhc2jzEJ2SFsnAlgkhpbvHg0a5Ih7kUoKrapp6bKXXNd7N1pGwwlP8oNOH2ITz
 HAad4+b9SoQ4N4XiWafvLaCue1CaVnNx8POszcXjw5rJ1D8Jfijaz/DFoowacOr3RszzL378Go7
 qNEdI=
X-Gm-Gg: AfdE7cnQ+6Hxuq2f4iRVosISjHv5bFSVVbxVXNVWyWLjBEA+MARsZxQP5Ab8Pao3sBE
 v02gpMp86vqkxFCN3YLDdCcKrOAEISS/Q/5WtAjsv+/HVyF7iug7nh63KeoSgjFcxCvjKVMVA/n
 a7LGNLHyhMAEtu/+RiuuAoPhx+l5bHojKhK6vy4O1eub36TOI/BRYlNVciRJ//aDzuYRAXOmMwS
 YOwwwzNSLzFlwiAYFyk3T7BGYaLB4PXmHdQm+AgKc7x5RwZa+ppbAD5cBRXllg5DbD5/PzXT2uE
 0lxrilDstgMvyT1dI9ZL3GZYYxE6AQlMXAEtq9pYJslUuYNqcR7EJegXwcatmaxnluqNfodmgQf
 KvICfNPViAEgSlG8eF0yinRCpMC9zV7uGpMTdAByaVTBjRpnKlppcTXjgw0LiCPLivbEIjxo4oS
 Foc87NftT/xszux2QbEDUXICVw
X-Received: by 2002:a05:622a:54b:b0:51c:1f97:e852 with SMTP id
 d75a77b69052e-51cbf0e00d1mr55823861cf.6.1783856118755; 
 Sun, 12 Jul 2026 04:35:18 -0700 (PDT)
X-Received: by 2002:a05:622a:54b:b0:51c:1f97:e852 with SMTP id
 d75a77b69052e-51cbf0e00d1mr55823491cf.6.1783856118185; 
 Sun, 12 Jul 2026 04:35:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01ca5002fsm2010096e87.27.2026.07.12.04.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 04:35:16 -0700 (PDT)
Date: Sun, 12 Jul 2026 14:35:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kavan Smith <kavansmith82@gmail.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2] drm/msm/dsi: round 6G byte clock rate to the
 PLL-achievable value
Message-ID: <5zcohpmyufznjrqvs5iqpcbsziq7fg47e7rsbj4hndrcp4c4po@lgc2kunzwwd3>
References: <20260706180753.408753-1-kavansmith82@gmail.com>
 <20260707013240.681012-1-kavansmith82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707013240.681012-1-kavansmith82@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDEyMSBTYWx0ZWRfX7DbrbOrLNPmp
 dUUZsuqM5wiKlSecOTKUZce/GfpsdnYJSL0FZww4cKaS8CM2dqpsshpDypZmCHtjS8hzXn9MEXS
 v9wvyo349MIa2WSSbEOSZHZocfwSwqg=
X-Proofpoint-GUID: 2PGfSuZ1JTQnVIkc4almLNCCJ1H-0AnF
X-Authority-Analysis: v=2.4 cv=a7UAM0SF c=1 sm=1 tr=0 ts=6a537bf7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=S4yUXPuXAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=chEMFHXW5F1Shr2T6d0A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=uB3M1fsSz_FXjR1IXk1m:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDEyMSBTYWx0ZWRfX2RnNn0gAKc/G
 UW+hn7H5+QE8iFbXhmHla73Ksmrumu4P+YZSuqb5g8oCqYxQLinS8gwbbN/ukacvaL+JBUDsHYi
 sHkO6u5Jy53aJDwT9Dc54rv9ofekcG6T5thsseMoA1Qvkga3MSEQ480/u+MdX8gG1Fur/z1n8Io
 qunygytlhXYCqLdG0Mye9xUPw46xH+ugnVdyShOQdgKd/myiYRMtYyzhrwmZZxV2tX3+DpdmZt2
 C9ZCw1m7Kn/Jo9/lxv480+vDIhDZ/hn5ISPNPlhnkTkLnjjYJLTBdxd6gry82ue1K2O4W8lF3xG
 3oR0zifHlhl2pg5UT3MMmvkC2UAxu/u+REDTMy4Gv/ptuuWfDqW2lkofV7NfcPo24jDlnz6iPts
 zGfzkVtqeQ1QT9NjgTEIDgOF1EaXaVg2usxMxODwETsCRHn/x+U+UhmO7tmsw3HzbCDDNfCarpG
 rs6qJcEOAlPg819U/Eg==
X-Proofpoint-ORIG-GUID: 2PGfSuZ1JTQnVIkc4almLNCCJ1H-0AnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120121
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

On Mon, Jul 06, 2026 at 06:32:40PM -0700, Kavan Smith wrote:
> MSM8916 runtime DSI commands still go through
> msm_dsi_host_xfer_prepare(), which re-applies the link clock rate before
> enabling the link clocks. That is fine in principle, but on DSI 6G the
> requested byte clock rate often does not exactly match the DSI PHY PLL's
> realizable rate. For example, the driver can request 56250000 Hz while the
> PLL actually runs at 56246337 Hz.
> 
> Because the requested and actual rates differ slightly, every later
> link_clk_set_rate() call is treated as a real clock change and re-locks
> the PLL. On a video-mode panel without an internal timing generator, such
> as samsung,s6d7aa0 / lsl080al03 on MSM8916, that live-clock glitch makes
> the panel lose pixel lock and visibly corrupts scanout on each runtime DCS
> command, including backlight writes.
> 
> Fix this by rounding the computed 6G byte clock rate up front, before it is
> stored in msm_host->byte_clk_rate and reused by later transfers. Once the
> host carries the PLL-achievable rate instead of the idealized one,
> repeated link_clk_set_rate() calls become no-ops in the common clock
> framework and no longer re-lock the PLL.
> 
> This keeps the normal transfer callback sequencing intact, preserves the
> OPP vote path in link_clk_set_rate(), and matches the fix direction
> suggested in the original 2018 discussion.
> 
> Reported-by: Daniel Mack <daniel@zonque.org>
> Closes: https://lore.kernel.org/all/1a682c5b-7fc9-3aaa-120b-64b239a355a3@zonque.org/
> Fixes: 6b16f05aa39f ("drm/msm/dsi: Split clk rate setting and enable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kavan Smith <kavansmith82@gmail.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)

Don't send next iterations of patches as a reply to the previous thread.
Always start a new thread for the new iteration.

> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index eabdaa4..5119862 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -603,12 +603,24 @@ static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  
>  int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  {
> +	long rounded_byte_clk_rate;
> +
>  	if (!msm_host->mode) {
>  		pr_err("%s: mode not set\n", __func__);
>  		return -EINVAL;
>  	}
>  
>  	dsi_calc_pclk(msm_host, is_bonded_dsi);
> +
> +	rounded_byte_clk_rate = clk_round_rate(msm_host->byte_clk,
> +					       msm_host->byte_clk_rate);
> +	if (rounded_byte_clk_rate < 0) {
> +		pr_err("%s: failed to round byte clock rate, %ld\n",
> +		       __func__, rounded_byte_clk_rate);
> +		return rounded_byte_clk_rate;
> +	}
> +
> +	msm_host->byte_clk_rate = rounded_byte_clk_rate;
>  	msm_host->esc_clk_rate = clk_get_rate(msm_host->esc_clk);
>  	return 0;
>  }
> @@ -2056,18 +2068,7 @@ int msm_dsi_host_xfer_prepare(struct mipi_dsi_host *host,
>  	 * mdp clock need to be enabled to receive dsi interrupt
>  	 */
>  	pm_runtime_get_sync(&msm_host->pdev->dev);
> -	/*
> -	 * Do NOT re-set the link clock rate when the link is already up and
> -	 * streaming. On MSM8916 the requested byte-clock rate never exactly equals
> -	 * the DSI PHY PLL's achievable rate, so clk_set_rate() re-locks the PLL on
> -	 * every command. For a video-mode panel with no internal timing generator
> -	 * (e.g. s6d7aa0), that clock glitch makes the panel lose pixel lock mid-
> -	 * scanout -> ~1s of displaced/wrapped image on every DCS write (backlight).
> -	 * The rate is already correct from power-on; downstream MDSS only refcount-
> -	 * enables the clocks here (CMD_CLK_CTRL) and never re-sets the rate.
> -	 */
> -	if (!msm_host->power_on)
> -		cfg_hnd->ops->link_clk_set_rate(msm_host);

There is no such code upstream. You are reverting a code from v1, but it
wasn't applied. Please don't send iterative patches (fix for the fix).

I'll drop the chunk while applying, but in future please don't make
such mistakes.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> +	cfg_hnd->ops->link_clk_set_rate(msm_host);
>  	cfg_hnd->ops->link_clk_enable(msm_host);
>  
>  	/* TODO: vote for bus bandwidth */
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
