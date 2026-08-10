Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1460EC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212AC10E899;
	Mon, 10 Aug 2026 13:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pmzv5Dka";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2508710E899
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQ4HJaLbq0C5lSmg6otADdQxKL1BFSCeuTQHhSL6PLrCb+tz559cCZTQSCMUYLuQx2LTNlTMW7XZrcFYztEUi8lBUQWeLiAnt2MBDVNn2G0HlMLiSU16fBKan1328JInfv8p10IZpvWDI/AFF4jwzoVptgNgNfaitZt8cB41HTAkvZ3Nf44uSESQmFqVt/MCuCTtf1g9KRSy5qACJniQsSy9PYfCNnfv/7GL+sd8LdrubJ1KlYnvLIZMu0cEHBtsEIRZJCcRCYd8WFymy2B+7JsFxcGb4BLn1dbBdpxRBS1X1KoDBdPKsaEB2VPJuIU6dbvjMbAD8itK2+WR7GXLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyGPrfWcyJv2cbMFbyYEkNhfOtxFnDgi/DBuXyBKCgI=;
 b=S5/qH7JwGfENT1PQVxxjpIkcHeUsCFTRv2q8ORjVKqcr2NFsruKKTeLdC7NdQLpVPGbrIV3O5B3K+f7/8LFRukQi4WjYyNY9RcbWh3zgfTzA8qxfdjpmc7bL3Mi1rMtr53lXIjPuhnbrADFpe2FM8t9mnpF9So7lSv53cUy+dddbyBvoQont0yCX4LswTXx9WM1HVuq85g9WoLDzHQHcFmz+SrrPLfWV0WOkSUdHzleoPwaTwhYYZZxjO45qI+aW+aCKQdTS5XazK8ajNrYlUl7S85Vcm69LjElJGAiO9xfw/kVrEMaprRJFgaMjf4YLL+OJ5doNMCVsD9pG0Rf/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyGPrfWcyJv2cbMFbyYEkNhfOtxFnDgi/DBuXyBKCgI=;
 b=pmzv5DkaoIMIAOEgJB5uwz8HLES38DA2CAEHIykWTP2kfyOLANq7+geAQpYMlsDfnJ7xZahV4hnbkhfLXDR5vyf6Uy5NTA8zYkMoRyfQZ5FdcP/RdqoLJmzcPXjwrtdlPqVDD64u91KexWJC6RIvQ8Tyf0Ndd4nw+cVCfkdXMlvTOZaJJ0ZKLxnHW/i4GmPtidkT3teyTS+RNRKyfBEpaXqT4bIZsXP7zPK80DeMIWUqP+R6GPFyudnLJLXIqK+7QSGuWfYizdZ13fByM82y/o22kS55GLgo6WOxmmfUGwB5gAplf9eXWKMXjzuBouTL2QCxgL/AYTDE8rKj/IYVsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:58:27 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:58:26 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 22:55:34 +0900
