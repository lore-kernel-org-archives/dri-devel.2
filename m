Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB11C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A655210E449;
	Fri, 28 Aug 2026 10:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KgipTOtR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E90610F347;
 Fri, 28 Aug 2026 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787913711; x=1819449711;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=f+K0qnK+t6mNKTWYs0D89ek+ijl9KjSU6Bl/TO3wPLI=;
 b=KgipTOtR6CrheUIkWy3VH5mXMLetsBQ0nF+whl4yqEPDYGBkxsHXoqBu
 e+hA9Nlr0h7IZXGi7ZO2Xkeogrc1WQvVapVALhseFYhF8Mm3gI4zTpwP/
 7HGqeu04XN83AODCQAIFrCxpaENqAiZCS2FXE4gq9qGw9jC0yihZ8GV5q
 xUG0yPILvIT89dF/yoJD+4zwOj6JvUcKJYtYjN55jMzSUG4HjxpL/w6YL
 UFE5bgm8dliEbOPiNqG90gZEQeEEzHQx7pwu6O09rX+7qF/SMguNIHUNM
 kHP/JIoiO95q5ByYf3q7HUPoY5wn6V4BKd/T+zui5yPxUb9+a2gsxjG0G A==;
X-CSE-ConnectionGUID: A38x9zAQTdeGzrdxg5zGAQ==
X-CSE-MsgGUID: Ca++nCh/SE+30IB3jHdhWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88184421"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88184421"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:41:51 -0700
X-CSE-ConnectionGUID: NKNgW2lZTbOwGd79nwLkug==
X-CSE-MsgGUID: hQPN6dtEQmylalpIy6k5Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="270080645"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.99])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 03:41:46 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, Mark Yacoub
 <markyacoub@google.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.comm, simona@ffwll.ch,
 melissa.srw@gmail.com, robin.clark@oss.qualcomm.com, umag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, Kamil Konieczny
 <kamil.konieczny@linux.intel.com>, "S, Sowmiya" <sowmiya.s@intel.com>
Subject: Re: [PATCH] lib/igt_kms: Do not treat writeback and virtual
 connectors as connected
In-Reply-To: <apFh2_fIKV1I39fL@quatroqueijos.cascardo.eti.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260819190740.1392859-1-markyacoub@google.com>
 <apFh2_fIKV1I39fL@quatroqueijos.cascardo.eti.br>
Date: Fri, 28 Aug 2026 13:41:44 +0300
Message-ID: <baa2dc747160986b8b8022c37c4416d672051594@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, 28 Aug 2026, Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> On Wed, Aug 19, 2026 at 03:07:40PM -0400, Mark Yacoub wrote:
>> Writeback and virtual connectors (e.g. DRM_MODE_CONNECTOR_WRITEBACK and
>> DRM_MODE_CONNECTOR_VIRTUAL) do not represent physical display sinks and
>> cannot be modeset using standard CRTC / atomic commit operations without
>> configuring a writeback output framebuffer (WRITEBACK_FB_ID).
>> 
>> On drivers such as MSM, writeback connectors (e.g. Virtual-1, Virtual-2)
>> report connected status with virtual modes. When generic KMS tests iterate
>> over connected outputs via for_each_connected_output() or during initial
>> display setup in igt_display_init(), attempting standard modesets on these
>> connectors causes failures (-EINVAL) before test execution can begin.
>> 
>> Exclude DRM_MODE_CONNECTOR_WRITEBACK and DRM_MODE_CONNECTOR_VIRTUAL in
>> igt_output_is_connected() so generic KMS tests only target standard
>> physical display outputs, while dedicated writeback tests can continue to
>> iterate all outputs explicitly via for_each_output().
>> 
>> Signed-off-by: Mark Yacoub <markyacoub@google.com>
>> ---
>>  lib/igt_kms.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/lib/igt_kms.h b/lib/igt_kms.h
>> index 521a03c01..8d4d14847 100644
>> --- a/lib/igt_kms.h
>> +++ b/lib/igt_kms.h
>> @@ -668,6 +668,10 @@ static inline bool igt_output_is_connected(igt_output_t *output)
>>  	    !output->config.connector->count_modes)
>>  		return false;
>>  
>> +	if (output->config.connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK ||
>> +	    output->config.connector->connector_type == DRM_MODE_CONNECTOR_VIRTUAL)
>> +		return false;
>> +
>>  	if (output->config.connector->connection == DRM_MODE_CONNECTED)
>>  		return true;
>>  
>> -- 
>> 2.55.0.737.g08866a6d13-goog
>> 
>
> This makes a lot of tests (including a lot of kms_*) be skipped on VKMS. Is
> that correct?

I think the commit overlooked the fact that VKMS has virtual connectors
only. Probably needs a revert and a return to the drawing board.

Also, Someone(tm) should run CI with VKMS and IGT. Never tried myself,
but shouldn't that be possible in user-mode Linux?


BR,
Jani.


-- 
Jani Nikula, Intel
