Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E647C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED1F10E65B;
	Thu, 30 Jul 2026 13:44:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="GpyZ4nvn";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id DE77810E183
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:43:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6109B1684;
 Thu, 30 Jul 2026 06:43:54 -0700 (PDT)
Received: from [10.57.0.74] (unknown [10.57.0.74])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 962F73F7B4;
 Thu, 30 Jul 2026 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785419038; bh=lL1JdVfovDObN1ibqr7cKXSnahnEUTJXEDC56kn6H+8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GpyZ4nvnxS+jvmDKeX3q1sDKx8ceNL+Sazdl9FH3Hnojl/f1c318UTYpb9B8fZY+l
 u5Z4y38I8N9iY/B9pJ2AmxhMdlE8mhiQfQ5IzI9nHCTmhLlLqBLXXbDzSkxuwGYOtU
 Ep4HgjP3Fo7F7zVvTWQXHBBzuRIWmFNlsHn4bA/8=
Message-ID: <b0dd62c2-b15c-46a1-88b3-33c2cecf4448@arm.com>
Date: Thu, 30 Jul 2026 14:43:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/komeda: Initialize encoder possible_clones
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, james.qian.wang@arm.com,
 vincenzo.frascino@arm.com, nayden.kanchev@arm.com, charvi.mehta@arm.com,
 Asad Malik <asad.malik@arm.com>
References: <20260721135227.439413-1-raveendra.talabattula@arm.com>
 <20260721135227.439413-3-raveendra.talabattula@arm.com>
 <ami6kzBg7zGi4WLs@e142607>
Content-Language: en-US
From: Raveendra Talabattula <raveendra.talabattula@arm.com>
In-Reply-To: <ami6kzBg7zGi4WLs@e142607>
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

Hi Liviu,

Thanks for your review.

On 7/28/26 15:20, Liviu Dudau wrote:
> On Tue, Jul 21, 2026 at 02:52:27PM +0100, Raveendra Talabattula wrote:
>> Komeda leaves encoder->possible_clones unset, so it stays at 0 for every
>> encoder. When userspace asks for writeback, the DRM atomic checks
> 
> Can you tell me more about this? What are you trying to do with the writeback?

We are trying to use the Komeda writeback connector to capture the composed
CRTC output while the same CRTC is also driving the display connector.

In this configuration, both the display encoder and the writeback encoder 
are included in the CRTC encoder mask. The atomic validation then reports:

crtc96 failed valid clone check for mask 0x5

The intention is only to support the display and writeback outputs concurrently.

> 
> Please note that there is a patch series that changes the way encoders get
> created for the writeback connectors, so that can potentially affect your
> use case.
> 

Could you please point me to the patch series you are referring to?
I would like to check whether it changes how the Komeda writeback encoder
should be created or how its possible_clones mask should be initialized

>> reject the configuration because no encoder is marked as clone-compatible,
>> leading to errors such as:
>>
>> 	crtc96 failed valid clone check for mask 0x5
> 
> The error you're seeing here is due to the encoder having a non-zero "possible_clones"
> which shows there is an error in your setup earlier and nothing to do with komeda.
> 

Understood. I identified that the failure is exposed by the following upstream commit:

41b4b11da021 ("drm: Add valid clones check")

This commit added validation of the clone masks for all encoders attached to a CRTC.
Therefore, the commit is exposing an issue in the earlier encoder setup rather than
introducing a Komeda-specific failure.

I will investigate where the display and writeback encoder clone relationship
should be configured correctly. 

>>
>> Komeda does not impose per-encoder clone restrictions, [...]
> 
> Komeda doesn't care about the encoders at all as it is meant to be agnostic
> to whatever encoder is used.
> 
>> [...] so initialize
>> possible_clones for all registered encoders to the full encoder mask
>> after encoder creation. This fixes writeback validation.
>>
>> Signed-off-by: Asad Malik <asad.malik@arm.com>
>> Signed-off-by: Raveendra Talabattula <raveendra.talabattula@arm.com>
>> ---
>>  .../gpu/drm/arm/display/komeda/komeda_kms.c   | 20 +++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
>> index 6ed504099188..0dcc8c05e86b 100644
>> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
>> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
>> @@ -276,7 +276,10 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
>>  {
>>  	struct komeda_kms_dev *kms;
>>  	struct drm_device *drm;
>> +	struct drm_encoder *encoder;
>>  	int err;
>> +	/* Bitmap of all encoders, assigned to each encoder's possible_clones. */
>> +	u32 clone_mask = 0;
>>  
>>  	kms = devm_drm_dev_alloc(mdev->dev, &komeda_kms_driver,
>>  				 struct komeda_kms_dev, base);
>> @@ -311,6 +314,23 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
>>  
>>  	drm_mode_config_reset(drm);
>>  
>> +	/*
>> +	 * Build the full possible_clones mask once. drm_encoder_index()
>> +	 * returns the bit position assigned to each encoder and BIT() converts
>> +	 * that index into the corresponding mask value.
>> +	 *
>> +	 * Komeda does not have per-encoder clone restrictions, so every encoder
>> +	 * gets the same mask and is advertised as clone-compatible with all
>> +	 * other registered encoders.
>> +	 */
>> +	drm_for_each_encoder(encoder, drm) {
>> +		clone_mask |= BIT(drm_encoder_index(encoder));
>> +	}
>> +
>> +	drm_for_each_encoder(encoder, drm) {
>> +		encoder->possible_clones = clone_mask;
>> +	}
> 
> You're modifying all the encoders in the system here which is not the right thing.
> 

I understand the concern. My intention was to follow the approach used by:

2e012e76ad59 ("drm: mali-dp: Set encoder possible_clones")

The code only updates encoders registered with this DRM device. 
Since Komeda does not impose any per-encoder clone restrictions, 
the full encoder mask represents the intended capability and
allows the display and writeback encoders to be used concurrently.

Please let me know if there is a specific encoder in this setup 
that should not be marked as clone-compatible.

> Best regards,
> Liviu
> 
>> +
>>  	err = devm_request_irq(drm->dev, mdev->irq,
>>  			       komeda_kms_irq_handler, IRQF_SHARED,
>>  			       drm->driver->name, drm);
>> -- 
>> 2.43.0
>>
> 

Thanks,
Raveendra
