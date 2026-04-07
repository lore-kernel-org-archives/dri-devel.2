Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C587FB5189
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 03:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF05910E332;
	Tue,  7 Apr 2026 03:02:12 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5529610E332
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 03:02:11 +0000 (UTC)
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
 by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fqWF31RTfz1BG7p
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 11:01:43 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fqW6G1F0xz1prRD;
 Tue,  7 Apr 2026 10:55:50 +0800 (CST)
Received: from kwepemf100009.china.huawei.com (unknown [7.202.181.223])
 by mail.maildlp.com (Postfix) with ESMTPS id 43E912025F;
 Tue,  7 Apr 2026 11:02:06 +0800 (CST)
Received: from [10.67.121.162] (10.67.121.162) by
 kwepemf100009.china.huawei.com (7.202.181.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 11:02:05 +0800
Subject: Re: [PATCH for drm-misc-fixes v2 4/4] drm/hisilicon/hibmc: use clock
 to look up the PLL value
To: Yongbang Shi <shiyongbang@huawei.com>, <tzimmermann@suse.de>,
 <dmitry.baryshkov@oss.qualcomm.com>, <xinliang.liu@linaro.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <daniel@ffwll.ch>, <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <helin52@h-partners.com>, <shenjian15@huawei.com>,
 <shaojijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
References: <20260403024828.1131906-1-shiyongbang@huawei.com>
 <20260403024828.1131906-5-shiyongbang@huawei.com>
From: "tiantao (H)" <tiantao6@hisilicon.com>
Message-ID: <fe73e9fc-f51a-b476-5d3a-157837052f15@hisilicon.com>
Date: Tue, 7 Apr 2026 11:02:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20260403024828.1131906-5-shiyongbang@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.162]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100009.china.huawei.com (7.202.181.223)
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


ÔÚ 2026/4/3 10:48, Yongbang Shi Ð´µÀ:
> From: Lin He <helin52@huawei.com>
>
> In the past, we use width and height to look up our PLL value.
> But actually the actual clock check is also necessnary. There are
> some resolutions that width and height same, but its clock different.
> Add the clock check when using pll_table to determine the PLL value.
>
> Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display engine")
> Signed-off-by: Lin He <helin52@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v1 -> v2:
>    - remove tag "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>", witch will
>      be given in public.
>    - add 'drm-misc-fixes' in subject prefix.
> ---
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 80 +++++++++++--------
>   1 file changed, 46 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 89bed78f1466..8561acbbc3c8 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -22,6 +22,8 @@
>   #include "hibmc_drm_drv.h"
>   #include "hibmc_drm_regs.h"
>   
> +#define CLOCK_TOLERANCE 100 /* kHz tolerance */
> +
The macro CLOCK_TOLERANCE is introduced in this patch but not referenced.
If it's not required, please drop the definition to avoid dead code.
If it is intended for future use, please add a comment explaining its 
purpose.

