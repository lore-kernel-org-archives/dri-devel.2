Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53F6606A337
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ILAXrLxL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC54310E1C1;
	Thu,  5 Nov 2026 15:56:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBE110E2DB
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793894202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/DjCBAZ71M2O4y+3ispRPpGuYiD1idnBkd3G3TD4EVc=;
 b=ILAXrLxLBHW/SrORipj2/FsCVsTlvNYBMq4RzGxmOijugQFLyMa7dlv5r2PlLjP+0fW7Xh
 2evNlAuUp4bIyrg4jIxwHkBZdGN4kJrfqO5KA6tL7DRyM3E7K0VSvdWWdnVSEyndLyj5Ts
 5+TFHm2SkYWBY1vfnq6ifvt6Mq8I3X4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-NQMNDgwDPLifskD-H-O18w-1; Thu, 05 Nov 2026 10:56:40 -0500
X-MC-Unique: NQMNDgwDPLifskD-H-O18w-1
X-Mimecast-MFC-AGG-ID: NQMNDgwDPLifskD-H-O18w_1793894200
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso22835375e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 07:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894199; x=1794498999;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/DjCBAZ71M2O4y+3ispRPpGuYiD1idnBkd3G3TD4EVc=;
 b=XIHXAIEKiPu313mm0F2oKoO+swina3yfGGkXDhHA/mycivJr5DEuHibBPDCzHp4pV2
 2pCbERZPusRk/MZDSFuDQY0jFwtBbQRc0EZfTSPc6eDWG2oZOWF2gLPpgYido0TtGEfW
 b+tPSz9211XXF6jW3bsnOiWDWYV8OtJ3qMAm7BtU2pgi8MyfClQvMOYhB0ymqqF9Lze9
 Ar6wezZajy1/sTdWqtHCQcyTQPrjd1gqQw5ysTG2dfVPCCIDwPuzCHKT+lJsqBvDtMo1
 zSbvWhZiX9Ic0JGwzSjWSPxgSHZta+AP2PM6BI2HfLfw49kMH5mGM7A698QhIpn4o2lD
 dOYA==
X-Forwarded-Encrypted: i=1;
 AKwUvByWf/38SP6TF+UUtTHjCt0owcDhqOEqG9CEJcXa9L8OozRW3y45lclBEPRtdfH7gFMMCL0Kv8llTtI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+kDCV5xc8/BpzYYLFOpn5ypIoO92LmcAaRaeKjxcYpyZI01XjG
 ay3IiS82q7XwMcAQdHadufE2QFSnKCtn9WFCyVmCCoIHjFE6YHUC0KiGC6jBLxkVCgLlhy+jrxX
 Z/p3PNZSDRgzI1llFEZKpvzpVeWhMm4fI88Ef6UF+GP0k8D3qkSleJBtIz1l+FmevEUApGQ==
X-Gm-Gg: AYBFou0T1+O+GnBXDLOv/J49VXmudQWQ44WG8ryKepDpzYkamkcgvw6bBDU6r0t0CAV
 fCTY4T/ytJpSCB/VbXqQMnG5eAgkwXhNm2yPzdUP5Pmm5cqOPeF3NFiBsbtIkN7mldMcTNZUe9j
 OsgqTYNAhLP8Yc7AboDjszdc2bh6QslIBxI1nmL2S/fCUMRovekBTXbk26/fZ1EW6TteLssWAJB
 7xv/b7/DCFtJCy9qCCzNeQm8UzJZRaujqon4QMyuzFfBCUoSQ1xeC8ZjYzBbaTH0m8QcZB0tShF
 XukWIGqmLSAaOqP4HXNfvhf0jsMJw9GAFs8l/alan+vO0LdQ5KH8CuanJUOxVbzAEvkCCklVhfI
 zmyts+Zu3V00294gOjFxuwFM8n3wXSkT0mccLiOW1wTGUha3Itp3UU71Isi32oFXfVBBk6oroZT
 gPr+KCqsOGyeGCbSGTJx+hMdd976vtpUCqDHZvoz0=
X-Received: by 2002:a05:600c:1d29:b0:4a5:5fb9:5d35 with SMTP id
 5b1f17b1804b1-4ac187a7678mr457976425e9.21.1793894199429; 
 Thu, 05 Nov 2026 07:56:39 -0800 (PST)
X-Received: by 2002:a05:600c:1d29:b0:4a5:5fb9:5d35 with SMTP id
 5b1f17b1804b1-4ac187a7678mr457976045e9.21.1793894198957; 
 Thu, 05 Nov 2026 07:56:38 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4533873f0sm146490745e9.4.2026.11.05.07.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:56:38 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter
 <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND 50/83] drm/ofdrm: Switch to
 drm_mode_config_create_initial_state
In-Reply-To: <20261105-drm-no-more-config-reset-v1-50-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-50-1f58d1e33380@kernel.org>
Date: Thu, 05 Nov 2026 16:56:37 +0100
Message-ID: <xlv11p8zff0q.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0aDGSUmg_bniDxZVTs2oCls_N908k1-1hHjKha22CE8_1793894200
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
>  drivers/gpu/drm/sysfb/ofdrm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

