Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B6FFED9EB
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B54410E706;
	Tue, 17 Mar 2026 16:54:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MuOjvBJw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFF010E6FB;
 Tue, 17 Mar 2026 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773766488; x=1805302488;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=Ib7O5v5gA5+SZAFPTs/BlvtXcjkxiVY/HpUZ9MjdV6U=;
 b=MuOjvBJwaxQEXu1Q+PaD2IrDjfvWgaM7oVpcZi9ZhNBeLYiZBvmNG9Sm
 KQZOjBbcJ8kicVdve/LnRls7iihpqI4ALgkEe88MjXYFKRaUjxTd7ohWK
 8sF/7jpIsBWx7eUUtjEAsyEjEEG5R5pP0oW4JEDgHgr0aqIX7acD/fRbA
 nlGPkYy6EHbon1Xef0SHPczRjpjEqlcxz6oilkGFu2aAajv3szNAn0HCR
 G12Pu9NfXT1cWb19uuIXY/Z0h9+0gfJ/7UENEKpF+l5jpYQ358aaCZlDT
 skBheTvrfVvXnBuI+D3taQlAE6hGajPDRKjwJlSYeDljA/GZGFRzrD+MJ g==;
X-CSE-ConnectionGUID: w5Gnb6DxRx6nG7uuTcJXyg==
X-CSE-MsgGUID: Evj1VPN+QCS4eO/NqCwVNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="77416581"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="77416581"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 09:54:47 -0700
X-CSE-ConnectionGUID: ltBood/0QMy4db0yfg64Ag==
X-CSE-MsgGUID: o6tfjkHCRF2AHjT5BZfq4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="222288507"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.161])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 09:54:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 18:54:39 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 irenic.rajneesh@gmail.com, srinivas.pandruvada@linux.intel.com, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 xi.pardee@linux.intel.com, Hans de Goede <hansg@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 06/22] platform/x86/intel/vsec: Plumb ACPI PMT discovery
 tables through vsec
In-Reply-To: <20260313015202.3660072-7-david.e.box@linux.intel.com>
Message-ID: <6fe39305-89cc-c83e-1f60-9807bb8996bf@linux.intel.com>
References: <20260313015202.3660072-1-david.e.box@linux.intel.com>
 <20260313015202.3660072-7-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 12 Mar 2026, David E. Box wrote:

> Some platforms expose PMT discovery via ACPI instead of PCI BARs. Add a
> generic discovery source flag and carry ACPI discovery entries alongside
> the existing PCI resource path so PMT clients can consume either.
> 
> Changes:
>   - Add enum intel_vsec_disc_source { _PCI, _ACPI }.
>   - Extend intel_vsec_platform_info and intel_vsec_device with source enum
>     and ACPI discovery table pointer/
>   - When src==ACPI, skip BAR resource setup and copy the ACPI discovery
>     entries into the aux device.
> 
> No user-visible behavior change yet; this only wires ACPI data through vsec
> in preparation for ACPI-enumerated PMT clients.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---

I took patches up to this one to the review-ilpo-next branch as those are 
basically ready and have seen enough version by now.


-- 
 i.

