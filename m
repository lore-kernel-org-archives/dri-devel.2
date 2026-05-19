Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFFDCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B41A10E395;
	Tue, 19 May 2026 07:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="tyhvuSRX";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B260210EAD0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779175100; x=1779779900; i=deller@gmx.de;
 bh=WAc5F5rQ0v08hBS8utm1ZidZA72YA0i/KvCxzE80sJ4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tyhvuSRXvU68rRTMQ89b/HLVi42xX+mCOkWQTirwwAdCHXo0gL2EQNKu2ewmuiz6
 8bExiO+ZBfNAAu0adQPIGGOA31NgFFWaXkRZ6EL+99yLtzgCP2eZAxxYyDRUzYLiV
 K75WxEVZ71jsV2kTJ0MbI2SnQjvLdqu5KVjpBGYCrczbyP42aQoUVyQ3gTgKb9CuV
 b01KAo2etqa10mC5aTGCP/PWEoR+znbb+efkr5zS72pR/+I1TyqhBd5wIzBwlscb1
 WU+SpG+NsIXf9RzKHqdAZ9j57KSjxD27p6AvRMJAgARkIfzUszRipaToeXBegq3zo
 OEGnnlZoj2jbL13TuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD2Y-1x3XHK2YTK-00o1sb; Tue, 19
 May 2026 09:18:20 +0200
Message-ID: <05c5ec50-29e4-4419-a8fd-da3395b34dd3@gmx.de>
Date: Tue, 19 May 2026 09:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbcon: Use correct type for vc_resize() return value
To: Jiacheng Yu <yujiacheng3@huawei.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260514091918.1607234-1-yujiacheng3@huawei.com>
 <40ec54e6-78fb-400f-bb10-c277287162fb@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <40ec54e6-78fb-400f-bb10-c277287162fb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IkWgiA11zOuRSmA3KTg8CqEWTv6dyzlj/Tk9fiLhwPfbvyHjsg+
 vaoVK1T//VwId8+8VxAcB/euAMPPGUVpW0JoNKSzMwmvbF02eDhddZhQOhvQK5C8Cvryc/t
 YDCWqJ6nlgD1wE28rPsQod1henargz+8l13AjZ3iGBxYILS0jvzyxQoXY5cOQYwKNeMK330
 kAEUvJri7Dofq9qbt2DJg==
UI-OutboundReport: notjunk:1;M01:P0:Vo7DaN5oxgg=;gvmqlVoGSFNTExfiFoS9rvxQKp9
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

On 5/15/26 09:12, Thomas Zimmermann wrote:
>=20
>=20
> Am 14.05.26 um 11:19 schrieb Jiacheng Yu:
>> The return value of vc_resize() is int, but fbcon_set_disp() stores it
>> in an unsigned long variable. While the !ret check happens to work
>> correctly by coincidence (negative values become large positive values)=
,
>> the types should match. Use int instead.
>>
>> Eliminates the following W=3D3 warning:
>>
>> =C2=A0=C2=A0 drivers/video/fbdev/core/fbcon.c: In function 'fbcon_set_d=
isp':
>> =C2=A0=C2=A0 drivers/video/fbdev/core/fbcon.c:1494:14: warning: implici=
t conversion from 'int' to 'unsigned long' [-Wconversion]
>>
>> Fixes: af0db3c1f898 ("fbdev: Fix vmalloc out-of-bounds write in fast_im=
ageblit")
>> Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

applied to fbdev git tree.

Thanks!
Helge
