Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7A0CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DFAD10E21D;
	Mon,  5 Oct 2026 03:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nm8Lq3TI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WDLA/klB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E835810E21D
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 03:25:26 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695103OA1464827
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 03:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hTYxHI2g7XScWCuVufXL3ZLK
 7k293CtuFnd4R0QnRjA=; b=Nm8Lq3TI5O0+0rLN4BPnewiBSGcXSJ8lOZ2MIb8j
 4rrMDrcWbduP/EWehSDwTQIza8RRFOAZ/YZawkzwfsJnWIa1Z0oguCa3H+GFBmXz
 uf8XdLazMazoRN2mCRLQmnw4KYURim3B4FwmFDBvXeBthA6QzQFIeySb0QAuuQeJ
 f361UKrPaWn7LtV41BWYM4ml6pQTWOo0tUqi9Ja+mt2gMY7YQ9pXofpzCwgnLXcK
 ZBMgaDQqxdwJGZXkvYR6mXJesSbUsHFk519R8rQcdZeYz6ZOiOx3KxK7UuGPTKfy
 n2bBjyTSTxCD6zi5CIJ/zPNx/s72zPiyT53fuxv6fiCdEA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sssm94q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 03:25:26 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7c39a674d83so892823137.1
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 20:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791170724; x=1791775524;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hTYxHI2g7XScWCuVufXL3ZLK7k293CtuFnd4R0QnRjA=;
 b=WDLA/klBdfDN0Shla5dCNOyR7c3eMSsdDTaMQO6Gui4K5yK5SQBQpzfpEGL6U/9dCt
 L375pgDTnOp2qioXpvOWkYaDDSHpX7DqllldPGR7d4qya2Jc4JxJYLSBu7cgfWs5n6Ln
 lgsd/qIZOxGCGAoDVZRuNHjtBl4flMtJde/SlOAphDQ0sjJmqkSrcIhaxhsYB5q9Hfgf
 FQeLrJg9A8lgsBXHe3wX6Z1YRDo1OWP/bmw8XcV2QSoMALJ5OI1LgtlvyiNRUHH7fHCI
 U1BeQCZMN0jAmcatypuNcjBA1SsG7hdXYLzu1Blp2vhSDQJOLOiG+8+Vfgd4bNI2tv6M
 rIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791170724; x=1791775524;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hTYxHI2g7XScWCuVufXL3ZLK7k293CtuFnd4R0QnRjA=;
 b=tg+Eralo2LHlJSF1BT1pVXggWt8I85yxNz0p5o4/c9daFtK3CkDD58QOnCvg2k8jsZ
 4TUb/19h+7oH1PdBcAlm4uduYUaZfEtiiWWkpiuLxLKgsUwtHSDGUKyQ4o9ouSgmBOQV
 NqU6eJ9rpXt7wRex5JMrQf4isNhevpM2pFbk4Rxvs4WAjJ5CmcUbt8C3S8ANCdgZFxRi
 9A74OOebT/e9+E8b/zfTzKXmoNzaQl2VS0Vkmc4ejqlFV7rCkf+2NWSN9pECZsOYNJ4E
 HjezmWk4Wix/KzBW/3VLCk1/xU35PpZVkY/VzD8mafODIJQOWEGhu6jaKcTwXI91u7XH
 5B+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBypswlKPpP6IqVfaaEPwRxHktIv+39D8fC7T/nbj2UOSt7WiP5GLzbhPoBjXDfbCfLp4GSjNPk4LjQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLlPr9Xv3BYuymw6/J236RRuYG1N7SHDd5tDBW3Gzlra8eHDwur
 2RaoGxA5TPeg9PfY4vhGV1813j/uC9PWIuyPnBfJ8fXddLvsFN1H71Lm3JVy5SYGX1DhjbeADEg
 /Yd2dzU8TLiuZR3a/7s8dwAAKEXZOG9VAeS9LR9agxzBedoDT1QaBaQlwFGGXwkOYwX6J17A=
X-Gm-Gg: AYBFou3J+yjFY3wttRie1Q3QfvujDZBTDWpjE2v+pak7aMmzq/hW/CYPQAYMlHf9y3x
 q8KLwU26GmdApMyilPiv9FjyZ74aRz7HcsWRdLrpEpGE/GChV7rry3aj0825WnHgSXNaSvO1ho9
 EpMScB4tja0/++x4+A6BtonN7Lz2oTKmWbHm1J52gmszCuas6zZI+PdC1vu+cnREz1h/5IvvUCt
 DpHRh2euO6vr7BFmRJ2wHoBFI2occbqf/+qZD0H1WKm83HqeeYhHIxhod2o3JmIz7ITdr/RuIuI
 WlFE8Tlad59HL7ks4VJXBObJ8YrCMDAbEuYFxBWxVcOklAYaf5GsfVwy5/YENrSUUir2nBPj8CL
 aWNeaoW6Ud3lgP9b1fpjKs8N2iYQqXh5B7TTgA1hxypNyfxfZmXQxGe8t6rsUK7Ljd1lzR1rNO7
 SKZlP2oDMnSqzn
