Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8C6CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E6010E328;
	Tue,  9 Jun 2026 14:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="elLiWARi";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B8010E328
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781014040; x=1781618840; i=deller@gmx.de;
 bh=KpM6icyVFSkvZv0ppMVr8lgT1Qn/7Wj6jGv85PyH8AM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=elLiWARit7t5iqA38CVvZ1EMRgsPSS8MsCAPZtFYH6GYUpVW3uEujHv+AHGSCOp9
 XojlgCY1IXwvDKvIXH7DtlD1+4UgkByajE30do8mOdMLpsgc2XTzuiSn53rmOQf0t
 29Q1YKB4wz4QtBuqfMnFNhrQpCYupQcDUIKg0R52XQpwI/8jvOln1qMUMGaUJUTT3
 kH2N6sXVfT1O3O6rSbMzRjUJ9P2d7rFk1MQzm3uf6cgOi678iTLOCiVobnvDsuD9i
 8AxuXrPbS5mgNyKPIOzclq06i8QeqJaXD0TnIRFvpkqI0vXtq2ZUFXb7Cm+4RAXj3
 aOvm8OlSsS28IzvJmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWici-1wi1st3kSG-00OtSw; Tue, 09
 Jun 2026 16:07:20 +0200
Message-ID: <f4ba11c1-ffe6-43dc-98cd-2f641243c995@gmx.de>
Date: Tue, 9 Jun 2026 16:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drivers/video/fbdev/s3fb: Use strscpy() to copy
 strings into arrays
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>
References: <20260608095523.2606-11-david.laight.linux@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260608095523.2606-11-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iF36Y7UO1Szfsb92mt04obHqDcqTlF8LPP+7/0DgAh47+BrKo9/
 eliIt0cBoiABRj29oFDubd9EEwU/hWpDMiI1kBPAozivBxj1AtSBR/voBLFLpzOMVFvZjFF
 Z2PiuxFbnwZK6Frgez2ZOXuTMwTX5noXEk3W1+IAnxASgOSTQXjw+u3gixcTC0BH5GjOb4D
 fvuT48CNoGVZegX0zD1eg==
UI-OutboundReport: notjunk:1;M01:P0:H/GQQ5sT8Ss=;2u3poEQhoqQAJu1tUhsjEkjmdnG
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

On 6/8/26 11:54, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
>=20
> Replacing strcpy() with strscpy() ensures that overflow of the target
> buffer cannot happen.
>=20
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
>=20
>   drivers/video/fbdev/s3fb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
applied.

Thanks!
Helge
