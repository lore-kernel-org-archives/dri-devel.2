Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFFCC624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED4910E551;
	Fri,  4 Sep 2026 12:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HfITeoGB";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F5D810E551
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:07:42 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5b4ae0b3308so621856e87.3
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788523660; cv=none;
 d=google.com; s=arc-20260327;
 b=ePaTQlBDIp5X6ttzq9QEFJML3+QQsojUPnMXhcSUS94CKNl/7+KxGdcuQlxXB3Uan3
 eys7Gu6zV/QgOLUEKQtZS7z5SGzGy7chCLc4i+qK86NLYc06Ve0wQ4gyex62NMcsAQr7
 tyYyR1C4Pkv4ZxCbZ7MR7m4r4Ppkl+Qhq6t1g5W0AT2pZVBJd6pM23pPQrC69vi2Zvet
 yDGPn2uDkcKGLJEBFyNpbI/ooPlX2n/oYGGzUICcWhpCCTsRI81JyVcoALcEIwUg/0Ds
 9smSWl5Mkc5GkPiLUHatZKD/wOOZyx4YqgqS3GhHkQ68wqwkFX6HLsIHpRrI8PfKwAe1
 0O2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bQ+ngubuSMUna8wGHEH6mnd/d/43/ckY+sPNpIA3LCs=;
 fh=mKr05x0NXR9Ll693umCutw8ktlNvIk/f9RRdj2EP4BE=;
 b=CE8OQ7wh7an7cTAthc48W4BlldMc/5c4rKm1gI9+7+JWkPMRU69I0KJHUlAYwlXQFx
 ju5mffrjhFYAIEHfaOhun4V/V5sQ0jF3PdA5PtlTLIoUKNpNmz9f60wQpuIZJg29DA/a
 Xzpa5fFDk5MF+PxerTS+eXrSPIYdvYUrx6QEz8WgbVTgO5aE+uXnkCVSC3NOTR0kp8TR
 TSX0NamOllBao/nKX0I3oqTbcx21MyGC7DeHdBs7rKC+P4OvnNO/Vp14w3w/cF0mSsGJ
 bifkhsTWJ8JcLErDc3D/O7g/UlGYB0bfPtnSeSQ8FLiTIRdVW+2IWm6bbIC+Qr0QzsG0
 7nlw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523660; x=1789128460; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bQ+ngubuSMUna8wGHEH6mnd/d/43/ckY+sPNpIA3LCs=;
 b=HfITeoGBFEfzuFXWyveamAf7lY90QF3ra/AE/NOxH9B6g0fgzdWJAG5HZ/BtuRYxiQ
 jwfrte7tNf5OUL1Z6BRDLuTEXl9kTcGsu2p5zVABf7T5dqd5vlUhpg3wjFqnj8bTlkBn
 5PhS/3qCnSiD++EUgjeH6k+VA5SdjZ9HhDugKZ4jNr3CTJXWdB8kPoxgzZOk6kRtwFFJ
 M2RekwRVCuRBkpHITHXhANkTSe50KnwKHb0nm1RpEZ7LwNXJqigUi06aNLFKQN9T+eRu
 F/wdZVpRg8U6uDcpMoKBOba0diY1LXWxEQt3C+yohokDwDIicC/lXiBIc1AUotexg4vW
 YzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523660; x=1789128460;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bQ+ngubuSMUna8wGHEH6mnd/d/43/ckY+sPNpIA3LCs=;
 b=KpLjb1B5/e5hDSU+h+qXVQbWf8Bu9rAX9cv6LRRvcDalHtBC3XhrzspqBD4Q9Fm40i
 g4DM8oo24+jekK3SO0tVH1GJxUG/751Osa17gX2tS0OlWK7VlWP4ATJ0Zm4fo741RNJO
 KtWrHL/zaDy7oyvV4jIlfeFxvT7s1dJBAtXZPWni0Wl7cWfe9X/DgjfBcprUiLsqlnGH
 BYP13GqnVb0uskx1YKLgMS5Gsmh6qJP1bqHKU6ydUTW6JLsiqZn8Al2NBSdxhKwsDkLM
 1gTuo7bZgSm/rKjHPrSgsrnHXUDITRnHmfZXO4OcvDrmeURaEthSuU8wJuIEPuxlM9WI
 9NXw==
X-Gm-Message-State: AFuF++n+r8aCybs4zNEkOM83qMWcrdMGT+0Q0hPM32Fg7AEpZZ3vxA02
 IccYj6JditTVqr41w20O5oS0wJL3NWsmZlepXGAb06SLSK9/BpNgGAsP60jVLpRaeMNucyNLUWp
 2z2KGrZkCEwFG6VXPxRtJGmHa9PiI8hE=
X-Gm-Gg: AYBFou2134H1YSoZx5DbW9lLFiuJjeh7f/Q8Neyr1sAnrzfNSTTpKsAac0P/gs+4jGX
 D6OTcE0CO8haPMEeCrWAfJZgbi5UvxjkK4HknTbdQ68aTQZJqFjY7Qwxe+0amMfYkSdW7LO/aiO
 Y92HTTAILefd1/l2SqYld1DptV1GgkxUBWh5D74WVVTQoWzy0KmkJg/+RTMdmBAwLrUt4l/cg83
 tstALNCyzM1gtnxEEL7BVw6aPq87fe/e1sxbuFSEo2YENzSZJz/tvIj4BFhEJff8Th7vbAN4YUq
 2zmab2vdgnb23A4PFXeTvooWwVvOMFVn6G/yNxXuCRPGYD9k0zz132+dE12ILLeOLIgAagZaLZZ
 fDTHbpMktb69K1ID4307K1pbrsKBx6c23ccoREQm+H3jAmTjopJ3N8T18yuHdljB1
X-Received: by 2002:a05:6512:3984:b0:5b6:1a7c:aa0a with SMTP id
 2adb3069b0e04-5b61a7cac43mr532668e87.34.1788523660278; Fri, 04 Sep 2026
 05:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260824195418.17707-1-kieweg.leander@gmail.com>
 <20260824195418.17707-3-kieweg.leander@gmail.com>
 <79f25a88-e5a1-45c4-8b80-67830d7e63eb@suse.de>
In-Reply-To: <79f25a88-e5a1-45c4-8b80-67830d7e63eb@suse.de>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Fri, 4 Sep 2026 14:07:28 +0200
X-Gm-Features: AcwNN1WZMHDh86DNK0rt2fYj74vso0lva0nGIJKgbC6O2XV9AFAo6Xx2PQUbBo8
Message-ID: <CAMwcS0hNeHFMcUBMS2PozTqgOr2A1E3BaUW8G=D8g9t9CpCM-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/glanda: Add initial DRM driver for GlandaGPU
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 u.kleine-koenig@baylibre.com
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

Am Mi., 2. Sept. 2026 um 12:03 Uhr schrieb Thomas Zimmermann
<tzimmermann@suse.de>:

Hi Thomas,

Thank you for the very detailed review. I'll address every point in v4.

Best regards,
Leander
