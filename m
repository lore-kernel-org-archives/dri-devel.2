Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71345C531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 01:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A106510E29C;
	Fri, 24 Jul 2026 01:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=mail.ru header.i=@mail.ru header.b="BUSaOruD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="l0aW8sU5";
	dkim-atps=neutral
X-Greylist: delayed 916 seconds by postgrey-1.36 at gabe;
 Fri, 24 Jul 2026 01:41:46 UTC
Received: from send77.i.mail.ru (send77.i.mail.ru [89.221.237.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EF410E29C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 01:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
 :Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:X-Cloud-Ids;
 bh=j+rTBjvvJbBmTAgdLYH8bPZosoB3irkIFNFBNf7jX0A=; t=1784857306; x=1784947306; 
 b=BUSaOruDrCFaRjXnWVh/aOHC0h1XThuv0AAo95SiU5amc5K/lkVZwjGfN+36HMTv4m2Dl8K56Ck
 EmfVVHgq1Kv3A0SOfAsTI445BIFw5D05AASzQZurRkUzAmWeodGQmbDCFZwyA9MAZX+SM7kJgWPFC
 iMC7F6q6IGyWp+YO+pmZtVc+u65meosv/sObr4EduSe7msgKLzu/6mU85N5gRJwNMs6+LgdLINa0v
 cqhuZO8AaNolinoP7pVLSaKz4JfUwM+DuM5Hifke2BG8J5JAN+BuBQv9nzBRpgJBeKAUobjGdFktU
 1Bs3IliVM4dLZjc8Hp4Ue0OxETxknvWMwfcA==;
Received: from [10.112.225.91] (port=36286 helo=send126.i.mail.ru)
 by exim-fallback-5cf4fc9bf6-6664b with esmtp (envelope-from
 <listdansp@mail.ru>)
 id 1wn4gN-00000000JND-2L3b; Fri, 24 Jul 2026 04:26:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Disposition-Notification-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids:
 Disposition-Notification-To; bh=j+rTBjvvJbBmTAgdLYH8bPZosoB3irkIFNFBNf7jX0A=; 
 t=1784856395; x=1784946395; b=l0aW8sU5IIeNbSzV98sfoL0HyJTKLjRh5GDGs5RcPsBLUrF
 PD2/6bGiOfdgub0p8y8RWKmDdd2Lq64i+Mwx+HpAXqIwSQw1ZfdiodPyiEGzh58hPUr0Z8OOY4fDo
 CuGTjAmIr+o1Gw6OQX+m+u6imAQTtr1nZYNXbJbMJwfbaSShCyHWCAq4N5cT2BuiJjVKMdHp1CRL4
 hfExWKzKhORA2Ynz1kiO++MreomuBazSgaPhGDgbYD7mOtrFMrfWver5LOy+fDuzB1tolhc7DwIFP
 znJ7Qb9ksJU6QJDlB90MKkoyRdWRa+V1c83etsb9QN2XXZXxD2Xqi1wVU/EBQfhA==;
Received: by exim-smtp-6c76488b9f-v4n2g with esmtpa (envelope-from
 <listdansp@mail.ru>)
 id 1wn4gE-00000000Cxm-1HGT; Fri, 24 Jul 2026 04:26:26 +0300
Message-ID: <ad3d5028-bd40-4003-859b-104eb12f0292@mail.ru>
Date: Fri, 24 Jul 2026 04:26:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: kyro: Validate overlay viewport coordinates
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260724004245.86764-1-listdansp@mail.ru>
 <20260724005423.86F621F000E9@smtp.kernel.org>
From: listdansp <listdansp@mail.ru>
Content-Language: en-US
In-Reply-To: <20260724005423.86F621F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD93ED3C6BF6FFA701F0B3D367FDA022B560160F5E35392B611182A05F538085040A52A1D80DEFEC40A3DE06ABAFEAF6705ABCD3C3B00A6A8428391D7A76C0DDF7159F445DFCDA6A35E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE720D3C300AFAD2243C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6759CC434672EE6371C2A783ECEC0211ADC4224003CC836476D5A39DEEDB180909611E41BBFE2FEB2B425B3C7DD974D21E5E1F8FF95E2FD3B9ED1E5CAC265509CA534BCE5480F527A50C819B32DFABC24A725E5C173C3A84C3C06EB4A85EF71DCC117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC3A703B70628EAD7BA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD1828451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE1E561CDFBCA1751F1B780A39BCC1DD35D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE386A7C529F68B8E5C302FCEF25BFAB345C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F790063755F431A9070C6492EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A58915208F695EC02C5002B1117B3ED696B41D1B265706B7FB484B8D70797403F6823CB91A9FED034534781492E4B8EEAD0942DC5495D0595EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659BD2DE12799FD87AD81FB97722110473B1737BFF5F8541112407CC042BEC098F3A7FA443BDB71D33AB8341EE9D5BE9A0A8D72C03768569D62BB30523EDBFDB6A99613692593E06B5E8CD93680B12512CF4C41F94D744909CE04437D853D7CD20871FE3B1D98EC473624A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVWmxowtcrDwU1EZWE20ilR4=
X-Mailru-Sender: 4CE1109FD677D277C46683902DBBBB3CD47F6A1C8DA1D5D03DE06ABAFEAF6705ABCD3C3B00A6A842977EED7048DEDC7C8A08967417F2D5E3FB559BB5D741EB96C31AF20DAA089319D7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B486472E5A48B460E48232B7BA1535077BF331AF1FE98FC1A6049FFFDB7839CE9E426FEB9BE7554530CCD57DFE5C6D5DDACBEF06E8C94DC2A399E8AE2CC53E203EF1DB84A0EC7C93B9
X-7FA49CB5: 0D63561A33F958A54B97C676AD7294855002B1117B3ED6969C43858CBE0D4DA4518C0FB0186044C402ED4CEA229C1FA827C277FBC8AE2E8B3A00E10D64C8961C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZS7ynJiCIcBVY/KWOxlKa9g==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok
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

On 24/07/2026 03:54, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing validation for ulHeight == 1 causes a division by zero panic in SetOverlayViewPort.
> --
> 
> --- Patch [1]: [PATCH] video: fbdev: kyro: Validate overlay viewport coordinates ---
> commit eccd0fc9ac01567bf3583eb92ff9c8b899a5e6b3
> Author: Danila Chernetsov <listdansp@mail.ru>
> 
> video: fbdev: kyro: Validate overlay viewport coordinates
> 
> This commit adds coordinate validation in kyro_dev_overlay_viewport_set to
> prevent 32-bit wraparound before passing the values to SetOverlayViewPort.
> It explicitly checks for overflows when adding dimensions and restricts the
> adjusted coordinates to fit into 16-bit register fields.
> 
>> diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
>> --- a/drivers/video/fbdev/kyro/fbdev.c
>> +++ b/drivers/video/fbdev/kyro/fbdev.c
> 
> [ ... ]
> 
>> @@ -378,11 +381,30 @@ static int kyro_dev_overlay_viewport_set(u32 x, u32 y, u32 ulWidth, u32 ulHeight
>>   	    (x < 2 && ulWidth + 2 == 0))
>>   		return -EINVAL;
>>   
>> +	/*
>> +	 * SetOverlayViewPort() adjusts X coordinates by +2 (left) and +1
>> +	 * (right) before packing them into 16-bit register fields.
>> +	 */
>> +	if (x > U16_MAX - 2 || y > U16_MAX)
>> +		return -EINVAL;
>> +
>> +	right = x + ulWidth;
>> +	bottom = y + ulHeight;
>> +
>> +	if (right < x || bottom < y)
>> +		return -EINVAL;
>> +
>> +	right--;
>> +	bottom--;
>> +
>> +	if (right > U16_MAX - 1 || bottom > U16_MAX)
>> +		return -EINVAL;
>> +
> 
> [Severity: High]
> This is a pre-existing issue, but does this validation block still allow a
> divide-by-zero panic if ulHeight is 1?
> 
> If a user passes ySize = 1 via the KYRO_IOCTL_OVERLAY_VIEWPORT_SET ioctl,
> ulHeight will be 1. The code calculates bottom = y + ulHeight, then
> bottom--, which results in bottom == y.
> 
> When these values are passed to SetOverlayViewPort(), it calculates ulDest
> as the difference between the y coordinates (bottom - top). Since they are
> equal, ulDest evaluates to 0:
> 
> drivers/video/fbdev/kyro/STG4000OverlayDevice.c:SetOverlayViewPort() {
>      ...
>      ulDest = srcDest.lDstY2 - srcDest.lDstY1;
>      ...
>      ulFxScale = (ulDest << 11) / ulSrc;
>      ...
>      ulSrcBottom = ulSrcBottom - (ulFxOffset / ulFxScale);
>      ...
> }
> 
> Because ulDest is 0, ulFxScale evaluates to 0. The subsequent division by
> ulFxScale then causes a kernel panic.
> 
> Should ulHeight == 1 be rejected alongside the ulHeight == 0 check earlier
> in kyro_dev_overlay_viewport_set()?
> 

Thanks for the review. The reported division-by-zero issue is pre-existing
in the codebase and is completely unrelated to my changes. This patch does
not introduce, touch, or modify this logic.

I request the maintainers to review my patch as is.

Best regards,
Danila Chernetsov
