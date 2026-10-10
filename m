Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54F1CA9EC1
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 17:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1181410E26D;
	Sat, 10 Oct 2026 17:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mj05ueRG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12E910E26D
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 17:36:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9FC88406D1;
 Sat, 10 Oct 2026 17:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594D61F000FF;
 Sat, 10 Oct 2026 17:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791653814;
 bh=czyMrPS4gaN5S1toQPWC0XGf1Y6zZ2VTaO3otU9fiQo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mj05ueRGiZjh4ov0PhIh+wp51luj6IECcvOWsyRT3vuJl2U2G3tTmi33/X01yL3Fm
 EcCIp1Oepv83m6cguweuuk9kbmcohze1OitmDJuy8q3T0Z4tKptZOE5Huu37bUEpgh
 RO95CMCVOjNu9ief4pRxZnd4dE6doJfbvor9pY4n6x4fCW+HX3sU8v8ymZneBrfUZd
 5B2ywzHmVru9/iljKXAYS/2dPNFYniWOxX5fCcMpxIvV5nn7ouDV542K44Hm3Be+1R
 tO9r5kvWqp/EisEbWp1bSbu8wMPVhcqEpoP72pSTMddNEJpBZgGFNAKEjVqGBbhimU
 P6nk+RxdG6+iA==
Message-ID: <sashiko-outbox-166781@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
To: "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
 <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 17:36:53 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] drm: NULL pointer dereference in drm_ras_nl_pre_telemetry() on inv=
alid node
- [High] drm: missing netlink attribute presence checks cause NULL pointer =
dereferences
- [High] drm: Use-After-Free of drm_ras_node in netlink telemetry handlers
- [High] drm: DRM_RAS_CMD_TELEMETRY_WRITE lacks GENL_ADMIN_PERM capability
- [Medium] drm: uninitialized stack variables leaked in drm_ras_nl_telemetr=
y_read_doit()
- [Low] drm_ras: drm_ras_nl_telemetry_write_doit validates wrong callback
- [Low] netlink: use of u64 and pad attributes instead of uint for new uAPI
--

commit 6e531a5b48e418d2f90c14c196ea1ac73f7170e4
Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

drm/drm_ras: Extend DRM RAS interface to include telemetry nodes

This commit adds a new node type, attribute set, and doit function for
performing telemetry read and write operations using the DRM RAS interface.

> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/net=
link/specs/drm_ras.yaml
> index a88fdab7a1c74..d558eb1cba3f1 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
[ ... ]
> @@ -100,6 +100,31 @@ attribute-sets:
>          name: error-value
>          type: u32
>          doc: Current value of the error counter.
> +  -
> +    name: telemetry-attrs
> +    attributes:
[ ... ]
> +      -
> +        name: value
> +        type: u64
> +        doc: Value of telemetry field that was read/written.
> +      -
> +        name: status
> +        type: s32
> +        doc: Status of the telemetry operation.
> +      -
> +        name: pad
> +        type: pad
> +        doc: Alignment padding used for 64-bit

[Severity: Low]
Does this new netlink family uAPI violate the generic netlink design
guidelines?

The telemetry-attrs set defines value as a fixed-width u64 and uses a pad
attribute. The generic netlink documentation explicitly prefers
variable-width 64-bit types (uint/sint) for new attributes to avoid padding
and 64-bit alignment issues on 32-bit architectures.

Since uAPI is immutable once merged, should this use uint natively instead
of introducing fixed-width structures requiring pad attributes?

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index b099eb67836e7..b88293295cda9 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
[ ... ]
> +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk=
_buff *skb,
> +			     struct genl_info *info)
> +{
> +	struct drm_ras_node *node;
> +	u32 node_id;
> +
> +	node_id =3D nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);

[Severity: High]
Can this cause a NULL pointer dereference if userspace sends a malformed
message?

Generic netlink policies enforce the type of an attribute only if it
is present, but they do not enforce presence. If the
DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID attribute is missing from the request,
info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] will be NULL.

Passing NULL to nla_get_u32() dereferences NULL + NLA_HDRLEN, leading to an
immediate kernel oops.

> +	node =3D xa_load(&drm_ras_xa, node_id);
> +
> +	if (node->telemetry_pre)

[Severity: High]
Could this dereference a NULL pointer if the provided node_id does not
exist?

