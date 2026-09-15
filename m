Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84E6C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0497710E28B;
	Tue, 15 Sep 2026 13:36:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="pFs8lMg5";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308B610E28B
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1789479351;
 bh=DWVhKVS/oSZ89zVo3nQvXjYHkur/TgVABxyYwyrAR0Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pFs8lMg5Su6CKj2jFXvGnKo/eWjf+h7+TwkRwWF+lPArue6NsQMLIQ6Bb/iRiOYaO
 ArJEto5IzfAFSR89Zfi14G8FilORU31JSnElxNNuxVC124ioGheV1za7DGjjgpgNvO
 GjMTsPlmnRGEhjxdwpeouBHxcOX779m2QSZyvJKDFY0hIawHzHODw4kXTfJ6S363qp
 OvmhxHONJQ7Y32zHh78PPW3Olr3tLUfAh4Ql3nvepYxk/E42dxzYg7/FmNyEmzB1If
 DuDevqJQJsktX+2rntw4eerCg0kNbQATVLtF4nnwOz3G/jI0nx+DBnsMWbaWrgngtR
 CB8tcnmO/395g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4hkjhF4Nc5z4w0p;
 Tue, 15 Sep 2026 23:35:40 +1000 (AEST)
Message-ID: <17f63c69-61a1-47c8-a4cb-705f9d394317@ozlabs.org>
Date: Tue, 15 Sep 2026 14:35:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] dma-buf: Export dma_buf_set_name()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-4-matt@ozlabs.org>
 <38195919-cdf3-49d4-bf2a-10f6cbab454a@amd.com>
Content-Language: en-GB
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <38195919-cdf3-49d4-bf2a-10f6cbab454a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Christian,

On 14/09/2026 12:06, Christian König wrote:
> On 9/11/26 23:41, Matt Evans wrote:
>> dma_buf_set_name() originally took a __user string to duplicate for
>> the buffer name.  Make this function a generic set-name helper, taking
>> a kernel-allocated string.
>>
>> Wrap this by a new dma_buf_set_name_user() to support the existing
>> ioctl path for a user-provided string.
> 
> That just describes what the patch does and not why, in other words this needs a bit more justification for the change.
> 
> For example something like "Allow exporters/importers to set the name of buffers from pre-existing information".

Fair enough, am adding missing rationale.

> It is also important to describe which role should set a name (exporter, importer or both). When an exporter gives a standard name for it's buffers that is most likely harmless, but when an importer bluntly overwrites a name previously set by an exporter or userspace then we really need a good reason for that.

Good point; my expectation was that exporters would use this to either
set or update the name, and importers would never do this.  I will make
this clear in the commit message/comments, thanks.

>>
>> Signed-off-by: Matt Evans <matt@ozlabs.org>
>> ---
>>  drivers/dma-buf/dma-buf.c | 58 ++++++++++++++++++++++++++++++---------
>>  include/linux/dma-buf.h   |  2 ++
>>  2 files changed, 47 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>> index d504c636dc29..8129ea11ff58 100644
>> --- a/drivers/dma-buf/dma-buf.c
>> +++ b/drivers/dma-buf/dma-buf.c
>> @@ -405,31 +405,29 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>>  }
>>  
>>  /**
>> - * dma_buf_set_name - Set a name to a specific dma_buf to track the usage.
>> - * It could support changing the name of the dma-buf if the same
>> - * piece of memory is used for multiple purpose between different devices.
>> + * dma_buf_set_name_user - Set a dma_buf's name from a user string
>> + *
>> + * The string is up to DMA_BUF_NAME_LEN long, including the terminator.
>>   *
>>   * @dmabuf: [in]     dmabuf buffer that will be renamed.
>>   * @buf:    [in]     A piece of userspace memory that contains the name of
>>   *                   the dma-buf.
>>   *
>> - * Returns 0 on success. If the dma-buf buffer is already attached to
>> - * devices, return -EBUSY.
>> - *
>> + * Returns 0 on success, and any previously-set name is freed.
>>   */
> 
> Kerneldoc for a static function is usually overkill.

