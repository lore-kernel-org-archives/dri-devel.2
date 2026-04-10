Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36FBE99052
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B7910E1B0;
	Fri, 10 Apr 2026 08:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AC+7Qbmj";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9935110E8EF
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 08:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUC4Ig+f61cqE/TwUtI9uGBc2CKs4JBj8fJOZZnq1ZOAQTcv1rw1f5Frf1pSt6ArIvVXfNrI+Ydd+vggtcsybL+In3avkdQFhWJavRQmBxw8IqpTkenQ99xIdmcqk4A5UfW990uyJ+Iub7bnQnraYFncT60eiYZxA3Ct6ZEC38pBmPYuI1vFko0opR9/TBoANckXKsJHNWH12aTLGv2dnSbuSRdA8kSmqQex8wNKtOcJGJnRW3ERRtSp5IppwHADdij5N6gBZ2gOasGcu+b1FDQTqnNV21f3Pq+XRE/UTpPfRuGWnA7rGylQ+nuRp1jytMOKBIMdmuzjbUqkYG2/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EydaJV+AGxZ0vvE2UykCsVBFqBrsGVxSycpkXYeuumw=;
 b=bBZ+4mDc/onCT9uxoPQO3y7+FwAnqTCHvbEqwJiEqwGQ7L+iO6mwJh5WUvzxRZ6UVf06pyqxfe8/7zX+3BMoNZHHx5348hBl+p0Ndpb/HzzJVufjT4iVC8EYzIIy4MfEcAtyM13E3WMak1oip+wzis6tDj3fRgcmws+gOPnG7+BDTi8SYIPugCV8vLGGRXsL6eDkZ8bcOlWqnBLULBFgZbHdHgdwt2ViwQgtrTNTjmxBZDgvaf3RqPA5Az8moNBAOy4Gk3xR54BoaqbO7Z4Ox1l7Iwhjqaxv4jOa0AkfCyo6jG9KwfyDWPMZFw3ZI7o+rHWRznj4S/ce5uiSlwhj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EydaJV+AGxZ0vvE2UykCsVBFqBrsGVxSycpkXYeuumw=;
 b=AC+7QbmjiG6fV6XTG1d+f14OGrsWXX7j0Hi2L2h/XM9h2j8cMGDX0bDuKf10pIBhNN/PXZXTOkt3whF0DXB4Z6Ghb7s10xmcwIt+b8Mr+zDmM+/BvunezxIOdNsnZ07c5FrAdBmC5afjicjvJkPyOrs7X1azHGIlMGLoHgK3udF4U0NZXsQz8X7SUJubJDDp1qk/dcHmh0sCf5JONB1FuV+CIWMnW6cOvHxJ3scm6YkwdnQkdHQdvpIXcElxn+zvuo/cVzGRU5TqA6fbrPtTFzzca2OhDJDwvDovZimS2CrNSqyCxeMm0AKSRUluuquwXVx3Upa0KOFjm9Iw6MgJhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 08:39:22 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 08:39:22 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 10 Apr 2026 17:38:52 +0900
