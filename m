Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3258C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 04:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B49D10E03E;
	Wed, 19 Aug 2026 04:29:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cMfQ+Nsc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 976D810E03E
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 04:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787113743; x=1818649743;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rlKfpwUBx8v03+Ro2F6w8yjO90dPGa2dNKzHdnSkTlY=;
 b=cMfQ+Nscoz78UiKkP+c0zMHAY8nfc8vYiwEOmT8Y2D2JEYwcT26xsS/u
 1McxqYfJV/uKL5PcETdqNChFGRLCgC0gFPWFuDV784s7yWA3eCiWG8Mi7
 IvED9u6V0DgOT79SLWCM0bg6Mu5gqu4Sk/zRhLYCYqm6GQv6pwYijqb2A
 3md4bKmCrnRPAdqznWQLrDBQmsz4L8dqrjnDvdScE2F7cXHe9audqYZtp
 CKJFiEJA+x7f9NfiKlyFXjoK9lepCOD6R/WKtAFbxLIxEGxhk3wQmtqkO
 Bs8KASxEq69C+dz8JHuFOMBsMTfPPLq1DX7tr/wNCmjhUuehct7yIljTh g==;
X-CSE-ConnectionGUID: pfPpU8UHT+WqYBplxx037g==
X-CSE-MsgGUID: KZILB0m1SUKu3yzSKJIZXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87489727"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87489727"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 21:29:02 -0700
X-CSE-ConnectionGUID: DMkQT5WdRfSam8bYuhNVNg==
X-CSE-MsgGUID: L7SQ8Dv6RhWOwEDN2IfLGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="267390359"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 21:28:59 -0700
Date: Wed, 19 Aug 2026 06:28:55 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com,
 riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, jani.nikula@linux.intel.com
Subject: Re: [PATCH v5] drm/drv: Convert wedged event string building to
 seq_buf
Message-ID: <aoUxBx5mNi7o3K3L@black.igk.intel.com>
References: <20260818133610.496374-2-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818133610.496374-2-mallesh.koujalagi@intel.com>
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

On Tue, Aug 18, 2026 at 07:06:11PM +0530, Mallesh Koujalagi wrote:
> event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
> The original scnprintf()-based loop required a manual pre-flight
> bounds check.
> 
> Replace the manual bookkeeping with seq_buf, which tracks overflow
> internally. seq_buf_printf() writes each "method," token into the
> buffer.
> 
> On overflow, len retains the position of the last
> successful write, so the trailing comma is stripped cleanly without
> including any partial method name in the uevent payload.
> 
> Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")

This actually doesn't fix anything, it just adds a WARN() splat.
So I'm not sure if this is needed here.

> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

Assuming this is tested and there are no regressions.

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
