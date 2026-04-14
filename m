Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B13F9D0C9
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A8F10E5D9;
	Tue, 14 Apr 2026 11:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aStJKqvA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1982810E5D9
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=na5i/bGBbYDzMRrdHYCieDINsomg3y1e34dF7bPMcKOs4xO5mjKaMi+wuQEfs8TBEOZ2wkOUvfR3bFGW460iq4+oN19g/FlisP+LLCDXoXnaKBOnX/Dg11sBTU+vxXe81Ir6fBWfbrA17ttakx7Ytu7oxerKZdCDIkWuyoRdaThJ+HVf27SLunZB4T6jmR4n99JlS15pfTZgdJ8DwhRy72QiOSWUWgx2b2gwFHsWaQFx03Y5NJIIUPMoK4OE2a/S6zdOaO+Oxihccg74nIuizl+GRlUsjCO5/EBF0DUbKHusialyCMT0FANizPZ3Sh5q3+sU3uPJu7wYnfwz/8kgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFX5aT0TtBGvw0UctHAvSk5kl90yZs43duVvZjoSx5o=;
 b=WR7cgUb4kkid7YIBQ7r8zImCosK+naPSd+Vj3t6ZDwSnRAuyM/qF2qumLcst+WEeMKZGWI5Tyi3LhvhDyu8q/C8/hwSuiyLS7XKpYILfnbmczlwOS5jI0J1jh41+eiFaejNczALQesFWHHP3dJrWWHjxrq8ieCVmfAL6C3Ukdu4vIZ9ZwlUNOruQdlxDHibR8iyzqjHsRqPmwzYxpskK9iAe6F7lHC1/rkhGyN+N6o3N+E0JSDR8D9rpgqsBhBs09520LaIiwasCqArRrFluNp+6bC3B3VAuW2lXvSS/89SBfEfrtN0RS34oYibzcpebDu35O6jBj+Cs+CsBxSXrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFX5aT0TtBGvw0UctHAvSk5kl90yZs43duVvZjoSx5o=;
 b=aStJKqvAT3p+Qlbn56AfjxO53qxiMtQgzQ7X6RBVwJXD7DQ6ky0ADd6Pq8J3TYta4sGj6NF5UgxRWtlxA8Y0oeOk8ulXtgTXgYMoZv9R9BIf+OyIFszPxtPeskf6Jq0xKs/1gEQb2142RDYozan3Dm9pU8ayKNl4jR+Jo36WP5Rk0WYjW8DgHO+fiWfWlFd8xJwkUB0N+d2Bjui7+bQov/9eggkZscWyDi/aA8dTkGlDUZ8clrxAuQrntb7caWmOx//3/GV5W67LMGKihIidYHlKJlhCrGQOsLcfu52XXm85Qj4bRJgeQzg1+hFIxXPzD8ezXUQwI3n8sCuiEznunQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Tue, 14 Apr
 2026 11:55:00 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:55:00 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 14 Apr 2026 20:54:14 +0900
