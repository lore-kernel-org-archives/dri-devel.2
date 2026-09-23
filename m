Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250D2C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4062410F199;
	Wed, 23 Sep 2026 20:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CpH4z28n";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAFB610F18C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790193949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ae8Rl5S099tC0SY0KTEywfRG63UpqYux9WWg47ljxY=;
 b=CpH4z28nLL6iibu4ohvydbY/25n4fKMjpdOqXajkwXc5O39WL9pAV5uyHFsnnuON/QWg5O
 /Bw/NTgti341ND+1vN7fZQFpNpqZNhht57VkczoVYc+rOuiyOPB9fE1UOndclXM+lHH74Q
 bXzWo4obVBax7PC+sLvM/Nw81HgCUPU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-t7MO0V9PNAijh4LcCSkauw-1; Wed, 23 Sep 2026 16:05:48 -0400
X-MC-Unique: t7MO0V9PNAijh4LcCSkauw-1
X-Mimecast-MFC-AGG-ID: t7MO0V9PNAijh4LcCSkauw_1790193947
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a05d645acso261712285a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790193947; x=1790798747;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Ae8Rl5S099tC0SY0KTEywfRG63UpqYux9WWg47ljxY=;
 b=eHmwzl3z6a616nibfxE6Kwua5NZC2jN4NB2NglGjgTr7zIvXCyJyJKVt9CNOiUxdMN
 6JrysXv8i/Z5Ewr/zwzEV1L/FqdECA6x2lwebpVcZ7aewiZCnaQpvK0Q45c3UerUv3LM
 tIits5KXyKeF3Z+p5x/UTBEcVZmLbgrn/GIaZNODkvoMQ0/cWTiWY4YgF40ca9HJKpij
 PPeEBSb8N2aPM4alDBjTwJkICcJ+B0ffmW8QWfsB2cj3TwYVwz7r8ELGRKIhugsHUuvz
 ma8T/9hhjKJm0SyN8tu+L4EjmXWnF06xAZpVkDYM49vqs+ngnbuoXcKNGqLKWzBI+hTG
 JKiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvTuMNOsdYAK2dfUKFmgYfQg4nLNL5907pHqaFQswP57ESlbf8+mMsaEafA3g7KDN/znvfou9uSio=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ljQFQOyEJxrKOYtzhj86g+2XXxkUe1EPEtJ2OfIEsk2Fg/yDEC
 2auO+drOEzZrN8hA1Ooa5sSUhBvz5DkBk2smevlSGJSgTvV0PTeObwlcX5By4Ftgu/3SL1kj80n
 w3mWz+CXi+wYqDKCT/rCqXyHfy5EpL8erRRg9i+enrQ4+eGjwHgkf4Uk8VDB16KDA22k9qA==
X-Gm-Gg: AYBFou30jfjQ8JOTnxwzC3PvgJAUD1FNh+Vqh5Z9iOgdo/6vXgstsh35ku2OzTyDBj2
 D5/9BG7sZcVVJzEVHluHpJsW3HoPRVx1Degg5GKLcigaBj/SAdDqZUVlA8T+xWLbSTIIGKFyLot
 QJr0nN0htMqToCfvpO+sIiqpI9aPEhkFO/0y5C49MrVp3c3EIfS0kf75Ol3M55vYRn9cJEH4VZi
 6TIHANf15114HTXHTzJtESVk6bom9BA++lqJuHpIeGOBS9SIbR/hG4eDwnXjEPeTybz5yLaPOnk
 cwgU1wl0qr+EYvSm+fwDozvavIPmPsdAVeLSC/eWU4BfrBHGaQXzrxcAf7ikZwsJBrHSo0c=
X-Received: by 2002:a05:620a:6ccb:b0:93c:17db:d91f with SMTP id
 af79cd13be357-93c3479e348mr42241085a.39.1790193947468; 
 Wed, 23 Sep 2026 13:05:47 -0700 (PDT)
X-Received: by 2002:a05:620a:6ccb:b0:93c:17db:d91f with SMTP id
 af79cd13be357-93c3479e348mr42237785a.39.1790193946917; 
 Wed, 23 Sep 2026 13:05:46 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c24753395sm301143985a.4.2026.09.23.13.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:05:46 -0700 (PDT)
Message-ID: <07d66ea7e0f0c7aef313b11d0881ca9170f05c77.camel@redhat.com>
Subject: Re: [PATCH 0/6] drm/nouveau: HDMI output colour format and
 quantization range
From: lyude@redhat.com
To: Daniel Campos Ramos <Capitain_Jack@yahoo.com>, 
 dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, dakr@kernel.org
Date: Wed, 23 Sep 2026 16:05:45 -0400
In-Reply-To: <20260923162348.1037898-1-Capitain_Jack@yahoo.com>
References: <20260922215336.612239-1-Capitain_Jack@yahoo.com>
 <c78df20bd86437dd3987053765a550b3bac0cc65.camel@redhat.com>
 <20260923162348.1037898-1-Capitain_Jack@yahoo.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w_QtoGSYPkERr3xoBxe7dpJ2UuUjP3cSbHIhQYNzw3Q_1790193947
X-Mimecast-Originator: redhat.com
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

Responses below:

