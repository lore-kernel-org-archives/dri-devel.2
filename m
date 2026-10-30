Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D6606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XOjMGlD7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F60A10E4E3;
	Fri, 30 Oct 2026 10:03:11 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D03E510E4E3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:03:04 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-3535bf8b3e0so876065eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 03:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793354584; cv=none;
 d=google.com; s=arc-20260327;
 b=J2yUK8YJlMAnwtL8JUDP6EjOJcLlIBkQJ09kooRhKvRyP/LtrgFybufwfkSf7cZPcx
 juR+qwuVxS6yq90o4/H/sJxNiyQ66tNjhyEK1iwjw1lOvw9jChgBc+DwBAjSStr3bfiO
 cWmlRhX23SBwo23wfZ4/ykVfxSoCe+HyDW6uecF0qxIgAL85BwH/X4sfeUW3LFgy4WsV
 SGcF8NlFPqiRnl2P+GUTeEzJtC/rTQJ302gka4q53qIy5xJZ2MGbUB8dZGzjdgtnRkZJ
 bm1MxRL7oOsBEpcx1Tg42i/MKPBxt1T+5X0/eIOTJh6Wx5LBI25G9c7AXanvlBiw5qCy
 Ci9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KKIoAfpAQt+lZvobWVlWyv/tAfJh09WkhRac1CVCCVY=;
 fh=CLFYfATDHPRx1n3+uAjiNodWV92wdolXilZNtQa+KZ4=;
 b=g+NzPidHUyuDjnuMA+4MmxVkQHzJLc7/Jyv5p0iSQ3QbgEvzfDLrKj0E043//1tK1s
 8i2yHyZSw0RZ2fim3TCmnePeV0sJnJXthx3lp7Qafsof6wABSIlvy3mNgJ49ejRGm+sS
 04ovNYFdsCAkbqJlDLz9bAUcUZMg002Dcl6eIfROmwx99GKB9B+WwYaH2+UqThAQT1gE
 TOeAEL3qK1t8yYMS3KRX99BFwSnqx2D/l6LOiKCmObdrwlGcaSx25s+b20L3aeRrnxEF
 mmAV7xchEjV36y1lODfXxUTLetol+yuzLIx4EDDshv3ccPNz1VX0FCkeMCWHXUfcbo69
 V8Rw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793354584; x=1793959384; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KKIoAfpAQt+lZvobWVlWyv/tAfJh09WkhRac1CVCCVY=;
 b=XOjMGlD7fVo+s/rVZ3xpBpOwRuZnqx2/TUcQXE8Q/4v3eZ7ScJ7WFGQJYdKiKErwC0
 Lfuuud9gZt1KN2urH+KyznkqlKir7hnwGY9F8+EDqMVbJthdtGSyRhatoD8whRvfRCr5
 LyUaSFTTnopcoDy9gYpiFLHL1VfcxZJpwy8RQOfBvFJzgW7piADbBOohwNDBYyP0PQv0
 l5msIhKTbiO+PCk0i76J4g+mtjts+q6sq3Ewzp63tO6HZmEudA3K3O0DCV9Js4xaunp3
 gWYCrdu7BEhf1UbGPJLwH9JD0tJDDTBZdSLDhnKwE6m41rx422h3Ts/qf1n0P2lpfpar
 nbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793354584; x=1793959384;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KKIoAfpAQt+lZvobWVlWyv/tAfJh09WkhRac1CVCCVY=;
 b=0jn0P+9T8e/5V4B+K72ugBDWPYsjXbFqZOqBPNw0LW+D9yp6LgQu8YTgBzHwMz6AG2
 uOJgjU7ZOmz1FuSKD2qtAhNSiiESlui52t28QcMHgrAv3pzxM40lmFtW93zV+3y+fKsF
 PsoWmxcYeyhpiLSYRVOt8lLnVyxttVFEndAPEBZBOxI3Yq8hSCM1AMcQVEHEh/7tOTT+
 d/tZZJl49kan8IyyazngOG3AJqOGSFxZanBLwWThdQQgkW9M+49aBHehYNpD4tvEGthF
 cGbhtXNzeOtNvEC92pZhYScxZiNAzmj+FumdkroaelN/7dEyGCoFNEiJJBWhhhivi+zE
 rq7g==
