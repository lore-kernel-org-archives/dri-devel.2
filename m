Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90FA606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GRTViG4X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C6A10E5A1;
	Tue, 17 Nov 2026 22:47:01 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6944210E6E6
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:46:54 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-94961d90b79so47861385a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:46:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794955613; cv=none;
 d=google.com; s=arc-20260327;
 b=X5eQdKv2iwpChFeTI3f3JRPjRAjcFzd7hriFN0HTMg4j+/YbcgfJ5Taii7UdFFGoNE
 kYgo/wVNpL3WqfywtoTIdY35Qiz7C2aAWTPmNfeCKKoqDhFNDom7Wkzc6mx5PlyZsdFE
 /ZPqf6usPBtSDewk6h4770atKZBBknMWHNDFzoyj7uJE6K2eCqPqXwAPc2J3t+nxsMqe
 ZTZWS36qckILJ1ZXxBnvqrOMoD2gmMBEZMvRrUjRSoJjA7EZaoDCfbL6y5knPfYNp+1m
 oUlZFPAYxyiPefyPOmJjVocxPm39MrEq3PAfPDS58C/ePssXQvm6Dtsd69hBUpxIdm7V
 xz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1hZsbSvYzSmLFEJ0qev10mPTktbA5RBsuqmPE4u2bw8=;
 fh=4HMa91NSKypt3IudI2qckY7vMyW9PmFGGHh0Q5BCq1s=;
 b=eAtWaL9D/RvcmSGhs3CDGt96Ne5qURziEal3juA9euxe3kkGLvTg8UygEt8puUfmNK
 qshqwetwDfh/E0G/s4Uapgs+T5gJewJnHTJJn0nJhOm8UbJ1ZQU6gDm//zBnUy8g4z6K
 Am8kdwQrYGybOzLkC1FT1zteJNVJEStr9ejxe9/NL8h36QYbaedjMZlbadFL+U1QDE4t
 NfpSgyzyZxypqUvrAqFGYvRd8RI8cYvPEpgNMwEqpDDB/V/S5xYORDCN7Tv0ypSqzS+S
 njRwDC8DipiaXO2hikxwAL/rFSFKV4xbkVxhC5m1ea9SmxSkGQwtpbWBaQ5kMgOw+zSi
 /jfA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794955613; x=1795560413; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1hZsbSvYzSmLFEJ0qev10mPTktbA5RBsuqmPE4u2bw8=;
 b=GRTViG4XW4DKST+v1I1ccgQX8EzmvWy6L+IgBVfHvmCb6CS4NPTZr89lVbhDc11IZE
 FGgDFmDAu4aLE4/jXGWibQlGadEOlm/sysGqR2/n+nI7VEi8KLwSBmGewVM+vgbXfsf9
 AapygQRSyo5j4Kj27dzyQt/lFsiVhAdnkWS6QDpxFB2AehzIRTUCW/znO9onEYYVy+kf
 Edw2EVJMz7tPT8fKmInFdG+nq5tkKJe2B8aPaqFYPYaLLosmCQ4B74tqZMd6AG1949th
 2HOvhEs8o0tFBrcGYYbHhnhov4TnY9mOj8pCAmkvhfqT4vxFYE3LmE5Oqqr3JsC2JfoJ
 CeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794955613; x=1795560413;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1hZsbSvYzSmLFEJ0qev10mPTktbA5RBsuqmPE4u2bw8=;
 b=M7dtWjTYiqWA6Tjy5RtAn9xtmnkgxbfeevPeQ4q4H1YIIZ0ZgFTgl8ddn6ATJjmYNW
 nU6DJlBJa9xPO4m+xRv2LbBauO9OThBWxt2jcTt/H7XiEhrgRuJ+EhQ71sA1MOyrfERg
 mZhk5e4A4ZOv5uDYHNM/2FSbeTBbXITVnIgD7BiC1aMiGZ0tDUUwGLL/LZdApSEf/qAe
 N7DdwUMp7GFWulbqDVBi9UiwhkP3HQF5i26lrp3bl8hoePlizZfJMpCeG/rCVXTqwXMB
 b4R8XShIGe1i5yeVZ30qycORRx1O6/m4whkINFaTtRXCF+S08jHUMf7mSQwK+FORxMYZ
 +6sQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEgigpNWoZgfwQNj/cMCVLIg1cSjxpg7E9lezMSQ3rSwYI9F7NdefG98Ef8AWIPMe6e//tXdOqdvnY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/msdIEPSHedfmaKqAkZCDeG+DAZ4HElgvyyH//LfDj/hAMoyDT
 BtKoof5upXljNPEzeT98zIFdgLEN3npBqjLNXm82seN50giiz193CSUv+QpgDH76KS02PGUkmZH
 HKWoJMg2aZEx50oCNU16ZvWZxriKjfBk=
