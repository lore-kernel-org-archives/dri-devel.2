Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0AEC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11E910E57C;
	Wed, 19 Aug 2026 15:23:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eqtYERns";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CIbQDDHV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB6AA10E56C
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:23:20 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbVWE566929
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=KBH/fUIgWYWW3/6b3lc46QqFXFbnfFKPLKLVEnp7Rdo=; b=eq
 tYERnsZTS3kFgGZ+V6OYIfQSuwal+Wyf6alsTQxpOdLChbPicqOUuXLXL9yBVLVI
 DpPL8hQD+TSwk0o8IG05G4gjVuVAj19T/RyMlhPzZbqqBkVYB8y5x0mvZZim1dON
 idZbReCveIfOKPoQSCJrzVNApr4H2re1dYjZjPK6cXbayggYeOpiBcniVOe8aStj
 ldhZb7RZiklrnboO0MquBUxcpdDAnR3aFOnL/HzIXssMdY8hn9AkeH6xDVR4tofX
 rYW5hyrLveNflJWVikkwx62Dd90MdJmAlFQG53w/5Rw6/T5k++Ln0+TyhdZxnNsM
 JzA/VA+0/v6s5OPvt43w==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5daa0jt5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:23:20 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4b19ce23e5cso889240b6e.1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787152999; cv=none;
 d=google.com; s=arc-20260327;
 b=Qh0ANibkSRjIu2c/avo41izZRx1O52kmYZgLhr+jxggtDGbymP73i4F6gCrDHbkYBO
 q1xoMD5YUXytlA8LzRKbFYGSxZ3ho83gZuB5YtR8Sb1R+6uDo587AIxZDpX4Aqq/3GQs
 eFCrndOh0C7rbs6KndFbUbvNWr0VYt9lwdMKlRb7CkIB8nfVO/gWjcT/S4TDZ2eHZdRN
 mgFDHunNIbhX+ewVz6MuiEliHpnPV7KbnTROp5/i0RlczFcA2dFXIc8Y4CxGv5rEDU2I
 lrOD/kRoNRvm4zys+8P7CfprF2g7tjUWb0NEoktGCj0VQxmlW2pQ4ZYUm8FzJfQaJpwB
 mP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=KBH/fUIgWYWW3/6b3lc46QqFXFbnfFKPLKLVEnp7Rdo=;
 fh=DX821vDyGI59/ImkPDDkZanHwCXfAdI9kEAutvA3Aqg=;
 b=WciT3VIyMOH1RGRid2S6ZQiL4L0GBJQpw7rI0NSZc+VAjPk8DB06/aasfqvdJXehTE
 +pwninQ2O3CFQQeW33SOmCQn2yY037descyC6/2P83vYHsllM3tHT4Ds+CqcGPk0w9iG
 Axud7G9Ttf4fvlvYQFE+IucmQInkFgO5h1P7yYqOyhX5HnsKv0WKAYM3LDS6Trwf69e7
 7l/RJ6loGbsREP/o0w/xLu/rWLOaX/M02OalR1IX6RKitlnkhIAdqFrW/6duB8USBfeA
 pOWxlen4Ix6xt6uxmYRleTd7RI6lZgeNT2S9KbFNQ2s/NU4nAZV+OUQ0FUxu2ZDFXTL4
 zEig==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787152999; x=1787757799;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KBH/fUIgWYWW3/6b3lc46QqFXFbnfFKPLKLVEnp7Rdo=;
 b=CIbQDDHVKUxWaw997MLar3xVctdBFjR3ZGYLjMsnDHKgSWvexRkLP4QFeI7xxWBazq
 WGXNs2W5gDswe6fLo/Dr4Qw/ADNq+CVkk5cg9XOOcyfFmSq4/1w/BXvTgBwzBVbjPKg/
 EMkWCr6ioX4Ayw0EDZwIPD2FZt/HZGy/yKz0xxj2/1T442PM9A3P22JO9yZf4PjsADhN
 xmrtNXQ9KPFuR59gGDZtrAHDJXYyJMWJgYVRUamA1gJ9+q3xAXV9mHC20VDUw1QonNS/
 7jh4Xan9vBix41khdAGoKo3d/iRo86Pax1pGfq9+GqAqFpFBaO/imlKbM50LKlxDiUYO
 UUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787152999; x=1787757799;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KBH/fUIgWYWW3/6b3lc46QqFXFbnfFKPLKLVEnp7Rdo=;
 b=tIC3zGkww+xxIFfiCdiElakhJ2x1kkVAF2Lhc4NtIMeeJfFck6knAX9kHey8JLf9RY
 m+WA7EeD620vPATUpi8MvXVarxxYTFPp/gqjJvQZk8XG9dGfIalux26NqZI/ljUle5Ml
 4Gf+zlrTwd0XoLk4gcfLq67shsrlgl+FCT9oakIvYYiCOn5KVf4KrYPcgSmuef4FLUIH
 PZsU85BpvPkPRRVwu/YlVAvO6x90i/SCzRXU4M69mVJYGZXDklPE54mf0ZKvx/YWtkFt
 1fk4heADdGeY49HZ6vrYOQE9CgAsUCT72CVDEoJK3NQNAPpIqjFK25Uq/pTHlFGrwoKl
 ZfzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAaHAsh+F7qw2dL6ocoH73VZE+aysnao4CL36w5cpjIgIAngVjJvnjYS82vfWd1uoO3dnzwjMNt3c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUKVF9Ok8qyYHrTtxDkXeOgOFKcJYLfmYHJmd2n71FnllLMP2O
 sj5tpi3ZX2LwVkraCydqckf9TK9w9wzfrvJpr1SZgLyxZZUcdCXDP0SZilkoJgFGHpj22bZd+c7
 t8p65IEkHUHFMWBOcFfAa8Rs02vaBOkwshaj0gTIdgwzC0gJZt1yJWQrQ+Fu1PGCbUNvmaPOY5g
 dUV7ftKFeT1r93AblW/35XvxgYzk87lSGUh92IzhVk4Ij8/Q==
