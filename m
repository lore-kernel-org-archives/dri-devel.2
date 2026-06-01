Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D58CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4284411334F;
	Mon,  1 Jun 2026 13:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PFt2RAar";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DuapfhhQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A8411334E
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 13:32:52 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6518fdqm4065896
 for <dri-devel@lists.freedesktop.org>; Mon, 1 Jun 2026 13:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=iSWiEO3+qeWSnedTIbwacWBgpl1B0hKJbCUNlgrD+t8=; b=PF
 t2RAar6Rx4C+bsZIRoMqTfW1WZG9nbsuJlWkqn83U135u0Z0bylMV0sOgc7F72gV
 sqKCXLPyNmXIQQ/LM30PPnvWdr+IvT+bUtFdYo+RGnFTWLchsKVSlh0FDoPSne/x
 pT8kRmrDo3AgwU10bbeSYRFnjrk+ckhVN2RePt2wOCFetIxgLNKUCdTFwqKwNPpH
 /4urPc305YRMDkPdekrkeylcnqus27uRpJqJZU23OIJXdUhw1wsfdevOrPX/7UiD
 bCTMtjBiSsut7/eI+6phiKEIvPexyRmaB5KOJrOAmfDDzb3RzByJ1NpduMDLwrt5
 I75z8vm444bwcKCfbr9A==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sws4xa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 13:32:51 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4863abb79b0so131774b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 06:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780320771; cv=none;
 d=google.com; s=arc-20240605;
 b=E2yjz3qcNuluxDUO1HUqwrPNk8tdTLTEOcX8Q+Q+Oha0XHos+HmVPuzRJ1AiuzM3uS
 6L3i0lBOX2DJWiw3FNKq8ANGMpKfkfnCcpNFfdvTpwZvMrRVlT3daXdGRJ6znDTPd/1Y
 A1JjmAk+oW8f+Nrz9qE/D6x2F0V/DvP0KH6YvURDn/222A1ooB7DyWucZejzJfCqXKXO
 Ns06pEEag11Hl4HiKa5r0lktH3CA7/uw48zbB2AaRhQjxJyVeuIVHwE5gb93sOifg9Uj
 WPVbb/qFcJHVxV89h4bJhhxj27jHVZSI42833JTvPYmG+KwOwXiTNnAgOwggvq3KrZOD
 MqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=iSWiEO3+qeWSnedTIbwacWBgpl1B0hKJbCUNlgrD+t8=;
 fh=YgvLJdChKTd4gKVMVV6lXZEBOoHG3entlpePM3mgptM=;
 b=URUh1mrrseAuJQNOFmXPYMO8SHQRc5d4vJ6y0bd1YqvME358/XQKLL/dh2GBb+HDLw
 z9AEVeqaglIRwUZv9f0fh8NYWg9IOV2F5kUFQSCrXtECdKhg2ZIeYik4Oh5GkmmQw3Ha
 YAYQ+RpHhXvwAr1qVrH2lXTkEeKUkt3UTm3rWDCDG7TVXdLK2Zv0nGBVnIDH2d2sh3s/
 uKmD9KNe12hblYXgjaM3+tJ3xb7+OCJcrJYJXNk4Z7Yz8vDm7goVsAKppMI6EB3ekQwD
 oeUNZ+Jbll7iRzIhIWTKwSZ/pzXy3Qpty4+wmfx6Rjakr4QFSlSG/M4B31d2jgjl/Q3l
 blKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780320771; x=1780925571;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iSWiEO3+qeWSnedTIbwacWBgpl1B0hKJbCUNlgrD+t8=;
 b=DuapfhhQiR94EHguw0bdTE1BPg00NYMyO4NNYh2acb6jaJY4LfgWgBO3V9yInOXCQ9
 qSNT0FFs/ocPVZkHqs+E7ownRKQqYqvdAeDI23/1QIBdmf25r7sPAjUelHNqQsyf+SGs
 H265KSIgec+uV0EdOGRN3LgWGc/jeW3StVzkwR4MZWWYcgUsvVDm6v542VFiwkRdtU6q
 TjYQbO8i6FilWznLrH1w3bmyyYE1hNJW4qdlgU1n59gQzdgV93vSgcff0uBs2qSKbSv6
 Qx0rgm4cEhsLOXmee4y9dYKngwPBfPhXZyNH1I9bedjvBQsWa/6ImXOGiG5K76YmLWXq
 PxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780320771; x=1780925571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iSWiEO3+qeWSnedTIbwacWBgpl1B0hKJbCUNlgrD+t8=;
 b=FgvlIVC9AmJcmjSAjBRv3xMVZvrxBgTYcHqEZ0Q2eZpa1Q0jNs25ZZ5uC5HWrHFoRM
 38TCcrSCPaBCMeimgze+0uc88ixE1CDxGUGfaNDQdyVORcvkFZPPxBhPw6InTsgJBD/c
 YcrCLsbCV4TNWRIR6ogJtNNEaGjtFWM2k91E/NgYHUUUIedHedSgYYrnayM+fv96jQSY
 RBtm+/+1zLThe56hMdgCwXZVKBQOi3ocfIiurB3ZVRo925D4oXH2DkrIAohkas6hGIgN
 2ROOlQ1odQ+Rx6Y7O4G41jZW/RzX+A3/egjycTvfUrpWqell0YsFdAqbFOmb3i/vlDHL
 YtAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9IRd8DEZ1AJciU7uQ8925hZXCWfgT4ySpATr1cdxu0q0QwMxQm+XRz5f3CIuzylgElA34RINTUfDs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5so2GgXnjTqacY+CWE6xeJUV011XUqVW+QDyWBEsN6ZJEkP46
 QNbMK+AykWV+wcdMR9vUOvIgbs4V+akXUEtKEl9DccbYQ/I/K2fCQ09d+ccWHUmHnMOw7khVgFL
 sr+aV48UiJVrjiBP2elmO72lOF3WErRKuE1SSpx18yEjfs+p3rWEGv1ni6UFB/xTFJoDIeVgne7
 Vzz3d6DOgUF45Kwh/7sPjwfO1HGEnyxTT+k90qhCwDTPlUtw==
