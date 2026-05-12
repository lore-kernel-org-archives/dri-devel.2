Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBF7CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 17:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 269E610EB8A;
	Tue, 12 May 2026 17:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="p17YBXDZ";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="jVOub3B6";
	dkim-atps=neutral
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D7810EB8A
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 17:42:21 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-hl1x.prod.antispam.mailspamprotection.com;
 s=arckey; t=1778607741; 
 b=Me/Ww5tLSx+J+ojEyx54eT4zRsaSyHaje/381e/6594zhXnEohxn4CU7itzyByuNFsdT6kSjsb
 XBCOeuoqbG+yMPc+eN+GZQ9u9gmccsAPZ5sCDa7c1KE1Q7nmK037NhbcCDYNjuao3FgDvyOpJW
 UoMHc8uzl5FjO4DlkwrhTTx8E9A8neW4kpVFeXkUVFmHOJVyZYK/8vhR4LlWyrGyXP0DuWEW/v
 pcpqJXFv2SouJEqrKvA3ODdG1OxivweTJxIl6fl+GJ31sz2hqYnpzjonJrw16H1vhfsyhf34pA
 aOMSfflAc9R7BgwV8zZyVz4/KwoGaBkkeja1RSf0UUl5RA==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-hl1x.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-hl1x.prod.antispam.mailspamprotection.com;
 s=arckey; t=1778607741; 
 bh=N0ory80vSiLGWEVAEYOHsz+lROIdnBjmis4jD8LYDF4=;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
 b=bmXQQ3YsNpmIo9HROc6LN9QO5ONlT9b/W7dsyKv+bLj2UZUIdJ1asVDEzQ2vifw/nUKSCBCEpS
 axWyW8DKgIjhHqD1ELOplB74CNXPrrMul+UjDBLHgIdVc0wro/bZDBvytbYeD1/beoqcaKfJNV
 bPKQkahzJH4QCi6P2VimpVS0r5Id2PKUXfgkdadPEGN5um6LzT9ooAJG8/fnV/NwurihINlSzV
 GE++WoBKzQ5ism54s8Qk6w/wCwryrV/aRObHiccRK/GeCK+8/5iSYI105lhFAmr5wz3BWRCZdZ
 IgEF2vSlABLcSSdpN3X5yl1RytsNASOvTBjzRsDIhvje7A==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
 :From:Date:Reply-To:List-Unsubscribe;
 bh=JuCcCssjBouozGGrCwGDqPLUK44aLy9/bRIDy8dNaOs=; b=p17YBXDZO0b9oQtLV0iI53wz5n
 kP1v5Mm4/jatnm7qnF7HbU/jil33UZP/CD9HqioeRnyZvO5glztPaBuvV2cykgUhhpMBkLccqe5AG
 GJSwQRUiX96ZH6OBqSn/cTymJ0Y363OmepXik0jo1PORT9gXmDH26xNA4k5WYjDhUx1Q=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-hl1x.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.2)
 (envelope-from <francesco@valla.it>) id 1wMr7Z-0000000Gg93-48U7
 for dri-devel@lists.freedesktop.org; Tue, 12 May 2026 17:42:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=JuCcCssjBouozGGrCwGDqPLUK44aLy9/bRIDy8dNaOs=; b=jVOub3B6/4CiZzAcBrBdp7OVvy
 SbmfAfA29fkZAQs6Sv3xpCcmtmsMy9HwGPFCL4oLbZ2KCy/tSqTdYNpImwR2dcTzoFJgvkeTxNuyP
 SevNHPyK3PhXIyyU27TiMeg/O06+WEqbn/t54xScZR8sztkG9ZB2eyKBzGbXwiMFZu+U=;
Received: from [95.232.18.244] (port=60175 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.2) (envelope-from <francesco@valla.it>)
 id 1wMr6z-000000008cX-0aN7; Tue, 12 May 2026 17:41:41 +0000
Date: Tue, 12 May 2026 19:41:39 +0200
From: Francesco Valla <francesco@valla.it>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/3] Add splash DRM client
Message-ID: <agNlONKkeOjnJoIr@bywater>
References: <20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it>
 <5d7067de-97b7-4232-9cf6-e4b978696482@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d7067de-97b7-4232-9cf6-e4b978696482@amd.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: d02b7c37717f15562a5e0f8f1529e2e2
X-AntiAbuse: ID - d02b7c37717f15562a5e0f8f1529e2e2
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wMr7Z-0000000Gg93-48U7-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-hl1x.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Hello Mario,

Thank you for taking a stab at this.

