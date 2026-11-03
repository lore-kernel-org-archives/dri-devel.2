Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE8606A804
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XhBx/KLf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591F010E4A4;
	Tue,  3 Nov 2026 10:57:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8079310E4A4
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793703456; x=1825239456;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QPguYvmA82JsTCU8FgikHkkspGIb4Etr7tA3T1fNntI=;
 b=XhBx/KLfRUPy8Qfvw/rYmX7bUWXqO6sLZviYlp0CF2j4NYWDYaNqYH4Q
 1ekvzELPAa/PUUhGwAIc4fRc4vIxRMXhSdH7nQHQXaA1knKfeDX8WoQ56
 xaWvnwV+9TKVwsP1tzItTORXW6Z6aPmu2tyFGzEuVVbxPPChH7K0Z/2Im
 kSf7Mau1mTVEXotDzKKsYz9CGyWJ+XQip58PGM86DwDjIAtT9petmj/pc
 /3HVcDZKTfHWxjGTPelWDqH/ko7dyUww1jg8l8D1BARQwiA/Ko0uAxqyK
 EFkupEZIrMmh84kDBUPke1BH8LaQNmhr1R3zrgRCJjG2rD0z6n2oaNXuu g==;
X-CSE-ConnectionGUID: RBh9x6tITBuN1ZsCUoIZLg==
X-CSE-MsgGUID: jq/9rdMeTXuEwhvoklCfNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2313006"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2313006"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 02:57:35 -0800
X-CSE-ConnectionGUID: 9CrBtWH9RGqnyf4+S5dWaw==
X-CSE-MsgGUID: iATedBMkRVylwyNSskjXWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6394460"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 02:57:34 -0800
Message-ID: <d9d9e293-6ea7-490d-b0d2-cfba733484fb@linux.intel.com>
Date: Tue, 3 Nov 2026 11:57:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Replace profiling frequency debugfs with test
 mode bit
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com
References: <20261103094215.1245113-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20261103094215.1245113-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 03-Nov-26 10:42, Andrzej Kacprowski wrote:
> Remove the profiling frequency debugfs control.
> Add IVPU_TEST_MODE_PROF_FREQ_HIGH to select
> PLL_PROFILING_FREQ_HIGH during driver initialization.
> High frequency profiling is for debugging purposes
> and it can be set at initialization time - there is
> no need to control it via debugfs.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> ---

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

