Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3988C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570D810E192;
	Thu, 20 Aug 2026 10:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NlB8zap4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hveLHaNn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BFB10E192
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:24:23 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KA3Fub3454836
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ty5/YlOK6jhAeQysmUgT83beKPjDWgvudsEIa05/S58=; b=NlB8zap4bl1dTpi/
 b77sQXntHv1GfNurcpg1EXnyTgwpZQ+R78j2BoglrlZvcovg72q6QAhNZfrYzcqr
 GCwMe36xIWlsMUYFJg8JYGU7TK6ZgYfMV+pc0lL6XogJV6HWr0LEOLcfyjLsqv1m
 ZNq4SlEiH17wGWg3jha9yW8w706I3uJe4rCwJjbfD5Am7ydlP/iNJjbivrLwrwS+
 x9zOhcGIvabtlfi89CueWIKKke4cwPHsg46q73d9VcaLPyY/MSWxNOaUT6WI97fp
 1du9a25vtOEz36lozAdQyY+2xlVha4vci5E+Etk7h5hFpMtrrVUJvTbcfOsZ8jJD
 DQkAog==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg88320-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:24:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbee5bab340so2247352a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 03:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787221461; cv=none;
 d=google.com; s=arc-20260327;
 b=NezS3Onw27gz6uxCxIAyeB0w+6wc6a2ODEr35ER7C3EOYDfGShv2pJ1C8rSnh4LZ+A
 Q+rb6RAynu94QgaJXadMluJWBkskjbb2piWThmeeZVMbbgd6l84gkUE1WY5vyk/WShxe
 xajZbfyRmwb2MpyALWS+4Tk+UocyQ+Z31LZf8R9VhLTCoLdvt3uI+F1kCNpV/Y6JHJKE
 WYtRHp2T5wspt4MIzXsU/ks8TQgeRkKDC8edTJZ52SzS/9BaJNAR2HJIlaHwfHisnl66
 XvSQFYqZ8UsBsdM6cvdGCDSAmh2MUDhRZM5ycMee5gkyBVJb9UIpi48RiN/QNWD447rz
 q6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ty5/YlOK6jhAeQysmUgT83beKPjDWgvudsEIa05/S58=;
 fh=jgmh99elYE/7eOaLsMMEgKcUrIeFDxqjxT0pEjGBNao=;
 b=N1X/txkTLtsIdTKhSo3sd86lxMv9V41hzD2W947zcHtL+XFZx3oZwi59X0PSaOeEJ3
 gURIqFPvaEcZ7PuybhjgzWKgHcN77p6Dh5ipJvbWG+9hKp/YiGKtpAyFXYiLiUSBMdWf
 468EUeCh14uK0HkJUxw9vZ6cl+MMfYpNVAWn22bac4VPq1cz3bnkDVwZAnQfluW89qRN
 memwxTg7NxDaBSLV5Auj/i3oJM+Hg22szn4w0qi4ixhR/FEskCHvT+u1k+j+A4DNXksq
 uncNXGi6VYXEtn0bg7Egv+9GtAWsg8xrhjp+yYZNiRI/kn1qPWbNLBzw5oj0wxxqC9Jx
 vYtg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787221461; x=1787826261;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ty5/YlOK6jhAeQysmUgT83beKPjDWgvudsEIa05/S58=;
 b=hveLHaNnATm/SMSQJ9bnrsoDeC9KIjF1vWsFwIxEYMRClMmdTIXSzauf7m+hmDnJad
 gg1ffEPp57/l3ejQr3Ek23mdllxUNK/QgK90/1/ngbce33fdlneCugV7y41tO/O3RKZI
 AhKxuX7dgG1lJQuCOuw/EAn5wOTxMM6P3RIh18mF3/DfmVLDSARTwjiykzF0qX8JBPvX
 bLB6yWEFYhNnq6o9huziCvq3IUFNleeum8N3pzlbyaVBOcpruG0ISW6QWguSczSzc6ki
 APosK8VgtiCquGiQ8Y8gktJ6SsoJoE7Jk+X0TSKri1FcdF/ALdVyHuGF9vjNxgopzqG6
 6x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787221461; x=1787826261;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ty5/YlOK6jhAeQysmUgT83beKPjDWgvudsEIa05/S58=;
 b=dKalEMt7JnMZQ5L8YLNZa0dfioIXo7MjrP8URMQPCiQ2+F/WAnlHmpx+7x1MRYNoBU
 4GVobS1594D2+d1wzRPrrsHBl4t7yQWG2ll4uytzLsBl24niF3XAgU30T3D8HoeWW84C
 MGdZ8kHUA9lOCJw9NInAaadRs/fspqrBY28GBE1CYUccjlf9fVW8HI0lR7Iy/B9tTF9n
 60N0YUKvCtcESDq/+CUo+SAUgJgP28TjU2Es7LAekQTRupAPyM47RxvT2XEJEGFAO8uS
 xLbZrDUK24Mq/4I2HKEog0r+sr88zwfoJ1pONlAW9CkJ7jgB61R6ln9SPJy74lHrxHOx
 mZRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrejPidAvT7wC86bKoqEuJj0giGOujCBD/QI6Y6nQM208R/p86RJFtpNmEM7gj6ul3+AQ4iyYpjT3I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydJ4ActwTBq7rYRwkm4DlMPWNPZjwtohjHuBoclHEJ6Y6RYW4I
 delbXhU6D8i2yaq3KeZo+C48f1A/GtCveYpH9h7FstgsuqZNKI8LrM043+tlv03lq0gxVg2F2W3
 aspQb7OotwiB4zF7UQL4w1L7imBY5ZGTc+sokt283Fv/KpqRWVxz8kSiwWOTtbSE+2y7YiGc8wT
 V5NjpootCLLLB7uy6ueC5TWmitIUOSWrp/IlRplPW1oKiFcw==
