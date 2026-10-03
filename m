Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84FDCA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 02:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F7710E6DF;
	Sat,  3 Oct 2026 02:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EnMXg6ny";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE1F10E6DF
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 02:50:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E7ACB43D59;
 Sat,  3 Oct 2026 02:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD36C1F000FF;
 Sat,  3 Oct 2026 02:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790995799;
 bh=rimjOSFXyz7DhOUxIP6BXN5ffGeTmwt6H4YzXyIQjN0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EnMXg6ny5VC2qwdSytnmxpkmp278vUGLgHwMAuTX2FcLRzMygppcwkl3IbvC4XwQQ
 H8+horBcbscR7QtU8LigI/gHF58RzYvahBLtqpwQZALz2juFOjPkBYgOxyVUFhJ4Tx
 PkEeRSdXLv+ElegvkZqMZgD7UbETFwwsCQacsKZNjNRJyO1/spPgDRIkDxC5+P8Sr8
 MpwBtqI5L1tVQlPiv1f3BVG1puhrujse59bIecPGGBlSlt9lw4EYq5N2vduA58MPsN
 XKQbx0N/1rhRYmZJ+smDrBbgOhM0ZFevMLCKnw+rOIwi6gQcOrsrcRPqR+JKzNCJSb
 DdN4S1haIZPLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] accel/qaic: Isolate hw submission
To: "Carl Vanderlip" <carl.vanderlip@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003023818.1161666-4-carl.vanderlip@oss.qualcomm.com>
References: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
 <20261003023818.1161666-4-carl.vanderlip@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 02:49:59 +0000
Message-Id: <20261003024959.AD36C1F000FF@smtp.kernel.org>
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
- [Medium] qaic: redundant req_submit_ts assignment causes incorrect stats
--

commit 832ae6a6a52a6bd91f900e3b436da51c50e676e9
Author: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>

accel/qaic: Isolate hw submission

This commit merges two pathways used to submit a request to the DBC FIFO
into a single function. This simplifies the job submission logic in
preparation for using the DRM scheduler.

> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_dat=
a.c
> index 3326d9da0e1e4..0208400d2636f 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
[ ... ]
> +/* Caller should be holding dbc->req_lock */
> +static inline int qaic_submit_reqs_to_hw(struct bo_slice *slice,
> +					 unsigned int num_req,
> +					 bool is_partial, u32 partial_size)
> +{
[ ... ]
> +	tail =3D (tail + num_req) % dbc->nelem;
> +
> +	/* Submit_ts will be taken for the last job of this BO */
> +	bo->perf_stats.req_submit_ts =3D ktime_get_ns();
> +
> +	/* Finalize commit to hardware */
> +	dma_sync_sgtable_for_device(&dbc->qdev->pdev->dev, bo->sgt, bo->dir);
> +	writel(tail, dbc->dbc_base + REQTP_OFF);
>  	return 0;
>  }

[Severity: Medium]
Does update_profiling_data() unconditionally overwrite this new timestamp?

In the IOCTL path, __qaic_execute_bo_ioctl() calls send_bo_list_to_device(),
which eventually reaches this code and records the per-job timestamp.
However, immediately after send_bo_list_to_device() returns,
__qaic_execute_bo_ioctl() calls update_profiling_data(&exec):

static void update_profiling_data(struct execute_info *exec)
{
        ...
        for (i =3D 0; i < exec->count; i++) {
                bo =3D exec->bo_arr[i];
                ...
                bo->perf_stats.req_submit_ts =3D exec->perf_stats.submit_ts;
        ...
}

Could this render the newly added per-job timestamp dead code? Since this
refactoring prepares for the DRM scheduler, might this overwrite also cause
a data race or incorrect profiling statistics when submissions become
asynchronous?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003023818.1161=
666-1-carl.vanderlip@oss.qualcomm.com?part=3D3
