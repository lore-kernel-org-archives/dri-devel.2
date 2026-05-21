Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC61ACD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 09:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52FDD10E05E;
	Thu, 21 May 2026 09:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="AGmBTyA7";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E6410E05E
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779354066;
 bh=HkYvTVcPzSTc+LKOwW4MxrM8I91nfQVQdqotlUSn+lA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AGmBTyA7gH4ux1s88NG7277H5LLbOvuOMz20+ai56lyumT0m4etdK9ZrKA/OhZPvZ
 DQcKB6ioFVSXqHWyMuWrqzvM4aqjcta50N4XSC3fz7YNRL5Y6oYNp1XngR0zcoVE4p
 tCkyZbBpYTPocrQq02wdiEJAB4/S8dSQNyN5hZvb4MgEuceLmC6+Q2B4O0tISVk8aa
 g1BNL/pxVbF9oceU4ybUnO91sFPXaDdOY9LzhebV0Rjp+p6cIEQEQylCweK9d4wrkB
 lu/YPi74aPQiQW4RLc71oiyVWCC5DRfaD65eLqh66aka+6qqlWEQy8SNzs5+YLozUQ
 JsNOs2SZzZ5+w==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1126D17E107C;
 Thu, 21 May 2026 11:01:06 +0200 (CEST)
Date: Thu, 21 May 2026 11:01:00 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dma-resv: Define guards for context-less dma_resv
 locks
Message-ID: <20260521110100.598baadb@fedora>
In-Reply-To: <20260521105402.4bc4b1e5@fedora>
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-2-f2d8c15a97ce@collabora.com>
 <03a57011-e734-4a74-aef2-e3a6016e15fc@amd.com>
 <20260518111456.30ba9bba@fedora>
 <a9ee80aa-0c9b-4bd7-87bb-d3e228357b18@amd.com>
 <20260518161531.331cab2d@fedora>
 <d793568d-9611-4174-b9e9-c71ffec5ae93@amd.com>
 <20260521105402.4bc4b1e5@fedora>
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

On Thu, 21 May 2026 10:54:02 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Thu, 21 May 2026 10:36:47 +0200
> Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
>=20
> > On 5/18/26 16:15, Boris Brezillon wrote: =20
> > > On Mon, 18 May 2026 14:18:41 +0200
> > > Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> > >    =20
> > >> On 5/18/26 11:14, Boris Brezillon wrote:   =20
> > >>> Hi Christian,
> > >>>
> > >>> On Mon, 18 May 2026 09:10:23 +0200
> > >>> Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> > >>>      =20
> > >>>> On 5/13/26 18:58, Boris Brezillon wrote:     =20
> > >>>>> When used without a context, dma_resv are no different from regul=
ar
> > >>>>> locks. Define guards so we can use the guard-syntactic sugars for
> > >>>>> explicit/implicit scoped locks.
> > >>>>>
> > >>>>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>   =
    =20
> > >>>>
> > >>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >>>>
> > >>>> How do you want to upstream it? My preference would be drm-misc-ne=
xt, but I think I can live with a panthor specific branch as well.     =20
> > >>>
> > >>> Everything Panthor related goes through drm-misc-next, so drm-misc-=
next
> > >>> also has my preference ;-). But I'd like to wait for more feedback =
on
> > >>> the other drm patches, and there are a few things I need to address=
 in
> > >>> the panthor patches anyway, so it's likely to take a couple more we=
eks
> > >>> for this series to hit the drm-misc tree, unless you have a good re=
ason
> > >>> to fast-track this specific patch.     =20
> > >>
> > >> Well the DMA-buf code itself uses dma_resv_lock/unlock   =20
> > >=20
> > > There's no use in dma-resv.c that can be converted to guards. I gave
> > > dma-buf.c a try, but just like for panthor, I don't really like the f=
act
> > > it's halfway through (other locks still use manual locking), so I'd be
> > > tempted to convert everything at once for consistency. If you're fine
> > > with that, I can give this a try.   =20
> >=20
> > Well depends on what everything means. I would only convert dma-buf.c i=
n one patch and nothing else. =20
>=20
> By everything I mean all type of locks, not just dma_resv ones.

BTW, I actually did more than just dma-buf.c [1], let me know what you
want from there and I'll ditch the rest.

[1]https://gitlab.freedesktop.org/bbrezillon/linux/-/commits/b4/panthor-gua=
rd-refactor
