Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CCA606BEB8
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DiEm1IqC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79ABB112817;
	Thu,  5 Nov 2026 15:54:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD89112844
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793894046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2AwBFO4JiuQ/FV/CMMmSCfjX/nAyzoMuTgXb5GZYKk=;
 b=DiEm1IqCduuxsASljcGOHWcflxcGDxqiAJ5+ODur+IEKDuxgZ0OG2t1JuAY8aS+zGcr1vj
 L/2K3beTMVRS9bSoXVTPVwe8baiSwHigJdn0mlv8AeQ3YeBoCBjPFTGWhlVrjQlpn8slCT
 SazYVMBsKik2fNBfTpnBqe+AIHaXti0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-ZP6qX1ZjMJWnHGVj_ks8JA-1; Thu, 05 Nov 2026 10:54:03 -0500
X-MC-Unique: ZP6qX1ZjMJWnHGVj_ks8JA-1
X-Mimecast-MFC-AGG-ID: ZP6qX1ZjMJWnHGVj_ks8JA_1793894042
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a2065a2ef9so19217025e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 07:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894042; x=1794498842;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e2AwBFO4JiuQ/FV/CMMmSCfjX/nAyzoMuTgXb5GZYKk=;
 b=Ens9Ws1bDi9FtV8H3lmNl1xXLPWuZOgMx/LUE2V08cQVi+kBASJIwKGpVDowqtLv4M
 +B0uibWEwfRtQgTWi/KcU6o8uOdL7/LOR3DZHy/vA/7861HsZrTt6HuUSE9Ehp13zzF0
 eNCx5paRt/mxKoZVU1lPo+R9FqkxQwOsE3iruJOrsR/DR8ByfqIoyW/auUNY/Eia8eJH
 NNgl8m/yq5+wbFMURPRHvYzN8+DV/TEpMGnhD1ugjWF5e7ORu5cZTlO8EN/aecDVVcU+
 fx690xxSqRD4WItBCXp6QiBn3sVZWZZDHeD33ziHgfkp/CUxuAeUg4mBBCXgt1fh1IJ9
 RcVw==
X-Forwarded-Encrypted: i=1;
 AKwUvByhQ0VdAKi4v44uQCCknesR2M2Lv0Tt9Z1jDuokTyV7R0uYOupkZpv+N/TbC+mLj1hDaRU3F7RmvC4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/XTbSG8OmzgMPvNxjJ8mjspUFV0T6oDiNYnRd8/kAZE42tbcrk
 vgq2qhUISFV1aZ4KA1+A0769lvL1MDrGVxC/wLo8IYbR5EkKuFAz+NzjQVC30SuWyhHY7NXhtHK
 /cMGbVWlURt3wBPB6bE0VtVQjk0DZbE6nmrzkuufP/7rugLicv0T7nD7fvuxydD/PLlVnzA==
X-Gm-Gg: AYBFou1w5w839mDC59NqIdmHtnWPYu5MpdreohcHtaAzs0+OtBpbRpYQGJ6wmi5WPkh
 R4fZGRTBnnuihYwjGDhBaUBgTmHJt0Z7RclRxYdR7D4rl1BDmXpICZZv5n9dzjI8IaM7EgF9szT
 TXZO+IWeFJh8iGLPCLaryiMN++s0pPElSyrzZ6rvP6JV49qr0sxjeb9Xz32oa09e5mTzcRMnsZX
 Wr5qDbz+D9RjNfaMJ9/NEWJjrlhx8AKBaHXJ2qiHbKUPf3ZUdA2NFYsgkDRodyULoiySc1du9vx
 iMth/HtQvAsZPIe+AIY0yZKxy4q1ZIZEbGPucvOLOzDYJgXE/lE8oczt6wdK7N+JJ/FHY8c0sUF
 sJADTyWEl1xMvCVbyW32pVtYsx+8z+E4Pfkxj6hKDf2dYMiaSxTpAHS+cyDqJL6EERj4hoVYg5o
 U6RZgVLok7m/VMES/r2GBFp2xP4g5OHpx/rS7q6KY=
X-Received: by 2002:a05:600c:8b66:b0:4a3:5a91:5f61 with SMTP id
 5b1f17b1804b1-4ac1793f8ddmr447891865e9.14.1793894041680; 
 Thu, 05 Nov 2026 07:54:01 -0800 (PST)
X-Received: by 2002:a05:600c:8b66:b0:4a3:5a91:5f61 with SMTP id
 5b1f17b1804b1-4ac1793f8ddmr447891245e9.14.1793894041029; 
 Thu, 05 Nov 2026 07:54:01 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e58fcc6sm136078815e9.2.2026.11.05.07.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:53:59 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter
 <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND 43/83] drm/ssd130x: Switch to
 drm_mode_config_create_initial_state
In-Reply-To: <20261105-drm-no-more-config-reset-v1-43-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-43-1f58d1e33380@kernel.org>
Date: Thu, 05 Nov 2026 16:53:59 +0100
Message-ID: <xlv1a4nnff54.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FbGHBKKwb6wSuqyt4lzmQQvXjB4w8VdeJuzd6oXOsgY_1793894042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Maxime Ripard <mripard@kernel.org> writes:

> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>
> Switch to drm_mode_config_create_initial_state().
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

