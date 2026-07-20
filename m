Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10804C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ACD510E182;
	Mon, 20 Jul 2026 20:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T+ffglzx";
	dkim-atps=neutral
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B2E210E182
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 20:08:33 +0000 (UTC)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-5bdb162ee53so4277447e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784578112; x=1785182912;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sv0XE5E0uWrOx0Yk9VthMKdWI6oZTQYr4ARXTJf47FY=;
 b=T+ffglzxpy494cro3zppZ+1DU/Gj8qDmhIXwdA08brcK4mCLaYoNBoB7wgfb0QGJsf
 AmFyh0j1FGz1eyVHFOAJtqcUUg/oPID4/cSlf7B3EQPdQCg7fKPi14oq4d8+xtKPMgO2
 py7leyLYqA/rZq0CONtd8EkpEw4QaIRIvkXCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784578112; x=1785182912;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sv0XE5E0uWrOx0Yk9VthMKdWI6oZTQYr4ARXTJf47FY=;
 b=Box6RVUmh10XXkSD+Z0ldpzMPAybMUZJ6EG24lBzVWkZGBrSkaAOAySjCIe7vezYgp
 nOZZ1wLsjPUE7e40pZ5rCycOeoI2dcX8u/SGojZn6FST/IAZ8o8Fl3UKQZWVRzJiWOfN
 T0JYGncJc8wnoPzANxKSbNQM4IzrTa3cA2hPNpdiYP07O17+3pAkkCGQvWuuwHMSgrn3
 +js3PSFnpLVoDxbN7EKoMLlD3KIgndAsKfZXvg/gcOryuvTfVzUO/LfRfZ1QssEJT5w1
 +pTz7GzKhRGsfL6/Lthp3qVkg20ClU9eHHREHAaYdmdqBHVy1ZFbNnNHnNBOy3enrsBP
 KnNw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKKewpGrcQvTaMKAKu/6CMgbjQ9PWrR/5MtzkJidyMme25a5/yGDwNuJAX6O2ZyRXqEjzwYgJNg/0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6RYYrJV7AGrU7O2q+kSS6ofIIduF14LzwqQpzNHNChgDUSfTM
 l+rQwKTFm6FdztAQm2gPZzOL8XKqpb4Lt07kbW5fXCHxc9AIG398oYCYVcMoiDa9MLtR3ZuTXqy
 ZsUU=
X-Gm-Gg: AfdE7ckAjk+/6UYuwv2IRnrB+PRZioabIX0Xk6Uk0zEJvxjwSWZ/YYcvOtdMthFNlKk
 fq0Rfxb1iMpVfF6rlANSc9GBBBKuXpeoDL4xUO/yRQ81IPu5EAiX1M0LBXXmP9KMcxkI0xZTy8f
 Ovi/2V8IqsPDRvRDXR2XhwEetj/45nQ7QG8dOh+qBK9hK/1lpaAhugjzcxricWp4kuM/EIWjUD4
 H6vn1RNKKIlVbZHJDpxbWUiaDkDz1sfv80fUekSaMz8c/U3E7+rTjY4DzVDNmRbobV75dA58W83
 r4cov1e6+WyBtM/Kr4nitZRYpNHRL9oNqC2GXMZh3GKYLMPWV8B+42PHyu6N9aNgB5xxRrUzo2u
 ITjTL1jc74cIl5ESjkBKjiPOl23c7QUcebwBlbZqnv0aFdI+qm5q3pWqrVdhDVO0I/CnccAJ5wO
 dPnnNFaXTMQb32rtSN0z0kRCvqimD07HBL95HTO8/Q1C4YD5IPe7s=
X-Received: by 2002:a05:6122:80e:b0:5c2:acd2:5b44 with SMTP id
 71dfb90a1353d-5c2acd26576mr619746e0c.3.1784578112011; 
 Mon, 20 Jul 2026 13:08:32 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com.
 [209.85.217.51]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c1f6c5111dsm10716274e0c.14.2026.07.20.13.08.27
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 13:08:28 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-74a9ac9cda6so496814137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:08:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2CsSJ9f6xLVXZY5S7rsOqZjkrHjW65IVA4m9vLJGWtM/Lo36V03gS3kYk3+rHbpGWn3dd9e/J2TQ=@lists.freedesktop.org
X-Received: by 2002:a05:6102:1612:b0:6e7:5c89:3fc0 with SMTP id
 ada2fe7eead31-7475374957emr5358497137.25.1784578107146; Mon, 20 Jul 2026
 13:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260719190358.438699-1-michail.tatas@gmail.com>
 <20260719190358.438699-4-michail.tatas@gmail.com>
In-Reply-To: <20260719190358.438699-4-michail.tatas@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 20 Jul 2026 13:08:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V12a9m22QhY6kpk+WU4myTH2fdBP0B==8SgxCseZugEA@mail.gmail.com>
X-Gm-Features: AUfX_mxRbgF3TukH-znmJVQMWzFFVxA4ExcdmYDukTXBJsdj5fOt6FSYHMF5FSI
Message-ID: <CAD=FV=V12a9m22QhY6kpk+WU4myTH2fdBP0B==8SgxCseZugEA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: ilitek-ili9805: make cleanup funcs void
To: Michail Tatas <michail.tatas@gmail.com>
Cc: michael@amarulasolutions.com, neil.armstrong@linaro.org, 
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
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

On Sun, Jul 19, 2026 at 12:04=E2=80=AFPM Michail Tatas <michail.tatas@gmail=
.com> wrote:
>
> Make cleanup functions return void since no one is checking
> their return values
>
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
