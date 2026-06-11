Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553FCCD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EC310ED66;
	Thu, 11 Jun 2026 07:56:01 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 168F710ED66
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:56:01 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-59e23d70dfaso2614967e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 00:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781164560; x=1781769360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QWA/oASaoEGszjXXYseH4EEvJ11J7t3dPdy+riQNNw=;
 b=YltIgCv8ioJi9kq3/vD8P/FRSyaabhT6PdwoKFxUWxICV9trSMvpJEcUPwdx1tT6IV
 thQH9NSPYhD2ixAeVhx4jIlSZsR/khSApj6rmU3smpwI3WJtRL/lg0L4ttDRF44Uugyz
 5Qho8rkwJ4Fbucia6gEvH2nirssIazThpd5RTUaGLF6+z76a4WrrTEqj0+NYi+epHFSq
 Ybw/Ya2cUdYjfMi0JiefP9aihaCtVpZquLcM13zfRI3Unbg7IErll+cog6WngjOORW9w
 sMCjgcD+btIT+FAvUznfO4UxnH+O1Hbz9OLEjtmbz+jpwxaLpS6mGPyOcRg6v/nhMh0o
 nicg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/r8pJfQqnMBS9eo9CIpc+ulVtbMJgu2BMY336L901/pP3GAFYoj3rGbt1sq8bIAd8wgKtz2ueBtXk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjHoOrBup3rWNlbEP0MBO/bczzFhy2R0yLptkVWvSrmTISBqr6
 tK7kLkYtdPcbpEvsWic5tIa//uMmBQ+iL8YdDr9CqYruYNac+eapXw7GuuPV63RjoE0=
X-Gm-Gg: Acq92OGVZwlMf9UaTbe6pkcNvq/eWPzSHLT23xD4Mf8Ih6lYGUuhYWkZTJvtgAmpTww
 LqLFkxTEgxIxoK1sj+R5ekudnSCgblSTupnus2sgeqpEDCV+oGSS2qMyywgDtccOcFO0KR8QE0d
 bmBdP/Tlk9oRDSFPDsVMzHQF8zBLtuWW5TmnGo7ss8gSjFrpYZjs2n0cx7j8RKlUfu0lgbbggf+
 2FEUOWjN1HQ/FJrb02JtYi5+HWjL9CGsSRwRuI5kj3r/OSEL8XRrgk99sR2q+eud9TCzrNQlEQg
 aFQg8h0HmTnHneYswzAShQxpS26B2yvH1RZnry5yxo/FQWypNUtNWk8Pp2EIAT037iCKb0GjC0i
 ksDThfgA72BlKdtxQVZwyIRXRbBDT7DHDB6OkwTSY96vXlhm2fPonL3BF86vJerGRvfuUSPydnV
 UHJaeDVOd3tvtlvODZED31K2Dio+cDlauZm7wCmqP8mzDEnjDMLtUUe/N3nhZlUT/wPUR1Ol9s8
 sFDp2sSbg==
X-Received: by 2002:a05:6122:2895:b0:573:a6f2:65f with SMTP id
 71dfb90a1353d-5bafe94315fmr399786e0c.6.1781164560030; 
 Thu, 11 Jun 2026 00:56:00 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com.
 [209.85.217.53]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb0e17f196sm727371e0c.15.2026.06.11.00.55.58
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 00:55:59 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-6cfdcc79789so2998436137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 00:55:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/y9LdrRSSeg+ye4QAq59ENKSkCIelQHe3F9+zniWBvyQRFLvH3NfCX5sgwv6zzZwufn5V5qNPCN4g=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3e02:b0:6d3:aad5:6d2d with SMTP id
 ada2fe7eead31-71d5f2c9e58mr483488137.18.1781164558613; Thu, 11 Jun 2026
 00:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260611005952.146825-1-marek.vasut+renesas@mailbox.org>
 <20260611005952.146825-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260611005952.146825-3-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Jun 2026 09:55:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXZASW=5v55QqsSjt0y_0Cf-3H4xuVYcQO96spfvQevug@mail.gmail.com>
X-Gm-Features: AVVi8Cc4jIWBETm4Ynpi7szi6_VsDVkjFdXWa9mml-KaDUYCZmOXsqOLYp1ugKQ
Message-ID: <CAMuHMdXZASW=5v55QqsSjt0y_0Cf-3H4xuVYcQO96spfvQevug@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: r8a77965-ulcb: Enable GPU support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Frank Binns <frank.binns@imgtec.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Magnus Damm <magnus.damm@gmail.com>, Matt Coster <matt.coster@imgtec.com>, 
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
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

On Thu, 11 Jun 2026 at 03:00, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Enable GPU on M3NULCB with R-Car M3-N.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
