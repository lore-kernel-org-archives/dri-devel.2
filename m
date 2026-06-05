Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927FBCD6E6B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF1A10E4AE;
	Fri,  5 Jun 2026 08:32:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="b1CKK9MG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3606C10E4AE
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 08:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCRdvz2ZNHPp5QwDhmrbR6XbIPgVpk2ty2+p0ggAaJcVyw5VKQRvCR4TmjJwNS3YicMb5pkRUdJ6Q8ikRuXpD0dxbEU6+DiRziRonrNvsDJNJcfVlz1xLvH6F28HT2dKvlX4TNvvl5ILt1aKgWkVy6rBI3YlXeGyrcGjdS3sr/W7buFtotzZozQGRE/2J2XGjD/k30uXysjihWZ95j7q2LXw+gkidK4MpSMHl7wp8wUhYn+XxL4oRIL4yBmIE/nzqZOV16N2KM9KXCIG4SZ8DsU2SYE5b4/fCH8txmTg/27FSprPMXQWzNi2qzurshHSAhNdY3GtkR6x1R1dkYrlQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOLw2mSBFG/9FNQrtlKMwGrNQnQBaNpRHcPgWUxQsj0=;
 b=nI3gcWh9gUymz8FZAa89KFFuuAiIkVwZM9J1XWlCF8evyUv5oyF6bQ0tXM4WKB7juZfA7YziwrCCoUUDnFmCGIkphJwu1AtR5WaNdeKNQNpWZShBh9qrQxRrZGD+EmBQYL/mcccfFfrnISrz/HmUq7rs3AMxJ/cGFS6JXQfrTdv+D9f1J87wjuMQLlxTmqqdVKHolS4HEPYgc4zJp5tZpFVchKABvuTUrOrzKIc5nOeo0J4UbzyTxYCfZwiFxVqQkhM4DtftlIhyS/BxzM5EbldDqGGGukKARZWZT3Mfmnp451gug70QcMXjKalh5bW1eTppr0AV17m1mp1NOAH4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOLw2mSBFG/9FNQrtlKMwGrNQnQBaNpRHcPgWUxQsj0=;
 b=b1CKK9MGngjJMHU9KzKsJNx8vvgK/IBFQ6Z93pTuyi/088ikzF0BbITpeJZ8QYhu/ye030X0vB/GfRd7zgelG3r5cmlVsZwGP3eNjeDkAnMHxmjKx6+vVcDb666ZiSz47ugHdvyCmJH2TkuBnqZ/nILvAAFr56/YI+51rLLJIVGI+79w4dO74yZTRJh9NeKeIWiVVfsOziUoLpzW3WkTRG/of+qdhUIJmFNepoiXkGCKLuDqPCSwpZStN67Cx/lWDsrOnjs+F5PlhvrAVv5JJcxkhBsI6H1PkfQgNwKeF1w2eNk+sOZUdB+izWvgmGlJnvgLn58P3Sgi5+uJnoVlow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 08:32:23 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 08:32:23 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 05 Jun 2026 17:31:54 +0900
