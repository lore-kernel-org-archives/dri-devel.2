Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20171C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344F710E4EF;
	Wed,  9 Sep 2026 14:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TMTTHeX6";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E721410E4EF
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 14:31:30 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1e1b51234so260444a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 07:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788964290; cv=none;
 d=google.com; s=arc-20260327;
 b=cmWh1OsuuDbmH9IAGHBN2JCDiva+LsGdcfHxdcpXoXLjK1cVuuYsWOfsASZIQ/oQ9I
 DQhAyJXg3I2dpYdU+Uyk791xdLCHlquI/7CFiWSIzjqxQwL3AhkFFWraMOhj/umootlf
 2NueCK6hTHOQvBBF2JNKxYMSNdN7uNaQn7FsX57E180bx77hgAl3ywalvTLyk79H4iTx
 hLi/G7MaWkr6QABvSuM4sJpm5P2p4OKefnP86ri+5KyotvYXp/tmwsARf/A7SJ8sPxG4
 kjknqjCYOiCbX8vctSX7Ig40djiymhIemjsG5+5Itgus1VG94EWSOmGIi1FanD6kgjNS
 QxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r6d1bbraxxEbRqi2dCUG5O4sMDZatQ/k1ITQSbR2TYM=;
 fh=qD3FWRdZvKq/LYEavuaJESxtlyrb2bObYQgfjFn4HAk=;
 b=c1KuSQ+CTCTinHsqLmy9h24F1sgUDzYsDnVa2VTrEi3gnyLkrKMpQFEB+TtK2w1E8a
 3pFmTgUhHU4rjQlD4SxSHyKm1mG/ssewxceUdWeZnTYexXbv/+zP16pMlDxCrInxw+xu
 2OYpO/rvBboihnEJK2PnrekoTerQLUmQyjQ/Do7EEbLDawsPo9YweWWo62wIe7TXoDap
 +p/vWQcTq5zfkJJZLgj3tqnr6SYmOeqhRGiau4iOfXPv1LgyvSesnzqk8zqoReiH5t7i
 lkWUJfcLu2iQMA6ijITSTRkHLwi78cZqf57s7tXr1AzLUz86ImnwIxIN69ge0J9uehAu
 EZZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788964290; x=1789569090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r6d1bbraxxEbRqi2dCUG5O4sMDZatQ/k1ITQSbR2TYM=;
 b=TMTTHeX6NIng1s4o44oU7v+3YX25zv0Hty5BicLHZ4AjEyRMSTvmqisaVzmnaNb8+Z
 1KULSyu0ho1CimAiPFCWgcmo1pW632G6apV2Qb890pFeNDn0XUjaqgX0vyJiM+yxA7D6
 Y5Et1EyrMj3Ev+arIss5Oxu+NeD13wCtX6MSR9qUjA9D8MX7SppBmxqD7CquQ5CIYQVe
 263jLXCh12xtd9S1oExrKEZos9X3NxJKfjCAqwTV6h0UhKRWEmwDrhpSJc9uBhDngbsz
 Wh8VapUXyjIJ5X75OZMVCLwsdQMhuNU1YVldNGfT/H/0qcYRMSlg40vYztz/ZViUhngp
 D62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788964290; x=1789569090;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r6d1bbraxxEbRqi2dCUG5O4sMDZatQ/k1ITQSbR2TYM=;
 b=KF5jw1I8rjBYdCZXRt4R5Qby6nNcPG1cDuDB1bq2Xen42tJb5QU9RyQDCCPT7YZ4Xy
 XacYL6PiuxXv9Y/OPUZuqxUTT6hVwt0UM/n/vJ7rB9kbgmR+5C3rrhxkDZcpmug6Xfeo
 NRLouVCQpL2uqV1+Xiqv6mM35xG6qAfeATRlNzfp6Nfy+j3I0j3pF1Z55pwUvnf28Z6+
 0UBVbK3mMHDRNNfrIHymn1emSxWdByv6ukAWyMPZfBIuF2d1k+3GvPkNjiCOuJUx7g9Z
 3h/RnI4nAM7atulauFPRVk0cc4UM8jJrRiRD7tVaSxBQemPGB59GTe+rmeM37c1r6Ic9
 aePQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcLK2B3sZTf7/HmorkB30Yr1v53tdm3a6oe9NaSF7/9ZkO5SGISn0zILTpu6XDiAYycVwgRiiUSmo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nSdbnhDmQj54vdDBO23xOppeW1zf8M5kc8ACImPkoqqOBmvB0K
 FISPR9+ACP2ch4KWxWBF0Wt8TRckYalLPfubikuFK2XpkrrW7yJMoLMC/icAj3eWZbItvblVaGZ
 HjmZkrbIeujDEmrZE2CNcETuvU3P02ZY=
