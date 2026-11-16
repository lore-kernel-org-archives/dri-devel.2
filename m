Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9D606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EreqnY2u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD2610EE7C;
	Mon, 16 Nov 2026 09:29:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91BBA10EEDA
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794821344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wFbznQG0d5IonVOFhnusqlVdFzPG48oiZmmSS9tPXTU=;
 b=EreqnY2uGsPcGB08CysgsQlx2r4/WZU1DJtu10NyBFowSXSRQwTr+DDZ5u4hEu8Vvrf2VL
 T2HA1h/5StAh4rLX6cK0x6E/6USu1TwtXzonLSXLJ+6m+hDOcsVfH/CQWfq8AAP6EgT9B/
 0TGalq8gj1Y5x0gaJwlsRwjRFpJ6+bg=
X-MC-Rep: binary re single
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-_30DmQKgOAWbkHYyiIfPgA-1; Mon, 16 Nov 2026 04:29:03 -0500
X-MC-Unique: _30DmQKgOAWbkHYyiIfPgA-1
X-Mimecast-MFC-AGG-ID: _30DmQKgOAWbkHYyiIfPgA_1794821342
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a359c7f47bso26106315e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 01:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794821342; x=1795426142;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wFbznQG0d5IonVOFhnusqlVdFzPG48oiZmmSS9tPXTU=;
 b=i7+dTamR1Yr1ueZ+n5di8w1I4iTJjBekwcOuJDWU+8vCegPx56ixk6b5dMRRWgjnXq
 2NkZfVhulriMdVmzIZS7paH2TF9cTEUXmAHsa37rA2A4+VcY64I377cK8zxTOIi0Be2m
 y7x0mxbOA6hN9SkOyl9FAdOl/Jn8nzWgjSqR3QUNgutfo5FR1Clejf+D7+HACRj6LT5k
 1kbI5xhMAE8+wkSrsAq134U+J1PAMBIN/VY/AaIe7saSf4e2QAxtSoNYFsMqNNUJnpSm
 YOgtdb9XCakWBxA01TIl2mRrrDJXj6G6Vl85VgDNyyk+ZvsPTdHGkKgKc8vyEJMjjTfz
 GdVQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF2960yTswow6OYrMRU/s2CwDeT5n/HXLii83QZ59VCE3tsOg6koZDxgQpKbcv1RmD2bKM/NrWvcl8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9KkpBrHGJ85hWfr2ch2LvMHWU26gkLMoRUeYscWFF9KVlcEzxa
 3Q6YjJCv/520SYTyTVk6jXIxB5tjNqohsaky3ek16hFdeEHsd1/YeBTWvJZbPexm53GKrgBWcqQ
 cO2BHvw2v0PQVxMSl5BZhAywUSVAg7kXLHBpjIvnZ+Xf74PSKzRRdCY5skasEYOUzGyxt3g==
X-Gm-Gg: AYBFou3k32FWCrBnZ/bPNjPE9bwmUXWcWUOtvzSHU/40Rckk2rxiAoPnSzpM+tilGhu
 P1CWlh4Uo5a56OLEzFFjB/MaV7H/bWmTjiYsmBzfcEd7oy6zAx2MKYzp8bIKdxF7jzL7fiYORy5
 fR+xHPVN5qljlZxnOGJggI8MEWtj4QD7C/j1Kuj7PdRmOdTDlODtClvebC8+zgPABpOAlr+EXdD
 AFPwjSGkma8h89tti0Rj479tqCUJQ8chSYdpz2t88QXykf3bkw8sE+rjrgjDr3ec/THeFDwPjzE
 7tXkjKeYx8wVRHPKbHRfM+ZEm0l95Ot9XoR7zWyEFp6E73ur2k1GKe6dvFoQbM19IQxw3sl0/s+
 bX4o5fYnAMix0egFc9d+DYvIRTAvX1aGfwnNjCO8dtNJ9rN+Ok53oJkiIZAK3Xujdhvy1nWdXcT
 xURceKysZ633dhRlZC4yPu+F1/3Ms/hFs5sGIcXBY=
X-Received: by 2002:a05:600d:41c9:b0:4bb:60bd:5398 with SMTP id
 5b1f17b1804b1-4bb60bd5507mr133776725e9.10.1794821341852; 
 Mon, 16 Nov 2026 01:29:01 -0800 (PST)
X-Received: by 2002:a05:600d:41c9:b0:4bb:60bd:5398 with SMTP id
 5b1f17b1804b1-4bb60bd5507mr133775995e9.10.1794821341249; 
 Mon, 16 Nov 2026 01:29:01 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb675200e4sm115370395e9.0.2026.11.16.01.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:29:00 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Jani
 Nikula <jani.nikula@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, Xaver Hugl
 <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v11 11/12] drm/bridge: add PS8622 connector luminance
 support
In-Reply-To: <20261103-superm1-backlight-property-v11-11-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
 <20261103-superm1-backlight-property-v11-11-00cce7b2ba22@kernel.org>
Date: Mon, 16 Nov 2026 10:28:59 +0100
Message-ID: <xlv1ld6trup0.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BqUKa9Fc3xL7SH-5EMY2LsnP5v-77VEzKVk2n4CsSoA_1794821342
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

"Mario Limonciello (AMD)" <superm1@kernel.org> writes:

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Expose PS8622 brightness through bridge luminance operations when
> DRM_LUMINANCE is enabled. Keep registering the backlight class device
> otherwise.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

