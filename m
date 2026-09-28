Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA3EC98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C1F10E77F;
	Mon, 28 Sep 2026 05:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IMA6hR82";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A32310E77F;
 Mon, 28 Sep 2026 05:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3fKX5nX4eILiPZDelwp8WVp1xTaBfcmKl0tUEoQViG5RZW7U0V5G6QaJaxnHwnVj3p+lcgQo2kIcR7KvLo9BxBY2SYKvKmZSo38t7UO2iKcpvDIikEe0nGX0wMBZNlIRZGjxU9yC0HHT3/c3I9PytCKRuqU5J7XoglNbwIKyY7bHZD2mZowI57AhaMCAwHdeMsGMUWbIY9SwPT4VQLWOf3PvcHTM3h99FwIH2nxHAErBUP5Cq2IP7R0RM0gSRrxzhYbGK0wEYdQgZRm14gwsPsbCqlc5phS8/Bgb3E+ckCQIZ9H24x9YEgbCkxbfcW9nH29g3VP2eH9RqkhW8qUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAI4YgSebkQbKxsB4tDmJwBFYendJRk2ZLrnxNDr5FA=;
 b=kXI5BEuW2bitVra2tHgick0yl1jvaQ1YNzuIwPjZrQ3iTWFarYLJA3lzJIM13OTqqni57Y9y4eVDNUZpa8t/JzX1Ee9KHm/Q3AJTPukxGoXRlxOJZSPazGMCyd62rJsExA+RRUqzF3rgwayYE3cvEpnoUJNts1Ki8ei1OiGJAgyCoHh2JX6NDemRoECYal1zFVJ/Q99CG9ATszao/LRvMpNgPOpzQorL0tymO6E0gdcWWiPq3LeZzWTdlMkSYP1A/jYJvbLFpx128s0sQmftPAG3KoUBi5dTpzMvj0n/lpJnH7FUCff09ci5KHsi//xVP/rqNSREbMG2i5JGBU5oNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAI4YgSebkQbKxsB4tDmJwBFYendJRk2ZLrnxNDr5FA=;
 b=IMA6hR82OM1wx8I1GGBN0qS1dxNoDXrc/iYQSgyo7+OFzv8mANNNadRfYBxbvJbY++2SQ78hFEIc3ap0Bxe3kzkt+EtXLLwVBol5afQDoASXgZdRxMfyHo5B+6Sy21wxL+lf19vExMnTpjVmWq/lPxtwNXq1QTNI01uPZjepYy60YsUpS/WI2Cfng+boKxyrZ3+YteHtcEMr/m8G1yCxdtGXJBnTjii0k1Z6jzzsLwNIJ9JuCnw4K4yOARAiG1ssWINvtgHTTvS0SwmSrznnyWx/uZR455+o/7dO8X9CCzBwnC6ytW9E7jyONl9vikuJnyiXPrVDoWp5wdNnSzTW5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.23; Mon, 28 Sep 2026 05:39:22 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 05:39:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 14:39:19 +0900
Message-Id: <DLQPHT9FD17A.22ME7VW07SQV1@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] gpu: nova-core: align Bar1 alias with Bar0
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260926124405.604707-1-dakr@kernel.org>
 <20260926124405.604707-2-dakr@kernel.org>
