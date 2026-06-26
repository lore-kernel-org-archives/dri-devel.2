Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECC4CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA60910E16D;
	Fri, 26 Jun 2026 11:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EfgRxBBh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337D510E16D
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 11:51:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D71E444103;
 Fri, 26 Jun 2026 11:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A4C1F000E9;
 Fri, 26 Jun 2026 11:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782474660;
 bh=3ofNf4N+u44fKNp0FXKjWD+sUzWAYwp8k+QwwB68AQU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EfgRxBBhQwByYROB+lNlMDJutfyztjF+e1QAmWRf/PBRaA7yzm2ExJr2XP8290Rsj
 lHjqt0MzoT2zq7kWmATmwg1W13ylDVyKbQ1vffDNeXDUAOCvdvBnvthT83bviJVaGe
 WpkUanrx4zpHrX1nPY/l4ppWwlMwne4awaapOZU5j8koX74KtRoStjs0ZRGSwtU4+O
 cSHMwZ0bCLgg71trxb0gMFIb8TUr4YNWBwVHv6Ip76bRzOQOa2k5nS9L8jukeW2FIf
 O4tJ/o2A4kg0HpryM+1BsxRr5reW9KpUe4O7ZfGf7ch3sNAbNIQ63L9f4qhOfgODoR
 1DySLkJox8TQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/xe: skip resv fence wait in xe_svm_invalidate
 if no ranges are bound
To: aquiles <achillezongo07@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626112638.2042298-2-achillezongo07@gmail.com>
References: <20260626112638.2042298-1-achillezongo07@gmail.com>
 <20260626112638.2042298-2-achillezongo07@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 11:50:59 +0000
Message-Id: <20260626115100.91A4C1F000E9@smtp.kernel.org>
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
- [High] Skipping `dma_resv_wait_timeout` based on CPU-side state (`tile_pr=
esent =3D=3D 0`) causes the driver to unmap DMA addresses while a GPU unbin=
d job is still in flight, leading to IOMMU faults and physical memory Use-A=
fter-Free.
--

[Note: The format of this report has been altered to provide a free-form su=
mmary without direct code quotes, due to system recitation restrictions.]

commit 3a11397b2ceb001d3564c3c183ff54d6b34bd490
Author: aquiles <achillezongo07@gmail.com>

drm/xe: skip resv fence wait in xe_svm_invalidate if no ranges are bound

This commit modifies xe_svm_invalidate() to pre-scan affected SVM ranges and
skip the dma_resv_wait_timeout() if no ranges are currently bound to the GPU
(indicated by tile_present =3D=3D 0). This is intended to prevent stalling =
CPU
reclaim when handling MMU notifier events for unbound SVM ranges.

[Severity: High]

Does skipping the dma_resv_wait_timeout() based on the CPU-side tile_present
state introduce a race condition with asynchronous GPU unbind operations?

In xe_svm_invalidate(), the newly added pre-scan loop skips the reservation
wait if range->tile_present is zero. However, looking at op_commit() in
drivers/gpu/drm/xe/xe_pt.c, tile_present is cleared synchronously when an
unbind job is submitted, not when it completes. The actual page-table update
job is queued asynchronously to the GPU and tracked by a BOOKKEEP fence on =
the
VM's reservation object.

If an MMU notifier event (like CPU page reclaim) fires concurrently, the
pre-scan sees tile_present =3D=3D 0, skips the fence wait, and jumps straig=
ht to
cleanup. This causes drm_gpusvm_range_unmap_pages() to unmap the DMA addres=
ses
while the GPU unbind is still in flight.

Can this lead to IOMMU faults and potential use-after-free of physical memo=
ry,
since the CPU will free the pages before the GPU has actually finished
unmapping them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626112638.2042=
298-1-achillezongo07@gmail.com?part=3D2
