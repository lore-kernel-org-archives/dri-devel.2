Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA08606A337
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GNJJsTZq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B16F10E3BE;
	Wed, 11 Nov 2026 13:18:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D37410E3BE
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794403122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esQaj4i0rxBBJRvkYI6ptnCogyr3YrhY79nTBzkIGog=;
 b=GNJJsTZqtj+Df/gaY5HhmqrJr6g71k0viQmCOi6F/mYIgwITp4Wn7HxrIeTSLeSeSOhpb+
 Y1WUYSLxHo+Q4O7zUFE4MXxdywIHbLflLwiFldUJ7KVNXfbWqkEow6vtHo8IH1GDlwYiwK
 UfpBV9H694MeQiy7XoqA2FDptMVTzM8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-D93A96g-PwCXioA6IMr6RA-1; Wed, 11 Nov 2026 08:18:38 -0500
X-MC-Unique: D93A96g-PwCXioA6IMr6RA-1
X-Mimecast-MFC-AGG-ID: D93A96g-PwCXioA6IMr6RA_1794403118
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1f03f2e8aso26641945e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794403117; x=1795007917;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=esQaj4i0rxBBJRvkYI6ptnCogyr3YrhY79nTBzkIGog=;
 b=0tey88Kw8VThc3WJIntacrSLvFq7YjTE+K2TDrjUfv4GFcAxh6XH0hBfFR9aHiJDRH
 tvEKV9HEen0g86QWpeNukYAk4CNBMIDF7SW3mHOqVBmnyi3Z1g7Qgrd0BfFcRlbIXmoq
 KEY9/e4B+FVxGjjEVsc16pxWXwm8NaKmlfFeLjGf3+8ZWPBLIKjXBj2nHMIFxbNEfSXw
 7xEi0KEmNbpfhYyHlBw5C4p3gkeIJMqbQuvZF9zVMzBkCdm44WVPeSETy/77PFcKMTQa
 FbKKddmxn9Nc5u2ji0Ukn/9kwQJhYB1cLtfcQhLMLe3iaV+E/XISwhhmylUE3DfNs1Y3
 3j7g==
X-Forwarded-Encrypted: i=1;
 AL+hErELAo8sY1YCzIF4RzojRN3I/4XoG6sRlWtJwbLjCQW7QhbVW2ocrMuG30Z+Z+Wgw23VqO4L4uEebkU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+seai7XTixd4XfwxNj+ZGHSFZHbk3+lH7LjZjqGDfif7x3Jf6R
 DF9M3c9YsxWQImbgrJIO+rDBXAdOOoTdqS8BI+mdl0EY6lLrMmJSyBgAWKItnEHsZb/XZ4I4PaI
 kVpKWCVSVfWVQzJFXZ8yIlJh+ZDuIeok7TKSQAYnzv6v8CqjuoShcnC3YJq9RlX7T/DDPwA==
X-Gm-Gg: AYBFou0Ddv4fGCq1cl6NWL4LF0GcHM8/fofYvv/z55/ep/z3HmD3dsab1G+BmH3ttD0
 cuUkn7LzyDmcTVSNTH3v/6xkx86mrNkMc2OkfESxJfz1u3L9WNlaRiy7OUppejQdO9PLSZ6Sa7c
 cSlP/Pji3sI7pZXmHJ5toRx0U4ggKTeIoEWPg/rQD6hZqcXc2XqtLQKmoedJNhrWtEUY8F9MhYv
 fU561tYYHAdOK/ppwEe14cjwNA/LiLqC8iSp+g96v79geN/ifZ6inSS/YN1dCHusJ8RaH8v7jfZ
 1OXa/spYR2W2l/qh/1IAmVSuf5OOIgDbeAfac7qhnxJfuaM081T84RBaToCS0ROYoygCk6U3VCv
 cP5U8BLrClJMucsx6lc+BoVumEuHAUiqA0kpPYbZjG0NNubJdw8DmoDEwofqqE8XIcVlTbJ98la
 Qver018Ft4F8DFgTqhn8gRF01iICUMeVkmbgNbOvw=
X-Received: by 2002:a05:600c:870f:b0:4a1:7c56:d4e2 with SMTP id
 5b1f17b1804b1-4ba093817d0mr40825465e9.16.1794403117582; 
 Wed, 11 Nov 2026 05:18:37 -0800 (PST)
X-Received: by 2002:a05:600c:870f:b0:4a1:7c56:d4e2 with SMTP id
 5b1f17b1804b1-4ba093817d0mr40824875e9.16.1794403117057; 
 Wed, 11 Nov 2026 05:18:37 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498811fa70esm9733692f8f.19.2026.11.11.05.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:18:36 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: =?utf-8?Q?M=C3=A0xim?= Pedraza Padilla <maximpedraza@gmail.com>, Maarten
 Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ard
 Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Helge
 Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>, Jani Nikula
 <jani.nikula@linux.intel.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Jocelyn Falempe <jfalempe@redhat.com>, Sam
 Ravnborg <sam@ravnborg.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/15] fbdev: efifb: move the BMP headers to
 <video/bmp.h>
In-Reply-To: <20261027135342.2003632-4-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
 <20261027135342.2003632-4-maximpedraza@gmail.com>
Date: Wed, 11 Nov 2026 14:18:35 +0100
Message-ID: <xlv1cxsba4lw.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uDBwgALDos2hUVI0_hJiZzMr4BL8ZncvOwNBk_u3WcA_1794403118
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

M=C3=A0xim Pedraza Padilla <maximpedraza@gmail.com> writes:

Hello M=C3=A0xim,

> The DRM splash client parses the same BMP headers as efifb. Rather than
> keep a second copy of the structures, move them to include/video/bmp.h
> with the magic number.
>
> BMP is little endian whatever the CPU, so the header gives the fields
> as __le16 and __le32, and efifb now reads them with
> get_unaligned_le16() and get_unaligned_le32(). Width and height are
> read signed, as the format has them. No change on the little endian
> systems EFI runs on.
>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Assisted-by: Claude:claude-opus-5-5

Please drop this tag. Has been obsoleted by commit 1e035297ffda ("docs:
remove Assisted-by references").

> Signed-off-by: M=C3=A0xim Pedraza Padilla <maximpedraza@gmail.com>
> ---
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

