Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CB9CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 11:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 349C410FC26;
	Wed,  3 Jun 2026 11:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyFYwlGa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N6Ucxz1k";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B294C10FC24
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 11:14:02 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6536RJ7M380244
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 11:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=19tJFy9lIf9VnTinb1+YfhqFSRdeYqD56zDrzVGVBoM=; b=Sy
 FYwlGagsxvh7ElOxJmaihXiqez53lfLpIWWl8M297FhjleULl5awjFAoM5CCEWiB
 JvXI+mZLsZQPYSnPNcg2ugnoQ/gJEUl8hFeBJujbGpipnoB6KK60ku7kENQ97OWA
 5Y/dnbMSMl+swmylyF04SqbWrrIOMrvp+538/VQuHGmfDt4QM8n6aJnQps0CPeQQ
 Zw5xpD95r/bTbUfArT1S42IVDtiPxePAIKB86A54NhuZ4lBvfoIlKToh7F1xnAco
 R3BVyIm8rwKaAb/B6rU2fDdMyufOt99LQP2nwge0bnpH662XZoHu41TfCP8gn3UN
 eZaHisN6F0jKdQZxaU/A==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejewhs6u2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 11:14:02 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-43ccd5d5357so4233421fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 04:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780485241; cv=none;
 d=google.com; s=arc-20240605;
 b=a+bn3iq2J5xW8Vids9XnYQiZ66gVjT5lfQTVK61RJqt/FKTyaZb85wAZig2/RGHUfy
 O71RYbxFhpObxBV+pow+bg0SZBKseNCPE5vmy6z9/pre9B8R3fdkvt6fBnRPM27hhpxG
 wvKIorUZ2nPaA/wBMo/NyQmpUjZ5/r8I6ovZk/7REDXgJo/RVeR9uVSUg2atc9iMwyDg
 VHViTrWAzb053fToZIdVWHtxMfV76eOMfppsZnH0bBxEsBylg3i5GrayJhYX39CFaGRj
 2bK/cxG99J+1Ph9LeIMk7olhhudMUnINmW1HaQPClUezqP3jzeTmSB1kvSQmbONktAz0
 g3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=19tJFy9lIf9VnTinb1+YfhqFSRdeYqD56zDrzVGVBoM=;
 fh=qcaXO7vSd/y9sPb5iWdLQMSsgfZpWJY3d46iCXuKmbs=;
 b=SB95iwiENGqM3ZoYiL+bNXTuBnVFX1u1BSKHvZO/ckc43jk7uPdpDNQz7OVy2o8lVv
 rTzBn12q7Y3QsX1DtKttO7JaLWh+0OHeoLci7UZtGbMoSbmOaXyKXI+C7VGZmnqQSQBH
 14NQZ96iHT4ceSTsSjPjvjCKL+7FV3CPcxl4r+Uo3reMFlzBsUs0LQKXQtltKoqw5if3
 Zke1CIHayIJNSiIhgoXfULS5I28cssoERA9uc0hppr7IPgIbRN2834A6A7ksnIkZwsF6
 9B6nXOjKO9x7gsNqinO1GjWbwm5bfPkB4hGsE4Tr7qI+LyfegXWdajpUsr8mk6oCu49L
 ydSw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780485241; x=1781090041;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=19tJFy9lIf9VnTinb1+YfhqFSRdeYqD56zDrzVGVBoM=;
 b=N6Ucxz1kfKHYQM+Ga7G6zGqglrQLVAXrLYA1HxAFa5qPNxuHdm3otMfFC9gDSCVZjq
 wlDSVMn4yT3VpeK9dlxrG8VXdegcjM0zuhadaRgMchYVv8c1wCovFFklV9F/VRCNShRw
 rij55L/FuPEsIGqYAFCRtteLL3dkdrgL8htSy9CEg6BART121rN4zAWw9QcweiVR2pRB
 EFU1k+qoHe7l5Kngtcgnau0E1uCJNlzDwmGHyeEaVWG1bwDG0ayfLzhH6AbvZBz67I/i
 K1mT13Sky59fonRNWN7fou3xrszLTyYPdYZJ9/9yEHrCz7cX1SqMh6AsJJPviHFJCqvI
 lSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780485241; x=1781090041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=19tJFy9lIf9VnTinb1+YfhqFSRdeYqD56zDrzVGVBoM=;
 b=Nsi+6NGQfi3WlDAQ9G7JTiA496g4HMUrv4zDaq1kp23yBmNCG42cYZ4vj77HCZGuVK
 +nNFVTuvq696d4cy0bZSX3iL4i8GNDRnNg9wbz6+Nujs7kDXJb/zaanOl4v+uCLklemv
 i2G7ykCSCbZQxE1iUO3KndXzOmwKMyMlBQ2NnYP/sRWT0Qy8YCae8e/wZtoRWH8Ts+LZ
 vZxD98yQfv4zAv+vbbNkTadM12bCWKcu8ohUyIGtX0k4KPy8dkXjNIC0xLB/A5rb4w16
 Cksyvlu9uG96qfT1+iH8o+nmK2HASCebm58NX60fshoEhVAkocpZih9Y0YNRvArS5lxW
 HaQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Vl+scj5JMSEF+wk3CevfhtNnyPzbS60bsbET5QfxqMzixbl04Sb+IYcbv7+Rxnpa4HKHE32SV7rM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxL2fW2LSZDJs/W+etGJpO6fC8E60o3j1GvN1tkThK08B7hH5eG
 c7qlvsk/DuF/9jvuyM5NPy4/YanCX7Y5qP3QTyWK4srx1IfZNAwyKalq5yjpR+zfdmqJ7NC/0WC
 9KbJuWxr5Ebgz9+U6mdJ2GXpBjtk0vbPzz64u9eEgPFWfUtHlqv9TNblYYLxOUQ+yzIz6V7+MIV
 v39OfIspw2H67MdNuZVf12iEdB/yw5obWii57tXChpPkd4uw==
