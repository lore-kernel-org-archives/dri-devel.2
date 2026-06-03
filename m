Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A80CD6E56
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 11:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5CB10FC47;
	Wed,  3 Jun 2026 11:22:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Oqbe4IoG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6047D10FC45;
 Wed,  3 Jun 2026 11:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780485725; x=1812021725;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WplGegAqOqVLUgzSJDiNs44x8wdGWkaQMGv6rMEFnOI=;
 b=Oqbe4IoGiSSMOtISA00Yh50V+oWZ/O1ROt08Ia23TzjaYMP0qM8pO/v3
 541CC9d5q4sIzKYWt5keNF/Yj7KcXS8jW4gUA+tjEiwiyH/kC7BmytSsK
 xJr1n75YrBEVzbhcs1TWD3u+x0tognh3l7FEyrdu6g8z+P8VrYaqCFKdn
 76c+bqSXpDl2pkQIMw8kyz7sJnacG2Oa1N7l91rxy0bpoBsmXsVQgGudS
 sY5wpa8rFWmjgIeGl0fs+pogXo8Ub+0mBuyUKx3Z3YZd7FoMct4yBUFyT
 LCN/fep/25TW8i3hh03EPo9q+8tWFoujxMhuaKafiA8d6q7Ev9MOGRE4D A==;
X-CSE-ConnectionGUID: u8elsFvFSrKqITwYLd5a/Q==
X-CSE-MsgGUID: HFhArhPEQBmRZUfjLFMzjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81029780"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="81029780"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 04:22:05 -0700
X-CSE-ConnectionGUID: 0UtUofyxSPK0kh3wnS/Vbw==
X-CSE-MsgGUID: vmtVxeQYRHKfizTVgCZNpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="244287695"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 04:22:01 -0700
Date: Wed, 3 Jun 2026 13:21:57 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v6 3/5] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Message-ID: <aiAOVcoDXxAZXfVM@black.igk.intel.com>
References: <20260520113351.171119-7-mallesh.koujalagi@intel.com>
 <20260520113351.171119-10-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520113351.171119-10-mallesh.koujalagi@intel.com>
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

On Wed, May 20, 2026 at 05:03:55PM +0530, Mallesh Koujalagi wrote:
> When ``WEDGED=cold-reset`` is sent, it indicates that the device has
> encountered an error condition that cannot be resolved through other
> recovery methods such as driver rebind or bus reset, and requires a
> complete device power cycle to restore functionality.

...

> +Example - cold-reset
> +--------------------
> +
> +Udev rule::
> +
> +    SUBSYSTEM=="drm", ENV{WEDGED}=="cold-reset", DEVPATH=="*/drm/card[0-9]",
> +    RUN+="/path/to/cold-reset.sh $env{DEVPATH}"
> +
> +Recovery script::
> +
> +    #!/bin/sh
> +
> +    [ -z "$1" ] && echo "Usage: $0 <device-path>" && exit 1
> +
> +    # Get device
> +    DEVPATH=$(readlink -f /sys/$1/device 2>/dev/null || readlink -f /sys/$1)
> +    DEVICE=$(basename $DEVPATH)
> +
> +    echo "Cold reset: $DEVICE"
> +
> +    # The PCI core exposes a 'slot' symlink on the device that sits in a
> +    # registered hotplug slot. Use it directly instead of scanning every
> +    # slot on the system.
> +    SLOT=""
> +    if [ -L "$DEVPATH/slot" ]; then

I think we'll need to iterate through the hierarchy to find it.

Raag

> +	    SLOT=$(basename "$(readlink -f "$DEVPATH/slot")")
> +    fi
> +
> +    if [ -n "$SLOT" ]; then
> +	echo "Using slot $SLOT"
> +
> +	# Remove device
> +	echo 1 > /sys/bus/pci/devices/$DEVICE/remove
> +
> +	# Power cycle slot. A platform-specific settle delay may be required
> +	# between power off and power on; tune to the hardware as needed.
> +	echo 0 > /sys/bus/pci/slots/$SLOT/power
> +	echo 1 > /sys/bus/pci/slots/$SLOT/power
> +
> +	# Rescan
> +	echo 1 > /sys/bus/pci/rescan
> +	echo "Done!"
> +    else
> +	echo "No slot found"
> +    fi
> +
>  Customization
>  -------------
>  
> -- 
> 2.34.1
> 
