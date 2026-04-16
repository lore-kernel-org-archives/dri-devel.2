Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C557BF8A176
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 13:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2660C10E8A9;
	Thu, 16 Apr 2026 13:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="S+wQZwaW";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF6610E1E9;
 Thu, 16 Apr 2026 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hq9qivWqDj5QmC/f7R7c8KgV7i+BCyYriYjNY6bYV4M=; b=S+wQZwaWys1gy8P7a+cL2tOK1L
 2gUQ7qvkr3XwfvSHvJDzmQ2minckq+4qHsZPxiNTOdW+omQBlS0pULfII6BW7c5aVtu7zvG4GVSuf
 fR+H5XK7uxaToMYPdnUGyRipdScQmBgKKU8S60dJy+G/A5zgASP2mZQF9es9XXp/BMelHwZvpqhpW
 ad2ar/qLXl7yl/gl1TTlT8IqJVGY0dE/BFfwdzHt/SZcjjwvxaKbH13fs49Vr4yxS7aDtlHUMh2CO
 kWf5aN8pc6KHA58I9746p2VXXf2bdcqO/X2fKLVTsyyAtpmSJZzicPouY9VdhSeMBlx04FmvnClHb
 rAx8ijsA==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wDMmJ-00H02p-SU; Thu, 16 Apr 2026 15:29:08 +0200
Message-ID: <278b236a-ae47-4413-8dcd-dde4a582430b@igalia.com>
Date: Thu, 16 Apr 2026 10:28:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] drm/amd/display: more drm_edid to AMD display
 driver (partial)
To: Leo Li <sunpeng.li@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, airlied@gmail.com, alexander.deucher@amd.com,
 alex.hung@amd.com, andrzej.hajda@intel.com, christian.koenig@amd.com,
 harry.wentland@amd.com, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mario.limonciello@amd.com, mripard@kernel.org, neil.armstrong@linaro.org,
 rfoss@kernel.org, simona@ffwll.ch, siqueira@igalia.com, tzimmermann@suse.de
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Michel Daenzer <michel.daenzer@mailbox.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260225121903.236115-1-mwen@igalia.com>
 <3856874.aCxCBeP46V@timur-hyperion>
 <3d928ea8-dee9-40cc-9fcc-af063b67138a@amd.com>
 <be7debbf-727e-4017-906a-36ee81fd844e@igalia.com>
 <67d07c60-a535-42c7-a6fe-79f9dd90c9b4@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <67d07c60-a535-42c7-a6fe-79f9dd90c9b4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 14/04/2026 20:17, Leo Li wrote:
>
> On 2026-04-13 13:51, Melissa Wen wrote:
>>
>> On 31/03/2026 12:45, Leo Li wrote:
>>> On 2026-02-27 03:52, Timur Kristóf wrote:
>>>> On Wednesday, February 25, 2026 1:04:29 PM Central European Standard Time
>>>> Melissa Wen wrote:
>>>>> Hi,
>>>>>
>>>>> This is a reduced version of `drm/amd/display: more drm_edid to AMD
>>>>> display driver` [1] sent a few months ago only with the less invasive
>>>>> changes, i.e., those changes that don't affect DC. This partial focus on
>>>>> using more drm_edid helpers instead of raw EDID helpers. Most patches
>>>>> here are already reviewed by someone and I think they can be merged
>>>>> without major concerns. They can also prevent new initiatives of keeping
>>>>> parsing raw EDID as driver specific code, which can make harder for us
>>>>> to remove `drm_edid_raw()`. They should focus on moving raw EDID
>>>>> handling to the DRM common code instead.
>>>>>
>>>>> Regarding code changes from previous version, here I added some r-b tags
>>>>> (from Mario and Timur), fixed commit message syntax (Mario) and
>>>>> centralized error handling (Timur). I'll follow up the changes in DC to
>>>>> accept the Linux/DRM opaque object in a separate series since those look
>>>>> more sensitive.
>>>>>
>>>>> [1] https://lore.kernel.org/amd-gfx/20251106165536.161662-1-mwen@igalia.com/
>>>>>
>>>>> BR,
>>>>>
>>>>> Melissa
>>>>>
>>>> Nice work, Melissa.
>>>>
>>>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>>> For this series.
>>> Thanks for your patience Melissa, series is also
>>> Reviewed-by: Leo Li <sunpeng.li@amd.com>
>>>
>>> We'll include it in this week's testing.
>> Hi Leo,
>>
>> In the end, was this series applied to AMD's branch or do I need to rebase it?
>>
>> Melissa
> Hi Melissa,
>
> During testing, it seems we're failing drm_edid_valid() in this callpath:
>
>      dm_helpers_read_local_edid > dm_helpers_parse_edid_caps > drm_edid_valid.
>
> I'm 90% sure it's because recreating the drm_edid from dc_edid ignores the
> HF-EEODB (HDMI Forum EDID Extension Override Data Block), which can override the
> number of extensions dictated by the base EDID. However, drm_edid_valid() does
> consider the HF-EEODB, causing this line(*) to return false. Commenting it out
> "fixes" the issue
>
> (*)https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/drm_edid.c#L2076
>
> This whole drm_edid to dc_edid conversion in dm_helpers_read_local_edid(), then
> immediately back to drm_edid in parse_edid_caps(), is really not nice... We lose
> the HF-EEODB-aware size by creating dc_edid based on the EDID-advertised
> extension count. It should work if drm_edid is simply passed straight through.
Hi Leo,

Thanks for testing and debugging the issue.
Can you share a reproducer, IGT test or setup to trigger this failure?
Anyway, I'll try to come up with another approach for this...

Also, I'm confident that we can avoid these ugly conversions with my 
second half migration series [1] plus the series to move AMD VSDB 
parsing in drm_edid [2].

[1] https://lore.kernel.org/amd-gfx/20251106165536.161662-1-mwen@igalia.com/
[2] 
https://lore.kernel.org/dri-devel/20260327082342.1286878-1-chen-yu.chen@amd.com/

BR,

Melissa
>
> The challenge is dm_helpers* are DC's interface back to DM, and there is another
> OS that depends on it. Plumbing drm_edid through DC would be quite challenging.
>
> Alternatively, It should work if we carry over the drm_edid.size value to
> dc_edid.length. Do you know the motivation behind keeping drm_edid->size
> private? Would it be a good idea to implement a drm_edid_get_size()?
>
> Thanks,
> Leo
>
>>> - Leo

