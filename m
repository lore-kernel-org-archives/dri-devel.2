Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78481C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A984110E75A;
	Mon, 29 Jun 2026 08:05:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SDUoEZgl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD6C10E752
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:05:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 678854118B
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204691F00A3A;
 Mon, 29 Jun 2026 08:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782720345;
 bh=GMkYpTTPhGGAbuiyRRU5+ZRUOQtoqN+VGzaDsQecaFw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SDUoEZglTonMtiBODajPCDcOXKEVSAF2TKHumoHQl9Owlxxbz/Eg9+euQlwX6NKGe
 R1ptXu/Clk6QiejmlCEtdMVqZtZ1PPkbCedZ711agRAk02DJ9DUoWL5jjqlbj2eFnx
 wh40J9EmoIGEJfzGyBjr2f1AMiTqLoq1QYGdwDwBE0aYJDE7zger1gL5W53Wl5ibMw
 6lBp0XVMXGOWwVenFl1NXOZ4D15WWdVH0DqNpOadOBRKDWNLSHrU2qU3IpIjS7XfgV
 MdADweedK62aDsZpEJ+zVYtCfrX/Ue0g/Sw0CoFiWgeqhMM2vuVw7j0TKokyzDgRQq
 fpiD1+MabOA7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dma-buf: dma-fence: Fix potential NULL pointer
 dereference
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629075636.2513214-2-phasta@kernel.org>
References: <20260629075636.2513214-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 08:05:44 +0000
Message-Id: <20260629080545.204691F00A3A@smtp.kernel.org>
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
- [High] Replacing the signaled-bit check with an `ops` null-check causes d=
river callbacks to be executed on signaled fences, violating the dma-fence =
contract and leading to a Use-After-Free.
--

commit f3771b2534b5990287b2b373aaf5a26b9dea2923
Author: Philipp Stanner <phasta@kernel.org>

dma-buf: dma-fence: Fix potential NULL pointer dereference

The patch removes the signaled-bit check in dma_fence_timeline_name() and
dma_fence_driver_name(), replacing it with a check for a non-NULL ops point=
er
to prevent potential out-of-order execution issues.

> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index c7ea1e75d38a2..0a025dfdf131e 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1170,7 +1170,7 @@ const char __rcu *dma_fence_driver_name(struct dma_=
fence *fence)
> =20
>  	/* RCU protection is required for safe access to returned string */
>  	ops =3D rcu_dereference(fence->ops);
> -	if (!dma_fence_test_signaled_flag(fence))
> +	if (ops)

[Severity: High]
Does this expose a use-after-free for signaled fences?

If a fence has a .release or .wait callback,
dma_fence_signal_timestamp_locked() does not set fence->ops to NULL. For
those fences, ops will remain non-NULL indefinitely even after they are
signaled.

By removing the signaled-bit check, won't ops->get_driver_name(fence) be
called on signaled fences? The dma-fence contract states that backing data
can be freed after an RCU grace period once the fence is signaled, so calli=
ng
this callback could access freed memory.

>  		return (const char __rcu *)ops->get_driver_name(fence);
>  	else
>  		return (const char __rcu *)"detached-driver";
> @@ -1203,7 +1203,7 @@ const char __rcu *dma_fence_timeline_name(struct dm=
a_fence *fence)
> =20
>  	/* RCU protection is required for safe access to returned string */
>  	ops =3D rcu_dereference(fence->ops);
> -	if (!dma_fence_test_signaled_flag(fence))
> +	if (ops)

[Severity: High]
Could this lead to the same use-after-free as above?

Since ops can remain non-NULL for signaled fences that provide a .release
or .wait callback, this allows the ops callback to be executed after the
fence is signaled and its backing data is potentially freed.

>  		return (const char __rcu *)ops->get_driver_name(fence);
>  	else
>  		return (const char __rcu *)"signaled-timeline";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629075636.2513=
214-2-phasta@kernel.org?part=3D1
