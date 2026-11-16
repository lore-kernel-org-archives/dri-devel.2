Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2BE606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fTZBzur3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B0AD10EE1A;
	Mon, 16 Nov 2026 18:32:38 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE09010EE1A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 18:32:32 +0000 (UTC)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ae72da2f57so6059930a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794853952; x=1795458752;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6Mzo85W8swCv3RAdLaxrajaoqyjLMw0IEsk0L6cWkMQ=;
 b=fTZBzur3Apyy5uSRehyZzjr4AFWBEDYwnFRInZMLQhvGps8h9ZVaqZMOukqM/z7Mh8
 FXuC2w+N1YBBwDeL7aLg/sCJJfIzMNB1gUnW6aYRsV1J2LTmpUROxDVZY00rJgHVa+qI
 p+yUPL1SQ7hRDYwj5CZBqn1tjWzQoqm5XNjdiNhPKnEF8dMwES87VmPYVbuC+Jd8cb75
 wQuDrygppr29+ibzK+vIEbQXeMiYEC6/b4W9GJNeBpp1h5E1a49g1RDuxO+14zPrIBtk
 i+np3JGsEPEXXABKi5TIo017MP89OSjk92FQ2Y2TF67RcVEtbdrActKc2A7lWiaMsvmL
 nDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794853952; x=1795458752;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Mzo85W8swCv3RAdLaxrajaoqyjLMw0IEsk0L6cWkMQ=;
 b=hRSqj+wKOHXuMHX5KCcvaqw7xCVxx0jiwMuhjS05pxT/K4pMWETBCU1hygAR0TSslt
 TBOkq/YKD8fWGmk2z5DLlU5pjICjJ7ToOGxHBkCeCJEsl7SlT4LeJz1SzN8gvGnwYrry
 Qu0puUqVYxUNYgxpq/CROFUmn9wlaBd6/rCZqTlOIw9IQXwwR31w5jA/e0tnocurXyqD
 sQQP56YGfaUVdyP0D/bbynV616h2D2Ok4WIBqWAzYgZk94e3hVbPCMlv4j5zAyXrV8HD
 VBmquVmGUwQ8PkOnVmFWB4szNv5yDNjLyxJV7NLmQDODZbfiyw6hpbIlWQyD/eJ2z5Xq
 2IHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHgtMviSep3MzWe/dZkTgORUSXYoap8YpkUdoR5vOoaCg9Ho2BWGC9yC2F8nCAdou/kH1NNm/dbUmU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/HuME2U9kso0I45dbl1ZDEmwyI6zz19mRc+VK8gozTXC9XeT+G
 KW9PcBxLG/uphZH0Zm+dAUr5n9HgsEYdIUjhyAjtrjdwL9reyvIpC1cCQT73sJA4kJYWqABovdg
 hmNPkhlvuQg==
X-Received: from plai1.prod.google.com ([2002:a17:902:c941:b0:2eb:16af:1567])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:da86:b0:3ab:36c4:b500
 with SMTP id 98e67ed59e1d1-3b1b089e0ffmr12560971a91.5.1794853951522; Mon, 16
 Nov 2026 10:32:31 -0800 (PST)
Date: Mon, 16 Nov 2026 18:32:22 +0000
In-Reply-To: <20261029125143.1744481-2-phasta@kernel.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261029125143.1744481-2-phasta@kernel.org>
X-Mailer: b4 0.17-dev
Message-ID: <179485394213.2938203.5775705349664994300.b4-review@b4>
Subject: Re: [PATCH] usb: gadget: f_fs: Remove deprecated dma_fence->ops
From: Neill Kapron <nkapron@google.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Neill Kapron <nkapron@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?utf-8?q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Paul Cercueil <paul@crapouillou.net>,
 "=?utf-8?q?Nuno_S=C3=A1?=" <nuno.sa@analog.com>, Sam Day <me@samcday.com>, 
 Michael Bommarito <michael.bommarito@gmail.com>, 
 Gabriel Prostitis <prostitisgabriel@gmail.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The dma_fence_ops function ops->release() has been deprecated because it
> prevents drivers from unloading. f_fs's implementation merely frees the
> fence. The dma_fence backend performs this deallocation automatically in
> the correct manner if ops->release() is not implemented.
> 
> The backend simultaneously correctly frees struct ffs_dma_fence since
> struct dma_fence is its base class.
> 
> Remove ops->release().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  drivers/usb/gadget/function/f_fs.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index c64a268e98a4..e8672b37e890 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1479,18 +1479,9 @@ static const char *ffs_dmabuf_get_timeline_name(struct dma_fence *fence)
>  	return "";
>  }
>  
> -static void ffs_dmabuf_fence_release(struct dma_fence *fence)
> -{
> -	struct ffs_dma_fence *dma_fence =
> -		container_of(fence, struct ffs_dma_fence, base);
> -
> -	kfree(dma_fence);
> -}
> -
>  static const struct dma_fence_ops ffs_dmabuf_fence_ops = {
>  	.get_driver_name	= ffs_dmabuf_get_driver_name,
>  	.get_timeline_name	= ffs_dmabuf_get_timeline_name,
> -	.release		= ffs_dmabuf_fence_release,
>  };
>  
>  static int ffs_dma_resv_lock(struct dma_buf *dmabuf, bool nonblock)

This makes sense to me. 

Reviewed-by: Neill Kapron <nkapron@google.com>

-- 
Neill Kapron <nkapron@google.com>