On Wed, 2026-09-23 at 13:23 -0300, Daniel Campos Ramos wrote:
> On Wed, 2026-09-23 at 12:13 -0400, lyude@redhat.com=C2=A0wrote:
> > You need to either tag your work with Assisted-by: if it is
> > generated
> > by an LLM. If you did the right thing and wrote it by hand and just
> > used these tools for analysis, that's fine.
> >=20
> > FWIW, If this was entirely generated by an LLM, then this is quite
> > a
> > lot of work and I'm very hesitant to review this. Going off:
> >=20
> > https://github.com/danielcamposramos/awesome-linux-hdr
> >=20
> > I am very concerned just about all of the results here came out of
> > an
> > LLM, according to the LLM generated provenance file, which means an
> > actual real person with experience working on this needs to go back
> > and
> > verify that all of this is correct. That is a lot of work, and the
> > idea
> > that my review comments are just going to get fed back into an LLM
> > are
> > not remotely encouraging to the effort of having to go through and
> > have
> > a real person look this over.
>=20
> Thank you, Lyude, both points are fair.
>=20
> The code was not written by hand: an AI partner wrote it under my
> direction, and I left out the Assisted-by tag the kernel
> documentation asks for. I will resend with it on every patch, and the
> Deep Color series gets the same.
> Sorry for that detail: I disclosed it in the cover letter body, but
> the tag belongs on each patch.
> For the record, the tools: both series were worked on inside Claude
> Code CLI and Codex CLI by several AI partners, Moonshot's Kimi,
> Zhipu's GLM, Anthropic's Claude, and OpenAI's GPT Astra and GPT Sol.
>=20
> What was mine: I found the problem on my own bench (full-range pixels
> to a Sony without a VCDB), set the design rules (follow
> drm_hdmi_state_helper.c, use NVIDIA's open NVKMS as the hardware
> reference), and ran every hardware test myself, 25 configurations,
> checking bars and levels on the set.
>=20
> The OCSC1 values were checked against NVKMS, not taken from the
> model's memory; the BT.601/709/2020 re-derivation was also done with
> the AI.
>=20
> On awesome-linux-hdr: it is an index of links, not the evidence for
> this series.
> Its provenance file names the AI partners for the source surveys; the
> hardware results are my bench measurements, and the logs for these
> patches are run27 and run28 in sony-bravia-linux (tools/stereo-
> modeset).

I'm happy to look at logs if I have something specifically I would like
to verify, but verifying the entirety of how this works from a bunch of
logs and measurements along with knowing whether we're missing anything
from this implementation that would lead to regressions (I already know
we are missing some things, which I will mention below) is more or less
the same as having to go and just do the work by hand myself. At which
point, I would strongly prefer someone to just implement the findings
of those results by hand.

We also have someone who has been working on these features on
nouveau's side already without the help of an LLM, and their work is
pretty much almost complete already and handles the missing bits
properly including:

 * Implementing IMP both for atomic checking and for tile allocation on
   some tegra platforms
 * Implementing display bandwidth allocation. This is needed for deep
   color with higher resolution displays, which will crash the GPU
   otherwise upon trying to set them (which I think would be the case
   with this patch series).
 * Enabling DSC and FRL on HDMI (also needed for higher res HDMI
   displays)

We've already merged some of their work for this, in particular some of
the work for fixing up blackwell and also reading HDR information from
EDIDs. So I'm not really sure we want to use this work anyway, sorry
about that!

One last thing though: it's somewhat of a moot point now, but in the
future: please consider just limiting your usage of LLM tooling for
actually figuring out the details of how things work and then handle
writing the code yourself after you go through the various openrm
sources it points you to. If I had accepted this work, it would have
taken a lot more time for me to actually get across the finish line and
be comfortable with merging it then is really needed. There's a very
hard limit as to the level of confidence anyone can have with LLM
generated code without spending more time reviewing it then you would
have if you wrote the code yourself, because you're now approaching
your own code submissions from the narrow perspective of a reviewer and
not its author.

We do require people take responsibility for LLM submissions. It's easy
to you take responsibility, but this is more complicated then just
"yeah I'll try looking at it again if something breaks". To me, if the
code is LLM generated, then the work in it's entirety needs to be of a
size where the author can reasonably have the exact level of
understanding they would have had if they wrote the code line by line
themselves and also trudged through the actual OpenRM code they were
looking at themselves. Otherwise, I have to be the one to do it in some
form. And that means me taking responsibility for the possible fallout,
and spending a _lot_ time then I would with a normal submission to get
as close to the level of understanding as an author as I can and then
take on the responsibility of dealing with the potential fallout of the
changes myself, quite possibly on my own.

FWIW: I think the approach that was taken recently with reverse-
engineering how ray tracing/BVHs work on nvidia hardare is a great
example of how these tools can be used without creating friction for
maintainers. There was plenty of AI generated code there, but it was
only given to us as a proof of concept with the expectation we might
not actually use any of the code. Which meant we could try implementing
it by hand and learn everything we can about the subject matter
throughout that journey instead of trying to trudge through the LLM's
code and hope very hope we don't miss or glance over anything. Just
approaching stuff this way does genuinely provide a lot more confidence
to maintainers, and does help to reduce the workload we have to deal
with by making sure there's always a person reasonably in the loop.
Otherwise we're struggling to make sure that's the case a lot more then
before.

>=20
> I read review comments and answer them myself.
>=20
> Fixes will again be written with AI help, declared in each version,
> and tested on the same bench before they go out.
>=20
> To make review cheaper, I can resend only patches 1 to 3 first (the
> header, the head programming, and Broadcast RGB, which fixes the
> visible range problem), or wait for whatever priority suits you or
> suites better. Feel free to also include it, if you want.
>=20
> Daniel

