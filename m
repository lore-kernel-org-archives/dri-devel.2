Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBD7CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 11:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE87810E3B7;
	Thu, 14 May 2026 11:21:00 +0000 (UTC)
Received: from de-smtp-delivery-119.mimecast.com
 (de-smtp-delivery-119.mimecast.com [194.104.109.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D501A10E3B7
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:20:59 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023076.outbound.protection.outlook.com
 [40.107.159.76]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-35-dc69cFQEOzeeDj3fSm1SqQ-2; Thu, 14 May 2026 13:20:57 +0200
X-MC-Unique: dc69cFQEOzeeDj3fSm1SqQ-2
X-Mimecast-MFC-AGG-ID: dc69cFQEOzeeDj3fSm1SqQ_1778757656
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10) by GVXPR01MB10824.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:218::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 11:20:52 +0000
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6]) by PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6%3]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 11:20:52 +0000
Date: Thu, 14 May 2026 13:20:49 +0200
From: =?utf-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <bstruempfel@data-modul.com>
To: Marek Vasut <marex@nabladev.com>
CC: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/bridge: lt9211: Add drive-strength-microamp
 DT property
Message-ID: <agWuyCxPqwZ4ztVF@DATAMODULBOERGELINUX>
References: <20260513133127.376458-1-bstruempfel@data-modul.com>
 <20260513133127.376458-3-bstruempfel@data-modul.com>
 <8bf05bf2-66a3-49e0-972e-4ab7ad9f0ff0@nabladev.com>
