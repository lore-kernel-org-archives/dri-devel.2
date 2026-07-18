Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175F9C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 18:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50BB410E32A;
	Sat, 18 Jul 2026 18:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="A6DwuzCO";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60F810E32A
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784398637; x=1785003437; i=deller@gmx.de;
 bh=c0jinHnXDkJCXkgxFa/hlXmn1yh5AUYW9b2j4tfwpSw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=A6DwuzCOMOfp8qa0urXWN9NGc/XGMFoMD6P0f3tO3MRhtRYYOXBxpLEuoAERvjkn
 m3D5AL+jZJFs69vQSv4Y4MgMYCFCdSXQT0aDBmCceVFDaqy7OhlsuWxee4rZd1AHE
 R7e2VGyXZ8rxSUnrul89FY+PlreyDp56hp5jGLtI0dHg7eXeIGX32Wjd+20st6a+X
 xniYdoIyrnvVfw2egBYhfqEWUl+VVPOIttX88PLNsWwLdlGtSMvFNVC3q9t0O260f
 fVTF7L0XW997fUV/e7ylX0D062xZRNPjMrDQ5Qd3ZoUA2bwJS+frhx8x+a6p6irSq
 v9E6SSm7Y5qMpVW66w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1x7pJQ0ShR-0108UN; Sat, 18
 Jul 2026 20:17:17 +0200
Message-ID: <40d5e392-3f99-44c9-b30a-3481f60143ba@gmx.de>
Date: Sat, 18 Jul 2026 20:17:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: arkfb: Move a variable assignment behind a
 condition check in ics5342_init()
To: Markus Elfring <Markus.Elfring@web.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <36d0eba7-e78d-4a06-95bc-c97d9b91f8f0@web.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <36d0eba7-e78d-4a06-95bc-c97d9b91f8f0@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TepeZg0lVctUCGtc6fRbZuWrzyfNg7jW1lMgl49lVwoSz859q/o
 Hx8vMnsGoS0fDaZ8Dx8+STCTeOgxZF4y3FRjoRi6cs1bbhCa4+1KZhzTX0dt5OI5giXkT+h
 Xg3Y1w8W42u2voaJSZgDTBFz9e6xjy2gqwKkGrHu3rkgFV9/c5j09LrJIhF2A8xSQMpD/6+
 A1Q+oFdha+CgWHPvz35+A==
UI-OutboundReport: notjunk:1;M01:P0:/nC24Gr4HuM=;pLMAJ18VoNpnjdgVENeJHhrS5UV
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

On 7/13/26 12:18, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 13 Jul 2026 12:12:52 +0200
>=20
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function =E2=80=9Cics5342_init=E2=80=9D.
>=20
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable =E2=80=9Cinfo=E2=80=9D behind a condition check.
>=20
> This issue was detected by using the Coccinelle software.

There is no "risk" here.
It just adds an offset to a potential NULL value (which isn't then used af=
terwards).

Helge=20
> Fixes: ede481f6dad47d40b7e561cfbc6c04286a9faf1a ("fbdev: arkfb: Cast ics=
5342_init() allocation type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/video/fbdev/arkfb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
> index 195dbf4a5142..9658f407b79a 100644
> --- a/drivers/video/fbdev/arkfb.c
> +++ b/drivers/video/fbdev/arkfb.c
> @@ -432,11 +432,12 @@ static struct dac_ops ics5342_ops =3D {
>   static struct dac_info * ics5342_init(dac_read_regs_t drr, dac_write_r=
egs_t dwr, void *data)
>   {
>   	struct ics5342_info *ics_info =3D kzalloc_obj(struct ics5342_info);
> -	struct dac_info *info =3D &ics_info->dac;
> +	struct dac_info *info;
>  =20
>   	if (!ics_info)
>   		return NULL;
>  =20
> +	info =3D &ics_info->dac;
>   	info->dacops =3D &ics5342_ops;
>   	info->dac_read_regs =3D drr;
>   	info->dac_write_regs =3D dwr;