X-Gm-Gg: AR+sD10E1v9DeX1ZNyzOAnPX4yk10bYzYDlYtbPYpnt1Dx/GqCFY//nzQZi2pXnwmHD
 Xps9uFy2YXmhfNVCG5WOfXp1a/n6ES9YP+sQe0XY0bypCBG5ZmV92bt2Wu1Qw4xSWVjbC3au/by
 BM6PuAOQzbzM8jT4RC/MjgmfeHtzShcagWgMcW9yfPEvJZ5/zCF/hKEaZmlQ==
X-Received: by 2002:a05:6a00:2301:b0:847:7ffd:ce35 with SMTP id
 d2e1a72fcca58-851d382e720mr19263272b3a.8.1787221461190; 
 Thu, 20 Aug 2026 03:24:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:2301:b0:847:7ffd:ce35 with SMTP id
 d2e1a72fcca58-851d382e720mr19263163b3a.8.1787221460718; Thu, 20 Aug 2026
 03:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
 <CAPx+jO-ow2vo2wMxERLGse88wLoaR=HLdOWk6Qwv97ZdbE4R5Q@mail.gmail.com>
 <CAD++jLnzDmxW_SoJ9H1tS2_r+jd7A7FpLVp37nK=dOEPj=GExA@mail.gmail.com>
