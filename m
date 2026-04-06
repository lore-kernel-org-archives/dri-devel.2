Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2D8F46C44
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0173C10E168;
	Mon,  6 Apr 2026 14:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdgkMWQ5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EEXD2GhB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCCD10E139
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 14:13:04 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636A6D2c913876
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 14:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=beKnurAGjmh8PAnmXnrRZXOK
 +gGp3TW+AG3rkQ9JhPg=; b=HdgkMWQ5HR6r4ZBuJngKf0dnZ4AecP80hzsRzbOo
 tYVOkpSn2HOBtXCi6Wifd8fBHTvMmFSYEc2mTMsCyHCoXcJHwERlHCHH7Ywyr3t4
 nGZlE6aS390bIqmVmWyx9PfvQ7tFWw3ImbGUfieozp1jmNCaRQmCRexuXynswjIf
 o928vL3dR9PpJ82+uQ+MJuqnAbjRrtB6O32ajrPM1EZmNil5aLFz2ho5HjxoMN8A
 DY685cDRPGCi33mcols5PUmbGuj+V2cR8PCM73huh6RNm3zmVAkGPK8QF/ZMpwQg
 l+Oe2J0/YHGJPU7Nq+k/fR0wu+cmRnb++8VxdkklIY4ntg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daudd5b46-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 14:13:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35da09e73d5so1278046a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775484783; x=1776089583;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=beKnurAGjmh8PAnmXnrRZXOK+gGp3TW+AG3rkQ9JhPg=;
 b=EEXD2GhBH8PRubMbLYNCUf4mEwBDZRYX9mUttHVNaYTHtpxySh78LxfNmkCk08A66f
 noGrhiGjjSjGaO+4WksTKIS1gf1IYYvSxXCrqrBrMQBwAysXAH+ICasi2niQeTl/P9/G
 y0aKNwqDugyihg3GcrV/kj7p2Q6VHhIVsyYlzQt8+HHYj7KWrDBaV8OKAPgfOCORvg/f
 UMpm9M+3GnCJ+L51ctDDh7BLmZM6enZfJy55/qSkKKbdOEfllmGnOJeYmrZiKipK2shE
 hBpNsR21GgJXrvgMM1+HSNCJxyO4FGG6B5fNMotUJFr0l/ICA6dpxBsvTBHc5Pe4UPoD
 wDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775484783; x=1776089583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beKnurAGjmh8PAnmXnrRZXOK+gGp3TW+AG3rkQ9JhPg=;
 b=DTdbcU+LUvER/XYuzFbwmDC8flB6O3t97eqTXijSssfziVPy2C0WCf6K7s4r9J5wI9
 HIMA4MULueScvb7S7xWYaSzg98wI8uIGy28MdT/5UtoIKHDbgc77rt4W7LbG8xnxPOJT
 idn9jnMtyVqt4+jDiQJzrfHd9AnRFcZvumxqrxtXFCz2zAFeSk61vctqU1MnjqgM6Xlf
 4ICE7Dc8UEQwMpJfP6wE7RXyNL87Ou6qJPbxjKcxmu0Q97g7jvO26z16Hl5/qfUGiga6
 6tSCRajrnnyH6l5I2WoR9UwoDR+rWYInZBqP22aQt2lYQ6QKmKMdulGgD4zrfRYF7IRd
 09bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpQIjGj0YwRbN4UQ9yvUbO+m2kM+cpcPaqVObuD9784CTcYVCtFbb4KAldOV/4Y2IOzIkJAxWOi2E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7+SKOF+KCVb1+vZ15/h1ZOTXSqOsCOs0NHLa2kUAlH79YXG9E
 j8SIghq9OIJgwP5lonFks+EZm2arrFwuQnp1r7NOwd5c1i/A/FWDrgabTIIAMWTs81w7QpqKfC4
 FDJe7J85FCx8cFZKZ9Ovjku2wK6dVbOo+WsvC7va8C5/odls4VCQnMElUNjAbaAgY+qiXljE=
