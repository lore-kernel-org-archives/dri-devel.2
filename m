Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88149606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mxgaQ+2f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96AE1124F9;
	Thu, 22 Oct 2026 11:37:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C248F1124F9
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792669065; x=1824205065;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=ALmiItUf2x/zH3Mfj6B6lpX1RjeV3OJyskyjLJWabeQ=;
 b=mxgaQ+2flyv2gTnYBjq3kFIFeSLc80+kW7awkShODe8/i1hgpY+q1s5I
 7W+5Z4f7awQRfb0Kzb0AKvXCGR2XK0bNMLCFoNQ2alXZLsBBuiaKF+EED
 Jf3KldkR1tedYne76hIwK5QorEAKR3bpGv4nkbGfaYflsCPYQWRFWGzZo
 FlU5fTZ4YtI9JZoIGBGAvFqauhe4MtMaOzFW5GXtiDCVQBsp98wpnqA6g
 tihyJ1uTkU3dyKphaHvYfiKHrtXVtgDjrQ8S1Sr/qrg9UbTUCdK2bPCmh
 kJGnWISxFdiIgWxA9fX8XSQRRcuu41PvO6HriM/1giOdLklL81abh3SBq g==;
X-CSE-ConnectionGUID: Xk3DkBbkROaydkhAcL7n7g==
X-CSE-MsgGUID: E//14gjsSceIDDtEklqeEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1518787"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1518787"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 04:37:44 -0700
X-CSE-ConnectionGUID: N0r6Et1LTiC0PAFkluJ/Tg==
X-CSE-MsgGUID: wCR/cxFaTtimhYw2cqbi8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3701729"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.5])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 04:37:40 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>, Chenyu Chen
 <chen-yu.chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Harry
 Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 kasan-dev@googlegroups.com
Subject: Re: [PATCH] drm/edid: reduce update_display_info() stack usage
In-Reply-To: <3486e0b1-d188-47a9-9de6-7ee5c2cfd097@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261013205223.2396822-1-arnd@kernel.org>
 <6c18da11310ced4a7c85ac7862c3f5c67b39891a@intel.com>
 <3486e0b1-d188-47a9-9de6-7ee5c2cfd097@app.fastmail.com>
Date: Thu, 22 Oct 2026 14:37:36 +0300
Message-ID: <90fe0000d611f080164a1fd7f228cd533a2e927d@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026, "Arnd Bergmann" <arnd@arndb.de> wrote:
> On Mon, Oct 19, 2026, at 15:28, Jani Nikula wrote:
>> On Tue, 13 Oct 2026, Arnd Bergmann <arnd@kernel.org> wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The drm_parse_cea_ext() calls into nine individual parser functions
>>> based on the data format. If all of those get inlined and KASAN_STACK
>>> is enabled, this can explode the combined stack usage beyond a
>>> reasonable amount:
>>>
>>> drivers/gpu/drm/drm_edid.c: In function 'update_display_info':
>>> drivers/gpu/drm/drm_edid.c:7040:1: error: the frame size of 1888 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
>>>  7040 | }
>>>       | ^
>>>
>>> Mark all of the individual parser functions as noinline_for_stack
>>> to avoid this and keep their stack frames separate. This reduces
>>> the stack usage for update_display_info/drm_parse_cea_ext to
>>> a more manageable 744 bytes, while each parser only adds at most
>>> 200 bytes on top.
>>
>> Is there really no way to tell the compiler to not do silly things in a
>> more generic way?
>
> The problem is really the sanitizers here, which turn off the
> optimizations that gcc relies on for its normal behavior and
> which cause additional register pressure for the inserted function
> calls.

Cc: a bunch of KASAN folks.

I think it's really silly and ugly to have to sprinkle
noinline_for_stack all over the place in pretty normal code [1]. The
stack usage for each individual function is fairly small.


BR,
Jani.


[1] https://lore.kernel.org/r/20261013205223.2396822-1-arnd@kernel.org


-- 
Jani Nikula, Intel
