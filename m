Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C160BFCD0CE
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2433510E6D5;
	Wed, 18 Mar 2026 08:06:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jChllHmy";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CF210E6D5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/rb2wjJOq87ojA7L5M1DEWezYXfW06JxRtsN1IOjphmQTd/ibZnXsRRQ9A3yzqeZ1AAoi4RK/5EFJ5X0EsSSVYfBc8oamWN4RuZsBTQDyjRwhW5nCqLP952ARD1sF44p+DYjWn56klHrBxpxCo4Qf/JrB9RYIquqKxdTdSbRoUD1E1yZikhDlAC7iII/ad4F7Twi2VbJkPE/1sEuZs0b8b/Cx/ZuBE9IDwhWCAYmYilAw7RipqgIro5a1EmrIs68gDRma32lApEa66wduo4GHN4Vb/u7UF9sB688RE+AYeXbW2lcMrGXuMfDMWlFSmGBuM80TC8ol+aCoEZz/xOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TLFEIpNqScuZCdTK3/0qIGxL+Z3k96PoDP3FrL/Wo4=;
 b=LJfalcTbXWfhE6bZuMeLUVEq7EktCWWsloQMTTgSkp4Mj1q1MmaO1xXQE5ffGmTUcYYFRJEIl9ZZSc8GrDKHRdkeA1dyZT3LFz1EuPDs7MEIgKgz81JUnMrnd2ZoEAqXVEyBQzdaUSIIf1v8+vFp7TvtT7BryGme1+9N4aFOskQKbn+VRUxhzL18zAtxrbDo3FVGotMpyjTVoS3SyWpvWeLwXCiTrv2UOznVVkUYe0X652qQLVMtyoqL/4G1TwsSpUHL74YVbWQMWYLiY3mIpTczEh54Lb4Ln1bFhhSGoq8htBd7AyDpqd8XfsEFT9U6Z+Xhj0m/wJWBN8boKYaGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TLFEIpNqScuZCdTK3/0qIGxL+Z3k96PoDP3FrL/Wo4=;
 b=jChllHmyOxTDVvCr6JwDjfBOXYuGQE4zD3JukkZDcF0gfRxJvpcTyyKv/Njt6zrml4guDJShtCfltpGeO6+N0i3zY7d6XV1JUPycKdl4fZJUL7O1vr8C+LrjnM7GzGiSaw7pXVt5sSWCO7EjaW4/Dj7u/Pjk5eQ3zOKKrkn5NrIgLxdMmbjfrbumDSagG1KeMh+ImdNhw+dtGShhrNBCEGwX5lo/qFxzFAXqfURDhH/Xg+6SWOd2ENbCqKDlFqMU7y9gRXVgvfzF6XD93JUVbzY/YU1kdLYNn7RoUls4U6Uosjpr8y+CFeY/6l+ieZL81dmAf4ADXpsbk4M6jC1R2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:06:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 08:06:44 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 18 Mar 2026 17:06:06 +0900
