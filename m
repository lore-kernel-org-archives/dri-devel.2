Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210C1FD5F8E
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83DC610E588;
	Wed,  8 Apr 2026 08:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a/7N/lPh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66EA10E587;
 Wed,  8 Apr 2026 08:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775637287; x=1807173287;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=Z95CjdbwHS0pAgI2+9rZ0GmygT3N2HLDTmrehBn9p14=;
 b=a/7N/lPhapcnoXmL0pCpJvMrCkeQlmf68Hs03lRSJh8Pl6p55MFan3p3
 S3K7Xz+KlJ4i9tmTh9e3Z5E8XWrDZrTZPsUbFebOvUPFHBAxzT35SzbU9
 kAA2KmuTb1QbdImIfqidZUCKDa5kqFD12p4lgvXTjLGpdlGQvnELUhFJ3
 lrP0iM74fhl7r7WH2iohYk+Wntcl5jRgR7G8onu68M1Eib/dhOWRpy7ka
 3iLtOy3d3YZYSPHKedVlZc0KaYBnc+0ERiATcDSmLPcmDMU+DD9fsYq2P
 rsgbTFZ/w1+fa1UWJXEGjpm25G4CvSDYi1IUk5Ac92vLaS2Wh6QV+8OMu A==;
X-CSE-ConnectionGUID: R1A2SNX7QfC6O9kSNwOx9A==
X-CSE-MsgGUID: kvkk9ZY5Ry+Xo7rkON6r3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="99239265"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="99239265"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:34:47 -0700
X-CSE-ConnectionGUID: pfhp5jv3RqObpRsbZUruKw==
X-CSE-MsgGUID: cfqGAIYsQ1yi2s9E6KjhQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="233286588"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:34:45 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260408082859.69823-1-joonas.lahtinen@linux.intel.com>
References: <20260408082859.69823-1-joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH] drm/i915/gem: Don't use VMA from wrong VM in EXECBUF
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>,
 Ville =?utf-8?b?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>
To: Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Date: Wed, 08 Apr 2026 11:34:41 +0300
Message-ID: <177563728194.70530.11694465930209500099@jlahtine-mobl>
User-Agent: alot/0.12.dev7+g16b50e5f
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

There will be no CI results as Linus already has a temporary fix in his
tree which got to drm-tip via the various -fixes trees. But its the same
change suggested by Ville so effectively it's been tested already in
every CI run after incorporating -rc7 to -fixes trees this week.

Regards, Joonas