Subject: [PATCH v2 12/12] gpu: nova-core: mm: Add PRAMIN aperture
 self-tests
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pramin-split-v2-12-65a00b3c7309@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0048.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 905dbdd1-2df6-4c0b-87a1-08def6e7731c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|11062099010|18002099003|22082099003|11063799006|56012099006|3023799007|7136999003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: MLvOfuiHBVFqS5PGUNkGGjATk1j8lbMDKPX2ss6dwigZJUJBEzEbDhtN/2kbFyNzNEsS08DPg9PwpjlQhFfCZsYNFUcrZjjr9g9j9rNsTIZ8Eaupqcgfx3fPHf5B3jtSP0ba/kJubONXIngYRVfkJrx1+5D+qKYNNBxI6xRcSYCmBJYcMg8qqxIN/Z6KJZYc5ZoJ4VRKC6SwGANUilxqxxL20XWl+9f71vSGned673ykqak9EZoqNMp8gBaFuwVedH65SzqXNCHoNbJzX8RbF/ryyrszWzpzzkARb5r7i/rRTGNE4VAbvqh7RDnk86OcEhVrWKUHssRxO/pSm0Nv/V3c2OkadbdDnG86IdsR6KbI1E4a80iXwWb9cGJXVyHZcwq02qUmV/7Y3ACGFajkcCj9W6nKiBeTsJrYDYQ9fXHpiOvop1XQ1cLw8m/Tu2Qp9QNcfQh4GUj8uEoaQ4VMk2p2jrXMT2DIR6CVLvXenOmPbzyR+dRnMAnuXKAafhdX0Cmd3ryrZQKUtKnblJAp91xZZBHXeeDq4Q8n248rN4qtFvesqF49xv2vLIaP7kUQZpJEJZxUt8lRn8p1UenC9ZAbohybk3Bgyzjh1hdqXi3iVH+9h99YGbDHKgp48G8wF7ZD1eQMb8iqdkdd3zwRC6Te3aGJVHlo9kv0iitYssH4bJUJjZZtKWrmvHrWSTymH4E5Ojv0uOQxJvIvKdmMKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(11062099010)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(7136999003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU9rNklzVjZRMnMrM1IvNFJ2M2pCNXVnM2JUaVF6QkxWbnNpUkczT2tjOGVN?=
 =?utf-8?B?MWwvbDUzRUF6R3J0M3N6dTBmYUFjSXpuUWV6UGZkZlJETjdETTFSbW4xWWpD?=
 =?utf-8?B?MUU5MmlVRE9TTXJMOHcremNTT1RtUm1yYURyOVROUVl4SU41YnZFUEcvWnNV?=
 =?utf-8?B?aC95bkVFWG1KTGYwdUZobnliM1loYkhTRkxvZTRlMlVpM1huMjdUbmZWN3pR?=
 =?utf-8?B?N3BxSVBwYkFhbjRONHc1WjR0ZmdmZWhlbVdRQ3BTNlp2UmM2dndZMDB5N1VB?=
 =?utf-8?B?NzFHbVlsNHRqSFJQOHpRY0dPUkhNZXk3ZXlNdG9DeWdINDRsT2FJTU4xRnRO?=
 =?utf-8?B?REhwa1VKQmF4Vk04cldQUGVRamxDa1JGU0lBZEVXemdoZTFROHNmS2pxcEx0?=
 =?utf-8?B?YVNObWFtNGQ2YjlrNHNFaW1FR0t3WGsrRXU5Sjg0cHdZdUZHbnk0WlFrbStx?=
 =?utf-8?B?cXFlSGJRWEwrbHdlbFJHL0VzR2s4QzBBZG1sZkx3TDBMMWtCUSsrbTMvUDlu?=
 =?utf-8?B?Qk1DSk9KYnZWRERlZlg0Z1ZGaXU3cFZ4bC94UGRtMHB5K1VTSHYwakc1OEZl?=
 =?utf-8?B?T1p5YWk4amxONzc2bW4yRTVUTFFvYzBrSEV4ZXlyQXpPYVVKWVF0KzVVVTgx?=
 =?utf-8?B?MnowYk4yZjRqSzU2WCthTUV3ZDcva0dReWErc1hFcWdiU3NlZit6bmxvajhZ?=
 =?utf-8?B?aVJLRWtkR1ZMSFRuT0JObEN0ZFl2SjBBUE9iUjU3SE9BdkJuTk5GS0cvTEl3?=
 =?utf-8?B?MitLM2Z6QndtY0FIWDlZUWNFcys5S1RvOUJaRlBrZ2gwRmtpMXVTbWlVSVJ4?=
 =?utf-8?B?czBDejExYWF3NXZYd1QwZU5KaE8rSXpZc2FOWWs0TjJhTTFPRzEvdlRSbXZ5?=
 =?utf-8?B?UDVuSXFaTG9vOHZCSVpWaDhXZ3BUQkJKSnZCQVFaREFEUHBSUWhPOFowaGQz?=
 =?utf-8?B?aGMyYkw3UmR3UWpnbGNHNEc5MXhMRldCL3JyRnRycG9aWExCaU5IMjJBMHkx?=
 =?utf-8?B?ZFR4enhSVC83UTVHVzF0TzhyQ3pncGx5SndHaXZrZlhSNy9xZm5acjAyUWQv?=
 =?utf-8?B?UlEzYjVENUkyaldaRG9ISXpWUEhvOVlMaklPRlBLa0d4OEEvR2tWYlIweFZR?=
 =?utf-8?B?anBEaHZEWGtYRC9PZW9aMXdUUlhUZ3FjRzBRQ29nU0RxWndHaFZDeGdKV2lY?=
 =?utf-8?B?UlhwQ1lOYTV5Wi94bkh1Wm9KNmNTY2JPZ1M2ZE8rbWJQZWJ3T0xMK1d0bGxm?=
 =?utf-8?B?NnpSTzFHSlRudjR0YnpvRmtmQ211MmdZYkswMXA2V29XR1JGNXkzNDcvaTIz?=
 =?utf-8?B?L2tVQllyM3lXWVorOFNyQ2RHZHdWZGxZeVV1bUxZa3Z5Y2xIbnF3VFN3MFps?=
 =?utf-8?B?VFIycU9IbFZrRnBYWWppZnNqNXZxL1Y2KzcyeGcyUXRCL29Lc0xEUGc5SDNw?=
 =?utf-8?B?aFFjODRTMTB5cVdTQys2QkxYNmRXSlZGWXJ6cFVML3VycjJ5Y2R1aDFzNDFD?=
 =?utf-8?B?cUx3Zm1obFo4R2dIVS9raS9qYUpNVE05bXB1RmQxQ21HblhqbXAwSXA3YlBz?=
 =?utf-8?B?U2hlNjlwRVhTR21aS2JFVm95SGRSVTlCdTBNbUU1NUlqU093cWlKTUs1eFVL?=
 =?utf-8?B?WFZwcytHSE5xeDBKcnJING9DemdUNE4xeDRJcXJDOGk2dk0xb09IQkRrWmM5?=
 =?utf-8?B?QWl6d1FlSzdVa0szYk1nM0pqeGRGMTE1UHExMFRSak5iRXI4dW9HUkdibnVx?=
 =?utf-8?B?bzB4cnA4Z1lOUmFxMkpPc1loMlBYSGYxM2Juem80anIwQWUvMTFBb3RiTlpR?=
 =?utf-8?B?akF4bHp0QXd0OFYxaXZJdlpHdXlBbzRZMG91WGRLNDFSQTFvTXpjV0FueWhk?=
 =?utf-8?B?S0pJYUZlVkdlaXFsV1lPUHNaMUNzM2plMUllV3g4ckw2NFRKZHZhNkJXc1Rr?=
 =?utf-8?B?ZEplOGw5ZGpxNndhbXIxVUFzaTZyeW8yc3lUdEdJSmF3eWdGY2JsaXV5Q2J5?=
 =?utf-8?B?TEVMRlVqZk9vK3d4WVVLOGZuaTRKR3B5R3VuU1VYTEZIc09IS2VlT2pMbWw5?=
 =?utf-8?B?RHlUMklnVEFpaTJHaWhidko4SlZVaTV1UTAzc0lHSHFGcnpDQmNNT2JVV2Vl?=
 =?utf-8?B?WFpLUVN2elJxblppaUJNRGRuTXB0aktpbDgreXJzMHVqNVZNQUZ3NkRMOHJC?=
 =?utf-8?B?TDFQRWpWVU5JZDJUQTcvc2o5MGltV3g0eE9VcG05RUJvWDZrZmZhcUF4dWI1?=
 =?utf-8?B?ZitYSmxvRitVZVMvMkoyY1BDTUV4SkU1ZUt3cnp3QldoUzk0ZHowNGNvWDVu?=
 =?utf-8?B?eFl6U1hhS1RENVdEN2ttNUpqOWpUSkFqbEVBQ0N4OGErZlMydHVnN0ppazh5?=
 =?utf-8?Q?P8n3V7Zwow8qA+aj5iyoNStE1KzARmPvv8RD0zjoeZvXl?=
X-MS-Exchange-AntiSpam-MessageData-1: Si9oQ4WvgyyfjA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905dbdd1-2df6-4c0b-87a1-08def6e7731c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:58:26.3572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqvIgAICH1oRyLkdy7p2LSQ1MUvjFVQ4g3fUMO9DA5Szp65pwLz7vaN/6FNte3Ey9pXGEZMFQUhqUmM6C3XoJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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
index eddd5e7aeec8..f012bea2b5bf 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -87,6 +87,9 @@ fn probe<'bound>(
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
index e29e07488e78..04e1e30eeed7 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -429,4 +429,16 @@ pub(crate) fn new(
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

