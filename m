Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B6ECA5FFF
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590F810E7FA;
	Mon,  5 Oct 2026 12:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EltnP57P";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6B410E5B2;
 Mon,  5 Oct 2026 12:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791202045; x=1822738045;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=NZIhoiBu3FmzTtuIairAkdd6glstAiFDHnqVQ7c6zec=;
 b=EltnP57PImvuievfbaop12ZE+61ev7Kn/xhVJLq5vKMB6hmFHJHr4EvL
 4Pq3skW/F2wxQExX/2Q3pVtgK6B6UpFQV5WRqcQeaPTgbTnEjg4r10tGF
 iGVft/DijCtzlbn13j8TTd/JSCCgeASzjg5ElGJp310Bxcp0XWhx1Gv4V
 8JuCxIQtAHpJlTJNz81OseLOT8HqtZFCZgnyK2BhO9+ZRlajskN8eu9Cf
 mDnjUfXX6yAuFJ3mJZZRybLQNePEEl/eX8epANKhw6D/mZzKVY2uybhms
 PD2vTECmlY46lnZntNmuoSAXBFcpU1ZHHmh8Z8TnIcD7UmUKuuIQd3ua6 g==;
X-CSE-ConnectionGUID: OSEXDPmjRyyHIlqNyctjZQ==
X-CSE-MsgGUID: DUjHnBwGRrWFzxJljSMOlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="90904711"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="90904711"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 05:07:25 -0700
X-CSE-ConnectionGUID: Vlt/SrZwT6K0+5JyQOzeMw==
X-CSE-MsgGUID: SHy2l4ZUTUWOfZisSQqOow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="276932252"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.222])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 05:07:20 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Arun R Murthy
 <arun.r.murthy@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 xaver.hugl@kde.org, harry.wentland@amd.com, uma.shankar@intel.com,
 louis.chauvet@bootlin.com, naveen1.kumar@intel.com,
 ramya.krishna.yella@intel.com
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH v11 1/7] drm: Define user readable error codes for
 atomic ioctl
In-Reply-To: <e9be1ef8-9884-4117-9eed-ba179248ffc6@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
 <20260331-atomic-v11-1-6a1df7ec5af8@intel.com>
 <e9be1ef8-9884-4117-9eed-ba179248ffc6@suse.de>
Date: Mon, 05 Oct 2026 15:07:17 +0300
Message-ID: <1f3c2a41a80a9e2902e72be385596ce285b96b2e@intel.com>
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

On Mon, 05 Oct 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> I have serious doubts about these failure codes. The core issue to me is 
> that when the kernel driver detects an impossible commit, it probably 
> knows best how to fix it. Yet the failure codes often lack actionable 
> meaning.

From a different perspective, one of my concerns is that not only the
error codes become ABI, but also the behaviour becomes ABI.

When you're doing atomic check, you usually bail out at the first
problem you can't wiggle around. It's hard or impossible to figure out
the next problem or a bigger problem, because you've just detected you
have a configuration you can't support anyway. You hit the first problem
and you report that.

Now, let's assume userspace adapts to an error code, retries with
different settings, and things work. What if we want to do atomic checks
in a different order in the driver, because it makes sense or is better
or whatever. Is it a regression to report a different error code because
we now do the checks in a different order? Is that painting ourselves in
the corner?


BR,
Jani.


-- 
Jani Nikula, Intel
