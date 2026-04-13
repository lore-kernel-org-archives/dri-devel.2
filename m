Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AF4E9380A
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 02:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA6510E2D7;
	Mon, 13 Apr 2026 02:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="c6jMnIY/";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3141410E2D7
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 02:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSUiWVDpHsqEGfOZ7+PaMGjfijRUiAHOdvFq0DGJ35AZhuZ1jLmBSJ8uBaAg18U2awGGv3yF7kSBmCtwZMwAV/Do+wQxZwVauh++NRSUbODB+roCJY+7Nnp2t0pXYL3/u+iBTLr817YfirUezWyFQBzKQfcpfnB9T1Falk9iMJVqnXdSN0XJlmqeEm1mjn3SGnK64GtKVKytGAIcqaNT+vgTIqw0MaCz1IokgFK744HbP07iyp6jtbXfPERGbqmgZCTAP9GQIWdTB6+e2IGBtnkYdzIzQvZOIq171LuvqlJ6jiiRL0tnNM1AbYvMuddnHXCObMCaJ/ymm3gsF4ByRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVecH0vUjB1BkkDR1lwFNG+mEtjlpaxW08KtX5NF3eo=;
 b=PoFIP09Y4C8Ho5NBmebJ5BelIwXUD90DU1Nk69HbFt+t8MnEABfmibn9TxHZY+jm2Yd+9kXQZ2eQZLISH0l3TEe/bE+7KdB22nw0r3cEQuAstoVT7yrwYZwMCRXFSb67PBFUAa9QYk9oVFxMcQaNaVbU7GU/B5/vN3hQvDS8DNAYjxANgyYgD0MltmjffGU0Gfy/vC9Wq7zFXPf8YAGuUL6NTrQpW1z8x9FWTIxmIkNf1BviIyQJEZ9cD6luU3Ivi9vvh0wMSN5pQo0nou6qCzgHbgz+AnAUT/+zHVq0561qERRFnk0U8s21HiE94P/wEc39GfFx8k79VFQu/NkJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVecH0vUjB1BkkDR1lwFNG+mEtjlpaxW08KtX5NF3eo=;
 b=c6jMnIY/j38zV0jUCr7BLDe3tAJqYR0KXH0C6jOPmBG91j0arW+QRw1zJKKiDVuETjKVZfgkrrsE5+0FgdYwcDySLIIRAHHjWyWqODzvfhn9A4yFSqdHd64olq2aw0kvHKaKOtoCHdjTMc3Hd/eNsaE4lLy+dQcyvSsPJhP2slANmPCVIMrWHkYKDVECPQxfSEZGg+8D40V6TFP9CMMG7IiYmMWcIqd0/X2UX0dfk+E+YHJIZJ9R90dxuZyRkqoSbIShEgjJFpzM7q9VXnG0CmkV6IeBRlXHf73WXRqi6zwT7jz4kB+YvXV3UiLR9hTLU1UzSzhssBHMzmmAjW5Ggg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 02:01:28 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 02:01:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 11:01:21 +0900
