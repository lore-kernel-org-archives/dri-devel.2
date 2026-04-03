Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1F5E85363
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 12:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0582410E45B;
	Fri,  3 Apr 2026 12:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="N11smG3I";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB00D10E45B
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 12:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pnFeo5WYVTMoJzdbetMpJ2Gg+m8E9ULLmaOX05Z0gGY=; b=N11smG3IeiXdg6rKzCMP2pKEfT
 MVJ5i2oRdC/QCbMxqWuLmp55qwHHXVzbFP4kn1EkEsKR0YVIXcDOULuciDMI79NzkQJjYDyOj5SXK
 xKtqJLv66CFrUe5Y11Tbm9iYulOh5ZHaELDnBKof50169JiSKB0xao86Lo1XXD8fnbPMSSxiZPd82
 QLXNdz5YsAk5IOe4NdSbR7aoQhyffuUP6aKUeSduuKfDT6j04kU9ByE+jbBVjxCeVl/tCGO2D4Q49
 tFquDz9bl3oUZ+B70aYHlerKmF7bl85F5t0x89TIvTowtoAL5EoScMgq1yy2aIbQvFNV8xw7gsUVV
 CQ/FUWCg==;
Received: from [189.89.58.26] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w8e17-00AsHw-Cu; Fri, 03 Apr 2026 14:52:53 +0200
Message-ID: <9ace6f9b-bc25-427e-a303-940b60d14bd7@igalia.com>
Date: Fri, 3 Apr 2026 09:52:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/colorop: Remove read-only comments from interpolation
 fields
To: Alex Hung <alex.hung@amd.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 contact@emersion.fr, harry.wentland@amd.com, sebastian.wick@redhat.com,
 daniels@collabora.com, chaitanya.kumar.borah@intel.com,
 pekka.paalanen@collabora.com, xaver.hugl@kde.org,
 dri-devel@lists.freedesktop.org
References: <20260402201514.1430606-1-alex.hung@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260402201514.1430606-1-alex.hung@amd.com>
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



On 02/04/2026 17:15, Alex Hung wrote:
> The lut1d_interpolation and lut3d_interpolation fields and their
> associated properties were marked as read-only, but userspace
> can set them via drm_atomic_colorop_set_property().
Hi Alex,

Just removing wrong comments is not enough. Those properties still 
behave as immutable.

lut1d/3d_interpolation should be handle by drm_colorop_state as they are 
mutable, not in drm_colorop.
...and changes are needed everywhere we manage states of colorop mutable 
properties.

Melissa
>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   include/drm/drm_colorop.h | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
> index a3a32f9f918c..5bcb510e56c0 100644
> --- a/include/drm/drm_colorop.h
> +++ b/include/drm/drm_colorop.h
> @@ -296,7 +296,6 @@ struct drm_colorop {
>   	/**
>   	 * @lut1d_interpolation:
>   	 *
> -	 * Read-only
>   	 * Interpolation for DRM_COLOROP_1D_LUT
>   	 */
>   	enum drm_colorop_lut1d_interpolation_type lut1d_interpolation;
> @@ -304,7 +303,6 @@ struct drm_colorop {
>   	/**
>   	 * @lut3d_interpolation:
>   	 *
> -	 * Read-only
>   	 * Interpolation for DRM_COLOROP_3D_LUT
>   	 */
>   	enum drm_colorop_lut3d_interpolation_type lut3d_interpolation;
> @@ -312,7 +310,7 @@ struct drm_colorop {
>   	/**
>   	 * @lut1d_interpolation_property:
>   	 *
> -	 * Read-only property for DRM_COLOROP_1D_LUT interpolation
> +	 * Property for DRM_COLOROP_1D_LUT interpolation
>   	 */
>   	struct drm_property *lut1d_interpolation_property;
>   
> @@ -340,7 +338,7 @@ struct drm_colorop {
>   	/**
>   	 * @lut3d_interpolation_property:
>   	 *
> -	 * Read-only property for DRM_COLOROP_3D_LUT interpolation
> +	 * Property for DRM_COLOROP_3D_LUT interpolation
>   	 */
>   	struct drm_property *lut3d_interpolation_property;
>   

