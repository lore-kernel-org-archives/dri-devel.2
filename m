Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D92CD6E52
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 01:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D994F1126B0;
	Sat, 30 May 2026 01:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="piMLl+Ly";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B2A71126B0;
 Sat, 30 May 2026 01:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5NUpbl/HBM2XJg2TP7hRmVtk8rVzFqN3eqR7addI25zup1R3olS+FGA3cqcAPf9XUeZJH5+kz2LSQd8Jzqwtb0dGW+qE8YKUW/n5qcc7IcZzMrawresgEMmd5hb3gE/LRnQdMun3vkWr/Gtq/+o+g2Iwqd5ke75AHGh8kwvQvWtVrNx3pmlj0CCuuvzvDnb0B4vIaI4xIpKnYgeNSrLJO1zhKeu5+gnYsC1Qxhe/99rv7Yz174npcEIw5qbbLMatftb3AiOWonHUF+apJmDkRz2RgnteVpx0MHWBgfj0ho71oUDrmY8uVvyI8V4aepv2Nc2fcIzDosXWvUk8TmopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dlb5zHH+Or5tjrxuYfzK38TEydIID0gz00ThkLzsYVc=;
 b=Ab5K57k8O+UiJ8/YVxpErROHwIsloCBOGhCinspVmKjFnO9siejTpD++i/F0DJI1gI/UupaixRW1uy9p4O1o/j55wnxpUvmXu/P83+VvtgBOXDw9bPwLzN19Tx6K1PJHZCsVlqOpbcCuefxINK85V6cloukf00QyZfkKxeIzDfK+OJI/uATdexdNKNTtf0MchstrbRfIju5bidTTgqFjdvbKKiaZ9sdvl60mv3c9O2ieUP25lBDEPFp06T0kWK1Gp1biYCLTfUBB+4IsPQnLByALSmfjySD1k1eKnPgDEoUQhE2oh5ZNUyr1SBY6BvLrqT8HFDLT6kfyaYKMvIOH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dlb5zHH+Or5tjrxuYfzK38TEydIID0gz00ThkLzsYVc=;
 b=piMLl+LyCCfI6OsNCExSZNYgBitQQjxRdQkb/zRkHFyJZ0hPZ6aWegivgvR6I4ZxqE+pHDLWRV9FITGoCKTbXOim+WGpayNTcjWV+pSSnHfDi/w4gcUZ6yy6vkWCngojPhORg91SXS+qGkoELU7DlfDtJ2hOV7e/5D/GRGgDtGS3Mql9w1nm/HV8JXidxIcNTS2mX4TGO5saGqDN2viDNNSuxIhUpvldocSgiFZJE0bvHGbwHbiRun7f48wVEh+dvmDXYcA0KmfR9B5HCbX93WkJj3AUAAy1EunjC2TwG3B7B0NBxYZYHJBOfaoMXtKMKM335eWwNsNOF3DceyyCWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BL4PR12MB9483.namprd12.prod.outlook.com (2603:10b6:208:590::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Sat, 30 May
 2026 01:46:25 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0071.011; Sat, 30 May 2026
 01:46:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 10:46:22 +0900
Message-Id: <DIVMRIYNDQ5H.3MG3GMWT3ZGRH@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v7 4/4] gpu: nova-core: gsp: run the unload bundle if
 Gsp::boot() fails
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
 <20260529-nova-unload-v7-4-678f39209e00@nvidia.com>
