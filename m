Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6E3C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 01:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D4910E139;
	Wed, 26 Aug 2026 01:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sd8eByFi";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBAC410E139
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 01:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g12Ph98e9AgtkHL9knpdo0PaxJ12oNo0FbMWWkyHZP6b33QApEpG6rjRFIHFP37StoMMNc3g+FYkES3csKPm5IZ0HF4XV+3KCJxyvI5JDREcLkj/Aj1QsYMfYMO65KmSd/IEPDpJuKUxEfeYdJarAzc1I9dY3iljN2I5jaRMSIgtokPzL1l8FTUdfQtuzE5xtBfxpatL8nRQ32q39iUkenjdRud5Adk593Y22TI/eLhS3Gh6wxhxGX64o222rmZdNKrO1hSOXgcE1rdXrRfOlqaUjGWLXbhEPkQ+xHlpOJYt7+XbxolAnYuVVkwx2RLCEfns2Wjlp2LAmbhnn3+qmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plhTbG9DEnPlUwU+KfYwMm4e401cUgnCjVMA60SZwdw=;
 b=GXZNqW2u9sCzaWkYM9DzBrf3Ji7cPrb5f3Vid+gZwBPCPUqjPuNvj5DMsSnDJBmzYuKsBzluI1tEXFkBZtnu8VusChToL0XNcLnHcMakDFwzDS+rf2ouXKz061SmfjSwnRYq6GY/f0d9rtznB0S1uoGm4JeRk8Nk9ElhSVJ+STZhf1/Ykc5jjtf9JVw93dEeh/vaOA+tVHYEFu7eHNR3jy20HrFMv4H9L15GVSpTyqTip0DDfls5eP13WSs821N1mVASIzJl12j3r7S5A09jio4uTOVMnKRzsHohPE7KvkvBio+EVilfIoPbXCD+cPRDINUmd2DWtN7KNgNq1zFaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plhTbG9DEnPlUwU+KfYwMm4e401cUgnCjVMA60SZwdw=;
 b=sd8eByFiah98nH7oqj8sZJAbLt0Y/J0XSAjXYvHWWuH5+Sz8AGJiXWIbgIjgls4RHzvqJSpN6Ehf0nimn0TOol2WEg8sAjpPSrsESVEsmJkSlGHxTZhTkNa0ThNweVxeAe2kKZWQegSPOm4R6FoHnzdEYdC252o7cmK/siyFhc37498Jzz41Qa/j+x1Z57XiCjm742EQ6dG2+xHpJBjMiy9BHvVeJw1vlw9AYk9ZafZteSnjFYSPYfs7l/vDAVFoVgaFPFRhFnDrdpaVzFZH7jh9aFaGaDEUnKPfBOuJyLpbmzqe2IbUGG7Z87oeK23shhAwZAgXu8XEOClRKgG6Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.6; Wed, 26 Aug 2026 01:41:43 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 01:41:43 +0000
