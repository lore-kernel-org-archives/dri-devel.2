Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE9ACA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 05:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBBEF10E0A9;
	Fri,  2 Oct 2026 05:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DFTp48kS";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDBE810E0A9
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 05:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOwyzIo5PHbfKj1lHpwn4oK7jEsMXqXHHIx0cGGg8W7HsbjFthh/9rt7UGUwWGHezfc11ns5bH2jRfYRkUEtXPvWm0MD2/PWYL+9BDKgCsPFslIxKrLu8J7MLS+aCcR9G7ZsHIknzdm4wRTF6IJWSfTdxKRlr60uT+AQHshIWr04uc+tZDY2Tolm/ahv2G9L5HQQEKGQrW18p+S899pjQR54msseYh0TLe76Qsj+kZwYkxKwR24GasJR0+kQ1P58vuU5rYZvyldq63sIN5QHzW42rGvKu5xzmqgfAn2M+8iiDRRHiLF1hHHKy2jR0QL1CQfyy7d4/RQafXfd2MsfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB5KBxAamQ6zR9xW5Hp/pKjPyPIs1imxHtISJ9ALM7U=;
 b=c++PjLDaMnOwz3UTkmJ0UHM3ocV+z4rGDNm6s3JRwiUjXq6fF0bw9zN686xUFB7/8OaQ3jxnEYBELjWmOG94K5z6ARJtBw0SM7ZMfjYrRFhQhYbRyLBUCsdemgMGH7wwxjh9ilquEMYT6ljnFhl3n1Wuf5KVoc0MkDEPMyd0H5dV+iroA1dknfsDJji6uhw5Q3AqNThaL55bn5k7pRpOTRmAkWvTOplI7XOXx4DuI4uN6RSHpzqQfIsknvL038i3khfO9/svTI/92M9Q2gdueaVvtv6B2FdpoUfQtAekyIU6spE2casUu5hTUToBHri6BfI2mw9ignZP+7XUnv3ghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB5KBxAamQ6zR9xW5Hp/pKjPyPIs1imxHtISJ9ALM7U=;
 b=DFTp48kS7hfHJij31KVCmT8CbKMVqj93977e8x1qSw7ARwYR/fwq0pvr+YZqnAvQKQSp8rIn5EWIOff8v6h0ADNlCRm0kC8S8uW7UnmXo25890KlLjauVYstva6pJDP1vFr6UTZ+pmJtImjoJ1PXDCXQqDMpCtenJ9vwKcY4N8gCXJqw8WiUmIqT799Notgljyfn6PEXbVOlov58OavL9p0zHconAH7M8luyGIVJ2T6fkoeAllBqSjqQzSg6seCCGRCYIIiUPx3S3gFDWUihDN5GMn9+aPbtZ6nzjUKZ4HKeWDFr8fy/CfAnGy7bLo4ETEL27zN96/4/cUUm8YXYZw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.22; Fri, 2 Oct 2026 05:58:16 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 05:58:16 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Date: Fri, 02 Oct 2026 14:58:07 +0900
