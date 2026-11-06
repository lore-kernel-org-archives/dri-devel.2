Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A7606D805
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pVRHUIi2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966AC10EA21;
	Fri,  6 Nov 2026 17:25:36 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54BA810EA21
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 17:25:30 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a018493d57so11475e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 09:25:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793985929; cv=none;
 d=google.com; s=arc-20260327;
 b=TgFg44mTjZ1wX62/PZ2WmI26xHnpRmajF+9B9m7l2JGIeZ0iBbjv857dWdcXzfHQwA
 WUP63gHDZLIJYSCco8Y24gry82UmaKSkxGSJDstw/QtMB83cHkTWAzn90O+Lwm3mYS9G
 9I17dIq1bQ9y+EZ5uOJkbu17qBE+va3kOfkpxfj/f6APVBWViAIJnY8AtHvNyWdhX4wP
 oaXLa7xDL9DVrcS/toBBDNXC1RQon9BBJVzcuWiYaRg+ZXmbpewe0KDdAJsdtHUuv2JC
 tCe6F+pR4Ejl0YdBFEyL4f0Q/Oiq2DOwthNo3IFtalXEVCJYb1kK7iS7Q6rh3wTAQijX
 9/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
 fh=vRS0LkLcYK6d1D+WWtbn2QirOyxTJVQuMfzjz9iUiCk=;
 b=p43QGO05328KTZTj4w7oa52Q0pLKE0diFrxpphiAP+5quwEOUQd3Ngjg5yuybeNnpW
 PXgWl2qrzRde/ZBKX45huGVAe/3kxwX+pbz96FLpyXLkrWvhKh6VRNim9ye501ngS7Ab
 AxauBbjvDcH3w5PVBbbkSLzafzbtAyEoh6p8Ekyzn9l2jPbxNbHBYZSHGY4BoRM0XBqg
 NqJUbI1N8OO7lkB+/EHZ5HbPZ2wiC4U9GXQMoQPLIVUZB6R3spEGyIjnaSQGwliGgiOz
 vPAH7RO9FBIHMjJXnxpg4n/xZ2TTh5RdjZD/uX6a0WSYryGMhTxwWPv4JoGRa8YSNqCS
 Xvvg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793985929; x=1794590729;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
 b=pVRHUIi2jTA+6U3IgdH7oeKcSexpwPuaEwsxwZblrvPwnpvRCDSS7kSxbwuizTUzcl
 IV07qb2A7bKgJjErDu46q1iuro7PcOnY3yiEqVSUKgrWHSvY5ALogptilrf5JT4SGhF4
 8lalwUhoUrlbEXjulDcP5hdF/808sV3oRuefOzVWq2tFuURX1nrrCOC36PSyHvrjGK2y
 P2+0RDDZ0g/vWFqz4L2ijdawY4OTqXeWKh+MY7mRCmft8lvDgz0MwRBp55NzgnxApj0u
 3Y6rUE76Ytjak3Xqwh7Vb0y0CMkehKvi1cbNX3jViz/MZVTqDEOBLenhQhPVvGy6mPNk
 qKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793985929; x=1794590729;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
 b=X7gqG3mIgAUc+nPL3/w/lbLQdUUStADRbJcW4WTq2nXp3qTrOouT2LcXXhHkLX8RLg
 YJBYb5xM7U9xNgKPjGMMoLwtLH7F8ycqfgN8MFNMjhh4aF3wt3BjMqRTU9qC1YOrAQ9U
 aEaNEVdVofY3GaO7FZk/waMsd8plG7j8nuo1dIZ2fTpP5JX5Bc5URkqQUhA55Zqdavc6
 Umfe3o4jFkFN9nqWfWUcnTLBhNoGekEQg7tJTtLXIfwh3vqfy+SoBmbzXMqjaHjYUw4j
 fmX5LW/Atus/2r4R3l69fBX/LQT7IYnbZn3VB8ci1zf6P3igqW/YElxdP3XEX3MTIL54
 Nk5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqyerYJHP8+3m1OTQ96p8YzN8UOnJ6Rcbe2HDCneO7LISaeQiX2qZf6yTlnw4nZd+NTF4PmCmO3Pw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/hz7CHixIk9QjTx3IdXOBUpR5Hd0aC953cDxRY94Vv92CtCZSM
 wvTUpfUl5AcLM86Q/eYEY0aem8VhUhJc5FTtwtN5zJF97QUDw27ZOIb15TNyUEKmBUs2lA+Q8YU
 0gndYQccVSuA7/REaNUOWEFw/+IEBfoZafYnlMl1K+EiX9Ufxogyz3TNKVXi7Fw==
