Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A41C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB5D10E7D3;
	Mon, 20 Jul 2026 07:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="dSR4z9QV";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011013.outbound.protection.outlook.com
 [40.107.130.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A07B210E6B9
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHFEZ9MeJj4uKyjWPmwGhnZcKQSMeRLSUlUf3bGPqJwZKUFaaPrMYr/VZUwEgLLtPf/9v0VS3IaRpMpKrhQlcyp5xphLV/WWKkEj2ihonNEUftUemJmzbuvYDSS91GgC8WGXzKvJcX5eQMDhr62bxC/PSkVFVTS9nZ0NseuhnfSy9RT9xLGBk9INASnbDDCdOk+mv5zmerWxj8bap8lGK65mmmL3AJmCYnTVXEnNuDN5zwy4Hvj+aHeisVRaBQZO5c3IngyNkD0sMvcB/Tz+PVJbnFzdBRkuTBQ6M2oCkp8Gc85oahDIG21tX8HZvFdKvasnTbT8H51p0KrFgx1/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJEYDwGuwdRotgzY7j0rCz/IgZSnSVJ9SGs2CPGqHes=;
 b=NUr38B1mGHccqcd5yhmxi0SihtwMLt5wkAXGmZsuHoCMWpQCrR8o29d1jVjIJaDIG33gfp47YzaK3YH8I30brr+KtSLEd0OugynhQQ2eQVp4En1hwQxqxlf8qiX6EguRUH5F/JCmQP7gmjqDfOPUaWRltcwu9SfyP3VoyzMHZuOcAU3F7nm9G4HEql/XFcF3ekvhcn75j78wg3yIQctWcmfdM4oF0jSg6c929O6t5X2EnJ00aUwqwtsXxylU2FllCkoMBpEDqnFLX9DkW5wKI8mJR+ExEFThZUxelUydXRhoW/eh7klJ0/lBfB7LuNKRNJVFRyofsVqRI2I6TGwivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJEYDwGuwdRotgzY7j0rCz/IgZSnSVJ9SGs2CPGqHes=;
 b=dSR4z9QV7elpzn8fJgSHy/stkNMGCkagKuO1JOCDfrk6/86nR6wUwvZzBxrIX9yOIXE8I4iH2GWSn9VAZu0OTYO1hiOhDilA6ldL6zWNsWheOJy5AU0i9kVto8N/3m+lLP7JGWxb6prTsZ81cYvTecSq+tMf1IfQLICGudVSvylDKyIIt1lwl7m2hHC3r+umt1CjFTI/WC0MVKMxD7AjG6tIaah9BhTaGL14j2xQ0MgWKgC76MzhrDCv4S50TO/0cKtLcX/iXPTuPJHjOZsnw75UdI3nvj320DJIy36SA7ty6JJzetH7/Reckg+FoLGJMHUYk3dusTM+/yYGbv0RWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AS2PR03MB9467.eurprd03.prod.outlook.com (2603:10a6:20b:59c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 06:55:14 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 06:55:14 +0000
Date: Mon, 20 Jul 2026 08:55:11 +0200
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: display: sn65dsi83: Add output
 data-lanes property
Message-ID: <al3GT1MuFZZmE-GY@mt.com>
References: <20260717115002.308035-1-wojciech.dubowik@mt.com>
 <20260717115002.308035-3-wojciech.dubowik@mt.com>
 <20260720-international-industrious-hippogriff-dd24ee@quoll>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-international-industrious-hippogriff-dd24ee@quoll>
X-ClientProxiedBy: ZR0P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::15) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AS2PR03MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8b985b-b552-499f-5dfb-08dee62bd9bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|52116014|376014|7416014|1800799024|38350700014|56012099006|5023799004|10067099003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: /zBNlxpTothF2gWt3emIiESJTYuoyrU8dXgTtXDnDz5vnyw2Qvatcsb/aGx0VoXpFQgHbxASf88epcJvFtxmJG7b4LqT4qTsdrGWLdvrn3BnSmiGilkOsNRQ+IeqUuoibTQLpooTiR1anY9IQmf8iBdzrinv82D8JqIQoN63k8XfZuRW8tgWsJTuYsoLUullD5erJtXmCfbqTt495PoszSHBqGtz4IvlTwKGJSLx7f35TPAXbkWgQzWNNJy+lJ878mEoIiyT4RmNPeGq8oJlQRNZF/m6PM03ivlbEuHRJMKccao4DguRP/jAl1d9Zpei0oBvSXRwi4UJ63WLxQR+mCDRQseYpn5QHVB5VSZFIck696tEUOwPB9XKnmjbTvJCQcp/hpM+knP8BE3oKdr0rb8YJe7DnEhB+h+3wWtyn93+JJGjQv3x4XnfhDMkL5QqQ+6TyVXW6BUTx1jrKAUPMmBlYPrHEGfPZorF/7NO0pagbdyVIFRc5hAmeqVE5YjaMdQ6urSd5tyTAgG9gpqRYJLO1KHyPEw/05YrgN0lRshBk//yUdOu95x3NIFvXVMZt5b9CV1FOy78nbaBf7Ac5A5QePK8m/N8i4XJjSJTZ3mCjoDEQ9QxAUd87E7IWML/zsbSVGuSo+KSi7Ay02IVBHN+6h2tpm1dze0wWaaWcWYpJT0lX3UOYqA+DO4hws8gKRZwH5kmraNEQNHP12v4lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(56012099006)(5023799004)(10067099003)(4143699003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?toB5vYJ4YMriCaYhP1J9rad51mXPMfCsXrk81+3pGyjK+2JD+asy1B6KUbuB?=
 =?us-ascii?Q?jwRQ7M1aQIeiZe+9z85bcphjH/LlwWZgJ3eKO7q2zv2F2uNZO8oUHnXLW2fq?=
 =?us-ascii?Q?3H87u8z/E1h9tIWqelof093qweC0dqJ9x8hTStHuAlDoj6JhE4ORaSS/Vt5Q?=
 =?us-ascii?Q?4xijjdgmZ3Ddgo+9vgF/8sH96mAOEQ0eoZkVx/hrOYt8KyAxFu9kEBHX/2IW?=
 =?us-ascii?Q?lc95lNF3HvBQ7eAbv8Pp9iCmgmBfjR/V08PKImyYrsuhXdUFnw6fy4hCeJK/?=
 =?us-ascii?Q?8pdm4OEq+iaPjPptFfmmTvZnkpQTCogG1SrukgS+lr1O5ai/n1YWA9wuKnLH?=
 =?us-ascii?Q?SrENE89bCYiVr8dDDeOwPTCekMVax1iwhCx5GkO2Nt8ionfn1sLt7Fo+ZIXu?=
 =?us-ascii?Q?ugQ9/nTCFyDuPxr0qN3+qDuu835P8oqaFcsewT+qJoCb5ZNqsxmX5EawqOw3?=
 =?us-ascii?Q?/P0RlIleFHPhXnxPZn9Fq3x0X05zfB0GyHLhPqE2T+mSxiGW37mmTck5XeSv?=
 =?us-ascii?Q?PG/NGvx0Rw0YNlIRTd+N3xduJQXRusudgFMkXcS8RkPJFH5v48pMHs6A8t4/?=
 =?us-ascii?Q?o2uBGWFjar+3Z+sDpS7XPGxgB2z8PX9ULZZOtA/eOIHaCzttpXYK28k2ftUj?=
 =?us-ascii?Q?Vk9yJDV4XFNHsfqJxmcByz6aIiZybPAdZnYt+0vlYcC3z8bBhA3UltElYluE?=
 =?us-ascii?Q?yImRHBj/Z/WF4VXYvdp2Aad8RPFEbOm8ZyrBcY6ryDvUpaZZtX84FMB+jQq4?=
 =?us-ascii?Q?y35uZmW2XOOVofVkWpL5eJhjfaQFK40iNFoUaEvrWDO6WFeifTLEuqcjJCUN?=
 =?us-ascii?Q?xLl/akuxqu6jYvjEuKlzrawWl8IWThBloYJZf+UgpMw82Jd2A4k7VWMEarSF?=
 =?us-ascii?Q?b8LLHgqehjAjIvaH+ChggvSCIs3E61QE0yoqnn2mmZN2czIoeJve/yXGG27Z?=
 =?us-ascii?Q?CQ0oHTdUYAHPmn8GcZOSjAanXPUUjuldXI4+fmAuNS0JgTECdGG84NMghqzx?=
 =?us-ascii?Q?4O1XNj5quYv1UAuYL7zjUDqyB3yQyqT4SNe4wr3rIYLEXBb40MDpVPn1TkXd?=
 =?us-ascii?Q?Gi345ZkZaPXKZ8IgrbE+ESw0NBgLRlt2uIsm5FEiwgVdHABcPaNXBLbYCq+1?=
 =?us-ascii?Q?OWo5P51sXbvsOeYbKTd5Yqe46IbSUuqwg4w+3stcNf9Q8SQzCMgrDuBiK2w/?=
 =?us-ascii?Q?z84gchsVMKAuckY8MYWH3X6X7/QKs2d+HEuoUACMaaxUby3D+6bPbkIROxZN?=
 =?us-ascii?Q?mnBv90Z2BW/wKZ6I7AfkouTulG7VFuBA4rn7kVGbBSbLaCNH6Z7cJyMtYFLg?=
 =?us-ascii?Q?b4L3jFsuBEB9J/TP14qu3K/bPScpp8Wpxej/gVvYUsyyfmQK3lYdEeQFWilS?=
 =?us-ascii?Q?hEIt1PWWw86oLAGae3LhtLZExEfY5KRzT+fHS3IOzwDemVckZyobDP0NHMGj?=
 =?us-ascii?Q?q1QY9UNcYX5WMguEn2Mq9zjAaOtFIJ2Vy4ogoTAiVbNWv27MNfeKdlEM6UuZ?=
 =?us-ascii?Q?0dzKktbiO8q6sC1At8DZeXant9eBi2QSJ5Q7HVdWxCffbnao9OVKirexpMcR?=
 =?us-ascii?Q?mIX/JFBnGjYNoIrt0TqH/6aN6f22sGsQg4sKZAwukmARgQiArIkHhtc5jssy?=
 =?us-ascii?Q?2EIGT+cD1bDQQzhJDuVJHnQxmIr1V3yrlT6W3y/L95i9GgSVknIIEbflzm6j?=
 =?us-ascii?Q?CbLzISFjf1P7tl7inLru2ekhuyL2qEJ5oxEezLQeCPD1UXLV8WXSL3m5C8eW?=
 =?us-ascii?Q?EEJbZcrmRA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8b985b-b552-499f-5dfb-08dee62bd9bf
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 06:55:14.5683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skHa9DwiRiA7FxkHjP9pvYovzicWsxFoDbBpw0wJACjL4aJvxT5HesvmGWKAagOQOm0YBDXMLYXYkX7uGE7oWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9467
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:04 +0000
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

On Mon, Jul 20, 2026 at 07:51:10AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Jul 17, 2026 at 01:50:00PM +0200, Wojciech Dubowik wrote:
> > From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > 
> > Add an optional output lvds data lanes property with two allowed values.
> > The array <1 2 3 4> for standard layout and <4 3 2 1> for reversed lvds
> > output lanes. The latter informs the driver that reverse lvds config
> > option has to be set in config register for the respective output channel.
> > 
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> 
> Well, I am not doing the work twice (nothing in cover letter explains
> why I should, IOW, why you decided to drop my review).

Sorry. Missed it. I will add reviewed-by-you tag in the nest interation.

Regards,
Wojtek

> 
> Dropping this patch from Patchwork.
> 
> Best regards,
> Krzysztof
> 
