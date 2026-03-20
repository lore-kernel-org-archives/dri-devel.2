Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18924108B915
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620DB10E033;
	Fri, 20 Mar 2026 12:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="c87f9FbP";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA8210E033
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejMm7QWlApAVK8xGmj5gjGwx9vKxhM7DsBSswVSwyfL5PSz57vC/FkTRsFwLuBqkpeARs2T31rBccY5ZswK1bc9mrObprCHfnPGoZvi9A1jp8Zfpcv7L2Iwu1NMIWVwraIRoT4uzl5Z1X45P7SKRTGPt6hqOau0EGOuLNRf5DBVPnT3L2bocZPmR/kWTJqPNFMEsaMvW6tBpM20X565SaSppBFoxKjaI/uUVxlTzZLjslPHi3IrEYWa0eHEwehQmYN60WzwJDGdZQS/jJHMSQrlAJBXFuehzArBBgj6ootWpXQ73cplJT1XqfyfeGoFTGlOUrOGsoceADt5YPMMpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWvq32oEIykZiXK5buc9O03dxC3RH92ggNj7P4GFbvU=;
 b=ETKtgK4SFAfWNXo4mnWnuuHrFlV0Aus7zuR71lpF3VsLeJ2Xjm4F5uC1rz/PKcQ5BhbvOXSev4aJhomMi3s7YwV13sZGax1NB5z6V641dCIHgSe6AYOCaPvGzZnYFNnHuJUSQS4f316S0qnC7HkZuWGvaA/C2VSn8+smAoi1PPLiStSHZOvDQIGRyFS6W+wiOJWUOxtHDyNcKtelGzeXq/sTpYkLP1FqqnFwo8XE21NuasnK1cvGqbteZzk9c6KRvXIOQ7Nmpbtvo+PywuukCtMw0BVjOiXE5tKWOasiOzKcYYOo59cVWf/2rcrvNPDrifkwVRkTpK1SGwc7iFteRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWvq32oEIykZiXK5buc9O03dxC3RH92ggNj7P4GFbvU=;
 b=c87f9FbP1WpyXovFlDzTE8xpivoi9MDlv7yrECHCJZxbjTABMHzb+qvHhn4jA8dGKzKnWzyqqze8NPBsmwy2D4GL+Sc3of4EmcKnaX1bioLM9ZhE/wYCFNyardve56SEFraQu6/fmRyvON0bEInmoh01VKwCqbi8kouUjExrAifric5fYNX/EG4s+j6jt6GF4BOrU8kkQZvaaWKtrx15WXmRGGdOVS8KUsgJrX8zgm32OHN+ig8g5J+VzFaY74OTLFmdnswF1hh7ubju7yhAakuzPhPuZcdmDfYEi/21/Eo6i7q0QOoStuU8arEBcCc/ASu8RDmHSKMZhy3M4AE+rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 12:19:58 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:19:58 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 00/10] gpu: nova-core: convert registers to use the
 kernel register macro
Date: Fri, 20 Mar 2026 21:19:49 +0900
Message-Id: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NOw7CMBBErxJtzSJ/YstQ5R4ohZMsyRbYyEYWK
 PLdMTkA5RvNvNkhU2LKcO12SFQ4cwwN1KmDefNhJeSlMSihrNDS4dRjiMVjopXzixLai3CTkdI
 Zo6DNnonu/D6Ut7Hx1moxfY6HIn/pH1mRKFApr43zvp+tHkLhhf15jg8Ya61f7/AeabEAAAA=