On Mon, May 11, 2026 at 08:59:14PM -0500, Mario Limonciello wrote:
> 
> 
> On 5/10/26 16:29, Francesco Valla wrote:
> > Hello,
> > 
> > this is the third (and hopefully last) RFC version for the DRM-based
> > splash screen.
> > 
> > Motivation behind the work can be found in v1 [0]; in a nutshell, the
> > splash DRM client can draw a splashscreen using:
> > 
> >    - the BMP image supplied by the EFI BGRT;
> >    - a BMP image loaded as firmware (either built-in or loaded from the
> >      filesystem);
> >    - a colored background.
> > 
> > This revision greatly simplifies the image seletion logic; now the EFI
> > BGRT is always used as first source if enabled, with a fallback to BMP
> > image loaded as firmware and then to a plain color.
> > 
> > Sanity checks on the EFI BGRT image have been borrowed from the efifb
> > driver. More complete splash providers (e.g.: Plymouth) have an
> > extensive management of platform-specific quirks, but I don't think it
> > would be reasonable to introduce such complexity here.
> > 
> > Additional notes:
> >    - Rotation is still not managed (and probably won't?).
> >    - Support for tiled screens is untested.
> >    - Plain color and BMP sources were tested on QEMU, Beagleplay and
> >      i.MX93 FRDM.
> >    - EFI BGRT support was tested using QEMU+OVMF.
> > 
> > Thank you in advance for any feedback.
> 
> Unfortunately I found that I couldn't compile with my normal Kconfig.
> 
> ERROR: modpost: "bgrt_tab" [drivers/gpu/drm/clients/drm_client_lib.ko]
> undefined!
> ERROR: modpost: "bgrt_image_size"
> [drivers/gpu/drm/clients/drm_client_lib.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> make[1]: *** [/home/supermario/src/linux/Makefile:2091: modpost] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> ❮ grep ^CONFIG_DRM .config
> CONFIG_DRM=y
> CONFIG_DRM_KMS_HELPER=m
> CONFIG_DRM_DRAW=y
> CONFIG_DRM_CLIENT=y
> CONFIG_DRM_CLIENT_LIB=m

Here lies the source of the issue, since I forgot to export the BGRT
table symbols. In my test setup I had the clients built-in and didn't
catch this. A simple patch (which will be included in v4) is attached.

> CONFIG_DRM_CLIENT_SELECTION=m
> CONFIG_DRM_CLIENT_SETUP=y
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_FBDEV_OVERALLOC=100
> CONFIG_DRM_CLIENT_SPLASH=y
> CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR=0x000000
> CONFIG_DRM_CLIENT_SPLASH_SRC_BGRT=y
> CONFIG_DRM_CLIENT_SPLASH_BMP_SUPPORT=y
> CONFIG_DRM_CLIENT_DEFAULT_SPLASH=y
> CONFIG_DRM_CLIENT_DEFAULT="splash"
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> CONFIG_DRM_DISPLAY_HELPER=m
> CONFIG_DRM_DISPLAY_DP_AUX_CHARDEV=y
> CONFIG_DRM_DISPLAY_DP_HELPER=y
> CONFIG_DRM_DISPLAY_DSC_HELPER=y
> CONFIG_DRM_DISPLAY_HDCP_HELPER=y
> CONFIG_DRM_DISPLAY_HDMI_CEC_NOTIFIER_HELPER=y
> CONFIG_DRM_DISPLAY_HDMI_HELPER=y
> CONFIG_DRM_TTM=m
> CONFIG_DRM_EXEC=m
> CONFIG_DRM_BUDDY=m
> CONFIG_DRM_TTM_HELPER=m
> CONFIG_DRM_GEM_SHMEM_HELPER=m
> CONFIG_DRM_SUBALLOC_HELPER=m
> CONFIG_DRM_SCHED=m
> CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS=m
> CONFIG_DRM_PRIVACY_SCREEN=y
> CONFIG_DRM_AMDGPU=m
> CONFIG_DRM_AMDGPU_CIK=y
> CONFIG_DRM_AMDGPU_USERPTR=y
> CONFIG_DRM_AMD_ISP=y
> CONFIG_DRM_AMD_ACP=y
> CONFIG_DRM_AMD_DC=y
> CONFIG_DRM_AMD_DC_FP=y
> CONFIG_DRM_AMD_SECURE_DISPLAY=y
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> CONFIG_DRM_PANEL=y
> CONFIG_DRM_SYSFB_HELPER=m
> CONFIG_DRM_SIMPLEDRM=m
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> CONFIG_DRM_ACCEL=y
> CONFIG_DRM_ACCEL_AMDXDNA=m
> CONFIG_DRM_ACCEL_HABANALABS=m
> CONFIG_DRM_ACCEL_IVPU=m
> CONFIG_DRM_ACCEL_QAIC=m
> ❮ grep BGRT .config
> CONFIG_ACPI_BGRT=y
> CONFIG_DRM_CLIENT_SPLASH_SRC_BGRT=y
>

Regards,
Francesco

---
 drivers/firmware/efi/efi-bgrt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index 1da451582812..4ca06ed5d6f5 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -17,7 +17,10 @@
 #include <linux/efi-bgrt.h>
 
 struct acpi_table_bgrt bgrt_tab;
+EXPORT_SYMBOL(bgrt_tab);
+
 size_t bgrt_image_size;
+EXPORT_SYMBOL(bgrt_image_size);
 
 struct bmp_header {
        u16 id;
--

