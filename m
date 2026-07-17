Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2A5C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C2910F508;
	Fri, 17 Jul 2026 10:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T4rT4ISO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F3F10F508
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:57:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84B1C60A69;
 Fri, 17 Jul 2026 10:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172911F000E9;
 Fri, 17 Jul 2026 10:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784285829;
 bh=/0SGcv6mlRG9f3AjHiEtNJObj9UuQLL0pzQjYeJFAPc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T4rT4ISOPJiPdyL4JBhmek20nChXXsDPGoM7t2LE3VnUeGhaaftldkW6qJHuEQ9oz
 Xj/SJQQpOEiOfg1H8CqNY2c25KBr2poGyK9Z7QumnSXBFshdCz1aUcthgzJ120hMSS
 mqSayu8neurIrJzeLguX1MmJbK+Uq9RJm9JRvCIUitAPT++7Iv8Bc+XhbjMrRO+G6G
 7fAFiGrZQxMDX5tNV3URnEvQtS9Ws0q+bfnrDkyG0hkmrNMyWg5I+6kzexeSGbbO7p
 3ncX+NIzgm95N6B8y3mzG0y2opGCONm1b+9agqORqNhRH1nKQptZ1MTw90XS6gnyf8
 jt8bzPmxFcGgw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 3/8] misc/arm-cla: Probe firmware-described devices
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717104759.123203-4-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 10:57:08 +0000
Message-Id: <20260717105709.172911F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Improper handling of `krealloc_array()` failure in `cla_dev_domain=
_get()` overwrites the array pointer with NULL, causing a memory leak and s=
ubsequent NULL pointer dereference.
- [High] Missing `platform_driver_unregister()` on the `cla_domains_finalis=
e()` error path leaves the driver registered, leading to a Use-After-Free.
- [Medium] Integer overflow when calculating `cla_nr_domains` causes lookup=
 tables to remain unpopulated, silently breaking device initialization.
--

--- Patch [3]: [RFC PATCH v1 3/8] misc/arm-cla: Probe firmware-described de=
vices ---
commit f4618493e3d162e6d466cff0e6d759171e5655f5
Author: Jean-Philippe Brucker <jpb@kernel.org>

misc/arm-cla: Probe firmware-described devices

Discover CLA devices from firmware and instantiate the driver with
platform_driver_probe(). Map the MMIO frame, select the kernel-accessible
privilege-level frame and associate each CLA with the CPU named by firmware.

> diff --git a/drivers/misc/arm-cla/cla-init.c b/drivers/misc/arm-cla/cla-i=
nit.c
> --- a/drivers/misc/arm-cla/cla-init.c
> +++ b/drivers/misc/arm-cla/cla-init.c

[ ... ]

>  	ret =3D platform_driver_probe(&cla_driver, cla_probe);
>  	if (ret) {
>  		if (ret !=3D -ENODEV)
>  			pr_err("arm-cla: probe failed with %d\n", ret);
>  		/* Some domains may have been created during probe */
>  		goto err_domains_free;
>  	}
> =20
>  	ret =3D cla_domains_finalise();
>  	if (ret) {
>  		pr_err("arm-cla: failed to finalise domains: %d", ret);
>  		goto err_domains_free;

[Severity: High]
If cla_domains_finalise() fails, this jumps to err_domains_free, which skips
platform_driver_unregister(). Will this leave dangling pointers to the freed
cla_driver struct on the platform bus?

>  	}
> =20
>  	/*
>  	 * Each CPU initializes their own CLA. CPUHP uses a pair of smp_mb()
>  	 * when calling the startup callback, ensuring that cla_dev_setup()
>  	 * reads fully initialized cla_lut_cpu and cla_dev structures.
>  	 */
>  	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm-cla",
>  				cla_dev_setup, cla_dev_teardown);
>  	if (ret < 0) {
>  		pr_err("arm-cla: failed to setup cpuhp: %d", ret);
>  		goto err_driver_unregister;
>  	}
>  	cla_cpuhp_state =3D ret;
> =20
>  	return 0;
> =20
>  err_driver_unregister:
>  	platform_driver_unregister(&cla_driver);
>  err_domains_free:
>  	cla_domains_free();
>  	return ret;
>  }

[ ... ]

> diff --git a/drivers/misc/arm-cla/cla-topology.c b/drivers/misc/arm-cla/c=
la-topology.c
> --- /dev/null
> +++ b/drivers/misc/arm-cla/cla-topology.c

[ ... ]

> +struct cla_domain *cla_dev_domain_get(struct cla_dev *dev)
> +{
> +	int ret;
> +	unsigned int domain_id;
> +	struct cla_domain *domain;
> +
> +	/* Domain ID is provided by firmware */
> +	ret =3D of_property_read_u32(dev->dev->of_node, "domain", &domain_id);
> +	if (WARN_ON(ret))
> +		return ERR_PTR(-EINVAL);
> +
> +	domain =3D xa_load(&cla_domains, domain_id);
> +	if (domain) {
> +		domain->nr_devs++;
> +		domain->devs =3D krealloc_array(domain->devs, domain->nr_devs,
> +					      sizeof(*domain->devs), GFP_KERNEL);

[Severity: High]
Does this code leak the original domain->devs array if krealloc_array() fai=
ls
and returns NULL? Also, since domain->nr_devs was unconditionally increment=
ed,
will a subsequent call to cla_domains_finalise() dereference the NULL
pointer at domain->devs[j]?

> +		if (!domain->devs)
> +			return ERR_PTR(-ENOMEM);
> +		domain->devs[domain->nr_devs - 1] =3D dev;
> +		return domain;
> +	}
> +
> +	domain =3D cla_domain_alloc(dev, domain_id);
> +	if (IS_ERR(domain))
> +		return domain;
> +
> +	cla_nr_domains =3D max(domain_id + 1, cla_nr_domains);

[Severity: Medium]
Can this calculation overflow to 0 if firmware provides a domain_id of
UINT_MAX? If it overflows, will cla_domains_finalise() skip its loop and
leave the device uninitialized in the lookup tables?

> +
> +	return domain;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717104759.1232=
03-1-ryan.roberts@arm.com?part=3D3
