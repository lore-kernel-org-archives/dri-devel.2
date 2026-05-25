Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634C1CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 07:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB4A10E08D;
	Mon, 25 May 2026 07:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O6ZGNZki";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61CC710E08D
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 07:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779695088; x=1811231088;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=foLqJ1LReO5idN/wZ0gPgZbLodtEo06BtIWKjvWnTQg=;
 b=O6ZGNZkigQjk0zaTqPxyRU8Rumw+YECla+/whHc0FN96HenJ4aA+IXX9
 LY93Pbl2gV9tBsWF4sOl6Jml+n0lX8xQSC+1mLPxqyFvCW5dT47nvZdrN
 GUGJ1a+8ScQ3Hk/aUkOj6wTHulGRv4tC68p78s1zT/mP2n3Q4YzBydSOB
 hYK66iG6TB2PiqVqx/vD+sQh1/jfHkQeQGxGeXpW6tG4TzvBoBysDRaSF
 5/iHuqDD5ISuXBfKU1TAaatTgFSX2JqgdecbHXEockO5w9QKVcJk54axC
 EGG/nnp8EfY8XTM7w+2WsjkeTOSYTXaFsAKJFj5J0+itR9QbW5wW5xOcU g==;
X-CSE-ConnectionGUID: nc8idjHTQc2Th7O72VlwrA==
X-CSE-MsgGUID: LYqQhJ6dS56M9//QSWVohA==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="97940926"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="97940926"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 00:44:47 -0700
X-CSE-ConnectionGUID: Mp1S4+IZT+mLvrPhgIoFBg==
X-CSE-MsgGUID: V//W4ZFjQjm2lx3GzvLJPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="240496198"
Received: from yshchyok-mobl.ccr.corp.intel.com (HELO [10.245.112.233])
 ([10.245.112.233])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 00:44:45 -0700
Message-ID: <f0a5dbaa-c6bc-484e-8459-eca457c9f617@linux.intel.com>
Date: Mon, 25 May 2026 09:44:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Document why full JSM message size is always
 used
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 andrzej.kacprowski@linux.intel.com, lizhi.hou@amd.com
References: <20260522093209.1169716-1-karol.wachowski@linux.intel.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260522093209.1169716-1-karol.wachowski@linux.intel.com>
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

On 2026-05-22 11:32 AM, Karol Wachowski wrote:
> Firmware expects IPC messages to always carry the full fixed
> sizeof(struct vpu_jsm_msg) size. Sending the full struct also
> ensures unused fields are zeroed, which maintains compatibility
> when existing commands are extended with new fields in the future.
> 
> Replace the misleading TODO comment with an explanation of the
> actual intent.
> 
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

> ---
>   drivers/accel/ivpu/ivpu_ipc.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> index f47df092bb0d..9f1ba0c57442 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> @@ -97,7 +97,11 @@ ivpu_ipc_tx_prepare(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
>   
>   	memset(tx_buf, 0, sizeof(*tx_buf));
>   	tx_buf->ipc.data_addr = jsm_vpu_addr;
> -	/* TODO: Set data_size to actual JSM message size, not union of all messages */
> +	/*
> +	 * Firmware expects full JSM message size regardless of the payload size.
> +	 * Unused fields must be zeroed to allow future extensions of existing
> +	 * commands without breaking compatibility.
> +	 */
>   	tx_buf->ipc.data_size = sizeof(*req);
>   	tx_buf->ipc.channel = cons->channel;
>   	tx_buf->ipc.src_node = 0;

