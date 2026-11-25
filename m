Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B199606A681
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KORpUxyN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74F7510FEE9;
	Wed, 25 Nov 2026 18:10:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A5E10FEBC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:10:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2722763534;
 Wed, 25 Nov 2026 18:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFD51F000D0;
 Wed, 25 Nov 2026 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630207;
 bh=TgIV3jE47xPt6IQI8zy4yurW7VBaLHowGA4VuDnkexk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KORpUxyN6C4Jcv1jOWPbV38oJFqWrAYyp4vOxiD3PAVaMmoxykBpAAOAw7Tw60Tq5
 +hgVXfsA1eNfPb9qowJcSnBrGVF0tJM/rwPnOuP7wKIvr+iKh9uosUDfYNzadCc44N
 3RjITT72KnrJNmVhWWtCNKla+TqI9URlxU3tACs8nJp3mPZ2xciTCagJVqWXLulAvf
 zv6B+fStVIEDKmiZXj8gicNTesGZlM3L4rI3IJGCY4AJ5GGrTfrMUJIJGiDuJfGcGX
 ZP2U5jR1FEPuBounrU2JSIROvq64sDqYC/T8mHyLK1O8iuzo4v0RLNhjpNUay/+zNI
 wpw/IEpJoBgWQ==
Message-ID: <sashiko-outbox-233913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/32] drm/probe-helper: add per-connector polling
 enable/disable
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-16-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-16-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:10:06 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/probe-helper: unbalanced HPD callbacks in per-connector
  poll helpers
- [High] drm/probe-helper: drm_kms_helper_poll_disable_connector()
  leaves poll active
- [Low] drm/probe-helper: duplicated HPD helper logic in
  drm_kms_helper_enable_hpd()
--

commit 3fcc8be33037c845672586431b3e9d911af66acb
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/probe-helper: add per-connector polling enable/disable

This commit adds drm_kms_helper_poll_enable_connector() and
drm_kms_helper_poll_disable_connector() to enable and disable output
polling and HPD for individual connectors added or removed dynamically.

> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_pro=
be_helper.c
> index 856b40fdaac4a..e468971ab6429 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -224,6 +224,14 @@ drm_connector_mode_valid(struct drm_connector *conne=
ctor,
>  	return ret;
>  }
> =20
> +static void drm_kms_helper_disable_hpd_connector(struct drm_connector *c=
onnector)
> +{
> +	const struct drm_connector_helper_funcs *funcs =3D connector->helper_pr=
ivate;
> +
> +	if (funcs && funcs->disable_hpd)
> +		funcs->disable_hpd(connector);
> +}
> +
>  static void drm_kms_helper_disable_hpd(struct drm_device *dev)
>  {
>  	struct drm_connector *connector;
> @@ -240,6 +248,16 @@ static void drm_kms_helper_disable_hpd(struct drm_de=
vice *dev)
>  	drm_connector_list_iter_end(&conn_iter);
>  }
> =20
> +static bool drm_kms_helper_enable_hpd_connector(struct drm_connector *co=
nnector)
> +{
> +	const struct drm_connector_helper_funcs *funcs =3D connector->helper_pr=
ivate;
> +
> +	if (funcs && funcs->enable_hpd)
> +		funcs->enable_hpd(connector);
> +
> +	return (connector->polled & (DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR=
_POLL_DISCONNECT));
> +}
> +
>  static bool drm_kms_helper_enable_hpd(struct drm_device *dev)
>  {
>  	bool poll =3D false;

[Severity: Low]
This isn't a bug, but drm_kms_helper_disable_hpd() and
drm_kms_helper_enable_hpd() right below these new helpers still open-code
the same per-connector callback and connector->polled checks instead of
calling drm_kms_helper_disable_hpd_connector() and
drm_kms_helper_enable_hpd_connector().

> @@ -316,6 +334,32 @@ void drm_kms_helper_poll_enable(struct drm_device *d=
ev)
>  }
>  EXPORT_SYMBOL(drm_kms_helper_poll_enable);
> =20
> +/**
> + * drm_kms_helper_poll_enable_connector - enable output polling for a co=
nnector
> + * @connector: the connector
> + *
> + * Enables output polling @connector and reschdules the polling work if
> + * needed. Intended for connectors which are added after initial probing.
> + *
> + * This must be called after polling has been initialized by
> + * drm_kms_helper_poll_init(). Safe to call while polling is already
> + * running.
> + */
> +void drm_kms_helper_poll_enable_connector(struct drm_connector *connecto=
r)
> +{
> +	struct drm_device *dev =3D connector->dev;
> +
> +	if (drm_WARN_ON_ONCE(dev, !dev->mode_config.poll_enabled) || !drm_kms_h=
elper_poll)
> +		return;
> +
> +	if (drm_kms_helper_enable_hpd_connector(connector) ||
> +	    dev->mode_config.delayed_event)
> +		reschedule_output_poll_work(dev);
> +
> +	dev->mode_config.poll_running =3D true;
> +}
> +EXPORT_SYMBOL(drm_kms_helper_poll_enable_connector);
> +
>  /**
>   * drm_kms_helper_poll_reschedule - reschedule the output polling work
>   * @dev: drm_device
> @@ -927,6 +971,54 @@ void drm_kms_helper_poll_disable(struct drm_device *=
dev)
>  }
>  EXPORT_SYMBOL(drm_kms_helper_poll_disable);
> =20
> +static bool drm_kms_helper_has_other_connectors(struct drm_connector *co=
nnector)
> +{
> +	struct drm_device *dev =3D connector->dev;
> +	struct drm_connector *curr;
> +	struct drm_connector_list_iter conn_iter;
> +	bool remaining =3D false;
> +
> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(curr, &conn_iter) {
> +		if (curr !=3D connector &&
> +		    curr->registration_state =3D=3D DRM_CONNECTOR_REGISTERED) {
> +			remaining =3D true;
> +			break;
> +		}
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	return remaining;
> +}
> +
> +/**
> + * drm_kms_helper_poll_disable_connector - disable output polling for a =
connector
> + * @connector: the connector
> + *
> + * Disables output polling for @connector. If there are no other registe=
red
> + * connectors, also disables the output poll work.
> + *
> + * Polling stays initialized; call drm_kms_helper_poll_fini() to tear it
> + * down. Does nothing if output polling is not initialized by
> + * drm_kms_helper_poll_init().
> + */
> +void drm_kms_helper_poll_disable_connector(struct drm_connector *connect=
or)
> +{
> +	struct drm_device *dev =3D connector->dev;
> +
> +	if (!dev->mode_config.poll_enabled)
> +		return;
> +
> +	drm_kms_helper_disable_hpd_connector(connector);

[Severity: High]
Can drm_kms_helper_poll_enable_connector() and
drm_kms_helper_poll_disable_connector() cause unbalanced
enable_hpd()/disable_hpd() callbacks on connectors?

struct drm_connector_helper_funcs documents that drivers do not need to
track HPD state because the DRM core guarantees enable_hpd() and
disable_hpd() calls are balanced.  However, no per-connector HPD state is
recorded here:

1. drm_kms_helper_poll_disable_connector() calls
   drm_kms_helper_disable_hpd_connector() without checking
   dev->mode_config.poll_running.  If poll_running is false (for example
   because drm_kms_helper_poll was false or polling was disabled for
   suspend via drm_kms_helper_poll_disable()), disable_hpd() runs even
   though HPD is not enabled.

2. A connector remains on dev->mode_config.connector_list after
   drm_kms_helper_poll_disable_connector() until its last reference drops
   in drm_connector_cleanup().  If another connector keeps poll_running
   true and drm_kms_helper_poll_disable() or drm_kms_helper_poll_fini()
   runs while an atomic state or client still holds a reference to the
   disabled connector, drm_kms_helper_disable_hpd() walks connector_list
   and calls disable_hpd() on it a second time.

3. Conversely, when disabling the last connector clears poll_running, a
   later drm_helper_probe_single_connector_modes() on a newly registered
   connector calls drm_kms_helper_poll_enable(dev), which enables HPD on
   all connectors on connector_list and sets poll_running =3D true before
   the caller invokes drm_kms_helper_poll_enable_connector(), calling
   enable_hpd() twice.  And if poll_running was false with multiple
   connectors present, drm_kms_helper_poll_enable_connector() sets
   device-wide poll_running =3D true after enabling only one connector,
   causing a subsequent drm_kms_helper_poll_enable(dev) to return early
   and leave HPD disabled on the other connectors.

Unbalanced enable_hpd()/disable_hpd() calls trigger WARN(bridge->hpd_cb)
in drm_bridge_hpd_enable() and cause runtime PM or IRQ count underflows
in bridge drivers such as ti_sn_bridge_hpd_disable() and
display_connector_hpd_disable().

> +
> +	if (dev->mode_config.poll_running &&
> +	    !drm_kms_helper_has_other_connectors(connector)) {
> +		cancel_delayed_work_sync(&dev->mode_config.output_poll_work);
> +		dev->mode_config.poll_running =3D false;
> +	}
> +}
> +EXPORT_SYMBOL(drm_kms_helper_poll_disable_connector);

[Severity: High]
Does drm_kms_helper_poll_disable_connector() actually stop or synchronize
with output_poll_work for a polled connector when another connector is
registered on the device?

drm_kms_helper_has_other_connectors() returns true whenever any other
registered connector exists, even if that other connector does not use
polling (polled =3D=3D 0 or DRM_CONNECTOR_POLL_HPD), so output_poll_work is
left running when no remaining connector needs polling.

More importantly, when another registered connector exists,
drm_kms_helper_poll_disable_connector() neither waits for an in-flight
output_poll_execute() nor marks @connector as poll-disabled.  Because
output_poll_execute() iterates dev->mode_config.connector_list and checks
only connector->force and connector->polled, it can run
drm_helper_probe_detect() on @connector concurrently with bridge teardown
and keep repolling it every DRM_OUTPUT_POLL_PERIOD until its final
connector reference is dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D16
