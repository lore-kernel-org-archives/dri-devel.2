Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF244CD6E57
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31F61134C1;
	Mon,  1 Jun 2026 15:28:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="INae7iy1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D3321134C1;
 Mon,  1 Jun 2026 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780327714; x=1811863714;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=3S42FX/eeqsZqTnlxB/zu3fYzUgrTMnuEf21k85uzOc=;
 b=INae7iy11U+pAABGMUKIGmlrgqLf+cmRhsZqAxYv0egAJzB5lEUZnsXT
 IsKJU7HJE2vCDwHTkeud6oQx8uotI64iv3XuykBxuWCwJUQ3AfBAnMiac
 VOqk8FcQm9wP0PIxh4d3q93kI2wvP2pd8teHKkPwT5TP7CzC+jE5jLJ4Z
 Iu6nFERs6Pj8/28H7Oe9DeAb/bDQrSbErPVdHT3kHg6c8uxRUcRKSFmkU
 mwLvfCkVlRL48F/HJDetDwhyQD3zTIyOaH45geLGUw9mZ2pyMAIYBPbp3
 sbcpRIbaEJhPEdFHpMavjKsS7D6/C1w/S3rrIBY3+sBg9aB/phLqI4y4H w==;
X-CSE-ConnectionGUID: 3JSoOqCmSv20nHpxxB/pfg==
X-CSE-MsgGUID: hdugLGWxTTSRKTu8jiKDgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81201938"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="81201938"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 08:28:33 -0700
X-CSE-ConnectionGUID: 6QI3/huuTtqMLTVecconEQ==
X-CSE-MsgGUID: sMaxWqyNRpOTqRp2du+d5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="241093420"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.121])
 by fmviesa008-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 08:28:30 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie
 <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: Re: [PULL] drm-misc-fixes
In-Reply-To: <20260529070009.GA313534@linux.fritz.box>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260529070009.GA313534@linux.fritz.box>
Date: Mon, 01 Jun 2026 18:28:27 +0300
Message-ID: <ddf0233e50044059c85279f928661563ef6a55bf@intel.com>
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

On Fri, 29 May 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Rajat Gupta (1):
>       drm: prevent integer overflows in dumb buffer creation helpers

Looks like this commit 5ab62dd3687b ("drm: prevent integer overflows in
dumb buffer creation helpers") regressed in our CI, awaiting
confirmation.

No matter what, it's immediately suspect because AFAICT it was not
posted on the lists, and the commit doesn't have a Link: trailer
pointing at the patch.

This is not how we're supposed to roll. What's going on?


BR,
Jani.

-- 
Jani Nikula, Intel
