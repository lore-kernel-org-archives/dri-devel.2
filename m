Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282C6CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5566D10EC0B;
	Thu, 15 Oct 2026 14:37:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD898112337
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:37:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B24F40633;
 Thu, 15 Oct 2026 14:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051111F000C5;
 Thu, 15 Oct 2026 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792075047;
 bh=06OT1wTQBbyf2GdT02ERlqkHBw85A0TFhd9h4BfYfqU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Kpi+OJKPPhcBw969SG0brvrxt+qjWiq6kDf15jj0UxlzkZ5LgPOUPU6/oRJdLsoM+
 zpODMEsUSU+ObCFyiOAHSH+6QjVrPtP3+oEAtOYUfp4Qjgg5NWHIFB5yhyRIhkHKhX
 fjUqxwURHJgCi9+ev2W22Nm7VQ+wPbckJSuD+WkyVit5AFCifSugOtO76otkyQaaFm
 wvYxmZjgC6b5g6zJOtcaGEbKfpIAHIiCbZxR5Cra+zYgXx9o8Gfcm8ZcjwFmzyBhet
 sX+vuv1u33mwohjq4MSaNL0MG0gWJJCnzIpwqJoxwcm2WpU6jMAkaino/dn79y/upu
 uk4qcfQAWwBEw==
Message-ID: <sashiko-outbox-172966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/15] misc/arm-cla: Probe firmware-described
 devices
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20261015142552.4128028-5-ryan.roberts@arm.com>
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:37:26 +0000
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
- [Medium] core: mixed goto-based error handling and scoped_guard in cla_mo=
dule_init()
--

commit 0ee32d948034264a0bab6422d831ac58dbde58cd
Author: Jean-Philippe Brucker <jpb@kernel.org>

misc/arm-cla: Probe firmware-described devices

This commit discovers and instantiates CLA devices described by firmware=20
using platform_driver_probe. It also adds topology grouping for domains and=
=20
registers CPU hotplug callbacks to manage hardware setup per CLA-local CPU.

> diff --git a/drivers/misc/arm-cla/cla-init.c b/drivers/misc/arm-cla/cla-i=
nit.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/misc/arm-cla/cla-init.c
[ ... ]
> +static int __init cla_module_init(void)
> +{
> +	bool driver_registered =3D false;
> +	int ret;
> +
> +	/*
> +	 * For now, we reject any CLAs discovered via FW tables, whose CPU is
> +	 * offline during init. This keeps things simple by allowing us to probe
> +	 * all HW at init time. Keep the online CPU set stable so that the
> +	 * cpu_online() check in cla_probe() is consistent with the online cpus
> +	 * when we call cpuhp_setup_state().
> +	 */
> +	scoped_guard(cpus_read_lock) {
> +		/*
> +		 * CPUs may be hotplugged, but all CLAs are described by
> +		 * firmware so the probe can be synchronous. This only sets up
> +		 * the resources, and CPUHP callbacks do the actual peeking and
> +		 * poking. This returns an error when no CLA has an online CPU.
> +		 */
> +		ret =3D platform_driver_probe(&cla_driver, cla_probe);
> +		if (ret) {
> +			if (ret !=3D -ENODEV)
> +				pr_err("arm-cla: probe failed with %d\n", ret);
> +			/* Some domains may have been created during probe. */
> +			goto err_hardware;

[Severity: Medium]
The function cla_module_init() uses a scoped_guard(cpus_read_lock) block wh=
ile
also jumping to a manual err_hardware cleanup label.

According to the cleanup and guard subsystem guidelines in
include/linux/cleanup.h, mixing goto-based error handling with scope-based
cleanups in the same function is considered an anti-pattern. This creates
confusing ownership semantics and risks double-frees or resource leaks duri=
ng
future refactoring.=20

Could this function be refactored to consistently use either only scope-bas=
ed
cleanup or only goto-based error handling?

> +		}
[ ... ]
> +
> +err_hardware:
> +	if (cla_cpuhp_state >=3D 0)
> +		cpuhp_remove_state(cla_cpuhp_state);
> +	cla_domains_free();
> +	if (driver_registered)
> +		platform_driver_unregister(&cla_driver);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015142552.4128=
028-1-ryan.roberts@arm.com?part=3D4
