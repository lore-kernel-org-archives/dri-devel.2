Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7151DCD4F5E
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67DB10EF52;
	Wed, 20 May 2026 07:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fo+tW3Ed";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565D710EF3C
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779262822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BTWTApFCbsMsSyvfrQOGSrxC79mvO1+CZfSBBZN5ls=;
 b=fo+tW3EdKgdwf8PEsaQ0TORzEaJdh40uTh/gsFUkqVe7a4dUVUpYwfgJ9k8SohI3Rypun2
 c6mBU0/q/civxs9QLDdHd/FfIOqn+f06FCTszuQBRz5ysL9i1UNsONzRgl6APMZkFT9iFO
 bdpZJe/s3/EG7rF1bPRxrfi4FmO3qXY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-Cqqj6xn_NFuaCcMm-NgJBw-1; Wed, 20 May 2026 03:40:20 -0400
X-MC-Unique: Cqqj6xn_NFuaCcMm-NgJBw-1
X-Mimecast-MFC-AGG-ID: Cqqj6xn_NFuaCcMm-NgJBw_1779262819
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d789cebcfso3671055f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 00:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779262819; x=1779867619;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0BTWTApFCbsMsSyvfrQOGSrxC79mvO1+CZfSBBZN5ls=;
 b=UUoUXzhTkIX/QC2mzNQhL0aa278YJbxFuOe7f3cMnWulOZLegoboK+jS2u2G0ddvJ5
 9gzJ2JgvMHqzDK7hspDIjvPKqYt8GrPozgeE252bLDkr5bpDQMPIsqsvvytWRrFqT5qg
 V/JTt2KiRdnZu2Cq82SLyi9dsHo5wx0RH/1g9jM6v9w1CqHa8yBGj+2ZlF3r0zkHOeaX
 Y300I5ZbXwwViYagDnc+SS7hzsj2SLlyYMDvRkKWOAh0Tfzx4JELNL2cJThLUF7R4tpH
 LVMYylBL2JWo1AdWWLMnX4XbUjNoK4yn1xuaqJwaHJtumTAjm4E6TyYM2+IYmw8/fXhF
 xoag==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hyumelMV73EETZ6cfIV3pAeWD3nqZGDkLFeRaOmC4SEccfcTgz3QfOvJVnbJ/RqK0CtqV+GsdLgc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVkLVTzFaDimowYKJURuORIGlCvdFC7k5LWgFtzWKq4m4fWvF4
 6vYkiwqCjn9X5PNerxczD8GNn8fhjQiUiHaheXzoaxQY/vl4lD7B0iNZhJBBNfVNQFHIxO9jaFP
 1qvyVNgcXdzlNeetXfRt6S1twAoFiuomSCkM+ZaUeqKjx4qwKD1UtFKEgngvHg1+anpfW2g==
X-Gm-Gg: Acq92OHzRNA3F5Gqzgh7onoLASHh+xz5xoL7QI9ZuHLhWLJdBrwLMfLInz2PDoIwjae
 1xqhYtifrR1pjPVpFjYtfX3Yd9wie+JZO7V5wuqQeA2dgOMwlCHNRUobiFbomqErR+/HkhGexZU
 elitOHzPkTV5xli9adSMWuiZFg2buub9AORn/Wp3LL1vfUtRL/OslngGnA7FtJJymkPwBvBWS15
 bGg8sSsellMV0qm2HSLsTfMpGjgnjxq9W4E08/1+xJ0xpspIVoJHOXpogrjuucZ2sagT9uGesOw
 BbKmNe7Cl3oW/TfTx/aiuJONptEh6OjHiU4I3mVcW4GK7yFJGYX/3//GhhWxlyzkU/m9UG9uzOB
 sMCcIpGU8cuuVQblJglyYVdrc89V/t29/SC+GveOMDwU9gfALt6n35Rv2Pn7pixEZC1OPXZfuNz
 Eegl5b
X-Received: by 2002:a05:600c:3b19:b0:490:f7c:b19 with SMTP id
 5b1f17b1804b1-4900f7c0f52mr141631105e9.0.1779262819447; 
 Wed, 20 May 2026 00:40:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3b19:b0:490:f7c:b19 with SMTP id
 5b1f17b1804b1-4900f7c0f52mr141630755e9.0.1779262818939; 
 Wed, 20 May 2026 00:40:18 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49031731733sm2892285e9.0.2026.05.20.00.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:40:18 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/8] drm/display: hdmi: Add common TMDS character rate
 constants
In-Reply-To: <78506dc5f7ff02a2bdd05de1170a1cb3e33e1abe@intel.com>
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-2-javierm@redhat.com>
 <78506dc5f7ff02a2bdd05de1170a1cb3e33e1abe@intel.com>
Date: Wed, 20 May 2026 09:40:17 +0200
Message-ID: <875x4iy1em.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iWKpj0x1qOXY0CYWpdXFQ6oH4_k_J-YtoU4Lzq7NJ2A_1779262819
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

Jani Nikula <jani.nikula@intel.com> writes:

Hello Jani,

> On Tue, 19 May 2026, Javier Martinez Canillas <javierm@redhat.com> wrote:

[...]

>>  
>> +/* HDMI spec TMDS character rate limits (in Hz) */
>> +#define DRM_HDMI_TMDS_CHAR_RATE_MIN	25000000
>> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0	165000000
>> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3	340000000
>> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0	600000000
>
> Usually everything in DRM is in kHz, and Hz is the exception.
>

That is correct but in this case these constants are to be used with the
HDMI helpers. Both struct drm_connector_hdmi_state.tmds_char_rate and
the struct drm_bridge_funcs.hdmi_tmds_char_rate_valid() callback expect
the TMDS char rate to be defined in Hz.

If we define these in kHz, it means that drivers will have to * 1000 at
every call site.

> I'm also not sure the 1_0, 1_3, and 2_0 really help anyone reading the
> code. I won't remember what they mean in Hz or kHz, and I'll have to
> look them up every single time.
>

I discussed this with Maxime before posting the patches since I wondered
the same. He suggested that the max TMDS character rate was linked to the
HDMI spec versions and that it would be more readable to name it using
the spec version rather than the resolution.

The other naming I suggested was:

/* HDMI spec TMDS character rate limits (in Hz) */
#define DRM_HDMI_TMDS_CHAR_RATE_MIN		 25000000
#define DRM_HDMI_TMDS_CHAR_RATE_74_25MHZ	 74250000
#define DRM_HDMI_TMDS_CHAR_RATE_148_5MHZ	148500000
#define DRM_HDMI_TMDS_CHAR_RATE_297MHZ		297000000
#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_4		340000000

> BR,
> Jani.
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

