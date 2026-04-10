Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA49E99052
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AE6310E8F0;
	Fri, 10 Apr 2026 08:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="C5nskQIL";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C8C10E8F0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 08:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzdn9h3mzmnGsaBC1eqhWMpqko7OYOu+10KOJ7ZCgv9nAJgqo9mLmty3XhqHF7qO6cHfUy7CQoHyMwwuZ3dxuSNd9ExbxGzVIBtWmuk350CgmuxeFVnVMeh9NoNpccqEzojrAkcPJjGKpNwHSf91WOqb0n58Fbr4CyrAkNNWTXowzTTbjgFFf/1mBQul6Sq/S3OfVYECCNNFNfJYq9VGAIt+2/UdORkOxGRPpy3EZQ9wTJfY8EaZpn3VT++CCOjT21BZWkLmkHHQQKUKFkZqurlxDo/31b/6uaHXpIF9yMjuLlXOkUex7uBTy/L+Qx0drZ8Qh0ZQOWuwHz6SSShTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRCh2daE8VDA8Se9OdsE0H6TIFWcBUKC7duXRLrCBDs=;
 b=YQibg452OxfASZC5nrJTg08E7OHVqiVk53oIRskrA+BuKQNbXbxSqZn0mwegrtL9qQtZxYuF5zluHtu0yUQD4ls1tohcUTPtsutaucvBS0q96MOQRrhUfuA/Ae3D2eoI0fEzOfnRSdbXBfRVCkwM3t5440MT55WxIn38YkiMGtkDOU7tJkql1LsgU+iodTPxcDfff93NeoT6EEnV4couDwA8Uj0AFJSepst8X9OQbBkH3a+WURKETtkJIf2eTFZQ+qOjw+L03/fjaKOWm7AeQ1OlEo1DIu/o0ypvFQifBXuseye/qn0ctwezdFgF0ZfaUuL+4XD6amWIFRhJDhNC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRCh2daE8VDA8Se9OdsE0H6TIFWcBUKC7duXRLrCBDs=;
 b=C5nskQIL53ssycLnRXLe6h//4dy6m6jsxDbEmr35ZFmhuw/2dgRN4Jv7zKhEaEJh3k8L0XizsJwiwSr58/5PAXSo0iiOkbfbc4jAiObvP53kn5zhM4yhd5E7gYI+mxmKqg0qay10LCoq55FpMTinfNJDli43F+droreCgmObaSV8+KbPMkCv5ZqnhceR1+2TO7E9d5WBoUSWSsA+csaySyFEHVI225NDRw0b8r8rnwj9Db3f1lk+Q/kKBdydhda9QLEhF1V/kZkKarYemf0efS+ubypIT8pDQf10+I01i9+WDQ1BYJym5K8uoIkPORNviH2+sX23vjZcltK0ZLBZQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 08:39:30 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 08:39:30 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 10 Apr 2026 17:38:54 +0900
