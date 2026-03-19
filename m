Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A78C108E1FC
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE1D10E9AE;
	Thu, 19 Mar 2026 12:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="T4nhKQVE";
	dkim-atps=neutral
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714B210E9AD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:03:16 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=8fGWRdVMsvQR++vWqgLDtZsnyrK4cb1DCNNce7pnyqA=;
 b=T4nhKQVEAuyPnY7TSwGIGxkWukqdUtxOOT0H5iYGWu+DDJl1ahX5PG309ETIGFPQeS4Vq2Hy+
 5bEbOb5kdDF0dbmvhj7YhrfBcO9ThoN19QPXDXuYdOO6zUO7q3k4qrab/jZCG0unA1b7ZNOOicx
 /v+D3r544GenaxN6ZjxDgKU=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fc41j5sz1z1K96k;
 Thu, 19 Mar 2026 19:57:13 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 870B74048B;
 Thu, 19 Mar 2026 20:03:13 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Mar 2026 20:03:13 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Mar 2026 20:03:12 +0800
Message-ID: <43fe4ef5-ffdf-425c-b535-8306fbe12b3b@huawei.com>
Date: Thu, 19 Mar 2026 20:03:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 for drm-misc-fixes] MAINTAINERS: split hisilicon
 maintenance and add Yongbang Shi for hibmc-drm matainers
To: Xinliang Liu <xinliang.liu@linaro.org>
CC: <tzimmermann@suse.de>, <tiantao6@hisilicon.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <daniel@ffwll.ch>, <kong.kongxinwei@hisilicon.com>,
 <dmitry.baryshkov@oss.qualcomm.com>, <liangjian010@huawei.com>,
 <chenjianmin@huawei.com>, <fengsheng5@huawei.com>, <helin52@h-partners.com>,
 <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <shiyongbang@huawei.com>
References: <20260318125326.3709098-1-shiyongbang@huawei.com>
 <CAKoKPbzAFi+MjTq-foT78zHsdZ7kpb5ciSfVHFuHH3Tr8-MLrA@mail.gmail.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <CAKoKPbzAFi+MjTq-foT78zHsdZ7kpb5ciSfVHFuHH3Tr8-MLrA@mail.gmail.com>
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

> ,
>
> Hi,
>
> On Wed, 18 Mar 2026 at 21:01, Yongbang Shi <shiyongbang@huawei.com> wrote:
>> To improve maintainability, split the maintainer information for the hibmc and
>> kirin drivers under the drivers/gpu/drm/hisilicon directory.
>>
>> drivers/gpu/drm/hisilicon/hibmc driver has almost completed feature development
>> based on the new generation HiSilicon BMC chip. It was co-developed by
>> Yongbang Shi, Baihan Li and Lin He. Going forward, this module will be
>> maintained by Yongbang Shi.
>>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> Acked-by: Tao Tian <tiantao6@hisilicon.com>
>> ---
>>   MAINTAINERS | 37 +++++++++++++++++++++++++------------
>>   1 file changed, 25 insertions(+), 12 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d7241695df96..4f8dbadbe70b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8603,18 +8603,31 @@ S:      Maintained
>>   T:     git https://gitlab.freedesktop.org/drm/misc/kernel.git
>>   F:     drivers/gpu/drm/gma500/
>>
>> -DRM DRIVERS FOR HISILICON
>> -M:     Xinliang Liu <xinliang.liu@linaro.org>
>> -M:     Tian Tao  <tiantao6@hisilicon.com>
>> -R:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> -R:     Sumit Semwal <sumit.semwal@linaro.org>
>> -R:     Yongqin Liu <yongqin.liu@linaro.org>
>> -R:     John Stultz <jstultz@google.com>
>> -L:     dri-devel@lists.freedesktop.org
>> -S:     Maintained
>> -T:     git https://gitlab.freedesktop.org/drm/misc/kernel.git
>> -F:     Documentation/devicetree/bindings/display/hisilicon/
>> -F:     drivers/gpu/drm/hisilicon/
>> +DRM DRIVERS FOR HISILICON HIBMC
>> +M:      Yongbang Shi <shiyongbang@huawei.com>
>> +M:      Xinliang Liu <xinliang.liu@linaro.org>
>> +M:      Tian Tao  <tiantao6@hisilicon.com>
>> +R:      Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> +R:      Sumit Semwal <sumit.semwal@linaro.org>
>> +R:      Yongqin Liu <yongqin.liu@linaro.org>
>> +R:      John Stultz <jstultz@google.com>
>> +L:      dri-devel@lists.freedesktop.org
>> +S:      Maintained
>> +T:      git https://gitlab.freedesktop.org/drm/misc/kernel.git
>> +F:      drivers/gpu/drm/hisilicon/hibmc
> Please remove me, Sumit Semwal, Yongqin Liu, and John Stultz from here.
> I'm going to hand over the hibmc DRM driver maintenance to you.
> And if you look at the git log, the other three guys were added here
> for the kirin DRM driver.
> ce1fc502de42 MAINTAINERS: Add Sumit Semwal and Yongqin Liu as reviwers
> for kirin DRM driver
>
>> +
>> +DRM DRIVERS FOR HISILICON KIRIN
>> +M:      Xinliang Liu <xinliang.liu@linaro.org>
>> +M:      Tian Tao  <tiantao6@hisilicon.com>
>> +R:      Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> +R:      Sumit Semwal <sumit.semwal@linaro.org>
>> +R:      Yongqin Liu <yongqin.liu@linaro.org>
>> +R:      John Stultz <jstultz@google.com>
>> +L:      dri-devel@lists.freedesktop.org
>> +S:      Maintained
>> +T:      git https://gitlab.freedesktop.org/drm/misc/kernel.git
>> +F:      Documentation/devicetree/bindings/display/hisilicon/
>> +F:      drivers/gpu/drm/hisilicon/kirin
> Please remove Tian Tao and Xinwei Kong from here. They are here mainly
> for the hibmc DRM driver.
>
> Once address the above comments, please add my ack:
> Acked-by:  Xinliang Liu <xinliang.liu@linaro.org>
>
> And to be a DRM maintainer, you might need to apply the push
> permission of the drm-misc git repo for pushing the hibmc driver patch
> in the future.
> See the docs below for what DRM-misc is and how to apply the permission:
> https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.html
> https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html

Ok,Thank you for pointing that out. Thanks, Yongbang.


> Thank you very much for maintaining the hibmc DRM driver.
>
> Best regards,
> Xinliang
>
>>   DRM DRIVERS FOR LIMA
>>   M:     Qiang Yu <yuq825@gmail.com>
>> --
>> 2.33.0
>>
