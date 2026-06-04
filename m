Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A056CD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 07:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B980113D11;
	Thu,  4 Jun 2026 07:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mTlK76AL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA6C1113D10;
 Thu,  4 Jun 2026 07:10:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 46DFC43DF5;
 Thu,  4 Jun 2026 07:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724E31F00893;
 Thu,  4 Jun 2026 07:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780557018;
 bh=AhMxEQwcegOFcYLIZ9y5iV53bw04kwuyEtOBVhEDYMA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mTlK76ALzPHk/Pz+6x8nTHyAjcgK/SS+Mku9+Qi7I3SNA0dfcHu6BhFEs+C19pRU6
 E5+OGsyWwtumgMG/WJ2Le0aae5LQxGXgowtVmcepxAXxMfqCWAilCKaYGk/5+kRVkP
 4cO9j+hmH6qM30B4Ytx/qU6yvKs9erS3UMZLX0LxVk1/5u7oTpy2ME5T1T/npLCOGU
 s4u+Pk89mJTbVKzFZ55WRg+drPIILWBGGd5p/DVxhd0Z2F7ICIpxvMp25Jq0zQa4Gy
 HAb3eZDLpekHG+5x0DW3wia0LnDWOcTfGSaDl10ol+7lmMFjJhA3KS0hZK1C8ogR+c
 F4m/GYKhfbnJQ==
Message-ID: <f027078c-6a55-463b-8938-95ede02dca3b@kernel.org>
Date: Thu, 4 Jun 2026 16:10:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, rob.clark@oss.qualcomm.com
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, io-uring@vger.kernel.org,
 kasan-dev@googlegroups.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
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
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <b6f6323e-6f5b-4928-b474-bd2743eac3f2@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wiFRKWLl9yvmDjGQCVE2s47E"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wiFRKWLl9yvmDjGQCVE2s47E
Content-Type: multipart/mixed; boundary="------------wMYGC0PsvxX072tLl8xZovbN";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, rob.clark@oss.qualcomm.com
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, io-uring@vger.kernel.org,
 kasan-dev@googlegroups.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <f027078c-6a55-463b-8938-95ede02dca3b@kernel.org>
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
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
In-Reply-To: <b6f6323e-6f5b-4928-b474-bd2743eac3f2@kernel.org>

--------------wMYGC0PsvxX072tLl8xZovbN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/4/26 1:22 AM, Vlastimil Babka (SUSE) wrote:
> On 6/3/26 13:13, Rob Clark wrote:
>> On Wed, Jun 3, 2026 at 2:17=E2=80=AFAM Vlastimil Babka (SUSE) <vbabka@=
kernel.org> wrote:
>>>
>>> We know p->pages is NULL in this case, right? Because it was allocate=
d by
>>> vm_bind_job_create() using kzalloc().
>>> And the job can't be reused with a leftover value?
>>> (msm_iommu_pagetable_prealloc_cleanup doesn't set p->pages to zero).
>>> Or should we set p->pages to NULL here.
>>
>> Correct, the job is not reused.  But I suppose setting p->pages to
>> NULL would make things more obvious, so no objection to that.
>=20
> OK, did that, just in case. Thanks.

The kvfree() -> kfree() part should probably be a separate patch
with Fixes: 830d68f2cb8a ("drm/msm: Fix pgtable prealloc error
path") and Cc: stable?

=2E..as the commit landed v6.18.

>> BR,
>> -R
>>
>>>> +
>>>>         p->pages =3D kvmalloc_objs(*p->pages, p->count);
>>>>         if (!p->pages)
>>>>                 return -ENOMEM;
>>>>
>>>>         ret =3D kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, p->count=
, p->pages);
>>>>         if (ret !=3D p->count) {
>>>> -               kfree(p->pages);
>>>> +               kvfree(p->pages);
>>>>                 p->pages =3D NULL;
>>>>                 p->count =3D ret;
>>>>                 return -ENOMEM;

--=20
Cheers,
Harry / Hyeonggon

--------------wMYGC0PsvxX072tLl8xZovbN--

--------------wiFRKWLl9yvmDjGQCVE2s47E
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaiEk0AAKCRCGXBN6rc5S
1v0/AQCTdSzVR1AlZpSbYogIVVB+443eCQzT7065V9OSIICLswD/e6Yg56WZBHlu
kh1s01feILBrZKf2TcrQ69haUSsKKgk=
=BoaG
-----END PGP SIGNATURE-----

--------------wiFRKWLl9yvmDjGQCVE2s47E--
