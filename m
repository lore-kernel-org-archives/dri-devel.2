Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1900BF54AD0
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0D910E4E0;
	Tue, 24 Mar 2026 16:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rxQuStRL";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B01310E4E0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:01:48 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5a126c8aab9so4713795e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774368106; cv=none;
 d=google.com; s=arc-20240605;
 b=O+tF9I4SJOTJ3V/LqZPsIU1iazQgbGUMF1GV8oi9311YbeGq4I2ierMy1AzW+kOTSl
 6UnrPDJpXYBb3OIGH1EfrlEL5ZaTkHuDO+xXhk6qUjFqN5vCSH+uGVvcs6vH7TJynYSz
 QHB2cDQBMp+yOJuukz0fOVjSdzxn78/pPsT4Q8J0OY8DhSU6oRlYQGu57BA7tdG5mI03
 6dCX6HTYGXVIhxhfc3y1Ts0BgViJ8i7tktCOh0E5tD1pB1AZXushL80eN4wsxMMRvbDz
 7nNhjmtNX6vZZKtN2sn63Jr1nML4UA+24Rl7GEQVJI8emlAEvg9yDCxMt/S6g9y1pERQ
 LjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nrJzMvzeHZjGfPnSDRk69y0I21STEYkJGWfpIwAOFso=;
 fh=v6a8zwi4IB/rZXUE7AiEF5ktmx1tXclBqzvNXUOpmeM=;
 b=FmJh99uPV20Zmhqalh1HKLHzZ8Hoa3SCtFLWMbrEWJ8vfMwN2XajKtgg2cm7hjGAc+
 uGIvD4sJeOHWAp8z0oy8F4f8DfinVkatE3rhvwmEltVMUItEhdhNt1WbLEkle25+Sb4d
 uErC9Ymx6+ZQG0YLtyBWy/fXrYtJPsIHbsIW3c6kmoYBaBh0xesrTJ+j7fIN7SVcyU7S
 eCUwOr2IooYEK2irIAU39I8op+mZV3b8AhGywyIyRLr10be3LZI8F40bEg5Ni32UqeAH
 ZD7ckunSIZDFqmnIaIcqsXu8ainyfVLvCjSkZ2SnuSkOq8L4WYNE2Q6t0UP++0SgifLR
 2D6Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774368106; x=1774972906; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrJzMvzeHZjGfPnSDRk69y0I21STEYkJGWfpIwAOFso=;
 b=rxQuStRLjx7WEVqSSm3T1qxq+U0qigCOKZuKISwKoutqvDKk0SKSfOhQJpnziltpb4
 jwJDkzid9xLH7i5d2uF1ylW2UsIMYOXNXm1402NMmq6vpAJzR1IrnQv+5iP/Ul0uaguX
 lF6b+BzhKqOKX/XHsuBK3ydqrXpRnm1GS7ImJOKALE1L+D3FxE3aSOdtodJUOnx9A+Dc
 C7+CnKvUXLOAS6/wVJS+PLGrVTzglmoSakextYwYMHmhhwKNR7Hh/JkagD4RYieKy2YJ
 ttoL6cGNK4HnHXrPFbqlLbKrXrJt4Dh6wMJ7sytZDCqOE9vU1+Nu4bUPAzuGACBP0M1D
 +UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774368106; x=1774972906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nrJzMvzeHZjGfPnSDRk69y0I21STEYkJGWfpIwAOFso=;
 b=I3dJlOfZ9du4s8+ZrHqOfPoeX59Lr7nv45w95GamzoYXfWZj7a9mb3PStmgHSZDSHF
 PxYsWLGIp8fT2Y89U484kUcPuEFWoCgMhRFUNSWDXOUYbZ376WPJwnG4uNnkQTbCWBoW
 f7vzWeMpmZrJpae8jNZbGt6rsNReOl9pobr7WxCNFVQ/8LsDBHoqub7WiNWJEpQBgoLS
 c+CjjuNR2A6xGBqBdLuZTkHqjzEsDWbuUQ4UdP8NZokxc8dKd3us6dJ74yI02ezfZ43G
 8U7Zec3cdR/ksDW+Zo9d8pYqHK7dfOg2608V1UHPNsPKbmGgDZAYPBmQcYvyOKtZI3DI
 FcnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiuf9dMzDvsXU09v2BYP1VjLXNuD19ImAonl6JCRfLAmb9cCH8OTuWgE94DooPMAcKuUOe6jDO4FA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw40T9QbxFD/wUGOZuzpcQSNA8mkKAlZrZ9Dphe0cGMdsUgIuFI
 Rezt7zXH1t8mRSz/OazWRINQijtO4PL51xG1I2nEVnW9ejCLrDY90b4tOtA3O4vAMDfW3F9JvGj
 fvZ/MnbVXyG9PDIFowNFyF/mE4zcxntA=