Subject: [PATCH 8/8] Documentation: nova: remove register abstraction task
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-b4-nova-register-v1-8-22a358aa4c63@nvidia.com>
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P286CA0058.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4e172f-cfcf-4b02-2cf5-08de84c54b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1wkwR8f1R4KKY5qRCXtnJIJS0U0qfWSOqg8XDrw8poQS+uN5rSam1BCbnWCM1MHSY5GdXnAkltOyz7i7DuqQGBUppSUqcLa1rzLMsstFZgcfP4wdYwOD3LZe4eoRG8So/l5f3j6bkJzhOkeL/o+gW1mSFjIHurTEVBVd1RHSAR0yfGHxEpLpEFHLwSX3oXk4udODyAaupkwWT4MKmF4KbmYIFtIGIJQ1NO4fbg+XSV/im1nft0o/AmPoJusd8ESM2LJpuZYGkXOx07fEnsBX2/cbnFPuY4AeNgLduiCemQU0FfEwwxd5IEwD/YyRSl+IpbxYA6+S15D3v9DVxyhe4dX3+WGjR26B286P11W06aKm4ylpqKs5++RZychWn8N06j/Djk7ybxhw1etvBGri7ZKM1p5KeJtil5amIjXjz9dXPf2FNLEcGoPd+lB8d3+NyzYUQBbZzsxcrP3RuQZPB3p3BnKnYLIlaTi1nNJnjMXkK303pBow2dNF4Zpm2WsdE8U+UEGB0cM7tAewn6mRNk1n07FkApPeqskSFgvP0H42n90GLDcoOSgR7GEZGKabPFqGfzuowbEqQSg3obm16zDiy1XMHAGrX23vNq39I/f3CSQGCErhuS/DNGF5D9UAdDKLjZpGEC6Lx/il+BzNHT6K2rV/SjAVgaN8fqInY0nVm5QblFmO4ViZ9vTTzRtpc+xGiERtBk6XXD892uEYXpd2h49B/tg5Qm2P5Ss2sJaodpV3olsDl+hUNzaNqfHAMRD1+t+ovGaJHW0W8xdU5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkN0ek1TQUhUeklCc1ZyU3A4MDloUTNkbGlCSDdSV29hVThLUlJoUDN1R05O?=
 =?utf-8?B?WjYvSTE5REFLL0hmSGU3UWdDZXREcEpVK1hBN3hDNkQydWZFMm5wTmRwbndN?=
 =?utf-8?B?dDZaNHdQMjJDMk9zajdOVVRDa251V1c5NVIvQ3NBUldET1o3M0RhcXBSNjFJ?=
 =?utf-8?B?WWRBcGRoMHp4bm5QUGRtVkc5bzhaTThOMnBWSlpDRk1Tbkw1N0dOR0lYM1hE?=
 =?utf-8?B?ZFFDRWFCc3hLQ0RGOENtR1hqVERXUU9GRGhMRkZXYnk3MWhBUEVkNVFJNmFT?=
 =?utf-8?B?eTJtY0UyOTFuakJFQ1FBQVVMMWFQQXhmN0pTOFc2UTBLY0NOZld2cmV5UWFl?=
 =?utf-8?B?bFM3M25lVzhZS2V4Q3JnZlNMNVRTeUp2ZTVkSHRVc3BhRUpqWSsvU2YyS0Jz?=
 =?utf-8?B?ZlBLeW45QWV0dnYzR1RRazdtRHk1RXlPUUxKcXliNVpKZEFyWjBXbDZMMXp6?=
 =?utf-8?B?eXQyM3piNDY5VVZlT1ZSNGVGb0FxNS9VbjZoWlJkRVY5V3Nvd3JZbnFQSXJO?=
 =?utf-8?B?YjZLOFRyc0dpQTlNWmNYeStGUVkrL3c1NlpKcGR6T2RTR2ZwQi85cFpybHc3?=
 =?utf-8?B?SDYzOVRYekV2VytNc1VpUzhkL1o0VzVLTllZS1RZelcwNjY3TE9KSHkrWDhG?=
 =?utf-8?B?TWRHRGQyYm52K1FEVXRsUS9TdU1CcC9GV1oxUFJzS08rV2kwM2xDM0JadlY3?=
 =?utf-8?B?ODl5TjYySDdOU1JRWkJ6R0tldmxqa09YWC8yTjdLdG5JYVVLZEFTQWFyd0sy?=
 =?utf-8?B?Uk5Ba256QXcwdFl3djM3Ri9aT0NGWm0xUDlVVHE0VlhhZHk3UjhUQ1R2Rkcz?=
 =?utf-8?B?RW81MklZSGJsSHJwa1krSzFydUtZdzVlazVMa1JQUkFuK1FPQjZwSER6aXor?=
 =?utf-8?B?RU94NTlaeFJjY1NHQmlCYW1Ba3pjK2F5M09qelcva2hBRWljYkJnZlpPTlk3?=
 =?utf-8?B?MVhDL21jaVNUakNCcnpRZnc5OTR2Z041MjRKMHJZQklsSnJPc0haZkR1NDhL?=
 =?utf-8?B?NlFLVXoybTBGUThGRTEyaUJGRjBDY1NmdHQ1VFJxT2ZUdXQ3R29aTDFSc1lX?=
 =?utf-8?B?VDgxZytFelNJNmVKNGRLV0orV0VnRlNsclBhVi9FNkl4ZFAyQWliZzIzZmJ3?=
 =?utf-8?B?SkFNc0VLNGo2aXdyR2xwWVd0UVhTazJHMSszTkNvNTUrOXdmZmR2U3VLZVZB?=
 =?utf-8?B?endqd205VW1RQzFlYnl4bkV2RHBDRExsVkhvQWVqazU3NE9odlRqeHRHRlZP?=
 =?utf-8?B?bjd1WUt4Ukx5RVpGVGt2Y0wzWWxzVWZaa0RYczY5eCtOL2MwRERIN1p0aUVV?=
 =?utf-8?B?WURuaXZyZllxWjR5SlB5bHR6ZDNBMEJKcndXV1ZpN2Y0NVBzWWdkcWpJZnFj?=
 =?utf-8?B?UmIxam5RdzVnNjlIeFhxMTlKUHdHMUxtQ2hTZmczQXhGV0dMYlVpT3JIbHY3?=
 =?utf-8?B?R05nTjV2a3BkNnBUV3N1aGl0NkcyWjIySDRLeTlDWXp4OFhiZlpvRHY5T0ZV?=
 =?utf-8?B?WlZ1N0tRaWFKR3pJWXI5cFFmMUpDMjBZV1FYczBzbHlTQy9jZ3Z4NE9mTytX?=
 =?utf-8?B?QVpwczNBNDNsYnRpQVU1aTNjb2QvUUVWVkt3QjdqSys3eHZ5QXdzRUpDVFpE?=
 =?utf-8?B?WEJDTkVIQWtSRDFMN2NGZlV6Nks0a2txaUk1VDNaTGoyN2hwdGFYVWdGV0RX?=
 =?utf-8?B?eE8rOXlYRTlaT3piemdiZytPcXVkSW5WRjZMUEZ6cjNEUUdDTHN6TnBDNVQ1?=
 =?utf-8?B?OVVUanljNnY5ampaSzRaVVVHRzdCcGlIQTFGOXkvWENzNWxoOWQza2paRTNQ?=
 =?utf-8?B?SHdLQlRLL2NNMWFCQk9WNVFvMnZQWUJLYkllZkJQUXNoVTEzUEZXcXliNHp1?=
 =?utf-8?B?bXlQVVlwZDVRTUdRUGp3RDNzZU9GMzVTRlZGMDJ3Smd1akRGVWs0SGtoSEZ0?=
 =?utf-8?B?QUp2bGxzQU92YjhZbzkvM0JUQ3QreEhIbGpnaVFsS3dtTVJRUmxlVll1OEpE?=
 =?utf-8?B?UHIxaWJZS3owM0pCOTBDcHdDZ3F1OWxuNkhTTUZOWTE5MVhxMFQ0R0d2K3R5?=
 =?utf-8?B?WDNnWm5iYUdFWmlDVmNwNzRvMjBLS3QyMG9BWnN4c2s4YlVKdFFkK0xpdTY5?=
 =?utf-8?B?MjByUXlMQngrM2tHMmgwRnVQQmdUNWxOUEQrSGhxMkpweDZzOXR0eVdtVGFw?=
 =?utf-8?B?RUlwNlVjUTlOVDFGTWVjMXhoaUc5YjhnT0Q2ZnJGRittNi9JbDYrTXJ4VEVu?=
 =?utf-8?B?ZTZuTXB3TTJYamZBeTZlMTM4KzZFSzltNGNYakowUWRVWE5Vemd5QXZUS1p1?=
 =?utf-8?B?emxUVFNnZVJybHhkVUpHcmZiQzI2cEQ5Q2FTeFR5RU96eUhIY1kwQUZaWG9O?=
 =?utf-8?Q?a66Uw4v2vERMl8cDvuKVMuWOAILqycd3I3fmqjPHN8vx9?=
