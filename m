Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B9DC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9D910EEAF;
	Wed, 19 Aug 2026 19:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Yp3ybvdD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5CC510EEC6
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787169338; x=1818705338;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Om0C0P/jyLplOSk5sCZOjEhBr4SLAm0QDer43b+YxsI=;
 b=Yp3ybvdDgSnHFZUvujOsuX1encmEV65WKdh2aubCQidJjxSPxWCq6Km0
 5HBmTH709CcJ4NoxViIKRIUgpG5ajwyK1SXHYI/UUWZiWUq3lC5/m2bEV
 PYQn4riNXMbg8T84HZb4h1yVgD+b/f1WT2FYlC+cG/BoKjohmj8QFrLk2
 WNBesjhD7dUthhHbvnrshqH4ksb8MvNrE9ppdakvXycwVFe4b3mgqy1UT
 A6ufSRNanZBxboJ0KftjfuWnh9AYzPA5Vk+zImDSivgFBdleZa4gsqF7z
 Pe65zGXqkkh++hJqBXBCyZy2j078W3jOp90eI0Qu26Q0FwGBn1y8GqXNr Q==;
X-CSE-ConnectionGUID: 5rsvu9z7Q4Sl4jPHOY9dCA==
X-CSE-MsgGUID: 395K6kglTCaZ8hoDo0mSeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="99054447"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="99054447"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 12:55:37 -0700
X-CSE-ConnectionGUID: 4C5kTeAGT9ui21HPGookxw==
X-CSE-MsgGUID: WsLsIpUdSy2fuXRr9s29Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="267599356"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 12:55:34 -0700
Date: Wed, 19 Aug 2026 21:55:31 +0200
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
Message-ID: <aoYKM0xKzcwvu3Tc@black.igk.intel.com>
References: <20260818133610.496374-2-mallesh.koujalagi@intel.com>
 <aoUxBx5mNi7o3K3L@black.igk.intel.com>
 <56c19f54-529f-4e91-9859-5add0afe0891@intel.com>
 <aoWK5PnCNDJYHFv9@black.igk.intel.com>
 <685c687f-3f84-4af7-af23-452c2a1b2b3d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685c687f-3f84-4af7-af23-452c2a1b2b3d@intel.com>
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

On Wed, Aug 19, 2026 at 04:38:57PM +0530, Mallesh, Koujalagi wrote:
> On 19-08-2026 04:22 pm, Raag Jadav wrote:
> > On Wed, Aug 19, 2026 at 03:48:31PM +0530, Mallesh, Koujalagi wrote:
> > > On 19-08-2026 09:58 am, Raag Jadav wrote:
> > > > On Tue, Aug 18, 2026 at 07:06:11PM +0530, Mallesh Koujalagi wrote:
> > > > > event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
> > > > > The original scnprintf()-based loop required a manual pre-flight
> > > > > bounds check.
> > > > > 
> > > > > Replace the manual bookkeeping with seq_buf, which tracks overflow
> > > > > internally. seq_buf_printf() writes each "method," token into the
> > > > > buffer.
> > > > > 
> > > > > On overflow, len retains the position of the last
> > > > > successful write, so the trailing comma is stripped cleanly without
> > > > > including any partial method name in the uevent payload.
> > > > > 
> > > > > Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
> > > > This actually doesn't fix anything, it just adds a WARN() splat.
> > > > So I'm not sure if this is needed here.
> > > In previous implementation multiple recovery methods may exceed
> > > WEDGE_STR_LEN (32) that
> > > 
> > > cause silently truncate a recovery method and emit a malformed uevent string
> > > containing a
> > > 
> > > partial token, however using seq_buf makes overflow
> > > 
> > > explicit, when it occurs, emits a WARN and include complete recovery name
> > > 
> > > in the uevent string so IMO, it's fix.
> > Is there an existing drm_dev_wedged_event() user that is facing this
> > issue? Please attach bug reports along with reproducers (if any).
> 
> Currently Sashiko is already reported that issue, here is details:
> 
> https://sashiko.dev/#/patchset/20260720101815.526813-5-mallesh.koujalagi%40intel.com
> 
> > 
> > Improvements are good, but not everything is a bug because AI said so :)
> 
> Agreed!, however in future, if we support multiple recovery method,
> definitely we encounter such issue.

Which would still fail with this patch applied because WEDGE_STR_LEN
remains the same.

So again. This isn't really fixing anything, it's just a robust refactor.

Raag
