Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF07C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C922210E752;
	Mon,  7 Sep 2026 10:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Y/lha7Xw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F22010E750;
 Mon,  7 Sep 2026 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788776213; x=1820312213;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=koOpTUb6YTdsPAfmxU0F4QcjTxU9LKAdIwUkd4Ok940=;
 b=Y/lha7XwvTifd7+uBJMRm3+B2GVfiooSZ1C5eiZpmfGMZsLZ0aI1vN6k
 diL0Ap7/UWVLhF9K2PsY6sAeWDF5pFo9zLa16BJLAuz03CLbhGaaMNrAX
 AtfDpp0y1dmIFmJ1dr3qZGtFhQA1NDfIncvirX4WXTvCWV4g14KlUOwVZ
 mtnuCPdfCEctueHaY3FTQ7NHGuAcg/C4BAS6xmn9XPS+n/gVkfPPGuud3
 wgHdTfkMTD1H35UVEHAfuZqkSlHjjnD+lRNem3xmOoNwd808B1blLe3Jh
 RLwQRlgF3VTrQ3RlsyTrQE4sonh8GNC/f9U/RRnECP4aExO0DCkY4BaUG Q==;
X-CSE-ConnectionGUID: yoXkN2zOQy6PsK7iH/CfpA==
X-CSE-MsgGUID: Nanrgl8AQLaigGThQOKbmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89107233"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="89107233"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 03:16:52 -0700
X-CSE-ConnectionGUID: qJOGdW5pRTm0os/SzdFdaA==
X-CSE-MsgGUID: ujSiwgFZSOiYrjw5VVSp9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="267426695"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 03:16:50 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?B?5b6Q5bqG?= <965456495@qq.com>, regressions
 <regressions@lists.linux.dev>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel
 <dri-devel@lists.freedesktop.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] i915: s2idle lid-open resume leaves eDP panel
 black until an input event (Raptor Lake; works on 6.18 LTS)
In-Reply-To: <tencent_8D7EB01E00F5CD0928A0F70A451C586E0608@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <tencent_8D7EB01E00F5CD0928A0F70A451C586E0608@qq.com>
Date: Mon, 07 Sep 2026 13:16:48 +0300
Message-ID: <b366e45424ee2cf3d8bfef3cfb90cf2f5491ad3b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Sun, 06 Sep 2026, "=E5=BE=90=E5=BA=86" <965456495@qq.com> wrote:
> a regression report, following Documentation/admin-guide/reporting-regres=
sions.rst:
>
>
> Regression range: v6.18..v7.2 (last known good: linux-lts 6.18.49-2-lts;
> first tested broken: 7.2.3-arch1-2; intermediate 7.0/7.1/7.2 untested)
>
>
> Symptom:
> After closing the lid (systemd-logind suspends to s2idle) and reopening i=
t,
> the machine resumes fine (kernel resume log clean, ~1 s, Wi-Fi and input
> work), but the internal eDP panel stays on a static black frame. The scre=
en
> only lights up after any input event (key press or mouse move), which then
> triggers the compositor to repaint. Reproducible on every lid cycle with
> kernel 7.2.3; the identical userspace on linux-lts 6.18.49-2-lts does NOT
> show the problem.

Please file a bug report as described at [1].

BR,
Jani.

[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


--=20
Jani Nikula, Intel
