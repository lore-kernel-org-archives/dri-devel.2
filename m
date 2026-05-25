Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9F6CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB7910E5CF;
	Mon, 25 May 2026 08:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="g8QoEfRT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F7510E5CF
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779696545; x=1811232545;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Pa/GA0RzkVGphfPxam5plZlFoNwkseKy2DjN2LQzuL4=;
 b=g8QoEfRTDsfRUZQ9N434fbBqkG+udgNdyyp6ACQ3Ji55eVMlPBc433Ad
 DVFYKEmHICp9j979eaiOIzvy2axmPyH2KQ0GfpCW/wPWpPh8+59YYdhrq
 YICl/iG1jQK12V3QXBBYfk3pdvRBZO3WWP1RbKcc5TJst0IzacTiWyoyF
 IsvKx8QRjsu3ALr/1GzH6IJ0p5Uj0J9bBjBDQVMRZGwWsfq/FSWwW4kY8
 qVAWnA1z1N1mE+XZX2WLPi0ZI5y9Ks6fkwhNXiUbQdbPLvEwNUaokjmlI
 /5OERPgP0Z4eUUC5aecceMxOumMbhNaoLF9KnuXxfSJPE+noYJEJYe6BM w==;
X-CSE-ConnectionGUID: ncrXxy0bSYqJ1EyHnGE0yw==
X-CSE-MsgGUID: 8eUPFKS0S7qH/vTRpTFWcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="91085880"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="91085880"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 01:09:04 -0700
X-CSE-ConnectionGUID: QcGG9OMxS+yKPAzilrx16Q==
X-CSE-MsgGUID: lR5zosnJQ7u80L6mQ1558Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="243368838"
Received: from unknown (HELO [10.217.180.37]) ([10.217.180.37])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 01:09:03 -0700
Message-ID: <d282fa34-218d-4396-85ae-98e040f0f356@linux.intel.com>
Date: Mon, 25 May 2026 10:09:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Document why full JSM message size is always
 used
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 andrzej.kacprowski@linux.intel.com, lizhi.hou@amd.com
References: <20260522093209.1169716-1-karol.wachowski@linux.intel.com>
 <f0a5dbaa-c6bc-484e-8459-eca457c9f617@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <f0a5dbaa-c6bc-484e-8459-eca457c9f617@linux.intel.com>
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

On 25-May-26 9:44, Dawid Osuchowski wrote:
> On 2026-05-22 11:32 AM, Karol Wachowski wrote:
>> Firmware expects IPC messages to always carry the full fixed
>> sizeof(struct vpu_jsm_msg) size. Sending the full struct also
>> ensures unused fields are zeroed, which maintains compatibility
>> when existing commands are extended with new fields in the future.
>>
>> Replace the misleading TODO comment with an explanation of the
>> actual intent.
>>
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks, applied to drm-misc-next.

> 
>> ---
>>   drivers/accel/ivpu/ivpu_ipc.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ 
>> ivpu_ipc.c
>> index f47df092bb0d..9f1ba0c57442 100644
>> --- a/drivers/accel/ivpu/ivpu_ipc.c
>> +++ b/drivers/accel/ivpu/ivpu_ipc.c
>> @@ -97,7 +97,11 @@ ivpu_ipc_tx_prepare(struct ivpu_device *vdev, 
>> struct ivpu_ipc_consumer *cons,
>>       memset(tx_buf, 0, sizeof(*tx_buf));
>>       tx_buf->ipc.data_addr = jsm_vpu_addr;
>> -    /* TODO: Set data_size to actual JSM message size, not union of 
>> all messages */
>> +    /*
>> +     * Firmware expects full JSM message size regardless of the 
>> payload size.
>> +     * Unused fields must be zeroed to allow future extensions of 
>> existing
>> +     * commands without breaking compatibility.
>> +     */
>>       tx_buf->ipc.data_size = sizeof(*req);
>>       tx_buf->ipc.channel = cons->channel;
>>       tx_buf->ipc.src_node = 0;
> 

