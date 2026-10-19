Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9829606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=icol5Wls
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084EC10E16B;
	Mon, 19 Oct 2026 18:46:45 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B946C10EAAC
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 18:46:38 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c2dc63f8d8aso400846466b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792435597; x=1793040397;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GrZgAedNjjfc1Cat6H/JuMrMooH5xXHjvJkahsdj4AA=;
 b=icol5Wlso0YOl8VFKrsBbPrz+EVMrcck/86k79SX+bzEQADG1Bd1ctdaJgQdo30Yz2
 fG+Hn21aMxrNmNsAUYj2oabp7JdkD3fyfQ4NY6LY5oi8EFxvZryYKHio6TD+bmU7ECg4
 NpNc1868delsrlUyx2e4jWWg1uIcBji8K/jGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792435597; x=1793040397;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GrZgAedNjjfc1Cat6H/JuMrMooH5xXHjvJkahsdj4AA=;
 b=BL3+Drm2jHMSnKjXgLVQRKctCXls+D4Y2IlyXGRtexYYQZLBC6GLULiS0U4H3zmZ8Q
 K8xL5vg1yKdUr4MFdJTftPmVC1LZhdQREu+CCo1AUd/VF7GcaMGfQywR/mTn4g12DxcS
 wbf5dUJvMmFGPz3Qth5GCVy/ahA4Zv/Wo/elSgYIF7XfjJvcpOwCxblC87EdWNwY3IJv
 b4KwmLzcC0Zhi8ygXQcF5gErC0pvTky3kaUDbYTFqHBk05yIlCnoDAaUrJZVIt2XEBP5
 Kc1qfper/Z46CdENMzRenTUi2qOYcQcqgaNQJ/JrRTR7/tsaKr/5KxfFbWiTFI+Xg/7j
 8/XQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1tdYQVqNM/Of3ttgczStsKZyEA79/ovGY7/vOdYYnrnNhp9jtwKxJ74B/a6x7WeZPk74DgtJyLp8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLBJPT74vnmBafYWDARJz0hhXytd6MB7M/TQkgS6RvG9lwCIUJ8
 r7EkMZYtD3dtUIeN9p86gdUxxf/dtNA48ImkLQ34ROdukHolovmnm1KCn3CnKi1QRzhtxFUZR1Q
 24eEuMw==
X-Gm-Gg: AYBFou3eXcZunPRGqvbFCvfeli9Pe0Mx08R7mpyR+8F4AMRihpYaoc+DsZqHlyxgsbi
 VXrAuqbBbbxS4JAcDGG81ZHyLwuE3qF7LJPPpdosmsU4jHdGC7mwdqVhmOJ4H7gLipNWAPI+flv
 Dt7vdqY4PDdlVMTSG98Er9QsLJKdWeridaqE6WBUYgaghq3mXu6HC/wQ6fOphzWBC7qV0hSAAit
 mQlAo+5zNqADsCGIE0cFd2VFq5L2OwXYqf5fLUwfuLGsS1UQ35jjuifgH4lsv7jNIqUg0r8LjxS
 KiR8idK6/7zz/s/z5C3Wi7G8EuVcN4+iYaLl57zaMX69E4LZ74RxlepS2WS4McSpIggCZcsI9/k
 y6SGJHLDizlbuMTySbznYMBn1A9IRXZkTeTxQfONgh2hivnISL62Y3ybGMiL5qHQS96zTlGri30
 C7B3aryRKUgov2btkYgkFyEKdKA64xHfx+SLgQiv6TpeyRzP3g2CO3kxn47w1uGAL0zT/VF+qY+
 xlJHqrWQMglmIHVEmdNPsflUYCR76C2yLQJlZ2ld/2bLm42Pco0gJmd7dfuMVeBRESQ2Q8WZDE/
 g7dg/9z365EDye7Worza38A/doe/hiFTuwzDkbNm
X-Received: by 2002:a17:907:3c8f:b0:c29:f5d8:9c6b with SMTP id
 a640c23a62f3a-c419e639332mr626315866b.26.1792435597064; 
 Mon, 19 Oct 2026 11:46:37 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com.
 [209.85.128.53]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4091eb1762sm405321266b.73.2026.10.19.11.46.35
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 11:46:35 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1e266fca2so10549875e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:46:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwVrWgcUkJ8JQSsDHdservUmqWMfAdUANg7149t1G7rz5HrLoM3MLD/8d0ssRXNzmBiXwEhDEVR5uY=@lists.freedesktop.org
X-Received: by 2002:a05:600c:1395:b0:4a1:d73d:4137 with SMTP id
 5b1f17b1804b1-4a1d760f94dmr197402015e9.28.1792435594264; Mon, 19 Oct 2026
 11:46:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014235035.1731419-1-luke@phorex.org>
In-Reply-To: <20261014235035.1731419-1-luke@phorex.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 19 Oct 2026 11:46:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U51TQF8r1Afv5D6HkRcE6CpnFJDJ_H1S+N6VGFaj9zLw@mail.gmail.com>
X-Gm-Features: AclHuK-9HZBpXRo11uBNzUEGmEbKurAg5Xd6yd5l18lGII7-MYI5avJghYF_wM0
Message-ID: <CAD=FV=U51TQF8r1Afv5D6HkRcE6CpnFJDJ_H1S+N6VGFaj9zLw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add BOE NE140WUM-N41 (0x0d9b) panel
To: Luke Macken <luke@phorex.org>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed, Oct 14, 2026 at 4:51=E2=80=AFPM Luke Macken <luke@phorex.org> wrote=
:
>
> The Lenovo ThinkPad T14s Gen 7 (Snapdragon X2 Elite) uses this 14"
> 1920x1200 panel. Without an entry panel-edp warns at every boot ("Unknown
> panel BOE 0x0d9b, using conservative timings").
>
> The panel's timing requirements are not published, so use the same delays
> as the other BOE NE140WUM entries (delay_200_500_e80). With them the pane=
l
> trains and lights up reliably on this machine.
>
> Assisted-by: LLM
> Signed-off-by: Luke Macken <luke@phorex.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Looks fine, but please follow the example of all other recent similar
patches and include the EDID in the commit message. Thanks!

-Doug
