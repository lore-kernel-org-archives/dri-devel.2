Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494A8C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9626610E825;
	Mon, 13 Jul 2026 07:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="kSaE74XQ";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013010.outbound.protection.outlook.com
 [40.107.162.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 825F910E15F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uelye/ZOoUxGMS2/vdHlgaUI4DY5OBQv7RQYYhN1qW6eaLI28RgTuoSqXBXJ48qxqsM4irw/OdlU360DTvUKXeImZU95btliWPs81PYJ0xeFdmOs7I//ufslYYShWZzkBKeYq45AdX4loMjOu9+l04BdsJLxbejbuM4lm35SOCnwj/XSY3/IYq/aWRKymxehLjwZ0mRw320s8XMx/u/i2U7tL+R2kLcwTvESTohj+KSnxGeC3oXbQEEhTaWDckzm5ZF4sDPnrzSPB3y+lONBLSDE+xleSvyMXkGXISEcoLbhnSko55+jaYjJ6NzYFj87Pa1eE9yo4RxRqPEsWzlsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rJEFGzVqgaWqPgX2NjIipVmq3FKY+pV8KgzuVemCxw=;
 b=EJjiqeIKBdjuwQQd8UAjfSKG5doiZgMe3WQH/fQwssBl6J2ZjJ9uTo3FyH7itihwgeVxAYsyYL8udg8W4Ws4Xr2N4+xt5D3aojPy5pr6itbUrtxTEzulVu4tVrEdjyeUYYNAlJDayMPGDfVX0SyokVDqJHJCnY2W7CZjJNpQluNd9KUoerLPqI/gt3MjznL/7Uqop93c5IawwvrYa3keI+3XQ9kCoDrrukN+54eCga0Bl1k6y0sceFQpLODHuC0MRv7bk+Gq091jiL1d0Im/xIQ2rYMJQMfZQ7t/WsPPf3a5l9CfUlSpuSjaY+hSDS02h18mMpXQ7Gz3YJusst86kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rJEFGzVqgaWqPgX2NjIipVmq3FKY+pV8KgzuVemCxw=;
 b=kSaE74XQVPv7+W0W16znJI33IwI4MkCcayY9rKQYrdexBDUihvr9ED1kKsqENh8aDBMU1JLhn76eiYKk+n1L3yTCsX/RtdemumtmzSjUiV6nr2H2+eVWYfJk+E4FZk3D2Km5YAuizeefVjrdsAThZp8+xOxwepLDIYuX8VSql5UG1MmLqWuU4eXtheSQph1UoRYMDoM4X7BqCsfmI6liIAfIDcBdzF2lJsFAay4+nwfsaQEr2ZYVoS7gNXf+D+UjR+LWk6dJh+RNrrOL/BZ/deTVC6A7HV1tu69EnMnALEiquMKYHUZBMmTUTSkB9uVebbENS8ki7DSMeDMCg7+hLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GVXPR03MB11645.eurprd03.prod.outlook.com (2603:10a6:150:2c7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 09:10:55 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 09:10:55 +0000
Date: Fri, 10 Jul 2026 11:10:46 +0200
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, Frank.Li@kernel.org, robh@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: display: sn65dsi83: Add output
 data-lanes
Message-ID: <alC3Fnzyy-C92sLA@mt.com>
References: <20260710082630.394040-1-wojciech.dubowik@mt.com>
 <20260710082630.394040-4-wojciech.dubowik@mt.com>
 <20260710083425.B7EB11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710083425.B7EB11F000E9@smtp.kernel.org>
X-ClientProxiedBy: ZR0P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::8) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GVXPR03MB11645:EE_
X-MS-Office365-Filtering-Correlation-Id: a73874fd-30f4-4ebe-39f2-08dede6325ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|1800799024|23010399003|19092799006|6133799003|3023799007|18002099003|4143699003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: n1vDgD5cFEhoqKpOqs0mKsXuIO3PKQVdslu0MLo+Q2PdRsMLUv2zBaHJBRaVvyOmPW8pHespYrkveV1M74g1f5VXIDFX+KrdIj67xnFjhdhAutKOHmbnkw2oLLvmvbajjlIxfLUc7nH2pUNOWOeNYyXdy04QR31PfuSuW9PLXvcbv0JXCVR19B/g4lJG63cMSSPGnWVmg4ltPUpbcw+8wLIx+JpadwLa9wEgQXRRJVJfIBPiKW7YzvdEt4FIUFHGE65eocNrlUo+te9H8VY6TlYT4fDJ9MVeaMPAYrAX9Aza4OdvQ8O+gV8n8HdP1Gayi6TGQXlfeGOK566dUE0vqS0VgcovDCfzvQ22yr5Yqyqm2RHTC/L+25udbYHiCuxx3qrJe/bvgqKaNl+s+zPUe1MERNOQJozL7qDtZPDH0zYcb01rZ1LyfEy/KIfXWRy6odNKQGolAft615Dxr/V1PUivjlhDpwPFBT2njNiG+BGF4n5jIBd4zba1fX/o4RI7XLPkmeScwrenoJhILVwGB6q9cvcWfq/dnfHM/6k8QvHKY8ygecRktKhVkcYsB3nSgPiC6CloLCh+e0coxH6teHc9odeumMj/+719YAUkMBXmqDJ217kjLzyv2S5VogT+TxIhN0LhjPvfAcS50dJOfKP3dEkCGeocfrlp3TLpyeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(1800799024)(23010399003)(19092799006)(6133799003)(3023799007)(18002099003)(4143699003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7RNQ1gT/FA0aGklVXLGP9raHV1PQ1oaTHEBgGiWe220WLHjLEl80Qomgag?=
 =?iso-8859-1?Q?9pr0EnJajt7TiTzeIWpiPWX9I2ZGp0VSMT0vR0RnMEs9AoGKf7sAWffttv?=
 =?iso-8859-1?Q?PZqsLDD7K/v23vAd4+gO+KhIaW9a2V+mTIefL7yAeNB8WziXQBskwEf4ye?=
 =?iso-8859-1?Q?fJKBlgjBII0S1vyH3qRvU/atZjzpNyQbWJEd4ElGpg5yhHBzdzuj1Dov6q?=
 =?iso-8859-1?Q?cOrg4zQYn8K7A4VJJM1qcee/PhIrWSnl03vLWHC0xBi9jHZyEAzxIXvoIk?=
 =?iso-8859-1?Q?FqEmzcct33GQuAQ7zJywqfVNAIiqxsr8oZZtjMszhrV/tiTHZv2JNf0h/5?=
 =?iso-8859-1?Q?zk0uMDzwBOtLv9O293IZo2ERtpqWJ0yq2TcJb+vTDoZOdWvDQEMKqXUt7f?=
 =?iso-8859-1?Q?GzTeQzimTgvsdANoFGVZ0X0Gn8+0clTzqe2Rh+S9Inj8M3Ggwi3xCnd81E?=
 =?iso-8859-1?Q?OkJiVJXKoPgKc0qwG+5pcMMnGHB9DKJIZqBy3CsneshJxvg72cVZb285vM?=
 =?iso-8859-1?Q?erARsEXloQU1sZQiIpvpHlv7W3M96ey80uNNQKi5C/aelMaPMWnXGnijKQ?=
 =?iso-8859-1?Q?dx53P9r/3McvF2qICkiySOInaQ9cOFaFksMEc25cNgEgZ7iMmDKawe+9Cz?=
 =?iso-8859-1?Q?49c5Jb2625Ov8pTZk48w97xiWQzu9IgtDpdkShtqA/+l2h2gjy5x6O5Lk7?=
 =?iso-8859-1?Q?gK44QWCXPZoIaeldSCDceTPSXIfc9Iz6WF7mu0r//OpCMgl8zfT3FYfHOt?=
 =?iso-8859-1?Q?/dwcgTYN0MewglEvQBGVxbX781ivdR0RZg3kF1QpNyDp6vEKI1Z9lGxIH3?=
 =?iso-8859-1?Q?YFtAZYo4cbNRDKRsF0IHwJwSQ3juQpi/2UK1cCX39bhupJECCoBVDTIzFp?=
 =?iso-8859-1?Q?uqcaog1FSHgvO8CiROHchsQFvchgpvwB77M9pSUV9mZ0wJ24s/iQZL94RO?=
 =?iso-8859-1?Q?zsCEs+jcdC0IWTNZnvvTZEzeaYf5zwnpPzJ4ol7o1NDE8QOrQ8Cs1ikvIY?=
 =?iso-8859-1?Q?PCkbQuPkqnPma7io2LRdMPB8JcyhZjaozoDIJg7dSaC9kjM9cKY4t/CEDO?=
 =?iso-8859-1?Q?pfhAIEztt3f6hixYeGx5uxl9WqYrfD1Zj8tvyFsNM5EQA6zm+IEU3p9PQi?=
 =?iso-8859-1?Q?ETVRwwL65LOUzo5is9obSp5RmGF4Eh1AYA5RONuZcBJAVDxzEx5j1ioAId?=
 =?iso-8859-1?Q?fO9DbK1rL62HiHtadIGjgEltxOj5tsKEBDIo/93F+vkqipSU+r65i5H4VQ?=
 =?iso-8859-1?Q?jQ23iOVun09w4EaGwsvQmDx4DBMl+deKze8s7VtdQSur9NwSKbq90Nf55i?=
 =?iso-8859-1?Q?LjyX9QtOU31Cf/OfWwKMqDR2X4mmqufTvcflM7SgbkznQUL+0+P1lao+8J?=
 =?iso-8859-1?Q?g9ISCypn4B+ygsHZSVfrTj3iSp8dm/sH/e5VjPyfmnL+ssZ53hkKK4Venv?=
 =?iso-8859-1?Q?u0mNvO7lUGO32ls/jgxxQs9WahuxyMq9hqCJcreXW5KUwOrTr3CbaOLjFO?=
 =?iso-8859-1?Q?3d66gcDSSmCC7lP1Kr0im4BMg0xa5bjflns60vUesMtbM1tfp7Tm8Yy0/M?=
 =?iso-8859-1?Q?dygxgxH8ud1eaAHlj6mVTZ3vxU6zQXoA3ZFuarM5MC8oQg2wlXCeCZvhUN?=
 =?iso-8859-1?Q?ZGdWgHN6chYeaH7Y2uJaUZXrHZU0Sqx0Bwj5m0UVlZfHZfCsnM1M2fVGsi?=
 =?iso-8859-1?Q?Lqw7HY1HmmfskemTP2QP6eSMNpLLWeflqRxaVsfbjMXJfZOUOSR3TFKhWN?=
 =?iso-8859-1?Q?IvkHufvKyNNO3S+x5WJGll8WPxOyzBuc5xAHIbF5OGR95QPrYhyaYwFSAq?=
 =?iso-8859-1?Q?0eHrP9iBzA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73874fd-30f4-4ebe-39f2-08dede6325ae
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 09:10:54.9776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PhCPKn5d3gUUFd8P9Q4yYcaFDSlq5RoV5urTU7bTBvRJJ7Yf5J8LA3eVOtWDktpedKbFZbquMHI2Ka5vybdbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB11645
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

On Fri, Jul 10, 2026 at 08:34:25AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Mismatch between device tree schema and driver implementation for the `data-lanes` property.
> --
> 
> --- Patch [2]: [PATCH v3 2/2] dt-bindings: display: sn65dsi83: Add output data-lanes ---
> commit 98aea58cd5128c6a4b72efd4a5f9ec088fd30dca
> Author: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> 
> dt-bindings: display: sn65dsi83: Add output data-lanes
> 
> This commit adds an optional output LVDS data lanes property with two allowed
> values. It supports the standard layout <1 2 3 4> and reversed layout <4 3 2 1>
> for output channels.
> 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > index e69b6343a8ebb..4431f113bb9cd 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > @@ -86,10 +86,52 @@ properties:
> >          description: Video port for LVDS Channel-A output (panel or bridge).
> >          $ref: '#/$defs/lvds-port'
> >  
> > +        properties:
> > +          data-lanes:
> > +            $ref: /schemas/types.yaml#/definitions/uint32-array
> 
> [Severity: Medium]
> Does this schema change place data-lanes at the correct level in the
> device tree hierarchy?
> 
> The schema defines data-lanes as a direct property of the port node,
> but standard OF graph rules and the driver implementation parse it from the
> endpoint node:

This is valid comment. While testing dt bindings I have put data-lanes property
on the wrong level. It should in under endpoint and not in main node.

I will fix it in v4

> 
> drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_parse_lvds_endpoint() {
>     ...
>     ret_data = of_property_read_u32_array(endpoint, "data-lanes", data_lanes,
>                     ARRAY_SIZE(data_lanes));
>     ...
> }
> 
> Because the driver reads from the endpoint node rather than the port node,
> will it silently fail to find the configuration and fall back to the default
> layout on affected hardware?
> 
> > +            description: |
> > +              Array of physical LVDS data lane indexes
> > +            oneOf:
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710082630.394040-1-wojciech.dubowik@mt.com?part=2
