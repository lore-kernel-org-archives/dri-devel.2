Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BBC606A333
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ftzX+zqz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A76610F2E2;
	Mon,  9 Nov 2026 13:56:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31E710F2F5;
 Mon,  9 Nov 2026 13:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232580; x=1825768580;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YK95ivznWXwvvJoD1SPsL3OYWIz0hPCgm3vAQ6EhbME=;
 b=ftzX+zqzPJcHLNS765LJa1uTosee1BnKdhzpkn08yVJ1Zr2ZPED0j1N5
 9G0IKDp4hz8g5k/x1FOuSJPLb6IYiSscHZRRVU5r/bAepy8xavY1IttJY
 5z/qKejeys6+XOgvjZy/NkqgYZyiTMXL3dG+ZqU+5i1UEl32OOkTh1xW6
 N2qBs9L98rmw7CNnUyO8O1YbukuU8oxVAeJKRv7UPNXgUwVJ94RvYfapo
 HqVMTiLX8KI5dbE5yBP/8PYi2MQR1sPofLNUHl/vtmoV3LAAIab/rDZRn
 +OTQV7HZrZFs4PZWMIhU15DLbOzjaXNBoub3IDxRDBsFXHsgF72CYDVJZ A==;
X-CSE-ConnectionGUID: bJ1mV1eEQi6xUp9k4BaMkw==
X-CSE-MsgGUID: bY8c0QbWR8+WrAB+6Jej9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850709"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850709"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:19 -0800
X-CSE-ConnectionGUID: 3TN+JL1fSj+6jhq7p8AvuQ==
X-CSE-MsgGUID: pSNFSnp7TuqJWb+QO1Q50Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202544"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:12 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Dominik Grzegorzek <dominik.grzegorzek@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Matt Roper <matthew.d.roper@intel.com>,
 =?UTF-8?q?Zbigniew=20Kempczy=C5=84ski?= <zbigniew.kempczynski@intel.com>,
 Jonathan Cavitt <jonathan.cavitt@intel.com>,
 Christoph Manszewski <christoph.manszewski@intel.com>
Subject: [PATCH 02/20] drm/xe/eudebug: Introduce eudebug interface
Date: Mon,  9 Nov 2026 15:55:27 +0200
Message-ID: <20261109135549.4128280-3-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the eudebug interface to the Xe driver, enabling
user-space debuggers (e.g., GDB) to track and interact with GPU resources
of a DRM client. Debuggers can inspect or modify these resources,
for example, to locate ISA/ELF sections and install breakpoints in a
shader's instruction stream.

A debugger opens a connection to the Xe driver via a DRM ioctl, specifying
the target DRM client's file descriptor. This returns an anonymous file
descriptor for the connection, which can be used to listen for resource
creation/destruction events. The same file descriptor can also be used to
receive hardware state change events and control execution flow by
interrupting EU threads on the GPU (in follow-up patches).

Introduce the eudebug connection and event queuing,
adding VM create/destroy events as a baseline. Additional events and
hardware control for full debugger operation are needed and will be
introduced in follow-up patches.

The resource tracking components are inspired by Maciej Patelczyk's work on
resource handling for i915. Chris Wilson suggested a two-way mapping
approach, which simplifies using the resource map as definitive
bookkeeping for resources relayed to the debugger during the discovery
phase (in a follow-up patch).

v2: - Kconfig support (Matthew)
    - ptraced access control (Lucas)
    - pass expected event length to user (Zbigniew)
    - only track long running VMs
    - checkpatch (Tilak)
    - include order (Andrzej)
    - 32bit fixes (Andrzej)
    - cleaner get_task_struct
    - remove xa_array and use clients.list for tracking (Mika)
v3: - adapt to removal of clients.lock (Mika)
    - create_event cleanup (Christoph)
v4: - add proper header guards (Christoph)
    - better read_event fault handling (Christoph, Mika)
    - simplify attach (Mika)
    - connect using target file descriptors
    - avoid event->seqno after queue as it can UAF (Mika)
    - use drmm for eudebug_fini (Maciej)
    - squash dynamic enable
v6: - drm->authenticated is overzealous for render (Mika)
v7: - struct member documentation (Mika)
    - enforce seqno mbz (Mika)
v8: - head->seqno fix (Mika)
    - resource alloc and removal cleanup (Mika)
    - s/wait_interruptible_timeout/wait_timeout (Mika)
    - use fd_install in connect (Mika)
v9: - fix xef vs debugger race (Sashiko)
    - assign d->xe early (Sashiko)
    - simplify locking (Mika)
    - fix pending->len outside lock (Sashiko)
    - remove version from connect to address fd_install leak (Sashiko)
    - create vm by id to avoid use after free (Sashiko)
    - use xe_eudebug_detach on connection error path (Sashiko)
    - don't sleep on kzalloc as we can disconnect (Sashiko)
    - check if enabled on connection (Sashiko)
    - preallocated event fifo for lockless allocs (Sashiko, Mika)
v10:
    - wakeup after detach, take account of occupied (Sashiko)
    - GFP_ACCOUNT for fifo (Sashiko)
    - set O_CLOEXEC on connection fd (Sashiko)
    - docstrings (Maciej)
    - use guard and __kfree (Mika)
    - init_early (Maciej)
    - remove unused struct members
    - no need to send destroy if vm was not announced (Claude)
    - avoid dereference of xef on eu_print (Claude)
    - don't silently truncate target fd (Claude)
    - preallocate resource handles
    - zero as target fd (Claude)
    - hold drm_device (Claude)
v11: - fix eudebug=n build (Claude)
     - document seqno as timeline (Sashiko)
v12: - drain nothing on detach, say so in the uapi (Sashiko)
     - drop resource handles on detach to avoid uaf (Sashiko)
     - ioctl naming, sysfs abi (Claude)
v13: - create enable_eudebug last, so init cannot undo an enable
       (review-prompts)
v14: - one mutex for all debugger state, no lockless accesses (Mika)
v15: - __free() variables defined where they are assigned (Sashiko)
     - poll in one lock section, no EPOLLIN once detached (Sashiko)
     - connect in the uapi ioctl list (Sashiko)
     - copy the event out of @events.pending directly, no bounce
       allocation per read (Sashiko)

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Zbigniew Kempczyński <zbigniew.kempczynski@intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
Signed-off-by: Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: Christoph Manszewski <christoph.manszewski@intel.com>
---
 .../ABI/testing/sysfs-driver-intel-xe-eudebug |   36 +
 Documentation/gpu/driver-uapi.rst             |    2 +
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    2 +
 drivers/gpu/drm/xe/Kconfig                    |   10 +
 drivers/gpu/drm/xe/Makefile                   |    3 +
 drivers/gpu/drm/xe/xe_device.c                |    8 +
 drivers/gpu/drm/xe/xe_device_types.h          |   29 +
 drivers/gpu/drm/xe/xe_eudebug.c               | 1212 +++++++++++++++++
 drivers/gpu/drm/xe/xe_eudebug.h               |   68 +
 drivers/gpu/drm/xe/xe_eudebug_types.h         |  168 +++
 drivers/gpu/drm/xe/xe_vm.c                    |   15 +-
 include/uapi/drm/xe_drm.h                     |   24 +
 include/uapi/drm/xe_drm_eudebug.h             |  131 ++
 14 files changed, 1707 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug.c
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug.h
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug_types.h
 create mode 100644 include/uapi/drm/xe_drm_eudebug.h

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug b/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
new file mode 100644
index 000000000000..26aff5116b8a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
@@ -0,0 +1,36 @@
+What:		/sys/bus/pci/drivers/xe/.../enable_eudebug
+Date:		August 2026
+KernelVersion:	7.4
+Contact:	intel-xe@lists.freedesktop.org
+Description:	RW. Controls whether the EU debugger interface is armed for
+		this device.
+
+		Reads back 1 when the interface is enabled and 0 when it is
+		not. Writing a boolean value ("0"/"1", "n"/"y", "off"/"on")
+		enables or disables it. The interface starts out disabled.
+
+		While disabled, DRM_IOCTL_XE_EUDEBUG_CONNECT fails with
+		-EOPNOTSUPP.
+
+		Writing 0 while any debugger connection is still attached
+		fails with -EBUSY.
+
+		Once enabled, connecting needs no privilege beyond access to
+		the render node: a client may attach to any DRM file it holds
+		a descriptor for, including its own. Any such client can
+		therefore keep the interface from being disabled for as long
+		as it keeps its connection open. Disabling does not revoke
+		existing connections; to disable, the processes holding them
+		have to close them or be terminated. A connection shows up as
+		an "anon_inode:[xe_eudebug]" entry under /proc/<pid>/fd.
+
+		Each connection allocates about 4 MiB of kernel memory for
+		its event queue, held until the connection is closed. The
+		number of connections is not limited beyond the file
+		descriptor limit; the memory is charged to the memory cgroup
+		of the process that connected.
+
+		This attribute is only present when the driver is built with
+		CONFIG_DRM_XE_EUDEBUG and the interface was set up at probe
+		time. If probe could not set it up, the attribute is absent
+		and the connect ioctl fails with -EOPNOTSUPP.
diff --git a/Documentation/gpu/driver-uapi.rst b/Documentation/gpu/driver-uapi.rst
index 627fc68c7a21..1fbcac949da9 100644
--- a/Documentation/gpu/driver-uapi.rst
+++ b/Documentation/gpu/driver-uapi.rst
@@ -30,6 +30,8 @@ drm/xe uAPI
 
 .. kernel-doc:: include/uapi/drm/xe_drm.h
 
