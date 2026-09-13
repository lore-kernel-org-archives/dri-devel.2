Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC96C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A57C10E8B6;
	Sun, 13 Sep 2026 13:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hLFP0QtY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFB910E8B6
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:07:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CAE043C22;
 Sun, 13 Sep 2026 13:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2514C1F000FF;
 Sun, 13 Sep 2026 13:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789304866;
 bh=KSFMfzEjnS7uyWWF5+oOauNh+DoNeogU3RtPXv45nS8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hLFP0QtYIvb87IX4zxJcapKqGdN33S3/sXLqCiw4P60wOKz6bvTnhanowJAG1gpc2
 JxWBavlnQt2WJTu5WZCYt5zYTKgq2Oq3caCZitvyFXbTidqDQvGMJBAL16qcUsDA1T
 Wlf5Pw7IoR7NiU3T3Ky0kisCaVY31EZVqkmd6ocm4z2LwxaUgqxPzTk+ainwD+6VlU
 1dIIXlS40qHZgBsNrCWZqPkkGufz/oI7xYi2qgeU6DY6oN0PVHuLtiUJRhePcF4sh8
 lqKV8uJy9uZNcOgstszAK8VNpn3FsOUvcELNauxF+TWuqQN4mDEF1XB59mOPcPv/5J
 iLoEwbzRxRgkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau: validate required NET_img regions
To: "Slavin Liu" <bolin.liu@seu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913125228.110071-1-bolin.liu@seu.edu.cn>
References: <20260913125228.110071-1-bolin.liu@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 13:07:45 +0000
Message-Id: <20260913130746.2514C1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds validation on firmware region counts, offsets, and =
dimensions allows out-of-bounds memory accesses and integer overflows if th=
e firmware file is malformed or truncated.
--

commit 8eea807eacef8758484282158b451c9cf174e015
Author: Slavin Liu <bolin.liu@seu.edu.cn>

drm/nouveau: validate required NET_img regions

The NET_img parser can finish without all FECS and GPCCS regions.
Reject missing required regions before computing their data addresses,
and release the firmware on both validation and ACR loading failures.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/gr/ga102.c
> index 2b51f1d0c281f..bfd1e00537b89 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c
> @@ -317,6 +317,11 @@ ga102_gr_load(struct gf100_gr *gr, int ver, const st=
ruct gf100_gr_fwif *fwif)
>  		}
>  	}
> =20
> +	if (!fecs_inst || !fecs_data || !gpccs_inst || !gpccs_data) {
> +		ret =3D -EINVAL;
> +		goto out_firmware;
> +	}
> +
>  	ret =3D nvkm_acr_lsfw_load_bl_sig_net(subdev, &gr->fecs.falcon, NVKM_AC=
R_LSF_FECS,
>  					    "gr/fecs_", ver, fwif->fecs,
>  					    fw->data + fecs_inst->data_offset,
>  						       fecs_inst->data_size,
>  					    fw->data + fecs_data->data_offset,
>  						       fecs_data->data_size);

[Severity: High]
This is a pre-existing issue, but while validating that the required regions
are present, does the code lack bounds checking for the firmware file itsel=
f?

If the user-provided firmware is malformed or truncated, the earlier loop in
ga102_gr_load() could read out of bounds because net->header.regions and
fw->size are never validated:

	for (i =3D 0; i < net->header.regions; i++) {
		const struct netlist_region *reg =3D &net->regions[i];
		struct nvkm_blob blob =3D {
			.data =3D (void *)fw->data + reg->data_offset,
			.size =3D reg->data_size,
		};

Additionally, can this lead to integer truncation when the unvalidated
fecs_inst->data_size is passed to nvkm_acr_lsfw_load_bl_sig_net() here?

drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c:nvkm_acr_lsfw_load_bl_sig_ne=
t() {
    ...
    lsfw->app_resident_code_size =3D ALIGN(inst->size, 256);
    ...
    if (!(lsfw->img.data =3D kzalloc(lsfw->img.size, GFP_KERNEL))) {
    ...
    memcpy(lsfw->img.data + ..., inst->data, inst->size);
    ...
}

Could an overflow during the ALIGN() or size calculation cause an undersized
allocation followed by a heap buffer overflow during the memcpy?

Similarly, would this unvalidated blob->size cause an integer overflow in t=
he
allocation size and a subsequent out-of-bounds write loop in
gk20a_gr_av_to_init_()?

drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c:gk20a_gr_av_to_init_() {
    ...
	nent =3D (blob->size / sizeof(struct gk20a_fw_av));
	pack =3D vzalloc((sizeof(*pack) * 2) + (sizeof(*init) * (nent + 1)));
    ...
	for (i =3D 0; i < nent; i++) {
		struct gf100_gr_init *ent =3D &init[i];
    ...
}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913125228.1100=
71-1-bolin.liu@seu.edu.cn?part=3D1
