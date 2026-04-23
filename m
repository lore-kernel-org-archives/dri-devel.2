Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EE9F589A0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C2DE10F0D5;
	Thu, 23 Apr 2026 12:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lOD8dZ98";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF30010F0D5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776946056; x=1808482056;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=NZkSPcRmjL/wS6NsoQeCkA1V04iVBP/f44bcm0vL/PE=;
 b=lOD8dZ98g4+8RAxhq0q1nB5E47eT/Y5tciDocXjf8+sriiNtOaK7vX3s
 tlKyB+NHCDtcEI56OPqNW9tuDcd39jeFoPXl6ffNhHAdRQTUgDcnDGK2q
 pE8UBEZNXpqBEcXApO59aNHGlOM/QIkllCJrqgtZIF8CL2Jd1nWGu0scG
 5nsmLzUolefc3F6HtzHkGGD22xg0CS13LpZQOVzN93W6e8wpADOiaNXFv
 aCKF6UrmD5ZsYvj60fWbdMp3wsfk5ufK4/7eSaz6TqZpgYkAfWBmxX1Oh
 SeT86sv7pvkizFLgi2hWKqB7G5v6iwX6osJyCgLpaKuYdKGLBwxzznADb Q==;
X-CSE-ConnectionGUID: Ux2hzwZxR7mAIGGokMQIbg==
X-CSE-MsgGUID: 2Ne+oQB3SGSaLO2nVD0N4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77824251"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="77824251"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 05:07:35 -0700
X-CSE-ConnectionGUID: SWrObGlTRYKZpSy+vvB4Qg==
X-CSE-MsgGUID: v/6bw2eISui+45LyUBXJeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="232949259"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.244.220])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 05:07:31 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha
 <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 00/28] drm: Implement state readout support
In-Reply-To: <20260423-wealthy-moth-of-youth-0858a5@houat>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
 <28caaa3e416c13af6745fedb213dc6eed29feb46@intel.com>
 <20260423-wealthy-moth-of-youth-0858a5@houat>
Date: Thu, 23 Apr 2026 15:07:27 +0300
Message-ID: <5a8491c0e403eebba06b3edc7c297abaa054e29d@intel.com>
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

On Thu, 23 Apr 2026, Maxime Ripard <mripard@kernel.org> wrote:
> Hi Jani,
>
> On Thu, Apr 23, 2026 at 01:50:59PM +0300, Jani Nikula wrote:
>> On Thu, 23 Apr 2026, Maxime Ripard <mripard@kernel.org> wrote:
>> > Here's a series that implement what i915 calls "fastboot", ie,
>> > initializing the initial KMS state from the hardware state at boot, to
>> > skip the first modeset if the firmware already set up the display.
>> 
>> FWIW, in i915 we also use the state readout for atomic commit
>> verification. Write software state to hardware, read hardware state
>> back, compare with the original state, complain if there's a difference.
>
> I know, and this series implement it as well. Is there anything you
> wanted to point out in particular?

Oh, I didn't get that far, obviously. Just wanted to mention the feature
is not only about fastboot. Sorry for the noise.

BR,
Jani.



-- 
Jani Nikula, Intel
