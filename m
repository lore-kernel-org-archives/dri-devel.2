Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D486C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC44210E390;
	Mon,  6 Jul 2026 12:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="0RrTmfhe";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021088.outbound.protection.outlook.com [52.101.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF3910E906
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2h2dBNcP1NscQcqSuXuHhjZdPWk2GJezglkxEK17we2GTputh95YqH3r0MNwKNGHLBsszIX0Hxp+oeGPuBL6D0ECk31Vxh+PZgM+v8I8+znJ2iusgyJOLmq388iUDCgb3gwDzjg7df/HREAntq85tt0KQRsxu0IaLy6wXw7sF9RnUYZCd8pQxjE9rPxj/VV/QQPLDIhBxHyIp99pmUG+NNF4kxH/cLe8op4vX/17armU/EwsRwUd5iGg0FsBbOiYYwFEvjgOFBEAuUOT2y5SL0onvE084CypUEZyUB59UQ+2jhd07RJe/fXH+qUamXx8+FtJFNio9ZP+OebRg8WfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtVhrOSpKIlxtMhm8722plFmIijkG0TcrbBa9tYYOV4=;
 b=HoRcXKwYvxNCTqMuvy5CObUXKa63r+EEnlM76soZCxKzVYVq0rczbK5qyzSOy/p9BsZQ7RlcCPXf7/9p3qCfSkCps5R0ODVAwDR9e0v7Zk4MoIlXDRQRT7yka5A7P0fqgW96xg8oiXyzq2NRGqEo/31R809aWnd9yL36GANRRy6/Pi3xoQGyJNzGSfeCR7hLK5ySUPcAPvSSgRrY1Pr2cCNzkaQSVMufu3CPY8qjVjaITall/XtIrM4Yo7R3gXrtPQOr8fwI7JzwAFVPJsEFNtHVIrcB53S7g6izAxRkaAz8xCl/87r4vndHp02cMyRmkhv29Uwo7V/D0A1H6r21ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtVhrOSpKIlxtMhm8722plFmIijkG0TcrbBa9tYYOV4=;
 b=0RrTmfhezFsAdNE3a31c2jGuSq/9VDth3bgRAma3RTL6X4g0DRsUonFYvij9Nr4iim1OXy7JTeAhlgjVLUjv6K3cE4P9rg39lLXFXJ/l/nzryIYLG/BrS5vHv3pG2gcgUsLKAyVohMF4L0YsA92CTgcQyxuxLqs70osDgFSkty4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:31 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:31 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:29 +0100
Subject: [PATCH v6 16/20] rust: io: add `read_val` and `write_val`
 functions on `Io`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-16-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
In-Reply-To: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=5040;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=NkRpbPrwkB51HryRZKyflqp9UEcDTca8Y51zQyrewEs=;
 b=PZ3bKEnsQInbmyUe4fzCK9V/OyjRSw5qGkepXUKCS4CicNKsc34N/NT3F82KVUjQChJKHL58A
 bKTipWtQCkUDDIZcSVtvv0kYVCZpPnOxTIuTs6XpmQw0d0e/pnGOAAW
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: c50a6e5f-f8d4-4049-7af2-08dedb5c5383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|3023799007|5023799004|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: HnLzlLwztPK/lkIYUKnmMUxzBuD8LH6YszKt1WYll2B/Hlz9tN9O0FE0zwrBrBfPvOeByTj10SEfmPBuUmUMTXVbjmEeo50ttUcZju3LMuZqwfac1+D1y9zToaDIBtGAMzAOarMhHT9vly91OkuWjmP0U+XIJUTbZMRXI7ZwMnOiFh87yiA+N/V7lV0rRTC1bzriy9f8yePxNvJAsUZxn7ild9QJYwipcs4R5H8tLNhOZZiMSKPu9mI4vFbyFHFepRRyiXmW834wEtZ31mT8eJYFT+IudeXenb2jwbKu7GvK9Og+0OS10uvoxvyun7H185S6ATNvWffIGwLWWKwydfei1Ayu6FN5oBFjAEs1KXnkodzlBlQIRAJEJeJIeLvFAu+siaH7QMtyiUzduf/xXurC/jC39hIlvIQN7/pYDugzpzBvbLW1X2M8bGG0Ubmxe/LaptJ3H/U2xYp81o8hFwefbCWlW4GpWaa7DoveU64WPJZkR6j30jFsmNzT+z9nWQeirtkHdFVeMDh4xM6EqGi5c3CeT6kBO+xDkY0q3PGyM01CNr6bjJwttMN2sPvzYsglo5KTeLHMy66O07WMB8WWD0L0qiezPeyYs6fXq+o8ogcNXVx4EluW7Dy4i8UFvKlmmmlY7FxaLjtt3ORyndP4JyOB5DRSxxVVpynJP+40cBgp9m9+McX7R1KPpyQNtbT9Gmc+M0s7jssc2ptlpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(3023799007)(5023799004)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NksyenhuZm53M1pDNlBXZjNqbmNIWlFsclFJQ3NCQ1E1RzREdGNSVjQ3NkJH?=
 =?utf-8?B?TlBhelU4QWZwQ1BVaFY5bFQ5WFpLbWIzandHNG5IQlB3RmJoZ2JkRFk3Vmt4?=
 =?utf-8?B?bUFBdXVTT2tzTHlwVXI1SW9kajhlVzMwem5lRGtHSndoWG5xZTlWdGcvaEJD?=
 =?utf-8?B?bG9vNVdDdmNORGZNdFJyWGI1dUJ6MEY3N0thNGhtMDdKR2g0Vnl5UXFyQTh4?=
 =?utf-8?B?WjdoNnB1d2lKR1BHSTR1d1EwYWFyY2NkcndITGV0d09vQ0tNcFMzV2R3a25s?=
 =?utf-8?B?eXZhY2R6Q0FqU1BzY3Z3QXlLS2Q3RnBmKzhZVDVmZVByOXhpcjlSNkRwTWpC?=
 =?utf-8?B?blRzUktEckFla1lrN0srV1JnRHNuUzRKUjJwcGdka2VHeTU4Mk1kVDA3MmIx?=
 =?utf-8?B?Nlg3R2l0UnQ4YTZsa01odjR0NGZqYmZJdmpHVnZma29xNWZteGJEemZrSWpO?=
 =?utf-8?B?Z0lqb2tEZk9SSHJnOG9TMmQ3TnBTTzNrUDFEK3Rrd1B0NE5WU1B2Rnp0SFV5?=
 =?utf-8?B?Z2hISFUyR1dMdm00d2xMZUFjd0lLdi9zbWY0VFlXZ0ZmVXVua2NSZ1RDUlps?=
 =?utf-8?B?RWh5T1V2cmxySUVyK3F4ckVuNXhDVVh5ZWNwaFkxN1hGNEl2ZDRhenJjVWxG?=
 =?utf-8?B?N04zYTVWczIyV3FudytVWUtEeldraFAzQ01Sb2dHb0p3a0F3ZW4wOW5TcjNJ?=
 =?utf-8?B?N3o5OUhzdElDaGtINXA5Rk4zdEV0cVB6U1BmRkgzRGc3dUFleFZZbUFHdkRa?=
 =?utf-8?B?SFlkSXd3Sk10U05pbnExa2lLSFdVZDJaR3Q3c3FLak82b0Z3eXY5VkZFbXFh?=
 =?utf-8?B?bzRYUFVWN3ZBN1JWaDNJNXdIWlVIUHducFN6Tnl2elJzWG5OVVZFV1lKdU1E?=
 =?utf-8?B?MVlqc0laR050dlBYa3BnNkR0VW1DZTNUY0xTZTBrc01qOW5Pbm9hdFlFUG5K?=
 =?utf-8?B?cVpob3kwZEptSTRNeFZreTkrN2FRNWlaWFVPS051cndDV2hpUU5oRGJUMWRK?=
 =?utf-8?B?M1NoT2JjNEcxcmVmZ0I2Zk9UdFZkNk1wellPeXZ3cmMzYWU2VzZsWWd2RUNi?=
 =?utf-8?B?Y1kxZjZvbzRCKzhhaDZzbGxRVVhrcnkzRkxTcFJkb1JuTGVhRSsrS1dCbzdB?=
 =?utf-8?B?VGp2WEpSR1c4RnREWlllMUhUWmdmOWYyUTA1NmlmbE02WitXcStjeER0QThz?=
 =?utf-8?B?dUNNdDRhRFVkY3ZwZ051UFpUQ3k5V1V4bGsxeE4xb0JNTm9SMW15M3AvSVI5?=
 =?utf-8?B?ZXZ2bW1WL0txSXR1T1c0ZWdMVFFKQWN5ZG91RFo5a2VVV3FhSXBLUk9ZR1FB?=
 =?utf-8?B?akFaNVlSaFZ2MTcxTnZnWlZXNWtMNTI4Y2pKSFY2bWFRYWZlaGo0bjZEUmJE?=
 =?utf-8?B?YlNRS1g0aXF6Zk5EZTZkQTcyTmtmRndOcy9OY3orbFZ0QzBoOC9zNzZTd3Rr?=
 =?utf-8?B?cmQvcUxySkpPZHgwRmNsUDdubVZRVktOUXdNellod1cwZXVYRU9qbzFkMVpv?=
 =?utf-8?B?d1hLMWNkWDE4N3llOTBvWEc5ZythKzVVUkdldzRINzdibC9JZnNKdjRFaDZp?=
 =?utf-8?B?VDZLS2JJVmxhWFlsVmNBWXpzampIWnVPZGRKMVRhSEMrUjVSN29sWTQyQXlT?=
 =?utf-8?B?UXpZSVVSaGlLNlNEQVFSc1ZMQnY2ajgvd3hvMlkvQ202c2NJYk5oN25GR1Nn?=
 =?utf-8?B?UCtDMmtGWk1QRDcrNWl3T2gray8vUkkySm13MUxtZHNZQXRidDJvSUdqQWVS?=
 =?utf-8?B?bTZVbUFhb1ZRRFlYdWU3YzUwZlZGdUhtVW1ySHIxMld3YklIY0xYQWNwMFA3?=
 =?utf-8?B?djduVDYrSDEzOGdYY1poc1JLOWgvRm5QazVIZVZ6NkpnQ0VubWQyN3R2YU96?=
 =?utf-8?B?ZXpHcHBPQW0xck4za0RsZ254aEJkSTFhbjIzdW5xZkhodTZhVXJ2b2NZeTVW?=
 =?utf-8?B?QmdnU1hYWDRSRWFwaDExakZ2RmhmUnZOcjV3SW85WWV2RVdzNVRWZklUd210?=
 =?utf-8?B?SG05QThUVTdUN0ZUc0FFampWbWpaa3BWNHNwOU5SMGIwMm5POG83c0NPd1FD?=
 =?utf-8?B?NGxBOEM1T1NIOTJ3OStiWVZIZ1RmQTZEZHBXWlFualphaVduN2JhVzVYOHQ4?=
 =?utf-8?B?ck1ZbzZidGdiZjRqL2FnRDVxWndRVjIxK005V1N3TjNjazNVeWNLY1YyaDVo?=
 =?utf-8?B?TGgraUNRZXdoU2pxM1h4ZDVyd3JocHkwOWhabmZST3FHNkpOMWdpYkJIYmNF?=
 =?utf-8?B?TDhEQW56cHJKTU9tMWlzb3NCTEFFSzFrZ1h5aFVYL0E4Rk9qcWdEYkNLelFO?=
 =?utf-8?B?c0xNMzQ2alJxWFZkdEo4T0M4M2V2OVVxaWRBKzh2RkwxOElPVE9UQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c50a6e5f-f8d4-4049-7af2-08dedb5c5383
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:31.8545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0BaVVYpr0dGo22VoMoDtc6s1jOnMkYlAJ0qwGX35bnSdJcMXkoqpkxhZUMLCKmTLL9OzSKw5ZtGLneOFCiZnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
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

Provide `read_val` and `write_val` that allow I/O views to be accessed when
they're narrowed down to just views of primitives.

This is used to provide `io_read!` and `io_write!` macros, which are
generalized version of current `dma_read!` and `dma_write!` macro that work
for all types that implement `Io`.

Note though `io_read!` and `io_write!` only works if backend implements
`IoCapable` for the type; which is typically only implemented for
atomically accessible primitives. `dma_read!` and `dma_write!` currently
supports them via `read_volatile` and `write_volatile`; this can be
undesirable for aggregates as LLVM may turn them to multiple instructions
to access parts and re-assemble, even if they could be combined to a single
instruction. Thus, `io_read!()` and `io_write!()` does not fully replace
`dma_read!()` and `dma_write!()` in this scenario. The ability to
read/write aggregates (when atomicity is of no concern) is better served
with copying primitives (e.g. memcpy_{from,to}io).

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 78c6ae2a0db8..c423125870b7 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -398,6 +398,50 @@ fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
         Ok(unsafe { Self::Backend::project_view(view, ptr.cast()) })
     }
 
