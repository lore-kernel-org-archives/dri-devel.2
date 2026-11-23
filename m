Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915E606A336
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pU9Xrfa1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB12C10E6E2;
	Mon, 23 Nov 2026 22:47:14 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBC9210E811;
 Mon, 23 Nov 2026 22:47:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqgwdSqXFYmu/yA72+P8U+D53V0Bf7ge4m2/OjR1SLMMQLEAGMbWDSij2ixQ8tlWqWkeV2nifq3JYskgzOvXWL+hhfyuw/suCXustFENuvvBuvPFMeo9EVh8QLmlOVxwo0v1wrMEuxR/x+j2Qofpl+svbU5JBXRookTi/zFWzZfe381EjilRDax11mAM0W7F1M34HCFk2QAO+cfIdDZvps4Q7oXG6eFYhHqFoAGqImhk6bd1gqMNfMpkLyLKULU1mLNAL030UdkQHqTwXEjy15kiX2J6UDNFYM4gjkz6MbmyhNjfOKQL7lavBSmDCBMKjMaAHwHcwjnkUO+wRALs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3CRrODd15UhWro5byYTORAmYIqtvFX3fmb/Dpyz5GU=;
 b=VLZMTYSsPw3LpyeD64OUQJxe5ekGiA5UMR8XXF4AjIRWeHJi7k4vmkTyfS+tmG84GvLWvoh1QHpYgRHAqweHdYCRPug39QjDrIoXP4cww+Cx2AlbawzzDDhbtDEYTo8g8mnVmGbsYe13+zLtIcufeJcyX7T8N52unawFTNKEkU06qBRaNnJ0Z86Qsr6QbTW2RHlTJ7D6ByIn769oqn6SceM2v1JfkFe86o2Kp/+h39HVh6vtA5Mdo7iLIO7AVBE5EilXJxG6R/g/rBTQWfv+TvHs7WoY4V9XqZeRlhU+4DbiGBdRL8u8l5kqMQzsKWf36Qhp/z86geefxylXOQuZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3CRrODd15UhWro5byYTORAmYIqtvFX3fmb/Dpyz5GU=;
 b=pU9Xrfa1vxDPV1u9Fdfh4i80KYOzPa0+bAJsbAGVuVNhTt33/Jepkj00MVL0Xmol9LMRKAogH1RuwtAd2ivqPRXPXAIqRjOBKPDacKL9wurkIebf9GvTClAdZFJ8cehyUCYIFZmGSEfgnNMPfIVisI6iPnO15mBpMHpmY4p7tqYFcvCYdUX7j5npyGG/KivppQK5VZIASklxAvZm5/xguIhiAepHeSOLFBvjS/ZMGVm/xZ34WInNGSKQxru3stpYVuSN9MC1ywcied0e3T1rF5w9utkyIEIzYW+ZvtgDB+NrqqVOkk7xSFACchCjYyn2gGyrAFJxGpf0Y8Ap4PVSLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Mon, 23 Nov 2026 22:47:04 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 22:47:04 +0000
Message-ID: <a02b03a7-2aa1-4ac6-866e-dfffc9ff2f55@nvidia.com>
Date: Mon, 23 Nov 2026 14:47:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/nouveau: add option to leave GSP-capable GPUs
 to other drivers
