Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52218CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B12CF10FDF8;
	Fri, 29 May 2026 12:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W0B/zdLV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5288A10FDF8
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780056375; x=1811592375;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=AY7YLc7DM7Bur7kuFzTZdDbr2bQsNDaW897mAT11cMU=;
 b=W0B/zdLVcXvvrmLwQqPJoTpbhETAO6g/Cggitgsim20Ahr6ugbzWqVL3
 saXrhMOZ7lMrgGsZOg6MnDplugKjV3ef8VaeX4vsC1wm62fHqPxqv+Cuf
 thIhr30WpzghOmNBCdHPooKX0b4VMXUUC74bAKItPXs2y5FIasPxVse3y
 VN6VpMJjTCi/g0QwT/B00fJ9CEP9fT0t/0vjeD72PoIv7xtmNIaBh+BQP
 5Lo6yNg9rsiJN/mB30ITUuYDAykVgyPOymkG6Yllkmsc/49wJHtEzbuui
 bK/VXmJfLe7+LUQDvNBwY6p95as07hdz2YQwJKmWNDMffJgEA1wUxIOHU Q==;
X-CSE-ConnectionGUID: PllN6/EMRLWpl5GgBNvVXw==
X-CSE-MsgGUID: Wl08W4xRTMGkZodNfJCuqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="92381115"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="92381115"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:06:14 -0700
X-CSE-ConnectionGUID: YRAgIjD/Sz2ZK8Nhy9urJA==
X-CSE-MsgGUID: aenAzjgCSAaHZE90gAoT2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="266704778"
Received: from mgoluns-desk.ger.corp.intel.com (HELO [10.245.80.25])
 ([10.245.80.25])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:06:12 -0700
Message-ID: <9c0b071d-efd0-4b89-9e75-78b8355d90d4@linux.intel.com>
Date: Fri, 29 May 2026 14:06:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add bounds checks for firmware log indices
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529115842.135378-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260529115842.135378-1-andrzej.kacprowski@linux.intel.com>
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

On 29-May-26 13:58, Andrzej Kacprowski wrote:
> Add validation that read and write indices in the firmware log buffer
> are within valid bounds (< data_size) before using them. If
> out-of-bounds indices are encountered (from firmware), clamp them to
> safe values instead of proceeding with invalid offsets.
> 
> This prevents potential out-of-bounds buffer access when firmware
> supplies invalid log indices.
> 
> Fixes: 1fc1251149a7 ("accel/ivpu: Refactor functions in ivpu_fw_log.c")
> Cc: <stable@vger.kernel.org> # v6.18+
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

> ---
>   drivers/accel/ivpu/ivpu_fw_log.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
> index 337c906b0210..275baf844b56 100644
> --- a/drivers/accel/ivpu/ivpu_fw_log.c
> +++ b/drivers/accel/ivpu/ivpu_fw_log.c
> @@ -98,6 +98,11 @@ static void fw_log_print_buffer(struct vpu_tracing_buffer_header *log, const cha
>   	u32 log_start = only_new_msgs ? READ_ONCE(log->read_index) : 0;
>   	u32 log_end = READ_ONCE(log->write_index);
>   
> +	if (log_start >= data_size)
> +		log_start = 0;
> +	if (log_end > data_size)
> +		log_end = data_size;
> +
>   	if (log->wrap_count == log->read_wrap_count) {
>   		if (log_end <= log_start) {
>   			drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);

