Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5881CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB17113A56;
	Tue,  2 Jun 2026 14:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="do+jdc8P";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020076.outbound.protection.outlook.com [52.101.196.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D863C113A55
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 14:18:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoosyG9XhHQGxv95DAZYf6kp5RqX/sZWFoZhnMQQ56wVzSSVU1GyLz03WUx4o1UiVCICo1wtQHp4cCM2afbjwgvwz2OCzJ/nTXi8oSTHJT058gkFCoh8uZ6qznMfX4p/kcKt6snhB7zw+VRNYn3RXGjYbyOIOfRzf6B9FRhq1f80LpnBZ6LUJQj82v0TMO3xHXWLElRipevGk+7LYVNmJiJjg9yonKda+UKAWtNSjyt/AaDiAd2EcSYei9F75Uc3yE/gUxdBOB3SF0rDUlqfAdL+i1ocFGTJo51Qghr+jKaV8RwoM2/rsssRr4/5XJz8y3FTHe7ZFxAulzqUUOKeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0TacVsjqtHn6L22DUpGtY9yQ/xAOVzmc3UVIs0/rn0=;
 b=ALrjlEPQ0CJZsKyUCpMBQlVLCbgfFW8pU/TAij2MsLYLxml1OAvcODGvzwxyAn3s4wL+mo98vvuJdc5OEMscu21PoatevrQRsCh70WW83XFkuef2fiDVCSM65TAqZWmFGwL79uHiVM6hQXH+RQu/rBl6q44+QvKvh9DZg/23kODp69dTzvNUXwONCKpzMoJGEmzsAPJcc7T8pvowQzg5FKx+/QMQhszFwPYb/X8Zq2koq8d7Ah/fHqnSbGGsv4pOw02S50vrgq/+s4hqs5hUHNgkLcoFHyHItahEGibYkdkipnimBwP6gI8VC3v+DVSwwHTCdy263puxpamfGu5V5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0TacVsjqtHn6L22DUpGtY9yQ/xAOVzmc3UVIs0/rn0=;
 b=do+jdc8PoD9rHUCNlHTQvI+QM/fpTp6mLewJU+1xS5T+QevEqvpdxHlmJG7FCrmJawWwBir35blUPB0DehPNZHtZzrfpqpIfL4E7D3bDYBZURa0nLq4l86BfGVDqk2ffR/G0WcR/NfRCxGfFVn3f/wkpq3wgAyTX8w5KB0zmzco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3626.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 14:18:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 14:18:02 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 02 Jun 2026 15:17:53 +0100
Subject: [PATCH v2 2/6] rust: ptr: use `match` instead of `unwrap_or_else`
 for `build_index`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-projection-syntax-rework-v2-2-6989470f5440@garyguo.net>
References: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
In-Reply-To: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780409881; l=1018;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=hr04Tt1QZvtf3ZStThFAxQPZm/WEXIYt5H2AG4sQ6kE=;
 b=nDRSXfcKJlczdRlmRmi24bZpHI+UVay7eR/s256qMwh8egQuYJ1A+HKu3PlnF0DID4D1ISLNy
 i1+rfgReU4nAf7dYd8/DQffByMPFi8/+raTT0KXMe3wJ/1jGIf1Sec0
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0539.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3626:EE_
X-MS-Office365-Filtering-Correlation-Id: 27848689-0b6f-4330-71cf-08dec0b1c1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|22082099003|18002099003|921020|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: R865n9AWB9niYLZkWGAL6g8zHVhF3RvmR2lU+WjJ4jV+4ISvsylAFDTy8d7RRC80TKZu19fbW/6kOXoEcA1Ex1If8xpFFyIZZmdOdCRfK1/fZmMNTa8ID4Okp/FPqLuI2tP2L6rAigxjyqhhrZC5Zz5kHZNJ5kiQmzPL6YM+zbYiPbde4ftBNelvZL9FXm+RPXRAtLJDGFBCk+6uCbOgqdYnyaYxUUNZH+MpRD9klFeHjXeLbzm4eUi3TNe5DWQBd1OBsUg7qEX0z6i7weakWjSbKb8ooDc79eWPNYuNH8fmAJUjRKnVh7+bX0NdUlgUWiy+/G3SZ5eOCn+/LlAGjhBDlJxE1LB5rTRxHBj4N4rRAba6U9tDnmk/0eU82KjfyJodEmvbGul37yr7L6jHiKzF0VUU9/Q1su0K5BL7wZB/CMUijz2xYMcd3Jqe6zbiYEhtJNSZI3qxTLGZC1p2Vs59U/6PpwubpW3mmGlsZiSHEzW76or4u3I7rjiOa3onKyn6Rj+2inHNcZVxcoTWYIourZSy9zSVqrsLtj7rT4x9SCvaG8PzLcJ+dtHRjiSsvO+Rdk0jXd6uRgphsclSOE9/RYnmO3JDAwjhO/LMMI8OFFgmo3M+7ecGJEKWCH+TusSe0Sbic63+Et0Gbdi96DhQ8WeX0Ho7yfif/zrhlxm/HYhVaZQb9/oLOt6ikibYwEkcWcfk4cJW6hsUoPOD2wXpOlXEgeufK/VxuOASdzig15586Eu7x3Bv+cJXyhiN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(921020)(56012099006)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1AwUE8xT0hsV3ZNTjQrYW9GZXQwMFFJVHR2dXVESFEzQzVVV3RHWG1UR2Jq?=
 =?utf-8?B?a3JkLzBhQlUxdXpJM2UrTGNHY2NrVUIzZWxoT0JSaEUrdE53bUNlMTVzZE9u?=
 =?utf-8?B?ZzIySGc5WUpxelgwS3VwL2dUb3RKVHF1b2ltRXMzM2QyeHd2QlhVMFYrNWxq?=
 =?utf-8?B?WERxOXU3ejBXZkY1QnNTa2t1amJDSFJMdEpadmRzQXN5V3VsUzJEcVA1clQ4?=
 =?utf-8?B?cGd2MmxNUUdYa0tRczVabmpSOVJXTC8reUZmcGkyNzQyM2lzY2p5b3JkbGpI?=
 =?utf-8?B?WU5qZnBSalpVaEVOWUFSeGlWOFRBb2g0NHBEdjNkOEVsK0RuVVErakxmblRz?=
 =?utf-8?B?Vkh0eVJ0bXViV2N3VUJTcUo1Mm5rRndXTnhraVdDVmNWemhtQXNmQzZUV3pX?=
 =?utf-8?B?S2M3OFhaamhOUnM4Zkd0S294MmlkdlVYRXZmaDlUOFVTQlVPc0xwdURlSlVv?=
 =?utf-8?B?ZXIybTlOOSticlhWc1hiRk5LRW9HRS8wcVVPd1F3UHB3ajlOOFl2U3pMdDlK?=
 =?utf-8?B?Z2E0aDFoK3I5eU9yajRDanpmaHJUbGxwZEhhTWVPbGhTWVVVazA1VW4vSUpt?=
 =?utf-8?B?bkRhN01NVW0rWFhtamNtcC9ncmtvU05mK2VDd0c5UWYrM01DbG1HT0Y3aTJC?=
 =?utf-8?B?dHhEQW9sK2hXai91ZzV0UGRnWUJlY1EyRE5BWk9nb3E4aDRSa053MnUybmpM?=
 =?utf-8?B?NzUvM1Q2N2RDTGd1cGZlSXU5WGdMdWMraTkvcEhqRkZiMTZwYTViNDVVZ21H?=
 =?utf-8?B?UXVqT1N4OGgzNzFBNUxhaHpEQlVXYUp3LzZrQTlvenJJNTFCd1o2T2VjRFFs?=
 =?utf-8?B?Nm5DaEFhK2tGOUV1aUo1c2g5NERUWTh1Vldmc28zQm80NFlrd2JMNEJCN3Y5?=
 =?utf-8?B?cXBHakY0dFVsTWlPVUkvT0Q5MDBvRDAzNTdod2pYUWt2WmdGVlRjbmdzUUgw?=
 =?utf-8?B?WFdSZ0hGZGV3SmdDQ3NmSzhRL1NIRlozL2x1QXd1NmtGb3NqN3l6c0RwNTZV?=
 =?utf-8?B?c2lHNkVCK1hCSTdqRTBRRTFVWWQ1UHdWUG9HaTFJUFNkOVlRZ05yZWp6SHNT?=
 =?utf-8?B?YXlHbzVUcjVmVTAxYURYMTdTaS9ueWNUeWxCK2E0bDlHbTd5MjlBY3Z6Tjg0?=
 =?utf-8?B?cXM0enVVbjRERjYwc2ZQQk5Xd0pGeTVUNy9UMVFjbW1YQTNrajhMT2NRaEt5?=
 =?utf-8?B?b0ZuQitWbkxuMnJpZVR0Qy9SNFhPd2w0WlFxdng5MUo5cXdSakVxS2tuVlB0?=
 =?utf-8?B?d0dpc2duTk96NGx5R1FIUS9VcE0wL01nSlczcVBLWUhZL2ZKOStYd2xyN3N6?=
 =?utf-8?B?bkExdjA1ODlOcUgzRHpDVlkwdXNVSDd5cmlmeFYreXByd3oza0lsbU1PbDN1?=
 =?utf-8?B?Vk5pUE5iOGFVMk1nbnA5cFVnWTZZT3JvNFU4Nm8xeWNOYUZ0SE9wVm9oNmVH?=
 =?utf-8?B?SzhIVi9lRTBnNFE4K0hxeFc2OGs3WUVoMnNPdVE1Z3pMc2lSdmdmT1ExY2dG?=
 =?utf-8?B?VnBMTjJCK0tLU2FyaVJzb29mK3R6d2R4S1dVMGJLblBEZHVkalZ6eURBakl0?=
 =?utf-8?B?N1NnVXhHSzF3ZVVEZXErVUhiOHFQVnFTalhzTGY5OU05YUFmbHlCMEgvWVRr?=
 =?utf-8?B?UnFCdklyZjU1MjNLZXYxNzI5QWluc0dCQTFsVWpPSjU3dFNORHB3TXhjOG5s?=
 =?utf-8?B?UGRXZ0pjb3FNaEFyaHFReXdBa1hSNitPNklaUjFyNEN1TFlsZFhxcFdQQktG?=
 =?utf-8?B?OTh4dklhMmJJV2hRaXp5dUdyV2t2aTVjR2J6T1Z1WXZWWGZoMlpSaHJ5TVlp?=
 =?utf-8?B?OHBJNmRacWRIcmp2aHJ6Z1F4Q2RDRHB0cC9GZXBSZEVxb2ZhVThaR0NoNzNS?=
 =?utf-8?B?RkUxRXIwRWg3S2pEN0l1T0xLT3FqUFpBbWNrcUZ4MDNzMmFqQlUwc0ZKZ2VP?=
 =?utf-8?B?MGppT1VKY3NweWhoaVVBL3J6aWtoSzhiNG5uOEROMlRnZThTQ09sdWFjVWRp?=
 =?utf-8?B?THd6Z2gyaHRoVVFoa1RWSG5SVnJYQTZCdE9ZcTNaZ1M3YW1UUHZKekg0NVdE?=
 =?utf-8?B?ZnZnd0lhZFlLd2xiZ0cxMUlNQkVJTGRtV3NMc3VMVTN1cnlQNlJRT1N2b0Ez?=
 =?utf-8?B?UnBkK1VlbzFLdGMza2tjaDArVkRyc2Z0N255SWJOQnpITTlMZWF4b1RTeThK?=
 =?utf-8?B?WXM4WWhRenZQRlBwTUNJVWk2a3dTN3ZrWnY4MVFDeVdJTWJMMWpNMlFJN0gw?=
 =?utf-8?B?ajVzQkVCbjVrOXg3U1kweGQxVUg5d2dzNWI5Wkk5amY3SzI2dTkzdjAxaytN?=
 =?utf-8?B?MHZ2TDJFbHptSGl3M0V3a1VxdTQ3b1hGL2FuOVJmMzhtang2Y2hrdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 27848689-0b6f-4330-71cf-08dec0b1c1a6
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:18:02.4646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhPNhPpX/S5rgTc/MBp14RBu2Z+uS9FbupG0uWV3rCd90p4mJ/6Y3Q4TNyVCR1RP6DECw5dx4tR5YiG31YEXLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3626
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

Use `match` to avoid potential inlining issues of the `unwrap_or_else`
function.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/rust-for-linux/aeCKlut-88SbNsyW@google.com/
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/ptr/projection.rs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/ptr/projection.rs b/rust/kernel/ptr/projection.rs
index fbe172e493c2..1b54616c6cbb 100644
--- a/rust/kernel/ptr/projection.rs
+++ b/rust/kernel/ptr/projection.rs
@@ -45,7 +45,10 @@ pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
     /// Returns an index-projected pointer; fail the build if it cannot be proved to be in bounds.
     #[inline(always)]
     fn build_index(self, slice: *mut T) -> *mut Self::Output {
-        Self::get(self, slice).unwrap_or_else(|| build_error!())
+        match Self::get(self, slice) {
+            Some(v) => v,
+            None => build_error!(),
+        }
     }
 }
 

-- 
2.54.0