X-MS-Exchange-AntiSpam-MessageData-1: s3Q8/kWx5AMZGQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4e172f-cfcf-4b02-2cf5-08de84c54b87
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:06:44.5599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLv8/YZSYr83NXEzcSTFKY6m3fPY6XNeILmbd6rTMab1+oJ7UyG1FC2wGeYW0XEqCC7f/84E5E2IA5y2pVlGwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

The `register!` macro has been implemented and all nova-core code
converted to use it. Remove the corresponding task in todo.rst.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 Documentation/gpu/nova/core/todo.rst | 76 ------------------------------------
 1 file changed, 76 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index d1964eb645e2..d5130b2b08fb 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -51,82 +51,6 @@ There also have been considerations of ToPrimitive [2].
 | Link: https://lore.kernel.org/all/cover.1750689857.git.y.j3ms.n@gmail.com/ [1]
 | Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Implement.20.60FromPrimitive.60.20trait.20.2B.20derive.20macro.20for.20nova-core/with/541971854 [2]
 
-Generic register abstraction [REGA]
------------------------------------
-
-Work out how register constants and structures can be automatically generated
-through generalized macros.
-
-Example:
-
-.. code-block:: rust
-
-	register!(BOOT0, 0x0, u32, pci::Bar<SIZE>, Fields [
-	   MINOR_REVISION(3:0, RO),
-	   MAJOR_REVISION(7:4, RO),
-	   REVISION(7:0, RO), // Virtual register combining major and minor rev.
-	])
-
-This could expand to something like:
-
-.. code-block:: rust
-
-	const BOOT0_OFFSET: usize = 0x00000000;
-	const BOOT0_MINOR_REVISION_SHIFT: u8 = 0;
-	const BOOT0_MINOR_REVISION_MASK: u32 = 0x0000000f;
-	const BOOT0_MAJOR_REVISION_SHIFT: u8 = 4;
-	const BOOT0_MAJOR_REVISION_MASK: u32 = 0x000000f0;
-	const BOOT0_REVISION_SHIFT: u8 = BOOT0_MINOR_REVISION_SHIFT;
-	const BOOT0_REVISION_MASK: u32 = BOOT0_MINOR_REVISION_MASK | BOOT0_MAJOR_REVISION_MASK;
-
-	struct Boot0(u32);
-
-	impl Boot0 {
-	   #[inline]
-	   fn read(bar: &RevocableGuard<'_, pci::Bar<SIZE>>) -> Self {
-	      Self(bar.readl(BOOT0_OFFSET))
-	   }
-
-	   #[inline]
-	   fn minor_revision(&self) -> u32 {
-	      (self.0 & BOOT0_MINOR_REVISION_MASK) >> BOOT0_MINOR_REVISION_SHIFT
-	   }
-
-	   #[inline]
-	   fn major_revision(&self) -> u32 {
-	      (self.0 & BOOT0_MAJOR_REVISION_MASK) >> BOOT0_MAJOR_REVISION_SHIFT
-	   }
-
-	   #[inline]
-	   fn revision(&self) -> u32 {
-	      (self.0 & BOOT0_REVISION_MASK) >> BOOT0_REVISION_SHIFT
-	   }
-	}
-
-Usage:
-
-.. code-block:: rust
-
-	let bar = bar.try_access().ok_or(ENXIO)?;
-
-	let boot0 = Boot0::read(&bar);
-	pr_info!("Revision: {}\n", boot0.revision());
-
-A work-in-progress implementation currently resides in
-`drivers/gpu/nova-core/regs/macros.rs` and is used in nova-core. It would be
-nice to improve it (possibly using proc macros) and move it to the `kernel`
-crate so it can be used by other components as well.
-
-Features desired before this happens:
-
-* Make I/O optional I/O (for field values that are not registers),
-* Support other sizes than `u32`,
-* Allow visibility control for registers and individual fields,
-* Use Rust slice syntax to express fields ranges.
-
-| Complexity: Advanced
-| Contact: Alexandre Courbot
-
 Numerical operations [NUMM]
 ---------------------------
 

-- 
2.53.0

