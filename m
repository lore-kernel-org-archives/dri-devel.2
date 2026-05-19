Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90117CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF68810EA1C;
	Tue, 19 May 2026 02:56:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yq0gaJor";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD5F10EA1C
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAxlcOnXv1brbsT9E0jJ7hCLXu2qFBhOlppX0iFEiukUyiKejPOfM9f559plooKMlA1i/qdJnVOws+zqmgJOyVK+3eLYiIaubqycgFVlR4ttcFZXZOj0LgcAi9v8WNwBkr2F2hnbCm7tsHD7g2B75wWtLQEGnIqbq5148mWO+nLjQG4u1DPRUq2Yel7jMD8npLjoDgbVYCIeRYoDHUEppasAMKGUY5uNefZMZ5u7/uwQL1pGTt7cBn8ytibADnREUmMovVz05nWWzgLSbr3mmUST0Hpa1Kui3GT/y9QAj2VJs5hpp//5iWBfeIUvrASvcYRIY3/hVh7P/I9e0N8vgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fji9+BmM9ucgnMAc1lpZpqvUPMwsd+Vw47/dPaMkzio=;
 b=V0qrBjniCnX0aBJN044DOTTiqw2jKNXDZQ3l/juNj2eqtMu+yVH/qi+EaHhcEbCUlGvnoz8SYtr7lkxxerxc6xuMKrl0TLkf+5KmPB7MBsZJEnDPXH6b9tblTiL1CBsBCSTAHLyxfvfxnRNNPqJBKAEmR0H9XOBB3goMQFWw7Q5DoK7r0JEIwJFn5q99zQH/XgxV2g9VIKdxn5TH7cE3Z3moc8acMsC6DllzoGTJ6QD8vVmS+64snIcT2J2tk/fUSTsQvp6Ave3E8T4aNoJSxRDJ+rD1HnnWUQ1B9x82yXr2v4E2FK3deeQ3rkh2yT+yr9VkzNervRfMwoMncuBwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fji9+BmM9ucgnMAc1lpZpqvUPMwsd+Vw47/dPaMkzio=;
 b=Yq0gaJor/h08D8XWzjQMDqPo+TsA79DjaXjzseJjoCeQUqpb0B4oOlFyxn1550Ubz6tQIXMxrtCOiogaHfYo2oQNRa6xPGklYPN+A3wv4DJ7NTYa31c7FUo6/ad9FydLAYNFAviLyxDrF3Zs0XVLywqsaJnhk+cr+sts174kgkdr/ZslWGwEL0KM/YuztOkgaogYdDouTy58VYX/CGs1lQAqcbdt90wADMUvtZKj6T39yJTIKDpS43gylttt96RmRZ3W5Bs5+Set0jKaeA9Cdm9CI3TQw8YBCVunS9RbnQm5uwiSQjX585nrq3hcdjbqLAbnZdlnUWo5l5ovMc6zHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:55:58 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:55:57 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:54:57 +0900
