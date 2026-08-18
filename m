Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC30C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FA810EABF;
	Tue, 18 Aug 2026 11:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PL1+430g";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24EDB10E35F;
 Tue, 18 Aug 2026 11:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787052927; x=1818588927;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VLISCEWuh6CbDTAP+BcIv8n7W+yN26FnLxWE8r2YT7I=;
 b=PL1+430gD/lirwEuWCPKYydIRTNbNXp/Kbw2czKqGvZdZXdK/RsRdR7n
 b1m4RQeFJN2xkmxEaGb/n8OOn11v0GmHT7Sz2QCA+UjZufp+qT8Li7CZR
 VGj21P55Bb18CiMEWoBbdT2RfG5byE9EPn/14Yew2XLG1VvRLxHlyT+li
 qAQs8ohO3qZlnDd5YvKDl7P+1ltL5bsbHyjl+DLlcDLyx2iCzYpOy/EU6
 sGWDNV63o7w5BvEDavroako4IOmjPNfizolOXFVG+g7Jqi5SANR3vViq0
 qi/YlahBI3K8bhsmMvKJ134EpmpC2t6OIxK+UL+j8l3Shxwxc+6PuzSof w==;
X-CSE-ConnectionGUID: T3FxESdYQp+ZCmOwXfns0g==
X-CSE-MsgGUID: 4rv4hXnIQTyqZX3j2L2TPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98907071"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="98907071"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 04:35:26 -0700
X-CSE-ConnectionGUID: Pef+Al6jQa65ntEI57neFA==
X-CSE-MsgGUID: FhJFIV3vTTSEZK6bszLj3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="267179131"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 04:35:22 -0700
Date: Tue, 18 Aug 2026 13:35:19 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, dev@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, riana.tauro@intel.com,
 michal.wajdeczko@intel.com, matthew.d.roper@intel.com,
 mallesh.koujalagi@intel.com
Subject: Re: [PATCH v5 2/5] drm/ras: Introduce error threshold
Message-ID: <aoRDd7mgRi8KqT2H@black.igk.intel.com>
References: <20260722034228.662746-1-raag.jadav@intel.com>
 <20260722034228.662746-3-raag.jadav@intel.com>
 <amD-SVMRhA0SsW1t@intel.com> <amymMwoSOxpHhEvX@black.igk.intel.com>
 <anMICHct8ipD-u12@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anMICHct8ipD-u12@intel.com>
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

On Wed, Aug 05, 2026 at 05:53:12AM -0400, Rodrigo Vivi wrote:
> On Fri, Jul 31, 2026 at 03:42:11PM +0200, Raag Jadav wrote:
> > Hi net maintainers,
> > 
> > On Wed, Jul 22, 2026 at 01:30:49PM -0400, Rodrigo Vivi wrote:
> > > On Wed, Jul 22, 2026 at 09:11:12AM +0530, Raag Jadav wrote:
> > > > Add get-error-threshold and set-error-threshold command support which
> > > > allows querying/setting error threshold of the counter. Threshold in RAS
> > > > context means the number of errors the hardware is expected to accumulate
> > > > before it raises them to software. This is to have a fine grained control
> > > > over error notifications that are raised by the hardware.
> > > > 
> > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > > Reviewed-by: Riana Tauro <riana.tauro@intel.com>
> > > > ---
> > > > v2: Document threshold definition (Riana)
> > > >     Return -EOPNOTSUPP on threshold callbacks absence (Riana)
> > > >     Cancel and free genlmsg on failure (Riana)
> > > >     Document threshold bounds checking responsibility (Riana)
> > > > v3: Move documentation from yaml to rst file (Riana)
> > > >     s/value/threshold (Riana)
> > > >     Use goto for error handling (Riana)
> > > > v4: Clarify 0 threshold expectations (Riana)
> > > >     Drop redundant wrapping (Riana)
> > > > v5: Drop redundant documentation (Riana)
> > > >     Aesthetic adjustment (Riana)
> > > > ---
> > > >  Documentation/gpu/drm-ras.rst            |  18 +++
> > > >  Documentation/netlink/specs/drm_ras.yaml |  32 +++++
> > > 
> > > Jakub and other net maintainers, ack on getting this through drm trees?
> > 
> > Can you please provide guidance?
> 
> Even better, could you please ack the MAINTAINERS change [1] so we can stop
> bothering you with these asks?
> 
> [1] https://lore.kernel.org/all/20260805094949.536651-2-rodrigo.vivi@intel.com/T/#u

