Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5898FC44501
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB7810F77C;
	Fri,  3 Jul 2026 10:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="upR8P3T9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B2810F781
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPeoPwdzrKx1JPVI8j2IPc65lFdaKy862lBdUbADBRthLnc3Ob7PvHO+doM6+J5pEb7j2aIMPyGY8gc94tXO7JDdig1l9aBxFO9IyIqHPuHNWYl4JtDMP/AJ7C1kiYp2Zfr+22KyG1UDUYCoSV9wMyIZNiBBUiGFkMQXFP/maPt2zSeKzOl6UM6mu6IHG8VhhNgc4FO1VqMQsoys4CTT9EpPSwAyZzlii/ROPaE+0ECZB0hjScWbmGXYXWhQV9Yi2CPmttYAIKh3K/ZOywYj2wMPmxk6s/JENWQ/opFMCpaOFk0Kpe9tWXdQyW54khTWJ7pbnIYS0s7j5C2uOf4dkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EC/+1NP96yHW59I+w8UQwr2dlb/iu5XcwgFN/H1124=;
 b=QegdLJfrALSpXJ/5mHtXGrb25uYuC1ySY4oObohSZ6O9IIu8apoJpMyxqdv7IaUMuQUwBe2j21n8ymUOb7TR7tq34SLcsOekggrxEwsJDb2KH+gW/AliJyMSLJ4ESeFV1HP0h7HMxSsnJUfBa3xh/3mktaWoFeUIkK/hUUsq+NEhgd/7mmcZe5MsERZ0juKLGg46GQBA3vajEW2MomPZURAxA5GHOeud5frj7vbe9OGZ7TtrNJM5AOfE+Gayn08h5/2MiQVHipH5xrJo6TIr8kAGAM1Kka8vNCWklxyYnSq9v8Nh6ccl7FNTu58u/2eFlxmuD9WoWmKnI4jdZ4JuQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EC/+1NP96yHW59I+w8UQwr2dlb/iu5XcwgFN/H1124=;
 b=upR8P3T9o7+XPNkYgr8Oe8J6thQPxDj3mHxZ2B5wiauRUT1OiGZrF/d1+Irr4/HIv+Syr4KY48pXwHZz+QMUD1n8REEMDIiKVv9q5Mupq+ik/DIdwuTQTMMmLsILQ2TvnPCJCaSk1EZzBh3PXXGvNKx8Awt2KztS8KARGt43ZrWcySHf6OX92Y13RKVexpjpLWu1gSgu6yJYhsyEy1UY0LPcR+VsRqQ4j8cya/aIkYlhe+0X668I9+NV31AK+Q4yTAkvUHTvHqMTAs5ezAUxdGzYQSRyKlzMB/H92yUnWpQyMSRKBCITATuUgwpylxz4KQ6NhZQM/0DVoKzA51x3lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:22:46 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:22:46 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:22:10 +0900
