Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E56C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 03:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F9C10E3F3;
	Mon,  7 Sep 2026 03:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FCGxJVfo";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 795AA10E3F3
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 03:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpGCcwGaflfqAr9VDnLhqRR0VJGo69zZDG7O5mAcpFYxS9gvDpsPgVCyLgWP/p1ppbQ0+S+4DquSphGk4M2sc13KKcbd9O5cKXV75LlpB2zqeGi8AtbAXgF9cm/okiekWmM4kslNBFSFKi1ggtBswToaCwm9df/ULX7qb8pCiu7HAHrTlEH/E8FX29bNEcX5VRyEiO9MSDMXKtGuxIIoRk8iQGDLCrSsBu9XGXLxzK8BoPZlGd/nkFiTwf8p77H+rD8r+KvbVLZ9OivjojvVraPXTMNZJqcjNTwbYQL1tKnERKCsXX0KGkUUjzejKlkIKSYVE1QPculkUKsK+2wu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M2v9VDgXqdNtVIyd47VYuyMKP9KPyYiO+MkK5pHyHg=;
 b=RG5mSnsB1SXe2rp0QswB7W+GXin/naFYAQWRsJxUQAzP8mfq6kOMyRf8uQpveGqTlN8qbEw1BJrzJgvB9pKi21JfeTO1vGQv9p+B3LA014c7n9leVMrVUFH1O6t9/ME43Iia9yRyqQeZfvt1CbLgx60cFrjb+AQ31d8PMuO0/7n8UVWbRb8CuMV/p0rWfbelTtfG9l+dDD8iJ7Bw3W8rv6+CgwC29FZhsQjbhvaKTJZusO6tNmMbF1e8FvbOTkRGejZulf4w5VsGX39poXlhPEKRtntLMI3sl8kmRT9aiR+dmDurSjFjWP45/lijp1PRP62jXfFMfkgykfJ+5HR99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M2v9VDgXqdNtVIyd47VYuyMKP9KPyYiO+MkK5pHyHg=;
 b=FCGxJVfoIaUBfUJPbWTaeX9sWHH0PeeMC9dG47pttoSo6aH09CxsUZ+xGhGrXVhcrjzTkwdIyYbEX0Vj3O2rolXILdVTqlTwGOsr30lluQgr+hhxl2I2yGJlS23lbRCEiHgfW34SBlFKEqpoqjs5i5X+nibyZ/0CU9zjk9opqid33TqG6ggNopy5Az/cyVbcE4QecwA9yK/cUH4w7fIZU2zIDztRBE8mM/DoegMLj8TqKzLMdPoy0z2JWNruC1LNb6jhOlTiD9Rz3ySqHfTrHqmCfY9z+W6MR6bGZ3TJEAK92n/e6uRuazgWj6xURoq4ZagefHzWBqvWp7amFpFnVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA1PR12MB161209.namprd12.prod.outlook.com (2603:10b6:208:5ac::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 03:22:33 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 03:22:33 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Björn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Onur Özkan <work@onurozkan.dev>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Eliot Courtney <ecourtney@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
Subject: Re: [PATCH v3 00/10] gpu: nova-core: add PRAMIN window support
Message-Id: <178875129291.3189712.2386326014688459969.b4-ty@b4>
Date: Mon, 07 Sep 2026 12:21:32 +0900
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0244.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA1PR12MB161209:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d7842c-583f-41f2-d8a6-08df0c8f4182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|10067099003|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: rzcvoeLqCz7AYhnPAEUhEQ3iHVRP1imVby4CGvNmRwfwZwFv8abJ5c4PpSUnixt2vTXUkNSuZniwLcXo/CFJGoc5tJljjVwz7QEdxRkR6rPpzWbJntdYx88Dy0lzFlurmS6zA55ch8cHwkiWwWen9DjH7u9/5yRpPZgI/lFKWolW1iOUDDuPtaflQ6CuE89jAintEj3aSKGIsL1DcJUOPKJVRFAMAkeL+xmE1bpYuhsKX+cKgUW7Ybx84wmEthhbn9IpVMHXKCrNUlYKLXJ1fXkcUOqTiqxLlok+LM9f5GBqLxXcyEQstGt8JFRJ+g4cYQQ99syfAiTiOeTl1Ndn8hlBT6/ekue3W1Fx9Xy1pMPydHDqlB0p12Yjut0VkPija63sWs+CtdkKUfu6St+eMzRlta7x4Andbm16IV1MVxsoSHDxot0MFAh7yRu7X1jiCccW73TQV2cMx38qHuMI8GILivDEz8c8zj81akiUEdSgPsTT+IfGY86nXgV0gC8SEP6bVX6qmWpdIpUlDK+5iFjk+Zq1/WHtAEogFXha3fHczMi9YuhlhBMLk0t+hUkpPH3RcrQzb4YvqZB3XFQA1qTvK0mTq+qDrR+0SI44LVgVTmc0UEUPvhcd3PEYRb0Dr62yf69IUmL8P4dF4aaHs8PmR402UnmVnAkCkzGmmwOeKshY/ztiy6i+qaccwVpIrC6w98pOLMFhMWEkIZj9oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjdtWWowaWFuZ08rcVBOZ0ZvQ0lZc2dSZzcrbDhkcFV5blVZQ0wzRnNwT1Yx?=
 =?utf-8?B?N3FwVkxGY0hSb1RwSjNVdVUvRWVqMHZ2bURyQ2hsQW0vK0hCWlliQTQ0WDlt?=
 =?utf-8?B?M3lnTWw3ZUdmemFraW9BVGtpaStoRkc1eFJQUWdFMFVSZjNzUWVPb3JMbW83?=
 =?utf-8?B?bzllWmN4NlAyMWpNSG1kYnloK2Q0cnFzYmtJa3liaFBHWjdLK0k3cWw4SlVT?=
 =?utf-8?B?WEJRUzZPSm5SNVlma2psM2VhQjRac0lwenFZTjB5MnJkR2VueDhUa2F0VTBZ?=
 =?utf-8?B?a3drWTZDUWVyVUV0Z3h1Z2dQemhERjFZTDJTaUpBa2lKRXV5T1J6ZkE1VzdI?=
 =?utf-8?B?NlJtckNXV3VkQ0JwSEU5c1VvNDRhM0M0OU5zUjZDNDQwaW94WkROdHBteDdQ?=
 =?utf-8?B?aXBsNHZiYzZVVUMzejBaWE1qZHRHSXRSZGpKUGVxMlZ4cnhuNGNvbkYrTDRO?=
 =?utf-8?B?ZGJMOVA2YVRQYlhkaFQxbTFGcTF1Q2VhaTdmMFBPemhucHN1ankxWDRDcTl0?=
 =?utf-8?B?djdQSEszZmIvQy9VSDZxNVA5QTVBdFJSZEM5UmZTdkVBcGovb1pDSUhPeGhV?=
 =?utf-8?B?MlFweHpDYjVvanYxSnNRcEhuMGRBVWFpSXJtUENmRkx2VE11U09ZbXRYcVU1?=
 =?utf-8?B?NjF4TWw5UElpMGVhQnluVEdHRkVFL3N5aTYrT2RZeDVwSjFNRjJBUzNIMVhX?=
 =?utf-8?B?RzlBYmhyRDlvcG9MOVBkMFp4RmNsYlgzSnBGZTRDQ21KOUNHcjZ4by9JM0o1?=
 =?utf-8?B?WlhFb2NTVm1WNUtKN1hWazVtTDJJajJCWXI2Z3JrVUVSZ1Rvb1FnbndDbnVr?=
 =?utf-8?B?MFBIVGI3QlZJaUVjNXp3Ukl4OFF1Vi9GVzR5MEJWRmhmTTlGTkoreHlBUkZS?=
 =?utf-8?B?S2xXWHkyYjgzUzY3V0Vtc0toRHVkbzVjUG9ISndEMTh2am8wOWJmTi9ISjdO?=
 =?utf-8?B?VkF0WHJ0OVlFZkZObXplaGxRdkh5SlBGUEVsZDAyVTBQdG9OcmZXaCsxVFAx?=
 =?utf-8?B?MDA4Wk1iMjhrUDZkc2tUSHdXZTBicmJUdWNTYlNwQXhUS1AwQW5yck1senc2?=
 =?utf-8?B?RzYyRzRvL1MvNE5ZS0RzOTFRWXlyTXFFOWxhSlJRNWxoUmxGN1d2Y1FERGpS?=
 =?utf-8?B?anR6M3ZjNzhrMEd1L3FXQzZJY1lNaGlUdGxqNzc5MDVEazRQM1pxbk5FZ3Bs?=
 =?utf-8?B?Znk1T2dIZk5OZHJ1TVVnSlROTno1SmdZNURveU5NenJTTDZZWi9KR1Ryc1dv?=
 =?utf-8?B?Njdmb3laWTVpUUNkbHlBeUN5V3FLZVNCMlExdnNxZTlUbVVoaEtIM1BQUitS?=
 =?utf-8?B?TzhvazNZcUE4UmJWdFlsVmNGOE8wNkJUVGFIblQ5RG9sVThoeWtkaW5xMjZn?=
 =?utf-8?B?VHBZeHZMSkxZWDdQZjR5T0Y1OURGVHNpL08zaTgrU2RnaDZzWmtMZ2N6NHNs?=
 =?utf-8?B?OTRjUVkyVzlWYm9razhkR3F4NGZtaG5GbitCRllQajdybThFZmFsUDVVbjY3?=
 =?utf-8?B?TnRPSFp5ZXBwaE9LdE1ydnpKd0RsR0V2dVpXLzZmNm42c0ZEZThXYzV3Vmcr?=
 =?utf-8?B?cE1xM3pOb1ZRMzVjbzRUd0JwY2VNM2puNllJOVlaWlhyWmJwTEk3Z2RRTHFq?=
 =?utf-8?B?bUlMV3BVek5IdjBKSXlscXVYbk9MblNuQ3hGYlV0emhGT0RjMnUzYXM0aTJD?=
 =?utf-8?B?U0xnblZpUCt0WXB0UGNBVlEydENnTG93NlNTUkVXeHZqRjRvZEJKZjVPbi9x?=
 =?utf-8?B?cm1malpFYWJSVXdzZFJKNXFXYU9mUDRZNlpCSCtmT2VPdTF2Um5hUTY1NEd4?=
 =?utf-8?B?cTRldzZ6a0FVcjBFL09mTXlpSStuSHFyQnB0cTcwSWRob2NLTjlvSGZSOWRM?=
 =?utf-8?B?NEp1VmI1TFNKdVVTWEgvaGNPUUIwc0VUakN4RVYxbHdSeGpKdkIxaUJEUnNN?=
 =?utf-8?B?cW1zNndqUVRldHptYVJRc0ozV3dVbmlJZkt5RVJKRDNURlMzZldNS1NDRmU4?=
 =?utf-8?B?ZFNaeUFTNEVqQjBiVlRGN3p1SHFpelFVMm1jc0ptSEgvQXhwbkhXTC92UVRG?=
 =?utf-8?B?Tkd0YWl5WWRJTmtzMWZLcnV3N3RLZEVvODJ6MVNUa0s3VVJTY0dqRlFWRSty?=
 =?utf-8?B?eWVjdmFUQ1YwWVNHQmtGNlV4TmRycW10WVJWUDRDL2wyckhsZGdKQU16WHdu?=
 =?utf-8?B?dDEyWGZINDVJOUx2ZTdLZzVkZU44K01DS1I0ekR6azlaRnBzY2h0N3drSXhQ?=
 =?utf-8?B?Z2VKV3E2bm9zL1NVMUhtaUIwRkhCc0Z5ZWowL3VWTkVjR1VjNVR3dDRjVG1Z?=
 =?utf-8?B?S3d0aDVzQkRRZ3MvNldLVHZNNzhVMlIvNFg0YTZtUGZJZGM4cG0wb2hyZThM?=
 =?utf-8?Q?+JMafEE7mXXJ/RbEnBSNukj6JzYXt844/8uOV3NQkQuWY?=
X-MS-Exchange-AntiSpam-MessageData-1: bDRCIlFO4Q2e8A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d7842c-583f-41f2-d8a6-08df0c8f4182
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 03:22:33.1347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbvHcW1kIrdzDoyrBx5BMKESYAUV7/AcTFpk+z1RjCN1a9sBsMaC1WFWW15WuTPoI3fxlsnsziOpYHgpGdmyLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB161209
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

On Thu, 27 Aug 2026 17:51:41 +0900, Eliot Courtney wrote:
> This series adds support for the PRAMIN window, plus some documentation.
> Some of these patches were originally written by Joel Fernandes [1]. I
> have updated them with changelog notes in each patch. For example, I
> updated them for the newer IO machinery from Gary Guo.
> 
> This series adds a Pramin structure which deals with updating the PRAMIN
> window and handing out typed MMIO views. The PRAMIN window is a method
> that lets arbitrary VRAM be written over BAR0 by configuring a 1 MiB
> window through GPU registers. That 1 MiB window can point anywhere in
> VRAM. This is useful for bootstrapping e.g. GPU side page tables.
> 
> [...]

Applied to drm-rust-next, thanks!

[01/10] gpu: nova-core: mm: Add VramAddress type
        commit: 1473ea0e38b3e3bc76d5e9f89ea4378550ed6328
[02/10] gpu: nova-core: mm: Implement Alignable and Debug for VramAddress
        commit: 8e43629439b7bbdbe4336300aa33727bae9792ca
[03/10] gpu: nova-core: mm: Add PRAMIN window registers
        commit: d3bd73dcf51d88ae116a574ce2f49209c7b48944
[04/10] gpu: nova-core: mm: Add the memory management HAL
        commit: b05ff82081b7b90fdd70cc7d07b3da9d85184f88
[05/10] rust: io: add static `cast()` method for views
        commit: 9aa6069d624ea877a17b7d0952c993d2eb07dc22
[06/10] gpu: nova-core: mm: Add support to use PRAMIN windows to write to VRAM
        commit: a14a957c0e619437fd3a67bc435120b0b6270914
[07/10] docs: gpu: nova-core: Document the PRAMIN aperture mechanism
        commit: b4481b9e3b5a3e1b45b5a70880cc2b730bc3700a
[08/10] gpu: nova-core: mm: Add GpuMm centralized memory manager
        commit: 5958450e98e52adb61c4967d67b76734ff9052c0
[09/10] gpu: nova-core: Add self-test assertion macros and config option
        commit: 2c76c4ec9eb0c91f7b37795f83df8a34d4172285
[10/10] gpu: nova-core: mm: Add PRAMIN aperture self-tests
        commit: e6a2c988ed96a5a3af51ed97ecba980521bf2fc0
