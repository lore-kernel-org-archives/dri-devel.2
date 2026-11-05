Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65C606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frEWTOgH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B51310FCFE;
	Thu,  5 Nov 2026 18:05:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D50310E95F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 18:05:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1125F601BE;
 Thu,  5 Nov 2026 18:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993601F000C1;
 Thu,  5 Nov 2026 18:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793901941;
 bh=FqpZKtb6Iw0j+0nNkzygJEo/Lzt18OHSh3xX1n4U0qw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=frEWTOgHj1fdyGHqXU0IL7PxQk/L2OrCIpbv6fCE8LQfQm2JjCSlX6C3m/P80qI1w
 fivPB481x0P81rIaUsjBqBaJEA8cUWs1SDLq/F2fNz5CjVu1YrescHd0aOMgEX7Nor
 uefWIpmmVCBDZx4lsb8R3hdWmVD020kznLi+QOksEipgG+FRu75mBCDBpzxsN70CTt
 WSkyhO8CdFjXiA3rWFsU26D5ZNs+OKIRSMtWq8OGl9sMwdiXmihQXDpt5g+fqHx1Rs
 WTULa2HP4aToSRkENE+pzipRvScPT3RA5BTBA8qbUyTbnAiZsnI0lLwthcUUKeAM6r
 OnA6PilpC3Bag==
Message-ID: <sashiko-outbox-199686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 26/27] drm/debugfs: Expose HDMI VRR in vrr_range debugfs
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-26-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-26-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:05:41 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/debugfs: vrr_range_show() reports Max: 0 when HDMI VRRmax is=
 0
--

commit c20f012be0daea32ab333f3e4f526e77c8606b3b
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/debugfs: Expose HDMI VRR in vrr_range debugfs

This commit updates vrr_range_show() to report HDMI VRR limits from
display_info.hdmi.vrr_cap when HDMI VRR is supported, and protects access
to connector->status and connector->display_info with mode_config.mutex.

> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index a72f9723d3a97..476f44642ac3e 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -586,12 +586,26 @@ static ssize_t edid_write(struct file *file, const =
char __user *ubuf,
>  static int vrr_range_show(struct seq_file *m, void *data)
>  {
>  	struct drm_connector *connector =3D m->private;
> +	u16 min_vfreq, max_vfreq;
> +
> +	scoped_cond_guard(mutex_intr, return -EINTR,
> +			  &connector->dev->mode_config.mutex) {
> +		struct drm_display_info *info =3D &connector->display_info;
> +
> +		if (connector->status !=3D connector_status_connected)
> +			return -ENODEV;
> +
> +		if (info->is_hdmi && info->hdmi.vrr_cap.supported) {
> +			min_vfreq =3D info->hdmi.vrr_cap.vrr_min;
> +			max_vfreq =3D info->hdmi.vrr_cap.vrr_max;
> +		} else {
> +			min_vfreq =3D info->monitor_range.min_vfreq;
> +			max_vfreq =3D info->monitor_range.max_vfreq;
> +		}

[Severity: Medium]
Can vrr_range_show() in drivers/gpu/drm/drm_debugfs.c report "Max: 0" when
an HDMI 2.1 sink advertises VRR support with VRRmax set to 0 in its HF-VSDB?

In drivers/gpu/drm/drm_edid.c, drm_parse_hdmi_gaming_info() sets
vrr->supported =3D true even when vrr->vrr_max is 0 (either because byte 10
of the HF-VSDB is omitted or because the 10-bit VRRmax field is 0, which
HDMI 2.1 uses when the upper refresh limit is below 100 Hz or defined by
the video mode / EDID monitor range):

	vrr->vrr_min =3D db[9] & DRM_EDID_VRR_MIN_MASK;
	vrr->supported =3D (vrr->vrr_min > 0 && vrr->vrr_min <=3D 48);

	if (cea_db_payload_len(db) < 10)
		return;

	vrr->vrr_max =3D (db[9] & DRM_EDID_VRR_MAX_UPPER_MASK) << 2 | db[10];
	vrr->supported &=3D (vrr->vrr_max =3D=3D 0 || vrr->vrr_max >=3D 100);

Drivers such as amdgpu handle vrr_cap.vrr_max =3D=3D 0 in
amdgpu_dm_update_freesync_caps() in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c by falling back
to connector->display_info.monitor_range.max_vfreq (or the highest mode
refresh rate, AMD FreeSync VSDB, and panel quirks) and storing the resolved
bounds back into connector->display_info.monitor_range:

		if (vrr_cap->supported && vrr_cap->vrr_min > 0) {
			amdgpu_dm_connector->min_vfreq =3D vrr_cap->vrr_min;
			amdgpu_dm_connector->max_vfreq =3D vrr_cap->vrr_max ?
				vrr_cap->vrr_max :
				connector->display_info.monitor_range.max_vfreq;

By checking info->is_hdmi && info->hdmi.vrr_cap.supported first and
unconditionally reading info->hdmi.vrr_cap.vrr_max, won't vrr_range_show()
bypass info->monitor_range and output "Max: 0" whenever VRRmax is 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D26
