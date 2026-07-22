Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63775C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 04:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3BEF10E407;
	Wed, 22 Jul 2026 04:37:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dXLCRdjF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98DB10E407
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 04:37:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 39E3541706;
 Wed, 22 Jul 2026 04:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70051F000E9;
 Wed, 22 Jul 2026 04:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784695078;
 bh=jZHqdVoA2vwwxB7YLbhgRBnSf8EYjkvq3Ijm9NucyWY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dXLCRdjFiXLJ/8mgn5acv++fPjCUHzvD7z4RcFzZIW6XosWAePyvs+xgzIQHGhKLZ
 yhK3SUOB2AbkfdbCzGfda800VcYBreIzIhUIe/EUVJxCUWqGVTTK/YSJF1zCmUtJsU
 +s2Il6YqiH+HXSR052vjqAh2yGtcojQlnwa0QqHkHtW/ApqsCHRGKP9a5i7SFff3YY
 w6h1L+hAYlWOmH8O5MOSsu7eFESZQYduSWHBXLdss6kfuO/4hdo1toVqE1gqmq8Rx2
 OfW1tyLX4lvsgAN4NoofHSzq0JgsJQC9ppwpSpI9+wSAYqTtuLADSmAtCcW3pk546c
 G9XwmqwAixrjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/gsp: validate sequencer command span
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722042123.39900-1-pengpeng@iscas.ac.cn>
References: <20260722042123.39900-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 04:37:57 +0000
Message-Id: <20260722043757.E70051F000E9@smtp.kernel.org>
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
- [High] The command buffer bounds checks can be bypassed because the param=
eter `repc` can underflow and wrap to a huge positive value if the caller r=
eceives a malformed message.
--

--- Patch [1]: [PATCH] drm/nouveau/gsp: validate sequencer command span ---
commit 238e220cb43516ffb6d1d9d9dd564342e419d339
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm/nouveau/gsp: validate sequencer command span

This commit adds validation to the GSP sequencer RPC command stream to ensu=
re
commands fit within the received RPC payload and fixed save area.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> index f544afa12b6bb..00417bbccc127 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> @@ -1010,15 +1010,30 @@ r535_gsp_msg_run_cpu_sequencer(void *priv, u32 fn=
, void *repv, u32 repc)
>  	struct nvkm_subdev *subdev =3D &gsp->subdev;
>  	struct nvkm_device *device =3D subdev->device;
>  	rpc_run_cpu_sequencer_v17_00 *seq =3D repv;
> -	int ptr =3D 0, ret;
> +	u32 ptr =3D 0, payload;
> +	int ret;
> +
> +	if (repc < offsetof(rpc_run_cpu_sequencer_v17_00, commandBuffer) ||
> +	    seq->cmdIndex >
> +	    (repc - offsetof(rpc_run_cpu_sequencer_v17_00, commandBuffer)) /
> +	    sizeof(seq->commandBuffer[0])) {

[Severity: High]
This is a pre-existing issue, but can this bounds check be bypassed if repc
has underflowed?

If the GSP firmware sends a message with an rpc->length smaller than
sizeof(*rpc), the calculation in the caller r535_gsp_msg_recv() could
underflow:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_msg_recv() {
    ...
    if (ntfy->func)
        ntfy->func(ntfy->priv, ntfy->fn, rpc->data,
                   rpc->length - sizeof(*rpc));
    ...
}

Because this calculation lacks validation that rpc->length >=3D sizeof(*rpc=
),
it can produce a huge positive value. If this large value is passed as repc,
the comparison repc < offsetof(...) evaluates to false since repc is an
unsigned integer. This bypasses the size check entirely and could allow
out-of-bounds reads and writes.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722042123.3990=
0-1-pengpeng@iscas.ac.cn?part=3D1
