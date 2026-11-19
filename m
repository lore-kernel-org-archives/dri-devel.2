Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131D606A32F
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Jdr2aFT/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 052F6112089;
	Thu, 19 Nov 2026 08:18:07 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F3011208C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=cKNnXRxwc7qIR50Hs6GqKcaRO1r0IQSK7B3OlbA6Vhg=; t=1795076280; x=2110436280; 
 b=Jdr2aFT/LyTjwb35Vx1vOgK1cDf8BAGfWGSfKDmlaAkdQcydpzVnFTCvzOdc3ra3dhDDkXtIT1E
 3APHkBsvWf7JkrRAgXJW7YMDzSP8G1Qtl33vUxemFZZ4tfHCOoebR1Sd02YTTlf/+KEYyPMJ2/R2a
 xMylUXCToEK4KaWYSqdvjw6hoLwKy9eYompbfNpGIokeoxldW7kUTgiLqQYfOr2SNrqaELMpHTlh+
 2jdDL5VVQNCGfCU0jDuq/RhguHuQc6/hV0XVv5P+oFd02DoxenvDvq/PWWtSFjDd6EKTsfPnqPsn8
 X/rXq/RHxa7V2Vkzdm8McvL8so86ViPsfEXg==;
Received: from [192.168.12.229] by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xTxLB-00000001MPj-3hij; Thu, 19 Nov 2026 09:17:57 +0100
Message-ID: <e945bdd00b4eecec4b7e451e35cb39855ad2e0de.camel@igalia.com>
Subject: Re: [PATCH 0/4] drm/vc4: Work around GFXH-16 instruction cache
 livelock
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, "Juan A. Suarez
 Romero" <jasuarez@igalia.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Raspberry Pi Kernel Maintenance
 <kernel-list@raspberrypi.com>, Maxime Ripard <mripard@kernel.org>, David
 Airlie <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org
Date: Thu, 19 Nov 2026 09:17:57 +0100
In-Reply-To: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
References: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
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

Looks good to me:
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

I was not aware that hang checks were happening at second boundaries,
regardless of the time at which the hangcheck was queued, it doesn't
sound like a good idea, so I think it is good to change that.

On the other hand, now we rearm the hang check every 100ms instead
which is a much smaller window. I understand this reduces visible
impact of the workaround when the issue happens, but I am wondering
whether this alone has any visible performance impact for the 99% of
the time we are not hitting the problem, I presume you haven't seen
any?

Iago

El mi=C3=A9, 18-11-2026 a las 18:47 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> Mesa issue #16652 [1] reports GPU resets every few minutes on the
> Raspberry Pi 3. They happen when text labels are drawn over their
> shadows:
> two different threaded fragment shaders, plus untextured single-
> threaded
> ones, in the same tiles.
>=20
> During a hang, the performance counters show four QPUs fetching
> instructions with 0 cache hits, ~6.5M misses per 100 ms, and 0 valid
> instructions executed. This matches HW erratum GFXH-16: the QPUs of a
> slice share one instruction cache and can livelock, evicting each
> other's
> fills. Since shader code always starts at offset 0 of a page-aligned
> BO,
> every shader competes for the same cache sets.
>=20
> This series works around it:
>=20
> =C2=A0 - Patch 3 starts each shader's code at one of four offsets in its
> BO,
> =C2=A0=C2=A0=C2=A0 spreading shaders across cache sets.
>=20
> =C2=A0 - Patch 4 clears the slice instruction and uniforms caches when th=
e
> =C2=A0=C2=A0=C2=A0 hangcheck finds no progress, and resets the GPU only i=
f the stall
> =C2=A0=C2=A0=C2=A0 persists. It is meant to recover from livelocks the of=
fsets don't
> =C2=A0=C2=A0=C2=A0 prevent.
>=20
> Patches 1 and 2 fix an off-by-one in the shader BO handle check and a
> NULL pointer dereference in validate_gl_shader_rec(), found while
> working
> on patch 3.
>=20
> Tested on a Raspberry Pi 3B+ with the issue's reproducer, 4 x 15 min
> runs:
>=20
> =C2=A0 without the series:=C2=A0 29 GPU resets
> =C2=A0 with patches 1-3:=C2=A0=C2=A0=C2=A0=C2=A0 0 GPU resets
>=20
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/issues/16652
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> ---
> Ma=C3=ADra Canal (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Fix off-by-one in the shader reco=
rd BO handle check
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Check for a validated shader befo=
re reading its thread
> mode
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Start shader code at varying offs=
ets in its BO
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Clear the slice caches before res=
etting a stalled GPU
>=20
> =C2=A0drivers/gpu/drm/vc4/vc4_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 43
> +++++++++++++++++++++++-------
> =C2=A0drivers/gpu/drm/vc4/vc4_drv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++++++-
> =C2=A0drivers/gpu/drm/vc4/vc4_gem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 ++++++++++++--
> =C2=A0drivers/gpu/drm/vc4/vc4_validate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 17 +++++++-----
> =C2=A0drivers/gpu/drm/vc4/vc4_validate_shaders.c |=C2=A0 7 ++---
> =C2=A05 files changed, 79 insertions(+), 23 deletions(-)
> ---
> base-commit: 80ac6d197218c3399d66674167a4d7c9051a25e2
> change-id: 20261112-vc4-icache-workaround-d11b444bc7e8
>=20
>=20

