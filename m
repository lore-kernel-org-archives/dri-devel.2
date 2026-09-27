Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC41C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11D510E564;
	Sun, 27 Sep 2026 11:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sD43A5hH";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB7B10E55E
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag1M7dI9jn4U/sgOwPBSCKudMIh+eZLWyVrolR2cLNF54WmmPhDs3Gyxh3teUBo5UJP94NPUWPpUdG69zHZYZGUZgGkXZW9R8lfrshpbmvoq/CicOHZsB7azRkQOQl9+bGcSVZGt0eruQTuPARBODwuoAKSrXYoNMGiu1cBE+jM+4aeOEShTe7d2TuXu8ivxOQgkcENmWa7NRKif35Y+1NCasAX6rW5Yt07i15o4pNY9bU8HrdjyGfePvkdIpgCovdUA+gjpep8QgxZCiTEMlcBnA8DN1G0yjt66uftLYcRWZ1dQuM5Oj4VmLNtzR/ukbKthqn/og2/0+OfZvnT+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edIL9SGCrRDH9Q3CdXsRjfjTQGdM9fCa4j70pgaXazg=;
 b=VJJxtKSg/D9ra2s7sZ6VorwGQnhvR6XbZE8qmfhrfMnjHI8nGtkGeLnwLJiVEnWhSrW1WTbO7HJ6nGKxzHJXbzHT+EdAwCwP1X1m6LjutauWXsfr6i0yP7ckZE4vUcusKYjDPl4ibITzbA7AUk7rM77zKCAhqVDh+DqiK8sK/02rXXy2dNRejYeIRmMa+KdMEFWK4ZHM8CcBt3n/P+TmwxlQBhDFWfoh9c3sqSqKyxxowIbBOR29ydEFEcu3ieILybOyS0STg6PHzYHC6H9Mw2YeV3Q1lPjjjfbyDiKy6vxFd3ASCTK+Xbz1wUIkGTDedV7C75G38neysZhUP/QYBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edIL9SGCrRDH9Q3CdXsRjfjTQGdM9fCa4j70pgaXazg=;
 b=sD43A5hH/wIbkfbuigv71MeNjHzsEXxX6QBYHtvaZK4eeony4Ndn1smt3F6JvJGiKtqHqFfpN/UiQbK+5pG8PYOnx0Fy5zXTJWAiCjDGWAQexu/Gx6V1p+3hJX1Ln4ugA2IJll9r5uIoqCG5iqCpZrL9JSkY0h7JpHvc5Xg2DyD7y1+eFRroPmxvqMUPnPeR7fG8HAgGj2z+4c1gf4fP1RKexEBV+P8RdJmvRZAFPxZEeBK0MogF8afseArzAh1NPA/qe3RFraS9i+g0RtKCuyVaQ6687OE0CE1oFrGZl0JYCKQsbwr7i3IrEW5Aa2rCgYsCH06AR30roT/BA/GQ5w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 11:14:36 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 11:14:36 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 20:14:25 +0900