In-Reply-To: <CAD++jLnzDmxW_SoJ9H1tS2_r+jd7A7FpLVp37nK=dOEPj=GExA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:24:09 +0200
X-Gm-Features: AcwNN1XagjqLsUfXCAJXyqu2taAnOsy7gMxOrYs8oiiblP73dGEaPVwCq6ztGis
Message-ID: <CAPx+jO-+hLsAdDC9Ep16cO52cA2c=xKeXvngkGqzoC0FyxXj+A@mail.gmail.com>
Subject: Re: [PATCH 10/11] regulator: db8500: Add power domain regulators
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3NiBTYWx0ZWRfX/LBwanTO5l01
 7z6Kn8qSUYP9IHMjrzHfi2o/p4VFPDAU4CorUewXiOH3P1P2nf2/kbB+aWdNt6vMPQr0nhfr0Gw
 W+5BvHXAt9ebgygO22BiQYf4qJ5QZAk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3NiBTYWx0ZWRfX+96yW+Aq6f/s
 eO7lk+e1h00+p9++r8VfWp6C20GXBDyx8OpGaBK2KnVha3XZ+iGtqiN3hQkOoqiTgFWpL5I9h9w
 XHwJYLCP16uVquHugJbnL4WvD65Mh33M4LxD8UlRhiIe/ly7qi+0GCnem29jxJ9YNPhkdq2TKsP
 Tl945qjcYqJ7g+olZwE9nJcdKhDct8A02YE1QrH/kXy0siV1j0GPpwRgmxjg0n1y7N76n+wrceX
 6+SbS4oyLIf5tD8eEthuQdCMgjbi56d+glUxOMYDmbijRcxoQIA7by6kdj99gYVEuTgXYLGXvkM
 G/0eLP2qNes7Yj9M1Sfg5QAYqXVnCDSKlri1V+eaUm5ax/9PdvDnmQAGGZzn8gxguXzJ8rim4Y9
 F1BqnmHk/+CDCObDjpkpiuehti6MNLGxhxoqz4Lzh1hXZVffHw216uQbqGJQUsmIXvm+ls9gqLf
 VVLVcC8if5dGlxdWvZQ==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a86d5d6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=-_xB5rzH_TN0feDXJEkA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: yvU8ARosHI9npi36DZCCiO07Rz9NaXuA
X-Proofpoint-ORIG-GUID: yvU8ARosHI9npi36DZCCiO07Rz9NaXuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200076
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

On Wed, Aug 19, 2026 at 3:30=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> On Wed, Jul 8, 2026 at 5:53=E2=80=AFPM Ulf Hansson <ulf.hansson@oss.qualc=
omm.com> wrote:
>
> > On Thu, Jun 18, 2026 at 7:01=E2=80=AFAM Linus Walleij <linusw@kernel.or=
g> wrote:
> > >
> > > Add a DB8500 regulator driver for the VAPE and VSMPS2 compatibility n=
odes.
> > >
> > > Back the regulator enable state with the corresponding power domains.
> > >
> > > This is done for off-chip consumers: the corresponding voltage rails =
are
> > > routed out so they are used for powering different peripherals using
> > > these voltages as supplies.
> > >
> > > Assisted-by: Codex:gpt-5-5
> > > Signed-off-by: Linus Walleij <linusw@kernel.org>
> (...)
> > > @@ -673,6 +673,7 @@ db8500-prcmu-regulators {
> > >                                 // DB8500_REGULATOR_VAPE
> > >                                 db8500_vape_reg: db8500_vape {
> > >                                         regulator-always-on;
> > > +                                       power-domains =3D <&pm_domain=
s DOMAIN_VAPE>;
> >
> > Hmm, isn't this the other way around? The power-domains node should
> > have a regulator supply?
>
> They probably have that, but that is not what this is about,
> it's the other way around.
>
> > We may even consider to skip to model the regulator altogether and
> > make the power domain operate directly on the prcmu instead.
>
> That is what the series tries to do, as a whole. Sorry if that was unclea=
r...
>
> What we do in this patch is to deal with the fact that two of the power
> domains, when enabled, also turn on two external power rails outside
> of the SoC.
>
> Since external components such as I2C devices cannot really be
> claimed as "being inside a power domain" they take a regulator.

So with I2C devices you are not referring to the I2C controllers, right?

Are you saying that these external I2C devices consume the same
regulator as the power-domain DOMAIN_VAPE uses?

I thought these types of external devices in general use a different
voltage range. Moreover, do note that DOMAIN_VAPE also has
corresponding OPPs (performance states) that change the voltage level
based on the requested OPP. I am not sure an external I2C would be
able to cope with that.

>
> This is based on my understanding that power domains is an
> SoC-internal concept only, so there is a clear boundary if something
> outside of the SoC starts to use such an externalized power rail.
>
> All this regulator does is to make sure the corresponding power domain
> is enabled when the regulator is enabled.
>
> I will repost all the patches once v7.3-rc1 is out.
>
> Yours,
> Linus Walleij

Great! I really appreciate that you move this forward!

Kind regards
Uffe
