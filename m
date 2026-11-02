Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB866079A9C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=KxXAAmYX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5320010EFD4;
	Mon,  2 Nov 2026 15:13:56 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18FB410EFB3;
 Mon,  2 Nov 2026 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1793632426;
 bh=G6oVY4CE3e6dkzK5lDm8qodLP62nbKSQOgzSCbSLRbI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KxXAAmYXGj8561ePKtJyEh1YoOniqny80/nhZgKKxv/uC/hBtUj0XItevaoVP2CO+
 J8SuQAWZHnLZyciYLh0uMHdgTgXb380DvrF/jjr1/a2kYtmD8DhdYn9SwFdbKz2Bwu
 vx1mC2eQ8cZv2VIqv4g5axpk0iyAEBtwkH0uAIaUWlTQJwPjvkvFoP5ReTK3Hd8mg/
 z0+irlVlhQ1SaycZe1h102Sy7sWwC/KUCvor+grh5p23MlTlDV37ppLhtp6XRZf+K7
 jfpx4eTW+6evip+T/F0+wVjniVeqZPcYEvKtjwjYNBGpLwHf8r7TC7shTgVXiZGd19
 dL/Czg6St8FcQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4jJFb60P30z4w0H;
 Tue, 03 Nov 2026 02:13:37 +1100 (AEDT)
Message-ID: <e9464db2-0cfa-4a61-8adc-eee51e30fd05@ozlabs.org>
Date: Mon, 2 Nov 2026 15:13:26 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] dma-buf: Annul dmabuf->file on file release
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Zack Rusin
 <zack.rusin@broadcom.com>, Zhenyu Wang <zhenyuw.linux@gmail.com>,
 Zhi Wang <zhi.wang.linux@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gfx@lists.freedesktop.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Alex Mastro <amastro@fb.com>,
 Alex Williamson <alex@shazbot.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, stable@vger.kernel.org
References: <20261013120211.135807-1-matt@ozlabs.org>
 <20261013120211.135807-4-matt@ozlabs.org>
 <3e3e0974-20f9-4aaa-a6b8-a7fb4727ad8e@amd.com>
Content-Language: en-GB
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <3e3e0974-20f9-4aaa-a6b8-a7fb4727ad8e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello DMA and DRM folks,

On 13/10/2026 13:13, Christian König wrote:
> On 10/13/26 14:02, Matt Evans wrote:
>> The dmabuf release path is split between file and dentry release:
>> dma_buf_file_release() is called shortly before the file is freed, and
>> dma_buf_release() calls an exporter's dmabuf->ops->release when the
>> dentry is freed.  However, the dentry can outlive the file (for
>> example, if opened with O_PATH), meaning .release might be called some
>> time after the file is freed.
>>
>> This presents a window, when closing a DMABUF file, in which
>> dmabuf->file points to freed memory yet .release op has not yet been
>> called.
>>
>> For VFIO, if a buffer's .release has not been called it's considered
>> still active and subject to move/cleanup.  If so, it attempts to
>> get_file_active() on dmabuf->file: a file close with dentry held open
>> will call this function with a stale pointer, a UAF.
>>
>> To make this pattern safe, set dmabuf->file to NULL in
>> dma_buf_file_release() to reflect that the associated file is now dead
>> even if the DMABUF is not yet gone.  A get_file_active() ... fput()
>> sequence concurrent with a file close then only executes as one of:
>>
>>   - Gets the file before file_ref_put() (dmabuf->file valid)
>>   - Observes dmabuf->file pointing to a file, but it's DEAD (no file)
>>   - Observes dmabuf->file = NULL (no file)
>>
>> Originally, drivers could assume dmabuf->file was valid until .release
>> was called from fops->release.  This assumption was no longer valid
>> after 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
>> dentry_ops"), which moved the callback to the dentry release (by which
>> point the file might have been freed).  With this commit, drivers must
>> still consider that dmabuf->file could be NULL before .release.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentry_ops")
>> Signed-off-by: Matt Evans <matt@ozlabs.org>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>

Thank you.  Zack's also added R-Bs for 1/3 and 3/3, and Zhenyu an Ack on 
2/3.

If this is acceptable, which tree would you recommend could take this fix?

Thanks,

Matt

> 
>> ---
>>   drivers/dma-buf/dma-buf.c | 21 ++++++++++++++++++---
>>   include/linux/dma-buf.h   |  5 ++++-
>>   2 files changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>> index 4c9add51f9ef..61485fc28b8b 100644
>> --- a/drivers/dma-buf/dma-buf.c
>> +++ b/drivers/dma-buf/dma-buf.c
>> @@ -193,11 +193,26 @@ static void dma_buf_release(struct dentry *dentry)
>>   
>>   static int dma_buf_file_release(struct inode *inode, struct file *file)
>>   {
>> -	if (!is_dma_buf_file(file))
>> -		return -EINVAL;
>> +	struct dma_buf *dmabuf = file->private_data;
>> +
>> +	if (!dmabuf)
>> +		return 0;
>>   
>> -	__dma_buf_list_del(file->private_data);
>> +	__dma_buf_list_del(dmabuf);
>>   
>> +	/*
>> +	 * As the file is being closed, dmabuf->file is no longer
>> +	 * valid and NULL replaces an otherwise stale pointer.  If a
>> +	 * reference to the file isn't already held, the file can be
>> +	 * closed at any time, including before dmabuf->ops->release()
>> +	 * happens: dmabuf->file _must not_ be accessed directly.  An
>> +	 * exporter should use get_file_active(&dmabuf->file) which
>> +	 * atomically tests and acquires a reference to the file (or
>> +	 * returns NULL if the file has closed).  The barrier ensures
>> +	 * get_file_active() observes the store before file_free()
>> +	 * frees the memory.
>> +	 */
>> +	smp_store_mb(dmabuf->file, NULL);
>>   	return 0;
>>   }
>>   
>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>> index d15b2b31d3c9..a31eb0ab9ecf 100644
>> --- a/include/linux/dma-buf.h
>> +++ b/include/linux/dma-buf.h
>> @@ -303,7 +303,10 @@ struct dma_buf {
>>   	 * @file:
>>   	 *
>>   	 * File pointer used for sharing buffers across, and for refcounting.
>> -	 * See dma_buf_get() and dma_buf_put().
>> +	 * See dma_buf_get() and dma_buf_put().  When an exporter holds a
>> +	 * common lock with the ->release() callback, it can use
>> +	 * get_file_active(&dma_buf->file) to safely acquire a reference;
>> +	 * the file could otherwise be closed at any time.
>>   	 */
>>   	struct file *file;
>>   
> 

