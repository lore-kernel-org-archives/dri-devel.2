Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5657CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C8F10EDB4;
	Mon,  5 Oct 2026 15:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vp4wdoGt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B8c2LKnr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 279E510ED97
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 15:24:28 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EP0UX2014398
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 15:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=K+gBuRp8FD/UBbEBBaGmBTx+aseyx2HENXRSUxpGT8M=; b=Vp
 4wdoGtHDDY98/Vd6Qgm8b1obilsjsnu0lnl0hmZd+7svngU1Nc5BVk7Wnc/uCoDg
 0Z6Y49OZyCmYQEBIarpBtD/hYewmD/FokMwtQquc/kIMs8SoUntz97ac9jEpJ6I0
 fxi9jp4yrYRlK2ujvKot/Y6LLkoRoDgpSZcW62BiJa3jbmqjHrnQDlujQtCCf7ho
 FUZR4N30yHYmArdqUY0pwha2tvCP8frLlZnN1PsU58f7Hvox79lvvjNefbHGoctw
 Al3dEUKAvFG/BF8hubF+mpcjMcymtXxBTtTh/lJOz1tVpVro/E+eB5PuEhJOcLL8
 sG5ri/nQVfTvKZBvJrBQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xhs2qcy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 15:24:26 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4c734afb8deso2784631b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 08:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791213866; cv=none;
 d=google.com; s=arc-20260327;
 b=i25uMqFj7qNonsenTLa95D3NR3+u4pqVeSsu0nyLiFklrYOVy9qcZk3KlXAwy89qyx
 Be88Y3DYafFaCIghEvKS70UO2zbJf+KBQdpP31xZ98bWjkn0LxenTfnF5+e21bdftICq
 oN2XxaiBSuccJMWRPjeW+X/CWeavNTodj/Jl4UlHrDAXLT4OB7euzNmcdM/1MxZhQQw7
 iLTY3ifLrecjndRM3OaeOlSHtjqRW8x01ksJqQr9eWSDTYcxuOU+Zr7sndgStdSKQHcD
 HnttASHDjYE61Ink7Pgcjih5RTdxIOPri4XW2ejzeLg76RYcN45f+nOurVcIUOgU9XOQ
 BvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=K+gBuRp8FD/UBbEBBaGmBTx+aseyx2HENXRSUxpGT8M=;
 fh=ttreWeoscXvKxBQME8R8o91uKMYocZAt8yRegHPH6aM=;
 b=WRQBhW34Dwb9M3bKZaQ0WFxLhRoxHYOMMkxO8+Rym7iYkGl3FNssqQeZJjOl0Ulamo
 dZOV99zhHUAZfX8/hG2f5WF45LkU5javKspG3FrTZhycftRRwKtjFd92088SYVATqFwH
 v019nXVXWlBUZTd0wMHwp2wmJN9lyDeKNLZRDe3eK0D2aBrD1Xz8oCzXnsESeV1tPS2l
 dlVDVK0iRS+WlTRsxXiM8EgI2WNDxZbiwE9mY4CpdL33LVk9AzF6mLb7NKXP3jp4Wp7C
 In7JMgeW3Ty+9s4hDrnQzKMIfYBcWaKrTwM7uoD6qJ4R2NZmyYQGy7x/CsQoC3DcxPo9
 QkuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791213866; x=1791818666;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K+gBuRp8FD/UBbEBBaGmBTx+aseyx2HENXRSUxpGT8M=;
 b=B8c2LKnrSFclKeTT0gPH28tRnqj9uEnJdQ8c1A13Ep2F8jQicTiDsjrC1G+T7lkPcB
 XJAObElHkNkJ3bxWcFFo9gDwVsWn+/CW/8s+MOSktMhoJiUCRgKAu+LCE0aEgR9WtnFj
 hPXqktGuJWAbwz2lZ101URy6ei6boW5Qi/dd9NxM1TwviUzn9wcJr71Y/QHNkG3beui8
 6qbqcZz/wCHQ/vvb5ms1Rx8di5v5Q2PIQ4pD5Cl9x9n8lDE4/tdY1AKYP6SfJqs/DD3P
 OYDH4ehniNWKsrAfOKPHctCmbYG1ZA03wKeVwRuPVBLkB9D9k8j+VEUZIGGkT6U8kjvN
 s5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213866; x=1791818666;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K+gBuRp8FD/UBbEBBaGmBTx+aseyx2HENXRSUxpGT8M=;
 b=wK8Zj93zsr9xq8PA+rWIQiLl5ew+3TJ22mbT0b1kaDY+gVZmIPQd5nj6hKTiImV095
 XXd/PKfKBS50NQg8cCW3KAj2z2yAltQEOmz55j6W+9GXyLb3ccTNtgfwx4egT9nsbr/W
 weEFHX3LGwab+9JyUWDRHhwbFQ0uNZ7BQ9rHhVpqD0yqhNRFbwpU5BubTSsPd7QQnXu8
 T9t1sVNdJ8/+vI9h9cYIq0E2l8Pt8oSU0is4bKg1+avkRHNhvcS9h0UdhFMeUhUQod6f
 rnz1JqoWtePVPVKvVB6Axaw44bxwik9HUIRe6V0I1vbQSXsSkCBJKuI8uU1yRi9rYZDJ
 I8og==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZffxH57w/fKixSc/3jvCJXv3rvmmBAapPWwWZU/CDN8ylDGFTyqLZ0AvwkzNxEIwhEaCfKqgfyTo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nIVPTjGNyEZahwf3OEclY5IL7ijyjoPGuEEhQYSJ81XT3BLl7r
 vfTgjSdxngLZ8CPSrZnB5kdtlkv3FcJk3Q1OqHJq+Z0z5OhmpIEfjSXdCloO5YiUgI9O/o+2C2n
 iNfTQUSX5RRERuteBbUGAPUZTpmNsqv0cGelUf09Xuf+++aP14YLGtoMX6XPNCxMV0scdCw8hM/
 XDujSiSpRyifCKvM8dHvwoI8WWPQ106RBAJcqJGTHtau74xQ==
