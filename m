Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD70C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 17:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 372AA10E4E1;
	Fri, 17 Jul 2026 17:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H2VR126h";
	dkim-atps=neutral
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B671D10E4E1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 17:04:21 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-963a722ed59so1594781241.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784307860; x=1784912660;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WPadNULOiYvQJVxvZ4y/qdA1/ZyRN8lpZEuwDw/lLZM=;
 b=H2VR126h6iezK+zkp4Tdy5FCAsCd0zIXL7cxNlq4wwuC1S5eglE2tzvBMa8qEBp5C/
 CYt69NtGdpk654vWMi3zT604N2+MrpK9/0mdq11R6ymDWUGaeWB1N05OJt7+Knu3ZNct
 LGVWFLdOfZvtopVCoRKXXhQbUigJyIf/rvrqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784307860; x=1784912660;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WPadNULOiYvQJVxvZ4y/qdA1/ZyRN8lpZEuwDw/lLZM=;
 b=r1wA/6oZHICpk4poZHeLDZ/DG+fGdOrj4NOICNO3eXXAnoDCZ8xQddmUJRbvm8I9JH
 QoO1/zUUNnv9FuwDQ6s5qOeR0iLL3CbIZu4OKfEe6Q2+uYsODz0JW2Je9Szw0RIc1vqh
 6PCasN/uVRR/uql5z+OOabUQKh+Kg2sgV/fpKDq4E2ExBW/c565XEleIKgh6tIWPA2Hf
 8ma3AJuElH6cCbbql2m6L78NkbCNeECkM9ejc0Ej8maFRKB0GkQMB2wNrimOjsLKVywm
 FgPScplIBHWNfKHw+skANbsLKjI6mhsBB+fnZcxkN+sGcDblatiinwVObNsrI7R241pU
 e1SQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrV8enxycfj2QgKiocUNnGNB7A475N59aGnF94Mk6P7kx3UP9PyvLy+/gK4Rq0cDyMCrVGy6ZIpC40=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8J4ppKir/ElIhqZiN/QmU6pD8Few6IYnLu5Bx3EjZpwoFma+f
 dGoHOYgiLpk9B8QNshSoQBa1dk9if+6H6u69gMT0GJj7cBZOEzNYJaqwNOlP83rtbVwT5KOdpbL
 22rQ=
X-Gm-Gg: AfdE7cmwjQbtPZbfY/Fn4uAK2J9LBhsL3kLMnAeEgHNttzVuiP7vCVwT9yEIdcO94I5
 /zx2ohtaQVArhTvNiMko0InH79QSueN0k0IbxHkgXvPUvONnd5NJpgv+yjm8Bty1jDzB6oUCcgo
 +ub19v0vOo8YpXyqzCaG6tuhQklZXugpb/XHF0m2VlibE5ZqR6O38Bpknb1fqG4md0fGr/aTh+c
 yARd6hXYrs49ib3vZSZvq0FPFpKzFvq31+lNV0XLiZNt+B/2qS0Mywg2o0Jse0d3RxmQnXCldf9
 8yqFzFXaxrGXKG+oYhmr7Ag5s/gMVd7ypQ2B1PQ7wADONc4bJqZsObAAhUQDHr6ypKV06ms6BoP
 ztNRcgiAlYYTBJRyA0QiQSQJHVrqdeIIt8/uXIeyh0OE5rd5tl9SIqJ7QGcewD4KejE2lMgdnM0
 fHKiaUD+aL4EwORhzmBZn/GrUVVaDNk9O61mclR2TKg+XXNkxQFJ/8U90=
X-Received: by 2002:a05:6122:3b8a:b0:5bf:6cfa:7743 with SMTP id
 71dfb90a1353d-5c1bf942107mr584017e0c.13.1784307860501; 
 Fri, 17 Jul 2026 10:04:20 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com.
 [209.85.221.170]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-976fc60ca1asm867748241.10.2026.07.17.10.04.16
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 10:04:16 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-5c0627c302eso1698420e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:04:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrLWTzeJA1J3hCVs1yXbsoxAwL1wrxVlm7H8Xuqyq1lgUI5Dq/Kvw9LhDj03FqIMl7OAF33jxuTre8=@lists.freedesktop.org
X-Received: by 2002:a05:6122:45a8:b0:5bd:af82:fd9e with SMTP id
 71dfb90a1353d-5c1bf825fa1mr570513e0c.8.1784307854860; Fri, 17 Jul 2026
 10:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260717143119.1815106-1-johan@kernel.org>
 <20260717143119.1815106-3-johan@kernel.org>
In-Reply-To: <20260717143119.1815106-3-johan@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 Jul 2026 10:04:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UNm2Lku-cfS9GMS7U4z6v6c3Ng-e9HGF1E_Ddvzc-q-g@mail.gmail.com>
X-Gm-Features: AUfX_mwU-m96pt8Zw611apwflgb7trdkOx8hUQcP2w8qxbFzz7l5pjYLutLF4q8
Message-ID: <CAD=FV=UNm2Lku-cfS9GMS7U4z6v6c3Ng-e9HGF1E_Ddvzc-q-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/panel-edp: take i2c adapter module reference
To: Johan Hovold <johan@kernel.org>
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

On Fri, Jul 17, 2026 at 7:32=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> The i2c subsystem currently blocks during adapter deregistration
> whenever there are consumers holding a reference.
>
> Switch to using of_get_i2c_adapter_by_node() which also takes a
> reference to the adapter module so that an attempt to unload the module
> while in use fails gracefully instead of blocking uninterruptibly.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
