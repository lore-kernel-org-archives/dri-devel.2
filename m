Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A99606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZLy7HF7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD141123DE;
	Thu, 12 Nov 2026 23:34:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4B51123DE
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:34:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5DEB1611BF;
 Thu, 12 Nov 2026 23:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CD71F000C4;
 Thu, 12 Nov 2026 23:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794526491;
 bh=oIG02DLJRy1ZX1/hmkj/Su1rL83RTzhmamFMnW4VSPw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jZLy7HF7ypKS4MDFuKRGlCoBLdBSw2AAn9pOOFDBXd0JeQ/8kMmOYPqyX7hWdxwYW
 Xo3xUxbuibcHxxgy8SKcrI8szD2FIjAL1zHb/P37ZuV4qTNIuC4TNNLWbRaqRW0vEG
 57okECjMRfKYG8e2tuYqcl1XKKv76ZhpNhhqHcMPNjrHa3B3X53q01xoIBYJ3GAjIf
 1OtwuNZQWTHeJVsNSRTjw0FYZCzMo8VHP4N6zlg09KSaXNMV1bs30IOGSQZJ0iuOOp
 gXc2w8Ae56Gule9wNMrppjK3bjvv9Lvf5BdfpIQRHDFYg5jijTivNEGLGjJZ0Wt3WZ
 mr0wliTefq8Kg==
Message-ID: <sashiko-outbox-211957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 13/13] drm/powervr_sgx: Add KUnit tests
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-13-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-13-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:34:50 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/powervr_sgx: link failure when DRM_POWERVR_SGX=3Dy and
  KUnit tests are =3Dm
- [Low] drm/powervr_sgx: missing KUnit cleanup action in
  equiv_test_sgx545()
--

commit 051430874fcdb70b3619ecd6aa282acde598440c
Author: Joseph Telaak <joseph@telaak.dev>

drm/powervr_sgx: Add KUnit tests

This commit adds KUnit test suites for the PowerVR SGX driver covering
firmware parsing, kernel-object teardown, the core table, register and
firmware structure equivalence on SGX545, the CCB ring, render-target
tiling, the USSE validator, and PRIME cache ranges.

> diff --git a/drivers/gpu/drm/powervr_sgx/Kconfig b/drivers/gpu/drm/powerv=
r_sgx/Kconfig
> index dbbba1d68bc69..6c880ffef5dbc 100644
> --- a/drivers/gpu/drm/powervr_sgx/Kconfig
> +++ b/drivers/gpu/drm/powervr_sgx/Kconfig
> @@ -47,3 +47,19 @@ config DRM_POWERVR_SGX_OF
>  	  bring-up. Dma-buf import isn't supported on ARM yet.
> =20
>  	  Say N unless this kernel is for such an SoC.
> +
> +config DRM_POWERVR_SGX_KUNIT_TEST
> +	tristate "KUnit tests for the PowerVR SGX5xx driver" if !KUNIT_ALL_TESTS
> +	depends on DRM_POWERVR_SGX && KUNIT
> +	select DRM_KUNIT_TEST_HELPERS
> +	default KUNIT_ALL_TESTS

[Severity: Medium]
Can vmlinux fail to link when CONFIG_DRM_POWERVR_SGX=3Dy and
CONFIG_DRM_POWERVR_SGX_KUNIT_TEST=3Dm?

The driver's .c files include the test sources under
#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_KUNIT_TEST), which evaluates to true
for =3Dm as well as =3Dy.  When DRM_POWERVR_SGX is built-in and
DRM_POWERVR_SGX_KUNIT_TEST=3Dm (for instance with CONFIG_KUNIT=3Dm and
CONFIG_KUNIT_ALL_TESTS=3Dm), the tests are compiled into the built-in driver
objects while kunit and drm_kunit_helpers are built as loadable modules,
leaving undefined references to symbols such as
drm_kunit_helper_alloc_device() and kunit_vm_mmap().

Since the tests are compiled directly into the driver rather than as a
separate module, making DRM_POWERVR_SGX_KUNIT_TEST a bool that depends on
DRM_POWERVR_SGX && KUNIT && (DRM_POWERVR_SGX=3Dm || KUNIT=3Dy) would avoid
this.

