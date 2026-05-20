Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A615CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 11:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E4110F02F;
	Wed, 20 May 2026 11:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="khmCo59z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9832110F02F;
 Wed, 20 May 2026 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779277028; x=1810813028;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2PMWUp0NxcroIO+Qn6lmxYbio2Q2FQg/0P2ZVXdsvfY=;
 b=khmCo59zmnaAiRm9odVf4r3D0JsfpDTn3cUXAcfuH0zj/XWB/HmnRQes
 aOCWRlt6yRaye3oKPzbRPaUbMwhbe9P89PTpWAVdo5dTdtA0iFZt+mzEc
 txE04r+l98CdTBzhev97hPKRUTbNL2cILd69s7RN1S1GICyTD3B0ClPrF
 TcJVFsnMzQ2QeV3jKX+o08j0k33c2CvlIl5C7Fl4KUhE/lHtzQr7/5fyv
 ezBxzv+wIk5MtdJqJWReVlLlk78J91crH4A23lreCbpPzAM2RRpbFgyL1
 jSd8HVu49X+i7ilmSAyd5oJkQphgoQn1LJo5ytZ0FY6zkW9ocZCZS9Nyy g==;
X-CSE-ConnectionGUID: F/nj1ThfT+6Ub8wZqivkvA==
X-CSE-MsgGUID: 03R2R5LOSROTGpHogUoPmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="84027500"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="84027500"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 04:37:07 -0700
X-CSE-ConnectionGUID: 4zVGJWBBTT6S/4WScSjjnA==
X-CSE-MsgGUID: vSolgllbRJOcyAZj8b4+JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="237153530"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa007.fm.intel.com with ESMTP; 20 May 2026 04:37:03 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v6 3/5] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Date: Wed, 20 May 2026 17:03:55 +0530
Message-ID: <20260520113351.171119-10-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520113351.171119-7-mallesh.koujalagi@intel.com>
References: <20260520113351.171119-7-mallesh.koujalagi@intel.com>
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

v6:
- Look up the hotplug slot in DEVPATH instead of scanning
  every PCI slot on the system. (Raag)
- Drop arbitrary sleep values from the example script.
---
 Documentation/gpu/drm-uapi.rst | 60 +++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 2c2f939322fb..665c66782504 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -424,7 +424,7 @@ needed.
 Recovery
 --------
 
-Current implementation defines four recovery methods, out of which, drivers
+Current implementation defines several recovery methods, out of which, drivers
 can use any one, multiple or none. Method(s) of choice will be sent in the
 uevent environment as ``WEDGED=<method1>[,..,<methodN>]`` in order of less to
 more side-effects. See the section `Vendor Specific Recovery`_
@@ -441,6 +441,7 @@ following expectations.
     rebind          unbind + bind driver
     bus-reset       unbind + bus reset/re-enumeration + bind
     vendor-specific vendor specific recovery method
+    cold-reset      remove device + slot power cycle + rescan
     unknown         consumer policy
     =============== ========================================
 
@@ -453,6 +454,17 @@ debug purpose in order to root cause the hang. This is useful because the first
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
 
@@ -530,6 +542,52 @@ Recovery script::
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
+    # The PCI core exposes a 'slot' symlink on the device that sits in a
+    # registered hotplug slot. Use it directly instead of scanning every
+    # slot on the system.
+    SLOT=""
+    if [ -L "$DEVPATH/slot" ]; then
+	    SLOT=$(basename "$(readlink -f "$DEVPATH/slot")")
+    fi
+
+    if [ -n "$SLOT" ]; then
+	echo "Using slot $SLOT"
+
+	# Remove device
+	echo 1 > /sys/bus/pci/devices/$DEVICE/remove
+
+	# Power cycle slot. A platform-specific settle delay may be required
+	# between power off and power on; tune to the hardware as needed.
+	echo 0 > /sys/bus/pci/slots/$SLOT/power
+	echo 1 > /sys/bus/pci/slots/$SLOT/power
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

