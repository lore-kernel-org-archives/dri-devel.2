Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285C3F9D0CB
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D12910E59A;
	Tue, 14 Apr 2026 11:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="T1+cZhwj";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0C5710E5CD
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2qi4nBGbA+1RDUmOIEhQWm198C8tNvq2g9H86Ju4J7wsn9glkG/2eB13H9YNWHqY89DQnQXDQ3BIY5ubVj+zI+E5DoJ/ncUsVioxsdVDQ4YKL7AZYYkvvFXhhK0lDdr2JzRpAWzZNXPLHIO0PlRSkKj8RJMCuQlZ4SA+icYvTydr/9UEch+PXY5NL8ol/0BIJphgr4Xy7puy2lGdoHA/X2fQ1H5PlpF5KIwmOEGgo5lYgleHzi+lNzNa9DETw8gRg6o7PgKQb56j/7g+pwX1eGYZhpP4e5RrLVGZeNYvTlzJ/+NxJLW6nOTZJ0tBoVVC9xstdTpEU0IKP8w3Yn8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am9IEKN5FZ+EC6BBZRkNvmzqqsdolZmLaza7Bqphhfg=;
 b=kUvuP6xdV9BFyt/nlAwdLp5EKcFPrKZ0raSaAYs13OpwZVGscq5ZACeaDs7TOJ5F2rEW6doTpR00P0YedNkUQE4+abmCU3s0K1dJ97n6cFHRMd9o6FDytnbnfS8+/AHOC0ZIn4XGWnsphPnMD99u2bDxpvqaJJCeN4nUovnzEu2A+Q0txHFrxT7gOgRIvgaDyF025NAZyMHeUpb1ZdVcBzNQb7ShCrC+cKZSFlXhVDP/gRbzR+NrRnQYyieJUy+htxCsCi/kWAkbr4TAxadcZ0ULNUOKtsFilDa8fkQQa0zEa5RE/6jN9g9aXY30hzBUs2IDzQihO4QTX4IRv5iqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am9IEKN5FZ+EC6BBZRkNvmzqqsdolZmLaza7Bqphhfg=;
 b=T1+cZhwjSK1HvIlR26manlNlZFP/S7+129fZQb4e9omMPwkOb8CnxggSp9kYXAzWNLaix95zfjfLYpT1ux4FGHq7fKO8xHAt/kKyog6vV+tvrfuBFIBW9h+GMiUyCcGQ40oQwwYcUUr0dPyAExOrXn1vXRBs+Sa32qZvULryFMW8sTUqdrdlsdPpHSKpGnXNKsRPXfdNArYANe9eEwUF+6pSOJl5NPvn3gqOkc/fPL/4DFERJHJkuRvSVT/KUIIWg08Mf5yXoSJfIFZ5yWLmzrMxCo2otnQ4ggbxwf19ud2pHRqXjd1z4JwOUAuMnHYn3bYKGOTvMIKkXFbtaEZz+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Tue, 14 Apr
 2026 11:54:36 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:54:36 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 14 Apr 2026 20:54:08 +0900