X-Received: by 2002:a05:6102:354b:b0:7b3:5b2f:7030 with SMTP id
 ada2fe7eead31-7bf80c9bc7fmr2346113137.4.1791170723856; 
 Sun, 04 Oct 2026 20:25:23 -0700 (PDT)
X-Received: by 2002:a05:6102:354b:b0:7b3:5b2f:7030 with SMTP id
 ada2fe7eead31-7bf80c9bc7fmr2346105137.4.1791170723392; 
 Sun, 04 Oct 2026 20:25:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e3235d5sm36670991fa.34.2026.10.04.20.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 20:25:22 -0700 (PDT)
Date: Mon, 5 Oct 2026 06:25:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>,
 Pengyu Luo <mitltlatltl@gmail.com>, Alexander Koskovich <akoskovich@pm.me>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: round up the compressed INTF width
Message-ID: <rcmt7bnqgu2kmwnr6mliytpjscnnknbm4qrfva77abozwwgraz@3r7giwxnzy43>
References: <20261004102758.84436-1-26rote@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004102758.84436-1-26rote@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxMyBTYWx0ZWRfX+agGwT+ztiaT
 Ms/JU3cpZGiG620mDrVN9Txn+TnpDf71nqqxaOYrOHSPKgenAxq+jA3MtDbVdvuhHgFGdr18rSa
 WtHpVGpL8lx2lDIkaGfrbO65Nf9Gd3g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxMyBTYWx0ZWRfXxJ+hkJJiKQS4
 9s375OYY9/Q9T2MTsJvJOhvoiAtL8VoTDnz9fHeQIKMu02I9U514Y3qfQM+/LbRbmfe5J2exYxV
 a46FOO4GCNbABFb1+yubyNWONzHVm3Pg1pdmnd9mGrzdRX+AUa5Z34Div2Y20sQTRraxj/oip87
 CjneLBGiHvOEtXR6YuvH+UQbNQ3IwvNRRqh8MKYwfSIZALemk9bEdqAGLi7vmG3tBKyfbCXDsHH
 thULMaasPK77iAukB/3G4zJrKzBpZQ9p3KD9INa2uC2DGkqwUyV3gMV4THYucq6JZqY3GRJvOd0
 zLgRTpHGCCEsOfgqhOfH8UZ47Rx8P9BFMbBik8Rs1qRFwJZ7y4k8K0593b8605O6PkSMh6nJAg2
 DuDcBss7T6qtbzfRojJFgFn7TDJWHgPYM+AnGDG95gMb3uYqR9pgCPaMPJwqbHRM9z57uBDTDVK
 9DpMtR+MKdfTw27VPVA==
X-Proofpoint-GUID: jU2dIMaWtpSmmoQGVmYiuKak2rO4PeJR
X-Authority-Analysis: v=2.4 cv=HqjjiETS c=1 sm=1 tr=0 ts=6ac318a6 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=q6ksuDL_9lF9NV4zmMMA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: jU2dIMaWtpSmmoQGVmYiuKak2rO4PeJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050013
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

On Sun, Oct 04, 2026 at 07:27:58PM +0900, Joonhoe Kim wrote:
> For DSI with DSC, drm_mode_to_intf_timing_params() scales the INTF
> active width by bpp / (3 * bits_per_component) and rounds down. The DSI
> host computes the same width with DIV_ROUND_UP, both for the pixel clock
> (dsi_adjust_pclk_for_compression()) and for the active width it programs
> (dsi_timing_setup(), from bytes per line). When the division is not
> exact the INTF line is one pclk shorter than the DSI line, and the DSI
> FIFO overflows.
> 
> Example: a bonded DSI video-mode panel, 952 pixels per link, DSC 8 bpp at
> 10 bpc: 952 * 8 / 30 = 253.87, so the INTF uses 253 and the DSI 254.
> 
> Round up, as the DSI host does. Qualcomm's downstream SDE driver also
> rounds this width up, and Pengyu Luo needed the same rounding on the
> Legion Y700 gen 4 [1].
> 
> Tested on a Lenovo Legion Tab Y700 gen 5 (SM8850) with that panel, with a
> module parameter selecting the rounding: rounding down, DPMS off/on gives
> no vblank and 14000-17000 DSI FIFO error interrupts per second
> (dsi_err_worker: status=4); rounding up, the picture comes back and there
> are no errors. Only tested on this device.
> 
> Link: https://lore.kernel.org/all/CAH2e8h6oinKxN1ndcvHCSc+=bFLXVVDZVAVF0cQHoiaMvEwhPQ@mail.gmail.com/ [1]
> Fixes: f9ce482d7dc0 ("drm/msm/dpu: fix video mode DSC for DSI")
> Assisted-by: LLM
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry
