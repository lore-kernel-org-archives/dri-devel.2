Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18563CA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEFE10E63B;
	Wed,  7 Oct 2026 17:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DwbvhZwd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F23A910E63B
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 17:55:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C3E5429E2;
 Wed,  7 Oct 2026 17:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CED1F000FF;
 Wed,  7 Oct 2026 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791395711;
 bh=41wy7CT/757MsEz93ApksEaRZyPHGEDMhqtFWTQh2K4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DwbvhZwdA18StROV7tUOJhTr8xhZyVyfe3jo6Nl9FCs5qH2TUuhR/7Dl1jAlBlBM8
 ghOCVylQOgI4NyUl+/IwKpJsVSNKPay+urmkoRFZVITNP3zttPGWfmYS6xtvcpo5BF
 FxXVSO2ULFpmPynvZgqnhzCLLN0Os14sZ1gYwKl6ued4EJzhs5BBo+YuEUDQg/NQul
 4R1CKFF77HH0kmnUtHRe8PpnQGUIAJ5YdrZFY57NBGmdYn6mjv3J1UO4OuRUZ4JWc7
 b3TpZAe16TxDCC0PYKhRa+4A4JsE8K3qy9+JPci9gSh8V7VqskX1yNl6+4SlvFzBQC
 qhVpBa9xT+0DA==
Message-ID: <sashiko-outbox-163272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: fix NULL deref when opening a closed DDC
To: "Arthur Liberman" <arthur_liberman@hotmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <DB9PR03MB73881C96FE86D964037ABEDB8A942@DB9PR03MB7388.eurprd03.prod.outlook.com>
References: <DB9PR03MB73881C96FE86D964037ABEDB8A942@DB9PR03MB7388.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 17:55:10 +0000
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
- [High] dc/gpio: TOCTOU race and double-close in dal_ddc_open lockless fix
--

commit ad94ac206173ba28053892dd31bd38232f256278
Author: Arthur Liberman <arthur_liberman@hotmail.com>

drm/amd/display: fix NULL deref when opening a closed DDC

The patch aims to fix a NULL pointer dereference in dal_ddc_open() by
adding a lockless check to see if either pin was closed by a concurrent
HPD teardown thread. It returns an error if a pin is missing rather
than trying to serialize the two threads.

> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers=
/gpu/drm/amd/display/dc/gpio/gpio_service.c
> index 95f8b7c7d657a..a3145cd82d8bd 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
> @@ -577,6 +577,17 @@ enum gpio_result dal_ddc_open(
>  		goto failure;
>  	}
> =20
> +	/*
> +	 * dal_gpio_service_open() installs gpio->pin, and close clears it.
> +	 * MST bring-up can AUX-read for DSC while HPD teardown closes the
> +	 * same DDC. pin is NULL again in that window; do not dereference it.
> +	 */
> +	if (!ddc->pin_data->pin || !ddc->pin_clock->pin) {
> +		dal_gpio_close(ddc->pin_clock);
> +		dal_gpio_close(ddc->pin_data);

[Severity: High]
Does this error path introduce a concurrent double-close?

If the check detects one pin is NULL while the other is not (because the HPD
thread is closing them sequentially), calling dal_gpio_close() on both
pins races with the HPD thread's own close operations.

Could this cause unsynchronized MMIO writes in the hardware teardown paths?

> +		return GPIO_RESULT_NULL_HANDLE;
> +	}
> +
>  	/* DDC clock and data pins should belong
>  	 * to the same DDC block id,
>  	 * we use the data pin to set the pad mode. */

[Severity: High]
Since this does not serialize the threads and the pointers are not cached
via READ_ONCE(), can the compiler re-read the pointers from memory further
down in dal_ddc_open()?

drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c:dal_ddc_open() {
    ...
	hw_data =3D FROM_HW_GPIO_PIN(ddc->pin_data->pin);
	hw_clock =3D FROM_HW_GPIO_PIN(ddc->pin_clock->pin);

	config_data.config.ddc.data_en_bit_present =3D hw_data->store.en !=3D 0;
    ...
}

If the HPD thread sets the pointer to NULL between the earlier check and th=
is
read, hw_data would become NULL, and hw_data->store.en !=3D 0 would oops
at offset 0x28, defeating the fix.

[Severity: High]
Does dal_gpio_set_config(), which is called right after, repeat the same
check-then-dereference pattern?

drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c:dal_gpio_set_config() {
    ...
	if (!gpio->pin) {
		BREAK_TO_DEBUGGER();
		return GPIO_RESULT_NULL_HANDLE;
	}

	return gpio->pin->funcs->set_config(gpio->pin, config_data);
}

If the pin is cleared after the check but before the funcs dereference,
will this oops as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/DB9PR03MB73881C96FE=
86D964037ABEDB8A942@DB9PR03MB7388.eurprd03.prod.outlook.com?part=3D1
