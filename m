Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01D606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iyls/BaX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB2110E092;
	Sat,  7 Nov 2026 18:19:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6156210E092
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 18:18:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 295B041437;
 Sat,  7 Nov 2026 18:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F8F1F0089F;
 Sat,  7 Nov 2026 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794075537;
 bh=NYLydfvL4nqDpMX7zNTX7blajBQKGAQeOIRoxzqK1Vs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Iyls/BaXzeANRoj7k3ZNgvePEi1LDp3yesn3eVji8Y4T2r+gMy5czof4zTM6/R2S1
 /BVReys0wr+uAmqWZNVNjuSprN4qaftrSnrHXE9DdwC2WJaMw3B1GzeQ4P6/u5NDzp
 9pNMI9nVYDa0ougwdXEcpOIRMfYXKnNpYAjil8xda76haiTLRwwfTj6EK6whE9cb//
 BzqbYBJQAfRgH2dscu98oruq4aeI/m2YN8zb2l3CzZq2vyjQPlSfXYGEr49hWa4AOz
 oxyAgyWMiS88BpfbnaL74EOf/m6eJv4W6Acs7Gdxa01Ur5OKBl4eaOIXLFH+4upy6Z
 W0c6iatPVmHgg==
Message-ID: <sashiko-outbox-203163@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
To: "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261106181225.3333260-3-zachary.mckevitt@oss.qualcomm.com>
References: <20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com>
 <20261106181225.3333260-3-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 18:18:56 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/drm_ras: unsynchronized xa_load() node lookup in telemetry
  handlers
- [Medium] drm/drm_ras: broken status handling and non-standard UAPI in
  telemetry ops
--

commit 136edf60d4fd4d79aaeb6f30bb50fe8f150aa0fe
Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

drm/drm_ras: Extend DRM RAS interface to include telemetry nodes

This commit extends the DRM RAS Generic Netlink specification and driver
interface with a telemetry node type and operations to list, read, and
write device telemetry fields.

> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/net=
link/specs/drm_ras.yaml
> index a88fdab7a1c74..cf015bba020d0 100644
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
> +        doc:  Name of the telemetry field defined by the device's uAPI.
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
Does the telemetry Netlink UAPI and its status handling work as intended
when a device reports an error?

In drm_ras_nl_telemetry_get_doit() and drm_ras_nl_telemetry_set_doit(), a
non-zero return from node->telemetry_get() or node->telemetry_set() frees
msg and returns immediately without serializing
DRM_RAS_A_TELEMETRY_ATTRS_STATUS.  Conversely, if the callback returns 0
with a non-zero status, drm_ras_nl_telemetry_get_doit() still serializes a
zero DRM_RAS_A_TELEMETRY_ATTRS_VALUE alongside status and bypasses standard
Netlink NLMSG_ERROR and extack reporting:

drivers/gpu/drm/drm_ras.c:drm_ras_nl_telemetry_get_doit() {
    ...
	ret =3D node->telemetry_get(node, &field, &value, &status);
	if (ret) {
		nlmsg_free(msg);
		return ret;
	}

	ret =3D nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
    ...
	ret =3D nla_put_sint(msg, DRM_RAS_A_TELEMETRY_ATTRS_VALUE, value);
    ...
}

In addition, telemetry-set attaches a dump callback to a set command to
enumerate writable fields, telemetry-get returns different objects in do
([value, status]) versus dump ([field, field-name]), and telemetry-attrs
exposes board temperatures, voltages, power, and TDP limits as device-
specific field IDs and unitless integers rather than through hwmon.

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 4f4777060a4e8..fda50563c4a54 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
[ ... ]
> @@ -617,6 +644,285 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_b=
uff *skb, struct genl_info *i
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
> +	if (!telemetry_fields_contains(node->telemetry_fields_gettable, field))
> +		return -EINVAL;
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

[Severity: High]
Can the unlocked xa_load() lookups in the telemetry handlers race with
drm_ras_node_unregister() and cause a use-after-free?

drm_ras_nl_family sets .parallel_ops =3D true, and xa_load() only holds the
RCU read lock during the XArray walk itself.  drm_ras_nl_pre_telemetry(),
drm_ras_nl_telemetry_get_doit(), drm_ras_nl_telemetry_get_dumpit(),
drm_ras_nl_telemetry_set_doit(), and drm_ras_nl_telemetry_set_dumpit() use
the returned node pointer without holding a lock or reference across
GFP_KERNEL allocations and sleeping driver callbacks, while
drm_ras_node_unregister() only calls xa_erase() before the caller frees the
node:

CPU0                                  CPU1
drm_ras_nl_telemetry_get_doit()
  node =3D xa_load(&drm_ras_xa, id);
  genlmsg_new(..., GFP_KERNEL);
                                      drm_ras_node_unregister(node)
                                        xa_erase(&drm_ras_xa, node->id);
                                      kfree(node);
  node->telemetry_get(node, ...);  <-- use-after-free

Because drm_ras_nl_pre_telemetry() and the doit handlers also perform
separate unlocked xa_load() calls instead of pinning the node in pre_doit
and releasing it in post_doit, node_id can be unregistered and reallocated
to a different node between the permission check and the operation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106181225.3333=
260-1-zachary.mckevitt@oss.qualcomm.com?part=3D2
