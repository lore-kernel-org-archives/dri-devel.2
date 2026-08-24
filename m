Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB12C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C5C110E69A;
	Mon, 24 Aug 2026 08:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DxptavqT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1F710E689
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:10:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1EAAA44EBC;
 Mon, 24 Aug 2026 08:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6DD1F000E9;
 Mon, 24 Aug 2026 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787559021;
 bh=otpJr0XTrglfEsX2uZzowPMZCS25VF8r2jsmiBGk4Gk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DxptavqTWD8DLZRVl7jtyZH/P7KmPx5H7qTsn5uXtfBbGHWWPTBf0tN+grK3sFxr5
 67mh/1AAfz+/QyggwiZO5WFX/iu03hgKG903tw+BNzZ1LndzcElGwO5fOdOYMtE7Wp
 r+OTSSDJQUp5JnxBjFH79rSrFDjYG0eFjjoKs1zNU5ymLbvnPx3NMZR1XO6UKwC/RQ
 0mMl4o46t7FBfLuiEK8AdV1CbCbpDZbjOrtoevHcHjVO7EhN8WpbSZM4ZubTS3QNBn
 eevM7+pYq2niNQLxtrkIAFZrWMxC7qJJq1KCI4EVLwURP8A1yBadpsQwu0D2D1DYTk
 rzO6TEVE/11Hw==
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
Subject: [RFC PATCH 10/12] drm/fabric: make the synthetic provider writable
Date: Mon, 24 Aug 2026 11:09:38 +0300
Message-ID: <605d72ca904f63a854869c9f88426b767e61554c.1787552412.git.ksinyuk@kernel.org>
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

Add provisioning callbacks to fabricsim for endpoint attachment,
administrative-state changes and peer updates.

Reserve each endpoint's last port for userspace-managed peer provisioning;
the remaining ports stay provider-managed, so one topology covers both
peer authorities.

Add per-callback fault injection for error propagation and failure
atomicity. The new debugfs controls remain test-only.

Signed-off-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Assisted-by: GitHub-Copilot:claude-opus-4.8
---
 Documentation/gpu/drm-fabric.rst        |   4 +
 drivers/gpu/drm/fabric/drm_fabric_sim.c | 138 +++++++++++++++++-------
 2 files changed, 106 insertions(+), 36 deletions(-)

diff --git a/Documentation/gpu/drm-fabric.rst b/Documentation/gpu/drm-fabric.rst
index 4ee7cb7ef6ac..1fd48027eee3 100644
--- a/Documentation/gpu/drm-fabric.rst
+++ b/Documentation/gpu/drm-fabric.rst
@@ -454,6 +454,10 @@ ports. The switch shape links every endpoint to an opaque switch peer
 (``peer-type = switch``) whose id does not resolve to an endpoint, exercising the
 directed half-edge model without a first-class switch object.
 
+It implements the provisioning callbacks, so it is also the reference provider
+for the mutation commands. It reserves each endpoint's last port for userspace
+peer management and wires topology on the ports below it.
+
 Its debugfs knobs stimulate synthetic counter activity, operational-state changes
 and runtime endpoint add/remove. These files are unstable test controls and are
 not part of the uAPI; the stable, reviewed interface is the YAML-described
diff --git a/drivers/gpu/drm/fabric/drm_fabric_sim.c b/drivers/gpu/drm/fabric/drm_fabric_sim.c
index 7d489c6894bf..e441943c02c3 100644
--- a/drivers/gpu/drm/fabric/drm_fabric_sim.c
+++ b/drivers/gpu/drm/fabric/drm_fabric_sim.c
@@ -90,6 +90,7 @@ static struct dentry *fabricsim_debugfs_root;
 
 /* Test-only fault injection (debugfs). Sticky until cleared. */
 static bool fabricsim_fail_register;
