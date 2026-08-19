Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECA8C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B71810E148;
	Wed, 19 Aug 2026 14:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GPeudUYz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g3An2BlN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B677110E8E5
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 14:38:13 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbfkX135340
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 14:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=OV4Etzi0F84EHavFR+Cnl8cEpGoAZCQzZFi7p8gpeMI=; b=GP
 eudUYzAmwpt46XExjtHoL24a2I/8JX5JZHI9Hy6CbC7dO1tazpRAgFP+VcfrugoN
 qQqsW9ubazohF9DaVxrl3s/LKRe5kznPmCK3LoVzh6vJ+iebuKHns765pvdU8/jk
 Lx7WZ4bv8UVCBWYHz3m6v5/GnJT2VNZ0ww0LUj8Ylet1jPbTbGqxlh474I7MyGKO
 RI1PPcRlaETWg5xn/0/ig7ssX0OVcLJI/cDW3vOkQPZjH9SybyNVUYXczHdUhTB5
 BQOZ3N3z7a1vzgCS4xi5BbzZii7NWgVe1Zsvy1mFlVQsrVsTo6F9HCwWhsQoGkSA
 JLDz4rujLqSxMRs9pEMA==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmbqd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 14:38:13 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6b1281dd14aso926839eaf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 07:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150292; cv=none;
 d=google.com; s=arc-20260327;
 b=jyDugqLp9mAwdep0APX2VI46vjEa8LbZUlyRutDRrYXBC1NboDoQ0NlLZtoNc79g0+
 sQCo5BRrF7LhXlbbh5DJd9lkSCHETnjM/tRmROKMUxspXisr3+hBnV/02+6ywDovQABd
 KEjbXJYpF67gTrJSk/evIQJW11k6rOSWIxaQ0Fdv5JLA3/uzVhY2QRskTyCA4AwgtfNM
 d/wezPD7qFoV3M39vgB+bA8C7MnpR4sGzoTG5nbsH357VLJzTUPtkMXzPVBu8xybOzce
 mMcOb8p3e0PbrPRVZl+LZExyw/o3gZ7kcpjAfkYvn32xeyxdMH+ejL7+rBb+ut9mB69Q
 azQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=OV4Etzi0F84EHavFR+Cnl8cEpGoAZCQzZFi7p8gpeMI=;
 fh=nrjkSSLHevP/AL/+NLb3F1+rvJNlRTjD1xSo/qPG1dU=;
 b=e2EjRDROEUUu8SVZ+J/nhS7epqMt0GekWK/K6vOMYkz8enwzZYb52bFf+7Hriob0cQ
 1462IJJbx0ce5npWZ1h+/NznOmepJShC9EMqMHmzHvuOJZOc2BxHNKPiAYe6rSBAFvQ/
 wCcSWoV+xRnvXUVYFO2TkPuwFK8hmCgRzp+gu5e3ZFyOEoPh/qlwzXcSWC+/Xj5UKGvr
 M7p8ebTbgY559VIfQ/+VAgCOqS6Dsz9EtjSiRBDTox7rAJ9tuyORUsy6U+77jp2KUL23
 ZFr8E54PEq/Lxnigl/+uJh9PcE9LR1CoaKRl8Fdco8J0A5gSVGvDBbmHaNgaJRLU/kZz
 stVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787150292; x=1787755092;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OV4Etzi0F84EHavFR+Cnl8cEpGoAZCQzZFi7p8gpeMI=;
 b=g3An2BlNUBesN6TfSU7KNZ7NfzaFpYTfqTALHWwAF/qyLfCTDmKk7OXctLTJ8wpX+B
 6jr3zfq+znl3YTvGXejJYETwasEr0URO1rT0Rks7RfgNeD9j7/SN2+s1c6ZH9N9/UpOV
 sjM6E1qcpsg3KRjAYCZWNEq19smIVNrfaqkZZkKW5JDcmrvqBXkTL7zKbIbJkB4Xy2OT
 r2mD4HjmOLCzFkFVJI8BZ+038Owo0uFMofGFVORFpYg6txszF2SvlTMEhjOcU5DCNMs3
 +XNNmpKzKlK8YGcscsuk+bJ1IRzffHIz3B84eLMmklEtymPZZE1c+W/cZzUt0YQMCXcK
 H1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787150292; x=1787755092;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OV4Etzi0F84EHavFR+Cnl8cEpGoAZCQzZFi7p8gpeMI=;
 b=SKs/EfwoBl2bpUAgJ862HE0lV5Z5EEwIz42as9SkKDesCu5m9dChFaqG50GTLLhKYf
 RUhkOudDeRGYfWWNcUdxYj6Vo8CFuk9msaaY1IFgUSVIeJ7V9e9AoXhajdyFiIgWany0
 T3Y8UtY6AYUW6nL89/c15aCKNm5kkR63fKlfVL4pAGoC/Pzyb7ih1EOBESHx2JcuoJV8
 r7shBCvnaQdVDFXZu8w9USpRdUsW5uYQ0OZQr49hjA5ZB60TkaaTFCeFu9A5uK9CjN0+
 QWrjzEy8jUIPS8O/SkQybRdkiv1q4biKRfLAfeAANwSAKM1sGEvjjjsMchm4g8cidM8C
 IUxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUaLomgV8HfBdkwBTxJq0BX+15K8UxhapsBFMqdfQQv9obmaO+dDKTbwGj/HCIKdd/DaYtrC4fnLQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjkTULIzbw4IEl/7ZkeyJd5MB9wnCd6PNYWCItiQM+5G6cCq9r
 xgnlduQEBbzBTgPd3UfJqQoM7Wi1Sxhacf7tDxFQhrUzCvZ3iw4XGIiBLc8sm39vgpB8IfnKpsq
 FJq0y8dBOSPTnP+AoKZJhDcScc2BKjZ004FVvGHUEgHUzzc34UmSqEnySa+vL118zA/OyFKO+Lq
 tPiKeDjm+nm8aGP5Y7CXuukKNByRcc0P23AE5pHiDCkODQjg==
