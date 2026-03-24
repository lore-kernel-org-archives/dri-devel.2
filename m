Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B51F532EF
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594BF10E5B4;
	Tue, 24 Mar 2026 08:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FNzUo5ss";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192C710E5B4
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 08:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774341146; x=1805877146;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=0jRrOAI03t67hrsoD6qZ/ZOKagtZrC7OAtNILxB5xbE=;
 b=FNzUo5ss734bmE3KjpODVCbDYflzSqsSZEDHcOnJchDjwteXiJ7HLlLA
 iSgmcbYmhgfsR+4+v9XYjZSRgpPU6NBpgvmO719myH3DdWWNovqVX2EoX
 1TRQJvTRC/Hg2PU7/p8DfsgIhJLGYcUF5WwpSIpvUsy9Xf3NVXtLiUT78
 Tk6PHAHnd9KtmrSSekGH29bOu0CcbQS8wti2FGqDyL9FkL+bcZJ7ZgfY0
 O7GSOUetKNj9GiPzkggT5PrU6tAGTApiNfxgX8BMaj1veAZTIuMfSfEOi
 vx3a0r/EghWha48sVSr8enQ6Nyqjnn7aOo2hpbmcq/K70e5yH7RcrnH3V Q==;
X-CSE-ConnectionGUID: G6S6Hm+HTIiUCoC7wKG9WA==
X-CSE-MsgGUID: EMhqjFqRRd2l9bAS14nWUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="79207287"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="79207287"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 01:32:26 -0700
X-CSE-ConnectionGUID: 5+GSlt+8S7iEDpFZ+lGAUA==
X-CSE-MsgGUID: sVAPbTj3SJy/LxDXbosa4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="217718803"
Received: from unknown (HELO [10.102.88.30]) ([10.102.88.30])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 01:32:24 -0700
Message-ID: <f6ed76a2-0907-4c56-a3a7-7b0eec4a3c08@linux.intel.com>
Date: Tue, 24 Mar 2026 09:32:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add disable clock relinquish workaround for
 NVL-A0
To: Lizhi Hou <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 maciej.falkowski@linux.intel.com, andrzej.kacprowski@linux.intel.com,
 stable@vger.kernel.org
References: <20260323095029.64613-1-karol.wachowski@linux.intel.com>
 <0317ba0d-6260-6e4f-ad5d-514297da7d73@amd.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <0317ba0d-6260-6e4f-ad5d-514297da7d73@amd.com>
Content-Type: text/plain; charset=UTF-8
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

On 3/23/2026 5:53 PM, Lizhi Hou wrote:
> 
> On 3/23/26 02:50, Karol Wachowski wrote:
>> Turn on disable clock relinquish workaround for Nova Lake A0.
>> Without this workaround NPU may not power off correctly after
>> inference, leading to unexpected system behavior.
>>
>> Fixes: 550f4dd2cedd ("accel/ivpu: Add support for Nova Lake's NPU")
>> Cc: <stable@vger.kernel.org> # v6.19+
>>
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_drv.h | 1 +
>>   drivers/accel/ivpu/ivpu_hw.c  | 6 ++++--
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/
>> ivpu_drv.h
>> index 5b34b6f50e69..f1b6155065ff 100644
>> --- a/drivers/accel/ivpu/ivpu_drv.h
>> +++ b/drivers/accel/ivpu/ivpu_drv.h
>> @@ -35,6 +35,7 @@
>>   #define IVPU_HW_IP_60XX 60
>>     #define IVPU_HW_IP_REV_LNL_B0 4
>> +#define IVPU_HW_IP_REV_NVL_A0 0
>>     #define IVPU_HW_BTRS_MTL 1
>>   #define IVPU_HW_BTRS_LNL 2
>> diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
>> index d69cd0d93569..d4a9bcda4100 100644
>> --- a/drivers/accel/ivpu/ivpu_hw.c
>> +++ b/drivers/accel/ivpu/ivpu_hw.c
>> @@ -70,8 +70,10 @@ static void wa_init(struct ivpu_device *vdev)
>>       if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
>>           vdev->wa.interrupt_clear_with_0 =
>> ivpu_hw_btrs_irqs_clear_with_0_mtl(vdev);
>>   -    if (ivpu_device_id(vdev) == PCI_DEVICE_ID_LNL &&
>> -        ivpu_revision(vdev) < IVPU_HW_IP_REV_LNL_B0)
>> +    if ((ivpu_device_id(vdev) == PCI_DEVICE_ID_LNL &&
>> +         ivpu_revision(vdev) < IVPU_HW_IP_REV_LNL_B0) ||
>> +        (ivpu_device_id(vdev) == PCI_DEVICE_ID_NVL &&
>> +         ivpu_revision(vdev) == IVPU_HW_IP_REV_NVL_A0))
> Reviewed-by: Lizhi.hou <lizhi.hou@amd.com>

Thank you, applied to drm-misc-fixes.

Karol

>>           vdev->wa.disable_clock_relinquish = true;
>>         if (ivpu_test_mode & IVPU_TEST_MODE_CLK_RELINQ_ENABLE)
> 

