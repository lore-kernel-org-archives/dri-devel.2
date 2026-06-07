Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF62CD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 12:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 545CF10EA18;
	Sun,  7 Jun 2026 12:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TGRVgwwl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6836110EA18
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 12:26:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A22A6001D;
 Sun,  7 Jun 2026 12:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE531F00893;
 Sun,  7 Jun 2026 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780835175;
 bh=JcszkUFLBqI8FU6CIUlSAU11Krf0euACmk+pnRdkCS0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TGRVgwwlHM3rq3b88cJQ1eF7Ee8E8sDddq3WTzwXjEZNB4gNoSkGDbIVjD9rtBtKS
 MptxhlHziI9IrLn6aV89oGy4dvKVu267bBckq1OE/FA30qWUoXTdU/FWHvBuSQuUYY
 X60vJjeGGk2dDzcEEWloj7gm+YyrNrYMmxbd6VNmFV3QU2kMXCWwb+5Lp2IILIFLiU
 cKvQKTPmt8syfa6Cv1vyp3Zn4g9vk3yHQ4uNUM5Kav6XsZMRzvSiEf4FwTmJqaPczd
 nkTTh2KINZVBWjiXQ7VkQZAla+EG6Pq67UyCjU0e5nT15ZSAdoDoH33zvSt+UyaRiP
 ooFNs5g/4ShYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau: bounds-check pushbuf offset/length in
 legacy DMA path
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <MEYPR01MB78861402D9E05E9CA6B67859AF1F2@MEYPR01MB7886.ausprd01.prod.outlook.com>
References: <MEYPR01MB78861402D9E05E9CA6B67859AF1F2@MEYPR01MB7886.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 12:26:14 +0000
Message-Id: <20260607122615.2AE531F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] The WIND_RING function fails to rollback the nvif_push buffer stat=
e, causing aborted commands to be submitted on the next ioctl.
- [High] The legacy pushbuf branch calculates the kernel jump-back address =
using a stale `chan->dma.cur`, causing an infinite loop when submitting mul=
tiple user BOs.
--

commit 58dcc07cf127c2fddaeed29612e7fbaebbf1c7ae
Author: Junrui Luo <moonafterrain@outlook.com>

drm/nouveau: bounds-check pushbuf offset/length in legacy DMA path

This patch adds bounds checking for pushbuf offset and length in the legacy
pre-NV25 DMA path. It rejects out-of-bounds pushes before calling
nouveau_bo_wr32() to prevent memory corruption.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouv=
eau/nouveau_gem.c
> index 20dba02d6175b..e9309279ba8dd 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
[ ... ]
> @@ -898,6 +898,17 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, vo=
id *data,
>  			cmd =3D chan->push.addr + ((chan->dma.cur + 2) << 2);

[Severity: High]
This is a pre-existing issue, but does this calculation use a stale
chan->dma.cur?

In the legacy chipset branch, the loop calculates the jump back into the
kernel pushbuffer using chan->dma.cur, but chan->dma.cur is never increment=
ed
within the loop. PUSH_JUMP and PUSH_DATA advance chan->chan.push.cur instea=
d.

Since chan->dma.cur isn't updated in the loop, won't all user BOs in a
multi-push submission be instructed to jump back to the exact same offset in
the kernel pushbuffer?

Could this cause the GPU to re-execute the jump to the second user BO and
enter an infinite command loop?

>  			cmd |=3D 0x20000000;
>  			if (unlikely(cmd !=3D req->suffix0)) {
> +				if (unlikely(push[i].offset +
> +					     push[i].length < 8 ||
> +					     push[i].offset +
> +					     push[i].length >
> +					     nvbo->bo.base.size)) {
> +					NV_PRINTK(err, cli, "push %d buffer not within bo\n", i);
> +					WIND_RING(chan);

[Severity: High]
This isn't a bug introduced by this patch, but does WIND_RING() fully
rollback the push buffer state?

Looking at WIND_RING():

drivers/gpu/drm/nouveau/nouveau_dma.h:WIND_RING() {
	chan->dma.cur =3D chan->dma.put;
}

It only resets chan->dma.cur. However, the subsequent code uses PUSH_JUMP
and PUSH_DATA, which write directly to the nvif_push object and increment
chan->chan.push.cur without updating chan->dma.cur.

If WIND_RING() is called on an error path, but chan->chan.push.cur is not
reset, will the next successful ioctl compute the length including these
aborted commands?

Since nouveau_bo_wr32() wasn't executed to write the jump-back instruction
into the user BO for the aborted push, could committing these aborted comma=
nds
to the GPU cause a hang?

> +					ret =3D -EINVAL;
> +					goto out;
> +				}
> +
>  				if (!nvbo->kmap.virtual) {
>  					ret =3D ttm_bo_kmap(&nvbo->bo, 0,
>  							  PFN_UP(nvbo->bo.base.size),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/MEYPR01MB78861402D9=
E05E9CA6B67859AF1F2@MEYPR01MB7886.ausprd01.prod.outlook.com?part=3D1