>   struct hibmc_display_panel_pll {
>   	u64 M;
>   	u64 N;
> @@ -32,26 +34,43 @@ struct hibmc_display_panel_pll {
>   struct hibmc_dislay_pll_config {
>   	u64 hdisplay;
>   	u64 vdisplay;
> +	int clock;
>   	u32 pll1_config_value;
>   	u32 pll2_config_value;
>   };
>   
>   static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
> -	{640, 480, CRT_PLL1_HS_25MHZ, CRT_PLL2_HS_25MHZ},
> -	{800, 600, CRT_PLL1_HS_40MHZ, CRT_PLL2_HS_40MHZ},
> -	{1024, 768, CRT_PLL1_HS_65MHZ, CRT_PLL2_HS_65MHZ},
> -	{1152, 864, CRT_PLL1_HS_80MHZ_1152, CRT_PLL2_HS_80MHZ},
> -	{1280, 768, CRT_PLL1_HS_80MHZ, CRT_PLL2_HS_80MHZ},
> -	{1280, 720, CRT_PLL1_HS_74MHZ, CRT_PLL2_HS_74MHZ},
> -	{1280, 960, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
> -	{1280, 1024, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
> -	{1440, 900, CRT_PLL1_HS_106MHZ, CRT_PLL2_HS_106MHZ},
> -	{1600, 900, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
> -	{1600, 1200, CRT_PLL1_HS_162MHZ, CRT_PLL2_HS_162MHZ},
> -	{1920, 1080, CRT_PLL1_HS_148MHZ, CRT_PLL2_HS_148MHZ},
> -	{1920, 1200, CRT_PLL1_HS_193MHZ, CRT_PLL2_HS_193MHZ},
> +	{640, 480, 25000, CRT_PLL1_HS_25MHZ, CRT_PLL2_HS_25MHZ},
> +	{800, 600, 40000, CRT_PLL1_HS_40MHZ, CRT_PLL2_HS_40MHZ},
> +	{1024, 768, 65000, CRT_PLL1_HS_65MHZ, CRT_PLL2_HS_65MHZ},
> +	{1152, 864, 78750, CRT_PLL1_HS_80MHZ_1152, CRT_PLL2_HS_80MHZ},
> +	{1280, 768, 80000, CRT_PLL1_HS_80MHZ, CRT_PLL2_HS_80MHZ},
> +	{1280, 720, 74375, CRT_PLL1_HS_74MHZ, CRT_PLL2_HS_74MHZ},
> +	{1280, 960, 108000, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
> +	{1280, 1024, 108000, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
> +	{1440, 900, 105952, CRT_PLL1_HS_106MHZ, CRT_PLL2_HS_106MHZ},
> +	{1600, 900, 108000, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
> +	{1600, 1200, 162500, CRT_PLL1_HS_162MHZ, CRT_PLL2_HS_162MHZ},
> +	{1920, 1080, 148750, CRT_PLL1_HS_148MHZ, CRT_PLL2_HS_148MHZ},
> +	{1920, 1200, 193750, CRT_PLL1_HS_193MHZ, CRT_PLL2_HS_193MHZ},
>   };
>   
> +static int hibmc_get_best_clock_idx(const struct drm_display_mode *mode)
> +{
> +	int i, diff;
> +
> +	for (i = 0; i < ARRAY_SIZE(hibmc_pll_table); i++) {
> +		if (hibmc_pll_table[i].hdisplay == mode->hdisplay &&
> +		    hibmc_pll_table[i].vdisplay == mode->vdisplay) {
> +			diff = abs(mode->clock - hibmc_pll_table[i].clock);
> +			if (diff < mode->clock / 100) /* tolerance 1/100 */
> +				return i;
> +		}
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
>   static int hibmc_plane_atomic_check(struct drm_plane *plane,
>   				    struct drm_atomic_state *state)
>   {
> @@ -214,17 +233,13 @@ static enum drm_mode_status
>   hibmc_crtc_mode_valid(struct drm_crtc *crtc,
>   		      const struct drm_display_mode *mode)
>   {
> -	size_t i = 0;
>   	int vrefresh = drm_mode_vrefresh(mode);
>   
>   	if (vrefresh < 59 || vrefresh > 61)
>   		return MODE_NOCLOCK;
>   
> -	for (i = 0; i < ARRAY_SIZE(hibmc_pll_table); i++) {
> -		if (hibmc_pll_table[i].hdisplay == mode->hdisplay &&
> -		    hibmc_pll_table[i].vdisplay == mode->vdisplay)
> -			return MODE_OK;
> -	}
> +	if (hibmc_get_best_clock_idx(mode) >= 0)
> +		return MODE_OK;
>   
>   	return MODE_BAD;
>   }
> @@ -281,23 +296,20 @@ static void set_vclock_hisilicon(struct drm_device *dev, u64 pll)
>   	writel(val, priv->mmio + CRT_PLL1_HS);
>   }
>   
> -static void get_pll_config(u64 x, u64 y, u32 *pll1, u32 *pll2)
> +static void get_pll_config(struct drm_display_mode *mode, u32 *pll1, u32 *pll2)
>   {
> -	size_t i;
> -	size_t count = ARRAY_SIZE(hibmc_pll_table);
> -
> -	for (i = 0; i < count; i++) {
> -		if (hibmc_pll_table[i].hdisplay == x &&
> -		    hibmc_pll_table[i].vdisplay == y) {
> -			*pll1 = hibmc_pll_table[i].pll1_config_value;
> -			*pll2 = hibmc_pll_table[i].pll2_config_value;
> -			return;
> -		}
> +	int idx;
> +
> +	idx = hibmc_get_best_clock_idx(mode);
> +	if (idx < 0) {
> +		/* if found none, we use default value */
> +		*pll1 = CRT_PLL1_HS_25MHZ;
> +		*pll2 = CRT_PLL2_HS_25MHZ;
> +		return;
>   	}
>   
> -	/* if found none, we use default value */
> -	*pll1 = CRT_PLL1_HS_25MHZ;
> -	*pll2 = CRT_PLL2_HS_25MHZ;
> +	*pll1 = hibmc_pll_table[idx].pll1_config_value;
> +	*pll2 = hibmc_pll_table[idx].pll2_config_value;
>   }
>   
>   /*
> @@ -319,7 +331,7 @@ static u32 display_ctrl_adjust(struct drm_device *dev,
>   	x = mode->hdisplay;
>   	y = mode->vdisplay;
>   
> -	get_pll_config(x, y, &pll1, &pll2);
> +	get_pll_config(mode, &pll1, &pll2);
>   	writel(pll2, priv->mmio + CRT_PLL2_HS);
>   	set_vclock_hisilicon(dev, pll1);
>   
