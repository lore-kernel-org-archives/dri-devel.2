Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEF0C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 00:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 002C110E04B;
	Sun,  5 Jul 2026 00:26:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h52nLCBj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 249B310E04B
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 00:26:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A47F6012B;
 Sun,  5 Jul 2026 00:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B8F1F000E9;
 Sun,  5 Jul 2026 00:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783211211;
 bh=ex2qCkz9RyTs5qb2H4B+LynKU0hce4Wa6dk4CpfKyws=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h52nLCBjqThOS+Pl4sO4G7CD0m7YJq9bwsoIB1q5O7lWL5ospI9anwOTHKQEm4Kax
 4s93TBUnLb/x7g0dm8VQ39Z3nEICKxB4WbbVvFXBBh47PGjus7TKWq5+Yi6Ibsdj4L
 xfHYQ6U+fnzLJSVkDGQl3dtOaZmllO+PeHeK9lKK9J+yh216lht8M1pk98BmD2RpEX
 OFV6ZkZUJxgXOgDLKgHl0G2Wx9C0VLN/s0C1vyDGcIj8ey1YhKrpqPka+3qLiFc5G3
 RJEle6wP+eL4g5l6KaE0MT5mvhWEt54DK3H233YCPZ203KGTUng9YzxRWrh0H5PO1R
 SN5xu/XxUEflA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: add missing MODULE_DEVICE_TABLE()
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260705001820.72397-1-pengpeng@iscas.ac.cn>
References: <20260705001820.72397-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 00:26:51 +0000
Message-Id: <20260705002651.B0B8F1F000E9@smtp.kernel.org>
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
- [High] Leaked and dangling session slots on `fastrpc_cb_probe` error path.
- [High] Decrementing `sesscount` in `fastrpc_cb_remove` corrupts the sessi=
on array.
- [High] Missing `of_reserved_mem_device_release` in probe error paths and =
remove function.
--

commit 187d5a897b2d7759c52e28a8af47ac213c1e4782
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

misc: fastrpc: add missing MODULE_DEVICE_TABLE()

The driver has a match table for the of bus wired into its driver
structure, but the table is not exported with MODULE_DEVICE_TABLE().
Add the missing MODULE_DEVICE_TABLE() entry so module alias information
is generated for automatic module loading.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..a5ccdd3eeea11 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2292,6 +2292,7 @@ static const struct of_device_id fastrpc_match_tabl=
e[] =3D {
>  	{ .compatible =3D "qcom,fastrpc-compute-cb", },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, fastrpc_match_table);
> =20
>  static struct platform_driver fastrpc_cb_driver =3D {
>  	.probe =3D fastrpc_cb_probe,

[Severity: High]
This is a pre-existing issue, but does fastrpc_cb_probe() leak session
slots on its error path?

drivers/misc/fastrpc.c:fastrpc_cb_probe() {
    ...
	if (sessions > 0) {
		struct fastrpc_session_ctx *dup_sess;

		for (i =3D 1; i < sessions; i++) {
			if (cctx->sesscount >=3D FASTRPC_MAX_SESSIONS)
				break;
			dup_sess =3D &cctx->session[cctx->sesscount++];
			memcpy(dup_sess, sess, sizeof(*dup_sess));
		}
	}
	spin_unlock_irqrestore(&cctx->lock, flags);
	rc =3D dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
	if (rc) {
		dev_err(dev, "%u-bit DMA enable failed\n", dma_bits);
		return rc;
	}
    ...
}

If dma_set_mask() fails, it returns directly without invalidating the
appended session(s) or rewinding sesscount.

Since sesscount was incremented, fastrpc_session_alloc() might hand out this
broken session slot to a userspace context, which will then attempt to use =
the
uninitialized device for DMA operations.

>  	.remove =3D fastrpc_cb_remove,

[Severity: High]
This isn't a bug introduced by this patch, but could fastrpc_cb_remove()
corrupt the session array when decrementing the total count?

drivers/misc/fastrpc.c:fastrpc_cb_remove() {
    ...
	spin_lock_irqsave(&cctx->lock, flags);
	for (i =3D 0; i < FASTRPC_MAX_SESSIONS; i++) {
		if (cctx->session[i].sid =3D=3D sess->sid) {
			cctx->session[i].valid =3D false;
			cctx->sesscount--;
		}
	}
	spin_unlock_irqrestore(&cctx->lock, flags);
    ...
}

Decrementing the total count without closing the gap in the array breaks the
tracking logic.

Because fastrpc_session_alloc() iterates only up to sesscount, any valid
sessions beyond the new sesscount become immediately unreachable.

A subsequent probe will blindly append at the new sesscount, potentially
overwriting a session that is actively in use by userspace.

>  	.driver =3D {
>  		.name =3D "qcom,fastrpc-cb",
>  		.of_match_table =3D fastrpc_match_table,
>  		.suppress_bind_attrs =3D true,
>  	},
>  };

[Severity: High]
This is also a pre-existing issue, but is there a missing call to
of_reserved_mem_device_release() in the rpmsg probe error paths and remove
function?

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
    ...
	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
    ...
}

drivers/misc/fastrpc.c:fastrpc_rpmsg_remove() {
    ...
	of_platform_depopulate(&rpdev->dev);

	fastrpc_channel_ctx_put(cctx);
}

The reserved memory is bound in fastrpc_rpmsg_probe() but never released
during teardown in fastrpc_rpmsg_remove() or error rollback.

Repeated unbind and bind sequences could leak DMA reserved memory mappings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705001820.7239=
7-1-pengpeng@iscas.ac.cn?part=3D1
