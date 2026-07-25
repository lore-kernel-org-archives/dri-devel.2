Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AE5C531D0
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 03:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B5D10E0E8;
	Sat, 25 Jul 2026 03:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZMbZfdd/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F39BF10E0E8
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:19:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4569F600AD;
 Sat, 25 Jul 2026 03:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C461F000E9;
 Sat, 25 Jul 2026 03:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784949582;
 bh=e+x3fYW7voHvdNOsUanVj3YOW+ag07DI0d9ADXnChro=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZMbZfdd/IE/sHim8tGI0B6/1sXFowBZyN0byHD4qzbiisdw2rztaeOM4BzRXRS4pl
 tC1X2G+WsRh9cyHVJ+ALSFFNAnZQRXOhup3JZ9gT3hm+6g+9HJJKcYUqIYVt5i2PbJ
 T8n7/5lONhhweg9GCdG22UtheEH2hFPeFhoygDos0Zsqc8h5b7qtwm3X0USlg7+Nfp
 zggZhBuVmg72qw8ofpbJF9AwvOEH3hxvfCxx86yQtrcbXe2HEvzPX7fzd2QOtdEoE7
 eXxSevV/9Pzev3pER3fN7S/HdghdtVHgBdaFBQnoyFhnrnoh1AeIBkqIL08weneUKd
 RKE5diZ2Bitwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/13] drm/bridge: it6505: don't write an error code
 back to the reset register
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <e0e8ff86b0ac7f8d75cb254ebf6d22bcf79d2d34.1784947240.git.daniel@makrotopia.org>
References: <cover.1784947240.git.daniel@makrotopia.org>
 <e0e8ff86b0ac7f8d75cb254ebf6d22bcf79d2d34.1784947240.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 03:19:41 +0000
Message-Id: <20260725031941.D1C461F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error check for it6505_read() inside it6505_aux_i2c_wait()=
 causes I2C read failures to be silently truncated and falsely treated as s=
uccessful AUX operations, populating caller buffers with error codes masque=
rading as valid data.
- [High] Blind restoration of the entire REG_RESET_CTRL register in it6505_=
audio_input() clobbers concurrent modifications made by other threads or wo=
rkqueues.
--

--- Patch [11]: [PATCH v6 11/13] drm/bridge: it6505: don't write an error c=
ode back to the reset register ---
commit 6cdd627967e5d418a885e4cc00b3b1ef771660fc
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: don't write an error code back to the reset register

This commit addresses an issue in it6505_audio_input() where a negative
error code from it6505_read() could be written back to the reset register.
It adds a check to return early if reading REG_RESET_CTRL fails, and also
ensures the audio input frequency readback is strictly positive.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 1678ec5b3ba70..aeaa7b5ecf5aa 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -1516,12 +1516,15 @@ static bool it6505_audio_input(struct it6505 *it6=
505)
>  	int reg05, regbe;
> =20
>  	reg05 =3D it6505_read(it6505, REG_RESET_CTRL);
> +	if (reg05 < 0)
> +		return false;
> +
>  	it6505_set_bits(it6505, REG_RESET_CTRL, AUDIO_RESET, 0x00);
>  	usleep_range(3000, 4000);
>  	regbe =3D it6505_read(it6505, REG_AUDIO_INPUT_FREQ);
>  	it6505_write(it6505, REG_RESET_CTRL, reg05);

[Severity: High]
This is a pre-existing issue, but does this blind write back of the cached
reg05 value clobber concurrent modifications?

If this is called from the threaded IRQ handler or link_works, it can run
concurrently with the hdcp_work delayed workqueue. If hdcp_work clears
HDCP_RESET during the 3000-4000us sleep window, that concurrent change
will be permanently overwritten and lost when the stale reg05 value is
restored here.

> -	return regbe !=3D 0xFF;
> +	return regbe > 0 && regbe !=3D 0xFF;
>  }
> =20
>  static void it6505_setup_audio_channel_status(struct it6505 *it6505)


While reviewing this fix for missing error checks, I noticed another similar
pre-existing issue in the same file:

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of an error
check for it6505_read() inside it6505_aux_i2c_wait() cause I2C read failures
to be treated as successful operations?

drivers/gpu/drm/bridge/ite-it6505.c:it6505_aux_i2c_wait() {
    ...
    if (it6505_read(it6505, REG_AUX_USER_CTRL) & AUX_EVENT)
        break;
    ...
    *reply =3D it6505_read(it6505, REG_AUX_USER_REPLY) >> 4;
    ...
}

If it6505_read(it6505, REG_AUX_USER_CTRL) fails, it returns a negative errno
like -EIO (-5 =3D 0xFFFFFFFB). The bitwise check & AUX_EVENT (0x10) will
incorrectly evaluate to true, breaking the wait loop.

Then, if the read of REG_AUX_USER_REPLY also fails, the negative return is
right-shifted and truncated to 0xFF, which avoids error assignment and retu=
rns
success.

This eventually leads to it6505_aux_i2c_readb() reading garbage data into
the output buffer:

drivers/gpu/drm/bridge/ite-it6505.c:it6505_aux_i2c_readb() {
    ...
    buf[i] =3D it6505_read(it6505, REG_AUX_USER_RXB(0 + i));
    ...
}

Could this silently propagate hardware error codes to the DRM layer as valid
data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784947240.gi=
t.daniel@makrotopia.org?part=3D11
