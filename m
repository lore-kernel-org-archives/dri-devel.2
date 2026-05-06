Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF400CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 14:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6576F10E1D0;
	Wed,  6 May 2026 14:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T4CqOWK2";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA7AE10E1D0
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 14:24:29 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-651c366f7efso6316805d50.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 07:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778077469; cv=none;
 d=google.com; s=arc-20240605;
 b=aU5gZ3mwqOKXxiwCI4G3qh/WtuCwWDZOhJm5gttFj0UFmEqBS87QwhhMIMoMKqOtIs
 NXO27dFd+BzzDXs5vC6Kt1ONbvspRx5tz5qclZTnjx9h1bckb8mi07ppwVzlj6i+Z+d4
 lL4WkE0WHGwObShz1eSxAm9kwmIlPxoSzZcdjDAn+rts1oIcbXs8E4UrYNXWTkJFo6Kw
 jOsIZYBfMgMky/VXaaoWIhoo5NXmJLInLuhGEQmYHDqfLZY6i792mIL+BHY02grL8dkg
 Vd0RLBMxyUQjRx5NhPxkEBE8eScdQy7tngTD4evUCNXisDLbMR74Q5ZZDSmBMGvIGupq
 p1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5RGPGtjg6gfxQd5la71FcBlakZT2mGW9DnwBFYIWLZk=;
 fh=wRoCWJ1a/me77VsvZy9YzM2SGwf8AbVL7dbYLQDxfKU=;
 b=M3w4FF5wOjzCEpP659nw/mqZxDbQzwab8aoBkzwARf5WjXQaRvwLuNZ+DiORqF/Bkv
 JckIyLlEEaxC+2/6HaeBGFkuSItpfAKlCOTeNsqUodT1Hz2daPok7WA3peIqQ2M45zpi
 ai3WaIfjy/Gay3DYUWTMoct8MOzip07iuCnXcyrb38CnRsSfivxp5IrxAKZK7MNhBMP6
 yRxj9XwzY9KzsJw56nGbE/ZknRepv8tC+1kU14WqtkeAgiuImEUwqAki5Gdix2bYAdib
 JUscRbp/UQFsTViZjwUVEGpeTu1xYF4J5eA5q6JNV4SQXdtyOChfZebwj3rPcJbP0Whm
 7PmA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778077469; x=1778682269; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5RGPGtjg6gfxQd5la71FcBlakZT2mGW9DnwBFYIWLZk=;
 b=T4CqOWK2q2vXLuOcQI7G+VfDNNhNe5Gc9KBoXAWJL1T2hs2VbVmCvXELsheGiVNVkI
 FHms9ChGhm4h7LO6yLd1Ih1xa7Es0kgG9VqYxFlPqg8XZrthn236xPc3m4xonx77RXg0
 u3e5eFWgw+4x8rVMeDNXGEmBhLb3Zcf+0NbIawAHxGXKu1mHklUIF2qzxY0vQ3RKZxIs
 3YJFiZbez2C3FSHdliX5YFomLQHCUCwtP4NG6eU6SVk4iMErh5+/Ek3BCNKF9loANEFS
 R0bDmYl1OFXTr9DpZTZA3vl7m4iC/BHAWsQLzdqvNUPHbU8v2FfuU7l986CBRBA2NcVN
 Uq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778077469; x=1778682269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RGPGtjg6gfxQd5la71FcBlakZT2mGW9DnwBFYIWLZk=;
 b=qbEoxbo1iG4+8UbAYLUMfkOmXRZG1ju+6LT9n60RxPR+7L5MKvXEs7UeuQw3/3EKNn
 fNf5twhzTwoZ+HlsLw8ugIolxMmFH4ubFzRplHkFtwgga/UReIF/fqBw61PV0Wp3J7Wg
 kbkbhbtN0AFCTLCQGN+WSl5OtTiIah24eML+SAwJ525GYwVYI4iC2U8dFZ53nokSlxuz
 tOcRuHEhPB4kblQe9Qck5pNHWZ4lnwpwxIFCYgTuaXv1LsmlcF3skTOy0hnzwdyvTpsT
 uVdd3WjiXuIpjz6VF+dm7W6Ts3zmYsSIeBsGHTfJ1jdqKmmp0lxe7l9xjet/t/sC7ZLY
 6dWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+162dmCC0z2hnwfbi3buy6GEm3xhffj0cnnBPRWPSIuVAcyMg4F6zZbvxFjCVk1WIzsK3JJ23SpUc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAARyaiNUywHmpOMkqcBBiUJdksWnchXwLNLPID7TzBGD+3o+x
 AKokp3wbv+OOgaA6myAS0OMsT9OTgy/f4zySdFfgkm/ATi0NUz7Q4muFfdaEw0K4Hee+bHPPlck
 owSNJGIRcMk0vhoFxvz02Dc9fBlTEJ38=
X-Gm-Gg: AeBDieuWTyCXzE+Fv1ZGnDFOog7aGYOjucoW+DedsBUBG40yFgsUK152T+iV3tooAsr
 0k2+/t8S/FH9XJ0N/U+xVgR86D+bnZvG2JEqq2m2TXfvk4qys9P5xvxKRZ6r1pmuMzMh/GuW/Si
 j1eTBwAy0HmmN4Vo7yzbXpZ17L+RnoXMudWdmEDXEUPfC4Bs39boz68p73fcjKRX2qpN9nxfURa
 B6TT+g47NnHCN3uBVDwmIP48jWKe+4izlqGpLqlLf50vrh6kKLD5Q/Y82Dop7FcDxslxEz3T0b9
 JnEzpHAU3gj7ejuNwmo=
X-Received: by 2002:a05:690e:4844:b0:650:6cb:a720 with SMTP id
 956f58d0204a3-65c7999803bmr2796421d50.39.1778077468595; Wed, 06 May 2026
 07:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260506092324.635014-1-lgs201920130244@gmail.com>
 <afsO9TxVuz79FFQ0@raspi>
 <CANUHTR8PNO-3hfEMCz4Zz_2ERLonE7OyNzPWtAaDtVpNB=YGhw@mail.gmail.com>
In-Reply-To: <CANUHTR8PNO-3hfEMCz4Zz_2ERLonE7OyNzPWtAaDtVpNB=YGhw@mail.gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 6 May 2026 22:24:17 +0800
X-Gm-Features: AVHnY4KKgBYwbo8b0KFKRUex7D8jzHNmM2otoNT3MCUewJRlzLyKPSEF6hD8vf0
Message-ID: <CANUHTR_201tMArsXEjuPKW=drk5hfyfneG-sJDqScfxNLLM=Rg@mail.gmail.com>
Subject: Re: [PATCH v5] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Liu,

On Wed, 6 May 2026 at 21:58, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> I will also drop the unnecessary local NULL initialization for ep,
> since the helper initializes the output argument to NULL.
>
> I will send a v6.
>
> Best regards,
> Guangshuo

One correction to my previous reply: I will keep the local ep variable
in imx8qxp_pxl2dpi_find_next_bridge() initialized to NULL, since
checkpatch requires pointers with the __free attribute to be
initialized.

Best regards,
Guangshuo
