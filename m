Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675D0CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71A110E320;
	Mon, 15 Jun 2026 09:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MaYBfsT/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156F110E320
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781517560; x=1813053560;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=s9bL6LBPgoWGmAaIwn9ye3tRNH2GTqhbH3c60kxXv5A=;
 b=MaYBfsT/mTDBaAhi9qWVpHmbk0KTEIoZ9mpAUBLT/0jyUpCai3wTZj05
 S/CoDOgIXNDc8reUc0e0dl1ejlDtxpC3fqLghPP4EzTRUCwg5zIcvMOav
 Ihe6kUmZy3jnOvlVzcfGaaIM3R/4UtijfIOLXG7tJVIBhqRvnk/D+1Iam
 Eju91j9oCF5ZrZeHU4jV4FAgx5FUGTW9FJFlQiY3tjVU/M1Si/HeeSSDj
 O/JCXelh92RL5mghPsWR30bVdwOv+yp3qY0h/a3IMApDJntqVYOSXT9de
 DbRg404wHhyNszOUepHkgJVpGPOb7T/1YIzvdftIBMOxOOsWWfbzj0vT8 A==;
X-CSE-ConnectionGUID: wvYgyzzWT5aQTJlKoQ038g==
X-CSE-MsgGUID: GeR3QkAVQC+nd0xJtF1L7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="86100440"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="86100440"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 02:59:19 -0700
X-CSE-ConnectionGUID: gSsm2Ym5RNSJd8MuzBO4gQ==
X-CSE-MsgGUID: pzW4cTE7Sqqmh0do5m9plA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="247302851"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.28])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 02:59:16 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Stone
 <daniel@fooishbar.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH v3] drm/tests: Move test EDID data to separate .c file
In-Reply-To: <178121613344.363421.14550491021391307675.b4-review@b4>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260610-test-edid-array-definition-fix-v3-1-8ba947c1c453@collabora.com>
 <178121613344.363421.14550491021391307675.b4-review@b4>
Date: Mon, 15 Jun 2026 12:59:12 +0300
Message-ID: <13d51fa273e6577004df793e77d62b76b7a5562e@intel.com>
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

On Fri, 12 Jun 2026, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> On Wed, 10 Jun 2026 18:43:43 +0200, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
>> drm/tests: Move test EDID data to separate .c file
>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Thanks for the patch, review and testing, pushed to drm-misc-next.

BR,
Jani.


-- 
Jani Nikula, Intel
