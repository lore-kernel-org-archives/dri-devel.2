Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7164ACD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA0DC10EAA3;
	Tue, 19 May 2026 06:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uc9ya3nl";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0031710EAAC
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzDXbJpI57AES/x83Kb5i9fw4g+A1evsiw54uEkkge1R7qm823SrulS8vHOXNRvpek+c6mVSUn+N/m4mG7XlDbu9a0hm+2Xx3MZSDh/Xpy2CwwteG/rgdsUf6GFMsIU1nwSE068NEsY/FhQvwNu47H4U666NP0g1vLCwWl+YNyWW5GI47UZaGYO5BSiPvx3LgBQ7kbNZw/NZ5D1++QooAI4LW+RZLuxDjbgkLAtpdaIFR7mfx/k7ezwV2ouU0EDDzbvuy0bO6Ew/jYA3dpDLkfJg8c35xqdjrmVDN3SLt1RB3SLdI2bidH8D4BF0NKGzgRdEnnBQ2Oxu6YgkvjJTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCTbWn3bTrfzQM5De2libsnQzr5noXoJVjbNGvf++N8=;
 b=dk+uiIlGXqxNXdTWi9VYkUY8xXLwWSyfMj3cmIy9YlBsWepXJ0inuP2pTD7WJVadsy1Rmj0qpk2ZO20TASMkcj3XOvWXXSPDIWUEI/BmUErDzjPRHD+bePIJK+Zf060/7dlGBbluJr5izruG1H6w/NqL/XkkcQKUSyStsh3qg0MM+hsDhEeysel5kOrNjuhyMY+Q0hlVsgmaM99jVd0ugYJgyYEsweQQt24BrebBCX3xHnSNE/UK7ir4N5ZM6+Zl+E0j5dQMYcXxgNuP9ib71j1HTgQXTKd86oWc1h4tO+C/evkaV5Ptt6wUc7zNvDgg5G7saQd1eBmtIOC4zDCbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCTbWn3bTrfzQM5De2libsnQzr5noXoJVjbNGvf++N8=;
 b=uc9ya3nlLjrL9QuMTiMGLcitvT54L98vl8djRNQv++GYHNWZzoHlUr31dMfW2wK6SJMomPLbOlmBCknmP5tyAZ/ruMGBnzzOYgEuRhdvvbG2TilY78i22MRGHBsII8RMj2zZ4o44UCNzmHLqtwMmwPsK1nGA84GdnTP8brf0kc/X95XBXu6hoFoakpyCZ4yZtmRDF9ORbxdlnKMeF308gGvOQdJphFOIhQpKkBiU/q9BmxCwU/6MuID2JJwCh2L9e4v+AYoN54rx+a0kpahcM0qx6Wt07HgwBByoa2xY3fJZbOz8jceb2J07bJwUfO1L69Q2AXAwyX+hyBE6re0MSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 06:39:10 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:39:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 15:39:06 +0900
