Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EB5F8E499
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 02:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF65810E1D3;
	Fri, 17 Apr 2026 02:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PsBAfVe/";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064EE10E1D3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 02:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqFivtDEnFqwHgKlt6heudWiGYlnanSVbfBDy/TKoCwzlnpewXiowiSDfWFoW3gu1c3jwCM5MLo10VSwqaWp/YsvpGrQqnHCi0CqwoP3B34QyQwos2qZYcVzINbHonEdfu3KI9xCbvAzW9wk6szUOxBtjsLUT2sGrRzV5TsLkj5UM7sbU/zeZpeXOE1BbFZPRkaVEVsydMtfbUo/dw3J1LuXO9KXjTRNpEw4Z+9UYcO63viCAfxyUzU8LxzTMTc/1Z6mGjqDV2dWtPb9e7NkzoG6mc7ZzLv6e2DnoVu3+YOx1bCCUglhZyipZzuQsB49IhzWjz3Ny7JHT7KVpOAcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qof00KACfXJnXOKxRqi4yJw5ovkItbbqt0lbP2tPJEY=;
 b=vUDr+GUPvc0cXleg3Ts2y/pwZ0jRc8G40Nwlj1A8grCtz0UYTanVgkVXCUrBIJmLIqpzSIDr/s/AAZ9jQX/GBmKWRXWKUDsxw2aL+nW7k2XqyF8vm/ohat8HFflygbzvgaPiDaCn/XFaZtPfbgp0kL2Bc9yxYWF8AdJPg46Wmc+o+6rNZeIsAbm7yREYEf7Yp4yWVr+WVFbbf2Pi6IwEUsBgH/C9OjKRrd3zpn7tE2OSyHwlmFcny40g0bsY1xj1IuyXOiP0l69iaiXEEHdYz6i7JQnREjgY3GHajB01Dru8uq71Q6C+IWN+QPRbpfIpVjl6r4ddYmq8e/P29FCjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qof00KACfXJnXOKxRqi4yJw5ovkItbbqt0lbP2tPJEY=;
 b=PsBAfVe/BostL/Fr73eaRVEdbRQVDHF6dh0wrTs2uIr/P333k3svZtSjctIVu1qk38+uQgDri/JNlqKzICLr1NX1EDGAmvL0tx3bL0CRKgsHtDl/LErjiQarr8XgpjtAEe4lsBeN0EOb4me5HIrZnAcR+fp7qyXQP7Au87OUyiyc2R1pmKHS6vwNhAumGYO3qh8Dd3Y1xaMBX7F3IFNx0oS81A0EyzRrFwdRIQKPZojQUX7lY9leMaQ2ClDR+c2S9bSQSNBhkraAxExcCMllwcYMPT5FwVigrbh/j7srwUyFoBv5CS1tKNGh+XUcK4VAeKX2PUEAFIden75t/MI2YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 02:34:43 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 02:34:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 11:34:37 +0900
Message-Id: <DHV2V1WWP7EB.2ZCK3X9RBH9I5@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "dakr@kernel.org"
 <dakr@kernel.org>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "aliceryhl@google.com"
 <aliceryhl@google.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Alistair Popple" <apopple@nvidia.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "John Hubbard" <jhubbard@nvidia.com>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] gpu: nova-core: vbios: reject extra PCI-AT and
 FWSEC images
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-11-705d30d16bba@nvidia.com>
 <acf292dad3656790a37f8b2f7b3a21f0cded50ca.camel@nvidia.com>
 <D7532B99-704D-4021-957D-1B50E33D29B3@nvidia.com>
