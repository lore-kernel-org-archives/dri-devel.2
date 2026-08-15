Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E658C5B572
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 00:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF8610E10F;
	Sat, 15 Aug 2026 00:13:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JgMHF8BS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3510610E10F
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 00:13:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DBC560008;
 Sat, 15 Aug 2026 00:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A747B1F000E9;
 Sat, 15 Aug 2026 00:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786752793;
 bh=7RB1lhsdwTLATapkCkGHzJDUND5eo8fYYFpa82FOWJU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JgMHF8BS0ESWrekmZsxaN/0l9PrGrtpgNLuEAcHyEebgXY5mOOPmqjfU4PulL5Vln
 prqhKTHjaSSsAYqkFQbztBPQ3evH+pphIM4GD6+qNzNUe9xv7LKJkR29wD7KjOgpC3
 TBz3vvHzDQ9nLys/L4cAIxP2YxK8zDFx+gYcyPAXqBZKIBFTpCV14rRBrVMlH/3Efy
 4fBhQPuzQbLsaI4jP9t96jYumKhZz8xmLC0F9zWVtXYdbaCM3+/oOd20WLauC33Fjx
 CL4eh23OoorpC2mtLkEXZaBihSBy67X+I7bIsCmMyW8gZnYXnAvbUh7Jmljece1roT
 jJUeMzKUiy1+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] nouveau/gsp: use per-version DP_CONFIG_STREAM
 params on r570 firmware
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814235705.59132-5-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
 <20260814235705.59132-5-mohamedahmedegypt2001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 00:13:13 +0000
Message-Id: <20260815001313.A747B1F000E9@smtp.kernel.org>
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
- [High] Integer underflow when computing MST.slotEnd for disabled outputs,=
 leading to a massive slotEnd value (0xFFFFFFFF).
--

--- Patch [4]: [PATCH 4/7] nouveau/gsp: use per-version DP_CONFIG_STREAM pa=
rams on r570 firmware ---
commit d855125b895d27bafd2aaed0c330ae6eae007aef
Author: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>

nouveau/gsp: use per-version DP_CONFIG_STREAM params on r570 firmware

This commit separates the DP_CONFIG_STREAM_PARAMS structure and its related
functions into r535 and r570 variants. This handles the structure shrinking
that occurred in the 570 firmware version.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c
> index a96e31c2d80b2..61f82e15ff398 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c
[ ... ]
> @@ -74,6 +75,67 @@ r570_disp_chan_set_pushbuf(struct nvkm_disp *disp, s32=
 oclass, int inst, struct
>  	return nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
>  }
> =20
> +static void
> +r570_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pb=
n, u16 aligned_pbn)
> +{
> +	struct nvkm_disp *disp =3D sor->disp;
> +	NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
[ ... ]
> +	ctrl->MST.slotStart =3D slot;
> +	ctrl->MST.slotEnd =3D slot + slot_nr - 1;

[Severity: High]
This isn't a bug introduced by this patch, but this preexisting issue gets
copied into the new r570_dp_vcpi() function from the r535 code.

When an MST output is disabled, nv50_msto_prepare() (in dispnv50/disp.c)
calls nvif_outp_dp_mst_vcpi() with num_slots=3D0. This propagates here, set=
ting
slot_nr to 0.

With slot_nr =3D 0, does the expression "slot + slot_nr - 1" evaluate to -1?
Since MST.slotEnd is an NvU32, this would underflow to 0xFFFFFFFF, passing
a maximal bound for a time slot range to the GSP firmware.=20

Could this potentially cause out-of-bounds accesses or hangs in the firmwar=
e?
Should this logic be updated to handle slot_nr =3D 0 safely before it evalu=
ates
to -1 and underflows?

> +	ctrl->MST.PBN =3D pbn;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814235705.5913=
2-1-mohamedahmedegypt2001@gmail.com?part=3D4
