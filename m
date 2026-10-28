Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865AF606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R9mHpWNt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D94C210E51C;
	Wed, 28 Oct 2026 04:57:23 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA91B10E51C
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 04:57:17 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-3a98fc80925so5915971fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 21:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793163436; cv=none;
 d=google.com; s=arc-20260327;
 b=hAI+XQAKVCOERS8atuUTM14a5W4GB10zI6OYFyn2ZFrDWxnQuSWiC0eO50QGGrKgXp
 sks6F/+vJakhUDf306DiC3/vX0phzMGFXOfz2il6EvxnvXPis/kFrcSNYx1YmZ+GaiwX
 pls1hSKWM6+u3Arf8SUw80hRVvWIcD+V8BJ5Uxw0RsLrV9hb8keGvDKBExcXvHIxzSTC
 T9WH7+s5ybWglrlzb/qsg6Ov9GXywoST08GqDHj6TjQoadmJtbCYyIQKFmdJCGCdsJkd
 V3KalK1ryeDndzcz/SbcPxEk94cC+tUp84LZYF0gR6vpvJ2/WxZteLvlnA13JpexQCEm
 g2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OZDzrby98zAkp+RBN2RFww3mthQeJbbd06e824FJn0Y=;
 fh=yBW8gHWMT+gZWhQfuULaoYk9d7Ch0VkRRREnf0rpUok=;
 b=d21pDTQoiLsT04u+/yEkHCzX33UMKi1kRuWf5zIYycltLYxG7ud1ZdZ2VmbekySOSU
 6tXwZdC7XGTwPI41n6DVS7foiX4hI2JxfQPK/ihgIqgTb9/Ug5CiV7BsIDzWN/P2DtXa
 RqQzEw9UUh7V0m3pa3Tavr6Bs9nfFA2fI4zp08yfYGGYvEoBfyIBNkDUXAfTJy2gn6v4
 MKkP1iUz1RjBalQZa3CtW5gYgOlMdyhx9aTb278A4cNHvJrXQK+hW/Hjh6mDcvAs5Gij
 KP9+BDuFbTXCroXf38mrO3Cs4FyhYeoFsybqUPkxOXgdXhfRFQeU5R5AutFQhe3OqT7O
 URyg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793163436; x=1793768236; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OZDzrby98zAkp+RBN2RFww3mthQeJbbd06e824FJn0Y=;
 b=R9mHpWNtYiZ2a5I8Web8HKpNvFaoJD7CHCASpw4y4GZMx6BrQ4PLa/IhwvPM+oWzRa
 qy51sX5LhkPRYVpFKxrO4NWyTN7vUo0cdFCN3PuQ7de7KVT1C0IcZYSMm0+fIFHLA1v+
 iP1tY0L2l+pTATRXrQFSDo1vBGwOKhKdP2n8JQNJcKtHF/1hsUESEOo/huYxDXWSmTH6
 nHl0Nvk0bSxlEGP+MruZOlDjHk37oylglu2TEX4UBjmEuU/9KtU8o57nDrkJZqrzSDDh
 F6V4t4R8ALEfTdTXlbJXZuVP0aCQninxonIV4pjaVkGzQ0ry06LaN9YMSl8uzRH10QJT
 mkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793163436; x=1793768236;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OZDzrby98zAkp+RBN2RFww3mthQeJbbd06e824FJn0Y=;
 b=bU4CuOYdv1nVmILJRAx4D7yswimTO+iIWqjJspD7OiYhoDhrkUod2AuBR7vPmnTkwZ
 ahRLXuErupptdp1jOnYC7j/fewGwknr72vfV4Qnrl7v/eCIxI+Sbz1Pm2tLwq8fMgP0E
 IIeqhVlN0OQTdsgeHYCJ/2sefse8pnGPvPBrZTV7qGBwUAQcvSS1LJBv1xNOoDlumrqB
 683toJxFXRIJ7z/SiJ9GObNEpjreqw3huqXKKV+NNzE7iD1DGTuwKkn769DMDSmZxKyI
 K63kBlvVl/ncnAnbgKQIshLHsebSXhZedfDEE1jDdXOZmvFJuQgalx8K5bDqFYWgBxja
 ncxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByK6XSLv69KcXetDrD8cbYKf2/LdfXzUYI/ojYpzOEaWbdEMqlRYOvrPhfWenP67n/OT4OcxEjgk88=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJGJsRQmJVmE9CV5KcppA3iPJXBevGOZrFSKaifU+Gb9MZQhSvO
 rWGSAiQ+fYYfZboSP0bnRsttbvhXc81gb2jo+HmsuXeDnHFXPqJPJnc39JntA0zymrzFKBPWy50
 a0mwOsZityhmNG3UNxtWk+OR9wgPmPso=
