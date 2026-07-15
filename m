Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D487C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF4D10EF0D;
	Wed, 15 Jul 2026 07:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TSw9n3E5";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013067.outbound.protection.outlook.com [40.107.159.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECECA10EF0D
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVlS0K2gpr0YOOCKaT4e8azkexEYryYNoVk5oYO6BaGCOuBNdL+J+5F37PJ1Ih+qABVp3zQ0gWJdUar9Ezm5OOMSoykFUWIOS5o7+3jmSCHV8obTyd2XFke6lDeNj/szpi8vwY8uVrtF3NC7qJdpix2Gp7PslL3klxX6Wdtc5M3usEmJgdnqzVZpIC6R4biTy6/rMBBvOU9MZU4FrjSwk1900BAc713IBAymdh/xH1Aca9fzrSHAb7M3rPTDb9g4xR6ZUrG5+0VZ+XnWc1dI9pNyMLDZT2CQf3LywE0eabl9dCe6ftcpqiWml+q+yV3GO0o4ACKiP30Jbu4Vcq9bBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUcPv2T6+zDq0VBxVV90Y4HPnXSOZ9AIkNLSbrDjkxs=;
 b=ijkxJL0rPcVGW+5mhjmR7a5GHfRF5RkK0K54kKsHLcH9IbjLplB/h+1MIsCgtRUMVGgOAefht0tUd4snTq+w5HN9kH3fESwxS+xf5ZexJAI2kANvM7H0EOvJYsYXdL+HWZeZorlPwEUcWXTV8Ch5eG/EKk2V7vJm4yqsvJ73sVNVFIZzuL61R635rtNQcdUhesi8989kvwYPkCIbjURLUb/Wda1D5mS5GXsPiqtqdnPpwa4PLTp1JSgYgrso5i3PPUGsWoOfedri4g38WrVv/ZaVy7IzsdUxCKssA/oQeQ9B6l7iq6TCvN6KwmeywqHrBjersiRMigv2YqZkxugv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUcPv2T6+zDq0VBxVV90Y4HPnXSOZ9AIkNLSbrDjkxs=;
 b=TSw9n3E5Y0HziGXQcz8br2ExOM6pU9zx9mJaf44QVN+OmHFEUtVONMXeGD06uBUvIMlE4SVFZN765DrljJBjvowEZdm0MQo07D1LqwchDF8tD9Wu9nf2bCFkHXHl9JXOcNnkOTv1uWTxaDx3YgWmAjKKgNcgl0UGWZXbYXlLrW8OMytmZrPrrF55NJfb7js1yn+q+OgTfyk1cgTWjMfWkXaVXlUZdfRMQcaI5FwOEIDq5S49slKStZPxTjry1oKeOiCOMyjHq9rBtR+VCuqz8hiGMI19wa6MqliqmXmu59nqyIW2PdQ4rUdOsxEN0OAAOm449cvMDh+BpU2J2XIRyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 07:40:14 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 07:40:14 +0000
