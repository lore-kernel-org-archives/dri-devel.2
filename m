Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FEAC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CEA10E55D;
	Wed, 19 Aug 2026 14:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eLme8JwQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JSTd3/Ve";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E88510E55D
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 14:49:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbbRR158060
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 14:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=4rNpIpy4LtbyQ9Xtow0eilFdW8OjcFy/oDCBHiNow/s=; b=eL
 me8JwQK0gnd4E0UZMMlGf35BN58ld0D1S5FR4/hiSNXSXIxD29uqf2vrpsBHXPjx
 d9PATSuywKmGTK0IssoLyQ3nYDj52e+ZKi4vMX5YCORIKrn1TBdkjENHaxy4I9Tf
 EhQRPwdOujFdQJfuOIq9ktzzprkpUeWv5BnWKOtOp0qFSIsIi/9Y0PmGTqk4JrpO
 nhu6BwMo5nJPbzvlRvoNnPEOjerlIY8yXhVvvN3gEqVRxGpSCl6vToiotnzH9P32
 FnOi/m8QA5a7QSwo+jCuLakY1PKPY0T4EjhdsQksMMIpPQysdOh6nsgGFr9hEiYy
 9QCjJF2anT+fFc8qCrEg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yffkq4y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 14:49:36 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6b12e3edc28so600642eaf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 07:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150976; cv=none;
 d=google.com; s=arc-20260327;
 b=YjnZPSHWWWOkJkzts9wiqmXq6vLIZbvG9utQt4/hPyHi5HIHfTS2O8Ben8mOqBGyPP
 AezyqE+hPzQUnN87wwKfIhvbrVc+/KbQChmIMVO4ZNoP2OytVb8Kyj9lobehXcyFdmOt
 D7QhYo68TcetGFnjT2MJX9riEIQww38owQ3iz41RthwbllJAfQtyoRr/EDq4jjaSslTT
 5MZ6tUS5a+PhHwXRuDRcXABCpY3jdO2T7aBWHRlhGDbYGUs97MXyA8cYUV+Qig58Phps
 EQKzkOIv+lbU2oqiKGvMoUlMtozEGYy/er9Cu01WdhKU85CTG6tEJk+Rq1BKD2Q12cQw
 BSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=4rNpIpy4LtbyQ9Xtow0eilFdW8OjcFy/oDCBHiNow/s=;
 fh=LOYTiyiTyXjE7sGz9e1XpLiYzoauaDFjwhGWU9EaTQo=;
 b=TR0ZHi4sqDtnYeYpIkhmofUF5e4AOgPzHe4DjdGvixuXY+Td8D9kn9s8jXc9mjRV/U
 l3JiyDPxMzBvsMUQemULzPR/wbJQIFBvpqv96Gaw7WBNxA5gH8brw27L3t/CkwDINeNJ
 8dp5eS3bE3g6L7TOG2nC9aItO7yhTH0t7kFdoDwFYk9sTNRInIDAPTOt+az/pg88GzUM
 qdN5nM3yP/MPJl8F1dMM1aJ05OL3s+QFTF1lpOebw2gSJXxG3/t+Im7T69mZ4hGoVe68
 nbslSMpqdq3F90oFiOCDLrsrOv+8PyFvK33Z1nydOMAgc0dbtojuijD2dGo0YsO1w/FI
 1ciA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787150976; x=1787755776;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4rNpIpy4LtbyQ9Xtow0eilFdW8OjcFy/oDCBHiNow/s=;
 b=JSTd3/Ve6lsyVvB0+vphe1Sozrz+uk0Vx6u1D2V5s2LKceIu5c2kK8NHU+he9E2ro2
 FT3WeTTekeBYy8/73mxeqvPxNjc2JtEB88gEmZgEktaxcs/I4WAGOF20i2PhKRuY/HRA
 +NPr7M+OUZ+czaidSPXRRcTyceAV0Hnxe7aq4pHVgPB5a1K2gQp6nfFybPY2eli/mqKL
 tQF0tNHaxAFFpLEVeuqIVKbHEQU91lQz7GS5xUUX4qNSAmSN0hTTvYW9XGATuxLEAu2W
 bBNc8t4LJrX90G2WTkNsxl1BqjWxEl+0E+ylzB0vJj8t/h580nNNJcJ19NhNbDSYalm3
 mOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787150976; x=1787755776;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4rNpIpy4LtbyQ9Xtow0eilFdW8OjcFy/oDCBHiNow/s=;
 b=jjTs+VqS8tEx8zV7Yitp4wF84281RekYP9PlI9VRRiN8PImY/PnB0Kovic5SuR/M2i
 hCWxLjZstYq+ezYq/V5YkRXv2SxELQguhe9SEHI2/cJcZvyup0DSUUqJXzDIoEsqrgYC
 mK90wHB1fZmNZX/h5NaWUYB6LlR7tSQg9cnU5+yVxE1ua+DJCFgA7BzsLkEtxFNblsF8
 1oYhixYEXckEYHbw0AVbvS5FhpgzQpIJgBjO3KmOSRGD0fVxET/7TN57hhobtbg8Gzyh
 Kpnta9WpOqCoMrxGhQCfkEQctdqliFzFDXCRVPQQVgDfCfsnQrn9LqPF1QOX5M0MD32W
 0/BA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHjc87HgYsH7E0gR3VA5duF+D6SI76EMMFSywZ7VAt2s1v0SDL8Bk43T52YTJ+fM7qkwF5GBOC4wo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjvQVDxr8yKb+kVBwUYcnsGOb7KgqMJzs+awVOEoNWADqkhXpH
 wyJrueeflhcfzOkk/KXbt6YqYOLbI2D9SRmLhORiF/FlXd72Ike745QBMc+aJuvbOGzZACE6tDe
 hbS+BLOhYz5mrRPeBx1Ff1Azl/amUou7YT6xJmEBWAzHfqx1T4k9Xi9GoN/b4MHlzON9kfsLNNt
 bXE2UW/36pZAp+QrzNjf95Y1Jci0Io2iE9fP6PK2Y8q7ARfA==