Subject: [PATCH 5/5] gpu: nova-core: vbios: use checked ops and accesses in
 `FwSecBiosImage::ucode`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-fix-vbios-v1-5-bc6f71d153d6@nvidia.com>
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
In-Reply-To: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TYCP286CA0079.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 79844229-e85a-4680-1528-08de96dcaefa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0PGmH6NTcXvhkb2BOS5i+/OPwkRVqILSQXXrY7hCTJcuQQQL3Piu/6EejKyT50MWAA0TW7iSvE11JOJHORBZDW7qOTh04kyBzuGm6AGqFWhRq/aHUl/gHPr4q7W5ZFssA6r9DKQ8QB1R/F6XiAzXglKM18EyO7Vd2zNeHhsg3f8ecaxT6b7XwxYM9npWFGaTI+oe0tamsSsnETiuJmRxD45xb6gjrx9C86VfCub0PLU59mMdnbs1VFu6Y30ZxjBAurlA3A0ificjpJzUcaMuz0N+BuP36nihDmdMwe6yYNfRgur3SDPnqIG/hsh7KfAnhbIpSfPICRMR4LWwx3Zp1m+cVk+sLWtmXu5dTZYwe9ArLUvQZ967/fXPifTeW6gvDsVkaTTCx0oqWd4XnhZTx6T+/U/XbQkEYl3nCozLVdJKn5u/ilY1Gp7z4HzLfgKk7Z5Su7vkkMLfZo5413RIYc6dBxhWWbFlKxB0qdnIO69gkxjnSDdsJyRQHgbW61iMt7u/gnY8tItIWjVXtf2oKMMRq5FkUgEAEUhI50svZq9mI7ZfP4mZcTIlkvcckLtpuq6i9gdk50DZYa7BJZ5sZJO1ziL+IJ+mwE3COpIP0tgl7AgYmYU/hdY3FxfaBZpNiLI98rGXZVgap2gBNs3yMWG9Uf921B5NsEJLA+5/Y30DVaYb+BOOlYV8Of81y8uFzu+WbZ2FFdcgFoKEliXezcg9iu8tmSV8/TlXZYTZEcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUEzWVUzQ3NhQnRzMlVnbDEzWGlKUVNBZ0IrQVUzRndPQ0JnTFROZkpqbkVT?=
 =?utf-8?B?enJwQUlvSk13SElTdU85RVBnSGZtYUtHNG5DQURqMkxNcEU4aGtWWHlVNmI2?=
 =?utf-8?B?QWVDZm80azI5QW5PNHg1S0lLNXhtMnRNWGUxZWR3amtIZkRQUHRBTEhON1RC?=
 =?utf-8?B?KzBWK3RYeTRycUpWOW9VdTJkZGJoZi8vUnUzOFFqNnlva2dQRm5JdDhvbE93?=
 =?utf-8?B?VTZqa3FDQmdUT2xGeUtDYU5tOC8wWmlDM2l5b0kwVHVJeXlJUmYvTWxrcGln?=
 =?utf-8?B?T0o3eG10NFplT1I0NUNLanJrVWVwSWk0R1FxQy93WVQybTU4ZzN6QW9saVVL?=
 =?utf-8?B?ZzcySVVFbFR1TG9oZHdtWjVHMGtKcUc5MldJWlRVemNLQ2luNzhBVG5vclhM?=
 =?utf-8?B?cmRNbWVZYkNjQ3lQM3JUTjljQ2VQR2EyYXNlMm9FQzVubmYzaFRqZHlZS1B6?=
 =?utf-8?B?QWlDaFJQQ1JsMUk2MjdmZjFYVWVtenVSckJTOXdSSWtnMXBVaHJiUytES3ds?=
 =?utf-8?B?QmMxdENPa29hZXBJL3NaNXRUSDljMjBSd3lVOTVBTGh5Y1E5ZU1DVW5Eb1RE?=
 =?utf-8?B?TUE4NTBaVnFqRFA5V01BTUpqRFl5dnJvL0VSZzcycW9Pbjl1WEhlTHg4VG41?=
 =?utf-8?B?TmsreWZ4YlNCeTQ4NnJ3cUN0WFpldDJKcmh2enJmUXprMmZuQ2pFZVROVHJZ?=
 =?utf-8?B?NzlWN2dlTEp1eGxaamY2eXRlRDMyYXF2aS9uUWl2NUM4Nk40MXVlakNsblc1?=
 =?utf-8?B?UGY1VU9nK1Q5U0pBTWdPcXUyM1NkaGV4MTc1NDVFcVM0aHp4cmZBM05YMCtG?=
 =?utf-8?B?ZGk3VXJIZGROSVZqOE93Z1RUUU5iRC9KeVpUSlBrcXZIYjk2MHN0Qk1IZkVN?=
 =?utf-8?B?dDhKS1JUaGt1eHpiZjhHVjZSOHpzVE1maHc1d2RwYUVoU1QvMVdkSlhOUHFa?=
 =?utf-8?B?L0xkWEd6YXlIMTAyRG0yUmNzaS9nU2o5L1ArbHdsQ21zWk9WT1NtNFlkZnNx?=
 =?utf-8?B?eW5CUUVzMFRlQTNZbk9uZUpJaVBzQ2M5RHRxRDdFYTNvazQrNjJUTEZXL3Y0?=
 =?utf-8?B?WENsUzBFZ1VNeXFDMC9GRFc2Z04ycnpjeGdtNW0rbTZxMUtKZU54Zmt5a3pG?=
 =?utf-8?B?QTV6YUFJM3ByRHRqZWwxdGR4QVZQMXkyb2dhVzZzU3JzNnR5ck10NTIxYlNn?=
 =?utf-8?B?TVZSSFE4TjVwWU5uK0xjSTRXU1ZNYUk2SzNieTBrVWJzd29VTXFtcFZ0dHNw?=
 =?utf-8?B?bEMxclg0eWZ0OWJNUjlEcW1DMWlqNys4TTlFV3RHMm1sNHFqcDlnelBFanRY?=
 =?utf-8?B?aTNPb0NMMWp5cXhpS1FjTUUzVGVTR1I3QTF2d2k3ME5WcTJKdExXY21FMEZF?=
 =?utf-8?B?cU1qd0UyMVptWjV5YXBGaDNzTFJEQlltMWcyYzZicUhzd1pqNUJoT0ltNFlD?=
 =?utf-8?B?REpyQXNYRnpvUjIyTkJ6cGdTeGZ4TjFhbEh2ZU9OQzZBa045eEE2NkR3Vkt3?=
 =?utf-8?B?STVSa3hHblJCY3ZBWTViWUFJc1VWcjVBTUV5VW1SemJlYmFLUno0TzVWdE4y?=
 =?utf-8?B?R2dNNDVDSGtWUDlQc3g4SGJzenJDWFZDQVc4T2RFQXFKeWUySm1nb1dadlJY?=
 =?utf-8?B?eWp1bnljTGZPdHowa2d2SmdYWHVibU84Q2czb3pkWHlBTDFFcnVQQ3lkNExq?=
 =?utf-8?B?a2F1S1FlOENnYThCTlFtTVhXRFdxN0M2WE04Zm9ZTzUzdFllUFhHZmlwRUFI?=
 =?utf-8?B?ekpDQTlnUzhLMWpmVEh0M2k3N09iZjFZa2NUVmptR3cxdDFQeWtYRzVyNTNn?=
 =?utf-8?B?bmpFN2ttakdhWFB5R1oyakV3T2h0dlJBblZwbzd4ajNTZmhtSEJ1T1pTR3pM?=
 =?utf-8?B?dVJzTWpWTktoVThFc0w5K3dZMm03UjJVakNYc25ZS1BWQnhHQm50bzFvNzF1?=
 =?utf-8?B?MjNmMzRPTTlMRWpKRHQyeHRTYmJxR1NKdS9reHd2VklndHdsMXREaEhVUnJk?=
 =?utf-8?B?TjJvNmVMVnJqMEdOeW0rK0dJNkdLRGJIQ0pKU2htTzY3TSs5QTFoK1BFbWhk?=
 =?utf-8?B?UUp6R2d6cEVCcFRmQm5EZzQ2eHlURGRDNVRPSHVoenZBNXVaWmloNUt2VVBH?=
 =?utf-8?B?Q3UvOE5hUm9uY3pxZUtDNEFZV1hRMm50bW1jM0lBVlJCeFNrSzFCUDh0Q0tB?=
 =?utf-8?B?blVudjFlSFZaWlJvWWZhWDNuMFAvTWJpaC9KTS9CQjVZdjVRL0tTTWdFYnVn?=
 =?utf-8?B?NmZJT2szckVNOWdiZWVhTjJpdUVNbG5rWU5QcERsc0Nuam9vR2swM1FaTFdL?=
 =?utf-8?B?MzJVemtqUHVTeHEzemFJOVpGc3dmQytlZVpGNThiYWswU1U1bU00U2dwbVlL?=
 =?utf-8?Q?AjR32G/wr0jKtRZ9N0AvoflCGo3Zi6DjzbgmPGR3K93d6?=
