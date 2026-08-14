Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0CEC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABBF10E5B5;
	Fri, 14 Aug 2026 20:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="YTUIYoWt";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6AF10E594;
 Fri, 14 Aug 2026 20:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786737841; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ehcMEMGFyfEh2tMIvAWNJxFR2TE3KSYFMrtRfhwWCcVWA4kSRuqH0yChtuEnu76SXJV2OILff6ZeNhO1mFXrhgtmgKiAJLf7z6XzONlCAxmC0wj549uVeaRDIsPtOBTiLqmgPorEwLNNh+FER6/Qv0B1dJKLHpYk46cShkshe1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786737841;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LOg2yFu5DUXB7qAK58Qo2nRQPlhbVRlYpLUREOVAKmY=; 
 b=nWthFAvES7g5CbTglGCM1NbJpVOvIyNP6Y+Dpi8wiF3aka8651UfuLS/CsR4DRy0/aB7TpsHOZAiKY95h/Lbf3ZxZcyA6uIO50rKisQrIVw/2lReqwfzc7k2gSKVIFlBhuB9tA2VsA+KvPOKFZBWtjusGNGXvhAGGZYoTagkE3c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786737841; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=LOg2yFu5DUXB7qAK58Qo2nRQPlhbVRlYpLUREOVAKmY=;
 b=YTUIYoWtoveYhNVQwZVjVt+Wq7Ka2VHmrn/qUc3yGPx/gusC+wJ+4ZVpmWr4nJ44
 fAzlaKAVk2D86ntHpUPh6maDNXXBe0ze3TxJW+kM6v9Rs0UzASXoiHwK2Ym4XTU0TVw
 GwrrtqJHSSSL0UVAVy0Z6vaTrcw2Dd372E3L35lg=
Received: by mx.zohomail.com with SMTPS id 1786737839270583.6279785799306;
 Fri, 14 Aug 2026 13:03:59 -0700 (PDT)
Message-ID: <2a5246dd-6a98-487f-852e-21423edf071e@collabora.com>
Date: Fri, 14 Aug 2026 22:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] YUV conversion colorop with amdgpu and VKMS
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>
References: <20260731181521.681990-1-harry.wentland@amd.com>
 <1df8715d-5b2f-4c66-9960-635b65dd8e9c@collabora.com>
 <8615b361-d250-4fb7-b0e3-057f2ec6786a@amd.com>
Content-Language: en-US, de-DE, en-GB
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <8615b361-d250-4fb7-b0e3-057f2ec6786a@amd.com>
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

Hey Harry,

"[PATCH v5 08/10] drm/amd/display: Check actual state during 
commit_tail" still fails to build - it modifies 
fill_plane_color_attributes() in amdgpu_dm.c, but not in amdgpu_dm.h and 
amdgpu_dm_test.c.

Regards

