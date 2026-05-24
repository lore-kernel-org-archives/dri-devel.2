Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5D9CD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 21:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D5E10E076;
	Sun, 24 May 2026 21:21:01 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E6010E337
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 21:20:59 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5a8d1f43432so14540765e87.3
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 14:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779657658; x=1780262458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6w+/iSJRWut/D1sqx5dV3SWtkjaFwtBwoEXiJRSLQ+s=;
 b=DLc9RI0zQwnis34o8S9DrIn2irn82FM4qPjFVndpoSZp+Zi3J9MfhvaTD5FkQdU7Zz
 EpkaC8HUmEH/LbjSF9aD6oEmjsdaWcFKDC2AQrEqd94oJAfMt6u3okTw1DbOLz0aC/mx
 cTAvfz8LcSbNwgYxJ5K8qfzSQyjd4wqBrnZXyyabdD+dHis3J5vsaql9JQecvLBK1oiw
 alDmCCRPJOSZeXZFjn14cyibKVMperfLNNcDPCogyrdtqVzbHg5imHcjvvzHZxcrgco5
 lJRASD5n3pjvz6BkO12nGBecleJYy5Wmy9FR8hOhjGJk8iGSI5I2gbA538bRPtLYbHGr
 pAzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KrDmVRg039Me2QNxBRk7hsQAWZowD1S0aaeX+ClZLRU/khtQr1YQe2AnRY9iMiiIsYuMr9pUp/NY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZJrLYtlLYyVOquXRpnB4NzZSrSAQ13IzILj8VYI+p7u7XfyeT
 Z+/l6hhVeXcfXItX0wj+gChGt28ctkZrpXPviUJntsqUf2OsT+OHMu/BDvcXc0BLC8E=
X-Gm-Gg: Acq92OE5mRVLNNfE3Znsapyab5RjlySdhawIdo2IsQazyKCXLIGmGz2g0R1v92j+hIo
 1WE1KFHhrvwviVkRciE9ZYXIqDGNiSIio9lH0DttuvqM+7B1y6W87wjGvY6zFVSQ5QkZ1gnHg5d
 R34gQL0ULwkCynKMKMeSSvi/r78IZcnTbqW5R0p9VOCLIHbsJvl4mShWwX/E5qYi8fLaiNy8kUT
 nxUbCm1u+abMsEaW0xr0/5CnpzZLjpb1YthpA9jqGt4mEueuTWj7AoVeq4Y0mGHs4s5GIcKoqUo
 jh3SHFnpBvVS8PowfdDfqLsv/cRGKysxZgEXs/oSt/QCwHur60iL5esZ4yObwwZka4VdUTGP5Zw
 uw1RbvIM8MIz1HRT71MT7EaeqWIRv5erS9p1uXF6X9WolLeBtkW2zPFZmiWX7jGUtdTxqIXYaoF
 X/BnUYUAm1GbOpOzI0ajDgWm4DL7CTcjnx7d5Udlpt0HsGMeWQJn9uThg=
X-Received: by 2002:ac2:5446:0:b0:5aa:126b:4504 with SMTP id
 2adb3069b0e04-5aa323c4508mr3297270e87.23.1779657657621; 
 Sun, 24 May 2026 14:20:57 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cb36e8sm2212142e87.16.2026.05.24.14.20.57
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2026 14:20:57 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-38e7b0903cdso73704771fa.3
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 14:20:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+Rr6PVc3lGWB+Eh4wKRc5vnTQa8jnIZS0ZSLG7IUZovvrdTQ6OT6k91KlLJDS9w0MGcxdTYl/eApE=@lists.freedesktop.org
X-Received: by 2002:a2e:b8d3:0:b0:38e:4810:4f44 with SMTP id
 38308e7fff4ca-395d8bd88a8mr40151971fa.4.1779657657216; Sun, 24 May 2026
 14:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260509190015.79086-1-jernej.skrabec@siol.net>
 <20260509190015.79086-8-jernej.skrabec@siol.net>
 <20260514-valiant-ape-of-discourse-a4f5a9@quoll>
In-Reply-To: <20260514-valiant-ape-of-discourse-a4f5a9@quoll>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 25 May 2026 00:20:42 +0300
X-Gmail-Original-Message-ID: <CAGb2v64UvgqOPuZwayBmSUhQA1VwBBDpFn7ok0d7OVHjhzz=2Q@mail.gmail.com>
X-Gm-Features: AVHnY4LF9PZK6soJXHv0nl5iKDfqAVEgS-xhOR9JBN-5Ngh0yXQO9LbOCoc_jy0
Message-ID: <CAGb2v64UvgqOPuZwayBmSUhQA1VwBBDpFn7ok0d7OVHjhzz=2Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] dt-bindings: display: allwinner: Split H616 DE33
 layer reg space
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, samuel@sholland.org,
 mripard@kernel.org, 
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 mturquette@baylibre.com, sboyd@kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org
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
Reply-To: wens@csie.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

On Thu, May 14, 2026 at 2:04=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Sat, May 09, 2026 at 09:00:14PM +0200, Jernej Skrabec wrote:
> > From: Jernej Skrabec <jernej.skrabec@gmail.com>
> >
> > As it turns out, current H616 DE33 binding was written based on
> > incomplete understanding of DE33 design. Namely, planes are shared
> > resource and not tied to specific mixer, which was the case for previou=
s
> > generations of Display Engine (DE3 and earlier).
> >
> > This means that current DE33 binding doesn't properly reflect HW and
> > using it would mean that second mixer (used for second display output)
> > can't be supported.
> >
> > Remove layer register space, which will be represented with additional
> > node, and replace it with phandle, which will point to that new, shared
> > node. That way, all mixers can share same layers.
> >
> > There is no user of this binding yet, so changes can be made safely,
> > without breaking any backward compatibility.
>
> There is user. git grep gives me:
> drivers/gpu/drm/sun4i/sun8i_mixer.c
>
> which means this is a released ABI. As I understood, the old code was

We held off on merging the DT changes so that we could rework this.
I can't find the actual request though. It was probably over IRC.

> working fine but just did not support all use cases. Why this cannot be
> kept backwards compatible?

AFAIK the "planes" block is shared between two display mixers. As the
commit message explains, this prevents using the second mixer, since
only one of them can claim and map the register space. And on the H700
(which is the same die as the H616 discussed here but with more exposed
interfaces), there could actually be a use case for the second mixer.

Hope that explains things.


ChenYu
