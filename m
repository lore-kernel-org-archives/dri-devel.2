Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BED5C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5B610EF1E;
	Thu, 27 Aug 2026 08:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IDYy+XHZ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8FC610E3B2
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:52:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2nGwOPSQxyo2yuv9TYvgr8XMih5EpmlA2EkYTJSJV3AYzU/ua4BQFWx+p66apQrVFcdzw/UrEsJKTDuzBHDd2zEEMt38logqoZwiMuCzKNu6iaJONZI5gv8eXIqcEa8dPx7F00xzFTCIaxbXjOeMGQEQejzVkNbTKayYLAcSdJjSz8K1lGz0RJNGAp+OWHeetIusRZk3XsBV0HSxvi9OH4JLNR6F9EXJbx5aO2CKibApVRpgPIvUyTe58I5ntUwH/9inJ2kLk2G7J3t1TKJLC2rKQsYeFQDjf3dmIDRPXWMo3WQzj7dvewl3xG0h0dfXcE3HdvQSIhS4vs6kXDSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IL+LGpDdvxkKwbZVEkuTAPSyjHwl52og9hVVu37XUpY=;
 b=ylEsS1JNS7K5KS6Zu6pGuOXI8DT/RA5U6KHBtyrlEuu4KIKdatpqqteAM7KdpbE5Azw0GuEOy/XO43KW5XviWpAvVLg9OCmZbJAinyrU5dhmmqTLNHRMPMctj/U/OK+9gb9SS+SsIJT84SLnbTaXYOXSR5No+N8LNWiaSGDC8CRBuesV/qSW20xgWifoB0Sc3F3Sj2X2moI3KtDjI4R8AwmJuy51otG0WlZPV+JL7uxmzQqiZ49/mA1bUj6my4e7Q67v3BnU095fNwloHhPgh+NQYTeaUyS9NYD7/a7WIMbvVONRRmHQIsPDcGk3jIXqCI2Ar+Oq2i9V3+RlUAfIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IL+LGpDdvxkKwbZVEkuTAPSyjHwl52og9hVVu37XUpY=;
 b=IDYy+XHZIH15J7ZbppnjrPyoZ2WR5GYSK89Pf0IMqDQHMoJFHw2mnQv6ou4qvndWyI4VKE6JkRwokFDPOYOVRFPX2mHbPjFQXfSCLWXzQ4YrvgLCZPMVkFocckoT4G1vtFkAzIhUpZygS5RoVYQCC/qE/1CMDlT+sT1W3SOH6jwESoxCzp3MbMVKXahqPzmYfiT3YoYt0aDg0OANwzrU6eaEi+NYuBaYgI1sAJvP5ykW8WJUHy7LkDNIWtNnljk4NlCAfrZialYGqfAQ1+QcPp42bGkQU+MetbyyYVA4jrfaRvl/QXnIANzului1B/P8l+QM1gVDFPepvEEeGHeKRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 08:52:46 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:52:46 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 17:51:51 +0900
