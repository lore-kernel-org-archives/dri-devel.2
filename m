Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750531088E50
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 23:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8688910E06A;
	Wed, 18 Mar 2026 23:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bRup2inS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D3010E06A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 23:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyiKKya4plDtAns62YvRDQxcoPxlLyIjbvVMM3Ib7t2uVrkY5Lv8MAbqsjjTejj39rKnrVBWKwSn9AiTsFC1lAMgsa60Ri/NLMxkiIzmNNTJkwuzsXIPIbpKlHmhD/dSIEzG4XPRaNVsOQ5KYdORQdAfi6izRTtw+cPTp5rjnpfpAMOVKS36GcqGBNPlt76OjYt/4hDBT4jstN9lqB5dqtmFZ5nEfZsQpElRQBEGmCrwQVyG9n/LmlIlssRcYPhrifrCxhFJGCKLEXzebYMqm1K6roFi33pJuFW8G7XAW5YuShbkl22vnNDQ3rsRouAYSR7ofB9YxUryRP8PU5ROfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCHWkZByAd0nW/H0FmbtKBsiawPAJc+LG6BN2MwG40Y=;
 b=Rqe5LbX35FeFd9rPvQUPYxQYeI4Mx8d8PCvsEeEOoqwcPXp7D7we1AYnJ80syG0507Kyn1Iy9Ac3eWBhhCZGc8PGYgcvyO7KeuXUdTM4KqLiXUvNwmFN5L0rbBEJVsqK3Ogv7X5oIQ40Pv+qrMaN3B2gWdDZSXlrNymEW/lJZc5l9Fb05m2hu9j8kMrge2eOoNbJDC4KyBPTUhYMR2gkXLyu0u/zQIcIDZVTN3ezmd2oNoVVOVkW/3WN1/KAd7o5WDBDCFYY0+Sa2vRzinjtV2Qz4XfDQr4kK3ULw/Rza1xiZk8k/i7uKV9EMJBDD5Iv5tnt+iixjkuy9EHrExWfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCHWkZByAd0nW/H0FmbtKBsiawPAJc+LG6BN2MwG40Y=;
 b=bRup2inSgi04PKyJGCmUnj8m04xMfEne1rqiYZm3CPqA8bxrBNryQoqcvXdvIXPhFTQBIrc6goq1StnDRVMoPPaxWuiK9rzdmMrn4haXQwjMv0X/ijm6dZgEpwX76iMvTQueI6cgEzelpkIy1v7sF7yAaM5bhDCjpo9OFuRFeGhXzgm9tEgtO5JTt8lJPV+JhWS+ZYYQQabaEgvrsb0vVqqNOicc1yxSsSHNYtBsF5/HRkmDseoZ181kX+z/ZkmY9MUqKs9N36YpiIt3umJsZEoSV1zd7O/toByUReDLGnrTlMFTVEGEFBZDCyFFN7XIpXQCtb5NnfEi5TORhOxW5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 23:21:51 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 23:21:50 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 08:21:45 +0900
Message-Id: <DH6ALL1W4RRK.3H921XS11SXE9@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: gsp: add mutex locking to Cmdq
Content-Transfer-Encoding: quoted-printable
References: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
 <20260318-cmdq-locking-v5-5-18b37e3f9069@nvidia.com>
 <DH60IMOXP3O2.26EAXOW3BC7S4@nvidia.com>