X-Gm-Gg: AR+sD13NkhRpU85a8Cb8uPTD1aKutMk5pxFFJy/Fa37zb2Bm+4hgzigZ3G5OcR5x31i
 1MykcjIX6letOjGd6avq50GpROxmUxb1FSMZTgJB6XNGf4Vjy/21KbcCmVVC+GvY6qUn5dV3Qes
 CMQWXV/3KJR7aQw6NvPnx1fUnNkD7xnWy1uS/l0x2jDJLoKcuqUN4JEPXC
X-Received: by 2002:a4a:e917:0:b0:6a1:8c8c:abd7 with SMTP id
 006d021491bc7-6b13c3a41cfmr4766404eaf.16.1787150976072; 
 Wed, 19 Aug 2026 07:49:36 -0700 (PDT)
X-Received: by 2002:a4a:e917:0:b0:6a1:8c8c:abd7 with SMTP id
 006d021491bc7-6b13c3a41cfmr4766332eaf.16.1787150975455; Wed, 19 Aug 2026
 07:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org>
 <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
 <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org>
 <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
In-Reply-To: <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 07:49:24 -0700
X-Gm-Features: AcwNN1V5bfW_enn3TfGcE4UwPNlg1kyolZJsLpJh8D-Byx5y30oNV1d5dKRlS_Q
Message-ID: <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNSBTYWx0ZWRfX87UC8JKk8/6R
 VnBKstjkDTPcYCu/I1Y0MiR56Nc7j71NrL2oXKk9eYcnQpoasbWt8HSAFvBQGKljDupHFvhPXsy
 weIgd7psWW1Qg0C+1k8VvtD9G4tIQgQ=