Subject: [PATCH v2 11/11] gpu: nova-core: vbios: reject extra PCI-AT and
 FWSEC images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix-vbios-v2-11-705d30d16bba@nvidia.com>
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TY4P286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: b42a1184-49bc-4e1d-824c-08de9a1ca7e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yPohLTOYI4/uUewynA3k6OEAWyRFLhR8T8UwQ+JZPFZt0dmbfBukay3xQaLA/TITSRKTQn1TVIw6yclCRhHKjhdqU+jXSQw/gvQVOcB+MyDOw+uryjDJWf/k8ES0xa7vkaoxS1BdkcAs8xdLk+d8aXdEPjCKENo7RLs2h+ZwFuTrKIW5DuOTeyB8HCOkA0yD8PGIlP3Gwf+hm1ArsIfqADZ3QyAg5fDR9nL0f610lgHsNDPrlvCDcJWeI8l5M354UutN/sT8vCNWUM2KXxEjYHaWVEoxMK5bFLrD13ZUE9i4EXw9DuyHo+Uba4YFaGiwvv0Vfy2XAnjrmM8CVol9i2elr+FM3G9cKhYuChn6vZrfUJKXslbjmrHtVK99EYeeW3xe410Td1dT5hn0YsjRJNW3sHukILCakL4mFgnKZVYqxq0tN+XcCVdNpGDsgaH8iNzxIlJSEry4clKYX5OpqouutFTxpgcOlROg4zSb7NN8e2rjp+++FwkC+y2EdXotMdR1om4rdaH585T4bK9vq9mMtR07oNsofXY4G4SlMJSqT2X2Ol6gl5PwmDFuishFHGhCLJFOGNc4Z3lvytgDIJFjkqZH8cnmQHrRVtRKzhg2iJ1MrQtTebitjmtW0QUlKAS1jBakmO9HkoqlhVPtCBYIONmr6HyFzJFR6w2PQR1BMognwG31nCOL74moq2oNM2QvxRO6eD0l0QhLVvoigeP6ZCs0fj2QhVp1gEYP96M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckhVUnVFWE1sZzk5czZhOUNkSUVMR3Z1MlF3aEtmNnBIbW9XTWMyMXZucGo3?=
 =?utf-8?B?V1BiRkVRdFdaVFNsYVhodnhrcC81S3pheVBWVFhCeW95NTI5Q2NzcnovTllB?=
 =?utf-8?B?UUhyRk9NemdxL2V5N0lRMWhYQjZpazJ1R282cjJZQUMzeElieHc1Y2Z5U2hp?=
 =?utf-8?B?NzhyTFVpOGRRcWVaK3hGanJ5SmJVaTFiMWtreUExZG5Gd0R4ZnpNQXo4RlRT?=
 =?utf-8?B?WldYZXpEMHQ3dS91UTlPdVI0RFlRc2tNVmZ0Q0Y0bTJUb0g5cnNqT3VQeERv?=
 =?utf-8?B?dUQrSTRZQmxRcUp4MU14MHhFVk15RUZQMDFpRmROM2h4ZnV2RmpQKzBjekJP?=
 =?utf-8?B?RnpGYTFRQ0k5OXdXQnBKeGtwdE5zNTM2YWk5bUd6Skh0NDFDckhGbGFDSWNI?=
 =?utf-8?B?VnJhS1NTNVB3UlZjTnF2ZkRMRSt4Tk1GMkd3cytUd0ttY25abXNMN3ROVFZa?=
 =?utf-8?B?Z2U5QkdjbGxmbTM5M0lxaEVQK1NBd3h6ZE9ieWE1TEZ3RE5oeDVjajlVQzM2?=
 =?utf-8?B?akpSOURNcEpYWWdKTkF4Q0VBeDA5cjhVc2pRendIS0NDQnczNFR2RXlzeHV2?=
 =?utf-8?B?NGpRQUY5RENUVm0vc1JXSmpYT0d6UmhjclZocSt4UmJYZ0NQS1BBUzdGUmF3?=
 =?utf-8?B?UXNzVk1sY1NPQ3kvZkt5WmhHTmwyWGVGb1cydlEva2srbmlrMXdEU1E4ckJD?=
 =?utf-8?B?em51S1dNMFRoZWgzVWdDU1lKT010aHM5cHNnUkg5bldXNXB0cUlOUURya2Z5?=
 =?utf-8?B?OUpPUWM5VUlqWlZqOGNLY1JMRXhkUUpvbWh3WGEzL0VTeGlRa3I4NjRxS0ZF?=
 =?utf-8?B?VlpQSSttSWlvcEwzMzB1ZmFBeHZWQUgzeFdVWFkvVFhzUGxoODFUTE5UM0Vh?=
 =?utf-8?B?RnFqSlRTUjh2Y1lsclpMelgyMktTalNnN1RQcCtDRGVUZ3piSUhMdXp2OXhu?=
 =?utf-8?B?S2wzcWl2MmR0bFdlZjlOS0RrbW9YSDlpNGxPbEJEaFd6bkEzaHQvcTRzY09v?=
 =?utf-8?B?TmpqcjZqWU5NenE5alVQM2hNTHpqM3EyZmwrZ1NvNFNLZmVaVXZ6ZGtkbzQ2?=
 =?utf-8?B?L01SQmQzbmthQkI4Wm53WDFmTjBOUEMyNS96SWx2UXJoMndCcWVUTXNYaDNo?=
 =?utf-8?B?T0Exdk9DWWlXYVJxWGlKeUJia0ltU2lGSTRWRElCdTZ0L1o2QmdzbTk1QlNH?=
 =?utf-8?B?clRmb2ozYmg2dVlhL2dMYWNIZXdJeEJxRzZYb2FnZlJKcExGNVJsVnlBTHMy?=
 =?utf-8?B?TFY0OFhmMFFCek5HbnlSdFB5aXdmY2ZIb1FxL3BKZzV1WHY0NWVRZzZoOCs1?=
 =?utf-8?B?V3VuYVpkb0NTcFIyb0xlRmp4b3lYWTRZMEw2ZnhZbkwwNjlsM2NaZVFhaHBt?=
 =?utf-8?B?Mkx0UEFWRmtsRStZL3F5VjZoVnlNOFRDRHRNQ0RmUVM4S3BUYWNCNXRiSzFZ?=
 =?utf-8?B?QkpTMmpZNXVBQndSV29YVjRlcHZnR3RnNVIzUGdPMnhNZVBDanlmUUJZa2lW?=
 =?utf-8?B?RElza3hMNTg2WUVCUHdnWWFRZC8vQTZpWkdzcW5LUEpsOExzTzBkdU52T2NH?=
 =?utf-8?B?RGJObWJKaHlYdkUxRGNKWUVxYmdnanM1UDB3ZjBNRTlxWUIvbkNySHVoa1BM?=
 =?utf-8?B?YkxMcXBPa2xNdVkzdnI5YXdDUkRkei9BZXlGM0x2MlFXV3pkWWJ5VkM1Tndz?=
 =?utf-8?B?Q21iN0FQSzNuOEdzWCt4RWtxV3YrZkVCRXZvS3E4M3dNVTlyeWJVUTk2V29Q?=
 =?utf-8?B?OGVzN01ZOG1TWGREcTRNYWV2SEx2bDVSeEltZ0hubGVtUVllSVFaUE4vWkxi?=
 =?utf-8?B?ZFVXbk10dnZZZUh4YTJHbDhSdU5zeFBZVld4MUtobGFzZXd5aVFXSm4vUFBZ?=
 =?utf-8?B?WVZVaExaZHRBQUpoVkZtMUtGUGtoUFNIaE1Td0h0MS9qR2pPL0pJaFdSOU12?=
 =?utf-8?B?cEdXd0psRTNxZWtKd1VveU1waGwrN2ZvbkU4VlE3djdHY3JKQ2hkZUlqRjFT?=
 =?utf-8?B?SCtuZWdNdUtUSU5ka0JuM2tNbHNMR0VocXZvWHI2NWFsbVJZcEIrM3hrUDlU?=
 =?utf-8?B?WWFGUjBDQS9BS3ZLNHYyZ0lETTN4Skt6alJvUHdLajJZajFsZTZoZU9HK04r?=
 =?utf-8?B?MjVKVjgzRTZNbUJOTUdGSzVjWFM0eFpXeEdkcmFFbUIwVGh1V1VHYkM0eC9N?=
 =?utf-8?B?RXg4ckcvcHErdHlVRFhxUUViSmY0NW01VlpveTZLYUNWOFJMZTI3ejE3VlVR?=
 =?utf-8?B?SnIrd2swSVl5K3gyNzdjSjg0YkVEdnFLVkJQbmdpOTZHYXFsRE9XOTdSNi95?=
 =?utf-8?B?cTRzNXZocDlrSGdEVDF4RDduWUtXNXBnalpXdVB0K3BINUpoN3BlLy96OXl3?=
 =?utf-8?Q?OL0/lqAB5bI2xqb2csOThm3Eh/o/+Brlr8NrupkPWlmYq?=
