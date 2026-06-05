Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F76ACD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 22:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C81112C48;
	Fri,  5 Jun 2026 22:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fPnO9CkY";
	dkim-atps=neutral
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com
 [209.85.221.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5368112C48
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 22:41:34 +0000 (UTC)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-59ebde7d704so833189e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 15:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780699293; x=1781304093;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxdAlMFBxvqeWetf2Jzav1he/6QnRjj7psD01yf0r3E=;
 b=fPnO9CkY/M/wrnFARES2Dj7HXgxNwEB1DIg4iL4Usnk+djeHIUOdc6gJESSUCNRhJ2
 FK5qoqcOuv1+xFlqL4v0WUFohnTPmD2GR6cLnTErMVqLUs0Ps+HnOZPsBoD3wO35DdSu
 Y/fy1PVSWxZFCgLgrNYpkmEEKMXzWxXKCaPuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780699293; x=1781304093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NxdAlMFBxvqeWetf2Jzav1he/6QnRjj7psD01yf0r3E=;
 b=hiK0Z5BAmkAM9a/zMfIed8bHFP8HOfQ08e6enH6KWZInnmJMEKeA4n+RTttCOSDIa8
 8NJcyyBY1feBnHftrvwaPyeLOuYCYOtdkKMoSZPZkkvuPR9z7KjYS0AU8Ply4MHcSdMK
 p4NJtvVRPJoqNTPfeJRqbPNNk7v62El7StWfKhC/mCZ7U0EZXrweh6PeBdrwN+WtOJuX
 IK6QJ09zVBIDPULQLOtlnkRyzGokrKnRQZjcEKoljor/wCeK7RkMbAi6JYuU/QsgtSLq
 T3xlyOfoBQS3+5UrQ8kS8rmPM8MDc3LqJ0FgoOPRzMuBhvv52JDLP84u02breQ9WoaD7
 hRpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nh0UvW2MfjZZzB8wHjBnPkasWGIlWrkySylzL3+in2qEUR4PYBJTP3JbwaNgX1GCS2qlXdJWP4aY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/f39W+K8lCYGSvvdgCEcJOMZAB7FwhiJ1cvsGjr2YoZ/j4p5l
 gmKKk98nwgjQbunKAv5CnudeKRILRnzuDdj5Jx3ZtyLJ0qcBweT12atoh4cTqBBtYUIhQZige8G
 2CQE=
X-Gm-Gg: Acq92OHSg4EQUkCst/vIVzuY4Ns4Azkq/Sk4Sb7Q8+0VbmWgf8f/qd0M3UJTRQymClD
 Wiv3WrpHSc8p1iDk3mH/nDi+1t0WkEAG55LkYqvMzVFvjro3bE5kwzuMfhHx7JD3DSqMt0cDjJH
 BI0Ponw54Iuo2CXx8ywNYDrjeN1G59exLpszGkfqcVVEPRxNmiXj7Re3NwhNsXcG4wO5sEvYoTs
 qKlLk7Uy6mvwbhTBKcNMnTfRnfIzSF54UtoOqEIqUWgf7phC61WXXBLX6bD8lFmFV30trYmNKN3
 JjuyNgZpGNf8e1pDc0mXdf+8SOnnNXYZ8+JpRud/fAKTL+z4l0BS/29Qkn8dcIGjEPFCB6ULpLt
 d/YRl1EIut0YFmQ9uAnJgdNcx/IWcFewfb8ALMuvUh6TkYnKYNT3D4QjNK5zXiPxBWLA/St9flT
 UgGif48aAgAMKv0+VxHGJdYINS2O94R1/ICETfHZYDpS6/nOWVVLEeOVQL7YoWxngzew1iPY+g9
 Nkhi6VPNAA=
X-Received: by 2002:a05:6122:e203:b0:575:36c4:8900 with SMTP id
 71dfb90a1353d-5ac52055628mr2908692e0c.14.1780699293457; 
 Fri, 05 Jun 2026 15:41:33 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com.
 [209.85.217.49]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d6dc3d3fsm9329250e0c.5.2026.06.05.15.41.31
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 15:41:31 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-6cfd17e9250so1046693137.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 15:41:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/3qAko+mv0jm6Ni5ZC3uTzz/8/2cUI5YukRmrASDWcfm7Wro6EOwGbxiLlqnrUYDt58tBmAdddbdo=@lists.freedesktop.org
X-Received: by 2002:a05:6102:2922:b0:635:1bc8:3568 with SMTP id
 ada2fe7eead31-6fefe98bb4amr3098337137.23.1780699290556; Fri, 05 Jun 2026
 15:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-1-57c70c23d0d6@oss.qualcomm.com>
 <CAD=FV=UaPKiGSL6mhVdywp67skSr2B7977f3kZ23FFHaD=95RQ@mail.gmail.com>
 <20260605152825.GA3740391-robh@kernel.org>
 <CAD=FV=U7jz-xwA+-Fic2thZaK6eCDhc-PZ1fqpCMAUmy3V3Y+Q@mail.gmail.com>
 <CAL_JsqK6u=x=ScTnW1jJCPZpCUb3mT0NZpsKqe6PqZmrNEKZiQ@mail.gmail.com>
In-Reply-To: <CAL_JsqK6u=x=ScTnW1jJCPZpCUb3mT0NZpsKqe6PqZmrNEKZiQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 5 Jun 2026 15:41:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBn78eOC_zG0S2U-W3whrVYEpghKF_WgX+3zpUJ82-5g@mail.gmail.com>
X-Gm-Features: AVVi8CfhuBhdP6-5vH6s542O1z5nb76ugorEAmoG2LM_DR_IrP8yU98AI3rZB0M
Message-ID: <CAD=FV=XBn78eOC_zG0S2U-W3whrVYEpghKF_WgX+3zpUJ82-5g@mail.gmail.com>
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

On Fri, Jun 5, 2026 at 10:14=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Jun 5, 2026 at 10:44=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Fri, Jun 5, 2026 at 8:28=E2=80=AFAM Rob Herring <robh@kernel.org> wr=
ote:
> > >
> > > > > --- a/Documentation/devicetree/bindings/display/panel/samsung,atn=
a33xc20.yaml
> > > > > +++ b/Documentation/devicetree/bindings/display/panel/samsung,atn=
a33xc20.yaml
> > > > > @@ -25,6 +25,8 @@ properties:
> > > > >                - samsung,atna40ct06
> > > > >                # Samsung 14" WQXGA+ (2880x1800 pixels) eDP AMOLED=
 panel
> > > > >                - samsung,atna40cu11
> > > > > +              # Samsung 14" WQXGA+ (2880x1800 pixels) eDP AMOLED=
 panel
> > > > > +              - samsung,atna40hq08
> > > >
> > > > Sure. I'll repeat the same comment I made the last time someone lan=
ded
> > > > a change to this file [1] in the hopes that maybe someone will post=
 a
> > > > patch one day:
> > > >
> > > > <repeat>
> > > > Given how many of these we're up to now, I'm starting to wonder if =
we
> > > > should come up with a generic compatible like we did with "edp-pane=
l"
> > > > and then we can stop having to merge CLs like this. All of these
> > > > Samsung OLED eDP panels have the same power up sequence and once we=
 do
> > > > that then we can read them via EDID or via DP AUX bus to identify
> > > > which specific panel we have and if they need additional tweaking,
> > > > just like we do with "edp-panel". Do DT folks have any opinion abou=
t
> > > > that? Coming up with a name would be a pain since I wouldn't want t=
o
> > > > assert that all future Samsung OLED eDP panels will have the same
> > > > powerup sequence. Maybe "samsung,amoled-edp-panel-v1" even though t=
hat
> > > > sounds terrible and there's no known need for a "-v2"?
> > > > </repeat>
> > >
> > > If things are the same, then perhaps there should be a fallback
> > > compatible. Or just reuse an existing compatible.
> >
> > Right, there already is a fallback comparible. This patch is just
> > adding a string to the enum that has the fallback compatible
> > "samsung,atna33xc20". So someone using this new panel will use:
> >
> > compatible =3D "samsung,atna40hq08", "samsung,atna33xc20"
> >
> > My point was that listing specific panel isn't really valuable here.
> > Though the "samsung" power sequence isn't completely compatible with
> > the generic "eDP panel" power sequence (which is why they have
> > separate drivers), just like generic "eDP panel"s we can query the
> > panel ID if there are any per-panel quirks.
>
> Unless the quirk is how to power on/off the panel...

Well, only if the quirk is how to power "on" the panel. ;-)

