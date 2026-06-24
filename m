Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B57CDE000
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D5210EE6D;
	Wed, 24 Jun 2026 10:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NDnlJ10P";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 978D810EE5E
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:15:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 80F94400EF;
 Wed, 24 Jun 2026 10:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459DC1F000E9;
 Wed, 24 Jun 2026 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782296131;
 bh=lchu6Biz945/ORhBgPpbU/WYWW7Pd0UhF0USF4XrMak=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NDnlJ10PHWdtucdgxsuV3UOaOJX5dloP9FIQbTbUCqexZcqYepgVKUNcgGjsOVc16
 rEcEI2v9C4bfr6tZzxdi8TnQy6FHQMVjcQT79tnu2NJpaAGS0/xYYrnKzSMPdYrDUC
 C8j1MzUa1AX96b03RR1TeNwSD+s6NiAeanAdoUj/yPRB7n0MMvtm2+oZg/BwKIi+Ph
 mvmKWOyT7fApFJJUn8Mb3+JoN13oNGaMBHv6bpQgGUaO2lUb36Kyh5/3WMGpMW10Bl
 F5tHGdibXhpVMb2mkPeWLxm0qgkHiUGG9/n0/e9g/lxb6kl2M3QVG0cipbbjW/2Noc
 Ve0UvTD6X1WKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] drm/ras: Introduce error threshold
To: "Raag Jadav" <raag.jadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623101043.255897-3-raag.jadav@intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
 <20260623101043.255897-3-raag.jadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 10:15:30 +0000
Message-Id: <20260624101531.459DC1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `set-error-threshold` operation modifies state but only repl=
ies with a generic ACK instead of returning the finalized object state, vio=
lating Netlink uAPI guidelines.

Pre-existing issues:
- [Critical] Lockless lookup and dereference of `drm_ras_node` via `xa_load=
()` leads to a Use-After-Free if the node is concurrently unregistered.
--

commit 90a4ea5c0139594375be477d76556dae20fa84e0
Author: Raag Jadav <raag.jadav@intel.com>
Subject: drm/ras: Introduce error threshold

Add get-error-threshold and set-error-threshold command support which
allows querying/setting error threshold of the counter. Threshold in RAS
context means the number of errors the hardware is expected to accumulate
before it raises them to software.

> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/net=
link/specs/drm_ras.yaml
> index e113056f8c016..9cf7f9cde2425 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -124,3 +128,31 @@ operations:
[ ... ]
> +    -
> +      name: set-error-threshold
> +      doc: >-
> +           Set error threshold of a given counter.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - node-id
> +            - error-id
> +            - error-threshold

[Severity: Medium]
Does this operation need a reply block to return the finalized threshold?

According to the Generic Netlink subsystem uAPI guidelines, operations that
modify state must reply with a full message carrying identifying information
about the object.

If the driver applies bounds checking and clamps or rounds the threshold,
user space won't know the actual applied value since the command only
returns a generic ACK. Is it possible to include a reply block here?

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 467a169026fc1..d60c40ac5427a 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -168,6 +189,40 @@ static int get_node_error_counter(u32 node_id, u32 e=
rror_id,
>  	return node->query_error_counter(node, error_id, name, value);
>  }
> =20
> +static int get_node_error_threshold(u32 node_id, u32 error_id, const cha=
r **name, u32 *threshold)
> +{
> +	struct drm_ras_node *node;
> +
> +	node =3D xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->query_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first || error_id > node->erro=
r_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->query_error_threshold(node, error_id, name, threshold);

[Severity: Critical]
This is a pre-existing issue, but is it safe to dereference the node pointer
here without RCU protection or a reference count?

The xa_load() function drops the RCU read lock before returning. If a
concurrent thread unregisters the node and frees it, could this result in a
use-after-free when calling node->query_error_threshold()?

> +}
> +
> +static int set_node_error_threshold(u32 node_id, u32 error_id, u32 thres=
hold)
> +{
> +	struct drm_ras_node *node;
> +
> +	node =3D xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->set_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first || error_id > node->erro=
r_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->set_error_threshold(node, error_id, threshold);

[Severity: Critical]
This is a pre-existing issue, but similarly to get_node_error_threshold(),
the node pointer is retrieved locklessly via xa_load() and immediately
dereferenced.

Could a concurrent unregistration of the device free the node while it is
being accessed here?

> +}
[ ... ]
> @@ -358,6 +466,59 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_bu=
ff *skb,
>  	return node->clear_error_counter(node, error_id);
>  }
> =20
[ ... ]
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl=
_info *info)
> +{
> +	u32 node_id, error_id, threshold;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRES=
HOLD))
> +		return -EINVAL;
> +
> +	node_id =3D nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_=
ID]);
> +	error_id =3D nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERRO=
R_ID]);
> +	threshold =3D nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERR=
OR_THRESHOLD]);
> +
> +	return set_node_error_threshold(node_id, error_id, threshold);

[Severity: Medium]
This operation completes by returning the success code from
set_node_error_threshold(), which results in a generic ACK being sent to
user space.

Should this prepare and send a netlink response message containing the
actual applied threshold instead of relying on the ACK?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623101043.2558=
97-1-raag.jadav@intel.com?part=3D2
