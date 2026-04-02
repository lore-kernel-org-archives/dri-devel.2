Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7795BCC6B1D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A8010F110;
	Thu,  2 Apr 2026 08:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aT6zBjWV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED1BA10F09C;
 Thu,  2 Apr 2026 08:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775117821; x=1806653821;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/K4KSBGJKLh1E6i7z3ecuB004elFmRgsg2MEWaWlZsg=;
 b=aT6zBjWVK36kgBlBWlEBr2Jl31x24IwNB/xiHFkJVu0j7zE4HPF7urHq
 yLgNlHRD5alT24ijcMt6Ie7NoNsGw1tUA/RQb7x0o3OCKuiAqNNMa3iFa
 nptt6lKiDZP4+IMKSGs2pKNfPxF2mZuBFwLxIVP2Es38QSnfE9u9V5o23
 J49zVZ+jhBmm9hONR0fb94DP91ZnRDmcByR79geAzBbel8T2ByBrgLOTW
 x/+oDCXe3+qR7BR4pc7G7jOnogXNwOo7w53aBRLl0QerB2ePFj/lcaX+C
 VStk0cYNQTjjbL6f/9X+WDBuXQXRZe+3kxFN30IvPM2F7pLNOvqhSMTAD g==;
X-CSE-ConnectionGUID: oepKUOJ7QaqvoC3ftSl3eg==
X-CSE-MsgGUID: 7+FZt3giS8mVLCAG83XZlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="78764145"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="78764145"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:17:00 -0700
X-CSE-ConnectionGUID: rXz/U5RQSAOR6Y6PRiTznw==
X-CSE-MsgGUID: sJcUnaEfTUmfM/oTPNhc1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="250122959"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:16:57 -0700
Date: Thu, 2 Apr 2026 10:16:54 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v2 3/5] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Message-ID: <ac4l9rpozGzrIrGP@black.igk.intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
 <20260318064016.374656-10-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318064016.374656-10-mallesh.koujalagi@intel.com>
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

On Wed, Mar 18, 2026 at 12:10:20PM +0530, Mallesh Koujalagi wrote:
> Add documentation for the DRM_WEDGE_RECOVERY_COLD_RESET recovery
> method introduced for handling power management unit errors. This method is
> designated for severe errors that compromise core device functionality
> and are unrecoverable via recovery mechanisms such as driver reload or PCIe
> bus reset. The documentation clarifies when this recovery method should be
> used and its implications for userspace applications.

Aesthetic nit: We usually try to utilize the full 75 character space where
possible (in all patches).

> v2:
> - Add several instead of number to avoid update. (Jani)
> 
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>  Documentation/gpu/drm-uapi.rst | 73 +++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index d98428a592f1..5b63f1c17b9b 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -418,7 +418,7 @@ needed.
>  Recovery
>  --------
>  
> -Current implementation defines four recovery methods, out of which, drivers
> +Current implementation defines several recovery methods, out of which, drivers
>  can use any one, multiple or none. Method(s) of choice will be sent in the
>  uevent environment as ``WEDGED=<method1>[,..,<methodN>]`` in order of less to
>  more side-effects. See the section `Vendor Specific Recovery`_
> @@ -435,6 +435,7 @@ following expectations.
>      rebind          unbind + bind driver
>      bus-reset       unbind + bus reset/re-enumeration + bind
>      vendor-specific vendor specific recovery method
> +    cold-reset      full device cold reset required

Does this work without unbind + bind?

>      unknown         consumer policy
>      =============== ========================================
>  
> @@ -446,6 +447,27 @@ telemetry information (devcoredump, syslog). This is useful because the first
>  hang is usually the most critical one which can result in consequential hangs or
>  complete wedging.
>  
> +Cold Reset Recovery
> +-------------------
> +
> +The ``WEDGED=cold-reset`` event indicates that the device has encountered
> +power management unit errors that affect core functionality that cannot be
> +resolved through recovery mechanisms.

Here cold-reset itself is introduced as a recovery method, so this could
use better phrasing. Also, we try to be consistent with terminologies
already in place so that the document is easy to follow.

> +This recovery method is reserved for power management unit error conditions where the
> +device state cannot be restored via:
> +
> +- Driver unbind/rebind operations
> +- PCIe bus reset and re-enumeration
> +- Device Function Level Reset (FLR)
> +- Warm device resets

These are already documented so not sure if it's worth repeating them.

> +Such power management unit error state typically persists across all software-based
> +recovery attempts. Only a complete device power cycle can restore
> +normal operation.
> +
> +Upon receiving a ``WEDGED=cold-reset`` event, userspace should initiate
> +a full cold reset of the affected device to restore functionality.

This is already covered in consumer expectations so can be dropped.

AI assistance is useful at times but we'd want to make sure that things
remain objective and translatable ;)

Raag

>  Vendor Specific Recovery
>  ------------------------
> @@ -524,6 +546,55 @@ Recovery script::
>      echo -n $DEVICE > $DRIVER/unbind
>      echo -n $DEVICE > $DRIVER/bind
>  
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
> +    # Try slot power reset first
> +    SLOT=$(find /sys/bus/pci/slots/ -type l 2>/dev/null | while read slot; do
> +	    ADDR=$(cat "$slot" 2>/dev/null)
> +	    [ -n "$ADDR" ] && echo "$DEVICE" | grep -q "^$ADDR" && basename $(dirname "$slot") && break
> +    done)
> +
> +    if [ -n "$SLOT" ]; then
> +	echo "Using slot $SLOT"
> +
> +	# Unbind driver
> +	[ -e "/sys/bus/pci/devices/$DEVICE/driver" ] && \
> +	echo "$DEVICE" > /sys/bus/pci/devices/$DEVICE/driver/unbind 2>/dev/null
> +
> +	# Remove device
> +	echo 1 > /sys/bus/pci/devices/$DEVICE/remove
> +
> +	# Power cycle slot
> +	echo 0 > /sys/bus/pci/slots/$SLOT/power
> +	sleep 2
> +	echo 1 > /sys/bus/pci/slots/$SLOT/power
> +	sleep 1
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
