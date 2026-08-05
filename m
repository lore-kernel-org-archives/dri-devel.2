Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9CBC55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAEBA10ECC9;
	Wed,  5 Aug 2026 05:45:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GAeZP8/B";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D74F10ECD3
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ryj9WyJP3ktXDipHrfFLVm4JZ7rpcGt35aiQ3W30cvvMcaAEX2a5SMgT8SBzQudmrN8jYt6L8QfOnr7PV0feOvFG0VjwU3AtODaNyE7z9lMBpVRaPwostNSqhC9NGcIdyaKMWvlRp0lYDLD5HIkwv9CBRsTFCnzCmI7eT6GIozzr0IpDu9aQBPEzfRXClYQ4bNhrFsOzaTedsQHJdkgKtj2VeUN0gaqzYQrY3vHNTN/Wp5xn8NIV4a9rBy/YYfdB46xR7LXN3famUYwFXVLE5hZchzNSaZW3j+EC9qX5XU3BBLuYsDI1TlawcBLJ1GDhKVtdtVOwifJAzAxLOD78sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYdcRxrmR9ZZZWUGKTKwnxdx1tZFHmIwLuvmgSPSEu8=;
 b=FUolfDf13Rhd6lhffc/Z7eirgkBmFQpd+7mbHw7dd4w+6jNSl/RyESlWeqYJxTKUu+mEeTJXHRQPgknXyfbWP54tMFGWXi7s/mY4IAHtf2fIk6KvEgGtjpg2ZDaUqsV+XLYiInkNJKw8BULQuIH4/UWTRjktB2+pFVr8cxkLWeg0yc/xmVyibE+aZ0EgF31gl64X+JUl5khwAq75S707ZiQVgrf+C48aGDl2j2BxTs7tztqgGnV6jUV1nxc7wT2acbN2QPHD2o7uXoPzHFkKR1aa4Qq3I/A/EpUcQW2vaOsSDA1OEMIXsjxgP4WXZgjmEig9CblWjWDFXfRUeGFXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYdcRxrmR9ZZZWUGKTKwnxdx1tZFHmIwLuvmgSPSEu8=;
 b=GAeZP8/BqlM7NuZWTseQj+LoQndbkE4+dOJznjTqVaqMr9LIFpMDYC0JpVxkc6f2vat934Fmuraw2Sdu+jv0fRi2j9nhDLG7YtBNA2hpranrVu+ZBuDaCeSTVduqttvCZDNClsPAMEkY0yo8xsFe1KEoOHdqdYes0iIe+o8Hh8tU3e0Be3S9RsIDwDvONfsMqqLNndtDXsnK+Q96SejLqYveMYOCyOAYn50hP04cpE+fHUv432uUzuS49CNSStTbQXVAMQ2MS9ucK6K10ulYzfrcKar5I9pOY0hze9hUguZmOuBWUOpxGQmmF1n6M20QomVzQ6T7FVPTZR5Lje6bFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:23 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:23 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 05 Aug 2026 14:44:50 +0900
