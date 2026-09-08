Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C26C79FAE
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6865E10E15E;
	Tue,  8 Sep 2026 16:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H6eQYWIA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D0910E15E;
 Tue,  8 Sep 2026 16:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788885217; x=1820421217;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=Zwms8LENiBypMxRUgVnbRobEhZCSbNKOrZa9Q7mf45U=;
 b=H6eQYWIAvYCc6p3ioNFAlOhI2pp274pbTVmuHMSd8r8VwsEhVhlHo/Yp
 ssd2MOm3ftrnCRynpyAXWbsjGlQnqlHwWNFZK0/j+/3xxBWDexkQ0WtV7
 AcmyQrbs6kuGDkOgGubgyqnO9/eMdc/T7G3sSAJrt4PIBsNyld/7yPPHS
 PYK7EZDOOs6LXul/DM1J3jYcPUe3e5EYByz2E2SU2C1Kpyi1atlw5I/Rq
 MLofZaCtRmt+zt6OgUN3vFU52hBAwHJnbpz06mr0ouUvHDbfmSGgMoe4n
 1gxN+yiqwsOj3DBUkSTD52w3fJtJNioVcgtRVb4Ajr2TSW5bYOcmOO7RY Q==;
X-CSE-ConnectionGUID: ZzZCk02FSWCM/QsoNcOUxg==
X-CSE-MsgGUID: Cajnnv1ES5uwzVd9PvUKPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88227849"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="88227849"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 09:33:36 -0700
X-CSE-ConnectionGUID: 5bYttxrYTRyyz5BKiYqUVA==
X-CSE-MsgGUID: lLPjEYKWRkmBbYSlikbP7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="275180153"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.140])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 09:33:32 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Hans de Goede
 <hansg@kernel.org>, David Herrmann <dh.herrmann@gmail.com>, Marta Lofstedt
 <marta.lofstedt@intel.com>, Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
In-Reply-To: <f8d54027-ea66-44ec-bc7b-0abb69e918ed@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-3-mario.limonciello@amd.com>
 <dd7f11d6772b9422793cbcf1011f4f1aa98bfa3d@intel.com>
 <f8d54027-ea66-44ec-bc7b-0abb69e918ed@amd.com>
Date: Tue, 08 Sep 2026 19:33:30 +0300
Message-ID: <236b657d2c01dd569a527d96613b1d4258f331b0@intel.com>
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

On Tue, 08 Sep 2026, Mario Limonciello <mario.limonciello@amd.com> wrote:
> On 9/8/26 10:45, Jani Nikula wrote:
>> On Mon, 07 Sep 2026, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>> +/* Forward declaration for backlight_update_status */
>>> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>> 
>> I think IS_REACHABLE() is almost always a mistake. It's a hack to avoid
>> link errors when something in a module needs something that is
>> built-in. It's a combo that should be handled at Kconfig level, not at
>> build level.
>> 
>> BR,
>> Jani.
>
> That came from this feedback from Thomas Zimmerman (I originally had it 
> as select:
>
> https://lore.kernel.org/dri-devel/8224920a-3a10-4400-9503-f014b7059329@suse.de/
>
> I was trying to use IS_REACHABLE to make it optional, but it sounds like 
> that's not the right direction then?

I agree with Thomas, but he's also not suggesting to use IS_REACHABLE()!

The point is, if you express the dependencies properly with "depends on"
in Kconfig, you won't need IS_REACHABLE(). It's the "select" that can
lead to incorrect configurations, and IS_REACHABLE() is band-aid to work
around this.

BR,
Jani.


-- 
Jani Nikula, Intel
