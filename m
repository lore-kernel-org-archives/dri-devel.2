Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC73CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A7410E382;
	Thu, 14 May 2026 08:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ITc5R/5o";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C615110E382;
 Thu, 14 May 2026 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778748658; x=1810284658;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=s1GP4zXeY63UPg7GVUSEQehGgvHOEjrwYan0aSI2ca4=;
 b=ITc5R/5ocbfr5+lR3gUNiNUwqIvLwYBJy7vmDtnzSsaenOM9Vc/CboQD
 OCqLrXY+WFkweH1BeT6NeiLBApTo8p6QAbxRcdawsJWq4wEJYPJk/Sw+i
 Rz9JgUiOwGGwX18j91yS0/2D/T34Q0w187ATxKIKtqriiAUvSdxKgE8lB
 TudUW39euDS6Ilv/xPhmZkisSVHbFs5gUmAWq/t9rEVp1gb7X+ubQ16H/
 Yg7LhJ1sqTKmCPVOX1vhwZq91zm/JEhClR52vQmkkLCPf+X5ktgl+CToF
 ThiBzbp/H0Ik1h+EyRm2W8pofS/b+Kd5wIUEz3JOEdJf2CpDPizSkHkNr A==;
X-CSE-ConnectionGUID: nzjh7KTOTV6XJ/xr+gRJPQ==
X-CSE-MsgGUID: ajnCu6uRQoOGhwymygEfMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79717868"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="79717868"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 01:50:49 -0700
X-CSE-ConnectionGUID: q2UoWm4WS/SwG8dcOjyBDw==
X-CSE-MsgGUID: B2mOq6SeRdOuTQupHmu54g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="233894092"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 01:50:46 -0700
Date: Thu, 14 May 2026 10:50:43 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v5 3/5] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Message-ID: <agWM41MpCMqDt4mb@black.igk.intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
 <20260512132614.1793083-10-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512132614.1793083-10-mallesh.koujalagi@intel.com>
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

On Tue, May 12, 2026 at 06:56:18PM +0530, Mallesh Koujalagi wrote:
> When ``WEDGED=cold-reset`` is sent, it indicates that the device has
> encountered an error condition that cannot be resolved through other
> recovery methods such as driver rebind or bus reset, and requires a
> complete device power cycle to restore functionality.
> 
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
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
> - Change commit message.
> 
> v5:
> - Update commit message. (Raag)
> - Remove unbind.
> - Simplify cold-reset script.
> ---
>  Documentation/gpu/drm-uapi.rst | 64 +++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 32206ce62931..809386f16521 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -422,7 +422,7 @@ needed.
>  Recovery
>  --------
>  
> -Current implementation defines four recovery methods, out of which, drivers
> +Current implementation defines several recovery methods, out of which, drivers
>  can use any one, multiple or none. Method(s) of choice will be sent in the
>  uevent environment as ``WEDGED=<method1>[,..,<methodN>]`` in order of less to
>  more side-effects. See the section `Vendor Specific Recovery`_
> @@ -439,6 +439,7 @@ following expectations.
>      rebind          unbind + bind driver
>      bus-reset       unbind + bus reset/re-enumeration + bind
>      vendor-specific vendor specific recovery method
> +    cold-reset      remove device + slot power cycle + rescan
>      unknown         consumer policy
>      =============== ========================================
>  
> @@ -451,6 +452,17 @@ debug purpose in order to root cause the hang. This is useful because the first
>  hang is usually the most critical one which can result in consequential hangs
>  or complete wedging.
>  
> +Cold Reset Recovery
> +-------------------
> +
> +When ``WEDGED=cold-reset`` is sent, it indicates that the device has
> +encountered an error condition that cannot be resolved through other
> +recovery methods such as driver rebind or bus reset, and requires a complete
> +device power cycle to restore functionality.
> +
> +This method is used by devices that are plugged directly into the PCIe slot
> +which supports removing the power.

This looks good to me.

>  Vendor Specific Recovery
>  ------------------------
>  
> @@ -528,6 +540,56 @@ Recovery script::
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
> +    SLOT=""
> +    for addr_file in /sys/bus/pci/slots/*/address; do

This looks like we're peeking into every slot present on the machine which
is not very optimal. Can't we just follow device hierarchy in DEVPATH to
look for the slot that is relevant for us?

> +	    [ -f "$addr_file" ] || break
> +	    addr=$(cat "$addr_file" 2>/dev/null)
> +	    [ -n "$addr" ] || continue
> +	    case "$DEVICE" in
> +		    "$addr"*) SLOT=$(basename "$(dirname "$addr_file")"); break ;;
> +	    esac
> +    done
> +
> +    if [ -n "$SLOT" ]; then
> +	echo "Using slot $SLOT"
> +
> +	# Remove device
> +	echo 1 > /sys/bus/pci/devices/$DEVICE/remove
> +
> +	# Power cycle slot
> +	echo 0 > /sys/bus/pci/slots/$SLOT/power
> +	sleep 2

Is this tested on actual machine? Is there an explanation for the amount
of sleep needed that serves all cases generically?

> +	echo 1 > /sys/bus/pci/slots/$SLOT/power
> +	sleep 1

Ditto.

Raag

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
