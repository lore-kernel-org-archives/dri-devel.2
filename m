Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA3CC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A4D510F157;
	Wed,  9 Sep 2026 13:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ev+NgOtR";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3198410F159
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:24:26 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396672b2566so1138287a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 06:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788960266; cv=none;
 d=google.com; s=arc-20260327;
 b=c6FXQeQOcScSnFMXPJl91qWVDnKqMYJxUTe90KYEsh6BdImf+0sPeELkmL01+ioylZ
 4nW2NuVao5Xk5R7r1D6UCUhiVg3avGvMhmtag848CngtoKSnb/k9owljHr8LcovZNqGy
 QgviG5/8uNqCe+EtZCnF7xumSBCRb7PWT7ATmh8Gf76NOuTFQxRbnc1PcPlVahQ2S54+
 iPlL5v9DusN5fsUESa1177sfjfIsWkhH6UrHS3skGK7FSibUBmD08K6IkC/RdyYWNGRC
 h1alpmPNYUUfGMWmmwhoF/g8jfpp+LVuxFahrViQ00iZg+u+zH3pX5ibmGm4ZdC+qelJ
 fshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nWDGOx6XLuNNayvEPs6THIuSRdlyzHqLn64Wfdmy9F4=;
 fh=UEFzUTH+PfT54rKnmF3un7zGJATIkFscWfCZUGPJ1c0=;
 b=pQxIjb5DhbNTcI5oI0KcaBFwDDrrINxoU77hFb+psnjPEpvwRfEMY+lFZrmpSaurTb
 vDtXv+0eZAy4covqvZx3mlooa8Lk9chDESlzdgXeU64rXt5p7Ir/xgk6O2Jm+V4nCvR2
 oL8ND0k2svTvxfH9lItfi4KLcZR0nGakT2EGyC2QsThTfxV3lZKoeGkp05ejtsJwJTg1
 97Rixg+U+WU7rFE9MO1XMO1+dZJfdTtpquWLPS3cPmEmvaDaSP7CrHL8Ss/cq/IPC1eh
 /PtUgodZ/AazWL8QyyhON9vyvioQizwraDjzrA6KW6aly26cf7XhoMRbBfKQEBK89qzw
 06UQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788960266; x=1789565066; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nWDGOx6XLuNNayvEPs6THIuSRdlyzHqLn64Wfdmy9F4=;
 b=ev+NgOtRu382uNuYB214CJOVMZNlBtPAeHMKhN9AomD5PxQnARyMYPGQPdG5VCmzkT
 K1JjFA0QTCPlLIlPYhEc+pLBf3n/vmoK3y2XlAT+7uKWPz8wiUEw7rzXeW9qotmpvwJp
 m7Udy29o5sC35T252Zt63oE36+Eha9j9IwAExniJ0GPXfeX/4aeIvPJi4NlxhEmT5u0f
 x/DIOI4N5r7BD9EMREhO1OQQ0DjhiDiZTu9mFmDQtdRePCXSLCcBel30VO6Bv+Y5hPtO
 89dgCsKuCGCcDxOSAOoU3xCJ/0MGt28IhjvtfVHuj5fwDfWblHWbM2o2/+vYwJnb5txz
 Z8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788960266; x=1789565066;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nWDGOx6XLuNNayvEPs6THIuSRdlyzHqLn64Wfdmy9F4=;
 b=DzfxVpDTkVPPMM0/vft3VzTnfExMJnBEG5hPQA5DeLGwipcTtpY3nJRdJaZxCYENym
 IOTzdv18VGAt8Ek7d5INvxPCPDe+SpyovTkMhrKAU+wJSs2bDGfzB4fpcSvTkIr1eeTx
 8lzgWvvHcasyV1CcEaOPZPSz/snN88I1ARHthS6zKq377lMZwmzScY2yYkaSuvHNm9Ns
 DaKbeqmj6U71Jj7kSdl91QoiDsaCPTPVNhe6GxrslCJm5DyHc2us6Gwo+bllwIVXJDHl
 Q/Twn29ihz9oarxeEwHojzWwSR78l4Ypnrw9pW5lhBzdvE4mEKvMvlJmaxmLLF5BdxIu
 U/MQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhNp/4YBsBq/CmJLkPSoyJPsrcMRHrSdYtI9h3TPWQPuN4gt8HCzmPd0LEoVS9WygrZIP50/LH3Yo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m/Ga1wpTAZZFxS7NOkGbdrj1HO721rB21eU05Uvp+RA7ml+MZk
 u+krMHB6Gpcw47coVLEW76speGNhhw848lMx1VEc/NKHHAP8TVBXqU+Ti3Il+vIV39udsjeukbU
 UZI5kT/BMWWXh4eqlbnwXcE8SLxmh7r4=
