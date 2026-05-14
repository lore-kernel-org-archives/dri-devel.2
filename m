Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A338FCD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 21:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EAB810F352;
	Thu, 14 May 2026 21:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="LxtRhAqK";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A448510E298
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:55:42 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E2KgBm2083595
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:55:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=IkkxRlEVU+3w+Yl34MPIFikE3yFUtB8xK/F28U9hrPg=; b=LxtRhAqK961K
 Qx6NyNdgt1AOhTAfIWUL4hMXnHS0598SipoJSDn2iWyvAzTrQJAJzUw+9sZxRwsw
 AR4HU5bIdSM3bPtuqkEL4/XZroyBkRJFBb8S4iq2p6k3Q3kBLqi2SZyuut/I+7yv
 xUXa521SbV2iscLIYd/hlxRNxClEJY5FzzABKnHYbLU/H96TcElBWFWztKhlJ7aG
 ud5pmNFXYCBdVjukCE9qns8eC2TSH3FWbtOqLsrdfRLV+ZPg5rKJK7KkrwX6S2cJ
 o1yla90oO9Hn4h6L0GpgkLL95NEIbYr1lnodaxhfyrHlbKjK8GwSA0mYBX8DYX/V
 TqTnTTC9EQ==
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvqycam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:55:41 -0700 (PDT)
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-bcc2320b2deso525507266b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778766940; x=1779371740;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IkkxRlEVU+3w+Yl34MPIFikE3yFUtB8xK/F28U9hrPg=;
 b=RiQ9YMan3k/a2Rxk+taFxsJc6w7IvTTvVdRdtBoznTCfX/xB9frKo03BYzGRQ79x/K
 q/qYDnMWLcZbVc/B2RVPpVKb+TesoOoxP0nmCxCsMb4kvmJlicIofRBsQstTQuSg0isb
 roQCwenS6HGY/RUR41fSrAQNbHaIZrw5J6EV9RnCuogVz/bo4ZtUVDi5hqqVKH9gfKKx
 wKsAV0suMyDp5aMG0vmWxYsbLtKV5BvoaYbRLSfsUUHrDXWhTT/RQcYvBrB38vGyF1KF
 w3aFf3jU8dby/zeBAtLVWs2cRs0OeTJq2NVOD37JTTAHgMg6+YjISoRwy4mgwpYLE2BE
 iPKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4dWzw0nsKQggcacevkNJzcMaiNJ6SWVavvB0pH8UQYLu1M2MJUBe+triQya6kcVVKFuzzWYbU7F8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIvULx2jvbhXGBsug+IgQ9BfEM7r/m2RxG70lLpiQTPYCZ6Tu8
 vOg188sHcEOimzT30q7Mwta7m0ohF4vQWNcyYAVrJrVW2Dz0ZGFI28FSisEepPaXZ05+WKip4QH
 mo4nr4GEcsWW8C4cxCbyYJp46E3kvhAgniBRMxXsfuPYo0hSuDzrBVYId/pmLvxGKq3wmxYMbvv
 fZ
X-Gm-Gg: Acq92OH07fdTGX+sYLdw6x9VY+Gzw5Hgx9ZmGVj/6+26ZJwB+RHQLaNqx3y3bAVUd5y
 U5kc81deQum71Bs6wNLRe24ZoXP7ZvdCl5olXmgd16gSoFefjoXtDOAj7b9TtDvyYBE/Jf6hDxo
 VCJFDKx74He9GfsawZNMx0iNIZv7GSBSyO35ef+x2IcRr32C0+eLOJKPnJ7DGazqXbx4aB+PbPv
 RoynkZWPFVl/1rdmZSFQ5mJC7D3EN41TI9sUf02DJlRIYqa0i0ikO4K0xamZ+qNHpH57hfS3Qca
 2g6/AbRLaPKuExlv89KW4VafuZcX9pW1+DI5U/XwX9SAP+Wu2NJ1hway0U+yMK7qtuoIA1diAQa
 dL2OqZU8HYKl7tBr1enBf3bD+vTQuvFLWJPCztkazRVLC6ISEym8R2wPAoZBy1MkLbOkHYSdh2M
 C0rSzMIJd2dqpAcQq7Q7Som3tjLFFXLnTwCWji/QxyupRbfUhN+ukbQFnylkNpzEXLRAY5u8Vos
 2Hwb33leARfgjf6J5qcgm0=
