Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6F606A332
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfPWmWVP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC0010E7EF;
	Mon, 23 Nov 2026 15:29:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8859610E4D6;
 Mon, 23 Nov 2026 15:28:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 59D4443A0B;
 Mon, 23 Nov 2026 15:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CD11F000ED;
 Mon, 23 Nov 2026 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795447734;
 bh=QlKHAAG2d3KlWvQS7SbnMcJoUE7Iqgg9ZhLvX4Di6mg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AfPWmWVP/72gW80cW9Ql6d/dbNoFXxPvgFSCDzlcQXASjhfw9Wrqv1T5riXOPxxWP
 LqxxjfPRwMaDcmLUMSh2oq8sHhwDIQudLB45ucj3GoR8g0avvhn52xoCEFpjac22qH
 gYuf/gDrUA7U7oRT0DcTHNBPBwTAYXvY12CdQH74DrQcUJ4XhU+gmZlZI2vhpcEM9S
 AqOBEaD1t6Xc/b6V9+TRqCNOU4x7z3EWPJ/ReJJTBnvpxW1uDGZMoePUqYHmT6m7Vg
 lXDsbvrU0q98EfVAipvY8fLiNKylZB/apx2QnYTaotpreLskxxpvP3YnQ+fjjpdkpW
 OTxTYtTAxcHew==
Message-ID: <sashiko-outbox-229565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/ras: Add retired-pages node type
To: "Rodrigo Vivi" <rodrigo.vivi@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261123150806.2266196-5-rodrigo.vivi@intel.com>
References: <20261123150806.2266196-4-rodrigo.vivi@intel.com>
 <20261123150806.2266196-5-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 15:28:53 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/ras: lost NLM_F_DUMP_INTR in
  drm_ras_nl_get_retired_pages_dumpit()
- [Medium] drm/ras: missing node type checks in error-counter netlink
  handlers
--

commit 27c9afd08cd19612592b285ef905e2efcbf77cec
Author: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>

drm/ras: Add retired-pages node type

This commit adds a retired-pages node type to drm-ras along with the
get-retired-pages dump operation and the get-retired-pages-info do
operation.

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index b099eb67836e7..34e5dab997440 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c

[ ... ]

> @@ -617,6 +637,145 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_b=
uff *skb, struct genl_info *i
>  	return set_node_error_threshold(node_id, error_id, threshold);
>  }
> =20
> +static struct drm_ras_node *get_retired_pages_node(const struct genl_inf=
o *info)
> +{
> +	struct nlattr *attr =3D info->attrs[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_I=
D];
> +	struct drm_ras_node *node;
> +
> +	node =3D xa_load(&drm_ras_xa, nla_get_u32(attr));
> +	if (!node || node->type !=3D DRM_RAS_NODE_TYPE_RETIRED_PAGES) {
> +		NL_SET_BAD_ATTR(info->extack, attr);
> +		return NULL;
> +	}
> +
> +	return node;
> +}
> +
> +static int msg_put_retired_page(struct sk_buff *msg, u32 node_id,
> +				const struct drm_ras_retired_page *page)
> +{
> +	if (nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node_id) ||
> +	    nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS, page->addre=
ss) ||
> +	    nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE, page->size) ||
> +	    nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS, page->status))
> +		return -EMSGSIZE;
> +
> +	return 0;
> +}
> +
> +/**
> + * drm_ras_nl_get_retired_pages_dumpit() - Dump the retired pages of a n=
ode
> + * @skb: Netlink message buffer
> + * @cb: Callback context for multi-part dumps
> + *
> + * Appends one message per retired page, in increasing address order. The
> + * dump resumes from the next address after a buffer overflow, and is fl=
agged
> + * with %NLM_F_DUMP_INTR if the list changed between messages.
> + *
> + * Return: 0 if all pages fit in @skb, -EMSGSIZE if the buffer filled up
> + *         (requires multi-part continuation), or a negative error code =
on
> + *         failure.
> + */
> +int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
> +					struct netlink_callback *cb)
> +{
> +	const struct genl_info *info =3D genl_info_dump(cb);
> +	struct drm_ras_ctx *ctx =3D (void *)cb->ctx;
> +	struct drm_ras_retired_page page;
> +	struct drm_ras_node *node;
> +	void *hdr;
> +	int ret;
> +
> +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_AT=
TRS_NODE_ID))
> +		return -EINVAL;
> +
> +	node =3D get_retired_pages_node(info);
> +	if (!node)
> +		return -ENOENT;
> +
> +	for (;;) {
> +		ret =3D node->query_retired_page(node, ctx->cursor, &page);
> +		if (ret =3D=3D -ENOENT)
> +			return 0;
> +		if (ret)
> +			return ret;
> +
> +		/* Never zero, so the first message is checked as well */
> +		cb->seq =3D page.generation + 1;
> +
> +		hdr =3D genlmsg_iput(skb, info);
> +		if (!hdr)
> +			return -EMSGSIZE;
> +
> +		genl_dump_check_consistent(cb, hdr);
> +
> +		ret =3D msg_put_retired_page(skb, node->id, &page);
> +		if (ret) {
> +			genlmsg_cancel(skb, hdr);
> +			return ret;
> +		}
> +
> +		genlmsg_end(skb, hdr);
> +		ctx->cursor =3D page.address + 1;
> +	}
> +}

