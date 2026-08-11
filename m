Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5675C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A32010E8A3;
	Tue, 11 Aug 2026 13:17:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="D0DJM+Mp";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A087310E1FA;
 Tue, 11 Aug 2026 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:From:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=iiDxR/T+im2R3v74OKLWGqURltZWSX0op5h3VfwA6MI=; b=D0DJM+MpCH7nnHXWDnZlDm/3DV
 LyJKFtpJBBoHp2mhQ6zC+JwB5bk3yYFup23o6iiX05tC47PaqtNe9Z5kbq3ct1uZczstzMB0hEKsV
 bmmlW9SgfL/pXT/BVRHEwGKa6eAl/aKiX7paTm2m9yeKz3lKARiiqEuci5BMwjd/u5MHK6QpNY3QM
 0oF6UzbqIdsFkdX7RbvXfMKr0FbAhhGYU7BaWZkKqEqGUuVmidn2+c7zOiVVTtDPeucA5g8dSBph7
 BNjoLwakJHpiKivXmRliZVwqPrYiIdu3WOLMAQtAAF+FIXv4cq7AB6TAGTFPZtZPNOsQtFV9sHxn/
 P3F+274A==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=[192.168.1.128]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wtmM9-00H7Ih-IC; Tue, 11 Aug 2026 15:17:25 +0200
Message-ID: <f3eb0bbb-c167-4557-b5a6-16cfb4b6137f@igalia.com>
Date: Tue, 11 Aug 2026 15:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/atomic-state-helper: fixes for blend-mode-prop
 warning
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniels@collabora.com, harry.wentland@amd.com,
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, kernel-dev@igalia.com,
 Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260804140758.107683-1-mwen@igalia.com>
Content-Language: en-US
In-Reply-To: <20260804140758.107683-1-mwen@igalia.com>
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



On 04/08/2026 16:00, Melissa Wen wrote:
> PREMULTI was the default DRM blend mode until 9813e158d13d
> ("drm/drm_blend: allow blend mode property without PREMULTI") introduced
> the possibility of exposing the blend mode property without PREMULTI
> being supported. However, __drm_atomic_helper_plane_state_init() still
> resets pixel_blend_mode to PREMULTI (hardcoded), ignoring the supported
> mode in this property. In the same series, 860e748bddcc ("drm: ensure
> blend mode supported if pixel format with alpha exposed") starts warning
> drivers that supports alpha formats in a given planes but doesn't
> support blend mode property, which includes AMD primary and cursor
> planes.
>
> For AMD DCN families, overlay and primary planes support the three blend
> modes, and therefore PREMULTI is still the default mode. So the warn can
> be fixed by just creating blend mode properties for primary planes too.
> PREMULTI is the default/unique mode for cursor planes in DCN and DCE
> driver. However, looks like PIXEL_NONE is the unique blend mode
> supported by DCE-generation driver. I don't have the hardware to check
> it out, but looking at the code I understand that, even if the hardware
> can do PREMULTI or COVERAGE, the way it programs registers doesn't make
> these other blend modes actually available.

Hello,

As this series mostly fixes AMD display driver, can I get an ack from 
AMD folks?

Thanks in advance,

Melissa

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
>    plane and for DCN+DCE cursor plane.
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
> Best Regards,
>
> Melissa
>
> Melissa Wen (3):
>    drm/atomic-state-helper: set pixel_blend_mode to prop default on reset
>    drm/amd/display: fix missing blend-mode-prop warning for DCN
>    drm/amd/display: advertise PIXEL_NONE as blend mode for DCE
>      generations
>
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 22 +++++++++++++++++--
>   drivers/gpu/drm/drm_atomic_state_helper.c     |  7 ++++++
>   2 files changed, 27 insertions(+), 2 deletions(-)
>

