Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233560A2601
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kej2cQJR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0373D10F49E;
	Tue, 20 Oct 2026 10:09:26 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494C210F49A
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hy4C8qreJkzfKTu8eLU5Aeg3V1CxJHp/w4qE13Lde6p18AbXlu9fr4oE6E5fNW2ckDhO4egv4K3MtjGGvX28TiBJZnKP3ujWtYKLNXuMxswFUXX5IJ1WJhGk0IOAoF/5T3DN78vT+Zba78PbgKXeZgHWiM1l2HpokoB/G5p2e3noVxki/MwLkD0xyDjKaO+KaYxglsxOvdFkl2o60oZExYxC3BbZQKSdYOmAkjoUL+f0fRH2nJ4YO081/r56IJ8rEC+mC1oXha3qNXv/4vhQV8sMzFHC0GUX48LBs6LTs3K/YeZVY7YcnMJKB58jOs9Kct/XfKiXnBdbY4ed2cGqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoWhu5Bek0Ipv5A2UjPqofvPSgZqnVpgeA3Lqm0gKyQ=;
 b=gozF058PQxNsMaavIwVv+MK6cjHoY+hJxm7ntNWZWb8lG+pEzPbz+Ky88Fhb85eFwwz5YA6W+v/6Bd3yow8h0NlqRi5Es3hXq2Aqv9kSMfRymhrdkFXteoZEYGhQ/dDA6d5zHZF4tjJX/bY7jmzdb3M0NJ0bnSsPVxr9Ep3vUpFKuRvX2kSHnvESCEMVwZMs/lovmDJVaAa+N3gC5p37MBkDaYbLWjhqCbo21YDi3ic0tlLsbTqSZGdCw6vKq2wnyKomWvee8tjUHfsbE0iZ2LkY67CEEBouX7yU4Z4nomdCdS4DHc0OtOKJxb5E2WWTkiWL+orgeS9AUvHTfLyI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoWhu5Bek0Ipv5A2UjPqofvPSgZqnVpgeA3Lqm0gKyQ=;
 b=kej2cQJRYELSV5/uPLz8GsUAOU+O9I9KQnQtg9H4fIyUkZYNyKXzE3Qvvm1BqpCHHomye7uRKYbGbzgKuN5xqPNpeE2vqxPyfW63flMzmdE1/p/DC1hMXKv3j3AZ3j23B61Uhc2fmw8HP8nfS1Y0DDBArnAucrD80PuObtgQ3vDgDZpIzpo6I5P3w5Pskci9S75coNxpBV7Izq8+smR7hivXXBJMT6Bc8KwI3IBtUTdGhyGEp6w14JSKW22lLZCe9Tp1mB5Q3pOIfqBZnN8TE2YUjtiXV20o/KrhWI41zm7OjdFL4YIRj33GGXxro9rXXuww2FxM+91uXZcfOoSn/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:09:03 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:09:03 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:32 +0900
