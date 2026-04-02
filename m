Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D87AD6AAFD
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14E110E10B;
	Thu,  2 Apr 2026 19:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zzlGFnqM";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F32910E10B;
 Thu,  2 Apr 2026 19:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPKKVwTkmvnqPI7BozvcEQ1Rb210DUn5/HQlj2cod6D/Zgtkw2U/UyQsveXTeGTOcfaBJLj8nMnt9wZ1r1pa5t+VYpIn/WASrm6nexqcpObEVIEeHQl6ZrDxQkoAR+53hP8i4HuG9gjIFqZ267j4aKUTsDcg1MFj9cDapDQe3YzN5GvAGdLavkZZlw90EEUML6WxseHPSKAtJntuCdRkBqCosrP3GU9Ihk4DTUh4UGNegNqQdEWVjNXr+UscXW0wZdkc4v13j2wboppfuz7xCbz52RFLLtYOb1H+ZFLNAaVv3Y9awdKEdjSixNOHKHilTmxH6I+fxZI31XAqR7fuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXWp+OGMB7Njzqq08rgnSr+SNOfGBGtnwouQaw+mz0M=;
 b=WosOp1+4xkUrAD/HIWbB5IT1fJ8cyVAjDhz06zcArLtFsKWfVlqXjWw0I4yHjl2fvsJqmp3IgvXQ0WWoN52ZHXxqhNpvLuBjYVjg865FYg6M7tgZsWoHtJZYaA3homohnWaWTxuDj6IFUvhIM2EL/LKKSp1UtN3+E6FYPvncs6t5xToe7WwHxWSWj2eHDS6Ojp52WPz/5AbwrppiYK2Rxj9ok60c9NmmVxM9fdd67eHKPc2Eg58eytRqTxSS4eyP/vWWwpXKZCQ5lr00Cscfz7VvSj6/e2jWjAixU79l9GOYCxCfaaGh8tzwt97n/ufPsIwOWl2adfCAgUWtCApqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXWp+OGMB7Njzqq08rgnSr+SNOfGBGtnwouQaw+mz0M=;
 b=zzlGFnqMgMQe5NnqQgwEcNC9RfytYUY2ufbUppxGScLMQcRPI+cb2rgyk500SdiPNh76Mndz1FXu6jRgGAxG1JR26Oe5QrePfMVmE4MiWDmy+VEvbVSQ6KFAS2ailhstLVnpBvEoyyNow2eQTbaPzV2LW5+yR/UkPuaZwjUpHZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 19:10:34 +0000