Subject: [PATCH 03/10] gpu: nova-core: gsp: introduce and use proper
 RpcMessageHeader type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v1-3-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 109ba6db-3daf-4f8e-bbad-08df1c8883cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: hHU2glioZzCfXJGBN7bSXBFDU1/90f+YA/JMJPEqwx+7uxpmXzZFUJiT7N06KB/KxE6D62NjZLwbg7BfEM07ymYtuizsqh/7mZGjORSDxtY88j+oA0oIkfX+yf2W5o9gmp+POS4wGKU20j+98DQdeWeIjPlt4B1zoEi6pm2X5F9dXLFwzoqm/PHyLxdTNbCI9xwD8oTruYIP/mFRbXvEH4k37sBDhZ9JvsB4ZU+C/Mgao8EVAjAT1wRjRr1QFDFBeeXwg6laWHooeIRlase1rUQZGA6gESP/X8fq+gBoAaNhWcSgejDONDX995yOgJSfaq00c5vc81BKHLDG9YRdp+PegDbh6eynUyLGKfFabbLYD4+qUiKS0kRlSrRtcrr0fcCIkDxOZct4HXwM/XE4M0K+OfKFRIYGKlUCcpoqJNWl9sO8aQyWZRE8agZttTLsy9R1PG41Sm9KAKspG/cDQ3aEFZ4v7JJN1OMykNWkI5h6b3og2rgLYI0TqDrc2JcJjrE3k1hI1hIeBfPj6NRttCRIRUV9ZRKuErKxd/pzaYUVPdCExUsx1MmvncA0DnQngoLJVfJPT07tWvZEaiTTBbT7mxQYJb/od6F0CQ5bH2k/I6od6IaM4RCSun9ZcF4f2sds33MDUcuhadYTOTY6untzj073h3zS00LfJJOON7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lhdXRlNUVPTm5LRVJSb0wvLy9ENjd4Vi9ua3VsRmw4UXAwWjZaWlhqbjZB?=
 =?utf-8?B?bXZxMDNuTUVGZ2hTeWdPb3JXbHZGSHRCenNwRnJ6VHpjMlFPNUlEd25kSzJF?=
 =?utf-8?B?YlpGSTZYelQxTU9Lemh1MXU1TlRrTE1hQ00vaWhMRjZRWkx5dHpqZTV3Z0xO?=
 =?utf-8?B?NHVRS0xzQmpBUGZzdGFISW9QcVAzeUEvZG4xeDVRQ2c2TEJHSFBkUk41a1E3?=
 =?utf-8?B?UGZVek92dTk3NytHM2V2M2RaYjgrSURmUkRvSklJZTRySEw4b2p1MENQY2lZ?=
 =?utf-8?B?ek9wNU4wNUxHS1hMeWVFNTJXcnZyMWJxTnptY084c0tobnhBaUZMdUFlcVdw?=
 =?utf-8?B?OFJqOXhEc3ljSFZSL2tvdm04aklKcE15MUhFbW9qemlQQml6dDAybmJGQU1p?=
 =?utf-8?B?SGhhSDJxbFF4cFRPb0lEaDZHT25VMHVDUDVEV2pEV3QrU3pyTjh6TGZ5VHVZ?=
 =?utf-8?B?L3Z5V3BXaVBJUnNidzdPM2c2L0JaODI4Zll3RVpna2hYbzNQZC9MWUFIbXgr?=
 =?utf-8?B?WmdqRkNpVVMrdHRJQXhZelIySlZJOW50VTV0eWg5SmZoMDhoU2VTWnBnTmc4?=
 =?utf-8?B?clpxZHB1elZGVGRXL29rVnZrNm45TDdMa1RFdjVnc2hMb09wUlVCRVhhV1VB?=
 =?utf-8?B?NTJsNmkrRVAzQUx6RUFjYndYNUhQUGRTWi8yUFo4Umg5dHpqVTQwYUFuNXg4?=
 =?utf-8?B?aFlNcXNIdGdSdTJyTTkzQVZVQkZWQlo0YTFZcVR1UFJjcnBFekdiVWJ3dGNT?=
 =?utf-8?B?L3RiR2U4NEVjNitxbnV2UloyMU1Jb3NFUDZVVzBDVE5wZDJiUTQwMWpNYXV0?=
 =?utf-8?B?Zlg5d0k1cVhKOHkySWF2RlVMSW9xVVlEWVdLemFzRVA4THNIQlRsaG9paU1m?=
 =?utf-8?B?N2FtQnFPRGs1UW1jR3R1ZURqMnQ0ZjFsd2d2ODVleDdCbEQxbjcxNFdaVW1V?=
 =?utf-8?B?NDFpYWFOOE14bkxRbG85WU1lR3p5Zy9uaXQxb3lzTnVnaDhJbDdmWEFNWWhk?=
 =?utf-8?B?NEJacGZWc3krMU03dGFHYUdaOXFPK0JMZkp4Y1JtUjNKaG5pZUNIMmgxb0tB?=
 =?utf-8?B?dFhhcHF2di84Z2ttOElRRzJPUmxlb2xwcmlTOFNDQ01XNFpRQ3B2ZmxvVGlT?=
 =?utf-8?B?b0lNN3BmOUVlM2p5N3A3YkwvcHpUUmV4N25Jc21aM2hkNytvL0NjZ2VvRTZl?=
 =?utf-8?B?dGlsTzNmTHgyUGlqTmNYRnZmM0xOalArcEV4djg0Tm9YV0JWSHpRc2I2OTM4?=
 =?utf-8?B?MEErZGFDakRFVEdRMkJHNUVRZVh5RXJBZlp2ZEdkL2tSNW1Pdmk3SmVta3Av?=
 =?utf-8?B?M202dStaWjBXSml6RnRCbUtWeXl5cDZxTFRvUUpiUFNra3ZxQmJrMDl2cGw0?=
 =?utf-8?B?enhnV1E2alZnbEtRb0xJU3VGUDZtL1U4VjJUbHJYSG9JSEl5SGtCRy9PMnhq?=
 =?utf-8?B?QUp3NXBJRTZodjVaVk83VVBKWXR5eDJiS3ZoL2QxTkEra05IUFJVdTBlUWtv?=
 =?utf-8?B?cEJNNzhUWDl5Uk9kOGtSQ2JyNEV3MXRNSjNxSEtrTlhMdVVFSVNNcGZ6S2Jq?=
 =?utf-8?B?VW9jT3pPTEIxV21mYmhuc3hOVG90eWJ5TzhjbkJ4U29YcWxsNEZMekg5ZE03?=
 =?utf-8?B?c1Z3elk5a3BHWTV1eHdOdWorZzhqTXNFM3hXdjVLVXd5NVpodk1IYnNZaUVl?=
 =?utf-8?B?N1hOcXhackVkYW5sSDJUTjRBMGJ6YkJKVmRKYVQveGJOVTE1NHNaZHJ3SFll?=
 =?utf-8?B?ZlBqVDFZSjlndS81d2UwU2l1WXMvd3VGNG0xbURYRWxaMHp5QU16eVJOdlFF?=
 =?utf-8?B?eUtMTGZ2Y2w1elRMK3locXN5MnZsUXdQSHRhK1JVZHM5Y1A5WnJvc1ZGelAz?=
 =?utf-8?B?bS9mcEZidDhKQlVvTStoQnNIcnJRTTkyUGN4UjZsN2JQM001R2VXek5OYnJE?=
 =?utf-8?B?N0ZHT2k3bFdZTEhUWkJUQU5VSmtpQkorWStPZTZLdk5DalNGYW5iMWg0RUIx?=
 =?utf-8?B?Um9nZ09BckhXRnViMWhGTm5RMlIyK0tmOTVDa1BJQUNIL2pPM2VxM3RFVkNv?=
 =?utf-8?B?UldXMUF6aE02UkZ0OUdibmE3YnBoelhvWDZ4MmRGL2h1MUsyZzA3bmJUaEdz?=
 =?utf-8?B?cjRrT0p0aEI2aVZDWCtGazJXdlNiSXhwSkZNb3BjWEdqVENWM2MycnY1bm5n?=
 =?utf-8?B?RjBKajJ6dkxtRnJGRGZPWlFqZG9sTzdNK1J1enMxRklCb1RZaVJxY1F3RHBO?=
 =?utf-8?B?RmgzeXN4REdHbVdEQzdqYWh3dnBBWTJHYlM5am1RU2xyMnlSSHpNSDRBaWNr?=
 =?utf-8?B?NUpQTHhuQ2VMbkQ5Mk55M1p2bFRxc0xuM2NSL2tNcUROaDZhekloSnM3QUhW?=
 =?utf-8?Q?QEddZUi7Jb8ZpailDD0sMwQmqey3K1cGJn7fYaloGkAZl?=