Subject: [PATCH v4 4/6] gpu: nova-core: emit Rust metadata for nova-drm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-nova-exports-v4-4-e948c287407c@nvidia.com>
References: <20260605-nova-exports-v4-0-e948c287407c@nvidia.com>
In-Reply-To: <20260605-nova-exports-v4-0-e948c287407c@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS3P286CA0049.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:200::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 8996b7a2-c673-4de9-c165-08dec2dcf797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|366016|1800799024|376014|6133799003|921020|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: E3FOYBfZdPGxYgkkHBTI/8GEgiqEfIXFAROLAZhxVLT2TSjSqR8YKSw6JJw6u9kBrsDJAxqS9UzNmeFbmp3C0OMhJnMCHYKhQMevjju+4cFgfWCM1gQzsf4zcmFSy0T5IyJA6tSLswp3tuZwmSOgNaqUOH2JQtifoZhh5h4NrarfnPqkccsD7X0SucsRHVh/jfxN68+MbuGVUc/FvvuwqNFj/DZFFLcPVelzVJnVsiCwkiRW9O5gp7ps4IDP1bm73IhpVxoUT3CjyfH1r7yNBb+Lh4lohzpaiLaLUuR9flgn1JlMgbs7BdLLMPTGRUgCWIVgpGOeiquAwfReu6j6D7D5NBZ8ogrQZLgLzCGMndHcMmRd6XCmfYsk/+PF2dM4Petv8KCDGBwt7O8RD7XQtVdkJ8xgKMdS/wiE5rJ84ArXxsl4hNBMuc/W8ClirDlxmILF1/hSlAx8lfnjPpPNfG15OHF54Iom7V1fmggDedgEzw+CDkWctginPKSJY/+9Whvy9V81PHbgGj+76o6i4IwYv8rdZA/agIvnTqWJ26oiWFQVVH7eK69E0S2k3zVBnFwr/moAf3iE7pjuciBMhzP8fhLH8AledeTyurQy6zDJWnrEX3uFJch4R+NxuOdwmBJm4JWvwupSy6icsh1uTVqaWWA/ApkfdafYC2vfiRx0j0PVkPdCmVihwuWWyIRnDvMbaqlz4CjNa1aVqwckfgPj2Xe9WrLfn5BE6E8qzRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(366016)(1800799024)(376014)(6133799003)(921020)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnVIWGFBWFlxZ0g5Yk4xYUV0OUJFdGowemhjdGNpVkpyaGJELzJycHJoSlRT?=
 =?utf-8?B?MTYrS215NnpzK2d3OFRyelU4d0pwNWNPb0E1NDFRM3FmT1FSRFJQcFdkR3Bp?=
 =?utf-8?B?cGM0VS9Wb2hPVW1aenNsU3lrNnBQSjloS1huUXhPRDkyTDhpQU82QzB5VDBP?=
 =?utf-8?B?Nzd3TlpTa3locHNqMlJDRGpIUEFubWllbXlVc3phMDk1UHZhSFh3NERJdE5Y?=
 =?utf-8?B?clNuaFJmYmI5V1hXUFRVeDBjbmlncHZKUlgzWitoY3RpcGZsMnMvZ1orZGhl?=
 =?utf-8?B?cU4rTTVVT3ZENm01bjJJdjVVbVRWbHpmZnlIcGJVOEpoRVltdkN5a2J6WnJv?=
 =?utf-8?B?NGxsQzRYeXJXczFYVG9oM2hlbEtxRE5XUTNxMmU0VnRUd21RZmx3Q2RRMnlX?=
 =?utf-8?B?VXY3c2FzMm5sTU5mTUdGWWN2elhqRXJoQUU1QnJGSHhwRm1tQ1ZJUloyN3dM?=
 =?utf-8?B?RnFReThmY3NQZ05kZXpqVllMNmhPdWlmL0dGdHlHTFVFdkd2TmcwU28wbzNi?=
 =?utf-8?B?RUFlWFZodWtJVmY4QmlXWmp3YTBPUHlyNTJsWlhCMmxUVFAvVmgwNG5ETytZ?=
 =?utf-8?B?N0I4OVRRaGMwaTZpWG11MEVxbjJsb2Z1WWUrZHQ4aVRLaisvbmtMVFh2cFdR?=
 =?utf-8?B?dzZFYm9wWVpaeUxQd3ZySHJrQmNxTVNQTVhucE5iNEdkbnhMaEt3cDVHUGxh?=
 =?utf-8?B?VUJxTWVQVXRrS29ZTDlDbVh1dXo3ZFVTSjlhbnpXRDFkbzFVS0hrdnhRVUFD?=
 =?utf-8?B?VDdvUGNqMVhENXdxOU82YVZNTmJwNG4vYlpFQy9pR0lQQmJmNkdKM0NMekhQ?=
 =?utf-8?B?eVRGTThCNW96RHIxcEc5cGZMTHVRKzRVZXNaL3dEdngraUdFUlplcEhSYVB4?=
 =?utf-8?B?UDhmWWZIaDRRL1A0ellqNGx4L2hCVGRlVEw1bGxuanB1M2JTM1ZvRzhiOWFz?=
 =?utf-8?B?eU9sRk5Fa21QbFRDOG9JNDB4S3ZMYWU0TjlkN3NlYWNSYm1weVV6eCtlczFs?=
 =?utf-8?B?cU5QS2hnN2RsOFJSeHZWVGlvV1Vya010VGx1K25HQzBRRk8rN2NKUDNVYk5E?=
 =?utf-8?B?eWQ5Z1ZTYkkrVW5hR1k1S2ppMWtKVTFzV24xMDByVUdCblg0MXRocDBPT3Ey?=
 =?utf-8?B?aitERmpVT21ibEptMGpBUGxXUEpVZVlOcFpnUlBiUHlkNjg2bXZTUzNDTmxn?=
 =?utf-8?B?elpMbFRGWXF0ZXRkeFdpSGpEWFlkeHV3dW5LVG9mdW1qRWg1cHlYNkt3NUQ1?=
 =?utf-8?B?SWhZNTlmRWgyMzRnYXZxOEtIQTdSUmRkdFFKT3NIVHRGVVJYWjl0NkU0alo2?=
 =?utf-8?B?OW40Z3pUcGdQdmlMTE1zN2pHWENpOCtXYytnSFFMQTgyOEthc0pwQWVRYXlx?=
 =?utf-8?B?ZXFGa2dPM3pmcVZaak9ac1lBWkcvTkVrY0RQTlpoSEp3K2tESFpSK3JwUExp?=
 =?utf-8?B?b1lLYm53UHdvVTBDRzFtdFE3ZE1FaURkeFhIMHNSQWdBQmpQbzZNNU1qVGs1?=
 =?utf-8?B?eDBCSFg4U04xMUdrV3hBMmdxYWM4VWY3cWUxSEhxWXFjQkRGMkswMXpJaUhp?=
 =?utf-8?B?WlNtOFRoRGVwajM1cERTTHMwQjFKVWI1VnowczBDMDBJelNUNktaSXFyalZj?=
 =?utf-8?B?b29PWDNWQXYzbnMzWFNicFdVRjdWU3UzQUlJekZJd1JRb08zZGVESStrTnBv?=
 =?utf-8?B?eTdCa1M2R2VLaW9ZZGsvLzJmQ3RrR2FoYW4rY3hiTGNJUURaamk0Z2YveDlY?=
 =?utf-8?B?RjVnVnVLVTQ0YnpoTmRxT1E3S05qNzhRWUIwcldTVGYzNU1iM0hOeUxzdGta?=
 =?utf-8?B?NGdKMG01bHhxeE1FOGgxUHpzRFZ6U2crcUZkc1hXOUlja2QyK0ZvdUMyZmtT?=
 =?utf-8?B?RTJtVzZXSnAySlJSRUtHSlV6R3ZRN1YyK1dHTmZxOWpwaU92QjIrNTRnZE9P?=
 =?utf-8?B?b09TbEI5SlA1NlJuK2dhRWk2S0pkVkNyUUNZNXF6UWpmYWk3QUxma2dFMVlq?=
 =?utf-8?B?ZVBuVFpTeHZIYUFOOTlZbWZOcW01NXhWc1pvU0RnY0lyRWxscFk4V1FQNGZ3?=
 =?utf-8?B?TkdGTDRtdGZuN3JNcmNHU25Fek9MMFhKczhrbTZ2WlNPK2o4RFp5bGtFcFRn?=
 =?utf-8?B?RDNDZzVmMFM0eEVFVi8zYm9SOTUvREJ2N0NsV1JnL1BRQ2dnQlBBRHdPVWlW?=
 =?utf-8?B?R3k4ZHZjODZqNFVGa3ZpTzIwbTZGZmFpSkFnSUd1V3kxSDFQWlVNckxIMkky?=
 =?utf-8?B?NFRIaVNLQkVvNkpyNEZyL0k2clMwSHRWQjhDWURjQjAyNkVka3YzV1lxQkxa?=
 =?utf-8?B?QlNKVjNtUXpuMUoyZnZvOXZ1UWQ1U0pyYVdFRGpyRXVxNmNMQSt6b1hIMldJ?=
 =?utf-8?Q?EP6wFp+gCEvQPrkgH6hv2nGWW2q5Y8BRHItnn+jPEp+rU?=