Message-ID: <eQa8TjBRRm61cRN6L1lZ3Q@nvidia.com>
In-Reply-To: <CAPVz0n2mwC1r+Wsm8j13J-zoZyzjEH2sepsYKVbf847Gqnapgw@mail.gmail.com>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <UJZ22UtaS1GSRPlyAst1og@nvidia.com>
 <CAPVz0n2mwC1r+Wsm8j13J-zoZyzjEH2sepsYKVbf847Gqnapgw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbb346d-dffb-4e3d-d156-08df204a2706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|7416014|10070799003|3023799007|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qQOpCB7bW4Yku5d/2VnIiA1WrebvOC+uKvr8tGHIXjnkAFHfnafyd3X92ak9lnztH+eIakZPfeFGzj7P/IfKF0hWZq/3Lb2A3PnDqH33ryxBXAqwUMbNPLhjvugETXR6PC7ww33/NJ11erNpLVTis9SCpI79frVjrWVzKszbX/o8QPgHGBlGz2P++DnxOjdMCIsVW4efnqCbZup8FhHE990ntQFTcKy/33KR5e6vpcbHYHjNr72npJ3qIVnK1WND1A82piEXYQtyYGTN3VbrPAIiq9jnbIwpaxA3DMDt9/o4aaNAIZadtaaT4CP9Y4GGK6r9keIz+dul+dab/K+GFi94ujwjJG8t0akqExBCuiw1q8ZIxgMaTl2XsFM1DQvxcylhJFItZqbnRQjhshcP0DFk7dqs/zun0KueTI8n5iERycPvP2PaIsPsJSnsF8xTDezRJBIKIxrWM6tetq/oSSrbwBhiu+YtB1Cgbu7tXvcsXT3b0m0+QwR6U2v2Ym6Ug2c0FJLIk/3ZiDLUHaGgtnrHTqKjc8UwmmU0AmKF2UYEIbGmkMdvCTJD9ZLajLwpuOh2VtcHTZxks/7pitcgz0XT2ru4IROTBTz+Hqec5uKV2ExwnC5dRnaMzOl3y/hHsdnww0TK/rYI+19cHO4ek6GSYfveWkSoXZ+0eGA2aYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(7416014)(10070799003)(3023799007)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnZ6VXJoNkpWSGN5bHNuSFJtRFc0eTJacGJEUTVBRlh3RndGbGl2d3YwU0E4?=
 =?utf-8?B?Z09SU0lkQ09sSTk0eUk4c2tTMmxUOU5ER1M2YzFzV2RrY1huSkM5aUc1QTdY?=
 =?utf-8?B?MlRqcVloODRJRk1xUVYyRkRtdmFzY1dRUXNXSjBkWkJ5OTQ4OXFVcTFXRCtC?=
 =?utf-8?B?UVgwd1A1aC8vY0cyL3dXeGFuQ2Q0ZDdnSnFIaVZjWEdrS1BLdTIzcEZWVFVU?=
 =?utf-8?B?VVh4UUpXNzEwblFIa1RxODB6K1pCV2c3S3dycDZxNWl0ZVYyaml1M1RpU2RH?=
 =?utf-8?B?NktSSU9SWTROVUlZNHB0WU05MzV2UDFhdHZIanFEMWRDR1NnN2FpcVNiUUJn?=
 =?utf-8?B?WUg1a1NJdlM4VHlwQXZYbWN1Q2JYUVliMkdMNFFUdGlRc3R3c1lBN2pqUktI?=
 =?utf-8?B?am5kMUxSeHk1VVBEVWFTbEplWWI0c1I2T2g4dDBVenBwbDlvbGRTSXZacVd6?=
 =?utf-8?B?OGNBc3luTTBBREU2R0RaL0FsdFFqbG5jbW5RbFpUcVIyWUl4TWo3TGVLOXdu?=
 =?utf-8?B?QS9sT2JjZEtUQ21BUVdCVWFuRENlWFhxQWZLQlVtQmFhaldlM0ZESXRySjl4?=
 =?utf-8?B?ZllrZDVrWE0wLy85THg1dWViZDN4RHNKdGhjNUp2SG5VTHpvT0Z4YWJtQmdG?=
 =?utf-8?B?RE1IdmY5Sk1QWGN5TFltbzBEMERSSmJFdVd5T012SkJueDNLRmYreU9yelNs?=
 =?utf-8?B?NmlHQlFxR3lZY0dwU0g5SmdvZGE2NTB2cnZTWndYeld5OGxoSUFwM3lCOU1z?=
 =?utf-8?B?dmZrWDJpc1lhalYxZWNXZXg4eGJTY05KdnVxVCs4YXJiWExkNHFSQlVJSGdL?=
 =?utf-8?B?Vjh4Q0ozR0xUb2V2ZE16aWdiOThsSTdEUFlGWkpBcGJodnpLc1JMV2lQZXFw?=
 =?utf-8?B?M01hTkRreXZsaTNsc1kyem9tSlhKOEVGb2kvQjd0cm5Ea2F3WkZaakNObEk4?=
 =?utf-8?B?cDFIcFZzQ3hXd2kyLzk0RGpQdjJLNERLWm1rTTd2NU1rZk05aUJhWFpoUlk0?=
 =?utf-8?B?WVkrZ0RUdENnZm9aOWNtUXRUZGFWa1FGZVVuMFRFMGx0NWY0SHBVeEE5VHN5?=
 =?utf-8?B?VjlkeGxCL01nUlRzVit2bjkxUWpqWXdvV0N6VVhYM0Z6bkJ1QXNmaWlIMXd0?=
 =?utf-8?B?eHpzWlBwcGRZQzArK3ZhTjdSK1crRG9uUFZmcFBmWGZOVENETFJiNVhPVXhP?=
 =?utf-8?B?WkNicXo2T1hXbUQwS2R0VEE1Slkwb0xOSU9ROTllTUV2bUtqZ000aXdJaFNk?=
 =?utf-8?B?UDNiUXJUQ2FMazE5S0FIS1RCcTB0QjVnL20wWnFYUVloQ2N2dWI3UkpJOXdl?=
 =?utf-8?B?cm41TkNBaEljby9FMFdHdU96eHptbHlTdTlLeGl5T1lLR0hNaGJuNmhOZHl5?=
 =?utf-8?B?b29xN0NSZEhGZmJ4SnIzVUxnRHhZUS9kTG1nOTh1WkVEY0NuV3BwM1RtMEta?=
 =?utf-8?B?Wm05N01qQmhsS1lqNHdWVmlUdVhGSXhHbE9XZXJmcE5RbTM2SU40Z0g4V0ZX?=
 =?utf-8?B?RlBkOVRPTS9rYWdFeVZTYWFZQ3lmWndETCszSTJnSXFHdkUvZGJ4YWpGbXRl?=
 =?utf-8?B?WHI3akV0a3hlWU13M1BCc2VpUUZEMmxySnZlaWtLVnJ2OUEzczVjV2RBQ0VQ?=
 =?utf-8?B?R25YeFNZV0RuRE1nblJrckN3aDBWWEF5bC9WVTMzM2kzSzdnSmx1TlhuY0Nz?=
 =?utf-8?B?Q1lHUEpQSzNaUjBubU94N013VkdHYXRBem8wK0lFQ3dGR3FqRHpnQ2lOL0hw?=
 =?utf-8?B?c2lFTENxRmZGVllvOTJSSjlhbWhza2hlQ25WK0FBakZIOVdWRXpHMVFjeHpy?=
 =?utf-8?B?MVJTT3ZTeDZ5YVNMSVVweFN5U2JkQ09MN25pMVRtSEdiaTZCbVltVmFWUTlT?=
 =?utf-8?B?SGY2UkYyK1pTdERnb09jY1o0QVQ3dHZmY0tINnRDajFTT21TcUJ1TGJFdGVB?=
 =?utf-8?B?dEVqaU5NaTRjckloZXJrK1VtaGpQRy9IcU9kR3RlUXNnckZ3RHUvZXJMT09n?=
 =?utf-8?B?NjM1Y1dBSGMvRHhlUkVRR2FKQU9RTEpmcm5JcTZaTzFBMVEraEplNUc2N0FO?=
 =?utf-8?B?bUdzRnlRZ0p5Z3VycFR0cmRKSXlKWVhkenROMG93eE1pV2tDQms0ckdYYm1Q?=
 =?utf-8?B?dDhtWVVuR2lTa1dCa3l6K3ovWUlQZGxTYnI3MFRlSlBYTXhlMWViR2lsZ3Qv?=
 =?utf-8?B?OWUwcUxnMGlYUkl3dDRsNnhtNEdxa3hGRlBNTUFMczlueVgyVzdrZlZnOFN3?=
 =?utf-8?B?VHNHRGRlYTBlSnpNSWpoYk1OMXg4R29sTUM2bEhyU0cvUHZWNlNjOHhWVnli?=
 =?utf-8?B?ZFgvMG5NYVlSa3hCb3VPYzlmWjQvRkp0d3NRNXpWRzkxazRYOVpSRGZuMFVy?=
 =?utf-8?Q?8WfsnahVlmSwcrDyo5XUjfXPQqxpIapsQ8g2NNqcbPa13?=
