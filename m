Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87883C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E284A10E65F;
	Mon, 24 Aug 2026 08:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="byqYhogQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E0110E65F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:09:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 492116011F;
 Mon, 24 Aug 2026 08:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1765A1F000E9;
 Mon, 24 Aug 2026 08:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787558988;
 bh=zI3zRraj20jjpJW3QVmyXH0EMMbB8ZN4Z8znqbKkWzs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=byqYhogQDQ5PqkuCGQrzuUiiJgA/OMhB5Teb3nPtSRNoU2W6/po1mS1R9elMuT0AP
 Ak0yQRty+WhE0MyAdV2/LWdTWNFEaEW7ZHTokc1c2LJn5FdXxSZCnAoo9GyLlAlpF4
 zaUV3REWhJ2BZaa2VY/sqNqHxCJeaJtO0smj/p7YDZBQ6JmOwzJRUyvN8W74BG7/Vo
 uKOdWxZxRU2U1Dmw18FqMzELqpnYY8XdHZymOfV2UwV9Gd8dVxSvVmSA476qrM7lPU
 IwPcpt24T944xulLkKPjg6TYcs7jF5Ap581GOyCkJxfeWsAhpqT8UQa8+3Dqd32DYm
 It+PJ/hcik+tQ==
From: Konstantin Sinyuk <ksinyuk@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ilia Levi <ilia.levi@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/12] drm/fabric: add core object model and provider API
Date: Mon, 24 Aug 2026 11:09:29 +0300
Message-ID: <83513555d01ea2ccc426020c97afee78d0376288.1787552412.git.ksinyuk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ilia Levi <ilia.levi@intel.com>

Accelerator drivers currently expose interconnect topology through
driver-specific interfaces, leaving topology semantics fragmented across
drivers. Add a common DRM object model for fabrics, endpoints, ports and
directly adjacent peers, together with the provider API drivers use to
populate it:

    fabric -> endpoint -> port -> peer

A fabric groups the endpoints of one provider-defined interconnect
instance. An endpoint owns a fixed set of ports. A port may carry a
type-qualified peer value describing the accelerator or switch directly
adjacent at the far end of its link; the peer need not resolve to another
live kernel object. The core assigns live-object IDs, manages object
lifetime and enforces the model's invariants. The complete object, peer,
locking and lifecycle contracts are documented in
Documentation/gpu/drm-fabric.rst, added here.

CONFIG_DRM_FABRIC builds the core as drm-fabric.ko and depends on NET for
the Generic Netlink uAPI added next. No provider uses the API yet, so
loading the module registers no fabric objects.

Add a MAINTAINERS entry for the subsystem.

Split the core and generated uAPI header across this patch and the next to
keep the object model and wire contract separately reviewable while both
commits remain buildable. Temporarily define the uAPI value enums locally;
the generated header replaces them in the next patch.

Signed-off-by: Ilia Levi <ilia.levi@intel.com>
Co-developed-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Signed-off-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Assisted-by: GitHub-Copilot:claude-opus-4.8
---
 Documentation/gpu/drm-fabric.rst             | 142 ++++
 Documentation/gpu/index.rst                  |   1 +
 MAINTAINERS                                  |  14 +
 drivers/gpu/drm/Kconfig                      |   1 +
 drivers/gpu/drm/Makefile                     |   1 +
 drivers/gpu/drm/fabric/Kconfig               |  14 +
 drivers/gpu/drm/fabric/Makefile              |   4 +
 drivers/gpu/drm/fabric/drm_fabric.c          | 681 +++++++++++++++++++
 drivers/gpu/drm/fabric/drm_fabric_internal.h |  34 +
 include/drm/drm_fabric.h                     | 259 +++++++
 10 files changed, 1151 insertions(+)
 create mode 100644 Documentation/gpu/drm-fabric.rst
 create mode 100644 drivers/gpu/drm/fabric/Kconfig
 create mode 100644 drivers/gpu/drm/fabric/Makefile
 create mode 100644 drivers/gpu/drm/fabric/drm_fabric.c
 create mode 100644 drivers/gpu/drm/fabric/drm_fabric_internal.h
 create mode 100644 include/drm/drm_fabric.h

