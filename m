Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89265606AD8B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MSMYPIPD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0BF10F2B5;
	Tue, 27 Oct 2026 07:36:57 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A37018924B
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDfD6Vaps4P2UEBr4f0pP/mCPOqyTA9p1COA05DULf2R5AFvmk32YbZQf+FTqBomKVeXB1omdY7zXuK7kK/YSSuvGTViDt2naCzvRLrNzQexHn2/C+uM3fJIbpYKaRO0G0bHcVSya4ZgwcachQa1ScJ8bEc8r2SRa8Wbh7RZ8w+STovrwLqJRgRNjHxIWY9goCt/KdN/tV4J9SIfWIZxKML6g2mRGiM+9G02nao6b1vm7bofjtkZoLRjJtfAZ3XFUo91Yh2EADrSKLhVSE02A1APqmXA3XDiKLuL9XL5K2+/SaUnIDRdSfbxosKkBnYVa8B5j34Z/8OIzb8LigGokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvQS7Pi1DpELQRwWVjRCJUUoT7fwBtT9Rd67sS6mqN0=;
 b=VJ16vSVgGHuc96Jvkrk4NoXVMSkjv6zpOmoe/Bj2fpe2f2hfq+IfdIua/xZK/YDrEteoqRMDMVdrjGE6yGn8HvkZqizq6yi08sIcRI79jc+syDNyB6BpTgn2mMsL/Vm78yMN6BKuuOw/rM2Bc4SqMz5wzhFOnt3wCE+odzgU3VomCkh/5lUeOUJAgdnhJy1i8nmbBpIIDby8gBa3RA8xJjqEtkGGtv+bEoAWYsSuQVJlBDu4iNITWVf4vuFt1IVWlUaF7pdQqRbw4SWvRZSO9Vd3jTdkrMLPzRSPrHz6Cl2vYKnsxfsX8OTT/ZfkGo9A8mOm5tYdM5IugILEA38K5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvQS7Pi1DpELQRwWVjRCJUUoT7fwBtT9Rd67sS6mqN0=;
 b=MSMYPIPDkYHIrhaaOTVH0bKWj7gN2FjQvgIYsQ4Xz6VOXCxaenT8nQ8tVntVafYpk6lb5aEMa0vyqVSVtcmanBCIjO7vTajQ8BLSFJSRV3N78nNMkBNdgC8UPhpzptVCU6yHP1+gTZkoYeFh6N9/Pziw09UorGALo5IqoRAxGgEjC0CCYsqWI+dr9Joni8dMJhqVsrbQ5C0quQAcGdf1rwNYNmpT9HmG8dudI2+g9qjqX2VvLlo8UlMz6ZU9wEJCy+g3E9KTxOv7AUKYHMefqPF4JAUd1wMBnjuNKre9VP12Q6e/7H2kcQY95MnT3rgyuJUTrPFrO7ChsSOMfRvFwQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:26 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:26 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:55 +0900