X-Change-ID: 20260318-b4-nova-register-6908b5118552
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCPR01CA0053.jpnprd01.prod.outlook.com
 (2603:1096:405:2::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 30928ac6-5f1a-4dbd-da79-08de867b0074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Eu0PgjCAMlVfu3Y6GFlOR3YXTegrJXnws7VHGGT9ABbzm0B8scxc0Nl81dDCDmmzTXqdseUq2Iq2ljOHJCxNwMjjwkIAE9aRbTn2ItFDKdhgSODZiQTc0aVWs3dkaAXkzBfGUfAGu1Wym19kiMlLz/qGv5OhPXjAKkkeCaYESls6IqB6fKrnonCO8yfFcmudqsn2ebdQtNH4MPyBrM9bOrVZnoIdWvEfF395vou1k1AWhnyH3uTv4SHbb9qUryqXzgZVjJ6qI3tKRy2q9jnJpFPeqYX+4Ox/hG6o7Y2jTHVG3FLKvwhEKQ1ERxaabIA4t5ODZipVAbqNQZ3FC2v2cotrvzFG/4TQPAGz8eC416uEdSyW0dCtAT5ZVWH7XpBreshm4ee8SuxfsHxi9BnAp4481Wi7W+HklEPUN6mP/wLRXVZIeI84oEcU0XVsChpRQtxwtifMtSYmRZtTpmBeyBL5WaCn1sKVSYgPEkirBAvE1kQO7HStpVDst9y6t3KKGEH2Ypxu7hTKPsguAOSxOJvUN9knwy74j/6++IEsH0sjGtuRq7KM8aY8zGrqM0H8lWpuf0/MJsw0Kb7dzGaUBCEv1rL7i1RpRPY0oP3rBv/RXvxFQx2n1bP+v+jQbKAy8zqMYOq5a+prjcCz6TpO1/8WVnv/NG30p13m7IEIReFMw+wLna+I4SgZ3oHssGEUsTNxJXsfDam/WkqyKbP97XTIsq9VMrL+MfdRyCdE2SoViaCgFMmTMofWmibH+dKF1znIkf7jPohQzObw90WHdLZaNKrkibNHqjSVZCc5C6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUJDVk42VW12dFIvcDlaazRZZUYrMnV5cUZPL1VGclIrTGt6U3d2bVh6NFY4?=
 =?utf-8?B?cEc1N2ltbk9GWmJaZGEyN1Vuak9QWFVuYllOYlQzWmxQdjFIM2VCT2tKb2Rp?=
 =?utf-8?B?WXBEdFlpNFIwS2NqMUdsR0dKV0hxRkVYUmV1NHo3OUdaS0VHUWxIczJ1aDRp?=
 =?utf-8?B?aEVCMk4xdU84RWVVclNFVUtzSEczTTFWcTMrNXEyczhLTXlLUWw1QUd4eGs4?=
 =?utf-8?B?SktFVWZHanVoTmd4ZENlejI4Q0FkQnBHd0U4SlVoVEFQQ3lWR3hFU3k5YlJk?=
 =?utf-8?B?MmN4bmEwelVBRXk2YVdsVm5HMDBVT0hzaEFTYTVwM1pLRHdHaXljVWlJV0Rh?=
 =?utf-8?B?Ym43TjFMRG5ISWVxMnRUb0ZTa3RDdUd4SEw3dmZJSE4wVHBoaExGOTBVbGRT?=
 =?utf-8?B?dFNRK3ErZFhtNXU3UDk4a0k1MEJNeGZoMEVJOHM4OHVBVUFBbi9wWVpVa2FX?=
 =?utf-8?B?WE45MkVOejB3SEdvRHBlR242ZkZoa3VJcXhIeTNMekxsTXdhWmswQ0F5c0hI?=
 =?utf-8?B?cmFJeW9RQmUyNCtla0pMZlZ0OUNBbUV3Y2hJaFpWQlZSWS9mQkxrdXZUYkYv?=
 =?utf-8?B?eEl0YUdzQ2lzR3d2cEo5NUY5U2NmRmZFQ2lOSEZadmk2N0NnWnlVL2M5SFZW?=
 =?utf-8?B?MFFjZDYrdHBDeWtIZ1hqWkNxRXJzRGpub0ZIdXRYSmlvSnB0ZmwvQklSdVha?=
 =?utf-8?B?RmNlVlJRbjc5c1NJSzUweTVubHJhL2tPenN5eVhtZHpWNU1BYk1yN2FGektk?=
 =?utf-8?B?ZVJvQ1pWbVR1WUk3TXJEcFJGQWdzVHNKWnY0eWV5WmxwV3UxYmgvM05tOUhF?=
 =?utf-8?B?clNZbDlJZ2NxZGlCMUxGS0dvaHRNaVNLZGVaMk1oU3ZNV3NlditzN1pTY3pN?=
 =?utf-8?B?a0V0eWl5N2JKQldESVVUZmlldlREdE1WelFobzU4RlZVR1B1SkcycmlHRFVB?=
 =?utf-8?B?cEVlazRKMVRYaExLUzdyQ1pWYUsxcm9Nd1U4ZzJmZFZzNzVBQmpsSWVqcVdw?=
 =?utf-8?B?SFdLanJSalBKbmRQQS9iVDhKTllTdThQbm4yckFUQVQrb3pKRzBQRnlRQTI4?=
 =?utf-8?B?UmlYL0pPT2M1QjBqeTRVZ2F0eVlBdW5aWllURUZ6Z09HWEFjTmo5NUhEYkFv?=
 =?utf-8?B?QVl3MUNzS1p4citYdURyQWZab1dEOXlZZDhNc0hLeGZDdHJ1ZWI2NWw3a1FZ?=
 =?utf-8?B?ay9CUXNZc1JYUUZPK3BEN2RiUTBPZk1GdlZUSE9aV0s0MmVVNFJoTTNCSkNZ?=
 =?utf-8?B?VW0yRXlGN3hxS2lPRGUyZnZkKzhPNVFBM2h2YXdCVWJBNE9oYm1VOHVhaXdG?=
 =?utf-8?B?RERaVUxzaVhnY0Q5RTliRDZRTTJBRm5pZlpKckZIcFl2MWJEWFN5ckhsYVFN?=
 =?utf-8?B?R2tiWThDNXVhcVZuQUNDZ2hJLzZSS1FmYytsMXhaSHZIaXBRdERFS2lrOU95?=
 =?utf-8?B?a2RQYmpDVVBIcC9ObURLWlVuSGJtQTRCWGdoYjZGT2R1Z2hUZFVWbW5BZWZD?=
 =?utf-8?B?SEJKaWlwRVFYUzE5WW1ZajB6cmlpQlowZnFvUTRyaVUwUGxIYUxPc3lNRHg5?=
 =?utf-8?B?cmtFRXJTb0F0dmJkd1V3OVNuQVVwczNrYkpEd0dsUk1EV1gyWnc3VkFnVmx1?=
 =?utf-8?B?Tk1ocFdKL3Q1Y2NRTnlsUTJoOWdVSzBLUEJsKzdRTXJ6M2lwZUxwOEM1SnEx?=
 =?utf-8?B?amR3TldGa0FUYnNzVzdQWG41bW43L201MjhncG9KclNLY3lzMmFyWUVFN21a?=
 =?utf-8?B?MzZRTUFici9CQzZqcFNraVVUbVl0Y3YxMUtVUnZqd1M3dkdXczhRelRlanJh?=
 =?utf-8?B?NTkwMXJMK25BUy9LYUVkd1MwdkZFSHlJckw2RzRna2lpN0hJbUVteWdjU3ZH?=
 =?utf-8?B?Ni9QN3J1WlhzZTlSQkxVTGF3bDJ1T3Q5WXNZVmRqYUJ6UHJudDdPeGNNTkdX?=
 =?utf-8?B?a0d0UG5qRWdLMWdXeTVqZnJPd0tTN0JwVjdXeWd2NmdrSDFtb0kxVDJyWjRm?=
 =?utf-8?B?dTZUSGxrT2dlbmFMVmsxVGl5dTcwSUxrcVIvcVhPbk1GTy9pR1FpMkxrSUkv?=
 =?utf-8?B?MTA4Qjl5S2RPcCtXazl0U1BoMTVoNC9XbzdsVTRwQ2hDa1BOU0lldkNnV3d1?=
 =?utf-8?B?b1g5Sm5SZ013TzVjWHhkVzg3R0RxcDZYdnRNejd6UUJ6NkFhQmk2QUEwaGY0?=
 =?utf-8?B?YTVZcnlPNEFsRXUzb1k5ODh1ZmZmWmFoeTRTaDEzb0dSeEFwMFZkM0hFSTV5?=
 =?utf-8?B?VmJNbHZFZ3V5bnd4b0tMK3JzaWJJY1ZUZDlsRklPenZwOWlQNVVXeTBRT0Ry?=
 =?utf-8?B?cDhwcWJBRlBMMFlaN2JnSXB1Z2RpZlFUUDdMTnhFRzJMTG1kQVg5M05DdXg4?=
 =?utf-8?Q?vMmC6knGwl9zB0OR5SSomjrqdndaqETemwyjdbBB5NFX5?=
X-MS-Exchange-AntiSpam-MessageData-1: wjxQ5Pxv61IkGw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30928ac6-5f1a-4dbd-da79-08de867b0074
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:19:58.1398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlwPGA735ABtAQoeYx+L+P3cSjgOMmuRFp/cVNx45xxJM2MjIY5fg1wLJvaKF9HKU0ZKK7nAt38dUOfPBOPVUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
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

nova-core carried its own helper macro to declare register types. Its
purpose was to be temporary since the beginning, and to serve as a
testbed to develop an equivalent that could be used kernel-wide.

That equivalent has now been merged, so it is time to retire the
nova-core local version.

The kernel register macro has evolved into something significantly
different from the one in nova-core, so it cannot be used as a drop-in
replacement. All declarations and sites using registers need to be
updated. No semantic change should happen as a result.

All the patches in this series could also be squashed into a single one
without altering their reviewability significantly. Actually I am
leaning towards that option since it doesn't make much sense to
partially convert the driver anyway. I'm leaving it in split state for
now in case this drives more people towards review. :)