So anything I can do here?

Raag

> > > >  drivers/gpu/drm/drm_ras.c                | 158 +++++++++++++++++++++++
> > > >  drivers/gpu/drm/drm_ras_nl.c             |  27 ++++
> > > >  drivers/gpu/drm/drm_ras_nl.h             |   4 +
> > > >  include/drm/drm_ras.h                    |  29 +++++
> > > >  include/uapi/drm/drm_ras.h               |   3 +
> > > >  7 files changed, 271 insertions(+)
> > > > 
> > > > diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> > > > index 83c21853b74b..2718f8aee09d 100644
> > > > --- a/Documentation/gpu/drm-ras.rst
> > > > +++ b/Documentation/gpu/drm-ras.rst
> > > > @@ -56,6 +56,10 @@ User space tools can:
> > > >    ``node-id`` and ``error-id`` as parameters.
> > > >  * Clear specific error counters with the ``clear-error-counter`` command, using both
> > > >    ``node-id`` and ``error-id`` as parameters.
> > > > +* Query specific error counter threshold with the ``get-error-threshold`` command, using both
> > > > +  ``node-id`` and ``error-id`` as parameters.
> > > > +* Set specific error counter threshold with the ``set-error-threshold`` command, using
> > > > +  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
> > > >  
> > > >  YAML-based Interface
> > > >  --------------------
> > > > @@ -111,3 +115,17 @@ Example: Clear an error counter for a given node
> > > >  
> > > >      sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
> > > >      None
> > > > +
> > > > +Example: Query error threshold of a given counter
> > > > +
> > > > +.. code-block:: bash
> > > > +
> > > > +    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
> > > > +    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
> > > > +
> > > > +Example: Set error threshold of a given counter
> > > > +
> > > > +.. code-block:: bash
> > > > +
> > > > +    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id":0, "error-id":1, "error-threshold":8}'
> > > > +    None
> > > > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > > > index e113056f8c01..9cf7f9cde242 100644
> > > > --- a/Documentation/netlink/specs/drm_ras.yaml
> > > > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > > > @@ -69,6 +69,10 @@ attribute-sets:
> > > >          name: error-value
> > > >          type: u32
> > > >          doc: Current value of the requested error counter.
> > > > +      -
> > > > +        name: error-threshold
> > > > +        type: u32
> > > > +        doc: Error threshold of the counter.
> > > >  
> > > >  operations:
> > > >    list:
> > > > @@ -124,3 +128,31 @@ operations:
> > > >        do:
> > > >          request:
> > > >            attributes: *id-attrs
> > > > +    -
> > > > +      name: get-error-threshold
> > > > +      doc: >-
> > > > +           Retrieve error threshold of a given counter.
> > > > +           The response includes the id, the name, and current threshold
> > > > +           of the counter.
> > > > +      attribute-set: error-counter-attrs
> > > > +      flags: [admin-perm]
> > > > +      do:
> > > > +        request:
> > > > +          attributes: *id-attrs
> > > > +        reply:
> > > > +          attributes:
> > > > +            - error-id
> > > > +            - error-name
> > > > +            - error-threshold
> > > > +    -
> > > > +      name: set-error-threshold
> > > > +      doc: >-
> > > > +           Set error threshold of a given counter.
> > > > +      attribute-set: error-counter-attrs
> > > > +      flags: [admin-perm]
> > > > +      do:
> > > > +        request:
> > > > +          attributes:
> > > > +            - node-id
> > > > +            - error-id
> > > > +            - error-threshold
> > > > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > > > index 467a169026fc..9a7b3d2acd25 100644
> > > > --- a/drivers/gpu/drm/drm_ras.c
> > > > +++ b/drivers/gpu/drm/drm_ras.c
> > > > @@ -41,6 +41,13 @@
> > > >   *    Userspace must provide Node ID, Error ID.
> > > >   *    Clears specific error counter of a node if supported.
> > > >   *
> > > > + * 4. GET_ERROR_THRESHOLD: Query error threshold of a given counter.
> > > > + *    Userspace must provide Node ID and Error ID.
> > > > + *    Returns the error threshold of a specific counter.
> > > > + *
> > > > + * 5. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
> > > > + *    Userspace must provide Node ID, Error ID and threshold to be set.
> > > > + *
> > > >   * Node registration:
> > > >   *
> > > >   * - drm_ras_node_register(): Registers a new node and assigns
> > > > @@ -61,6 +68,13 @@
> > > >   *     + The error counters in the driver doesn't need to be contiguous, but the
> > > >   *       driver must return -ENOENT to the query_error_counter as an indication
> > > >   *       that the ID should be skipped and not listed in the netlink API.
> > > > + *     + The driver can optionally implement query_error_threshold() and
> > > > + *       set_error_threshold() callbacks to facilitate getting/setting error
> > > > + *       threshold of the counter. Threshold in RAS context means the number of
> > > > + *       errors the hardware is expected to accumulate before it raises them to
> > > > + *       software. This is to have a fine grained control over error notifications
> > > > + *       that are raised by the hardware.
> > > > + *     + The driver is responsible for error threshold bounds checking.
> > > >   *
> > > >   * Netlink handlers:
> > > >   *
> > > > @@ -72,6 +86,10 @@
> > > >   *   operation, fetching a counter value from a specific node.
> > > >   * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
> > > >   *   operation, clearing a counter value from a specific node.
> > > > + * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
> > > > + *   operation, fetching the error threshold of a specific counter.
> > > > + * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
> > > > + *   operation, setting the error threshold of a specific counter.
> > > >   */
> > > >  
> > > >  static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> > > > @@ -168,6 +186,40 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
> > > >  	return node->query_error_counter(node, error_id, name, value);
> > > >  }
> > > >  
> > > > +static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name, u32 *threshold)
> > > > +{
> > > > +	struct drm_ras_node *node;
> > > > +
> > > > +	node = xa_load(&drm_ras_xa, node_id);
> > > > +	if (!node)
> > > > +		return -ENOENT;
> > > > +
> > > > +	if (!node->query_error_threshold)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
> > > > +		return -EINVAL;
> > > > +
> > > > +	return node->query_error_threshold(node, error_id, name, threshold);
> > > > +}
> > > > +
> > > > +static int set_node_error_threshold(u32 node_id, u32 error_id, u32 threshold)
> > > > +{
> > > > +	struct drm_ras_node *node;
> > > > +
> > > > +	node = xa_load(&drm_ras_xa, node_id);
> > > > +	if (!node)
> > > > +		return -ENOENT;
> > > > +
> > > > +	if (!node->set_error_threshold)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
> > > > +		return -EINVAL;
> > > > +
> > > > +	return node->set_error_threshold(node, error_id, threshold);
> > > > +}
> > > > +
> > > >  static int msg_reply_value(struct sk_buff *msg, u32 error_id,
> > > >  			   const char *error_name, u32 value)
> > > >  {
> > > > @@ -186,6 +238,22 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
> > > >  			   value);
> > > >  }
> > > >  
> > > > +static int msg_reply_threshold(struct sk_buff *msg, u32 error_id, const char *error_name,
> > > > +			       u32 threshold)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID, error_id);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME, error_name);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	return nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD, threshold);
> > > > +}
> > > > +
> > > >  static int doit_reply_value(struct genl_info *info, u32 node_id,
> > > >  			    u32 error_id)
> > > >  {
> > > > @@ -225,6 +293,43 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_id)
> > > > +{
> > > > +	const char *error_name;
> > > > +	struct sk_buff *msg;
> > > > +	struct nlattr *hdr;
> > > > +	u32 threshold;
> > > > +	int ret;
> > > > +
> > > > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> > > > +	if (!msg)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	hdr = genlmsg_iput(msg, info);
> > > > +	if (!hdr) {
> > > > +		ret = -EMSGSIZE;
> > > > +		goto free_msg;
> > > > +	}
> > > > +
> > > > +	ret = get_node_error_threshold(node_id, error_id, &error_name, &threshold);
> > > > +	if (ret)
> > > > +		goto cancel_msg;
> > > > +
> > > > +	ret = msg_reply_threshold(msg, error_id, error_name, threshold);
> > > > +	if (ret)
> > > > +		goto cancel_msg;
> > > > +
> > > > +	genlmsg_end(msg, hdr);
> > > > +
> > > > +	return genlmsg_reply(msg, info);
> > > > +
> > > > +cancel_msg:
> > > > +	genlmsg_cancel(msg, hdr);
> > > > +free_msg:
> > > > +	nlmsg_free(msg);
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  /**
> > > >   * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
> > > >   * @skb: Netlink message buffer
> > > > @@ -358,6 +463,59 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> > > >  	return node->clear_error_counter(node, error_id);
> > > >  }
> > > >  
> > > > +/**
> > > > + * drm_ras_nl_get_error_threshold_doit() - Query error threshold of a counter
> > > > + * @skb: Netlink message buffer
> > > > + * @info: Generic Netlink info containing attributes of the request
> > > > + *
> > > > + * Extracts the Node ID and Error ID from the netlink attributes and retrieves
> > > > + * the error threshold of the corresponding counter. Sends the result back to
> > > > + * the requesting user via the standard Genl reply.
> > > > + *
> > > > + * Return: 0 on success, or negative errno on failure.
> > > > + */
> > > > +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
> > > > +{
> > > > +	u32 node_id, error_id;
> > > > +
> > > > +	if (!info->attrs ||
> > > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> > > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
> > > > +		return -EINVAL;
> > > > +
> > > > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > > > +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > > > +
> > > > +	return doit_reply_threshold(info, node_id, error_id);
> > > > +}
> > > > +
> > > > +/**
> > > > + * drm_ras_nl_set_error_threshold_doit() - Set error threshold of a counter
> > > > + * @skb: Netlink message buffer
> > > > + * @info: Generic Netlink info containing attributes of the request
> > > > + *
> > > > + * Extracts the Node ID, Error ID and threshold from the netlink attributes and
> > > > + * sets the error threshold of the corresponding counter.
> > > > + *
> > > > + * Return: 0 on success, or negative errno on failure.
> > > > + */
> > > > +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
> > > > +{
> > > > +	u32 node_id, error_id, threshold;
> > > > +
> > > > +	if (!info->attrs ||
> > > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> > > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID) ||
> > > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD))
> > > > +		return -EINVAL;
> > > > +
> > > > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > > > +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > > > +	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
> > > > +
> > > > +	return set_node_error_threshold(node_id, error_id, threshold);
> > > > +}
> > > > +
> > > >  /**
> > > >   * drm_ras_node_register() - Register a new RAS node
> > > >   * @node: Node structure to register
> > > > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> > > > index dea1c1b2494e..02e8e5054d05 100644
> > > > --- a/drivers/gpu/drm/drm_ras_nl.c
> > > > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > > > @@ -28,6 +28,19 @@ static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_E
> > > >  	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> > > >  };
> > > >  
> > > > +/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */
> > > > +static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
> > > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> > > > +};
> > > > +
> > > > +/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */
> > > > +static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD + 1] = {
> > > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> > > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
> > > > +};
> > > > +
> > > >  /* Ops table for drm_ras */
> > > >  static const struct genl_split_ops drm_ras_nl_ops[] = {
> > > >  	{
> > > > @@ -56,6 +69,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> > > >  		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> > > >  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > >  	},
> > > > +	{
> > > > +		.cmd		= DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> > > > +		.doit		= drm_ras_nl_get_error_threshold_doit,
> > > > +		.policy		= drm_ras_get_error_threshold_nl_policy,
> > > > +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> > > > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > > +	},
> > > > +	{
> > > > +		.cmd		= DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> > > > +		.doit		= drm_ras_nl_set_error_threshold_doit,
> > > > +		.policy		= drm_ras_set_error_threshold_nl_policy,
> > > > +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> > > > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > > +	},
> > > >  };
> > > >  
> > > >  struct genl_family drm_ras_nl_family __ro_after_init = {
> > > > diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> > > > index a398643572a5..57b1e647d833 100644
> > > > --- a/drivers/gpu/drm/drm_ras_nl.h
> > > > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > > > @@ -20,6 +20,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
> > > >  					struct netlink_callback *cb);
> > > >  int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> > > >  					struct genl_info *info);
> > > > +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> > > > +					struct genl_info *info);
> > > > +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> > > > +					struct genl_info *info);
> > > >  
> > > >  extern struct genl_family drm_ras_nl_family;
> > > >  
> > > > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> > > > index 0beede3ddc4e..b1fa87975cc5 100644
> > > > --- a/include/drm/drm_ras.h
> > > > +++ b/include/drm/drm_ras.h
> > > > @@ -71,6 +71,35 @@ struct drm_ras_node {
> > > >  	 */
> > > >  	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
> > > >  
> > > > +	/**
> > > > +	 * @query_error_threshold:
> > > > +	 *
> > > > +	 * This callback is used by drm-ras to query error threshold of a
> > > > +	 * specific counter.
> > > > +	 *
> > > > +	 * Driver should expect query_error_threshold() to be called with
> > > > +	 * error_id from `error_counter_range.first` to
> > > > +	 * `error_counter_range.last`.
> > > > +	 *
> > > > +	 * Returns: 0 on success, negative error code on failure.
> > > > +	 */
> > > > +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id, const char **name,
> > > > +				     u32 *threshold);
> > > > +
> > > > +	/**
> > > > +	 * @set_error_threshold:
> > > > +	 *
> > > > +	 * This callback is used by drm-ras to set error threshold of a specific
> > > > +	 * counter.
> > > > +	 *
> > > > +	 * Driver should expect set_error_threshold() to be called with error_id
> > > > +	 * from `error_counter_range.first` to `error_counter_range.last`.
> > > > +	 * Driver is responsible for error threshold bounds checking.
> > > > +	 *
> > > > +	 * Returns: 0 on success, negative error code on failure.
> > > > +	 */
> > > > +	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
> > > > +
> > > >  	/** @priv: Driver private data */
> > > >  	void *priv;
> > > >  };
> > > > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> > > > index 218a3ee86805..27c68956495f 100644
> > > > --- a/include/uapi/drm/drm_ras.h
> > > > +++ b/include/uapi/drm/drm_ras.h
> > > > @@ -33,6 +33,7 @@ enum {
> > > >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> > > >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
> > > >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE,
> > > > +	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> > > >  
> > > >  	__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX,
> > > >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
> > > > @@ -42,6 +43,8 @@ enum {
> > > >  	DRM_RAS_CMD_LIST_NODES = 1,
> > > >  	DRM_RAS_CMD_GET_ERROR_COUNTER,
> > > >  	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> > > > +	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> > > > +	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> > > >  
> > > >  	__DRM_RAS_CMD_MAX,
> > > >  	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
> > > > -- 
> > > > 2.43.0
> > > > 
