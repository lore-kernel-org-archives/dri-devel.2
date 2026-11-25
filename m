Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520C606A327
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=irHPryiR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8B910E841;
	Wed, 25 Nov 2026 12:59:25 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA5B10E841
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SF5YEUPw+0GdCxyZaMRbGNiFWzNJLtmuI9/5FcA6PY5o+c0uIIJyiW/xLg7YncynMFSOCpUkpYNlu5KzDamAGTiaahNgMIaTfjS8bUa66Wlybaxanalnu8JuQooFNomyo+jNoKA/pmc6FPHgxS/WLSVhMHHd+RPyUWOGYWmJkjIyhFuLAoIzK7feQoAjGx1UHr3BKz849izZa61dDp2m4P5oZk0LUs4Px6wMDLMYxPEBLmGiEGRM2KJeeVlRA20+hb0hga+HDzmWC6gFKKk9FrZ7e4kJ+Q45I50wDbDSZviL3pEON6RSjy/hTsc7LPiBw4tmSmp6OH9k4MWibnblog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyf5Fy+eAguGcpbo1MSEhNPOPjk7owKhBujRxu/OqV8=;
 b=wSbGPtQkjo5PxLrkBIRZz3Jm3TJ/HsHSt9VW57cPs4gOkvbw6jqjLOebqERCFK7O+DOC3crSLqO18eXg72gNFmmoXMKdfW2dGjbcvtac0bcSqQIx0HIshtwSimTdLrbX2S+C9sYO9DYOo/OdmG6PMWobla4zxlvuCl4P9HxrFCOz/idxrpkgS0r0w/+7kH0h7yGOWpDgPF59DU8CGBkUA3mLsjQzjz7r/kBbUrtqtKobCpkUP83WgP1Y7S3VhJVbaCJp+VXjeaPOuT9LJ2CtPcPjTE30oJbNN1y1Bt7YBiyzCMAtA5hzRYZds8W9j5t+tuLa562Sf2MR6NG0TZC/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyf5Fy+eAguGcpbo1MSEhNPOPjk7owKhBujRxu/OqV8=;
 b=irHPryiRiPCGxoXB5pr1aXAG5r4fQ6j3J3hs9GZvr4rWvj8lulBa5eTGlKxtfG82Sxs6gpNxiBTfRoJUmB/yA3o+i+TJFI+wJTfg8BbBNvl/FUFuV8jqdMIzCC1mPd5c44cAxBXRWK3DfGPpSF72+iA/Fcahp+ySuJkHPILxRSWGkdDNOJiQsjbfpRHsnOqXU57CbpIdvX1Cr7HK2jBVRlr6Sh25dMi80n8vxKQy1LJRuLd93IXYHOl8Gp89FfujYNRCv0S7k200PTqdlsBFtgsUnnXB2iGPWwPqa+ebEPNhOmGrLbN1pblpZSlgULZCQA9thU/SUp3i8sa5BmNA+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by VI2PR04MB10189.eurprd04.prod.outlook.com (2603:10a6:800:22b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 12:59:06 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 12:59:06 +0000
Message-ID: <5892f6fd-8bb3-4f46-9b4b-daada46f98ee@oss.nxp.com>
Date: Wed, 25 Nov 2026 15:02:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/5] dt-bindings: display: imx: Add i.MX94 DCIF
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
 <20261120-dcif-upstreaming-v13-1-966ac248773f@oss.nxp.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20261120-dcif-upstreaming-v13-1-966ac248773f@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::8) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|VI2PR04MB10189:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b13f6b-5819-4db6-28ae-08df4af3e35d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|4143699003|18002099003|6133799003|22082099003|921020|10067099003|56012099006|11063799006|261102123227099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: rthWXvSnW/4+nvMBprQbCja4/00fO89AMyizJWfnARk13KnYvM3UN3XSapp/z08pAfutqWIVNp4rNjpizhInHMq+b0BkVnUNxxbRsF4YO54XRmrx58aFvsz5qFDZ5F5QwrXwTRZHmqcdlVpzaIh0EEq3yQCy0BRXbRdmJaBD0SIJ+h8KrNtaxgsDMP7XkoSXTWHljhc3sTUTZh5xkvyGLxji9lt2X+4UwCDEdm6p8Qx0y04Lp88uLa/GVdpiZlDGjmAgu6SiHkgJTdVJZwm8oAg6i07q/vuYdzSqRFQZO85bmYQNTX2/lym/eHOie1PUn5M/Hn0iOCYgMBeIkDNX/RXaIFWYQGDCnPGc8KJH42N2iRLK322zBKn1taD6dg55o0+f8eJ8misZeaHRQjrbJ0GsnndHKZBFlZlXNZ+D5ppbSYy4RazHGV26f6C27cQV3PPdNPpvKseEe7WSfJnBioQ4+700KTY3dQPgsxcLr9aUSIRwlINiBgQibY5GcBEfb3f4W9NyFT9eCds/7e8ye1H9A2q7v9LhRsRxYb/jjzHZFKXp5hVqk41tzzzJk/2SsEJJ4E3k0HZsb6cG/XHuFpyCW07KUCD1jeEbNFxnTuWqCX//Kyf6AUqbQcHY/do2P+0SIDIrVxVRyzZRijHyfimAf9Lj5jwIoCZ0coRVePgf3g9/O/n/qMzJG1D6gX6dviHP+vr6OXX53iXIT75RIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12316.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(4143699003)(18002099003)(6133799003)(22082099003)(921020)(10067099003)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGpFeTBTYlpQZlVCeDBoRkdaUGNoVlpUUEZrZlFnT0UwZm4vb0RZMVgwN0Jq?=
 =?utf-8?B?dUFRWUJIYjY0SlZtR0NVczlpckkzemorSEdDZGUrMWt5bVB1Ri93Y0RGYzlY?=
 =?utf-8?B?cjkwaFBFaEpwQkFyMFROM2lRcFQ5UWcxZkIzb1ZJNDRRRDhZanlOTTRSek1L?=
 =?utf-8?B?LzhLUVhnOUJGNWxTZ0JpUVpVS3JZbmt4TkdsOHdRMFhhd1hoUENWWnd6Wis3?=
 =?utf-8?B?VmhlT1U0UmNFWHRuSmtMdW9jbEtjcFdXSFNLTDBNNnlDcEhMa0JFVjdxRnhE?=
 =?utf-8?B?VkprbzhlRWc4RHgyYmwxclkvazdSTHk5Y2VnYXlEdmxsTVVIYUlaaDNyblJy?=
 =?utf-8?B?WVlCOGxhNFh3a0lLK2FKR2owSlJoRk03OEdoWEkwanpNLy9VRmZBdDV0UEZw?=
 =?utf-8?B?ZmdkemN3bXBJWnhMM3dwcXV6TkYrUkhnU2QvNkNLb201VHBJc2pzSGhBaGQ5?=
 =?utf-8?B?eU9kOGJSNHRrSzFJZXRNZFlEd2ora2dIcXoyVGUxMHMwKzg1Q0xsengxVEJD?=
 =?utf-8?B?WFc2UXRlZW1DN3NuS2tFeFlGVEd0bXJNMnBSUXZUcHhrT0tKUjlNOXA5b3RY?=
 =?utf-8?B?S1JvcDVCNkpkR2ZEbFlFbmtXVWYxZTArSmdSazlkNGQ5R0t4dG9nS0toWVhh?=
 =?utf-8?B?aGV2Zmw1QnZNenY3WWRWaHZrWHJBNFVYTE0wd0RlVkMvSWF6bTIvdXZkcW53?=
 =?utf-8?B?NDR1R21mSG40Mlo3VGV4Qlh2T0hIV01pSEVkVk91WGFjUnFvMnQwNnhENlMx?=
 =?utf-8?B?aGNwaDJZU28zZmVRY01rMlcxZHViSWpSWUgzNHBlblAwTmJKZ3p3azczdi9I?=
 =?utf-8?B?NHdMT0dwMjEyMmdnZU9jQytlYTYvS0RNYk9Va0V3VFcvRmVEUSs0QkdwUlJG?=
 =?utf-8?B?VkJVU1prMXVuSEhaemxJaFZSNHFKT0lXWXd1L1RycmhYbFdIM3BEMEZ5M2RS?=
 =?utf-8?B?cUI0T0NkTmVOcXpqaHJ3bG9XNC9WSmZ6UkNUTE1SL3FyczJEUXhzV3VERE5p?=
 =?utf-8?B?S0xiRXZDTVlpSGUwM05CSFVkVGtwcXl4RndqQUxya2lBendnREhKUVJyZEFk?=
 =?utf-8?B?K3paK0VkT0crMmZGZEM0dnRRZ2Nic1BFWHRvcmdYbGtJZ3Q3NXR4aEtXTDl5?=
 =?utf-8?B?THVOQWJjRkpWS2pyQWhtejdxWmF1MVJRNGxSTkNJREJvQXdEZmI5NSsvdVll?=
 =?utf-8?B?TDJJektvaW43TlpkTGphS0ROYmJQWjhPNFNHcXg5Um9UVVJ6QVIwQkkwclp4?=
 =?utf-8?B?c01HeHJhL1pXRzB0YSsyZzgxdjhLd3NpWnV6U3lncHQ3bTJ4d2I0UEJyYzF3?=
 =?utf-8?B?cG1yMWhPN3pTQW8yTXpxMXRiU2djb2Iwck5DYkR6eDFEa05zNi9QdmVTM1Ft?=
 =?utf-8?B?S0lSa0NGRkY5VzJjL0hnUnBmUzlHdUdQOU1HQzZheE1VYjRDd3F5eDBLRGZ5?=
 =?utf-8?B?RXQxVUttMDNUVkRwSkdrZDkzSGhtSlJWRGNOeTNMYWlWdkdoaG1JMTJZRHND?=
 =?utf-8?B?RTliUC9oUFUxYzk1WVFJYVNJZ0ZaMDJNVDRDOElROXFOMmRPMjdNYlBXMWFv?=
 =?utf-8?B?L3EwQlVxMXZuUkZ2ZzJySDRIb2Qya3VMaklVTWJKNUd1bWQ5cENHVlgxL1NN?=
 =?utf-8?B?ODRRVmhYNmxJWFRSN1lKSkhkSGxHUXByUjUwaGhVY0xQdGVOYjA2bVZxZXdL?=
 =?utf-8?B?RzdlZ2JaWTM0ZkZ6QWsvdVZDQVlFbTBNMDdteTNnZ3o3KzIzOTErekhmcHd6?=
 =?utf-8?B?ZkdkbFF6RU1aMmpvcHdPSnB5VHYvUnB3OHJCaWFkTjBrU2NyM0pXVFpJTVJo?=
 =?utf-8?B?T0d3VEdLTG41dG10NHJzemV6UVNOQnJMM21lMERVb2JOcUMwejlwMzdZTm14?=
 =?utf-8?B?a0crM2JvYXhyc3hQNkZSUzFEc3JoQWp1N29ibmkrL0hPNXM0eXJ3WCtVRjJ1?=
 =?utf-8?B?U2xiS3RVZ0FNR2FvVk8yckt3dW5Da3RMUWR4bU85ek50Yi9XMlMrU0FGOEVB?=
 =?utf-8?B?MERYb2pDckJuYkJvMnVGOTBrRzJUZzhsak9rSlVIOVdrekRhYVBhVUh6anZV?=
 =?utf-8?B?RXB2cXRkczRUdndtcWJBdCtlcWsyTEZwT0VaczVPSlFCakJ4L3BNT01nYmNi?=
 =?utf-8?B?UDJRTnNvMlZjWitCV3Q1em43VkpEeFRqZ1FVckdZbVJVd1E3QkZCZEszbVdN?=
 =?utf-8?B?WDMrM0ZjUFpSRTA3Qnl6OVZBakhKR1kzL2FhWUJUcjlZOCtxZ09ZNHNMelFC?=
 =?utf-8?B?R3V0Z1ZTYUFvRVNlZ1IyaGVwciticDVaMjFENGFRdVY3dzNNQXg0dlQvNURs?=
 =?utf-8?B?ajllRTA5Y0l1cmlMeDdXV21kdXJkaWc0MWg1K1RHWndUSTc2MWhrZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b13f6b-5819-4db6-28ae-08df4af3e35d
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 12:59:06.3275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LSXBSnpiFuC/TuENpE3G8HSRlYycEAl4SqcRdYbVOBtcVqvjBeU1NhFmz1l2bTAvXAIA8f93fmJzqRqvOBQZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10189
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 14:50, Laurentiu Palcu wrote:
> DCIF is the i.MX94 Display Controller Interface which is used to
> drive a TFT LCD panel or connects to a display interface depending
> on the chip configuration.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


