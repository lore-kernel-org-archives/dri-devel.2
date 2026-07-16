Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD166C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2399C10E360;
	Thu, 16 Jul 2026 13:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QOmw8Y/9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4624610E360
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:02:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C9E5743D63;
 Thu, 16 Jul 2026 13:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8373A1F00A3A;
 Thu, 16 Jul 2026 13:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784206923;
 bh=3GJ7n2DMUgvfywYRkzzwMhGUrIpOzbCNFlCKtsGy3Po=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QOmw8Y/97zDK7T2tKayR6DLsQGjpp+OcYVgio45vpl0t2Yksm4LmNAv8Tu36Cv4s6
 NtKyyTC99gZ7vgJDrca/ePmrY4g05ZF2JetbC0UfLdRPRmV9BZCYAxQeowK95v8nfh
 5GhKIln+wdwOiTJQhQMRZNTzFwPtyyfn1ZqmMd3+ZMhwfZGBdsD7CtNOWHl2z4Fv1U
 cK2y44EWHhiCQ0izhVE+LP6JMrAJHNGW3mhyP2pJmL0Lm5RDmfksJNSI+VSAeQx9AN
 sOfQcuVWsHycBuDECRU437eCtoO7eKqiMH3S9R7vTJ7ZihYrWwt9Osar1v8HIuqu8s
 u88EXNtFOhDZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] driver core: platform: unify release path
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716-swnode-remove-on-dev-unreg-v8-4-5c2b8cc38c28@oss.qualcomm.com>
References: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
 <20260716-swnode-remove-on-dev-unreg-v8-4-5c2b8cc38c28@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:02:03 +0000
Message-Id: <20260716130203.8373A1F00A3A@smtp.kernel.org>
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
- [High] Dereferencing a freed primary software node during platform device=
 release, leading to a Use-After-Free and possible double-put.
--

--- Patch [4]: [PATCH v8 4/5] driver core: platform: unify release path ---
commit a4c9de720c7986b23ccb07ee951d4a99f15666ec
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

driver core: platform: unify release path

With no drivers that manually assign software nodes to platform devices
created with platform_device_alloc(), we can now unify the release path
and remove platform_device_release_full().

> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index fb57d487a6c2a..66f9ec73d47e9 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c

[ ... ]

> @@ -599,19 +599,19 @@ static void platform_device_release(struct device *=
dev)
>  	struct platform_object *pa =3D container_of(dev, struct platform_object,
>  						  pdev.dev);
> =20
> -	fwnode_handle_put(pa->pdev.dev.fwnode);
> +	device_remove_software_node(dev);
> +	/*
> +	 * If the primary firmware node is a software node, its reference count
> +	 * was already decreased by the call to device_remove_software_node().
> +	 */
> +	if (!is_software_node(dev_fwnode(dev)))

[Severity: High]
Does this check result in a use-after-free of the primary software node?

If a platform device is registered with a primary software node (for example
via platform_device_register_full()), dev->fwnode points to it.

During device release, device_remove_software_node() retrieves the primary
software node and drops the reference, potentially freeing the node:

device_remove_software_node()
   swnode_put(swnode);

Because dev->fwnode is primary, set_secondary_fwnode(dev, NULL) inside
device_remove_software_node() only clears the secondary pointer, leaving
dev->fwnode still pointing to the freed primary node.

The subsequent call to is_software_node(dev_fwnode(dev)) would then
dereference this dangling pointer.

> +		fwnode_handle_put(pa->pdev.dev.fwnode);
>  	kfree(pa->pdev.dev.platform_data);
>  	kfree(pa->pdev.mfd_cell);
>  	kfree(pa->pdev.resource);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-swnode-rem=
ove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com?part=3D4
