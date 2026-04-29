Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEBBFF887E
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB8610E3B4;
	Wed, 29 Apr 2026 14:32:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aCwGrNDu";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C87910E3B4
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CR9ajI9C057AWPyBWQNxWKWoPX/LzJ+JcrMmVw2T5ofOMOx2Y4RF5P2sDcqlMIOeQr5UMI+W4XZ0cRVfdxHLt5Bt6K375rS1mEi68uUj4xVTNnnPats9vP0WlBgnbjvy2DkZpq+UHN3nBwIFpVMBCwO0OfW8BVTUS4jh6nzAK77VlOdzcJ8qsuvAloQXsLDXHh46a5bqj+MO5vEIHWoIyx/1MD098Fl1yl2TrGEDJcKXeljwkKR7SRyzLGmmCOcEXFp1LEMDkuCK+KpN5EATvriJOXC7UnZoIkYwDUrZUPAvI41+RQlQDoyAlZWai/GSUE4ALC+l4ItSOHEdl6w3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4obcNYRUq8Y3tmt42Zqv8hOTW1+1kJ6EKUWtrdGjyM=;
 b=H9NfOkXj/CHS9ju0IcvuFgg3VzMwMiPd4mrljmH7aveGcz0U/ybqM+W4qgaLYDHVEl1By+XbNUhCTIflIhzRV36NMAk6W7lJmIkgZ30E8xR1zMUcaeT7G6iyXnT3aylVxunyvt0G5ZIe6Qb3QFVQi+RU6kAMIpqb9LGSBi4LyPNYWjOEhX2RH25iemtXcCDR/oHsBsDcHNTWHAAEMVEPpnsSI8z3u2WMwzZmtdB8btrXXf4uu7XQLRUS7nSU8ogKJhdf/wJWLQUNfwnmM6j46wAbEPwmNo14y3Ket6FVpyjcdboNgdYngcia7yPFS75BUohwwGfRTQ1ZzaAmV/SV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4obcNYRUq8Y3tmt42Zqv8hOTW1+1kJ6EKUWtrdGjyM=;
 b=aCwGrNDuo5lcQ2MqfIs66/0fhMo1H/Opb76Z85eRLmrVhOFG4EFOZMLluHbo/IvUQIr3+KGufLCAjW5koE5DMNJYLaCZj/uucSD/OksX5x35yQ6Fo/czyL7JvTbT7uq2OWQsK1ujFvt+oE+yRsOROzasckywpArwSR5agaogfkLdukXzq9lH9YirRpl2CT9bZ7pwbOT/7EKU+T5acIWQ7hixeI13HEB0oVQZE5yHDMVNzdQTknHCiGUyh6ISNC4coY6E0bueLk5+DDCcrI/tmhxMIyYMszwszLALyX52n4Un2BMnJLeC5u8rgSvz/vZJ6wgVf0I5b01/U+NEPhkF6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.16; Wed, 29 Apr 2026 14:32:41 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 14:32:41 +0000
Message-ID: <76d35553-fff8-4de0-9815-3a2b777e43ec@nvidia.com>
Date: Wed, 29 Apr 2026 10:32:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] gpu: nova-core: vbios: fix various cases of
 reading past `BIOS_MAX_SCAN_LEN`
