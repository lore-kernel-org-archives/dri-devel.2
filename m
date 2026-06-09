Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985B5CD98C5
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B1A10E463;
	Tue,  9 Jun 2026 15:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="uijsNF/V";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021099.outbound.protection.outlook.com [52.101.95.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F61F10E3F9
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHuwa/HJTJuPsRV8v8jNDY2nZ1cIA3yq3CGWZ6eRn7ztZC1LIfUuufqbu7Jkjn/EksORF5K2pmDcj0qHWhFvbNLtKQaEtbOvuqjqeRDWRF6zqtQ8HglOu7Vyi8AKGKdEwDcxgUhytdXwWG3LTEllRQXhEcNCuT1WybPJ946GHtzGbXIwm0exn4sObjGn7ypL0NxeTNOUKmCIRYoYAUNGkjUOYqXf9AE3m/j/sIzC/vJA49pmDV0TSvkjjEAMnPposDOkp2RlwUznwMagX/ldUiE9L/8nnCqe+4vLZwi5FtxSWTdWk4R7v24B5u2+YdkfXxO2DlIOca+XhOAmXduuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCX98HN2c9d25qlpIZB8yb3q+oU/LM3Cdz2twWdFASg=;
 b=OxjRQpOyQBVmMxragZA5w5VeYx6w0OFaFrbCGTHqpCzvM7lJiplmLjL1UHvCpvbiMnJcMOOzFWdRSlOmvaW8G08JZej48CK+L70zgVOh4gHV1gmA61Dw6b8O5ChpWFQKlF2zXlYfd120YtN0/b2gy0pVu9Gugwwh5vMrMT05LR3VWPU2ExOwRIgvheKPL08eOxEIIMS6v27TA5vHouDMx45h6ObxRhzF1FgFAeQezG9RNiPNr57iE3lCWEGueAQjBHEsUk2ibP+5LNG9Ybc9SpRV7cT+5nRF3s/g8nwHfwsZow0BcCn9aTVYlrfVIaEogpD39JJzVBXxZ5WYNAqX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCX98HN2c9d25qlpIZB8yb3q+oU/LM3Cdz2twWdFASg=;
 b=uijsNF/V+Wo+Rj/yFD4W5Vql9UN1IoMxZlDWO6uGPINwUheSHiu1gO3aQVUb9fxyhdV2kFQbhqv8+48CY3aLkHt8XXThLqL3uKugVdDCyfTm5LClRXVOXRkln/ApepCnbK1RyJIKOACj2LHbLw0v5aj5E8uWz7vkK6NC/Ml+ad4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6167.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:183::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 15:38:59 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:38:59 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 09 Jun 2026 16:38:38 +0100
Subject: [PATCH v2 2/4] rust: sync: generic memory barriers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rust-barrier-v2-2-30fcc48e1cd0@garyguo.net>
References: <20260609-rust-barrier-v2-0-30fcc48e1cd0@garyguo.net>
In-Reply-To: <20260609-rust-barrier-v2-0-30fcc48e1cd0@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Gary Guo <gary@garyguo.net>, Alan Stern <stern@rowland.harvard.edu>, 
 Andrea Parri <parri.andrea@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
 Luc Maranget <luc.maranget@inria.fr>, 
 "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 lkmm@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781019537; l=6215;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=wG4s0Mlub6+whdzeHqbgBmHcmK1O3EYo/fHDF5pP2po=;
 b=AKArYWjZKafa37olqd81KKgaw2WERoLhXOgII/oJTgjpdQsvJ2z+B02io15KIxA+VpD2mSbBf
 cqwEfiWal2sCdsTk74twn7DsJgFDsNN+1fWVRJbJ+wHAazRcA/t1yKL
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfbd3ea-5d6b-40a7-7079-08dec63d3948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|22082099003|18002099003|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: VMIUJu1MiLH1v3O8cL2vrNIRzypYtDpEaP2WNwIT2XWGEb5LQCpSQ38KV05Ensm/Leemy8YlCDoUzJGMIXG956WwV7aikPocgD/C32e11LZ4uRSmj+zAKX65Hix/RJr+v+gwuNTxNA4VbiGtlZ01mTnr7sfBA1ODS3xoOa4gYFW6hljG5G+1thgVx7UFaVGtf70Q7IvDpICDRtR6+fp+N9O4wsLAZqIaIqm+hgxOW8JvHc43pKK+XuAsOe9g05MG0lkx/E9ElpUVK6jpxF2W2fnBuuIK4cKamcJEuioHlCtRGENJ/CacnfsT0EoR3vanx65kZWjPv546uiLJTdFj03nyhshJHUFwmtkjWq3tQs8c0FFQpPA7CbxgUQ7fNdv7jNngW4jrQskm5fLvMDCvua14MpEk4GyNshdrKviZcFDCrKgDsAkoZn+4qxIAYWdIMYRoQF1PkjSbjHOVj7IyYbOA2Sfv861fkDqC80WqCQmlOP1WZLvCk1XbtMrDg4yei7uc8Eh4QQCBwYGTnsXITFumQz/WhUk5HTwaw24Yyf2+qC3BoVzc+B9cG0KIbw7Bu5lOAPkHWfmhuYeczVUgwdDLMN7hMAH3Sffy37FaYHgiSEGhZ5OB4nOjhQnb2SsRfPtovOpYpzG8Bdz4enCJoez6p/9pkRORAm3rBAjrs5jyiDuHDbxaAs8gsTWmtxcD825VajDALxOAEG5GVXPJx4xdf7AlAuum/4/4IMOoxPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(22082099003)(18002099003)(3023799007)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVBYmxsTC9wME45aGFXOUhybGE2Z3ZHK2VaVVpCbis5aHR5VEZEUWxBZk1J?=
 =?utf-8?B?dXJ6YW96Ky9DNnh5QmNhVkZpaERqbDRXSTFuaFY3SHQrbkM5cTNBM2g2YTZi?=
 =?utf-8?B?MXlkV2JVc2s5b0ZuWjl2WEt6MUxHSkFvcWMybXlIcGpDL2MrTmswd285eHoz?=
 =?utf-8?B?U1p5WGVTQnNjbFNGUTlhVDVTRlRkcDlnNkJpcHNraTNBT1QzSGxiRG1Vejk4?=
 =?utf-8?B?LzA1cElkSVhnSzdJVmpWL3piL242OWFmVjlWV0txTVltU2JOSm1NelZnZ0kv?=
 =?utf-8?B?Nm9LalJ4RDFlNHZHTkFzVXNJZ2p3OGlHaEVJOXV5T2Nmc1F0MU5HVitzYmhp?=
 =?utf-8?B?WkhyaCszeXRWdkNLVlZ3bEdRL0VJOVZEVGxGQnIxYzFuRko1Y2xnazMycWM2?=
 =?utf-8?B?R0x0QmU1T3RWT0NwdUozYTg4L3JxbDNqb2VpajUrSDIzdVVtWStjczlxOW1X?=
 =?utf-8?B?L2M4dFZCUGc3c0hUcFR4L2xYOVc0ZFBrM1lwbWphNVVRNzdlSXNXK3Zrak9v?=
 =?utf-8?B?YkY1K1lrbm80K1dudUNOOVRjKy9oektFMlV1dWhrdnEwb3Blbk1NVUZsN1Nn?=
 =?utf-8?B?UmIvTjRLK2pqbU0xdHZVb3ZGb1VBSlo0aGFOQWE4N0NXN1E2RUJqQkFETzNh?=
 =?utf-8?B?d2VxaGtKNGlsUGpQTlRrakV3OWhWMkF3S1hpRFJpdTFMQ1hLL0Z2a09rM3JY?=
 =?utf-8?B?LzdzL1JIUDhmQi9VR1MzOEp3SE1NNmYyVjF6Q1hNcWpLYUxPYWU2NldoREF0?=
 =?utf-8?B?NVErTGxiTVp3SjNld0hDblRReHBzZmdteGc4aUJYQ0g4cFlneHlmWnR2N2Rt?=
 =?utf-8?B?SGp6YzlwVGZQb0Jmek9uZ0NTaExtRE1VcXBuWHhIMTJ6M3REM01kRVd3TjRY?=
 =?utf-8?B?Q29yUTJrRXpCTG15RzBMVHZmSGQyc25PT3d4cDM5ZG54T0JoeHpqMmg1QVVP?=
 =?utf-8?B?QkpXSkt5eVgzVkJTVDJsZkEzSitiakZBZG9tSTFUcWF6SFVjTHgza1l3Wm04?=
 =?utf-8?B?TFVaL1B4Y2VhV0oydkJRQXZuYkxac2Izek9qbTV6MXJRTUVHRUNQbjhMZk1C?=
 =?utf-8?B?TEVYYnF3b3lGT2RVVXRBbmM1aFlvbm1UbEd0UnJjcVA2Q3l2YmRWbTRHcjBI?=
 =?utf-8?B?dFUzS1NtTnlOdEVRdXhpdUtmREVFeXZUUFJNVzAxOEV5eVlrTWt1SHBGeDZF?=
 =?utf-8?B?RkxwcjFpWjRMRXNBTVcrQTNMRTVmM0QyaWQzQTd1YnJnYXhORnMzUHQ4V1BN?=
 =?utf-8?B?ekZEa3BBVkZtS0FEcDU5Z1FoSVVCbERxcnpiQkZpQ2orZy80RUU1MHJMZGZY?=
 =?utf-8?B?QjlkWlg3VDB4azhnM2ZBeWN2YnBEb0lNSmtNOWxNQmE0eVJzS0lLTDNreXpa?=
 =?utf-8?B?bzVuYTJaOEEwRmU2Q041NEdaSS9XWUxjZUI3ak00WXFWd0FFckt6dllYeEI1?=
 =?utf-8?B?K0pBVDRSV2ZxR1QrQ002em5vVnROMFRzZHpJeEFYVEJKTEpWMEFyOFV5Wi8x?=
 =?utf-8?B?VVZNakwxOHN3TlFINWk3M1J5Y05XaFZHSG5SRTMzMXdDZmdmOHVEWjlRREgr?=
 =?utf-8?B?UmY5K09SSTVRbjVZWU1sMmtuV2wwc09nTFoxZzB0MEZKTWJNdkpXbmkyNHVQ?=
 =?utf-8?B?K0RmYjdDalpGZTJFR2dtVWVLSUxWb2VkcExjZTAvazU4QUhYZ29CY0dhM2tl?=
 =?utf-8?B?MGowQmNHbXpJeUNsSkVjMU5ZZkdhemUrVFRqMlFJNnZFbFJFYVZXVkJMRm4w?=
 =?utf-8?B?KzQ2L1JDUUtjZWtrTThBRy9jNzIyMzRYenBvN2dXdGpYRlRFc0puVVdUSml3?=
 =?utf-8?B?V0YzNnk0cU1jNkNkN09GdUhqeDI2M3hPcEN0RmRPcWhYOEFwc0owVWkyV1RT?=
 =?utf-8?B?azhZVVo5T0xNM3lxcE8xOHZWN3dveHVzWFNUeEpyNk9pOUpXWkF2MDhpcnBQ?=
 =?utf-8?B?YjZLb3NtTFdhc2d5RW9ETklDNmJicFJwc0pMQ3p5RFpSSlN6a0xuTEZyeWR5?=
 =?utf-8?B?MDlrMWZNNkpidC9KMnZCZTc4OG5QNUlORWw5b0F1Z1IvMEc3d3BCVG9uaVBH?=
 =?utf-8?B?aDFyMGhSbWY3QmFYUkorSGxYNnRJVXRYOFZIOHUxNHF4YlI3cUJKUWwzMVhi?=
 =?utf-8?B?eHZINVdsSWRjWjN0ZnRiNCtoQllVM1hSMTBaeUY5Z1RRVmQwR0ZEY0Yzc0NB?=
 =?utf-8?B?T3B5cFpvMW5NQWxVZ2RTRXNxNnRsRHpVcWwxSk9uc2lUNWpycjNZQ0tiL29p?=
 =?utf-8?B?QVlIcjNKc2kvdko0ejM1SmRMQWFPVGVHZlJXY3lkQ09qOXUvaURKTTVBQ05L?=
 =?utf-8?B?M055VnFMcHlGMmhQb3BjMmh1LzY1OHFBZmNCWlljejhDOTQ2U1lNZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfbd3ea-5d6b-40a7-7079-08dec63d3948
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 15:38:59.0138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9ZJnqfU3S0WXC3nYx+4JOoolwqZ5zGiDFaoyQuyRNIPEn37RaIchi/OcMZ8p1hJLnqlDwErdCmWBmjVIYzx1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6167
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

Implement a generic interface for memory barriers (full system/DMA/SMP).
The interface uses a parameter to force user to specify their intent with
barriers.

Provide `Read`, `Write`, `Full` orderings which map to the existing
`rmb()`, `wmb()` and `mb()`. Generic is used here instead of providing
individual standalone functions to reduce code duplication; for example,
the `CONFIG_SMP` check in `smp_mb` is uniformly implemented for all SMP
barriers. This could extend to `virt_mb`'s if they're introduced in the
future. It would also make it easier if new ordering types are introduced
in the future (e.g. `Acquire`, `Release`).

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/sync/atomic/ordering.rs |   2 +-
 rust/kernel/sync/barrier.rs         | 123 ++++++++++++++++++++++++++++--------
 2 files changed, 96 insertions(+), 29 deletions(-)

diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atomic/ordering.rs
index 3f103aa8db99..c4e732e7212f 100644
--- a/rust/kernel/sync/atomic/ordering.rs
+++ b/rust/kernel/sync/atomic/ordering.rs
@@ -15,7 +15,7 @@
 //!   - It provides ordering between the annotated operation and all the following memory accesses.
 //!   - It provides ordering between all the preceding memory accesses and all the following memory
 //!     accesses.
-//!   - All the orderings are the same strength as a full memory barrier (i.e. `smp_mb()`).
+//!   - All the orderings are the same strength as a full memory barrier (i.e. `smp_mb(Full)`).
 //! - [`Relaxed`] provides no ordering except the dependency orderings. Dependency orderings are
 //!   described in "DEPENDENCY RELATIONS" in [`LKMM`]'s [`explanation`].
 //!
diff --git a/rust/kernel/sync/barrier.rs b/rust/kernel/sync/barrier.rs
index 8f2d435fcd94..54c527fdb760 100644
--- a/rust/kernel/sync/barrier.rs
+++ b/rust/kernel/sync/barrier.rs
@@ -7,6 +7,34 @@
 //!
 //! [`LKMM`]: srctree/tools/memory-model/
 
+#![expect(private_bounds, reason = "sealed implementation")]
+
+/// Memory barrier orderings.
+///
+/// The semantics of these orderings follows the [`LKMM`] definitions and rules.
+///
+/// - [`Read`] provides ordering between preceding load operations and succeeding load operations.
+/// - [`Write`] provides ordering between preceding store operations and succeeding store
+///   operations.
+/// - [`Full`] provides ordering between all the preceding memory accesses and succeeding memory
+///   accesses.
+///
+/// [`LKMM`]: srctree/tools/memory-model/
+pub mod ordering {
+    pub use crate::sync::atomic::ordering::Full;
+
+    /// The annotation type for read-read barrier ordering.
+    pub struct Read;
+
+    /// The annotation type for write-write barrier ordering.
+    pub struct Write;
+}
+
+pub use ordering::{Full, Read, Write};
+
+struct Smp;
+struct Dma;
+
 /// A compiler barrier.
 ///
 /// A barrier that prevents compiler from reordering memory accesses across the barrier.
@@ -19,43 +47,82 @@ pub(crate) fn barrier() {
     unsafe { core::arch::asm!("") };
 }
 
-/// A full memory barrier.
+trait MemoryBarrier<Flavour = ()> {
+    fn run();
+}
+
+macro_rules! define_barrier {
+    ($([$flavour:ident])? $ordering:ident, $binding:ident) => {
+        impl MemoryBarrier$(<$flavour>)? for $ordering {
+            #[inline]
+            fn run() {
+                // SAFETY: barrier methods are safe to call.
+                unsafe { bindings::$binding() };
+            }
+        }
+    };
+}
+
+define_barrier!(Full, mb);
+define_barrier!(Read, rmb);
+define_barrier!(Write, wmb);
+define_barrier!([Dma] Full, dma_mb);
+define_barrier!([Dma] Read, dma_rmb);
+define_barrier!([Dma] Write, dma_wmb);
+define_barrier!([Smp] Full, smp_mb);
+define_barrier!([Smp] Read, smp_rmb);
+define_barrier!([Smp] Write, smp_wmb);
+
+/// Memory barrier.
 ///
 /// A barrier that prevents compiler and CPU from reordering memory accesses across the barrier.
-#[inline(always)]
-pub fn smp_mb() {
-    if cfg!(CONFIG_SMP) {
-        // SAFETY: `smp_mb()` is safe to call.
-        unsafe { bindings::smp_mb() };
-    } else {
-        barrier();
-    }
+///
+/// The specific forms of reordering can be specified using the parameter.
+/// - `mb(Read)` provides a read-read barrier.
+/// - `mb(Write)` provides a write-write barrier.
+/// - `mb(Full)` provides a full barrier.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::sync::barrier::*;
+/// mb(Read);
+/// mb(Write);
+/// mb(Full);
+/// ```
+#[inline]
+#[doc(alias = "rmb")]
+#[doc(alias = "wmb")]
+pub fn mb<T: MemoryBarrier>(_: T) {
+    T::run()
 }
 
-/// A write-write memory barrier.
+/// Memory barrier between CPUs.
 ///
-/// A barrier that prevents compiler and CPU from reordering memory write accesses across the
-/// barrier.
-#[inline(always)]
-pub fn smp_wmb() {
+/// A barrier that prevents compiler and CPU from reordering memory accesses across the barrier.
+/// Does not prevent re-ordering with respect to other bus-mastering devices.
+///
+/// See [`mb`] for usage.
+#[inline]
+#[doc(alias = "smp_rmb")]
+#[doc(alias = "smp_wmb")]
+pub fn smp_mb<T: MemoryBarrier<Smp>>(_: T) {
     if cfg!(CONFIG_SMP) {
-        // SAFETY: `smp_wmb()` is safe to call.
-        unsafe { bindings::smp_wmb() };
+        T::run()
     } else {
-        barrier();
+        barrier()
     }
 }
 
-/// A read-read memory barrier.
+/// Memory barrier between local CPU and bus-mastering devices.
 ///
-/// A barrier that prevents compiler and CPU from reordering memory read accesses across the
-/// barrier.
-#[inline(always)]
-pub fn smp_rmb() {
-    if cfg!(CONFIG_SMP) {
-        // SAFETY: `smp_rmb()` is safe to call.
-        unsafe { bindings::smp_rmb() };
-    } else {
-        barrier();
-    }
+/// A barrier that prevents compiler and CPU from reordering memory accesses across the barrier.
+/// Does not prevent re-ordering with respect to other CPUs.
+///
+/// See [`mb`] for usage.
+#[inline]
+#[doc(alias = "dma_rmb")]
+#[doc(alias = "dma_wmb")]
+pub fn dma_mb<T: MemoryBarrier<Dma>>(_: T) {
+    T::run()
 }

-- 
2.54.0

