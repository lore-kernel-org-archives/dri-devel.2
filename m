Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D14C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D913610EBB5;
	Wed, 19 Aug 2026 15:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RJF/eCs1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NR3/ARB8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9065D10EBB5
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:48:48 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbSU7566918
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=9LwX2wymuNWHp2N3uz9gd+qk90vslZI2iYUW0/6tKgc=; b=RJ
 F/eCs1iKDPKXfdB5ApsmYoJxm/g60Lf9+5/Gjz+wuCzKhgMfVMVe+Cxjk44biNnM
 KdOz4rmYUDmfbVAHeZJskobZsbGPgl6nNtQMPyhL//HGHIxSJEakCRGmZzVWADrY
 ocNcZa3xFT9BaD4aDGfQYcmQHGnOmjxBOFtDaqwG8hJpO3himuIfvbZNfwwoJZsN
 lguO3NPX151/ns4boGy4hZ6cvPJ/63CcCujJAxiLVaz96j256GYBgIrVBfP+kOcQ
 tM1exHWwVoEgkcTjXMDOuuKnmmNnVFPnLYiSUxIXM4lKgusXPi6cmY87/YcaRbmJ
 jgu1IevwRlk9XbJDTqMA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5daa0pyj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:48:47 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e6b73b3920so840684a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787154527; cv=none;
 d=google.com; s=arc-20260327;
 b=qjnJ395sfpd0Gq4EjadUvB/fevGuBIX05R17D0iIkRs1B+QcAtinWLxDAX2tgIojIQ
 SgmpoPqX8fgfr/TPf/ceozfxagJo78S7mUEH7VTQsnqEyQg/7LHRoGaPVd3r/Kq386tW
 gOa9GKKSqPYFBgfG/2V/P2wBaIsCKxhCwF6Xjw0yg7ha1JOLp5uV48x7cOvE5ClUyXma
 S24Wn0pdHQNN0nZ7xeFv4Oh4GO3EwcFFdv2fahFHhlQsMKnqm6mS2D/aahbn9Lzxyzc0
 PD/tFZ0ftAOnOctn5qZ3BPoVMrjAxHrgtADeqIJ7Kf2281nz6AL1507/JRM9uHepZUBZ
 31PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=9LwX2wymuNWHp2N3uz9gd+qk90vslZI2iYUW0/6tKgc=;
 fh=e9+zh00lM2QPXbuDW5L4Tv3gw0zUZBwp5CQW7CNNUyA=;
 b=YiSY6nBnt4ft9wp/qX8MS5Fk7lKQYG9qAwpFRdPQ90JBU7vAdKzxM5Jstejt4cUO6V
 aLv4SDOxe58bQQgqDGVZgOkKevHAf6kVJUFteFqwHhf9wBeTb+aKZuSjObc37gMuwhrY
 WM1/6A6bUqqfdhLaaEs/MWU9d0Fg7lp5MJ1F5xlNa0YHbBTzj9LF+WNPfmv7ndCjVVae
 b3UK7wvcD1BHCD628woRFM1A+oEP0TOljXq90EX0jhSfEthPCoJnZSXfrwJo2So5XnHb
 x4/cX8HaX0DdxZqaPpURwywtWgO4CkJIer3TqH0N5XHvI2NCBAEuau9OOPKWHJaLwrvX
 ROEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787154527; x=1787759327;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9LwX2wymuNWHp2N3uz9gd+qk90vslZI2iYUW0/6tKgc=;
 b=NR3/ARB8yEeTO7kzqFbSODJ4MxwcF6UUmLRk4Qk7Cf6PCARkikepiXqbnKZwoJXNW+
 8zfV+Tl23P3TMitzByxRcsoQ7zvQx6Tg0jZozVOcFnYNBmiiBNHWsve9yhFF2qUGOUiR
 zw6IzaGedkDP/3Y+bLKSJ8GNm87sZo24q7e1e8lPLk5B8TtMd1H/U/3cEwjl3MhH9/EY
 83i/C04PYa/jHqVba1DXtwnSRILC6/vnfTKQg5Lkh6N8T5lralYF+L4lXmquPrEkU1I5
 +aLMtp7UG9SKnGNVKhYdRSEydVPB2BSu5tJ51qGIPhXcsSXonxMtX6hVzspIQwtMdnAC
 DKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154527; x=1787759327;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9LwX2wymuNWHp2N3uz9gd+qk90vslZI2iYUW0/6tKgc=;
 b=Hs/KiH2vcj00HhFsi2S8eFJaMOj8z9lJvrkzeQDv8LKptjXKGKTm2apryxCqX4q9Fw
 6GZOz2VJaW0Vf+zKhtquAlhvsYCwcCUYOm9y1+ZsB0NvxF8TWAMHsR8GLhSaPm0Cdbdm
 qnmJEIsp8VVQpdYx4FIwdINnEvX6lQoZUK/hTvS+d+OH80Yfej8xy6ex7yy3IS1RPqu3
 QXxqY/qHYoTnt4uco4M2egx8Mt2Zd8/E4esgFaFxO9+bi4/RlJrQcqcADQf7FGZRuBE0
 Oz+E4b1tbjVJWgdetaF9LgP8eUGOkwDpEHzQHe0/3vm3huc7P0Sp4izqF9gS8ApuvLrU
 PSVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RociC9DGc2H5NBjsmss/oj/j2ltAejSc5Z4PQCyyJyuKYScR7eB7Jg6E+UUJRk1lRnspofyxczcqzA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDaqLJMoifUz1w5gctb0QW7G0r/vb5I7FcWITyJ7cwmaYheHGv
 e3zMqFdHUglf2xXR+qvmi8jWB/HrBja4LXjQEl+clBW1mDOzrhy/Dz9SkpxryiGB7sSemWLSOEO
 gSR85Lm5kIKhvK1jwsXuxBzV30Zsxh4m31/F11G7cIJ7CEHTc1A53Sk51FLnYakucZgSQVb17Kd
 lY3Juk42dhJ3NEeRTs4fc7LCfa17AfgmUUchrHxFJNhs4YmA==
