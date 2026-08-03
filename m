Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53369C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A052210E6E4;
	Mon,  3 Aug 2026 16:13:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dJgI7mtP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17F310E740
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:13:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C5B5660A9B
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4071F00A3F
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785773622;
 bh=P04brJjayLVgRWu73sAc2E+ndFKcA5q+VMy6bVRNWQ4=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=dJgI7mtPbMPLeWz5FC9RBdYVdLa9rfjw9KDXGCxB2qdjP7VSh14u19OoWN+qVawfD
 H25A+8QXl/Y3R4pLEJmc7ZiU39ggUpZD3T4M1DBvZn1woNJ7D5z8QyDBuQCQb6DKXT
 tW+BgqngYmG2HI/Qrg97uzWgapsbY/XT188Ccq3M99+uVkqBLUt9Zu8fXNQSV+gde7
 HISE0dGbqJbthdZgY7J0WyJ6O7BHg0uYNcuZ/lR3NkWL2aw4Y5KN9YRdsctf5iBz+X
 YI7QaA9JSlF4VtTle2MbAELwaOiz7bObT5SrWigdg5UI3Q4waz88YfjdyH2Y8jt9JF
 mKPMHfPlMoKxA==
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-39faa67fab8so3905061fa.2
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:13:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqtFPrWxVtIrHS0g0a24sgNQsfbE9XsfRxhO10xnWb0Uu3HCh+XkumTmZH+H/g49bWSwqBL2YtYT90=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwTO8o6bkzYbwBeFSMjsb8wVOWU96IkXmNchdZcm+cGKRO5Dko
 wryUygdIjUKtHFYT69qMNws0617WeMZMBU4VMX9twoa/D1uCkaW6jUykFhwI1gldru8q9DP7UvM
 M+fBrxtDdPWD1N0J9RUvmjVJgt2/ch5o=
X-Received: by 2002:a05:651c:150c:b0:39f:63d3:f1e2 with SMTP id
 38308e7fff4ca-39f864562f8mr20984431fa.40.1785773620744; Mon, 03 Aug 2026
 09:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <75ad4947981f2dc33fd42c05ae0b0cedda7647bd.1785772659.git.jernej.skrabec@gmail.com>
In-Reply-To: <75ad4947981f2dc33fd42c05ae0b0cedda7647bd.1785772659.git.jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Aug 2026 00:13:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v66AJ1Oucec-gZue_SU_q2s4K8oB5=8rvOgcGPaXKuk0gA@mail.gmail.com>
X-Gm-Features: AUfX_mz064VR1oGAUu4p4Wa4jv5ZeE5jPGOfMsUAPA8tv8awon34YrfM6Q_FSEI
Message-ID: <CAGb2v66AJ1Oucec-gZue_SU_q2s4K8oB5=8rvOgcGPaXKuk0gA@mail.gmail.com>
Subject: Re: [PATCH 01/13] drm/sun4i: Fix V3s YUV scanline size
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
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
Reply-To: wens@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Aug 4, 2026 at 12:11=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> The VI scaler line buffer on V3s can hold 1024 pixels for subsampled
> formats, not 2048 as currently claimed. Since coarse horizontal scaling
> is engaged only once the source width exceeds that limit, YUV layers
> wider than 1024 pixels are passed to the scaler unchanged and the
> output is corrupted.
>
> Use the value from the vendor driver.
>
> Fixes: 2586de70c15c ("drm/sun4i: Add VI scaler line size quirk for DE2/DE=
3")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Chen-Yu Tsai <wens@kernel.org>
