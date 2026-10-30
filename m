Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496FD606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKvgmAUt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55EF410E0F8;
	Fri, 30 Oct 2026 20:30:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB7D510E0F8
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:30:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F51D4088C;
 Fri, 30 Oct 2026 20:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280571F000C1;
 Fri, 30 Oct 2026 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793392237;
 bh=u3iFkyS8003joF89HNTPECrGYvOMBInfKyP0kyoNdTU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=DKvgmAUtmVwFyWVBoEhihhXi0QICPzeIs4vieJ4tx7/nHFw3feYMvxFzToXDF9Gt6
 7AyBdjivnFUIWamW04UXfmNOcvr7pbIZodoeVnuCKGxbi7DG1zTfl9nDqcQl2CzTUy
 K+dS6YOYSn0gXC13xW7aqufLJXSCuKXEWQISOpsUkRpOwASnDXkgYTiX7w6w9rMPDP
 FGXnYFjAfrlBbXNzvNktZ92f2PQBwNBZL6AAJghnr1wOA804soSsn4NF6SzmpZKf86
 krgP6hmaPyghob+Retqqt0LhZX0vMZeTHUWa2Vlfji4S6ipESWCuQAe2gCiOLdDPIN
 kI9ZvSw153LYA==
Message-ID: <sashiko-outbox-191474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
To: "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261029203000.1763447-3-zachary.mckevitt@oss.qualcomm.com>
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
 <20261029203000.1763447-3-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 20:30:36 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/drm_ras: unsynchronized node lookup in telemetry netlink handl=
ers
- [Medium] drm/drm_ras: broken status handling and non-standard UAPI in tel=
emetry ops
- [Medium] drm/drm_ras: missing field validation in telemetry doit callbacks
- [Low] drm/drm_ras: mismatched kernel-doc @field tag in drm_ras_telemetry_=
field
--

commit dc8b379237033d84f80f290cec4514d0c3cc4442
Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

drm/drm_ras: Extend DRM RAS interface to include telemetry nodes

This commit adds a telemetry node type, netlink attribute set, and doit/dum=
pit
callbacks to the DRM RAS interface to support reading and writing device
telemetry fields.

> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/net=
link/specs/drm_ras.yaml
> index a88fdab7a1c74..a02aaed8772fc 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml

[ ... ]

> @@ -100,6 +100,34 @@ attribute-sets:
>          name: error-value
>          type: u32
>          doc: Current value of the error counter.
> +  -
> +    name: telemetry-attrs
> +    attributes:
> +      -
> +        name: node-id
> +        type: u32
> +        doc: >-
> +             Unique identifier for the node.
> +             Assigned dynamically by the DRM RAS core upon registration.
> +      -
> +        name: field
> +        type: u32
> +        doc:  Telemetry field to be read/written, e.g., SoC temp.
> +      -
> +        name: field-name
> +        type: string
> +        doc:  Name of the telemetry field defined by the device's uapi.
> +      -
> +        name: value
> +        type: sint
> +        doc: Value of telemetry field that was read/written.
> +      -
> +        name: status
> +        type: s32
> +        doc: >-
> +             Status of the telemetry operation.
> +             Populated by the device in response to the performed
> +             telemetry operation. Errors may be hardware specific.
> =20
>  operations:
>    list:
> @@ -198,6 +226,52 @@ operations:
>              - node-id
>              - error-id
>              - error-threshold
> +    -
> +      name: telemetry-get
> +      doc: Perform a read of the specified telemetry field.
> +      attribute-set: telemetry-attrs
> +      do:
> +        pre: drm-ras-nl-pre-telemetry
> +        request:
> +          attributes:
> +            - node-id
> +            - field
> +        reply:
> +          attributes:
> +            - value
> +            - status
> +      dump:
> +        request:
> +          attributes:
> +            - node-id
> +        reply:
> +          attributes: &telemetry-field-attrs
> +            - field
> +            - field-name
> +    -
> +      name: telemetry-set
> +      doc: >-
> +           Perform a write of the specified telemetry field.
> +           Telemetry writes are device specific, and may be used to set
> +           device limits or other capacities, for example.
> +      attribute-set: telemetry-attrs
> +      flags: [admin-perm]
> +      do:
> +        pre: drm-ras-nl-pre-telemetry
> +        request:
> +          attributes:
> +            - node-id
> +            - field
> +            - value
> +        reply:
> +          attributes:
> +            - status
> +      dump:
> +        request:
> +          attributes:
> +            - node-id
> +        reply:
> +          attributes: *telemetry-field-attrs

