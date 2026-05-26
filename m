Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4495CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 01:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3130510E42E;
	Tue, 26 May 2026 01:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eXkjhicc";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C7210E42E;
 Tue, 26 May 2026 01:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUpKqnyuosjxgkLY2Fk0S/Ut6iI7OkyZXqRNS8N6sd/JKstxRFTCBgTF7HgcR9NNXqvxd//OlOJUU8B8vQxI6mE3RFRkragQJn/bsm/s10PWQM35qDGh0BWSLhv3NUHB+7eUXy4azPxhofLDHv3JXI4nujD9OfeD/ZS07ZQVxGv/X2Xs/fj2d6gnD7r9Zr//sC/cQnMGS0UBAf7ET7d+WxedXVcdhJXAutocadYmD50B8C5anIDeOKirXoPIBlPln02RjwCBmenR3XaLUG8mokMVeBnH5nWIHiOSHDXc1EirV6lE7YLnmcUuNO7oOmkoZzUSKoWxsmaYbovSBjvFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9b9mBltzybiGnF6iyhrfKb2TMlLb5ic8VhNbg1Am9A=;
 b=aHg6iyLQ15a7KmaNGFA5L500m6o1AFGpraczF4Zr4QnHcAxe9mF+LwvKNlZHM8uQKQTXlZTzSQe9FcXl/u+aIUGlnzeNRpxKDFuHs/HyF+KimBfERed5RGUvBAyDlpbxf9QwvKC+NcftnXUL6x3Sanb1CdSOiDo7UORmGUr+P4CgWL+NS1wyiA38XhM245cK3wVmKC62PAQKXywYM5PjDK3wlerii2VrolJaRD2wR15W88hqr3wZ3qAYnWVc44FZSjBgOUU1g6X+wAyRu5wPlODoNqxQptuae3+IILq2B1iYLC5Fp9yeEl0m7N0pPcg6pOqCFafivW7Qm5xBuOLlIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9b9mBltzybiGnF6iyhrfKb2TMlLb5ic8VhNbg1Am9A=;
 b=eXkjhicciISXhHEUcpZ0m06Qf2UqUqhPSxDxMnRvyPii8SkRQedsxF6OyTpSWrsienVRpB5cTqMnlAlWABEIvhbcVW8+yWs0g7YzN5vHwg2SSVQfrXDJ6wItA0t46ba2hF1IBrRRC+WYRTED94Z9ot2nqEWksHFIFVvfqxZHhGp9Zqcca9lqoEZXLKVgUXECMKQ2gIk+/IsbfMKJz9osUKt+ER6QHdpEmDLr9z4XihJpP0GHgbLnwx7/WW6iiuW7Qa3MdAoRKlUQq+NHBtfdju7rM3yy91MVzQWyWqXkD8An+6JgeY/XEeHyx++OZ7llGvrBLbuYXN6ID2/Vku0dxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 26 May
 2026 01:44:23 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:44:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 10:44:18 +0900
Message-Id: <DIS87RUBF1WX.2TTG0PIV1GTKM@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 3/5] gpu: nova-core: replace ARef<Device> with &'bound
 Device in SysmemFlush
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <ttabi@nvidia.com>, <joelagnelf@nvidia.com>, <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260525225838.276108-1-dakr@kernel.org>
 <20260525225838.276108-4-dakr@kernel.org>
