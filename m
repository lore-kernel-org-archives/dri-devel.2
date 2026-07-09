Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AA9C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8238510F3BC;
	Thu,  9 Jul 2026 06:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="W/KEi6b1";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6454A10F3BC
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtMppX2hmobav9S5c0toHZGGxshPOZcHrqKflSmS0+9Mh2+tqcUziCQ/pAeo94Enz7qKoiZ7At+bfew43TQQbY1JnWDrncQ8fagVu/Ryycz2lAhbQiQ+hoEWejyaAfdIsJzdxaYOOJZ8Izl3fEyDim6/N6EKr5jrnXAV2WS+r7hqIkDAZ6jzyJB8jv7/k7Wtbyi9+LVTD7i+c1eTNVcxzkfyfP4+6W22jg+qUaxZUqW5cPSTABdM4vC33v5A6q7MIpFvtGsVrFWfBtnmYsTafjyvPmburvIEkr2WLx22S6EXIeg22BR6xmKzvn++3uvl3y3F4MeFYogstFbQxr8v5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUOhJzbcsxg6i72Nr0Zx0FycWGG8xqDOcIorTsre5ek=;
 b=T1oFvlD18sskNMYSFUOc7kgtjfnFCBYzuTCOPDxAb36cT6CUg+VTF+B58RijPigpex/ULLUkuHkmR3ZMrw1k6KUanoCPQg5MoqVNTBmSENzaICx9n1P9ivMg8RAC4jYcc2rYNfK3XBiwBU7wJ4Dh3ujhZcfzu8f95e7N8bG+rmsbjpUjUyGL84LhCLMUICoXQg3r4dsaTlVep3Pq6aqEliSYlypKBkRjQN9en0XY8t8/A/CjLXVFuQAJ1h58R/KD59pOo93mSeoQzqXBCWMIWR2lSUdLuD4n9Dk9YIZKVa0nxLLb6Aud6Sr2v958YlDtLIMP8FM/Ghhc9++P+AwxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUOhJzbcsxg6i72Nr0Zx0FycWGG8xqDOcIorTsre5ek=;
 b=W/KEi6b1Uexrm7KAnCwJPPTzgNM0838hg6XfOGkCb1DAxhkCmx175n/yEh1UN7IFQTre25duJWEi5YDybt+5sgSpIWesbF7D6M1VXlYDS/F2Y3TMDlaR4Zg4B7BdhnuDVUWfMQZTaDSw2yz8gV0fnzgtYj1kF5B3Oa9Evp39stfCeT3kqmbDM86ctzL7fvEwlBqWevA179n8hqukbDeqhZRDZC4GNcwtyx8Zti2sHUHd3uDgrCNihRafgCOTDm8bNewSeGR/wL3lDvOKD/mh+D3nCdAxJ2Lnl6ZTGGCRih4pxY0GAh25f2Zuegv0tscM2ntK1jsfAIcxalf16cuL5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:56:45 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:56:45 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Jul 2026 15:52:56 +0900
Subject: [PATCH v6 03/13] gpu: nova-core: gsp: replace BootUnloadGuard with
 local handlers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nova-bootcontext-v6-3-520cbf8b9b50@nvidia.com>
