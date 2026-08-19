Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B4CC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBAC610E105;
	Wed, 19 Aug 2026 09:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="U9gn1BeH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D29910E105;
 Wed, 19 Aug 2026 09:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787131873; x=1818667873;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=3u3xlMJ5fpbZzxsclW4XVg2U0FbIpBnl65cYigskGc0=;
 b=U9gn1BeH+xwG+RdIXXnIr4TXLO7zeem0F81QzV5OImFrAF9RhN1iAZzc
 UNk+6utUjZatrpsrJM8pPk6R4fdWsfti6osMxGIhOXbv3yuE1PrVxElcx
 jmRJOY91kxr0RJtzq+6Z+lRo0NS0Xm+ioQAlFphU8Z99hGOyu5RF6sdwR
 oF/Ytsf0OA0dYNIgjmzE9sVbXz513rrNztFQ755vFCeOHsqcceD26JxUL
 2iH4jJv4tTLUvHz8TX7x6gfqKYor/EleehWNwhaEVJwpXKJYMAxYJHdGi
 ZlploTtbqy/tYvQkks3pr720nO2cb3jGPZhKJEEuFqPmCWzmwpFyOrjxQ A==;
X-CSE-ConnectionGUID: 0h6dj6blQ++kgbIbIrGk6g==
X-CSE-MsgGUID: /r8IHl+jRyayq39ALpfxBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="113185481"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="113185481"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 02:31:12 -0700
X-CSE-ConnectionGUID: 2PuugOzfQAeylrVcZiNS/g==
X-CSE-MsgGUID: 42QGZO9kSMWCtkqYS0dWAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="262230989"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.152])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 02:31:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: Unexpected files in the drm-intel tree
In-Reply-To: <aoR9fNYRhmWDNJtz@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <aoR9fNYRhmWDNJtz@sirena.org.uk>
Date: Wed, 19 Aug 2026 12:31:07 +0300
Message-ID: <cbd77031f484d0c044666c4fc11fd3ef273459bb@intel.com>
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

On Tue, 18 Aug 2026, Mark Brown <broonie@kernel.org> wrote:
> Commit
>
>   ac3baea883dab ("drm/panel: find_panel_by_fwnode() return a counted reference")
>
> added this unexpected file:
>
>  drivers/gpu/drm/drm_panel.c.orig

So this has been reported before for drm-misc [1] and drm-xe [2] trees,
and has been fixed in the drm-misc tree by commit 651b0bd0922b
("drm/panel: remove accidentally committed .orig file").

Similar to what Joonas said in [3], this should really only be reported
once for the tree *and* branch where it originated. There's not a lot of
value in reporting again whenever something gets merged somewhere else.


BR,
Jani.


[1] https://lore.kernel.org/r/al9cE1PAYd9jyCfZ@sirena.org.uk
[2] https://lore.kernel.org/r/annCRqegoQ9PBClJ@sirena.org.uk
[3] https://lore.kernel.org/r/178712337932.24680.17671628229026350089@jlahtine-mobl

-- 
Jani Nikula, Intel
