Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51273606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfvWjkj9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B224510E5E9;
	Sat,  7 Nov 2026 13:27:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71FF510E5E9
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 13:27:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E76AB60202;
 Sat,  7 Nov 2026 13:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD22F1F008A5;
 Sat,  7 Nov 2026 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794058052;
 bh=LeMCQcp+aNw2vY2DViJmjvnYhSi5FExNVb5PVTrMZ8I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cfvWjkj9ub0BgN3rJLFiTs4aeo/Bwv2O2u8hiotL6T3h0Og00tAicVZTQRMjal2N4
 YxBzIHsPtHFhBACJkAxTonpp6Wz4HYzPjpseNKyIYbkesT54caFh+LPEgc6KMapfg5
 SX8PpxZoYSz8Pd4l2MNDjMF8mwn8AbnyibfSLd9oVPzfGl6nPRD93q3QXTWjkIijkc
 z4p9pQU4AlO7M7qbmeSv9wDKXxIGzj3FKRfcnCRSeOvBHFFDlWt3mcSaWhgytNSPXL
 dFkn2e4AFuRBElNx1uwR8NN29zOq6SGVrSEm0f9XYa8NDnCPDe0zQMoEvsaeqhtSRp
 UHdFFwwUS1XWQ==
Message-ID: <sashiko-outbox-202923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] io_uring: account the ring context and SQPOLL
 thread data to memcg
To: "Tao Cui" <cui.tao@linux.dev>, akpm@linux-foundation.org,
 dgilbert@interlog.com, mkp@kernel.org, loberman@redhat.com,
 jmeneghi@redhat.com, kraxel@redhat.com, vivek.kasireddy@intel.com,
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, rostedt@goodmis.org, vdonnefort@google.com,
 mhiramat@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com, axboe@kernel.dk
Cc: linux-mm@kvack.org, James.Bottomley@HansenPartnership.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 joro@8bytes.org, will@kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
 mason@kernel.org, aesteve@redhat.com, tjmercier@google.com, harry@kernel.org,
 vbabka@suse.cz, cuitao@kylinos.cn, media-ci@linuxtv.org
In-Reply-To: <20261106131829.3228926-7-cui.tao@linux.dev>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-7-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:27:30 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] io_uring: commit message omits rsrc and tctx changes and
  uncharged allocs
--

commit 3d47975c4208930279f98824279734ca99b5e9bd
Author: Tao Cui <cuitao@kylinos.cn>

> io_uring: account the ring context and SQPOLL thread data to memcg
>
> The io_ring_ctx and the SQPOLL io_sqd are the last per-ring allocations
> made with plain GFP_KERNEL.  The larger surfaces around them are
> already charged: io_mapped_ubuf and io_rsrc_node since commit
> 075d5837bafc ("io_uring/rsrc: charge buffer arrays and nodes to memcg"),
> the tctx node and its XArrays since commit 0b34e7b20a48 ("io_uring:
> charge tctx nodes and personalities").
>
> Charge the context and the SQPOLL thread data the same way.
>
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

[Severity: Low]
Does the commit message match the actual changes and current tree state?

Alongside io_ring_ctx and io_sq_data, the patch also switches new_array in
io_coalesce_buffer(), ctx->hash_map in io_init_wq_offload(), and
io_uring_task in io_uring_alloc_task_context() to GFP_KERNEL_ACCOUNT without
mentioning them in the subject or changelog.

The changelog also says these are the last per-ring GFP_KERNEL allocations.
While commit "io_uring: account the remaining per-object allocations to
memcg" later in the series converts io_alloc_cache_init() and io_wq_create(=
),
percpu_ref_init(&ctx->refs, ...) in io_ring_ctx_alloc(),
percpu_counter_init(&tctx->inflight, ...) in io_uring_alloc_task_context(),
and alloc_cpumask_var(&wq->cpu_mask, ...) in io_wq_create() still use plain
GFP_KERNEL.

Finally, the cited commits 075d5837bafc ("io_uring/rsrc: charge buffer
arrays and nodes to memcg") and 0b34e7b20a48 ("io_uring: charge tctx nodes
and personalities") are not present in the base tree, so io_alloc_imu(),
io_rsrc_node_alloc(), io_tctx_install_node(), tctx->xa, and
ctx->personalities remain uncharged.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106131829.3228=
926-1-cui.tao@linux.dev?part=3D6
