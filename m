Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524A4CD98CF
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B75BA10E8E3;
	Tue, 16 Jun 2026 08:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ufW02ZY9";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2690610E8E3
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:28:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0EE334E42F1A;
 Tue, 16 Jun 2026 08:28:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CEC81601A9;
 Tue, 16 Jun 2026 08:28:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CFA09106C9A90; 
 Tue, 16 Jun 2026 10:28:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781598494; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=aaxq/M/Ply1BeAL0um/t7/Wtp1Nk5iB+eJILsXeAgPM=;
 b=ufW02ZY9/n2G9CS0p2r1Ke0nPW5lO7C8vkFPk39GqxJKlHiJBdvi2W3n5nKVVq0Tvyng4T
 9buq65P/tAVUzT3eohWLEBicl4fuG6orL5mysJTOIsoGNWsg1HMsXAiHAYckPCE5KN2WPC
 YLLnSR5VM3VGsUPbTND0uoLCDGUb+6cNckVWA4+5ULK0+ErTdJbdLfQ8FxDA5VVR7Z2Bxz
 qLTo4LGS03Hb0F2O+iZycWE256Cc6mSuQMoM519ACS3N7ivBQX34cG8IgWwgSJ6nv9JvYa
 xD8jTuC3nAu0Vv7QvSP3J40SV/yjALQr/wOCB1Wrk1EZYRIZD9lUwS4rJXpDJw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 10:28:07 +0200
Message-Id: <DJABYEB3V5O9.3N8KN13VZ70B1@bootlin.com>
Subject: Re: [PATCH v4 2/2] drm: bridge: ti-sn65dsi83: Disable video burst
 mode for LVDS stability
Cc: "Sean Nyekjaer" <sean@geanix.com>, "Sudarshan Shetty"
 <tessolveupstream@gmail.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <alexander.stein@ew.tq-group.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Marek
 Vasut" <marex@denx.de>
To: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <ahsxWhXMhzbAj_3G@Seans-MacBook-Pro.local>
 <DJ17SSAYCT51.28YSD262KHNKK@bootlin.com>
 <20260605160946.GC4350@killaraus.ideasonboard.com>
 <DJ19VYINRU7X.MAJ2N3K941SP@bootlin.com>
 <20260605173156.GA108156@killaraus.ideasonboard.com>
In-Reply-To: <20260605173156.GA108156@killaraus.ideasonboard.com>
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

Hello Laurent, Marek,