Received: from SA0PR12MB4384.namprd12.prod.outlook.com
 ([fe80::e7e1:4bbc:b573:74b5]) by SA0PR12MB4384.namprd12.prod.outlook.com
 ([fe80::e7e1:4bbc:b573:74b5%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 19:10:34 +0000
Message-ID: <7b522135-570b-4c99-ad4a-0d6060a85a8c@amd.com>
Date: Thu, 2 Apr 2026 15:10:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Wire up dcn10_dio_construct() for all
 pre-DCN401 generations
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Cc: IVAN.LIPSKI@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 alexdeucher@gmail.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, ionut_n2001@yahoo.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com
References: <22eb66d8-b74a-4e0a-9851-7e39c7f950cd@amd.com>
 <20260401071446.91826-1-sunlightlinux@gmail.com>
Content-Language: en-US
From: "LIPSKI, IVAN" <ivlipski@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260401071446.91826-1-sunlightlinux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::28) To SA0PR12MB4384.namprd12.prod.outlook.com
 (2603:10b6:806:9f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e5b9b6-3ae6-4bb1-93e8-08de90eb843c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: EjqTA/2hHk9wc1QjOFOsxrkyDYRQXm0sczFTJpBQsFerd42BmDiCd/ddj6ojiDbYXc3dL+Tp249x9FiKb93CYRl7XqoDXp6XKANGygh/7wJV1UwCyy20fW2jFCkb5CX6nO4aXiVQX+/K0NimraGWoLB3AdY1DN6CkgVi5cgx96PYE9DzaszpnFijmaMvc89Y8prWdZQC0KGCpLOnZH8GzODau+AsncAbFYcc1VJG7kAWdF+u07ym+CAKHNRyaHud8tVLsEmjeanBN3NbeIsv84vPqh05tXUMnBa25lykbiEncEf7DAiKyWvn1CuQobCDuuKXshinbEciB1A43qaSpJwEzF2U05/eTFwYccvJI5mzP4GwlL1pflIqs3WDMm25ohXeQfLLbASuGPvsCE1Ob6c5f1aJuVMtXoLJHbJZzX3fCw0uOv1j95NTr+fRZyzZj+dKWy8goGA5QiefeWwG0cjDAVMYITyev3GsbB5bdtXsMEdS9bhe57hRwmcy8IHabi/YHSqDrGqBMxNTe/zJ1ZgthdjhUE/QU7lPF3X0n/r8umTqp6GJJfoNXffee+W10qyUfwjjeAgKlYVw6le8q/ur3iDU+C5gpTOFQu6iJgakoPVo0v6LUBEe95hBxaN0SG/x2pww8uSZpue7UUrkPWeDPYtipwmSfix2rw2gXt9dZRUOEi6mssbRB6fayrxIChC6LWORKfHAP+BjMUDezNyjsxQ+uxbvBvGQQb2Jbpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4384.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FDUUViMTlqTHBvUmc1WkxpcmkxcDVFUlovU1NkenErUC9OUFpTZHlSR04w?=
 =?utf-8?B?cVBCMmREU1ZScFNkYVFMMlI2alFDQ3F0N01YMnFnVVBlVFlXT3RSNklEMVRS?=
 =?utf-8?B?QlJZUGNtU041ekhEbEd1RU0vMUVUN3dmbTc1RkRBcERkMGxqMUIvRERGcm5U?=
 =?utf-8?B?UDhFaWl4UXZKcGN4d3FZYXAxZFJvY25pdld5RGY0VmFDa2ZZR3NTaTZRYXNQ?=
 =?utf-8?B?SjB0cmdQdnZLRHUrTHdjQ2pZY3gzQ0Z0RlhwWkJ4c3NyOUVDQjA1L2w2RGZi?=
 =?utf-8?B?OXhRZkJhbWdnN2FjbnJwMnk0U2F3ZG5SMXVPRDhvN0xhT0hwZmhtVzZkQzdL?=
 =?utf-8?B?YTZyMVdnYUZkSHN0YVRhemNscWJzNTBrMnV5K1p5YnluS3M3RFdYemtGUlc5?=
 =?utf-8?B?ZGx3eU5HRHgzRlB5NnMyUS9XcDFJcmIxNFhlVDJUcVdZMlJNejhOd2trS20z?=
 =?utf-8?B?RUV5THp6d1IvYU5OZ0psNmNLWVVCRmxKWUx1dE03OE10dyt3aU5sdXRzbmIw?=
 =?utf-8?B?SU84TGJrMTVkWndpems4ZjdrV0ZGWTVkRFZXaVpEa0V4THFDOXNyM1Z3Nzla?=
 =?utf-8?B?SGZJaHJJL0UvK25DRDQ4Vko2NkxVVDBsaWluamh1L1hDQzE1SExTN2hMTFJ5?=
 =?utf-8?B?YVZkNlVIeDU5Y25zSVBLK3U2bEY1UlVMQWs5SEtOd0hTbS9hMzhwZGhzU3Vj?=
 =?utf-8?B?MDBjL2QwNEdqRjFSZk90Qyt1NU9WMzY0MXN0RThrR2k5V2tJcFlGRm0wYjZ6?=
 =?utf-8?B?ekJLL256bTExb0hhRFY0a0pzbzdNYWMwTmVGZm9jdVh2czJvWGMzRVBkTkVj?=
 =?utf-8?B?Y2RZVm9mNnZMdDBnM0k4L1I3RVVjNEF4azhFT0VXa0pKSXJsMFAzSzZZWFRP?=
 =?utf-8?B?Ym90U0c1NTRoQ2l5aWJxVTFHOTRRYnBRbFhMWFQ5akxJNzZoVnppYnNVbkhF?=
 =?utf-8?B?bHA3VG9jdTZaRUhuMm12RDJ3UVNJUUEzQ2tjdDJYQ2Y4SDJzeDRrb2RZQ2tE?=
 =?utf-8?B?dEZTdnlST3l5dGVQR2hmWHlaT1d2bmR3NXVHa1Q4ZEZMVmFuYURZdXdubkpl?=
 =?utf-8?B?R1RiYkR0OFlpVGlXcVJqNVFwSlg4N3Q0Smx3ZjVlUHJjWW92c0liWXFSWDdZ?=
 =?utf-8?B?aEs3U0JNdkJjOW5tYjl2enRWak9ST3VNQlRMaElYV0NEZGY0OVpRQWZvOXli?=
 =?utf-8?B?U1RtdEJsdTEyTjhpTExDem1QREVRYW9mSytqOFZDZnk1Wk43eCt0QmhacUgr?=
 =?utf-8?B?OGVvaTQ3dWRrMkc5a01UMldBQmpyMXN4T1ZWRUtuMTVCelZVM1VlUDR4eUpz?=
 =?utf-8?B?V2ZVbmt0QmNmWnZqR0hzcDJoWVNOUkhjdWZhYThiS0Z1QTcwTElNRzB4dnBo?=
 =?utf-8?B?aFhUcXdrQW80aTVHU2ROM2dWemEzZ1pCcFQ5SVNWQkFxMnp3dzlWbmQwS0pV?=
 =?utf-8?B?VHBZTXdCdDhCaVRZOWhIWG85R3BQMS8yZVRndS84MkhTWGFwWUwzM0tUb0dD?=
 =?utf-8?B?S2RQaUJtT2JLbWIxZlVZWGlhTTVDNG55dXo4UDFCeHZ4YmFyTzlMNzRUbHJt?=
 =?utf-8?B?SHZiMldmRjFCUmpkRllzd0I2Z2t2N3VoTHBIT3NVb1VFTml0Mi84Smx0QnRv?=
 =?utf-8?B?dTU2anlrWWxSOEJEeEdMM0xQQmxkTjhYQVZRNWVFM2R4UXBuL1N5SWVzODMw?=
 =?utf-8?B?RDltOGlQRFcxQ0FsV2JPcGdhaWs4emlPUmVIWWNIYmU0bEs1RmVTSnR3RVlt?=
 =?utf-8?B?YWpOdk1DUlVmMG45QVNDREFnWVh1MHlxUW00Q1FmOGVQcjFqU2pkU0RaMENE?=
 =?utf-8?B?YWtWVnJmRjRLbUZvM2NweHVxa0prdnlwUnQwM3NVK29HTzFXLzVLNWI5MGV5?=
 =?utf-8?B?VTk5T3JzODRzaVVzK3hQT0dXRmJVc3NUQ0QvcWF3WWFkTUhhN3p0VkU2OHVw?=
 =?utf-8?B?OFV3NFgvRDJJSUhia3QvNjdtQy9NckhMMlJuM0xTOUtPSnhSdjZTbUdEOE9k?=
 =?utf-8?B?WU1jYXZLaDkyWU9WcHVVSnFvVERjL2pJVTYzZnBSRjF4T3k0MDAvd2paR0tr?=
 =?utf-8?B?U0tGT0RwZ1Z5b25pbThhMUpCSGNzTmUvWHp1VVVZbXYxb002NHNTRGlKanlN?=
 =?utf-8?B?aGlHbzRHR0JXSTJ4T1RGT1MvMC95bGlOLzBUdWs4NTl6UDd6RnRjNTJXa3BX?=
 =?utf-8?B?VzJES1Q2SUQxcS80NDIvTEpnZHE5d3NWam5VVUFPRUVhNFF0QUxEN2V6Z2pD?=
 =?utf-8?B?K2pVa2NrbkFWZE42bDY3Q05URWk4THprRmdsRWhETnJpWnNhVlh3UFV6VEwx?=
 =?utf-8?B?L01XblNLK1lrODFWV1VlTXhGUFJ0K0NHdGJpTzNaN25vc0Y5Uzl5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e5b9b6-3ae6-4bb1-93e8-08de90eb843c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4384.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:10:34.6236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGZGjJe7YQN5t8aE0vXHB9Qx7cjkvJp7yLptyOBtKSF3ZcU8Nr0TBAvWLrYrEWC+KuFz3eLV4weJGZiEoiMR7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
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

Hey Ionut,

There was a compilation error, so we changed kzalloc_obj instead of 
kzalloc for dio_create() in dcn10-36_resource.c, same as dcn401, ie

struct dcn10_dio *dio10 = kzalloc(sizeof(struct dcn10_dio), GFP_KERNEL);

With this fix, the patch passed the promotion testing.

Thank you again

On 4/1/2026 3:14 AM, Ionut Nechita (Sunlight Linux) wrote:
> [You don't often get email from sunlightlinux@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Ionut Nechita <ionut_n2001@yahoo.com>
> 
> Thank you, Ivan, for picking up this patch and for the review.
> 
> If any issues come up during the promotion cycle testing, I'll be
> around to address them.
> 
> Best regards,
> Ionut

-- 
Thanks,
Ivan Lipski

