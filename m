Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121D6CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DC210EE7E;
	Tue, 29 Sep 2026 12:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KONfK1uC";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 346A410EE7E
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqEQErbJ0qZLOTA4+WodOZ9AxsHjDxCT+vEkEOqAteN/C7pHz3b5gzTEEuyr7o0Uhza4IWnjm4EQDzEAUEv35WmHsssRpMjekFnftNmL7cibzvkTFgY8qd6Dt6SuqpQ/L/f53HFwyTsKL+mr3GJGYmR1W1fR4LZjSMc8W4UViMsDcys9asd97E9vOk/vR2taq1OrxkKuQ+qfKVHQMtw85qY+c0X4rtj7XQgEisMzwKETcKm+BK+3H9t8//XEG2+g6RCn0e8JnTB8SSQkYhtpbFQtyx2Y5Y5YegvryGV9GOFqp9PYLSQ1XisLj+KdnS5e13vB4YBjYKURzpqwL6dGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/MTd+6V2MnF27F0L/18/PabkKqmSf/LP2ayaOZ93QQ=;
 b=akFT3svV/DNB24a4nSspyEHeigUHBULTTgU/c7/XrXclP+tYkAoEFG97XncFRAdB/kBXF9IjzNqPJu5UvSObiYpGfmp8LFY6uzeIeT2C+Y4lMQ/4UicAQAHpzzKWAc5ew02kuzMIIJYdhj2pRU1WpG4g9ABVf4nFypmHpNkUJJ7KI9mIAVwBVY3SxawEByiYB0LMCahOVm6zlijxx88dFCUZ07LFLXznvJ0mMoM1HblSvhqXp6MeczR+tiMv9dmj9p4p9QiJDKXgI3pqrMWdxPB5CIYCQCiqd/UAhn7RCFwLKKwjN5S0gr3IDcS6JTcalK4c6gmyCQDp1eO/vEnzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/MTd+6V2MnF27F0L/18/PabkKqmSf/LP2ayaOZ93QQ=;
 b=KONfK1uCEDJyFTevS8lkB1kbD3OUbZ+VMelRkqyxkghCgzvP3trIxqF0dRcJVnePD5VjWZfPp/qS8G4AtCCFlvhVZ2BSca4k6vWS4d2ywPP2rGoNZ+qNZ4G/wCpY1eYbXUb5ddbD7Ctii7ihrqkyamt3x/vGUfKOYg2rZ3hlz78=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 12:08:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 12:08:49 +0000
