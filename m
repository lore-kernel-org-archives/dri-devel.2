Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F96606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGtX2erB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2502289321;
	Tue, 24 Nov 2026 21:07:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5954E89321
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 21:06:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0EA634160B;
 Tue, 24 Nov 2026 21:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29551F000D2;
 Tue, 24 Nov 2026 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795554416;
 bh=dgUdXTBUUb/qbhg5JLket8CrG1LLe0WNnBAdClr267k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oGtX2erBXlaZ5O4+OQNfwW/Dw4nCujm43fSB+plUoX/0aFjOU65hEojfxQB+Dm1gL
 qCjh1iZx0RRips1S3wAl0oMUmZDslDbdDQ7+GwAZkRVm9I+EnGectlV6blFPxFqDu2
 YeeAbQlPiTtssrGkvLMhjBnytIYG3gpMBoPPLWTrQbA27VRtxAO2QU3I0tdzesHcqb
 MZVXVwi5rcCs6zDBXvFCMZkeyCC1HxpPHPmSbmwieNdyNEhK4mf0SDQbsFFrdCTnIY
 fzuQoSuFA5MZwDL9nUWsvuPTVsrsYLzst9E/ZALQFAze3dM9/PtL1/mleRMNWq0jsB
 lRBWcoosZ5VjA==
Message-ID: <sashiko-outbox-232015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/fb/ramnv50: Fixed DDR2 reclocking on NV50
 architectures
To: "Mahdi Salimi" <mahdisalimikingmallo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125-ramnv50-ddr2-reclock-v1-1-64f046c1c95d@gmail.com>
References: <20261125-ramnv50-ddr2-reclock-v1-1-64f046c1c95d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 21:06:56 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/nouveau/fb: nv50_ram_calc() does not write calculated
  DDR2 mr[0]
--

commit 2fb9a17101350a18953857e40ee356852e576655
Author: Jonathan Fouquart <jfouquart@hotmail.fr>

drm/nouveau/fb/ramnv50: Fixed DDR2 reclocking on NV50 architectures

This commit adds the NVKM_RAM_TYPE_DDR2 case to nv50_ram_calc() to call
nvkm_sddr2_calc() when calculating DDR2 mode register values during
memory reclocking.

Link: https://gitlab.freedesktop.org/drm/nouveau/-/merge_requests/23

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c b/drivers/g=
pu/drm/nouveau/nvkm/subdev/fb/ramnv50.c
> index be15519d0c969..d013a2fd2b2e7 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c
> @@ -288,6 +288,9 @@ nv50_ram_calc(struct nvkm_ram *base, u32 freq)
>  	ram->base.mr[2] =3D ram_rd32(hwsq, mr[2]);
> =20
>  	switch (ram->base.type) {
> +	case NVKM_RAM_TYPE_DDR2:
> +		ret =3D nvkm_sddr2_calc(&ram->base);
> +		break;
>  	case NVKM_RAM_TYPE_GDDR3:
>  		ret =3D nvkm_gddr3_calc(&ram->base);
>  		break;

[Severity: Medium]
Should the second switch on ram->base.type in nv50_ram_calc() also write
ram->base.mr[0] to mr[0] for NVKM_RAM_TYPE_DDR2?

nvkm_sddr2_calc() updates the CL and WR fields in ram->base.mr[0], and
nv50_ram_calc() later writes ram->base.mr[1] and the new memory
controller timing registers, but the MR0 update for DDR2 still uses a
no-op mask:

drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c:nv50_ram_calc() {
	...
	switch (ram->base.type) {
	case NVKM_RAM_TYPE_DDR2:
		ram_nuke(hwsq, mr[0]); /* force update */
		ram_mask(hwsq, mr[0], 0x000, 0x000);
		break;
	case NVKM_RAM_TYPE_GDDR3:
		ram_nuke(hwsq, mr[1]); /* force update */
		ram_wr32(hwsq, mr[1], ram->base.mr[1]);
		ram_nuke(hwsq, mr[0]); /* force update */
		ram_wr32(hwsq, mr[0], ram->base.mr[0]);
		break;
	...
}

Because ram_mask(hwsq, mr[0], 0x000, 0x000) re-emits the pre-reclock
value cached in hwsq->r_mr[0].data rather than ram->base.mr[0],
reclocking between performance states with different CL or WR values
leaves the DDR2 chips programmed with the old MR0 timings while the
memory controller uses the new timings, which can corrupt VRAM or hang
the GPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-ramnv50-dd=
r2-reclock-v1-1-64f046c1c95d@gmail.com?part=3D1