Subject: [PATCH v6 12/15] gpu: nova-core: gsp: cmdq: use consume_element to
 implement drain
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-12-bed9669724ba@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0009.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f88560-be14-4a1d-e9e5-08df33fd0215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261026121527099003|261021123027099003|56012099006|11063799006|261022105027099003|261009223027099003|261021121427099003|10067099003|22082099003|18002099003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info: 96thsO47GFsFU8CFm2sye7A1YIo+5VQ+MFp1dRnAAP3mduaeWHkZTA74hEffKeH6SYnniHB3n0GoTrH2sERYdoAbO3ZTSHVXyIkqGJ1gOqaUp1rJYVWAgQEHDZGRizcgbV7F6xT0VktnqFFUe5DG2ZwhTB97uUSm2LcmLaCUSzSAYnDV14l9K85B7TJoaYRsyFIl31Iaev0fJLeNDb054JlvX7G2cjdB4QaW+mf8V/9WOnVBLRN8Ouie7LwGcBr+Sfqy2//dH8RU184TKfPWeNNhK91lF3jScAu48pmZPRbqvuFOeQ942CYXSnMCVyDuLqO1VK01A+ieiZb6cXHpQP/H762xR2945QCegVlskdQ1zMgxkdMYNCgqidQ93BMHbHBQhu/E5qd859dXocU5rQXKF+Pu0dDBqGhVoMaXVv20uhKkm8cNzYvq8cPi46x//10FyFXi+I7xAJjx+LcGqtwdFIvuDdBXIDSpF19ykxCY+Hcj9sxdCfuXZZh14ZV9+C+Xeua3feFnxnw12FJCsUFuxT7lsdLos+ehHQoeLIcNM/jF+dOV/4yTClsdREuejlfcOINXYt1idG6SdYZ86Wrpv3vB3C+BM/V4sfhTPusACTYRPNWe6cN+54MNysUrKSx465pZAAqdhoswUecQ54Cc6+GMCdnjD04eCnNwFaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261026121527099003)(261021123027099003)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(261026140227099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YytxaXZjOXpsL0t2YkxUSEw1M0VqbG5XUkVicHd5U2ljdWdKNXVTT2RHb0RQ?=
 =?utf-8?B?WHd0blArV2JJN2Y5ZUlHbUpGOVdxNE1Gam5uQ3RTanBUbzc0c2JtWGl4WTV2?=
 =?utf-8?B?NzF3ZG9OcjRFUnpVTncySUxWTUp4V05mTHFKdU41aUJDR09sZ1dHTnhNczBs?=
 =?utf-8?B?alNiRnhjeFhTOGJsMGVXNEpSMlM5Mzlsc01yL0U5UXY5RFZ0MldWQXZLbCsy?=
 =?utf-8?B?RDJ4NVdqcHhYS2c4MmlpOHdJSFlWUUY3bWNGUnpWMDZJcWVPY2JINTZYYlNJ?=
 =?utf-8?B?TG1RSE5kNFhMS3k5b3FQQkQwNUlJT2VlbU1ORjI3ZmVQYy9oZHRxenhrRWJk?=
 =?utf-8?B?MVUyYWNxUTl4YzJpZW5od3c2SExGRGVHeWJaNFZ1MUdNYzUvU3pKQTd5RUtW?=
 =?utf-8?B?dm1tT29kZS9iaHFSbXpIMk9CMkFiclVlejJzMnRmZ1VkT2dkenh4NCt1WkZU?=
 =?utf-8?B?dzhxeGRDbXdYVC9RS1F3SGFiaTg2L1I3YzRsRTQ1YWN1aGNNSHRpQjJjcjJv?=
 =?utf-8?B?NzRlSUxmdmlTMnVtTW9rZ21Ja0RMMko3NUcrMUhiK0NYajVTZGlaWTBKS3NI?=
 =?utf-8?B?bE9nMWxnVElyblZTUDhGQ2tjcnlIZjhkUnJMZEpyZFZQRStycmhCNXhVN2lz?=
 =?utf-8?B?U2d4Mi9IbVRRMVcrRlBIcnpHa1F2U0lDMnprd2xpMEJnR0JvazZSdURSN25o?=
 =?utf-8?B?Ujc5TTVGdDdtbWE0SVJKNWNIWkpQNTZ0WkRoeG9pT2Mvb0NjbGxBdFBEK0tK?=
 =?utf-8?B?enRrL21qNzhDSGp2SU1iMFZyYmt0cFl1TmRZWFRQYTlwUnNPeXVkTE1nWHVt?=
 =?utf-8?B?U3A1VGNPMlh6SmhadVd0WG1wTVl4K2w2cTlnSWFOWGZuWUdCbEk0dU1GeUdZ?=
 =?utf-8?B?bnZsRUg3Q2JKRjJra2xxK3R5UWpSRjVhbnduZEk4TVJQTG5vZ0tTUVB3U29l?=
 =?utf-8?B?bGpwTWRGemU4TWZZRVBjc25jRERjejlWR0xPSVV4UkUzTEljaG1rNElwMnFZ?=
 =?utf-8?B?UDdWbDJ4S2hrSy9Lbmt1Y3FwVHVPbTNUVmwxZHlMQTRFOEM4UVRLa0s4UUtr?=
 =?utf-8?B?K2RsbjNlUzVoSXJYaFdvdnNnM1Y4bU5STGpDQXlMMTVUNVVQMEV5d2lHVVlM?=
 =?utf-8?B?cXpqR0diUkZzZ0dZODc1djF3RkFFWTBXQ2lka3FnZ1lhZU5UZXNJTVY5UjF4?=
 =?utf-8?B?Z09xTWVoWkRtQmZhaEpJZHJNcHRWaHM5SWY1NGx5cXh6azBYMCtEbnArZElV?=
 =?utf-8?B?d3V6dXVXZTA3TjMvN2VrNXFLbjJtOTk3OFFqQkd3Wk9DT3dJUGtzOGZleE9D?=
 =?utf-8?B?L1M2c0p3UElwbWhCdXVHMXJTQU52RVF4OEpJK0FyNkgyUkRCNUt6MGhBNWNN?=
 =?utf-8?B?aWRSRXdPTnJ3cVZlZnBrREpXclhSTytFTWM3SkZweHdUNVh1YU1rTmtOanVD?=
 =?utf-8?B?VmNyQjVndGZiNThtdFpMM2lobGs0amRjUm95bXJ0OE0vVzNCbXFycnNtSzg2?=
 =?utf-8?B?VXB4bHVkN2kxZjl0ZGJZMnY0NkhjbTloQmNZMThQTlhwc2Y3bXlHUHJDbld4?=
 =?utf-8?B?anY5RW5JY1dlM1Q5dEtGTTByQkhDTmNKOE93cUZTUmJOd3VDQzZyQXl5Y2Fl?=
 =?utf-8?B?NDZ2K3p3a1loQ0U0Yk1rT1VYVnNsemc3MnRNODZOSUFmRmp5QlUxdmI3Umti?=
 =?utf-8?B?K0NOeHFNVS9La2c5OW5zNDh0aHdPRHFjaERzdlhTcndWVUFzZGtnY3VWV2lK?=
 =?utf-8?B?WCtDQjFvNkNzRzYrQkFIdXdmWGtjS3BzaUhSWEhCVkNsVDFlN1RjWEtxTDNu?=
 =?utf-8?B?Q0RYWkNvL1A5OGhNSk9RcDYyN3Y0d1poWWpjK0NEVDB5MEUvY3pnTDJDL1VR?=
 =?utf-8?B?SzZOZmFtTk1LcXo4S0VCa3lndU5uRkxXcHdnTEFxT3lSQmdtUGVzTHY0U2Zm?=
 =?utf-8?B?QXZ0Q0xZRFpVK3lTMTJXc0JPOTU1dVlHd0grMlhKU0MyYnNDSk5FY0k5Vzdp?=
 =?utf-8?B?TVZwdytjZXo2L2xveVZQMStxNTAxTzU2cEZmcGw5MTFqQlNBb2gySThOdVJL?=
 =?utf-8?B?ZEhkMFAxaUdGTXNEMjhBeUtHaUpZbUZUbXF0USswMlVDanV6dXRuWWYyTith?=
 =?utf-8?B?VHAvSm5xRHZSRk1JY0NWaXk5Nm1HMWRhYnEycTl3dHRSWlAwRHEzd05GbFY0?=
 =?utf-8?B?cmZ5ZmFHYWZGSElLc0wzS0w4LzFoY1NwRGQyb0w0cFlxSDJJQmRQbC8xdC9z?=
 =?utf-8?B?RW4rVXhwOEVjb2JaakdEZm9uMm56YjVIQkpLRThkZngyYnNoSkk1dUN0b0ZM?=
 =?utf-8?B?ZXJPYlZYb2d5a1JYdVNTOUZEMXZpa1dFaEtCQ2dOd1Z6akJDUzRwU2JBR1Rp?=
 =?utf-8?Q?Ko5Dwx9M4ZoqW0Uy8mx4k1IuqOY6kBSesVtsw557FJ/I7?=
X-MS-Exchange-AntiSpam-MessageData-1: PBY/D+fv72PcoA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f88560-be14-4a1d-e9e5-08df33fd0215
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:26.5964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCxYMKx3/PPLx4rdkN4YoG3RCEMcQ1sOouPkK8HLg1AcnQRv64z7d7nP23e7MKnxbR+sb+Lc1koyKCzoMRvbOw==
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

`consume_element` can be used to factor out the code of `drain` that
advances the read pointer.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 9c2c8fbad045..cbdd05385e83 100644
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
@@ -1069,21 +1078,14 @@ fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
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

