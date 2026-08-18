Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A3EC5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF06E10E00F;
	Tue, 18 Aug 2026 10:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jwja8jcl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4796D10E00F;
 Tue, 18 Aug 2026 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=uO/nAH6WXiGHz4KEvvjqTPxJpxO7ml5cqr41kxbTfG8=; b=jwja8jcl4hSH2EoViAkbWiQ2nY
 TavYJdKNyYNt6Vkkb77dHre2LcYIIhzX+HNdMxuMPC8fs3R3LFmHi+IYR+iM7YzlgKUBE5089lwlj
 jLUGluo7vPJyZp86S5tgSPmI3+/ZX99DBc5RaBKFB+BJxKiczl2Abs5racTmQPJYD1vMsEH99u7TM
 1q+7SatVbL2GExx07rNVRuOg8G1H/r04T9MKM6C+P67YfbbQhKXPG7Y1OQ4YLW4zsthD0tnXQogRe
 hB7uB+cjtKWTsCnUe7v0lvfbzb2USWtE14JM0BPFZkmzHTS04bnspBCI/iHYmO/YiqX+McNTh9R7U
 5DHlUcJg==;
Received: from [31.4.136.12] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wwH3Q-005ZE6-Rc; Tue, 18 Aug 2026 12:28:24 +0200
Message-ID: <6d601f3b-c531-42c8-a2c9-fd1da1b74c1b@igalia.com>
Date: Tue, 18 Aug 2026 12:28:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] drm/atomic-state-helper: fixes for blend-mode-prop
 warning
To: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "daniels@collabora.com" <daniels@collabora.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "leandro.ribeiro@collabora.com" <leandro.ribeiro@collabora.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "pekka.paalanen@collabora.com" <pekka.paalanen@collabora.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "siqueira@igalia.com" <siqueira@igalia.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>
Cc: "Hung, Alex" <Alex.Hung@amd.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 Lyude Paul <lyude@redhat.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260813143605.106104-1-mwen@igalia.com>
 <DS0PR12MB65342A796015C57DCD287AB99CDB2@DS0PR12MB6534.namprd12.prod.outlook.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <DS0PR12MB65342A796015C57DCD287AB99CDB2@DS0PR12MB6534.namprd12.prod.outlook.com>
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



On 13/08/2026 19:58, Wheeler, Daniel wrote:
> Public
>
> Thanks for the fixes Melissa, we'll re-add them to next week's promotion and re-test.

Nice!

Thank you!

Melissa

>
> Thank you,
>
> Dan Wheeler
> Sr. Technologist | AMD
> SW Display
> ------------------------------------------------------------------------------------------------------------------
> 1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
> amd.com
>
>
> -----Original Message-----
> From: Melissa Wen <mwen@igalia.com>
> Sent: Thursday, August 13, 2026 10:30 AM
> To: airlied@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; daniels@collabora.com; Wentland, Harry <Harry.Wentland@amd.com>; leandro.ribeiro@collabora.com; maarten.lankhorst@linux.intel.com; mripard@kernel.org; pekka.paalanen@collabora.com; simona@ffwll.ch; siqueira@igalia.com; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; tzimmermann@suse.de
> Cc: Hung, Alex <Alex.Hung@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; kernel-dev@igalia.com; Lyude Paul <lyude@redhat.com>; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
> Subject: [PATCH v3 0/3] drm/atomic-state-helper: fixes for blend-mode-prop warning
>
> PREMULTI was the default DRM blend mode until 9813e158d13d
> ("drm/drm_blend: allow blend mode property without PREMULTI") introduced the possibility of exposing the blend mode property without PREMULTI being supported. However, __drm_atomic_helper_plane_state_init() still resets pixel_blend_mode to PREMULTI (hardcoded), ignoring the supported mode in this property. In the same series, 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed") starts warning drivers that supports alpha formats in a given planes but doesn't support blend mode property, which includes AMD primary and cursor planes.
>
> For AMD DCN families, overlay and primary planes support the three blend modes, and therefore PREMULTI is still the default mode. So the warning can be fixed by just creating blend mode properties for primary planes too. PREMULTI is the default/unique mode for cursor planes in DCN and DCE driver. However, looks like PIXEL_NONE is the unique blend mode supported by DCE-generation driver. I don't have the hardware to check it out, but looking at the code I understand that, even if the hardware can do PREMULTI or COVERAGE, the way it programs registers doesn't make these other blend modes actually available.
>
> Bearing this in mind, this series is organized as follow:
>
> - Patch 1 fixes the pixel_blend_mode reset when the blend mode property
>    is advertised without PREMULTI support. It's needed for AMD
>    DCE-generation (patch 3) and I think with this we can also remove a
>    workaround in nouveau nv50_wndw_default_state() caused by the
>    hardcoded PREMULTI default value [1].
>
> - Patch 2 fixes the missing-blend-mode-property warning for DCN primary
>    plane and for DCN+DCE cursor plane. The alpha property keeps only on
>    overlay planes because looks like this is not supported by AMD primary
>    planes and it doesn't affect the blend mode warning we are targetting.
>    Enabling alpha properties to primary was also causing -EINVAL on IGT
>    alpha tests because it started testing primary planes and disabling it
>    (which is not allowed by the AMD display driver).
>
> - Patch 3 fixes the warning for DCE primary plane, but I detached this
>    solution from the previous patch because I don't have hardware to
>    validate if my assumption about PIXEL_NONE-only is correct.
>
> [1] https://lore.kernel.org/dri-devel/20260720215058.398210-3-lyude@redhat.com/
>
> [v1]: https://lore.kernel.org/dri-devel/20260722183240.626522-1-mwen@igalia.com/
> Changes:
> - new patch for pixel_blend_mode default value other than PREMULTI.
> - remove DCE11 which supports per_pixel_alpha but doesn't support DCN_UNIVERSAL_PLANE.
> - new patch for the primary plane blend mode on DCE-generations
>
> [v2]: https://lore.kernel.org/dri-devel/20260804140758.107683-1-mwen@igalia.com/
> Changes:
> - keep alpha property only for overlay planes (looks like primary plane
>    doesn't actually support it) - alpha prop in primary planes causes IGT
>    test failures with RX 7900 XT on a 4k60 HP U27 as reported by Daniel
>    Wheeler.
> - improve readability of if conditions (Alex H)
> - add Leandro's r-b tags.
>
> Best Regards,
>
> Melissa
>
> Melissa Wen (3):
>    drm/atomic-state-helper: set pixel_blend_mode to prop default on reset
>    drm/amd/display: fix missing blend-mode-prop warning for DCN
>    drm/amd/display: advertise PIXEL_NONE as blend mode for DCE generations
>
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 25 ++++++++++++++++---
>   drivers/gpu/drm/drm_atomic_state_helper.c     |  7 ++++++
>   2 files changed, 29 insertions(+), 3 deletions(-)
>
> --
> 2.53.0
>

