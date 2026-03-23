Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20985EC01C9
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6774510E0C0;
	Mon, 23 Mar 2026 11:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BXxGhTY3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CEA10E0C0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGTM0otEubnM2ZMH9AgH9IR02a+k/YO3zS8T7JfpJQjWZpIzyGoQLsHUP554tE6yTZpdoFn/tP54n5vsCTptIQ5XFgcWHdbidOJEDlp9AmWAJ0JQzXp2TqpOb6lfbwY2jYFQqSaWbCIIl4ZhivT5l77ripZPsJKhgt9f3XvzK3JzD35S1v9AVOdfCWlX0F9ip17do1FmlDitnMuxkRtN9y2YjydzCwdFNf0H8T8cOwLkDG1zShzT01gIGxQVwg1nqr0lVBPvEILOvYfKR0XsIP5UEb6N5eulMERrJmQzhOX+6TeLh2AA0gVAGpeIGTboFtnkxpxIJ3H3F7eCq6GP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8BfMVLDW4UbsUtX4mnqmFsFSVXtql/vrHYu4xc90RQ=;
 b=uL6bDIywn27eocd3MnfluAU0Lh+Lk2LHW73sJmThUAH0YacW9/mjkeD7GgV9ZIFAiOZgjhnH+wPI//F2AUzMYuWUh7ODBzxskCSHBusrCD3zIm6Oo966HbrWc5WIkX6iJ+x4aH+cWZy3lKXAdB+9E0HZJwyPyvNvmQ80Lk+iUGX0QIGHtDie+fn8+X3zM955r1nEGsdF89tGa5Fy6ncZzofpIYqYS5NanN1b8p7qVipTD81dfHgFfNj1WDQhD2jYLGG+K0gIM47oJPI6lsN3PO5pt8su0QfBB4NYmOwQmEDfbMM1pXZeEUhYVuj9icV+4GZOMGeMw9ccxjz7tJTIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8BfMVLDW4UbsUtX4mnqmFsFSVXtql/vrHYu4xc90RQ=;
 b=BXxGhTY3KjHLjqB61ZQncgSIXboNxv7xaXFk3Qj08Rg1yPcqHkcn45VhlbQquJ/nNaSZSSdyoKkLFMMhMZqa9ol91zhX7e4luit7suV/dbk1PPbIXR5fk8ceFuw9G/YufpgMuf6Z17Icf3s5qYTVk1E/BwsBxPXokBpqO4YZOr2elonY4dJITrnLx9+CIotIxTBVpwDaDEDnm6ccwqZ1NNqAhOR5SGp4oo1sm+X+Dqfo3q7L3wRvdQ6YA+edUDKvhW5jaxj+SWvjGVT7RjT6ujubb7KjVWoHbJsP5OQ0zZd/onqRcg54ruqHHwjdxGtmAGHW/wynjB9sROnOkFhjKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 11:07:50 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:07:49 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v3 00/10] gpu: nova-core: convert registers to use the
 kernel register macro
