Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC5FC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 21:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8D010F721;
	Fri, 26 Jun 2026 21:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KcRUmGoz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E93D10F721
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 21:55:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49AE541385;
 Fri, 26 Jun 2026 21:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BE11F000E9;
 Fri, 26 Jun 2026 21:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782510935;
 bh=uByLBAt7nuYNgTf94ZDcO0pD8wkSdi3uQnxpIe/Mg4Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KcRUmGoz3A7jcXzmzc1LZCV8UHFjZ5L0CnbjcnsV5s0NqJGVh8cROckDeXJWArPEg
 P0Rr0YQu/t3RSaMuxF+OCEDqB18JDp7T3o68Zq61UErTn5O/vD23z3ryRsBSkPD5El
 +8ffSpFCSYcquxTP382qaoqOdCmrLKl09o6LLYAhFFZxDGY7PX3nPJvhHdNkTs27yy
 csaXw9pXyY5tXGSAo4LxQX2KWRr42yNkqpA1Rmq6pouAVYXuuxfq4XWIyidZLqXh0D
 xEkdTe1Oo+GdFcsEA/KL4AnPns6bwD4io3n+r/TKGGaHoMMyUVqQhAyQiDJ2avR31g
 kOmyw0ALWFhmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/i915/gt: Return bool values from a boolean helper
To: "Andi Shyti" <andi.shyti@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626215232.861416-1-andi.shyti@linux.intel.com>
References: <20260626215232.861416-1-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 21:55:34 +0000
Message-Id: <20260626215535.05BE11F000E9@smtp.kernel.org>
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
- [Medium] The patch fails to fully implement the explicit boolean returns =
claimed in the commit message.
--

commit 0d74cf5750ffd2182532ac4105376be52c64bca2
Author: Andi Shyti <andi.shyti@linux.intel.com>

drm/i915/gt: Return bool values from a boolean helper

This commit updates intel_has_gpu_reset() to return false instead of NULL
when GPU reset is disabled via parameters. The stated goal is to have the
boolean helper return explicit true or false values.

Link: https://lore.kernel.org/r/20260625114442.2912230-1-andi.shyti@linux.i=
ntel.com

> diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915=
/gt/intel_reset.c
> index b2cf672564dd9..6053f3e8aa27c 100644
> --- a/drivers/gpu/drm/i915/gt/intel_reset.c
> +++ b/drivers/gpu/drm/i915/gt/intel_reset.c
> @@ -797,7 +797,7 @@ static int __intel_gt_reset(struct intel_gt *gt, inte=
l_engine_mask_t engine_mask
>  bool intel_has_gpu_reset(const struct intel_gt *gt)
>  {
>  	if (!gt->i915->params.reset)
> -		return NULL;
> +		return false;
> =20
>  	return intel_get_gpu_reset(gt);

[Severity: Medium]
Does this fully achieve the goal stated in the commit message?

Looking at intel_has_gpu_reset() in drivers/gpu/drm/i915/gt/intel_reset.c,
intel_get_gpu_reset() returns a function pointer (reset_func).

By returning intel_get_gpu_reset(gt) directly, the code still relies on the=
 C
compiler's implicit pointer-to-bool conversion.

Would it be better to return an explicit boolean value here as well, such as
!!intel_get_gpu_reset(gt) or intel_get_gpu_reset(gt) !=3D NULL, to fully al=
ign
with the commit message's intent?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626215232.8614=
16-1-andi.shyti@linux.intel.com?part=3D1
