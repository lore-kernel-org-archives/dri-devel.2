Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EFC606A6A6
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZICi5BZb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF4810E162;
	Fri, 20 Nov 2026 20:54:41 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF19F10E203;
 Fri, 20 Nov 2026 20:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tv26+4/S6wTCm57gHdS96Q8Q9UjsipbE+KzmNvZnJRVZLQadm/2gHoeYYWcXbSCsI4/mMfhq1XudbvzCpNevWTzcMgBKK1LEEBnVpY563QzQw4cuMuTsDE8RWw8oNvAxUp5kzCSFM6G1wqffRKGUhHQLEjGG8zgkVbUW4ul6wsnWU3kWsa1gqdRpZ02RUWVNSVNLQkCk0X19O6kOzWQCPtJ8H3uUA1pEp6cL6ige4IZngvNTQg3tP2fCRS25a5/g8MaWwIZKWF7F0SHFO5BckatphzsR1nKN8DD1LLYYQgGuac3C4kF/Lync5iz9GpZMvgBH5zGH7BL9u6K0c3LTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBXQYfcy1i8Bi/FlH/xlEHVkHpg6pZV4gl/1Ef8Zgyo=;
 b=upM3WgVHIVHgFBNb/F6qCF6/W8wZoVIZAtkTkOoNRMUXrwyx1IVj0dnshS4V59Vpc0gNpUV91yb0tBsML19vnd3PJIWgnnjsd2rlsBX90Tx0If1E1QqWT+iiu0gPGKDfdjGG97uW1B4hqKmpY509GRFJh4qJZ1Wfiy6WM1txiUgCOxOQQLQGhGI8uYMxWqGU9ZaBX8v6Ngmxs+iHo7IFuCBLwd+n8LLHclPBPj6gbc015EtGEqoWEJ7ceZGYlk4i4T/6+vOqgjAik/1pmIDO5FXIWU9r5cLRllTfiPN9MzgGvHgedMyaQEqwviKJafh1T5f0MzUNMZVy2pKoG5wYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBXQYfcy1i8Bi/FlH/xlEHVkHpg6pZV4gl/1Ef8Zgyo=;
 b=ZICi5BZbBRnzm8sNJzbWb2w62OGnx64RTLIuv8dCsS/Ruyjl548uREgZFW6fYtjnSGCjk8419fvpOr1He61DvptCgSLRmUEjL6K9pg8l5GSXsPvY6zreB5W3jIkOFsScEuxt4ZmO2qz0H/i9rUEbiIWAxA3gZPO11EDjWa7blBM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 20:54:29 +0000
