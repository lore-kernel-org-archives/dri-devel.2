Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284BCC982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C6A710E021;
	Mon, 21 Sep 2026 12:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hFNC+AUi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC78D10E021;
 Mon, 21 Sep 2026 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789992361; x=1821528361;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=O9I35faObi0LwJh6VqhUiFz7Qd2hXMLjzi2BJWPyarQ=;
 b=hFNC+AUiNoSS6HmFV6c2s6LSdx1P6XYotsVHD2s+LUgnkdqubKsZVCyL
 zR6cnOhA2QE92BKBMMrUYQSqAuFvNrapMX+U0tFyfdKvlNgEWTuTqurJQ
 W/TVIQCc60DME1GtvjW8cuUwP7UurZafuoGNuKQaCKVWfDq6bjhMtvkjz
 yYUdBzgXvyejiLQVxFREBgd6wAtxVy8SJh2Ngd+sm/4ovMbRx3RqLhmGq
 FlFuC42KBGRiALYbK93pDW3coBXR8pHuq1xhxJJIcHKkmKGtKTyWcXA0F
 xOjLH5pjejs0oJdiCVbN5sltxKjXtE1a75JN2T7yb01iqrgMylxUgNpI3 A==;
X-CSE-ConnectionGUID: DHGgAT1mTVaABCSSLtJ2Fw==
X-CSE-MsgGUID: dKjVvsnTRVeBFLl5ITz0Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="90519082"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="90519082"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 05:06:00 -0700
X-CSE-ConnectionGUID: 7sb0Y0uUQ9Cl3af9e8EaQw==
X-CSE-MsgGUID: 7zieuhx0QFuzuIZVjsKFoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3656413"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.180])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 05:05:58 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Zhenyu
 Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: Re: [PATCH] drm/i915: use string choice helpers
In-Reply-To: <b5576d0e503315036500145888d712e75df42f7e@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260918042325.17700-1-lalitshankarch@gmail.com>
 <b5576d0e503315036500145888d712e75df42f7e@intel.com>
Date: Mon, 21 Sep 2026 15:05:55 +0300
Message-ID: <f752369b705a2fecd04c84e8f8917a85f952a09f@intel.com>
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

On Fri, 18 Sep 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Fri, 18 Sep 2026, Lalit Shankar Chowdhury <lalitshankarch@gmail.com> wrote:
>> Prefer the str_high_low() and str_read_write() helper functions
>> over ternary operators with hardcoded strings.
>>
>> No functional changes.
>>
>> Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

And pushed to drm-intel-next, thanks for the patch.

BR,
Jani.


-- 
Jani Nikula, Intel
