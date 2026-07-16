Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F84C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D76A10E781;
	Thu, 16 Jul 2026 12:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n98UlGxV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF1210F2EE
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:51:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 788646001A;
 Thu, 16 Jul 2026 12:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083E91F000E9;
 Thu, 16 Jul 2026 12:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784206272;
 bh=ULM2iW4wj9iQ79s6IuQtd6ZxEe9dUly/0y7N9PwbUKM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n98UlGxVuPAah/nkIZHKkqiCFXPwYW9poK3Zomzt4+XyHCIEsa2oJqqaT2JpM7Kif
 jqbhnKuM4LW58AS2JbD2TR+nEURpixHJMHV/PmejUg2C3LbZrTUbY09Xsfr42YXGEc
 cTrOJ1bT0s3HJpsCPpxFGugG6VZtFBnZUp1wBoxv3t+uopLhcSrKjlEA4K7644GhDv
 meeTU6m1SZZ56y0HydGXBYrAcrt+7kfmGVeUCv0lgKSvMw4Q5LpOYEB75HDI6LcDwz
 l8PyhDX3rrxXdeJEf+J6z3reYPaaP2M241+Sjmoa2hgJ0KSyIS3tLmnr1ClZrwL/+9
 pkF82xpgk/HBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/5] driver core: platform: tests: add test cases for
 correct swnode removal
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716-swnode-remove-on-dev-unreg-v8-5-5c2b8cc38c28@oss.qualcomm.com>
References: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
 <20260716-swnode-remove-on-dev-unreg-v8-5-5c2b8cc38c28@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 12:51:11 +0000
Message-Id: <20260716125112.083E91F000E9@smtp.kernel.org>
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
- [High] Failing KUNIT_ASSERT_* macros abort the test early without unregis=
tering the platform device, leaking it and leaving dangling pointers.
- [High] Binding a test-scoped fwnode to a refcounted platform_device leads=
 to a Use-After-Free if the device outlives the test, even on the success p=
ath.
- [Low] Missing <kunit/fwnode.h> dependency causes build breakage.
--

--- Patch [5]: [PATCH v8 5/5] driver core: platform: tests: add test cases =
for correct swnode removal ---
commit 34e0068267b7ef119d11aacf8edb960ce02d5583
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

driver core: platform: tests: add test cases for correct swnode removal

This commit extends the kunit module for platform devices by adding test
cases to verify that the same software node can be added to platform devices
repeatedly.

> diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test=
/platform-device-test.c
> index 6355a2231b741..9ce563f76aad6 100644
> --- a/drivers/base/test/platform-device-test.c
> +++ b/drivers/base/test/platform-device-test.c
> @@ -1,12 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> +#include <kunit/fwnode.h>

[Severity: Low]
This include, and the kunit_software_node_register() function used later in
the test, don't seem to exist in the tree at this point.=20

Will this cause a build failure?

[ ... ]

> +static void platform_device_swnode_add_twice(struct kunit *test)
> +{
> +	struct platform_device_info pdevinfo;
> +	struct platform_device *pdev;
> +	struct fwnode_handle *fwnode;
> +	bool bound =3D false;
> +	int ret;
> +
> +	fwnode =3D kunit_kzalloc(test, sizeof(*fwnode), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
> +
> +	ret =3D kunit_platform_driver_register(test, &platform_swnode_test_driv=
er);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fwnode_init(fwnode, NULL);
> +	pdevinfo =3D (struct platform_device_info){
> +		.name =3D DEVICE_NAME,
> +		.id =3D PLATFORM_DEVID_NONE,
> +		.fwnode =3D fwnode,
> +		.swnode =3D &platform_device_test_swnode,
> +	};
> +
> +	pdev =3D platform_device_register_full(&pdevinfo);

[Severity: High]
Since the fwnode is allocated with kunit_kzalloc(), its lifetime is tied
strictly to the test execution. However, platform devices are refcounted, a=
nd
platform_device_unregister() only drops a reference count.

If the final platform_device_release() is delayed (for example, by external
subsystems holding references), and the test finishes in the meantime, the
fwnode memory will be freed early.=20

When the delayed release finally executes, it checks
is_software_node(dev_fwnode(dev)). Does this result in a use-after-free on
the kunit-managed fwnode pointer?

> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +	wait_for_device_probe();
> +	scoped_guard(device, &pdev->dev)
> +		bound =3D device_is_bound(&pdev->dev);
> +
> +	KUNIT_ASSERT_TRUE(test, bound);

[Severity: High]
If this assertion fails, KUNIT_ASSERT_TRUE will abort the test immediately =
and
skip the subsequent platform_device_unregister(pdev) call.

Since the platform device was registered globally, does an assertion failure
here permanently leak the device and leave it pointing to test-scoped memory
after the test exits?

[ ... ]

> +static void platform_device_two_swnodes(struct kunit *test)
> +{
> +	static const struct property_entry properties[] =3D {
> +		PROPERTY_ENTRY_U32("foo", 42),
> +		{ }
> +	};
> +
> +	struct platform_device_info pdevinfo;
> +	struct platform_device *pdev;
> +	struct fwnode_handle *fwnode;
> +	int ret;
> +
> +	ret =3D kunit_platform_driver_register(test, &platform_swnode_test_driv=
er);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fwnode =3D kunit_software_node_register(test, &platform_device_test_swn=
ode);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
> +
> +	pdevinfo =3D (struct platform_device_info){
> +		.name =3D DEVICE_NAME,
> +		.id =3D PLATFORM_DEVID_NONE,
> +		.fwnode =3D fwnode,
> +		.swnode =3D &platform_device_test_swnode,
> +	};
> +
> +	pdev =3D platform_device_register_full(&pdevinfo);
> +	KUNIT_ASSERT_TRUE(test, IS_ERR(pdev));

[Severity: High]
If the invalid device registration surprisingly succeeds, this assertion wi=
ll
fail and abort the test without unregistering the newly created device.

Could this permanently leak the platform device if the test fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-swnode-rem=
ove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com?part=3D5
