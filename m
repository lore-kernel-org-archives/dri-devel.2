Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2982606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFxv6u9/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB85410E84D;
	Sun, 22 Nov 2026 17:24:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B6810E816
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 17:24:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 513EC417F8;
 Sun, 22 Nov 2026 17:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06A31F000C0;
 Sun, 22 Nov 2026 17:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795368264;
 bh=5cA6tv+oYevkW51Cz6Z48eQLMDD1Exkr3moCEav2aA4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ZFxv6u9/EgemnDAEfWpc07xxfIsaPXIFWwoqVwf7UHhVhZvffs2jZMmdkVaxCn5Jz
 3UA/lv0IqvQMFn5wGF1IgDRL1moHvf45J2PAC9hqXAfCc6iyQyH5QM0w4Rwm9Bwrlt
 3Hcg/KWFLKtIIRkykSO9a88J1eCm9Zlcda3VORq6AwoO3e97mfIW2VuGvSCUXR9AVA
 Jd9+trnBzbVFupeY7VJZKg0xlItDwvwXTqVW7+oM0kiU5cMXvJ1tR/G+gjjIgkN7Gn
 sSTx2KZKxjazV2L6DBBGc2loJ8FmcvratBXuqkni2UZvfKcWyqJCEv6j4AMPaG6P6/
 NsYrwaJ0vYVsQ==
Message-ID: <sashiko-outbox-228143@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [REGRESSION] nouveau: GM108 hangs at boot since
 "drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts"
 (6.18.64)
To: "R. V. Lobato" <vieira.lobato@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261121101350.bab69dff11a2@gmail.com>
References: <20261121101350.bab69dff11a2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 17:24:24 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/nouveau: missing Signed-off-by trailer and raw email commit
  message
- [Medium] drm/nouveau/devinit: reverting fallback in
  gf100_devinit_preinit() vs device->disp
- [Low] drm/nouveau/devinit: missing Fixes trailer for commit
  15465d681517
--

commit f69e16ffb3a4936b58c7bf63ef33b8ce793b99f6
Author: R. V. Lobato <vieira.lobato@gmail.com>

> nouveau: GM108 hangs at boot since "drm/nouveau/devinit/gf100-: try to av=
oid double-running vbios scripts" (6.18.64)
>
> Hi,
>
> The 6.18.64 backport 15465d681517 ("drm/nouveau/devinit/gf100-: try
> to avoid double-running vbios scripts", upstream 2139cb633d48, review
> patch 426/686 <20261113153835.372076643@linuxfoundation.org>) breaks
> nouveau on my GM108 laptop GPU. The machine hangs during boot.
> 6.18.63 works. Reverting only the gf100.c hunk of this commit on top
> of 6.18.64 fixes it.
>
> Hardware: HP Spectre x360 15-bl0XX, BIOS F.04, Intel HD 620 (i915,
> drives the panel) + NVIDIA GM108M [GeForce 940MX] [10de:134d], no
> display engine, runtime PM enabled.
>
> On 6.18.64 the VRAM size is garbage and the boot stops shortly after:
>
>   nouveau 0000:01:00.0: NVIDIA GM108 (1180d0a2)
>   nouveau 0000:01:00.0: bios: version 82.08.62.00.15
>   nouveau 0000:01:00.0: fb: -1159778304 MiB GDDR5
>   nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 6013d4 [ PRIV=
RING ]
>   nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 10f65c [ PRIV=
RING ]
>   nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 17e280 [ PRIV=
RING ]
>   (no "drm: VRAM", no "Initialized nouveau"; the system hangs)
>
> On 6.18.63 the same machine prints "fb: 2048 MiB GDDR5" and nouveau
> initializes normally.
>
> My reading of the cause: the new code in gf100_devinit_preinit() runs
> the VGA CRTC check only when
>
>   !(nvkm_devinit_disable(base) & (1ULL << NVKM_ENGINE_DISP))
>
> The guard expects nvkm_devinit_disable() to return a mask of disabled
> engines. In 6.18.64 it calls the void ->disable() hook, which disables
> subdevs with nvkm_subdev_disable(), and then always returns 0. So the
> guard is always true, also on boards without a display engine. On
> GM108 the VGA CRTC reads hit the PRIVRING fault at 0x6013d4 and, I
> infer, return a nonzero value (I did not log it), so post is set to
> false, the VBIOS init scripts never run, and the memory controller is
> left uninitialized.
>
> nouveau.config=3DNvForcePost=3D1 lets the machine boot, but only fixes the
> first init, because force_post is cleared after the first preinit.
> On every runtime resume of the GPU the check skips devinit again:
>
>   [   35.770421] nouveau 0000:01:00.0: Enabling HDA controller
>   [   35.805652] nouveau 0000:01:00.0: fifo: fault 01 [WRITE] at 00000000=
00120000 engine 05 [BAR2] client 08 [HUB/HOST_CPU_NB] reason 02 [PTE] on ch=
annel -1 [007fd38000 unknown]
>   [   35.806084] nouveau 0000:01:00.0: fifo: SCHED_ERROR 20 []
>   ...
>   [   75.453651] WARNING: CPU: 0 PID: 1081 at nvkm_runl_cgrp_get_cgid+0x7=
9/0x110 [nouveau]
>
> Counts per boot:
>
>   kernel                        runtime resumes  fifo faults  SCHED_ERROR=
  WARNINGs