In-Reply-To: <20260525225838.276108-4-dakr@kernel.org>
X-ClientProxiedBy: TY4P301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c11e84b-6878-417a-6fed-08debac84fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Ja4/QAG9QDfCAJtNhwaZiPdidO2KINkfYVa5xet8SavtHjE9MmM6TAZLF6keQPHslqiI487jKlPb69QXd36BTRIL4A8QzHVkocH/BiqKAG5PoFq+3Tk+iOBCx2JO1B3SfB5aKrvmcH0LH1ZJ+cASgOXsup40unH97NGZsAGbYxfPooQFqM9T3WlBH3sBMIgOWxEBPKnfgSRVMzddIagSx9BvFZK6UZBqmvTzUndAvDDnWw1FwRDisOFe6XdCYV1ISm9QUMSb5CEgw1n2Ez7KTS1C4cbuTH+3mZcSspDwbgEPDvYbdvzaVSTV/D/G5LGwKh3LjvTW2gox9adL0iJfge0Bd90n96GIROMJLRSnurc8Ull40O7DM6q9Qdaa6s7b0mVdxx1B8SgAuPyWIl1K5X5emB6rd+0wgwIS1Lxxb9kHf5CQAcuf9W4UnBjmJXRDGjZz/Oft2nKndutNMxZ/GQLIExdDGvp+KE2B2R3oWkTfB6FqC6BDSNEucJbCrY8Zw6uStJAhp0PUjZRa7rYn8ZbCT5D0RVP/RKSUKVm4vJOUU22mdv7YL5j8QJzgYLrmVt1rJDhzxVksElKdAOBhXLrTqVV8O5yiLA6F6z4uH84Ndllu+ZqFm5+T0Zl06Gb2z4W3uz34imVPJIFwaAY24LjEZzqz5eJDvz9eqXauePq9UyQWj3XRvfGcUikELoBf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clVTcXQzeWF1TlBDMzFDaW5yYmxLUld5RFFjV0VZNVJnaWh5RTVBdWJjTDNq?=
 =?utf-8?B?blUvb0lvK3lxZnFDOFI3NThac2FPaCtkd1JXcE5WaHJHL0t4dENYQzVlS3U0?=
 =?utf-8?B?cGhVZVJ0aG1tamVudnlSdFhWTVFEZzlmY1dRRlV6VVorY3V4dm5zR1R2WTlk?=
 =?utf-8?B?cTRRYWVNUjFoQkNYamEvWUFJTW5yVllUOEVycTZ3OEVsNmFiUnVvWHFuTzUr?=
 =?utf-8?B?WnFYWUZPVVJ4N0RYS093dnU4UnJSbGNpZlhlSm53clMwNEJhUGdQeGJ3SEFx?=
 =?utf-8?B?M3FFYXNHd2hzcW5YT3IyS1gvdkxPdUNMNlRsMEpMNmg3MFBoRHRmUWNEWkp6?=
 =?utf-8?B?N1AxV20wWE9pTTl3UkRRZDRLaVZuQ1kyY05jajV3bTBCeDlQV2h3NkpYOVFI?=
 =?utf-8?B?ejJGVG1rVG1FQ21CdlJFcUczbWFCckJsSVIzR0FCUUJIRlI2dzcrcHk1cGFw?=
 =?utf-8?B?R20yd2JkQytJTEUvK21BTzVwQVFGcjFrZEZKSGVSWjZQM1ppTFZ0T1lPVlRS?=
 =?utf-8?B?ZFd1OGdBNS9hK2lIVWd6ZGVKQThkMlgyNGRPaHFSNVB3TnNpclJPMzJqQWVw?=
 =?utf-8?B?ZWJZc3dnWmU4d2o2QnBiWitBSk5IcWxDVURtMDZYMUlHT3YrWGtld2VlNm9T?=
 =?utf-8?B?QzU0MkxsalduUnBobmN3K3RDM2VaamxxZ3Y4QjBIVTdKYzNzNWRwczQ1OVNl?=
 =?utf-8?B?b3ZTZ2tSWHZlTEU5cjMvM25tRnFVUmNtSUxpU2VMeEh2ZDlkR005dXJqOXZK?=
 =?utf-8?B?dGV0VU9Na3dNdGVtSFMveTBMV1JoWG5SMzNPMEhUdjN0bFBGNFcxQzh2OW5y?=
 =?utf-8?B?c3cwYVVWWUsyaElFOTBuTWlVMWNZYUV6eTYyRTFDYitUd3Y4MTFtNm5OK1BP?=
 =?utf-8?B?LzZUZ1p3VEwwL3lEWkRMSnI3ak43MG9hYis1dnFXb2lkRVIyamg0TWNUUlor?=
 =?utf-8?B?cFloYjd6T25Bc1NMUzdnZHRxSjdJemw3OXVjWXlEZ3VGU3FuSFRvcElqT0NW?=
 =?utf-8?B?YzlBUzNFZ3NQNGFVS3E5eEkxQzFVUk1McU1rZmZuSXpaYjZHZXpVTTBnSWlm?=
 =?utf-8?B?ZXNxNnNlOTJJL0EweEV3M2lTY2VpVUUyTUc0WElpNmUrZ2JVYmRMK1VsMCt3?=
 =?utf-8?B?RjRqSkI5VlQ0ZzNPZjNXdzJDNkxqV1JJTTZrTmk5SWRRbWJaMW1rd2J2Nnov?=
 =?utf-8?B?UGkweUtRQ2Q4RXFNNGlsbXBVZlJZTjEraDVtZnFBR3M5QkEyRU5DbmhIUzVk?=
 =?utf-8?B?VzV1R21adXhld0VKbStmOW9ZM2dFbWZlZlpTWjZpRjJvcU1XZk5aOHY0bVp2?=
 =?utf-8?B?R1EydnhXOHR0eUdCTDc0WW5kMjc0Vmd3TVBDKzhXNW1BcUJ1TzJDOEpyWGpx?=
 =?utf-8?B?b3poZm0xZUxkWjBua0I0S3hrVnhpOS9GUkR0Y3drdFhkenFvK0Vhb0lCanM3?=
 =?utf-8?B?dnFvZ0t3M2NzU2hGZHkzdmtQVXVXeU1ET05NckJ3MytuQ05ZdWZjcENMVEdm?=
 =?utf-8?B?MWNxREFCdnZudmhsZEcwVUdtaTM3VmhIc1lSS3A3ZmkvbWdxUWt4VDZ4M0dT?=
 =?utf-8?B?cmZHSU91NTdWWFRiMWhJSmdpTk80QlBJeloyYUI4blJmVjE1UU5jblJlYWZG?=
 =?utf-8?B?aWY3Y0QyOExMRmhCSjd0WFFsckVsL0tBZ3lFMExCVnRHR0x6eFB0YXNncEJK?=
 =?utf-8?B?SlprQktDOEo3M3JBaXZLN3pJMGx0VjRzQ05ZTHhDVlhiRm1SVng0UXo3YlVZ?=
 =?utf-8?B?dzk5aWFaZllHTGMrbzBXdHEvbzAvQ2RQK2twUUcvYXJQQlRZWk5YdENmWGRE?=
 =?utf-8?B?NWZ6blhQTFVFVUFvcFpXeFFiTjBqM0hRTmErRytXeEQweDhMZmpnaHdzNG45?=
 =?utf-8?B?Y3Q5TTVzTnRmcnkzOE56amxVZDRMcURvK0VxYzVsYU9jaTlzNENWcklHakVq?=
 =?utf-8?B?R0xRb3BlMkJSWlFlbXg3Rk1hRTNhYkszVjdWTC9mRGJmNHhPc3hsNlpleTd3?=
 =?utf-8?B?YkZIRjNzaVhONmozQzcrZUMwcnY3R3hPcWpEbVI3UGVCekZmdncvcGRubjRn?=
 =?utf-8?B?TDhaRkxZUXF5UGQ1UEhyZG93UlRYRkFKYlQ3VXIwNTlDb240cWVnK0Z4Q0Ev?=
 =?utf-8?B?OUd1S1pDWG1ZUUxBMk1OclJUajRvb3F2QWdvZWRobnRiUTdRaXU4Ym1kTGlV?=
 =?utf-8?B?dHRGMDM5RGUyQ0U4WVJJdjZhS25NQ21VQjBzTDBwYzlGbVlwVG0raGNQelJx?=
 =?utf-8?B?WjRhNmVZNWJQR3BvclV6T1p6UUlSaU1FbHIwMGRXMmNnUHBPSnRhRWVHN0pC?=
 =?utf-8?B?ZXpSeXJJZFJOanozTk1qWnRPWTl3bC9hd0ROcVVOQkxrY0Z6b29HV0xOTVkr?=
 =?utf-8?Q?uUbECZVyNZ++I11LdB3lj030sB8HJmrxTYbWcEqD2ojB1?=
X-MS-Exchange-AntiSpam-MessageData-1: /PfWPD2dh+wyEQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c11e84b-6878-417a-6fed-08debac84fc7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:44:22.8901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yD2dJJUpb66dUh4S4ZLK1ENbomxvLmH00vIuT85aCLe/uOit7mFjwrHqxjdIZcFS4vcZvRv2Q20RkKmHy7Gdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

On Tue May 26, 2026 at 7:58 AM JST, Danilo Krummrich wrote:
> Now that SysmemFlush is lifetime-parameterized, the ARef<Device> is
> unnecessary -- a plain &'bound Device reference suffices.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
