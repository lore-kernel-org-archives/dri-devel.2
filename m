Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB17EFF886F
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D387E10E0A1;
	Tue, 28 Apr 2026 06:14:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="AytlwYKe";
	dkim-atps=neutral
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D230C10E0A1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 06:14:11 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=4jtzaZVol03S+yIm5JkpA1F/0hXeP8du+x+1tWAm9/U=;
 b=AytlwYKeyoe7LNdsvlK55dMrwWIy018xQGYFyEMPQpNA60UTAqLWqJmk+kzHVWIPsqaobMubX
 Hbrn/j1bD/O/dCYv2pY4zxzrUbgul1Rwuqu1KUav4kr78r2IwmR37JGChw2zR4Mc1Ol8wi8sG6m
 QGJeZGypRWTnUhbR64lPI6w=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4g4VMn5K9rzpSvH;
 Tue, 28 Apr 2026 14:07:33 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id A839840538;
 Tue, 28 Apr 2026 14:14:08 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 14:14:08 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 14:14:07 +0800
Message-ID: <4846f056-dcf8-43ab-a947-2197d89e5494@huawei.com>
Date: Tue, 28 Apr 2026 14:14:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v5 4/4] drm/hisilicon/hibmc: use clock
 to look up the PLL value
To: Thomas Zimmermann <tzimmermann@suse.de>,
 <dmitry.baryshkov@oss.qualcomm.com>, <tiantao6@hisilicon.com>,
 <xinliang.liu@linaro.org>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <helin52@h-partners.com>, <shenjian15@huawei.com>,
 <shaojijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <shiyongbang@huawei.com>
References: <20260423063233.1267631-1-shiyongbang@huawei.com>
 <20260423063233.1267631-5-shiyongbang@huawei.com>
 <c5d2b5cd-df8b-4bbd-a0cc-4d7e3ad61da3@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <c5d2b5cd-df8b-4bbd-a0cc-4d7e3ad61da3@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
