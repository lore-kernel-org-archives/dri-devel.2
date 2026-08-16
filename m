Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0452EC5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 11:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC3510E284;
	Sun, 16 Aug 2026 11:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="blB6zRWr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E9510E284
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 11:07:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB975438BC;
 Sun, 16 Aug 2026 11:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7C61F000E9;
 Sun, 16 Aug 2026 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786878472;
 bh=CH8v0Rd3779tf14gsB6mUAILOvFN7qgNCkoCRG4vmB4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=blB6zRWrJRgOf0QgrqCpo9UKnZCAvw1TNFpPpwIPe7QJKPiSnLScxQ2ZxBxLjPglI
 A9CaDMK5Py7m+xZW4hpljztqAN0gumofekqTjSBJc7Rhc5ZaiWinOKjYjRzh3qzLBi
 Wg6UGh00NVU/WDpoB/bsUy+FaQzPPrEb2lWvgVUfNbtMUlMd93jeE29R563O/z8sH/
 4aWbglWqIdtXZoaDyPiAZ92GN0OINdtMSiXAjj8JELDdeC7ObYn192pjkp7F19y02X
 HEYrghpUkRt0VKkwvep9+bIOntvCzCxI5bEH+eS41njUPKLk7Y4NlkJDgVYYKgcteI
 Pc0xoVFPscGGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] backlight: Add support for Orient Chip OCP8178
To: "Wim de With" <wf@dewith.io>
Cc: linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, devicetree@vger.kernel.org, lee@kernel.org,
 conor+dt@kernel.org
In-Reply-To: <20260816-ocp8178-backlight-v3-2-caf95c453c50@dewith.io>
References: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
 <20260816-ocp8178-backlight-v3-2-caf95c453c50@dewith.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 11:07:51 +0000
Message-Id: <20260816110752.5D7C61F000E9@smtp.kernel.org>
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
- [High] Missing PM resume initialization causes backlight to fail after sy=
stem suspend.
--

--- Patch [2]: [PATCH v3 2/2] backlight: Add support for Orient Chip OCP817=
8 ---
commit bfc20bddc55de3beb592431b21d9fc9bc3366d90
Author: Wim de With <wf@dewith.io>

backlight: Add support for Orient Chip OCP8178

This commit adds a driver for the Orient Chip OCP8178 backlight controller.
The driver implements a vendor-specific onewire protocol over GPIO to set
static brightness levels.

> diff --git a/drivers/video/backlight/ocp8178_bl.c b/drivers/video/backlig=
ht/ocp8178_bl.c
> new file mode 100644
> index 0000000000000..6c1e8c9451f12
> --- /dev/null
> +++ b/drivers/video/backlight/ocp8178_bl.c
[ ... ]
> +static int ocp8178_bl_update_status(struct backlight_device *bl)
> +{
> +	struct ocp8178_bl *ocp8178 =3D bl_get_data(bl);
> +	u8 brightness =3D backlight_get_brightness(bl);
> +
> +	ocp8178_bl_set_brightness(ocp8178, brightness);
> +	return 0;
> +}
> +
> +static const struct backlight_ops ocp8178_bl_ops =3D {
> +	.options =3D BL_CORE_SUSPENDRESUME,
> +	.update_status =3D ocp8178_bl_update_status,
> +};
[ ... ]
> +static struct platform_driver ocp8178_bl_driver =3D {
> +	.driver =3D {
> +		.name =3D "ocp8178-bl",
> +		.of_match_table =3D ocp8178_bl_of_match,
> +	},
> +	.probe =3D ocp8178_bl_probe,
> +};

[Severity: High]
Will the backlight fail to turn on after a system suspend cycle?

Since BL_CORE_SUSPENDRESUME is set in ocp8178_bl_ops, the backlight core
calls ocp8178_bl_update_status() upon system resume. During suspend, the
GPIO controller may pull the control pin low.

If the pin remains low for more than 2.5ms (OCP8178_T_OFF_US), the chip
shuts down and will power back up in its default PWM mode.

Because ocp8178_bl_update_status() immediately sends 1-wire commands without
verifying state or re-running ocp8178_bl_enable_onewire(), will the chip
misinterpret these 1-wire signals as tiny PWM pulses instead of restoring
the brightness level?

Does the platform driver need pm_ops to re-initialize the 1-wire mode state
before the backlight core attempts to update the brightness?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816-ocp8178-ba=
cklight-v3-0-caf95c453c50@dewith.io?part=3D2