+static bool fabricsim_fail_mutation;
 static u32 fabricsim_fail_errno = ENOMEM;
 
 /*
@@ -142,8 +143,45 @@ static int fabricsim_port_stats_get(struct drm_fabric_port *port,
 	return 0;
 }
 
+/* The mutation hooks only fail on request; the core owns the model. */
+static int fabricsim_endpoint_set(struct drm_fabric_endpoint *ep,
+				  const struct drm_fabric_endpoint_change *change,
+				  struct drm_fabric *fabric)
+{
+	if (fabricsim_fail_mutation)
+		return fabricsim_injected_errno();
+	return 0;
+}
+
+static int fabricsim_port_set(struct drm_fabric_port *port,
+			      enum drm_fabric_admin_state admin)
+{
+	if (fabricsim_fail_mutation)
+		return fabricsim_injected_errno();
+	return 0;
+}
+
+static int fabricsim_port_peer_new(struct drm_fabric_port *port,
+				   const struct drm_fabric_peer *peer)
+{
+	if (fabricsim_fail_mutation)
+		return fabricsim_injected_errno();
+	return 0;
+}
+
+static int fabricsim_port_peer_del(struct drm_fabric_port *port)
+{
+	if (fabricsim_fail_mutation)
+		return fabricsim_injected_errno();
+	return 0;
+}
+
 static const struct drm_fabric_ops fabricsim_ops = {
 	.port_stats_get		= fabricsim_port_stats_get,
+	.endpoint_set		= fabricsim_endpoint_set,
+	.port_set		= fabricsim_port_set,
+	.port_peer_new		= fabricsim_port_peer_new,
+	.port_peer_del		= fabricsim_port_peer_del,
 };
 
 #define FABRICSIM_TICK_MS 100
@@ -343,12 +381,9 @@ static void fabricsim_link_linear(void)
 		struct drm_fabric_endpoint *ep_b = fabricsim_slots[i + 1]->ep;
 		struct drm_fabric_port *pa, *pb;
 
-		/*
-		 * Interior nodes consume two ports; stop rather than walk off
-		 * an endpoint's port array if it was sized too small.
-		 */
-		if (pa_idx >= fabricsim_slots[i]->num_ports ||
-		    pb_idx >= fabricsim_slots[i + 1]->num_ports)
+		/* -1 skips the reserved last port. */
+		if (pa_idx >= fabricsim_slots[i]->num_ports - 1 ||
+		    pb_idx >= fabricsim_slots[i + 1]->num_ports - 1)
 			break;
 
 		pa = fabricsim_slots[i]->ports[pa_idx].port;
@@ -379,7 +414,8 @@ static void fabricsim_link_mesh(void)
 			if (i == j)
 				continue;
 
-			if (port_idx >= fabricsim_slots[i]->num_ports)
+			/* -1 skips the reserved last port. */
+			if (port_idx >= fabricsim_slots[i]->num_ports - 1)
 				break;
 
 			/*
@@ -421,7 +457,8 @@ static void fabricsim_link_switch(void)
 		struct drm_fabric_port *leaf_port =
 			fabricsim_slots[i]->ports[0].port;
 
-		if (!leaf_port)
+		/* Port 0 is the uplink; skip an endpoint with only the reserved port. */
+		if (!leaf_port || fabricsim_slots[i]->num_ports < 2)
 			continue;
 
 		/* One directed half-edge from the leaf to an opaque switch. */
@@ -467,11 +504,12 @@ static void fabricsim_ep_debugfs_create(struct fabricsim_ep_priv *ep_priv)
 }
 
 /*
- * Create one endpoint at @slot with @nports ports, registered as a member of
- * the synthetic fabric.  Returns the new ep_priv or an ERR_PTR.  Caller holds
+ * Create an endpoint at @slot with @nports ports. @orphan registers it
+ * without a fabric for a later ENDPOINT_SET attach. Caller holds
  * fabricsim_lock.
  */