In-Reply-To: <DH60IMOXP3O2.26EAXOW3BC7S4@nvidia.com>
X-ClientProxiedBy: TYCP286CA0051.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e1168c-f71f-4e92-ad9d-08de854521f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: XtxbE+eabTIAzJpIpHDl8s0MWkFEb6ePhdqAaYLYj7q2XUHQ0eEasJf2u1BXhjSXq0mNcvvhGUByg9tOT09ccBXI3JtzkPo+pKja1V+tj85FeKztg6vP7v4ZD/9JygBtpa7nVCZ3O0XZuKRptTnVBvFKB7Xolzd0x92/RWO7FDZCbOyoLoYs0HRR4f9A3kfy9M+dOU+jT4eY/GbIaWPyQqr0MCOiOylLwwj9v9MNmeH724eugUaFi0Z0JM1b+k/43ZpbmxgaAAco1ZvNFlgXBjRLO8sTEE44Qm3X/LhFJFy9Cyx06+XvB7RLk3H9aVxyc9wpPaV0eXusPAAjOeKLmJv/j3l1v6k4AujuwmdW/a5mv8RuZTBlh6YNiIyG8ijhyx58Ykn/oRWCrGJUSNnNv4e8FqQFgd+27paXT26+Vpq1pCJ6EPUftcVP9G7VptcsIAYK1/ahJKNb9u+bjp42GovmZjC+h8afmxrV/x2hiajR7MHCmGUhwzYm0tNyC7SYzMzhe9QNftR2Ab/MX8BtBa+Pu2x/eLimMZwHONJO7k2rTMb871Gb/VV9LtJZX+B+D9JnVjOxrNFfTvpVw7RlHh8vbdOvedFo/Hz+Ye6Hc0GUmzXQHg8qbsvtjO9+p5T/sf/T8Ml5XooabU3B83tFShyp6KZOyBhUMe1wj+a3aa9QDmJD7qpguRXn6hYBNJy44HJ12nkzyW4UKjy/qPXU0h4QaAcFx4PHLUnRwbGDJVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am0wUFB2akg5ZmVmRC9jT2xpa3VKbmgwKzRnc21iYS8rQUJaQ292MWNSdTJu?=
 =?utf-8?B?enh0YnNONUNmdm5tMkJsK0d0YmVVaDM5NXZYalBESUI4UW5aOFpEZmREcnBZ?=
 =?utf-8?B?ZGFRd1dpbkJGbko1elpCVHIvam00V2xMV3hXWnE1K0U5eVlJRkRRYnQzdUY0?=
 =?utf-8?B?T3RZa2JXejN1ampnSmZHSUxleWFnaUovWVVqajQzVjhUN1kwSnhGUUJRYnJS?=
 =?utf-8?B?S1F3WUhNZmVhNnJpT01vVnMxYTh4MEQrZk5qTmMyK0J3MU9hMytDZlg3YWZH?=
 =?utf-8?B?SFFQazlGTnpaYzNXcW1EdkF3a1FqL0NYQjdBc3kvT0JsbmMzOHN2TW9UK2o5?=
 =?utf-8?B?MFQrZWJxVnNiRXhLSnZ1dVJjSThjS1hOZWY0V0lEL0VXR3FPZjMzUHNUb3ZR?=
 =?utf-8?B?c2orZEg0aHZ1bGk5U24wLzJmRXhFWTY0cGp4bzNaa2l5NDJuaWt1ZDlzazhN?=
 =?utf-8?B?YnNTSkhoSkJxZEdCZi9SVXhzQ1JPRHFmRTR0aFJ1S0ZlNDJsRkdJOUZESFRB?=
 =?utf-8?B?cHhXbHVqT2ZPT1J5bE93WEpnM0czcWlpRkVlUHFUMFVKMGlZYVRHeDZjSGpr?=
 =?utf-8?B?aGRZbWdaWW8xT2NPTWtmSmFwSUZVQWVtTFpPQ0NPL25wcWJrWVh1Uk1Kalh3?=
 =?utf-8?B?a01HUjdjR1dKY21lem16QnRyMElsNThpVWwza0M2Q1diOW5zMXgxcElLWUo2?=
 =?utf-8?B?Ny8vTlVMZjdzUVVBVGxLK3VrVG0rNEJML3NBTU9maS9IQUI2UC9MS3dZNUQx?=
 =?utf-8?B?UmJyd0l3Mm9Sb2NFTTk4bWMxa3RMYzhjQ0tNYUdTcnZ1QmtlVER5SDFwWi92?=
 =?utf-8?B?bjl2VDAzNUU0SmpZODYrc3VaVGM0cTFkZDZYT1NPemFyZFRwLzBSZzk4Qy9w?=
 =?utf-8?B?eS9hRm9YeDdMRnpzalN6TUQ2a0ZYdE1Nb2pHU0p6OXE5ZlZoWlk2eVhNbzFQ?=
 =?utf-8?B?TkdIR2x0VjRLUS9jNEUxNGpEUyt0bW1xMk5TRGh3STBzRHpzcnBLL0FET3ZM?=
 =?utf-8?B?cUNOMmZoNlU5MHphN21GNlpjbE1wU3lQYVRjZXA3dWFTV3ZIOERSeHorWHFk?=
 =?utf-8?B?bCtEYTRWRkRTdTdVT0FVenYwMkd0U1FQR2lvbFpQT2VLRkU3Q1BaTUNFUzRt?=
 =?utf-8?B?TVh1bXltdHZ6cUh1aDl0SUtZamZSTXdNa0trc2t4Nm5VVUJIRFpUdVNFbUNG?=
 =?utf-8?B?bXZJczZTekpxdmZtaFNDY3NHQWs2T3plUWIzZGlGQlFtd1pIejFLU20ya3lw?=
 =?utf-8?B?MTlrVVlieDNaNkIwV08rcG1sTXo0bGYzQVNKc1pNWmFVOFU0MzQ1bGRPSjFx?=
 =?utf-8?B?ZVowRlN5ZFpYNVZZa0pOVzU3RzZZWSs2RlYzdTdUcG9WdzJvM3hPMjIzNkRu?=
 =?utf-8?B?eE5hRk5hOGlDekU3OFJUTEN5WVFqK2ZYcFhGTnM1M296NkE5V3lxZ0xsU01Y?=
 =?utf-8?B?YW1zWDlsaVhoemt3Szh5d3BYci9Gb2c3dWNDVXg3dFo4SWR4WU4ycU8wcWc2?=
 =?utf-8?B?cDVjcWZEeFliclc5ekdnS1FSUDc4MlptMzFScysyZXZzTC9WSVRjdUtwSTkw?=
 =?utf-8?B?b3FpK0RnZUhWdnF5WElsWWQvVVZmMzBsMHg0NzZBbFI3cXlRYzV2WVQ5eXlV?=
 =?utf-8?B?QitUcGY2NHFlMUtVdnVsdkc3QzV6UjVzQ2hPYXZ6eUpKOWtrTmdnZUdNQjFK?=
 =?utf-8?B?ZElCd3JCRTJBL3RYaG1xZmhzUlVUOW54ZWhKaGJaU3k5M1NFMm10R21DdzJM?=
 =?utf-8?B?OUpKMzhveGdRNllsY2xoamZRQWo4ZTRKZXpDRkczRDNtbXVDa3pJUExSMS9M?=
 =?utf-8?B?bXBpbDhqb1c3KzYxSE5hcTljUkxlaWViM0NLUXhZNjI3QWJwL1dlMXNHOGZD?=
 =?utf-8?B?amV1WXZCKytkd3EzbUVKekJmMittNlJPemlPeXFuOWowNTlQWlhPRFJpYXZw?=
 =?utf-8?B?Z0pDNmRsdVBxaGMrVGNIWkZQbVRIUjN0N3BIL0JIR2pDd2ExaGY0anVRYW15?=
 =?utf-8?B?ODc1VHVNZ0FWM1pTZnBhWnQ3anUrZkxmY0Q2OHZqUG9SSzYxL0xneXY5VGJS?=
 =?utf-8?B?TXJ2ZE12OGtKWE54VXZCc3YxakJMYUdzQjBxV3JiZm1SVXhzNFBGOGNqZXJy?=
 =?utf-8?B?MzRIdjBHMWNhU1pEc201SDhKKzc0L2UxbVFHZzdtbi9HK1BQR0JITFZ1ZXlE?=
 =?utf-8?B?QUltTERMdzVhYjdGT29TN1YxT3hwL0grS1RhbVZmN2tGMkh4OFNIYmNzVWhC?=
 =?utf-8?B?YlQrdWZrSTk5QlBEMWoxUk8zQzMzOEtIYU12Tmo4eGRqUXE4V0V0RDVBaXRk?=
 =?utf-8?B?TklRWGVub1pjOWxoY2s0bEVWSDBzYWNsTUo5SGJrY0pCc2VQWCs2WjVjNHdt?=
 =?utf-8?Q?G4jQqVBf0T8IhBPzGwEPCEOyIM+yandqppKGfVJUYUdgf?=
