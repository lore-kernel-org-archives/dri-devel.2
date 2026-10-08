Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D40CA600A
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 08:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C9410E766;
	Thu,  8 Oct 2026 08:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUvbddGx";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE8610E765
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 08:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlvhwnZywMo20ROm6gjjrQAVrm6vuQCHof19bmN0CGuEobze4dawgZXQrc+HSMwy0ODulGI0K6QU9UZfF+7rsJXSZwTqIpQN0yfeshAc2dvvtPC/ve7JafWeq58QVCzpB7RDeLsa1rEVbS5YVR/IDY+VKfnu+qCdb/6jwlYQRhbTegV1lzVU4VV02xemoocyApMDA0m49oRtOu1Hs8AfpMQw9YzUFwPOd9X04CEowRq4D58HvzuUBlpc1FEpKw+PC/W7GVDAsbXnsKKd6Y4hiLhD6XwnrRA9cvZSkNUa/3p4kydqydSA4SzyWTxHCoH/eRcCbXu0SfVFby4FE1To2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCge2Q06zixJfUvukQ/YHsuVQI6qgpFdcIQpyu/BQn0=;
 b=cpasLseoI4ZqrgMqkmKG+TS/71eNzMimtev3ZnAsc2a1yvdRtjJOXjIpFiunCvqvqHbDCEQupjPAbWblml+oGiTJIAHJ3sdLJXZpVxP0YqXw0hf0fYIgu4GNfl2fkdypNZ8N7CT/CNk1REhesrDAhSaruPKmg2QdYOL7Swk4MH08dKkpAmG6HdcDCSBh+9s6Qz6CU92LkmGwFW64yHX0LCMUqG7DKGwVgy3navqYdOXSiNZNvYG5r4HMYAw+MZ3F0aUpE8CtFK8G5yrasg1eH+CcUHj5y6CbyAMawORvyBzT6b6b287els4ymowMvw67d/twxTmZYVetnicYCw26iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCge2Q06zixJfUvukQ/YHsuVQI6qgpFdcIQpyu/BQn0=;
 b=oUvbddGxe4XmRFALFZukg7ZprTPexGmnOPJNGgLYt8fZNFMrLrp3guoTvQ+j6aJ57beujETvby+v4Eg97r8WMLtFu15mC0ly/B0fU8AwrwEMrElEDpVnrdiMqe35K1mcr6mMrxxX0IbEy1bhIeoCcfmJQlfKRmTbR+B4nULtbsUQ/FdwVwn9+0qevLvaM73aKnZ6FnE9zTlvTsRFnMTwUskV1IlGM5EGB34i6PLTJldukKpD/nQ6huDoVBXH9qHrKVKFG7o6mvlg6hqLZgj49VcPP2jlcNWc04/kTwacUQIhF2PidYsKHaX9ZDRVm6hnOXRnlzwIoX3fLe4TGu5cGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Thu, 8 Oct
 2026 08:32:42 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 08:32:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Oct 2026 17:32:38 +0900