The original static function had some so I kept it, but no worries. Removed.

> And since this is used only once and very complicated I would completely merge the logic into dma_buf_ioctl().

Will do (no function, no kerneldoc).


Many thanks,


Matt


> 
> Regards,
> Christian.
> 
>> -static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
>> +static long dma_buf_set_name_user(struct dma_buf *dmabuf, const char __user *buf)
>>  {
>>  	char *name = strndup_user(buf, DMA_BUF_NAME_LEN);
>> +	int ret;
>>  
>>  	if (IS_ERR(name))
>>  		return PTR_ERR(name);
>>  
>> -	spin_lock(&dmabuf->name_lock);
>> -	kfree(dmabuf->name);
>> -	dmabuf->name = name;
>> -	spin_unlock(&dmabuf->name_lock);
>> +	ret = dma_buf_set_name(dmabuf, name);
>> +	if (ret)
>> +		kfree(name);
>>  
>> -	return 0;
>> +	return ret;
>>  }
>>  
>>  #if IS_ENABLED(CONFIG_SYNC_FILE)
>> @@ -578,7 +576,7 @@ static long dma_buf_ioctl(struct file *file,
>>  
>>  	case DMA_BUF_SET_NAME_A:
>>  	case DMA_BUF_SET_NAME_B:
>> -		return dma_buf_set_name(dmabuf, (const char __user *)arg);
>> +		return dma_buf_set_name_user(dmabuf, (const char __user *)arg);
>>  
>>  #if IS_ENABLED(CONFIG_SYNC_FILE)
>>  	case DMA_BUF_IOCTL_EXPORT_SYNC_FILE:
>> @@ -854,6 +852,40 @@ void dma_buf_put(struct dma_buf *dmabuf)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
>>  
>> +/**
>> + * dma_buf_set_name - Set a dma_buf's name
>> + * It could support changing the name of the dma-buf if the same piece
>> + * of memory is used for multiple purpose between different devices.
>> + *
>> + * @dmabuf: [in]     dmabuf buffer that will be renamed.
>> + * @name:   [in]     The name of the dma-buf, allocated with kmalloc() or
>> + *                   similar.  This takes ownership of the allocation
>> + *                   on success, which will be kfree()d when the
>> + *                   dmabuf is released or a new name assigned.
>> + *
>> + * Returns 0 on success, -EINVAL if the name is NULL, or -E2BIG if the
>> + * name exceeds DMA_BUF_NAME_LEN.
>> + */
>> +int dma_buf_set_name(struct dma_buf *dmabuf, char *name)
>> +{
>> +	if (!name)
>> +		return -EINVAL;
>> +
>> +	/* dmabuffs_dname() won't use the string if the length
>> +	 * (including terminator) exceeds DMA_BUF_NAME_LEN:
>> +	 */
>> +	if (strlen(name) >= DMA_BUF_NAME_LEN)
>> +		return -E2BIG;
>> +
>> +	spin_lock(&dmabuf->name_lock);
>> +	kfree(dmabuf->name);
>> +	dmabuf->name = name;
>> +	spin_unlock(&dmabuf->name_lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(dma_buf_set_name, "DMA_BUF");
>> +
>>  static int dma_buf_wrap_sg_table(struct sg_table **sg_table)
>>  {
>>  	struct scatterlist *to_sg, *from_sg;
>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>> index d1203da56fc5..14d3950b63c8 100644
>> --- a/include/linux/dma-buf.h
>> +++ b/include/linux/dma-buf.h
>> @@ -570,6 +570,8 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags);
>>  struct dma_buf *dma_buf_get(int fd);
>>  void dma_buf_put(struct dma_buf *dmabuf);
>>  
>> +int dma_buf_set_name(struct dma_buf *dmabuf, char *name);
>> +
>>  struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
>>  					enum dma_data_direction);
>>  void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
> 

