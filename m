Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA73CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC15113E91;
	Thu,  4 Jun 2026 09:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gkwQ7pQG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XDclbqvb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A281F113E8D
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 09:37:08 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6547Ksvv1476664
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 09:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=LbH2Ej66t35eFH01LN7Yn1mCVFPgBbI2BNIp23nOi0I=; b=gk
 wQ7pQGrydVH4blqAd03q/e5Ae1bc6NbOQrmi8+rkuGoe4hzxNhqsJTwdZ7wdW/+N
 qDxXNeOTPUwizWZs2hH9w8/Dguipy6CaRuCRoLEcFNj16hvzbndv+YDWdp5V7tbO
 myZCEQ905ekyZ8KmSkGZ4nHoSkeaSZo90THNZ8f1Ow09YhZkoFIQTeHNfhZw9Vx4
 PFfg/aVoZC4rsLW1ANya/izCW3kjD78HPRL82MviYJ9f77AWmu3ujblBlbiwXYV0
 1gWu4CL/J3Nn8B9UV26DMYO+HnPLUwIs+kzQRLfroybnAOf5kfTrCEXsRYwhpABP
 B5FOeZZdPcS6JqR0hCZw==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejp6nv2h0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 09:37:08 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-440e399d049so466615fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 02:37:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780565827; cv=none;
 d=google.com; s=arc-20240605;
 b=k/wEZK2ezkgxrjnTd9NFMXju6c1sz33yzwkUPSrHkFgYoVMOtFwMkIm5locTrqZo/9
 R6qaTEuRLDyyfVKQICPoBx79o9dZXb3Zh1vDkd3sM0TguoOpU1jCLND9OjgjjuylX3uQ
 BBcbVmeG088ccHsWC5tsRXE0qQaTXq4fJG42wJdFgB63IQamZFJWorIxeRLlSZbYfT1t
 oYMNvwewwsrp1zGtONyySr7hGJTwYCL52dfkrC3XoXcaagzJb/QSNHdhRd64DKMcmE85
 sn3QQjyHePuwF2Cjm5ptd6m4pvtLSPp/+v9sdxmiudt01eo0VcjtbfaaD1jNcbgtQbin
 2cQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=LbH2Ej66t35eFH01LN7Yn1mCVFPgBbI2BNIp23nOi0I=;
 fh=C9uEHLcdS9KxH1Nn1/SP88nq86OJNqlEcNXD6svejuw=;
 b=CfmdCiRfF7ZX5le7NlTIMZQIrH2W4irQDwd4OdJbqzYkSUv9Sbfg8ALVjXCc/UH8Is
 5S2knedBiAY6It36LoadTUJRYrpU5K/KVkXD6zqLE3Rt561Paavewd1ZHcQEPOSpVb2e
 tHWYZsgpQd8/GmremEWwKll5TBihHENyfcrjR0X2BQOomg3z9rFp/5OWf4cY3eQobw8t
 rlqpkZsUuVswOn129M0To1QLAAtEbx8h1KwwBAVEeO6jHB/YPYl4QzWNpVKWuiJxq616
 2CANlkyPu47ngDy0dQTsyzJbuFeO3w3uKuul5r+JmFihFFyj42WI9fdxp5EtOOdCrS7j
 MoJQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565827; x=1781170627;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LbH2Ej66t35eFH01LN7Yn1mCVFPgBbI2BNIp23nOi0I=;
 b=XDclbqvb7yerLT1XWFdW8wOOHgCj3wAhWThMOq6PibKV6I++GFenTQrETeQhxSmoAR
 BmJyj6k+rVARWLCZGPoQNdMprIRSgD9z9MwH4cSWOvo7hqwCGC0K5ezV4jZC0QaPvPFu
 g3whVF231+Na3Udwv5BDkocuhMXAmoanNskDm3YSwVg4Yt/Zoy0jmippEpmiJn5f7q0/
 Abpa9pNfav1u7uVVVpGklQD4TucK/L9f7d4bv0K77qYJJ9JXvlrvx3eNbmy1nxSVkXqW
 i5qY3MJdFqqAk68/KKnithpBlMTuERgag3O5Z/GuZTvvdNC46HTo7INiKjMOJx/yI0/z
 oESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565827; x=1781170627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LbH2Ej66t35eFH01LN7Yn1mCVFPgBbI2BNIp23nOi0I=;
 b=IsWDhVj89bfTntAWrqY8CylFvvmTqUIVVLseWin2baylFTYzFG1t+4kosF7UWEGk1f
 8mga9xcYbh3mf97Up0DkbfIF509hMHbrjCJ1UwqzuWWjnJM290rTPDpmDZUhNtisgPIn
 xMfceeos5W5+sfj47bjjd++fCkoIEJww5042lhd2hH80XhcQQOJzUZo8YDNggo7R/QLi
 k7aNshEjUUBvS7Op+OrWNfNxYIaaXsXPgvqGTIJZeBfDcFNBE4ktfo2Hm8WEpZofIOru
 7/4KiSpBbsOEG5uHzye1gbPkQnGpg6Lzznuis6h3DLgasr2v4t9XGdPEOmoLs0HJ32P7
 zuaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hW1YACJOhdhUGD3t/peBq3ROq5o+ghOjGVQRFnITmKnApbGsAmyqYRf9Yglt+P+4KCT3UykW/qEg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMKHbOaynvrAXn0dHT+ARmLtkQPKwWM6grpKgIrPv1C8gNT+Z9
 MALSwlb+MhAjnYhz5nFFwObJcXEzlHd5RPPAafYEgtwcWRzLargKhHocprXi3nCs5PTuArnqeuD
 0+qt2Mo3Q5X1Fkk84mEIoTrrcjdbtODOAElMg2fF45OwErnLks4xpr/plFqgEVUXvOilj1Nq8tj
 bbrGXvt6aFF0OStl8/nVODO07sqJe4gSZbhHkqhkef6nRqpg==
