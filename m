Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D90CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 16:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D65F10F1F6;
	Thu,  7 May 2026 16:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hhsGdeN3";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3768B10F20F
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 16:23:28 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso789953f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778171007; cv=none;
 d=google.com; s=arc-20240605;
 b=YcPOBYEgRGZMEN/ubz6wN3DW+UAiZdibvjIONofBZX+3F2IfSL+zTICt2dWSXN0OQr
 9qCdWTCkZlByYDFi+eAkVYVkEd+IRRVeqEj9+cZYzgNmlI1eQSdYqQkHOlThVGU1GxZ9
 74cX4wAy8V1TDIKgaXe7tL6AiGlUVg9Q3kRfzzM/7p2sF1zS9z91SE0ieyx99v5iZaju
 Wr0qjHoxeteA+qvL31K5FF0Oiz4il1ScTzVk/dmGDs7fxB4sLAryF7ttcAwifg0WZ9gJ
 MuKrmkCGLrCCURrZ2vvLy/wEuIt0OpPlOXPPIj/U36sjvpr0cg/+gT6cbisCAd6wYuUB
 S8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=78n13q0JxWmtufuvEqwAQZAMZxadvALvItN4XP7CsJ4=;
 fh=tCp1cVSM462KHB4SkKzSl9OUcjS6g/tBmByJDEEpoCI=;
 b=NgsKbTGiZWmr3rxdTTdnCtBBRE5jPb4jV3KSFV0QwhelrLKeQyU7uoKLx6wFaUfIV9
 +igFhntCsBVHL3dFkrpZoZ6NV+LIr5UPOVavhjpbpTMa0vsfLPMUtCgeEwnuITE2t+KS
 iOf4JwnLGKnVUxli0yOcLNRiKfRvyOcp4ejgE9OABQPSo72Wqp3vR66aMn8syQkaBfAJ
 0oveH+3xqk30D9BrvF/mRYI9t3iUYlIRcHwttPowjizs/xCe+zJ8rX5ZbejWGVmzQWXa
 fmoZweM6Hc3gqowrYvwl0TniRjaeku9uHn28RNjjmJfYaAh0NDr4OHkKdXpkYRR9oeU1
 e2aw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778171007; x=1778775807; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78n13q0JxWmtufuvEqwAQZAMZxadvALvItN4XP7CsJ4=;
 b=hhsGdeN3QTOVGZ7Mrfx5WADOBtoBp+Ey1xtgKaXRsjPqz7EZZlcG7tFMtHEvC7F4RI
 wXXG1NDItymNbieJ9MPt/JL0tKJVL520WvR9EZIH5gTatDba93xbR4v3BXlRDDrRiHyM
 LYrIJ5d5uPJFrYIa+A5qL4tQBminxAmPDDTmZWdEClzjaYsRXWHSnbtPd88r1RWPVLHG
 N6qvlV29kE6GE53+6FnRCZrso5YRjRgwz1Z6z96Iuynn195kKZEqLMqz5eeNuxbBFuuk
 6HvA58DMzlpxQlHV6x/saPGP3dfz/vaSuEuKj4n/1p+igpSoG6ER7rHlcK22SjNWtvsb
 Pkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778171007; x=1778775807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=78n13q0JxWmtufuvEqwAQZAMZxadvALvItN4XP7CsJ4=;
 b=Rh91Qd30/YSfuoUfPDjsLlBn0mJLQOgq/z6VWr5YdETX6SFcw4Qaa+Vm043vQFqPVo
 0fHOVR4I0FsfLgE3eOAQyXi9DII2ZXWrXnh3NfIY5SEZA37PtHRfuzpSeQQV39FMcIdY
 N1c+sPhlFq7ORBbwqY9EmbiZL9GBzcINiztp1pcCwH3KF4LI4VSOu4dmNVY88X7AWkmA
 +N8Re71pOsMMnnVp4QWqJBvLk5wuYjgdD2Ylurip4bDiNuf5Tsr2Me2Gqffkk8xKir7v
 BE7kYgvnaQHsdZG36JuF+NZEIocHd8pu0DTy+UeldK+PBjlh4XJQg99LMipu5q82LSNh
 5jCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mfgGZD8yTGDmhgaPK7NcSIMzwbBanQl43t29oWpsLqz2zCizLMd9yOl4rB5zAvvB5TPxHake57Ao=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzzcwj7YWro3NCzCTaI3JhbF1trc7dqbJmiEypkvbrTMJom6q5w
 w91XECm82qPasZEDU+Xwt0bVPQa/Z9XhWnDY/KTnvrI0hFjW+m9/aUvQiOz2gbJ8w4cF5q1u93n
 ydUMx59WmecI51qPbeFa1yeePEmhTxPY=
