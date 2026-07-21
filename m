Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B2AC4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 21:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C27810EB72;
	Tue, 21 Jul 2026 21:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NMxojnEC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B2710E3C5
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 21:11:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E4479413B9;
 Tue, 21 Jul 2026 21:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9274E1F00A3A;
 Tue, 21 Jul 2026 21:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784668283;
 bh=n8T7yg5g3bUvpE3hgwpnqYxaGobKxLlckUXEn/pBazA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NMxojnEC1Pp6CbQ/7qGcJfOV9vWeDqjuqOOqfplxmP7hET9rGBXIIOApkaxIfoLNC
 kkRUqvSxKKHue7VsGUj3aRnm3zLTfP2Kd9+rkuUqq4bYpaJeE4LH/11YakR5T8j6vd
 4sgmQaXUXgZcAKTslzXAztza23EZNZDh6B2l761UnfCjTaRAOyMeAUsM5aeqx3+aqy
 PL4DhXndtSpqqlwp+tphlqi6hgxC0o7bQiZTzQvjcT2z1VzudC/CnmOgk/aOH/kEyr
 ViXp9Zp74GvL0eVjfmkkaiklQ3XCgSHYFbYblAHJ3WQLkGRCTtTNfWdu1FflkxQ0C5
 1OiFZg77TY3fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 29/29] selftests/dyndbg: enable FT_classmap_inheritance
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260721-dd-maint-2-v7-29-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
 <20260721-dd-maint-2-v7-29-010fbe73b311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 21:11:23 +0000
Message-Id: <20260721211123.9274E1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test `FT_classmap_inheritance` is broken by commenting out t=
he entire `modprobe test_dynamic_debug` command.
- [Low] Redundant and confusing double assignment to `default_hash`.
--

--- Patch [29]: [PATCH v7 29/29] selftests/dyndbg: enable FT_classmap_inher=
itance ---
commit 368562dd09d0a9983482e5b9ecbe159f50ea9ede
Author: Jim Cromie <jim.cromie@gmail.com>

selftests/dyndbg: enable FT_classmap_inheritance

This commit re-enables FT_classmap_inheritance in the dynamic debug
selftests. It also updates parameter names and syncs result checksums
to match a recent test run.

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> index 947f23dcb4ce7..49c2a79929c6f 100755
> --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

[ ... ]

> @@ -217,8 +217,10 @@ function verify_modprobe_param_logging {
> =20
>          # Verify that the resulting control-file state is completely cle=
ared
>          local hash_unset=3D$(slice_and_hash_ddctrl '\[test_dynamic_debug=
\]')
> -        local default_hash=3D"fd89900c8614f23c3a6e8a8d45aa3280"
> +
>  	# Pristine fully-disabled slice hash
> +	local default_hash=3D"fd89900c8614f23c3a6e8a8d45aa3280"
> +	default_hash=3D"d8d188e03eb33d970453c06b8f3f25a4"

[Severity: Low]
Is this double assignment to default_hash intentional? The first value is
immediately overwritten, leaving redundant dead code behind in
verify_modprobe_param_logging.

[ ... ]

> @@ -508,8 +510,8 @@ function FT_classmap_inheritance {
>      ddcmd =3D_
> =20
>      # modprobe with class enablements
> -    modprobe test_dynamic_debug \
> -	dyndbg=3Dclass,D2_CORE,+pf@class,D2_KMS,+pt@class,D2_ATOMIC,+pm
> +    #modprobe test_dynamic_debug \
> +	#dyndbg=3Dclass,D2_CORE,+pf@class,D2_KMS,+pt@class,D2_ATOMIC,+pm
> =20
>      verify_file_slice '\[test_dynamic_debug\]'

[Severity: Medium]
Does commenting out the entire modprobe command break the test? Because the
module is no longer loaded, verify_file_slice in FT_classmap_inheritance
will check an empty state.

[ ... ]

> @@ -689,6 +690,59 @@ function GOLDEN_RECORDS {
>  #K=3D da6bd1c6a299290150668186f8263b82 FT_basic_queries.4       "kernel/=
params.c"
>  #K=3D 82572e8d20c4b567afac783006d1a935 FT_basic_queries.5       "kernel/=
params.c"
>  #K=3D baea1247680e8151c121539f4b90a6d8 FT_basic_queries.6       "kernel/=
params.c"
> +#K=3D 68b329da9893e34099c7d8ad5cb9c940 FT_classmap_inheritance.1 "\[test=
_dynamic_debug\]"

[Severity: Medium]
Is it expected that this golden record in GOLDEN_RECORDS matches the MD5 ha=
sh
of an empty string (68b329da9893e34099c7d8ad5cb9c940)? This appears to
cement a broken test that asserts the module is absent rather than verifying
classmap inheritance.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dd-maint-2=
-v7-0-010fbe73b311@gmail.com?part=3D29