Subject: [PATCH v2 06/10] gpu: nova-core: correct FRTS vidmem offset
 calculation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-blackwell-fixes-v2-6-8e3d8bc32bb9@nvidia.com>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0283.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e9cf98-dcb1-414b-1d6d-08ded8ed0688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2ILa63GSStGmzlxml2UDor1lW8pQYI1ro0FdD/QMFbSGdYNKabAipl4bmsgXl57beGJLj6JfPweFCBhbxCoV4C4q7+C4zp807DDFc2cELlGQ2stDRHNyJIKkjvSFP8GDLml7lSQY2imxGTNorv5dtFDr+4nJYIoet+cKFoMo2Ay4hf/j8o943X9F83/6TmFLPQroec3qjY891oJS5Wc1UxiHcjZ0C0fAQJy9JkwIE8tRxw4gTVBGYVkV+OvHd4ay3LR4LjIZqz4dNZbDwo2oZd9+8yJ1WOXrARr5KWgFAFuNz7llG5pJjy+l5U1InUAcnnHsNMgRegKrxRIWyHdEKMrzQ6uLVG0YxAisqK1NyOUDw7cqBnA80Zujp5Vt9BKgDGBbmHVP5trp/3mNDxQLRwHapKmy8qM0tWLZ7d/LjB0y07V+SovSK3g9wHEXaEQbXui3YKurNB1h5KWOcOathhKqA99HLmpnfxlSn5d6CBPZeZethO7fgA6iyJoY9lzg5GHajKCRlAB0Nser1P/6hTjD+vR/yaBkeH8TlPV2TCsZR9ZZhKaw4MPPzobum2qc0mNPmnskRoXpV+ajt/ijmA66xP89uVeG1Gx9RmEW+v0Jd9oo19MlOUGfG5hDPBhwV9LDXze8nES4+ervshQcEj76x0r9G6QzSgLOpfYfl4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1ZoUUVDQm4wd29HZnJjUTY2UXphdVlCSkl0QXdscm9tRkdZYlBMckpIaEtO?=
 =?utf-8?B?Tm9JMVdiTVJLNkZMTHNURzFacVdwVmE3ZmxoMWFKR3R4cjl5SEVYVTBJQ1ow?=
 =?utf-8?B?elF4dW9TN3JiRkRiUnM5OTREWGZ6VjA1Q25iMHRmWllYalNRdXkvdFdJVGhw?=
 =?utf-8?B?VzN5M0tPNDVRcWl6djBnTGM1N2JpU0hRWlJJUktCM0ZXRDE2S20yMmtTVGhq?=
 =?utf-8?B?dVV5RXlVUzRXZFNiNUhSZFNzWDFIZ29RNXdWanFDbXZoNzVwRXVtck0xZDFE?=
 =?utf-8?B?bjVqaEwvL21QTGtLSkNhRXZTNDRZQnNyOCtzMXdYYUxESmNMT2ZxeDZnSS9B?=
 =?utf-8?B?dWxUaXRCb2Rqa0VVUGtpQWNZSHZxSWlraDUyTkY5VFpsblpYWnNhdjVtNDU1?=
 =?utf-8?B?WGVGdGFWU0JrL0EzRnh3cEd3ZVl4ZmNXanYxbEJ3MXRkdmFyS1NGWTJSTEFG?=
 =?utf-8?B?d1crM3ZlSVhNT1daaCttRE9hb3JWVkpMdzYvckJLK1Joc2t2RDNzWExwT0tO?=
 =?utf-8?B?MmIrbFMwRHlWQjQyMERGM1dUT2gxN3hjbXd0NTdOR0s3a0grMWJJckFQdGR1?=
 =?utf-8?B?L1RaUWY4dFBJcUZEeDgvVnZKU0VicUtROS9pRWd2QVd4K2NmWStSNkNVa25S?=
 =?utf-8?B?ZkNqWUxxNklXaVlJb2hoY0ZsOCtBamVWenpudEZ2UUNWWlptdDFxWE0xeFJW?=
 =?utf-8?B?UDMwMDA3ZzExQUNtb0J4ejJMSDBMK2hmVjFMQkRZU1FtQ1ovRUxOeXhuZS8r?=
 =?utf-8?B?bXUzeFpnT0R5OTYwVUxKSER0YmdPZGpZdXE3T3F6UkFtVFpSZytsbmR2cnBa?=
 =?utf-8?B?VTlzZ1BGQXNGWmd1RUEzVGhFaURoZVBrNjVWNWtZbnFtMHJJOWo0MElVZUNh?=
 =?utf-8?B?SC9kNlJsdVBOQ1V6RytvWmlibXc1aHJRcWZPcHVEZmg4S0tHUFlDNDFkMFZr?=
 =?utf-8?B?bm81UWtaUGFPZGRnbzFueFhxS3diWEJ0bGJxL2VmVW01ZldpS2ZHanFlcXFW?=
 =?utf-8?B?ZEFMYTI3Sk9ZaUtKZFJFbnZlcWhkSVB2Z0t1cFB3czdQS3NrSDdFb1psb1BO?=
 =?utf-8?B?ZzN4ZmMwUXVwRXpsa3FlazhiY3daV2g5TTY5Y0NWdU5oWmR3clMzSUJFUCtI?=
 =?utf-8?B?TWZHdlpYY0UxY0R6OTk3RWFwRnF5UEtKQjNsQTdoQ2NlZW1CdHRqa3dJNmVR?=
 =?utf-8?B?VmRCMmpYYTNmV1pOZGZwSEVlY1FpQ3lxK0IwVlphTUlBVjJRMHZPMzJrMHpI?=
 =?utf-8?B?NlZGU2s0QjJ0bnM5L0pMQ3pNS2YxK2ovY3FzK2JDcWJLdUV5ZTBLRFd1STk1?=
 =?utf-8?B?Z1NDeUZEYUxLVFFraDVGY0NERmdRM3FKeTc4bkN6R3AzQjhydHBza282ZkYv?=
 =?utf-8?B?K3NGRW5HaGE1SzViUmZBMVlFNG4xckZvNEZLU294d3Rmc3NKOW5oU3d5SUlM?=
 =?utf-8?B?T1o3WTRXVHp4OVRzRjg3UkVTSmdBZENyU0xOTG84VlRxT2g2RHR5MDhxQTJI?=
 =?utf-8?B?ZUxDNHVOczRiK3NKMnIyTFd3azMyNFJxMVpuUk5PcUdDUWV6UGtBUU1xNmI0?=
 =?utf-8?B?YklvekpseUV2QXlRTXBiQ3pYdDVTRi9qVjNKalNwRkd0Smhvcjd4N3VBeHhM?=
 =?utf-8?B?WGcwaW9UZ29VeEtsRm5ya0kzbUxQUVZaOTNKZHhSbStDY2JFTVlyaDduLzRo?=
 =?utf-8?B?UWtqY1pJQkczbGxJZS8zT0srU21sVFRrTW9TVU8xR3Fsa2lLQ3NYUnBlMmFq?=
 =?utf-8?B?OUFlUDZkU3JYbjNTVm43ZG92OGh5VTVDdUh5a1hnRHEwZzFEM0lrVUpYcDRt?=
 =?utf-8?B?Z0pHeWZVOXptTkdSc0lRTGhmYzY5NkxnOXkvWGRzVm8ySThuYXN3ZVZNY00v?=
 =?utf-8?B?YWU3RFFBQlVSQ1hPc0kzQlFCbWVpdEo4Wm12bzF2Qm9lN2xNelBxUmxwTzA1?=
 =?utf-8?B?a3VWbzRKZE5sSGhnRFNNQ3dFUmdjV1BCTnlzUWliRHFIN2tTNFpGcW40Y0d3?=
 =?utf-8?B?b2tDVTVwS0drd1BZQnRyOVFleUF2NENDZjhGWnFtVm1Mc3BtQVFTSzV2T1pJ?=
 =?utf-8?B?bVZ4dEtTZlRpZ1JJdHBwdzE3M1BYQ1VQbkJpZU5JQlAxYm82b05uRFVoZGt0?=
 =?utf-8?B?K0NQZWZTUFhjbVcyU3lEeEZUTEM4aEcrcHZ5WjUxMHQyNm5LZFUvSjlOQnkr?=
 =?utf-8?B?NUZTSVBsQXhMZjVJV3hsZm5zdVVIMzBoNHBUQXFmc2RwbkxQU1RCUHBJUzFB?=
 =?utf-8?B?NWFaUVdQRGg4Rmk3YnhQcWVxZ3JKbjFob3BsUVJpN1BaekprMWNtSStnRVR6?=
 =?utf-8?B?ZVlsd3d6b21KSzdmbUxweUkvK1hDY00vd3VxQkQ1aWxxNWhuUmFEdTJ1Q2RD?=
 =?utf-8?Q?G2rIjp2SNOTgW3TYXtm2VLoXhKchHNEDAC+WXybWmoBhq?=