References: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
In-Reply-To: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0293.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::11) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9c1756-72ea-4cd5-ec3d-08dedd873d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|6133799003|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KBXBa8+g8FbbOU04642LgMXvLFmJfGl/7UPpnLxYaDTyPHl2hU/8TLLsd5BlS0IQgu424fhZvlc80iPMk8vgKb+vWVyQIUi9r8hl87CdzcY5UMo8X1t4huqlsYH5B+eysxL3WXGli79Xit40GxDbwJaCOJpF33EE1bxYbVBbrlYR+SpB294pWlbQjQ9Y0EzfzyphHv2kleMz4AThc7t6+nkaPQ33ns6LySTC9wkZB/Bl21LG9+juo7Sv9Mr/Ixdmd6wFAn2Zqw7es1Zz8/zsONjNfe7XiPRpH23pqfo/uLnsmTT925vpGmpS9zyKMrTVcY2IgvAzMwBKWfhGsodz++1kRzRS3c7u+mUNR5WNKJ1h8+RT8A5zB1rXaA58HO5MTxe8KWR1gibdskkqV4d1OBDBkn/Hh0vlAuSRN59ZXb8hkuHMCychR6iIzIPr4Tp+Q7yxkCTYWJ4jPqPn+4UB6dzJrYtOG8nHvuRs3lxMUOCDTn6MuP5kQw73jenpyErrnwHNoU3uyyioy6NkioTRVf43S5otHzhbSWWkQ2bhKceJiaq8eWxOEHwArpLVDFdfr7mWMVlBBiN3r2lexzP/GwpyDeECXqGtL49OJrzloQCm0p72zzlCBWRr4h5VbsosAFwR16j+9uQvY39IzHx/HD7Qp/zm5zj1a2Vlli9l5sBLM1RkGbznC3aW0vTEdQsAI7VjUrnj/HlXiv4liE8ptg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(6133799003)(11063799006)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlNJejJlNmhETnhyNzV0aUlSN1dRb2dyRUpHZ2dwWXJ1ZHYzNWxRb21qb3Zx?=
 =?utf-8?B?VjFxMjVHZjExakVHQlVoeXFFQmdiL0hzOXZiWFpXREcrdGVGUmJrU05qaG5j?=
 =?utf-8?B?dE45RytVSWUvNlE2VWxIUFkxcDdhRWVJUFVrNnVFUDR4K2dhOGlrU3d2Y0pt?=
 =?utf-8?B?WENDVStPRnlYZnR2c0xMSmV5YkxJZEtVRWlTMlFLekdyc2E3bHZoZklOaUJn?=
 =?utf-8?B?ZVA3S2s2bVp5M1dqaSt6ZzZCWUxLdGZ2Q0JGZDBpc0hjaXpoUEd6bmY0bi9P?=
 =?utf-8?B?TzZRSVVhTkx6NUozT3JTelozN1VjWmlhdUlTbzFsbDJ1ZXN6dmpGYXZNKzVy?=
 =?utf-8?B?ckZTa3l0ZU1ORnRyTXdNbmpwbk00SGNUeFJId0U5TzlOOFJxb0EvSjkwaG9o?=
 =?utf-8?B?Q0FDNTkwb0hWdjVEUnFneksyc3NYQ1BmZUdYTHd2NzhCR0pjQ1pDL1NhVGR0?=
 =?utf-8?B?WlZTcU9ZZE9jaU14bmJxRVZSRFBoSkZQckxIQk1xRGZ4UHJBeWs3VVpTRDI1?=
 =?utf-8?B?RkpCcDhUaVFMWEpEQTVRUGhPUVJ5MGhJVGM2djJxSUZDN0dDY1BmVXNzR25D?=
 =?utf-8?B?c3ljSjA2eWJsY2hJd0xkTjBZVTVMZThBTzlZajhVWDBOV3FxOWhnUXJTQjgw?=
 =?utf-8?B?TDVMZkN0RjVPaE5hL0d0bEVqYzdNamdtNXUwTGR4QnFLdDBSUDVWUzdURDNB?=
 =?utf-8?B?ZjF6YWpoZlRIZGJkSWppQUJNL2NrY2ZWMVAwa0Q4WFpta01vblNKWDE4SHU3?=
 =?utf-8?B?eEU2MjdBZUkycEhkTjRPSDZrM2VXZVhBajF0VC9yN1RGbVNROVRlQjBhcU9y?=
 =?utf-8?B?L1Zwc3hPZW1kWnVkWUtDVnBXVFB1VXhmZjhBTFY0UmxWQjVJOHVTRlMrMjVF?=
 =?utf-8?B?U0VScnJHOXdkNTRkbGQzWEZacURPWk8waGxtczgwdmNONDd3Qkk2YkluUnBI?=
 =?utf-8?B?Z1BSbmhoS0JURVFPUTIxVVdiOC9PVlNxQkZ5TFJtN3AxalFmUGFVdkQ3NFN1?=
 =?utf-8?B?OWpvendnUHlDTUVUdkpRYi9DbTV2d1FOSmpwRnFYUnBVanRzYTJZakRnR0RD?=
 =?utf-8?B?dWEzQ2Q2U1BFOGxabURmRHpDeXRWT3ZwMGRRUmpvd0RRRE9ZQXN6ejNYcVJD?=
 =?utf-8?B?T1ZXaTVNOVNOdlNGQ09ZVTdIclgyNlkxbTAwdk5pSmpCZDFBU1kvVGs1SW1D?=
 =?utf-8?B?M3k1eFlCaVc3L3pjdHlsNWlXN0lQTkZnaVRlaE1WUzdyMnV0YXdROWtianRR?=
 =?utf-8?B?TWlud1IzNE1meTNwb2s5bjBMeVA1aW1LczRnT2dXR2puWHNPOTMyWk1NVGdz?=
 =?utf-8?B?UVczbHpBMEFvZDJGdmNkZWxCcFgvWm1aNWNUZXZVVCtldjQ1S0dyRUIyMHJV?=
 =?utf-8?B?M0pWRW5uWERDY3BZSWdTME5PMElQMmF1ZHY3Ry8yR3h6eVhRQ1JDQjdvN3dx?=
 =?utf-8?B?NlEyVC83UzNibDgzV1E0Qy83UEp0MG11WVR6aWt4eW5WMUNtNzEzTXkyWkhC?=
 =?utf-8?B?dk9QSDlzb242MHAxYzZzczliRFYxalVKSnphNFp4MlhmM001TU5aRUxOOEdp?=
 =?utf-8?B?NUJTcTU5MUJ4M1NCMlVxT1hZT2JLeDJadGdZT1grb3VhbzU3WjFNVEh0bTVj?=
 =?utf-8?B?MkN3ZGRHcXYvUmxjUEtKdzhXMFhUM3JZQ25iSUFDcmNHRk5XdjRZWEJHaVlS?=
 =?utf-8?B?cVhuQ29sQXRVVVZKeGVodVd1RHJKc2FHUWlla282c3pHODZBamlFdGw3MWVX?=
 =?utf-8?B?UHFBaGMzdG5HSWx4QlNacDc5ejRMQjRJbjZJZEEyRWtLcmxuL002OENJZS96?=
 =?utf-8?B?WjJ0KzhJT2U2OEdybHZiZUR1K1FWSWRwYS9YY1ZQZGNkWmFoWFJ1UEI5eDQ0?=
 =?utf-8?B?OEtNeWx6MU5Ubi8ydzR0R3FaWUtrRWc4VjF1VFdPVFhBR24veTh0ZGJDWmtV?=
 =?utf-8?B?NTloOG0wTytBbktwcWJXVERQdnZidWFTNTBHTmpxQnBUWlRDSitmWjNlK0F0?=
 =?utf-8?B?LzNSbUFtN25HRmZLbnR1a2puQ1VzdmUyWkhnYnQrektML0s0eDlPSStGcDlk?=
 =?utf-8?B?WGovN21ZTjNnenY2Yk1xdWk0TGdvWEZScU1KZS9lZzVNd3FKVEJXM1crNXBF?=
 =?utf-8?B?Rnp4enlsbmo0MEtjSW4ycFY3cUVjUFppZCt2bTJLME5rRlpHdm8xaUJScnk2?=
 =?utf-8?B?MTIyZWtCQXBTKzBUOXAvbUJlKzEvWkF6ZlVqR2Q4bmFmMnhFVkpZQlBnd1FW?=
 =?utf-8?B?b0NLYnN1a0VlQ2xTdDBFbHpRMGEwc3NaNEU2bHRtVVBtcGI2bEx3bXhjRFBV?=
 =?utf-8?B?b1kyeE5RTXZ1Ly9FOEt5Y3dNU1J5aTNoOCt0bTB0UnVGSmw3Yklyc0I0OXZI?=
 =?utf-8?Q?lrMI/St9Wv0oOCOHRG/caiWtW1bcCqieaN1obBQmxrSIW?=
