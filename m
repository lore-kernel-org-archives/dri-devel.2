Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9C3CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F245A10EE39;
	Wed,  7 Oct 2026 11:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lMVqRpZL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B96610EE39
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 11:49:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3AF60417A4;
 Wed,  7 Oct 2026 11:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF02E1F0089B;
 Wed,  7 Oct 2026 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791373759;
 bh=jphD37XWPLzzsYlT7j2OAN/bdxiXQigiXbLPNBYEBP4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lMVqRpZLgM5v05h58s0bInVl5tWt5XgbfFq+m72m06+G/PtByyfc6YaAxhv4HREMR
 GD0WZiYSn5FlbTZ9wiMRbFv6gVYUbniadxaaK0kcNbOoEJNYpHWVQjd9JymcywXyDh
 rp4yUAVNQl8WOfvvcAtLyHc+AfQZIKQbsqYesGDQ7JgJdyVsX/o1Lw2BblHr1zmqFI
 cx/ZGYV/4fgxNOWQYgqylm9B1wXdlmnq2/JhhkQ2dM2C1HfmyuFldoLkESjdWJOxT8
 Va+Yv7SQK81VAzmUkSt/5XOcHE7HfNBLP2dv/lWVQZwsEsalsIyQFOQoTrlRvhT8hU
 BIOJy/lR/j4cw==
Message-ID: <sashiko-outbox-162938@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] misc: fastrpc: add UAPI flags for extended IOVA
 mapping
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20261007-extended-mapping-v2-4-5dca3aa2c2d3@oss.qualcomm.com>
References: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
 <20261007-extended-mapping-v2-4-5dca3aa2c2d3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:49:18 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] misc: fastrpc: unbounded memory and DMA mapping leak via mismatche=
d map flags
- [High] misc: fastrpc: UAF of ext_cb array due to race with krealloc durin=
g probe
- [High] fastrpc: refcount underflow via retained 0-refcount map on SCM err=
or
- [High] misc: fastrpc: memory leak and invalid hyp unmap on secure mapping=
 failure
- [Medium] misc: fastrpc: extended context bank mappings are bypassed and d=
efeated during DSP invocation
--

commit d890ee0bf9f03c55cbc6da25fffce9e57f51d755
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: misc: fastrpc: add UAPI flags for extended IOVA mapping

