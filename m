Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3D0C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2D310EFAA;
	Thu, 27 Aug 2026 10:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JocmhI1e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3210310EFBA;
 Thu, 27 Aug 2026 10:30:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2A8B408EB;
 Thu, 27 Aug 2026 10:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FA71F000E9;
 Thu, 27 Aug 2026 10:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787826643;
 bh=142kRjmzPQUicVULYUprTh6XseyAHoUcCmFe2A2FQmY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JocmhI1e+OUPFTfovKbpo6gx3diST6kc34siSxWfY1OMI/9kjhFF/fh1EnVsuLpTK
 52JvT7woG9f6wNCUb8Iu9wiuzmGw4oNeHWCWLTJmgex4oA/xag6KZuERgW5BE6CUFz
 W0hIcw4KtPcjKpNT/IOI2sMqXA7nSCKOcgUjGFPeMuZAP5Tddn1/jLxj0sp89ytmGh
 81/E6hh9pEkF4bzHaqIOFc6ROkDxC44UBelwVB3A83zmZPTqyA5O5Qs2YNEoqtONXr
 sE52a7MJsNjjtBPv31Y9P2R4mxW6Y8+OgeEXMoMrvoYWiVJ3GNx6lAqNP10oOr2Q31
 0ylwvipj7yFaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] drm/xe: Block BO VM access when device I/O is
 unavailable
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260827101801.1247654-14-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-14-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 10:30:42 +0000
Message-Id: <20260827103043.70FA71F000E9@smtp.kernel.org>
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
- [Low] The function `xe_bo_vm_access` mixes goto-based error handling with=
 scope-based cleanup helpers, violating kernel cleanup guidelines.
--

commit ab2c90ef1f693fb22833ef442c6ad80ec3443ca6
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe: Block BO VM access when device I/O is unavailable

This commit modifies xe_bo_vm_access() to return -EIO when device I/O is
blocked. It uses drm_dev_enter() to protect against concurrent unplug and
protects the block with a userfault SRCU lock.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 1eabece56f6c6..717d318c7072d 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -2245,9 +2245,25 @@ static int xe_bo_vm_access(struct vm_area_struct *=
vma, unsigned long addr,
>  	struct ttm_buffer_object *ttm_bo =3D vma->vm_private_data;
>  	struct xe_bo *bo =3D ttm_to_xe_bo(ttm_bo);
>  	struct xe_device *xe =3D xe_bo_device(bo);
> +	int idx, srcu_idx, ret =3D -EIO;
> =20
> -	guard(xe_pm_runtime)(xe);
> -	return ttm_bo_vm_access(vma, addr, buf, len, write);
> +	srcu_idx =3D srcu_read_lock(&xe->mem_access.vram_userfault.srcu);
> +
> +	if (xe_device_io_blocked(xe) || !drm_dev_enter(&xe->drm, &idx))
> +		goto out_srcu;
> +
> +	/*
> +	 * Keep the drm_dev_enter() protection until the runtime PM
> +	 * reference has been released.
> +	 */
> +	scoped_guard(xe_pm_runtime, xe)
> +		ret =3D ttm_bo_vm_access(vma, addr, buf, len, write);

[Severity: Low]
Does this mix goto-based error handling with scope-based cleanup helpers in
xe_bo_vm_access()?

According to the cleanup guidelines in include/linux/cleanup.h, the usage
of goto and scope-based cleanup helpers should never be mixed in the same
function.=20

Could this create confusing ownership semantics or risk subtle ordering bugs
on scope exit? To maintain consistency, would it be better to convert all
resources in this function to scope-based cleanup, or stick entirely to
goto-based cleanup?

> +
> +	drm_dev_exit(idx);
> +
> +out_srcu:
> +	srcu_read_unlock(&xe->mem_access.vram_userfault.srcu, srcu_idx);
> +	return ret;
>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827101801.1247=
654-1-arvind.yadav@intel.com?part=3D13
