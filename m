Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2B9CD6E64
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2FA310FA1A;
	Wed,  3 Jun 2026 08:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QEO/KtI2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F7B10FA1A;
 Wed,  3 Jun 2026 08:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780475252; x=1812011252;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=tMlNo3koGceEqsnJYRqTljD/W1UJMZuj71kL7Fbq4/0=;
 b=QEO/KtI2NghJNZTREHUQbFuxcXxYJMaC/bWVleLc85p8Go9eRZOpy/8y
 jIyz5DRDOFqdOHNFjQLNrTGWzuiyPk/YhRITph7yNolwO9l/2aUc8hydv
 f9qEkdSHcizmhaeBuhM965jaGGJFFy+dSMwsSDfXEK3JkYZbI7egJcRRQ
 iEg0ouWSWx8ppzzCzOoMADTxfFNanJ1GBpUHWR+cIklW9p3CgyqCVl/WT
 56ACPKDlDBgKE9TvFB7i6jGpYrXMsc/viMnXi5DmViVrHzY7WYA+N2Wd3
 pUYCYwDaEYEb8FEbc+a5aopHxu2NdDuAJ3u/kUqlzOIPbIgFzPW+25RWN g==;
X-CSE-ConnectionGUID: 6udE/mpgSniwai/kKO5Bcg==
X-CSE-MsgGUID: 2oC0L1b/ROmSnifoEKOY8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="98696731"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="98696731"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 01:27:31 -0700
X-CSE-ConnectionGUID: +lGZn+AdTbmyHwoKIDDktQ==
X-CSE-MsgGUID: hiCbU2wyTo+S0KzbqpGWfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="282270046"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.189])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 01:27:26 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 matthew.brost@intel.com, uma.shankar@intel.com,
 pierre-louis.bossart@linux.dev, jerome.anand@intel.com, tiwai@suse.de,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH v3] drm/i915/display: Fix intel_lpe_audio_irq_handler
 for PREEMPT-RT
In-Reply-To: <3e012936-8493-43c8-b547-17ae40e6ef74@lankhorst.se>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260602004515.1907422-1-runyu.xiao@seu.edu.cn>
 <20260602062957.0Nbtw_yY@linutronix.de>
 <3e012936-8493-43c8-b547-17ae40e6ef74@lankhorst.se>
Date: Wed, 03 Jun 2026 11:27:23 +0300
Message-ID: <41760e1def08cbf51bf868a7ebf393e0d9e59125@intel.com>
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

On Tue, 02 Jun 2026, Maarten Lankhorst <dev@lankhorst.se> wrote:
> Thanks, pushed!

Where are the CI results?

>
> On 6/2/26 08:29, Sebastian Andrzej Siewior wrote:
>> On 2026-06-02 08:45:15 [+0800], Runyu Xiao wrote:
>>> From: Maarten Lankhorst <dev@lankhorst.se>
>>>
>>> The LPE audio interrupt comes from the i915 interrupt handler. It
>>> should be in irq disabled context.
>>>
>>> With PREEMPT_RT enabled, the IRQ handler is threaded.
>>> Because intel_lpe_audio_irq_handler() may be called in threaded IRQ context,
>>> generic_handle_irq_safe API disables the interrupts before calling LPE's
>>> interrupt top half handler.
>>>
>>> This fixes braswell audio issues with RT enabled.
>>>
>>> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
>>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>>> Reviewed-by: Uma Shankar <uma.shankar@intel.com>
>>> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
>> 
>> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> 
>> Sebastian
>

-- 
Jani Nikula, Intel
