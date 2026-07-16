Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98999C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E05EF10E379;
	Thu, 16 Jul 2026 20:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="G0tBoJWd";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E80A10E379
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:09:13 +0000 (UTC)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJp2kN4034731
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:09:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=fyZCLJIQW6xH8mOeeNx9UNPdCdkhruJNt4u6M+kl3Po=; b=G0tBoJWdvaDk
 Wz4me9U9EmzdxbVYlbLVAfjJCP27d6V5CRGhDCsQxHd1wC51VEIW5NDlLtPdhtid
 Y3QFaqMgURyUh0GfmaRtX7cvFRuYL/eUy7XWGSK3W1UnNuGcmMhoDVxFZhjVwFdj
 Y0SJW4IzIYBm2nOniFrlhPh4CgIXlUL6NYUYlHM5wq/J4bRwQDAxtQyQEQjDAlw2
 I9nTh3mwe1qX+xfUsDbEtUHrMMFEyBk5OmI7ZaemvGPdpXU1zn1/SUSGNVDz9JhF
 gyGozHXiVdrg4wtKnjIXepWNvHOqU/PxZvm4VTQ9a9r/fvoy4pXcJNqU6imFJJms
 GDfW2AvWUg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ff0s0jas8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:09:11 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7eb711362a2so5157360a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:09:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784232550; cv=none;
 d=google.com; s=arc-20260327;
 b=TWNWHvJudirs7ow39eiz/JZdOcM1Ica8jwc5w8NDJ7cr2UztKGLeAkcnnu2G6XRR+0
 qttuA55j/u9B7Cktzm3IrZxQ7mvSf7aT/27k53Zdb+kKmhV6PkqQbHPkdKYbzMcmIUYL
 IrItMNO+Q2e34aA7MxukUcyIip0PyLohPCikVSXJQlmEeJFi9AlKmM9Te6Nl8D+DqHRC
 GOYTjHcoNhRWvwHvJm9MSLnQJpMsDJKLt4kXQ5v9Pscu/ltTW9by+ahEkxnt4yjaeTT4
 yagj/jYeHgVfTOD8BO5qzWU7utL5s2MPQyGe9LKm5jzslR7am91cKGMpNT0tTlxn0gDP
 iA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=A/MBU9UxYJ0LTf7N8/pjvYID5QVas5vE3ImYU9370R0=;
 fh=UtxHx3XOG6kD47jOTRUbeVQAFzZm0MoV8hXAXcBN1KA=;
 b=Bsugc0vMO5L0yTuumQalUxrkebtysZKZl2UMvH3YPtk7eAO/PWyIp2Ymg687URI1VE
 zojUJ9vX4zDAKo9bQY4ABjh2StQg1ptfbJgmuHLwQ2Zye64/u3IQB7pUUb35AVhEqPZS
 EqqknlI5bfBuXSdUuyDsgZIbF1dyCq2p3xFuDSdg3XglIwLoSgSCFFYzkDdQsIAsEeP5
 m5tsjtylPWoFjHVEKNNiQjDdADQe3a3XM2zp2fWgDwF2kg/E+/6FNAEqtvgWnfE8K9QZ
 VBSqT10fON42ebV/ZpLH0vK2O3YKPeBGtoejP63kmopcBG2quUeT+ifFH5UdnpSQVxUE
 uqSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232550; x=1784837350;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A/MBU9UxYJ0LTf7N8/pjvYID5QVas5vE3ImYU9370R0=;
 b=iDo3jdqIgI0AHN7pmgjnF3KBJeIZ+qNqNnP1yep2Yx66w0g1MIJPMJ5e6J8IZH8ZVs
 GytIrFSJwIiOVluJ4PwI12L42YuwxBhTciZbGFY5sB/squHpiP6fTPoMJoy5/nbvwOej
 KeBfu5tX8NxzmOHwHc1gl5IApc8Y24Sta/z+0cwVq9NXOR0Qed5Qga4Dm0Yj5mmJslP/
 ga3SDN1PFOf6V1wAM36LPcBvNjMHnjzAVv91m6F+7Vy++ox4MmrPH3JiY+H0fux5eXWb
 obLKPQcVXKsC7j4iopPajpKKWWiqsS714vyw67GIztubenQZKoenUceaku83uZ4eXiZT
 SeoA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOIM13Oi37x4dTdLVsWjd7M5Zey2+J/EUJgcehBAZS0wzaOJKsNPU8VDrATlPgQvlrH/nM3Dub3y8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxit+SWfOVy1mWVftMdpl0dOCZPgPnqroWi/y7BnltWAvXwOMWT
 vKBKJp+oTRw/cVKUAW0PDuHUJF9tOa8q+5EUD13RFu/W9w6PTxP3Lf7arQgL71wyh+VPqoPgPde
 lcnQbKOiVPbziEYpXgXu60Kvh60W3tJvvxvSGCu+0/Aiu4G2lY1rLLqzak1fnb5bVSwi9foiOSr
 IqPpoIfw8et42B3g9m7yWi6lX9q/51KBoqukymSJz1dy8=