X-Gm-Gg: AeBDietrs1fxpZvVeL9qaL3QX0WCeMtoIjjJgTcfFlwfAC2QrhOxxoIV/mC0wyetoAc
 evggyGDYop5qUpGpfP3+8LNoOvcCXLtehtwNPH4XPvch0gWqb7gCPp8rD3KIUk4TzbfaFvpXH14
 GX1GLMC/ie2WM3ivmdyI0F8L0eGR+5xcrWYHYxU7RDuJvIX2adX4biNhhnnsNjzxsR3Z+v9K3pC
 hz1jCWmDOfkOLkPcCFuhmn8fNdmuQ+Wui8xYbjFcOrxX2+g2YjG+eT9PUFi9qo+7Xkbw0ZENaov
 amKw/XWjo078Ab6uBMsjn6Ek8fiv1mB6357Vgv5tZBVpjgvtgw0N+wavg7QhMPpWGPPN9rjXxcq
 +SoEYRJpjiuDcSOB37bwV5rtj7adPE94+jX6yvVGzWK4HANm10Czq7KKWiyfvKwB+Hp4sLxnXWo
 JsKixs0gtQtRppXRA3JGnhFaBROK6rtcAH2CsYsEQV2A==
X-Received: by 2002:a17:90b:390a:b0:35b:e4ed:4f60 with SMTP id
 98e67ed59e1d1-35de69a53ffmr7635500a91.5.1775484783351; 
 Mon, 06 Apr 2026 07:13:03 -0700 (PDT)
X-Received: by 2002:a17:90b:390a:b0:35b:e4ed:4f60 with SMTP id
 98e67ed59e1d1-35de69a53ffmr7635477a91.5.1775484782848; 
 Mon, 06 Apr 2026 07:13:02 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe624756sm24171622a91.5.2026.04.06.07.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:13:02 -0700 (PDT)
Date: Mon, 6 Apr 2026 19:42:55 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 prahlad.valluru@oss.qualcomm.com
Subject: Re: [PATCH] drm/msm/disp/dpu: consider SSPP line width during mode
 valid
Message-ID: <adO/Z0mJ5ocI8J1z@hu-vishsain-blr.qualcomm.com>
References: <20260328-msm-next-v1-1-12ac4e27c670@oss.qualcomm.com>
 <v37m6z5le4rk56b7pinr5wbi7l7s2bbgkggglx4eog6w7ja77f@lvyxc5tks2bs>
 <acrBL4fF4aiAw8m9@hu-vishsain-blr.qualcomm.com>
 <c7xvoopmujdmdar4lr5oghcc4olc72fpfrpe6yq7wrmtqaytjg@iweixftggvbg>
 <acrHj02HsaoK5N1b@hu-vishsain-blr.qualcomm.com>
 <sube4fl4iubrutg7wvdqcmdpuvia5bavmc5x5gajrngsrte6fj@nybmbjbcm6ma>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sube4fl4iubrutg7wvdqcmdpuvia5bavmc5x5gajrngsrte6fj@nybmbjbcm6ma>
