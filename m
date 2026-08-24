Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0A5C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FF910E687;
	Mon, 24 Aug 2026 08:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m5EW7SK4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A423810E687
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:10:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1942760A71;
 Mon, 24 Aug 2026 08:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231C61F00A3D;
 Mon, 24 Aug 2026 08:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787559017;
 bh=bfiVBG187PzczPhWTtOtD4xKFF9wn8rnmWf+nhZVMss=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m5EW7SK4LBG/zhutrSOdPuXvfTgp8ErFIsRNRycJftmwy9S8aiZqNhoARJlEoVE6O
 uJ9e8W7r0Z2juHmuTRHk7r9Nysq2zwMXvjtTkxQrSBbdEGbhwuH6dmp/aSIeImTwz1
 LFZU/Lc1dXtDlcosDCgjfU0BoyVztiJan7OmfffbX/Y/1EyhyxUE/P4mmM/Gg/P/sT
 0R/LhSIbzGJY52FzUILzwpSZ08f2X/6avoh/9avWFPiBs8WVlbEB0yCCT5KucO7V4V
 2bgHoRu81uZ1dMMj18xhAirN0t/bnRdYciLS4WCDHoBdPWBFeHvh5FLgXi453RdNvB
 uDRcOXKVMvSdA==
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
Subject: [RFC PATCH 09/12] drm/fabric: implement mutation netlink operations
Date: Mon, 24 Aug 2026 11:09:37 +0300
Message-ID: <5b008798364477a2740ebb18544bddfa16f7d512.1787552412.git.ksinyuk@kernel.org>
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

Connect the six provisioning operations to the core mutation helpers and
add the generated operation and policy source that dispatches to them.

Resolve and pin mutation targets in pre_doit, run each transaction under
drm_fabric_mutation_lock, call the provider without drm_fabric_lock held,
and release references in post_doit. All six require GENL_ADMIN_PERM and
are confined to init_net.

A failed provider callback returns its error with core state unchanged.
Successful mutations emit notifications after commit, carrying the
resulting topology generation.

Co-developed-by: Ilia Levi <ilia.levi@intel.com>
Signed-off-by: Ilia Levi <ilia.levi@intel.com>
Signed-off-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Assisted-by: GitHub-Copilot:claude-opus-4.8
---
 drivers/gpu/drm/fabric/drm_fabric.c         |   5 +-
 drivers/gpu/drm/fabric/drm_fabric_netlink.c | 275 ++++++++++++++++++++
 drivers/gpu/drm/fabric/drm_fabric_nl.c      | 106 ++++++++
 3 files changed, 384 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/fabric/drm_fabric.c b/drivers/gpu/drm/fabric/drm_fabric.c
index 1aae5ff68798..50c34b4fd722 100644
--- a/drivers/gpu/drm/fabric/drm_fabric.c
+++ b/drivers/gpu/drm/fabric/drm_fabric.c
@@ -793,7 +793,8 @@ int drm_fabric_user_fabric_del(u32 fabric_id)
 		/* Symmetric with FABRIC_NEW: only an empty fabric may be removed. */
 		if (drm_fabric_has_members(fabric))
 			return -EBUSY;
-		drm_fabric_base_seq_inc();
+		/* Notify while the userspace-owned fabric is still addressable by id. */
+		drm_fabric_emit_fabric_delete(fabric, drm_fabric_base_seq_inc());
 		xa_erase(&drm_fabric_xa, fabric->id);
 	}
 