X-MS-Exchange-AntiSpam-MessageData-1: 7wPlYkjuaUks2g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79844229-e85a-4680-1528-08de96dcaefa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:39:30.8652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViHEBSHH5PAYaRc6dxEehv0GeO55wfDLnh0oQ5gsiae3YceX6xWtnij62YcHOToQZpBzVRQ5h/PX0ITbmhShsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
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

Use checked arithmetic and access for extracting the microcode since the
offsets are firmware derived.

Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 3bd3ac3a69f2..b509cd8407a5 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -1027,16 +1027,21 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
 
     /// Get the ucode data as a byte slice
     pub(crate) fn ucode(&self, desc: &FalconUCodeDesc) -> Result<&[u8]> {
-        let falcon_ucode_offset = self.falcon_ucode_offset;
-
         // The ucode data follows the descriptor.
-        let ucode_data_offset = falcon_ucode_offset + desc.size();
-        let size = usize::from_safe_cast(desc.imem_load_size() + desc.dmem_load_size());
+        let data = self
+            .base
+            .data
+            .get(self.falcon_ucode_offset..)
+            .ok_or(ERANGE)?;
+        let size = usize::from_safe_cast(
+            desc.imem_load_size()
+                .checked_add(desc.dmem_load_size())
+                .ok_or(ERANGE)?,
+        );
 
         // Get the data slice, checking bounds in a single operation.
-        self.base
-            .data
-            .get(ucode_data_offset..ucode_data_offset + size)
+        data.get(desc.size()..)
+            .and_then(|data| data.get(..size))
             .ok_or(ERANGE)
             .inspect_err(|_| {
                 dev_err!(

-- 
2.53.0

