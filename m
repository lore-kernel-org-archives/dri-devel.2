Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE3AC982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899CC10EC03;
	Tue, 22 Sep 2026 08:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="U9YFm5sV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E7F110EBFF
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790067314; x=1821603314;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=/R7/zPpAu251V6P/E/Xj+nW9E/NOV7769IvAMnd4OJA=;
 b=U9YFm5sVfqER/UMKySjOVQON6PiSILGd2qKF2yIKhrd3rJu6GJ1tUjvf
 5s3XjntLt9YkyorDFJOc8lnj/LmAUZfkufhRsw1aAVsu2teJkfWyO7WUk
 QC8Bq6dRV3m7+dYrkgcZ4MI9QAmZl3otMiQQoGv2ygEXaeUsdi1YZqmHY
 QlZgSr8ZBj+BwTQ+vjbw63DqU0v1C/o/KCcjVGbCsjLoqhFHvRD/z2PPI
 HBCkXH1lPr3z7WHYE93GFB1nzfR1b9BYAjxkfK2V/TOT64hzfOXKH8fmW
 jJ3/Th7IyoTCefrbHhMPT/XRwaDcR0soI8pKCg7G9kc5xdCISWOmWxD7m w==;
X-CSE-ConnectionGUID: H9hCfZVAQ2qpKO7UE176hQ==
X-CSE-MsgGUID: oEdWlQmsS3CpTKiyAN+dnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89785756"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="89785756"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 01:55:12 -0700
X-CSE-ConnectionGUID: lkLVqdwoRN2PE2VUDbdFPw==
X-CSE-MsgGUID: bmsVI9FnTiiuUXt6Hwc2ug==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.71])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 01:55:07 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: vishnu.saini@oss.qualcomm.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Ravi Agola <raviagol@qti.qualcomm.com>, Vishnu Saini
 <vishnu.saini@oss.qualcomm.com>
