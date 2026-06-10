Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC622CD98CC
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1CF110E742;
	Wed, 10 Jun 2026 19:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LxnCgWTH";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9310710E742
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 19:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/BpiG297ETHHo3mPdIMCIrGKzzIHhJo/bB/n1U7662LR4iP7VzvISRASrgBc/+fU/VRXEfh2d6IpWlFsMRnu/LkxZ6+zINRDAPj94iYIRmYX2e6HNSnJ+7j0cTbv0gWUym0B2hAKrxWv/SBdi/YJIJr7te0uhCQCH+rUxvIk7+IrN8ohylVlw2qOLxdOin9Y8jMuUCe+k7S0xYtvG+n6syJ+jcnooQYl4ySHN9yECD5fhhT7QyKrvWDgOFyxv2FmimbpxyAsq0vH3SEb6sc9qPxyWnMkVhRsWwAmP7hfsVozX5CinBHjR3oNlloS+mqnumTnhNwea1A+duix1jjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMbxuiCmNvxRmLzwONoSlo/5ti0pOUPbE50y3TtQVAU=;
 b=ncQnmpi2REokEUj/Z6hNlcIUpd7icJhr3eWhAXgmPlK3TfMuwdzHnqEywYknhuoq59HY8zGuB07zt5T0rwryB1O7tW8OBtrrYIGKKUdbR2V9jfYwG6AUWlRbnYN941L6F79G41hqvxPBn2NPQ3K1J5xtfpO6wROukBXfwhaaWq5Rhcl9DKFgniFzDc9aVjt8mnfbe1ZpJKY4mmYq37oYSr9qow9QvoEU/hpGzSk+E73yUQ6Gbju1hlYVaprKn8vg/TIDAtQ3P5taTcDL71irMYgKbSnRaSiD4y7QPjGeutNae+/5/LuS2rEZQpySjo7BUnB+gjH96Aq0o++de42cgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMbxuiCmNvxRmLzwONoSlo/5ti0pOUPbE50y3TtQVAU=;
 b=LxnCgWTHxMrsNvAvYT2qBYtoqoBzDWsyxHYFNrgVkmaZS1dKhukFpvJC2XA1tN3PGYQwCs+JVsy6GzVHyWsohyt9Kw6zX6OVhz8ELl6eI+riNFNFIiV+XPTPKHxkmUNPIkjUmluBy1jHn3fPtmCkVHvp8suhMRATT2WrFpXKOTB+VlssM/gHZ11OrG3JfQm/wwTALonRGccr6MxKYKzjmucqMlcOybSrw2HRqMPDiSM5+9cMu79yWGYIiGGgJEruG3FkyrbhGTO3Oi3lRlzL4SozMkyKRI2PJJEM/CkrWxuk8TF+EA4qd8M5337vAIQKVRgITTGoF3qQXNhq2ZS3gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 19:18:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 19:18:24 +0000
From: Frank.Li@oss.nxp.com
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, shawnguo@kernel.org,
 laurent.pinchart+renesas@ideasonboard.com, antonin.godard@bootlin.com,
 Hugo Villeneuve <hugo@hugovil.com>
Cc: Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: (subset) [PATCH v2 00/15] var-som-6ul: improve support for
 variants
