Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF90C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 06:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE47B10E051;
	Tue, 14 Jul 2026 06:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hn2eGnyG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065F210E051
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:58:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E32D942EA6;
 Tue, 14 Jul 2026 06:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EA91F000E9;
 Tue, 14 Jul 2026 06:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784012329;
 bh=5/OaUK+k5M+Xre+14Np8m75VkZzuoGorbG9uW6qe5KA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hn2eGnyG4g+UIayZCzy4/lakKne+Yy8W6b3FhDPA2AIwO1QaGorZyr3Xw0VCUoLRp
 P626Tv4wY0Bh04ooZI9Z+6WP6GAT4EqCtrYCjmsZhZKylf5EVvDAEWN3Zfci5mvsC/
 HPvbEG8+Hk4faWaQI5xWD8PfatYd9oVUsplqDY5ooXMJLR9WerOgdCXCqbcWPxNe8R
 AKO4cppD9gEmFcP09sub2eduiD+W8q2Yp7+ztEydEqtj2T3hjTL7wbqtLQ8yS06HXh
 RjdsN5PUzHBCIQspVH5Fqgi3I4uc8wiRQktRqMRYRUsWnCgRYqWVUpiHnCqzEvViCb
 mTeEVOt7/KWHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/2] drm/bridge: Add Lontium LT7911EXC eDP to MIPI
 DSI bridge
To: syyang@lontium.com
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260714064822.2753289-3-syyang@lontium.com>
References: <20260714064822.2753289-1-syyang@lontium.com>
 <20260714064822.2753289-3-syyang@lontium.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 06:58:48 +0000
Message-Id: <20260714065849.78EA91F000E9@smtp.kernel.org>
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
- [High] `devm_drm_of_get_bridge()` in the hot-pluggable `lt7911exc_dsi_hos=
t_attach()` callback leaks devres memory and causes use-after-free upon pan=
el unbind/rebind.
- [High] Double removal of the DRM bridge due to a flawed `list_empty` chec=
k in `lt7911exc_remove()`, leading to double mutex destruction and use-afte=
r-free.
- [High] Firmware upgrade clears the `upgrade` flag AFTER sending the hotpl=
ug event, causing potential modesets to fail silently.
- [Medium] Direct mutation of `pre_enable_prev_first` on an external `drm_b=
ridge` object owned by a downstream driver.
--

--- Patch [2]: [PATCH v15 2/2] drm/bridge: Add Lontium LT7911EXC eDP to MIP=
I DSI bridge ---
commit 4c1fba2c711f35f533a59a3680b0b1fda9a82f94
Author: Sunyun Yang <syyang@lontium.com>

drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI bridge
   =20
Add support for the Lontium LT7911EXC bridge chip, which converts
eDP input to MIPI DSI output using an internal firmware-controlled
pipeline.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/drm=
/bridge/lontium-lt7911exc.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
[ ... ]
> +static void lt7911exc_firmware_upgrade_work(struct work_struct *work)
> +{
[ ... ]
> +	if (ret)
> +		dev_err(dev, "failed to read version after upgrade\n");
> +
> +	/* Notify DRM to re-trigger modeset after firmware upgrade */
> +	if (lt7911exc->bridge.dev)
> +		drm_kms_helper_hotplug_event(lt7911exc->bridge.dev);

[Severity: High]
Could this hotplug event fire before the upgrade flag is cleared?

Since drm_kms_helper_hotplug_event() triggers modesets synchronously
(or fast async), it might call lt7911exc_atomic_pre_enable() while
lt7911exc->upgrade is still true. If that happens, pre_enable() will
silently skip writing the hardware enable registers, resulting in a=20
black screen.

Would it be safer to clear the upgrade flag before firing the hotplug
event?

> +
> +	goto out_release_fw;
> +
> +out_mcu_run:
> +	scoped_guard(mutex, &lt7911exc->ocm_lock)
> +		lt7911exc_inside_mcu_run(lt7911exc);
> +
> +out_release_fw:
> +	release_firmware(fw);
> +
> +out_unlock_upgrade:
> +	scoped_guard(mutex, &lt7911exc->ocm_lock) {
> +		if (!lt7911exc->removed)
> +			lt7911exc->upgrade =3D false;
> +	}
> +	mutex_unlock(&lt7911exc->upgrade_lock);
> +}
[ ... ]
> +static int lt7911exc_dsi_host_attach(struct mipi_dsi_host *host, struct =
mipi_dsi_device *dev)
> +{
> +	struct lt7911exc *lt7911exc =3D dsi_host_to_lt7911exc(host);
> +
> +	if (dev->lanes > 4) {
> +		dev_err(lt7911exc->dev, "unsupported number of data lanes(%u)\n", dev-=
>lanes);
> +		return -EINVAL;
> +	}
> +
> +	lt7911exc->output_bridge =3D devm_drm_of_get_bridge(lt7911exc->dev, hos=
t->dev->of_node, 1, 0);

[Severity: High]
Could this devm allocation leak devres memory and cause a use-after-free?

The devm_drm_of_get_bridge() allocation is tied to the host device
(lt7911exc->dev), but it runs in lt7911exc_dsi_host_attach() which can
be called repeatedly if the downstream DSI panel is unbound and rebound.

Because the allocation is tied to the host device, it won't be freed until
the host driver unbinds. This leaks memory on every panel rebind. Also, the
retained drm_panel_bridge will hold a dangling pointer after the panel is
destroyed, risking a use-after-free if accessed later.

> +	if (IS_ERR(lt7911exc->output_bridge))
> +		return PTR_ERR(lt7911exc->output_bridge);
> +
> +	/*
> +	 * LT7911EXC requires the panel to be powered and ready before
> +	 * enabling MIPI DSI output. Keep default order (panel first)
> +	 * regardless of panel's prepare_prev_first setting, since the
> +	 * chip's internal firmware handles panel initialization.
> +	 */
> +	lt7911exc->output_bridge->pre_enable_prev_first =3D false;

[Severity: Medium]
Is it safe to directly mutate the state of an external bridge object?

This output_bridge is owned and managed by the downstream driver. Setting
its pre_enable_prev_first field from this host driver violates object
ownership and could override necessary configuration expected by the
downstream driver.

> +
> +	drm_bridge_add(&lt7911exc->bridge);
> +
> +	return 0;
> +}
[ ... ]
> +static void lt7911exc_remove(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct lt7911exc *lt7911exc =3D dev_get_drvdata(dev);
> +
> +	if (!lt7911exc)
> +		return;
> +
> +	scoped_guard(mutex, &lt7911exc->ocm_lock) {
> +		lt7911exc->removed =3D true;
> +		lt7911exc->upgrade =3D true;
> +	}
> +
> +	cancel_work_sync(&lt7911exc->work);
> +
> +	dev_set_drvdata(dev, NULL);
> +
> +	mipi_dsi_host_unregister(&lt7911exc->dsi_host);
> +
> +	if (!list_empty(&lt7911exc->bridge.list))
> +		drm_bridge_remove(&lt7911exc->bridge);

[Severity: High]
Will this result in a double free of the bridge?

During module unload, mipi_dsi_host_unregister() detaches all DSI children,
which calls lt7911exc_dsi_host_detach(). That explicitly calls
drm_bridge_remove() and moves the list node to the global
bridge_lingering_list.

When execution reaches this list_empty() check, it will evaluate to false
because the node is on the lingering list (and its next pointer isn't
pointing to itself). This causes drm_bridge_remove() to be erroneously
called a second time on the same bridge, leading to a double free and
double mutex_destroy().

> +
> +	gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714064822.2753=
289-1-syyang@lontium.com?part=3D2