-static struct fabricsim_ep_priv *fabricsim_make_ep(int slot, int nports)
+static struct fabricsim_ep_priv *fabricsim_make_ep(int slot, int nports,
+						   bool orphan)
 {
 	struct drm_fabric_endpoint_desc edesc = {};
 	struct drm_fabric_port_desc pdescs[16];
@@ -509,6 +547,13 @@ static struct fabricsim_ep_priv *fabricsim_make_ep(int slot, int nports)
 		pdescs[j].index = j;
 		pdescs[j].max_lane_count = 4;
 		pdescs[j].max_lane_signaling_rate_mbps = 200000; /* 200 Gbps/lane */
+		/*
+		 * Reserve the last port for userspace peer tests; a single-port
+		 * endpoint therefore has no provider-managed port.
+		 */
+		pdescs[j].peer_mode = (j == nports - 1) ?
+			DRM_FABRIC_PEER_MODE_USERSPACE :
+			DRM_FABRIC_PEER_MODE_PROVIDER;
 	}
 
 	snprintf(ep_name, sizeof(ep_name), "sim-ep%d", slot);
@@ -540,7 +585,8 @@ static struct fabricsim_ep_priv *fabricsim_make_ep(int slot, int nports)
 		timer_setup(&pp->activity_timer, fabricsim_activity_tick, 0);
 	}
 
-	ep_priv->ep = drm_fabric_endpoint_register(fabricsim_fabric, &edesc);
+	ep_priv->ep = drm_fabric_endpoint_register(orphan ? NULL : fabricsim_fabric,
+						   &edesc);
 	if (IS_ERR(ep_priv->ep)) {
 		ret = PTR_ERR(ep_priv->ep);
 		goto err_ports;
@@ -597,7 +643,7 @@ static void fabricsim_destroy_ep(struct fabricsim_ep_priv *ep_priv)
 	kfree(ep_priv);
 }
 
-static int fabricsim_add_endpoint(int nports)
+static int fabricsim_add_endpoint(int nports, bool orphan)
 {
 	struct fabricsim_ep_priv *ep_priv;
 	int slot, ret;
@@ -616,7 +662,7 @@ static int fabricsim_add_endpoint(int nports)
 		return -ENOSPC;
 	}
 
