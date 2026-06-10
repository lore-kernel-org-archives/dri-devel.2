Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5757BCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B95210E99D;
	Wed, 10 Jun 2026 14:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BWW7uaxE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CFBA10E9C3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781100010; x=1812636010;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=lSmeWmGSvos+VJwGcRA8JyabB7wzhIoB+/mZkMeRpZ0=;
 b=BWW7uaxEFpKR/61gQYPdeEsYCG4aUr+z24S4L+3LpH7rnBw+4bQzBPc9
 HgnefitNjh7pLYavvI/59+Z9T2rd4bIZE/mbZOZ/WWsQZa8gfrjadam/N
 CHDhrwC/xhwu4kIAbwLfMUr+YKMx2JPJOPp+zhuKA/v8s/0krImcp6NHv
 0VSlNHDPnGklST61ySvafW4ZX0mzVOaRXRk46p+tqn2LlLDxHjsyRoXNm
 32T7mjCaKxkSSYqfJ6csiFZEYZOsgNVtUUxibdRsneO1JqV+ojKsU9hj5
 f29gOH4pmIv+EfJwx/3+8NY8RW/Vakps4zQlscNPoSfleg0FaM6RKnFUE Q==;
X-CSE-ConnectionGUID: yMT5ntV2R8ChwjUBBUx6Bg==
X-CSE-MsgGUID: iNGF6sG+TrWEA9CDhRiRAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84463305"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="84463305"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 07:00:10 -0700
X-CSE-ConnectionGUID: bJdcSQXnSWW1HLXtEQr3CQ==
X-CSE-MsgGUID: nI9lx0QnQfGu2kpDT3ltSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="242046002"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.244.3])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 07:00:08 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: Re: [PATCH] drm/tests: Move test EDID data to separate .c file
In-Reply-To: <20260610-quantum-glossy-partridge-136d8b@houat>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260610-test-edid-array-definition-fix-v1-1-4467ba487886@collabora.com>
 <79f42f7e29b7a807c8ca4e622a547183018d65cb@intel.com>
 <20260610-quantum-glossy-partridge-136d8b@houat>
Date: Wed, 10 Jun 2026 17:00:05 +0300
Message-ID: <97ac9e7b0f65f6f8c34c74718a0b707b95b1127c@intel.com>
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

On Wed, 10 Jun 2026, Maxime Ripard <mripard@kernel.org> wrote:
> On Wed, Jun 10, 2026 at 03:32:12PM +0300, Jani Nikula wrote:
>> On Wed, 10 Jun 2026, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
>> > Having the test EDID arrays defined in the .h directly will duplicate
>> > them across every user of the EDID arrays. This works fine as long as
>> > there's only one user, but may produce build warnings/errors when there
>> > are multiple users and not all of them use all definitions.
>> >
>> > Move the array definitions to a new .c file, and mark the declarations
>> > in the header as "extern" to avoid the linker throwing a fit, and give
>> > them an explicit size (either 128 or 256, depending on EDID) to avoid
>> > the compiler inferring that they must be size 1.
>> >
>> > Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
>> > Closes: https://lore.kernel.org/r/04ff70850213ae0f75486b1a27a7edb6fb4e71c3@intel.com/
>> > Fixes: ce1d0139adac ("drm/tests: bridge: Add test for HDMI output bus formats helper")
>> > Fixes: 082fbc179c01 ("drm/tests: bridge: Add KUnit tests for bridge chain format selection")
>> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>> 
>> Thanks for doing this.
>> 
>> I think I would've also moved the comments with the edid-decode
>> results. Matter of taste I guess.
>> 
>> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>
> Yeah, I agree but since it fixes a compilation warning it can be done as
> a subsequent patch.

Btw the Sashiko review comment looks appropriate.

>
> Acked-by: Maxime Ripard <mripard@kernel.org>
>
> Maxime

-- 
Jani Nikula, Intel
