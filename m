Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD46CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 13:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D06C10E1AC;
	Tue, 26 May 2026 13:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GbXvMV9Y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F50E10E1AC
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 13:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779803784; x=1811339784;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=2Ekqwm9mVpnB2bnyQisrcjZYlInf4jdq0wIB8D1lHwk=;
 b=GbXvMV9Y+AM9oy6RjxTvCcTPI7zTR2nzJ3YiyJzdVeKZyMKcYYSeu1kk
 qFtBaxqn7Fb/AwJ2G6xhkyg5yh6yiU8y1b/RfDatlO5VwakYxkupPedGc
 7hNuRYocsKNDKZIrKZMIil6k/syIKyEHhkjkKoNr6KeGryY+PfhdJ5kev
 1ke4tlGLv6I0v4dXhj79N1mDS8+kOa6KPYzfeP7LtxvwtuHuSDSedJcXR
 5MKGIdSqwwE9YvJxyIeLB6nuRd2rChCgxwtRlaL3f6fIqwMHp6Ku0MgS1
 ObCHmnwi1Qth4fHKsZXSKvDsRz6h2zKB/SUHq0jRFwKDmcBQqamoLvUES g==;
X-CSE-ConnectionGUID: 2O/jRC6qS9KIso5qM5GxfA==
X-CSE-MsgGUID: ouCG28f8Sb+ogixg0WDfgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="79650664"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="79650664"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 06:56:23 -0700
X-CSE-ConnectionGUID: /leugFaVRaCTur2SPn5wNg==
X-CSE-MsgGUID: ssZRfAjSTYu9A6X5x0VHdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="241080157"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost)
 ([10.245.244.104])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 06:56:17 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v3 4/4] drm/scdc-helper: Implement parsing and printing
 HDMI 2.1 fields
In-Reply-To: <DXw5qfHzRwWls-U9c30neg@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260526-scdc-link-health-v3-0-59e4a4aaead1@collabora.com>
 <20260526-scdc-link-health-v3-4-59e4a4aaead1@collabora.com>
 <a14c938ec67d501967873622e5d2c3c40765cc1d@intel.com>
 <DXw5qfHzRwWls-U9c30neg@collabora.com>
Date: Tue, 26 May 2026 16:56:14 +0300
Message-ID: <ed3429c4ce492d9daf6b63ba7f1aa47a18e8f931@intel.com>
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

On Tue, 26 May 2026, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> On Tuesday, 26 May 2026 12:52:31 Central European Summer Time Jani Nikula wrote:
>> On Tue, 26 May 2026, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
>> > +static __pure const char *drm_scdc_frl_rate_str(enum drm_scdc_frl_rate rate)
>> 
>> There are a total of only 71 __pure usages in the kernel. Is this
>> helpful for a static function where the compiler can figure it out by
>> itself?
>
> For the compiler, no. For the programmer, maybe. It's basically
> documentation that foo(x) remains the same for a specific x, so
> that having 3 calls with the same parameter in some scope is not
> actually 3 separate function calls, but just retrieving a value
> without manually saving it into a stack variable. A compiler can
> infer that in this case, but a programmer that has their LSP show
> them the function signature on hover will immediately know what's
> going on without having to look at the implementation.
>
> I have a habit of slapping it onto any function that is pure just
> because, but if you'd rather have me drop it then I can do that.
> I'm aware that slapping attributes onto function signatures can
> make them a bit noisy to read.

I'm not dead set on this.

But my observation, in general, is that setting an example is something
to be done with care. People try to do the right thing, and cargo
cult. And then you find out it's all over the place.

So IMO the question is not so much, "is it a good thing here", but
rather, "is this what we want for all pure functions".


BR,
Jani.


-- 
Jani Nikula, Intel
