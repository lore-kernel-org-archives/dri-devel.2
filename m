Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F89C4450F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 05:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0384410E68E;
	Fri, 17 Jul 2026 05:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KcqVn7p/";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FFF110E68E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 05:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKwHbmfpvnAztNOtDxXdRCt1f8XtqzdmZtyAwgZ5nKRMEqmXM7lD7VJFls1BtmjIaLPpgr6h23r+2j7VyIeSlRoLMhIBoOz4F/70pLlo2gn3ZBkOcTiYPLeNSI92xi0BexdA86hYQm3d5U/lUGEbz/zCjuJfrpa2Ul9mln2Zj/OfcTkP7X+WOTovfjliJeUsfg04TV3Tf1SZoEPH7UiiLZ+Y5+DgZMlcE2wroIOm7QX3ryYdYpb0x2uvwImYcHJMdsTSdego5zMIqPCTB+F8bM6BVeo5xkAq5lXwC7iglTDuD52groPdISs8uS0WchvDOjCrkfov/YGCQzq850yBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2oH9RMxJ+HLki6OWzn26MNj4NPe/IbCtbFeJkC15wg=;
 b=dCmBX16ng+7IdeDVaxn6zBBnG5DCHckxhEtCulF/bXMZSBqYEqg5+MQbRf3RUgVvO+Am0CKpKZ4RUL1HgpSmDUw9RffnyAvG9rTi/dnqLNgJnbK5VSxRjw3NRsUzY1aWRbWOK2ju+9YGVsc1BEnm+ge76SFjRY5FOgB/osaPJPCnFQZOJm5c2hGd9f1uDIwguHnJpNon4Lx4AKuyqXYW1z41vZVwtbln2ZDSWvGt4+Px3xCBjIRVPeYz+K3hoqPDnS6bvqjmFJdz4WsbQIH+X9dbtmjQ+puOJnzA8uIAONULk5yEy/H8dmTDlPFM3uUxmSxYkIFBFqLV+/w2+wYJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2oH9RMxJ+HLki6OWzn26MNj4NPe/IbCtbFeJkC15wg=;
 b=KcqVn7p/gHqZ1cz3spUD3qWf5u1zizUx2fvza8jQmxFrM5LBbkXoaRhUvUTBFsXA0UiigW0HhLHJoCUOrxS9mZqlPFu4k3n9CnXZByWkPxy0wDXyW2mir0p2teDPqeF9J9kx8KDJK6OvY3FihEpvHMhxp6in3seaLnBGuyCdBUHYMH99AHXdtlg/kYhbeXbMnLLT9NZU9wFa/NLMjqPVP43uTt/hJSe0ae4//ol+1DS+/xAvLWr4FT5k8cYDoDusbSmxHag51h2wf8ALSAm2qxBsBgdzC+lvj44dM7EUtF7mldHp5zpFSEiVhxidJE8PmbjoBkZbHKoiqb8IX/P1QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by DB8PR04MB6876.eurprd04.prod.outlook.com (2603:10a6:10:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 05:28:12 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:28:12 +0000
