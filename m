Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FD8C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A8B910E2B8;
	Thu,  2 Jul 2026 04:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="K3vjFiUI";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3497510E42C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 04:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/MM4KNycczzo4Mx4Lm9QvjO8j6e7HgPkYT5z26a9N8v9a2DC8w/pQSf3pLMgZS2GmwEXfX5sOhdOExoODiFDsSkDYDtaz+Ic+4d64s2pbL0H15Q9y3s3+ykxuY6siKIe8QZb3UBLquRZDlXgkJjV+K7sXLj/LbAf5W1Ci3PyRpnJrnJDTh6ufR7Ma3E/Qy53l9nBk2/FJE49tcLDZmOko8PbpsWs+YAr2uKQy54ZO+WuDY1ZJPwoPkdiKQuuG4oIaZ9iWWweCr9dbo/Y4P+JeRb0Yrcjgi78DkpW4GQ4+WJ1TbzamtmldvMbYJRq/KBGFap8uvIahFM/UkI74WJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/x2nxXjxhnMfCAunLqWbem6UmrSUPmPB0AjoiCprHg=;
 b=ovTAdqaBWZSWWsnzPcg5XNrCAE16F0pyF2hB6OUDd/x0C9R9r8MWPKlHoEHnSiCqkeohVuTHC9votitn3RYt8hPqT19nIa245HuMtT2Rti1uNNLx/dgkFo8TX7slD1lNvXjEPhs80zUWy9WEOV1zxbiyTZ7udsHsPBtUK0Mw+FqoB0Ty81rOMSsAvGnlSjE3HAbeytsbjc6umn6yARoM6G+0VYCMyugaj4OKea99rlmVdQpzTMQBtlNRNjgXXzOBQSuwrl/g1xFN+nuKrh13OGkV3f6Wmpy2uNNfyrBhO1cPJEjSb6n3Fug/6A4Y7WhfqfTyM+7KtU966DnGUeFiRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/x2nxXjxhnMfCAunLqWbem6UmrSUPmPB0AjoiCprHg=;
 b=K3vjFiUIVg0JlthJ1RSsNjmuAo4f0Jb6YPJ8ChAV/DQ/6Ryyr/qhUwyH9MJK1WIsR3jEa2DBNpp0cuiwvN/yFT0klPCqINbEOyyI6vRjhTM9/bOiC5soU6CQQ6uCrYJgwDjSP3xhncANZdqrw1pzuch4PxfTDnySZGyIpQ0jVssEebDsP3sc1fuGvfzTH5dohl2gdzu1qN59CUakVKVRY7QfrI6I9Cnh9fHwjJgVWnYr4OAWlWG7c2U05izbweIF3lJXJ8Im0s6i+2BEKILooqFYxLdKsKyfV612eVN+Ar1wVfaN7sOKP8gxvnxBf+9pCFoBZJeSTShR00sgAFYKoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 04:38:36 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 04:38:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 13:38:30 +0900