> Am 23.04.26 um 08:32 schrieb Yongbang Shi:
>> From: Lin He <helin52@huawei.com>
>>
>> In the past, we use width and height to look up our PLL value.
>> But actually the actual clock check is also necessnary. There are
>> some resolutions that width and height same, but its clock different.
>> Add the clock check when using pll_table to determine the PLL value.
>>
>> Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display engine")
>> Signed-off-by: Lin He <helin52@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> ---
>> ChangeLog:
>> v2 -> v3:
>>    - remove unused macro CLOCK_TOLERANCE.
>> v1 -> v2:
>>    - remove tag "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>", witch will
>>      be given in public.
>>    - add 'drm-misc-fixes' in subject prefix.
>> ---
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 78 +++++++++++--------
>>   1 file changed, 44 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> index 89bed78f1466..1a07e8146eee 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> @@ -32,26 +32,43 @@ struct hibmc_display_panel_pll {
>>   struct hibmc_dislay_pll_config {
>>       u64 hdisplay;
>>       u64 vdisplay;
>> +    int clock;
>>       u32 pll1_config_value;
>>       u32 pll2_config_value;
>>   };
>>     static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
>> -    {640, 480, CRT_PLL1_HS_25MHZ, CRT_PLL2_HS_25MHZ},
>> -    {800, 600, CRT_PLL1_HS_40MHZ, CRT_PLL2_HS_40MHZ},
>> -    {1024, 768, CRT_PLL1_HS_65MHZ, CRT_PLL2_HS_65MHZ},
>> -    {1152, 864, CRT_PLL1_HS_80MHZ_1152, CRT_PLL2_HS_80MHZ},
>> -    {1280, 768, CRT_PLL1_HS_80MHZ, CRT_PLL2_HS_80MHZ},
>> -    {1280, 720, CRT_PLL1_HS_74MHZ, CRT_PLL2_HS_74MHZ},
>> -    {1280, 960, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
>> -    {1280, 1024, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
>> -    {1440, 900, CRT_PLL1_HS_106MHZ, CRT_PLL2_HS_106MHZ},
>> -    {1600, 900, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
>> -    {1600, 1200, CRT_PLL1_HS_162MHZ, CRT_PLL2_HS_162MHZ},
>> -    {1920, 1080, CRT_PLL1_HS_148MHZ, CRT_PLL2_HS_148MHZ},
>> -    {1920, 1200, CRT_PLL1_HS_193MHZ, CRT_PLL2_HS_193MHZ},
>> +    {640, 480, 25000, CRT_PLL1_HS_25MHZ, CRT_PLL2_HS_25MHZ},
>> +    {800, 600, 40000, CRT_PLL1_HS_40MHZ, CRT_PLL2_HS_40MHZ},
>> +    {1024, 768, 65000, CRT_PLL1_HS_65MHZ, CRT_PLL2_HS_65MHZ},
>> +    {1152, 864, 78750, CRT_PLL1_HS_80MHZ_1152, CRT_PLL2_HS_80MHZ},
>> +    {1280, 768, 80000, CRT_PLL1_HS_80MHZ, CRT_PLL2_HS_80MHZ},
>> +    {1280, 720, 74375, CRT_PLL1_HS_74MHZ, CRT_PLL2_HS_74MHZ},
>> +    {1280, 960, 108000, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
>> +    {1280, 1024, 108000, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
>> +    {1440, 900, 105952, CRT_PLL1_HS_106MHZ, CRT_PLL2_HS_106MHZ},
>> +    {1600, 900, 108000, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
>> +    {1600, 1200, 162500, CRT_PLL1_HS_162MHZ, CRT_PLL2_HS_162MHZ},
>> +    {1920, 1080, 148750, CRT_PLL1_HS_148MHZ, CRT_PLL2_HS_148MHZ},
>> +    {1920, 1200, 193750, CRT_PLL1_HS_193MHZ, CRT_PLL2_HS_193MHZ},
>>   };
>>   +static int hibmc_get_best_clock_idx(const struct drm_display_mode *mode)
>> +{
>> +    int i, diff;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(hibmc_pll_table); i++) {
>> +        if (hibmc_pll_table[i].hdisplay == mode->hdisplay &&
>> +            hibmc_pll_table[i].vdisplay == mode->vdisplay) {
>> +            diff = abs(mode->clock - hibmc_pll_table[i].clock);
>> +            if (diff < mode->clock / 100) /* tolerance 1/100 */
>> +                return i;
>> +        }
>> +    }
>> +
>> +    return -EOPNOTSUPP;
> 
> This errno code is for sockets.
> 
> Rather return -MODE_CLOCK_RANGE here, which you can then return from .mode_valid as well.
> 

Okay. I will fix in v6.

Thanks,
Yongbang.

> Best regards
> Thomas
> 
> 
>> +}
>> +
>>   static int hibmc_plane_atomic_check(struct drm_plane *plane,
>>                       struct drm_atomic_state *state)
>>   {
>> @@ -214,17 +231,13 @@ static enum drm_mode_status
>>   hibmc_crtc_mode_valid(struct drm_crtc *crtc,
>>                 const struct drm_display_mode *mode)
>>   {
>> -    size_t i = 0;
>>       int vrefresh = drm_mode_vrefresh(mode);
>>         if (vrefresh < 59 || vrefresh > 61)
>>           return MODE_NOCLOCK;
>>   -    for (i = 0; i < ARRAY_SIZE(hibmc_pll_table); i++) {
>> -        if (hibmc_pll_table[i].hdisplay == mode->hdisplay &&
>> -            hibmc_pll_table[i].vdisplay == mode->vdisplay)
>> -            return MODE_OK;
>> -    }
>> +    if (hibmc_get_best_clock_idx(mode) >= 0)
>> +        return MODE_OK;
>>         return MODE_BAD;
>>   }
>> @@ -281,23 +294,20 @@ static void set_vclock_hisilicon(struct drm_device *dev, u64 pll)
>>       writel(val, priv->mmio + CRT_PLL1_HS);
>>   }
>>   -static void get_pll_config(u64 x, u64 y, u32 *pll1, u32 *pll2)
>> +static void get_pll_config(struct drm_display_mode *mode, u32 *pll1, u32 *pll2)
>>   {
>> -    size_t i;
>> -    size_t count = ARRAY_SIZE(hibmc_pll_table);
>> -
>> -    for (i = 0; i < count; i++) {
>> -        if (hibmc_pll_table[i].hdisplay == x &&
>> -            hibmc_pll_table[i].vdisplay == y) {
>> -            *pll1 = hibmc_pll_table[i].pll1_config_value;
>> -            *pll2 = hibmc_pll_table[i].pll2_config_value;
>> -            return;
>> -        }
>> +    int idx;
>> +
>> +    idx = hibmc_get_best_clock_idx(mode);
>> +    if (idx < 0) {
>> +        /* if found none, we use default value */
>> +        *pll1 = CRT_PLL1_HS_25MHZ;
>> +        *pll2 = CRT_PLL2_HS_25MHZ;
>> +        return;
>>       }
>>   -    /* if found none, we use default value */
>> -    *pll1 = CRT_PLL1_HS_25MHZ;
>> -    *pll2 = CRT_PLL2_HS_25MHZ;
>> +    *pll1 = hibmc_pll_table[idx].pll1_config_value;
>> +    *pll2 = hibmc_pll_table[idx].pll2_config_value;
>>   }
>>     /*
>> @@ -319,7 +329,7 @@ static u32 display_ctrl_adjust(struct drm_device *dev,
>>       x = mode->hdisplay;
>>       y = mode->vdisplay;
>>   -    get_pll_config(x, y, &pll1, &pll2);
>> +    get_pll_config(mode, &pll1, &pll2);
>>       writel(pll2, priv->mmio + CRT_PLL2_HS);
>>       set_vclock_hisilicon(dev, pll1);
>>   
> 