In-Reply-To: <D7532B99-704D-4021-957D-1B50E33D29B3@nvidia.com>
X-ClientProxiedBy: TY4P301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfe774e-aecf-4169-b305-08de9c29e0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZZsm7IBGebAaV8Eky+ftVkMMOjmqGrPINS30UjQBvlsGsILqmxm6vDYDOaOpxswZ9JAQZLtDMUnY95d97CLNJxCmp2cbOEDy6ySXgxhehZrYYlks0mKOCOQmiwPU1gK3+SgPOeMgG6vdunM3xcAgsvp+igZmsVlHQndASJXAumPRU9hu874EW0zHgzfMTn+Hc5omYGLjpulIpirdmaEsStJsmeFj21uXZrStAbEZh0ONggikhWLJDQjTm9/uhogeDPsymZysm/vtBWpbqeRvP7TGd1suXbJZBtqVf+TQj5lgb1O0B51C/8DUloHiADQEkDLi0h6wU/xCSbq+tfKuMQ9zPhUXRXXxl/LSA2teGaxv25d9sY/1KjFAGaebuCHkchWsbzv8GYDCl0zAlcZdDF7/+lgzzFkiYufAD68Vszwjwzfo6mg0qllsuhtNm4fA4luqYGa5Py/dVGK4eOp6gBD7Re3mTGBNI8bIPUkvKPxmTq/GB7qPytD1MGS5FlwpLuLZhVfWT+bj1YMZHW9lA6Zi799xn+dRYxsx1HkW+9HlSOdh1rFzbSRkiKTnESM6EFdUPZMiCViWqXRftuSOPMOUDoaOPLUyNgHugLhswIpxX7zIX7qrU/7GH1zG2a3X1V6quJaLq/5YshPv9CQqYAlcb3PNCs3BraWVbsOrJy7lVZ+diJCxiMi6zj+129NFTsFNcNIq76GtDxrfYmPl5FZSAiIZuijGA3+VogkOsE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2pnRFZCUXlPUzlVbm0wRUJ0cXptMFZsZ1JrN1BzRWJnbG13MVpOa0xCSGQ3?=
 =?utf-8?B?RlVySXdjcXZKZXBiSkNaUExNS1ZNd0ZYcG52d21XNmhzd0hZa0tURE5IVFl5?=
 =?utf-8?B?LzVsRm9qMitUb3Axb0gyemtRb3VLU3d5L2M2OFE5dVZMQ3R4WEpNNUZXbVZQ?=
 =?utf-8?B?dnd5V2RJZHY5N3piNDFkbVlpTHI1MHJzTXpOWFZTdGxlZ2s3b3hUazk4cDRR?=
 =?utf-8?B?d1JOV2trRVRKQlNWY2c3SE0xRXQ1UE1yU2YydisydElPWHRuQXFKcXVnRS9p?=
 =?utf-8?B?eno3d1g4aU1zTkdqZ3dQdmo0Rno4WW5xMDFiVnZvdlVLcXFFT0QreGFLL1cx?=
 =?utf-8?B?SjdlY0ZsOFowc2l3ZjdNYUtWb0dnUGdpUUlubWxyVi8xZWNmZ1p3VzJLU3Z4?=
 =?utf-8?B?NDZZZ3RESVNjaDB1QmZic2poaGxlckxNaGRQTFdGMU5BYU8wV0dhaHU1SXpN?=
 =?utf-8?B?cCtOL3BjbmZNTDJVZTlLeVhKQVJlUTQyU1BLcjFacWhZdSswbktvTzRMaWMy?=
 =?utf-8?B?YTdyY1FyZWM5cWdiN05kcU9KRElyS1ljNDRkcnhCTmFXUXUyMXl2MnlDRnRh?=
 =?utf-8?B?dHcwaEppVW16eENFZTR4ZGZkRjZkZ0UzRm1NeTM2RkpDVE92dkdMNFBCRDZ0?=
 =?utf-8?B?Zkp6SStKYUdkNWtrQUJnQkpKNVZJa04xNE1KdmZMMGU1eHlLUHAvNlF4dEJJ?=
 =?utf-8?B?U0VjdlFBTjcxcmlHQm8vUHdLSVdQdW9ocyt1M1Z0VStlL05lNllndzZ5US9k?=
 =?utf-8?B?Tm1tTFJyY21XTlphdUZtcDEwa2EwZGxxRW55bFJleldpM2FtWDRtSmtnRU1M?=
 =?utf-8?B?Zjd6MHBGSFI4aXphYS9oTkQvQnl0VmJWVk82NWpVT25XaTFSYUk1aVh1Ri9n?=
 =?utf-8?B?WlNtOGhVVGVRK0w1R0ZmejZHeDNEQzl5SENKeVV0UUdCUDhNb3FCR1VMU1N1?=
 =?utf-8?B?azhVSjRNa0J1RzA4M0d2SUJwZndOMWl0RDYzbTg1NEwvdWhXejhNRktjS3Ju?=
 =?utf-8?B?QjFJYkl2Y01HdTNMNTc5YmdrTlEvMTFmNExtdXBzbjNxc3dRWUJDYmN2UEZV?=
 =?utf-8?B?a2t6SC94Mk5DeG55S0d3UlhzWkhGTlIyazZ3d3ZvR2wrazBHcnNBcDZSQWxK?=
 =?utf-8?B?bENvZXB5endiLzdLZzJQQS8xU2d0QUFNNTZLNkVZbHU2RnZSbC83UnFKMFls?=
 =?utf-8?B?Zm41YjJkMnJqaXBxc0lrYlI0RGE0K3dMWmk1Tk5raWVCQ2paZWZ0VEp4WlNY?=
 =?utf-8?B?UUxlbklkanlHSllTa1kxWmJhVzhNdVZaZ1hBVzZ1akVWUUFzMFV4TGU4Y0xm?=
 =?utf-8?B?SjcrRFkxcnhBZ2NxUmo5QUt0enl2R05ONGZYdjF6Y2tkQnVEajAxZngzVFhz?=
 =?utf-8?B?eFN0Y2VFVE92WEllK1h4VitGQnZRZGZHU1ZraVJUVk9uZUMvNjYwOFJDaW4v?=
 =?utf-8?B?UjY1d2JaNTR0K3BqTWZ4WlNTZ200Q3lXNUdObWFNQWJZdlVxdGF3NFY4TlhF?=
 =?utf-8?B?SkhjZjMvdkZmN3NqNHBFcmkrcG1WTXJ3eWR6U3pWUkovQnJEVU5hMTJ6cDZs?=
 =?utf-8?B?M0xyMks2V3BUZ1BMWWw4VS9tRmYzcGJUNVVsVnExdXZweUNiYVJNbGxUcGkv?=
 =?utf-8?B?SWw1OHg1V2JPakYvc2FlNkJNMS9UaHU5bjFKSEdSdDNwS1NuZlFzVlBXcXVs?=
 =?utf-8?B?VzFnNG1FQzR0dk96alBwaldLd1RxS25ENGNCcFFkYkgxQU0yUmp6QkxoajQ5?=
 =?utf-8?B?bVNCckIrRlJFc2Q4Z0YySWcxbGF4RXhIUFB2UUgxSWpqcExzUkxnSEN4TWhm?=
 =?utf-8?B?aHdqMFc1UVFsNnEzeWtCSmtERjhJK1hHK1FUa2VRREJFQnBpNE9BQ1JrSnZR?=
 =?utf-8?B?M0lWWWVxY2E4NkJaaGw1dmIvYUpmdmU4TVk5bHdXOU9WUVYrQS9YNVdkTGVI?=
 =?utf-8?B?eUVIL2Y5a2luZ2RxMXVudk1aVWJjWkg3UEoxOGJ5dlMvWVdBcTVFR2ZlZ05I?=
 =?utf-8?B?clhBa3RPR1I5aXBjVmxCenFsVlB3Q2g0UlZPSmRaQ2hyWUJOaUtlVHZIeGx3?=
 =?utf-8?B?OTd4MWNqbU1SanIzR2xYMEd6cVlWeGk4OE10MG9NV3FCODZhd1kwdEFSa0RT?=
 =?utf-8?B?eDFHenEreVdId29nY0VmZUV5NEc0QS9WSlhkMVFML1hnREp5WmUyZUswUndS?=
 =?utf-8?B?eEMxVmVHL3Yvc25vS1YxcTRCZUJvSnZYZ1dsc2M1MCswYVZ1Z3g3c3NHNkc2?=
 =?utf-8?B?aGk5M0dNNWdqcWF6WmVaTXcySlFoQWVOWTR1SkduamFlUlB2ekhEcjdoWlVl?=
 =?utf-8?B?QVFSWEV2UGN6Y1BUM2xEcWZoYWZpNjNwN1kyU2h2RHlIWFk2ZWdlcm9wZTho?=
 =?utf-8?Q?GCubmoSOH9c+QJ8jIinh1TDWOtw/DCOQpuG3LqwZyei97?=
