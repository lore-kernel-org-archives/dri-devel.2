Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0301BF8A14B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA2810E871;
	Thu, 16 Apr 2026 09:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iaQ6oM0A";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB1B10E86B;
 Thu, 16 Apr 2026 09:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776330213; x=1807866213;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=tKR79W2coauzINztppMgXVidiXr4hWU40kBg3n8zqYk=;
 b=iaQ6oM0A4VgGa2BJtuVXCOjoqO0c1X397JzzgfD31sSRLm78VWEP3APp
 FPJmabvFMylwSLAcq+R/d6XUJmBY/vfRszb93vOGVnFSe/pioFjuEZqs5
 4MBr7fz6VkJToAjV6hJT9aTCBJBdaUCuZzRyhxlBQVx76e3nVbm4yUDiG
 s6dOTaG3rC6j/9hq0BGP3+2mTzyzFMXKQJYWbELhvdc5mbbKddgiL5i5Q
 Ha16H/jqZ29rQh/WoO1d7DDS5uRb2buJ+GJvU0aHi2DpsZ2q3AnRIQWK9
 3T2SljLGJMEutrPeMHs4J4esRUbK3yfUgUjVorQSXfxt+UIUO+kTsUZRI Q==;
X-CSE-ConnectionGUID: QE8N9ZkxQ2O+a8BJuBqKhA==
X-CSE-MsgGUID: G+8BjliFS06ZDbYNW6bLdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="99971658"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="99971658"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 02:03:31 -0700
X-CSE-ConnectionGUID: wp9/kQC2Qra/6BBcA+xEVA==
X-CSE-MsgGUID: vuHN9M0iR7O1VChxvBGklA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="228016603"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.246.78])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 02:03:27 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org, Ville
 Syrjala <ville.syrjala@linux.intel.com>
Subject: Re: [PULL] topic/pipe-reorder for drm-intel-next and possibly v7.1-rc1
In-Reply-To: <CAHk-=wjmTh4ESQE7ntR=ddF5JBToNerf4Dzt2zQQ2-Y3OEre-A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <d69501d53c233386d70ed10290af24aafebf434f@intel.com>
 <CAHk-=wiAGevirr3=xC=u5_kN+m63JtjqA0C9NJLrd5PGrM0suw@mail.gmail.com>
 <CAHk-=wjmTh4ESQE7ntR=ddF5JBToNerf4Dzt2zQQ2-Y3OEre-A@mail.gmail.com>
Date: Thu, 16 Apr 2026 12:03:24 +0300
Message-ID: <12226307473a261449a177f4757633da946d3e3a@intel.com>
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

On Wed, 15 Apr 2026, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 15 Apr 2026 at 09:28, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I guess I'll test it just to verify, but if this fixes that known
>> issue I'm all for getting this fixed sooner rather than later.
>
> Well, that was easy enough. I assume this was expected, but I can
> indeed verify that that branch works for me as a replacement for (two
> versions) of the local patch I have been running for the last six
> months or so.

Yay, thanks for confirming it still works for you!

> And maybe I'm the only person on the planet that runs this setup, but
> it gets an ack from me. So I'm ok with a late pull as a fix, but
> somebody who can better judge the risks for other setups should
> eventually make the judgement call.

We've tested a similar setup locally, and a bunch of other setups in CI,
and haven't seen any issues. As far as real world scenarios go, I think
yours is as real as it gets. That said, we'll only really know once this
hits more end users... but I'm not sure if there's any benefit in
dragging this across another development cycle.

Dave, up to you then, will you take this through drm-next?


BR,
Jani.


-- 
Jani Nikula, Intel
