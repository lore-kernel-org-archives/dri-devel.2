Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AE2C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C0C510E448;
	Wed, 12 Aug 2026 17:20:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NTUvD2fl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DC810F0A6;
 Wed, 12 Aug 2026 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=TBLKWXq6HG2XRFCU+5kyvX35rrKA9Y6g9Bk43j5/pF4=; b=NTUvD2flz4LKIly/iwdLL8R47Q
 uruoZ7I8Xbh10Ksv40vhEnj36jqVV8QAWUGbSH+qWanBY0by0KiRqKik26D0yo7bFBKbfua3DF16/
 Yb+/ZjOIK3PiQnCPVUn1BJBwx9Ygz8rImkoAw2eaAKUWNskITLraKVlAbFT5/l8vWXApY8QBBQtBu
 1H/etiGMGGuTt6K08ahIRoRm2woKNmk/CGRuN4zODgLgo+ZbQfzH+qztZY4MQWpuNmT4sT1kPUkwe
 NPXnCJshwgMmUa5Z7MmMQSu2XWDumEZzepaVNGIJUgfIh8EhU7v3wwCM8ZbqFDE81vGxKc5bTFXG7
 Bu+9x5WA==;
Received: from [31.4.134.207] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wuCcV-000Dr2-75; Wed, 12 Aug 2026 19:20:03 +0200
Message-ID: <22c2dfcd-f124-469c-aab8-a98db4b449d2@igalia.com>
Date: Wed, 12 Aug 2026 19:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amd/display: fix missing blend-mode-prop
 warning for DCN
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
References: <20260804140758.107683-1-mwen@igalia.com>
 <20260804140758.107683-3-mwen@igalia.com>
 <DS0PR12MB65344015A6A94FCD1E449A709CDC2@DS0PR12MB6534.namprd12.prod.outlook.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <DS0PR12MB65344015A6A94FCD1E449A709CDC2@DS0PR12MB6534.namprd12.prod.outlook.com>
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



On 12/08/2026 18:34, Wheeler, Daniel wrote:
> Public
>
> Hey Melissa,
>
> I've found out that this patch causes some IGT failures with the igt@kms_plane_alpha_blend tests. I noticed it with a RX 7900 XT on a 4k60 HP U27. The tests fail with an assertion failure. I posted a snippet below.
>
>
> Starting subtest: alpha-basic
> Starting dynamic subtest: pipe-A-DP-1
> [181.052561] (kms_plane_alpha_blend:9570) igt_kms-CRITICAL: Test assertion failure function do_display_commit, file ../lib/igt_kms.c:4982:
> [181.052564] (kms_plane_alpha_blend:9570) igt_kms-CRITICAL: Failed assertion: ret == 0
> [181.052568] (kms_plane_alpha_blend:9570) igt_kms-CRITICAL: Last errno: 22, Invalid argument
> [181.052571] (kms_plane_alpha_blend:9570) igt_kms-CRITICAL: error: -22 != 0
> Dynamic subtest pipe-A-DP-1 failed.

Hi Daniel,

Thanks for testing and pointing it out.

I think the failure is caused by including alpha property to primary 
planes, so the test runs for primary planes and fails when trying to 
disable them (CRTC w/o primary).
I'm not sure if this is essentially an issue in the IGT test or if AMD 
primary planes don't support alpha, but I'll send another version to not 
add alpha property to primary by now as it isn't related to the blend 
mode warning. After I'll look at the driver to understand what is the 
right approach.

Best Regards,

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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Melissa Wen
> Sent: Tuesday, August 4, 2026 10:01 AM
> To: airlied@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; daniels@collabora.com; Wentland, Harry <Harry.Wentland@amd.com>; leandro.ribeiro@collabora.com; maarten.lankhorst@linux.intel.com; mripard@kernel.org; pekka.paalanen@collabora.com; simona@ffwll.ch; siqueira@igalia.com; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; tzimmermann@suse.de
> Cc: Hung, Alex <Alex.Hung@amd.com>; kernel-dev@igalia.com; Lyude Paul <lyude@redhat.com>; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
> Subject: [PATCH v2 2/3] drm/amd/display: fix missing blend-mode-prop warning for DCN
>
> validate_blend_mode_for_alpha_formats() warns when a plane supports formats with alpha but doesn't expose the blend mode property. Fix this by adding the same overlay plane blend modes to primary plane, since they are all universal planes in DCN-generation. Cursor planes support
> ARGB8888 format and CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA is set by default (other color formats are not implemented), so only expose support to PREMULTI, which is the default blend mode on DRM.
>
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 1b564cfe2120..a276f3730044 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1923,8 +1923,15 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>          if (res)
>                  return res;
>
> -       if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
> -           plane_cap && plane_cap->per_pixel_alpha) {
> +       /* TODO: Check which blend modes are supported in DCE-generation
> +        * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
> +        * property accordingly.
> +        */
> +       if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
> +            plane->type == DRM_PLANE_TYPE_PRIMARY) &&
> +           plane_cap &&
> +           plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL &&
> +           plane_cap->per_pixel_alpha) {
>                  unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>                                            BIT(DRM_MODE_BLEND_PREMULTI) |
>                                            BIT(DRM_MODE_BLEND_COVERAGE);
> @@ -1933,6 +1940,13 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>                  drm_plane_create_blend_mode_property(plane, blend_caps);
>          }
>
> +       /* Cursor color format is set to CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA
> +        * by default, so only advertise DRM_MODE_BLEND_PREMULTI blend mode for
> +        * this type of plane.
> +        */
> +       if (plane->type == DRM_PLANE_TYPE_CURSOR)
> +               drm_plane_create_blend_mode_property(plane,
> +BIT(DRM_MODE_BLEND_PREMULTI));
> +
>          if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
>                  /*
>                   * Allow OVERLAY planes to be used as underlays by assigning an
> --
> 2.53.0
>

