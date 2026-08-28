Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E524FC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3801810E466;
	Fri, 28 Aug 2026 03:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lAZDcfJo";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6081710E466
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhmnc48A/m8Z++PnRYOU4WvqCCw0QkVn1GGrdJmFPLbuPTTVavB5cUhAiN+qi4Q0BrU0sLf4kdN1l29T/HS86oHhkJh+JUR+6bgPbAorcWadlSBH6L2G0wV0DMM+nfyVyTHV4qSYY6FzTdraCPHvS5f5DkdP0q5GvwEV6r7zMbF2M3GaJy63eqdLuv+NT7vl3JMjLVlM1ekuPOjjmwzffpxVFDdk0yKPdfC7p6vHt9gYlft12FpMTwqqUEd6PVE1N5l73dY8k1kEM7wZlhjPInwJk1h8dJvdSQxy6qh27IqJmaZwDyIdagzgUPRuVEw7a76Pe7eUk8FJa/N/RUrk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LncKFFtg04Zn8+zTgVlTCJhblEiCVJLo/0dSFmAGBgE=;
 b=ux0x/h1RO/+7yNBida51qukkp7mOnkfijKobpfooNpfGFGPZmlEecCU8TVLX55O9SEYk6uT5YXZ/JkdR3vFTxWA3IJy6Vubp8WsTz/Ap3ZvSVzB64VfEqlUUXxmAnZHAWvuvyjJXhxlRwjmyT2yFphYxFL7sLyI2dbn3vMSlHl4u/UCsz7X2QoTlbfrOBTt8npoqyDYu4/1xXpffAUMt64n+6fJcyQIUPbGV/XEWFc/d+CUL5iZkkSnqqOMIVUoZEwceHqjnItyToX3pRusJmCTAzIdcf5GOhH9lRU6jWGmntOd0HFjgBuMApvTh4uHPwhvs/T7WU1gvRi+HmdM1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LncKFFtg04Zn8+zTgVlTCJhblEiCVJLo/0dSFmAGBgE=;
 b=lAZDcfJosl5K2QHbudjDEYfyEpQ6SPLfMTtG2Ca4nwwLeOzhFJVNOwR3Pjha2hJCiYLTEdYnfvV+BOvbOAS5NVaGIynZnWjxIkMXU/jhaSkF9mld8lXSHnjN52qwNvZyHX8suJMArxxU0sdSyyJ8lER6/0T+H+QVewlRuoqgKKpDyD/7pG8+WoIhKB0UyHsrFgJr89iHOEks0QsS4Wr/qHICnoJwtcOOZx2DAZMnTVTnzgEYptrkEGA8UxDn0GxUKgNKfQNpUlpH+ktsISmOfsSMp7tf3V7pCuFDAsXYsPYbhwTY4UwELeVybgEz9FYOMSadK5H3XrWB7vWYxMS50w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 28 Aug
 2026 03:36:11 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:36:11 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v5 04/11] rust: uaccess: add UserSliceWriter::write_truncated()
