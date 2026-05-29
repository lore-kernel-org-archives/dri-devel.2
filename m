Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EEDCD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB2E10FE01;
	Fri, 29 May 2026 12:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="m+SgjH+v";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1194D10FE01
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780056231; x=1811592231;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ghM0U831hKCdDL+dTygEhGz4xGBPcfucNQVi/sbfTzg=;
 b=m+SgjH+vOuJJdDO0RwnQyeFRgE8YBjsbpiHsb/hxf4fwEVdSQ7SxuH59
 raNG5GQCh473KTS6JWMQwr7i8DBopQQF7R9B9KJHvJsq5uc5x4ysZRWeR
 zxjO+lcIBUyTB54VbhSLTTxg2amI+sTeTwb7vtEJa5UMSd8rF9FixD86U
 AMUByhFMlLeiO91wL5ZM3OTtwmbrQLvBukyjDAVhX7TzX7BFwtGGbUlBL
 DFdmZWfae2XDOfxbLzAM6k2CiBkPmKZC4cJ5/oATVPxL9GLTceXWsxjoz
 qAJNtA/b/Y593kHCSOzaznTWWUW+M6Eeq9Z3DdFnnUogN3tghEOXiE9zx Q==;
X-CSE-ConnectionGUID: J+t1Uh0xSWShC75RIwDaQA==
X-CSE-MsgGUID: V9DWEx6sTMSpwG3yeK1SjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="92380814"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="92380814"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:03:50 -0700
X-CSE-ConnectionGUID: ByWMDaHgS9e7kTtdJWvmKw==
X-CSE-MsgGUID: OtqxAANFR52hyHAy8NIIzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="266704016"
Received: from mgoluns-desk.ger.corp.intel.com (HELO [10.245.80.25])
 ([10.245.80.25])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:03:47 -0700
Message-ID: <cf9be472-0d8c-4103-b2c3-345765e7594e@linux.intel.com>
Date: Fri, 29 May 2026 14:03:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Fix signed integer truncation in IPC receive
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529115453.132291-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260529115453.132291-1-andrzej.kacprowski@linux.intel.com>
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

On 29-May-26 13:54, Andrzej Kacprowski wrote:
> Fix potential buffer overflow where firmware-supplied data_size is cast
> to signed int before being used in min_t(). Large unsigned values
> (>= 0x80000000) become negative, causing unsigned wraparound and
> oversized memcpy operations that can overflow the stack buffer.
> 
> Change min_t(int, ...) to min_t(u32, ...) to ensure large values are
> properly clamped instead of becoming negative.
> 
> Fixes: 3b434a3445ff ("accel/ivpu: Use threaded IRQ to handle JOB done messages")
> Cc: <stable@vger.kernel.org> # v6.18+
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

> ---
>   drivers/accel/ivpu/ivpu_ipc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> index f47df092bb0d..9980a7898bed 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> @@ -276,7 +276,7 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
>   	if (ipc_buf)
>   		memcpy(ipc_buf, rx_msg->ipc_hdr, sizeof(*ipc_buf));
>   	if (rx_msg->jsm_msg) {
> -		u32 size = min_t(int, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
> +		u32 size = min_t(u32, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
>   
>   		if (rx_msg->jsm_msg->result != VPU_JSM_STATUS_SUCCESS) {
>   			ivpu_err(vdev, "IPC resp result error: %d\n", rx_msg->jsm_msg->result);

