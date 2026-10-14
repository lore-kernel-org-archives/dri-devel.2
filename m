Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AB4C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48FA31120CD;
	Wed, 14 Oct 2026 20:21:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D491120D5
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 20:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792009278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YgsfYyvaCRIqPWxqcD4j7lIKXDmBefp8x+ni+nNvW90=;
 b=CpWqMxijWFTQzDF/WxFCvpPSi3QGdWWX4Ptq7RsVlrtnKaGFr8jbADzFqj1wVbZW2O6Wy5
 22sZ8fs/j/tQL13g90bOhuicuWjZWwzwtZp1o6A7x8ZhVi4QxqaJulhwu/nOp5u/5rVUR9
 g4rGmNYN7jLODMWCOSCC2eTl1Jt8rKA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-SZuIwgWeOAK2SQ2eeT7tJg-1; Wed, 14 Oct 2026 20:21:16 +0000
X-MC-Unique: SZuIwgWeOAK2SQ2eeT7tJg-1
X-Mimecast-MFC-AGG-ID: SZuIwgWeOAK2SQ2eeT7tJg_1792009276
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48afe000b94so736450f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009275; x=1792614075;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YgsfYyvaCRIqPWxqcD4j7lIKXDmBefp8x+ni+nNvW90=;
 b=MIRV/aGrPAB41ziBvKn81475U7g0LySDOT7WJg5PfuCF4V34Vt+rPlVAVyYHlCIpnn
 Y2ICoumFHxLszj7l70R06nlhkQQt3Tmpfqj9xhqTmrWRM6TpWw14Lg1N37bZEgt+3nwO
 IfS8n4hcA9Mf4MiVSFs+tDsWsP3ADHPj/H3vL13xWeL3N7RJtv2tIB5aDEHZUKcwAwVu
 NhCZ+O5FKewI8tpQnaPbSwQbgkqBE2shdzM0VUqO6Nak6jxPeKuO7eM0qxoZ1NNnq5Ek
 zWlhGstx0K7u+otc9RqSYtoTksN9J4060j4yKSK3tEMn2/GF63TpG9VS2gqkxBAgZ1Bi
 NvzQ==
X-Gm-Message-State: AFq9FYL5ZAMXzu+44idFa1oCidupN6pRPVX1WIkk1K3oeRiXe/ekTIA2
 bElMr32j+sfRCsA5VsjDeeyBgwaQwBwsjYqMcg9qeYvzTrig608vppdMUeTh6Z7X6bL+XW1Cpil
 xkoVU1LFezWMqiMsJrRu8hvKZ5yRoBKEFJVhXvNbjr/y+Hkija9JDfmE3MfOEsdPlCGtkLg==
X-Gm-Gg: AYBFou1lozdoEa9ZDbc0VHJ+JDxNK415VZ0dS5/tZPHclOZcrNzplR5uAusCtHSF1Pq
 ux+UhHIGpVhUZXas1S9zRd1NxfXiKqs3fKJ8t4RPT9yRnOnnl0AP4M5t+d728Bd7S6spOUuHd6+
 zUrXNNo2S2C0qLSwpa9V8hTVEDlGu3xetnBe/fGO4/q0IqxIkIYm9BX9H44pWRWKwKxqbF0Qoyo
 e9U/KDcL4nWQLCKtHp608yS6ZQmhfqAiOqu48oGM5qiNOWNqrmjEIzgGS1uBggBQgdgePS2Q/zV
 jROiSMcQ12YKfcbgpTwEHWchmZKRuH5QC6FOLOqHA6LZd3jqb6JnPuivS8ukosk052zFz6uKbRD
 AQ5lL0f8/KAuAdqflEwMXaESltOh3VPrASVK+fHmv3eaYIuHZBPADBDaUtxuC74T4lw==
X-Received: by 2002:a5d:5f84:0:b0:48b:86:5563 with SMTP id
 ffacd0b85a97d-48dbaae6f0bmr32545157f8f.27.1792009275513; 
 Wed, 14 Oct 2026 13:21:15 -0700 (PDT)
X-Received: by 2002:a5d:5f84:0:b0:48b:86:5563 with SMTP id
 ffacd0b85a97d-48dbaae6f0bmr32545119f8f.27.1792009275075; 
 Wed, 14 Oct 2026 13:21:15 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab6361sm11737792f8f.32.2026.10.14.13.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 13:21:14 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 35/75] drm/solomon: ssd130x: Switch to
 drm_atomic_helper_connector_create_state
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-35-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-35-586c9c026823@kernel.org>
Date: Wed, 14 Oct 2026 22:21:06 +0200
Message-ID: <xlv1a4ogghjh.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hPVWr3mj3TVDyH9lZVb1GXPRgVNh1axTJBxb8JyIUPM_1792009276
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

> The solomon: ssd130x connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>
> Switch to drm_atomic_helper_connector_create_state() instead.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/gpu/drm/solomon/ssd130x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

