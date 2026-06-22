Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825CECDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7EEF10E4DA;
	Mon, 22 Jun 2026 07:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bbct5gr3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013065.outbound.protection.outlook.com
 [40.93.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD7C10E4CA;
 Mon, 22 Jun 2026 07:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1I5bKG0B3BWYim8188Ee2Y5HQjFqHyxCTF3ous36XACTSzfuEyzuwm8AUkECua7KDFOWIHZLrFevws44hedFI4pSj3bxor2ueNQBimlIdguiFBgUaX7gGSIYO/Dr4uycexKSc2KhTnpzTYng7gcj6b3q8U9GhKrMfDNjdW/Npq+dX5/IlvIRL/Wak86zTAyjiQMEWW1EJaah2vzsng4aiQTeuP/8R0vOKz/jmrJFoQUOXB+AEjnVQQhc6lNomm0+/79A77ZAEJ6EE8myL7daJPv4+H0CpyXMiM4ijHQjSBHQqh5f8Azz8PxSL/p5IiB65RZIeWnxe7px0S56Ph4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dDA1KHVXTtzTRJyJvBaV1eVKidSJpU5jPah7Ua0RwY=;
 b=CtZ2Wvxdajun2k4jN6WhUaQCCHwSXMESx4wEUJ4jxyqd11oLgThdA7NG8d9XePKWZmPDRpF9P+uZUBFoxAf2VYtF1esJjv3RwVHriF8rgnuOS7Vk4ngR9hn3ZQLDrMytd27CLZVS38lUv6WTPn1gayv92Nmk+wJfVX5+0rI/SlQstAuNU7s7eJGD17eQJc27rqgbOymbdGlj6ZOq2MwBJVDOX3xrT+Dlja9e7/dtgm3IHBCbDLmSBvGh1rzGLy/En+LcMisLSjJdLTyPwW7XETehToGOcrhd5clW09EFwNaBep4/l6M6IKxHJ8vMuJjeetcUS3XkKc7xue9DSmHk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dDA1KHVXTtzTRJyJvBaV1eVKidSJpU5jPah7Ua0RwY=;
 b=bbct5gr3wPvwkslqE/Ft4oNBbJ7g29y8jLlFR4avAt9uzCIkzMfcIbbZxN1uzu4Pw0ITr68SnIoJtrdwG/E37IfO6H6GkHoSfKUbPhvs/QRDzNw/2abWTvfgvigexjpAf+BgIEM225Iy5mMI/e914v4lsKdTDIEnkC+o+s5pNs+HX9XrpZkeVCq+cK7qgkUf1R5La3kjljrh/e2bBPc2YQIiTMVKZNGnv7GmQrGKMn5AaYnDX/QDNXbTJRmlN68aJ1nutBTsUsIet1+2kZ+8gzjqOszylFbg7oyM00nP+bBrI9IYQ25BSmtqpazzAfnszhDqxVl04E6VU1OSu6+5uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 07:00:52 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:00:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 16:00:48 +0900
Message-Id: <DJFDUT9699E0.2N0MR3PDR1KNF@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/6] gpu: nova-core: gsp: sequencer: do not store
 sequence into GspSequencer
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
 <20260619-nova-bootcontext-v1-2-45193cd0a2e5@nvidia.com>
