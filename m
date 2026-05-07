Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18146CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A3A10F0D1;
	Thu,  7 May 2026 13:39:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ij1zWfqY";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1099F10F0D1
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:39:23 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso668815f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778161161; x=1778765961; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MirORJ/xODrUNsE9K1GDry31szTlmO/Fh+672eoJv6Y=;
 b=Ij1zWfqYjhJ+rqzkeQv0hcdag8zluIB6U3OxyoXxIKyhu6Sdi6w/F3s/Ln5mOeMgOT
 xzC/FSD9pWm8iwCP0kPlf8Fyc0T6Knyupq2ZHoKb5Xw3KCy9OaNfy0GEv3xBbCassVOu
 pmv1yQT5+gjjgF1SXG3gZN8T/GhwZ9NI6pN8COD/zEFSvKhLgciQ8You9vrnCTf2Iyip
 1eXvpc/NrmRtibo7ALk9wJyizqlqu3zy9mYTob4+AxkvxHGS+UOYsN1uf2JCdIxRQAAh
 VdlqI0IXjN3Hbo3Tbw+sL0zjPg6NVpgDmAr6s6WyGwDubssrptKRDO0zEcsGMKt7wbcf
 pH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778161161; x=1778765961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MirORJ/xODrUNsE9K1GDry31szTlmO/Fh+672eoJv6Y=;
 b=H9YvQf+A//CZxNhEF5+hGiLS4W82DozU6So1tMDk6LRJAcDhrD/G6B7ouB828oSMye
 lR8hF7YMykav+hhhdoUvl5G6q+gSyPGaqWgxrkwsPzpqABfwIBdGK+S+NJn+gIloEYum
 j7b+r1maYix4n76MQZsw45frVV7kbNcsp7al8PCYFCF4IdbYKBU8kIT3jxlSsv+DiKQY
 Ib4MdR40AQsP9uMJFZZCvmySkPqvQe7wH+B7dSbiIu+Ut2oI0b9SlUIlOoKF8cSbReM9
 s76VxmKfr1hyj9gTTz76KOmbyNQm8IzTQwjGG/kKJ/YLbhMc7QW+im/rf6DM9iO5jrW9
 uWyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ib8UPsP+T7wT1Pcj/g/gf+nPUHtiCqp5h0L9h7MWYItU1psasvgnrqF4gB4sRMc1gYNjNHWkm5Lk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy11bovUQNMG7lx3XCOsbR6G9LLf/mxjvzR/a7KgBwAyYoiBJU/
 MZxvdckVd5TUl0CC0FlIhrmHswlfMs8cwjBvcZxzBJq7WP8dSeQWzFg5
X-Gm-Gg: AeBDiesuRuZ0aSQOWu0uwZNcdIq1HsxE9lD64pch4Ob1NeLJPI0BhEzpcuG0vwBFf50
 B2zPMD9stjRQzggSUBneYef5HmM/w+oR11doJtu4iZ2qR8Rnn4xULrRgOL+Lk+eJlgySO5bkjN9
 49ALyOEjrL6zLYiym0X5nPDooDOJcjm1hl3MYa/CwwpZXt1e02GD6DXHRebDUA+3XIuZYSHXhyB
 PPckVRbkw9HoLt2e2CcY7o0dN3z+fuNuiqhY05ZjAn8OP04rcefnHrh3Def6afrq69EQnIb/vGE
 Ve8uXiz2GLpWt28ctnA0vPwzEOyMudyIchN6nBRoHIGRKbwL2LbXTZc0ww70+/4ViDMty3LZvdd
 oE5OIi1bIjbePt6mg9XFC/mAob6LoHg34KlhMIvvaVfwOiBtEwHrtZQMiuUQG+kzdPMo9qGg3qP
 NNeWuX2H2h55VDBm63dREy6ssOBJHbBCFnQiRlBWTKmdQWwxiUEhwx+hTz73Ict1bsApkmyPpFl
 gtjFiBNnt6ej/IbWylK6ZD3
X-Received: by 2002:a05:6000:200b:b0:43d:7b85:6c95 with SMTP id
 ffacd0b85a97d-4515d5c567emr13185884f8f.33.1778161161071; 
 Thu, 07 May 2026 06:39:21 -0700 (PDT)
Received: from orome (p200300e41f1c9800f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1c:9800:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02802sm20939063f8f.17.2026.05.07.06.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:39:19 -0700 (PDT)
Date: Thu, 7 May 2026 15:39:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Ketil Johnsen <ketil.johnsen@arm.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Florent Tomasin <florent.tomasin@arm.com>
Subject: Re: [PATCH 4/8] drm/panthor: Add support for protected memory
 allocation in panthor
Message-ID: <afyU2Doug7zK_p2r@orome>
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
 <20260505140516.1372388-5-ketil.johnsen@arm.com>
 <20260506-energetic-azure-pig-2b6ec4@houat>
 <20260506125015.0108ef44@fedora>
 <20260506-golden-python-of-aptitude-ff972a@houat>
 <20260506170515.2d8511c3@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="asfzz3x46tacowfj"
Content-Disposition: inline
In-Reply-To: <20260506170515.2d8511c3@fedora>
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


--asfzz3x46tacowfj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/8] drm/panthor: Add support for protected memory
 allocation in panthor
MIME-Version: 1.0

