Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D0606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VPrdVG0j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C8110ED9D;
	Mon, 16 Nov 2026 11:02:04 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B58310ED9D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=Rf8qt+Zh3EUE2lSQ6kbDmdifzLtndza1jl085CZIWqw=; t=1794826917; x=2110186917; 
 b=VPrdVG0jhhG3yMRNe030Mf9rbzTYQGrAga8je0BoBTbcP1ZB5R/8pQsPx566RTEUjgEjIWdEDGQ
 4UPRB4QitwtGPffq9OdE7ZUkM4Bka2XwlIC2VkwRqUZ8gD50mNxWD3SUEn9Bhg98M4X1AqyHwu+nq
 6ZqtMwJgRaV+5BR9Cimm1vmYf5tfNUtl2REaFUKFM4lIX3v+nbQcgAnfQYgOXOyLjbQwl0q5D0sie
 9Xyninze5d3SswgPGdEe0O8xrc4iHQ68t0jox9BwtUf0WIW16bRJ5Wwfwt3ah+8zmlU5Oz3R8+ZS+
 ZdBOX2OQCrNXGZC3hr7g2uPMymYrbv3JPyqQ==;
Received: from [137.101.48.64] (helo=[192.168.0.17])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xSuTA-000000009mR-1nOX; Mon, 16 Nov 2026 12:01:52 +0100
Message-ID: <08699944b70494159b0f750c1ffb4d8dc14bfe82.camel@igalia.com>
Subject: Re: [PATCH v2 0/3] drm/vc4: Fix async page flip completion
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Raspberry Pi Kernel Maintenance
 <kernel-list@raspberrypi.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org
Date: Mon, 16 Nov 2026 12:01:41 +0100
In-Reply-To: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
References: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks! Looks good to me:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El s=C3=A1b, 14-11-2026 a las 16:16 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> VC4 implements async page flips with a custom code path that waits
> for
> the BO fence before completing the flip. On VC4_GEN_4 (RPi 0-3), the
> completion also decrements the usecnt of the old FB's BO. This series
> fixes three bugs in that path.
>=20
> Since commit e8941ac97f28 ("drm/vc4: Remove BOs seqnos"), the
> completion
> runs from a dma_fence callback. VC4 signals that fence from the
> render
> job IRQ handler. As v
> c4_bo_dec_usecnt() takes a mutex, running an SDL
> application with SDL_VIDEODRIVER=3Dkmsdrm on the RPi 3 triggers:
>=20
> =C2=A0 [ 2511.636319] BUG: sleeping function called from invalid context
> at kernel/locking/mutex.c:623
> =C2=A0 [ 2511.636667] in_atomic(): 1, irqs_disabled(): 1, non_block: 0,
> pid: 0, name: swapper/0
> =C2=A0 [ 2511.636681] preempt_count: 1000002, expected: 0
> =C2=A0 [ 2511.636689] RCU nest depth: 0, expected: 0
> =C2=A0 [ 2511.636698] locks held by swapper/0/0: 1, on CPU#0:
> =C2=A0 [ 2511.636711]=C2=A0 #0: ffff000037183198 (&fence->inline_lock){-.=
..}-
> {3:3}, at: dma_fence_signal+0x88/0xec
> =C2=A0 <snip>
> =C2=A0 [ 2511.636892] Hardware name: Raspberry Pi 3 Model B Plus Rev 1.3
> (DT)
> =C2=A0 [ 2511.636899] Call trace:
> =C2=A0 <snip>
> =C2=A0 [ 2511.636991]=C2=A0 mutex_lock_nested+0x24/0x30
> =C2=A0 [ 2511.637002]=C2=A0 vc4_bo_dec_usecnt+0x40/0x124 [vc4]
> =C2=A0 [ 2511.637070]=C2=A0 vc4_async_page_flip_complete_with_cleanup+0xa=
0/0xc4
> [vc4]
> =C2=A0 [ 2511.637102]=C2=A0 dma_fence_signal_timestamp_locked+0x118/0x290
> =C2=A0 [ 2511.637116]=C2=A0 dma_fence_signal+0x9c/0xec
> =C2=A0 [ 2511.637126]=C2=A0 vc4_irq_render_job_done+0x24/0x114 [vc4]
> =C2=A0 [ 2511.637158]=C2=A0 vc4_irq+0x16c/0x274 [vc4]
>=20
> While looking into this issue, I also noticed that, since commit
> 4d12c36fb73b ("drm/vc4: crtc: Move the BO handling out of common
> page-flip
> callback"), the old FB is released before decrementing its BO usecnt.
> If
> userspace removes the old FB and closes its handle while the flip is
> pending, vc4_bo_dec_usecnt() runs on a freed or recycled BO.
>=20
> Patch 1 fixes the use-after-free, patch 2 moves the completion to a
> worker
> and patch 3 returns fence lookup errors to userspace instead of
> leaving
> the flip pending forever.
>=20
> In v1, Sashiko reported that a flip waiting on its fence can complete
> after, or concurrently with, a later flip that has no fence. This has
> been
> possible since commit 82faa3276012 ("drm/vc4: kms: Remove async
> modeset
> semaphore") and isn't changed by this series. The best way to fix it
> would be moving to the generic async helpers, which is on my TODO
> list.
> Until then, this series keeps the current behavior and only fixes the
> bugs
> above.
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> ---
> v1 -> v2:
> https://lore.kernel.org/r/20261112-vc4-async-flip-fixes-v1-0-42449a703840=
@igalia.com
>=20
> - [1/3] Add the refcount underflow warning to the commit message.
> - [2/3] Allocate the workqueue after initializing the CRTC, so it's
> =C2=A0 released before the CRTC is cleaned up and named after the CRTC
> (Sashiko).
> - [3/3] New patch.
>=20
> ---
> Ma=C3=ADra Canal (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Drop BO usecnt before releasing t=
he old FB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Complete async page flips from an=
 ordered workqueue
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Look up the async page flip fence=
 before committing
> the flip
>=20
> =C2=A0drivers/gpu/drm/vc4/vc4_crtc.c | 136 +++++++++++++++++++-----------=
-
> ----------
> =C2=A0drivers/gpu/drm/vc4/vc4_drv.h=C2=A0 |=C2=A0=C2=A0 6 ++
> =C2=A02 files changed, 70 insertions(+), 72 deletions(-)
> ---
> base-commit: d48ea86919434695da12d280dccab72b094397e1
> change-id: 20261111-vc4-async-flip-fixes-1b1ab17dc795
>=20
>=20

