Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA531CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E2310EABF;
	Wed, 10 Jun 2026 15:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FifRZX7P";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012022.outbound.protection.outlook.com
 [40.93.195.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DED010EABF
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPgLVlJfReeAB+pODrD+aqRgZ7A0RHWC9ce14057kOX0C9qCNlUhCY4rBjxzCRwaDEwyo0DhS3LrsipJABJ99mlohi+CzPlOzsLaP3O0fTaeQHzr6Xah1Jko+Le3S851tBR5bFpo3X7xUvwIchL/jjMqDHJ0+gek4j1TcCzTBKV+TJOoEBZdY/qRoA3pXGwxgAq1dFS/icZ6FNENx0CZjgO6R+Vw7HFUWhGPBAJGf6TZPmqz+IFRwbX6S13+cxt5lQwwybEM9r6n93Asu9UH2IEX/upEkHZYpR01TBScT+IQy+19O8pv5JwcDupH4dv6ATjML4hNuRvpPt8HAzqV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5I09kMon0zGUpfWJl6jLnDHki4FbYNmHZ12zivzcOSg=;
 b=F5ay5+RTxhg2ZnHnuBsBboa819bbPtwPrrL+QAFUtqCcNT47sJn8NRVh/UhgbvwBeoN6Fn+JFymDrCZigP9XNfe74IGlFUjO1iIKAoNjp5tXKbtB0ssKCdzH8tMrTXVXl8ss3FU8YFv9eqnuhGduoWxXqOuu695ZIQX9RFTqgYA08bElv1gPIsy+928jIadr49g7sz+QXbhlJJN48/7oAmtesYWKDojV7pUOUe6IfliKFV48XbSBdxzNkpDrezaQUN07pcSJAtk6nxZzi2WfX1Yhfd2whjvLspZeW2vAa6OUa/5+FLxDjMCsgx0ZVCOe96Pa89vRwkdEKIVrs/peag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5I09kMon0zGUpfWJl6jLnDHki4FbYNmHZ12zivzcOSg=;
 b=FifRZX7PZHd+KjphivNdZPoKyAXD3YlybOMbGQZBxXJCdta2hINILtvbcu9evrGV+o1Y6PiQVzW6YWQEF30Asw6WkerTEcXMzipgC2jrH3jNYg4+9yFv+zpzSM3eiY8RSkgBaa3h7luBf+hCV0CAcsI5Zkjj0mjpICzANureGKGOSn4S9vssYSR3rg/nrUqsh5idfd3HL9sKYs+xwnCjvpMkoptMD9nlMshqJsJLdmH2/MTeLx0F1OuLKfSAXEspkTL+E6EaG+1VcqiNp/ebSwbwzk3T4wvHyjx8Hk5MlUpeAkkA26o/PBrnh4eknBr1D2MYkf7+7qJllclLanNPWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 15:28:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:28:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 00:28:06 +0900
Message-Id: <DJ5H4ONMJNUB.N5E8ZV5PRJZN@nvidia.com>
Cc: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: use `c"literal"` instead of `c_str!()`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@kernel.org>
References: <20260610135716.1013688-1-gary@kernel.org>
 <20260610135716.1013688-2-gary@kernel.org>
In-Reply-To: <20260610135716.1013688-2-gary@kernel.org>
X-ClientProxiedBy: TYWP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ff539d-3850-4837-af83-08dec704e0a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|7416014|376014|366016|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: JTyHzhgrGUSEovcbykMIrQszZHYcBA7RzTv3SEKlAfOEMDJPK0opol/1g9UbDlQnjzAA7b5Y8KnG/KsHlRF4oLyYWLYJWdS7sr+UNY+QPHrAoWifnMIrPwAIqzMYlYPGUukPLr1JL0qpUPhrE0IekA6cbTc9JpDDGRuyvjlFYXZX31i5Pyc1Cw4SZabp4PUINHuxjnpj3HFndkqiV1Ofekd4BCM9X/EZkBlr+gBHdjxcO7O8jByXueYTS5iWdIavJ9IglpjcTYrUAR8jxCTVElhSwBnuz+hG7Sd0TqqHXQvNac+hatY/bjcP8rTcr9UKh2FrORhq/0OWySN/ZrS+cnBs1JjAl3IyMeHZvqGYrkrhNQ7gxO4wgqPQADz9U+A8XQJWkP0qdMLdpgpd+tHqaOkVZVSNw6czBORSos2q1vnZpluprfPMVSxTHeXGCY03LViT/4pbFnX7LtaNsOK3ljy9S3OlwShmioUKc3k/BG+CkYcoez6y1vhwFfAMOPGXmd4iaDMLvi+bSKrQhns6x6AiiZwl5HVL9qDK6TDuR7BgJeRP7NPLVJ7wAmiJUx/l7WdUucka3S8AAE/5w+mfpJxSb/HpqBglcw5O608lWLuesTozyxVjrAkynT7DPqB3ZqoVA7kAvcD8FqqbhrTsskapXDd1N0yLw7VXnY9geVY0XzSo4AOkQqA2qrHe9fmz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(7416014)(376014)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVI3U3VleDAzSnd1Y2E2V1B3bWltdm5hSlhaNDZtZHozZTc2MkhSSWYwS01m?=
 =?utf-8?B?d25TWXBJUG5qSWlNQzJmN3kwSUdodXoySzM0VGNIUVl1dE1QdGlwaGVRTnA0?=
 =?utf-8?B?SHA3b3B5eXBSWkgvVGozZDFEdzFDbXcraDh6ZkhLdG9rTHVZRVNSRVBqcmRD?=
 =?utf-8?B?dGd6aWR4d3lqQkVveU9jazNweXhOblUveFJSNGtjZDdWWHRlRWdwZHJkQXFm?=
 =?utf-8?B?TW1jbFhacmQ2VFpjRmRENTZ5N055NHZvWDVwdDVRcGVRS3VuMFpwMnhjSmxH?=
 =?utf-8?B?NWxnbldBbjRsOUltMUtjT0RJWTY3VnZ6ODVGVkxibTExZGd4amJ0a1RzVUVL?=
 =?utf-8?B?Z2NTd0YrZHJOcVFkTEppaU12NjNUVDYvZmFzK0FESmtqOXJOZ0dnQ2ZEVVEv?=
 =?utf-8?B?YmFCdXliZkV6ekYrZ29Ua0RJNytreU96ZFpHTjdkOUE2QmNUU3lXaTVabEF6?=
 =?utf-8?B?d0M4SGphTnRReVc4bTFkTkU4cTQxMDlmakVMbDd0MFVEbnkrTzNhazVUcjZm?=
 =?utf-8?B?ekEzcW04dVZ4bG5xTFZ5bWpiYzZiNXdkdVdwQTdWTjBoN3psQlVQeE9idVdC?=
 =?utf-8?B?M244NFhXeExtVkw2aXNKZ2xWU1ZDSk8rUzhvNGM4ZmtGSktQcW5rT1psclRU?=
 =?utf-8?B?cHA3bGErRUVTcXUwZVU2RldqbHhzZUwxeHFBSGhDMWRhc1FCSHVCdkx4Rmh2?=
 =?utf-8?B?WjBUMWM4Ny82UTVqOGxBK1hkTHp1ZS9lMyt2Y1FwYmpBeUQybjY0NWc1N3JN?=
 =?utf-8?B?enUyWnloU0FjUEFHN1JJZVNURmVtUnBYZDdwdFpDM0J4YXhJZkpSNGtTQmQv?=
 =?utf-8?B?MlcvaFN2Wi9STGttRlFzTGlWbHc0NGRVUVZjNnFidkVtSjBSSmpmM3FrdFdL?=
 =?utf-8?B?RUFqM1N3ek45VjRueTdZZjlJN3lFcTB3K1VMbTVPbm9tNXJ1SDFCcUxYQjBr?=
 =?utf-8?B?Tk96NFp0Sk45N0FuWCs0aGRuTnYzQjR6ckMyUloyMFBlVElvbkNaeTZXTnpG?=
 =?utf-8?B?bkRSZG1pNHZUeGg3SkNidG8xSjlJR1lvTlAxN3l1Zytpd1cyVmhuVUJPcFBI?=
 =?utf-8?B?ZE5PZTVxOHZ5OE44cXptdXV2MjFvQzk2eE45Qm52WDY4djhTSFUvMDE3VWlH?=
 =?utf-8?B?ZGhIVVhlTnNrUlJQMFJreDRSYjF0R2JSYlVqWFl0UUV2dHRjeDd4OEhtYUJy?=
 =?utf-8?B?MXdkZkkxTUhGa1BaOVNyc251WjJselpZZHUrbG9vZzYxM1kvdTVTZGVrUy82?=
 =?utf-8?B?U3d5bTh2dmprUkpCNzFxRzFCUDFUQkFZQzc5cDFxVE1lZ3loaGZiMzE1SEFC?=
 =?utf-8?B?aVpzcWpGSW5VdmlMM1hZRVU5Ky9NUzdhUDI3Q1dkRU0vb1pCbkM4Q3YwT2VP?=
 =?utf-8?B?ZzdlMXozSnd5cEl0TVdmSWVkaDNIdTQ1SVZuUEcxU3FwU3paREdQYjRwcFpN?=
 =?utf-8?B?b2RmY0FUanBiSHFWeU85WGpkbzQ1aWxnRWswZEdFMFRjRkhDUWRqWXZBbW5P?=
 =?utf-8?B?QzVLLzFMWHJQYTh1SHFvZ1N2cWV5VDhFSE13S0tTdGFScENCY2FhOFNmNmYr?=
 =?utf-8?B?cEtCaE15Zm9xNkU5blFrcXF4cnk5UGtrS0RiZjRYM0ZSdVpYeEI3NzJhcVJs?=
 =?utf-8?B?dHBkSzZWNTZyZzhEaWxqdVB5ZEozQXMrdHN3Ylp4V2hWaXd4KzhPdzVxcm1L?=
 =?utf-8?B?Yk5iVzdnb08vbm0rSlZjY2orNGpJbVlxY0ZTOEVlUDNoczA5dTcxanJtY3B5?=
 =?utf-8?B?a3NjZk1TUHZxUlJSVDluUlBkaWt6OGIxc0xlSTYwOHlpQTZOUHpSNkdhRkMv?=
 =?utf-8?B?cXE3N0RBT3o3c09rQjgxL1VmZDE4clViSHZQbjRmdFhuYU1abG01YU9Sa25z?=
 =?utf-8?B?cWZ0cnNHV3gzV2NteEx0NDRyZjBZaFY5LzU2WUJKTC9yL1JyOXg3cE1xOUdN?=
 =?utf-8?B?TmpYSGxuQzVMUDdoU3hkaUd1S0V2MURuTWtlUkM1VTAyQ1k5WTlpWUlONE1l?=
 =?utf-8?B?S2o5enVlT3JWdzlUd2h5emVaakdGemY2S1FDN044YWQrc1kwb0lSZWI4Q3lD?=
 =?utf-8?B?WXhDSkdaSVkvOXZ0RU0zNmdYTmhmT0xUNTdscjh3M0FiSHRvd3JzSHBtaWo1?=
 =?utf-8?B?aEJsQTRUN1h5WU11WXRGVENLc3lUWGIxYk1MVlFDeFNTTzlwNXRzMXJRbGVB?=
 =?utf-8?B?b0lQR2dCVC9TMzR4YngxNkFEK1ZJOGxsRTJQd2RmWlFTRWViUm9VN1ZWNUoz?=
 =?utf-8?B?bTYzNkt1VDJNeEYya2pKeXQrVkNVRVUrVFBBWE50VHgrb25ocFV2NG9iYUlq?=
 =?utf-8?B?MTJGQUxIaUZPTGhyQ3dUUWQrNHFxVWtocjNKdE15ZEcwYnh3eWtqUE5mblBz?=
 =?utf-8?Q?wIzW9Vkgoh+zXCLI87EDgV1XC81Qs6CgGbnJUSkwYdAj2?=
X-MS-Exchange-AntiSpam-MessageData-1: tccY5tVCV/JY0g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ff539d-3850-4837-af83-08dec704e0a7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:28:09.8761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McgD6vZpWbvccotXNmzAWHL6DAZpNJUi7GjgY4z2aO6TyxtbhcGOQXLgXoHpMKfCf2FG3uzjQALsHznMgeDrNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
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

On Wed Jun 10, 2026 at 10:57 PM JST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> No functional changes intended.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
