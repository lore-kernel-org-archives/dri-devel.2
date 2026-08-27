Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37394C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ADEF10F186;
	Thu, 27 Aug 2026 19:18:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SgMdgbAp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B317410F186
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 19:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787858315; x=1819394315;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ZEvghn5iUqKMeGcDHG1wGNG7qY9SwnARynbhSwp0i1Y=;
 b=SgMdgbApUHhhBU26OSkHnmA2f8BUM2n06oV67/u/pNjQLoHDomnu+3X7
 hb0OS/1AICpdfmQqUgZBUDgJkpFZEaKPpPsDHXMdWsPh0j3Ty+ktL8mDh
 cx1yZg8INuT/QVh6V2xkkuMb29pggClKOTs8xTOK7ez41YpekRb0zqdif
 xWlbIVPCOU7Bysg1jzqU19By1LEgtb1Jn9ODpUyjrLl4kDZSGN8lgwkni
 nCSwA8T51QdT8Gi5jM8XD88qko21eyeHnUxPCs6N7/2WPaw9Oeh6z75If
 tGbBSGQW3MNHWEWYHTYLFCoKSWqKpTQwIkqeT2Ld+1n+GrOTBeGy2cXAh w==;
X-CSE-ConnectionGUID: U7ujgENpQhin6GaZa2tYYA==
X-CSE-MsgGUID: 3CBdwXc3SeaR5KLEX0nEVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99884412"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; d="scan'208";a="99884412"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 12:18:35 -0700
X-CSE-ConnectionGUID: L0/Yj2PwQey07ZTfhx1ceg==
X-CSE-MsgGUID: iNlDjpvRT0m8hk8uRUzQRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; d="scan'208";a="297854378"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.245.26])
 ([10.245.245.26])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 12:18:32 -0700
Message-ID: <7f13dc482e5ea2d22ddff75fe30c03cd8df42fb5.camel@linux.intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 2/2] dma-buf: Document how exporters and
 importers agree on mapping lifetime
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Thu, 27 Aug 2026 21:18:29 +0200
In-Reply-To: <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
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

Hi,

Some comments below:

