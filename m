Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D519606A334
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=btTWV09n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6EAB10E192;
	Fri, 13 Nov 2026 20:36:54 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8FC10E192
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:36:48 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c505b2e1cb9so261378466b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794602206; x=1795207006;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1y8NVjB34PyHWKL2vr54yws1Tup4C1XdntOkDoibOvc=;
 b=btTWV09nTOlgwjfzuka0KsfwFTnK1EHq4USOP6D5h59u0F9FFc1MdnvIJ+3mryEMqW
 MMjY5br/8XgicVC7SVjZdWvcCJY29w+1SK9FdYbVA6HSsfMRwPCRh4HzOrSir5/N8r00
 4222AbwB/9gFSPYZtzZhqobP9BFVlV2JsSld4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794602206; x=1795207006;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1y8NVjB34PyHWKL2vr54yws1Tup4C1XdntOkDoibOvc=;
 b=Ksip37/kky1g45nsGjMbEvq4n4HRzHJsXwOXfIjzmtMbetdLFiI5sK2b17eWcNVqk2
 Slpjyd3/xGBRHdJSsuG4wLeMCXPqbpCaZppUgcmOb/xfTCCoF1XZf4KiDyqQWSIQWCL1
 zWiBe4+asMa4bYo1QRSOfwMvgoVBBHROThpCE8Ap7bZGtNcajvHuKThYF73OvO0+35gZ
 T0DLQLuYc3Uokmflt8Z9Mu1W4HVJHwmOiyVQ/qlIeUa81RxFX1GphEDkmVXNMKqn/YqU
 s+8q/zeux5kVkO+z6W5UbKIU+PL83F27OBeuwJA4g7DRrMGPlITJ7Nm8hI4lDs/HOyoN
 EQEQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGATFsGy1ke+D1P+a/1k/SAFeEvz6c4uD9uN7Lua3Y45sESrDI6je+wgE9Hmr8XvtMr9CC0xAig9lI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8WoDuNfPFFpH9xP7DElaxfhRtmKZKa76aVq3SP40p2rYVWp5q/
 Vn5jo0pMNdnHCxxIzPKGVA5CMd6EE1U7IOBVc543oO8l0Fs94u4QoWMAd9nb3MgTzUYHLwKWZiG
 LwwFM3xoJ
X-Gm-Gg: AYBFou27qZlixU5Qc4pJyUKO74PNzesZ3e7nkoGx85hujmbErFChl90mEMBN67ihZd6
 blLjOTOd7XMOC+jsak4pEYwnDZF6GaIdUCObqVSQ3klLf7QYEYuVPwewFflQhRhKACeMmZTR+gi
 dqG+t6Bww3OO+tgRNh89z9IuAe5ySEgXTNaKhEWfe38gaj1yUXIzl+F8dChep9L6FFfZhr4Emg4
 yErT7XsYLFn7/pJECYNXW2RJyz8WtbhLkp4N9VnXNbwO9qDOBaI/KJgAaDAXOnRHLhDTWPo2yK1
 LxdQl8+emeYgpQ0q5BWLp4Sg0nxcNuRPu13MijUPSza6TxC1vIiQP9LmugBmtIaUftAEUyMkeh1
 aWYgKUkMpkFHVPHRDq7T37qjh+ywARNFCSg6WJh2Lg0fJvK6Hn1bw7vBDAI2FNLAXdk5k9yJ/h7
 mQG0m2STuaAjZ3wQCoPzI/aql4+g7OII+18NSLlpCXCACCkl1etR4n7AEluFFf0gtCOBkvlyT7a
 lhPQRqegpg2tp2R7joaMSfODXTh9uLGNFsiWdLR2wdeob6ja+hbhCR7SQbFDxgpRAYSQ1++Afbs
 fVhycmXqGK6axCJGjgqeEGMpDR3UKdN0J0b2zwm5wj6FClhrdMK3DLYFdl899SE6643w
X-Received: by 2002:a17:906:c154:b0:c4d:18e2:e66c with SMTP id
 a640c23a62f3a-c5096369d85mr305670766b.18.1794602206573; 
 Fri, 13 Nov 2026 12:36:46 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com.
 [209.85.128.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b23b2asm137928166b.22.2026.11.13.12.36.43
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 12:36:44 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso18491495e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:36:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErF2Ccp48hVpexPdjeWLmiJY79/0/17nckBsNFwmO+bY3qNbwm5qsOlvr2TgpVsPhORMdrDYyvbhG3c=@lists.freedesktop.org
X-Received: by 2002:a05:600d:82c6:b0:4a7:9006:b176 with SMTP id
 5b1f17b1804b1-4bb55c5f5f5mr89863295e9.7.1794602202883; Fri, 13 Nov 2026
 12:36:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113171540.446-1-_@tawheed.cc>
In-Reply-To: <20261113171540.446-1-_@tawheed.cc>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Nov 2026 12:36:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UXEDzjuBF8QK0MccAkCB35MUXEoAhzCFgViUr2xtpOMw@mail.gmail.com>
X-Gm-Features: AclHuK9vk6BRndli2ewuhNI9ERAXzJsRsPjpVZzz0vGOWMoLJS_4XyO0TtIZQ8Q
Message-ID: <CAD=FV=UXEDzjuBF8QK0MccAkCB35MUXEoAhzCFgViUr2xtpOMw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add LGD LP129WT112684 panel
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

On Fri, Nov 13, 2026 at 9:16=E2=80=AFAM Tawheed Makhdoomi <_@tawheed.cc> wr=
ote:
>
> Add the LG Display LP129WT112684 12.9" 2880x1920 eDP panel used in the
> Microsoft Surface Pro X (SQ1). Without this entry the panel is driven
> with the conservative fallback timings and probe hits the "Unknown
> panel" WARN.
>
> I don't have a datasheet for this panel, so the timings are a guess
> based on similar panels: delay_200_500_e200_d200 is what the other LGD
> 12.9" panel in the table (0x06b2, LP129WT232166) and most other LGD
> entries use. With this entry the panel is detected and the display comes
> up on every one of the 38 boots logged so far on my Surface Pro X (SQ1).
>
> EDID, read from /sys/class/drm/card1-eDP-1/edid:
>
> 00 ff ff ff ff ff ff 00 30 e4 55 05 a0 28 09 00
> 00 1c 01 04 a5 1b 12 78 03 ee 95 a3 54 4c 99 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 de 8a 40 78 b0 80 37 70 30 20
> 55 04 12 b7 10 00 00 19 00 00 00 fd 00 1e 3c 00
> 00 24 04 0a 48 14 14 14 14 00 00 00 00 fe 00 4c
> 47 44 5f 44 56 31 2e 30 5f 0a 20 20 00 00 00 fe
> 00 4c 50 31 32 39 57 54 31 31 32 36 38 34 00 41
>
>   Manufacturer: LGD
>   Model: 0x0555
>   Made in: 2018
>   Alphanumeric data strings: 'LGD_DV1.0_', 'LP129WT112684'
>   DTD 1: 2880x1920 60.000 Hz 3:2 (274 mm x 183 mm), pixel clock 355.50 MH=
z
>
> Signed-off-by: Tawheed Makhdoomi <_@tawheed.cc>
> ---
> Changes in v2:
> - Include the EDID in the commit message.
> - Say explicitly that the timings are a guess (no datasheet) and how
>   they were picked, as Doug asked.
> - v1: https://lore.kernel.org/r/20261112154444.417-1-_@tawheed.cc
>
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add LGD LP129WT112684 panel
      commit: fc72cd52fb284f3707fa36a68ea5a22543a51d71
