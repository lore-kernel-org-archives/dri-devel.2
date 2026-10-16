Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEE7CCF2C0
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 17:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C237C10E3B2;
	Fri, 16 Oct 2026 17:42:12 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazolkn19013082.outbound.protection.outlook.com
 [52.103.35.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC08B10E388;
 Fri, 16 Oct 2026 17:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjKgBsZQfLjFb7sdxk8+1mxvIL2h9BWAT+0JlEVYjyqF+Og2DYOSSUC6RlY3Yw+lyE/IcRdlzabWsv97hRA4WOqUtjtpI9Z7abRYiX2T8L9NoaWPRC9CNN8M+AKDLPUO96VXGPexSGxUVtzN+mk0CsjlWdpwSCz+aX6mOqzMEgjYWWRDDdjK433+sirCcrHVa+HWTTSgvThcpuRpqXr0OWdirQ9w26g6FA/NrnPRE8Zbnpy5AUHet0B67F2HhAWtJLOWSFseezxxOV5bI+8DhhOzr5f77aleMZNTG30QRoqOZ6R0TqChGepD90XgT2JNCMQxZ/q800+wH+fzwCPXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Evwl+5NQHxk//KyO0zIhrywe0skRjuwPp5+iWl8+vqs=;
 b=aBJ5LoM4583ZzAe/w7Ckou6LN9+OY8rYDcvDZDgW9a2qapNenMfNCMjMMGWyja40P9sxKTNQnZQE9OKbsZ31QGQgT6DIoCescoidnYKtUAIcL8A+N99fAN211eJZUfNGSCHMUiNWTgWlQO3SM8yIcX2QI39+wdXg084x0YsAitLbNUEDWlGyWb+TQ78yDstb2Alqn2vnlbNmpuDr8MYEtY0aWl+jFE+zgWrj950hYfSn1yEg44zAYtvhLYFpU6LtyKNFG7LJ5KU//RHaAtLB6ncBg2XP24ffv/Wx+Q9wVWrl8n9+ZDe7tJjFZAOg75woQkd3YX7LmCNCjZwQMG8pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Evwl+5NQHxk//KyO0zIhrywe0skRjuwPp5+iWl8+vqs=;
 b=FAy5ZWooKhRw2C1+krQoT3j5sydhEknATy9eyD7KrTVGHVCb9OwUlV7GyUORDpq5ncE5Qb9y41YZ28j7wY/lGiLiZLG9BvzLJsK/vVXGIabPt/qtGvLL6ixMDv2GIFR3bkfTp4luVD1IqJyGzKs//+OPFcaPTMLMPR6E4BISPVwOqFRs2hJ+PvbCEULS63oQn3BpBeLZl85q6e7hhVJ/cpDfo2tiW+vfh/+niPqSgZP1/ohpI3IVKvYJi4627YndrOHc4UbIIE8g96HYC2DeNS7YbAPXgxvtk3CLxTv91H9VD/7XsFTwuzGPs9Nw7iOsTRdv0hTfknrYb84DMy9ECQ==
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com (2603:10a6:10:223::18)
 by AS8PR03MB7781.eurprd03.prod.outlook.com (2603:10a6:20b:405::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 17:42:01 +0000
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48]) by DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 17:42:01 +0000
From: Arthur Liberman <arthur_liberman@hotmail.com>
To: Alex Hung <alex.hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>, "sunpeng.li@amd.com"
 <sunpeng.li@amd.com>, "siqueira@igalia.com" <siqueira@igalia.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Subject: Re: [PATCH] drm/amd/display: fix NULL deref when opening a closed DDC
Thread-Topic: [PATCH] drm/amd/display: fix NULL deref when opening a closed DDC
Thread-Index: AQHdVoN3m8ngRWIFC0yB4TViupGfHrcAbKoAgAAOvLQ=
Date: Fri, 16 Oct 2026 17:42:01 +0000
Message-ID: <DB9PR03MB73885E0CE92C33AEC9E31A7E8A9B2@DB9PR03MB7388.eurprd03.prod.outlook.com>
References: <DB9PR03MB73881C96FE86D964037ABEDB8A942@DB9PR03MB7388.eurprd03.prod.outlook.com>
 <38cc515d-ae4b-4031-a061-224d492826e1@amd.com>