Subject: [PATCH v4 03/20] gpu: nova-core: vbios: avoid reading too far in
 read_more_at_offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-3-5d3f210c5602@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:405:370::16) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: d0494369-0fef-4690-d965-08deb552265e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: K2JKL/5Gt/jxhDWZYggIav84AHgJCT+vP9wZVeGoQTuH/kPwbvK6f2p58zvxghfUR+6iEdHvYRuqsII5YZq51MsMI7fIJbrXT8GFV0XVk+gRfzwz+XuILkIj/dFln0E1hxyZxYdngyzC5avBQdjSkVAtDpAwX2CzBTIThHj9U7hEyY9pQ1P+tRY3hqvX4dIIQVuMi1fAkE/PS+YYncBspi4HAt956g4SN8IqLVlCBbpQvDUgn1dm6Kk99GBMPeRNaHfMDweU7nY53/RRouvE3042JEZvD6/KaNcJfKhvHnDOloZN9DHmZZl8QfNgNyam/dgPwIOBmSbieY2cVCvQfSn9AkI6v1tK75uGpZet4LXC2JB2xgseD0CU7IbHV8CNGZ/lkdhvE+x4dk5Fcsga+Cm7K9AOmwQ3uvIWxlvSCN7MeteGtMW9MEdxEsO/BuVKbIsLuGjScroxP0f6+xyQ/gAEWkyAe8XdGv1coJ1L4C0mFY2Mnw0dP8hFRPmjcm1JMIBM2WajcoFlaHPyWS7hvQPnCtoE2RvvycwiElgwKq8PShgV94DJgGpscCLMkZlSroQ9TJHWPF3gCxt8+9G05z5XyRO66BLilxoo7AcyjoK778Wu75wVbDsj8l1r5O3MTldI17OaAigBYJ+cgMY078+g4rM5DpxJLCLmScUcETRLjRh31kYN/gVXUW6VPHE5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXMxZUM3UWRablhoZTR0UkN0TUh6VldpTTV2ZVVUR05GUWc5bUJ1UXhHNHNu?=
 =?utf-8?B?Z1JpMVBkMFBRNjBRbGNRbytnWi91KzlnV1l0MDkweW1QMlhjMDJVWEc4Tldq?=
 =?utf-8?B?SXBYdUlITUlwUHIxV3U5Rk5zSkR2ekE4TkpQWkxEend6dWszMVI2QmFQVWlV?=
 =?utf-8?B?c2FXM0FQcmJ3MlltTFUvcmVqZ2dYZEVZa091U2pxaTkzQi9RREdIcnE2WUs3?=
 =?utf-8?B?Q0JVdDZxekN2K1Z0dkNmRFd5cFVBZDZMZ3FLWFNvSDUvWk40YzBudkRIejZy?=
 =?utf-8?B?ellMWWRFNWcycC9SMFdwaTNSL1ZURXJYcVdISnpscnZobHJ0Z1Z0RUJTeU9D?=
 =?utf-8?B?QXdaTGlRaU5xYnFibGc0QjRXQmMvSTltOUtPQjVPS0lnUHkxRmoyVzlYcld6?=
 =?utf-8?B?MlBRTEduY0VYSXFBNmVDSFdSY000OGliU3NCMzRERDZYU0YyZTFLcjlNVWlV?=
 =?utf-8?B?RC9Xb2ExdVU1QnlKTkJvYU1oZzQvQmsrZG9WdnJzdzZXSGdQazVVbWtVbG1s?=
 =?utf-8?B?TURjTmVIV1RFNk11R1A4ZkZBVUhPQ1JraFVWMlY4aTVCWW9JcG5RVGFwUXVI?=
 =?utf-8?B?VkpvTXNteDY3TGlRNHJHdXRETGJ1dFFBYXZ4T1liMjVSdVJLUitVOE0vQnJZ?=
 =?utf-8?B?NTc0UUhNM0N5OGVhZGNIamlBUXBkcytvTDg1ZVFxS0t2YVpoYXlRbFNFNFpz?=
 =?utf-8?B?ZmdnVTRCWVQxdjRyd0pvZXN1aEZ3N2NaempiaXFaWTlhbWZTcmw5VEN4SkdB?=
 =?utf-8?B?WjdaNHNHbHpGOGIxUWdXMyt4STFSMGZTQkM2UXg1bjlhbjZrTFB2MG41Ujkv?=
 =?utf-8?B?UW9MTGhmenNJMUZGZGFNWjNYb2JyWm9rZUZvTWI1UEpwc0VQdnR0cENRS2Vw?=
 =?utf-8?B?dW1pcnpwV1BiandUK3Y3VTlSQTRHcHRIMjNVMy9zaGs3Q0xZbFZrN2FXVDlI?=
 =?utf-8?B?ZXNXb1FiY0ZDLzlqUmI3RDkzWFB4empRbDdXemMwK1pqQmwyTkFLS1VQK29N?=
 =?utf-8?B?QmFhR2JOWHlWaHF0QWZVRnZJTHBuTHJvUDk0Y0FhMUhhL3RucnpUYmlsUkF0?=
 =?utf-8?B?cExpZUFpSkhmamNPbStYRzFNcFhLMXJFV2dNVWFqbkV6YjM4Sk0vQjNHeFk4?=
 =?utf-8?B?QUE2RnZmaW5yeWEvVGVLKzdvNDlSdmhYRzk5NGFjZHQrcXRaL2ZISEhQL0VS?=
 =?utf-8?B?dDB2UUZ0WXI1UXlJTStLeHRNSEV5Nk53ZzVmR1BhSzM5aUR1Q0N2R3dPOFpW?=
 =?utf-8?B?YzdXQTRXbDBLN1JLQTFRRXd5RURoZzYveERWSjBSZmRBQk1jc0U1TFpJenhQ?=
 =?utf-8?B?ZUJSOGVJMUJZRmFObThML3lveUdjZjVLWDQxUzdMMGFuVTRsNFJqM0FIOGVB?=
 =?utf-8?B?RTUxYWVrSnRJM25hSmh5N2NpTlVxQTB5WkVHZlBzaURTMUsyV2RYYmMzQzRD?=
 =?utf-8?B?WldPNE92eWo4RmRTUjJKbE5MWHlmU3I3UmQraitTV01HeHVobVRSNXc3dmdI?=
 =?utf-8?B?OTcvZUR6SGR1d2pEYis1QjUvVGUyQWpJUUlWRkxFZVYyVi93SGxMZ2dVQldm?=
 =?utf-8?B?SUpQVDJkQkpQV1hSMGgrdURTVkxHUVM5ZTdRbk1scFR0Yk1GblhKZVZRWUND?=
 =?utf-8?B?R3BxQWY2dzFpVGI5ZzEwNElWQXUyamVKVWR1QkRVeVRYMUZJSmIxQ2Y3N1Zv?=
 =?utf-8?B?RS9sZlNOL1gvZ1prTTZvSHp6ajZPQ2FRenhPblJSSldsdlVXYm1SZUFTUStN?=
 =?utf-8?B?Tlkya3RNUjROei9NeEdMeFRCQ2ZqYzVnVDVBaXV1cUFlTEFacUFuN0FENGJu?=
 =?utf-8?B?WDFIb3RzbFkwa0tFV2k5bjZVYmJpZGRtSGR2bmdIRzdvR2JMTEZ4QzVBZXFV?=
 =?utf-8?B?ZmpQL3BldnN0M2N5R05CZlhmMEFmMXZITE00Z3dtNjFlMWZOYTEwb05uS1BB?=
 =?utf-8?B?WGZqZ1lhb3lMUlI4L3ZQRmc5VTVoUVNYVmRsbVF2Z2hhTy8xQ0V4eUhxYkd0?=
 =?utf-8?B?cHhhWktJQk4zV3FXdmJ2QnV6OFRCdTVpZ0NEMjFuMVRPRldPdlJHdzVlQmFx?=
 =?utf-8?B?ZkVpSEpiWnRLRHVYRWtOS2NIZlNvQ1dURHd6QW0vRWZ6cDJRSmsxS2ZXSjg0?=
 =?utf-8?B?enhjT214M3dXckRJOE9xQ3VXVjJxQWF1cjkyV084QnhwMDVDbHVQYk5zNXYw?=
 =?utf-8?B?Zm1XTFlxQVVxN0lNWFZCdkxqMTJsLzgwUThEcElaVEcvTmpKM2w3OXptNFNi?=
 =?utf-8?B?R0NkWWhMNllUMVZlSFBNWkZsdDk5Y09rQnBuMEdEV3M5R3k0RXY2UzFYbm1U?=
 =?utf-8?B?VUZVN3hkSDlkZFVtcGNCNEM3ZDBpTEF1Q1QyUUFaV3FvOURPQ2lvekMzVW95?=
 =?utf-8?Q?5k2oxwmfG5ZFNI5w7pgK/+1+auAaGDrE4RQeZR8e0MDdB?=
