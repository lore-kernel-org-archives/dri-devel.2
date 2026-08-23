Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541DDC5DF81
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 04:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F08AE10E456;
	Sun, 23 Aug 2026 04:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CG1X0zgf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4C110E456
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 04:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787458886; x=1818994886;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=v2pzVfzI7W4iCaBlsp4COLv3kQ8ZXwSlHg1dGbkpQ6o=;
 b=CG1X0zgf3jqdD3OvLlZuxkf5sTqNbj5ruU0w77xNdvZs1SkgLk/CdTle
 xi3AfAnFjS5ScS2SorUcKXr6JUwAVfcinaLuMZhuHwlLIcQtNgla+UOor
 x/AQkS3siOeI2wjyvUIiJwnT5GbHTC8YeGUxlHJ8stizOwOAbzzWlPJO5
 XxfBDGu/8lEubV3ht0eutQ2EqbzvmvHR/O0gUwdazt3EsywhSpcGf06ji
 092g+5PR6wEzsGbrO27e2GXkPZ3JvGPYFj0b+/QOwH1K+spXC0BEg3Ty1
 bl0b49BC9Lt5vAE0RAN7a4DA0ZuIowct1nNxlpizErph1/dnilnlRm5y+ A==;
X-CSE-ConnectionGUID: a5nzWp/4S+Sltqm5lIaLLQ==
X-CSE-MsgGUID: 76Q3DmLKSoChWLvrEEN0AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="105326442"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="105326442"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2026 21:21:25 -0700
X-CSE-ConnectionGUID: 1PtCYm3sTNCiFTJkGj+MXg==
X-CSE-MsgGUID: 1j5JGDhCSDyNojiEcoNYfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="260542045"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2026 21:21:22 -0700
Date: Sun, 23 Aug 2026 06:21:19 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com,
 riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, jani.nikula@linux.intel.com
Subject: Re: [PATCH v6] drm/drv: Convert wedged event string building to
 seq_buf
Message-ID: <aop1P1xK9fB90AzQ@black.igk.intel.com>
References: <20260823003349.587495-2-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823003349.587495-2-mallesh.koujalagi@intel.com>
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

On Sun, Aug 23, 2026 at 06:03:50AM +0530, Mallesh Koujalagi wrote:
> event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
> The original scnprintf()-based loop required a manual pre-flight
> bounds check.
> 
> Replace the manual bookkeeping with seq_buf, which tracks overflow
> internally. seq_buf_printf() writes each "method," token into the
> buffer.
> 
> On overflow, a warning is issued, len retains the position of the
> last successful write, so the trailing comma is stripped cleanly
> without including any partial method name in the uevent payload.
> 
> Assisted-by: Claude:claude-Sonnet-4.6
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
