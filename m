Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B49CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 12:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4906511A81C;
	Fri,  5 Jun 2026 12:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nr/ATgtD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BB011A818;
 Fri,  5 Jun 2026 12:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780662562; x=1812198562;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ElXAMqzzY1IJ+dQP3EQwu8jimgcKvAVdV04h8U4nH5o=;
 b=nr/ATgtDBxuJinmGwbIyonAgHNrwyqaGgmD6ps2Hi4FaihxfqiYUcpDf
 949f0Zj51h25MfhU5j6ULzA0I2dEFJOhjzuLQzVnww0DLctg8I0n4axBp
 1zgmEuoD+30LeKt3wrZ45fJwx6ooMyCN+29uu3gvxokEsb6yNDQfgaBZW
 w51FMEyLoU/YeVrkJxcPKXHq/b2uN0KQB1pt0XOjbS47U8SoYXeRCEF6R
 EzfGDqGPgCQY0c5nOC4qBwWuMkRf/LC7/GQ1EgUapJNfyuTHCtBvthe/P
 BROHiTdma5OS7sxFqEc3beTA7oZUK3ds2Qt11dO0UmDGy0p90qbkWISK4 Q==;
X-CSE-ConnectionGUID: Unk0L1ZvSjqPTSd2RdEQ2A==
X-CSE-MsgGUID: KI6S1az2Qry+dLX1LOjDTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81527075"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81527075"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 05:29:22 -0700
X-CSE-ConnectionGUID: JbFd+8/vSl+ERAkiYt86EQ==
X-CSE-MsgGUID: nyk4auxKQeqX/rNrfmC2Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="240383694"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa006.fm.intel.com with ESMTP; 05 Jun 2026 05:29:18 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v7 3/6] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Date: Fri,  5 Jun 2026 17:55:47 +0530
Message-ID: <20260605122544.1021695-11-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605122544.1021695-8-mallesh.koujalagi@intel.com>
References: <20260605122544.1021695-8-mallesh.koujalagi@intel.com>
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

v7:
- Update recovery script. (Raag)
---
 Documentation/gpu/drm-uapi.rst | 85 +++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 93df92c4ac8c..8ab2fdd20cb5 100644
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
+        echo "WARNING: $dev did not re-appear after reset."
+    fi
+
 Customization
 -------------
 
-- 
2.34.1

