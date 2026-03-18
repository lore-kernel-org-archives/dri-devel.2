Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E020AFCD0C1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53AA410E2D0;
	Wed, 18 Mar 2026 06:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YSoEKdyN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13EF110E08E;
 Wed, 18 Mar 2026 06:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773816192; x=1805352192;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Uaq8UE7qBZ6Tm/1pQbY9D51HBLZ2aKdXBbC/fjSItrQ=;
 b=YSoEKdyNBuyqOt4wjiOTr+wVvNWMI+h3p66TeLRICt3PvoNRiw1v2Y7n
 12cgyL6qsWu2PlbetbTVb/M+axGJGNYMYJsMGbbGatxvqqI2qFK5wB1IP
 j8NNRi7HG4UeDdVINpb/g/4JmdB3ruJy+veUJtYzw9z/xpxyhgbq54T/P
 1bzUxbjJWSEJS7hCTqyFKU/m0olT3VS8E10tj2Obu/gU4fzybVxsxAdop
 bTzHScJ+jDtDwMBLZq7/jv8lpJ22YOjKq3zpWE8W6hdCHq5WssZg8uWNk
 KgywpdlCfFsRczsmZl3zAu/lxNYGjK9ueKrNI3Niv0JqgOK+0UK6cRXYI A==;
X-CSE-ConnectionGUID: 6NsBJMmWQ/SPfdYxl1wLBw==
X-CSE-MsgGUID: hDSTjA1uRqi+F3OoqZ6Irw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78723351"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="78723351"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 23:43:12 -0700
X-CSE-ConnectionGUID: 3xiTk6cPTieqV8XRfSbZ0Q==
X-CSE-MsgGUID: qlH61ehnSzeo7yJwRhPxhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="227464619"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa005.jf.intel.com with ESMTP; 17 Mar 2026 23:43:07 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v2 3/5] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Date: Wed, 18 Mar 2026 12:10:20 +0530
Message-ID: <20260318064016.374656-10-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
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

Add documentation for the DRM_WEDGE_RECOVERY_COLD_RESET recovery
method introduced for handling power management unit errors. This method is
designated for severe errors that compromise core device functionality
and are unrecoverable via recovery mechanisms such as driver reload or PCIe
bus reset. The documentation clarifies when this recovery method should be
used and its implications for userspace applications.

v2:
- Add several instead of number to avoid update. (Jani)

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 Documentation/gpu/drm-uapi.rst | 73 +++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index d98428a592f1..5b63f1c17b9b 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -418,7 +418,7 @@ needed.
 Recovery
 --------
 
-Current implementation defines four recovery methods, out of which, drivers
+Current implementation defines several recovery methods, out of which, drivers
 can use any one, multiple or none. Method(s) of choice will be sent in the
 uevent environment as ``WEDGED=<method1>[,..,<methodN>]`` in order of less to
 more side-effects. See the section `Vendor Specific Recovery`_
@@ -435,6 +435,7 @@ following expectations.
     rebind          unbind + bind driver
     bus-reset       unbind + bus reset/re-enumeration + bind
     vendor-specific vendor specific recovery method
+    cold-reset      full device cold reset required
     unknown         consumer policy
     =============== ========================================
 
@@ -446,6 +447,27 @@ telemetry information (devcoredump, syslog). This is useful because the first
 hang is usually the most critical one which can result in consequential hangs or
 complete wedging.
 
+Cold Reset Recovery
+-------------------
+
+The ``WEDGED=cold-reset`` event indicates that the device has encountered
+power management unit errors that affect core functionality that cannot be
+resolved through recovery mechanisms.
+
+This recovery method is reserved for power management unit error conditions where the
+device state cannot be restored via:
+
+- Driver unbind/rebind operations
+- PCIe bus reset and re-enumeration
+- Device Function Level Reset (FLR)
+- Warm device resets
+
+Such power management unit error state typically persists across all software-based
+recovery attempts. Only a complete device power cycle can restore
+normal operation.
+
+Upon receiving a ``WEDGED=cold-reset`` event, userspace should initiate
+a full cold reset of the affected device to restore functionality.
 
 Vendor Specific Recovery
 ------------------------
@@ -524,6 +546,55 @@ Recovery script::
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
+    SLOT=$(find /sys/bus/pci/slots/ -type l 2>/dev/null | while read slot; do
+	    ADDR=$(cat "$slot" 2>/dev/null)
+	    [ -n "$ADDR" ] && echo "$DEVICE" | grep -q "^$ADDR" && basename $(dirname "$slot") && break
+    done)
+
+    if [ -n "$SLOT" ]; then
+	echo "Using slot $SLOT"
+
+	# Unbind driver
+	[ -e "/sys/bus/pci/devices/$DEVICE/driver" ] && \
+	echo "$DEVICE" > /sys/bus/pci/devices/$DEVICE/driver/unbind 2>/dev/null
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

