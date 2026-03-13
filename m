Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF36105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE51E10E11F;
	Fri, 13 Mar 2026 12:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="jMJeBcXJ";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D62910E11F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773406255; x=1774011055; i=deller@gmx.de;
 bh=WYTXehAz3Tkprls041O/SdcEBiG3v9f0dVM6LTIyYQE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jMJeBcXJBIVuoNhgFlT86aKFqYPeVsl/BWE6sMnIXmu6tw7m/yYS0+2WGIBCLqyz
 3oSyymi/kWDWSd9H6ZXZNoL6uJkquNYDpiTF3jqvRw0DIhzAzpG26H2VCKwjjeXCJ
 kuhJ8WX+9PLU7G1zFfvlnzsmoiUR/GDGrVVoKxnmDcufu9izyNxCm5mYsxO/2c5qj
 KIzQIgBg/suysNN6vnzsFklxfOTHPD5QTu91DKyKWAM5chmENSJv0q7LKzCfgHKYZ
 th160WW387YCSdlCygUZZzfFJs2Oj+AWsQra88nf2wG50uz5f1Gvspv8wwWFg/xhc
 6a7M9gtDrqH9F6n7GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiaY9-1vNJyi1KLv-00ev9q; Fri, 13
 Mar 2026 13:50:55 +0100
Message-ID: <e9580f2e-19e2-4e82-b041-afe4cf9fb301@gmx.de>
Date: Fri, 13 Mar 2026 13:50:51 +0100
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
 <100ea3bc-d7a2-45c5-982f-5dc5fd27163b@gmx.de>
 <4f06f63c-7ab6-42b7-9789-13c929c64db3@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <4f06f63c-7ab6-42b7-9789-13c929c64db3@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Svfw2ZOE+M4S7YvgVe9ahOafaRzGN9GSbBGYYXgBm1zrGZSxgXw
 u9ECh40W/fHyERxIV+uaDmxhd7go2phY2EVA7oTXimeCE6cCm0DdZ4XXO5L4LrJEfdz9k5I
 3N+UXFkW2zp8fnAueSdtZYvq1DW4bbj6TgOrinTlxfF2r7mszggzU1s6ovSEbo2Il7ewmR/
 6UCNHQqFINKeP9uFTLsFQ==
UI-OutboundReport: notjunk:1;M01:P0:T07y6Qk4kbs=;mXkRjl8JJCNPcrgI6CnA4+PYwcp
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

Hi Thomas,

On 3/13/26 09:05, Thomas Zimmermann wrote:
> Am 12.03.26 um 20:47 schrieb Helge Deller:
>> On 3/12/26 16:10, Thomas Zimmermann wrote:
>>> Am 12.03.26 um 16:04 schrieb Hardik Phalet:
>>>> On Tue Mar 10, 2026 at 6:38 PM IST, Thomas Zimmermann wrote:
>>>>> Hi,
>>>>>
>>>>> thanks for the patch. Let's hope there are no conflicts with other
>>>>> hardware.=C2=A0 IDK if anyone still uses this driver.
>>>> Hi Thomas,
>>>>
>>>> Thanks for reviewing this.
>>>>
>>>> Since I currently do not have access to the hardware needed to test t=
he
>>>> change properly, I will drop this patch for now. I may revisit it onc=
e I
>>>> can validate the behavior on real hardware.
>>>
>>> Good luck. That's the Hercules framebuffer driver. Finding such
>>> ancient hardware that can run modern Linux is nigh impossible.
>>>
>>> But we can merge the patch. If it breaks anyone's setup, they will sen=
d a bug report.
>>>
>>> Helge will pick up the fix if he's ok with it.
>>
>> No, I don't want to merge such patches any longer without any testing
>> on real hardware. There is no actual problem (else someone would have r=
eported),
>> as such I don't see a benefit to apply it. Applying it just brings the =
risk
>> that we break it for someone.
>> So, NAK.
>>
>> I believe I wrote about my opinion already in another patch?
>=20
> Sorry, I wasn't aware.
>=20
>> I think we should rephrase that specific TODO item (which mentions the =
memory
>> region allocation) that only patches which have been tested are accepte=
d.
>=20
> There will likely no one show up here for testing unless it breaks
> there system. Which you won't know until you merge the patch.

No-one likes to merge unnecessary patches which highly potentially
introduce malfunctioning and haven't been tested at all.
 =20
> If only pre-tested patches can go in,

You misunderstand.
I'm still happy to take *any* patches for fbdev.
Even untested ones if they
a) seem necessary (e.g. bugfix), or
b) seem beneficial (code cleanup)
as long as they don't break the driver. This patch may break the driver.

Helge
