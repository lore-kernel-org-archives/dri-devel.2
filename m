Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809CACD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D828B10E37F;
	Mon, 25 May 2026 13:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lSJkxI0n";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5D110E37F
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGjh9nLuMhL+mBEPuUxta04pX+8Zw6wPd/5pioECdGtuhCSfbaPWFgQ0Q4tJzJdTecj2J40kKB1swssqs58w6i0dY0kD6Dw/0id8NDR/gL0hReqGv3ZrzVLysI3jrRulAldtSJDCnYjaCIw4V1Vej7J6SHtXa9Dt2CmldsOQkRZcYEJJihDXELqInfHaWylKfDMsiplLI8c7HD0PSkF6UjOptHf5miv/oJUxHeT63J3YBegnn4PEr1X4ikrqc67F1kIcn0U7NBP5U7fCX95/nPOt6tK+AdA/pSx4GtqeYQNsHS4mbPYYi5mpIIIq44NxbihGy5BQ8H5vmIq8Tju3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k8iWz54qyTt5iLRlq8TfyVwsd2AeNe7OZbLfutC1pI=;
 b=CNJs3w5BybokC+/OLZjvwnS7WDbyeXovcBLAsEnEFe9tuahHUojNEtPSuJ8y59ePGCbzxcnROHLZbliBlUsKJjg3uzr2NzF6mhksafczJ9jluAhIgtNUQET5Cz+Gw/m5PdIwr1iYbSo5JFnqWKLB2WSokjY4qXZz0lS/DTptA+q1rHKcPOz7TUdgrlGVHaxZCckW/QhqhBhlDraq6RTeh28QXkOWMv+C2cek5J7PR6V6O5IvMPdeLiuCO0jngzOlm7NFn/2r0nADPXlKI6z/pzJt/1nbin+bMOjSL5MH8lzEuL9ENP9ho6iqobfJtishtb7/XQfsJLm3yXwHUNy8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k8iWz54qyTt5iLRlq8TfyVwsd2AeNe7OZbLfutC1pI=;
 b=lSJkxI0nHnsB8dTSzH8CQeyQnUxvIRoO73eL1zavzmrZFT0KFS4w6rJo1YK4lrlz3jtlEkPYkysoHRpl/lTtwmrXe7+rL+0D8N96ievJGV2sXVdIGePRkUCkBXvEuZ8qLmLRRe1xlehVMsb3SY+4Gb57uD4M1EELQF663OBiosU4LlWBvIZVHZhTCZJEOx+sCHgUpY3PTDuBBCmAAzs+3SPX9tJxxAxOGsWXLTXResob0QrW02Z1ZBCGK3D2t9xRVyoRyZpf1K2X/UwcuN6P1a00glqL/tZrz4ZmEIHnRFkwMTH8aj+zW0GVvJJgQMq2eThUEZ3wjknAZDEniVKZ0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:31 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:31 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:29 +0900
