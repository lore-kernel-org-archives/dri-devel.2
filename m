Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE30CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6065F113416;
	Mon,  1 Jun 2026 14:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fl2WHhoU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AX/W6Nbu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 556D3113416
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 14:39:31 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651BBCwd3128068
 for <dri-devel@lists.freedesktop.org>; Mon, 1 Jun 2026 14:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=VN4C3LVZuH1k7AUd4KK8MEyJP8WIXP8lg6sKthHlaQM=; b=fl
 2WHhoU2ZbOBnQayMN29RXuPbvfhRf7VSTallEctg+EVOpuK7OgxdBm1XKyW8KVTE
 2FmNSvRNQVGx1p8XxVrQ/Acsaz17y44FmnZf6SXtJAHS7yz6ptk3108QtY5IBJ57
 rGpDJvhLyR6ZpSbbxiv5Cd5Mx+Nx50TKvl7k7InzYMfbjxMf+CT/ouAgiL0kUY12
 hQjpPFe61B5qE52vZYVpldryQZ1paFipGZJISOzTfsMA4uSAHXUCQAf2UYW4q44Z
 m1eRBDEscpykCOKXssGcU4hCKIBbpc83YhNKgOd/8ieznHfQ15SoeqQ1iy/P0qG3
 yGRx31p+5FW9UFEHz3iA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh9010v25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 14:39:30 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-485aea3987dso4755641b6e.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 07:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780324770; cv=none;
 d=google.com; s=arc-20240605;
 b=JhTPPmup/TcC/8LDNP2uOEnfL+qzoOYffOHakM3RXKS4bjI6a96agJCByGlKVyFgrZ
 v64TNYdCtS6/kQ53tRi8dMrDi5GxUFJFN0gNyYGAzG/2fEwQIkWwnR+BwwU8A9xrelN+
 FkbKCq5AQLjLpjxcsmq9LLOLQJ71EHMT5yPbuJbCQMigqEx8WqQOcqea6p+rP5VYMSsq
 9UY6g7AR+bbhL/hijOIQpDu4OvrYwj5tj9DamTPUVE48PfBD01Qvw5vmrZILmJuoHo0Y
 ZXiH72BKIMgkewrF/RnAiSRgRrlVpo2fP6D3tRJNp252lneKXM1aCIfQCJqWMupueiEZ
 7U5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=VN4C3LVZuH1k7AUd4KK8MEyJP8WIXP8lg6sKthHlaQM=;
 fh=fS2Om71tsxsr6iPNcEErMsJJhi8wAyZzhK5MN2ATlqs=;
 b=YGl8T1HohfctGC7GOG2HbF4/X6GejIIq4rDYskJtJDd45F7rjAfXG+7njYTYKeuz5m
 tAevij1M64gURthx9HZd0V5bYNfBG00I+307ABHnmjKRXpG3AKaoNo/diiBUtYQGfpDJ
 IQTnEaOGnk8/56eoCD0Nkn/md/E/NwHwQGI8Q2MWMeccUlbmsTbIGzm4SQtnYEISplDw
 fXeCZYoZCVvcMU3/F+kmb1XkJnd6+cLMlugsxJ8MHkYbmvVlLVkHqN2Hs5IL0H6CZJlg
 jKren2zivW/jmgLEq4lSwRpdYhYT/wHE0bH8oCdpOmCNpKhyfotE2QC64lwcRrOto69K
 uCOw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780324770; x=1780929570;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VN4C3LVZuH1k7AUd4KK8MEyJP8WIXP8lg6sKthHlaQM=;
 b=AX/W6NbuFb6q/7Uc5MaYRzhOK85jG+jAB8crkgputRtpQK7AgN7sdVyaZQU5PHY4do
 76wd1ay3QRBvTwVdZkP4gTEvv0D8YRE5vTdKffaHyaO3FsIifWc48fK2oPjRgbZFugMR
 wOGv26izdnHHYkSE4PB31ajLMbXFIuYE7cxLqKP20n4dw9C/cEAKv8wGL4Wk0RVEmGnw
 qi41N59yx7ovmMlWuTNWjs+Op/1uvytXklJJMaBHhnXIZwG9lwy3gPo6J0w27K09BCpe
 hvVTk3xJB+6OVzMs/Q+q7OYu92XfKFiqrtom5G2bcj7yOGU4D5uIqETnoez3KPPcAynC
 IVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780324770; x=1780929570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VN4C3LVZuH1k7AUd4KK8MEyJP8WIXP8lg6sKthHlaQM=;
 b=BAIpYqBTmC7IQUxYYvVRFBlmOz6Zi1SXIKBsp4A2AIhE45HbxCeenQpv/VcSkjU9Dm
 fYiFQooKcSTO2vyc7b/bjfRNL6IONlyUc4oATdAlbOoM5haz7W018t3SyATYMGt72UOT
 ZoSn1s1IjphWMuQ9RvtGOKmmg/WDcTKbDDPP3j/syI158HzZL+1jm8v9QCt2Umd3sQNR
 jh1/5eGJHpBDpG2AeFP2AgsTnpEZf94PrDL1G8CU2N7YpLYEdAMdiGv8Ix3eFX+Hr3IG
 5ZxpvfKO9hz2ai5+I87VjUKvhSJG01vJ/Wkkg10Rr0dETTwOfeWwIdSAYmkSh+ecm56E
 nNPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PD1e2I2rvWyccM3bLjB+lN9X4x5W/M0qOSyTqPAvKcJ3VjV6nf2Bz9Ri3uB5LHbA56Y8XPTtxg50=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNqvuFkUsaFdPjGjMLXbzTAut7pXAs5FAc/dkX8QyVNZKErGtQ
 J8yNbkgj/hMQ3kWFgrTwRwluf8Gk+o6Yc8K1PYTzg1MH/KubM1VXEz1XxRQH7/xS0oFMt3aRLIX
 9QVMt1JVoEXvwfMiDTt+jDfwh+NIbq5Mhw9INULag2xksVec7kKEaSeTpnhTjkkTrKuD2eDlq06
 pITEwmva137v5otIvS6WVUXqYlVSc16SeI2txgQukIKsJTiw==
