Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF63C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D31710E5F8;
	Wed, 19 Aug 2026 13:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P4Hn4sno";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA15710E14A;
 Wed, 19 Aug 2026 13:54:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3C2F43E14;
 Wed, 19 Aug 2026 13:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAAD1F000E9;
 Wed, 19 Aug 2026 13:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787147693;
 bh=V+fjHQRERu8YrYewmSxHZhyCDM8wSX91vTKrv0mNNok=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P4Hn4sno8WmbrpLKqfQJ3vdzaOTmm64xVkSBkfqiSYbLlaTL9V72YK/hkSVcq/0cd
 HeXyMFqj9L6+uW+O1h2tg/FTkvPDWb497hejM9JXzSdoHhg9UXqRlWGMCP7bp5TjEx
 TNNmulncqrtLRP9OkJ0zbalFLrKZd7XllgBZhg8aXiNa0PvKgwZG5zssZdY3AohLSQ
 HzZUzXv1Y8uofHjhAVVrEH/Q7gWy5eCTOl83VV4wtWZGI76IVADMdfNUk4U55aK59p
 Av/vqqP/1pXtxMZ3NTavYOiXO08NRKg9iyGOmuLSnPVeZQL5kqsIZlEfKGozX1VNgW
 tFvZA0ywpJrRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] drm/ras: Cancel and free message on get counter
 failure
To: "Raag Jadav" <raag.jadav@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260818135304.497098-2-raag.jadav@intel.com>
References: <20260818135304.497098-1-raag.jadav@intel.com>
 <20260818135304.497098-2-raag.jadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 13:54:53 +0000
Message-Id: <20260819135453.8EAAD1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Concurrent device teardown causes Use-After-Free and potential=
 Control-Flow Hijack due to unprotected `drm_ras_node` access via XArray.
- [High] Uninitialized variable `ret` is returned if the node iteration loo=
ps do not execute, corrupting netlink dump responses.
--

--- Patch [1]: [PATCH v6 1/5] drm/ras: Cancel and free message on get count=
er failure ---
commit 967dffc71497d8878a77ecf0c72775277b0ce183
Author: Raag Jadav <raag.jadav@intel.com>

drm/ras: Cancel and free message on get counter failure
   =20
doit_reply_value() directly returns on get counter failure, which results
in stale sk_buff and genetlink header that aren't cleaned up. Fix it and
while at it, consolidate error handling using goto.

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 39155fb514de3..4fa1a257b0ed1 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -234,25 +234,28 @@ static int doit_reply_value(struct genl_info *info,=
 u32 node_id,
> =20
>  	hdr =3D genlmsg_iput(msg, info);
>  	if (!hdr) {
> -		nlmsg_free(msg);
> -		return -EMSGSIZE;
> +		ret =3D -EMSGSIZE;
> +		goto free_msg;
>  	}
> =20
>  	ret =3D get_node_error_counter(node_id, error_id,
>  				     &error_name, &value);
>  	if (ret)
> -		return ret;
> +		goto cancel_msg;
> =20
>  	ret =3D msg_reply_value(msg, error_id, error_name, value);
> -	if (ret) {
> -		genlmsg_cancel(msg, hdr);
> -		nlmsg_free(msg);
> -		return ret;
> -	}
> +	if (ret)
> +		goto cancel_msg;
> =20
>  	genlmsg_end(msg, hdr);
> =20
>  	return genlmsg_reply(msg, info);
> +
> +cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +free_msg:
> +	nlmsg_free(msg);
> +	return ret;
>  }

[Severity: Critical]
This is a pre-existing issue, but does get_node_error_counter() have a
use-after-free risk during concurrent device teardown?

Since drm_ras_nl_family is configured with parallel_ops =3D true, these han=
dlers
run concurrently without genl_mutex. If the device is concurrently unregist=
ered
(e.g., driver unbind or hot-unplug), drm_ras_node_unregister() removes the =
node
from the xarray and the driver frees its memory while the netlink handler is
still executing.

This can happen in get_node_error_counter():

drivers/gpu/drm/drm_ras.c:get_node_error_counter() {
	...
	node =3D xa_load(&drm_ras_xa, node_id);
	if (!node || !node->query_error_counter)
		return -ENOENT;

	if (error_id < node->error_counter_range.first ||
	...
}

Here xa_load() retrieves the node pointer locklessly, but it is dereferenced
without holding an RCU read lock or taking a reference count. Could this re=
sult
in a use-after-free and potential control-flow hijack when executing
node->query_error_counter()?

This same pattern appears in drm_ras_nl_list_nodes_dumpit():

drivers/gpu/drm/drm_ras.c:drm_ras_nl_list_nodes_dumpit() {
	...
	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
		hdr =3D genlmsg_iput(skb, info);
	...
}

And in drm_ras_nl_clear_error_counter_doit():

drivers/gpu/drm/drm_ras.c:drm_ras_nl_clear_error_counter_doit() {
	...
	node =3D xa_load(&drm_ras_xa, node_id);
	if (!node || !node->clear_error_counter)
		return -ENOENT;
	...
}

[Severity: High]
This is also a pre-existing issue, but can drm_ras_nl_list_nodes_dumpit()
return an uninitialized value?

drivers/gpu/drm/drm_ras.c:drm_ras_nl_list_nodes_dumpit() {
	...
	int ret;

	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
		...
		ret =3D nla_put_u32(skb, DRM_RAS_A_NODE_ATTRS_NODE_ID, node->id);
		...
	}

	if (ret =3D=3D -EMSGSIZE)
		ctx->restart =3D id;

	return ret;
}

If the xarray is empty, or on the final recvmsg() call where ctx->restart is
past the end of the items (signifying EOF), the iteration loop will not exe=
cute.
This leaves ret uninitialized. The function then checks if (ret =3D=3D -EMS=
GSIZE),
which reads uninitialized stack memory, and then returns ret. This could ca=
use
the dump to fail sporadically with arbitrary error codes.

A similar issue appears in drm_ras_nl_get_error_counter_dumpit():

drivers/gpu/drm/drm_ras.c:drm_ras_nl_get_error_counter_dumpit() {
	...
	int ret;

	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTR=
S_NODE_ID))
		return -EINVAL;
	...
	for (error_id =3D max(node->error_counter_range.first, ctx->restart);
	     error_id <=3D node->error_counter_range.last;
	     error_id++) {
		ret =3D get_node_error_counter(...);
		...
	}

	if (ret =3D=3D -EMSGSIZE)
		ctx->restart =3D error_id;

	return ret;
}

If the requested error range iteration does not execute, ret remains
uninitialized here as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818135304.4970=
98-1-raag.jadav@intel.com?part=3D1
