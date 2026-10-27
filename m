Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A1606AD96
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iYC4Jmdl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048B810F2BA;
	Tue, 27 Oct 2026 07:36:58 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E31010F2B5
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0uoA3Al94PsRZSA9cviLzEnjfaShOV8jy40TteFgi6nZOrep7KOpslyLGYFJHY31HGeR3AR8fMOaje2q9Rttb7QN3IKX23PWGUnAj1Vg0TyYvivfPdhK/Uj7XRBZtnZ1/1Jm64s5p8oyTJqNlQ4KkZwf7BReJxpYNAV6x2SNB9wLpSTFUU5XG2uqq7J4lijeKW3ydzroPhp2JtR4QugegzqyXH1iinOzSbJFpP+NAXYnHgzUo/kQm8+ZNAPrDOGBxy9orxF2D+eflX2tCZIh/qANuYaDBkeOOoBXF6AECBKScCtaaeDXoSGATrbDvhW8vXUgebqwl+2bhsgAOPbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upx7ISnxYw7+RMuPcE2wEnuLPiW5ZU16Be7oxK4m3aY=;
 b=lbSCgHz/9QvCFLuK0lOsUcM/2sLTlloJvcak/1caKK7LVFYfzDwRV7YUNtHmAYmwjbJH1UMffsMj47K2dd1bt9JOKIc6Bi9po/NbB+PPbrRUadOWYW2y43CfVStra6xeVYjys/3Ubd6gwIGA5YeKKHh3ywaOQXAPPTNr5xdmtXhxnOfhTDMWhKkT5tu4Q3o3mKREMG7Kgh1NFZYu2qt1hRVXAR7rlgXtpzAx1+o90MVPa5gWGPVjR+Bju1vFmNBXDgtzRnOjpNur42Q2vpA++XVrT1DCQiyCaczktzUuGVXH5TOXRmko8q1/XMbXQ7iPQuqxe53Zk3Iwf4JeqErw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upx7ISnxYw7+RMuPcE2wEnuLPiW5ZU16Be7oxK4m3aY=;
 b=iYC4JmdlscvLXfyKL/+Zu9tKrrLBB4OhdOwgOE5SklMs1RhbukyYZ170FFB1NS5kKyjHpFBnw4MpMtKRARDIIaDyVhjjey5y/zI5L+mp8TupGjiY4hvq9I/arH/lZjqBO69GbHYFljVzmgCjmmCWQ61cKwc+Bw1IrDL4ZujgE3n2hoj8sxR/1Fr79rAXF+mrXoCamF5rnj7WodPmW0AVpvZsCyZc9KzFV5WgOKIU5RqP9xUF3ihuEE/v7sqpflepwUmNWDxBaz968f7ypPYtPrWeQ9K//kOOMOPV7IMHmqB89S8zoHZHw/8b/fMS+46F6omzbsSeedf7OFUCOkzmDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:23 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:23 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:54 +0900