Message-Id: <DJNT3ASUG4FU.3IE0ARFHAVMIL@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 07/19] rust: drm: restrict AlwaysRefCounted to Normal
 GEM Object context
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-8-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-8-dakr@kernel.org>
X-ClientProxiedBy: TY4P301CA0123.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: ecad477d-a7be-4e10-0ec3-08ded7f3c634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pzmZw12j70f9Q4NjldhxEEr28/CZOCYLoreP3FG8TfnyXOLq3vsuGqrKy2e8MphS5LNgoaDjIBwHoHiZdogg2zalDd8WeJgr/IsmtehNfDDe92WjDDB7KG9BdzIOf22ErPlpeg4UCoxtFfNCYOVUnupo7QWgUfejM4CEYD5Do1LVHB9nw8/9f3MT5agARWQkI6r6+sI7Yq1BqCL1sLydJtaCR56iTIYtjO22Goo86wB8tV+f8WTsNMVz3yaXwWhnw6qdqVGj+VD8KhZLjWEpO9J4eIB9W+kQDE0ddQdekegCxB9zWiKePWEIgY3KSQuOwP75S9dhgZiUzYk5yGDSj1tBXSt1L/lDpDj7DRmaVX+gJG88tEc3JZwe9Ropsc8hj/fYe+Z9kl1VM0hrDedxE37OOV2iJ2fvxQNUVq4FMK4lPwLK9lzkzFVaVfrn5ooyMEzohFWYdM3EPTjIZHVXrYg1F8hJBOZaEz6dtM6qAViGiyMgBvK0dOyVldh/MtmQQQjSxJEy2Kfbl2aizva7cjRt/w8WZRz048CWDetSsu1ghVTMJ7jBWMYTYa44WTeBqwZL1Jl94Vfjx4xMqa69ADB6MduA+/AJXYcd2pB0UVyqi7kIvYIkGer6m+UetAoSlz5gKFol92PcHQMfZRxqzMVRh3XAWSTQDt2UQKo92zg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clhWVFdCYkxnaXFWTWUxeHptem1NckV3czNBV0Z0bmI5dHFsWHRNVWtZR2x2?=
 =?utf-8?B?WWt2VVpxS1psckRncVRFWUpnS0Q3NXh1R0NjRUZTdFgrelZaOXpTaitRY1hR?=
 =?utf-8?B?bno3MXdKWTFmYzJUc2UxY3pTMzNVOUF4c1E4V081dytXUTQ0WFBDSnI4dW9k?=
 =?utf-8?B?UXM2Y3BVSkFBZE9hRDVvSkVvUTl6UlVJTkJKZmRZenk5RGNxYm9HWGl6RkhP?=
 =?utf-8?B?a0V0aDJNNVNnMDBkZlVaU0NDa3IxRll3amFrckNUcUNKZlVneitnSmJZVTdw?=
 =?utf-8?B?bGsyUVFsemF5VUFuWEVIczNSVTZ1bmtEUlQ1QkJQS05VNmlnUkNkdzczZkJt?=
 =?utf-8?B?V2QvVGwxZ0NrajFDaWNxWnVjQXJNbGh4V3g5cHdndE9hZ1NkTWpYMjN3a1h0?=
 =?utf-8?B?ODN6TENhaWRuMjVmc0I5eXF5QzA5SlRrZnY0a3FMa1N0Njd5T3pCZjFZNEls?=
 =?utf-8?B?WTZIUFF5T29BQzBJV3RXQUhYWThEUDZ3eE9Sb1RnandMSUE4S1lHN2xhMHBE?=
 =?utf-8?B?TFFvNllDZUdidmlwSVZyak5nUVJtZXVDRmJqcUV1T2FIOUdSQjh6U3hRSktW?=
 =?utf-8?B?NXZXSVRULytMcXJSR2pkQ1Y3M2FLVkpCSFBlK3kvdGpzWGo3WERSWVdYUnhX?=
 =?utf-8?B?TWdKSFJxdWNsZjREdVNlNGMxbmNhK2tYREMyT0RvWmJ6UHlHUEJSaEdYa3dw?=
 =?utf-8?B?WUNwOFphN0lUUGdVeUNmQUV2UkZTNG5rT0tJMzQrcEZmSU44OUVmNzh2WlBo?=
 =?utf-8?B?bE9BdlhKZk1xVHVnTFJHRnBkNGVOQUxJZ25sbWVTcWl5ekQ4KzNlUGtrYUdt?=
 =?utf-8?B?TkpkcTBnOU10K3ZKd21GY2RSRzNmRjVLNDczK2ZROFVRZnBZV2wzUW5wZlA2?=
 =?utf-8?B?czI5MnpBWVRSdmdqUGYvdzMrTGQzUDlBRk50cFduK1JLZFVzZzdzcml0aDlP?=
 =?utf-8?B?YURGbk9pd1BPR0c4VnhBeGkvbkFYTHMyNk1MVlhETFNNcm9lT2hVODRISFNq?=
 =?utf-8?B?bGloV0NzdW93SFQvSmcvWkdlRlhaNVo0SG5CeitmUzhCMXoxM3Q1UGxSSkZz?=
 =?utf-8?B?WGhwNVBGNURHbi9EZStibHdqZEFBUUNqa0hsbTZ1Ymh2dG85VVlqRUVRSHVj?=
 =?utf-8?B?ckVJaUJWcVZpdTU3NzVhQ2U4VXR2L08vTXJoMTBCWE1TMm5ueGpOejR6bVpY?=
 =?utf-8?B?UlRET2ZzdnErQ3N0bmlzaFBuZE1vVmNlL0R6L1IrQkhGV0JtN05OS3NoUkV6?=
 =?utf-8?B?b2Q4YnVweXkzTy9vQXJKaHcvcVB4MitNM1UzclphTzVNOWltc1doYlY2Ykc4?=
 =?utf-8?B?Wjc0VFNQa1NuRkgyTm1JeDJaSThhSUMxQnl6WERTaEFHYkUwSWN1VmV0eFNj?=
 =?utf-8?B?S0lQb3dKVjF4enJReTlubUtQck1Ka2s1YTJQWjc0ekk4RFdQTmJ0ck9KVVRn?=
 =?utf-8?B?V2FXMEtXQ3JJLzlvZ2VBMUExS0h4QWZqelhhV25yUDEyYWw0RWRXY3BMTnN5?=
 =?utf-8?B?M1ZoU1VGY1B6bm9ZZ2hCeTEvOTZjUEVPbm9JVW5FUVI5aEFkNldDUFJ0a0JR?=
 =?utf-8?B?UG5TdmZ6eHhyWG9kbER3SGo0UEYzS3gwR1gvWFRtT2hGaDdQdW1qa0lkUVdY?=
 =?utf-8?B?UVVjK0hVWU1IRys2Ukx3RUZtRVI2VHNPOXMzbFdZTkR3dC9XL0pvYnZDbXhV?=
 =?utf-8?B?YUtIbE9lTkROSUhocEE5UVhzNVRncTdPQklUaVNhNDl4eFRIeDlDOU9UOU1m?=
 =?utf-8?B?aFhxSTRYeWhnRTg0M2hraGtBaFZQZmdnTlZhcTVvUk8ybjEwSmkra2djaDJH?=
 =?utf-8?B?V2gwUk9wRFRuY0IyYWYrdGJSNzZJZkZ1YTBVdlFkL2tWY09yVXM5cVdRYitP?=
 =?utf-8?B?c2p1ckYrNlJ1akgxSVl3UGNzRkNVWFc4blY1YVpIcnNXeWNGNSsrMUVNbml0?=
 =?utf-8?B?QStGSzIvaXdQOEMvODY4SkRDcm5VVXlrYXBWMml6WUVmb3VuVjNsZWZGQ2hl?=
 =?utf-8?B?cG1La2hDTVgzK0FuTWFOUzFYVGEzb3FQdk5saEkyWGpwU052a0ZtZzZQckFJ?=
 =?utf-8?B?ZDVVR3MvUUc1RlZhMWRBUGJueEpYUUtibFRKQzRHYkpxQldjRUE4dUdzY21w?=
 =?utf-8?B?TGF5OHZNRjJsUmJXQTFlRTU2Sk5MOEVwTndxK0RtdVQ0Q3JZMit0cGc4S2tV?=
 =?utf-8?B?MjFwMkFPUlo3MDlZL3RRZ3RnaStrVUxId09vZXhqRitnSkJBRVV5QmUydkVR?=
 =?utf-8?B?TmIrQkVzZ2xjQmYycDFPWTJvTmdyWmhndjJsL1NWZE5PdWk0R2dIN1FZZWtC?=
 =?utf-8?B?U0Y3bUczN3ZkU3A5LzFXeFpVZU9JRjh1T2NPalZJSmpsYzAzOGJ0Vm1QaDRO?=
 =?utf-8?Q?1QeVt7IW1sXo9tOMW0eV0xZ0RhucVEYBATmnAffniYfnd?=
