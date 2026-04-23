Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD31F9936B
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA78710F08F;
	Thu, 23 Apr 2026 10:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SjgJ7zvS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DD210F08F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776941468; x=1808477468;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=PodkzkhxuFT88JROfW+TNaLrzJPmbt4l36DemDa8IXs=;
 b=SjgJ7zvSQMAQ3cvgJq1yBfVRAvc8qreOeZgCw/nGPMq9R24DKuqaW03l
 oG4VCn+tg7EWicuEVOfdkaCwihnuz3D1V/lEREipNqk0UdlsvB0WMlhS8
 6y2gL+O+q2RDm7hjPZsYu3rKInqHS5SY754RYVCSiW8RjW0102c5ZFZce
 Dkmy7p6X9V8riAUR8bvGy9+rLE9FawbeTAE8A3/G0Wpg4zFU0rNh+DPeR
 ICuupPmeVkYxuUGilgW8OASCoFMVjn04mXp7xw/esuoa5aqoEinku8TFs
 u/0MXDIlY98uNnoRUYbdP5t5Wxr0q5uo1Lv3YPCVAbmqypLmkB8LFuT/o g==;
X-CSE-ConnectionGUID: XwHhdoZUQCmhuWWHo5YYTg==
X-CSE-MsgGUID: rQ+3Z35USS+geaXtoozr0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="100559928"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="100559928"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 03:51:07 -0700
X-CSE-ConnectionGUID: Pb5rGiLtRgmIbVtpv7Qkqg==
X-CSE-MsgGUID: oK1sDR6PR/a5VTRuKYRslQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="232466810"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.201])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 03:51:02 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha
 <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Laurent
 Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 00/28] drm: Implement state readout support
In-Reply-To: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
Date: Thu, 23 Apr 2026 13:50:59 +0300
Message-ID: <28caaa3e416c13af6745fedb213dc6eed29feb46@intel.com>
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
> Here's a series that implement what i915 calls "fastboot", ie,
> initializing the initial KMS state from the hardware state at boot, to
> skip the first modeset if the firmware already set up the display.

FWIW, in i915 we also use the state readout for atomic commit
verification. Write software state to hardware, read hardware state
back, compare with the original state, complain if there's a difference.

BR,
Jani.

-- 
Jani Nikula, Intel
