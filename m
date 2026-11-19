Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9A1606A335
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtlR9L59
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5DF1123E2;
	Thu, 19 Nov 2026 13:36:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12C21123F2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:36:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B832466DC;
 Thu, 19 Nov 2026 13:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F3E1F000CB;
 Thu, 19 Nov 2026 13:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795095411;
 bh=4mL6ksnTx4P/6pkn/miSCvn7EM7e6lCs9QAdIgMUFoU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LtlR9L59+KfW98nEO6H7Yn9R/Iazv+amZTBqAa3mbNy9GvUW3nCQ/aDLc62eA3Nlu
 2j/LgsBq3sQK5eRaa9uAjiY9fIbwVlReAbDwntnYRA1gKJgRh3k7issXMWjRfX0Qfm
 cI+ZR2DMZjEUIDJqXzParPtvqmsofZ/ayNDNOT+yDaKogDcRvA6/nJG5EHHCEbFmuK
 OLrdgQ9CrxX6ZSKHEqdoqAHCBmiPqlXKZhFwGhiIEimWGHzU5y0bs/+cjanlwV+B9W
 CsmymceyCvqwiphFIr11KOWBR2goVTvo1qYsKTDvUmaxj2HRfPpe3MHwc6Vuv1AmNf
 KFD0Q4wuvu1Qw==
Message-ID: <sashiko-outbox-223186@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/sched: Fix memory ordering with
 dma_fence_overwrite_timestamp()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261119131830.2535266-5-phasta@kernel.org>
References: <20261119131830.2535266-2-phasta@kernel.org>
 <20261119131830.2535266-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 13:36:50 +0000
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
- [Low] drm/sched: missing kernel-doc for
  drm_sched_overwrite_scheduled_timestamp()
--

commit 4813d16b1085e58469356c4e77e1cbeb576347c5
Author: Philipp Stanner <phasta@kernel.org>

drm/sched: Fix memory ordering with dma_fence_overwrite_timestamp()

This commit replaces the manual timestamp flag check and assignment in
drm_sched_get_finished_job() with dma_fence_overwrite_timestamp() via a
new drm_sched_overwrite_scheduled_timestamp() helper.

> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 99252674e2668..a065a6d2eb1c3 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
[ ... ]
> @@ -898,6 +899,22 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sc=
hed)
>  	return IS_ERR(entity) ? NULL : entity;
>  }
> =20
> +/**
> + * drm_sched_overwrite_scheduled_timestamp - make timestamp more accurate
> + *
> + * Overwrites the timestamp of the provided scheduled fence with the one=
 from
> + * the finished fence, if the scheduled fence is already signaled. Does =
nothing
> + * otherwise.
> + */
> +static void
> +drm_sched_overwrite_scheduled_timestamp(struct dma_fence *finished,
> +					struct dma_fence *scheduled)
> +{
> +	ktime_t timestamp =3D dma_fence_timestamp(finished);
> +
> +	dma_fence_overwrite_timestamp(scheduled, timestamp);
> +}

[Severity: Low]
This kernel-doc comment omits @finished and @scheduled descriptions,
which causes scripts/kernel-doc warnings when building with W=3D1 or
generating documentation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119131830.2535=
266-2-phasta@kernel.org?part=3D3
