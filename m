Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F08606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rqcbxq2u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1730010F26B;
	Mon, 23 Nov 2026 23:42:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E5DD10E4B4;
 Mon, 23 Nov 2026 23:42:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF3D461AE0;
 Mon, 23 Nov 2026 23:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461BE1F0093C;
 Mon, 23 Nov 2026 23:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795477343;
 bh=pZaWALtRzAxJdXdDThbz7FD/s8EITa1UvFfPj9bv2zs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rqcbxq2ul7a0PP7vQru24z6eKITufDyxZ1bbQ9Vz+j+OJmselgQ8ymC7YrcrjtFZo
 WfVDxMYZyI5fSa8VhmxdUcQxND3sWpqMcyTxDPg7LdZs45ET/Zx9W3ij5StMwZo2nw
 mWSPUYSr8NC3HI1UXuG11HWZ8HK/Ov6G7Z8WeCWBw6fsZ7WBRq3Ev/vlLxmo2ozMkO
 vZJvaptq+QzuZB45VO0rER/WgwAVB/m+P7mTKjf8IXfQ1/u0Qge9fcW+RtPSQQ0Y7f
 htXJnJDB4UfCEBJSEiCYH1UeHOtVagQ598TtuZSqkv93a/josjGwDtM0eZg7VecGJz
 p9jGmfnvxD90Q==
Message-ID: <sashiko-outbox-230220@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/ras: Keep nodes alive while netlink operations
 use them
To: "Rodrigo Vivi" <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
In-Reply-To: <20261123233326.2882114-8-rodrigo.vivi@intel.com>
References: <20261123233326.2882114-5-rodrigo.vivi@intel.com>
 <20261123233326.2882114-8-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 23:42:22 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/ras: repeated node_id lookup in
  drm_ras_nl_get_error_counter_dumpit()
- [Medium] drm/ras: premature node put in get_node_error_counter() and
  threshold helper
- [Low] drm/ras: separate declaration and initialization of __free()
  node variables
--

commit d22066c85bafafc21ec35b35656510aa805c320f
Author: Rodrigo Vivi <rodrigo.vivi@intel.com>

drm/ras: Keep nodes alive while netlink operations use them

