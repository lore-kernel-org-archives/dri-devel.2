Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFEBC5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3ABD10E0BD;
	Thu, 13 Aug 2026 20:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="tMwJirrP";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B5910E0BD
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 20:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786654365; x=1787259165; i=deller@gmx.de;
 bh=QTjOG3/s0uieRqtvKL8hfz6KGa4eiv9qXqjKYqRILaI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tMwJirrPefMYYqOAeHDx1Y1DG3UcJqg/2q3DhhZJvKew3gwg4pJc+JB4k+sRY3aV
 YaHEWVM74DrBz3Apcf0eDJWq7wf0kZxVbCqOJhRmGGmJMan6RZYn5mNgirBmHFPo+
 BlKLnDn1mEuWk90HPg0E7bmqBXQjEg4iYQaeAKbyCQyPe1EUDstvmUOAQ+rBgthTc
 VoIS/82Nio3fSjI7WEgv8RLnNl3ipXGtQXOXlnii9ULznOMaMuCFv6+VjhRkbtHQh
 N1YTxEx/bX/ZOt0cJzK3vF2woMNj9or6ONWEnwTlWmOvRXt41rrK7bULGiFR2qOKf
 4VVMphPIWNOAicIQwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72oB-1wmeBu1np9-009Maj; Thu, 13
 Aug 2026 22:52:45 +0200
Message-ID: <00fca3fb-28a8-4f52-b40c-5dd88b8de0d2@gmx.de>
Date: Thu, 13 Aug 2026 22:52:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org
References: <20260809234810.982500-1-rdunlap@infradead.org>
 <81ac11ee-772e-4024-b9e9-6a925344052c@gmx.de>
 <alpine.DEB.2.21.2608131914280.48788@angie.orcam.me.uk>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <alpine.DEB.2.21.2608131914280.48788@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PyvvFHI555Vr1wfz4SXV/btp7DEn89XJOAoYAIOVONrk67MTqG8
 0jCJoBnv/3ctTLYdouO9v6HMwRMVnco3tgMmSi3d121aiFVGXm055RC1NBHu7dydAoL9+tz
 BYG3sorSjmgdoe/rCNRTGafcijz5clC7o7trHBuEkS3owP5WseMZZFslNTjlAsfvclyUbUn
 2Lv6HQEoaj35dUzwt0G/w==
UI-OutboundReport: notjunk:1;M01:P0:jUn5KyozxNc=;F4tkjDBW6u611i1QMoIsk5810nV
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

On 8/13/26 20:16, Maciej W. Rozycki wrote:
> On Thu, 13 Aug 2026, Helge Deller wrote:
>=20
>>> This is all ancient source code from the beginning of git time.
>>> Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.
>>>
>> I've added the various comments from the mail thread to the
>> patch and applied the patch as-is for now.
>=20
>   Given the statement of the problem as per the quotation above I don't
> think there was a need to fast-track it without giving me a chance to
> chime in.
Don't worry. I'm happy to drop the intermediate patch anytime.

Helge
