Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFED9CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 20:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44CD10F07E;
	Wed, 13 May 2026 20:57:02 +0000 (UTC)
Received: from de-smtp-delivery-119.mimecast.com
 (de-smtp-delivery-119.mimecast.com [194.104.109.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C938F10ED5B
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 09:03:03 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022084.outbound.protection.outlook.com
 [52.101.66.84]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-111-QyrqaNLXPR2xkyO-IpUEjg-2; Wed, 13 May 2026 11:03:00 +0200
X-MC-Unique: QyrqaNLXPR2xkyO-IpUEjg-2
X-Mimecast-MFC-AGG-ID: QyrqaNLXPR2xkyO-IpUEjg_1778662978
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10) by VI1PR01MB6893.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:19a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:02:55 +0000
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6]) by PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:02:55 +0000
Date: Wed, 13 May 2026 11:02:52 +0200
From: =?utf-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <bstruempfel@data-modul.com>
To: Marek Vasut <marex@nabladev.com>
CC: Andrzej Hajda <andrzej.hajda@intel.com>, 
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
Subject: Re: [PATCH 2/2] drm/bridge: lt9211: Add drive-strength-microamp DT
 property
Message-ID: <agQ4pVGFEMGaMqgc@DATAMODULBOERGELINUX>
References: <20260512164609.3390700-1-bstruempfel@data-modul.com>
 <20260512164609.3390700-3-bstruempfel@data-modul.com>
 <dff39a7a-a25c-4565-ad20-48026995af11@nabladev.com>
