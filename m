Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC47C54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB8E10E64F;
	Thu, 30 Jul 2026 01:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="e1zCtKaw";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F5910E64F
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ba0v2vZDqMkr2pArD9vG1wmU/RuNnkOtbWG/6cwUsANvLP3beogj2SnKIZ+ssp91CnqVYoOUnvWMVmr9nKkz8hNefPIs1CyZdHTw9ctYpQa3P2FczT5nJ1Sn77d6rdXhS+MXItgTqrpCqoW+9mi1TOkFUmtu7lL1E4rD685swUkxkcIKTd/wLow7R87ELGYE/vnQiTzhoSq3Ug1rWj/Z3ku4j8rmHDd23EK7wxzaiivtzEX9uhS7yE2P53HHSoRolxkpjFd9X80EPfukovtQqVU5IfiWp0spnivZ4WDglzfSYTG/S1mj5joh+hXkFfnz6iC1HRjd430kOH0d8I3v1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke+q2IEX4QxNWyDFsmqSdiyYGHH7FV8+Yi+GH6yc2cM=;
 b=RnbULk5bqJqvJ5FvG+9T4NZWMo4gMsKk0ryBMjc8tH3TC/T//pdssVTwW0ZVNvlhzrdrN7CuHfQh/mPmAZdFZkDGYEgLR4ng1TJLoKEDfJdN0jv8TPzf9M7RQGRrbqDaJxRarDwFAZ5lRyW7MexXlKP/4Lh1Ng57d7JY9RlN+cEhg6cYjgryT/Br5UuKhjDZHaKvF0tykGHDSV95zyowN9t8YCD8hjYWoAphLMrpvEhOixnmDH4krde5+cDfuBLm99zgP37a2Uxq1i2+MY+Tlso0HGEZLI1wKwYN5vzf3SYaWifG7pIwhmPdpPOeCWZz1LzQblR0/SDW5+adtbSsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke+q2IEX4QxNWyDFsmqSdiyYGHH7FV8+Yi+GH6yc2cM=;
 b=e1zCtKaw7O+4ua2WUP3Dn/jpG18Sfn4p6EKk4BZLPYjesZfGTST1ONqG9OSOmf5QlkqkuJxHzJ3VKDiL/rnc3Xcole8OSaIfiYfiIt3jwg/0muZyyM+yIVcswZsd3P3Ua6/SdvBoFunPkgCmcnIGX36kwCS7LXWX9L/MuRDcF/QGc0HeO2MPVd5//imO+P+L6nnBvlUG3pD0EONw6E/BIBrl6+dkwhNDnvnyPlyY6QPPl0zJWBqzfC1sh9/QwG3RlZ2YUtQfNR61/HmetUjgf5w5RDIvOKsYh1V5bIpRqCtE8YwwjoaqgIiJgfrpnz9lY096BewhXKyV4blv3rGmKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CH1PR12MB9648.namprd12.prod.outlook.com (2603:10b6:610:2b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Thu, 30 Jul
 2026 01:32:31 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 01:32:31 +0000
Message-ID: <30143942-0d97-4823-9de7-e7e6ffb5678c@nvidia.com>
Date: Wed, 29 Jul 2026 18:32:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] drm: nova: Add chipid enum to nova-drm UAPI
To: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
References: <20260723063046.1265791-1-apopple@nvidia.com>
 <20260723063046.1265791-4-apopple@nvidia.com>
 <DK7R7PB91GUE.1PS77AQM8ZR99@kernel.org> <amhdA35CcMD_uY2f@nvdebian.thelocal>
 <DKAIVPSA45O9.1NZES5S3BII10@kernel.org>
 <57e2b956-89fd-43e8-8cb3-a15aee272660@nvidia.com>
 <DKAKR85QX9UM.1VYAAL82QBWJ5@kernel.org> <ammyfspYkXOwMsdU@nvdebian.thelocal>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ammyfspYkXOwMsdU@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CH1PR12MB9648:EE_
