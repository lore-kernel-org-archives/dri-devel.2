Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22933CD4F5E
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 12:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB4E10E4BC;
	Thu, 21 May 2026 12:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nzDcIMxy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DbAcYDWB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9688210E47E
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:07:24 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L99nPR3118529
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iaChCRreVrJ74kZNk7MSCJr0
 m9ZSy7dcaCDchcoc19I=; b=nzDcIMxyjJvkmntJZeCUqKK4rGY7v2BWgji395mH
 SOupqFt6B2iOfRz0M2XXB2G8GaXVB7w+Bax4Du746G4jmLWhfGHPdZymhR8TdpLl
 VvFAwKBxi9LSBNkxdDcbaS0crrbgtan9O7vrtO/zikVQ9S8m9NHujQm1fRs+L9UD
 WgdA7rYosaoKPuVGZrCcdr8jDQUadeg2yJluCzuJDpvRoy4+LN5KILpiUqA1nK54
 SKb/VLhe4TVbuPd6tQgOTGFXahcPdORtHqOpKIC/Ueidmguhup7mZPI7cFp+RuSI
 u9f44UU9dNTvgOs84uU8+C4DcUyceK7GPyhdv2HX9Le6oA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9r962ax3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:07:23 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4854350c0afso61182b6e.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779365243; x=1779970043;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iaChCRreVrJ74kZNk7MSCJr0m9ZSy7dcaCDchcoc19I=;
 b=DbAcYDWBZHQz31+0vFMAmUe5URDBrezLmWloguSWnMsOJ4UlKtWU4gWLLuBY34XgpF
 Jdfc936whxcLjtGjOfAibdJgDXaRKWAabTagsaU0TCVujn0fLw+lwuvUdC6uD9dNz5r/
 zMEscwWuCDp+AIeX14vGtT99TXYs2ZsSFH2njg5cPBmUV8PEgP+aA9J/fOThl93kDwYA
 W8ZM9jcdVdUwpdnMpnjIfmOqOLKEPrki27Gssl8Wq3W67mp62ZES6iRZ8UO/GLTbuRVk
 WtRBDesE0Tf4wUwIlhSukenZSdVjD5X4IUE2ceLW4z09LmMKLPAYBX4H+WyWkFQnOpAP
 dl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779365243; x=1779970043;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iaChCRreVrJ74kZNk7MSCJr0m9ZSy7dcaCDchcoc19I=;
 b=Pjqb5I5pJpfbnLzQ4dpOzYYwUeSKrWjjTAYtu2hQBOfV4jejNtLsTYJPhlgYyxYhSE
 F0cwmBGVEYveej/R4vIxPb98OFIFcAdj03m2cgDADl3NaY6feO7sNr8zXfVIdUBIwgMD
 8a9Vbb2YaR44wFPQZ9M7T0ieKkFh7M7fhyQe1i+333vThTLjTdSKxBom4yAv9RBYeYow
 CKAWVuwF12SeFsh+nRxe3RfxH5hrMhoB8iYwC+dYgNWjzlMEbAwx2eij3itbS8+UM5s/
 aPr/ZaP61FXH/lGkQskpistepDlmOHF7vZQUrwrpphUXLAJ+siYOQ+q6YxtlTeMKcBNF
 8cqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2fvi0FQ6zTQAEcmjbvrZzEuIyLgFXBzviXi1AjlZyvYMEt1Vs31Vh08kIMzGT5C5YXH/CJEGEZ/k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwS3pHFNiWapzcXOeSDQugGb3C2Qp5JauI74XgLapz09tB/cJI/
 f0o5L7ZQsaWLCKOP9OT4eaoyT3KR9I97LFUfZI+6VRDS1B91Ss5Fp+eLBcRcmMKn33f4YN1TqE7
 uiIc2FqdMcDAV2Hc7UO1CrySqHtPOPoW36xr5rR9eilPl1kAa8CcpkqeYNQTakeLeZrkKajU=
X-Gm-Gg: Acq92OFrlfHtVqn2X+7GrKp6WD26crw778iOdWXP2xdmjE4UQ0NfkXlUPX5zb05ioxH
 biLumnZQSwScSO9MEKmx5lWOAzpT+71F7hgqcTdHgFFBoTPfPeMDvJ/+wgzRKJtmpRyL0soeTmz
 ouQiKdnDB+TAIK6twvH++jUDNJ03QKTD+WwBL71AdswvZHMN4zkHWOfUgyh9kQRsXPuxPTbY0EX
 hNGbPhtay88qUGZv2WldUqJ36C3LzVOwQtLsTgaXEn6PfbRbsDMPr/KnvGyWjYPJdHl/e04n8Nj
 T/ZhJHxfuCJKJBRwQe1c/k3VHHkn+WmJ2MUxfh3H/0prZEQh8Ziie9qKDn0m8jOQi2+uNH/s7r1
 mEmndXMYvdOSWC9Xq8p0giiD23b0+DZ8rUi2a50voBBmUddQVC6xyxjN4XX8nDI8cLE/J0lNJBY
 GuqR7/ncIRHp1o5AUwdAo/0fUGwELIoBLS3kA=
