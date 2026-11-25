Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A170606A684
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Px26KOns
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4EC10FA1D;
	Wed, 25 Nov 2026 08:43:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1358010FA0B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795596133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bfedwSxwQLGGz+Z2vyd2vC4NVHhMFBOOXh9XyPwMEUc=;
 b=Px26KOnsf8VzWaT5M4+AXcSNp0xsxvL1F6fNbr7DrhkBSuZfc89DxLbq56hteEnSnsCC1P
 XC0DDlgCO9PWNvFGT8J1/10w32LNQmUSnDexmrqotpmPjGLs2yIpE9PleFJrHiOlcSpJF6
 hVsBNoRC49PsF4OsiUpxpOfl7krYqVU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-pG-Ch2cIOvWYO2zERzQ_-w-1; Wed, 25 Nov 2026 08:42:11 +0000
X-MC-Unique: pG-Ch2cIOvWYO2zERzQ_-w-1
X-Mimecast-MFC-AGG-ID: pG-Ch2cIOvWYO2zERzQ_-w_1795596130
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a35e1d2dddso47879795e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795596130; x=1796200930;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bfedwSxwQLGGz+Z2vyd2vC4NVHhMFBOOXh9XyPwMEUc=;
 b=xpXem4wERb+LS3e6ur4LC3iYLVXoBnQ4MmWJpF+EUmZtnkyW/X3L0z40iim7TC9pr4
 dNsu/SguHbX6oyv0uIjSlmdH/UGitMlpGTS4FpBMJCSAKoTng/3JX/aWDtEr1TtptOyx
 UUbuTSw35AEV0abgZNeXT+nuWaEUvNZJhepoMVQykq/A9kiMqc49Iv/P61NRCZWyZpCE
 PNFwiBKmOfahle6qmQKD9nMhxsixTgA0epyBkgDm9n7OcpHJ1nLIuPmPojypBQkrjObO
 u1nTfLg29HovQuxZBetCbpsMcc8Vn5lePoslB1SIb6oHNqs/rxU4N43K0PfBxonYZTRL
 qaDg==
X-Forwarded-Encrypted: i=1;
 AL+hErGYHFqnbnpHZyzOx0BpqiAxob+TEMjClzz+Avda7fHRBjHN8VYQ5y+1qpBlDfjzvDFQo3NZBd5vWVA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/B2mlVzvS3+wwY4ezejoG6OLS+Csb4c90Z8cJYrC/aOd17Tga2
 rEKZB3lC1OuOO1lvWhIYfn12PUpzrFZsLCILL2hJOI+qzaEKawsbC+ZhOtZMgCFWxK6/CuiOhTd
 rf2ZFGOZkKWVrvpERAI6REMKBEzBfmqu+30KcEkzq1pR5MtU44hZfGiDxsYMhMwXxlLzLjQ==
X-Gm-Gg: AZFdTZeOQ26oqcv88ttNurg5Ywtzf5WJFC/2alTlhXIETEKZ8MdONnjq71YwjOrUqZF
 Z4MU4zxdvLiReSlxrJ0IEBACpdeX+sx/652AwxSYcDD4LqB+o2xYQswMWdgyxHats3ybIuSHOB+
 OZolFqr9Tztk6EiLouZuBcROkftgxN+Ujuo3mJHuRRG1fOOKWwkOhgmj3AaSA+hwgkTCmfmyjEe
 p+/chjXkP0+7KonXwKS0aB6rShEHgfWeK/8ZrOlWUah2n5JNLukqP+2lBEed1uUnw+7/1r4q5jS
 ha7A0BxzOYQKLuDq/flQ3HEcI7/3KGx6ForNX0aAl5uUE0XZu0KMjtPuU+u3ZoCovUipY1Vybsn
 n6kYiI887G2S4cc5zq1nBgO46BjoJIjwDTESQbZrF+8tj1Y1vfez9Au8LvUrUUfvYjHYKNbnHiG
 IhsiUce2egNaJKPCw6kUCz23Uq659vrUt5So8U5JY=
X-Received: by 2002:a05:600c:4584:b0:4b8:4af2:88b3 with SMTP id
 5b1f17b1804b1-4bb88817aa2mr346072955e9.22.1795596130182; 
 Wed, 25 Nov 2026 00:42:10 -0800 (PST)
X-Received: by 2002:a05:600c:4584:b0:4b8:4af2:88b3 with SMTP id
 5b1f17b1804b1-4bb88817aa2mr346072345e9.22.1795596129635; 
 Wed, 25 Nov 2026 00:42:09 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d55sm32983935f8f.5.2026.11.25.00.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 00:42:09 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Yige Jiang <yigejiang86@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Yige Jiang <yigejiang86@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firmware: sysfb: Clear the device pointer on
 registration failure
In-Reply-To: <confirmed-20261105-25-a16124b5ff57@gmail.com>
References: <confirmed-20261105-25-a16124b5ff57@gmail.com>
Date: Wed, 25 Nov 2026 09:42:07 +0100
Message-ID: <xlv1mrqxl2u8.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: urPQJb5pmexOoGV_TBHZ19Ju0i48PMB_6ZQ4WdP7ag4_1795596130
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Yige Jiang <yigejiang86@gmail.com> writes:

Hello,

> sysfb_init() stores the legacy framebuffer device in the file-scope pd
> pointer before adding its data and registering it. If either operation
> fails, the error path drops the allocation reference but leaves pd set.
> A later sysfb_disable() then passes this stale pointer to
> platform_device_unregister().
>
> Clear pd after releasing the failed device, while disable_lock is still
> held. This makes sysfb_unregister() skip it just as it skips an absent
> or already unregistered framebuffer.
>
> Fixes: bde376e9de3c ("firmware: sysfb: Add sysfb_disable() helper function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
> ---

Thanks for the fix.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