X-Gm-Gg: AeBDies5BfPTkI43l9rah5YRzK0wv0VQXlIeSJz5TyEpdyXrXiUnbVii7t9RRZSGC7P
 hVA1ZS915z6UXj/qFNwpCP0jkDCv3dxLYcL/RQILENDj+bnzzbW4V+Quh7FOQkcgYuUVAbxf3Es
 Fab4xih7YNGrbCGtswV+YGAHD0vi+HKLM91qI4t57CrwFwuKvA6cyijLArzrMuufX2g3ky6ALpt
 gI5K6yBv8+/SNC/gTKIp7+rMWgOQvcmH/NdTYDKL8LhxGl4tNW+Jbu8iS/c3dDK+8IiwD5kqZBn
 xx9Aq5s7auF5t3r4ij1Xzpws7CYzNMRCu9n4QZA6IhxO1XOB6D0K1gxcAr9Sfm6DyUZQWQ==
X-Received: by 2002:adf:e786:0:b0:451:bbe4:b48e with SMTP id
 ffacd0b85a97d-451bbe4b4cdmr9706562f8f.5.1778171006277; Thu, 07 May 2026
 09:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260429170012.366537-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260506195002.GA1778786@killaraus.ideasonboard.com>
 <CA+V-a8u8=mfR0zDJRNMEjnjrzFVAkOrqtro05Zgd1JFqGRByKw@mail.gmail.com>
 <TY3PR01MB1134676FA7479724BDCE40649863C2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260507103830.GM1778786@killaraus.ideasonboard.com>
 <TY3PR01MB113460CD4F3609EEA898FE648863C2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113460CD4F3609EEA898FE648863C2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 7 May 2026 17:22:59 +0100
X-Gm-Features: AVHnY4LRMvX5NWqGQvTosoP_Ri2LYKGR7IldmZ4eLshJruHuK1dfbRXarsoS31o
Message-ID: <CA+V-a8t+HHYNxet4Od9F2Hk980kQ5yfru4-hF1f-6i_yKZGN0w@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: renesas,rzg2l-du: Add RZ/T2H
 and RZ/N2H support
To: Biju Das <biju.das.jz@bp.renesas.com>, 
 "laurent.pinchart" <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 "magnus.damm" <magnus.damm@gmail.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Biju, Laurent,

On Thu, May 7, 2026 at 11:54=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Laurent,
>
> Thanks for the feedback.
>
> > -----Original Message-----
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Sent: 07 May 2026 11:39
> > Subject: Re: [PATCH 1/4] dt-bindings: display: renesas,rzg2l-du: Add RZ=
/T2H and RZ/N2H support
> >
> > On Thu, May 07, 2026 at 09:24:48AM +0000, Biju Das wrote:
> > > On 06 May 2026 20:58, Lad, Prabhakar wrote:
> > > > On Wed, May 6, 2026 at 8:50=E2=80=AFPM Laurent Pinchart wrote:
> > > > > On Wed, Apr 29, 2026 at 06:00:09PM +0100, Prabhakar wrote:
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > Document the Display Unit (DU) support for the RZ/T2H and RZ/N2=
H SoCs.
> > > > > >
> > > > > > The DU block on RZ/T2H is functionally equivalent to the RZ/G2U=
L
> > > > > > DU and supports the DPI interface, but includes SoC-specific re=
gister differences.
> > > > > > Add a dedicated compatible string to represent this variant.
> > > > > >
> > > > > > As the DU implementation on RZ/N2H matches RZ/T2H, describe it
> > > > > > using an RZ/N2H specific compatible string with the RZ/T2H comp=
atible as fallback.
> > > > > >
> > > > > > Unlike other DU variants which use a multi-port model, the
> > > > > > RZ/T2H and RZ/N2H DU has a single output and is modelled using =
a
> > > > > > single port node with one endpoint. Add a port property to
> > > > > > support this and update the allOf constraints accordingly.
> > > > >
> > > > > Wouldn't it be simpler to always have a "ports" node, even for
> > > > > variants with a single port ?
> > > > >
> > > > I agree that, from a binding perspective, always having a "ports"
> > > > node keeps things simpler and consistent. Biju suggested this chang=
e based on earlier feedback for
> > the RZ/G3E series.
> > >
> > > From G3E feedback, I got the impression that going forward all future
> > > SoCs needs to have single port and multiple endpoints. That is the re=
ason for suggesting port for new
> > SoCs.
> >
> > Right, let's clarify that.
> >
> > TL;DR: it depends on the hardware architecture (what a surprise :-))
> >
> > When reviewing the G3E, I noticed that the LCDC has a single output tha=
t is connected to one or
> > multiple encoders, depending on the SoC. I think this should be modeled=
 in DT with a single port.
>
> OK.
>
> >
> > Note that this does not preclude using a "ports" node, containing a sin=
gle "port@0". If you're
> > confident enough that no future generation will require multiple ports,=
 then it makes sense to
> > standardize on a single "port" node and no "ports". If, on the other ha=
nd, you think that some SoCs
> > would have multiple ports, then using a top-level "ports" node uncondit=
ionally would lead to simpler
> > bindings.
>
> OK.
>
> >
> > I'll let you all decide what you think is the most suitable approach.
>
> Thanks for the advice. We will use ports that will make the binding simpl=
er.
> We will continue to use ports for SoCs which has single output connected =
to
> Single encoder(RZ/T2H) as well as multiple encoders(RZ/G3{E,L}).
>
As agreed, I will switch back to the ports property.

Cheers,
Prabhakar
