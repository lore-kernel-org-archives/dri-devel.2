Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE546606D82E
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CcvxdKhE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5383A10EB98;
	Sat,  7 Nov 2026 14:56:40 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BE9110E62A;
 Sat,  7 Nov 2026 14:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJ+YI6QJGiHZte481Bg8kkWWSCECVX5uvI0vdPvqmR25M2gVYD5h3Y2gYu6gbxkn8jTfDFGKJHmeQJ01nCaYOywSdjPAM0Ifp8G54a0rlkc835V9DUiJVJ2h74z2QGPgMxX0oHh13lrQu3sAqEbl+79PT3bQ3IZeRZ99FhRc6BRInwip2wac2luAEbKJ5lpm8iESqP7Qcy2+liejb3hdI9v/qq1KC9ouA7aF9vEIHdZdDLjwzefausvagtR0C8EQKybgGlb9Qj60sK/u0cVyZDMgLnh/+z4+sNGYWksU8hFlxW1rFP/hBg3rGCnC7e25t4si04JMgkZllF0IEc6yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFkJwSeUjwAlQ0sBIHOsrgYaznxTkgwfCe3kq1tWza4=;
 b=Vkcl6iuJsOCsdFfua1z0qJnRdDeeM2cVdbDmJOfWJjGvOMHPb+W15FGOjANjAG/v6Y7q9E/2EO6N8KpjhHWY2IcTo4ea84CQ8Ksj1CK7spE2B3PAu9BQmBQiejqZWf91oAjyglvDMhNgkylyrihn6CeG4s3LjYRtavWWMpYKzXlnhAvHlLhApU3Sv3UL2RmdBDT1/swWD2//AmnR80gtM1oChvj1Oeo08+mZIWFsPZ8N5qdmMTmUdMYZkZWBee00FN+vCkGFjuwoUJFt+9ITpSJPGF6a//ey85R0SOjr4jXTWBVfzbH8fzqjDuFVVs9x0DsgGi1706v8e/UWMeyJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFkJwSeUjwAlQ0sBIHOsrgYaznxTkgwfCe3kq1tWza4=;
 b=CcvxdKhEv8Mnki5M3FPDDukEphGpKNXl6TcBDuu/pTiHDMxzq+XAoaXODzeiqddHqenFSppN0OJ5d8K3ho/9BUUWlx0lO0JfQuMdh6rSIsY6y1p2vJZx/o/8VwdUOtq3+/MclH13eOMQpdjh8DtiXBRcZ0/uXrNaXbqEo8xvpMtOlikyr289DO5KNsX+BCte2FZCVFLjwJpTy6OphC89ED7GZGQKzBnO+/0GuJPbBAaOCIFmYQDoW1P5FhMB6P5zPQcmwYOzIvw0jWoiv3/qYdD2md77FBee4epI4DnCzLi8n7tRSKI3zn2u5tZFXnkZPmV02S+Wzy2VsrBb1c3KQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 14:56:29 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.009; Sat, 7 Nov 2026
 14:56:28 +0000
Date: Sat, 07 Nov 2026 09:56:26 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Sanjay Kumar Yadav <sanjay.kumar.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>
Subject: Re: [PATCH v4 1/1] gpu/buddy: Prune exhausted subtrees in
 range-biased allocation