-	ep_priv = fabricsim_make_ep(slot, nports);
+	ep_priv = fabricsim_make_ep(slot, nports, orphan);
 	if (IS_ERR(ep_priv)) {
 		ret = PTR_ERR(ep_priv);
 		mutex_unlock(&fabricsim_lock);
@@ -667,7 +713,7 @@ static int fabricsim_bulk_add(int n)
 		return -EINVAL;
 
 	while (added < n) {
-		ret = fabricsim_add_endpoint(1);
+		ret = fabricsim_add_endpoint(1, false);
 		if (ret < 0)
 			return added ? added : ret;
 		added++;
@@ -713,15 +759,28 @@ static int fabricsim_parse_int(const char __user *buf, size_t count, int dflt)
 	return val;
 }
 
-static ssize_t fabricsim_add_ep_write(struct file *file, const char __user *buf,
-				      size_t count, loff_t *ppos)
+static ssize_t fabricsim_add_ep_common(const char __user *buf, size_t count,
+				       bool orphan)
 {
 	int nports = fabricsim_parse_int(buf, count, ports_per_ep);
-	int ret = fabricsim_add_endpoint(nports);
+	int ret = fabricsim_add_endpoint(nports, orphan);
 
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t fabricsim_add_ep_write(struct file *file, const char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	return fabricsim_add_ep_common(buf, count, false);
+}
+
+static ssize_t fabricsim_add_orphan_write(struct file *file,
+					  const char __user *buf,
+					  size_t count, loff_t *ppos)
+{
+	return fabricsim_add_ep_common(buf, count, true);
+}
+
 static ssize_t fabricsim_del_ep_write(struct file *file, const char __user *buf,
 				      size_t count, loff_t *ppos)
 {
@@ -736,6 +795,11 @@ static const struct file_operations fabricsim_add_ep_fops = {
 	.write	= fabricsim_add_ep_write,
 };
 
+static const struct file_operations fabricsim_add_orphan_fops = {
+	.owner	= THIS_MODULE,
+	.write	= fabricsim_add_orphan_write,
+};
+
 static const struct file_operations fabricsim_del_ep_fops = {
 	.owner	= THIS_MODULE,
 	.write	= fabricsim_del_ep_write,
@@ -810,6 +874,8 @@ static const struct file_operations fabricsim_fail_errno_fops = {
  */
 static int __init fabricsim_setup_params(void)
 {
+	int wired;
+
 	/*
 	 * Reject an unrecognised topology rather than falling back to mesh, so
 	 * a typo cannot fake a shape.
@@ -830,22 +896,17 @@ static int __init fabricsim_setup_params(void)
 	if (ports_per_ep > 16)
 		ports_per_ep = 16;
 
-	/*
-	 * A mesh gives every endpoint (N-1) peers, so the busiest endpoint needs
-	 * at least (N-1) ports. The switch shape only needs one port per leaf
-	 * (a single half-edge to the opaque switch), so it is not bumped here.
-	 */
-	if (strcmp(topology, "mesh") == 0 && ports_per_ep < num_endpoints - 1)
-		ports_per_ep = num_endpoints - 1;
+	/* Peers wired per endpoint: mesh N-1, linear interior 2, switch 1. */
+	if (strcmp(topology, "mesh") == 0)
+		wired = num_endpoints - 1;
+	else if (strcmp(topology, "linear") == 0 && num_endpoints > 2)
+		wired = 2;
+	else
+		wired = 1;
 
-	/*
-	 * A linear chain gives every interior node two neighbours, so it needs
-	 * at least two ports; bump a too-small request rather than index past
-	 * the endpoint's port array.
-	 */
-	if (strcmp(topology, "linear") == 0 && num_endpoints > 2 &&
-	    ports_per_ep < 2)
-		ports_per_ep = 2;
+	/* make_ep() reserves the last port, so @wired alone drops an edge. */
+	if (ports_per_ep < wired + 1)
+		ports_per_ep = wired + 1;
 
 	fabricsim_init_eps = num_endpoints;
 
@@ -877,7 +938,7 @@ static int __init fabricsim_init(void)
 	mutex_lock(&fabricsim_lock);
 	for (i = 0; i < fabricsim_init_eps; i++) {
 		struct fabricsim_ep_priv *ep_priv =
-			fabricsim_make_ep(i, ports_per_ep);
+			fabricsim_make_ep(i, ports_per_ep, false);
 
 		if (IS_ERR(ep_priv)) {
 			ret = PTR_ERR(ep_priv);
@@ -910,6 +971,8 @@ static int __init fabricsim_init(void)
 	if (fabricsim_debugfs_root) {
 		debugfs_create_file("add_endpoint", 0200, fabricsim_debugfs_root,
 				    NULL, &fabricsim_add_ep_fops);
+		debugfs_create_file("add_orphan", 0200, fabricsim_debugfs_root,
+				    NULL, &fabricsim_add_orphan_fops);
 		debugfs_create_file("del_endpoint", 0200, fabricsim_debugfs_root,
 				    NULL, &fabricsim_del_ep_fops);
 
@@ -921,9 +984,12 @@ static int __init fabricsim_init(void)
 		debugfs_create_bool("fail_register", 0644,
 				    fabricsim_debugfs_root,
 				    &fabricsim_fail_register);
-		debugfs_create_file("fail_errno", 0644,
+		debugfs_create_bool("fail_mutation", 0644,
 				    fabricsim_debugfs_root,
-				    NULL, &fabricsim_fail_errno_fops);
+				    &fabricsim_fail_mutation);
+		debugfs_create_file("fail_errno", 0644,
+				    fabricsim_debugfs_root, NULL,
+				    &fabricsim_fail_errno_fops);
 	}
 
 	pr_info("fabricsim: registered %s topology with %d endpoints, %d ports/ep\n",
-- 
2.43.0

