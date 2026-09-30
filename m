Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD3DCA5FAD
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B2E10E9D1;
	Wed, 30 Sep 2026 02:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="i2g9HLo6";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010024.outbound.protection.outlook.com
 [52.101.193.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9D510E9D1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBoNtmnw48FrJZUN6HWSpO6i+3JgWKdvXRWLQ3Oodtm6Pcbk1dqLLQDlTmHDNsmDlOjoaePwD6YUFr3aEKN0j/nURT/ZIW7kRcHPC85SvbvEv/mQRDo0c4WwtFzlCJxwceWjn1POgdVtNgVe85/vHNbF++a9XU35i17ar4CFvkLEkHyyBGSpdG5dZuJ3EublyJHjZXCcjGZDasuICPnes7+N1D67CYYM3kusABmAbLXRTgOhPE65W0A8BmHf1s9Ogl4AYl7pnMuUvRIxtfXeLuZCE962efQLIL7zWOJgEkXsNifBy2vYq+4QCMe7vBHh9nLLBsKDkKnf2u+gYmg6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fKWG8O02Uz5mDQ/qYKA1kszylId4ZueHj1l4N6hfl0=;
 b=iZERSq+zLNhb8L45F+bghJSQ6QvHzZDgJpoXJwp/ZP+rS2exJViz6aLyFSLk5Xh57TuIwTnQ2VnW+/bFAJ8XKeyyJ/SK9ql/6A4Jp8RDRxrCzddpYci9jdxjSC23zpV2G4d33prV10zkKM2mgqPbTF8Erg0Z8OrVMu7jaALH+Kb/b91m9br/CkDDI+yMOm8+gTem94hSKNA+RZGuKgfCYcIFi1wgDo2uryiTm1oRIHNuUBP7ux6ecUKTWOC35JzzEVTTJNiJ46jTDNEi2QKysFgp5s9xHBcsPXX2yZqiGmt53IJWxyqjUFXUXwBC989WAvIlhOLrQHFExwKrPUAU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fKWG8O02Uz5mDQ/qYKA1kszylId4ZueHj1l4N6hfl0=;
 b=i2g9HLo6mRObQxNH9c8/NYfQWiF+OZiFiBOdqyzeiEzp4t3soIsYEy3H7WVLb3fS5wcCQ0O16X1Z2sR3r5enS50IGzo8nG82iempfiH7+NB+a7P2C6uBzn3SImNUm8r3S+1gDgNLV9ZkBIAhYPj0gFcI35KKW33F48Bnm7xuUhP271t3rE6BCSIPheE+NnQkQOSU01P802ilBf3bir0mYgCplSIxXAFUl0cZR8ZYdI6TtIvLwHq9OyEXMGkWAfeoEXRFimni2eXgt1/lTJC2RcYrAVWaDw3XbzxoEehCSEg+3qWep6SVJwTya1LUA8sI1+DgjkEo+pmHFvsWKR2bRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 02:44:24 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 02:44:24 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 30 Sep 2026 11:42:50 +0900
Subject: [PATCH v9 1/9] rust: bitmap: use function-level cfg on kunit test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-chid-v9-1-0d6cca376cff@nvidia.com>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
In-Reply-To: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>, Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0107.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab93df8-2bba-4c2e-3aa4-08df1e9cbcaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|1800799024|366016|10067099003|56012099006|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YEfpOMCtA1oGTZ+3/vg9cFt6r1bKIKoFX+SDrs6G05NQYt4k3nUin2Qp/G7mqQQYOTNu4L33uOUpcGQNY+AUsVtifZHs/Z+D7zIvdq+s487JdBcPM5UXi0PeTGdYDnUtk7GU5he93wJai87aNLKpQwHZuu+Oh5CeL6xNq3oDSQJWrdvqu61FyDSMBdWxMAGQLCkEHSMh1gKiggc2xaRqD5hBub50E+OeKyaJN25e1E2+JWflLcdicGjBwOy4z8+T+UpfWlkwuWe5bloLw24GzY5C9vHZf/Q+0qzVo28VmQTe95HDVVcfZjAe7X2xy2wtkj1xJGBCQ0gFTastEP8xcuehVi8CTncrNmp8XrrEBWiXukwgeLiNtkuLTuZPVAuIFON/suvh3A17gtB8Wyia77M1bufhGDGlXYcOA0qixtq8h6PQXSBHQMGnDWKVR7QS1iP8/RGOU9jGalVLbs8fE/LtEWNIxU2ODmWXpX7kqbv3xnhlVEjXvuZ7Tnqg1FRUlL0+IE9hiNLpaGCu1+cpZ9/x4X9KIPaFe49uAjTd+4om3OylNvdI1yrEOzjDdc01HaKUxnC5r5/RfzfktZwCjzmiAvzWyhviHqMchcsltuUe+mv29vqdZSOUWBFfMvafVA3UtMUfNx4mflXHMV/4xyNo6xLiV97mLnh/f1rA766pfWiS41g2+94aSY5nB+Z7drMVNEQ3INxt78wlERh5wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(921020)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGJMQ1FRZkJ5UlVKZjVnajEyQXhZdS9oLzdUQ3R5VkZ3RjRudGgwa2pSdXdq?=
 =?utf-8?B?bHlWZkN4VTRZbzJPdEYyanZGS3hIUDVNSmtSZkNNZ2R0L3Bsc1BXOElGUGM0?=
 =?utf-8?B?ZWwzYnlqbE5mUjZyck9kMGVpcXUwTGUwNFhtMmFYV0xpOWpNekRrU1RCVlpR?=
 =?utf-8?B?NnJXakg5aVIwc3dOTGNZbmJuWFlDUTdob0RDMjJwd0d6UUZINUpqSDlrQklY?=
 =?utf-8?B?NVZqaG03aENnb0dLbG96TmZsYTFKMzIzaFhUeHhTMkYxWDJFTFY1aWZPcnBj?=
 =?utf-8?B?U0JkeFVENjA4MklJOG1GbFVnNTlxdUdFMGptSjlQZzNoQ3ZCdEZ4d3B5eXor?=
 =?utf-8?B?RTM2WG9rQVJ6U2hrMTB4RytFYUVXNzF2TXdWdmJ5VnB4V0pybGF2YUxlbW5u?=
 =?utf-8?B?bnFEQm9yWTh4THVNMjcvNHFmcUZ1NnpHSlFPNk1sQUxMd3o3MDhTbFBhUitV?=
 =?utf-8?B?YkIvZ1JPMUpxM25uZFhncS9WWEJpUEl6azRYS3pSOXU5UWZYL2xUY2FZbGtK?=
 =?utf-8?B?UU9vaENyZGJzY1FGS3BuakRGYUhxWm9EdFY4NUVWTjJMNHVxeHJNS1hoTzd2?=
 =?utf-8?B?M2JxTzdoSnVKdk8zWmFLUFFmdHlBUVBYVkhUWUhTSFlYY0ZJcGhQbUZ6WXVK?=
 =?utf-8?B?eERnNmk1dFFNZVdNaSt1U2dSMnZZVVJLajl0Vk5nOGZuSjdoQ0NUWjEyRFY1?=
 =?utf-8?B?L2IxcmRabldzbkhJQWpjUWlJbE00a3hFckNhODgrY0FIeCtBdDZ5Q2FsYjF5?=
 =?utf-8?B?MVhlUFVSRklXenFLKzdKcndvcFdWMUZyQnNDMlZXbCsxSmhiNXV5STFhU0hz?=
 =?utf-8?B?NUhnK25XbVdkelFyYTdWS21YTDNCRGVaaHhhbWxKMXdTQkRDWitwbVVhMmJE?=
 =?utf-8?B?SXVQWk5mWUQxR1FJYi9QTU9Kd3Y0UXg1bVV6bk5pcGR5VUJQNS9PSXJVUFpw?=
 =?utf-8?B?ejI4V3pnUFNwdTlpaXc1OFZpcHIvYXcxWGY5UFlib0duTURha2txQmxCWUdM?=
 =?utf-8?B?NWhYemhQT0plbVBNNmQxb0JKZ0IyVWtCbWdsWW5VV0RRc0hFbFdERVV1cURS?=
 =?utf-8?B?V1BoeW5LcXlqUUJzQTZnb1hmdWRVQ0RDclUvUzdzTERvOHFhUFNvY3VHM2Rl?=
 =?utf-8?B?TTRSYXY1MkhpRmE2MzIvNnN1MW5qS0JPYysxaUZjY1NPOVB1OWVZb1hMVlRM?=
 =?utf-8?B?RFBOWTFDcFJpd0ZsRENGaXF4UDRHZkREQ2RxVW52U1hSZUw5RE1ndGxacHh1?=
 =?utf-8?B?WWJ5MUgyTCtQQThaR05HQXNoQ2RmMUVoMVRBNzN5MjFLcVNpZVJTeDk4TGNa?=
 =?utf-8?B?L1lSQXdIRzlXVjV5YXBvNjFGb0NRYkFYM01ESlgvS0xjSXBSVzdUcDBjWnNO?=
 =?utf-8?B?bU9YdlNBMWZGTE14blRHQWwvQjBoSStpVkZEemJObFVCU2ZjU0lYZ1JtbHNr?=
 =?utf-8?B?SEhhZ2VnamlvRDhOQVphWkt4NFNEa0lUaDl2RTNaTkFoa2luMHgvOGpDY0FX?=
 =?utf-8?B?N2ZhdTJPZ2RvUzZpbWZhZkJOTnR0MCtUaVU3bjBxM2tqemxBMGdLNjAzQWVw?=
 =?utf-8?B?OUF4SU5jVU9YdlNEQThVSDNQUU9aUjAyYlFwL1VYbERNTEs2eER3ZUc1UmNr?=
 =?utf-8?B?NThIZXYxSE90VXQyc0NTSStXdEdxTFZsNkMzaENGWXhVOCtwdFhySHhWRFA4?=
 =?utf-8?B?MFFubGtNWmNWUEY4eUVBY0xUUkhQWEFrc0hrZnhiQWtWMk1OZUZ5RXFCOXl1?=
 =?utf-8?B?R05qamY4NW1mdk1lWlRzUzlrcjhRUm9lRm0wdHQzOGJrUE5IeHJHcC8xbkds?=
 =?utf-8?B?TmQyZENOZXZkeU4vVHVZTWxBSHQzcEVmTkt6RDVlRUlZSWJBQS93YWN3UWVi?=
 =?utf-8?B?U3RiQm1qekJndHVYK0V5QWFlVmZtbG9yVEFjelFTVnRtU000SWk0QllzQWtv?=
 =?utf-8?B?YU9ZMDJQZ1RCS0RzL0M5dytUQ0EwV2VXbEtRNURDWlczb3BNNFAzL0hMTG1C?=
 =?utf-8?B?RzE3K00yTnhqemNXM1RyWFljTlhoUHNWRk1MQThNSFRZWnZFOS90YkxqeU9t?=
 =?utf-8?B?Rk5OOUc1RENlNFRqUVZZdnBWU29POWpDSDd5SHBiTmxHOS9NUjM2ZU0yclJx?=
 =?utf-8?B?aEpuQWdCQTRqMlFJaVpZZUpYQ2N2b0FHUzFyT2dkZDE4TlkzazlJRXQ5aWhx?=
 =?utf-8?B?K2tGWGx6L0llcHNWcVNHNUVjTmZxanZwMzl5d1FsQ3EzdkFOV1RZd1lsbjY1?=
 =?utf-8?B?WmtJRmZpZHBvTkNCalkxdEkzK2FLSm1hUFRGeU1lMDdKY05tYUFjaU5aWFl3?=
 =?utf-8?B?SmJBblQ4QlhFTXN5RnhzWGxQb05TQk5jQklLeWdyTUo2T1FSanJqNWpYUlVh?=
 =?utf-8?Q?APe+v7o9m7WjazllJ2SF5/MTVVC7ma5LwvnW47yIRRyhr?=
X-MS-Exchange-AntiSpam-MessageData-1: uM0JoCzAdkWxgw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab93df8-2bba-4c2e-3aa4-08df1e9cbcaf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 02:44:24.0845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsNGg26cyb1IdWUNHnj3wZcbS2sqJk6ijVLpLZl901/ZvVIKHz7GEKjA4b9EWneQb3oYuXYM21lzSY8oqL+Ivg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

Since commit c652dc44192d ("rust: kunit: allow `cfg` on `test`s"),
we no longer need this workaround.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Yury Norov <ynorov@nvidia.com>
Reviewed-by: Burak Emir <burak.emir@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index b27e0ec80d64..a43bfe0ec3dc 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -572,24 +572,21 @@ fn bitmap_set_clear_find() -> Result<(), AllocError> {
     }
 
     #[test]
+    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
     fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
-        // TODO: Kunit #[test]s do not support `cfg` yet,
-        // so we add it here in the body.
-        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
-        {
-            let mut b = BitmapVec::new(128, GFP_KERNEL)?;
-            b.set_bit(2048);
-            b.set_bit_atomic(2048);
-            b.clear_bit(2048);
-            b.clear_bit_atomic(2048);
-            assert_eq!(None, b.next_bit(2048));
-            assert_eq!(None, b.next_zero_bit(2048));
-            assert_eq!(None, b.last_bit());
-        }
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+        b.set_bit(2048);
+        b.set_bit_atomic(2048);
+        b.clear_bit(2048);
+        b.clear_bit_atomic(2048);
+        assert_eq!(None, b.next_bit(2048));
+        assert_eq!(None, b.next_zero_bit(2048));
+        assert_eq!(None, b.last_bit());
         Ok(())
     }
 
-    // TODO: uncomment once kunit supports [should_panic] and `cfg`.
+    // TODO: uncomment once kunit supports `#[should_panic]`.
     // #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
     // #[test]
     // #[should_panic]

-- 
2.55.0