Subject: Re: [PATCH v4] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
In-Reply-To: <20260922-lt9611usc_edid34_misc_next-v4-1-47d5315821fe@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260922-lt9611usc_edid34_misc_next-v4-1-47d5315821fe@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 11:55:01 +0300
Message-ID: <96be97088cc0d436414f0f9552fa7442312ac719@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 22 Sep 2026, vishnu.saini@oss.qualcomm.com wrote:
> From: Ravi Agola <raviagol@qti.qualcomm.com>
>
> The LT9611UXC bridge can fetch only 2 EDID blocks at a time, which
> previously limited EDID reading to 2 blocks and prevented support
> for displays exposing more than 2 EDID blocks.
>
> Add driver support to fetch up to 4 EDID blocks by re-triggering
> EDID access after the first 2 blocks are read. For block 0 and 2,
> set the EDID ready flag in 0xb028 so the bridge can expose the
> corresponding EDID blocks, then retry the read until the expected
> EDID is fetched.
>
> Reset the edid_read flag on HPD disconnect so that the next
> connect event triggers a fresh EDID fetch.
>
> Increase EDID wait time from 500ms to 1000ms, On Qualcomm rb3gen2
> platform sometimes edid read interrupt is coming 600-650 ms after
> HPD interrupt resulting in edid read failure.
>
> Signed-off-by: Ravi Agola <raviagol@qti.qualcomm.com>
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> ---
> Changes in v4:
> - Rebased onto latest drm-misc-next.
> - No functional changes; replied inline to the two Sashiko-bot
>   review comments on v3
> - Link to v3: https://lore.kernel.org/r/20260722-lt9611usc_edid34_misc_next-v3-1-7ec2bba6ff8e@oss.qualcomm.com
>
> Changes in v3:
> - moved edid_read state change inside mutex lock     [sashiko-bot]
> - returned -ETIMEOUT when retry_cnt is exhausted without a match.    [Sashiko-bot]
> - Increased edid wait timeout from 500ms to 1000ms as edid interrupt is sometimes taking around 650ms time
> - Link to v2: https://lore.kernel.org/r/20260624-lt9611usc_edid34_misc_next-v2-1-24ce3f5770b8@oss.qualcomm.com
>
> Changes in v2:
> - Removed memcpy and doing edid fetch everytime. Required an update in firmware as well for edid block0 reset.
> - Verified patch with existing firmware V5.0.21, patch is not causing any regression if V5.0.21 firmware is used.
> - Firmware V5.0.22 is required with this patch to support edid fetch on more than 2 edid block monitors.
> - Link to v1: https://lore.kernel.org/r/20260517-lt9611usc_edid34_misc_next-v1-1-5e2fd8c6399b@oss.qualcomm.com
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 80 +++++++++++++++++++++++++-----
>  1 file changed, 68 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index b3bb7f2cebb3..a74077a65f62 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -28,7 +28,7 @@
>  #include <drm/display/drm_hdmi_audio_helper.h>
>  
>  #define EDID_BLOCK_SIZE	128
> -#define EDID_NUM_BLOCKS	2
> +#define EDID_NUM_BLOCKS	4
>  
>  #define FW_FILE "lt9611uxc_fw.bin"
>  
> @@ -167,6 +167,8 @@ static void lt9611uxc_hpd_work(struct work_struct *work)
>  
>  	mutex_lock(&lt9611uxc->ocm_lock);
>  	connected = lt9611uxc->hdmi_connected;
> +	if (!connected)
> +		lt9611uxc->edid_read = false;
>  	mutex_unlock(&lt9611uxc->ocm_lock);
>  
>  	drm_bridge_hpd_notify(&lt9611uxc->bridge,
> @@ -380,13 +382,39 @@ lt9611uxc_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connect
>  static int lt9611uxc_wait_for_edid(struct lt9611uxc *lt9611uxc)
>  {
>  	return wait_event_interruptible_timeout(lt9611uxc->wq, lt9611uxc->edid_read,
> -			msecs_to_jiffies(500));
> +			msecs_to_jiffies(1000));
> +}
> +
> +static int lt9611uxc_read_edid_block(struct lt9611uxc *lt9611uxc, unsigned int block,
> +				     u8 *buf,  size_t len)
> +{
> +	int ret;
> +
> +	lt9611uxc_lock(lt9611uxc);
> +
> +	regmap_write(lt9611uxc->regmap, 0xb00a, (block % 2) * EDID_BLOCK_SIZE);
> +
> +	ret = regmap_noinc_read(lt9611uxc->regmap, 0xb0b0, buf, len);
> +	if (ret) {
> +		dev_err(lt9611uxc->dev, "edid block %d read failed: %d\n", block, ret);
> +		lt9611uxc_unlock(lt9611uxc);
> +		return -EINVAL;
> +	}
> +	lt9611uxc_unlock(lt9611uxc);
> +
> +	return ret;
>  }
>  
>  static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, size_t len)
>  {
>  	struct lt9611uxc *lt9611uxc = data;
> -	int ret;
> +	int ret = 0;
> +	int retry_cnt = 10;
> +	unsigned int edid_ready_flag = 0;
> +	bool header_matched;
> +	bool edid_valid = false;
> +	const u8 edid_header[8] = { 0x00, 0xFF, 0xFF, 0xFF,
> +				    0xFF, 0xFF, 0xFF, 0x00 };
>  
>  	if (len > EDID_BLOCK_SIZE)
>  		return -EINVAL;
> @@ -394,20 +422,48 @@ static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, siz
>  	if (block >= EDID_NUM_BLOCKS)
>  		return -EINVAL;
>  
> -	lt9611uxc_lock(lt9611uxc);
> +	if (block == 0 || block == 2) {
>  
> -	regmap_write(lt9611uxc->regmap, 0xb00b, 0x10);
> +		lt9611uxc_lock(lt9611uxc);
>  
> -	regmap_write(lt9611uxc->regmap, 0xb00a, block * EDID_BLOCK_SIZE);
> +		edid_ready_flag = (block == 0) ? BIT(0) : BIT(1);
>  
> -	ret = regmap_noinc_read(lt9611uxc->regmap, 0xb0b0, buf, len);
> -	if (ret)
> -		dev_err(lt9611uxc->dev, "edid read failed: %d\n", ret);
> +		/*
> +		 * Set the EDID ready flag so that lt9611uxc can fetch correct EDID block
> +		 */
> +		regmap_write(lt9611uxc->regmap, 0xb028, edid_ready_flag);
>  
> -	lt9611uxc_unlock(lt9611uxc);
> +		lt9611uxc_unlock(lt9611uxc);
>  
> -	return 0;
> -};
> +		do {
> +			msleep(100);
> +			ret = lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
> +			if (ret)
> +				break;
> +			/*
> +			 * Compare first 8 bytes of EDID header for block 0 and block 2
> +			 * to confirm EDID read successfully
> +			 */
> +			header_matched = (memcmp(edid_header, buf, 8) == 0);
> +			edid_valid = (block == 0 && header_matched) ||
> +				     (block == 2 && !header_matched);
> +			if (edid_valid)
> +				break;
> +
> +		} while (retry_cnt-- > 0);

What's the purpose of the above dance? Why do you have to try ten times,
and what's with the header matching? None of this is explained in the
commit message.

BR,
Jani.


> +
> +		if (!ret && !edid_valid)
> +			ret = -ETIMEDOUT;
> +	} else {
> +		ret = lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
> +
> +		lt9611uxc_lock(lt9611uxc);
> +		regmap_write(lt9611uxc->regmap, 0xb028, 0x00);
> +		lt9611uxc_unlock(lt9611uxc);
> +	}
> +
> +	return ret;
> +}
>  
>  static const struct drm_edid *lt9611uxc_bridge_edid_read(struct drm_bridge *bridge,
>  							 struct drm_connector *connector)
>
> ---
> base-commit: 8ef59ee794076e2b58cff357b12de2ba5d441271
> change-id: 20260517-lt9611usc_edid34_misc_next-b02592de0b25
>
> Best regards,

-- 
Jani Nikula, Intel
