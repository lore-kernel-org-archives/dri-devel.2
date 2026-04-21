Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB009F327C0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF9810EBB1;
	Tue, 21 Apr 2026 08:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PXAeAshy";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CEC10EBB1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4IbPIihr/pr3DdoFe2Moqa6wO7ykGox+EFV5TId9CDPHegdIH0NeV8f7sGze/DVPDcEYOC8ip/akap8qalWB5Y1uE0IkfghdBY35wwO+rWeL1CRPPXUmnLqcT74d7S4pWGKxRovIdrGwZi1NXviu6y6gTPnN1+H+UK0wkAIOTgc3bO7kbxjtkvs9VoGCSAbrhyFqnmttTmbh6HVa/kdL9Po+hCIVux6TXY0evxcbpp/9pHSHCWQu5vOeI70XMCf/RQouFEH4BfkEmYise6ImA2F/kXbfpgxI73V4RffS9JV5Sq44Uu5AY2OwqBG65p8TE/MC8PfHNSI6Zvq3XDW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16avJtFPua2TrssEaHImBQOSCg6S+YfrNFuZRJgb264=;
 b=YQzh+72zexCocMlqa9peOu5HMEMVuzUMCUO+Rj+hsEca6e8W5ereXoRiyH8PIw73TEP3hpBUpiobe0JXWL7MLXwJN7l6yNAtxLn1jRTBDYYFawzjESp/qDZvgLj5o7JY9PGU7do7T8inOkLrSzPnGqMwBJWF+1Wr3XtvCq80JLHiAp+jgJg789vCeVBSIrS0F/mEbP+uAvoMuCY7iKczOIG1M5jePvaSWBYiMa6ouTGXQEnKbRDtKrSAukJLJlMR38ZJfwhfnx9WIPRoOjjxM0KkuflP4fepw+V5KZKe3j/CmL4X5mB4eULO8pCSwGWluGscYUOgmRoy06a/ntbfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16avJtFPua2TrssEaHImBQOSCg6S+YfrNFuZRJgb264=;
 b=PXAeAshyceXfhpa+8ZwCUnwimWywpGOex4A4QZmoCDCMBGrByU1FchkQBuvnolOA52Fl90YmBn/sVzVQMGVxLRZ+93G9Va3o/7OUxbOktGc5auhfKdGKYvx7FlIjovXyyRky+1QbV+pu+u5yKx6BEia8Cukn0fP76DjyjzY+KpX+HFnkJqgpgsuvrnX8cx2ZPzSP3HYPiNHWMwQC9EePHtfDauBg+/BNXEe2KThO1kBjUqmN+3NatZ39pRhftX/1qS6dZ27cZBHjU3JAO23QPymCcwYizCEHWzFAN5qwdVPlGXp2XHQ/xtsPGIFoivVLHbfo8+uITVigfxB4uTpSyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:21:09 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:21:09 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 21 Apr 2026 17:20:26 +0900
