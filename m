Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C73CD98CC
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 05:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC1710E56F;
	Fri, 12 Jun 2026 05:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CmNX+O9c";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC7E210E56F
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 05:22:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DEAA9600AF;
 Fri, 12 Jun 2026 05:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6A31F000E9;
 Fri, 12 Jun 2026 05:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781241744;
 bh=3OUi/fZ4O5cAGJga82bovgYpsNJ9yDhcWDduwocyh5M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CmNX+O9cjs9qhWWn19MlEkS9b61KT2yC2ryk9jXv/blWnvw82F/54ImovUAp6khXb
 Tmf8IJ61Yh3HIE3ZaJv6hXyvyfZqWIZPDaAmZTzU6wfw/DGVbFy4Cn3ubs2CVyHui5
 ma4nXFgN+S2IMdzbC/g7JpVV4CH9MlWM5CEUSqeQVf+JPjfh+PH1KpW9R2b+8EYTxf
 UKDtbLZ04r2yGyvBMfFU1QJPzmN3UzVlDA9DC9g27gSJpzXuQaG2PDQYYZQwcZ+Z+a
 jgNSSN2kgdpG8p9D4fGhODezm5WInuBNOtyGwcjOtJfbLLi6Vj/mdlbPxYIwPjXc52
 xXmP2of26pqCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/drm_ras: Add drm_ras netlink error event
To: "Riana Tauro" <riana.tauro@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611052144.784969-5-riana.tauro@intel.com>
References: <20260611052144.784969-5-riana.tauro@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 05:22:23 +0000
Message-Id: <20260612052224.1D6A31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] drm_ras_nl_error_event() restricts netlink multicast notificatio=
ns to the initial network namespace, breaking netnsok =3D true functionalit=
y.

Pre-existing issues:
- [Critical] Missing RCU read lock or refcounting during xarray iteration a=
nd node lookup causes a Use-After-Free vulnerability.
- [High] Uninitialized stack variable `ret` is returned to userspace in net=
link dumpit operations.
--

commit 162404af4b01c208febc1891d2805e74285b3e40
Author: Riana Tauro <riana.tauro@intel.com>

drm/drm_ras: Add drm_ras netlink error event

Define a new netlink event 'error-event' and a new multicast group
'error-notify' in drm_ras. Each event contains device name, node and
error information to identify the error triggering the event.

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394c..503d555e067c0 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c

[Severity: Critical]
This is a pre-existing issue, but missing RCU read locks or refcounting
during xarray iteration and node lookup might cause a use-after-free.

Looking at get_node_error_counter(), drm_ras_nl_clear_error_counter_doit(),
and drm_ras_nl_list_nodes_dumpit(), they retrieve a node pointer from
drm_ras_xa:

	node =3D xa_load(&drm_ras_xa, node_id);
	if (!node || !node->query_error_counter)
		return -ENOENT;
	...
	return node->query_error_counter(node, error_id, name, value);

Since xa_load() releases the RCU read lock before returning, and the caller
does not hold an outer rcu_read_lock(), could a concurrent call to
drm_ras_node_unregister() free the node and result in a use-after-free
when accessing node fields?

[Severity: High]
This isn't a bug introduced by this patch, but returning an uninitialized
stack variable could cause issues in the netlink dumpit operations.

In drm_ras_nl_list_nodes_dumpit() and drm_ras_nl_get_error_counter_dumpit(),
the local variable ret is declared without initialization:

	int ret;

	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
	...
	}

	if (ret =3D=3D -EMSGSIZE)
		ctx->restart =3D id;

	return ret;

If the xarray is empty or ctx->restart is beyond the last element (such as
on the final dump iteration), the loop is entirely skipped.

Could this return an uninitialized ret to userspace, potentially leaking
stack memory or causing netlink_dump() to loop indefinitely if ret happens
to be a positive value?

[ ... ]

> @@ -222,6 +255,61 @@ static int doit_reply_value(struct genl_info *info, =
u32 node_id,
>  	return genlmsg_reply(msg, info);
>  }
> =20
> +/**
> + * drm_ras_nl_error_event() - Notify listeners of an error event
> + * @node: Node structure
> + * @error_id: ID of the error
> + * @error_name: Name of the error
> + * @value: Value associated with the error
> + * @flags: GFP flags for memory allocation
> + *
> + * Sends a notification to all listeners about an error event on a speci=
fic
> + * RAS node.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, cons=
t char *error_name,
> +			   u32 value, gfp_t flags)
> +{
> +	struct genl_info info;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	int ret;
> +
> +	if (!error_name)
> +		return -EINVAL;
> +
> +	if (!genl_has_listeners(&drm_ras_nl_family, &init_net, DRM_RAS_NLGRP_ER=
ROR_NOTIFY))
> +		return 0;

[Severity: Medium]
Since the drm_ras_nl_family is configured with .netnsok =3D true, does this
check inadvertently restrict multicast notifications to only the initial
network namespace?

By checking &init_net and subsequently using genlmsg_multicast(), it
appears that subscribers in other network namespaces might not receive
these error events.

Would it be better to use genlmsg_multicast_allns() here to properly
broadcast to all namespaces?

> +
> +	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
> +
> +	msg =3D genlmsg_new(NLMSG_GOODSIZE, flags);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr =3D genlmsg_iput(msg, &info);
> +	if (!hdr) {
> +		ret =3D -EMSGSIZE;
> +		goto free_msg;
> +	}
> +
> +	ret =3D msg_put_error_event_attrs(msg, node, error_id, error_name, valu=
e);
> +	if (ret)
> +		goto cancel_msg;
> +
> +	genlmsg_end(msg, hdr);
> +	genlmsg_multicast(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_NOTIF=
Y, flags);
> +	return 0;
> +
> +cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +free_msg:
> +	nlmsg_free(msg);
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_ras_nl_error_event);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611052144.7849=
69-4-riana.tauro@intel.com?part=3D1
