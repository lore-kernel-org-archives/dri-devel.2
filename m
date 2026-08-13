Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E63EC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711C010E36D;
	Thu, 13 Aug 2026 19:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aaijN38C";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114E310E36D
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 19:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK9ua2UX1BxmjEtGEIj/uxHSWFiBxAJxu81ZuBix6O8ankCv05axKmX6HU4OrAxqOc8ptSL2yOxjpSIW9r2eISl5ePeumMBTiX5xzFpK5c+WlMTylk7xITn96OQ50HEsaU+YLEOQbHzQqjTQu9uMGDBj6RRnZWQ4xBkYE1K7KZ/GFjaXdAQRiPJYQZzS82U+lq+gIlsCtNOI9I3L2MR0p5hBXA1gszENpqeEvasUJVaggZ9fxSfRCcsbsUtYhy6bUG0q8x9EJBBc/tO87DbsC5fvYKP+wr+Ild7OSXiQRIpfKGz36/jo8PTTk9ALfWmCJHx23NxNrt1GF5b9Pf9rlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Omx7RwUJjh789wUlmGCVgPG66x9kUT9LFsueGpT0tis=;
 b=r3c7OrfdO2v4tmoYlSTYKTOd4PR0uIedO6YUitoARkFc8Ua3SJYu/iWTZ2SmGQFFw8ydvZhmzT2Q8BTNyL78BN206GV6pKPqVguCEgHXwNYCdUOc7MYiW380zdYWHAviwIGYhIm6I435F9Zgp/9EC9EOY/wJdSku8hRUBv5g+qtdv2FyaJVMFA0k5yU0HW2MDnAfr8cNA5QmPA/Kg0p+IE33pqhKVrl3ZnF9/Jlc+YZT6XQ3Trl1AVBMpOEs5fYIujXUW6uvYYpAks8+W8kMts6uz8FYw/SYXKObTI4P2QOOrzdTR3ZVKYFDMJSQ6499aviP8//27WzCFCZ32vHJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Omx7RwUJjh789wUlmGCVgPG66x9kUT9LFsueGpT0tis=;
 b=aaijN38CXG33IYMmgQTFKFdQYdXKTVzc7Mwap0Drh9Rfu+TNWxtMJKrooV4QYyGeDIQONcPDTShTCDNDq9Gb7lf7j0RhQ1x53cJ2En1cG9bLv90gn+eE2gMeQeCoZyc88XnmRtPmObdIdw2/tt2WRbehFyIeAWGxaMHcFnYO+vuwTeb6GwPTklZ1hdkwR1wQpCUqBfgb45K4PIG7HoqcA/fbhLzhQltZHolcJixR+Pf5cLPR7JYuU8GCtYgq3ECsSpsIPjcN1hmLGTeiqKwCzRB38Vw7/Lfca+//sT5FtwCskqDBGXrYG8S/nGN6JtPuW0wRMZEzZNkjXhMZ5RWVag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 19:31:00 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 19:30:58 +0000
