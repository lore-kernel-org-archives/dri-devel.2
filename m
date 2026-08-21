Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347A5C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D77010F30C;
	Fri, 21 Aug 2026 15:30:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZFPXbrY7";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A7DC10F30F
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787326232;
 bh=0SjnZoAiswH2T2RP04K1GTQXFm/D343GdExP27HzYZ0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZFPXbrY7cH7u2m2aO7U5qtI7tjfoSJzfJXiLX1T6K9gqmwpcOJEmCaGdsFOCY16Ak
 sDBsBeZpI+F3ZpqDzMJhxw8e2wIuf/hSXJ0jYkRD9tdHQYjt+jMdYm8BEfULVwOc+L
 sgCa80xWk8NrN1hPa7N2uCpJv2bPLEAdsvl9vzlfyQ0wN27U/tK6sc9HbpIlYRxJO1
 X0WQO1rR261LhDk2Tl6mAd6KujTLr1D7GsS9eefaWcL46xkLxIaAKPb446rtEoMyYq
 b16KIE7u9moyfgcdN78WnKz0l5zSxi0HvA5hm9RtrchSN0Vm5j6ZXkaO2mEu2xs39L
 36M4zE9JhNs9g==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AC72F17E0829;
 Fri, 21 Aug 2026 17:30:31 +0200 (CEST)
Message-ID: <4fc2a3b6-2771-438b-ae99-5574e9c6efc9@collabora.com>
Date: Fri, 21 Aug 2026 18:30:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 67/69] drm/connector: Drop redundant hdmi
 vendor/product fields
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Algea Cao <algea.cao@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Liu Ying <victor.liu@nxp.com>, Phong LE <ple@baylibre.com>,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-67-294364b2cf15@collabora.com>
 <20260820-strange-rich-tiger-78a5a4@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260820-strange-rich-tiger-78a5a4@houat>
Content-Type: text/plain; charset=UTF-8
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

On 8/20/26 1:10 PM, Maxime Ripard wrote:
> On Fri, Jul 31, 2026 at 07:20:14PM +0300, Cristian Ciocaltea wrote:
>> Now that all users migrated to the new drmm_connector_hdmi_init()
>> signature, vendor and product are provided through struct
>> drm_connector_hdmi_funcs, a reference to which is already stored in
>> drm_connector_hdmi.
>>
>> Drop the redundant fields from drm_connector_hdmi and point its users to
>> hdmi.funcs->vendor and hdmi.funcs->product instead.
>>
>> This allows simplifying the related connector registration tests by
>> getting rid of the now unnecessary KUNIT_EXPECT_MEMEQ() checks.
>>
>> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/display/drm_hdmi_state_helper.c |  4 +--
>>  drivers/gpu/drm/drm_connector.c                 |  4 ---
>>  drivers/gpu/drm/tests/drm_connector_test.c      | 41 +++----------------------
>>  include/drm/drm_connector.h                     | 14 ++-------
>>  4 files changed, 8 insertions(+), 55 deletions(-)
>>
[...]

>>  /*
>>   * Test that the registration of a connector with a vendor name at the
>> - * maximum length succeeds, and is stored padded without the trailing
>> - * zero.
>> + * maximum length succeeds.
>>   */
>>  static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
>>  {
>>  	struct drm_connector_init_priv *priv = test->priv;
>> -	const char expected_vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] = {
>> -		'V', 'e', 'n', 'd', 'o', 'r',
>> -		'V', 'e',
>> -	};
>>  	int ret;
>>  
>>  	priv->hdmi_funcs = dummy_hdmi_funcs;
>> @@ -911,10 +882,6 @@ static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
>>  				       DRM_MODE_CONNECTOR_HDMIA,
>>  				       &priv->ddc);
>>  	KUNIT_EXPECT_EQ(test, ret, 0);
>> -	KUNIT_EXPECT_MEMEQ(test,
>> -			   priv->connector.hdmi.vendor,
>> -			   expected_vendor,
>> -			   sizeof(priv->connector.hdmi.vendor));
>>  }
> 
> Unfortunately, these tests were useful, and are there to match what the
> spec asks for.

I've just added a new test to cover this, as well as a couple of prerequisites
to consolidate SPD InfoFrame handling:

* video/hdmi: Define SPD InfoFrame field lengths and use strtomem_pad()

  HDMI specification defines the SPD InfoFrame Vendor Name and Product
  Description as fixed-size fields, 8 and 16 bytes respectively, padded
  with zeros and left without any trailing NUL when a name spans the whole
  field.

  Give those lengths a name and mark the fields as non-strings, so that
  the copies can be handed over to strtomem_pad(), which implements
  precisely the required semantics.  This also bounds the reads from the
  source strings, whereas the open-coded strlen() could run past the end
  of the buffer in the hdmi_spd_infoframe_unpack() path, where the names
  come straight from the wire and are not NUL-terminated.

  While at it, replace the related magic numbers in the pack and unpack
  helpers with the new defines.

* drm/connector: Use the SPD InfoFrame field length defines

  DRM_CONNECTOR_HDMI_{VENDOR,PRODUCT}_LEN used to size the vendor and
  product arrays in struct drm_connector_hdmi.  Those arrays are gone and
  both names are now only validated before being copied into the SPD
  InfoFrame, hence the limits they have to be checked against are the ones
  of the SPD InfoFrame fields themselves.

  Switch the remaining users over to
  HDMI_SPD_INFOFRAME_{VENDOR,PRODUCT}_LEN and drop the DRM specific
  defines, so that the two cannot drift apart.

* drm/tests: hdmi: Add SPD InfoFrame vendor/product coverage

  The vendor and product strings provided through struct
  drm_connector_hdmi_funcs end up in the SPD InfoFrame, whose fields are
  defined by the HDMI specification as fixed-size: 8 bytes for the vendor
  name and 16 bytes for the product description, padded with zeros and
  left without any trailing NUL when a name spans the whole field.

  Nothing exercises that so far, since the SPD InfoFrame is only generated
  for connectors implementing the related hooks, which none of the
  existing test funcs provides.

  Add a connector variant supplying those hooks, along with parametrized
  tests covering both the padded and the exact length cases.

Thanks,
Cristian
