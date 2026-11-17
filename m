Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD674606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5pWdZoEl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD3510F6E2;
	Tue, 17 Nov 2026 13:04:10 +0000 (UTC)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134BE10F6E3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:04:03 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=SHJZaWrKHNhHUqos5xpllk63Yn/OQUNoxKtkvNvJ2EE=;
 b=5pWdZoEltFxbPMoef/xATCGqmi8k3EEg2rfUtIrPI+OOlZLeirFHp/bDmS4djZZ9hnHU/g8xZ
 3JGhomXimyWBJ+DtzU4m1B3KenAr+nNEkhzZNpKFRfTj3j6M6Z0xvCJOxn7fgvfjgAJHSKnAzEy
 KcBPB26EM95gPqgrJYhS8Yw=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jTQ0H62HSzRhTB;
 Tue, 17 Nov 2026 21:03:43 +0800 (CST)
Received: from kwepemk200005.china.huawei.com (unknown [7.202.194.71])
 by mail.maildlp.com (Postfix) with ESMTPS id E0AB140561;
 Tue, 17 Nov 2026 21:03:57 +0800 (CST)
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemk200005.china.huawei.com (7.202.194.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 17 Nov 2026 21:03:57 +0800
Message-ID: <fd6919ff-393a-4d07-a138-e0d6d7ab0cdc@huawei.com>
Date: Tue, 17 Nov 2026 21:03:55 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v4 2/2] drm/hisilicon/hibmc: Add a flag
 to indicate whether the OS-side driver has been loaded
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20261026060303.289737-1-shiyongbang@huawei.com>
 <20261026060303.289737-3-shiyongbang@huawei.com>
 <sashiko-outbox-184838@kernel.org>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <sashiko-outbox-184838@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200005.china.huawei.com (7.202.194.71)
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] drm/hisilicon/hibmc: unconditional enable flag set when DP init fails
> --
> 
> commit 9960ec3a8f045c4b7198b1788310aca553de0cc3
> Author: Lin He <helin52@huawei.com>
> 
> drm/hisilicon/hibmc: Add a flag to indicate whether the OS-side driver has been loaded
> 
> This commit adds a hardware register flag (HIBMC_ENABLE_STATE in
> HIBMC_ENABLE_FLAG) to notify the BMC when the OS-side driver is loaded and
> unloaded, preventing the BMC from enabling DP and triggering unhandled
> interrupts before the driver is ready. It also introduces a spinlock to
> serialize read-modify-write operations on the shared register.
> 
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index df4501bb076bc..15583a2d1c6fd 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> 
> [ ... ]
> 
>> @@ -460,6 +486,8 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>>   		goto err_return;
>>   	}
>>   
>> +	hibmc_set_enable_flag(priv);
> 
> [Severity: High]
> Should hibmc_set_enable_flag() be called unconditionally here if DP
> initialization failed or if fewer than two MSI vectors were allocated?
> 
> In drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c, hibmc_kms_init() treats
> hibmc_dp_init() failures as non-fatal so that VDAC can still function:
> 
> 	ret = readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL);
> 	if (ret) {
> 		ret = hibmc_dp_init(priv);
> 		if (ret)
> 			drm_err(dev, "failed to init dp: %d\n", ret);
> 	}
> 
> Meanwhile, hibmc_msi_init() either allocates 2 MSI vectors and registers
> hibmc_dp_interrupt and hibmc_dp_hpd_isr unconditionally, or succeeds with
> HIBMC_MIN_VECTORS (1) without registering the DP interrupt handler at all.
> 
> If hibmc_set_enable_flag() is called unconditionally in hibmc_pci_probe()
> and the BMC subsequently enables DP and triggers a DP interrupt:
> 
> 1. If hibmc_dp_init() failed before allocating priv->dp.dp_dev (or failed
>     in hibmc_dp_serdes_init() before clearing HIBMC_DP_INTR_ENABLE),
>     hibmc_dp_interrupt() calls hibmc_dp_get_hpd_status(&priv->dp), which
>     dereferences a NULL dp->dp_dev pointer in hard IRQ context.
> 
> 2. If hibmc_dp_init() failed during encoder or connector initialization,
>     priv->dp.connector.dev remains NULL, and the threaded handler
>     hibmc_dp_hpd_isr() calls drm_connector_helper_hpd_irq_event(),
>     dereferencing NULL.
> 
> 3. If pci_alloc_irq_vectors() only allocated 1 MSI vector, the DP interrupt
>     has no handler registered.
> 
> Would it be safer to only set HIBMC_ENABLE_STATE when DP has been
> successfully initialized and its MSI vector is registered?
> 

Okay, I will add a new state to record the DP initialization status and check
it when setting the flag.

Thanks,
Yongbang