Message-Id: <DIMG3O986H3J.2HSGP992ETOY9@nvidia.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 20/27] rust: io: make IoMem and ExclusiveIoMem
 lifetime-parameterized
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-21-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-21-dakr@kernel.org>
X-ClientProxiedBy: TY4P286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf46193-0417-4286-67fe-08deb5715584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|7416014|376014|921020|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: 9bzhW6q66RA7QEvHOr6gWEvCutvvFTTue3O0YYc3qS2WMPr7Rjbb7ZgR8UlsNIGx70fbwgYf3WMN6ku0byxaI8SEy/GtXF/BnJKKSZwg0ZnnYEerh/t26n+lPVdz4919/d9l0En79mf3xA/PXJSCOmJmPc98wbV5wgZSJL7xkUOKtwV7BlpA5/9Qd8MT6E7pIMXH8RgdxPIREOeorP5nGubCgFmTVFNLG663Np3yR0DtNdp7J4gRTv4i/KOsJWANykVYlWIDzZTwqhTd2gb9+XJx+4SCYt3YNUVI688pQ+VBYHOb6D5zH9hM3fliBBLy+/zESNzpApb/B7/mM2A0owNqlxnh8dM2Pd2FrJYjAAudHvuuc9mYvKpkQeMl4xYRgmMPrvoZXMFzLkc+CmIh5tXF1Nhqz0A6drmYXxmYH7AnVl7vLZtOIm6pmWP2O6dGCp4IsZ+g05N4Qk29JYYrziLg6K7W809F4ZPlHa1taKxcn8co0izq4+SXlGRjz3nyBlsleWioJg28dmlnLBu5vGL96u3y11lwhHCiFlhcTKPZv6ar8kpiPcuwxSUZNshGeIxIIDPgawd8y52rq95mUGMw8eYkP7IWJ3fIEL94OjuxE4sWUagetyCwQC6mpFfDxj0zJ621P30yMhi+vBTj+YaOUl45AqJFrXXShdaBDU250AgGLs38wycjxK3dtAKJaojdlyzXIWLpRiXQFV1zbnqTrp0XzXkzqf43d7VbO8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(921020)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eitWUWJEUWZhNnlabW92NlhzUFJFdmV5dmRoNHFoRzRFZ1Z2OUUxSWdxaWM3?=
 =?utf-8?B?U0lxU05YQjhnNkloTFNka2ZTVjcwTWVXYkJUWVpacW92SW5kT0NDZ2RHVDZw?=
 =?utf-8?B?VisraFU0bk5YRjZZa3c4bzVWRU91d2l3TGRFbWtYTXVXYWlndWlDeUZtUkYv?=
 =?utf-8?B?UXJkaWhqcWhVaE1kamE2L3Zram1wajlqRHlQSnpkTkRucFZNTXV6VUd1Wkxl?=
 =?utf-8?B?YjRCOUswdDNrcU5yRUJNZFZaUzZBQStrSjhIb3ZVUHlWNFBhajZEVlV6d0c2?=
 =?utf-8?B?VzhERGI5dmh2YjRkSjBiMWdMTjIrRmYwR0xBMktxYmNwS0hKSDUzRStmMEdR?=
 =?utf-8?B?QUdrMWFRUjJDY0Z3VTdBRUhDcVZEMVM4dEpkR0lmRFh3OEtnWDNiVnZMOURT?=
 =?utf-8?B?UzJpM3BtWTVkMTcvUXBSZjVCbXp4LzRnUVRoajVhWVBUNE16R1ZpNS8vYUt2?=
 =?utf-8?B?M0dxd0tGcWYySkwxa1IrRUt2eitTenZBWm5YeXR3OUU2eUQxejFkRkdFdFlH?=
 =?utf-8?B?NnQyUC9ya1ZoQUcvRHlWc2huRVlhVWJDUFgzK0hrNUVtMjA4YjFIMWJldTJF?=
 =?utf-8?B?dUxjSi8vRXdaeThwbUxmc2Y4ZDZNZHppWjhzQkJESHBKMHczcUQxaUJ0aFEx?=
 =?utf-8?B?dFQ4WUpqckVkWVJ5bWgvV2EyTE0xUVFRNEc3VkwyVjhVYUw5R3JnTWVuMVBO?=
 =?utf-8?B?L245aEdHMmdXYURpYlBORzJsNVVpSkxHeFFheDFMczBwWWRnTmVFc3pKa3pa?=
 =?utf-8?B?WmhqeEtsUStPeGxha3FpN1R1T096NkhTME5ObGtWTnE1SmdMTmx5ZlZiZGh0?=
 =?utf-8?B?bWJvUEp2Vk5TbSsyaUZET0lhV2hoc2Y4YWFwVFFWUjZTUFVnbksyQ3dEdjll?=
 =?utf-8?B?MmxPTVRlNUNvQ2haczkyVnhqQVI2UHFqWkVXZFZQNXlPTkNIOEFyUGFkZU5V?=
 =?utf-8?B?cGVIMk1YVUJaK2Q4cDdYZDFyWUF5SjdpLzFNemhzTGxwblphYjkxVmtmZnN6?=
 =?utf-8?B?b1M3VGtNUmtHUEVWZFhqZXRqVUllY244QW1iOEwxdjl4MVFiMHlGaXBmYldO?=
 =?utf-8?B?MGVnY0g5NWRtQURWdUlvMjMvWW4wYUxoVzZ3K21ub0FmN0hvTVptN0lnQkFq?=
 =?utf-8?B?YWlxTEx4V0NjeUFIVVExeExaSThVSkpIRjliVlpHdHNPa0VGenk5VnBTazJk?=
 =?utf-8?B?eXBFaGVKV0lWdCtZUnBGK29ZbTJJMXZLK1ZNZWZYb1Z1bGtyYTBIOTB3dUEy?=
 =?utf-8?B?bndEUlVWUm95UDUvTXhLWnB3YXkycWhUUkhSWm9HRzlwZGREL2VpVGx1N00w?=
 =?utf-8?B?RTIxQmV6TTdISEg4QWlEcmxET0x0QU92aHFMWnArcXlSNElxY1AvWGZ4MlMw?=
 =?utf-8?B?MU5qcXV4K2svNnYzWkxLSGhTeHpaMzZLZ0dycDREcmZ1YlozYjVHTVdQc3lz?=
 =?utf-8?B?VXRJTCtHeU1ZenVKMzRzZjdHY0JvSHQ3YStTejliM1gvMzM3c1Q4b1lYMzFq?=
 =?utf-8?B?QUMxc0NTcDMvMVhTbUNZd3I1RHRWbGpxM3cyaDZsRG9xS2ljSkN4QWUwTUZR?=
 =?utf-8?B?NlJzQ2NIZFpBK2l1Z3hybjYrZEovc3hkUTFpbnd3bCtqVlJFblZNQmwwQmdq?=
 =?utf-8?B?eDF2Y1MxMDRveU1DMnl4SFRKZ0djaExpMGhqOTFZY2NxR3ZDdlhLNWM0MW9h?=
 =?utf-8?B?c28vU0dVSnVKREJ1ZkltanppTWtYZHlhVHA4YVZMQlJVR2JlWVJZUEg4YUI5?=
 =?utf-8?B?N1NpTFpZeEdTdWlxcEhBM3QwS0JMSWJBL3hQcndWMTQ2VlhWZkNZUTVZZGwx?=
 =?utf-8?B?VUVPcENHMTR1TFd2VGFXd0ZjaU1QTDRxZFdvby9jN0t3UXRzbEtYZ3k2Skwx?=
 =?utf-8?B?azhyM3FoOC84YkJrWTJjZFpVanM1QTBzeERTbjNmZjlPdHNISHNaT1Uwc3VB?=
 =?utf-8?B?Sm1Sc3QzU1hObDRLUTVBUjZ3WkJoZU1kWkZKaE9PdUh3SnVSV2tDdVNvM2pD?=
 =?utf-8?B?ZXFpWXJiazJvL1F3TExIL0dKS1diUlBPcGNheThCSVptMjNTaFpGWExVUDZs?=
 =?utf-8?B?Z0NOZmhKamw4ZzZxYk92cStuSUJsREkvWUQ1b1NvUGRqMVppV3BuWGlsS1Uz?=
 =?utf-8?B?T09nUTlUUS91c1JaUVBZcjZtYXhIRnloTW5pTlY3MVQ5a3lBZzFWN25uM1NC?=
 =?utf-8?B?N3c3TittbHN3REU2SFZyQkJxbTYxa1dSSmFsdkxXSEYwaDVqQUUrSERIN21m?=
 =?utf-8?B?RUZvOWJyckx5dEd1OHRWR1pxRWN6eUtQTHVMSUhVcUxNdGQwRmkyUUQxdEE0?=
 =?utf-8?B?NmxoN2l0RC83TlFTTXhJSmFpVm9OTVBLQjJaNGtqcS9mb25PdTBpdzYvbnA3?=
 =?utf-8?Q?CJHUGXblAD177BsdK0pJGay3EdzGM64P2JQndfSm4FR8M?=
X-MS-Exchange-AntiSpam-MessageData-1: r8waLiJ6BvcqVg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf46193-0417-4286-67fe-08deb5715584
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:39:10.7471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1nQ6fYyt+i9hvh0wF8rzeGIY0sdpwYOuHmhpLf1b7+pwsthg0BKyQc/bM5Cqnrv0bJBDgB76yqAGLPybJB/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
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

On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
> Add a lifetime parameter to IoMem<'bound, SIZE> and
> ExclusiveIoMem<'bound, SIZE>, storing a &'bound Device<Bound> reference
> to tie the mapping to the device's lifetime.
>
> This mirrors the pci::Bar<'bound, SIZE> design and enables drivers to
> hold I/O memory mappings directly in their HRT private data, tied to the
> device lifetime.
>
> IoRequest::iomap_* methods now return the mapping directly instead of
> wrapping it in Devres. Callers that need device-managed revocation can
> call the new into_devres() method.
>
> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