diff --git a/Documentation/gpu/drm-fabric.rst b/Documentation/gpu/drm-fabric.rst
new file mode 100644
index 000000000000..99b189dc614e
--- /dev/null
+++ b/Documentation/gpu/drm-fabric.rst
@@ -0,0 +1,142 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+===============================
+DRM Fabric over Generic Netlink
+===============================
+
+Modern GPUs and dedicated AI accelerators are increasingly connected through
+scale-up interconnect fabrics such as AMD xGMI and
+`UALink <https://ualinkconsortium.org/specification/>`__.
+
+DRM Fabric is a registry and dispatcher. It does not discover routes, compute
+reachability, program switch forwarding, manage device memory, or provide a
+data path; those remain with the vendor driver and the fabric controller.
+
+Key Goals:
+
+* Provide a standardized topology model for GPU and accelerator interconnects
+  (xGMI, UALink and similar), enabling data-center discovery and monitoring.
+* Support read-only enumeration, monitoring and state queries for
+  provider-owned topology.
+* Offer a flexible, future-proof interface that can be extended with new fabric
+  types and attributes without breaking the uAPI.
+* Allow multiple endpoints and ports per provider, so drivers can model
+  accelerator attachments, links and their peers.
+
+.. contents::
+
+Object model
+============
+
+DRM Fabric models interconnect topology with four object types::
+
+    fabric
+      `-- endpoint
+            `-- port
+                  `-- peer (optional value descriptor)
+
+A *fabric* is a membership group of *endpoints*; each endpoint represents one
+accelerator attachment and owns a fixed set of *ports*; and a *port* may carry a
+*peer* describing the device directly adjacent at the far end of its link, which
+is either another accelerator or a fabric switch.
+
+Identity is layered. The core assigns kernel-local ``fabric-id`` and
+``endpoint-id`` values that address live registry objects for the duration of
+their registration. Providers supply an endpoint ``fabric-ep-id`` -- an
+accelerator's identity within its fabric's identity domain. A peer instead
+carries a type-qualified ``peer-id``: for ``peer-type = accel`` it is the
+far-end accelerator's ``fabric-ep-id``, and for ``peer-type = switch`` it is an
+opaque provider-defined switch identity that names no local object. Accelerator
+and switch identities occupy separate namespaces selected by ``peer-type``, so
+the same numeric value may name different objects under each type.
+
+Fabric membership does not imply end-to-end reachability, and the topology is
+not necessarily a tree. The registered shape reflects the direct adjacency the
+provider reports: for example, it may be a full mesh with no root, a linear
+chain, or a switch-based topology in which ports terminate at opaque switch
+peers rather than locally registered endpoints.
+
+A *peer* is a value descriptor, not a reference to a live kernel object: its
+``peer-id`` may name a remote accelerator managed by another OS or an opaque
+switch in another trust domain, and need not resolve in the local registry. The
+core stores one directed half-edge and does not require the reverse half-edge to
+exist, so removing an endpoint does not retract peer descriptors held by other
+endpoints. ``peer-type = switch`` only describes the kind of far end; it does
+not create a first-class switch object.
+
+.. kernel-doc:: drivers/gpu/drm/fabric/drm_fabric.c
+   :doc: DRM Fabric core
+
+Peer semantics
+--------------
+
+A peer is an identity rather than a reference to a live object, and the
+difference decides what the core reports. A ``peer-id`` that resolves in the
+local registry today may stop resolving later because the endpoint it named
+unregistered, and no event is emitted on the port still carrying it: a peer
+is recorded on one local half-edge, and peer disappearance does not retract
+that half-edge. A peer is therefore topology as last set, not proof of live
+connectivity; liveness belongs to the fabric controller.
+
+The core never retracts a half-edge on its own. Failing to resolve a peer
+locally is not the same as the link going away -- the far end may be a switch,
+an accelerator on another node, or a local endpoint that merely unregistered
+-- so only the provider knows when a port's physical adjacency actually
+changed, and only the provider retracts or replaces the descriptor.
+
+Endpoint teardown removes the endpoint's owned half-edges without generating
+a separate event for each port: the delete already describes the transition,
+so removing an endpoint advances the topology generation once rather than
+once per child port.
+
+Driver API
+----------
+
+.. kernel-doc:: include/drm/drm_fabric.h
+   :internal:
+
+.. kernel-doc:: drivers/gpu/drm/fabric/drm_fabric.c
+   :export:
+
+Design scope and boundaries
+===========================
+
+Vendor drivers retain hardware discovery, firmware interaction and the
+load/store data path; DRM Fabric represents only the topology and
+provider-reported state of DRM-managed accelerators, which is why it
+belongs in DRM. The interface does not define MMU programming, switch
+policy, key management, live migration, or any required user space daemon.
+
+DRM Fabric does not define in-network collective operations or how an
+endpoint or switch executes them. Such capabilities belong to the
+interconnect implementation and its provider. Adding capability later is not
+foreclosed: for an endpoint it is a new attribute, while
+``peer-type = switch`` is a value descriptor rather than a registered object,
+so there is nowhere to attach one today. ``peer-id`` is already an opaque
+switch identity that need not resolve locally, so making one resolvable later
+strengthens the contract rather than breaking it.
+
+Object lifetime and locking
+===========================
+
+All registry and object state is protected by ``drm_fabric_lock``. A fabric and
+its endpoints are created and torn down through the provider API; endpoint
+unregister removes the endpoint from the registry and frees its fixed set of
+ports. Fabric membership is tracked, so a provider must remove all member
+endpoints before unregistering a provider-owned fabric: drm_fabric_unregister()
+returns ``-EBUSY`` and leaves the fabric registered if any remain, so the
+provider must retry after removing them rather than treat the fabric as gone.
+
+Objects are reference counted and a port is pinned through its owning endpoint.
+Endpoint unregister drops the registration reference and waits for outstanding
+pins before freeing the ports; fabric membership holds a fabric reference.
+
+Providers own object lifetime, so a provider must serialise endpoint
+registration against unregistration of the containing fabric. The unregister
+entry points compare the supplied pointer against the registry before
+dereferencing it, so a stale or repeated teardown is rejected: fabric
+unregistration returns ``-ENODEV``, and endpoint unregistration, having no
+error return, warns and performs no teardown. Endpoint registration rejects a
+departed parent the same way. These checks prove current address membership
+only: they cannot tell an earlier incarnation from another object registered
+later at the same address.
diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
index 65bf3b26e4f4..7d99c47ddbe7 100644
--- a/Documentation/gpu/index.rst
+++ b/Documentation/gpu/index.rst
@@ -16,6 +16,7 @@ GPU Driver Developer's Guide
    driver-uapi
    drm-client
    drm-compute
+   drm-fabric
    drivers
    backlight
    vga-switcheroo
diff --git a/MAINTAINERS b/MAINTAINERS
index 3c508bda61d5..2ab63bd763b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8966,6 +8966,20 @@ F:	Documentation/devicetree/bindings/display/xlnx/
 F:	Documentation/gpu/zynqmp.rst
 F:	drivers/gpu/drm/xlnx/
 
+DRM FABRIC
+M:	Konstantin Sinyuk <ksinyuk@kernel.org>
+M:	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
+R:	Francois Dugast <francois.dugast@intel.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/gpu/drm-fabric.rst
+F:	Documentation/netlink/specs/drm_fabric.yaml
+F:	drivers/gpu/drm/fabric/
+F:	include/drm/drm_fabric.h
+F:	include/uapi/drm/drm_fabric.h
+F:	tools/testing/selftests/drivers/gpu/drm_fabric/
+
 DRM GPU SCHEDULER
 M:	Matthew Brost <matthew.brost@intel.com>
 M:	Danilo Krummrich <dakr@kernel.org>
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 323422861e8f..fc66146a603b 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -309,6 +309,7 @@ source "drivers/gpu/drm/atmel-hlcdc/Kconfig"
 source "drivers/gpu/drm/bridge/Kconfig"
 source "drivers/gpu/drm/etnaviv/Kconfig"
 source "drivers/gpu/drm/exynos/Kconfig"
+source "drivers/gpu/drm/fabric/Kconfig"
 source "drivers/gpu/drm/fsl-dcu/Kconfig"
 source "drivers/gpu/drm/gma500/Kconfig"
 source "drivers/gpu/drm/gud/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e635fcffd379..bdf67dd3aab9 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -213,6 +213,7 @@ obj-y			+= panel/
 obj-y			+= bridge/
 obj-$(CONFIG_DRM_FSL_DCU) += fsl-dcu/
 obj-$(CONFIG_DRM_ETNAVIV) += etnaviv/
+obj-$(CONFIG_DRM_FABRIC) += fabric/
 obj-y			+= hisilicon/
 obj-y			+= mxsfb/
 obj-y			+= sysfb/
diff --git a/drivers/gpu/drm/fabric/Kconfig b/drivers/gpu/drm/fabric/Kconfig
new file mode 100644
index 000000000000..21fbfae9863d
--- /dev/null
+++ b/drivers/gpu/drm/fabric/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config DRM_FABRIC
+	tristate "DRM fabric support"
+	depends on DRM && NET
+	help
+	  Enable DRM fabric support. This infrastructure provides the
+	  core object model and provider API for registered accelerator
+	  interconnect topologies.
+
+	  To compile this as a module, choose M here: the module will be
+	  called drm-fabric.
+
+	  If in doubt, say N.
diff --git a/drivers/gpu/drm/fabric/Makefile b/drivers/gpu/drm/fabric/Makefile
new file mode 100644
index 000000000000..3a76f31f1e83
--- /dev/null
+++ b/drivers/gpu/drm/fabric/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DRM_FABRIC) += drm-fabric.o
+drm-fabric-y := drm_fabric.o
diff --git a/drivers/gpu/drm/fabric/drm_fabric.c b/drivers/gpu/drm/fabric/drm_fabric.c
new file mode 100644
index 000000000000..8769d7bdcde1
--- /dev/null
+++ b/drivers/gpu/drm/fabric/drm_fabric.c
@@ -0,0 +1,681 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
+
+#include <drm/drm_fabric.h>
+
+#include "drm_fabric_internal.h"
+
+/**
+ * DOC: DRM Fabric core
+ *
+ * The core keeps a registry of fabric, endpoint, port and peer objects behind
+ * a small provider-facing API. A provider registers a fabric, attaches
+ * endpoints with their fixed set of ports, then reports link changes and peer
+ * adjacency through drm_fabric_port_set_oper(), drm_fabric_port_set_peer() and
+ * drm_fabric_port_unset_peer().
+ *
+ * The core owns object identity and lifetime: it assigns kernel-local IDs,
+ * refcounts objects, serialises access under its internal lock, and advances a
+ * topology generation on every change so a concurrent netlink dump can detect
+ * a torn snapshot.
+ */
+
+/* Global lock for all fabric, endpoint and port state. */
+DEFINE_MUTEX(drm_fabric_lock);
+
+DEFINE_XARRAY_ALLOC1(drm_fabric_xa);
+DEFINE_XARRAY_ALLOC(drm_fabric_ep_xa);
+
+/*
+ * Family-global topology change token, exposed to user space as
+ * topology-generation and used as the netlink dump-consistency sequence. It is
+ * nonzero and never emits zero across the u32 wrap. Increment it on a
+ * committed topology mutation so a subsequent GET/DUMP reports the
+ * post-change generation.
+ */
+u32 drm_fabric_base_seq = 1;
+
+static u32 drm_fabric_base_seq_inc(void)
+{
+	lockdep_assert_held(&drm_fabric_lock);
+	/*
+	 * Generation feeds cb->seq; netlink treats 0 as "no dump in progress",
+	 * so skip it on wrap.
+	 */
+	if (++drm_fabric_base_seq == 0)
+		drm_fabric_base_seq = 1;
+	return drm_fabric_base_seq;
+}
+
+struct drm_fabric *drm_fabric_find_by_id(u32 id)
+{
+	lockdep_assert_held(&drm_fabric_lock);
+	return xa_load(&drm_fabric_xa, id);
+}
+
+struct drm_fabric_endpoint *drm_fabric_endpoint_find_by_id(u32 id)
+{
+	lockdep_assert_held(&drm_fabric_lock);
+	return xa_load(&drm_fabric_ep_xa, id);
+}
+
+/*
+ * Returns NULL if no endpoint matches, or ERR_PTR(-EINVAL) if @devname is
+ * ambiguous across buses and @busname does not disambiguate it.
+ */
+struct drm_fabric_endpoint *
+drm_fabric_endpoint_find_by_dev_name(const char *devname, const char *busname)
+{
+	struct drm_fabric_endpoint *match = NULL;
+	struct drm_fabric_endpoint *ep;
+	unsigned long idx;
+
+	lockdep_assert_held(&drm_fabric_lock);
+	xa_for_each(&drm_fabric_ep_xa, idx, ep) {
+		if (strcmp(dev_name(ep->parent), devname))
+			continue;
+
+		if (busname) {
+			if (strcmp(dev_bus_name(ep->parent), busname))
+				continue;
+			return ep;
+		}
+
+		if (match)
+			return ERR_PTR(-EINVAL);
+
+		match = ep;
+	}
+
+	return match;
+}
+
+/*
+ * Returns true if a member of @fabric already uses @fabric_ep_id. fabric_ep_id
+ * is the accelerator's identity within a fabric and is what a peer descriptor
+ * names (peer_id for DRM_FABRIC_PEER_TYPE_ACCEL), so it must be unique per
+ * fabric or peer resolution is ambiguous.
+ */
+static bool drm_fabric_ep_id_in_use(const struct drm_fabric *fabric, u64 fabric_ep_id)
+{
+	struct drm_fabric_endpoint *ep;
+	unsigned long idx;
+
+	lockdep_assert_held(&drm_fabric_lock);
+
+	xa_for_each(&drm_fabric_ep_xa, idx, ep)
+		if (ep->fabric == fabric &&
+		    ep->fabric_ep_id == fabric_ep_id)
+			return true;
+
+	return false;
+}
+
+static bool drm_fabric_has_instance(const struct drm_fabric *fabric)
+{
+	struct drm_fabric *other;
+	unsigned long idx;
+
+	lockdep_assert_held(&drm_fabric_lock);
+
+	xa_for_each(&drm_fabric_xa, idx, other)
+		if (other->type == fabric->type &&
+		    other->instance_id == fabric->instance_id)
+			return true;
+
+	return false;
+}
+
+static bool drm_fabric_type_valid(enum drm_fabric_type type)
+{
+	switch (type) {
+	case DRM_FABRIC_TYPE_SYNTHETIC:
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * drm_fabric_register() - Register a new fabric
+ * @desc: fabric description (type, instance id, name)
+ *
+ * Allocates the fabric and inserts it into the registry as provider-owned.
+ * Rejects zero and out-of-range types before allocating.
+ *
+ * Context: May sleep. Acquires drm_fabric_lock.
+ * Return: the registered fabric, or an ERR_PTR() on failure, -EINVAL for a
+ *         type this kernel does not define.
+ */
+struct drm_fabric *drm_fabric_register(const struct drm_fabric_desc *desc)
+{
+	struct drm_fabric *fabric __free(kfree) = NULL;
+
+	if (WARN_ON_ONCE(!drm_fabric_type_valid(desc->type)))
+		return ERR_PTR(-EINVAL);
+
+	fabric = kzalloc_obj(*fabric);
+	if (!fabric)
+		return ERR_PTR(-ENOMEM);
+
+	fabric->type = desc->type;
+	fabric->instance_id = desc->instance_id;
+	refcount_set(&fabric->refs, 1);
+
+	if (desc->name &&
+	    strscpy(fabric->name, desc->name, sizeof(fabric->name)) < 0)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		int ret;
+
+		if (drm_fabric_has_instance(fabric))
+			return ERR_PTR(-EEXIST);
+
+		ret = xa_alloc(&drm_fabric_xa, &fabric->id, fabric,
+			       xa_limit_32b, GFP_KERNEL);
+		if (ret)
+			return ERR_PTR(ret);
+		drm_fabric_base_seq_inc();
+	}
+
+	return_ptr(fabric);
+}
+EXPORT_SYMBOL(drm_fabric_register);
+
+struct drm_fabric *drm_fabric_get(struct drm_fabric *fabric)
+{
+	lockdep_assert_held(&drm_fabric_lock);
+	refcount_inc(&fabric->refs);
+	return fabric;
+}
+
+void drm_fabric_put(struct drm_fabric *fabric)
+{
+	if (refcount_dec_and_test(&fabric->refs))
+		kfree(fabric);
+}
+
+static bool drm_fabric_has_members(const struct drm_fabric *fabric)
+{
+	struct drm_fabric_endpoint *ep;
+	unsigned long idx;
+
+	lockdep_assert_held(&drm_fabric_lock);
+
+	xa_for_each(&drm_fabric_ep_xa, idx, ep)
+		if (ep->fabric == fabric)
+			return true;
+
+	return false;
+}
+
+/*
+ * Compare the possibly stale pointer by address without dereferencing it.
+ * A reused address passes as the later object; providers own incarnation
+ * tracking.
+ */
+static bool drm_fabric_is_registered(const struct drm_fabric *fabric)
+{
+	struct drm_fabric *entry;
+	unsigned long idx;
+
+	lockdep_assert_held(&drm_fabric_lock);
+
+	xa_for_each(&drm_fabric_xa, idx, entry)
+		if (entry == fabric)
+			return true;
+
+	return false;
+}
+
+/**
+ * drm_fabric_unregister() - Unregister a fabric
+ * @fabric: fabric to remove
+ *
+ * Removes an empty @fabric from the registry and frees it. A provider must
+ * unregister all member endpoints first.
+ *
+ * @fabric must still be registered. The pointer is compared against the
+ * registry before anything dereferences it, so a stale or repeated
+ * unregister is rejected rather than acted on. That comparison proves
+ * current address membership only: it cannot tell an earlier incarnation
+ * from another fabric registered later at the same address, which remains
+ * the provider's obligation.
+ *
+ * Context: May sleep. Acquires drm_fabric_lock.
+ * Return: 0 on removal. -ENODEV if @fabric is not registered, checked first.
+ *         -EBUSY if members remain; the fabric stays registered and the
+ *         provider must remove them before retrying. -EBUSY also warns
+ *         because this is a teardown-ordering bug.
+ */
+int drm_fabric_unregister(struct drm_fabric *fabric)
+{
+	scoped_guard(mutex, &drm_fabric_lock) {
+		if (!drm_fabric_is_registered(fabric))
+			return -ENODEV;
+		/*
+		 * Members still reference ep->fabric; freeing it here would
+		 * leave stale pointers.
+		 */
+		if (WARN_ON_ONCE(drm_fabric_has_members(fabric)))
+			return -EBUSY;
+		drm_fabric_base_seq_inc();
+		xa_erase(&drm_fabric_xa, fabric->id);
+	}
+
+	drm_fabric_put(fabric);
+	return 0;
+}
+EXPORT_SYMBOL(drm_fabric_unregister);
+
+static void drm_fabric_ports_destroy(struct drm_fabric_endpoint *ep)
+{
+	struct drm_fabric_port *port;
+	unsigned long index;
+
+	xa_for_each(&ep->ports, index, port) {
+		kfree(port);
+		ep->num_ports--;
+	}
+	xa_destroy(&ep->ports);
+}
+
+static int drm_fabric_ports_create(struct drm_fabric_endpoint *ep,
+				   const struct drm_fabric_port_desc *descs,
+				   unsigned int num_ports)
+{
+	unsigned int i;
+
+	for (i = 0; i < num_ports; i++) {
+		struct drm_fabric_port *port;
+		int ret;
+
+		port = kzalloc_obj(*port);
+		if (!port) {
+			drm_fabric_ports_destroy(ep);
+			return -ENOMEM;
+		}
+
+		port->index = descs[i].index;
+		port->max_lane_count = descs[i].max_lane_count;
+		port->max_lane_signaling_rate_mbps =
+			descs[i].max_lane_signaling_rate_mbps;
+		port->oper_state = DRM_FABRIC_PORT_STATE_UNKNOWN;
+		port->has_peer = false;
+		port->endpoint = ep;
+
+		ret = xa_insert(&ep->ports, port->index, port, GFP_KERNEL);
+		if (ret) {
+			/* A duplicate port index is a provider bug. */
+			WARN_ON_ONCE(ret == -EBUSY);
+			kfree(port);
+			drm_fabric_ports_destroy(ep);
+			return ret;
+		}
+
+		ep->num_ports++;
+	}
+
+	return 0;
+}
+
+/**
+ * drm_fabric_endpoint_register() - Register a provider-owned endpoint
+ * @fabric: non-NULL fabric the endpoint belongs to
+ * @desc: endpoint description, including its fixed set of ports
+ *
+ * Registers @desc as a member of @fabric and advances the topology generation.
+ * @desc->fabric_ep_id must be unique among the fabric's registered endpoints.
+ *
+ * The provider must serialise this call against drm_fabric_unregister() of
+ * @fabric. A fabric that has already left the registry is rejected, but that
+ * check matches on address and cannot distinguish incarnations; only the
+ * provider knows its own object lifecycle.
+ *
+ * Context: May sleep. Acquires drm_fabric_lock.
+ * Return: the registered endpoint, or an ERR_PTR() on failure: -EINVAL if
+ * @fabric or @desc->parent is NULL, or @desc claims ports without supplying a
+ * port array, -ENODEV if @fabric is no longer registered, -EEXIST if
+ * @desc->fabric_ep_id is already in use within @fabric.
+ */
+struct drm_fabric_endpoint *
+drm_fabric_endpoint_register(struct drm_fabric *fabric,
+			     const struct drm_fabric_endpoint_desc *desc)
+{
+	struct drm_fabric_endpoint *ep __free(kfree) = NULL;
+	int ret;
+
+	if (!fabric)
+		return ERR_PTR(-EINVAL);
+
+	/* Supplies dev_name()/bus for the query paths; pinned below. */
+	if (!desc->parent)
+		return ERR_PTR(-EINVAL);
+
+	if (desc->num_ports && !desc->ports)
+		return ERR_PTR(-EINVAL);
+
+	ep = kzalloc_obj(*ep);
+	if (!ep)
+		return ERR_PTR(-ENOMEM);
+
+	ep->fabric_ep_id = desc->fabric_ep_id;
+	ep->fabric = fabric;
+	ep->parent = desc->parent;
+	ep->ops = desc->ops;
+	ep->priv = desc->priv;
+	refcount_set(&ep->refs, 1);
+	init_completion(&ep->unregistered);
+	xa_init(&ep->ports);
+
+	if (desc->name &&
+	    strscpy(ep->name, desc->name, sizeof(ep->name)) < 0)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	ret = drm_fabric_ports_create(ep, desc->ports, desc->num_ports);
+	if (ret)
+		return ERR_PTR(ret);
+
+	get_device(ep->parent);
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		/*
+		 * A concurrent drm_fabric_unregister() may have freed @fabric
+		 * since the caller passed it, so validate membership by address
+		 * without dereferencing it.
+		 */
+		if (!drm_fabric_is_registered(fabric)) {
+			ret = -ENODEV;
+			break;
+		}
+
+		if (drm_fabric_ep_id_in_use(fabric, ep->fabric_ep_id)) {
+			ret = -EEXIST;
+			break;
+		}
+
+		ret = xa_alloc(&drm_fabric_ep_xa, &ep->id, ep, xa_limit_32b, GFP_KERNEL);
+		if (ret)
+			break;
+		drm_fabric_get(fabric);
+
+		drm_fabric_base_seq_inc();
+	}
+
+	if (ret) {
+		put_device(ep->parent);
+		drm_fabric_ports_destroy(ep);
+		return ERR_PTR(ret);
+	}
+
+	return_ptr(ep);
+}
+EXPORT_SYMBOL(drm_fabric_endpoint_register);
+
+/**
+ * drm_fabric_endpoint_port() - Look up a port of a registered endpoint
+ * @ep: provider-owned endpoint
+ * @port_index: per-endpoint port index
+ *
+ * An endpoint's set of ports is fixed for its registration lifetime, so a
+ * provider that serializes the endpoint lifecycle may call this without
+ * holding drm_fabric_lock. The returned pointer is borrowed and remains valid
+ * only while @ep is registered; it must not be retained across
+ * drm_fabric_endpoint_unregister().
+ *
+ * Return: the port at @port_index, or NULL if no such port exists.
+ */
+struct drm_fabric_port *
+drm_fabric_endpoint_port(struct drm_fabric_endpoint *ep, u32 port_index)
+{
+	return xa_load(&ep->ports, port_index);
+}
+EXPORT_SYMBOL(drm_fabric_endpoint_port);
+
+struct drm_fabric_endpoint *drm_fabric_endpoint_get(struct drm_fabric_endpoint *ep)
+{
+	lockdep_assert_held(&drm_fabric_lock);
+	refcount_inc(&ep->refs);
+	return ep;
+}
+
+void drm_fabric_endpoint_put(struct drm_fabric_endpoint *ep)
+{
+	if (refcount_dec_and_test(&ep->refs))
+		complete(&ep->unregistered);
+}
+
+/*
+ * Same contract as drm_fabric_is_registered(): a stale, possibly freed @ep is
+ * compared but never dereferenced, and an address reused by a later
+ * registration passes as that later endpoint.
+ */
+static bool drm_fabric_ep_is_registered(const struct drm_fabric_endpoint *ep)
+{
+	struct drm_fabric_endpoint *entry;
+	unsigned long idx;
+
+	lockdep_assert_held(&drm_fabric_lock);
+
+	xa_for_each(&drm_fabric_ep_xa, idx, entry)
+		if (entry == ep)
+			return true;
+
+	return false;
+}
+
+/**
+ * drm_fabric_endpoint_unregister() - Unregister and free an endpoint
+ * @ep: endpoint to remove
+ *
+ * Removes @ep from the registry and frees it along with its ports, advancing
+ * the topology generation. Peers on other endpoints that name @ep are left
+ * untouched: the core never scans or retracts a half-edge on unregister.
+ *
+ * The provider must first quiesce its own use of @ep and any borrowed
+ * drm_fabric_endpoint_port() pointer. The core waits only for references it
+ * issued itself; concurrent netlink readers need no provider action.
+ *
+ * @ep must still be registered. The pointer is compared against the registry
+ * before anything dereferences it, so a stale or repeated unregister warns
+ * and performs no teardown; there is no error return to report it. As for a
+ * fabric, the comparison proves current address membership only.
+ *
+ * Context: May sleep. Acquires drm_fabric_lock.
+ */
+void drm_fabric_endpoint_unregister(struct drm_fabric_endpoint *ep)
+{
+	scoped_guard(mutex, &drm_fabric_lock) {
+		if (WARN_ON_ONCE(!drm_fabric_ep_is_registered(ep)))
+			return;
+		drm_fabric_base_seq_inc();
+		xa_erase(&drm_fabric_ep_xa, ep->id);
+	}
+
+	/*
+	 * Drop the registration reference and wait for any in-flight netlink
+	 * operation that pinned the endpoint to complete.
+	 */
+	drm_fabric_endpoint_put(ep);
+	wait_for_completion(&ep->unregistered);
+
+	drm_fabric_put(ep->fabric);
+
+	drm_fabric_ports_destroy(ep);
+	put_device(ep->parent);
+	kfree(ep);
+}
+EXPORT_SYMBOL(drm_fabric_endpoint_unregister);
+
+/* Borrowed: valid only while drm_fabric_lock is held. */
+struct drm_fabric_port *drm_fabric_port_find(u32 ep_id, u32 port_idx)
+{
+	struct drm_fabric_endpoint *ep;
+
+	lockdep_assert_held(&drm_fabric_lock);
+	ep = drm_fabric_endpoint_find_by_id(ep_id);
+	if (!ep)
+		return NULL;
+	return xa_load(&ep->ports, port_idx);
+}
+
+/*
+ * No refcount of its own: pinned through its owning endpoint and released
+ * with drm_fabric_port_put(). ERR_PTR(-ENOENT) if no such port exists.
+ */
+struct drm_fabric_port *drm_fabric_port_find_get(u32 ep_id, u32 port_idx)
+{
+	struct drm_fabric_port *port;
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		port = drm_fabric_port_find(ep_id, port_idx);
+		if (!port)
+			return ERR_PTR(-ENOENT);
+		drm_fabric_endpoint_get(port->endpoint);
+	}
+
+	return port;
+}
+
+void drm_fabric_port_put(struct drm_fabric_port *port)
+{
+	drm_fabric_endpoint_put(port->endpoint);
+}
+
+static bool drm_fabric_peer_type_valid(enum drm_fabric_peer_type type)
+{
+	switch (type) {
+	case DRM_FABRIC_PEER_TYPE_ACCEL:
+	case DRM_FABRIC_PEER_TYPE_SWITCH:
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * drm_fabric_port_set_peer() - Set a neighbor (called by the provider)
+ * @port: local port
+ * @peer: descriptor of the endpoint on the other end
+ *
+ * Sets the peer and advances the topology generation on success.
+ *
+ * Context: May sleep. Acquires drm_fabric_lock.
+ * Return: -EINVAL if @peer carries an unknown peer type, -EEXIST if the port
+ * already has a peer. 0 on success.
+ */
+int drm_fabric_port_set_peer(struct drm_fabric_port *port,
+			     const struct drm_fabric_peer *peer)
+{
+	/* Reject a provider's invalid type before it reaches the wire. */
+	if (WARN_ON_ONCE(!drm_fabric_peer_type_valid(peer->peer_type)))
+		return -EINVAL;
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		if (port->has_peer)
+			return -EEXIST;
+		port->peer = *peer;
+		port->has_peer = true;
+		drm_fabric_base_seq_inc();
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_fabric_port_set_peer);
+
+/**
+ * drm_fabric_port_unset_peer() - Remove a neighbor (called by the provider)
+ * @port: local port
+ *
+ * Inverse of drm_fabric_port_set_peer().
+ * Removes the peer and advances the topology generation on success.
+ *
+ * Edge retraction is always explicit (provider- or controller-driven); the
+ * core never removes a peer implicitly.
+ *
+ * Context: May sleep. Acquires drm_fabric_lock.
+ * Return: -ENOENT if no peer set. 0 on success.
+ */
+int drm_fabric_port_unset_peer(struct drm_fabric_port *port)
+{
+	scoped_guard(mutex, &drm_fabric_lock) {
+		if (!port->has_peer)
+			return -ENOENT;
+		drm_fabric_base_seq_inc();
+		port->has_peer = false;
+		memset(&port->peer, 0, sizeof(port->peer));
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_fabric_port_unset_peer);
+
+static bool drm_fabric_port_oper_state_valid(enum drm_fabric_port_state state)
+{
+	switch (state) {
+	case DRM_FABRIC_PORT_STATE_UNKNOWN:
+	case DRM_FABRIC_PORT_STATE_INACTIVE:
+	case DRM_FABRIC_PORT_STATE_ACTIVE:
+	case DRM_FABRIC_PORT_STATE_DEGRADED:
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * drm_fabric_port_set_oper() - Update a port's operational state
+ * @port: port to update
+ * @state: new operational state
+ *
+ * Advances the topology generation if the state actually changed. Invalid
+ * states are provider bugs; they are warned about and ignored.
+ *
+ * Context: May sleep. Acquires drm_fabric_lock.
+ */
+void drm_fabric_port_set_oper(struct drm_fabric_port *port,
+			      enum drm_fabric_port_state state)
+{
+	if (WARN_ON_ONCE(!drm_fabric_port_oper_state_valid(state)))
+		return;
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		enum drm_fabric_port_state old = port->oper_state;
+
+		port->oper_state = state;
+		if (old != state)
+			drm_fabric_base_seq_inc();
+	}
+}
+EXPORT_SYMBOL(drm_fabric_port_set_oper);
+
+static int __init drm_fabric_init(void)
+{
+	return 0;
+}
+
+static void __exit drm_fabric_exit(void)
+{
+	WARN_ON(!xa_empty(&drm_fabric_xa));
+	WARN_ON(!xa_empty(&drm_fabric_ep_xa));
+	xa_destroy(&drm_fabric_xa);
+	xa_destroy(&drm_fabric_ep_xa);
+}
+
+module_init(drm_fabric_init);
+module_exit(drm_fabric_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("DRM fabric infrastructure");
+MODULE_LICENSE("Dual MIT/GPL");
diff --git a/drivers/gpu/drm/fabric/drm_fabric_internal.h b/drivers/gpu/drm/fabric/drm_fabric_internal.h
new file mode 100644
index 000000000000..d454225a0b81
--- /dev/null
+++ b/drivers/gpu/drm/fabric/drm_fabric_internal.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef __DRM_FABRIC_INTERNAL_H__
+#define __DRM_FABRIC_INTERNAL_H__
+
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/xarray.h>
+
+#include <drm/drm_fabric.h>
+
+extern struct mutex drm_fabric_lock;
+extern struct xarray drm_fabric_xa;    /* Fabric registry */
+extern struct xarray drm_fabric_ep_xa; /* Endpoint registry */
+
+extern u32 drm_fabric_base_seq;        /* Dump consistency sequence */
+
+struct drm_fabric *drm_fabric_find_by_id(u32 id);
+struct drm_fabric_endpoint *drm_fabric_endpoint_find_by_id(u32 id);
+struct drm_fabric_endpoint *
+drm_fabric_endpoint_find_by_dev_name(const char *devname, const char *busname);
+struct drm_fabric_port *drm_fabric_port_find(u32 ep_id, u32 port_idx);
+
+struct drm_fabric_port *drm_fabric_port_find_get(u32 ep_id, u32 port_idx);
+void drm_fabric_port_put(struct drm_fabric_port *port);
+struct drm_fabric_endpoint *drm_fabric_endpoint_get(struct drm_fabric_endpoint *ep);
+void drm_fabric_endpoint_put(struct drm_fabric_endpoint *ep);
+struct drm_fabric *drm_fabric_get(struct drm_fabric *fabric);
+void drm_fabric_put(struct drm_fabric *fabric);
+
+#endif /* __DRM_FABRIC_INTERNAL_H__ */
diff --git a/include/drm/drm_fabric.h b/include/drm/drm_fabric.h
new file mode 100644
index 000000000000..68d8acec2d38
--- /dev/null
+++ b/include/drm/drm_fabric.h
@@ -0,0 +1,259 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+/*
+ * DRM Fabric driver API: common object model for GPU interconnect topology
+ * (fabric, endpoint, port and peer relationships).
+ */
+
+#ifndef __DRM_FABRIC_H__
+#define __DRM_FABRIC_H__
+
+#include <linux/completion.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
+#include <linux/xarray.h>
+
+enum drm_fabric_type {
+	/* Zero is invalid; concrete fabric types start at 1. */
+	DRM_FABRIC_TYPE_SYNTHETIC = 1,
+};
+
+enum drm_fabric_port_state {
+	DRM_FABRIC_PORT_STATE_UNKNOWN,
+	DRM_FABRIC_PORT_STATE_INACTIVE,
+	DRM_FABRIC_PORT_STATE_ACTIVE,
+	DRM_FABRIC_PORT_STATE_DEGRADED,
+};
+
+enum drm_fabric_peer_type {
+	DRM_FABRIC_PEER_TYPE_ACCEL = 1,
+	DRM_FABRIC_PEER_TYPE_SWITCH,
+};
+
+struct device;
+
+/**
+ * struct drm_fabric_port_desc - Port descriptor for drm_fabric_endpoint_register()
+ */
+struct drm_fabric_port_desc {
+	/** @index: per-endpoint port index */
+	u32 index;
+	/** @max_lane_count: maximum provider-reported link width capability, 0 if not reported */
+	u32 max_lane_count;
+	/**
+	 * @max_lane_signaling_rate_mbps: maximum provider-reported per-lane
+	 * signaling rate in decimal megabits per second before encoding, FEC
+	 * and protocol overhead, 0 if not reported. A capability, not the
+	 * negotiated rate: multiplying it by @max_lane_count does not give
+	 * usable bandwidth.
+	 */
+	u32 max_lane_signaling_rate_mbps;
+};
+
+/**
+ * struct drm_fabric_endpoint_desc - Endpoint descriptor for drm_fabric_endpoint_register()
+ */
+struct drm_fabric_endpoint_desc {
+	/**
+	 * @fabric_ep_id: accelerator identity within the fabric's identity
+	 * domain, unique among its members and stable for the duration of
+	 * membership; a duplicate is rejected with -EEXIST. Distinct from the
+	 * core-assigned &drm_fabric_endpoint.id.
+	 */
+	u64 fabric_ep_id;
+	/** @name: human-readable endpoint name */
+	const char *name;
+	/** @parent: required backing device, provides dev_name and bus */
+	struct device *parent;
+	/** @ops: provider driver callbacks */
+	const struct drm_fabric_ops *ops;
+	/**
+	 * @priv: provider cookie reachable from every @ops callback via @ep
+	 * or @port. The core stores it, never dereferences it, never frees it.
+	 */
+	void *priv;
+
+	/** @ports: fixed set of ports, copied by the core */
+	const struct drm_fabric_port_desc *ports;
+	/** @num_ports: number of entries in @ports */
+	unsigned int num_ports;
+};
+
+/**
+ * struct drm_fabric_desc - Fabric descriptor for drm_fabric_register()
+ */
+struct drm_fabric_desc {
+	/** @type: fabric interconnect technology */
+	enum drm_fabric_type type;
+	/** @name: human-readable fabric name */
+	const char *name;
+	/** @instance_id: vendor-unique instance identifier */
+	u64 instance_id;
+};
+
+/**
+ * struct drm_fabric - Fabric object
+ */
+struct drm_fabric {
+	/** @id: kernel-local identifier, assigned by the core */
+	u32 id;
+	/** @type: fabric interconnect technology */
+	enum drm_fabric_type type;
+	/** @instance_id: vendor-unique identifier within @type */
+	u64 instance_id;
+	/** @name: human-readable fabric name */
+	char name[32];
+
+	/** @refs: reference count */
+	refcount_t refs;
+};
+
+/**
+ * struct drm_fabric_endpoint - Endpoint object
+ */
+struct drm_fabric_endpoint {
+	/** @id: kernel-local identifier, assigned by the core */
+	u32 id;
+	/** @fabric_ep_id: provider's stable fabric-local identity */
+	u64 fabric_ep_id;
+	/** @name: human-readable endpoint name */
+	char name[32];
+	/** @parent: backing device, provides dev_name and bus_name */
+	struct device *parent;
+
+	/** @fabric: parent fabric */
+	struct drm_fabric *fabric;
+
+	/** @ops: provider driver callbacks */
+	const struct drm_fabric_ops *ops;
+	/** @priv: provider cookie, as supplied at registration */
+	void *priv;
+
+	/** @ports: xarray of &struct drm_fabric_port owned by this endpoint */
+	struct xarray ports;
+	/** @num_ports: number of ports in @ports */
+	unsigned int num_ports;
+
+	/** @refs: reference count */
+	refcount_t refs;
+	/** @unregistered: completed once the endpoint is fully unregistered */
+	struct completion unregistered;
+};
+
+/**
+ * drm_fabric_endpoint_fabric_id() - Wire fabric-id for an endpoint
+ * @ep: endpoint to query
+ *
+ * Return: the parent fabric id.
+ */
+static inline u32
+drm_fabric_endpoint_fabric_id(const struct drm_fabric_endpoint *ep)
+{
+	return ep->fabric->id;
+}
+
+/**
+ * struct drm_fabric_peer - Directly adjacent far-end identity
+ *
+ * A value descriptor, not a reference to a live object. While its owning port
+ * remains registered, it is retained until explicitly retracted even if the
+ * object it names stops resolving locally. See "Peer semantics" in
+ * Documentation/gpu/drm-fabric.rst.
+ */
+struct drm_fabric_peer {
+	/**
+	 * @peer_id: identity of the far-end object, read per @peer_type: an
+	 * accelerator's fabric_ep_id, or an opaque switch identity. The two
+	 * are separate namespaces, so one value names different objects
+	 * under each type, and neither has to resolve locally.
+	 */
+	u64 peer_id;
+
+	/** @peer_type: kind of far-end device; selects the @peer_id namespace */
+	enum drm_fabric_peer_type peer_type;
+	/** @port_index: far-end port index within the object @peer_id names */
+	u32 port_index;
+};
+
+/**
+ * struct drm_fabric_port - Port object
+ */
+struct drm_fabric_port {
+	/** @index: per-endpoint port index */
+	u32 index;
+	/** @oper_state: operational (link) state */
+	enum drm_fabric_port_state oper_state;
+	/** @max_lane_count: as in &struct drm_fabric_port_desc */
+	u32 max_lane_count;
+	/** @max_lane_signaling_rate_mbps: as in &struct drm_fabric_port_desc */
+	u32 max_lane_signaling_rate_mbps;
+
+	/** @has_peer: whether @peer holds a valid descriptor */
+	bool has_peer;
+	/** @peer: neighbor description, valid only while @has_peer is set */
+	struct drm_fabric_peer peer;
+
+	/** @endpoint: parent endpoint */
+	struct drm_fabric_endpoint *endpoint;
+};
+
+/**
+ * struct drm_fabric_port_stats - Per-port statistics for the port_stats_get() callback
+ *
+ * Counters are monotonic for the lifetime of the provider's registration and
+ * are not clearable through this uAPI. Link error accounting belongs to DRM
+ * RAS and is deliberately absent here.
+ */
+struct drm_fabric_port_stats {
+	/** @read_bytes: bytes received on the port */
+	u64 read_bytes;
+	/** @write_bytes: bytes transmitted on the port */
+	u64 write_bytes;
+	/** @link_down_count: link-down transitions */
+	u64 link_down_count;
+	/** @retrain_count: link retrain events */
+	u64 retrain_count;
+};
+
+/**
+ * struct drm_fabric_ops - Provider driver callbacks
+ *
+ * A callback that is not supplied makes the matching netlink operation return
+ * -EOPNOTSUPP.
+ */
+struct drm_fabric_ops {
+	/**
+	 * @port_stats_get: read per-port statistics. The core pins the port
+	 * through its endpoint and calls without drm_fabric_lock held, so this
+	 * may sleep. It must not re-enter a core API that takes the lock or take
+	 * a provider lock from which the core may be called.
+	 *
+	 * Populate every field or return -EOPNOTSUPP. Zero is a valid count,
+	 * not an unsupported marker.
+	 */
+	int (*port_stats_get)(struct drm_fabric_port *port,
+			      struct drm_fabric_port_stats *stats);
+};
+
+struct drm_fabric *drm_fabric_register(const struct drm_fabric_desc *desc);
+int drm_fabric_unregister(struct drm_fabric *fabric);
+
+struct drm_fabric_endpoint *
+drm_fabric_endpoint_register(struct drm_fabric *fabric,
+			     const struct drm_fabric_endpoint_desc *desc);
+void drm_fabric_endpoint_unregister(struct drm_fabric_endpoint *ep);
+
+struct drm_fabric_port *
+drm_fabric_endpoint_port(struct drm_fabric_endpoint *ep, u32 port_index);
+
+int drm_fabric_port_set_peer(struct drm_fabric_port *port,
+			     const struct drm_fabric_peer *peer);
+int drm_fabric_port_unset_peer(struct drm_fabric_port *port);
+
+void drm_fabric_port_set_oper(struct drm_fabric_port *port,
+			      enum drm_fabric_port_state state);
+
+#endif /* __DRM_FABRIC_H__ */
-- 
2.43.0

