Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1ED109E559
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2CF10E236;
	Thu, 26 Mar 2026 06:27:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WoKgx5hQ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF0110E236
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2RQHiFN2jSx3ZOJ2HfQOKnbeUIwYL51v7FOs2B4m1sKKQgfWwMFssx7Wq+PYmWYn0TW5RGlCLSFSmwbpkVoiiuOVGrZTp2dp9PF/d74ZYijVBW5lbd/kCk1D46OK/hwlppiun3pVo3IM/pznsMKjwGgxPVzAEKEtgIBaIhQnlLQoGKYrWghXDuRpfOEoq1RlJCO1h8GQ0wXysmeQgiCinE9t6YH+AjoWUIH5IDNBoGlyhutxAR2ILo93o98N+BRMjnXi0HWSagevEj3Vq7go83Rq4aW6sQGptTZHf+MKmXhg4ZE1hldlO3eozhSzb+zkGqcb+unOSKIeUBXezMgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAxpekvi2sCPvA7o2y7Ee50F43WImFJSPMYna/VM7sI=;
 b=JiOE8dtJpbH3BrvdxlngptUubgcZefjRb1yNR/tPlraf1pNbLBD0IO8P8FFjQ1F1/Jx4j+7W23BtwhM15HEWD7dpXxNSwoSsIK4bxEOig+oqJda013bkBwv+acjYzu7vDUz6ysFgWYE8SHcqNFPYhuzORUM2WZXFPA7JAEkGGRvjMJwzS7uQndXwy87mA85v+/wEs7wryYmtLZ2RyLddLb89PzLtNXUdvoaQCfGCFmZIOU4hET036006suBXRXmp4ac0Afq+91PEEGgYM+4Yv6JnO0BSlJiuJR8S4uvJXZMIEBuJDNcaU7QHVbah9YUyRfS1GfIyOGwtjBBW7GpYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAxpekvi2sCPvA7o2y7Ee50F43WImFJSPMYna/VM7sI=;
 b=WoKgx5hQA7yuTolnHXnE50XKmRcfpQF5RZggfAaY4Uy1/6ZaLYc3jnQ36Qed0R+/RvVUe+XF9x0W/H5mqQiuFwDm83jyhSZgz4ZTGZCVrZZ9ENCZQdliHa7syKUTrHy4JI1NWaSgqdvvzTZpstCGUAXFciUBHEerI4zSSKvgwxTypPR2sQL8cQTjZLsO2MTmyPeT37IRfv7FT4ZcJrnOI9qXqAgMf8ZHhl4nwrEcLC9wz71pe061BClyl6FF9GidNvH+3H6ZIEcDfsm2cTWJhEtgEZbQIX+LdBO7fnbPVdCa6w++XS27Ag18qQvv79JZcH9yJAYod5sMPgqU3DSSCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 06:27:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 06:27:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 15:27:27 +0900
Message-Id: <DHCI1C0Y1YR4.3F2S7J2D03FQZ@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH v4 00/10] gpu: nova-core: convert registers to use the
 kernel register macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>
