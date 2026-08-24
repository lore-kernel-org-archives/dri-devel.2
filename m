Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA35C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2194A10E0C8;
	Mon, 24 Aug 2026 07:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZH/6+y1U";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D89E010E05B;
 Mon, 24 Aug 2026 07:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787555444; x=1819091444;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=tImze8P9DnJ43b/sUUa/AFdWIzvMdKWa2RT4dWIRm50=;
 b=ZH/6+y1UnhKFXubisOZJsKUdpHrTesM9fy0Zbv6J3+rshpmLlNLxwzSR
 z6yaVGzSCe6bIbSK9sXLQLQVITG/btNyoX53hUuy87YCZ1DNcXtKfrJOn
 1IKzk+Ub85EyuMR44W/m0cRbeXQ/JVOSeXNwq0bMBUaQuiDVf136Bfgk4
 2Ak14OrOEc8kQYEHyP+LXSY/ebqYLeCwxpWNErKj9mirIIO79msu1893p
 SqIFgQNhLf2z+MUGOjs2OhpGNLQPWUiA0b7VLD14OPp4o+Rq6vHViAHI5
 O8YmkUwJNL/Ml9JfXfOBa53+oJz3QBbP5OmObrh5qXBj5c1cwz+rhUVWY w==;
X-CSE-ConnectionGUID: w4Ipn3XtSEW+MLm48IxyFQ==
X-CSE-MsgGUID: QqXm4cikSB+u5AGrgJsw4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87116165"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="87116165"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 00:10:44 -0700
X-CSE-ConnectionGUID: rJvj9kj1STi7ENgV6xBe7g==
X-CSE-MsgGUID: jFyZTu+3TXCJjKtFoJhF1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="266392350"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.205])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 00:10:42 -0700
Message-ID: <a95f2cb629ab15b431594dc259011324ab1bc6cc.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/8] drm/i915/selftests: Use drm_* prints in mock
 selftests
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, 
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Jani Nikula
 <jani.nikula@linux.intel.com>,  Andi Shyti <andi.shyti@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,  Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Mon, 24 Aug 2026 09:10:41 +0200
In-Reply-To: <20260818095624.3254368-2-krzysztof.karas@intel.com>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
 <20260818095624.3254368-2-krzysztof.karas@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Krzysztof,

