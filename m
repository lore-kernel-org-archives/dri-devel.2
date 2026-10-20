Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E63606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GOdFDN17
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 347C110E1D4;
	Tue, 20 Oct 2026 11:43:26 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A573010E1D4;
 Tue, 20 Oct 2026 11:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYOhZVXRr+PHlYSQ98drHLw7IY1SA1/kT/WNRXkReXudztfItmisxfOOV67rGJJ3GlBPh2Htkv4JONLv/xgscbyj2zLEHp8AB+Nuvzbt1JfxIuzsCqBzgc0UrmqWEtl+8AZz7kGt+4Y+9T5t4KBE7moGaV+xy5XLHXN4VnxVUC3sf/VSf3V0GUd+/s3iNCQur4UekbQOfLtKAS5Rf8EskcgowE8gKCq7hj+ymdcty6+IWqjZ5pu/tUNeGiGJDHRNEeWh73FKFMD6RNUlXhlziHLjpw4wHkTLBO9DGtSpeZjgDUL8JdClz1b4pUi/U6PH9jwS6ao3AoBw9d4+Nz7c6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yr/5iHM2S2EmucT0cSWkPrWt6xwNrbKO8Qs7s9cHww=;
 b=nJYtfDfj5lzq/CfF5iwHOJKhFgbof07But40kPTmdo1a4gGTxI9DlnJ0Y8H4ax2T6EsJa7m3z2Dxoq1ztdff8pzU8d4xQsyvniadZmu9RIzL6xLs+KReBqplLuSo6U8SJ/PqDQ9MWGDR17XfX6iSMFm9P0tHBIoVpv/r7tCTh3d7mnQGovynEdV72jDNcLcZWH4cRLj2BHxpvLXQmteBKXBooODaQq8n1SDR/Sfqwolwe53tM2sbieWw2+JykGB28I0a2sbmGIq+IEN7s8J2uYBufOq7fC4yv9vbN8FuoMPpUGu9ZjwUM4NkpOvo+IGTliGxKcNZ+VYYt4Qm3p7tSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yr/5iHM2S2EmucT0cSWkPrWt6xwNrbKO8Qs7s9cHww=;
 b=GOdFDN17Kz2Jpp1jJqHT0GnBAqh0MiWe3kgNf/Wa+E66rpYmG2+TsQvMkmG9hIqQZq0Cn0KVupYQ51jwnBYrvbuYjwNdq1St9sfqCyghXAhDxNopwgRUH4FXMkFsLxJCsfxlXPboRNbBD9VW4dUptzvruToH3LZzcqJGuW5nnJhchwI3spa+R5ROjgzkTLmpdgktZKOjNzhYW2ydOaCXDSSq2Rsfww+rBagliTkBbvlFZfYIhkluqr2A4CGQ4Ogub07y2wrxmRv9koI0jd260wNJXtxeTWrvOsp6stQaUNJ5B46ZHPeH/gotDpwoa0PJOfzgKuIjkiRyKIaLu1Jxrg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 11:43:14 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 11:43:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 20:43:05 +0900
