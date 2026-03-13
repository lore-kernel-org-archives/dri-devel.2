Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A750107BCD0
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 17:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B6510E0A0;
	Fri, 13 Mar 2026 17:14:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QLXFsAD2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jBVq2cF5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF2210EC5C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 17:14:19 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DAmsIb2390601
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 17:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ftmGZg82HsvVE5aL4YKHhM6r
 iSgn0jTKomy1uoJs+Hg=; b=QLXFsAD2H7ZX6fLnJf0+EpaoSLC6q0bnNyo2aQPY
 6lzVMFg3UlUMFL5IhKLZNE2/Ki377wMU7wPGpP/OFBHqUO+sZgr2ZGn3AwohP8PF
 9wMmDKmrz4O/tz4RNlilIFjDqFFzE+taxTsVN4C7AtnpheIK2/LiMDlVYvnW0wCb
 rh7JKFIcigKkUunUG/PwwvHHDmEfqKQW4Z+ruSf9f7FcO8RKxr7RILqUf+a+h6KJ
 gI3L3TBDnzkGODia/VGbexez9AC3R019Ia4OBad+Coy8j/MuLX6oaq60jOOjKtn0
 eQkj/fRCqXSFDpCoIV7uvwNJaEie/UQZF8XVDS54wR+Rtw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh5m99kd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 17:14:17 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-948df60cec6so4343599241.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773422057; x=1774026857;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ftmGZg82HsvVE5aL4YKHhM6riSgn0jTKomy1uoJs+Hg=;
 b=jBVq2cF5OLUaPFoFJ9dGFKaND9bti2VcTmwc4qtzRnqpdroFenMX5ZIbX8Mdf4MJSy
 ADu8aOF1ZeJRa1081/lOFj3rmKv9Qxtes4J30xSPC4VUmoPyVQ4alotYEX5U/6D2cS6e
 dtbKaCwT8fc1D9kdAanIKPAIYLHpbL2UO+6PVN9uQnGp2YAh1VyaLEXNtbrgoqNbR6BV
 FEOJiTTu/YwM81g7BXXMVANlEjLmMVZBRY2EdMVX2y+mMKGJUEc2ZB/9/FdFBqafdS13
 Rq5IjHkMorCwbnQEGKtbE30YH4/GY2F00qty7yU1A8dSoyI6za0PbXef3zH8HEFrfmUO
 BgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773422057; x=1774026857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftmGZg82HsvVE5aL4YKHhM6riSgn0jTKomy1uoJs+Hg=;
 b=jqvqin7qz03R3kdRWgVsa/M+vj1whllxLwV+ID+MR991zOkeruaNiCIpLo/F6BQlan
 7om1ANtb2qcA/fRpsyh9PjozMjauFZoe+AQOZhZwFL1lXVjRzJPf28wLa4YavtL9KUwL
 i79pmTmaSkcEnevN4sfcZYEh2A6UcRPWYsn6KRsO9NQgW2hF+TIuBavd2srgFKgOwHyl
 q4FZbabQLYU4iIPDGu8096JdCvfxdwR81pE6bCDLWcXqVPrQ6nVfO8LUG+AxO4dwTGnG
 cB8SWI9AW5QpIXh3L/4pJjqk10nUNOMbRMUq6uC8HB6tzIzDiSqmWXglYjteLDI65uwh
 Rkjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSmtKUZRj+6oDN2dA3TDHc2ta5NVUGmAQcBlCuAD0yLhWE7Wg1GWRvVqep34HGgJQVSaFDeibZbNc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbzqGb1WrPmMlEYJ6zny2qCnK7lOO0E9LSYtgl1MDrQhActvdk
 S88zDlqWgK9kqoDV4G2bYh6WnFRDmfNbmnHoBtCPIjjqCPVIxS6sRrDRWQwlDAKw78qIT+49cbq
 pBxE7vAN5UA7fIJq97ytdhhucCGLVoAHm6nX/fgTrN4VFBQe46f0bLMk78fZ3MFvm0Wd4iHI=
X-Gm-Gg: ATEYQzzcsxPaB+f20vBVjS51SyPo9TT6u1FvH6YJ+OTCMTjQRuWNGgXXaA4Fq391TKt
 tZQzORaUlGgzZ37Lo5ABcH1Vo/Spytq/JhjKPLAnA6TsjVPXsrC5wf5aooDNRwe48hSoV8lwYNM
 OAP35G0/c0Lt0hlyR3ipwYRqBsId6voGpkLl5sAmW9ne7+jubSJN7xJZPEBs+1va19d9SwoqzOa
 JQO42mZ46HA4myhapUe6UNIGI6iSnnBJH8USA5Kfx3hyjTBOR0H9W96+0OFG7leHSzAFfdkt8eY
 rl/9olX3tmvTect8iAP8m22aCKwbZ9PctfR1BY42YotSyxBwgeaOUksn/AGAD1nDT3k24cIqjDA
 RTXvgAEKrlSQddcIb5rNtSZtJbeYVgsWzfYXPKimznmT9XN4irRqaq2VokTEjrPIbbz5aLSDjeQ
 dP+AvTjSGpswCDrkxmeXXO4vQyo6KsaJz5ccU=