X-Gm-Gg: AR+sD12hPxdhHbCBdu05ZmbcY/M/zadDk95jJzvw+53F0E7Q78A+iyHM0uhcTwUi/ga
 iEpHlacFkM6/q1AeBEHcyriK19XTd9WcldIKMmuUhnArX04YrqY2GYmXaim7/UptIqiI8Q7cXmz
 qUNPY7Nf6ayY6lfKYmM2wP38Wen8mAgt3wP+L08kJxKyKq7iUJHh2uoJ4n
X-Received: by 2002:a05:6820:1792:b0:6ae:8ee4:e01f with SMTP id
 006d021491bc7-6b13c2d221bmr5523520eaf.4.1787154527083; 
 Wed, 19 Aug 2026 08:48:47 -0700 (PDT)
X-Received: by 2002:a05:6820:1792:b0:6ae:8ee4:e01f with SMTP id
 006d021491bc7-6b13c2d221bmr5523471eaf.4.1787154526670; Wed, 19 Aug 2026
 08:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org>
 <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
 <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org>
 <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
 <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
 <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
In-Reply-To: <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 08:48:35 -0700
X-Gm-Features: AcwNN1Uf01RBOSSs1eSJ6ShN0aw0OhP8jKQH--o7bN6dJI2taQ6GEVNP3fqxrcY
Message-ID: <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=fv3sol4f c=1 sm=1 tr=0 ts=6a85d05f cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=mAvluEFbtwFrZWikVwkA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: GblqnYY8k_V6LNJQBbyQ77zoMbIGFJfD
X-Proofpoint-ORIG-GUID: GblqnYY8k_V6LNJQBbyQ77zoMbIGFJfD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEyMyBTYWx0ZWRfX3AOhtRhTRHB1
 CX0LhyrElxdyMlk5zSAmfXBuc6EjEplrPZlNGwCPdVBp86gNNoN1g3NSI0M4h9Gd2ApGXmMBr7d
 8XNwLwLq0h9Fe4OC3sayIoCjD7bhhV8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEyMyBTYWx0ZWRfX6F2L45rYAKfx
 fncS7jo5mYb+5q87awgwo0KcmB62/fPOhZtt0a6jOHlM0HxO1sapQXv836DPTUyDFACZ54r+oU/
 tT1Gbyzlc/I2z3+8nV8MMDW4sZ4FZhySDLUN06XdAbV01qieeHH6K3ONhR4C2kkmaRoAeYPM5t2
 keeWYlh8k+gggFkt87qanwqzJyjDDe+0Kqac5oBZS2jhhoxmGvXoN4jyRWLsjA+jiqCLa8e0gkf
 +bceImpZdXXaFF9VLM+FDEqhCvUYtEyt/PV6lOiJI2Jc2oO2fo6e/oYzb3OAGK9rMtxt0Md+Bmw
 t8Z8PmeGRdYRUSOLOm9Dh4eijqwF+pjZK6NvEVxQUf/mXynH4PFBDe8raZ4xrEW+HgBUrz0h3kA
 SHmYXRgSo3Zl7+hRO1Y9v7m1/VaGordSzFv8N4EsS8d3AnfiDC5kGCo6NXhXD9s0CDrerd4/dhR
 34mxtD1GJumbxdg8DwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190123
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

