Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239A4C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 08:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2462C10E12A;
	Wed, 15 Jul 2026 08:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Pb8DEWbl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C234110E12A
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 08:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784103712; x=1815639712;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=iAfny9tsRkFi7wpfX7LS5mYT1VvazfuKi7jHx/gyRFg=;
 b=Pb8DEWbly6M26oCxzg+yza33TCrngPCqC2aJ+c4uRiYLBOL9J5gkxeqL
 PFnTKZDCXikxN2fn5RpqEa2jPW+ugnNPnNLL5rjg5zDMI0e2PjtuPFa6U
 Cg1a77Wo2bTX7tMb8cnWbZImlarglvBySipD+zNEx01tF+GCJ9qq0FDRw
 i5WRf9zx2boDeFByxyszXqIfoDFakwyp5tXuedDluLYaCrm81k/01w+R+
 eLTUIcwJwpwOz/k+2XawiSCLPqcs9ZT+QRAHjC4/zdvhhiVXlxla8fGzi
 B7dTnuol7MkL2Vwy5q7TgeWwTRaJEbxL0qfT96XJgIjaRWftwhv9M85PU A==;
X-CSE-ConnectionGUID: 2nu59pYEQoSbJEcTsfecMg==
X-CSE-MsgGUID: XmkwASpvTgiBZo6jXoEFTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84614801"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="84614801"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 01:21:52 -0700
X-CSE-ConnectionGUID: 0GJVSs5IR16Jw2/YG8oxaQ==
X-CSE-MsgGUID: UtluDqoOSH2K6JLyb2Aylw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="261017499"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.64])
 ([10.217.180.64])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 01:21:50 -0700
Message-ID: <68d6db92-5e48-477f-ba97-d116480e0636@linux.intel.com>
Date: Wed, 15 Jul 2026 10:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Reject firmware log with size smaller than
 header
To: Jhonraushan <raushan.jhon@gmail.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260715074206.867712-1-raushan.jhon@gmail.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260715074206.867712-1-raushan.jhon@gmail.com>
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

On 15-Jul-26 9:42, Jhonraushan wrote:
> fw_log_from_bo() validates the tracing buffer header_size and that the
> log fits within the BO, but never checks that log->size is at least
> log->header_size. fw_log_print_buffer() then computes:
> 
>    u32 data_size = log->size - log->header_size;
> 
> which underflows to a near-U32_MAX value when firmware reports a log whose
> size is smaller than its header. That huge data_size defeats the
> log_start/log_end bounds clamps added by commit dd1311bcf0e6 ("accel/ivpu:
> Add bounds checks for firmware log indices"), so fw_log_print_lines() reads
> far past the small real data region of the BO. A size of 0 also makes
> fw_log_from_bo() advance the offset by 0, causing the callers to loop
> forever on the same header.
> 
> Reject logs whose size is smaller than the header (which also rejects
> size == 0).
> 
> Fixes: d4e4257afa6e ("accel/ivpu: Add firmware tracing support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jhonraushan <raushan.jhon@gmail.com>
> ---
>   drivers/accel/ivpu/ivpu_fw_log.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
> index 275baf844b56..716467aa3156 100644
> --- a/drivers/accel/ivpu/ivpu_fw_log.c
> +++ b/drivers/accel/ivpu/ivpu_fw_log.c
> @@ -43,6 +43,10 @@ static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *off
>   		ivpu_dbg(vdev, FW_BOOT, "Invalid header size 0x%x\n", log->header_size);
>   		return -EINVAL;
>   	}
> +	if (log->size < log->header_size) {
> +		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
> +		return -EINVAL;
> +	}
>   	if ((char *)log + log->size > (char *)ivpu_bo_vaddr(bo) + ivpu_bo_size(bo)) {
>   		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
>   		return -EINVAL;

Thanks for submission.

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
