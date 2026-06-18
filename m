Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3777CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14EB010F167;
	Thu, 18 Jun 2026 05:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T5tEwIvI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91FF410F16F
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:23:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD69C60008
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5A11F00A3A;
 Thu, 18 Jun 2026 05:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781760205;
 bh=cPAfR4QHvOXIQK3/i6GuTSJit6fDFmI9ld3QIz4yEtA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T5tEwIvIYoFQr7cMulOzqfTy+6Cea9zkER6KMp24IuS3daR0rpoM6R/Zl1oioFzV7
 6Q3QF5btavATSvmTF/iLguxeuwsK04HDebfU0Khfpx9kEd/L7+0UiQetk7yOqgL1bh
 tUFWMvL9+qtft3RdBoucdPDu/5FlEo/w95+XK8uTeSpwh6huPDXrDNZW+gnDGDqKK6
 L50zE25R7wNqG8G/TMVD5OUtM1Jnq0OYCSURVJNLnzYwT8K34cK4aNg6klmVtfGv7e
 6dcMGJBcdpGQyN4ptuPgwD34pMJ9lWA2mWMrGlUXi0/nAMO7t0v8iyS3Q6LqIqSdSB
 eAuzykrpmTRNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] regulator: db8500: Add power domain regulators
To: "Linus Walleij" <linusw@kernel.org>
Cc: devicetree@vger.kernel.org, vkoul@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:23:24 +0000
Message-Id: <20260618052325.4F5A11F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The `db8500_regulator_disable` callback incorrectly treats a retur=
n value of 1 from `pm_runtime_put_sync_suspend` as an error, causing early =
abort and state desynchronization.
- [High] Mismatched Genpd APIs (`of_genpd_add_device` paired with `dev_pm_d=
omain_detach`) lead to a silent detach failure and Use-After-Free list corr=
uption.
- [High] Embedding a `struct device` in a devres-managed structure (`devm_k=
zalloc`) with an empty release function causes a lifecycle violation and Us=
e-After-Free.
- [High] The virtual device is never fully registered with `device_add()`, =
leading to a memory leak of PM QoS constraints.
- [High] The driver saves an OF node pointer to the persistent device struc=
ture without incrementing its reference count, risking a dangling pointer.
--

commit abd72295748300bd01e4a7216b2321ff24b1a38f
Author: Linus Walleij <linusw@kernel.org>

regulator: db8500: Add power domain regulators

Add a DB8500 regulator driver for the VAPE and VSMPS2 compatibility nodes,
backing the regulator enable state with corresponding power domains.

> diff --git a/drivers/regulator/db8500-regulator.c b/drivers/regulator/db8=
500-regulator.c
> new file mode 100644
> index 0000000000000..c5a9a1baaf8ea
> --- /dev/null
> +++ b/drivers/regulator/db8500-regulator.c
[ ... ]
> +static int db8500_regulator_disable(struct regulator_dev *rdev)
> +{
> +	struct db8500_regulator_info *info =3D rdev_get_drvdata(rdev);
> +	int ret;
> +
> +	ret =3D pm_runtime_put_sync_suspend(&info->pd_dev);
> +	if (ret)
> +		return ret;

[Severity: High]
Does this propagate a success status as an error?

According to the PM subsystem rules, pm_runtime_put_sync_suspend() returns 1
when the device is already in the RPM_SUSPENDED state. Since this checks
if (ret) and returns it, won't the regulator core treat this as a failure,
aborting the disable operation and leaving the regulator's use_count and
enable_count out of sync?

[ ... ]
> +static void db8500_regulator_release(struct device *dev)
> +{
> +}

[Severity: High]
Does this empty release function circumvent kobject lifecycle tracking?

The struct device is embedded in devres memory allocated via devm_kzalloc().
Since put_device() does not guarantee synchronous memory reclamation, will
devres forcibly free the memory when the driver unbinds, creating a
use-after-free for any subsystem still holding a reference to pd_dev?

> +
> +static void db8500_regulator_cleanup(void *data)
> +{
> +	struct db8500_regulator_info *info =3D data;
> +
> +	pm_runtime_disable(&info->pd_dev);
> +	dev_pm_domain_detach(&info->pd_dev, true);

[Severity: High]
Will this detach silently fail?

The device is attached using of_genpd_add_device(), which adds it to
genpd->dev_list but does not populate the dev->pm_domain->detach callback.

Since dev_pm_domain_detach() checks for that callback, won't it be a no-op,
leaving the device in the genpd active lists when freed and causing a
use-after-free?

Should this use pm_genpd_remove_device() instead?

> +	put_device(&info->pd_dev);
> +}
[ ... ]
> +static int db8500_regulator_register(struct platform_device *pdev,
> +				     struct device_node *np)
> +{
[ ... ]
> +	info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	device_initialize(&info->pd_dev);
> +	info->pd_dev.parent =3D &pdev->dev;
> +	info->pd_dev.of_node =3D np;

[Severity: High]
Could this leave a dangling pointer in info->pd_dev.of_node?

The np pointer is provided by for_each_available_child_of_node() in
db8500_regulator_probe(), which automatically drops the reference on the
node when advancing the loop.

Since of_node_get() isn't used here to increment the reference count, will
the reference be dropped when the loop concludes?

> +	info->pd_dev.release =3D db8500_regulator_release;
> +	ret =3D dev_set_name(&info->pd_dev, "%s-pd", match->name);
> +	if (ret)
> +		goto put_device;
> +
> +	ret =3D of_parse_phandle_with_args(np, "power-domains", cells, 0, &pd_a=
rgs);
> +	if (ret)
> +		goto put_device;
> +
> +	ret =3D of_genpd_add_device(&pd_args, &info->pd_dev);

[Severity: High]
Does this leak PM QoS constraints?

The device is initialized with device_initialize() but never fully register=
ed
with device_add().

Since of_genpd_add_device() automatically registers a resume latency QoS
notifier that dynamically allocates PM QoS constraint structures, and those
are normally freed by device_del(), will these structures leak upon cleanup
because device_del() is never called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D10