X-MS-Exchange-AntiSpam-MessageData-1: tU2usQjfUqZ0Hg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbb346d-dffb-4e3d-d156-08df204a2706
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 05:58:16.7105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5fMeviREp/FT3RAQravlNN1EjoGasVH6xIHZgcjwxsnIkqGP6SEkdDI1xNgq0jsAUif25sBSf+Xx+fcVdAxXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
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

On Thursday, October 1, 2026 3:03=E2=80=AFAM Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12:19 Mi=
kko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wednesday, September 30, 2026 4:05=E2=80=AFPM Svyatoslav Ryhel wrote=
:
> > > Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> > > Tegra20/30 SoCs display controller.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++++++=
++
> > >  1 file changed, 138 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/tegra/n=
vidia,tegra-8bit-cpu.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,t=
egra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia=
,tegra-8bit-cpu.yaml
> > > new file mode 100644
> > > index 0000000000000..f0dab608b2936
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8b=
it-cpu.yaml
> > > @@ -0,0 +1,138 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-8bit-c=
pu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +description: The display controller in Tegra20/30 SoCs features an
> > > +  8-bit SPI interface that closely resembles the MIPI DBI Type B
> > > +  protocol and is referred to as '8-bit CPU'. Each display controlle=
r
> > > +  provides two such interfaces, which can be used to send MIPI DCS
> > > +  commands to initialize and control the panel while image data is
> > > +  transmitted via 16/18/24-line RGB.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: nvidia,tegra-8bit-cpu
> > > +
> > > +  dc-gpios:
> > > +    description: Data/command selection pin.
> > > +    maxItems: 1
> > > +
> > > +  rw-gpios:
> > > +    description: Read/write pin.
> > > +    maxItems: 1
> > > +
> > > +  cs-gpios:
> > > +    description: Chip select pin.
> > > +    maxItems: 1
> > > +
> > > +  data-gpios:
> > > +    description: Specifies a set of 8 gpio pins used to transfer dat=
a.
> > > +    minItems: 8
> > > +    maxItems: 8
> >
> > Based on my admittedly brief research, according to the TRM the display
> > controller can drive all of these pins - of which there are two fixed
> > sets as you mention - directly. So we'd need to describe which interfac=
e
> > the display is connected to in DT, but not any GPIOs (which they really
> > aren't).
> >
>=20
> Thierry, Mikko.
>=20
> I am not sure how to approach GPIOs defined outside of Device Tree.
> All GPIO interactions are done either by ofnode/fwnode or software
> nodes. Global gpio declaration is in process of being removed and
> legacy GPIO API seem to be not long-therm sustainable. How to resolve
> this? Should I keep above layout with GPIOs defined in the tree?

I looked a bit closer and I now think the initialization sequences=20
cannot be done entirely through the display controller - so this is=20
correct, we do need the GPIO stuff.

>=20
> > > +
> > > +  nvidia,init-sequence:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    description: Device specific set of values used in DC DISP_SPI_I=
NIT_SEQ
> > > +      registers.
> > > +    minItems: 4
> > > +    maxItems: 4
> >
> > And AIUI this is panel-specific DBI commands the display controller wil=
l
> > transmit. So ideally the display driver should receive this data from
> > the panel driver.
> >
> > Thank you
> > Mikko
> >
> > > +
> > > +  panel:
> > > +    type: object
> > > +    description: Node of supported panel driven by the bridge.
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        unevaluatedProperties: false
> > > +        description: Video port for RGB input.
> > > +
> > > +        properties:
> > > +          endpoint:
> > > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > > +            unevaluatedProperties: false
> > > +
> > > +            properties:
> > > +              bus-width:
> > > +                enum: [ 16, 18, 24 ]
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: Video port for DBI output (panel or connector).
> > > +
> > > +    required:
> > > +      - port@0
> > > +      - port@1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - ports
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +
> > > +    dbi-bridge {
> > > +        compatible =3D "nvidia,tegra-8bit-cpu";
> > > +
> > > +        dc-gpios =3D <&gpio 110 GPIO_ACTIVE_HIGH>;
> > > +        rw-gpios =3D <&gpio 11 GPIO_ACTIVE_HIGH>;
> > > +        cs-gpios =3D <&gpio 108 GPIO_ACTIVE_HIGH>;
> > > +
> > > +        data-gpios =3D <&gpio 32 GPIO_ACTIVE_HIGH>, <&gpio 33 GPIO_A=
CTIVE_HIGH>,
> > > +                     <&gpio 34 GPIO_ACTIVE_HIGH>, <&gpio 35 GPIO_ACT=
IVE_HIGH>,
> > > +                     <&gpio 36 GPIO_ACTIVE_HIGH>, <&gpio 37 GPIO_ACT=
IVE_HIGH>,
> > > +                     <&gpio 38 GPIO_ACTIVE_HIGH>, <&gpio 39 GPIO_ACT=
IVE_HIGH>;
> > > +
> > > +        nvidia,init-sequence =3D <0x0000002c 0x0 0x0 0x00005000>;
> > > +
> > > +        panel {
> > > +            compatible =3D "hit,tx10d07vm0baa";
> > > +
> > > +            reset-gpios =3D <&gpio 175 GPIO_ACTIVE_LOW>;
> > > +
> > > +            avci-supply =3D <&vcc_2v8_lcd>;
> > > +            iovcc-supply =3D <&iovcc_1v8_lcd>;
> > > +
> > > +            backlight =3D <&backlight>;
> > > +
> > > +            port {
> > > +                panel_input: endpoint {
> > > +                    remote-endpoint =3D <&bridge_output>;
> > > +                };
> > > +            };
> > > +        };
> > > +
> > > +        ports {
> > > +            #address-cells =3D <1>;
> > > +            #size-cells =3D <0>;
> > > +
> > > +            port@0 {
> > > +                reg =3D <0>;
> > > +
> > > +                bridge_input: endpoint {
> > > +                    remote-endpoint =3D <&dpi_output>;
> > > +                };
> > > +            };
> > > +
> > > +            port@1 {
> > > +                reg =3D <1>;
> > > +
> > > +                bridge_output: endpoint {
> > > +                    remote-endpoint =3D <&panel_input>;
> > > +                };
> > > +            };
> > > +        };
> > > +    };
> > > --
> > > 2.53.0
> > >
> > >
> >
> >
> >
> >




