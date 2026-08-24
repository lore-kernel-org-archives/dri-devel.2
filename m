Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103A8C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7262510E689;
	Mon, 24 Aug 2026 08:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ByRWCrWK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0212810E687
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:10:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D928441403;
 Mon, 24 Aug 2026 08:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03B91F00A3E;
 Mon, 24 Aug 2026 08:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787559010;
 bh=3bOD35N9hzlOHer1DJ+BslyoToWmJfP4iRcfNvS+PjU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ByRWCrWKlzvxO1Z9tmfenL9hxa7L+5VPw1BTy0QHOF1PGY+4x/BGAXN4jfdiQzHa4
 PP9oXsElAuoASTDYGtlnwZi2AhuGUvs+7qrKhyT/K2PK7Z63lkBNluS1+Y4E2TUv4C
 lobbiiA4Z7eNv9jvjahln3jbJRG8obgR9yZ3wSVQWSlaLROClwO8Bb0OJTDZxmrLex
 Ka1AtTuEo594omaJBgE32djWifTweQ0dVzbzKa+arNso8abBa/nh8VtkV5tO42O4Z4
 juyRGv3B2+GbO5MxPFgoED386FZkl29weVzWXuTz8E0JQlbDAP4WaU/xhiGxvJFGqS
 mlD9by+gvPehg==
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
Subject: [RFC PATCH 07/12] drm/fabric: add topology-provisioning core
Date: Mon, 24 Aug 2026 11:09:35 +0300
Message-ID: <0ecb1eb1209aa1ff0a58f5a23f5ba3014277690a.1787552412.git.ksinyuk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
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

From: Ilia Levi <ilia.levi@intel.com>

Everything so far reports topology that a provider composed. Composing it
from userspace needs the core to create an empty fabric, move an endpoint
into or out of one, change administrative state and record a peer. None of
that may leave the object model half-updated.

Add the core mechanisms without exposing provisioning netlink operations.
Deleting a provider-owned or non-empty fabric is refused.

Provider callbacks may sleep and therefore run without drm_fabric_lock.
drm_fabric_mutation_lock serialises validation, the provider callback and
the core update, with targets pinned across the unlocked callback.
Registration and teardown join the same transaction domain, so a successful
callback cannot be invalidated before commit.

Administrative intent stays separate from operational state, and each port
selects one peer writer at registration. A request that already matches
committed state succeeds without invoking the provider.

Registering an orphan endpoint is now valid, so the KUnit case asserting
that a NULL fabric is rejected is repurposed to assert that it yields an
orphan reporting fabric-id 0.

Signed-off-by: Ilia Levi <ilia.levi@intel.com>
Co-developed-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Signed-off-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Assisted-by: GitHub-Copilot:claude-opus-4.8
---
 Documentation/gpu/drm-fabric.rst             |  93 ++--
 drivers/gpu/drm/fabric/drm_fabric.c          | 554 +++++++++++++++----
 drivers/gpu/drm/fabric/drm_fabric_internal.h |  13 +
 drivers/gpu/drm/fabric/drm_fabric_test.c     |  17 +-
 include/drm/drm_fabric.h                     | 108 +++-
 5 files changed, 637 insertions(+), 148 deletions(-)

diff --git a/Documentation/gpu/drm-fabric.rst b/Documentation/gpu/drm-fabric.rst
index bc7b87c766cc..61e2c18bf0b5 100644
--- a/Documentation/gpu/drm-fabric.rst
+++ b/Documentation/gpu/drm-fabric.rst
@@ -18,6 +18,8 @@ Key Goals:
   (xGMI, UALink and similar), enabling data-center discovery and monitoring.
 * Support read-only enumeration, monitoring and state queries for
   provider-owned topology.
+* Support topology provisioning as an optional provider capability, covering
+  fabric and endpoint lifecycle, port administration and peer management.
 * Allow new attributes and fabric types to be added without reusing existing
   wire identifiers, so the uAPI extends without breaking existing consumers.
 * Allow multiple endpoints and ports per provider, so drivers can model
@@ -56,13 +58,14 @@ provider reports: for example, it may be a full mesh with no root, a linear
 chain, or a switch-based topology in which ports terminate at opaque switch
 peers rather than locally registered endpoints.
 
-A *peer* is a value descriptor, not a reference to a live kernel object: its
-``peer-id`` may name a remote accelerator managed by another OS or an opaque
-switch in another trust domain, and need not resolve in the local registry. The
-core stores one directed half-edge and does not require the reverse half-edge to
-exist, so removing an endpoint does not retract peer descriptors held by other
-endpoints. ``peer-type = switch`` only describes the kind of far end; it does
-not create a first-class switch object.
+An endpoint may be registered without a fabric. Such an endpoint is an *orphan*
+and reports ``fabric-id`` 0. A *peer* is a value descriptor, not a reference to
+a live kernel object: its ``peer-id`` may name a remote accelerator managed by
+another OS or an opaque switch in another trust domain, and need not resolve in
+the local registry. The core stores one directed half-edge and does not require
+the reverse half-edge to exist, so removing an endpoint does not retract peer
+descriptors held by other endpoints. ``peer-type = switch`` only describes the
+kind of far end; it does not create a first-class switch object.
 
 .. kernel-doc:: drivers/gpu/drm/fabric/drm_fabric.c
    :doc: DRM Fabric core
@@ -79,10 +82,10 @@ that half-edge. A peer is therefore topology as last set, not proof of live
 connectivity; liveness belongs to the fabric controller.
 
 The core never retracts a half-edge on its own. Failing to resolve a peer
-locally is not the same as the link going away -- the far end may be a switch,
-an accelerator on another node, or a local endpoint that merely unregistered
--- so only the provider knows when a port's physical adjacency actually
-changed, and only the provider retracts or replaces the descriptor.
+locally is not the same as the link going away -- the far end may be a
+switch, an accelerator on another node, or a local endpoint that merely
+unregistered -- so only the provider knows when a port's physical adjacency
+actually changed, and only the provider retracts or replaces the descriptor.
 
 ``port-peer-delete-ntf`` reports an explicitly retracted half-edge; it is
 not emitted when a peer merely becomes locally unresolvable, so its absence
@@ -105,11 +108,15 @@ Driver API
 Design scope and boundaries
 ===========================
 