X-Gm-Gg: AYBFou0AqWgnpdYX3SFTkCr7OEYSDI/0iHYkCjvqK2TwEYkXIbUM/GEJH8Hfz5otTvw
 4i2qCiXzXF9/Fh9gGmkmomoAn2gdYlduv0jVfrxLfIuc3Rox/jq7Twv3FKsvmjr+q3l6ElYs4mq
 1Bwh5i9XuX6xFgPEkaTUk2alko1X7jytBWrEQDz9iRPTpb2HM3THGGIunnx7z0hrYUndJYeED0Z
 hTOFexkYT5+OMfQ7kJJMlT4muccgvzm8A7d/Z+1qu8hULVE0Kjv8FWEzHGLdaTPeslYLl7E5jam
 n6JvqFaobsi81PtCTDrpyDrx2y/9vIm8KeWNGBLY+vuztxv0Ym0LQfAan/nUYEx28KhkHvxiaHf
 O4FhcpTrUYllDX4W56zF6um5PaUBITC0fpiA+RfwUFi/yG4pqzyCxhIMhbJNfhmzG3o7OxxlspT
 xilHMCqWTuE2aL18FjThAuZUYiEtShxUT7b34HLTzwuBCA
X-Received: by 2002:a05:600d:644f:20b0:4a2:a8c:22ae with SMTP id
 5b1f17b1804b1-4b78a315689mr14125e9.12.1793985928307; Fri, 06 Nov 2026
 09:25:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-3-cui.tao@linux.dev>
 <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com>
In-Reply-To: <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 6 Nov 2026 09:25:16 -0800
X-Gm-Features: AclHuK_zmhBLd-fBLwMoqE-7QVB_DAT0nisVVyTe7VWHd67XlQDn1ECR61povKo
Message-ID: <CABdmKX0nCB2hT+iMh=BB-nC=fUBPof8YvjvO-gtEw+zcHZgvZA@mail.gmail.com>
Subject: Re: [PATCH 2/7] dma-buf/udmabuf: account the page array metadata to
 memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tao Cui <cui.tao@linux.dev>, akpm@linux-foundation.org,
 dgilbert@interlog.com, 
 mkp@kernel.org, loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com, 
 vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com, 
 eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com, 
 rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org, jgg@ziepe.ca, 
 kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org, 
 James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org, 
 phasta@kernel.org, joro@8bytes.org, will@kernel.org, 
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com, robin.murphy@arm.com, 
 mason@kernel.org, aesteve@redhat.com, harry@kernel.org, vbabka@suse.cz, 
 cuitao@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 5:23=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 11/6/26 14:18, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> >
> > udmabuf pins the pages of a memfd and hands them out as a dma-buf.  The
> > data pages keep the accounting of the memfd they were instantiated in,
> > but the bookkeeping around them does not: the page pointer array and
> > the pinned_folios array, both sized by the buffer page count, plus the
> > transient folios array sized by the memfd folio count, are plain
> > GFP_KERNEL.  A 1GB buffer costs about 4MB of uncharged SUnreclaim
> > memory, and size_limit_mb defaults to INT_MAX.
> >
> > Charge the three kvmalloc allocations so the creator pays for the
> > metadata it induces.  The system heap in the same subsystem already
> > accounts its buffer allocation;

Only if the mem_accounting param is set to true. We (Android)
currently depend on it being disabled because system heap buffers
don't have a single owner for their entire lifetime (ownership often
changes immediately after they are allocated), and the kernel doesn't
have the ability to switch who is charged for the buffer memory quite
yet. Albert is working hard on it at the moment.

Could you update the message to note the mem_accounting param pls?

> > the data pages here stay with the
> > memfd.

memfd / udmabuf is a little special because it uses shmem for the
backing store, which is already tracked by memcg under all conditions
(except hugetlb). We don't currently use udmabuf, so the lack of memcg
charge transfer for udmabuf is not an issue. But once we get charge
transfer working for the system heap it'd be good to follow up with
udmabuf.

> T.J. needs to take a look here, but I fear that this might break uAPI.

Thanks for looping me in Christian. The buffer allocations cost
gigabytes, but these metadata arrays are only 4MB per 1GB of buffer,
so I don't expect charging them to break anyone. Leaving them
uncharged is an accounting gap though, since someone could spam many
udmabufs from the same memfd and only pay for the memfd pages once. So
this change is ok with me.

> A lot of the DMA-buf resources are intentionally not charged against memc=
g.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>

With the commit message updated to mention the mem_accounting param:
Reviewed-by: T.J. Mercier <tjmercier@google.com>
