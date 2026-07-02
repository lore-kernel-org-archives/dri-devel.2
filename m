Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950BFC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A7D10E2AC;
	Thu,  2 Jul 2026 02:29:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UkAWpIm5";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F57910E2AC;
 Thu,  2 Jul 2026 02:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhd3cCnJi9DMGOYFKzMApZTDfttX048xR7QfzefwOhAMHAxySjFivhYIJLrcaBF4qKBroamxlYUjghnVwVXdJDGuPQPeXBHyk4/nbYry12NgYQtN8Pua0h829Zv8ICNOCjeTDAWQLWKgVc+iDm9kL2gXSyV4mkg/DADdbZJ7WsFdFH54lULcWFzp4Lje815ysbHhhDH0aifB2P4hTf5GgBCOWyWaNpq/kpioD6GqHlgEK4Jf6S1CP+HdvyOfhn23NdfuawdjRVhl5W8YOvgNuUrlX2xo067Jm1qPFliGs7fBZL8r0NPifgRoCRP63bp0DkdZ2m+nfzPykH2Gh/IGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzr3v9Ieye9/KCi97AdKNsmax8KjbENDDi9IKxxB20I=;
 b=eAHnw7L+fR1ssRuJw2Vy2M2eqyALbtesCM8tbxseFTLqQEb8yMtAOr8ccagNtJgRts5+Z8+rJ1VIwoX8QYiyJrO3WzaZ7zsLX/StjeNu05ZzWzjTvQswN6bc3B9WocnG82HY4ZQLHhEKcyqrv56XxCfODnqU7xJrLUc8ZFKig3mrNF58yLuYbuNVFvOuO6buaGqGgkTYzV10u3DZGLDaAUUt5VbfB6Nc0AsrU/f54h98Se1nulvl64AYws7r/DeHC12IoIWAznX5E4va4hGZzmZElQTgaUfxWjFUI54pMogVSubLBqp4rvAiJ3qmoprX9sL9KYuFLqnSE9YkFvOejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzr3v9Ieye9/KCi97AdKNsmax8KjbENDDi9IKxxB20I=;
 b=UkAWpIm5k3pPVhz73d2mc7P3xsCB2CjtD7D16P+6NjYgjd7j/JFhBXcHPidPrwV3872Fk0AtturI+fyOkMULFmNgDtkVwrxiq7lxzNSpY4qWg0K40tH+pOc8B089NRtSmlFYDdc8VIs4aQE+l2bc6ZrqYcd/NwdsBldTWNDNP6H6HoUe2aMa/LQghLXH9rxkBP+7tWZd03X83niHcn6X89DbnHQ74uIzDK35hVBzOzleNme5AfBd4ij902vqpW/ZEdUvrKjwRI9C4ZHOE5boYMx707B8kiKRHoLT+RPBYQfwfqCEgvQT8+nAsH71qDPPUuwy9R7v7qoIY/5Qww7a2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 02:28:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 02:28:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 11:28:51 +0900
