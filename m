Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FA3C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 12:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036E010E452;
	Sun, 12 Jul 2026 12:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Eumjqq18";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 377DF10E452
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 12:48:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B25544326C;
 Sun, 12 Jul 2026 12:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725B61F000E9;
 Sun, 12 Jul 2026 12:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783860495;
 bh=NxABF4bQ0vO4pbUBoFVI+QWidPEPiaVQGPG/udvt+eU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Eumjqq186bYIIesngL0EEU39gJwLLKilpPQETZSPZtigYgjLcypySI9P7jI+FIDGI
 L3Jw36hpFa7mKhErMLDUEVy4e0gFDvcw/0daH5RWmKLzSuzvXwlexhUkkQKgA7cWog
 MyCQxGCF1UK5XKnFgw1vCBBTqXEBeGCE6KN3cj0IgirEdkx1Tdyw39+gV5I8CDmilg
 KY9Nf1VcDIGeKeu7upAnOTUT8yGyfX8L5rbgwJZV20kj9IyS7fWUxiiUrYgkrVqHLL
 bXJK10eckPtsy9HMwiYkyasTV5To9lY6rA1TqHT82XtYDhWlRvg2fbZqrp6tyjgMuo
 0R28ui1dIJ7JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/nouveau/clk: don't use the pstate cursor
 after the loop
To: "Francesco Magazzu" <postadelmaga@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260712123616.1180830-3-postadelmaga@gmail.com>
References: <20260712123616.1180830-1-postadelmaga@gmail.com>
 <20260712123616.1180830-3-postadelmaga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 12:48:14 +0000
Message-Id: <20260712124815.725B61F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Clobbered Hardware Clock Programming Error in `nvkm_cstate_prog`
- [High] State Tracking Desync in `nvkm_pstate_prog`
- [High] Ignored RAM Clock Programming Error in `nvkm_pstate_prog`
--

--- Patch [2]: [PATCH v2 2/4] drm/nouveau/clk: don't use the pstate cursor =
after the loop ---
commit 9e641d48c614d5036ae19e8053df44c4f5085e05
Author: Francesco Magazzu <postadelmaga@gmail.com>

drm/nouveau/clk: don't use the pstate cursor after the loop

nvkm_pstate_prog() walks clk->states looking for an entry and uses the
list_for_each_entry cursor after the loop. Although current callers clamp t=
he
index to prevent out-of-bounds access, this leaves a trap for future caller=
s.
To fix this, the code now tracks whether the entry was found and returns
-EINVAL if it was not.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/clk/base.c
> index 42f3709e07474..4d546b07f4cbf 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
[ ... ]
> @@ -270,13 +270,19 @@ nvkm_pstate_prog(struct nvkm_clk *clk, int pstatei)
[ ... ]
> +	if (!found)
> +		return -EINVAL;
> +
>  	nvkm_debug(subdev, "setting performance state %d\n", pstatei);
>  	clk->pstate =3D pstatei;

[Severity: High]
This isn't a bug introduced by this patch, but could this prematurely
update the software state tracker before hardware programming has
completed and been verified?

If a hardware failure occurs during nvkm_cstate_prog() or RAM clock
programming, the transition fails.

Because clk->pstate is updated here before hardware programming finishes,
a failure leaves the hardware out of sync with software.

Future requests for this state might be incorrectly skipped because the
software evaluates pstate !=3D clk->pstate to false, leaving the hardware
stuck in an inconsistent state.

drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c:nvkm_pstate_prog() {
	...
		do {
			ret =3D ram->func->calc(ram, khz);
			if (ret =3D=3D 0)
				ret =3D ram->func->prog(ram);
		} while (ret > 0);
		ram->func->tidy(ram);
	}

	return nvkm_cstate_prog(clk, pstate, NVKM_CLK_CSTATE_HIGHEST);
}

[Severity: High]
This is also a pre-existing issue, but does nvkm_pstate_prog() silently
discard the RAM clock programming error?

If ram->func->calc() or ram->func->prog() fails and returns a negative error
code (like -EINVAL or a hardware timeout), the error stored in 'ret' is
discarded when the loop exits.

The function then proceeds to unconditionally return the result of
nvkm_cstate_prog().

This decoupling of memory and core clocks could lead to hardware lockups or
severe screen corruption due to mismatched frequencies.

drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c:nvkm_cstate_prog() {
	...
	ret =3D clk->func->calc(clk, cstate);
	if (ret =3D=3D 0) {
		ret =3D clk->func->prog(clk);
		clk->func->tidy(clk);
	}

	if (volt) {
		ret =3D nvkm_volt_set_id(volt, cstate->voltage,
				       pstate->base.voltage, clk->temp, -1);
	...
}

[Severity: High]
This is another pre-existing issue, but is the hardware clock programming=20
error clobbered in nvkm_cstate_prog()?

If clk->func->calc() or clk->func->prog() fails and returns a negative
error code, the 'ret' variable containing the error is unconditionally
overwritten by the return value of nvkm_volt_set_id() (which will be 0 on
success).

This causes the transition to report success despite a hardware failure,
masking the error and corrupting higher-level state tracking.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712123616.1180=
830-1-postadelmaga@gmail.com?part=3D2
