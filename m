Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA37C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0408B10EFBA;
	Wed, 12 Aug 2026 13:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EJY4pyL5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7F5D10EFB5
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:01:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 377DB60A92;
 Wed, 12 Aug 2026 13:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FCF1F000E9;
 Wed, 12 Aug 2026 13:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786539701;
 bh=JprA4rEFsaaGGKf5OqpOYVXeiuAEYYV6xGCxTfD9E7c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EJY4pyL50uhslMGcZneuMVRflT83wPvfHh4VN/hUyeutdHwYl8mDzJX1Dk7c78hMW
 OiPXZjRKL5dcs7P7Ztf3FM1HfP+EH3zQAFgaI5bUlXagekKB4kHidKcw52KUf3uYnd
 QPtMCRWPP5WQX4Ij6eBLI1lGrgNtmIpEfGED4+cf6by6fCxk/1bj50e8TH74h24vn5
 DWPljvgNEi/1S0K87NBfc7Jvx7F79YDN/vArVB4KMyVjq7sDb5d9m7bfxkT2K2eO4A
 ISvfssXIeGBGLQV473juWNgGb3SrF3L42/YIzN6Wk1Bd6SdsW3wCGLFW7eymj+NSCB
 xPWjuTj3slNVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] ALSA: hda: allow direct complete with a powered-off
 GPU
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812122206.193680-4-dev@deq.rocks>
References: <20260812122206.193680-1-dev@deq.rocks>
 <20260812122206.193680-4-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:01:41 +0000
Message-Id: <20260812130141.C1FCF1F000E9@smtp.kernel.org>
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
- [High] Bypassing mandatory suspend preparation in azx_prepare() causes co=
ncurrent hardware access and crashes if direct-complete is aborted.
--

--- Patch [3]: [PATCH 3/3] ALSA: hda: allow direct complete with a powered-=
off GPU ---
commit 2f8a96155a50eb983d9e329380eedc7ca760b5b8
Author: Andre Eikmeyer <dev@deq.rocks>

ALSA: hda: allow direct complete with a powered-off GPU

This commit allows direct complete during system suspend for HDA
controllers bound to a powered-off switcheroo GPU. It returns 1
in azx_prepare() if the discrete GPU is runtime suspended and
switched off.

> diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
> index 4b03c64e72ab4..47cc695864a11 100644
> --- a/sound/hda/controllers/intel.c
> +++ b/sound/hda/controllers/intel.c

[ ... ]

> @@ -1025,6 +1048,10 @@ static int azx_prepare(struct device *dev)
>  		return 0;
> =20
>  	chip =3D card->private_data;
> +	/* A powered-off dGPU cannot signal HDA wake events. */
> +	if (azx_vga_is_powered_off(chip))
> +		return 1;
> +

[Severity: High]
Does returning early here bypass setting chip->pm_prepared =3D 1?

If the PM core aborts direct-complete (for example, if a user enables
wakeup via sysfs, or another device fails to suspend), the fallback
suspend path will execute.

Because chip->pm_prepared is left as 0, when the PCI core triggers a
runtime resume, wouldn't __azx_runtime_resume() incorrectly queue
asynchronous codec resumes via pm_request_resume()?

Could these async resumes execute on the pm_wq workqueue concurrently with
azx_suspend() shutting down the HDA controller, leading to MMIO faults or
system lockups?

>  	chip->pm_prepared =3D 1;
>  	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812122206.1936=
80-1-dev@deq.rocks?part=3D3
