Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814A6F53D90
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 19:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E78C910E3DE;
	Mon, 16 Mar 2026 19:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f3FenR7x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ixJA8qsb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B7510E3DE
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 19:54:55 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GECT1G1639392
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 19:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pIDGUC66DjeB5/G8Sh3DXLNt
 596Pz7YBrzXPtS3KZpA=; b=f3FenR7xKGBt7N689oX1FC7QCS3nZKWyany+Ukve
 AhGgqwm9iAgDQemKfXde2XKj4dmel1184ERT0DJphfT5NRqMNwVM113O+oewmBfb
 l7WjLUQxTBYuydQGuiniirF0uwDiy78WWJ/vMQ+bvMy60eo5koNmr9Nj8UWJ1YJ6
 cY2BVEbsBLiLpzgbgPbO+gH0RakTe6GjTAZyKnL4zYxHDeQjaP+GFFRwOjQAe1/S
 auRfD8JKoGljAfRFauPH1duCup4fBX+Jt3rssfxVio3bu3swuUzzt2N14iPhNOcT
 UsFKEZKkbyVsx6MGpXXL0csd8LlSpJGhIjUoJIhY3wAHrw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxke098k7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 19:54:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd98d96382so559201685a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 12:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773690894; x=1774295694;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pIDGUC66DjeB5/G8Sh3DXLNt596Pz7YBrzXPtS3KZpA=;
 b=ixJA8qsbve0tuxeOvNyeyredzy5nHOnZdxsu2YPsh1b5j6j4TCzwk/qe65qP+sFjyp
 sOThT5KrEm054gZpvGmK2qDCrBwAnUz4YFHF+qI8WQDQ3U8+Bnc2iyP3rS0/Yuing9kg
 Xtnd1c9Jod5+Mua5ZDnt9DMcsFOVJlxmA0rZ7bRsoQyp2sMwY2MhMaToMn+T1/ttw4/G
 0dBudhiDfhe1/Yk6JmohoS1MfSa//ZwXLGLWivC8aNe22rq7pg9//zScdZg7LB98wtfE
 diBEOMuRRgGrM++sw189vXDa7tKNr3eByw/auLuTibsMa8ERjXeWpR0S6fvvhZ8eN1Ab
 LxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773690894; x=1774295694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pIDGUC66DjeB5/G8Sh3DXLNt596Pz7YBrzXPtS3KZpA=;
 b=gBeQRM9pERYObRLFeTXPN4sF4VuL5FisW0XX7Nxet/XZQRvHetS13CqOeHyRSbo2JY
 ts1CgbRHEatXQdQ2fN7KC8UHkUR8m9l1+FmiEUvBW6oppy+/wiC8WAxYxoB/qEJLLuqv
 QEW1w96b/exBS3ysf0J+YgN8WBdGDmYVhFzoYZvMcNDmuuMlVrbgGIu0hKFmbyieclBX
 uKEd8acmY8sdKW7I9h5bDqCbgwhNADKF8bxjcvaTfKwn4RWE3q/jPMXy2FZIvRvYmnep
 s6XtUXA6djxhj5kY6UyoUE2vicKuaS8d+qLa4ifH98l3PCzPsSp0yLGSUxBiYtKkwfG2
 zlzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUAsVfrnuWPsMe6GozDvnrL9U3J/u7n0kcmbwCmo2a1hbBJhomGFNcszIHbsK7gQYVubYFjGqAj9I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkNgecEFgrexjb1Ogz+O94oXqkcpf8nRBSIEF9P6Epaz+oXMir
 nIw264IpmyvbAHwoirRXjSSf/C33UbuHVqNUEhiS2KXlSVhsxyLAcdr+m8v+DGyTJ5juA2ZeR6E
 qTx434hfxpTj8fq872CQYHHrY/YBd0PY3I0DsltvvyCbOE2PXSdO5139F8fB6+5EsEPh/UPo=
X-Gm-Gg: ATEYQzz+C9NBChN+l2NVm5vN+Ne5cR+dXZpRtd6AncPhmNortwgeA9HWK54Jn47i6sd
 GXuCy0erBDg+fQiOKUB/Q2+RUCwHfzMoALyO/f2dW4zhyfHyrF7ul1L99ZdXPg1zNInU2/3B3WO
 o+xu69D5iEwTbXXzHDDkJZgOcbwBf8mXdVshYruaP3GxYpC9+K2+4YLw5ODYWzQ1nL+JpIgCNc6
 zblBHBP+AwXIJZX3fUi2VzXNLu/UwOKtm0Thr9DEbGt/v6WGXbUbvtYvRSlHyiSnsOjj0clk987
 3Qr6rNS6IocYxvLNWEFabSL8+yhEzur5Id8FW8pJ+Pr92rWLlUi0iCtpV4rKxnXVad0YmfuwQHZ
 KigPv/Cp9nMwPSpZyHg3/8LblBqZZVMAeXFgFir0Bpp9VSTragpgw5FfudEx4pNZYiFwrD0U6ml
 YtvE7YnEaFTOTtzfCIhHBAu6V4LAYzYIyQrzA=
X-Received: by 2002:a05:620a:31aa:b0:8cd:8e8c:208b with SMTP id
 af79cd13be357-8cdb5b05b6amr1799114385a.38.1773690893997; 
 Mon, 16 Mar 2026 12:54:53 -0700 (PDT)