X-MS-Exchange-AntiSpam-MessageData-1: 6MCLtSqqFQWd1w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9c1756-72ea-4cd5-ec3d-08dedd873d16
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:56:45.3150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: td1dqRpUUSMzhOrBS1ZWlzGkokN2Gr8KU25h+e0TE8C0bqvXi2d/+3IqoSOyn74deryt36yYAOHRWG7iYy9O6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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

When adding the GSP unload capability, we introduced `BootUnloadGuard`
to automatically call `Gsp::unload` whenever an error occurred during
the boot process, in order to try to reset the GSP to a valid state.

This approach is not well-suited to the errors that may occur in HALs:
by definition, an error occurring in the HAL means that the GSP is not
booted; yet the first thing that `Gsp::unload` does is queue a shutdown
message to the GSP, which will inevitably result in a timeout when done
from a HAL.

Furthermore, `BootUnloadGuard` is problematic because it holds
additional references to the boot context, notably the `Falcon`s. These
extra references stand in the way of making some of the `Falcon`'s
methods mutable, since those methods would require exclusive access. As
this behavior is only needed in one place, introducing dedicated types
for it is distracting and unnecessary.

Thus, remove `BootUnloadGuard` and adopt a two-level error handling
strategy:

- HALs are free to handle their errors as they see fit (most likely, by
  running their unload bundle if it is ready by the time of the error),