In-Reply-To: <20260619-nova-bootcontext-v1-2-45193cd0a2e5@nvidia.com>
X-ClientProxiedBy: TYCP286CA0140.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::14) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 04df776f-a917-4a17-3029-08ded02bff3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: vTfFSwPSygJ4/U27bShObMWOsT0ZlH9GpoizF3hOZJ/ZapPOZKgJVpYrFcd6L7JJjo8LJ9fpcFW5p9HRr3WK4jrwa4FR8mWKxMATSpzx/1Ls50jGQaLKz97uVnLKpZYL4jWLFk+vyMJBPeEdWxr3htA4wwPC88JArZg1T/lPheULIbk2T27uId/cwO+Logw9UQYJTw/tuGiDJKX0zBPP4Y778Cjm/Y9x0Pbq3sFHD4uDuABdz54ZGznOHoSFpfJE+BXs4UqN1R0TwyWO0NBcTZGQp5ngUJdtkpxSQFGsLviKMNfA/jzHAwVuOJCz1EWr4E4G7A9zeUSDsZYVEN4hQ94EsoxTHsDR8IMQXmKR2X+lZ8sFpw6vIB+Vysa79hEmv8lHoYc2z85H3o+EE6aSqDz62NjIM55jWVRByHm98t3tW7W7qd3OaWw5y5QCnFmb+Og+TlrfuP47/kcEjDh0sXp7KrhMgibEmD0fDpr92JlEDQGOww6YsYXt2e+kMX+tZws3QcwDBAH+icgcFMINntCE/MHgYSegRuBsjfUqi9VEMJtUNoI29rwNmkxnfreP/WxQvRkNUwsz0jZ0RaTFdtXHoIfXGoEpgoXxVW16NwQaFBA+0r6C2Z86S9mC+4NtkgHcqaY7q19iy4+MCMf+IFQswdGlWY0mS4ezivgultA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1d3ZDlhOVF6Szl6a2xUeC80clFRVjNZR0VEZGZNZHQ3Uzd4RE04cXRjeVhR?=
 =?utf-8?B?OTR3OE45ajQ2T0JYWEplR1dYN0dhNTFDM1V6NXJQOFdzY0VqVjMwMStFVnJQ?=
 =?utf-8?B?M0VrczNUcG5YSEI3ZXQxZlNLdnh5a0xxWHdJUCtNNTNNY010YmFaMmt3MTk2?=
 =?utf-8?B?cUUvQXhubWJmd3NEQUNBUUVDY0JZYzZoNjVqZDVldFkyQVlpTEVzSy9OdDZy?=
 =?utf-8?B?dlo4UkdqU0szc3RqMUxOTXJtLzFjbjlWUVM4OHd0UmJzSG9MZWhoWHVjKzRw?=
 =?utf-8?B?OCtseW5oWmZ3MUk2NU15MjlMaGJYMUZsNEw1aWVsdFJLYkJKVm91cXpiaitP?=
 =?utf-8?B?YXBUSE5xdXFIV2JETFM3cXZwdHBKV3VrWXovejB0QnZYNERDajVKVDcyaXJt?=
 =?utf-8?B?WE4zQzc4UlJ1bzEvemRwOXpDWnZnRzNOUHhRZkJ1WERnUFZ4bm4yY2luMElU?=
 =?utf-8?B?YVEwek05UTU2eFYyeUJ0cExxUitkb0lHV1oydWlFQWZtQ2lHcmVpR0Y2MFZT?=
 =?utf-8?B?R0xIMWl1Y1B4SUZTTlliNzQ5R2h4ZHFMOXJDZ1BnazF1NDNhbllDbTdJUE0r?=
 =?utf-8?B?RmNVS3FlWDg3WVJOcUlNQVhvYzg3UktZUGI4UTFhbVFzVWozNjlNOW1icEQv?=
 =?utf-8?B?MzRNNDlKeUZnbWZGUSthTDdDM2xvRVNJak0rcDN1ei84TWw2R2RwWmpvdVRq?=
 =?utf-8?B?Zmp0OFJUMmVyQVMyajlTTW1sVnJreGY3WW9nSEZpNVRnZmladElKYVJ5dzNV?=
 =?utf-8?B?OEd0R3drMytoeElKYW9LVlROYXY3TmdybXNuWE9KRWZ4WEduZlgrY1ZKRmg2?=
 =?utf-8?B?eTNOMms0d2V5eWE4dTArZTNNOUpqTFVxcmh4NkNCb1BnZUsxTjhDcDRaYnpW?=
 =?utf-8?B?QUpxZTZoSkcxZTZ5TmV6bGFUSThFQ2NKOWR1SERINkxoQnlHWDd4SG00UkI5?=
 =?utf-8?B?WHlpNkVTQlVkL2h3K3JtMVZ1UXJ5TjBsRFlLaXUwWjFETnhGdXhzcW10WS9h?=
 =?utf-8?B?QUp2YXZLMDYycVpRQkZxcGc1NldSWkg0MlNLRHdZbE5SRlRxWkVoc0Y2akx0?=
 =?utf-8?B?R1EwSHlvMWw0dlBwcWFuQ0hxR0Flc0FhNVBORTRCUDlEcDZSek1zRlUrUkFq?=
 =?utf-8?B?bmlvbDdDWTdmSDF1dkNkeVI0THN2Rm43bTZjZ1Qxek9lMUFkK2dqTXZsOTZ3?=
 =?utf-8?B?WmN2TytiVUFURDl1VWNoWHZ4VTE3RWxDMVdkNDZZL2d5dHJhY2UremJsSkVK?=
 =?utf-8?B?bEpnNEhpUm5DbGNzWkp1NDBuL3M1QlBhQ3NXbitkRHBlTHp2VVpoY3BXKzdp?=
 =?utf-8?B?eDJCVnJKQ1Fac2J6QkJaYXhpaUFUSjNtemJGQ3BHeHgxd3JlVUUyY2lYTGZS?=
 =?utf-8?B?eFFYeVMxNXdVREJxZTNzR1ZCbjNaL3JHbGphL296b1d5dWo4UGtaMWpkZlZm?=
 =?utf-8?B?V2tFaExJZ2lYVXhnQzJwTUt0TFlZNTM5MnNxaU1qcng0bEp5Njltc29VK2Na?=
 =?utf-8?B?MHFITGdXbkxPSGVRZlZnOWdUWjU5ekg5YUFEVnNuc1RDb2lWazdTRTd0ejBD?=
 =?utf-8?B?eVNTYU1uZ3Q2M0plTk1lajVEVnlXMkdlM1VVeGVpb1B1ekRWNVlyNzJ4djN4?=
 =?utf-8?B?cTA0ZlJOYVBKS3BVVk1KaEduM1dhdXNIYkJpR0dGSlFURXVqSFJOMmlZMk95?=
 =?utf-8?B?ZTU1VHFrWWFWZ0xxVnJwRW80Rks5TUFORjdFc0xrUjc5a3JlcHl0TXZoNFhq?=
 =?utf-8?B?WnhrVDlvaUdPVEorZEFEbithODRDbFBjcnJmNkxWWFJreElmV2s4SnJsbUhZ?=
 =?utf-8?B?UGxpaFZJdkhUQzR2cmNoRlNhOTUrcmJkQ1VKRGhUQXR4MG1YaDR1SlNJSjgy?=
 =?utf-8?B?dGNYamlSWEw2d1U4bFZqTUcyM2YzTTJqRzNFeWFLeFlSNWYyOG4zV2x6aUNo?=
 =?utf-8?B?Q2kwZlhsT3NWakx0QkZ0N2l1djBRbmJLTUc3cURHNXpITmhCQ0s4RVBnZUxk?=
 =?utf-8?B?dGVrdlU1TFVNVisyamd4RGpJWFNsbGhFTzlIUFV1aDdLQWdSTFovQnQ0azFV?=
 =?utf-8?B?SGZNNGlyUGZyS3lTdzJ0RXNHdHlETjJSTElaeEwrTXJnMFQ2bmowTzdWcEZE?=
 =?utf-8?B?WGhVNlErRzZHVVN2bDBXc1FMMWVsQlN5ajIyTDAydURFRnlPYjkyU2I2RWEz?=
 =?utf-8?B?Y2QyN2lManFpdXJHNWwxdlFvYmZwcENFRTB6dnJNTmVTek9oeEVWVGwzci8z?=
 =?utf-8?B?Q3dtUkZVSGVhWFlqb3VSVTdSd01SQjZ1YlAvd0dLVE81QzJXZmRtU0NXaEZW?=
 =?utf-8?B?YWRPeWQ4QkJITFE4Z01wa0s2enpzN2N2Rlo3NzI4Rmh2YURUeHUxeFFWaits?=
 =?utf-8?Q?vXPf/VJh0ZB3oYIs2br4L5PifUP5KiWKr427LwH3fDEpU?=
X-MS-Exchange-AntiSpam-MessageData-1: L1g2EY1qCujAAQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04df776f-a917-4a17-3029-08ded02bff3d
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:00:52.8128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWoAGFqcW+20602AlsBFGohsZW4HOt2BRCdn4yddpOLdWm4GzMtu1jv/clSdZ+XrIi8V1t16t25BSWNv3pDvag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
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

On Fri Jun 19, 2026 at 10:42 PM JST, Alexandre Courbot wrote:
> The sequence is currently stored in the `GspSequencer` even though its
> lifetime is limited to `GspSequencer::run`. This object-oriented design
> does not play well with the borrow-checker, as `GspSequencer::iter`
> borrows a reference to the `GspSequencer`, which makes it difficult to
> introduce mutable references in `GspBootContext`, as we want to do in
> order to make the `Falcon` references mutable.
>
> Thus, store the sequence locally in `GspSequencer::run`, and move
> iterator creation to `GspSeqIter::new` so it no longer needs to borrow
> the whole `GspSequencer`.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
