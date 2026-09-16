Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57082C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8564310E13C;
	Wed, 16 Sep 2026 07:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RGB3N3Ll";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528ED10E13C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 07:45:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73DA86020C;
 Wed, 16 Sep 2026 07:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87FE1F00893;
 Wed, 16 Sep 2026 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789544701;
 bh=08F4O+RO9ORg2zuhs+gAiJPHqJbu9dHxGFqMoLqkFm0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RGB3N3Ll6gBZQOGKsJ65KjPTSA9Wr0VdCm331Fbfx7kG53RLHxxP+by2lBRUrveay
 gZLolz21uwY3Cyotq4Ua7qr5vQCAKXZfCR+MHGC75nyjuscZHAUVQc0RJDZYSXolSU
 fkWTDnMk4Hu2j4Ynna1SV44bTht+1eZetHDGxVLH0xwTrtYSIpbyWM5Ufr67mUCKkJ
 xTrU6HekuzbXL6D8dB4CcQIDoWJWMu/h87FK3+0v7sCN+MhSUADeFU4AB37mbu6iS0
 ZOpGUFcFTTceG725OVjs+W3xoBRHcAtBH2gY/mOF96CiLmZ+dQ8ZFIq0TVL2yBqH2G
 dun2T4Pjip/Ow==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Hans de Goede <hansg@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v5 00/11] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
Date: Wed, 16 Sep 2026 09:44:55 +0200
Message-ID: <178954469112.2840604.11490977238691570475.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
References: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Tue, 15 Sep 2026 16:24:41 +0200, Maxime Ripard wrote:
> This is a follow-up to the plane reset removal series, and part of a
> larger effort to remove the reset hook from all KMS objects.
> 
> The CRTC reset hook is overloaded: it is called both at probe time to
> create the initial software state and during suspend/resume to reset
> hardware and software state. These two roles have different
> requirements, and the reset hook is not fallible, making error
> handling difficult for the initial state allocation path.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[01/11] drm/arcgpu: Switch to drm_atomic_helper_crtc_create_state
        commit: 36323b4a23282fc74aea73b5d3570c113fae431e
[02/11] drm/aspeed: Switch to drm_atomic_helper_crtc_create_state
        commit: 0e82728b3f48162cbc1ed1bae708dfcdb1a22879
[03/11] drm/gm12u320: Switch to drm_atomic_helper_crtc_create_state
        commit: 85be9cba55299acf49faf6a98a0e03e5e8b3a105
[04/11] drm/mcde: Switch to drm_atomic_helper_crtc_create_state
        commit: d7f9bde13c54070ec5b091baf361009dd884f8c7
[05/11] drm/pl111: Switch to drm_atomic_helper_crtc_create_state
        commit: f14ba2463aca5b179409a99f3c824c28ee71daab
[06/11] drm/repaper: Switch to drm_atomic_helper_crtc_create_state
        commit: 0d3b9d5604d1d18ea0946cf694e7c045b8ef8e94
[07/11] drm/tve200: Switch to drm_atomic_helper_crtc_create_state
        commit: bfcf0fec178ea9c8a9bec73130b4ea8e510e5583
[08/11] drm/xen: Switch to drm_atomic_helper_crtc_create_state
        commit: c4967fd8b43e5b44386e8a3feecab89eacb398d9
[09/11] drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
        commit: 5354d1e5fba4753efc4e5e27e671de5febc21ec0
[10/11] drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset
        commit: 9ea7393511e139c24d6b5d7edcbb39b5a4c10a61
[11/11] drm/crtc: Remove reset
        commit: f1bcb90506a9a6be4d44dc85034f8acc48a49c29

Thanks!
Maxime