Subject: [PATCH v6 11/15] gpu: nova-core: gsp: cmdq: do not sleep when
 waiting for a message with timeout 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-11-bed9669724ba@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0126.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 60986f3d-a9a9-44e1-debd-08df33fd0052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261026121527099003|261021123027099003|56012099006|11063799006|261022105027099003|261009223027099003|261021121427099003|10067099003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: YgVFjgtfpJ9hIU5mQ92LpTCfy4SYhU3SaorhwxqmDeqtVpD5XjuJucfW439IVL4J6AL3p/e7qC20VgXvbZGjwirpGNSRzCXfhfjb3UjunMW4sKp17ck8cOJJt1mqULcGFT2Q6tGxDGVCBoo2OKlTUFYE+ZSI3Rp9hxXrG6wshmNhlnRgL5CZBT2pP+ATuqZBfPc4y06HlgTGY1XL+1A4XId7gvANVaR7FQ3EU6GSO/eF7qd56GYoDIRpjdKmaJuPQBkaN4JanKtJ9EwXFw9uLLwed5gDSNm9u85Ylmd4lrawLEYwFL8ZbWyRNO/RsGEZiYwszLg0vyPQtOrkA9TaEcXTBcRpGT8Ri0KLvmc6pYQSc6Ky3MJAsRsV+WJYK/kgC4+1U3KR4l+vc0sI1HtiGCS1P5KCHlsIa1h8qWKFqV2cQpNuViat55+EgwJw5AMgQDmjWqfOW3Bd8HmxoWg0F4kOvjW5xz1KBWCCCTqJYbmlNyxVap9ADlc7iu3TWJxZPKJcrprk5pXJRrYSq+2O81+oGu/XntZygALFc58XoHhD57OpD9v0yNeLn/XFUuRgELBLsjqfCes7o7wypzz2mKGdcR44EXhzUmsQNuM7Uz1yHPgZZGzgb1KuSXkxndAp13/SRyHvmNnfyqxCbdVhWhW5jPUiKYIMeckHUl/4GYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261026121527099003)(261021123027099003)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjJxQnMzbDVWMndWZVdvck5EZDBub3dMOWpyY2hmVXJBTUlockhNY0hoOWpU?=
 =?utf-8?B?NWdPRjRsZUZsRk1SYjdvRGhFWXYzRDdsZHJoVGIyV3hQaUc2RnlIeEtlN3RB?=
 =?utf-8?B?d01YNVl6Vi9jenpldytwSjVtRGR2Ulh5cHJZS2Nya0JPdVNsU2xzbko4SE1W?=
 =?utf-8?B?MTNTMDRHM3pZYTI5WUEzQmo2RkFtbGpQVm1wUFhPdHBxUHJaQVROMVR6aGRT?=
 =?utf-8?B?ZHQ4RzM2YmpvVC94dHE3RUNCN0U5SzVkTDdtbnFSOFJwUmhXb2dPbW44M3Va?=
 =?utf-8?B?bGU3ZGRORW02YmdIMGJZWXRoN2FGT292endXUjNvcWhMb01RWm5CZ2JIWDY4?=
 =?utf-8?B?dmR1WHNnc2REcXdSUFNpbWdZNEx5NGVTWElibEpLUDBOWStLbVZCdVlUMER0?=
 =?utf-8?B?WkFrQ2ZTcHVmWXdKeVAySXFBUyt5L2lRdnIzblFFUHlEOE8vNCtVRTZSNkho?=
 =?utf-8?B?L1hXalRpWlVNbW15b1dwL0FWeTJ4QmVJaE1nN2ppYlZyNEZDYjMvVVJoR01L?=
 =?utf-8?B?Z01pR3BxYVo4N0xKT1V4WEJmMXpUTmVwY291ekphcVdXVHRWVHpZM0JNMEV4?=
 =?utf-8?B?QjBLWC9YSzdwS3JZWWxncVBGU3NSMlBSeG12aEpUVXlNdFczMTV2LzEwK0FN?=
 =?utf-8?B?eUxKNGF0cHcramRSRU9CZlp0SXFBZzBIREp3QmN1MUtQRytJbmxXWU02dy83?=
 =?utf-8?B?T0ZTMjZ2Rm5paWhIaTRHQ3hINlMxbXhTLytVL0tkeDNXY1FoUmg5VENUNndM?=
 =?utf-8?B?UmNvR3QzeXllN3R6NHZsNml1TXRBWVFEQXkzcTVGdFFOM1BHMWVZZ2Ryenl3?=
 =?utf-8?B?bWdxSCtBZzNxNTY5M0U3c29kMXFDcXpTQWVNQkVoUUYzeENIUGRNVmpMbVRU?=
 =?utf-8?B?cHNxR1QxSWt4USswZTlLSjd0TmZlYkJpdUorcVRjVC96QWhOYzJxY1d0TEdE?=
 =?utf-8?B?T3IzeXhadTBwZmJ6N3U1N241ZTNFa3FDWER0ZlM0cHlXcnZRTUR2Y0tPQ1Br?=
 =?utf-8?B?U1VvakFSdTlZckJmaHJpZWpEY2JnZ2lUY0FFNUZiSVgxKy8wbnZwSEVUcUYx?=
 =?utf-8?B?L2ErTlZ1MlIrZzNGcTRMZFIwcU1XR0YvVGF2TWZxbmJXU0hFOThiNHNkblBL?=
 =?utf-8?B?a2xZakxiYzVncVNWM0d4Um04UWZ1ZkpoRGsxZEJJKzlGNEYwWU5sOXkzT0E3?=
 =?utf-8?B?SVJXYTFSUFNmaEYyV0VSWVJ4YnA3SWg4SGpySW1EeWRZcWhSRTYrOXkwQjlO?=
 =?utf-8?B?NlBWSnBEaUJTOXZ1RDFWdWU2QWZ4QmxZWXMzMGtsL0VQTVVic3d2WnZRVWE4?=
 =?utf-8?B?aU5pZW8vK2N6Z1ZKaDJVM0ZJMmRTVzRsYkJJbisvYmY5NzV3S2ppWTA3NFB6?=
 =?utf-8?B?OWdVdVlVM0xvc3NBS05qV1FuLzYySWc3SVNKTU9IRFZJTlR6ZVVIOGlrNUE4?=
 =?utf-8?B?STVZRzBMOFFpOVBSb3dWN2kzZ09NOFZsNk45ZDVrQUFVSi9TeW42a0tYZWxq?=
 =?utf-8?B?K0E5cUNBK0hPV2FZZDZMSUh5aEw3NmFiMkNWYVlTejFneWo4a0Nhd0FaUHdI?=
 =?utf-8?B?TGZYWGJHQnFvZW4rd0srcEtGcEVaYUZiSVlKR1FuSFM3VFE2RmJNQVBrczJY?=
 =?utf-8?B?ZW1IckhmbW44eVd3amFsbURJajZVandCd01pYnZvQVBrazBTZU1FVkVta3p4?=
 =?utf-8?B?YkdRc1A1MjFHbTBTaWwrMDZLeUhvS2xYNEl1dlBXb1ROVzBscWtWTzBEdWM2?=
 =?utf-8?B?NHN3cFlGY0tGdTMyUFhwbW9POWVUNnpkNnp6V0xTTTZZb0VQQWY3OXlRZERS?=
 =?utf-8?B?M01xUmwvU3Raem5MbzZTNHRYRzR6OHN4MXd1ZkN2NWRKZ1hFZGI1UnBVRU90?=
 =?utf-8?B?V1k5K1gwaXc4b0FLb3MwbnYwbVQ2WllzZkg4R1MrUkhaVnFlL2dCbUk1aUYr?=
 =?utf-8?B?Yy8xSXJ4SzE1S3VvaDc2aThsb1ZQUHZRYU8yRW83eVZDSm9ZNDBuVkVxRytt?=
 =?utf-8?B?UVJCRk8rWTZOQWRtU0lQWmRTSjJ1M1grc05lbGhBbUhWeS8xYXJQZEdoZGo1?=
 =?utf-8?B?ZXFmdlM3akRGR0tyUVk2a05UclRLbEU0SjhvZVhaZjRGTEVCeUx3R1dzWUU5?=
 =?utf-8?B?ZSt3RkkvM3RWNUpQZzlKZWFQVGhsNFVqU0hMSndqd0l2YkZDcFVlZWdlNVRm?=
 =?utf-8?B?M2MyU0JjTm02UEdSVzQxTGpHSE9Sa296dFM0Y3BEL2FUd3JPcGdtckMwZlhT?=
 =?utf-8?B?NGJRTzYxOUdQRzVtMjRFZnpmUGJCb0xoSHg2eFFKNFpjVTZxVDVoNmxVUlgz?=
 =?utf-8?B?WjZuY2xXQnBvdzlRdHZwL1dmTytDYUFLcEVSS1JsYUtUcUFmR0N6bEN6dFB0?=
 =?utf-8?Q?yL6YEg+ZaHabb8OysGs5wYuFypPxTxDVbOcLuM1yyHcsp?=
