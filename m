Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BF2F327B0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4857410E834;
	Tue, 21 Apr 2026 08:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UBpm2f32";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFECE10E831;
 Tue, 21 Apr 2026 08:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776760264; x=1808296264;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OEr8gEOjl48zeUjxd/sTOHsa316dgDwWJRI62ZmoQTw=;
 b=UBpm2f32mPyzzrk9Vor75c+UOsOQ4f7Nss8851ki5CD9zXFYxByDNznl
 lLQW6/HejeoJID2rLmAp4dbXZZpQxSPp23NXdi66cC7lD9TjpmsikMYkh
 vQL7s2xQeXNTq0X7lditt07T4NA/MhvKEosW1hykKrw9vsmkjOeArSJkE
 2k/xiVcq0HBcwuxDSEDWS9O0kYRSBZHC67o6gFGFdtRjjUkfFrlqN+p2f
 Wtp7arXCYTCoLeq3EQ50VTKhNyiMnF3WaFShzDXc/5vLuYpi5HuTSGKgp
 sOY6wTyRVTa7QKFt6AWc0HdJZFDRWTs8wbc62vTeG53fTzsD3q79SO9n9 g==;
X-CSE-ConnectionGUID: bYG/mx6zSkugAqNYQI3bOA==
X-CSE-MsgGUID: C+NPUNnPRC+1XKdMKmrI9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="87990258"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="87990258"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 01:31:03 -0700
X-CSE-ConnectionGUID: mjzoRJV3Te2J0Uk0q/uVPQ==
X-CSE-MsgGUID: sT5Pq+gMRn+JHz1Wegvk6w==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 01:30:59 -0700
Date: Tue, 21 Apr 2026 10:30:56 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v4 3/4] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Message-ID: <aec1wAFHMZyb9sFW@black.igk.intel.com>
References: <20260413133013.560239-6-mallesh.koujalagi@intel.com>
 <20260413133013.560239-9-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413133013.560239-9-mallesh.koujalagi@intel.com>
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

On Mon, Apr 13, 2026 at 07:00:17PM +0530, Mallesh Koujalagi wrote:
> When ``WEDGED=cold-reset`` is sent, it indicates a non-recoverable

This looks like "cold-reset" should be able to recover it, so is it
really non-recoverable? ;)

> device error, only a full power cycle can restore the device.
> 
> v2:
> - Add several instead of number to avoid update. (Jani)
> 
> v3:
> - Update document with generic scenario. (Riana)
> - Consistent with terminology. (Raag)
> - Remove already covered information.
> 
> v4:
> - Update doc. (Raag/Riana)
> - Change commit message. (Raag)
> 
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>  Documentation/gpu/drm-uapi.rst | 60 +++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 579e87cb9ff7..0b87c8ed760d 100644
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
> +    cold-reset      unbind + remove device + slot power cycle + rescan

Do you need to unbind if you're already removing the device?

>      unknown         consumer policy
>      =============== ========================================
>  
> @@ -447,6 +448,14 @@ debug purpose in order to root cause the hang. This is useful because the first
>  hang is usually the most critical one which can result in consequential hangs
>  or complete wedging.
>  
> +Cold Reset Recovery
> +-------------------
> +
> +When ``WEDGED=cold-reset`` is sent, it indicates a non-recoverable device error,
> +only a full power cycle can restore the device.

This was phrased much better in last rev, not sure why changed?

> +This method is used by devices that are plugged directly into the PCIe slot.

... which supports removing the power.

>  Vendor Specific Recovery
>  ------------------------
>  
> @@ -524,6 +533,55 @@ Recovery script::
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

This looks like too much is happening here, can we try to simplify a bit?

> +    if [ -n "$SLOT" ]; then
> +	echo "Using slot $SLOT"
> +
> +	# Unbind driver
> +	[ -e "/sys/bus/pci/devices/$DEVICE/driver" ] && \
> +	echo "$DEVICE" > /sys/bus/pci/devices/$DEVICE/driver/unbind 2>/dev/null

Is this really needed?

Raag

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
