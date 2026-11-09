Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A3E606D802
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XfprxiV2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC7910F302;
	Mon,  9 Nov 2026 13:56:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E7510F302;
 Mon,  9 Nov 2026 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232589; x=1825768589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=neLflSka4PeBwrvXXG0UlbYMOD7Sy6Rnfgfmg/qj1qc=;
 b=XfprxiV2oX2OCJ7X6db08zvxUzyiSe0T1VcKgRlATug/nlVLFCtRCmbB
 LBHWWIRyMvfaK5X/Qe1xJXNfqx3D8RIcI73hma2m3rIKmichULG7OiGSI
 v9n3845bwbHNphIC7dMLtY76hN2O2Zfp/4lOpI4EOOKCoiG20kUlDQ46O
 eRbHRWcQSUwSDwJrI2iJiMz8zm3HIwDl1piZI0dRbsuv2HPyEQEHTYkcD
 eWeih5mAbhN6Dxa1HOiKhuEk9At3c4TZ7kX86J1acvQ4SpOwPvN52sYEi
 USBwzMIWDeb01eHVYsMYUeIqDmQsnqOg3wfTA5g0qBRv6n3DxCgYFSMKd Q==;
X-CSE-ConnectionGUID: +qlITD3XSrGTTrjruitnOg==
X-CSE-MsgGUID: yNvcmeaATTeboHVIRCKp2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850722"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850722"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:29 -0800
X-CSE-ConnectionGUID: RRGRRz4hSRqDkwOLjJ1i2A==
X-CSE-MsgGUID: f9kkoDz2SMqgKKaSocm5tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202601"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:24 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 04/20] drm/xe/eudebug: Add connection establishment
 documentation
Date: Mon,  9 Nov 2026 15:55:29 +0200
Message-ID: <20261109135549.4128280-5-mika.kuoppala@linux.intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add documentation for connecting to a target DRM Xe client
for debugging.

v2: improved Pipe and Fork documentation (Sashiko)
v10: qualify the ptrace_may_access() parity claim per fd
     acquisition method (Claude)

Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 Documentation/gpu/xe/xe_eudebug.rst |  11 +++
 drivers/gpu/drm/xe/xe_eudebug.c     | 104 +++++++++++++++++++++++++++-
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/xe/xe_eudebug.rst b/Documentation/gpu/xe/xe_eudebug.rst
index a73f8bd9a8e9..9c6070784e84 100644
--- a/Documentation/gpu/xe/xe_eudebug.rst
+++ b/Documentation/gpu/xe/xe_eudebug.rst
@@ -27,6 +27,17 @@ Connection Establishment
 .. kernel-doc:: drivers/gpu/drm/xe/xe_eudebug.c
    :doc: Connection Establishment
 
+File Descriptor Acquisition Methods
+-----------------------------------
+
+.. kernel-doc:: drivers/gpu/drm/xe/xe_eudebug.c
+   :doc: File Descriptor Acquisition Methods
+
+Security Model
+--------------
+.. kernel-doc:: drivers/gpu/drm/xe/xe_eudebug.c
+   :doc: Security Model
+
 Events
 ======
 
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
index 61572c006d22..d18ba28f43b1 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.c
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -23,8 +23,110 @@
  * DOC: Connection Establishment
  *
  * To debug a target DRM client, the debugger must first establish
- * a connection using :c:type:`drm_xe_eudebug_connect`.
+ * a connection with the DRM_IOCTL_XE_EUDEBUG_CONNECT ioctl, issued on a
+ * DRM file descriptor of its own for the same device and taking a
+ * :c:type:`drm_xe_eudebug_connect`. On success the ioctl returns a new
+ * file descriptor, the eudebug file descriptor, on which the debugger
+ * reads events and issues the eudebug ioctls. Closing it ends the
+ * connection.
  *
