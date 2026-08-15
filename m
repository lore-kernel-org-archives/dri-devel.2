Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF186C5CFC1
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 00:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E9410F6A2;
	Sat, 15 Aug 2026 00:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ghztINC8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E805C10F6A2
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 00:08:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D130043396;
 Sat, 15 Aug 2026 00:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F5B1F000E9;
 Sat, 15 Aug 2026 00:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786752509;
 bh=cx68jtuGEmaH1J40Af03VQqUQHjpkjKgQKq0BmD1pFs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ghztINC8Tv4jLgi/MyxagmMFwVv8Bphs3sGGTjNXJAkW4LssAlQA07ANgZKOVU6cJ
 L6LsSdwBcfGAWNPLKDCCVZ27gh6fDPR3LIAw9KsYPoLuhCBX61dgVhL21W1BYZ3/vX
 mvmG+6fGO0y0CwXxzyiUmZ4hQHdcbkx8cW4IqXC/3axsYF/3kikrmfZZoR+poIZMNC
 DTrfWW9/kFyXDlJfLS4w8bWEmBWtDj3sOVOEgZKZaHOf6XhJ2mGDiZ6PMSsPIpbzLi
 5p2vj8NlYXfAuXP4suitChppjqnVKtXavULVBOgvGtUi7H17yA7/PuAaUfjedhw8aH
 cPdrJbQFoNT1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] nouveau: honor HF-EEODB EDIDs by converting to
 struct drm_edid
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814235705.59132-8-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
 <20260814235705.59132-8-mohamedahmedegypt2001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 00:08:29 +0000
Message-Id: <20260815000829.93F5B1F000E9@smtp.kernel.org>
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

New issues:
- [High] OpenFirmware (OF) EDID parsing is broken because the EDID property=
 blob is never updated.

Pre-existing issues:
- [High] Unprotected access to `nv_connector->edid` can cause a kernel pani=
c via a NULL pointer dereference.
- [High] PM runtime autosuspend reference leak on firmware EDID read failur=
e.
- [High] Concurrent execution of asynchronous atomic commit and hotplug det=
ection leads to a Use-After-Free of EDID.
- [High] Potential out-of-bounds heap read during ACPI EDID allocation due =
to untrusted length calculations.
--

--- Patch [7]: [PATCH 7/7] nouveau: honor HF-EEODB EDIDs by converting to s=
truct drm_edid ---
commit 8141f1386a9c223f5c8dc8688b041f5d4419ab2c
Author: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: nouveau: honor HF-EEODB EDIDs by converting to struct drm_edid

This commit converts the nouveau display driver to use the struct drm_edid
API to correctly handle HF-EEODB EDIDs. It updates EDID retrieval paths to
use drm_edid_read helpers and a custom block reader for GSP boards. The
legacy edid pointer is retained as a borrowed view for raw-EDID consumers.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1804,7 +1804,7 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder,=
 struct drm_atomic_commit *st
