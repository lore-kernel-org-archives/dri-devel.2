Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1E606A6B5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=cIshJhwD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 327F910E6B7;
	Fri, 20 Nov 2026 20:58:03 +0000 (UTC)
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com
 [165.173.182.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC29E10E6B7;
 Fri, 20 Nov 2026 20:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795208272; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MNJOx8tZxvWSrqSIVQfcCY3UygmScJycKjInx52Iu7xc1lGJX4iUIKf1/vdB/glMbELOd4HX2n+gXdNywq0nzmtyeZ2S4OWdeonUKGyrG3lu+LRQeqXQnXbylEtFb+y37DqCUz6B3aQRVI+KBg6rc+82JENxKYl9oKLeYg9gtkw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795208272;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=+jrSQBlE/7LeuSSURWGNRbL9ee6NMmTf4Eyvavv2h3o=; 
 b=mjpuWmLANXf8FNcgYdxS9IVD2M/CmIsGoIzjJcpALWVOawZ3X05yuUhHqFvPoa77/VdbHubBkEPR+N9vnk5vSWG3T+49ibVjk5184WRSUzBDngGLfNF812AGDaP3jqR/XJr4ppqDlTEVUcU3KzxoD6ZLOpttRLFKP/84s+qS0fc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=cIshJhwDkvinZkmQQvnYiUNMr9JOEOR/Fr/w9y+Q50EflImyHSVmqhjMzhK2uayV9knldH7Z9PKlzuGa8KYbpUr60Pcb3yeaTxOjYPW5SpyTFr48Ktro2Cho8EvP1e9FkuiMD4B8v+ZfCCn2iu8EUVZ8U7Y3B0s+MpglQ55HECM=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=+jrSQBlE/7LeuSSURWGNRbL9ee6NMmTf4Eyvavv2h3o=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795208270460676.7972250834318;
 Fri, 20 Nov 2026 12:57:50 -0800 (PST)
Message-ID: <35c12a49-294e-4c56-af83-c7bdce56d052@collabora.com>
Date: Fri, 20 Nov 2026 21:57:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] drm/amd/display: Add Gamma 2.4 and 2.6 colorop
 support
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20261119195158.2546927-1-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20261119195158.2546927-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks a lot!

I added the patches to my kernel branch at 
https://gitlab.com/rmader/linux/-/tree/testing-post-blend-2026-11-20 [1] 
and tested it with my Weston test branch for the post-blend pipeline 
(https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2157). I 
can confirm it works on AMD for SDR video playback - below is some DRM 
debug output confirming the Gamma 2.4 -> Gamma 2.2 Inverse use we'd 
expect. The kernel and Weston branches further add and use gamma 2.4 on 
VKMS, successfully comparing the output to the GL renderer.

Thus the the whole series is:

Tested-by: Robert Mader <robert.mader@collabora.com>

Best regards,

Robert