X-Gm-Gg: Acq92OGxcBAInaMAD+dY7+u8anKCcN37dO77hFIP01oDEPjshFtI9ERWiMsavZKlsAw
 BmguJr5K5LttE9aPzKpC9WK6qT8RzkpCs2Wuf45CjKS/63faBrxvSUYJ7bceMr62IJKwiSDSqH4
 ZFDjzOHoeDPmEkiq4ZMnWNn4owAN7TnGJQ3aNDF1dnkXEL4meNGLbsGyeQVQcIv3UR7tkT4NXda
 fsFkgXmG+6Zp6iVrA==
X-Received: by 2002:a05:6870:171b:b0:439:d504:1465 with SMTP id
 586e51a60fabf-440db44d16dmr1912782fac.5.1780485241394; 
 Wed, 03 Jun 2026 04:14:01 -0700 (PDT)
X-Received: by 2002:a05:6870:171b:b0:439:d504:1465 with SMTP id
 586e51a60fabf-440db44d16dmr1912767fac.5.1780485240990; Wed, 03 Jun 2026
 04:14:00 -0700 (PDT)
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
 <CACSVV00dNWgpNVU5rB=Hmg+3oWF18yTyfKNr_tWesjoP1jMxwg@mail.gmail.com>
 <5e6948b3-d235-4b61-aed7-e8b4d0f5b452@kernel.org>
In-Reply-To: <5e6948b3-d235-4b61-aed7-e8b4d0f5b452@kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 04:13:49 -0700
X-Gm-Features: AVHnY4L4Mu1tTTnLDgXjw8iz5Wj3eHB3OSZ6g8qAAhd22vyCAP_N07hQtlCZoOc
Message-ID: <CACSVV02v0Fuc6=Rqyd89D-_tcSjEXuQmxz0+2-4aoRAEwJE4zg@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEwNyBTYWx0ZWRfX2Sdlurr68EPY
 9jgEO3E2FnIYsWqrAt4wyKkMLCz8TKlFgVrRMLuECySocU6ZCdFT2H5KxdA4TALOxcANH6VR3HK
 jJ8zw7F3UydatvpJvIYxc+UubzVM1jkV4/oQP83XzccHmatJXxOe5Ay8GwHoSjJm48zov0qfalH
 8F/bWJd2c8PG/TdQU//E+/Eb+T4xhtDtZR8predPdcUOlfHmL+/Tiy1B0UfWhXcio955S5Z4hdE
 obWxyPttXy/EVK+e/6JrAkbgQVVBrQdeKNK8P5lpXwwCnfxh0LBOj6PDxCczDFIDeNwTtjw+Ovd
 IcUg4CSntTupzVq2A1cq9vYLXQyXcM1qM9oQ9LO0LmNVyDI8m3Nt8TGWrEDpVax5xtUHBfSUiLY
 G2WVEEr+shprrn+yXSLwLLGgtFTiCd49ziQ7JMxH04qiV5q4SzD/KbdCtqeGA/FlTFYJaA2eQlc
 zI1Z7s/OjdiBzt1rfLQ==
