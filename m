Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9398CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BFE11A231;
	Fri,  5 Jun 2026 15:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hJYEQ8bp";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525BA11A231
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 15:50:18 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8ccef9eabccso30193126d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780674617; x=1781279417;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZktE3L5rKfoN1/el6TuB/5aSd1JOfP8XWyiHhYJAdA=;
 b=hJYEQ8bpnY/mIfvT5LI07V2TykVOkhrNvm4FdNei+URG9di8gXaZtiI+WovGdSLaIl
 E53ZHlUATK6sXwPpw2Zw9gdZ3yD3ToKG6pB+b6VRY7kh3yBdO9uHKYlnCA+2vuPF/TX0
 GQV3yTBUWGg+KP3ns2yONhvJUQVy4SsCx5RzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780674617; x=1781279417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CZktE3L5rKfoN1/el6TuB/5aSd1JOfP8XWyiHhYJAdA=;
 b=LcKms6tkenddi9DYWg8oJl5G0Vfh2NjuKuBZWp/U+00phHeuoHge7hqj2BhoUtE7U9
 kibOMbc9P9PfaVMTrPmqgtBoaLg6aJTTELcU8v6Sm+2fvSUXf/c6w6hdqtGfX6BA9ysD
 lsQ/mj4wdW3xaKa3qxUhikUk0hGt2XcvM+9FQsU26tntinVQaaad3i6L1sIzGJz9enMw
 FIDhc6xuSsCpzZaWC/Q/9yyCJQs78ohzJcoIulNQgMPZoalj2MhjyGpyeA682uz7xtA5
 WuLzq/P88ta+V+OmARVA0mm5QEoeiZ31b8dVoUq2TClvtbWzoJBoYVB+f0l3bGYOlbBH
 X3vA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8iB0gzJN38oaty2JDs9EL60Tl0DzB4qWtsw28Rpy6QbBKGDi7M+yJLjyHeHrceqoz/4M07yJYy1k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4amZpsCRyDD8saTN8gRBX0O8bYmNb2Jh2m4U/zdho4E80z5l2
 IhlJYHfJ3Tfm2CO1LfmyCD/JI45HFceUsLK2RputXKeqM+//DOva6qriH/949IIs5efqruD+zau
 N0Uw=
X-Gm-Gg: Acq92OHOpcQFsY4CIOHLVTwrG8YBAzANjwqLPA04gDiFaydUgL9VF+yF5/Le7lCiKVU
 0hl+WdduusZ6nI20wI0oeqI0OhU5DTGVvUDcEk0RZ82/8TmlYJ3q9mcV6bdn+SsgPJ21/t+JZi5
 JPMaFSj6wYd2gZj6kYnLCDZZk2cBkSZuhUr+EykqnXbhipHH1zPrdY6Xx+7BnigUfnDeYfwttVz
 Yu0taheHw932xYPcUGY6q//4AcGi6GHoo1HaiCo20mibtSH00hoTI5l7oKEDXdSr40cE0FVsoTY
 6+VWSJvzowCCtValv8GJr25qYzmLY8p1L78bakgoz3eA3Il0f6yoMEHnn0UPP2sDMgs1Ql9RWxU
 mS01WLHplQLrz0+vtaFcrHVUZc2NfCVgk9VN1QArOl/eJPId1Ai5YkSl0IWAAAWeNQxKT9RH2Vo
 IQWUaAZPTrBfcMV5ntM3dnCRq4RzzzgJ9oKzRapbiPIHNBvy3YTY0I9dGl8ZXhbP+SHcitsZGB/
 dP5
X-Received: by 2002:ac8:57cc:0:b0:517:70a5:c875 with SMTP id
 d75a77b69052e-517987a8e1dmr5457751cf.14.1780674616931; 
 Fri, 05 Jun 2026 08:50:16 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com.
 [209.85.160.170]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517940762fbsm27011571cf.18.2026.06.05.08.50.16
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 08:50:16 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-517907feed0so14258421cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 08:50:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8wKV7V8pORcD3MAlcDTQ9VvTbsQrcFcnyg+0lvzlHrG/6bYv26NwUD24FMQxe93I8zrehvOS0vBcY=@lists.freedesktop.org
X-Received: by 2002:a05:6102:8347:10b0:6b4:d9ba:d9d2 with SMTP id
 ada2fe7eead31-7002d6be5e9mr1035796137.6.1780674274409; Fri, 05 Jun 2026
 08:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-1-57c70c23d0d6@oss.qualcomm.com>
 <CAD=FV=UaPKiGSL6mhVdywp67skSr2B7977f3kZ23FFHaD=95RQ@mail.gmail.com>
 <20260605152825.GA3740391-robh@kernel.org>
