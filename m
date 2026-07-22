Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E96CC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 04:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705CE10E29E;
	Wed, 22 Jul 2026 04:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yzzkp8Xl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7194F10E29E
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 04:30:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71481601EC;
 Wed, 22 Jul 2026 04:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085B81F000E9;
 Wed, 22 Jul 2026 04:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784694657;
 bh=d5APJGMME49rryZB/NZeG5y0yxD0+UDoExp+FKQrs9Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Yzzkp8XlN7Uec/qjYUmdFx+o9p5kVZt3eKDFGRJkcqSbSfLJllwtL26Xfo/kkkQuf
 6tVBRW4yyzFcVaXNePBaEfubdYr305P0QXuh6/i5gHLn4AjUdrz6D9BoGxSkeZQwmQ
 dB3hqffAOLXBxBzOu4U6hKERH7ZLuwFdFHUanOFO/KGbj/3hMN1PgNgcgCAhwhmISa
 zYiUmy+sohA9PoH9VHkQ4hGlX5UnWROVx+qc1Kp/5FFMN1rVAOVnHle15RZuwtA8+G
 tdjRa8ii4TwJb9WQdv1JLU2EnKwKnfEbYuV/UBmPWw+ummpUnIt1lyNm6G45NI++AA
 9FmwAzYT2vtQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/exynos: limit G2D GEM map count
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722040832.80135-1-pengpeng@iscas.ac.cn>
References: <20260722040832.80135-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 04:30:56 +0000
Message-Id: <20260722043057.085B81F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:

Pre-existing issues:
- [Critical] The driver processes commands backwards during validation, all=
owing bounds checking bypass via duplicate register commands.
- [Critical] g2d_wait_finish fails to clear g2d->runqueue_node after freein=
g it on timeout, leading to a double-free.
- [Critical] An integer overflow in last_pos calculation allows an attacker=
 to bypass buffer bounds checks and perform arbitrary out-of-bounds DMA.
- [Critical] The driver entirely skips bounds validation for REG_TYPE_SRC_P=
LANE2 and REG_TYPE_DST_PLANE2 buffers, allowing out-of-bounds DMA.
- [High] Off-by-one error in cmdlist size check allows an out-of-bounds wri=
te of a null terminator over struct g2d_cmdlist's last field.
- [High] On 64-bit architectures, struct g2d_cmdlist size exceeds its DMA p=
ool block size due to unsigned long scaling, causing memory corruption.
- [High] Submitting multiple GEM mapping commands for the same register typ=
e overwrites references in buf_info->obj, permanently leaking GEM objects.
- [High] Lockless access to file_priv->userptr_list causes Use-After-Free a=
nd list corruption.
- [High] Lockless modifications to file_priv->inuse_cmdlist lead to list co=
rruption across concurrent ioctls.
- [High] Global userptr pool limits are bypassed due to unconditional reset=
 on file close.
--

--- Patch [1]: [PATCH] drm/exynos: limit G2D GEM map count ---
commit b30e7ac73eaa32c37f3e06c772aa25cba4e9ce35
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm/exynos: limit G2D GEM map count

