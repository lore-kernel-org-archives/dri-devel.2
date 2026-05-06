Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B4BCD3436
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 09:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B9410E52A;
	Wed,  6 May 2026 09:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RI27SDbK";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="rh7gjW6p";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F23710E52A
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 09:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778061063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfrATgQHWoLdism2lue+ijTptYIlhESry+/AqSEnFWE=;
 b=RI27SDbKKDguoKKMbbzFH5qRa0MoeviY4xlJbsMLl7Jt2poMo0opihyY+5fM0OXw/908LH
 q/xE0FtLRnYeCQ12+/v9O6t3tHmcJJlYGKjnmSlZ/9egSs6XULXLM9/6AwIzW8uIald+Pq
 jIwPdQqSoD6Nn9J29NX6ai1uqB5WTng=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-AvVlmUOoM56YXqUalxUXqg-1; Wed, 06 May 2026 05:51:01 -0400
X-MC-Unique: AvVlmUOoM56YXqUalxUXqg-1
X-Mimecast-MFC-AGG-ID: AvVlmUOoM56YXqUalxUXqg_1778061060
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44696b11265so6440627f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778061060; x=1778665860; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vfrATgQHWoLdism2lue+ijTptYIlhESry+/AqSEnFWE=;
 b=rh7gjW6prWO1aqq7QZi3knr40MFN+YVbHm+H1e7D1MSsjnxtA5iiEeE5rTPrhUw+S6
 dlWnf1iQLIaDPIIgVkOgZF1+vjsr85y8rzfMfD8SHNchtDuk8WGYLNZ91QedTb3pn34Z
 3dU/8WeP+E2/uljYdrogK4XIbE1Av5DFXcSSD4ApyQRk70yFbLZBMmyGbsyQP26+BiKc
 0/z8Gvf5PDwM03o6KnUf+Nw1aSaIyTZh02VyJmXPIiil9hGgi09iIUeTM5FPdoTFyXZ9
 BwnyYDTQFHmtjCF1GennF262zs+kQJHZrxmMKqJTocRQ+1P581WpnZAT15xTw9LBLZQs
 x55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778061060; x=1778665860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfrATgQHWoLdism2lue+ijTptYIlhESry+/AqSEnFWE=;
 b=LHY53U56PoYEC1S6i0l2V+T1/tgVKZsUxFvuzlpuFNB7pXPIIIA2toIWz133QH0bf1
 6XdTiiXkYMney98SFVmVGnm6Q7VZcmREd89tK5S38mzjKjtSba1WqZ5pPdutfJP9F/SY
 nwq6sUf2QzdSCCkPrEInMkZuA8L5gmhFeEsUIuZf5LuO+2mM7zeYy2HnFpJ63Xo8aQKU
 OAOGnUdLCJJvmVYi6FjE5btiy17+nmqJ+Tu5Lm1lslVOY63u0mEtnmLWc85kmIGjNxBw
 1xqZ8AXXJZ14Htgxz/1/KbukfJycDB9AEnbTqu1N0+fszKcxc07rGksQKBbwASCnxqWj
 bAlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9X1llqNyfQXiK9+YNLL/jqcABY2QIilPyjBky5u+oqrbBBLHPYzghTN/mzhcqbG8qLNfhSRGSAN8A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrnrukSg8IEsdd3tuHidU1PBeXg4z5vp2O+vgjWsv9YmGgazz+
 K39i1q3156bYdTUdFoGQNA3f0oD6y6oU4vA8r3T96nKVcmERiWYb9B0eivpqBTl6f7f8jploN9I
 kRUmQo6gUFJ773ZXhqiwMXWHN/JCJQtcFSggx9e4dCVPlnDhdXynp2sAmsiKI+SPSk8lWgA==
X-Gm-Gg: AeBDiesZhpqAqivPjbWvIi8HWA2Ciym8ID5TK8Yjx4L+Zezo8cJauJHCRDR7Wq90t0x
 /f17KQAF7du5+lCwRVHqa7w7LhC4Ij3JElxYfjwO3xcU7ffi4HEmGz1YVI3HsTeomLy/nbQ7bOk
 05jlLq60fOICRntjqegswoPq6LUsrQ5SPw/1nStH9pA/BvFOjeJq8YgIsDSvmM0p4DKLzbZFvOu
 wRsPOjkailWRBteleKuesMKfKCtFhrygvAHf/8YeuofV+z8c7qasRp9Q/H40DPqsZ2jHMT9ClT/
 VGHXBBdEmoOJjCLvjwBcowmNHFZV07L6wFPbu74JoByaGUE7xUl/T3QZetxaltpLvKWxehQzRff
 atpr7y9fr
X-Received: by 2002:a5d:5f83:0:b0:446:ef9a:8f41 with SMTP id
 ffacd0b85a97d-4515da970a0mr4473825f8f.40.1778061060054; 
 Wed, 06 May 2026 02:51:00 -0700 (PDT)
X-Received: by 2002:a5d:5f83:0:b0:446:ef9a:8f41 with SMTP id
 ffacd0b85a97d-4515da970a0mr4473777f8f.40.1778061059498; 
 Wed, 06 May 2026 02:50:59 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02abbsm10793056f8f.18.2026.05.06.02.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 02:50:58 -0700 (PDT)