Subject: [PATCH v3 10/10] gpu: nova-core: mm: Add PRAMIN aperture
 self-tests
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-pramin-split-v3-10-24b24d7afc52@nvidia.com>
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
In-Reply-To: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: DU2PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::35) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9d7564-01f6-465c-5224-08df04189065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10070799003|10067099003|56012099006|11063799006|7136999003|3023799007|18002099003|22082099003|11062099010|921020;
X-Microsoft-Antispam-Message-Info: LqIbs0OYOq05bpwPJ/KZL7k51VnMbvRzLtKKDfO8ZPkfq8AtLArCmjZcFDviOJ5WvLI1FYPymKz2ihjn4bNoROTFqjjQDoM75+/bZVhyma0dhDfXwZcrO5ngPWlF6tmpTGOWGZfV5h/gU5UiPMbW7dg05xbs/KLQkUujIV3iDY5buXRMjjjGawqGHVaj9jrz0BtjRPAHF5l3Qsrq6zFiUs6QLwTyOn7tU+yHTc7REZXbvUHoksFFeTMrcWIbb3QkvJoDOgLn14MRvmsMebMzsqgmjbfniFEfslC51TxmvHFWRde3BaK+qS/E4ML/orKR65vJFUSrVcZl6NMC0UjLVrLFbMx5RTPbPkM+Dv81Vhlc+l6pIwhl+2aitLrZ4RlTgEmECXRfKr79gvKKVNt/R8UJ/Dzsvtq2J0pW5n6yEx70bs3knRdyH77YaAJmXtHmUW2++3q8+n7ZMnNk+OGAx+aXus8LCCAGfw+IKVCQDyJYwD1q9oA4rDF1QFlsfSS+84mT+nSoZzjp0M0+STLV2Dn4i+IlrKgCUjut5hltBJCAzIHSFkoCZGK3EnUJ0OYwzCkYTD3MtCdRImGFV44LoaCu9TxThC7n6HUSrxMLzVM8bbAUwXbcz2Kf4jm31StfQM3Ih/Vi7N56BuiTPifsYSsfV+ZfUy0RrA+rxjJnMn3apB8UJHF5vB0wiuBOkOYMBVocJGXhGiT/MZhIM3LpzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10070799003)(10067099003)(56012099006)(11063799006)(7136999003)(3023799007)(18002099003)(22082099003)(11062099010)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlNLdEMreElTTll3d2dsb3Z6czBzbGhtNCtSMktUNGtXYTZzQXRsNi9yck82?=
 =?utf-8?B?TG1pcEhXZlZzL1RzTlYwMnc0ZWc4OTlkT0xtMTc0MlRrU250dmljMzM4SjZH?=
 =?utf-8?B?WEkrNnY4UWhvNlFuSU51SUJkSnVBWVlTbGNkb0FQckRLY0lGQ0E1aTZLSmlV?=
 =?utf-8?B?NXF2Q0RvMml5Y29nd3BuSkhYRGY2M2NkUHkwVjZ1MHh6dkVudzQvTExvc0R5?=
 =?utf-8?B?RVlGbjd5S0FxNGlJWnlXNVd1YzJzSGwrVjk2Q1dNbzEvZHVDbDBPaWNkK01n?=
 =?utf-8?B?bk5aVVdKemdGOXRPVE1GWkRpTEgweXJxOHdiQ1Q1SDZFazNLQUJSRFFPUlhy?=
 =?utf-8?B?WU5RVG5SQXk2dUk5UkM2M3BhVnVabk9CWExOTUtlN3l4d3AzS29oVE9DVm12?=
 =?utf-8?B?S2NhcStuMGVEbXZCYm04aGR1V3hRZEk4VUZrbkNwOUVQSnB5bHZMKzRlWE1I?=
 =?utf-8?B?TlJNZXRTcTZtUDdnazdVeGpSVjR5VTNObTUxRllHSzhtQ1c0YUY4RjJaVnlR?=
 =?utf-8?B?VnhpVnMwMlpzMXM1VzVDaUhwTWJkMnZPTThsOFk2OThpZkRFRXlTTlE3R0Zw?=
 =?utf-8?B?a3U1VHM2N2g4U2daTTY0NFczbHJncURGK3FzM1hSN2V3NzVSN3lFSThvSHF0?=
 =?utf-8?B?eU9iUXBUOG1ZS3NYTmZ5WjFaVkNKQ3hXcVFLdmFpUzRJbVFkVVpDeE5abXdz?=
 =?utf-8?B?MkpPYUo1VHQ3YStKYUQzOUJ3d1RBVGNpNHlwQllWaUJZS2tJemZBQkFRYUMy?=
 =?utf-8?B?RWl4RlRqamxtcDNaajBhQ29EdGJMZnhWRVVCWTRQSlF4aXUzVDBoWFB6cGtV?=
 =?utf-8?B?am1sckZzVHUranJrTG1CN2p3V3lMSmNIZW9qbXdYcytneHVBV2dlcUErTE85?=
 =?utf-8?B?T1pHK0lJOHBiN2NRODUrb2tMc0RXbVNpOWhoVnRQU1RLSWJwVEVhQTFpUXc2?=
 =?utf-8?B?NXVRMUphUmJKWjJVSnVDQ1REMU1pRDFsU0RaVk45R21wNlFCaFZuMTJqWnpZ?=
 =?utf-8?B?YVlpaDdMeUgrN1pVcyt2UFBIVDNPeXVwRDQrVkdHTWU5dVJrV2JWRHE4SGZD?=
 =?utf-8?B?bUZkYXJzUkVXSmptR0c5Y3daQ2lIUytyRFNpV1cwR2JaVEszMmhFUGdTUVJY?=
 =?utf-8?B?bFpRZ1dnSENkd2xSNzNhTld0eVlUMGcwakZSdHNCV1dnNWhjRStBY2c2ODIz?=
 =?utf-8?B?QjlJSTNLY2xYNzlWZ0JkdXBLTThoM25mMllNTDFqTVd6TWIvdG9KQ3VHMXV6?=
 =?utf-8?B?Vlpza1FuMGRFUUk1ODlRUjFuSmdhMStvVlptOW5kS2s3eUdrUUlCZUN5YnRi?=
 =?utf-8?B?QjZlSURRZHRkNGpuRHp5cEJzMmM4d0YyTFgya0hnWjdxWTAzZkJKSHduOXNF?=
 =?utf-8?B?SjIyV09JbHE5RUlKd3lBQ2tiZURIdUpCRnc0M1Vtb3k3dVlaQ1hVMjR2ZWZ3?=
 =?utf-8?B?UWRNQ2dIU3lTbnZ2aFZjdW5SOUNmSHIyYkt1bkVGU3pMK2xYQWdVTDM5MUZh?=
 =?utf-8?B?VEsrTXJLaW9VTm1HL0FXUDl1cXZmMXVKWThIYXNGZ21Bd2JJbysyWE1JbGlQ?=
 =?utf-8?B?dzlqRDhWZGoyVmpvVUROZTkrYWNRQ1Zuc3NRVjlKRXhnZFI2QldQaG1rWkQv?=
 =?utf-8?B?RDMrbmpqc0ZKOUR4UitFS21sa1p0UnV5WWNQZFoxVlpFa1NzblEzTlI1Q1g5?=
 =?utf-8?B?blYvSkF1VzVUTURZMDN4TnB2WDIvdjNWZ3oveVdHelRYZ3JOQlphTTZJa0Jp?=
 =?utf-8?B?ZytKQWdHRE9yQVg5WkJNbFg3dzBRd1ZqbjFzdEhlbTc5bTNoQSsxemRGSW54?=
 =?utf-8?B?QWtmWFkxTjQ0UHp5K0NEV3hqbWQzZFRWWFpmUFpFdkdzRWw2ckFyWmVBZDYz?=
 =?utf-8?B?SjE2Tkhma1FtS3ROc2cyUStoNU5GZDdKbUk0R3NEcThiZ2RtN056VENaOTdT?=
 =?utf-8?B?U0t6dU0wSEdybnpOSUs5RWJ0TURzMlhFZ3I2MG5PNmE3aHlzNXNicCtGOVdF?=
 =?utf-8?B?M084T0t4NGdDeW8zVU9ORmF0Y0RTVlJubHUwdlNDS0svWnRGbWEzRzVsREU1?=
 =?utf-8?B?SFV6WGVBRFI1RkIwZmprS0JDM1UxUS9EYzZJeVJiMWhrSXJNSHp4aUNlQW55?=
 =?utf-8?B?aHhnQnhjU3lZS0RJZW1qbHQ3YkNJSWlzQ3piVFpYUTJubTFSQ0pJMHBYc3JP?=
 =?utf-8?B?ejJJN09XLzVGSnZVcjF0ZzlOd2VrME1BeUV1ZGxma005MUhqd09scXRoejdm?=
 =?utf-8?B?djNrdHQwcGZzR0hSTnpXazlodDhpS0xwK2p2a3dsZm43NEg2K0dxSEE5NTEw?=
 =?utf-8?B?dG9JeTJCaWR2QnZYYkJNbDdpNm5UL1lMVVdFWlJLT2VXZjdqc1BJZlVKK0Yv?=
 =?utf-8?Q?OGN8tL/5MsvBOUYVTrOSjk1Bgm1+Eel2MhXaDtCJGdwD1?=
