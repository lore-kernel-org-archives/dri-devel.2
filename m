Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE74ECD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F7110E20C;
	Mon, 15 Jun 2026 07:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WU1fh3UV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1988310E20C
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 07:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781506950; x=1813042950;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HUgIZoq2/zUpBGQAYFZzW5uj30BMloz46p6UkY/MDp0=;
 b=WU1fh3UVMP5l1PMwRNojS95p0MgaJUXhUQRj+Z3nKadeghZvizSmC6rK
 HDrbzpuU0XaDPHxVgjbPgvjgNPH8wN575xEms+ZgpToqQ6s7G2E97Syl1
 KxHPNvv2Mp3zNwQpQV2AM+1CFfXM/0nYQlLi9/DKLNZpiXF85WU6FcUB9
 5DD6CgoYiqdlPNQJbXf/mbwliFmRuTU3JHp9DeeCHKooVPB7jRabvQ61p
 Pn5p9wz+/ugEv+p+qJYMIX9Hwl1bW14XTsQoRLYSw7n5NppgjeSwXfW3m
 h9GLT1m02vq+HXBcT2L8sbBWkbwZR1NdeMbtKrH47vAMmPgiudUawm/y3 w==;
X-CSE-ConnectionGUID: m7c756LjQdW5e6fIbmX62Q==
X-CSE-MsgGUID: 9TjuhDy4Qf2QYnHdUUfuog==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="104910809"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="104910809"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 00:02:29 -0700
X-CSE-ConnectionGUID: lXad/FNtQR+EtPP2PqcTLg==
X-CSE-MsgGUID: yPdv00d4RQSEiVH7RxWdGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="285500291"
Received: from pgcooper-mobl.ger.corp.intel.com (HELO [10.246.16.57])
 ([10.246.16.57])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 00:02:27 -0700
Message-ID: <ca3ce7e9-7262-4432-bd83-c0c78afc0ef1@linux.intel.com>
Date: Mon, 15 Jun 2026 09:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: fix HWS command queue leak on registration
 failure
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com
References: <20260611055140.948684-1-karol.wachowski@linux.intel.com>
 <737f87af-7d54-4117-851c-2f097781bf5c@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <737f87af-7d54-4117-851c-2f097781bf5c@linux.intel.com>
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

On 12-Jun-26 9:10, Andrzej Kacprowski wrote:
> On 11-Jun-26 7:51 AM, Karol Wachowski wrote:
>> A command queue is considered valid and usable by the driver only when
>> it has a doorbell ID assigned (db_id != 0), meaning both the FW cmdq
>> creation and doorbell registration completed successfully.
>>
>> However, when either ivpu_register_db() or set_context_sched_properties()
>> fails after ivpu_hws_cmdq_init() has already created the cmdq in FW,
>> the command queue is left registered in FW while the driver treats it as
>> uninitialized (db_id remains 0). On the next submission attempt the
>> driver tries to register the same cmdq again, which fails because FW
>> already has an entry for it.
>>
>> Fix by calling ivpu_jsm_hws_destroy_cmdq() on error paths to properly
>> unwind FW state and allow subsequent registration attempts to succeed.
>>
>> Fixes: 0c7c13186866 ("accel/ivpu: Add API for command queue create/ 
>> destroy/submit")
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_job.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ 
>> ivpu_job.c
>> index 521931d1f7fc..b24f31a8b567 100644
>> --- a/drivers/accel/ivpu/ivpu_job.c
>> +++ b/drivers/accel/ivpu/ivpu_job.c
>> @@ -208,9 +208,9 @@ static int ivpu_hws_cmdq_init(struct 
>> ivpu_file_priv *file_priv, struct ivpu_cmdq
>>       ret = ivpu_jsm_hws_set_context_sched_properties(vdev, file_priv- 
>> >ctx.id, cmdq->id,
>>                               priority);
>>       if (ret)
>> -        return ret;
>> +        ivpu_jsm_hws_destroy_cmdq(vdev, file_priv->ctx.id, cmdq->id);
>> -    return 0;
>> +    return ret;
>>   }
>>   static int ivpu_register_db(struct ivpu_file_priv *file_priv, struct 
>> ivpu_cmdq *cmdq)
>> @@ -281,10 +281,10 @@ static int ivpu_cmdq_register(struct 
>> ivpu_file_priv *file_priv, struct ivpu_cmdq
>>       }
>>       ret = ivpu_register_db(file_priv, cmdq);
>> -    if (ret)
>> -        return ret;
>> +    if (ret && vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
>> +        ivpu_jsm_hws_destroy_cmdq(vdev, file_priv->ctx.id, cmdq->id);
>> -    return 0;
>> +    return ret;
>>   }
>>   static int ivpu_cmdq_unregister(struct ivpu_file_priv *file_priv, 
>> struct ivpu_cmdq *cmdq)
> 
> Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Pushed to drm-misc-fixes.