Subject: [PATCH v3 07/11] gpu: nova-core: vbios: keep PmuLookupTable local
 in setup_falcon_data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-fix-vbios-v3-7-8f648aef7a85@nvidia.com>
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
In-Reply-To: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0109.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f18877-8bab-48bc-0a87-08de9f7ef101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: KC0AOVCdXhsIcRhqZrB5Q4r3cljTMQ9lg1nXVWzSDwZribPYRg90/iM/AvUdM5c2tQY3mjxSVSYaiGY/io+R7grBLXUDieghvpSFjsAzDh1IM5jLtX0zZrreSQDdh/Xp3M08oae4cXgksdIXevUYA7KyPkeZ6Oc/8GCL9su4CJAX+66Lj0iziQjxtoM87a/oAHWcWOJo416jiVrxzLtaxsXKvLPi3IQBUIW3vowc8AdMVnpYq6dTAQ8ZM+2hnlaGa48kCzYUuQlyglriWrmXQVEVe44T8b4XZAvvi3LjUuHaZm5XrVfhPN5MgmhpOxzDw0aD2rR7q5jFb1CcPfZ4QoILCr/q2l6nyGS7MXGHgDGx1AURImFCs6kLgP0kef/WEjvDSxXeDfUhEKtaBqTUQ2uAOgyP6bv7GsaKDygjVMZfoDoozG3dAMAIOi7tFOl1uS+OwmmCky1TA1nZbMEpQPwrcH+0Ag1WzJnxUfA93CYiwnOwgMnalqBcqHnC8eeLIQu6pAYPDiMiLdQY+W/iObr9YhDbjCo3MlSxoXeZdOVxUW+EpRhgbKFj2y8fPGvLcmf6MUlnD3ffUXPEN0F6XXSyVWly2hk3uAHe9qoKgYyici8nx0FHNN6YZWgoZMpoJWe579ptuIQIJwicGpPWlvclZPUAjvmtkUnk+jN35GpX1AO+f3nw+zCRhsH+9HqZrBibi9Jr2tlM32s/B7Mb0FxzLRsxC55XQAr/peL+wGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0Z1dktvdjBSNHcxM3JBL0RFS2QyOFEydlZKTVJkOGd5ZFB2NlVTQ0EyeEY5?=
 =?utf-8?B?ODV2TTVaMWNpWTdWc09qMloyUzYvVjYweGJtaVBYeUFNYkx2N0FYRjhlYm5K?=
 =?utf-8?B?bUptZk1JNGtZcHN0M0U2NURXQXE5OTdnYmhOQjQ0ZHljNmJUUzM5Q2FPSi9n?=
 =?utf-8?B?ckRuVHZMbElNS0JnRXNGSXVYSnlCMzR3MlVtSEFxQWdqSCtZcllZUXVYTXRX?=
 =?utf-8?B?WXV2MUdJVWtlUlRxZlVOTFZKUFBzWkRZZURxRGFwbk5BWXlmYzArQndaVUlw?=
 =?utf-8?B?VUQrNzgxc29nS3pOYkJROXNuZkw0N0RLWWFnUWlLaGJrSEkwYlVhM2p1ZDc5?=
 =?utf-8?B?bzlKMXJLMjRsUjNkbG9yNHdHOEFLUkN0RGxiN2prbmVDRkFkZmQxWDUwT0hy?=
 =?utf-8?B?YkhJOXFMNDVBQlZ5SXVhS1pPZTBFVUNtUmFPZDlWQTZRcmQyZnhNNEg2N1Fr?=
 =?utf-8?B?K1NjWHFpblprSWZGbFI4MDZJeGQ4T1NqSTNWMzVuYkNFdmJ4TzJxWUl5dmF2?=
 =?utf-8?B?UWZUbUNnZDNndUZiSFRXcDQrb200ck9lTUR6SG5TWlJGRVVJOXhJTmVjVUxH?=
 =?utf-8?B?V2IvTDZHc1YrekFMZWdQcW8zWCtmU3FJUWIzakZEa1B0eUFqV3hRK1JrM2cr?=
 =?utf-8?B?YVhoWE5FYjNGcldnUFlQYVRRWTFMUnNpbkJWcGp5cDhqNlRLUUl2eXZVc01m?=
 =?utf-8?B?QmpHQnlTSVFUU1d4cW5zdWZEL2h0RzBZbUJQbkFuRHR5TUlKT3hrSHRWV1Zk?=
 =?utf-8?B?YTkwUUdZQnU3cU55U3F3TDQ5NzhqTkNjZ3VzMnZQS2MvSUU2cXFlMkxDaVNj?=
 =?utf-8?B?eDZ2MG5YcG1JY1VXMURnMjlCYmJrTUtEaFdvaXY2UVhOcWE3SHphWU0rUlRL?=
 =?utf-8?B?aUVTK2p4dlVRbVV1ZVEvWDBWU3g1NCtMUW9RK0x3aTJiRWc4YmNsQ3h3d0FD?=
 =?utf-8?B?WndPTFRaV2tYbjQxTFFpaDN3dC9sajlOY0RSLzBVakFuVHpBMFpJY3VMMDVC?=
 =?utf-8?B?cis5UUduT2Zpb1dGbFJaNmxhb2lJTGdNUWVEaFNwU1NKb1NSZlc0RFdrWHM1?=
 =?utf-8?B?Mlg3VG9TNmRFQU0rd0d5ZUp2TFFVTDNDTktBUDN3WUZzSWFseDdKRENONFk4?=
 =?utf-8?B?elo3S3Z1S3FjWmtpUzNSWDZXVG1lOVo5NjB1N1p6V2J2TjdaM3ZKZmc4Nm5P?=
 =?utf-8?B?NzJjTVZKc0VLdWtwTURaYTczL2ZTZDRCL2FDRUdyV0Vsa0dNdDRVMmk3WnJn?=
 =?utf-8?B?VjVneEZDNk80RlF5ajZ4OWNRT0NpZUZNcW1oVy9MMU92Nzdsd0x1V3ZSSEtp?=
 =?utf-8?B?aFpvaE85MTc0cjRVMHloMG1xUW9aNldZSG9hM042VUlxSTZEUmRQS2piRjJ2?=
 =?utf-8?B?NXpaVGlBbXRYTmdYaTIwMG0vUVRjbEx0eXh1bWxCa05zaGpnbTk3VFFEdUFX?=
 =?utf-8?B?TGMvWFJ0SmRFSndxeUhFMGJDQjdHTDhmNjZ0K1NLc2lVZXNsS2lZUGJPYXdu?=
 =?utf-8?B?Si9SamJUZldML3lIVy95NkJ4VkFMVi9aQjJZaXNkbzBSRkp4MGpFKzBkYWQ3?=
 =?utf-8?B?WURSTFlxaytHMllDdEk3TXNYWXdaTUN4OFgxNHc2VnJTb2t6KzN0TjZENElV?=
 =?utf-8?B?VGJoQTBmamlpbC8wLy9sblB5NWRMSDg0ZUZVWVBnU2lhcEFoeUJsTmtIaDlw?=
 =?utf-8?B?RmV3SkYvanZTL3Z1RnVWd0M4Q29aZWdjNHVWa3ZnVU5BdlBqR21WWm1QckJp?=
 =?utf-8?B?cmEweklZRlpGSGdCcmNvU2ZBcjArTHVFY3BaZlJVU214NEFHS3RpSXh3Z1Ey?=
 =?utf-8?B?VjVKenpvbFFYR2QvMDZZTHRBa2pJcWJLdmZFVGErVzVYbE0xOFJ2VDZNWkoz?=
 =?utf-8?B?cE92Nk5LaVBZak1ScGJoMzEyK2JTWXdhNlNKV2kvaTVSUksybHkrNXF4VUNS?=
 =?utf-8?B?dlh0ZWllcGovaTN5NzVPUmNwNjBMdldWOFFBQjgybzNUWHNSbzdCM1hyVDBm?=
 =?utf-8?B?cC9SbnNPdlN3eXRLcWJJWjBlOXVLVkpSQzIrWm90bEtyOTZJNHRTc3V0MHZh?=
 =?utf-8?B?VENYVDhoR2xUb05VdVFMbEFEQVJlK3ZMTjdvaUREMkJLMUNrVTQrRCs1N2l2?=
 =?utf-8?B?VWhVaGM2ZzhVZU1pODQ4Q2xDVC9zMDhpZDNBQXN1Z3pTaHcxdUoxY3ozM2VQ?=
 =?utf-8?B?NWZCM2hFemhYR0orMGw0dmRsaGtkZ2htSzEyUXN5dUgwVGx6NmxQNTVacTZS?=
 =?utf-8?B?V3lOWkVXaEZNZUZxTXRnZDJpNk8rYndTS0w4cUtTY3VmTzkzQlUrR3l5T3da?=
 =?utf-8?B?OE1ySWVsUDRQbnJqU1hyWk9jY0h2TjY4Mk5oa3o1NzJSbHZNZkY2NnlLNmdz?=
 =?utf-8?Q?SoRQpCLmiRPr4yOvZloZLvSfazDrNT3/Gq7a/R19aYCyA?=
