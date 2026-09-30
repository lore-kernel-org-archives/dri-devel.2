Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D92ACA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7BBE10E1E8;
	Wed, 30 Sep 2026 09:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hbcPX000";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F1A10E1E8
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ew8LGX188dmWGv5sm5Ky0KqIlunEAGRqw8AEkli6Omwm5eRXm/yoxxXPXcNDjH4ke+LFCEeaqeEtmNAcm+PEUcxff/Pn5937NuxeRHIKbpaqheIELzoF5ja48/tOO6JYv+mTfG4duu4LkoN6wHlo2/idExi94joNdLjVNhqAZ7m+lmniqA8PDixpzFbVj4S2HkZjpKBk6H/RX2arV72UAtVGawhbmhl8lko7y8sknaEE5QckWfLVPJUlytsA8OE3AUwnaAQcZ/+xYSFP3xnRxKqHh2iau+/dGiwVGfX6y8WmUCnK93qjCjL1xu773Xx/saTWz49diSBedofYrtYdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njq/yzgUIdNiOOqWv7bIYjZq3ew1FCyjdWNz2r9414U=;
 b=JCOtr1GXvBuSNNI7HrlTd689+LJ+WFhfNmaH7+eGpUaxdQnGdJPXN68Jtoqo7S4kpaaRT2/VFkJRzim7NyXSm2tAqVDJff8T3zvDHqAsDlLoow0vFuv8ukHucm9W2qxk/Gla/PLm+2Yo0F0fvUdrz2nmIlr2ovRM22mL26gjJV7DAsAu8CWPUlRjab7sgbFLaswz9cHIDThSzN7q7gaKQIStcmMUb/dG1X5QF9McBLzLl7hNBT1b2mnxnF5xmsA1SD6RxBM/KSMX2yzT2B7bgi6jK6/HRgMUDtT1gFqrno5uQdmD6dBQH/dAnqXjHLi1HOKzuVWhaxDxQ1L+sJDtRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njq/yzgUIdNiOOqWv7bIYjZq3ew1FCyjdWNz2r9414U=;
 b=hbcPX000t/ZAuWFCxGRGpEKHk2ErpYYkDU0LE1LyuoXROdxYdx7S5mC+zUbqFCenNGrUXC1pyAI6o1X9Mx/Cr70laRNiwgOm0tAnaLBKNCB9PfrHjHjeQ19w7lnQmNbwpKAwrSqVTk+M1o87WT8ht+LuSSV/e8Dtq5saiQC4QicbxAEBnKEzLv2CK08evHG7ExLAmbvxSWMVGw0LY0BBKg+wgxpMC8pjSUXkbUjdgmUEsdFF6OujUJLCKoEj6M8uYybsbZFuqRRn+uR9iG6Ed8tXHHnRsHuBGtHdknyojMzqOlBWOK+ZkQaC/UR2YNm3lHJnESfuPvLP6RP8IbdE7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 09:19:26 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 09:19:26 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Date: Wed, 30 Sep 2026 18:19:23 +0900