X-MS-Exchange-AntiSpam-MessageData-1: +vbRROikPgYnBg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0494369-0fef-4690-d965-08deb552265e
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:55:57.6746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDxPE8D5M1seV+iiwY7nZgWvcPuhfeTHRjygJwa6T2bdGNJ4oNQl9KvJ97nkEYePcHVw79EHXGgzgzuUcDA3Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

Fix bug where `read_more_at_offset` would unnecessarily read more data.
This happens when the window to read has some part cached and some part
not. It would read `len` bytes instead of just the uncached portion,
which could read past `BIOS_MAX_SCAN_LEN`.

Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS construction and iteration")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 180928433766..79eb01dabc6f 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -185,8 +185,13 @@ fn new(dev: &'a device::Device, bar0: &'a Bar0) -> Result<Self> {
 
     /// Read bytes from the ROM at the current end of the data vector.
     fn read_more(&mut self, len: usize) -> Result {
-        let current_len = self.data.len();
-        let start = ROM_OFFSET + current_len;
+        let start = self.data.len();
+        let end = start + len;
+
+        if end > BIOS_MAX_SCAN_LEN {
+            dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
+            return Err(EINVAL);
+        }
 
         // Ensure length is a multiple of 4 for 32-bit reads
         if len % core::mem::size_of::<u32>() != 0 {
@@ -200,9 +205,9 @@ fn read_more(&mut self, len: usize) -> Result {
 
         self.data.reserve(len, GFP_KERNEL)?;
         // Read ROM data bytes and push directly to `data`.
-        for addr in (start..start + len).step_by(core::mem::size_of::<u32>()) {
+        for addr in (start..end).step_by(core::mem::size_of::<u32>()) {
             // Read 32-bit word from the VBIOS ROM
-            let word = self.bar0.try_read32(addr)?;
+            let word = self.bar0.try_read32(ROM_OFFSET + addr)?;
 
             // Convert the `u32` to a 4 byte array and push each byte.
             word.to_ne_bytes()
@@ -215,17 +220,9 @@ fn read_more(&mut self, len: usize) -> Result {
 
     /// Read bytes at a specific offset, filling any gap.
     fn read_more_at_offset(&mut self, offset: usize, len: usize) -> Result {
-        if offset > BIOS_MAX_SCAN_LEN {
-            dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
-            return Err(EINVAL);
-        }
+        let end = offset.checked_add(len).ok_or(EINVAL)?;
 
-        // If `offset` is beyond current data size, fill the gap first.
-        let current_len = self.data.len();
-        let gap_bytes = offset.saturating_sub(current_len);
-
-        // Now read the requested bytes at the offset.
-        self.read_more(gap_bytes + len)
+        self.read_more(end.saturating_sub(self.data.len()))
     }
 
     /// Read a BIOS image at a specific offset and create a [`BiosImage`] from it.

-- 
2.54.0