X-MS-Exchange-AntiSpam-MessageData-1: xI9oHmgnxU62sw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109ba6db-3daf-4f8e-bbad-08df1c8883cd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 11:14:36.3727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiWp1NMt428YZPi1ryBeKcRFAjjgHMGQguruxMQUC5SVL7ujBQ3Qfvl3c5J/r6NzRwDy0Arpe+KrNFLEKmeQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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

So far, the GSP command queue transport and message layer code were
intertwined, a design issue that goes as deep as the types themselves:
the generated bindings for `GspMsgElement` even include the RPC header
at its end.

This makes it difficult to introduce the new GMC message type; thus this
patch works around these limitations to make the RPC message header more
explicit and allow it to be eventually handled by a different layer.

The `RpcMessageHeader` wrapping type is introduced following the same
model as `GspMsgElement`, and can be obtained from the latter. The
methods of `GspMsgElement` that actually query the RPC header are moved
to `RpcMessageHeader`.

Regarding initialization, `GspMsgElement` leaves the RPC header zeroed,
and the command queue code is now responsible for initializing it in a
separate call.

The only functional change is that the RPC debug messages now display
the size of the RPC payload instead of the whole message including its
headers, as they are technically part of the message layer. This metric
is arguably more useful as the headers have successfully been parsed by
the time we can print these messages.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 25 +++++++----
 drivers/gpu/nova-core/gsp/fw.rs   | 90 ++++++++++++++++++++++++---------------
 2 files changed, 71 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 08a49450bca0..8e7e6609ebf1 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -50,6 +50,7 @@
             MsgFunction,
             MsgqRxHeader,
             MsgqTxHeader,