X-MS-Exchange-AntiSpam-MessageData-1: VM3nxo0ULaCxTg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60986f3d-a9a9-44e1-debd-08df33fd0052
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:23.6217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/KVDBjX9em89VDuJiXKAklZr11ui5m5iDPaAP3PLh07olrWywdhVdN7xpxZbYSfjA0WeFl0UF+WKcj3seD8Ig==
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

`read_poll_timeout` can potentially sleep for the specified
`sleep_delta` if `timeout_delta` is `Delta::ZERO` and the system clock
is coarse enough to not register a tick between the time the function
has been called and the time the loop test is done. `wait_for_msg` has a
short test condition and is particularly vulnerable to this condition.

Add a dedicated branch when `timeout` is `Delta::ZERO` to perform the
test without calling `read_poll_timeout` and avoid potentially sleeping
for 1ms.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 9e678715c624..9c2c8fbad045 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -909,12 +909,24 @@ fn send_command<M>(&mut self, command: M) -> Result
     /// - `EIO` if a message fails framing or checksum validation.
     fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         // Wait for a message to arrive from the GSP.
-        let (slice_1, slice_2) = read_poll_timeout(
-            || Ok(self.gsp_mem.driver_read_area()),
-            |driver_area| !driver_area.0.is_empty(),
-            Delta::from_millis(1),
-            timeout,
-        )
+        let (slice_1, slice_2) = if timeout == Delta::ZERO {
+            // If `timeout == Delta::ZERO`, check the message queue once as `read_poll_timeout` can
+            // potentially sleep if the clock hasn't moved forward while the condition was being
+            // checked.
+            let slices = self.gsp_mem.driver_read_area();
+            if !slices.0.is_empty() {
+                Ok(slices)
+            } else {
+                Err(ETIMEDOUT)
+            }
+        } else {
+            read_poll_timeout(
+                || Ok(self.gsp_mem.driver_read_area()),
+                |driver_area| !driver_area.0.is_empty(),
+                Delta::from_millis(1),
+                timeout,
+            )
+        }
         .map(|(slice_1, slice_2)| (slice_1.as_flattened(), slice_2.as_flattened()))?;
 
         // Extract the `GspMsgElement`.

-- 
2.56.0