+    /// Read a value from I/O.
+    ///
+    /// This only works for primitives supported by the I/O backend.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_read_val(mmio: Mmio<'_, u32>) {
+    /// // let mmio: Mmio<'_, u32>;
+    /// let val: u32 = mmio.read_val();
+    /// # }
+    /// ```
+    #[inline]
+    fn read_val(self) -> Self::Target
+    where
+        Self::Backend: IoCapable<Self::Target>,
+        Self::Target: Sized,
+    {
+        Self::Backend::io_read(self.as_view())
+    }
+
+    /// Write a value to I/O.
+    ///
+    /// This only works for primitives supported by the I/O backend.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_write_val(mmio: Mmio<'_, u32>) {
+    /// // let mmio: Mmio<'_, u32>;
+    /// mmio.write_val(1u32);
+    /// # }
+    /// ```
+    #[inline]
+    fn write_val(self, value: Self::Target)
+    where
+        Self::Backend: IoCapable<Self::Target>,
+        Self::Target: Sized,
+    {
+        Self::Backend::io_write(self.as_view(), value)
+    }
+
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
     fn try_read8(self, offset: usize) -> Result<u8>
@@ -1229,3 +1273,65 @@ macro_rules! io_project {
 }
 #[doc(inline)]
 pub use crate::io_project;
