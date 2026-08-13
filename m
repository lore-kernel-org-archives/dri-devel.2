Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7811EC5AD5A
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 00:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE0310E486;
	Thu, 13 Aug 2026 00:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fRN9MYtp";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6967D10E489
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 00:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSbLw8dgqat3SI/7Urq3eSceBAmsKO+zqH2en4NyxKMww7t0ZitiN9D8I/DmtO8kLvheI2uWvszT3DsJUNCRB6xSQZUH9HAGz0g75v1uVp7IXQ2N93ldcLxV/iJ9BslkVaEbXAb7GhbXxsjBLOkV8zn/Ml23Ex/TySthOqr1Ou3l4PqEAKc4QTP4wsdFflmNwv0eMEjGFb5qijS9PTXbPuMK0ZU4CIWsvphGCm+XozSaX268DFFzbv1wAWkA/dhcrzyrwaxHKbtAWRYndfmZXe4XadDmXJstkKliPPPDlMUcC07qfWN1m8jH3RgPUFy1TQAl57HQ3AzSTpD0oLVKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5y/9E8wG7/OOSboQbomFqugeOn9q+A3Rk1PAdouObs=;
 b=ixN0IKwftKM0leVRQTo9Vxy3/+H+cS40ety8V94VTRnA2ouzvCiNdYfsqiEiYv9Sn8ghbVbv/7vwYtdghcg8qE0MbvCXv7LgTtQLEh05CfrpjvtmyEXim9vSngAKjmiPuuWBpUvQ+NAqga2ivqr7Z4EKoRafyZnZo0KBrNDWSMzU7ckPpx/UwTh1Jz1+6RyHERCYxOMEz0c1wouIGtNYQCZVkSiXkkFnUJaf8csUnqICcDQAGo3zEvFa+M1GaPcPYIbqgi1bRkTUweft9KTK5RsjytCtgtyFpz4BZbJ+QV1SxzcVE4rtnmP7NpFYdF9tSYebT1gpz8hRe1jz3GGuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5y/9E8wG7/OOSboQbomFqugeOn9q+A3Rk1PAdouObs=;
 b=fRN9MYtpbFCNbjJTBR43eza4RVhxJ+Mo3ZhJvqiLByt4yWRc7nvcsQGoaQJ7P08Fa0GCgerIRvNnoLVo/QJ0/c+zPImmotZ/8svUzcj7Ed34zlwdUMgySiZzCpHtdizgqQcDnXU8w75rFSh9AEvEKsbzH/BTanWWbLiELaEtlOLnwzmVdrzXmP0AR774d8+d4cYW3ze+XThZ0LtDoOzcKwFy5t9iEgwfZk0mMSqQkjUUXLMLcbh02SvPNHuppQ/8e9jFM17R5VjZ99YJ+zlt8R3rGX6KI5m+9l2URu/yiBHbZpKtQ3rZOlm4RyLBlHR90QpH0FM5t8Hy2aaa1KtVdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Thu, 13 Aug 2026 00:00:14 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 00:00:14 +0000
