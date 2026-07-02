Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1D4C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4E210F307;
	Thu,  2 Jul 2026 11:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KbCuFgGi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8698310E4B0;
 Thu,  2 Jul 2026 11:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782992933; x=1814528933;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=UReP3MYn8/Ahqd8MfKgT6QqOYlWMRjhFw9iLuV6rknA=;
 b=KbCuFgGiXyiyBiKn1lzcYxhm9HTpK6JjPqC0gpYXp1zgUsK8zdTOFjVZ
 SmNsFXQrajC9yVW7iIblGW7pxDMQKUUoSez15rPei+4jLX3ycMGIJk/B3
 7OISiAhvtynZw4ZjrGCEw6aEIIgAOLWjEw9bJBZTnLNwbMz95zjcR1Fwh
 QEfWYrVgbJmWzlayB54UjlMsnMJcMF8VwFgkqknM9Y6LJHvG2kiXv4G31
 5G4eEDDsHc7bAk5FAS7tAm74Ib9NptoMmgSjphQdtDsoHbP1AlVITjqRi
 BtNuHZYyzsTrL6cy2cpWrLa/kIjsi1YRa5KZHfB6NqMKXvGFitZfunM4a Q==;
X-CSE-ConnectionGUID: fUzMezSsRIOJ3KuSHpaCwA==
X-CSE-MsgGUID: ytsGtc+1T4ShVbzdpBb1XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="94399955"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="94399955"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 04:48:53 -0700
X-CSE-ConnectionGUID: g2dLrWFEQH2Amj+lwuV+uQ==
X-CSE-MsgGUID: 3OytmsoTSm+0SuG6EsklJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="249489468"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.209])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 04:48:50 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Liou, Mei Fan" <mei.fan.liou@intel.com>, "Vivi, Rodrigo"
 <rodrigo.vivi@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Dutta, Ranjan" <ranjan.dutta@intel.com>,
 "Chang, Junxiao" <junxiao.chang@intel.com>, ville.syrjala@linux.intel.com,
 "Deak, Imre" <imre.deak@intel.com>
Subject: RE: [PATCH] drm/i915: add disable_edp module parameter to skip
 phantom eDP init
In-Reply-To: <SA1PR11MB71300AD7CBCA15C7E410E852D8F52@SA1PR11MB7130.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260630102845.2678707-1-mei.fan.liou@intel.com>
 <50700395af210f0e5ca0c5e8306cda41b077f43a@intel.com>
 <SA1PR11MB71300AD7CBCA15C7E410E852D8F52@SA1PR11MB7130.namprd11.prod.outlook.com>
Date: Thu, 02 Jul 2026 14:48:47 +0300
Message-ID: <ec41ece75ff57c7641cc13d42588355efe0c00f4@intel.com>
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


Cc: Ville, Imre

On Thu, 02 Jul 2026, "Liou, Mei Fan" <mei.fan.liou@intel.com> wrote:
> Rather than adding a new module parameter or DMI quirk, I would like
> to pursue your suggestion of fixing the existing video=eDP-1:d path
> (tested: not working for this case).
> May I rework that?

I had a glance.

intel_dp_init_connector() -> drm_connector_init_with_ddc() ->
drm_connector_init_and_add() -> drm_connector_init_only() ->
drm_connector_get_cmdline_mode() ->
drm_mode_parse_command_line_for_connector() ->
drm_mode_parse_cmdline_extra().

drm_mode_parse_cmdline_extra() sets mode->force.

drm_connector_get_cmdline_mode() sets connector->force if mode->force.

It's an interesting idea to use connector->force == DRM_FORCE_OFF to
bail out from eDP init in a way that cleans up the eDP connector but
doesn't fail the probe altogether. (And I think currently this happens
automatically if the PPS/AUX fail, it just takes a while.)

For other connectors we should keep it dynamic, i.e. the connector
should stay around even if forced off at probe, as the status may change
later, but eDP is kind of static. E.g. we don't try all the DPCD reads
again later.

I'm not dismissing the idea immediately, and it might work, but I'm also
not pre-emptively acking. There may be corner cases that I can't think
of right now. Maybe we need to keep the connector around but just not
try to probe it, and then leave it disconnected. Not sure.


BR,
Jani.


-- 
Jani Nikula, Intel