>   6.18.63 (two boots)           25 / 30          0            0          =
  0
>   6.18.64 + NvForcePost=3D1       2                31           103381   =
    39
>   6.18.64 + gf100.c hunk revert 3                0            0          =
  0
>
> The revert I use (restores 6.18.63's gf100.c exactly):

[Severity: High]
This commit lacks a Signed-off-by: trailer certifying the Developer's
Certificate of Origin.  The commit message and subject are also formatted a=
s a
raw mailing list bug report email rather than a kernel changelog with a
standard subsystem prefix.

[Severity: Low]
Should this regression fix include:

  Fixes: 15465d681517 ("drm/nouveau/devinit/gf100-: try to avoid double-run=
ning vbios scripts")

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c b/driver=
s/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> index 186e09ea0cb10..5368e705e7fd6 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c

[ ... ]

> @@ -100,25 +99,6 @@ gf100_devinit_preinit(struct nvkm_devinit *base)
>  	 * can use it as a reliable way to know whether we should run devinit.
>  	 */
>  	base->post =3D ((nvkm_rd32(device, 0x2240c) & BIT(1)) =3D=3D 0);
> -
> -	/*
> -	 * However some VBIOS init sequences miss this bit. So fall back to
> -	 * the nv50 method of checking if the bit is not set. Running the
> -	 * VBIOS multiple times may have detrimental effects.
> -	 */
> -	if (base->post) {
> -		u64 disable =3D nvkm_devinit_disable(base);
> -		/* magic to detect whether or not x86 vbios code has
> -		 * executed the devinit scripts to initialise the
> -		 * board. only works if there's a display engine.
> -		 */
> -		if (!(disable & (1ULL << NVKM_ENGINE_DISP))) {
> -			if (nvkm_rdvgac(device, 0, 0x00) ||
> -			    nvkm_rdvgac(device, 0, 0x1a)) {
> -				base->post =3D false;
> -			}
> -		}
> -	}
>  }

[Severity: Medium]
Does removing this fallback reintroduce double execution of VBIOS devinit
scripts on GF100+ GPUs that have a display engine but whose VBIOS does not
set BIT(1) of 0x2240c?

Since a7f000ec5650 ("drm/nouveau/disp: switch to instanced constructor") and
da2b1a0a40d8 ("drm/nouveau/devinit: Convert function disable() to be void"),
nvkm_devinit_disable() disables absent subdevices via nvkm_subdev_disable()
(clearing device->disp to NULL) and always returns 0.  Calling
nvkm_devinit_disable(base) and checking if (device->disp) before reading the
VGA CRTC registers, as nv50_devinit_preinit() does, would avoid the PRIVRING
faults on displayless GPUs like GM108 while preserving the fallback check on
GPUs with a display engine.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121101350.bab6=
9dff11a2@gmail.com?part=3D1
