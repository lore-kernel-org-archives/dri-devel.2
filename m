Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505B3108E1FE
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B56EC10E9D4;
	Thu, 19 Mar 2026 12:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="GPkjwzKu";
	dkim-atps=neutral
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8050810E9E6
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:19:18 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=o5dCJcE75fawAW/YtTdJpjUV1wg7SofSF083pzscpPA=;
 b=GPkjwzKu/UJIr59vfruIyJ3JlE8dYKXLfuQQSeSEHgyhIsR3bnzveYFU5PhBNhRTdPLl3wDT0
 NmHufjw9NJr5CsxZbZCkpGCWeHG7iIo1ayh7u++tBnod3OVGEgdQ7Z/YmeMWkXmZm4FMsZntURX
 7/aHez8/rcakjYj9x9V/liU=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fc4Nv4N8bz1T4G6;
 Thu, 19 Mar 2026 20:13:51 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 6B18B40569;
 Thu, 19 Mar 2026 20:19:14 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Mar 2026 20:19:14 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Mar 2026 20:19:13 +0800
Message-ID: <b3006b05-6728-4a43-9883-7f4c5ac5e07f@huawei.com>
Date: Thu, 19 Mar 2026 20:19:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 for drm-misc-fixes] MAINTAINERS: split hisilicon
 maintenance and add Yongbang Shi for hibmc-drm matainers
To: Thomas Zimmermann <tzimmermann@suse.de>, <tiantao6@hisilicon.com>,
 <xinliang.liu@linaro.org>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <helin52@h-partners.com>, <shenjian15@huawei.com>,
 <shaojijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <shiyongbang@huawei.com>
References: <20260318125326.3709098-1-shiyongbang@huawei.com>
 <a9d79fe1-b78e-4df8-9ced-6ff81ff90b87@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <a9d79fe1-b78e-4df8-9ced-6ff81ff90b87@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


> Hi
>
> Am 18.03.26 um 13:53 schrieb Yongbang Shi:
>> To improve maintainability, split the maintainer information for the 
>> hibmc and
>> kirin drivers under the drivers/gpu/drm/hisilicon directory.
>>
>> drivers/gpu/drm/hisilicon/hibmc driver has almost completed feature 
>> development
>> based on the new generation HiSilicon BMC chip. It was co-developed by
>> Yongbang Shi, Baihan Li and Lin He. Going forward, this module will be
>> maintained by Yongbang Shi.
>>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> Acked-by: Tao Tian <tiantao6@hisilicon.com>
>
> Nit: tags should be given in public even if there was an internal 
> review.  That adds accountability to the patch.


Okay, we'll make that change after this patch.

Thanks,

Yongbang



>
> Apart from that:
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Best regards
> Thomas
>
>> ---
>>   MAINTAINERS | 37 +++++++++++++++++++++++++------------
>>   1 file changed, 25 insertions(+), 12 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d7241695df96..4f8dbadbe70b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8603,18 +8603,31 @@ S:    Maintained
>>   T:    git https://gitlab.freedesktop.org/drm/misc/kernel.git
>>   F:    drivers/gpu/drm/gma500/
>>   -DRM DRIVERS FOR HISILICON
>> -M:    Xinliang Liu <xinliang.liu@linaro.org>
>> -M:    Tian Tao  <tiantao6@hisilicon.com>
>> -R:    Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> -R:    Sumit Semwal <sumit.semwal@linaro.org>
>> -R:    Yongqin Liu <yongqin.liu@linaro.org>
>> -R:    John Stultz <jstultz@google.com>
>> -L:    dri-devel@lists.freedesktop.org
>> -S:    Maintained
>> -T:    git https://gitlab.freedesktop.org/drm/misc/kernel.git
>> -F:    Documentation/devicetree/bindings/display/hisilicon/
>> -F:    drivers/gpu/drm/hisilicon/
>> +DRM DRIVERS FOR HISILICON HIBMC
>> +M:      Yongbang Shi <shiyongbang@huawei.com>
>> +M:      Xinliang Liu <xinliang.liu@linaro.org>
>> +M:      Tian Tao  <tiantao6@hisilicon.com>
>> +R:      Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> +R:      Sumit Semwal <sumit.semwal@linaro.org>
>> +R:      Yongqin Liu <yongqin.liu@linaro.org>
>> +R:      John Stultz <jstultz@google.com>
>> +L:      dri-devel@lists.freedesktop.org
>> +S:      Maintained
>> +T:      git https://gitlab.freedesktop.org/drm/misc/kernel.git
>> +F:      drivers/gpu/drm/hisilicon/hibmc
>> +
>> +DRM DRIVERS FOR HISILICON KIRIN
>> +M:      Xinliang Liu <xinliang.liu@linaro.org>
>> +M:      Tian Tao  <tiantao6@hisilicon.com>
>> +R:      Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> +R:      Sumit Semwal <sumit.semwal@linaro.org>
>> +R:      Yongqin Liu <yongqin.liu@linaro.org>
>> +R:      John Stultz <jstultz@google.com>
>> +L:      dri-devel@lists.freedesktop.org
>> +S:      Maintained
>> +T:      git https://gitlab.freedesktop.org/drm/misc/kernel.git
>> +F:      Documentation/devicetree/bindings/display/hisilicon/
>> +F:      drivers/gpu/drm/hisilicon/kirin
>>     DRM DRIVERS FOR LIMA
>>   M:    Qiang Yu <yuq825@gmail.com>
>
