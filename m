Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65222CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 02:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7877510E736;
	Sat,  3 Oct 2026 02:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XWENdP1h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A13A10E6DF
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 02:49:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B8E860AAF;
 Sat,  3 Oct 2026 02:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194181F000FF;
 Sat,  3 Oct 2026 02:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790995784;
 bh=ctxhcuW0/82ZJCH39HXVmzqd/0TJkLwVwqtP1+UIBDE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XWENdP1hXn4QFpSWoLz3pjHtjf7cuCXGv8fiOAU7CCaGEVpznjVz3FexJzBh1SJPL
 MsCkTdA2aLAA/m04Iqqkm7lHOGWzHHAK4dxjacZ1Di+N8vPZPdV6G8VD83p4E5ZGNN
 QpTru7+A980spdEx/PUyw7kCw+HZckm6loRZmYNxfoNv8T0zlbWFxxRz3PJek7CL0E
 d1O+IV0I1VwHc28+98X8k6l16F4MJPBBouYkaCsOXV+HchtJn1vphgWrzJ4y4X87y5
 QThcazTz5CfU5w+XVg6ar/+pWatsi5DXOPam5uB4C9/dnYSN4c0R62uYAtVO4sbO57
 C2YQwgN0aAcfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] accel/qaic: Centralize execution info
To: "Carl Vanderlip" <carl.vanderlip@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003023818.1161666-2-carl.vanderlip@oss.qualcomm.com>
References: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
 <20261003023818.1161666-2-carl.vanderlip@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 02:49:43 +0000
Message-Id: <20261003024944.194181F000FF@smtp.kernel.org>
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
- [Medium] mm: unaligned memory access in exec.resize_arr array allocation
- [Medium] drm/qaic: failure to deduplicate resv pointers causes -EALREADY
--

commit 564e37a5c5a191292a9c140ea89ad4c33346feeb
Author: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
accel/qaic: Centralize execution info

This commit moves per-exec ioctl information into a common data structure
to prepare for adding dma-resv fences, which require all buffer objects
associated with a fence to be locked using drm_gem_lock_reservations.

[Severity: Medium]
In drivers/accel/qaic/qaic_data.c, the function __qaic_execute_bo_ioctl
calculates the offset for exec.resize_arr around line 1502. The driver
allocates a single buffer for three arrays: bo_arr at 8 bytes per element,
handle_arr at 4 bytes per element, and resize_arr at 8 bytes per element.
The offset for resize_arr is calculated as (8 + 4) * count.

If count is an odd number, for example 1, the byte offset becomes an odd
multiple of 12, resulting in a 4-byte aligned pointer. When this is later
written to in lookup_exec_data around line 1426, it performs an unaligned
64-bit memory access.=20

Can this lead to alignment faults on platforms with strict alignment
enforcement, or trigger undefined C behavior? Would reordering the array
layout or padding the calculation prevent this regression?

[Severity: Medium]
Also in drivers/accel/qaic/qaic_data.c, the function send_bo_list_to_device
calls drm_gem_lock_reservations directly on the raw, non-deduplicated
exec->bo_arr array around line 1280.

What happens if userspace submits distinct imported buffer objects that
share the same dma_resv pointer, such as from identical or shared dma-bufs?
It appears this attempts to lock the same reservation multiple times within
the same ww_acquire_ctx, causing the underlying ww_mutex to return -EALREADY
and fail the ioctl.

Since the driver previously used a per-BO mutex for locking that allowed
executing distinct BOs with shared reservations, does this code need to
deduplicate the reservation pointers before passing them to the locking
helper to avoid this regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003023818.1161=
666-1-carl.vanderlip@oss.qualcomm.com?part=3D1