> diff --git a/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_equiv_test.c b/driv=
ers/gpu/drm/powervr_sgx/tests/pvrsgx_equiv_test.c
> new file mode 100644
> index 0000000000000..aa10ee3d37b21
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_equiv_test.c

[ ... ]

> +static struct eq_fx *eq_device(struct kunit *test, unsigned int core, u3=
2 core_rev)
> +{

[ ... ]

> +	INIT_WORK(&sdev->reap_work, eq_noop_work);
> +	/* The restart path queues the reap; the real driver's own workqueue is=
n't set up here. */
> +	sdev->wq =3D system_dfl_wq;
> +	sdev->free_wq =3D system_dfl_wq;
> +	sdev->irq =3D -1;
> +	sdev->regs =3D (void __iomem __force *)fx->regs;
> +
> +	sdev->family =3D pvrsgx_core_family_get(core);
> +	KUNIT_ASSERT_NOT_NULL(test, sdev->family);
> +	sdev->cr =3D sdev->family->regs;
> +	sdev->core_id =3D sdev->family->core_id;
> +	sdev->core_rev =3D core_rev;
> +	sdev->core =3D pvrsgx_core_lookup(sdev->family, sdev->core_id, sdev->co=
re_rev);
> +	KUNIT_ASSERT_NOT_NULL(test, sdev->core);
> +
> +	sdev->kernel_mmu =3D pvrsgx_mmu_create(sdev);
> +	sdev->idle_mmu =3D pvrsgx_mmu_create(sdev);
> +	sdev->reset_mmu =3D pvrsgx_mmu_create(sdev);
> +	sdev->reset_page =3D alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_DMA32);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sdev->kernel_mmu);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sdev->idle_mmu);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sdev->reset_mmu);
> +	KUNIT_ASSERT_NOT_NULL(test, sdev->reset_page);

[ ... ]

> +static void eq_fini(struct eq_fx *fx)
> +{
> +	struct pvrsgx_device *sdev =3D fx->sdev;
> +
> +	sdev->test_wr =3D NULL;
> +	eq_cur =3D NULL;
> +	cancel_work_sync(&sdev->reap_work);
> +	pvrsgx_ccb_inval_reap(sdev, true);
> +	pvrsgx_pb_put(sdev->pb);
> +	sdev->pb =3D NULL;
> +	pvrsgx_kobj_fini(sdev);
> +	pvrsgx_fw_fini(sdev);
> +	__free_page(sdev->reset_page);
> +	pvrsgx_mmu_destroy(sdev->reset_mmu);
> +	pvrsgx_mmu_destroy(sdev->idle_mmu);
> +	pvrsgx_mmu_destroy(sdev->kernel_mmu);
> +	mutex_destroy(&sdev->pb_lock);
> +	mutex_destroy(&sdev->done_lock);
> +	mutex_destroy(&sdev->ccb_lock);
> +}

[ ... ]

> +static void equiv_test_sgx545(struct kunit *test)
> +{

[ ... ]

> +	pvrsgx_transfer_ctx_fini(sdev, &xctx);
> +	pvrsgx_render_ctx_fini(sdev, &rctx);
> +	pvrsgx_vm_put(vm);
> +	eq_check(fx, "teardown");
> +	eq_fini(fx);
> +}

[Severity: Low]
If a KUNIT_ASSERT_* fails during eq_device() or equiv_test_sgx545(), can
skipping eq_fini() leak the unmanaged allocations and leave sdev->reap_work
queued while KUnit frees sdev?

KUNIT_ASSERT_* aborts the test immediately without reaching eq_fini() at
the end of equiv_test_sgx545().  If an assertion fails after
pvrsgx_fw_start() has queued sdev->reap_work onto system_dfl_wq, KUnit
frees sdev without cancel_work_sync(&sdev->reap_work), which can cause a
use-after-free on sdev->reap_work in the worker in addition to leaking the
MMU page tables, reset_page, and firmware arenas.  Registering cleanup via
kunit_add_action_or_reset() would ensure teardown runs on assertion
failures too.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D13
