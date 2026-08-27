Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD37C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D49910F11F;
	Thu, 27 Aug 2026 17:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pGPiq1LR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3572410F11E;
 Thu, 27 Aug 2026 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:From:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=3umtK014DCeqmIoBuP+Z8Hv05CiBCmR4PkDDRA58fBs=; b=pGPiq1LRwJ+hTTDhdjtmXfb2Hi
 9EE4Oeggs752RRuQ1vH70rBCj0VkewRcYrAuLS81kHQ19sx3tA510zCXRoSyWCNDwmpT5TtRnn2gp
 HPtFavuQjz1vPgrKo4/w+wDeRruUKXjTV6aZbF3lwGxiaDV14p7ogVgSPVg9HPCeHA3G5mStnF4ak
 gu7OBshxuNfyFnazMqF8D06yhvmpVAvowEouh8R/ZwoKrIsZpztph75OubS42vuOB9uygEWvOFFso
 vKOFCVZWXLpaXXP1DFTu4jwqYEnL2w1due/pPcpS8R0Xp+tZQ0IYWNmuiAeA+/u6G9m6E9VLDb9dM
 0ERwMh1Q==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=[192.168.1.206]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wzdgd-00AIAx-SL; Thu, 27 Aug 2026 19:14:47 +0200
Message-ID: <6dda204d-2c12-4442-9893-6449b5ce51c9@igalia.com>
Date: Thu, 27 Aug 2026 19:14:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] drm/atomic-state-helper: fixes for blend-mode-prop
 warning
From: Melissa Wen <mwen@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniels@collabora.com, harry.wentland@amd.com,
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de,
 Alex Hung <alex.hung@amd.com>, Daniel Wheeler <Daniel.Wheeler@amd.com>,
 kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260826104143.39077-1-mwen@igalia.com>
 <CADnq5_MEBLriK_M_atX6FKR5618fiB5DmAWOvxE_e+6nd5FdDg@mail.gmail.com>
 <83bef197-dfbc-44a5-b9d8-6e0c44488793@igalia.com>
Content-Language: en-US
In-Reply-To: <83bef197-dfbc-44a5-b9d8-6e0c44488793@igalia.com>
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