X-MS-Exchange-AntiSpam-MessageData-1: giZIhgNesc6SAA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e1168c-f71f-4e92-ad9d-08de854521f1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 23:21:50.6910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EP7i7LDRt3/ZBpBCNIdGEhT1FLfBXJAELmdZZw74imPvmOxJ+zXEF3nfOStxWY9OIfv3TWhMSHKm8AwVDzKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

On Thu Mar 19, 2026 at 12:27 AM JST, Alexandre Courbot wrote:
> On Wed Mar 18, 2026 at 1:07 PM JST, Eliot Courtney wrote:
> <snip>
>> +    /// Returns the DMA handle of the command queue's shared memory reg=
ion.
>> +    pub(crate) fn dma_handle(&self) -> DmaAddress {
>> +        self.inner.lock().gsp_mem.0.dma_handle()
>> +    }
>
> Just noticed that we now need to lock to get the DMA handle. It's
> inconsequential in practice but a bit inelegant.
>
> Since the DMA handle never changes, and is only ever needed during
> initialization, I think I will just insert a patch before this one that
> adds a `pub(super) dma_handle` member to `Cmdq`. That way we only need
> to obtain the handle at construction time and can get rid of this
> method, which keeps the public API focused on message handling.
>
> No need to resend, I will apply this patch on top of mine and merge.

Actually let's fix that afterwards, what I proposed above would
introduce code that hasn't undergone review, and doesn't reduce the
number of patches in the series so doesn't bring any benefit. I'll merge
the series as-is for now.