Subject: [PATCH v2 05/11] gpu: nova-core: vbios: use checked accesses in
 `setup_falcon_data`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix-vbios-v2-5-705d30d16bba@nvidia.com>
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
X-ClientProxiedBy: DM6PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:5:18f::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 43794c76-557d-4867-d049-08de9a1c99f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: aBmt1mJaVk7qPrNaXjBKKByl2IzK9NYQrYr6M5HpXMiMArf3SmiftF4clyo9iYHKHcsPvaBnTwSENJ3agBCZJ0nR+GA3Hxffgw0tjj2fMQyR1DIYB0fugEuZn2bb9+C0RNioMALLhbJIvFV+2gX4cn9kj6O2+DiAML42pinjS6ofUPrDjJyGDdmFqkP7c4QiOuPsJdkMGRi+IielsyxIp71fMuh+chW2UmVzbOuisip/HE6+AXYaOEgLmsEoNqd5uWcRJvQw+75LKPZMaKp423rS82tWTHdgn129RO1DAAmIje7DVpdvvu42Y/spshZvbGJedSY0h7nB9Dwgtc4C9/vcXGfB8eCu9OHeft2Yse4cy2GlAaXS4fqYlBb46UOY40uPKbkjGfSV/RZSLF03wj9ftndBCu86S6NmBaXj6ICqafs4ZK4h/lvYdmShV44U2v2WKALiEHruvPdKWq89Bj3zd5V5/D2F3sGu0IZI7HCdk6d+uvouQmkdHbpP5EzHYvIh6e2v1lEoh1y1aQoR7DLGGxE8r5ZK1j1Es1y3CZD0WJiIVrszUHfPZUhh6MbO3bpBqMuHIgoC2YOnhN8UgCQuarfCFwWS2yI/0+fE2D17/rY1BiTBU7BenoPY82dEbLyAno4rd1PXFTDtOcBt1kZbVljDlU8bJm/n+NRJwNjt7ZDoYDl0rOjhui8oyDq/fzXCyJvaI6oX3qudzbJ4B52bwMIMRuM4EPGIHZCJLaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTVRUVlMU3IrSytTVzkxdkpLN2hWTHFYL3dFdWxKTjhzN1Z5NEM2R1hRR2ln?=
 =?utf-8?B?M3hpVWEyK2RUbG1pcUwwQTBNUEV6N1BTa3cxdlcwUXo0d2Z6Q3NLL3N2dGtV?=
 =?utf-8?B?YkVaMitLMUpucVJ5TUhXYzdkSGZFVkhaN0laVVdHa3hLMVpYdW15U01kZHl2?=
 =?utf-8?B?bnMvOHFxSGNweWJpMFdLQjNnckFMVGRVamFVY0tjOXlmTUVxZ2x5bkF2andH?=
 =?utf-8?B?L3pteHBsRlhTQWhwWnhwaFUvNEMvUTY0c2wxZTNLUXdEaDFvc2U3N3NWaXJz?=
 =?utf-8?B?bWZjNEl2cVQ0V09PYUpmeDZQd1dwaHFhNDlWRFpoWTQxd3Bkc1VxRE9LL1VL?=
 =?utf-8?B?b2RBTlhIb0o1UG84TmZuTC92Nlh2QVc2a1A2bDF2UVJ4eGh6dTI0eVFNWDFY?=
 =?utf-8?B?YTdDTTZ0Rm9yREpXV2RyS1NZcnVkRkxiYWpVcXliaytGYk83alhucTNrVFp0?=
 =?utf-8?B?Z3Z2VDVVWDZ3cWJDUGNOdjlrTGpuNndERC9OOHBEWU9Jdi9nb2d5STBEbTBG?=
 =?utf-8?B?cWxpNWUvMzViTTY2NWo5bCtDNGluNm15Mmk3VTZ3L2h1UXdGN3UzNzRDdXBq?=
 =?utf-8?B?cmswQjIzYlA5Mk9UZC8yR3ltdHE4aTN4N2hpT2NZdFlESGFTMjBnZnUvajNS?=
 =?utf-8?B?MzlJamM0SDRoS2RVeHV6NUo3V3ZNUlQ3aDV5VVVsV081Q2o1dmdxUGszOUJa?=
 =?utf-8?B?aFI2VVYyRkd3TEpYODFicXB0M3phVFh3L0djQklnQXdmMW5Sa1UyMmY3ejhx?=
 =?utf-8?B?bTBvSE9KRW5PTnVuQnZ3a3J2Szg5ZkZqSnNTbnFIN1RhcCt4cHBXdElVT29J?=
 =?utf-8?B?VmVBRmJadDhjaHM5U0JpanZ1OEROZWNzK0NzaEk2dGtmUG02Znc1bXFtUW5S?=
 =?utf-8?B?ZExSUDJrcENIL0N4TytNdmlXNXQ3RDRXM1ZwUkx0RktPVHpmNmU0bFFLaFpr?=
 =?utf-8?B?WkpNcFJROVkvb2NJdEFhSHJqcXpBM1VtbjBGTDhvcUg0WmQyQ1BOM3JaUGpU?=
 =?utf-8?B?S21welVYRVJSZlRPOVdCVFN6TVNoRkorWG1RSmsxL004Nk5hT1JmWHBxU2V1?=
 =?utf-8?B?aVJoT2pDVzFwMFVBejN4c0IweHlJdnZXa2Q0bkZxSDVRMTlCVXZqUXd1VWJV?=
 =?utf-8?B?bFFTZHNlaVA2OG5OSmhZRGk5eWkvUVIrSnphUExBRldmS2kxQ1lobzVGT3Fl?=
 =?utf-8?B?dkYzU0RwWXNLVmZRZkQzWGdWWm5ZYU5HSGc1ellqeFlXMjV4WGlrVWpLOUJF?=
 =?utf-8?B?dC9nV2ZGRkFnUE93QlRQaDczTW1QQ0tLcElTcnRtTzRKTmlwZCtDUEZvNklM?=
 =?utf-8?B?WUlLaUt0NXZHajNLNEx0V080R2x3bVpTTWRjYnVsYytWc1JlVTVxTjZicGpw?=
 =?utf-8?B?WmJjQlQreHZJVDJDN2Yvck5WM20zWUszNzg2Q0ladjQ3NGxFZzFicVVHOEVs?=
 =?utf-8?B?UEFjRk5YTitBcWhjaXBSdVgrcU1LNUFuRVZETTIzWUFMSURhQ0tYU1Y3U3lu?=
 =?utf-8?B?RG5kVktYd2twUnl6U0dwMG9WRlZkTVFoYWpxTGFHY2xPVVMvbzYvMFJpV0hY?=
 =?utf-8?B?TGIvZnRBdEpNWFozZll0c2JwYTFWQjJMSHdpT0RnUDFEVlVXMXZMNWFPY3Zr?=
 =?utf-8?B?Vi9xdG80SHJwdHlKZHhaOWRvWHN3TFl6czRPQkROU1M4bkwxWnVOczhCTkI1?=
 =?utf-8?B?N2FzNUFZYmVDL3N1WXAzTjVJaGU5SlVjZEFkcSsxWkMxeGNvZndNWU9RdDVX?=
 =?utf-8?B?b0NidkErUWMvc2dxK0t3ZTMwSFFKS3JkQ0tvS3NCdkIycXJBU1BlOVl6ZG1W?=
 =?utf-8?B?YWRRR0hDc2RaemFCbVhHOWdPVVRHOXFyeisySVJLZlorS0sxdjYyUDd4b3Jj?=
 =?utf-8?B?eXorV3hvT255S2Q2aVduaEd3aDBaVUFoYmVnd2JNUUlScVpVNnZnSklwVFhZ?=
 =?utf-8?B?TGp6Q2xyOFZUV1oycVNpREE5anJPcXJKS2tVZ3NkalB6VUxrNWJsUVRVUUdp?=
 =?utf-8?B?MVpLNk5FdzlqVFIyZ24vUmZCSit2clp3cU96L0JPTEdoWFc3ZTN4U1FTTk9J?=
 =?utf-8?B?STRUYlNMbG1aWFVEbHJTa3lDeVpHL0tZdnEybFB5eXhkcUsrMTZjRDExNmla?=
 =?utf-8?B?N1dQSmpaam51QWpwVHdGRmxRVW1BbTMrVmZvazZtU01Xb3RxdW9IRXZBcGNs?=
 =?utf-8?B?ZUtpbjFWWUZZYzh6YmQwWmg4VmpjMVQ4VkF6TG1rVTBVYi9LbzE1TE5tSG53?=
 =?utf-8?B?K0luZlBRR0tlLysvblZwdWRtaUJzNk5TS0E4UjJ1eGRvTDhhWGEvUjQ0U2pm?=
 =?utf-8?B?TWZTZkpXNXp3WXRqUTZXYzdKV0xDYndhNC9Oekt3d3VzblR3MmUwWEx5THFK?=
 =?utf-8?Q?Ff7Ca/4BY5F70rdQVgzxKcbG6GuSWHiEuT9fA0cdCfgfM?=
