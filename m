Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C28CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 074F410E480;
	Thu,  2 Jul 2026 06:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TFvnmH81";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C738A10E480
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 06:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjdZ5Y2a5h5WYJx++OnfxUGpLnA3wHWlH1kBSI0AWBQ0JzioLYOLWF4EXrqFWKX1PYCNbzQu4SlHuJYnf3k+Jv2DUOG2hpr0SVf09lhC39Xcrr08GEKEAw/ndcWvtmzQBck1+Bm6R3C2zJwuD1SRGS7p51JTH6rNOqqpR0ltdGPXRcp33YKtGI6VuMoYknbdBUUFJ1wxFn0t7Nfp1e0YAh/q+GfMC8xf7KtrFXd4mUUFKDfGUktv3K+8s1Jde8lul6TRFSjYE13Zyob3XG4MRAT0ytwJaD9tYet8TrGZWx37QLs61AYxg2ObQI/cXT6JiICmBL0cj1T83UCB55niyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4i07cAoLHD22gJcX093lZAlmIWr4IqiI3o6XAObsfQ=;
 b=In+I9xrCsKrs06kD1bdrQM2tFMYgZPGaDuINRJXNrLmB/AjEHCrPdArOIT5YkKgfUJiHoANU+qefZBU1chH425sKQQwrl69nEUXvqQQiOaRWDJTL7qVqyC1dt64JD/hqtN1/AIgU1GuuOvAzn0PdIWSmrlAcZKhwp6ovP0U13+5g644QdNk+Whjiwhco+mrzkHIr6+GLizfqZ/UJ1/V9U2xweSek0VY5hp99uvTCMK2Woy7pwj7oke2+dbWdfs5KwQjnHdracrpaBQ0yD6SN2jV7avc8Vq+8JZejBHmQFFa+aCPtykGQhSlFfb765YjEzkBsk6xaS5fI64d+3336lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4i07cAoLHD22gJcX093lZAlmIWr4IqiI3o6XAObsfQ=;
 b=TFvnmH81A+ETn/ToC9/tw+bCrsWDhS3OV/v0m27FTuIB8CxAoAJPW/XogGCbcBUhHM3Cvta/f7HD8b0bB3EmJYmzeNEeypHATrVleU5QKFKDdua0mljhx/NwQi25DU/BPN+CsC7KcQsmSnoyXC0nZ/lNuWvtyqBvjLJm8wIkD6AmcqiWYPs2+7rY/loY3o0hoUMwcte4ZzwGrltlGIRT4z7Pj0bYKxU+AbBgonLtoizf2eJIcIjNfvg2L4R8beDwRN2w8csDjNubIpeTBAtjf35zeqDyyA/9J9V6KwwpeWY7ZAyjHNj5voBd5GTlknAEtukmtbxXleOLulbUc3pK2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 06:43:14 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 06:43:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 15:43:10 +0900
Message-Id: <DJNVQRDHAP3E.3MT6S0BRSX5FN@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 15/19] rust: drm: add AsRef<ParentDevice<Bound>> for
 Device<Registered>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-16-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-16-dakr@kernel.org>