In-Reply-To: <20260926124405.604707-2-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0128.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f362c36-e81b-4c7c-3a78-08df1d22d9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|23010399003|376014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xqDeMqfDuScDKzIzsW2y0w+seUO0n86OyVnGbRvBK8j5LHRR36CmfcksPgxhD0Hk4vuxX1BplHXhxsuYnzKGUg5Uu69H3LyAp6+VEK6XvqQk++lUjcylqHHt/aYdycixXJyOOrAqRslroCDuhnMvqJAs+XEt50+QJc78H+Wv5zPiboKYAlGH1qox5ZaHhenxBlvmxoXqNNCHjah2vbLSXqIJzpWBD6Kxi4e+/GN0T+a8dPu3t5Qm8FV8l4WEQwvuW8R+syJr5YvOQuwy6JfKUZntSbN6d5xNAzqMS21MgyQTmFrYAOlpNU0VsjRRX06zDuVHvYatGwnmN+M3+dNGgSbwvTIaAk4XXbDgOshtvx2JmjEIOtdOpPA0lapq/qVRiGUzWXV6/KCFQaGGqbeX31ZV5gnlTkHlKCiJF5W/vioA05mclT1CB+lSHOx+KWcUrwYtX7ienk4hb6u26ii8tUczJFn4oKHs+dX9Kpf9JwSIBe5YDsyVOsVqJLFw8ikTQNVjaHh2msFsajPHxTQo82YJckathSuo8aRO+NHVc62ZYH6PzDkdKK7hmbcxJtpbMgWzEl243+aaaultQ1bGXcUiXifoTVAMVic/Fc9/vX3TM/IyUpzx3WNs1oXt+HgXaH8UuHnxaq+JJG/04n0P9Il9XFUj5KFp12HFv3piUtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0QvSjFVd2gveGkwblV3UjRHcnBGemh4YlA4bHFUREZYTllvY084SllNZEVU?=
 =?utf-8?B?cWJwaGRVa1ViMzdaQVo0ZDl1SmFDS2daUFVacTdPNEhBbnJraUZjeHVRaHI3?=
 =?utf-8?B?UUJaMXVHcXdlVjREZktZd2RMSFJKMFk0Rm12L1FFQ29wM0E5TDRoM0p3aEZC?=
 =?utf-8?B?T1g4SU9DOUJlRkU1OGQ3MzBpWDdya291cDh1SWlzQXYvUHNyUFAvUWx6TlVK?=
 =?utf-8?B?OXlYV1NPa3hMNk53aEVGUkNuNDNMdC9HaUJBZlNmaFVkbjg4WjE1NXZ3eWFp?=
 =?utf-8?B?RW5MZFhIUGdvZGtzd1A2aE1XZWdlMnhpTjBTeXpNaW1TRFhyQTA3eUVlZWd1?=
 =?utf-8?B?TVhUUEE3Z2UxLzdrSGNYWVNYcWVCc1A5NHk2SVY0NWl2YUZuWlhQSlY5Z1JB?=
 =?utf-8?B?bmovb1p4YnFleE1QS0RSK0Z5Y2QyeGR0cE5kUnJmNzNqMks5SXlVdGxWYitv?=
 =?utf-8?B?RkRWZm92L3FWUE5qMkxjSmpKMllDQmNabDVaUTIrbHBJVk5BZThzVkxJTFNL?=
 =?utf-8?B?RTI0TnJBUlFnRW9udEIzM0RqTDRyZHBUbkdQbXNlZncybXVjTnZkRVhTcHY3?=
 =?utf-8?B?eDJZbCtMUHVCUDBiQ3JjWVNEMVFiamtZbmdsaks0YUljNjY1amtqenpJK2Vk?=
 =?utf-8?B?OElTeUU4VzJsK0I2aktkay9LYTh0RUVtME1mUHhsRlNoQTY4VDM3V1dRVnFW?=
 =?utf-8?B?K0NJaTlZTjNIUXBDc3FvN2VpVWxQc0pKVVhQMDFGZEZTK0crdkszb2Z3WVR4?=
 =?utf-8?B?WktibjBXWlc0UVU1NjU1RVFkYTVkdWhNOGFKOGJkaDBpWjVTSFErWFZMa2Q4?=
 =?utf-8?B?cmtvMzNLRU5vVytRQW5yYUVqVEVyQjhhQlU3Wmw5SGZ1R1paN25ucFVhWm9F?=
 =?utf-8?B?UFozeDFIVDVvN2VSZGwxYXMrVktJM2dyQTJNZWU0RVdUNUR2cnRIQlE4OURL?=
 =?utf-8?B?aVhDUDRPdEhUOXBjY29JVjhXcWQ2dlViZXByNzhoZ1AxQU5KOXgvWnlhcys1?=
 =?utf-8?B?K1NLODh0Y05wL1pKSDlPY281cmZwSlBZNG1VVmU3T3dKZk9WZlVqdmRFUG91?=
 =?utf-8?B?M0NBT21yOFlJYnQ1RUdraDhQUUxqOHk3YWFNbFFmenM2b29KdW0rMkF3eGtr?=
 =?utf-8?B?aGFtL0dJRkJiSWJxOWQrYzlCQkxJdmg3aDRibjB3bDdtTHVCa1J1em5sRXZJ?=
 =?utf-8?B?RmdUMVBQZVB3azFoMkl0UUd3YXI1eVAvdklvK3NWbkZMN2pCOHg3ckd5aHRq?=
 =?utf-8?B?cWsyS1owcm5EcmxOMmFBdk83ZFNkSkw2SFdPM1p3YktwbllaU2tIaFRlL2Zk?=
 =?utf-8?B?TUR3OVR4d1YwbmFhTExYbTNYZVNnZzR1YTVLNFNPVm5HMlR3OThSUitZR1RV?=
 =?utf-8?B?R3hIRXZId1pnc0lId2hPUUVCZmhNN0VIYXBkVFpTTFlGamFqanNmOHJjdElU?=
 =?utf-8?B?VVRjbFBHMTYzZXcwN2RNSHZjKzRVS1dHK1lzcFJocFdVbjVGeGtmelRLcHR0?=
 =?utf-8?B?akdsdXhlTjhBL0RjcTduVkc3VjFVMzhucXIwSkVuNHdHZGlGTE1LeTBuYVJH?=
 =?utf-8?B?UmROa2wvRE5majlzWHdSNUtXb012R3p5QnZKTllxM1BvT01NY1IweGZKVWhx?=
 =?utf-8?B?bWJqbHJGd0kwZUpPZ0RRMDlpSFBzZVMyS0c4cS9XVVFmcDgwS01ITGNIZGVJ?=
 =?utf-8?B?dlJmQnBkSmhWeERuWEg2TjBSRmVSSVZrUituMzdEY2h3MkhhTy9KYzdZZk9a?=
 =?utf-8?B?bTJSMHBya054aFh5OGczQXJnR3BzdFhvMks1RjdxUi9uUGliRTUvYzNaVEl2?=
 =?utf-8?B?bmxOZTMrTWNCdURYL0xaSHAwbFZKZTlWUUVZRnBpNG84RGdWdVorTnhtWFNj?=
 =?utf-8?B?d0pMVk14cTIwa0l5QllRS3hYMnlyOGx5cGRDVFVTWTFENGx2V0Fka1ExUm1X?=
 =?utf-8?B?V09XTjBvWVE4VnBUTzBnTHY0WEJWeENvK2J2SERLMFBOblZ3VmhGOFY5L1li?=
 =?utf-8?B?T2JDTDBTakM4SXl5cHhTaHo0V1J0aXcyKzAyMGtkZVNZd3BQRHBjU3FHUThQ?=
 =?utf-8?B?ZmJCL1piMFQwdCt2M08yRkZURHpiMXBiSGpOSmRUR3FGbG50c0dtZ2t2eDEz?=
 =?utf-8?B?d3RzWXZIeENwZzVKYnl6WCtGUGpNTUJOR2ZVU1dpT2d6dm8rdmxEbStuK2s3?=
 =?utf-8?B?UzJFQXBrMkNsUmVrdWlOQVdUK3lrakpjTGxaYVFlRUVoa2c1RFZLU0VOR0hs?=
 =?utf-8?B?SXBKbWVFTVJFZHpqOWFEci8zT0NiYlFLS3gxbmVvNEdWSS92MHVuS052MVg2?=
 =?utf-8?B?aVZaeCtpbVNxajkzYlFHOFY3UWthcS9GT1g2SlhCbGRXZmxRdnhoVmNnOWs3?=
 =?utf-8?Q?DuGQEbUg01WSmD1NlDSM1fFhX+dw2tsYt8nBI7zu+9DrL?=
X-MS-Exchange-AntiSpam-MessageData-1: bzyBv2m3v59T9A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f362c36-e81b-4c7c-3a78-08df1d22d9a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 05:39:22.8364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgS0Kd2mW1vsxeK1Q9recErXA9mMEA/z9CWnAtvpJ5ThuMcPIupBFWDyfAB+6ByGhvGRvCvRu++2ksjgUXUUyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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

On Sat Sep 26, 2026 at 9:43 PM JST, Danilo Krummrich wrote:
> Make Bar1 an alias for a borrowed pci::Bar in order to match the Bar0
> type alias.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