X-MS-Exchange-AntiSpam-MessageData-1: Ao0bny9d9OB+lA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e9cf98-dcb1-414b-1d6d-08ded8ed0688
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:22:46.4607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpoIz5Wm+148fAmB9Py7D44DPsDNZ7rxePfAdE0W2ercmtvIiCuWx3cgNJlApWgGJ0gghiafCHp+iQVxJL/p0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

Currently, the frts vidmem offset is calculated based on the non-wpr
heap size and pmu reservation size, but this is not right. The layout
actually looks like this:

| non-wpr heap | WPR2 .. FRTS | PMU reserved | ... | VGA workspace |

It's just by coincidence + generous alignment that the values happened
to match. Instead, define a per-architecture reserved size at the end of
the framebuffer and use this plus the PMU reserved size to calculate the
frts vidmem offset.

Fixes: d317e4585fa3 ("gpu: nova-core: Hopper/Blackwell: add FSP Chain of Trust boot")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs           |  4 ++++
 drivers/gpu/nova-core/fb/hal.rs       |  3 +++
 drivers/gpu/nova-core/fb/hal/ga100.rs |  4 ++++
 drivers/gpu/nova-core/fb/hal/ga102.rs |  4 ++++
 drivers/gpu/nova-core/fb/hal/gb100.rs |  5 +++++
 drivers/gpu/nova-core/fb/hal/gb202.rs |  5 +++++
 drivers/gpu/nova-core/fb/hal/gh100.rs |  4 ++++
 drivers/gpu/nova-core/fb/hal/tu102.rs |  8 ++++++++
 drivers/gpu/nova-core/fsp.rs          | 25 ++++++++++++++++++-------
 9 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index fd60f93258a9..5ffe66af282f 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -305,6 +305,9 @@ pub(crate) struct FbSizes {
     pub(crate) heap_size: u64,
     /// PMU reserved memory size, in bytes.
     pub(crate) pmu_reserved_size: u32,
+    /// Size reserved at the end of the framebuffer. This is architecture dependent and used to
+    /// compute the FRTS offset for the FSP CoT message.
+    pub(crate) fb_end_reserved_size: u32,
     /// Number of VF partitions.
     pub(crate) vf_partition_count: u8,
 }