X-MS-Exchange-AntiSpam-MessageData-1: HhM/H3IxF9TkHw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9d7564-01f6-465c-5224-08df04189065
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:52:46.0058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhUJZym6z8bvbYYJIdiklo1TWmcdxUSvIhC2e7RZZ2xjrokeUouOIO2tFsJxuUam3dkFeXtK7CdcHTCqEG8LGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Add self-tests for the PRAMIN aperture mechanism to verify correct
operation during GPU probe. The tests validate various alignment
requirements and corner cases.

The tests are default disabled and behind CONFIG_NOVA_CORE_SELFTESTS.
When enabled, tests run after GSP boot during probe.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: convert the tests to window_at(), macros, and the new types]
[ecourtney: cfg-gate the tests and expect(dead_code), not a runtime no-op]
[ecourtney: run the self-tests on all architectures, drop the chipset arg]
[ecourtney: test within a usable FB region, skip when none is large enough]
[ecourtney: report failures without failing probe, start banner at dev_dbg]
[ecourtney: removed the mm-specific Kconfig option]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs    |   3 +
 drivers/gpu/nova-core/gpu.rs       |  12 ++++
 drivers/gpu/nova-core/mm.rs        |  40 ++++++++++-
 drivers/gpu/nova-core/mm/pramin.rs | 134 +++++++++++++++++++++++++++++++++++++
 4 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index cf3534dd47d4..8cef4c284277 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -86,6 +86,9 @@ fn probe<'bound>(
                 // (`try_pin_init!()` initializes fields in declaration order), lives at a pinned
                 // stable address, and is dropped after `gpu` (struct field drop order).
                 gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar) }),
