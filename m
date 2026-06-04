Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AE6CD6E6D
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8A3112866;
	Thu,  4 Jun 2026 14:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="g4QuGABm";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012002.outbound.protection.outlook.com
 [40.107.200.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3F8112876
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJ6JUQN90D9WhjhSyIBrM6I4fp0JtPr491dl2ZkxBdyRDXIxmqw/e4etuHKh1/2HDQI4DlkEnuNTV2KPmrMaWjDjYJSACIZRMBI0dengDvKZm3/hakJ0i0SXj3U1Vx72tmkSpoA/A/Oj3WKtTqy2Wa5Xa0HeMvia75qr3STJ/v8xITJ/7SZzLr9vlZ86unQpCaRGAzU+7i14hXTtDrUbOmzlbvyGHj7A3z65KndBexDsa3zTm0nT6jB8NV8xxFKXom39/4Y0YHHwgqOKnrqR6r0ISQ/oHXe5vI1sNvTTO5jDqj5M8LfjFIwou9WnE8yRV/66SXG+ac7fzVPfxkS7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL9mnocAzrqZfhl7rEoFw1lpU+uvEwLOAO4dfCA1UqY=;
 b=yi2vFo83+kDbSBGVFJrL8S7wRZ3NE3R4xuGZAX7Bm/4YproaVm25a5MED+VQ9rPbogpwmuU6/JBivaYlwgjT0vIc2un1oABKys6RgEMQNmp3GLqu1V9I5/ekrnALDZPO7xHNxP2Zkrn/z6cn8lNr6QmBOkJCrR88KtINa1dKSw2zzn2/4W8K2+VXNJG1h8rL/AuqwEUE+jt7/mMHxpz1Nyubq2TXsGRYqTnlcdlUuKGXY0cGG9PN14bGJv+gYV7k2ni2CaVkwPiJgZ1eT2vVVwIm4TLDSjxsdihUTH31x+xc0eCHhP5LpmlQDkc3cV6QBFIaoWqgmnhwU+lv6I/OXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL9mnocAzrqZfhl7rEoFw1lpU+uvEwLOAO4dfCA1UqY=;
 b=g4QuGABm8rplYaXm6RqfB/6mB9+b32VbdalC6ls+NzZoITtyIWzMdg/ipzb1dyMdRJDanCXs7dtY9uPQY8GrU8aDt/Q6z2IoCovb4CWNdCWlA0nYGm8b4CB/Raq9ZFQUegVSTN8QPu7Fkg1y6W5Mbts4CV8VkNf6fv74z7/el2OzloioTKTeuOr/uIXW38hOWY525885OUHcDm4Z6v74j7vuUgJ4FzLcDMve1la5sTBpKUpXj43DIuMWsY16NGapHmMPayLbvsPUSP/UxXefVqtsv61QJh2dsIX9cFcN5H38pNX8K5v5Aoc7ZKts2yhZrKATbcXhxdtjzqcCxp41Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 14:59:14 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 14:59:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 23:59:09 +0900
Message-Id: <DJ0CR9A8OXYR.27EFEWLDXK5RZ@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/5] rust: inline some init methods
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260530-nova-exports-v3-0-1202aa339ef7@nvidia.com>
 <20260530-nova-exports-v3-1-1202aa339ef7@nvidia.com>
 <DIZE5YHLR2WJ.1VOBKWU8Q6AWH@garyguo.net>