In-Reply-To: <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
References: <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
Message-ID: <20261107-joel-rb-tb-buddy-prune@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:408:e1::8) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 6107d369-1731-418f-41d1-08df3cdf4d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261102123227099003|261009223027099003|261021121427099003|261021123027099003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3HQxyOw/1QaoUb+HjULNmWjK4Ct6KkdQ3Dev5v4p+CPVkoEyEW3GLqusmQ7HzuNn3nfv+rt15c5z4K+NqWhspz1dRF7mF+9ew5C9qsRoi8LUVBASiqVHREqXbT8t+e6QSnMXXXu+K8RLPYpyyzzETu0O7ANaSdhebauVr7dhZ6BDWdIL1awLj/s2O7z0AO5gp9ecCw52qdNbX7REhzy5arBD4EAeE64s14OoGn9njPcLmqWV/Ufy8KZuWkAF2KQFIYUU6R5vxCl0m9de1ZRBPRJURi2aWa0nUfhHEUcBGRi/UZIjw+/Kd5F0PjPmIIl40lF9fgMdRUVYWa2WAAVA+WwSK+xUaPppseLPJJfyl2eihElF+6DAfoBSmkpai0WWTBPOKuoN4K17VxR9cDbk1QV5Sd8FSkqKvZiKpiKaHJ7zk1WKn4JCoE0qcI+s1LTKAIieiYGzQhZeEwgjm9c7geVlV0z8NtsnILh4+D8LkAKjbbvi6gKjr7f/Vv0Uy21CZNSDpy7TE7ZUU1d7XySdWMSXmskB+AXCcU5vp8jcST/iMTo8ENLCd/G0rrAI0unF6t+Gzs++TbqAua93nxpqvsa0BwwmhAE/Hyop6mQvBG3tlfWwYs1Th3To9ZnT2NX4jmTFOw5tmWLnVd+bPLIF5whccV36BzdHeupKD2cl54Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB7742.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261102123227099003)(261009223027099003)(261021121427099003)(261021123027099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHlxZkU2SzFoMTBkeFI3cUw4N0l4YUVydmFBSkx5WDVLS2lNbHFITXlESlpG?=
 =?utf-8?B?MDlLN2I0aHRiNE9IN0FQYWI2MUhqQVdKUk9WMkRWSWRiZWZKdTlDUHk5a2R1?=
 =?utf-8?B?MlNEQUhpT2x2dGF6dWJwVjJWSzBrNXp3Vk1NZFBNZUt5czAwZFg3RTAwMXRr?=
 =?utf-8?B?UmZ5OWJLYVNIZ0ZLV003R2JZNG56WnF3K3d1L01aRXB5VkdMazd3T1h2N0NT?=
 =?utf-8?B?OUVqUVFBcG5VbXdYL3lzdTM2NjgvdUlXay9PM3FIbDN6d0E2dFNvaVNNdnI3?=
 =?utf-8?B?ZFcwSGRQVW90RkdKWGtVMjFMWWdhSGV1b01EYWgyK09hMHFhYTRiRVNTamZT?=
 =?utf-8?B?c3MwSlA3L01NSjZOckFPaittS2NvS0dRVWVCdFFGQXY1bmQ4b24rK0s4bHZ1?=
 =?utf-8?B?NForNDZaNm90bjBjOUpaZndiaTNqSVhVc3VqZ0xvQmp3aklXUDhJQ1N2Z2dO?=
 =?utf-8?B?aXVFM3lZaDV3OFpxNU1MMUVtOUw2Uy9uU0U3SWtOQlFlZmJNYlIzUkZUUExo?=
 =?utf-8?B?TmxFTlNNenlQdjhDczczV3ozRHZJaEhhNXZLYml3RGJlT01tLzYwUGV0K3dB?=
 =?utf-8?B?WkVWd09tZ0V4bm1oK0cvZkpSUVFTV3k0TVVZelVuYStUZU44RHNubFZjUlhM?=
 =?utf-8?B?MUQ4SXFMa2pOQ21LT3ZvcFlZeUloemhmK01hYVVydURnY2Y5NmVTdmZvNG4r?=
 =?utf-8?B?RXFKekJSUTNGWCswNXVRQWpIcTN5RUNsdTRGNDFUb1lGSm1xNWVPR3h6R1JC?=
 =?utf-8?B?aGo3ZU1WQTJlZ0t5QWRpdDNQTWltci9rM0xLQlNXZDVTdXhwMXBqVlE4VnN4?=
 =?utf-8?B?ZVZQMEdQZ0MwQUI2OWhYSmZSa3BORkJXb2dtWEw2bDh4VWFFRGZpUVB1SzMw?=
 =?utf-8?B?OGdGSjZKMWhpOFpnaXBLSEptbXd6ck1aSzBUVjFmdytoVy9UeXJVVlJMYWZG?=
 =?utf-8?B?bUxsMmo0VXg4bXRVMmFqRWVxWVI1Zm5neUJ6b0dWcVhkSTVUZDRhMTJSbEVh?=
 =?utf-8?B?NzRpRklWYmdJT0publJ2TDl4RHJJbStSSFo0ekd2eFRnVmRKWlVWSGVtbVZM?=
 =?utf-8?B?VjZKYnJFRnh3Sk1Eb0h4N3NXRzdTTHpYRnF0SzNrRklUN1hSUkdtRWtrQklq?=
 =?utf-8?B?Y1pmU25RZ1RRVjBHNTQvMTI4Z0hjSytaa3A3VmNkeThyWXBHU2l1STlyNWVz?=
 =?utf-8?B?ZmlsM01hUjVLTGI0WktZT1JKSGdwelZoQmJlTTlRZ0NyMDA3bWM2VGJLbUdn?=
 =?utf-8?B?alpyWGxyWGpkdlVkOHFWNkFKc2liSVR5ZUNLU2dWQUdxN293R1ovWFhtVFY1?=
 =?utf-8?B?eHFJQXNhTE1SWWMxYmNFM0FlcllHMmRKeUF6dkk5YkI1bWUwaXdBb1Y1K2Mx?=
 =?utf-8?B?S2dxbExGdWNDSEttVXdIWW9IWURBR1BKek9uYzBJQ0k5S2Vmb1JlYmM2K1BD?=
 =?utf-8?B?dDh4cTZwWWd5WnIzVk9tM3IrNWU4Smg2TmlOcjFOZTJCUVg0YzhwVjViVHZK?=
 =?utf-8?B?VEUrRHJ0MXlkL2RiUGFocHVrd1BicSswSkQwVVlTdTRoVXVYWlREbmV4Rkg2?=
 =?utf-8?B?UlBQWjdZSmZLbzlTc0pYOTl3NnBsc3hRWWJZTkJ5am1rd0xRV08rTzRGOWxx?=
 =?utf-8?B?UjVlZnI4MWxjdHkvVUF0eTIvK1pzUW9nS3c4dmxrdXdjanVvaTlTalJKVDJL?=
 =?utf-8?B?Q09iNjg0S1M2Mjl5UXgvQjU0d2VsTGJ0ajRUT1MzZDg3ZjB6VENCSXFocGRv?=
 =?utf-8?B?SzlLc2pIaW1jSGNkV2RMbEhNT3BCa213MVk0Q0U5bE5oRWppQ0I1M2VmU3dy?=
 =?utf-8?B?bWFYZm80VjVQYkpHVVdzellGdG9SK3V3U2QyUDRENjd5MXJ4aUtEUTZUSUNR?=
 =?utf-8?B?Vkd3TXFBRXVQb1lJbzVzZllYZmlsMWdER3pvYnloRnZJcEgyWVVhTnhRL2dY?=
 =?utf-8?B?Yi95RE43ajJKVStaRXhzWnkzVGRSL2RmbG1ScStTaUszY1FaNXBUcStsZmdN?=
 =?utf-8?B?OXQ2RHloOFArNnd0S1NENHRibFFSL0hSZEE2Tm9CZjU4MldobnYrVlFjejFo?=
 =?utf-8?B?RENMKzNMUnRXemtuMUxMdlZoT2NOWkc1UlFJZi9KTTRkS3FsMHpjcWh4Smw4?=
 =?utf-8?B?amZFWmJ4UG5EY292dWx3bGdGS3J3amlKQ3Vac05SVTU3aXRaeUNJOWhiYUpK?=
 =?utf-8?B?NTlmNEx0Yi9QdU1KRHJZc0FvUzlNeGUrNFhkQnM5N01XanFMdFlRY1RadDVW?=
 =?utf-8?B?RmpFZlR2VlhZdzErTENWSkEySmRwUk9RQ0J5QjlSaGp0TU9WNDZFV2tub1dR?=
 =?utf-8?B?cC93SXpTeTV4NC8vZ0tFU1dUL2FZbkhLci9WUmZDQURFaU93UVpEdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6107d369-1731-418f-41d1-08df3cdf4d4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 14:56:28.3751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6brKtgp+XQJUwjYvK2fqlrpcwiPtxXtIuyrfHVsy4ZkWvdslPvaVT/JGuO2EHuHB/McpNFIGj8hVNOVqaZf0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 10:46:35AM +0530, Sanjay Yadav wrote:
> [...]
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Tested-by: Joel Fernandes <joelagnelf@nvidia.com>

> ---
>  drivers/gpu/buddy.c       | 56 +++++++++++++++++++++++++++------------
>  include/linux/gpu_buddy.h |  7 +++++
>  2 files changed, 46 insertions(+), 17 deletions(-)
