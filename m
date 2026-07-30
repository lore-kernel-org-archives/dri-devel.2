Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BF8C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D464D10E67B;
	Thu, 30 Jul 2026 09:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fy7DR/ui";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38AEE10E67B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785402881; x=1816938881;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=lE6x1kYRC11Y8EI9rsrIsy/POw71Fh+oamWcplWGCwg=;
 b=fy7DR/uiukvfcssWQ5knlwVaYbF2s5DNBpd0hdTfUPxrWfygX0WhU8+x
 5tBG4vbYE1RmW3knQr+PoEfFEmPpdmpzbnnRgChVQOyCSuERBGy11gjvL
 2VFkIuRx5ODPaj3vcacy+u2htaQqEVLWcsz97es8GZEx6UZVfauy5A06y
 okL+gp3OTerwk0HGN/1l9vDlbaAqT13WveNOTSvzVra8K+T6dWdeC/DQu
 l+IIPMciY5VYxBDFANAWWNV/VduuRth9LaxJw9CH+4TwVhbiLUD2ZwoiW
 aE/ZLTmi2evR05yttWL7BJOCcEeSCLM0nOJhoq298qU3f2hxJkQkDa2WD Q==;
X-CSE-ConnectionGUID: 1yyuQ0ikSDSucovJazJBXA==
X-CSE-MsgGUID: ptISTnXuR+qO0fmBoi+k6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103422218"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="103422218"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 02:14:40 -0700
X-CSE-ConnectionGUID: s058yAiBSoyuFUikDnXtMw==
X-CSE-MsgGUID: vnXY6O0kQAGztisBKUuTqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="290203039"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.245.160])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 02:14:34 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, broonie@kernel.org, daniels@collabora.com,
 maarten.lankhorst@linux.intel.com, miguel.ojeda.sandonis@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 penguin-kernel@I-love.SAKURA.ne.jp, tytso@mit.edu, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
In-Reply-To: <20260729214505.185776-2-leandro.ribeiro@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260729214505.185776-1-leandro.ribeiro@collabora.com>
 <20260729214505.185776-2-leandro.ribeiro@collabora.com>
Date: Thu, 30 Jul 2026 12:14:31 +0300
Message-ID: <b2628133dfe020b9e3c74af27a3cfa2525f66223@intel.com>
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

On Wed, 29 Jul 2026, Leandro Ribeiro <leandro.ribeiro@collabora.com> wrote:
> Commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
> with alpha exposed") introduced a WARN() to let driver developers know
> that a previously valid behavior should now be changed.

I should've chimed in way back when, but in retrospect it's a bit
presumptuous to add a commit that puts the burden of the change on the
driver developers, without so much as identifying which drivers or
getting an ack from them.

This is really not unlike the __deprecated attribute, see commit
771c035372a0 ("deprecate the '__deprecated' attribute warnings entirely
and for good"), but this one's runtime not build.

> But WARN() should not be used for that, as it's a kernel warning report
> mechanism for conditions that are not expected to happen. It also
> produces a stack trace. Instead, a simple warning-level log message
> should have been used, as drivers were expected to trigger the
> condition.
>
> This is causing problems for fuzzers, as they may stop when encountering
> a "BUG:" or "WARNING:" in the logs.
>
> Replace WARN() with drm_warn() in this function, avoiding these issues.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")

> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
> ---
>  drivers/gpu/drm/drm_mode_config.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 3bcc7bf0900c..3d9c554e08a8 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -869,8 +869,9 @@ static void validate_blend_mode_for_alpha_formats(struct drm_plane *plane)
>  	for (i = 0; i < plane->format_count; i++) {
>  		fmt = drm_format_info(plane->format_types[i]);
>  		if (fmt->has_alpha) {
> -			WARN(1, "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup",
> -			     plane->base.id, plane->name);
> +			drm_warn(plane->dev,
> +				 "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup",
> +				 plane->base.id, plane->name);
>  			break;
>  		}
>  	}

-- 
Jani Nikula, Intel
