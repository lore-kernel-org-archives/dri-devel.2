Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEBFF46C45
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9894A10E1E3;
	Mon,  6 Apr 2026 14:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="j3hCIeKl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C3910E258;
 Mon,  6 Apr 2026 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775485564; x=1807021564;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ySZfr0eMzp1PsKF3LWE2vqrtvvNKjSJ7ALiE7VnzTc8=;
 b=j3hCIeKl+b3I0h0TbveUGWDJGYedxk7N1gNICxRzia0KbGceOc/oaZUE
 6Jprg20bzr/5lwfYHy8a0wPZFGbFo1PlshKPVJFAr/UOfCd7WR2cICf30
 x5D0iFZ10rZTVXOYUbvQ96NyJs584SgZmi7S6zxTBmmXcugoYFteVBAdM
 IoxLuv3F7HBGzFO63JxrGN+4BWklC/5oKn57sC2WyK4HmyVK5vjI4KfrF
 cuHOkrjiPyVPjQ7HctrwVWokPjocYxcm5+SIXOaQD2pz7FVatEExbQ17L
 psARmCm+jazXKgoEvLDf7zUZPSrAJm+g8OnYzba3+taMDvVtD6sQ4AQZI A==;
X-CSE-ConnectionGUID: 7iekqFucRNWQHuQYi37lwQ==
X-CSE-MsgGUID: XsXxU72mRLK2LENwV9/seg==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="75603915"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="75603915"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 07:26:04 -0700
X-CSE-ConnectionGUID: WkXSfPYDTMaDFNvUYzpPHw==
X-CSE-MsgGUID: 6uD+ratATIi6MmDQvs9Myw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="221309246"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa009.fm.intel.com with ESMTP; 06 Apr 2026 07:26:00 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v3 3/4] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Date: Mon,  6 Apr 2026 19:53:29 +0530
Message-ID: <20260406142325.157035-9-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406142325.157035-6-mallesh.koujalagi@intel.com>
References: <20260406142325.157035-6-mallesh.koujalagi@intel.com>
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

Add documentation for the DRM_WEDGE_RECOVERY_COLD_RESET recovery method.
This method is designated for severe error conditions that compromise core
device functionality and are unrecoverable via other recovery methods such
as driver rebind or bus reset. The documentation clarifies when this
recovery method should be used and its implications for userspace.

v2:
- Add several instead of number to avoid update. (Jani)

v3:
- Update document with generic scenario. (Riana)
- Consistent with terminology. (Raag)
- Remove already covered information.

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 Documentation/gpu/drm-uapi.rst | 60 +++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 579e87cb9ff7..d8b3608c5cbb 100644
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
 
@@ -447,6 +448,14 @@ debug purpose in order to root cause the hang. This is useful because the first
 hang is usually the most critical one which can result in consequential hangs
 or complete wedging.
 
+Cold Reset Recovery
+-------------------
+
+When ``WEDGED=cold-reset`` is sent, it indicates that the device has encountered
+an error condition that cannot be resolved through other recovery methods such as
+driver rebind or bus reset, and requires a complete device cold reset to restore
+functionality.
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

