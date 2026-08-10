Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A25C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2CA410E1F9;
	Mon, 10 Aug 2026 13:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eBHPNGPN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A269E10E1F9
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:22:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A4D5360052;
 Mon, 10 Aug 2026 13:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C16D1F000E9;
 Mon, 10 Aug 2026 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786368122;
 bh=UZsH3LVbKNCPB+c+qhYVDFZ+SNwzoeHb0Bkj6iEH2eo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eBHPNGPNTHailW20RvooOGtapH3hfdJzA+rCKcZXazeJA5tqV+tir7YVwoIp7z6uw
 s5lfcST0jaMuuGu1NfHjLfVQ5qmJPVdubRnbRQwZkVIjlzGvvpV7LuHPE5LZ5+Pbpk
 RkvJxoz4sPZ5oY8umg4xfWYo/QbQEowQZ8EdBw2RPQgpybjCgIU7yvUpbMKc078EpX
 vv4np6srnKEusp11gKh9K61+7Ff+HFHHOjgeCPkItJl8PCdslj+07tKlvcobeWBKoZ
 Yms2UsSGXlNnm7GGSEswqJ5h7wzeU1i/65Xub661qPS3I3GNs5bkPkW1EJcnao4L/u
 s+B3DM9dHtNRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: Remove duplicated CCB control
 initialisation
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810-b4-upstream-remove-duplicate-ccb-control-init-v1-1-4ea79b116b40@imgtec.com>
References: <20260810-b4-upstream-remove-duplicate-ccb-control-init-v1-1-4ea79b116b40@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 13:22:01 +0000
Message-Id: <20260810132202.3C16D1F000E9@smtp.kernel.org>
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
- [High] Pre-existing NULL pointer dereference in `pvr_fw_object_destroy()`=
 when handling allocation failures.
- [High] Unprotected accesses to `free_list->current_pages` and `free_list-=
>ready_pages` in `pvr_free_list_process_grow_req`.
- [High] Firmware commands in the FWCCB can be processed out of order due t=
o lock dropping in `pvr_fwccb_process`.
--

--- Patch [1]: [PATCH] drm/imagination: Remove duplicated CCB control initi=
alisation ---
commit f2cf0d89b43f414e7db3141318ab274dbe8aa132
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Remove duplicated CCB control initialisation

The same is already done by the ccb_ctrl_init() callback.

> diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imag=
ination/pvr_ccb.c
> index 4accf18e23418..48672a86ca2f5 100644
> --- a/drivers/gpu/drm/imagination/pvr_ccb.c
> +++ b/drivers/gpu/drm/imagination/pvr_ccb.c
> @@ -82,11 +82,6 @@ pvr_ccb_init(struct pvr_device *pvr_dev, struct pvr_cc=
b *pvr_ccb,
>  	pvr_fw_object_get_fw_addr(pvr_ccb->ctrl_obj, &pvr_ccb->ctrl_fw_addr);
>  	pvr_fw_object_get_fw_addr(pvr_ccb->ccb_obj, &pvr_ccb->ccb_fw_addr);
> =20
> -	WRITE_ONCE(pvr_ccb->ctrl->write_offset, 0);
> -	WRITE_ONCE(pvr_ccb->ctrl->read_offset, 0);
> -	WRITE_ONCE(pvr_ccb->ctrl->wrap_mask, num_cmds - 1);
> -	WRITE_ONCE(pvr_ccb->ctrl->cmd_size, cmd_size);
> -
>  	return 0;
> =20
>  err_free_ctrl:

This isn't a bug introduced by this patch, but I noticed a potential NULL
pointer dereference in pvr_fw_object_destroy() when handling allocation
failures.

If pvr_gem_object_create() fails in pvr_fw_object_create_and_map_common(),
fw_obj->gem is explicitly set to NULL before jumping to the error cleanup
path:

drivers/gpu/drm/imagination/pvr_fw.c:pvr_fw_object_create_and_map_common() {
	...
	fw_obj->gem =3D pvr_gem_object_create(pvr_dev, size, flags);
	if (IS_ERR(fw_obj->gem)) {
		err =3D PTR_ERR(fw_obj->gem);
		fw_obj->gem =3D NULL;
		goto err_put_object;
	}
	...
err_put_object:
	pvr_fw_object_destroy(fw_obj);

	return ERR_PTR(err);
}

The cleanup path then calls pvr_fw_object_destroy():

drivers/gpu/drm/imagination/pvr_fw.c:pvr_fw_object_destroy() {
	struct pvr_gem_object *pvr_obj =3D fw_obj->gem;
	struct drm_gem_object *gem_obj =3D gem_from_pvr_gem(pvr_obj);
	struct pvr_device *pvr_dev =3D to_pvr_device(gem_obj->dev);

[Severity: High]
Will this unconditionally dereference the NULL gem_obj (derived from the NU=
LL
fw_obj->gem) to get the device, causing a kernel panic?


This is a pre-existing issue, but there appears to be an unprotected access
to the free list page accounting variables in
pvr_free_list_process_grow_req().

drivers/gpu/drm/imagination/pvr_free_list.c:pvr_free_list_process_grow_req(=
) {
	...
	/* Since the FW made the request, it has already consumed the ready pages,
	 * update the host struct.
	 */
	free_list->current_pages +=3D free_list->ready_pages;
	free_list->ready_pages =3D 0;

	/* If the grow succeeds, update the grow_pages argument. */
	if (!pvr_free_list_grow(free_list, free_list->grow_pages))
		grow_pages =3D free_list->grow_pages;

	/* Now prepare the response and send it back to the FW. */
	pvr_fw_object_get_fw_addr(free_list->fw_obj, &resp->freelist_fw_addr);
	resp->delta_pages =3D grow_pages;
	resp->new_pages =3D free_list->current_pages + free_list->ready_pages;
	...
}

[Severity: High]
Since pvr_fwccb_process() can run concurrently (from the IRQ handler and
userspace-triggered free list release), can these unprotected modifications
and reads of free_list->current_pages and free_list->ready_pages lead to
data corruption in the free list page accounting?


This isn't a bug introduced by this patch, but I noticed that firmware comm=
ands
in the FWCCB might be processed out of order because the lock is dropped in
pvr_fwccb_process().

drivers/gpu/drm/imagination/pvr_ccb.c:pvr_fwccb_process() {
	...
	while ((read_offset =3D READ_ONCE(ctrl->read_offset)) !=3D READ_ONCE(ctrl-=
>write_offset)) {
		struct rogue_fwif_fwccb_cmd cmd =3D fwccb[read_offset];

		WRITE_ONCE(ctrl->read_offset, (read_offset + 1) & READ_ONCE(ctrl->wrap_ma=
sk));

		/* Drop FWCCB lock while we process command. */
		mutex_unlock(&pvr_dev->fwccb.lock);

		process_fwccb_command(pvr_dev, &cmd);

		mutex_lock(&pvr_dev->fwccb.lock);
	}
	...
}

[Severity: High]
Since this function can be called both from the IRQ thread and from the
userspace-triggered pvr_free_list_release() path, if one thread dequeues a
command and drops the lock, could a second thread acquire the lock, dequeue
the next command, and process it concurrently, leading to out-of-order
execution of firmware events?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-b4-upstrea=
m-remove-duplicate-ccb-control-init-v1-1-4ea79b116b40@imgtec.com?part=3D1
