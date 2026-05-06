Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC76CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 19:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B462710E20D;
	Wed,  6 May 2026 19:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LO2utyff";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2506610E20D
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 19:58:57 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so77651f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 12:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778097535; cv=none;
 d=google.com; s=arc-20240605;
 b=ElY0ZcApSRS8IYuFMLiGpy5GsYIlxIKnG78IgkKLcIODFVyD7eNt/bSf3lDvt1YzWY
 ymsD/pFsttS980V4IdOi+v2uBRZx067TtfRw3/DGKnrN4Hvi4jftnHv33R9+5ie7uLiU
 ZH/P1s5VMbeaS/o2jpIyOtrkze1wFvcR8WXNa58LOKau9DyiQZxzQfNt+6fViUIEnbQM
 WA+GBBDfH7V5aV0882zDc8rzWLJb11J4cIhf+uRsBz4jgXpmiuwXItjHlWZ1STXnIzOO
 gQrbblePbVijgqMgMVMX7AlDRBtOD9D5VhaPi+5nf+hAhjkpKMEISm5I5gGJvroKaX2T
 +ujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cKQwfi3VdbXqK1EPlrp+rIWkQqAXhahRUcj4Mc9yLZo=;
 fh=dn/E4Le30bcBumTSH6tO8zOSPRd39Tj1/5y+nGDpAC4=;
 b=CVz8gxopnM6cPr7P6ZTO1f+zCk63K2/XmJg9DH4fRgeVsaZprfUhw8VD+TaPYn6tWx
 ZSKDFEVs37jPpVCPBbi4gpisZagWNb2TeN6+w5Hua/6cWy6qreNkyGQH3b3fRICqEYY/
 D84dqkUxQIg+hAdRuVx1XrWM8KL5iQOSj2WOnW9xaj67nqg4nXJsDlQryk8572RnCMit
 6BPkUWJSSa1Rxh5HUG8kgla7VHcVpWnvfs90aeMpkJp9zsl0yqUFd7MAnzV08uq1pc/d
 50PzVxATz4hzsOStlV2hlwjrfVYaEBtqN7+8Wie1FwZNXDnu4P+mgxGIjvXFd4tGzbpz
 e88g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778097535; x=1778702335; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKQwfi3VdbXqK1EPlrp+rIWkQqAXhahRUcj4Mc9yLZo=;
 b=LO2utyffjg2l7LwAIch5BIbZW+JSko90fzxpGx6cbbkPP5uUG0U+quUm0LV895gjWT
 rJdAhuKEbcgGJUEsLGJNUGVJTiQUpQOuqKMBf/yLZlQIPNamqAOl5qM4ETrZSP3++/oE
 +qWgHTIq3UZq4kzwHVeXsfzwgFt6Spvm/cAa2zoFFY4DK8io+HYFS17Sdd8afuylMwkR
 /tsmrNCV53aXFi+0HZHER1GqdentsfeU69Z/X8VUPF2fyjMUMdgKhWUvPcqVqw7T68M6
 kK4Dzk2BSFHPY1qTNN/x4FGs/i6aR4qwGmx/anLWoBgOpKnmWLVER54a6b5QZ955w8re
 t0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778097535; x=1778702335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cKQwfi3VdbXqK1EPlrp+rIWkQqAXhahRUcj4Mc9yLZo=;
 b=KkuazC82db/f+ByZc2/LoeYmX1XwIXl4V/ZLSj1nJ1NNpiSD/t9Qm9SlIgy00sU92t
 0ZUAPzPHdAc9n1MPZhHIX1p1M4w+sG7nQT/J00Q7wQtWtlycknBgxzhVHQRQw4FpscUW
 OrLVY22EYeMu9Fo27I2Pwfqa1MZ8OlYvYq2pIlK1eP8v3pXT7cv9veNMyydiXl9ZLWjX
 DHYaUU/Fupq2SZX+jNQrk0FB63RbINHl7W9H+WZeudP5WdDroRh6LUSAsMrUmtMaPwH+
 SmolYeoFvx3ZRVMvYJh/KU13okKVuGsU0r9mRhkM87pq42N0MdSuQF8eDE1mf9+3qExf
 h3tQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MKRXmg/dzlqOaszz51ZQ7GghnvD/hb4XvPEPLTkAGj8ndTNYTf635Zxxak492HSCq1QDntSwds8A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVnj5R35R3NvG/mHjjKs6VzRsyZIAzq/h2MjHAscX+wV+KjHkr
 3DMGF1QKYRWwh+yQGR3MwiSXW20duO/KMBst3RFOX3TZlaT1xhVIsvAdgHpg2LljquMy1qZkfTj
 CbRWNx86QDwPi9fPK8+reIwGO2ktGVtI=
