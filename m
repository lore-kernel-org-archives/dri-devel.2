Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32714C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 909BD10E324;
	Tue, 21 Jul 2026 11:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uMb5RrzN";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9815210E324
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSpSYCFFcaPHFAGwMTXqsrKUz9vxTP/+7Roi319FbcZqkvivo/79g4rgqSzrVMUMrjgXDO7krdbh6v19LPN1wWItCBC/ExdOs3PbzFvQ6JpHF98B0+Uh5j+OxmgSRMp2PBiM2kjZzo02kdLd8FpYssr40McRp9H5V+DBiVuJVUe7sWwbOxjWuzPgw/Emi2cKRJ99eDG7IkahBRiNsbkR8qb1NsS2c2kdFX++OI3Xp7BLE7u/VG5kSvhkAxbNCCuyZukOWW5UCTZ6ul+fOtsaj49JmFJ+rdLnrEom8ZpGEsjoK6Y4ojbkY5HNsywoWRHxO2+sHnPQ5713Owjyd3sP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTuhCTfF5VvH8sEzlyfV2hherqbhT7NYNMYhytxcOS8=;
 b=vXXFYKmTAVzekPtSZbmBkokFsxZEsDCUL2peIOjQWMf0m7/ymFpKOFfrwyENZe50cLlgJrWcT4TQ+YflFCm3j/On8fHDi0KTtWfedoW5TCAgFgE/yBVlZLlt5mZ0shfnMGRqxY9BPiNbJuFGm7zsfQ4MJT44QzI/pkxEALTi2vinKzVPmu+ZEZVYoViWhdanDlIZhKNPSfE2rg+YNlpRus726E6wI/W+kD4bRF9UvX/lfcJtxGH5H6FVMwknZtJHBYtTWKuqUQmmFw8KjT2wdjBFbNaejZVKPdUBueUip2iZpS5CrqZ46x/FBvpqEW8SuWqUrmKeg3aw7mRuESbngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTuhCTfF5VvH8sEzlyfV2hherqbhT7NYNMYhytxcOS8=;
 b=uMb5RrzNTLdJQ5u+Q/YQ8RMUyXI4O0v18T+pljoi6Xq5VSS4YAKuKfXRnlRj0qmNAzSOrskjPbo+aFTv6OaAtQlwPjHXyHBS3Xpc39Bm72oLZgI02BRA8Tmw4QU75Zg0lvOREhn0A3b0eF1ifBxymlZj6bDmfKtj59XCM0gV2Ias0uXotATnreFCUr4g36bCucOIQkCYXeZivWvkurYn3SuPHIywrXG4EPB27peikoky8MJtK2G7kRiGwM+EwnAAnR5tbgDvaAaYdv/YH+ZXxx2372U3JrkaCEVLn29ctRm0QhMidNPFwPMDfK/VmLUZgBLWKhS8VIhuYloPPO97tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 11:00:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:00:31 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/8] rust: io: register: allow paths for relative register
 bases
Date: Tue, 21 Jul 2026 04:00:09 -0700
Message-Id: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0ML3aLU9MziktSi4vi0zApd80Qz89Sk1DTLpEQDJaCegqJUoDDYvOh
 YCL+4NCkrNbkEZIhSbS0ABImc1nEAAAA=
