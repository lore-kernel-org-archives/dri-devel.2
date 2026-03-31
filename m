Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDC61061B2B
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 02:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7507110E7D4;
	Tue, 31 Mar 2026 02:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="P8Kp0SC2";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E08510E7D4
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 02:00:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2aAgOEqex8RQGhBt1WoAcyzlDH48YB/ajq2KJx+i6rDkWxW+7vR8NHHxt5pLNvh0FkLHtjgX55ER726lQHXQz87jkxhBDgYIjQ6E5t86U/AG881rONouPc6rwJkur8vvbh2DOFzMgKOkb6GOGntUnrOrQtSKsjE/8+rAz/AM7kLABvTPvl9DE4fxTCi36GoT1vdiZ2aReERXLsvxKhYWY4XMzUpJWfVJvvG7PtJDhLby0IEfiiGP+QMfwY4wTFwa1i93ksNkaDfqR0Q2S2Ir7hpztzJG+Wrswpt7mUqU6W6hVSP2SSXroZuoFlSWlWYdDnHSkeA3ACxZA0uMOOiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reWl/ZaeWVQ/kZ84F37Yq0DJTIipsCrbCjtTnfFzDMc=;
 b=ltTfJIZwR44JnGjpkqc7OXjGkCRAOEdSDUgobrL6ME7OK1D2wjft7+aAZY3vJaijPEjik3L1ZYHG5CuLsD/CUSVs6i9fqj1i8W8l3lM+tK5kIg7klGyLlV8kXacM/AgpFVa9E0H1LZm1+KNtVdqRbgpwdRRC3nFk1OctNTgksxqTk446MGgjJEK3zJYDrLx5rB+/zt8SS2qhlDbeXCVsGaIXY0jUrKqpOBgiH7U4bCF26RkVYCEw2uZ7Vs3s3vqHlkl2QFD8Ww+jgxhBzEyCDG0Nrm9y78feMiNvoixNWlL3qQPfMCZE8xP6fJYLFrJxpLFYez21WYDMGJug+TiFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reWl/ZaeWVQ/kZ84F37Yq0DJTIipsCrbCjtTnfFzDMc=;
 b=P8Kp0SC2/p6SbWVVZq9kxKl3aMcdOP1MkzN94CTv6cJGHB4V0leXzJrE+j9c6LyaEVOSMxUiTdh4aq0VRW63aLTu1yUNQbCxIysI5Bewvg+uNfDXcrHoVvafXi0lgiNRgl3FLJ7Q4WtcqIBBFTl/ZGIeUUV8fujmkyxd970V3iftxNMbh9ZbK+q79P6LLXBjeh4xxZB/41Eqsh2Nnsz5KY+RYWwMRa5p2DJmUzaZmv/JINyntEzaU/6+RMGOq03JNzOrUzEwtSG5U5zq5/HuXiMBNX4VXePPNPgL9Bb/aEhjaz1UbguiCbQ5IUEY47G4XkUhR25QKMzpIImXt6naEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by GVXPR04MB9850.eurprd04.prod.outlook.com (2603:10a6:150:11a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 02:00:21 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 02:00:20 +0000
Message-ID: <47cf4920-6245-4714-bfbc-7350e0b32d68@nxp.com>
Date: Tue, 31 Mar 2026 10:01:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: bridge: ldb: Require reg property
 only for i.MX6SX/8MP LDBs
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260329-fsl_ldb_schema_fix-v1-1-351372754bc0@nxp.com>
 <crqzju5cqhvmy5msxvuquydmnpb2ft2t3gsyr6qsre6ccqjvzz@46gfcrelczsr>
 <aabe88e5-70f9-4ea1-b750-e425970a2761@nxp.com>
 <oyietcoxdawgjmpdc3kkmru2azuuqrkmn3onm37wpu6f3t2pqg@g7aswu7zsfrq>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <oyietcoxdawgjmpdc3kkmru2azuuqrkmn3onm37wpu6f3t2pqg@g7aswu7zsfrq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|GVXPR04MB9850:EE_
X-MS-Office365-Filtering-Correlation-Id: b52325be-8966-4f33-1e5c-08de8ec94388
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: BTs/APweJkOJOSjlUgjgNAZcJVD0Ff7FUrXe2K3HiTP5REqAkrOX3xCIomJVR2/6j2ITW+hCJwo1/ZfNUEGrTbNyZFj4yDv4+UeP2ioyYhifJn0A5lfdjxXdpT4XiRNvxiy/nIYDQOWv3rvIo2VgYhY8XSQF67bDjzRKE+bUhdGry3PdI6UrNrasdMa6lG+f+7thStnOJGDpkIjmImRbyIz8GUxqaKwShkJmG9ezm1/qV8b3yY/hsk8eRYM4JIcAyhPLgtkEZjFG5lJbthXDnc0phtoOK3PsXSvom6IGwLJOMnR4KTPPk9sHA5d6cx186jUK1CcOs+slbc1zjWAlAbx6nHbm6cH8ATlT+k9xhE8NHwgs5AtfscF8tz1zqkrbPA9WRZs1l7wm0sjqJ2vsaoxjaLEkPTCVqsiKXRGHIw94SJ6sDmae2Y8FDOvQ8CUNFAJej36y7i+yjt5OMj6yXzmSNbKcMOYsTKBu9E2K49IgVmlKB1IVwKEpFA6ijFCWRNdYJKCIZDGAOx1KhgfvkvofxLf0nP0zhP1wAMOv/SA8PCO0NU58DAQ9mqvTWM7K9VXMjKD2JFhjHL1meO2WFLClF6+Ae5Z1Gs/8JjnLx7jlTjmfxQjeehlKha0vBdZksmd9oCmsLKKIZ+hvpGpidBC4/9rm8RgNXlTsnNKkNpCMMhiBOj4ugZQd/1wsqcYB1BU2iUFSeHyA9vPPh9iQcpTTpccXLYxuWFgzBbj0EvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUVmMjlxQUcxWHRzQzEva1NPcFgxYUF1azgzbHVHcFB0TEdjQzNMZTRURHo0?=
 =?utf-8?B?Q3pvcllGYjRMeDZyQytPbEdGUWNjQTI0QWtiejh3TUx2OVpnd2lGdlhaK1dN?=
 =?utf-8?B?NnYxbGg5Mm1zSkdISDZzWkhzTjJqTVdlNWNwbm5jOUZNeittUkZHdUl2VHM5?=
 =?utf-8?B?UFQ1T1loNmlaa1Z6K0x0dTUvRjR0Z2U4Y0lNQUVtTk9CWFRTcTB0dG9xdnlM?=
 =?utf-8?B?UzFiWThhSlErb1ZsRDUyL3JyMkp3cHYxMVE4ZnArY3ZuVjhrOXc5TnlMSUJk?=
 =?utf-8?B?UWNaSHhHNXFUMmY5T0R5bWtUSC82MklublRsTEFralVoS1BHbkhGYWdEUDB2?=
 =?utf-8?B?VUpmZmFVTlM4ZnZhSmlQMXo1SUpYNHhkWjBVRnNPbnVoMldPdGw3UzRuS0Vh?=
 =?utf-8?B?SUx3TnZFNUU4WDhHVlg3OG0xbnBtM1gzbnZuQ21iSWlKWmo5aTQ2OFM5RjBN?=
 =?utf-8?B?SE94SFl0Wjk2eFB0LzlVaExEd0RpMlhkTG5FalV6eGNBRi9uMnhCK2pjMVZL?=
 =?utf-8?B?WnRVbi8yaFFUbHhhY1hranNqUWk0TDJ2Yy9MckVTYXhHeWQ4WU5qQVdXTjFu?=
 =?utf-8?B?QUYvbm1mK1dDblVuQndGdEo3eUU3cEp5L0tRUWVTY0dlbVYwQTJuRUs2OHNk?=
 =?utf-8?B?MDNwMkNvenpWV1gzRm1Hc3RsNTJwV3ltMU4xZ1NDYW5YM1VXK29veXFpajNX?=
 =?utf-8?B?eWJtVUdONVMvMlhlbDdKdGVFMHZKZjU5dVk4Y2xHRVlUdGhxc0RrUGY2dWxn?=
 =?utf-8?B?cnE5Wk9xRTU1cTdWTGFySUdBQndOem5IdU8yUlFaQ0pEbjJCVWUxbWorQ1A5?=
 =?utf-8?B?S3poTHB2K2tybFk0bnB0MmZCY3FUWldQUEMxdUJOQkFIQm9Za2Q4cERjME1j?=
 =?utf-8?B?cUNFalRIOXl6QksyRE5kMXNwbUo2VFhTN1hVMktyYy9aTStNLzFUc3cwNzdU?=
 =?utf-8?B?T2JNWEtyclp1cWVVUnFNSlk3eHFKV1Q1ZnVaSlI2bWtRMmo2aW8yYms0N0ZO?=
 =?utf-8?B?cFFFRDdWR0k5aFFxdHlaOG5POVN1bVRmSCtkNm9Jb2VSbXJSTW8zSnJDUVZk?=
 =?utf-8?B?NmMyM2JCMEVyRmczMWs0MkRIY0NSQWVYZUl1eXhsMU5sOFlSdGhUZ1lRT2x5?=
 =?utf-8?B?ZVNhZkJ1MTZIQ29HQ2g3bTUyR2wranA3RS9RaUNYNGNvZDI0ZXJTdGc4OXJ5?=
 =?utf-8?B?VTFhVVFyWXJTN3BaQnBMVkNMSGtPeS94OHdmU0NxbG02alVOSzUwWnduUUhU?=
 =?utf-8?B?Nlc2dEpFeUVhTnJ0Q2tVcmNnM0toK0pWUVVvV3ZwYkFZWUwzQTNQclZyVXZD?=
 =?utf-8?B?Ym1JWFNFWURrRGI4U1hrYjlZZjlmQ2VQMVcxejJQMmU0cm9LOTN5dUVURkk0?=
 =?utf-8?B?M1hqYTZuK0xzcGdkZjRTYXUwZERzWmhLem5naDIxQ0V4dmprdzE2SDdYQWpX?=
 =?utf-8?B?RHM1WmdxVk5vMzlyRm5TNXVXc0J4dWlUUFZHN3NoK1VGRGQ1YW9teUpxbCtu?=
 =?utf-8?B?TnBRKzQ3WDVkQ0p5MWg2MWZiYjNxcml0cnVNM0pVdUNlTWRJVkdtOERHZVAr?=
 =?utf-8?B?NXVzOGZUakdDQU4ycjJaLytqQnNaL05scEpsUUFQcWxJV0xyMi9uZlpnd0tl?=
 =?utf-8?B?NEVwWUtHcmU3VndtT25lQzhYUjdINllLWS9qWFNQTUl0NkFYM3dVVXdWek5D?=
 =?utf-8?B?ZVM2TE1TMWpTb28vampnZUFCYzVZcmM5b2NIdnJ2V1V3TjE0amRjVlYxRUdC?=
 =?utf-8?B?NWViSkIwTzQyR2tUY3pyK2UxaXJKbitteG1iNEZNaWR1RHUzd2RGZUdRVUNB?=
 =?utf-8?B?aTQrWGU5Ykt1ZFkxN1l6cVIwelRnOVpWR1dJc1ByL2o3RnZ6b0dhL1hHajJz?=
 =?utf-8?B?clR6WHVxM1QxUzVCR1oxUnRUMW9PbTc2Z1VKMms5eVVFakg2SkdLNEtadm40?=
 =?utf-8?B?QjRTazZoOTg2bWN1cGlXVVFZcExiZXZUOUJmZzVuMXVOcGFGVG5DTUYrQUFl?=
 =?utf-8?B?QXlDNVR0Z1JxZERteG9zQmw1eXAyUHdPaWdPWWpGam5yZUUwUzRLRkcvYlhw?=
 =?utf-8?B?K1d6czYya09HQU90dWlmbCt2N09nOGI3Vmoyb3JSU05rTEMrSUF4alFUSkVL?=
 =?utf-8?B?SjY5L3hsdWhDd2l4UmkzdjlYUEErQk5HOGNFOE5uTzBCS1kxdTZFaUgwV3k2?=
 =?utf-8?B?MjEwZSt4b0lESEZHMXdOY1poR2tra0pMWVJHWk5VejdodjVGWFVXU0VWcHds?=
 =?utf-8?B?bGZ2VGtyYTU4ZnNjZGpLUkQyQnl3b21IMU0rdW50cXlZWjB5aUhNZ05zUEJU?=
 =?utf-8?B?WGFtWDc3aC9zNjV3djg2NWlLdXpiUE16R2xZRVJnWWViSFhLaU5Qdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52325be-8966-4f33-1e5c-08de8ec94388
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:00:20.7899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEFacIBVdk//w08NgdBxZtQ885E7EcIM2d9//TwV9Jx/dJeT/bVB/tfq4PAH0yyWfr90oLXPHv26FqvefZ3m6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9850
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

Hi Marco,

On Mon, Mar 30, 2026 at 12:28:00PM +0200, Marco Felsch wrote:
> On 26-03-30, Liu Ying wrote:
>> On Sun, Mar 29, 2026 at 07:42:23PM +0200, Marco Felsch wrote:
>>> Hi Liu,
>>
>> Hi Marco,
>>
>>>
>>> sorry for not writting back earlier, the last weeks were quite busy.
>>>
>>> On 26-03-29, Liu Ying wrote:
>>>> LDB's parent device could be a syscon which doesn't allow a reg property
>>>> to be present in it's child devices, e.g., NXP i.MX93 Media blk-ctrl
>>>> has a child device NXP i.MX93 Parallel Display Format Configuration(PDFC)
>>>> without a reg property(LDB is also a child device of the Media blk-ctrl).
>>>> To make the LDB schema be able to describe LDBs without the reg property
>>>> like i.MX93 LDB, require the reg property only for i.MX6SX/8MP LDBs.
>>>
>>> NACK, we want to describe the HW and from HW PoV the LDB is and was
>>> always part of a syscon. This is the case for all SoCs i.MX6SX/8MP/93.
>>
>> The reality is that i.MX6SX and i.MX8MP LDB DT nodes are already in-tree.
> 
> What do you mean by 'already in-tee'?

I mean the LDB DT nodes are already present in device trees.

You may find the LDB DT nodes with the below command line.
git grep -A5 lvds_bridge arch/ | grep -E '6sx|8mp'

> 
>> People may take them as ABI(not only for Linux, but also for other
>> potential projects which use the LDB schema and/or the DT nodes).
> 
> Not sure about this. The DT sould be backward compatible, meaning an old
> DT shouldn't break new users e.g. old DT with 'reg' property present
> shouldn't break new u-boot/barebox/linux/... drivers. But a new DT could
> fix/change the behavior for new u-boot/barebox/linux/... drivers.
> 
> So no, I don't see a problem here.

An OS could try to get the LDB register(s) via the reg and reg-names
property which are currently present in i.MX6SX and i.MX8MP LDB DT nodes.
If we remove the properties from the DT nodes, then that OS would be broken.
That's the ABI breakage problem I talked about.

> 
>>>> Fixes: 8aa2f0ac08d3 ("dt-bindings: display: bridge: ldb: Add check for reg and reg-names")
>>>
>>> Therefore I would just revert this patch completely.
>>
>> IMHO, it doesn't make too much difference between my patch and reverting
>> this offending patch, because of the ABI, i.e., the reg properties in
>> i.MX6SX and i.MX8MP LDB DT nodes are supposed to be stable.
> 
> Please see above. If that would be the case, your DT must be rock-solid
> bug-free from day one, which is highly unlikely.
> 
>> I feel that what you are asking for is even more than simply reverting
>> this offending patch, that is to say, completely disallowing the reg and
>> reg-names properties for LDBs across all SoCs.  But again, that would
>> break the ABI.
> 
> Please see above. IMHO it's more confusing if the same "IP" requires the
> 'reg' for i.MX6SX/8MP but doesn't require it for the i.MX93. Therefore I
> would like to keep it consistent.

I agree that it's ideal to keep it consistent, however, in order to avoid
the fore-mentioned ABI breakage problem, we have to keep the reg property
being present in i.MX6SX and i.MX8MP LDB DT nodes.

> 
> Regards,
>   Marco
> 
>>
>>>
>>> Regards,
>>>   Marco
>>>
>>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>>> ---
>>>>  .../bindings/display/bridge/fsl,ldb.yaml           | 23 ++++++++++++++++------
>>>>  1 file changed, 17 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
>>>> index 7f380879fffd..5f6dc2b11d7b 100644
>>>> --- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
>>>> @@ -28,6 +28,7 @@ properties:
>>>>      const: ldb
>>>>  
>>>>    reg:
>>>> +    minItems: 1
>>>>      maxItems: 2
>>>>  
>>>>    reg-names:
>>>> @@ -68,7 +69,6 @@ required:
>>>>    - compatible
>>>>    - clocks
>>>>    - ports
>>>> -  - reg
>>>>  
>>>>  allOf:
>>>>    - if:
>>>> @@ -83,12 +83,23 @@ allOf:
>>>>          ports:
>>>>            properties:
>>>>              port@2: false
>>>> +
>>>>    - if:
>>>> -      not:
>>>> -        properties:
>>>> -          compatible:
>>>> -            contains:
>>>> -              const: fsl,imx6sx-ldb
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - fsl,imx6sx-ldb
>>>> +              - fsl,imx8mp-ldb
>>>> +    then:
>>>> +      required:
>>>> +        - reg
>>>> +
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: fsl,imx8mp-ldb
>>>>      then:
>>>>        required:
>>>>          - reg-names
>>>>
>>>> ---
>>>> base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
>>>> change-id: 20260329-fsl_ldb_schema_fix-4fe01c42bff3
>>>>
>>>> Best regards,
>>>> -- 
>>>> Liu Ying <victor.liu@nxp.com>
>>>>
>>>>
>>>
>>
>> -- 
>> Regards,
>> Liu Ying
>>
> 

-- 
Regards,
Liu Ying