Subject: [PATCH v5 11/22] gpu: nova-core: vbios: simplify setup_falcon_data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-11-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b10da77-b9ba-4cb9-fdfb-08deba65b408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 99kCBMmpd1an8hC8ntKET1Um/r5G/CxJGSpztr0iI3W64V8g3QoHzOh11FCf/MUrx7BebQveIROHiCCXrH3/sVqdXDDETMINySCF6nMb8OX739EVol6lpGwvEHB9nCnTUb2IlEguEFVE8335PKGVRheSr+2SzMvailbA5rzuQ08SwYzjIniOqsA5RgQ8XcJA8tniCiWspCV9F9rFzggfE3ktFQPwVbzLhpH1OlurmApcB4lLVzQWU59532HnxhIGP65NEJybZ8BztyUqurvxvuJ9lQsYQh41kC2VRb2vGNY21BuRABBoFSMmqcbdrSiEp7HamRZDRiojW/g7sO3WoEdT0kIS3dAFHaS+i+SXe5zkRDAfOkH7uA5lDonA9wGHX/ygWbpHpISfTBCw2HFCz/U0ma4pnUNxZtP87+XDOxC0a/ejZIAZkJmHLqIjmzEGe4luKOcMNVdXpwO6X5enxuArJ8q7f213MHVDcWJch6gdR1JKL+EnRdyDu/l92GheiBvnX5VUR8XUcn+1KJfhJj179WuYQXS3+wE5jvdq9U2QLpmSnkU6s7lXBZ6OpNyLSXd1im96bKCRTymQOHcM2yRTWfRbs6nWfwY2KOuXwbRhi7yzgI6sLwnT9QFat6OQCIyHiuKCgRJ8WF1N74y9p9ghhc17NSKnbpUm3qvJCSmbgB65wZtivslsSuwNFUWR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWNJVUVmN2k0dFMxZFVMWmtrbFg2TnFYclhiMlE2Ukw4Q0VsU0NCWkJjaHli?=
 =?utf-8?B?MUtFWklFSHpYWXAyRVBub0d4OE9JTnIxVVJIYUhyQTExM0N3bHFyZFVTZGFU?=
 =?utf-8?B?MFNRMHlqL1JYcFZxU0lHSHlIalNzcVR2ZFN1b1lIeWlRcmdJTVMzdGpudUZD?=
 =?utf-8?B?dGlRK1JsS0k3UXFPNTJZbjlKNXJyVEozYVE2RTZybmJ4d216eUJXVHFSNFRy?=
 =?utf-8?B?ZVUxb0hxc3RpWC9ZZnhOVDh4MnJMY2Z0dElsNDUzbG1BQ3pwaTQwUXVMM2R0?=
 =?utf-8?B?bS9NUmxVV0V5MWNkUktuWDJHTklSTFlpM2VieGpGN1pHaElxKzBYL3dmSUI3?=
 =?utf-8?B?eGZPekpZNDRkSEdweTZ0TlIyQm5FQVJNYWowaTlDc0RQUXhYRXhrMzliWlVU?=
 =?utf-8?B?UDR5a0xxTm1zbG43aVd2cUlyNmtvckhjUDlReXFKSGhYZHVjbDFZaWhhcEVZ?=
 =?utf-8?B?SFllaURWVi9ZZHdQYndaMEU5QzdLbTZnOWMyQVRuUm5ES3hObndnUGN2U3cw?=
 =?utf-8?B?NENsZ1pVUC8xTHBCZFg1bUwwWG9tWXF2NXRSV1NZYnNDWEZpb29LVlU3bjVV?=
 =?utf-8?B?Mnp4U2tRWXlhZCtzMEN0M2NReitpenovZmFkYW03WGs0WGRwVjQzSTg1T05T?=
 =?utf-8?B?VTBhL1BLYndBdGY0SzBna3lNdnIyaXA3aHROVEJSaVpZbjBPTHIxeUpDTG1Q?=
 =?utf-8?B?d1NmZy82VmVEbTM1bkZEMlBTNHZ3YndKY1Z5SjUvT3hZeEFheGJpQnM1WCtU?=
 =?utf-8?B?bExzbUJTVHRoWU9OUCtkL1dpV2V6RlpmQkdZL3hXV0twc3FSMWJxc1NUMGtC?=
 =?utf-8?B?emZ1YjRsY0xGY0xtQmttV0FTWTNqNGRNWkI1OC8wKzVJV3h6WFBrVWtzcCtj?=
 =?utf-8?B?WFhndzQreFM5YitReGpXTkpHWUhaZ2ppTkUyeU9uVTVacTBKRHM5blFlR2cz?=
 =?utf-8?B?RWdldUNvVWxPdzAyQ1pJQkJSbFoxQnRpUWNibTAva0tGclU2aFFidG5XRjVU?=
 =?utf-8?B?dkZvd3U3bTVBMS8xREs0T3FqUHNoRWs3ZURzeVpLcWptNzhiamlGNFdOQ2Ey?=
 =?utf-8?B?cGthb0Z4cDhwRUZ1VHpSRGxhTnd0VjhoV3dzYURzR255YWtuTjArWkJJeWRM?=
 =?utf-8?B?UjVNUlZmb2Jqa2xaQVNTQVdHSVVmNG9nK0pCUnJ2ZHIxOXdrMHRxUnpzZnBZ?=
 =?utf-8?B?ZlZNbXBtK2J2bnZaZWNvY1h4YjFJVmQzbWIyNktiWGxDbEl6Skx4YkxaUW5a?=
 =?utf-8?B?eTJmOEFWNDZuYWNEeXBtemdFdlZ2S25vcjErTnd5blpWbDZ2MG15dlNYN0M5?=
 =?utf-8?B?QjA4Sm01RzZ6OE55Nnh4cHl0bVNPQmtSTEFXbXR0K2tiL0dta1gzK3FVb29S?=
 =?utf-8?B?RnFPbERuQkM2OWVJV25RY0Vra1J3UTFpdFJLVW5vVk1qWC9KYWVWVDUweWgx?=
 =?utf-8?B?UHJoaU5KQ2VyeWt5UzI1OHNvOEk0cTFyellyM1p4NGRzMzhCc2t5VmtiWDJJ?=
 =?utf-8?B?MnY1dUFXekduQ01IR1dNc2I1TmtVak0zSFB0REdMUXRoc05QWXZPTG54ck8v?=
 =?utf-8?B?R2NuYWdrcS9ES2tyb3MzRG5EYURpZE5yMllvenJxMUNtTENITkNwNDIzcEtH?=
 =?utf-8?B?MHFFVnRGTks4S2hmVHlQV3hQLzg4SmRuQi9XOVBJOG42QWc1cjFtM3Y1SXNu?=
 =?utf-8?B?SEs3Zk04YVc2Q3NPSE5ib1phT2MrRlpHb0pQU1JNYnQ4dW9tVnZDQkwzRDNz?=
 =?utf-8?B?RnJKcHl4YlgrUG9VNVh3R29ZN3hyL2dkZTV2c095MUVENVpaWFBDR2c4c09o?=
 =?utf-8?B?alFuRkJjR3FxM0FzSmVmaXExam41VlQycy9iTHd6d3dDaGFqWmdCZXdjN2Zp?=
 =?utf-8?B?YWtObzMzZkJQcjVvcFhSZXFtdm11OWZ6SHN2Z2RBSkhBeVpkSnpsWjdnOWkv?=
 =?utf-8?B?SCtaRlowL1lGbHJ6d0Z6bElDMG04UklLVXpHTDIxcGh6aHZuNVg1ZmRLWVJF?=
 =?utf-8?B?bE1QUlliRGdyYk1pSm1ITnV4aEtETUljOTJ3d2dlck9hRjV3WnVuSmJRcml0?=
 =?utf-8?B?Z0ZlQkR2aEkxUzFVV3FLdzcwQXFVdTF3M3YxSFg5N2U0VElKWlZQbENOL0pi?=
 =?utf-8?B?azBZVExkZ3Q5R3B2V1ZPem1uUCtvbXdYS0d5ejMrRDdvM2ZEVlZ0ZXZPM1Mx?=
 =?utf-8?B?THFjbnVRa2NLSHg4cFBEQU0xTzhvbzMydG1FdC95bTZtc1UxVVQ1QzFvQ0o0?=
 =?utf-8?B?MDJLS2hpVFFxM1BnVXFQMVl3Sm9RbngzcmxkTDFXdWFyTkFTbFdiNTdSeFM1?=
 =?utf-8?B?TmEzNENvN1RYNzE3WGtMckpPdWYxd09jbFdjbmFzbzBlZVptcENOejZnbWZU?=
 =?utf-8?Q?Y1QV5BHmyybSclBHiPbr34iiCEaUn/0Q+CRfYZ079s9a4?=
