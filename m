Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B101BCD98CE
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44AAD10E7B2;
	Wed, 10 Jun 2026 07:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m7T+xXiF";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F09610E545
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 14:58:32 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2bf237e1433so63016755ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781017112; x=1781621912; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eFoSbz/qa2j2QRMMIew+HXblnpoKHM6VjME/GNmQDGg=;
 b=m7T+xXiFIr38WPZTtiIYhUgs1/6nvV0Kd/kxkFJxiZscWXQJLzzZXqx/UH9Xh7iaCo
 +4v/ZiMjZ46EtGsp7W8Zn6oZpLMSjmWqpFO8CXK/0R23W3X9KEjyJU7zbhbfDb8Z6qag
 0+rRw9bTPeOAO74rxoBD4pD7F88z+TsbWBrnnXYM/5mRzeHhGBmj02N1OIlNw/Wj8zA4
 MK5oYSbiM/tLkQEZdTc4XwG0R5cqv1cBxPCIbblNSW6VIH0BB5hqm0PAQS9O8r9oSre6
 4l+jKo5qtcMKj0Y+0W3oXM4LTfGvhhfXHMR02tlps5E0Ntza8bY0CoIE970U3AIbckOd
 JweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017112; x=1781621912;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eFoSbz/qa2j2QRMMIew+HXblnpoKHM6VjME/GNmQDGg=;
 b=dRW0yr+keeVnPunXGFZxD8g3nDoRqB85qEoK4dR7PsQx+rXS3X4s6kAvUWvaBC5t7m
 2SKCi82py4lVOoAqIV7Wfut7mSY8z290mRo7Hy+UnjCXCJxkGgA69NIAx/GMY4vV+F0k
 a5p5gRb990frww/PwZ0wseHizQ9DtMPVyPATuCCx2Dfgini4IWCHSCGLFbeRfW1UPGbF
 LoA+KK61SCdTfVqRmjfb6drX9sGu5EtJI7Vc/yYKJhdgJ8ul8VUk0eSYfSx6bUle0Loe
 y/6GpG05x3q5prnEYR8FPK2HBn8X3z0QVkc51yKlAwZYsZnV7qTge49kMtSnYmQq2YZp
 iKVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PYDOdMeduGjg/QuSxrUO03ZeaF+8mS72fLFgrcd1p7UcwYnckXx3mn/TF6sk0oX4Bb+013kA7tKM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywg53F5zSTchNlZWH6EC6jUIGNI1agJX1w01uXeoXK3d21f5j4h
 iqhy5nfUW3Wp4K+x332WJQMeWK7uQSUnZcuipG9s5dnqNo5KLX8kZyQ+
X-Gm-Gg: Acq92OH9KlB576m3w3d8kgyg9zQ+vJQpjBwshjiPnBMGJWO8eyaMGS1l3Crxh9FS50G
 mo0OHQ4EOx47rPXY2T/O0CKlQDuhbMeg30xS3ziRP1dcO4LpZWkvioY7IkTRV9vD2oY6x4JbBcw
 LGhRbW3MZUuP0kppMjCxKH5qsbaL/yhLAHyPGffzDXGPjPrFszbaSR34zAVG6qb/P4IdZgTY88Z
 laZ0nE4f+TWbxs7WOrQ+XGdnyaJbULkZaNrSIDGobLinKXM1QByNSYmWYOr5CfRlFiqdFACR1Xo
 /gzwwT8gpGht+vPgczmbqa7Uc3X/1BEee49+8VhGy0BELo5LUXhzEdustI/yNYi6WYy0yOx2dxh
 2BjKrthNpHzvwvBgc3xjDOYn5B9Hpy+7Pun/LIyc9LphnByMOY3Ezna2nIRDN2Sq2vh3XNBuy90
 tdcnCw2ujEamlFs4Lz2qNNA2oKDoUxG45RFBelY7kjHu6KCjfDNGOXnA==
X-Received: by 2002:a17:903:3885:b0:2c2:27be:39a9 with SMTP id
 d9443c01a7336-2c227be3b30mr199425095ad.9.1781017111918; 
 Tue, 09 Jun 2026 07:58:31 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:3::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f87920sm219844645ad.24.2026.06.09.07.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:58:31 -0700 (PDT)
Date: Tue, 9 Jun 2026 07:58:29 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me,
 razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
 matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
 Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 2/4] udmabuf: emit one sg entry per pinned folio