X-Gm-Gg: AR+sD12A9YfF4UkzFWZsARR2rixPwKIPujy5J4Ch/Es5/SjectdFeNW46LthGk++a0p
 /8G/jTLxLKMW+4WLIwLuxw9jBplWu0PKpXK9VX5XU/WkOtouacKtLo/BTUsZcxfoZ6/jTQp3sPO
 WDWEsvQP827of29dt7Ya1iN+WMFw3lzVYvE38NwqGDYvbjSn/f0taoNLxb
X-Received: by 2002:a05:6808:1997:b0:495:eb86:6e8f with SMTP id
 5614622812f47-4b2bcaa116cmr4635306b6e.14.1787152999001; 
 Wed, 19 Aug 2026 08:23:19 -0700 (PDT)
X-Received: by 2002:a05:6808:1997:b0:495:eb86:6e8f with SMTP id
 5614622812f47-4b2bcaa116cmr4635236b6e.14.1787152998435; Wed, 19 Aug 2026
 08:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org>
 <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
 <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org>
 <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
 <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
In-Reply-To: <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 08:23:07 -0700
X-Gm-Features: AcwNN1WxA9fiQ0CGl4J8t7bFhD1MTRVpPgPEs_G6pBof5jMpK8zFCbjUKPrGqB0
Message-ID: <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=fv3sol4f c=1 sm=1 tr=0 ts=6a85ca68 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=2opUpfO7wUc-A3Q1rUYA:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: MSMI7N_yHBGnFKk5jOru0OI-QTqA8xuO
X-Proofpoint-ORIG-GUID: MSMI7N_yHBGnFKk5jOru0OI-QTqA8xuO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEyMCBTYWx0ZWRfX75yeKn0jV4qE
 ezJskBHGVzuws3f9tVglDs2+wdiRpH/t6x8nDMZRX22CqLkPJPN9noxzLfR4NHngrItwvL5lARE
 21YmgnlVTeJCc865S6pAoA/MRN6fi7g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEyMCBTYWx0ZWRfX7QuL3hO63Mzs
 AmoMcamlLg+NkRPAHz0BZ8cYO5FO+YN3DapXK/I9qCcJNkdNLcCl2NtWJlYpuH/0GDMGCiBdc20
 a1qmXkPar9kTgTpNouynDVJejSCCbFqvjfsiPWbz1LlaZKJZz0p/94JrbnGnGlxghHg3XKwICiQ
 ZotpeWH8ctPfrUYEOKgoeK6lF2H3yxk0ZMr4KP/jtDDZvE3aW5gBCtZXjtjLshOqUMYt+nItBiT
 5mrCGEcHA1YsBQrB5qzYP0oKCgyuq8pveNbLKYzS9fJ+OSuekPrwQBDI93rD5/4yjGPEU8WBx0w
 pwu5BNh6i1dDthGakLnBPWbyU9vW7ggLFwcPv4CBI9kZlVtZIZF1dwHSpvQnq0J/fCjsOx+5I5U
 kBWPixIbAhjbrVMbOr0yKf9wF4t+KQ/KtjbA3lXcv6+8+jolhHZno1hsI3DhMkLsLAkqW3kHDhG
 OZ82XGZS2TBb3qEGR/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190120
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