X-MS-Exchange-AntiSpam-MessageData-1: jTct9bznBglccA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b10da77-b9ba-4cb9-fdfb-08deba65b408
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:30.9220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4FkLC19eHNbPVsk7AZ4KZpNLJ1H2EjrRJmEc57l38hW0acwjTgiA++O1FcKVHhpFG/5vIBua4hGgnhSlBTBFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

The code first computes `pmu_in_first_fwsec` or adjusts the offset and
then uses it in a branch just once to get the correct source for the PMU
table. This can be simplified to a single branch while also avoiding the
mutation of `offset`. Also, adjust the code after this to keep the
success case non-nested.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 54 ++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index ca101b2b6095..470e0e2a81ab 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -985,48 +985,40 @@ fn setup_falcon_data(
         pci_at_image: &PciAtBiosImage,
         first_fwsec: &FwSecBiosBuilder,
     ) -> Result {
-        let mut offset = pci_at_image.falcon_data_offset()?;
-        let mut pmu_in_first_fwsec = false;
+        let offset = pci_at_image.falcon_data_offset()?;
 
-        // The offset is now from the start of the first Fwsec image, however
-        // the offset points to a location in the second Fwsec image. Since
-        // the fwsec images are contiguous, subtract the length of the first Fwsec
-        // image from the offset to get the offset to the start of the second
-        // Fwsec image.
-        if offset < first_fwsec.base.data.len() {
-            pmu_in_first_fwsec = true;
+        // The offset is from the start of the first FwSec image, but it
+        // may point into the second FwSec image. Treat the two FwSec images
+        // as contiguous here and subtract the first image length when the
+        // target lies in the second one.
+        let pmu_lookup_data = if offset < first_fwsec.base.data.len() {
+            first_fwsec.base.data.get(offset..)
         } else {
-            offset -= first_fwsec.base.data.len();
+            self.base.data.get(offset - first_fwsec.base.data.len()..)
         }
+        .ok_or(EINVAL)?;
 
-        let pmu_lookup_data = if pmu_in_first_fwsec {
-            &first_fwsec.base.data[offset..]
-        } else {
-            self.base.data.get(offset..).ok_or(EINVAL)?
-        };
         let pmu_lookup_table = PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?;
 
-        match pmu_lookup_table.find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD) {
-            Ok(entry) => {
-                self.falcon_ucode_offset = Some(
-                    usize::from_safe_cast(entry.data)
-                        .checked_sub(pci_at_image.base.data.len())
-                        .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
-                        .ok_or(EINVAL)
-                        .inspect_err(|_| {
-                            dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
-                        })?,
-                );
-            }
-            Err(e) => {
+        let entry = pmu_lookup_table
+            .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
+            .inspect_err(|e| {
                 dev_err!(
                     self.base.dev,
                     "PmuLookupTableEntry not found, error: {:?}\n",
                     e
                 );
-                return Err(EINVAL);
-            }
-        }
+            })?;
+
+        let falcon_ucode_offset = usize::from_safe_cast(entry.data)
+            .checked_sub(pci_at_image.base.data.len())
+            .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
+            .ok_or(EINVAL)
+            .inspect_err(|_| {
+                dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
+            })?;
+
+        self.falcon_ucode_offset = Some(falcon_ucode_offset);
         Ok(())
     }
 

-- 
2.54.0

