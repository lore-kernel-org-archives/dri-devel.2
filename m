Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6AAF3ED6B
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5060E10E274;
	Sun, 12 Apr 2026 00:20:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LQqRyRml";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fMcIA8vQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C456310E274
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:20:39 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BMvfNi960399
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=38k/XTq7kKCBw+bFrD6wXO/P
 0rbeifQeFp/yj6jZ2YM=; b=LQqRyRmlOhVITTnkio20iiVY/SuEJAiXpqhbkHqU
 8qdZqog0MUFhcpL9ibpAEeQxkdsEwTInKXnr/iRhnNsKjAm0VTmiv2pqIgy/7TIF
 Y5V3gxKWYyYCyaUvYrFbfSiu/JOH8zvs0KDZBwgaKSqLUiuD2I++12/TBqZiynJC
 kOvYDuwK9QzJA0St+SJQ9ObJOByq0OEmxSjxI9/pGfNRgr6mH1nuGowCM3T2CCTT
 G61LSNiRMnv4gZh6i0Wd2VlJ6/tCZBu/Q/L3B4GNtvXAYbmPr1uTiIKxtXngCOIX
 OTSqnObic0rPMI4ZUn5UugfFHV+8Hdz+HfqQXYmgT9LR6g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfjbp9892-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:20:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4ca7e7c2so65135641cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775953238; x=1776558038;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=38k/XTq7kKCBw+bFrD6wXO/P0rbeifQeFp/yj6jZ2YM=;
 b=fMcIA8vQ3A6Pre3L8KtDKMBS/fFlZ2SW8D2pHCFO6ShGkrZ2fpO++Bqh+VVUJZU5Uo
 gkRkOyEpR8CrVsY1E5kx9TmuOZSbyuNGXyba2tWpRp19R2033cghOJ3b/eM35b/ltlkr
 VlJ96gBWglvgcDtrEApG7op7ze2TNfSMWjqzvuge6pSgJX5D4vRHIINVo+eAXNFuK/kX
 hOuzrnV2FvVioKOeNy3LG0Ncl7Tzb+ykfVubGVYJ3Tfm4KKU/745aWzocExPQ3NDKhJd
 2MMpjJWG9fwVe4rVSzPuHKrnNhA5TxL2kNfD70CxKN47nThVDpy6t9KGEyM5X9XT9KZ6
 GRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775953238; x=1776558038;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38k/XTq7kKCBw+bFrD6wXO/P0rbeifQeFp/yj6jZ2YM=;
 b=luqZ3M/PfLdFHr6zlrskN86wnkIp0TUV++/ri528vjFkrfjuL9NGk33DvBKbifwTeA
 0QL/VTZ9tWLEsmrWQPYkwFQkor4TDUcMR0uhDtWFT1+z8R4rZeF/zuiggvZjOGLAl1yf
 5UbosZn3sAKq+XXBoG5riu0/N0FcshKGeK3HaWdMPbDmR3CD8I4msQ8hsagRS8G1z6tu
 VTtbm4tII6wGBR44ozCWs48tIOjh20bgFTralF++y//D/9ASh2rBoQiRNA36I5lxuLKM
 TTZaQEDdQH0byuRxptwTQkZR8hRLkstMeoXh5KTGx/G7t07lNK9y2necIdMb3hmvVB5b
 Lh8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs8gtr0rIMOTeLtVeIHFWXoGvYVv/mUBrFzqlh7pf2HjoG080XR9ajU6L8HK2E0AXK08zHmhAf/Mg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVN3zrOknX2WNNibYYfLKw6VkWGIB64+Ebp3bGwUqVu8UodpWb
 uU/L4QZ3VJHrZ4iQ1Lp/sniFpL4X2+PbOnxqSAw2RPKLjzfpyMQAEPJ4Lj45yMAQJzk8P/esQ61
 bwpFv3xIxeuWVtk3t9uNjm3Mmij8WKNZdSFzAAYEWFo0Q7ruSkc3NFdGeURLAdH57K6caGdI=
