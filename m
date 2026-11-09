Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84331606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=WxKrjVq5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2FA10F232;
	Mon,  9 Nov 2026 12:18:28 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C64D410F219
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794226701;
 bh=A9c8wLk68pTshZQz/4EWbcWbZwqzl037mBD3rbXZZpg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WxKrjVq5KYnun6DyV+jsyo2vBe/kngIrZyr83nVUeDPwVNYAu2E6PKVi+jkytPvNM
 aOqzGmw85JvBGfoZWUXn7RNH17+L/9vRNaMXtBA7gw+HCXUkQOsFbqr1NeqttdpuDY
 sBB3DuMCFrA6yUm5OJ2IPqIyzukeiEQOYkWC6I9OlpbbNeOZhZbkDJLiczKlnA95kN
 FDxmzaKW2SQ1c/n/r6FUF5iF0A8yhJzc1HBzlH2nMhIYZLR9839XAZzWekEouwX+bU
 7ymL3dfbVhRCYESLkyg5q7xlF4b1ygCTg/FmvWtiU3+UeyMPS1rDg23AgPeWEy2MTw
 FMnySmbmQIf6A==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9214217E0564;
 Mon, 09 Nov 2026 13:18:20 +0100 (CET)
Message-ID: <280e4024-f1b1-47d0-980c-4d6f067e33d4@collabora.com>
Date: Mon, 9 Nov 2026 14:18:19 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com>
 <20261014-vc4-common-scramb-v3-6-c68d58d959a2@collabora.com>
 <45ea1610-360f-4f6b-9ea6-30b28fbe8514@igalia.com>
 <8b1b7d8d-9656-4b3b-9f83-1526c8110ab7@collabora.com>
 <b60a42bb-b48b-434a-a306-3ac9189027a5@collabora.com>
 <e532cc6a-21d0-4021-9854-08963331223e@igalia.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <e532cc6a-21d0-4021-9854-08963331223e@igalia.com>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maíra,

On 11/9/26 1:53 PM, Maíra Canal wrote:
> Hi Cristian,
> 
> On 04/11/26 17:08, Cristian Ciocaltea wrote:
>> On 10/28/26 11:44 PM, Cristian Ciocaltea wrote:
>>> Hi Maíra,
>>>
>>> On 10/27/26 3:35 PM, Maíra Canal wrote:
>>>> Hi Cristian,
>>>>
>>>> On 13/10/26 22:03, Cristian Ciocaltea wrote:
>>>>> Replace driver local scrambling logic with the newly introduced common
>>>>> HDMI 2.0 scrambling support:
>>>>>
>>>>> - Advertise source-side scrambling capability by setting supported HDMI
>>>>>     version based on the variant's max_pixel_clock.
>>>>>
>>>>> - Provide minimal .scrambler_{enable,disable} connector callbacks that
>>>>>     only toggle the VC5 HDMI_SCRAMBLER_CTL register, while delegating
>>>>>     sink-side SCDC programming and periodic status monitoring to
>>>>>     drm_connector_hdmi_{enable,disable}_scrambling().
>>>>>
>>>>> - Drop vc4_hdmi_reset_link() and vc4_hdmi_handle_hotplug(), switching
>>>>>     the .detect_ctx() path to drm_atomic_helper_connector_hdmi_hotplug()
>>>>>     which internally calls drm_connector_hdmi_sync_scdc() to trigger a
>>>>>     CRTC reset on reconnection.
>>>>>
>>>>> - Drop the local scrambling_work delayed workqueue and scdc_enabled
>>>>>     flag, now tracked by the common drm_connector_hdmi layer, as well as
>>>>>     the now unused output_{bpc,color_format} driver data members.
>>
>> [...]
>>
>>> I'm going to test both fixes and send them out as a separate series, so we're
>>> not blocking on it.
>>
>> I submitted the fixes earlier today:
>>
>> https://lore.kernel.org/all/20261104-hdmi-scdc-scramb-fixes-v1-0-16a9bb3d64a6@collabora.com/
>>
>> I'm waiting for Lucas' scrambling patches to land in drm-misc-next so that I can
>> rebase this series and send v4.
>>
> 
> I believe Lucas' patches landed today in drm-misc-next.

Indeed, they weren't there when I checked earlier today, so thanks for the quick
notice.  I'll prepare the next revision.

Kind regards,
Cristian
