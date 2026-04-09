Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5B6EA3C25
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D5410E782;
	Thu,  9 Apr 2026 10:24:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="klzChuTZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86EEA10E77D;
 Thu,  9 Apr 2026 10:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775730294; x=1807266294;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=A5ne7mfOtPom5trDXxrA2WkFZkJcl9vXjEhixiCVQFU=;
 b=klzChuTZivFyk0UnYF1SD6IHlwn2Sp6hf860/iQEtF1KZE693aKZ5MaD
 /Vj3uyJBkrU0BoGZM98P0oYpt5CLcIZsr0NBqiN4Pwg0yYTGkHCVPKvJO
 Rw+VPwKPQvSz+Dbl4iGTcxcl7kLbpVYO4R48TTZQNT4/d5c7MAACUQXVx
 abZ4p9g4oRHJjesIzwwNSxHRUQNiBEXvzHgwMv7fDg/bHvOsCYkcEGa+q
 BdgHG1w8rYvpVhCCAtQGnayo/Uq0q4XvcVukISOqHXjiElHLqdRk2hN8b
 GsUbcp52NiSa+QrT79bb7IldqsbkV3S1Nk1eAL5bk9HuFTzkQ4/smTVOB A==;
X-CSE-ConnectionGUID: jLlnX4VvTvuol+r9UshOMQ==
X-CSE-MsgGUID: PROF0j5VSJqZDVWJzK1H0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76449841"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="76449841"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 03:24:53 -0700
X-CSE-ConnectionGUID: iSTR2pl8Quud9rGUwIiLUg==
X-CSE-MsgGUID: SIWOAyjKQka3Q8G6KmLLyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="228661168"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.151])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 03:24:49 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <add6fPHRC7Bc8Uri@jlahtine-mobl>
References: <add6fPHRC7Bc8Uri@jlahtine-mobl>
Subject: Re: [PULL] drm-intel-fixes
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dim-tools@lists.freedesktop.org
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Date: Thu, 09 Apr 2026 13:24:46 +0300
Message-ID: <177573028627.53749.1013951458023110256@jlahtine-mobl>
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

Quoting Joonas Lahtinen (2026-04-09 13:07:56)
> Hi Dave & Sima,
>=20
> Here's still a drm-intel-fixes PR towards 7.0. Took a few more hours
> as Linus seems to prefer the EXECBUF fix via -fixes rather than -next.
>=20
> One display fix for SU area WARN in PSR code, for GT refcount underflow
> fix in hangcheck and removal condition on execbuf BO processing which
> gives a false alert of a bug in mainline.

Also, if you haven't been following all the discussion, the execbuf
cleanup here removes the need for the fix that Linus applied himself to
v7.0-rc7. This just removes the condition check that is always true,
avoiding false alarm of a bug in current mainline.

Regards, Joonas