Date: Mon, 23 Mar 2026 20:07:35 +0900
Message-Id: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwQ7CIAyA4VcxPYuBMhb05HsYD4x1Ww+CAUM0y
 95dtpMmxuPftF9nyJSYMpx2MyQqnDmGGnq/Az+5MJLgvjagxFZqZUXXiBCLE4lGzg9Koj1K2xm
 lrDEI9eyeaODnRl6utae6FtNr+1DUOv2DFSWkQHTaWOca3+pzKNyzO/h4g1Ur+CGg/CFgFawd/
 KCkJts3X8KyLG/WKNxT8wAAAA==
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
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCP286CA0176.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d4192a-d04c-4244-95c8-08de88cc6b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: l/IlKJxbzgAkLNmczgUpKJaJ6nQTruAfNae3MgIqyMO/CCtE7fwn0ZqmQg4T4i505Wzhl7nz8wx6SpgNVEhxfuBBJt/Fu9PqATXaXXgsiVsu2zQkXwPUXYRQ/wWhH4mHRdln0wlVm6QD4Ze7PH8e8FOR5UtJR5JYgiRpx9GhXByTKI22u9yZLgPTdni/I3zgXWCL1SQKRVyXPpn0NCfV9jNA31ZxltM7Qf7VGJRAVx0X4t1xzN3jttE8u5RW9ORzdE3lJYgw8SL8DuUpJx1xBo3w/HUsHQ7ZaX7CGEmtDxOSL5JFqeJJLEUcGRDWfiaJTLNU2yNFf2i+xGvH5XoCHBjvYjqeDrFDLInzVHuSCqzNSjnHYLyWGASLMwzdLdk/NySVeAbOM5m0oAfgcPJHkcNuDCrH+wswEJFNnsHXb0sbCLZfwNpffmt/mll2SeXVFEhj1I0nDkRl93n6hrhAT+J12SqyP4OK9KNa2hQYu7zZXAZrYNdxsKBXpGeBukl2kF2yZAcIGJSiZCjGXS/u7W7vx4M0M9XArZScMUpHbzfXC4IQBFWG+naBkmaZjRgBdEZ78k2efHWAbRNWZp9vIIAeCK9N+R0qmnYXBzb71OjjJbYAw582tBoD+RRzpwRakWLO47R5cHF6vAQUrSRUDYwipIFds7wVvMBva9Nm1IP8kM2maEzwn77XX6HkK212CYXJwujvWJHEJgTEt5FG3bgovYoOhZq4kbnCWK1ETxj54PNYsMngTHbZvCSgnkubj0CTu4Ig3rTTnJCAhXdXMFv7TYZkQ2XoQSPVenJqtyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE1hb2NNVStmS1cxY3R5c2tTeUZ4a2hMY3AxWDBRc2lwRUFWU1c3SkZxcW1p?=
 =?utf-8?B?dXRCOS82Q0t6VDVCbVVlYm1OQlNJR0FCTDJBMU5KT3A2U2JmU2lVQk9TbFJp?=
 =?utf-8?B?MmJXVGpFbGtpYjZSMGVwTEt5ZzZlWGxnVmpsS2pWZXJVMzUvNll2eWg2bEcr?=
 =?utf-8?B?aktTNE9EeDJYd0NYdXJKL0c3dnFETTQ0akExdzE1dEZOOHFSaXBJRld3Qyto?=
 =?utf-8?B?Z3dDOTdnV3k1K3loRXhFd0pUZjNrd0Y0anZpNTdYdGtEN2RncTZWZHdkTGhu?=
 =?utf-8?B?MTdrRTM2SzlUN1NCQ2UzakpZTElSTHh2MjlSaEU2dDJjVzNXdlJqMDNlQXpY?=
 =?utf-8?B?c0Fna3pIdGVMUlNHV0JRYkdxampYNVRCQ091cG9hR1lWRG5GNi9Jcm13WDIv?=
 =?utf-8?B?aTRpWnlxY3FzWDh2ckhMbDhqbEk1OTQxODhid3BpR2ZpMDhuVVVhQ1hFR3Zi?=
 =?utf-8?B?TC9SY1NZbTdqcUNTdlEza3g1RVk5LzV6SkZGSzB2NkVwY2kyN1cxNUF6MWxq?=
 =?utf-8?B?dVR4ekF6Ym1JVTIvdHJNSkVKanBlYTFuU0JBM1ZvRW01dHk3THJXMHNFUEhF?=
 =?utf-8?B?L3M0MUh0aXNJTlEzejZrQUNYRHoxamtqKzRvVkRiakZUOXRoRUZ1b0hmYkRY?=
 =?utf-8?B?MmZZNGg4K2VTR2FaeFkyZXFBMmk4cjlnNDBINS9YZ1c3U3BNMnFFSmRQVzIv?=
 =?utf-8?B?WDl3eDZZdDl1SUJzM3FRM05uZEVmajJzSnZGaG9zZHFPSXJvdGZ6cGpLU2xn?=
 =?utf-8?B?L0ZnNGdVdDF3MmxhdVUrSHA4OFNFSnNFclRUeGhCWHBBTnRRTllOZkdhRHd4?=
 =?utf-8?B?dUxaWFViR0RzckRPL3B2L01GaDh2VUEreVEzQzROM0RDNmp2RFRlYUFUTEdY?=
 =?utf-8?B?NGdtZGhXWURPZzJLdmp1c2I4TGU4MHNvYnFEazh1L3Z3bkE0MXFQc1lyR3NM?=
 =?utf-8?B?bWVOWi9oK0Y3bWJseHIrbFVGazNEb2tYbE1HUWwydmtRVjA2cERpemd6emlN?=
 =?utf-8?B?V2U4WFR6ZTc3aWVsVHF5YnRIRXBucGpTMUUwb25NT2FTKzZLc3JTUFhXZ2sv?=
 =?utf-8?B?ajFZbjd2S1VIYXpJd3V6TXh3NWFYS2Y2VVhvcFU4aVVIUXVMTUpvYUhWeDll?=
 =?utf-8?B?WE1LWmt3NktYZkQzYnJlTVQzNFJ3L3Z4V3hZaHNkbDN5WENjRG1pcUFwSmdI?=
 =?utf-8?B?b09BbnBFc04rakJId3E2dGl0SU5xd2t5ZERES1JUbWhNU2RBMGMzNzlseEd2?=
 =?utf-8?B?QzJUWThYWjhacDVQZ09IcWVRemVJUUxEWjJSUmtzeU5CRkJnQXJmZDFyYlM5?=
 =?utf-8?B?UjY3YnBwYWNrTlBsTElRbnZPQW9pSC9GdkdkYkQrcjNCdnppOExGUlcvS3pW?=
 =?utf-8?B?dlRaZHcxeUxJV0ZnRE1vM29qZVpCMGluNjB1b25aQzRLUnNtd1h0TnBjUEMz?=
 =?utf-8?B?cXp4TCtlTk84OUNJbEdQenpCbVVORHQrdkk3ejN6V2o0c3Y2UkVLQTN0VEVQ?=
 =?utf-8?B?emhOUHg0MVNlK01QSFJ5NUhrL1BFVm8xWHQ5SXk5b1JWRnVmYmFtQkcveW5i?=
 =?utf-8?B?RGxqS01aeDRId3BoTUlaa3NvZjdQM2hXbDhGRkpBcWU4MlEvNDlhMEpkMXFT?=
 =?utf-8?B?ODFEN3RRSEVMR2hTWTZISmNVV05HNjA5aGk3dnZqN2NCT0dMWnc1QjVZaVds?=
 =?utf-8?B?NStYOEYwczNYbmFXaGdoK1JNa0hkdExZNE5qOGVRWUlKVkpLU0RpWlhjbHBx?=
 =?utf-8?B?WWlBSlVVelJUV2NYa0VkYXlscjBzVmZ0UExrTG9uVW9WYlBkbGRQcm5SbmRN?=
 =?utf-8?B?OWdGZ3dENGVkWnhzb2FjYzJvaVFtdG5PdGMvYmhTbEVYMkJheElWc0wxME5O?=
 =?utf-8?B?b3ZsWFNFc2VNZFVjcnUxYnpWVXRnN0FnR1o5SC8vTnN6SkRFNStNM1RrUTYy?=
 =?utf-8?B?c2JaMnhvNEN3UTFRRHZoeWpFVzFOejMvUVQ2MUQrMkZTUDkvMjdkSVZka0FL?=
 =?utf-8?B?cm1Nc1h2SWhVcDVNcHhvbS9FUFJ2amE0VHFnK2ZUZHRtMGZ0dkdudWdRdUJz?=
 =?utf-8?B?MXcyaFBBZUFzVy9XSk1adnFTMUw3TlVLWUV6VzNid3lQcW0wZ3RjR0Y0TEFu?=
 =?utf-8?B?Y3VldDZVc2J1Umx5Qnh2dHJhMWtMWlB3NW9RSWtqa2NWaURaMnZWdDJ1cG5K?=
 =?utf-8?B?TkF0MVdyRURTdGtWM08vNVQyL1RUTFMwNEQvbzBnM253QThDZkRGMUVUNWdD?=
 =?utf-8?B?WVhTeFJvL2FqYk0rTE9jdTYzeEs3aS9JeTBsczhkaHBnRVVMS3FUelZjTThy?=
 =?utf-8?B?ckk2YW1OTVlHcDVZYzFsRHpuVW5PMFVYeFQ4K0JlM2ZseTlDa28zTVpQcHNZ?=
 =?utf-8?Q?dic917eaBCtYX1z1BI7hH8MScNnbkbDK8dpWY7/h89v2v?=
X-MS-Exchange-AntiSpam-MessageData-1: +bMLZ7GCLpEmRw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d4192a-d04c-4244-95c8-08de88cc6b3b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:07:48.9096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTnJ4E7EEl7SjKhfwbzb/ok7Zp6waomf7qACihQXGU+Dz5tO0i+4BWvKanutmD9dc9zvqKe0AtmnNxolZEsGBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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
without altering their reviewability significantly.

I hope to be able to merge this quickly so we can rebase in-flight
series to use the updated register syntax.

This series is based on drm-rust-next as of 2026-03-23 and has been
tested on Turing.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v3:
- Remove obsolete part of PMC commit message.
- Add { } brackets around const expression used in `Bounded`
  constructor.
- Use `MAX..` arm to `bounded_enum` to catch missing values in the
  required range of the `From` implementation. (thanks Gary!)
- Remove unneeded const asserts that are already caught by `Bounded::new`.
- Link to v2: https://patch.msgid.link/20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com

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
 drivers/gpu/nova-core/falcon.rs                    | 577 ++++++++--------
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
 17 files changed, 760 insertions(+), 1513 deletions(-)
---
base-commit: a19457958c3018783881c4416f272cd594f13049
change-id: 20260318-b4-nova-register-6908b5118552

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

