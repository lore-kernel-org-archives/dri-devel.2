Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08056C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0873F10E1F5;
	Wed, 16 Sep 2026 22:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MEEhIUoA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9012A10E1F5
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 22:49:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 515CB41FA6;
 Wed, 16 Sep 2026 22:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DDF1F000FF;
 Wed, 16 Sep 2026 22:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789598974;
 bh=7B6pB9osYWTYDL3saUXm1M2Vox1CkobWnI/2ScVSGcU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MEEhIUoALkb52aCzmz9qlLj12T45yUkh7JM4/g8x5XXvwfXQTuen5p5DFZvs+nv5V
 j24nK+vcCOG2F89AhTlY3hSqTxWV2IIN2yRAOESR01tUaOmNEs+/Iq8M4/adWXAU+I
 0hhhpywUcEJatarjxOKYdEARUo5Sxw1LXUmRFpCMJVcjbniC57nsu305UdKaVVcOD3
 ohJ1jT1BcCQqHeuTEZ2/Bx0p+T/ZnKhgyAVurZOof4IyYY2lwBnrl7SAi315x+/5KE
 XiVzvBfpaEwTDrAv3HDikzIWkApzgrTHdUrx9U1o8ESdQSt8tvEVCez7nLZ0QbxAl2
 dhX3bwfQGEu+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] drm/nouveau/gsp/r570: Add comp mode workaround
 from issue #3172217
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916223358.507351-4-lyude@redhat.com>
References: <20260916223358.507351-1-lyude@redhat.com>
 <20260916223358.507351-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:49:33 +0000
Message-Id: <20260916224934.16DDF1F000FF@smtp.kernel.org>
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
- [High] nouveau/gsp: guaranteed RPC failure in r570_memsys_enable_raw_comp=
_mode due to object mismatch
- [High] nouveau/gsp: missing hardware state rollback on fbsr suspend error=
 paths
--

commit f701d812b32be8bdc5f923ff8d18f26bd8108911
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r570: Add comp mode workaround from issue #3172217

This commit adds a workaround to temporarily disable raw compression mode on
the GPU right before initiating fbsr, and re-enables it upon resuming. This
change is intended to prepare for saving and restoring compbit backings from
the GPU.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index af5aa5065c3dd..fe618a94461dc 100644
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
> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl);
> +
> +	ctrl->bRawMode =3D enable;
> +
> +	ret =3D nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.object, ctrl);

[Severity: High]
Does this command need to be sent to the subdevice object rather than the
device object?

The NV2080 prefix indicates that
NV2080_CTRL_CMD_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE
is a subdevice-level command. If it is sent to the device object
(&gsp->internal.device.object) instead of the subdevice object
(&gsp->internal.device.subdevice), won't the GSP firmware reject the RPC
due to a class mismatch?

If this fails unconditionally on Ampere and Ada GPUs, it would abort the
suspend/resume sequence.

[ ... ]
> @@ -104,6 +141,17 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp)
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
Should we resume the channels before returning an error here?

If r570_memsys_enable_raw_comp_mode() fails, we exit r570_fbsr_suspend()
with an error, bypassing the rest of the suspend. This leaves the channels
permanently suspended since we don't roll back the call to
r570_fbsr_suspend_channels(gsp, true) made just above this block.

> +	}
> +
>  	/* Save BAR2 allocations to system memory. */
>  	list_for_each_entry(iobj, &imem->list, head) {
>  		if (iobj->preserve) {
>  			ret =3D nvkm_instobj_save(iobj);
>  			if (ret)
>  				return ret;

[Severity: High]
Similarly, if nvkm_instobj_save() fails, do we need to re-enable the raw
compression mode and resume the channels?

Returning directly here leaves the hardware state modified without a rollba=
ck
path, which might cause the GPU to be stuck with suspended channels and
disabled compression until a system reboot or driver reload.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916223358.5073=
51-1-lyude@redhat.com?part=3D3
