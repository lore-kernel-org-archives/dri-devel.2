Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7BAC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC72F10E897;
	Mon, 31 Aug 2026 13:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="keL0tNQO";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D85B510E897
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788183822; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IVlY0gIVVSZrFGHgFCPp18waPuFEz56rP113VJg2JsLPHQNW9Q9/ddGpb41qlW4bfZuCOMF1SCPAY6SRAe126CEc84HEmQbXOUDwFDimpE3MqUU4wjbferCBb6YP9h6x36I3WtgXJ1Vzm9yaBF3U7Y/pFUYu074SpavmDHu9cHo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788183822;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=5i9Tk76bvZxyHI3PKHSXeLT+1Z0nB59sYd6lOtLrBuU=; 
 b=AWt60QKJjjHICHHqxRYW9fnjoZYGM4fdC9TtaemtlYZtIPyTFCaWRs5bs1efU2Hr5ihIocrhcyRNzg6divQKcMLwLH0Kn7k2hOzAWvgf9KR4MmGqzUsOngEw6uP3BWr/WxQOemZ72/3hbAgSXbhUwWMCZx/KxXCJRndc3XLCygU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788183822; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=5i9Tk76bvZxyHI3PKHSXeLT+1Z0nB59sYd6lOtLrBuU=;
 b=keL0tNQOl/CcthxacCVtPkDZlQXPBr9rPtFtysG8rMl0iRVkmnof0/Y3sX5z8/pq
 GamjS7/sfTfqVxCQCH/iLWymY4TXLYG24jcUtVb5rURTMLhTGtbaqzmFQ6356NutenO
 Uz1RFezjaSnZLFsEoPI6lhi5JcratxXsD0cOO5/s=
Received: by mx.zohomail.com with SMTPS id 1788183819590850.2688823130364;
 Mon, 31 Aug 2026 06:43:39 -0700 (PDT)
Message-ID: <067b0055-9b85-4434-be36-7c6dc2450b12@collabora.com>
Date: Mon, 31 Aug 2026 15:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] udmabuf: Add mlock accounting for udmabuf
 pages/folios
To: dri-devel@lists.freedesktop.org
References: <20260831060210.1713177-1-vivek.kasireddy@intel.com>
 <20260831060210.1713177-3-vivek.kasireddy@intel.com>
Content-Language: en-US, de-DE, en-GB
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260831060210.1713177-3-vivek.kasireddy@intel.com>
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

Hi, thanks for the patch!

On 31.08.26 08:00, Vivek Kasireddy wrote:
> Since udmabuf allows users to pin pages in memory, which is a vital
> resource, we need to ensure that unprivileged users cannot abuse
> this feature to exhaust system memory. To address this, introduce
> mlock accounting for udmabuf pages/folios. This change ensures that
> the number of pages/folios pinned by udmabuf is tracked and limited
> based on the user's mlock limits.
>
> If an unprivileged user/process exceeds their mlock limit, no pages
> are pinned and EPERM is returned to the user. Note that, privileged
> users/processes (CAP_IPC_LOCK capable) are exempt from this limit,
> allowing them to pin pages without any restriction.
>
> Earlier, there was a 64 MB default limit on the size of udmabuf
> allocations, but it was removed in commit 44e9eb5a7621
> ("dma-buf/udmabuf: Disable the size limit by default") which left
> open the possibility that unpriviledged users could pin unbounded
> amount of memory. This change makes the limit dynamic, by invoking
> user_shm_lock() to check the mlock limit for unprivileged users.

I think this description is somewhat misleading: before commit 
44e9eb5a7621 the same was already possible - it just needed multiple 
buffers/allocations. That's why that patch was accepted in the first 
place, without first landing a patch like this one (adding mlock 
accounting). I.e. the described problem is not new and just became 
easier to trigger.

Best regards

Robert

>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Robert Mader <robert.mader@collabora.com>
> Cc: Xaver Hugl <xaver.hugl@kde.org>
> Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")
> ---
>   drivers/dma-buf/udmabuf.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 7c4339130eff..e78947f01656 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -203,9 +203,10 @@ static __always_inline int init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
>   	return 0;
>   }
>   
> -static __always_inline void deinit_udmabuf(struct udmabuf *ubuf)
> +static __always_inline void deinit_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
>   {
>   	unpin_all_folios(ubuf);
> +	user_shm_unlock(pgcnt << PAGE_SHIFT, current_ucounts());
>   	kvfree(ubuf->pages);
>   }
>   
> @@ -217,7 +218,7 @@ static void release_udmabuf(struct dma_buf *buf)
>   	if (ubuf->sg)
>   		put_sg_table(dev, ubuf->sg, ubuf->sg_dir);
>   
> -	deinit_udmabuf(ubuf);
> +	deinit_udmabuf(ubuf, ubuf->pagecount);
>   	kfree(ubuf);
>   }
>   
> @@ -385,6 +386,15 @@ static long udmabuf_create(struct miscdevice *device,
>   	if (!pgcnt)
>   		goto err_noinit;
>   
> +	if (!user_shm_lock(pgcnt << PAGE_SHIFT, current_ucounts())) {
> +		pr_warn_once("%s: User not permitted to pin more than %lu KB "
> +			     "of memory, either increase ulimits -l, or "
> +			     "obtain CAP_IPC_LOCK capability\n", current->comm,
> +			     rlimit(RLIMIT_MEMLOCK) >> 10);
> +		ret = -EPERM;
> +		goto err_noinit;
> +	}
> +
>   	ret = init_udmabuf(ubuf, pgcnt);
>   	if (ret)
>   		goto err;
> @@ -441,7 +451,7 @@ static long udmabuf_create(struct miscdevice *device,
>   	return ret;
>   
>   err:
> -	deinit_udmabuf(ubuf);
> +	deinit_udmabuf(ubuf, pgcnt);
>   err_noinit:
>   	kfree(ubuf);
>   	kvfree(folios);
