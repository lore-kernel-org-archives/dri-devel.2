Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7CCCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 13:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E1FF10EAC1;
	Tue, 12 May 2026 13:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="THXakvuB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE07910EAEA;
 Tue, 12 May 2026 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778592582; x=1810128582;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N0+VPOvLWM9rfrFTGd8MnLspsMZ7OWDXslo1tV4ORgI=;
 b=THXakvuB/D0ePeovbT9QU3XO9q/KM80RxvoqE3eaE6q4zSqzO3NQS/BD
 elRzkUQa01gkWPTGGyGjyACUiJ1DU1esc6WI0vTTNEr70M6CM67ECUiHj
 tYD3L5IYKU5WV/U+lsaShqCmhnw2j18yypNx7ULHWfFxNGgJFNqOzkXmv
 wgbXuHMAuvGdxIGe4IrnHy9mpw1ZDzAKGW7GJMoTED6tz2ATeptS/iH6a
 vQvNIa1vtfYWLbI4zLa2ydhiyZiLViqUVbWyWUzssII5Z1erWWFmzHDXq
 8n2PE66MX2/c5mgRCDKh+L9Gj9XaVMmln3Lf/MYhH70A1TvT5MvAixvQV g==;
X-CSE-ConnectionGUID: yffR0GXVRZyAyl0SrhDkxQ==
X-CSE-MsgGUID: FCI5IY9WRN6zqokPd38MVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="102164702"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="102164702"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 06:29:41 -0700
X-CSE-ConnectionGUID: ag/plrSTSm2lNQYFoR8aZg==
X-CSE-MsgGUID: MZ5t2HCzQgmHmRIY5ydjRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="237855889"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa009.jf.intel.com with ESMTP; 12 May 2026 06:29:38 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v5 3/5] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Date: Tue, 12 May 2026 18:56:18 +0530
Message-ID: <20260512132614.1793083-10-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When ``WEDGED=cold-reset`` is sent, it indicates that the device has
encountered an error condition that cannot be resolved through other
recovery methods such as driver rebind or bus reset, and requires a
complete device power cycle to restore functionality.

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
v2:
- Add several instead of number to avoid update. (Jani)

v3:
- Update document with generic scenario. (Riana)
- Consistent with terminology. (Raag)
- Remove already covered information.

v4:
- Update doc. (Raag/Riana)
- Change commit message.

v5:
- Update commit message. (Raag)
- Remove unbind.
- Simplify cold-reset script.
---
 Documentation/gpu/drm-uapi.rst | 64 +++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 32206ce62931..809386f16521 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -422,7 +422,7 @@ needed.
 Recovery
 --------
 
-Current implementation defines four recovery methods, out of which, drivers
+Current implementation defines several recovery methods, out of which, drivers
 can use any one, multiple or none. Method(s) of choice will be sent in the
 uevent environment as ``WEDGED=<method1>[,..,<methodN>]`` in order of less to
 more side-effects. See the section `Vendor Specific Recovery`_
@@ -439,6 +439,7 @@ following expectations.
     rebind          unbind + bind driver
     bus-reset       unbind + bus reset/re-enumeration + bind
     vendor-specific vendor specific recovery method
+    cold-reset      remove device + slot power cycle + rescan
     unknown         consumer policy
     =============== ========================================
 
@@ -451,6 +452,17 @@ debug purpose in order to root cause the hang. This is useful because the first
 hang is usually the most critical one which can result in consequential hangs
 or complete wedging.
 
+Cold Reset Recovery
+-------------------
+
+When ``WEDGED=cold-reset`` is sent, it indicates that the device has
+encountered an error condition that cannot be resolved through other
+recovery methods such as driver rebind or bus reset, and requires a complete
+device power cycle to restore functionality.
+
+This method is used by devices that are plugged directly into the PCIe slot
+which supports removing the power.
+
 Vendor Specific Recovery
 ------------------------
 
@@ -528,6 +540,56 @@ Recovery script::
     echo -n $DEVICE > $DRIVER/unbind
     echo -n $DEVICE > $DRIVER/bind
 
+Example - cold-reset
+--------------------
+
+Udev rule::
+
+    SUBSYSTEM=="drm", ENV{WEDGED}=="cold-reset", DEVPATH=="*/drm/card[0-9]",
+    RUN+="/path/to/cold-reset.sh $env{DEVPATH}"
+
+Recovery script::
+
+    #!/bin/sh
+
+    [ -z "$1" ] && echo "Usage: $0 <device-path>" && exit 1
+
+    # Get device
+    DEVPATH=$(readlink -f /sys/$1/device 2>/dev/null || readlink -f /sys/$1)
+    DEVICE=$(basename $DEVPATH)
+
+    echo "Cold reset: $DEVICE"
+
+    # Try slot power reset first
+    SLOT=""
+    for addr_file in /sys/bus/pci/slots/*/address; do
+	    [ -f "$addr_file" ] || break
+	    addr=$(cat "$addr_file" 2>/dev/null)
+	    [ -n "$addr" ] || continue
+	    case "$DEVICE" in
+		    "$addr"*) SLOT=$(basename "$(dirname "$addr_file")"); break ;;
+	    esac
+    done
+
+    if [ -n "$SLOT" ]; then
+	echo "Using slot $SLOT"
+
+	# Remove device
+	echo 1 > /sys/bus/pci/devices/$DEVICE/remove
+
+	# Power cycle slot
+	echo 0 > /sys/bus/pci/slots/$SLOT/power
+	sleep 2
+	echo 1 > /sys/bus/pci/slots/$SLOT/power
+	sleep 1
+
+	# Rescan
+	echo 1 > /sys/bus/pci/rescan
+	echo "Done!"
+    else
+	echo "No slot found"
+    fi
+
 Customization
 -------------
 
-- 
2.34.1

