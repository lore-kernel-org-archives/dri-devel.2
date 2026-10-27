Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC760A5BC4
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g7kpb9/d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631E710F2AF;
	Tue, 27 Oct 2026 07:36:18 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C8410F276
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0gdJSjRlpF0DP9I3L52nNnBDsBH6QTl43SmhFJlWNAra+ojUt2gnK88krukleaX5xTEYgj/wHtNL89wcmvCdByjc0YACvCKUAq/AWrpeCZ2B3vbjS+VsXm95sgKolQATenS5wrZzx/qUxiqrf6ZLOpbmoYT+V8SqGAJkEdNSY6LT9N+AfO1855NIiMB/kISLBf1Py2u6K2R8SgaAYYFfNLE56kCkCdbNMo2JcMnexvCuL8Zm4sBm00PgDyM5MwtV7bbQWl+XFxPs1GeugX3vQgjtIz9N9H298vXs/1nDDfsStNFwzPyCTpQdS6hE5mCbOcupADnwkLQGhGvZqmswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUMYTBfo1Bxb83xVJVk2CRhyXR9Jn0p3/zHpRZ1IRIE=;
 b=FiAB85WVuQwFHQl9kjphH9obAh5cLjxw2QjNcKnMmts1zbyxtKT1fEDsMwNP46LvcuNPvwjFi/XQdM3EHLPlURhRVU/1WnFEokfpvWC+qZOrCT3/4+rY7uHpo3S1TvLmX2x8H3Ceu9piM5ObYc118tKmB3Ap6Atzr5eVP2bYsf8VHQdA768oE925AF0nVLmkcnXjEz0fcn0qWmZ1zhDAA32aBmGgq6eg8S9mOWQouPRC/o8CgtLRKwL/WjKaOuw6p6Sz9QklPLDQyc8FPT4u4AndgVPfdjYa4feYgWSS3GdpS+evJ3D9qMXhjF7hIjkmU/Z6dD5s8rhA3djlsPXbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUMYTBfo1Bxb83xVJVk2CRhyXR9Jn0p3/zHpRZ1IRIE=;
 b=g7kpb9/dU3yI7yPu0Cz27sIbDIcC2mjJZdZ2A5aiLvdEeiZwSdvgYeHA61IZkMmwpss2zIGwP0yaWAi6ti2Tw+N8ywSdALkTx0Z14ZJXPgwOFC105QzVB4p83mAN3QIuXtJbP6k5g2oS79m04f07UE0TFgjrPsHjN21+1okiga6MPZMdb9u+AT73zWq5TVaNZqNETGk3ClSbD1zl2N0vl4os2Zv50xmiUBy25gOJBYT3afc5FCklrjy9fvK9CtGaAppVLJlAhOKBRKMkfaMo+OlvKmQ9Yw/is7PUvk0++h6vBp0rsawfVFA9cTQVK6x53z6kIShqNbnBHFfKjkaDaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:35:58 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:35:58 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:46 +0900