In-Reply-To: <20260529-nova-unload-v7-4-678f39209e00@nvidia.com>
X-ClientProxiedBy: DM6PR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:5:330::30) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BL4PR12MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: e61324b8-c918-4a4d-e5fa-08debded4212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: vZ9GLFI331e+UFhcokK5CYr+/WU0H0IRhia1Ny+cw9Duvfu7yl378Ps/tSKCbPNpdgRiNvKVXJwqc3XOUeUITqEjksaP/hIOiK0o4pwnLhDFZ1LCYQs/uuSraxehvIlKBq9kNzQSsbTxO9sLcz0NVBsZ2I6Jf2huzzJ2xTYR0svYVuZ3bDl0s5BkXCkK1GNTkYnTrxydDudHqmR9hXoLtP7+v8ukXqZpYG2ff85YXxuOv0ojIZTShqjkaV7g6ZUt9WEBpwzpsUPOr1rwrNuTtFvnqjFjAjk+gcZSYEGh5l5AmonDS6ogsGBW3ADYHxpeiLSZySkUH9+nwC9KIRF7p4t10n4ER44go35qd4nNwZAEir8JEiBfobUQtEPyFC76wtmOEUOwYVHnoyoDeXBc/Rt4UnxyrW9JxpPp0yryJqnEUYFd/MPNfxisFH0qK0xfhneOKnxvJ65f1vE+i4joLIgv80T8n3j4cZV5ESLfrU5rvY72sSkMgRtZ8AYGDOZUZ0xWdG0gn0Xls0BMTJKPXUATnUAg6SEqlIiJi3IhGrHJSUKpxattqxtwq/aSColZq8rto33T7gOtWn/t+Wk3By9stLnsUQhhuZp0DGe4CZzs5pMM4Xx9EJyJMgK0XocSmHcxlm1oBb+wQaTVsBxq5oWiN1xYASD4ppcTBYGq8pn2TBfqkEIPYx6HmCBsgrR0VIz8UzEn+BBwQ42mMD37Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDNRRUI0dEozM2gxTzNNZ1U4Y3RxSjl0R2s0aHlmcXlEQlkvQUxyYkJZNElv?=
 =?utf-8?B?a0xwSjJkVFBaQ01PMmlvcFNTL3hmVTZ6V2h1TFYxMXBrNFQ2aExKb0t3WVp0?=
 =?utf-8?B?QUt4THBEZW14aHJJZlA3WXpQWlFmR1JmMFBuVUQ3bXI1bU1yLy96NExKK0xK?=
 =?utf-8?B?YXR5YWx1a2JxNGFwL3lDNmNndEpxUG9ZM1dZNExEbjcvbThLYmpVeXZ6Z3Jv?=
 =?utf-8?B?aUErSjJSNThYNXJ6em1WM2pGTXZ5MVVPN2NxYkZFdlJwMkJmeU1nVDh6Nll6?=
 =?utf-8?B?T3dTa3YwYnlQNE1kQ2tMQUJTRkhmT2FXdGQxczdKa1lCQlRLa0puelI2bDlj?=
 =?utf-8?B?WllmR21vMStBcy82eE9GcWxaUXg1NEtkUGlVSVpqRGM2LzNzQStYcWVuUHNm?=
 =?utf-8?B?NzBhWjJTd1VmQkRsdkZPK1pjQnBuTUNVZ1VrTzg2N3NyTEJNd2dnS0xEQUVZ?=
 =?utf-8?B?eFJLZXJEeklvWnRSM2lvdUxubFA3WGwyN3dOaE9RQzVON1VaZnUrTkFGNlBU?=
 =?utf-8?B?dFJsYmhETVl2NEsrL01hb051YVNPU1cvVTg1SThNTEtacU5JNzhpWTZDWUox?=
 =?utf-8?B?Y29qcGtDOVovajNldjZYYWNhOU5jTGZxV2xDLzM0YWZHamVJT3JRajhXTHNW?=
 =?utf-8?B?ZlN0S29lZk5FVS9hNDRXMVNRd2dwTkh2TUhLcnBiWVdmOXRjTTIwdEdmZEln?=
 =?utf-8?B?Tm50UGE0Z3VCbGVjRzZuSWducUQ0cmREVzFaZXowSDhUZmREOFhVMUhUdklt?=
 =?utf-8?B?cStxc25RUm4rbUVtNUVHSllycDVtRFlaem1Tc056elRYcUo3RTRZcHFWd0JI?=
 =?utf-8?B?RGt2aEpaTnMvbmRJYU43SExTVWZJSklyRjRhVWZpcHU1T0QyRGRlTUJnRnQw?=
 =?utf-8?B?YmZqSUtxelBMVXBZdTJHMnl6bXpoLzdVWStuS2s5QXhiWk1ra2IzV3ZyNjI2?=
 =?utf-8?B?NmdvSzBTN3E4WmFTRzNyUHgwdk5LS2tXRnFTL0RwVGg0eGxwMHlsUlBwZFZw?=
 =?utf-8?B?T3RSTExPOURWdWpRMGdhMGVEbzNvWWc4UUxrQU5tQUMrcUlrYlhOVDdNV1Fv?=
 =?utf-8?B?VjBqRWUvNW9MZ1FIdHdCbFl1L2JmWXc2eSt2bVNlYmptelhjcnZqNTEwdDJU?=
 =?utf-8?B?bHVBU1VTaHdWd3pRUUlLUnFFYlBHNUErY05tSVJxVnJmOVBkT0Z3cEsvdys1?=
 =?utf-8?B?WXJhU24xY0NweDIzUVQyR3J2TmV0Uk1OYk43T0MvSXRYR09DZW84UUp4RVNX?=
 =?utf-8?B?c21GNVkrZFFQMjhPWEI4d2Q4cThoZXJpTHNNTzZEMmpJYTJ3bE5LMCtCV0h5?=
 =?utf-8?B?cUFsZ1lDUlcrNzE3RGtxMWlQVmx6bC9WV3hSUlc1d3Q2Z05mTWE4anhUY2RN?=
 =?utf-8?B?N0NJd1NJRUJ0L3MrcFhJV2E4c0RXSi91c0FnOGlQQnptZU10SUU4R0tnckFF?=
 =?utf-8?B?T0x4eGNIbGRZQ3IxakFZUzJuQUhiMmZDYkRxY2MzVGVteUVCbmZqSUh6TXhC?=
 =?utf-8?B?cWJSMXBvby9VbFh0ZTR1VlEzcEVGYy9SYzN5aUtQeFkrZHhyR3g2aVg4dVBW?=
 =?utf-8?B?SEk0ZEJjUWE1K0dHSUVKYU96dlJCaG5mNUV6d3NZUE9SZlpoMkY4cmhWSGdC?=
 =?utf-8?B?TmV5Y2F0cit2UVNSc2RQbS8vZUZDWk1veHUxWS9KdzVZZ2hHcmJYb2I1aDVz?=
 =?utf-8?B?WURCektaekhLYzZOb1F6cUlJdzFNWHU5T28yRUZtUnZja0h3RmxPZ2s2cXZK?=
 =?utf-8?B?cEtMYW9SWFVHME4xMGloTE9wbTRMc2hZQ2NFTEdnYVBWZjh2MXFtbG44T0Rz?=
 =?utf-8?B?V0dsRlNvYTF5NVZHVjBDK3c2cGhKRUN5NWZ3ZnF5bS9Ocyt6d0sraEEyVzJu?=
 =?utf-8?B?R3FmSjh2aDZVZm5OcnRKRW9ETU9uUjNhQU04MUhWdHZYckVNVmtrY1Z1b2lG?=
 =?utf-8?B?di9yc0d2enNYY2xFS1FNL0xuaGp1blpwaTYzcGV4eksyWmxYcUc3TlNXcFZP?=
 =?utf-8?B?bzJWdWd2aXY4S0tadlJuUFZRU0NiekVQMUNtVjRGMUNEeDVtVU8xQ3d4elFP?=
 =?utf-8?B?Y0R4MWhLdVBPbk5RRDNLR0huZTNFVFJwVlpPdkpyTjBLUGoyWkg5V0JidGRm?=
 =?utf-8?B?NDRoazFmZEk3VlFUcDA2S1hDakVvNzUxN0wvdm92TXozVnpVcEZUSTUwWEx0?=
 =?utf-8?B?TUkvZGMwKzllZFJKdUNWUGtXbjg4RnFNVmcyQWN2b2NZY0lPK3RKVW1yRktT?=
 =?utf-8?B?SkxLYTNJUS9TVmFwV3pPUlBkSnpxendDS1hESXFCWGpycmdHazBSMUxMb1FC?=
 =?utf-8?B?YzhXb1UwNjk2T3lQQitYa2pjL1o0RGx1b20yY01JczFGY3RxZU1LUktMdVRq?=
 =?utf-8?Q?L+O1JYJvaIQ+cS/N/IokCBeV3XyTswZieyusAi+wFZFHo?=
X-MS-Exchange-AntiSpam-MessageData-1: Qibo3ypKvhLipg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61324b8-c918-4a4d-e5fa-08debded4212
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2026 01:46:24.8059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHITZ3ae8DxDFHnF/4jp8XoCInRMj525dut3+xet4WDQiY0hzNpqxRY9PMn7LBtoZZOEczdDFzMzsc2Ph9sR+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9483
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

On Fri May 29, 2026 at 4:33 PM JST, Alexandre Courbot wrote:
> If `Gsp::boot` fails, the GSP can be left in a state where boot cannot
> be attempted again unless it is reset first.
>
> To avoid this, we want to run the unload bundle whenever `boot` fails to
> try and clear the partially-initialized state.
>
> Do this by wrapping the unload bundle into a drop guard up until `boot`
> returns. After that, running the unload bundle becomes the
> responsibility of the caller.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