X-Gm-Gg: AYBFou024TaWDwqFwS+oTwWGEYkp3GDMWuwIEVVpOw5RHvn0gDGuuMd0b3qbKLnVecg
 BplW7yusinPgjjY8BE54cVvuVPSYvR80ggiZFaFqgAqSDEVLJu23m/LSU2wDvnaQ6uJfmGeXN6c
 JGz5B0Kut39g+CJEqFUayhMksaAYz8CHzr33QuD8jrsvKv6e5uMUEVsqvZFJt5z044Bv/CHaOwm
 7YkwNiJA8Ja40a/CxiSnkgyKWC0ajEeQk0cN0jo2SSOP8GkL+1qWqVPOU5aBgRtlc5jY5YktLWx
 F/Fgrsiy0U+VMqBMhawrDeCC6L7wJyqtlOd58FkOKlR76LXhGThbzjpRenj/Fcr7bFnrVwsVuyP
 aoV9dzUr03F8IbkxOHBEltPUDuKTB2hySJQdhBY1qshHPBRNDqQGqFn4ECzX4tMe6GSsgXNUvsn
 rBQKigoWVCqEhDsZfj9hGhkiOLmA==
X-Received: by 2002:a05:651c:545:b0:3ab:3f1c:c2c8 with SMTP id
 38308e7fff4ca-3ac9cd1c35fmr2385451fa.0.1793163435483; Tue, 27 Oct 2026
 21:57:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028020147.2014466-1-matthew.schwartz@linux.dev>
In-Reply-To: <20261028020147.2014466-1-matthew.schwartz@linux.dev>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 27 Oct 2026 23:57:04 -0500
X-Gm-Features: AclHuK9MsG3Srq6acawczlgwAiHex2zY6MicKJ4lS3tOP-Ts2G9ypKxJ3PSeqik
Message-ID: <CALHNRZ9f8ZTnc0LnAJ+YPRYKA9D1=tvY=Ce6bf=91O=WWU6XmA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: chipwealth-ch13726a: Fix dark grays rendering
 green at 120 Hz
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Teguh Sobirin <teguh@sobir.in>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 9:02=E2=80=AFPM Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> The init sequence writes 0xf0 0x50 followed by 0xb9 0x00. The panel
> configuration in the Thor's stock Android firmware (decompiled from its
> devicetree overlay, dtbo.img) has two runtime command sequences that
> differ only in the 0xb9 value, both "display off; f0 50; b9 xx; display
> on":
>
>   qcom,mdss-dsi-ram-command:        b9 11
>   qcom,mdss-dsi-bypass-ram-command: b9 00
>
> With 0x00, in the 120 Hz mode, a full-screen gray ramp from black to
> white, shown with identity color management, renders black as green and
> the darkest grays as bright green, both at maximum and at reduced
> brightness, and the tint is more noticeable at lower brightness. The
> 60 Hz mode renders it correctly. With 0x11 the ramp renders correctly in
> both modes and the panel dims without a color shift.
>
> Use 0x11, the value from the vendor's ram-command sequence, instead.
>
> Fixes: 3ee01b8647b5 ("drm/panel: Add panel driver for ChipWealth CH13726A=
 based panels")
> Reported-by: Aaron Kling <webgeek1234@gmail.com>
> Link: https://lore.kernel.org/all/20260727-ch13726a-washout-v1-1-bf869ddf=
c5cf@gmail.com/
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
> Aaron, this should be the 120 Hz issue from your washout patch; could
> you give it a try on your Thor? I found the issue here separately and
> saw your patch as I was prepping for submission, and I bet I was seeing
> the same bug you originally saw.

This is something we tried before. And best we can tell, enabling gram
limits frame rate to 60hz on this panel. Framerate tests such as the
ufo test were reporting 60 when set up like this. Can you verify the
refresh rate on your device?

Aaron

>  drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/=
gpu/drm/panel/panel-chipwealth-ch13726a.c
> index 562dc573528d..0832e49b77a9 100644
> --- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> +++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> @@ -65,7 +65,8 @@ static int ch13726a_on(struct ch13726a_panel *ctx)
>         ctx->dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
>
>         mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x50);
> -       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x00);
> +       /* 0x00 (the vendor "bypass ram" sequence) renders near-black as =
green */
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x11);
>
>         mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>
>
> base-commit: 8ef66514d7b993c9fb96a5886f001e3556610c1c
> --
> 2.56.0
>
