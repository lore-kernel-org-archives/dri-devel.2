Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053B0FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCCCF10E0FB;
	Thu, 30 Apr 2026 09:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="C1viHSKl";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A996A10E0FB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGZk/QXuu2OUOGzXPzze58TmeMKsjuydILWdiU8Jly/7U9FvE/PDhSZ0ZY9RvRKaOYgqt+x5C04orRSrp8n5nOexpfVSfH4Dw4noTlQTc/V+Sz2WMlGRLIUVbejKxD1UmjWe3cM7siufRdu34pLIEJhcN5OtzQTJShV+xFBr1Zv1SY1mblzQP5yH52hU04XFTs3xbpoe1oxV7vNqNO+wk5TUCa4ra7ObhyIwQOPOZh+/V7Ohk97+t1zwbN+Xxnz2BLmyaNUiu345SznSMIjSGZg7qhv915XZhBZOhvE2E6ygVkG2ArNMfiJ5+0CMW6JfXaYJq6/YfCTxfuWL9yNLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0fJ6hyJBzrIoyM0S1bpBMnJS6i3WLAb8h398kBtl60=;
 b=EPe5llfsLFsWy+g0gRVU6lmMn3oYmR7m1Y8RZLE9lGubRppjAvp16M1JePOP7WLmRlC165eYDOpYA86PlncV0Ev+1zD3WcpSE8pulQnlXPgK/ZPfDvcMp16NztQHzLZ5D9wIeU+IsWO1SIvakbs1z5kiaEZss0/5OmL/mvlUQ4HZWX0tG10+hOD2qXX78Cq8WPWZf8AA8Gt/1jFBOqdfieMAYmEx3sLISjvp2c4v/ha+MV4LbiyATXvIJuDzbyMhYvzJOLzOg810CI/2t8HrYGJOTaxqOWYtmESTT1PElkaeuBw0QW2Oh6jBZWPiWRQ/On3+Pq5PKghHbAGAJzgeMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0fJ6hyJBzrIoyM0S1bpBMnJS6i3WLAb8h398kBtl60=;
 b=C1viHSKly6jz15xpUm/TgOL/x3/KkI3mFJuoFN1nNA3Tjo4+zUA+H+IMycJ0zOnpKxhjMY6nOhomRylDuYDocKCrnOe+I+TNbx7FmulSiRe7RAYm/UgPqJu+dnd29oEkUqOQhc07sbJkIS1OB59TjnIlAdomWtI8A/p2xL5aiOht5rLux6XrajQm2yzUgntZQycIgBI0SM4EjbCJxu3zvvmyVWrGpAU5uIbQbxU81j+5sKh1y2w2/LayGO3FlGerNSctvw1YscpDDDpqYpFu8RmMpH06gVXBMHVbXIj5vjmt8eq64QbGYMH9LM4l7Q93jVSXJ3g48c9NxDUE9vM7gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by PA2PR04MB10411.eurprd04.prod.outlook.com (2603:10a6:102:424::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 09:55:25 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 09:55:25 +0000
Date: Thu, 30 Apr 2026 17:56:45 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Marek Vasut <marex@nabladev.com>, Marco Felsch <m.felsch@pengutronix.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: bridge: ldb: Require reg property
 only for i.MX6SX/8MP LDBs
Message-ID: <afMnXQCRX4WEhxfu@raspi>
References: <20260329-fsl_ldb_schema_fix-v1-1-351372754bc0@nxp.com>
 <crqzju5cqhvmy5msxvuquydmnpb2ft2t3gsyr6qsre6ccqjvzz@46gfcrelczsr>
 <0d7c7403-4b77-42f3-82d6-eaf2be8e5b1e@nabladev.com>
 <excxf6kxwx44kepc22smvvnirptc4kxpubioxoto7nqleqhoiq@ymch4y6dd5n5>
 <bc7d5955-600a-48eb-b897-3928ace275a5@nabladev.com>
 <7hysu6kamrsltsfcp5hyx23o5nbqbds22jhv65266w2qmps6ft@4tpbs4gfnzx4>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7hysu6kamrsltsfcp5hyx23o5nbqbds22jhv65266w2qmps6ft@4tpbs4gfnzx4>
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|PA2PR04MB10411:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d29a1b6-bb35-4558-1170-08dea69e99b0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ujQiW075ld2s3HVwEBsLVpaVnEFz6fpUidmR7f7xPFROKOHoG1k5VOpBH3+WRNL5zTZyWS/oNrTJ/UO+R/ij9XIVKkUKeSxQ1Bdpy9GZ/WDwOYGYwmGhvTnsJDnCeecl5k+c2rI7TlZmqftx2c3cWuN66h+3KT9kGHfnqMill1HOZ64LzerJLDuNXt09ijZBNOWG399jPWYDnuYmRArlKLigGY5bXwAOA3bX+ZlRDjodC6N3G9OJqjwwP4ZSa3cpv2R5Xrc8b3op7QpY6gs/Fx0nNXX+NS4b9pzcbf0/YDLwQQcGJyWp6J549mbGcHoH6L6e2PUtG/u09r9UUBJlTSdNBBFj/WxJbnSZs5UEhLU4b/1xs8lYyHz/aENUXMdkW4tkgRdTV24DIfBEWsSUx9n/RbM+i65Dw0CY+BPwfQLjt259Ktmld++ocaorHUVEz5TWx0HHgPVS8SWuy3zuq6GjE2paW0c70aKwnCy3plyTq6SR8tvKSewByf/6DMuVGq512tNREhKgOdfox8eVfPoYp28EQowcsif3gdNmLfEqSduuqm+GT9AvtJqJq6weEDCvaQPHM9QosVD1uXormAF/oUiKg5rbUCAaUy7LD6Tm1ATJn0sCKrABZn1Q78ZhSfvsVSFl2MFaDou31sfAanRDpARj3amSqi7c1AjQuuwsjAnmBtGtC1BdROgR8rJs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmpucUlzNHMvSTg3YzQzYXNnVC9rSm9SUEd1Zm5VYmhYR0hncGxJWlFIdEk1?=
 =?utf-8?B?ak81Y1Z6N1R0TUdaNThUbm1jTXZEcjJxb3B3OFdaWlVBTmo4VlZDQnE0MnJs?=
 =?utf-8?B?VEJLUjNEWk13OC8xV081ckwwVXFiVlo3R1krb3lOZTJUU09qdWVXVlhOcVJl?=
 =?utf-8?B?eFROWHRmcFlKeWlNaDF5NDk0akhFYVVhMSs5bFJRU1Fmc2VRMFMyUEF0K0Zs?=
 =?utf-8?B?bWdTVWd2YWpURFJsOThZYkVuYWRlRDEzMXRRTWNtcGFZV3dERTZnQzFwOFJL?=
 =?utf-8?B?MExFMGZQZ1ZqZm5JOXpnN1ZDK1REWURhVHB4WUNQU1kvNXdtRG5FclpNaDZC?=
 =?utf-8?B?NmFBR2pVVko2alhuaE5MMVNhRy9NOGxFTklFeHg3UTRnZG1QRnhYbWFRTEp0?=
 =?utf-8?B?Q0tWMHVoT3crZTNJNDEwY2l3L01nYTRRSGpSU3dKdTNUWVV4OWRxVGJtVGdS?=
 =?utf-8?B?aFRZOXlBQ3NxaFYzNjJUYzZVZTNwZlpMSUJERHBnOWpLdDNpV3hHdUNFMEhV?=
 =?utf-8?B?NVRKdy9SUDJGTDdkY3RKVy85VFdzbldDTmlWSFBheDJHVVU2MzFGYUQxSkMr?=
 =?utf-8?B?eFdxcW5SUCswMDlHNDFKLzFzc1NodWJScjlxT2U3NFNQNVJMUXlqdWNDdlNT?=
 =?utf-8?B?Y0RMYk0zU1hsUHEvMGZtRGE4QW9CS05FYTZMRGE2THRoZjJ6N2tvRThWcWRs?=
 =?utf-8?B?RmJObkl5S0MxQzgyMWxHS3NSTklUc0luZXdBUWpUbERRc2dENDJvUzlRWEVq?=
 =?utf-8?B?S3ZLeUEwTU5INkJzZFlXK09TblNmVnp3eWQ2R2Z6WDUvd09wUm1pRyt0V1Rh?=
 =?utf-8?B?OWptSys5SHN2TlRvTUdteEwrNHZPUTIrY2xjT05pSUIyU1pCY0phOFl4b29z?=
 =?utf-8?B?NXJxNlYyYmFMNHNiMWMycjBtamRpdEdPUE5NM21hS2VoYlNRTkxJajY0ZmhW?=
 =?utf-8?B?d2J0aVNKWkhTV1NXTmE2QXlJNlZBZWw1Q2FnTzNIaEQ1aHBNbjhCMkpvcW9j?=
 =?utf-8?B?dWVGQkZSd1I3c0xYMzJVVHVPanF3YUpFczRUU01weWplRjdGWGFlTWQ0RGJv?=
 =?utf-8?B?T0dwZmdZUFpMRzdmZXJCUGJ6dmV4YW41blU3Uk1BWks1dlVHOHVUemxXenpt?=
 =?utf-8?B?aHJNLzFnL2xLZjZSeFhUajBWQjVtQmc5aUsxODFhdTk0cEQxemNVTVhuTmtS?=
 =?utf-8?B?WTVTUlp2OVZSZjk2blZkWjhVeDlZZ3FOZnV2Umdlck1jZUFVTnFObGJxRFVh?=
 =?utf-8?B?cHlRWU55ZXFsakc4Qm5YRkFVb3BCNWErR2dJU3l6NDRueXNqNnFiOGUvY211?=
 =?utf-8?B?RnNRUXhESXpCUW5iVHA3SWZ3NFhPVzBaeERRMTNSMFNmalU3VktYOEUrYXJh?=
 =?utf-8?B?cUVVcWd2NmtEczJRVWlkcHRkbXZWMG1MeXEzK2crWk9CZEZ0Z2NhU05GaXBQ?=
 =?utf-8?B?ZU9TcUw4ZzBNVC9QUWJLbUQ3K2RHY3pVeFRnRFNTaGtKaU1Va3IzcmNxSGw3?=
 =?utf-8?B?ckFuU2tRMWxXdVlWanhkQ0ZPYmkyUjVKVEJRN29QcFM5TG9ERzJkQUFzbFBL?=
 =?utf-8?B?czVYN1Y3RlBnaEdXc0JVQ3p5YkxwS093b3BKQktTOTNjSXg5Q3dDKzhsV1Rh?=
 =?utf-8?B?aFM4K3g3aGtEYjhabDlCOGNwU1ZtdVlUSU9icDZtMmRJSWdpTEFQNDZuSEcv?=
 =?utf-8?B?cUpvbkEvdUxYS2JiV3NrMjJGZWphV3VQV1BSV2xOV3UyaS9kSldoUlcxNm9s?=
 =?utf-8?B?a0p3SzVKcGwxWHpZazVRK1NKakU0RjluSGFPajZ1aTZEMjcyd09HWi9oVGhq?=
 =?utf-8?B?dCt2V1BYTEZuWE90UU1wWEUxOHJjUUl4cVFhaVo5Y0o1Skx0UXY4SFE4dFdL?=
 =?utf-8?B?N0UrTXdZM0hBZVpZUmJGWi9SVUlyamVTOEZyK29ZWkZabHAvN1ZGMVl2RmVm?=
 =?utf-8?B?c2pUek9yQjRQbktlNU0veFpRL0F4cUo0dFJPTkgrR1hIUGxxZzRXSW5tNEJo?=
 =?utf-8?B?STB3SEk4TkFmNGh6WDNNUVBvT2hpNkpjNnBTSmVmS2MweEhURXZwUVUxVXM2?=
 =?utf-8?B?Nzl2N1lVakNMZmtUUGtjU0VxT2hTVlpocENxU0tyWkZXOGt2Q28zeW1tU0Vz?=
 =?utf-8?B?Ym9xbHZlV3hGbXlaUy9jd0FyMGJyQXJwU3hVdUpVaGxXQ2NZV3gxVGpXZGpI?=
 =?utf-8?B?Szk1SWRrYTJzK1ZIUUcvOFFOTVJqNnlxQVc0bUsxVDMxVGxJdm1BN2JsaU9X?=
 =?utf-8?B?OWlRV0xyMUF6bks5aFdoaU9rdTJ2TEhhcUgrMFJwWEw3UzZWWkFZazZBRE1m?=
 =?utf-8?B?eTZaeVFSaXVablJBS21idFdVSm5TYTJGRUdvT2wrcndJSEFpWEd0UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d29a1b6-bb35-4558-1170-08dea69e99b0
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:55:25.1838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPTWqCzd6SwcwVSfQabKp8a+ppO+TZrDKGGZPIXLYagHWs397DPT6/e/ly/QLWh/OW1ohS+dCHokjRmfHeeEqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10411
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

On Thu, Apr 16, 2026 at 01:20:20PM +0300, Laurentiu Palcu wrote:
> Hi Marco, Marek, Ying,
> 
> On Tue, Mar 31, 2026 at 01:22:19AM +0200, Marek Vasut wrote:
> > On 3/30/26 8:29 AM, Marco Felsch wrote:
> > 
> > Hello Marco,
> > 
> > > > > On 26-03-29, Liu Ying wrote:
> > > > > > LDB's parent device could be a syscon which doesn't allow a reg property
> > > > > > to be present in it's child devices, e.g., NXP i.MX93 Media blk-ctrl
> > > > > > has a child device NXP i.MX93 Parallel Display Format Configuration(PDFC)
> > > > > > without a reg property(LDB is also a child device of the Media blk-ctrl).
> > > > > > To make the LDB schema be able to describe LDBs without the reg property
> > > > > > like i.MX93 LDB, require the reg property only for i.MX6SX/8MP LDBs.
> > > > > 
> > > > > NACK, we want to describe the HW and from HW PoV the LDB is and was
> > > > > always part of a syscon. This is the case for all SoCs i.MX6SX/8MP/93.
> > > > > 
> > > > > > Fixes: 8aa2f0ac08d3 ("dt-bindings: display: bridge: ldb: Add check for reg and reg-names")
> > > > > 
> > > > > Therefore I would just revert this patch completely.
> > > > Last time, I pointed out the hardware is part of syscon, but as a subnode
> > > > and therefore with reg properties. What is the problem there ?
> > > 
> > > To quote the DT spec here:
> > > 
> > > """
> > > The reg property describes the address of the device’s resources within
> > > the address space defined by its parent bus.
> > > """
> > 
> > That parent bus would be the syscon, wouldn't it.
> > 
> > > The parent bus is not the parent iomuxc (i.MX6X) nor the blk-ctrl
> > > (i.MX8MP/93) device. Therefore this is wrong IMHO and should be dropped.
> > 
> > How so ? What is the parent bus ?
> 
> It looks like the discussion is stuck on 2 things:
> 
> 1. DT spec argument hasn't been fully addressed: Marek asked "what is
>    the parent bus if not the syscon?". That question is still open. Syscon
>    children carrying 'reg' to express their offset within the parent's MMIO
>    range is a common upstream pattern. Marco, can you explain why syscon
>    doesn't qualify as the address space provider here?
> 
> 2. Regardless of (1), removing 'reg' from the imx6sx/imx8mp DT nodes is
>    an ABI break, those nodes are already upstream. Ying's patch is
>    the minimal fix that respects that constraint while unblocking imx93.

Yes, I don't want to break ABI by removing the 'reg' property from i.MX6SX
and i.MX8MP LDB DT nodes.  And, I don't see a way to remove it, which
doesn't break ABI.

Laurentiu, Marek, can you please provide your A-b or R-b tags if you are
fine with my patch?  I see your positive opinion on the idea of this
patch, based on previous discussion[1][2].

[1] https://lore.kernel.org/all/p7glzm344tiu76zm5aa7qq4lswdcjuqlqel3hl3tr3s2cllltj@i2eyzuux4cj3/
[2] https://lore.kernel.org/all/a4a5284d-6004-46c5-b5a3-f8eb4d9b3680@nabladev.com/

> 
> Marco, a broader cleanup of 'reg' from imx6sx/imx8mp would need to be a
> separate patch with an explicit plan for the ABI impact... So, for now, my
> suggestion is to move forward with Ying's solution.

I'm open to any better idea than my patch to support i.MX93 LDB in DT.
If there is any, I'd like to see plan/discussion/patch for that.

> 
> -- 
> Thanks,
> Laurentiu

-- 
Regards,
Liu Ying
