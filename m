Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F98960726AC
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d9p/C4gF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 697FA11291B;
	Thu,  5 Nov 2026 15:57:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5429E10E03B
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793894221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1+mN0RnHyyW/Kk8WOT8k8frVguueOGkksvB+nVa7Ms=;
 b=d9p/C4gF3uLx882nsvpXmIYzrVLTSqV3VQMbQatGK5WxuCI93eij7mYFt1xN5mQ66xNvkB
 v3GyT9QCyIQ3oOe+uv0QqD6T2xoIkNQHEVYTJjCcK4xcIuf47ew82/itYPzdI5enmFMWpq
 oKupWXtJRrvARUz4HSZsCHo+Fn4BFpk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-Ld8RBX-BOlCC742hjofxlQ-1; Thu, 05 Nov 2026 10:56:57 -0500
X-MC-Unique: Ld8RBX-BOlCC742hjofxlQ-1
X-Mimecast-MFC-AGG-ID: Ld8RBX-BOlCC742hjofxlQ_1793894216
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48c430f0f01so1655015f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 07:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894216; x=1794499016;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i1+mN0RnHyyW/Kk8WOT8k8frVguueOGkksvB+nVa7Ms=;
 b=Gh8f1adel4bfu7Acp7HLKdMyePm5Z5184kaO+w2IU4fm8lqt122SygReDNNcyZP2Xo
 y8qBWAPXyDBdS1EpFleRIWUx5/FEHKZCDuNlYPI+VMhc8sG1l/lHGHndzUwGuFpUSbVa
 j084GReHhYPJ8gPgMirvohWyddZqyESfsEewcQ5AjT9RsvuBAyiVcePO/a5E74O8G3YR
 GAzkMBe45gb8pQdWxT03oBoN/BaQGi2778sMptNcqamNRX45QmLnSy0iB+it/2IWhYAA
 iVjYsihGpQr3NoLwU5NoY5VEOtYSTlcOVlkudCMa4jBUt5rjoKDuH0G7KG3bs8o5dmYT
 OmSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3Ya8I4/Io+GuOgUuVcovXMR3TzWY5LgkN9VHH28ZRXc8Liqd9pHQhq8q3rNHPTHEcHrE7m+g1CFs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Q8wqLQ0QhPQC4VIX8ljlZWvi5IkipYyLphFdOOFsfL316goql
 zHS+Ey7DsNRFIu8r/M+3NQ8yxfB6cwDcZJrlcucPSL2V0G2JdmfakcJhCUFLX1NHSSMF8jC6FIc
 J3McWyN6UhNRuKX1+JHIB6p7yENoBhJkx6b99ohAM5HLphPNYUxoNanfB/Xn4QxfLp/FYMw==
X-Gm-Gg: AYBFou3YAjDTy2k090+WcEh7Dkz1mEcnGe9JJ6nUz1grCWi4MdnyD94xR44GkpGVFST
 MsdHHekvBd3B9o2J5eXFiHwzEDR0uUVbXPUfkAuSbDtB4E0lftqdTrUZ152hm0E086J+Tpks+eC
 UNE1SuCyiAs51LdLGEKvWCppyWAhaEl5ySLyi8G+6T0uqXzJajUzCUlIpUtpFaRS86b5jPsUWhy
 Hg4r3y80APiIEgRWXAe+nEgDXJkZpMciRaWOXUy+9+5hQ4heqopfQ8T+BtKbnc01SSd/djoFGrf
 QRC7/zSnscnvvGvGeEy0lpdH4VWGUj6zeIDlTW2DDXkDuX/fseeizFLecPbltIgA+3IWEanR20g
 iRWZAGwG0HqJTzIjwCo1v8zsJymahVDAgPOZJFIYTShQMQV0jzxE1+CxbgWCKSpIfmQPGO4DjCj
 YG21kLtjT+i/7wyLvEGye86rfxltUM8t2OZhX61dM=
X-Received: by 2002:a05:600c:1f93:b0:4a5:75d2:c104 with SMTP id
 5b1f17b1804b1-4ac17ffa050mr446172625e9.22.1793894215709; 
 Thu, 05 Nov 2026 07:56:55 -0800 (PST)
X-Received: by 2002:a05:600c:1f93:b0:4a5:75d2:c104 with SMTP id
 5b1f17b1804b1-4ac17ffa050mr446172245e9.22.1793894215260; 
 Thu, 05 Nov 2026 07:56:55 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6af5f0c63sm1031515e9.6.2026.11.05.07.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:56:54 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter
 <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND 51/83] drm/simpledrm: Switch to
 drm_mode_config_create_initial_state
In-Reply-To: <20261105-drm-no-more-config-reset-v1-51-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-51-1f58d1e33380@kernel.org>
Date: Thu, 05 Nov 2026 16:56:53 +0100
Message-ID: <xlv1y0b7e0fu.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YkXILyFM6LJ1H6INgWhjMheYMo_xIIIruXVtGfLKeXE_1793894216
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/gpu/drm/sysfb/simpledrm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

