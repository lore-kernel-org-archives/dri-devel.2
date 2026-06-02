Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC2DC5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90035113864;
	Tue,  2 Jun 2026 05:49:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="noO22Ui9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ECA8113864
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 05:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780379371; x=1811915371;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=XiyYyAHDe/o5OzbJ6v9PhRD2lY35xaiYM1/wBqdFa8o=;
 b=noO22Ui9QsSEjBzGjv9RCVK/AH27bdYzzgqmfs7Glt3XRaO+eU8niMYz
 vLrPRmbhkVzObhynbI1EZAded3U6bv09By2ZUxyfGyZJADAGJXC6EZXVA
 Pgat3MIu8J6xGyQW6yHiKyQAMJJUQgIEIqjDc0u0s/W48UVqQiKn32onw
 mcwAlw68DL4yH1df3+SqBAkqlPJWRPsx8rW9omJpuoz8CqwRcWZahG6Tv
 ROWALFC2J9R2rJpiiEBsgsetpXluKs8XncBLgEwbrOxLOrM7KFFDbI4ef
 wBP8FMg3AUlI2BYO5krIhfrQ/6HKGt/eoF/uIc+5kgleCleiU9ahQYYv5 g==;
X-CSE-ConnectionGUID: hqDmwU41TIOwGEFCTK9ClQ==
X-CSE-MsgGUID: c7fn4OwGRd61360qkDD/ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="85045059"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="85045059"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 22:49:30 -0700
X-CSE-ConnectionGUID: /g+LueiEQsu0jQDFl/Bbjw==
X-CSE-MsgGUID: t10f2cToRSSnznqba1m3ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="267451367"
Received: from martanox-mobl.ger.corp.intel.com (HELO [10.94.250.132])
 ([10.94.250.132])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 22:49:27 -0700
Message-ID: <093b7951-a0f3-4935-adfa-dfd4fe45bea9@linux.intel.com>
Date: Tue, 2 Jun 2026 07:49:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add bounds checks for firmware log indices
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529115842.135378-1-andrzej.kacprowski@linux.intel.com>
 <9c0b071d-efd0-4b89-9e75-78b8355d90d4@linux.intel.com>
Content-Language: en-US
In-Reply-To: <9c0b071d-efd0-4b89-9e75-78b8355d90d4@linux.intel.com>
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

On 29-May-26 14:06, Wachowski, Karol wrote:
> On 29-May-26 13:58, Andrzej Kacprowski wrote:
>> Add validation that read and write indices in the firmware log buffer
>> are within valid bounds (< data_size) before using them. If
>> out-of-bounds indices are encountered (from firmware), clamp them to
>> safe values instead of proceeding with invalid offsets.
>>
>> This prevents potential out-of-bounds buffer access when firmware
>> supplies invalid log indices.
>>
>> Fixes: 1fc1251149a7 ("accel/ivpu: Refactor functions in ivpu_fw_log.c")
>> Cc: <stable@vger.kernel.org> # v6.18+
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> 

Applied to drm-misc-fixes.

>> ---
>>   drivers/accel/ivpu/ivpu_fw_log.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ 
>> ivpu_fw_log.c
>> index 337c906b0210..275baf844b56 100644
>> --- a/drivers/accel/ivpu/ivpu_fw_log.c
>> +++ b/drivers/accel/ivpu/ivpu_fw_log.c
>> @@ -98,6 +98,11 @@ static void fw_log_print_buffer(struct 
>> vpu_tracing_buffer_header *log, const cha
>>       u32 log_start = only_new_msgs ? READ_ONCE(log->read_index) : 0;
>>       u32 log_end = READ_ONCE(log->write_index);
>> +    if (log_start >= data_size)
>> +        log_start = 0;
>> +    if (log_end > data_size)
>> +        log_end = data_size;
>> +
>>       if (log->wrap_count == log->read_wrap_count) {
>>           if (log_end <= log_start) {
>>               drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, 
>> log->name);
> 
> 

