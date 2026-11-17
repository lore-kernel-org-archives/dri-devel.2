Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63789606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRNJpT6n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB94810E577;
	Tue, 17 Nov 2026 13:33:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6668010E577
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:33:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D4E5605FF;
 Tue, 17 Nov 2026 13:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF801F000C4;
 Tue, 17 Nov 2026 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794922428;
 bh=sQci8fzg9/W/FSNsMklQmdlz69zG/Vmgg7GDCI5lbf4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CRNJpT6n5Jrivo4cHxaQBu51PO15iItl3rPq1h8MKq3KwraUQr3CgCB+L2echStR3
 qVThpc84xpuUkBbFGLaEF12ZoXftNdLgkkygYSIMrV/diOjx9Ie9SOR4+ooAB/OpK2
 n1IPYcT2krH9yJi/S6wCJ3pfgScbD+hRmwuoj4KkAVSZQKQ23ICiaHNarvmwoWkCoE
 lIWf9WboesT67mn6lbIhBZoaiLr7iltWqwuxx5NQwikQY+hpp3/vkflnk2DQiXmeAw
 L/GNLOB2WWtT7FR0EcXbKD8YbXrQcUOh4DrnA67u0pABTIDvVL/tzBmkBbTjCY04pF
 LiWXr9c/d04jQ==
Message-ID: <sashiko-outbox-218882@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] selftests: cgroup: Add dmem selftest coverage
To: "Albert Esteve" <aesteve@redhat.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
In-Reply-To: <20261117-kunit_cgroups-v7-3-5bcbfe17f323@redhat.com>
References: <20261117-kunit_cgroups-v7-0-5bcbfe17f323@redhat.com>
 <20261117-kunit_cgroups-v7-3-5bcbfe17f323@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:33:47 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests: cgroup: test_dmem always skips under kselftest
  runner
--

commit b1601ac573b3434d7a724ddf07cd272e92c72579
Author: Albert Esteve <aesteve@redhat.com>

selftests: cgroup: Add dmem selftest coverage

This commit adds the test_dmem selftest to verify dmem.max enforcement and
byte-granularity accounting using the dmem_selftest kernel module.

> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/self=
tests/cgroup/Makefile
> index a08661320a07c..d01e8eb1ead2d 100644
> --- a/tools/testing/selftests/cgroup/Makefile
> +++ b/tools/testing/selftests/cgroup/Makefile
> @@ -11,6 +11,7 @@ TEST_GEN_MODS_DIR :=3D test_modules
>  TEST_GEN_PROGS  =3D test_core
>  TEST_GEN_PROGS +=3D test_cpu
>  TEST_GEN_PROGS +=3D test_cpuset
> +TEST_GEN_PROGS +=3D test_dmem
>  TEST_GEN_PROGS +=3D test_freezer
>  TEST_GEN_PROGS +=3D test_hugetlb_memcg
>  TEST_GEN_PROGS +=3D test_kill
[ ... ]
> diff --git a/tools/testing/selftests/cgroup/test_dmem.c b/tools/testing/s=
elftests/cgroup/test_dmem.c
> new file mode 100644
> index 0000000000000..3793664678b91
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/test_dmem.c
[ ... ]
> +int main(int argc, char **argv)
> +{
> +	char root[PATH_MAX];
> +	struct stat st;
> +	int i;
> +
> +	ksft_print_header();
> +
> +	if (cg_find_unified_root(root, sizeof(root), NULL))
> +		ksft_exit_skip("cgroup v2 isn't mounted\n");
> +
> +	if (cg_read_strstr(root, "cgroup.controllers", "dmem"))
> +		ksft_exit_skip("dmem controller isn't available (CONFIG_CGROUP_DMEM?)\=
n");
> +
> +	if (cg_read_strstr(root, "cgroup.subtree_control", "dmem"))
> +		if (cg_write(root, "cgroup.subtree_control", "+dmem"))
> +			ksft_exit_skip("Failed to enable dmem controller\n");
> +
> +	if (stat(DM_SELFTEST_ALLOC, &st) < 0)
> +		ksft_exit_skip(
> +			"dmem_selftest helper not loaded (insmod test_modules/dmem_selftest.k=
o)\n");

[Severity: Medium]
Will test_dmem always be skipped when run via the standard kselftest runner
(make run_tests or run_kselftest.sh)?

The kselftest framework builds and installs modules in TEST_GEN_MODS_DIR,
but runner.sh executes TEST_GEN_PROGS directly without loading those
modules first.  Unless test_dmem loads and unloads
test_modules/dmem_selftest.ko itself (for example via finit_module() and
delete_module()) or is invoked through a wrapper script in TEST_PROGS,
automated kselftest runs will never execute these tests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-kunit_cgro=
ups-v7-0-5bcbfe17f323@redhat.com?part=3D3
