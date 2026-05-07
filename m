Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAE0CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B73F10F076;
	Thu,  7 May 2026 11:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="fPmUsP6B";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A04010F076
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778154843;
 bh=6BJjaGOruHF5NtcX/6zf6Bu/wTeaT/tj56yBW3eKEjU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fPmUsP6Biz1SZnJghN6tCtUsycAXbfsN/MzfNobVHwNqgB9kUdtzRDrm7ogE3kUmV
 1KDDDRUWg2fjogTnUTYzgF84lYdKCv6j/In8onWuNjag38GBGDvUnROplZj2yWZhfL
 NkM1qmranfx0+bTAFnW3K5+3qzk/cZ6W9Vmu4X+KK7wK0pOHDN34U4vAiHVUfXeg6Z
 VV+J44rQsAIf+Bk6E7Pe3FkLjB/Wl1R5/SFqZlP8qc3JfmltvLQveBlZNxBGuINO9h
 +ICAiSORgAbWgWhwR5Dc7w958IByNyyynEWatcnxaomqoIEzijteBXQrJZekWZmmyG
 cp7GXoQgAYdmA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E4C6717E131F;
 Thu,  7 May 2026 13:54:02 +0200 (CEST)
Date: Thu, 7 May 2026 13:53:56 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Marcin =?UTF-8?B?xZpsdXNhcno=?= <marcin.slusarz@arm.com>
Cc: Ketil Johnsen <ketil.johnsen@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Florent Tomasin <florent.tomasin@arm.com>, nd@arm.com
Subject: Re: [PATCH 4/8] drm/panthor: Add support for protected memory
 allocation in panthor
Message-ID: <20260507135356.5428d50d@fedora>
In-Reply-To: <afxVIuVVPisBQ9p_@e129842.arm.com>
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
 <20260505140516.1372388-5-ketil.johnsen@arm.com>
 <20260505181523.49a3d85c@fedora> <afxVIuVVPisBQ9p_@e129842.arm.com>
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

On Thu, 7 May 2026 11:02:26 +0200
Marcin =C5=9Alusarz <marcin.slusarz@arm.com> wrote:

> On Tue, May 05, 2026 at 06:15:23PM +0200, Boris Brezillon wrote:
> > > @@ -277,9 +286,21 @@ int panthor_device_init(struct panthor_device *p=
tdev)
> > >  			return ret;
> > >  	}
> > > =20
> > > +	/* If a protected heap name is specified but not found, defer the p=
robe until created */
> > > +	if (protected_heap_name && strlen(protected_heap_name)) { =20
> >=20
> > Do we really need this strlen() > 0? Won't dma_heap_find() fail is the
> > name is "" already? =20
>=20
> If dma_heap_find() will fail, then the whole probe with fail too.
> This check prevents that.

Yeah, that's also a questionable design choice. I mean, we can
currently probe and boot the FW even though we never setup the
protected FW sections, so why should we defer the probe here? Can't we
just retry the next time a group with the protected bit is created and
fail if we can find a protected heap?

> I'm not sure why it's needed at all, but if
> it is really needed, then s/strlen(protected_heap_name)/protected_heap_na=
me[0]/
> would simplify this.

It's not so much about how you do the test, and more about the case
you're trying to protect against. I guess here you assume that
panthor.protected_heap_name=3D"" means "I don't have a protected heap for
you". If it's deemed acceptable, this should most certainly be
described somewhere.

>=20
> > > +		ptdev->protm.heap =3D dma_heap_find(protected_heap_name);
> > > +		if (!ptdev->protm.heap) {
> > > +			drm_warn(&ptdev->base,
> > > +				 "Protected heap \'%s\' not (yet) available - deferring probe",
> > > +				 protected_heap_name);
> > > +			ret =3D -EPROBE_DEFER;
> > > +			goto err_rpm_put; =20
> >=20
> > If you move the heap retrieval before the rpm enablement, you can get
> > rid of this goto err_rpm_put.
> >  =20
> > > +		}
> > > +	}
> > > +
> > >  	ret =3D panthor_hw_init(ptdev);
> > >  	if (ret)
> > > -		goto err_rpm_put;
> > > +		goto err_dma_heap_put;
> > > =20
> > >  	ret =3D panthor_pwr_init(ptdev);
> > >  	if (ret) =20

