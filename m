Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DAFCD5BB4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 18:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5977510E554;
	Thu, 21 May 2026 18:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WyiW9jrJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8352C10E1DF;
 Thu, 21 May 2026 18:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sVjLEB7Naf89XwfAlVqfn6fiYt2mgbkC8rcKbVFM4ZQ=; b=WyiW9jrJE3IPmDbqRIByANcIDk
 F7bPShMluB90PMXEsvGSzgYTqQdg62Gi8gibiqP9BZAAN3Fs0rRSGmU2td/yfGgC7/eQlCqFwHrS/
 jC/kVuhnyxryPeT+ITnQu9D/gr65P0RO0Tk2Ww66iZDXCo9A4+TDXiilYxrMYMFjTN48j9V/oO/vt
 v6CNfXBsHE2uPMii8EiiN+niyVqrFwPPlWqtibsm06ESeCeV9E+lUUBIG4N9rMq1m7nXZktWGTpON
 ovS9a5si3THkoGFwxNCwoaK7uLdPcsxDTckPWNvy47Zli3MyjkD0xZiRkUNf5WKE83lqmKF1LY4r7
 BSVSRpaA==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wQ8ZZ-004V6y-8Z; Thu, 21 May 2026 20:56:45 +0200
Message-ID: <add51789-7291-40d6-9c8a-f68f46f1f11c@Igalia.com>
Date: Thu, 21 May 2026 11:56:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Refactor drm_writeback_connector structure
To: Suraj Kandpal <suraj.kandpal@intel.com>, freedreno@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-list@raspberrypi.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20260521053708.1475129-1-suraj.kandpal@intel.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20260521053708.1475129-1-suraj.kandpal@intel.com>
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

On 5/20/26 22:37, Suraj Kandpal wrote:
> Some drivers cannot work with the current design where the connector
> is embedded within the drm_writeback_connector such as intel and
> some drivers that can get it working end up adding a lot of checks
> all around the code to check if it's a writeback conenctor or not.
> This is due to the inheritance limitation in C.
> This series intends to solve it by moving the drm_writeback_connector
> within the drm_connector and remove the drm_connector base which was in
> drm_writeback_connector. This is done in union with hdmi connector
> within drm_connector to save memory and since drm_connector cannot be
> both hdmi and writeback it serves is well.
> A RFC version was floated and discussion had taken place at [1] which
> kicked of this more cleaner series.
> We do all other required modifications that come with these changes
> along with addition of new function which returns the drm_connector when
> drm_writeback_connector is present.
> This series also contains some writeback API cleanups as a consequence
> of writeback connector moving into drm_connector
> All drivers will be expected to allocate the drm_connector.
> This discussion was tiggered from [2] and sits on top of Dmitry's series
> see [3].
>
> [1] https://patchwork.freedesktop.org/series/152758/
> [2] https://patchwork.freedesktop.org/series/152106/
> [3] https://patchwork.freedesktop.org/series/152420/
QQ: What tree is this patch set based on? I tried to apply it locally 
but I get conflicts no matter what baseline I use. I've tried full 
kernel, drm-tip and drm-next. Dmitry's patch set, [3] above, applies 
fine but I get conflicts in the rcar and mali files when trying to apply 
this set.

Thanks,
John.

>
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
>
> Suraj Kandpal (7):
>    drm: writeback: Refactor drm_writeback_connector structure
>    drm: writeback: Modify writeback init helpers
>    drm: writeback: Modify drm_writeback_queue_job helper
>    drm: writeback: Modify drm_writeback_signal_completion helper
>    drm: writeback: Modify drm_writeback_get_out_fence helper
>    drm: writeback: Modify prepare_writeback_job helper
>    drm: writeback: Modify cleanup_writeback_job helper
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +--
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  | 12 +--
>   .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 +-
>   .../gpu/drm/arm/display/komeda/komeda_kms.h   |  6 +-
>   .../arm/display/komeda/komeda_wb_connector.c  | 11 +--
>   drivers/gpu/drm/arm/malidp_crtc.c             |  2 +-
>   drivers/gpu/drm/arm/malidp_drv.h              |  2 +-
>   drivers/gpu/drm/arm/malidp_mw.c               |  7 +-
>   drivers/gpu/drm/drm_atomic_uapi.c             |  4 +-
>   drivers/gpu/drm/drm_writeback.c               | 50 +++++++-----
>   .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   |  9 ++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 10 +--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h |  4 +-
>   .../gpu/drm/renesas/rcar-du/rcar_du_crtc.h    |  6 +-
>   .../drm/renesas/rcar-du/rcar_du_writeback.c   | 16 ++--
>   drivers/gpu/drm/vc4/vc4_txp.c                 |  8 +-
>   drivers/gpu/drm/vkms/vkms_drv.h               |  2 +-
>   drivers/gpu/drm/vkms/vkms_writeback.c         | 15 ++--
>   include/drm/drm_connector.h                   | 69 ++++++++++++++++-
>   include/drm/drm_modeset_helper_vtables.h      |  4 +-
>   include/drm/drm_writeback.h                   | 76 ++-----------------
>   22 files changed, 164 insertions(+), 163 deletions(-)
>

