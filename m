Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF8CC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E5D710E323;
	Thu, 16 Jul 2026 10:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MdFqDd6x";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B654110E323
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784197789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ofRORFIvXf2fpwqJcpHvsjRV8rnnHpN0JGyGgGcZ0Og=;
 b=MdFqDd6x7eyUv5GnbtMFznfhmWLY5jMZT7ijMMle0+cKHFlX3FqXvdYt8o+rmSpr3J2iyU
 OqR8eVhSI3yNtn9dY5xcfqGweRlsiCXEdNx2v3LTExnuesRCEx11vRCZ0wMmMsCkqS059K
 10bHe3ANqKawfKUznHv96OGWq6yGoo0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-myq3hskPPE2vzZDP4cTZeg-1; Thu, 16 Jul 2026 06:29:48 -0400
X-MC-Unique: myq3hskPPE2vzZDP4cTZeg-1
X-Mimecast-MFC-AGG-ID: myq3hskPPE2vzZDP4cTZeg_1784197787
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493dc8408fdso24752375e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 03:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784197787; x=1784802587;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ofRORFIvXf2fpwqJcpHvsjRV8rnnHpN0JGyGgGcZ0Og=;
 b=OEu/P5BW2zCU/Os/AeXbyRoKfoqOEl/crUPi/shxUNIx8ej8UrqRvxTDOiVfj8y+Oj
 LP+HwDSBBemNMryiPaVarF9d8orRnST2EPFiU5FDwLkNr/2bODXuXtiyDHzTn7kZpGWr
 6VMHniDWVq4KKmZ7EPEKR/FO/4v5m0RD/m0+IXNUmAnsATzj5GsV7UfzlHcFn3D51a5s
 T9rfRJcJIONGC6AmUVL35l6Q2LxwQ0exG+72K1i4gG3iG3CV9dgN1fueApYK2uQEMxQp
 wslDMVaEie1xv7dS69cj8TvAo3tVsDISSuqpE4gvM+g8gNnxWGrcDX08F5JVuD4BfGqO
 fIXQ==
X-Gm-Message-State: AOJu0YxkRaKeEoK3m+Ij9UnXx1qfmFSRjBBrnt2W4qd21fUq1Qio0YO6
 +NLJir7zULFx1NeePTjnmeNP5Xhq1v8sE8aDTeT400Jw0eV+xQYcQpAfe21L4W5PjL8ysVW4Hov
 yvCTCX2fBP6KND3GubUTd4CFzf0fqCPSvg2c5t+P5UbymSE0bxKcDSzZufmOgAdxQ4SUthA==
X-Gm-Gg: AfdE7cl97UbfjfcA+Z6JHDa7skLTmLOmVRTOXvHGyBwJK+SfedHi1GkjgiuqXBPV5uj
 nU92ai6rpsKsiu+UqgX688QEuRDeVXi8tI9vKwuq9Gf4xctIcM63tNy2e6PmZTsV7xxAYBSW5LC
 CwZ+9vzgI2co9EBOTrwLwti6KdBxbqqUhgVcHm8hiMLJ79cXxSYE/evnXxLeWTLQD6/I4hyMu4a
 MASQKmo5puvA9SbOGL8oAOQ2DBJNP5J+TWPwfsF223DvU2zXrJ9/d+NH2zU+XUxUre4GPrg9imt
 7M3CFRRY6nv3kclvoV0jmZEe0wnatBTcq3ndSontsCrwtouVzNqkiUp3Cr6wJ2HFrFp5amkrKFx
 mDRfPedSdj8YqJaV35ZcAlPA0knITnYDYHurv8SeMz/LH0X8e2lXorGE8NYg=
X-Received: by 2002:a05:600c:354e:b0:493:e38b:182d with SMTP id
 5b1f17b1804b1-493f881800dmr235751595e9.22.1784197786932; 
 Thu, 16 Jul 2026 03:29:46 -0700 (PDT)
X-Received: by 2002:a05:600c:354e:b0:493:e38b:182d with SMTP id
 5b1f17b1804b1-493f881800dmr235751215e9.22.1784197786451; 
 Thu, 16 Jul 2026 03:29:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e9a7bbsm48296375e9.13.2026.07.16.03.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 03:29:45 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 08/60] drm/ssd130x: Convert to atomic_create_state
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-8-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-8-302d986fe5f0@kernel.org>
Date: Thu, 16 Jul 2026 12:29:44 +0200
Message-ID: <87v7afrzvr.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TqmxtYUnRkvd3ob60y_yL6wQNO8_v68KEBnBxzXDM3I_1784197787
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

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

Thanks for your patch.

> The plane reset implementation creates a custom state subclass, but
> only initializes a pristine state without resetting any hardware. This
> is equivalent to what atomic_create_state expects. Convert to it.
>
> The conversion was done using the following Coccinelle semantic patch:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