In-Reply-To: <38cc515d-ae4b-4031-a061-224d492826e1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR03MB7388:EE_|AS8PR03MB7781:EE_
x-ms-office365-filtering-correlation-id: c2d7c433-8870-4273-a201-08df2bacc8b9
x-microsoft-antispam: BCL:0;
 ARA:14566002|24021099003|8062599012|31061999003|8060799015|12121999013|25010399006|41001999006|19110799012|37011999003|51005399006|15080799012|15030799006|40105399003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?E2mREqKlSSSaCiYJ8FIWNLmo76IZSNcr119lagmAOyJ+A2I1+85OC3Eld6?=
 =?iso-8859-1?Q?qSHFn2KVmRH0D6YIi20r3KvFrTOhjtcNYUeHzuzXMVUxBubg1ay7f5Z3fj?=
 =?iso-8859-1?Q?GZieV/sace4SKzrlTquOX6nfCGYU1BQRp0CP11bPgW9vdudOtNmqdwDj8v?=
 =?iso-8859-1?Q?ZtposKnDp3+AvSRnB/+HGLfw76h8PVREBGuUt0Qb1n8SYIagyNSxvtJDfv?=
 =?iso-8859-1?Q?eXx3iWtupUveA/WhrE7D0CY0Ys9as6GfdI3kbt03rWddg7zhKNbGuUeZFe?=
 =?iso-8859-1?Q?6e0VQuMQgMKj6GmZSDeeaZUkZB6q6sZtH5AaeadLhw2nAHUFuBjIJCeZaD?=
 =?iso-8859-1?Q?iBP83aBtlJcNSyyKmfs64ZnqJ8aoxAqGXbdhJL4lm01HbgnQN3qzQdvNJA?=
 =?iso-8859-1?Q?iJ55ciDomRz0RNgC0kspbLe2vvQZIcT0ZChT/HXd5d5XYtgDatgdc2xYhm?=
 =?iso-8859-1?Q?QBi2VvXbE9OAhfcCN5kI1wc6vmmAPbKelwtIgW1CTX9M3trGNcgz6R63+a?=
 =?iso-8859-1?Q?bu9GWfm2Uk24xKFO/PTqma/OUY8AB5pPN2wgJDij9YNQCRJjZ/Cc5/hf5G?=
 =?iso-8859-1?Q?zlgRkecRgWjCr3t0Ih1yLx1XJwPD5zTf2fPdocNaYXtP1eCTyMT09hJ8Rc?=
 =?iso-8859-1?Q?Bf0og9nNc7vL14cl2PSk/EX5jrCUOxXnYdEYZ7nQNRzQkRMYWnUCzlKy6y?=
 =?iso-8859-1?Q?lOdlp4ujMJsB4i43a4IVUvjypK3UE0q8eZE1b0DwrCeMpGMeB5Xw9PuCdy?=
 =?iso-8859-1?Q?kwoTwlP8+NRSnBoo275LnhgMlsBRQy1Mpcf3EHrDwfmiNpWra+jSWXVHp/?=
 =?iso-8859-1?Q?1DxZZI61f6KVNTsWihluHd7i/Sp//QdmeG9eLtJv5qww32OIHA/7CAKAJI?=
 =?iso-8859-1?Q?Plfe4H+8L8TyhV6J1maVz76zeAdzmFOdnSrWEOz2p9xbBvmw4ti6r/5W6X?=
 =?iso-8859-1?Q?FfDuNxg+WJb7fqDh/B0iQaUHmzlAYF65RmGeQCAxVgvuNObNces4p448tW?=
 =?iso-8859-1?Q?Fg6LH1YUG6Ijc6og9ZzAGcGCPlfP+B3VkYh3r5vAByZCCNG+d3v2/C7mYS?=
 =?iso-8859-1?Q?qsMdUYpdeg2fRXVbvoynDY1iffMCwf3rF5soyks0MFVz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h3a3MpsqbOXqVw11xTz/DgIsYO8JYYs+pm6Wu3OO46vSfpnyQGMEgMIckM?=
 =?iso-8859-1?Q?URP94RGHkfZGphj2iAzNpcbubbFEo5sfEmRm0z9HamBnKwuEVDdArmn+lt?=
 =?iso-8859-1?Q?3x8MbrHhaIV0Pzqz2nfzeJeBXU+Upp1vqx2Dpnc6fFJN/47Buvfiq3+XQV?=
 =?iso-8859-1?Q?Ou+M+x8OSVw/uB3dGsRCVifsmm4AhAr5g5BSt9hVMkErow0clyHXK0imtr?=
 =?iso-8859-1?Q?f7QW4UrdwB4rOrgFi8BRWF95j2cQ6k5/Kep9pe0leEAKv5lVKsszrinrgp?=
 =?iso-8859-1?Q?5vB3HRywe9c1eDPX9GmoM9JusMZxfZbCPAXHWPtHGB8pJt7PvQvI2BvQFx?=
 =?iso-8859-1?Q?/SyT5AfhLLgu6Lt+Vewf+s/OMYfjjmM9uFXBVU4CucCEJ+cyNolpIaG0/h?=
 =?iso-8859-1?Q?RRVobdXZZBQsLA6dvGsw/SyMvFW3DgiKaFPegjbolMuSkP+CfG5Lhz/sTN?=
 =?iso-8859-1?Q?nmM8XzOsnOwBoYtEV62/Dpz8A0FnWxvofGO40kbXcPAC3tJb9SZ6X/AOMS?=
 =?iso-8859-1?Q?LWVRJr0UkpG4K/+0TssKaqNvarcb0oxLhlh5XIZHHXgCbpjTCSwTyXVEiS?=
 =?iso-8859-1?Q?R1Qmqun4ECYQGJ4yI+/1GDIH2tQ50BHDNBi/Gur6vsD3VWsMhlYa//RC+3?=
 =?iso-8859-1?Q?rN9ja4MGaFkphpbO5uONbDJWgCuX9fj9xWP6h6VZmk43RDDvkAB2JsIQHJ?=
 =?iso-8859-1?Q?N1Z7kOlwe2YlyltMMZFGcXEEVNw8GfsMrU52BBWQIcIeBmKGt9rEnlZYnE?=
 =?iso-8859-1?Q?3h+yttZWn156DYad0ZD66hMfmXUBY2rGFeYBniG68P0bw7pPNw8s5L3mJw?=
 =?iso-8859-1?Q?kFjWbYvCNLRbMFueWNE+2RRSpJpmj9lfJ6vgr8cHE4vY1+Vk0n2H5iaJZs?=
 =?iso-8859-1?Q?+yyGbFEIHFAL30niIHjpdTVfZxvf4fhGLaMdiu243W+PVdPYr23ECydtMk?=
 =?iso-8859-1?Q?/Ljswv8lQ8QOXWxmpXjcdJ/CakbyvqiIN5d9uCy5opVJJledMq6PRCVCeN?=
 =?iso-8859-1?Q?DglIJGo9GvisS5kBprxgNhR0Dl+HA6vnvlYc4xSaLD20ek6qj+mTpStp3I?=
 =?iso-8859-1?Q?hRnNqN9gvdB8tZWsYpnIsZPlVwSsqg5OTkOJYGg4IScpZ3pVdoRkvlgUOQ?=
 =?iso-8859-1?Q?6LOqaZtab3WREWACSX/ctTLQAJAwmN43xpkWx4l2QLYaGnWUAIjRObC+YQ?=
 =?iso-8859-1?Q?/S+ThTHna1aR3zzcqUl6zcuXsvlfHaKrt70hJYL1X+Rt/jNC/fBGMfJy5B?=
 =?iso-8859-1?Q?V7NKkSwVbzRBs1qxcDztgjreuXtMJ54KMCD8Z9ePHtHcTtGBazQGO4cGgj?=
 =?iso-8859-1?Q?1flmFpP8j2bTwuGx/3d/1Tbn7OJMvbYOLqKeWunGelvAktXCGTSPtIQ6P7?=
 =?iso-8859-1?Q?oDjcFClZjS4zC/eGvJ9LF7naaOAGSwwZmEEmTkU9OynHyQQrSHrwNPEVMW?=
 =?iso-8859-1?Q?dARqrKN9CSDQ2T2R?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-6-msonline-outlook-24844.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7388.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d7c433-8870-4273-a201-08df2bacc8b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 17:42:01.1742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7781
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

