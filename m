Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC11606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=PZO5l/Ej
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDEB10FA45;
	Wed, 11 Nov 2026 09:41:47 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 248CA10FA45
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794390100;
 bh=7bKfGK/qfrm5C2JrxSXmO8PZzjTGFJi/TFX3XJ6m2pw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PZO5l/Ejq89WXSLT0iNZzGbyMuSbknvtJVfebh0uGdhvmGRJVnrNAECtWICrY9xE8
 fswm8tEuSBwZju0QcuZ1vJuzu6I6rzFDi/lG4sEYEqyAjJC89tZiOt2it9ip0R4k/y
 K8WVytv8j7VTBgf3x6SDMRZ+MRIBYMoShLvcx/YbCsXtbzXjtMVs3JhYGjKWbN1ALc
 Ddu6DWUFA1l8L4eCL54xMipncsJx8E/2rk9OTFh6g2TW/rXBGwNP0WiaV+7UExvcUT
 t8pIgFRko+26XxFrq9UZiE9vBZRUcCjYDGWZp77jTgMyy+m1SoJGtrx9CKKPeA19Uu
 7q6xKwXCc8ZfA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F74017E05D6;
 Wed, 11 Nov 2026 10:41:40 +0100 (CET)
Message-ID: <7f4c2132-bb73-4698-ab68-902fada398b6@collabora.com>
Date: Wed, 11 Nov 2026 11:41:39 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] drm/rockchip: dw_hdmi_qp: Set the VOP2 color space
 from the connector
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>,
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
 <704571ba-af39-441f-9eb9-09d4a2c9feb3@rock-chips.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <704571ba-af39-441f-9eb9-09d4a2c9feb3@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Chaoyi,

On 11/11/26 8:19 AM, Chaoyi Chen wrote:
> Hi Cristian and Jan,
> 
> On 11/11/2026 3:05 AM, Cristian Ciocaltea wrote:
>> Hi Jan,
>>
>> On 10/18/26 5:31 PM, Jan Claußen wrote:
>>> VOP2 converts RGB to YCbCr using the matrix selected by the CRTC
>>> state's color_space, but the HDMI encoder never sets it, so VOP2
>>> always converts with BT.709. Once the colorspace property can
>>> signal BT.2020 colorimetry to the sink, a YCbCr output would be
>>> encoded with BT.709 and decoded with BT.2020.
>>>
>>> Derive color_space from the connector colorspace before the early
>>> return, so that a colorspace change alone is applied.
>>>
>>> Signed-off-by: Jan Claußen <jan.claussen10@web.de>
>>> ---
>>>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
>>> index 9c4cf68d79d5..10c5b6d6406e 100644
>>> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
>>> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
>>> @@ -17,6 +17,7 @@
>>>  #include <linux/phy/phy.h>
>>>  #include <linux/phy/phy-hdmi.h>
>>>  #include <linux/regmap.h>
>>> +#include <linux/videodev2.h>
>>>  #include <linux/workqueue.h>
>>>  
>>>  #include <drm/bridge/dw_hdmi_qp.h>
>>> @@ -187,6 +188,19 @@ static int dw_hdmi_qp_rockchip_get_vop_format(struct drm_encoder *encoder,
>>>  	return bstate->output_bus_cfg.format;
>>>  }
>>>  
>>> +static u32
>>> +dw_hdmi_qp_rockchip_color_space(const struct drm_connector_state *conn_state)
>>> +{
>>> +	switch (conn_state->colorspace) {
>>> +	case DRM_MODE_COLORIMETRY_BT2020_RGB:
>>> +	case DRM_MODE_COLORIMETRY_BT2020_YCC:
>>> +	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
>>> +		return V4L2_COLORSPACE_BT2020;
>>> +	default:
>>> +		return V4L2_COLORSPACE_DEFAULT;
>>> +	}
>>> +}
>>
>> My main concern is introducing V4L2_COLORSPACE_* logic into a DRM bridge driver,
>> which should rather rely on enum drm_colorspace / DRM_MODE_COLORIMETRY_*.
>> Translating the DRM colorimetry into V4L2 values only for VOP2 to map them back
>> to a CSC matrix doesn't seem fully justified.
>>
>> The root problem is rather on the VOP2 side: the color_space field in struct
>> rockchip_crtc_state and its V4L2-based handling in the CSC selection look like
>> leftovers inherited from the vendor kernel, and I think this is a good time to
>> clean that up instead of building on it.
>>
> 
> Yep. And if you look at the latest vendor kernel code, we have also
> removed the V4L2_COLORSPACE_* related content and switched to DRM.

Thanks for the heads-up; I haven't checked the recent vendor kernel changes.

Regards,
Cristian