X-MS-Exchange-AntiSpam-MessageData-1: JrCSEMUg99sXOA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f18877-8bab-48bc-0a87-08de9f7ef101
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:21:09.2656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifwNQXHlwio967u7FjLcdaBt5ORQjCcDZbPWu3OE821ixdocOUkj4YL0BcoXEiRQrXCB4maHZ+ANG5MiNhJNFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

This does not need to be stored in `FwSecBiosBuilder` so we can remove
it from there, and just create and use it locally in
`setup_falcon_data`.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index d63af95eb642..01f65d50cbb3 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -256,7 +256,6 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
                 Ok(BiosImageType::FwSec) => {
                     let fwsec = FwSecBiosBuilder {
                         base: image,
-                        pmu_lookup_table: None,
                         falcon_ucode_offset: None,
                     };
                     if first_fwsec_image.is_none() {
@@ -630,8 +629,6 @@ struct FwSecBiosBuilder {
     /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
     /// [`FwSecBiosImage`].
     ///
-    /// The [`PmuLookupTable`] starts at the offset of the falcon data pointer.
-    pmu_lookup_table: Option<PmuLookupTable>,
     /// The offset of the Falcon ucode.
     falcon_ucode_offset: Option<usize>,
 }
@@ -931,24 +928,14 @@ fn setup_falcon_data(
             offset -= first_fwsec.base.data.len();
         }
 
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
+        let pmu_lookup_table = PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?;
 
-        match self
-            .pmu_lookup_table
-            .as_ref()
-            .ok_or(EINVAL)?
-            .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
-        {
+        match pmu_lookup_table.find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD) {
             Ok(entry) => {
                 self.falcon_ucode_offset = Some(
                     usize::from_safe_cast(entry.data)

-- 
2.53.0