In-Reply-To: <DIZE5YHLR2WJ.1VOBKWU8Q6AWH@garyguo.net>
X-ClientProxiedBy: TYWP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 68677085-5927-4414-1b82-08dec249d73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|10070799003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BXKdmKc9rhxD28nLh/x0/Pn9AN9y/mnVW8CC88cGMlFqNRoB44uccrnwDrD5Tp2ZhC2yShhbbG7CSNoq84ne4zq/YRVqjXMwxXsAxCD2S4rQephsjWm3y1TwdbjHBZQVKO3Lhj12FYny1Sl7MhVd3ClUUJzfeEsBRiLGZcczgcc6uz/edtRjyDm9u9PGxjPa+xV6M0EELCHZN8N+Vn0XUEai7R9my/tzhwLd43wBMVm7fGugLwWLbPpnueA1GaAOJJ0JSYDqXX8yEOGOnpBNQPc51muuppX+Qbg1KON5Y9RPsAkMHu1nmG8aSBFkh0CRVOIzqFjooHYfqDKZ9Gk16E/2gKYMHubeq/BhzRH0BaeKtvzo01o74GjqAMCHHoVBxtmHMCagiBeRIpYyKVGQj8t27i7H/e6I3/a+lQ4FAc5mo+uYyx8v4N0ueNvPmtXpWpXgxJSem0fSCWnJf8Mtb+DbpYfJt6ctyT9k9f65FJMZDGhKbo75CuNhF0/jqB51JBxNkJfLXITCgQzmkcq1bBCzhKFYKEW9oVRLHlhOiMDis999XXLrOyk4QNy6EBpguoeQl/z/vU99MuLkyM1VJDQiA/9sdpXs4MXU6LOyxswpPi5xyjSH8xEsxPDwyP94CDLK8B598dH1+jXS7UksodAXKjZDw+qJmhF6lWmkrvv/5NI1qqJK7yioSkSfulWJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2ptMXdoYW5xL0xqOWt3MTdvL3dsSUw4czFpSHRoQUF1ZlNXUjQ3aVdlK3Az?=
 =?utf-8?B?NGdpU2swZkRxdVFONWxsbGpFNjJ1RzFSTkNoc1V5SGRGTkFlYjRud0hpVGph?=
 =?utf-8?B?UE54QTB2WkNQRlpqUEpubmJ0YkIyVWk4TVVKSzh2bVRWZGpiTU5Tb1FxY1lX?=
 =?utf-8?B?eW9UYVZOS2tNQm9BYTFwTm0rTmk4dnp3VCt2V1hUUDgrSkkrOHJHRzZLQ1BD?=
 =?utf-8?B?M1BCR0htSWswbU80TFNEV2hZKy9mVVprK3FpUTRaL2NzUVluakhRbkVTd3ov?=
 =?utf-8?B?bFBrWCs5R1pMTHBBQis3MDdPcWh6UEo2dlRVTHZYVXFYclhMV0J5L0kzU2E5?=
 =?utf-8?B?U3poV041Mm5zcGJSMFM3WEVFR0x6MTQwTWh6bG0wR0h1c3VnUU1pN1ZDVTlM?=
 =?utf-8?B?N3hWSGV0N1NEK3gvbUNkS0JmTHRNRysyRlNpSXFOMGVOUTRrYWcrdUg5Tk9o?=
 =?utf-8?B?dnFiYlBqRUlZd1RIeG9MUnpOSzJ2bUx2OXMrNHk5V05QTG9TTWh5K09pYUla?=
 =?utf-8?B?am53ZUlGZnpwYXFKVWlOSzZXOTBwU2JzbkswYStpVjZPcUpVM280aCt1NHZ1?=
 =?utf-8?B?dlpPQklFSzhqQTVaTFBSYUl1VHhtY2hMYnhnNmtCNC8zQjI4YUt1V2Z3L0FN?=
 =?utf-8?B?dzVKVFdidVpKK2tNaXpkbTc2OHVNellXVDYvTlpIaGJ0L3VOOEQ4d1p1SW9R?=
 =?utf-8?B?eFRaOEttK3RJVGlGVXBBemZKUWNrb01zK3lwSWpEdTdrWS9oR0dmeUNpcWtP?=
 =?utf-8?B?L1JONlBVd1RlYk1BMlNCRVlnU3IraVVZdTJnaEF3TGU4dWVPTG5IVWExOVlt?=
 =?utf-8?B?MUVySk5uTHZraC9HTHBId0NuSHZtK1lOMHhLWFdNQXdGb0ZkQkEvWDRnVFFr?=
 =?utf-8?B?WiswL0VvT0RFeEx3eHFnUWhTUndEa0FGZmJGZllyREpqeVRzeXR3Q0M4eGlG?=
 =?utf-8?B?MWFpUFprUHJlWmxzZDlzU3RmVVlpOGE3cUVoMGdqVVFkQnVrcXNkdDF1SDR2?=
 =?utf-8?B?Vjhhd0NxK0pNNTNGdUZqZ3pGSWxneW9VS2dFblpLWW5KblNIMWJiOXdqSmdy?=
 =?utf-8?B?Y0JBbDRYZUlDMTRybDFxMTYzbHlKSCtZaTI4ZUVKa29yNkd5ekhSUFRZUG94?=
 =?utf-8?B?dnlSM0RtSmlKRTFjYW1nclk1UUJXTGRVOFBNRGpFaHVGcjZwMkt2bVd1QVBz?=
 =?utf-8?B?OWdQMXQwZkZ2eDV1YkxYWGJ4eWFZZlJXSXZvSjFuNkMzb3BZa2c0RUpHNmdI?=
 =?utf-8?B?cUhCYThrNjNKcFFqeC9IRk9nVlBZNGFOSjZNc3MzWmx3TlpWRys5THBJbGdS?=
 =?utf-8?B?VkNmUlZBRkZ3MHQ1Nk5Ta3BCTEZEQTBFdGQySmpmUHkwTmtmQXdCeGN2YU5r?=
 =?utf-8?B?QkhoL2I3UmZZd21xQWZPYS9Id1dGcTRmeTJvbjBYZkpVRGhiQ0FDQ1hKaXJ5?=
 =?utf-8?B?L0NlaDVKNS9RY1M0WEc1RlF3SmFiSG9xN0F4NkJwb3A0UzJrMVpKaml2RnRz?=
 =?utf-8?B?aU5FZXlYUVQ2REQwYzhxVzhJTG83Nzc2RG01ZFN6RUJ4WDBBd2NwZi9vMFhT?=
 =?utf-8?B?Z1pscTA1ZnVTSm5kZDhKM0liRGxzMVBHNkd1bWoyaXl1SzlmcExNTlhhZW5m?=
 =?utf-8?B?V0l2K0VuSHArK28wUmR6ck5GRGw4cStodW53citVaUVwVjR3YlZCRXlGVFJw?=
 =?utf-8?B?eVpYYWVDcW5DMElFTnBlYkFSeXg0Q3VRRkpHVEt0YXdKb29Od1ZhRUlqdnhv?=
 =?utf-8?B?TzVuZEFtajFhZUVCSnZ3aDJQWGdQWnd1WGNjTE4vam4zUzRqZTc3SEpOWUVv?=
 =?utf-8?B?SFZtcFpKckM2dHZYemdVMzdzaXJIZG5FUkpXRUdCRE1XQ0UweFR2TXFYQXpx?=
 =?utf-8?B?Q2lYMGgxUHNmNjhNNjAwNG5tc2U2TUE4UGErL0xMbkx4MmIyS1ZzS3ZpNGl3?=
 =?utf-8?B?SVE4Y2hDVnlEK2pkWStSVTI1emdGaGd4V0lMcmp0cTBGVEQ2Ri9BSE5ZbUVZ?=
 =?utf-8?B?dXQwL0dKSHdkRDRXVmthWWJJNjB0YTF1S0IxSDFLT09OUjB5UElxNmRKbXNG?=
 =?utf-8?B?YkxZWVFDc0NFN3lDaUpxRklHVHdHSmk3TmFLZVk5dFRhaHdKNmQ1M2lzNm02?=
 =?utf-8?B?bFpySk1keERrRXh5aVhXTmF5OFlSQVhaeUQ4aFJzdnNvZDBDcEE4WU5EdnhP?=
 =?utf-8?B?alpDdnVpTzBtR2ZPZ0V6Y2VLSHBFQlFZK0xzaHNnL2FQNlM0L1d3Z3k4Y2t0?=
 =?utf-8?B?YWgrck85WjcyL1kwd2lKOFYrbktlSFdJMEJUUkFYdEp5NEVjb3JkVWF3d1pW?=
 =?utf-8?B?Y3dFeE1xbzYycE1IYmFFejRaMDVFWXcvVXh3a1hCSStIeXRJU2pJMXlVR0VO?=
 =?utf-8?Q?JMytewgYXA8MwMfqPy82qgwHOTwF8wqhXEL76DD5Bi42G?=
X-MS-Exchange-AntiSpam-MessageData-1: lK7RV4zon1RZxQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68677085-5927-4414-1b82-08dec249d73b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:59:13.8421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhtgeUwWbE/DQn/Pd8msCjHxNTLV8bLPJnzNH7bDxqcREDXQ7dUe/2mC7X7wcVQ79y/dm9Lgas9DD0XEcizO8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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

On Wed Jun 3, 2026 at 8:52 PM JST, Gary Guo wrote:
> On Fri May 29, 2026 at 4:27 PM BST, Alexandre Courbot wrote:
>> These methods should be inlined for optimization reasons. Failure to do
>> so can also produce symbol names larger than what `modpost` or `objtool`
>> can handle.
>>=20
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Hi Gary,

Sashiko suggested (and I tend to agree) to also inline the following
methods for consistency:

- InPlaceInit::init
- UniqueArc::init_with
- UniqueArc::pin_init_with

Does your `Reviewed-by` still hold with these methods added?
