Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6494C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CA210E599;
	Tue, 28 Jul 2026 13:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cUgcev3L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rj61MaJ5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5BC10E580
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:57:18 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SDPXh23112634
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=J6F4TZN6AddpdswCw+TOERdC
 B6esaNgGvqSJnVXEzNM=; b=cUgcev3Lwxfwu8ATuI+zI93rdwf3J89jA6JvqOa+
 WQc3qvu2tjnnmZDdFWZ43jSSHxR1LvkEc/hO07igQOAs3pA0r8CYX/RZJdt8kSxT
 Fs+FkszihcqyAhnmxluKXWa5DvqPiTTM2gwPGo7yAWZfzYsXA1Gt5VZAxUQbZvwY
 noemk4fpq4dKsjjerDE0m8qmPhK2zVz273yPhYdxZeybR9s/mrtSvQpLv3PNy2lT
 XMSiHj68skavhMxMtc3wtSQK+wc3VftP7y7ywGO95hWu6gyw8n5pr+UzSb07r6jY
 3j3pNFTGGsIdmBVVM2b/CdYXZEeYSYX6B59hl40+vHg3Bg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y2ac9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:57:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so88287641cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785247037; x=1785851837;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J6F4TZN6AddpdswCw+TOERdCB6esaNgGvqSJnVXEzNM=;
 b=Rj61MaJ55e9+FbXAkzVx90qtJcCmUjg2qBC+myOSXqxPdo4jiDmLbAO3soJ0r7GgA4
 QfRWlZ7l8KAMuaiYAeS9bJ3crm9kFtr5B2eCLOjhRCMJ7wOcYeX4OsCAqFTMgWL8pxNX
 OIxGGrin8anlN/WxzwgF/HeFpA1OJQXGnrrN2fNSMcyrJ4ww1M5A4PFDkFxbASoNZl7B
 graVrPwS8qcleVJ+Wwy9pq6YW19BuQvnPaIiWUoJpYHXnR4qfDWBS34sPvnukMoDOxk+
 ZMSAnwk+IjxXLrMiDdCpZBp2dRIFW4u0YqBE+dv4fYgPEjvzuXhC5DFILzboiWBz+Afw
 V4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785247037; x=1785851837;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J6F4TZN6AddpdswCw+TOERdCB6esaNgGvqSJnVXEzNM=;
 b=BJtHDIBpcEVLjwAPXfr6pSWA6hU5SeJslm/vL8XeFUnLB4OUhmfzjdtVIcvo0KqsB2
 SSMd8iIwIAy4wpta17DkBpX9u+K2BPxaANkIQCOxl6NLfw2b5jy0+VTdq8m9mOpjOhZm
 f9HSWidWa8DgmEpDLeUQHq1egpUrxVVKHSae8mOYyXKunO5cg8VTOsDDiE003771E7iG
 QNrzY0/iqtjYFAA8pnzrDEdgJmdoSQz5WTEjfyGqqqAQ2vv/TKZwn8KAO+mYoVW/SqmB
 +qD86SoMTTDijVYsFm2LeXEiZ32M942kf6cctUhuoa4uX5zrLFR0bc0IzXxgTqNKag2N
 oruw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoT9jbc6ladSTxXnaVwAv1hFyTeAzA/fN3S7f+DyJARRJ04YC1QgahAAFuz5Yu4CMuJ9RAkH00sTMs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywir43vr2HjmqA8Fpw38qNMt3+s035Nbt4Gus+HhhGI0wzeGvI+
 MLdoPLFRCczMoay0T5XeBRR4XsvR30oAo9Yo6WEOO1F2qUhc1nHmSKJg8VJmefeQSOtk99yHPHJ
 fuNEaKOqFE2SYwIukAXu25Mi+vm9rTY25wxJtzQmGBLuy+2trmOSnkZ8EYl8G197JrCGkf94=
X-Gm-Gg: AR+sD10R9yjhiSzkt52a6XacBOC63bQvCRaq1M0zskRrYrKD2k9dUFYcxjxG/WZfsH4
 CeOtvQL8l0HACUtfNb6oX2mVvnmzTc0mx3Fbqx2KyQX1AfvRLqfOFgdmNx5gydN2ugKIGAtF6p4
 E8EAocID7YfnW1OQwoZDumhQsawQhUDlHHeLXDsDnm8P3MesNJzxW7I3vQklwVB7Wtx06qaDXzM
 aM6+akAAvn9mkR+mJFVZgbNmp2AFf8PJ0u0kepX0v4JBaiqM7+CuZZGNxyYZDxf20pg5E1zNVjE
 4S0t/s6LQAkQ7atO0L9lElK863fHEDu3ClhI9h/3Y9dSJKhoDCDLuFxxPm4Zh8N43I9fjVOHFj5
 JEoX7trnHwpG72rtTLiOjaySWfn/n4Vx3HdD7Vkc/3/DNltlpL5ZBsBTwhSYSYf/v7xV2tmjWaj
 eBsvhtzudfhjjy3w==