>  			lvds_8bpc =3D bios->fp.if_is_24bit;
>  		} else {
>  			if (nv_connector->type =3D=3D DCB_CONNECTOR_LVDS_SPWG) {
> -				if (((u8 *)nv_connector->edid)[121] =3D=3D 2)
> +				if (((const u8 *)nv_connector->edid)[121] =3D=3D 2)

[Severity: High]
This is a pre-existing issue, but can this cause a NULL pointer dereference
if the EDID retrieval failed?

If a display mode is forced on via sysfs or a hardcoded VBIOS mode without a
valid EDID, nv_connector->edid will be NULL. Unconditionally dereferencing
it here to check byte 121 could crash the kernel.

[Severity: High]
This is another pre-existing issue, but is there a use-after-free risk here
during concurrent hotplug events?

During an asynchronous atomic commit, nv50_sor_atomic_enable() reads
nv_connector->edid locklessly outside the connection_mutex. If a concurrent
hotplug worker calls nouveau_connector_set_edid() and frees the EDID
memory, this access could corrupt memory. Should atomic drivers read EDID
information from the protected drm_connector_state instead of the mutable
connector state?

>  					lvds_dual =3D true;
>  			} else
>  			if (mode->clock >=3D bios->fp.duallink_transition_clk) {

> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
[ ... ]
> @@ -490,8 +490,11 @@ nouveau_connector_of_detect(struct drm_connector *co=
nnector)
>  		int idx =3D name ? name[strlen(name) - 1] - 'A' : 0;
> =20
>  		if (nv_encoder->dcb->i2c_index =3D=3D idx && edid) {
> +			drm_edid_free(nv_connector->drm_edid);
> +			nv_connector->drm_edid =3D
> +				drm_edid_alloc(edid, EDID_LENGTH);
> +			nv_connector->edid =3D
> +				drm_edid_raw(nv_connector->drm_edid);
>  			return nv_encoder;

[Severity: High]
Does this bypass updating the core connector's blob pointer, breaking OF
EDID parsing?

Because nouveau_connector_of_detect() manually assigns nv_connector->drm_ed=
id
instead of calling nouveau_connector_set_edid(), it skips the
drm_edid_connector_update() call. This leaves the core connector's
edid_blob_ptr as NULL.

>  		}
>  	}
[ ... ]
> @@ -590,20 +618,36 @@ nouveau_connector_detect(struct drm_connector *conn=
ector, bool force)
> =20
>  	nv_encoder =3D nouveau_connector_ddc_detect(connector);
>  	if (nv_encoder) {
> -		struct edid *new_edid =3D NULL;
> +		const struct drm_edid *new_edid =3D NULL;
> =20
>  		if (nv_encoder->i2c) {
>  			if ((vga_switcheroo_handler_flags() & VGA_SWITCHEROO_CAN_SWITCH_DDC) =
&&
>  			    nv_connector->type =3D=3D DCB_CONNECTOR_LVDS)
> -				new_edid =3D drm_get_edid_switcheroo(connector, nv_encoder->i2c);
> +				new_edid =3D drm_edid_read_switcheroo(connector, nv_encoder->i2c);
>  			else
> -				new_edid =3D drm_get_edid(connector, nv_encoder->i2c);
> +				new_edid =3D drm_edid_read_ddc(connector, nv_encoder->i2c);
>  		} else {
> -			ret =3D nvif_outp_edid_get(&nv_encoder->outp, (u8 **)&new_edid);
> +			struct nouveau_rm_edid rm =3D {};
> +
> +			ret =3D nvif_outp_edid_get(&nv_encoder->outp, &rm.data);
>  			if (ret < 0)
>  				return connector_status_disconnected;

[Severity: High]
This isn't a bug introduced by this patch, but does this early return leak a
PM runtime reference?

At the beginning of nouveau_connector_detect(), a PM runtime reference is
acquired. If execution enters this fallback path and nvif_outp_edid_get()
returns < 0, the early return bypasses the out label where
pm_runtime_put_autosuspend() is called. Repeated failures here could
permanently prevent the device from entering low-power states.

> +
> +			/* ret is RM's true buffer size: an HF-EEODB EDID is
[ ... ]
> @@ -712,7 +756,13 @@ nouveau_connector_detect_lvds(struct drm_connector *=
connector, bool force)
>  	 * valid - it's not (rh#613284)
>  	 */
>  	if (nv_encoder->dcb->lvdsconf.use_acpi_for_edid) {
> -		edid =3D nouveau_acpi_edid(dev, connector);
> +		struct edid *raw =3D nouveau_acpi_edid(dev, connector);
> +
> +		if (raw) {
> +			edid =3D drm_edid_alloc(raw,
> +					      EDID_LENGTH * (1 + raw->extensions));
> +			kfree(raw);
> +		}

[Severity: High]
This is a pre-existing issue, but could this lead to an out-of-bounds heap
read if the firmware provides a malformed ACPI table?

The allocation size is computed by trusting the raw->extensions byte. If the
underlying ACPI buffer is physically smaller than what the extensions byte
claims, drm_edid_alloc() will read past the end of the raw buffer when
copying the data.

>  		if (edid) {
>  			status =3D connector_status_connected;
>  			goto out;
[ ... ]
> @@ -973,8 +1024,8 @@ nouveau_connector_get_modes(struct drm_connector *co=
nnector)
>  		nv_connector->native_mode =3D NULL;
>  	}
> =20
> -	if (nv_connector->edid)
> -		ret =3D drm_add_edid_modes(connector, nv_connector->edid);
> +	if (nv_connector->drm_edid)
> +		ret =3D drm_edid_connector_add_modes(connector);

[Severity: High]
Since nouveau_connector_of_detect() left the core connector's edid_blob_ptr
NULL, will this fail to parse any display modes?

The drm_edid_connector_add_modes() helper relies exclusively on
connector->edid_blob_ptr. If it remains NULL, this will silently fail and
break display output for OpenFirmware displays.

>  	else
>  	if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_LVDS &&
>  	    (nv_encoder->dcb->lvdsconf.use_straps_for_mode ||

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814235705.5913=
2-1-mohamedahmedegypt2001@gmail.com?part=3D7