I hope to be able to merge this quickly so we can rebase in-flight
series to use the updated register syntax.

This series is based on drm-rust-next as of 2026-03-20 and has been
tested on Turing.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Reorder register fields in descending order.
- Drop `nv_reg` macro and use the kernel `register` macro directly.
- Make `FUSE_UCODE1_VERSION` registers return a u16 directly.
- Use `into_raw` instead of accessing the inner value of registers directly.
- Use safer macro to generate the `From` and `TryFrom` implementations
  of falcon enum types.
- Link to v1: https://patch.msgid.link/20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com

---
Alexandre Courbot (10):
      gpu: nova-core: convert PMC registers to kernel register macro
      gpu: nova-core: convert PBUS registers to kernel register macro
      gpu: nova-core: convert PFB registers to kernel register macro
      gpu: nova-core: convert GC6 registers to kernel register macro
      gpu: nova-core: convert FUSE registers to kernel register macro
      gpu: nova-core: convert PDISP registers to kernel register macro
      gpu: nova-core: falcon: introduce `bounded_enum` macro
      gpu: nova-core: convert falcon registers to kernel register macro
      gpu: nova-core: remove `io::` qualifier to register macro invocations
      Documentation: nova: remove register abstraction task

 Documentation/gpu/nova/core/todo.rst               |  76 ---
 drivers/gpu/nova-core/falcon.rs                    | 582 ++++++++--------
 drivers/gpu/nova-core/falcon/gsp.rs                |  27 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |  70 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |  12 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |  17 +-
 drivers/gpu/nova-core/fb.rs                        |   6 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs              |  37 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs              |   7 +-
 drivers/gpu/nova-core/fb/hal/tu102.rs              |  17 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  19 +-
 drivers/gpu/nova-core/gfw.rs                       |  11 +-
 drivers/gpu/nova-core/gpu.rs                       |  37 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |  11 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |   9 +-
 drivers/gpu/nova-core/regs.rs                      | 601 +++++++++--------
 drivers/gpu/nova-core/regs/macros.rs               | 739 ---------------------
 17 files changed, 765 insertions(+), 1513 deletions(-)
---
base-commit: a19457958c3018783881c4416f272cd594f13049
change-id: 20260318-b4-nova-register-6908b5118552

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>