+            RpcMessageHeader,
             GSP_MSG_QUEUE_ELEMENT_SIZE_MAX, //
         },
         PteArray,
@@ -664,11 +665,16 @@ fn send_single_command<M>(&mut self, command: M) -> Result
         let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
 
         // Fill the header and command in-place.
-        let msg_element = GspMsgElement::init(self.seq, size_in_bytes, M::FUNCTION);
+        let msg_element_init = GspMsgElement::init(self.seq, size_in_bytes);
+        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
         // SAFETY: `msg_header` and `cmd` are valid references, and not touched if the initializer
         // fails.
         unsafe {
-            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element)?;
+            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
+            pin_init::raw_try_init(
+                core::ptr::from_mut(dst.header.rpc_header_mut()),
+                rpc_header_init,
+            )?;
             pin_init::raw_try_init(core::ptr::from_mut(cmd), command.init())?;
         }
 
@@ -694,7 +700,7 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
             self.seq,
             M::FUNCTION,
-            dst.header.length(),
+            size_in_bytes,
         );
 
         // All set - update the write pointer and inform the GSP of the new command.
@@ -779,16 +785,17 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             return Err(EIO);
         }
 
+        let rpc_header = header.rpc_header();
+        let payload_length = rpc_header.length();
+
         dev_dbg!(
             &self.dev,
             "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
-            header.sequence(),
-            header.function(),
-            header.length(),
+            rpc_header.sequence(),
+            rpc_header.function(),
+            payload_length,
         );
 