Date: Wed, 10 Jun 2026 15:18:16 -0400
Message-ID: <178111898079.1109057.8610962818602994576.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305180651.1827087-1-hugo@hugovil.com>
References: <20260305180651.1827087-1-hugo@hugovil.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c614a0-6a16-4ad6-8436-08dec7250a9f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: V4c+WiRXM7zbCWu89K3Jv0JjFEcAyy98sB05DVPjOlKlP9UniB4hBwhVSYnXUo7lVFnsV0XJmXW32UKRzAO3JTX0rHDuNBurBgbpN2MSbdQaYGdFWBAhGtP4IsV8vx1LnH+PJrdaDNGeaXxTB6Y+DnNjVkF4MGAC3dcleysLJyAKthx/HecYwlsDJR+JwBhublWSrVupm0CJdStIx1/kZ3TTpsBJauFWCvfDAn71oduFTzgayRUg986r0BrsZYVjvNB4f+CNNen/ENhl+TzAJHMepUcoty0bkVrf0oTh0ZIFyGeXR7I2sw+GekA5TRnUMqjkJfA4NMjs75gm5xRThsQU+ReYpmXWnbmVuI8oi013MB/To5dJ6kF7VKofwGslWBeDq14dotrVuNagqlDQ27UpJ+MnOJLyIsxNoP+YsONxqjM2IIQr1Q4ZOzA++fOUNUCe3Nl4orGum7Ttg00tGJlqwD/MqEJcuTLoyKcobmzGLiz+tBwePYn09HRIgwe95FL6XG/r2Kxibss7w9XpvncE91fTzWaZDdfWkrcz73f6AIqk5CWZDZqTkzbRoiCIdFq56LM4IoF8ULYogDK3fxGG6XnBiu7WMpp9PPIHOLCIhQafH2z6IhjAghbIBc5apYwzavJGUMOedbTrPeAEQOPsiAeyz7owTS1OSFhbmTHcu7f5XABfF5OpRwyNW9hh0osP+nssXBW1oYYMtxVzvt/c+5kgBimgjcIjWv3vbfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(921020)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2d6QUxwOGNiTlpHUWlZdlArTEJlYlhIUkE2d3Z2SWZmNk90bjVBdGhTSUVa?=
 =?utf-8?B?dDFtYWdHcVdVZEIvSndKeUFLZ2JOVnBNY05kWnViT1M1RENtalBRdElZalhj?=
 =?utf-8?B?ZE5JZTVucDZ0MDllRlR0SzhZZmVWN2lSazdCQm1WVlhFTThXbzhoaTFWNWth?=
 =?utf-8?B?RTF1Sm41VFpXMW9xdmZzZGc2RzF4ekp5Y3Y3RGIyazBXbkdLbFV3Z3psZlZn?=
 =?utf-8?B?bjZ0M3NpZkRpdmhHREJKYVliZzVSNVZKaC9KZk1iTEdmUnZ5dmt4VStYLzRq?=
 =?utf-8?B?MFNCZUloa3crd2FSRlFsakdMWUJvbVNncTFYMXRqLzNNY2MySy9HK1RqZzNw?=
 =?utf-8?B?WE1zdEVPaEtPcmVyb1h3UEluRVI0UFZyY2JKZmFoa0w2YVVIcjJ2L0hPQ1V5?=
 =?utf-8?B?S0pQYnJuQTBBaGdacXpXbWpIVGtLTjA2RjdyeVdxbjl1U202bEFFeG9kWE9U?=
 =?utf-8?B?WGQzNy9PSGRtS2hxOU9peEpxRExjR0dCYzNIUXdTRExJNUs3MFZtM1d4MmFF?=
 =?utf-8?B?ZjhkeE52UWkwSjkxY2x3WURkTjJEYWVDUG1ZZUkyeXZWWUZCSzArSngxVjFK?=
 =?utf-8?B?Zk9hb2N3dGlaWFMvNDA1clp1ak91bXZoYXUzYTR4ckNqN1RGRlBzMU5hUjhl?=
 =?utf-8?B?MWpzYysrTUkxTHVvWGFXbER2RldCcm1wd1pxU0RzUExEdWJ2Vlh6MlNsREtz?=
 =?utf-8?B?ZW9zdW5FL2pLYzBwSWluajNMUXcwOGNMbVhkeC83bHhEM2VHSnFCblVXM2sz?=
 =?utf-8?B?ZVppYVdXaWxNTGhRVnJReTFYMGpmeTh2WExIMldxZ216ZU9XZG5kRWtXZjlv?=
 =?utf-8?B?M2wweEhRVmhQcFZGNi9LMUtocCtuajB6cHRkekkzd1l5dHdEY2xyZ0FzYWlq?=
 =?utf-8?B?K3AwaHB1a1RjUWhtbGJyNElvVW4vZjNRUFV6YzdQTUhGNkFlSFYreE9xVWt2?=
 =?utf-8?B?T1UvMWdNOG14ZHpDMWplMU16VDVCWFFxWkQ5RVE3bFFxSFd5dzNzeldkY0Zq?=
 =?utf-8?B?dXdNRHBiSkRvNlVqcEtjaDhCbXNOcFFQMGdNb1dMTTIxclY0bHgxWWlsZ2dt?=
 =?utf-8?B?ckEwWVdrbEUzQ3ZYYWVDQTJ1ZG9GYVMzR0ViYVBDNzZaUE53UC9lTUJBS0dm?=
 =?utf-8?B?ME1DVFZsR3dRSDhQbXpxdG9HRmtTY0wyWnE2czkrUUNHRmRYSHhFMzQ4NFI1?=
 =?utf-8?B?WXJtQjBDclRRbE45TDUrb3JlQ3l1UmhuV1EzR1RpTWplVzBYclN1Mnhmd0V3?=
 =?utf-8?B?aDVJYk9wYjlMQUg2YTFvc3FEVlY2dmtVeWlsYkhkdGk1b0VqN0h1akhrTCs1?=
 =?utf-8?B?RTdCaEliOW5XQnY1Tzd3YkR2U3hrSm5yemp6M1FYZ2RqcWVIdHB5VEUrbDQy?=
 =?utf-8?B?REczOHRtTDZ4OWFaOUk0QkRVSk9SeGdCNXBqZWFxaStwQ3BXKzZGZUdjZlFk?=
 =?utf-8?B?U1pSMW8yTGZNVVQ4OFV1MHBLQnUzdVVtaitjakZ1aC9YejBpdjRaTFlYYmwy?=
 =?utf-8?B?MDIvcnVnOUVIc2NXMFo2THo4QlBrYytBaTVUb0xEMjdUb2k3a2ZEd2h3eGNC?=
 =?utf-8?B?czZORTZpbXBHSEtSRlRiZy82dG1BWnlFamhGalBEU2VwT0dOS3ZXV3VCRHBa?=
 =?utf-8?B?dFY4YlI0Mk9OSGhKYUZ1QTVYbGhBSlRTcGMrQmk5MndFV3FBeGtmdWpTNjZL?=
 =?utf-8?B?REY3dXJjUHF4c1NlL1F2K0NpVlJHaENRV3dMQjVCZHoyQnVBaWxDODZQZmhV?=
 =?utf-8?B?NU40RVY5R1Q3ZTNTYlNIWUZtRVY3V0M1d3pObC80eGhEUWd6M000TFVRRVVS?=
 =?utf-8?B?Ymh2UkJpaTlKUkJMMFNKMlUxOTRzTlh0NWYrQzVuSnFZRUw5YnJzUnkycmpv?=
 =?utf-8?B?dDZCZ2h1dkVPTUJpeWZaRUQvMm42UkU5ZjF4dmc4SFFsWnpnYURPcmZiVGpw?=
 =?utf-8?B?ckFMVVBsQmR5ZldOUGFGdnpOclFnVEN3czMxR0xPNnZSa2JiQjFjNHo3UDAr?=
 =?utf-8?B?d1ZHVVZ4aXR3MUdCSzVUMHhsdUZEUUY1Q0UyNi8xYVFEZ1NPeVBGeHE2NG00?=
 =?utf-8?B?bUxibkwwSDVhT3VsSGg5WGNyc1NFbWw4Sml0M0Y4cmRGbjM2VVBNMlIvcFY1?=
 =?utf-8?B?NEtIUFNOeExFMmROUElibm9BZ3crcWdxaTdtNE51ekQ0clZjbm9xT1laU3hF?=
 =?utf-8?B?ajlPS3F1YlZWcHNOVFZNMXpNOU8rbUlrbmlvbXZmRVVXRjEwTUtocDZBTWQx?=
 =?utf-8?B?YXowOUFKM0NoZnJVTW5NQ2JIME02b09mSzVsZEdhTVJTUWZDK253ekxQbGYr?=
 =?utf-8?B?cmZUWUpjU0pkWTBiZWpOcENvUktqVUlWZjNxUGQ0Ym1JNnp1U2FwN1NlRUhQ?=
 =?utf-8?Q?RE/mu2avRGgUV2YEH0qHzzBhTfTMfborH/JJK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c614a0-6a16-4ad6-8436-08dec7250a9f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 19:18:24.1349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooOWxj/yGEdzHPhhplBymIIJD2+EG7TSi66lQPpruKU7ce5TjwlVjnUVIXm+jCqVIFWB8lEy8NRzkvdf24pmx9VzR5/v20Oeap0nBQnqJPsPEqM35OFV+U3QBAQUarvk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689
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

From: Frank Li <Frank.Li@nxp.com>


On Thu, 05 Mar 2026 13:06:15 -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Hello,
> this patch series improves support for Variscite VAR-SOM-6UL based boards.
>
> The first two patches fix DT/dmesg warnings.
>
> [...]

Applied, thanks!

[14/15] dt-bindings: display/lvds-codec: add ti,sn65lvds93
        commit: bd584193a91ef2e190a2cf19f9320387fda1a21d

Other dts part already picked by me. This binding have not picked by
subsystem mainatiner by twice ping. I picked it to avoid CHECK_DTB warnings.


Best regards,
--
Frank Li <Frank.Li@nxp.com>
