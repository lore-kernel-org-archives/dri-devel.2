Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CEDC5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 16:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE85110EBE9;
	Tue, 18 Aug 2026 16:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TwJ0J9fC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1310510EBE9
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:13:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D826E41347;
 Tue, 18 Aug 2026 16:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A761D1F000E9;
 Tue, 18 Aug 2026 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787069615;
 bh=4us3wz48kFzF8azi4/+qYSw+1k3/WMkILHZtIRU6s5s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TwJ0J9fCfUz3Q9WUBENTO6359NaAPN5KfKkky726zsCsmxkv/KlyJC8n3TeO1OQ5M
 1hWRz4NMG2ECIFCyuCDeXodezZfqbEJ6omXuCJpkEc1ajMbaVqPihKN3ytpvxsXKaT
 FXn+phVbviLSD8MAmljA3z/undKjMpTNuDEs/y6PzfhORCWR4of7hq24eXh1XCfBce
 6On4U/wfrW6Tl7ODe27orolfwv2juLCKBqUqaYXfCXyIKEGn9/zbf//XpUnGJtHp/4
 R/K8PhCTJhpFQZL1oU/J2nsgbisL3CSWO5oVEDQlyuOTv5AzxU11V3F11GMKuYxFkq
 l2eD0I92toolw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] drm/ttm: drop stale @ctx kernel-doc entry
To: "Sean Chang" <seanwascoding@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818160914.108313-2-seanwascoding@gmail.com>
References: <20260818160914.108313-1-seanwascoding@gmail.com>
 <20260818160914.108313-2-seanwascoding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 16:13:35 +0000
Message-Id: <20260818161335.A761D1F000E9@smtp.kernel.org>
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
- [Low] The commit message incorrectly claims it is fixing the documentatio=
n for `struct ttm_bo_alloc_state` rather than the function `ttm_bo_alloc_at=
_place()`.
--

--- Patch [1]: [PATCH v1 1/2] drm/ttm: drop stale @ctx kernel-doc entry ---
commit eda6deffe5de61d4cef4644920a61899181f3f40
Author: Sean Chang <seanwascoding@gmail.com>

drm/ttm: drop stale @ctx kernel-doc entry

This commit removes a stale @ctx kernel-doc entry in ttm_bo.c to fix a
documentation mismatch.

> ttm_bo_alloc_state no longer has a ctx member, but its kernel-doc
> comment still documents @ctx. Remove the stale entry so the
> documentation matches the struct.

[Severity: Low]
This isn't a bug, but is this description accurate?

The commit message states the documentation for struct ttm_bo_alloc_state
is being fixed, but the modified kernel-doc block actually documents the
function ttm_bo_alloc_at_place().=20

It appears the diff chunk header below mistakenly picked up the struct=20
definition from earlier in the file, which may have caused the confusion.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index ef56c18ded1b8..943297b49dc53 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -506,7 +506,6 @@ struct ttm_bo_alloc_state {
>   *
>   * @bo: The buffer to allocate the backing store of
>   * @place: The place to attempt allocation in
> - * @ctx: ttm_operation_ctx associated with this allocation
>   * @force_space: If we should evict buffers to force space
>   * @res: On allocation success, the resulting struct ttm_resource.
>   * @alloc_state: Object holding allocation state such as charged cgroups.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818160914.1083=
13-1-seanwascoding@gmail.com?part=3D1
