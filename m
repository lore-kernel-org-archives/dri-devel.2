Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CF3E9A74C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F062110E131;
	Tue, 24 Mar 2026 09:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="kpMPl3LL";
	dkim-atps=neutral
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C8E10E131
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:30:09 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=taUqtCi2vlxxccKzv1LC+mi+qctm2JrXoQKBlOmS+t0=;
 b=kpMPl3LLh2rDIDcTlbN7Cx2lHpCjOnilr1hb58ITKgVub89AZjrfRFkop3zPjUhbr+zVfHPWD
 ZwIkYoNahDgE98DcGdND4jvt+B+n9bLlFKv2i+pNtSXXxFMzeRNTegRgbISCqgW+0rSsXy2SReE
 6hOcTP0GjfwciEQZFXc8ako=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fg4Nf17zfz1cyPF;
 Tue, 24 Mar 2026 17:24:02 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 4E9754056C;
 Tue, 24 Mar 2026 17:30:06 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Mar 2026 17:30:06 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Mar 2026 17:30:05 +0800
Message-ID: <ca35b9e2-a166-486d-a75b-6a6b92ef79ce@huawei.com>
Date: Tue, 24 Mar 2026 17:30:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND drm-dp 0/4] Fix some bugs in the hibmc driver
To: "tzimmermann@suse.de" <tzimmermann@suse.de>, "tiantao (H)"
 <tiantao6@hisilicon.com>, "xinliang.liu@linaro.org"
 <xinliang.liu@linaro.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "kongxinwei (A)"
 <kong.kongxinwei@hisilicon.com>, "dmitry.baryshkov@oss.qualcomm.com"
 <dmitry.baryshkov@oss.qualcomm.com>, <shiyongbang@huawei.com>
CC: "Liangjian(Jim,Kunpeng Solution Development Dept)"
 <liangjian010@huawei.com>, Chenjianmin <chenjianmin@huawei.com>, "fengsheng
 (A)" <fengsheng5@huawei.com>, "helin (T)" <helin52@h-partners.com>, "shenjian
 (K)" <shenjian15@huawei.com>, shaojijie <shaojijie@huawei.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260312074202.1491504-1-shiyongbang@huawei.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260312074202.1491504-1-shiyongbang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq100007.china.huawei.com (7.202.195.175)
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

Hi Thomas, Dmitry,

I have a question, this patch was sent in 2026.3.12, back when Linux was
in the mainline linux 7.0-rc4 stage, and it still hasn't been accepted.
Since this is a bug fix, I'd like to get it accepted into the mainline
as soon as possible. Should I add "drm-misc-fixes" to the subject line
to specify that it should be sent to that branch?

By the way, If I need to resend it with subject-prefix "drm-misc-fixes",
I'll remove the "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>" and
reply via email.Thanks,
Yongbang


> From: Lin He <helin52@huawei.com>
>
> There are some bugfix for hibmc-drm driver.
>
> Lin He (4):
>    drm/hisilicon/hibmc: add updating link cap in DP detect()
>    drm/hisilicon/hibmc: fix no showing when no connectors connected
>    drm/hisilicon/hibmc: move display contrl config to hibmc_probe()
>    drm/hisilicon/hibmc: use clock to look up the PLL value
>
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  1 +
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  1 +
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  |  2 +-
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 80 +++++++++++--------
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 35 +++++---
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 14 ++++
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  1 +
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 74 ++++++++---------
>   8 files changed, 123 insertions(+), 85 deletions(-)
>