On Wed, Aug 19, 2026 at 7:53=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/08/2026 16:49, Rob Clark wrote:
> > On Wed, Aug 19, 2026 at 7:43=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 19/08/2026 16:38, Rob Clark wrote:
> >>> On Wed, Aug 19, 2026 at 7:21=E2=80=AFAM Krzysztof Kozlowski <krzk@ker=
nel.org> wrote:
> >>>>
> >>>> On 19/08/2026 15:26, Ekansh Gupta wrote:
> >>>>> On 19-08-2026 00:43, Krzysztof Kozlowski wrote:
> >>>>>> On 17/08/2026 06:47, Ekansh Gupta wrote:
> >>>>>>> This patch series introduces the Qualcomm DSP Accelerator (QDA) d=
river,
> >>>>>>> a DRM-based accelerator driver for Qualcomm DSPs. The driver prov=
ides a
> >>>>>>> standardized interface for offloading computational tasks to DSPs=
 found
> >>>>>>> on Qualcomm SoCs, supporting all DSP domains.
> >>>>>>>
> >>>>>>> The QDA driver implements the FastRPC protocol over the DRM accel
> >>>>>>> subsystem. It uses the same device-tree node structure as the exi=
sting
> >>>>>>> fastrpc driver in drivers/misc/. The approach for binding the QDA=
 driver
> >>>>>>> to device-tree nodes while coexisting with the fastrpc driver is =
an open
> >>>>>>> item described below.
> >>>>>>
> >>>>>> No. Grow/replace/improve existing driver instead of coming with a =
duplicate.
> >>>>>>
> >>>>>> That's a standard upstream requirement, basically given on every
> >>>>>> upstreaming guide.
> >>>>>>
> >>>>>> Please watch old talk from Greg - "I Don=E2=80=99t Want Your Code!=
".
> >>>>> Posted discussion threads here[1]. Would seek comments from Dmitry,
> >>>>> Srini as well.
> >>>>>
> >>>>> [1]
> >>>>> https://lore.kernel.org/all/3476b5c3-7983-4994-a901-3d7d8bd75255@os=
s.qualcomm.com/
> >>>>
> >>>> The rest of the comments is still valid even if you did not acknowle=
dge
> >>>> them.
> >>>>
> >>>> Anyway, regarding above - again, watch the talk from Greg.
> >>>>
> >>>> You have ONE driver. Not two.
> >>>
> >>> Long term, moving to the common driver framework (which did not exist
> >>> when fastrpc was first created) seems like a good thing.  But does
> >>> that not allow for some transition period?  How can we get from here
> >>> to there without otherwise breaking userspace?  Is there some other
> >>> precedent elsewhere in other driver subsystems?
> >>
> >> Yes, Iris and Venus where we agreed for an exception (two drivers) as
> >> long as new driver supports old hardware / features.
> >>
> >> This is not the case here, right?
> >>
> >>>
> >>> I suppose drm exposing legacy fbdev on top of drm drivers is _sort of=
_
> >>> a precedent if you squint a bit?  I'm not really familiar enough to
> >>> say if that would be reasonable/possible in this case.
> >>
> >> Growing old driver does not look complicated itself. The only a bit
> >> tricky thing is to present somehow exclusive interface to user-space,
> >> like usage of one disables the second etc. Depending on actual
> >> differences in that interface.
> >>
> >> But having a duplicated driver is a clear no go and it is well known
> >> upstream requirement. Nothing new here.
> >
> > Would it be acceptable as a first step to, by default (ie. when no
> > cmdline override/etc) for the new driver to bind to new compatibles
>
> You have one compatible.
>
> > and the existing driver to old?  Ie. have both drivers but only one
> > binds on a given platform?
>
> I don't see how is it possible to write such DTS, because - repeating my
> question - how many hardware blocks is there? I believe only one per
> given DSP, so how could you have two device nodes?

Maybe I'm misunderstanding something here.. I don't see any new
bindings with this series so my assumption is that the bindings are
the same.  What I meant was something more like "qcom,glymur-fastrpc"
would bind to new driver but "qcom,fastrpc" (which seems to be what is
used on older platforms) would bind to the old driver.

So single dts node, but different compatible strings picking which
driver is used.

BR,
-R
