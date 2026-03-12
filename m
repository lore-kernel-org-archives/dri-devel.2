Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D41106ACE3
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF59E10EAA7;
	Thu, 12 Mar 2026 19:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="X8+TCxoR";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F07A10EAA0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773344830; x=1773949630; i=deller@gmx.de;
 bh=YH+LzWD/PBipu3rXEE382eyHrK4R+ZApTu2WkZepSCY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=X8+TCxoRtWl5wePONnZ6CNLOqqNIjyAw9WH9u8s0yJPuif9aYePM18IIfClPgA4d
 ecaqSzFbpYNIDG4RjmX5MfONaxBCE75d2CZGoIXSGxvi44HC+xeJR4cVQIDJrsJDV
 mozP2K1sKuXRo9HLzVMGFb/aLUDAAHYB0qwbza84dE6Gk9NFqT0LMElfj2za+uUn3
 FSz3ElJv0u0qpDCq5Quvqd092J0gYz4qKPK6ilFFIQfI84+EfatnBIGMzt3tODi0m
 86ITVORG6SY6RuGI5w98R16U/jovx61hK27UUMTxCbZE9FNsA6SyUSrDcV8wM99t0
 BfKf2Fq0VPCJNVUBwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1vwM9817Oi-005bUm; Thu, 12
 Mar 2026 20:47:10 +0100
Message-ID: <100ea3bc-d7a2-45c5-982f-5dc5fd27163b@gmx.de>
Date: Thu, 12 Mar 2026 20:47:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fbdev/hga: Request memory region before ioremap
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Hardik Phalet <hardik.phalet@pm.me>,
 Ferenc Bakonyi <fero@drama.obuda.kando.hu>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>, linux-nvidia@lists.surfsouth.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260310123004.888132-1-hardik.phalet@pm.me>
 <3d58e520-0308-44c7-a43a-e438548e9c40@suse.de>
 <DH0W99FBZJEX.30MPSPJVGV4ZF@pm.me>
 <afd8b00d-42fa-4eb7-b18e-302d3f7cadf7@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <afd8b00d-42fa-4eb7-b18e-302d3f7cadf7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fVSpoStkL6wgi12mYr9r73A35atzKqNLKcIH/2YCXqnrsaJ1GT2
 xf2aX05/tDbN5jvRiAcTLcvt3AJgYAlePCXukayMhjJwaGhlbMaLnGzEzYi3xUPBbKboYKi
 8dIohzJ+JYZuhDgNdrlPX4U8/Umb1r6DffvXcf/uQ7Q4PuTue1R9rcmZ+X0DpMa7CNTTKzu
 O+dxnbvdmaL7+NI+FkKJg==
UI-OutboundReport: notjunk:1;M01:P0:iHviwaFozVM=;07nDJsESbQoXhn+/iH/h0DtgHgG
 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
 13Lgk7D/HpbJJ9CU9ZBx
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

On 3/12/26 16:10, Thomas Zimmermann wrote:
> Am 12.03.26 um 16:04 schrieb Hardik Phalet:
>> On Tue Mar 10, 2026 at 6:38 PM IST, Thomas Zimmermann wrote:
>>> Hi,
>>>
>>> thanks for the patch. Let's hope there are no conflicts with other
>>> hardware.=C2=A0 IDK if anyone still uses this driver.
>> Hi Thomas,
>>
>> Thanks for reviewing this.
>>
>> Since I currently do not have access to the hardware needed to test the
>> change properly, I will drop this patch for now. I may revisit it once =
I
>> can validate the behavior on real hardware.
>=20
> Good luck. That's the Hercules framebuffer driver. Finding such
> ancient hardware that can run modern Linux is nigh impossible.
>=20
> But we can merge the patch. If it breaks anyone's setup, they will send =
a bug report.
>=20
> Helge will pick up the fix if he's ok with it.

No, I don't want to merge such patches any longer without any testing
on real hardware. There is no actual problem (else someone would have repo=
rted),
as such I don't see a benefit to apply it. Applying it just brings the ris=
k
that we break it for someone.
So, NAK.

I believe I wrote about my opinion already in another patch?
I think we should rephrase that specific TODO item (which mentions the mem=
ory
region allocation) that only patches which have been tested are accepted.

Helge