On Wed, May 06, 2026 at 05:05:15PM +0200, Boris Brezillon wrote:
> On Wed, 6 May 2026 15:12:37 +0200
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > On Wed, May 06, 2026 at 12:50:15PM +0200, Boris Brezillon wrote:
> > > On Wed, 6 May 2026 12:08:24 +0200
> > > Maxime Ripard <mripard@kernel.org> wrote:
> > >  =20
> > > > Hi,
> > > >=20
> > > > On Tue, May 05, 2026 at 04:05:10PM +0200, Ketil Johnsen wrote: =20
> > > > > From: Florent Tomasin <florent.tomasin@arm.com>
> > > > >=20
> > > > > This patch allows Panthor to allocate buffer objects from a
> > > > > protected heap. The Panthor driver should be seen as a consumer
> > > > > of the heap and not an exporter.
> > > > >=20
> > > > > Protected memory buffers needed by the Panthor driver:
> > > > > - On CSF FW load, the Panthor driver must allocate a protected
> > > > >   buffer object to hold data to use by the FW when in protected
> > > > >   mode. This protected buffer object is owned by the device
> > > > >   and does not belong to a process.
> > > > > - On CSG creation, the Panthor driver must allocate a protected
> > > > >   suspend buffer object for the FW to store data when suspending
> > > > >   the CSG while in protected mode. The kernel owns this allocation
> > > > >   and does not allow user space mapping. The format of the data
> > > > >   in this buffer is only known by the FW and does not need to be
> > > > >   shared with other entities.
> > > > >=20
> > > > > The driver will retrieve the protected heap using the name of the
> > > > > heap provided to the driver as module parameter.   =20
> > > >=20
> > > > I know it's what dma_heap_find asks for, but I wonder if it wouldn'=
t be
> > > > better in the device tree and lookup through the device node? heaps=
 are
> > > > going to have a node anyway, right? =20
> > >=20
> > > I'm not too sure. Take the PROTMEM (name=3D"protected,xxxx") dma_heaps
> > > instantiated by optee for instance, I don't think the originating
> > > tee_device comes from a device node, nor is the underlying heap
> > > described as a device node. The reserved memory pool this protected h=
eap
> > > comes from is most likely defined somewhere as reserved memory in the
> > > DT, but there's nothing to correlate this range of reserved mem to so=
me
> > > sub-range that the TEE implementation is carving out to provide
> > > protected memory. =20
> >=20
> > Maybe we should be working on a dt bindings for heaps then? Something
> > simple like we have for clocks with a phandle and an ID would probably
> > be enough. In optee's case, it looks like it would map nicely with
> > TEE_DMA_HEAP_* flags too.
>=20
> Sure.
>=20
> >=20
> > The only two that wouldn't be covered would be the system and default
> > CMA heap if not setup in the DT, which shouldn't be too bad for this
> > particular use-case.
>=20
> I'm not opposed to the idea of describing the association through the
> DT (with a <phandle, ID> pair). My main fear is that it drags us into
> endless discussions around what's considered HW description and what's
> not (PTSD of all those DT-bindings discussions I suppose :-)), which
> ends up delaying the merging of Panthor's protected memory support.

FWIW, I plan on doing exactly that for Tegra. The way we wire things up
there is by referencing the protected memory by phandle via the memory-
region property (and a memory-region-names =3D "protected" for context).

It doesn't support passing a specifier along with the phandle, but maybe
that can be added (using something like a #memory-region-cells property
to mirror other similar bindings).

Thierry

--asfzz3x46tacowfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmn8lgQACgkQ3SOs138+
s6G3+g/9HA74siLrq2Ig7isjRJFtRcHmFnjq8EblmmVUlYSar61ejku2o14ju81i
ybe025hgJcVIPKuiYXscduXk8eOdVzix8Os/oFh3ZPHyMP0tuG8zC1HNjqsnLWPd
eha1cnD27rsFPgnSmhFFIYiThWDUzf2ynteIeul4Ax4z1LL1oqSpD3WH+9brO9fC
aUZOdU16WSEK6O5Yx/g8zX3id2trZzYfWCDueg0tGGLwcMvfXTuuSbz9e59C5EBj
SyMPiOrwT+EERP4FUfqPEnbt0CLnjhZnxekp//Lv2DwjzSSNIlFoeTczP/qjoeTf
iIf4FfLI1FA4zODWgX+OWlD9iq1QyDEIjzM0EHsSz9Fr1QTZeuvEN8C4gwMF8ZJP
nfejV/U9HvsE4jOuv25o6XSpVUXVulF8cAmWSb2gzEe0L2r3S7SJvc5fin5zY+ui
X4VlDMkw1XflRl+fte35xoi829RIFJkYC8drCV/mrP/ORzUwa/cO1MDhn7yougGH
bEoX4HFA1dl+rscnYASEUeoQP+1z+7IMdifsCZTMRUkPEOPmYXqVSIQkFEL/S00Z
46wlyQT1DP+De2fxipN4WUpaKmS61pjCibQYO/RO3sRSXUEUt/Hz2MabLrSy9QHx
J6PCv2dsBoF9pjVW2+kRPnxCm4AsjRJ3lQFHjh5HIZHWWs7ir6A=
=H2su
-----END PGP SIGNATURE-----

--asfzz3x46tacowfj--
