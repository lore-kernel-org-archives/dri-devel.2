Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722F3C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 469EE10E5DB;
	Thu, 20 Aug 2026 04:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LhbQWkVi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE0F10E5DB
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:58:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81C5860A84;
 Thu, 20 Aug 2026 04:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177941F000E9;
 Thu, 20 Aug 2026 04:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787201883;
 bh=rkNoXWNGfH+SF1GE2KZw7kUq1LN4VNMX0LT8wm7AIjk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LhbQWkVilJZV+rSc4mpGZeaTSfqCvUpsR48rKs7qjbsmeJN4BTfiHPlHXZ43MRaQ6
 gmqhhRnASSWH7o+JbQzmKSy7YmaiP4M1RznOHq0WwN4I8CpkBMkvyFl5krZMHRDGiN
 +eQcLxWpmsydUkt99fJhp177P13PH4iBCUs6fbg7pQdl03u2+MdVVVmmkLlOU9xGNL
 8X+cKkuROAYo1iJZxUyvyBgMVMUd571RGYFpj35odhTZaWLMpx0yYEpybMYofTaf9h
 aR/C4ASHQU2mu/o++6SCsqrdQuJv2C74otsccXlaVD+nPoXJq1KRRQ/jSI6xbKFY+k
 6be0X9+1a4gyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: anx78xx: fix potential use-after-free on
 device removal
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260820044746.3087-1-fanwu01@zju.edu.cn>
References: <20260820044746.3087-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 04:58:02 +0000
Message-Id: <20260820045803.177941F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Connector lifetime mismatch causes use-after-free on driver un=
bind.
- [High] Missing anx78xx_poweroff() in driver remove path leaves regulators=
 enabled.
- [High] The INTP interrupt handler may dereference a NULL `connector.dev` =
pointer if an interrupt occurs before the bridge is attached.
- [High] DRM bridge operations can access freed regmap, regulator, and GPIO=
 resources if called after device removal.
- [Medium] Missing mutex locking in probe and bridge enable/disable paths c=
auses race conditions with threaded interrupt handlers.
--

--- Patch [1]: [PATCH] drm/bridge: anx78xx: fix potential use-after-free on=
 device removal ---
commit 5c75354b8bb8f58551e701235d2a45c7111239b5
Author: Fan Wu <fanwu01@zju.edu.cn>

drm/bridge: anx78xx: fix potential use-after-free on device removal

The commit fixes a potential use-after-free on device removal by freeing
devm-managed interrupts before unregistering dummy i2c clients. It also
adds a missing devm_free_irq() call in the probe error path.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers=
/gpu/drm/bridge/analogix/analogix-anx78xx.c
> index 32186efa6f501..735b0404ceba8 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> @@ -1309,6 +1309,7 @@ static int anx78xx_i2c_probe(struct i2c_client *cli=
ent)
>  					"anx78xx-intp", anx78xx);
>  	if (err) {
>  		DRM_ERROR("Failed to request INTP threaded IRQ: %d\n", err);
> +		devm_free_irq(&client->dev, pdata->hpd_irq, anx78xx);

[Severity: High]
This isn't a bug introduced by this patch, but could the INTP interrupt
handler dereference a NULL connector.dev pointer if an interrupt occurs
before the bridge is attached?

Since the interrupt is requested here and enabled immediately, if it fires
before the connector is fully initialized, could the handler crash when
calling drm_helper_hpd_irq_event(anx78xx->connector.dev)?

[Severity: Medium]
This is a pre-existing issue, but does anx78xx_poweroff() and other probe
and bridge enable/disable paths lack mutex locking? Could this cause race
conditions with the threaded interrupt handlers, leading to corrupted
hardware state or imbalanced regulators?

>  		goto err_poweroff;
>  	}
> =20
> @@ -1332,6 +1333,14 @@ static void anx78xx_i2c_remove(struct i2c_client *=
client)
>  {
>  	struct anx78xx *anx78xx =3D i2c_get_clientdata(client);
> =20
> +	/*
> +	 * The threaded IRQ handlers access the dummy I2C clients through
> +	 * regmap and may free the cached EDID, so stop them before those
> +	 * resources are freed below.
> +	 */
> +	devm_free_irq(&client->dev, anx78xx->pdata.hpd_irq, anx78xx);
> +	devm_free_irq(&client->dev, anx78xx->pdata.intp_irq, anx78xx);
> +
>  	drm_bridge_remove(&anx78xx->bridge);

[Severity: Critical]
This is a pre-existing issue, but does removing the bridge here cause a
connector lifetime mismatch and lead to a use-after-free on driver
unbind? If the unbound connector is accessed by the DRM subsystem after
this point, will it trigger a use-after-free?

[Severity: High]
This is a pre-existing issue, but can DRM bridge operations access freed
regmap, regulator, and GPIO resources if called after device removal?
When anx78xx_poweroff() writes to SP_POWERDOWN_CTRL_REG, could it be
accessing freed memory if the bridge outlives the device removal?

> =20
>  	unregister_i2c_dummy_clients(anx78xx);

[Severity: High]
This is a pre-existing issue, but is there a missing call to
anx78xx_poweroff() in this driver remove path? Does unbinding the driver
without powering off the chip leave the dvdd10, pd, and reset GPIOs
permanently active instead of turning them off?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820044746.3087=
-1-fanwu01@zju.edu.cn?part=3D1
