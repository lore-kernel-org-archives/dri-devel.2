Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52DCC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA8C10E04A;
	Fri, 18 Sep 2026 07:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="l1g8CXNt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B8B10E04A
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789715208; x=1821251208;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=3KRwA31+VY85ETkWbsG5YLZqWPSFFHLGeCNZWy+Ot/A=;
 b=l1g8CXNtVezc9SrUiPHrHpBRLfqprFERHOWxheur02hgQ3uTgEaj+wNF
 35HlYjVz0alafagVWxvHnsC/DCVGE6ZRn5X8UNFgLLxtnXVQVLuqi+L8L
 cvSKsfRIsNOEjwfJYU7oQzluf9D+BVP+sGLPXzybX2Q0EcRDNkvALiNHq
 2O4ClzkN+qL7lmii7EBr1LiUgJ7ybbmRUsRdIr6/INaba5SZR29Gaolb3
 RkjGJeWsuvoVf85Yu+0k+e7p/GLwk911KhbjFb3XAZ0wVUhPXiTtFZ9Qk
 ZiNjjTeDZQbUkmJ/pTZpvQ21JUB5ZDV5HPNwv9hQnCHQFpDee+M7hX48h Q==;
X-CSE-ConnectionGUID: R8Ocbsl9QTKclYSdl5ibUw==
X-CSE-MsgGUID: 6D9thRsNQW2tQjaye/4RAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77765980"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="77765980"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 00:06:19 -0700
X-CSE-ConnectionGUID: 7jLdTt+rSWmdKJH2VhO3Hg==
X-CSE-MsgGUID: rxMzxxxzSIOaGkFEXaDVzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2662983"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.245.189])
 ([10.245.245.189])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 00:06:08 -0700
Message-ID: <7ee240d45896cf5f4845b4ca0740a307edaf83a7.camel@linux.intel.com>
Subject: Re: [PATCH] drm/pagemap: Prevent CPU stalls during unbounded
 pagemap teardown
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Varun Gupta <varun.gupta@intel.com>, dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com
Date: Fri, 18 Sep 2026 09:05:56 +0200
In-Reply-To: <20260917170357.3926213-2-varun.gupta@intel.com>
References: <20260917170357.3926213-2-varun.gupta@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, 2026-09-17 at 22:33 +0530, Varun Gupta wrote:
> drm_pagemap_dev_unhold_work() processes an unbatched llist of
> pagemaps
> on the system workqueue. This creates potential latency traps during
> heavy teardown cycles due to two compounding factors:
>=20
> 1. The loop contains a per-item drm_dbg() trace. If dynamic debug is
> enabled on a slow serial console, synchronous print latency scales
> linearly with the batch size and can block worker execution.
> 2. The llist can accumulate large batches during intensive unmap
> operations, monopolizing worker resources without yielding.
>=20
> This causes below log warning:
> "workqueue: drm_pagemap_dev_unhold_work [drm_gpusvm_helper] hogged
> CPU
> for >10000us 19 times, consider switching to WQ_UNBOUND"
>=20
> Fix this by implementing a latency mitigation strategy:
> - Move the teardown work to system_unbound_wq to avoid tying up
> =C2=A0 per-CPU bound worker pools.
> - Add cond_resched() inside the teardown loop to yield the CPU during
> =C2=A0 large batch teardowns, ensuring system responsiveness.
> - Convert the drm_dbg() trace to drm_dbg_ratelimited() to mitigate
> =C2=A0 serial console bottlenecks while preserving debuggability.
>=20
> Fixes: a26084328ac4 ("drm/pagemap, drm/xe: Manage drm_pagemap
> provider lifetimes")
> Signed-off-by: Varun Gupta <varun.gupta@intel.com>

LGTM.
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/drm_pagemap.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_pagemap.c
> b/drivers/gpu/drm/drm_pagemap.c
> index 892b325fa99b..f8d5428f1750 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -986,7 +986,7 @@ static void drm_pagemap_release(struct kref *ref)
> =C2=A0	dpagemap->dev_hold =3D NULL;
> =C2=A0	drm_pagemap_shrinker_add(dpagemap);
> =C2=A0	llist_add(&dev_hold->link, &drm_pagemap_unhold_list);
> -	schedule_work(&drm_pagemap_work);
> +	queue_work(system_unbound_wq, &drm_pagemap_work);
> =C2=A0	/*
> =C2=A0	 * Here, either the provider device is still alive, since if
> called from
> =C2=A0	 * page_free(), the caller is holding a reference on the
> dev_pagemap,
> @@ -1009,10 +1009,11 @@ static void
> drm_pagemap_dev_unhold_work(struct work_struct *work)
> =C2=A0		struct drm_device *drm =3D dev_hold->drm;
> =C2=A0		struct module *module =3D drm->driver->fops->owner;
> =C2=A0
> -		drm_dbg(drm, "Releasing reference on provider device
> and module.\n");
> +		drm_dbg_ratelimited(drm, "Releasing reference on
> provider device and module.\n");
> =C2=A0		drm_dev_put(drm);
> =C2=A0		module_put(module);
> =C2=A0		kfree(dev_hold);
> +		cond_resched();
> =C2=A0	}
> =C2=A0}
> =C2=A0
