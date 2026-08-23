Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E050C5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 11:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35ABA10E00F;
	Sun, 23 Aug 2026 11:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UCDGIk58";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63AF110E00F
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 11:34:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7407560008;
 Sun, 23 Aug 2026 11:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F9F1F000E9;
 Sun, 23 Aug 2026 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787484843;
 bh=8STjwjlcA5BCiHAzgDD3vds2zA8Z/fDlOwS9/FSjRXs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UCDGIk58OSPyRP+8iGXKE5qThTHmhR6bNxAOI76j9ZD+64uM62QPvgsLjhJYpSPgW
 QIgjlYkjOo54kVRnJQ1U94hIFOptQoqAzV2YUE5XKafr6EkRuIWO03PCpLFh9uUSDO
 ruKHF4Yb+AjEqciFUHNmoADdME8TYRCF/OH+IBdXAfvoCC8fH/VvBIadtSlmSbUNv7
 QOOVH2APZr5Bvq5jmGdKqxFA1xXMneDcqo9+3OEzsr3udkZy1thhELGENKn97JDwrO
 A9a+QIntggb4z+6hqUSnCl7KBQB2b1tIbRBdQP0lPp8RFsaNKYDLQsOKawkwCQp+tE
 VClmLXPhSS2Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260823111959.17029-7-amit.barzilai22@gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-7-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 11:34:02 +0000
Message-Id: <20260823113402.D7F9F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] DMA on stack memory via regmap_bulk_write in ssd130x_write_cmds.

Pre-existing issues:
- [High] drm_gem_fb_begin_cpu_access sleeps in atomic context.
- [High] regulator_enable sleeps in atomic context.
- [High] Backlight and DRM atomic commit unprotected SPI updates interleave.
--

--- Patch [6]: [PATCH v5 6/6] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 s=
upport ---
commit c25fd0a18b10199afa7a08a23e60b6d45a463381
Author: Amit Barzilai <amit.barzilai22@gmail.com>

drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support

This commit adds support for the SSD1351 controller by introducing a new
SSD135X_FAMILY to the ssd130x driver. It adds a new init sequence, custom
command protocols that pass parameters on the data path, and family-specific
plane and encoder callbacks.

> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/=
ssd130x.c
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
[ ... ]
> @@ -271,6 +310,17 @@ static int ssd130x_write_cmds(struct ssd130x_device =
*ssd130x, const u8 *cmd,
>  	unsigned int i;
>  	int ret;
> =20
> +	if (ssd130x->device_info->cmd_params_are_data) {
> +		if (!len)
> +			return 0;
> +
> +		ret =3D regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cmd[0]);
> +		if (ret || len =3D=3D 1)
> +			return ret;
> +
> +		return ssd130x_write_data(ssd130x, cmd + 1, len - 1);
> +	}

[Severity: High]
Will this cause a DMA fault on stack memory? Callers like ssd130x_write_cmd=
()
allocate the command array on the kernel stack (e.g. u8 buf[8]). Passing
cmd + 1 to ssd130x_write_data() results in a regmap_bulk_write(). On SPI
devices, this passes the buffer directly to the SPI DMA engine. Because
vmalloc-backed kernel stacks forbid DMA, this might cause an immediate
kernel panic or fault during device probe and runtime updates.

[Severity: High]
This is a pre-existing issue, but does this split transaction allow
concurrent updates to interleave on the SPI bus? If a user-space write to
the sysfs backlight interface triggers ssd135x_update_bl() concurrently with
a display update from ssd135x_update_rect(), another thread's regmap_write()
could execute in between this regmap_write() and ssd130x_write_data(). This
could cause the controller to misinterpret parameters as opcodes or vice
versa.

[ ... ]
> @@ -1247,6 +1431,45 @@ static void ssd133x_primary_plane_atomic_update(st=
ruct drm_plane *plane,
>  	drm_dev_exit(idx);
>  }
> =20
> +static void ssd135x_primary_plane_atomic_update(struct drm_plane *plane,
> +						struct drm_atomic_commit *state)
> +{
[ ... ]
> +	if (!drm_dev_enter(drm, &idx))
> +		return;
> +
> +	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
> +		goto out_drm_dev_exit;

[Severity: High]
This isn't a bug introduced by this patch, but does this call to
drm_gem_fb_begin_cpu_access() sleep in an atomic context? Plane atomic
update callbacks run in atomic context during non-blocking commit tails.
Since drm_gem_fb_begin_cpu_access() can sleep while waiting on dma-buf
fences or acquiring locks, this might cause kernel warnings or deadlocks
during screen updates.

[ ... ]
> @@ -1629,6 +1887,31 @@ static void ssd133x_encoder_atomic_enable(struct d=
rm_encoder *encoder,
>  	ssd130x_power_off(ssd130x);
>  }
> =20
> +static void ssd135x_encoder_atomic_enable(struct drm_encoder *encoder,
> +					  struct drm_atomic_commit *state)
> +{
> +	struct drm_device *drm =3D encoder->dev;
> +	struct ssd130x_device *ssd130x =3D drm_to_ssd130x(drm);
> +	int ret;
> +
> +	ret =3D ssd130x_power_on(ssd130x);

[Severity: High]
This is a pre-existing issue, but can this power management sequence sleep
in an atomic context? Encoder atomic enable callbacks must not sleep, yet
ssd130x_power_on() calls regulator_enable() which uses mutexes internally.
Could this lead to deadlocks or crashes when the display is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823111959.1702=
9-1-amit.barzilai22@gmail.com?part=3D6