Message-Id: <DM9N0B96OZBI.23VE69RL54O19@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 01/14] gpu: nova-core: gsp: cmdq: remove stale comment
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-1-dceeb8f360ec@nvidia.com>
In-Reply-To: <20261020-cmdq-rpc-v5-1-dceeb8f360ec@nvidia.com>
X-ClientProxiedBy: TY6P301CA0001.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6846a0-053b-4004-25b1-08df2e9f5271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|1800799024|366016|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9nkCTqMIQ125ASdEWZHCXR7++8mdrMmfrNZyGnGD22/bBc5yV+g5xgfqTXrM0qlXJPS9V8jDaN3SlVUn2OO3ZE/Lw+5Pw17HqufRC5QVFmVOcQmlP0oHHeEs9HJiVioBCiYkLBX+TRWKWiZ6PgwxMRq+smSo0yfvvFh5t2khEQnRJ6AAVEG9z5jX9C2y3wk6rp8yAMPe6RzX/vQoMyl1dcleZSyf3Dx9rJ6D/ROODHJOKEfjO4naBcGgVIH+/Vj2ciHzV+RwqNxTTLNH4utwtIUc09/fWb5NbiU2jERjbfY24s/feILymItYgTH16CG9zLX+g9maAuAqn4tnKXop7s++V+JFy5PmvLEjSGigNOOcbnBw6w6SFpwepEcwqsudDbKI4gjJqBsK7M5YYU6Y7rE1LjQCWBoCueDXejzp5tWYe1swaOcleqccm/K7ueOhhPEN/uPO72dbIX0ZxxZKz49rKOZzWYCNODeOOulxazi2WdQt/yaOfUhw3WiF5Q97SJmGjSQ5YDxFTsBpt1IEAR0GTLvrMkG9rKEFU8inRhL8+dEZehrRM8rja0UWSH7+/t3qSZVlWRlc/bCWyCR127UlHw3VkEznW5AuvO55fSMiW4vY638FmG7pG/Pe3TJRjbCxQFDYO6YuBP/6WG424yA5JjNkhPbSgqnaOh6ADpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TndIT2pKTDI1aEFVSFlZNDB0QW5kMyttL2dNS3h4Y2FQMUtmV0I0OG81dHVa?=
 =?utf-8?B?T0hONE5ScE1paUFWQzF0SzFRUWNhbm1hLys4WnNJcVdiU1VONWVwZGpQM0FL?=
 =?utf-8?B?Q0ZpR1pMb3JnOUNhN2VvbW9xVWVYdVhIVTBCWkM1SlZuNHpyRk5EcXpobnFj?=
 =?utf-8?B?MVlHbjdGa1ZCRnpLTEtiaUJXSHFoaUwzVTdSOG5Pc2h5UHN2R28xbjJRekN0?=
 =?utf-8?B?NmZCMGhhcU9nSUgvUTR4c05FRnV6Sk1ucGtqeldnZjRwSEV0QmhkQTFtSE5L?=
 =?utf-8?B?c1A4UGd3YmUrYkFUSWpwSno4dDdQR1NTYVFGOUZCb0pCTXRnV3oyN2ROM3gy?=
 =?utf-8?B?Y1dEQVdjM2xERVNwT2o0bTI3QkhrMXlqV1ovTktvWW11SkZVay95bldrdnJy?=
 =?utf-8?B?L1pRamQ4Z1FINTFCdUk1WEE0VzVMclZnNnZ0RWhvSnZ2aU14Y3ErK0VOK2ty?=
 =?utf-8?B?NEx0MzVVRWowYUNyY1RxOENhSGluNmJmT25reW92UFJ2LzZ4R09XK2FocHJi?=
 =?utf-8?B?L3UrbGx3Q2drQzBVMzJjbnJ6K0d4eUxvSGR4UWs2QTNKUDVJd2NXQlBkYVZ0?=
 =?utf-8?B?cTV0WElpeHF2M3o2SEErMXFxUjVuVDVsTTZKVzVZTHIzQnZwNDR1cFRzc2Nw?=
 =?utf-8?B?RlBNQUgrRHA3VXdidCtzYys5TWwwbk5lZmRQNVpZYWdHU2RDVWNiSFRCQXBh?=
 =?utf-8?B?ZEZHL2NwWG43a3crd0htSy9vZCs5aVpoK2VPT2VDRzBGSTFKZDUxM1ZEakpP?=
 =?utf-8?B?aVMxMWFVOXM2Mmc0WG16WkZjZVE2c01Ha0JrWXgrL3c0bXdEWFVrVzI0bU41?=
 =?utf-8?B?OVhWeStmOFh6UVBUQTk4eWRpRlZ3RG9Od2VZNGQyS2VIR3hXeGJTeVBVZDIz?=
 =?utf-8?B?VnVuWDErUndTTjI0ZzUxeW40b1JYWW9ZbVVHY1EvT0MzeURBVXRTbXpxQlQ1?=
 =?utf-8?B?aHdKeDluWDF6QVhGTkhpeDhoTFdWL0ZuRHk4Vi9GSDh5bmVFdGQvM1ZCRVZ0?=
 =?utf-8?B?L0JPaFdhbU8vMFFOOGl2TTlHK1BVaVBqdVp4V1RTMnBEVEc5UVFzUWN3NHo1?=
 =?utf-8?B?MUorbExibEJGWnZaY2d2ZVUvcXRPWFlSbTByQVZtL1FXdmFjK1BiZ0JnWU8y?=
 =?utf-8?B?M0ZGYlhkYkJQOC9LbVF5OGpnMGh4OTZKN0lmRnAxTEYyQVJvR1p4c0FNeDVw?=
 =?utf-8?B?NWlwSy9ZbkhERWx3YWR3K0krSG91SUpOVnphQ3J4S0gxT2ZDd0NBSlFjcmR1?=
 =?utf-8?B?WDJxblNpNktwdG1qNkROeWR0WTUvdGxacnpsbG4zSnJiTzU4WnFiQmdYeHg1?=
 =?utf-8?B?RVlaaTZoWGpMaTlqZHhzYytRbjFWRW1wUW5IdEFNNUxJUzJOdDNSNVVNMzZC?=
 =?utf-8?B?RC9tLy9yOHUrRHgyVlRqbUxIdlZKV1djSnNQVnNsR1RPVlRZakIvTjVEVm9n?=
 =?utf-8?B?N2VRV3BhYzUwKzcybVlOY3puZnJIYjJndEZUQVlIaUZ4aSt2NW5QM1RCS2dq?=
 =?utf-8?B?NEErVENJZzU3NUk4TEFTaytSdkFGYmV1aTdlaGs0OXNzMWc4NGxXSVNRRVlN?=
 =?utf-8?B?NTN4QzcwcE5XRHdNL3lPTXg3TjFiVEY3K1lYbnhlbk13NmtGUHZydzZ3RUEx?=
 =?utf-8?B?YSszeWdSL2UvdmpCQ0E4Y0lwOENOckhGSDhMTnd4UUVaWnpYSzgzQldWeTZG?=
 =?utf-8?B?N1Z0cU5aMUlzTTExT0dndjlaYnJXZjlNWkRnK3VxK09iQUNtSVNFaldwTzFI?=
 =?utf-8?B?cG5KNktGZGNiU2J5L2doOWNBb3YxUGVoRUJjaTR1c24vVThUT04vcis2ZSs2?=
 =?utf-8?B?bnlaV1ZtbU1ZM1AyTkRwcFJEZTRqRVVFT1R4Q082SmdiT0c4cTNyV0Z3elQ1?=
 =?utf-8?B?aUxhNkE3UVBSMjljRWh3UTcvdWNUZ3ZnazNUaUUvVXRSVkVlWXR6eVZCdFov?=
 =?utf-8?B?YXJHd1kvdnNQZjFXeGdjTVZGNzhTMGIzVythOGlVTUxYUXdzcnRqNkVSdUR4?=
 =?utf-8?B?Nmdpb1g0QWVJRndYRVhLa3YrVGUrVXdQOFUzOHBNeUppL3cxRUdZZ0UvN0VS?=
 =?utf-8?B?bm5rVFgzVDRRcCtiSGxkZzJLclB0bFM0dXlEUGhzU1UwWFRieWNPVDVta0tl?=
 =?utf-8?B?V012YkxqeUtCMzlNMDdaZHJXaDg3cFdpTm40Vk52TldKaWpBQ1VGREZVRWM3?=
 =?utf-8?B?Z2VtejJ3Mm9mV1BheDhxekpweThnYndKR3RxN0xVdWNFZDVBc0hMQVR3cnpB?=
 =?utf-8?B?aWNvZlpxMjFPbUQya3VIV2N6S3A5VTZkTlZIaWhhMnNjVmtYTWdvVlZiRmdl?=
 =?utf-8?B?KzJkWlQrbGl0Mjc0RlBFR0duQ3pJaWVMSlA4ZWNEbEtQUFZiZ2k5S1cybGRv?=
 =?utf-8?Q?EfJv6yWxMmIrFPiI77vTCbVzBMYZO6JgQVFN31vIOz6ZF?=
X-MS-Exchange-AntiSpam-MessageData-1: vNwJaK0hwhuZEA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6846a0-053b-4004-25b1-08df2e9f5271
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:43:12.9188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40Kr7f43soWCsXKq92z+kjgACQT+3SYVsk6+yTPI4iCF4/JSK8LPOKgWEgWfh1/WnMMZUcD5tNgfFoZKtrOUHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 20, 2026 at 7:08 PM JST, Alexandre Courbot wrote:
> The message constructor is no longer run by `wait_for_msg`.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
