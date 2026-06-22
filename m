Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D47CCDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D9210E4E6;
	Mon, 22 Jun 2026 07:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jJ9n4YTG";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB58E10E4E7
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFPOLAxjJPZJgIQw0qiGsv2XQUBoNF22x1EDkkNeAkXjZ8Sg09voes0LGi6fywhzhhfBb6Q5jgiLYQ9NQlQuNcD+0EM+CwHRWKmUg11F9EWf+n9UuoRX/m5Ygy9OK/gbHsHryM1GbDXA3NDXZeK1xgErqupBVsQ3CZV+E7NzWqaX+s3qVN8LMiI+gnSNyLdMqGHUZo0lgP/1V7NRc+DQ2WKDFEJq6D8KRwU7jv9bx+4/XUA7kIMdeQfKSL5gcFzuYCVex1OTW9FTMkdBe9MNr1pXQc6pqlYNESlOjupFvzBkGbWptDZHANx1jwpiJlp+YKmjJmC40XwxI1ZxGyMPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY5Zme3hNuFKSX0zDHdSEwzrjSon5gyIWfYlVVMdcpg=;
 b=qVud8qBi0vi6+OKUWLgSzali9iTk/Dyg7OQ1zJAKjjR3WY+hPOYkTkpoHC8azkK3xbEFfwpAr/JnV09DP86S2Bgc6wxjwBDoYd0ABwZkdCiYK8JB72A/xT9z9eHSMtIDc0o7GvwG3bsgaHAH9kSjum0PMsl9TxgTCsF8NeWHbYjhBn4HAYdhdPgFTKFIx8IE8Fya8qClhiqOoYv6/q+kpzbWjUcN1By0HfQUhilOLIzwinxYVHiB2F3kuWkHK+3xmdz4047sc0qdyU4/Zzl9DFqTHEqWS8yZsd7fV2ANE5bvGMwX93v1PwTiCyzOQWFP9hZUCIahkn0BBfGOknkUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY5Zme3hNuFKSX0zDHdSEwzrjSon5gyIWfYlVVMdcpg=;
 b=jJ9n4YTGhISs9cegrCBvrpyzSAo64szwgJisHNk79GuL/UV/YTSV1HnE8OU8cPJerH5rtuZ7/Wt/w+klxyUcepFhxhe0tz0F8d1xQO7wGk8RzqymOIWNAOLFGQLr0MAVwnSplhcppHOxpz9SLhYtUEYGruKFQO3Kb/H2asn1lMOtGaBfXuDz2tGJxrQzHyAu58tf5GFPnhGIpaevckhCAqaX4CqUY2TuS+/vI/ldJSh7prL+o55uBbvruAif5agCtjO7RM8z81aT/AkzYnKC/z33cSHYdl6azJbl5HkZjMlVLPV/wrO5rpicWekWF5IAcxCp1ZNpFztVnEbSGod2Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:11:52 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:11:52 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:30 +0900
Subject: [PATCH v2 08/13] gpu: nova-core: gsp: turn FWSEC execution into
 HAL method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-8-0ddeafc06f5d@nvidia.com>