Hi Alex,=0A=
=0A=
I've only had this problem happen once so far, when I turned on my monitor =
after it was off for a day.=0A=
Unfortunately, I don't have a reliable way of reproducing this problem to s=
ee if your proposed patch fixes the issue.=0A=
I'm not sure whether this helps, but here's my setup:=0A=
Ryzen 9 9950X on a X870 board, no dedicated GPU.=0A=
Using the on-board USB-C output in DP alt-mode to connect my Dell UP2516D, =
daisy chaining a second display to it.=0A=
This setup has had a few other amdgpu related issues, for which I submitted=
 patches, they also appear to be additional guards.=0A=
=0A=
- Arthur=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From: Alex Hung <alex.hung@amd.com>=0A=
Sent: Friday, October 16, 2026 7:39 PM=0A=
To: Arthur Liberman; amd-gfx@lists.freedesktop.org=0A=
Cc: dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; harry.we=
ntland@amd.com; sunpeng.li@amd.com; siqueira@igalia.com; alexander.deucher@=
amd.com; christian.koenig@amd.com; airlied@gmail.com; simona@ffwll.ch=0A=
Subject: Re: [PATCH] drm/amd/display: fix NULL deref when opening a closed =
DDC=0A=
=0A=
Hi Arthur,=0A=
=0A=
When AUX already holds the DDC, dal_ddc_open() fails with=0A=
GPIO_RESULT_ALREADY_OPENED, and the HPD path then calls dal_ddc_close()=0A=
on pins it does not own.=0A=
=0A=
Please try whether the following solution fix your KWin issue?=0A=
=0A=
=0A=
diff --git=0A=
drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c=0A=
drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c=0A=
index ad1a499b0d9d..1f53b33fc875 100644=0A=
--- drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c=0A=
+++ drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c=0A=
@@ -2604,8 +2604,6 @@ bool dp_is_sink_present(struct dc_link *link)=0A=
=0A=
        if (dal_ddc_open(ddc, GPIO_MODE_INPUT,=0A=
                         GPIO_DDC_CONFIG_TYPE_MODE_I2C) !=3D GPIO_RESULT_OK=
) {=0A=
-               dal_ddc_close(ddc);=0A=
-=0A=
                return present;=0A=
        }=0A=