X-Gm-Gg: Acq92OFwNL0vyztjpFztSkZ9eRlkqKaDb21j63JDfkxv5LzM/f2Qs0yUtGiAdiE64Su
 o21yrTId9X1GP8A3l/0Oee4UJNtd1kshGnaiv+ZaaqqUcFQT9Uyt6IYivoLO/N6JD03dB8Y+MVS
 ztguKjVJLO4z9UAbbmHr49PGKnI5qT7hA4Nywc4numDZP6yNOVbRb2pt1/nyZWpEFReml/YME8J
 waZBciVeonj2g==
X-Received: by 2002:a05:6808:c413:b0:472:c4ba:32d9 with SMTP id
 5614622812f47-485e73685aemr7697317b6e.20.1780320770641; 
 Mon, 01 Jun 2026 06:32:50 -0700 (PDT)
X-Received: by 2002:a05:6808:c413:b0:472:c4ba:32d9 with SMTP id
 5614622812f47-485e73685aemr7697281b6e.20.1780320770193; Mon, 01 Jun 2026
 06:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260528093437.2519248-1-hch@lst.de>
 <20260528093437.2519248-2-hch@lst.de>
 <5f7f90d8-cb32-4ffb-8f1c-0722aafbe869@kernel.org>
 <20260529135045.GA10647@lst.de>
 <5f3ba603-a6ad-4cf2-9a54-aebc10273c59@kernel.org>
 <58cc76e7-2348-443d-a989-2a06e61178af@kernel.org>
 <20260601113831.GA25535@lst.de>
 <d7b08296-7f6e-4d89-ab3b-04e43d04929e@kernel.org>
