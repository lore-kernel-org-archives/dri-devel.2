Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58EE606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q70IX0lu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27CF61127FF;
	Thu, 19 Nov 2026 23:54:24 +0000 (UTC)
Received: from mta0.migadu.com (out-216.mta0.migadu.com [91.218.175.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D211127FC
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:54:17 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=SVZrlJks8sXPVt3xrpYdTAoVZmdk9CSrl7P148bcFmU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795132454; v=1; x=1795737254;
 b=q70IX0luUcbU6FCiJYBpmUfdNrXaCDzDyverVa5nohERhVo++3RcTQWOyKaGqDjVgz3oc5Fx
 VBY96WxGxsdaNk3gHTfIfp6AF/YK/SO2tPRF0sI/OQFkm0I4B33qwJ5F3URCKw0ij+tnYR3yJa0
 Gw0mzX4e9eiXeXHZeFdigyFI=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id eca0a2cac3c52e86;
 Thu, 19 Nov 2026 23:54:14 +0000
X-Mizu-Trace-ID: eca0a2cac3c52e86
X-Migadu-Flow: FLOW_OUT
Message-ID: <1ea66d73-4d40-4d95-855f-4235cbd1d809@linux.dev>
Date: Fri, 20 Nov 2026 07:53:53 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, akpm@linux-foundation.org, dgilbert@interlog.com,
 mkp@kernel.org, loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
 vivek.kasireddy@intel.com, jasowangio@gmail.com, eperezma@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, rostedt@goodmis.org,
 vdonnefort@google.com, mhiramat@kernel.org, jgg@ziepe.ca,
 kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
 James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
 will@kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
 mathieu.desnoyers@efficios.com, robin.murphy@arm.com, mason@kernel.org,
 aesteve@redhat.com, tjmercier@google.com, harry@kernel.org, vbabka@suse.cz,
 cuitao@kylinos.cn
Subject: Re: [PATCH 3/7] vhost: account the per-device kernel allocations to
 memcg
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-4-cui.tao@linux.dev>
 <20261119101239-mutt-send-email-mst@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261119101239-mutt-send-email-mst@kernel.org>
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello, Michael,

在 2026/11/19 23:12, Michael S. Tsirkin 写道:
> On Fri, Nov 06, 2026 at 09:18:25PM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> Everything except the worker struct is allocated with plain GFP_KERNEL:
>> the per-vq iovec and log arrays at VHOST_SET_OWNER, the memory table at
>> VHOST_SET_MEM_TABLE whose size follows the user supplied region count,
>> the pending message nodes, and the vhost_net/vhost_vsock device structs
>> with their fallback to vmalloc.  The worker has been accounted since the
>> vhost_task conversion.
>>
>> A container that can open /dev/vhost-net or /dev/vhost-vsock, which
>> device plugins hand out with passthrough, holds roughly 150KB of
>> resident kernel memory per device after SET_OWNER.  Charge the rest the
>> same way the worker already is.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> should each patch be merged individually?
> 
Yes, I think merging them individually is the cleaner path here: the series spans six subsystems, and each maintainer taking their own piece keeps things simple. Jason has already taken patch 5 into iommufd.  Please feel free to take patch 3 through your tree.

Thanks,
Tao
> 
>> ---
>>  drivers/vhost/net.c   | 14 ++++++++------
>>  drivers/vhost/vhost.c | 16 ++++++++++------
>>  drivers/vhost/vsock.c |  5 +++--
>>  3 files changed, 21 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index 4570a4ffbab2..bab6597c696d 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -249,7 +249,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
>>  	/* No zero copy backend? Nothing to count. */
>>  	if (!zcopy)
>>  		return NULL;
>> -	ubufs = kmalloc_obj(*ubufs);
>> +	ubufs = kmalloc_obj(*ubufs, GFP_KERNEL_ACCOUNT);
>>  	if (!ubufs)
>>  		return ERR_PTR(-ENOMEM);
>>  	atomic_set(&ubufs->refcount, 1);
>> @@ -302,7 +302,8 @@ static int vhost_net_set_ubuf_info(struct vhost_net *n)
>>  		if (!zcopy)
>>  			continue;
>>  		n->vqs[i].ubuf_info =
>> -			kmalloc_objs(*n->vqs[i].ubuf_info, UIO_MAXIOV);
>> +			kmalloc_objs(*n->vqs[i].ubuf_info, UIO_MAXIOV,
>> +				     GFP_KERNEL_ACCOUNT);
>>  		if  (!n->vqs[i].ubuf_info)
>>  			goto err;
>>  	}
>> @@ -1344,17 +1345,18 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>>  	struct xdp_buff *xdp;
>>  	int i;
>>  
>> -	n = kvmalloc_obj(*n, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
>> +	n = kvmalloc_obj(*n, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
>> +			 __GFP_ACCOUNT);
>>  	if (!n)
>>  		return -ENOMEM;
>> -	vqs = kmalloc_objs(*vqs, VHOST_NET_VQ_MAX);
>> +	vqs = kmalloc_objs(*vqs, VHOST_NET_VQ_MAX, GFP_KERNEL_ACCOUNT);
>>  	if (!vqs) {
>>  		kvfree(n);
>>  		return -ENOMEM;
>>  	}
>>  
>>  	queue = kmalloc_array(VHOST_NET_BATCH, sizeof(void *),
>> -			      GFP_KERNEL);
>> +			      GFP_KERNEL_ACCOUNT);
>>  	if (!queue) {
>>  		kfree(vqs);
>>  		kvfree(n);
>> @@ -1362,7 +1364,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>>  	}
>>  	n->vqs[VHOST_NET_VQ_RX].rxq.queue = queue;
>>  
>> -	xdp = kmalloc_objs(*xdp, VHOST_NET_BATCH);
>> +	xdp = kmalloc_objs(*xdp, VHOST_NET_BATCH, GFP_KERNEL_ACCOUNT);
>>  	if (!xdp) {
>>  		kfree(vqs);
>>  		kvfree(n);
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index ea127af58ada..d1274106ad5d 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -526,11 +526,14 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
>>  
>>  	for (i = 0; i < dev->nvqs; ++i) {
>>  		vq = dev->vqs[i];
>> -		vq->indirect = kmalloc_objs(*vq->indirect, UIO_MAXIOV);
>> -		vq->log = kmalloc_objs(*vq->log, dev->iov_limit);
>> -		vq->heads = kmalloc_objs(*vq->heads, dev->iov_limit);
>> +		vq->indirect = kmalloc_objs(*vq->indirect, UIO_MAXIOV,
>> +					    GFP_KERNEL_ACCOUNT);
>> +		vq->log = kmalloc_objs(*vq->log, dev->iov_limit,
>> +				       GFP_KERNEL_ACCOUNT);
>> +		vq->heads = kmalloc_objs(*vq->heads, dev->iov_limit,
>> +					 GFP_KERNEL_ACCOUNT);
>>  		vq->nheads = kmalloc_array(dev->iov_limit, sizeof(*vq->nheads),
>> -					   GFP_KERNEL);
>> +					   GFP_KERNEL_ACCOUNT);
>>  		if (!vq->indirect || !vq->log || !vq->heads || !vq->nheads)
>>  			goto err_nomem;
>>  	}
>> @@ -2053,7 +2056,8 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
>>  		return -E2BIG;
>>  	if (max_iotlb_entries <= 0)
>>  		return -EINVAL;
>> -	newmem = kvzalloc_flex(*newmem, regions, mem.nregions);
>> +	newmem = kvzalloc_flex(*newmem, regions, mem.nregions,
>> +			       GFP_KERNEL_ACCOUNT);
>>  	if (!newmem)
>>  		return -ENOMEM;
>>  
>> @@ -3405,7 +3409,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>>  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>>  {
>>  	/* Make sure all padding within the structure is initialized. */
>> -	struct vhost_msg_node *node = kzalloc_obj(*node);
>> +	struct vhost_msg_node *node = kzalloc_obj(*node, GFP_KERNEL_ACCOUNT);
>>  	if (!node)
>>  		return NULL;
>>  
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 0cb87971d749..600daeb05e7b 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -721,11 +721,12 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>>  	/* This struct is large and allocation could fail, fall back to vmalloc
>>  	 * if there is no other way.
>>  	 */
>> -	vsock = kvmalloc_obj(*vsock, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
>> +	vsock = kvmalloc_obj(*vsock, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
>> +			     __GFP_ACCOUNT);
>>  	if (!vsock)
>>  		return -ENOMEM;
>>  
>> -	vqs = kmalloc_objs(*vqs, ARRAY_SIZE(vsock->vqs));
>> +	vqs = kmalloc_objs(*vqs, ARRAY_SIZE(vsock->vqs), GFP_KERNEL_ACCOUNT);
>>  	if (!vqs) {
>>  		ret = -ENOMEM;
>>  		goto out;
>> -- 
>> 2.43.0
> 