References: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
In-Reply-To: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::7) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c69ee3-e739-4a5e-873b-08ded02d88ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: fF9npVt5Sq57b25+jmkuZEtV5GFHNUTP9VfUItYR++zlJN2Vsp8GNNQBcotQTqIvdQE91cZwhSNLVKBePdJ2j9AwR63ptKDiJdwNOkpKbUUlIi8vpN2KRmxAY7+/zyTB/zbLYMLXXI1ai85MG2gemeTcguuUL5FcN/6k+oSnUIA2Eo1MKnBOOPkw52rw5IFNApN0JeIiqJ22fChR+aCA0fgfZGdL0QGKoZxW7Z9ggO7d3REtyj6Oj5ISAhESfg6PUeQ3Ibb7kX7Y08HnVBKzpLZJoUu1jy3K1nbuE0kPzPQQmDUY1xbmPOqz++wBhatNwoc9YszmXjP0CZdlT8eqpSYt844KsEmZ4enOSQXDDee7MpOmxljCyTAhbvt46V6ZZzHfGWeHHeznUMQM1yAiB5s1FDYXj+HMsia+KIDBPHOlw305srUl1vjHyhlHco40DD79T51BWBp/7vRIFxwfGAOUkT4ZhcFGHiPb8pOGbG9KaVCptvTA1vvbG+dJPhSxNpj3VZEE0bqeQme2sbYbEEIvZf32WuEZBi2IUrBtaMhorNME0sBQ5//9g56qtMr84Dvk0CkrUBrDyvrTiDCBdu0i/3/MxOakQBChgsIoB+UH8CWXf5Q7teJRkZvmE1PuFML8LOoqoqj4H2gOZ/hKGAmk9GCRf2+ZuLEuhtRFXF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0hweEFSMTQ0YlhNQlpOZVFFVitnb0IzZWxDMFZ6TEpqZittWFltRnVBUEdr?=
 =?utf-8?B?c0lvWnFnT2JxN3hYdThMbDZydGt0VEw3WG15SHQ0a0FRVEpWTnFJRnVUV1Ry?=
 =?utf-8?B?ZGRwQnJWaGpLbklpSngrcms0VkcxektPRU9BWm44UjVPQUUzZVN5bFpXbzlE?=
 =?utf-8?B?Vi9ZcjFhV3k2VlNNQlh4RE1aZkRZendYdElaeWZyYkNXRnZYaUc4VlQ3UjZh?=
 =?utf-8?B?S01Hc0hFS3V5ZEVnRTEySVNuQldzbTBKZnN2dWVaVzAwT2lkWDZtYlMxNnRZ?=
 =?utf-8?B?WkgzL3g2ZVRHZktDMGZyZndPSnplTzVOWUE0akltQWI2bys0TUt5Tk5MNEd0?=
 =?utf-8?B?MkdhL0ZMMjN2M3Fza01kaUF3WXdHTWo1OTEvUFNuRnJCU3I4dUQ0NHhCRmZ3?=
 =?utf-8?B?VURWMmhiSDBwYzJ4YlJhS2JDK1NEZTgxUTViOTJjSGhUTXVYN1Z0YWNWQU5X?=
 =?utf-8?B?a2xWdXdlSFJrRHpPSnJlNlZhRGs5NHRORHF6eFNvM3FOQmJGM0xoOExTT1pF?=
 =?utf-8?B?T3dneVlKZUlpZGtzc3YrS0lHZ2pMbkM4OU5ZT29RVHhUZVFVV2FYOHRzT0Z0?=
 =?utf-8?B?Z00ranpJMDVVUi9IRThjeGFNbVJFTFVRMWdlNWxNMDFFeStKUm0zOXlMei81?=
 =?utf-8?B?Wi9ORlJOMnJlcUtSU1lLamF0bklBQStvcXhHN3ArSndZd0w0bHJKNzZ3dTJr?=
 =?utf-8?B?MnVSMWo0UStwVlpaY1VHZUZ6Z056aUR3ZlpHTjJWS3MzYlVHVWVZdUdPUStm?=
 =?utf-8?B?K2lWYlhHZkVNM0RrSzNta05ka2g4TEtOM0hoQ3cxelh6OE9CNTJCSU5jQjBO?=
 =?utf-8?B?allJQWlvcDNJbmlCSFpzelFDSXhSSWZGZTEyaU9CUkRvRTJEenZQV0xmSVZQ?=
 =?utf-8?B?OVVLOXlBbVdwUENvQ2JoczBVNGtvL1ZCNTFmVldkb0xGN3pMMzIzQjVLOTIy?=
 =?utf-8?B?eExRTmFXZlJucjNlRUgxa1hraTg5VTZPMUVRdUMreTFpMFdBVDdBQjArb3l5?=
 =?utf-8?B?N1JiSEpVbm9ZOGdkZ3RqUWxZMTJ6QmJpUWc4Ui9KUHpObi85TVkwMlFhSzBh?=
 =?utf-8?B?MlRSYVVjS3FjM0MvMzk0ZHRiZ3BRRC9qbkpYMGR2R3FTL0hsYTcrM2FxNmdV?=
 =?utf-8?B?MHpwT1dZVi92enlvV3BSWm1EbVc1amY2NnFxYUU5SFd5aGNKMm9pbHM2THN4?=
 =?utf-8?B?S2N1YUJoSXljYXZjdnViS1d6M2RuZktEUklaZUU4Q1FQOXRmcmNBVXZZaFdu?=
 =?utf-8?B?cDA4SEpCTit0aXNGZ0g3a25kdW9vODM3UHZwOEpJamYzc0JIQnFlVERyb1Zm?=
 =?utf-8?B?RzJINDlHNVFNOExKV1BNN01uVUdrY2JvcXZLOFpkVm82T01PUURDTEtjVlVx?=
 =?utf-8?B?U1hudEVvVk9vODA5R2FsT05EbkFzR21PaDZxS0dQWW0rTmVaMXA5MVB2aXZR?=
 =?utf-8?B?ay9aZTQ4M1NSVTVXMkR5azBJRzE2RFRzdmdYZmFKRE1ETWgwdTdIMlREenBs?=
 =?utf-8?B?WnFpRXoyV1dIc2RhSUFnVituWnRPS3VmUXJKNjNUNk1KZEZUZUVRdm9ra1BQ?=
 =?utf-8?B?U1krZzVHUldaVUlYbFNhV2Q0MHByb2kvd2pTOXRpLzNHWG01YzF6YytXUi9s?=
 =?utf-8?B?bTRMbmFiZHFMSFdOTUp2bXZvVnltc3VDSjJueXJvMkNUNjB3V1paakc3OWJa?=
 =?utf-8?B?MTlmKyswczc3bHhEVnFrbXgzNXZsTlBTWmh5V0xCSkFpaG5BQWl2RzJCZ2xI?=
 =?utf-8?B?SWRkdU92UkRVYnA0RHNFM2c2ODVHdjZwWFZVT2FjU3RxMXg1azI3TzBUZEt0?=
 =?utf-8?B?OUNYNVhEY3VtTUZYdi9rbS8vNlRnZDlqSmUvNkt4aXdUVFRGVUpuLzFSRGI5?=
 =?utf-8?B?TVBkY3RraWlVa29XMkkwWnVoQjNzVnJXdXJLcHl4SUJEckVNQzcrWWdBdkNZ?=
 =?utf-8?B?elBmdWxKdG5Zd1I4bG5XYTBtMzRwbm90YnNsQUZsVTRMZjlmTXczcDlqT2hO?=
 =?utf-8?B?aWpCdW85M2xnTmQyTnVKVmY2TGNuUjdVbG5vaGxFYVhBcE5rNXpnais1MGhD?=
 =?utf-8?B?d0dJNUUyT0JhcUxraHhTalptR0FOb0F2ZnpPb1RWWXIyOHlQNkM2bWx4aU95?=
 =?utf-8?B?cUE5N3RkN3l2VDJFVEtmSnVCQnY3dU5KYUQwQ0Yxbmp0czBkblNmN3VMdHND?=
 =?utf-8?B?d1ZtUnNSSEdaU0crdWh5VStRa2pGclh2QXQvZFF1TmNRem0zcUlCaGtVNXVS?=
 =?utf-8?B?Q2tZVzkySlNjaXlyVlBiY2taUjc5MTBwTHlXSnlWYmFRSndNTmZnMHBLTUJu?=
 =?utf-8?B?UnNDZXhPOTVjeUh0eHBKUy8xbG9JVmEyeG9Ka1VoMEpzTW03Ylg4Ui9YZTNr?=
 =?utf-8?Q?wwQa4tJTYUOPD1fnDLClHAejpeGOh0fjn9G02bFZIZQwG?=