+                // Run optional GPU selftests.
+                #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+                _: { gpu.run_selftests(pdev) },
                 _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
                     c"nova-drm",
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 7b3e378c429b..f0cba7336b29 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -429,4 +429,16 @@ pub(crate) fn new<'a>(
             )?,
         })
     }
+
+    /// Runs self-tests on the constructed [`Gpu`], logging failures without failing probe.
+    #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+    pub(crate) fn run_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bound>) {
+        let this = self.project();
+        let dev = pdev.as_ref();
+        let regions = &this.gsp_static_info.usable_fb_regions;
+
+        if let Err(err) = crate::mm::selftest::run(dev, this.mm, regions) {
+            dev_err!(dev, "self-tests failed: {:?}\n", err);
+        }
+    }
 }
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 58dce211a337..9e4338c7c393 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -3,7 +3,7 @@
 
 //! Memory management subsystems.
 
-#![expect(dead_code)]
+#![cfg_attr(not(CONFIG_NOVA_CORE_SELFTESTS), expect(dead_code))]
 
 use core::{
     fmt::LowerHex,
@@ -123,3 +123,41 @@ fn sub(self, rhs: Self) -> Self::Output {
         self.into_raw() - rhs.into_raw()
     }
 }
+
+#[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+pub(crate) mod selftest {
+    use core::ops::Range;
+
+    use kernel::{
+        device,
+        sizes::SizeConstants, //
+    };
+
+    use super::*;
+
+    /// Run MM subsystem self-tests during probe.
+    pub(crate) fn run(
+        dev: &device::Device<device::Bound>,
+        mm: &mut GpuMm<'_>,
+        usable_fb_regions: &[Range<u64>],
+    ) -> Result {
+        // VRAM span the self-tests are free to overwrite, from the chosen test base.
+        const SELFTEST_SPAN: u64 = u64::SZ_64M;
+
+        let base = usable_fb_regions.iter().find_map(|region| {
+            // Tests rely on this being 8 byte aligned for checking misalignment handling.
+            let base = region.start.align_up(Alignment::new::<8>())?;
+            (base.checked_add(SELFTEST_SPAN)? <= region.end).then_some(base)
+        });
+        let Some(base) = base else {
+            dev_warn!(
+                dev,
+                "PRAMIN: skipping self-tests, no usable VRAM region of {:#x} bytes\n",
+                SELFTEST_SPAN
+            );
+            return Ok(());
+        };
+
+        pramin::selftest::run(dev, mm.pramin_mut(), VramAddress::from_raw(base))
+    }
+}
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
index 20be3fc471ba..7f89c093d591 100644
--- a/drivers/gpu/nova-core/mm/pramin.rs
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -176,3 +176,137 @@ pub(super) fn window_at<'a, T>(
         Ok(PraminAccess { view })
     }
 }