In-Reply-To: <8bf05bf2-66a3-49e0-972e-4ab7ad9f0ff0@nabladev.com>
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR01MB8486:EE_|GVXPR01MB10824:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e52489-8478-4f36-6078-08deb1aadbb2
X-LD-Processed: d72fb47f-f4be-4915-91c7-ebd53299157b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|10070799003|56012099003|18002099003|22082099003|4143699003
X-Microsoft-Antispam-Message-Info: ucO1vdI1HltDzP+wTZ89wP9hEkBZdjT/HSos0Wc53pBk9U7u96JufVj5AHGJuoLqM75DKF+keZd8Qa85NM+dbk6I1i0IO7b1ar6UQOL8vbhSyBCfzB5qVMStHDUyesA7khHbRoVIQ5++ns7R6CnIEFDhlS34J9q5GEMlCOY2X/7Z2mOhvhGYrKmuppsNDiI9zRW1QFk9IQGun23z94VGWHayggUvWfHARWSevB40wF/oSN8p3RGkENLDRFd4zo5kufqmfzG1+pIdoYzcR1SLnt36J39D8qGO3taDAQZzr2zZFqQZcmHtdzMeGgW7n3R7eS5G7sLjL2lU4Jx2SDt9s5pr7LBYbfU1WdqAQ/AMahL1o2pZ4ciiNGKYz0e1OGW2J9OV4NNHiLZrqANwiW1rDLWasfq1d9DrGBJiotvE+/UWXbqGks7/c7IdKTMRfH2RkTpC1ozgDIdk4mz3b06QiBRKu7zZ+TU+OwDldGvQRhDRiBbDYvOyZZBAzIU+Y9bQuvr1xm69YnP+dui8rySZ69fUlvcXfQzbXHvqjcFccj4kQr49hpgxcEj+E5o894mcpXc9qQ9vqgzrBQYIwoI22z1cwI/74u6Kq4R7F8MbpT4rBgBow6L5BbNf6UUsRDFW6D7YM2bY4Bt2UXA01ErK5hnkWYCEv428nyJZ2HRrLjpkVnZJ5rhSNKyYlSkDgOwg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR01MB8486.eurprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnNsejlmR3JCK0RBUVJWM3lta3E3TDBlWTc2M01EVXZVT283aWt2dUV2Q0pu?=
 =?utf-8?B?SHlWOXlnQVRMS0oraWlIajloSlIyYUYrTllRQ2F0eHRrUFQ3alRMdWpjbG9k?=
 =?utf-8?B?d0cyZHFsN1dFbk54WDRxbWVmS0UvSkNOKzJIdlp6L09jWHMyWVFweW5zTUlq?=
 =?utf-8?B?c0pZcTZhdVdpOU15bFVzbUpRRURFYnZhMWFYY1M4ZlpYV3o0REJsL0FORFJ0?=
 =?utf-8?B?cmVHSyszN2NCMjZZd3E1QkZCbGRHOEZIWWgyUTlrRi92Qmh2T3dDN2JxV3Vq?=
 =?utf-8?B?WHhuOWhPaTViNW82OGMvMmpZNTB4SkFJZVMyNXoyYW95aTBkQzFPK0ovLytw?=
 =?utf-8?B?NlZqbXhnNEhxMi9XYlljTjUyNVJHZFIwcVBlSFRYSFNOR05yNjFSQUs3VUNK?=
 =?utf-8?B?dWJ4aW82ZjBnV2FVRFA1SHBOeW44VmJzNXJnTlJ1YTB2aVF6d2tHVWJXK0Ey?=
 =?utf-8?B?NTRkZE11eUdwLytkd0VMc1RsQzRZOWIxQ2tnd0FVN0RzVGhqRTllUGV3K3Q5?=
 =?utf-8?B?U09jdHdKU1ljck8vQi9CbU93bWFUNXZHK1lVTFVCQTJqdWRRYjB5MjlwVW0v?=
 =?utf-8?B?Z0lVSTZXZ1RYVU9FRUdhQ3Y3bGtjOHNHRE9TbWRUS2Q5YjQ2OG9FOHlzcE5v?=
 =?utf-8?B?SjJmcVBkbWZxb3N6bTFEZFFBdWZWM3NRTTZmeXpmeTFTOGdRQllrbzlEV0dG?=
 =?utf-8?B?TThUQXQrK1I3YzJqMlNyUVh6YWlMWjRTeTBxb0prRXZRQkJQY3pOYVh6RW9W?=
 =?utf-8?B?M1U0MHVwSHhiT0xOUkJkS2FjLzNGcmhwdTFTdnVBWHF0UmEyVGYzdVlvNkZK?=
 =?utf-8?B?RjdDMHdHN096WU9RWkJEZ3hVcisxb0hSMnZpaWptZWs4RXYyZWRPb3J1d2lh?=
 =?utf-8?B?N3FXTWphTWFPTXRtNFJXbXhMVmFtdkZ4Vjg4ZDYxVUNaYlpVNXhMbjFtRjll?=
 =?utf-8?B?YjVJVG51QldiTHFvSmtIQ1R6clpzRTNJdk9IUUtYZmUxbWIzUVd1OVV5ai9t?=
 =?utf-8?B?NUVEc1VLZ3huQjhRTU5PY25IbUV5SFpCUGJRaFkxUEdqTS9LTXl1ZkFJWVAy?=
 =?utf-8?B?Y3YwaEpSY2NIU21yYWkxMU85c2d1bERpR214VCtJWEVmUEZyRk52ZytPYzFZ?=
 =?utf-8?B?TnNBTWgzNVVGL29yY2VGTC83dmZCVllKc283MWI1dzluWStyQVBPUW9hNFha?=
 =?utf-8?B?d3d4WmZEQWdFcTZydW9qWVRYSVJob085Ym5WL2xySjQ0QVpZUUdGVHR6Y1pY?=
 =?utf-8?B?OHc1cXcycm9IcWtKaWJEY2FJNEg1OWUxdUkxQUJ4Y2EvL2h2KzdQKzRBekRG?=
 =?utf-8?B?cWcxeTV2Ti8wT2pwRVZJK1NGUDA1TFpha1pFR0NKMlpmU2VkNnVjbGtNZHJN?=
 =?utf-8?B?QklRbmpCTEdiSzY4RWkxbDh4bVJ6MVJvMlFHZW9CZUpCYkE4Y0hZc1hjVU8v?=
 =?utf-8?B?UEhQK2FOaGttSWllT2tzNStoRW5Fbm55UDZscEc0RWh2cWppNkNieXAxZjdH?=
 =?utf-8?B?Uy9WS1NpRWRkajVXVlN6Yk8wTjF0ZVQ2OUUvZWxlTC9TMXZyaDBoQXZ4MUk5?=
 =?utf-8?B?eHBxQzE5T0h1RkQ3RGZuaGxCNjdRbjBvRDcvcnZvL01CY3ZOOFFaSUZvRDVD?=
 =?utf-8?B?QktHVTNnUmtkWC9FQzhTRkdWeThndzRXbndLQnNycE8rbUxBak8yYlVCcmh3?=
 =?utf-8?B?RE9wUjluMzFmOERyZmE2cjZFT0xnREt0MzEvNHlxODJCNStDdXpIWWxrRXpZ?=
 =?utf-8?B?YUd4dDVtR005alFFVzFFVkE4ZlptREhhYXZGVjE2bXd5cStPbFUvWVlBSyt2?=
 =?utf-8?B?c0tMVnpqaVZLVnBhTHpwSWUwOU9XSksxRWE2dHNlVkdPRWtiQkM3VU9iL3l3?=
 =?utf-8?B?Y3RWSm1lSnhicVExTUp2UWpnRk02QVdFa2g0OFFEMS9ra29VZFNCYlBYaWFI?=
 =?utf-8?B?Nm9ncE1yMXkrSHNGV05ZRjcwQXl6cFk3S0ZrczNudU5GV0FUbGlOSmZsMXd4?=
 =?utf-8?B?Y2VEQlIwbTA3WlViMWZMZ3J4U2lpVTlZYW90UXVCcnZFWGVEV3ZGa3hpT2JP?=
 =?utf-8?B?cEIvWXJQNVdrRDlUaDUzRFlFWVN3Rnl2VUZSWk8wVVNtbUNuY1Q1aUNPaG1t?=
 =?utf-8?B?cUF3bWI0cHZpY2ozcDFGQnFtQVBQZ2h5Sy9aNEN3UEpyMkM0QWg0WVY2eExV?=
 =?utf-8?B?VVFvT0NYYjNsYk1sdjdSeER4ZHdwQkNaRS9UK0VDR1hEVi9QZ3RHd0xSSy9M?=
 =?utf-8?B?TGN5N29WNTR1ZFVvekZBZjhhdmRSMGNaZ29vUmxBYXR2N2NhbUMvQVVycXdD?=
 =?utf-8?B?aURJWVhBV2FlTVdqbGo2OHorbnZrclV3UnU5YjRDZVpBdFdSdUJqUWQ4bjNx?=
 =?utf-8?Q?RQuqlBll0pZ4U4NgqHKRiIWQiqullgIZKttdL+y+Vukej?=
