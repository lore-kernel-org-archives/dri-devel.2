Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC33CC982CD
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 06:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C5710E638;
	Thu, 17 Sep 2026 06:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Nhqvs3nW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9950B10E638;
 Thu, 17 Sep 2026 06:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789628248; x=1821164248;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=emH1J4cBgiN5T9BbNi7z7yhKApmeSxcgOTtnbUvF3DA=;
 b=Nhqvs3nWjxPy63A9i4ZUptin9VKCY5NdVQQoy6sbt1o4jJFb+ekcGjFd
 y85WZ72Nk7ukAsTp4KvOrhzrtNYJPKShdcxNFl6k9js4Ylt/Pzq9b8x06
 esgOx/W6/sZIDU5bukL54K6BGrErWNaz42/xxP8QUInwj9xDfiGyFmvVY
 NUfZEYMiEnhxyTRQRnfEsLz+AOh7nGTIRL8ALSfBiVrm2hVE9tCOJB/Oz
 TiHqHMA43h7z5ZKINKXiQ9KqKjZ8uzCOLFSMpjg54OuVw8GkzviXWo1e6
 xAE8/91w7iwL6Nus63QodkmKjqXfdyayc8LvtJ0Qcdr/sGbeIPLgQkbBY A==;
X-CSE-ConnectionGUID: MSjeaNLzQNiFg5dC6wvDhQ==
X-CSE-MsgGUID: JNWhsgwvSP6M4i0QDRV+eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93846236"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93846236"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 23:57:25 -0700
X-CSE-ConnectionGUID: 7sCm9ffsTReAiqJK44SzgA==
X-CSE-MsgGUID: 8gnKXQFZRDiQK/kt8e4gZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="269333869"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 23:57:21 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260916171935.2087305-1-vulab@iscas.ac.cn>
References: <20260916171935.2087305-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] drm/i915: Fix vm reference leak in mock_gem_device()
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: andi.shyti@linux.intel.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
 linux-kernel@vger.kernel.org, matthew.d.roper@intel.com,
 rodrigo.vivi@intel.com, simona@ffwll.ch, sujaritha.sundaresan@intel.com,
 tursulin@ursulin.net, Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Date: Thu, 17 Sep 2026 09:57:18 +0300
Message-ID: <178962823827.28653.5098493516220452854@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
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

Quoting Wentao Liang (2026-09-16 20:19:35)
> mock_gem_device() takes a reference on the GGTT vm for gt->vm, but
> neither mock_device_release() nor the setup error paths drop it, unlike
> the real teardown where intel_gt_driver_release() releases gt->vm.
> Drop the reference before mock_fini_ggtt() and on the error paths.
>=20
> Fixes: cdeea858d8df ("drm/i915: Remove unused i915->ggtt")
> Cc: stable@vger.kernel.org

We're not putting Fixes and definitely not Cc: stable for selftest
improvements.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

You clearly did not try to address any of the issues per the surrounding
coding style or understand the severity before Cc stable, but just generated
some static code fixes and commit messages with LLM.

Looking at your history of spamming the LKML with 30+ patches per day
and not a single response for requests to fix things or add the
Assisted-by tag, don't really expect you or even your LLM to read this.
So this reply is more for documentation purposes.

Doesn't really inspire any confidence to merge anything or look at any
further of your multiple patches which you send separately and not in
series in the hopes of getting some merged even when pushback in others.

If I happen to be wrong, let me know.

Regards, Joonas
