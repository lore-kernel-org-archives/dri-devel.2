Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D22C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 994C110E3E0;
	Thu, 27 Aug 2026 10:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JA0Dp+sQ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6288710E3E0;
 Thu, 27 Aug 2026 10:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=tYGgf7xKuGOlswlRccJyniNDxOZS5LEFyZBK1IRiB5A=; b=JA0Dp+sQ4OMaLV+23ZvdLu9t00
 Zx3jfXeGTrDi9yNL7NtjcjQwGZrKTlw/4zpa06Q4iBc7fHUVtFYU+ips17Wa4IlCMy4Wu0E3+Jnht
 I4ZpSGPDG2W0xiiVZT9njmeVM1jmwDaIa4oKVH4JYZd0WnjyuErnnTLgQZG8LG7+EwPDXtilDTzqM
 OElQG4qbKuzN/Ks0OSd3luiVbUQ5S57t92bYslLxpgZdpISLn5mweG30+ui/zAWlWEiGLflHKC1v/
 xtKnb/wjb2jbhVdhKPG3DNXyi0eZNWuOU8x2OCyh/3DTpLQMFzm/ixCUT5XBOkLt7JdcpZuACeAIH
 6ZXU/5zQ==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=[192.168.1.206]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wzXHS-009y8R-19; Thu, 27 Aug 2026 12:24:22 +0200
Message-ID: <22a3be63-ebe9-4334-9f42-73e62f123277@igalia.com>
Date: Thu, 27 Aug 2026 12:24:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: use plane color_mgmt_changed to track
 colorop changes
To: Dave Airlie <airlied@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20260807115712.22423-1-mwen@igalia.com>
 <CADnq5_OxnaEdNUpC1VQsCgensRYAgFCMeGy3uL5n6mYXqOHV-g@mail.gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <CADnq5_OxnaEdNUpC1VQsCgensRYAgFCMeGy3uL5n6mYXqOHV-g@mail.gmail.com>
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



On 10/08/2026 20:40, Alex Deucher wrote:
> On Fri, Aug 7, 2026 at 8:08 AM Melissa Wen <mwen@igalia.com> wrote:
>> This is a resubmission of d79716401a95 ("drm/amd/display: use plane
>> color_mgmt_changed to track colorop changes") whose change was reverted
>> by 0461ba9a7994 ("Merge tag 'amd-drm-next-7.3-2026-07-02' of
>> https://gitlab.freedesktop.org/agd5f/linux into drm-next") during a
>> merge conflict resolution.
>>
>> Original commit message:
>>
>> ```
>> Ensure the driver tracks changes in any colorop property of a plane
>> color pipeline by using the same mechanism of CRTC color management and
>> update plane color blocks when any colorop property changes. It fixes an
>> issue observed on gamescope settings for night mode which is done via
>> shaper/3D-LUT updates.
>> ```
>>
>> Fixes: 0461ba9a7994 ("Merge tag 'amd-drm-next-7.3-2026-07-02' of https://gitlab.freedesktop.org/agd5f/linux into drm-next")
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Hey Dave,

Can you apply it to drm-next?

This a regression from 
https://lists.freedesktop.org/archives/amd-gfx/2026-July/148126.html
And AFAIU drm-misc's branches are not the right place.

Best Regards,

Melissa

>
>
>> ---
>>
>> Hey,
>>
>> I noticed this problem in the resolution of a merge conflict after
>> testing drm-misc-next on SteamDeck with KMS colorop API support and
>> verifying the issue of missing updates in nightlight-mode was back.
>>
>> Let me know what are the right steps to address it.
>>
>> Thanks,
>>
>> Melissa
>>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 67b825cbb88f..d0e612371c8f 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4202,7 +4202,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
>>                          continue;
>>
>>                  bundle->surface_updates[planes_count].surface = dc_plane;
>> -               if (new_pcrtc_state->color_mgmt_changed) {
>> +               if (new_pcrtc_state->color_mgmt_changed || new_plane_state->color_mgmt_changed) {
>>                          bundle->surface_updates[planes_count].gamma = &dc_plane->gamma_correction;
>>                          bundle->surface_updates[planes_count].in_transfer_func = &dc_plane->in_transfer_func;
>>                          bundle->surface_updates[planes_count].gamut_remap_matrix = &dc_plane->gamut_remap_matrix;
>> @@ -6012,6 +6012,10 @@ static bool should_reset_plane(struct drm_atomic_commit *state,
>>          if (new_crtc_state->color_mgmt_changed)
>>                  return true;
>>
>> +       /* Plane color pipeline or its colorop changes. */
>> +       if (new_plane_state->color_mgmt_changed)
>> +               return true;
>> +
>>          /*
>>           * On zpos change, planes need to be reordered by removing and re-adding
>>           * them one by one to the dc state, in order of descending zpos.
>> --
>> 2.53.0
>>