Subject: [PATCH 3/5] gpu: nova-core: vbios: use checked accesses in
 `setup_falcon_data`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-fix-vbios-v1-3-bc6f71d153d6@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0078.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa7a795-a66e-4912-2394-08de96dca9f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ToetGcc2fK4azCq3UEU05pUctCAP2RzMEWePQmlI0Jtfbi+603CzF3G5EHzO3jf8jlkY9/Q9bAUwnH1Q2pvsa9NQs19eMuAbSjdi8XVtfZi8QLAhyqOA5rVlhZQb7iL44daAeww+EjKXDYlHjM6Ytw+oQKsTdSS1B4lPkLRLil+J9WgGTG254QCa5ZN+mT9XDPvAtIEm+45kpQz+lTfTKFdKbRf1iZCq1dFHd++fCf3RfHYNx38YanN1jaFTgxoBlR9ZLUfkVgtaNONzplfD5dxc3RCFWIueTI5grHk56Koe1vWK/8AAU8YFtGcZLxDrwTKSchTW7hb7YNfwBcPSvyYqeVtqJuWEM8Zw6oECC9C+uW/ldnFPN8eLXJ2crzPGR3h2LoDOXwimLNbquSmbDpKJxJSv00J01ltH06rKJv1puynGv9wbRWLQVkhKwyrsaOdaRUK38QejRjPP68JIXQVFFl2JxXC298b6vL+quVdnwZol2HqZkOYGbTy76KvDqEcrkczMdY+3bjd7dbETXTvKPdDXWjKF5sIZqJlAEaUYxvxf0vQDgoT2o3/LOgdCTWIyHmXtySqbm0uT/I7pXSa55aa11NailjXbR+THnFvlLNEn28TBZZ/CJlmIyLmsSLr03iAC9jZxVTUWkR8R/9Nh1Rx7KKHFcA0CkhGEjSyoXaZkic0DtwUAOI4kn3GUTgBcEf34MMyOqwB65LKHCJPR/NRQjlCCX93h8pmVLTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWdlcGdTSkpUaTRnSDR5aGNaQUVUYmdqbVNvazYvT2V6QWtqS21GRHVnb3N3?=
 =?utf-8?B?dGJucU9PUWoyRmZ3Rkk3bW81K0liWlNNWGc5cmRuM2hjMjJPYWs1ZzdOVGVF?=
 =?utf-8?B?Yk9pem1YT1M3OUVjb2gwVzFUK0t4MmRZWGt2Zm9QT3NIeG41Z1hNbzRXOEU2?=
 =?utf-8?B?cjlJZEpNc0dzUUliaDJVNUtKMSsrc291LzZyTUF2Wk4xTHNudU5nSlk5bDVF?=
 =?utf-8?B?M2c4Sm0zWUdLa1N6Z2N6MVpEdzlTWEVveTViQ0RJVWVOd3I3bkdvT1dSdFNh?=
 =?utf-8?B?ZjBGemc0cXJXZEVVUC9VZFp5S1RXaExwNUV6TzhoZVRZZjBPRllaanJXU1ZR?=
 =?utf-8?B?VUViWm9QRDBaV0ZqOGluMTlDOTMzdnZMNHVacDBTQkkyTUFCM0lqazlzTjVB?=
 =?utf-8?B?bHcxbUVjRWw4c0t5NlhmMWV5UDUyVzlBNzBCeWV6TGp2YW1IajZkcnR6Q0lx?=
 =?utf-8?B?ZWRESXE3bDhITGxReW1RVU1ndjB3MVZVcExxbkVVcktNRDFwaTB4YTlud1RM?=
 =?utf-8?B?ZFhnd1hVV2pWYjNwV2hUUmhKb09lV2IxcFN6bWc3TmdlanVhby82RFVVZUtS?=
 =?utf-8?B?TVlQaGdyMXBJUDE1S1lyM09mc1k4YjA4YjRQTzN2dVRoaHJ5akpwQVAreXls?=
 =?utf-8?B?R0ZoeU90MkhqcUhNazM3cDB2Q0ZObU1TNHg4RW0zZkpFcEZyZGdsNzQ4eVox?=
 =?utf-8?B?UGxSV1haRjZSeER4d3BMZ094OEk0OXBjVzVqS1BMZjFFek4xRnQvUTFUTXk0?=
 =?utf-8?B?cXNRVXFTa29YcEZTLzBmZnJzbWE2dlZHSnpuVGQ5R1E1bHNpak4xZTBhSGI2?=
 =?utf-8?B?T3JXVFN5RVh0NlpXNkNDOUEvT0dPKzlKU0UrZjNPMERnSzRFcmo5T3Z3SlM4?=
 =?utf-8?B?SzhDQXJUM1lVQldjNUFXMHBoc21qS1prT1FjNU9lNFFOeHVtSnJ0dFJub0V2?=
 =?utf-8?B?Y3M0R0gwOFhEQmYrcjJmLzdTN01LMzExbUZ1OVB0d1ZGWldLZHpQT2FyN1VU?=
 =?utf-8?B?cFBJT1VVMkpTekhiMDVzaWNuR0Rra1pSTStCdlVhRnNFRGc0elV4WitnTVd3?=
 =?utf-8?B?OXZsVjJVODFHK2trTmhQNHlRMFBHb0FrKytHQnBwTUlaRW0vWmJEaFgyaFUy?=
 =?utf-8?B?aHpvZytJYUpKR09BdzBwQytkZGExU1pZWFM3MWFCbzRMbERVWXd0RmZRcC9p?=
 =?utf-8?B?SEFCdWdPSlJWVytEMjF0UWRLTllidmF5cmRuektsekZoOGJRMlpUUWJocHgw?=
 =?utf-8?B?RWhxUk9zejVMWHphS3RDSGwxMjArVWZ4ZTJPSjE3NGkrZFluWXJVQUNmSkcx?=
 =?utf-8?B?VmVpeFRwWWxpeXFMbFVLVEc3cHVoUzVwWmNFckxGbFMrZVZXWkljRVkxTmVY?=
 =?utf-8?B?MDJuUlF2dnllbkpRem1nTFg2RzNKNjNUQUdiUkdoWllybUhlV3hOVE1nSjEv?=
 =?utf-8?B?Uk1QallxcmN2UEt5QXJFREZqckJ5cVUrMDYvOU5zeEdBQnRhMGREZWhHT3kr?=
 =?utf-8?B?SjFJbHBFcVNNdTNDbFdvbGliY203dnZkMEVoWXdyQ2xxOHBjVHFuM2VINktM?=
 =?utf-8?B?YXVqTmpPRlJzaU1xbW5scjNqVTA4VFdNMmNQd0RQWU1rTHRydDhXMWZaVFVE?=
 =?utf-8?B?YWQyeTdYQ3I2WWFLWHhFWEh2MGJROUgxbUR1TXhTN2JwRFcvL1pEd211b1h4?=
 =?utf-8?B?QWNjUU1PVUh3RTNHa1VMeVpkTHlIY2NMMHVtRnB0TjcwK29DaXU1OVFGV2pI?=
 =?utf-8?B?a1lVNGRCa0pmanpnNWp3b1pudmVscDZHbjZPekhBVktKRDdIREpQWVZYSy9q?=
 =?utf-8?B?eUo5c010TUdlRUpSRWtQelJITHBTUkNwcUxJOU1LRXVlVnEwYlh4dUJpWjdm?=
 =?utf-8?B?WS9IWWZja2w0VXM2N1RJV3NHZHUvaytGQW12QmZUQ1FRRFFuTktkYnl3RjlP?=
 =?utf-8?B?WkFZa2svbldwbGQwMlVObmNYWHhKT2NWSWFHY1FTT2RvbjB4UXMxc1NKNnEw?=
 =?utf-8?B?ZDlHNUlQcHJVTzN5dDZRRCtLVnEzd2pQTStpbnpzaDN6RHJWOCt5NmdqT28y?=
 =?utf-8?B?blFrdmZKcWdYUHk1QnBxZVR4MFVYSTNrRkFkQUJXWEtwaDkxL2RjenhFNWZt?=
 =?utf-8?B?RTNUZS95TGlRSWdCbWllNWNCZjRpY0dvcTFXYmNlQ1RpRWZhVFJPdUdyeHZw?=
 =?utf-8?B?bFplQmYyZEkreWVuTWxuekdtZ2FIcjdnelpVSW5OY2RHeFBaa0o4M3plTEht?=
 =?utf-8?B?MlRDRys5dUhMK2Q2Q3pmTy9BWjZncEZRYXVaUDNxTEhOcm05VmIrVHh5akNm?=
 =?utf-8?B?UEZpaER6aVlMV2NLeHZWUlJES1FKVGFaVEdFMFk0VXdWTE1HMDY5bkZuYkYv?=
 =?utf-8?Q?mek+3xOzrYC1+HpZWxP4ZfzpDQxu6fhQ2bBnLcy0cxSct?=
