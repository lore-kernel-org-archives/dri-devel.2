Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0220606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fx5+ETKG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026FA10FEEE;
	Thu, 29 Oct 2026 01:56:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A4D910E155;
 Thu, 29 Oct 2026 01:56:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D687F600D1;
 Thu, 29 Oct 2026 01:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4341F01825;
 Thu, 29 Oct 2026 01:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793238966;
 bh=TdvyYggd3+ot/rrwwJrGtQuigaHGXLmVRVfqCqTuWQA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=fx5+ETKGMELNzK2HD0JYTf7azYhU9liRV7yApEyTpGZWQz9TWZ1XIKyz1ZCi5ijCT
 ttAOiSatvXMM2o71PJbS9chOSrTBIZrtQY/mJ8lvsJWACtAZyATEyuYUsk9SdYN4Fo
 /fVuwEqJp1O34+Yy61MsaR7r43apFPZtVsOBJczBf96wRjOoFo3q8/MnuONCFeQkKw
 SGangOmGd+BYsW+jsSHYSOIhKjqgovbC9wx8Tm0BZ5ygFWox+L42fjteO5nnc31ucK
 AyYnZMn2gmDGXnU/ZwocyMfGnMalKibuqr+0lhyizNxOEUaYHmPlgay0J0DyAEPFQq
 QMAM/gsv+/PRg==
Message-ID: <sashiko-outbox-188625@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC 2/5] drm/i915/selftests: Port GT-dependent selftests to
 work with multi-GT (low-hanging fruits part 2)
To: "Krzysztof Niemiec" <krzysztof.niemiec@intel.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20261029014155.55865-3-krzysztof.niemiec@intel.com>
References: <20261029014155.55865-1-krzysztof.niemiec@intel.com>
 <20261029014155.55865-3-krzysztof.niemiec@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 01:56:05 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/i915/selftests: unported wedged check in i915_request_live_s=
elftests()
--

commit 46c0aca503dcff6d10a11b75ac8ca3cd05b6385a
Author: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

drm/i915/selftests: Port GT-dependent selftests to work with multi-GT (low-=
hanging fruits part 2)

This commit updates top-level i915 selftest entry points that do not take a=
 GT
directly to check all GTs via for_each_gt() and abort if any GT is wedged.

[ ... ]

> diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/=
drm/i915/selftests/i915_request.c
> index e1a7c454a0a9d..6bf8ba4744974 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_request.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_request.c
> @@ -3295,9 +3295,13 @@ int i915_request_perf_selftests(struct drm_i915_pr=
ivate *i915)
>  		SUBTEST(perf_series_engines),
>  		SUBTEST(perf_parallel_engines),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> =20
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			return 0;
> +	}

[Severity: Medium]
Should i915_request_live_selftests() in
drivers/gpu/drm/i915/selftests/i915_request.c also be updated to iterate ov=
er
all GTs with for_each_gt() like i915_request_perf_selftests() here and
intel_memory_region_live_selftests() in
drivers/gpu/drm/i915/selftests/intel_memory_region.c?

Currently, i915_request_live_selftests() still checks only the primary GT:

int i915_request_live_selftests(struct drm_i915_private *i915)
{
	...
	if (intel_gt_is_wedged(to_gt(i915)))
		return 0;

	return i915_live_subtests(tests, i915);
}

Its subtests (such as live_nop_request(), live_all_engines(),
live_sequential_engines(), and live_parallel_engines()) do not reference
to_gt(i915) and instead iterate across all UABI engines on all GTs via
for_each_uabi_engine(), finishing with igt_live_test_end() ->
igt_flush_test().

If a secondary GT is wedged while GT0 is healthy,
i915_request_live_selftests() will not skip and will instead run against the
wedged GT's engines and fail with -EIO in igt_flush_test().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029014155.5586=
5-1-krzysztof.niemiec@intel.com?part=3D2