Message-Id: <DJNQC1A84TF0.17HUBQBCRGFZ4@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 09/13] gpu: nova-core: introduce GspBootMethod
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-9-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-9-5539d8469590@nvidia.com>
X-ClientProxiedBy: TY4P286CA0089.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfcf4bd-b40c-4aed-6d5f-08ded7e1a9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|376014|7416014|6133799003|22082099003|4143699003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: nAKS1OzZTEprnJzKzKxSI/iroFtUuUfBFiEwPM584UrrrFLCQ7+hLwF6aevZe31+I8OMgP0DQAbNgo4OU9TuPLgnFlwVI6S7O5IjKaFdkL+knwIPk3XU2W4ec2GuIhnF2Af716+tEzjdXIDgl7Vl8bHuHcFd6GTNi8OXbQVdNvhSS8gbcaJKDI5EmvH9sFvfFZIKqf9LMdZmSf+uRFXfS5Rs09Bk55yG8WJCjSjSeCFwo8c/+oIYZduQDHfIHvYZWIMu+yo5mZa+x3ZciaqWOKZ+iW1lGYui81Ad2hkqQFlf61d+basvwfdaLhVtiXI9MsvuyMclDZbDUGAMFZfLni5YvfLRfEPZoGj8ofwb41sfooMdFX5XFg9Hgld0Cqd0JGHjFseCGl40mEYpon86NxEleSr+7xe9uOTkg++v8esFCqclp/kCJ1N7+4D9mlzXMeoZ5dv8Pc8XTqJAgC3ResLey+KDfz2MqHQUN7kvGpaaRIuQggtveykjhZfun7Rg6rfvitqBWhQCg5PystRa4ArwCzSP9Zu2agTLQ9AKXIe9fiJcBUNUZKTX4gZFfFnDTDZ2xOxxNq873DB0t+IeV5xT8fuBqX5PgckQ2Wc2ngYyQCobWpZhVqjeNFfamj66iRaWK+cFJQ0xnlouIBSwtr29sIjOaSt0y/f7ut1n+bDP9DRRXWEl/bk++8gSB6jSsY0WvHNL/DP/df3BkovFOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(7416014)(6133799003)(22082099003)(4143699003)(18002099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW1IZ25JVnNsUUc2Ymh2Q0RGcVp0T3ZYaXQxaVM1UW5zNG94RDNVZHlGOEdP?=
 =?utf-8?B?NzZ0RmRYSVhXV2FTaXUyRExhQlI4WmVzYmZTUGtEc1lrUDVDemQ1K1RFZlZo?=
 =?utf-8?B?ZjYxZmFoTmw1SFlxNGswYUljd1hjblc0c1VzcDJCdzBWTmNVNkszNWEyMFZ2?=
 =?utf-8?B?UEpYcFA2QzVYU0xpNllOQVZyMXpsN3k2a3pOcnRXQ011WUIzUFU2bXlWSWlE?=
 =?utf-8?B?aUk4NVU0TzZ1KzFSbE1ncGZLMlBLdDdzb2l3M0ZUTG9SbmlsQmFUY2lrS1Ra?=
 =?utf-8?B?MGZ2SGE4d0hFZ3FhVExHTXpBaDh3SXB2a1l4Z295R2lHQnVZZ2RMTUFNbnVM?=
 =?utf-8?B?d3ViQ0J5YzdnaG9qRVNFTEg3cjhKUmZlUkhGMG04U1hReGU3elYvT2NVSnYx?=
 =?utf-8?B?Z3lHWHdyZXpOTGs1clFrWGdTYkY0OHdXV0I5ditHczJOU204SXAwejRpdjhh?=
 =?utf-8?B?eGFEcjZ3QjlySERQWFVwQ2hLYjhMVkZjVHVNUGl2M3ZGditVYXAvbjVaYUVl?=
 =?utf-8?B?NG0vSzRYbnpkNnpxcHQ5SWhuYWMyVHdFV1lpeWZLTkEzZ3FjQ0padHQybTRw?=
 =?utf-8?B?aUFzRTdEWDJTQS82MG84cFRaSXhFdjVpNVMwZUdMSGx1clpMYUVTbVpJSEQ0?=
 =?utf-8?B?Q1B5WjhLOGdIblVMUTViQW1ZM1ZqUW9NaXNZeU1JYUkxcVN0VXg2OVJINkZ4?=
 =?utf-8?B?WGliVHh1L0l5MXRaS052SkZVUXJrKzE3ZzFkVC8vaWc3ZVNBeWZmT3MvK0tn?=
 =?utf-8?B?NXNnQ2ZqSzUxdGxGTVVzY0NZaHFMVnRnMGk2aGtsbFVGcDh4b2NjVWZtZnR4?=
 =?utf-8?B?N2RLUW5kTXVGeWJuMFhuUXd1MkplY1V2c3JPSTlZdjFTd3dNOE9QREZkRDVl?=
 =?utf-8?B?U3owa1NwY0lLT0dZU0h3T3VHVWUwZmF1RXJQR2NGU1c5bFhBZU5LaGVVeWl2?=
 =?utf-8?B?WFZFeHVoeTRXd1d6cUhsOW1WVUxvNzdoNHBGUUMyWlVpMDJ6THpCblFxdHVj?=
 =?utf-8?B?UnlTSFRsRExSR1k2ZWIrR29oWWZua2g0bXU1Z3VLN1diMHRxOU5pMStkalBs?=
 =?utf-8?B?a1lzU2NUUEZGKzMzNDhmcHdBSjl3SG9vRUpncTNYblJna1ZpOWVqcFN4V1hm?=
 =?utf-8?B?Mm40WC85aWMzSDlaRis4MmhvdUlBMnc0TE1sRlNKODF0U2lsRGEvS1FqdHZy?=
 =?utf-8?B?eno1aCt0NWcvb1QxMGY0V2ZZN2FQU1pER2Q4cVpGbktkNXhmNENWSWtDNkFa?=
 =?utf-8?B?T2FhY2ZodEZvb2twT0Uzcll6cEQzU2FyTEVRVmtqalQzV2xLa3ZVQ3ZYcGhq?=
 =?utf-8?B?V1gzT0tpSGVWQk9mcmhpWXRJdE5DRE5mNlhVOW1JTE9LNldIRzY0Yi9VT0V3?=
 =?utf-8?B?RVVCcG1XQ1VyVFo3bXczblhtV1dZcGhMTHB0dkNIZjlpbElvQ1U2eFEyNWFr?=
 =?utf-8?B?VVN6WlJxRjhMYUs4K0c1elFnekhTQWhxQjBGeWoyMlRrWFluZnVLd2Y5WjNV?=
 =?utf-8?B?SFZvSzVBbWl6ZXJuSms3TGo4cUdEMW8xTTc1QVpIZHFPL1VUSEhycGZkWWE2?=
 =?utf-8?B?aHNaeXh3a3UyUzF0ODhvUWZGUDhMQ01Lb1BMUm1tVGFvZEluOG1OWWNDUURo?=
 =?utf-8?B?NU1GcEU4c1ZrKzVYN2Q4UzFsV3FXUmdDcE8zQzdjMzgrWk1lU3JYRG5hM1hv?=
 =?utf-8?B?Tk1lU28rVkh4Qis1Ny91TmtKalF0Y3RPUGg3UEJocUFKQlpNakhOQXZDN28r?=
 =?utf-8?B?Z3NubXdERWt2MHlTb2tvaDQ4NkNSVlBxR2hQT3ByWTJBOUVpbXhFTGdLL0pj?=
 =?utf-8?B?aWdidGIrc3BKb25QSjRsVU9UVkRmTWxaWGRxNHJCZWFIdDl6R1hoVkd5WHZN?=
 =?utf-8?B?QUY3ZDFmOUljVkd3VFFLN1lvbjBNSCsvaC9ad3B5SlFYNzcvUFBNVDJhUU1l?=
 =?utf-8?B?MFh2QmhRY01CTHdzOG9HWHg5Q0w2dEtXSWV4ajlxOGNzUmhLeFdlSDVPZXM3?=
 =?utf-8?B?U0I2UnNrS0dySktSR3lsaHVSMzd2VTRjT2E1cTl3STRVbEF1ajRXOGNlS1RK?=
 =?utf-8?B?aGFOQkg5QkhhVVBDQ3BudDA2eCtEOFdLemxDKzdVdFhlZ2dXbm5CTjd6VFUy?=
 =?utf-8?B?Q1VMYjAwcHQwYmN5ZjZBS2h5b09nM0Q0VXVFdElDc2ZhRHB6Tm1KdVVkMXl1?=
 =?utf-8?B?L2pWbFplTkFnMTNmSjZVQWhKSFpHd2ZJYmpMcG9ROFNQTitQUnpwUVA1d2tx?=
 =?utf-8?B?TGJKN3poUTFMRXcvcjUxL2RoOVZ1T3ZCRmtqVkM5bFhWMWZEVnpSNFBWcXhx?=
 =?utf-8?B?N2lkRVdNZlJUcDVQZXV2dVlpWitZSWhadzhMQUdQeGFUY0Y1M3FKZWxhM2lL?=
 =?utf-8?Q?nZMQpGExjn1hdCGobABCFq7ZuIFF5g9N6zHAEwN0wG/WB?=
X-MS-Exchange-AntiSpam-MessageData-1: GAvQC62XUjIsZA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfcf4bd-b40c-4aed-6d5f-08ded7e1a9fc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 02:28:55.4840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pe4all8VBSXGODlxX5NMDXf4S4DMC/h/MmUaRbU9jSIozum003BbVVaLGjd/JhfJWTaUW5F4S1hUcXtbgiRqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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

On Mon Jun 29, 2026 at 11:09 PM JST, Alexandre Courbot wrote:
> The GSP boot method is currently determined by two ad-hoc methods of
> `Chipset`: `uses_fsp` (a boolean telling whether to use the FSP boot
> path or the Sec2 Booter one) and `needs_fwsec_bootloader` (another
> boolean valid only for the Sec2 Booter method that tells whether the
> FWSEC bootloader must be used).
>
> This is neither extensible nor sound: the combination `uses_fsp &&
> needs_fwsec_bootloader` is invalid, but can still be expressed.
>
> Thus, unify these two predicates into a single `gsp_boot_method` method
> that returns an enum type unambiguously describing the boot method to
> use. This ensures that no invalid combination can be expressed, which
> makes matching sounder.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Ideally we would not need to expose bootloader details (needs fwsec
bootloader, mapping of architecture to GspBootMethod) outside of the
HAL, and also not have to duplicate the logic for determining
`needs_fwsec_bootloader` in both the HAL and Chipset. One thing
preventing keeping all this in the HALs is that we need to know the set
of firmware files in a const context, which can't go through the &dyn
for HALs. I also find it a bit odd to go Chipset->GspBootMethod->HAL
which relies on the GSP HAL being entirely determined by the boot method
which doesn't feel generally correct to me.

What if we added a const fn n gsp/hal.rs called like boot_firmware_files
( or whatever) which returns the extra firmware files needed to boot the
GSP based on the architecture. Then we don't need to expose details like
`needs_fwsec_bootloader` or `GspBootMethod` outside of the HALs. We
still need another set of matches but it's unavoidable AFAICT without
being able to know the HAL type in a const context, at least it's
consolidated and in the HAL this way. In the future we might consider
type parameterising `Gpu` with the chipset and types that it uses with
the minimal set of strategies that it needs (e.g. sec2 vs fsp boot) then
we could even make the HALs not use dyn and push a bunch of stuff into
associated types.

That looks like this (on top of patch 8):

WDYT?

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firm=
ware.rs
index 80e948bf7511..1c02d80de7bc 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -423,24 +423,19 @@ const fn make_entry_file(self, chipset: &str, fw: &st=
r) -> Self {
     const fn make_entry_chipset(self, chipset: gpu::Chipset) -> Self {
         let name =3D chipset.name();
=20
-        let this =3D self
+        let mut this =3D self
             .make_entry_file(name, "bootloader")
             .make_entry_file(name, "gsp");
=20
-        // FSP-based chipsets (Hopper, Blackwell and later) boot the GSP v=
ia the FMC image loaded by
-        // FSP. Older chipsets use the SEC2 booter instead.
-        let this =3D if chipset.uses_fsp() {
-            this.make_entry_file(name, "fmc")
-        } else {
-            this.make_entry_file(name, "booter_load")
-                .make_entry_file(name, "booter_unload")
-        };
-
-        if chipset.needs_fwsec_bootloader() {
-            this.make_entry_file(name, "gen_bootloader")
-        } else {
-            this
+        // Add the firmware files specific to the GSP boot method of `chip=
set`.
+        let boot_files =3D crate::gsp::boot_firmware_files(chipset);
+        let mut i =3D 0;
+        while i < boot_files.len() {
+            this =3D this.make_entry_file(name, boot_files[i]);
+            i +=3D 1;
         }
+
+        this
     }
=20
     pub(crate) const fn create(
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-cor=
e/firmware/fwsec.rs
index 95e0dd77746b..7a931f22f629 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -385,9 +385,8 @@ pub(crate) fn new(
=20
     /// Loads the FWSEC firmware into `falcon` and execute it.
     ///
-    /// This must only be called on chipsets that do not need the FWSEC bo=
otloader (i.e., where
-    /// [`Chipset::needs_fwsec_bootloader()`](crate::gpu::Chipset::needs_f=
wsec_bootloader) returns
-    /// `false`). On chipsets that do, use [`bootloader::FwsecFirmwareWith=
Bl`] instead.
+    /// This must only be called on chipsets that do not need the FWSEC bo=
otloader. On chipsets
+    /// where the bootloader is required, use [`bootloader::FwsecFirmwareW=
ithBl`] instead.
     pub(crate) fn run(&self, dev: &Device<device::Bound>, falcon: &Falcon<=
'_, Gsp>) -> Result<()> {
         // Reset falcon, load the firmware, and run it.
         falcon
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 32bfa0be2357..c04706b60ba8 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -133,22 +133,6 @@ pub(crate) const fn arch(self) -> Architecture {
         }
     }
=20
-    /// Returns `true` if this chipset requires the PIO-loaded bootloader =
in order to boot FWSEC.
-    ///
-    /// This includes all chipsets < GA102.
-    pub(crate) const fn needs_fwsec_bootloader(self) -> bool {
-        matches!(self.arch(), Architecture::Turing) || matches!(self, Self=
::GA100)
-    }
-
-    /// Returns `true` if this chipset boots via FSP (Hopper and later), w=
hich requires the FMC
-    /// firmware image.
-    pub(crate) const fn uses_fsp(self) -> bool {
-        matches!(
-            self.arch(),
-            Architecture::Hopper | Architecture::BlackwellGB10x | Architec=
ture::BlackwellGB20x
-        )
-    }
-
     /// Returns the address range of the PCI config mirror space.
     pub(crate) fn pci_config_mirror_range(self) -> Range<u32> {
         hal::gpu_hal(self).pci_config_mirror_range()
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index b4ac4156056e..d5cca3c8350a 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -30,6 +30,7 @@
     GspFwWprMeta,
     LibosParams, //
 };
+pub(crate) use hal::boot_firmware_files;
=20
 use crate::{
     driver::Bar0,
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/h=
al.rs
index eddb4e8bf510..9da078dd1059 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -57,6 +57,25 @@ fn post_boot(&self, _gsp: &Gsp, _ctx: &GspBootContext<'_=
>, _gsp_fw: &GspFirmware
     }
 }
=20
+/// Returns the names of the firmware files required to boot the GSP of `c=
hipset`, in addition to
+/// the "bootloader" and "gsp" images required by all chipsets.
+pub(crate) const fn boot_firmware_files(chipset: Chipset) -> &'static [&'s=
tatic str] {
+    match chipset.arch() {
+        // Turing chipsets boot the GSP via the SEC2 Booter, and require t=
he FWSEC bootloader.
+        Architecture::Turing =3D> &["booter_load", "booter_unload", "gen_b=
ootloader"],
+        // GA100 also requires the FWSEC bootloader.
+        Architecture::Ampere if matches!(chipset, Chipset::GA100) =3D> {
+            &["booter_load", "booter_unload", "gen_bootloader"]
+        }
+        // Other Ampere chipsets, as well as Ada chipsets, run FWSEC direc=
tly.
+        Architecture::Ampere | Architecture::Ada =3D> &["booter_load", "bo=
oter_unload"],
+        // Hopper and later chipsets boot the GSP via the FMC image loaded=
 by FSP.
+        Architecture::Hopper | Architecture::BlackwellGB10x | Architecture=
::BlackwellGB20x =3D> {
+            &["fmc"]
+        }
+    }
+}
+
 /// Returns the GSP HAL to be used for `chipset`.
 pub(super) fn gsp_hal(chipset: Chipset) -> &'static dyn GspHal {
     match chipset.arch() {