Date: Fri, 17 Jul 2026 13:29:41 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Frank.Li@oss.nxp.com
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Robert Chiras <robert.chiras@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: display: simple: Add waiken,101wx001
Message-ID: <alm9xSAEb2apN3Uh@raspi>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-2-da797562636e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715-dxl_lcdif-v2-2-da797562636e@nxp.com>
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|DB8PR04MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: d675085b-374c-4b63-0694-08dee3c43171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|19092799006|376014|366016|23010399003|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BR25y8Oev8XUWjghrkg6OgKY/hCvxN6C6ecwpuHfPQ2XMqceKu5TppEy6ZUHnWuO21mNp8IwlJFZRTVCzV4oFmNn2dwAGeIczl6Q0gvbL6VxEgkTOox4Yv4B8JnSk5AmfJHahciW/9u49xmoSAp5XKSoU5ygCP9vuAgQ2ZIssi66Ocp+Dv6ftf1QO8EQqYbLRfgJ5/rWXjpzWt8V+90LRLFeMOB1FJElGVNjKi3tVb1ZPEOcQ2N7vchAEzJpqT0m44LgiNjReyG/bUS9ONc6/Xl+vXM+x3snROZ0HfV0U1xosJ9YKjIhKPm82C3izZpkmdaJlY958S/vdPsvyeMDU5qCA55fTkY4qKmnOU9aKfECYdgdgZgXnxAU9xlb+SQLW4UVqe0S/PGXnnqSMJimxeWb9JnejsUxow/uWHZL+ce9W9+L87Ak2bCxHcRvoYK6KzPkwuf6pDkFFeQMxvPfuezjKR2pxXyAFbL0G8PpeqvhOdmJK0MY6+49N4DxVSp9CMKfioQF6N8zpZ5zkQU56xWdiZA8/aeYlioSWsf9ZUuYeW9P50XBBg7DrZnR/hnt1nlTNXPWCLybH2SHl3qhKi+EVi5ZwOndPbsqaqhWb1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(19092799006)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEJGckJNdXB5MEQvSjFObzcwVHBNYU84SzV6S29Fd3BNd2lsWXRHVkxMSCtt?=
 =?utf-8?B?K0VsQjJiV2pYSng4Z0ZaTHIyYUYzVWRrcjk1bDJNQ2d0NmNpby93YytsTmRN?=
 =?utf-8?B?NVZyT2FLTC9sQmtYR0poUjlhNHJvbXRYdEhKeFB4M1pjaWdObjlmQVArN3BM?=
 =?utf-8?B?RDhlT1JrQVgybHc2TkFDYTdWRTZHaHBCdTlCNjNFejlDUlVxei82MjNPV05M?=
 =?utf-8?B?R3Q0VUJGQ0JESWJ4OGlqZEVVT2FLeUo3L2ZSTlpjUW1kN05aWThJNkM1MWZi?=
 =?utf-8?B?VUw1djc2azRtZjdsU3J1dE1EVCswb21KUlBITVlyc2lhN2dFV05SOWQ5WU1T?=
 =?utf-8?B?MkRLazFGejVJMjlFamgwYjRqRHpMZWFxNjMydUU2TUVoUDJuREo0WFJaenhO?=
 =?utf-8?B?ZnpqRTlKOGxJcHRCMzFUdjFXbTRMRDF4YjF1MWxjZHYrem51NXo3VnFCTkRa?=
 =?utf-8?B?RjhpRUovcVJSYUNzSE40aUs4Mm1nSGN3SVNxSDFLOGpoTndmSzh2N2xnNkpl?=
 =?utf-8?B?cGZpWVlnelV2Y1FvaTFoeXd2REEzeVhXNkdJUWQzM3dPL3gyQzFZTDFtZ3Zj?=
 =?utf-8?B?bGhQdHdVUWdaWEFLVS9DUWVyOXlJTnNwQk5tMmdMTGNRbkJmejl0bDNhdWth?=
 =?utf-8?B?bURvYWc4dVpIcmRYWjVBY3hUczlhOHlwaHBEaEJTUzB2ajR2aFVIWFp5RUsv?=
 =?utf-8?B?VFJJSHJDcE9Td0l3YklXTnYwcnMrUjEyVUZxK3Q2WmU0bkpQNllDTWlWL2pr?=
 =?utf-8?B?c2RnMVZpcjhaUDNmOXNtcWJRZVJSTjVBcmhBSzg2VFRpelVVODVRSnZ3KzJp?=
 =?utf-8?B?SXNnbEtZc1Q1MlkvUGJaTm4ybW9MUC9iaUsvZ1F2L1R0SU1wZ2llUmdnUVBq?=
 =?utf-8?B?OGRBZlAwaVBuNTZ2YVhhN0tpdHRwakVkLzNxQnNCQTEyZ3NkVGZ6clh6bEov?=
 =?utf-8?B?UjVBa1hiTHRBWS80eXRMMVl0ZlA2N2xqVkJkWENWT0lQSzZKRStVemQvYlNz?=
 =?utf-8?B?SXFQZTJsYXN3MmdyUGt1MUFUTGpLamg3RW1iZGU3dExJTm4rZ3d0UE56Y1RS?=
 =?utf-8?B?cjNXVGJqVmpwMW9BdVhKMEhiZHl4TXJvYkc0dG94bGpjQnVwU0N3RmpPZFkw?=
 =?utf-8?B?VTZRL1c0UFlWWWF3cHlVRlFSa2FKMWRoaWRJRWg0UndzcWViRmEza25FV1d4?=
 =?utf-8?B?MGlKeWtLSUk1aVFtZ2dLaXJybTN4RGczT1p0UTF2eC9zcE4rOWNhai9obkpP?=
 =?utf-8?B?OUFSbm0wbnZCbW1kWmdOM2E0TDczVnZta3BOMVBjSm1qbE12RXZDbUplUjNy?=
 =?utf-8?B?RW95YmJUNWZESkNqNXVHTGloZ3Q0ZEJBUEhiMkhrK0xqa2prRm5HckdOMTVa?=
 =?utf-8?B?eE9jZllRZzVrWlpoSFp4K0sreEEvTEFiajhzSysrS05vMFpQZC9wd0cxbnlF?=
 =?utf-8?B?blUycVVvNkVrcFJSdG9jR3lIVGQvT0cwNFNrZHpPRUg2R0NWUWxGcVpnNTR4?=
 =?utf-8?B?THRLZytsRVlEY0FGUTJFbEZLa3FGZ3lKNDNJRkUxMHJoa1REeWwvR2V4Z2N0?=
 =?utf-8?B?Q0ZUOWw5VjhvcXFsU21Eb0NrazUxTXcxUjNPVlZ6clAyVVdBYldIeVZJTEVz?=
 =?utf-8?B?ZStYenZDVGNRSXYwVXp4L2RDQ3pGUlNXVHdOejJ5b3lHczl2cEw4VU5JbHp4?=
 =?utf-8?B?aS91dU9IWFdITGxXdm9RVXkxNWFRbk1YWkc1NWRuQXVqb0dhQlMySXlRemFp?=
 =?utf-8?B?b1Brb2hGS2JvdWRRUzYvRC9qcWtWejFCWHJPcFozNFcxckkyRkFJVmFNcUFm?=
 =?utf-8?B?QWlYWDhmM1dFdE9XTVhac05wdzVPM3lNZzRNb29vTEhLaFNlUTdDT2dVcDNo?=
 =?utf-8?B?WWtmVWNER1N5ZjBIdWVRMDliNjFuOVd3eHgrMkoveVNyWGlUTWR0M0ZuMkVN?=
 =?utf-8?B?dDhjSmNJU0RTSVg5VXdmSVZaeW41ZVBPLzNlQndrRGI3STR5TnJqRW5pZk1h?=
 =?utf-8?B?TllUYmJlbklMRUNWd3NzT3BGRGhQdzBDdjd2dDVQQlY3QlZJTVlGdjhoaEp4?=
 =?utf-8?B?a0xJTWg4dm9jUEVrdzZOeTluWWtqVEZ0QnE4eWEwSFZWcWZjZEtuRnlveHVO?=
 =?utf-8?B?VmRXb3Rrd0hNK2N5aUFtUHNjMEROZ0JmR0xjSEFNVWFuNUpPZ01PRU9QSjJF?=
 =?utf-8?B?MlZ1cG1nWHNvYTN2N1lmVmxUMjN4N1VBLzhzY0JHVnpEL0NralZ1RmhZQ0Jn?=
 =?utf-8?B?MDBVdzUxbUlBMUUrcE5OOER5aXBoUWVPZm1oTmFlTFVVb3lHc1hSRUFQcWdB?=
 =?utf-8?B?OXFJNmVrTUxTQmtMRGczVWN0bWc5MkFnVGQwYy9iTTM4WjBvcUxEdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d675085b-374c-4b63-0694-08dee3c43171
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:28:11.9486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLlZDaKqXPXCodUQ4oaoJYJ6/tb+8GKMZIj3ZiHnpUzCFpYsasEEvWUtNiudPJMgg0WRa8XMESQM5ePRF4F7SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6876
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