X-MS-Exchange-AntiSpam-MessageData-1: DjAjZw3EvolCSA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43794c76-557d-4867-d049-08de9a1c99f9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:54:36.7532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ko/Oncq3fLwAj0VrEd1+hoYFG0hJ6msG61xWSCILDm1dZTx4CiHh+EMQk5KnNcq2E5fCj4itakTvg2YQmY/xLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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

Use checked arithmetic for `ucode_offset` in `setup_falcon_data`. This
prevents a malformed firmware from causing a panic.

Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index bc752d135cbf..d8633e61178b 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -955,14 +955,15 @@ fn setup_falcon_data(
             .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
         {
             Ok(entry) => {
-                let mut ucode_offset = usize::from_safe_cast(entry.data);
-                ucode_offset -= pci_at_image.base.data.len();
-                if ucode_offset < first_fwsec.base.data.len() {
-                    dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
-                    return Err(EINVAL);
-                }
-                ucode_offset -= first_fwsec.base.data.len();
-                self.falcon_ucode_offset = Some(ucode_offset);
+                self.falcon_ucode_offset = Some(
+                    usize::from_safe_cast(entry.data)
+                        .checked_sub(pci_at_image.base.data.len())
+                        .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
+                        .ok_or(EINVAL)
+                        .inspect_err(|_| {
+                            dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
+                        })?,
+                );
             }
             Err(e) => {
                 dev_err!(

-- 
2.53.0

