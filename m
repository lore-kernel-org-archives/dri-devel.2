Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E142BC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 12:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF5D10E137;
	Fri, 14 Aug 2026 12:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vn3MLVfH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B60510E137
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:19:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D568F600C3;
 Fri, 14 Aug 2026 12:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E18A1F000E9;
 Fri, 14 Aug 2026 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786709942;
 bh=JBzWUe8txcI1Sih5BQCMUW65BsDMCEoPlSNRsvhHJC4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vn3MLVfHtf1raiLZL7TmffOYQ2/Ko3E7ygNpnXpUTNcDXMfy3Ud0Eq/KhzGi/tvSS
 yv6+Efezw87hLoXJOfqlenX6wNRQzDXtag1egtM2Z4iLwULYpaw7XJTaPojFE/eEI8
 nboJ/guR9T9maG9OcewRn7SsTBsJk3oZQpil0QU/nHXTzjz+3TGc9s/bybY8P7WLKi
 ZuoH0k8qN3/aD0+0E6pFulujPhu64qSrqh03xGVEn9k+NVEjLIlmIs9X9s62+a/eA/
 bK3D22MuKgaCYeY3iT8PQ643SC9aiT+2WtipMtVFr7u2kPHFQRTf0NQHJxsgXOF+Xp
 x/kKyjw4XFCsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: ti-sn65dsi86: improve HPD interrupt
 handling
To: "Yashas D" <y-d@ti.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814120304.887993-2-y-d@ti.com>
References: <20260814120304.887993-1-y-d@ti.com>
 <20260814120304.887993-2-y-d@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 12:19:01 +0000
Message-Id: <20260814121902.6E18A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Early return bypasses secondary status clearing, causing an IR=
Q storm.
- [High] Casting opaque `hpd_data` to `struct drm_connector *` causes type =
confusion and potential kernel panic.
- [High] Lockless connector access introduces a Use-After-Free window.
- [Medium] Unconditionally writing 0xFF to write-1-to-clear status register=
s causes lost hardware events.
- [Medium] Bitwise ORing negative error codes produces meaningless values.
--

--- Patch [1]: [PATCH 1/2] drm/bridge: ti-sn65dsi86: improve HPD interrupt =
handling ---
commit 7011d7627c6af8ae9fd09f6d42480bb03a988154
Author: Yashas D <y-d@ti.com>

drm/bridge: ti-sn65dsi86: improve HPD interrupt handling

Fix the interrupt handler to clear all three IRQ status registers
to fully de-assert the IRQ pin, enable replug event detection, and
use per-connector hotplug notification instead of polling all
connectors on every DP HPD event.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 48b83df9aed61..d9bd4ef8f0e21 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c

[ ... ]

> @@ -1387,23 +1391,35 @@ static irqreturn_t ti_sn_bridge_interrupt(int irq=
, void *private)
>  		return IRQ_NONE;
>  	}
> =20
> -	hpd_event =3D status & (HPD_REMOVAL_STATUS | HPD_INSERTION_STATUS);
> +	hpd_event =3D status & (HPD_REMOVAL_STATUS | HPD_INSERTION_STATUS |
> +			      HPD_REPLUG_STATUS);
> =20
>  	dev_dbg(pdata->dev, "(SN_IRQ_STATUS_REG =3D %#x)\n", status);
>  	if (!status)
>  		return IRQ_NONE;

[Severity: Critical]
Is this a regression where the early return bypasses the newly added cleari=
ng
logic?=20

If the interrupt was triggered exclusively by an event in SN_IRQ_STATUS2_RE=
G=20
or SN_IRQ_STATUS3_REG, status will be 0 and the handler returns immediately=
.=20
Will the hardware IRQ pin remain asserted, leading to an infinite interrupt
loop?

> =20
> -	ret =3D regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, status);
> +	/*
> +	 * Clear all three IRQ status registers to fully de-assert
> +	 * the IRQ pin
> +	 */
> +	ret  =3D regmap_write(pdata->regmap, SN_IRQ_STATUS2_REG, 0xFF);

[Severity: Medium]
Will this unconditionally acknowledge and clear all pending events in these=
=20
write-1-to-clear registers?=20

Because the registers aren't read first, might this cause the driver to=20
permanently lose secondary hardware interrupt events or error flags?

> +	ret |=3D regmap_write(pdata->regmap, SN_IRQ_STATUS3_REG, 0xFF);
> +	ret |=3D regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, status);

[Severity: Medium]
Does bitwise ORing the returns of regmap_write() corrupt the error values?

Since regmap_write() returns negative error codes (e.g., -EIO), ORing them=
=20
combines their two's complement bits to produce an unrelated negative numbe=
r,=20
which could mangle the error code passed to dev_err().

>  	if (ret) {
>  		dev_err(pdata->dev, "Failed to clear IRQ status: %d\n", ret);
>  		return IRQ_NONE;
>  	}
> =20
> -	/* Only send the HPD event if we are bound with a device. */
> +	/* Notify only the DP connector, not all connectors on the device. */
>  	mutex_lock(&pdata->hpd_mutex);
> -	if (pdata->hpd_enabled && hpd_event)
> -		drm_kms_helper_hotplug_event(dev);
> -	mutex_unlock(&pdata->hpd_mutex);
> +	if (pdata->hpd_enabled && hpd_event && pdata->bridge.hpd_data) {
> +		struct drm_connector *connector =3D
> +			(struct drm_connector *)pdata->bridge.hpd_data;

[Severity: High]
Does casting the opaque bridge.hpd_data directly to a drm_connector pointer=
=20
cause type confusion?=20

The hpd_data pointer is an opaque private context owned by the bridge=20
consumer. If a driver passes a different structure or a drm_device pointer,=
=20
will this cause a kernel panic when dereferenced by=20
drm_connector_helper_hpd_irq_event()?

> +		mutex_unlock(&pdata->hpd_mutex);
> +		drm_connector_helper_hpd_irq_event(connector);

[Severity: High]
Does dropping the hpd_mutex lock here introduce a use-after-free regression=
?=20

The lifetime of hpd_data is only guaranteed until drm_bridge_hpd_disable()=
=20
returns. If a concurrent unbind operation completes and frees the connector=
=20
memory while this interrupt handler is executing=20
drm_connector_helper_hpd_irq_event(), can this result in memory corruption?=
=20

Would it be safer to retain the lock or take a reference via=20
drm_connector_get() before unlocking?

> +	} else {
> +		mutex_unlock(&pdata->hpd_mutex);
> +	}
> =20
>  	return IRQ_HANDLED;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814120304.8879=
93-1-y-d@ti.com?part=3D1