On 27/08/2026 18:37, Melissa Wen wrote:
>
>
> On 27/08/2026 15:34, Alex Deucher wrote:
>> On Wed, Aug 26, 2026 at 7:20 AM Melissa Wen <mwen@igalia.com> wrote:
>>> PREMULTI was the default DRM blend mode until 9813e158d13d
>>> ("drm/drm_blend: allow blend mode property without PREMULTI") 
>>> introduced
>>> the possibility of exposing the blend mode property without PREMULTI
>>> being supported. However, __drm_atomic_helper_plane_state_init() still
>>> resets pixel_blend_mode to PREMULTI (hardcoded), ignoring the supported
>>> mode in this property. In the same series, 860e748bddcc ("drm: ensure
>>> blend mode supported if pixel format with alpha exposed") starts 
>>> warning
>>> drivers that supports alpha formats in a given planes but doesn't
>>> support blend mode property, which includes AMD primary and cursor
>>> planes.
>>>
>>> For AMD DCN families, overlay and primary planes support the three 
>>> blend
>>> modes, and therefore PREMULTI is still the default mode. So the warning
>>> can be fixed by just creating blend mode properties for primary planes
>>> too. PREMULTI is the default/unique mode for cursor planes in DCN and
>>> DCE driver. However, looks like PIXEL_NONE is the unique blend mode
>>> supported by DCE-generation driver. I don't have the hardware to check
>>> it out, but looking at the code I understand that, even if the hardware
>>> can do PREMULTI or COVERAGE, the way it programs registers doesn't make
>>> these other blend modes actually available.
>>>
>>> Bearing this in mind, this series is organized as follow:
>>>
>>> - Patch 1 fixes the pixel_blend_mode reset when the blend mode property
>>>    is advertised without PREMULTI support. It's needed for AMD
>>>    DCE-generation (patch 3) and I think with this we can also remove a
>>>    workaround in nouveau nv50_wndw_default_state() caused by the
>>>    hardcoded PREMULTI default value [1].
>>>
>>> - Patch 2 fixes the missing-blend-mode-property warning for DCN primary
>>>    plane and for DCN+DCE cursor plane. The alpha property keeps only on
>>>    overlay planes because looks like this is not supported by AMD 
>>> primary
>>>    planes and it doesn't affect the blend mode warning we are 
>>> targetting.
>>>    Enabling alpha properties to primary was also causing -EINVAL on IGT
>>>    alpha tests because it started testing primary planes and 
>>> disabling it
>>>    (which is not allowed by the AMD display driver).
>>>
>>> - Patch 3 fixes the warning for DCE primary plane, but I detached this
>>>    solution from the previous patch because I don't have hardware to
>>>    validate if my assumption about PIXEL_NONE-only is correct. Also, I
>>>    added PREMULTI to the list of supported blend mode to avoid uAPI
>>>    regressions since it was the required/default mode for many years 
>>> and,
>>>    without overlay plane, PIXEL_NONE and PREMULTI are equivalent for
>>>    primary on top of a black blackground.
>>>
>> I presume you are planning to apply this directly to drm-misc for 7.3?
>
> Right, I'll apply to drm-misc-fixes, just doing it now.

Or not now. I have to wait for -rc1.
I'll keep it on my radar.

Melissa

>
> Best Regards,
>
> Melissa
>
>>
>> Thanks,
>>
>> Alex
>>
>>> [1] 
>>> https://lore.kernel.org/dri-devel/20260720215058.398210-3-lyude@redhat.com/
>>>
>>> [v1]: 
>>> https://lore.kernel.org/dri-devel/20260722183240.626522-1-mwen@igalia.com/
>>> Changes:
>>> - new patch for pixel_blend_mode default value other than PREMULTI.
>>> - remove DCE11 which supports per_pixel_alpha but doesn't support 
>>> DCN_UNIVERSAL_PLANE.
>>> - new patch for the primary plane blend mode on DCE-generations
>>>
>>> [v2]: 
>>> https://lore.kernel.org/dri-devel/20260804140758.107683-1-mwen@igalia.com/
>>> Changes:
>>> - keep alpha property only for overlay planes (looks like primary plane
>>>    doesn't actually support it) - alpha prop in primary planes 
>>> causes IGT
>>>    test failures with RX 7900 XT on a 4k60 HP U27 as reported by Daniel
>>>    Wheeler.
>>> - improve readability of if conditions (Alex H)
>>> - add Leandro's r-b tags.
>>>
>>> [v3]: 
>>> https://lore.kernel.org/dri-devel/20260813143605.106104-1-mwen@igalia.com/
>>> Changes:
>>> - add Daniel's, Mikhail's and Viktor's tested-by tag, accordingly
>>> - add Alex H r-b tag
>>> - add PREMULTI to the DCE list of supported blend modes to avoid
>>>    uAPI regression reported by Viktor.
>>>
>>> Best Regards,
>>>
>>> Melissa
>>>
>>> Melissa Wen (3):
>>>    drm/atomic-state-helper: set pixel_blend_mode to prop default on 
>>> reset
>>>    drm/amd/display: fix missing blend-mode-prop warning for DCN
>>>    drm/amd/display: advertise PIXEL_NONE and PREMULTI blend mode for 
>>> DCE
>>>
>>>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 31 
>>> +++++++++++++++++--
>>>   drivers/gpu/drm/drm_atomic_state_helper.c     |  7 +++++
>>>   2 files changed, 35 insertions(+), 3 deletions(-)
>>>
>>> -- 
>>> 2.53.0
>>>
>

