Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E826C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CF4E10EDBA;
	Wed, 22 Jul 2026 14:02:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mNwSoILY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04A710EDCD
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:02:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A09943F56;
 Wed, 22 Jul 2026 14:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540571F000E9;
 Wed, 22 Jul 2026 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784728938;
 bh=8NGjpLcWAKZyCLZHY2QHKwbZDh3N9qUG8faciH2gG0U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mNwSoILYhjm0Vfsea5TsXZdVxlkvQvkYg/qH4uQ4LhfptBn6Hicjeq/Pm6trp+LOh
 cjiY/s5UoVfBGGnZjXbPyMtaeaIiK+epkG2yzoXXIxBIW6/PEDhB67ddVIEmt42kmp
 Kcz7KfMUHyQqN2zi3DcvKomXS7KqgrCd5iT7jCi1hOcIFwFYTIvqcQn6kSW7h9ge48
 MdbB8pDeKzCkXmZUF50OEwfWkp3lnoQoOCjz7qSfqX/5SpEl1/Kil+W2y/r4vdY8jW
 N4g9BgOD+1ZpK4tAG1Tn4xkQfeNZeN+50u3PALQpdtYzFtVRhl9yIyqLoCFnnW8VMz
 wBIjalWU0UNiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/4] drm/xe/mcr: Keep GT forcewake during MCR steering
To: =?utf-8?b?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722004654.744249-2-talesam@gmail.com>
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-2-talesam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:02:17 +0000
Message-Id: <20260722140218.540571F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unprotected concurrent access to GuC capture `cachelist` and `outl=
ist`.
--

--- Patch [1]: [PATCH v1 1/4] drm/xe/mcr: Keep GT forcewake during MCR stee=
ring ---
commit 3d26258fb8d98aa82b5daf58a00b99ab1ef9b4be
Author: Tales A. Mendon=C3=A7a <talesam@gmail.com>

drm/xe/mcr: Keep GT forcewake during MCR steering

This commit ports the i915 MCR locking model to the xe driver. It changes
the locking sequence to wait for the hardware semaphore before taking the
software spinlock, allowing it to sleep rather than spin. It also ensures
GT forcewake is held over the entire lock, steer, and unlock cycle.

> diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_mc=
r.c
> index a97b236dab7c9..e1e3c0688dc2e 100644
> --- a/drivers/gpu/drm/xe/xe_gt_mcr.c
> +++ b/drivers/gpu/drm/xe/xe_gt_mcr.c

[Severity: High]
This isn't a bug introduced by this patch, but does the GuC capture code
lack locking when modifying the cachelist and outlist?

These double-linked lists appear to be accessed and modified concurrently
by multiple un-serialized asynchronous contexts. This could be triggered via
GPU hangs or timeouts during normal operation.

For example, during G2H event processing, the list is modified directly
when the CT worker calls xe_guc_capture_process():

drivers/gpu/drm/xe/xe_guc_capture.c:guc_capture_get_prealloc_node() {
        ...
        list_del(&found->link);
        ...
}

Concurrently, during DRM scheduler job timeouts, the outlist is also
modified without locking after xe_engine_manual_capture() calls
xe_guc_capture_get_matching_and_lock():

drivers/gpu/drm/xe/xe_guc_capture.c:guc_capture_add_node_to_outlist() {
        ...
        guc_capture_add_node_to_list(node, &gc->outlist);
        ...
}

Other contexts like devcoredump freeing also access these lists via
xe_guc_capture_put_matched_nodes().

Could concurrent modification of these lists without locking (such as
spinlocks) cause list corruption and inevitably lead to a kernel panic
when the lists are later traversed or modified?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722004654.7442=
49-1-talesam@gmail.com?part=3D1
