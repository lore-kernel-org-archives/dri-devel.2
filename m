Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846F0CD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9237710E0F3;
	Wed, 20 May 2026 10:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nkfqvHA+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6E310E0AD;
 Wed, 20 May 2026 10:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779274045; x=1810810045;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=NTgvPjhiKspj+D9RnFquYPNFWhEnUeUjx20h+WwV/f4=;
 b=nkfqvHA+rpszeNjUKHuWiUQxvEbebPe7d8XBvQEGkCl70AWDNtg47Gm7
 jGoj6pez9Hv7EleFKlI5s4qQEyNxtwlBE0OggHPjU9WpuEXpwBbTmImDF
 Yzf4qy1L9C0GGylGZgLDoxMFNkZjE4XpRh1MrP+2SRalYhKXhm0QEmIMK
 t0/7TcKk8rWBG9+4r7kUQsRgH0IzNWu5yIR3/X+GqZRmvCVg46AGZFZKw
 oxbGk+/TUKSffPnoJ27e1oulsRW+msQzDXKcvndFYXyLxeNzYRRe5GcJw
 kp6bdRzhuHw7a/Ad5W3IqOF9IEuE/bkc1yR9OiyQ6fpxMVR7GIrnlX59D g==;
X-CSE-ConnectionGUID: vjr3Tx7nSTmI3HZR+yLHDg==
X-CSE-MsgGUID: o2rMOYW/SyK4SurL14f0kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80285847"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="80285847"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:47:25 -0700
X-CSE-ConnectionGUID: 24HCvk+IRAGnSo3Cu2V3Yw==
X-CSE-MsgGUID: xqn//TLZRUaqqiuJmJ6Xew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="263927334"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:47:22 -0700
Date: Wed, 20 May 2026 12:47:19 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v5 3/5] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Message-ID: <ag2RNz2n81uUQJE0@black.igk.intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
 <20260512132614.1793083-10-mallesh.koujalagi@intel.com>
 <agWM41MpCMqDt4mb@black.igk.intel.com>
 <d3ef7dd8-afa8-4e2a-a691-b2c2ab9a88fd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3ef7dd8-afa8-4e2a-a691-b2c2ab9a88fd@intel.com>
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

On Wed, May 20, 2026 at 03:20:51PM +0530, Mallesh, Koujalagi wrote:
> On 14-05-2026 02:20 pm, Raag Jadav wrote:
> > On Tue, May 12, 2026 at 06:56:18PM +0530, Mallesh Koujalagi wrote:
> > > When ``WEDGED=cold-reset`` is sent, it indicates that the device has
> > > encountered an error condition that cannot be resolved through other
> > > recovery methods such as driver rebind or bus reset, and requires a
> > > complete device power cycle to restore functionality.

...

> > > +	# Power cycle slot
> > > +	echo 0 > /sys/bus/pci/slots/$SLOT/power
> > > +	sleep 2
> > Is this tested on actual machine? Is there an explanation for the amount
> > of sleep needed that serves all cases generically?
> 
> Honestly acknowledges! point, the original sleeps  were guesses and there is
> not a
> 
> single value that's correct across all the platforms (it's depends on the
> slot controller,
> 
> downstream link etc.). I'll remove both sleeps in next version.

Rather, explain it with a small comment here.

Raag
