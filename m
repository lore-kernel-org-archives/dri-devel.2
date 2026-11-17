Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDD606A335
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMkWyT7V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D2F10E403;
	Tue, 17 Nov 2026 13:46:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D1D10E403
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:46:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ABB30634E1;
 Tue, 17 Nov 2026 13:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ACC1F000CF;
 Tue, 17 Nov 2026 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794923162;
 bh=n83/iJYoTIdCBGnePGGOtYa0kVUJd900GADw7+Lu+IA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SMkWyT7VjtsthMVl0zeIL8XJExTjwmUt0oTdrhvDxsUg9DhvTYd0WdpLoc3pzSd5y
 qk8GE24oKj/H4/UXuAZlyl93VTZm+4ZUCGy/IU951q2AVDEgsM4rpn7MqfjieW61J/
 +56CTi9gNgm9SOLo60yBCudBoDSFcOoBiz2y6Hw8jerW440nb9lNBkRs9Nlv4XlSw7
 09+IfHefrdta7TsD0RFv7x8pU7azrA/q4CmMJuKV68f4QBCA+SXOlE4PZX0Gpd4ma5
 eyUQW6sS1slP+4vOYITQdMS9XMJD5gWiVbsTOIp8vtHoGAF4Ceay6oljQQ95i7LCcd
 5c4iN8Mdv5bXQ==
Message-ID: <sashiko-outbox-218900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] selftests: cgroup: Add dmem_selftest helper module
To: "Albert Esteve" <aesteve@redhat.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
In-Reply-To: <20261117-kunit_cgroups-v7-1-5bcbfe17f323@redhat.com>
References: <20261117-kunit_cgroups-v7-0-5bcbfe17f323@redhat.com>
 <20261117-kunit_cgroups-v7-1-5bcbfe17f323@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:46:01 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] selftests: cgroup: default KDIR in test_modules/Makefile
  breaks build
- [Medium] selftests: cgroup: race on selftest_region in
  dmem_selftest_exit()
- [Medium] selftests: cgroup: ERR_PTR stored in selftest_region in
  dmem_selftest_init()
--

commit ff1dfd0d8169df4ccb406a2e9530169608e94814
Author: Albert Esteve <aesteve@redhat.com>

selftests: cgroup: Add dmem_selftest helper module

This commit adds an out-of-tree dmem_selftest kernel module under
tools/testing/selftests/cgroup/test_modules/ that registers a synthetic
dmem cgroup region and exposes alloc and free module parameters for
selftests.

> diff --git a/tools/testing/selftests/cgroup/test_modules/Makefile b/tools=
/testing/selftests/cgroup/test_modules/Makefile
> new file mode 100644
> index 0000000000000..dd8a17313cec2
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/test_modules/Makefile
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +TESTMODS_DIR :=3D $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)=
))))
> +KDIR ?=3D /lib/modules/$(shell uname -r)/build
> +
> +obj-m +=3D dmem_selftest.o
> +
> +# Ensure that KDIR exists, otherwise skip the compilation
> +modules:
> +ifneq ("$(wildcard $(KDIR))", "")
> +	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=3D$(TESTMODS_DIR)
> +endif

[Severity: Medium]
Does defaulting KDIR to /lib/modules/$(shell uname -r)/build break the
cgroup selftest build when the host's running kernel headers are older
than the target kernel tree or when cross-compiling?

Because tools/testing/selftests/cgroup/Makefile sets TEST_GEN_MODS_DIR,
the default all target invokes this Makefile unconditionally.  When
/lib/modules/$(uname -r)/build exists for an older host kernel that lacks
linux/cgroup_dmem.h or struct dmem_cgroup_init, Kbuild compiles
dmem_selftest.c against the host kernel headers instead of the tree under
test and fails the build.  In addition, checking $(wildcard $(KDIR))
without checking $(wildcard $(KDIR)/Module.symvers) does not verify that
the kernel tree has been built.

Defaulting KDIR to $(if $(O),$(O),$(realpath ../../../../..)) and
checking $(wildcard $(KDIR)/Module.symvers), as in
tools/testing/selftests/sched_ext/test_modules/Makefile, would build
against the target kernel tree when available.

[ ... ]

> diff --git a/tools/testing/selftests/cgroup/test_modules/dmem_selftest.c =
b/tools/testing/selftests/cgroup/test_modules/dmem_selftest.c
> new file mode 100644
> index 0000000000000..a763a156f13f3
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/test_modules/dmem_selftest.c
> @@ -0,0 +1,146 @@

[ ... ]