X-Forwarded-Encrypted: i=1;
 AKwUvByB7eyUSA63/g9rl3JgCFZ650lOj/Fq32jxXKokjPNXYXEHGrOruB6TeCm0x8A1mAeto1jVjjqIJVc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKcTs4a8thQOmQwKTyEwEh49PJT8UH83FMt6fkwjID4ITrDT89Z
 CuTrL9ZeDVDdhgRh/lw/SP5art1CLnHfK/981IDKsvTRmavayN4DPaU4DYAVFDToQ9au9ad1SiR
 13Ubjz14geeJZuvTY8hI2eFMPhF5qf/s=
X-Gm-Gg: AYBFou0+VWnpqQnQNcBGGfgpXwiujovoIrZXOlUduhr7WLuVMPZKx/zTcldbkWiVqG0
 W+Czp4G4vi7a4oLhZ6WPOOk0tgb0nyoxt2zhc+ScROWynKtUqr9mpTYIQWbet2XWTDvbMBWCT8L
 Wj7pGfGdUJHLy7POW0kWMa9mXClI3NL5Zi0KVYPXCFqTNeeeEC75Ls4BpcjDPDhTjSXf50fa2Aq
 qSzxhQdHyXYxkkLtBfCZG8aITnrpvktDp/JDFe5VZ0YzVG5vf1CfiOAWXdpS4QGJ+T4N+S14DDf
 0SD4oG8E96BSlzhAowFEtAj/x14rI4vZjHdp54czYqJmjgY2sSkroIVlFjSagrsWrXLCi8upAHj
 j6tJUc4T4cgZN+xM7Dm5UQpGKr3Cv4DWR2YIUR67sIWhmkbT211dDHdRopumnA3YE8WAkTA==
X-Received: by 2002:a05:7300:1897:b0:361:167c:2364 with SMTP id
 5a478bee46e88-36a42362348mr4001559eec.8.1793354583867; Fri, 30 Oct 2026
 03:03:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029152909.234584-1-clamor95@gmail.com>
 <20261029152909.234584-2-clamor95@gmail.com>
 <auRjGM7briuvXDEg@houat>
 <CAPVz0n2=sgbzBfvhGOoRFXeOzKDvs9en7QD0pHc31r5GzgCsKA@mail.gmail.com>
 <auRoaHUqMO4BRQlk@houat>
In-Reply-To: <auRoaHUqMO4BRQlk@houat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 30 Oct 2026 12:02:52 +0200
X-Gm-Features: AclHuK-L_bH3_AEz9gXr-D-fUGtxDSP6rDxMoUG2ElKY1BLDMKdvYmD62gCTKCI
Message-ID: <CAPVz0n3K74CZemDzVVymmjU_5GUGE9FsEKk555-AJfG0jek_hg@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] drm: Add MIPI DBI bus support
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 30 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:5=
1 Maxime Ripard <mripard@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Oct 30, 2026 at 11:42:12AM +0200, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 30 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
11:29 Maxime Ripard <mripard@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, Oct 29, 2026 at 05:28:59PM +0200, Svyatoslav Ryhel wrote:
> > > > From: Mikko Perttunen <mperttunen@nvidia.com>
> > > >
> > > > The MIPI DBI bus allows modeling DBI hosts and peripherals using th=
e Linux
> > > > driver model. DBI hosts are registered by their respective drivers.=
 During
> > > > registration, DBI peripherals are created from the device tree node=
s
> > > > provided by the host.
> > > >
> > > > DBI hosts expose operations that can be used by peripheral drivers =
to
> > > > access associated devices.
> > > >
> > > > The original code was authored by Mikko Perttunen; I have aligned i=
t with
> > > > the existing MIPI DSI implementation.
> > > >
> > > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > >
> > > The SoB situation isn't right here. The author is allegedly Mikko
> > > Perttunen, but you don't have their SoB, and yours isn't there either=
.
> >
> > This is up to Mikko to decide what to do.
>
> Not only, no. When you're sending a patch you must add yours too.
>

> > > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

My CO dev and SoB are both present. Mikko will say their word and I
will update accordingly in v6

> > > Aside from that, which MIPI-DBI type is this supposed to support, and
> > > how do you intend to support Type C panels we already support through
> > > SPI?
> > >
> >
> > MIPI-DBI Type A and B, which have NO support right now.
>
> Then you need to make it much clearer... everywhere :)
>

Ok, noted. DBI Type C support remains as it is, it was not
changed/touched at all.

> Maxime
