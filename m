Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D40606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z54wKY6B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0370410F30D;
	Tue, 20 Oct 2026 07:36:51 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172BB10EB66
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 05:10:36 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-705cb6ceebaso1039198eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 22:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792473035; cv=none;
 d=google.com; s=arc-20260327;
 b=PSQq1NnB1oHWY7rFtDaXGQbVGXZVqx7iY19v9gQo+1ssfSWvtMxCRtjP9zOdjuO/6K
 BMVNUA9xFjNdIz4Ucccf0ZvJ/zf2KLtD8jYnsAjMX460FFz1UCC0mRCn7fZGCTLMa6wV
 jSXjuM5BV6F8yibHPes1aPCE5owD2vm/1QXSDJeT3IGLN4Fwqvmr2G9vv8xEsgc1QAVS
 7+uxawiIyXVxOXwwfnVLRRPUl+QgzgSv7iljqExqtBwQnicoKwxkhVes0CyRXds2OubV
 1yYDYAKrVTMeS2q4dxv++IjqWb8YBGF9Rnt9H3qlKlXW2oprHeCkSbaIppwAuMnUPDsk
 +06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GiXfA5+zF0NeMfbHqqL9rF1nabmZUfUnh+LSjoOt3J0=;
 fh=kTOoadgbBmMl+cpfm+UVAwLQbl0FWkSwyTU+bN/a1aU=;
 b=LqrE91qavf2iFfHzMFhT32PV08T3cds+NPEDX9/TN9gpfFHMaiaNDyn7aGXfoaFAxM
 6tgfXsa4ageWlNvL664OcHBKnge0D1g5H7WmzFSP9k5l6r5T4BZzxZzswkAfUbc3TfhI
 uEd/sALoR4lGdiTIdt8yq2iLtfuwJmSwMA8fNP9K5yDyxgwz5USxmGXchUVMSU1RWQuY
 M6bQS4sIPCyuWso43IMLxmwPdCM3Tn3NKRQ2SMyFkXw01prRGh6tcedmRcN4jnFNNJXn
 2gRF3fcayMGfSJuj8gd4FbuHaFIszAYwE5WIYwJdp4L5h6Ne3U0dc/kuRTlWsj+6bybh
 2P2g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792473035; x=1793077835; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GiXfA5+zF0NeMfbHqqL9rF1nabmZUfUnh+LSjoOt3J0=;
 b=Z54wKY6ByzAEshYx2yVpt+bcLwZVeu0QzN/6szHmyLuaGR6Q4IxenSXMmDHeL6k1RL
 GkMGO9doysCZ4nt6CWyRsD5p5HNbaMEpHL29aN2lVD8lE6DYecsZdlo3Jr/fGU8cPGeA
 ceeluTDSLLdXQSZp8uiQStV+3XG0p4IElTCuFzlIDMSgqSg/CmeYnyECnaHYG4VswlTb
 ckSJNd7AaEq1FpbbkfVkoQvZIFJudx9h3l/QgBNSBRt7+I9723tXGeK2sMlljPZvErwe
 5MpggcJxAX1ZLQqZNCmztYQ0qNOiwCAJPl0PYaV8rC58BY/5GM7C44z6h8OPA7qqv1zz
 AD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792473035; x=1793077835;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GiXfA5+zF0NeMfbHqqL9rF1nabmZUfUnh+LSjoOt3J0=;
 b=Eoo1yxZ5kFZqzrxP2wnFSrVoxLhuIdCm/VH8WJTxN6UX2y6ny0UzoBSMuvvGlJYbMR
 xUqnQLQmw7QqcUBX1Mc2sjXOylCZMOBpnyA8QPKdYSPv2dmZHgcIIFR9wD44QkEcG8SY
 TNFOszTR085LiCBBweiSYZd8NePbbFtSUB/Sum/abs89rdsLQiulJyuSRubVrHCMsvzZ
 HEL9FysxFI5BRxDZaZsgJZR9U3oESw1Pu7khQdcHADiKH7wG+2AKHhgge5iOr514ZGf7
 UzQnjVAjbqlXQgC5PgNRsMk6nslodTENF43cuKaY9ZZMJcBiS3ZhfOQO4Q7bJY2zXLZo
 jcPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzy1D/XFjiTMORtC0QSsx7Dl0b7hYh8pQ7n79ok6spNpDoiIHiSfTz4vvlTm1o4x3nJJKeiyT6+/Gw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIkFsA6EIJ0ErgE5yy/eZJDX6bPYGArd1BVnMU0rj1Lop9ELsXs
 dhlYFnC1z3VtqbV5wkrJWvR70KuE3XBcMtzGFRNi/TQH4Ux9dHRl6TAzVg1yhDX6/nZdyRmcfU3
 8MslPoUfWPlKUD4G08czjmZAtLIY2fqY=