Message-ID: <UJZ22UtaS1GSRPlyAst1og@nvidia.com>
In-Reply-To: <20260930070535.47130-4-clamor95@gmail.com>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P301CA0123.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: bf51e677-d1ae-42ee-b2ac-08df1ed3ec6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|10070799003|921020|56012099006|3023799007|10067099003|22082099003|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: eDLz0Xt5vCQpLE4XZkqLqLw7WhbLJAvorXk65hcrls3D4Es6T1qklLT9fNOn2WxIme9OHdSZBoTPq+Kxjuphr8Enq/fVQJmTsNNgq7qIirC/ezdP2kxbr0cVyABTBld1r2aIESra8XvqKrTUmSds4EDhq9u7ne7lFhpr9+7BBl7tH7Te4/TuiAqHLADTzpKT0MklafaQJfxY/oxDGjH2MDHH3sx5vDDB9i8QAN7D9/5NXuFDe+T0PGD6h5Xzy2/HsKihljXZmC9kFkmrOgzbv2QD9d3GedTndI6z+jmmEkyFl6yshhrecOo4+lOHPl7zNHGpxvjB0km0U6Ps7PgBcC7/HSC+N15DX/Ld1GUAm1qCkkoCYkEux7RDkZLyD1KRpzejLGSQ+GO6iJXQWtZs2z+Gu/BmnfwSfVNN49Fjk10y9JkAz9rQOOshMLXMFd0rgb3rMDNfCg1RN9Ks0ZgqHo9JhCHwFb6VM9VaQsnagLemcDP3uQ5uim6fn/yk6CAQwE6Ki+fUa5cSM4T6Fjs+M9lABE3qZnz8dSw6fSTTkGU2xsoIIYoh9jI/Mml4b9WxUdJZiAnd5OqmhodUBU5oIW4g2LY3kdOr5yb13hkbIejskiTv94v/maujJFpcxB8TCkqmLYQkxA2N6cWG2t7vN48p35P4pizB5De0Po/x7ctyIFz1hO4v4uyVqXHADQP61A8RwXif5M6FlNImbIk6GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(10070799003)(921020)(56012099006)(3023799007)(10067099003)(22082099003)(11063799006)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0ZUZ3hUaXZ1Q0ZWdDcvU3ZSanRJYUpvbm9vMGpEaHRnMHorcm02dDVzTXNF?=
 =?utf-8?B?RlpOK1VKYmxKb0wrbWkzUklDcitCSXVUQ1RlMGtzOVVtODRqQ2VXL3hRWEhm?=
 =?utf-8?B?aUhBcE5wOTlxbCtuZFBaTEw1amxEZ0dCZndyVFVBYVNoKzBTbE1zWkVMWThR?=
 =?utf-8?B?bnJoWXhGcm5RN1JXeGxwNWg0NzI2TjBHbEp6cGRCTzdPOTlENjZjellZcm9a?=
 =?utf-8?B?aHRBdWovSmNDVWRJV3l1MEYzL0pUT2VuR1krQlFuVitUODFNZWYwWFNmQnJM?=
 =?utf-8?B?SWwvOXZKVHFIbEdocTV0bmxDQ3lVcXFmazdSdUFBL3dIRXR2V3dCMWxWSnFp?=
 =?utf-8?B?WE9JSU1RRTVvZ1JmQUtUWGdaT1Y5S0picFVLRXZ1RVFlSnQvZFp5aUVwTHN4?=
 =?utf-8?B?SStNaG9zRzFxRmxPZ3F2eXFvRllERmk4U0dHMWtuQWdIa1dkYW5mU2tRcnFa?=
 =?utf-8?B?UWk5NzJKSmN3ZVVOMTJyam45dUUxczNSL3A2TGlGa3lzY1pOQ3Rsb0ZHM2Ru?=
 =?utf-8?B?SkNlY1RLTU1lY2ZCSGQrcDkvRnJKWkFBV1MrVXJ3a3hXVkpyQnFpai9Ma3dQ?=
 =?utf-8?B?YzJMTm9LTGQwNHBSaEhlTFlkT1FqUHFjUkxtVlh3eXdHMXdEK0tMeGtyeG9h?=
 =?utf-8?B?RWpqd0xaY2crbVF3d1hIakRoRkdScVZGN0F1ZzIrUVpuVmNuODdSQ3hoMGVO?=
 =?utf-8?B?ZmdWWThaYUJyOExsdFU0TVAyZys1TTNtR21CUmlyTnQ0Ym5OZmYrYU1kSUVw?=
 =?utf-8?B?K1RoMGxNazVNaVUyS1ozV040bGQ2U08xSlJXWlgrS0NiUlFqQjNTWVFhUU8y?=
 =?utf-8?B?d0JjMzFFeVBwWU95NkFUK0hZdjhmQjM3M2Rla1pVejFpVFNyOTcvc3c4YlRX?=
 =?utf-8?B?ZmsxVkNLeDVySit4OTI4cHpjem9KYWV6TlR5K1V5SmFWN0VFdEJvYkFBYURt?=
 =?utf-8?B?UG45WThQdmlldFR0NmxCejBTSWFqTVdURmd4bVAzcXNjUE9kbkUzb3RTbVp2?=
 =?utf-8?B?Tndnbi9KQVFSdENVS1ZXUlFJNUpkd0VFQ1BTNWkvTVV3ZlYyRHJTekc0K1JC?=
 =?utf-8?B?SGVHZE12ME13QUFLUjcwb05LNFEwSEFkdEVUNTZpNGJjbjNLQkVUYmxQMy84?=
 =?utf-8?B?UGdyUzhkWGJjcE9ScWI3c0g4RnJleVg5ak5ZYXJieXZzeUpUUFQwOCtmdExu?=
 =?utf-8?B?ZEI2UWU1UCtXdWNvMnRCTVdoaTl0cFdVVHNLNXE4dzNnc1dmNkYzTUVNU2NT?=
 =?utf-8?B?RmVQZyttenRaSUNHZGhRWmxqVnFlZDdMSHRtZW5COXRyM200Z3hPUTB2Y1B0?=
 =?utf-8?B?RlM0bGY2UEw0VE9OL1drd2w2c3ErSkhGNGViNmdFYWs3YVkwWUN0UkJ5VXlP?=
 =?utf-8?B?ZE1tL1ZlQWk0U2dBbXRoWEEvTVZyWll5eXdpYVovVkR5Y0hZdnB3T2lxamFX?=
 =?utf-8?B?dHNPbHJqRVlvMjZWejQraVVvSkI4NEZKU29vVk9xK2huRG9kNCtIaC9KUWp2?=
 =?utf-8?B?NWNQaDhnSkxvRHBUbGdnRVg2R2cvYk1zeTE1dnc0MUJxZSt1TlVwdlh0WitH?=
 =?utf-8?B?NWdMVXdEbXM0cXovdVRiVFlnU09jMy93MWsrbWRTVkJVaUxoaUU0REc2UmJS?=
 =?utf-8?B?ekhMSWpMQ28rNExyY0JORC9pZ3JvTXR0MnJRcDdiVDZMNGFuTXZJcE1reC9X?=
 =?utf-8?B?ZTdkQkhPS09TTUtiSUVNbmhkSDJvOTl5cWh0eUF5QkxSUUJWc3g2QVI0dDZG?=
 =?utf-8?B?MS84UGdPamxXSGNhb1doelZGcWUyWExOcU9VcFVuRElDTExESzFnUWwwQlZJ?=
 =?utf-8?B?NnlwcE9zNFhDWXE1Y1Fabk5qMXVVa1UwYmk5dFN3WjQ0amh6SGZCOHJvRmRV?=
 =?utf-8?B?TGl2OVhZajZDTmhHQlpxb3pHdnpqMHFmM0RQTmZNeTgyNjhtVm50bUVxOGwy?=
 =?utf-8?B?SXZLck56Z3R5YUJMQmZ6M1BmMStYSVdUeFcvREJudjdEdVJGbWhOSHAzOE16?=
 =?utf-8?B?eUx5MVQ5UldWNGkvQnJpcVN6WnR5ZElTUklWOERUV3FiOGkrSjZTNVZIKzgx?=
 =?utf-8?B?eXJMUDdLSndyMk9VRkcwZnRycXhlaHdETXFEcGh3UE0zeWt0c1dacEt4Ny9j?=
 =?utf-8?B?Y0cwaU4xWDY5cUU2bTNKeHQ0Mk8yOElSazlRTFVKQVRKL0h4eE56Mlgwdk5v?=
 =?utf-8?B?UXlKb0tEQlVCSjRvSEU5UnlDbUZJemRNZnkvOUk5UXdTdXppNG5wVEN5Q0Iz?=
 =?utf-8?B?dVJNVldWdkdWcUQvUCtPTjg2QUZDSXBYUHBHNUZmczFCdWRrRW9aZ1lyTHoz?=
 =?utf-8?B?T0dXSjNxM3BmVTRRRlY0QjhmK3J1STJnZ3JSY1A1WjNEcXF4SFBvL3MyS3gx?=
 =?utf-8?Q?DpH2gjoSVNOsi0xDqFXtXYnqmeYTcCUsR3rERgviyjYo7?=
