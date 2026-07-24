Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4BBC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 19:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A777C10E085;
	Fri, 24 Jul 2026 19:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R2cQLEyj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16A710E085
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 19:48:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E9AAE41FB4;
 Fri, 24 Jul 2026 19:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D674C1F000E9;
 Fri, 24 Jul 2026 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784922492;
 bh=Xgjdyft+OKEQ3BRd9E0FjAMVZAURtSGF812mlpI1u9c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=R2cQLEyjYgkITQsGt3xdflVXjKM9Iw/P93FdIIIxmAFUqAHguKarCA5nNrGmuXoCh
 4DiRfri1DhiNxQRD4DPyFdliKOh7txhvdhS5E+qtqNoptkOS0j576wp3on/rZzqmcI
 tQ5NK6HLEWIq1i4hFWptquEL5naCcFmidLluFwNqY6+T/eUcaDTPqm0eig1vR1Tl2c
 w2E6gT8RxUCd3jM73dkoxQDzOsYzVK7VhsBNqFcseOqEuZX9c0R72k0E62vXHwe4NE
 i5qhweEGNqohCGQ38C9E5t56kgtI3dr4MmEnjEtdmjL5W7ami4DdlPTwuXHWnZklNY
 Y2ft3xnrmDDOw==
Date: Fri, 24 Jul 2026 12:48:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, linux-next@vger.kernel.org
Subject: Re: Semantic conflict between 04b177544a04 in drm-misc-fixes and
 0b6b1bb28482 in -mm
Message-ID: <20260724194808.GA1461047@ax162>
References: <20260722225605.GA1910198@ax162>
 <amFPJc1NQbuYWlSp@gsse-cloud1.jf.intel.com>
 <20260723212724.GA999236@ax162>
 <20260723160942.b58b065d771401aba117bc77@linux-foundation.org>
 <amKftG6NRZy0Ii2/@gsse-cloud1.jf.intel.com>
 <93289e91-ef9f-4786-bf49-e93d91afc1ad@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93289e91-ef9f-4786-bf49-e93d91afc1ad@sirena.org.uk>
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

On Fri, Jul 24, 2026 at 01:13:42AM +0100, Mark Brown wrote:
> On Thu, Jul 23, 2026 at 04:11:48PM -0700, Matthew Brost wrote:
> > On Thu, Jul 23, 2026 at 04:09:42PM -0700, Andrew Morton wrote:
> 
> > > I'm fine the drm people changing things ;)
> 
> > I'll jump make a DRM change so this is all worked out when it gets to
> > Linus.
> 
> So should I drop Nathan's fixup then?

As you may or may not have seen yet, the drm commit has been reverted in
the drm-misc-fixes branch, so my change should no longer apply.

-- 
Cheers,
Nathan
