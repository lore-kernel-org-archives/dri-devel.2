Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9538ECD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035F810E974;
	Fri, 12 Jun 2026 07:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MDkXmbBm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F65410F2A9
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 07:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781248274; x=1812784274;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=965j2jOjO7j8y7YMLNYUsZddQ8uEg0Q6P7SW9614e/U=;
 b=MDkXmbBmmqq10hfio9KbIZGwxyk1vnqmxSRKaHnuokE3YpRgeX2VHmSS
 DAyo6+wLvymeuwbXAGVW/KCtS89B6NdeZQaTSzcq87ZSZqz3y4aVJ5TM7
 N5N3y03hNhZZ/OzBRTSYYp4gI3SMSEUIB89WKhH5XGKQI9+F3ozKIY5D0
 4gCB8NrPonqbgNUE/PjFoZkC7i75uXO4jBIAWY/qgQDtN06Lbg6dH662j
 pr4QYr5+a3SI3MyMDh2lqxdXkMcWAJL6OZaOLCU5oIhAYzmWhMILF/oU/
 KNI6j2okt13Q/Pzfz//YIIKllnW7IKyisQVyOqatGdL6zoRJxd0MYxzOe Q==;
X-CSE-ConnectionGUID: kzjUXJpRTpqjXnVdpenDOg==
X-CSE-MsgGUID: bTT0uDkpRBWn4lB9zVTNGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85705791"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="85705791"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 00:11:12 -0700
X-CSE-ConnectionGUID: Z1YBbPiaSO6tR1nrzTJx4w==
X-CSE-MsgGUID: 2/130etIRDWKQfExxn03xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="244322604"
Received: from soc-5cg43972ff.clients.intel.com (HELO [10.102.88.80])
 ([10.102.88.80])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 00:11:10 -0700
Message-ID: <737f87af-7d54-4117-851c-2f097781bf5c@linux.intel.com>
Date: Fri, 12 Jun 2026 09:10:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: fix HWS command queue leak on registration
 failure
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com
References: <20260611055140.948684-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <20260611055140.948684-1-karol.wachowski@linux.intel.com>
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

On 11-Jun-26 7:51 AM, Karol Wachowski wrote:
> A command queue is considered valid and usable by the driver only when
> it has a doorbell ID assigned (db_id != 0), meaning both the FW cmdq
> creation and doorbell registration completed successfully.
> 
> However, when either ivpu_register_db() or set_context_sched_properties()
> fails after ivpu_hws_cmdq_init() has already created the cmdq in FW,
> the command queue is left registered in FW while the driver treats it as
> uninitialized (db_id remains 0). On the next submission attempt the
> driver tries to register the same cmdq again, which fails because FW
> already has an entry for it.
> 
> Fix by calling ivpu_jsm_hws_destroy_cmdq() on error paths to properly
> unwind FW state and allow subsequent registration attempts to succeed.
> 
> Fixes: 0c7c13186866 ("accel/ivpu: Add API for command queue create/destroy/submit")
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_job.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
> index 521931d1f7fc..b24f31a8b567 100644
> --- a/drivers/accel/ivpu/ivpu_job.c
> +++ b/drivers/accel/ivpu/ivpu_job.c
> @@ -208,9 +208,9 @@ static int ivpu_hws_cmdq_init(struct ivpu_file_priv *file_priv, struct ivpu_cmdq
>   	ret = ivpu_jsm_hws_set_context_sched_properties(vdev, file_priv->ctx.id, cmdq->id,
>   							priority);
>   	if (ret)
> -		return ret;
> +		ivpu_jsm_hws_destroy_cmdq(vdev, file_priv->ctx.id, cmdq->id);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int ivpu_register_db(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cmdq)
> @@ -281,10 +281,10 @@ static int ivpu_cmdq_register(struct ivpu_file_priv *file_priv, struct ivpu_cmdq
>   	}
>   
>   	ret = ivpu_register_db(file_priv, cmdq);
> -	if (ret)
> -		return ret;
> +	if (ret && vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
> +		ivpu_jsm_hws_destroy_cmdq(vdev, file_priv->ctx.id, cmdq->id);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int ivpu_cmdq_unregister(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cmdq)

Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
