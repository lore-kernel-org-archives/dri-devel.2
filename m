Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F68C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A7E10F353;
	Fri, 31 Jul 2026 16:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rPDZqLwS";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA3510F353
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:51:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 39C941A136B;
 Fri, 31 Jul 2026 16:51:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0BA1A6039A;
 Fri, 31 Jul 2026 16:51:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D2CCD11C16B2B; 
 Fri, 31 Jul 2026 18:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1785516704; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xedTpxStbFFiqkuVBdm3XQzkeGVbnwoL+h8tRRtpk8g=;
 b=rPDZqLwSpbk5aGRB9S80Y866TYgGB9qJAye5UNHsH0yENoqTuHx1I6pHw3IsX+cork1XLJ
 AZjpoJ9CAsOFKDWsXnu8YsOK1VlBf6yfhLV+BdWlGd5DEazGZnIDKtNIPvxblHoVmtnTEf
 xpdlR73OAGjtRCdzE+mM29X049TlW8ylgjAW1OZzU9ja8l3qXnPRwPcTdmXvg4+/Uf+09S
 4/KJWrUXYGJoqELhbtXeOS9mmYwfSEoaVcg0/8fgQMTNtXcsSST1Hrn/2pVPUgXEUJXBea
 C7a5drl6vCFhJ2+pmCYRJcUhBQI6MXaQUIY/f3EsXuutvfBP2p1rKLzXf6YKFg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 18:51:37 +0200
Message-Id: <DKCWUF046FIK.LAHQYYO82SF5@bootlin.com>
Subject: Re: [PATCH 10/10] drm/bridge: ti-sn65dsi86: Remove redundant
 dev_err_probe()
Cc: "Pan Chuang" <panchuang@vivo.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "open list:DRM
 DRIVERS" <dri-devel@lists.freedesktop.org>, "open list"
 <linux-kernel@vger.kernel.org>
To: "Doug Anderson" <dianders@chromium.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <20260723131649.134127-1-panchuang@vivo.com>
 <20260723131649.134127-11-panchuang@vivo.com>
 <CAD=FV=WPC92HLyRbo72KK5E9jTQ2TZN9F9gogZk7oNfpat4YRg@mail.gmail.com>
 <CAD=FV=Uud3YA_eQ12SM9MUSLQSmzDY1f_V0HnSCUUXOHSY1aDQ@mail.gmail.com>
 <DKCKLKB5PQRX.5J3QA5DIEMK@bootlin.com>
 <CAD=FV=VELor3eGb0FgtKS5isXw2ARKAb4vJckLcsC20EzA=AZg@mail.gmail.com>
In-Reply-To: <CAD=FV=VELor3eGb0FgtKS5isXw2ARKAb4vJckLcsC20EzA=AZg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Doug,

On Fri Jul 31, 2026 at 4:43 PM CEST, Doug Anderson wrote:
> Hi,
>
> On Fri, Jul 31, 2026 at 12:16=E2=80=AFAM Luca Ceresoli
> <luca.ceresoli@bootlin.com> wrote:
>>
>> Hi Doug,
>>
>> On Thu Jul 30, 2026 at 11:17 PM CEST, Doug Anderson wrote:
>> > Hi,
>> >
>> > On Fri, Jul 24, 2026 at 7:11=E2=80=AFPM Doug Anderson <dianders@chromi=
um.org> wrote:
>> >>
>> >> Hi,
>> >>
>> >> On Thu, Jul 23, 2026 at 6:17=E2=80=AFAM Pan Chuang <panchuang@vivo.co=
m> wrote:
>> >> >
>> >> > Since commit
>> >> > 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_=
irq()"),
>> >> > devm_request_threaded_irq() automatically logs detailed error messa=
ges on
>> >> > failure. Remove the now-redundant driver-specific dev_err_probe() c=
all.
>> >> >
>> >> > Signed-off-by: Pan Chuang <panchuang@vivo.com>
>> >> > ---
>> >> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
>> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> >>
>> >> I'll plan to apply this to drm-misc-next in ~1 week unless anything c=
omes up.
>> >
>> > Pushed to drm-misc-next:
>> >
>> > [10/10] drm/bridge: ti-sn65dsi86: Remove redundant dev_err_probe()
>> >         commit: 9c950822f0fa923ccd344d7a143872d25efe89a3
>>
>> Out of curiosity, did you apply using b4?
>>
>> I see the commit does not have the R-by I gave to the cover letter a few
>> days ago, and assumed b4 would pick it up as it does when applying the f=
ull
>> series. If my assumption was wrong, maybe it's an issue to report to the=
 b4
>> project?
>
> Oops, sorry about that. I actually found your response to the cover
> later as I continued to work through my inbox backlog, but I had
> already pushed the patch. :( I was also surprised that b4 hadn't
> picked it up...

No big deal, I was just curions about the process.

> I applied w/
>
> b4 am -P_ 20260723131649.134127-11-panchuang@vivo.com

I didn't know about '-P_', I normally use a range, such as '-P 1..3' or
just '-P 10'. And, very interestingly, there is a difference:

b4 shazam -P_  20260723131649.134127-11-panchuang@vivo.com -> does not take=
 the R-by from the cover
b4 shazam -P10 20260723131649.134127-11-panchuang@vivo.com -> takes the R-b=
y from the cover

> Running it again still doesn't find your review:
>
> $ b4 am -P_ 20260723131649.134127-11-panchuang@vivo.com
> Grabbing thread from
> lore.kernel.org/all/20260723131649.134127-11-panchuang@vivo.com/t.mbox.gz
> Analyzing 4 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Analyzing 16 code-review messages
> Checking attestation on all messages, may take a moment...
> ---
>   =E2=9C=93 [PATCH 10/10] drm/bridge: ti-sn65dsi86: Remove redundant dev_=
err_probe()
>     =E2=9C=93 Signed: DKIM/vivo.com
>     + Reviewed-by: Douglas Anderson <dianders@chromium.org> (=E2=9C=93
> DKIM/chromium.org)
>   ---
>   NOTE: install patatt for end-to-end signature verification
> ---
> Total patches: 1 (cherrypicked: <20260723131649.134127-11-panchuang@vivo.=
com>)
> ---
>  Link: https://lore.kernel.org/r/20260723131649.134127-11-panchuang@vivo.=
com
>
>
> Ah, if I don't do the "-P_" then it finds your tags, but I don't know
> of a way to pick up just one patch other than that... Even "b4 am -t
> -P_" doesn't find your tags... I guess that's by design?

So, looks like '-P <num>' is the answer. :)

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