Subject: [PATCH v5 11/14] gpu: nova-core: gsp: cmdq: use consume_element to
 implement drain
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-11-dceeb8f360ec@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
In-Reply-To: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWPR01CA0039.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 108ed884-17da-4b3b-caf2-08df2e922b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|18002099003|22082099003|10067099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: cjrRlQzRC5P+/q3nT3VQl21xOZvLCFtnBhYO0fqSeVOhUfueCEKUJBzGj1Hwk7LF4CJv6zewVNuBp9fUBH9g2b9onXTtHraJbXr6HyUIOtUvaiM5bAAH5uW9xiOc/PUc+0bQ34olEJ3jhsnejBEOoEHjf2tTx0DYP18582cNS2uHlUnK7fVwUmSu/YevG5fTSxMD2W8xUEgCQih7qC5Sa9IzyLAvl3OZb5xVoyun7Zofpa+ta1Ot6o83gtjNUTf6H1Z+zcEwevg5ZXLxqdOLH/1uMU042+mAy9ZWssmB/d6U4PnXTEyJsbhD9VU58ho3JPd9Dppi05xyQXnxsufLhiSbt8kgN5l8uwTYU+wFsCjwmOKlN/KUaP68I9gOQIAYZPCBLtcjOojgAjd+Ixr39r5XYC3C/TvvnQEyDcQUVALAazDtTZdoL0OQb1khHphGqHyTtZmFXfc69FO3NFLD8Wuib6KicjyYmGYVwj6KPLxfqeM4WTvOplKBc7lo2BRqEWxQQhvEcOvQtAHSjPsYxfqqrVtz+Bzez8q6dlVe/8Jrka028rE7f308Eux2fkj2flJknqcjiqaYqda+tHqnClZSPcVLJrmWMNEmjWX2y+oFncpNh/AkuHU06316RBpUG/hZJbWQkZ9Yv+NrCsVX8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFI0UEZubEpxcDZDL0Erb1NReXk0UlBrN2tyT05CUHhLUzhweDNTYlpWUFFC?=
 =?utf-8?B?Q0FobURkYU1rc004ckV0bGlra3ZtWDQ0Wm9GZksvbkZqYzgxQ24wL3RzS1VX?=
 =?utf-8?B?SnlDWWRmNjlEUjZicU5XaldVQ0twSFNrRnVhb0Z4ekQ4S0lvUEhmTlM1OHZp?=
 =?utf-8?B?a09iYlkvbGhmVk4ybHN5YWFlSzJxc2ZuZWRxWWpVMndJbkFOMC9yTHZ3N2s4?=
 =?utf-8?B?ZFJ4ZkdjSG8vZUFOSyt4RE1RQ3hocUZ4SUJ1V2RLR1M5b1BmdDBPTENPaXNq?=
 =?utf-8?B?UGJabFJJbjh3WmhZc054ZEVhU3MzRFEzRGdYNjBiSCtDNSswa0lCUXN3OVBH?=
 =?utf-8?B?YWtRVmNDaWFBc1h3Y2ZzbGpTcGFNRWIxU2lFTzVGaUkrRzRkSTh4N3pIZHd3?=
 =?utf-8?B?dkRHOW5EdkpnajcyajlDMEhTbzh5azZSVkh1R2dXcVJNY3VSNGtQU010N1BX?=
 =?utf-8?B?YWd5Y1NnSVB2TkZ6SzQwbjN0M0crU21IS0luVHhKMFNuanhrZzhiSmZxd2t0?=
 =?utf-8?B?T0ppVHk4eWdCZVBiV2hFZjRBd2lrMHFQNFBnZHUzckxCeUN5M2tDcWFwT3Bq?=
 =?utf-8?B?b0RKZlRWN1VxcDYxNTRVbmJDYm9Ob0kraHQ1R0VUbU9QYVZVLzQ4RHpkZjE4?=
 =?utf-8?B?MVNnS2RtZkI2Y3I1ai9DM2FVSVJUMDJ2ZzZvMjk5SXVEbjM5enlDWTY4aVRY?=
 =?utf-8?B?MkMvSW8xYWx0a0I1U2JtdFN0QjdXc0JCazVBa2Roemh1ZVc0bmNlNjdPejRn?=
 =?utf-8?B?eW1SdFQ2NVZvTzZ4YW1VcUJXZUY5MEIxYnJDTDV3QTF1QnJIdENxN3dNZzRP?=
 =?utf-8?B?SSsrRUVrUVN5RUY5RVhhUTFiQ1JyaGlFODhQcTVUS2NUS3JBTDhJdWcyU2VC?=
 =?utf-8?B?ZEhHeFJOY0daQ011SUNTbVowQjNhZHhEL0lKK0xPU28xQjR6YkRVSFVDNEE1?=
 =?utf-8?B?SnNCWUhQeEZNUkdybldIL1JmUFEvRk5icjhETDVoYmhpeTMvb1VoYzZDcUY5?=
 =?utf-8?B?NXBkbU1aREVSNGpWcCtlM0N5Ym85SGhOSzNLZkRJVDBxbW9ld0tXRFZXZzJF?=
 =?utf-8?B?bFlaYWF1eVNYOVFXVWlFbGpBM2R3bHNna3lPTDNkOE1CdFk2cGJVa3l5ZVZZ?=
 =?utf-8?B?eXU2Z25Nc3VFM1NXUkFaMFQrbDRnb0N0TEpnOFlyRitnb1RjQ0k5UEszczFi?=
 =?utf-8?B?aWkrY2FEWUR5VjRJcmxxQ1FncGtqT2hySDh2YThxTms4VHpKQ2ptcmppcGF2?=
 =?utf-8?B?Ny95QStwcHRBNWZ5UzRMT09pU21iN1l0UDA5UTVSVGpKdTVXMmR6NVZjZjJE?=
 =?utf-8?B?MHN4d2dodFlhajdDM3FXT3ErbzFrQXRXNWk5bCt3djVSYitaVDZ4dUY3WWc5?=
 =?utf-8?B?TTkxNEROYkNKMWpmTWVNdTlURHFjUmVzckYwZkhoSTJLU3hzSk5RYk9KM3Nr?=
 =?utf-8?B?Z3JSQklRNDZnc0pVOXV3QjBNREVtK0hMZHo5cXE1dE4rZVRWUForRmlhK3No?=
 =?utf-8?B?MWxNb1Zyc0JxN1hCUWZteTEzckJSQVljTWVKNEx6MTA5VlRvNGdrWXJOeGk2?=
 =?utf-8?B?MzR6SGdacjFIa3g4VkpBSkZIMXM2bE1HcmhQVlUwYjhWNlQvYTZFUmNHOERx?=
 =?utf-8?B?anNHakZHMzJWNHFhRDkzdTZaWGwyejlIcnNKb1hqdTlUYUEzeUZWM1FLL0la?=
 =?utf-8?B?Zng5VUEzZHUvRHBNaGpBQ3Irc1J1NUVJTWJxUHR2QmlSL0NLclRPQnQ3QlNT?=
 =?utf-8?B?UWUzcXhXeSszbEdLalZZZW9xOG56S29jeGx4eHVZUTZYcVhXTVhZV2dqMVhS?=
 =?utf-8?B?M2QvUjN0V1VTcWQ3d1pDSXFGaUNpV0FjUG8vTVVZYmlsdE9oYWpSNTZ1d3FC?=
 =?utf-8?B?ald3dk1BckdBZUtFc2FKbkQwL2hybGVYRm5IWWZlNVMyZUFQNit6YVdtS1NP?=
 =?utf-8?B?TGlZWm5JcnV1U3ltcXBidGdZbGVMSmNQbE1vQjluOG9HTlBXbkpTU2hPTDdh?=
 =?utf-8?B?TisrWmFzMmtVQnBNSkU1cmFqTEIxSkNVWUZGcGg4cU1VMDEwbWNkKzBqQWtE?=
 =?utf-8?B?U2hpTDZJWTA5UFJUUHlHaUFDdVBjQjBUSnlZUWVHVHozbXVmeStpTFVNeTJ6?=
 =?utf-8?B?MWY2bWtqS3B6S2NmUXI3V2Q5WjFOdmErOHpWY2xjUHRMbEhaTGo4R2p3cmxK?=
 =?utf-8?B?UDJWQUpLUlRBVE41WmpPQWkwTndEcW0ydmdOWGd4Sjlnd0E3SEVKRWp1dHRP?=
 =?utf-8?B?OUJ5S2VyRkpOVCtWdmF5TEo1R2NlZnVVL1R0TWl5MU9mK3hvNWZvZ1FRUXlB?=
 =?utf-8?B?d3BzUzlRYUt4Tm5EbldrZmtJclI0WkI1NmNoZWVKUThpNHFpcnJ5ZXRaN2tF?=
 =?utf-8?Q?1l2doONMIllAknQVdWM1fSyZkmHdfFBqXYdIjb7WvhSbY?=
