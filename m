Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C57BF8E4B4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7534710E982;
	Fri, 17 Apr 2026 07:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="r0E/a2T3";
	dkim-atps=neutral
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBB310E981
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 07:08:53 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=pzBLAWMzasZLljpmq7lbj2ABnUU+Y1nf8FDUPyoPiNA=;
 b=r0E/a2T3VlqKtj5pItApGfhv8ZkQUnvCfSmrN+X9OXPnXWhmE7sKS599EO3f/we3F8ZvPm5LL
 qNYtnd52KIGNGixM115H/KvGxPl6w5KIM3DueYSJ8lLRLgHLnbGPsIRxW/Z4aNHMSohxnXJSZtn
 gUfbqaHA5hoSxJaedZHsGl4=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fxm6H0JM6z1cyQc;
 Fri, 17 Apr 2026 15:02:31 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id BCED74061D;
 Fri, 17 Apr 2026 15:08:49 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Apr 2026 15:08:49 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Apr 2026 15:08:48 +0800
Message-ID: <93568f17-2eeb-47bf-96b6-ccadec00e84c@huawei.com>
Date: Fri, 17 Apr 2026 15:08:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/hibmc: Use drm_atomic_helper_check_plane_state()
To: Thomas Zimmermann <tzimmermann@suse.de>, <tiantao6@hisilicon.com>,
 <kong.kongxinwei@hisilicon.com>, <sumit.semwal@linaro.org>,
 <yongqin.liu@linaro.org>, <jstultz@google.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, Rongrong Zou <zourongrong@gmail.com>,
 Sean Paul <seanpaul@chromium.org>, Dmitry Baryshkov <lumag@kernel.org>,
 <stable@vger.kernel.org>, "Liangjian(Jim,Kunpeng Solution Development Dept)"
 <liangjian010@huawei.com>, Chenjianmin <chenjianmin@huawei.com>, "fengsheng
 (A)" <fengsheng5@huawei.com>, "helin (T)" <helin52@h-partners.com>,
 <shiyongbang@huawei.com>
References: <20260413085037.17491-1-tzimmermann@suse.de>
 <20260413085037.17491-2-tzimmermann@suse.de>
 <7fd5022a-9a5d-4976-9d4a-1e0fa2022eae@huawei.com>
 <1805a7d4-a4a0-48ee-ac6e-33e5d9d5fdc9@suse.de>
 <fffc172f-6bfe-4947-8f3b-52a1534b1d3b@huawei.com>
 <34ecfa0c-a6f5-48b0-b706-27e1f9868dd7@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <34ecfa0c-a6f5-48b0-b706-27e1f9868dd7@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq100007.china.huawei.com (7.202.195.175)
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


> Hi
> 
> Am 16.04.26 um 15:22 schrieb Yongbang Shi:
> [...]
>> However, I believe the modified version is the better implementation,
>> the plane check should be complete even if the CRTC is not enabled.
> 
> Great.
> 
> I agree that the logic in the helper is non-intuitive. I'll send you an
> updated series with an improved commit message next week.
> 

Looking forward to the updated series next week, and I appreciate the
improved commit message as well.

Thanks,
Yongbang.

> Best regards
> Thomas
> 
>>
>> [1]
>> https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>> hisilicon/hibmc/hibmc_drm_de.c#L84
>> [2]
>> https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>> hisilicon/hibmc/hibmc_drm_de.c#L94
>>
>>
>>>
>>>>
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +    else if (!new_plane_state->visible)
>>>>>            return 0;
>>>>>    -    if (new_plane_state->crtc_x + new_plane_state->crtc_w >
>>>>> -        crtc_state->adjusted_mode.hdisplay ||
>>>>> -        new_plane_state->crtc_y + new_plane_state->crtc_h >
>>>>> -        crtc_state->adjusted_mode.vdisplay) {
>>>>> -        drm_dbg_atomic(plane->dev, "visible portion of plane is
>>>>> invalid\n");
>>>>> -        return -EINVAL;
>>>>> -    }
>>>>> -
>>>> The purpose of this check is to ensure that the right and bottom
>>>> boundaries of the plane do not extend beyond the crtc. In
>>>> `drm_atomic_helper_check_plane_state`, `drm_mode_get_hv_timing` is
>>>> called to retrieve the crtc boundaries, and `drm_rect_clip_scaled` is
>>>> used to clip the plane, any portions extending beyond the right and
>>>> bottom boundaries are discarded.
>>>>
>>>> I'd like to confirm that my understanding is correct? previously, the
>>>> check failed if the plane exceeded the boundaries, but now, after
>>>> `drm_atomic_helper_check_plane_state` is called, the plane is
>>>> clipped to
>>>> fit within the boundaries.
>>> Yes. This sets plane_state->dst, which is clipped to the size of the
>>> display mode. But it also tests that the primary plane covers the whole
>>> display.
>>>
>>>> in function drm_rect_clip_scaled:
>>>>
>>>> diff = dst->x2 - clip->x2;
>>>> if (diff > 0) {
>>>>      ...
>>>>      dst->x2 -= diff;
>>>> }
>>>> diff = dst->y2 - clip->y2;
>>>> if (diff > 0) {
>>>>      ...
>>>>      dst->y2 -= diff;
>>>> }
>>> I agree, the logic in drm_atomic_helper_check_plane_state() is hard to
>>> understand. It sets the clip rectangle to the size of the display mode
>>> (or zero if the CRTC is off) at [1].  Then is clips the source and
>>> destination coordinates against the clipping rectangle at [2].
>>>
>>> Because we set can_position to false, it tests if the destination and
>>> clipping rectangles are equal at [3]. This is similar to the that is
>>> being replaced, but with plane state correctly adjusted. If both
>>> rectangles are equal, it returns success. If the destination is too
>>> small, it fails with an errno code and a warning.
>>>
>>> If the plane is not visible, the helper already returned at [4].
>>>
>>> [1] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>>> drm_atomic_helper.c#L943
>>> [2] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>>> drm_atomic_helper.c#L945
>>> [3] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>>> drm_atomic_helper.c#L959
>>> [4] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>>> drm_atomic_helper.c#L949
>>>
>>> It is now possible to have a primary plane that is larger than the
>>> display mode. This is a feature of the DRM API.
>>>
>> Thank you so much for the explanation. It's much clearer to understand
>> drm_atomic_helper_check_plane_state.
>>
>> By the way, we ran some basic tests on this set of patches using the
>> latest BMC chip, and everything worked fine.
>>
>>
>> Thanks.
>>
>> Best regards
>> Yongbang.
>>
>>
>>> Best regards
>>> Thomas
>>>
>>>
>>>>
>>>> Thanks.
>>>>
>>>> Best regards
>>>> Yongbang.
>>>>
>>>>
>>>>>        if (new_plane_state->fb->pitches[0] % 128 != 0) {
>>>>>            drm_dbg_atomic(plane->dev, "wrong stride with 128-byte
>>>>> aligned\n");
>>>>>            return -EINVAL;
>>>>>        }
>>>>> +
>>>>>        return 0;
>>>>>    }
>>>>>    
>> Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>
>>
>>
> 

