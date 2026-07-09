Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC620C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 20:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8AE10E2DD;
	Thu,  9 Jul 2026 20:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CapTJLig";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C3010E2DD
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 20:06:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 28BA743ECA;
 Thu,  9 Jul 2026 20:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46121F00A3A;
 Thu,  9 Jul 2026 20:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783627577;
 bh=DIX/EnhU2gwadFVKCiu1bCt7blj1hhG7ZUuljrxCe68=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CapTJLigDiW87sQPqvEo6gNdgW1PQRvs+kWQGgx8XcYkTq2ralj65KaN7F2++fyDa
 s1oa4SxK5TyG2AEzwv+71exXn0NTlIoeIUwaWacYAw7HmSenCCrlXKGPD67ABjByn6
 f8YyS1e46uMS8ft3PT0DmtMDlzP1qrQUnIyznBI5y0hXC0bnZONxXnoXh/cFOwNC3z
 +wEB3pH4qr0rDzSp3SbjA2UC4n5kosAj/DCKS6ko/7W6fNh2EZIKwN7IoauJIOTCxU
 tFJqQKHpxOvKEEdjCZqnZPf66G2ycZifOpWulz3Cdyr6+iIkd3ihgdan5TwcIm7MJQ
 Y53mfDOkMN5kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/vkms: Fix UAF between connector configfs rmdir
 and .detect
To: "Ibrahim Hashimov" <security@auditcode.ai>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709195129.50856-1-security@auditcode.ai>
References: <20260709150637.45052-1-security@auditcode.ai>
 <20260709195129.50856-1-security@auditcode.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 20:06:16 +0000
Message-Id: <20260709200616.D46121F00A3A@smtp.kernel.org>
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
- [High] Unprotected list traversal in vkms_config_show() debugfs handler c=
auses Use-After-Free.
- [High] Missing DRM device unplug synchronization allows Use-After-Free on=
 vkmsdev->config during device teardown.
--

--- Patch [1]: [PATCH v2] drm/vkms: Fix UAF between connector configfs rmdi=
r and .detect ---
commit 0675814c013a710595cbeaa530445c1e4fc38596
Author: Ibrahim Hashimov <security@auditcode.ai>

drm/vkms: Fix UAF between connector configfs rmdir and .detect

vkms_connector_detect() walks config->connectors via
vkms_config_for_each_connector(), which expands to a plain
list_for_each_entry() over vkms_config::connectors with no lock and no
RCU protection.

[ ... ]

> This patch is scoped to the .detect sink. vkms_config_show(), the read
> handler for the "vkms_config" debugfs file, also walks the plane, CRTC,
> encoder and connector config lists without any lock or RCU protection,
> and is subject to a separate, pre-existing use-after-free against a
> concurrent configfs rmdir. Fixing it properly requires RCU-converting
> the plane, CRTC and encoder teardown paths too:
> vkms_config_destroy_plane(), vkms_config_destroy_crtc() and
> vkms_config_destroy_encoder() still free their objects non-RCU (plain
> list_del() + kfree()), so the RCU conversion done here for connectors
> alone is not enough to make that debugfs walk safe. That is left as a
> separate follow-up and is not addressed here.

[Severity: High]
This is a pre-existing issue, but since vkms_config_show() in
drivers/gpu/drm/vkms/vkms_config.c uses unprotected list traversal, could
this cause a use-after-free if it iterates over planes or crtcs while they
are concurrently removed?

Reading the vkms_config debugfs file calls vkms_config_show(), which
iterates over planes, crtcs, and encoders using unlocked list traversals
like vkms_config_for_each_plane(). Concurrently, removing a plane via
configfs rmdir triggers plane_release(), which calls
vkms_config_destroy_plane() to immediately unlink and free the plane
configuration with kfree().

I understand you explicitly noted this as out of scope for the current
patch, but wanted to verify if it will be tracked separately.

> Verified on a v6.19 KASAN-instrumented build: a detect-hammer vs.
> connector-rmdir stress loop reliably tripped a "KASAN: slab-use-after-
> free in vkms_connector_detect" report before this patch; with the fix
> applied, the same stress loop no longer produces any KASAN report.
>=20
> Fixes: 466f43885ac0 ("drm/vkms: Allow to update the connector status")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07

> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms=
/vkms_connector.c
> index b0a6b212d3f4d..c43948de2b017 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c

[ ... ]

> @@ -26,10 +28,22 @@ static enum drm_connector_status vkms_connector_detec=
t(struct drm_connector *con
>  	 */
>  	status =3D connector->status;
> =20
> -	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
> +	/*
> +	 * configfs can free connector_cfg concurrently (connector_release() ->
> +	 * vkms_config_destroy_connector(), on an rmdir of the connector's
> +	 * configfs directory) without taking drm_device.mode_config.mutex,
> +	 * which this .detect callback is always called under. Walk the RCU-
> +	 * protected list instead of taking the configfs device lock here: the
> +	 * two locks are already nested in the opposite order by
> +	 * vkms_destroy(), so acquiring the configfs lock from under
> +	 * mode_config.mutex would deadlock.
> +	 */
> +	rcu_read_lock();
> +	vkms_config_for_each_connector_rcu(vkmsdev->config, connector_cfg) {

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of DRM device
unplug synchronization here allow a use-after-free on vkmsdev->config?

If a user-space process calls a DRM ioctl like DRM_IOCTL_MODE_GETCONNECTOR,
it enters vkms_connector_detect() and accesses vkmsdev->config. Concurrentl=
y,
if a user deletes the device directory in configfs, device_release() is
triggered:

drivers/gpu/drm/vkms/vkms_configfs.c:device_release() {
    ...
    vkms_destroy(dev->config);
    kfree(dev->config);
}

Because vkms_connector_detect() does not protect its execution with
drm_dev_enter() (and vkms_destroy() uses drm_dev_unregister() instead of
drm_dev_unplug()), the device teardown does not wait for in-flight ioctls
to finish.

The drm_device is kept alive by the open file descriptor, but dev->config
is freed, which could cause the ioctl to dereference a dangling pointer.

>  		if (connector_cfg->connector =3D=3D vkms_connector)
>  			status =3D vkms_config_connector_get_status(connector_cfg);
>  	}
> +	rcu_read_unlock();
> =20
>  	return status;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709195129.5085=
6-1-security@auditcode.ai?part=3D1