X-Gm-Gg: AeBDieub+04kGXmJMtsF+cNN4hbRIraLWyMZ09IaKaZtzylSed8UsFeB8jV0AOLPBJi
 Fvf5KPMnmUGwknjYgZHEZEphV+kbzzTM+JCn1JkUCkPRo7xuzDFkI1vhp8L+Sh0wzsqM/DRUyP6
 hdrWJO+2xWDhSEzhiL81yfva3K51h01hQPCGNu3h9728GDaayYNslhbDYGZ+6HSPolHuBWxoGdM
 +TKnGqzYImK2l5mfPQ096wImsBQMaljVqYvPijxQjJxdsMn3U7jf5LAIwNXmY3eWlt3qGdDUTzU
 HQFatd3hsk2tZJjHhrKPgzl/qRueRhJHkhyTVOSwdYmSN/+JBFJcMlxJ6OBdxoyCOv4FQTSZPMY
 J9YIWGYuay7u49yTCdi+tIgJWXvxpx0VcWydEWYot7xb22FhhfCVx3bbftfu8j/hQInAplnL+SO
 bs8YRoQRBrpY7k6b9lkr5gxLDF/pxZEyVo4Ws=
X-Received: by 2002:a05:622a:998:b0:50d:830a:4213 with SMTP id
 d75a77b69052e-50dd5b2ef3dmr137656621cf.6.1775953238316; 
 Sat, 11 Apr 2026 17:20:38 -0700 (PDT)
X-Received: by 2002:a05:622a:998:b0:50d:830a:4213 with SMTP id
 d75a77b69052e-50dd5b2ef3dmr137656291cf.6.1775953237855; 
 Sat, 11 Apr 2026 17:20:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeee1201sm1642279e87.54.2026.04.11.17.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 17:20:36 -0700 (PDT)
Date: Sun, 12 Apr 2026 03:20:33 +0300
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
Subject: Re: [PATCH v4 03/39] drm/msm/dp: break up dp_display_enable into two
 parts
Message-ID: <b5uajle5nbjziwoxjpxrdog277acn7xpkl6kaeydjuwf3t5jkl@opvkfwursb43>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-3-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-3-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=PuijqQM3 c=1 sm=1 tr=0 ts=69dae557 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=o24zTyMAPkfF8K49h8IA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: azv30tSJkknwnsKQl-731_BBk5uL4ufm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDAwMCBTYWx0ZWRfX0poKRGbmI2lv
 9wj5Z42xK/ykkoC9T7Ez7WscScFIrIyw6qeQLWXgLv8B6K3b437nJ9u1uDhEX5B1tQYD13npzGh
 UdejtBXHxITTQhR9O51QC6d5TKKiXfxzpyutdiafz+0ZPlDmdalVOPABLq8+vE92zbuSs1VxyLD
 WLlaOxD4KkMtXaxZStarf/+OyJ/V7Bt1IAVaMzqHONmPZfN8r+Je94MOcTp+fGzChC0Ej+jTBJ9
 jP3en16lhitxSxNoCmmY4h9FViRV2V5OUUruBg1pYUsB+YW0Tm6lyLCswOv4zamD7ZTAs9yjihM
 uSZnYjuRj3a795G3h520uOoVqWIsOk6d9jFHUQtTdIKzA1RgSVi5f52SZvEA+Qa+gKgELQgMQuD
 10BM/fuGXLCvtIlzeyKLOiiJAkf3AMwa6WjhVDkuj56OhzkUSfpEaezH7YL0PXkf2imZZrhTLB3
 pl3frAltWbidW1BFVvQ==
X-Proofpoint-GUID: azv30tSJkknwnsKQl-731_BBk5uL4ufm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604120000
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

On Fri, Apr 10, 2026 at 05:33:38PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> dp_display_enable() currently re-trains the link if needed and then
> enables the pixel clock, programs the controller to start sending the
> pixel stream. Split these two parts into prepare/enable APIs, to support
> MST bridges_enable insert the MST payloads funcs between enable
> stream_clks and program register.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    |  54 ++++++++++++-------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |   3 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 105 +++++++++++++++++++++++-------------
>  3 files changed, 106 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index e9f0b96c3ebd..5ecbc83c3838 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -622,7 +622,40 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
>  	return 0;
>  }
>  
> -static int msm_dp_display_enable(struct msm_dp_display_private *dp, bool force_link_train)
> +static int msm_dp_display_prepare(struct msm_dp_display_private *dp)

After going through the patches, msm_dp_display_prepare() ->
prepare_link.

> +{
> +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> +	int rc = 0;
> +	bool force_link_train = false;
> +

-- 
With best wishes
Dmitry
