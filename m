Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40164FB3D03
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1BFB10E453;
	Mon, 30 Mar 2026 10:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/7ivxdi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UJI+sasF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6948B10E453
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:35:40 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U78VSF4162066
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=LF5RL0x0hzV9Gp5KGKo//rmB
 +Sfg+4q53JxDb2IIUYo=; b=O/7ivxdi/0oZotB2CO40NR7Xpp8mJVl4EstodScX
 4d8KobJBJdMfX33NUObS0l6oXslWY1eCTTsZYFHgT5ps2WGp6NR16JxpVoEqeGOG
 wi/WBxE5V0SXKmXXcDjZvpImjPPlYWPIslOMsTVpofwbzyq9AEld1KEf1Nm844NB
 gGE4wd4JhomCogBpn7JhHQ9E5A3WqAh1X2gXqL5ZSMfk41B5o8yDT56pX8UWEEUI
 febNNgylw025+vJkY86fZIc86/JwTLiKuqfgjvEFJ0JPDGG5NkCVJpnEvWXmf5bk
 qysKmJnf24VLGDPT062VCZFbupBIeXckehENJZqnKbJMdw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7mhartr7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:35:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b323c43fdso4425911cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774866938; x=1775471738;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LF5RL0x0hzV9Gp5KGKo//rmB+Sfg+4q53JxDb2IIUYo=;
 b=UJI+sasF9tu30ftrZaWaYHlFHSivlDhJxxqtVX8qRValV97L2nqrdJU9sYyyeNsZD8
 K4JNFX4PaHyV/C29BJvkh1OIsip9wuDBJvhEfKsNCDIerSgu32aq9GCQ5VS4TWikxeqY
 e0F3O+dBMSLL1hxZeOGvOOyt3ukUVBtvrMtHdHuL0S67Z4xuCLKNFIVuld3Czb2J+/+D
 zewHYm4oS4RVjcix/XVRcPeU/F3x+2hXIPAGvomqEjSmT3Gifyjslsnd8x0GpY7vnUDy
 uNoW83GgCwI3UJeTUBhq5f3XpDBdlnPgtVEEnfdlchbwzua1K7a+669WUkmRUJY3LZLr
 qJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774866938; x=1775471738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LF5RL0x0hzV9Gp5KGKo//rmB+Sfg+4q53JxDb2IIUYo=;
 b=RkDquCxG6lcfBA41u4cpAdFUIa+/da2DJVzE2EXcmf+b4NMd4RrGWEDgAjU51TZaa/
 2cnQVoPmJduiPT/mt/QR9HCJGvAmgvMXK33og5HOOzc/S/ayzH3ZbtOu8MTnkMR7GqJH
 JSJi8Dw/OMhM2H6Lj1QWrm73xsJaSLiNSu6t52XMJuLhAKfKKex8C+epmcArMmD7h3Px
 4riX9HyszkBd5ZaX28pVwpFsg+6+kUhoxUcdSb03dQz+hh9UoM4eiOmUyvYDwMv7bcWQ
 fh2ceD5rguFnPKNBlRMi+BnYng3q84IulQJnznJX5LEN6hnCAhPUiEdB4csPPXeVjO+u
 wBdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkEoOyMKBdN0iVCH74Rfk7kH03q9O9cWTCERPSo+OWMvfupECuOWG9VwTmmOy+fIzyQZEfxeRfpRU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWSwEJhwFWtEZ360YGUjR6O+6flUGFJgj0xMIS4nukmqYpU09L
 tuKO5nQwkzqlO61hqmYiSpn2vWM5WBZwf1efe7vzqXYjNm0j7TDReiwotGlQCIlTw2UWcfXiGaq
 cnECugQzpiVV8ASI/SEBYB475oB19yiRwSKvt/y0fikd5rntCkzCpkmeIhL3a1cMD1Fby804=
X-Gm-Gg: ATEYQzw6LQPs9/mC+A+1MhnVIYGNX4rJOO8VTpRYKi93fB6vzj/NZ3UcLU+UrPimqrN
 DN4EC1TQ7zRvRB16mPku5OQVX67yCLnjoToquG2eKfB0QRLsOUUzGkqwWlSvNdz89q3lITQ2FaH
 eaELJmnzHIN7RjZeZxB9s4NqF6WFZ9V0immE3W5CRqvdRBS9ppbPhJb0mos6tBtwpbUAyEpJiEW
 1XrfYDC/2qDhD249PVkogRSnWBy6h9vJBosilmbmsgdk9ht3oauHh70ePIvD8cwVAxGkBDZ6fo8
 yAlelRxctTRFXGpqRk5L7fNUCMfj8vrSCMVf9/D3LECKl28RjjSvSRaaxI8SNwDiyMxWrIgN93Z
 wDPswDjMp7UDM2tsUmCFMAcUjYQxz16GqUTkNBJdgXyt3VIRXCvmv38bEnlK5lte9nt/N8AA5mC
 pijMuX9SdnkkI+gM1mIyS5l0TxcRuVOg0lq4o=