-Vendor drivers retain hardware discovery, firmware interaction and the
-load/store data path; DRM Fabric represents only the topology and
-provider-reported state of DRM-managed accelerators, which is why it
-belongs in DRM. The interface does not define MMU programming, switch
-policy, key management, live migration, or any required user space daemon.
+The core records direct adjacency only, not end-to-end reachability or switch
+forwarding, which remain with the fabric controller. Vendor drivers retain
+hardware discovery, firmware interaction, memory semantics and the
+hardware-carried data path; DRM Fabric represents only the topology and
+control state of DRM-managed accelerators, which is why it belongs in DRM.
+It does not create a network device or own route computation, switch
+forwarding, transport or congestion control. The interface also does not
+define MMU programming, switch policy, key management, live migration, or
+any required user space daemon.
 
 DRM Fabric does not define in-network collective operations or how an
 endpoint or switch executes them. Such capabilities belong to the
@@ -123,27 +130,49 @@ strengthens the contract rather than breaking it.
 Object lifetime and locking
 ===========================
 
-All registry and object state is protected by ``drm_fabric_lock``. A fabric and
-its endpoints are created and torn down through the provider API; endpoint
-unregister removes the endpoint from the registry and frees its fixed set of
-ports. Fabric membership is tracked, so a provider must remove all member
-endpoints before unregistering a provider-owned fabric: drm_fabric_unregister()
-returns ``-EBUSY`` and leaves the fabric registered if any remain, so the
-provider must retry after removing them rather than treat the fabric as gone.
+Registry membership and object state are protected by ``drm_fabric_lock``;
+topology mutation is additionally serialised by ``drm_fabric_mutation_lock``,
+described below. A fabric and its endpoints are created and torn down through
+the provider API; endpoint unregister removes the endpoint from the registry
+and frees its fixed set of ports. Fabric membership is tracked, so a provider
+must remove all member endpoints before unregistering a provider-owned fabric:
+drm_fabric_unregister() returns ``-EBUSY`` and leaves the fabric registered if
+any remain, so the provider must retry after removing them rather than treat
+the fabric as gone.
 
 Objects are reference counted and a port is pinned through its owning endpoint.
 Endpoint unregister drops the registration reference and waits for outstanding
 pins before freeing the ports; fabric membership holds a fabric reference.
 
-Providers own object lifetime, so a provider must serialise endpoint
-registration against unregistration of the containing fabric. The unregister
-entry points compare the supplied pointer against the registry before
-dereferencing it, so a stale or repeated teardown is rejected: fabric
-unregistration returns ``-ENODEV``, and endpoint unregistration, having no
-error return, warns and performs no teardown. Endpoint registration rejects a
-departed parent the same way. These checks prove current address membership
-only: they cannot tell an earlier incarnation from another object registered
-later at the same address.
+Providers own object lifetime. The unregister entry points compare the supplied
+pointer against the registry before dereferencing it, so a stale or repeated
+teardown is rejected: fabric unregistration returns ``-ENODEV``, and endpoint
+unregistration, having no error return, warns and performs no teardown.
+Endpoint registration rejects a departed parent the same way. These checks
+prove current address membership only: they cannot tell an earlier incarnation
+from another object registered later at the same address. Only the provider
+knows its own object lifecycle.
+
+Netlink mutation commands additionally hold ``drm_fabric_mutation_lock`` across
+target resolution, the provider callback and the core commit. The lock order
+is::
+
+    drm_fabric_mutation_lock -> drm_fabric_lock
+
+Provider lifecycle operations that can invalidate a prepared mutation take the
+same mutation lock: endpoint registration as well as endpoint and fabric
+unregister. A provider-driven teardown therefore cannot race an in-flight
+mutation on the same object, and a registration cannot claim a fabric-scoped
+``fabric-ep-id`` after an attach has validated the identifier but before its
+provider callback completes. A provider must not invoke any of these lifecycle
+operations from one of its own mutation callbacks: the callback already holds
+the mutation lock, so the nested acquisition would self-deadlock. A successful
+callback therefore cannot be invalidated before commit, and the post-callback
+checks are invariant assertions only.
+
+A fabric records whether it was created by a provider or by userspace. Only an
+empty userspace-created fabric may be deleted through the provisioning core;
+provider-owned and non-empty fabrics are rejected.
 
 Generic Netlink family
 ======================
diff --git a/drivers/gpu/drm/fabric/drm_fabric.c b/drivers/gpu/drm/fabric/drm_fabric.c
index bbc3224c3314..1aae5ff68798 100644
--- a/drivers/gpu/drm/fabric/drm_fabric.c
+++ b/drivers/gpu/drm/fabric/drm_fabric.c
@@ -25,14 +25,23 @@
  * drm_fabric_port_unset_peer().
  *
  * The core owns object identity and lifetime: it assigns kernel-local IDs,
- * refcounts objects, serialises access under its internal lock, and advances a
- * topology generation on every change so a concurrent netlink dump can detect
- * a torn snapshot.
+ * refcounts objects, serialises object state under drm_fabric_lock and
+ * topology mutation under drm_fabric_mutation_lock, and advances a topology
+ * generation on every change so a concurrent netlink dump can detect a torn
+ * snapshot. See Documentation/gpu/drm-fabric.rst for the fuller object
+ * lifetime and locking treatment.
  */
 
 /* Global lock for all fabric, endpoint and port state. */
 DEFINE_MUTEX(drm_fabric_lock);
 
+/*
+ * Lock order is mutation_lock -> drm_fabric_lock; a provider callback already
+ * holds this and must not re-enter registration/unregistration.
+ */
+DEFINE_MUTEX(drm_fabric_mutation_lock);
+
+/* ID 0 is the orphan sentinel, so allocated IDs start at 1. */
 DEFINE_XARRAY_ALLOC1(drm_fabric_xa);
 DEFINE_XARRAY_ALLOC(drm_fabric_ep_xa);
 
