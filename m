Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA577C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1054310F432;
	Thu, 24 Sep 2026 10:19:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="op929JW8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8EE610F432
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:19:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D927601FE;
 Thu, 24 Sep 2026 10:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815D81F00893;
 Thu, 24 Sep 2026 10:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790245169;
 bh=TZslcpdo8LVVv3KbnajTDG7QpxpY21058xGr23nNR2c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=op929JW8pk9V5xSSCBj3gfmqtlijbYSWaxW513KiSTtRacPj1L8UEhBSLMveUf7gL
 LG0aBPKNX7J4qsM32U7/3KgP3cIocClNcODYZIIGKCCVPLAir5lh/mYjaAVOOBmPnf
 CP06/w5i8JG0KTLfjrDj8Rkj3/AIC0iH3SWHc7rxN+fGxNpnegr9lnfZXcmW0GK1M6
 u7bH/jj0bD7wz25vY9GS41ErHT1Y+BR3IOdP1qV+E915X0QwP40G6SNxJEOKeD8GL1
 x8el1RPq1DrXU95xP6tEZJj9k/xv9I4hHnIwwBaQVEeFooSCHRsLX8xEf2QLRYKlYr
 TsZbAfI51bzbQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v8 03/14] irqchip/gic-v3-its: Resolve the default
 NUMA node explicitly
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: media-ci@linuxtv.org, kvmarm@lists.linux.dev,
 "Oliver Upton" <oupton@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260924100529.1398790-4-aneesh.kumar@kernel.org>
References: <20260924100529.1398790-1-aneesh.kumar@kernel.org>
 <20260924100529.1398790-4-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:19:28 +0000
Message-Id: <20260924101929.815D81F00893@smtp.kernel.org>
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
- [Medium] irqchip/gic-v3-its: incomplete NUMA_NO_NODE resolution exposes a=
llocations to task mempolicy
--

commit 6d762ab83972132164ae57c1422f1916decb2fe3
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

    irqchip/gic-v3-its: Resolve the default NUMA node explicitly
   =20
    alloc_pages_node() resolves NUMA_NO_NODE to numa_mem_id() internally. In
    preparation for switching ITS allocations to the CoCo shared memory
    allocator, resolve the default node explicitly in its_alloc_pages().
   =20
    The CoCo shared memory allocator interprets NUMA_NO_NODE as a request to
    apply the current task's memory policy. Passing numa_mem_id() instead
    preserves the existing nearest-memory-node placement across the
    allocator switch. This patch does not change the current allocation
    behavior.

> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v=
3-its.c
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -236,7 +237,7 @@ static struct page *its_alloc_pages_node(int node, gf=
p_t gfp,
> =20
>  static struct page *its_alloc_pages(gfp_t gfp, unsigned int order)
>  {
> -	return its_alloc_pages_node(NUMA_NO_NODE, gfp, order);
> +	return its_alloc_pages_node(numa_mem_id(), gfp, order);
>  }

[Severity: Medium]
Will this leave other callers of its_alloc_pages_node() exposed to the
task memory policy change?

When a device probe or ITT allocation occurs with its->numa_node =3D=3D
NUMA_NO_NODE (which is common when firmware lacks NUMA info), callers pass
NUMA_NO_NODE directly to its_alloc_pages_node():

drivers/irqchip/irq-gic-v3-its.c:its_alloc_pages_node() {
	...
	page =3D alloc_pages_node(node, gfp | gfp_flags_quirk, order);
	...
}

If node is NUMA_NO_NODE, it passes it directly to the underlying allocator.
When the underlying allocator interprets NUMA_NO_NODE as a request to apply
task mempolicy, these direct callers will be subjected to the current task's
memory policy instead of bypassing it and using the local node.=20

If a user binds the driver via sysfs under a restrictive task mempolicy,
the allocations could land on suboptimal distant nodes or fail entirely.

Should the NUMA_NO_NODE resolution logic be moved inside its_alloc_pages_no=
de()
to ensure all callers are protected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924100529.1398=
790-1-aneesh.kumar@kernel.org?part=3D3