If a panel does need different power-on processing, then I'd expect a
new compatible string unless we end up in the situation we had with
eDP panels where there is a ton of second-sourcing going on and the
quirk is relatively benign (like the "hpd-reliable-delay-ms" and
"hpd-absent-delay-ms" properties for "edp-panel").


> > So the question is: should we stop adding specific panels and just
> > always list "samsung,atna33xc20" for all Samsung panels with a
> > compatible power sequence, is it worth it to add a more generic name,
> > or should we really keep listing all these individual panels for no
> > real gain.
> >
> >
> > > I can in no way
> > > prevent someone from using 'foo-panel' in their DT when the h/w is
> > > actually a foobar panel if the differences are transparent to s/w. (B=
ut
> > > I will reject a quirk property later on when foobar turns out to be
> > > different than foo.)
> >
> > It's more a question of what guidance we tell people. Here, Konrad is
> > trying to do "the right thing" by listing his specific panel and then
> > using the fallback. I'm saying "listing the specific panel isn't
> > gaining you anything" and I'd rather not have to review / apply these
> > pointless additions to the bindings.
>
> I think the guidance is clear. Overall, doing something special here
> because Samsung panels are special just muddies what the right thing
> is for everyone else.
>
> > ...but I can imagine people will be upset if I tell them to list
> > "samsung,atna33xc20" for all compatible Samsung AMOLED panels. It
> > would be nicer to come up with some sort of generic name?
>
> Well yes, people have a hard time using compatible strings that don't
> sound generic. That's too bad for them.

OK, so sounds like going forward I should NAK changes to this file and
tell people to just use:

compatible =3D "samsung,atna33xc20";

...to mean "Generic Samsung AMOLED panel with power sequencing that
matches atna33xc20"

Yes, it means that if we find quirks with a specific panel later, it
could possibly be harder to work around them. However, since we have
several ways to identify the panel (via EDID and via DDC) this seems
fairly low risk. You can't perfectly predict the future anyway.


-Doug
