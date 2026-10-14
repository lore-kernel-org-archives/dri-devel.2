Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7E9CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 02:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C6310FA7B;
	Wed, 14 Oct 2026 02:22:37 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21CC910FA7B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 02:22:32 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-3a1981228f8so24655701fa.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 19:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791944550; cv=none;
 d=google.com; s=arc-20260327;
 b=qH5Q7PaEI9xPdEAHu3e8mvuV3TlHDpyWU/8i3CrXsQcxd6nn/Wut7i8wc/PrjsrxFU
 8gwPdFcFc8/PjoPX1fqLq5aCilLFwzo/Au6VKbgE9ZiOhUs+vizw8XKAMTbp3zqwpRG4
 +hp0Szfc877wmUwZe2zmL6UAE6rthBGyqgmwXO6NddOqVt8OBdQSNnH4vXlnmbSAumEu
 i5hMZMXVexiT/iQGmP411C56NjbDbGCFCKsaXGnlgQe0xDtEKA3lxg+ImboXIzDMvsbz
 Uw8hLY9AbE8bwU665w7LVO/8lD6cfyEkrHqL/wgODvT/SIe5re/GOdpclPr4xX1IfhvD
 E7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uR6LzQI4dyAnk+9+CQvzUY4D1It975ps1tZNRpR3a0U=;
 fh=4v4VUVACGDAOTZfogaO2VM82BvZHfWfw4miK4LIihVc=;
 b=W36ks18v1oEOVtR0czfG6zVXJhGfSGhwLEfhQ0VXO4WZJyPuF7VNtOOiw6plVuPdUF
 +HFXG4KlxzN9XOhTHpiOHvOsPEuc6VAxRGsRpKe+zESZgLLhctLU153ZjjkwxGFRQw3R
 sRHfD/aZw+ZT0LL9x4EbAbwpzOtban2xbTEEXnVdZ4u822gEAboVYW8KVhWG9rvMFDMe
 nSsbq08XVKbKoE73xKUsD/Ml1NBMUQbR6JGzvfHSMPu6e7hr7hOLrgJ/dxzNCZSU+NRZ
 KQNboVw+ssN5JVHT2CC6hLO3UMfjYjFY9FHkpfBqHSZjeA59fb3Xo5SUTV/P1q6FW4C0
 L8fg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791944550; x=1792549350; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uR6LzQI4dyAnk+9+CQvzUY4D1It975ps1tZNRpR3a0U=;
 b=G3PpvTzjtaoKCeq5EhhWxatuU1IBp3lTY1LU2Yldv2HyWxcRkRP4/db17mt4b8Ff7J
 hHRIRxGO+j79Z02/LMePMp29jC8Wy5I+5C5UgmxQH6DvA45veFeV80QXk6a20GyZn//q
 X0xi8tTjJikPslEbfL+7REhke3f6BOwvPzHYxySft56hjQFQ+9ey5fgrcz1rLWhX3cml
 jGK/4d4LixJ6G38OYNBEpL4Ybcf754Zw7sgLh9KkSVQgGwxAuBvle8iftaLy0jOFq0j4
 ix/ijGZKQxGRsPgOkRzXnsg15c86kalku0hawAxQaQPFoZLEbixyPfTMR73Y/inhh8W5
 Lf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791944550; x=1792549350;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uR6LzQI4dyAnk+9+CQvzUY4D1It975ps1tZNRpR3a0U=;
 b=1MmLvqfGTiNGeSaRzlzjB2v8WYanJYsDb8mSphuERWVxC8ltOhYtIkEhGPsSHwq5NJ
 xmntOtpbL+F2DbYRhOlgCD64K17xImCRBdpOwCUnbSX0Ib0TgfPBXTKcjVBcORhkfCSf
 Mnb4YjIjjYUCmyWmj6RrquU9w9Tp7GrbWb9yVXwufs6lv2rsv/qR0fMjOUaFLvaSs0kH
 2A+blOBH+yVvoxoQZv1Lxh3/EkAxg4jGO8zeM56yG1NzBMG5IS4M00GDJ9eOS2yEj9Vh
 kW/Mxqnnqz72C6YOL/66OO/p10POBT7ahOlDpztvGMQ/unMfeerdDmjhXRPJAKGbOtlw
 ChSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByyiCTi3If48HoDmLFtdxwTUIcb9TY56ljsBtMYPit5YFvIGtUlpblHhm19MFVlptZZb13BIFJwjK0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLjyVoVXtLZWTwvWrJhRQBTTyvNBQA4rNLbr0dcCg45y6m6cCTG
 E4xLOg60XSAFQuLd1wchp7sGLMMv6yb6oLTwEBCvrM9BoCL0wI031+Zeq65v8xfi82MORdZkbKW
 hK9q0G55BGDWd4WNIURSLU2WdPt91W5M=
