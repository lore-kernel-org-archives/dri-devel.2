Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661FAC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C20B210F3E3;
	Thu, 10 Sep 2026 09:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BjlP95bG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10CCB10F3E2;
 Thu, 10 Sep 2026 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789033844; x=1820569844;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=QaGkdeHt/iTVylswcvkyA74aeou+kOImrpOlB1eTjEw=;
 b=BjlP95bGgPtgAWlFkBawJVbms6BEdCy+CJ+vRkmKFsuM7ovgwqwQBKxN
 M7w7oo0EWvJBN009bXwLe/UJYli1ZoNGw7wvaSG8WQztnHeW3kKqScv7Y
 74WQp5VaR+6m3vnsTfqswH6HJdxg2V3ewZCGPHqxUZsxYdeF6ElBCY/0c
 m2Wy16MXvBs7VhVE5ti2pcDbS8FIVSGdUBqbz5hG+EZNrPCAwpseU388j
 P3GQLklYWuxtm4gNQCpUdB+vyOPSSyVvFGSFkxoTwB/D2QanGCL3Zy5Hv
 7GwlY9q2oB6PlDbE2ebRR9CMU1GyWngDJVr0VGDNX5m/BqDFS+mAxp2v4 A==;
X-CSE-ConnectionGUID: kVLjPgVyTNChobVtAhE9Aw==
X-CSE-MsgGUID: 9/Gc3Mg1R0i9vSGPB9Qq5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88627067"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="88627067"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 02:50:43 -0700
X-CSE-ConnectionGUID: LuZpvBWWStCLU8bXOMUdQg==
X-CSE-MsgGUID: H69zuhBGQOSZPYEbOVLh3w==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.193])
 ([10.245.245.193])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 02:50:42 -0700
Message-ID: <131278e8dbc7b02b5a2395f3ab1ef4575f12fb93.camel@linux.intel.com>
Subject: Re: [PATCH 01/13] drm/xe/irq: Always free requested IRQs on uninstall
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com, 
 rodrigo.vivi@intel.com
Date: Thu, 10 Sep 2026 11:50:39 +0200
In-Reply-To: <20260827101801.1247654-2-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-2-arvind.yadav@intel.com>
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

On Thu, 2026-08-27 at 15:47 +0530, Arvind Yadav wrote:
> xe_irq_suspend() clears irq.enabled after disabling and synchronizing
> the
> interrupts. irq_uninstall() currently returns when that flag is
> clear, so
> a suspended device can skip free_irq() during teardown.
>=20
> The managed uninstall action is registered only after the IRQ request
> succeeds. Reset the interrupt registers only when interrupts are
> still
> enabled, but always free the requested IRQs.
>=20
> Fixes: 4d79a1266d4c ("drm/xe: Make irq enabled flag atomic")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/xe/xe_irq.c | 6 ++----
> =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_irq.c
> b/drivers/gpu/drm/xe/xe_irq.c
> index 9e49e2241da4..d314993b14a1 100644
> --- a/drivers/gpu/drm/xe/xe_irq.c
> +++ b/drivers/gpu/drm/xe/xe_irq.c
> @@ -786,10 +786,8 @@ static void irq_uninstall(void *arg)
> =C2=A0{
> =C2=A0	struct xe_device *xe =3D arg;
> =C2=A0
> -	if (!atomic_xchg(&xe->irq.enabled, 0))
> -		return;
> -
> -	xe_irq_reset(xe);
> +	if (atomic_xchg(&xe->irq.enabled, 0))
> +		xe_irq_reset(xe);
> =C2=A0



> =C2=A0	if (xe_device_has_msix(xe))
> =C2=A0		xe_irq_msix_free(xe);
