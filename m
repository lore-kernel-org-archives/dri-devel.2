Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26535C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7061710E08E;
	Wed, 22 Jul 2026 11:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="J+DZbE81";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F3610E08E
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 11:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784720326; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kQNjROSiA81iYSeW3M9mzLeFw/xx+3M0SqqcDeF1Met2wIeW8aXCBD02UUda61H9Biu90UyH/mbG9B5OUYSpIcM3eeCYWUBD8jy/A1Wjrm1sEOrx9mtCW74dBu6DAxxiExxvX7IUAnptNq+0YLW99tu2njCLnPORvUueV/hQon8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784720326;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tyz+1ZlIAnOEc0Va4DFA0J1+YpDdP0XRHzxDkISRxzQ=; 
 b=hSkZbqhU//LZ/glA0abh1uHghJNCuZVpzb1Tk1OfA8xCZIrHJNk+Ljjxtr03gVaS4goA3zvf8Z3sbRxafMtG45ScxyFj4XImHHUl+5DEPRC7LYbAdQktlBGZaTjEfVrw5+bsn2qhOG2RsCX4ZFVlN3iaKZbG6QTzvOsbOsxH95E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784720326; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=tyz+1ZlIAnOEc0Va4DFA0J1+YpDdP0XRHzxDkISRxzQ=;
 b=J+DZbE81w9jCKLckYpMLiURNEpIsW8lqixln+Olh+FG6LQ5mIF2xAiDdM7KbAWEc
 56k3MPiU1H6OVHS2oLmKZQ92DaLVI0RLL0MKq+ponOMmoU6VHNNK4zqTLoFr1J13NdM
 kRMtOUKZIoHfIqVG4x+dA+ODf+/OhvJwsRXcAwk4=
Received: by mx.zohomail.com with SMTPS id 1784720324799660.8652285687484;
 Wed, 22 Jul 2026 04:38:44 -0700 (PDT)
Message-ID: <28536b3e-1c19-473f-b46a-425eb13ba0e3@collabora.com>
Date: Wed, 22 Jul 2026 13:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-buf/udmabuf: Disable the size limit by default
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
References: <20260722110145.36641-1-robert.mader@collabora.com>
 <20260722112708.5CD131F000E9@smtp.kernel.org>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260722112708.5CD131F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Responding to the report just for the record:

On 22.07.26 13:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Removing the dmabuf size limit (by setting `size_limit_mb` to `INT_MAX`) allows an unprivileged user to request a massive buffer size (up to ~2.2 TB). This forces the kernel to attempt massive unbounded vmalloc allocations for the internal tracking arrays, rapidly exhausting system memory and triggering the OOM killer.
>
> Pre-existing issues:
> - [High] Setting `size_limit_mb` to `INT_MAX` allows unprivileged users to create udmabufs of 4GB or larger. On 32-bit architectures, this triggers an integer overflow when converting the page count back to bytes (`ubuf->pagecount << PAGE_SHIFT`), resulting in a size of 0 or a severely truncated value.
> --
>
> --- Patch [1]: [PATCH v2] dma-buf/udmabuf: Disable the size limit by default ---
> commit f1c9db60e57729e9743c42b43759bab6d0eafb5d
> Author: Robert Mader <robert.mader@collabora.com>
>
> dma-buf/udmabuf: Disable the size limit by default
>
> This commit disables the default 64MB size limit for udmabuf by setting it
> to INT_MAX. It aims to support users who need larger buffers for high
> resolution video formats. The change assumes the per-buffer size limit does
> not provide sufficient protection on its own.
>
> Link: https://lore.kernel.org/dri-devel/20260711144814.8205-1-robert.mader@collabora.com/
> Link: https://lore.kernel.org/dri-devel/6764ca6f-b4d8-4baa-9d27-2ca867ac2d41@amd.com/
>
>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
>> index bced421c0d658..639e937049242 100644
>> --- a/drivers/dma-buf/udmabuf.c
>> +++ b/drivers/dma-buf/udmabuf.c
>> @@ -20,9 +20,9 @@ static int list_limit = 1024;
>>   module_param(list_limit, int, 0644);
>>   MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default is 1024.");
>>   
>> -static int size_limit_mb = 64;
>> +static int size_limit_mb = INT_MAX;
> [Severity: High]
> Does this change allow an unprivileged user to exhaust kernel memory?
>
> Because the size limit is effectively removed, an unprivileged user can
> request an extremely large buffer size via /dev/udmabuf.
>
> Looking at udmabuf_create() and init_udmabuf(), the internal tracking
> arrays are allocated based on this requested size:
>
> drivers/dma-buf/udmabuf.c:udmabuf_create() {
>      ...
>      folios = kvmalloc_array(max_nr_folios, sizeof(*folios), GFP_KERNEL);
>      ...
> }
>
> drivers/dma-buf/udmabuf.c:init_udmabuf() {
>      ...
>      ubuf->pages = kvmalloc_objs(*ubuf->pages, pgcnt);
>      ...
> }
>
> Since these allocations use GFP_KERNEL without __GFP_ACCOUNT, they bypass
> memory cgroups. Could a large request trigger unbounded vmalloc allocations
> that consume gigabytes of memory per ioctl call, leading to an OOM condition?
As mentioned in the commit message and as discussed in the mentioned 
links, this is a pre-existing issue as users could just allocate 
multiple buffer, having the same effect as allocating a single big one.
> [Severity: High]
> This is a pre-existing issue, but does removing the size limit expose a
> page count overflow on 32-bit architectures?
>
> When a user requests a size of 4GB or larger, the pagecount exceeds
> 1048576. In export_udmabuf() and get_sg_table(), the size is calculated by
> shifting the page count:
The udmabuf interface works on pre-allocated system memory. On a 32-bit 
architecture users can't allocate more than 4GB of memory - so the 
described request should be impossible.
>
> drivers/dma-buf/udmabuf.c:export_udmabuf() {
>      ...
>      exp_info.size = ubuf->pagecount << PAGE_SHIFT;
>      ...
> }
>
> drivers/dma-buf/udmabuf.c:get_sg_table() {
>      ...
>      ret = sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->pagecount, 0,
>                                      ubuf->pagecount << PAGE_SHIFT,
>                                      GFP_KERNEL);
>      ...
> }
>
> On 32-bit architectures, this 32-bit arithmetic wraps around to 0. Can
> this result in a truncated dma-buf size or an invalid SG table with
> 0-length elements, potentially causing a panic in IOMMU drivers?
>
>>   module_param(size_limit_mb, int, 0644);
>> -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is 64.");
>> +MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is INT_MAX.");
>>   
>>   struct udmabuf {
>>   	pgoff_t pagecount;

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