Message-ID: <7b54a4ef-600f-4e10-af1e-16790207b74a@amd.com>
Date: Tue, 29 Sep 2026 14:08:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udmabuf: respect the device's maximum segment size
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <20260926071258.77202-1-kmehltretter@gmail.com>
 <ea7da508-131e-4146-a737-5e8778866e03@amd.com>
 <20260928125853.GG163130@ziepe.ca>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260928125853.GG163130@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e48743-54a2-462f-bea8-08df1e226b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|6133799003|10067099003|11063799006|5023799004|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: B4GwGfPbxJ+kvNFfeXEGKOYiYkRVyxm2hMHr+P6FBjel/AOWWPsqp6sjB8MLV+rXEknNtB3aqUF5bBJSMkHf5yqpDEX468r3WSc20Jv8fb/WwSq20egPZEGv1N2SAOay+ulEviZhVbt1zqzlUWODPGddTNGmMQuAYh2i0or4cKYiJa7nPOT2wC9rOhvWMcwcxwaBgVnS9GOj7DHapPtl15ZzZOmXpzAopzodfEtDzGX0BcmVH79hFXjYPaAe7KZwoutwN7EKgt4N3kvbcbB1KkYGqENy1xsZdni2b/MwJAl9x4y5+/9sLthi0Z70Htmk6E7fX52U9ydQmzpJVLwmUkmyYHEXseKTShPOzlSTcUnHFq9l9Sgx/fmxuYD9CekElI/F1qSflAFrtqxF6cVxlRWSqFgO4ur2k+19cHk9QrMoGwTMFnOB/8qjKscq9300mNd+RUC48tglwvlHFsKr/MBy11FQGn2h500mkUOGAj8Yam/e40kRVIEKX6fLPv+0xyFvNvyKwBd7pT3ehajZ1NjklTiKFchD8vckji9Q7QUHzRS9UugSd6C5CWBQeFb3RWImR2xTRqOyY+B8dJlXITn7uzkkYhRwEXHC1L71sLJAkozfCLGh0Apme5dLIJsF10cTbMd2ptobLStkxLvZUT3u4jYPnY0lxvrDX7GAE20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(6133799003)(10067099003)(11063799006)(5023799004)(18002099003)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkxLaUszeklzdUpWWUhnZ1U3dVFZelNRb0NaQmN1RzYxZHYxNW9NVFVIU25q?=
 =?utf-8?B?VjQzcCtnbFpmUEd2ck4wQUVhd2o1akEyNmZaNmhicTZpbW92MThCUGRMSGIy?=
 =?utf-8?B?b3VBd1JNaWZmMkViWURyMFg2U1A1L2RiRWlDRFVzWVpRc08yWTdWcHNQUzV4?=
 =?utf-8?B?djNzYlFHZ1dQNC9rYjl5VmJIY01mNjRPczM0dThoU2J0VFZRUTNwSjNOWHZS?=
 =?utf-8?B?dEtFdy92bXlqT1l4bkswbWxoNDZaUjFXSVE4Z1hRYW9oMTE1cW1wSHFJNWF1?=
 =?utf-8?B?RWRHTlBBL2ZWbzFEcTcrV2FTV0pBYVJ1Q21ZUzQyMjdvNEc2UlU1bnMwL0lR?=
 =?utf-8?B?V0Y1U0R0Q0RKNnc0YSs4SW1XMVVBNDNzOUhFNUZQaUZXQTdIMjhvci9NNHNa?=
 =?utf-8?B?SUxXYllhbmdCM1dSaVZsUVlvREU3NkdlMjREOEloa0JvMTFyWUpManEyS3Vn?=
 =?utf-8?B?RkdEc2t1WCtoTUdPTWFlNnBqbEVhV2h3bnFYSDN6WE1WMlBZZGpBOXdLc3BU?=
 =?utf-8?B?RUNRaGxJdDk1NnFaMFZQc0FkdUlzSU9HUkxZV0c2TzBjdVl6QzBWMGdTODZR?=
 =?utf-8?B?cytVaUFEaVIxSkp4ek8yY1hRMUpEZ0p3ZVhMcGgxdnFuSzh3dS9tNUs2SDBK?=
 =?utf-8?B?ajZxL0RSU1B0Z1Q2NXRkOEFiOWY0UjN6Y2Vyc0JtMG82MVNNbTA1d1EveGow?=
 =?utf-8?B?VWRnY2orYTdVNDJQSjhJb2xmMysyR3RaakJjUkxSRHh3S1dEamhJSE5heFhz?=
 =?utf-8?B?ZURVdy9LK2FTTjQxV2NlOFFMSFo3VkhhWG95YnBEV3AzdWhXQmVpbXBhZ05T?=
 =?utf-8?B?M0NUZURDL1F3WU94Sm11Tm01Zm5ua1h4S3J1ODQzOFV1NzlaNDVzbGhHbjNx?=
 =?utf-8?B?aHA3Ymp1aWcwVVI5NHpQa1VmZ3Fwekhnd21YUTdsejdzU0lzVEJYSC92Q296?=
 =?utf-8?B?WVJOZDNMWXdLVkkvR29mN2gvRFEwUVVKbzVXL2FsWlVOQlFFT1ZvYjluWTNY?=
 =?utf-8?B?aUlyM3lMZkdPZUpNM2NaeklyYlgwYXgyNGVNUEhtY1pKa2p1TlpOblVMekJz?=
 =?utf-8?B?QWdIaG5QWkRscitGTUMyNDhOazkrSDcycUhMTEFHMkVlRDQ0SXg1SXM2SVBy?=
 =?utf-8?B?d21iQWZ0eXA3Qm54dUxxL095MnRmNnZaLzFHbUVETmEwelhOK1puNVQ5TmFV?=
 =?utf-8?B?VVo1Q0J6NVNTMU1UeUdieWI1bFhIcU16ZXZreDNRb3RXVmQ3d0hVckhSOFBM?=
 =?utf-8?B?QmhsSUdORDFuKzRvSGxJeExpVCtsb2VJcE1DOXgwbjRKejhVNnhGNThpYVpl?=
 =?utf-8?B?TGlubHZlZ3lYd2Z2VW1keHg3S2wyZ1diYkRURzlHRGdjaDdYN05rcmZwTVVJ?=
 =?utf-8?B?RFpBK0VkdkI3MzFRNWNoYmFlYTVENEp0clA4RWtoVFNDR1Rtbjk2bTBBenhP?=
 =?utf-8?B?NWRCRi9VWUk1Smpsd0tUbHhSV29vQVV6cFhIY2xUMUFrdHBQQkZlYzEwbG96?=
 =?utf-8?B?V2RTQTVETUJjTGxRalJ4Q0ZqblZCMGRxOUwweXpQSms1UjFXZllBZXN2WmhH?=
 =?utf-8?B?Z0NBd1dLaGhnUUU2OEExTEw5SGJqb3IzNldJSFdqd1FzWmJLSWpaUWdsdk1Y?=
 =?utf-8?B?T2FHWk1uMjV0NjhpZ1p4R1VMczJaUDJQUVFsNW1MRDE3MG9LcDl2RXpySmJI?=
 =?utf-8?B?RHRoOVdjQTMvakdrY1RPSVBlcFJwZ0h5SWNLREpPZXZ6Kzlvb2ZQQVBRZlYx?=
 =?utf-8?B?UzNmL2QzS1dxRmF5UzZIQlpQQ2FXYkgrdmlwNEZUWDRHaTRmYVFoYU42ajIz?=
 =?utf-8?B?ZjUvWWlDUVgzRWpWdXRvUGlCU3JGeGd1SWFLemlLd3VNY0xraXVjWWhqZENN?=
 =?utf-8?B?TEppc3BzaUtIZVFiVjVydEdaS1pyaThkOG5acGV6ZmNsMFFwSnd0OUtSQUJi?=
 =?utf-8?B?SmkwbjhLTSsyR0tXcTgycThTMkoyVlNNaFg5SlFjei9WeG9DMklzNnVtZkJw?=
 =?utf-8?B?dXVnM3pkam4xVDZCcG9aNkZ5bWhuNDMzVUdkSm5yNDhvTkMrQmFLK0gyanEx?=
 =?utf-8?B?WWlxOGZGZUpXWEFPVjFWK204ci8vWnJtZ2JnVURlREtURmpwei96MnBNb210?=
 =?utf-8?B?cG1jWk5TcndubTVtQnRCaWVPNmhNY3VHZDdOVVBtU212cm0zSjNLV2pGdWhz?=
 =?utf-8?B?RXVZdnRUWURZMEc1dGcxQ2hadU1aYkpMckhab1liMGVISTVVTEFTT0VPdWFx?=
 =?utf-8?B?TEFRUEhUVldlZGVvZnVESlZjYnZsckJnQ3BMdU9pYmJmQ3BpSENsMEhadTIz?=
 =?utf-8?Q?Oy6F0I9NKRVGHVa7xA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e48743-54a2-462f-bea8-08df1e226b84
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:08:49.5275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1HfGnvZ6YGEar6PDlUFZfz1BsSLPSIrh56SLk7JP0Bs0075ZV/6GSFulN3p3FUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068
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

On 9/28/26 14:58, Jason Gunthorpe wrote:
> On Mon, Sep 28, 2026 at 10:27:32AM +0200, Christian König wrote:
> 
>> In general I think that the sg_alloc_table_from_pages_segment()
>> approach is because of the broken design of the old DMA API.
> 
> The scatterlist and the DMA API use of it is very specialized to serve
> the needs of the storage stack without performance cost. Segmentation
> is intended to make the sgl entries map 1:1 to HW entries so the block
> layer can schedule correctly.

Yeah and that is a clear violation of the principle that kernel APIs shouldn't be designed with the use case in mind.

Instead the API should reflect what the HW does and needs, e.g. in this case what the bus systems and IOMMU engines can or can't do.

How it is used in the end should be irrelevant to that, it only servers as validation if the design fulfills all requirements or not.

Regards,
Christian.

> 
> Nothing else needs something like this but still has to tip toe around
> these rules. It makes it more complicated to map and then in some
> cases you have to undo it when programming HW :\
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

