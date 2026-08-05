Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E87AC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F6C10EE17;
	Wed,  5 Aug 2026 11:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U28CIvEv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C4E10EE17
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 11:51:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7C3860A96;
 Wed,  5 Aug 2026 11:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656191F000E9;
 Wed,  5 Aug 2026 11:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785930710;
 bh=BwSFO82QLmRv/SOI8LKMs/bi8oZekfh8xW9nfi+qU/c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U28CIvEv4Py+AEX7c1nweE7WKyJkqSwMrKDL46bA+mzu4vc+HnSakj6TQOR0fcSfC
 PnQz4qc2wVGAa8nU80JWelx1RRmeeOIpwHRhOvBUL5L+XxjKqTn43g9uCDSPU9Qg5r
 vNzju1X4YVxWUjLTZrlSCUaMyHEpyBKpfwqrya8ItBlKRuKSHmez7NAXcTF5ke7tSM
 mBFQ1uZnR9/CHop9jAE99TK7D8E3VPbjIPukhaPSKaS81QjVBEm9/GyQDo7nlIJ/dq
 giQrr58ZK5tpICwPasdHe2SqmaRyXcwwWs+bE/+gK9Ps1onIyPbP/ZK7f5rwO1yFtH
 A2UzTR94UoOZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/pagemap: Add fault injection for higher-order
 RAM folio allocation
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805113338.3742178-5-matthew.brost@intel.com>
References: <20260805113338.3742178-1-matthew.brost@intel.com>
 <20260805113338.3742178-5-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:51:49 +0000
Message-Id: <20260805115150.656191F000E9@smtp.kernel.org>
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
- [High] The debugfs entry created for fault injection is not removed on mo=
dule unload, leading to a memory leak and a use-after-free vulnerability.
--

--- Patch [4]: [PATCH 4/4] drm/pagemap: Add fault injection for higher-orde=
r RAM folio allocation ---
commit 20731b2cfca08a84398b3c52bd2ca16474a3a4f7
Author: Matthew Brost <matthew.brost@intel.com>

drm/pagemap: Add fault injection for higher-order RAM folio allocation

This commit introduces a fault injection attribute to simulate the failure
of higher-order allocations in drm_pagemap_migrate_populate_ram_pfn().
The feature is exposed via a debugfs entry.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 7610e233d238c..01eb29ef023ce 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c

[ ... ]

> @@ -1540,6 +1564,16 @@ void drm_pagemap_destroy(struct drm_pagemap *dpage=
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

[Severity: High]
Does this code leave dangling debugfs entries on module unload?

In drm_pagemap_module_init(), fault_create_debugfs_attr() creates the
drm_pagemap_fault_inject debugfs directory, which holds pointers to the
migrate_to_ram_fault_inject struct located in the module's .data section.

However, drm_pagemap_exit() doesn't seem to clean this up by tracking the
dentry and calling debugfs_remove_recursive(). When the module is
unloaded, the memory backing the fault attribute is freed, but the debugfs
files remain.

Could reading or writing to these lingering debugfs files after the
module is unloaded trigger a use-after-free?

>  	if (WARN_ON(!llist_empty(&drm_pagemap_unhold_list)))
>  		disable_work_sync(&drm_pagemap_work);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805113338.3742=
178-1-matthew.brost@intel.com?part=3D4