+
+#[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+pub(super) mod selftest {
+    use kernel::{
+        device,
+        io::io_read,
+        sizes::SizeConstants, //
+    };
+
+    use super::*;
+    use crate::{
+        selftest_assert,
+        selftest_assert_eq, //
+    };
+
+    /// Test read/write at byte granularity, at unaligned addresses.
+    fn test_byte_readwrite(
+        dev: &device::Device<device::Bound>,
+        pramin: &mut Pramin<'_>,
+        base: VramAddress,
+    ) -> Result {
+        for i in 0u8..4 {
+            let addr = base + 1 + u64::from(i);
+            pramin.window_at::<u8>(addr)?.view().write_val(0xA0 + i);
+        }
+
+        for i in 0u8..4 {
+            let addr = base + 1 + u64::from(i);
+            selftest_assert_eq!(
+                dev,
+                pramin.window_at::<u8>(addr)?.view().read_val(),
+                0xA0 + i
+            );
+        }
+        Ok(())
+    }
+
+    /// Test writing a `u32` and reading back as individual `u8`s.
+    fn test_u32_as_bytes(
+        dev: &device::Device<device::Bound>,
+        pramin: &mut Pramin<'_>,
+        base: VramAddress,
+    ) -> Result {
+        let addr = base + 0x10;
+        let val: u32 = 0xDEADBEEF;
+        pramin.window_at::<u32>(addr)?.view().write_val(val);
+
+        let window = pramin.window_at::<[u8; 4]>(addr)?;
+        for (i, &expected) in val.to_le_bytes().iter().enumerate() {
+            selftest_assert_eq!(dev, io_read!(window.view(), [build: i]), expected);
+        }
+        Ok(())
+    }
+
+    /// Test window repositioning across 1 MiB boundaries.
+    fn test_window_reposition(
+        dev: &device::Device<device::Bound>,
+        pramin: &mut Pramin<'_>,
+        base: VramAddress,
+    ) -> Result {
+        let addr_a = base;
+        let addr_b = base + u64::SZ_2M; // base + 2 MiB (different 1 MiB region).
+        let val_a: u32 = 0x11111111;
+        let val_b: u32 = 0x22222222;
+
+        pramin.window_at::<u32>(addr_a)?.view().write_val(val_a);
+        pramin.window_at::<u32>(addr_b)?.view().write_val(val_b);
+
+        selftest_assert_eq!(
+            dev,
+            pramin.window_at::<u32>(addr_a)?.view().read_val(),
+            val_a
+        );
+        selftest_assert_eq!(
+            dev,
+            pramin.window_at::<u32>(addr_b)?.view().read_val(),
+            val_b
+        );
+        Ok(())
+    }
+
+    /// Test that offsets outside the VRAM region are rejected.
+    fn test_invalid_offset(
+        dev: &device::Device<device::Bound>,
+        pramin: &mut Pramin<'_>,
+        vram_end: VramAddress,
+    ) -> Result {
+        selftest_assert!(dev, pramin.window_at::<u32>(vram_end).is_err());
+        Ok(())
+    }
+
+    /// Test that misaligned accesses are rejected.
+    fn test_misaligned_access(
+        dev: &device::Device<device::Bound>,
+        pramin: &mut Pramin<'_>,
+        base: VramAddress,
+    ) -> Result {
+        // `u16` at odd offset (not 2-byte aligned).
+        selftest_assert!(dev, pramin.window_at::<u16>(base + 0x21).is_err());
+
+        // `u32` at 2-byte-aligned (not 4-byte-aligned) offset.
+        selftest_assert!(dev, pramin.window_at::<u32>(base + 2).is_err());
+
+        // `u64` at a 4-byte-aligned (not 8-byte-aligned) address.
+        selftest_assert!(dev, pramin.window_at::<u64>(base + 0x44).is_err());
+
+        // A `u16` view at an even address is allowed.
+        pramin.window_at::<u16>(base + 0x22)?;
+        Ok(())
+    }
+
+    /// Run PRAMIN self-tests during probe.
+    ///
+    /// `base` is the start of a driver-usable VRAM span that the tests are free to
+    /// overwrite.
+    pub(crate) fn run(
+        dev: &device::Device<device::Bound>,
+        pramin: &mut Pramin<'_>,
+        base: VramAddress,
+    ) -> Result {
+        dev_dbg!(dev, "PRAMIN: starting self-tests\n");
+
+        let vram_end = pramin.vram_range.end;
+
+        test_byte_readwrite(dev, pramin, base)?;
+        test_u32_as_bytes(dev, pramin, base)?;
+        test_window_reposition(dev, pramin, base)?;
+        test_invalid_offset(dev, pramin, vram_end)?;
+        test_misaligned_access(dev, pramin, base)?;
+
+        dev_info!(dev, "PRAMIN: self-tests passed\n");
+        Ok(())
+    }
+}

-- 
2.55.0