References: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
In-Reply-To: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9657d8-8455-40df-511f-08de8b00c247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: dbaVikYnapmtQm6PAtRmjijA1oeGT+6KuSNX0wEyyLO7lXbfHB45XDbntAmaSZkzSCHn80lSCqdf/p5yOK2gDGe5u1hEL5tntY/FuqUspZmZtDD7rb5lnTq2RoTG6t+T84/pOPWQqZQdIOoOAxJET/8DqUy2JpNtCHkDr/267dazQVUTyqshh1onSVXnTs+D/o5R1Z3FVavsOrkrER9tyCnJNmNhm1LweJGTtJzwGYgN/13PDx2JZsihiQVYDlNMvl+cKmEUMN6m6iT3tXoGPIhEvyq7mahiARTZ+XSD9qdexAeN33sMzVF3vYSzHKn5U5Wq06JQHK3CqRuvzlHzHT0mr4qFZmNC8N6lJOMynTnpvAivaxOF64WqwrTD9oQOiboO/o/awaw+6ZZHY+K1ve8EOKXQsc82abcQ2vkuZwwGOduUywre/wx9wnW8ij42n8EU+MS/p1ZY58gcVphg9hm4QbQI/3+QMrzBqz1wILu3DUrYh95EGkmlt0RvbQ/dDolkfdamBSOWIqDXczQFQEcEUVgoFFtG2EHVges8kT5ANoMPalNllWw5eBvfB/hOIMjwAS/efswBuQ7Vx5OwGATuLAtIr4+WjjeM6qQQ8y3IhQxD5zsYt74zjpMTOscl4fk7E+z6zA8eXjF44/T9VyeFkAMQfhINMyEQhSksu4Syq+w9KBD5n8T5AYf5/nwYvm6X8R27d1G1gXRmIbCOjOp14oiniz8M2yfZvfzDonK4dSAU37IYEtTmLvntiR4AJ8vkQ+2QkpqU+Y1EoYahoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFNsRDZZaW5TbFZCVlI0YUM1WkIvWVYzVXJJVTFuYUlKTi9udGtRd1haKzNB?=
 =?utf-8?B?U256MGhhbytvU3R5a2p2TUZwZjdnUSsvblhPbGhXMC9vTGdRSjVYY1JQTUV0?=
 =?utf-8?B?NFNxNUxiaEYwdEFndjM4dTVlZEdxd3B3R1NzaHN0YUJqRkJ6RmhsYlNCQnkx?=
 =?utf-8?B?YXpGbkVxYk5FaHZXQ0xFUHJZL0g4dDM2a3JyTDRTanlkQmxveENsdHQ3QVcv?=
 =?utf-8?B?Y1hOc3dOM3Q0WWtwejhabmJaNkpzeGdVejNxa3FkM2MxYmlCd0tLdk5vbTJi?=
 =?utf-8?B?NUtzMTRGdkxDNDlPOE5QL1RuVkRkTDRENm81cHVoT3VyZVJqY1Joay9xT0c0?=
 =?utf-8?B?aTB1K3JyZVN6QnAxWUlsMGYrNG5hc0FqQVNJamV5azJvdFFiWGxxVC9CNEZR?=
 =?utf-8?B?MGRkZjdjUC9ScmZ4TmtkVjBCYjVFai9iT05naWhlYzdMNXVGWDBPOUorRkZS?=
 =?utf-8?B?V3hjZFdnY0lnSE4xcG1pd0k1aWw4c2VVQ0VwS3hZb08wZmdsWlY3eGZmTUhD?=
 =?utf-8?B?ZWJYR0NJNDFLcHRleDJKTFZUZTNvdXU5RVBna09ubTZaWU8rRkpWVTYzY2Qx?=
 =?utf-8?B?c09UMXdZOWVBeGtRMVU2cElDaHN2OUJyWXJBdElYVjJPei9vUU5kcEk2dG94?=
 =?utf-8?B?L2lreFpaL0hWRFVIaEo2NmdUeVc2ZVkzdUl1YjJWYjM2MDYwakRTaUZWbTd6?=
 =?utf-8?B?N2VZQll2OFFQL3ZoTnZwVWNpa25zU1AwUndKQkNCVFBjcDNPbXdaVlNCOGFp?=
 =?utf-8?B?K0hQTWRZS0RMRHM1VHZqdGxManlmMDVIcGlOdFl6TEh6S2kyd001NSsrZ2do?=
 =?utf-8?B?c28wM0tTdWx2NGVuNmhkL3NXMXo0L1BkZGlscjMrZnZPdGZCckZQYWVrZ2xT?=
 =?utf-8?B?V1djdGEvMWpWRkpPcWh2cDZrejJjMWV1OEVDQ01BZUlwcURnbzFaVUlyVkpY?=
 =?utf-8?B?QUZ4WkRoaVBkWGdUOTU2WEsrTnNEdzlPdkZJM1lhTlZZOEd5NlY5dnB6THUy?=
 =?utf-8?B?c0ZWWE51VzhUdDJVcWwzR0RxMGhlQXhSb1d3N1dHYm1IUmUwdWZPMEtSRUZG?=
 =?utf-8?B?MTJhbFQzcEIyYXUrSjkyR0hOMkJDZWJrWDN3b3MyeG9NckZ6ZGhJQmJ5d0Fp?=
 =?utf-8?B?MUttelEwNk5mVFBlNjk0UWUyZ3Z0a0JmdTBacFhtbS96WmRBOHN4dU05a1NR?=
 =?utf-8?B?ZDVmWjE3U0JnSHFIUXIyMDA3TmFZRTRqS1pRWUpsN3ZNaytwNnJSMGlSQkhD?=
 =?utf-8?B?VG1nYWhrVUdTaFoyUUYva25xTEp0UDVkbStPUXV5SnBlL0lUTGJwSHFPdFhr?=
 =?utf-8?B?RFRqclp4RjJaNHRwYWExSGtaUzQzZnphK3lGRGMwNlFhTTRuYzNnSDRnaGhH?=
 =?utf-8?B?ZmdldWVCYTJTaVR1VlEwdjVJL0ZzWmZvaUVCaWkrYi9QLzhKZFlFYXVqSWh1?=
 =?utf-8?B?MzBuL2ZYUHFOek1iT2JhRE52M0RCNS9QcVBveWxLaHhLUFpNQWFTTWVWYnpE?=
 =?utf-8?B?bDNaQmRlM3ZUMFZncmNJT2FqSnVsNUdzTmlCcklVQWhyZk5UTDFaWHlMYWNR?=
 =?utf-8?B?TFRPY2RZQUlEb1VZUVhYUDkrc2VNMWxSb29sdmp5Y0N6dWFHUXVtSlhzb0tY?=
 =?utf-8?B?ODNUNWxUUHVCdDIvaU15VkNYbyt4bGZqUHRFZ3BnbWhYZm1DQWVCUE1Lc1ds?=
 =?utf-8?B?YW8vV3pLeTVQTEhkYUNtOWVNYUw2RW1pRnVPb3dsRm1tc1RHTGxFWTdwUzB1?=
 =?utf-8?B?cGEwczR1TUVOcXBhYmYvUnpaVGh6aW1JWnhvbkRoOEhYeEVXQWJGc21ldUI2?=
 =?utf-8?B?cnpHcEFIVUJXYThlVUdqQk96ZWNqbmlBQkdKOXFJRE5xb3lUMnM2M1prdUFO?=
 =?utf-8?B?dHk0KytXOE9aRUM3Z0NvdEpCaTZvVjZ1b1NwUGNNUXlmZUpDU0p6UnZxN0ZV?=
 =?utf-8?B?blVYTC9tRU1ybGJhMzg4TUNITlRUVlo3d3Jwa3RTaU5uR0JkYjRRTzd6VDlq?=
 =?utf-8?B?Wkk5bnhIR2lWclVPK2tHR0dVcnRNTW1pc3F1dVNRd01jUGtpUi9sSWhKaC9r?=
 =?utf-8?B?MkZRR3R1NW9uOXpkSStmeERBOTRYSnZlRjkrQ1JqcEI1UFBqNWRZQTJ0Mkt1?=
 =?utf-8?B?YVhIbUtSL0tYK0x5OFBVTitoV3lHRDZqaEhFS1E5VUI3RVNlNXIxWk1reVlx?=
 =?utf-8?B?ZFdtVzE5K0FJbzI3RFZjNG4wUjJQM0hMRFlxNFB1RkdScEQ0Z1RZcDhRdXFv?=
 =?utf-8?B?TCtzczduVTViWVZ1VndQSktET3FHdW5LY3lMWHZkT2hvU3BDdkdnaEEzYTJo?=
 =?utf-8?B?dlFLV1F4YktocHVYbkgrSldiVFRPaVRtem1TVnFmUUdDYTdCQ2VPbUVpZ0VC?=
 =?utf-8?Q?DVWBUmlZhLXQLkQyMGM7uqnZqVdAHag7C9vOFBey0/HTC?=
X-MS-Exchange-AntiSpam-MessageData-1: YHVrDBj3enTbQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9657d8-8455-40df-511f-08de8b00c247
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:27:31.2218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hga1OnuMlkO3gTTnfyeFCZlo2McgLI60oFuW+R25kRbJrfWNG/1WGfb0WwkpKPrUbZe3efIyp6DPDlPFOzaaaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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

On Wed Mar 25, 2026 at 11:46 AM JST, Alexandre Courbot wrote:
> nova-core carried its own helper macro to declare register types. Its
> purpose was to be temporary since the beginning, and to serve as a
> testbed to develop an equivalent that could be used kernel-wide.
>
> That equivalent has now been merged, so it is time to retire the
> nova-core local version.
>
> The kernel register macro has evolved into something significantly
> different from the one in nova-core, so it cannot be used as a drop-in
> replacement. All declarations and sites using registers need to be
> updated. No semantic change should happen as a result.
>
> All the patches in this series could also be squashed into a single one
> without altering their reviewability significantly.
>
> I hope to be able to merge this quickly so we can rebase in-flight
> series to use the updated register syntax.
>
> This series is based on drm-rust-next as of 2026-03-25 and has been
> tested on Turing.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Pushed to drm-rust-next, thanks!
