Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38445C4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A8B10E27F;
	Wed, 22 Jul 2026 09:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OlaYlSGG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B67410E27F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:47:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E5FE60A68
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D881F00ACF
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784713641;
 bh=1psssF0EJ6tgCgfE2TXes0fv6UVmjctuTqOJj4nGWvY=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=OlaYlSGGgf3SjX9FtmKK314tNu5zhl9wEVX9vR6t71FECrmQdRnr+RAPXCGpTgYdc
 4+3eVvDBNfnlpgMQlUax2lwdMC4IDIV4k/o7Livq4QflOP/9M3y3w+kXQ1j41iHCTL
 D/CziWm/gj2i7ZWI80Te0xiTyYtGacP3EG4cVxyX0sW0OPp5SOSTd4E8t/nas2QyXR
 Nv7hp45iFsAuv1xr8zojBCS9q15iW6eWXa2t2PQRFGctrh8Psi3f/Qs7Y7mlFhFDXX
 s+7ciqFi6fOjR3D8ae105CgrmLqy2GhsypU/BJfq1FL2muCof0nRxhJu8JKBSlfEjr
 BUaR8mHWklewg==
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-39c7ef2b1e2so108477601fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 02:47:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0lPivLecJh39dZ6ykiL5bLd+vzUOhEfWakBs+cqIjs8GPew+0J2fTsIoHHc7gJJj3bm+dMIcwJo0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxX2xvaO5UR6zTONqNnbiGUYgvFQPt/5dhFGPlLa3UOSgNoiIU4
 SfVQB2axlLMg4pP0EOCJkVOH+YkLsJEyS0MG/TeP2fl/SmSjXMUiEHHcGKIsIDxkHyKRXh47DKA
 GZpOl5xjJL05Z8y+NUifDL9/eHR3pbFxsHnu7edzh5A==
X-Received: by 2002:a05:6512:211:b0:5ae:b9b3:2c0 with SMTP id
 2adb3069b0e04-5b28f9b8c38mr3373315e87.58.1784713639893; Wed, 22 Jul 2026
 02:47:19 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jul 2026 02:47:18 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jul 2026 02:47:18 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <51d2d692-ba40-3035-fac2-a9e8e98e6d99@linux.intel.com>
MIME-Version: 1.0
References: <20260713-swnode-remove-on-dev-unreg-v7-0-6d6bc448427a@oss.qualcomm.com>
 <20260713-swnode-remove-on-dev-unreg-v7-1-6d6bc448427a@oss.qualcomm.com>
 <51d2d692-ba40-3035-fac2-a9e8e98e6d99@linux.intel.com>
Date: Wed, 22 Jul 2026 02:47:18 -0700
X-Gmail-Original-Message-ID: <CAMRc=McoW72iX1GKWJAeVDBV4ft_sqDtcOwhF8XSWyC8agQhWA@mail.gmail.com>
X-Gm-Features: AUfX_myW5j5EC2yrK4hzqs7Ma3O0GUiOq4nsa6hrcCjhD9aYXO8RY8duj-A8ynw
Message-ID: <CAMRc=McoW72iX1GKWJAeVDBV4ft_sqDtcOwhF8XSWyC8agQhWA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] platform/surface: gpe: use
 platform_device_register_full()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 brgl@kernel.org, 
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 driver-core@lists.linux.dev, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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

On Tue, 21 Jul 2026 18:19:42 +0200, "Ilpo J=C3=A4rvinen"
<ilpo.jarvinen@linux.intel.com> said:
> On Mon, 13 Jul 2026, Bartosz Golaszewski wrote:
>
>> Creating a software node for a given set of properties and adding it to
>> a platform device can be achieved with a single call to
>> platform_device_register_full(). There's nothing in this driver that
>> suggests using the more fine-grained interfaces was intentional so
>> switch to using the high-level helper.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com=
>
>> ---
>>  drivers/platform/surface/surface_gpe.c | 39 ++++++++++-----------------=
-------
>>  1 file changed, 11 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/s=
urface/surface_gpe.c
>> index 40896a8544b0a4da4261ea881b1eaed62d93b32b..4ca7ad76f3b9d2b6c455a5d5=
b37f23a85eb69c69 100644
>> --- a/drivers/platform/surface/surface_gpe.c
>> +++ b/drivers/platform/surface/surface_gpe.c
>> @@ -290,9 +290,9 @@ static struct platform_device *surface_gpe_device;
>>
>>  static int __init surface_gpe_init(void)
>>  {
>> +	struct platform_device_info pdevinfo;
>>  	const struct dmi_system_id *match;
>>  	struct platform_device *pdev;
>> -	struct fwnode_handle *fwnode;
>>  	int status;
>>
>>  	match =3D dmi_first_match(dmi_lid_device_table);
>> @@ -305,44 +305,27 @@ static int __init surface_gpe_init(void)
>>  	if (status)
>>  		return status;
>>
>> -	fwnode =3D fwnode_create_software_node(match->driver_data, NULL);
>> -	if (IS_ERR(fwnode)) {
>> -		status =3D PTR_ERR(fwnode);
>> -		goto err_node;
>> -	}
>> -
>> -	pdev =3D platform_device_alloc("surface_gpe", PLATFORM_DEVID_NONE);
>> -	if (!pdev) {
>> -		status =3D -ENOMEM;
>> -		goto err_alloc;
>> +	pdevinfo =3D (struct platform_device_info){
>> +		.name =3D "surface_gpe",
>> +		.id =3D PLATFORM_DEVID_NONE,
>> +		.properties =3D match->driver_data,
>> +	};
>> +
>> +	pdev =3D platform_device_register_full(&pdevinfo);
>> +	if (IS_ERR(pdev)) {
>
> Hi,
>
> Please add an include for this and PTR_ERR().
>
> With the missing include fixed,
>
> Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> Thanks for doing these.
>

Danilo already queued it so I'll send a follow-up once it's in next.

Bartosz
