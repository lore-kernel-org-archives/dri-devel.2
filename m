Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A62C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A931510E520;
	Fri, 11 Sep 2026 22:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X/LqolwP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1020B10E520
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 22:37:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87DD5600AA;
 Fri, 11 Sep 2026 22:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6D11F000FF;
 Fri, 11 Sep 2026 22:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789166247;
 bh=YHxbnJ8eGfsgHLlvSmDgbYKgj1h0G2vOXYUzEdcVMbg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X/LqolwPcHmW7D8dP8JYV+5IZv1/WHLdYh/iIaS8tRP3gjaUt3/ceEGlznybAPUdH
 kRgnHwIr3FqQiatseRoSlxOk3VGQFYsUkabfwyE7mYeyjFKjPuJZAJ2cqrg1TFHpNd
 FmzaKxrgjrDCxF5z/P89zpw2rMFv4U136c7/jngc1QbfQ5yYMuuWEgoq0MV+HD6cOd
 blfn5uTGOCgqijdEz/Hm4UMPFB2B5zy6RWae0Bqt4h8HaMjKbaSoaDBMW0Bhq6qQ+Y
 Xs7FHAWiSojMhUE8sBFZQSlroSy5wU8CDMWQ1qQ5l53SyfebqUKlLaPfdq9axJlYRu
 +f605ihwH8MEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] drm/nouveau/gsp/r570: Add comp mode workaround from
 issue #3172217
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911222428.752641-4-lyude@redhat.com>
References: <20260911222428.752641-1-lyude@redhat.com>
 <20260911222428.752641-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:37:26 +0000
Message-Id: <20260911223727.1B6D11F000FF@smtp.kernel.org>
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

New issues:
- [High] API Misuse causing command rejection: `r570_memsys_enable_raw_comp=
_mode()` allocates the RPC with the device object instead of the subdevice =
object.

Pre-existing issues:
- [High] Missing state cleanup on error paths in the suspend callback cause=
s the GPU to hang permanently after a failed suspend.
--

commit 9926d57d576468c9d718471d17ce97302fb87674
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r570: Add comp mode workaround from issue #3172217

This commit temporarily disables raw compression mode on the GPU right
before initiating fbsr during suspend, and re-enables it upon resume.
This workaround resolves an issue on Ampere and Ada GPUs.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
[ ... ]
> +static int
> +r570_memsys_enable_raw_comp_mode(struct nvkm_gsp *gsp, bool enable)
> +{
> +	NV2080_CTRL_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE_PARAMS *ctrl;
> +	int ret;
> +
> +	ctrl =3D nvkm_gsp_rm_ctrl_get(&gsp->internal.device.object,
> +				    NV2080_CTRL_CMD_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE,
> +				    sizeof(*ctrl));

[Severity: High]
Does this code allocate the RPC with the device object instead of the
subdevice object?

By passing &gsp->internal.device.object, the header receives the NV0080
device handle, but the command (NV2080_CTRL_CMD_INTERNAL_MEMSYS_...) is an
NV2080 subdevice command. This mismatch between the command class and the
target object typically causes the GSP firmware to reject the command,
causing the workaround to fail and suspend to abort.

> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl);
> +
> +	ctrl->bRawMode =3D enable;
> +
> +	ret =3D nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);

The write operation here correctly uses &gsp->internal.device.subdevice,
which seems to confirm the intended target object is the subdevice. Should
the nvkm_gsp_rm_ctrl_get() call above also use the subdevice?

[ ... ]
> @@ -104,6 +140,17 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp)
>  	/* Stop channel scheduling. */
>  	r570_fbsr_suspend_channels(gsp, true);
> =20
> +	/* Temporarily disable raw mode to prevent FBSR restore operations from=
 corrupting
> +	 * compressed surfaces. Required for ampere and ada.
> +	 *
> +	 * Nvidia bug #3172217
> +	 */
> +	if (r570_need_raw_comp_war(gsp, device)) {
> +		ret =3D r570_memsys_enable_raw_comp_mode(gsp, false);
> +		if (ret)
> +			return ret;

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leave
the GPU channels permanently disabled?

If this function returns an error, the Linux PM framework does not invoke
the device's resume callback. This means r570_fbsr_suspend_channels(gsp,
false) is never called, potentially causing a hard hang of the GPU session.

While not introduced by this patch, adding a new command that might fail
(especially given the object mismatch noted above) heavily exacerbates the
missing cleanup on this error path.

> +	}
> +
>  	/* Save BAR2 allocations to system memory. */
>  	list_for_each_entry(iobj, &imem->list, head) {
>  		if (iobj->preserve) {
>  			ret =3D nvkm_instobj_save(iobj);
>  			if (ret)
>  				return ret;

[Severity: High]
This isn't a bug introduced by this patch, but this error path now also ski=
ps
re-enabling raw compression mode in addition to leaving channels disabled.
Could we use a goto label to ensure proper state cleanup before returning
suspend errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911222428.7526=
41-1-lyude@redhat.com?part=3D3
