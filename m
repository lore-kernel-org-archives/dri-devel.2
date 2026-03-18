Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C4710854BE
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F69B10E6EB;
	Wed, 18 Mar 2026 09:21:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="ZUz/qOVX";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZUz/qOVX";
	dkim-atps=neutral
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD8D10E6EB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:21:01 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=2O6+F83mBMMoECpvDTi7oW3ptd4Byni//tQnXbKqDTg=;
 b=ZUz/qOVXbXDMg+zCdJPQG3eHVJiBUMBffRynCCJZh1rmLYscJ/ZJR++uPJQtW8LwQv7sgLUDL
 WkTTB90HHhyLNuUWm0v4z0olxLENwb9aLsW5n9MaRZCOkPDn/zE+oE1m08klZXsCAsiivgTFmYe
 iC1pi0GkJjhu0oy2rD7ESJE=
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
 by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fbNZs1g6pz1BJ5h
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 17:20:05 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=2O6+F83mBMMoECpvDTi7oW3ptd4Byni//tQnXbKqDTg=;
 b=ZUz/qOVXbXDMg+zCdJPQG3eHVJiBUMBffRynCCJZh1rmLYscJ/ZJR++uPJQtW8LwQv7sgLUDL
 WkTTB90HHhyLNuUWm0v4z0olxLENwb9aLsW5n9MaRZCOkPDn/zE+oE1m08klZXsCAsiivgTFmYe
 iC1pi0GkJjhu0oy2rD7ESJE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fbNTb5950zpSvM;
 Wed, 18 Mar 2026 17:15:31 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 66A8B2025F;
 Wed, 18 Mar 2026 17:20:55 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 17:20:55 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 17:20:54 +0800
Message-ID: <565221f8-e6ee-4aaa-9f67-9243c8eb4493@huawei.com>
Date: Wed, 18 Mar 2026 17:20:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes] MAINTAINERS: add Yongbang Shi for
 drivers/gpu/drm/hisilicon matainers
To: Xinliang Liu <xinliang.liu@linaro.org>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, "tiantao (H)"
 <tiantao6@hisilicon.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "kongxinwei (A)"
 <kong.kongxinwei@hisilicon.com>, "dmitry.baryshkov@oss.qualcomm.com"
 <dmitry.baryshkov@oss.qualcomm.com>, "Liangjian(Jim,Kunpeng Solution
 Development Dept)" <liangjian010@huawei.com>, Chenjianmin
 <chenjianmin@huawei.com>, "fengsheng (A)" <fengsheng5@huawei.com>, "helin
 (T)" <helin52@h-partners.com>, "shenjian (K)" <shenjian15@huawei.com>,
 shaojijie <shaojijie@huawei.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
References: <20260318011426.3130333-1-shiyongbang@huawei.com>
 <CAKoKPby5F0WSjM75qLTVtdP2V00O+3GQvALOTiZFCWGFMjKjLw@mail.gmail.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <CAKoKPby5F0WSjM75qLTVtdP2V00O+3GQvALOTiZFCWGFMjKjLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

OK, Xinliang, that's a good idea. I will split the maintenance.

Thanks,
Yongbang


> Hi,
> Good to see active maintenance for hibmc driver.
> I guess you guys are maintaining drivers/gpu/drm/hisilicon/hibmc.
> There is a Hikey kirin driver under the hisilicon directory as well.
>
> In case someone is not receiving unrelated emails, could you 
> separate the maintenance for the two drivers?
> Like:
> DRM DRIVERS FOR HISILICON HIBMC
> You guys list here for maintainers and reviewers
> ...
> F: drivers/gpu/drm/hisilicon/hibmc
>
> DRM DRIVERS FOR HISILICON KIRIN
> Other guys list here for maintainers and reviewers
> ...
> F: drivers/gpu/drm/hisilicon/kirin
>
> Thanks,
> Xinliang
>
> On Wed, 18 Mar 2026 at 09:22, Yongbang Shi <shiyongbang@huawei.com> wrote:
>
>     drivers/gpu/drm/hisilicon/hibmc driver has almost completed
>     feature development
>     based on the new generation HiSilicon BMC chip. It was co-developed by
>     Yongbang Shi, Baihan Li and Lin He. Going forward, this module will be
>     maintained by Yongbang Shi.
>
>     Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>     Acked-by: Tao Tian <tiantao6@hisilicon.com>
>     ---
>      MAINTAINERS | 1 +
>      1 file changed, 1 insertion(+)
>
>     diff --git a/MAINTAINERS b/MAINTAINERS
>     index 96ea84948d76..ef3ff26ac1dc 100644
>     --- a/MAINTAINERS
>     +++ b/MAINTAINERS
>     @@ -8604,6 +8604,7 @@ T:        git
>     https://gitlab.freedesktop.org/drm/misc/kernel.git
>      F:     drivers/gpu/drm/gma500/
>
>      DRM DRIVERS FOR HISILICON
>     +M:     Yongbang Shi <shiyongbang@huawei.com>
>      M:     Xinliang Liu <xinliang.liu@linaro.org>
>      M:     Tian Tao  <tiantao6@hisilicon.com>
>      R:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
>     -- 
>     2.33.0
>
