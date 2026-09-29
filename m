Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6E0CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D6710E8EE;
	Tue, 29 Sep 2026 09:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MVfSYQkg";
	dkim-atps=neutral
Received: from mail-lr2-f11.google.com (mail-lr2-f11.google.com
 [74.125.230.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E3510E131
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 09:29:58 +0000 (UTC)
Received: by mail-lr2-f11.google.com with SMTP id
 38308e7fff4ca-3a5b0adf48fso19376931fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 02:29:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790674196; cv=none;
 d=google.com; s=arc-20260327;
 b=ZvD7bC/daxEOFfMk6ceUSyb/lS0dOfijfBJcMsWqCWwSPJuk4g7sVusKJ4Rtw7WNgm
 cuu3rXvHLKphj07bgDb4EVi6lFA2VxzafwCneGjBlTvOrWAwYUI6NgN8Sw9c3YPd7vpk
 l8lfJ9JviJ31KfPC/TYH31S3qyOKTk4cdEpMtqFH72x+eNzyP25kJopu3EgmmUyRnMce
 7MjMC2VZodrFaaUYCWAbkdP5NJyu/d8c/Qt9naSpFv1qt3dWQhBuO4hFN66GbuZVgxgB
 5KsgJvRqjwHYAAirRl8sBHyV0ONnCoDrnGThzK2vpKAxma8P5sSFu1T7WnDs0J/2SzqP
 RDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JhSt9RrDgclo++iTfJ1ToFjlbT6uO7QVlIXjkP8IcNI=;
 fh=cvE6mBh/YV+1CQRjUW/2SrkGMQ6MT5EAy5HEU3BqnUs=;
 b=gPjv0QOGMK7FsJpbNjh0CSjNBh6b7C0Apw5pS80pb0wJ78NSIkEDf3SNDl3kdFdnop
 FPRSeF9X+sNw2ajIykX38f9CUBVLl02PdBXvpU+beeca6hO85sn23FTb/2BQMIMOLCrK
 Yk8/tewW2R5AzYjUOb1s6dq3GpEtdKzEJh+oF3K+7IR1nf6++rKUewRapgmSrIYtrg+o
 Ps1ArHikPFTI3AunX5FDSxJYLVB2KPs0CvoUQwwz1HEUcU4tBa8T23QcNyVPgzdmT9Hb
 4cJodRsBLw+FBUpvpAxs8V3R3M6GmCwvJoPKavPGHWn77SuDaGJC8FXk/dQwsoi11oSx
 EUGA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790674196; x=1791278996; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JhSt9RrDgclo++iTfJ1ToFjlbT6uO7QVlIXjkP8IcNI=;
 b=MVfSYQkgEA5HG85CpHsslH+hH4w6i4Hzug5c2b6OEUVnzp/nKtSi2IIC5qdGs+gffG
 4EByxr8YQArqLypvqEAQnthWJiRbmWHYK7InQR3iGS0+H5ueg/azL6W9O+ICqRCv9UoA
 2YBh8GNuBaMqxPzqblg70ofjR1DfuZW+6cXt9egpjLHmVxkfjEoZwaqniAFlZDt5zWc/
 6eT2jK5I+4SYopWCQeUTzPhMxKjNkkI2eNLskFdb8PlsfDAbGh5teTGo31zeeF3ofYEF
 aozhe50UEuQej73i/FGukUF5qLbWiv/8K22pAyvcVNRpgXMtUTJd6AUdi4y281MCADmr
 TFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790674196; x=1791278996;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JhSt9RrDgclo++iTfJ1ToFjlbT6uO7QVlIXjkP8IcNI=;
 b=Cjqh2kV0CWuz0PXAaakOADzcoNSIBp98UaeUqPxqm1DReOScEYNk2O/T9I7fupww1D
 3WDQtsfVHGGoXsiPUxa0469gKdNzabBIsb1/ciQJ3Y45+ECcCNqT8Q7mV809q/rjeIv4
 b3gIDxGPbcvBxHOmXo/VZGs15zv6oG/D9EU1ikTKaKUK7VaEs5R5a+bnRodPLOwgiQiZ
 SBagKgVt+qyum16L9joRSrMu/FP2ZeYkPuJamSHJsGMkD6ZJxWxPdfBnH7GRFnO9IcsR
 DFjvUslHXtsCCebH/aUUmEl8P72mGT3KUXubdtvBgtrhzYqhSqioX0wNOsYYvCjJ8Aiq
 KFZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRvFwK8oAn/6VaTBj9V1V6WwS1rAGFD8PH7HNPfurO6ZpSSPj9A3fLkIA1Lv85Klki2awC7ASu4o0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKjJUF2FG6p0P+ara+D5NJE8JewjkLtrzvoYD5sCEpIAjT21Qyd
 nNseUsQOJBIDpv1huPBO/BAfmUkBUgyiN5KQ9BrCnS63B2R6UYlyjo9HvWO5fF92eoNBrJOwFTE
 +3S66gPnqVbzCRwiZsZzcGCXseHbeZ7U=
X-Gm-Gg: AYBFou2DBN6QKCLg9ui3qLaUI/PG5MT3BM8i+YGGX9Qf/oh0XSLSJQrLEX2d4ni8fPU
 xzMuYFKKaBZOTSCjJJRa2QPV1n9DnJeuMDFRHyQwTnF7Qvpp2WvZoAuvDuML2La8f0mdxEu5WT7
 xc+VkFCdZssPDV6WotnpgU7ClJ8gmGEBOS90ltNfvLB7wHbDobH/u+6ZxHrGnUWtWUYAsLK8Htq
 5oLmLBvh+8oM04cdJRWYNvJT3yL29nxP84tQlF5GpdN5ntc35M9XpgRgzbN/g0v25c3rw4qR6e0
 pU2w8SWw+UKgifSpkegpcZKXa2mRJ4zIdOxZrh++KHR73K2BrRpR
X-Received: by 2002:a05:651c:b22:b0:3a6:6831:6e28 with SMTP id
 38308e7fff4ca-3a66831753emr17447411fa.6.1790674195948; Tue, 29 Sep 2026
 02:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260904125523.43813-1-roman.demidov.nn@gmail.com>
 <CACSVV02h=c8KQoUT+18uXBoL4nkTzefu6AiTX=y6-W0rUrSSYA@mail.gmail.com>
In-Reply-To: <CACSVV02h=c8KQoUT+18uXBoL4nkTzefu6AiTX=y6-W0rUrSSYA@mail.gmail.com>
From: Roman <roman.demidov.nn@gmail.com>
Date: Tue, 29 Sep 2026 12:29:44 +0300
X-Gm-Features: AclHuK8WiNHB93l-tibJnv-74UuqCfijjfNU3TD0Xmz7yFxr3JF9kKuc8tDTO8s
Message-ID: <CA+KF4bJSyuhB4OGDU-31riOMZK+4ubtLSPpTf8qgkW3pt6nXrA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: check pm_runtime_resume_and_get() during
 resume
To: rob.clark@oss.qualcomm.com
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Rob,

Thanks. I did consider guard/cleanup here.

A plain guard(mutex)(&a6xx_gpu->gmu.lock) would remove the manual
unlock/err_unlock, but it would also keep gmu.lock held until the
function returns, i.e. across msm_devfreq_resume() and
a6xx_llc_activate(). The current code drops the lock before those calls,
and I didn't want to change that as part of this fix.

scoped_guard() can preserve the original lock scope, but the error paths
still need to unwind the PM refs and clear the OPP in the right order.
Doing that with labels inside the scoped block and a success label
outside ends up more convoluted than the current linear unwind. We'd
still have goto, just with extra nesting/state.

I also considered PM_RUNTIME_ACQUIRE(). The auto-cleanup for
pm_runtime_put() is nice, but it doesn't remove the goto-based unwind
for the clk_bulk_prepare_enable() failures. If the GPU clock enable or
GMU clock enable fails, we still need to unwind the previously enabled
clocks, clear the OPP, and drop the mutex. So we'd still need a goto.

That said, if you'd prefer I switch the two pm_runtime_resume_and_get()
calls to PM_RUNTIME_ACQUIRE() and keep the explicit clock/OPP unwind, I
can send a v2. Or I can respin with guard(mutex) if holding the lock
across those calls is acceptable.

BR,
Roman

=D1=81=D0=B1, 12 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 04:5=
5, Rob Clark <rob.clark@oss.qualcomm.com>:
>
> On Fri, Sep 4, 2026 at 5:58=E2=80=AFAM Roman Demidov <roman.demidov.nn@gm=
ail.com> wrote:
> >
> > The return values of pm_runtime_resume_and_get() calls in a6xx_pm_resum=
e()
> > are not checked, which can lead to hardware access on suspended devices
> > and PM reference underflows.
> >
> > Fix this by checking the return value of each pm_runtime_resume_and_get=
()
> > call and properly unwinding the previously acquired resources on failur=
e.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Fixes: 5a903a44a984 ("drm/msm/a6xx: Introduce GMU wrapper support")
> > Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 38 +++++++++++++++------------
> >  1 file changed, 21 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/ms=
m/adreno/a6xx_gpu.c
> > index f9de9329dee3..0cf205ea744b 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -2175,44 +2175,48 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
> >         opp =3D dev_pm_opp_find_freq_ceil(&gpu->pdev->dev, &freq);
> >         if (IS_ERR(opp)) {
> >                 ret =3D PTR_ERR(opp);
> > -               goto err_set_opp;
> > +               goto err_unlock;
> >         }
> >         dev_pm_opp_put(opp);
> >
> >         /* Set the core clock and bus bw, having VDD scaling in mind */
> >         dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
> >
> > -       pm_runtime_resume_and_get(gmu->dev);
> > -       pm_runtime_resume_and_get(gmu->gxpd);
> > +       ret =3D pm_runtime_resume_and_get(gmu->dev);
> > +       if (ret < 0)
> > +               goto err_opp_clear;
> > +       ret =3D pm_runtime_resume_and_get(gmu->gxpd);
> > +       if (ret < 0)
> > +               goto err_put_dev;
> >
> >         ret =3D clk_bulk_prepare_enable(gpu->nr_clocks, gpu->grp_clks);
> >         if (ret)
> > -               goto err_bulk_clk;
> > +               goto err_put_gxpd;
> >
> >         ret =3D clk_bulk_prepare_enable(gmu->nr_clocks, gmu->clocks);
> >         if (ret) {
> >                 clk_bulk_disable_unprepare(gpu->nr_clocks, gpu->grp_clk=
s);
> > -               goto err_bulk_clk;
> > +               goto err_put_gxpd;
> >         }
> >
> >         if (adreno_is_a619_holi(adreno_gpu))
> >                 a6xx_sptprac_enable(gmu);
> >
> > -       /* If anything goes south, tear the GPU down piece by piece.. *=
/
> > -       if (ret) {
> > -err_bulk_clk:
> > -               pm_runtime_put(gmu->gxpd);
> > -               pm_runtime_put(gmu->dev);
> > -               dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
> > -       }
> > -err_set_opp:
> >         mutex_unlock(&a6xx_gpu->gmu.lock);
> > +       msm_devfreq_resume(gpu);
> > +       a6xx_llc_activate(a6xx_gpu);
> >
> > -       if (!ret) {
> > -               msm_devfreq_resume(gpu);
> > -               a6xx_llc_activate(a6xx_gpu);
> > -       }
> > +       return 0;
> >
> > +       /* If anything goes south, tear the GPU down piece by piece.. *=
/
> > +err_put_gxpd:
> > +       pm_runtime_put(gmu->gxpd);
> > +err_put_dev:
> > +       pm_runtime_put(gmu->dev);
> > +err_opp_clear:
> > +       dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
> > +err_unlock:
> > +       mutex_unlock(&a6xx_gpu->gmu.lock);
>
> this does at least look a bit less terrifying than what came before...
> but maybe
>
>    guard(mutex)(&a6xx_gpu->gmu.lock);
>
> to simplify the locking part of this.  And I think at least some of
> the runpm stuff could also be handled w/ guard/cleanup stuff?
>
> BR,
> -R
>
> >         return ret;
> >  }
> >
> > --
> > 2.53.0
> >