X-Gm-Gg: AYBFou1hrHnZv5Iyhf+QRD8LvG2aRr6JdKKo8Dhm63P8cETHTn3T1Y2UzHi3vGZuD9h
 9wzt1nA8MPjhxUYpeJlOoM+JPCCJKpFPUTFZDhVf17iTSkfuJEo2iqyP1Yp3UJW//PSwxZ1Po/0
 7v+NOTNq/6wZvJb0DR6beP4OP+sYAFV333z8Jw7RBproU5hwqHJHbuYDs7KeXWS84++GdOMfoGk
 gkXG5WR0UrW8m6eYMZBXij+PhkVVx4AFbdSLXoOfGZvuAlPqjggo6bu4QBdFQLm1dXqNOutU3CV
 7AtX7Y+fQJHK1V8yLPQ9wM3GtJI3hkj9V6Cl9Iie5mpGrRFnOdteTLSmWaao3l9QtTkNfzcP2j5
 yNc5gnLZwf33ZtXERVLB4xOMLpKqMBpprXWD5RT/qAnM=
X-Received: by 2002:a05:6512:224c:b0:5bc:f02e:9b2e with SMTP id
 2adb3069b0e04-5bcf02e9c70mr3265873e87.9.1791944549826; Tue, 13 Oct 2026
 19:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20261013145210.103565-1-sashal@kernel.org>
 <as5R_xrDv4eVPdtz@orome>
In-Reply-To: <as5R_xrDv4eVPdtz@orome>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 13 Oct 2026 21:22:18 -0500
X-Gm-Features: AclHuK887CDwAvm9A-A5lvdpxpUm0jxZaYwqU9DtjoFJ0z65i4nraDiY5z22Q4Y
Message-ID: <CALHNRZ9zhVaz9UeYJTFRph+0JMM8x+5it_Xv7Qhy5f2kh12MDQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: gpu: nvidia,gk20a: Allow a fuse clock
 after the reference clock
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Diogo Ivo <diogo.ivo@bootlin.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Tue, Oct 13, 2026 at 10:46=E2=80=AFAM Thierry Reding
<thierry.reding@kernel.org> wrote:
>
> On Tue, Oct 13, 2026 at 10:52:08AM -0400, Sasha Levin wrote:
> > GM20B needs both its reference clock and the fuse clock while it is
> > powered, so allow "fuse" as a fourth clock after "ref".
> >
> > Assisted-by: LLM
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Aaron, Diogo,
>
> I'm fairly sure I remember at least one of you mentioning that GM20B
> wasn't always working reliably. Would you mind giving this series a spin
> on your devices to see if it fixes any issues you were seeing, too?

I've got a t210 nano a02 that essentially hasn't been able to load
nouveau since I've started my Android Common Kernel effort over two
years ago. I think it came up like twice when I accidentally left it
boot looping for days and forgot about it, but never when I wanted it
to.

With this series, nouveau loaded properly 3/3 boots. I'll keep this in
my 6.18 kernel fork and see if any of my t210 devices hit the probe
hang and will report back if I find a case this doesn't solve. I will
also point other people I know with units affected by the issue to
this series.

Aaron
