Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B062BCD4F48
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F152010E0A4;
	Mon, 18 May 2026 07:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Ro/navyn";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6259D10E0A4
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779088614;
 bh=KqXz31fFcllBghfI8pU+i0+gahHJxk311r9iPzSXzpE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ro/navyn0/DVaD7IcAs2bwN9U0+qbMBiTf0oUjhMcD0ROwgB/USIvQN1YZMsz174L
 qBnN+vWuGWz1lVeR2jYgmElu1mjPxSMMGXIGAjsej3MU7FVBjkaUWJZstMBCZOlCyO
 Lv4cAJJONcuvfiREYLHFMuSa+lE3sWIqJRj8ubGV6P0FReLdNK4Fk54j0akWhe7mYb
 Ym19npygDaWlq5bpJbStix+kkZv9vaF6FznF0nLYxsVhvf2siW6oSF6AwFgJReakda
 iiCScxbzTpDsRQNchfi+ZPOY5WefpAq+Cs+QuebRutmtjhkxc98uX1vYr3I/U2XKv+
 5Ebczo3CckW+Q==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BDEFE17E04E2;
 Mon, 18 May 2026 09:16:53 +0200 (CEST)
Date: Mon, 18 May 2026 09:16:50 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Marcin =?UTF-8?B?xZpsdXNhcno=?=
 <marcin.slusarz@arm.com>, Ketil Johnsen <ketil.johnsen@arm.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Steven Price
 <steven.price@arm.com>, Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Florent Tomasin <florent.tomasin@arm.com>, nd@arm.com
Subject: Re: [PATCH 4/8] drm/panthor: Add support for protected memory
 allocation in panthor
Message-ID: <20260518091650.5a7a4f4a@fedora>
In-Reply-To: <CAPaKu7QC7FdjL6m_OSb+E5aYKs6bmT-9DAHc5PC=XctCmRph2Q@mail.gmail.com>
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
 <20260505140516.1372388-5-ketil.johnsen@arm.com>
 <20260505181523.49a3d85c@fedora> <afxVIuVVPisBQ9p_@e129842.arm.com>
 <20260507135356.5428d50d@fedora> <agMvb_jeRsO7tSS-@e142607>
 <20260512161111.0cb7000e@fedora> <agNJasayW8VCHTiU@e142607>
 <CAPaKu7QC7FdjL6m_OSb+E5aYKs6bmT-9DAHc5PC=XctCmRph2Q@mail.gmail.com>
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

On Wed, 13 May 2026 12:31:32 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> On Tue, May 12, 2026 at 8:39=E2=80=AFAM Liviu Dudau <liviu.dudau@arm.com>=
 wrote:
> >
> > On Tue, May 12, 2026 at 04:11:11PM +0200, Boris Brezillon wrote: =20
> > > On Tue, 12 May 2026 14:47:27 +0100
> > > Liviu Dudau <liviu.dudau@arm.com> wrote:
> > > =20
> > > > On Thu, May 07, 2026 at 01:53:56PM +0200, Boris Brezillon wrote: =20
> > > > > On Thu, 7 May 2026 11:02:26 +0200
> > > > > Marcin =C5=9Alusarz <marcin.slusarz@arm.com> wrote:
> > > > > =20
> > > > > > On Tue, May 05, 2026 at 06:15:23PM +0200, Boris Brezillon wrote=
: =20
> > > > > > > > @@ -277,9 +286,21 @@ int panthor_device_init(struct panthor=
_device *ptdev)
> > > > > > > >                     return ret;
> > > > > > > >     }
> > > > > > > >
> > > > > > > > +   /* If a protected heap name is specified but not found,=
 defer the probe until created */
> > > > > > > > +   if (protected_heap_name && strlen(protected_heap_name))=
 { =20
> > > > > > >
> > > > > > > Do we really need this strlen() > 0? Won't dma_heap_find() fa=
il is the
> > > > > > > name is "" already? =20
> > > > > >
> > > > > > If dma_heap_find() will fail, then the whole probe with fail to=
o.
> > > > > > This check prevents that. =20
> > > > >
> > > > > Yeah, that's also a questionable design choice. I mean, we can
> > > > > currently probe and boot the FW even though we never setup the
> > > > > protected FW sections, so why should we defer the probe here? Can=
't we
> > > > > just retry the next time a group with the protected bit is create=
d and
> > > > > fail if we can find a protected heap? =20
> > > >
> > > > The problem we have with the current firmware is that it does a num=
ber of setup steps at "boot"
> > > > time only. One of the steps is preparing its internal structures fo=
r when it enters protected
> > > > mode and it stores them in the buffer passed in at firmware loading=
. We cannot later run the
> > > > process when we have a group with protected mode set. =20
> > >
> > > No, but we can force a full/slow reset and have that thing
> > > re-initialized, can't we? I mean, that's basically what we do when a
> > > fast reset fails: we re-initialize all the sections and reset again, =
at
> > > which point the FW should start from a fresh state, and be able to
> > > properly initialize the protected-related stuff if protected sections
> > > are populated. Am I missing something? =20
> >
> > Right, we can do that. For some reason I keep associating the reset wit=
h the
> > error handling and not with "normal" operations. =20
> I kind of hope we end up with either
>=20
>  - panthor knows the exact heap to use and fails with EPROBE_DEFER if
> the heap is missing, or
>  - panthor gets a dma-buf from userspace and does the full reset
>    - userspace also needs to provide a dma-buf for each protected
> group for the suspend buffer
>=20
> than something in-between. The latter is more ad-hoc and basically
> kicks the issue to the userspace.

Indeed, the second option is more ad-hoc, but when you think about it,
userspace has to have this knowledge, because it needs to know the
dma-heap to use for buffer allocation that cross a device boundary
anyway. Think about frames produced by a video decoder, and composited
by the GPU into a protected scanout buffer that's passed to the KMS
device. Why would the GPU driver be source of truth when it comes to
choosing the heap to use to allocate protected buffers for the video
decoder or those used for the display?

>=20
> For the former, expressing the relation in DT seems to be the best,
> but only if possible :-). Otherwise, a kconfig option (instead of
> module param) should be easier to work with.
>=20
> Looking at the userspace implementation, can we also have an panthor
> ioctl to return the heap to userspace?

Yes, it's something we can add, but again, I'm questioning the
usefulness of this: how can we ensure the heap used by panthor to
allocate its protected FW buffers is suitable for scanout buffers
(buffers that can be used by display drivers). There needs to be a glue
leaving in usersland and taking the decision, and I'm not too sure
trusting any of the component in the chain (vdec, gpu, display) is the
right thing to do.