Date: Fri, 28 Aug 2026 13:35:24 +1000
Message-ID: <20260828033531.1117754-5-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828033531.1117754-1-apopple@nvidia.com>
References: <20260828033531.1117754-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0002.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::12) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d9e0a8-cbc3-41ef-3652-08df04b580fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X72oD+Fzyu2L5ULlTgYSAfrSXKoeI2F97h3kvoh7kOPpXfQh9HX6Yo+5cfptN9csw8CWBfvvwo5+YwrP8ipwh4zTWcwOGHvHUNbwDBQunkB9Qf7B4m1pDhda/3Lyu8NTkpWdhy6bZSndJEWgStkiBiV6RS5qsGgZ5uSCk19iFoL9vf57GwR94mr27ElmqqnPmMt+TlEBLY8QcIxg09T2Bm5Kt9byutepUgOy4W2fyvt6d4+RL8W/eK/TOQ8ORWBRgEKI1rpFszGhQB4vLSP4QHL1SyX34RdFicqg5IqD+ei7ga1zOK3d1Sryt4+jMlT84/5V1HJbJSUCrqdlrMYDtNRfgRWFyaw+mPay4wsRghq7Y7MhvMSwuunSJ+mniIm3g6H70zKxyw4gF0PKkKwJ28u+KXYdcJ8ohY4T/BMlF3c5rW25M/pxax8BKFMMtZwir+XXc11TYxNRD7ImSitkFze0X9tZs2nJftpjpiRjmfTW8/slfa7JYcswCdaOn666T+a5dCfJLsZM1yUZ6J0Y43H9uQjqbub+CBhA20tr1fAuRnPNALf4W1ovgfwNGjhUTzEEaRRC2EbhGVssxwZfZ/c4VwA+Lh7BXfC93q7Ervd/mjEhewh0sKpaC9PU8XW3x2Pv26P+8lWCaw3by2IZnikiGqh8Scf9nZWdVHtYP40=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ACkNTaO8TdYMt7MMhnvz7Idvz5JMZyTyvDkp3lstSnIZ6w4I60R3OBz8mlBH?=
 =?us-ascii?Q?AOPF7rUymcx4EwF6BfbR/W4u5qdF2QAMVPFaWLTtDGOwSyyMbLkBsk9z52xe?=
 =?us-ascii?Q?QhddADK4iJv+K21XpXI/3sRDmTTMVYrPlCDgRCmwRDv+iG3D2RrquCCTfEIH?=
 =?us-ascii?Q?UA6RiUU0DldkyxBZvIPN+EVKnrtQ3DMIAlirdiILC0hg+91sCaFS2xgWivwW?=
 =?us-ascii?Q?PPREqoOb7954v8CsC60b+QatQSPfnitx3FlWTQ3kIhgOIFfrE7o/vtjCh81p?=
 =?us-ascii?Q?GTdFr3iRy0YlI1EK3es6+0U3XKxz2+OTxW9D/bzc6mJLBzECysXmINq2+iNf?=
 =?us-ascii?Q?gwNxxhQYRui+Te+GlG7sfuk4vuvpw4AWXKKs9ZmbgOsA16P8yWB4Fj/PWcFo?=
 =?us-ascii?Q?NxgBrw5h4ChjaXPkUPvzJJ0oo54DKmv2h8vKzeRzW5N1q8EHN38P2kypQS+9?=
 =?us-ascii?Q?T9FcgHBCycphB0mqTEl1/h+6GgD7z/ChXWX+FL5C5o9n6+UquG8y5LgIiBoX?=
 =?us-ascii?Q?/NYyfVdGy12eU/af8HTg2YrXZvMt9nPNzQSB/CBEtOunEknVKYkjaKq2UqZN?=
 =?us-ascii?Q?gjjTigCqKomzYA0u9WBoGkbHxPBifGqa1J1u2spFCPxGx6seweDHioDRE7FR?=
 =?us-ascii?Q?KcLWXPVyJvszfnUoJoOm9fGF3nl5e9m4h6OK2b5jRPoNAtPdGnHNJlaB98X+?=
 =?us-ascii?Q?39IJRihD2Rynwx4vAOK/M5HaESlYkU9PreHuX76YKybbm+xXXqkQLjvNhBTT?=
 =?us-ascii?Q?Dm/5LfJMulxWOA/mlQMr/6GYho7e6epGc86aL8jSiH9C0Lmak4xrSiUAKwbc?=
 =?us-ascii?Q?nO0n0XfX6jS+4ss1VderwQd5Lx80dAmrYdRqn0+K/Wlwp6T7cQsR1CSEVIAk?=
 =?us-ascii?Q?xouRKM0DoMP4HUD1Za0AIAMuqXJ8IWgChYSDZRHPxuujqLN1qsqIsjq0LPpB?=
 =?us-ascii?Q?w1t3l8GpCjgUzQ91qSLAFBOJgIG5ePdgDP8WuujhCSjg66ypnuuPWd0PIPHU?=
 =?us-ascii?Q?zhJ4ZipcLnzEoB5MSClQX7hLi94f7Q9dFAhV/KkvO9Yrslk7WGW627RnZO35?=
 =?us-ascii?Q?UlB6HW7gLYHoCBBnFbsknTf8Rx/VMSQkN1cJxq4mJ2334f604odGCASusRsO?=
 =?us-ascii?Q?c2xwfhbdC6hSQBtelWrMJEqUcydpnKYIkkvp6elmhrFrOvH1il9d6LbbIV/0?=
 =?us-ascii?Q?lR6PsSINoye/dO20sWUzyDhaxik7Crgf7FVCkvLyfuZXc9d5w+TBmQ9WLKl9?=
 =?us-ascii?Q?7vIIf4TupU7p9BGdOoaiIdvfFAVdI3na5XxweWyKVdhUvDWbMLvBz4napIYp?=
 =?us-ascii?Q?f/mhFWtisdjE9ZoJv45T/yl1zWxYRsfWXvhX70zovzFgYOtzt4uOwAaz2fQ6?=
 =?us-ascii?Q?ke+6SgH/vgtaitVLJg3mC1XTisZQQtYqRoZTIpWn2gjNqmdHmGT94DElEbkC?=
 =?us-ascii?Q?gnBJMuEr8fNTpzBAbh+sUpmKld9R+YPo7JVmSowalIZTXi+kam4omgktf3Ga?=
 =?us-ascii?Q?G+QLpgND46qNB4goZt/pfU4hPevyYvbI8R2hkozV6UikLwGOI4mOkVAM0qIr?=
 =?us-ascii?Q?wUNqjW07XBR+yhWZxNFXsbnAKogQAk6NtaUp/zyYzgcK1SznRLF8FJH9MX6p?=
 =?us-ascii?Q?IyqZkhp93aXYAwwU8snaCYtpUigrhSD1yM0e3TwwIBIm3rBXguGaA+lPuLRF?=
 =?us-ascii?Q?KEDJDNi2QnXSq5Q5Q2PHlRuOsTQ9YbDW6wxEmVUuGlt94HC4Ocr29/YWsD1p?=
 =?us-ascii?Q?eXcNjnFTQQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d9e0a8-cbc3-41ef-3652-08df04b580fd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:36:11.0689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9zF0HsTxbqYJHzoXPkJyxWN9xmD5ZbmjA3lwFOKbyPsg9kmlWsabPgG4lNOwwMXPPAKJD/m6UTfcXx1prwJfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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

Add a helper that writes as much of an AsBytes value as fits in the
remaining userspace buffer and returns the number of bytes copied. This
avoids requiring callers of versioned UAPIs to convert values to byte
slices and truncate them manually.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/uaccess.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 5f6c4d7a1a51..c63b91942631 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -624,6 +624,20 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
         self.length -= len;
         Ok(())
     }
+
+    /// Writes as much of the provided value as fits in the remaining buffer.
+    ///
+    /// Copies `min(size_of::<T>(), self.len())` bytes to userspace. Returns the number of bytes
+    /// actually written. This is useful for versioned structs where an older userspace may provide
+    /// a smaller buffer than the current kernel struct.
+    ///
+    /// Fails with [`EFAULT`] if the write happens on a bad address. This call may modify the
+    /// associated userspace slice even if it returns an error.
+    pub fn write_truncated<T: AsBytes>(&mut self, value: &T) -> Result<usize> {
+        let len = self.length.min(size_of::<T>());
+        self.write_slice(&value.as_bytes()[..len])?;
+        Ok(len)
+    }
 }
 
 /// Reads a nul-terminated string into `dst` and returns the length.
-- 
2.54.0

