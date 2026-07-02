Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DFBC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E0C10E42F;
	Thu,  2 Jul 2026 04:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="en5DtpvR";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFA510E42F
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 04:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LE7T1WG2GqQi6TQfdmrEJG6ufJZRci0dRbaCT2mtgaLLlk85ccMlfR5Fo5QR8+Ptq90sBbHJqloIPl1UTbF+OplOWA6iWCBwJqouhgRMJJjsMZs+ObpNzAjXgdPuWInHSX6oee96k4daBcKRlD3Pmy+Pj3BETK7CIMXKFAOvS8MNdANwk7fgJ+QbQ7czMJDu5VDJyzjKXiDAbj59XjJQO37WuvPZL3mGIkn0ATDNSwSgs3WLa2Wn0atXayoU5+UU6VpOJBC3QNjlzf0xPNRuXzASdjgNX9r1o9WPwZ68dnY8dTcyaymAWBPmG5IznHI0MBumMpw0PrXzXiwTUXwWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJk5BEqUfv5uQ8yoJW9FlPC5/1x8EG9dqi5ElbaZe4A=;
 b=fR2aPtxtkyM/uQmsucjEI12l2dOYLu2XPnLUk9JsBz62kOKxPCJhH41yRUOPgborHFOAAxRAquF66GnPN83WzT89y+MC67iRDhuKQg151M88GR7DQw/R3JpdRj8b4u0Cvz+Dwyz4PsP3gIZ4z3c+jf4XaupYHl+x/S5Au9DYDFfSHdwMVSuD2Y9rpERG7rvBjuFb6uEPMUsSYp6crGWhL1xTNNQrA8fHSUVrsjpCrfDaMz3c9zu2o7XbhZ1P8Fco7pgZ91S/tdgawPK17ZEXRyXfCMUhc+/dM3i2sCQYkyY3hUaGR22xzzHVTNa3Tnn031EanSWDZO0+UocF8wQZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJk5BEqUfv5uQ8yoJW9FlPC5/1x8EG9dqi5ElbaZe4A=;
 b=en5DtpvR+7ePKMd3w+o95iG0i16v3n5id84UG8ivuLNEH+hH8d+UtBAtuQ6Q0/6DMnckq/ZkOnY8x3JoadEd0mJmtREbR+sixXcAKWAA44fxntowzIljcrnNwPc6MOLZOmbBG0pUwI2wqhXpK9fLGdhtOgvHYR2CTZWLR9HQ1mhZ0cBs6SuWAuindjyTv5EYb4kaSmdAX8ppmyhEzgg8+Z0wFQPo7tawI0l58bPjaeLPOfOwt+g4dysaD8i4q78pn8gvqD/vdIeuZVi2NwnHbOCOREN3b/iPaDqM7KbgjVrSeHIkCjioJAXtYyVCAfbzCegQadQU/Yg9zAwOcsVhtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 04:52:57 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 04:52:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 13:52:53 +0900
