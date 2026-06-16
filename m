Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D80CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B3910E691;
	Tue, 16 Jun 2026 02:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XQss+jVY";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CDF410E691
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 02:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCbs2H6iRTPqWZKKQb8eD7gKxDXT2UYbsay3B0O6AUcw8Uv3cyhz9J0/ODm+++hn8JmbNNC2gC5oKT/xvOeOdZgkL445KAud+2CSIlJF673gL2wLs5pmnVLO6zGhJscN4sHbcGseJ8fXgdlY+eQnBevr7SqArlssYbdeZAP6/Xd26STvTHORQdzplBSxV+oXiqhWPMY36KENNvxsu1rwmyAzcsgAMMBo90OCf1LQ7XDBjICB3+d6QrNTSSObTveRlLg/Sse5YhdKhT0r/wigC3r2mv/GN2t9zDlMQIgBzHc30YW5v7qgd8y88aT5gccQ2h/8SgM2pwuCyMwGx9YACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03H3PBygFcqoFozScTzRnwiFp9Or5fN39Nz+8IkM7Yw=;
 b=EVjuh4zWKJa8m+/qWkzJhDTakU3anXwnaVzO78YeoUaV54qxE/2FeyV0dVtes4Hp8d/SZ7vh6KegfkG5WpePy8Em5T5n1KB5Xxhn19XWGN3dJ7K7nw2JjUj+Pzhp3GyClM+mwwNXrK9LzvsVx6Z7/bq49n5YKt/Szmfg8nbbhkyTszMiDdiCUZ+cXPNg+4oYxTPNPl8/3w7f/zN9YclpVfoNCj7Mm9brXO2PMjE0UXAKJ4Wa8YTknCr/AkxtVqk86rIfBCYawwaQn/zlhg5ksCZkw4TjCWPJIr/93SNAYZDxTRWhv0+vucdKJEXm9t4ASg46rRy2SdhQ8m86gEAUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03H3PBygFcqoFozScTzRnwiFp9Or5fN39Nz+8IkM7Yw=;
 b=XQss+jVYoX0anF8QKFs7p8LVl6rf74Azgq2H42y2gyM5RE+FGfSQTeE1u4wI1LaSPK5EpOXqgyeJoh5+qZRq7DsELrMsNkcPBLD8QiBBUdcdCKSvvmRgFTqGYT+KJgvVWm/bqTlEQLe/QYjV5EH39pNlIi3qo/3OA1L1vgazo0BFjANVDGrh1j7j14zjAlosFus7jxOWJCSFGMagIzUtByrUkZ2js+KwWe+NKCzD85W6BZGeiOEWlRGbd4O6taQ1LSWq9QUH36M8K2wfrWKbBF3mQ9VHYw+3hk5NbMQHs9VvCYD1/O9heTJPqj79qKyKYQgNsxpm4Lu6Tp+QD1euQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 02:00:18 +0000
Received: from LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350]) by LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350%7]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 02:00:18 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Conor Dooley <conor@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: display: tegra: Changes to support
 Tegra264