X-MS-Exchange-AntiSpam-MessageData-1: zDkJYq0nhxaj1w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecad477d-a7be-4e10-0ec3-08ded7f3c634
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 04:38:36.5750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf1hnrlDIFkv7Rn2GgXWg/j/d0r3TrVRKXCLcqIgBcM5L5oC7EbtEyQ+Bjy9+MH7IKtxc0wquJuNWbzylO86Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
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
> Restrict AlwaysRefCounted for gem::Object and gem::shmem::Object to the
> Normal context, since only Normal objects should be independently
> reference-counted.
>
> To avoid cascading through IntoGEMObject (which had AlwaysRefCounted as
> a supertrait), remove AlwaysRefCounted from IntoGEMObject's supertraits
> and instead add it as an explicit bound on lookup_handle(), which is the
> only BaseObject method that returns an ARef.
>
> Since Object::new() and shmem::Object::new() return ARef<Self>, move
> them to Normal-only impl blocks. Similarly, simplify ObjectConfig and
> shmem's parent_resv_obj field to the Normal context.
>
> Remove the DeviceContext generic from DriverObject::new() and
> Driver::Object, since GEM objects can only be constructed in the Normal
> context. Simplify DriverAllocImpl accordingly.

I think this last item could be its own patch - it wouldn't introduce
any extra churn, and would separate the concepts (restricting GEM
references to `Normal` context, and updating the API) nicely, making the
first patch a bit more focused (~+20/-35 LoCs extracted from it).

But even without this,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
