Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E486FCD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4931510E883;
	Mon, 18 May 2026 14:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MjR5dh6D";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE8310E890
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779113735;
 bh=QDhP2ywyXlpxq310WYLb3KtdttgJ/FJZ9LPyfSF/Qxk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MjR5dh6DsJgL0f40EMCWwtquK5OJ/A/kVSwXGNDcgSomQblUUjk8ZTwjRW3ENLNrs
 aiJfPViRQVbayYcHJ5w6Z67KNWoebKyOi3echpl6ZFlozTqWd6xYAVsleIjLVVTXjf
 d45/S10lQa/h9nykuB1QorwzPVinCUd/10e0iG9fY0sZuMhu3nPtmU/AcTTpaMjv2E
 Bth3MqjjCZqzo3LzfKzg9sBu4eNgCPM4m+CY0tUPWW1EuwvqjeZrXWLJw2Y84ocqNe
 3RdZvqYVsovVTElND8wBV8oVrhdqjGToQJErRh5s24fuPU6igUxKNAgTzfkrS3KO20
 /E20WxyY+UuLg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D05117E04E2;
 Mon, 18 May 2026 16:15:35 +0200 (CEST)
Date: Mon, 18 May 2026 16:15:31 +0200
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
Message-ID: <20260518161531.331cab2d@fedora>
In-Reply-To: <a9ee80aa-0c9b-4bd7-87bb-d3e228357b18@amd.com>
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-2-f2d8c15a97ce@collabora.com>
 <03a57011-e734-4a74-aef2-e3a6016e15fc@amd.com>
 <20260518111456.30ba9bba@fedora>
 <a9ee80aa-0c9b-4bd7-87bb-d3e228357b18@amd.com>
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

On Mon, 18 May 2026 14:18:41 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> On 5/18/26 11:14, Boris Brezillon wrote:
> > Hi Christian,
> >=20
> > On Mon, 18 May 2026 09:10:23 +0200
> > Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> >  =20
> >> On 5/13/26 18:58, Boris Brezillon wrote: =20
> >>> When used without a context, dma_resv are no different from regular
> >>> locks. Define guards so we can use the guard-syntactic sugars for
> >>> explicit/implicit scoped locks.
> >>>
> >>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>   =20
> >>
> >> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>
> >> How do you want to upstream it? My preference would be drm-misc-next, =
but I think I can live with a panthor specific branch as well. =20
> >=20
> > Everything Panthor related goes through drm-misc-next, so drm-misc-next
> > also has my preference ;-). But I'd like to wait for more feedback on
> > the other drm patches, and there are a few things I need to address in
> > the panthor patches anyway, so it's likely to take a couple more weeks
> > for this series to hit the drm-misc tree, unless you have a good reason
> > to fast-track this specific patch. =20
>=20
> Well the DMA-buf code itself uses dma_resv_lock/unlock

There's no use in dma-resv.c that can be converted to guards. I gave
dma-buf.c a try, but just like for panthor, I don't really like the fact
it's halfway through (other locks still use manual locking), so I'd be
tempted to convert everything at once for consistency. If you're fine
with that, I can give this a try.

> and obviously has test cases for all the different variants.

Looks like the test cases all validate that dma_resv_lock(x, NULL)
returns 0. If I were to convert those to guard(dma_resv)(), these checks
would be gone. Is that okay with you?