> +static struct dmem_cgroup_region *selftest_region;
> +static struct dmem_cgroup_pool_state *alloc_pool;
> +static u64 alloc_size;
> +static DEFINE_MUTEX(alloc_lock);
> +
> +static int param_set_alloc(const char *val, const struct kernel_param *k=
p)
> +{
> +	struct dmem_cgroup_pool_state *pool =3D NULL, *limit =3D NULL;
> +	u64 size;
> +	int ret;
> +
> +	if (!selftest_region)
> +		return -ENODEV;
> +
> +	ret =3D kstrtou64(val, 0, &size);
> +	if (ret)
> +		return ret;
> +	if (!size || size > DM_SELFTEST_REGION_SIZE)
> +		return -EINVAL;
> +
> +	mutex_lock(&alloc_lock);
> +	if (alloc_pool) {
> +		mutex_unlock(&alloc_lock);
> +		return -EBUSY;
> +	}
> +
> +	ret =3D dmem_cgroup_try_charge(selftest_region, size, &pool, &limit);
> +	if (ret =3D=3D -EAGAIN && limit)
> +		dmem_cgroup_pool_state_put(limit);
> +	if (ret) {
> +		mutex_unlock(&alloc_lock);
> +		return ret;
> +	}
> +
> +	alloc_pool =3D pool;
> +	alloc_size =3D size;
> +	mutex_unlock(&alloc_lock);
> +	return 0;
> +}

[ ... ]

> +static int __init dmem_selftest_init(void)
> +{
> +	static const struct dmem_cgroup_init init =3D {
> +		.size =3D DM_SELFTEST_REGION_SIZE,
> +	};
> +
> +	selftest_region =3D dmem_cgroup_register_region(&init, DM_SELFTEST_REGI=
ON_NAME);
> +	if (IS_ERR(selftest_region))
> +		return PTR_ERR(selftest_region);

[Severity: Medium]
If dmem_cgroup_register_region() returns an error pointer, can a
concurrent write to the alloc parameter dereference that ERR_PTR in
dmem_cgroup_try_charge()?

Module parameter sysfs attributes are created by mod_sysfs_setup() before
dmem_selftest_init() runs and remain accessible until do_init_module()
tears them down on error.  Storing the return value directly into
selftest_region leaves a non-NULL ERR_PTR(-ENOMEM) visible to
param_set_alloc(), which only checks !selftest_region before passing it to
dmem_cgroup_try_charge() -> get_cg_pool_unlocked().  Checking the return
value in a local variable before assigning selftest_region avoids exposing
the error pointer.

[ ... ]

> +static void __exit dmem_selftest_exit(void)
> +{
> +	mutex_lock(&alloc_lock);
> +	if (alloc_pool) {
> +		dmem_cgroup_uncharge(alloc_pool, alloc_size);
> +		alloc_pool =3D NULL;
> +		alloc_size =3D 0;
> +	}
> +	mutex_unlock(&alloc_lock);
> +
> +	if (selftest_region) {
> +		dmem_cgroup_unregister_region(selftest_region);
> +		selftest_region =3D NULL;
> +	}
> +	pr_info("unloaded.\n");
> +}

[Severity: Medium]
Can param_set_alloc() race with dmem_selftest_exit() over selftest_region
and alloc_pool?

In delete_module(), dmem_selftest_exit() runs before free_module() removes
the module parameter sysfs files, and param_attr_store() does not hold a
module reference:

CPU0                              CPU1
param_set_alloc()                 dmem_selftest_exit()
  if (!selftest_region)
                                    mutex_lock(&alloc_lock)
                                    ...
                                    mutex_unlock(&alloc_lock)
                                    dmem_cgroup_unregister_region(...)
                                    selftest_region =3D NULL
  mutex_lock(&alloc_lock)
  dmem_cgroup_try_charge(selftest_region, ...)
    get_cg_pool_unlocked(NULL, ...)  <-- NULL pointer dereference

If CPU0 instead acquires alloc_lock right after CPU1 unlocks it and before
dmem_cgroup_unregister_region() marks the region unregistered,
dmem_cgroup_try_charge() succeeds and sets alloc_pool after
dmem_selftest_exit() has already finished uncharging alloc_pool, leaking
the charge, pool state, and cgroup CSS reference.

Checking selftest_region under alloc_lock in param_set_alloc() and
detaching selftest_region under the same lock in dmem_selftest_exit()
before unregistering the region would close both races.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-kunit_cgro=
ups-v7-0-5bcbfe17f323@redhat.com?part=3D1