X-Gm-Gg: AYBFou1NRjv0R/dx1ZtjD1rwrLpe8wlWCuMTpgKFEDv4ivQi/DuXzcofZAouWF5nHxU
 ESRRDnmqhJvUY2FlNOU972nCZOi260HsjwL7RhaBcTj2wKutrV7AVDBa1q8jSecoz5g8T5V9TdQ
 p/v6QL4dg5Wpir0NvQsOuzdffIAXVJrYmqJIlpZCjpTjzFVI+YGltsOsPstpo/JnUi/z7Ah6syr
 mTmSYzAhpytPcKQQE+d2Go+YFln2lhYsnpPVq2rpO/Kvxl9h8iHZ3+KGtgUf9PBdhj6u2Paf7lS
 bqP8uTWmjQg1w45G+HQe/ReTPgwvLPrZqxrqDNTtpWJRLCZZxaD65NmRXz7ylTZpHH4IL1D8SLL
 Ec+olVNIIWLxtkA==
X-Received: by 2002:a05:6820:808:b0:6f7:384:a09a with SMTP id
 006d021491bc7-7035597fbdbmr6886581eaf.24.1792473035202; Mon, 19 Oct 2026
 22:10:35 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012064334.3193085-1-thnkslprpt@gmail.com>
 <e22eadd0ada0c8243cfdf7829580984fdf897498@intel.com>
In-Reply-To: <e22eadd0ada0c8243cfdf7829580984fdf897498@intel.com>
From: Avi Weiss <thnkslprpt@gmail.com>
Date: Tue, 20 Oct 2026 08:10:23 +0300
X-Gm-Features: AclHuK-p2nWNOpMkyd_0WG7nPltm1YYmadXikekJFIF4kF3fWw5LAI-0mOwxIIM
Message-ID: <CAKOB7-Y0GTen0gYm-m4ixg8RjHuqEHsNgRTM4s3SbLg5J=vM3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: hdmi: free EDID on connector update failure
To: Jani Nikula <jani.nikula@intel.com>
Cc: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jani,
This complicates the if (!drm_edid) a bit further down, so might not
be worth it.
What do you think? Leave it, or should I try to rework it?
Cheers,
Avi


On Mon, 19 Oct 2026 at 16:38, Jani Nikula <jani.nikula@intel.com> wrote:
>
> On Mon, 12 Oct 2026, Avi Weiss <thnkslprpt@gmail.com> wrote:
> > If drm_edid_connector_update() fails, hdmi_get_modes() returns
> > without freeing the EDID allocated by drm_edid_read_ddc(). It's
> > an unlikely error path but nevertheless possible and should be
> > cleaned up fully.
> >
> > Free the EDID before returning, while keeping the existing return
> > value of 0.
> >
> > Fixes: f6e4f57fd90dc ("drm/exynos: hdmi: convert to struct drm_edid")
> > Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> > ---
> >  drivers/gpu/drm/exynos/exynos_hdmi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> > index d4fce39c2b61..386557a7f5e8 100644
> > --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> > +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> > @@ -893,8 +893,10 @@ static int hdmi_get_modes(struct drm_connector *connector)
> >       drm_edid = drm_edid_read_ddc(connector, hdata->ddc_adpt);
> >
> >       ret = drm_edid_connector_update(connector, drm_edid);
>
> You could just move the drm_edid_free() call here to avoid duplicating
> it.
>
> > -     if (ret)
> > +     if (ret) {
> > +             drm_edid_free(drm_edid);
> >               return 0;
> > +     }
> >
> >       cec_notifier_set_phys_addr(hdata->notifier, info->source_physical_address);
> >
> >
> > base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
>
> --
> Jani Nikula, Intel