X-Gm-Gg: Acq92OEj8jGO7Kbk5+fjtyvs6MNL/WElSLRx8yNNgo47MLEpMocdQhvZkf60gF554iW
 mQKRerX7+9VIsOetYfe31UdOiUQhPwKx2oSwqOMriaMeAgQZJZ5+D2mUXPinFWBMvya5KPyc0bQ
 oAaQEj2ubjEPPZGso0LOVW20G9cFX+7ojzh/NRpppJ471S0NEhOD7Aojtyve+6tpkfIBX7yBBtt
 TCALR4H1cmWwQ==
X-Received: by 2002:a05:6808:1912:b0:485:41fc:71dd with SMTP id
 5614622812f47-485fb6a8ec9mr5078461b6e.13.1780324769633; 
 Mon, 01 Jun 2026 07:39:29 -0700 (PDT)
X-Received: by 2002:a05:6808:1912:b0:485:41fc:71dd with SMTP id
 5614622812f47-485fb6a8ec9mr5078428b6e.13.1780324769126; Mon, 01 Jun 2026
 07:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260528093437.2519248-1-hch@lst.de>
 <20260528093437.2519248-2-hch@lst.de>
 <5f7f90d8-cb32-4ffb-8f1c-0722aafbe869@kernel.org>
 <20260529135045.GA10647@lst.de>
 <5f3ba603-a6ad-4cf2-9a54-aebc10273c59@kernel.org>
 <58cc76e7-2348-443d-a989-2a06e61178af@kernel.org>
 <20260601113831.GA25535@lst.de>
 <d7b08296-7f6e-4d89-ab3b-04e43d04929e@kernel.org>
 <CACSVV00k-fxW6+waHNqvmYcnVNDkRexoWWprFzfayZfqdyMuuA@mail.gmail.com>
