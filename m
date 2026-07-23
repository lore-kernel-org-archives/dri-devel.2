Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23428C44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 00:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46AC010E65F;
	Thu, 23 Jul 2026 00:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WQK9DjAI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957B510E65F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 00:17:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1F82600AB;
 Thu, 23 Jul 2026 00:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543C31F000E9;
 Thu, 23 Jul 2026 00:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784765878;
 bh=wthA/0W5Mjt9NIT8I0mbRuD0veEW3x8VlcXN4wzFRPQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WQK9DjAIymk/Qakdk7UVUFwVv3RxLUDIYJFJ96DbrHhCZmErBlTRT9s9+wDeTRLRJ
 Lo6kpX/pTeon/htHrljHmsnUACaTrG9AiWvaK+s1qiTTx49wx/f4MPJSGCH7zcAHIk
 7FFh6XQzh6BJl6hQYwnS11NpanvV3fabJF5yx2hDbaxUPhd6Qo5uEcf/yO62/tuR8G
 sSM8xRz231Csx/kWRYs2uYbAam/vetuwsCyj/835GdLUKDFWebgy670WNC87NOI9mB
 cHqTYS9uIkNLpr9gItP79E7rT8m3i2EH65SoJJkt8Ql0jDar9ddtW8ifSqIMOkbY9u
 grnbRQBzjWuDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/7] drm/tyr: add GPU virtual memory (VM) support
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-fw-boot-b4-v9-4-8669d2a02590@collabora.com>
References: <20260722-fw-boot-b4-v9-0-8669d2a02590@collabora.com>
 <20260722-fw-boot-b4-v9-4-8669d2a02590@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 00:17:57 +0000
Message-Id: <20260723001758.543C31F000E9@smtp.kernel.org>
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
- [High] `map_bo_range` and `unmap_range` do not validate that `va`, `map_s=
ize`, and `bo_offset` are page-aligned.
--

--- Patch [4]: [PATCH v9 4/7] drm/tyr: add GPU virtual memory (VM) support =
---
commit f6b41ad5c64a48e1d1e8176179d981d7c1d18bd9
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/tyr: add GPU virtual memory (VM) support

This commit adds GPU virtual address space management using the DRM GPUVM
framework. Each virtual memory space is backed by ARM64 LPAE Stage 1 page
tables and can be mapped into hardware address space slots for GPU executio=
n.
It provides map, unmap, and remap operations with page table synchronizatio=
n.

> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> new file mode 100644
> index 0000000000000..c113820b55052
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/vm.rs

[ ... ]

> +    pub(crate) fn map_bo_range(
> +        &self,
> +        bo: &Bo,
> +        bo_offset: u64,
> +        map_size: u64,
> +        va: u64,
> +        flags: VmMapFlags,
> +    ) -> Result {
> +        let bo_size =3D u64::try_from(bo.size()).map_err(|_| EOVERFLOW)?;
> +        let bo_end =3D bo_offset.checked_add(map_size).ok_or(EINVAL)?;

[Severity: High]
Does this function need to validate that va, map_size, and bo_offset are
page-aligned before passing them to the DRM GPUVM framework?

If unaligned values are passed, drm_gpuvm_sm_map() might successfully split
or remove overlapping mappings in the GPUVM tree during its preliminary
unmap/remap steps.=20

However, when it subsequently invokes the driver's sm_step_map(), the
underlying pt_map() divides the unaligned size by the page size (SZ_4K),
resulting in a page count of 0 for the unaligned remainder.

This causes the hardware page table update to fail with ENOMEM or EINVAL.
Because drm_gpuvm does not roll back earlier tree modifications if the map
step fails, could this leave the GPUVM tree out of sync with the hardware
page tables and potentially lead to state inconsistencies or memory corrupt=
ion?

[ ... ]

> +    pub(crate) fn unmap_range(&self, va: u64, size: u64) -> Result {
> +        let end =3D va.checked_add(size).ok_or(EINVAL)?;

[Severity: High]
Similarly, should this function verify that va and size are page-aligned
before processing the unmap request?

Passing unaligned values here could lead to similar state inconsistencies
between the DRM GPUVM tree and the hardware page tables if the underlying
unmap operations fail or partially complete due to size truncation.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-fw-boot-b4=
-v9-0-8669d2a02590@collabora.com?part=3D4