X-Gm-Gg: AYBFou1fVwZSNtXhwQR5wPlGWUFEoJ7PhLLFMmIXIC6pBzo3EVwRilh+FTkiIWbOPos
 j6mljBZTotBn3CELV8tooHIi2WRCXasT66blXI1tcasgH1jQ/YONFs0Jnh5lYlBz95q5YMEKqs/
 CvjYZSknFKogtxnNvVj+epTUAGUQoJfdZN2j68jbmFxbwyh2T9Rb7lWXwm
X-Received: by 2002:a05:6809:2011:20b0:4f8:4ec9:b170 with SMTP id
 5614622812f47-4f84ec9b327mr2603597b6e.2.1791213866058; 
 Mon, 05 Oct 2026 08:24:26 -0700 (PDT)
X-Received: by 2002:a05:6809:2011:20b0:4f8:4ec9:b170 with SMTP id
 5614622812f47-4f84ec9b327mr2603566b6e.2.1791213865417; Mon, 05 Oct 2026
 08:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260904125523.43813-1-roman.demidov.nn@gmail.com>
 <CACSVV02h=c8KQoUT+18uXBoL4nkTzefu6AiTX=y6-W0rUrSSYA@mail.gmail.com>
 <CA+KF4bJSyuhB4OGDU-31riOMZK+4ubtLSPpTf8qgkW3pt6nXrA@mail.gmail.com>
In-Reply-To: <CA+KF4bJSyuhB4OGDU-31riOMZK+4ubtLSPpTf8qgkW3pt6nXrA@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 08:24:13 -0700
X-Gm-Features: AclHuK-mmsEZaxj_x6teheAh1It8QjlccHsJuxFTdfftJBrzQnwwKcoa3Lw1lPo
Message-ID: <CACSVV01JuE85VnNm8rmTo7b2YOCLWZKkW4n3RCXm7P3cY3GO2A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: check pm_runtime_resume_and_get() during
 resume