Subject: [PATCH 03/12] rust: num: add Bounded::shr_exact
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pramin-split-v1-3-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Yury Norov <yury.norov@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: cec24349-d8b8-4dc2-e3ac-08def2b4be32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|10067099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qQMwLGpjvHTkYuillehp477hj5vb+dvDfJOr6PnlJiMOijBirhaCSOgWsSqFaO+rvjz9K0zw262A0GkLNck9w9WnOzFNJETKyE+uaZcX03IrqMU5P5HWCOIYK1YDZ9dX8ueHYINi5gCw6ACpIXM1pNQSv5aq5z9DMVgdhHBHrAb5Xtg878mlzFS1SqmLrxAVoIV1Bg0F/+3OFUR/LCGqj1hWMqJ+VhHMIfrsHlVDSlDwPN1td/KV4J2zTUzxJwVns/K5mKnKbG84GPuedc7E27v/kS1X27lSShQs+CfZQZM/4P5JKnRF1x8UmhEdERljGiBff1CI83Ui6gkF/nm56BCh8/PUKS1Np0fFgGysDpOeF5M44L1fT301tDHwNr7+UXNoGCa9Vme8fvjrh1hmviAMwjKHwmk1Xpp+Ef8fvz7zMzTqFBbwOKPCoV4IIAKd7jeC9ILIgQ/Rh3NUgmyek8xJYfKW3Y/d8U2w4ag7z8v+sur2P/8VVY+kclPl3ZLi5ITrzhp9hFpZrEVr/e4veIQno0phJjkgIL55N9O57VXKp0lcTqXpvh7bVLRaH/hqmLoWfWlJSJQl9f95HHiuM1iX2Iz/rvyYLT9DfYahgsZDe1Io3WN3kLT0rVhvAWwBwDCRneXh+9g5dl9QV/N2tbI5XdKq/juMbh+YRFdUJPTlEA6SH0zvhCj8q2DVAMc2KErssy7PN/XQBVOdfHlorw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(10067099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9KcnQ4QzRDenRCRGxjYjJGZURWV2dIZU04S3hMWTBJaHBrM1AwN2srYm1n?=
 =?utf-8?B?SUs5SCtld3FVYlR3YTlveS9yRVQ1Yk9pdElhaS9Oc1M4TlZKeXlldkxoMDlp?=
 =?utf-8?B?RWFWRXhUT3QydHkyaUZ1d3hCcGMyTm9FOWF1d0pkSFdzYWJENFJvb3pDb1JJ?=
 =?utf-8?B?QTZCZ0RUU0N6d01iNWk3VlYrUTVMcTAwQnQvbFpzSDJtUTRsaHErY2dab2c5?=
 =?utf-8?B?SzZ3cWwrQmVKaDN4T3FqeFY3b0RHMnZQNmkvY3VGaHp6Y2lPOWhsK3N4YWN5?=
 =?utf-8?B?MFBxcSs4VlFKRlNwUU80UWFQcGpUNHp5RzM2SkZKVTdZYkFsRXBZMXlTTDJs?=
 =?utf-8?B?NVFSSStIVTRqcHdiRnVOSXFwbHRxOEU4dGpQa2EyMjZFOXhGazUyTUN5d1Iy?=
 =?utf-8?B?TkNMakJlSjA4Rzg3R1lZNGduTWMzZXg2QndxdHRIMnNvL20wZEhjL3Vob1Zp?=
 =?utf-8?B?NTJxd1Byc1ZFYitZV2c3QVlDYWpLTE9SQ3IrdXFBV0RtUXRVeXFyZlA3NmxN?=
 =?utf-8?B?dGpCd3FFNkJmNE5IeWtSeFhocEFoT3IzUjBObWVlSFBraHgxcHE4cWNmTk00?=
 =?utf-8?B?eFNpdEg1RXhhNVp1U2xsdlF3dnU1OXlva2ZFckFDUFpBNTY0SDljT09xWHFz?=
 =?utf-8?B?M3ZKb1JReE5OcHhaeUZacllINStyWmJuTTRkNGloYlVDT0crVkI2RkxMT3NR?=
 =?utf-8?B?czArMCtKSTNKTVRQRjF0UTlaQ3pmeEM1OGpUS3RZVS9hd1c1eW9wUDRBWC9r?=
 =?utf-8?B?eGxtK2U4NzQ0VGxpbzc3Q240cWQ2bWJEM05CczA4VXpmQmxtNEwwU0srbVNx?=
 =?utf-8?B?REt2dUw5TE1LMHpyRWJTTUc2a3NKQkYzWWVYUXFMbGR6dHdyYTh0NFlMTm1C?=
 =?utf-8?B?WC95YzJhQjEzaXZSdmpiWmRkUVpNSTZhSkc3M1lBRkVOdmM5RnpiNGg4dlox?=
 =?utf-8?B?VGtsS0Q1dlI5bEluZlNMaEVWdWM5VXFqVEFKQmdQblBBelIzclgyODFwNGg4?=
 =?utf-8?B?ekRwYXNPWWJKOFp3QjNkOFhybkd4Ymt3bnhMNWpyenBXaXAzVDFvUmRrVXFN?=
 =?utf-8?B?czBWRFVDUlpYdUZlSDVMeGZkYXpKb1U5NG5TTTBxK210c0Z5RzB5SjI2MXdy?=
 =?utf-8?B?VG05a0JiY1FiU01vWFBoQ3lhNlFtQTcxbFNIWmUzMzZUQWFtb29OM05Qa1Zu?=
 =?utf-8?B?emg3aHpmcHJON1hQa1JXaWVXclY1eVdoQndHK0J0QVVsa2FPTGJYc1Z4MTJO?=
 =?utf-8?B?T0dvRGlQVEVtWTVCS1c5Z2tpR2IyQkxoSk02K01ncGJWcjJNMEh5TUVscDMx?=
 =?utf-8?B?SUptYXFCYVZNdUw3dDI3c3E0blJHbUducS8vbGhhNGJESW5NbWFxb3liZ0Yx?=
 =?utf-8?B?YmJjS0FVNkx3SmVXUTgxa3M3cjYvdUd0eU80aVVxZE5wK255WWdzK0cvOThD?=
 =?utf-8?B?M3JmZVZaLzNZWVZrM3VZVzRFUURlS1lvaWFMZFM1b2tZaGtzYk9lWDVYSW4r?=
 =?utf-8?B?VEQ4UHU1OHBLeWZxRVQ4Y0M3SlVTbThJNDZSR1lobEl1NUNaTG10cW9EL3VI?=
 =?utf-8?B?YTVMWWRvYWQ0U0xEVFgwb2Z2djd5Tnl2ZzZRMFVTaDB3VHpwTnZpYXlNeVRC?=
 =?utf-8?B?ejJaZkJBMmhRRk5UbHl0SlpiWWQxdlhzK3VnUE9QZTJjTkdaVGRQVVVRTE9h?=
 =?utf-8?B?K3E2QVJPVXVlVFZNZ25WNVp2NDI1ODR0K1FLdmtPUVVTajJCRW1yVytjeFI2?=
 =?utf-8?B?d2x5NmJMbmZ0Q3F0TjlxeGR2a1Q5ZlIxZlc5Sm9oZVpqUnRidWh6bVRjdkJz?=
 =?utf-8?B?a1NhQjI2cldSeTNOL0MxSzRHYUlRWHJHY2JYRzZIODV3QjBHUW11bmdNYnhm?=
 =?utf-8?B?VUxOaGY4YTR4Q0RJdmV2amIvYkRuSG9hQnZQcy93ekVsdFVQYWVGUU1EM1dr?=
 =?utf-8?B?ZzZrU2tDMkV0OEg2a1p5Mk13OFM4TzgxY203blZKeHl1YlZKdGUyejY2d01T?=
 =?utf-8?B?dDEyV2Z3aTcwSFVSNE5vZXBWMzJUYStGRUNjUTdUVzJ3SlhsUDVTdU85dksv?=
 =?utf-8?B?VFpUcXZ3c2JJVHFZancrUFFiQks0NEpQOFNJdGQ3WnZzSG0vd2RGME5DaVB1?=
 =?utf-8?B?dnk1eXVZSWNyU1pjSUlsYjdTeWdiM3dmb0VsWExqMjBNNzhRbmZzVzBOZ21p?=
 =?utf-8?B?RE1Ca0xNT293OEp6cDJFR0FLUHF1eTV3bDQrQ3dOeUJQWHBaOWVpb3BodWlh?=
 =?utf-8?B?NCs0ZE1MbUtnb1hTL1Nub2ZQM05ESzRYcm14aUVjWjh5R1JjUFphWjFCOUtW?=
 =?utf-8?B?ODlTbG40cFBWMGpMd2tQQ253K2lSVXBoSmM2WlJWdU1ocDNJckhHNzFheFJG?=
 =?utf-8?Q?8ZUBy/VQQTUri5L0v+n3fVpB3GvIvxPbSu6BdGkKjBg9b?=
X-MS-Exchange-AntiSpam-MessageData-1: pyrkm0bA5i3jbQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec24349-d8b8-4dc2-e3ac-08def2b4be32
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:23.3905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8Kap7d6DgEjG8Te/Hkg0LgLlVsko5++hgv3YV3uM8tAwP+Js9dXQ3PfciBR4xQcHuNQ+tiKXusVRNJcWfPX0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

Add `shr_exact` in the vein of `try_shrink` which shifts a bounded right
only if it loses no set bits. This is useful for getting a shifted down
integer while simultaneously checking that it's aligned.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/num/bounded.rs | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index f263107f001e..2695a7858d8a 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -493,6 +493,36 @@ pub fn shr<const SHIFT: u32, const RES: u32>(self) -> Bounded<T, RES> {
         unsafe { Bounded::__new(self.0 >> SHIFT) }
     }
 