X-MS-Exchange-AntiSpam-MessageData-1: 0Ab0uRAk/LZfQg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8996b7a2-c673-4de9-c165-08dec2dcf797
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 08:32:23.7198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DndzZxpGLk7DVsQFn2jX08zEJSgJA7bHFK0uor4m/KTqMdkE4p1ofIewTjwN/ZNyMHyjAQKovVl6xs7K2rdiqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
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

Emit nova-core's crate metadata (libnova_core.rmeta) so that nova-drm
can import nova-core's types and functions at compile time.

This is intended to be a workaround until the build system supports Rust
cross-crate dependencies natively.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/Makefile             | 4 ++++
 drivers/gpu/nova-core/.gitignore | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 2f9c6101e21c..164e704bc741 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -34,3 +34,7 @@ targets += nova-core/exports_nova_core_generated.h
 
 $(obj)/nova-core/nova_core_exports.o: $(obj)/nova-core/exports_nova_core_generated.h
 CFLAGS_nova-core/nova_core_exports.o := -I $(objtree)/$(obj)/nova-core
+
+# Output nova-core's crate metadata for use by nova-drm at compile time.
+RUSTFLAGS_nova-core/nova_core.o += \
+	--emit=metadata=$(objtree)/$(obj)/nova-core/libnova_core.rmeta
diff --git a/drivers/gpu/nova-core/.gitignore b/drivers/gpu/nova-core/.gitignore
index 7cc8318c76b1..bac774beba3b 100644
--- a/drivers/gpu/nova-core/.gitignore
+++ b/drivers/gpu/nova-core/.gitignore
@@ -1 +1,2 @@
 exports_nova_core_generated.h
+libnova_core.rmeta

-- 
2.54.0

