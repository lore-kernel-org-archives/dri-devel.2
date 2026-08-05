Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DACC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5398310EF31;
	Wed,  5 Aug 2026 16:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="ClOGRdUE";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020106.outbound.protection.outlook.com [52.101.195.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D97210EF30
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFWQezQU5DkMdW6c7w3VHDpZEfcz4zJCu6Daoiv3Vkmg4fcVz20GGV53xH9eYC2iD4G5yd/ou/iLh2/GtxS3mMtRRpDDQkV+eB8FusGQ8SBMvMwzq5r34Qs9DLbFyRblIUNpZmJontevC9wjhNUUlN60om+JSTe9YK/3pW5LjEnKxpMADcxrSA0Gr7gzWdaw3inPM6JHM+SeTLUSulefnQUifhxATRteATAc1slTI1QaYUeC3uaSLSUlBuV/xshKRaxifJCu8fyybQa7lPY4jbD0oRM0NcsAJEoUrlnAVW0r2WbJm0aQ3Hk3oEaLoDiSPQQlhNAiL9OgHnOM79OHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4E8hmqb30t8gQ5gAenzaXPjowRjYQsuGIN7wA5UX+s=;
 b=JRSoApiBs3ENHF4NDl1S2MvuWUZ1JJJnqrhhx7x9JNW9qkUhfwij28y310teLGZuZH7ZDVLmumtMI9cJ5uff2SH1zq9vkuVKGEuz0Y78cu7+41j9Th54zs+66uGWin0Qsxb8njfvXv+Mzn+mW4lGO47bhDwJWITbz6vzGZWAieyQekekvAdvOUlvZbKqgBWQkB9vhmA2hRoPqG6IfVv4n0edONELMhVLeJotyBCwxBzO1SlpAvtKIyTaP29F3ovGj8vhhbetr7TTEmLjTQox55z3xCz3zSn6W2YsnUSs5X6mhPwrZpRrPRMoNO35S4kxDO4yyF4z8IbxatfBhfNgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4E8hmqb30t8gQ5gAenzaXPjowRjYQsuGIN7wA5UX+s=;
 b=ClOGRdUE5Vhv4utGNbMxjSWGYGW9ut5D5HKX4ciCVqNZboYVm+hUKYu8u1ENyYc7Ew+33H17kTgJ3Dof2ty/XJKqD/l+x7w2tmygHTJ7G/Tw5iiBUXUEGVrnJBb5YWUtLe6uSgB95bvgunuOF+t4oApYBwiM4RkxsuJnSnYKPEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB5822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:05 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:05 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:52 +0100
Subject: [PATCH v2 09/16] samples: rust: pci: specify base type for registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-9-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947818; l=939;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=4IYGZYY5yfpiRR/pq59TMlwC0IwSy825+cZG4DHMQFA=;
 b=w4AsBhVpDXSaEf5w8vJydVaBzWmV9q6jueFMKwjjKDAvq/keAkgyJX087Om0LWnvmKqZkRs24
 cjUnd/CCS+LDfFPu3NGj1gQahYQkOQuAyZTUKBlPnXp6YTHTzVj1yZP
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0608.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::8) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO2P265MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf0b419-80c2-401a-7cf1-08def30fc913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: 4vUEl+6O1a2pjklfRkslXkjm4+iHX38iTvUj0Is0OniotLDB0qDuNCpaRwJggarSu/hQ7409aK7YCp1BFW9bn9QQsQKX62R2jo7R//U0t4JCndvS7VnvcDdKZtXhwOKm1Oyqs9vqg6GohknmE+MgPVHleo4VuRWbGGeF+eCpzlOqKcPCq+IcX2Kn7Rpm78Wd42CfPBHiIJyTXg/K8R2HR4LVc51cF4F7/o2DCInZKI7SqhjkUNCI/a+04gEyjiOj6vOaLdtgHxUUY7K8uXLMDjJer6NAv0z9Mn8wRhOrbITJ0J+0FqWp5/1rVCmMWHTOiiuRA49H29H25shApoZLobL4ESuJ6oqTkGPvsZgEOWV13+VdwrVWREDkJ+Wy3J5fG3tQKZCStMOnQWAzElIzxgKJl58XrBrYmfIinuplQ2x3n2zXhrux4xhhdUG+KBFq4XZ3KWbaSRsghd/gJILV0mICnD7USpx+PjeV6hTz0VRBEb4SPM7Y3RsEQ/Q1J1m124+Rhs/s2JalHCKcf4xnvFVRXUSEqehoPFmum0tfKKQKj3nx3JhA2JpS7qeD8R2Mk6TIGnydd0kyG2gm+BVRShVvbzpZkd+n7Zxcb/nCJRGldaX7meulKRQo6Ld4pHgEiqN8vD5gkj1lZtGkY1l2m9cWpouyzJ3UldYa7GdDT55lrlplt1ZOfw4CstQ2oOX4xyeyQ6Qe/bEZI148ajGtpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGVlRSthL3RSdWNGTStvWTdTNzVEQldhQUpQUjdhR05qemh3cDIxc3pUMWVM?=
 =?utf-8?B?TWdlZWtQUGFsSWRWVTBHdFY5b25xM1NMNjh2WlorZHRya3JGRlZrY2grcTdU?=
 =?utf-8?B?VEtOMk5RYURsdjFGWkR0UXV0bm9KZFBlVFgvb3dPSnE3Nnh3VXp0clljSU9p?=
 =?utf-8?B?aEp3cTYvNk9uL0laZVl5SDRlOU1SZVkxTmxBdlAzcE5CMlNTUU95QWMyeXlE?=
 =?utf-8?B?Z0NEc0d0Nm5QMy9FOHVGUHl1amN5bDVXSkZ2NFFtWmwwV3hIbjIwb1JuTnU3?=
 =?utf-8?B?aW85eWZacUxQMkRxNGNKV214aHBGZVc0SXB4NkRNdTBmcnRBcWhiZisvNm9x?=
 =?utf-8?B?My9KdzA4d3hUQ0tCaXZYUWFEMHkzM05YZGNET3VhM1kzRDlvVVc2cDhxdVVX?=
 =?utf-8?B?a0lTdGNrL1F1OTh0UTB0OUFWdFNvZlhIbzc4Y2pGTzJqTHFua25IY2lnRnVW?=
 =?utf-8?B?TFRRWWlwN1ovcjZjUHdiSzN3bFRQMS8vWnB3d1FNdVhPbnRyOXZzdlVqSmZR?=
 =?utf-8?B?Mm1ncGFDWHJWN3dXTWNHRDhIZUlyQ0w2QzZuZnhPdUJ2cXBIZ3ExOTdkWnZG?=
 =?utf-8?B?ckx5aVY2NmxTaHBSZ0lib01yM0hrZzdvYzNqN1YxOEd1MHp4M3BySEsxbmtj?=
 =?utf-8?B?TS83dFdkSTBmWDlyZXVmNGdvc29BMUR3OW5kRlBrZkcwTVBSckd2ZUtiV0hT?=
 =?utf-8?B?Z3VNM2NIbGlTUzR1c01Jbi9KSlRqWmZIVlhkNjZzV0xoMVdRRWZKTTlkWGJE?=
 =?utf-8?B?a0Eranp2M2pJUUo3dkkySG9aVjBZUjM5eUcxUWNEUXFCU3ltNGw2R2ZvcEpt?=
 =?utf-8?B?MTErWk45bFoxVlgxMjluR09sa0ZzYTJqZ2oyWFo3YjRiOGhyZXJiVk52c0Fm?=
 =?utf-8?B?cFlHYnoyT3JCSXN0b1dLd081L3dvTVNGbDV1VlRZRDdCRnlBRmF2VmM2TUdG?=
 =?utf-8?B?OEJTOWhUaXhRQXRUeHVGNzVpa01hUzd4NzAzdTAxVEtJaHhzb0wrMEY1SW42?=
 =?utf-8?B?eDdwSHpTd1k1bkt2MTA4N0FoeTQ0aThkNFI4MHdURjZWZU1GTzlzd3VEMXd0?=
 =?utf-8?B?ZVFhNCtJVjBaeVJjR2p1UHhTVVlCejdGeXJvTUVRZ2dKR2oySFhRdjROWEFH?=
 =?utf-8?B?Q0p0Q1F0NnBHY2ZqQVMyaS9lOVQxZFdJVXJvM3drazRjeERDUmUwMXcyY3FF?=
 =?utf-8?B?VVVXUE1QUDFZNlN1dFZRY1hTY1hKR2NyTW5YamdlQzhTN2FjbHVYY2ZFZmc4?=
 =?utf-8?B?UVlYSEtLdUNtYzVzNGh4OENveEtYNzlrQmhFWnAyTlNxRy9zdzVjYnZuN2dn?=
 =?utf-8?B?Q241R1UvZGpRalJ1angwQXU4blowdTZhZnRrQnY3dFp3NEU3bngySTB2SUpm?=
 =?utf-8?B?M3VFbmRJWUQ3dW0vME9JOHd6eUpUVXhSY1FKNDFZVG1vREZZRDA0SjNSUzVp?=
 =?utf-8?B?Z21sWlNiUS91bDZDamVtNVdNSXRqUE5KSnV3UURzZGFqanpIWHIrbUxXNTFL?=
 =?utf-8?B?b1d0ZzJ3cWxqam5BcGlFTFdtVlgvS2RPTkR0VGJZTitFSEhTNmkvSDFHM05O?=
 =?utf-8?B?RlRBWURBRFNEWjYvenpiclIrL3VIWnlVcHpIZ3RDNGxJY3RVWS9aemp4bHM1?=
 =?utf-8?B?cEprSzMxWTRLbC90WEtuTEN2d3hMQmFpb2ZHaldGRWtZb0dqbFFBM1YzSldN?=
 =?utf-8?B?elR1d01lZkJ0MnRsS3VKcUxjTXhUbW5XaGNBK1lPaytXa3g0aGp0NkVMMEJ6?=
 =?utf-8?B?YXRPaFNka0p0ZG1WL2Nia1F1d1lIcUlqdFFFL3Q2QmJ0ODBCMHpwK012aGUy?=
 =?utf-8?B?K1djKzRpLzZPWUIvTVJsaWVMZm9Sa2puRXpsaFRjbUR1Wk5JYzUya2pKK3dS?=
 =?utf-8?B?ei9RK1ovaTMyWUJvQ1c3UWIxMTVFSjZUS1VrVHg2TGRnbWxySmpSV2tXczZC?=
 =?utf-8?B?aGVRb1oyd1FRaXpxSElRam9LdmdxOTEzYlg5UDgwdFFRcXBNQXFZWHhZcmFt?=
 =?utf-8?B?Mjd0aHBaMEg4QU4xV200eEhNYmxNejM0WlpUdnBRYUNHTUpMbDhtL2FCVnNE?=
 =?utf-8?B?MEdMWkhxRmIvREkzSW5CNEYzQW9lSXh6WSsrR3RwOEZYOWdUWWZHdHZ5clpi?=
 =?utf-8?B?eEIrcEdKaW1HSkZBTmtuemFjb3g1Y1FoZ1lGb0lBbFZUSDlib2R5MytOaTBP?=
 =?utf-8?B?YnZGbVpGWlFxOUpFSWEvdmNHenV2aU9hWlc0b0JIbVJ0cDh4REZORXpSQ3VJ?=
 =?utf-8?B?dEQ0OVBPVU1hQ0lxVnRtZFdWdEo5V284UlhnWVJuTW1KUllKQmU2QnRFVTQx?=
 =?utf-8?B?UmtUNmJqTWl5M0VhRjloNXFvNkNIMlY3MzNKWFNtYnpQanNkT05hdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf0b419-80c2-401a-7cf1-08def30fc913
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:05.7980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4xAlMsdajqUE8Dt/L/GSrclP14AciOfIr99Vy2ph9O2PfFhnu3KomoA9UhX89VcerjPGzHWKlen+COxjdZgIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5822
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

The `register!` macro is going to require explicit base type, specify it
for both `register!` usages in PCI sample driver.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 samples/rust/rust_driver_pci.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 2282191e6292..13b035a95756 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -23,6 +23,8 @@ mod regs {
     use super::*;
 
     register! {
+        base: kernel::io::Region<END>;
+
         pub(super) TEST(u8) @ 0x0 {
             7:0 index => TestIndex;
         }
@@ -102,6 +104,8 @@ fn config_space(pdev: &pci::Device<Bound>) {
 
         // Some PCI configuration space registers.
         register! {
+            base: pci::Normal;
+
             VENDOR_ID(u16) @ 0x0 {
                 15:0 vendor_id;
             }

-- 
2.54.0

