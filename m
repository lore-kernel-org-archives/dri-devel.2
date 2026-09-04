Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605C3C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE7BD10E54B;
	Fri,  4 Sep 2026 08:53:06 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A97410E54B
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:53:03 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.129])
 by gateway (Coremail) with SMTP id _____8CxPNLshppqS5oIAA--.24536S3;
 Fri, 04 Sep 2026 16:53:00 +0800 (CST)
Received: from [10.20.42.129] (unknown [10.20.42.129])
 by front1 (Coremail) with SMTP id qMiowJBx6c3rhppq6ssaAA--.25462S3;
 Fri, 04 Sep 2026 16:52:59 +0800 (CST)
Subject: Re: [PATCH V3] drm/loongson: Create blend mode property for cursor
 plane
To: Huacai Chen <chenhuacai@loongson.cn>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Huacai Chen <chenhuacai@kernel.org>,
 Qianhai Wu <wuqianhai@loongson.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, dri-devel@lists.freedesktop.org
References: <20260903084212.3621540-1-chenhuacai@loongson.cn>
From: Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <d40cf8e3-b128-7af4-a998-6eb9e7d398cf@loongson.cn>
Date: Fri, 4 Sep 2026 16:39:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260903084212.3621540-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx6c3rhppq6ssaAA--.25462S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF1DtFWfCw1DCryUAr15KFX_yoW8tryrpa
 nrCFW0krZ0yFWDJ3srA3saya13ZayfGa4vqryrJ39F9ryqkF9rAr1UCFnIgrWUJF47G34a
 gryxCFsrCF4DKFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
 JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUU
 UU=
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



On 2026/9/3 下午4:42, Huacai Chen wrote:
> After commit 860e748bddcc929 ("drm: ensure blend mode supported if pixel
> format with alpha exposed") we get warnings at boot:
> 
> loongson 0000:00:06.1: [drm] [PLANE:41:ls-cursor-plane-0] pixel format with alpha exposed but blend mode not setup. Please fix.
> loongson 0000:00:06.1: [drm] [PLANE:46:ls-cursor-plane-1] pixel format with alpha exposed but blend mode not setup. Please fix.
> 
> The reason is the cursor plane supports color formats with alpha but the
> driver doesn't create blend mode property, which triggers the warning in
> validate_blend_mode_for_alpha_formats().
> 
> The loongson DC HW doesn't support DRM_MODE_BLEND_PREMULTI, so create
> blend mode property with DRM_MODE_BLEND_COVERAGE for cursor planes since
> it is the only one implemented in the driver.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
Reviewed-by: Jianmin Lv <lvjianmin@loongson.cn>

>   drivers/gpu/drm/loongson/lsdc_plane.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loongson/lsdc_plane.c
> index bea42215796d..bcc0ffa17bdf 100644
> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
> @@ -7,6 +7,7 @@
>   
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_blend.h>
>   #include <drm/drm_framebuffer.h>
>   #include <drm/drm_gem_atomic_helper.h>
>   #include <drm/drm_print.h>
> @@ -765,7 +766,7 @@ int ls7a1000_cursor_plane_init(struct drm_device *ddev,
>   
>   	drm_plane_helper_add(plane, &ls7a1000_cursor_plane_helper_funcs);
>   
> -	return 0;
> +	return drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_COVERAGE));
>   }
>   
>   int ls7a2000_cursor_plane_init(struct drm_device *ddev,
> @@ -790,5 +791,5 @@ int ls7a2000_cursor_plane_init(struct drm_device *ddev,
>   
>   	drm_plane_helper_add(plane, &ls7a2000_cursor_plane_helper_funcs);
>   
> -	return 0;
> +	return drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_COVERAGE));
>   }
> 

