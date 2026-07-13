Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB27C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BC010E866;
	Mon, 13 Jul 2026 08:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QO7Fp283";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68AA510E866;
 Mon, 13 Jul 2026 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783932220; x=1815468220;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6XwGpqwq9riuEieA2U+jpZ5aJK2mXorSE7cSvvkqI9o=;
 b=QO7Fp283StE20Yj+m3tawuq+Ex8VJJEjbWsCZQT9u2ExsdoZ/FaN/5KR
 4GeJAOXPunxjQstXkEZc6fl6qSKRKR6N1VQ1M60HpJwpLgN2b7c4Mx/ZL
 k7sKoSVpxTLG2JZwRleupEzv7nZjw2hAbq30hUofP5/VWitPdO6g9yByl
 1AhqV2D4+fA3obJdO5tW0dCJ2A9p8ppfVKgagyLbdbrZYxzGPxZdLbyBC
 NEk+2mRVM3Fi7TwkX+BaYNvGSSBhcgOa6ifdD08W74nKdVLm2JKnmJ2lW
 awnBP5pSQ/M8dpq8yoboxtByAKRMmvynyRsOBgL3Wtmdd3D6+enDWG0WU Q==;
X-CSE-ConnectionGUID: H6QXdCV9RqCZWyzPe5eM1A==
X-CSE-MsgGUID: hxZUZ8TrTJeTAJwlfVXOhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95903979"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95903979"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 01:43:39 -0700
X-CSE-ConnectionGUID: Nbi6WR3BSJGZl2OLqwV38A==
X-CSE-MsgGUID: LxaDEMkcR9CUgX3r9Rsaag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="251073086"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa006.fm.intel.com with ESMTP; 13 Jul 2026 01:43:35 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v10 3/4] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Date: Mon, 13 Jul 2026 14:09:43 +0530
Message-ID: <20260713083939.251872-9-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713083939.251872-6-mallesh.koujalagi@intel.com>
References: <20260713083939.251872-6-mallesh.koujalagi@intel.com>
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
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
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

v7:
- Update recovery script. (Raag)

v8:
- Add rescan instead of reset. (Raag)

-v10:
- Fix column width. (Sashiko)
---
 Documentation/gpu/drm-uapi.rst | 91 ++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 4 deletions(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 93df92c4ac8c..43294a10738e 100644
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
@@ -434,15 +434,16 @@ method is unknown, ``WEDGED=unknown`` will be sent instead.
 Userspace consumers can parse this event and attempt recovery as per the
 following expectations.
 
-    =============== ========================================
+    =============== =========================================
     Recovery method Consumer expectations
-    =============== ========================================
+    =============== =========================================
     none            optional telemetry collection
     rebind          unbind + bind driver
     bus-reset       unbind + bus reset/re-enumeration + bind
     vendor-specific vendor specific recovery method
+    cold-reset      remove device + slot power cycle + rescan
     unknown         consumer policy
-    =============== ========================================
+    =============== =========================================
 
 No Recovery
 -----------
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
 
@@ -530,6 +542,77 @@ Recovery script::
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
+    die() { echo "ERROR: $*" >&2; exit 1; }
+
+    [ -n "$1" ] || die "Usage: $0 <device-path>"
+
+    PCI_DEVS=/sys/bus/pci/devices
+    PCI_SLOTS=/sys/bus/pci/slots
+
+    syspath=$(readlink -f "/sys/$1/device" 2>/dev/null || readlink -f "/sys/$1" 2>/dev/null)
+    [ -n "$syspath" ] || die "cannot resolve sysfs path for: $1"
+
+    dev=$(basename "$syspath")
+    [ -e "$PCI_DEVS/$dev" ] || die "not a PCI device: $dev"
+    echo "device : $dev"
+
+    slot=""
+    walk=$(dirname "$(readlink -f "$PCI_DEVS/$dev")")
+
+    while true; do
+        ancestor=$(basename "$walk")
+        case "$ancestor" in pci*) break ;; esac  # reached the virtual bus root
+
+        ancestor_nofn=${ancestor%.*}  # strip function: 0000:03:01.0 -> 0000:03:01
+
+        for f in "$PCI_SLOTS"/*/address; do
+            [ -f "$f" ] || continue
+            addr=$(cat "$f")
+            case "$ancestor_nofn" in
+                *"$addr") slot=$(basename "$(dirname "$f")"); break ;;
+            esac
+        done
+
+        if [ -n "$slot" ] && [ -e "$PCI_SLOTS/$slot/power" ]; then
+            echo "slot   : $slot (port $ancestor)"
+            break
+        fi
+        slot=""
+        walk=$(dirname "$walk")
+    done
+
+    [ -n "$slot" ] || die "no hotplug slot with power control found in PCIe topology"
+
+    # Cold reset: remove the device, cut slot power, restore power, rescan.
+    echo "Removing $dev..."
+    [ -e "$PCI_DEVS/$dev" ] && echo 1 > "$PCI_DEVS/$dev/remove"
+
+    echo "Powering off slot $slot..."
+    echo 0 > "$PCI_SLOTS/$slot/power"
+
+    echo "Powering on slot $slot..."
+    echo 1 > "$PCI_SLOTS/$slot/power"
+
+    echo "Rescanning PCI bus..."
+    echo 1 > /sys/bus/pci/rescan
+
+    if [ -e "$PCI_DEVS/$dev" ]; then
+        echo "Done: $dev is back online."
+    else
+        echo "WARNING: $dev did not re-appear after rescan."
+    fi
+
 Customization
 -------------
 
-- 
2.48.1