Received: from LV8PR12MB9133.namprd12.prod.outlook.com
 ([fe80::d29f:9915:159b:b02]) by LV8PR12MB9133.namprd12.prod.outlook.com
 ([fe80::d29f:9915:159b:b02%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 20:54:29 +0000
Message-ID: <886d2fe0-ac06-407f-b1db-f8d7857282c5@amd.com>
Date: Fri, 20 Nov 2026 15:54:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] platform/x86: amd_isp4: add the OV13B10
 (OMNI13B1) board configuration
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bin Du <bin.du@amd.com>, Nirujogi Pratap <pratap.nirujogi@amd.com>,
 Benjamin Chan <benjamin.chan@amd.com>, King Li <King.Li@amd.com>,
 Caspar Adriani <caspar.adriani@proton.me>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Arec Kao <arec.kao@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261103155313.114347-1-saif.elden.hatim@gmail.com>
 <20261103155313.114347-3-saif.elden.hatim@gmail.com>
 <avMH5glolytc9L86@kekkonen.localdomain>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <avMH5glolytc9L86@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::8) To LV8PR12MB9133.namprd12.prod.outlook.com
 (2603:10b6:408:188::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9133:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e14e155-7495-448d-7576-08df4748786b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|11063799006|261026140227099003|4143699003|261021123027099003|10067099003|261022105027099003|261028144727099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: upGsmQkJIi7i4pNPwITUqb3IeGYT24HLRqVgxEiNVBMX0r7zMIfDPjdP66tvjFHpS2zEBk5ef4CVd9Rr5kTU1PppYtR8HZ++W7O6Jn/9v/UtqxOnfFQCLDtb2tk50O3SiWA0bKFNCEt3ulfu6wtmZJOlyxFAF+lAkLxFzCUUPwhYXBCR+GZe8MXiQAHINx8phkLgqYWQCPYqVyAPdrBFf+itprMOlToMFA9M9U5II2dq92F5iio0SZVQ0/dC2waF2mVoPkN2zaJ96J7PpMjnS3deJNOSKhCeuuaAwjP0DpK7Q4FpD8FrF7cE9zUaHqhYkSG8H26ejavDOQcAlVHZ1p3YYRwOzL8eiIFoziiab9OYNTnZmxeX4nujE1WI0T2kLybpDvqYNIcD0hbWyXpBYn7HVGTZYe6ngGVJz1XnByn3YnsezkO15SIbeZbFLe8wXDHhcqw6NyppLBPKoWbBrMiCsfvKfuQYVpzl2p2huB4XBPWozgaQn8fezH4+NnQw5vFxeHiQ2SvW3vOxdPPbNVERalYe6KDnDPa4ozHK92INSqJi+Ke/H2I+6NTuLWCzUm+7hu3m1INqXKIvxrFzgg/ZUepDEwbC5dOZkS9fD16bZiWv2a036dcxlb/Gp8vD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(11063799006)(261026140227099003)(4143699003)(261021123027099003)(10067099003)(261022105027099003)(261028144727099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JoR25wTmtac1h5VkFnUTk0MXB6aS9ySFRrZUtPeWZEci9WazZ1cnMvZ0RS?=
 =?utf-8?B?RmY5ekpFTTkyQ3VUclNRTFR1cTRDL1cvNUJVWEo5VS8rZW9GWitVOUV5SkFZ?=
 =?utf-8?B?dlltNWpBY1p6RG1NcnNMQzVsUFh1bFRVRkIxMzhGNytONkliTkE5bTRzUmVP?=
 =?utf-8?B?YUN2ZzVTTlNoOHZ1Z0xUTi8xQ1VRMFZiK0NyaklwNG1PZE0xTjNIaUtiR3lr?=
 =?utf-8?B?eUkyN1BBR3hGOVZaNjhIREh2RjZiU2RQZFhsVXV4bzIrMVlpRXhXTHpPUDVP?=
 =?utf-8?B?UE0wMU5GSXFTT1I2Um5CalFtSEx6TG1UeUJlSU1pWTcydnhiZU8wanVmeURy?=
 =?utf-8?B?RjhaY3d2S29HZlR4NlZ4YWI2RmhrS21LRzdaSi9GbUlrOUVCTVZ3aC9EYk9P?=
 =?utf-8?B?dGRjS2JMTm9WcTQ5RUJOL0NkOVE4aFNTRGE3RnZSVXBiejNWSkVYT01XaE1S?=
 =?utf-8?B?dEVoaCtJZTVtL044eGdyckcxZ3gxblliMEtsdDY1cGtZR0VDMFk1UE1lampu?=
 =?utf-8?B?Vm83Tll2aXhQeG5yWHZCd0ZxenZaRUw0YkFmTXNDdG1lYjRpRU9yUFdaTEVK?=
 =?utf-8?B?UUV4bGVqdS94aTQwbkg3dHo0YmZCZkNpM2h3aGMyQzhmM2xTWTIrQmhFbmkz?=
 =?utf-8?B?STc0Q0lsVnFmK1VMWkN1ZTlWM1hzU1hKSmZvaVdqekdEWkY0a1MvNS83T1Ux?=
 =?utf-8?B?aHN1RFRhVGJScW1SUGQ5VjNCazJ2SnhvSXBGM1NQOVgvdVNNazRjR0NEaEp3?=
 =?utf-8?B?THZpd3hFaFVCOGpLU3M5ekJHbVo3eVZGeGF2U2M2eG9SeHNIZVZSZDJuemhk?=
 =?utf-8?B?RTZwU1ZVUlRqbzlEbE5kWk1vaHNJVUNpSUhHdkFJcHRKRXdOUTBXZEc3NUM4?=
 =?utf-8?B?SGJLUDhmMXBlSHQ2Q2xTalErWDRza0VrcXFuZjhyYjJLTmo5bGZQK2tIclRN?=
 =?utf-8?B?cUpKNytDSURvSm5UU1gwTU1sRXR3T1N6ZmdvRnNFbW9PMkJCTCtDbXUwcUN6?=
 =?utf-8?B?RC9PQnM1ZTMxSktxZVBEYjUxbHkybUY1VG1EcFZ2TCs2VTM5czZqbmZxaTk3?=
 =?utf-8?B?UG1Cc1NqMU5zKzFsK210MEZWMVZEWTV3YXlXblNsalJ3UHI5OVQxV2E3RlRE?=
 =?utf-8?B?WTFEVkQ1VHV1TEtPZUNPd2lZc2l2dkU5di82eE1XcUljazN1ZDhYTjNEVG9h?=
 =?utf-8?B?N3hSOG1kbmxnMkVmRUhqWXhsWktkczBkSXFhUjR4REtEbkZWMmZ5ZENweUJX?=
 =?utf-8?B?cDVtZHBPWlJINEtZdE1GYmc0N2hZTC9rM0Q1cVhyMXNSU1c1M1J2ZUpGTGlL?=
 =?utf-8?B?cm1JdHNMdXNuWFdqUTZLc2dKMzc4eUxPS2ZOWEJocWNXM2M1UEJiUkFkY0xV?=
 =?utf-8?B?RExzTGhsRDc4aVUyOEdEZkpPS0pLYXY1V2cxWkpsTmh1STFLeXF6RFpjUDFI?=
 =?utf-8?B?NjJETVhMRDU0TmxWQVZkRm9wZzJRQXh6cU02Qlh2SWpTSFUyT3Rza2szR0F0?=
 =?utf-8?B?VkQwMjVwdWcwaDQvWW9CL25pQTVqRG5SRVlIWStaVmt2L2xGT0NlMEhpTHA5?=
 =?utf-8?B?Ri9ldDRrQkVMT2lGT2hjeHhnSVRhREczN3VCSS9aa1JnV0NRZ2YwTUdsNjlO?=
 =?utf-8?B?Um92c0JoVkRKTVF5RS9JaTl4bzllVWxPQXI0d3ZVWTZhYVZ2YmxNYzhFL0lT?=
 =?utf-8?B?dFlvOXZteEpCVG5QaGtMMndXYi9mcHE0cklYQXU3TWVYbmhYOXJWYzRvaG0r?=
 =?utf-8?B?dE9IeDl3MVlEY013NEpKMWM1dktaejV4UktYbjJrTDZlWEV6bW9TdkZWaWpE?=
 =?utf-8?B?UzJnOTVZeTgwaVJVM1JuUVJNWXNpSnViTTJQOFp2eWRTQURvTEl0Rk9oczMw?=
 =?utf-8?B?c2ZFeVVjcFQwTGVmYVVIZ0tPY3hnVVR5VU9nL2pXOUxYaERhc3pIN0JUNnJ2?=
 =?utf-8?B?M3dxSHhaVTg2KzhYdm5nckxjb3VmWk5scHZiSXVMYzVHcENON2c4WGpiN0RY?=
 =?utf-8?B?UG9adFBDMk5DazFyZzk3UjM2cTJzSlBrZGpuZm9WOHNvczdLTXVtN00vbUtZ?=
 =?utf-8?B?MlZkR08rdVlBcDNwUVcxZ3o4MXB0YjFmS3BQbklNRWFlTDRXVURuakdrVjB1?=
 =?utf-8?B?SW5HYm1wUERmbmExUWMzVysrbFNZUHVibThNT3JiV2t1d3cydXFYeHhPN1Rp?=
 =?utf-8?B?cVNYdFptbUZoRjdhcWNBRlE2V1RscFBCVUJwWXZEeUJGYVVqK3BQemNCY0JW?=
 =?utf-8?B?MWkyRTZBRVc3NnUrVnhscmtnbDFqMWVZbXh1TCs3K2hET2d3emJpOXM2bDJB?=
 =?utf-8?B?TVRxWHhTWEJpTk5HVDdDbm9pQXlLY002M0RrclR5RjNuNFN0NGJkZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e14e155-7495-448d-7576-08df4748786b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 20:54:29.5431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGOiDR+P1Dbtvd+JSthBcgLlYqWvTWq9/BkwA/5TaXFGLlpwtDPyiD6ccP7zm3qkPjoPBwttBHh6F2SrRbtpcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sakari,

On 11/10/2026 7:02 AM, Sakari Ailus wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Hi Seifelden,
> 
> Thanks for the set.
> 
> On Tue, Nov 03, 2026 at 06:53:12PM +0300, Seifelden Abdelmonem wrote:
>> +#define AMDISP_OV13B10_HID           "OMNI13B1"
> 
> Any idea who allocates these HIDs? Omnivision ACPI ID prefix is "OVTI" and
> "OMNI" is indeed unallocated. I presume these HIDs have been "allocated" by
> AMD? This is not the first time something like this happens but it would be
> good to avoid it from happening in the future.
> 
Apologies for the delayed response.

Thank you for bringing this up. You are correct that "OMNI" is not 
registered with the UEFI Forum. The OMNI5C10 and OMNI13B1 IDs were 
created by AMD. Since these IDs are already present on shipped 
platforms, they need to continue to be recognized by the kernel to 
maintain compatibility with those platforms.

Going forward, we will use IDs registered with the UEFI Forum 
(https://uefi.org/ACPI_ID_List?acpi_search) i.e. "OVTI" for OmniVision.

Thanks,
Pratap

> --
> Regards,
> 
> Sakari Ailus