[Severity: Medium]
Is this Netlink uAPI structure and status attribute behavior intentional?

In drm_ras_nl_telemetry_get_doit() and drm_ras_nl_telemetry_set_doit(), if
node->telemetry_get() or node->telemetry_set() returns a non-zero value, the
handler frees msg and returns ret directly without serializing
DRM_RAS_A_TELEMETRY_ATTRS_STATUS:

	ret =3D node->telemetry_get(node, &field, &value, &status);
	if (ret) {
		nlmsg_free(msg);
		return ret;
	}

In the consumer patch "accel/qaic: Add callbacks for DRM RAS netlink
telemetry", qaic_telemetry_get() and qaic_telemetry_set() assign *status fr=
om
telemetry_request() (which maps firmware errors to negative errno values) a=
nd
return *status directly. Consequently, whenever an error occurs, the reply =
is
aborted and DRM_RAS_A_TELEMETRY_ATTRS_STATUS is never sent, whereas wheneve=
r a
reply is sent, status is always 0. Conversely, if a driver returns 0 while
setting a non-zero *status, drm_ras_nl_telemetry_get_doit() unconditionally
serializes the uninitialized or zero DRM_RAS_A_TELEMETRY_ATTRS_VALUE and
bypasses standard Netlink error reporting.

In addition, telemetry-set attaches a dump operation to a SET command to li=
st
writable field descriptors, and telemetry-get returns different object
representations in do ([value, status]) versus dump ([field, field-name]),
unlike get-error-counter where do and dump return the same attributes.

Finally, telemetry-attrs exposes opaque device-specific field IDs and unitl=
ess
values for thermal, power, and voltage sensors and limits (such as SoC/board
temperatures and TDP in the qaic consumer). Should those metrics be exposed
through hwmon rather than a device-specific key-value pass-through in DRM R=
AS?

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 4f4777060a4e8..5b9c00f28834b 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c

[ ... ]

> @@ -617,6 +644,264 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_b=
uff *skb, struct genl_info *i
>  	return set_node_error_threshold(node_id, error_id, threshold);
>  }
> =20
> +/**
> + * drm_ras_nl_pre_telemetry - Enforce permission checks
> + * @ops: Generic netlink operations
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Enforces a telemetry node's pre_doit conditions (if they exist).
> + *
> + * Returns 0 if no pre_doit is specified, otherwise returns the pre_doit.
> + */
> +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk=
_buff *skb,
> +			     struct genl_info *info)
> +{
> +	struct drm_ras_node *node;
> +	u32 node_id;
> +
> +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS=
_NODE_ID))
> +		return -EINVAL;
> +
> +	node_id =3D nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> +	node =3D xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (node->telemetry_pre)
> +		return node->telemetry_pre(node);
> +
> +	return 0;
> +}

[Severity: High]
What prevents node from being unregistered and freed while
drm_ras_nl_pre_telemetry(), drm_ras_nl_telemetry_get_doit(),
drm_ras_nl_telemetry_get_dumpit(), drm_ras_nl_telemetry_set_doit(), or
drm_ras_nl_telemetry_set_dumpit() is using it?

The drm_ras Generic Netlink family sets .parallel_ops =3D true, and xa_load=
()
only holds rcu_read_lock() internally during the lookup, returning an unpin=
ned
struct drm_ras_node pointer without a lock or reference count.

In drm_ras_nl_telemetry_get_doit() and drm_ras_nl_telemetry_set_doit(), the
handler holds node across a sleeping genlmsg_new(..., GFP_KERNEL) allocation
and a sleeping driver callback (such as qaic_telemetry_get() ->
telemetry_request()), while drm_ras_node_unregister() only calls
xa_erase(&drm_ras_xa, node->id) and returns immediately before the driver
frees node and the underlying device structure.

Furthermore, because drm_ras_nl_pre_telemetry() and the doit handlers perfo=
rm
separate unlocked xa_load(&drm_ras_xa, node_id) lookups instead of pinning =
the
validated node in pre_doit, can node_id be unregistered and reallocated to a
different node between pre_doit and doit?

[ ... ]