X-Gm-Gg: AR+sD11UGeYF9R0hW22sDq8Jk/mkw5FOnmZyh0fuUdIHRVYNO1DJJsCGxxc/7Of4MRZ
 chVWLnfHoOAXWc0upBwh8lQNujJWkKX9dn4FBGRO4aKPi8zzjUOFDVx18vhxtsqcVYVbm9Eg/yy
 vEiRwOc02m62W6lgbrvXj1WLFF1L7ZSqyHdiH0xLMe/DHshtuvjhzTpzJA
X-Received: by 2002:a05:6820:1ca2:b0:6ac:b1ae:6ce3 with SMTP id
 006d021491bc7-6b13c69056emr3835938eaf.32.1787150292236; 
 Wed, 19 Aug 2026 07:38:12 -0700 (PDT)
X-Received: by 2002:a05:6820:1ca2:b0:6ac:b1ae:6ce3 with SMTP id
 006d021491bc7-6b13c69056emr3835876eaf.32.1787150291802; Wed, 19 Aug 2026
 07:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org>
 <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
 <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org>
In-Reply-To: <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 07:38:01 -0700
X-Gm-Features: AcwNN1UJH0MueaAt4fuAnOTplgnMr9BZwDd-FRtcH8UIxmOIWCFCFvjMK1YdptU
Message-ID: <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNCBTYWx0ZWRfX+obKXHbZKgwo
 6sRP6srkzStoI3kXWMMnYSaRT2IWw744+XgpEB4ETduio9vltOX5fusWLR3UarPAGjiaDcz8gmH
 hm9P+fT+Z1mW1541jopvFL0EqEggUVXidzHLIg7kkn/lZAhhu391s1TAnhHkxRteH2InfRCaAWm
 rXNGc3IRQdVdSBWIvgn+NZvIHa+qMc/RxCsIiCt8GNg5ff6Ee57Sbf1fcteD4YyW6yyaprkT8H5
 4w+MfSC1GuRQl7rzaKITWuKs7swAittl+zhaSPk6Oz6C1X2oPyafGI2oUVd1FryG2SBofCYpqU7
 CoOVFrTByQgBIeo5VpluQSvtfbAFtmW7fWcTtPGcU8Sj+CYf5EjslSjt0RYbA8cGq/eB8/9eEL7
 cXXPXzDe5xtS0ba0qqYZu5ng+7sKzigvJ/sNU2xkvWHVAcbTqRRapI7DGQ6124kPioadopvExQM
 VZ6zNJwTkLO35H1iV1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNCBTYWx0ZWRfX37YUWV5cC8Pv
 bmmTGwEFGOec+0VEcLs2z5GS4FmhguDBC2FdvGeQgUQhV7HGUt5nT3KfNGFKBG0fNB7O43p/Nic
 QOXjaLGq2Mlw+oZsl/GtSltgp73ArIM=
X-Proofpoint-GUID: KXiZAh0zzTNZJInrNGqOTnQ7zsIlmFcI
X-Proofpoint-ORIG-GUID: KXiZAh0zzTNZJInrNGqOTnQ7zsIlmFcI
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=6a85bfd5 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=OXa2z63zbhD_Ho30eBkA:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190114
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

On Wed, Aug 19, 2026 at 7:21=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/08/2026 15:26, Ekansh Gupta wrote:
> > On 19-08-2026 00:43, Krzysztof Kozlowski wrote:
> >> On 17/08/2026 06:47, Ekansh Gupta wrote:
> >>> This patch series introduces the Qualcomm DSP Accelerator (QDA) drive=
r,
> >>> a DRM-based accelerator driver for Qualcomm DSPs. The driver provides=
 a
> >>> standardized interface for offloading computational tasks to DSPs fou=
nd
> >>> on Qualcomm SoCs, supporting all DSP domains.
> >>>
> >>> The QDA driver implements the FastRPC protocol over the DRM accel
> >>> subsystem. It uses the same device-tree node structure as the existin=
g
> >>> fastrpc driver in drivers/misc/. The approach for binding the QDA dri=
ver
> >>> to device-tree nodes while coexisting with the fastrpc driver is an o=
pen
> >>> item described below.
> >>
> >> No. Grow/replace/improve existing driver instead of coming with a dupl=
icate.
> >>
> >> That's a standard upstream requirement, basically given on every
> >> upstreaming guide.
> >>
> >> Please watch old talk from Greg - "I Don=E2=80=99t Want Your Code!".
> > Posted discussion threads here[1]. Would seek comments from Dmitry,
> > Srini as well.
> >
> > [1]
> > https://lore.kernel.org/all/3476b5c3-7983-4994-a901-3d7d8bd75255@oss.qu=
alcomm.com/
>
> The rest of the comments is still valid even if you did not acknowledge
> them.
>
> Anyway, regarding above - again, watch the talk from Greg.
>
> You have ONE driver. Not two.

Long term, moving to the common driver framework (which did not exist
when fastrpc was first created) seems like a good thing.  But does
that not allow for some transition period?  How can we get from here
to there without otherwise breaking userspace?  Is there some other
precedent elsewhere in other driver subsystems?

I suppose drm exposing legacy fbdev on top of drm drivers is _sort of_
a precedent if you squint a bit?  I'm not really familiar enough to
say if that would be reasonable/possible in this case.

BR,
-R

> Best regards,
> Krzysztof