X-Gm-Gg: ATEYQzwmaYX9uPsMl8Nwavn752mgq0zWi5RTuBuMgXH7gAz1z4vrMGLqwVfHvbbigkV
 Q0L2iahafWox5/y1on6avk587x3jF2VhBkwmsbmhxZNRk8dcMSrzYdUr9YCo/KpaD9gHzvR+HQp
 WOy/v2nyA7KFGuOXqVkvxZ1P1jcqbHV3GCUc4TBk97AbV9cbgT3APZUOMegSf/FLtSczxQOjGCY
 ZNAfZY3FRDzQCwl4KpCHzjTjJI9FO+cqMzQOkuHZFqmKA9S5wtlKfMVe2Q1TSmjEfbM4VNDC5ba
 KUb6l5wMfSv7kFhn06+THvwbzj0ULj/uL55h02V7kJKR0VrDczUKf68OPR48YD1dDdMJTzaPlrm
 GUhg=
X-Received: by 2002:a05:6512:39c4:b0:5a2:95c8:ca5e with SMTP id
 2adb3069b0e04-5a29b9a16cemr10428e87.31.1774368105945; Tue, 24 Mar 2026
 09:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260323-ch13726a-v3-0-e28b6f97fe80@gmail.com>
 <20260323-ch13726a-v3-1-e28b6f97fe80@gmail.com>
 <20260324-dexterous-snake-of-progress-ea8783@quoll>
In-Reply-To: <20260324-dexterous-snake-of-progress-ea8783@quoll>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 24 Mar 2026 11:01:33 -0500
X-Gm-Features: AaiRm52QlZgq-pYKdDII5R-UZpE70r1UAWoE9tJ0Dx3Ru2XFLdzKXalMbWfEOAs
Message-ID: <CALHNRZ-TAQmcwYr9iW+j+S5Egh11C0LpPeY1SO=hgDdvG8otqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add ChipWealth
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

On Tue, Mar 24, 2026 at 4:08=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Mon, Mar 23, 2026 at 12:08:32PM -0500, Aaron Kling wrote:
> > The Chip Wealth Technology CH13726A AMOLED driver is a single chip
> > solution for MIPI-DSI. This is used for the AYN Thor bottom panel.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  .../display/panel/chipwealth,ch13726a.yaml         | 65 ++++++++++++++=
++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/chipwealth=
,ch13726a.yaml b/Documentation/devicetree/bindings/display/panel/chipwealth=
,ch13726a.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..5d964900795653401a87199=
4bcf6403cdeaad64f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/chipwealth,ch1372=
6a.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/chipwealth,ch13726a.y=
aml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Chip Wealth Technology CH13726A AMOLED driver
> > +
> > +maintainers:
> > +  - Neil Armstrong <neil.armstrong@linaro.org>
> > +
> > +description:
> > +  Chip Wealth Technology CH13726A is a single-chip solution
> > +  for AMOLED connected using a MIPI-DSI video interface.
>
> Here you describe the hardware, including what I asked last time -
> explain why this is ayntec thor panel, but not chipwealth,ch13726a.
>
> Then also name the file as the compatible. If you do not know the part
> (model?) number, then why do you think filename should be called
> ch13726a?

The vendor source release for the AYN Thor calls the 'panel' ch13726a,
but per the data sheet for said part, it's a chip used in various
panels, not a panel itself. The handling for various panels using this
chip will share a lot of similarities since the chip is what the
kernel driver will talk to. The alternative would be having separate
drivers and bindings for every panel that will be mostly duplicated.
This is the case for multiple things supported in the kernel already,
such as the vtdr6130 which is currently described as a unique panel
but is in fact the part number for a ddic. And I will need to refactor
that for another device I have in the pipeline. In fact, all the
device panels I need to submit in this context reference ddic's and
not unique panel models. I'm waiting to see what gets approved for
this series before sending the rest of those in.

If I add something to the description like 'This chip is not a panel
itself, but is used to control various panels', would that be
sufficient? Or does the kernel need a new way to describe ddic's
separately from panels, since this seems to be common now?

Aaron
