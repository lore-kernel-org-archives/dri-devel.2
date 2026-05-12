Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2B7CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 14:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 404FC10E215;
	Tue, 12 May 2026 14:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HfiHYnEs";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0AE610E215
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778595078;
 bh=ffnSOLr6GBRvN/RNrGZcqdQPL9WDigCoPM7fdgwRrkM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HfiHYnEsvlaGP8rXHMzyPOvqqCmbexRYDSqS7YdPq/NwKBFXqNQZucTJlKvSPvs6N
 bQEhjDnFB5iHZ4TngCrePrDeNE6o6Bvgpxllw0d75usAc1NR6HvluYWni2NJopiDRI
 86qPMBksnJSMJEmIc3ojTu/JVZgi9qGmlmiXngJlggUUebkB/TGJRfiBJwLD84rFDV
 OnhnS4h4nXnGTF6iC75b1H6EoiUE3RyNWTM4C+t0TL2mN2b3Niq51V/iGCXGpEwWjk
 52R8MJIdUqkeCRYwCPvihSkxBzJYZqA/D5pKKdhsATj+Rl5B7QS6Pp/8xc0d4UHxn6
 V/S1XclaHmC1g==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 50EAF17E040C;
 Tue, 12 May 2026 16:11:17 +0200 (CEST)
Date: Tue, 12 May 2026 16:11:11 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Marcin =?UTF-8?B?xZpsdXNhcno=?= <marcin.slusarz@arm.com>, Ketil Johnsen
 <ketil.johnsen@arm.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey
 <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T.J. Mercier"
 <tjmercier@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Steven Price <steven.price@arm.com>, Daniel
 Almeida <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Florent Tomasin <florent.tomasin@arm.com>, nd@arm.com
Subject: Re: [PATCH 4/8] drm/panthor: Add support for protected memory
 allocation in panthor
Message-ID: <20260512161111.0cb7000e@fedora>
In-Reply-To: <agMvb_jeRsO7tSS-@e142607>
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
 <20260505140516.1372388-5-ketil.johnsen@arm.com>
 <20260505181523.49a3d85c@fedora> <afxVIuVVPisBQ9p_@e129842.arm.com>
 <20260507135356.5428d50d@fedora> <agMvb_jeRsO7tSS-@e142607>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 12 May 2026 14:47:27 +0100
Liviu Dudau <liviu.dudau@arm.com> wrote:

> On Thu, May 07, 2026 at 01:53:56PM +0200, Boris Brezillon wrote:
> > On Thu, 7 May 2026 11:02:26 +0200
> > Marcin =C5=9Alusarz <marcin.slusarz@arm.com> wrote:
> >  =20
> > > On Tue, May 05, 2026 at 06:15:23PM +0200, Boris Brezillon wrote: =20
> > > > > @@ -277,9 +286,21 @@ int panthor_device_init(struct panthor_devic=
e *ptdev)
> > > > >  			return ret;
> > > > >  	}
> > > > > =20
> > > > > +	/* If a protected heap name is specified but not found, defer t=
he probe until created */
> > > > > +	if (protected_heap_name && strlen(protected_heap_name)) {   =20
> > > >=20
> > > > Do we really need this strlen() > 0? Won't dma_heap_find() fail is =
the
> > > > name is "" already?   =20
> > >=20
> > > If dma_heap_find() will fail, then the whole probe with fail too.
> > > This check prevents that. =20
> >=20
> > Yeah, that's also a questionable design choice. I mean, we can
> > currently probe and boot the FW even though we never setup the
> > protected FW sections, so why should we defer the probe here? Can't we
> > just retry the next time a group with the protected bit is created and
> > fail if we can find a protected heap? =20
>=20
> The problem we have with the current firmware is that it does a number of=
 setup steps at "boot"
> time only. One of the steps is preparing its internal structures for when=
 it enters protected
> mode and it stores them in the buffer passed in at firmware loading. We c=
annot later run the
> process when we have a group with protected mode set.

No, but we can force a full/slow reset and have that thing
re-initialized, can't we? I mean, that's basically what we do when a
fast reset fails: we re-initialize all the sections and reset again, at
which point the FW should start from a fresh state, and be able to
properly initialize the protected-related stuff if protected sections
are populated. Am I missing something?
