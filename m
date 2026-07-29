Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F72C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA65410E64E;
	Wed, 29 Jul 2026 11:14:27 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B64E10E631
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:14:16 +0000 (UTC)
X-UUID: 9f70a7908b3e11f1aa26b74ffac11d73-20260729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:36d63765-e2c6-43a9-bf56-f5b4fc7c7be9, IP:0,
 U
 RL:0,TC:0,Content:11,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:11
X-CID-META: VersionHash:e7bac3a, CLOUDID:424a2a298356391d8c43dffbdbb9a819,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:4
 |15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
 SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9f70a7908b3e11f1aa26b74ffac11d73-20260729
Received: from [10.42.17.251] [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <oushixiong@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
 with ESMTP id 356961306; Wed, 29 Jul 2026 19:14:10 +0800
Message-ID: <b6a77872-b4e4-46d4-b4c0-f5e20bed11a4@kylinos.cn>
Date: Wed, 29 Jul 2026 19:14:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/log: Fix division by zero when scale module
 parameter is 0
To: oushixiong1025@163.com, Jocelyn Falempe <jfalempe@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <20260729105840.865696-1-oushixiong1025@163.com>
Content-Language: en-US
From: Shixiong Ou <oushixiong@kylinos.cn>
In-Reply-To: <20260729105840.865696-1-oushixiong1025@163.com>
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

Adding to Cc Jani Nikula

On 2026/7/29 18:58, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> The scale module parameter can be set to 0 via kernel command line or
> sysfs. When scale is 0, scaled_font_h and scaled_font_w become 0,
> causing a division by zero in the rows/columns calculation.
>
> Introduce a drm_log_scale() helper that returns scale ?: 1, and use it
> at all read sites. This avoids a race that a setter-based clamp would
> have between param_set_uint() and the subsequent check, where another
> CPU could observe scale == 0.
>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
> v1->v2:
>     Introduce a drm_log_scale() helper.
>
>   drivers/gpu/drm/clients/drm_log.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index 294b3be1a6b3..9522c1344123 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -29,6 +29,11 @@ static unsigned int scale = 1;
>   module_param(scale, uint, 0444);
>   MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, default is 1");
>   
> +static inline unsigned int drm_log_scale(void)
> +{
> +	return scale ?: 1;
> +}
> +
>   /**
>    * DOC: overview
>    *
> @@ -76,13 +81,13 @@ static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
>   {
>   	switch (px_width) {
>   	case 2:
> -		drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, width, scale, color);
> +		drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, width, drm_log_scale(), color);
>   		break;
>   	case 3:
> -		drm_draw_blit24(dst, dst_pitch, src, src_pitch, height, width, scale, color);
> +		drm_draw_blit24(dst, dst_pitch, src, src_pitch, height, width, drm_log_scale(), color);
>   		break;
>   	case 4:
> -		drm_draw_blit32(dst, dst_pitch, src, src_pitch, height, width, scale, color);
> +		drm_draw_blit32(dst, dst_pitch, src, src_pitch, height, width, drm_log_scale(), color);
>   		break;
>   	default:
>   		WARN_ONCE(1, "Can't blit with pixel width %d\n", px_width);
> @@ -216,8 +221,8 @@ static int drm_log_setup_modeset(struct drm_client_dev *client,
>   		return -ENOMEM;
>   	}
>   	mode_set->fb = scanout->buffer->fb;
> -	scanout->scaled_font_h = scanout->font->height * scale;
> -	scanout->scaled_font_w = scanout->font->width * scale;
> +	scanout->scaled_font_h = scanout->font->height * drm_log_scale();
> +	scanout->scaled_font_w = scanout->font->width * drm_log_scale();
>   	scanout->rows = height / scanout->scaled_font_h;
>   	scanout->columns = width / scanout->scaled_font_w;
>   	scanout->front_color = drm_draw_color_from_xrgb8888(0xffffff, format);