X-MS-Exchange-AntiSpam-MessageData-1: dBk+/0ATncTgGiDJv3IeQlIzGt8ctaBGrTw=
X-Exchange-RoutingPolicyChecked: TNLxNT2YjdJlwdHpTWLXBSHchFWXcXWlgcBlQOtbOgZMhn1FOTpk0SNT6RHaHq6BWpC42RU89qDaRzicMu96aZ38aX/476rzaTx+kS6KmEABRk1+wpy1oUT0yK5j12dGoU6uaGD2cegV5Tf+cEVdZA6h4Qk4He44+63Gb1cZkv4yttAu2ZFww9VAl/JSYfdgLbdhVK8LIxCYwbJrzVAZ3KNyDPZ0WgiAr8ogiivR4J8nRCef07trWil8Y+rzGmT/Z3UrEO0mNybkqQW9mP1FsUsDNqXxTH9ze4MS69HlvMm4EgqEQic2zqcf+Xo4dAc+wUrlshZKjDxkH4oHxO6PWw==
X-OriginatorOrg: data-modul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e52489-8478-4f36-6078-08deb1aadbb2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB8486.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:20:52.2534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d72fb47f-f4be-4915-91c7-ebd53299157b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iry/lzYAO1FqBPcqkPkeL2Iq5+GpBkSvZV5AnJBeiXy8w1ltA9hk19WcwddGmmE3c0iFdYyjW5QDvrlMwhaIUq4t2u0MwIQBz6xLn50e0OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR01MB10824
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jZiwKHtaUXNIwNs198T-Is86soYjOWHpmlRacAMx8bk_1778757656
X-Mimecast-Originator: data-modul.com
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
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

On Wed, May 13, 2026 at 03:45:43PM +0200, Marek Vasut wrote:
> On 5/13/26 3:31 PM, Boerge Struempfel wrote:
>=20
> [...]
>=20
> > @@ -666,6 +675,26 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
> >  =20
> >   =09ctx->panel_bridge =3D panel_bridge;
> >  =20
> > +=09ctx->lvds_hsdrv_isel =3D 8; /* default: 25 uA */
> > +=09ret =3D of_property_read_u32(dev->of_node, "drive-strength-microamp=
",
> > +=09=09=09=09   &microamp);
>=20
> if (ret && ret !=3D -EINVAL) {
>    ... error handling ...
>    return ret;
> }
>=20
> Then you won't need the if (!ret) conditional and can reduce indent.

Thank you for this suggestion. We will than need to do the lookup even
in case of no value being supplied, but that would make the code
cleaner. Therefore I am changing this in v3.
>=20
> I also wonder whether it wouldn't be better to simply bail with=20
> dev_err_probe() if the property is invalid, let the user know they=20
> should fix their DTs before it is too late.
Ok. I'll change that in v3.
>=20
> > +=09if (!ret) {
> > +=09=09for (i =3D 0; i < ARRAY_SIZE(lt9211_hsdrv_microamp); i++) {
> > +=09=09=09if (lt9211_hsdrv_microamp[i] =3D=3D microamp) {
> > +=09=09=09=09ctx->lvds_hsdrv_isel =3D i;
> > +=09=09=09=09break;
> > +=09=09=09}
> > +=09=09}
> > +=09=09if (i =3D=3D ARRAY_SIZE(lt9211_hsdrv_microamp)) {
> > +=09=09=09dev_err(dev, "Invalid drive-strength-microamp value %u\n",
> > +=09=09=09=09microamp);
> > +=09=09=09return -EINVAL;
> > +=09=09}
>=20
> [...]
>=20
> > +
> >   =09return 0;
> >   }
>=20

--=20
Best regards,
B=C3=B6rge Str=C3=BCmpfel

DATA MODUL AG
Landsberger Str. 322
80687 M=C3=BCnchen

