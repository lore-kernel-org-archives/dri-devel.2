Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D6606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=NlIsZpPS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D7A210E0C0;
	Wed, 11 Nov 2026 06:19:43 +0000 (UTC)
Received: from mail-m1602365385.xmail.ntesmail.com
 (mail-m1602365385.xmail.ntesmail.com [160.236.53.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D7E10E0C0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:19:34 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5443da424;
 Wed, 11 Nov 2026 14:19:30 +0800 (GMT+08:00)
Message-ID: <704571ba-af39-441f-9eb9-09d4a2c9feb3@rock-chips.com>
Date: Wed, 11 Nov 2026 14:19:24 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] drm/rockchip: dw_hdmi_qp: Set the VOP2 color space
 from the connector
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 =?UTF-8?Q?Jan_Clau=C3=9Fen?= <jan.claussen10@web.de>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261018143135.5745-1-jan.claussen10@web.de>
 <20261018143135.5745-7-jan.claussen10@web.de>
 <cd6ff4c0-cd5d-4c42-8f52-5f3893aec015@collabora.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <cd6ff4c0-cd5d-4c42-8f52-5f3893aec015@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c942f20b03a7kunmef3b884a81d8c9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQktPVk1PTE1JTR9CHhgaSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=NlIsZpPS+ZAgSnMCOJyZ/fhpuRI6ICncfbRAEYIDCGzmKhhHkjrPZUwly1aNVM2tLOM+CozijxecNUuQP1FmSvpAvviyK2jnpcm+Exwdf80ojPZnAg2ay8vUMcLN6QrckT7XLVHk8hkiv+PvBvU1iF2v6nFTo0nvxrQ0B2obmnY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=XS5mBLwVG/2WkI+k9TR/yW0nuz+R1AOPXfUeB4VXSF8=;
 h=date:mime-version:subject:message-id:from;
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cristian and Jan,

On 11/11/2026 3:05 AM, Cristian Ciocaltea wrote:
> Hi Jan,
> 
> On 10/18/26 5:31 PM, Jan Claußen wrote:
>> VOP2 converts RGB to YCbCr using the matrix selected by the CRTC
>> state's color_space, but the HDMI encoder never sets it, so VOP2
>> always converts with BT.709. Once the colorspace property can
>> signal BT.2020 colorimetry to the sink, a YCbCr output would be
>> encoded with BT.709 and decoded with BT.2020.
>>
>> Derive color_space from the connector colorspace before the early
>> return, so that a colorspace change alone is applied.
>>
>> Signed-off-by: Jan Claußen <jan.claussen10@web.de>
>> ---
>>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
>> index 9c4cf68d79d5..10c5b6d6406e 100644
>> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
>> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/phy/phy.h>
>>  #include <linux/phy/phy-hdmi.h>
>>  #include <linux/regmap.h>
>> +#include <linux/videodev2.h>
>>  #include <linux/workqueue.h>
>>  
>>  #include <drm/bridge/dw_hdmi_qp.h>
>> @@ -187,6 +188,19 @@ static int dw_hdmi_qp_rockchip_get_vop_format(struct drm_encoder *encoder,
>>  	return bstate->output_bus_cfg.format;
>>  }
>>  
>> +static u32
>> +dw_hdmi_qp_rockchip_color_space(const struct drm_connector_state *conn_state)
>> +{
>> +	switch (conn_state->colorspace) {
>> +	case DRM_MODE_COLORIMETRY_BT2020_RGB:
>> +	case DRM_MODE_COLORIMETRY_BT2020_YCC:
>> +	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
>> +		return V4L2_COLORSPACE_BT2020;
>> +	default:
>> +		return V4L2_COLORSPACE_DEFAULT;
>> +	}
>> +}
> 
> My main concern is introducing V4L2_COLORSPACE_* logic into a DRM bridge driver,
> which should rather rely on enum drm_colorspace / DRM_MODE_COLORIMETRY_*.
> Translating the DRM colorimetry into V4L2 values only for VOP2 to map them back
> to a CSC matrix doesn't seem fully justified.
> 
> The root problem is rather on the VOP2 side: the color_space field in struct
> rockchip_crtc_state and its V4L2-based handling in the CSC selection look like
> leftovers inherited from the vendor kernel, and I think this is a good time to
> clean that up instead of building on it.
> 

Yep. And if you look at the latest vendor kernel code, we have also
removed the V4L2_COLORSPACE_* related content and switched to DRM.

-- 
Best, 
Chaoyi