X-Received: by 2002:a05:622a:581a:b0:50b:29f0:299c with SMTP id
 d75a77b69052e-50ba393eaa2mr175866281cf.60.1774866938462; 
 Mon, 30 Mar 2026 03:35:38 -0700 (PDT)
X-Received: by 2002:a05:622a:581a:b0:50b:29f0:299c with SMTP id
 d75a77b69052e-50ba393eaa2mr175865891cf.60.1774866937927; 
 Mon, 30 Mar 2026 03:35:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837349dfsm14156801fa.17.2026.03.30.03.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 03:35:36 -0700 (PDT)
Date: Mon, 30 Mar 2026 13:35:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 12/38] drm/msm/dp: introduce max_streams for DP
 controller MST support
Message-ID: <ex5zvncmnt5pmb5j2utolgbw3yewj4x4e6nu7sdrgzm7ubasmi@2jdubbxuckwd>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-12-01faacfcdedd@oss.qualcomm.com>
 <ltlmp5ytl2f7no7aqq7sl54pwd4f53fuema23xnuwu5uthhbg3@7wamwvv22nle>
 <c71ea478-ed93-4f10-aba2-023180c2ed42@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c71ea478-ed93-4f10-aba2-023180c2ed42@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4MyBTYWx0ZWRfX4QZL+y6gX6zU
 Xv+7jh3MB1JPUa7gRyzTk6DiJ020mGZj1U/G6KO/ruzXEX9ClN3q5WlNht2sJubQx2Q2Fw9zTbR
 8L8S8rQU7VM81uy2WGmlq9cSKbFKrbSrS3sIFv/33SgoCe71WpAsJs7xTkygSrjrhQKCh8Uiwu7
 JuW5ehhGTOSpNq9J7I7LYzFy6wj6r9AIstxOaFMokLSASO+wsOkhJBIwbSR6T2JG/7ENFT6cKWJ
 lx4Ae2jBEt4WJvTojOb0ZcxIoXf1o8b8TQ4UF8cbtyolv6OJScwVc8g2pRpCnLkousf3DjpAPMX
 QjpjXw8m1aJ2dZop5GkgkoO/3Us3jqZl+HP8/mPuGy7uhaggXmbbGjw/g8pItK3sVhwsOPS1o/p
 ek6cLl+svAlJwZvq36M1dgjIRIU/KXxXobR8mH4Oyy7YFaDqEna4EE1DmcpKLj3CoGKmL0fFqqC
 ywzK9lGeY/JKddh1oog==
X-Authority-Analysis: v=2.4 cv=Fbw6BZ+6 c=1 sm=1 tr=0 ts=69ca51fb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=3x_SqFvT9Ql7C9IDPiAA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UGFGhtaL_16lNUeZCD22kNosED__KVRS
X-Proofpoint-GUID: UGFGhtaL_16lNUeZCD22kNosED__KVRS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300083
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

On Mon, Mar 30, 2026 at 05:57:13PM +0800, Yongxing Mou wrote:
> 
> 
> On 8/26/2025 1:42 AM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:15:58PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Introduce the `mst_streams` field in each DP controller descriptor to
> > > specify the number of supported MST streams. Most platforms support 2 or
> > > 4 MST streams, while platforms without MST support default to a single
> > > stream (`DEFAULT_STREAM_COUNT = 1`).
> > > 
> > > This change also accounts for platforms with asymmetric stream support,
> > > e.g., DP0 supporting 4 streams and DP1 supporting 2.
> > 
> > How?
> > 
> Each DP controller have it own msm_dp_desc ...

Why do you need to mention it?

> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 21 +++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
> > >   2 files changed, 22 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 78d932bceb581ee54116926506b1025bd159108f..a8477a0a180137f15cbb1401c3964636aa32626c 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -33,6 +33,7 @@ module_param(psr_enabled, bool, 0);
> > >   MODULE_PARM_DESC(psr_enabled, "enable PSR for eDP and DP displays");
> > >   #define HPD_STRING_SIZE 30
> > > +#define DEFAULT_STREAM_COUNT 1
> > >   enum {
> > >   	ISR_DISCONNECTED,
> > > @@ -52,6 +53,7 @@ struct msm_dp_display_private {
> > >   	bool core_initialized;
> > >   	bool phy_initialized;
> > >   	bool audio_supported;
> > > +	bool mst_supported;
> > 
> > Why do we need the separate boot field here? Isn't it enough to check the max_stream?
> > 
> If remove mst_supported, condition "mst_streams > 1" will appear in multiple
> places.

And so what? If you want, extract the function, but don't add
duplicating data.

> > >   	struct drm_device *drm_dev;

-- 
With best wishes
Dmitry