X-MS-Exchange-AntiSpam-MessageData-1: 9HaX/FiE7jes5A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfe774e-aecf-4169-b305-08de9c29e0e3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 02:34:43.5566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0zNyRmfdLt8Bpq8ZNurGEbPJsg8ihA1DQCSwgvPOZWxV2Jjv0zGr33Im0saAtywUoubFMOlGib+nGHtAfIqMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956
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

On Wed Apr 15, 2026 at 9:02 AM JST, Joel Fernandes wrote:
>
>
>> On Apr 14, 2026, at 7:40=E2=80=AFPM, Timur Tabi <ttabi@nvidia.com> wrote=
:
>>=20
>> =EF=BB=BFOn Tue, 2026-04-14 at 20:54 +0900, Eliot Courtney wrote:
>>> Currently, these are silently overwritten. Instead, error if they appea=
r
>>> twice in the VBIOS.
>>=20
>> How do you know that there can only be one PCI-AT image or no more than =
2 FWSEC images?
>
> Also, which GPU is this extra PCI-AT observed on? When I wrote all this c=
ode, it was on GA102 and there was only one PCI-AT and 2 FWSEC.

I think that it doesn't make sense for there to be more than one PCI-AT
image. I haven't observed any, it's just that the current code will
silently accept it. I think that we should explicitly define the
behaviour here - erroring seems the most conservative to me, but other
behaviours could be take the first or take the last.

This is more of a problem for FWSEC images, because the current code
will take the first image as `first_fwsec_image` and the last image as
`second_fwsec_image`, which means that if there are more than two, the
falcon data offset will actually point to the wrong thing, since the
code assumes that first and second fwsec image are contiguous for the
purposes of the offset pointer space.

AFAICT, nouveau and openrm take the first PCI-AT and FWSEC images, but
they use the first FWSEC image to adjust the offset and then just
address directly into the whole VBIOS based on that. To match that
behaviour I can update this this patch to change the nova behaviour to
match - i.e. take first two FWSEC and first PCI-AT, instead of the
current behaviour which is last PCI-AT and first+last FWSEC.

N.B. that the current code partially assumes that there are only two
FWSEC images because it requires the falcon data pointer to be in the
first or second one, and errors if it's after that.

WDYT?