In-Reply-To: <20260605152825.GA3740391-robh@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 5 Jun 2026 08:44:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U7jz-xwA+-Fic2thZaK6eCDhc-PZ1fqpCMAUmy3V3Y+Q@mail.gmail.com>
X-Gm-Features: AVVi8CdDy3XFBVBoorpIXJgEbshGHoXa78jsg55oeGuqaaVdEdPTZn0YzBf-fxQ
Message-ID: <CAD=FV=U7jz-xwA+-Fic2thZaK6eCDhc-PZ1fqpCMAUmy3V3Y+Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: samsung,
 atna33xc20: Add ATNA40HQ08-0
To: Rob Herring <robh@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
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

Hi,

On Fri, Jun 5, 2026 at 8:28=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> > > --- a/Documentation/devicetree/bindings/display/panel/samsung,atna33x=
c20.yaml
> > > +++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33x=
c20.yaml
> > > @@ -25,6 +25,8 @@ properties:
> > >                - samsung,atna40ct06
> > >                # Samsung 14" WQXGA+ (2880x1800 pixels) eDP AMOLED pan=
el
> > >                - samsung,atna40cu11
> > > +              # Samsung 14" WQXGA+ (2880x1800 pixels) eDP AMOLED pan=
el
> > > +              - samsung,atna40hq08
> >
> > Sure. I'll repeat the same comment I made the last time someone landed
> > a change to this file [1] in the hopes that maybe someone will post a
> > patch one day:
> >
> > <repeat>
> > Given how many of these we're up to now, I'm starting to wonder if we
> > should come up with a generic compatible like we did with "edp-panel"
> > and then we can stop having to merge CLs like this. All of these
> > Samsung OLED eDP panels have the same power up sequence and once we do
> > that then we can read them via EDID or via DP AUX bus to identify
> > which specific panel we have and if they need additional tweaking,
> > just like we do with "edp-panel". Do DT folks have any opinion about
> > that? Coming up with a name would be a pain since I wouldn't want to
> > assert that all future Samsung OLED eDP panels will have the same
> > powerup sequence. Maybe "samsung,amoled-edp-panel-v1" even though that
> > sounds terrible and there's no known need for a "-v2"?
> > </repeat>
>
> If things are the same, then perhaps there should be a fallback
> compatible. Or just reuse an existing compatible.

Right, there already is a fallback comparible. This patch is just
adding a string to the enum that has the fallback compatible
"samsung,atna33xc20". So someone using this new panel will use:

compatible =3D "samsung,atna40hq08", "samsung,atna33xc20"

My point was that listing specific panel isn't really valuable here.
Though the "samsung" power sequence isn't completely compatible with
the generic "eDP panel" power sequence (which is why they have
separate drivers), just like generic "eDP panel"s we can query the
panel ID if there are any per-panel quirks.

So the question is: should we stop adding specific panels and just
always list "samsung,atna33xc20" for all Samsung panels with a
compatible power sequence, is it worth it to add a more generic name,
or should we really keep listing all these individual panels for no
real gain.


> I can in no way
> prevent someone from using 'foo-panel' in their DT when the h/w is
> actually a foobar panel if the differences are transparent to s/w. (But
> I will reject a quirk property later on when foobar turns out to be
> different than foo.)

It's more a question of what guidance we tell people. Here, Konrad is
trying to do "the right thing" by listing his specific panel and then
using the fallback. I'm saying "listing the specific panel isn't
gaining you anything" and I'd rather not have to review / apply these
pointless additions to the bindings.

...but I can imagine people will be upset if I tell them to list
"samsung,atna33xc20" for all compatible Samsung AMOLED panels. It
would be nicer to come up with some sort of generic name?

-Doug
