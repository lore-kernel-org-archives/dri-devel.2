Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3959606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=m+Dq0sq+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C32110E377;
	Wed, 18 Nov 2026 03:59:50 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF7C10E377
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 03:59:44 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c50933bdf4bso110192866b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794974382; x=1795579182;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IOskFv7B1qRwSI1xnDutWFbR8KW2ByneEJ1ja9wWCsE=;
 b=m+Dq0sq++Q2OoIlM2wcbLpek4rQ5Ou++JhHf++lCfesgE95h9gazonQ/pOZvuODtNw
 Oo2hu9CV8ODsPehpdhUyKJ56uwlNOy6uwRCZ//SP/17iLGCGsSYaQA2ch45P7Rf2dF30
 DT0r2I5Kb2fVBKy43/OkOjzhBtbp4RzOEVZS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794974382; x=1795579182;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IOskFv7B1qRwSI1xnDutWFbR8KW2ByneEJ1ja9wWCsE=;
 b=pP6OUd6x1rSM7ZGxN/Moerp4y35RgR5BWuMqWxlIkhirQgVH0butoQYsniNBr58YkG
 7yFObfvYsDslI3hSd0sHE/WGJnXVT7o1prqSSgDws3Jun/UoFuOSEgC+J9ijMhSrxR4r
 u0s3jsqbnCrRG3qfX6KziqA+cl5f4n6KhqQQxxDKY/WoTJ53MaGtwSHRxonouDAX4KUV
 bXCPDlFXz5kTGp7jxyVYxMs8kKPdVPK52hKlBIQHaPCoIM7IfHapNYAVF45VpMMujvmL
 5oSFBoqGDObFl/YYat3iK5hqUXJ+tchtRePmKwhrGkdg2pstnV7Ybg0xCv2sshJnY52Q
 bWcg==
X-Forwarded-Encrypted: i=1;
 AL+hErGG8sWLdImFXumB3SS1ZrCPU7zsKk309+iyq3fKTRwykYAQJ7rErzqvC5hCTX3FS5ro4K6qhK7l9CM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9w6MfOVZlAnBUc4jPzP/B1ikU8NWqHgRH6Cme2BLeT+CDaspM1
 tWjhClYYtY+INf8zsMtzC1ifbRVdNF00LJ98dkd9kYLnAAZ9VJ0t3eza3TDE5jnOl+3vZmvroMl
 C+Y7tOft6
X-Gm-Gg: AYBFou1OjCuZgWgacJ0zM/yRRp+sIGYYImuKfGFcCdrnJpedc4v4UKMV+uEwast1zwi
 L3/ytQ4tlL5ewRGg2486LLO7mo1SrR8vRFummhKkBtY/YMRhI2Y/AhV3av+zU7oI5qj4LWtC9j6
 rI9F4VgM0oNyVQ3VQF3FeC6VAJQgaQyNsxkdhgx2rRgh90cyYM52C1GWeOUavEsISDE7KthTKOf
 1LRnbzGnmNL/Gefd6VivKFMFJwrGItXSO5SNhzoB9xW+6Qlr/jiQfhd8aXGU4YoAn4CEBMmLQMI
 zRqzv72z28A3NCVvswS3BnYgKahLGa9H9gWQcRPIrTHKhZan86wim+rApHjBSJnbN9kdtgqnG67
 RM+Pxm4NMBvdcGm9H9F6V7A1xs4GROz8WgpmWLfeINmalcqpa+CEJd5oiLXEPmgb1sC/b5gVijK
 7I8oFfV6nWE3A9THTu3wqXkJMAtyiGh0NkRgAdu2ffQ94eS0D9kU6dZAWT0GR1aBxEV78CfMBYz
 uF3qYt/7pvpzNo3ItQiMbwMElVQTH8FMgb+rCQGY5KipbHtJKzLJVjk+OBBIwx9qRbLOqasnsT8
 ZaSrgEIBAPBjyEchcfbcVrkElCk8Zi92K/EvrgKFnMc2Ywl2g2IjT40n1A2m+QP0swgj