X-MS-Exchange-AntiSpam-MessageData-1: wPLt8gAc1HDGzQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42a1184-49bc-4e1d-824c-08de9a1ca7e3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:55:00.2170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrO7C+OgcEa2qXrzzZ3ThOwWqInKysX8PYQi1lK6QqRfuMDSAGBh6N7JQ18fipIsAivox1a/LPItWGLCjKcPww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
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

Currently, these are silently overwritten. Instead, error if they appear
twice in the VBIOS.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 5cc251c73800..a9294b68ea77 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -251,13 +251,20 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
             // Convert to a specific image type
             match BiosImageType::try_from(image.pcir.code_type) {
                 Ok(BiosImageType::PciAt) => {
+                    if pci_at_image.is_some() {
+                        dev_err!(dev, "More than 1 PCI-AT image found\n");
+                        return Err(EINVAL);
+                    }
                     pci_at_image = Some(PciAtBiosImage::try_from(image)?);
                 }
                 Ok(BiosImageType::FwSec) => {
                     if first_fwsec_image.is_none() {
                         first_fwsec_image = Some(image);
-                    } else {
+                    } else if second_fwsec_image.is_none() {
                         second_fwsec_image = Some(image);
+                    } else {
+                        dev_err!(dev, "More than 2 FwSec images found\n");
+                        return Err(EINVAL);
                     }
                 }
                 _ => {

-- 
2.53.0