X-ClientProxiedBy: TY4P286CA0123.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d478b41-3019-449b-1624-08ded8053107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: R090NMezoakBJpeKjn0dccs8g5fwHJQiCl0ixUws9JiduvFXoRmYUZScY/lDTwDFgvPLlQ46ppPfWDAOreGnNCKjOj8VwSb5ETAIsSkOlq3/ZAecgHzDmPwyBM9a/lO4lVIJ72QpXji1OHboMffg+Ew/2M9cEsUFH5CmW45JIe1DTtfkUeujQMAD7RG8Vxh4q8ee895j11ShxQwO6PGS6zI0TvmAAtL4RmMpl0CbElNOQ/eJllCDdpRVjrtR4p3mr9u4fXGqHKQdU6+t31eU97a2dnl1KsE9sleIYJqNf2qwPV8H8nkgVeivrSr9RAR7wcCZSJ3BPki3wJ/wviupdDIfLpewwDfQsa0TL/9ZCpj6Nq0WSS600aYHWAvBcm034LrRLtRyw+SHQdqBsD6tnSxAlO8IOKUGywWspE5mqT+CKSnWDREgEaBholJoZ+TXVHmgNydvfCuQ3wX+3ydGoezkV4aHJ9/BmNpdOFe2+o3M+BQ2CH1/cBQRcW+LQm1/Ii1y7H4C736ER92C5GHqYSMjy0JB2c8/zQZzYNm2a/XUzyh/0Whws7DQkNswDMa6lME2gU30fjDmYQe5DF3uJDNkNU9Vw1aKO2IBGlGw1il/p5sLWNc3VnCTERRrGaQWmU5aqH5XzKnujXH/FHL/P9kgBocWn9jstSocWFFV5rM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk9Hb3E4RHUwS25QWDN6YmgwTHlTNWJmNldYakJtb0xvTFh2cVFLNUhHWDZC?=
 =?utf-8?B?UUFiWVhRcGZEYm9WVjk5cWRDVngvY0JJWndNWW1oazUxYlo3RHBVSVFRQ0d6?=
 =?utf-8?B?SGtXcG9xZ01ESkZoVEhwVldhN2lKazZTajZYZGN2SVBXdmhFeCtYWmY3emNW?=
 =?utf-8?B?eWZLL3RZS0hLSWcyTXRrWWtOQzc0aUk0OFJCUkNDY3NoL0xuU3dlVEFkaUN5?=
 =?utf-8?B?Tlg0TXNkc3U4VlFhanlRanNoMlF6RWFXSlhDOU9SQW05Q2RSbnRLQjJQKzdE?=
 =?utf-8?B?MGh3OFZXOXdqMnl6VHZadGMxNFRUdis0eTJWd2VVTHN4akFrRGJSaGVySGlS?=
 =?utf-8?B?cWtYbzcrNUt2TjRyM3RFL0tRS2VXZ0hENmpDVU5DMzR6VTd1emdQL0pWV3Er?=
 =?utf-8?B?Rm5XL3U3M3l3OVQ0WUoydnFqNXZtVUdnZXRPSlh5Y24ybS9KK0tXclV6UmtZ?=
 =?utf-8?B?SVNlV3ZMWUVPMTJKczlRR2MwSW1VSW9TWFhESEczMXlOYUEwd3hCWWlPY1Rs?=
 =?utf-8?B?Zkh3aTQyQ1VRNFlRb0pETjZpbEE4ZVp6eU1XelBEWXI1OEJsYkQxUlVicm1C?=
 =?utf-8?B?RlFUaEc0dFQ5Mm5OcWxqL2pWL1BkRm84enVIVjlERUt1UzUyRi9HaHdDN2Zy?=
 =?utf-8?B?MkFqa0pOZDBlNkZwMHRGR2ZKbUtQSUUzMkJ5NU1iWVZwSmhKZkNZWlRFVFB3?=
 =?utf-8?B?TjhvaGcyNi9xSWg0QTdjRkc2U0Y3QXdHYWtZYjg2Z0pWTDlnU2tOeG9OWUJv?=
 =?utf-8?B?OVRNKzFJaXpkRXYxZnBJdC9YdlVlNnlmRDI5WnJhRDR4d3RIV2hYQTRvQ3pi?=
 =?utf-8?B?Ry9JdFdrZDNrN2loa0lpcjl0eXBaMDV6RWx5V1Z5ekkvRTRSaFUwS2NQNHRI?=
 =?utf-8?B?cU5oa0JIZHZPbmZ2WmMvbUluTkRkcEd0K0hQNDZ6S2VwQ0JQSEQ3ZTB2NThZ?=
 =?utf-8?B?bGZLUW5IVlRHeEhjSTJWOWhFUHBUbzFxcHpHYkJsR0E3VStGKzgxTUVSZmZq?=
 =?utf-8?B?V1ZRK1pCNW1XZVkyUzNGZHI4WU43ajd1Q2NQeUMzSWx5VWNNMXo2dU9xdE1B?=
 =?utf-8?B?Tm1VWGJDSjRlVll6L0xzeVNsaUllVDFiZmZIYzNXWnVkdW1rR1FPdGZRdFc4?=
 =?utf-8?B?aXYvNkpsdlVhdFE0Y2VHamNZR3pTSVJZRlE2czZMbXBIQWhEQVhKVEtkekpo?=
 =?utf-8?B?SXgvaHhPMy9kWDZHTzIvMDJIQnlFazhBUEdxZXNLVmFGeDBIZzg3cEI2ZGI4?=
 =?utf-8?B?MzhpWng0ZEZPekE3OUdTU0hXYVk4cGZVOTR3R0E4UDRGbHJ5QlBqQ2Q0RGho?=
 =?utf-8?B?c21QazZKS2ZvQlM3VmZ0R0RMU3dBUVRTdE9uSlFPaUQ3TFZVZTB4M3A0YzB5?=
 =?utf-8?B?TnlpZ2p0WVUwSTA5NFRnbjlBK2R4NjVmdk5OckhXdHFkV3VGRTBpdzJNREhv?=
 =?utf-8?B?b1BHNFhHTUdaWjJ2RC9KbzE0bHd4d0IveVJ3Mml1aXN1ZEJZNER4SkF1SHVi?=
 =?utf-8?B?bGlPNUpGRXptTG1FWU5pM3BTcDUrOXYwa3dvVGN0TllJWHVKYlJHVzk2TFhR?=
 =?utf-8?B?Y3lhQzJLei9Xc3JIdFJiZitIYzBTWEtzSU5kR3ljZlVLdUljVTlldVNrdFhQ?=
 =?utf-8?B?aXVURHBXc3NyUXhmNUFOM3NRMFNpVXE2bk1BY0pqVjZWL25adHNmQlNyS1hU?=
 =?utf-8?B?bXBiMFc1blRSQUJWRy9EcVREQk5vUHUzb3Niakl4RnQxcXZjZ1VrL0pGWi8r?=
 =?utf-8?B?b1gvTGlBc05RVFdlbFNqTU5ORFFReGVZVUdIYUp0RXVvZ0pyNmFwdkFwTkdQ?=
 =?utf-8?B?bzliMW54QnBhd0Fsb2lKcWcwNTJvc1ZGT2JQK2ttL0xmbWI2WEtxdjA1Wlkx?=
 =?utf-8?B?dzlmSmhjY2JwNE5kZHRaaS9wOFJpUkN4RmxRNitqcWlYNTlFQjVRQ21TVmsx?=
 =?utf-8?B?a3dYWE9CVU5nNTBpWWRyZXR4ZVNvNUlpdERLaUdFVkZHQzcrQ3oxWEU3K1h2?=
 =?utf-8?B?RUNLeDhUQ0s1ekcxYmlhVGcxcW9DZ1BLYnMza016bCtWQ1JNdlZlMjlJNTds?=
 =?utf-8?B?Z0JTcjlEZVkzREZMeFZ6aFpQNzc4S3FiWVk3SjcrTkJnaW9uOXJKOVhJNUxP?=
 =?utf-8?B?ZEswWERrTkRXV0JyWVFiSWtWTkd4VDdDcjh0Y1J6ZEtzbFFLNkhUczlxWC82?=
 =?utf-8?B?RTR5emtnVDdROXZ1cjdoQll3RUhMTnZFc09ySk5KRWtLc3UzWjR6UWpacHJx?=
 =?utf-8?B?VlRHdERBRTlFajQrVVhEdnMyOGZZQ29DSldPZitOYjlrTlB6d3BkWFNBMW5T?=
 =?utf-8?B?Q2I4QkNUUWR6R0VoWlBhUUN1cHc3aWFWMkpyMzg4bzFMdm12cHVodVMwZDNJ?=
 =?utf-8?Q?6+6Jaddd7fbKhCLVJkczuTFnIkzWwpNEWWnz/dZALfpY/?=
X-MS-Exchange-AntiSpam-MessageData-1: DDK7UNQnar0Isw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d478b41-3019-449b-1624-08ded8053107
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 06:43:14.4399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWVuuWGsAJ3PHyH79nxpgCqnxSqWyuP0XBihZjSt+JwAVLZRIwpdrIjjxC24Z2tVCZ7wgjQw0XXIm8rXfsvldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
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

On Sun Jun 28, 2026 at 11:53 PM JST, Danilo Krummrich wrote:
> Implement AsRef<T::ParentDevice<Bound>> for Device<T, Registered>,
> providing access to the bound parent bus device for registered DRM
> devices.
>
> Since a Device<T, Registered> guarantees that the parent bus device is
> bound, the conversion to T::ParentDevice<Bound> is safe.
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