X-Gm-Gg: AYBFou38+nUHJe2lQlYsXyOzF9tpvgv622xU8r8vBm22LT6bpcqR1NmksXnfrVTwmpd
 5L3REbz5gRGUPZobjgm1I/IHGuBVsq7m/oSjUzSTV6n8xbWF3q/ii3fYgRpG+btOQCOTV1z0+Hb
 sf6McwhfA54xOetf/Td4jpoF6r9Hv9PEljVSFLKiwJECW1Qu6dNwdwRJwR9FphLS7Ek5HyLyeyj
 7oAbQVi8l1PVVRgXo9VlgByLOcSFaltvIHwVMebdKIn4Kw6S1n7vpcVuHz+XH89Dol1TibojHXh
 suoNuXy/JW09sEnagA3oJbfXjDK1ZEhdDIXuMtTkeuhsGoVcO/oaez1zJC+bYPxMrSRy2wYbuBo
 bYtPCCgiaJG4=
X-Received: by 2002:a17:90b:2dc5:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-39b9a99459fmr10318254a91.3.1788964289978; Wed, 09 Sep 2026
 07:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
 <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-2-284880d6e68b@linaro.org>
 <47f0399d-bb31-48bc-b69d-4abd445727b4@oss.qualcomm.com>
 <5bd35343-1bd9-43c6-90f9-d57d67e6d416@linaro.org>
 <CACu1E7Fs-=sKJ07Pcb_7BCTFaXLCMVGEu=yQ6+hfG3Vjc2Y_RQ@mail.gmail.com>
 <6763c530-ffb6-4480-9a56-2594bfe8a010@linaro.org>
In-Reply-To: <6763c530-ffb6-4480-9a56-2594bfe8a010@linaro.org>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Wed, 9 Sep 2026 10:31:18 -0400
X-Gm-Features: AcwNN1W6JfBlDjrb1_5nbhBQz72mGClexEs4modSAjAw6CNXol8sRbktxQsrmMU
Message-ID: <CACu1E7GZa8QwWLk0qiCYiYzJN-2HorU93bYkkFChzR2gnExmGg@mail.gmail.com>
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

On Wed, Sep 9, 2026 at 10:29=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 9/9/26 15:24, Connor Abbott wrote:
> > On Wed, Sep 9, 2026 at 5:32=E2=80=AFAM Neil Armstrong <neil.armstrong@l=
inaro.org> wrote:
> >>
> >> On 9/9/26 11:06, Konrad Dybcio wrote:
> >>> On 9/8/26 3:24 PM, Neil Armstrong wrote:
> >>>> The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTE=
R
> >>>> register on A6xx and other A7xx GPUs, use it when running a A750 GPU=
.
> >>>>
> >>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >>>> ---
> >>>>    drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 +++++++++---
> >>>>    1 file changed, 9 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm=
/msm/adreno/a6xx_gpu.c
> >>>> index f9de9329dee3..081e79ea4652 100644
> >>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>>> @@ -23,9 +23,15 @@ static u64 a6xx_gmu_get_timestamp(struct msm_gpu =
*gpu)
> >>>>       u64 count_hi, count_lo, temp;
> >>>>
> >>>>       do {
> >>>> -            count_hi =3D gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWA=
YS_ON_COUNTER_H);
> >>>> -            count_lo =3D gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWA=
YS_ON_COUNTER_L);
> >>>> -            temp =3D gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_O=
N_COUNTER_H);
> >>>> +            if (adreno_is_a750_family(adreno_gpu)) {
> >>>> +                    count_hi =3D gmu_read(&a6xx_gpu->gmu, REG_A7XX_=
GMU_CX_AO_COUNTER_H);
> >>>> +                    count_lo =3D gmu_read(&a6xx_gpu->gmu, REG_A7XX_=
GMU_CX_AO_COUNTER_L);
> >>>> +                    temp =3D gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_=
CX_AO_COUNTER_H);
> >>>
> >>> KGSL apparently *writes* the system time to these registers, is that
> >>> an idiosyncrasy regarding how the vendor userland drivers then use
> >>> this counter?
> >>
> >> This is a GMU counter, no sure why & how KGSL or freedreno would write=
 anything to it...
> >
> > It is writeable. This is part of implementing
> > VK_KHR_calibrated_timestamps. The idea is that when the GPU suspends
> > and resumes, we keep track of how many ticks it would've taken and
> > then pretend to advance the counter by writing the CX counter (after
> > powering on CX but before powering on GX which initializes the normal
> > GMU counter).
> >
> > Note that VK_KHR_calibrated_timestamps worked initially on turnip but
> > the tests started failing with v6.19. I haven't bisected yet but my
> > guess is CX was never actually collapsing for whatever reason and we
> > made it collapse hence breaking the tests. So we probably do need
> > this.
>
> OK thanks for the detail! Today it's only used for perfetto, but still
> on A750 a different register is used for this purpose.
>
> Neil

Well technically no, today this function is also used by
VK_KHR_calibrated_timestamps on turnip and today it's broken because
of a kernel regression...

Connor

>
> >
> > Connor
> >
> >>
> >>>
> >>> Konrad
> >>>
> >>> P.S. looks like a8xx also has this counter
> >>>
> >>
>
