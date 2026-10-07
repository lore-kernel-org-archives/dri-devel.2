Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3BCCA6007
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE5410E483;
	Wed,  7 Oct 2026 14:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="iDj1cgYt";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DEF10E483
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1791384182;
 bh=Vy/SqPR2iRJy+qH2zNvd5P2288DBcyzZTTebwGhXmmo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iDj1cgYt3A0i04M2ayQrIeQD8r2hmTUox//NvpuJMBgb9DAJGJgDjG+45BDvpKfAn
 YGWxBZIr+jOJGuGraDsDKknuoYlTQXy/MvRh+NRtDQlpY3fBJIndRDaWMOWrODf5YK
 +uZlsuORBlsm7MgvchZvA88okEqAQn8quST5REy2c6jn705dZR8ytJwAUsBocB7BeU
 MiZw0J79WZOWR2fmJb+e9wJULTpZkCvH0J6cR3rJR7390Yz/j3S2sWKOiQZCCaRkCw
 hfK+kSaXQl4TWkQWHbBxytFYU3JeT/A7DO5xRVzinzMDiZ2R2+BfnFLTHJpjXMjAeZ
 2DdvZFRErtdkA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4j0G7j0fjYz4wKm;
 Thu, 08 Oct 2026 01:42:56 +1100 (AEDT)
Message-ID: <88a14307-37a2-4081-b5b1-039d4f64a6da@ozlabs.org>
Date: Wed, 7 Oct 2026 15:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Annul dmabuf->file on file release
Content-Language: en-GB
To: Alex Mastro <amastro@fb.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex@shazbot.org>
References: <f8efaabd-c06e-4f04-8cfa-489c148e37ba@ozlabs.org>
 <asYOmaPqwUOBdz0x@devgpu015.cco6.facebook.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <asYOmaPqwUOBdz0x@devgpu015.cco6.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Alex,

On 07/10/2026 10:19, Alex Mastro wrote:
> On Tue, Oct 06, 2026 at 08:15:26PM +0100, Matt Evans wrote:
>>  static int dma_buf_file_release(struct inode *inode, struct file *file)
>>  {
>> +	struct dma_buf *dmabuf = file->private_data;
> 
> I think dmabuf can be NULL here if the dmabuf allocation fails during
> dma_buf_export().
> 
>> +
>>  	if (!is_dma_buf_file(file))
>>  		return -EINVAL;
>> -	__dma_buf_list_del(file->private_data);
>> +	__dma_buf_list_del(dmabuf);
>> +	/* Must be observed by __get_file_rcu() before file_free() */
>> +	smp_store_mb(dmabuf->file, NULL);
> 
> Resulting in NULL deref here -- guard with null check?

Oof, yes!  Thanks for catching this.  __dma_buf_list_del() protects
itself against a NULL arg.  Done.


Thanks,

Matt

> 
>>  	return 0;
>>  }
> 
> via this path
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc29..557cd7a4c971 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -725,6 +725,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  	if (!try_module_get(exp_info->owner))
>  		return ERR_PTR(-ENOENT);
>  
> +	// succeeds
>  	file = dma_buf_getfile(exp_info->size, exp_info->flags);
>  	if (IS_ERR(file)) {
>  		ret = PTR_ERR(file);
> @@ -739,6 +740,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  	dmabuf = kzalloc(alloc_size, GFP_KERNEL);
>  	if (!dmabuf) {
>  		ret = -ENOMEM;
> +		// go here
>  		goto err_file;
>  	}
>  
> @@ -771,6 +773,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  	return dmabuf;
>  
>  err_file:
> +	// ends up calling dma_buf_file_release()
>  	fput(file);
>  err_module:
>  	module_put(exp_info->owner);
> 

