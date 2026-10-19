Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749FBCCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A29010E02D;
	Mon, 19 Oct 2026 09:51:45 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 315AE10E02D
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792403497;
 bh=5oNAwwfQ69cR4mGdxdN7cguLnSFgztnFfpd9LWdweB4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Izl0OhUpiwWX70q+r2yy6nj/mQjXejNqbmpzWetZRnFRSCwdjzJcKbvNuLjDHgswb
 dp6C0fw8P/AMcsaZA+TIMW7kSdf6daGCd7Q0fVe8ubSCvtOhNidzl8KKB1sNIKqiY8
 fEUrsB9W0O44yhx/9siPXPbVduiCLyaQQ2N1/blIvGoLBGtiNbJWTOrsavPmHnSA2M
 B9eqhcQKtuBoBn9GVPVpRvyFeZgaoexV1iZA4VMOMFmVbXK3a+nuy25vPPw0qvrsqM
 mW7LS2D7VcahGvm+y4D9s2WIc83jF+HbwCRyPSacQhPptfhmVXXPnwKZeL1gMTCO/b
 6aPZUtywIGDqw==
Received: from [100.64.0.157] (unknown [100.64.0.157])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9C40117E089A;
 Mon, 19 Oct 2026 11:51:35 +0200 (CEST)
Message-ID: <bb98b4ef-559c-4a7e-a338-ea105810e54f@collabora.com>
Date: Mon, 19 Oct 2026 15:21:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/ci: add sc7180-trogdor-wormdingler-rev1-boe
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 valentine.burley@collabora.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260616115410.325837-1-vignesh.raman@collabora.com>
 <20260616115410.325837-3-vignesh.raman@collabora.com>
 <mxfi2t4qwxb5n3xebdfesq2rwwrimtpav5uwvkchtqfjksl2rt@gr4bjqqyt22y>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <mxfi2t4qwxb5n3xebdfesq2rwwrimtpav5uwvkchtqfjksl2rt@gr4bjqqyt22y>
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

Hi,

On 02/10/26 18:16, Dmitry Baryshkov wrote:
> On Tue, Jun 16, 2026 at 05:24:05PM +0530, Vignesh Raman wrote:
>> Add job that executes the IGT test suite for
>> sc7180-trogdor-wormdingler-rev1-boe.
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> ---
>>
>> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
>> index fdaa26ad79d6..61ac2d043ce3 100644
>> --- a/drivers/gpu/drm/ci/build.sh
>> +++ b/drivers/gpu/drm/ci/build.sh
>> @@ -28,6 +28,7 @@ if [[ "$KERNEL_ARCH" = "arm64" ]]; then
>>       DEVICE_TREES+=" arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dtb"
>>       DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtb"
>>       DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sm8350-hdk.dtb"
>> +    DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb"
> 
> Let's keep it at least minimally sorted, puting wormdingler between
> kingoftown and sm8350

Ack

> 
>>   elif [[ "$KERNEL_ARCH" = "arm" ]]; then
>>       GCC_ARCH="arm-linux-gnueabihf"
>>       DEBIAN_ARCH="armhf"
> 
> [..]
> 
>> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
>> new file mode 100644
>> index 000000000000..4af93eeeaf99
>> --- /dev/null
>> +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
>> @@ -0,0 +1,23 @@
> 
> Most of the entries here are shared with kingoftown / limozeen, except
> for:
> 
>> +kms_invalid_mode@overflow-vrefresh,Fail
> 
> Do you know why it fails? Why does it not on previous devices?

Will check this again.

> 
>> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt
>> new file mode 100644
>> index 000000000000..8d1768de90cc
>> --- /dev/null
>> +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt
> 
> This is mostly a copy of the existing lists, but kingoftown and limozeen
> list .*suspend.* here. If we don't skip them for wormdingler, should we
> unskip them for kingoftown too?

I will unskip for kingoftown and test.

> 
> Also, I see that kingoftown lists several additional tests to be skipped
> (kms_flip@2x-wf_vblank-ts-check, kms_cursor_crc@cursor-random-max-size,
> kms_invalid_mode@overflow-vrefresh). Do you remember why?

These tests caused hang or timeout, so it was added to skip file.

> 
> Overall, I _think_ I have commented beforehand, but I can't find that
> comment (so it might be my delusion or false memory). Is there a way to
> unify the configuration for sc7180 trogdor devices?
> 

Let me check if we can use a unified configuration. I will regenerate 
the expectation files.

Regards,
Vignesh


