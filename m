Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DA4C44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 03:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 898FA10E516;
	Thu, 23 Jul 2026 03:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bUGBZpUG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACBE410E4C6
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 03:47:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D860600AB;
 Thu, 23 Jul 2026 03:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9FA1F000E9;
 Thu, 23 Jul 2026 03:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784778451;
 bh=7LRm66cQFtvLNzRJ2kcEBPhMQwvK6FZeRtzNaY6kJhQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bUGBZpUGP+RvtkZQtvYpeO4DoAV2czBTmekoH2UxrX/c4miHT3Stkw8EbqKU1oLUV
 0C/8odFtXrLkFL1mWjKchY0u3vZgeMxTVqNFND5anEbK0RujcdF1OxCsrbJhDh8kU9
 pYgApS1S+mCCsAqEyc+DCez0G0FCKNhrPGdhO2vdVor5yHRoCNbjQ8SvKki5fUZhCA
 5iKe70FefImoLl8yhpVSCIs55KhuTigZuypppEwN5qP5kV1xcqnnH7SYa84uTeprDu
 qCUjGiZPvYJjduA1MkgNlFZH6cVTCimlagyHxduANrZMHr071fGBzWuIdur//6/svD
 boIhOXj2jSCWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] drm/ras: Introduce error threshold
To: "Raag Jadav" <raag.jadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722034228.662746-3-raag.jadav@intel.com>
References: <20260722034228.662746-1-raag.jadav@intel.com>
 <20260722034228.662746-3-raag.jadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 03:47:30 +0000
Message-Id: <20260723034731.2B9FA1F000E9@smtp.kernel.org>
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
- [Medium] The `set-error-threshold` command only ACKs on success instead o=
f replying with a full message, violating Netlink design rules.

Pre-existing issues:
- [High] Lockless access to the `drm_ras_xa` XArray without RCU protection =
or reference counting leads to a Use-After-Free vulnerability when accessin=
g `drm_ras_node`.
--

--- Patch [2]: [PATCH v5 2/5] drm/ras: Introduce error threshold ---
commit c7d3a70f53c077dda897bf8be8b57f1fb2216708
Author: Raag Jadav <raag.jadav@intel.com>

drm/ras: Introduce error threshold

Adds get-error-threshold and set-error-threshold netlink commands to query
and set RAS error thresholds for hardware error accumulation control.

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
Should this operation include a reply definition?

The Netlink uAPI guidelines for new families state that all operations,
especially SET or ADD commands, must reply with a full message rather than
relying on a standard ACK.=20

Once a command only ACKs, it becomes uAPI and cannot be fixed later. Would
it be better to return the updated state of the threshold here instead of
relying on a separate GET request?

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 467a169026fc1..9a7b3d2acd25d 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
[ ... ]
> @@ -168,6 +186,40 @@ static int get_node_error_counter(u32 node_id, u32 e=
rror_id,
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

[Severity: High]
This is a pre-existing issue with how this file accesses the xarray, but
is it safe to dereference the node pointer here without RCU protection or
a reference count?

The generic netlink family drm_ras_nl_family sets .parallel_ops =3D true,
meaning doit callbacks run without genl_mutex. While xa_load() takes the
RCU read lock internally, it drops it before returning.

If a DRM device is concurrently unbound and freed, couldn't this memory be
freed before we call node->query_error_threshold(), resulting in a
use-after-free?

> +		return -EOPNOTSUPP;
[ ... ]
> @@ -358,6 +463,59 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_bu=
ff *skb,
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
> +}

[Severity: Medium]
Does this operation need to construct and return a reply message?

By returning directly, this handler only emits a standard generic netlink
ACK on success. As mentioned above, the Netlink design guidelines require
operations to reply with a full message rather than just an ACK.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722034228.6627=
46-1-raag.jadav@intel.com?part=3D2
