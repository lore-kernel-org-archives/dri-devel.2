Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962D0CD98D4
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A325D10EDE5;
	Thu, 11 Jun 2026 10:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fWqqg/qE";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E70810EDDA
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781172636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQRyqUjYEtr0y/u9/sXosv9fI09dOaWuwDl+f7MSICU=;
 b=fWqqg/qEEOeBhLTiXQh5WxsmVoRKTGr1GVdI4gJB/RA9tyWt61Ta7r5+D5i885hdF+V7hr
 b/+HE/ZO+JeZQG2lviWKUE/MbIKl66dSoE1DSNNFfYGYdYwL5xSyeSzlkRfNcD7R6XQ/NB
 RjtD+vlnBM15QU09C0/DzgBpVCzYt54=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-1IByu4wcNTeeSG7dhumugg-1; Thu, 11 Jun 2026 06:10:35 -0400
X-MC-Unique: 1IByu4wcNTeeSG7dhumugg-1
X-Mimecast-MFC-AGG-ID: 1IByu4wcNTeeSG7dhumugg_1781172634
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490ae016853so14351495e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 03:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781172634; x=1781777434;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rQRyqUjYEtr0y/u9/sXosv9fI09dOaWuwDl+f7MSICU=;
 b=FsHM8IFOCzd7+9nq4SwTe3tWKTW65mIidMFqi3ekPrPPqH+8/IzUqOAP9IQSaFOi3P
 P0MWzLwKJLVJFajgQPmzSz2xoLLvbrd6AV+flWOpvWaRg8HtkKNmvd80J7Wne1GO6UtO
 zsi6lwmg+N8Glfhgzw3pbnTGGSbNGXdylTn9ekeA4SpBXZrNfandeCnTurgBZbmBWODP
 fw4iIjf8mGl77QreXizTDA4XIm+KqxGRokwLMWDRJc9Rmiq7kkGZmslCpiNN5FvIokuU
 ilySwMQJHnQgepoLBAVQoKhio2otK/gmxTMMi1CmI9jCAMQwEO+HnY+CvRfv7wTaXKWQ
 DPkw==
X-Gm-Message-State: AOJu0Yziu3Frl4dZkUgwLvlxYX857642OnEbv1TvQchtQDj/kwgoP0wF
 oLmMj596EaSe/QPD/+juv2NaUbtEPQxfBut7/1GX/ZHLzhS50cqTzweN07XrUSqdxQ1GavFExTh
 KXYxCVHP5cVuD1ucjM0yRRa9bLM78wBS8J20MwR8rAvDHz+YZw/OUanomj0DHBm8hD3MnrA==
X-Gm-Gg: Acq92OH64zAXY0C+kT/Pt/gq4/KM028Kfbi2DLuMyoUlrkb45fXt6YtDfIIJyhHQ6ub
 mW4jDSSg4/VwsdD8lyAL7hBXZMAb3IcHsT2zbB9sZ5NGDNfJa7ndBBD42gHBQaPz3r756rz+o3G
 eEvxsnhANvsdzYulVcYoWSg6vAwBb/YJDiNjASVDzNgX/bslkDWVGMLw2w5Ty4ohehh+aWlPJg7
 D9o13a7eJX7rxQbv+ImeqKKiTi480L6fXO78I+nxv7MYqt9d12e+R+ehNBZ67bizXsVTwPIFJUP
 r7gknutq2AZgVrk99AQ9PuUQ2mIBRdvXigiFVKi4zYbyIbBOX9uJRU7okcm6VMlj4hXxXCIrdt1
 Pb4cwSGGjGzSD/RxOcDap2Lta0h9AMXIshXXVyisLSqlYix3g3H37HjvV4ZjmVWH2jKJ/9hAfun
 Ezxxla4N4eQxhq1lE=
X-Received: by 2002:a05:600c:4685:b0:490:e1e6:8988 with SMTP id
 5b1f17b1804b1-490e55dc1damr31237555e9.7.1781172633836; 
 Thu, 11 Jun 2026 03:10:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:490:e1e6:8988 with SMTP id
 5b1f17b1804b1-490e55dc1damr31236645e9.7.1781172633469; 
 Thu, 11 Jun 2026 03:10:33 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e52ac9aasm38076025e9.4.2026.06.11.03.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:10:32 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Zack Rusin <zackr@vmware.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 01/15] drm/amd/display: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-2-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-2-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:10:31 +0200
Message-ID: <87y0gl5qw8.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E8Hf15Fj1pEW2FYHmTkVb9vkDxxIIBln8fcYAnFAKLo_1781172634
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update.
>
> Test the flag in DCN code and do a full update in DCN code if it has
> been set.
>
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. This driver does
> not do that, but DRM's damage iterator will soon rely on the flag.
> Therefore supporting it here as well make sense for consistency.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

I don't think that a Fixes tag is correct here? Your patch series
is changing the 'struct drm_plane_state.ignore_damage_clips' and
the changes make sense, but definitely isn't a fix in my opinion.

Having said that, the change look good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

