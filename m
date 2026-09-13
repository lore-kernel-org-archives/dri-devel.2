Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EB2C88E64
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2979F10EA51;
	Sun, 13 Sep 2026 22:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jDYhVxoo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C6510EA52
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:45:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 709B5407B9;
 Sun, 13 Sep 2026 22:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A371F000FF;
 Sun, 13 Sep 2026 22:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789339516;
 bh=CYwEJGqfwAioZ93Xl1zgDR0pG2xtGE7362pYqh++soY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jDYhVxookF2ZgJ+aqHBsmhHpFU5LLW6bbsfMs0CaOe/9ZzJK9XVlP2ex+fqz7UPCY
 VzTpg1ZhOzwwhPeZYRcAtRRtAxOpdDIUi/yubGcFMIgu27QKvDmOysjCIP5DccIwXg
 EKPtX1EmmB+JlUP4NQcdnAYbRFw7rbH8mNCSicM8pV+ZUrtJC2MiKQV5DPz9GODDfc
 Br+ItinrUNW9T6J8Q3dNyB5nwBNZPlotPRhzx6Pr3UxGimRFL45dQhhzM29QHP5Gdu
 DvR4LnmcNmzwVl1vn5HmdTGZCvYJQLO1o9S3J2aWUUpwGUw5HhR1d4x3RALvAmjF8W
 KJAYvkET5I1Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/qxl: reject command sizes that exceed the
 release slot
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913223000.695299-3-qwe.aldo@gmail.com>
References: <20260913223000.695299-1-qwe.aldo@gmail.com>
 <20260913223000.695299-3-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:45:15 +0000
Message-Id: <20260913224516.33A371F000FF@smtp.kernel.org>
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
- [High] Incorrect pointer arithmetic when setting `mm_time` in `qxl_proces=
s_single_command` corrupts the first release slot in the BO page instead of=
 the currently allocated one.
- [High] An integer overflow in the bounds check for `reloc.dst_offset` all=
ows bypass of the command buffer boundary checks, leading to out-of-bounds =
writes into other release slots.
- [Medium] Userspace can spuriously receive `-EFAULT` if the command payloa=
d is paged out, because the driver lacks a page-fault fallback.
--

commit 32830020edc55718de9f74f8287e937fa568d5e5
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

drm/qxl: reject command sizes that exceed the release slot

This commit adds a check in qxl_alloc_release_reserved() to reject
allocations where the requested size exceeds the slot size for the given
release type. This prevents a heap buffer overflow that could occur when
command payloads are copied from userspace.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_=
release.c
> index 06979d0e8a9f0..049ad167fe128 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -312,6 +312,9 @@ int qxl_alloc_release_reserved(struct qxl_device *qde=
v, unsigned long size,
>  		return -EINVAL;
>  	}
> =20
> +	if (size > release_size_per_bo[cur_idx])
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but while this size check prevents one form of
buffer overflow, there appear to be other out-of-bounds writes in
qxl_process_single_command() in drivers/gpu/drm/qxl/qxl_ioctl.c.

For example, when setting mm_time, the code seems to ignore the in-page off=
set:

drivers/gpu/drm/qxl/qxl_ioctl.c:qxl_process_single_command() {
    ...
    struct qxl_drawable *draw =3D fb_cmd;

    draw->mm_time =3D qdev->rom->mm_clock;
    ...
}

Because fb_cmd points to the base of the mapped page, doesn't this write to
the mm_time field of the first drawable (slot 0) in the mapped page instead=
 of
the currently allocated one at (release->release_offset & ~PAGE_MASK)?

This could corrupt previously submitted commands in the ring and leave the
active slot's mm_time uninitialized or controlled by userspace. Note that
subsequent patches in this series do not appear to fix this issue.

[Severity: High]
This is also a pre-existing issue, but there seems to be an integer overflow
in the command buffer boundary checks in the same function:

drivers/gpu/drm/qxl/qxl_ioctl.c:qxl_process_single_command() {
    ...
    if (reloc.dst_offset < sizeof(union qxl_release_info) ||
        reloc.dst_offset + write_size >
        sizeof(union qxl_release_info) + cmd->command_size) {
    ...
    reloc_info[i].dst_offset =3D reloc.dst_offset + release->release_offset;
    ...
}

Since reloc.dst_offset + write_size uses an unprotected 64-bit addition, co=
uld
a maliciously crafted large reloc.dst_offset (e.g., near U64_MAX) wrap arou=
nd
and bypass this bounds check?

If it bypasses the check, the large offset is added to release->release_off=
set
and implicitly truncated to 32 bits, which could yield an offset pointing
before the current command slot. Would this allow arbitrary out-of-bounds
writes to previous release slots in the cmd_bo ring buffer?

Note that follow-up patches in this series do not seem to fix this issue.
Patch 3 only adds a page-boundary check which does not prevent writing to
adjacent slots within the same page, and Patch 4 only validates src_offset.

[Severity: Medium]
This is another pre-existing issue, but how are page faults handled when
copying the command payload?

drivers/gpu/drm/qxl/qxl_ioctl.c:qxl_process_single_command() {
    ...
    fb_cmd =3D qxl_bo_kmap_atomic_page(qdev, cmd_bo, (release->release_offs=
et & PAGE_MASK));
    unwritten =3D copy_from_user_inatomic_nontemporal(...);
    ...
    if (unwritten) {
        ret =3D -EFAULT;
    }
    ...
}

Since qxl_bo_kmap_atomic_page() creates an atomic mapping which disables
page faults, if the user buffer is paged out,
copy_from_user_inatomic_nontemporal() will fail.

Instead of falling back to a slow path to fault the pages in, this returns
-EFAULT directly. Will this cause valid ioctl calls to randomly fail under
normal memory pressure when a user page is swapped out?

>  	idr_ret =3D qxl_release_alloc(qdev, type, release);
>  	if (idr_ret < 0) {
>  		if (rbo)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913223000.6952=
99-1-qwe.aldo@gmail.com?part=3D2
