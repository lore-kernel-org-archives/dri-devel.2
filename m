Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1F0C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C919D10E2CC;
	Wed, 19 Aug 2026 10:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JRZHjUa0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F3810E2CC
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787136747; x=1818672747;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TtEbx43RxDxGdKpl/rvPyRCrNRlLj1n6MMA2ceL11Vg=;
 b=JRZHjUa0MbyMY/LznYE9HsLjZMWJERagKzPUINlv+j12Z7aZGSsDarQI
 jaDNoJaD4IVfanXTHnhDvaMQ0znm2NgB7oGxxWJ9xVmzSPs5Aq1qGwMfq
 WuBmmX14IUkK7KSOXCcpSjxjHDJbBxudkUSu4aelAkOlucsIMU+0ysJvB
 G23tCVZQSGbiuaBzzgP4PKcfe6w0ytFSl+KblJmLp8XfZAJdCmT35G3bE
 p1V6HcGLPr2t/QGtRocXnMXxcAiv+uCeWXBakC8XhFx4INhbHH+R6MVPI
 sKZWcy/Zh6dGVm7ifjuKNHVVImw0cfSxmF4BbFmsoG1HcEpu9vURGqic2 A==;
X-CSE-ConnectionGUID: ncDKwNmqSc+87Jjz75bEng==
X-CSE-MsgGUID: UtFYHCkWRJ+/R7rVgpjh8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87565376"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87565376"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 03:52:27 -0700
X-CSE-ConnectionGUID: GhQGpXXISruk0W+M+4yIeA==
X-CSE-MsgGUID: VA0hyc3gScWjNmpNsWaSqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="265058347"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 03:52:23 -0700
Date: Wed, 19 Aug 2026 12:52:20 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com,
 riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, jani.nikula@linux.intel.com
Subject: Re: [PATCH v5] drm/drv: Convert wedged event string building to
 seq_buf
Message-ID: <aoWK5PnCNDJYHFv9@black.igk.intel.com>
References: <20260818133610.496374-2-mallesh.koujalagi@intel.com>
 <aoUxBx5mNi7o3K3L@black.igk.intel.com>
 <56c19f54-529f-4e91-9859-5add0afe0891@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56c19f54-529f-4e91-9859-5add0afe0891@intel.com>
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

On Wed, Aug 19, 2026 at 03:48:31PM +0530, Mallesh, Koujalagi wrote:
> On 19-08-2026 09:58 am, Raag Jadav wrote:
> > On Tue, Aug 18, 2026 at 07:06:11PM +0530, Mallesh Koujalagi wrote:
> > > event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
> > > The original scnprintf()-based loop required a manual pre-flight
> > > bounds check.
> > > 
> > > Replace the manual bookkeeping with seq_buf, which tracks overflow
> > > internally. seq_buf_printf() writes each "method," token into the
> > > buffer.
> > > 
> > > On overflow, len retains the position of the last
> > > successful write, so the trailing comma is stripped cleanly without
> > > including any partial method name in the uevent payload.
> > > 
> > > Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
> > This actually doesn't fix anything, it just adds a WARN() splat.
> > So I'm not sure if this is needed here.
> 
> In previous implementation multiple recovery methods may exceed
> WEDGE_STR_LEN (32) that
> 
> cause silently truncate a recovery method and emit a malformed uevent string
> containing a
> 
> partial token, however using seq_buf makes overflow
> 
> explicit, when it occurs, emits a WARN and include complete recovery name
> 
> in the uevent string so IMO, it's fix.

Is there an existing drm_dev_wedged_event() user that is facing this
issue? Please attach bug reports along with reproducers (if any).

Improvements are good, but not everything is a bug because AI said so :)

Raag