X-Received: by 2002:a05:620a:31aa:b0:8cd:8e8c:208b with SMTP id
 af79cd13be357-8cdb5b05b6amr1799109585a.38.1773690893417; 
 Mon, 16 Mar 2026 12:54:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156358066sm3681927e87.63.2026.03.16.12.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 12:54:52 -0700 (PDT)
Date: Mon, 16 Mar 2026 21:54:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH v2] drm/msm/disp/dpu: add merge3d support for sc7280
Message-ID: <twm2kcouzbwew4md27f3o36q5odpctlfugmkakxom7b2ittftg@qb7golmack6c>
References: <20260101-4k-v2-1-712ae3c1f816@oss.qualcomm.com>
 <DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.com>
 <tbi5mwg4jt5scvr76lpzpvi5zj3kn3entoorsd4dior4g23czd@xtobadslhfrz>
 <DH437ESQRIAF.2336WF7XZBTI@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DH437ESQRIAF.2336WF7XZBTI@fairphone.com>
X-Proofpoint-ORIG-GUID: oxfHGT3KWTVxBT5JnuDhn0DTlfH4lNrw
X-Authority-Analysis: v=2.4 cv=aue/yCZV c=1 sm=1 tr=0 ts=69b8600f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=xNf9USuDAAAA:8
 a=EUspDBNiAAAA:8 a=PZxLfFMIzHLfKC7kn-cA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1OSBTYWx0ZWRfX0m8PPRwn5ysi
 npRXSy7sKRjOU0LK7qyt0jGqre+Ar1GJAJ0tMBhbMYLzxFA2nh0LgvHvUSPeHYqKJ9guYAF5x2j
 ZUur1zk1OBqSiigoIjqXcdb05KSKdT9X+lYSsEJA0OpDJrsD53TSjAepUgkQnXAdux6slHyMSsG
 2NMhndPRRnmRfCRrfVUxzSTpbdo0oZuNL/j3o0pDbbj3U/+R3Wxdwht2fyo75nn2Y9rgc/GDxmW
 yl8Vxjz18O9lZGUmobfN3Sb0ucdqZiStyXz9ORXQ2yRLMxCZ7i0ZjVDPFxeAnkTSTGHjVVzkFE9
 bzm7zqZCq12/ItmD+wIB+QBrbLL0kDn+rZ8rgLXJFhfCA3VW+2Wq353FlFzK+YWTnun5wNG8Hr8
 ub+VkbizDWrpieZa36XGAlG2m8wc3J1XcmLj7VElfYhYAD5HG/236jbrIwXofqJGd4pwEcUgOc8
 cd60OsbK+0Vo88Gn6ag==
X-Proofpoint-GUID: oxfHGT3KWTVxBT5JnuDhn0DTlfH4lNrw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160159
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

On Mon, Mar 16, 2026 at 10:08:47AM +0100, Luca Weiss wrote:
> Hi Dmitry,
> 
> On Fri Mar 13, 2026 at 6:14 PM CET, Dmitry Baryshkov wrote:
> > On Fri, Mar 13, 2026 at 09:33:18AM +0100, Luca Weiss wrote:
> >> Hi Mahadevan,
> >> 
> >> On Thu Jan 1, 2026 at 6:04 AM CET, Mahadevan P wrote:
> >> > On SC7280 targets, display modes with a width greater than the
> >> > max_mixer_width (2400) are rejected during mode validation when
> >> > merge3d is disabled. This limitation exists because, without a
> >> > 3D merge block, two layer mixers cannot be combined(non-DSC interface),
> >> > preventing large layers from being split across mixers. As a result,
> >> > higher resolution modes cannot be supported.
> >> >
> >> > Enable merge3d support on SC7280 to allow combining streams from
> >> > two layer mixers into a single non-DSC interface. This capability
> >> > removes the width restriction and enables buffer sizes beyond the
> >> > 2400-pixel limit.
> >> >
> >> > Fixes: 591e34a091d1 ("drm/msm/disp/dpu1: add support for display for SC7280 target")
> >> > Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> >> 
> >> This patch is causing display regression on QCM6490 fairphone-fp5.
> >> 
> >> With this patch in 7.0-rc3 (or 6.18.16) there's just pink noise on the
> >> screen. When reverting this patch everything becomes working again.
> >> 
> >> See also https://salsa.debian.org/Mobian-team/devices/kernels/qcom-linux/-/issues/41
> >> 
> >> @Dmitry: Can we revert this for later 7.0-rc, in case it's not fixed
> >> quickly?
> >
> > Could you please provide the resource allocation parts of
> > debugfs/dri/0/state for both working and non-working cases?
> 
> Broken (with the patch)

> resource mapping:
>         pingpong=# # 68 68 - - - - - - - - - 
>         mixer=# - 68 68 - - - - 
>         ctl=68 # # # - - - - 
>         dspp=# - - - - - - - 
>         dsc=68 - - - - - - - 
>         cdm=# 
>         sspp=# - - - - - - - # # # - - - - - 
>         cwb=- - - - 

I see. It tries to use two mixers with a single DSC. What about someting
as simple as:

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 0f4921b1a892..cbb7caa194c1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1410,7 +1410,8 @@ static struct msm_display_topology dpu_crtc_get_topology(
 		topology.num_lm = 2;
 	else if (topology.num_dsc == 2)
 		topology.num_lm = 2;
-	else if (dpu_kms->catalog->caps->has_3d_merge)
+	else if (dpu_kms->catalog->caps->has_3d_merge &&
+		 topology.num_dsc == 0)
 		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
 	else
 		topology.num_lm = 1;


-- 
With best wishes
Dmitry