X-Received: by 2002:a05:6102:304c:b0:5e5:66c6:d23e with SMTP id
 ada2fe7eead31-6020e1aa78bmr1714988137.1.1773422057420; 
 Fri, 13 Mar 2026 10:14:17 -0700 (PDT)
X-Received: by 2002:a05:6102:304c:b0:5e5:66c6:d23e with SMTP id
 ada2fe7eead31-6020e1aa78bmr1714980137.1.1773422056967; 
 Fri, 13 Mar 2026 10:14:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38a67dbc223sm16625041fa.19.2026.03.13.10.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 10:14:15 -0700 (PDT)
Date: Fri, 13 Mar 2026 19:14:14 +0200
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
Message-ID: <tbi5mwg4jt5scvr76lpzpvi5zj3kn3entoorsd4dior4g23czd@xtobadslhfrz>
References: <20260101-4k-v2-1-712ae3c1f816@oss.qualcomm.com>
 <DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.com>
X-Proofpoint-ORIG-GUID: cm11Kwpq8RwKItSPtn-P4yBM5oWQ3H90
X-Proofpoint-GUID: cm11Kwpq8RwKItSPtn-P4yBM5oWQ3H90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzOCBTYWx0ZWRfXw+DQqH0vI99S
 8mkVToczxNvpXT+qanndDnj4XCwCEp6KHAY+Q+ZmgWf4RsBYlE8bM0fDqSV1lG3+fE6GWDs0n4E
 N0NCq/JfmUl496nXAeX3jw8RsY/K0opCi5eqPbxG1Dz0H4kVQUIm51/Z6zWDCIcy5Jt0VHGwPgV
 D1YYkQWAYAft1kwjUA50WRxhcEaZu26Ix0fg/VeXREyNyrKe0bvsDnAYzzNoMtKJKKXrPKYT9iN
 VF5cVv6BzA9J3jtGjxj49nyYlbhTWiIxLdIhCO+beLdyuDDQa735EzMLXea1FCUwn/1dQNpLXFC
 KlLH96hk3FvitzsYmBCDetDo8JTSEcOYnKaxMcCzSamf1Turi052+pd59ZCQN9Fmrjk0zUtkaSn
 inobW4POLVud3uV/EBkJ5uHP/KVm0uC2yUt/dgGoC+3T8tAzqFq/5G2GBHEtTlLzF04imi6y180
 DL9cJmVvxnRQ1pq7C4g==
X-Authority-Analysis: v=2.4 cv=S6TUAYsP c=1 sm=1 tr=0 ts=69b445ea cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=xNf9USuDAAAA:8
 a=EUspDBNiAAAA:8 a=GhyGFkOBsQlZH4ZKdbYA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130138
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

On Fri, Mar 13, 2026 at 09:33:18AM +0100, Luca Weiss wrote:
> Hi Mahadevan,
> 
> On Thu Jan 1, 2026 at 6:04 AM CET, Mahadevan P wrote:
> > On SC7280 targets, display modes with a width greater than the
> > max_mixer_width (2400) are rejected during mode validation when
> > merge3d is disabled. This limitation exists because, without a
> > 3D merge block, two layer mixers cannot be combined(non-DSC interface),
> > preventing large layers from being split across mixers. As a result,
> > higher resolution modes cannot be supported.
> >
> > Enable merge3d support on SC7280 to allow combining streams from
> > two layer mixers into a single non-DSC interface. This capability
> > removes the width restriction and enables buffer sizes beyond the
> > 2400-pixel limit.
> >
> > Fixes: 591e34a091d1 ("drm/msm/disp/dpu1: add support for display for SC7280 target")
> > Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> This patch is causing display regression on QCM6490 fairphone-fp5.
> 
> With this patch in 7.0-rc3 (or 6.18.16) there's just pink noise on the
> screen. When reverting this patch everything becomes working again.
> 
> See also https://salsa.debian.org/Mobian-team/devices/kernels/qcom-linux/-/issues/41
> 
> @Dmitry: Can we revert this for later 7.0-rc, in case it's not fixed
> quickly?

Could you please provide the resource allocation parts of
debugfs/dri/0/state for both working and non-working cases?

> 
> Regards
> Luca
> 
> #regzbot introduced: 2892de3f4f985fa779c330468e2f341fdb762ccd
> 

-- 
With best wishes
Dmitry