@@ -906,7 +907,7 @@ int drm_fabric_endpoint_set(struct drm_fabric_endpoint *ep,
 		if (change.valid & DRM_FABRIC_EP_CHANGE_ADMIN)
 			ep->admin_state = change.admin;
 
-		drm_fabric_base_seq_inc();
+		drm_fabric_emit_endpoint_change(ep, drm_fabric_base_seq_inc());
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/fabric/drm_fabric_netlink.c b/drivers/gpu/drm/fabric/drm_fabric_netlink.c
index fef2d4c8f5bb..1a0f293723e9 100644
--- a/drivers/gpu/drm/fabric/drm_fabric_netlink.c
+++ b/drivers/gpu/drm/fabric/drm_fabric_netlink.c
@@ -80,6 +80,7 @@ static int drm_fabric_fill_endpoint(struct sk_buff *skb,
 	    nla_put_u64_64bit(skb, DRM_FABRIC_A_ENDPOINT_ATTRS_FABRIC_EP_ID,
 			      ep->fabric_ep_id, DRM_FABRIC_A_ENDPOINT_ATTRS_PAD) ||
 	    nla_put_string(skb, DRM_FABRIC_A_ENDPOINT_ATTRS_NAME, ep->name) ||
+	    nla_put_u32(skb, DRM_FABRIC_A_ENDPOINT_ATTRS_ADMIN_STATE, ep->admin_state) ||
 	    nla_put_string(skb, DRM_FABRIC_A_ENDPOINT_ATTRS_DEV_NAME,
 			   dev_name(ep->parent)) ||
 	    nla_put_string(skb, DRM_FABRIC_A_ENDPOINT_ATTRS_BUS_NAME,
@@ -132,6 +133,8 @@ static int drm_fabric_fill_port(struct sk_buff *skb,
 	    nla_put_u32(skb, DRM_FABRIC_A_PORT_ATTRS_ENDPOINT_ID, port->endpoint->id) ||
 	    nla_put_u32(skb, DRM_FABRIC_A_PORT_ATTRS_OPER_STATE,
 			port->oper_state) ||
+	    nla_put_u32(skb, DRM_FABRIC_A_PORT_ATTRS_ADMIN_STATE,
+			port->admin_state) ||
 	    nla_put_u32(skb, DRM_FABRIC_A_PORT_ATTRS_MAX_LANE_COUNT,
 			port->max_lane_count) ||
 	    nla_put_u32(skb, DRM_FABRIC_A_PORT_ATTRS_MAX_LANE_SIGNALING_RATE_MBPS,
@@ -846,6 +849,272 @@ int drm_fabric_nl_port_stats_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+/* Fabric create/delete have no target to resolve; only serialize mutation. */
+int drm_fabric_nl_pre_doit(const struct genl_split_ops *ops,
+			   struct sk_buff *skb, struct genl_info *info)
+{
+	int ret = drm_fabric_nl_host_only(genl_info_net(info));
+
+	if (ret)
+		return ret;
+
+	mutex_lock(&drm_fabric_mutation_lock);
+	return 0;
+}
+
+void drm_fabric_nl_post_doit(const struct genl_split_ops *ops,
+			     struct sk_buff *skb, struct genl_info *info)
+{
+	mutex_unlock(&drm_fabric_mutation_lock);
+}
+
+/*
+ * Pin the target in user_ptr[0]. Drop the mutation lock on failure because
+ * post_doit does not run when pre_doit fails.
+ */
+int drm_fabric_nl_endpoint_pre_doit(const struct genl_split_ops *ops,
+				    struct sk_buff *skb, struct genl_info *info)
+{
+	struct drm_fabric_endpoint *ep;
+	int ret = drm_fabric_nl_host_only(genl_info_net(info));
+
+	if (ret)
+		return ret;
+
+	mutex_lock(&drm_fabric_mutation_lock);
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		ep = drm_fabric_resolve_endpoint(info);
+		if (!IS_ERR(ep))
+			drm_fabric_endpoint_get(ep);
+	}
+
+	if (IS_ERR(ep)) {
+		mutex_unlock(&drm_fabric_mutation_lock);
+		return PTR_ERR(ep);
+	}
+
+	info->user_ptr[0] = ep;
+	return 0;
+}
+
+void drm_fabric_nl_endpoint_post_doit(const struct genl_split_ops *ops,
+				      struct sk_buff *skb,
+				      struct genl_info *info)
+{
+	drm_fabric_endpoint_put(info->user_ptr[0]);
+	mutex_unlock(&drm_fabric_mutation_lock);
+}
+
+int drm_fabric_nl_port_pre_doit(const struct genl_split_ops *ops,
+				struct sk_buff *skb, struct genl_info *info)
+{
+	struct drm_fabric_port *port;
+	u32 ep_id, port_idx;
+	int ret;
+
+	ret = drm_fabric_nl_host_only(genl_info_net(info));
+	if (ret)
+		return ret;
+
+	ret = drm_fabric_port_key(info, &ep_id, &port_idx);
+	if (ret)
+		return ret;
+
+	mutex_lock(&drm_fabric_mutation_lock);
+
+	port = drm_fabric_port_find_get(ep_id, port_idx);
+	if (IS_ERR(port)) {
+		mutex_unlock(&drm_fabric_mutation_lock);
+		return PTR_ERR(port);
+	}
+
+	info->user_ptr[0] = port;
+	return 0;
+}
+
+void drm_fabric_nl_port_post_doit(const struct genl_split_ops *ops,
+				  struct sk_buff *skb, struct genl_info *info)
+{
+	drm_fabric_port_put(info->user_ptr[0]);
+	mutex_unlock(&drm_fabric_mutation_lock);
+}
+
+/* A nested policy cannot mark members required; check type and instance-id here. */
+static int drm_fabric_parse_new_params(struct genl_info *info,
+					enum drm_fabric_type *type,
+					const char **name, u64 *instance_id)
+{
+	struct nlattr *pa[DRM_FABRIC_A_FABRIC_NEW_PARAMS_MAX + 1];
+	struct nlattr *nest;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, DRM_FABRIC_A_FABRIC_NEW_PARAMS))
+		return -EINVAL;
+
+	nest = info->attrs[DRM_FABRIC_A_FABRIC_NEW_PARAMS];
+	ret = nla_parse_nested(pa, DRM_FABRIC_A_FABRIC_NEW_PARAMS_MAX, nest,
+			       drm_fabric_fabric_new_params_nl_policy,
+			       info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, nest, pa,
+			      DRM_FABRIC_A_FABRIC_NEW_PARAMS_TYPE) ||
+	    NL_REQ_ATTR_CHECK(info->extack, nest, pa,
+			      DRM_FABRIC_A_FABRIC_NEW_PARAMS_INSTANCE_ID))
+		return -EINVAL;
+
+	*type = nla_get_u32(pa[DRM_FABRIC_A_FABRIC_NEW_PARAMS_TYPE]);
+	*instance_id = nla_get_u64(pa[DRM_FABRIC_A_FABRIC_NEW_PARAMS_INSTANCE_ID]);
+	*name = pa[DRM_FABRIC_A_FABRIC_NEW_PARAMS_NAME] ?
+		nla_data(pa[DRM_FABRIC_A_FABRIC_NEW_PARAMS_NAME]) : NULL;
+	return 0;
+}
+
+int drm_fabric_nl_fabric_new_doit(struct sk_buff *skb,
+				  struct genl_info *info)
+{
+	enum drm_fabric_type type;
+	const char *name = NULL;
+	u64 instance_id;
+	struct sk_buff *msg;
+	struct nlattr *id_attr;
+	u32 fabric_id;
+	void *hdr;
+	int ret;
+
+	ret = drm_fabric_parse_new_params(info, &type, &name, &instance_id);
+	if (ret)
+		return ret;
+
+	/*
+	 * Reserve the id attribute before publishing: with the space already
+	 * committed the store cannot fail, so there is no create-then-withdraw
+	 * window.
+	 */
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, info->snd_portid, info->snd_seq,
+			  &drm_fabric_nl_family, 0,
+			  DRM_FABRIC_CMD_FABRIC_NEW);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	id_attr = nla_reserve(msg, DRM_FABRIC_A_FABRIC_ID, sizeof(u32));
+	if (!id_attr) {
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	ret = drm_fabric_user_fabric_new(type, instance_id, name, &fabric_id);
+	if (ret) {
+		nlmsg_free(msg);
+		return ret;
+	}
+
+	/* nla_put_u32() copies a host-order u32 verbatim; so does this store. */
+	*(u32 *)nla_data(id_attr) = fabric_id;
+
+	genlmsg_end(msg, hdr);
+	return genlmsg_reply(msg, info);
+}
+
+int drm_fabric_nl_fabric_del_doit(struct sk_buff *skb,
+				  struct genl_info *info)
+{
+	u32 fabric_id;
+
+	if (GENL_REQ_ATTR_CHECK(info, DRM_FABRIC_A_FABRIC_ID))
+		return -EINVAL;
+
+	fabric_id = nla_get_u32(info->attrs[DRM_FABRIC_A_FABRIC_ID]);
+	return drm_fabric_user_fabric_del(fabric_id);
+}
+
+int drm_fabric_nl_endpoint_set_doit(struct sk_buff *skb,
+				    struct genl_info *info)
+{
+	struct drm_fabric_endpoint *ep = info->user_ptr[0];
+	struct drm_fabric_endpoint_change change = {};
+
+	if (info->attrs[DRM_FABRIC_A_FABRIC_ID]) {
+		change.valid |= DRM_FABRIC_EP_CHANGE_FABRIC;
+		change.fabric_id =
+			nla_get_u32(info->attrs[DRM_FABRIC_A_FABRIC_ID]);
+	}
+
+	if (info->attrs[DRM_FABRIC_A_ADMIN_STATE]) {
+		change.valid |= DRM_FABRIC_EP_CHANGE_ADMIN;
+		change.admin =
+			nla_get_u32(info->attrs[DRM_FABRIC_A_ADMIN_STATE]);
+	}
+
+	if (!change.valid)
+		return -EINVAL;
+
+	return drm_fabric_endpoint_set(ep, &change);
+}
+
+int drm_fabric_nl_port_set_doit(struct sk_buff *skb,
+				struct genl_info *info)
+{
+	struct drm_fabric_port *port = info->user_ptr[0];
+	enum drm_fabric_admin_state admin;
+
+	if (GENL_REQ_ATTR_CHECK(info, DRM_FABRIC_A_ADMIN_STATE))
+		return -EINVAL;
+
+	admin = nla_get_u32(info->attrs[DRM_FABRIC_A_ADMIN_STATE]);
+
+	return drm_fabric_port_set_admin(port, admin);
+}
+
+int drm_fabric_nl_port_peer_new_doit(struct sk_buff *skb,
+				     struct genl_info *info)
+{
+	struct drm_fabric_port *port = info->user_ptr[0];
+	struct nlattr *pa[DRM_FABRIC_A_PEER_ATTRS_MAX + 1];
+	struct drm_fabric_peer peer = {};
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, DRM_FABRIC_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(pa, DRM_FABRIC_A_PEER_ATTRS_MAX,
+			       info->attrs[DRM_FABRIC_A_PEER],
+			       drm_fabric_peer_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	/*
+	 * A nested policy cannot require members; require the complete peer
+	 * descriptor here.
+	 */
+	if (!pa[DRM_FABRIC_A_PEER_ATTRS_PEER_ID] ||
+	    !pa[DRM_FABRIC_A_PEER_ATTRS_TYPE] ||
+	    !pa[DRM_FABRIC_A_PEER_ATTRS_PORT_INDEX])
+		return -EINVAL;
+
+	peer.peer_id = nla_get_u64(pa[DRM_FABRIC_A_PEER_ATTRS_PEER_ID]);
+	peer.peer_type = nla_get_u32(pa[DRM_FABRIC_A_PEER_ATTRS_TYPE]);
+	peer.port_index = nla_get_u32(pa[DRM_FABRIC_A_PEER_ATTRS_PORT_INDEX]);
+
+	return drm_fabric_port_peer_new(port, &peer);
+}
+
+int drm_fabric_nl_port_peer_del_doit(struct sk_buff *skb,
+				     struct genl_info *info)
+{
+	struct drm_fabric_port *port = info->user_ptr[0];
+
+	return drm_fabric_port_peer_del(port);
+}
+
 void drm_fabric_emit_port_change(struct drm_fabric_port *port, u32 generation)
 {
 	struct sk_buff *msg;
@@ -982,6 +1251,12 @@ void drm_fabric_emit_endpoint_delete(struct drm_fabric_endpoint *ep, u32 generat
 				       generation);
 }
 
+void drm_fabric_emit_endpoint_change(struct drm_fabric_endpoint *ep, u32 generation)
+{
+	drm_fabric_endpoint_event_send(DRM_FABRIC_CMD_ENDPOINT_CHANGE_NTF, ep,
+				       generation);
+}
+
 static void drm_fabric_fabric_event_send(enum drm_fabric_cmd cmd,
 					 struct drm_fabric *fabric,
 					 u32 generation)
diff --git a/drivers/gpu/drm/fabric/drm_fabric_nl.c b/drivers/gpu/drm/fabric/drm_fabric_nl.c
index 032548405146..20b277f27ae9 100644
--- a/drivers/gpu/drm/fabric/drm_fabric_nl.c
+++ b/drivers/gpu/drm/fabric/drm_fabric_nl.c
@@ -11,6 +11,19 @@
 
 #include <uapi/drm/drm_fabric.h>
 
+/* Common nested types */
+const struct nla_policy drm_fabric_fabric_new_params_nl_policy[DRM_FABRIC_A_FABRIC_NEW_PARAMS_INSTANCE_ID + 1] = {
+	[DRM_FABRIC_A_FABRIC_NEW_PARAMS_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 1),
+	[DRM_FABRIC_A_FABRIC_NEW_PARAMS_NAME] = { .type = NLA_NUL_STRING, .len = 31, },
+	[DRM_FABRIC_A_FABRIC_NEW_PARAMS_INSTANCE_ID] = { .type = NLA_U64, },
+};
+
+const struct nla_policy drm_fabric_peer_nl_policy[DRM_FABRIC_A_PEER_ATTRS_PORT_INDEX + 1] = {
+	[DRM_FABRIC_A_PEER_ATTRS_PEER_ID] = { .type = NLA_U64, },
+	[DRM_FABRIC_A_PEER_ATTRS_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
+	[DRM_FABRIC_A_PEER_ATTRS_PORT_INDEX] = { .type = NLA_U32, },
+};
+
 /* DRM_FABRIC_CMD_FABRIC_GET - do */
 static const struct nla_policy drm_fabric_fabric_get_nl_policy[DRM_FABRIC_A_FABRIC_ID + 1] = {
 	[DRM_FABRIC_A_FABRIC_ID] = { .type = NLA_U32, },
@@ -50,6 +63,45 @@ static const struct nla_policy drm_fabric_port_stats_get_dump_nl_policy[DRM_FABR
 	[DRM_FABRIC_A_ENDPOINT_ID] = { .type = NLA_U32, },
 };
 
+/* DRM_FABRIC_CMD_FABRIC_NEW - do */
+static const struct nla_policy drm_fabric_fabric_new_nl_policy[DRM_FABRIC_A_FABRIC_NEW_PARAMS + 1] = {
+	[DRM_FABRIC_A_FABRIC_NEW_PARAMS] = NLA_POLICY_NESTED(drm_fabric_fabric_new_params_nl_policy),
+};
+
+/* DRM_FABRIC_CMD_FABRIC_DEL - do */
+static const struct nla_policy drm_fabric_fabric_del_nl_policy[DRM_FABRIC_A_FABRIC_ID + 1] = {
+	[DRM_FABRIC_A_FABRIC_ID] = { .type = NLA_U32, },
+};
+
+/* DRM_FABRIC_CMD_ENDPOINT_SET - do */
+static const struct nla_policy drm_fabric_endpoint_set_nl_policy[DRM_FABRIC_A_ADMIN_STATE + 1] = {
+	[DRM_FABRIC_A_ENDPOINT_ID] = { .type = NLA_U32, },
+	[DRM_FABRIC_A_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DRM_FABRIC_A_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DRM_FABRIC_A_FABRIC_ID] = { .type = NLA_U32, },
+	[DRM_FABRIC_A_ADMIN_STATE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
+};
+
+/* DRM_FABRIC_CMD_PORT_SET - do */
+static const struct nla_policy drm_fabric_port_set_nl_policy[DRM_FABRIC_A_ADMIN_STATE + 1] = {
+	[DRM_FABRIC_A_ENDPOINT_ID] = { .type = NLA_U32, },
+	[DRM_FABRIC_A_PORT_INDEX] = { .type = NLA_U32, },
+	[DRM_FABRIC_A_ADMIN_STATE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
+};
+
+/* DRM_FABRIC_CMD_PORT_PEER_NEW - do */
+static const struct nla_policy drm_fabric_port_peer_new_nl_policy[DRM_FABRIC_A_PEER + 1] = {
+	[DRM_FABRIC_A_ENDPOINT_ID] = { .type = NLA_U32, },
+	[DRM_FABRIC_A_PORT_INDEX] = { .type = NLA_U32, },
+	[DRM_FABRIC_A_PEER] = NLA_POLICY_NESTED(drm_fabric_peer_nl_policy),
+};
+
+/* DRM_FABRIC_CMD_PORT_PEER_DEL - do */
+static const struct nla_policy drm_fabric_port_peer_del_nl_policy[DRM_FABRIC_A_PORT_INDEX + 1] = {
+	[DRM_FABRIC_A_ENDPOINT_ID] = { .type = NLA_U32, },
+	[DRM_FABRIC_A_PORT_INDEX] = { .type = NLA_U32, },
+};
+
 /* Ops table for drm_fabric */
 static const struct genl_split_ops drm_fabric_nl_ops[] = {
 	{
@@ -106,6 +158,60 @@ static const struct genl_split_ops drm_fabric_nl_ops[] = {
 		.maxattr	= DRM_FABRIC_A_ENDPOINT_ID,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= DRM_FABRIC_CMD_FABRIC_NEW,
+		.pre_doit	= drm_fabric_nl_pre_doit,
+		.doit		= drm_fabric_nl_fabric_new_doit,
+		.post_doit	= drm_fabric_nl_post_doit,
+		.policy		= drm_fabric_fabric_new_nl_policy,
+		.maxattr	= DRM_FABRIC_A_FABRIC_NEW_PARAMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_FABRIC_CMD_FABRIC_DEL,
+		.pre_doit	= drm_fabric_nl_pre_doit,
+		.doit		= drm_fabric_nl_fabric_del_doit,
+		.post_doit	= drm_fabric_nl_post_doit,
+		.policy		= drm_fabric_fabric_del_nl_policy,
+		.maxattr	= DRM_FABRIC_A_FABRIC_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_FABRIC_CMD_ENDPOINT_SET,
+		.pre_doit	= drm_fabric_nl_endpoint_pre_doit,
+		.doit		= drm_fabric_nl_endpoint_set_doit,
+		.post_doit	= drm_fabric_nl_endpoint_post_doit,
+		.policy		= drm_fabric_endpoint_set_nl_policy,
+		.maxattr	= DRM_FABRIC_A_ADMIN_STATE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_FABRIC_CMD_PORT_SET,
+		.pre_doit	= drm_fabric_nl_port_pre_doit,
+		.doit		= drm_fabric_nl_port_set_doit,
+		.post_doit	= drm_fabric_nl_port_post_doit,
+		.policy		= drm_fabric_port_set_nl_policy,
+		.maxattr	= DRM_FABRIC_A_ADMIN_STATE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_FABRIC_CMD_PORT_PEER_NEW,
+		.pre_doit	= drm_fabric_nl_port_pre_doit,
+		.doit		= drm_fabric_nl_port_peer_new_doit,
+		.post_doit	= drm_fabric_nl_port_post_doit,
+		.policy		= drm_fabric_port_peer_new_nl_policy,
+		.maxattr	= DRM_FABRIC_A_PEER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_FABRIC_CMD_PORT_PEER_DEL,
+		.pre_doit	= drm_fabric_nl_port_pre_doit,
+		.doit		= drm_fabric_nl_port_peer_del_doit,
+		.post_doit	= drm_fabric_nl_port_post_doit,
+		.policy		= drm_fabric_port_peer_del_nl_policy,
+		.maxattr	= DRM_FABRIC_A_PORT_INDEX,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group drm_fabric_nl_mcgrps[] = {
-- 
2.43.0

