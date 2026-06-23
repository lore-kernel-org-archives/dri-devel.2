Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CD4CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB07A10ECAF;
	Tue, 23 Jun 2026 20:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hUoEMut+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2316610ECAF
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:46:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C6C3408E7;
 Tue, 23 Jun 2026 20:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BC11F000E9;
 Tue, 23 Jun 2026 20:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782247618;
 bh=E+pdPHUzO2f+Yfg/sq60kV+78LBrUXwyWw6ffZK2aK8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hUoEMut+AmxoyL2NCLaP3atxOKaDbi41ScbUcIkbA/5zLLV9qii5ZlSSMILDUOgVB
 kGvhpAsqDS1wTp4mrTUjE6PXN4bA14QojBFTpisHyJ8JJBJ2kwZTln1rBBTQ8CcIMx
 Aa0a/RUi2KKGVeTNEZYgvAlLX8aMW2pINyxozH1FCdIhGYKuET1YpGWly01xfgrztG
 BZGpPqCT5NO1OPrKrVls5z1M5UyI8EdOMIBrhGrPSwTXajI+RS92v07lc65vNKd1OD
 nwsuljKO0tR2LxKNAaZQDbWsYUv+KiI3o0jZJ55nDTyrPSs+WiQ0G3Kgm50qc8/ibd
 iwYN1EVOQDGUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] drm/drm_ras: Add drm_ras netlink error event
To: "Riana Tauro" <riana.tauro@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622101716.3313496-6-riana.tauro@intel.com>
References: <20260622101716.3313496-5-riana.tauro@intel.com>
 <20260622101716.3313496-6-riana.tauro@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:46:58 +0000
Message-Id: <20260623204658.C6BC11F000E9@smtp.kernel.org>
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
- [Medium] Multicast events are restricted to `init_net`, silently dropping=
 events for listeners in other network namespaces despite `.netnsok =3D tru=
e`.

Pre-existing issues:
- [High] Lockless access to `struct drm_ras_node` pointers retrieved from x=
array leads to Use-After-Free.
--

commit aab90b1a7792dc491d0dcac6947d349046f95876
Author: Riana Tauro <riana.tauro@intel.com>

drm/drm_ras: Add drm_ras netlink error event

This commit defines a new netlink event 'error-event' and a multicast
group 'error-report' for the DRM RAS subsystem. It provides a function
for drivers to report device and node error information to subscribed
userspace listeners.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Riana Tauro <riana.tauro@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394c..77f912a4d101f 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c

[ ... ]

> @@ -222,6 +255,60 @@ static int doit_reply_value(struct genl_info *info, =
u32 node_id,
>  	return genlmsg_reply(msg, info);
>  }
> =20
> +/**
> + * drm_ras_nl_error_event() - Report an error event
> + * @node: Node structure
> + * @error_id: ID of the error
> + * @error_name: Name of the error
> + * @value: Value associated with the error
> + * @flags: GFP flags for memory allocation
> + *
> + * Report an error-event to userspace using the error-report multicast g=
roup.
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
ROR_REPORT))

[Severity: Medium]
Will this silently drop events for users subscribing from non-init network
namespaces? The drm_ras_nl_family sets .netnsok =3D true, but this check
is hardcoded to init_net.

> +		return 0;
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
> +	genlmsg_multicast(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_REPOR=
T, flags);

[Severity: Medium]
Similarly, genlmsg_multicast() implicitly uses init_net under the hood. Does
this prevent containerized listeners in other network namespaces from recei=
ving
the multicast events?

> +	return 0;
> +
> +cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +free_msg:
> +	nlmsg_free(msg);
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_ras_nl_error_event);

[Severity: High]
This isn't a bug introduced by this patch, but does locklessly accessing
drm_ras_node pointers retrieved from drm_ras_xa lead to a use-after-free?

In drivers/gpu/drm/drm_ras.c, get_node_error_counter() retrieves the node:

drivers/gpu/drm/drm_ras.c:get_node_error_counter() {
    ...
    node =3D xa_load(&drm_ras_xa, node_id);
    if (!node)
        return -ENOENT;
    ...
    return node->query_error_counter(node, error_id, name, value);
}

A similar lockless pattern is present in drm_ras_nl_list_nodes_dumpit():

drivers/gpu/drm/drm_ras.c:drm_ras_nl_list_nodes_dumpit() {
    ...
    xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
        ...
        ret =3D nla_put_string(skb, DRM_RAS_A_NODE_ATTRS_DEVICE_NAME, node-=
>device_name);
    ...
}

If a concurrent device teardown or hot-unplug removes and frees the node
while these functions are executing, will accessing node->query_error_count=
er
or node->device_name dereference a freed pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622101716.3313=
496-5-riana.tauro@intel.com?part=3D1
