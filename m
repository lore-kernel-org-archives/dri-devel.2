Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9F7C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E78710E36A;
	Wed, 12 Aug 2026 15:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oJuKY7KC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39AE210E36A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:36:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4835A60A7D;
 Wed, 12 Aug 2026 15:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C882F1F000E9;
 Wed, 12 Aug 2026 15:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786548991;
 bh=AQ7DljG1jr29OigD+CqdvZ2CD8KvQZOIC8mr64yMlVI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oJuKY7KC9BOor/ndKpR/A9HczH3Ja6f6df7YspT/kNDsBii9k2l6pt7xzpINKo+Ks
 fn5kQcXk5mT2W4pyPkY4r3D0kEun2g5HS75TUVLYqqfB87elpt3E640kUaZ14FggBE
 9+HYyH+11FvJEYufJEdhGDAJjfJKbPb9H4jrmur7dmtxoNq53yB448o1etYNLMvIbf
 kYlUQDDCSCvLsSpsfh6E7pPt1KMrz15e+8sqY57LH/C7qcJsIbsJ2Po27c7WpZ3ZPd
 aYlgOvunewDk0U778ugHr+HGPqh8XnEqhaa2bZMRRDFVo5hZLKhKT89bxloQBlb8q6
 MGX5RzyurQRMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] ALSA: hda: allow direct complete with a
 powered-off GPU
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812144221.35877-4-dev@deq.rocks>
References: <20260812122206.193680-1-dev@deq.rocks>
 <20260812144221.35877-1-dev@deq.rocks>
 <20260812144221.35877-4-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:36:30 +0000
Message-Id: <20260812153630.C882F1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning 1 early from `azx_prepare()` for direct-complete skips e=
ssential system suspend preparation (`chip->pm_prepared =3D 1`, `snd_power_=
change_state()`, and `flush_work()`), breaking the fallback path if direct-=
complete is aborted.
--

--- Patch [3]: [PATCH v2 3/3] ALSA: hda: allow direct complete with a power=
ed-off GPU ---
commit 512712a6e8db78ff16bf65eb2c4538a62401c892
Author: Andre Eikmeyer <dev@deq.rocks>

ALSA: hda: allow direct complete with a powered-off GPU

This commit allows direct complete for the HDA controller when a bound
GPU is powered off and unused. It checks the vga_switcheroo state and
runtime PM status to return 1 from azx_prepare() when appropriate.

> diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
> index 4b03c64e72ab4..6f1c1d596e2ca 100644
> --- a/sound/hda/controllers/intel.c
> +++ b/sound/hda/controllers/intel.c

[ ... ]

> @@ -1025,6 +1027,10 @@ static int azx_prepare(struct device *dev)
>  		return 0;
> =20
>  	chip =3D card->private_data;
> +	/* A positive return allows the PM core to use direct complete. */
> +	if (azx_vga_is_powered_off(chip))
> +		return 1;
> +

[Severity: High]
By returning 1 early here in azx_prepare(), does this inadvertently skip
setting chip->pm_prepared =3D 1, calling snd_power_change_state(), and
flushing the asynchronous work queue?

If the PM core or PCI subsystem subsequently aborts direct-complete (for
instance, if device wakeups are enabled via sysfs or a child codec aborts
it), the fallback path will invoke azx_suspend() and azx_resume() on an
unprepared device.

Could this result in the ALSA card remaining in the D0 state instead of
D3hot, failing to block userspace hardware accesses during system suspend?

Furthermore, since flush_work(&azx_bus(chip)->unsol_work) is skipped, is
there a risk of a race between the asynchronous work queue and hardware
shutdown during azx_suspend()?

Finally, during system resume, if chip->pm_prepared remains 0, won't
__azx_runtime_resume() incorrectly request runtime resumes for codecs while
a system resume is still in progress?

>  	chip->pm_prepared =3D 1;
>  	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812144221.3587=
7-1-dev@deq.rocks?part=3D3