In-Reply-To: <dff39a7a-a25c-4565-ad20-48026995af11@nabladev.com>
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR01MB8486:EE_|VI1PR01MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd87e0f-0318-4ed0-0a49-08deb0ce6ba8
X-LD-Processed: d72fb47f-f4be-4915-91c7-ebd53299157b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|18002099003|56012099003|22082099003
X-Microsoft-Antispam-Message-Info: euDSvUY1Eo3Dg6JQeJ0zFyNakTDwkcrt26L7JH5/i/hDd2H6H0sXDVXzEsvNUhzNH1mDy1LtXJgJmpPVVUmo8hwT17EHaoY1KuZNZQ6ceiC8Hhlz2plfbmlRVywfOAIv3BVDmXBL1Rx8CNSi5FDkDG9Tjiw/OYoZcc6FoBv81PMHiqfUnvb0fsFqdrFpR3aUOUqW3VQ2ydq1UjjwK18gbweIIXZYv4M5rc9GZAAX01C0htW8LT3314Zb47RIVKduvHHjlvrkYkbFXCf/D53p/5S00AygdsTKoHSK9sdZUae3JN9Eb1nIAMCTrSES5bgBsDX+HhapL7xauBTv+GwGHOAmF7OB+ouLU2hgQt2o+h040UaQkN6vVegDdxHbydXRpqPkdjgjFUsqh3FM6xUcIb4t1wr7nNDrNTlLLk89yPtfErSgwyjjCvScUmPFajvh3F97t589U1od+xsnIgVLFjX3r8uKL/77d/sM2WFZprPCYSOVtqVdg+K3ICireHI3n3KS3WEALnkVstfi0lW0xLUF5LUYFyB1uX0TzUZasGoBxk2SBT3UL8W+dnG0P38Kd7xckF5GDVqOoqC2IAE9vE5Zhp2WGvNq4KUpgpvzB4UFNanOoSAcxeNPo0TwyMjlMo+sQZlfjJTX4dAQ7yerW60llDL1ZbJsZB7eLxtqRJxvr/5CJGnYCSUqprU0BzjR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR01MB8486.eurprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REhkVzR6bDUreWtoUlp4OXllR3ZYZXZ4V2RGdXlINUxvRHVvWlVMU1BscjNS?=
 =?utf-8?B?R3VmWGdyTkNBaG9ETTBWQUFVV3d5dDd3Vk5iTzB0V3hIR1dpWExiM3VmOGE5?=
 =?utf-8?B?TUx1UUdWb3czbkRsQWNDanN0ZkhVNStjeEtJOHBpdFlEcGQ3RkRFeDNQVWN1?=
 =?utf-8?B?Ymc3dEYwRkkzQlNWSmZxRGpWNlIzNUQyd0xzekhjR0h1STJzQ1N3TU44S2lu?=
 =?utf-8?B?TElFTVZsS014NUVQOW1pMGZHa0lvK3RUM3k5ZnRRVVM0U2ZjZjlVV25YamNE?=
 =?utf-8?B?Skk4K2p4TnhWTVVJQjlVU2IvdTRtYThXcHlsS2RDaEhsWEIwRE1KRGYyWVg5?=
 =?utf-8?B?MUFXMXFFVkIrdDdOakl0TmZ2NTkwa0FRWVRvcnlrQ28wSktIdTBjS0RxUVoy?=
 =?utf-8?B?blQvb1B4L0g1KzhPT1ZwdGR1Zk05eHlSZDVTMU1zS2pKazg1ZTlTb2cwajIx?=
 =?utf-8?B?SmtVYmN3ZEtEWSt6ai9WVFQ4MHRxdklKMDNhTXBOODNrcTR2K2lYOGZXQUQx?=
 =?utf-8?B?NUNQVUhXZ0VWdURZS3hVL2t3QUpZSGs5dlQ2b0ZTN1RyOUJaY3VQUUFIYVVL?=
 =?utf-8?B?ZStjT2FrOUxzMCtoU29DcDJFaVhYYld6MldYWUZMZjZ0bDRtZnUxRzVJVXp1?=
 =?utf-8?B?SmdZcU1BYUY5N0tjTWZHMWp2US9mVzRiVWpTdVlMZi9Pa3lMMEtoeUZNcFB0?=
 =?utf-8?B?YVByNVZjNmxGVlFWcEl4SFFsVVB1ek05c3VGUDFYUkVSempKQ1hTc0xSR2dE?=
 =?utf-8?B?andvaWJxQVNnRTBYWjdxWGVibW1yS0FLSDZlbUhGRzE2VU94cnF4a09EcnJu?=
 =?utf-8?B?SmNhOSt4ek9EcndLS1dxeVFSZjI4d25wc3hUbVArV3ZJRDhNS1VrSGtTc3Rt?=
 =?utf-8?B?NnZuVU5vT0tZcXdHZmUvREppNHhYUTlvVVB2TUxubWlQRU1FSnBZZDhVbzZi?=
 =?utf-8?B?NGFVM29ReTB3UmRISmFVYThmN3Z4WHBuMVJMZ2ZHS1hxZ3crSDB2NFQwV2ZV?=
 =?utf-8?B?Y1VTRzI5N05pWFFabFVDRGtwWjQrT294UDZzRWxPdUZpZG54SjFmOEQ3ZVFt?=
 =?utf-8?B?WXhsdmYxQWwyVjZoYlQ0U1dZVjlkYTEzOGRMTy9yaDUvWVNrNDRlYXRqQThQ?=
 =?utf-8?B?M2tUbnpUYmMxTGFHZlJmR201RFo2TEdUcU51UlY5Z043NFlCZm4vVy90MmxU?=
 =?utf-8?B?RFlqZCtPS0tqcVhQZDVvVEtpTmYrWlAwVEFtOXdpQ0hyNmVyeGQvaEpmR1JH?=
 =?utf-8?B?YWJSQzJPYUV6bVlpL3hEa2NWcXA1dkxjb0RPWm55K3VEY044WFd6Nm9IN0FX?=
 =?utf-8?B?cHFEVk5MWUh2UjRUQ3Z6MklwRS9PKytSUmR6ZGlwVUVTZUoxNXorbGsycFFz?=
 =?utf-8?B?dndoYkkzd2dlUlM2NUFaVUdkVXUvcWtOVTJYT0hkT3VhVmVLMVlKcVhVZzhv?=
 =?utf-8?B?MmViYmFzTDM0TXY0TjRCbjZndEdiLzNmNmQwVGlpalR5YXBhM1lHUFA2czQ3?=
 =?utf-8?B?bnpWcUM4QkU5d1QrS0I5dFdrTk0xeDREeUdXTnFkL041V3pXdHIvQVNObi9I?=
 =?utf-8?B?RFU1RVU2T1JnSFBGTnp3MmFjRmx4dHZVRlliTmd0WlRPbkFLWlZBb3NrMWVM?=
 =?utf-8?B?OStidStUVkVsbEU1Zk9ZUytOM0N5ZFRnWWptZUtUN0tCNnl1eldvOUZiVVpS?=
 =?utf-8?B?OEkxbDdHbFNnL0h2UXBFNE9kdGxhdjBtOU8yeWZSRVRidGplMXhEREM5b1BL?=
 =?utf-8?B?ZHJWeFlNVmFBSjVDeTNjb0o3V01RYUtBN0t3ZjNBcDRRUEJqalJES3pveUhQ?=
 =?utf-8?B?cjB5cjFza2hwWjVEMHR3eEJTUEgxQVJyOG5rdURwdzZ4TGhtd2RIZ2R2L1RZ?=
 =?utf-8?B?SDdHVVdtSHdSVHNDVlc4YUl0R1M5UnhUUTdMS3V2TnV0OWJ4eUpWWk1OLzla?=
 =?utf-8?B?T3FWczEzVFYvYmFQeTh0YjJpSUpuTWlsU2pUQUltY0dGQlBwVURsdTJ0QVdn?=
 =?utf-8?B?OEdnUW8wajZuSTdTVWd0MmNWQ21YOVJma1VwcGlsTGtDNjNyYWtpc3BaT09S?=
 =?utf-8?B?UVZ2OG9VaEN1QlBpZXY0c3dYNGMxZVJSTDlUYW9TK0p5VnFoTHVRWkRENjNM?=
 =?utf-8?B?akNhQng2Nk8zOWRyaWpaQkZPMjcvV2Q0Vm5kUTB6aXRSakN3NUtSOEkwY09n?=
 =?utf-8?B?eWtTOXVCNzBzS0kzYi8wY0M0bTlUZW53K3lEN3dMRDNtczErdGZpNjJ5Q1Er?=
 =?utf-8?B?MXNjU05IUm96NkVKNTNmSVpndlhJVGh6RFBENkNPQUNDTGNyOG9QSlRDMTdz?=
 =?utf-8?B?V1lkL3o2UnZXcEI3aEVNenlHUUxCUXVLZ2lpQnJKeGJLeXhMTTVnZnpIVVRL?=
 =?utf-8?Q?oynTu2x7WOsA0GwA=3D?=