X-MS-Office365-Filtering-Correlation-Id: a9db4582-4e36-4846-aca9-08deedda6c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Xpz6kjIzR7U2l53U5gXDnzefVrje4oZjVutX7sgeRImInTudIqm8V1vq1qTM5PnBcMpr4qR/lQEcNjKPRSMo/m8mhAWqRGhwUDBaDPRf/xx5cSz7g2u/hhQSq8C1Rz3YS7/HCGNNUQPWuY0+ywv8R+/z9/T5GkZuGYM8y+iKLUTj9hc1SEYMmn/D/4FG11xt6LGA0dE2Iv++CtJ1UlJAQi77ucLJNemfpdKE/FHbxsL26yyuCRLHwgHs69vTsAmImUt7Apqvi+g6tghqXToIvlSFyHgXnHdvSguZuvWixXsbVHWiSIoA8wlj2XI5ac0XS+5kge4be3qu6Q6rb5v3qX59Bpg1ePd+x3jfcKDgX/58OPaWqe9a3h+RkTh1hVElQ4jx25yTcVvPu0HNLHuFnW5xbkLlD7RoqcJj5AQ/dsgyBMjHawFtsNbW5dVftN+yZ0xVhDjxiIEl19aQlGOU8Xznmff9PL8eN7R/Mw/9JPKT8mdwxYMkJlmB3xI7oVyjlJs/JfaPoL7WXyZT+w/7V2dNf017nOtwSglv56sj6fNYB0701FiLKZNKuo34r8CkpJJ5wZWfKUV+c/72lCSx7glzvMbOnRbzpUcM3GJAUsQQbiGeHQDiEilgJpjyjNJzZ4Fd/v1s7N+ll9U5KTFxiWcxf7B07zgilWWYMZSmcUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUtlMFhQcDhXKysrcEYyUk5TWUpRWllURFdEVGRWd0hnUmRPNlI4OHZnMXA5?=
 =?utf-8?B?T0NGZmVNeDg1ZVFVOG4zMVpVU0pMY2lWenMxdXdJT2NXWFY0MGduYzRSSmdt?=
 =?utf-8?B?YnMxNlR2VUxKUHAzL3drQVpsZ2ZoU215RUdqTEdHWFRucGJzSHlqZTBmY2xX?=
 =?utf-8?B?OHZrVXNKNVNXMU43RGR2Vm1rWkZzOFVaVlh4N1oyeTFRMkxwMkg2OEpDT1F3?=
 =?utf-8?B?d25ZZy9Sd1IwTnZoaVY1K0lma0hkUUg4NGowSk5WMzJpZ1V1V1EwbnA0bjV4?=
 =?utf-8?B?bWtpNE5VMW16dHZTVFgyQ0tDcUlteWFkRWRjRTBPWVNnR283TUdJcmlwVGQy?=
 =?utf-8?B?UElSNGFUcEZVT0JoMWNFQmNwSzB1dGpTNkhhOHFNTVlwN1krZndIcGVpTnlI?=
 =?utf-8?B?Y29nZkRTQlBLNGRhc2R1VW1FdmRSaEtFbENMamo3aFh0YVlvUTRjREhic0h3?=
 =?utf-8?B?b2JXYmFHSmdiU3M5WmpXUjQxT2piR2UwdkhZZU5wVlR0eUFTaWY4MVJIWE1R?=
 =?utf-8?B?aWNML3lDeGhhTXZNVGszVzVQbGtkZ3haMDk2eDFVK3lrZVgwOXBLalcyY21Y?=
 =?utf-8?B?eFFnQmpmTjN3Z2VnNzJISUkvTk9pSHhsaUMwNFZlSHpKeWs4NDBxbzZIVzhj?=
 =?utf-8?B?eUhpVmV5RFhmbkFTOGRlZ0RGL0JsUmtLN2o3NlpJTlgyODNYZ0U5YUxsQXhr?=
 =?utf-8?B?UGlVVlFGRS9pU3Rad09YZXZ2TXY0dk1RQzhYOTVhL0l5MGllb0tQV1ZYZ2RC?=
 =?utf-8?B?NW5EUFJsb3NXWXU2RXBHczFQVGV5RUVueHBqRHJoYjJXcHp6TG1QNjBOb0RY?=
 =?utf-8?B?ajc3bHJPYTNEeTBjcVlXNmM0Z05icDZXaE5yL2cwUXhlZXI1dnZ1dm9XL0J2?=
 =?utf-8?B?dTlpWVJDeWR6Q1JPd2F4ZXV4OUZKQ24rbWpxRXc5WStpM0pkMXQzSTZZNnhM?=
 =?utf-8?B?OU9lV2Z2OTBxN1FDV2RxK2hrT3VqR2NCVFNxM2svM1hkelZKUm5TQW9FaGZU?=
 =?utf-8?B?MmNuUWRYdE5idkY2OVFRcDV1RHduVjhOQ2thdGNyY0RhVGJrU1dZbG5pQmhy?=
 =?utf-8?B?cEcvc25BWkxydExRZkxHcnNLMlFRcEZmdEp4c3oxU2JDemJybTFpdmI0UjYr?=
 =?utf-8?B?ZkVFWHRMbjZteWQwRWwrdVZidkMrcy9tblZUSnFva2pvR3JOOE42N3oyWjQ4?=
 =?utf-8?B?NERaL1gzb04wb1BZRmlCOUJrYnpKVFRFaG9xN0hsSklkeDdZZzZlTGUyM0xa?=
 =?utf-8?B?UWpicm1ySEsxNk9GUDlmU1NxMGJaWGw2MGE3dGo3dFFWUGtxaFMrRWk3dG5v?=
 =?utf-8?B?V1hXaExpSTMxei93MXJORi9yVGtoQUZQRXlPTE5QOUtCUzBXcXpTcGs4ejFY?=
 =?utf-8?B?VnQ3bzA2VENaNk1LZDQ3Skp3bnVOZkowdGJqSnpzZHp3eUU5ZEMxdnpBbXk3?=
 =?utf-8?B?VmUwd2N3UVUxWVdCMFNMc0d1NStrKzFqeHN5dEVPa1ZqQjYxc3o4cVNoMmlJ?=
 =?utf-8?B?TURPZmRGQkxZUUR2Q0RnaS91L1M4Zm9Za001d0llYjU4NnNxOUZKQVJsejRD?=
 =?utf-8?B?Q3FiaUxlQUF2OWpKVkQrOXdDUlVHQXJoTnRVSDdPcVh5dXE2ajlnVVkyM0px?=
 =?utf-8?B?bkFnWW9laGk4aDBDOGZnRVZPS21aQlM0MmIzWGFrNFVSZzBVRXd1WGFJTThJ?=
 =?utf-8?B?S1lYL2dHTS9ld2V2bkkwVmJXWHZYQXlRcHVLYi9pQUJNcVcvdVpNRTl1Vkdx?=
 =?utf-8?B?Wm5URHFBZndwcGEyZmpsekVUVVI5WGhGUVZyd3U0d280S3N5UW0vdy90MXhw?=
 =?utf-8?B?aWxLUnFnV0ZFYzl0RUpES2JqNDB3em5rNU9XQUpPUDNQQnluUW5zdTcyYWlJ?=
 =?utf-8?B?cC9JT1VsODROcEU2MlFzMHJQODNhNXFFc3pQV1BxcDdCT0Rob2lmYURVSzZ5?=
 =?utf-8?B?cTM4ZGI3dE5wNUFMQklGd1oySURCWDV0b3liRHlkL3ZIQ0dvYk1NUHBBbVdP?=
 =?utf-8?B?aEFCcU1SRzVmbG9RR2IwaEhuMi85ZldHVkxJY21qbmhDL2x2MVluYW9xRXdu?=
 =?utf-8?B?YzBEM0xtQkJQODNkWjhDekV5NGpHSDdVV2o1ak4yRzlQZGE0N2MxMTFvRFkr?=
 =?utf-8?B?dFYwVTh3cUtFcGNXYk5lN0pQL1BBYzFwMnNROEdkdjVieDNJZXptR3c4VmNS?=
 =?utf-8?B?OW9ZekpFNFU2S2dQS2huZnFRWXIvMk42TEZ4NENSTVBGNm95QVNZaE1XcnQ3?=
 =?utf-8?B?Rm9wamFQVmx4RUVaQ0xPdTVNcnNPMytnRENQU1htb2g1VVdCVXVyYS9GZkxW?=
 =?utf-8?B?SmoxYTRkenFxeWVLRkhmanBXS2pGVFNPVmt1YndxNHQ1UkJiblZWUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9db4582-4e36-4846-aca9-08deedda6c40
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 01:32:30.9682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvAUp1h3Y1EdE8abx+TcFYn4W6MjRS72wuQdTHR+UOjiAltz5UAX4GoG9JzJQzPFM59sad8oWJtH4Rp/9nn/1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9648
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

On 7/29/26 1:24 AM, Alistair Popple wrote:
> On 2026-07-29 at 08:57 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
>> On Tue Jul 28, 2026 at 11:49 PM CEST, John Hubbard wrote:
>>> On 7/28/26 2:29 PM, Danilo Krummrich wrote:
>>>> On Tue Jul 28, 2026 at 10:00 AM CEST, Alistair Popple wrote:
>>>>> On 2026-07-26 at 01:23 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
>>>>>> On Thu Jul 23, 2026 at 8:30 AM CEST, Alistair Popple wrote:
...
>>> Just to orient myself, I'm assuming that by "opaque values", you mean using
>>> something that just counts up from, say, 1, instead of using real boot42
>>> values below, right?
> 
> No. We'd just document these as a unique magic value that identifies the GPU
> chip rather than something that could be decoded into anything else.
> 
OK, that sounds good to me. I was just trying to figure out what you
all meant by opaque in this case, and now I understand the idea.

thanks,
-- 
John Hubbard