X-Gm-Gg: Acq92OHVoQqgfciwo6d+C9bOEw2yC3jpbTp1BPd4/bawd1aBwZh7BLg4RUdMU3BEOR7
 tszDAv2ZqT8lDgSCo5M+PfKKhZxzpOwe9Nu1jXiPZum45D+4Y116QmWIzaV0KWQLO+D5+C9tRqR
 RKkvzAFni1arH8awCywp4618Mxf1LFk+S2Jk4cu/Z+liQpJQ8X4CCMFg1okEXpl3xjeaczf2+r2
 9ot66zXE/wyFwzeEw==
X-Received: by 2002:a05:6870:d0d3:b0:43b:9922:9df2 with SMTP id
 586e51a60fabf-440db7cf55cmr4593201fac.21.1780565827204; 
 Thu, 04 Jun 2026 02:37:07 -0700 (PDT)
X-Received: by 2002:a05:6870:d0d3:b0:43b:9922:9df2 with SMTP id
 586e51a60fabf-440db7cf55cmr4593192fac.21.1780565826858; Thu, 04 Jun 2026
 02:37:06 -0700 (PDT)
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
 <CACSVV02v0Fuc6=Rqyd89D-_tcSjEXuQmxz0+2-4aoRAEwJE4zg@mail.gmail.com>
 <b6f6323e-6f5b-4928-b474-bd2743eac3f2@kernel.org>
 <f027078c-6a55-463b-8938-95ede02dca3b@kernel.org>
 <29bd5886-15c7-462b-8a39-f2ff25269ddf@kernel.org>
