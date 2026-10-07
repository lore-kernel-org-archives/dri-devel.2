Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20EACA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61E9310E697;
	Wed,  7 Oct 2026 20:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hrbpl84Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2783710E697
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 20:32:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F9D660A89;
 Wed,  7 Oct 2026 20:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1CB1F000FF;
 Wed,  7 Oct 2026 20:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791405177;
 bh=EvmHFXSoFmxGfczNgvdD0YwJkvmzBnIzkx20xRy7USo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hrbpl84ZOz/yKQzqW39VOarlrE6phWBnrWAwKvco0Eq/Bk3brv2PDMUS8lVp57B/+
 QH7NktqpHc/Atb8mGdyW4w6PTe4XJB6kfmf0K3rEa/dmiB/Rr4QgSVKbr0d/VYpJeX
 vCk99IGAteJbS4yFXAu6yc1CSb/eYTUrAJ3bjBUMeBBwMx3JBBN68wDVHTcBat+wmo
 BXAPoUfFj4NNrmeD/B1m0qtd41LFRcRt66Q4rJ7343eHXjy7HHeRP2J0v9TF3JpJk6
 u5HGKvbrZPA5AxXQOys7jIlY+YW33rWBkIn42KILc3EqYT1s+/iBzgDf1RTn5RNHcS
 +vjz0Oufp0ejg==
Message-ID: <sashiko-outbox-163341@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
To: mohit.dsor@oss.qualcomm.com
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261008-lt9611c-v7-v17-2-1e8f5f2b2f19@oss.qualcomm.com>
References: <20261008-lt9611c-v7-v17-0-1e8f5f2b2f19@oss.qualcomm.com>
 <20261008-lt9611c-v7-v17-2-1e8f5f2b2f19@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 20:32:56 +0000
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
- [Critical] drm: build failure due to non-existent .atomic_create_state ho=
ok in drm_bridge_funcs
- [Critical] drm: type mismatch and memory corruption in atomic_enable hook=
 signature
- [High] drm: missing mandatory initialization for HDMI bridge operations
- [High] sysfs: NULL pointer dereference in firmware attributes due to regi=
stration race
- [Medium] drm/bridge: missing atomic_disable leaves LT9611C hardware power=
ed on
--

commit 0482492a2bb6e8ef5381a82384662e6858358155
Author: Sunyun Yang <syyang@lontium.com>

drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

This commit adds support for the Lontium LT9611C series MIPI DSI to HDMI
bridge chip. It supports configuring single or dual port DSI inputs and
provides HDMI output functionality along with audio and sysfs firmware
update support.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/b=
ridge/lontium-lt9611c.c
> new file mode 100644
> index 0000000000000..6082c89b388bf
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
[ ... ]
> +static void lt9611c_bridge_atomic_enable(struct drm_bridge *bridge,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> +	struct drm_connector *connector;
> +	struct drm_connector_state *conn_state;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_display_mode *mode;
> +	int ret;
> +
> +	connector =3D drm_atomic_get_new_connector_for_encoder(state, bridge->e=
ncoder);

[Severity: Critical]
Does the signature of this atomic_enable hook match what the DRM core expec=
ts?

The atomic_enable hook in drm_bridge_funcs expects the second argument to be
a struct drm_bridge_state pointer for the old bridge state. Treating this
argument as the top-level struct drm_atomic_commit pointer and passing it to
drm_atomic_get_new_connector_for_encoder() casts the bridge state to a comm=
it
state, which can cause out-of-bounds memory access when dereferencing the
state arrays.

[ ... ]
> +static const struct drm_bridge_funcs lt9611c_bridge_funcs =3D {
> +	.attach =3D lt9611c_bridge_attach,
> +	.detect =3D lt9611c_bridge_detect,
> +	.edid_read =3D lt9611c_bridge_edid_read,
> +	.atomic_enable =3D lt9611c_bridge_atomic_enable,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,

[Severity: Medium]
Is an atomic_disable hook needed here to properly power down the bridge?

The driver implements atomic_enable to set up video timings and dual DSI
ports, but lacks a corresponding atomic_disable. During display blanking
or system DPMS off, the hardware might remain active, wasting power or
potentially locking up when the upstream DSI host stops its clock.

> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,

[Severity: Critical]
Does this compile against the current drm_bridge_funcs definition?

The struct drm_bridge_funcs does not contain an atomic_create_state member,
and the assigned helper drm_atomic_helper_bridge_create_state does not exis=
t.
The correct hook for resetting bridge state is atomic_reset, pointing to
drm_atomic_helper_bridge_reset. Without a valid reset hook, atomic state
allocation for the bridge will fail.

[ ... ]
> +static ssize_t firmware_store(struct device *dev, struct device_attribut=
e *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_warn(dev, "starting firmware upgrade =E2=80=94 display will be disr=
upted\n");
> +
> +	ret =3D lt9611c_firmware_upgrade(lt9611c);

[Severity: High]
Can lt9611c be NULL here if the sysfs file is accessed before probe complet=
es?

The sysfs group is registered via lt9611c_driver.driver.dev_groups, which
means the files are created by the driver core before probe runs. If usersp=
ace
accesses this before i2c_set_clientdata() is called, dev_get_drvdata(dev)
will return NULL, causing an immediate crash when it is passed to
lt9611c_firmware_upgrade().

[ ... ]
> +static ssize_t firmware_show(struct device *dev, struct device_attribute=
 *attr, char *buf)
> +{
> +	struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "0x%04x\n", READ_ONCE(lt9611c->fw_version));
> +}

[Severity: High]
Similar to firmware_store, this will dereference a NULL lt9611c pointer if
the sysfs attribute is read before the client data is set in probe, or if
probe fails.

[ ... ]
> +	lt9611c->bridge.of_node =3D client->dev.of_node;
> +	lt9611c->bridge.ops =3D DRM_BRIDGE_OP_DETECT |
> +			DRM_BRIDGE_OP_EDID |
> +			DRM_BRIDGE_OP_HPD |
> +			DRM_BRIDGE_OP_HDMI |
> +			DRM_BRIDGE_OP_HDMI_AUDIO;
> +	lt9611c->bridge.type =3D DRM_MODE_CONNECTOR_HDMIA;

[Severity: High]
Since this driver sets the DRM_BRIDGE_OP_HDMI flag, does it also need to
initialize supported_hdmi_ver, supported_formats, and max_bpc?

When DRM_BRIDGE_OP_HDMI is set, leaving these uninitialized (zero) causes
drm_bridge_add() to log a warning for an unknown HDMI version. The HDMI sta=
te
helpers will also reject display modes because no valid color formats or
depths are advertised, which prevents display modesetting.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-lt9611c-v7=
-v17-0-1e8f5f2b2f19@oss.qualcomm.com?part=3D2
