Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BA11090221
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C274E10EA00;
	Thu, 19 Mar 2026 12:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="FCnV+XCt";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896A710EA00
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773924275; x=1774529075; i=deller@gmx.de;
 bh=6Rv4e8atV1tnbbfb93sNLYRUwXQEpPAayL7pLJG1oBw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FCnV+XCtlZx0cLB5ZqMIelgn7lVqzyKNGz2f0Hv8af+VYmIZ656IPLSLlGjjoZbT
 PuotRSUSJL1pY4Tbp4saPsaJZohQgkHFAsMa1F64DjeyrR8nfS6zmSKJh7etQFDiD
 29EPXreHc+TTtOxf/3N8rdYVPsvQkcibn6iIW/lOFXkf3HA3SV5TGEeFkVOSXRJPd
 lKdBOaLkFDCYCsicF6MUF5cloEjWX3/dx+kszCbjvWLIBGtMNFYaFOPMTyVirYQi2
 qdqS4XRKUkv29EtV+AwStAdcZJJupJ8yvQZ2AqJEemj2Sxq8Nf+Nj5UpTKGdwBIny
 fLYwCVqx8E3wmCqhYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfNf-1vjSSz1F6d-0187lL; Thu, 19
 Mar 2026 13:44:34 +0100
Message-ID: <f13eab5d-bcf0-49ba-91ac-0903040438be@gmx.de>
Date: Thu, 19 Mar 2026 13:44:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: matroxfb: remove dead code and set but not
 used variable
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jason Yan <yanaijie@huawei.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 b.zolnierkie@samsung.com
References: <20200403021609.20968-1-yanaijie@huawei.com>
 <20200408101852.GC20795@ravnborg.org> <abpX_2PUWie03GdG@black.igk.intel.com>
 <17605e19-065c-4b71-abb2-a9c9a7b9ddc6@huawei.com>
 <abun9dwCYAWd1nIB@ashevche-desk.local>
 <e5f7611f-f087-4835-99e3-4fddc927aab8@huawei.com>
 <abuyJDK6E2aHA4rC@ashevche-desk.local>
 <c717b7b6-ffb6-47f9-b345-de0eddcfe7a4@gmx.de>
 <abu9DKMN660yd3Sd@ashevche-desk.local>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <abu9DKMN660yd3Sd@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rc+ubQ1ChmKHaxyUEJ9kSzqVzIT+vavbJoYSQzwZCf8onNsd5Nr
 b4kTAQky3vA47BlEsXQsq0FP1Yd87fa+XwqavZY3X2RMzGkd+UJO0atYNTPmYfR0s1ux/PK
 tk2bQ/n4uHdr1pgtLHassyOV/58qCmxAjiM8Vd7/VJVcrkqHvCCD3JFzvrwVSkWTVT23yH0
 lDYHvXGXuX8zzFGtImBJw==
UI-OutboundReport: notjunk:1;M01:P0:ktXpEymcdLk=;VLTF1L/qSF8SU6Cr6wT7tm9IUUo
 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
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

On 3/19/26 10:08, Andy Shevchenko wrote:
> On Thu, Mar 19, 2026 at 09:35:33AM +0100, Helge Deller wrote:
>> On 3/19/26 09:21, Andy Shevchenko wrote:
>>> On Thu, Mar 19, 2026 at 04:06:44PM +0800, Jason Yan wrote:
>>>> =E5=9C=A8 2026/3/19 15:38, Andy Shevchenko =E5=86=99=E9=81=93:
>>>>> On Thu, Mar 19, 2026 at 10:22:08AM +0800, Jason Yan wrote:
>=20
> ...
>=20
>>>>> Helge, can we revert this change and start over, please? (I can also=
 send
>>>>> revert if you think it's a better way)
>>
>> Andy, all points you make against removing relevant code is absolutely =
right.
>>
>> But for this specific commit 7b987887f97b ("video: fbdev: matroxfb: rem=
ove dead code and
>> set but not used variable") I have to agree with Jason, that the patch =
is ok.
>> I don't see any build errors either.
>=20
> Just run on today's Linux Next (since the driver has not been changed in=
 that
> sense for a few years, the very same issue is present for a long time):
>=20
> drivers/video/fbdev/matrox/g450_pll.c:412:18: error: variable 'mnp' set =
but not used [-Werror,-Wunused-but-set-variable]
>    412 |                                 unsigned int mnp;
>        |                                              ^
> 1 error generated.

Ok.

 =20
>> Are we mixing up things here maybe?
>=20
> ...
>=20
> FWIW, I dove to the history of the driver.
>=20
> So, the code, that was guarded by #if 0 was introduced in the original c=
ommit
> 213d22146d1f ("[PATCH] (1/3) matroxfb for 2.5.3"). And then guarded in t=
he
> commit 705e41f82988 ("matroxfb DVI updates: Handle DVI output on G450/G5=
50.
> Powerdown unused portions of G450/G550 DAC. Split G450/G550 DAC from old=
er
> DAC1064 handling. Modify PLL setting when both CRTCs use same pixel cloc=
ks.").
>=20
> Even without that guard the modern compilers may see that the pixel_vco =
wasn't
> ever used and seems a leftover after some debug or review made 25 years =
ago.
>=20
> The g450_mnp2vco() doesn't have any IO and as Jason said doesn't seem to=
 have
> any side effects either than some unneeded CPU processing during runtime=
. I
> agree that's unlikely that timeout (or heating up the CPU) has any effec=
t on
> the HW (GPU/display) functionality.
>=20
> So, since the commit 7b987887f97b ("video: fbdev: matroxfb: remove dead =
code
> and set but not used variable") the 'mnp' became unused, but eliminating=
 that
> code might have side-effects. The question here is what should we do wit=
h mnp?
> The easiest way out is just mark it with __maybe_unused which will shut =
the
> compiler up and won't change any possible IO flow.

Yes, I think that's what I'd prefer.
Do you mind sending a patch?

Helge