+    /// Right-shifts `self` by `SHIFT` if that loses no set bits, and returns the result as a
+    /// `Bounded<_, RES>`, where `RES >= N - SHIFT`.
+    ///
+    /// Returns [`None`] if any of the `SHIFT` least significant bits of `self` is set.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::Bounded;
+    ///
+    /// let v = Bounded::<u32, 16>::new::<0xff00>();
+    /// let v_shifted: Option<Bounded<u32, 8>> = v.shr_exact::<8, _>();
+    ///
+    /// assert_eq!(v_shifted.map(|v| v.get()), Some(0xff));
+    ///
+    /// // A set bit would be shifted out.
+    /// let v = Bounded::<u32, 16>::new::<0xff01>();
+    /// let v_shifted: Option<Bounded<u32, 8>> = v.shr_exact::<8, _>();
+    ///
+    /// assert!(v_shifted.is_none());
+    /// ```
+    pub fn shr_exact<const SHIFT: u32, const RES: u32>(self) -> Option<Bounded<T, RES>> {
+        let shifted = self.shr::<SHIFT, RES>();
+        if shifted.get() << SHIFT == self.0 {
+            Some(shifted)
+        } else {
+            None
+        }
+    }
+
     /// Left-shifts `self` by `SHIFT` and returns the result as a `Bounded<_, RES>`, where `RES >=
     /// N + SHIFT`.
     ///

-- 
2.55.0

