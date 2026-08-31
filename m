Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E52C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D320810E249;
	Mon, 31 Aug 2026 06:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Cu96ozi0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185CC10E249
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 06:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788158347; x=1819694347;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=7SZ92tf62kVjgnV4LGbPCY+M+xMWJmgJSdjzk8RWssY=;
 b=Cu96ozi0JeioSjZMaXZddwcJolYZ2FlyKsQioMqMdVw+8dqoXfFuolve
 p3GklXC/8JlufsrpTFr6N+mIBnWtl4TwU7DLiiA97Hkzzu9B8wIjkveJi
 BVFdyvPvuXERBHxtzkh7fj9HkyUSRE1Lo6pZNo3Z28Zi/4yCG+LNfjnvw
 GR1HzZTbYdcs07UAysNA4oNTpQrf0F9Gimg/BeOQ2FPZEFsmzQsNVV6iv
 K0CRT5b85tMiCf1ulwzbLsh5Zhk/iEi3uCmg/bIfYeAdSh37g4yRus8kT
 Kly/ERi2ceFkm5NTPBHLKwZCCLsASOSYxCcuBYZSLuKFkowf5F9coOoDc Q==;
X-CSE-ConnectionGUID: IVfBh/6mThaAP6HBZZZrsg==
X-CSE-MsgGUID: MCMpbo3dSvSqIITrcJ+5sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88578219"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88578219"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:39:06 -0700
X-CSE-ConnectionGUID: XS7rDxXuQIe9yZUmvjKI+g==
X-CSE-MsgGUID: n4efgligThO4QwAmyx2zng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="266134445"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.41])
 ([10.245.244.41])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:39:03 -0700
Message-ID: <8276d124012e7a335c299b20f6578fc9f751e713.camel@linux.intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 2/2] dma-buf: Document how exporters and
 importers agree on mapping lifetime
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe
 <logang@deltatee.com>,  Jonathan Corbet	 <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Mon, 31 Aug 2026 08:39:01 +0200
In-Reply-To: <20260830075828.GA24140@unreal>
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
 <7f13dc482e5ea2d22ddff75fe30c03cd8df42fb5.camel@linux.intel.com>
 <20260830075828.GA24140@unreal>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Sun, 2026-08-30 at 10:58 +0300, Leon Romanovsky wrote:
> On Thu, Aug 27, 2026 at 09:18:29PM +0200, Thomas Hellstr=C3=B6m wrote:
> > Hi,
> >=20
> > Some comments below:
> >=20
> > On Tue, 2026-08-25 at 09:28 +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > >=20
> > > Pinned, revoked and movable mappings are selected by which
> > > optional
> > > callbacks each side implements and by whether dma_buf_pin()
> > > succeeds,
> > > not by any flag or enum. Nothing in Documentation/ says so, and
> > > the
> > > rules are spread over the kdoc of dma_buf_ops.pin,
> > > dma_buf_attach_ops.invalidate_mappings and
> > > dma_buf_invalidate_mappings(),
> > > so a driver author has to know the symbol names before finding
> > > them.
> > >=20
> > > Name, per flow, the callbacks both sides have to implement to end
> > > up
> > > in
> > > it, describe dma_buf_pin() as the runtime negotiation, and record
> > > that
> > > the pin is what tells a revoke from a move.
> > >=20
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > > =C2=A0Documentation/driver-api/dma-buf.rst |=C2=A0 6 +++
> > > =C2=A0drivers/dma-buf/dma-buf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 85
> > > +++++++++++++++++++++++++++++++++++-
> > > =C2=A02 files changed, 90 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/driver-api/dma-buf.rst
> > > b/Documentation/driver-api/dma-buf.rst
> > > index 2f36c21d9948..39c201f38aa6 100644
> > > --- a/Documentation/driver-api/dma-buf.rst
> > > +++ b/Documentation/driver-api/dma-buf.rst
> > > @@ -113,6 +113,12 @@ Basic Operation and Device DMA Access
> > > =C2=A0.. kernel-doc:: drivers/dma-buf/dma-buf.c
> > > =C2=A0=C2=A0=C2=A0 :doc: dma buf device access
> > > =C2=A0
> > > +Mapping Lifetime Negotiation
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +.. kernel-doc:: drivers/dma-buf/dma-buf.c
> > > +=C2=A0=C2=A0 :doc: mapping lifetime negotiation
> > > +
> > > =C2=A0CPU Access to DMA Buffer Objects
> > > =C2=A0~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > =C2=A0
> > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-
> > > buf.c
> > > index d504c636dc29..30afec7365bc 100644
> > > --- a/drivers/dma-buf/dma-buf.c
> > > +++ b/drivers/dma-buf/dma-buf.c
> > > @@ -684,7 +684,90 @@ static struct file *dma_buf_getfile(size_t
> > > size,
> > > int flags)
> > > =C2=A0 *=C2=A0=C2=A0=C2=A0 reference acquired with dma_buf_get() by c=
alling
> > > dma_buf_put().
> > > =C2=A0 *
> > > =C2=A0 * For the detailed semantics exporters are expected to
> > > implement
> > > see
> > > - * &dma_buf_ops.
> > > + * &dma_buf_ops. Whether the exporter may still move or destroy
> > > the
> > > backing
> > > + * storage after step 3 depends on what exporter and importer
> > > implement, see
> > > + * the mapping lifetime negotiation section below.
> > > + */
> > > +
> > > +/**
> > > + * DOC: mapping lifetime negotiation
> > > + *
> > > + * No flag or enum says whether the exporter may move or take
> > > away
> > > the backing
> > > + * storage while an importer holds a mapping. Each side
> > > implements a
> > > set of
> > > + * optional callbacks, and dma_buf_pin() settles the result at
> > > runtime. Three
> > > + * flows come out of it:
> > > + *
> > > + * - Pinned: the storage never moves and is never taken away.
> > > + * - Revoked: the storage never moves, but the exporter may take
> > > it
> > > away.
> > > + * - Movable: the exporter may relocate the storage at any time.
> >=20
> > Perhaps add "even temporarily to locations that are not available
> > for
> > DMA".
>=20
> I don't know. "Not available for DMA" defeats the whole purpose of
> dma-buf,
> which is intended to expose DMA-capable memory to other peers. I
> imagine
> that "everything is optional dmabuf world" this is possible, but it
> looks to me like a partial version of revoked flow.

Not permanently revoked. In practice this would be, for example, a GPU-
exported dma-buf which is only available for p2p access which gets
evicted, or a system memory exported dma-buf that gets hit by a
shrinker and moved to swap. The exporter calls invalidate_mappings() to
notify importers that storage is going away. Importers need to call
map_attachment() to bring it back.

>=20
> >=20
> > > + *
> > > + * Every exporter implements &dma_buf_ops.map_dma_buf,
> > > + * &dma_buf_ops.unmap_dma_buf and &dma_buf_ops.release.
> > > dma_buf_export()
> > > + * rejects an exporter missing any of them.
> > > + *
> > > + * An importer reaches its flow like this:
> > > + *
> > > + * 1. Attach with dma_buf_dynamic_attach(). Leaving
> > > + *=C2=A0=C2=A0=C2=A0 &dma_buf_attach_ops.invalidate_mappings NULL ru=
les out
> > > everything but the
> > > + *=C2=A0=C2=A0=C2=A0 pinned flow, because the importer can then neve=
r be told
> > > anything.
> > > + * 2. Call dma_buf_pin() under the reservation lock.
> > > + * 3. On failure run the movable flow, or give up.
> > > + * 4. On success the storage stays put. Whether the exporter may
> > > still take it
> > > + *=C2=A0=C2=A0=C2=A0 away, which makes this the revoked flow instead=
 of the
> > > pinned
> > > one, is the
> > > + *=C2=A0=C2=A0=C2=A0 exporter's choice and is not reported back.
> > > + *
> > > + * dma_buf_attach() is the shorthand for an importer which only
> > > ever
> > > wants the
> > > + * pinned flow. It passes no &dma_buf_attach_ops, and DMA-buf
> > > then
> > > pins around
> > > + * every dma_buf_map_attachment() and waits for the
> > > DMA_RESV_USAGE_KERNEL
> > > + * fences on the importer's behalf. Peer to peer needs
> > > + * dma_buf_dynamic_attach(), because
> > > &dma_buf_attach_ops.allow_peer2peer lives
> > > + * in the attach ops.
> > > + *
> > > + * Pinned flow:
> > > + *
> > > + * - Exporter: implement &dma_buf_ops.pin and &dma_buf_ops.unpin
> > > to
> > > hold the
> > > + *=C2=A0=C2=A0 storage still on request. An exporter whose storage n=
ever
> > > moves
> > > implements
> > > + *=C2=A0=C2=A0 neither, and dma_buf_pin() then succeeds on its own. =
An
> > > exporter which
> > > + *=C2=A0=C2=A0 refuses to be pinned implements &dma_buf_ops.pin and =
fails
> > > it.
> > > + * - Importer: nothing more. The mapping stays valid until it
> > > unmaps.
> > > + *
> > > + * Revoked flow:
> > > + *
> > > + * - Exporter: answer dma_buf_pin() as above. Call
> > > + *=C2=A0=C2=A0 dma_buf_invalidate_mappings() when the storage goes a=
way
> > > and
> > > fail
> > > + *=C2=A0=C2=A0 &dma_buf_ops.map_dma_buf while it is gone. The two wa=
its
> > > which
> > > complete a
> > > + *=C2=A0=C2=A0 revocation are described in dma_buf_invalidate_mappin=
gs().
> > > + * - Importer: &dma_buf_attach_ops.invalidate_mappings has to
> > > unmap
> > > within
> > > + *=C2=A0=C2=A0 bounded time and drop the pin.
> > > + *
> > > + * Movable flow:
> > > + *
> > > + * - Exporter: call dma_buf_invalidate_mappings() before each
> > > move,
> > > then wait
> > > + *=C2=A0=C2=A0 for the &dma_buf.resv fences. &dma_buf_ops.pin and
> > > &dma_buf_ops.unpin play
> > > + *=C2=A0=C2=A0 no part here.
> > > + * - Importer: hold no pin.
> > > &dma_buf_attach_ops.invalidate_mappings
> > > drops the
> > > + *=C2=A0=C2=A0 cached mapping and has to lead to
> > > dma_buf_unmap_attachment()
> > > within
> > > + *=C2=A0=C2=A0 bounded time.
> >=20
> > Hear I would want to see the exporter being allowed to force unmap
> > the
> > dma mappings and reclaim thestorage when the fences mentioned above
> > have signaled, but the importer has not yet called
> > dma_buf_unmap_attachment(). That would allow importers to call
> > dma_buf_unmap_attachment() lazily, just before the next
> > map_attachment,
> > which would allow simplifying importer implementations.=20
>=20
> How? It will move one piece of code as is to another place. In
> addition,
> both exporter and importer need to stop HW access to same region.

A typical GPU example: A GPU importer receives invalidate_mappings() on
an imported dma-buf. The dma-buf is still accessed by the GPU and thus
has a couple of dma-fences attached. The importer can't immediately
call dma_buf_unmap_attachment(). In fact, typically the easiest thing
for the importer is to call dma_buf_unmap_attachment() on the next gpu
command submission immediately followed by a dma_buf_map_attachment(),
but it can't guarantee that would happen within bounded time.

A well behaved importer would therefore currently have to schedule an
async worker or similar to wait for its dma-fences to signal and then
grab the resv lock from worker context and call
dma_buf_unmap_attachment().

A well-behaved exporter on the other hand, would have to wait for all
dma-fences to signal, then wait for all unmap_attachment() calls before
reclaiming.

TBH I'm not sure what the best solution is here, but the importer flow
doesn't fit well in a typical gpu command submission model IMO.

Thanks,
Thomas




>=20
> > More of a related idea than something that needs fixing for this
> > patch.
> >=20
> > > =C2=A0It need not stop the hardware, because access runs until the
> > > + *=C2=A0=C2=A0 importer's &dma_buf.resv fences retire. Map again bef=
ore
> > > the
> > > next DMA.
> >=20
> > A successful map will mean the exporter has placed the data in
> > storage
> > compatible with what was agreed during attachment?
>=20
> Yes.
>=20
> >=20
> > Thanks,
> > Thomas
> >=20