X-Change-ID: 20260418-registers_fix-7a67ebef9ba0
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TP0P295CA0011.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: c40c6a05-b747-4173-165e-08dee71747cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|11063799006|10067099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info: ZkHgyojyYZJrKHeqUrqBVV0h6EHnWm/aJYgRnHYslN+c9N+fqWTezYx60znqISX3m5buF4OttbVm1EU2kmPNWpKBVRxipBgXkm6+itfcwosnacmY4y3GtB4AOQaYxepMN6Ld9U806tM2hFzq8kOP7zQkrNJsYa2xU9yflTxxmHNnZ0qxQqRRsY/qkK0F35KRYmcHW5JK/JOaG5eBushjZXzAMaFbxHXJnLaRpVUHE9MFzSwmGBZYzTDhvnisXdNW7TAPeem0t+F/bhDoB2Z23ldCne6voeyNLpY8QAx9pOOkMbLELxHr/xefz2vi8QixEXeg7toNUih0MSPsjsQwcqmeMc/bXyoJVBNE6hLtU0WagAYsPDvVUf7YRPII0B9xnzRJZ4qagfj85Amv1kWfvuCYYpCBCTbjKHWcsmHNrk6BCwiO+04yofQAewWP0j7YYkNVuByI5/RWJp64xAR5DWkXsqSIqTIh0qIgD4zcPuNPXFraY3TN2XneoP7bCHsegjHjcyhCrW2Mk9T/chcame9aoYpJXK3PNYfth26tgUp4hCz+wBHa2IXPjjXBAitpu18lxfw/9d2YFH5kib6Ju6wZut37lCSWO6gYIVuGrMZUPwCfOWgNsSWtuLL+MxCHn4dwzvtMVmRa0/w6lu95py5hpuYr6ahah7Dn6DN1LM4bgINXfMBoW+iBC404a+MdHptZWfqE8jNSdB6fEoN+zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(921020)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YStMWGZhdWlpZVlJODJuZ3AxYlgyQmNndUhBTkFBRmwvcTNWUmhtc1MzMXQ3?=
 =?utf-8?B?VXJmTWVoNXlseENwMys3dW10c3lDOElENEc5NE9sK250QUVpdTRwQklwY2F5?=
 =?utf-8?B?TDNxNWRPUEFLdjRLcXJsYldTc2xCTHA2ZGlaREdiOXd0V0tiUUtlOW9POU5I?=
 =?utf-8?B?em9xdDRhNGV1cTZXRGFFZVZRQVhpQlRDNGswaytPcGZieFd4VDU0cHhQbmFB?=
 =?utf-8?B?UXhkMS9sSDJ0RHJuR0preStBTEFiODdvOHcvNFR0WnRUV2RhQmJLMS9mT0Rm?=
 =?utf-8?B?aHc0RngvRm5Wa2M3c29VbWdUc090TmpHVkZYeFdFTldRdElpbHVmaGFzRkR3?=
 =?utf-8?B?WFNBOWJ1K1RBZUErc1hEbjNadEQyNlIxSDZtdGdrMWdCVXUwVWNZdkxkVHVq?=
 =?utf-8?B?djMxaCtDRlJMK3QwblQ0N0xmOWJRaXI1aUVNc0NFS3dpVDlwYUVFWW9PWnRR?=
 =?utf-8?B?UGxhRmk2cFJmZzhhSmJEcEZZSzBRM3IwUGVCVjd6eFZiMXlraTZ2VFlqeDR0?=
 =?utf-8?B?bHhVZUtjYkZKcEFsVWZOeFBJRVBHN2RjbmZqbzVHa2tScW9FWURMaGJmYUt2?=
 =?utf-8?B?VlhlVTBZcnMyLzdtUEJLK0QzVDJsd2gvYTc0S3k2YjErTGRPRURoY0k4WGo5?=
 =?utf-8?B?MFQvbEpaNXBQYVNnVTFpVVJTZzc0UWtDc0srU2NSbUw5b2FMeXZVcGlhdnMx?=
 =?utf-8?B?dzUrT1A2WmV2THF3OG1jaUowUFh2QUpJY3Y0NllEQXN1TmNab2ozR0dHeTc5?=
 =?utf-8?B?SjhmQmFNUU1hNTFtZ0FZNm91L20waFk5S0kzaWJDVnlqN2g0Sy9uN0Q1c3Bm?=
 =?utf-8?B?L0JjQ2RWWGVNNS9oWmF4R0xFMXJwWGh5aGZySjVrZGxjbVQ5czFPemNzaGdG?=
 =?utf-8?B?Y0s1cU4zLzArcTFzcCtXckZOMjhxNjBIWlNyL280S05GY3Z2eUFMT1E0bUVw?=
 =?utf-8?B?NzkrWm5JZUc5UkJNODh0TUFRd0NtZmpPSHZZMDcxMmtUOU1YNmFjTGpXdGhj?=
 =?utf-8?B?S1JtaHpkWWdyYVJKRTc2b0dWNStmdVFncml4RWtHeC9XcGtSWXlVQnFVYVV4?=
 =?utf-8?B?b0pJSmRSeUtCc2UrMFQzNlUwcTUzRGNkK3NpaXZGbU5jeDVzeExaUzlkcGlO?=
 =?utf-8?B?K1cxM0RmQkNXV3lEVTZ0SXV0MkNqNEZCSkhmdk9DWmhDSEt1K2JGWnAwUUpZ?=
 =?utf-8?B?Mi9pRWQ4aFV0SjZsMDE5ZXV1UkZIcmJQdEsvRUpoMTh4c2hZZFN5UVowR3Zp?=
 =?utf-8?B?MnRjcStTUE9ERW1JYU9nK2t1eHBNZjhPa3lpNnlvVCttaEJRMHpWSzk0ZVd6?=
 =?utf-8?B?YWtkUzQzTWxJZ3hjRnllRHVxTGhDM0Q4ZVZXL2J0emtmalVyb1M0ak5pVVdP?=
 =?utf-8?B?ajB4T3p4ZEtnNjBsNzU1YnhQbjlXWnMvRStoOEJDa011S3hpemFDWk9Xb1R4?=
 =?utf-8?B?YkNIN0xYKzgxOUd0TWZhNmZSbmVaT2hSTC9sS0ZuQ2lKMGluUlA3bm5FV1NE?=
 =?utf-8?B?MEdGd1F4U3FHZnlLK0FteHNTQXN3bXgvM0crbWhoWHVBdjVJaC9UdlRwcTMr?=
 =?utf-8?B?NXNjZm5kWlZwNXF3azRFWVprbmc2SklNV1JuR1FUSTlMZml3a3RWWlZoY3V2?=
 =?utf-8?B?a2ZGck9XZWJXMGZJamNxak9aTGorVFZZbEZtOEpPZG1mMnl4QzJ5OG1sbGsr?=
 =?utf-8?B?cVZoOTlsNVFORzk3dElPUnJxUklGVVFzZHlzNEJKNWNtcWZPTXNvVmZ4Tjhv?=
 =?utf-8?B?T0U1TEtqRGRNZk1QNkE0UVRnWkM0Mmd2SVB4a3Zya1dmeVZES3hQQ2tSUGlk?=
 =?utf-8?B?YzJ5Um5Qa0RtN1BRMWwyUDgwdGlZWlhXTlQrN3R5MTdlUTRDaHlRQkd1cmUz?=
 =?utf-8?B?ZGN2ak9jWUZnSVhkekVqSjZnUkJPY1dMUnVURjBTbVQ5bGZvODhWUHI2OG1H?=
 =?utf-8?B?M2owM2pwbzNFYWcrSHpQUnBCMmNXN3pWb2tSUFJWelFQUTJUdVNxWWR5Mytr?=
 =?utf-8?B?bzhMKys0a1NheFdFeFVsNzBWNnFlZjZ4amwrRXVGK056Uzhld0V1NWozbFBT?=
 =?utf-8?B?YVg3SXUyUnNtZWJZV2xkN2RpSVB4cmR0VU1JdFBHL2xSSllnSlcwZk05ZFF4?=
 =?utf-8?B?VFp6emNaTm5MZXY3aTJMSUNEanNWd1ljMVhUOXluSjM4RnNhTlFIVXEwcTJF?=
 =?utf-8?B?bVFHcmp0UWhWcURIVm9YR2FFZjE1UDB6VDhqa283N2orcThuZjZjQXNOR2VN?=
 =?utf-8?B?OHQvZG9xdzlyMGIwZmorcllLUmpkcUdhemQ1cDhJaXFJTS9ZdEVhT3dOWXZV?=
 =?utf-8?B?dWdFSHZadVpGb1lhUlJndmovNjMyQmVKZWI4UGEzL2Jjd3JHSC9aQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40c6a05-b747-4173-165e-08dee71747cc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:00:31.4813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhSg6BzPDtZJstMdTwMLFrv6yPQEmHvvyDrVYwaRrgv/9Nls5nlpoLoXzI0Qf4EPoRA1ZuKFg20iWw4gryyktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
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

