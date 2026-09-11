Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B49BC88E41
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 06:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50DA510E35A;
	Fri, 11 Sep 2026 06:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hLm03z0/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E01E10E35A;
 Fri, 11 Sep 2026 06:29:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 947B243DE8;
 Fri, 11 Sep 2026 06:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB5C1F000FF;
 Fri, 11 Sep 2026 06:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789108197;
 bh=wczBpiDQ5Um+1ItHGabiYECJKkXlQ9Z9sJbaj+aWGYQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hLm03z0/v/R/j0zkkwN6pVThFb1EaOl/dTCdFrH//kcvT3BV7DkT4N5Gxy0CcaS/X
 Au/CE7OR3CPw9ZNSW5iJE6tCLrTjPWbQSybaKX9Ge3H4nst0ln5Y838hHEglMtJb2M
 7jrAGHTGgVSH6JbNd1xyDRWf4NsuEylkDDWXew7vRBcQEi183citS1zOkV2ABOrf21
 el+PwERuLGWz+Zm5g1LjolREboHg7uVLwE/yiPUOICFYVnmLSyZF8vgA/b9rl0/pKR
 h1Dn46FNykjKgynoflCPXiONw3pE3lYZE2/4UTW3KKqa7c3udh/o2NLwImrBo3tk+h
 I4vmIWslJ03cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/gem: Prevent overstepping exec array boundary
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260911061145.3535489-1-krzysztof.karas@intel.com>
References: <20260911061145.3535489-1-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 06:29:56 +0000
Message-Id: <20260911062957.3BB5C1F000FF@smtp.kernel.org>
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

Pre-existing issues:
- [High] VMA pin leak when returning -EINVAL for parallel contexts after a =
secure dispatch in `eb_parse`.
--

commit 5f50a42b21cf667f0838c20a62d465078d28fa60
Author: Krzysztof Karas <krzysztof.karas@intel.com>

drm/i915/gem: Prevent overstepping exec array boundary
   =20
It is possible for eb_relocate_parse_slow() to call kvfree() on
entries outside the original exec array. To amend this problem, ensure
that relocation cleanup uses the original exec object count, excluding
the VMAs appended by the command parser.

Cc: stable@vger.kernel.org # 5.10+
Assisted-by: GitHub-Copilot:gpt-6-astra

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu=
/drm/i915/gem/i915_gem_execbuffer.c
> index 1f303d4eaa4d4..d5aadced7da0c 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -1766,6 +1766,7 @@ static int eb_reinit_userptr(struct i915_execbuffer=
 *eb)
> =20
>  static noinline int eb_relocate_parse_slow(struct i915_execbuffer *eb)
>  {
> +	const unsigned int count =3D eb->buffer_count;
>  	bool have_copy =3D false;
>  	struct eb_vma *ev;

[ ... ]

> @@ -1868,7 +1869,6 @@ static noinline int eb_relocate_parse_slow(struct i=
915_execbuffer *eb)
> =20
>  out:
>  	if (have_copy) {
> -		const unsigned int count =3D eb->buffer_count;
>  		unsigned int i;
> =20
>  		for (i =3D 0; i < count; i++) {

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the
command parsing paths, I noticed a potential VMA pin leak in eb_parse()
when handling parallel contexts after a secure dispatch.

In eb_parse(), eb_dispatch_secure() pins a GGTT VMA and returns it as batch.
If intel_context_is_parallel() evaluates to true, the function immediately
returns -EINVAL:

drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:eb_parse() {
	...
secure_batch:
	if (batch) {
		if (intel_context_is_parallel(eb->context))
			return -EINVAL;

		eb->batches[0] =3D &eb->vma[eb->buffer_count++];
	...
}

Since the early -EINVAL return happens before the pinned batch is added to
the eb->vma array, eb_release_vmas() will not unpin it during the error
cleanup path.

Can this leak the pin count on the GGTT VMA, tying down memory and preventi=
ng
the VMA from being unbound? Could this lead to GGTT space exhaustion if
triggered repeatedly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911061145.3535=
489-1-krzysztof.karas@intel.com?part=3D1