> +int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info =
*info)
> +{
> +	struct drm_ras_node *node;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	u32 node_id, field;
> +	s32 status =3D 0;
> +	s64 value =3D 0;
> +	int ret =3D 0;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_FIELD))
> +		return -EINVAL;
> +
> +	field =3D nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
> +	node_id =3D nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> +
> +	node =3D xa_load(&drm_ras_xa, node_id);
> +	if (!node || !node->telemetry_get)
> +		return -ENOENT;
> +
> +	msg =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr =3D genlmsg_iput(msg, info);
> +	if (!hdr) {
> +		nlmsg_free(msg);
> +		return -EMSGSIZE;
> +	}
> +
> +	ret =3D node->telemetry_get(node, &field, &value, &status);

[ ... ]

> +int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info =
*info)
> +{
> +	struct drm_ras_node *node;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	u32 node_id, field;
> +	s32 status =3D 0;
> +	s64 value =3D 0;
> +	int ret =3D 0;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_VALUE) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_FIELD))
> +		return -EINVAL;
> +
> +	value =3D nla_get_sint(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_VALUE]);
> +	field =3D nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
> +	node_id =3D nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> +
> +	node =3D xa_load(&drm_ras_xa, node_id);
> +	if (!node || !node->telemetry_set)
> +		return -ENOENT;

[ ... ]

> @@ -631,14 +916,21 @@ int drm_ras_node_register(struct drm_ras_node *node)
>  	if (!node->device_name || !node->node_name)
>  		return -EINVAL;
> =20
> -	/* Currently, only Error Counter Endpoints are supported */
> -	if (node->type !=3D DRM_RAS_NODE_TYPE_ERROR_COUNTER)
> -		return -EINVAL;
> -
> -	/* Mandatory entries for Error Counter Node */
> -	if (node->type =3D=3D DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
> -	    (!node->error_counter_range.last || !node->query_error_counter))
> +	/* Currently, only Error Counter and Telemetry endpoints are supported =
*/
> +	switch (node->type) {
> +	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
> +		/* Mandatory entries for Error Counter Node */
> +		if (!node->error_counter_range.last || !node->query_error_counter)
> +			return -EINVAL;
> +		break;
> +	case DRM_RAS_NODE_TYPE_TELEMETRY:
> +		/* Must provide telemetry_get, telemetry_set is optional */
> +		if (!node->telemetry_get || !node->telemetry_fields_gettable)
> +			return -EINVAL;
> +		break;

[Severity: Medium]
Should drm_ras_nl_telemetry_get_doit() and drm_ras_nl_telemetry_set_doit()
validate the user-supplied field ID against node->telemetry_fields_gettable
and node->telemetry_fields_settable before invoking the driver callbacks?

Unlike the error counter handlers, which check error_id against
node->error_counter_range, drm_ras_nl_telemetry_get_doit() and
drm_ras_nl_telemetry_set_doit() pass the untrusted u32 field directly to
node->telemetry_get() and node->telemetry_set(). In the qaic consumer patch
("accel/qaic: Add callbacks for DRM RAS netlink telemetry"),
qaic_telemetry_get() and qaic_telemetry_set() pass *field directly to
telemetry_request(struct qaic_device *qdev, u8 cmd, ...), which truncates t=
he
u32 value to u8 so out-of-range values like 0x101 alias to valid commands.

Also, since the documentation comment states that settable telemetry fields
are required when providing telemetry_set(), should drm_ras_node_register()
reject a node that sets node->telemetry_set without
node->telemetry_fields_settable, and should include/drm/drm_ras.h document
that telemetry_fields_gettable and telemetry_fields_settable must be
terminated by a NULL .name sentinel entry for telemetry_fields_dumpit()?

> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 1765a3130b09b..fb10238999ddb 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -10,6 +10,16 @@
> =20
>  #include <uapi/drm/drm_ras.h>
> =20
> +/**
> + * struct drm_ras_telemetry_field - A descriptor of a telemetry field.
> + */
> +struct drm_ras_telemetry_field {
> +	/** @name: The enum or macro name defined by the device uAPI. */
> +	const char *name;
> +	/** @field: The numerical value of the field. */
> +	u32 value;
> +};

[Severity: Low]
In struct drm_ras_telemetry_field, should the kernel-doc tag @field be @val=
ue
to match the struct member name?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029203000.1763=
447-1-zachary.mckevitt@oss.qualcomm.com?part=3D2