In-Reply-To: <29bd5886-15c7-462b-8a39-f2ff25269ddf@kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 02:36:55 -0700
X-Gm-Features: AVVi8CdLwF-PFxeKWBcz71YZzZxxEA0LQrJYMS3qkVqAqJLyt2EL9LT70o-g4fs
Message-ID: <CACSVV03Ez9uKw0WDm9G2HTfyXy8SLu9AFGGnY58z-GK+32DV3A@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Christoph Hellwig <hch@lst.de>,
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
X-Proofpoint-GUID: IpreccBR13cvQzwtePkg8ms7SqSUnUr3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MiBTYWx0ZWRfX+aXXQjBETc8x
 8v/ip7X+hStI044NIK/gAW3mo4sAWp56XBzFaM6KZaHZN/NAoq8Kz5AuLvpoQR1ci/tVTpG8viH
 /xHh9LnByoAiB+y7id1/P1kpqXkVP3XfmESHBE669Y+1qZibX+/uCXba6fF3VNxWtHSzEHPDtSa
 NyrpLA3KaWgct72APo31IxCWvAauh8k828qpYtMrBNbSEc6wYuHJtEHGBuv7CmHw7mBL+h9n+OU
 kLMnzvDqmXLhkrCv3qc0t+KjukPg6LoajauH/FPtptDUJJSEzyc7NOxnxFldkWPyephKsW3LRuz
 t6laaXhiLt2ckvKbMTtKaW2AjJFy0khUOytqYWQ7NupdBGzbXkzplpG0vTJ9ytU0Kf941zNfNtX
 icw0wnwJoUOq7W+///2ApGlDQTm2f6HW0hK/lQkMHdgp0sPkjDb4uywdC6htobm79PYSvU+sILc
 6/S/bgBGOipyyEr/OuQ==
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a214744 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=G_pyjxEXS8sYRXXvRXQA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-ORIG-GUID: IpreccBR13cvQzwtePkg8ms7SqSUnUr3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040092
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

On Thu, Jun 4, 2026 at 12:35=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 6/4/26 09:10, Harry Yoo wrote:
> >
> >
> > On 6/4/26 1:22 AM, Vlastimil Babka (SUSE) wrote:
> >> On 6/3/26 13:13, Rob Clark wrote:
> >>> On Wed, Jun 3, 2026 at 2:17=E2=80=AFAM Vlastimil Babka (SUSE) <vbabka=
@kernel.org> wrote:
> >>>>
> >>>> We know p->pages is NULL in this case, right? Because it was allocat=
ed by
> >>>> vm_bind_job_create() using kzalloc().
> >>>> And the job can't be reused with a leftover value?
> >>>> (msm_iommu_pagetable_prealloc_cleanup doesn't set p->pages to zero).
> >>>> Or should we set p->pages to NULL here.
> >>>
> >>> Correct, the job is not reused.  But I suppose setting p->pages to
> >>> NULL would make things more obvious, so no objection to that.
> >>
> >> OK, did that, just in case. Thanks.
> >
> > The kvfree() -> kfree() part should probably be a separate patch
> > with Fixes: 830d68f2cb8a ("drm/msm: Fix pgtable prealloc error
> > path") and Cc: stable?
> >
> > ...as the commit landed v6.18.
>
> Hm right, but realistically, can there be so many pages necessary, that t=
he
> array to hold their pointers would be over what kmalloc() can provide?

Pretty unlikely.. IIRC kvmalloc won't fallback to vmalloc for anything
under PAGE_SIZE, so count=3D=3D512..  which is more than 10x what I've
seen in practice

BR,
-R

> >>> BR,
> >>> -R
> >>>
> >>>>> +
> >>>>>         p->pages =3D kvmalloc_objs(*p->pages, p->count);
> >>>>>         if (!p->pages)
> >>>>>                 return -ENOMEM;
> >>>>>
> >>>>>         ret =3D kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, p->coun=
t, p->pages);
> >>>>>         if (ret !=3D p->count) {
> >>>>> -               kfree(p->pages);
> >>>>> +               kvfree(p->pages);
> >>>>>                 p->pages =3D NULL;
> >>>>>                 p->count =3D ret;
> >>>>>                 return -ENOMEM;
> >
>
