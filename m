Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC06F531C1
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E895810E4F2;
	Mon, 13 Apr 2026 18:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nxr7YDE+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iw2XGuCm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A01E10E4F2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:10:57 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DHJgTG2229989
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=thMSOyRCtxX4mnV8s8UastfN
 C+eBisw9LHuDPQy4Nyc=; b=Nxr7YDE+Ulwbsxs0uQJ+5XFCFHQ3rs6D447Ui0he
 QKbSdxMt2HbxlqcqFyVNXKv1cdRJlXe5AjvPaa3qvzOBv3Wyyz5eXJaZFfPxKhIo
 XTOdfMeDJploU2cL4J8PvpeUbbTzPpJKx9XQu2igu5lSzFPLjR9m4Gay+zyDts6g
 th1flOoNgEstnMsA9vem9nKRS36CbA85DsT6PE6JkFkzaqxewn/zKahWRwkdcgtu
 5Kx/4cOfY+LMvgE2CgE1LhX8YoOJ+lzwYkqZaHLefpYEkyGjWEnfHx+cXJ3QpFB6
 ulBzEUNTB2oRatIaHovicUc4itXNbR9YRqMkh6FAinqO1g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dgxt61q4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:10:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4076dc16so104755371cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776103856; x=1776708656;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=thMSOyRCtxX4mnV8s8UastfNC+eBisw9LHuDPQy4Nyc=;
 b=iw2XGuCm1fWeGnAJeM9jltqGljCJyJkGBXWwcaxBwB+lVxaS7lZEBHwQziJDAIeDLP
 GZaKlLMUj1QtZi8p9iaQWff3B3zU604vVmMZzqbKtsPb0Cm1COo9YuTJRYNNk7fHZT/I
 2ma4ybVh6JoMyBdG1N4wCCA7ObCXbBdw06jiKaSU46YUeqV95LYIadMHITqWbtKywWOQ
 e5ZU0zvqpHmlZ0S/cMr3nGfHgQDFS07baCyBIKA182xsD5LpJOln9u9gyw8Y6JeEWVrf
 ztcOiuZ2CbL1F+vIA5CQTEq/M2XTSuIIM2B3stFJD9EUvx/V+sntqEoPeJmVQcHxb7di
 BXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776103856; x=1776708656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=thMSOyRCtxX4mnV8s8UastfNC+eBisw9LHuDPQy4Nyc=;
 b=GTwJ3uekPa7jjvTgHZ7ZhRwqz4xnPYA+3ITpGa5XqNsKgIcfteji+p2qfHSRFZtlTt
 1BVWiEEbhxq4igHOSULVyS8NJFglrkkiPvXF2UqFPl6fhJljKJzonpDOKNqkInRb7EzA
 jrSBruE5hkuX6iZaYJPRAlMxhdIb/TlLTPn9L08KvVVo+r+z72ltmNCNCnEM0KnIEnI+
 Wk6sFjexBZMphk+uNk/ljPqah/enjKjF8nLmwPS5mqkoSif34CfxySlQLDB9fF5bvl47
 FR8dFNO4tITJIHdKRN9D+ywZOW5mIugxrlLoM+pbXpj+b/SDYRbOtN4DSR55vDvt20Kr
 MUbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ++Wm1b7+A3bNhQPJ7Ytn7TVhflcSq8MbhvCeBtEB34Lm53mzi2Efdrym19d2BS278hYH68UAxU9s8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHoFYGM1teTICs2ONygQE7JWS3DXXL0adKheExJWH9O1sQ5nd5
 /Wo60w6dSzRZ3UyUBmHplEPtGTPh0CxIhdUV/8YAuV237vjrXUdg3TiCfQnJqvWOhG8Fc5cMcxi
 jRmRwmFlFIFozzZaRXPxajGRvsM7ie1V+msTpCSIUo6tgCzSjAgQguuVijELRnFmdD7Xy8j0=
