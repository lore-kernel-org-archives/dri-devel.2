Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EF4CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0DF10F1A9;
	Thu, 25 Jun 2026 08:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kPFygwjk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BF210F1A7
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:26:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7C9143A99;
 Thu, 25 Jun 2026 08:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A251F000E9;
 Thu, 25 Jun 2026 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782375978;
 bh=ei75v/vDLBZ28WkMycO+AKLf74ZitRua7zsygYXs+II=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kPFygwjkJUwoQRg2aaPUOz0kUMFKR/uiupVxJh63Vk4BqkTsOXWS38SSi9gskneO9
 NY3ReBcisp/grMtmNLnBnoCYXu6VafXgZ1OlhPKUG03kV9lhNBAo9EH/DXTjr/mnl9
 vrZv1GripO4OjJZyGwcw6+k/9P9PlRCQNPAK4SzhfcZxd+pHrB0V/Typq60DRWFJ+r
 gVoRa7ehCAipHISvv3Zmy8zvbh1tsuH+jfa0joAb9xtn7eO4e0gR1zZh2zcvLhV+7l
 iS0l7+vJ3rnsbiQx5crWpyMhBAMwCY4KJTCMhDYMrgKRTjLaq3gG55XSN6nJUpQLWf
 ndKCv3TbDETng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625080832.17477-1-jianping.li@oss.qualcomm.com>
References: <20260625080832.17477-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:26:18 +0000
Message-Id: <20260625082618.70A251F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Use-After-Free and Double Free due to bypassing reference coun=
ting for handles.

Pre-existing issues:
- [High] Memory leak of newly created DMA maps for handle arguments.
- [High] Race condition in `fdlist` cleanup leading to Kernel Use-After-Fre=
e.
- [High] Circular reference causing permanent resource leak on interrupted =
invocations.
--

Note: The format of this review is altered to provide a free-form summary
rather than inline quotes to comply with system recitation restrictions.

commit ad847e952f22a54c8e1f599b332d32abb92a3e6a
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: avoid duplicate DMA mappings in fastrpc_create_maps()

This patch modifies fastrpc_create_maps() to bypass reference counting when
looking up existing DMA mappings for handle arguments. It achieves this by
introducing a boolean take_ref flag to fastrpc_map_create() to prevent
duplicate DMA mappings and unbalanced reference counts.

[Severity: Critical]
Does bypassing the reference count for handle arguments introduce a
use-after-free and double-free risk?

In drivers/misc/fastrpc.c:fastrpc_create_maps(), this patch forces
take_ref =3D false for arguments where i >=3D ctx->nbufs. This populates
ctx->maps[i] with a weak reference.

If a concurrent thread calls FASTRPC_IOCTL_MEM_UNMAP and drops the map's
reference, could fastrpc_get_args() dereference a freed pointer when it
accesses ctx->maps[i]->dma_addr?

Additionally, if the DSP returns the handle in fdlist, fastrpc_put_args()
will unconditionally call fastrpc_map_put(). Since a reference was never
taken during creation, does this consume an unbalanced reference and free
explicit memory maps prematurely?

[Severity: High]
This isn't a bug introduced by this patch, but does the error path leak
newly created DMA maps for handle arguments?

When fastrpc_map_create() does not find an existing mapping, it calls
fastrpc_map_attach(), which allocates a new map with a reference count of 1.

However, looking at drivers/misc/fastrpc.c:fastrpc_context_free(), the
cleanup loop only iterates up to ctx->nbufs. Since handle arguments
(i >=3D ctx->nbufs) are deliberately skipped during this cleanup, are the
maps created for them permanently leaked, potentially leading to memory
exhaustion if a user repeatedly passes new memfds?

[Severity: High]
This is a pre-existing issue, but is there a race condition in the fdlist
cleanup that could lead to a use-after-free?

In drivers/misc/fastrpc.c:fastrpc_put_args(), the code looks up the map
without taking a reference (take_ref =3D false), and then immediately calls
fastrpc_map_put() to drop a reference.

If a compromised or buggy DSP returns the same file descriptor in the
fdlist for two concurrent invocations, could both threads simultaneously
execute the lookup and drop a reference without adequate locking, causing
the second thread to drop a reference on an already freed map?

[Severity: High]
This isn't a bug introduced by this patch, but does the invocation error
handling create a circular reference that permanently leaks resources?

In drivers/misc/fastrpc.c:fastrpc_internal_invoke(), if the invocation is
interrupted (returning -ERESTARTSYS or -ETIMEDOUT), the code explicitly
skips calling fastrpc_context_put().

Because fastrpc_context_alloc() takes a strong reference to the user
structure (fastrpc_user_get()), and the leaked context holds this
reference, the user reference count never reaches zero. Does this prevent
fastrpc_user_free() from ever executing to clean up pending contexts,
allowing a local user to easily exhaust resources by interrupting
invocations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625080832.1747=
7-1-jianping.li@oss.qualcomm.com?part=3D1
