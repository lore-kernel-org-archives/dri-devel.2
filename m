Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBD4C624D6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0465310F1C9;
	Wed,  2 Sep 2026 12:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Cc1eMX8n";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D6B10F1C9
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788353897; x=1819889897;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TTsQ7/5iVpoqXZRtmKvAJ/ZLYemv4+I21PNUB8I2Dos=;
 b=Cc1eMX8nppE40yjQCuzNViC2pU0eoNZkySHC7/Rm1hQSaoN4LvPfpW4l
 YhVK0VysQBvYiL2VSnAdQV3MdNpEn42nZqnVDkeHybSVPYlcFRnoHcViq
 aphcWN0REy/acdXQj7WcNdTOkCamfIDmHMdY5Im1wFu/Lvljh5Mv0ohEK
 f9S2lp0t8MPV0z8KxCcSl8HYcILjAgWJyMDkag9UITJQL3crRfDp5OKDW
 YvuEv5KCHm6i2dzqicvRnHFGqqYDluhgtXMQ5Pjd/1V6P4+rDfipf/Pnf
 OzwNxiwtr5ZJsnCoMg/aer0kxOrkNEgUgdfG44JtlG9HTT80B0tTnkIS2 w==;
X-CSE-ConnectionGUID: by4Gu6YyTEq1wFyLYzJ2MA==
X-CSE-MsgGUID: NLkrInfRRWGz2I7kA1EiYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88839519"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88839519"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:58:16 -0700
X-CSE-ConnectionGUID: 8Oc9YsY/TLKBqtCXA/gQaA==
X-CSE-MsgGUID: x2zyYLg5RKGZRDjUGD8ObA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="271369313"
Received: from kpleskax-mobl2.ger.corp.intel.com (HELO [10.94.252.39])
 ([10.94.252.39])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:58:13 -0700
Message-ID: <827834ae-d595-48c6-8213-1e336e704484@linux.intel.com>
Date: Wed, 2 Sep 2026 14:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] accel/ivpu: Limit firmware log name prints to
 field size
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, stable@vger.kernel.org,
 sashiko-bot <sashiko-bot@kernel.org>
References: <20260901125749.404338-1-dawid.osuchowski@linux.intel.com>
 <20260901125749.404338-4-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260901125749.404338-4-dawid.osuchowski@linux.intel.com>
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

On 01-Sep-26 14:57, Dawid Osuchowski wrote:
> The name in struct vpu_tracing_buffer_header is a fixed-size array
> populated by the NPU firmware. It is expected to be NUL-terminated,
> but nothing on the host side enforces this, so printing it with an
> unbounded string conversion would read past the field if the
> terminator is ever missing and expose adjacent bytes of the shared
> tracing BO through dmesg and the debugfs FW log output.
> 
> Print at most as many characters as the name field holds, so the output
> never runs past it even if the string is not NUL-terminated.
> 
> Cc: stable@vger.kernel.org
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260827102339.281799-1-dawid.osuchowski@linux.intel.com?part=2
> Fixes: d4e4257afa6e ("accel/ivpu: Add firmware tracing support")
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_fw_log.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
> index 4f9055aa9d33..9eafc42120b6 100644
> --- a/drivers/accel/ivpu/ivpu_fw_log.c
> +++ b/drivers/accel/ivpu/ivpu_fw_log.c
> @@ -69,9 +69,9 @@ static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *off
>   	*offset += size;
>   
>   	ivpu_dbg(vdev, FW_BOOT,
> -		 "FW log name \"%s\", write offset 0x%x size 0x%x, wrap count %d, hdr version %d size %d format %d, alignment %d",
> -		 log->name, log->write_index, size, log->wrap_count, log->header_version,
> -		 header_size, log->format, log->alignment);
> +		 "FW log name \"%.*s\", write offset 0x%x size 0x%x, wrap count %d, hdr version %d size %d format %d, alignment %d",
> +		 (int)ARRAY_SIZE(log->name), log->name, log->write_index, size, log->wrap_count,
> +		 log->header_version, header_size, log->format, log->alignment);
>   
>   	return 0;
>   }
> @@ -123,7 +123,8 @@ static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefi
>   
>   	if (log->wrap_count == log->read_wrap_count) {
>   		if (log_end <= log_start) {
> -			drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);
> +			drm_printf(p, "==== %s \"%.*s\" log empty ====\n", prefix,
> +				   (int)ARRAY_SIZE(log->name), log->name);
>   			return;
>   		}
>   	} else if (log->wrap_count == log->read_wrap_count + 1) {
> @@ -133,7 +134,8 @@ static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefi
>   		log_start = log_end;
>   	}
>   
> -	drm_printf(p, "==== %s \"%s\" log start ====\n", prefix, log->name);
> +	drm_printf(p, "==== %s \"%.*s\" log start ====\n", prefix, (int)ARRAY_SIZE(log->name),
> +		   log->name);
>   	if (log_end > log_start) {
>   		fw_log_print_lines(log_data + log_start, log_end - log_start, p);
>   	} else {
> @@ -141,7 +143,8 @@ static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefi
>   		fw_log_print_lines(log_data, log_end, p);
>   	}
>   	drm_printf(p, "\n\x1b[0m"); /* add new line and clear formatting */
> -	drm_printf(p, "==== %s \"%s\" log end   ====\n", prefix, log->name);
> +	drm_printf(p, "==== %s \"%.*s\" log end   ====\n", prefix, (int)ARRAY_SIZE(log->name),
> +		   log->name);
>   }
>   
>   static void

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