This commit adds reference counting and a release completion to struct
drm_ras_node so that drm_ras_node_unregister() waits for active netlink
operations to finish using a node before returning.

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index f561604e7e967..550ca7d54cd12 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
[ ... ]
> @@ -178,9 +208,9 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
>  static int get_node_error_counter(u32 node_id, u32 error_id,
>  				  const char **name, u32 *value)
>  {
> -	struct drm_ras_node *node;
> +	struct drm_ras_node *node __free(drm_ras_node_put) =3D NULL;
> =20
> -	node =3D xa_load(&drm_ras_xa, node_id);
> +	node =3D drm_ras_node_get(node_id);
>  	if (!node || !node->query_error_counter)
>  		return -ENOENT;
> =20
> @@ -193,9 +223,9 @@ static int get_node_error_counter(u32 node_id, u32 er=
ror_id,
> =20
>  static int get_node_error_threshold(u32 node_id, u32 error_id, const cha=
r **name, u32 *threshold)
>  {
> -	struct drm_ras_node *node;
> +	struct drm_ras_node *node __free(drm_ras_node_put) =3D NULL;
> =20
> -	node =3D xa_load(&drm_ras_xa, node_id);
> +	node =3D drm_ras_node_get(node_id);
>  	if (!node)
>  		return -ENOENT;

[Severity: Medium]
Does dropping the node reference on return from get_node_error_counter()
and get_node_error_threshold() leave *name unprotected in
doit_reply_value() and doit_reply_threshold()?

drivers/gpu/drm/drm_ras.c:doit_reply_value() {
	...
	ret =3D get_node_error_counter(node_id, error_id,
				     &error_name, &value);
	if (ret)
		goto cancel_msg;

	ret =3D msg_reply_value(msg, error_id, error_name, value);
	...
}

CPU0                                  CPU1
doit_reply_value()
  get_node_error_counter()
    node =3D drm_ras_node_get(...)
    node->query_error_counter(...,
                              &error_name, ...)
    drm_ras_node_put(node)
                                      drm_ras_node_unregister(node)
                                        xa_erase(&drm_ras_xa, node->id)
                                        drm_ras_node_put(node)
                                        wait_for_completion(&node->released)
                                      /* driver frees counter names / unloa=
ds */
  msg_reply_value(..., error_name, ...)
    nla_put_string(..., error_name)   <-- use-after-free

Because the __free(drm_ras_node_put) reference lives inside the helper,
drm_ras_node_unregister() can finish waiting before msg_reply_value() or
msg_reply_threshold() copies error_name into the skb.

> @@ -210,9 +240,9 @@ static int get_node_error_threshold(u32 node_id, u32 =
error_id, const char **name
> =20
>  static int set_node_error_threshold(u32 node_id, u32 error_id, u32 thres=
hold)
>  {
> -	struct drm_ras_node *node;
> +	struct drm_ras_node *node __free(drm_ras_node_put) =3D NULL;
> =20
> -	node =3D xa_load(&drm_ras_xa, node_id);
> +	node =3D drm_ras_node_get(node_id);
>  	if (!node)
>  		return -ENOENT;

[Severity: Low]
This isn't a bug, but cleanup.h style prefers defining and initializing
__free() variables in one statement ("struct drm_ras_node *node
__free(drm_ras_node_put) =3D drm_ras_node_get(node_id);") rather than
initializing them to NULL and assigning later, here and in the other
functions touched by this patch.

[ ... ]

> @@ -451,7 +482,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buf=
f *skb,
>  {
>  	const struct genl_info *info =3D genl_info_dump(cb);
>  	struct drm_ras_ctx *ctx =3D (void *)cb->ctx;
> -	struct drm_ras_node *node;
> +	struct drm_ras_node *node __free(drm_ras_node_put) =3D NULL;
>  	struct nlattr *hdr;
>  	const char *error_name;
>  	u32 node_id, error_id, value;
> @@ -462,7 +493,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buf=
f *skb,
> =20
>  	node_id =3D nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_=
ID]);
> =20
> -	node =3D xa_load(&drm_ras_xa, node_id);
> +	node =3D drm_ras_node_get(node_id);
>  	if (!node)
>  		return -ENOENT;

[Severity: Medium]
Can the dump loop in drm_ras_nl_get_error_counter_dumpit() silently
truncate the dump or switch to a different node if
drm_ras_node_unregister() runs mid-dump?

drivers/gpu/drm/drm_ras.c:drm_ras_nl_get_error_counter_dumpit() {
	...
	for (error_id =3D max(node->error_counter_range.first, ctx->restart);
	     error_id <=3D node->error_counter_range.last;
	     error_id++) {
		ret =3D get_node_error_counter(node_id, error_id,
					     &error_name, &value);
		/*
		 * For non-contiguous range, driver return -ENOENT as indication
		 * to skip this ID when listing all errors.
		 */
		if (ret =3D=3D -ENOENT) {
			ret =3D 0;
			continue;
		}
	...
}

drm_ras_nl_get_error_counter_dumpit() already holds a reference on node,
but each loop iteration passes node_id to get_node_error_counter(), which
acquires xa_lock(&drm_ras_xa) and looks up node_id in drm_ras_xa again.

If drm_ras_node_unregister() runs concurrently, it calls xa_erase() before
waiting on node->released.  Subsequent iterations of the loop then get
-ENOENT from drm_ras_node_get(node_id) and treat it as a non-contiguous
error ID to skip, returning a truncated dump with status 0 (or querying a
newly registered node if xa_alloc() reuses node_id while the old node is
still waiting in drm_ras_node_unregister()).  Passing the already pinned
node pointer to a helper would avoid both the race and the repeated
xa_lock / kref cycles in the loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123233326.2882=
114-5-rodrigo.vivi@intel.com?part=3D3