X-Authority-Analysis: v=2.4 cv=Zewt8MVA c=1 sm=1 tr=0 ts=6a200c7a cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=8jdotb935GZv83SU0eMA:9 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-GUID: X6IwnH5lTxkQDhZPb763pezgmIYv8xGK
X-Proofpoint-ORIG-GUID: X6IwnH5lTxkQDhZPb763pezgmIYv8xGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030107
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

On Wed, Jun 3, 2026 at 2:17=E2=80=AFAM Vlastimil Babka (SUSE) <vbabka@kerne=
l.org> wrote:
>
> On 6/1/26 16:39, Rob Clark wrote:
> > On Mon, Jun 1, 2026 at 6:32=E2=80=AFAM Rob Clark <rob.clark@oss.qualcom=
m.com> wrote:
> >>
> >> On Mon, Jun 1, 2026 at 5:50=E2=80=AFAM Vlastimil Babka (SUSE) <vbabka@=
kernel.org> wrote:
> >> >
> >> > On 6/1/26 13:38, Christoph Hellwig wrote:
> >> > > On Mon, Jun 01, 2026 at 10:16:30AM +0200, Vlastimil Babka (SUSE) w=
rote:
> >> > >> > kmem_cache_alloc_bulk() returning 0 was considered a success in=
 that case.
> >> > >> >
> >> > >> > Either fixing kmem_cache_alloc_bulk() (and the comment) or fixi=
ng the
> >> > >> > user sounds fine to me.
> >> > >>
> >> > >> Would it be wrong if we just returned true for size of 0? Would s=
omething
> >> > >> else break?
> >> > >
> >> > > I don't think it is wrong per se, but it feels like the wrong kind=
 of
> >> > > API.  I.e. I don't think the MSM caller actually wants this, as th=
ey'd
> >> > > also do a zero-sized kvmalloc.
> >> >
> >> > If p->count is 0 then indeed there's a zero-sized kvmalloc so p->pag=
es =3D=3D
> >> > ZERO_SIZE_PTR but then nothing breaks because nothing tries to deref=
erence it?
> >> >
> >> > msm_iommu_pagetable_prealloc_cleanup() has a "if (p->count > 0)" bra=
nch so
> >> > it seems it's considered possible. But then the rest of the function=
s also
> >> > seems working fine, i.e. kmem_cache_free_bulk() of zero size does no=
thing,
> >> > kvfree() of ZERO_SIZE_PTR does nothing.
> >> >
> >> > It seems to me kmem_cache_alloc_bulk() returning true for size =3D=
=3D 0 fits
> >> > naturally in this world and is less likely to result in a gotcha?
> >>
> >> I think I was probably expecting kvmalloc(0) =3D> NULL ... but it
> >> happened to work out before
> >>
> >> Adding an "if (!p->count) return 0;" at the top of
> >> msm_iommu_pagetable_prealloc_allocate() seems like the thing to do..
> >> if you want, I can send that patch (but traveling this week... so
> >> let's see what I can do)
> >
> > Aaaaaand.. sending patch from hotel wifi doesn't seem to be a thing
> > that works.. but I've tested the following w/ deqp-vk cts, and works
> > as expected
>
> Thanks, I will amend the commit in slab tree with this as the easiest way=
 to
> go foward.

Thanks

> Just a quick question though:
>
> > ----------------
> >
> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_=
iommu.c
> > index 7d449e5202c5..ef744d154bbe 100644
> > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > @@ -332,13 +332,16 @@ msm_iommu_pagetable_prealloc_allocate(struct
> > msm_mmu *mmu, struct msm_mmu_preall
> >         struct kmem_cache *pt_cache =3D get_pt_cache(mmu);
> >         int ret;
> >
> > +       if (!p->count)
> > +               return 0;
>
> We know p->pages is NULL in this case, right? Because it was allocated by
> vm_bind_job_create() using kzalloc().
> And the job can't be reused with a leftover value?
> (msm_iommu_pagetable_prealloc_cleanup doesn't set p->pages to zero).
> Or should we set p->pages to NULL here.

Correct, the job is not reused.  But I suppose setting p->pages to
NULL would make things more obvious, so no objection to that.

BR,
-R

> > +
> >         p->pages =3D kvmalloc_objs(*p->pages, p->count);
> >         if (!p->pages)
> >                 return -ENOMEM;
> >
> >         ret =3D kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, p->count, p=
->pages);
> >         if (ret !=3D p->count) {
> > -               kfree(p->pages);
> > +               kvfree(p->pages);
> >                 p->pages =3D NULL;
> >                 p->count =3D ret;
> >                 return -ENOMEM;
>
