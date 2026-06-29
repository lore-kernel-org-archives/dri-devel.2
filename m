Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90E4C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430FA10E903;
	Mon, 29 Jun 2026 14:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nNRu96LO";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7146D10E900
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcewaDyyqstWANuoy+QJcDZ+jsVhQHqKmoJmgSjcwKLvV+/i+/6t3/dHwnYcl9AGrZtvbAcQVj4TOCzbtFwp3z8OeyXXhnUTilVbOhCTHjTy8A+laxjqInVPFixr2vXrZSzCyf0VLYmWScEEvQNKWRLHGaaWjJtdKdRZhqgsgYZv+M1+bj1CfpQoSxRcwm/Dvni4OdaZJRSsxiAfYgElF0ae7AME1pHF6em8h/8f6meILxJkRls9Kkuh3hRKRm4NDjKmDQEzWdb5OFMRaoucT4DIEt9C3PuadXBWOaKasrnAH1POBihgkl/LuvzKczL7Uhm5QHeTY2HyNuRmIzToPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCh5RDIG9kpjgUae5SMGYsTzUYlkSUM3g8Vxk01IuP0=;
 b=iMIXsIQ0yDsOiU9zb8OUsZjhnz2O99eCAK7H7ibHycDYnwSHl/Rx+RdzqakkOrp7hWhek1a0P5tm4JGC2j0ay6jUQVjNh+Z+O2gIp0/kbpmC8BSziKFC6jVItB7b9irk+C72/wcYMjlfLP59rJeqOm4VhV9I9T3hfj05686QqjJpZPDcLpIURn1Tbqjw/+gqz/ZUdMWmzWZqcElG8Kr3IbnDPANAgTH1mQ2lGhJ1njlMAE7hLkFGl9m9Xuc1n3RryK2NSkRdVrAbfKpfIG7ueB374JXG8llTC5bKfd4c5y5jDEa8i6jUonX1Udg7MoNxwUHiLweb0NQLZhJLRhjIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCh5RDIG9kpjgUae5SMGYsTzUYlkSUM3g8Vxk01IuP0=;
 b=nNRu96LO1Y95T+qBXZ/1dVnxBXCIZBthjdD5ZbPFjFKt24ke/rZbRUWD4u7idhBCVKwss1oji/8C6AMy0gSSADOk7X1R9wazbcxN+vKiWFL1FaJDhsivnTrG8mjPTnV26Elyx9BXj3lZ21OXJ2IYffSuPdnxkEMYpW2bKUNwjd3j+/kNidlIUtpUrG1TmBBpTw+Gd9Mim7tcIJJSNjrRcejLrK6Q4jCOIRzapFZxyAaqOB5oz+FBPGBzi6Gy/3+rQtYKOkcS7MFTBPLxcrkVKbH68SWzOSmZjeoQYKB0LSgVQEt5ptyGjBHwXqc4zxwMvNboR3f1JjdmZjJzgmseAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:09:57 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:09:57 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:35 +0900