X-Gm-Gg: AfdE7ckb4CdZ/fxEB+JdDZVjzDBoqbfFqrHrqt9kHk4Th5Ffalo/kEtr2ZrboThmzbK
 onwvdgWGSgD3RMAgyxNz7abR+zRQPKUZSq1zmOf1SpJbxnbTPKCe5pyFDm0CuR2fccr3r5w79s2
 HBkNcFT5pVmwgoJmNdJdcTGDyx/E+H5W3X5ZLB818aB46cm96N5FVaBD++ifej1A8rKtkYAe6g7
 rybee6oF4/3a/mfo0A=
X-Received: by 2002:a05:6830:6aeb:b0:7e9:cc39:2ef0 with SMTP id
 46e09a7af769-7ec59cc5592mr5232593a34.18.1784232550371; 
 Thu, 16 Jul 2026 13:09:10 -0700 (PDT)
X-Received: by 2002:a05:6830:6aeb:b0:7e9:cc39:2ef0 with SMTP id
 46e09a7af769-7ec59cc5592mr5232532a34.18.1784232549056; Thu, 16 Jul 2026
 13:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260715204008.3911275-1-zhipingz@meta.com>
 <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
In-Reply-To: <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 16 Jul 2026 13:08:58 -0700
X-Gm-Features: AUfX_mzMEcC_t0EX7NJOVZpINMLBmfJ4Fcr0yjX2dQzL33Xd9YvVjPxD4eAksO8
Message-ID: <CAH3zFs0Wbz5EYUMQArmUtT-jdAtisafw6e89RWKZJrJpipYQoA@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=DZ4nbPtW c=1 sm=1 tr=0 ts=6a593a67 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=i0EeH86SAAAA:8 a=G4JgLt0UOHroHTRVxaYA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX+uKfSQk5+qBq
 p8GUKDZbLO8NqHOs0Q1HgBgE2FBQbXpfbso+nJvXAOw7AUx4KQ+oT+3TZYQKZ8O3DbFb88IcU1Y
 VIO0oVyznKAwt5dlAn3d1GkVUrd/gyp2C5mMpz+C8b2YT1QEDRF/m+7GisI4e1C1hLGiNEVNnu6
 QijdV13CU8YzsOdSOM7WnyI3zFyqWBa5Ibm2sdAs6L3tlX5hEimgrgC1NBZZZSeofvjtaO7wBc0
 4rFEif2MJlnEnaQkhCDU3xtqMv4MDuib5l4dEI9YmN++HIOsdvp0CiM+EkwideX0HK/1c8VI6wt
 zDU3dm+IRH972/H2l96ahpQ4NH/RNG/odwVsiBvfEYVjFHEhrFsbmCjCAoHauWuGDCTT1s6hEqb
 6LxCHbeqLy93VStD72X63wdYLlX7p3fHaSl0CoV8E4bTFQnfh3X72vnvijYMNQqgIqCaIZryuZg
 jfgMfru56ok5RBmUZ8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX4qq9auEcNW0J
 /Um+BQYa3y4XKt3cFgevh/6zdAjXkvs6JzpWI//jPWG86KTQaqOZGEyOiJeprc9HEGu/4tWaVz7
 vmV6mJyw4j16M653GRPFiohX3FM/bHc=
X-Proofpoint-GUID: PU031NM8OkcIc1KrXjCERRcjGVUAJEsq
X-Proofpoint-ORIG-GUID: PU031NM8OkcIc1KrXjCERRcjGVUAJEsq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
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

On Wed, Jul 15, 2026 at 6:07=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> Hi Zhiping,
>
> One concern I'd like to raise is the implicit topology constraint of the
> TPH P2P path. TPH Steering Tag only works reliably when both importer and
> exporter devices sit under the same Root Port (or same TPH-aware switch).
>
> For cross-Root-Port P2P traffic (e.g. P2P devices located in different
> RC or even socket), most server-grade Root Complexes do not forward TPH
> prefixes through their internal routing. The ST field gets silently
> stripped before reaching the target device, so all TPH setup becomes
> ineffective with no error reported to user.
>
> Because cross-Root-Port P2P traffic with ST does not affect the host, but
> merely the completer may experience some performance degradation because
> it lacks the TPH hint. In this case, I suggest adding restrictions in the
> uAPI.
>
> A further step is to check whether the importer and exporter are under
> the same root port. However, this verification will cause the P2P TPH
> to be unsupported in the case of multi-host or multi-root PCIe switch.
>
> Thanks

Hi Fengcheng,

Agreed the RC may not preserve TPH across Root Ports (PCIe Base Spec
r6.4 =C2=A76.17.4 requires all intermediate routing elements to support
TPH, and cross-RP forwarding is optional/implementation-dependent, cf.
=C2=A72.2.10.4.2). But the uAPI can't gate it: there's no discoverable "TPH
routing" capability -- DevCap2[13:12] (r6.4 =C2=A77.5.3.15) describes the
completer, not P2P forwarding -- and a same-Root-Port check would
wrongly reject switch and multi-root topologies where ST does forward.

And it's harmless anyway: per r6.4 =C2=A72.2.7.1 an element without TPH
support ignores the TH bit and completes as if unhinted, so a stripped
ST just degrades to the non-TPH baseline.

Thanks,
Zhiping
