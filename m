Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126DDCD5BD1
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 01:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DAFD10F7B8;
	Fri, 29 May 2026 01:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XN5H4FIj";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C499810F7B8
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 01:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pf36KEouTGhIO0A7yEWYfI7+N/btIO/rAvrPubnS7P9/1xPoz6EajozdbsHfclzmGebcHeeI2c7Zhwdrt4vtTlhR3edXZF+NZM+1ojPJ4YwR6Xf96hqt76+nIbV7Jq1mzsNuoHEnBhIEjhq7HXC8ml5FfrX6fLqnEpEPdcftqL8Au1ggs4ZYp9bRzZBjYLR03GlfZDyXFnLMXBGf33jQ6VNBDdpIKMQORE6TIaLT/3NQdg7l45DhhaWX+B2uujWQj7SwfYsFFCuGY9WOKzoavMp51KicU5uhNlO9I5W06FInR6/a8dtIgFAhJRUNJ2BQQAwTMSChVWgofRrGZE1fag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2cTH5HAawKywOsWwMzrijL38e2R6gjUsuDEl8GNxDQ=;
 b=dvnkCOm6xCCMxPrN/U+HiDri1dblVlXk/Qjukfbk6hOAz82BKQ1hDPHmUlIhIMsMbHxLpOjUWla0Ef4CHGZ5gOJEywFDFsOmkrSERmbwXPr5f6kTg8wRhT29oPNZ2l8XaKUeBrkPCTGLPR29jnP22jmZXjtpwO9zEzVsPMCMMNodWIbA+Sox3QK2Ck6twj1JymS8XWYeVDgpqh5ATS7wD35aERC4TElVjOwYoR8GPr6JOdYuJASrWhon/wO7aFc28PHB+ksvAeeISYXpBFBdJbufNjk9WkucBbqfvWN/9zJtfi/zOCtkqSqXazB1m4pBSUgfWQ+Yw05oj/ZvMiuYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2cTH5HAawKywOsWwMzrijL38e2R6gjUsuDEl8GNxDQ=;
 b=XN5H4FIjIA7zbkVVrT+MPijBYVfJV5SzJ0zHgkPag5rcY12+6ol/dVYyBRuXFRoxxYzSZrTfAodtlfqxYyNxn01pjOv5pRZy4pC2zk0YKmDzhqpTUJLKnwbQ2hLDGf6cXwJT/b7yKvmqUIQiCIZy42pLlv/i+Q3sWvGo5BooCYqu+NjgQ92KZ8K6r3+EVDgaq/JjtO7ivUfBDBxhgTNh5DXI+e3X03p4jwyxkxb0PgMKh1TVTCt9bVH0BLdD0GX95NKQ3aVNePZiL4BAC2FhvVS3+7daPlyV/MOwKrstV/RlrEO3oY2gkmD8t8jdBpvXLvzBEIgXPEM7BqnVrcl9dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Fri, 29 May
 2026 01:57:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 01:57:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 10:57:24 +0900
Message-Id: <DIUSDFHK8YNE.SFBKQK9B4NTD@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <boris.brezillon@collabora.com>, <deborah.brouwer@collabora.com>,
 <gary@garyguo.net>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "Eliot Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v2 1/2] drm/tyr: separate driver type from driver data
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260529000106.2257996-1-dakr@kernel.org>
 <20260529000106.2257996-2-dakr@kernel.org>
