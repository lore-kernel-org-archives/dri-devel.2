Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAC9CA9EC1
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 17:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1153B10E278;
	Sat, 10 Oct 2026 17:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h6/RHVBF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C4110E27A
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 17:36:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A42F406D1;
 Sat, 10 Oct 2026 17:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87ED1F000FF;
 Sat, 10 Oct 2026 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791653816;
 bh=Ph+/ZBET6Z1YE6UskAUElMktd2TrcZklt3qXS0DExUc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h6/RHVBFHWK1JBiKdvUaX5Yqkg8QRyLkeM0B/ZQqMPuuuRSdCcX21d1KuB1QG0zIG
 2q/uvK+Z83ilwImpcb2f6pJUcup/a2BqNBAdVLwG6ZOYOHCehTi5B4FYQwMS4TucTG
 ZhGfGNJSrfXhBsrjh+0NHPHM0Ua5cap0maNPF/7JUQuVQKTDdw/w4PoKPPuGC570Yr
 NbNEWon1Egl6A45cXCG0IxtNr/az9pN0jIcRNo5X/0xvOxqQ7aG5XYGfTr1cbCU0V4
 2PnQOC6OBsE2MF603VkVM11frsjw7OcNDbtqKiCQ1sxPCEzJm+qQhlM6JZr1VJhKv6
 FuZzAjq03o2tg==
Message-ID: <sashiko-outbox-166783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/drm_ras: Remove admin-perm flag from list-nodes
 operation
To: "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009173152.2436195-2-zachary.mckevitt@oss.qualcomm.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
 <20261009173152.2436195-2-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 17:36:55 +0000
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
- [Critical] core: UAF in drm_ras_xa lookups during Netlink operations
- [High] core: uninitialized variable leak in Netlink dumpit handlers
- [Low] netlink: missing NLM_F_DUMP_INTR flag for lockless dump iteration
--

commit 46092107989be3447885b1e58b5d130104004fba
Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

drm/drm_ras: Remove admin-perm flag from list-nodes operation

Drivers may want to avoid requiring CAP_NET_ADMIN for subsequent
drm-ras operations. So, drop the CAP_NET_ADMIN requirement for dumping
RAS nodes so that drivers with different permission requirements are
still able to use the interface.

> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index c9f5e0ceb3b5f..ff0dc406c27c8 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -46,7 +46,7 @@ static const struct genl_split_ops drm_ras_nl_ops[] =3D=
 {
>  	{
>  		.cmd	=3D DRM_RAS_CMD_LIST_NODES,
>  		.dumpit	=3D drm_ras_nl_list_nodes_dumpit,
> -		.flags	=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +		.flags	=3D GENL_CMD_CAP_DUMP,

[Severity: Critical]
Does dropping the admin permission here safely handle the pointer management
in drm_ras_nl_list_nodes_dumpit() and get_node_error_counter()?

In drm_ras_nl_list_nodes_dumpit(), xa_for_each_start() iterates over the
xarray:

	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
		hdr =3D genlmsg_iput(skb, info);
		...
		ret =3D nla_put_string(skb, DRM_RAS_A_NODE_ATTRS_DEVICE_NAME,
				     node->device_name);

The xa_for_each_start() macro drops the RCU read lock before returning,
leaving the node pointer unprotected against concurrent freeing.

Could an unprivileged user concurrently querying the list while nodes are
unregistered trigger a use-after-free when node->device_name is read,
leading to memory corruption or data leaks?

A similar unprotected access occurs in get_node_error_counter():

	node =3D xa_load(&drm_ras_xa, node_id);
	if (!node || !node->query_error_counter)
		return -ENOENT;
	...
	return node->query_error_counter(node, error_id, name, value);

Does xa_load() protect the returned node pointer from being freed before the
query_error_counter() function pointer is dereferenced?

[Severity: High]
Can exposing drm_ras_nl_list_nodes_dumpit() to unprivileged users leak kern=
el
stack memory?

In drm_ras_nl_list_nodes_dumpit(), the ret variable is uninitialized:

	int ret;

	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
		...

If the drm_ras_xa xarray is empty, the loop will not execute, and the
function will return the uninitialized stack value. The same issue exists
in drm_ras_nl_get_error_counter_dumpit().

Additionally, if the loop does execute and the socket buffer is full, ret is
set to -EMSGSIZE and returned:

	if (ret =3D=3D -EMSGSIZE)
		ctx->restart =3D id;

	return ret;

Does returning -EMSGSIZE break multi-part netlink dumps entirely by failing
to return skb->len when the buffer fills up?

[Severity: Low]
Is the NLM_F_DUMP_INTR flag required for this lockless dump iteration?

drm_ras_nl_list_nodes_dumpit() iterates over the lockless drm_ras_xa data
structure. If concurrent node registrations or unregistrations occur, the
iteration could skip or repeat items.

According to the Netlink subsystem rules, should such dumps maintain a
generation counter and set NLM_F_DUMP_INTR on the affected messages to
notify userspace of inconsistent states?

>  	},
>  	{
>  		.cmd		=3D DRM_RAS_CMD_GET_ERROR_COUNTER,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009173152.2436=
195-1-zachary.mckevitt@oss.qualcomm.com?part=3D1