Message-ID: <97d29d64-1efb-44de-b0f9-f4e4e956d454@nvidia.com>
Date: Wed, 12 Aug 2026 17:00:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
To: Danilo Krummrich <dakr@kernel.org>
Cc: Vladislav Zaharov <vladazaharova2018@gmail.com>, acourbot@nvidia.com,
 aliceryhl@google.com, ttabi@nvidia.com, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
 <a72edc5b-49c0-42e0-b21c-940e71909666@nvidia.com>
 <DKNCIMHM4AG6.145KTN1QZLFTD@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DKNCIMHM4AG6.145KTN1QZLFTD@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::30) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: d92d1352-3f00-43f6-3396-08def8cdda09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lX0X77Q3geAG4It2NC3lp2CnMtLPgEtG+8JVFAzyXR0tujJTHQGsSV3xXIV//Kq7QysHpgOJ13+vDe6eti8Q8eZSBbMrR7PGQyE+aD70EaJTvS6X5oIghoIL1biw4crcrIl/XxWUK4tqRkAw96SFU4WXSrtfsn6rMKJ2HI6P6vn9NfuOWEfzShUtBSh7N23juS15N05eaqIDsSaaLqbooBwd4dBoMUoxeBnWlTMX0X+g74oqHTWn7H6DiyS74aCKOU2z1QJ9Mq1YjLACgxaQyHPjgfY1QQ3fEqEMfeBamVeOrMFZTFcv7EXcRoXVeXubBjbW8W6QJy/nh36pqMti4YRO3r+4/TGTH4bQUoXA9OuedL3pn6aVdBmG3Rl4R6DbwI0fykiUt+8KIWawi5wVDJe1E7kTKiX1PbHJc+9EVdI7OnddwGfA90qRr0y0U/x20uTfwPD6UlqyuSJAyJgGrbxiX+GdAcI7nEDSil49vOnFPdcgWrWLPNpankpHk9KujYlEvxTA0t+6/ZVKMg4HGwgA+tn3IF7dAnhuHfP5aEb10EUy+mbWRoCerXezgFuLcAfYFDQ45ZkOxlK61g5fmaJlz+IgMaYC4pMlTpun6zCxCGliWLi5jVpSiplqc+CpAKLjLiv640ItHlLtUe94Hb/Nxl2wVZC0KszcY92J0bE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzczckR6MllSSVV1K2Z6MUlRRUloQUx5R3NPejE3YkJsSnREV3E1aUlUMDd0?=
 =?utf-8?B?Wlh5bWJvMDZPU0RvRkFtcEc0K0hJN1pMQ3JDNW9leEFrcHJiYW1hcUROQ2Vo?=
 =?utf-8?B?K3dMbnRhOWhINEtJZVA4U0x6emlGN0h1SkhHRWQ0UUVCNXUvT0NZNUJ0QjRH?=
 =?utf-8?B?YW1SL0tVNGozZ0UvNXRNbmhna05ITUtMY0g2YllZY2thMjRaOUo4Y2Y2bXpF?=
 =?utf-8?B?QU5tanlPNm9QUzl1WEJTNGtqdWdkY2p6VFYraFEyYjdjdGFaNmk4U1JJR0wz?=
 =?utf-8?B?ZXBjZ0lzOWpQV29ncGx1NXhCd3pvWjhmK2pDbWFLMUhBTkJKZ2xPRkxtU1R2?=
 =?utf-8?B?bHlteG5yZjRwL05wSUpaUXllNEpQUnc4cGRvZVZKbWVpS1hLOVRKdUlYRUxJ?=
 =?utf-8?B?dElUSW05cCttZWY0R1BMMFp4R0RkNFJYUUxPcEZFdG5PSHV3Y1duaEhZWFc3?=
 =?utf-8?B?UWc4bWZOdFJtVytRYUNDVTllRHByTWxaK2FSd0hLS1QzcVJxK2l2b1h1WEZI?=
 =?utf-8?B?ZEJHTjBYdWIwWFFXd2RlTkV1SENhOHFDZzA5UmwxT0t5eFRrM0FHS09oWkZa?=
 =?utf-8?B?OXp0UC9TaHY3SzFWWTJpSFh2YU1ZTStlcVpEdnZoV3NocVZkajkyVTVuZ2JS?=
 =?utf-8?B?aE5NdVY5QVBvMUZnTGRaa2lidW02aFgvZEhZQ2VZZ2FEUmVxZmM0OEN5YXZz?=
 =?utf-8?B?QlFMN0FyOFlPWVowMTF1aFFOd1Nuekg1TUJ3OFBSckp4cHNqczN2czZ4SzhX?=
 =?utf-8?B?OHVpNUt5MkJQcWZiUlozbGlNalNyV3paNWJsbWU0aVg1d1huVm52M2FxazFX?=
 =?utf-8?B?WE1MK2hKQWt5bzYwUTNTcGNCV1pjZVpQUUM4RHBkYlRidnZQRy8rYXd6NkNS?=
 =?utf-8?B?QWhkaUlnTCt3R1p5ZFkxK1p6bm9TRkpKTWN3Y09ja1FpbSswSjJ6NjMxY2Zn?=
 =?utf-8?B?WDFMMi9aUW93eUtFSVhuRWUvZlh6NTh3dzZJQ0tjcXJxdnVubW9Md1A0Q3Mr?=
 =?utf-8?B?bERlc0JRTVcweUM5Z1poaDJaZmFYeXhiSXc1WGY0bUh0RU5tZFRSVlBTZDZH?=
 =?utf-8?B?dkpvWmowbG1TMm1mL015NUp6T3ErZm1hZTlQeEEwbG4wUVdnSW95V0FFQjNm?=
 =?utf-8?B?anQ5SUp2Z2EvbnB1OTRyNjk2TnlJUDR0LzRFdHBQMXFMWlNIOEdLN1VvYkFP?=
 =?utf-8?B?SnRZYmJaVzB1VGFqMFdDQ0JyT3lPNTJMclh0cEoraWQremlBenE1OTk2cHJG?=
 =?utf-8?B?ZllBcDNYZVYrYWs3UVA3RnlVNW0wUmo4ck5iV0tqT0wzNDRvVkRTWTQwbW5R?=
 =?utf-8?B?USs1Tkk3YXBNWndUb3p5ZVlydTYrVlJEUXJ6aHMvN2E2RFk0TWJhVndVOXBj?=
 =?utf-8?B?UW9PbHlSL3lKeTErWnBUejhGYzVIME4zT2tsWHlhTkFETVF2WkI0ckFwZkwz?=
 =?utf-8?B?d3VmbFo5cVFhdUgzRGhaeTBCYUVKR3AzV2lWWUg2Q3lTbktZSDJ6N1JFUE9m?=
 =?utf-8?B?eHZOVmE1N3pMT29adlgwY04xWnJodTJYdUkyZFBheHllZ2JlQnVpRUt4Rlhv?=
 =?utf-8?B?SzlEWmswUWhYS08vTzFPWG1FZ3ZFOVh3Vml2UnJrRVpyelVqQ09yak1zNkhR?=
 =?utf-8?B?czczWC8wTWppYTBNSzEzbG9CYTE5M3VXNUhGZGRJV2hmSWFVaXF4NUY0TCtR?=
 =?utf-8?B?MWhrbUxNRUYzOTRKLzVEZWNPajJNKy9XTEdML0JFaHpzRVFscFRuSXpSdVIv?=
 =?utf-8?B?SVNvQmY0Tmd0a3FTSWJpbnA1eVo1bTlvMEp2QlhXV0F3cUM4WGUyMVFmajRr?=
 =?utf-8?B?MEZ2aFgvN1ExMDgxbkRrWFpXVXpFQTE2cmdiM0hzcERJaXlWRHFpbGVxWmlu?=
 =?utf-8?B?WWtCRGVuSHRmTVBLcEdHN3JEeG9yM1pBeFlId05TQ2o4SGgxY3U0Z3lhdGpG?=
 =?utf-8?B?ckhBQVNDaTFPZ2d0a1orandLV3RGalFBYm8yZjRMODQrMWJLZXBsQWcvVkdD?=
 =?utf-8?B?M1JUZGI3dXF2cVRZTlFiWFJqZzE2ZEY4cWk5ZDlZMzV4N0NENUdHaEFtU0Qv?=
 =?utf-8?B?ck9KU29wemNQd293ZjhDRVdWMFIrNWI3Njd4WU9qQWd1SWRwNHBESU1qTEVr?=
 =?utf-8?B?aXMwamVpTTZINThhSlRRTWE0dnJxSTc4Yk5uOU1QcmhobDc0VmRXNzNsd21r?=
 =?utf-8?B?b2VENUNpcnNUYmlmM0JCVXNtZW1SRzZHQ1ZkWVY3ekM2WldycmZncTdCRmdD?=
 =?utf-8?B?SDRIeFhWdW56SjFncUVoQnhnRHNGQ3NLOW9BY3FMNFF6YmxVcEEzbjN6R3E4?=
 =?utf-8?B?Y3NLbklvcTBtQzNsazB3bU96bExubHR6ZTNwYWRYVldtU1c5ZGwxUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92d1352-3f00-43f6-3396-08def8cdda09
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 00:00:14.5663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOMbpXC4RvM4ruD75kj+AnA6mTWSpQsojxVJjXyIlAtF5mD1edEAk4mQk9FheXBd+dgN/TzyKeudjeNycCT9Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
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

On 8/12/26 4:15 PM, Danilo Krummrich wrote:
> On Thu Aug 13, 2026 at 12:41 AM CEST, John Hubbard wrote:
>> I'd *much* rather use a kernel parameter: keep_gsp_logs, instead of
>> requiring a rebuild of the kernel. As you mention above, nouveau
>> arrived at the same conclusion, and yet even after mentioning it,
>> you went off in this other direction, but without explaining why.
> 
> Not sure if Vladislav read that, but it might be on us; we were both talking
> about a Kconfig in [1] back then, but meant a module param actually. :)

Yes, it's less clear from those threads, that's true. :)

> 
>> If someone is debugging, all they need to do is reboot with that
>> parameter, in order to get the logs. That's a big improvement over
>> requiring a kernel rebuild.
> 
> I think for development it doesn't make a huge difference, but a module param
> might be easier to deal with if something unexpected happens in some less
> controlled environment.
> 
> So, while I'm usually not a huge fan of module params, I do agree in this case.
> 
> [1] https://lore.kernel.org/all/067c6016-ce21-449e-b0d6-86252ac483a0@nvidia.com/

thanks,
-- 
John Hubbard