X-MS-Exchange-AntiSpam-MessageData-1: ubI2D9sxnm+Qlw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf51e677-d1ae-42ee-b2ac-08df1ed3ec6c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:19:26.5671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEL9WRm664PwhEzXJontedLih44RpK39vm3n9hUWIElfQmKrneuOxZuK/Vask0Qbc9kpg5jHR2uuROpzxRUrKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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

On Wednesday, September 30, 2026 4:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> Tegra20/30 SoCs display controller.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidi=
a,tegra-8bit-cpu.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,teg=
ra-8bit-cpu.yaml
> new file mode 100644
> index 0000000000000..f0dab608b2936
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8bit-c=
pu.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-8bit-cpu.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description: The display controller in Tegra20/30 SoCs features an
> +  8-bit SPI interface that closely resembles the MIPI DBI Type B
> +  protocol and is referred to as '8-bit CPU'. Each display controller
> +  provides two such interfaces, which can be used to send MIPI DCS
> +  commands to initialize and control the panel while image data is
> +  transmitted via 16/18/24-line RGB.
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra-8bit-cpu
> +
> +  dc-gpios:
> +    description: Data/command selection pin.
> +    maxItems: 1
> +
> +  rw-gpios:
> +    description: Read/write pin.
> +    maxItems: 1
> +
> +  cs-gpios:
> +    description: Chip select pin.
> +    maxItems: 1
> +
> +  data-gpios:
> +    description: Specifies a set of 8 gpio pins used to transfer data.
> +    minItems: 8
> +    maxItems: 8

