Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF74C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5060B10E336;
	Thu, 16 Jul 2026 12:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ux/c8NAo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C1D10E336
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:39:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E272F40131;
 Thu, 16 Jul 2026 12:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59DE1F00A3A;
 Thu, 16 Jul 2026 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784205567;
 bh=MPuyxPHae0+oUWc2GEFndDyueIkDT2PvUAcnMN3JsV4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ux/c8NAoGQbLDA7xpiUsUHeTZq+9weQK94uDGvs3sXjrJ3rb2d9irpvX7Oke72az7
 oVLtbJSK+mUfGBq6Pgf+02UDlDDpXLYgWrXYmjm5YsPjkqSHkI2e9toZFiW3wjx5b/
 5pvjV8AGbbLZ3BJeKdOuyKbs+dfWYlEH+KOEdwoCnxGxJjrAf5FCEstG8JaoNESqvU
 pzu4HxJ03ISzCZ+A9GzZ1vlSChqTTGGW85DUbA4433875aAqyxO+S96X4GPExny8cX
 a00C5IAqF9vW/pyjmRez81rRlmDQV1YW5+u23hzNzr9cQW+CEEl+s1I9wUbLFvwPUa
 6BUl94s/vmojA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/5] driver core: platform: amend the API contract
 for fwnode setters
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716-swnode-remove-on-dev-unreg-v8-1-5c2b8cc38c28@oss.qualcomm.com>
References: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
 <20260716-swnode-remove-on-dev-unreg-v8-1-5c2b8cc38c28@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 12:39:27 +0000
Message-Id: <20260716123927.A59DE1F00A3A@smtp.kernel.org>
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
- [Medium] The patch fails to implement its intended behavior because it us=
es `WARN_ON()` as a standalone statement without an early return. `WARN_ON(=
)` evaluates the condition and emits a warning traceback but does not halt =
or return from execution. As a result, the operation is not disallowed, and=
 execution falls through, continuing to overwrite the firmware node and lea=
ving the resource leak unaddressed.
--

--- Patch [1]: [PATCH v8 1/5] driver core: platform: amend the API contract=
 for fwnode setters ---
commit 0ad30205c2e10306a33e3a3823c155c95eca3ce4
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

driver core: platform: amend the API contract for fwnode setters

Calling platform_device_set_fwnode() for a dynamically allocated platform=20
device whose primary firmware node is already a software node leads to a=20
resource leak. This commit intends to disallow this scenario and warn loudly
if it ever occurs.

> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index a71015f1d9153..fb57d487a6c2a 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c

[ ... ]

> @@ -723,11 +725,20 @@ EXPORT_SYMBOL_GPL(platform_device_set_of_node);
>   *
>   * Assign a firmware node to this platform device. Internally keep track=
 of the
>   * reference count. Devices created with platform_device_alloc() must us=
e this
> - * function instead of assigning the node manually.
> + * function instead of assigning the node manually. This function must n=
ot be
> + * called for a platform device that already has a software node as its =
primary
> + * firmware node assigned.
>   */
>  void platform_device_set_fwnode(struct platform_device *pdev,
>  				struct fwnode_handle *fwnode)
>  {
> +	/*
> +	 * If we call this function for a platform device whose primary
> +	 * firmware node is a software node, we'll never end up calling the
> +	 * symmetric software_node_notify_remove(). There are no users for this
> +	 * right now in the tree so just disallow it.
> +	 */
> +	WARN_ON(is_software_node(dev_fwnode(&pdev->dev)));

[Severity: Medium]
Does this code actually disallow the operation?

Since WARN_ON() evaluates the condition and emits a warning but does not
return from the function, execution will fall through and still overwrite
the node, leaving the resource leak unaddressed.

Would it be better to use an early return here, such as:
if (WARN_ON(is_software_node(dev_fwnode(&pdev->dev))))
	return;

>  	fwnode_handle_put(pdev->dev.fwnode);
>  	device_set_node(&pdev->dev, fwnode_handle_get(fwnode));
>  }

[ ... ]

> @@ -739,11 +750,15 @@ EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
>   * @dev2: device whose OF node to reuse
>   *
>   * Reuses the OF node of another device in this platform device while
> - * internally keeping track of reference counting.
> + * internally keeping track of reference counting. This function must no=
t be
> + * called for a platform device that already has a software node as its =
primary
> + * firmware node assigned.
>   */
>  void platform_device_set_of_node_from_dev(struct platform_device *pdev,
>  					  const struct device *dev2)
>  {
> +	/* See platform_device_set_fwnode(). */
> +	WARN_ON(is_software_node(dev_fwnode(&pdev->dev)));

[Severity: Medium]
Similar to platform_device_set_fwnode(), does this prevent the overwrite?

A standalone WARN_ON() allows execution to continue and overwrite
pdev->dev.fwnode.

>  	device_set_of_node_from_dev(&pdev->dev, dev2);
>  	pdev->dev.fwnode =3D of_fwnode_handle(pdev->dev.of_node);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-swnode-rem=
ove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com?part=3D1