Message-Id: <DLZBFYOAL5BZ.399YM6UPEZGES@nvidia.com>
To: "Thorsten Blum" <blum@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "Timur Tabi"
 <ttabi@nvidia.com>, "Tim Kovalenko" <tim.kovalenko@proton.me>, "Eliot
 Courtney" <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] gpu: nova-core: firmware: fwsec: use KVVec::zeroed()
 to zero-pad buffer
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20261007203035.162075-4-blum@kernel.org>
In-Reply-To: <20261007203035.162075-4-blum@kernel.org>
X-ClientProxiedBy: OS3P286CA0061.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:200::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a74e837-3d6e-4a76-6816-08df2516b876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|366016|7416014|376014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bcMGUhP/HwMl0ED2KRu8oKHZTMSIS3Uyj9U4IcrH7noQa3r3jQjgjl6DK4TWY9j7fwMgaAxkWpy8o4CBcDVOSLLjP3u0RpASctKFNoYFRjrWUDTiEmB3vVHdqP+AMFhTyNHGgdmAr6x567sktpmwSfVOpJZw77cpjLtmp7qBMyNFL2sAlr+32LulwRFKChQjc7yNfnlU70vCuWdMnJn+r3EiFOsA2SLJvXscJuflGJ5JgrX6e3gWfSZb4wvH9gODWELBeEaoSlvTYtEbVf8ter3NDmShrlyok1b69qII2pFs34nSreXF6pfzsnQ+FTT/bj9ctarhdDJf/digi476LZAqQ7VepnGYV3LhlYyzOcvO2/u6HPM+4JFs2PPTKDKVtQJ+B4Nau5M8YIo9QWn/hHPYRjhf8huXkrOLbhFcK0td8dMdtFScdlh7PEVRn3GprjnTg5HlC6ixHv3p1v0YromM/o0NQPVRgrVrtAuqsdIIevIYVSsRtpyCDZMsCv8WccatIveIjiazaNODccV1Btropr64PYssyUSDpzYwhRBjV9pjT/6FDjiJrjDQ5pv48CgiW3WKIzl9po68dXyCcrySq+6DpurLXtvJQRML/6UBfGzowNIHxmyxHT6EExnWv7onYBQrPYeAKR9Nvan8VawiSggMjs6zt6N1jvrbVis=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(7416014)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmNoSEozdWlNVjl4cklQd1A1blBSMkVKY0Q4RkxMNUZJQmxrTi9LaGsvNURC?=
 =?utf-8?B?UFNDS3VIZmlEa0VJc244VzRvbUE3UUlvOExwREwxMzYwNU03OXJPQVRCVk44?=
 =?utf-8?B?U1JGS2dHMGwwWGxnVldKWjRESnNoZ1A0cFRKOG1vaGZiVHVCdUpWZS9ZaEtD?=
 =?utf-8?B?ckZTanpiUlVVMnRTazFiUHgvbERyamhBejYvQUhpQ0VEbkkydjArWTdEcThN?=
 =?utf-8?B?Q0pOSFdLNXZDV2xScmdyZC9tL0ozSitaNUZiR2R2NUdQQmYydnZITmhHVGla?=
 =?utf-8?B?dUpPUDdPRlFzYXFmVFVVY3VnSnE5aXIwbzhlUWxnYk1lSUlvL0t0aFgxWHRG?=
 =?utf-8?B?ejBFSTJVdk5rdURkRkhnbDVmd1FMQW5lRExaazZTNXZLc21RVWdleWpwVjgx?=
 =?utf-8?B?YUFrQXA2NG45UGl0ZkM5aktST0E0WVFIajRDREJWU3JUNFp3NElWbWRJVEpG?=
 =?utf-8?B?THRUczAxRjU1Unk4WGRTQW0vbGFaWHVVOWsyWS9Fd25SdkczMmZmVFZ0Mksw?=
 =?utf-8?B?citKeFA4ajlLUmhiR2RteUJsVFl4Tnc2SGRqcDJLNHd6OGUrZEpPSTdsZVZp?=
 =?utf-8?B?Q0ZtdjdOSU9JbDM5NmMveEtJM1h6K2RqS1ptd0dIUWFWNHJZNTBqRHhjZ28r?=
 =?utf-8?B?a1JtbEo1TlhkN1l3bCtPbHpGWHNNcDVIclAwK1lWeTFKRDg0OHdEUmpoWXZz?=
 =?utf-8?B?VU5ZQTZrS092VGsraGpYUUx4MWNKbCtPcXRMM05oYWovZldyb2F1RWpwcFlo?=
 =?utf-8?B?T2JDTVhhSjljWCtNeXk5MXFIVXlHMXRLdktkTjhQQk1qZTVZcnk5cDh2UDdy?=
 =?utf-8?B?SXNRdzdYeXB3SkNNZ3BzRlB1NzBMWHpNdmpYWGhtZk1QckFqa2lBakJCZGtP?=
 =?utf-8?B?RDVlWVhLL1NuOExQa3R2aEJHdTgzcVR6MXVHaWdxUVBzU28wWVJVdkN1VUVn?=
 =?utf-8?B?YndLK1VDTlR2cDJnb2RJQXh3MWc3Wi96eThCQkE5N0RLU3hDM1ZVblZyNHkw?=
 =?utf-8?B?UTB2VDhndEttZC8xam42d3Q4N2lRYmhVMlIxczZDQU5lY3YzaWZQMHYvYXls?=
 =?utf-8?B?Z3RyczltRm5JTFZ1T0xpRkk5L3ZFR3lua01JTDMweWNYL20wL0xlSG1RSm4y?=
 =?utf-8?B?d1E3UkNxYW9ZR2xqcE02dnl6Zy9xSVFCeTJWamExSUgzYjIxdEJTYVhMUnNz?=
 =?utf-8?B?UlRTaW9RVnVTTWV6QVc4NFdyMU9qSGZmSmJBczJSZ01UaGlUMU5kN2pxdERy?=
 =?utf-8?B?b3U1QVdlemcvVXFMV0VQY2NtaVpWSEZTRjIzUmdmWVpwV1NPM3p0a2hZUUs0?=
 =?utf-8?B?OGF4Vis1WDFWcmF6L2FEVVZtUVluTHIrUVdYd01BUVRJVEZscExrMjZNTmJr?=
 =?utf-8?B?SHd3VVc0d2J4Q3luWWxPakRNbU1JZzBJVUhZQStRTnI3REFra1BqVVdjeERH?=
 =?utf-8?B?YnZTZGc1Wk1lR3RRZFc4M2ZxaXlRaWVNYUJ5YWRDZzd3Y3ovU3FPeVVSd0J0?=
 =?utf-8?B?ZEp6SmdBQThja0UxUHBVQ0VtN2tjUm5idWJYOG9iOGx6UVJMa0lJYUM2VElO?=
 =?utf-8?B?cUdTNzFXMlBhT3d5UjRwOGxHbDdTUW1ZZ2ZhOWNIMDRsOTE0Smp3OWpCdmhz?=
 =?utf-8?B?cXQrdEVMdFBra0RuS0xNVldPYTF1OVRqUzc1TVRNcUtRQU82LytPbURnV2Zo?=
 =?utf-8?B?amFtWWU1eGhmdGdMem1KR1p6Q3NHOVU4dEx6ZG9IekFtdExpSU43MjMxdU5I?=
 =?utf-8?B?Y0E3VjBJYkhNYU9iUzlQSlA3S2FSeFZFckhGempBOXIzQ0Y5QTd1c3k0VDVG?=
 =?utf-8?B?c05Cd2FuaUVpTXZtRVJ0MUZsL2t3dGMyZkJRSThPTXNpOU5KKy9Vc1ZVVXNV?=
 =?utf-8?B?cWVyT2lnbjdlQ09Xdysyd2k1UEdKU2RwaDRzYmRMY2hhamxkRUZVRUQwajR4?=
 =?utf-8?B?bENGWE5VNXNKMnBzbGNoUGR2ZFh5MmhKVmJ1L2FCL1B0YjlhUUtkRlczYkMw?=
 =?utf-8?B?UjE5Y3phcWFrcHRTNytWbFFkMHlXSGR2OFVtRnFEU0VkSHRYMlVRMU85a2J1?=
 =?utf-8?B?anMzdDVhSnpyZ2dhdHhrWHdpWG1HcnBtdXB4dW9SWW1kdVU2VmU3R0xBV3Z4?=
 =?utf-8?B?anV3dmNUSDA0K1lselJjaE1WaWVNUTRob2dXaUVjSlhQZDJQZkUwSW9kMUF0?=
 =?utf-8?B?Rm5Sa3U5MFdFT05zQW9JWk5wUUJlRlB4TS8vSXRTb1BNMEVKc2dnYU1wYUUy?=
 =?utf-8?B?eHB4d1pxNXRIRTNPdFRrQzZscDU5MGdPWE9PSDJjUE05SDkxdmY1VXJqVDNs?=
 =?utf-8?B?UkM3R05zalVWRUZOVG9jV0h2RlQwdVVLR2Q2T2J3THdPUnhFblVwMmZpOW1G?=
 =?utf-8?Q?8EI+NmhLscb/lGdWFk/Y1gWbYciaJRA21B9fp2VOq9Cz2?=
X-MS-Exchange-AntiSpam-MessageData-1: M97I1y/M2DbX0A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a74e837-3d6e-4a76-6816-08df2516b876
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 08:32:42.5676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4xLWnidDYotMAe3fgKhQzWT51di+lPp7g0Gb9G76UnpAh6zDK5QxZCF9/3hnGWq0zVLkmucyLjqJmI96yRzQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
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

On Thu Oct 8, 2026 at 5:30 AM JST, Thorsten Blum wrote:
> Use KVVec::zeroed() to initialize the firmware object's leading zero
> padding.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