X-Received: by 2002:a05:622a:192a:b0:51c:c67:2042 with SMTP id
 d75a77b69052e-529d71da27dmr20415441cf.53.1785247036705; 
 Tue, 28 Jul 2026 06:57:16 -0700 (PDT)
X-Received: by 2002:a05:622a:192a:b0:51c:c67:2042 with SMTP id
 d75a77b69052e-529d71da27dmr20414971cf.53.1785247036109; 
 Tue, 28 Jul 2026 06:57:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2be077c14sm2123277e87.1.2026.07.28.06.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:57:14 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:57:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 Sravanthi Kollukuduru <skolluku@codeaurora.org>,
 Rajesh Yadav <ryadav@codeaurora.org>,
 Chandan Uddaraju <chandanu@codeaurora.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Vara Reddy <quic_varar@quicinc.com>, Stephen Boyd <swboyd@chromium.org>,
 Guenter Roeck <groeck@chromium.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tanmay Shah <tanmay@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] drm/msm/dpu: Drop sneaky dev_pm_opp_set_rate(0)
Message-ID: <twedkppa74qxgbphy4xqhreb4a4s524jfjuzaqydtizeutpjql@tht3pklgptp7>
References: <20260728-topic-dpu_power-v1-0-e7783b859a70@oss.qualcomm.com>
 <20260728-topic-dpu_power-v1-1-e7783b859a70@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-topic-dpu_power-v1-1-e7783b859a70@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a68b53d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=JydwUDacOMusncNaJ5cA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEyNCBTYWx0ZWRfX93fhI6C/+mik
 on2p3URdg4wIRsNJvxLU70/Z/K8Vlk2jnLhubqtWWcaOPvrAAlLWhBQjYSvb+gVrfnWhv/El7mG
 X3DtvsJamKd2xu3gxUe8bVasjaiTj6w=
X-Proofpoint-ORIG-GUID: 4Pb2QNRgNXdPYhJBzn0a2nr2aijAibao
X-Proofpoint-GUID: 4Pb2QNRgNXdPYhJBzn0a2nr2aijAibao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEyNCBTYWx0ZWRfX2PM72VYkZ9e6
 L6W4LVr5BWYybGUNgvPw+Q2yVhP/XNmYrBbwj5FMk9rUgSxyuZTls4enXhqGbAoNDV6xNKbhop7
 8We85i3IQe9kD15KtPgus8L9fGB570KC7UQgX2KqodF7zg0wqix4hbZgUb2wGcuKUtf507zgpvc
 48YR1vn798aPiYVbP1uxRZtjXqU2pXkbzMVtCwq3bqlGJaF0S+fpdMhMJqSyu+23t8zvgDDH37Y
 vhZYRqB5qoP9YZtIuGcqTfLZwCt1do/6QBSzaNDuUTWdKRORAdbRw1GF81VOhek1dqEaz0Cev05
 lSsf3ld4a/RK6YIqR7+QNivNgaCzlt9kRFaycpveQJ4YGaXkZeZkowP7XuL4FeJ7TBiegqPY+o1
 goiqbLKyRvcaRlrNbumVJ/GVR6SiFzpbMQ2Bff/Z0WiBTCHVFSUDhrwfqYozdTPvf4Sl7LY6ulf
 aq2yMUVL2v4J3VA8x6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280124
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

On Tue, Jul 28, 2026 at 03:20:45PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> dev_pm_opp_set_rate(0) removes the vote specified in required-opps but
> does not actually park the clock, making it run without the necessary
> power backing. Prevent that from happening when
> _dpu_core_perf_get_core_clk_rate() returns 0.
> 
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> index 2ff255d7795e..fea173e37464 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> @@ -394,6 +394,10 @@ int dpu_core_perf_crtc_update(struct drm_crtc *crtc,
>  
>  		trace_dpu_core_perf_update_clk(kms->dev, !crtc->enabled, clk_rate);
>  
> +		/* If we're going offline, PM callbacks will disable the clocks instead */
> +		if (!clk_rate)
> +			return 0;

Is 0 here an actual case? If it is coming from the core_perf, then the
next line will handle it.

> +
>  		clk_rate = min(clk_rate, kms->perf.max_core_clk_rate);
>  		ret = dev_pm_opp_set_rate(&kms->pdev->dev, clk_rate);
>  		if (ret) {
> 
> -- 
> 2.55.0
> 

-- 
With best wishes
Dmitry
