Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADAFCD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 12:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331F011A7EA;
	Fri,  5 Jun 2026 12:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DWYf7hoB";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A19D311A7E6
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 12:17:23 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2bf18c30bb2so12605335ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 05:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780661843; cv=none;
 d=google.com; s=arc-20240605;
 b=A7YOky/V7yTAK3mlo0Lxq9FQO+KeqxWOC+qpmjIm/PtsmAxSOmlKiIkFJEJ/zL3qYO
 L2jkfiAxAU+o1yeKakraB6E7IXwPfcYK8uTAFO4+flKIvv86zvAZ45NLJlrVZ816I8HU
 4fdO1iuaLLBSj8RnuPnCom8r3Jcmn0NwHetMopO+Rq+t9zPJuSfuTbvRqd7nb1FYfDZj
 5XLE5GN5Z3PlEBRyty1fp/bEZquh0v5oOXpMFMTrmIirT0052PsgybF7Fw0nrYGX2oC5
 r5iHiOLywoU5UURkeC+KtufJLnyJgH5dAypAMHiofd2bP37KT0WGCtt0wWqviLZOtBND
 /TYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O1D7q+cAZBnaFGgiAedXXkbxBpbfjB/B2YThNrAJHNA=;
 fh=meU1uc9o9ELOkwcU7Bh6hsWePbtVVCdvNz3tRUkP1wE=;
 b=FZZn6a+5ryx+Kqy9tXFUFB1kuEgyygRTwYMf6Q4D8YmifXfdlSNF6rKSJIj4DKDjnB
 ZA5rFQ3SLK4QnjK2fFQ1shFWvCOStMsnBuJTU2unC8uXt8YAToEotG+V+4reGY0E2A6P
 ZjYACNR+rDnIkugKaDZ4+/naXknjJ/L0B1ibqFlGMgA9RJU5ASMW9ythAXf0p6eQ8JGy
 zvB4cQHK+yHRaaSXCTHuvJg+1HbjvpRygVwlbAfYkWcjtnLfjI+FlGwwLVKYmJ4I0qD3
 GxmsCOhU+vuuVdYTWwacT876MXpa274OG4xEOY/t7EtSJgspzXyxIDmxIbe39JlxFWOO
 6GTw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780661843; x=1781266643; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1D7q+cAZBnaFGgiAedXXkbxBpbfjB/B2YThNrAJHNA=;
 b=DWYf7hoB+RQLrOs92EXG090stNfmFY6yul/WF/LR12oTKb9E/JmYH6G2HdxIErGjdT
 GKDYa5if0eSngw7m/oWBBQYFk2kA5nJjSbBqGkmSfcgghCGOrXXByKPNedupLlMLTYyV
 fi0vJlLa8B3o5s7lbWPSqVS9B7XKaUp4B3RM/PIahaT6FF+roh4zAFdLFMIdHeiVlToU
 oBcTnlRrldY0EC7QG013o3WxlnmckQvCZq2vLFRbx+xw9kBK1pP2CFJ6BdULTmBoPVxv
 V4wbREYMyd5ORuWtdFzZ1v6qiwOE23Wq4b1UfTl7s+Yo5oI0P0z1lAzajfEPdQpseD3k
 LPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780661843; x=1781266643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O1D7q+cAZBnaFGgiAedXXkbxBpbfjB/B2YThNrAJHNA=;
 b=tYtGz1BaVeaV9KwzJHHbMKImc9jgnQmBWHM3OlgSCehWnq9UFZGzqRzjVLPilx1nsJ
 A3jYWl/N5t5lfX7M7Urjzfh0Ha7qkyyh9hirrgoL7vJxSfhSDQIdNKRgr95+a1/EkI5a
 aQyX2iCcgKBYFasXSmo6jLek/4dkWn62oweeaaSSuddeiIJvbgiRM7sGFtdYwO0bTTOE
 T0D47jB8U1NOFkSnMVSd+PSDwHpTjZEIcm75yOPVwUI3nc1Z6GXu5gFTA/JXR7P6ulGa
 +E+FdwzfYP+pvZueTZEK0SSz+br8RZxbd1KWcw3c4umw0oj98Prr8BqSPUougdFJCHCQ
 W0QQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kzbTT7brYMqIQ+ytzl4j2qHoCYV1lyBdS6b6dBn4WUwcvVwKlQCX9fYQrdFE0uz8gj+M3yASBGJo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXV42+X3M1oymTwbgiF581W3j/hA5oGXwqlaRdtzpij1snTq5j
 Z2m/9utlzrp1GUQbrtKrHd/Anb01w9JiUs6M0LnwEsyVrYDa9O6MTv0LW11wTt+ITJe9Aw9g0Jp
 1IUQdlra/QwZWQrJJtHoasZwl7nB7yqA=
X-Gm-Gg: Acq92OHzCTcpdHMAHqP6+fHc4cgonrO4xNjz1+l+YLVsKHTKbZ/a1Rg+FiWJ/MXkEBz
 cPHd0fwoFeODltPLHRBO9T+4vwadyAvanbxCSoMn48Jr3QqIGdQdwgT+/hjI4fBK3LoTYr+xqB2
 fpkGZHNPqJZYeqMO9/+/HA6eoS7DTIgYo5Yi9fkdLPeXq4eVDEaTLiDviI4UYm/HFsPLZHCNVF4
 lu4g5Pl2gV2h9x5x10T9g9vykSLFWAQRvgkj/bFOSOwiGkad31W3Zi0sf8bivdVwP9WSMgYXHWZ
 4GvcL5KMi+3jGZeE/pcaH5ek1LFcUVNDsTlmOBmx6tSUaGWgPALJT5CAg5JGAGJAX29ov1T0A9E
 =
X-Received: by 2002:a17:902:e752:b0:2c1:737:bed9 with SMTP id
 d9443c01a7336-2c1e893d479mr35069085ad.30.1780661842733; Fri, 05 Jun 2026
 05:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260321-th1520-v1-0-ec877197770d@gmail.com>
 <4180689d3426882dcac2eb74209d398477f88b90.camel@iscas.ac.cn>
In-Reply-To: <4180689d3426882dcac2eb74209d398477f88b90.camel@iscas.ac.cn>
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 5 Jun 2026 20:17:11 +0800
X-Gm-Features: AVHnY4ILOfLjHFNJyQ_dDaX-IoRogY7VjEEX1-rTSKRis09oXxcE00pq7WQJTBw
Message-ID: <CAN4SLj09F+bSQFk4x3POGrh6hh2s8ssk1CmTDvrDzBCswZJBuQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/bridge: th1520-dw-hdmi: Two fixes
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
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

On Sat, Mar 21, 2026 at 1:05=E2=80=AFPM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> =E5=9C=A8 2026-03-21=E5=85=AD=E7=9A=84 03:12 +0800=EF=BC=8CFelix Gu=E5=86=
=99=E9=81=93=EF=BC=9A
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> > ---
> > Felix Gu (2):
> >       drm/bridge: th1520-dw-hdmi: Fix error check on dw_hdmi_probe()
> > return value
> >       drm/bridge: th1520-dw-hdmi: Fix remove() callback
>
> Both fixes look trivial and let me start to doubt how could I make such
> mistakes.
>
> Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>
Hi,
Gentle ping on this.

Best regards,
Felix