Message-Id: <DHRNNEJT7GGX.3JDC10C5WIGTP@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/3] gpu: nova-core: switch to kernel bitfield macro
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <20260409-bitfield-v2-3-23ac400071cb@nvidia.com>
In-Reply-To: <20260409-bitfield-v2-3-23ac400071cb@nvidia.com>
X-ClientProxiedBy: DUZPR01CA0116.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 031844d8-a4ab-4992-4c26-08de9900929a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rYG2xAG0iKWdZKQO2RVXuTyXJGJ13ROAUaPSo4X7kAzP3TNJsqggclv0DYpQFlU4hWjyVvCU1ohkAOgc6WLNTrvnMtzoGe4tFt1nLxv8vO9QEEI5235IcANDE/g36pUVtus5j+F4M0Lj9OWsBwByicuZHAU1fX8UVG5pHjgYgU65kcyFvQEdfHFll4f+jrS+M9/ZuUG8XANJwzH2MLKIEMMLEliMJngB6+m8KR0N/hHIlXuVbfkLKCGULjo9RVrj4ULrcr12GTDwvgU3TuhkkTr/h1gls/NK7TyVJTBI+TbTeW5qMwWETZXRORFw+cDzuHcC5/2auSEhmZmLrPNMSJUmnBDq8+BLteK5wUrhzibs8h86Z8SiWyc1Znvt9+OILjt5ts4/UazSXiOCIlDyQYB4bntioFDlstxk+4B/c/U1KR40DXpHpyXTx0ZtkBAYGZKsg3G0sj8wkDtEuJFdJn0RZJ8bce2y5x6kBhJjE6IIGz4WO1ZpPrBDx3Ed4UCOd/wQjA2y3GykcUVU3HHhK3MvbgEowhNIaduG2TQMxdvFj19Sme8j2QSbBGy6rN2Mlsm93zBSoKrRtbLDe5CpKgMg7zt43B/cA3bvIIgmMb1Od1teFf/3c5kLRmPq1iU+A9S4cOYA2iwlOVtHoRFfry2/OFGFJhOzx/KqJ3MzWj0n76CQTsLIpGl1tGT8PqX4ynPQbPQWB1ldpM8xfCZYCAHXDkdqJWHzqpVmjWYo7OLepDdGk+/ciHKyOzoANuNXDtXvAPcTDg5UTcdLABBg9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUp6OHB1OHJrdlhSSEwrRUhTNW1aaUNUaFVrSkdYSXh3L1pUK3M4NHhxRFY2?=
 =?utf-8?B?SFlSMHVxQkNoWmFJNmJ3eDdHSXhLY29aTitlYjF2QXRTOW96RHY1YzhUQ0Ez?=
 =?utf-8?B?TllBY1BSVXdnOHpOdlQ0bytUT1I5OWRRZFZPWUhnSUcrVG0vK25UeGgxcG80?=
 =?utf-8?B?K0ZTaFl3cmJiWnhxSU42bTVmdGx5TkFHb2tQbGZYeFNFaGgzVEtJREhMc3pr?=
 =?utf-8?B?UzkrdnE3K2NiaWlPZnRxY2FYaDFFUFVUb2FuaWFXdGJIWG82SzV1OWdoNkZq?=
 =?utf-8?B?czhwTm9IWllQbHFRQStxdkJFZGtyREloSll3U0NNUTQvUHpqZ0JTaEJDM1A4?=
 =?utf-8?B?SUZxUm8rM0FvOGlLdFFwY094b2cyZXVHemZQcnQwOGFoWkZHNEw3SFJjOE00?=
 =?utf-8?B?Tzk0a1lJYjIzWmhQcTlrM3BGd0RTQ3dOM2U5U2VMZlg4cXJBVTVMeEFXOFp0?=
 =?utf-8?B?WFhISjBRNGhLcnYxWFBRb0taekNWQnh4WFY3SStISGlPbno3d2NqTHRKU1RX?=
 =?utf-8?B?VTRCN0g2SGRiVWt6b3NpWlAzL1ZkSGsvekpxc2lSenRkUlBrWGptVE0wRFhH?=
 =?utf-8?B?dmFwOEliMThIVEZqMFgxa2ZmWTNBN3I3NmpoR3NHSms0enFiSk5VUEJJSXRy?=
 =?utf-8?B?Mk4xalN4WTlDTVM0NnVRaW96bkEwamhXeno4UjRTNVdzWEhleGJKZkNuUldh?=
 =?utf-8?B?N2FCWkN4M0p3VDRTTi9YM0JhK1lFR296eDR6QmgySC9KMjlBZ29CWGRmbWN6?=
 =?utf-8?B?YW1pcjdvL2w0N29QUkRFRmE4aE9XeUNlTHlQa0hSbEh6UVkyWDdLU0NhRmlN?=
 =?utf-8?B?c2JqdWVFWHB2RU84ZDMvRGg0a25qMDBSVUM0ZlBQNXduTGVpU3VtNG04ZzZ2?=
 =?utf-8?B?OE4wa1BMTVNrd0UxbE1mVWpJZUx2bXVVdmVaTlhrbS9nSUFkOTlxUTVsL2Qz?=
 =?utf-8?B?bDlvK0VoOWVMUGdZOXZTSFpxeitHR2YzeGkrSERwY1l6ZW5CN0JTTzlQRU4x?=
 =?utf-8?B?SUM1UFlKMkNNQUp2QUtMeFJOL3lHcFYrYnpSS0ZoNGYzQ2FDdlRBRjBFVXp3?=
 =?utf-8?B?MmpPVkp1VDcvc2lBTzhYUTdhcmdTSlQrM0cxVExKNEEwRTkzWVdZbnpTazVQ?=
 =?utf-8?B?RHRETTBxWXI2cG5EaFBwRWZEdngvV0k0TzNONjU1WExFSXZGYklXZkduN0tX?=
 =?utf-8?B?dmlaR09rNWJrNTMxcE5xZGNuVTF6N2F1alFIT3VFNXhmMmNBTE9tK0J0TWh2?=
 =?utf-8?B?STluM3ZCS1BRRFRLdng2YXRzdGN1Wm1jaHhJN0JQQ1ppWEVCTGtib1lGb2pC?=
 =?utf-8?B?d21DcmZFaTdKcFRFSS8ydmxPSEZCUzlPaDM5VUVRUnc4bjdyak11ZkQ0S0pk?=
 =?utf-8?B?Q2hTaXNrakhBckE4ZlQxdEU5S0pSZTc4UDBPOGtaS1c3dUo1V0c3dkg3bVRV?=
 =?utf-8?B?SkhVQy9rdFpLVEJ0cmRxSm5iazFmZkhtR3UvMjFiSGRSMUgvVE5xWmkvYlp0?=
 =?utf-8?B?TGVwS1hBWDYwUVlXUlg2bTBlL29Mc2RmVkNGdDkwY3JwYVlQOGl5bVZEbG80?=
 =?utf-8?B?cjFCRjBjSHZWL3pJVkhvWTEwdHNBaFNVc0w2L0hHTjl2cTVzRGduaUVOUnNE?=
 =?utf-8?B?TVJUSk9mNnhCcGpoY25tbXNZOXhoTENKdy8yVytTRXR6V0srK0tOVzNGQnJo?=
 =?utf-8?B?emdvbmxzbXRXNllBbTB0QllOZXRJZXlPT0lVRHQwSkwzU081K2QrdnFNNDc0?=
 =?utf-8?B?S0dOaU5sVng0OTZTTWZiS1dVVmVYT1FhWkptbE5iUjhYUEFOTXpEUGxnMzVo?=
 =?utf-8?B?WFBwSy9vbVlyb1Z0dmN0V3RwOGRJMnJ4dGxOZUVHeEZ5Zll3eDJRWFdKdE53?=
 =?utf-8?B?SGhTQkVWQWljdDJEcGtyMlR1UEhQMW10YUprS3k1VlJHcXJodk5kbDAxQTVr?=
 =?utf-8?B?R2s5NGtxblhFbHlialhrZzVNTjFmUzkwT25ibGtPKzJuVTZ3V2phZmZGV3FD?=
 =?utf-8?B?ME9MUm50SXhsZlorRTlia041SW5ZWVRhMkhZMWdPeVpiVTFNZjg3Y1d3ZjYr?=
 =?utf-8?B?aGR2U2l6MlJGbEQ2WHRyM1l6eXlWTUc2b2FmTndlOXdjMExaT0tNTkhXMHFG?=
 =?utf-8?B?WCtoZ3hsNC9YbDFGaXNOVkxsL0JMR1gzcXBwVnhkVTVhWElNY05HK1QycllS?=
 =?utf-8?B?MGJmSWhtdUpOTC9hc1o2cHY0SnJ3R0prZ3gvSTZ6NVhOQ3YxWTArRCt3UFdK?=
 =?utf-8?B?eGpZUEI2UVhGOGtOeVl3V1RaNS9iOEI2S3hEbHRTOE1WRk9abWYzVEFJNjkv?=
 =?utf-8?B?cVNQUk5BZThVMFBqSmFHNG1oRnZVZXpHakkxcWlkWm5uV0tDNEdQRXpjNGFn?=
 =?utf-8?Q?kMH/+mVzXsDJl1RM29CPr4LLObzh3yqrf+6vdRsNBUDdh?=
X-MS-Exchange-AntiSpam-MessageData-1: o/mh7kKo5Tznqw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031844d8-a4ab-4992-4c26-08de9900929a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 02:01:27.7472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3BSK9jUl4ngpJma+E5RMyTKbFOniplns3a/pxgT65etmbRQ1brzVZnCZzNXogYCzo6fYDRopk1QYi0SqXN4gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
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

On Thu Apr 9, 2026 at 11:58 PM JST, Alexandre Courbot wrote:
> Replace uses of the Nova-internal `bitfield!` macro by the kernel one,
> and remove the now-unneeded local macro.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