The register! macro currently accepts an identifier as the base of a
relative register. This requires base types declared in other modules to
be imported into the module containing the register declaration, rather
than allowing a qualified path to be used directly, which is arbitrarily
limiting.

This series allows path to be used as relative register bases. Since a
`path` fragment cannot be followed by `+` in declarative macros, the
`Base + Offset` and `Base + Alias` forms are replaced with `Base:
Offset` and `Base: Alias`, inducing a syntax change.

The first two patches clean up the macro's internal dispatch and
arguments in preparation for the change. Patches 3-6 gradually add
support for the new syntax and update docs and examples, while
preserving the old syntax. Patch 7 updates Nova to use the new syntax,
and patch 8 removes support for the now unused old syntax.

The series is structured this way so the Nova update and deprecated
syntax removal can be merged separately, as otherwise the whole series
would need to go through drm-rust.

Outside of the syntax update, no functional change is intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Alexandre Courbot (8):
      rust: io: register: dispatch fixed array shortcut internally
      rust: io: register: remove unused rule arguments
      rust: io: register: use path fragment for alias destination
      rust: io: register: use path fragment in relative internal rules
      rust: io: register: allow paths for relative register bases
      rust: io: register: use new relative base syntax in doc and examples
      gpu: nova-core: convert relative registers to new syntax
      rust: io: register: remove deprecated relative register rule

 drivers/gpu/nova-core/regs.rs | 74 +++++++++++++++++++++---------------------
 rust/kernel/io/register.rs    | 75 +++++++++++++++++++++----------------------
 2 files changed, 74 insertions(+), 75 deletions(-)
---
base-commit: 22e77d81d0a9ab3aee1c5538b3f2f8a66930bfa7
change-id: 20260418-registers_fix-7a67ebef9ba0

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