To: Roman <roman.demidov.nn@gmail.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 7faUVagm2JeWquuWJ3DwYNntfwlcQlGu
X-Proofpoint-GUID: 7faUVagm2JeWquuWJ3DwYNntfwlcQlGu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfXz0AMtRIQjJnO
 ARkX9e57UsdZLVCoxbBj2+7nKC7cthBgqvu2TOsh4WqjK3QZOYBUiP6keO0r0YvOtB+Qm6H+dtf
 khsAfWobR4Y5Y64BXOSHJxF6b2oiZoA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX6fJ7tn6lCgXc
 HHepmLtWpwJhQAwCa7Dkm/c+MYfPCZAsLNLb/wGnKT3nfllP6xHmoQrrtlWm8nWpCP2y9+96Ss8
 vts+LMMUK/XUo141bXuv4EWVyg65F+gzcDOo7jsA/CnxgEm6NRWAvkxc6TLR5/l6NnnOq01TWg8
 eV7rVJc53Sa5o6mxKxW+3YGW6G0kYDCZ3ydhVJF65CMSnwpYeKiCzsj7h/KPhBzKtwLypqBD2Dg
 9ukl5NLDoVFpP80M/SQ8L37C22fWbhA1O5D0HojGGv2Q+PH3WRni5VFVesMAfihfAIF/aEVudX4
 qEab017kpbrq0fWJXIY0LOYInfLdggyfdnoQTvTyfvJIG7Jau+ODz6tpCMvCQ//crR0yvTza6Lk
 DRiYNMZw5FHphl3w4atrIGsneH+R8dgLAnx83FiZ49cf2PCu4y/9RdZJq8XyQoV7WhXadleGyTm
 oT5gJCdicf46Jf5/qWw==
X-Authority-Analysis: v=2.4 cv=Q6tHcI2a c=1 sm=1 tr=0 ts=6ac3c12a cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HH5vDtPzAAAA:8
 a=zCo_tC22IKUfHdO8KQgA:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050060
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Sep 29, 2026 at 2:29=E2=80=AFAM Roman <roman.demidov.nn@gmail.com> =
wrote:
>
> Hi Rob,
>
> Thanks. I did consider guard/cleanup here.
>
> A plain guard(mutex)(&a6xx_gpu->gmu.lock) would remove the manual
> unlock/err_unlock, but it would also keep gmu.lock held until the
> function returns, i.e. across msm_devfreq_resume() and
> a6xx_llc_activate(). The current code drops the lock before those calls,
> and I didn't want to change that as part of this fix.
>
> scoped_guard() can preserve the original lock scope, but the error paths
> still need to unwind the PM refs and clear the OPP in the right order.
> Doing that with labels inside the scoped block and a success label
> outside ends up more convoluted than the current linear unwind. We'd
> still have goto, just with extra nesting/state.
>
> I also considered PM_RUNTIME_ACQUIRE(). The auto-cleanup for
> pm_runtime_put() is nice, but it doesn't remove the goto-based unwind
> for the clk_bulk_prepare_enable() failures. If the GPU clock enable or
> GMU clock enable fails, we still need to unwind the previously enabled
> clocks, clear the OPP, and drop the mutex. So we'd still need a goto.
>
> That said, if you'd prefer I switch the two pm_runtime_resume_and_get()
> calls to PM_RUNTIME_ACQUIRE() and keep the explicit clock/OPP unwind, I
> can send a v2. Or I can respin with guard(mutex) if holding the lock
> across those calls is acceptable.

Ahh, right, holding the lock across devfreq call would be bad.  So
disregard my suggestion, I think it turns into a bit more of a
refactor than what I had in mind.

BR,
-R