X-Gm-Gg: AYBFou24M+eZ6DsLW5MChlHh0BFsF8LZ77GS83h2oz5K86GMvz/YWDBlQmvGOAzmJbs
 0oT7jIIhT1QmSyDIOgMMvMJ/J2elzgARy36CopCDaL9mT3cX3ScZAb/k87eiidvMpovuIIwL/RQ
 sM3F5GJfkzGIM3/xOLu+Y2HsFs8fuCOR14QDtSKtGnkat3wJKt+Eq1AvzozhI4RhGPsaYalph7f
 YW3/maFkETinD0ksUNYENpbQXcfjdzMcK7A6Cv4vuR0CjzxuAjwK8ZjhGjkZGq6MFxTW2BBJSA4
 tePO39fSeAohRx4LfqprpEwBTNERZS8hMmXKagYzYHE/TuyqW2kcxv9CQ5gM2H9myw7LkzDThC/
 8P8QZfQnG28BsDgZUgkSXbiGwyZ5avSMxw5lrGYUKY62Frbkxkx1b+IIZoUAdD1f75bcgpEaHRm
 0Ngu6Z6JbaCs53sBfyT5Xw6Q==
X-Received: by 2002:a05:620a:8005:b0:944:941:c060 with SMTP id
 af79cd13be357-9499957e979mr176328385a.15.1794955613294; Tue, 17 Nov 2026
 14:46:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
 <20261117-prt-explicit-sync-v2-9-bb3851cb6a0c@pixelcluster.dev>
In-Reply-To: <20261117-prt-explicit-sync-v2-9-bb3851cb6a0c@pixelcluster.dev>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 18 Nov 2026 08:46:41 +1000
X-Gm-Features: AclHuK_8M3T-tzOgRWG-WLJiHvR1_KsaG1vlYb1skLjroWFOoHVsoG0QIuOvmDM
Message-ID: <CAPM=9tzeLEgavoAwjp2H0Y55STxRr6P8_LHHM5YWLkr9qJ2Lwg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] drm/amdgpu: Add new AMDGPU_GEM_VA2 ioctl
To: Natalie Vock <nat@pixelcluster.dev>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 at 22:50, Natalie Vock <nat@pixelcluster.dev> wrote:
>
> This new ioctl is a modernized version of AMDGPU_GEM_VA, with the
> main changes being support for many operations batched in one ioctl,
> and a better sync model that allows passing multiple syncobjs for
> both wait and signal. Timeline syncobj are now properly supported in
> both wait and signal cases.
>
> One breaking change compared to AMDGPU_GEM_VA is that
> synchronization is now explicit (where possible), meaning that
> previous submissions are not necessarily waited on.
>
> Using this ioctl allows applications that hammer lots of sparse
> operations, particularly some games running under Proton, to see
> significant reductions in stuttering.
>
> Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 348 +++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   2 +
>  include/uapi/drm/amdgpu_drm.h           |  46 +++++
>  4 files changed, 396 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 72b3710462824..188c8ec234c02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3124,7 +3124,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -       DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW)
> +       DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA2, amdgpu_gem_va2_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };

Can we just call it VM_BIND for consistency with xe and nouveau?

Ideally of course we'd use gpuvm for amd, but even without that it
would be good to at least have somewhat consistent naming just so
grepping find things.

Dave.