X-MS-Exchange-AntiSpam-MessageData-1: FNwtSu+fyKylZg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa7a795-a66e-4912-2394-08de96dca9f5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:39:22.2520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YUM9m6MJFAPTkwPSQGsJHcNMXIhurVpi/kgfEWjUh8OA2QxAMti+gB35uskQ9Tg4Z02vBV5uuAY6W16nFQQXQ==
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

Use checked arithmetic and accesses where the values are firmware
derived to prevent potential overflow.

Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index de856000de23..2b0dc1a9125d 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -936,17 +936,12 @@ fn setup_falcon_data(
 
         self.falcon_data_offset = Some(offset);
 
-        if pmu_in_first_fwsec {
-            self.pmu_lookup_table = Some(PmuLookupTable::new(
-                &self.base.dev,
-                &first_fwsec.base.data[offset..],
-            )?);
+        let pmu_lookup_data = if pmu_in_first_fwsec {
+            &first_fwsec.base.data[offset..]
         } else {
-            self.pmu_lookup_table = Some(PmuLookupTable::new(
-                &self.base.dev,
-                &self.base.data[offset..],
-            )?);
-        }
+            self.base.data.get(offset..).ok_or(EINVAL)?
+        };
+        self.pmu_lookup_table = Some(PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?);
 
         match self
             .pmu_lookup_table
@@ -955,8 +950,9 @@ fn setup_falcon_data(
             .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
         {
             Ok(entry) => {
-                let mut ucode_offset = usize::from_safe_cast(entry.data);
-                ucode_offset -= pci_at_image.base.data.len();
+                let mut ucode_offset = usize::from_safe_cast(entry.data)
+                    .checked_sub(pci_at_image.base.data.len())
+                    .ok_or(EINVAL)?;
                 if ucode_offset < first_fwsec.base.data.len() {
                     dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
                     return Err(EINVAL);

-- 
2.53.0

