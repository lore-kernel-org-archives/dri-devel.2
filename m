Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B213C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA1710E6FA;
	Mon, 29 Jun 2026 07:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="moem1u7O";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011004.outbound.protection.outlook.com
 [40.93.194.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6421D10E6FA
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSr7XJmtUy4wcFrO0sox40FXe0GnZhdkKNeCZQ0vEyPmdeR0u3tdUKuelbHle2p550buQS0wpe0eNJ2o0pFntk/fcdeABZPeBXnY16ft35SNJL8COlpuVyCnCDrq/pW7N/khDA5YnL9bbEtx4ssrmeHcYhcgU1wDJMmNIBR7g7Mxklkduq0Rrc4i72KdOS/cIfVH8lDtfJcdawNjjRnhzhsccbmF8M09I+kiwRCIi14u2B/fdp72qwhYo6nIT0fbIlx4aU40ZhznYL1BlHINlxPLOGi+PuwyClhlCTE7wxCTXpPZAPRGpuS51N6ML13yukRG80Bc0fkOeetBhvVfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxgzIuEY3lRHTX1pISZhbFXHtP1ZyczjeCRXmt7PT0E=;
 b=CnqM8/XtxiEnUsou7m5uQVRV0mrs2xH8SszBWH6dAhpTIY/8vY9r0xtJOoljlewORvSF0UVVGCrqjptbxMEeC2cFLCAbkhJnqhH5n9QwB4DZRSMZqEJ6s2MukHY8mKgNDw6sM3VpaO7LencQibwvfYmHBZVNDEIVC32yTCkG+CvMPcKt+lsXUbf2hBHlUWpGomEM6OPr8xAMVAI+vEUPuUPgPDp8QocKTmwcy6jlDZAG79nEDubmXWMaSd94AA0ucKY9OnUXScA2rvh++znRhZ9TqQ8YHHy9CCRuMsaozJZbEC2M9tNIsCGoDIGH/9kX8uo99hgUM7ksGmZIYlMPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxgzIuEY3lRHTX1pISZhbFXHtP1ZyczjeCRXmt7PT0E=;
 b=moem1u7OwqKRdy4BU5rYzvWRXskFmRIObdMavEIBudfGyIvTsA+ahxAxZi21rozIFsEMrsTvCWazM/kg0VsKYiOrzBWhjW6WuEKpaT1LMOZq7sDYu62iUx83ucKDtH611Z0/o3aQZVtulVJ83IL8Sxd5+sMkhhug/XdaHFi+czhBw3zLVF6sRSOsvWTcN4JlcaMgCXO1KM0JsiPVWKMA35xSEhq+ek2/Ktj/5Pes/iZ7KKWMN7XtN2wFhGGErHdRyrRHPyE53HPAopfVQHOjmcK0gF3YJpcASABDs0hNDTUrKF+Yf8YVFhjBBnJke9ricH1ip7c88np1jCulBIahEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:11:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:11:01 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 16:10:57 +0900
Message-Id: <DJLCGEB0ZTL7.3C1BGJRHW35HC@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "SeungJong Ha" <engineer.jjhama@gmail.com>
Cc: <sashiko-reviews@lists.linux.dev>, <ojeda@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <dakr@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>
Subject: Re: [PATCH RFC 4/4] gpu: nova-core: gsp: convert GspMem to zerocopy
 via the transmute bridge
Content-Transfer-Encoding: quoted-printable
References: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
 <20260628-dma-zerocopy-bridge-v1-4-9a2895ebe30d@gmail.com>
 <20260628172200.B116D1F000E9@smtp.kernel.org>
 <20260628182154.712621-1-engineer.jjhama@gmail.com>
In-Reply-To: <20260628182154.712621-1-engineer.jjhama@gmail.com>
X-ClientProxiedBy: TY4P301CA0067.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: d5523aba-8fbb-472f-f299-08ded5ad933e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|1800799024|366016|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xI9SIEtNfwY1TaSzvpKVA90O+2tq6RucbpXreBYKKdfgdHdH5n0sJKatqJq+yr1QCGmXMO1r7RhuWK8pJ5SqbMnm2Mcodt5NPFOoe6we8BGEZ/ivnie+ik7aDH2Lz9uRkEVHFSZzn1cNp/l89a+Xgwm6mMA8H/tJZC7Xo0PgM6EdYBF+3kOgonGVWgm2b0NiebMp3/nkSHI7Mp0aA+OVXW2ksM1dP8S1y/cTN/yeEUAtpX0kLKlhGOH914MltNmgbqV0qbIbh/v26wnS5A3GBreWN1XwbEO2qKv1R85EWAnp4+LhGR/Nq62TaQ5KBzdv+iB2tujHcZHk/P9E2Fhpd4iLT0KFIUOMQnTM+q7QhKrIN/jzAQBe5aUOJG3xeSIGs9mjzS9FH+H6eGfcoolzPeQmpVCuNFb0s7PNA9Iv6dXRisaSIgR69dVdtHdNcVN45Z/woc4+vb/0cfBBLLifVxKCL0ZEKKy1hfQtkGRCXJ0FmvslgXR0izGdUb72ebQP04At3tliCxe4x0FhwQqSV+sv6msYYUHA/K+OylPufHxPQdpD0v3Rt0fTkoVNdfAlbZCFCRrAciw7hiyouqf819jgwBTS3QtxijijGrpfsrrz33sw/q2RygzNCymcH/27qSeAlJJ4C41yU98cZCteAFBTuXo4mzh7iugNGl4H9kY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xMTmMvaHFHVVdTWWpPNnNFWUx4R1Ezb0NPTVozYWdoWHBjeTdiZ0xyaHBo?=
 =?utf-8?B?RTFjU3d5dy82bXp6UTdvRzRxbkdCY1BMOXczSGh5WjNjUjB0UHpGd0NDY0lH?=
 =?utf-8?B?WTF6eVJtb3c5SkpoemVzM1Uzb09kUmxJRUFZbEN3OUtMd0FHbEx3SEpkYlZk?=
 =?utf-8?B?aURVK1FOdzh2amo3c00wNDZYR0w2UTFmSW4wRTR2YXpBNHE1Nm1kbVlDSDlQ?=
 =?utf-8?B?YnFOaGQ0cUp0Ulp2MENUUkQ4ZUVrU0RqbVFGbk5hVlJ1cVF0eU56WE5JSFdM?=
 =?utf-8?B?KzZSRzFzQ3hUSWhuOUxROGNXdG11QzBnbFE2TzZsUWdvSlBqVXhVSjhlZWlo?=
 =?utf-8?B?WGNTMHB5ZW0vZmJFSGtEbnp3dXBvYWZ5UU1lZnRFQTFGaFBJcWUweDlVM3Zr?=
 =?utf-8?B?K3FqR0FCRGlXOWMxell0MVJpcDF1aG53VlZORGtCR0UxT0YwaHdFdVpudjBH?=
 =?utf-8?B?VTV3cFgxR294N1lrT3RqREErZUNjNGxQdG9vdHVzVy82azY4TzJsODV5WHdz?=
 =?utf-8?B?QlBqOXdnWmc1WDJma3B2QzZmeWkzUFZYeGhaVEV3MS9NRTJSRWlSbHErUUs2?=
 =?utf-8?B?cDdjOURyNVAzc3l6L0hFbFhTeStEUGgxRjdlOEVzY2hjaGpNK3JrS0pUMW1U?=
 =?utf-8?B?bFJhWEJaWER4QWI2bXNVUFNMbnRlc1NBaEZnMXhISEdIZWVGMHJSUHdNK0VI?=
 =?utf-8?B?Z0JGRmtRdTkxOG9mQTRsVUl5NkhjZnplMnozZlhCeWZaaFhvU1JsbWNiQlhq?=
 =?utf-8?B?alYxTmVIaXBpSE9aakxRcS9Xc1I3ME0zbzd2VzJ1cmdiMWFQd1RYMGZabVd2?=
 =?utf-8?B?WGpkdVJ4NW41SDk4eUdMd2VRUmE5VDFNNHdTY0FBNVZQNmhGbTdpMHgwd0VL?=
 =?utf-8?B?TzBlZVU4SjhlNUhqb1hyYjI0eDRlSDFuTTRxaEQ5OTFJNjlaUGtMQm5HZm5h?=
 =?utf-8?B?QWVMbk5mQ3NFWHZKSTBmbk1WeUVhSzI4VURBSktYYVNCcU5SYzNGdTZwdlAy?=
 =?utf-8?B?aDRDT2crbDh1RlNndnROUWVaZVBmZWh1V1k4ZFVCWUZoa3F6NVFXWlRmd1hw?=
 =?utf-8?B?YTRnNUdyK0pjU2ZlK1dNSkJPSTBhakY2N1E0TG9KVWh0Z3M5Vk5FcU5VUDFX?=
 =?utf-8?B?ank0Yk1tVHBQU1h0OWg5REo1Z1cvYjkveGd5ZEVtbGV3TW4zQjFsWHdPcFNs?=
 =?utf-8?B?WVZYSWY1L09VNGZlYXUvMG0yYjVkRUdjZmpreEJUNDFnRHV2TmZNR1o2dFA4?=
 =?utf-8?B?SHpicDk3TVNEdnlRKzNOdS9qaTdGUExmMWRCR0svMzRKemJtaGxhcFNHQk90?=
 =?utf-8?B?aEI2TkprOHVUYnYwWVJtS2w0bjA5ZVB3SmVFUzMrZjdsYVFuMXdVNnF0ZTky?=
 =?utf-8?B?ODc5UmtZTUorMGlWMWNTQnRCUi9VazJNOFZZeVc0NFNrRloxMEwrN2FLSG5T?=
 =?utf-8?B?V010OSsrVzVINTFVS0cwb0FjQ2N4R1RyNVBCbmxmMUpieGhQamlKNTJnbWlR?=
 =?utf-8?B?aXNwUVRCYTl6eHRmZXp1QU9qcjU4enhQOEtpV0hQRkR6b01zTXNVMDFJeTZX?=
 =?utf-8?B?THVHakJrOWhXaHpXL1NqcEQxekxxL0pLSGxhVFkwQlRrbDJhK0NkbjVnbmVF?=
 =?utf-8?B?cTEzTWdNRUJ3YzkzN29pVHZnQkhDa2hselN2dFBuK0NzTzBiY0xFOU9CbnVv?=
 =?utf-8?B?M2dlY2h4RWdPVENwWGhwcEtvS0llcWd5dGNMT3dHaUErM3pEV1R2WnpXZXV2?=
 =?utf-8?B?YTBTVjVod0V5TmthZWs4YkNZSm1xaUdEUDlPZXRtOW9NWTQwMzFQTVlSVDBM?=
 =?utf-8?B?ZTh1THI3Q3BRbG1NR214cFRTck9mNnpaOFc2RzlwRyszVkxrNkxJR0s0c1dm?=
 =?utf-8?B?UUFMcDFEcGg2ZGFQZkhpTHRkcmR0MldnUkRFSTVXVEFWc3d4Y3FMWHZmeEF4?=
 =?utf-8?B?UUkveVdyamY5dnVPOENxRGJMcEhWTEFFeHBLUnhoeXBDRWZNWDBRa3Z0ZHZW?=
 =?utf-8?B?SXVNdFB0V2tXa0hmZXUxZUZ0czcrT2F0bzlJYnQ2Uk1Pd3JhaU5YTFRTWStC?=
 =?utf-8?B?LzNTRXdlMWY1bkNNajZIY3VBMW9iNCtQT1U5aDB4WEFaTXlUVFdnZytQV04z?=
 =?utf-8?B?dHgwZXhiSk1Bb3NXNHRiaHo1YUwwc0NuRUFrN1MrSW5VRXlDM1BUVTJ1RHFE?=
 =?utf-8?B?eEpJUzAzMEFkV0JoMmlaaWQ3Wkt6a3IzMkdMVU5HYnBmTUZJTGJ0NThUTDQ1?=
 =?utf-8?B?dmNIMXpuUU80UTJBNS96YjJuRUw1UGtWM2xyOE9va1JMTHlKTDMxNDJQT0RT?=
 =?utf-8?B?ZU9Jc3dsejB1c1hHWXlpNzVpL1FKY0F0R0gzWElvMVkzTUpUcFB3VFFZQmlv?=
 =?utf-8?Q?dIMHscE1etoR2dDFCmX2PuIoiqLniLu9d+Ym0qS2prjWq?=
X-MS-Exchange-AntiSpam-MessageData-1: N/ZsM+ebQQAdVg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5523aba-8fbb-472f-f299-08ded5ad933e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:11:01.3435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9oK/ojMy2xdCFSJ/7dl2w8FeSPlISCA06dGGTJBo0WzPmBVP2oasXwrB2jiPXFDBLG90Yh0dBQL35oJ0ld5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
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

On Mon Jun 29, 2026 at 3:21 AM JST, SeungJong Ha wrote:
> This is pre-existing and not changed by this patch: it only makes
> explicit (via a checked `zerocopy` derive) what the previous `unsafe
> impl transmute::{FromBytes, AsBytes}` already allowed implicitly -- the
> layout is byte-identical and the message-handling path is untouched -- so
> it neither introduces nor addresses this. I'm not familiar enough with
> the GSP threat model to judge whether the TOCTOU is in scope here; if it
> is worth noting, I can add a TODO comment near the affected reads.

So I understand that this as a copy-pasted Claude/Sashiko block, but
would also appreciate if the human behind the keyboard could provide the
context required to easily understand which part of the code this is
about.