+ * The interface has to be enabled for the device first, by writing 1 to
+ * its enable_eudebug sysfs attribute; until then the connect ioctl fails
+ * with -EOPNOTSUPP. See Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug.
+ *
+ * The debug target's DRM client file descriptor is passed into the
+ * connect ioctl via :c:member:`drm_xe_eudebug_connect.fd`.
+ * This is the fd that the target process obtained from open('/dev/dri/cardX').
+ *
+ * This file descriptor must be a valid DRM client fd in the debugger's
+ * (calling) process context. For debugging an Xe DRM client in
+ * another process, pidfd_getfd() can be used to acquire a duplicate
+ * of the file descriptor from the target process. See
+ * :ref:`File Descriptor Acquisition Methods <fd_acquisition_methods>` for
+ * details on how to obtain the target's fd.
+ *
+ */
+
+/**
+ * DOC: Security Model
+ *
+ * If you are inside the same process, you can connect to your own DRM client
+ * by simply passing its fd to drm_xe_eudebug_connect.
+ *
+ * For a remote process, possession of that process's DRM client fd is
+ * the capability: the connect ioctl adds no credential check of its own.
+ * What sets the bar is therefore how that fd was obtained.
+ *
+ * Taking an fd from a process that did not offer it goes through
+ * pidfd_getfd(), and the kernel enforces credentials there.
+ * __pidfd_fget() requires ptrace_may_access() with
+ * PTRACE_MODE_ATTACH_REALCREDS, under the target's
+ * signal->exec_update_lock. That is the check ptrace(PTRACE_ATTACH)
+ * makes, and the one process_vm_readv() makes under the same lock in
+ * mm_access(), so for this path the same ptrace_may_access() rules apply
+ * as in CPU process debugging with gdb. Most of the File Descriptor
+ * Acquisition Methods end up here, including those that only use procfs
+ * to discover which fd number to ask for.
+ *
+ * Two methods do not involve ptrace_may_access(), because nothing is
+ * being taken. With SCM_RIGHTS the target sends its own fd over a unix
+ * socket, which is the target consenting. With fork() inheritance the fd
+ * belonged to the debugger before the fork and the child merely
+ * inherited a copy of it.
+ *
+ * See :ref:`File Descriptor Acquisition Methods <fd_acquisition_methods>`.
+ */
+
+/**
+ * DOC: File Descriptor Acquisition Methods
+ * .. _fd_acquisition_methods:
+ *
+ * There are multiple ways to get the target DRM client fd for
+ * another process:
+ *
+ * Unix domain socket
+ *     The debugger can receive the DRM client fd from the target via a Unix
+ *     domain socket using SCM_RIGHTS ancillary data. This is the standard
+ *     mechanism for passing file descriptors between processes, but requires
+ *     coordination to establish the socket connection.
+ *
+ * Pipe
+ *     The target sends the fd number through a pipe, and the debugger
+ *     duplicates it via pidfd_getfd(). This requires coordination between
+ *     the processes to establish the pipe and synchronize the transfer.
+ *
+ * Fork
+ *     If the debugger spawns the target process via fork(), a DRM client
+ *     fd can be shared across the fork boundary — either inherited by the
+ *     child from the debugger, or acquired from the child by the debugger
+ *     via pidfd_getfd() after the child opens the device. This is useful
+ *     when the debugger launches the target directly, similar to how gdb
+ *     spawns inferiors.
+ *
+ * Ptrace
+ *     The debugger can attach to the target process using ptrace. It can
+ *     intercept the return value of the target's open() or drmOpen() call
+ *     by inspecting registers at syscall exit to catch the fd when it is
+ *     created. Alternatively, if the target has already opened the device,
+ *     the debugger can read the target's memory using PTRACE_PEEKDATA to
+ *     locate the stored fd value in a known variable or data structure.
+ *     Once the fd number is known, pidfd_getfd() can be used to acquire a
+ *     duplicate in the debugger's process context.
+ *
+ * Procfs
+ *     The debugger can look through /proc/<targetpid>/fd for file descriptors
+ *     and inspect /proc/<targetpid>/fdinfo to see which of those
+ *     are for an Xe DRM client, then duplicate that fd number with
+ *     pidfd_getfd().
+ *
+ * Brute force
+ *     The debugger can duplicate each fd listed in /proc/<targetpid>/fd
+ *     with pidfd_getfd() and try to connect with it to see if it succeeds.
+ *
+ * In both procfs methods the fd has to be taken with pidfd_getfd(). Opening
+ * /proc/<targetpid>/fd/<N> instead opens the device node anew and yields a
+ * new, empty DRM client of the debugger's own, which connect accepts but
+ * which is not the target.
  */
 
 /**
-- 
2.53.0