X-Received: by 2002:a17:907:7b8c:b0:c4d:7d2c:c350 with SMTP id
 a640c23a62f3a-c50f320a6a1mr428695666b.1.1794974382124; 
 Tue, 17 Nov 2026 19:59:42 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com.
 [209.85.208.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c510cab3962sm50876966b.57.2026.11.17.19.59.41
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 19:59:41 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6b87a1a2babso1794399a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:59:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErHcwgPU6FuWUtu0tQsq3wgPj/it5NVqmiPA2/Rwz9IbqHUTe0eSuOkMNiSbrfferQJzFpQeFcMv5Wg=@lists.freedesktop.org
X-Received: by 2002:a05:6000:2893:b0:498:364d:7509 with SMTP id
 ffacd0b85a97d-4a3774cbbbamr10035694f8f.24.1794974022637; Tue, 17 Nov 2026
 19:53:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-reform2-internal-panel-v1-0-765cf8d5ff4f@igalia.com>
 <20261116-reform2-internal-panel-v1-1-765cf8d5ff4f@igalia.com>
In-Reply-To: <20261116-reform2-internal-panel-v1-1-765cf8d5ff4f@igalia.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 17 Nov 2026 19:53:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XQ0Nw6tuUjr_pC_DQnWQZ0XD=jH+_djvbduQSd3XSrcg@mail.gmail.com>
X-Gm-Features: Aa3M54pcJVKrzVh9hl7PlSfdr6bBBDt4Ls2uHxZOi9oF_y8egwxD6E6UxsIqAlM
Message-ID: <CAD=FV=XQ0Nw6tuUjr_pC_DQnWQZ0XD=jH+_djvbduQSd3XSrcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel-edp: Fix Innolux N125HCE-GN1 mode
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Lucas Stach <dev@lynxeye.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, "Lukas F. Hartmann" <lukas@mntre.com>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Christian Gmeiner <cgmeiner@igalia.com>
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

On Mon, Nov 16, 2026 at 4:11=E2=80=AFAM Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:
>
> From: Christian Gmeiner <cgmeiner@igalia.com>
>
> The mode has a pixel clock of 162 MHz, which is 70 Hz. The EDID of the
> panel only has 60 Hz and 40 Hz. Output of edid-decode:
>
>   DTD 1:  1920x1080   60.001038 Hz  16:9     66.721 kHz    138.780000 MHz
>                Hfront   46 Hsync  30 Hback   84 Hpol P
>                Vfront    2 Vsync   4 Vback   26 Vpol N
>   DTD 2:  1920x1080   40.000692 Hz  16:9     44.481 kHz     92.520000 MHz
>                Hfront   46 Hsync  30 Hback   84 Hpol P
>                Vfront    2 Vsync   4 Vback   26 Vpol N
>
> On the MNT Reform 2 with i.MX8MQ the picture flickers at 70 Hz. Use the
> 60 Hz timing from the EDID.
>
> Fixes: a14c6b0eef77 ("panel-simple: add Innolux N125HCE-GN1")
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Hmmm, this worries me a little bit. I know that on some boards people
purposely set a clock rate that didn't match the EDID because it was
the only rate achievable with the PLLs available. It kinda seems like
that's the case for at least one user of this board. In commit
eb893e34309c ("arm64: dts: mnt-reform2: add internal display
support"), for instance, I see:

> Clocking
> is derived from a system PLL, which provides quite good rate matching
> for the single supported display mode and keeps the video PLL free for
> usage with the external display, which isn't supported yet.

By picking a different rate here, you might break someone's setup.
...or is that your setup?

FWIW, it would be better to change how the panel is expressed in the
device tree rather than changing this mode. Can you change to using
the generic "edp-panel" under the AUX bus? Then everything just comes
from the EDID anyway.

-Doug