[atomic] drmModeAtomicCommit
     [repaint] Using plane-only state composition
     [repaint] paint node 0:4-2-1 on primary plane 224
     [repaint] paint node 0:4-1-1 using renderer composition
     [repaint] paint node 0:comp-3-1 using renderer composition
     [repaint] paint node 0:2-1-1 using renderer composition
     [repaint] paint node 0:2-2-1 using renderer composition
         [atomic] applying output 0 (eDP-1) state
             [CRTC:411] MODE_ID (24) -> 1920x1200@60.001Hz (0x248)
             [CRTC:411] ACTIVE (23) -> 1 (0x1)
             [COLOROP:412] BYPASS (414) -> 1 (0x1)
             [COLOROP:417] BYPASS (419) -> 0 (0x0)
             [COLOROP:417] CURVE_1D_TYPE (421) -> Gamma 2.2 Inverse (0x7)
             [COLOROP:422] BYPASS (424) -> 1 (0x1)
             [CRTC:411] COLOR_PIPELINE (429) -> 412 (0x19c)
             [CRTC:411] VRR_ENABLED (25) -> 0 (0x0)
             [CONN:503] CRTC_ID (21) -> 411 (0x19b)
             [CONN:503] Content Protection (508) -> Undesired (0x0)
             [CONN:503] HDCP Content Type (509) -> HDCP Type0 (0x0)
             [CONN:503] HDR_OUTPUT_METADATA (8) -> 0 (0x0)
             [CONN:503] max bpc (504) -> 16 (0x10)
             [CONN:503] Colorspace (505) -> Default (0x0)
             [CONN:503] underscan (38) -> off (0x0)
             [CONN:503] underscan hborder (39) -> 0 (0x0)
             [CONN:503] underscan vborder (40) -> 0 (0x0)
             [CONN:503] color format (507) -> AUTO (0x0)
             [PLANE:224 pri] FB_ID (18) -> 586 (0x24a)
             [PLANE:224 pri] CRTC_ID (21) -> 411 (0x19b)
             [PLANE:224 pri] SRC_X (10) -> 0.00 (0x0)
             [PLANE:224 pri] SRC_Y (11) -> 0.00 (0x0)
             [PLANE:224 pri] SRC_W (12) -> 3840.00 (0xf000000)
             [PLANE:224 pri] SRC_H (13) -> 2160.00 (0x8700000)
             [PLANE:224 pri] CRTC_X (14) -> 0 (0x0)
             [PLANE:224 pri] CRTC_Y (15) -> 60 (0x3c)
             [PLANE:224 pri] CRTC_W (16) -> 1920 (0x780)
             [PLANE:224 pri] CRTC_H (17) -> 1080 (0x438)
             [PLANE:224 pri] FB_DAMAGE_CLIPS (22) -> 0 (0x0)
             [COLOROP:232] BYPASS (234) -> 0 (0x0)
             [COLOROP:232] FIXED_MATRIX_TYPE (236) -> YCbCr 709 Limited 
to RGB (0x3)
             [COLOROP:237] BYPASS (239) -> 0 (0x0)
             [COLOROP:237] CURVE_1D_TYPE (241) -> Gamma 2.4 (0x8)
             [COLOROP:242] BYPASS (244) -> 1 (0x1)
             [COLOROP:247] BYPASS (249) -> 1 (0x1)
             [COLOROP:252] BYPASS (254) -> 1 (0x1)
             [COLOROP:257] BYPASS (259) -> 1 (0x1)
             [COLOROP:264] BYPASS (266) -> 1 (0x1)
             [COLOROP:271] BYPASS (273) -> 1 (0x1)
             [COLOROP:276] BYPASS (278) -> 1 (0x1)
             [PLANE:224 pri] COLOR_PIPELINE (283) -> 232 (0xe8)
             [PLANE:224] FORMAT: NV12 MODIFIER: 
AMD_GFX11,64KB_R_X,PIPE_XOR_BITS=2,PACKERS=2 (0x200000010401b04)
             [PLANE:224 pri] rotation (231) -> 1 (0x1)
             [PLANE:224 pri] pixel blend mode (227) -> None (0x2)

1: A heavily rebased version of Melissas branch from 
https://gitlab.freedesktop.org/mwen/drm-misc/-/commits/gamescope_pipeline_w_colorop

On 19.11.26 20:51, Harry Wentland wrote:
> Mutter needs a pure 2.4 power curve. The color pipeline only has 2.2.
> This series adds 2.4, and 2.6 for completeness.
>
> Tested on Navi 48.
>
> IGT patches for the Gamma 2.4 and 2.6 tests are on the igt-dev mailing
> list.
>
> Changes in v2:
> - Put gamma 2.4 and 2.6 on the wide curve in
>    cm_helper_translate_curve_to_hw_format() as well (Sashiko).
>
> Harry Wentland (4):
>    drm/colorop: Define Gamma 2.4 and 2.6 and its Inverse
>    drm/amd/display: Use the wide curve for gamma 2.4 and 2.6
>    drm/amd/display: Add support for 2.4 and 2.6 Gamma and its Inverse
>    drm/amd/display: Add KUnit cases for gamma 2.4 and 2.6 colorops
>
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  6 +++
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 12 +++--
>   .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 18 +++++++
>   .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 54 +++++++++++++++++--
>   .../amd/display/dc/dcn10/dcn10_cm_common.c    |  4 +-
>   .../amd/display/dc/dcn30/dcn30_cm_common.c    |  2 +
>   drivers/gpu/drm/drm_colorop.c                 |  4 ++
>   include/drm/drm_colorop.h                     | 39 ++++++++++++++
>   8 files changed, 132 insertions(+), 7 deletions(-)
>
-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