@@ -322,6 +325,7 @@ fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Self> {
                 .wpr_heap_size(chipset, fb_size)?,
             heap_size: u64::from(hal.non_wpr_heap_size()),
             pmu_reserved_size: hal.pmu_reserved_size(),
+            fb_end_reserved_size: hal.fb_end_reserved_size(),
             vf_partition_count: 0,
         })
     }
diff --git a/drivers/gpu/nova-core/fb/hal.rs b/drivers/gpu/nova-core/fb/hal.rs
index 714f0b51cd8f..aa50534550eb 100644
--- a/drivers/gpu/nova-core/fb/hal.rs
+++ b/drivers/gpu/nova-core/fb/hal.rs
@@ -41,6 +41,9 @@ pub(crate) trait FbHal {
 
     /// Returns the FRTS size, in bytes.
     fn frts_size(&self) -> u64;
+
+    /// Returns the size reserved at the end of the framebuffer, in bytes.
+    fn fb_end_reserved_size(&self) -> u32;
 }
 
 /// Returns the HAL corresponding to `chipset`.
diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index 3cc1caf361c7..ce544cbafa2d 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -81,6 +81,10 @@ fn non_wpr_heap_size(&self) -> u32 {
     fn frts_size(&self) -> u64 {
         0
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        super::tu102::fb_end_reserved_size_tu102()
+    }
 }
 
 const GA100: Ga100 = Ga100;
diff --git a/drivers/gpu/nova-core/fb/hal/ga102.rs b/drivers/gpu/nova-core/fb/hal/ga102.rs
index 44a2cf8a00f1..82b4c6034c4a 100644
--- a/drivers/gpu/nova-core/fb/hal/ga102.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga102.rs
@@ -48,6 +48,10 @@ fn non_wpr_heap_size(&self) -> u32 {
     fn frts_size(&self) -> u64 {
         super::tu102::frts_size_tu102()
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        super::tu102::fb_end_reserved_size_tu102()
+    }
 }
 
 const GA102: Ga102 = Ga102;
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index 6e0eba101ca1..a53932eaf483 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -78,6 +78,7 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
     );
 }
 
+// This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
     usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap() }>(
     )