-        let payload_length = header.payload_length();
-
         // Check that the driver read area is large enough for the message.
         if slice_1.len() + slice_2.len() < payload_length {
             return Err(EIO);
@@ -835,7 +842,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
         Error: From<M::InitError>,
     {
         let message = self.wait_for_msg(timeout)?;
-        let function = message.header.function().map_err(|_| EINVAL)?;
+        let function = message.header.rpc_header().function().map_err(|_| EINVAL)?;
 
         // Extract the message. Store the result as we want to advance the read pointer even in
         // case of failure.
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 918a7ae809eb..1cfa7838ac11 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -781,11 +781,25 @@ fn new() -> Self {
     }
 }
 
-impl bindings::rpc_message_header_v {
-    fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, Error> {
-        type RpcMessageHeader = bindings::rpc_message_header_v;
+#[repr(transparent)]
+pub(crate) struct RpcMessageHeader {
+    inner: bindings::rpc_message_header_v,
+}
 
-        try_init!(RpcMessageHeader {
+// SAFETY: Padding is explicit and does not contain uninitialized data.
+unsafe impl AsBytes for RpcMessageHeader {}
+
+// SAFETY: This struct only contains integer types for which all bit patterns
+// are valid.
+unsafe impl FromBytes for RpcMessageHeader {}
+
+impl RpcMessageHeader {
+    /// Creates a new RPC header.
+    ///
+    /// `cmd_size` is the size in bytes of the payload. `function` is the RPC function of the
+    /// message.
+    pub(crate) fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, Error> {
+        let init_inner = try_init!(bindings::rpc_message_header_v {
             header_version: MsgHeaderVersion::new().into(),
             signature: bindings::NV_VGPU_MSG_SIGNATURE_VALID,
             function: function.into(),
@@ -796,8 +810,32 @@ fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, Error> {
             rpc_result: 0xffffffff,
             rpc_result_private: 0xffffffff,
             ..Zeroable::init_zeroed()
+        });
+
+        try_init!(RpcMessageHeader {
+            inner <- init_inner,
         })
     }
+
+    /// Returns the length of the RPC's payload, not including the header.
+    pub(crate) fn length(&self) -> usize {
+        // `length` includes the length of the RPC message header.
+        num::u32_as_usize(self.inner.length).saturating_sub(size_of::<Self>())
+    }
+
+    /// Returns the sequence number of the message.
+    pub(crate) fn sequence(&self) -> u32 {
+        self.inner.sequence
+    }
+
+    /// Returns the function of the message, if it is valid, or the invalid function number as an
+    /// error.
+    pub(crate) fn function(&self) -> Result<MsgFunction, u32> {
+        self.inner
+            .function
+            .try_into()
+            .map_err(|_| self.inner.function)
+    }
 }
 
 /// GSP Message Element.
@@ -811,17 +849,15 @@ pub(crate) struct GspMsgElement {
 impl GspMsgElement {
     /// Creates a new message element.
     ///
+    /// The RPC header is left initialized to zero and must be initialized separately using e.g.
+    /// [`Self::rpc_header_mut`].
+    ///
     /// # Arguments
     ///
     /// * `sequence` - Sequence number of the message.
     /// * `cmd_size` - Size of the command (not including the message element), in bytes.
     /// * `function` - Function of the message.
-    pub(crate) fn init(
-        sequence: u32,
-        cmd_size: usize,
-        function: MsgFunction,
-    ) -> impl Init<Self, Error> {
-        type RpcMessageHeader = bindings::rpc_message_header_v;
+    pub(crate) fn init(sequence: u32, cmd_size: usize) -> impl Init<Self, Error> {
         type InnerGspMsgElement = bindings::GSP_MSG_QUEUE_ELEMENT;
         let init_inner = try_init!(InnerGspMsgElement {
             seqNum: sequence,
@@ -831,7 +867,6 @@ pub(crate) fn init(
                 .div_ceil(GSP_PAGE_SIZE)
                 .try_into()
                 .map_err(|_| EOVERFLOW)?,
-            rpc <- RpcMessageHeader::init(cmd_size, function),
             ..Zeroable::init_zeroed()
         });
 
@@ -848,34 +883,19 @@ pub(crate) fn set_checksum(&mut self, checksum: u32) {
         self.inner.checkSum = checksum;
     }
 
-    /// Returns the length of the message's payload.
-    pub(crate) fn payload_length(&self) -> usize {
-        // `rpc.length` includes the length of the RPC message header.
-        num::u32_as_usize(self.inner.rpc.length)
-            .saturating_sub(size_of::<bindings::rpc_message_header_v>())
+    /// Returns a reference to the RPC header within the message element.
+    pub(crate) fn rpc_header(&self) -> &RpcMessageHeader {
+        // SAFETY: transparent type.
+        unsafe { core::mem::transmute(&self.inner.rpc) }
     }
 
-    /// Returns the total length of the message, message and RPC headers included.
-    pub(crate) fn length(&self) -> usize {
-        size_of::<Self>() + self.payload_length()
+    /// Returns a mutable reference to the RPC header within the message element.
+    pub(crate) fn rpc_header_mut(&mut self) -> &mut RpcMessageHeader {
+        // SAFETY: `RpcMessageHeader` is a transparent wrapper for the type of `inner.rpc`.
+        unsafe { core::mem::transmute(&mut self.inner.rpc) }
     }
 
-    // Returns the sequence number of the message.
-    pub(crate) fn sequence(&self) -> u32 {
-        self.inner.rpc.sequence
-    }
-
-    // Returns the function of the message, if it is valid, or the invalid function number as an
-    // error.
-    pub(crate) fn function(&self) -> Result<MsgFunction, u32> {
-        self.inner
-            .rpc
-            .function
-            .try_into()
-            .map_err(|_| self.inner.rpc.function)
-    }
-
-    // Returns the number of elements (i.e. memory pages) used by this message.
+    /// Returns the number of elements (i.e. memory pages) used by this message.
     pub(crate) fn element_count(&self) -> u32 {
         self.inner.elemCount
     }

-- 
2.55.0

