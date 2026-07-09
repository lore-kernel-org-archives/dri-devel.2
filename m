Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33027C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ECC510E680;
	Thu,  9 Jul 2026 06:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HE50AB6T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C2310E680
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:21:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A3A8600C3;
 Thu,  9 Jul 2026 06:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0951F000E9;
 Thu,  9 Jul 2026 06:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783578083;
 bh=avnLObW5dxVopVTUHmZJmNzAyLLSH95SmjofjaiSK/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HE50AB6T6u8vIVbIcCz6uZe8Kj3T1R1zz8vsHh11DaO/+G75qD99OSEHjxbwRnon6
 77VNDQDXMACMZydcRTx4NGDbjjU6OpoalrqW2ZFiW7vtb7jmazsxcfPTzv1Gr/pPwB
 0BdHltp8Hm0im/kYSM/tIZrcc4c35KyH+DOwx1dH9vzohc2yZUp5WfbX4Flmgd7oi6
 eyVvo/7wAVeX9Qy+CFYKBt+X8Reh0XPm3mGVzEUIHdLxq8MwksQpHMqVT0d5VAG5jB
 QyS3NXDeoLzb+y/cUAbhNX2AFcxuAA3ejWNN3dx94ugUtdGPcb9cCinT9jLA7A6QgJ
 Ti1eRvYeQMTAw==
Date: Thu, 9 Jul 2026 08:21:15 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kishore Batta <kishore.batta@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
Subject: Re: [PATCH v6 5/7] bus: mhi: Load DDR training data using device
 serial number
Message-ID: <ysumvduurfx5jq7r2eaa4ik24eqk5at24frvjl3zyif4wc4ojj@2bhq4vzuqlnw>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-5-3a78362c4741@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701-sahara_protocol_new_v2-v6-5-3a78362c4741@oss.qualcomm.com>
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

On Wed, Jul 01, 2026 at 04:07:39PM +0530, Kishore Batta wrote:
> Devices may provide device specific DDR training data that can be reused
> across boot to avoid retraining and reduce boot time. The Sahara driver
> currently always falls back to the default DDR training image, even when
> serial specific training data is available.
> 
> Extend the firmware loading logic for the DDR training image to first
> attempt loading a per-device image dervied from the device serial number.
> If the serial-specific image is not present, fall back to the existing
> default image, preserving current behavior.
> 
> This allows reuse of previously generated DDR training data when available,
> while keeping the existing training flow unchanged for devices without
> saved data or for all other firmware images.
> 
> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> ---
>  drivers/bus/mhi/host/clients/sahara/sahara.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
> index 9adbd84859073d8024ba2a5fcfa33897439d6759..b5ca6353540dc3815db6539e7424afdb749fd3f6 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> @@ -59,6 +59,7 @@
>  #define SAHARA_RESET_LENGTH		0x8
>  #define SAHARA_MEM_DEBUG64_LENGTH	0x18
>  #define SAHARA_MEM_READ64_LENGTH	0x18
> +#define SAHARA_DDR_TRAINING_IMG_ID	34
>  
>  struct sahara_packet {
>  	__le32 cmd;
> @@ -226,6 +227,27 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
>  		return 0;
>  	}
>  
> +	/* DDR training special case: Try per-serial number file first */
> +	if (image_id == SAHARA_DDR_TRAINING_IMG_ID && context->fw_folder) {
> +		u32 serial_num = context->mhi_dev->mhi_cntrl->serial_number;
> +
> +		fw_path = kasprintf(GFP_KERNEL,
> +				    "qcom/%s/mdmddr_0x%x.mbn",
> +				    context->fw_folder, serial_num);
> +		if (!fw_path)
> +			return -ENOMEM;
> +
> +		ret = firmware_request_nowarn(&context->firmware,
> +					      fw_path,
> +					      &context->mhi_dev->dev);
> +		kfree(fw_path);
> +
> +		if (!ret) {
> +			context->active_image_id = image_id;
> +			return 0;
> +		}
> +	}
> +
>  	/*
>  	 * This image might be optional. The device may continue without it.
>  	 * Only the device knows. Suppress error messages that could suggest an
> @@ -235,7 +257,8 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
>  				      context->image_table[image_id],
>  				      &context->mhi_dev->dev);
>  	if (ret) {
> -		dev_dbg(&context->mhi_dev->dev, "request for image id %d / file %s failed %d\n",
> +		dev_dbg(&context->mhi_dev->dev,
> +			"request for image id %d / file %s failed %d\n",

Spurious change.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