In-Reply-To: <CACSVV00k-fxW6+waHNqvmYcnVNDkRexoWWprFzfayZfqdyMuuA@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 07:39:17 -0700
X-Gm-Features: AVHnY4IeX3RPNliDvhMevHdXSnbKaPpqnSaYQnqMtv5VzgFC7cHejpPkwD8NES4
Message-ID: <CACSVV00dNWgpNVU5rB=Hmg+3oWF18yTyfKNr_tWesjoP1jMxwg@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=H6nrBeYi c=1 sm=1 tr=0 ts=6a1d99a2 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=dBKglsDaislA0vfKbgwA:9 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: yv4aYGwZUBou5EJBw0nLCo7MkoQECkN7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE0NSBTYWx0ZWRfXx1TMw8DiO25T
 qal2EUlr8FFv9JzR1eYmpeX/vUy+REsgCmxnHmmFRdL0Rs/ipfMv5amC489BR/Wq9/fjF5Rx8lE
 IhAV1KNJT9Zf7E0z6S85C8zrnUfYyXI1NBJzH6iEFuxenjpzJxp2pZrfpZOcsgekBrI1uKvLYwa
 fYCrSSnJ6oLA1WoFQphssw+qpL7k+nUUQ/BG2HtjIYsMYGNAdsnKf8heFzb4eNLRSOucJiYFjKi
 3O26jvR+1IzdCnaT95H9qshJDKNx8D1MWxWDNCS07N07guFI8kTLtuvVDCbLOr5V/M5snUZ6AOI
 3JGFCUiCUeV8Ae4tbIbcHejwA2+QbwlCMcP8gaVlxxM15/blmUOyIQR5POEHniNcz7wzn1tlVMM
 SfBIroh9Mcl0QPTzvjJTmLXNwUzALMsXrSrotUwjpwWqA550UE3XJwJRdiHVkPy7UUZdvU85Agb
 crDIer3b7at9nrXTDyw==
X-Proofpoint-GUID: yv4aYGwZUBou5EJBw0nLCo7MkoQECkN7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010145
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

On Mon, Jun 1, 2026 at 6:32=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm.co=
m> wrote:
>
> On Mon, Jun 1, 2026 at 5:50=E2=80=AFAM Vlastimil Babka (SUSE) <vbabka@ker=
nel.org> wrote:
> >
> > On 6/1/26 13:38, Christoph Hellwig wrote:
> > > On Mon, Jun 01, 2026 at 10:16:30AM +0200, Vlastimil Babka (SUSE) wrot=
e:
> > >> > kmem_cache_alloc_bulk() returning 0 was considered a success in th=
at case.
> > >> >
> > >> > Either fixing kmem_cache_alloc_bulk() (and the comment) or fixing =
the
> > >> > user sounds fine to me.
> > >>
> > >> Would it be wrong if we just returned true for size of 0? Would some=
thing
> > >> else break?
> > >
> > > I don't think it is wrong per se, but it feels like the wrong kind of
> > > API.  I.e. I don't think the MSM caller actually wants this, as they'=
d
> > > also do a zero-sized kvmalloc.
> >
> > If p->count is 0 then indeed there's a zero-sized kvmalloc so p->pages =
=3D=3D
> > ZERO_SIZE_PTR but then nothing breaks because nothing tries to derefere=
nce it?
> >
> > msm_iommu_pagetable_prealloc_cleanup() has a "if (p->count > 0)" branch=
 so
> > it seems it's considered possible. But then the rest of the functions a=
lso
> > seems working fine, i.e. kmem_cache_free_bulk() of zero size does nothi=
ng,
> > kvfree() of ZERO_SIZE_PTR does nothing.
> >
> > It seems to me kmem_cache_alloc_bulk() returning true for size =3D=3D 0=
 fits
> > naturally in this world and is less likely to result in a gotcha?
>
> I think I was probably expecting kvmalloc(0) =3D> NULL ... but it
> happened to work out before
>
> Adding an "if (!p->count) return 0;" at the top of
> msm_iommu_pagetable_prealloc_allocate() seems like the thing to do..
> if you want, I can send that patch (but traveling this week... so
> let's see what I can do)

Aaaaaand.. sending patch from hotel wifi doesn't seem to be a thing
that works.. but I've tested the following w/ deqp-vk cts, and works
as expected

----------------

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iomm=
u.c
index 7d449e5202c5..ef744d154bbe 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -332,13 +332,16 @@ msm_iommu_pagetable_prealloc_allocate(struct
msm_mmu *mmu, struct msm_mmu_preall
        struct kmem_cache *pt_cache =3D get_pt_cache(mmu);
        int ret;

+       if (!p->count)
+               return 0;
+
        p->pages =3D kvmalloc_objs(*p->pages, p->count);
        if (!p->pages)
                return -ENOMEM;

        ret =3D kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, p->count, p->pa=
ges);
        if (ret !=3D p->count) {
-               kfree(p->pages);
+               kvfree(p->pages);
                p->pages =3D NULL;
                p->count =3D ret;
                return -ENOMEM;
