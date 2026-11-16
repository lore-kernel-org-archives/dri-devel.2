Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE89606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=V4Zp+urQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776BA10F426;
	Mon, 16 Nov 2026 19:52:22 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3766610F42C
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 19:52:16 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-5365f9a04c5so65776771cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1794858735; x=1795463535; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
 b=V4Zp+urQhhfNz9ZuHdvOaB+I9WAIw4EZkFp+BuzS7gxLX9PV3Li17kbP05pdbxTVls
 Wbn/XibJ+F6BBIsqv9ekaAqq8QKN4/9VAhmLky/LooAKTljySkDydZlIbjVVhk7RP4zI
 O3eR7OpRIqj282/3OIEKvCGMRAnxey4efJYF8f3ZWkKJsidf72EONKEPQJ9632PIiG44
 Y2gVRMBd/imbrZDP9hmfSZhkqmPmLvsNFQpoGTTPGop66HQHt7k3F77Sg7z/N/TsglJX
 TmaGAMegTiBVTHnJunRMMB4+mymcKFNpYC0aDfWjBYekopzSbZYX2ZeK4jF7YeSu4czd
 sUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794858735; x=1795463535;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
 b=kY9neGLrNoSKYyeiBl0kaf1VA3ZXfecRiu2ZOk5JN2p0IavuLAuolEIggtDrjfFdiu
 2fg2i8NZQTHT78qpcg5kUCfjPkGxnnpeA3w62r5XUhWwk8ydz/RXDVam3KLlJP27GYZN
 qmSrT9/2g8zGgp3sTsvApflfJGaOduURLTCbpca1YSBR68vbviDBMxkAc+sUu309ixrR
 0uYgngJm6z3ngh23oHIQde/S9yOuNMGYYpp2b9BOd1ulStXcCuWtbutgqYoxfyy5z7L1
 JImPLhJLp+9CwppYQOVgDYZeL5KL3w1vlGiYk2eRp5AdkcH/ImGUskho5alyXOpcf6Yr
 O4Fg==
X-Forwarded-Encrypted: i=1;
 AL+hErHOm7boVXwLyB+g5Hv7b1DWZgx3xI3SRtq27n8aVFEsCp1cLGAzotnSi2ajdmmR8eYWZG44F71tDQ8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9cy/qcSTMCrlFNzrg3jpvWABt2eE42/NxM2O49CWYfWyrVJ7fg
 ii9nMUpVLrKqlu0iaBL+T/wWnyXcTxKqymtu3jyJpsWKlr596X5TJKKBh9HMxsv0zk4=
X-Gm-Gg: AYBFou18qpsCtNemmf2md3W1gEy7Hiie76b6Xce7qJ00e6ywLToy5aH63Oyj0D2el0Q
 JoJKVxB2jzzDiTluS3UKGo6/OiD2gIYoRTKqVQzt2F43bfmc/eHdj/AHUXg9fpCK9h4ZZC8re1q
 QABb5iND87JyhkxCpKop5Jy8Q6UIuNiNefO0Abke+dzyqpIhfLN9Y/vDNEBh8x3hjFTc/UywpOn
 TFh9b4ogcEmZAT/xzYlActhnyoturRmxbivvAK2/GlYAfzKvXAwxBrI0Oi/dc3Z814idO6jfR50
 XrLmtupSp8FlyMYwDgwWmLRdj1/1UKqeZdTRvOLo7sICv1EjdxI6BOG6gUypUMFipwrOz1mDPCK
 CW/wSkOoCJs7pyc3oNcP0USLG5zkYixtdi/61DrJtpfSG78SiAW6J1EGQfXfwymK1FyYqci0cQr
 iu2+OIHdRWTx3BEpbV3pYLKnkJAz8685rQaAnyn0w5UH0A8k6974qvK5acTxMG7coHvABm5ZHbK
 sJITfq0yYrLN+/cfBKiHB/Q+3Q+z+GPxor0hT0esfUXCW8jERWZ1fCcufiit83GP92GytJf15h/
 1s/4Hg==
X-Received: by 2002:a05:622a:13c6:b0:55c:c7ab:4445 with SMTP id
 d75a77b69052e-55cc7ab469bmr121785021cf.29.1794858734926; 
 Mon, 16 Nov 2026 11:52:14 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f8319d44bsm48973876d6.4.2026.11.16.11.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 11:52:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xT2kP-0000000ALbT-12cG;
 Mon, 16 Nov 2026 15:52:13 -0400
Date: Mon, 16 Nov 2026 15:52:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
 loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
 vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
 rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
 kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
 James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
 will@kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
 mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
 mason@kernel.org, aesteve@redhat.com, tjmercier@google.com,
 harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
Subject: Re: [PATCH 5/7] iommufd: account the hw_queue page array to memcg
Message-ID: <20261116195213.GF2452510@ziepe.ca>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-6-cui.tao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106131829.3228926-6-cui.tao@linux.dev>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 09:18:27PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> IOMMUFD_CMD_HW_QUEUE_ALLOC pins up to max_npages pages just to check
> that a user supplied queue region is physically contiguous, and the
> page array for that check is plain GFP_KERNEL.  The size comes from
> cmd->length, a u64 that is only overflow checked, and the array is
> freed again as soon as the contiguity check fails, so the allocation
> can be repeated concurrently: a 1GB region costs about 2MB of
> uncharged memory per attempt.
> 
> Every other iommufd allocation that scales with user input is already
> charged, and the pinned pages charge the mapper at map time.  Charge
> this array like the rest.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  drivers/iommu/iommufd/viommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
