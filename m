Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B501C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E6F110E004;
	Tue, 18 Aug 2026 10:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PcDV40GW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9469A10E004;
 Tue, 18 Aug 2026 10:08:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9889E601DE;
 Tue, 18 Aug 2026 10:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191811F000E9;
 Tue, 18 Aug 2026 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787047738;
 bh=yS14iiRK+G+C4SHOGrp//fJ7F9Km+55R1xhozNTy3yQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PcDV40GWq43mo3FDoHxQZw52lAWYuBcnNN6H67hd/GPQWthIAWX3GppWxM2xMg+rY
 Yuqco4MJxa1sYxGcGQrjil8lA5T/vUvAWyLLaW68DzUPECFwHb4VQmNqKeINAqgjZ2
 rjNSnpgOZ6dCpidLWS7T6npQZ95FFssligiZebXTnxqxHxSVHoCvqHUIwvXnzl9hBZ
 axsgQ9p6JDeTCZ7mKBG7/iY0vx1CMrMTwFoWyUqdb96FryQjHqjVcWX6vW5qyLdSD7
 g3wPapFOfWlrztZDfVxihGEjFG63zziP4u0Zfx7JFEWF/iT7gWbsLiATXbJzfhU5qr
 5XpOmkMOZ4kqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] drm/i915/selftests: Use drm_* prints in selftest
 headers
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260818095624.3254368-9-krzysztof.karas@intel.com>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
 <20260818095624.3254368-9-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 10:08:57 +0000
Message-Id: <20260818100858.191811F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Invalid pointer cast in `__i915_subtests()` causes type confusion =
and kernel panics when tests pass non-i915 context objects.
- [Low] The `run_selftests` macro calls `__run_selftests` with 5 arguments,=
 but the function signature expects 4 arguments.
- [Low] Conflicting function signatures for `__i915_subtests` between the h=
eader and source file.
- [Low] Passing `NULL` to `drm_info()` mangles log formatting in mock selft=
ests and destroys `igt_hexdump()` alignment.
--

--- Patch [8]: [PATCH v2 8/8] drm/i915/selftests: Use drm_* prints in selft=
est headers ---
commit a417b9a673aa26bae15031a5fc6e3dc6e4262012
Author: Krzysztof Karas <krzysztof.karas@intel.com>
Subject: drm/i915/selftests: Use drm_* prints in selftest headers

This commit moves away from generic pr_ prints to device context aware drm
versions in the i915 selftests.

> diff --git a/drivers/gpu/drm/i915/i915_selftest.h b/drivers/gpu/drm/i915/=
i915_selftest.h
> index e29ca298e7eb1..66707d7b35d31 100644
> --- a/drivers/gpu/drm/i915/i915_selftest.h
> +++ b/drivers/gpu/drm/i915/i915_selftest.h
> @@ -84,6 +85,7 @@ int __intel_gt_live_setup(void *data);
>  int __intel_gt_live_teardown(int err, void *data);
> =20
>  int __i915_subtests(const char *caller,
> +		    const struct drm_device *drm,
>  		    int (*setup)(void *data),

[Severity: Low]
Does this introduce a conflicting function signature?

The header file defines __i915_subtests() with 7 arguments here, but the so=
urce
file defines it with 6 arguments without the new drm parameter, which will
result in a conflicting types error during compilation.

> diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu=
/drm/i915/selftests/i915_selftest.c
> index 3adcfdab75ae1..6550b05e76360 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
> @@ -41,13 +43,13 @@ struct i915_selftest i915_selftest __read_mostly =3D {
> =20
>  int i915_mock_sanitycheck(void)
>  {
> -	pr_info(DRIVER_NAME ": %s() - ok!\n", __func__);
> +	drm_info(NULL, "%s() - ok!\n", __func__);

[Severity: Low]
Will passing NULL to drm_info() mangle the log formatting?

drm_info(NULL, ...) resolves to dev_info(NULL, ...), which prepends
"(NULL device *): [drm] " to the logs. This replaces the clean logs from the
previous pr_info() calls.

[ ... ]

> @@ -224,6 +226,8 @@ static int __run_selftests(const char *name,
>  			   unsigned int count,
>  			   void *data)
>  {
> +	struct drm_i915_private *i915 =3D data;
> +	struct drm_device *drm =3D i915 ? &i915->drm : NULL;
>  	struct mm_struct *mm =3D NULL;

[ ... ]

> @@ -299,8 +303,8 @@ static int __run_selftests(const char *name,
>  	return err;
>  }
> =20
> -#define run_selftests(x, data) \
> -	__run_selftests(#x, x##_selftests, ARRAY_SIZE(x##_selftests), data)
> +#define run_selftests(x, drm, data) \
> +	__run_selftests(#x, drm, x##_selftests, ARRAY_SIZE(x##_selftests), data)

[Severity: Low]
Is the run_selftests macro passing the correct number of arguments?

The run_selftests macro was updated to pass 5 arguments including the new d=
rm
parameter, but the static function __run_selftests() was not modified to ac=
cept
it and still expects 4 arguments. This causes a build failure.

[ ... ]

> @@ -495,6 +499,8 @@ int __i915_subtests(const char *caller,
>  		    unsigned int count,
>  		    void *data)
>  {
> +	struct drm_i915_private *i915 =3D data;
> +	struct drm_device *drm =3D i915 ? &i915->drm : NULL;

[Severity: High]
Can this cast cause a kernel panic when testing non-i915 context objects?

This blindly casts the void *data argument to struct drm_i915_private * to
derive a drm pointer. However, callers often pass other types like
struct intel_gt *.

For intel_gt, offset 8 contains a string pointer (const char *name), which
perfectly aliases with drm->dev. When drm_info(drm, ...) passes this to
dev_info(), the kernel will attempt to dereference the string literal as a
struct device *, resulting in a fatal page fault.

[ ... ]

> @@ -557,7 +561,7 @@ void igt_hexdump(const void *buf, size_t len)
> =20
>  		if (prev && !memcmp(prev, buf + pos, rowsize)) {
>  			if (!skip) {
> -				pr_info("*\n");
> +				drm_info(NULL, "*\n");
>  				skip =3D true;
>  			}
>  			continue;
> @@ -567,7 +571,7 @@ void igt_hexdump(const void *buf, size_t len)
>  						rowsize, sizeof(u32),
>  						line, sizeof(line),
>  						false) >=3D sizeof(line));
> -		pr_info("[%04zx] %s\n", pos, line);
> +		drm_info(NULL, "[%04zx] %s\n", pos, line);

[Severity: Low]
Does passing NULL here break the formatting of the hex dump output?

Similar to the mock selftest above, dev_info() will prepend
"(NULL device *): [drm] " to the prints, which destroys the clean column
alignment expected in igt_hexdump() output.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818095624.3254=
368-1-krzysztof.karas@intel.com?part=3D8