Message-ID: <aigqFQWzPkiSh3ie@devvm29614.prn0.facebook.com>
References: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
 <20260603-tcpdm-large-niovs-v1-2-f37a4ac6726c@meta.com>
 <bdce2488-fe77-4f36-9ed6-dd2c785fa7c1@amd.com>
 <aiMY8CpckM8Jav0g@devvm29614.prn0.facebook.com>
 <0c86f5d3-b5e9-4cac-aa9d-30c5c8ecca66@amd.com>
 <CAKB00G3opAoAYswsq2uz0Q6jgku8u4NthKOzCbSumZ0qK7QxcQ@mail.gmail.com>
 <a51e97bd-39dc-492f-bd7d-f137423277df@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a51e97bd-39dc-492f-bd7d-f137423277df@amd.com>
X-Mailman-Approved-At: Wed, 10 Jun 2026 07:58:35 +0000
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

On Mon, Jun 08, 2026 at 03:59:04PM +0200, Christian König wrote:
> On 6/8/26 15:55, Bobby Eshleman wrote:
> > 
> > On Sun, Jun 7, 2026 at 11:42 PM Christian König <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
> > 
> >     On 6/5/26 20:44, Bobby Eshleman wrote:
> >     > On Fri, Jun 05, 2026 at 11:30:07AM +0200, Christian König wrote:
> >     >> On 6/4/26 02:42, Bobby Eshleman wrote:
> >     >>> From: Bobby Eshleman <bobbyeshleman@meta.com <mailto:bobbyeshleman@meta.com>>
> >     >>>
> >     >>> get_sg_table() emitted one PAGE_SIZE sg entry per page even when the
> >     >>> underlying folio was larger.
> >     >>>
> >     >>> Instead, walk folios[] and emit one sg entry per folio. When folios
> >     >>> represent large pages (as is for MFD_HUGETLB), each sg entry is a large
> >     >>> page. Normal PAGE_SIZE sg tables are unchanged.
> >     >>>
> >     >>> Required by net/core/devmem to support rx-buf-size > PAGE_SIZE with
> >     >>> udmabuf.
> >     >>
> >     >> That doesn't explain why this is required.
> >     >
> >     > Sure, can definitely add. Devmem currently requires dmabuf sg entries to
> >     > be length and size aligned when it allocates niovs for NIC page pools.
> >     > Though udmabuf is not violating any dmabuf contract by emitting
> >     > PAGE_SIZE entries and the above restriction is probably more a
> >     > shortfalling of devmem, by emitting a single entry per folio this patch
> >     > allows udmabuf to be used by devmem for large pages.
> >     >
> >     >>
> >     >> Please note that accessing the pages/folio of an sg-table returned by DMA-buf is illegal and strictly forbidden!
> >     >>
> >     >> Regards,
> >     >> Christian.
> >     >
> >     > It seems both devmem and io_uring zcrx at least introspect through to
> >     > the sg-table to build NIC page pools (not accessing the memory itself,
> >     > however). Is there a better way?
> > 
> >     That's an absolute NO-GO! We need to stop that immediately.
> > 
> >     Touching the underlying struct page of an DMA-buf exported sg-table is strictly forbidden.
> > 
> >     We even have code to wrap the sg_table and hide the struct pages on debug builds to catch those issues, see function dma_buf_wrap_sg_table().
> > 
> >     My last status is that the NIC page pools are build directly from the DMA addresses exposed by the sg_table.
> > 
> >     Was there any change I'm not aware of?
> > 
> >     Regards,
> >     Christian.
> > 
> > 
> > Oh no change, your mental model is still current.
> > They just go through each sg and use sg_dma_address() on each.
> 
> Ah, thanks! That was a near heart attack :D
> 
> Yeah that is perfectly correct, question is do you then still really need this udmabuf change? I mean the DMA API usually merges together contiguous DMA addresses.
> 
> Regards,
> Christian.
> 

Hey Christian, sorry for the delay I justed want to double check what
I'm seeing...

I reverted the udmabuf patch and confirmed devmem still runs into 4K
pages even for hugepage udmabuf. I see that the dma_map_direct() path is
being taken, which if I am reading the code correctly results in the
sg_dma_len(sg) inheriting sg->length directly (set by udmabuf's
sg_set_folio(..., PAGE_SIZE) call), compared to the iommu_dma_map_phys()
path which looks like it does merge when possible.

Best,
Bobby