=0A=
=0A=
=0A=
On 10/7/26 11:47, Arthur Liberman wrote:=0A=
> dal_ddc_open() uses gpio->pin after dal_gpio_service_open() installs=0A=
> it. Close clears that pointer. HPD sink detection and a KWin atomic=0A=
> check can both open the same DDC: the check reads DPCD for DSC while=0A=
> the HPD worker closes the pin. The load of hw_gpio.store.en then=0A=
> oopses at offset 0x28 and kwin_wayland exits with IRQs disabled.=0A=
>=0A=
> If either pin is gone after open, close what this call holds and=0A=
> return GPIO_RESULT_NULL_HANDLE so the AUX transfer fails instead.=0A=
> This does not serialize the two threads.=0A=
>=0A=
> Cc: stable@vger.kernel.org=0A=
> Assisted-by: Cursor:xai-grok-4.7=0A=
> Signed-off-by: Arthur Liberman <arthur_liberman@hotmail.com>=0A=
> ---=0A=
>   drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 11 +++++++++++=0A=
>   1 file changed, 11 insertions(+)=0A=
>=0A=
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers=
/gpu/drm/amd/display/dc/gpio/gpio_service.c=0A=
> index 95f8b7c7d657..a3145cd82d8b 100644=0A=
> --- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c=0A=
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c=0A=
> @@ -577,6 +577,17 @@ enum gpio_result dal_ddc_open(=0A=
>               goto failure;=0A=
>       }=0A=
>=0A=
> +     /*=0A=
> +      * dal_gpio_service_open() installs gpio->pin, and close clears it.=
=0A=
> +      * MST bring-up can AUX-read for DSC while HPD teardown closes the=
=0A=
> +      * same DDC. pin is NULL again in that window; do not dereference i=
t.=0A=
> +      */=0A=
> +     if (!ddc->pin_data->pin || !ddc->pin_clock->pin) {=0A=
> +             dal_gpio_close(ddc->pin_clock);=0A=
> +             dal_gpio_close(ddc->pin_data);=0A=
> +             return GPIO_RESULT_NULL_HANDLE;=0A=
> +     }=0A=
> +=0A=
>       /* DDC clock and data pins should belong=0A=
>        * to the same DDC block id,=0A=
>        * we use the data pin to set the pad mode. */=0A=
>=0A=
> base-commit: 41505ac433cc4c5179deee8860d197b04f6d1c1d=0A=
=0A=