X-Received: by 2002:a17:906:4786:b0:bd3:2b8a:2164 with SMTP id
 a640c23a62f3a-bd3bfb9f635mr526850566b.16.1778766939845; 
 Thu, 14 May 2026 06:55:39 -0700 (PDT)
X-Received: by 2002:a17:906:4786:b0:bd3:2b8a:2164 with SMTP id
 a640c23a62f3a-bd3bfb9f635mr526848066b.16.1778766939261; 
 Thu, 14 May 2026 06:55:39 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde?
 (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4bd0a24sm94246766b.11.2026.05.14.06.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 06:55:38 -0700 (PDT)
Message-ID: <5c64e13a-2d41-4e5e-addf-9a76f08ae172@meta.com>
Date: Thu, 14 May 2026 14:55:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Alistair Popple
 <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-10-mattev@meta.com>
 <20260424183153.GJ3444440@nvidia.com> <20260426105215.GA440345@unreal>
 <20260427083644.4ee174cd@shazbot.org>
 <25a4fc45-1b4d-426b-954a-60bf21e9040f@meta.com>
 <20260511140957.25eb5d9d@shazbot.org>
 <4af0c788-22cc-4fb1-9276-ab35439fb7c8@meta.com>
 <20260513122734.44ce8a68@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260513122734.44ce8a68@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0MCBTYWx0ZWRfX0PGj/sei5kRl
 QtC02VdbBBE2SuBoeC1vY66wbT8ducTd0ODnNYbQLTG0q1cQf1hNWHzmvdSarSHeLDGN3MJlklP
 tVXaMnxFHXUdm0SmuWN3hIXMcrhwbZL4FXazGJAZzJ0/xeSd5HsSYDS0SkIBd48rPv4KAHj9TVL
 aSLn5dSxyGn9kzJ4lG8rWBoKtNBkHB7LS/2jRXVRoQ1eKNyZeClc0idjK77ZYjfsUc2xV1jmXMZ
 sOGJaID4GRRbLq9FJcPKoDXGB30PAWZiI5FfD6jJPNcHeFHC7EiQHeMLKuFLCvh+9cP7OL9AGBH
 Ns4XGyfj5z4WBdzt1YGfj89myL/cdEpO8NkDagWWCrJtJ3a+5xOa6FOjYgDfoFqG42meBICByoZ
 9zMrBVfQNfD6kC0/DdFI+1z/BSv6DUhydTBISbU24keiRGWk78vyKsz+mpIlOYVd0uN3wJQ/i0c
 0W/vJWO92stgchg8fJA==
X-Authority-Analysis: v=2.4 cv=f4F4wuyM c=1 sm=1 tr=0 ts=6a05d45d cx=c_pps
 a=Ak8bExYEjeps3Jj0Zi+cTQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VabnemYjAAAA:8 a=QlOCKlcsugFDnh0twowA:9
 a=QEXdDO2ut3YA:10 a=IIT_bRn7abC_HnDGr_W6:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 5gP00pVtTGuYlUOuYZQtOpSK2xr09hJZ
X-Proofpoint-GUID: 5gP00pVtTGuYlUOuYZQtOpSK2xr09hJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Mailman-Approved-At: Thu, 14 May 2026 21:46:51 +0000
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

Hi Alex,

On 13/05/2026 19:27, Alex Williamson wrote:
> 
> On Tue, 12 May 2026 18:51:40 +0100
> Matt Evans <mattev@meta.com> wrote:
>> On 11/05/2026 21:09, Alex Williamson wrote:
>>> I think the question of how we actually expand an arbitrary grab bag of
>>> "ATTRS" is the central question in whether we should implement the
>>> interface.
>>
>>> If we follow the direction I suggested for TPH, maybe this
>>> is just a VFIO_DEVICE_FEATURE_DMA_BUF_WC, where it supports only PROBE
>>> and SET, with SET taking only the dma-buf fd to implement the one-way
>>> promotion from UC -> WC.
>>>
>>> If we support a generic SET ATTRS feature, we really need to map out how
>>> flag bits are indicated as supported and how a user untangles failures
>>> from trying to set various attributes.  If we end up with a feature
>>> indicating each ATTR is available, we might as well have just
>>> implemented a feature for each attribute.  Thanks,
>>
>> Agreed, that's key.  Alhough, the aim of this patch is for attrs to be a
>> memory type enum rather than a bag of possibly-concurrent and
>> possibly-conflicting boolean flags.  Maybe 'memory attributes' would be
>> a better feature name.
>>
>> I'm not sure about the feature-per-attribute.  Say we do a
>> VFIO_DEVICE_FEATURE_DMA_BUF_WC and then later support a second,
>> VFIO_DEVICE_FEATURE_DMA_BUF_UC_WEAK (like, say, Arm Device-nGRE).  Then
>> we have to specify that these two VFIO feature types actually
>> interact/override somehow.  I doubt we'll end up with a dozen but it's a
>> bit tiresome having a few features that interact.
>>
>> At least if it's a single DMA_BUF_MEMATTR feature taking an enum, we
>> just encode the N different (mutually-exclusive!) valid states and done.
>>    I don't feel having a new feature for each keeps things simpler.
>>
>> Discovery of support for a specific future attribute is OK with a single
>> ATTR too; we can take an enum attribute argument to a GET and -ENOTSUPP
>> for any we don't like.
>>
>> (We could also add orthogonal DMABUF flags (can't think of a good
>> example...) but I'd suggest _those_ as semantically-grouped different
>> features, with the same issues of specifying conflicting cases versus
>> existing features.)
> 
> I think the GET behavior you're proposing is a bit counter-intuitive, if
> not abusive of the interface, but I do agree that if the feature is
> SET'ing a single value and not a group of independent flags, that we
> can probably rely more on a try-and-fail model rather than advertising
> each supported value as a separate feature.
>
> For example, the user has some list of compatible attributes ordered
> from most to least desirable, they try each in order until one works,
> or none work and they decide whether that's ok.
> 
> For GET, if we implement it, I think it should report the current
> attribute, mirroring SET.  We could almost get away without implementing
> it, but I do worry about the case of nvgrace-gpu, where it might be
> interesting for the user to see that the default attribute could be WB
> rather than UC.

I'd come to the same conclusion yesterday when implementing it. :)

GET just returns the current value, SET gives ENOTSUPP if the provided 
value isn't supported.

I haven't done much thinking on mechanisms for overriding the default 
value, but a sub-driver could add that via some hook from 
vfio_pci_core_feature_dma_buf().

> Where does the user derive the enum value?  Are we defining our own or
> is it a system header defined enum?  I'm curious if/how we're going to
> handle architecture specific attributes.  Thanks,

Good question.  There doesn't seem to be a suitable existing enum so I 
defined a new set (mirroring existing pgprot_*() semantics), in the same 
vfio.h/UAPI place as this patch.

The set could be extended in future to add some kind of "base vs 
arch-specific" grouping if we want to support arch-specific types like 
that hypothetical example arm64 'UC_WEAK' above.  (The feature param's a 
u32, so steal top byte for extension group_id?)

For the base set of types, they should at most follow the set of 
IO-related pgprot_*() types (whose names are a bit of an awkward fit 
across architectures but they're used consistently).  I've revisited the 
names to make them consistent with pgprot_*().  For sake of keeping the 
huge enum names smaller, abbreviated slightly:

pgprot_noncached()    -> VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC (*)
pgprot_writecombine() -> VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC
pgprot_device()       -> VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_DEV

  *: Was UC in the v1 patch, which makes more sense as a memory type
     name, but consistency with pgprot_* is better.

But, I was thinking to support just the NC default and WC option in this 
series.  Does anyone feel strongly about needing pgprot_device() right 
now?  For external PCIe functions it'll behave the same as the NC type 
(even on arm64) so I don't think it's critical to add yet.

At this stage feels like we should get more field experience before 
adding more values/a scheme for arch-specific values so I'm keen on NC + 
WC for now, WDYT?


Matt