X-Gm-Gg: AeBDiesdCGngCk+JY3mAi8gQagMb28i2flyQAUBACYSo3XWz46FT6L6Nvv6lpv1plXn
 Q4zluN5VWVQPs0Q6zi5BmVNy2ukNjENnwqDOxj+PikehIHrXFCg/VgvhsI5yaYxMkLdrVLbPpK+
 15KbFe/IDf89FiIlrdatrR1a/rBeNugYTZlQwYVSyQrmW2bUzBMwaUIR5EO5vixry10N9+F2yUc
 B0O6KZVUoJ8AEx3Kl1wdtZzAfV//+PeRnoEViatfArZ5XXie9YOsOpORDm4sUyTrZZPSYJdCKPz
 pWLYLdc64CjK54WzsSo/Jc9ai9Gel94VMvxMcqkPhAMQ9KD8tElf5IiEA27SxTKc82h7R5HB8YA
 CQh8nKzxQLitbxUeEepOLfTzJxcwtWjf1BXtmrtajJFOnul532Hz2P/14KJV1VH4uW5Y2BZ5Mao
 dfKg9FNjC0QmL4J/+cGYIUjAD6c+gXdjnGyZ0aBax4RyBg+A==
X-Received: by 2002:a05:622a:1f8f:b0:50d:736a:624a with SMTP id
 d75a77b69052e-50dd5b95bafmr242460411cf.1.1776103855751; 
 Mon, 13 Apr 2026 11:10:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1f8f:b0:50d:736a:624a with SMTP id
 d75a77b69052e-50dd5b95bafmr242459651cf.1.1776103855207; 
 Mon, 13 Apr 2026 11:10:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeee12fesm2704689e87.40.2026.04.13.11.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 11:10:54 -0700 (PDT)
Date: Mon, 13 Apr 2026 21:10:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/10] drm/msm/hdmi: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <kie3dnybc3ycjcotnlxdanffv3hr6emaafy3xuhc3x7wsi5s5q@dqvqkm5fidof>
References: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com>
 <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-2-acd01cd79a1f@bootlin.com>
 <t45cmunr6lhxrvqgwa2mrh765zmjjderfpd32islrbg7jey4fq@d5635guivyla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t45cmunr6lhxrvqgwa2mrh765zmjjderfpd32islrbg7jey4fq@d5635guivyla>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE3OSBTYWx0ZWRfX+FM/yD0urQul
 LWtvBSyVlviS/Nh/xfO6uwSQEGSFNVUy9js0lp/oIxenFqKluG76C+1xknVxK4jg1C1SXdrv17p
 h/iUdzObmC594KbZytOYI7i1Q0hDYwMzMhiUlaeDtNTaMJ3dIBssmIHeVaQ4k2M5EMJNlwy1X/F
 E6D+UoIybPtAJYh+MUs/BvXNPB7uHrLBzuNyLdwZJHg2oIRFrKOQPHr5/aEfPavkikohO/giVoE
 pWRn/Zssf/ABGlNert1ew3xn3effpbv9mWqZFnYLY6HbLNQiQRN8MYrMnKyM6srx1+O1X8FFwei
 hUlXO61uk+19oQa3JXSnvbgrQmh+K1u4tReOV2srbHRmVN1sO4hFSlVqJieQ2m+/5g12agmZkqT
 ji8RQQxf4krgnbO5XiDAr1jpDesqcGZVEVz92Ol2tWzbrfuhTXakF8/I4RpORGruqiUEM+MAahR
 TQoOPoBb40bwFloYiwg==
X-Proofpoint-ORIG-GUID: lgrxTDpdJpfxOJngBFLQshQH4ZZ3-vrU
X-Authority-Analysis: v=2.4 cv=br58wkai c=1 sm=1 tr=0 ts=69dd31b0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=Z46hioPf_zsqFS52ZJEA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: lgrxTDpdJpfxOJngBFLQshQH4ZZ3-vrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130179
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

On Mon, Apr 13, 2026 at 08:57:42PM +0300, Dmitry Baryshkov wrote:
> On Mon, Apr 13, 2026 at 03:58:34PM +0200, Luca Ceresoli wrote:
> > This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> > @panel parameter, thus using a reduced feature set of that function.
> > Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> > 
> > Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> > returned bridge, ensure it is put on removal.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> >  drivers/gpu/drm/msm/hdmi/hdmi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> 
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> How common is the probe / remove path? Would it make sense to have a
> devm_ version of the function?

And probably the best way would be to change the driver to allocate the
bridge early and follow the rest of the bridge drivers. I will check it
out and possibly send a patch.


-- 
With best wishes
Dmitry