+.. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
+
 drm/asahi uAPI
 ================
 
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index dbe462040999..8c2113628efe 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -261,6 +261,7 @@ Code  Seq#    Include File                                             Comments
 'i'   80-8F  linux/i8k.h
 'i'   90-9F  `linux/iio/*.h`                                           IIO
 'j'   00-3F  linux/joystick.h
+'j'   40-4F  uapi/drm/xe_drm_eudebug.h                                 Intel Xe EU debugger connection
 'k'   00-0F  linux/spi/spidev.h                                        conflict!
 'k'   00-05  video/kyro.h                                              conflict!
 'k'   10-17  linux/hsi/hsi_char.h                                      HSI character device
diff --git a/MAINTAINERS b/MAINTAINERS
index 1c3aec082b0a..ec06cbef5c4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13397,11 +13397,13 @@ Q:	http://patchwork.freedesktop.org/project/intel-xe/
 B:	https://gitlab.freedesktop.org/drm/xe/kernel/-/issues
 C:	irc://irc.oftc.net/xe
 T:	git https://gitlab.freedesktop.org/drm/xe/kernel.git
+F:	Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
 F:	Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon
 F:	Documentation/gpu/xe/
 F:	drivers/gpu/drm/xe/
 F:	include/drm/intel/
 F:	include/uapi/drm/xe_drm.h
+F:	include/uapi/drm/xe_drm_eudebug.h
 
 INTEL ELKHART LAKE PSE I/O DRIVER
 M:	Raag Jadav <raag.jadav@intel.com>
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 8e57473b6fb2..b703bcb17574 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -143,6 +143,16 @@ config DRM_XE_FORCE_PROBE
 
 	  Use "!*" to block the probe of the driver for all known devices.
 
+config DRM_XE_EUDEBUG
+	bool "Enable gdb debugger support (eudebug)"
+	depends on DRM_XE
+	default n
+	help
+	  Choose this option if you want to add support for a debugger (gdb)
+	  to attach to a process using Xe and debug its gpu/gpgpu programs.
+	  With debugger support, Xe provides an interface for a debugger to
+	  track, inspect and modify the resources of that process.
+
 menu "drm/Xe Debugging"
 depends on DRM_XE
 depends on EXPERT
diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 0392ba58dd65..d42620e10c26 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -163,6 +163,9 @@ xe-$(CONFIG_I2C)	+= xe_i2c.o \
 xe-$(CONFIG_DRM_XE_GPUSVM) += xe_svm.o
 xe-$(CONFIG_DRM_GPUSVM) += xe_userptr.o
 
+# debugging shaders with gdb (eudebug) support
+xe-$(CONFIG_DRM_XE_EUDEBUG) += xe_eudebug.o
+
 # graphics hardware monitoring (HWMON) support
 xe-$(CONFIG_HWMON) += xe_hwmon.o
 
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 273e2c45fea9..ed28abc4f37f 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -34,6 +34,7 @@
 #include "xe_dma_buf.h"
 #include "xe_drm_client.h"
 #include "xe_drv.h"
+#include "xe_eudebug.h"
 #include "xe_exec.h"
 #include "xe_exec_queue.h"
 #include "xe_force_wake.h"
@@ -181,6 +182,8 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
 
 	guard(xe_pm_runtime)(xe);
 
+	xe_eudebug_file_close(xef);
+
 	/*
 	 * No need for exec_queue.lock here as there is no contention for it
 	 * when FD is closing as IOCTLs presumably can't be modifying the
@@ -231,6 +234,7 @@ static const struct drm_ioctl_desc xe_ioctls[] = {
 			  DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(XE_VM_GET_PROPERTY, xe_vm_get_property_ioctl,
 			  DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XE_EUDEBUG_CONNECT, xe_eudebug_connect_ioctl, DRM_RENDER_ALLOW),
 };
 
 static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -1064,6 +1068,8 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		return err;
 
+	xe_eudebug_init_early(xe);
+
 	err = drm_dev_register(&xe->drm, 0);
 	if (err)
 		return err;
@@ -1101,6 +1107,8 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		goto err_unregister_display;
 
+	xe_eudebug_init(xe);
+
 	detect_preproduction_hw(xe);
 
 	err = devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index d99881c6e1d5..000bf91bc5f0 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -15,6 +15,7 @@
 #include "xe_cper_types.h"
 #include "xe_devcoredump_types.h"
 #include "xe_drm_ras_types.h"
+#include "xe_eudebug_types.h"
 #include "xe_heci_gsc.h"
 #include "xe_late_bind_fw_types.h"
 #include "xe_oa_types.h"
@@ -621,6 +622,26 @@ struct xe_device {
 	atomic_t g2g_test_count;
 #endif
 
+#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
+	/** @eudebug: eudebug globals for the device */
+	struct {
+		/** @eudebug.session_count: session counter to track connections */
+		u64 session_count;
+
+		/**
+		 * @eudebug.cap_state: eudebug capability state, protected by
+		 * @eudebug.lock
+		 */
+		enum xe_eudebug_cap_state cap_state;
+
+		/** @eudebug.attached: number of debuggers currently attached */
+		unsigned int attached;
+
+		/** @eudebug.lock: protects the eudebug state of this device */
+		struct mutex lock;
+	} eudebug;
+#endif
+
 	/* private: */
 
 #if IS_ENABLED(CONFIG_DRM_XE_DISPLAY)
@@ -708,6 +729,14 @@ struct xe_file {
 		/** @mmio_gem.pci_barrier: MMIO GEM object for PCI barrier mmap. */
 		struct xe_mmio_gem *pci_barrier;
 	} mmio_gem;