This patch limits the number of GEM mapping commands by MAX_REG_TYPE_NR
to prevent out-of-bounds access on fixed-size buf_info arrays. It also
defers taking a command-list node until after validation.

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_g2d.c
> index e92a4d872c410..2dfea16f32cb8 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -1151,21 +1151,17 @@ int exynos_g2d_set_cmdlist_ioctl(struct drm_devic=
e *drm_dev, void *data,
>  	int size;
>  	int ret;
> =20
> -	node =3D g2d_get_cmdlist(g2d);
> -	if (!node)
> -		return -ENOMEM;
> -
> -	/*
> -	 * To avoid an integer overflow for the later size computations, we
> -	 * enforce a maximum number of submitted commands here. This limit is
> -	 * sufficient for all conceivable usage cases of the G2D.
> -	 */
> +	/* GEM mapping commands also populate fixed-size buf_info arrays. */
>  	if (req->cmd_nr > G2D_CMDLIST_DATA_NUM ||
> -	    req->cmd_buf_nr > G2D_CMDLIST_DATA_NUM) {
> +	    req->cmd_buf_nr > MAX_REG_TYPE_NR) {
>  		dev_err(g2d->dev, "number of submitted G2D commands exceeds limit\n");
>  		return -EINVAL;
>  	}
> =20
> +	node =3D g2d_get_cmdlist(g2d);
> +	if (!node)
> +		return -ENOMEM;
> +
>  	node->event =3D NULL;
> =20
>  	if (req->event_type !=3D G2D_EVENT_NOT) {

[Severity: High]
This is a pre-existing issue, but further down in this same function
there is a size check that allows an off-by-one write:

	size =3D cmdlist->last + req->cmd_nr * 2 + req->cmd_buf_nr * 2 + 2;
	if (size > G2D_CMDLIST_DATA_NUM) {
		dev_err(g2d->dev, "cmdlist size is too big\n");
		...

If a user crafts the number of commands such that size perfectly equals
G2D_CMDLIST_DATA_NUM, the check passes. Then later in the function:

	cmdlist->data[cmdlist->last] =3D 0;

Could this overwrite the last field of struct g2d_cmdlist on 32-bit
architectures since data is bounded at G2D_CMDLIST_DATA_NUM elements?

[Severity: High]
This is a pre-existing issue, but does struct g2d_cmdlist exceed its
DMA pool block size on 64-bit architectures?

struct g2d_cmdlist {
	...
	unsigned long	data[G2D_CMDLIST_DATA_NUM];
};

On LP64 architectures, unsigned long is 8 bytes, making the data array alone
over 2032 bytes. However, nodes are distributed using a fixed 1024-byte blo=
ck
size:

	node[nr].cmdlist =3D g2d->cmdlist_pool_virt + nr * G2D_CMDLIST_SIZE;

Could this cause the data array of one node to overlap and corrupt the next
node in the pool?

[Severity: Critical]
This is a pre-existing issue, but does processing commands backwards during
validation allow bypassing bounds checks?

In g2d_check_reg_offset():

	for (i =3D 0; i < nr; i++) {
		...
		index =3D cmdlist->last - 2 * (i + 1);

If duplicate configuration commands are submitted for the same register,
the first occurrence in the stream determines the validation state, but the
hardware executes sequentially and uses the last occurrence. Can an attacker
supply a valid configuration to pass software validation, followed by an
invalid out-of-bounds configuration that the hardware will execute?

[Severity: High]
This is a pre-existing issue, but can multiple GEM mapping commands for the
same register type cause a memory leak?

In g2d_map_cmdlist_gem():

		buf_info->obj[reg_type] =3D exynos_gem;

If userspace submits multiple commands targeting the same register type,
this overwrites the slot without dropping the reference to the previously
stored object. In the cleanup function g2d_unmap_cmdlist_gem():

		if (buf_info->types[reg_type] =3D=3D BUF_TYPE_GEM)
			exynos_drm_gem_put(obj);

The cleanup clears the array entry on the first pass, so subsequent passes =
for
the same register type do nothing. Does this permanently leak the overwritt=
en
GEM objects?

[Severity: High]
This is a pre-existing issue, but are there lockless accesses to
file_priv->userptr_list causing use-after-free conditions?

In the ioctl path:

	list_for_each_entry(g2d_userptr, &file_priv->userptr_list, list) {

Concurrently, the workqueue executes hardware completion routines that call
g2d_userptr_put_dma_addr(), which modifies the list locklessly:

	list_del_init(&g2d_userptr->list);

If the worker frees a node while the ioctl thread is iterating over the lis=
t,
can this corrupt the list and cause a crash?

[Severity: High]
This is a pre-existing issue, but are there lockless modifications to
file_priv->inuse_cmdlist causing list corruption?

In g2d_add_cmdlist_to_inuse():

	list_add_tail(&node->list, &file_priv->inuse_cmdlist);

And in exynos_g2d_exec_ioctl():

	list_splice_init(&file_priv->inuse_cmdlist, run_cmdlist);

Neither of these operations appears to be protected by a lock. Can concurre=
nt
execution of these ioctls race and cause list corruption?

[Severity: High]
This is a pre-existing issue, but does unconditional zeroing of the global
counter bypass device-wide userptr accounting?

In g2d_userptr_free_all(), when a DRM file descriptor is closed:

	g2d->current_pool =3D 0;

This executes after freeing only that client's userptrs. If other clients
still have pinned memory, doesn't this allow an attacker to repeatedly open,
map, and close file descriptors to completely bypass the max_pool limit?

[Severity: Critical]
This is a pre-existing issue, but does g2d_wait_finish() fail to clear
the dangling pointer after a timeout?

	if (runqueue_node->async)
		g2d_free_runqueue_node(g2d, runqueue_node);

The node is freed, but g2d->runqueue_node is not set to NULL. When the
g2d_runqueue_worker executes shortly after, will it read this stale pointer
and double-free the node?

[Severity: Critical]
This is a pre-existing issue, but does an integer overflow in the last_pos
calculation allow out-of-bounds DMA?

In g2d_check_buf_desc_is_valid():

	last_pos =3D ((unsigned long)buf_desc->bottom_y - 1) *
		(unsigned long)buf_desc->stride +
		(unsigned long)buf_desc->right_x * bpp - 1;

Since unsigned long is 32-bit on ARM32, providing a massive stride can
wrap the multiplication to a very small number, bypassing the last_pos >=3D=
 size
check. Can this cause the hardware to access memory outside the pinned buff=
er?

[Severity: Critical]
This is a pre-existing issue, but is bounds validation completely skipped
for Plane 2 registers?

In g2d_check_buf_desc_is_valid():

	if (reg_type !=3D REG_TYPE_SRC && reg_type !=3D REG_TYPE_DST)
		return true;

This early return bypasses all checks for REG_TYPE_SRC_PLANE2 and
REG_TYPE_DST_PLANE2. Can an attacker submit massive width and height
configurations against a small 1-page buffer for PLANE2 to read or write
out-of-bounds memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722040832.8013=
5-1-pengpeng@iscas.ac.cn?part=3D1