Message-ID: <9ff4d5cd-527e-44dc-b42f-ebadfcaa5c7f@nvidia.com>
Date: Tue, 25 Aug 2026 18:41:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] drm: nova: Add chipid enum to nova-drm UAPI
To: Alistair Popple <apopple@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 M Henning <mhenning@darkrefraction.com>, nova-gpu
 <nova-gpu@lists.linux.dev>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-4-apopple@nvidia.com>
 <CAAgWFh0VvY4D=-Se+bVO1YonRNFEa28nc7+ZbxEbv6en7oPaDw@mail.gmail.com>
 <DKXF49DF656E.XB24SXGL3RLE@kernel.org> <ao062w9fdaQEEYHy@nvdebian.thelocal>
 <DKYBNF427ALE.1OFETHRT4KNHK@kernel.org>
 <ecb0dc71-84f6-4a0a-8bcd-d38b194630d3@nvidia.com>
 <ao48Kz_vDm8Ogg9n@nvdebian.thelocal>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ao48Kz_vDm8Ogg9n@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0233.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::28) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 510a6286-9d12-40ae-6eed-08df03132e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: m7bVOLcJeGxGA0yJQEPflMOpNp7Al7+QCE9tBmG38wto2qdOu0M2DcqVKkvVG12AEJ/9pxNVcD+SSnB/Y3QfWrh8pHYNOF6zkisx3bNAvlPdoHx/+1k/4in1xxYbm5s+0eULEJXHqCx7vZJTXIHUSppMBNhjIUfocbusEFQQKgIWhSXpdG3C2za/XC6choHZa0Theq2h+Tkyh4RB4Vkbd91Qedg0G+4GkGk+luvfc96ls04QLGG/IzxU8T8/Rh5uO9YWl3Iywfjm2hvsMZG/0ET7l9kDhTiReEX9Xtjn3M7tb2vM/U+RXZW38kxcqSiTx6VfJO2qo+OfB0QotR6qpLrvEg6m9qY9v0bnvOsXxVvbAi0kH/WaqlTfWm8wf/cDx2z4UfbyD1Ne1pTWqCVi1RwOnUowFL6EKJd3AnJnS4IH4+CI2NynjW7lKf/eAd30g6Iag6xzCFn5DLrKjBfLkeNCzPIbKQX0QbI98WrjfJHrMahVm16132ujKmA6zwypaHyBtbj4WxTXHze0/IALSloaY2WkPG9wGBjawy+84qc/DCtSlYgyrdY982l4Cp+7B9jXahmHuUbXyLUREpzSf7NThwPgFF9Mitd+F/w2bvsXmaPvSZr3nSCuYk5B2XHDPW4yTNhrQ20fO+Cn36ZGmYSau4rOYLIPBmqaUlhHP1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elNMNTBxTkVhNDFBMXAxRkRXVFZwYmdZU1p5VFFvOFkrQVBzK1hUOWZOUGRS?=
 =?utf-8?B?UTVqNWR5bldFdWhCTmZrTFZqTFN2aTlobjlUeXhRM0MvRkRKbGRRZnMxZWhj?=
 =?utf-8?B?Rk5vQW03YXJxV1k3YlJ2Q1E2U01ZaEViZCsyRHcvaDkzdmUzaERxdThZZFho?=
 =?utf-8?B?OERvSG9NK2U2eGhleWpvTFJIckxwcU1yS216UjFlNW95VlpDUFpDcVdEQ01p?=
 =?utf-8?B?clJsYW45QjNFMmR6R29KaWtUMTRaTTB5Ym51WHZSL0hNNEVMZVJlOFUzaXFX?=
 =?utf-8?B?Mm1QU3pwQ052dU1ONEhvS1VYV3VjZ09Xdi9wZDV2Ykl0aFpjUEgwTUxCVkpT?=
 =?utf-8?B?NUlDTnU0RUw3a0VSYTBqMGp3Z3JRTFRjcDRPU2ZPODlwS21XdXBMN0o0clhY?=
 =?utf-8?B?K1F4OFZPdVNMWlcxcVZaMm1mRHBYS3ZycHZxWVBwS3A1WEFnM1VGbXNlWkla?=
 =?utf-8?B?cHAvajJHQWVkMUNic2ltZzJnUnN2MXJuRUdXaHVLY0phQVhXNWExcmxSRm1Q?=
 =?utf-8?B?RFlQRjNkT1R4N2RlTll4WjVaZjIzaHZIb1FNUncyWkhPQWF1TXIzV2t0MUlY?=
 =?utf-8?B?Z2JjQ0tHU25JQVFtUUxFZWw0MkdmdTJDOThVaEJ5dDBqcmtLbGxpeXU3SS9p?=
 =?utf-8?B?OGZGSzdjOFpmZDBCeC9NQkRsL1RPei96YnpjRk1jeEFRYXZXaEM5bVVsUW1y?=
 =?utf-8?B?OXhsbkpHOHkvL2NtV3FycGpDcE51L2xyeGU1dldGWDYwek4vN2gwR2FtdVRj?=
 =?utf-8?B?cFJVdWxBbHI1dWk0bjBKRTUrWm1CeUUrSlgwdDBTWkcyNjIrUzRibjEzencv?=
 =?utf-8?B?dkNQT1ZsdzRwbWt5QzAyQlN0TFFoZng5NkJMdk5hSTE2TDN0bnhCOGQvd3JJ?=
 =?utf-8?B?eVJOYVVjY2pyWkVYNjBIb3JWR1V0eDZabW9iaU1LWDdoZnRIYnBydFd6Wm9k?=
 =?utf-8?B?UHBYcVZuUzdqMHRXNTYyOTJqS3AvSzViRXZ5SWlTbEhKcEVVbHZxeUNLVVc1?=
 =?utf-8?B?dVBuV3YyTE1oMy9tUmtHblEwSFpyTlVWK2EyUzBxa1FuaGthVVhiaEJSWitW?=
 =?utf-8?B?WEwzRHZmcWdxcGdDNTFLYTdpMWNZd05WVVhTUlU2eE9jdlZyY2JFS1FPdTBs?=
 =?utf-8?B?bGlsM1Y5RHpuQUpQUFRvbzRzMkxaZWVxSHNnMmhMdU90dXVkMENYYzhhclg4?=
 =?utf-8?B?cEFSVGhxMENXSEhCL2phZnZTQXQ1UkpFbzA4TWIrWHBLK0xwWmtoaVQyU2FN?=
 =?utf-8?B?NGNqSTBOSnZ6bGVUYTRqdTBYRE5LSTduODBCclNpTkFVUE94VU9DOFR6eXpD?=
 =?utf-8?B?aVVJZGlnYzYxd0U0dnpvTG9kZk0wK2dkSmV2YmpVV0NhTWUwQWVOU0J1TUcv?=
 =?utf-8?B?L0pSUlYxTGhFaFQrRFRubWRIZVA5aE9EVStndHVmNkxYZTlxeE5pVzNLYmJu?=
 =?utf-8?B?b0t1cnlvWkkzVlU2VlpGOC8xTm90dk9LYzFCRXBOOStpZTFUR3VXL3JYa3I1?=
 =?utf-8?B?dTBoaFh4OGJkQy8vNktZdFJULy9FaEFsNFppeVhoOTk1dVhNVU4vbmRyZWU1?=
 =?utf-8?B?MXk2TVdnaUplOGh0VEVrM0FCWWNrYjBSTTNXc0RMTkk5cUFlK2VIWTE1OHFz?=
 =?utf-8?B?TjdzNXpDbFcwV2ZnWGVvb1lTdUcyVWYxZ3hSYzVaQmwxQTlzdVBZcU1FRlVK?=
 =?utf-8?B?OEIyOUpWSlZqSTVqSGhGeEtCSmtScENDTTZCYm8zMFBRMW56MnY3NVNycUtF?=
 =?utf-8?B?c0dnSFhoRk45bVJGTG5oZVZ4ZjUvN3ozOUN1Z0p3dmdHaDJ2anU1dVpZZ0w4?=
 =?utf-8?B?dkpIWS9zYkd5NCthaGQ4YzdmRVoyODNRNGNHVll0aDBDdGNOb1RaT2cxSytC?=
 =?utf-8?B?K3l2MC85Y1I3cE5sNGYxd3h2L3FPdFg4aWZnZjBZemIyRGVmYlJxVzc1QVls?=
 =?utf-8?B?ZmtBNkkybklKeVFOc2RQOXJnT1BPYlVCd0I5UmZwNUllUExBcm9JUTcvd0Vl?=
 =?utf-8?B?RG5HTjQ3L0ExOEM2dGw3dmpJSkZaZTRLb1NMZDBCT0MzdVhPTFBhcEgya0Z1?=
 =?utf-8?B?VFVPYnJWcE90ZEhJOFRyV2ZjY0JIb3VGdzZ2Sk5ocGN2Q3pEK2laQWRXSm03?=
 =?utf-8?B?ZXU2NHVSZHV4T2gzMlY1d21DRmFaTTFFVngxZ2I2aHRGZEJHN1RtRGxDcnlB?=
 =?utf-8?B?SjhJTy9ORXNzNXMyYWlLV1A4SmMyaXUrWlZQcU03R0pmMkVubVlqOW5tUVVK?=
 =?utf-8?B?dm40TENEMzdIUnVtTUJiZGlZVXlKT2ZoTGIvVHM5Z2pZcUdvVXJmTWdFeUFT?=
 =?utf-8?B?UVVJTHkzZVhNTnVhdnFRdkRzeXFHOUlDL3FtYXVDbWQydmVXYndFZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510a6286-9d12-40ae-6eed-08df03132e4f
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 01:41:42.8612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0ujZ9Ws4xS7KY4vg/mffLomoBKrUYVgTm8a7C7x24tpZbnxIBVQ0hAhjms35rYczxlcWe7GsEeATAYMr3PSgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234
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

On 8/25/26 6:27 PM, Alistair Popple wrote:
> On 2026-08-26 at 07:13 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
>> On 8/25/26 1:53 PM, Danilo Krummrich wrote:
>>> On Tue Aug 25, 2026 at 9:13 AM CEST, Alistair Popple wrote:
>> ...
> Sure. Two questions:
> 
> 1) Do we also need to provide the decoded implementation value?

User space needs to:

a) Know enough about the GPU to be able to choose an SM version (and
probably a few other things) which in turn is eventually required in
order to run GPU programs, as shown in your merge request[1].

b) Display GPU information to the user.

c) I'm sure to be overlooking something.

> 2) If we provide the decoded values why do we need to expose the chip-id at all?
 OK, so maybe we don't?

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43352/diffs?commit_id=945a8e7c51939577526974b342c8dc6bafc3372f#3bb2fa8303917a2ad83e2239c2cae842dfaa594f

thanks,
-- 
John Hubbard