- `Gsp::boot` uses a `ScopeGuard` that runs `Gsp::unload`, since the
  GSP should be up and running by the time `GspHal::boot` has returned.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 67 +++-------------------------------
 drivers/gpu/nova-core/gsp/hal.rs       | 13 +++----
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 27 ++++++++------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 +++++++-----
 4 files changed, 41 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 152093aafae6..f62079709b6f 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -30,66 +30,6 @@
     },
 };
 
-/// Arguments required to call [`Gsp::unload`](super::Gsp::unload).
-///
-/// Stored as their own type to avoid repeating a long and tedious list in [`BootUnloadGuard`].
-pub(super) struct BootUnloadArgs<'a> {
-    gsp: &'a super::Gsp,
-    dev: &'a device::Device<device::Bound>,
-    bar: Bar0<'a>,
-    gsp_falcon: &'a Falcon<'a, Gsp>,
-    sec2_falcon: &'a Falcon<'a, Sec2>,
-    unload_bundle: Option<super::UnloadBundle>,
-}
-
-/// Guard that calls [`Gsp::unload`](super::Gsp::unload) with a
-/// [`UnloadBundle`](super::UnloadBundle) when dropped.
-///
-/// Used to ensure the `UnloadBundle` is run during failure paths.
-pub(super) struct BootUnloadGuard<'a> {
-    guard: ScopeGuard<BootUnloadArgs<'a>, fn(BootUnloadArgs<'a>)>,
-}
-
-impl<'a> BootUnloadGuard<'a> {
-    /// Wraps `unload_bundle` into a guard that executes it when dropped.
-    pub(super) fn new(
-        gsp: &'a super::Gsp,
-        dev: &'a device::Device<device::Bound>,
-        bar: Bar0<'a>,
-        gsp_falcon: &'a Falcon<'a, Gsp>,
-        sec2_falcon: &'a Falcon<'a, Sec2>,
-        unload_bundle: Option<super::UnloadBundle>,
-    ) -> Self {
-        Self {
-            guard: ScopeGuard::new_with_data(
-                BootUnloadArgs {
-                    gsp,
-                    dev,
-                    bar,
-                    gsp_falcon,
-                    sec2_falcon,
-                    unload_bundle,
-                },
-                |args| {
-                    let _ = super::Gsp::unload(
-                        args.gsp,
-                        args.dev,
-                        args.bar,
-                        args.gsp_falcon,
-                        args.sec2_falcon,
-                        args.unload_bundle,
-                    );
-                },
-            ),
-        }
-    }
-
-    /// Disarms the guard and returns the [`UnloadBundle`](super::UnloadBundle) it contains.
-    pub(super) fn dismiss(self) -> Option<super::UnloadBundle> {
-        self.guard.dismiss().unload_bundle
-    }
-}
-
 impl super::Gsp {
     /// Attempt to boot the GSP.
     ///
@@ -107,6 +47,7 @@ pub(crate) fn boot(
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
+        let sec2_falcon = ctx.sec2_falcon;
         let dev = pdev.as_ref();
         let hal = super::hal::gsp_hal(chipset);
 
@@ -118,7 +59,11 @@ pub(crate) fn boot(
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let unload_guard = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
+        let unload_bundle = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
+
+        let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
+            let _ = self.unload(dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
+        });
 
         gsp_falcon.write_os_version(gsp_fw.bootloader.app_version);
 
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index d3e47ef206de..851d1f24c137 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -24,7 +24,6 @@
         Chipset, //
     },
     gsp::{
-        boot::BootUnloadGuard,
         Gsp,
         GspBootContext,
         GspFwWprMeta, //
@@ -51,15 +50,15 @@ fn run(
 pub(super) trait GspHal: Send {
     /// Performs the GSP boot process, loading and running the required firmwares as needed.
     ///
-    /// Upon success, returns a guard that runs the GSP unload sequence if GSP boot does not
-    /// complete.
-    fn boot<'a>(
+    /// Upon success, returns the [`crate::gsp::UnloadBundle`] to use with [`Gsp::unload`], if one
+    /// could be created.
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>>;
+    ) -> Result<Option<crate::gsp::UnloadBundle>>;
 
     /// Performs HAL-specific post-GSP boot tasks.
     ///
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 1d06405a32f6..5a39d087c904 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -7,7 +7,8 @@
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
-    time::Delta, //
+    time::Delta,
+    types::ScopeGuard, //
 };
 
 use crate::{
@@ -23,7 +24,6 @@
         Fsp, //
     },
     gsp::{
-        boot::BootUnloadGuard,
         hal::{
             GspHal,
             UnloadBundle, //
@@ -143,13 +143,13 @@ impl GspHal for Gh100 {
     ///
     /// This path uses FSP to establish a chain of trust and boot GSP-FMC. FSP handles
     /// the GSP boot internally - no manual GSP reset/boot is needed.
-    fn boot<'a>(
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>> {
+    ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
@@ -160,10 +160,6 @@ fn boot<'a>(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
 
-        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-        let unload_guard =
-            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
-
         let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
 
         let args = FmcBootArgs::new(
@@ -174,11 +170,20 @@ fn boot<'a>(
             false,
         )?;
 
+        // Wait for the GSP RISC-V core to halt in case of error. We create this guard after `args`
+        // to make sure that boot args are kept alive until halt, in case they are still being
+        // accessed.
+        let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
+            let _ = unload_bundle.0.run(dev, bar, gsp_falcon, sec2_falcon);
+        });
+
         fsp.boot_fmc(dev, fb_layout, &args)?;
 
+        // Wait for GSP-FMC to release the GSP lockdown, indicating that `args` is not accessed
+        // anymore.
         wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_dma_handle())?;
 
-        Ok(unload_guard)
+        Ok(Some(unload_guard.dismiss()))
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 87ceb8878f01..f78e2489f5a6 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -6,7 +6,8 @@
 use kernel::{
     device,
     dma::Coherent,
-    io::Io, //
+    io::Io,
+    types::ScopeGuard, //
 };
 
 use crate::{
@@ -32,7 +33,6 @@
     },
     gpu::Chipset,
     gsp::{
-        boot::BootUnloadGuard,
         hal::{
             GspHal,
             UnloadBundle, //
@@ -259,13 +259,13 @@ fn run_fwsec_frts(
 struct Tu102;
 
 impl GspHal for Tu102 {
-    fn boot<'a>(
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>> {
+    ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
@@ -290,9 +290,12 @@ fn boot<'a>(
             .ok()
             .map(crate::gsp::UnloadBundle);
 
-        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-        let unload_guard =
-            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
+        // Run the unload bundle to try and recover the GSP if an error occurs.
+        let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
+            if let Some(unload_bundle) = unload_bundle {
+                let _ = unload_bundle.0.run(dev, bar, gsp_falcon, sec2_falcon);
+            }
+        });
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
         if !fb_layout.frts.is_empty() {
@@ -319,7 +322,7 @@ fn boot<'a>(
         )?
         .run(dev, sec2_falcon, wpr_meta)?;
 
-        Ok(unload_guard)
+        Ok(unload_guard.dismiss())
     }
 
     fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {

-- 
2.55.0