The xa_load() function returns NULL if the ID is not registered, and
this code immediately evaluates node->telemetry_pre without verifying if
node is a valid pointer.

> +		return node->telemetry_pre(node);
> +
> +	return 0;
> +}
[ ... ]
> +int drm_ras_nl_telemetry_read_doit(struct sk_buff *skb, struct genl_info=
 *info)
> +{
> +	struct drm_ras_node *node;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	u32 node_id, field;
> +	s32 status;
> +	u64 value;

[Severity: Medium]
Are these variables guaranteed to be fully initialized by the driver
callback?

They are declared on the kernel stack and passed by reference to the
node->telemetry_read() callback below.

> +	int ret;
> +
> +	if (!info->attrs || !info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
> +		return -EINVAL;
> +
> +	field =3D nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
> +	node_id =3D nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> +
> +	node =3D xa_load(&drm_ras_xa, node_id);
> +	if (!node || !node->telemetry_read)
> +		return -ENOENT;

[Severity: High]
Does this lockless usage of the node pointer risk a use-after-free?

The pointer is obtained via xa_load(), which uses RCU internally but drops
the read lock before returning. The pointer is then used locklessly without
a reference count across the node->telemetry_read() callback.

Since telemetry_read() is allowed to sleep, could a concurrent hardware
unbind or module unload unregister and free the node while this callback is
still executing?

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
> +	ret =3D node->telemetry_read(node, &field, &value, &status);
> +	if (ret) {
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	ret =3D nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
> +	if (ret) {
> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	ret =3D nla_put_64bit(msg, DRM_RAS_A_TELEMETRY_ATTRS_VALUE, sizeof(valu=
e),
> +			    &value, DRM_RAS_A_TELEMETRY_ATTRS_PAD);

[Severity: Medium]
If the driver's telemetry_read() callback returns success (0) but fails to
explicitly populate the value or status fields, this writes uninitialized
kernel stack memory directly into the netlink reply.

Should these variables be initialized to zero when declared?

> +	if (ret) {
> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);
> +		return ret;
> +	}
[ ... ]
> +int drm_ras_nl_telemetry_write_doit(struct sk_buff *skb, struct genl_inf=
o *info)
> +{
> +	struct drm_ras_node *node;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	u32 node_id, field;
> +	s32 status;
> +	u64 value;
> +	int ret;
> +
> +	if (!info->attrs || !info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
> +		return -EINVAL;
> +
> +	value =3D nla_get_u64(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_VALUE]);
> +	field =3D nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
> +	node_id =3D nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);

[Severity: High]
Similar to the pre_doit handler, is it possible for a malformed message
missing the VALUE or NODE_ID attributes to trigger a NULL pointer
dereference here?

The presence of DRM_RAS_A_TELEMETRY_ATTRS_FIELD is explicitly checked above,
but VALUE and NODE_ID are extracted unconditionally.

> +
> +	node =3D xa_load(&drm_ras_xa, node_id);
> +	if (!node || !node->telemetry_read)

[Severity: Low]
Does this code validate the wrong callback?

The telemetry write handler checks for the presence of node->telemetry_read,
but later invokes node->telemetry_write(). While node registration might
currently ensure both are populated, checking the read callback here creates
a brittle dependency on the registration logic.

> +		return -ENOENT;
[ ... ]
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
[ ... ]
> @@ -83,6 +96,22 @@ static const struct genl_split_ops drm_ras_nl_ops[] =
=3D {
[ ... ]
> +	{
> +		.cmd		=3D DRM_RAS_CMD_TELEMETRY_WRITE,
> +		.pre_doit	=3D drm_ras_nl_pre_telemetry,
> +		.doit		=3D drm_ras_nl_telemetry_write_doit,
> +		.policy		=3D drm_ras_telemetry_write_nl_policy,
> +		.maxattr	=3D DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
> +		.flags		=3D GENL_CMD_CAP_DO,
> +	},
>  };

[Severity: High]
Should this command require the GENL_ADMIN_PERM capability?

Unlike DRM_RAS_CMD_SET_ERROR_THRESHOLD, the telemetry write command is miss=
ing
the GENL_ADMIN_PERM flag. This allows unprivileged users to issue arbitrary
writes to hardware components, potentially leading to denial of service or
hardware state corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009173152.2436=
195-1-zachary.mckevitt@oss.qualcomm.com?part=3D2
