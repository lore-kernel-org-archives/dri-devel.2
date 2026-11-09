Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05340606A320
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XL2WHWTD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5964C10ED1F;
	Mon,  9 Nov 2026 02:38:00 +0000 (UTC)
Received: from mta0.migadu.com (out-147.mta0.migadu.com [91.218.175.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF6D10ED1F
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 02:37:52 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=BSLLWUjqysUniWqaKos+1oTfbUDYuJJnNJuIc0pgFwo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794191871; v=1; x=1794796671;
 b=XL2WHWTDldq8dc4J+S5VCwQikjlgRsEG8sCdf/g6J4yLzejet5DgbiFD8IVyo9je8po4cF2p
 Jw0384EKoWqB18dC453JHT0pAHeiO2yXJCNMIF2qCFTC5OabTZPbEg7Hh2R6YOb90xpbTCYbOwD
 wx+r2xZlOW1wCBc0dsFb6yJU=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id d646f8317d3d17bd;
 Mon, 09 Nov 2026 02:37:50 +0000
X-Mizu-Trace-ID: d646f8317d3d17bd
X-Migadu-Flow: FLOW_OUT
Message-ID: <16b5464d-d4a2-420e-9de0-2ccddb860e3b@linux.dev>
Date: Mon, 9 Nov 2026 10:37:34 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, linux-mm@kvack.org,
 James.Bottomley@HansenPartnership.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
 will@kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com,
 robin.murphy@arm.com, mason@kernel.org, aesteve@redhat.com,
 tjmercier@google.com, harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn,
 media-ci@linuxtv.org
Subject: Re: [PATCH 6/7] io_uring: account the ring context and SQPOLL thread
 data to memcg
To: sashiko-reviews@lists.linux.dev, akpm@linux-foundation.org,
 dgilbert@interlog.com, mkp@kernel.org, loberman@redhat.com,
 jmeneghi@redhat.com, kraxel@redhat.com, vivek.kasireddy@intel.com,
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, rostedt@goodmis.org,
 vdonnefort@google.com, mhiramat@kernel.org, jgg@ziepe.ca,
 kevin.tian@intel.com, axboe@kernel.dk
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-7-cui.tao@linux.dev>
 <sashiko-outbox-202923@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <sashiko-outbox-202923@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

在 2026/11/7 21:27, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] io_uring: commit message omits rsrc and tctx changes and
>   uncharged allocs
Thanks for catching this.

You're right that the changelog should better match the actual changes.
Besides io_ring_ctx and io_sq_data, this patch also switches the
allocations in io_coalesce_buffer(), io_init_wq_offload(), and
io_uring_alloc_task_context() to GFP_KERNEL_ACCOUNT.  I'll mention
those explicitly in v2.

You're also right that "the last per-ring allocations" overstates the
current state.  Patch 7 still leaves some infrastructure allocations,
such as the percpu pieces and the io-wq cpumask, unchanged.  I'll drop
that wording and instead describe what this patch accounts and what
remains.

As for commits 075d5837bafc and 0b34e7b20a48, this series is based on
linux-next (next-20261104), which already includes the
io_uring-7.4-20261029 tag containing those commits.  If the review is
performed against a tree without that tag, those objects will indeed
still appear uncharged.

Thanks,
Tao
> --
> 
> commit 3d47975c4208930279f98824279734ca99b5e9bd
> Author: Tao Cui <cuitao@kylinos.cn>
> 
>> io_uring: account the ring context and SQPOLL thread data to memcg
>>
>> The io_ring_ctx and the SQPOLL io_sqd are the last per-ring allocations
>> made with plain GFP_KERNEL.  The larger surfaces around them are
>> already charged: io_mapped_ubuf and io_rsrc_node since commit
>> 075d5837bafc ("io_uring/rsrc: charge buffer arrays and nodes to memcg"),
>> the tctx node and its XArrays since commit 0b34e7b20a48 ("io_uring:
>> charge tctx nodes and personalities").
>>
>> Charge the context and the SQPOLL thread data the same way.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> [Severity: Low]
> Does the commit message match the actual changes and current tree state?
> 
> Alongside io_ring_ctx and io_sq_data, the patch also switches new_array in
> io_coalesce_buffer(), ctx->hash_map in io_init_wq_offload(), and
> io_uring_task in io_uring_alloc_task_context() to GFP_KERNEL_ACCOUNT without
> mentioning them in the subject or changelog.
> 
> The changelog also says these are the last per-ring GFP_KERNEL allocations.
> While commit "io_uring: account the remaining per-object allocations to
> memcg" later in the series converts io_alloc_cache_init() and io_wq_create(),
> percpu_ref_init(&ctx->refs, ...) in io_ring_ctx_alloc(),
> percpu_counter_init(&tctx->inflight, ...) in io_uring_alloc_task_context(),
> and alloc_cpumask_var(&wq->cpu_mask, ...) in io_wq_create() still use plain
> GFP_KERNEL.
> 
> Finally, the cited commits 075d5837bafc ("io_uring/rsrc: charge buffer
> arrays and nodes to memcg") and 0b34e7b20a48 ("io_uring: charge tctx nodes
> and personalities") are not present in the base tree, so io_alloc_imu(),
> io_rsrc_node_alloc(), io_tctx_install_node(), tctx->xa, and
> ctx->personalities remain uncharged.
> 

