Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFA0CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 06:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6901B112E49;
	Mon,  1 Jun 2026 06:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="deU2ejyR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A4D6112E49;
 Mon,  1 Jun 2026 06:39:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C506F60018;
 Mon,  1 Jun 2026 06:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03E81F00893;
 Mon,  1 Jun 2026 06:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780295954;
 bh=rKk6j/n9sj1IniX/7VKjNeDlTH/D2W3IN/BVvbihauI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=deU2ejyRoOMJVQywPOlLu1PqH70E+zWfsku4xW3ejYZB8yKEwCBukyd+rzzgKkdmf
 vGfMeLir+q2+YLlqYJ/AzObbKzdRw866F6HyGjCNfk4XHBFW0DBz7SfQREAKIrqTih
 eBi6cugoUG+CYfTUshTd0CccN+PQjgSzwSv7queVBc6p52Wolbj/6fOndd0MpYLxG2
 cWd4oZ+vbxMMcHUxBTZyTjrMsQm3x2s3VngOun20ayrnEQkV5sF8YIYLuI3Ny72DXa
 BZJwi4+K5b9H+0C3rpQ6FfqPHiUwR1FUO2dIJha1fHRhWnIHL6s3QX/hRpXpWMsXxA
 Afp4/cf9Y5iIg==
Message-ID: <5f3ba603-a6ad-4cf2-9a54-aebc10273c59@kernel.org>
Date: Mon, 1 Jun 2026 15:39:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
To: Christoph Hellwig <hch@lst.de>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
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
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260529135045.GA10647@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HMU1xMsen67VgPzLuGJEEdMK"
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
--------------HMU1xMsen67VgPzLuGJEEdMK
Content-Type: multipart/mixed; boundary="------------ub6P4aBhniaWwf9dwX4fSUIh";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Christoph Hellwig <hch@lst.de>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
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
Message-ID: <5f3ba603-a6ad-4cf2-9a54-aebc10273c59@kernel.org>
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
References: <20260528093437.2519248-1-hch@lst.de>
 <20260528093437.2519248-2-hch@lst.de>
 <5f7f90d8-cb32-4ffb-8f1c-0722aafbe869@kernel.org>
 <20260529135045.GA10647@lst.de>
In-Reply-To: <20260529135045.GA10647@lst.de>

--------------ub6P4aBhniaWwf9dwX4fSUIh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 5/29/26 10:50 PM, Christoph Hellwig wrote:
> On Fri, May 29, 2026 at 01:54:48PM +0200, Vlastimil Babka (SUSE) wrote:=

>> Thanks, I applied it to slab/for-7.2/alloc_bulk and merged to slab/for=
-next
>> (it's still yankable in case of issues)
>>
>> Did some fixups below (the comment was stale prior to the patch; resto=
red
>> unlikely(), simplified one line).
>>
>> A test merge into yesterday's -next found a conflict in drivers/gpu/dr=
m/
>> panthor/panthor_mmu.c. Commit 1013bf53650e ("drm/panthor: Split
>> panthor_vm_prepare_map_op_ctx() to prepare for reclaim") moved the cha=
nged
>> codeto a new function panthor_vm_op_ctx_prealloc_pts().
>> But it's solvable so no need for a complicated coordination I think.
>=20
> Ok, thanks.  The two Sashiko complains also look like they had merrits,=

> but I won't get to looking into them until Monday.
The review:
https://sashiko.dev/#/patchset/20260528093437.2519248-2-hch%40lst.de

So there is a user who might call kmem_cache_alloc_bulk() with size =3D 0=

(although the comment says @size must be larger than 0!) and
kmem_cache_alloc_bulk() returning 0 was considered a success in that case=
=2E

Either fixing kmem_cache_alloc_bulk() (and the comment) or fixing the
user sounds fine to me.

And yeah freeing an object via kfree() allocated via kvmalloc is a bug...=


--=20
Cheers,
Harry / Hyeonggon


--------------ub6P4aBhniaWwf9dwX4fSUIh--

--------------HMU1xMsen67VgPzLuGJEEdMK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCah0pCgAKCRCGXBN6rc5S
1rmyAP4xYSWajEqm+MA0a6gB0YMw8PYGMERv/Liiv8qq9FfVwQEA0LaAVOUS0vOJ
pFwKYpvxOLNGK+0ssT0N7hdbranbAAA=
=ebwI
-----END PGP SIGNATURE-----

--------------HMU1xMsen67VgPzLuGJEEdMK--