[Severity: Medium]
Can calling genl_dump_check_consistent(cb, hdr) before
msg_put_retired_page() lose NLM_F_DUMP_INTR across a multi-part dump
boundary?

genlmsg_iput() only requires 20 bytes of tailroom, while
msg_put_retired_page() needs another 32 to 40 bytes.  If the remaining skb
space falls in between when page.generation changes,
genl_dump_check_consistent() sets NLM_F_DUMP_INTR on hdr and updates
cb->prev_seq =3D cb->seq, after which msg_put_retired_page() fails with
-EMSGSIZE and genlmsg_cancel() discards hdr.  When the dump resumes at the
same ctx->cursor in the next skb, cb->seq already matches cb->prev_seq, so
userspace never receives NLM_F_DUMP_INTR.

Also, page.generation + 1 wraps to 0 in cb->seq when page.generation is
U32_MAX, and if all remaining pages at or above ctx->cursor are removed
between dump batches, query_retired_page() returns -ENOENT before cb->seq
is updated.  Moving genl_dump_check_consistent() after
msg_put_retired_page() succeeds avoids consuming the sequence change on a
cancelled message.

[ ... ]

> @@ -631,14 +790,18 @@ int drm_ras_node_register(struct drm_ras_node *node)
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
> +	switch (node->type) {
> +	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
> +		if (!node->error_counter_range.last || !node->query_error_counter)
> +			return -EINVAL;
> +		break;
> +	case DRM_RAS_NODE_TYPE_RETIRED_PAGES:
> +		if (!node->query_retired_page)
> +			return -EINVAL;
> +		break;
> +	default:
>  		return -EINVAL;
> +	}
> =20
>  	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
>  }

[Severity: Medium]
Now that drm_ras_node_register() inserts DRM_RAS_NODE_TYPE_RETIRED_PAGES
nodes into drm_ras_xa, should the error-counter netlink handlers verify
that node->type =3D=3D DRM_RAS_NODE_TYPE_ERROR_COUNTER?

Without that check, passing a retired-pages node ID to the error-counter
operations causes get_node_error_threshold() and set_node_error_threshold()
to return -EOPNOTSUPP instead of -ENOENT, and causes
drm_ras_nl_get_error_counter_dumpit() to iterate over
node->error_counter_range on a non-error-counter node:

drivers/gpu/drm/drm_ras.c:get_node_error_threshold() {
	node =3D xa_load(&drm_ras_xa, node_id);
	if (!node)
		return -ENOENT;

	if (!node->query_error_threshold)
		return -EOPNOTSUPP;
    ...
}

drivers/gpu/drm/drm_ras.c:drm_ras_nl_get_error_counter_dumpit() {
    ...
	node =3D xa_load(&drm_ras_xa, node_id);
	if (!node)
		return -ENOENT;

	for (error_id =3D max(node->error_counter_range.first, ctx->restart);
	     error_id <=3D node->error_counter_range.last;
	     error_id++) {
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123150806.2266=
196-4-rodrigo.vivi@intel.com?part=3D1