X-Gm-Gg: AeBDietXz9CPyo5ZJF4DXb127PacgleK2dCXZOdqx/20yDEkUOuBhIQMF+HdE5XMJdB
 7DAA4E+oYV+9rEJ8Iuy7q/gVt89giGPPy+jr3S2A6OfzcASquJKiBbF74zW/sZMKufMMNSztbpV
 ukrPqIiLapc9RmfwEzu8eNZzi6lmzZuhxVgkVEF99d++4sRzYoLHOUDcd22WMqQctgNxnwSY//j
 +mLEmJcfBqkVVt4QVMuQoxJW56a2RB7QSaUNbfG/ks7ZomR0NI7aeRu/Yq1t2lZVD9Ex8h5Es90
 ahtdegpWVClU04SQWqMo+/CC8YZO5RaWaGEOGcXPyfiuhb6uAIPNyRun6LqtMD18p36HASlKw4s
 R3KcNzZN5bJZN+E2lMVYq9oyByZvPU27I4Mzu
X-Received: by 2002:a05:6000:2309:b0:43d:773d:78ff with SMTP id
 ffacd0b85a97d-4515ce1c7a9mr8612810f8f.27.1778097535163; Wed, 06 May 2026
 12:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260429170012.366537-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260506195002.GA1778786@killaraus.ideasonboard.com>
In-Reply-To: <20260506195002.GA1778786@killaraus.ideasonboard.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 6 May 2026 20:58:29 +0100
X-Gm-Features: AVHnY4JcTk1czQ8A4YapAWR6cDFrvvjoC98jxL7sK27uKvjqiU99iFcUrsGiPk0
Message-ID: <CA+V-a8u8=mfR0zDJRNMEjnjrzFVAkOrqtro05Zgd1JFqGRByKw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: renesas,rzg2l-du: Add RZ/T2H
 and RZ/N2H support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Laurent,

Thank you for the review.

On Wed, May 6, 2026 at 8:50=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Prabhakar,
>
> Thank you for the patch.
>
> On Wed, Apr 29, 2026 at 06:00:09PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document the Display Unit (DU) support for the RZ/T2H and RZ/N2H SoCs.
> >
> > The DU block on RZ/T2H is functionally equivalent to the RZ/G2UL DU and
> > supports the DPI interface, but includes SoC-specific register differen=
ces.
> > Add a dedicated compatible string to represent this variant.
> >
> > As the DU implementation on RZ/N2H matches RZ/T2H, describe it using an
> > RZ/N2H specific compatible string with the RZ/T2H compatible as fallbac=
k.
> >
> > Unlike other DU variants which use a multi-port model, the RZ/T2H and
> > RZ/N2H DU has a single output and is modelled using a single port node
> > with one endpoint. Add a port property to support this and update the
> > allOf constraints accordingly.
>
> Wouldn't it be simpler to always have a "ports" node, even for variants
> with a single port ?
>
I agree that, from a binding perspective, always having a "ports" node
keeps things simpler and consistent. Biju suggested this change based
on earlier feedback for the RZ/G3E series.

Cheers,
Prabhakar