On Tue, 2026-08-18 at 09:56 +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to device context aware drm
> versions.
>=20
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>  .../gpu/drm/i915/selftests/i915_sw_fence.c    |  92 +++++++------
>  drivers/gpu/drm/i915/selftests/i915_syncmap.c | 129 ++++++++++--------
>  drivers/gpu/drm/i915/selftests/scatterlist.c  |  45 +++---
>  3 files changed, 144 insertions(+), 122 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu=
/drm/i915/selftests/i915_sw_fence.c
> index 6a305322e30d..462704e575f5 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
> @@ -26,6 +26,8 @@
>  #include <linux/delay.h>
>  #include <linux/prime_numbers.h>
> =20
> +#include <drm/drm_print.h>
> +
>  #include "../i915_selftest.h"
> =20
>  static int
> @@ -107,7 +109,7 @@ static int test_dag(void *arg)
>  		return -ENOMEM;
> =20
>  	if (i915_sw_fence_await_sw_fence_gfp(A, A, GFP_KERNEL) !=3D -EINVAL) {
> -		pr_err("recursive cycle not detected (AA)\n");
> +		drm_err(NULL, "recursive cycle not detected (AA)\n");

Since this use patter doesn't pass any context to the drm version, I think
your commit message doesn't give an answer on why we may want this change.

>  		goto err_A;
>  	}
> =20
> @@ -119,7 +121,7 @@ static int test_dag(void *arg)
> =20
>  	i915_sw_fence_await_sw_fence_gfp(A, B, GFP_KERNEL);
>  	if (i915_sw_fence_await_sw_fence_gfp(B, A, GFP_KERNEL) !=3D -EINVAL) {
> -		pr_err("single depth cycle not detected (BAB)\n");
> +		drm_err(NULL, "single depth cycle not detected (BAB)\n");
>  		goto err_B;
>  	}
> =20
> @@ -130,19 +132,19 @@ static int test_dag(void *arg)
>  	}
> =20
>  	if (i915_sw_fence_await_sw_fence_gfp(B, C, GFP_KERNEL) =3D=3D -EINVAL) =
{
> -		pr_err("invalid cycle detected\n");
> +		drm_err(NULL, "invalid cycle detected\n");
>  		goto err_C;
>  	}
>  	if (i915_sw_fence_await_sw_fence_gfp(C, B, GFP_KERNEL) !=3D -EINVAL) {
> -		pr_err("single depth cycle not detected (CBC)\n");
> +		drm_err(NULL, "single depth cycle not detected (CBC)\n");
>  		goto err_C;
>  	}
>  	if (i915_sw_fence_await_sw_fence_gfp(C, A, GFP_KERNEL) !=3D -EINVAL) {
> -		pr_err("cycle not detected (BA, CB, AC)\n");
> +		drm_err(NULL, "cycle not detected (BA, CB, AC)\n");
>  		goto err_C;
>  	}
>  	if (i915_sw_fence_await_sw_fence_gfp(A, C, GFP_KERNEL) =3D=3D -EINVAL) =
{
> -		pr_err("invalid cycle detected\n");
> +		drm_err(NULL, "invalid cycle detected\n");
>  		goto err_C;
>  	}
> =20
> @@ -152,15 +154,15 @@ static int test_dag(void *arg)
> =20
>  	ret =3D 0;
>  	if (!i915_sw_fence_done(C)) {
> -		pr_err("fence C not done\n");
> +		drm_err(NULL, "fence C not done\n");
>  		ret =3D -EINVAL;
>  	}
>  	if (!i915_sw_fence_done(B)) {
> -		pr_err("fence B not done\n");
> +		drm_err(NULL, "fence B not done\n");
>  		ret =3D -EINVAL;
>  	}
>  	if (!i915_sw_fence_done(A)) {
> -		pr_err("fence A not done\n");
> +		drm_err(NULL, "fence A not done\n");
>  		ret =3D -EINVAL;
>  	}
>  err_C:
> @@ -191,7 +193,7 @@ static int test_AB(void *arg)
>  	if (ret < 0)
>  		goto err_B;
>  	if (ret =3D=3D 0) {
> -		pr_err("Incorrectly reported fence A was complete before await\n");
> +		drm_err(NULL, "Incorrectly reported fence A was complete before await\=
n");
>  		ret =3D -EINVAL;
>  		goto err_B;
>  	}
> @@ -203,12 +205,12 @@ static int test_AB(void *arg)
> =20
>  	i915_sw_fence_commit(B);
>  	if (!i915_sw_fence_done(B)) {
> -		pr_err("Fence B is not done\n");
> +		drm_err(NULL, "Fence B is not done\n");
>  		goto err_B;
>  	}
> =20
>  	if (!i915_sw_fence_done(A)) {
> -		pr_err("Fence A is not done\n");
> +		drm_err(NULL, "Fence A is not done\n");
>  		goto err_B;
>  	}
> =20
> @@ -246,7 +248,7 @@ static int test_ABC(void *arg)
>  	if (ret < 0)
>  		goto err_C;
>  	if (ret =3D=3D 0) {
> -		pr_err("Incorrectly reported fence B was complete before await\n");
> +		drm_err(NULL, "Incorrectly reported fence B was complete before await\=
n");
>  		goto err_C;
>  	}
> =20
> @@ -254,25 +256,25 @@ static int test_ABC(void *arg)
>  	if (ret < 0)
>  		goto err_C;
>  	if (ret =3D=3D 0) {
> -		pr_err("Incorrectly reported fence C was complete before await\n");
> +		drm_err(NULL, "Incorrectly reported fence C was complete before await\=
n");
>  		goto err_C;
>  	}
> =20
>  	ret =3D -EINVAL;
>  	i915_sw_fence_commit(A);
>  	if (i915_sw_fence_done(A)) {
> -		pr_err("Fence A completed early\n");
> +		drm_err(NULL, "Fence A completed early\n");
>  		goto err_C;
>  	}
> =20
>  	i915_sw_fence_commit(B);
>  	if (i915_sw_fence_done(B)) {
> -		pr_err("Fence B completed early\n");
> +		drm_err(NULL, "Fence B completed early\n");
>  		goto err_C;
>  	}
> =20
>  	if (i915_sw_fence_done(A)) {
> -		pr_err("Fence A completed early (after signaling B)\n");
> +		drm_err(NULL, "Fence A completed early (after signaling B)\n");
>  		goto err_C;
>  	}
> =20
> @@ -280,15 +282,15 @@ static int test_ABC(void *arg)
> =20
>  	ret =3D 0;
>  	if (!i915_sw_fence_done(C)) {
> -		pr_err("Fence C not done\n");
> +		drm_err(NULL, "Fence C not done\n");
>  		ret =3D -EINVAL;
>  	}
>  	if (!i915_sw_fence_done(B)) {
> -		pr_err("Fence B not done\n");
> +		drm_err(NULL, "Fence B not done\n");
>  		ret =3D -EINVAL;
>  	}
>  	if (!i915_sw_fence_done(A)) {
> -		pr_err("Fence A not done\n");
> +		drm_err(NULL, "Fence A not done\n");
>  		ret =3D -EINVAL;
>  	}
>  err_C:
> @@ -343,28 +345,28 @@ static int test_AB_C(void *arg)
> =20
>  	ret =3D 0;
>  	if (i915_sw_fence_done(A)) {
> -		pr_err("Fence A completed early\n");
> +		drm_err(NULL, "Fence A completed early\n");
>  		ret =3D -EINVAL;
>  	}
> =20
>  	if (i915_sw_fence_done(B)) {
> -		pr_err("Fence B completed early\n");
> +		drm_err(NULL, "Fence B completed early\n");
>  		ret =3D -EINVAL;
>  	}
> =20
>  	i915_sw_fence_commit(C);
>  	if (!i915_sw_fence_done(C)) {
> -		pr_err("Fence C not done\n");
> +		drm_err(NULL, "Fence C not done\n");
>  		ret =3D -EINVAL;
>  	}
> =20
>  	if (!i915_sw_fence_done(B)) {
> -		pr_err("Fence B not done\n");
> +		drm_err(NULL, "Fence B not done\n");
>  		ret =3D -EINVAL;
>  	}
> =20
>  	if (!i915_sw_fence_done(A)) {
> -		pr_err("Fence A not done\n");
> +		drm_err(NULL, "Fence A not done\n");
>  		ret =3D -EINVAL;
>  	}
> =20
> @@ -424,17 +426,17 @@ static int test_C_AB(void *arg)
>  	i915_sw_fence_commit(B);
> =20
>  	if (!i915_sw_fence_done(A)) {
> -		pr_err("Fence A not done\n");
> +		drm_err(NULL, "Fence A not done\n");
>  		ret =3D -EINVAL;
>  	}
> =20
>  	if (!i915_sw_fence_done(B)) {
> -		pr_err("Fence B not done\n");
> +		drm_err(NULL, "Fence B not done\n");
>  		ret =3D -EINVAL;
>  	}
> =20
>  	if (!i915_sw_fence_done(C)) {
> -		pr_err("Fence C not done\n");
> +		drm_err(NULL, "Fence C not done\n");
>  		ret =3D -EINVAL;
>  	}
> =20
> @@ -483,14 +485,14 @@ static int test_chain(void *arg)
>  	for (i =3D nfences; --i; ) {
>  		if (i915_sw_fence_done(fences[i])) {
>  			if (ret =3D=3D 0)
> -				pr_err("Fence[%d] completed early\n", i);
> +				drm_err(NULL, "Fence[%d] completed early\n", i);
>  			ret =3D -EINVAL;
>  		}
>  	}
>  	i915_sw_fence_commit(fences[0]);
>  	for (i =3D 0; ret =3D=3D 0 && i < nfences; i++) {
>  		if (!i915_sw_fence_done(fences[i])) {
> -			pr_err("Fence[%d] is not done\n", i);
> +			drm_err(NULL, "Fence[%d] is not done\n", i);
>  			ret =3D -EINVAL;
>  		}
>  	}
> @@ -553,7 +555,7 @@ static int test_ipc(void *arg)
> =20
>  	usleep_range(1000, 2000);
>  	if (READ_ONCE(ipc.value)) {
> -		pr_err("worker updated value before i915_sw_fence was signaled\n");
> +		drm_err(NULL, "worker updated value before i915_sw_fence was signaled\=
n");
>  		ret =3D -EINVAL;
>  	}
> =20
> @@ -561,7 +563,7 @@ static int test_ipc(void *arg)
>  	i915_sw_fence_wait(ipc.out);
> =20
>  	if (!READ_ONCE(ipc.value)) {
> -		pr_err("worker signaled i915_sw_fence before value was posted\n");
> +		drm_err(NULL, "worker signaled i915_sw_fence before value was posted\n=
");
>  		ret =3D -EINVAL;
>  	}
> =20
> @@ -584,7 +586,7 @@ static int test_timer(void *arg)
>  	preempt_disable();
>  	timed_fence_init(&tf, target =3D jiffies);
>  	if (!i915_sw_fence_done(&tf.fence)) {
> -		pr_err("Fence with immediate expiration not signaled\n");
> +		drm_err(NULL, "Fence with immediate expiration not signaled\n");
>  		goto err;
>  	}
>  	preempt_enable();
> @@ -594,7 +596,9 @@ static int test_timer(void *arg)
>  		preempt_disable();
>  		timed_fence_init(&tf, target =3D jiffies + delay);
>  		if (i915_sw_fence_done(&tf.fence)) {
> -			pr_err("Fence with future expiration (%lu jiffies) already signaled\n=
", delay);
> +			drm_err(NULL,
> +				"Fence with future expiration (%lu jiffies) already signaled\n",
> +				delay);
>  			goto err;
>  		}
>  		preempt_enable();
> @@ -603,12 +607,12 @@ static int test_timer(void *arg)
> =20
>  		preempt_disable();
>  		if (!i915_sw_fence_done(&tf.fence)) {
> -			pr_err("Fence not signaled after wait\n");
> +			drm_err(NULL, "Fence not signaled after wait\n");
>  			goto err;
>  		}
>  		if (time_before(jiffies, target)) {
> -			pr_err("Fence signaled too early, target=3D%lu, now=3D%lu\n",
> -			       target, jiffies);
> +			drm_err(NULL, "Fence signaled too early, target=3D%lu, now=3D%lu\n",
> +				target, jiffies);
>  			goto err;
>  		}
>  		preempt_enable();
> @@ -692,7 +696,7 @@ static int test_dma_fence(void *arg)
> =20
>  	err =3D -EINVAL;
>  	if (i915_sw_fence_done(timeout) || i915_sw_fence_done(not)) {
> -		pr_err("Fences immediately signaled\n");
> +		drm_err(NULL, "Fences immediately signaled\n");
>  		goto err;
>  	}
> =20
> @@ -702,25 +706,25 @@ static int test_dma_fence(void *arg)
>  	sleep =3D jiffies_to_usecs(delay) / 3;
>  	usleep_range(sleep, 2 * sleep);
>  	if (time_after(jiffies, end)) {
> -		pr_debug("Slept too long, delay=3D%lu, (target=3D%lu, now=3D%lu) skipp=
ing\n",
> -			 delay, end, jiffies);
> +		drm_dbg(NULL, "Slept too long, delay=3D%lu, (target=3D%lu, now=3D%lu) =
skipping\n",
> +			delay, end, jiffies);
>  		goto skip;
>  	}
> =20
>  	if (i915_sw_fence_done(timeout) || i915_sw_fence_done(not)) {
> -		pr_err("Fences signaled too early\n");
> +		drm_err(NULL, "Fences signaled too early\n");
>  		goto err;
>  	}
> =20
>  	if (!wait_event_timeout(timeout->wait,
>  				i915_sw_fence_done(timeout),
>  				2 * (end - jiffies) + 1)) {
> -		pr_err("Timeout fence unsignaled!\n");
> +		drm_err(NULL, "Timeout fence unsignaled!\n");
>  		goto err;
>  	}
> =20
>  	if (i915_sw_fence_done(not)) {
> -		pr_err("No timeout fence signaled!\n");
> +		drm_err(NULL, "No timeout fence signaled!\n");
>  		goto err;
>  	}
> =20
> @@ -728,7 +732,7 @@ static int test_dma_fence(void *arg)
>  	dma_fence_signal(dma);
> =20
>  	if (!i915_sw_fence_done(timeout) || !i915_sw_fence_done(not)) {
> -		pr_err("Fences unsignaled\n");
> +		drm_err(NULL, "Fences unsignaled\n");
>  		goto err;
>  	}
> =20
> diff --git a/drivers/gpu/drm/i915/selftests/i915_syncmap.c b/drivers/gpu/=
drm/i915/selftests/i915_syncmap.c
> index 88fa845e9f4a..3eae3c6fa312 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_syncmap.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
> @@ -25,6 +25,8 @@
>  #include "../i915_selftest.h"
>  #include "i915_random.h"
> =20
> +#include <drm/drm_print.h>
> +
>  static char *
>  __sync_print(struct i915_syncmap *p,
>  	     char *buf, unsigned long *sz,
> @@ -102,7 +104,7 @@ static int check_syncmap_free(struct i915_syncmap **s=
ync)
>  {
>  	i915_syncmap_free(sync);
>  	if (*sync) {
> -		pr_err("sync not cleared after free\n");
> +		drm_err(NULL, "sync not cleared after free\n");
>  		return -EINVAL;
>  	}
> =20
> @@ -121,7 +123,7 @@ static int dump_syncmap(struct i915_syncmap *sync, in=
t err)
>  		goto skip;
> =20
>  	if (i915_syncmap_print_to_buf(sync, buf, PAGE_SIZE))
> -		pr_err("%s", buf);
> +		drm_err(NULL, "%s", buf);
> =20
>  	kfree(buf);
> =20
> @@ -146,14 +148,13 @@ static int igt_syncmap_init(void *arg)
>  static int check_seqno(struct i915_syncmap *leaf, unsigned int idx, u32 =
seqno)
>  {
>  	if (leaf->height) {
> -		pr_err("%s: not a leaf, height is %d\n",
> -		       __func__, leaf->height);
> +		drm_err(NULL, "%s: not a leaf, height is %d\n", __func__, leaf->height=
);
>  		return -EINVAL;
>  	}
> =20
>  	if (__sync_seqno(leaf)[idx] !=3D seqno) {
> -		pr_err("%s: seqno[%d], found %x, expected %x\n",
> -		       __func__, idx, __sync_seqno(leaf)[idx], seqno);
> +		drm_err(NULL, "%s: seqno[%d], found %x, expected %x\n",
> +			__func__, idx, __sync_seqno(leaf)[idx], seqno);
>  		return -EINVAL;
>  	}
> =20
> @@ -169,20 +170,21 @@ static int check_one(struct i915_syncmap **sync, u6=
4 context, u32 seqno)
>  		return err;
> =20
>  	if ((*sync)->height) {
> -		pr_err("Inserting first context=3D%llx did not return leaf (height=3D%=
d, prefix=3D%llx\n",
> -		       context, (*sync)->height, (*sync)->prefix);
> +		drm_err(NULL,
> +			"Inserting first context=3D%llx did not return leaf (height=3D%d, pre=
fix=3D%llx\n",
> +			context, (*sync)->height, (*sync)->prefix);
>  		return -EINVAL;
>  	}
> =20
>  	if ((*sync)->parent) {
> -		pr_err("Inserting first context=3D%llx created branches!\n",
> -		       context);
> +		drm_err(NULL, "Inserting first context=3D%llx created branches!\n", co=
ntext);
>  		return -EINVAL;
>  	}
> =20
>  	if (hweight32((*sync)->bitmap) !=3D 1) {
> -		pr_err("First bitmap does not contain a single entry, found %x (count=
=3D%d)!\n",
> -		       (*sync)->bitmap, hweight32((*sync)->bitmap));
> +		drm_err(NULL,
> +			"First bitmap does not contain a single entry, found %x (count=3D%d)!=
\n",
> +			(*sync)->bitmap, hweight32((*sync)->bitmap));
>  		return -EINVAL;
>  	}
> =20
> @@ -191,8 +193,7 @@ static int check_one(struct i915_syncmap **sync, u64 =
context, u32 seqno)
>  		return err;
> =20
>  	if (!i915_syncmap_is_later(sync, context, seqno)) {
> -		pr_err("Lookup of first context=3D%llx/seqno=3D%x failed!\n",
> -		       context, seqno);
> +		drm_err(NULL, "Lookup of first context=3D%llx/seqno=3D%x failed!\n", c=
ontext, seqno);
>  		return -EINVAL;
>  	}
> =20
> @@ -229,8 +230,8 @@ static int igt_syncmap_one(void *arg)
>  		}
>  		max++;
>  	} while (!__igt_timeout(end_time, NULL));
> -	pr_debug("%s: Completed %lu single insertions\n",
> -		 __func__, max * (max - 1) / 2);
> +	drm_dbg(NULL, "%s: Completed %lu single insertions\n",
> +		__func__, max * (max - 1) / 2);
>  out:
>  	return dump_syncmap(sync, err);
>  }
> @@ -244,14 +245,16 @@ static int check_leaf(struct i915_syncmap **sync, u=
64 context, u32 seqno)
>  		return err;
> =20
>  	if ((*sync)->height) {
> -		pr_err("Inserting context=3D%llx did not return leaf (height=3D%d, pre=
fix=3D%llx\n",
> -		       context, (*sync)->height, (*sync)->prefix);
> +		drm_err(NULL,
> +			"Inserting context=3D%llx did not return leaf (height=3D%d, prefix=3D=
%llx\n",
> +			context, (*sync)->height, (*sync)->prefix);
>  		return -EINVAL;
>  	}
> =20
>  	if (hweight32((*sync)->bitmap) !=3D 1) {
> -		pr_err("First entry into leaf (context=3D%llx) does not contain a sing=
le entry, found %x (count=3D%d)!\n",
> -		       context, (*sync)->bitmap, hweight32((*sync)->bitmap));
> +		drm_err(NULL,
> +			"First entry into leaf (context=3D%llx) does not contain a single ent=
ry, found %x (count=3D%d)!\n",
> +			context, (*sync)->bitmap, hweight32((*sync)->bitmap));
>  		return -EINVAL;
>  	}
> =20
> @@ -260,8 +263,8 @@ static int check_leaf(struct i915_syncmap **sync, u64=
 context, u32 seqno)
>  		return err;
> =20
>  	if (!i915_syncmap_is_later(sync, context, seqno)) {
> -		pr_err("Lookup of first entry context=3D%llx/seqno=3D%x failed!\n",
> -		       context, seqno);
> +		drm_err(NULL, "Lookup of first entry context=3D%llx/seqno=3D%x failed!=
\n",
> +			context, seqno);
>  		return -EINVAL;
>  	}
> =20
> @@ -306,20 +309,20 @@ static int igt_syncmap_join_above(void *arg)
>  				continue;
> =20
>  			if (!join->height) {
> -				pr_err("Parent with no height!\n");
> +				drm_err(NULL, "Parent with no height!\n");
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> =20
>  			if (hweight32(join->bitmap) !=3D 2) {
> -				pr_err("Join does not have 2 children: %x (%d)\n",
> -				       join->bitmap, hweight32(join->bitmap));
> +				drm_err(NULL, "Join does not have 2 children: %x (%d)\n",
> +					join->bitmap, hweight32(join->bitmap));
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> =20
>  			if (__sync_child(join)[__sync_branch_idx(join, context)] !=3D sync) {
> -				pr_err("Leaf misplaced in parent!\n");
> +				drm_err(NULL, "Leaf misplaced in parent!\n");
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> @@ -350,8 +353,9 @@ static int igt_syncmap_join_below(void *arg)
>  				goto out;
> =20
>  			if (sync->height) {
> -				pr_err("Inserting context=3D%llx (order=3D%d, step=3D%d) did not ret=
urn leaf (height=3D%d, prefix=3D%llx\n",
> -				       context, order, step, sync->height, sync->prefix);
> +				drm_err(NULL,
> +					"Inserting context=3D%llx (order=3D%d, step=3D%d) did not return le=
af (height=3D%d, prefix=3D%llx\n",
> +					context, order, step, sync->height, sync->prefix);
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> @@ -363,16 +367,17 @@ static int igt_syncmap_join_below(void *arg)
>  			u64 context =3D step * BIT_ULL(order);
> =20
>  			if (!i915_syncmap_is_later(&sync, context, 0)) {
> -				pr_err("1: context %llx (order=3D%d, step=3D%d) not found\n",
> -				       context, order, step);
> +				drm_err(NULL, "1: context %llx (order=3D%d, step=3D%d) not found\n",
> +					context, order, step);
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> =20
>  			for (idx =3D 1; idx < KSYNCMAP; idx++) {
>  				if (i915_syncmap_is_later(&sync, context + idx, 0)) {
> -					pr_err("1: context %llx (order=3D%d, step=3D%d) should not exist\n"=
,
> -					       context + idx, order, step);
> +					drm_err(NULL,
> +						"1: context %llx (order=3D%d, step=3D%d) should not exist\n",
> +						context + idx, order, step);
>  					err =3D -EINVAL;
>  					goto out;
>  				}
> @@ -385,8 +390,8 @@ static int igt_syncmap_join_below(void *arg)
>  			u64 context =3D step * BIT_ULL(order);
> =20
>  			if (!i915_syncmap_is_later(&sync, context, 0)) {
> -				pr_err("2: context %llx (order=3D%d, step=3D%d) not found\n",
> -				       context, order, step);
> +				drm_err(NULL, "2: context %llx (order=3D%d, step=3D%d) not found\n",
> +					context, order, step);
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> @@ -423,17 +428,19 @@ static int igt_syncmap_neighbours(void *arg)
>  				goto out;
> =20
>  			if (sync->height) {
> -				pr_err("Inserting context=3D%llx did not return leaf (height=3D%d, p=
refix=3D%llx\n",
> -				       context, sync->height, sync->prefix);
> +				drm_err(NULL,
> +					"Inserting context=3D%llx did not return leaf (height=3D%d, prefix=
=3D%llx\n",
> +					context, sync->height, sync->prefix);
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> =20
>  			if (sync->bitmap !=3D BIT(idx + 1) - 1) {
> -				pr_err("Inserting neighbouring context=3D0x%llx+%d, did not fit into=
 the same leaf bitmap=3D%x (%d), expected %lx (%d)\n",
> -				       context, idx,
> -				       sync->bitmap, hweight32(sync->bitmap),
> -				       BIT(idx + 1) - 1, idx + 1);
> +				drm_err(NULL,
> +					"Inserting neighbouring context=3D0x%llx+%d, did not fit into the s=
ame leaf bitmap=3D%x (%d), expected %lx (%d)\n",
> +					context, idx,
> +					sync->bitmap, hweight32(sync->bitmap),
> +					BIT(idx + 1) - 1, idx + 1);
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> @@ -473,9 +480,10 @@ static int igt_syncmap_compact(void *arg)
>  				goto out;
> =20
>  			if (sync->height) {
> -				pr_err("Inserting context=3D%llx (order=3D%d, idx=3D%d) did not retu=
rn leaf (height=3D%d, prefix=3D%llx\n",
> -				       context, order, idx,
> -				       sync->height, sync->prefix);
> +				drm_err(NULL,
> +					"Inserting context=3D%llx (order=3D%d, idx=3D%d) did not return lea=
f (height=3D%d, prefix=3D%llx\n",
> +					context, order, idx,
> +					sync->height, sync->prefix);
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> @@ -483,22 +491,23 @@ static int igt_syncmap_compact(void *arg)
> =20
>  		sync =3D sync->parent;
>  		if (sync->parent) {
> -			pr_err("Parent (join) of last leaf was not the sync!\n");
> +			drm_err(NULL, "Parent (join) of last leaf was not the sync!\n");
>  			err =3D -EINVAL;
>  			goto out;
>  		}
> =20
>  		if (sync->height !=3D order) {
> -			pr_err("Join does not have the expected height, found %d, expected %d=
\n",
> -			       sync->height, order);
> +			drm_err(NULL,
> +				"Join does not have the expected height, found %d, expected %d\n",
> +				sync->height, order);
>  			err =3D -EINVAL;
>  			goto out;
>  		}
> =20
>  		if (sync->bitmap !=3D BIT(KSYNCMAP) - 1) {
> -			pr_err("Join is not full!, found %x (%d) expected %lx (%d)\n",
> -			       sync->bitmap, hweight32(sync->bitmap),
> -			       BIT(KSYNCMAP) - 1, KSYNCMAP);
> +			drm_err(NULL, "Join is not full!, found %x (%d) expected %lx (%d)\n",
> +				sync->bitmap, hweight32(sync->bitmap),
> +				BIT(KSYNCMAP) - 1, KSYNCMAP);
>  			err =3D -EINVAL;
>  			goto out;
>  		}
> @@ -508,28 +517,28 @@ static int igt_syncmap_compact(void *arg)
>  			struct i915_syncmap *leaf =3D __sync_child(sync)[idx];
> =20
>  			if (leaf->height) {
> -				pr_err("Child %d is a not leaf!\n", idx);
> +				drm_err(NULL, "Child %d is a not leaf!\n", idx);
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> =20
>  			if (leaf->parent !=3D sync) {
> -				pr_err("Child %d is not attached to us!\n",
> -				       idx);
> +				drm_err(NULL, "Child %d is not attached to us!\n", idx);
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> =20
>  			if (!is_power_of_2(leaf->bitmap)) {
> -				pr_err("Child %d holds more than one id, found %x (%d)\n",
> -				       idx, leaf->bitmap, hweight32(leaf->bitmap));
> +				drm_err(NULL, "Child %d holds more than one id, found %x (%d)\n",
> +					idx, leaf->bitmap, hweight32(leaf->bitmap));
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> =20
>  			if (leaf->bitmap !=3D BIT(idx)) {
> -				pr_err("Child %d has wrong seqno idx, found %d, expected %d\n",
> -				       idx, ilog2(leaf->bitmap), idx);
> +				drm_err(NULL,
> +					"Child %d has wrong seqno idx, found %d, expected %d\n",
> +					idx, ilog2(leaf->bitmap), idx);
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> @@ -582,8 +591,9 @@ static int igt_syncmap_random(void *arg)
>  			u64 context =3D i915_prandom_u64_state(&ctx);
> =20
>  			if (i915_syncmap_is_later(&sync, context, seqno) !=3D expect) {
> -				pr_err("context=3D%llu, last=3D%u this=3D%u did not match expectatio=
n (%d)\n",
> -				       context, last_seqno, seqno, expect);
> +				drm_err(NULL,
> +					"context=3D%llu, last=3D%u this=3D%u did not match expectation (%d)=
\n",
> +					context, last_seqno, seqno, expect);
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> @@ -595,7 +605,8 @@ static int igt_syncmap_random(void *arg)
> =20
>  		phase++;
>  	} while (!__igt_timeout(end_time, NULL));
> -	pr_debug("Completed %lu passes, each of %lu contexts\n", phase, count);
> +	drm_dbg(NULL, "Completed %lu passes, each of %lu contexts\n",
> +		phase, count);
>  out:
>  	return dump_syncmap(sync, err);
>  }
> diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/d=
rm/i915/selftests/scatterlist.c
> index 7e59591bbed6..d8fbe5a8060b 100644
> --- a/drivers/gpu/drm/i915/selftests/scatterlist.c
> +++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
> @@ -24,6 +24,8 @@
>  #include <linux/prime_numbers.h>
>  #include <linux/prandom.h>
> =20
> +#include <drm/drm_print.h>
> +
>  #include "i915_selftest.h"
>  #include "i915_utils.h"
> =20
> @@ -53,14 +55,16 @@ static noinline int expect_pfn_sg(struct pfn_table *p=
t,
>  		unsigned int npages =3D npages_fn(n, pt->st.nents, rnd);
> =20
>  		if (page_to_pfn(page) !=3D pfn) {
> -			pr_err("%s: %s left pages out of order, expected pfn %lu, found pfn %=
lu (using for_each_sg)\n",
> -			       __func__, who, pfn, page_to_pfn(page));
> +			drm_err(NULL,
> +				"%s: %s left pages out of order, expected pfn %lu, found pfn %lu (us=
ing for_each_sg)\n",
> +				__func__, who, pfn, page_to_pfn(page));
>  			return -EINVAL;
>  		}
> =20
>  		if (sg->length !=3D npages * PAGE_SIZE) {
> -			pr_err("%s: %s copied wrong sg length, expected size %lu, found %u (u=
sing for_each_sg)\n",
> -			       __func__, who, npages * PAGE_SIZE, sg->length);
> +			drm_err(NULL,
> +				"%s: %s copied wrong sg length, expected size %lu, found %u (using f=
or_each_sg)\n",
> +				__func__, who, npages * PAGE_SIZE, sg->length);
>  			return -EINVAL;
>  		}
> =20
> @@ -70,8 +74,8 @@ static noinline int expect_pfn_sg(struct pfn_table *pt,
>  		pfn +=3D npages;
>  	}
>  	if (pfn !=3D pt->end) {
> -		pr_err("%s: %s finished on wrong pfn, expected %lu, found %lu\n",
> -		       __func__, who, pt->end, pfn);
> +		drm_err(NULL, "%s: %s finished on wrong pfn, expected %lu, found %lu\n=
",
> +			__func__, who, pt->end, pfn);
>  		return -EINVAL;
>  	}
> =20
> @@ -90,8 +94,9 @@ static noinline int expect_pfn_sg_page_iter(struct pfn_=
table *pt,
>  		struct page *page =3D sg_page_iter_page(&sgiter);
> =20
>  		if (page !=3D pfn_to_page(pfn)) {
> -			pr_err("%s: %s left pages out of order, expected pfn %lu, found pfn %=
lu (using for_each_sg_page)\n",
> -			       __func__, who, pfn, page_to_pfn(page));
> +			drm_err(NULL,
> +				"%s: %s left pages out of order, expected pfn %lu, found pfn %lu (us=
ing for_each_sg_page)\n",
> +				__func__, who, pfn, page_to_pfn(page));
>  			return -EINVAL;
>  		}
> =20
> @@ -101,8 +106,8 @@ static noinline int expect_pfn_sg_page_iter(struct pf=
n_table *pt,
>  		pfn++;
>  	}
>  	if (pfn !=3D pt->end) {
> -		pr_err("%s: %s finished on wrong pfn, expected %lu, found %lu\n",
> -		       __func__, who, pt->end, pfn);
> +		drm_err(NULL, "%s: %s finished on wrong pfn, expected %lu, found %lu\n=
",
> +			__func__, who, pt->end, pfn);
>  		return -EINVAL;
>  	}
> =20
> @@ -120,8 +125,9 @@ static noinline int expect_pfn_sgtiter(struct pfn_tab=
le *pt,
>  	pfn =3D pt->start;
>  	for_each_sgt_page(page, sgt, &pt->st) {
>  		if (page !=3D pfn_to_page(pfn)) {
> -			pr_err("%s: %s left pages out of order, expected pfn %lu, found pfn %=
lu (using for_each_sgt_page)\n",
> -			       __func__, who, pfn, page_to_pfn(page));
> +			drm_err(NULL,
> +				"%s: %s left pages out of order, expected pfn %lu, found pfn %lu (us=
ing for_each_sgt_page)\n",
> +				__func__, who, pfn, page_to_pfn(page));
>  			return -EINVAL;
>  		}
> =20
> @@ -131,8 +137,8 @@ static noinline int expect_pfn_sgtiter(struct pfn_tab=
le *pt,
>  		pfn++;
>  	}
>  	if (pfn !=3D pt->end) {
> -		pr_err("%s: %s finished on wrong pfn, expected %lu, found %lu\n",
> -		       __func__, who, pt->end, pfn);
> +		drm_err(NULL, "%s: %s finished on wrong pfn, expected %lu, found %lu\n=
",
> +			__func__, who, pt->end, pfn);
>  		return -EINVAL;
>  	}
> =20
> @@ -275,7 +281,7 @@ static const npages_fn_t npages_funcs[] =3D {
>  	NULL,
>  };
> =20
> -static int igt_sg_alloc(void *ignored)
> +static int igt_sg_alloc(void *arg)

Is this related?

>  {
>  	IGT_TIMEOUT(end_time);
>  	const unsigned long max_order =3D 20; /* approximating a 4GiB object */
> @@ -305,7 +311,7 @@ static int igt_sg_alloc(void *ignored)
> =20
>  				prandom_seed_state(&prng,
>  						   i915_selftest.random_seed);
> -				err =3D expect_pfn_sgtable(&pt, *npages, &prng,
> +					err =3D expect_pfn_sgtable(&pt, *npages, &prng,

And this?

>  							 "sg_alloc_table",
>  							 end_time);
>  				sg_free_table(&pt.st);
> @@ -322,7 +328,7 @@ static int igt_sg_alloc(void *ignored)
>  	return 0;
>  }
> =20
> -static int igt_sg_trim(void *ignored)
> +static int igt_sg_trim(void *arg)

ditto

Thanks,
Janusz


>  {
>  	IGT_TIMEOUT(end_time);
>  	const unsigned long max =3D PAGE_SIZE; /* not prime! */
> @@ -348,8 +354,9 @@ static int igt_sg_trim(void *ignored)
>  			if (i915_sg_trim(&pt.st)) {
>  				if (pt.st.orig_nents !=3D prime ||
>  				    pt.st.nents !=3D prime) {
> -					pr_err("i915_sg_trim failed (nents %u, orig_nents %u), expected %lu=
\n",
> -					       pt.st.nents, pt.st.orig_nents, prime);
> +					drm_err(NULL,
> +						"i915_sg_trim failed (nents %u, orig_nents %u), expected %lu\n",
> +						pt.st.nents, pt.st.orig_nents, prime);
>  					err =3D -EINVAL;
>  				} else {
>  					prandom_seed_state(&prng,