X-Gm-Gg: AYBFou1bayahLUg/vqr6V5lWgySvDku8JzRVir6685RMCWRu5kRR63tITUs+Ta/ZetB
 ujaompNlKfozAaat/s6P1bJOarNP6yKpUs+B4TUM7IjAQtMvTkOsLyYLQ+nIWotlRIVQ+P6LvnL
 xkWKJfiWe7FserX3yR2JtYdRigCMz7o7bXivbr9JUC9/mbjh/FUV7HCMwYtf9NZSaLvm9qWcUrF
 UyHI7ef0fnj2VdChG11+A/Q9jItYEFD18Kl/F/XYvotQAZFXVYgYpX04NH5CaYEBLnJfJwuCndT
 EI20Qf/Ldar+OXjeDNnmDni58AxufUtaFWHo3ZoALWKlp17dNqUTlg3gs0ePzDBdfNUsYHq2g2x
 uujlzROn0ajuXoM2FRkbhOg==
X-Received: by 2002:a17:90b:3907:b0:398:bada:832b with SMTP id
 98e67ed59e1d1-39b3d8a3d1cmr27490020a91.6.1788960265594; Wed, 09 Sep 2026
 06:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
 <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-2-284880d6e68b@linaro.org>
 <47f0399d-bb31-48bc-b69d-4abd445727b4@oss.qualcomm.com>
 <5bd35343-1bd9-43c6-90f9-d57d67e6d416@linaro.org>
In-Reply-To: <5bd35343-1bd9-43c6-90f9-d57d67e6d416@linaro.org>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Wed, 9 Sep 2026 09:24:14 -0400
X-Gm-Features: AcwNN1XDIGqxTwFTzYxc9ACHpOeiJfaYEzctXSxy3CZjTiBOkSiKBiUHjwpg3z8
Message-ID: <CACu1E7Fs-=sKJ07Pcb_7BCTFaXLCMVGEu=yQ6+hfG3Vjc2Y_RQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/a6xx: Use CX AO Counter register for
 timestamp on a750 GPUs
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Wed, Sep 9, 2026 at 5:32=E2=80=AFAM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> On 9/9/26 11:06, Konrad Dybcio wrote:
> > On 9/8/26 3:24 PM, Neil Armstrong wrote:
> >> The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
> >> register on A6xx and other A7xx GPUs, use it when running a A750 GPU.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >> ---
> >>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 +++++++++---
> >>   1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/m=
sm/adreno/a6xx_gpu.c
> >> index f9de9329dee3..081e79ea4652 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> @@ -23,9 +23,15 @@ static u64 a6xx_gmu_get_timestamp(struct msm_gpu *g=
pu)
> >>      u64 count_hi, count_lo, temp;
> >>
> >>      do {
> >> -            count_hi =3D gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS=
_ON_COUNTER_H);
> >> -            count_lo =3D gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS=
_ON_COUNTER_L);
> >> -            temp =3D gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_=
COUNTER_H);
> >> +            if (adreno_is_a750_family(adreno_gpu)) {
> >> +                    count_hi =3D gmu_read(&a6xx_gpu->gmu, REG_A7XX_GM=
U_CX_AO_COUNTER_H);
> >> +                    count_lo =3D gmu_read(&a6xx_gpu->gmu, REG_A7XX_GM=
U_CX_AO_COUNTER_L);
> >> +                    temp =3D gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX=
_AO_COUNTER_H);
> >
> > KGSL apparently *writes* the system time to these registers, is that
> > an idiosyncrasy regarding how the vendor userland drivers then use
> > this counter?
>
> This is a GMU counter, no sure why & how KGSL or freedreno would write an=
ything to it...

It is writeable. This is part of implementing
VK_KHR_calibrated_timestamps. The idea is that when the GPU suspends
and resumes, we keep track of how many ticks it would've taken and
then pretend to advance the counter by writing the CX counter (after
powering on CX but before powering on GX which initializes the normal
GMU counter).

Note that VK_KHR_calibrated_timestamps worked initially on turnip but
the tests started failing with v6.19. I haven't bisected yet but my
guess is CX was never actually collapsing for whatever reason and we
made it collapse hence breaking the tests. So we probably do need
this.

Connor

>
> >
> > Konrad
> >
> > P.S. looks like a8xx also has this counter
> >
>
