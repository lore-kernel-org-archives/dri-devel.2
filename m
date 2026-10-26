Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87DF606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dka5t6rA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD2010F182;
	Mon, 26 Oct 2026 21:55:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319C410E09A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 21:55:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E617541851;
 Mon, 26 Oct 2026 21:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2181F01825;
 Mon, 26 Oct 2026 21:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793051738;
 bh=iXrFDuymdw1zV01J+vuUHl21rR0cL7RI5yOcpJEwSyc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=dka5t6rA7b6z4d1C0ZpysvT5AaDg1M0sR/65A7itujDJvgWDA3vecEs/pZdPAgV2a
 TxPBIlJ/W5KUyeL0o0VATPj2ruBKvG1ZJVgDjqGuIRwdSGQP1kssq5SyVK0hzExuzl
 STCoaYHwWr9XoEZKTlyqo/hTRw00jWrpMETHQxR4zu6DAi3hFhdWtoRTSFu+Bm8NFV
 RaK2IdASQsipTR41aE26IKxD+ke9Wq+kQHvZn/Jao3/B2p9KQk1W3nt6Felo+vDB3p
 DFMy+gLVxgBy6bvX3lnkbdo8QwK6de+/o7Br6Lnno4ZkVhr0P291c1Lo1Msl8EOtkX
 LZzqmLc9ukPFw==
Message-ID: <sashiko-outbox-185769@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: validate backup buffer size in command
 buffer processing
To: "Zack Rusin" <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261026213712.244907-1-zack.rusin@broadcom.com>
References: <20261026213712.244907-1-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:55:38 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/vmwgfx: uninitialized guest_memory_size read in vmw_cmd_res_sw=
itch_backup()
--

commit 541f6121a2573592c8475e994e0c33c0a080bc71
Author: Zack Rusin <zack.rusin@broadcom.com>

drm/vmwgfx: validate backup buffer size in command buffer processing

This commit adds a bounds check in vmw_cmd_res_switch_backup() to ensure
that backup_offset plus res->guest_memory_size does not overflow or exceed
the backing MOB size before switching a resource's backup buffer.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_execbuf.c
> index a9136a6523cba..0156aee84c9fb 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -1718,6 +1718,7 @@ static int vmw_cmd_res_switch_backup(struct vmw_pri=
vate *dev_priv,
>  {
>  	struct vmw_bo *vbo;
>  	void *info;
> +	u64 end;
>  	int ret;
> =20
>  	info =3D vmw_execbuf_info_from_res(sw_context, res);
> @@ -1728,6 +1729,13 @@ static int vmw_cmd_res_switch_backup(struct vmw_pr=
ivate *dev_priv,
>  	if (ret)
>  		return ret;
> =20
> +	if (check_add_overflow((u64)backup_offset,
> +			       (u64)res->guest_memory_size, &end) ||
> +	    end > vbo->tbo.base.size) {
> +		VMW_DEBUG_USER("Backup buffer too small for resource.\n");
> +		return -EINVAL;
> +	}

[Severity: High]
Can this check read uninitialized slab memory from res->guest_memory_size
when binding DX shaders or DX streamoutput resources?

In drivers/gpu/drm/vmwgfx/vmwgfx_resource.c, vmw_resource_init() initializes
struct vmw_resource fields individually without setting
res->guest_memory_size:

drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:vmw_resource_init() {
	...
	res->id =3D -1;
	res->guest_memory_bo =3D NULL;
	res->guest_memory_offset =3D 0;
	res->guest_memory_dirty =3D false;
	res->res_dirty =3D false;
	res->coherent =3D false;
	res->used_prio =3D 3;
	res->dirty =3D NULL;
	...
}

For DX shaders (submitted via SVGA_3D_CMD_DX_DEFINE_SHADER and bound via
SVGA_3D_CMD_DX_BIND_SHADER), vmw_cmd_dx_define_shader() calls
vmw_dx_shader_add() in drivers/gpu/drm/vmwgfx/vmwgfx_shader.c, which
allocates struct vmw_dx_shader with kmalloc_obj() (without __GFP_ZERO) and
calls vmw_resource_init() without ever initializing
shader->res.guest_memory_size:

drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:vmw_dx_shader_add() {
	...
	shader =3D kmalloc_obj(*shader);
	if (!shader) {
		return -ENOMEM;
	}

	res =3D &shader->res;
	...
	ret =3D vmw_resource_init(dev_priv, res, true,
				vmw_dx_shader_res_free, &vmw_dx_shader_func);
	...
}

Similarly, for DX streamoutput resources (submitted via
SVGA_3D_CMD_DX_DEFINE_STREAMOUTPUT and bound via
SVGA_3D_CMD_DX_BIND_STREAMOUTPUT), vmw_dx_streamoutput_add() in
drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c allocates struct
vmw_dx_streamoutput with kmalloc_obj() without zeroing. When
vmw_cmd_dx_bind_streamoutput() in drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
processes the bind command, it calls vmw_dx_streamoutput_set_size(), which
stores cmd->body.sizeInBytes in so->size rather than
res->guest_memory_size before calling vmw_cmd_res_switch_backup():

drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c:vmw_dx_streamoutput_set_size()=
 {
	struct vmw_dx_streamoutput *so =3D vmw_res_to_dx_streamoutput(res);

	so->size =3D size;
}

When vmw_cmd_dx_bind_shader() or vmw_cmd_dx_bind_streamoutput() then calls
vmw_cmd_res_switch_backup(), res->guest_memory_size holds uninitialized heap
memory. Doesn't this cause valid DX shader and streamoutput bindings to fail
with -EINVAL whenever the uninitialized value is large, allow userspace to
probe the 64-bit uninitialized slab value by varying offsetInBytes or the
MOB size, and leave the actual shader and streamoutput byte sizes
unvalidated against the MOB size?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026213712.2449=
07-1-zack.rusin@broadcom.com?part=3D1