X-Authority-Analysis: v=2.4 cv=H5PrBeYi c=1 sm=1 tr=0 ts=6a85c280 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=MVsHzMdaoZhIBd0MKPEA:9 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: lY4Uv2pgGnsMXtbxCjwA1hLQ4vGBM2RI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNSBTYWx0ZWRfX2189RoP8XfkK
 ExXoqEfUqvWiBkhCRxYe+ozq+MlzWBl14Ks/JDZP5D1SRTZrrAwdGrxybKz8EzQxI8hAyfe6Uyw
 UgKBahNzOBYm9UJdzpSExuhilqTCsLS5NXdBr36fQg4fD2u/y6/uXlscGwd2PiQ8mIyCZJJirXE
 kdjIx92WrxUmPNTAucv6JK6t4BpTfNrkzSXdeO0vd0Kwkap0ZVm06XK1eSnSGt2t8LOYttlsBWf
 V1JGhz30pr6jBLdWus58+WG/bzCXsdDaX3ZG/ikkoHrjYUjB1CIBhtA2eOuD20TbUED+OpJ4XRj
 c1N1/LsGSFquZAbRWMGgLmb2W3XrKUzCsorrkF+3viidgRYrxbcD09krO7hFEIelRO3Oj1cwQIJ
 S0KSgihBITX/Ok3vGoe6DVrfj3sMbR91m44WQtppZK80PRPObObu7Pflop/Dq7y8S4SzpaP1bCZ
 UyFqJUPkyU5AZ98wWJQ==
X-Proofpoint-GUID: lY4Uv2pgGnsMXtbxCjwA1hLQ4vGBM2RI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190115
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

On Wed, Aug 19, 2026 at 7:43=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/08/2026 16:38, Rob Clark wrote:
> > On Wed, Aug 19, 2026 at 7:21=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 19/08/2026 15:26, Ekansh Gupta wrote:
> >>> On 19-08-2026 00:43, Krzysztof Kozlowski wrote:
> >>>> On 17/08/2026 06:47, Ekansh Gupta wrote:
> >>>>> This patch series introduces the Qualcomm DSP Accelerator (QDA) dri=
ver,
> >>>>> a DRM-based accelerator driver for Qualcomm DSPs. The driver provid=
es a
> >>>>> standardized interface for offloading computational tasks to DSPs f=
ound
> >>>>> on Qualcomm SoCs, supporting all DSP domains.
> >>>>>
> >>>>> The QDA driver implements the FastRPC protocol over the DRM accel
> >>>>> subsystem. It uses the same device-tree node structure as the exist=
ing
> >>>>> fastrpc driver in drivers/misc/. The approach for binding the QDA d=
river
> >>>>> to device-tree nodes while coexisting with the fastrpc driver is an=
 open
> >>>>> item described below.
> >>>>
> >>>> No. Grow/replace/improve existing driver instead of coming with a du=
plicate.
> >>>>
> >>>> That's a standard upstream requirement, basically given on every
> >>>> upstreaming guide.
> >>>>
> >>>> Please watch old talk from Greg - "I Don=E2=80=99t Want Your Code!".
> >>> Posted discussion threads here[1]. Would seek comments from Dmitry,
> >>> Srini as well.
> >>>
> >>> [1]
> >>> https://lore.kernel.org/all/3476b5c3-7983-4994-a901-3d7d8bd75255@oss.=
qualcomm.com/
> >>
> >> The rest of the comments is still valid even if you did not acknowledg=
e
> >> them.
> >>
> >> Anyway, regarding above - again, watch the talk from Greg.
> >>
> >> You have ONE driver. Not two.
> >
> > Long term, moving to the common driver framework (which did not exist
> > when fastrpc was first created) seems like a good thing.  But does
> > that not allow for some transition period?  How can we get from here
> > to there without otherwise breaking userspace?  Is there some other
> > precedent elsewhere in other driver subsystems?
>
> Yes, Iris and Venus where we agreed for an exception (two drivers) as
> long as new driver supports old hardware / features.
>
> This is not the case here, right?
>
> >
> > I suppose drm exposing legacy fbdev on top of drm drivers is _sort of_
> > a precedent if you squint a bit?  I'm not really familiar enough to
> > say if that would be reasonable/possible in this case.
>
> Growing old driver does not look complicated itself. The only a bit
> tricky thing is to present somehow exclusive interface to user-space,
> like usage of one disables the second etc. Depending on actual
> differences in that interface.
>
> But having a duplicated driver is a clear no go and it is well known
> upstream requirement. Nothing new here.

Would it be acceptable as a first step to, by default (ie. when no
cmdline override/etc) for the new driver to bind to new compatibles
and the existing driver to old?  Ie. have both drivers but only one
binds on a given platform?

BR,
-R