X-Proofpoint-ORIG-GUID: Y271I0r_eFYftmM4FSEhmCt1Qi4aQnMl
X-Authority-Analysis: v=2.4 cv=JZ2xbEKV c=1 sm=1 tr=0 ts=69d3bf70 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=q32X2GtWTQ-4QQcc0HIA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE0MCBTYWx0ZWRfX5qqdrGeLughq
 GV4/hT3zMhW7/8dyv038KBqJBxQOUkWDwJb1cXfGxhGb4u69ZN6gPx05f7h/SsoISsb5N7bfV4R
 /A0TRuNcF/jI1ohCq4xdM2l/HA6iXKQKy8+0yizD2tQNT3o5Dp14DUfythtEW8giHOA4qdk6JZ6
 Mcn1WHYW9Kt8vkDae0LDQIesdsEGqN9hasQ79F0JW+t6rwBxyHsPjXLa65FSOICfbYJEGQu4nGv
 IzM7Y+aWn+qULU3cIQFoc1kW5IEr+RDgKWz5gKjOjNvQKvb5dShal+AeH4dLIe1JSGEInEBHZg6
 i7DyilTNKmHF/+gtmG5VlmdJT9TwmCIoqXAqdpmtj/0+rd4/zSngpBjn4k05p2BP4F+bGk6dTTv
 iSEIXEHFLyNu6p/mtLLOibVplNobAUVbSsOgkrQvTsHRd7pfIsq014zEIQlIhtWJ8NymNvkmJ6p
 R4/qQst1zHvBMl3T1Cg==
X-Proofpoint-GUID: Y271I0r_eFYftmM4FSEhmCt1Qi4aQnMl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060140
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

On Mon, Mar 30, 2026 at 10:38:15PM +0300, Dmitry Baryshkov wrote:
> On Tue, Mar 31, 2026 at 12:27:19AM +0530, Vishnu Saini wrote:
> > On Mon, Mar 30, 2026 at 09:39:31PM +0300, Dmitry Baryshkov wrote:
> > > On Tue, Mar 31, 2026 at 12:00:07AM +0530, Vishnu Saini wrote:
> > > > On Sun, Mar 29, 2026 at 02:24:53AM +0200, Dmitry Baryshkov wrote:
> > > > > On Sat, Mar 28, 2026 at 10:45:35PM +0530, Vishnu Saini wrote:
> > > > > > Few targets have lesser SSPP line width compared to mixer width,
> > > > > > SSPP line width also needs to be considered during mode valid
> > > > > > to avoid failures during atomic_check.
> > > > > 
> > > > > Technically this is not correct. There is no requirement for the
> > > > > planes to cover the whole CRTC. Nor is there a requirement to use only 2
> > > > > rectangles to cover the screen. As such, it is perfectly fine in
> > > > > mode_valid, if CRTC is wider than 2x max_linewidth. It would be an error
> > > > > if the user tries to stretch 2 rectangles in such a case.
> > > > 
> > > > This is to fix an issue with 5k monitor on rb3gen2, since SSPP maxlinewidth is 2400
> > > > it can't cover the whole 5k buffer in left right split mode.
> > > > Do we need to fix it from drm backend by dividing 5k buffer into 2 planes and 
> > > > use 2 pipes in split mode.
> > > 
> > > Quad pipe is pending for 7.2, most likely. However, I think, instead you
> > > should teach compositor that if the commit fails, it should retry with
> > > the lower resolution (it might require somethi g like -E2BIG from te
> > > commit).
> > Yes, from driver we are returning "-E2BIG" during atomic_check.
> > Thank you for the clarity, will try to fix it from compositor.
> 
> Just to point out: it's not different from the driver not being able to
> perform the atomic commit for any other reason. For example, if card has
> 3 outputs but can support only 2 concurrent outputs, then each connector
> will still have a list of valid modes, but trying to enable outputs on
> all three of them would still fail (or trying to enable high-enough
> resolution on all three, if that removes a possible question of limiting
> number of outputs by other means).

Thanks for pointing this out. Agreed, this is consistent with other atomic
commit failure scenarios caused by resource limits.
The compositor team is looking into this from their end.
 
> >  
> > > > 4 SSPP rects --> 2 LMs --> 3d_mux --> DP
> > > >  
> > > > > > 
> > > > > > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 12 ++++++++----
> > > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > > > 
> > > > > 
> > > > > -- 
> > > > > With best wishes
> > > > > Dmitry
> > > 
> > > -- 
> > > With best wishes
> > > Dmitry
> 
> -- 
> With best wishes
> Dmitry
