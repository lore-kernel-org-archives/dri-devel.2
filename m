Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D027CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CEDD10F283;
	Thu, 30 Apr 2026 08:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kOFYK4JG";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4588A10F283
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:06:06 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-50e5ad864a6so6330011cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 01:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777536365; cv=none;
 d=google.com; s=arc-20240605;
 b=iC1RTeGWXwlWSP9S7EeHmHoNrWgnaChONY9+C/G21puVkXfAcH2SN79g3Thk9+scbc
 rNHWyQqjaz3mfb+Bz67J3m4wpG1eMfKcwP6qn9nQO1aDTspwGhEQt/uvUQIAI4EoOgea
 qX5phPVvefVluzW0tKCqOehmfakVESSYjAZgv+M7WZ8m9lyOdQDXOxe6i3oLM/Sy1bTf
 UaVlB+hRf9uAzhZCCyHzvFh5q6ntNmTztPaykaLSgzCSWZgkY3M0Aae5CMbci5B7ITvq
 Wsdf3UF0y+BvGDcmluLzkTz0T3hmI4MAziTcL3XmkuSwfIGMLT01WPL+7sVUxp4Mo0Qk
 GEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aHHbY88Ic6fPHsCAIdOdDjCHlL/VlQzAfbBQBfErsg8=;
 fh=QLRxBpMUT6r48/381nflDdq/z/in5s9m1yWUXhnNDj8=;
 b=XY3RBvW5Fu38/fJJue58XalAl5fNDgsh8b1d8wi660GHqkzrxJVCeyoXAi87p4i0gO
 CcE7axgXtwJC18979z3BbRLqgk9A/3/AxNz/69Km1Z35y0zUlJPUOf3i5m4OMSA3HJp+
 Ri9nKADdUqkdsH3TXfbWZJebQ2FLj7Ct3c9f8VsK313MfiG2pJzzJ3EwB/dicxkiFwJM
 AjbMt1T2K+9R0eZ/s/KL/jr/Nd9VEP6LBre5homBJZj3J7zHiM+mruFYLNKjxc51b7MG
 8JRAB7T2tWj1cadZs7HKNpDoCW14GHJsDOvd2oDm0zKLpWmC51dYa1LTEeasMdzyVex8
 MYUA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777536365; x=1778141165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHHbY88Ic6fPHsCAIdOdDjCHlL/VlQzAfbBQBfErsg8=;
 b=kOFYK4JGL6yeIeQ/DEqoZHsYnu08PbkLNC+ri8T5U3K0gS0DCKygYyYj0deMxUJIkA
 maqDSrYe6kVUqWIWP6cJEEPTaIVLb/K1SaXYdv1jmmMuenWQ4OWshubYSoizfypLkXIp
 LRrTl24CfyQ8p9lGlL7gTCXHoD4SRXwtFcVjoSNZkpc7jQ9JT2kTRiuvRgjcelTZPmX1
 2Nsk4PQGPC6ySxeBohEWDkSEx0P8OKYsroN4cK2rkR6uDDzqsTuy1ONPFg4Fe8CCOlTP
 6rH70voxb79QA70NBmIIVSYOY9lUkkrhT8kd4QeVXvxDxn1BUvP36lvDDseuabsRvFzz
 otig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536365; x=1778141165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aHHbY88Ic6fPHsCAIdOdDjCHlL/VlQzAfbBQBfErsg8=;
 b=PyA2w4XqVqpva4+ZJUY2KYAFqkfSKHFDWaUFSxbnCUrOvFXlm7W1FbGISzE8yhI7uP
 fc996DM4zZ5gKzZM4N/IVgAiwIWscpDDcFrAGHg4M2pczZD0F11rEmCax0myLIDYlsOY
 ptixpTPhfouFMtZWCkFQZBjlbxPUITfsex4klvHz0svXFTPCunCKcb0kv8nyNrWrLI/f
 jeIGboSmuI1JgjE1xKwv4bckKI14wkqIncD/w/rM8ZqqLgK8w2FyE1ojnFKhsDtpVNgj
 YRV2/jlJhPFXvzReu424/uzUmWb3NZYnbyMqPyRjM5lRKfQQG6J/qBcsSSodHouAwH4M
 cxbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/5kMbV40ZR4Y1vHCSX+dS/MBjwu3TsQJlymjTrBRrE+LoyWDuBt+ya5Wwflj4nkEDEiLp1ig49kE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0ekuke/n3LrbVWKJ8A0XqlzBWke6arfauc67ZRUJOKjiy0Wvl
 miex4XsEeCuKaIXSm+zqWH5pbjBRbanAZBLbCb691v9FojNArekWRe5D5IignrqoFGwSErkhwfI
 8NquN1W9ybDMs9gAx8Uyzmf32KRx8WvU=