To: Alexandre Courbot <acourbot@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
 <20260421-fix-vbios-v3-1-8f648aef7a85@nvidia.com>
 <DI5O794IQL4T.1TUZKR7LI9MOS@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DI5O794IQL4T.1TUZKR7LI9MOS@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:408:e5::31) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab6c554-cea1-40e8-f063-08dea5fc2b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: YnQLNiChoExm4ZSteMQNLTVF9iBjbXXcKSat0hnL56Rz7Z2B3A+oAfXCuXAnhjEMzcMEQwDAgvutbOOP+3kuGp7QCw95Nr0NDD6iaEqPP07sCucD1JOp6lMdoYRDEPJrUMq//m+aRVAj/haEaB5qxeovCXOAORJD/UMoRNkkVI5dliWprxMQJ2begBxOfACirTM5CMMLZHq6U50sVs+W68u3EiyfOH0r/jdH4X58vX/jTlUa9A94KzE6M5q7fLqeK+QPw5N422VbBGBcFoOJWBnlbndT6uQ4ruCwP8coUeUfeZAwMtMsfLCt8dzeJ8L91a2vtrD18/ONcEXizxcH8dt49GW5/is84BvlHC992b3dXE7WJ04A+XWqajTwmWzGn4liWSSysD0S4gYDOr7TeR08d5wA1FgrUa0IiUcPKHtW4T10rq+5al29wF+3kyQLXZRXxxRZNxDE1X+Avg7MJN6HlVfh5PMBBi/WykbTAb2CAvKxg/hnuLF28lq/2wKm5pouOXWUJ/d+Ym21b7Nvtfh37I7+FHSPlFebpPkGLvsYiVfn7cJIH/Z4xzOoaK62+i7npQnI8UM+Z0PB4mb/jDdIKPqIkhG+TFd2HCqxNAF8Wykg4x0feQT/5k5OJC3rmTffKdOJjZmmbyywfipCdvpNQsO20rLcW3qpKsFN+IKbprl+CMuG81cLr49ZdKG1ziD7ZBmqZb467nLp0xZUw8JvAlpZ3fDdW5FHt+Q6eLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzRkY1d4K1phNW5HeE5OenhLQ1QxRDQ4Q3BhRjVHelZ3cTJPRXcvUFVpNE0w?=
 =?utf-8?B?WTJGZWIyUWNpV3owSHpyemlhY1BJUXd1RjcyT1ErWUtOaWdxZEpyelBubTYv?=
 =?utf-8?B?Ly9taEF6NWYxdU90MDdJUmwxSDYrMTVqNTV1dkJzS1hxUGJvU0x6dEVidVJU?=
 =?utf-8?B?OVd2QVNXWHZZakFzSUkzYmltNkl0ZTg0VlBJTERoYlpHNSs4OTVkK2tDOVFO?=
 =?utf-8?B?OWZaUEZTL0phOFhsWVhxRWFDWHROdnF3UllBdzEyNlU5U21palpBeFNXYmRO?=
 =?utf-8?B?WlQxdDIyZFJTTFpmaXhVS1ExUXB5MGxpcEgvZjZGNGljdnR2VnhHeUw2Q1hs?=
 =?utf-8?B?aWZGdkY5b09hdHV0d29nV0VDRUo3YmlSZitudGNTa1NLWmFYSkhBWEJ2ZXRP?=
 =?utf-8?B?a2tIWDdZeVd4SFc2dkViWGV2UmM3RlhLWmlYTU5RdHRMQU9ZTjFUZWlnbzQ1?=
 =?utf-8?B?YUVSQURINE5OL3ZaNmMwOFcrOFBhUWM0MlNyQU9kNzJFWmNNZFZrZmM5RDhR?=
 =?utf-8?B?RUZIQVBqNUF6eGpMSXgrRkpTYzVzZDRKTVJhSDlFNlNTTHB1Si80UWVGSGpw?=
 =?utf-8?B?bXNTeWwrK3VGTXFFYU11UEkwc0pHc253cU9lRUpmeUVEajZyRXdWalVaeDdW?=
 =?utf-8?B?bUZBeXpRV2RleEVpekhFZ0dNTCt1b3JEY1ZCd2gyZGhVbXRBZEN6TjFvZmxn?=
 =?utf-8?B?NFNIWWVKanBHS05UQ0Rtdm9XLzFlanc2aWsxUXFFbmg0QmY3b1hsOTcxU2FQ?=
 =?utf-8?B?NGdGN2xWdzFRcVlEOTFxdUNpWmtkaHVUNlFaemU1SC9VdzR0VnN2bWptWHBY?=
 =?utf-8?B?L2FNNkZhVEdhLy9Hano5d2lwV2JtdkprRVhJTnF0R1VubHRnMWp3VjFnTlhB?=
 =?utf-8?B?MmU2TzJKejQ2dFZEdGR3ZnZuSko0WXpYTDA3a3p6VkFhbnUzTThJcUJaYitI?=
 =?utf-8?B?bm9KNDBsVkNPQWZjYlhHbUhMMXdrWlNXaWg0TGoxbjFyQ3FDT0NRQ2JKbnhT?=
 =?utf-8?B?cXV4RzFhaHp6akREOXVvVysyYU9PQzJscVMvTUFtV1gzOXRmUzhVL2N3UTBs?=
 =?utf-8?B?bytBRlhBbnpKc0NicStOOUUrbWVleEI2VWtLTWNGc3czc3gwanVRMmhyL0Fh?=
 =?utf-8?B?Nk04T0FyZ04xS1NBNXFGend2T3cxR0M4ZEVvalJHNGdNOFVjMXhCY1IwY1ZU?=
 =?utf-8?B?WGlUcU4zWTgxU2U1eEp2bzBvWG5WV1lXb1ZHVWVnd2kxd2pLdm1HYXdaclhT?=
 =?utf-8?B?enVWaCt4R2JPcHdNQkozN3RJaGNIYzRHS05tem1OeFFsbksvU1JwRThwTTZo?=
 =?utf-8?B?VUU3UFFtU0FDYlZHYWpSZVJielZ4TFZrMnl2aWF4ckVMakJqbldpT0UxdGxV?=
 =?utf-8?B?Q29SRTE1aW40dEJDN2M0YXVhWEE5dzYyR3JVNmFGR3hkVEpmZW8raFZtVk16?=
 =?utf-8?B?bkdRRU1GdW9FT0N4ZW9YbnZtZkI5b2pmOCtaNXFoRWVJaWNnL000QWVZNnRh?=
 =?utf-8?B?MzBHTUxwcmJnK0NVN1pCaXZ0M09pMk4rdjc1ODQyZWlEYm1CRzhEUENsbVIv?=
 =?utf-8?B?aGFCS1lIUjNTMkV1ZnNMUHlhTmoyR3kvWGliaWVkR3lMcDJWRlpTU3NkRy9x?=
 =?utf-8?B?ZXJ4UGVGUm9Tb2xxUGtNVTRQeG1xcTNiUVZpNytpOUJEaTBDKzdRa1V5QUsx?=
 =?utf-8?B?aGt2b0NVOUY4U3JNbldDL05rcE1HMVlhOW1UK1BNUVFtTEZPN2h5ZTFlTW1t?=
 =?utf-8?B?UWxrR3ZqaldhRHpPNldPNndxWXFLK0xHbEVvcTBHVzRsc0hoM21UcjM3NkhO?=
 =?utf-8?B?UWpFaEJIV0x2Sk9mZ3lQWHFPdHpSbXNzTmc4c0NqYU1NNkthYU90Qkowc2NO?=
 =?utf-8?B?U0F3NmU1alRYQnMxVFJtenRKNlBPcjJSanNjNVVjYVY2RnJjMEVqWGhlOWt0?=
 =?utf-8?B?cDZPSk8yNEZMSnFObXIvcWVPbmU4dmxmeDFsQVYxWFp3TkxsakQwUEJxaEFa?=
 =?utf-8?B?eDduREhhd0VkdDZ0Ti8yLzQ3V2lyc2FsZlJxNnN0QkZxc3o2Vkt5VXhzZS9W?=
 =?utf-8?B?VUpMOExwY3B1TnpxaEZDQUh5TFJIWStuL25wanNXU09zd1cxWEZxQ1BScXRY?=
 =?utf-8?B?dTZrWUlNeWxFL1duVEtNeHlKYXQ5Z01EZ2JyYVBoT3k2eHUrUzJwWjZQenZH?=
 =?utf-8?B?Y3o4d2dwVGZ1VEd2SCtFaDJVWGlxZURDdG1WeU9sNWozdldhRnNjS09yN3Yz?=
 =?utf-8?B?Tm1ZQ1lBUmQ0aU9tdDZZa2VLS0c5S1RJV1dBbVJ1RngvY1ZxdnFXZ0h6SjUx?=
 =?utf-8?B?OXZqMXc1a1UvbkpTdTdWTnBOc3dicmN0QkdhRmpmODB2REdIY0xQdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab6c554-cea1-40e8-f063-08dea5fc2b46
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 14:32:41.1734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvN2LZqE+RAse8wpT0h0uh39s6kFUdcHongX2Rf05TMFfbOEA5K6t/XaWdLmGQHLx7NhnpyAIIqsQCEucNcvcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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



