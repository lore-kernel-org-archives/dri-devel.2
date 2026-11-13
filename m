Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85E606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=D0WmJ+Ye
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2D51126BA;
	Fri, 13 Nov 2026 16:38:18 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF751126BA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:38:12 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c50715c2757so191128666b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794587891; x=1795192691;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZBtOs8SUuvYS9eK9oBm2MAuuDuF7zij1f4x3ajNRRgw=;
 b=D0WmJ+YeBO2UEHp/nphyS8wNdlxZW8+K37F4wqxHlwByI4HnnDTBOa6VyPh8UpAn0M
 z1mc/v96a8o7ypEwkIMFaV4W+mcwjBczzTwbaOXSr8EFGjqyi6LlN7x2WrH7SUKNsTmK
 8gwX1iR9NQ/ihnEP1HLdq2RJ2QgAUCQ4dxbdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794587891; x=1795192691;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZBtOs8SUuvYS9eK9oBm2MAuuDuF7zij1f4x3ajNRRgw=;
 b=nr021tW/c4PwlWnIeNmIv9OCi9gDDuCOEtPisgHG2khq4cPmhdvwO8L71trpaVpw7L
 Tf2bG3ez9TfppNB+5MV/yFiwXBBxUfm5rRoZC3KK4Fy6TlDUCPJawoEg5yEqBRpAJL29
 wGIcKQB3Znwe9JbnmgUQCQ4rq4MaB0MQGPnypmGbkS1Ox2IXgCw1XCTT1pzUEgMPACpe
 hbJE3+fdDZQ8WUijRcvLEcHf1maBIDH8jG7chBAU+kzaf80NfzkO0a+V9eLE0b6vHd1X
 I5Km6OPmqdQjJQqvKP11qqtiGZrSpMYeT8LWxPD/lcfHQOxeaA154Mqcf+aoQZxi1+9z
 nRVQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHRkKjCfarC3fp4YvvcpXXuokxI9K8GfEPYi+KPK2Gxj3bOHxZi2XdTTGpFLVHZbdjGf6xmWiS/O7A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/10NeIry13YCZ7cA3bJRBtLs+n/cQmYGZOdXP8MpP7lUR88+S1
 lowGqJxQ6+Bbm/4eEiS3aDpN3A8+9tpVMMAXfjo1Xb2nPwfZUYWujaJXojA2c4fu7S+M47t5AQP
 2XCroRWO3
X-Gm-Gg: AYBFou0sc0TG+U3oiyRJ1ghyi8SBNL1etvlqocdFvwzamgrSbvPIhWFq62ZXb0Rg3p0
 cbQwhrzBIZpLESoNavHoR3cuBDbhzvCVzWPHjnpmF9sstMkqy9ksZuXFKVEHkRSbrDT0lSb5Fes
 4qeieNIbQn7Vga66OjRtFJG5/jTsV4ENL7vm9WJx/wC1rKjggrWzSqBThreX9Jg4OcTvCjGMNJE
 RMLHtFKx2l2jKs0UqaU6itmLYY9UX24yxtNpjJ+3MRtTeI+bSiY5J7h80wZEGKn3icj2yI+ZzZq
 e1K+Y6FtMEBC24DUbCWfnsP8+b2EezBsq/i+Xqur4XSgGjOHwPzYNw/wWbq+gKcdgt4mcN0oU7m
 Gt7JJpOwT367PntQhUAgJeXEyCEN87mYARyn9ZRfawe/QrgVamzOWK7XZarSXDdpfoWmIlqFegn
 qbmItwfM3QYDSkie3RwOSTQKx/NxZ4Y0ecs92XqWZ/Z7q1/Y2icc+MJtK6d/EVXt8qE0Fui9FMe
 G5w+jxZi2Bsdhsrx93209cx0y5MSe+KMtO9KjOPD6aLXnDK5Ltgc4rDG2dQIywOfyGocfZ0nRJe
 rnnP2Q93JaXZY9kJXqpeFEhi3Vn1hMHKYsPXjiMWMWAbUsgqhATb/EApmSDXnpeA51N1
X-Received: by 2002:a17:907:6d20:b0:c46:74f6:e149 with SMTP id
 a640c23a62f3a-c5096328142mr285659666b.16.1794587891366; 
 Fri, 13 Nov 2026 08:38:11 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b6f6eesm118502566b.63.2026.11.13.08.37.59
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 08:37:59 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-491971ac844so1404139f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:37:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErHi9K6g3rPuAED3YDNq6D2NAZKiowsU2pS1/aTrRB6wWnHq6w9v5T3ltqUZBWRL6ZniBFMmpKNpUWU=@lists.freedesktop.org
X-Received: by 2002:a05:6000:4201:b0:48e:870:7791 with SMTP id
 ffacd0b85a97d-49c71e3d623mr7912453f8f.26.1794587878240; Fri, 13 Nov 2026
 08:37:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112154444.417-1-_@tawheed.cc>
In-Reply-To: <20261112154444.417-1-_@tawheed.cc>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Nov 2026 08:37:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VMbAusUr0GpSaL3cRexqLt3mEkdk1OP96ZXtwT3rvSWQ@mail.gmail.com>
X-Gm-Features: AclHuK_-H1omPIi3kNtcH0DdX5XIsoE0vQ7Cu-PsOqPjOrjRqcY_iHAPS8_aqcw
Message-ID: <CAD=FV=VMbAusUr0GpSaL3cRexqLt3mEkdk1OP96ZXtwT3rvSWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add LGD LP129WT112684 panel
To: Tawheed Makhdoomi <_@tawheed.cc>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, Nov 12, 2026 at 7:44=E2=80=AFAM Tawheed Makhdoomi <_@tawheed.cc> wr=
ote:
>
> Add the LG Display LP129WT112684 12.9" 2880x1920 eDP panel, used in the
> Microsoft Surface Pro X (SQ1). It uses the same timings as the other
> LGD LP129WT* panel already in the table (0x06b2).
>
> Without this entry the panel is driven with conservative timings and
> probe hits the "Unknown panel" WARN.
>
> Panel ID: LGD 0x0555, EDID descriptors "LGD_DV1.0_" / "LP129WT112684".
>
> Signed-off-by: Tawheed Makhdoomi <_@tawheed.cc>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Please follow the example of other recent commits to this file and
include the EDID in the commit message. Also, when you say "It uses
the same timings as the other ..." does this mean "I have the
detasheet and verified that it uses the same timings" or does this
mean "I have no idea, so I picked what the nearby panels do". Please
be explicit about how you arrived at the timings in the commit
message.

-Doug