On 14.08.26 21:33, Harry Wentland wrote:
>
> On 2026-08-01 05:42, Robert Mader wrote:
>> Hi Harry,
>>
>> On 31.07.26 20:15, Harry Wentland wrote:
>>> When we merged the drm_plane color pipeline API the major gap
>>> that existed was the lack of a YUV to RGB conversion colorop.
>>> We deprecated any legacy drm_plane color properties, which
>>> means that the COLOR_RANGE and COLOR_ENCODING properties can't
>>> be used with the COLOR_PIPELINE property on a drm_plane. In
>>> practice this means that we can't use a COLOR_PIPELINE on
>>> YCbCr encoded framebuffers.
>>>
>>> This patchset expands on the Fixed Matrix colorop proposed by Chaitanya
>>> and adds limited range variants of the YCbCr to RGB conversions.
>>>
>>> His full patchset can be found at
>>> https://patchwork.freedesktop.org/patch/709860
>>>
>>> This code has been tested with IGT and an experimental KWin branch.
>>>
>>> All patches are now reviewed and tested. We have a Weston and
>>> KWin implementation. IGT patches are missing one review. I
>>> deem these patches ready to merge once the last IGT patch review
>>> comes in.
>>>
>>> IGT branch:
>>> https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/yuv-fm-colorop
>>>
>>> KWin branch used for testing:
>>> https://invent.kde.org/hwentlan/kwin/-/tree/yuv-fm-colorop
>>>
>>> The kernel branch containing these changes, based on drm-misc-next
>>> can be found at:
>>> https://gitlab.freedesktop.org/hwentland/linux/-/tree/yuv-fm-colorop
>> I wanted to give this a quick go with the Weston implementation [1], however unfortunately the branch doesn't build for me and fails with the error below.
>>
> I forgot to update the series and still had a bad branch sitting on this branch.
> I pushed the latest rebase. There should be no conflicts now.
>
> The rebase from v5 was trivial (what was sitting on my FDO tree was older) so
> no need to send a v6.
>
> Harry
>
>> With that fixed I hope we can land the series - that would be awesome 🤞
>>
>> Regards
>>
>> 1: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2133
>>
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2987:1: error: conflicting types for ‘fill_plane_color_attributes’; have ‘int(struct drm_atomic_commit *, const struct drm_plane_state *, const enum surface_pixel_format,  enum dc_color_space *)’
>>   2987 | fill_plane_color_attributes(struct drm_atomic_commit *state,
>>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> In file included from ./drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:87,
>>                   from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:48:
>> ./drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.h:1133:5: note: previous declaration of ‘fill_plane_color_attributes’ with type ‘int(const struct drm_plane_state *, const enum surface_pixel_format,  enum dc_color_space *)’
>>   1133 | int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> In file included from ./include/linux/linkage.h:7,
>>                   from ./include/linux/printk.h:8,
>>                   from ./include/asm-generic/bug.h:31,
>>                   from ./arch/x86/include/asm/bug.h:195,
>>                   from ./include/linux/bug.h:5,
>>                   from ./include/linux/slab.h:15,
>>                   from ./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:30,
>>                   from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
>>                   from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:30:
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:3034:17: error: conflicting types for ‘fill_plane_color_attributes’; have ‘int(struct drm_atomic_commit *, const struct drm_plane_state *, const enum surface_pixel_format,  enum dc_color_space *)’
>>   3034 | EXPORT_IF_KUNIT(fill_plane_color_attributes);
>>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/export.h:76:28: note: in definition of macro ‘__EXPORT_SYMBOL’
>>     76 |         extern typeof(sym) sym;      \
>>        |                            ^~~
>> ./include/linux/export.h:89:41: note: in expansion of macro ‘_EXPORT_SYMBOL’
>>     89 | #define EXPORT_SYMBOL(sym) _EXPORT_SYMBOL(sym, "")
>>        |                                         ^~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_kunit_helpers.h:12:33: note: in expansion of macro ‘EXPORT_SYMBOL’
>>     12 | #define EXPORT_IF_KUNIT(symbol) EXPORT_SYMBOL(symbol)
>>        |                                 ^~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:3034:1: note: in expansion of macro ‘EXPORT_IF_KUNIT’
>>   3034 | EXPORT_IF_KUNIT(fill_plane_color_attributes);
>>        | ^~~~~~~~~~~~~~~
>> ./drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.h:1133:5: note: previous declaration of ‘fill_plane_color_attributes’ with type ‘int(const struct drm_plane_state *, const enum surface_pixel_format,  enum dc_color_space *)’
>>   1133 | int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>>
>>> Further background on this work can be found at:
>>> https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html
>>>
>>> v5:
>>>    - Drop new VKMS kunit tests for conversion matrices
>>>    - Added script to show how VKMS kunit test values are computed (Pekka)
>>>    - Removed fixed-matrix enums for "YCbCr limtied to full" and
>>>      "RGB709 to RGB2020" as they're currently unused by userspace (Robert)
>>>
>>> v4:
>>>    - Specify matrix entries in docs (Pekka)
>>>    - Squash limited-range enums into "Add FM" patch (Robert)
>>>    - Don't reject RGB planes with fixed matrix in VKMS as
>>>      we don't want or need to make a colorop dependent on
>>>      the framebuffer's pixel format. (Robert)
>>>    - Fix conversion matrices in VKMS and implement kunit
>>>      tests (discovered while documenting the matrices)
>>>
>>> v3:
>>> - base on Chaitanya's updated patch and rename code accordingly
>>>     to Fixed_Matrix instead of CSC Fixed-Function
>>>
>>> v2:
>>> - use Chaitanya's CSC_FF block for named matrices
>>>
>>> Cc: Alex Hung <alex.hung@amd.com>
>>> Cc: Daniel Stone <daniels@collabora.com>
>>> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>> Cc: Uma Shankar <uma.shankar@intel.com>
>>> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
>>> Cc: Melissa Wen <mwen@igalia.com>
>>> Cc: Simon Ser <contact@emersion.fr>
>>> Cc: Robert Mader <robert.mader@collabora.com>
>>>
>>> Chaitanya Kumar Borah (1):
>>>     drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
>>>
>>> Harry Wentland (9):
>>>     drm/vkms: Fix limited-range YCbCr to RGB conversion scaling
>>>     drm/vkms: Add fixed matrix colorop to color pipeline
>>>     drm/vkms: Add atomic check and matrix handling for fixed matrix
>>>       colorop
>>>     drm/amd/display: Add fixed matrix colorop to color pipeline
>>>     drm/amd/display: Implement fixed matrix colorop color space mapping
>>>     drm/amd/display: Use GAMCOR for first TF if YUV conversion is needed
>>>     drm/amd/display: Check actual state during commit_tail
>>>     drm/amd/display: Set color_space to plane_infos
>>>     drm/amd/display: Force GAMCOR for subsampled surfaces with
>>>       PQ/Gamma22/HLG
>>>
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +-
>>>    .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  85 +++++++++++-
>>>    .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 +++-
>>>    .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
>>>    .../amd/display/modules/color/color_gamma.c   |   3 +-
>>>    drivers/gpu/drm/drm_atomic.c                  |   4 +
>>>    drivers/gpu/drm/drm_atomic_uapi.c             |   7 +
>>>    drivers/gpu/drm/drm_colorop.c                 | 107 +++++++++++++++
>>>    .../gpu/drm/vkms/tests/gen_yuv_conversion.py  |  87 ++++++++++++
>>>    drivers/gpu/drm/vkms/tests/vkms_format_test.c |  40 +++---
>>>    drivers/gpu/drm/vkms/vkms_colorop.c           |  66 ++++++---
>>>    drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
>>>    drivers/gpu/drm/vkms/vkms_formats.c           |  64 ++++++---
>>>    drivers/gpu/drm/vkms/vkms_formats.h           |   2 +-
>>>    drivers/gpu/drm/vkms/vkms_plane.c             |  55 +++++++-
>>>    include/drm/drm_colorop.h                     | 127 ++++++++++++++++++
>>>    include/uapi/drm/drm_mode.h                   |  12 ++
>>>    17 files changed, 639 insertions(+), 68 deletions(-)
>>>    create mode 100755 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py
>>>
>>> -- 
>>> 2.55.0
>>>
