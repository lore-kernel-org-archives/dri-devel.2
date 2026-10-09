Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E62CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24E6112068;
	Fri,  9 Oct 2026 11:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RG+mBBEK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3378112068
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:20:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 61BBE4033A;
 Fri,  9 Oct 2026 11:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1111F000FF;
 Fri,  9 Oct 2026 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791544816;
 bh=0o1kK6fZkQXjnkYxsuaH1QSfO7UyFiC+mO/coJPFJLc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RG+mBBEKabQUgfgmbPasX/MSSkpLHhuY6DS6ZI+rY2e7HUhhytKXOXAJdq7oBtmtY
 FfDmJhyBylKgRGP0puMj+jNvDYdizfF7HbmTWNebVr4i1m+nf9OPuTSy1kJesVipEo
 biqNxDqgycmNbG0zrJ5+B2wJ9Xh9KP3Ll0HfamzTef/vohfUQvzKvx1OP5Gr7jH47f
 2Z3L4JZUrbo1c8pz1OKACGSH0ELIhSXPJVoR3tZNkkLuWRTvpLi31NVciL6BFEzzcv
 utqnSLSVJ16fvEe1hVsawL0nRG0RgkDc/ubyG/65i5IX7+uRKcGCiboDyi4p/I6XNp
 4xvpWaU6ybokg==
Message-ID: <sashiko-outbox-165352@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/imagination: Improve logging of unknown freelist
 IDs
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-b4-improve-logging-of-unknown-freelist-ids-v2-1-5e6c3f63370e@imgtec.com>
References: <20261009-b4-improve-logging-of-unknown-freelist-ids-v2-1-5e6c3f63370e@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:20:15 +0000
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
- [High] drm/imagination: missing lock around free_list page accounting
--

commit 26a8dc61d661134bbaa586ea04b036fc6a817608
Author: Alessio Belle <alessio.belle@imgtec.com>
drm/imagination: Improve logging of unknown freelist IDs

This commit improves logging when the driver receives freelist grow or
reconstruction requests from the firmware for unrecognised freelist IDs.
It replaces a WARN_ON() with a ratelimited warning.

Link: https://patch.msgid.link/20261006-b4-improve-logging-of-unknown-freel=
ist-ids-v1-1-96ebcb132b80@imgtec.com

> diff --git a/drivers/gpu/drm/imagination/pvr_free_list.c b/drivers/gpu/dr=
m/imagination/pvr_free_list.c
> index e85cac83834c6..ec02fbbe0168b 100644
> --- a/drivers/gpu/drm/imagination/pvr_free_list.c
> +++ b/drivers/gpu/drm/imagination/pvr_free_list.c
[ ... ]
> @@ -367,8 +368,12 @@ void pvr_free_list_process_grow_req(struct pvr_devic=
e *pvr_dev,
>  	u32 grow_pages =3D 0;
> =20
>  	/* If we don't have a freelist registered for this ID, we can't do much=
. */
> -	if (WARN_ON(!free_list))
> +	if (!free_list) {
> +		drm_warn_ratelimited(from_pvr_device(pvr_dev),
> +				     "Received freelist grow request for unknown ID 0x%x\n",
> +				     req->freelist_id);
>  		return;
> +	}
> =20
>  	/* Since the FW made the request, it has already consumed the ready pag=
es,
>  	 * update the host struct.

[Severity: High]
Are there missing locks around the free_list page accounting in
pvr_free_list_process_grow_req()?

Right below this change, free_list->current_pages and free_list->ready_page=
s are
modified without holding free_list->lock:

	free_list->current_pages +=3D free_list->ready_pages;
	free_list->ready_pages =3D 0;

The FWCCB processing loop (pvr_fwccb_process) drops pvr_dev->fwccb.lock bef=
ore
calling process_fwccb_command().

Since pvr_fwccb_process() is called by both the IRQ thread
(pvr_device_irq_thread_handler) and the release path (pvr_free_list_release=
),
could multiple threads concurrently pull commands from the global FWCCB que=
ue?

If pvr_free_list_release() runs concurrently with the IRQ thread, it appears
they could execute pvr_free_list_process_grow_req() or
pvr_free_list_reconstruct() for the same freelist concurrently.

Could this result in a data race and corrupted page tracking, causing the
firmware to access unmapped or unallocated memory (GPU MMU fault)?

Additionally, after pvr_free_list_grow() returns, the fields are read again
without holding the lock:

	resp->new_pages =3D free_list->current_pages + free_list->ready_pages;
	resp->ready_pages =3D free_list->ready_pages;

Could this create a time-of-check to time-of-use vulnerability where the va=
lues
are modified by another thread before being used to populate the response?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-improve=
-logging-of-unknown-freelist-ids-v2-1-5e6c3f63370e@imgtec.com?part=3D1