On Fri Jun 5, 2026 at 7:31 PM CEST, Laurent Pinchart wrote:
> On Fri, Jun 05, 2026 at 06:56:54PM +0200, Luca Ceresoli wrote:
>> On Fri Jun 5, 2026 at 6:09 PM CEST, Laurent Pinchart wrote:
>> > On Fri, Jun 05, 2026 at 05:18:43PM +0200, Luca Ceresoli wrote:
>> >> Hello Sean,
>> >>
>> >> +Cc Marek, Maxime.
>> >>
>> >> On Sat May 30, 2026 at 8:51 PM CEST, Sean Nyekjaer wrote:
>> >> > On Wed, May 27, 2026 at 02:27:36PM +0100, Sudarshan Shetty wrote:
>> >> >> The current DSI configuration enables MIPI_DSI_MODE_VIDEO_BURST.
>> >> >> while burst mode is supported by the hardware, its use
>> >> >> depends on continuous clock behavior from the DSI host. In practic=
e,
>> >> >> burst mode may introduce instability depending on the host control=
ler
>> >> >> implementation, as the DSI link may transition to low-power state
>> >> >> between bursts.
>> >> >>
>> >> >> Testing showed improved display stability when using non-burst mod=
e on
>> >> >> affected panels.
>> >> >>
>> >> >> Remove MIPI_DSI_MODE_VIDEO_BURST and use non-burst video mode.
>> >> >
>> >> > We briefly talked about this at Embedded Recipes
>> >> > I promised to sent a link:
>> >> > https://lore.kernel.org/all/E35054BA-FBE5-4CEE-905C-1F5D20140590@ge=
anix.com/
>> >>
>> >> Thanks for the discussion at ER and for this follow-up e-mail.
>> >>
>> >> > When burst mode is enabled, the LVDS clock gets way to high for my
>> >> > panel. I don't know if it's the DSI controller in the STM32MP1 or
>> >> > something not supported on the TI side.
>> >> >
>> >> > We have been running with this fix for 2 years :)
>> >>
>> >> If I can summarize the situation in the last 4 years:
>> >>
>> >>  * Several users reported the same trouble
>> >>  * Those users patch their kernel out of tree to disable burst mode a=
s a
>> >>    workaround
>> >>  * According to Marek the correct way to make burst mode work is
>> >>    implementing link negotiation
>> >>  * Nobody is willing to implement link negotiation as of now
>> >>
>> >> And this leads me to some questions.
>> >>
>> >>  * Do we want to keep the current situation (everybody beats their he=
ad on
>> >>    the wall until they discover disabling burst mode "fixes" their pa=
nel,
>> >>    and keep an out of tree patch)?
>> >>
>> >>  * Assuming the priority is getting a screen working (and not saving =
power
>> >>    on a black screen), would it make sense to apply this patch, and l=
et
>> >>    people improve in the future by implementing link negotiation?
>> >>
>> >>    Let's pretend for a moment this is a new driver being developed: w=
ould
>> >>    it be OK to have a basic working driver, without some power optimi=
zation
>> >>    features which can be added later on? The only valid answer to thi=
s
>> >>    question is obviously "yes". Doesn't the same principle apply here=
? If
>> >>    it doesn't, why?
>> >>
>> >>  * What is the expected power saving with burst mode?
>> >>
>> >>    I'm afraid I don't have precise numbers but I measured the total b=
oard
>> >>    consumption with or without burst mode (the former with a black sc=
reen
>> >>    but backlight enabled) and found no difference: exactly 12.74 W in=
 both
>> >>    cases.
>> >>
>> >> Thanks for you rpatience in reading this. I hope it helps in finding =
a
>> >> better solution.
>> >
>> > Rephrasing this a bit, is the discussion about dropping support for a
>> > supported feature (burst mode) because users who suffer from the lack =
of
>> > another feature (link negotiation) are not willing to spend time
>> > implementing it,
>>
>> That's the question I have, more or less. I have no answer yet, I'm most=
ly
>> trying to clarify the situation in the first place, for myself and anyon=
e
>> interested.
>>
>> Maybe it's worth pointing out that AFAICU any driver enabling burst mode=
 is
>> buggy because in lack of link negotiation it may work or not, based on p=
ure
>> luck.
>>
>> > and would prefer if users of burst mode were forced to
>> > do the work instead ? That doesn't seem very fair to me.
>>
>> Link negotiation is not just "another feature" w.r.t. burts mode. It's a
>> prerequisite for burst mode to work reliably. So hard-enabling burst mod=
e
>> was building a roof without solid walls (link negotiation).
>>
>> So I'm rephrasing your the question :) as: shouldn't users of burst mode=
 be
>> forced to implement link negotiation, since _they_ need it?
>
> It's quite annoying when both positions have compelling arguments :-)
>
> Has anyone analyzed what work would be needed to implement the link
> negotiation ?

Marek did multiple attempts in the past, I think it's the best analysis
available in public as of now. Following the link provided by Sean Nyekjaer
in this thread on May 30 leads to them:

 * https://lore.kernel.org/dri-devel/20220801131113.182487-1-marex@denx.de/
 * https://lore.kernel.org/all/20220219002844.362157-1-marex@denx.de/

> Dropping burst mode without any plan to support it will be
> demotivating for some people. If asking for link negotiation support to
> support non-burst mode is too much yak shaving, would researching a
> technical plan be an acceptable middleground ?

On my side I haven't gone into the details. But I'm not sure having a plan
would help: Marek had one, but it didn't fly.

Maybe Marek can comment on this?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
