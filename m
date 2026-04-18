Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27228F99C63
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 01:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82BD10E2E4;
	Sat, 18 Apr 2026 01:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PCz59Jz1";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0294710E2E4
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 01:51:12 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-82f8892d4d6so601454b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 18:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776477072; x=1777081872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gj7SAePflqB3SH6bEs3kSf8AjrLM/HJ0qal797EEMsU=;
 b=PCz59Jz100lCW8L0GFrMzuFBxGyjdEr2A/DBuXG8ZKLEUXsHjFPyAHgHYE/os1ceCb
 hT6ADZ2BY8Ubxcj3LvSwqpSA/dJopOhr/W6VWNV9IxVsLx4iGSeggml53nzLRIiTiNlp
 ZMc1lb+RdWSPTfg+6tPh2SPG79Kl357n520g9RK0kydGIehI82gg3lnUpJHPNlmT8L/A
 fT2xc9W+IhhQJWLbjEfl2oOSQOYB6QCoXMjO/R18B1zX40+OKZDW87K3WcCvwOfkuCWR
 7unHFHMwakeiqehkSnHYx29T8xNMOKFSp1wd73bPywacG7h7WZU0M9rwOMLRj8uk72K1
 vZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776477072; x=1777081872;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gj7SAePflqB3SH6bEs3kSf8AjrLM/HJ0qal797EEMsU=;
 b=S58zITR0KN9jn8YZgxGGJy0uap2WP9nARAhnyX97kh0RjMJw3jITs9J2oBOV8UuhL9
 BQaEDNWzj38Rw/8UnB1cc0xmQRYeWToh+y9BgV/CsAOhsonxkmOh4Ih8upx3OTQg5VnV
 sruDI4hzDC9B5d0ohvU/Gp7WP3KnQobURBq6jgzPvTZWTmJK7azi7yPVTtDKCzXHcZoe
 uYAAKCgofKwsSG1+Dj62XXW0z5ek88wHRYfrzN7fi1fc2HXz0fvYf7nhXofFji8zPxjx
 3cd25MDN8qgCcq+n2RWo15sX7+NarzqRSD+sAMeuNB1Jvj4RCUoZqcluikkSaspMSMHb
 mjjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+p/vmKH/l4I81I2GhWbpUJCm1BACBUI+sAIm6HOBSsE0PHQA4iVMHnhk7ogS8uCk6NPzxFCEZEgc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy19ZnxyaBe69i1tn3ei6d/jLAeDem2k68pkyaisE0Zz57SYhad
 4+ma2Aw73o7QDsgFxrhFVzfmwN3oeY4vYVoBsN9MVU86uckbnxVMeEJ9
X-Gm-Gg: AeBDieuTDECoj3RTbko3wtTCFUDO7BUOBNL/beciUES4gDherl/1njjvl97Of791bxw
 rVMTz15UlYkCvj2XUCXrrgpLfWSoVKmJ5fZH0E2IZMx9pc5N/PxBRHRb0m7EZCMwsEm0yFqUNpN
 roH6h5/+5TQ6enaMBT89Z1NG1yQ8MNn8kmVlRmdwVpg/eyYhfXTK8beQW0hrPIheKQczYoPRXXY
 OKetJ+58UjEx1R03pYC7BE/phADTO6NO56khK4UepITLHzPPUfizWH+tjCvUVZ7SXLCQLnVyFpc
 0QoMkMBOLDPPkSlp21VGrVgJPXdNJ8uCpit+ytGBiCpbOQTf0HPFAcXIbuasParZvBfSGP6RGqp
 Oj6V6iaX4K3Sq/7STpyGMAREtuKtmotG1YZAJi1aFsnPPa2x7XzRsQ1uhJA7/p/Ai23Mwv9oXv/
 xV6iaot/oacBm3R2280TNz4iSgWkv6IFaa448BJ28QPHhXrzXgizL2iJBeTPD0O716x4gwZVXmw
 7ZrXKaUipEBg1ULEYP7bzjBuAeHNtrHR6A98EmijaFMYUQtyQVoSUHcImPDQN2Z29i3/dAn21zM
 OKFHYg1RAtev
X-Received: by 2002:a05:6a00:94dc:b0:82c:24d5:63e6 with SMTP id
 d2e1a72fcca58-82f8c831e32mr5309850b3a.15.1776477072365; 
 Fri, 17 Apr 2026 18:51:12 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:6937:998c:4c76:85cd?
 ([2601:1c0:5780:9200:6937:998c:4c76:85cd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9d2fa9sm3345589b3a.16.2026.04.17.18.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 18:51:12 -0700 (PDT)
Message-ID: <9947777e-ad0e-4af2-ac43-a2bb91339966@gmail.com>
Date: Fri, 17 Apr 2026 18:51:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: novatek-nt36672a: Inline command sequences
To: Doug Anderson <dianders@chromium.org>
Cc: sumit.semwal@linaro.org, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260415235608.8138-1-chintanlike@gmail.com>
 <CAD=FV=UCyfjiqcpYCM5ePz-auX4g=i_+i78ivvvyA8R1XtAKzg@mail.gmail.com>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <CAD=FV=UCyfjiqcpYCM5ePz-auX4g=i_+i78ivvvyA8R1XtAKzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Doug,

> 
> While that may seem a lot less efficient, the design of
> mipi_dsi_dcs_write_seq_multi() limits the inefficiency. Writing things
> like the above also allows you to share code better. For instance, if
> a second panel is added to the driver that uses the same sequence of
> commands for "dimming enable", or setting the resolution, or turning
> on "UI" mode, you could create a helper function to share the code.
> That is impossible / awkward with the tables-based approach.
> 
> Eyeballing the table, you could also potentially optimize things a
> little bit if it matters. For instance, I see a big sequence of 0x80
> going to lots of registers (without seeing the panel datasheet, I
> don't know why). Potentially, you could do things like:
> 
>    for (uint8_t reg = 0x8b, i < 0xa0, i++)
>      mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x80);
> 
> I dunno if it's worth it. You could try running bloat-o-meter to see
> if the code is smaller, I guess...
> 
> [1] https://lore.kernel.org/r/CAD=FV=WtjW5WWmjeb2zwF2PjiJeZv1jZS_UKZ0bT1658=CkwVA@mail.gmail.com/

Thank you for the clarification and patience. I apologize for 
misunderstanding your initial feedback—I appreciate you taking the time 
to explain that the goal was to inline the command sequences as 
functions rather than simply removing the helper.

I will send v2.