On Wed, Aug 19, 2026 at 8:27=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/08/2026 17:23, Rob Clark wrote:
> >>>>
> >>>> Growing old driver does not look complicated itself. The only a bit
> >>>> tricky thing is to present somehow exclusive interface to user-space=
,
> >>>> like usage of one disables the second etc. Depending on actual
> >>>> differences in that interface.
> >>>>
> >>>> But having a duplicated driver is a clear no go and it is well known
> >>>> upstream requirement. Nothing new here.
> >>>
> >>> Would it be acceptable as a first step to, by default (ie. when no
> >>> cmdline override/etc) for the new driver to bind to new compatibles
> >>
> >> You have one compatible.
> >>
> >>> and the existing driver to old?  Ie. have both drivers but only one
> >>> binds on a given platform?
> >>
> >> I don't see how is it possible to write such DTS, because - repeating =
my
> >> question - how many hardware blocks is there? I believe only one per
> >> given DSP, so how could you have two device nodes?
> >
> > Maybe I'm misunderstanding something here.. I don't see any new
> > bindings with this series so my assumption is that the bindings are
> > the same.  What I meant was something more like "qcom,glymur-fastrpc"
> > would bind to new driver but "qcom,fastrpc" (which seems to be what is
> > used on older platforms) would bind to the old driver.
> >
> > So single dts node, but different compatible strings picking which
> > driver is used.
>
> Glymur is already done, so imagining we talk about next/future SoC then
> we would be at point of duplicating drivers for the same hardware. So
> back to square one of my comments.

I just picked glymur as an example, because I needed to pick
_something_, and toplevel dts for devices available outside of qcom is
only just starting to land.  Maybe it wasn't the right example. Let's
just say "qcom,supercoolfuturething-fastrpc" instead.

I think my example otherwise still stands.

(In either case, kernel cmdline or similar override to get the new
driver instead of old would be a good idea.)

> The rule of usptream development is that we do not accept duplicated
> code, just because a vendor wants to write something new. This is
> basically the concept applied all over the drivers tree, where we pushed
> back against all sorts of duplications all over the vendors.
>
> What I miss in this thread is why would there be any exception here. We
> do not grant exceptions from standard practices on "I want" reasons.

I agree that we should not have duplicated drivers just for vendor
lolz.  But when it comes to adopting common frameworks and integrating
better into the ecosystem, this doesn't seem like something we should
actively discourage.  I don't think this is a case of vendor lolz, but
rather reacting to drm/accel emerging as the standard framework for
this sort of driver.

So how do we get from here to there?

BR,
-R
