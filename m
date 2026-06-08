Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDC2CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6452A10E345;
	Mon,  8 Jun 2026 07:27:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bFjDFb14";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2555010E16E
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780903640; x=1812439640;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SJOKXNP9FmKA1NOLEfhFMPNSdAh6YT3VyxOAkzI9GYk=;
 b=bFjDFb144HWzWJSujwAC8Z/7rDXvnLWbwKHxQlz65npacR8fZj1WwekB
 PFuTWJ765oluYAuQUQYwLOqeiHcwCYeTLGKDMJN4VHbxDJVhlHZ7YHeWr
 SD2bw0UFecTGQhbXpSfabQQYJIaEytMR1APG9OqeOoNceKIXiT+TVW1kj
 cDckKOqLW32oX6eZGTWe4ssDoa6LYlY80iUiVYATr0Qa37o72BbtAqXok
 djzTOCQ3Sj31I0ZmMvhAxjQBIcaw/7r8p11v28G7NoOI30mFDg8bNIGE7
 kloN1rKb6KJyDGrrgOYqT1rN8R61xJxH8iGFMOTcRS/8XUe+dJqbLFprW w==;
X-CSE-ConnectionGUID: ZF78P5bWSxuB7GWCDLCXeQ==
X-CSE-MsgGUID: 2m1ow/bASwS856DrtTf30A==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="92199573"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="92199573"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 00:27:19 -0700
X-CSE-ConnectionGUID: jNLMCwdKTSelGTAsf47bSg==
X-CSE-MsgGUID: qpzfZxoJR5Wukvzc90cEAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="275668283"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.44])
 ([10.217.180.44])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 00:27:18 -0700
Message-ID: <7218fa4b-bb09-47a8-a2ab-7d381cf7d897@linux.intel.com>
Date: Mon, 8 Jun 2026 09:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Fix signed integer truncation in IPC
 receive
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, david.laight.linux@gmail.com,
 stable@vger.kernel.org
References: <b464b589-2d28-4617-baf0-eefbe14e170a@linux.intel.com>
 <20260601161643.229342-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260601161643.229342-1-andrzej.kacprowski@linux.intel.com>
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

On 01-Jun-26 18:16, Andrzej Kacprowski wrote:
> Fix potential buffer overflow where firmware-supplied data_size is cast
> to signed int before being used in min_t(). Large unsigned values
> (>= 0x80000000) become negative, causing unsigned wraparound and
> oversized memcpy operations that can overflow the stack buffer.
> 
> Change min_t(int, ...) to min() as both values are unsigned and can be
> handled by min() without explicit cast.
> 
> Fixes: 3b434a3445ff ("accel/ivpu: Use threaded IRQ to handle JOB done messages")
> Cc: <stable@vger.kernel.org> # v6.12+
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> ---
> Changes in v2:
> - Replaced min_t() with min()

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

> 
>   drivers/accel/ivpu/ivpu_ipc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> index f47df092bb0d..9347f05a2b79 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> @@ -276,7 +276,7 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
>   	if (ipc_buf)
>   		memcpy(ipc_buf, rx_msg->ipc_hdr, sizeof(*ipc_buf));
>   	if (rx_msg->jsm_msg) {
> -		u32 size = min_t(int, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
> +		u32 size = min(rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
>   
>   		if (rx_msg->jsm_msg->result != VPU_JSM_STATUS_SUCCESS) {
>   			ivpu_err(vdev, "IPC resp result error: %d\n", rx_msg->jsm_msg->result);