Date: Tue, 16 Jun 2026 11:00:08 +0900
Message-ID: <GQ3BjYo-T_aPQrsd0a_Vtg@nvidia.com>
In-Reply-To: <20260612-iphone-racing-c2f1934f3cf1@spud>
References: <20260612-t264-host1x-v1-0-8d934987de67@nvidia.com>
 <20260612-t264-host1x-v1-1-8d934987de67@nvidia.com>
 <20260612-iphone-racing-c2f1934f3cf1@spud>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OSTPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:604:222::16) To LV3PR12MB9166.namprd12.prod.outlook.com
 (2603:10b6:408:19c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9166:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 576d9501-c90d-4e56-23a8-08decb4b03c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: pzIuToqP9BCQYREQayUnT20LYeY1/szTU2T7NhTVVQFNNCFf7LKxHvwHarYMrOJA+vW1NXqTVZdz8fl1Dt9sQK7B7/EcEaBve0EaATzub0nQWVME/5cLEWKfbIzLWG6XpGYsR5nROl/0Xq7MNgq+r0q+V60u4oBQOAgVWET7j1ndXkt9RPKGjbWWALskPAYAkO8pBuuvtrDK1urDSTsXkMCRBHrqwHI+SjEvxEgCdRZaOu8Enr6332y2DZPxJo5pjzJXAQXPKWtqDRi+e3/kZ81Y8BcCDWckvuEkC7l2ltbR3ZZycOJVI+tTQH8o3QXEVdpY5RGPg+k+vWuzeVmw13b/RUyRoLhSKiH1qjkM6mmk33X2P8OPPNTvLyiwAo0R6K6fZPnyJbXcawyXk+wSh7zZ5GH5Cx881oL6RsrF+PaU/h2pkEKZbJLlccBrnUJlNec+Vbr72RwueCbXJvOoLof9YAeZFYyVouCTR2EX1++KOBFcsoLlS4eqPjax3Gviac/mchviJ+pMaYFFeTcKZr52obhOASY2XGw+l5hdWA15bvDBAwdkByJGNzJ6AmxEOK84iyFNg6VfUtqxtsWmC7b9YNnr/x/SGkZKUlAqZErtwsg8YKAHaBe8gMU6tqA+Pzz+xoUz+YGMa80jKm2RZHjkra22c7DXStodTuMmN5oXOfsxNSirEZbvBWo2uXWk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9166.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkVDa1BnSG9jUUZ4eE84dDhlcEZQOEdlUlVSd1F4TXhtaDZSM25BVVQvcGNi?=
 =?utf-8?B?MTN5dWtNeGRKY2h2STFQNWM1aUdNYnhscGxGUGRxUXpnenB0eEt5Um1kbXNJ?=
 =?utf-8?B?Y3dUZlVCWGY3SHBsYUwvVnJ4UUxqSllHOUUvZjN1Z0xvK2k4Tlo4MDRzdndi?=
 =?utf-8?B?TFpjTXU3ZnlURkVBcTB1Wi9vQ0NtVVZCaVg5WTNBKzJuaEZQN1dvMmNyUEJ0?=
 =?utf-8?B?NTBKcmQvK1J4aTRVck9jOTFiZmNHMWNhQ3pPT0p0emV2WEhqYXkzRTV5NTNu?=
 =?utf-8?B?cGtlVzhPOVZEeGpDZWdadzIyTTN3Y1NpUVU5MktSL1ZiSkgzV01LR1BhN09y?=
 =?utf-8?B?N2ZlUUxPN2IvRzIvck80cXRSWHdVSDVMRXUycHZkeUJQQzRDdDZaOHVYbXYr?=
 =?utf-8?B?eVZRQ05MMDRIQUYyeXJIb3FwV1d2MmEvY0RXVWdCMk5RZlVpZEVCOFV0RkFi?=
 =?utf-8?B?bHd6WEJnaDZqTDEybHBBNzFZcmUrUkNQVWMyWmlUMUFlL293cXdKT1J1YlUr?=
 =?utf-8?B?Rzlpd1c4UkJsdEt3cXJXY1l4d3dMM29tM2tWMzZiTjk5ak5mbSs2Ukk1bHgz?=
 =?utf-8?B?eGxUQmFCNzNpbCt2WGFUeW9qNEllL3Fuc3JhQ2JCZjZMU2hXdVdXRnUxNkQ5?=
 =?utf-8?B?VVlEODNVTHcxQUNMeUkzUi8yWGJrcjZJUmJzSFJ0SEU3K0xXMG5BRTBhSUI3?=
 =?utf-8?B?STNIMCs0NlU5Zm1yeW94QXZIa25CVTJPQUNPZjdCZFVDZlJ5SDhwRVo3bU16?=
 =?utf-8?B?SVQxSVYza2twMmpRczRHc0dhbFU0Rm53R2pNOG9HSlBHNHh1WW43aHdqTUJx?=
 =?utf-8?B?Z21XSmorWkozMEV4Z2laK25KVzcrcFNkSW1IYkVmVHJYWGFNT29sL1JjK3pU?=
 =?utf-8?B?L0JMZVc5aEM4b1pjQW45U3NBMktJd2JDcy91cEpESzc3YkhwWkwveE8zdmV3?=
 =?utf-8?B?NHRkTjRWRTh2dCtxVmFKVXlyeE02MWg5WFdQSlRXZjRNeEpva1lSeUNLKzNt?=
 =?utf-8?B?S3FlbTJ5UG40R05nSlNCMVV6WGhLU0RITEtTckVTVmdOMU9FNmwvelJNUU01?=
 =?utf-8?B?YkpkRm50TnRUbHdBZkV2WmR1R1VTSnc0c05oSUJ1S0p0SGZNS0laOXdSdjhK?=
 =?utf-8?B?R1ZHbXBOUTUyR0RTUW1USUdNQmc4bXg0L3RmYjdVUkRYRU9JeHVWbEdFVU51?=
 =?utf-8?B?cUxKUkdndmE2YjVsWFUrK2srYXo0c1JlNXl6UGNXZzN3TmM1YjJRQkVNMDcv?=
 =?utf-8?B?eitYVTU2bWQ4eWZLdVloZ1RYNDlQRjNXSkNJSFJ2NXZZY3FDWUozajV4cDVB?=
 =?utf-8?B?U0g5bTZUTEdZM3ZWRng5SlErNWd2TTBJZnVkSENIR0FEUzdxUEh5Ui9TTzBO?=
 =?utf-8?B?bHpPbFhsU1NjQ0lZdkxjbVAwU0JjMndKT1B0SVZWUGxjWmZ3Qmpkcy90aVMr?=
 =?utf-8?B?NStRMENJR2NqR2tkRFE4SGZuVGpZTUt3REU0NHh1Wk9SMHcvSTlScVVEWVJp?=
 =?utf-8?B?N0VJb3VCaHZJMWpOZ2lNekYwcDBBTnh5aXNCWTRjNHJDeFFjRkZ2Y1FtNWoy?=
 =?utf-8?B?STdqZUNDcjhFWkFDeFBYMDcvbG9teXFOTnlERG9YVk1qOE8rdXZTUDI1SGxl?=
 =?utf-8?B?NzlIN2REMUlFdlYxdzBSNkQ3L3BRS3VMeHN2UDdLZnV5c2NiRFpOcGdUQ2Zs?=
 =?utf-8?B?VW5zSDB5Q0VhQ0Ztd3FXWFltVXhrY1luZzhTdW1NbzRrSzBBazlkcks4OWJG?=
 =?utf-8?B?YmtnS0F3MGk4cnpTLzdUTEp4MlNpbDk4Q3JtYTlRSDZxdm9GazhsaGNZUXNQ?=
 =?utf-8?B?N1ArTUVuUjNzUEdBNFhYUGRPTWJSZEl4dURTY2IvdEZJSjFjSDZEM1RSSlZa?=
 =?utf-8?B?MzdOWEJtUUMyWkVCMEJxV2M0SDVyVjBSYWNmRDZNYVlJWUFxZFpKZkVnK3lK?=
 =?utf-8?B?Mlg5QXpuS2pPMmlIVnlLODRwUXhST0JOYlpQRXRrVlZwL05leEl0aEp1NlZm?=
 =?utf-8?B?MmRNa2M3VU54Y01SRk9YUG1TWUVVb3pvc2VhVlJTMndRUE00bnZZdGtyVFZL?=
 =?utf-8?B?eTRiV0d1bWRYMTJGcWduQ0VYekxCcTZBZC9POTI5cXBleklwMzd0QWtvbE1S?=
 =?utf-8?B?WHRaUEwraHo5SDVtVzJMckRhODI2NEVZMmlxeWtpMUlyVG5aQTVuQjJtK0Z5?=
 =?utf-8?B?TXJzb01iWS96TnZKblZzZnhMMllQekREOFZEdWFnLzA4aDFNenZFTkN0MnN0?=
 =?utf-8?B?QmliYi9yT2NtQlFpL0krazRGYThEUXJTUURkR0orektzaXlpanlzMFN3OWVJ?=
 =?utf-8?B?RDE4NHRnK2liOUNrejlTdmJYRmxBN2E1Zy96YkxidzduQ0VEem90aXBzcUNG?=
 =?utf-8?Q?YYEwAIlWjvAN+E7r6VCZoiPtl8pZ1OdZqgSdD6oP5hYMC?=
X-MS-Exchange-AntiSpam-MessageData-1: beLpZ/RtxECUDQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576d9501-c90d-4e56-23a8-08decb4b03c7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9166.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 02:00:18.1111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtM2CeIpdFcyL2UiqgXVvadXm7wZ/J7Sk8+297Bk9M2a+bV9TCVmDfs6XBqq2BJXktC4gIe9G1aitCY/VR1tCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
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

On Saturday, June 13, 2026 1:16=E2=80=AFAM Conor Dooley wrote:
> On Fri, Jun 12, 2026 at 03:32:29PM +0900, Mikko Perttunen wrote:
> > Add nvidia,tegra264-host1x compatible string. The Tegra264 host1x is
> > similar to Tegra234, but with a different set of engines and layout.
> >=20
> > The engine register range is no longer continuous, so two range entries
> > are also needed.
>=20
> Please restrict the new ranges of 2 to only the new device.

Thank you, will fix.

Mikko

> pw-bot: changes-requested
>=20
>=20
> Thanks,
> Conor.
>=20
> >=20
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >  .../devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml     |=
 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,teg=
ra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,t=
egra20-host1x.yaml
> > index 3563378a01af..5b0e3158aa5b 100644
> > --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-ho=
st1x.yaml
> > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-ho=
st1x.yaml
> > @@ -25,6 +25,7 @@ properties:
> >            - nvidia,tegra186-host1x
> >            - nvidia,tegra194-host1x
> >            - nvidia,tegra234-host1x
> > +          - nvidia,tegra264-host1x
> > =20
> >        - items:
> >            - const: nvidia,tegra132-host1x
> > @@ -57,7 +58,8 @@ properties:
> >      enum: [1, 2]
> > =20
> >    ranges:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > =20
> >    clocks:
> >      description: Must contain one entry, for the module clock. See
> > @@ -192,6 +194,7 @@ allOf:
> >            contains:
> >              enum:
> >                - nvidia,tegra234-host1x
> > +              - nvidia,tegra264-host1x
> >      then:
> >        properties:
> >          reg-names:
> >=20
> > --=20
> > 2.53.0
> >=20




