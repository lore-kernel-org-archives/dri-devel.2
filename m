Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD725CDB47C
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C14010EE5E;
	Wed, 24 Jun 2026 10:15:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wn77j7Ah";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D156D10EE5E
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:15:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 92750442FC;
 Wed, 24 Jun 2026 10:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CFB1F000E9;
 Wed, 24 Jun 2026 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782296130;
 bh=xCy6HKiRg5Ve6e0nIZBTlfOfGLMrEvl6DtlZRhS2W+k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wn77j7Ah6/C/RcRlax1m+Q8h7nCmoXUWbW9/mIz4Bvp60ITcxrB5/T5kpDcEn+89U
 uJsv6dPPOzLCSkHa+OepdEgGoMlDJRDaikY7uZyGslAFhxtjZEVVojHg1u/NcrQfuL
 K5eGC1Vk9f3s/SVTefa/XYdpYAIA6y5jWkUOC/TzaHwHJVAfU6Bt34Jcr0h0x0R0sF
 j9XR45PwSzQYKARXPbGsDoEtwYeKfbYWBWSGAWRN13UokN5MCoi8nADHtbDfkxLDjV
 /F9hh11NYuiBto/Ss6Gk8aCIgfSRWgKopVnS8D3xrFg5oep4+kFqAFxvPGrlRdzG12
 7ck2lHVS5/cyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] drm/ras: Cancel and free message on get counter
 failure
To: "Raag Jadav" <raag.jadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623101043.255897-2-raag.jadav@intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
 <20260623101043.255897-2-raag.jadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 10:15:29 +0000
Message-Id: <20260624101530.56CFB1F000E9@smtp.kernel.org>
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
- [Critical] Lockless access to `drm_ras_node` pointers from the global `dr=
m_ras_xa` XArray leads to Use-After-Free and control-flow hijacking during =
concurrent device teardown.
- [Medium] Missing generation counter and NLM_F_DUMP_INTR flag for lockless=
 Netlink dumps.
--

commit 17d70fc870ba118f3745064732f976f0856f2d46
Author: Raag Jadav <raag.jadav@intel.com>

drm/ras: Cancel and free message on get counter failure

This commit fixes a resource leak in doit_reply_value() where sk_buff
and the genetlink header were not cleaned up on a get counter failure.
It also consolidates the error handling using a goto pattern.

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394c..467a169026fc1 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -201,25 +201,28 @@ static int doit_reply_value(struct genl_info *info,=
 u32 node_id,
[ ... ]
>  	ret =3D get_node_error_counter(node_id, error_id,
>  				     &error_name, &value);

[Severity: Critical]
This is a pre-existing issue, but does lockless access to drm_ras_node
pointers from the global drm_ras_xa XArray lead to a use-after-free
during concurrent device teardown?

The drm_ras netlink operations use .parallel_ops =3D true, meaning handlers
like get_node_error_counter() run concurrently without holding the global
genl_lock().

When retrieving a drm_ras_node pointer via xa_load(), the XArray API drops
the RCU read lock immediately after the lookup, returning a raw, unprotected
pointer:

drivers/gpu/drm/drm_ras.c:get_node_error_counter() {
	node =3D xa_load(&drm_ras_xa, node_id);
	if (!node || !node->query_error_counter)
		return -ENOENT;
	...
	return node->query_error_counter(node, error_id, name, value);
}

Concurrently, a driver can unregister its nodes during teardown, which remo=
ves
the node from the XArray and synchronously frees the node memory via DRM's
managed cleanup.

Could the netlink handler then dereference this freed pointer, calling func=
tion
pointers read from freed memory?

This same pattern appears in drm_ras_nl_list_nodes_dumpit() and
get_node_error_threshold().


[Severity: Medium]
This is also a pre-existing issue, but are we missing a generation counter =
and
NLM_F_DUMP_INTR flag for lockless Netlink dumps?

The Generic Netlink UAPI rules dictate: "If iteration during a dump may ski=
p or
repeat objects (e.g. due to lockless data structures), set NLM_F_DUMP_INTR =
on
the affected message(s)."

drm_ras_nl_list_nodes_dumpit() and drm_ras_nl_get_error_counter_dumpit()
iterate over the lockless drm_ras_xa XArray across potentially multiple net=
link
continuations:

drivers/gpu/drm/drm_ras.c:drm_ras_nl_list_nodes_dumpit() {
	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
		...
	}
}

Because drm_ras_xa can be modified concurrently by node registration or
unregistration, a multipart dump might skip newly registered elements. Shou=
ld
the implementation maintain a generation counter or set NLM_F_DUMP_INTR on =
the
netlink message to inform userspace of the sequence change?

>  	if (ret)
> -		return ret;
> +		goto cancel_msg;
> =20
>  	ret =3D msg_reply_value(msg, error_id, error_name, value);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623101043.2558=
97-1-raag.jadav@intel.com?part=3D1
