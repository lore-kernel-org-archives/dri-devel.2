Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8578C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99BB010F2B6;
	Wed,  2 Sep 2026 16:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DNryGjUE";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569AB10F2B6
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 16:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788366557;
 bh=07wNkN/lOeWwRJbukv6jdoiif6PmME2dJsvO3j8+vJY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DNryGjUExz6UC5CnJUZrVNbrAxYLxqF/bsFTTtfvl0M5hTH92MTRW5C0ZPv0B4pkb
 Awc6yqOLuXMFdZ7QM2ZNLwAa4vcgZW0IqnZYx7XA3DGM/tm82lhdkT8eBsYGebujKS
 rCWZDZcVDI0AnCk86XDNW+lvEj+XP1Im2BfJiPe/MLOcdw5GH5HDDPlofEmqgHqX2/
 YYYA8k51nMXgb9DKnrw6aso/GIJXqaLYEH9ngtK3jFOQZSpStOzCPjQ8ZXGgzKhcA3
 /SNQl3Z95boCVkxQocQRTIzPdReKOb3cJydQmdPXK5XrF0/O71SIDQd1nTGVJ2xjtP
 LWuzxuY0i8vLA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4269E17E0DD8;
 Wed, 02 Sep 2026 18:29:16 +0200 (CEST)
Date: Wed, 2 Sep 2026 18:29:10 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 13/17] drm/panfrost: Skip cache flush/invalidate when
 enabling perfcnt
Message-ID: <20260902182910.6d47e05b@fedora-21.home>
In-Reply-To: <aphECpYnFuwIgzPQ@sobremesa>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-13-72a13b2c125d@collabora.com>
 <20260901153233.261fb14d@fedora-21.home>
 <aphECpYnFuwIgzPQ@sobremesa>
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

On Wed, 2 Sep 2026 16:43:34 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> On 01.09.2026 15:32, Boris Brezillon wrote:
> > On Fri, 28 Aug 2026 21:56:53 +0100
> > Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> >  =20
> > > The GPU cache flush/invalidate operation is unnecessary, because at p=
resent
> > > all counters are always enabled for all sessions, and there are no pl=
ans to
> > > expand the uAPI so as to let UM select specific counter groups.
> > >=20
> > > If the above was ever implemented, then different counter groups being
> > > selected between sessions might leave stale data in the GPU caches, so
> > > the flush/invalidate would have to be reintroduced. =20
> >=20
> > This explanation confuses me. To me, the reason we don't need a
> > cache-flush has nothing to do with the fact we always enable all
> > counters, it's just that, either the perfcnt buffer has been freshly
> > allocated/mapped and the cache has no entry pointing to it, or it's
> > been written already, and the flush should have happened after the
> > dump. For the case where the enable happens after a RESET (which you
> > introduce in one of the remaining commits, I guess), there's no flush
> > needed either, because the RESET clears all the caches. =20
>=20
> This is something I wrote after a chat with Steven about whether removing=
 this flush/invalidate was fine.
> If memory serves me right, he expressed his concern that flushing GPU cac=
hes after a sample might write
> disabled counter data into system memory, but in that case UM should know=
 better, and I guess reading off
> disabled counter data is seen as undefined behaviour in the TRM.

That's still 'after a SAMPLE' though. I see no reason why one would
want to flush things at enable time. To me, the ENABLE step is just
about resetting the internal counters and activating the counting.
Those values are not written directly to memory, the SAMPLE operation
is what transfer those internal counters to the piece of memory you've
provided, and that's when you want the FLUSH to happen, I think.
