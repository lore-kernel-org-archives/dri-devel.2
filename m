Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F89ECD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9860C10F14E;
	Thu, 28 May 2026 13:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BxuRmE4p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 069D610F14C
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:02:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B91E4446DC
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8661F00ACA
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779973362;
 bh=9zBMRM7knJbV+B5IyzIOMW8VBuVs+q0LiO/Usw/gaBw=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=BxuRmE4pOfjvzE4Zz5o9zLilN741qISwWNB9t6fWz4iCJqX3tVV7endadRmESzVtn
 1orlfZqkTg1VmQ+Cukq4RmFJfGuHHCF/zIOcDD1uGc69DR8zfGvWPelYvG9qGFXJEW
 WKYrtPoU14PzR/MQjGFlmDjng67cXVNYxOho6DdZlZLAxUvVzKPuMY0aY/5Saqj3L4
 UAar+++JJdqVTtgmabzmsHSzuPdwnlLOwS4b8V0LEp6XHZwNnhQ5+nmiOdjtlYKuyD
 K4IveBukR1Dst/ahOzodRHbjmNTdZDua3wf9PU8EMmD3Q3yCiaA1plrDhSCxLT03WD
 y8+yiI8l8+4dA==
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5aa2d5a1d51so5809926e87.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 06:02:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/gI0Tpls/3h3JEqoslkc3pwsWBDxv3jX+XyB3i/NgT64ps1Sqzv5+QwPhlg01Z4f0NnKgf+a+6AzI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3yrALGG1K2GyWQu3oDOKfHt4+3TmLxRv9AiLBojSSYAfwLJWY
 4r0R6zoCkBoZqdxPCb6j0EZK/gkPMPqxiqWq+WD0R0a8J3X/yP0nJAI0JNXC4sVPGviw4IB28Mh
 URsbvJZdGpLJeD1bhCs4CXstqoDHYo21YZ+S1Rmbdwg==
X-Received: by 2002:a05:6512:61d8:10b0:5a3:ffed:8443 with SMTP id
 2adb3069b0e04-5aa323bbfd8mr6446301e87.23.1779973361190; Thu, 28 May 2026
 06:02:41 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 09:02:40 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 09:02:40 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <9a0d0e01-adf8-e111-49a0-580239265dbf@linux.intel.com>
MIME-Version: 1.0
References: <20260513-swnode-remove-on-dev-unreg-v6-0-f9c58939df27@oss.qualcomm.com>
 <20260513-swnode-remove-on-dev-unreg-v6-2-f9c58939df27@oss.qualcomm.com>
 <9a0d0e01-adf8-e111-49a0-580239265dbf@linux.intel.com>
Date: Thu, 28 May 2026 09:02:40 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfX+f4OVSsE9gnEccWiX2jccomhdJeMMGbVPcyzTi4SZQ@mail.gmail.com>
X-Gm-Features: AVHnY4JLKSlVBf56eLZQmpAeLQcFReum4FF_eA-wI4Fc7-vVe2WQrN5HmsTNijA
Message-ID: <CAMRc=MfX+f4OVSsE9gnEccWiX2jccomhdJeMMGbVPcyzTi4SZQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] platform/surface: gpe: use
 platform_device_register_full()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, brgl@kernel.org, driver-core@lists.linux.dev, 
 LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, platform-driver-x86@vger.kernel.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
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

On Thu, 28 May 2026 14:35:50 +0200, "Ilpo J=C3=A4rvinen"
<ilpo.jarvinen@linux.intel.com> said:
> On Wed, 13 May 2026, Bartosz Golaszewski wrote:
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
>>  drivers/platform/surface/surface_gpe.c | 36 +++++++++++----------------=
-------
>>  1 file changed, 11 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/s=
urface/surface_gpe.c
>> index b359413903b13c4f8e8b284ef7ae6f6db3f47d72..b8bb47b0d91f036ee5073d21=
534f8f26a4d5ed15 100644
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
>> @@ -305,34 +305,20 @@ static int __init surface_gpe_init(void)
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
>> +		platform_driver_unregister(&surface_gpe_driver);
>> +		return PTR_ERR(pdev);
>>  	}
>>
>> -	pdev->dev.fwnode =3D fwnode;
>> -
>> -	status =3D platform_device_add(pdev);
>> -	if (status)
>> -		goto err_add;
>> -
>>  	surface_gpe_device =3D pdev;
>>  	return 0;
>> -
>> -err_add:
>> -	platform_device_put(pdev);
>> -err_alloc:
>> -	fwnode_remove_software_node(fwnode);
>> -err_node:
>> -	platform_driver_unregister(&surface_gpe_driver);
>> -	return status;
>>  }
>>  module_init(surface_gpe_init);
>
> Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>

Hi!

Thanks but FYI: I will replace this series with a different approach once t=
he
rework of node assignment for platform devices lands upstream.

Bart
