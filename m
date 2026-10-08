Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A7ACA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E13C810E76D;
	Thu,  8 Oct 2026 10:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AUx8bCu1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9997910E76D
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 10:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791455497; x=1822991497;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=p2sH1T+I7HvLbQHOYoHwgHvxZJT79+teuaDB0DTFgiA=;
 b=AUx8bCu1F7xLGiFR1nuOpiU1xWHLXhPJjvJt3RFAsrTSLpGD5HKeeeTu
 uZ/wcQlUlQzX9F7phA5V2yYsEJ/Ht+EL3B0QVj9rXPllAWYbQNGSsH7u4
 oc7OFEMmPf8ILA2vWyQWEPS/KzW/Q91Rl0mwvy/Pm48qBfAthSf0qWypG
 QjJXIVXa4SFydxrjM+BZYRlp+T9tTVctWtH8GRoGBTKN+7H7N2dLh0oGU
 UVLd3WMcgUDaGbtTk6bI4uAqnD4EU6r4ZwOwfxe4KBJUSyqmnY0ZNn7Ai
 M7Fhq/t7c7nXdQCs7GHj1/dI9wp8ytXbQvC1Q+3x/YEWliyP+Qx/AbUmL Q==;
X-CSE-ConnectionGUID: 5FrLJmV6Qw28VuDbzebtSw==
X-CSE-MsgGUID: cgfgqLMjR9SkjD75LZxpmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="241914"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="241914"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:31:37 -0700
X-CSE-ConnectionGUID: HLYojpreS1O17+cGkTlAWA==
X-CSE-MsgGUID: 3HvFwj9cTNa4hVXqeNxGnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="117569"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:31:36 -0700
Message-ID: <7531e594-41dd-419e-b78a-8600162b6d24@linux.intel.com>
Date: Thu, 8 Oct 2026 12:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com
References: <20261008100013.3006983-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20261008100013.3006983-1-andrzej.kacprowski@linux.intel.com>
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

On 08-Oct-26 12:00, Andrzej Kacprowski wrote:
> In FW_TEST mode, boot the firmware but skip the ready wait and all
> subsequent firmware communication. The firmware test reports its
> results through the firmware log.
> 
> Disable driver timeouts in this mode so timeout handling does not
> interrupt the firmware test.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_drv.c | 3 +++
>   drivers/accel/ivpu/ivpu_hw.c  | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 6b71edf566e7..8c3fb0f01a31 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -539,6 +539,9 @@ int ivpu_boot(struct ivpu_device *vdev)
>   	ivpu_hw_irq_enable(vdev);
>   	ivpu_ipc_enable(vdev);
>   
> +	if (ivpu_test_mode & IVPU_TEST_MODE_FW_TEST)
> +		return 0;
> +
>   	if (!ivpu_fw_is_warm_boot(vdev)) {
>   		ret = ivpu_pm_dct_init(vdev);
>   		if (ret)
> diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
> index 59a5de8d9270..8b63140e3160 100644
> --- a/drivers/accel/ivpu/ivpu_hw.c
> +++ b/drivers/accel/ivpu/ivpu_hw.c
> @@ -94,7 +94,7 @@ static void wa_init(struct ivpu_device *vdev)
>   
>   static void timeouts_init(struct ivpu_device *vdev)
>   {
> -	if (ivpu_test_mode & IVPU_TEST_MODE_DISABLE_TIMEOUTS) {
> +	if (ivpu_test_mode & (IVPU_TEST_MODE_DISABLE_TIMEOUTS | IVPU_TEST_MODE_FW_TEST)) {
>   		/* in milliseconds, negative value disables the timeout */
>   		vdev->timeout.boot = -1;
>   		vdev->timeout.jsm = -1;

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