Date: Wed, 15 Jul 2026 15:41:43 +0800
From: Liu Ying <victor.liu@nxp.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drm/imx: Switch to irq_domain_create_linear()
Message-ID: <178410074760.759322.11532753464327742911.b4-ty@b4>
References: <20260708095645.385291-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708095645.385291-1-jirislaby@kernel.org>
X-ClientProxiedBy: MA5PR01CA0284.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::9) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|AM0PR04MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 707828a1-3444-43b3-ca8c-08dee2444e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|19092799006|1800799024|366016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: H27P+h77Vch42VeLtx/eSiqSRSFlF6mWQmZDeCzNn7hPubzOh1lfj1c8kEVNB0j4me4x9vePOpkUEwXghQwYBFjBjxPVCsO6sZkhCczIGNOgJVy53MaE5d/e3PiRktKtxcomhuUqVrFpJIo0W0j5Zql/6HhSV61pkj7b2NOLk2OAn0uCBSvVxblCredOgK26+oZxkFVYxwpVS9H9TBAzPAapjjipUYSXGKwBTzhXdQXoTKD10CShWU67fWxLuh3ySeNZsQ67R35S/WcQxE2cGTnOjrAP9BfXvTLN3/zoMZ2ikLU9l9CFYqDDTYTG5hbZW96OAhW15blqTqM0AVOlwbwSQNfA8eFSlDInWvBuO9+Xf2OEhuU7SVcemJF4SdnKpITJPJfB5B/lm4FsL9TzNwfzeuzg8qu0q9bMb4e0LaCYFUnRj5CWgkgDVK4+WttXqBiEXi7HTRQacBEgYvG5z9akBn77M5AnW6HJ6TuB1cGY5ug8TcP55933M+xVcQFDIi4Gdtm/06q0TpU+H7iRllFipw920zNlJT6nGbAVDexzAfmnkdxNdDA58e7zOPFT0c46KDcPJBKcCpKmGRkxxVKn6bFHqR6n8SG2ISosv8fp8JLIVztnkemd3w8U03xtdMYXOZuYu3USqjC1EugKXeotvEWWRGTjHynNGhMwmt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pIQ+t9GEL5HLAFnGcwkRfeNX/ECLH4t0mFORUX432n6ndffucucfnIkBjK4P?=
 =?us-ascii?Q?inmgQe7X/h8+CAS+TYjs2ain8m0xuo6HI/oqhRLsBYm+cSF+Qlm6vyDDGcED?=
 =?us-ascii?Q?TRnLkJY1DUXLeky/yWgC+u75uHiDTXigzvpwl/2Sxw3URh5RW84YBk4GMIN+?=
 =?us-ascii?Q?VA5/1YwL85IpVSODA/s4R9KBM2/7+LzYrfCNnRTQ/gB4YYKJGtbwq/eDqsqW?=
 =?us-ascii?Q?2HzGjpp0o2jUBcwqWzAOei0G0FU5+RP+XAas0zazxOdehO5oWzpFOJW/02x0?=
 =?us-ascii?Q?ent3V7opPffPc38KqLULFzcFauL3+Rml8tROJt6HIZJksX0Z1inauHbc0jxl?=
 =?us-ascii?Q?YJr6u4SZ1PUQoqjDzsw80YG0+nbJM2ra6C5Nd8nUVvp/NYh2upDlx8wztt36?=
 =?us-ascii?Q?KTAMaqgSKcH3OYcsJFE5F9qL/PKmsUkrfl133vI/0oc9vsfD84NoyDZpFfWL?=
 =?us-ascii?Q?Klsuvuggbk6aS6Ah4RjG33TS9NgHjsTIohFoHTdDftQzX/txkKlXT9mJeXT3?=
 =?us-ascii?Q?xGy8o+0gtcRL4Os/I3ER2xLUlIB2mIXj03/2xJ1vA0v44pWApSlwUgkpgJi3?=
 =?us-ascii?Q?6O4Tcv6gwrD0rds7QFTDrKBqMAZu/W1fCZuXdHXtgBAZ6KtKlAxFzOPuaBUh?=
 =?us-ascii?Q?yVlXXNN5bXxmttIi4DJbrwmPUeozi1zri8QzKOudr0mJHBp7m/2XBXqyqB1Y?=
 =?us-ascii?Q?gYAAHUxdMJivEQkTTxCQi7cWjTZlhsaAju8HHRb8tHH3ecWVvG1NfUbMYZzs?=
 =?us-ascii?Q?XAzT/LQ1FEsCU2HAakGHBsVMlacW7mWUIbBtlWVH2hftJ2AmMO0zfP0A3SK2?=
 =?us-ascii?Q?mO/yiJCLUo8bYGIed/b44hAH4yymL+ptm6TpAWB+5vzHwBggy7OfzznqNX29?=
 =?us-ascii?Q?sM6M9pYkhnWdDbkHblKLLyJrwVVxkHQ9NjWH9jpNT3p/Qlqd0xkNYNY561yc?=
 =?us-ascii?Q?S6aZ9y4LhFc8JHceG9y8ofso53qwNjYIT9arp+6tBjLuOkbxLTwR8c4KUBa6?=
 =?us-ascii?Q?0YOfCJXhoqPLGKWa3chVIvJG1lJpat4mCmekpYcT3CpeeeXXSNYMdbJWAhT/?=
 =?us-ascii?Q?QsKkEcLSnH4l4vcVg7ytr4Le40TNtGXWPnS77y628+ep9UlnDfUtQcW8NEBi?=
 =?us-ascii?Q?BgQVWZHxp1fyG4lK/dF1h7+gGKhKP4xuJOV9HMw0zxVLqOjg3Z5kzxS1RVZT?=
 =?us-ascii?Q?heneZ2iCPtADFYX379dvYACVSxreKLTSLh+kDXccRYvfFrRLo9Os8wtywG70?=
 =?us-ascii?Q?qKlu8Lg8FgkkLvPfwlyXJnb+5R79E+1w4TaIpudsKGrZLeRcCTy8X/wZGo9b?=
 =?us-ascii?Q?nfI/QxrehnckPi/Pe6HW+eF8VW9ZRDq6kzE5SFFHVr2NTmLUFXWUUM4s8Vlm?=
 =?us-ascii?Q?vBO1BGhKaqcc++Fv8ZjdNtOzr6Qy1SZk8smMyTxfFXryimU8q64JaSVHZP7E?=
 =?us-ascii?Q?+YMsvGsVD+iX8cgDCWzklzxOc9YlXY3nWr6+E2HxNxSujiVTLx6AuLtM2t2j?=
 =?us-ascii?Q?Mrkskx8VGDIk9JK6OREI/vmkih/QL2rWWdX94STIVdMa3Ijgzgss7yy2fBbL?=
 =?us-ascii?Q?bAuqERfLFE0aSFCQ+tUVMr/+Wz56/eYm3F0S/x2oLxC4t62T+oVfJbEz9ziQ?=
 =?us-ascii?Q?IHfi2SMCeBHb2ohhzLlq3KTs3KB8KkJ2nZNvJ0YvcgH8ePwABN8B0CujW7qG?=
 =?us-ascii?Q?DDA2P+R6z88aDZB01BFYD0p+ZcT3OCnWX+sy8Vv/1gxHX6dU9E3vbSvrrJ6H?=
 =?us-ascii?Q?hoCRdarICw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707828a1-3444-43b3-ca8c-08dee2444e91
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:40:14.1836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lcm3XfG0+acV78zm06x227yCl0dtc1wrh6W4hH6qngDxWBY01xwUVhqL3MrtCsHWwUnQ1ZBgpBE7K/6JvHd0eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
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

On Wed, 08 Jul 2026 11:56:44 +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_add_linear() is going away as being obsolete now. Switch to
> the preferred irq_domain_create_linear(). That differs in the first
> parameter: It takes more generic struct fwnode_handle instead of struct
> device_node. Therefore, of_fwnode_handle() is added around the
> parameter.
> 
> Note some of the users can likely use dev->fwnode directly instead of
> indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
> guaranteed to be set for all, so this has to be investigated on case to
> case basis (by people who can actually test with the HW).
> 
> [...]

Fixed a complaint from 'checkpatch.pl --strict' for patch 1/2.

Applied to misc/kernel.git (drm-misc-next), thanks!

[1/2] drm/imx: Switch to irq_domain_create_linear()
      commit: d91748f683693be386fa127b7ec25d2a366b88b9
[2/2] drm/imx: include dc-drv.h to avoid sparse warning
      commit: 68952f1b00736f91867939f50d7b78c08126caad

-- 
Regards,
Liu Ying
