Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E664F94CDB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 07:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F9B10E171;
	Wed, 22 Apr 2026 07:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O1v1SNo4";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F14E810E171
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:36:30 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-38ce8a5bc20so55376301fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:36:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776843389; cv=none;
 d=google.com; s=arc-20240605;
 b=kx0bqIkg7Pm8A1+bisIQToR9SCUqZj/ma+om3w72OMAaBZCoHeKWZw1XNi17cJCvzp
 p4vrRhOi7oqcd2zWHTlXVuAgLCuIqtn5EWDisZT6AQuR1CSGWXJuXas/5G5B6hkCKjcb
 18ghpCPcaNJwlklahoDX3vi/CZ9681GKuBQ+UnprF3yRiM9yiq1v5HAxK5xEPCyHMVYx
 GDO3EPNqo+HzsDlvYW/EDs2d9nzKuADwaGVA/DO764WV7IJonStN5Uba3AUn8SrapHSj
 hcR5BYdoGbHQw6EriTdODH+DR6k9b18261AQDg8LcXXKqOJZ6cSoZwcQBwvqVlsj3/Mi
 jAww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JRhsk8bRbL2KGVeQozHjmCu3DTba9VSOU96UxmUB0aY=;
 fh=LvnxZE+61OfGnN/nkY3Te6Hb2i4RkNU+8CV2208seNI=;
 b=Qf33H6EDrs8MqeGOzqmzWMaRMuw3+kvx3bf8WHR88X51uwDgjKddvuwj8+B7pDBwvI
 NFRNFS9QOtMrKkoMVpsUJhJc9u+ZUvENEiUjMgbxxjdGXA5BDNzafS4BB5/zz47w/Zwz
 MaOLKgXTSUd9uGKRlTuAom5GtFtvCzTvPsyr0kfjjPMmEGjMdw2hPUQ6EEDGU7JTCgOR
 YWX+8VFA6dT0HQMAxe0Ifk7MgxIPnPKmSyEy3QwmW+E8ZJIwQ8f88T9ozZUfvJdkxbCQ
 PTYxMUQZvw6m3oBNiMRbmbEFCYizR0wzZvy+dMDLq9iFKO3s8hy8apFyxJ/4Y2RlRoay
 Zmfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776843389; x=1777448189; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRhsk8bRbL2KGVeQozHjmCu3DTba9VSOU96UxmUB0aY=;
 b=O1v1SNo4Jjs4TGnbv4UuSa3sx17ThAKztbjAxsjeJCPE9iy7Iv4dfq+Ou/oH8A7b1a
 bbZ0obhI4yrTKvrJuRTzN/lRCvNsB29nLL01a2AGxvCJXY4RX2r0ZDPXYgaUvkaxbs6O
 5/KLwu+vHvidTuTPP3LcwJhz19/sXlgSXixkv2xFN/1V+NHhQON8+IJLx3qLyCPVFBau
 i2g4qFviZ+O/96xAm2BAXj4ZCYrMR7NQDXRdOieTvqvddyV1zWGDryKyXoqonNMbom9Q
 S8jWNMso9XYZEw75H9lOBTcT4vKDhf+PysU5JOtr5DnHg5cc3pMH6bms3tO7utbVqEWT
 UBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776843389; x=1777448189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JRhsk8bRbL2KGVeQozHjmCu3DTba9VSOU96UxmUB0aY=;
 b=MiC0VASl+fwzjOKHOMESnHcd0xJheNUdVAbM0IyfOBvXZIWn41gDj6uk2eJtJLz1Eo
 caQ8WZ0nzntMRZAplWXzNSz6WMmCWEdXW18kfhSAZ2Ahpd8o9Yr+T+izzQz/pINsdAsg
 bxoa4CRRJmimOJZoNat2rovli9eHXRiuUjI+kZUFXVLPP9U+P0ra/KaR/ws7CymJRnAi
 W/Jx8U4PelHT1vmdUMHL3MRMb5D2HMirAnk7G+cifzObY4R2sRc/qj+a5xH6+Mg9+eva
 jlBaoC5I8KsJha8U8rmviqa9p/2UwQuSBXl8uTB7spJgXiiwNpybCj5hE+ybkaEgk7pt
 PNOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ++LTGe/23MFEELUAxF/H51SsA5yWUPwDgIiwQj1m5bnDFQQ2yO/dchjKLT1ArpzxyiF6quddHqD8c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPokRep6Mh7W4RmkWKZFbMHzldZlOK2qbhEv65//zJiHBOls+x
 qK/4nudM+ggY7LmGI3bUgl6D/GQSfDaqda51vE0ze0eX+HDwmKYIaCd8Zx/uVhQiwC0+X7LKb0R
 IAp+24UsBgjkXRQfP93sLka7HlcTRO8w=
X-Gm-Gg: AeBDiesvBZRMSOH97Y6tyXcYO522AIvYt18iEiSXCGVsAMCeQXHiesF1YCmxqOfIPdc
 ni4lXpc9huCPjuQEkdN6+kTY+j/zNBxwVjpG8dlvxwMqyrNZfoYEQlldHvHvldpYdOhNNdUsoEZ
 aG3Tmr1blAa7QZVXDx2DK+eUFMgT3m12HXhO7qubzJrLqEOkwG9p4Bf5PWrH+kfnrMnlnH18TPI
 Ewq0BCLS1wjTCMzNPCmgXa69eEZf/x+y3L1FS3v0a7LRUSo2afog6e5zsBlnefO/LGkBPOpFICb
 24LJ9Vmoh30/uLEv3ME5bex9yU1043Z0Jzb9zy/zBnXKg66E0fot9locuEjfjZmrM8pnKLT04vi
 ZXIs=
X-Received: by 2002:a2e:bc14:0:b0:38e:23c9:2f77 with SMTP id
 38308e7fff4ca-38ec7418244mr76801921fa.0.1776843388831; Wed, 22 Apr 2026
 00:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-ch13726a-v5-0-f7f6f4f30e05@gmail.com>
 <20260421-ch13726a-v5-1-f7f6f4f30e05@gmail.com>
 <20260422-resilient-puma-of-excitement-02fee3@quoll>
In-Reply-To: <20260422-resilient-puma-of-excitement-02fee3@quoll>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 22 Apr 2026 02:36:17 -0500
X-Gm-Features: AQROBzBRZGRInIxeMUjKR2PpeDYi3ALSLVHHQxsrJaDloP4zzhaCTJCBGIAsqt4
Message-ID: <CALHNRZ__HyuWpcTzqq8YG_n=RPZ10kNhHU262=NHEqr_S-pYKg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: display: panel: Add ChipWealth
 CH13726A AMOLED driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>
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

On Wed, Apr 22, 2026 at 2:05=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Apr 21, 2026 at 12:38:37PM -0500, Aaron Kling wrote:
> > The Chip Wealth Technology CH13726A AMOLED driver is a single chip
> > solution for MIPI-DSI. This is used for the AYN Thor bottom panel.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  .../display/panel/chipwealth,ch13726a.yaml         | 67 ++++++++++++++=
++++++++
> >  1 file changed, 67 insertions(+)
> >
>
> I don't get it, you use b4 but still drop the tags (b4 gets them
> automatically). Nothing explains reasons for dropping the tag, so I skip
> the patch.

It's not automatic, you have to run b4 trailers, which I forgot to do.
Will send another revision after running that.

Aaron