This commit introduces new UAPI flags, FASTRPC_MAP_FD_EXTENDED and
FASTRPC_MAP_FD_DELAYED_EXTENDED, allowing userspace to map large buffers via
the extended SMMU context bank. It adds a flags parameter to map creation a=
nd
validation routines to handle the requested context bank type.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d40cdcd5dec30..4ba07a5b28bb4 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -398,7 +404,7 @@ static void fastrpc_free_map(struct kref *ref)
>  			err =3D qcom_scm_assign_mem(map->dma_addr, map->len,
>  				&src_perms, &perm, 1);
>  			if (err) {
> -				dev_err(map->fl->sctx->dev,
> +				dev_err(map->attach->dev,
>  					"Failed to assign memory dma_addr %pad size 0x%llx err %d\n",
>  					&map->dma_addr, map->len, err);
>  				return;

[Severity: High]
This problem wasn't introduced by this patch, but if qcom_scm_assign_mem()
fails, the function returns early without unlinking the map from the list
via list_del().

This leaves the map object in the fl->maps list with a 0-refcount.

During session teardown, fastrpc_user_free() calls fastrpc_map_put() on all
entries in fl->maps:

drivers/misc/fastrpc.c:fastrpc_user_free() {
	list_for_each_entry_safe(map, m, &fl->maps, node)
		fastrpc_map_put(map);
}

Does the early return here strand the map object in the active list and
lead to a double-put and refcount underflow?

[ ... ]

> @@ -956,7 +967,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl=
, int fd,
>  		map->attr =3D attr;
>  		err =3D qcom_scm_assign_mem(map->dma_addr, (u64)map->len, &src_perms, =
dst_perms, 2);
>  		if (err) {
> -			dev_err(sess->dev,
> +			dev_err(dev,
>  				"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
>  				&map->dma_addr, map->len, err);
>  			goto get_err;

[Severity: High]
This problem wasn't introduced by this patch, but the map->attr field is set
to the requested attributes before calling qcom_scm_assign_mem().

If this hypervisor call fails, the code jumps to get_err and calls
fastrpc_map_put().

Because map->attr is already set to FASTRPC_ATTR_SECUREMAP, fastrpc_free_ma=
p()
will attempt to transition the memory back to HLOS using a source permission
mask that includes the secure VM:

drivers/misc/fastrpc.c:fastrpc_free_map() {
	if (map->attr & FASTRPC_ATTR_SECUREMAP) {
		...
		err =3D qcom_scm_assign_mem(map->dma_addr, map->len,
			&src_perms, &perm, 1);
		if (err) {
			dev_err(map->attach->dev, ...);
			return;
		}
	}
}

Since the initial transition never succeeded, the memory does not belong to
the secure VM and this second qcom_scm_assign_mem() call will fail.

Does setting map->attr before a successful hypervisor call lead to an inval=
id
unmap attempt that returns early, leaking the DMA structures and map object?

>  		}
> @@ -979,13 +990,47 @@ static int fastrpc_map_attach(struct fastrpc_user *=
fl, int fd,
>  	return err;
>  }
> =20
> +static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
> +			      u64 len, u32 attr, u32 flags, struct fastrpc_map **ppmap)
> +{
> +	if (IS_EXTENDED_MAP_FLAG(flags)) {
> +		struct fastrpc_session_ctx **ext_cb;
> +		int i, count, err =3D -ENODEV;
> +		unsigned long lock_flags;
> +
> +		spin_lock_irqsave(&fl->cctx->lock, lock_flags);
> +		count =3D fl->cctx->ext_cb_count;
> +		ext_cb =3D fl->cctx->ext_cb;
> +		spin_unlock_irqrestore(&fl->cctx->lock, lock_flags);
> +
> +		if (!count) {
> +			dev_err(fl->sctx->dev, "no extended context bank found\n");
> +			return -ENODEV;
> +		}
> +
> +		for (i =3D 0; i < count; i++) {
> +			err =3D fastrpc_map_attach_to_dev(fl, fd, len, attr, flags,
> +							ext_cb[i], ppmap);

[Severity: High]
The ext_cb array pointer is cached under the lock but dereferenced outside
of it in a loop.

Because fastrpc_rpmsg_probe() registers the character device via
fastrpc_device_register() before calling fastrpc_cb_devices_create(),
userspace can concurrently issue a FASTRPC_IOCTL_MEM_MAP ioctl with an
extended map flag.

Concurrently, fastrpc_cb_init() resizes the array without RCU or
synchronization against readers:

drivers/misc/fastrpc.c:fastrpc_cb_init() {
	new_ext =3D krealloc(cctx->ext_cb,
			   (cctx->ext_cb_count + 1) * sizeof(*cctx->ext_cb),
			   GFP_KERNEL);
	...
	spin_lock_irqsave(&cctx->lock, flags);
	cctx->ext_cb =3D new_ext;
	...
}

If the memory is moved by krealloc(), it frees the old block.

Can this lockless traversal of ext_cb race with krealloc() during device
probe and cause a use-after-free?

> +			if (err !=3D -ENOMEM)
> +				break;
> +		}
> +		return err;
> +	}
> +
> +	return fastrpc_map_attach_to_dev(fl, fd, len, attr, flags, fl->sctx, pp=
map);
> +}
> +
>  static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
> -			      u64 len, u32 attr, struct fastrpc_map **ppmap)
> +			      u64 len, u32 attr, u32 flags, struct fastrpc_map **ppmap)
>  {
> -	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
> -		return 0;
> +	if (!fastrpc_map_lookup(fl, fd, ppmap, true)) {
> +		if ((*ppmap)->flags =3D=3D flags)
> +			return 0;
> +		fastrpc_map_put(*ppmap);
> +		*ppmap =3D NULL;
> +	}

[Severity: High]
If a map with mismatched flags is found, its reference is dropped but it is
not removed from the list.

Since fastrpc_map_lookup() iterates from the head and always returns the
first matching fd:

drivers/misc/fastrpc.c:fastrpc_map_lookup() {
	list_for_each_entry(map, &fl->maps, node) {
		if (map->fd !=3D fd || map->buf !=3D buf)
			continue;
		...
		*ppmap =3D map;
		ret =3D 0;
		break;
	}
}

Any subsequent mapping request for the same fd with different flags will
repeatedly hit this old map, drop the newly acquired reference, and fall
through to fastrpc_map_attach() where it appends a new map to the list.

Could an unprivileged user exhaust kernel memory, DMA attachments, and SMMU
IOVA space by alternating flags in repeated FASTRPC_IOCTL_MEM_MAP calls?

> =20
> -	return fastrpc_map_attach(fl, fd, len, attr, ppmap);
> +	return fastrpc_map_attach(fl, fd, len, attr, flags, ppmap);
>  }
> =20
>  /*
> @@ -1063,10 +1108,10 @@ static int fastrpc_create_maps(struct fastrpc_inv=
oke_ctx *ctx)
> =20
>  		if (i < ctx->nbufs)
>  			err =3D fastrpc_map_create(ctx->fl, ctx->args[i].fd,
> -				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
> +				 ctx->args[i].length, ctx->args[i].attr, 0, &ctx->maps[i]);

[Severity: Medium]
When processing argument buffers during a DSP invocation, fastrpc_map_creat=
e()
is called with a hardcoded flags parameter of 0.

If the user previously mapped a buffer to the extended CB, fastrpc_map_crea=
te()
will find it but reject it because the cached flags do not match 0.

The invocation path will then discard the extended map and create a fresh
standard map attached to the regular SMMU CB, completely bypassing the wider
IOVA window the user requested.

Does hardcoding flags to 0 here cause valid extended-CB maps previously
requested by the user to be defeated during DSP invocation?

>  		else
>  			err =3D fastrpc_map_attach(ctx->fl, ctx->args[i].fd,
> -				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
> +				 ctx->args[i].length, ctx->args[i].attr, 0, &ctx->maps[i]);
>  		if (err) {
>  			dev_err(dev, "Error Creating map %d\n", err);
>  			return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-extended-m=
apping-v2-0-5dca3aa2c2d3@oss.qualcomm.com?part=3D4
