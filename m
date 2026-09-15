Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66EEC88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE9510E923;
	Tue, 15 Sep 2026 21:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hKYawqdH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E64A10E923
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 21:21:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5E5860008;
 Tue, 15 Sep 2026 21:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B18D1F000FF;
 Tue, 15 Sep 2026 21:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789507261;
 bh=HgY1DKDVRNB+iXLSP5XiE9Ckygkii4XoXd84Z4mKlkw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hKYawqdHs441c0K/UXcqXGWk2YQQLX296pyWOORfWxjHXpfxcRPFlVuYr6mmoKs1p
 7CbrfA9dIZftG3QhFWS3EynF5RGR/sDFj+js5nD2qMuxv9D+gT9sHFMdt75+8s/+r8
 7ZQHMtvQTQC9x9m0H5NmSPbhTOPZYxd+RR9SZxI7bKTa/we2rFBx+b8ls79MZIYkw8
 Y2ukqx+KMVNKe4NBWEqYMric80qoyYOqeeLpc48++aCczkk9JJ0jwbiTixKq2C5YGu
 b5Swbp8UBfIdq6cMY4gtmeHCC7b4YP7JjfERoA0UQAWDZkNY/0HezMkkFNNu2c1REG
 pUaYc4LvEAWEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] drm/nouveau/gsp/r570: Add comp mode workaround
 from issue #3172217
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260915210647.695187-4-lyude@redhat.com>
References: <20260915210647.695187-1-lyude@redhat.com>
 <20260915210647.695187-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 21:21:00 +0000
Message-Id: <20260915212101.3B18D1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/nouveau/gsp: object class mismatch for NV2080_CTRL_CMD_INTERNA=
L_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE
- [High] drm/nouveau/gsp: missing hardware state rollback on suspend failur=
e leaks GPU state
- [High] drm/nouveau/gsp: LIFO violation resumes channels before re-enablin=
g raw comp mode
--

commit 4ceacec02691502afb3850e4b4368411a557d72f
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r570: Add comp mode workaround from issue #3172217

One of the things that OpenRM does right before initiating fbsr is apply a
special workaround (nvidia issue #3172217) which temporarily disables raw
compression mode on the GPU. It is later re-enabled after resuming with
fbsr completes.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index af5aa5065c3dd..569732320f3dd 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> @@ -26,6 +26,35 @@ r570_fbsr_suspend_channels(struct nvkm_gsp *gsp, bool =
suspend)
>  	return nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
>  }
> =20
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
Does this command need to be sent to device.subdevice instead of
device.object? The RM firmware validates the object class and will reject t=
his
subdevice command when sent to the NV01_DEVICE object, which will cause this
function to fail and break system suspend on Ampere and Ada GPUs.

> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl);
> +
> +	ctrl->bRawMode =3D enable;

[ ... ]

> @@ -59,6 +89,13 @@ r570_fbsr_resume(struct nvkm_gsp *gsp)
> =20
>  	/* Finish cleaning up. */
>  	r535_fbsr_resume(gsp);
> +
> +	/* Re-enable raw mode if it was previously disabled */
> +	if (r570_need_raw_comp_war(gsp, device)) {
> +		ret =3D r570_memsys_enable_raw_comp_mode(gsp, true);

[Severity: High]
Is it safe to re-enable raw mode after channel scheduling is resumed?

In r570_fbsr_suspend(), channel scheduling is stopped before raw mode is
disabled. In r570_fbsr_resume(), channel scheduling is resumed in code
preceding this snippet. Resuming channels before restoring raw compression
mode violates LIFO ordering and creates a race condition where channels mig=
ht
begin processing commands while raw mode is still disabled.

> +		if (ret)
> +			nvkm_error(&gsp->subdev, "Failed to re-enable raw comp mode\n");
> +	}
>  }

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
> +	}
> +

[Severity: High]
Does this code leak hardware state when r570_memsys_enable_raw_comp_mode()
or the subsequent nvkm_instobj_save() loop fails and returns early?

If either fails, the modifications from r570_fbsr_suspend_channels() and
r570_memsys_enable_raw_comp_mode() are not rolled back. The Linux PM
core will abort suspend without calling resume, leaving the GPU permanently
with suspended scheduling and disabled raw compression mode.

>  	/* Save BAR2 allocations to system memory. */
>  	list_for_each_entry(iobj, &imem->list, head) {
>  		if (iobj->preserve) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915210647.6951=
87-1-lyude@redhat.com?part=3D3
