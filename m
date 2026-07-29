Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D1CC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 03:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1049710E626;
	Wed, 29 Jul 2026 03:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VnWjKgMA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC60510E626
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:08:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30A9A60A5E;
 Wed, 29 Jul 2026 03:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB4C1F000E9;
 Wed, 29 Jul 2026 03:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785294510;
 bh=6iV21Zho42YIIRVrplvMwJR6mgM1W34nDODZMRudoC4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VnWjKgMAesvEtCoMK+bOe9nnmFIAkWp6rnAPgk5rBDhtc4jsvpFVczAi9AgRmD8fP
 yF0I5BE2mWSUBWdckSPhkpeN36MJt11PGdky+z3NSE8vGYu+liWrnyWIBNBTzOem3Y
 peV6loWV+bq2oPEuUxj1/v2YR6IIJ6iDa5Yk0Y4AXXmaTp29njBCsWnNulpuDdwrvJ
 Gm2HyzOEalN6ySw+8R8krIE/wp4j6LINqV9DGKXrRIQrpNCSzqgvCAgfctBIJKxf5l
 y7xlDntuYt3Xv8EM+gG/+tznu/pJ6arxaSEMuQZF8rSWgJTq/SQhC0n13nbFNDc/Tl
 u8sMiSs6WN5Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/13] drm/panfrost: Introduce a reset lock
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-claude-fixes-v4-11-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-11-01968f2ec77a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:08:30 +0000
Message-Id: <20260729030830.BCB4C1F000E9@smtp.kernel.org>
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
- [High] Missing `reset.lock` protection for other hardware-accessing entry=
 points, risking concurrent register access during a GPU reset.
--

--- Patch [11]: [PATCH v4 11/13] drm/panfrost: Introduce a reset lock ---
commit 37b5ec54907b68f8dbe5d3c8dbd5b539b7f3a90e
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Introduce a reset lock

This commit introduces a read/write semaphore to prevent driver entry points
from accessing hardware registers while a reset is ongoing. It wraps the
timestamp query ioctl with this lock to avoid races during GPU soft resets.

> drm/panfrost: Introduce a reset lock
>
> So as to avoid accessing HW register while a reset is ongoing, a read/wri=
te
> semaphore that envelopes the reset sequence will help driver entry points
> avoid racing with it. For now, the only such racy entry point is the ioctl
> that returns the current GPU timestmap.

[Severity: High]
This isn't a bug introduced by this patch, but are there other entry points
that also race with GPU resets by writing to hardware registers?

For instance, panfrost_ioctl_perfcnt_enable() calls
panfrost_perfcnt_enable_locked() which writes directly to GPU_CMD:

drivers/gpu/drm/panfrost/panfrost_perfcnt.c:panfrost_perfcnt_enable_locked(=
) {
    ...
    gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
    gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_INV_CACHES);
    ...
}

panfrost_ioctl_perfcnt_dump() and mmu_hw_do_operation() also write to
hardware registers (GPU_CMD and AS_COMMAND respectively) without acquiring
reset.lock.

Could these be invoked concurrently with a job timeout reset? If so,
should they also acquire pfdev->reset.lock to prevent hardware state
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-claude-fix=
es-v4-0-01968f2ec77a@collabora.com?part=3D11