@@ -101,10 +110,8 @@ drm_fabric_endpoint_find_by_dev_name(const char *devname, const char *busname)
 }
 
 /*
- * Returns true if a member of @fabric already uses @fabric_ep_id. fabric_ep_id
- * is the accelerator's identity within a fabric and is what a peer descriptor
- * names (peer_id for DRM_FABRIC_PEER_TYPE_ACCEL), so it must be unique per
- * fabric or peer resolution is ambiguous.
+ * fabric_ep_id must be unique per fabric or peer resolution is ambiguous;
+ * orphans (@fabric == NULL) do not participate.
  */
 static bool drm_fabric_ep_id_in_use(const struct drm_fabric *fabric, u64 fabric_ep_id)
 {
@@ -113,6 +120,9 @@ static bool drm_fabric_ep_id_in_use(const struct drm_fabric *fabric, u64 fabric_
 
 	lockdep_assert_held(&drm_fabric_lock);
 
+	if (!fabric)
+		return false;
+
 	xa_for_each(&drm_fabric_ep_xa, idx, ep)
 		if (ep->fabric == fabric &&
 		    ep->fabric_ep_id == fabric_ep_id)
@@ -136,40 +146,20 @@ static bool drm_fabric_has_instance(const struct drm_fabric *fabric)
 	return false;
 }
 
-static bool drm_fabric_type_valid(enum drm_fabric_type type)
-{
-	switch (type) {
-	case DRM_FABRIC_TYPE_SYNTHETIC:
-		return true;
-	}
-
-	return false;
-}
-
-/**
- * drm_fabric_register() - Register a new fabric
- * @desc: fabric description (type, instance id, name)
- *
- * Allocates the fabric and inserts it into the registry as provider-owned.
- * Rejects zero and out-of-range types before allocating.
- *
- * Context: May sleep. Acquires drm_fabric_lock.
- * Return: the registered fabric, or an ERR_PTR() on failure, -EINVAL for a
- *         type this kernel does not define.
- */
-struct drm_fabric *drm_fabric_register(const struct drm_fabric_desc *desc)
+/* @owner is set once here, before publication, so no reader needs a lock for it. */
+static struct drm_fabric *
+__drm_fabric_register(const struct drm_fabric_desc *desc,
+		      enum drm_fabric_owner owner)
 {
 	struct drm_fabric *fabric __free(kfree) = NULL;
 
-	if (WARN_ON_ONCE(!drm_fabric_type_valid(desc->type)))
-		return ERR_PTR(-EINVAL);
-
 	fabric = kzalloc_obj(*fabric);
 	if (!fabric)
 		return ERR_PTR(-ENOMEM);
 
 	fabric->type = desc->type;
 	fabric->instance_id = desc->instance_id;
+	fabric->owner = owner;
 	refcount_set(&fabric->refs, 1);
 
 	if (desc->name &&
@@ -191,6 +181,35 @@ struct drm_fabric *drm_fabric_register(const struct drm_fabric_desc *desc)
 
 	return_ptr(fabric);
 }
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
+	if (WARN_ON_ONCE(!drm_fabric_type_valid(desc->type)))
+		return ERR_PTR(-EINVAL);
+
+	return __drm_fabric_register(desc, DRM_FABRIC_OWNER_PROVIDER);
+}
 EXPORT_SYMBOL(drm_fabric_register);
 
 struct drm_fabric *drm_fabric_get(struct drm_fabric *fabric)
@@ -253,27 +272,40 @@ static bool drm_fabric_is_registered(const struct drm_fabric *fabric)
  * from another fabric registered later at the same address, which remains
  * the provider's obligation.
  *
- * Context: May sleep. Acquires drm_fabric_lock.
- * Return: 0 on removal. -ENODEV if @fabric is not registered, checked first.
- *         -EBUSY if members remain; the fabric stays registered and the
- *         provider must remove them before retrying. -EBUSY also warns
- *         because this is a teardown-ordering bug.
+ * Context: May sleep. Acquires drm_fabric_mutation_lock, then drm_fabric_lock.
+ *          Must not be called from a provider mutation callback (endpoint_set /
+ *          port_set / port_peer_*), which already holds the mutation lock and
+ *          would self-deadlock.
+ * Return: 0 once the fabric is removed. -ENODEV if @fabric is not currently
+ *         registered, which takes precedence over the member check. -EBUSY
+ *         if member endpoints remain, in which case the fabric stays fully
+ *         registered and the provider must unregister the members before
+ *         retrying -- a non-empty unregister is a provider teardown-ordering
+ *         bug, so it also warns.
  */
 int drm_fabric_unregister(struct drm_fabric *fabric)
 {
-	scoped_guard(mutex, &drm_fabric_lock) {
-		if (!drm_fabric_is_registered(fabric))
-			return -ENODEV;
-		/*
-		 * Members still reference ep->fabric; freeing it here would
-		 * leave stale pointers.
-		 */
-		if (WARN_ON_ONCE(drm_fabric_has_members(fabric)))
-			return -EBUSY;
-		/* Emit before the erase, while @fabric is still live. */
-		drm_fabric_emit_fabric_delete(fabric,
-					      drm_fabric_base_seq_inc());
-		xa_erase(&drm_fabric_xa, fabric->id);
+	/*
+	 * The mutation lock below blocks a racing unregister or endpoint_set attach
+	 * on this fabric.
+	 */
+	lockdep_assert_not_held(&drm_fabric_mutation_lock);
+
+	scoped_guard(mutex, &drm_fabric_mutation_lock) {
+		scoped_guard(mutex, &drm_fabric_lock) {
+			if (!drm_fabric_is_registered(fabric))
+				return -ENODEV;
+			/*
+			 * Members still reference ep->fabric; freeing it here
+			 * would leave stale pointers.
+			 */
+			if (WARN_ON_ONCE(drm_fabric_has_members(fabric)))
+				return -EBUSY;
+			/* Emit before the erase, while @fabric is still live. */
+			drm_fabric_emit_fabric_delete(fabric,
+						      drm_fabric_base_seq_inc());
+			xa_erase(&drm_fabric_xa, fabric->id);
+		}
 	}
 
 	drm_fabric_put(fabric);
@@ -314,6 +346,8 @@ static int drm_fabric_ports_create(struct drm_fabric_endpoint *ep,
 		port->max_lane_signaling_rate_mbps =
 			descs[i].max_lane_signaling_rate_mbps;
 		port->oper_state = DRM_FABRIC_PORT_STATE_UNKNOWN;
+		port->admin_state = DRM_FABRIC_ADMIN_STATE_DOWN;
+		port->peer_mode = descs[i].peer_mode;
 		port->has_peer = false;
 		port->endpoint = ep;
 
@@ -333,23 +367,30 @@ static int drm_fabric_ports_create(struct drm_fabric_endpoint *ep,
 }
 
 /**
- * drm_fabric_endpoint_register() - Register a provider-owned endpoint
- * @fabric: non-NULL fabric the endpoint belongs to
+ * drm_fabric_endpoint_register() - Register an endpoint
+ * @fabric: fabric the endpoint belongs to
  * @desc: endpoint description, including its fixed set of ports
  *
- * Registers @desc as a member of @fabric and advances the topology generation.
- * @desc->fabric_ep_id must be unique among the fabric's registered endpoints.
+ * Registers the endpoint and emits an ENDPOINT_CREATE event. When the endpoint
+ * joins a fabric its desc->fabric_ep_id must be unique among that fabric's
+ * members; a duplicate is rejected with -EEXIST.
  *
- * The provider must serialise this call against drm_fabric_unregister() of
- * @fabric. A fabric that has already left the registry is rejected, but that
- * check matches on address and cannot distinguish incarnations; only the
- * provider knows its own object lifecycle.
+ * A NULL @fabric registers an orphan endpoint, which a later ENDPOINT_SET
+ * attach can join to a fabric.
  *
- * Context: May sleep. Acquires drm_fabric_lock.
+ * A fabric that has already left the registry is rejected, but that check
+ * matches on address and cannot distinguish incarnations; only the provider
+ * knows its own object lifecycle.
+ *
+ * Publication joins the mutation transaction domain
+ * (drm_fabric_mutation_lock -> drm_fabric_lock), so a provider must not call
+ * this from within a mutation callback (that would self-deadlock).
+ *
+ * Context: May sleep. Acquires drm_fabric_mutation_lock, then drm_fabric_lock.
  * Return: the registered endpoint, or an ERR_PTR() on failure: -EINVAL if
- * @fabric or @desc->parent is NULL, or @desc claims ports without supplying a
- * port array, -ENODEV if @fabric is no longer registered, -EEXIST if
- * @desc->fabric_ep_id is already in use within @fabric.
+ * @desc->parent is NULL, or @desc claims ports without supplying a port array,
+ * -ENODEV if @fabric is no longer registered, -EEXIST if @desc->fabric_ep_id is
+ * already in use within @fabric.
  */
 struct drm_fabric_endpoint *
 drm_fabric_endpoint_register(struct drm_fabric *fabric,
@@ -358,8 +399,7 @@ drm_fabric_endpoint_register(struct drm_fabric *fabric,
 	struct drm_fabric_endpoint *ep __free(kfree) = NULL;
 	int ret;
 
-	if (!fabric)
-		return ERR_PTR(-EINVAL);
+	lockdep_assert_not_held(&drm_fabric_mutation_lock);
 
 	/* Supplies dev_name()/bus for the query paths; pinned below. */
 	if (!desc->parent)
@@ -377,6 +417,7 @@ drm_fabric_endpoint_register(struct drm_fabric *fabric,
 	ep->parent = desc->parent;
 	ep->ops = desc->ops;
 	ep->priv = desc->priv;
+	ep->admin_state = fabric ? DRM_FABRIC_ADMIN_STATE_UP : DRM_FABRIC_ADMIN_STATE_DOWN;
 	refcount_set(&ep->refs, 1);
 	init_completion(&ep->unregistered);
 	xa_init(&ep->ports);
@@ -391,28 +432,31 @@ drm_fabric_endpoint_register(struct drm_fabric *fabric,
 
 	get_device(ep->parent);
 
-	scoped_guard(mutex, &drm_fabric_lock) {
-		/*
-		 * A concurrent drm_fabric_unregister() may have freed @fabric
-		 * since the caller passed it, so validate membership by address
-		 * without dereferencing it.
-		 */
-		if (!drm_fabric_is_registered(fabric)) {
-			ret = -ENODEV;
-			break;
-		}
-
-		if (drm_fabric_ep_id_in_use(fabric, ep->fabric_ep_id)) {
-			ret = -EEXIST;
-			break;
+	ret = 0;
+	/*
+	 * Under the mutation lock a concurrent ENDPOINT_SET attach cannot also
+	 * claim this (fabric, fabric_ep_id).
+	 */
+	scoped_guard(mutex, &drm_fabric_mutation_lock) {
+		scoped_guard(mutex, &drm_fabric_lock) {
+			if (fabric && !drm_fabric_is_registered(fabric)) {
+				ret = -ENODEV;
+				break;
+			}
+
+			if (drm_fabric_ep_id_in_use(fabric, ep->fabric_ep_id)) {
+				ret = -EEXIST;
+				break;
+			}
+
+			ret = xa_alloc(&drm_fabric_ep_xa, &ep->id, ep, xa_limit_32b, GFP_KERNEL);
+			if (ret)
+				break;
+			if (fabric)
+				drm_fabric_get(fabric);
+
+			drm_fabric_emit_endpoint_create(ep, drm_fabric_base_seq_inc());
 		}
-
-		ret = xa_alloc(&drm_fabric_ep_xa, &ep->id, ep, xa_limit_32b, GFP_KERNEL);
-		if (ret)
-			break;
-		drm_fabric_get(fabric);
-
-		drm_fabric_emit_endpoint_create(ep, drm_fabric_base_seq_inc());
 	}
 
 	if (ret) {
@@ -494,26 +538,36 @@ static bool drm_fabric_ep_is_registered(const struct drm_fabric_endpoint *ep)
  * and performs no teardown; there is no error return to report it. As for a
  * fabric, the comparison proves current address membership only.
  *
- * Context: May sleep. Acquires drm_fabric_lock.
+ * Context: May sleep. Acquires drm_fabric_mutation_lock, then drm_fabric_lock.
+ *          Must not be called from a provider mutation callback, which already
+ *          holds the mutation lock and would self-deadlock.
  */
 void drm_fabric_endpoint_unregister(struct drm_fabric_endpoint *ep)
 {
-	scoped_guard(mutex, &drm_fabric_lock) {
-		if (WARN_ON_ONCE(!drm_fabric_ep_is_registered(ep)))
-			return;
-		/* Emit before the erase, while @ep is still live. */
-		drm_fabric_emit_endpoint_delete(ep, drm_fabric_base_seq_inc());
-		xa_erase(&drm_fabric_ep_xa, ep->id);
-	}
+	lockdep_assert_not_held(&drm_fabric_mutation_lock);
 
 	/*
-	 * Drop the registration reference and wait for any in-flight netlink
-	 * operation that pinned the endpoint to complete.
+	 * Blocks a racing mutator: @ep cannot resolve once erased, so no
+	 * ENDPOINT_CHANGE follows.
 	 */
+	scoped_guard(mutex, &drm_fabric_mutation_lock) {
+		scoped_guard(mutex, &drm_fabric_lock) {
+			if (WARN_ON_ONCE(!drm_fabric_ep_is_registered(ep)))
+				return;
+			/* Emit before the erase, while @ep is still live. */
+			drm_fabric_emit_endpoint_delete(ep,
+							drm_fabric_base_seq_inc());
+			xa_erase(&drm_fabric_ep_xa, ep->id);
+		}
+	}
+
+	/* Wait for in-flight operations holding endpoint pins. */
 	drm_fabric_endpoint_put(ep);
 	wait_for_completion(&ep->unregistered);
 
-	drm_fabric_put(ep->fabric);
+	/* An orphan endpoint holds no fabric reference. */
+	if (ep->fabric)
+		drm_fabric_put(ep->fabric);
 
 	drm_fabric_ports_destroy(ep);
 	put_device(ep->parent);
@@ -572,16 +626,25 @@ static bool drm_fabric_peer_type_valid(enum drm_fabric_peer_type type)
  * @port: local port
  * @peer: descriptor of the endpoint on the other end
  *
- * Sets the peer and advances the topology generation on success.
+ * Emits a PORT_PEER_NEW event with new peer details on success. Only valid on a
+ * provider-managed port; a userspace-managed port (%DRM_FABRIC_PEER_MODE_USERSPACE)
+ * is programmed through the PORT_PEER_NEW uAPI instead.
  *
  * Context: May sleep. Acquires drm_fabric_lock.
- * Return: -EINVAL if @peer carries an unknown peer type, -EEXIST if the port
- * already has a peer. 0 on success.
+ * Return: -EOPNOTSUPP on a userspace-managed port, -EINVAL if @peer carries an
+ * unknown peer type, -EEXIST if the port already has a peer, 0 on success.
  */
 int drm_fabric_port_set_peer(struct drm_fabric_port *port,
 			     const struct drm_fabric_peer *peer)
 {
-	/* Reject a provider's invalid type before it reaches the wire. */
+	if (port->peer_mode != DRM_FABRIC_PEER_MODE_PROVIDER)
+		return -EOPNOTSUPP;
+
+	/*
+	 * An unknown type is a provider bug, and the netlink path serialises
+	 * the value verbatim into an enum-typed attribute, so refusing it here
+	 * keeps it off the wire.
+	 */
 	if (WARN_ON_ONCE(!drm_fabric_peer_type_valid(peer->peer_type)))
 		return -EINVAL;
 
@@ -602,17 +665,21 @@ EXPORT_SYMBOL(drm_fabric_port_set_peer);
  * drm_fabric_port_unset_peer() - Remove a neighbor (called by the provider)
  * @port: local port
  *
- * Inverse of drm_fabric_port_set_peer().
- * Removes the peer and advances the topology generation on success.
+ * Inverse of drm_fabric_port_set_peer(). Only valid on a provider-managed port.
+ * Emits a PORT_PEER_DEL event carrying the removed peer on success.
  *
  * Edge retraction is always explicit (provider- or controller-driven); the
  * core never removes a peer implicitly.
  *
  * Context: May sleep. Acquires drm_fabric_lock.
- * Return: -ENOENT if no peer set. 0 on success.
+ * Return: -EOPNOTSUPP on a userspace-managed port, -ENOENT if no peer set,
+ * 0 on success.
  */
 int drm_fabric_port_unset_peer(struct drm_fabric_port *port)
 {
+	if (port->peer_mode != DRM_FABRIC_PEER_MODE_PROVIDER)
+		return -EOPNOTSUPP;
+
 	scoped_guard(mutex, &drm_fabric_lock) {
 		if (!port->has_peer)
 			return -ENOENT;
@@ -669,6 +736,287 @@ void drm_fabric_port_set_oper(struct drm_fabric_port *port,
 }
 EXPORT_SYMBOL(drm_fabric_port_set_oper);
 
+/* FABRIC_NEW yields an empty fabric; endpoints join only via ENDPOINT_SET. */
+int drm_fabric_user_fabric_new(enum drm_fabric_type type, u64 instance_id,
+			       const char *name, u32 *fabric_id_out)
+{
+	struct drm_fabric_desc desc = {
+		.type = type,
+		.instance_id = instance_id,
+		.name = name,
+	};
+	struct drm_fabric *fabric;
+
+	lockdep_assert_held(&drm_fabric_mutation_lock);
+	lockdep_assert_not_held(&drm_fabric_lock);
+
+	/* Userspace-supplied: reject without warning. */
+	if (!drm_fabric_type_valid(type))
+		return -EINVAL;
+
+	/*
+	 * A userspace-owned fabric outlives this call -- only FABRIC_DEL
+	 * removes it -- so pin the module.
+	 */
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
+	fabric = __drm_fabric_register(&desc, DRM_FABRIC_OWNER_USERSPACE);
+	if (IS_ERR(fabric)) {
+		module_put(THIS_MODULE);
+		return PTR_ERR(fabric);
+	}
+
+	if (fabric_id_out)
+		*fabric_id_out = fabric->id;
+
+	return 0;
+}
+
+int drm_fabric_user_fabric_del(u32 fabric_id)
+{
+	struct drm_fabric *fabric;
+
+	lockdep_assert_held(&drm_fabric_mutation_lock);
+	lockdep_assert_not_held(&drm_fabric_lock);
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		fabric = xa_load(&drm_fabric_xa, fabric_id);
+		if (!fabric)
+			return -ENOENT;
+		/*
+		 * Userspace-owned fabrics only: a provider's registration pointer
+		 * would dangle.
+		 */
+		if (fabric->owner != DRM_FABRIC_OWNER_USERSPACE)
+			return -EPERM;
+		/* Symmetric with FABRIC_NEW: only an empty fabric may be removed. */
+		if (drm_fabric_has_members(fabric))
+			return -EBUSY;
+		drm_fabric_base_seq_inc();
+		xa_erase(&drm_fabric_xa, fabric->id);
+	}
+
+	/* Release the pin from FABRIC_NEW. */
+	module_put(THIS_MODULE);
+	drm_fabric_put(fabric);
+	return 0;
+}
+
+/* Pins the fabric for use after the lock is dropped, or ERR_PTR(-ENOENT). */
+static struct drm_fabric *drm_fabric_find_get_locked(u32 fabric_id)
+{
+	struct drm_fabric *fabric;
+
+	fabric = drm_fabric_find_by_id(fabric_id);
+	if (!fabric)
+		return ERR_PTR(-ENOENT);
+
+	return drm_fabric_get(fabric);
+}
+
+/*
+ * Caller holds mutation_lock throughout. The target is resolved and pinned
+ * before drm_fabric_lock is dropped for the sleeping callback.
+ */
+int drm_fabric_endpoint_set(struct drm_fabric_endpoint *ep,
+			    const struct drm_fabric_endpoint_change *req)
+{
+	struct drm_fabric_endpoint_change change = *req;
+	const struct drm_fabric_ops *ops = ep->ops;
+	struct drm_fabric *new_fabric = NULL;
+	int ret;
+
+	if (!ops || !ops->endpoint_set)
+		return -EOPNOTSUPP;
+
+	lockdep_assert_held(&drm_fabric_mutation_lock);
+	lockdep_assert_not_held(&drm_fabric_lock);
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		/* No-op administrative request. */
+		if ((change.valid & DRM_FABRIC_EP_CHANGE_ADMIN) &&
+		    change.admin == ep->admin_state)
+			change.valid &= ~DRM_FABRIC_EP_CHANGE_ADMIN;
+
+		if (!change.valid)
+			return 0;
+
+		if (!(change.valid & DRM_FABRIC_EP_CHANGE_FABRIC))
+			break;
+
+		if (change.fabric_id == drm_fabric_endpoint_fabric_id(ep)) {
+			change.valid &= ~DRM_FABRIC_EP_CHANGE_FABRIC;
+			if (!change.valid)
+				return 0;
+			break;
+		}
+
+		/* Detach */
+		if (!change.fabric_id)
+			break;
+
+		/* Attach: endpoint must be orphaned. */
+		if (ep->fabric)
+			return -EBUSY;
+
+		new_fabric = drm_fabric_find_get_locked(change.fabric_id);
+		if (IS_ERR(new_fabric))
+			return PTR_ERR(new_fabric);
+
+		/* Reject early if the target fabric already uses this id. */
+		if (drm_fabric_ep_id_in_use(new_fabric, ep->fabric_ep_id)) {
+			drm_fabric_put(new_fabric);
+			return -EEXIST;
+		}
+	}
+
+	ret = ops->endpoint_set(ep, &change, new_fabric);
+	if (ret) {
+		if (new_fabric)
+			drm_fabric_put(new_fabric);
+		return ret;
+	}
+
+	/*
+	 * mutation_lock rules out a race; the WARN_ON_ONCE rechecks below are
+	 * assertions only.
+	 */
+	scoped_guard(mutex, &drm_fabric_lock) {
+		if (change.valid & DRM_FABRIC_EP_CHANGE_FABRIC) {
+			if (new_fabric) {
+				if (WARN_ON_ONCE(xa_load(&drm_fabric_xa, new_fabric->id) !=
+						 new_fabric)) {
+					drm_fabric_put(new_fabric);
+					return -ENODEV;
+				}
+				if (WARN_ON_ONCE(drm_fabric_ep_id_in_use(new_fabric,
+									 ep->fabric_ep_id))) {
+					drm_fabric_put(new_fabric);
+					return -EEXIST;
+				}
+				ep->fabric = new_fabric;
+			} else {
+				/* Reached only for an attached endpoint. */
+				drm_fabric_put(ep->fabric);
+				ep->fabric = NULL;
+			}
+		}
+
+		if (change.valid & DRM_FABRIC_EP_CHANGE_ADMIN)
+			ep->admin_state = change.admin;
+
+		drm_fabric_base_seq_inc();
+	}
+
+	return 0;
+}
+
+/*
+ * No revalidation is needed: the port stays pinned and admin_state has no
+ * out-of-band writer.
+ */
+int drm_fabric_port_set_admin(struct drm_fabric_port *port,
+			      enum drm_fabric_admin_state admin)
+{
+	const struct drm_fabric_ops *ops = port->endpoint->ops;
+	int ret;
+
+	if (!ops || !ops->port_set)
+		return -EOPNOTSUPP;
+
+	lockdep_assert_held(&drm_fabric_mutation_lock);
+	lockdep_assert_not_held(&drm_fabric_lock);
+
+	/* No-op administrative request. */
+	scoped_guard(mutex, &drm_fabric_lock)
+		if (port->admin_state == admin)
+			return 0;
+
+	ret = ops->port_set(port, admin);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		port->admin_state = admin;
+		drm_fabric_emit_port_change(port, drm_fabric_base_seq_inc());
+	}
+
+	return 0;
+}
+
+/*
+ * No revalidation is needed: the port stays pinned and has_peer has no
+ * out-of-band writer.
+ */
+int drm_fabric_port_peer_new(struct drm_fabric_port *port,
+			     const struct drm_fabric_peer *peer)
+{
+	const struct drm_fabric_ops *ops = port->endpoint->ops;
+	int ret;
+
+	if (port->peer_mode != DRM_FABRIC_PEER_MODE_USERSPACE)
+		return -EOPNOTSUPP;
+
+	if (!ops || !ops->port_peer_new)
+		return -EOPNOTSUPP;
+
+	lockdep_assert_held(&drm_fabric_mutation_lock);
+	lockdep_assert_not_held(&drm_fabric_lock);
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		if (port->has_peer)
+			return -EEXIST;
+	}
+
+	ret = ops->port_peer_new(port, peer);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		port->peer = *peer;
+		port->has_peer = true;
+		drm_fabric_emit_port_peer_create(port, peer,
+						 drm_fabric_base_seq_inc());
+	}
+
+	return 0;
+}
+
+/* Same userspace-managed contract as drm_fabric_port_peer_new(). */
+int drm_fabric_port_peer_del(struct drm_fabric_port *port)
+{
+	const struct drm_fabric_ops *ops = port->endpoint->ops;
+	int ret;
+
+	if (port->peer_mode != DRM_FABRIC_PEER_MODE_USERSPACE)
+		return -EOPNOTSUPP;
+
+	if (!ops || !ops->port_peer_del)
+		return -EOPNOTSUPP;
+
+	lockdep_assert_held(&drm_fabric_mutation_lock);
+	lockdep_assert_not_held(&drm_fabric_lock);
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		if (!port->has_peer)
+			return -ENOENT;
+	}
+
+	ret = ops->port_peer_del(port);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		drm_fabric_emit_port_peer_delete(port, &port->peer,
+						 drm_fabric_base_seq_inc());
+		port->has_peer = false;
+		memset(&port->peer, 0, sizeof(port->peer));
+	}
+
+	return 0;
+}
+
 static int __init drm_fabric_init(void)
 {
 	return drm_fabric_netlink_register();
diff --git a/drivers/gpu/drm/fabric/drm_fabric_internal.h b/drivers/gpu/drm/fabric/drm_fabric_internal.h
index 7fc5bc3f33f9..dc95b9967b64 100644
--- a/drivers/gpu/drm/fabric/drm_fabric_internal.h
+++ b/drivers/gpu/drm/fabric/drm_fabric_internal.h
@@ -13,6 +13,7 @@
 #include <drm/drm_fabric.h>
 
 extern struct mutex drm_fabric_lock;
+extern struct mutex drm_fabric_mutation_lock;
 extern struct xarray drm_fabric_xa;    /* Fabric registry */
 extern struct xarray drm_fabric_ep_xa; /* Endpoint registry */
 
@@ -34,9 +35,21 @@ void drm_fabric_endpoint_put(struct drm_fabric_endpoint *ep);
 struct drm_fabric *drm_fabric_get(struct drm_fabric *fabric);
 void drm_fabric_put(struct drm_fabric *fabric);
 
+int drm_fabric_user_fabric_new(enum drm_fabric_type type, u64 instance_id,
+			       const char *name, u32 *fabric_id_out);
+int drm_fabric_user_fabric_del(u32 fabric_id);
+int drm_fabric_endpoint_set(struct drm_fabric_endpoint *ep,
+			    const struct drm_fabric_endpoint_change *change);
+int drm_fabric_port_set_admin(struct drm_fabric_port *port,
+			      enum drm_fabric_admin_state admin);
+int drm_fabric_port_peer_new(struct drm_fabric_port *port,
+			     const struct drm_fabric_peer *peer);
+int drm_fabric_port_peer_del(struct drm_fabric_port *port);
+
 /* Emits use the post-change generation. */
 void drm_fabric_emit_endpoint_create(struct drm_fabric_endpoint *ep, u32 generation);
 void drm_fabric_emit_endpoint_delete(struct drm_fabric_endpoint *ep, u32 generation);
+void drm_fabric_emit_endpoint_change(struct drm_fabric_endpoint *ep, u32 generation);
 
 void drm_fabric_emit_port_peer_create(struct drm_fabric_port *port,
 				      const struct drm_fabric_peer *peer,
diff --git a/drivers/gpu/drm/fabric/drm_fabric_test.c b/drivers/gpu/drm/fabric/drm_fabric_test.c
index 3457675645f6..863b7cf69068 100644
--- a/drivers/gpu/drm/fabric/drm_fabric_test.c
+++ b/drivers/gpu/drm/fabric/drm_fabric_test.c
@@ -112,13 +112,17 @@ static void drm_fabric_test_unregister_reports_removal(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_fabric_unregister(fab), 0);
 }
 
-static void drm_fabric_test_endpoint_requires_fabric(struct kunit *test)
+/*
+ * A NULL fabric registers an orphan endpoint, which reports fabric-id 0
+ * and can be unregistered.
+ */
+static void drm_fabric_test_endpoint_orphan_register(struct kunit *test)
 {
 	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
 	struct drm_fabric_port_desc pdesc = { .index = 0, .max_lane_count = 4 };
 	struct drm_fabric_endpoint_desc edesc = {
 		.fabric_ep_id = 1,
-		.name = "no-fabric",
+		.name = "orphan",
 		.parent = fabrictest_dev,
 		.ports = &pdesc,
 		.num_ports = 1,
@@ -126,9 +130,10 @@ static void drm_fabric_test_endpoint_requires_fabric(struct kunit *test)
 	struct drm_fabric_endpoint *ep;
 
 	ep = drm_fabric_endpoint_register(NULL, &edesc);
-	KUNIT_EXPECT_TRUE(test, IS_ERR(ep));
-	if (IS_ERR(ep))
-		KUNIT_EXPECT_EQ(test, PTR_ERR(ep), -EINVAL);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep));
+	KUNIT_EXPECT_EQ(test, drm_fabric_endpoint_fabric_id(ep), 0);
+
+	drm_fabric_endpoint_unregister(ep);
 }
 
 /* Registration must not walk a NULL port array. */
@@ -1280,7 +1285,7 @@ static struct kunit_case drm_fabric_test_cases[] = {
 	KUNIT_CASE(drm_fabric_test_unregister_reports_removal),
 	KUNIT_CASE(drm_fabric_test_instance_id_unique),
 	KUNIT_CASE(drm_fabric_test_endpoint_register),
-	KUNIT_CASE(drm_fabric_test_endpoint_requires_fabric),
+	KUNIT_CASE(drm_fabric_test_endpoint_orphan_register),
 	KUNIT_CASE(drm_fabric_test_endpoint_requires_port_array),
 	KUNIT_CASE(drm_fabric_test_endpoint_register_stale_fabric),
 	KUNIT_CASE(drm_fabric_test_unregister_rejects_non_member),
diff --git a/include/drm/drm_fabric.h b/include/drm/drm_fabric.h
index 136100b3da67..69e9099a1e57 100644
--- a/include/drm/drm_fabric.h
+++ b/include/drm/drm_fabric.h
@@ -4,8 +4,8 @@
  */
 
 /*
- * Common object model for GPU interconnect topology: fabric, endpoint, port
- * and peer relationships.
+ * DRM Fabric driver API: common object model for GPU interconnect topology
+ * (fabric, endpoint, port and peer relationships).
  */
 
 #ifndef __DRM_FABRIC_H__
@@ -18,8 +18,32 @@
 
 #include <uapi/drm/drm_fabric.h>
 
+enum drm_fabric_admin_state {
+	DRM_FABRIC_ADMIN_STATE_DOWN = 1,
+	DRM_FABRIC_ADMIN_STATE_UP,
+};
+
 struct device;
 
+/**
+ * enum drm_fabric_peer_mode - authority for a port's peer descriptor
+ * @DRM_FABRIC_PEER_MODE_PROVIDER: the provider reports the peer through
+ *	drm_fabric_port_set_peer() / drm_fabric_port_unset_peer(); the userspace
+ *	PORT_PEER_NEW / PORT_PEER_DEL path on the port returns -EOPNOTSUPP.
+ * @DRM_FABRIC_PEER_MODE_USERSPACE: userspace provisions the peer through
+ *	PORT_PEER_NEW / PORT_PEER_DEL (which invoke the provider programming
+ *	hooks); the provider must not call set_peer()/unset_peer() on the port,
+ *	and doing so returns -EOPNOTSUPP.
+ *
+ * One port, one peer descriptor, one source allowed to program it, fixed at
+ * registration. PROVIDER is the zero default, so a port that does not opt in
+ * is provider-managed.
+ */
+enum drm_fabric_peer_mode {
+	DRM_FABRIC_PEER_MODE_PROVIDER = 0,
+	DRM_FABRIC_PEER_MODE_USERSPACE,
+};
+
 /**
  * struct drm_fabric_port_desc - Port descriptor for drm_fabric_endpoint_register()
  */
@@ -36,6 +60,9 @@ struct drm_fabric_port_desc {
 	 * usable bandwidth.
 	 */
 	u32 max_lane_signaling_rate_mbps;
+
+	/** @peer_mode: who may program the port's peer descriptor */
+	enum drm_fabric_peer_mode peer_mode;
 };
 
 /**
@@ -79,6 +106,19 @@ struct drm_fabric_desc {
 	u64 instance_id;
 };
 
+/**
+ * enum drm_fabric_owner - lifecycle owner of a fabric object
+ * @DRM_FABRIC_OWNER_PROVIDER: created by a provider via drm_fabric_register();
+ *	only the provider may unregister it, never userspace FABRIC_DEL.
+ * @DRM_FABRIC_OWNER_USERSPACE: created by userspace via FABRIC_NEW; may be
+ *	deleted by userspace via FABRIC_DEL.
+ */
+enum drm_fabric_owner {
+	/* Zero value, so a kzalloc'd fabric is not deletable via FABRIC_DEL. */
+	DRM_FABRIC_OWNER_PROVIDER = 0,
+	DRM_FABRIC_OWNER_USERSPACE,
+};
+
 /**
  * struct drm_fabric - Fabric object
  */
@@ -91,6 +131,8 @@ struct drm_fabric {
 	u64 instance_id;
 	/** @name: human-readable fabric name */
 	char name[32];
+	/** @owner: lifecycle owner, gates userspace FABRIC_DEL */
+	enum drm_fabric_owner owner;
 
 	/** @refs: reference count */
 	refcount_t refs;
@@ -108,8 +150,13 @@ struct drm_fabric_endpoint {
 	char name[32];
 	/** @parent: backing device, provides dev_name and bus_name */
 	struct device *parent;
+	/**
+	 * @admin_state: administrative state, initially DOWN for an orphan and
+	 *	UP for a fabric member
+	 */
+	enum drm_fabric_admin_state admin_state;
 
-	/** @fabric: parent fabric */
+	/** @fabric: parent fabric, NULL while orphaned */
 	struct drm_fabric *fabric;
 
 	/** @ops: provider driver callbacks */
@@ -132,12 +179,14 @@ struct drm_fabric_endpoint {
  * drm_fabric_endpoint_fabric_id() - Wire fabric-id for an endpoint
  * @ep: endpoint to query
  *
- * Return: the parent fabric id.
+ * An orphaned endpoint (no fabric) reports fabric-id 0 on the wire.
+ *
+ * Return: the parent fabric id, or 0 if the endpoint is orphaned.
  */
 static inline u32
 drm_fabric_endpoint_fabric_id(const struct drm_fabric_endpoint *ep)
 {
-	return ep->fabric->id;
+	return ep->fabric ? ep->fabric->id : 0;
 }
 
 /**
@@ -171,11 +220,15 @@ struct drm_fabric_port {
 	u32 index;
 	/** @oper_state: operational (link) state */
 	enum drm_fabric_port_state oper_state;
+	/** @admin_state: administrative (requested) state */
+	enum drm_fabric_admin_state admin_state;
 	/** @max_lane_count: as in &struct drm_fabric_port_desc */
 	u32 max_lane_count;
 	/** @max_lane_signaling_rate_mbps: as in &struct drm_fabric_port_desc */
 	u32 max_lane_signaling_rate_mbps;
 
+	/** @peer_mode: authority for @peer, fixed at registration */
+	enum drm_fabric_peer_mode peer_mode;
 	/** @has_peer: whether @peer holds a valid descriptor */
 	bool has_peer;
 	/** @peer: neighbor description, valid only while @has_peer is set */
@@ -203,11 +256,34 @@ struct drm_fabric_port_stats {
 	u64 retrain_count;
 };
 
+/**
+ * struct drm_fabric_endpoint_change - Requested endpoint change for the endpoint_set() callback
+ */
+struct drm_fabric_endpoint_change {
+#define DRM_FABRIC_EP_CHANGE_FABRIC	BIT(0)
+#define DRM_FABRIC_EP_CHANGE_ADMIN	BIT(1)
+	/** @valid: bitmask of %DRM_FABRIC_EP_CHANGE_* selecting which fields are meaningful */
+	u32 valid;
+
+	/** @fabric_id: target fabric, 0 to detach (%DRM_FABRIC_EP_CHANGE_FABRIC) */
+	u32 fabric_id;
+	/** @admin: requested admin state (%DRM_FABRIC_EP_CHANGE_ADMIN) */
+	enum drm_fabric_admin_state admin;
+};
+
 /**
  * struct drm_fabric_ops - Provider driver callbacks
  *
- * A callback that is not supplied makes the matching netlink operation return
- * -EOPNOTSUPP.
+ * A callback that is not supplied makes the matching netlink operation
+ * return -EOPNOTSUPP.
+ *
+ * All callbacks are invoked without drm_fabric_lock held and may sleep;
+ * see each callback's own doc below for any further constraint.
+ *
+ * The mutation callbacks (endpoint_set, port_set, port_peer_new,
+ * port_peer_del) run with drm_fabric_mutation_lock held, so a provider
+ * must not call drm_fabric_endpoint_unregister() from inside one: that
+ * call takes the same lock and would self-deadlock.
  */
 struct drm_fabric_ops {
 	/**
@@ -221,6 +297,24 @@ struct drm_fabric_ops {
 	 */
 	int (*port_stats_get)(struct drm_fabric_port *port,
 			      struct drm_fabric_port_stats *stats);
+
+	/** @endpoint_set: attach or detach an endpoint and/or set its admin state */
+	int (*endpoint_set)(struct drm_fabric_endpoint *ep,
+			    const struct drm_fabric_endpoint_change *change,
+			    struct drm_fabric *fabric);
+	/** @port_set: set a port's admin state */
+	int (*port_set)(struct drm_fabric_port *port,
+			enum drm_fabric_admin_state admin);
+	/**
+	 * @port_peer_new: program a port's neighbor. Reached only for a port
+	 * whose peer_mode is %DRM_FABRIC_PEER_MODE_USERSPACE; a
+	 * provider-managed port reports its peer through
+	 * drm_fabric_port_set_peer() instead.
+	 */
+	int (*port_peer_new)(struct drm_fabric_port *port,
+			     const struct drm_fabric_peer *peer);
+	/** @port_peer_del: unprogram a userspace-managed port's neighbor */
+	int (*port_peer_del)(struct drm_fabric_port *port);
 };
 
 struct drm_fabric *drm_fabric_register(const struct drm_fabric_desc *desc);
-- 
2.43.0

