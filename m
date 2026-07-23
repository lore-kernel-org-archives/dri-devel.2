Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6951C4452B
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 03:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F85510E4C6;
	Thu, 23 Jul 2026 03:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hN7+YPfz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8CFF10E516
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 03:47:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E029600AD;
 Thu, 23 Jul 2026 03:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C961F000E9;
 Thu, 23 Jul 2026 03:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784778452;
 bh=q7Ij+g8nRSOtJyvM0j+dxZO+Pyahbv06Bz3HnudAoqA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hN7+YPfzMidN1h19LgWQP+WmE/q+hgNH0/3KP/PQLtaMC2qII/ut7DzIZEc2YaSmZ
 KYDBAEc9wKIuTDpmh8nIlZ+c55tsEZStwpJ/e8JRXL1rbVeq99FngG9srSkCjfZKWs
 MnlSIfpTX0ZDy0POIRL8i/hyrl4/OZWz0Ko8hv3gpn2ZcVlLapfioN7EbdC8Ye9HHa
 qMZtfaQJ9htKxX2jDlr5UVKxqs2SRgjLkaq1cLXBigfXTaCgKFGTPvc4/Jls2mPftd
 NAvEEbW/jiuBWWnE56ezFgD/pD4+Nx+0l4pqR1u7UqdO4LKJf05FVqcm01V5UmEt61
 6ReSRRuCteN0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] drm/ras: Cancel and free message on get counter
 failure
To: "Raag Jadav" <raag.jadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722034228.662746-2-raag.jadav@intel.com>
References: <20260722034228.662746-1-raag.jadav@intel.com>
 <20260722034228.662746-2-raag.jadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 03:47:31 +0000
Message-Id: <20260723034731.E7C961F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing RCU read lock or refcounting causes a Use-After-Free of `d=
rm_ras_node` in netlink callbacks.
--

--- Patch [1]: [PATCH v5 1/5] drm/ras: Cancel and free message on get count=
er failure ---
commit a7d45a29dc348f6234c9ec9f5c9ccdf5d73188b7
Author: Raag Jadav <raag.jadav@intel.com>

drm/ras: Cancel and free message on get counter failure

doit_reply_value() directly returns on get counter failure, which results
in stale sk_buff and genetlink header that aren't cleaned up. Fix it and
while at it, consolidate error handling using goto.

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394c..467a169026fc1 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -201,25 +201,28 @@ static int doit_reply_value(struct genl_info *info,=
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

[Severity: High]
This is a pre-existing issue, but is there a missing RCU read lock around
these node accesses?

Since drm_ras_nl_family uses parallel_ops =3D true, callbacks execute
concurrently without the global genl_lock(). Looking at
get_node_error_counter(), it retrieves the node using xa_load() and then
dereferences it:

get_node_error_counter() {
    node =3D xa_load(&drm_ras_xa, node_id);
    if (!node || !node->query_error_counter)
        return -ENOENT;
    ...
    return node->query_error_counter(node, error_id, name, value);
}

Because xa_load() only holds the RCU read lock internally and drops it
before returning, the node pointer is unprotected here. If a driver
concurrently unregisters and frees the node memory, could this lead to a
use-after-free when the callback dereferences node->query_error_counter?

A similar issue appears to exist in drm_ras_nl_list_nodes_dumpit() where
xa_for_each_start() is used without an encompassing rcu_read_lock().

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
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722034228.6627=
46-1-raag.jadav@intel.com?part=3D1