+
+#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
+	/** @eudebug: struct to hold eudebug connection specifics */
+	struct {
+		/** @eudebug.debugger: the debugger connection into this xe_file */
+		struct xe_eudebug *debugger;
+	} eudebug;
+#endif
 };
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
new file mode 100644
index 000000000000..0a57d99fc5e8
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -0,0 +1,1212 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2023-2025 Intel Corporation
+ */
+
+#include <linux/anon_inodes.h>
+#include <linux/cleanup.h>
+#include <linux/poll.h>
+#include <linux/uaccess.h>
+
+#include <drm/drm_drv.h>
+#include <drm/drm_managed.h>
+#include <uapi/drm/xe_drm.h>
+
+#include "xe_assert.h"
+#include "xe_device.h"
+#include "xe_eudebug.h"
+#include "xe_eudebug_types.h"
+#include "xe_macros.h"
+#include "xe_vm.h"
+
+#define cast_event(T, event) container_of((event), typeof(*(T)), base)
+
+static const struct rhashtable_params rhash_res = {
+	.head_offset = offsetof(struct xe_eudebug_handle, rh_head),
+	.key_len = sizeof_field(struct xe_eudebug_handle, key),
+	.key_offset = offsetof(struct xe_eudebug_handle, key),
+	.automatic_shrinking = true,
+};
+
+static struct xe_eudebug_resource *
+resource_from_type(struct xe_eudebug *d, int t)
+{
+	return &d->target.res[t];
+}
+
+static int
+xe_eudebug_resources_init(struct xe_eudebug *d)
+{
+	int ret;
+	int i;
+
+	ret = 0;
+	for (i = 0; i < XE_EUDEBUG_RES_TYPE_COUNT; i++) {
+		struct xe_eudebug_resource *r = resource_from_type(d, i);
+
+		xa_init_flags(&r->xa, XA_FLAGS_ALLOC1);
+		ret = rhashtable_init(&r->rh, &rhash_res);
+
+		if (ret) {
+			xa_destroy(&r->xa);
+			break;
+		}
+	}
+
+	if (!ret)
+		return 0;
+
+	while (i--) {
+		struct xe_eudebug_resource *r = resource_from_type(d, i);
+
+		xa_destroy(&r->xa);
+		rhashtable_destroy(&r->rh);
+	}
+
+	return ret;
+}
+
+/*
+ * Drop every handle, keeping the maps themselves usable.
+ *
+ * The maps hold raw pointers to the target's resources, and the reference
+ * that keeps those alive belongs to the target, not to us. Once the target
+ * is detached it is free to destroy them, so the handles go in the same
+ * critical section that detaches us. A lookup then either sees a live
+ * resource or finds us detached.
+ */
+static void
+xe_eudebug_resources_clear(struct xe_eudebug *d)
+{
+	unsigned long j;
+	int err;
+	int i;
+
+	lockdep_assert_held(&d->lock);
+
+	for (i = 0; i < XE_EUDEBUG_RES_TYPE_COUNT; i++) {
+		struct xe_eudebug_resource *r = resource_from_type(d, i);
+		struct xe_eudebug_handle *h;
+
+		xa_for_each(&r->xa, j, h) {
+			struct xe_eudebug_handle *t;
+
+			err = rhashtable_remove_fast(&r->rh,
+						     &h->rh_head,
+						     rhash_res);
+			xe_eudebug_assert(d, !err);
+			t = xa_erase(&r->xa, h->id);
+			if (XE_WARN_ON(!t))
+				continue;
+
+			xe_eudebug_assert(d, t == h);
+			kfree(t);
+		}
+	}
+}
+
+static void
+xe_eudebug_resources_destroy(struct xe_eudebug *d)
+{
+	int i;
+
+	scoped_guard(mutex, &d->lock)
+		xe_eudebug_resources_clear(d);
+
+	for (i = 0; i < XE_EUDEBUG_RES_TYPE_COUNT; i++) {
+		struct xe_eudebug_resource *r = resource_from_type(d, i);
+
+		rhashtable_destroy(&r->rh);
+		xe_eudebug_assert(d, xa_empty(&r->xa));
+		xa_destroy(&r->xa);
+	}
+}
+
+static bool __xe_eudebug_is_detached(struct xe_eudebug *d)
+{
+	lockdep_assert_held(&d->lock);
+
+	return !d->target.xef;
+}
+
+static bool xe_eudebug_is_detached(struct xe_eudebug *d)
+{
+	guard(mutex)(&d->lock);
+
+	return __xe_eudebug_is_detached(d);
+}
+
+static void xe_eudebug_free(struct kref *ref)
+{
+	struct xe_eudebug *d = container_of(ref, typeof(*d), ref);
+
+	xe_assert(d->xe, xe_eudebug_is_detached(d));
+
+	xe_eudebug_resources_destroy(d);
+
+	kvfree(d->events.fifo_buf);
+	kvfree(d->events.staging);
+	kvfree(d->events.pending);
+	mutex_destroy(&d->lock);
+	kfree(d);
+}
+
+static void xe_eudebug_put(struct xe_eudebug *d)
+{
+	kref_put(&d->ref, xe_eudebug_free);
+}
+
+static bool xe_eudebug_detach(struct xe_eudebug *d,
+			      const int err)
+{
+	struct xe_file *target = NULL;
+
+	XE_WARN_ON(err > 0);
+
+	mutex_lock(&d->xe->eudebug.lock);
+
+	/*
+	 * The target may start tearing its resources down the moment it has
+	 * been detached, and the fd close path does exactly that. Drop the
+	 * handles in the same critical section, so nothing can be resolved
+	 * afterwards.
+	 */
+	scoped_guard(mutex, &d->lock) {
+		if (d->target.xef) {
+			target = d->target.xef;
+			d->target.err = err;
+			d->target.xef = NULL;
+			xe_eudebug_resources_clear(d);
+		}
+	}
+
+	if (target) {
+		XE_WARN_ON(target->eudebug.debugger != d);
+		target->eudebug.debugger = NULL;
+
+		d->xe->eudebug.attached--;
+
+		eu_dbg(d, "session %llu detached with %d", d->session, err);
+	}
+	mutex_unlock(&d->xe->eudebug.lock);
+
+	wake_up_all(&d->events.write_done);
+
+	if (target) {
+		xe_eudebug_put(d);
+		xe_file_put(target);
+	}
+
+	return !!target;
+}
+
+#define xe_eudebug_disconnect(_d, _err) ({ \
+	struct xe_eudebug *__disc_d = (_d); \
+	int __disc_err = (_err); \
+	if (xe_eudebug_detach(__disc_d, __disc_err)) \
+		eu_dbg(__disc_d, "Session disconnected, err = %d (%s:%d)", \
+		       __disc_err, __func__, __LINE__); \
+})
+
+static int event_fifo_pending(struct xe_eudebug *d,
+			      struct drm_xe_eudebug_event **pending)
+{
+	struct drm_xe_eudebug_event *e = d->events.pending;
+	unsigned int len, copied;
+
+	lockdep_assert_held(&d->lock);
+
+	*pending = NULL;
+
+	if (__xe_eudebug_is_detached(d))
+		return -ENOTCONN;
+
+	if (d->events.pending_occupied) {
+		*pending = e;
+		return 0;
+	}
+
+	if (kfifo_out_peek(&d->events.fifo, e, sizeof(*e)) < sizeof(*e))
+		return -ENOENT;
+
+	len = e->len;
+	if (len <= sizeof(*e) || len > XE_EUDEBUG_EVENT_MAX_SIZE) {
+		eu_dbg(d, "bad event len %u", len);
+		return -EIO;
+	}
+
+	copied = kfifo_out(&d->events.fifo, e, len);
+	if (copied != len) {
+		eu_dbg(d, "fifo inconsistency");
+		return -EIO;
+	}
+
+	d->events.pending_occupied = true;
+	*pending = e;
+
+	return 0;
+}
+
+/* Read and written under xe->eudebug.lock, see @eudebug.cap_state */
+static void set_cap_state(struct xe_device *xe, enum xe_eudebug_cap_state state)
+{
+	lockdep_assert_held(&xe->eudebug.lock);
+
+	xe->eudebug.cap_state = state;
+}
+
+static bool __xe_eudebug_is_enabled(struct xe_device *xe)
+{
+	lockdep_assert_held(&xe->eudebug.lock);
+
+	return xe->eudebug.cap_state == XE_EUDEBUG_CAP_ENABLED;
+}
+
+bool xe_eudebug_is_enabled(struct xe_device *xe)
+{
+	guard(mutex)(&xe->eudebug.lock);
+
+	return __xe_eudebug_is_enabled(xe);
+}
+
+static struct xe_eudebug *
+xe_eudebug_get(struct xe_file *xef)
+{
+	struct xe_device *xe = xef->xe;
+	struct xe_eudebug *d;
+
+	mutex_lock(&xe->eudebug.lock);
+	d = xef->eudebug.debugger;
+	if (d && !kref_get_unless_zero(&d->ref))
+		d = NULL;
+	mutex_unlock(&xe->eudebug.lock);
+
+	if (d && xe_eudebug_is_detached(d)) {
+		xe_eudebug_put(d);
+		d = NULL;
+	}
+
+	return d;
+}
+
+static int xe_eudebug_queue_event(struct xe_eudebug *d,
+				  struct drm_xe_eudebug_event *event)
+{
+	unsigned int copied;
+
+	lockdep_assert_held(&d->lock);
+
+	xe_eudebug_assert(d, event->len > sizeof(struct drm_xe_eudebug_event));
+	xe_eudebug_assert(d, event->type);
+	xe_eudebug_assert(d, event->type != DRM_XE_EUDEBUG_EVENT_READ);
+	xe_eudebug_assert(d, event->len <= XE_EUDEBUG_EVENT_MAX_SIZE);
+	xe_eudebug_assert(d, event == d->events.staging);
+
+	if (__xe_eudebug_is_detached(d))
+		return -ENOTCONN;
+
+	if (kfifo_avail(&d->events.fifo) < event->len)
+		return -ENOSPC;
+
+	copied = kfifo_in(&d->events.fifo, event, event->len);
+	if (XE_WARN_ON(copied != event->len))
+		return -EIO;
+
+	wake_up_all(&d->events.write_done);
+
+	return 0;
+}
+
+static struct xe_eudebug_handle *
+alloc_handle(const u64 key)
+{
+	struct xe_eudebug_handle *h;
+
+	h = kzalloc_obj(*h, GFP_KERNEL);
+	if (!h)
+		return NULL;
+
+	h->key = key;
+
+	return h;
+}
+
+static struct xe_eudebug_handle *
+__find_handle(struct xe_eudebug_resource *r,
+	      const u64 key)
+{
+	struct xe_eudebug_handle *h;
+
+	h = rhashtable_lookup_fast(&r->rh,
+				   &key,
+				   rhash_res);
+	return h;
+}
+
+/*
+ * Adding a handle is split around d->lock: handle_prepare() allocates the
+ * handle and reserves its id, __handle_insert() publishes it and stamps
+ * @seqno under the lock, and handle_abort() undoes a prepare that did not
+ * get inserted. _xe_eudebug_add_handle() does all three. A caller with
+ * more to do in the same critical section calls them itself.
+ */
+static struct xe_eudebug_handle *
+handle_prepare(struct xe_eudebug *d, int type, void *p)
+{
+	struct xe_eudebug_resource *r;
+	struct xe_eudebug_handle *h;
+	int err;
+
+	if (XE_WARN_ON(!p))
+		return ERR_PTR(-EINVAL);
+
+	h = alloc_handle((uintptr_t)p);
+	if (!h)
+		return ERR_PTR(-ENOMEM);
+
+	r = resource_from_type(d, type);
+
+	/*
+	 * Reserve the id, and the nodes backing it, before taking the lock.
+	 * A reserved entry reads back as NULL, so nothing can observe the id
+	 * until __handle_insert() stores the handle, and that store is
+	 * guaranteed to find the slot already there and so never has to
+	 * allocate.
+	 *
+	 * Allocate cyclically so a freed id is not handed out again while
+	 * the DESTROY event that freed it may still be on its way to the
+	 * fifo. A debugger applying events in read order would otherwise see
+	 * a CREATE for an id it still considers live.
+	 */
+	err = xa_alloc_cyclic(&r->xa, &h->id, XA_ZERO_ENTRY, xa_limit_31b,
+			      &r->next_id, GFP_KERNEL);
+	if (err < 0) {
+		kfree(h);
+		return ERR_PTR(err);
+	}
+
+	return h;
+}
+
+static void handle_abort(struct xe_eudebug *d, int type,
+			 struct xe_eudebug_handle *h)
+{
+	xa_erase(&resource_from_type(d, type)->xa, h->id);
+	kfree(h);
+}
+
+/* Return: the handle id, or a negative error after which the caller aborts */
+static int __handle_insert(struct xe_eudebug *d, int type,
+			   struct xe_eudebug_handle *h, u64 *seqno)
+{
+	struct xe_eudebug_resource *r = resource_from_type(d, type);
+	int err;
+
+	lockdep_assert_held(&d->lock);
+
+	if (__find_handle(r, h->key))
+		return -EEXIST;
+
+	/*
+	 * A detach marks us detached and clears the map in one critical
+	 * section, so a handle either goes in before it and is dropped by it,
+	 * or not at all.
+	 */
+	if (__xe_eudebug_is_detached(d))
+		return -ENOTCONN;
+
+	err = rhashtable_insert_fast(&r->rh, &h->rh_head, rhash_res);
+	if (err)
+		return err;
+
+	xa_store(&r->xa, h->id, h, GFP_ATOMIC);
+
+	/*
+	 * Stamped at generation, not at queueing, so concurrent producers can
+	 * take N and N+1 and then queue them the other way round. That is by
+	 * design: the number is the debugger's timeline, not the delivery
+	 * order. See drm_xe_eudebug_event.seqno.
+	 */
+	if (seqno)
+		*seqno = atomic64_inc_return(&d->events.seqno);
+
+	xe_eudebug_assert(d, h->id);
+
+	return h->id;
+}
+
+static int _xe_eudebug_add_handle(struct xe_eudebug *d,
+				  int type,
+				  void *p,
+				  u64 *seqno)
+{
+	struct xe_eudebug_handle *h;
+	int id;
+
+	h = handle_prepare(d, type, p);
+	if (IS_ERR(h))
+		return PTR_ERR(h);
+
+	scoped_guard(mutex, &d->lock)
+		id = __handle_insert(d, type, h, seqno);
+
+	if (id < 0)
+		handle_abort(d, type, h);
+
+	return id;
+}
+
+static int xe_eudebug_add_handle(struct xe_eudebug *d,
+				 int type,
+				 void *p,
+				 u64 *seqno)
+{
+	int ret;
+
+	ret = _xe_eudebug_add_handle(d, type, p, seqno);
+
+	eu_dbg(d, "handle type %d handle %p added: %d\n", type, p, ret);
+
+	return ret;
+}
+
+/* Return: the removed handle's id, or a negative error */
+static int __xe_eudebug_remove_handle(struct xe_eudebug *d, int type, void *p,
+				      u64 *seqno)
+{
+	const u64 key = (uintptr_t)p;
+	struct xe_eudebug_resource *r;
+	struct xe_eudebug_handle *h, *xa_h;
+	int ret;
+
+	lockdep_assert_held(&d->lock);
+
+	if (XE_WARN_ON(!key))
+		return -EINVAL;
+
+	r = resource_from_type(d, type);
+
+	h = __find_handle(r, key);
+	if (!h)
+		return -ENOENT;
+
+	xa_h = xa_load(&r->xa, h->id);
+	if (XE_WARN_ON(!xa_h || xa_h != h))
+		return -EIO;
+
+	ret = rhashtable_remove_fast(&r->rh,
+				     &h->rh_head,
+				     rhash_res);
+	if (XE_WARN_ON(ret))
+		return -EIO;
+
+	xa_h = xa_erase(&r->xa, h->id);
+	if (XE_WARN_ON(xa_h != h))
+		return -EIO;
+
+	ret = h->id;
+	if (seqno)
+		*seqno = atomic64_inc_return(&d->events.seqno);
+
+	kfree(h);
+
+	return ret;
+}
+
+static int _xe_eudebug_remove_handle(struct xe_eudebug *d, int type, void *p,
+				     u64 *seqno)
+{
+	guard(mutex)(&d->lock);
+
+	return __xe_eudebug_remove_handle(d, type, p, seqno);
+}
+
+static int xe_eudebug_remove_handle(struct xe_eudebug *d, int type, void *p,
+				    u64 *seqno)
+{
+	int ret;
+
+	ret = _xe_eudebug_remove_handle(d, type, p, seqno);
+
+	eu_dbg(d, "handle type %d handle %p removed: %d\n", type, p, ret);
+
+	return ret;
+}
+
+static struct drm_xe_eudebug_event *
+xe_eudebug_prepare_event(struct xe_eudebug *d, u16 type, u64 seqno, u16 flags,
+			 u32 len)
+{
+	const u16 known_flags =
+		DRM_XE_EUDEBUG_EVENT_CREATE |
+		DRM_XE_EUDEBUG_EVENT_DESTROY;
+	struct drm_xe_eudebug_event *event = d->events.staging;
+
+	lockdep_assert_held(&d->lock);
+
+	xe_eudebug_assert(d, type <= XE_EUDEBUG_MAX_EVENT_TYPE);
+	xe_eudebug_assert(d, !(~known_flags & flags));
+	xe_eudebug_assert(d, len > sizeof(*event));
+	xe_eudebug_assert(d, len <= XE_EUDEBUG_EVENT_MAX_SIZE);
+
+	memset(event, 0, len);
+
+	event->len = len;
+	event->type = type;
+	event->flags = flags;
+	event->seqno = seqno;
+
+	return event;
+}
+
+static int send_vm_event(struct xe_eudebug *d, u32 flags,
+			 const u64 vm_handle,
+			 const u64 seqno)
+{
+	struct drm_xe_eudebug_event *event;
+	struct drm_xe_eudebug_event_vm *e;
+	int err;
+
+	scoped_guard(mutex, &d->lock) {
+		event = xe_eudebug_prepare_event(d, DRM_XE_EUDEBUG_EVENT_VM,
+						 seqno, flags, sizeof(*e));
+		e = cast_event(e, event);
+		e->vm_handle = vm_handle;
+
+		err = xe_eudebug_queue_event(d, event);
+	}
+
+	return err;
+}
+
+static int vm_create_event(struct xe_eudebug *d, struct xe_vm *vm)
+{
+	int vm_id;
+	u64 seqno;
+	int ret;
+
+	vm_id = xe_eudebug_add_handle(d, XE_EUDEBUG_RES_TYPE_VM, vm, &seqno);
+	if (vm_id < 0)
+		return vm_id;
+
+	ret = send_vm_event(d, DRM_XE_EUDEBUG_EVENT_CREATE, vm_id, seqno);
+	if (ret)
+		eu_dbg(d, "send_vm_event create error %d\n", ret);
+
+	return ret;
+}
+
+static int vm_destroy_event(struct xe_eudebug *d, struct xe_vm *vm)
+{
+	int vm_id;
+	u64 seqno;
+	int ret;
+
+	vm_id = xe_eudebug_remove_handle(d, XE_EUDEBUG_RES_TYPE_VM, vm, &seqno);
+	if (vm_id < 0)
+		return vm_id;
+
+	ret = send_vm_event(d, DRM_XE_EUDEBUG_EVENT_DESTROY, vm_id, seqno);
+	if (ret)
+		eu_dbg(d, "send_vm_event destroy error %d\n", ret);
+
+	return ret;
+}
+
+void xe_eudebug_vm_create(struct xe_file *xef, struct xe_vm *vm)
+{
+	struct xe_eudebug *d;
+	int err;
+
+	/* Debuggable queues run on fault mode vms only, see exec_queue_set_eudebug() */
+	if (!xe_vm_in_fault_mode(vm))
+		return;
+
+	d = xe_eudebug_get(xef);
+	if (!d)
+		return;
+
+	err = vm_create_event(d, vm);
+	if (err)
+		xe_eudebug_disconnect(d, err);
+
+	xe_eudebug_put(d);
+}
+
+void xe_eudebug_vm_destroy(struct xe_file *xef, struct xe_vm *vm)
+{
+	struct xe_eudebug *d;
+	int err;
+
+	if (!xe_vm_in_fault_mode(vm))
+		return;
+
+	d = xe_eudebug_get(xef);
+	if (!d)
+		return;
+
+	/*
+	 * A vm we never handed out to the debugger needs no destroy event.
+	 * Only a genuine bookkeeping inconsistency should drop the session.
+	 */
+	err = vm_destroy_event(d, vm);
+	if (err && err != -ENOENT)
+		xe_eudebug_disconnect(d, err);
+
+	xe_eudebug_put(d);
+}
+
+static int add_debugger(struct xe_device *xe, struct xe_eudebug *d,
+			struct drm_file *target)
+{
+	struct xe_file *xef = target->driver_priv;
+
+	guard(mutex)(&xe->eudebug.lock);
+
+	if (!__xe_eudebug_is_enabled(xe))
+		return -EOPNOTSUPP;
+
+	if (xef->eudebug.debugger)
+		return -EBUSY;
+
+	scoped_guard(mutex, &d->lock)
+		d->target.xef = xe_file_get(xef);
+	d->target.pid = xef->pid;
+	kref_get(&d->ref);
+	xef->eudebug.debugger = d;
+
+	xe->eudebug.attached++;
+
+	do {
+		d->session = ++xe->eudebug.session_count;
+	} while (!d->session);
+
+	return 0;
+}
+
+static int
+xe_eudebug_attach(struct xe_device *xe, struct drm_file *parent_file,
+		  struct xe_eudebug *d, u64 target_fd)
+{
+	struct drm_file *drm_file;
+	struct xe_file *target_xef;
+	int ret;
+
+	if (XE_IOCTL_DBG(xe, target_fd > INT_MAX))
+		return -EBADF;
+
+	struct file *file __free(fput) = fget(target_fd);
+	if (XE_IOCTL_DBG(xe, !file))
+		return -EBADF;
+
+	drm_file = file->private_data;
+	if (XE_IOCTL_DBG(xe, !drm_file))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, parent_file->filp->f_op != file->f_op))
+		return -EINVAL;
+
+	target_xef = drm_file->driver_priv;
+	if (XE_IOCTL_DBG(xe, !target_xef))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, xe != target_xef->xe))
+		return -EINVAL;
+
+	ret = add_debugger(xe, d, drm_file);
+	if (XE_IOCTL_DBG(xe, ret))
+		return ret;
+
+	eu_dbg(d, "session %llu attached to %s", d->session,
+	       parent_file == drm_file ? "self" : "remote");
+
+	return 0;
+}
+
+static int xe_eudebug_release(struct inode *inode, struct file *file)
+{
+	struct xe_eudebug *d = file->private_data;
+	struct drm_device *drm = &d->xe->drm;
+
+	xe_eudebug_disconnect(d, 0);
+	xe_eudebug_put(d);
+
+	drm_dev_put(drm);
+
+	return 0;
+}
+
+static bool __event_fifo_has_events(struct xe_eudebug *d)
+{
+	lockdep_assert_held(&d->lock);
+
+	if (d->events.pending_occupied)
+		return true;
+
+	return kfifo_len(&d->events.fifo) > sizeof(struct drm_xe_eudebug_event);
+}
+
+static bool event_fifo_has_events(struct xe_eudebug *d)
+{
+	guard(mutex)(&d->lock);
+
+	/* Allow all waiters to proceed to check their state */
+	return __xe_eudebug_is_detached(d) || __event_fifo_has_events(d);
+}
+
+/*
+ * wait_event_*() evaluates its condition with the task already marked as
+ * sleeping, where the lock cannot be taken. wait_woken() lets us check
+ * the condition while running, without losing a wakeup in between.
+ *
+ * Return: as wait_event_interruptible_timeout()
+ */
+static long wait_for_events(struct xe_eudebug *d, long timeout)
+{
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+
+	add_wait_queue(&d->events.write_done, &wait);
+	while (!event_fifo_has_events(d)) {
+		if (signal_pending(current)) {
+			timeout = -ERESTARTSYS;
+			break;
+		}
+
+		if (!timeout)
+			break;
+
+		timeout = wait_woken(&wait, TASK_INTERRUPTIBLE, timeout);
+	}
+	remove_wait_queue(&d->events.write_done, &wait);
+
+	return timeout;
+}
+
+static __poll_t xe_eudebug_poll(struct file *file, poll_table *wait)
+{
+	struct xe_eudebug * const d = file->private_data;
+	__poll_t ret = 0;
+
+	poll_wait(file, &d->events.write_done, wait);
+
+	guard(mutex)(&d->lock);
+
+	if (__xe_eudebug_is_detached(d)) {
+		/* Queued events went with the detach, READ_EVENT only fails */
+		ret = EPOLLHUP;
+		if (d->target.err)
+			ret |= EPOLLERR;
+	} else if (__event_fifo_has_events(d)) {
+		ret = EPOLLIN;
+	}
+
+	return ret;
+}
+
+static void xe_eudebug_reader_clear(struct xe_eudebug *d)
+{
+	if (!d)
+		return;
+
+	guard(mutex)(&d->lock);
+	d->events.reader_active = false;
+}
+
+DEFINE_FREE(reader_active, struct xe_eudebug *, xe_eudebug_reader_clear(_T))
+
+static long xe_eudebug_read_event(struct xe_eudebug *d,
+				  const u64 arg,
+				  const bool wait)
+{
+	struct xe_device *xe = d->xe;
+	struct drm_xe_eudebug_event __user * const user_orig =
+		u64_to_user_ptr(arg);
+	struct drm_xe_eudebug_event user_event;
+	struct drm_xe_eudebug_event *pending;
+	long ret = 0;
+	int pending_len = 0;
+	int fifo_ret;
+
+	if (XE_IOCTL_DBG(xe, copy_from_user(&user_event, user_orig, sizeof(user_event))))
+		return -EFAULT;
+
+	if (XE_IOCTL_DBG(xe, user_event.type != DRM_XE_EUDEBUG_EVENT_READ))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, user_event.len < sizeof(*user_orig)))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, user_event.flags))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, user_event.seqno))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, user_event.reserved))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, xe_eudebug_is_detached(d)))
+		return -ENOTCONN;
+
+	scoped_guard(mutex, &d->lock) {
+		if (d->events.reader_active)
+			return -EBUSY;
+
+		d->events.reader_active = true;
+	}
+
+	struct xe_eudebug *reader __free(reader_active) = d;
+
+	/* XXX: define wait time in connect arguments ? */
+	if (wait) {
+		ret = wait_for_events(d, secs_to_jiffies(5));
+
+		if (XE_IOCTL_DBG(xe, ret < 0))
+			return ret;
+	}
+
+	mutex_lock(&d->lock);
+	fifo_ret = event_fifo_pending(d, &pending);
+	if (fifo_ret == 0) {
+		if (user_event.len < pending->len) {
+			pending_len = pending->len;
+			ret = -EMSGSIZE;
+		} else if (!access_ok(user_orig, pending->len)) {
+			ret = -EFAULT;
+		} else {
+			eu_dbg(d, "event read: type=%u, flags=0x%x, seqno=%llu",
+			       pending->type, pending->flags, pending->seqno);
+			ret = 0;
+		}
+	} else if (fifo_ret == -ENOENT) {
+		ret = wait ? -ETIMEDOUT : -EAGAIN;
+	} else {
+		ret = fifo_ret;		/* -ENOTCONN or -EIO */
+	}
+	mutex_unlock(&d->lock);
+
+	/* disconnect takes xe->eudebug.lock, so do it only after dropping ours */
+	if (fifo_ret == -EIO)
+		xe_eudebug_disconnect(d, -EIO);
+
+	if (ret == -EMSGSIZE) {
+		if (XE_IOCTL_DBG(xe, put_user(pending_len, &user_orig->len)))
+			ret = -EFAULT;
+	}
+
+	/*
+	 * Copied without d->lock, so that faulting on the user pointer does not
+	 * happen under it. Nothing else touches @events.pending meanwhile: only
+	 * event_fifo_pending() writes it, only the reader marked by
+	 * @events.reader_active calls that, and the event stays occupied until
+	 * the copy has succeeded.
+	 */
+	if (!ret && __copy_to_user(user_orig, pending, pending->len))
+		ret = -EFAULT;
+
+	if (!ret) {
+		mutex_lock(&d->lock);
+		d->events.pending_occupied = false;
+		mutex_unlock(&d->lock);
+	}
+	if (ret)
+		eu_dbg(d, "event read=%ld", ret);
+
+	return ret;
+}
+
+/**
+ * xe_eudebug_ioctl - Issue a command to eudebug interface
+ *
+ * @file : eudebug file (returned from connect)
+ * @cmd : cmd
+ * @arg : arguments depending on cmd
+ *
+ * Issue a eudebug command
+ *
+ * Return: 0 on success, negative error code on failure. -ENOTTY for an
+ * unknown command.
+ */
+static long xe_eudebug_ioctl(struct file *file,
+			     unsigned int cmd,
+			     unsigned long arg)
+{
+	struct xe_eudebug * const d = file->private_data;
+	long ret;
+
+	switch (cmd) {
+	case DRM_XE_EUDEBUG_IOCTL_READ_EVENT:
+		ret = xe_eudebug_read_event(d, arg,
+					    !(file->f_flags & O_NONBLOCK));
+		break;
+	default:
+		ret = -ENOTTY;
+	}
+
+	return ret;
+}
+
+static const struct file_operations fops = {
+	.owner		= THIS_MODULE,
+	.release	= xe_eudebug_release,
+	.poll		= xe_eudebug_poll,
+	.unlocked_ioctl	= xe_eudebug_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+};
+
+/*
+ * Tell lockdep up front where the lock sits, so that a violation is
+ * reported on the first run rather than once both paths have been seen.
+ * Reclaim never takes it, so allocating under it is fine.
+ */
+static void xe_eudebug_lock_prime(struct xe_eudebug *d)
+{
+	if (!IS_ENABLED(CONFIG_LOCKDEP))
+		return;
+
+	mutex_lock(&d->lock);
+	fs_reclaim_acquire(GFP_KERNEL);
+	fs_reclaim_release(GFP_KERNEL);
+	mutex_unlock(&d->lock);
+}
+
+static int
+xe_eudebug_connect(struct xe_device *xe,
+		   struct drm_file *drm_file,
+		   struct drm_xe_eudebug_connect *param)
+{
+	const u64 known_open_flags = 0;
+	struct xe_eudebug *d;
+	struct file *file;
+	int fd, err;
+
+	if (XE_IOCTL_DBG(xe, param->extensions))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, param->flags & ~known_open_flags))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, param->reserved))
+		return -EINVAL;
+
+	if (!xe_eudebug_is_enabled(xe))
+		return -EOPNOTSUPP;
+
+	d = kzalloc_obj(*d, GFP_KERNEL | __GFP_ACCOUNT);
+	if (XE_IOCTL_DBG(xe, !d))
+		return -ENOMEM;
+
+	d->xe = xe;
+
+	kref_init(&d->ref);
+	mutex_init(&d->lock);
+	xe_eudebug_lock_prime(d);
+	init_waitqueue_head(&d->events.write_done);
+
+	err = xe_eudebug_resources_init(d);
+	if (XE_IOCTL_DBG(xe, err)) {
+		mutex_destroy(&d->lock);
+		kfree(d);
+		return err;
+	}
+
+	d->events.pending = kvzalloc(XE_EUDEBUG_EVENT_MAX_SIZE,
+				     GFP_KERNEL | __GFP_ACCOUNT);
+	if (!d->events.pending) {
+		err = -ENOMEM;
+		goto err_put;
+	}
+
+	d->events.staging = kvzalloc(XE_EUDEBUG_EVENT_MAX_SIZE,
+				     GFP_KERNEL | __GFP_ACCOUNT);
+	if (!d->events.staging) {
+		err = -ENOMEM;
+		goto err_put;
+	}
+
+	d->events.fifo_buf = kvmalloc(XE_EUDEBUG_FIFO_SIZE,
+				      GFP_KERNEL | __GFP_ACCOUNT);
+	if (!d->events.fifo_buf) {
+		err = -ENOMEM;
+		goto err_put;
+	}
+
+	err = kfifo_init(&d->events.fifo, d->events.fifo_buf, XE_EUDEBUG_FIFO_SIZE);
+	if (XE_IOCTL_DBG(xe, err))
+		goto err_put;
+
+	err = xe_eudebug_attach(xe, drm_file, d, param->fd);
+	if (XE_IOCTL_DBG(xe, err))
+		goto err_put;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		err = fd;
+		goto err_detach;
+	}
+
+	file = anon_inode_getfile("[xe_eudebug]", &fops, d, 0);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_fd;
+	}
+
+	eu_dbg(d, "connected session %llu", d->session);
+
+	drm_dev_get(&xe->drm);
+
+	fd_install(fd, file);
+
+	return fd;
+
+err_fd:
+	put_unused_fd(fd);
+err_detach:
+	xe_eudebug_detach(d, err);
+err_put:
+	xe_eudebug_put(d);
+
+	return err;
+}
+
+void xe_eudebug_file_close(struct xe_file *xef)
+{
+	struct xe_eudebug *d;
+
+	d = xe_eudebug_get(xef);
+	if (d) {
+		xe_eudebug_detach(d, 0);
+		xe_eudebug_put(d);
+	}
+}
+
+static int xe_eudebug_enable(struct xe_device *xe, bool enable)
+{
+	guard(mutex)(&xe->eudebug.lock);
+
+	if (xe->eudebug.cap_state == XE_EUDEBUG_CAP_NOT_SUPPORTED)
+		return -EPERM;
+
+	if (!enable && xe->eudebug.attached)
+		return -EBUSY;
+
+	if (enable == __xe_eudebug_is_enabled(xe))
+		return 0;
+
+	set_cap_state(xe, enable ?
+		      XE_EUDEBUG_CAP_ENABLED : XE_EUDEBUG_CAP_DISABLED);
+
+	return 0;
+}
+
+static ssize_t enable_eudebug_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct xe_device *xe = pdev_to_xe_device(to_pci_dev(dev));
+
+	return sysfs_emit(buf, "%u\n", xe_eudebug_is_enabled(xe));
+}
+
+static ssize_t enable_eudebug_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct xe_device *xe = pdev_to_xe_device(to_pci_dev(dev));
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	ret = xe_eudebug_enable(xe, enable);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(enable_eudebug);
+
+static void xe_eudebug_sysfs_fini(void *arg)
+{
+	struct xe_device *xe = arg;
+	struct drm_device *dev = &xe->drm;
+
+	sysfs_remove_file(&dev->dev->kobj,
+			  &dev_attr_enable_eudebug.attr);
+}
+
+static void xe_eudebug_lock_fini(struct drm_device *dev, void *__unused)
+{
+	mutex_destroy(&to_xe_device(dev)->eudebug.lock);
+}
+
+void xe_eudebug_init_early(struct xe_device *xe)
+{
+	/*
+	 * Not drmm_mutex_init(), which can fail and leave the lock destroyed:
+	 * the state is read under it from here on. Nothing can reach the
+	 * device yet, so the state itself is set without it. Without the
+	 * release action the lock is merely never destroyed, which only
+	 * costs the mutex debug checks.
+	 */
+	mutex_init(&xe->eudebug.lock);
+	if (drmm_add_action(&xe->drm, xe_eudebug_lock_fini, NULL))
+		drm_dbg(&xe->drm, "eudebug lock will not be destroyed\n");
+
+	xe->eudebug.cap_state = XE_EUDEBUG_CAP_DISABLED;
+}
+
+void xe_eudebug_init(struct xe_device *xe)
+{
+	struct drm_device *dev = &xe->drm;
+	int err;
+
+	/* early init failed */
+	if (xe->eudebug.cap_state == XE_EUDEBUG_CAP_NOT_SUPPORTED)
+		return;
+
+	err = devm_add_action_or_reset(dev->dev, xe_eudebug_sysfs_fini, xe);
+	if (err)
+		goto out_err;
+
+	/*
+	 * Last: once the attribute exists it can enable us, and nothing may
+	 * fail and overwrite cap_state after that. Removing a file that was
+	 * never created is a no-op, so the remove action can go first.
+	 */
+	err = sysfs_create_file(&dev->dev->kobj,
+				&dev_attr_enable_eudebug.attr);
+	if (err)
+		goto out_err;
+
+	return;
+
+out_err:
+	drm_warn(&xe->drm, "eudebug disabled, init fail: %d\n", err);
+
+	scoped_guard(mutex, &xe->eudebug.lock)
+		set_cap_state(xe, XE_EUDEBUG_CAP_NOT_SUPPORTED);
+}
+
+/**
+ * xe_eudebug_connect_ioctl - Connect to eudebug interface
+ * @dev : DRM device
+ * @data : ioctl data, (struct drm_xe_eudebug_connect)
+ * @file : DRM file
+ *
+ * Connect to the eudebug interface.
+ *
+ * Return: eudebug filedesriptor on success, negative error code on failure.
+ *
+ */
+int xe_eudebug_connect_ioctl(struct drm_device *dev,
+			     void *data,
+			     struct drm_file *file)
+{
+	struct xe_device *xe = to_xe_device(dev);
+	struct drm_xe_eudebug_connect * const param = data;
+
+	return xe_eudebug_connect(xe, file, param);
+}
diff --git a/drivers/gpu/drm/xe/xe_eudebug.h b/drivers/gpu/drm/xe/xe_eudebug.h
new file mode 100644
index 000000000000..91e604c39814
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_eudebug.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2023-2025 Intel Corporation
+ */
+
+#ifndef _XE_EUDEBUG_H_
+#define _XE_EUDEBUG_H_
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+struct drm_device;
+struct drm_file;
+struct xe_device;
+struct xe_file;
+struct xe_vm;
+
+#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
+
+#define XE_EUDEBUG_DBG_STR  "eudbg: %llu:%lld (%d/%d) -> (%d): "
+
+#define __eu_print(d, func, fmt, ...) \
+	do { \
+		struct xe_eudebug *__pd = (d); \
+		func(&__pd->xe->drm, XE_EUDEBUG_DBG_STR fmt, \
+		     __pd->session, \
+		     atomic64_read(&__pd->events.seqno), \
+		     current->pid, \
+		     task_tgid_nr(current), \
+		     __pd->target.pid, \
+		     ##__VA_ARGS__); \
+	} while (0)
+
+#define eu_dbg(d, fmt, ...)   __eu_print(d, drm_dbg, fmt, ##__VA_ARGS__)
+
+#define xe_eudebug_assert(d, ...) xe_assert((d)->xe, ##__VA_ARGS__)
+
+int xe_eudebug_connect_ioctl(struct drm_device *dev,
+			     void *data,
+			     struct drm_file *file);
+
+void xe_eudebug_init(struct xe_device *xe);
+void xe_eudebug_init_early(struct xe_device *xe);
+bool xe_eudebug_is_enabled(struct xe_device *xe);
+
+void xe_eudebug_file_close(struct xe_file *xef);
+
+void xe_eudebug_vm_create(struct xe_file *xef, struct xe_vm *vm);
+void xe_eudebug_vm_destroy(struct xe_file *xef, struct xe_vm *vm);
+
+#else
+
+static inline int xe_eudebug_connect_ioctl(struct drm_device *dev,
+					   void *data,
+					   struct drm_file *file) { return -EOPNOTSUPP; }
+
+static inline void xe_eudebug_init(struct xe_device *xe) { }
+static inline void xe_eudebug_init_early(struct xe_device *xe) { }
+static inline bool xe_eudebug_is_enabled(struct xe_device *xe) { return false; }
+
+static inline void xe_eudebug_file_close(struct xe_file *xef) { }
+
+static inline void xe_eudebug_vm_create(struct xe_file *xef, struct xe_vm *vm) { }
+static inline void xe_eudebug_vm_destroy(struct xe_file *xef, struct xe_vm *vm) { }
+
+#endif /* CONFIG_DRM_XE_EUDEBUG */
+
+#endif /* _XE_EUDEBUG_H_ */
diff --git a/drivers/gpu/drm/xe/xe_eudebug_types.h b/drivers/gpu/drm/xe/xe_eudebug_types.h
new file mode 100644
index 000000000000..598abb249195
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_eudebug_types.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2023-2025 Intel Corporation
+ */
+
+#ifndef _XE_EUDEBUG_TYPES_H_
+#define _XE_EUDEBUG_TYPES_H_
+
+#include <linux/kfifo.h>
+#include <linux/kref.h>
+#include <linux/mutex.h>
+#include <linux/rhashtable.h>
+#include <linux/sizes.h>
+#include <linux/wait.h>
+#include <linux/xarray.h>
+
+#include <uapi/drm/xe_drm_eudebug.h>
+
+struct xe_device;
+
+/**
+ * enum xe_eudebug_cap_state - eudebug capability state
+ *
+ * @XE_EUDEBUG_CAP_NOT_SUPPORTED: eudebug feature support off
+ * @XE_EUDEBUG_CAP_DISABLED: eudebug feature supported but disabled
+ * @XE_EUDEBUG_CAP_ENABLED: eudebug enabled
+ */
+enum xe_eudebug_cap_state {
+	XE_EUDEBUG_CAP_NOT_SUPPORTED = 0,
+	XE_EUDEBUG_CAP_DISABLED,
+	XE_EUDEBUG_CAP_ENABLED,
+};
+
+#define XE_EUDEBUG_MAX_EVENT_TYPE DRM_XE_EUDEBUG_EVENT_VM
+
+/**
+ * struct xe_eudebug_handle - eudebug resource handle
+ */
+struct xe_eudebug_handle {
+	/** @key: key value in rhashtable <key:id> */
+	u64 key;
+
+	/** @id: opaque handle id for xarray <id:key> */
+	u32 id;
+
+	/** @rh_head: rhashtable head */
+	struct rhash_head rh_head;
+};
+
+/**
+ * struct xe_eudebug_resource - Resource map for one resource
+ */
+struct xe_eudebug_resource {
+	/** @xa: xarrays for <id->key> */
+	struct xarray xa;
+
+	/** @next_id: next id to try in @xa, protected by the @xa lock */
+	u32 next_id;
+
+	/** @rh: rhashtable for <key->id> */
+	struct rhashtable rh;
+};
+
+#define XE_EUDEBUG_RES_TYPE_VM		0
+#define XE_EUDEBUG_RES_TYPE_COUNT	(XE_EUDEBUG_RES_TYPE_VM + 1)
+
+/**
+ * struct xe_eudebug - Top level struct for eudebug: the connection
+ */
+struct xe_eudebug {
+	/** @ref: kref counter for this struct */
+	struct kref ref;
+
+	/**
+	 * @lock: guards all the mutable state of this struct: the target
+	 * link and error, the resource maps, the event queue with its
+	 * buffers and reader, the ack tree and the async disconnect error.
+	 *
+	 * Nests inside the vm reservation of a vm bind and inside
+	 * xe->eudebug.lock, and outside the user fence and xe_file eudebug
+	 * spinlocks. Never touch user memory, disconnect, or drop what may
+	 * be the last reference to this struct or to a user fence while
+	 * holding it.
+	 */
+	struct mutex lock;
+
+	/** @target: debug target specifics */
+	struct {
+		/**
+		 * @target.xef: the target xe_file that we are debugging, NULL
+		 * once detached. Written under both xe->eudebug.lock and
+		 * @lock, so either is enough to read it.
+		 */
+		struct xe_file *xef;
+
+		/** @target.pid: pid of target */
+		pid_t pid;
+
+		/** @target.err: error code on disconnect */
+		int err;
+
+		/** @target.res: resource maps for all types */
+		struct xe_eudebug_resource res[XE_EUDEBUG_RES_TYPE_COUNT];
+	} target;
+
+	/** @xe: the parent device we are serving */
+	struct xe_device *xe;
+
+	/** @session: session number for this connection (for logs) */
+	u64 session;
+
+	/** @events: kfifo queue of to-be-delivered events */
+	struct {
+#define XE_EUDEBUG_EVENT_MAX_SIZE SZ_64K
+		/**
+		 * @events.pending: pending event bounce buffer, preallocated.
+		 * Owned by the reader marked by @events.reader_active, which
+		 * copies it out without @lock while @events.pending_occupied is
+		 * set.
+		 */
+		struct drm_xe_eudebug_event *pending;
+
+		/**
+		 * @events.pending_occupied: @events.pending holds an event
+		 * that was popped from the fifo but not yet delivered
+		 */
+		bool pending_occupied;
+
+		/** @events.reader_active: a read is in progress, only one at a time */
+		bool reader_active;
+
+		/** @events.staging: write side staging buffer, preallocated */
+		struct drm_xe_eudebug_event *staging;
+
+		/** @events.fifo: queue of events pending */
+		struct kfifo fifo;
+
+		/** @events.fifo_buf: memory for the fifo */
+		void *fifo_buf;
+#define XE_EUDEBUG_FIFO_SIZE SZ_4M
+
+		/** @events.write_done: waitqueue for signalling write to fifo */
+		wait_queue_head_t write_done;
+
+		/**
+		 * @events.seqno: seqno counter to stamp events for fifo
+		 *
+		 * Stamped when an event is generated, which is not the same
+		 * moment it reaches the fifo, so concurrent producers can
+		 * take N and N+1 and then queue them the other way round.
+		 *
+		 * That is deliberate. The number is the client timeline the
+		 * debugger reconstructs, not a delivery order. Making the two
+		 * agree would mean holding @lock across event generation,
+		 * serialising the producers and losing the very ordering the
+		 * debugger is after.
+		 *
+		 * See drm_xe_eudebug_event.seqno for what this promises
+		 * userspace.
+		 *
+		 * Atomic, so that it can also be read without @lock, as
+		 * __eu_print() does for every debug message.
+		 */
+		atomic64_t seqno;
+	} events;
+};
+
+#endif /* _XE_EUDEBUG_TYPES_H_ */
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index dd855876f571..b9b851adc9bf 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -28,6 +28,7 @@
 #include "xe_cpu_bind.h"
 #include "xe_device.h"
 #include "xe_drm_client.h"
+#include "xe_eudebug.h"
 #include "xe_exec_queue.h"
 #include "xe_gt.h"
 #include "xe_migrate.h"
@@ -2226,10 +2227,18 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 	args->reserved[0] = xe_bo_main_addr(vm->pt_root[0]->bo, XE_PAGE_SIZE);
 #endif
 
+	/*
+	 * Announce to the debugger before the id is published, as from that
+	 * point on a concurrent destroy can race us to the resource map.
+	 */
+	xe_eudebug_vm_create(xef, vm);
+
 	/* user id alloc must always be last in ioctl to prevent UAF */
 	err = xa_alloc(&xef->vm.xa, &id, vm, xa_limit_32b, GFP_KERNEL);
-	if (err)
+	if (err) {
+		xe_eudebug_vm_destroy(xef, vm);
 		goto err_close_and_put;
+	}
 
 	args->vm_id = id;
 
@@ -2264,8 +2273,10 @@ int xe_vm_destroy_ioctl(struct drm_device *dev, void *data,
 		xa_erase(&xef->vm.xa, args->vm_id);
 	mutex_unlock(&xef->vm.lock);
 
-	if (!err)
+	if (!err) {
+		xe_eudebug_vm_destroy(xef, vm);
 		xe_vm_close_and_put(vm);
+	}
 
 	return err;
 }
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 578f0c1eb43e..942a7fe81f4b 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -85,6 +85,7 @@ extern "C" {
  *  - &DRM_IOCTL_XE_VM_QUERY_MEM_RANGE_ATTRS
  *  - &DRM_IOCTL_XE_EXEC_QUEUE_SET_PROPERTY
  *  - &DRM_IOCTL_XE_VM_GET_PROPERTY
+ *  - &DRM_IOCTL_XE_EUDEBUG_CONNECT
  */
 
 /*
@@ -110,6 +111,7 @@ extern "C" {
 #define DRM_XE_VM_QUERY_MEM_RANGE_ATTRS	0x0d
 #define DRM_XE_EXEC_QUEUE_SET_PROPERTY	0x0e
 #define DRM_XE_VM_GET_PROPERTY		0x0f
+#define DRM_XE_EUDEBUG_CONNECT		0x10
 
 /* Must be kept compact -- no holes */
 
@@ -129,6 +131,7 @@ extern "C" {
 #define DRM_IOCTL_XE_VM_QUERY_MEM_RANGE_ATTRS	DRM_IOWR(DRM_COMMAND_BASE + DRM_XE_VM_QUERY_MEM_RANGE_ATTRS, struct drm_xe_vm_query_mem_range_attr)
 #define DRM_IOCTL_XE_EXEC_QUEUE_SET_PROPERTY	DRM_IOW(DRM_COMMAND_BASE + DRM_XE_EXEC_QUEUE_SET_PROPERTY, struct drm_xe_exec_queue_set_property)
 #define DRM_IOCTL_XE_VM_GET_PROPERTY		DRM_IOWR(DRM_COMMAND_BASE + DRM_XE_VM_GET_PROPERTY, struct drm_xe_vm_get_property)
+#define DRM_IOCTL_XE_EUDEBUG_CONNECT		DRM_IOW(DRM_COMMAND_BASE + DRM_XE_EUDEBUG_CONNECT, struct drm_xe_eudebug_connect)
 
 /**
  * DOC: Xe IOCTL Extensions
@@ -2634,6 +2637,27 @@ enum drm_xe_ras_error_component {
 	[DRM_XE_RAS_ERR_COMP_FABRIC] = "fabric",			\
 }
 
+/**
+ * struct drm_xe_eudebug_connect - Input of &DRM_IOCTL_XE_EUDEBUG_CONNECT
+ *
+ * This structure is used to connect to an eudebug interface of target drm file.
+ */
+struct drm_xe_eudebug_connect {
+	/** @extensions: Pointer to the first extension struct, if any */
+	__u64 extensions;
+
+	/** @fd: Debug target DRM client fd */
+	__u64 fd;
+
+	/** @flags: Flags, MBZ */
+	__u64 flags;
+
+	/** @reserved: MBZ */
+	__u64 reserved;
+};
+
+#include "xe_drm_eudebug.h"
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/include/uapi/drm/xe_drm_eudebug.h b/include/uapi/drm/xe_drm_eudebug.h
new file mode 100644
index 000000000000..63f4a6142a1a
--- /dev/null
+++ b/include/uapi/drm/xe_drm_eudebug.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2023 Intel Corporation
+ */
+
+#ifndef _UAPI_XE_DRM_EUDEBUG_H_
+#define _UAPI_XE_DRM_EUDEBUG_H_
+
+#include "drm.h"
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+/**
+ * DOC: DRM_XE_EUDEBUG_IOCTL_READ_EVENT
+ *
+ * Receive one event from the connection returned by
+ * &DRM_IOCTL_XE_EUDEBUG_CONNECT. The argument is a pointer to a
+ * &struct drm_xe_eudebug_event filled in as described there.
+ *
+ * A connection starts out blocking, and then waits up to five seconds for
+ * an event to arrive; O_NONBLOCK can be set on it with fcntl(). Only one
+ * reader at a time is allowed on a connection.
+ *
+ * Return: 0 on success. Negative error code on failure:
+ *
+ * - -EMSGSIZE if the pending event is larger than the supplied len. len is
+ *   updated with the size needed and the event stays queued.
+ * - -ETIMEDOUT if the blocking wait expired with no event.
+ * - -EAGAIN if O_NONBLOCK was set and no event was queued.
+ * - -EBUSY if another thread is already reading on this connection.
+ * - -ENOTCONN if the debug target is gone.
+ *
+ * Detaching discards whatever is still queued: the events describe resources
+ * of a client that no longer exists, and the handles in them can no longer be
+ * resolved. A debugger that gets -ENOTCONN, or EPOLLHUP from poll(), should
+ * treat the event stream as having ended at an unspecified point rather than
+ * assume it saw everything the target did.
+ */
+#define DRM_XE_EUDEBUG_IOCTL_READ_EVENT		_IOWR('j', 0x40, struct drm_xe_eudebug_event)
+
+/**
+ * struct drm_xe_eudebug_event - Base type of event delivered by xe_eudebug.
+ *
+ * Base event for xe_eudebug interface.
+ *
+ * For receiving events :c:member:`drm_xe_eudebug_event.type` has to
+ * be DRM_XE_EUDEBUG_EVENT_READ. On return, this is set to the type
+ * of event received. :c:member:`drm_xe_eudebug_event.len` has to be
+ * set to maximum size that can be received. On return, len will be set
+ * to the event size. If the pending event was larger than this size,
+ * -EMSGSIZE is returned instead of 0 and the caller should retry with a larger
+ * allocated receive length.
+ *
+ * :c:member:`drm_xe_eudebug_event.seqno` can be used to form a timeline
+ * as event delivery order does not guarantee event creation
+ * order. Must be zero in the read request.
+ *
+ * :c:member:`drm_xe_eudebug_event.flags` will indicate if a resource was
+ * created or destroyed. Must be zero in the read request.
+ *
+ * %DRM_XE_EUDEBUG_EVENT_NONE and %DRM_XE_EUDEBUG_EVENT_READ are never
+ * delivered: the first is unused and the second is the request type for
+ * the read ioctl.
+ *
+ * :c:member:`drm_xe_eudebug_event.len` is authoritative for the event that
+ * was read, and events may grow fields in later kernels. Step to the next
+ * event and skip a type this debugger does not know by @len rather than by
+ * the size of the matching struct in the header it was built against.
+ */
+struct drm_xe_eudebug_event {
+	/** @len: Length */
+	__u32 len;
+
+	/** @type: Type */
+	__u16 type;
+#define DRM_XE_EUDEBUG_EVENT_NONE		0
+#define DRM_XE_EUDEBUG_EVENT_READ		1
+#define DRM_XE_EUDEBUG_EVENT_VM			2
+
+	/** @flags: Flags */
+	__u16 flags;
+#define DRM_XE_EUDEBUG_EVENT_CREATE		(1 << 0)
+#define DRM_XE_EUDEBUG_EVENT_DESTROY		(1 << 1)
+
+	/**
+	 * @seqno: Sequence number, for the debugger to construct a timeline.
+	 *
+	 * Allocated per connection and monotonically increasing, taken at the
+	 * point the event is generated rather than when it is queued.
+	 *
+	 * Event generation is asynchronous: threads in the target produce
+	 * events concurrently, so events are not guaranteed to arrive in
+	 * seqno order. The numbering may also contain gaps, as a number can
+	 * be allocated for an event that is never queued. Neither a lower
+	 * seqno arriving after a higher one nor a gap means an event was
+	 * lost; if an event cannot be queued the connection is disconnected
+	 * instead of silently dropping it.
+	 *
+	 * Use this to order and correlate the events that have been read,
+	 * which is what timeline means here. Do not use it as a delivery
+	 * order guarantee.
+	 */
+	__u64 seqno;
+
+	/** @reserved: Reserved field, must be zero. */
+	__u64 reserved;
+};
+
+/**
+ * struct drm_xe_eudebug_event_vm - VM event
+ *
+ * VM event is delivered when vm is created or destroyed. Only vms created
+ * with %DRM_XE_VM_CREATE_FLAG_FAULT_MODE, the ones debuggable exec queues
+ * can run on, are reported; other vms of the target are not visible to the
+ * debugger.
+ */
+struct drm_xe_eudebug_event_vm {
+	/** @base: base event */
+	struct drm_xe_eudebug_event base;
+
+	/** @vm_handle: unique handle for vm */
+	__u64 vm_handle;
+};
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* _UAPI_XE_DRM_EUDEBUG_H_ */
-- 
2.53.0