On 4/29/2026 9:24 AM, Alexandre Courbot wrote:
> On Tue Apr 21, 2026 at 5:20 PM JST, Eliot Courtney wrote:
>> Fix various cases that allow reading past `BIOS_MAX_SCAN_LEN` when
>> scanning the VBIOS.
>>
>> Fix bug where `read_more_at_offset` would unnecessarily read more data.
>> This happens when the window to read has some part cached and some part
>> not. It would read `len` bytes instead of just the uncached portion,
>> which could read past `BIOS_MAX_SCAN_LEN`.
>>
>> Also add more checked arithmetic to catch potential overflows.
>> `read_bios_image_at_offset` is called with a length from the VBIOS
>> header, so we should be more defensive here.
> 
> This reads like this patch is doing 3 different things, or at least two,
> since the second chunk (`read_bios_image_at_offset`) does not seem
> related to `BIOS_MAX_SCAN_LEN`.
> 
> The general rule is that one patch should do one thing - the trick here
> will be to either update the message to describe a larger thing (and not
> 3 small ones), or to split the patch. Both are acceptable IMHO.

I thought about that too but didn't say it because it seemed the other
changes were just 2-3 lines and generally same 'functional area'. However,
I agree with Alex, perhaps splitting into 1 for BIOS_MAX_SCAN_LEN and
another for checked_add makes sense.

> 
>>
>> Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS construction and iteration")
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Feel free to still carry my tag either way.

Thanks.