Subject: [PATCH v6 03/15] gpu: nova-core: gsp: cmdq: validate checksum
 earlier on receive
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-3-bed9669724ba@nvidia.com>
References: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
In-Reply-To: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 957473c9-c7c8-4743-4fbe-08df33fcf130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261021123027099003|56012099006|11063799006|261022105027099003|261009223027099003|261021121427099003|10067099003|22082099003|11062099010|18002099003|7136999003|261026140227099003;
X-Microsoft-Antispam-Message-Info: oYMESlzVCQ2h9zSCROybLNYsbFwtvc1244pVvK9WfniBtpnwEjeY3KrSQ5vfryEPCti+nHTpOpr8jay8ETuBcN3vUTKdXTT0bmrqVdo/qJkWqMPKL8Xa4I6c5Uw/kyS1lU9CDV4P0UXGh0NPI4/MasxvJ4B69q/xYRZFdxEuh6K5gV5BJy9CgcUcSLgM9wJf5TCtoRVw/wqiFkzi+8uvr6+mg/WA+FL2oSIDVhUUIx8P789mvjX8cIDQg5rQ0hZrrEJ6wJsFsW37t3Nbtuxdi2rBtpB60FwT8NqOHzvZ5B+o1niglrZWc/cYTIfSFg/BG/brdwDQYc6aY+Uu9KspxZGTUoTdgUZxGXVDDxQBfS113dFawnKcrWuJbOObrJ2aw58M78kLdt8FFNWygdlpmy4I2yBynnJpJD4ocDpgnVcKYguj+QQXifdj29Cl+7nGVLpPqy+fu8kLa1cw7oH16bAUOyGM3Z5BKizzuEije0sYqF7pUyfCZHmB47623s9nuGng4UpQQK/z0h/Ey+Kd3IWqo53rC20rKFDo3N/qe0tyT0qHJOveEkDHFG4XlPJ9R2UHJtNoBeUoo0CSRieCeBrSjfFHEwTJtgeik/5HWCx/Qvn2oF4Kk1GK6XqZEWXoObErU8mh3E3A1Oh+x4pCkGR3+1jqZ7HWEr+opaJNlxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261021123027099003)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(11062099010)(18002099003)(7136999003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Snd6b20rUmlOSVEvWG1vQUFUTE0vMW5IZGNSakJ0N2NpdituLzVWd2tJZnpy?=
 =?utf-8?B?MlljeVFYdktvSGNqUCt1N21wRjcwK3hkdE5OWDZhbEJENnJFQ0s3SjF5TG94?=
 =?utf-8?B?cTRwRTNtald6RnVmQXgvSFdPTWgzbE81TEJJUjRDRnlGWUNXNll5T3VXZDhi?=
 =?utf-8?B?T3V2YldNTFBWWkFoTWdMcUJnYm11UlRqOEdlbTZKOFFtM21kd1owTVlUN3hK?=
 =?utf-8?B?b3BFSzdsYk5EZ2c3MTBBcTJ2eDJTc0l5Wm5QZGVoZG9RVjhkZ0RBRkJteHR2?=
 =?utf-8?B?ZUNMemxNWDhCcW5nU1NMQUtXQk1oNndvWG1ObEJPU1FEWElqUXhybitRRnli?=
 =?utf-8?B?NjBTNndUUEF4YUgySVBjM0hMNzF1NHJvdi9rd3dqMmZTNXdIenFEMkJTWVI4?=
 =?utf-8?B?U0NWQXFTT05SUGx1Y0ROd3hKdUJhOXM4a2IyZE1jMW9iZW1rR05JckxjY2JI?=
 =?utf-8?B?RGkwRlFYKzR0NWpjTnI5cnNVc08yZDNHdnJzc2hqRWZZOVZuaXZsVVJaaFpB?=
 =?utf-8?B?TFd5bW9MRHRDaEpySkpPakRxeXFQRlBmdkdYTW8yRGFxTWFDNjF5Y3QzQURk?=
 =?utf-8?B?UEJtU2M1T1lmSW1pSko3U2QvVyt4QjVwTjBlejJMVWF1MHhsY0VJTnBoSGZU?=
 =?utf-8?B?cGd3dzNnOHY0QnI4MEFNa2ZzdHVQTUM2Z0kzYUY1M1BvS1p0KzVKY25tV2Zn?=
 =?utf-8?B?c2xXVUtlOGk2K2NkKzFxZzA3bDU4SGdGRWZMRmF5MFFFUnVUM0VuQjZGVEtu?=
 =?utf-8?B?bjN4QjczdXFJQ09HLzN0ckFXa2QrOWVRL0ZMUFVKbDQ0Z3I5NzZMc1NCSTcz?=
 =?utf-8?B?V09jWmttcFIyNVpZcHFaU0Z6eFFJSHhHMllXTTV1a2owa1h0dVVKN2JBYXht?=
 =?utf-8?B?MUlrVldDZFduU0l6b2FZOTE2NG9LcHNpWFNMc2NqUGFQamwvVkRiTVJTSUE1?=
 =?utf-8?B?T0xSN3NHMXRMcUR6dm5WTXE5KzVsZTMvaXh0OGVhY205VEw1NkpqTFpPUUxN?=
 =?utf-8?B?NEJDMk9qYzhMNlNkTFRXajJlYk9GL3JmaVRTYmx6LytpVkVuaysxeDdDUHVU?=
 =?utf-8?B?amFsRyswQTJ5OVZSRkJYRzJqejUvVmE1T1lVaFBTVWx2WXN3N2Z1TndYeDRz?=
 =?utf-8?B?TUxRQW1YZ21BTGo1bVEzcU1aQmovS2w5Z2ZLSVpIbEcvSEwxRHBzMHM2dmZE?=
 =?utf-8?B?N24wNkFuTzlEQ1pIaGNpcGJWbzd3Y25abHVESmZ0RXRlUG1BK0tRTk9pSzdF?=
 =?utf-8?B?c2RiTnJKRCs1aVh4UzlSc0RxR2FWUGtyejFvNzdnZmd5Sm15aHg3dnJ2Vkly?=
 =?utf-8?B?aXJPZ2d5M3FkaHZOeXBYL0NrZURHQnlLU2craDcyWVdiT3FYZmovWnA2bEpC?=
 =?utf-8?B?NHplRFVjZWEwOFR4TlhsTmQzZ0d3YmVWNzdXOGRkc0pBOTB6V1RhakwrUmQ0?=
 =?utf-8?B?dVhUZ3lWN2F0L1ZCc0VhTDdDL1FmcmY3UWkzWG14WlJIZlZPT3dXbE8rWExQ?=
 =?utf-8?B?RndnUEt5WFIzay95MlRuSzdjb21sTUNIQWxPbHBNMzI0VUFjOWpnRFJDc1hQ?=
 =?utf-8?B?ZnEwWkNhUXBLN0dUSXJhZlJJOEpFc3Z3QmtwSVNnR2dvcXZHSG5JTHpjSWFh?=
 =?utf-8?B?SFQ4TVBKaVpVYWRJL2YzcnhYM0x2RTY2OXNUbHhnTFZoa290NkIvczUvQ1Ur?=
 =?utf-8?B?VElrMVBrejRQdkhhS3p1N1hZNVJycXhlSGhpejJ3MEF5TVNBRzF4Q25oQ0Z0?=
 =?utf-8?B?a2Z0NGZJbXFmdWUwU1ZHLzMvY24zdDRja0ZXeFhLWlIySmo0NURVVXJ6T0FI?=
 =?utf-8?B?MDA2bXlHZTFzbnJlOWFWWmVaMWgzSmxhSjl5RDVwVk5nSjVyRUZHQXM0YzRm?=
 =?utf-8?B?Wnp2dDA0ZzVKNzlCR2RHaytsRmJJankvYWcxOWZaOUY2MDlSUzNBZTBRSGdq?=
 =?utf-8?B?bGhMVzFOeUlldWwwQ1ZGWUphVFhUb2FLY0gwT29LdnZGYnJNcDFZZ0JkWDR0?=
 =?utf-8?B?TTdIM2FoOUZsS1JUT2RrZEJONjJDQlJhaG5RMUVmbmNINTg2SkxkK1dSY05l?=
 =?utf-8?B?NHRCWUo3dXJZU2R2Z0dOWm81bWp5dmZIaURvRlQwaWd5NDllWVVrdkZURmJV?=
 =?utf-8?B?dmpET01zRUJIUnBpeFUrd1pIYWZJY2dHRXRMaC82YStDSmJlN3o2NDVTZFV2?=
 =?utf-8?B?eFltRjdHd25DUVFZcDRJa3dBNUVtaE4yZmVHa3lMbVVjVzNnTDNQY25ETzZC?=
 =?utf-8?B?blJyTXQ5MTlRU1k3VDVkQjI1RndzbzRyNGVHYUU1WFpNYXEwdzN2bUUzbmhC?=
 =?utf-8?B?ZlljUTlOWDlueUY3TTkyNDlCMSs3YXh6a01Pay9lYW9yUS9SWVhSVURwOUJU?=
 =?utf-8?Q?QF9CAvRw/9eoJlp3oK05uG9oIQSu2UqRmjvQL2XD8YksU?=
X-MS-Exchange-AntiSpam-MessageData-1: VKkTRztejpngDw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957473c9-c7c8-4743-4fbe-08df33fcf130
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:35:58.2615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48ghayoPJIPZQWy+B1eUP1/ixXUSNfugeOxm/srVNjeV6uushHWS/XovayKVF1khVz36HLujUMvNE6yVT36q7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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

The checksum validation error message of `wait_for_msg` prints the
message's sequence number before validating the checksum.

But the checksum is part of the transport layer, and it not validating
indicates a corruption that could very well be in the RPC message
header, meaning the value of this field cannot be trusted.

Furthermore, the transport layer is not supposed to know the kind of
message it transports, and it accessing the RPC header is a layering
violation.

Thus, move the checksum validation before we start looking at the
message header, and drop that information from the error message.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 1bd15fc0aef2..0c18a586576c 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -789,6 +789,15 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         // Extract the `GspMsgElement`.
         let (header, slice_1) = GspMsgElement::from_bytes_prefix(slice_1).ok_or(EIO)?;
 
+        // Validate checksum after truncating the message to its exact length.
+        if Cmdq::calculate_checksum(
+            SBufferIter::new_reader([header.as_bytes(), slice_1, slice_2]).take(header.length()),
+        ) != 0
+        {
+            dev_err!(&self.dev, "GSP receive: bad checksum\n");
+            return Err(EIO);
+        }
+
         dev_dbg!(
             &self.dev,
             "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
@@ -817,21 +826,6 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             )
         };
 
-        // Validate checksum.
-        if Cmdq::calculate_checksum(SBufferIter::new_reader([
-            header.as_bytes(),
-            slice_1,
-            slice_2,
-        ])) != 0
-        {
-            dev_err!(
-                &self.dev,
-                "GSP RPC: receive: Call {} - bad checksum\n",
-                header.sequence()
-            );
-            return Err(EIO);
-        }
-
         Ok(GspMessage {
             header,
             contents: (slice_1, slice_2),

-- 
2.56.0

