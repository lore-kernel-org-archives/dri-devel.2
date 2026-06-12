Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73C3CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5618010F32D;
	Fri, 12 Jun 2026 08:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nsM5rLmt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3AE610F32D
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 08:27:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCBE8409A8;
 Fri, 12 Jun 2026 08:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CD21F00A3A;
 Fri, 12 Jun 2026 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781252875;
 bh=5/GYLLyYz9zy6YPMV2AGwjkzt9oklZS6I7GDdK5Rl8I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nsM5rLmt4ul4rewSXdhJoU/Tgxme/Hp+pL4KgoTwHdTHQ2HhKPuG0BdXl2xrMkPKP
 SJ+6PxUpsQMDF9VOkLR5ZsryJm8SNntuCi4keGZ1DN5EgVpw2n82UYMrteX15tCxeH
 PVjAQVF1VDgH8XDdurlaI+Xc+nYLct/f62fdps/v7GxeHLZ8IWA5AMB9eggw2nD9Ws
 XNQNUqM5HKwlOMDbEKF2wTgnUs8OOhkKJZev2KUbY6yFB6VTeGUfsjq5sC34p5rtTh
 EKgDLEjbKCAr6nv7SGfRtexm51oFicT1eZYmYktUD4EhMgHUCHQnrIrNz8qIEKpuIz
 RFLnm57O5je2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/6] drm/xe: Handle PUNIT errors by requesting
 cold-reset recovery
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612080722.26726-12-mallesh.koujalagi@intel.com>
References: <20260612080722.26726-12-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 08:27:55 +0000
Message-Id: <20260612082755.84CD21F00A3A@smtp.kernel.org>
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
- [Low] Unnecessary header files were added to `xe_ras.c`.
--

commit 5df465d682f75cd912c33257354af24edc73cf6d
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/xe: Handle PUNIT errors by requesting cold-reset recovery

When PUNIT (power management unit) errors are detected that persist across
warm resets, mark the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET
and notify userspace that a complete device power cycle is required to
restore normal operation.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 6a5140bc47e52..93a56a0269f1e 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -4,6 +4,8 @@
>   */
> =20
>  #include "xe_bo.h"
> +#include "xe_assert.h"
> +#include "xe_device_types.h"

[Severity: Low]
Are these headers necessary here?=20

Neither the new punit_error_handler() function nor the modified=20
handle_soc_internal_errors() function appear to use any macros or types=20
defined exclusively in xe_assert.h or xe_device_types.h.

It looks like xe_device.h is already included below and provides the=20
necessary types and function declarations like xe_device_set_wedged_method(=
).=20
Could these additions be dropped to avoid unnecessary compilation dependenc=
ies?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612080722.2672=
6-8-mallesh.koujalagi@intel.com?part=3D4
