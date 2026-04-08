Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CDBFD5F8E
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C3810E558;
	Wed,  8 Apr 2026 08:01:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LFZ9YJa2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9BA610E553;
 Wed,  8 Apr 2026 08:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775635311; x=1807171311;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=i2yfIxOGb6lqkzYbh3ZOAuNkbIH5wzEswH0/dZvpHzE=;
 b=LFZ9YJa2R2paSZ77vladpRBfJhqczTNlmtB8+4So1Me3RrLFT3N054W0
 RaZ8bLIls2mJwbNdvgdcL6Gp3despBup+OYc6knSpuyHfebq7ncJ46aF6
 ZKMuIWEJ6YUXjUdgFs+1g6hYpli374h0+VEgHJcjrI7EZJN7dNio4RXPq
 1PGG95mTbv6DfBocBfS3JhxRKppf/S85FupxUXm1CBKLPrUvIIkYCMFcW
 jvrdBw/dKzP1FDjhZn+e5i+21JWsm26PM+eJvM9sDtj6v+LaJ+xTOmzEG
 YLTtTR7J8j3VRKDtK8/g1aycr0/CzSoN4nMRjP3eys3BO7DPRn7Ay5C30 Q==;
X-CSE-ConnectionGUID: dTbUwAnIRGy4bqANSXEgig==
X-CSE-MsgGUID: cgw4kEeBTEG1K8kvUEt3Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87996677"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="87996677"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:01:50 -0700
X-CSE-ConnectionGUID: EpmoplCXRTyuK8fwpnnr4g==
X-CSE-MsgGUID: jWoxzPnvQ2+bossyntWlIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="225224380"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:01:48 -0700
Date: Wed, 8 Apr 2026 10:01:45 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v3 3/4] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Message-ID: <adYLaSCnulLnXvOA@black.igk.intel.com>
References: <20260406142325.157035-6-mallesh.koujalagi@intel.com>
 <20260406142325.157035-9-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406142325.157035-9-mallesh.koujalagi@intel.com>
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

On Mon, Apr 06, 2026 at 07:53:29PM +0530, Mallesh Koujalagi wrote:
> Add documentation for the DRM_WEDGE_RECOVERY_COLD_RESET recovery method.
> This method is designated for severe error conditions that compromise core
> device functionality and are unrecoverable via other recovery methods such
> as driver rebind or bus reset. The documentation clarifies when this
> recovery method should be used and its implications for userspace.
> 
> v2:
> - Add several instead of number to avoid update. (Jani)
> 
> v3:
> - Update document with generic scenario. (Riana)
> - Consistent with terminology. (Raag)
> - Remove already covered information.
> 
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>  Documentation/gpu/drm-uapi.rst | 60 +++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 579e87cb9ff7..d8b3608c5cbb 100644
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
> @@ -447,6 +448,14 @@ debug purpose in order to root cause the hang. This is useful because the first
>  hang is usually the most critical one which can result in consequential hangs
>  or complete wedging.
>  
> +Cold Reset Recovery
> +-------------------
> +
> +When ``WEDGED=cold-reset`` is sent, it indicates that the device has encountered
> +an error condition that cannot be resolved through other recovery methods such as
> +driver rebind or bus reset, and requires a complete device cold reset to restore

s/complete cold reset/device power cycle

> +functionality.

This section is much easier to follow and can be reused in commit message.

We may also want to add limitation of this method (if any). IIUC this
requires that the slot actually allows removing power.

Raag

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
