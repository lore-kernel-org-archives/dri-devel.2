Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E7CC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4472810E1B5;
	Tue,  4 Aug 2026 18:17:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=leandro.ribeiro@collabora.com header.b="lGYd+Ew9";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AC310EB56;
 Tue,  4 Aug 2026 18:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785867460; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bJMklkrw7V7F5kaypnXvWckFqmSL2OQmgB6rQWoJrmDoyykaYp/Ms3kS72frLo0IFywM+sUiX1xhnk4pVM3dOyo7E3SsiSQlDyciZRqEoGOLE9adyQmfLTcE77dZJ2PWlcjlnXYlTu2m04CgYAeRYphw8ZMf8pNp+9cb4E7IVjk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785867460;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iX/BcEDZW7kPU9Z63peIu1ubQcVuBxnhjJYy41gHWhs=; 
 b=kVSvm4nsMOhOdHzyAm9EODDYidRuM8tv2gHIozWyC5uk03+O5oae6KXYLBEhjzEyPx70fLNxKn8U/S/+bqgV5dQ4irN1TyD59GvlcQOcJPmk/X1ia0a21YN2Ge+mjMUdVCmg1qiF/Ypyrusn4GLCHdlQdaQKPQ328ax+pwGhkrI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=leandro.ribeiro@collabora.com;
 dmarc=pass header.from=<leandro.ribeiro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785867460; 
 s=zohomail; d=collabora.com; i=leandro.ribeiro@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=iX/BcEDZW7kPU9Z63peIu1ubQcVuBxnhjJYy41gHWhs=;
 b=lGYd+Ew9YbeGtj3FDlLbbXC7KV+jSP2fwcTKV4ZG+XsjnH0b4lZxuKxHl7CV1cLU
 FeNAgJEgdfyuCjhakkeU+QOzOm3a7jq9jcaH7xyDrsQ/5iiXVfiVSLidCNT7WCYLCjR
 9Djzkm9hb1WCmqx5icqTQHBFoUDtZAJoFJHyVy4g=
Received: by mx.zohomail.com with SMTPS id 1785867459087896.3917670132231;
 Tue, 4 Aug 2026 11:17:39 -0700 (PDT)
Message-ID: <3aa7aba7-a2b1-474b-8e77-e0e1f6a0a712@collabora.com>
Date: Tue, 4 Aug 2026 15:17:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/atomic-state-helper: fixes for blend-mode-prop
 warning
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, daniels@collabora.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, kernel-dev@igalia.com,
 Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260804140758.107683-1-mwen@igalia.com>
Content-Language: en-US
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
In-Reply-To: <20260804140758.107683-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

Hello,

Thank you! I don't have AMD hardware to validate the DCE-generation
details either, and I'm not familiar with the AMD specific bits. But
this series LGTM from the blend-mode requirements perspective. So, with
this caveat:

Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>

On 8/4/26 11:00 AM, Melissa Wen wrote:
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
> 
> Bearing this in mind, this series is organized as follow:
> 
> - Patch 1 fixes the pixel_blend_mode reset when the blend mode property
>   is advertised without PREMULTI support. It's needed for AMD
>   DCE-generation (patch 3) and I think with this we can also remove a
>   workaround in nouveau nv50_wndw_default_state() caused by the
>   hardcoded PREMULTI default value [1].
> 
> - Patch 2 fixes the missing-blend-mode-property warning for DCN primary
>   plane and for DCN+DCE cursor plane.
> 
> - Patch 3 fixes the warning for DCE primary plane, but I detached this
>   solution from the previous patch because I don't have hardware to
>   validate if my assumption about PIXEL_NONE-only is correct.
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
>   drm/atomic-state-helper: set pixel_blend_mode to prop default on reset
>   drm/amd/display: fix missing blend-mode-prop warning for DCN
>   drm/amd/display: advertise PIXEL_NONE as blend mode for DCE
>     generations
> 
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 22 +++++++++++++++++--
>  drivers/gpu/drm/drm_atomic_state_helper.c     |  7 ++++++
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 

-- 
Leandro Ribeiro