> BR,
> Roman
>
> =D1=81=D0=B1, 12 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 04=
:55, Rob Clark <rob.clark@oss.qualcomm.com>:
> >
> > On Fri, Sep 4, 2026 at 5:58=E2=80=AFAM Roman Demidov <roman.demidov.nn@=
gmail.com> wrote:
> > >
> > > The return values of pm_runtime_resume_and_get() calls in a6xx_pm_res=
ume()
> > > are not checked, which can lead to hardware access on suspended devic=
es
> > > and PM reference underflows.
> > >
> > > Fix this by checking the return value of each pm_runtime_resume_and_g=
et()
> > > call and properly unwinding the previously acquired resources on fail=
ure.
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > >
> > > Fixes: 5a903a44a984 ("drm/msm/a6xx: Introduce GMU wrapper support")
> > > Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
> > > ---
> > >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 38 +++++++++++++++----------=
--
> > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/=
msm/adreno/a6xx_gpu.c
> > > index f9de9329dee3..0cf205ea744b 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > @@ -2175,44 +2175,48 @@ static int a6xx_pm_resume(struct msm_gpu *gpu=
)
> > >         opp =3D dev_pm_opp_find_freq_ceil(&gpu->pdev->dev, &freq);
> > >         if (IS_ERR(opp)) {
> > >                 ret =3D PTR_ERR(opp);
> > > -               goto err_set_opp;
> > > +               goto err_unlock;
> > >         }
> > >         dev_pm_opp_put(opp);
> > >
> > >         /* Set the core clock and bus bw, having VDD scaling in mind =
*/
> > >         dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
> > >
> > > -       pm_runtime_resume_and_get(gmu->dev);
> > > -       pm_runtime_resume_and_get(gmu->gxpd);
> > > +       ret =3D pm_runtime_resume_and_get(gmu->dev);
> > > +       if (ret < 0)
> > > +               goto err_opp_clear;
> > > +       ret =3D pm_runtime_resume_and_get(gmu->gxpd);
> > > +       if (ret < 0)
> > > +               goto err_put_dev;
> > >
> > >         ret =3D clk_bulk_prepare_enable(gpu->nr_clocks, gpu->grp_clks=
);
> > >         if (ret)
> > > -               goto err_bulk_clk;
> > > +               goto err_put_gxpd;
> > >
> > >         ret =3D clk_bulk_prepare_enable(gmu->nr_clocks, gmu->clocks);
> > >         if (ret) {
> > >                 clk_bulk_disable_unprepare(gpu->nr_clocks, gpu->grp_c=
lks);
> > > -               goto err_bulk_clk;
> > > +               goto err_put_gxpd;
> > >         }
> > >
> > >         if (adreno_is_a619_holi(adreno_gpu))
> > >                 a6xx_sptprac_enable(gmu);
> > >
> > > -       /* If anything goes south, tear the GPU down piece by piece..=
 */
> > > -       if (ret) {
> > > -err_bulk_clk:
> > > -               pm_runtime_put(gmu->gxpd);
> > > -               pm_runtime_put(gmu->dev);
> > > -               dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
> > > -       }
> > > -err_set_opp:
> > >         mutex_unlock(&a6xx_gpu->gmu.lock);
> > > +       msm_devfreq_resume(gpu);
> > > +       a6xx_llc_activate(a6xx_gpu);
> > >
> > > -       if (!ret) {
> > > -               msm_devfreq_resume(gpu);
> > > -               a6xx_llc_activate(a6xx_gpu);
> > > -       }
> > > +       return 0;
> > >
> > > +       /* If anything goes south, tear the GPU down piece by piece..=
 */
> > > +err_put_gxpd:
> > > +       pm_runtime_put(gmu->gxpd);
> > > +err_put_dev:
> > > +       pm_runtime_put(gmu->dev);
> > > +err_opp_clear:
> > > +       dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
> > > +err_unlock:
> > > +       mutex_unlock(&a6xx_gpu->gmu.lock);
> >
> > this does at least look a bit less terrifying than what came before...
> > but maybe
> >
> >    guard(mutex)(&a6xx_gpu->gmu.lock);
> >
> > to simplify the locking part of this.  And I think at least some of
> > the runpm stuff could also be handled w/ guard/cleanup stuff?
> >
> > BR,
> > -R
> >
> > >         return ret;
> > >  }
> > >
> > > --
> > > 2.53.0
> > >