Message-Id: <DJNTEBHY3M5O.1WOC26NA4ET7P@nvidia.com>
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
Subject: Re: [PATCH v5 09/19] rust: drm: split Deref for Device context
 typestates
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-10-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-10-dakr@kernel.org>
X-ClientProxiedBy: TY4PR01CA0109.jpnprd01.prod.outlook.com
 (2603:1096:405:378::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5ef198-f48e-4bef-39c2-08ded7f5c8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|10070799003|376014|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TKLxaAv5U2qhVFccHEEDcRvfCwTg9aSEFbmZtNamxAeDOjXxswxbAWwc4Gy8SaUWocbpU/K9LqE5I1lThp92qa6v4nQ/FoAsq2Bcfhx6Z75Lxa0feiHbLQD61R/Jz15OS2QGoe7YEqGMeo3UMyRNY5EuUmlWR5cDybaxod831Qz5fwAX6GNFBSx/di16m/BkKcbLpbCbzSqc+x2tfrMAaLdYd2y7oCfHClJL/032rqzObIEDyBD9rrEnRe/5wUW2k92elPMbh8/KlcSJe413kXLxg/xkhfHYgC9UIzBmSv7zoLtqolfybRSi8TpuoNE5MGE8ghjuwPcFs/w/hNtWTHnsseZ4HbWjDAJMr2kzh6DP9eUVeKfLhaDjZY92i5W2gZKDRAEe/PYZyxFBkl3Z1tuDB5mA/7xahqp3motcowidJEXcXe966ml7g1xAnOPJdslkdMPWhfuRgKAw9QfO7/wy2mlzwix6tZAKi43FCPNT4DiVjoX3yZqE7nR3eValCbK8DyUhllT2sjJMnxxNPRUG2HXDv8Ez3vw4lSHF+pskfC64F8lk70sJxCm2piz+mmb2Gm5qAVeZeJ7l0w8NhDS9Js4KpPiR1I3/FlIvJvB/pkSNbDQP3hV0Qqec9v8AMai8o1TQCPnUdH0vuCWOLwPSmQuerhQUjmlOjlx/8Ho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(10070799003)(376014)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWdoOCtZb1ZnQjAyTkhGNGFPYi9nalovQUFEU1VwbktOTEtvQ21idFB2bVJV?=
 =?utf-8?B?anZGdWR1U0d2TnZJMGhreXBSWUhMVEV5T3ZZTGhmbm1QNEpndmQ4Zk9kT1pi?=
 =?utf-8?B?VVdpSnBaZlVGN2ZzUEVaUmxRRkxiaVVuMEhuZWRDamtCT1FSMUZsZmE4eDN5?=
 =?utf-8?B?UWpPQ3JHK05aV3ZROGxXQkRSRm5RNzVqc1J6YmZxM0FsaGtJVm9JUDRwMWJ2?=
 =?utf-8?B?Qk9ZN2pCclR1RXdXNzBFdkoxbHNlM1pSM0RXUWZyYU91cjFFSUZpTE02UUwz?=
 =?utf-8?B?K2tlMWJmUkVyd3Z2K05CcmpBSzZLR251NUVpNkhsRFdEeWJyN1ZsRnRGNU5T?=
 =?utf-8?B?akN3dUUraTFGMTBZcGpnOUl3SHZDK1BIcHIvSHpyakJOVzFhNHpiYVNmdmFr?=
 =?utf-8?B?enZTNERuL083TjFZSlZnR2hTbU1DNy8xT1p2VVkxUFZBQ1FyS2d1ZFNCQXVT?=
 =?utf-8?B?VTdpOFdoVUxFaDRGVGhSZlFpY0hyWUUwN3J4T001ZFVnTFE2UFA4K0NUVUZO?=
 =?utf-8?B?djhxRXBVeHcwUjYzMXltL2tmZk1TcVFlaXU1Zk5GMVpWdlErcEpUMjlzeU1K?=
 =?utf-8?B?WmJXR01BSnErd085UTRnbFRReVl4NXduODlKVWM5RzB6d2E2dE9pNytvMU80?=
 =?utf-8?B?dTRCSG4wWllaaWR1OTB1VjRaZWZ1TTJ0VXFJWWE0eG4yWSt5QkJ5U29wa0Nv?=
 =?utf-8?B?U1FPTlJhSGpnaWUyNGJENjd0eGkxbEVlZmZ2NXJsSnpHaVlPaEZrRXE0YXVQ?=
 =?utf-8?B?Tit6Y0NOSWtydDVMNUo4c29oUGRBeVgwOUJ2QWloTU1SVGZsa1NqUjZRQnF0?=
 =?utf-8?B?dG9hb0pOTEQ3ZFJ6Ti9yUmx2MjlUSWk3eDNNc1NyR25leWlLdkxQaFBabGNq?=
 =?utf-8?B?SFRoekNzM2N5dDVIOEcycE96NUlPNmhtTlBJRFdhbEUyRkl6OG1YTVR3dGox?=
 =?utf-8?B?cmVvSGRWbEplQXJDOWVDSXJQeDl2V1hXSG1URTdEc2huTm5wT0xZR2NpTDJV?=
 =?utf-8?B?S09ZckVxQTlPMTd3RmJJb0l0aFpTcXoyTE5aemFwcW9za09oSHpYa3dpK3h6?=
 =?utf-8?B?VG9WK3JJL2NaUlZmeEY5MjBSS1hxK1ZyK2wxY0h3NTM0TGg5OU5GanBrVy8w?=
 =?utf-8?B?WEFhL0RkL0xSWk9YdnFSS0Jiem1SU2RhdU11VmVmNVRCMWZ1UGlwVnl5RXZL?=
 =?utf-8?B?b1Q1bG9RMW9YYmJoeFk3cjcyYytZakw4VWVnOCtZaXpxZE1TdU85eDQ2cWlX?=
 =?utf-8?B?dE9PSGdRLzVlTUVVV2ZMRFIzWDJ2dDJqU1FVN2UvVnRQZGZaSzNYKzFzSWZP?=
 =?utf-8?B?bnZBMHl3SXZGcFAzWkhsdnhpVENWQ3hhaS9iZWwxK0xCUXhwTncyUXhHZDRk?=
 =?utf-8?B?bDVYT1JiWDU0S091UkdEMjNSUW5vczg3V3ltb2xzb0EvSUY5WmpnZWRhbXcx?=
 =?utf-8?B?UzRPbWhjQWhoTndQMUI0Mjg1S2daWFFTajV5VjQ4ZnRRU2Z5bkswUXJFR3cx?=
 =?utf-8?B?aWRxdEpxMEF5bXlBL1Y4OGZOYmNaOWxtVzU1SUc1Vk8vSm5zUGtuRWtXUW9F?=
 =?utf-8?B?aEZ5dGRId0tkSHRJQmNuMkNVd0lKZUg3d01WdnZzU2JlZ3RFdlpyVGZPWGVS?=
 =?utf-8?B?SU9SZEtBNkdtRi9BTG1yOXAwUDB1U3RkVk1mQlVMWWxGd21QVEpTd25WdUo2?=
 =?utf-8?B?Rm1iNlhuVDQ2a1hKUm9wN1NHQVgxeXdMS3dYRWlXcWRGVkZoR0xZU25DY0My?=
 =?utf-8?B?NE1ncytzNkNZaTFadHVWMlJic3MvNzg2WkJaajMyR3hyTC9mbjM0dWZCSjZ3?=
 =?utf-8?B?aVlZQjhRY0xQS1RGbXY4eDRESjdYMTFRU3hreUlMci9RSnFFQWhQd2Q2QW1Z?=
 =?utf-8?B?c1pIWXF2K1FCaklpbEhCUEFONDIwTDVwLzh5clRYMFZnTGxEcTFkMWZLNTNM?=
 =?utf-8?B?dmt5TmRma2JYSUR0V2dBa29zS2hRZzFBczRyaHZOSzRXdGErS3FVeDBtQkho?=
 =?utf-8?B?b3BHb3ltZENTWHJZV1pjNUgwb0IzMHlXMmt2SFRKd2w0bXk5SElIOGxWVGZv?=
 =?utf-8?B?bm9xcXFFV3l0UE1VRXdxOWhkZGlmbjdtNG5ub1dMVnVxSEF0bFE4NmtWVktK?=
 =?utf-8?B?Vjk4SkVib2xIYTVSSm9CMXVRVGo5WldNYXIvTU9ZVXUxL1A2WDhxRUxBRFk5?=
 =?utf-8?B?RlR1Nm9pZHhYVFY5aXFJUlMxenhhakRKQ0owODYyaVhNNW93MWY3UXlUUmVY?=
 =?utf-8?B?cW1wN3FQRW9VTEtQNERMeG1WY2c3TUVhTU9la0p4MXNpbjhuaTZVRTcrbDA5?=
 =?utf-8?B?SldQSE95QkpuVTZjcU9sdkh2b1ppbXlTWHJLZjJkRXhNZXhCRFl6c1JtTEZI?=
 =?utf-8?Q?pIVkgws6mb4z+hHgrOz/Y0HGqygFAogu9+dwlwEOMZS1S?=
X-MS-Exchange-AntiSpam-MessageData-1: zdTX7uIrUJSWnw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5ef198-f48e-4bef-39c2-08ded7f5c8bc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 04:52:56.9319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+oZVYUHjWAyK1B9R8U/HZ7sEAf1Ai1FxS5ZxKK4rd1MV/3k6gLgTsIewPXgEgWF5eVtjuwGZp9DRg6vJqTL1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865
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
> Split the Deref implementation for drm::Device by context:
>
>   - Device<T> (Normal) dereferences to T::Data.
>   - Device<T, Registered> dereferences to Device<T> (Normal).
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