On Tue, 2026-08-25 at 09:28 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Pinned, revoked and movable mappings are selected by which optional
> callbacks each side implements and by whether dma_buf_pin() succeeds,
> not by any flag or enum. Nothing in Documentation/ says so, and the
> rules are spread over the kdoc of dma_buf_ops.pin,
> dma_buf_attach_ops.invalidate_mappings and
> dma_buf_invalidate_mappings(),
> so a driver author has to know the symbol names before finding them.
>=20
> Name, per flow, the callbacks both sides have to implement to end up
> in
> it, describe dma_buf_pin() as the runtime negotiation, and record
> that
> the pin is what tells a revoke from a move.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> =C2=A0Documentation/driver-api/dma-buf.rst |=C2=A0 6 +++
> =C2=A0drivers/dma-buf/dma-buf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 85
> +++++++++++++++++++++++++++++++++++-
> =C2=A02 files changed, 90 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/driver-api/dma-buf.rst
> b/Documentation/driver-api/dma-buf.rst
> index 2f36c21d9948..39c201f38aa6 100644
> --- a/Documentation/driver-api/dma-buf.rst
> +++ b/Documentation/driver-api/dma-buf.rst
> @@ -113,6 +113,12 @@ Basic Operation and Device DMA Access
> =C2=A0.. kernel-doc:: drivers/dma-buf/dma-buf.c
> =C2=A0=C2=A0=C2=A0 :doc: dma buf device access
> =C2=A0
> +Mapping Lifetime Negotiation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: drivers/dma-buf/dma-buf.c
> +=C2=A0=C2=A0 :doc: mapping lifetime negotiation
> +
> =C2=A0CPU Access to DMA Buffer Objects
> =C2=A0~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc29..30afec7365bc 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -684,7 +684,90 @@ static struct file *dma_buf_getfile(size_t size,
> int flags)
> =C2=A0 *=C2=A0=C2=A0=C2=A0 reference acquired with dma_buf_get() by calli=
ng
> dma_buf_put().
> =C2=A0 *
> =C2=A0 * For the detailed semantics exporters are expected to implement
> see
> - * &dma_buf_ops.
> + * &dma_buf_ops. Whether the exporter may still move or destroy the
> backing
> + * storage after step 3 depends on what exporter and importer
> implement, see
> + * the mapping lifetime negotiation section below.
> + */
> +
> +/**
> + * DOC: mapping lifetime negotiation
> + *
> + * No flag or enum says whether the exporter may move or take away
> the backing
> + * storage while an importer holds a mapping. Each side implements a
> set of
> + * optional callbacks, and dma_buf_pin() settles the result at
> runtime. Three
> + * flows come out of it:
> + *
> + * - Pinned: the storage never moves and is never taken away.
> + * - Revoked: the storage never moves, but the exporter may take it
> away.
> + * - Movable: the exporter may relocate the storage at any time.

Perhaps add "even temporarily to locations that are not available for
DMA".

> + *
> + * Every exporter implements &dma_buf_ops.map_dma_buf,
> + * &dma_buf_ops.unmap_dma_buf and &dma_buf_ops.release.
> dma_buf_export()
> + * rejects an exporter missing any of them.
> + *
> + * An importer reaches its flow like this:
> + *
> + * 1. Attach with dma_buf_dynamic_attach(). Leaving
> + *=C2=A0=C2=A0=C2=A0 &dma_buf_attach_ops.invalidate_mappings NULL rules =
out
> everything but the
> + *=C2=A0=C2=A0=C2=A0 pinned flow, because the importer can then never be=
 told
> anything.
> + * 2. Call dma_buf_pin() under the reservation lock.
> + * 3. On failure run the movable flow, or give up.
> + * 4. On success the storage stays put. Whether the exporter may
> still take it
> + *=C2=A0=C2=A0=C2=A0 away, which makes this the revoked flow instead of =
the pinned
> one, is the
> + *=C2=A0=C2=A0=C2=A0 exporter's choice and is not reported back.
> + *
> + * dma_buf_attach() is the shorthand for an importer which only ever
> wants the
> + * pinned flow. It passes no &dma_buf_attach_ops, and DMA-buf then
> pins around
> + * every dma_buf_map_attachment() and waits for the
> DMA_RESV_USAGE_KERNEL
> + * fences on the importer's behalf. Peer to peer needs
> + * dma_buf_dynamic_attach(), because
> &dma_buf_attach_ops.allow_peer2peer lives
> + * in the attach ops.
> + *
> + * Pinned flow:
> + *
> + * - Exporter: implement &dma_buf_ops.pin and &dma_buf_ops.unpin to
> hold the
> + *=C2=A0=C2=A0 storage still on request. An exporter whose storage never=
 moves
> implements
> + *=C2=A0=C2=A0 neither, and dma_buf_pin() then succeeds on its own. An
> exporter which
> + *=C2=A0=C2=A0 refuses to be pinned implements &dma_buf_ops.pin and fail=
s it.
> + * - Importer: nothing more. The mapping stays valid until it
> unmaps.
> + *
> + * Revoked flow:
> + *
> + * - Exporter: answer dma_buf_pin() as above. Call
> + *=C2=A0=C2=A0 dma_buf_invalidate_mappings() when the storage goes away =
and
> fail
> + *=C2=A0=C2=A0 &dma_buf_ops.map_dma_buf while it is gone. The two waits =
which
> complete a
> + *=C2=A0=C2=A0 revocation are described in dma_buf_invalidate_mappings()=
.
> + * - Importer: &dma_buf_attach_ops.invalidate_mappings has to unmap
> within
> + *=C2=A0=C2=A0 bounded time and drop the pin.
> + *
> + * Movable flow:
> + *
> + * - Exporter: call dma_buf_invalidate_mappings() before each move,
> then wait
> + *=C2=A0=C2=A0 for the &dma_buf.resv fences. &dma_buf_ops.pin and
> &dma_buf_ops.unpin play
> + *=C2=A0=C2=A0 no part here.
> + * - Importer: hold no pin. &dma_buf_attach_ops.invalidate_mappings
> drops the
> + *=C2=A0=C2=A0 cached mapping and has to lead to dma_buf_unmap_attachmen=
t()
> within
> + *=C2=A0=C2=A0 bounded time.

Hear I would want to see the exporter being allowed to force unmap the
dma mappings and reclaim thestorage when the fences mentioned above
have signaled, but the importer has not yet called
dma_buf_unmap_attachment(). That would allow importers to call
dma_buf_unmap_attachment() lazily, just before the next map_attachment,
which would allow simplifying importer implementations. More of a
related idea than something that needs fixing for this patch.

>  It need not stop the hardware, because access runs until the
> + *=C2=A0=C2=A0 importer's &dma_buf.resv fences retire. Map again before =
the
> next DMA.

A successful map will mean the exporter has placed the data in storage
compatible with what was agreed during attachment?

Thanks,
Thomas