X-Exchange-RoutingPolicyChecked: jFsntCcj2dV0geWE+unv0wHZOBC+DDInyqzClO/ReYbwwcIKHZ+f4bp6yKAq12BmpT5vfAxX3TEkKb9QL8Izd3/3BCEAYEL/pbWWJPVBgdU6y/bx3U16sueaZcaN/KWXGkPMMQLUDJfrE+gabIpI1xU9D5Zn0EyG7NiyPs/OjWP8sD/kEJaU0O6Rw5mCScriMGGicHsc7XQXeqz005NfruQF1L+uZooemBEsCOmRlFt2PaL4wzuZTFJrWQar77RVbx2Nx3tBS98j/wXEbeI2NoE9KZfhJqz6osDxg7mWvOeZwXBPHgnCp3iX9rQH6KAAOysuldATICWVLp4/956I6g==
X-OriginatorOrg: data-modul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd87e0f-0318-4ed0-0a49-08deb0ce6ba8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB8486.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:02:55.0724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d72fb47f-f4be-4915-91c7-ebd53299157b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKc4FzG8ccEJQaOkA/A1+Qeo7DXieQb4+1gKrbH0KQAf2NUxTGEYaLF5Hbg+KW6+M0nZ9qmpir/l37DWziC/v7DDdZcQa5hYldP5o/FZFX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR01MB6893
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w7R1lXOm358H7vj_m1NzEWi0jubVwBw6BNJWp27eCd0_1778662978
X-Mimecast-Originator: data-modul.com
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 13 May 2026 20:57:01 +0000
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

