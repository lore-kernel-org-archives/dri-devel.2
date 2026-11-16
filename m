Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C143606A322
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CWYbN7FQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE78C10EA33;
	Mon, 16 Nov 2026 20:33:46 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8AB10EA33
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 20:33:40 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-94965745d92so232703385a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1794861219; x=1795466019; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
 b=CWYbN7FQqbQNy66cXBJ0u3mYJ5ivvkywIRHr6CN6tkWjyI/UdYwa9DX91LqyV01jOC
 bE97FKRaEs2XfsDyY1nkcPEZisbQjVzKlIHB+a1eYSoHuBFUX1iitQhaWHU+RTXpXfwu
 qIT7rDksqmdpSe+bYaeV1AtBHdXjAA03qhQUNXzc3GcrDx1Q4yANTVC8QFq/TweApafx
 RkvV6DtoozBNkI3RVUpZpkbASKWHo/Lz1R/W5u63erhCwKdPF84xH6OWhRWkpR0P4ivd
 2oOzpHtmbJby2ppQvVJfKRpI7aVstntriO7d94aFkiEgO0vp+LhNUb7uSPHECuY7IKUL
 4hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861219; x=1795466019;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
 b=ejrUZ4pcjUDbJBKQQ7CIgiJ4K3T+RQYdcxPEzXcsmWM1c6Z2hGlQzBFBVbeApn1Ny6
 WrZ2St13tUAf7UArdNlj0OqrGLzZFpgNvkG9433TATuCzTVy+dwsxPUnKHHd3E2K3V9X
 3ZA5FTVd/iRZuxTLHPsYA1CiXVosxCvm/ux2TOJpKmhxIBVT8vJiu+uX2q48i1XtKojw
 uWbv2dgjdkIwaWpR1kW4F6YuaWja5UBfm2PWPl0wAtJOz0MFBKjlC3ogzh9dAYOwuN+B
 B5ganzntC9UdgfpIFfLtteXTovBrEzDwaoCFgHV+1zqVGOQ+oLEfNCd8bxUw/6wB22s7
 8a+g==
X-Forwarded-Encrypted: i=1;
 AL+hErHjIUQUGtt9kCgahYIHPKbp5mAlU65OFfxC/0xSMSuYvFsvCAijC8yMnXwhiqvRkm9NDTBMMsgXasQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/YrQnran6rGO6eqL8IqoRx0LlYs9b8AYiEsO0eba2SZNSEuDr1
 UVHcHH/lm3GbgGZtk71RuE0o0srxrdIQG3h5sjy6xspwmYAVnyaiifRSmZSFpmI7lFE=
X-Gm-Gg: AYBFou2CaG7vyfTSggRR0yoH9rrA9kbj2YKT+U/148G3iMGl1LDo99rBNp8h9DChxuX
 4g4bEsHdpHS01zQDoUVFO8Zlxq8uah9SIqBLDi/w28Jrk1KzSvbOGiWF9SwblUz9hNsiZY9oopc
 5J+poJ2mWAdwNYO7xM2e59MyEW6BPsu9+Lh+48+/flic6aCQRpLx0H8uxyVfBYYgH5SurU/EZXx
 DyvyjidqAfU9IcoguWxXEleFZO61ggPI6KhdetQqoJozMv7ZNhjLeqR+b7gAtjtj+062kYpxF9V
 1okPZ2Ii2ws/WHaz7YwWVN9WoM5vEIZvU7FQ3Gjb1QU8Ce3Isjnbghmt7DSchInv5QEcYwPNycK
 flA4ESAKcGpzVSj26JcAFSjnnmzv80CQlTejyJxVOH0d1GqSpa4YDZ+s+0RWutIH3EjVanWAyJh
 Zx5IllwHI9+A+snaNwVTJO7/yH5BL42IHBXzB8M2N9FVO8UuvO7z7Q762clYDEA+2HT3Y7UuUTT
 KV1JbhOZceISmpTlZJM5EW4VykFHLk7cBbwR7YEBvtzoY63UYoL9xNGWK4Glu9kQw35UKmfctVx
 3AWdLw==
X-Received: by 2002:a05:620a:46a6:b0:949:733e:ddd8 with SMTP id
 af79cd13be357-949733ee766mr1034555085a.54.1794861219140; 
 Mon, 16 Nov 2026 12:33:39 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c804f9esm930800685a.11.2026.11.16.12.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:33:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xT3OT-0000000ARJs-2rZa;
 Mon, 16 Nov 2026 16:33:37 -0400
Date: Mon, 16 Nov 2026 16:33:37 -0400
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
Message-ID: <20261116203337.GA2481588@ziepe.ca>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-6-cui.tao@linux.dev>
 <20261116195213.GF2452510@ziepe.ca>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116195213.GF2452510@ziepe.ca>
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

On Mon, Nov 16, 2026 at 03:52:13PM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 06, 2026 at 09:18:27PM +0800, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> > 
> > IOMMUFD_CMD_HW_QUEUE_ALLOC pins up to max_npages pages just to check
> > that a user supplied queue region is physically contiguous, and the
> > page array for that check is plain GFP_KERNEL.  The size comes from
> > cmd->length, a u64 that is only overflow checked, and the array is
> > freed again as soon as the contiguity check fails, so the allocation
> > can be repeated concurrently: a 1GB region costs about 2MB of
> > uncharged memory per attempt.
> > 
> > Every other iommufd allocation that scales with user input is already
> > charged, and the pinned pages charge the mapper at map time.  Charge
> > this array like the rest.
> > 
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> > ---
> >  drivers/iommu/iommufd/viommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I'll just apply it, thanks

Jason
