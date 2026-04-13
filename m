Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE00F34C4E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3F0010E44E;
	Mon, 13 Apr 2026 13:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZgKPiaSS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3000510E44E;
 Mon, 13 Apr 2026 13:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776087178; x=1807623178;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0cvXIurc1UdqWUHQopaYIdoGDYkC71obgDeLZQM9WNo=;
 b=ZgKPiaSSMneN3+SQ/0VxFsUtEI46Pbw/MlAuq7GbwlTrymqo3nKkY0Pf
 yTfzp1k5PbrWYA/5FFtMoo4X4+iTh5Kf8GqDUBk7B2gz6/Z1ZFV4xtuke
 YaR9U+zqL2DgDE31ImzWCI5HcP2up+62ya/LwrrIAYXZdjCKQZHCaI2wv
 GLTjbB8QzByIbL74Hkpyn3osK/jgKJgoUEiWNLXeIUi+O7bwyVwyLqyyy
 5P7FGVoGX2Z3ZRFm1HtOe6l8zifvD8H3KG7uHKu+8XD6j9T387iDFve+V
 phhOubV9oxJGq4yr5XsCn7jYrM9SdVk/xXbbeEw3eJ3BeeKzXSIWmTW0p Q==;
X-CSE-ConnectionGUID: +6XUJEGJRBSIr0RdoTL0qg==
X-CSE-MsgGUID: s4YKA0pgQ6KlIyPTZNeUkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="94594705"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="94594705"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 06:32:58 -0700
X-CSE-ConnectionGUID: zje9tYp0QnqdR/h7LgcS4w==
X-CSE-MsgGUID: aFGmsjqQQwqc9IhGL3FF3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="229659694"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa009.jf.intel.com with ESMTP; 13 Apr 2026 06:32:54 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v4 3/4] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Date: Mon, 13 Apr 2026 19:00:17 +0530
Message-ID: <20260413133013.560239-9-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413133013.560239-6-mallesh.koujalagi@intel.com>
References: <20260413133013.560239-6-mallesh.koujalagi@intel.com>
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

When ``WEDGED=cold-reset`` is sent, it indicates a non-recoverable
device error, only a full power cycle can restore the device.

v2:
- Add several instead of number to avoid update. (Jani)

v3:
- Update document with generic scenario. (Riana)
- Consistent with terminology. (Raag)
- Remove already covered information.

v4:
- Update doc. (Raag/Riana)
- Change commit message. (Raag)

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 Documentation/gpu/drm-uapi.rst | 60 +++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 579e87cb9ff7..0b87c8ed760d 100644
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
+    cold-reset      unbind + remove device + slot power cycle + rescan
     unknown         consumer policy
     =============== ========================================
 
@@ -447,6 +448,14 @@ debug purpose in order to root cause the hang. This is useful because the first
 hang is usually the most critical one which can result in consequential hangs
 or complete wedging.
 
+Cold Reset Recovery
+-------------------
+
+When ``WEDGED=cold-reset`` is sent, it indicates a non-recoverable device error,
+only a full power cycle can restore the device.
+
+This method is used by devices that are plugged directly into the PCIe slot.
+
 Vendor Specific Recovery
 ------------------------
 
@@ -524,6 +533,55 @@ Recovery script::
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