X-MS-Exchange-AntiSpam-MessageData-1: BhDThano8HQtKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108ed884-17da-4b3b-caf2-08df2e922b28
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:09:03.4980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqpuy8SuQhQdZRTDqmBP3fDB1FQW7PcKS4mSrw3XfVmd/SI/bsME4xRX8WbhZwSGROTCoDohbq7EGK7jVL1JqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

`consume_element` can be used to factor out the code of `drain` that
advanced the read pointer.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 7db3d28e8902..54e87fd7158c 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -651,6 +651,15 @@ enum GspParsedMessage<'a> {
     Rpc(RpcMessage<'a>),
 }
 
+impl GspParsedMessage<'_> {
+    /// Log the message on `dev`.
+    fn log(&self, dev: &device::Device) {
+        match self {
+            GspParsedMessage::Rpc(rpc) => rpc.log(dev),
+        }
+    }
+}
+
 /// GSP command queue.
 ///
 /// Provides the ability to send commands and receive messages from the GSP using a shared memory
@@ -1054,21 +1063,14 @@ fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
     /// `EIO` if a message fails framing or checksum validation, or if a message's page count
     /// overflows a `u32`.
     fn drain(&mut self) -> Result {
-        while !self.gsp_mem.driver_read_area().0.is_empty() {
-            // A message is available, so this returns without waiting.
-            let msg = self.wait_for_msg(Delta::ZERO)?;
-
-            let pages =
-                u32::try_from(msg.header.msg_length().div_ceil(GSP_PAGE_SIZE)).map_err(|_| {
-                    dev_err!(&self.dev, "GSP drain: message length overflow\n");
-                    EIO
-                })?;
-
-            RpcMessage::parse(self.dev, msg)?.log(self.dev);
-
-            self.gsp_mem.advance_cpu_read_ptr(pages);
+        loop {
+            match self.consume_element(Delta::ZERO, |message| message.log(self.dev)) {
+                Ok(()) => (),
+                // No more message pending on the queue, drain is complete.
+                Err(ETIMEDOUT) => return Ok(()),
+                // Other errors are fatal, and stall the queue.
+                Err(e) => return Err(e),
+            }
         }
-
-        Ok(())
     }
 }

-- 
2.56.0