+
+/// Read from I/O memory.
+///
+/// The syntax is of form `io_read!(io, proj)` where `io` is an expression to a type that
+/// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!).
+///
+/// # Examples
+///
+/// ```
+/// #[repr(C)]
+/// struct MyStruct { field: u32, }
+///
+/// # fn test(mmio: kernel::io::Mmio<'_, [MyStruct]>) -> Result {
+/// // let mmio: Mmio<'_, [MyStruct]>;
+/// let field: u32 = kernel::io::io_read!(mmio, [try: 2].field);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_read {
+    ($io:expr, $($proj:tt)*) => {
+        $crate::io::Io::read_val($crate::io_project!($io, $($proj)*))
+    };
+}
+#[doc(inline)]
+pub use crate::io_read;
+
+/// Writes to I/O memory.
+///
+/// The syntax is of form `io_write!(io, proj, val)` where `io` is an expression to a type that
+/// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!),
+/// and `val` is the value to be written to the projected location.
+///
+/// # Examples
+///
+/// ```
+/// #[repr(C)]
+/// struct MyStruct { field: u32, }
+///
+/// # fn test(mmio: kernel::io::Mmio<'_, [MyStruct]>) -> Result {
+/// // let mmio: Mmio<'_, [MyStruct]>;
+/// kernel::io::io_write!(mmio, [try: 2].field, 10);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_write {
+    (@parse [$io:expr] [$($proj:tt)*] [, $val:expr]) => {
+        $crate::io::Io::write_val($crate::io_project!($io, $($proj)*), $val)
+    };
+    (@parse [$io:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [$($proj)* .$field] [$($rest)*])
+    };
+    (@parse [$io:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [$($proj)* [$flavor: $index]] [$($rest)*])
+    };
+    ($io:expr, $($rest:tt)*) => {
+        $crate::io_write!(@parse [$io] [] [$($rest)*])
+    };
+}
+#[doc(inline)]
+pub use crate::io_write;

-- 
2.54.0