X-Received: by 2002:a05:6808:e659:b0:482:ce40:abeb with SMTP id
 5614622812f47-4852ec297c0mr916941b6e.7.1779365243005; 
 Thu, 21 May 2026 05:07:23 -0700 (PDT)
X-Received: by 2002:a05:6808:e659:b0:482:ce40:abeb with SMTP id
 5614622812f47-4852ec297c0mr916918b6e.7.1779365242588; 
 Thu, 21 May 2026 05:07:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa2f120b83sm204605e87.32.2026.05.21.05.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 05:07:21 -0700 (PDT)
Date: Thu, 21 May 2026 15:07:19 +0300
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
Subject: Re: [PATCH v4 14/39] drm/msm/dp: introduce max_streams for DP
 controller MST support
Message-ID: <p3jfi2cxevvdtqathqrpnxdkzrwuna3hojovfjvdni7zvjec24@pyvaubeq77qk>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-14-b20518dea8de@oss.qualcomm.com>
 <s32w4u44y4jhuk4c4qxsytat2pdiskzuvbozklhofpjh54r7pc@2i6vvbaen2ur>
 <0e39dd9f-9858-49cb-a052-7d0791b694af@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e39dd9f-9858-49cb-a052-7d0791b694af@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Cd69jTm7XK5yMgJSVAz8LDQMAygb5O6Q
X-Proofpoint-GUID: Cd69jTm7XK5yMgJSVAz8LDQMAygb5O6Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyMSBTYWx0ZWRfX85o1ga78RQ2S
 5vLpucpeNj9nJY5PNlrU1/SSwnYXP+zG9pdxc4ocQybSf5PF0s0H1z4+ZR/DbSraCRjyz9AY10w
 xbREfweBoxyXa+VD1mMqbiFBYLruOhbwHnRyl8kiDVaVHq6noUdvtvsHaWGgpeA/EyFAexE1E9C
 l3zKDNxAlbYjCeC7NeB0bjuJxHoadHyg1FvPf5ZiByDX8TDTTbt+6TqHfGWbywZggAWawoPaqTn
 ALX6yZMLj7IsPi0bBh+S+P5V5IizJSvWFLAOdAHHbynUOqwdX+z3AO3URo14l2mh+OnbYiIwG9c
 JepyRpg79tLi82oiBYPdHqn2me1yJ18m9w8FVZBa3HtpIF0xpSx/ST8wIATIGhLvDcihmRmYch/
 OS/P+Y2oMuydfActgvFQUyMcINUTOFoqVkXcmJU0PXLbdi4oNLj5rLCfHq63WLJAsavbRJuaY3f
 NvCey5sbJA8TakJzTzQ==
X-Authority-Analysis: v=2.4 cv=GqFyPE1C c=1 sm=1 tr=0 ts=6a0ef57b cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=COk6AnOGAAAA:8
 a=u-wEjeJDRpFVrNTbhscA:9 a=CjuIK1q_8ugA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210121
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

On Thu, May 21, 2026 at 07:34:32PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/12/2026 1:59 AM, Dmitry Baryshkov wrote:
> > On Fri, Apr 10, 2026 at 05:33:49PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > @@ -2740,7 +2741,8 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
> > >   	if (rc)
> > >   		return rc;
> > > -	for (i = DP_STREAM_0; i < DP_STREAM_MAX; i++) {
> > > +	ctrl->num_pixel_clks = 0;
> > > +	for (i = DP_STREAM_0; i < max_stream; i++) {
> > 
> > Why? I think the code was fine with getting up to DP_STREAM_MAX clocks.
> Sure.. will change max_stream -> DP_STREAM_MAX next version.
> > In fact, I'd rather use that instead of the hardcoded value for
> > determining how many streams can be there. Think of the old DTs which
> > didn't have extra stream clocks. We still need to support those.
> > 
> The current logic only assigns num streams to dp->max_stream when
> desc->mst_streams == num_pixel_clks, otherwise set to 1 which mean sst.
> I would like to introduce a switch in the driver to control the number of
> streams, rather than having it fully determined by the DTs.

Why?

> Do you think it would be acceptable to use:
> dp->max_stream = min(num_pixel_clks, desc->mst_streams)?

We know that num_pixel_clks <= desc->mst_streams. Otherwise DT is wrong
and should not have been comitted. So, the min(a,b) has a known return
value of num_pixel_clks.

> 
> > >   		ctrl->pixel_clk[i] = devm_clk_get(dev, pixel_clks[i]);
> > >   		if (i == 0 && IS_ERR(ctrl->pixel_clk[i]))

-- 
With best wishes
Dmitry