Message-ID: <aecd067a-e308-44b5-ae46-8f9947c9b44e@nvidia.com>
Date: Thu, 13 Aug 2026 12:30:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
To: Timur Tabi <ttabi@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 "vladazaharova2018@gmail.com" <vladazaharova2018@gmail.com>,
 "dakr@kernel.org" <dakr@kernel.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
 <a72edc5b-49c0-42e0-b21c-940e71909666@nvidia.com>
 <5efa940cf5271c7bc0d725b7f0df365f247f08da.camel@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <5efa940cf5271c7bc0d725b7f0df365f247f08da.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::25) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 10edf7c1-bb94-48c6-5e71-08def97166e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|5023799004|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rHGeMZ9PeAypwEQN0wPgQQgDjcsu9yiKrPNdR7QsT0COEKWuqcu7u2O2kNqskmC/8wAWdqDkYXovjZI/sE8O+LIEChIjsmeNbcz+1TgXF5VJmnQu6C6gEPOqhz1DaD+zndBHY1oxuIvQsSWjBVK07qTSmMyOXbGmtp1Umn86bpQP+lqdrlPej35ozTX5lJlJsayXTB8VUUMPEifpuSf4fce9smPtv1gscWoCggt55JntwalgyUoJsAA/RdXUZOyHnyeBdZlwnTpkqNQDB5dZJ5v5qi1QruO0X0aSNbMauz0fia1wSbvxLzo2QJX4IoUj3AK/SZeY46io/ykp7S8czLQnWUG76qL2RBBpeL3mwvaDToktOFnflr+bYEXilIXDHmF+hWChkAr2pmztPynGYoKhci3hZIsOFybXH+4GfJcwX0FVF/yzh8Cu23lrn8oZLl4wwdoIuPqQ5uHEanBW6+VxeatNeNejcoXfz5/OVzY9Yns5pPb+1qePvvKuEtcaETDxNN7IDgNZ3iGSkTg+STnts2/oz7S4q39eHhissgWxzMZZzoxv6jBt5mgpnjGhlKV+wfgWYpAb2qMIxdPP/k+6KLdIIhCdSuAEhwdAHvKnsiCvsMCItomHG8qKDAAY7Gi2Kz+bGkujHOuetBTbBY33MxcPPj6LSkase5NJN0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(5023799004)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0pmMWs2MnZPNFdBZEluQ0x5a3JGVVFCdlRib1NCc1dhd3RxQ0MvL2dScTFC?=
 =?utf-8?B?WCtoNzBhN3JoRjhaZU9tK0ZjZ0RrY25yVXNOcEkyUlliRmp4NnBwUk9mWEg4?=
 =?utf-8?B?dy9GOUJqdUZncXZqQnFuUit4by9zQ3M4dlM3dE9rSk9jaFovUUY1S2JQZDJQ?=
 =?utf-8?B?NUdpeHo0a2RxMnVCRG5HeXc5U1BCR1NONHBoWTlZQTQwMER6OWxKZWlzWWRq?=
 =?utf-8?B?cUxYc0hlcUtlS1RnTDBmVjZXVXdLeXZIL1UzWEd6eERyaDJwRU01akIxcEQ5?=
 =?utf-8?B?Z0tQY2VaWU1JZzRtRlR0TXJ6VHQyeDBDdk9aN1Y1Y1FkR1ZjYnBWcExjeDdv?=
 =?utf-8?B?T2JETFA3M3RTa1lpaFhXa0o5ckwzcUR5Smt5SFF4c2VzUCt1L1ZPSzUxVUNJ?=
 =?utf-8?B?Wm9uR1g2NE8wc2RsYXdadHhmVFBFTEFXTzhOM3U1M2dNY2VGK21nZU0yZ3Q0?=
 =?utf-8?B?SmxKSE5zMFNoOE94Mi95bmxZQUJnN3VINnhQTnRYRGNQdjRybm1QYm1JNWtF?=
 =?utf-8?B?Z2lYYzRFQUFIRjg3WExzTjVLb3FENk9PTkd4YytYMUZvYW00VnlNdktxOFhz?=
 =?utf-8?B?NlVVVkppbE1FZUNkL3I4VElrQVFqUmFoM0xGY0creUR1TmxsaElFWVZIS2Y1?=
 =?utf-8?B?QUhGQURodHE4MVNQdlNLRUtIRk1NcmZZVkNiNDBHOGdwSXFhNmUyVmwxNlZJ?=
 =?utf-8?B?NXpwbVlSZ0RFd1ZoUEpoN2NqODZBK3J5T1F6L1R4cWxzazhHazFQanVvQUt5?=
 =?utf-8?B?RlVIWisrU0dUVVFlVGdibk9tTFk4eU9nSFlMZG1jOHdXUUZGdTUwU2d2TmpG?=
 =?utf-8?B?YjVyK0hseHdxWnFzS0xzcmRPSlNsWmVKVW9qdEZoK3lsS3ovZEN5QWthSFlM?=
 =?utf-8?B?QzVORkQ4V1Q3T21UakR6TnB0cFRkMlo4blppUy9GVEdVbFRoWGxBZU9JU1U1?=
 =?utf-8?B?UUtkMDdwR0Z1c2VBcFZ5eGQ3cGtyV3JoWXlYTDFBdWFQTlNBTlplZVFiSHhs?=
 =?utf-8?B?aSsyTHEwL25WRThGOXEvdUl4MTZkRlB2cGswQmFnWlVOTkZRSVBVaFY0ZWpY?=
 =?utf-8?B?Qk1qVE5RdlNJcmtRV2grNHlNNUtBc0tzK3ZvanFYSDF3akVRb0JTNG50VUNh?=
 =?utf-8?B?cWJSZmMwVFUzZVdEQlZzdUp5eFVEYXphTGtNM0ZGSWtiRlcxVEREcitJRjgw?=
 =?utf-8?B?eDRCcDhZdkgyTGZncENrK2pPWVM0RjJVYng2K0t4N0ZPZVRWRWdVVnRVRDBB?=
 =?utf-8?B?TXQ0QkhwekFPWHgzbjBNZGtIRTJodk5UVHNXL29kWFpNcHN0YkVQY3hBUFVz?=
 =?utf-8?B?Zi9DZmE1T1E0eFMyeGlzMWxMcWdmanRxVG5aTUZmVTNZTlVWR05vL2d4ZE5Z?=
 =?utf-8?B?RlpPTW1MSDh2Tmw1NmtzQkNzdEdwL1ZRcFZrUUhaT0dselBuSU5mL09QZ0ZP?=
 =?utf-8?B?ZFIxNUcwVUhGZngrdEk1eWp3b0lyVGRtcGlWTkpveENoN2hETC8wVVV6M3FC?=
 =?utf-8?B?aFZXQTMvY0FXUUs5dysvSWJsYjdTaDdGU21EK1ZFRTFTMXk4QjRVTk1lQ1h1?=
 =?utf-8?B?L2svYWtQWkt2OFNIZUhnYW5KNTB2MEQ5RnRTWlF3UXc0Tjl2UmJJK0dhKzdn?=
 =?utf-8?B?K3VJejlQU1p1UUhUNXNyQ1E1R3JsaDJLZERMSVpBb0NLWkFuaTg1R2xXcTRh?=
 =?utf-8?B?V1MraHlhS29oV1BFTnFVMWRGNHhmSlcxMzZ5SkJheS8rSi9NRyt2MVdkaXBN?=
 =?utf-8?B?NlEzLzZTSUJQQS8vb2xvU1pXdjRaWWJTZlNMSm8yM1pvV2M5SWUwQU1xNTFM?=
 =?utf-8?B?Y3V1Vi96QkI0cXprZU5mR3dEUFdhUUJmSUxiMTd3emVqREJGQi9uTlM0NUVC?=
 =?utf-8?B?dUR1YmpJUkxPR05KZURiQ1FWY3FrMTg4dmU3Sk1JdjR1U0JzcEJEa29aTmtB?=
 =?utf-8?B?d3k0NjVUSzgvam0ycEt4bkc5Qk9aWG4raUdEK3pLUTRHSGYrMUVLREVycGRK?=
 =?utf-8?B?MDBrRDIvOTZZa29RdlBINms5Ny9DenZVU2IrVjdFUlZRa0Z2SkdCZnk5cGhJ?=
 =?utf-8?B?N0hOTVVDN3V0VFNraEF0V2dnTi9rdHhGRVBsU2NsTE5wUlh6TGZuZG5IM0xL?=
 =?utf-8?B?UVhnSVpISkd1U2UyTk5WeTZhYWduU0R0djE2QjN4OXNHaFgxMmZTNW5pTHhU?=
 =?utf-8?B?MTlGcVhHMHRXdnZ0MGo3MTVnbTUzeklYNGh3UnZHMS9qM1BDUzNxMkNON0xy?=
 =?utf-8?B?T2g2cHlxOFN2K0hweWQrU3pzNjRwaVhQckNlcXhBeE40UVJ4Z2t5SW8rT29m?=
 =?utf-8?B?NXcvVm5HNCt5N0M2S0Y5Vmh5L0NVTlE2OUpoTGpQTFJoMEFreitYdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10edf7c1-bb94-48c6-5e71-08def97166e1
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 19:30:58.7701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4GTlpUGA075rbj2Hkuzsipc4uH8jbARD4zYxDPV8LztcA1udj0JWI3OOn9tYs9dXLrksr1Nt9TzPjgLa9o/zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
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

On 8/13/26 9:29 AM, Timur Tabi wrote:
> On Wed, 2026-08-12 at 15:41 -0700, John Hubbard wrote:
>> And so should nova! (Except for the strangely worded "keep_gsp_logging"
>> param name.) See below.
> 
> The patch set that added that parameter to Nouveau was under review for months, and no one had
> any complaints about it until now.  Regardless of whether it's "strange", I think it's important

I'm not keeping a close eye on the nouveau list.

> that both Nouveau and Nova use the same parameter for the same functionality, so Nova should
> also call it "keep_gsp_logging".


Completely disagree. There is no need for these disparate drivers to share
a name, especially given that a better name is available. I'm quite
unhappy with your continuing efforts to add artificial constraints
along the lines of "nova must match nouveau", tbh.

Nothing is stopping nouveau from adopting nova's names, if that is
desirable from their end.


thanks,
-- 
John Hubbard

