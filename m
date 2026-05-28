Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE9ACD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 16:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5385510F291;
	Thu, 28 May 2026 16:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PtVMVsti";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB38710F24F;
 Thu, 28 May 2026 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779986982; x=1811522982;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=jRNLJqJ2HvzVjQj+tHx25T+AidGfUuIqtwnCkO6JJPk=;
 b=PtVMVstix50prMDQ343XD/LQ4+V4PTdNa27r6pf1x10mFbVmZXaa5dby
 xo95aK4Rci3U5YIvjU7w6+ADK28kh2Zyu36E/NWrNQMb5vIh3gq5qhfbo
 IcKNR+/V5RG+5+cBHPGzpXpSuPjYB3dqKZqorhYE1yj2jb94DmoP7bRsk
 Rb5CowrwHBENe3NFepTvk7ZLfYXwvpfSFX9btZEiljx7OJowD3E+yGl8S
 T/zwG9Ix2NFYD9gxZKkEJTxAcp+EUmbzpMdoW2mF135lDlt6wO7qUkuxG
 9dvQmEuVOdxPOBAy+PI5zy5F8KbsLiQXBtarq4ncRxOsRwKV29PIXKicm A==;
X-CSE-ConnectionGUID: KrtF+vbLTj2RbSlxlS/ndQ==
X-CSE-MsgGUID: baivdz6MTv6sQc+k/cFx+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91522127"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="91522127"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 09:49:42 -0700
X-CSE-ConnectionGUID: GalvE7ydTGKhYxVR2sLgZg==
X-CSE-MsgGUID: eLHufy7CRaWI7Bqe/yeR3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="241567216"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 09:49:40 -0700
Date: Thu, 28 May 2026 18:49:36 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: =?utf-8?B?5Y2gd2Vp?= <zhanwei919@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guenter Roeck <linux@roeck-us.net>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm/xe/hwmon: report a single fan for DG2 instead of
 two
Message-ID: <ahhyIMa3Btj7oZv6@black.igk.intel.com>
References: <20260527115311.13398-1-zhanwei919@gmail.com>
 <ahb3VMRCQpofblbW@black.igk.intel.com>
 <CA+qUFcnP-XEPHJD-+djRydD92-bAz5bxxVaRHGJ3nrpwtq4m7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+qUFcnP-XEPHJD-+djRydD92-bAz5bxxVaRHGJ3nrpwtq4m7w@mail.gmail.com>
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

On Wed, May 27, 2026 at 11:18:52PM +0800, 占wei wrote:
> Thanks for the detailed explanation -- that make sense
> 
> I can think of two paths forward:
> 
> 1) Have fan_input_read() return -ENODATA if one channel has started
>  reporting pulses but another remains silent for, say, 30 seconds.
>  This way the phantom entry still appears in sysfs but userspace
>  tools like `sensors` can handle the "no data" case gracefully
>  instead of showing a misleading 0 RPM.

Sounds a bit over engineered solution with its own caveats because

a) We assume that both channels are monitored simultaneously and first
   channel actually reports non-zero value for 30 seconds (or whatever
   trivial value we device) continuously, which is not guaranteed.

b) This means the output of one channel depends on another and I'm
   doubtful if maintainers would be okay with such hacks.

> 2) Drop the code change entirely and instead add a short note in
>  Documentation/gpu/xe/xe_hwmon.rst explaining that on DG2 boards
>  where the OEM routes multiple physical fans through a shared tach
>  line, fan{2,3}_input may read 0, so future contributors don't end
>  up re-attempting the same v1 patch I just sent.

This one makes more sense to me though.

Raag