>   drivers/accel/ivpu/ivpu_debugfs.c | 29 -----------------------------
>   drivers/accel/ivpu/ivpu_drv.h     |  1 +
>   drivers/accel/ivpu/ivpu_hw.c      | 13 -------------
>   drivers/accel/ivpu/ivpu_hw.h      |  1 -
>   drivers/accel/ivpu/ivpu_hw_btrs.c |  7 ++++++-
>   5 files changed, 7 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
> index dc20bc73c6ed..ae535fe49274 100644
> --- a/drivers/accel/ivpu/ivpu_debugfs.c
> +++ b/drivers/accel/ivpu/ivpu_debugfs.c
> @@ -226,33 +226,6 @@ static const struct file_operations fw_log_fops = {
>   	.release = single_release,
>   };
>   
> -static ssize_t
> -fw_profiling_freq_fops_write(struct file *file, const char __user *user_buf,
> -			     size_t size, loff_t *pos)
> -{
> -	struct ivpu_device *vdev = file->private_data;
> -	bool enable;
> -	int ret;
> -
> -	ret = kstrtobool_from_user(user_buf, size, &enable);
> -	if (ret < 0)
> -		return ret;
> -
> -	ivpu_hw_profiling_freq_drive(vdev, enable);
> -
> -	ret = pci_try_reset_function(to_pci_dev(vdev->drm.dev));
> -	if (ret)
> -		return ret;
> -
> -	return size;
> -}
> -
> -static const struct file_operations fw_profiling_freq_fops = {
> -	.owner = THIS_MODULE,
> -	.open = simple_open,
> -	.write = fw_profiling_freq_fops_write,
> -};
> -
>   static ssize_t
>   fw_trace_destination_mask_fops_write(struct file *file, const char __user *user_buf,
>   				     size_t size, loff_t *pos)
> @@ -513,8 +486,6 @@ void ivpu_debugfs_init(struct ivpu_device *vdev)
>   			    &ivpu_resume_engine_fops);
>   
>   	if (ivpu_hw_ip_gen(vdev) >= IVPU_HW_IP_40XX) {
> -		debugfs_create_file("fw_profiling_freq_drive", 0200,
> -				    debugfs_root, vdev, &fw_profiling_freq_fops);
>   		debugfs_create_file("dct", 0644, debugfs_root, vdev, &ivpu_dct_fops);
>   	}
>   
> diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
> index ea5b8dc612d1..b33a53101894 100644
> --- a/drivers/accel/ivpu/ivpu_drv.h
> +++ b/drivers/accel/ivpu/ivpu_drv.h
> @@ -238,6 +238,7 @@ extern bool ivpu_force_snoop;
>   #define IVPU_TEST_MODE_CLK_RELINQ_DISABLE BIT(11)
>   #define IVPU_TEST_MODE_CLK_RELINQ_ENABLE  BIT(12)
>   #define IVPU_TEST_MODE_D0I2_DISABLE       BIT(13)
> +#define IVPU_TEST_MODE_PROF_FREQ_HIGH     BIT(14)
>   extern int ivpu_test_mode;
>   
>   struct ivpu_file_priv *ivpu_file_priv_get(struct ivpu_file_priv *file_priv);
> diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
> index 86679d64fc14..2cc2915ab5c5 100644
> --- a/drivers/accel/ivpu/ivpu_hw.c
> +++ b/drivers/accel/ivpu/ivpu_hw.c
> @@ -359,19 +359,6 @@ int ivpu_hw_boot_fw(struct ivpu_device *vdev)
>   	return ret;
>   }
>   
> -void ivpu_hw_profiling_freq_drive(struct ivpu_device *vdev, bool enable)
> -{
> -	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX) {
> -		vdev->hw->pll.profiling_freq = PLL_PROFILING_FREQ_DEFAULT;
> -		return;
> -	}
> -
> -	if (enable)
> -		vdev->hw->pll.profiling_freq = PLL_PROFILING_FREQ_HIGH;
> -	else
> -		vdev->hw->pll.profiling_freq = PLL_PROFILING_FREQ_DEFAULT;
> -}
> -
>   void ivpu_irq_handlers_init(struct ivpu_device *vdev)
>   {
>   	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
> diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
> index 8c1b61df6cd4..de3dcb8e6173 100644
> --- a/drivers/accel/ivpu/ivpu_hw.h
> +++ b/drivers/accel/ivpu/ivpu_hw.h
> @@ -61,7 +61,6 @@ int ivpu_hw_power_up(struct ivpu_device *vdev);
>   int ivpu_hw_power_down(struct ivpu_device *vdev);
>   int ivpu_hw_reset(struct ivpu_device *vdev);
>   int ivpu_hw_boot_fw(struct ivpu_device *vdev);
> -void ivpu_hw_profiling_freq_drive(struct ivpu_device *vdev, bool enable);
>   void ivpu_irq_handlers_init(struct ivpu_device *vdev);
>   void ivpu_hw_irq_enable(struct ivpu_device *vdev);
>   void ivpu_hw_irq_disable(struct ivpu_device *vdev);
> diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
> index 840983a618ca..602d09e511e5 100644
> --- a/drivers/accel/ivpu/ivpu_hw_btrs.c
> +++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
> @@ -153,7 +153,12 @@ static int info_init_lnl(struct ivpu_device *vdev)
>   		return ret;
>   
>   	hw->tile_fuse = tile_fuse_config;
> -	hw->pll.profiling_freq = PLL_PROFILING_FREQ_DEFAULT;
> +
> +	if (ivpu_test_mode & IVPU_TEST_MODE_PROF_FREQ_HIGH)
> +		hw->pll.profiling_freq = PLL_PROFILING_FREQ_HIGH;
> +	else
> +		hw->pll.profiling_freq = PLL_PROFILING_FREQ_DEFAULT;
> +
>   	hw->btrs_irq_mask = BTRS_LNL_IRQ_MASK;
>   
>   	if (ivpu_test_mode & IVPU_TEST_MODE_FREQ_CHANGE_ENABLE)

