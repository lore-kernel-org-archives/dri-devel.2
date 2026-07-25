Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED00C53200
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 03:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2EA10F4CE;
	Sat, 25 Jul 2026 03:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VraPtlSV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2041710F4CE
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:18:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 80A2A60A5E;
 Sat, 25 Jul 2026 03:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F82C1F000E9;
 Sat, 25 Jul 2026 03:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784949491;
 bh=tdzAX7tPsKVERueL90dbStcBnvhL7EnYxSZIiigv0fs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VraPtlSV64G/Ak3c8Bn/1rCaaRHcVHAY7t1gqhfzhwBv372+8+02MgcOyrV2vDLn4
 XJpwRrozioonDqWPSn1VqipjjpITG7gm39H62n9rAGLsDv+STw72BoQjzoYW41+19P
 /W8sseYWTgUYPuBi84kZN5gaLBVNj0jk7+dYh8i4N/Fz66GeoxT2Qjw75JsMbfiTUw
 BGAuYkXwwe0RjFHJXc7EWAuJzaiKRfHZL9swNlLWXLSQm1MIVAp5ZpCvlzegRRqoBW
 czU+7AF81UyGjOqPHolGfj0CXaam0j40r7G3Tqq/Yo+VWrAul3DJ4+ALdbEjl+OtxR
 tZt3s6htLSWDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/13] drm/bridge: it6505: balance and disable
 runtime PM on remove
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <9ea942316bc9a08474f6171866a432bd4eb93410.1784947240.git.daniel@makrotopia.org>
References: <cover.1784947240.git.daniel@makrotopia.org>
 <9ea942316bc9a08474f6171866a432bd4eb93410.1784947240.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 03:18:10 +0000
Message-Id: <20260725031811.0F82C1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unbalanced Lifecycle Operations: `drm_dp_aux_register` is called d=
uring bridge attach, but unregistered during driver remove.
--

--- Patch [2]: [PATCH v6 02/13] drm/bridge: it6505: balance and disable run=
time PM on remove ---
commit ff66d772f6681026b2d4511d26d9b73d925d8240
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: balance and disable runtime PM on remove

This commit disables runtime PM in the remove function and drops the
usage reference held for a connected display, fixing an unbalanced
runtime PM warning that occurs upon rebinding the driver.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -3662,6 +3662,9 @@ static void it6505_i2c_remove(struct i2c_client *cl=
ient)

[Severity: High]
This isn't a bug introduced by this patch, but does this driver have an
unbalanced lifecycle for the AUX channel adapter?

Registration happens during bridge attach:

it6505_bridge_attach() {
        ...
        ret =3D drm_dp_aux_register(&it6505->aux);
        ...
}

However, the unregistration happens just above this diff context in
it6505_i2c_remove() rather than in it6505_bridge_detach():

it6505_i2c_remove() {
        ...
        drm_dp_aux_unregister(&it6505->aux);
        ...
}

If the DRM driver or device undergoes an unbind and rebind cycle, the
detach and attach callbacks will execute without the underlying I2C driver
being removed.

Could this lead to drm_dp_aux_register() being called a second time
without a prior unregister, causing it to fail with -EEXIST since the
adapter is already registered?

>  	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
>  	cancel_delayed_work_sync(&it6505->hdcp_work);
>  	cancel_work_sync(&it6505->extcon_wq);
> +	if (it6505->extcon_state)
> +		pm_runtime_put_sync(&client->dev);
> +	pm_runtime_disable(&client->dev);
>  	it6505_poweroff(it6505);
>  	it6505_remove_edid(it6505);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784947240.gi=
t.daniel@makrotopia.org?part=3D2
