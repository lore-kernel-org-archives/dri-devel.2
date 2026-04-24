Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF79F589DF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140C810F3E6;
	Fri, 24 Apr 2026 08:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="cCktON0B";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB7410F3E6
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777019962; x=1777624762; i=deller@gmx.de;
 bh=7ISYR8F3K2sFaIG27uwE9ScnE0QQmJa2992ne+W9AoI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cCktON0BMlrqcfSU6WP9FWP2GKbTnGZS4jgVqnhznKbZ0e9mBvAjBJk0pzie9VYF
 TN9Wj5LJLibOeWsJmKUhdKKsOsuvt5x9D+SRAYhiPNfoQ8tOJXd1jKLS1e1ee3py1
 vjC0qqmXl86evjHbfDHH1WNPF0ezECi+fyUYf9T+AgRjuKVECpu1rDZ5V1rB3Gr5H
 yjbcrh6BCazu2AV0r0E1x3P9s/NslrxS88svyttPiRYHpBVU4lKQ2VTX+V5AXhhKE
 CrNBKqYQI3LesPBE8d6UKH0NJDZGoc+GeKA7dTutswjOXOWzb+S1Hvr+jMS7w/Ply
 TgP34UtNGMO4cMc6cQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1vlHEB1dSr-00nnMd; Fri, 24
 Apr 2026 10:39:22 +0200
Message-ID: <5ccb6ea6-37e5-48c9-a6cf-f794edf7a7fd@gmx.de>
Date: Fri, 24 Apr 2026 10:39:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/todo: Drop todo item to request memory regions in all
 fbdev drivers
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260423205531.49971-1-deller@gmx.de>
 <3fe83b69-b868-45a8-9862-50c6f0fdeb95@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <3fe83b69-b868-45a8-9862-50c6f0fdeb95@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iBDlGTwRJDq3wZdw9a9/XrY9Tjl8FWC9nbgyag3Cee370KZNAnY
 bwLrB2D4gFYwzqpMcx9QKpDtlHXhwOJmDE48zPaLLcslHlxWpN5fI5biehPv7DIHgWQy76q
 hD6Q8aYB8C72LF8BnVZm2BoTgeCQT1IN6IpxbToHwMcT90djjRkbSKjW87i1/jMXyvNSM6Z
 wAVUku0Tme77UlJrFUNiQ==
UI-OutboundReport: notjunk:1;M01:P0:JPNB+boJhfE=;ANvminyp6mzP7zZTlnuqI3TbudS
 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
 rPxBoWzf25uA365v9AhK5tZUwB+sHFJTWLP4=
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

On 4/24/26 08:57, Thomas Zimmermann wrote:
> Hi
>=20
> Am 23.04.26 um 22:55 schrieb Helge Deller:
>> This item is tagged for beginners, so often people not familiar with
>> the fbdev drivers think this is an easy task, start up their AI tools
>> and blindly send in the generated code as patches.
>>
>> The problem:
>> - Those patches often introduce bugs, so
>> - ideally want the code tested, since ressource misconfigurations
>> =C2=A0=C2=A0 often lead to failing drivers
>> - The patches are often unnecessary, since in the old machines with the
>> =C2=A0=C2=A0 old graphic cards resource conflicts usually don't happen =
as only one
>> =C2=A0=C2=A0 graphic card can be used at a time anyway.
>> - and today most relevant drivers have necessary patches already
>> =C2=A0=C2=A0 implemented.
>>
>> So, let's get rid of this todo item and silence the steady stream of
>> stupid patches.
>=20
> I see that AI patches can be problematic, but reserving these
> regions is still the correct thing to do. Removing the TODO item
> will not change that.

Sure.
 =20
> Some background on why this item exists: we currently use aperture
> helpers [1] to manage ownership of the framebuffer memory during
> boot up. This is necessary to switch from the system-framebuffer
> driver (i..e, simplefb, simpledrm, etc) to the hardware's native
> driver. But this is all ad-hoc because Linux' resource management
> doesn't do this for us. Before we can integrate any such
> functionality, we have to fix all drivers to reserve their resources
> correctly.
>=20
> If we remove the TODO item, we'd likely still want to move forward
> with improving resource management. If that breaks unfixed fbdev
> drivers, users would then also send bug reports.

Ok for me.

Helge

> And the other point is (again) that if there are no means of testing a d=
river and no information whether a driver is actually in used by anyone, i=
t's maybe time to remove the driver.
>=20
> [1] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/video/apertur=
e.c#L17
>=20
> Best regards
> Thomas
>=20
>=20
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 Documentation/gpu/todo.rst | 16 ----------------
>> =C2=A0 1 file changed, 16 deletions(-)
>>
>> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
>> index bc9f14c8a2ec..b4dd64a8cc06 100644
>> --- a/Documentation/gpu/todo.rst
>> +++ b/Documentation/gpu/todo.rst
>> @@ -448,22 +448,6 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
>> =C2=A0 Level: Intermediate
>> -Request memory regions in all fbdev drivers
>> ---------------------------------------------
>> -
>> -Old/ancient fbdev drivers do not request their memory properly.
>> -Go through these drivers and add code to request the memory regions
>> -that the driver uses. This requires adding calls to request_mem_region=
(),
>> -pci_request_region() or similar functions. Use helpers for managed cle=
anup
>> -where possible. Problematic areas include hardware that has exclusive =
ranges
>> -like VGA. VGA16fb does not request the range as it is expected.
>> -Drivers are pretty bad at doing this and there used to be conflicts am=
ong
>> -DRM and fbdev drivers. Still, it's the correct thing to do.
>> -
>> -Contact: Thomas Zimmermann <tzimmermann@suse.de>
>> -
>> -Level: Starter
>> -
>> =C2=A0 Remove driver dependencies on FB_DEVICE
>> =C2=A0 ---------------------------------------
>=20

