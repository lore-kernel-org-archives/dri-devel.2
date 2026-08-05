Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E0DC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 23:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DAE810E25B;
	Wed,  5 Aug 2026 23:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NsaWFY1n";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95C810E25B
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 23:24:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E47D560A63;
 Wed,  5 Aug 2026 23:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0551F000E9;
 Wed,  5 Aug 2026 23:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785972289;
 bh=nvDIlz8fKx/JCMRIINdNtxBqkPMk/uUtQCCENJDB/+4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NsaWFY1n/XuOIszIwpC9RckuR31avTlZxU57w+IarMG41ZZkk0GXAVzDce7/xGbE4
 vz+Blp9SfZ2zqQiVt1CdBcxw+FZ1/KekCA0D0VDlcygUj898yCjV2JBC19dSdL+mn+
 FGTJtWy1PNJCSDkuoKOlrFNryr8QeTYyQGYqboQ4/3tAs6L05fjNw7koKpfOuAVJvD
 5hMQnIQLKToZ3YvVqdP80Uv6R5IQ6PmKoQpVYY5GPxoLXprOX/tiW5uvd4X5BDbyu+
 T0X27a3hwJNRMjANt7ihF636rjEEpaBeFbFiD86I9+UEOQS021hNhItLTOKjJ2OTXA
 v4WvM1i7kOX1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] drm/pagemap: Add fault injection for
 higher-order RAM folio allocation
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805231041.3791771-7-matthew.brost@intel.com>
References: <20260805231041.3791771-1-matthew.brost@intel.com>
 <20260805231041.3791771-7-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 23:24:48 +0000
Message-Id: <20260805232449.6C0551F000E9@smtp.kernel.org>
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
- [High] Use-After-Free in debugfs due to missing cleanup on module unload.
--

--- Patch [6]: [PATCH v3 6/6] drm/pagemap: Add fault injection for higher-o=
rder RAM folio allocation ---
commit fdb5d198639794ed363bbe0eda839a0e39a16e0c
Author: Matthew Brost <matthew.brost@intel.com>

drm/pagemap: Add fault injection for higher-order RAM folio allocation

This commit introduces a fault injection attribute to simulate memory
pressure for higher-order RAM folio allocations. It adds a debugfs entry
to allow testing the order-0 fallback and THP split paths in
__migrate_device_pages().

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c

[ ... ]

> @@ -1554,6 +1578,16 @@ void drm_pagemap_destroy(struct drm_pagemap *dpage=
map, bool is_atomic_or_reclaim
>  		kfree(dpagemap);
>  }
> =20
> +static int __init drm_pagemap_module_init(void)
> +{
> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_FAULT_INJECTION)
> +	fault_create_debugfs_attr("drm_pagemap_fault_inject", NULL,
> +				  &migrate_to_ram_fault_inject);
> +#endif
> +	return 0;
> +}
> +module_init(drm_pagemap_module_init);
> +
>  static void drm_pagemap_exit(void)
>  {
>  	flush_work(&drm_pagemap_work);
>  	if (WARN_ON(!llist_empty(&drm_pagemap_unhold_list)))
>  		disable_work_sync(&drm_pagemap_work);
>  }

[Severity: High]
Does this leak the debugfs directory on module unload, potentially leading
to a use-after-free?

In drm_pagemap_module_init(), fault_create_debugfs_attr() creates a debugfs
entry pointing to migrate_to_ram_fault_inject, which resides in the module's
memory. Since the returned dentry isn't saved and removed here in
drm_pagemap_exit(), the debugfs entry will remain active after the module is
unloaded.

If the debugfs files are accessed post-unload, could the kernel dereference
the freed fault_attr pointer? Should the dentry be captured during init and
cleaned up in the exit function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805231041.3791=
771-1-matthew.brost@intel.com?part=3D6