Based on my admittedly brief research, according to the TRM the display=20
controller can drive all of these pins - of which there are two fixed=20
sets as you mention - directly. So we'd need to describe which interface=20
the display is connected to in DT, but not any GPIOs (which they really=20
aren't).

> +
> +  nvidia,init-sequence:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: Device specific set of values used in DC DISP_SPI_INIT_=
SEQ
> +      registers.
> +    minItems: 4
> +    maxItems: 4

And AIUI this is panel-specific DBI commands the display controller will=20
transmit. So ideally the display driver should receive this data from=20
the panel driver.

Thank you
Mikko

> +
> +  panel:
> +    type: object
> +    description: Node of supported panel driven by the bridge.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Video port for RGB input.
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +
> +            properties:
> +              bus-width:
> +                enum: [ 16, 18, 24 ]
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Video port for DBI output (panel or connector).
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dbi-bridge {
> +        compatible =3D "nvidia,tegra-8bit-cpu";
> +
> +        dc-gpios =3D <&gpio 110 GPIO_ACTIVE_HIGH>;
> +        rw-gpios =3D <&gpio 11 GPIO_ACTIVE_HIGH>;
> +        cs-gpios =3D <&gpio 108 GPIO_ACTIVE_HIGH>;
> +
> +        data-gpios =3D <&gpio 32 GPIO_ACTIVE_HIGH>, <&gpio 33 GPIO_ACTIV=
E_HIGH>,
> +                     <&gpio 34 GPIO_ACTIVE_HIGH>, <&gpio 35 GPIO_ACTIVE_=
HIGH>,
> +                     <&gpio 36 GPIO_ACTIVE_HIGH>, <&gpio 37 GPIO_ACTIVE_=
HIGH>,
> +                     <&gpio 38 GPIO_ACTIVE_HIGH>, <&gpio 39 GPIO_ACTIVE_=
HIGH>;
> +
> +        nvidia,init-sequence =3D <0x0000002c 0x0 0x0 0x00005000>;
> +
> +        panel {
> +            compatible =3D "hit,tx10d07vm0baa";
> +
> +            reset-gpios =3D <&gpio 175 GPIO_ACTIVE_LOW>;
> +
> +            avci-supply =3D <&vcc_2v8_lcd>;
> +            iovcc-supply =3D <&iovcc_1v8_lcd>;
> +
> +            backlight =3D <&backlight>;
> +
> +            port {
> +                panel_input: endpoint {
> +                    remote-endpoint =3D <&bridge_output>;
> +                };
> +            };
> +        };
> +
> +        ports {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            port@0 {
> +                reg =3D <0>;
> +
> +                bridge_input: endpoint {
> +                    remote-endpoint =3D <&dpi_output>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg =3D <1>;
> +
> +                bridge_output: endpoint {
> +                    remote-endpoint =3D <&panel_input>;
> +                };
> +            };
> +        };
> +    };
> --=20
> 2.53.0
>=20
>=20




