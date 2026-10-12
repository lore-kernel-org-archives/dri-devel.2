Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D717CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CED810E323;
	Mon, 12 Oct 2026 15:23:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B672D10E323;
 Mon, 12 Oct 2026 15:23:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EF8A4010D;
 Mon, 12 Oct 2026 15:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0161F0089B;
 Mon, 12 Oct 2026 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791818581;
 bh=3zvLbGOnFnnAGn2qAryqpW+U40X6cwAqGDqCIjqxeO0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P2rt+7dMfYNAqml0/Bw2nOzdKRGzhF86qrxUSzPwdS5SwlL3XWTOVfhurI9UL7HBY
 TJkDZeLOxrj9LWY2FqDLvdvOxoRnuoc4afNhUYq7kbfyORWx2EQezB9wCeUzLqArbY
 Rwujt64fLkEuufderjBpTWrgr23mDqUPTdGisCPGlfdKkTN5Fkp8dGGyRZriUmMSbd
 x+t/UtyDecbJ2kAIxu/700XOjBFS1ADQzQb8CevdSTYXRo+6NrKMjKFAbSw+guUYzJ
 1sLJvBMhwytQ0X4QxCISN680UsKpE+sdeP27xAW5bSjdzHjyaMb9hzwglERxG5YwzE
 ogW042fGuB4YQ==
Message-ID: <sashiko-outbox-168327@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 3/8] drm: Introduce DisplayPort link training
 capabilities and state helpers
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-feat_link_cap-v3-3-7517f4aba0f3@bootlin.com>
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
 <20261012-feat_link_cap-v3-3-7517f4aba0f3@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:23:00 +0000
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
- [High] drm: AB-BA deadlock between sysfs active ref and dp.mutex
- [High] drm: UAF/NULL deref of connector->kdev in sysfs_connector_dp_link_=
update
--

commit 1620ef6dfb353b92f81d9907563ffd328e9eb367
Author: Kory Maincent <kory.maincent@bootlin.com>
Subject: drm: Introduce DisplayPort link training capabilities and state he=
lpers

This commit introduces helpers to expose DisplayPort link training capabili=
ties
and state to userspace via sysfs attributes. It adds functions to manage
sink and source capabilities and exposes them through a new dp_link sysfs
group.

> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
[ ... ]
> +void drm_dp_sink_reset_caps(struct drm_connector *connector)
> +{
> +	struct drm_connector_dp_link_caps zero_caps =3D {0};
> +
> +	if (!connector)
> +		return;
> +
> +	drm_modeset_lock_assert_held(&connector->dev->mode_config.connection_mu=
tex);
> +
> +	scoped_guard(mutex, &connector->dp.mutex) {
> +		kfree(connector->dp.cur_link_info.link_rates);
> +		memcpy(&connector->dp.cur_link_info, &zero_caps, sizeof(zero_caps));
> +		kfree(connector->dp.sink_link_caps.link_rates);
> +		memcpy(&connector->dp.sink_link_caps, &zero_caps, sizeof(zero_caps));
> +
> +		drm_sysfs_connector_dp_link_update(connector);
> +	}
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
[ ... ]
> +#define DRM_CONNECTOR_DP_ATTR_SHOW_SIMPLE_NESTED(_name, _info)          =
       \
> +static ssize_t _name##_##_info##_show(struct device *device,            =
       \
> +				   struct device_attribute *attr,              \
> +				   char *buf)                                  \
> +{                                                                       =
       \
> +	struct drm_connector *connector =3D to_drm_connector(device);          =
  \
> +	ssize_t size;                                                          \
> +	scoped_guard(mutex, &connector->dp.mutex)			       \
> +		size =3D sysfs_emit(buf, "%d\n", connector->dp._name._info);     \
> +	return size;                                                           \
> +}

[Severity: High]
Does this sequence introduce an AB-BA deadlock between the sysfs active
reference and connector->dp.mutex?

If a userspace thread reads a sysfs attribute like cur_link_info_nlanes,
the VFS/kernfs core acquires an active reference (s_active) on the
kernfs_node. The show callback then attempts to lock connector->dp.mutex via
scoped_guard().

Concurrently, a hotplug or link retraining event can call
drm_dp_sink_reset_caps() as seen in the drm_dp_helper.c snippet above. That
thread acquires connector->dp.mutex first, and then calls
drm_sysfs_connector_dp_link_update().

When drm_sysfs_connector_dp_link_update() invokes sysfs_update_group(),
and the visibility drops to 0 (because nlanes is cleared to 0), it calls
kernfs_remove_by_name(). This in turn calls kernfs_drain(), which blocks
indefinitely waiting for all active references to drop.

This leaves the kernel thread holding dp.mutex waiting for s_active to
drop, and the userspace thread holding s_active waiting for dp.mutex.

[ ... ]
> +void drm_sysfs_connector_dp_link_update(struct drm_connector *connector)
> +{
> +	int ret;
> +
> +	if (!connector->kdev)
> +		return;
> +
> +	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_DisplayPort &&
> +	    connector->connector_type !=3D DRM_MODE_CONNECTOR_eDP)
> +		return;
> +
> +	ret =3D sysfs_update_group(&connector->kdev->kobj,
> +				 &connector_dp_link_group);

[Severity: High]
Is it possible for connector->kdev to be unregistered and freed between
the NULL check and the sysfs_update_group() call?

MST hot-unplug processes (like drm_dp_delayed_destroy_work()) can invoke
drm_connector_unregister() and device_unregister(connector->kdev) without
holding connection_mutex or connector->dp.mutex.

Since drm_sysfs_connector_dp_link_update() does not hold a lock that
serializes against connector unregistration, this looks like a TOCTOU race
condition where connector->kdev->kobj could be a use-after-free or a
NULL pointer dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-feat_link_=
cap-v3-0-7517f4aba0f3@bootlin.com?part=3D3
