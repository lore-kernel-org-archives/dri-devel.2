Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA27C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 18:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA0410E5E3;
	Sat, 18 Jul 2026 18:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="NFSNJvxR";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C1A10E5E3
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784401155; x=1785005955; i=deller@gmx.de;
 bh=g8Dc+3KQmljGQaV0yXRzSzJx5AX2kgylrc3XqdlohiM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=NFSNJvxRdnBeR2PbnJFPb4w2wsM1dstE1W8mvwu1mOhH2GI+P+x/NEcjLMHYA+9O
 E/+dlP5qRalfqDY4BBw9u3y76iTxqbdEuosqjQ+t4U/NRbi1FBohNNnKGpOU8Z2TF
 KyYGOVhoe5sr75QFYxoym1KjDL0L8eeaTo01i/eFfyulroE2BeHyQO99pdpEfPlTX
 vhunT4cyvV74HZ1r31ZhQ623S3arsCYWsdJsn6SX4ENrlsMwY0D8csbv9Uup1y3sf
 bQdGdSYTHuS9EuxuxD/4VvIt886dLem/D6oMMTE1WRS5xd1CCvVTXDIGT7EQUPN23
 ESalQMyUfBLVyd+lFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7iCg-1x6Sfp1egk-011VOb; Sat, 18
 Jul 2026 20:59:15 +0200
Message-ID: <73192556-399d-4106-94f4-6df3fb6511ff@gmx.de>
Date: Sat, 18 Jul 2026 20:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: udlfb: validate vendor descriptor items
From: Helge Deller <deller@gmx.de>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Bernie Thompson <bernie@plugable.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260706093038.80131-1-pengpeng@iscas.ac.cn>
 <db0698e3-9f45-4123-8b6d-ff59bcdcf25f@gmx.de>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <db0698e3-9f45-4123-8b6d-ff59bcdcf25f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AO1Zuj1Nn7CEoGbTY7wBfOZej+0XTzQJ4xp4t+k5jSoxOEMQczl
 xQojIkfp6uTCU7U4xKm7fkmlHYc3JV+TWDCvl4yUbJNnq1Eppt/74o09iRuMipA2HdfWfwe
 59jRV8qYgj2FpnlpYIWfcyJ2Mktwe/Ife222OtxnikTl6Edg0N8Pr2XdZt6M0wjQiL6h6Ud
 OCfGGvHRl1nBe90p/FEJQ==
UI-OutboundReport: notjunk:1;M01:P0:Vtmp8JErRTA=;zLFfZ9CLnDe7qdTZ3dGMX/1M5by
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

On 7/18/26 20:26, Helge Deller wrote:
> On 7/6/26 11:30, Pengpeng Hou wrote:
>> dlfb_parse_vendor_descriptor() walks key-length-value items inside the
>> DisplayLink vendor descriptor.
>>
>> Require each item to contain its key, length and declared value bytes
>> before reading item-specific fields such as max_area.
>>
>> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>> ---
>> =C2=A0 drivers/video/fbdev/udlfb.c | 22 ++++++++++++++++------
>> =C2=A0 1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
>> index fdbb8671a810..e78d6f95c9c5 100644
>> --- a/drivers/video/fbdev/udlfb.c
>> +++ b/drivers/video/fbdev/udlfb.c
>> @@ -1586,19 +1586,29 @@ static int dlfb_parse_vendor_descriptor(struct =
dlfb_data *dlfb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc +=3D 5; /* =
the fixed header we've already parsed */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (desc < de=
sc_end) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cha=
r *value;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 u8 length;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 u16 key;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key=
 =3D *desc++;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key=
 |=3D (u16)*desc++ << 8;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(desc_end - desc < sizeof(key) + sizeof(length))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto unrecognized;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key=
 =3D get_unaligned_le16(desc);
>=20
> Is there a reason why you switch to unconditional little-endian reads?
> Is this "vendor descriptor" always little-endian?
> If yes, then your patch is probably correct.
> If not, I think your patch will most likely break big-endian machines.
Please ignore my comments above.
I should have looked more closely.
Your patch is of course correct!

The patch is now added to fbdev git tree.

Thanks!
Helge