In-Reply-To: <20260529000106.2257996-2-dakr@kernel.org>
X-ClientProxiedBy: TY4PR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9d1bc1-d0c1-4d5d-e10a-08debd25a2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: tB7PYp7lqNsZZ0SBvNHZk579rh6LFQ9Ni460hjuTGErga5H3f3Nu06DoWEz20c+tJ6XsE3JL322SCevVlAaLt8ZyKkbjg1V9x0unHuU19Yu9/Cl8f9qglPZd9OiNhfUao9GadWNhOXi52ovKou34GI5s5b3e3ojGa3cxD34a6sSbjIBgw7bGVlxl8g6YGviHH48BbL4ec+OxubyMH21ewLofRaew0x84QpGyPjklJYxtAN6Gt/VvJ386Pipq9UvbpwMbUKyKEO9OHCCCMiIrb18QZgDon9tgvean6Gjq/SGDoHMhe9ZRhe0uvfoeHHgpaFTYZmRreWkqwCw5pyYN03u30O/RN4P1WkeN6tpEcYY484WkClPoAG2ypXcnwM2UziIXLskDN3wQa67PRV1hfOP4woRlOXeEYwNJdEFVdPlm+AtmFU3+fIXPl+hnmFwxuS5DlpXoa2XSwN1S6iGb81B8qYQ/R8sMA208XxOxqkltH4ek3YOY5pPd7iHGv3cKfh86tsmd6FEpwpXPLi/QRudaup5L0FOBTbQCLX3p64mrZApBcu/TdpLUJuobo+qBQzcnc1NZuX9EAXO+pPsIZDvwv6Q1yTRc01JYSEkEUVCbLoCP5sEe0JaTfQF8jn2F0uaYBFXsFSjtCD8cuojmXuJmCJioH/wFgTQDzD3ebQnZ5X4qZ3YpbAzEVFLGbowUHWScbCC+Fm8CoiHQpg2zDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRkU01SMGV0NWk1U25NZ2NYY2JTRmUwbHBPNmEzejluREVyRlpBMUh2NGJ3?=
 =?utf-8?B?Q2tWdzkrVU16UkJGV3dSazE0b1VGYXh5dndEMkRNcVF3SGt6eHhIeVQveFQ5?=
 =?utf-8?B?cEVqS2E2YU9EbDhqMUYyWVdxWDVVZTlQbTRhSHNVYWNicWJNUFhsbUtIT0xi?=
 =?utf-8?B?SVl1ZmgyOGhTSWlqOHNlL05kSjJOblJyOWtlVjhIMjg0cVQ5cFh2eHNHcVRL?=
 =?utf-8?B?cjBxcUJlajBIOTA0b1JESVFZc2IzQmN3QisrVGduMTlRWWh6UGxDV2gwQzdL?=
 =?utf-8?B?MmdQTFZ5S3JJVW8xWDBKZThnRWhlakZycGRPaXNsZnVZVVhEMTlIeGZxWC9j?=
 =?utf-8?B?R1ZrVFVrR2dHdnR2WE80KzZOT2NYZFdSNERkeGovWHFyL0hremZpWjhQc3NF?=
 =?utf-8?B?bEI5K0pKdFBmaHhDQ05HbjhscmZtUmc2NWpoR0hUSHpFNlpCaHZJVHZVYXVK?=
 =?utf-8?B?RG5jdUlzbzY5RXB5bHZlRmE2dG93dWdLR2RUbDg2SVB3NXhZa1V2V0JiSW5m?=
 =?utf-8?B?ZDhxVU9mWHZ6QTc1Mnd3eElmQytrV1VoN0h4VVJsbUszanR1ZnNtazh1c1hi?=
 =?utf-8?B?M1hMcVMybVpBMzFndm9XTDNvSjNrcnZCb0I0ek5GVUVhb2R1QWsrVDlSNUFM?=
 =?utf-8?B?c0NSYUFWb3d3K0NidUxOb3N0S1BoclVscUphQndsVlplekNpZ1hPay80YlAy?=
 =?utf-8?B?RFM4MTZnNFdvbzkwdzBnVUFZbWJkVzBwaC9XbEI1aWRxSnhvaUNOYTlkWTNK?=
 =?utf-8?B?cFZ4NEpqUWtFKzNmdzVESHNlWUNyc2g5cGZ4UEZnRjJVcmdNRGgxYmJCaXJB?=
 =?utf-8?B?OVNNV0Z3TUlxaFFsRDRKUkp2MUgzbE5Ib3NqMVZ3RkpYZmpMYmNaTkNTcmRm?=
 =?utf-8?B?TEdmOE9mYzdUTHFrZERCMmZKZVliS0FCRHZNZFpMckpLblVwS3R2RS93MVhU?=
 =?utf-8?B?a3Y1SnNyYnBucTR6RHNaY1dtemw1VEFTRXdNOHArOHRNUHAxZ1FDd2xvd3dn?=
 =?utf-8?B?aHhyeXhIUzEvOHRrQ1pidXNCaVZnLy8yN2VaMTlEOWZ6VTZqNFhhUERTR2Rn?=
 =?utf-8?B?dEYrV0c0VDltTW43akk4SjNvblFTRjFaMUJBSHBvWUJ4Q2toYjkyV1ZMalln?=
 =?utf-8?B?cy8vdDMvYUZCeHVHRDE2S3YySVJrVVZVUGY1bHNFVHoxc2NGQmN6anl1Zjlr?=
 =?utf-8?B?MFNsY0NCZ21uYndOVEplblJ6RUppek9Bb2NWYmJzcm9DM2M0alpyL05CcUp4?=
 =?utf-8?B?ZXVjaGpzUEMydDFzT0ptOVgyZG1PS29WWFF4QXk1RitQU2FHTVpuV2E5Wk9s?=
 =?utf-8?B?dGhxaU92VmZlUjRCbU9ub3ZSdEdIdnRvNFJRMklxa1k5RG5heFVGNDRwN2V2?=
 =?utf-8?B?NGpWakc3Z1NVZXA0N0ZvbmZSb09rRGVyeHplOFErT1NZVUx0TC9LOXdkNXhO?=
 =?utf-8?B?TGxhL3dFclV2Vk5jMTFqZjlZbHdZZHhQendWTTdHMnUxMklBS3NXS2RmeGsr?=
 =?utf-8?B?KzJITHhseU1uc1J6TkFPdHhaTlZEQjF2VnViSHNOcnFaK3NPZGZDTytkdVAy?=
 =?utf-8?B?dEY0NW5GV3ZqYnJhbHBnZkVDNGN3UCs0UUJEQTNhZFF0YlNyL2NHenhGRTNH?=
 =?utf-8?B?WnY1N2dSZy9zaENHTkdZSWVLVVRzQzRLNlF4UlBwMWE5UUpUU2ZQRUFJeFdB?=
 =?utf-8?B?R0ljUXFvSkprQUo1QlVVZlIyZllSOEUvTmhBVjJ4RmRBLzIrR3E5UXpYKzJQ?=
 =?utf-8?B?ekNHVzdENThCcnNpYkxBVnc5T3IrdUhnQXZuWUJsb2hnc29md0VEdFFCU3ly?=
 =?utf-8?B?bkZKYkpFTTFDZ0YyczR6RFhkcnQ2dHhsUEpPVXd5eWY0TzkwbGVFQkFXT3du?=
 =?utf-8?B?ay8vbFJxd045dkU5V3IrTHl4OVB1blF6dytEeTlPS1hab1dNckZRWDJUblJl?=
 =?utf-8?B?Z1RrdlI3YVQ2UmFtSE1Ga2dDYjRaV1BWdFd3NjVzTVJQUFZEN1Q0RjVMcFhK?=
 =?utf-8?B?Qk13Wk1IT2I4QzhTdnNvUEhJZ3AySlF3VUZlWmdodmFNVExQS0ZrM1hvNUxP?=
 =?utf-8?B?MjNmTUlaZjI3UTVXREowbENqMGljeGhBaGJYS2pNTmMraU5wYms5Z1lFVDZa?=
 =?utf-8?B?TW5zTW5UOThRcWlUdEFuRGlIcjJhbXBlbk5VYjh4dVBiazk3TjB5dlJmVGN6?=
 =?utf-8?B?UDBOeXI5TzRrVVV6SlJFbVA0VTZXaFplNDkvRHF3OXVWK2xuNG9yampvcmpM?=
 =?utf-8?B?K3puakgxTCsxeUx2bkFHelYrWHhSNG1qVlFKYkVrYTlTcllYc2N5bGVCOUlm?=
 =?utf-8?B?ekpLazJqT2RIZk5DK0N3U0J2MWF0OVlEK0RaMGU5dDNMV01FQXFBSmNrS2to?=
 =?utf-8?Q?40llb0a/270b2U+LDeOZTb9hVyDUgqtgiJH5EehIG6yOP?=
X-MS-Exchange-AntiSpam-MessageData-1: zUknvplxaIxwcw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9d1bc1-d0c1-4d5d-e10a-08debd25a2e6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 01:57:28.0220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/yCjzUBkRQuAW+RnFqZRCl63TxUnMQAA2b14Cg7uuXxPzfdntCLXLY02pQ7enk9KRmzg8D9IrphXzUa/HvgtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504
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

On Fri May 29, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> Introduce TyrPlatformDriver as a unit struct for the platform::Driver
> trait implementation and keep TyrPlatformDriverData for the private
> driver data.
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