X-MS-Exchange-AntiSpam-MessageData-1: MxXG118RbkDbmA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c69ee3-e739-4a5e-873b-08ded02d88ce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:11:52.1516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdWhWmjavbRWSa521v+HuwQuzvuBksFgUNG7E5X3l73ym2KvKcw54bf8AiZAS6gOj7Lwu3mWS8PZ/PuHFcnQ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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

Turn the `run_fwsec_frts` function into a method of `Tu102`. A following
patch will turn the "use FWSEC bootloader" property into a flag of the
TU102 HAL itself, and making this a method will allow the code to access
it instead of querying `Chipset`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 175 +++++++++++++++++----------------
 1 file changed, 88 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 230145146540..fb0fc99b492b 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -126,95 +126,96 @@ fn run(&self, ctx: &GspBootContext<'_>) -> Result {
     }
 }
 
-/// Helper function to load and run the FWSEC-FRTS firmware and confirm that it has properly
-/// created the WPR2 region.
-fn run_fwsec_frts(
-    dev: &device::Device<device::Bound>,
-    chipset: Chipset,
-    falcon: &Falcon<GspEngine>,
-    bar: Bar0<'_>,
-    bios: &Vbios,
-    fb_layout: &FbLayout,
-) -> Result {
-    // Check that the WPR2 region does not already exist - if it does, we cannot run
-    // FWSEC-FRTS until the GPU is reset.
-    if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
-        dev_err!(
-            dev,
-            "WPR2 region already exists - GPU needs to be reset to proceed\n"
-        );
-        return Err(EBUSY);
-    }
-
-    // FWSEC-FRTS will create the WPR2 region.
-    let fwsec_frts = FwsecFirmware::new(
-        dev,
-        falcon,
-        bar,
-        bios,
-        FwsecCommand::Frts {
-            frts_addr: fb_layout.frts.start,
-            frts_size: fb_layout.frts.len(),
-        },
-    )?;
-
-    if chipset.needs_fwsec_bootloader() {
-        let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
-        // Load and run the bootloader, which will load FWSEC-FRTS and run it.
-        fwsec_frts_bl.run(dev, falcon, bar)?;
-    } else {
-        // Load and run FWSEC-FRTS directly.
-        fwsec_frts.run(dev, falcon, bar)?;
-    }
-
-    // SCRATCH_E contains the error code for FWSEC-FRTS.
-    let frts_status = bar
-        .read(regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR)
-        .frts_err_code();
-    if frts_status != 0 {
-        dev_err!(
-            dev,
-            "FWSEC-FRTS returned with error code {:#x}\n",
-            frts_status
-        );
-
-        return Err(EIO);
-    }
-
-    // Check that the WPR2 region has been created as we requested.
-    let (wpr2_lo, wpr2_hi) = (
-        bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
-        bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
-    );
-
-    match (wpr2_lo, wpr2_hi) {
-        (_, 0) => {
-            dev_err!(dev, "WPR2 region not created after running FWSEC-FRTS\n");
-
-            Err(EIO)
-        }
-        (wpr2_lo, _) if wpr2_lo != fb_layout.frts.start => {
-            dev_err!(
-                dev,
-                "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
-                wpr2_lo,
-                fb_layout.frts.start,
-            );
-
-            Err(EIO)
-        }
-        (wpr2_lo, wpr2_hi) => {
-            dev_dbg!(dev, "WPR2: {:#x}-{:#x}\n", wpr2_lo, wpr2_hi);
-            dev_dbg!(dev, "GPU instance built\n");
-
-            Ok(())
-        }
-    }
-}
-
 struct Tu102;
 
 impl Tu102 {
+    /// Helper method to load and run the FWSEC-FRTS firmware and confirm that it has properly
+    /// created the WPR2 region.
+    fn run_fwsec_frts(
+        &self,
+        dev: &device::Device<device::Bound>,
+        chipset: Chipset,
+        falcon: &Falcon<GspEngine>,
+        bar: Bar0<'_>,
+        bios: &Vbios,
+        fb_layout: &FbLayout,
+    ) -> Result {
+        // Check that the WPR2 region does not already exist - if it does, we cannot run
+        // FWSEC-FRTS until the GPU is reset.
+        if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
+            dev_err!(
+                dev,
+                "WPR2 region already exists - GPU needs to be reset to proceed\n"
+            );
+            return Err(EBUSY);
+        }
+
+        // FWSEC-FRTS will create the WPR2 region.
+        let fwsec_frts = FwsecFirmware::new(
+            dev,
+            falcon,
+            bar,
+            bios,
+            FwsecCommand::Frts {
+                frts_addr: fb_layout.frts.start,
+                frts_size: fb_layout.frts.len(),
+            },
+        )?;
+
+        if chipset.needs_fwsec_bootloader() {
+            let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
+            // Load and run the bootloader, which will load FWSEC-FRTS and run it.
+            fwsec_frts_bl.run(dev, falcon, bar)?;
+        } else {
+            // Load and run FWSEC-FRTS directly.
+            fwsec_frts.run(dev, falcon, bar)?;
+        }
+
+        // SCRATCH_E contains the error code for FWSEC-FRTS.
+        let frts_status = bar
+            .read(regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR)
+            .frts_err_code();
+        if frts_status != 0 {
+            dev_err!(
+                dev,
+                "FWSEC-FRTS returned with error code {:#x}\n",
+                frts_status
+            );
+
+            return Err(EIO);
+        }
+
+        // Check that the WPR2 region has been created as we requested.
+        let (wpr2_lo, wpr2_hi) = (
+            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
+            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
+        );
+
+        match (wpr2_lo, wpr2_hi) {
+            (_, 0) => {
+                dev_err!(dev, "WPR2 region not created after running FWSEC-FRTS\n");
+
+                Err(EIO)
+            }
+            (wpr2_lo, _) if wpr2_lo != fb_layout.frts.start => {
+                dev_err!(
+                    dev,
+                    "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
+                    wpr2_lo,
+                    fb_layout.frts.start,
+                );
+
+                Err(EIO)
+            }
+            (wpr2_lo, wpr2_hi) => {
+                dev_dbg!(dev, "WPR2: {:#x}-{:#x}\n", wpr2_lo, wpr2_hi);
+                dev_dbg!(dev, "GPU instance built\n");
+
+                Ok(())
+            }
+        }
+    }
+
     /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
     fn build_unload_bundle(
         &self,
@@ -283,7 +284,7 @@ fn boot(
 
             // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
             if !fb_layout.frts.is_empty() {
-                run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
+                self.run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
             }
 
             gsp_falcon.reset(bar)?;

-- 
2.54.0

