Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA05CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC8810E384;
	Mon, 25 May 2026 13:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FTYztMXg";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013042.outbound.protection.outlook.com
 [40.93.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA7510E384
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFhxBMqvY2XpK0oV9wZMOchihddfEUJv8sR5W+jhWXXUJGivcqmr7IUhAd81CcSZ0nh3nFdzSTpbg35EsLdczJ/P7nJOcitM8S+6+L/bYqHtFO3H0og5hu/AoLf0NYmZW/qk3ZQJWOSXWMShjWh7EMt71rYL61ftgc46Qw3H5WuUw6vAN6+7RVQ8YhP/h2aGYzyiC21z8Ybj1I9ku1NUqM6vptIphbm1HEB3leyh6G6VFYy1KuhoyBKFyrrmNxfgQ9CJKWD4Ymfgdh+eMZswJj+wyp4AWsK9pK7UjhASL51xscjaUs6FheH4sWOPOXOc5Sd7Cv3WuQbiaXza3+5wbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37oHg1BZVRUA/LLf735omqQfHVHTDQXjfXeq/Dk2G4o=;
 b=RDL6ATlVn3bLWT6Sa0qR0IiEDtM59J5lvl5UESaCSZ6c799mKynNJlkglhhgAnMEym84WMlD8JZ9SdvShjTTNWRPiAVUaM4A1ccOVkGxGmrHpxW1ptnK3PQtg8CCIGzASN2K3BDB0hJ8z1sMzkLugR+aQ7Kfi9XokRt1SvDWCQ4kfQn+fFFBO9awJSoQQcxc2CqioIz6x9A4oGpWQCgBcTO2hwSEsR8Lq2acokd7x17RGi5sCzFiAl9Bq1w0N59OXqO5UYEMUXUiWf6DTGV1My+Sp4PjDtaIsNVVk8NoH4zAgArwzY9ndfuq4s5Jt+jR99wDJF5qn9jpw3q+ap07aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37oHg1BZVRUA/LLf735omqQfHVHTDQXjfXeq/Dk2G4o=;
 b=FTYztMXgsUQWPfDe3ofOJgJy4HLoRQlKjbd2S+kyk1G+lr4Q8A36FH7qaC6lrhYWCeBveofZ4lGeZ4AXhip3p6LqYoTkol8oai9q5S8oot7bi8oFjDJGrt+N5mAR8tYENXaCnHQRIRXF5PJN9bANQpRHXdI7QpHnO7NNsM25IFPTPzUCdO1Apwm+g4UCWfX7PrE6LYthLrtW/BxlVZm3X30XOjK5h0LUG0QO0exHkVhUvQY+KKXPsPLUKt6yFN8dG8PWlJwCoexkCc8ZcNHRagsdponX10uNXzz+O+UQ4ATo9EUhuGxtEZQZysokAiWEgu7TsHBBd/XoLo83pmcZ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:35 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:35 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:30 +0900
Subject: [PATCH v5 12/22] gpu: nova-core: vbios: read PMU lookup entries
 using FromBytes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-12-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0120.jpnprd01.prod.outlook.com
 (2603:1096:405:4::36) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6a034b-ac32-4769-6269-08deba65b699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: IE9dY7SkqBRiYfwgpkY0vTFgw8L3eBoHo9BVyqgcmko3AzPLEeENHMTGKg5txRhnhh7wem0aGYnV2WZq6Mextn5di9arTFwH97HMgqYb/1A/Clal1H2g6NYA/qMn1ck096RKqDX3g8HhuPdztDigEn2SqHLt2HPJy7OwstFHmiu3rQ6kDSOTWfydI2QAvtQ0JblQNYZToK95S0muNvY4YmA9D0nKAKt5Vgpe7rh3sMEMATPJz8kPcuuMyLqBxo7ifl/oXuC2BH+LG/Nf/fytr3QaFamYWBm5PDdUY3UCAv7vg9UOkV+RF6qzYsxoAtzxG7csBgovHpZuZJ8+BYsKk772LQHPMNtKDJGsUcEwFQyFCHcRPoKQTjujJbAABXnsFoGHeccdcekhjRBRAORig8T64DeeAztoEo4pw8qtF6B73seq4BDGinSLy2GLBdu2Fb9DcNPXMq8aucWw0TwVnsR9uYAe9+h4GQDtVjqZ/iBPQMvkbo5IDUe8XUzx6Lt57r+et9dfFQz7KAl4QmmSkbqiyyRfquAFFiXsWR8A0Bw5JkMKudXsDwwhFQGFH0NbCZ1bHpvqaVQwOg2apkBQhGGT2R/M463dbnmLjAobjfToe+4OeUsaVBjEoT6DlJ6ibCq8DW+pixNu+FOKrOh+vw8SAL06wzt0a71Tdud3ThE9EimLNDNk30xtA/8Ta1HL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amVNUkxoeDVBMEplOHJuUmdoelpHdlRNNVUzZWovcHIvNkJZY1BXc1QwSzZD?=
 =?utf-8?B?d2krVktKZEYzNjNMSDNNckRFS1g3dGdVWU02dUZEZGM3R1QzdFdWVzRGSE1t?=
 =?utf-8?B?V2lqU0RxVEJUczB0MUFkenh4WFpuenM0cFBUam1YOUMrNXdzelBFRSt0LzRp?=
 =?utf-8?B?K1l4ZWUwT2EzTEZHV1FEalBSZ0YrazU2UXcweGcyVTd2c1htQTFEaHJkWTU3?=
 =?utf-8?B?Z0plbmRoNS9NMThBVGVnTG1UWUlrS3g3cjZMbTZtMFdKVXYzVkE4UXYwRUpq?=
 =?utf-8?B?KytYYW9Bd3dmaWF2TDFJUjFKYmd3ZGZnWHFGUlNjNHJMdHBqbGpVd1F6SzQ2?=
 =?utf-8?B?YU9iZXB0N2pZeEZkN1BFcVRSQW1ha1ZNeHgwSEZuNGZVSFUwQVZVakJvRitM?=
 =?utf-8?B?ZTUyQ0tBRUZIR21zV01LVjV6TURHSHRCZDRWRnJXTDlWQjVzcnZlL2FRNW5B?=
 =?utf-8?B?U1VUSjJsMFJYS0tYQW9FQU1JenpFY05vK2lYQmcxMEpxTXkvcERTMDBpZThn?=
 =?utf-8?B?T1dsY1E5UVVSTUhZeGZjZ1M2UFZDaDI1b2gxUFRyT1FUY2ZQWVdqbWlyUGxu?=
 =?utf-8?B?THRLbUpFQzlKSTdPdmVKa2krVFNTelFxT2pKQUhLamZrZmtEYjJadlh6Y0x2?=
 =?utf-8?B?ZFR2L1kzZFlXTWgyYzVpRVV2Sm9BWHp1ZVluVjEzcU00OWNlRm5CYjBEMi91?=
 =?utf-8?B?Qm8yMWR2MktHOVNYcFB0VUI0QWtQMFQwT2o2UzJBZFhiS3ExRi9DNUd5U1Jy?=
 =?utf-8?B?VEdTZ0RKbExzcnlkVkZQc1cyQ2g5TU1LNjk5QWxoeWtJcG5LQjZuOHRBVHY3?=
 =?utf-8?B?clZucXBNZGFvMzZLYnQwSWxFWDM1MklXVG90RkVsV0tjZ0xZeTJaMXBJZkhj?=
 =?utf-8?B?MW1aSG9KcWd2YTRxMmlJQmJaeHZDL1ArTXJkcTh2SCtUbU52Njc3RmlZcXBS?=
 =?utf-8?B?QTRoS3FUS2dQOU9TNW10aHNSeVpuQmxlUjhPdXAwNlBNT0lFR205WnpnYTFk?=
 =?utf-8?B?YUNOUVE1Qm55MjE4R00xSHpSa2dCanBsT2ZxMlN4eUM1RjhBM096M2VsekEw?=
 =?utf-8?B?ZTEvY1AxZG5kc1VXblJHTmhNSkdPWUVHSEk1QkVBSnMxSTludnpQZE1BbFRH?=
 =?utf-8?B?SC82YkU0WW13VW5kK0Q0dzViUytVUlB6NWlwNm5uQkNiRUdDbThIcVVZR2Vu?=
 =?utf-8?B?MDR0RW96b09JM3puMWF1Sjd4U2YyQm9RVHNkMzFrU09NT2xwT1VkWjNKNFdU?=
 =?utf-8?B?UW0wenUzM0EwUEd3TTlBbHpLcGRTaHlVMU9DMzQrT2o2aFpiY3V4RXZ6ekpw?=
 =?utf-8?B?MVB2enZOZnM5LzkvYUpLY1BrSm9SckZpNmlMajdFUTg5ZWhKQUIwWGo2dnli?=
 =?utf-8?B?ZlUzdnhGVnYwQzJmYVJ6OVNJNSs4dmx0N2ZSVkRlOG43UkN3Rm51MFE3VGk3?=
 =?utf-8?B?SWtRbGoxaWNsTmZXME5xcmNZc3VWNzRPQlJQckl5ZjJ0ZW5FczM4RXFEQlJ3?=
 =?utf-8?B?ZU52NnBtU1ZhVmRvSXlYaDg5R3p3RmVvVC9uQ0VmUVhKWGtZelVCT2hveHlY?=
 =?utf-8?B?a0o1YTUvWVZlaTcwcjM2YXdUWGZqT29MSWlUdnBYMGV3bE42R014UGt0Z09T?=
 =?utf-8?B?Q1NqK0wxcnIrc01Ra3hwSHBhLzJ0UkxQcG5SR1cvYlN5TTVQMDF1MVBneUhI?=
 =?utf-8?B?bmMvdnVpV0x0WktjNVZnSGgwelNwME45bytUSW9EQWsvcHAycmF2ZS9BVEpO?=
 =?utf-8?B?K0FVNVhsclRPa1k0ejVzczQ2OUFRb280MlU3NUl0NW9VazRHcHRra1g0TnAv?=
 =?utf-8?B?M2crLytwNnN6dWY2R0JJOXlROS9KeUtWT3h5V0dxZ0FOcENVMzErUzVIZkpP?=
 =?utf-8?B?MlEwMlhFaWszcDM1TEcxTU9obkZUVlJpT3VSeEF1WXFqdVdjQzR0U0lHc3FZ?=
 =?utf-8?B?NXk1SFI1eVYvWFcwaXN5Nmg0UHkrbFNWMFprZlQyS1RPd3FOUlJQeFZjZzVW?=
 =?utf-8?B?eTFva1lGbE5jZFhEZHB0UXFHaGlYeVNESEZNbWNsYlhWT1ZZL0RabzhNUjFK?=
 =?utf-8?B?RHV1Ym5yUERJNmJjUmJVbWtPZ3JEaGI0dkN5ay83RzVUaXcwb2hnRnZ0MlNZ?=
 =?utf-8?B?alZMd1EwYmpXbUVwWFdEZUdQQm5CQmtuY0R1WlJ5TktQcUVpSUc1ZXc1OFdn?=
 =?utf-8?B?am41dEwwYkNNd0g3N09kK1RVOXRXMFFwSEorWS9vVnU4ZGd1Z2s1MlNkNDg5?=
 =?utf-8?B?R1JDSGNHa0cybzZOQ1JkUWMvWUlIay90cWQ4QldNOW0wTFBzYjB5L0YrcStX?=
 =?utf-8?B?UEdhQjdWQ0dINXdEb3ZpU1prbHAvZDVYaGc3emxKUE4zWUQyZld2NEF4NHNx?=
 =?utf-8?Q?DiNKzh4Ijcy/aufiniHNs8HgP6RKWc97/yKBDTsWshNEF?=
X-MS-Exchange-AntiSpam-MessageData-1: iPcWwuCxSA2RDw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6a034b-ac32-4769-6269-08deba65b699
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:35.1989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGhtvODBSuSj3WOboRAHDnGjq5GGV+1gHIiBjMww6uMp9/97+vrN2yGQFSRhXQ9jEouKdzal21hsq6xhcTyOwg==
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

This simplifies the construction of `PmuLookupTableEntry` and is
allowed now that the driver can assume it is little endian.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 470e0e2a81ab..987eb1948314 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -897,19 +897,8 @@ struct PmuLookupTableEntry {
     data: u32,
 }
 
-impl PmuLookupTableEntry {
-    fn new(data: &[u8]) -> Result<Self> {
-        if data.len() < core::mem::size_of::<Self>() {
-            return Err(EINVAL);
-        }
-
-        Ok(PmuLookupTableEntry {
-            application_id: data[0],
-            target_id: data[1],
-            data: u32::from_le_bytes(data[2..6].try_into().map_err(|_| EINVAL)?),
-        })
-    }
-}
+// SAFETY: all bit patterns are valid for `PmuLookupTableEntry`.
+unsafe impl FromBytes for PmuLookupTableEntry {}
 
 #[repr(C)]
 struct PmuLookupTableHeader {
@@ -963,7 +952,13 @@ fn lookup_index(&self, idx: u8) -> Result<PmuLookupTableEntry> {
         }
 
         let index = (usize::from(idx)) * usize::from(self.header.entry_len);
-        PmuLookupTableEntry::new(&self.table_data[index..])
+        let (entry, _) = self
+            .table_data
+            .get(index..)
+            .and_then(PmuLookupTableEntry::from_bytes_copy_prefix)
+            .ok_or(EINVAL)?;
+
+        Ok(entry)
     }
 
     // find entry by type value

-- 
2.54.0