@@ -116,6 +117,10 @@ fn non_wpr_heap_size(&self) -> u32 {
     fn frts_size(&self) -> u64 {
         super::tu102::frts_size_tu102()
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        u32::SZ_2M + u32::SZ_128K
+    }
 }
 
 const GB100: Gb100 = Gb100;
diff --git a/drivers/gpu/nova-core/fb/hal/gb202.rs b/drivers/gpu/nova-core/fb/hal/gb202.rs
index b78e0970f66d..bc0832ce04ab 100644
--- a/drivers/gpu/nova-core/fb/hal/gb202.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb202.rs
@@ -71,12 +71,17 @@ fn pmu_reserved_size(&self) -> u32 {
 
     fn non_wpr_heap_size(&self) -> u32 {
         // Non-WPR heap for GB20x (see Open RM: kgspGetNonWprHeapSize, GB202+).
+        // This size is r570-specific.
         u32::SZ_2M + u32::SZ_128K
     }
 
     fn frts_size(&self) -> u64 {
         super::tu102::frts_size_tu102()
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        u32::SZ_2M + u32::SZ_128K
+    }
 }
 
 const GB202: Gb202 = Gb202;
diff --git a/drivers/gpu/nova-core/fb/hal/gh100.rs b/drivers/gpu/nova-core/fb/hal/gh100.rs
index d39fe99537ed..0ac36d858791 100644
--- a/drivers/gpu/nova-core/fb/hal/gh100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gh100.rs
@@ -69,6 +69,10 @@ fn non_wpr_heap_size(&self) -> u32 {
     fn frts_size(&self) -> u64 {
         super::tu102::frts_size_tu102()
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        super::tu102::fb_end_reserved_size_tu102()
+    }
 }
 
 const GH100: Gh100 = Gh100;
diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-core/fb/hal/tu102.rs
index f629e8e9d5d5..8bafbeec9807 100644
--- a/drivers/gpu/nova-core/fb/hal/tu102.rs
+++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
@@ -52,6 +52,10 @@ pub(super) const fn frts_size_tu102() -> u64 {
     u64::SZ_1M
 }
 
+pub(super) const fn fb_end_reserved_size_tu102() -> u32 {
+    u32::SZ_2M
+}
+
 struct Tu102;
 
 impl FbHal for Tu102 {
@@ -82,6 +86,10 @@ fn non_wpr_heap_size(&self) -> u32 {
     fn frts_size(&self) -> u64 {
         frts_size_tu102()
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        fb_end_reserved_size_tu102()
+    }
 }
 
 const TU102: Tu102 = Tu102;
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 533fb95573ab..a38ba66626d8 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -134,20 +134,31 @@ struct FspCotMessage {
 }
 
 impl FspCotMessage {
+    /// Computes the FRTS vidmem offset for the Chain-of-Trust message. It is measured from the end
+    /// of the framebuffer.
+    fn frts_vidmem_offset(fb_info: &FbSizes) -> Result<u64> {
+        let mut offset = u64::from(fb_info.fb_end_reserved_size);
+
+        if fb_info.pmu_reserved_size != 0 {
+            offset = offset
+                .checked_add(u64::from(fb_info.pmu_reserved_size))
+                .ok_or(EINVAL)?
+                // The 2 MiB alignment is r570-specific.
+                .align_up(Alignment::new::<SZ_2M>())
+                .ok_or(EINVAL)?;
+        }
+
+        Ok(offset)
+    }
+
     /// Returns an in-place initializer for [`FspCotMessage`].
     fn new<'a>(
         fb_info: &FbSizes,
         fsp_fw: &'a FspFirmware,
         args: &'a FmcBootArgs<'_>,
     ) -> Result<impl Init<Self> + 'a> {
-        // frts_vidmem_offset is measured from the end of FB, so FRTS sits at
-        // (end of FB) - frts_vidmem_offset.
         let frts_vidmem_offset = if !args.resume {
-            let frts_reserved_size = fb_info.heap_size + u64::from(fb_info.pmu_reserved_size);
-
-            frts_reserved_size
-                .align_up(Alignment::new::<SZ_2M>())
-                .ok_or(EINVAL)?
+            Self::frts_vidmem_offset(fb_info)?
         } else {
             0
         };

-- 
2.54.0