Hello Marek,

Thank you for your feedback,

On Tue, May 12, 2026 at 08:29:55PM +0200, Marek Vasut wrote:
> On 5/12/26 6:46 PM, Boerge Struempfel wrote:
>=20
> > +/* Maps register value (index) to drive-strength-microamp DT property =
value */
> > +static const u32 lt9211_hsdrv_microamp[] =3D {
>=20
> This can be u8 .
>=20

you are right, I'll change that in the v2.

> > +=0912, 14, 16, 17, 19, 20, 22, 23, 25, 27, 28, 30, 31, 33, 34, 36
> > +};
> > +
> >   struct lt9211 {
> >   =09struct drm_bridge=09=09bridge;
> >   =09struct device=09=09=09*dev;
> > @@ -50,6 +55,7 @@ struct lt9211 {
> >   =09struct regulator=09=09*vccio;
> >   =09bool=09=09=09=09lvds_dual_link;
> >   =09bool=09=09=09=09lvds_dual_link_even_odd_swap;
> > +=09u8=09=09=09=09lvds_hsdrv_isel;
> >   };
> >  =20
> >   static const struct regmap_range lt9211_rw_ranges[] =3D {
> > @@ -374,7 +380,8 @@ static int lt9211_configure_tx(struct lt9211 *ctx, =
bool jeida,
> >   =09=09/* BIT(7) is LVDS dual-port */
> >   =09=09{ 0x823b, 0x38 | (ctx->lvds_dual_link ? BIT(7) : 0) },
> >   =09=09{ 0x823e, 0x92 },
> > -=09=09{ 0x823f, 0x48 },
> > +=09=09/* bits 3:0: RG_MLTX_HSDRV_ISEL, LVDS TX driver current */
> > +=09=09{ 0x823f, 0x40 | ctx->lvds_hsdrv_isel },
> >   =09=09{ 0x8240, 0x31 },
> >   =09=09{ 0x8243, 0x80 },
> >   =09=09{ 0x8244, 0x00 },
> > @@ -629,7 +636,9 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
> >   =09struct device *dev =3D ctx->dev;
> >   =09struct drm_panel *panel;
> >   =09int dual_link;
> > +=09u32 microamp;
> >   =09int ret;
> > +=09int i;
> >  =20
> >   =09ctx->vccio =3D devm_regulator_get(dev, "vccio");
> >   =09if (IS_ERR(ctx->vccio))
> > @@ -666,6 +675,23 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
> >  =20
> >   =09ctx->panel_bridge =3D panel_bridge;
> >  =20
> > +=09ctx->lvds_hsdrv_isel =3D 8; /* default: 25 uA */
> > +=09ret =3D of_property_read_u32(dev->of_node, "drive-strength-microamp=
",
> > +=09=09=09=09   &microamp);
>=20
> if ret !=3D 0 , then what happens here ?
>=20

if ret !=3D 0, we will keep the default value of 8 (corresponding to 25 uA
as written above), which is the behavior that the driver had previously.

According to the documentation, of_property_read_u32() will return 0 on
success, -EINVAL if the property does not exist, -ENODATA if property
does not have a value, and -EOVERFLOW if the property data isn't large
enough. I think we only would need to give a warning or similar if the
-ENODATA or -EOVERFLOW cases. However, I personally do not think that is
necessary, as the usage is specified unambiguously in the devicetree
bindings.

If you feel like we should add a warning in those cases, I can add them
however.

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
> > +=09}
> > +
> >   =09return 0;
> [...]
>=20

--=20
Best regards,
B=C3=B6rge Str=C3=BCmpfel

DATA MODUL AG
Landsberger Str. 322
80687 M=C3=BCnchen