On Wed, Jul 15, 2026 at 02:34:47PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add WKS101WX001-WCT panel, which is an industrial-grade 10.1-inch IPS TFT
> LCD capacitive touch screen display module.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  Documentation/devicetree/bindings/vendor-prefixes.yaml            | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 21453f0d7ce22..01da44ed3e20a 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -349,6 +349,8 @@ properties:
>        - vivax,tpc9150-panel
>          # VXT 800x480 color TFT LCD panel
>        - vxt,vl050-8048nt-c01
> +        # waiken 10.1-inch IPS TFT LCD panel with capacitive touch

To follow comment convention for each compatible string:
s/waiken/Waiken/
s/10.1-inch/10.1"/


> +      - waiken,101wx001

Commit message mentions "WKS101WX001-WCT", so can you use full model name?

>          # Waveshare 10.1" WXGA (1280x800) LCD panel
>        - waveshare,10.1inch-c-panel
>          # Waveshare 11.9" (320x1480) LCD panel
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 396044f368e7c..38d6765ed62ed 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1833,6 +1833,8 @@ patternProperties:
>      description: VXT Ltd
>    "^wacom,.*":
>      description: Wacom
> +  "^waiken,.*":
> +    description: Waiken Technology Co.

Home page[1] mentions "Waiken Technology Limited", so use the same for
description?

[1] https://www.waikentech.com/

>    "^wanchanglong,.*":
>      description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
>    "^wand,.*":
> 
> -- 
> 2.43.0
> 

-- 
Regards,
Liu Ying