Subject: [PATCH v4 03/13] gpu: nova-core: gsp: replace BootUnloadGuard with
 local handlers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-3-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS7PR01CA0254.jpnprd01.prod.outlook.com
 (2603:1096:604:24b::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3d5ce2-7c0f-4f49-c4dd-08ded5e819c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|6133799003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: E/fczZCMRYhM5Ql+dlRgTdcnFCZrVrllqeVQvhH129BHLMbRPksbeFGewnLKYTeDpKGFIpN1XC/UY6e0Jq+oROAW3O/qoMmkJmtryjcG0B3pysHNBRub8hIM1dhFkx2DQNcAjFOVTuZwG2/pt2Mm5vyZC+2Ywb98jm0z70s2loTXi24PSryDaObHFgBAh/0gi1O9qLRxvYdL32SVumrQnJzeMkislZXr7JVBvHEJWR6YwzyaP/AgusnRQzWYQ+OpVk6wB+zujvSB8QGjow0wxQPQBb7c7bWo7kvICoRjKfotFeub7LKg2berSe7km3RGb38SDJ5DD3YJfSLNoPwAVgXS4qWl9dCp0zUHI/Wioydcw2LUm1IWDMF6+X09n92bEPtZdZ0Yfnc/cbyCCsynFZCjMmvHkSMl3E22nMCw92ZnkCS0KoItKX2yzJ2sbIQj5pE8ZwXCDhZJh6PhVZnJ4JAZARNBSRD4IrTbEsdFaWSRshoDoXhBXHBO1JAiZ/MD8Sxn3Y+svDDXG+6QiSuI/tQVcrQh7/4O/19RPalUdjXgtseXYwVW85Z6JwXhLUZ6LFoVhywl51s7JyYlTW7JO2Xyy2g2C3B3teLZ5ILVi7wgQ9CMqaPDnpMdC+hGoEElvV6shvLVbbzE/qrHRlZPnh/OqoavY1sO7HsYJltJhDpQtJdo8fGKOKFvkp5UXaRnJs+21cWe4DYC9n1ciclQHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRJSnp4NE9YbFo2T0hFemxDZFg0VEpvcit0eWc2eFRKMXhjcE1OeDhpTzgr?=
 =?utf-8?B?TzV1SmtqYjM2WEhlb0QwRlQrNDBVNjJuSzRJS0VmdXBIMW93YkN1TkdKZUJh?=
 =?utf-8?B?d294VGc5WHZtVWVwcWhPVE85RUN3eWNSSnR0R3VaSXpIUzY4KytpcFlRS0dl?=
 =?utf-8?B?d0RPUlNNWWIwMVM0dndvdTFKczlrNTRrU2dwL2U5a1EvMVM3bnF5ckNjMEVa?=
 =?utf-8?B?RWt5V0Z5c0h1bUJhSnlLUVVneFY2UDhQbG9CRGNXWGNwUDE3LzdRS0t3K241?=
 =?utf-8?B?YTRDdGxXckN6VkRkL2dvMXNTMVFteGJEUW41bVFsbEdIWU16Vm1nSjlocEJR?=
 =?utf-8?B?alBVMmdLLyt5cXZzcFBXUThESFRkYWQ5YVREZndiVFBUcHpNVlhUUm5YMzVn?=
 =?utf-8?B?UnRWcDhhOHFBdmJQYVJkVjU1clJZRUdBT2R3Y3FRcGpEdUhLYkYyVnFPRkU1?=
 =?utf-8?B?Wk5NS3hlZlZZM2lhcnpFSXg3ejdQUGZZZi8yMm9xVm9kSmU1ZlQwNUJzeGN6?=
 =?utf-8?B?YksrbE82QXVSY2Z5aEx3QlBhWHoxTXJRL3pCbFJ2b0cvR3VVSmpuZ25JeHVL?=
 =?utf-8?B?bk0rdlgwTEx3djhReFpVVHZlU2wvT0FrKzNvY0ErMElKd1llRFUrVUFMQUZn?=
 =?utf-8?B?bmpQQzVVdVJ5MlM1MHJFNmdWSnY4RGNPN2V6cVdGUDRFUnBsZk5FNGZpWVMy?=
 =?utf-8?B?ZDhDQmJsNzJBNlJiZlNzS3Fsck5kU1hpWW9wRUVMUmZFc2FFUnlSU0pOVlZG?=
 =?utf-8?B?b0JWYVd6TEUxSjdJRmdrMXorcWRkVThzNHZkZFhhK3ovZjh6VVNvRDJDS2Yx?=
 =?utf-8?B?Ym8xdlMwVlpYcE16eHpVVFNTdVAvZ0JGUkFOcmRaNC9RMjNKVTIzQ3AvTFZW?=
 =?utf-8?B?MDVNM0JOS3dBeWx3MUhMWFhhdk9IWEs3OFEyMjV5NnpQSU1rQmIwQkcxWGVB?=
 =?utf-8?B?bVBCN2J6NkJZMHdPKzVQOUFDRzRSbGtEV0tWa05DeDBFdW9qT2xEY0NOK2lX?=
 =?utf-8?B?VGtwVWxDL1U3eXJKQWx6UTRsOTE3YzNoLy9QYXppU2ZwdjhacnkzQzFiTFRo?=
 =?utf-8?B?VzVZdkc4NEJ3WUh0VUlNcCtNYzllMUtHNElKOXA4TGNTb0NmRlBTbkk4YnpO?=
 =?utf-8?B?RjRXR0JxbUxLaGVhUHQrYUZmU2ovVG90S1JHOG9jbVE1VENtb21xQlJ1UWE5?=
 =?utf-8?B?OThWanhQT0UrNEEzbW1HUGc5NzZZYWk2R2Y3RldFUTh5amRGbnNQYkhRWWY0?=
 =?utf-8?B?MitLTmg1VkloWGJUOCt2OUVzRDc3S1R3VnllS2xQNFF2cWVpM1ptMXp6UGM3?=
 =?utf-8?B?TlFabFRybnFiWjFFZHFFaW5DZ0loRG1MeWNnUndsZGVDbWIvaHcxUm1HN2hs?=
 =?utf-8?B?cml0clVOUGNxVm1BZzJWLzFLd1lYdTdBZHFkV25yR1M5bE9rWGJSME02aENt?=
 =?utf-8?B?Y2JadHQ3czh0c3hadmdXam5WNzJkQWRLMUF2Y2kvSHJOTTk4WHdudElFMlR5?=
 =?utf-8?B?YVBkeHdNSUVMVnNPY3I4a0I5VWc5QjVKSE5mMEx6aEYvNmt6WGtsQlNKWFFk?=
 =?utf-8?B?dE5SSUVSSVVLazlPSXViUkJpYzFhbjdlY0djeHpVbjhBU2pqVDMySkdNaHNQ?=
 =?utf-8?B?NVhqcVhLMXlRaWxVZ3Nqa0FscXBEQ3lEMW1KZlpRZzBteDgzVkgyYmJpdWg0?=
 =?utf-8?B?TnBaU1V5UzlndjZSRzR4QU5iOFkxZkxGM0VhMmlHcWxFNlByRExBMldCb0RX?=
 =?utf-8?B?YXllUGVISVVMMldoMm53UHZUcXJxR1BUUnYvVkV3cTI5Mktzb1dhL1RuSmVL?=
 =?utf-8?B?T2lvNklQZ092QTlkeHFrQ2ZpVEJCb3pXa2JxTkpGVFN3QlcrZVg1bHllS1BP?=
 =?utf-8?B?blNmWjRnMzMzZERScnlibUdQQk9jWi9ZZ0RZUDNnVGJzS2FTaGY0ZjhXamhj?=
 =?utf-8?B?ellLd3A5dXZlU3hocy9MVjJTdGVWTEhNdjNTTmNhOFVsWHQ1bzNGQ3dmUVFv?=
 =?utf-8?B?NGRKSWgvOGhRc1IzZWFvNCtOMCtJVDQ0bXQ0MWYzcFVrR0NKQk45TkgyUTZC?=
 =?utf-8?B?T09KMUZLS25jWjlTeGFoV2FFWVFHU05RblVBUCtHY1ZzTXlsMFFWZ1Mrd09X?=
 =?utf-8?B?d1Fob3psS1UyQ2hweDFQZ1Y1RUtleU9LUm1ZM0M4azRFeDA5cXlqVG11Yko2?=
 =?utf-8?B?YldzZ0dtOGJlS2h0UFU5eFdGTTFzQTdwVXBlVUdwMlg4WmJxMDBpTmZyK0hi?=
 =?utf-8?B?dStkcW00ZHY4V1VZRzNEaTlxZnRvVGdIcGpnRElLdkVheXBZMUFzS1RJVzNN?=
 =?utf-8?B?cW5KZW9ic1o5TmxMemc4UFN1VUZWTGlsRG90L1M4Tmp5Q05KNitqNUFzVEk1?=
 =?utf-8?Q?Ag1OyrSi3wHcnDycqGm2RkUoH/88/l5KO2LCWGzxZ+1Ba?=
X-MS-Exchange-AntiSpam-MessageData-1: 9acspyjkgUtNcA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3d5ce2-7c0f-4f49-c4dd-08ded5e819c3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:09:57.6811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyx21oAs5ZY3LwF7HmQdblRuBni2sFFFize9nMDVbZzv45GHP0vj9JcoFuLutLgTXZitAh1syrTaqG7wbJ7RGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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
---
 drivers/gpu/nova-core/gsp/boot.rs      | 67 +++-------------------------------
 drivers/gpu/nova-core/gsp/hal.rs       | 13 +++----
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 20 ++++------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 +++++++-----
 4 files changed, 33 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index ab0491b57944..536f2e341c01 100644
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
index 1d06405a32f6..5fe445d73599 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -23,7 +23,6 @@
         Fsp, //
     },
     gsp::{
-        boot::BootUnloadGuard,
         hal::{
             GspHal,
             UnloadBundle, //
@@ -143,27 +142,22 @@ impl GspHal for Gh100 {
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
         let gsp_falcon = ctx.gsp_falcon;
-        let sec2_falcon = ctx.sec2_falcon;
 
         let unload_bundle = crate::gsp::UnloadBundle(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
 
-        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-        let unload_guard =
-            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
-
         let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
 
         let args = FmcBootArgs::new(
@@ -174,11 +168,13 @@ fn boot<'a>(
             false,
         )?;
 
-        fsp.boot_fmc(dev, fb_layout, &args)?;
+        // Keep the result as we want to wait for lockdown release even in case of error, to make
+        // sure `args` is not accessed by the GSP anymore.
+        let res = fsp.boot_fmc(dev, fb_layout, &args);
 
         wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_dma_handle())?;
 
-        Ok(unload_guard)
+        res.map(|()| Some(unload_bundle))
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
2.54.0

