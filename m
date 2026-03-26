Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D846010A62D2
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A0010EA06;
	Thu, 26 Mar 2026 13:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ppx1QO75";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090F810EA06
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:49:40 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12736a0147cso75249c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774532979; cv=none;
 d=google.com; s=arc-20240605;
 b=ROKsco/B6YhKwNJyt+KjCbe6IKtf5H+E4uT3gZp0ZXmeNBsubNmtOD0TqndjwUmESB
 cAzunc27y9TJ2aCwer8v3yUyPUlzld1mJ8DmeB2SEEcutH4v9cIXq1jgVqRGENz/GjHh
 yvwM/JaHl8ZoN7gGMJEf9+N7fy2rnkWxt16yJOXiwLULv0gBjwLEC1GwonJ3FQ3M2afI
 BYx4rioMyUBIJQ1IXbmw7GMT06SMFJV9vq7E/aXV4W1HJ+eLW1/Off5nR0s2xMoBkqE6
 g5UYToU7yrrxd93BwDK0Kzh2Xixq53BuJF3JOtrHjd4hyYl57hp7rpVmH0xTAhLCWy/h
 xFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wfUh7bPyGedeXVq0QvRByx2scv8qgWT1+iSxFB0rUCs=;
 fh=SjvOyewxQfdVl5tHoxD2//HNIEVw/45FSpbBnZbELKU=;
 b=JZgDo0Bac8NKYYOKy0qSOkgAke/vS8+QnBBrhu4sll5+diYg9qWZwMvBTbDfVJD+u5
 aWjFHPeoXpCUPtOSybhwQtsIqVVvjAkicfF0CZFn91fDy73Vgu/6kYVFxhE7DYgjufdg
 3oWcaVJ66quBEsfgVCJoKiNvce6RuGQXDy0cJ0vRALl21rv2g/3k/s8Bp3CUBDRvUx+j
 j4u6xZokgWPBbgVLntYedlMXU8/STLUyC5q1AzPluFfVbAjHJOSKkao6NyPkgawyin+R
 K5B9Oc8Bz9iljOCytWRS1Mu5fauL9HS58EeR8pOYso+Nk97BMsVAQgJOuTcIFdEcLPXl
 +J7A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774532979; x=1775137779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfUh7bPyGedeXVq0QvRByx2scv8qgWT1+iSxFB0rUCs=;
 b=ppx1QO75+op0LltnXGxozKLZn/4gCLf0TbdqdXWOdQeMxXqsjZhQ/PhCUM9zDCje80
 3k8BtPyYoDY3YBWE4VezOx6bNAcwdt46C1BMiWuokywaKyShmeqWusniQNIoHv14lGOF
 MY0o8PB8lOGriTUcIcA4/qJGtde9vY1telpX/yVSEGf7P+Ucq4v3GPmbCw15G1BTe5w2
 vGK/yxi6PIf98v1Ovq3uwoBZFBKlNiirNkoI9auT3mkjzruM4gOVp/8RM32LBxiyZuUQ
 mcSIwA1BEvxzbRV9tpTZ5UP14nqNZasZlA6TXoApPVYuRTnZM8IdySA7e2G9MYGCPJtl
 oniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774532979; x=1775137779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wfUh7bPyGedeXVq0QvRByx2scv8qgWT1+iSxFB0rUCs=;
 b=cZPPVRLM9pftN32OnjouNwYgi3riFHOoPkx4fp1HzHk3AcgX0qZy10e2k4J/amu/Tz
 MVLMjApETbMVBuYc09SDyOIXuAchUWxJwz6cgtdRbb4CB/U7Ivl+WRmJDTQhLX0Q3AhS
 eGmhstts2qWoKtH5eJKq612++nxv/qvFJDS5no0Z3o74ws5z/jqoiKTgIz+VkncA+9/l
 2eXsYQ0UfROUf8Px6nSTyGixrBcAdQTm0u6v6O8VxitZ5G3PuoKK/3KBKZsTCo1E9bsd
 izSCrccBLvTAYtBr3+38AqIe9U/Br3S4SpPOlO4GxBsRJLWmEg4D46MwzisahALTbJpF
 NU0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQh08T0FFTASGYdvb5aRtn/+59VartQ1Df7y45rol06NOHOwA7Aarnc+n7tgoFFqji68PKb5/ds3A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQNpLwoIID/9JVKfZGxRemPqVWSH0KCze0v2kq9p15XHTOcejl
 zOEklHY+1+4pvTrqWDJjGBbnX4oYER1PU+K2N6SJfJvdHmSuU5dtmj3fnz0Z3DQeH8IcngxqV0a
 zQW/jRrkdrVPZ8az6EiIFHx+X0cci9So=
X-Gm-Gg: ATEYQzwwu0981Pjj+GqZzn1sFmC0ahBO37zxF2UidT3AGjdqnpcTiVpEWWWH9vvDrTu
 04TAukJp7KtK3Ek5VrasHChKIww4gElrjpUzNM8U0CdvxOZ4kJQsQzrlvlNauETITfHe5XXs1Kq
 eDvK2Li42tAUrrOslZO95NDS9GMKSwoGKokQ0SkFGJynbAxmbavI2VHPtQ9YsPTgDqXynOEUwtD
 RmCCxo3lV3N2iWJWl/F/pKh/8Gvz0Jui2u+INk3inzR6htqtkJXcIIoWcnt5qjzdJSUySBYp58x
 XKdFUYRuLbBVzKDkLQG1mX+ZEcUZgLp9+uCDcaQ3HTIrwvTRGCl5KDNVh9a8LtxhkWlLGg==
X-Received: by 2002:a05:7022:45a3:b0:127:332d:63e with SMTP id
 a92af1059eb24-12a96f05899mr2013237c88.5.1774532979363; Thu, 26 Mar 2026
 06:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260324085130.74534-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260324085130.74534-1-pengpeng@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Mar 2026 09:49:28 -0400
X-Gm-Features: AQROBzBVF-fM23YwoE70eri3RB6hBb-a7AhCMxCBVEJA36gooeuIRUMHibK5jKM
Message-ID: <CADnq5_OnYwP6Y9VMy-_587n+HXKgttVfy2nLVcDfwLuPj=JynQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: bios_parser: fix GPIO I2C line off-by-one
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied.  Thanks!

On Thu, Mar 26, 2026 at 9:18=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> get_gpio_i2c_info() computes the number of GPIO I2C assignment records
> present in the BIOS table and then uses bfI2C_LineMux as an array index
> into header->asGPIO_Info[]. The current check only rejects values
> strictly larger than the record count, so an index equal to count still
> falls through and reaches the fixed table one element past the end.
>
> Reject indices at or above the number of available records before using
> them as an array index.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/=
gpu/drm/amd/display/dc/bios/bios_parser.c
> index 8b3084cc59fd..85c8f5479a52 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -1952,7 +1952,7 @@ static enum bp_result get_gpio_i2c_info(struct bios=
_parser *bp,
>         count =3D (le16_to_cpu(header->sHeader.usStructureSize)
>                         - sizeof(ATOM_COMMON_TABLE_HEADER))
>                                 / sizeof(ATOM_GPIO_I2C_ASSIGMENT);
> -       if (count < record->sucI2cId.bfI2C_LineMux)
> +       if (count <=3D record->sucI2cId.bfI2C_LineMux)
>                 return BP_RESULT_BADBIOSTABLE;
>
>         /* get the GPIO_I2C_INFO */
> --
> 2.50.1 (Apple Git-155)
>