Date: Wed, 6 May 2026 11:50:58 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 Mike Rapoport <rppt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 06/10] dma-buf: heaps: Add support for Tegra VPR
Message-ID: <20260506-tentacled-unicorn-of-typhoon-cb4edb@houat>
References: <20260122161009.3865888-1-thierry.reding@kernel.org>
 <20260122161009.3865888-7-thierry.reding@kernel.org>
 <20260123-meteoric-butterfly-of-imagination-fd691f@houat>
 <aY3nov29aBGWw93Y@orome>
 <20260218-voracious-orchid-malamute-febce0@houat>
 <afJSQbArB8USb6mt@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="sztjivasnlwpybgk"
Content-Disposition: inline
In-Reply-To: <afJSQbArB8USb6mt@orome>
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


--sztjivasnlwpybgk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 06/10] dma-buf: heaps: Add support for Tegra VPR
MIME-Version: 1.0

Hi Thierry,

On Wed, Apr 29, 2026 at 08:49:58PM +0200, Thierry Reding wrote:
> On Wed, Feb 18, 2026 at 10:42:22AM +0100, Maxime Ripard wrote:
> > On Thu, Feb 12, 2026 at 03:50:09PM +0100, Thierry Reding wrote:
> > > On Fri, Jan 23, 2026 at 02:30:14PM +0100, Maxime Ripard wrote:
> > > > Hi,
> > > >=20
> > > > On Thu, Jan 22, 2026 at 05:10:05PM +0100, Thierry Reding wrote:
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > >=20
> > > > > NVIDIA Tegra SoCs commonly define a Video-Protection-Region, whic=
h is a
> > > > > region of memory dedicated to content-protected video decode and
> > > > > playback. This memory cannot be accessed by the CPU and only cert=
ain
> > > > > hardware devices have access to it.
> > > > >=20
> > > > > Expose the VPR as a DMA heap so that applications and drivers can
> > > > > allocate buffers from this region for use-cases that require this=
 kind
> > > > > of protected memory.
> > > > >=20
> > > > > VPR has a few very critical peculiarities. First, it must be a si=
ngle
> > > > > contiguous region of memory (there is a single pair of registers =
that
> > > > > set the base address and size of the region), which is configured=
 by
> > > > > calling back into the secure monitor. The memory region also need=
s to
> > > > > quite large for some use-cases because it needs to fit multiple v=
ideo
> > > > > frames (8K video should be supported), so VPR sizes of ~2 GiB are
> > > > > expected. However, some devices cannot afford to reserve this amo=
unt
> > > > > of memory for a particular use-case, and therefore the VPR must be
> > > > > resizable.
> > > > >=20
> > > > > Unfortunately, resizing the VPR is slightly tricky because the GP=
U found
> > > > > on Tegra SoCs must be in reset during the VPR resize operation. T=
his is
> > > > > currently implemented by freezing all userspace processes and cal=
ling
> > > > > invoking the GPU's freeze() implementation, resizing and the thaw=
ing the
> > > > > GPU and userspace processes. This is quite heavy-handed, so event=
ually
> > > > > it might be better to implement thawing/freezing in the GPU drive=
r in
> > > > > such a way that they block accesses to the GPU so that the VPR re=
size
> > > > > operation can happen without suspending all userspace.
> > > > >=20
> > > > > In order to balance the memory usage versus the amount of resizin=
g that
> > > > > needs to happen, the VPR is divided into multiple chunks. Each ch=
unk is
> > > > > implemented as a CMA area that is completely allocated on first u=
se to
> > > > > guarantee the contiguity of the VPR. Once all buffers from a chun=
k have
> > > > > been freed, the CMA area is deallocated and the memory returned t=
o the
> > > > > system.
> > > > >=20
> > > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > Aside from the discussion on CMA, it doesn't look like the heap def=
ines
> > > > anywhere the attributes of the allocated buffers this heap provides.
> > >=20
> > > Attributes like what? Where would you expect the driver to define thi=
s?
> > > I don't see anything in struct drm_heap_export_info that sounds like
> > > what you expect, nor does the allocation ABI provide any means of
> > > reporting attributes.
> > >=20
> > > There's also not a whole lot to this, other than that the memory
> > > allocated by this can't be accessed by anything other than a select s=
et
> > > of devices. You can't have any CPU access to these buffers (the hardw=
are
> > > will refuse to let the CPU read from this memory) either, which is
> > > hinted at by the fact that no mmap() operations are allowed.
> > >=20
> > > Can you elaborate what you're looking for?
> >=20
> > Are the buffers you're getting when allocating cacheable? uncacheable?
> > mappable? physically or virtually contiguous? etc.
> >=20
> > See
> > https://docs.kernel.org/userspace-api/dma-buf-heaps.html#heaps
>=20
> The CPU doesn't have access to the contents of these buffers, so
> cacheable or uncacheable aren't really meaningful, but I guess they are
> unmappable in that sense. The buffers are physically contiguous, but I
> think "protected" is the right name for the heap since it most
> accurately describes what the purpose (and access pattern) is.

Yeah, that's what panthor has been using too:
https://lore.kernel.org/r/20260505140516.1372388-1-ketil.johnsen@arm.com

--sztjivasnlwpybgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCafsPAQAKCRAnX84Zoj2+
duZVAX4rZKstjm4yGIoK4/qxMtpVXLGWXrhCS66Fx3Nz2VUdigwaNxKdo0VUnHgz
6sVzgJsBfRq2AlW+F/stHpXM0fMsHUXere2S6tyHKPw8gwt6dAO5rXziaIeIl7HL
rUTTJPnxiQ==
=nQPK
-----END PGP SIGNATURE-----

--sztjivasnlwpybgk--