To: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@redhat.com>
Cc: Timur Tabi <ttabi@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 "lyude@redhat.com" <lyude@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
 <20261123-nova-nouveau-gsp-v2-2-5e8c27aa8555@redhat.com>
 <617a6fcc6a541f27351fb7f5abe21fb89553438a.camel@nvidia.com>
 <CAMwc25rDmsXw++KeE4OhTCGCq0PRUZJJQaEMXY2dbvdwWzyL7g@mail.gmail.com>
 <DN2WGM8KWOD4.1Q96FIYG22NA0@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DN2WGM8KWOD4.1Q96FIYG22NA0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ea2935-9a45-438f-7561-08df49b3b1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261028144727099003|261026121527099003|261026140227099003|261022105027099003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kNOPsdDruhS6Lv7ZwLM63q3io0ObI390p5BKkijgb1PXgJBYHenXNy+R1YbL2/KP2MawHQOvLkqEmqDmqAtrD0vlxx+7ea8/t/vwwO3zcAqBfcgZJyCvtfAZzQgHW/BZGnfDRO5orcdBc5gyV8QV1zQuRTIF0+BugGgOEWlrwP5jqeIGTZkBTgkCvEKU4AVoio6F91uTFTUETM+56rNsRBx0Cj/6reHLgYB3BJElT1a81qqyF48nZu6Nb2d901xXDV34iymPURpXlfs+/9POvUaOjqS2KVJLNfAUiRSfBwS+75yu1bniAWSmZsIhPjOsiar3O2pAE8xw6KI9Qu8LrvDOzeMNtVg1ASbh4kZOEJOr4ATMhNSHm7rbv+QpcVpi+H7bxxIHbCej14e3pjFQRdp2hUSSz3+R1xBvU8L/oh6w1JlOQLF2jXWdK7cBwBjTA0bA2VesB1cMVw93d/09RHGR4nSZcKEwm8lB8iREzXGN98Qt99QFWNUmPbj+4DwXPziNoCJf9nbZOA71Qh6int9VcNQqs7Ky0k9TnEA2dgBQgbkRW8GiuiGJACWJsUNdE4Svzcakj7IcLbPK1QvpJPq0p4t5SLG7Sc5/dcl0m4omzwZW/f90bNnWRwjqlbUnDx1SxxpcXS23q+cDnglbgOcyycFwRhbQV6N18Xvh/Nw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHhneFBGSWhxZklOTGpldHRreFlQZTRrU2tYQkZDdjBmYVpZMXh0ME1SZjdF?=
 =?utf-8?B?NEtxNEgwaDhlMURmb0s3K3pFeXdBZXZIZm5IZXMzYWFqK29sY1VUL0Vzbldx?=
 =?utf-8?B?eXIxeko0ZUJMM1RTNWVxVHFYT3FrazJtWk52T1A3V1hRWWNWR3haYWlJT0xX?=
 =?utf-8?B?d1o5b1JvdnJ1alBxVnQzVmZGQ2hDOXlUUjVLZ0YvQWRpVDRBMzNRMDNzVFJC?=
 =?utf-8?B?ZEdpREtIWVVZWkdISTYwSkJ4SDN6bkVtcFRrWGxEWmpOK1J5Z05oVXlxMng3?=
 =?utf-8?B?K1BrUkpvY1VubWVsTFFOaTNmNEZDMDZCcUNNOWUxTnV2a1Rld2xyOHdiY1ZH?=
 =?utf-8?B?R2p5UXpXTndtVEJnaXp4aU5BUVVVVDhXeE9Ram5DaEVkRUROT0hlVXBoQWRx?=
 =?utf-8?B?NnJNOHk4bWdHR2xXQ015bDBGaTJJSE5BdWg1MlFpTkV1dUFpK0R2akNkb05j?=
 =?utf-8?B?RFVXUGwzVnpQWVdFTCtkWnRSUERucTcySGpwRDhiSmRCbGhCcG91eERBOUVI?=
 =?utf-8?B?SllPZ0gxZXFEbDdJQ25XTlFFUGVSVHVsbjF6RVlyUnZkdTJQMkJBSVVDSlVO?=
 =?utf-8?B?Rk5FRE51dC85NDZBU1lIcjJEUjBiZ2JTRW9ERHZ1RGI3YmhjNzRPcXZZZXpQ?=
 =?utf-8?B?KzlKODR2ZjNaYmNmTzdINUFOcXJGNE9DS1pQZmhEK2Y1NUp3T0dFQ0V4K2VH?=
 =?utf-8?B?ZGYyM1Z0WlgrdHZJaDY5c3JvRDVoNDVMcnlxZDRjU0Q0NlJUV3JtNUlycnM0?=
 =?utf-8?B?eFRBV2h3OTV0UUwrVjVtaVVqYUdUOE16VzBmN3NVUlBlVE1jUzFCYTNKSk9h?=
 =?utf-8?B?VkhEejJ2RUhjNzZMdk1kbUJORFVDc3ZTRmREWm4rbFI0M2lQblRlcG9oZndI?=
 =?utf-8?B?bkNLNjB3T0lDNmhwL3lWV2JNVWJOcDFBbi9iQTNDN1BVOGZ3WW12V2dlek5C?=
 =?utf-8?B?Q1ROaHp2WXhpWER2ejF6SFkzOXlJUWx1YVJlTC9idThsZ1c5UjQ4amhISmhB?=
 =?utf-8?B?aVo4cVNQTlZMeTRMV2pocnJKd096M05CdVYwRWlWM0NkOUVjK3I3Q0NjWExC?=
 =?utf-8?B?ZVB6Z3psS0lGTW5ydm94UHJMMWJXengwMjNHREFBb1B2MFVacW0rWlA0MFJr?=
 =?utf-8?B?VmQ0dEFKSGVqZEcvdUtRZUZSYjZPODByclFVNW9OeDhoUS8vcWRTM3F1R0k1?=
 =?utf-8?B?OEV5cUJBc1ZKL1FIL2RnNnNsYVovbGVOb2lsUlRVSGpWQS9qZDhvV1FRcHpY?=
 =?utf-8?B?MEZOeXRLQ1FqL09OeGtudm1uSlZIRWhoeFNPeVhKVWg0SEdjdG1LeUhGTDRW?=
 =?utf-8?B?anhBL1hJL2JMalJ2SXdaRWJJUEdvWVFqV0NJaDBpOTk1SzhLMm5zMmpxVDgx?=
 =?utf-8?B?c0MxYVpBQzQzcFd4NjQwcUdNSk5DUnpsT1FvcjFlUTRjbnZqRmdjbFdUYWdV?=
 =?utf-8?B?ekxSMnIwMFg0QTkzRGtUdWNkdUhVdmJ1VHNLZEdubFE2NzQzV29CMTNjb3hY?=
 =?utf-8?B?ZTcxZll1S1hHNHdmTWRBM0NYMDZMUjByRTQ2RkF5U2hkMVk3NnBTNU5PanFH?=
 =?utf-8?B?MW5hWlZPcENCcm9RdzN6THRlR0JuM0F2cUFhWUZuS0xyQ0VEanc2R1VCdTJP?=
 =?utf-8?B?M0FtSVppSGhPSnpad25pMFdsMm9OeEcxdWRKT1N2ZWRLMEs0UHRCdk9WdXFH?=
 =?utf-8?B?MlJLM09LTnIvMkJKVExOblFEQkxmUTZzTlh1UWNiMFcrcisraXRWZmFNNkFP?=
 =?utf-8?B?RjFqOExKT0dkU3Y4aVp1TVpZMThQVzUyTzBhYWhPMkNtVUQ0Z1ZmOW5CbTBr?=
 =?utf-8?B?aTFwdDJsRERyQ3VaS2VQVnVvSXlTTEZYVFhSUUY3a3FyeVZBV1RYNklQK2hN?=
 =?utf-8?B?VXNZM2MwWWFUR0UvazlGQVR5dHpGOXZ3MUdzUlhkKzFXTUJBVGRaYUdDeDdl?=
 =?utf-8?B?RCtMMVlZUHloOXNIMWlRZ29IRnNrMkRyaUNFVlIvbjV6M203QTFGRkZSV1ph?=
 =?utf-8?B?WmRVbzNYQ1orNUpuN01CLzB6cHcwdFk1T0tjLzRMaXlGVmV0b21ZZERKZ2px?=
 =?utf-8?B?c093YldWdkpOUXkySTQrWXBQeDN1TnAwdXhueVE1b01CWGRjVkZFN3FxMVA1?=
 =?utf-8?B?RVZDUEw1b3VhQSs0Y1FtSk94QkpwdEs3aU9URTM1VG4yeEJKRDREd1hjS1Aw?=
 =?utf-8?B?MFlsY2hmRjg3VlJLR3dzWnF5cmQzM25qM0pBd2hWKzBHam9JOHF6OWJIaVo2?=
 =?utf-8?B?K2V2QUJFcmR0aDhBSXJ4M3hTaWw4aFUxaGc4cnhHVTJBcVlsWmlNZGxCU0FI?=
 =?utf-8?B?ejEvUzFkbzZHNUVaWlpQTGszTlRlbHVxZmVEdFpLQUdBYnRSVDRuUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ea2935-9a45-438f-7561-08df49b3b1a2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:47:04.0399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07SxiMpQziVJRxbRXNBe3s0MwcxbYWfaTSUqVgnVmFNN8YPu7aulahwWDVcbdWiRuuIrg9qMx4EU/JOe1DNbXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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

On 11/23/26 1:14 PM, Danilo Krummrich wrote:
> On Mon Nov 23, 2026 at 10:11 PM CET, David Airlie wrote:
>> At some point we need to give the option, but indeed we don't have to
>> right now, if nova developers are fine with always providing the
>> command line option then we could drop the bind options for now,
>> but I know it can be annoying for devs.
> 
> I'd prefer to go with a Kconfig option right away.

So would I. It really is a touch less annoying.

I'll also respond with a review for this patch, shortly.

thanks,
-- 
John Hubbard