In-Reply-To: <d7b08296-7f6e-4d89-ab3b-04e43d04929e@kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 06:32:38 -0700
X-Gm-Features: AVHnY4IDUhXdIIQ59yCVYlfBYI5ZXqh2r6jh6SDaQfttaiXqq2hNkv_bQjj9LiA
Message-ID: <CACSVV00k-fxW6+waHNqvmYcnVNDkRexoWWprFzfayZfqdyMuuA@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Brown <broonie@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, io-uring@vger.kernel.org,
 kasan-dev@googlegroups.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a1d8a03 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=gxV2vm59AnE_F2JHV74A:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: yI8iznfP_iWTvWYHVDQfYjlJDuBfzc8a
X-Proofpoint-ORIG-GUID: yI8iznfP_iWTvWYHVDQfYjlJDuBfzc8a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzNSBTYWx0ZWRfX1S2sjqtevG21
 w6SZhZ61ZYKI8B9GhYpfcnqMPVhj8cx3liGXrw98wXYelokEiPIEZWt4q1fEFLcF8yJekoxnfxi
 B03LXfVDnuLTxyA3OEqSeWPbmbIYMEja3pyIBCqeNXUMjyGlz+jODzZirdRBPSBn8Yd9SDnpvNy
 VWt/K/77cfF6qO6GTySjuSYa9yoAyQiRzedRieqtd2cBABdkLY8iEcxulKVeFaUw9dQQ0XlTRrf
 yLJAHLBFGlxy++rmDiycajlrvoXF6gTxGTv0UKFED+xYnPp9gXX+mLk59/Rvg4hjMxpVBkQjyE2
 pu+7R2F2EOg/5E85K7EsIgZSqXglB8Xga2sSHqV5QWJI9cMH26YpLJTifAJQP8LH4lX8NSYhVev
 O3+w8SwdRQgAfpJQ0lTYS7EOMOXFp2F8FztCjOnaZgzO34WKRV39StVgCNY/iDgstwQj6lIXD2I
 w8SC7QJtuStI6UGT7+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010135
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

On Mon, Jun 1, 2026 at 5:50=E2=80=AFAM Vlastimil Babka (SUSE) <vbabka@kerne=
l.org> wrote:
>
> On 6/1/26 13:38, Christoph Hellwig wrote:
> > On Mon, Jun 01, 2026 at 10:16:30AM +0200, Vlastimil Babka (SUSE) wrote:
> >> > kmem_cache_alloc_bulk() returning 0 was considered a success in that=
 case.
> >> >
> >> > Either fixing kmem_cache_alloc_bulk() (and the comment) or fixing th=
e
> >> > user sounds fine to me.
> >>
> >> Would it be wrong if we just returned true for size of 0? Would someth=
ing
> >> else break?
> >
> > I don't think it is wrong per se, but it feels like the wrong kind of
> > API.  I.e. I don't think the MSM caller actually wants this, as they'd
> > also do a zero-sized kvmalloc.
>
> If p->count is 0 then indeed there's a zero-sized kvmalloc so p->pages =
=3D=3D
> ZERO_SIZE_PTR but then nothing breaks because nothing tries to dereferenc=
e it?
>
> msm_iommu_pagetable_prealloc_cleanup() has a "if (p->count > 0)" branch s=
o
> it seems it's considered possible. But then the rest of the functions als=
o
> seems working fine, i.e. kmem_cache_free_bulk() of zero size does nothing=
,
> kvfree() of ZERO_SIZE_PTR does nothing.
>
> It seems to me kmem_cache_alloc_bulk() returning true for size =3D=3D 0 f=
its
> naturally in this world and is less likely to result in a gotcha?

I think I was probably expecting kvmalloc(0) =3D> NULL ... but it
happened to work out before

Adding an "if (!p->count) return 0;" at the top of
msm_iommu_pagetable_prealloc_allocate() seems like the thing to do..
if you want, I can send that patch (but traveling this week... so
let's see what I can do)

BR,
-R
