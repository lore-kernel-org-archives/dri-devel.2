Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFE6CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127B811321E;
	Mon,  1 Jun 2026 11:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fhQbD7Wt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A0B1130FF;
 Mon,  1 Jun 2026 11:39:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 787396001A;
 Mon,  1 Jun 2026 11:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E21B1F00893;
 Mon,  1 Jun 2026 11:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780313989;
 bh=5MMXZTkE9Ksy8r/e1+0LdFptK92/DrsLI/CT08d5UQ8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fhQbD7WtYmzfm3aO27P3MUdk1PYXtWtZRyjEbt1BF4stHyg0uRK+76axAKeOrgWDi
 +MDRJzoDAjER/TkerBiZ6pMsxnVf+EI5Sbm6Cq3INBW+ZBsyIzYpL3iBZYgt1lB4+u
 HjQ+nGLuY8hFZur08h5UjnV+3mEoTJiHhdlZSr6qVL4bZzZhLX1zKwlGyj5QD1jic0
 UkDzGkcO1Z5agDNQLNVSXMQoNuE17jqfJy33oa27Z1JSDerxJk1wpv48niFk3Df/7s
 W/FrJHStGRgZmeMdYp1ZcncnjGDoCc6TCD43KfzJKdGvUYNlcBcSVthzLF9qDJG5Va
 qQREa+iz/Gd9g==
Message-ID: <aad27c5f-01a6-4a2a-a55c-c7e411c4dd05@kernel.org>
Date: Mon, 1 Jun 2026 20:39:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mark Brown
 <broonie@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
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
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <58cc76e7-2348-443d-a989-2a06e61178af@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YwQVGEEKxGzkrAPA10HjJL0h"
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
--------------YwQVGEEKxGzkrAPA10HjJL0h
Content-Type: multipart/mixed; boundary="------------Fos0wBgvdCggrd0C0H32WobZ";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mark Brown
 <broonie@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, io-uring@vger.kernel.org,
 kasan-dev@googlegroups.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <aad27c5f-01a6-4a2a-a55c-c7e411c4dd05@kernel.org>
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
References: <20260528093437.2519248-1-hch@lst.de>
 <20260528093437.2519248-2-hch@lst.de>
 <5f7f90d8-cb32-4ffb-8f1c-0722aafbe869@kernel.org>
 <20260529135045.GA10647@lst.de>
 <5f3ba603-a6ad-4cf2-9a54-aebc10273c59@kernel.org>
 <58cc76e7-2348-443d-a989-2a06e61178af@kernel.org>
In-Reply-To: <58cc76e7-2348-443d-a989-2a06e61178af@kernel.org>

--------------Fos0wBgvdCggrd0C0H32WobZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/1/26 5:16 PM, Vlastimil Babka (SUSE) wrote:
> On 6/1/26 08:39, Harry Yoo wrote:
>>
>>
>> On 5/29/26 10:50 PM, Christoph Hellwig wrote:
>>> On Fri, May 29, 2026 at 01:54:48PM +0200, Vlastimil Babka (SUSE) wrot=
e:
>>>> Thanks, I applied it to slab/for-7.2/alloc_bulk and merged to slab/f=
or-next
>>>> (it's still yankable in case of issues)
>>>>
>>>> Did some fixups below (the comment was stale prior to the patch; res=
tored
>>>> unlikely(), simplified one line).
>>>>
>>>> A test merge into yesterday's -next found a conflict in drivers/gpu/=
drm/
>>>> panthor/panthor_mmu.c. Commit 1013bf53650e ("drm/panthor: Split
>>>> panthor_vm_prepare_map_op_ctx() to prepare for reclaim") moved the c=
hanged
>>>> codeto a new function panthor_vm_op_ctx_prealloc_pts().
>>>> But it's solvable so no need for a complicated coordination I think.=

>>>
>>> Ok, thanks.  The two Sashiko complains also look like they had merrit=
s,
>>> but I won't get to looking into them until Monday.
>> The review:
>> https://sashiko.dev/#/patchset/20260528093437.2519248-2-hch%40lst.de
>>
>> So there is a user who might call kmem_cache_alloc_bulk() with size =3D=
 0
>=20
> I don't know if it can really happen there, but maybe DRM folks can tel=
l us.

Yeah beyond my area :)

>> (although the comment says @size must be larger than 0!) and
>=20
> The comment is however new, the caller existed when there was no commen=
t and
> the return value 0 when asked for 0 was working there.

Haha, you're right. Didn't notice that...

>> kmem_cache_alloc_bulk() returning 0 was considered a success in that c=
ase.
>>
>> Either fixing kmem_cache_alloc_bulk() (and the comment) or fixing the
>> user sounds fine to me.
>=20
> Would it be wrong if we just returned true for size of 0? Would somethi=
ng
> else break?

I think it won't break as nobody should be accessing an array of size 0,
and it matches the previous behavior.

--=20
Cheers,
Harry / Hyeonggon


--------------Fos0wBgvdCggrd0C0H32WobZ--

--------------YwQVGEEKxGzkrAPA10HjJL0h
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCah1vfAAKCRCGXBN6rc5S
1n8cAQCqp4CsOu+ZPkt9JTKGMEjAbun8lhAPjYEe5ZxQbjlUnQD/Yqc0JkpGdJ3B
cq4AV3Pw4qMLNMrm3+rVRHMdUu9OmQ0=
=RNAw
-----END PGP SIGNATURE-----

--------------YwQVGEEKxGzkrAPA10HjJL0h--
