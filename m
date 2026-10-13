Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884C6CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC0010F7BD;
	Tue, 13 Oct 2026 12:05:02 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF59E10F7BD
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1791893094;
 bh=b30tYFBmUTaS3zxQfRBfgyhMiRzxN0xSDIkj7tzLIwY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=j8Oj76L7H3Nk4J2a6acAuondTqocX9HA/QzYMnV6sbFl9y7qMYyK+pe5duzNPWu4d
 SkTS/raIlM1oDlzTfntwSOtPQvK/uqxo+YIw0q1ad2wcBY9M2WT92MhnDmwHgCtEMQ
 fv69NpzaBhpiMLSOf+DG97EJdUNz7FPDK4ujogpRap6kl/fw2dRJ9csAZOyByjpbpw
 wY5LA/8JzieK2bqwkcsF8o33RXxL3yMnlIUV3ykEgli0c4Dq9N4sYGrX3SQkW6BhkA
 I72zQhsetcICUf7BEOOQyqtignepf4tBmW/IwmzKb6LShhDIBiyWFRseIeTtetJUsH
 RAeiOMbFAAtFQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4j3tLX2QYNz4xh2;
 Tue, 13 Oct 2026 23:04:52 +1100 (AEDT)
Message-ID: <6bd77a8c-9ff9-40af-9cbe-23139b20f822@ozlabs.org>
Date: Tue, 13 Oct 2026 13:04:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dma-buf: Annul dmabuf->file on file release
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org,
 sashiko-reviews@lists.linux.dev
References: <20261009123601.94079-1-matt@ozlabs.org>
 <20261009123601.94079-3-matt@ozlabs.org> <sashiko-outbox-165603@kernel.org>
 <749905e4-52ea-490b-98c7-3923655a52ba@ozlabs.org>
 <072d1780-1f69-40fe-8a6e-a588a7967a99@amd.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <072d1780-1f69-40fe-8a6e-a588a7967a99@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12/10/2026 18:48, Christian König wrote:
> On 10/12/26 17:27, Matt Evans wrote:
>> Hi Christian, Alex,
>>
>> I'd be very grateful for your help on this:
>>
>> On 09/10/2026 14:11, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>> - [High] dma-buf: NULL pointer dereference of dmabuf->file in exporter drivers
>>> -- 
>>>
>>> commit b5be810d5fa3244638a9bad8503cacb8ca86027e
>>> Author: Matt Evans <matt@ozlabs.org>
>>>
>>> dma-buf: Annul dmabuf->file on file release
>>>
>>> This patch sets dmabuf->file to NULL in dma_buf_file_release() to prevent a
>>> use-after-free window if the dentry outlives the file. By clearing the
>>> pointer, exporters using get_file_active() can safely observe that the file
>>> is closed.
>>>
>>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>>> index 36cdc342627ee..d0f8b766e8fd1 100644
>>>> --- a/drivers/dma-buf/dma-buf.c
>>>> +++ b/drivers/dma-buf/dma-buf.c
>>>> @@ -193,11 +193,26 @@ static void dma_buf_release(struct dentry *dentry)
>>>>      static int dma_buf_file_release(struct inode *inode, struct file *file)
>>>>    {
>>>> -    if (!is_dma_buf_file(file))
>>>> -        return -EINVAL;
>>>> +    struct dma_buf *dmabuf = file->private_data;
>>>> +
>>>> +    if (!dmabuf)
>>>> +        return 0;
>>>>    -    __dma_buf_list_del(file->private_data);
>>>> +    __dma_buf_list_del(dmabuf);
>>>>    +    /*
>>>> +     * As the file is being closed, dmabuf->file is no longer
>>>> +     * valid and NULL replaces an otherwise stale pointer.  If a
>>>> +     * reference to the file isn't already held, the file can be
>>>> +     * closed at any time, including before dmabuf->ops->release()
>>>> +     * happens: dmabuf->file _must not_ be accessed directly.  An
>>>> +     * exporter should use get_file_active(&dmabuf->file) which
>>>> +     * atomically tests and acquires a reference to the file (or
>>>> +     * returns NULL if the file has closed).  The barrier ensures
>>>> +     * get_file_active() observes the store before file_free()
>>>> +     * frees the memory.
>>>> +     */
>>>> +    smp_store_mb(dmabuf->file, NULL);
>>>
>>> [Severity: High]
>>> Does setting dmabuf->file to NULL here cause a NULL pointer dereference in
>>> exporter drivers that still hold a reference to the dma_buf?
>>>
>>> For example, if a GEM object is exported to a DMA-BUF and the file descriptor
>>> is closed, the dma_buf is kept alive by the GEM object. If a user then reads
>>> the debugfs file, amdgpu_bo_print_info() in
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c dereferences dmabuf->file:
>>>
>>>          seq_printf(m, " imported from ino:%llu", file_inode(dma_buf->file)->i_ino);
>>>      else if (dma_buf)
>>>          seq_printf(m, " exported as ino:%llu", file_inode(dma_buf->file)->i_ino);
>>>
>>> Similarly, during cleanup, amdgpu_ualink_cleanup_imp_xa_node() in
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c attempts to read the file count:
>>>
>>>      dev_dbg(adev->dev,
>>>          "IMP-CLEANUP: dmabuf free for NPA:%llx handle:%llx:%llx, fc:%lu\n",
>>>          imp_xa_node->npa_addr, imp_xa_node->handle.handle_hi,
>>>          imp_xa_node->handle.handle_lo,
>>>          file_count(imp_xa_node->dmabuf->file));
>>>
>>> Could these routines trigger a kernel panic when dmabuf->file is NULL?
>>
>> I am out on a limb here, being the first time I've read this driver. :-I  It _looks_ like there's a live dmabuf->file because a get_dma_buf()-style reference is held here (so a false positive from Sashiko).  But I'm quite uncertain.
>>
>> Christian, that you hadn't already mentioned this hints to me that this is safe, is that fair?
> 
> The Sashiko comment is nonsense. Each GEM object which has a DMA-buf (either through import or export) holds a reference to the DMA-buf file.
> 
> The only case where it is temporarily not holding the reference is during the destruction dance, e.g. handle ref goes to zero, DMA-buf is released and freed, GEM object is released and freed.
> 
> Additional to that this is for debugfs which is meant to be used for debugging only and is not really stable. We literally have tons of debugfs files which do very questionable things with locks and/or RCU and sometimes just returns random data because the object in question is about to be destroyed.
> 
> A NULL pointer deref is a bit more problematic. But in general most people don't care much, it's debugfs.

That makes sense, and I really appreciate the explanation.  Thanks for 
the help.


Matt

