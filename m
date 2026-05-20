Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB97CD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203D210E270;
	Wed, 20 May 2026 10:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eppgyzWJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9325F10E270;
 Wed, 20 May 2026 10:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779274591; x=1810810591;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EVLS3bnRNYDUAIGB4KwuSCa1Sug/uhGOfw3jecBETjQ=;
 b=eppgyzWJuMZEebK95zNgTDcuXt/mhTIqaDMo4ZJFETdTvRr8rdTD7647
 9Mjdg0mv8xDPF2ZoOEt4DxnqwERqSGvlR0JWoGZGyT1KIL9Sl8q/QyCkP
 MRnILnF4SjNvzkFZOfneyBjV9r5S4qu0BQssQOnenhs8iwnkD/1FJ0dxa
 FLZUsF/koDoc7ILETUKpiAZc/1Wx/9IS3P+mSAtIahVR0elMU/0UyH+6C
 gQ3LtNEyujCAF6/GuFB4/Wf1q4Tj7x7nGUsmu5ZkAx/Jcvt0znhEaNGCF
 J+BPxHDLpzitg43a/cLYEILhb6I0YNbfkMxF/tDM6ZWcg8/IPvKTINNus w==;
X-CSE-ConnectionGUID: PohoYy3vQ+qPjKDTwt/adg==
X-CSE-MsgGUID: +LWGLGC6SlWv4dT+AnhMAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83785176"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="83785176"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:56:31 -0700
X-CSE-ConnectionGUID: vs4fyjU7QEyf8eSwEgTO5g==
X-CSE-MsgGUID: snC0DJfpQy+6Y28KMeLVgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="237142445"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:56:27 -0700
Date: Wed, 20 May 2026 12:56:24 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v5 5/5] drm/xe: Suppress Surprise Link Down on
 non-hotplug device
Message-ID: <ag2TWK3l9QOiHCXs@black.igk.intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
 <20260512132614.1793083-12-mallesh.koujalagi@intel.com>
 <agWJbWQXA9XJnool@black.igk.intel.com>
 <cc73f8fd-19d3-48ca-9c1a-d645462e5286@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc73f8fd-19d3-48ca-9c1a-d645462e5286@intel.com>
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

On Wed, May 20, 2026 at 04:03:42PM +0530, Mallesh, Koujalagi wrote:
> On 14-05-2026 02:05 pm, Raag Jadav wrote:
> > On Tue, May 12, 2026 at 06:56:20PM +0530, Mallesh Koujalagi wrote:
> > > If the slot is not hotplug capable, pcie_suppress_surprise_link_down()
> > > masks the Surprise Link Down bit (PCI_ERR_UNC_SURPDN) in the USP's AER
> > > Uncorrectable Error Mask register before punit_error_handler()
> > > triggers the cold reset.

...

> > > +#ifdef CONFIG_PCIEAER
> > > +static bool pcie_slot_is_hotplug_capable(struct pci_dev *usp)
> > Shouldn't all of it be part of xe_pci_error.c?
> Happy to relocate if/when a second caller appears,
> but for now keeping them next to their sole user in xe_ras.c
> seems cleaner. Open to other opinions though.

We usually add the code to the component it's closest to, i.e. all the
PCI stuff in xe_pci* files, but I'll leave it to you all.

Raag