X-Gm-Gg: AeBDieuZ8bTHEd+9Rjscd0J+nUI9ItNUF1VcHssFyAULWbufVj9LCdbTJbjfdBTVkX0
 +C/Sk9w9LKRD57wej9kMfcirf3CtNPCPl7feFg19xGKpJUTFeGp48ANiOBxYP7K3euK41i5DHVf
 h2y5Q6QJwQ4Q47lOG3YfR6AMwJ7IlvPzMNXC4ud7i6tNHcBxxSCk2IaGZwRPhyQwv+SDAgFRFDy
 X/FGQSJf3pnlrioBhoEQAk9hPVTev0R/9K0yFSh0A+ExpOE2pY6jtKmBQvL3elJlAgYUwPNL8Qz
 l2P1O1YZrcJ9aPnXo2qwVY8XFVsf8i4T9DAwDgM=
X-Received: by 2002:a05:622a:1809:b0:50f:b494:7880 with SMTP id
 d75a77b69052e-5102ae00e8fmr24579821cf.51.1777536365053; Thu, 30 Apr 2026
 01:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250728150059.2642055-1-max.oss.09@gmail.com>
 <20260429133333.GA68737@francesco-nb> <DI6BS0B8HTLP.2Q00QFIUQUZRU@bootlin.com>
In-Reply-To: <DI6BS0B8HTLP.2Q00QFIUQUZRU@bootlin.com>
From: Adrien Grassein <adrien.grassein@gmail.com>
Date: Thu, 30 Apr 2026 10:05:53 +0200
X-Gm-Features: AVHnY4KX4Bq5Iz4F53ngH9TavzVTHCJFBpfKqnqz3t9KeC2cBA1XOSrQ9l3Bjj0
Message-ID: <CABkfQAEg7q+XSFVxwBDQ_dQMor2rANN0uZ0MKvuLVy_n9i732A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: lontium-lt8912b: Do not generate HFP
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, max.oss.09@gmail.com, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hello Francesco and all;

Thank you for proposing yourself.

I have no time anymore to maintain this driver (and I don't have the
setup anymore).

I totally agree with this proposal.

Thanks a lot,
Adrien

Le jeu. 30 avr. 2026 =C3=A0 09:53, Luca Ceresoli
<luca.ceresoli@bootlin.com> a =C3=A9crit :
>
> Hi Francesco,
>
> On Wed Apr 29, 2026 at 3:33 PM CEST, Francesco Dolcini wrote:
> > +Dmitry, Luca
> >
> > Hello all,
> > how to get this patch considered and eventually merged? I see that this
> > is not moving since long.
> >
> > Considering that Adrien Grassein is not visible on the mailing list
> > since 2022, and that I have various HW available that is using this
> > combination (on TI Sitara and Jacinto, on a DPI-DSI tc358768 bridge,
> > and NXP i.MX), I have access to the (little) documentation that is
> > available from Lontium I can propose myself as a maintainer here.
>
> Thanks for volunteering! I am not a DRM maintainer, so I'll let others
> chime in, but I suspect you should just send a patch to add yourself to t=
he
> MAINTAINERS entry and (as a separate patch?) remove Adrien, unless he
> speaks up by then.
>
> > I assume being able to ack patches would help the maintenance here, or
> > is this just a glitch and a ping was enough?
>
> dri-devel is flooded by patches, driver-specific ones will unavoidably be
> missed in lack of a responsive maintainer. So this is not a glitch, it's =
a
> frequent pattern I'm afraid.
>
> As above, if you were in the MAINTAINERS entry, look at patches and comme=
nt
> on them, and test on hardware that would be great IMHO.
>
> For this one patch: it looks OK.
>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> Adding the "why" would be better, which I assume to be power saving. No
> need to sned a v2 just for that though.
>
> I'm applying it in ~1 week. It would be good if you could check it still
> applies on drm-misc-next before that, report back if it does, send a v2
> (adding the "why") if it doesn't.
>
> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
