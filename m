Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A93FC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3EC710E281;
	Fri, 25 Sep 2026 12:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J6yKYr+C";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ABBC10E281;
 Fri, 25 Sep 2026 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790340534; x=1821876534;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=keLjwrDnaX1oNrwQa0KCt9pvuS+VJLQJ2PEo4P6RmXU=;
 b=J6yKYr+Cxd5vV6pMektP+6FooqmBCBCJ4nI5pdjqwMitt7J2zZK6C3NY
 +MzEDK7mIGLrabsaWCaKFgfJkt7VwdGrpQQKcVcMpUpoMF992FO5HSZfO
 YzWFZkwQ5f+/UfVILGdt2gJZx9/4BW0qELUw3Jz3q+XB6btX2ibRk1xf7
 N6+EKysZMitBf9wfbBZNSVfNp9oESCIUfOXIxlJJ+9Gpa88nQYveKHIje
 GUJUANKuZUmFktLuZbai8e5BZUWqEmLvO1BLa0U7D3YdOEKVTpZNq0hFa
 JXINsa17dy5JRB3Ky1dcTfPIbRXTOigeLm26ayLj3fC5t0d3nHg3HmMQc A==;
X-CSE-ConnectionGUID: Z2Vs4T0ATBik5ep7vVf30g==
X-CSE-MsgGUID: hlKVH0RJTKGar540YVwo7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89892461"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="89892461"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:48:54 -0700
X-CSE-ConnectionGUID: SO2hFo73QoixFnmSHsjGhg==
X-CSE-MsgGUID: 63gI6Dn/QPmBXq5kxfrvAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="272136683"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.90])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:48:50 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Marcel Hamer <marcel@solidxs.se>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Vinod
 Govindapillai <vinod.govindapillai@intel.com>
Cc: Marcel Hamer <marcel@solidxs.se>, stable@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/irq: crtc guard inside interrupt handlers
In-Reply-To: <20260925115511.1655213-1-marcel@solidxs.se>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260925115511.1655213-1-marcel@solidxs.se>
Date: Fri, 25 Sep 2026 15:48:48 +0300
Message-ID: <5bd47464aaf0f7eeb6b993ca1124d2f2858ee857@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, 25 Sep 2026, Marcel Hamer <marcel@solidxs.se> wrote:
> Interrupts are enabled before the crtc datastructures are initialized.
> As intel_crtc_for_pipe() is called inside interrupt handlers and can
> return a NULL value, this can in rare cases lead to the following NULL
> pointer dereference and panic:
>
> RIP: 0010:handle_plane_fault+0x19/0xc0 [i915]
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f
> 1f 44 00 00 55 48 89 e5 41 55 41 54 49 89 fc 53 48 83 ec 18 <48> 8b 1f
> 65 4c 8b 2d 24 90 31 ef 4c 89 6d e0 41 89 f5 48 85 db 74
> RSP:
> 0018:ffff92b180003e50 EFLAGS: 00010086
> RAX: ffffffffc0911fc0 RBX: ffffffffc06e0b90 RCX: 0000000000000005
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff92b180003e80 R08: 0000000000000005 R09: 000000010517d5f6
> R10: 0000008000000041 R11: 000000010517d5f6 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f72f5b72780(0000) GS:ffff8bbdcbfe9000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000102f2c000 CR4: 00000000003506f0
> Kernel panic - not syncing: Fatal exception in interrupt
> Kernel Offset: 0x2c800000 from 0xffffffff81000000 (relocation range:
> 0xffffffff80000000-0xffffffffbfffffff)
> Call Trace:
>  <IRQ>
>  intel_pipe_fault_irq_handler+0x42/0xc0 [i915]
>  gen8_de_irq_handler+0x1ed/0xdf0 [i915]
>  gen8_irq_handler+0xb5/0xd0 [i915]
>  __handle_irq_event_percpu+0x6e/0x230
>  handle_irq_event+0x3a/0x90
>  handle_edge_irq+0xd1/0x1a0
>  __common_interrupt+0x48/0xe0
>  ? generic_smp_call_function_single_interrupt+0x17/0x20
>  common_interrupt+0x84/0xa0
>
> Fixes: f13011a79999 ("drm/i915: Pimp display fault reporting")
> Fixes: 138d2bda4eaf ("drm/i915/display: pass display to intel_crtc_for_pipe()")
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Marcel Hamer <marcel@solidxs.se>

Please file a bug as described at [1], attaching full dmesg reproducing
the problem. I don't think we're seeing this in our CI, so would be good
to understand the root cause better.

BR,
Jani.


[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


> ---
>  drivers/gpu/drm/i915/display/intel_display_irq.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_irq.c b/drivers/gpu/drm/i915/display/intel_display_irq.c
> index a59b75830bd1..4ffc8789c9f3 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_irq.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_irq.c
> @@ -131,6 +131,9 @@ static void intel_pipe_fault_irq_handler(struct intel_display *display,
>  	struct intel_crtc *crtc = intel_crtc_for_pipe(display, pipe);
>  	const struct pipe_fault_handler *handler;
>  
> +	if (!crtc)
> +		return;
> +
>  	for (handler = handlers; handler && handler->fault; handler++) {
>  		if ((fault_errors & handler->fault) == 0)
>  			continue;
> @@ -148,7 +151,8 @@ intel_handle_vblank(struct intel_display *display, enum pipe pipe)
>  {
>  	struct intel_crtc *crtc = intel_crtc_for_pipe(display, pipe);
>  
> -	drm_crtc_handle_vblank(&crtc->base);
> +	if (crtc)
> +		drm_crtc_handle_vblank(&crtc->base);
>  }
>  
>  /**
> @@ -425,9 +429,14 @@ static void display_pipe_crc_irq_handler(struct intel_display *display,
>  					 u32 crc4)
>  {
>  	struct intel_crtc *crtc = intel_crtc_for_pipe(display, pipe);
> -	struct intel_pipe_crc *pipe_crc = &crtc->pipe_crc;
> +	struct intel_pipe_crc *pipe_crc;
>  	u32 crcs[5] = { crc0, crc1, crc2, crc3, crc4 };
>  
> +	if (!crtc)
> +		return;
> +
> +	pipe_crc = &crtc->pipe_crc;
> +
>  	trace_intel_pipe_crc(crtc, crcs);
>  
>  	spin_lock(&pipe_crc->lock);
> @@ -465,6 +474,9 @@ static void flip_done_handler(struct intel_display *display,
>  {
>  	struct intel_crtc *crtc = intel_crtc_for_pipe(display, pipe);
>  
> +	if (!crtc)
> +		return;
> +
>  	spin_lock(&display->drm->event_lock);
>  
>  	if (crtc->flip_done_event) {
>
> base-commit: f49a343b305c0b6c19a3b50c0bbf10bcd0e2e8fd

-- 
Jani Nikula, Intel
