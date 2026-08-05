Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC095C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8628510ECA8;
	Wed,  5 Aug 2026 05:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fg3qpCah";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C532810ECA8
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMUngYWj1Tp1OHFvWJNDcdLd77Ekn99yL1zs0Ymxms1iIqsj5Jxe6WQ84m/urJ3Zf8XtJeWShIRhq553VHNjxbglH+9nx2vaVfIRqE40rj5a51UWmX9WiQyk324ZZIow7LtfZus64y3ersO5OmbSYT5aDoUSlKLhUlK1EvBbi8Q5F9TZbiKbVU1SeF3/t+dyLicWprichf7qecWYNCekRwNYrGN7pYwk8ZdWS/ymBLWB8qAC7PRsiBZQSfOjATO9ha/lKWlcbS+eRVlYnr7tx8rY8RxtVURU9m3z4foQmkM9vv1tArDIqRt+qxY2dcAI/TenTtQ+hmcV5DbYRKiNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Me+n0FksMQOS5OcfszZir4AwvdtrSn6Fm8gbv1ncTM=;
 b=q+jP+EMr/UGv/QjKbrXHYoGoyaJWrxWviq4D3Bqc5qZWvbCIUpL9qWaMmh2cViLJX0WNrZi7OfaZVPAWudUMXyDIYo/ajn85U7dJMtUISua1Sk0RXJ42AkUO5+B655A29Tf8iUCYYM6SN00rFWo6l+87iLsuw0gyk4tnfyLK7zvLbHyrUQtgt727VuhGkFpRKxmUyx6r02v+a+O75Q4lg3z20uSOL88f+J6RrPhUvg6GrciKDFnZV7AnvKydJNbmXbzDYit31YzR3CeyUap3PkvF7UwDbWUgMSnXGlaCYfbOgfAVVzKVJpha/XywgVX5Cz83lg80/STfbezUKsWuRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Me+n0FksMQOS5OcfszZir4AwvdtrSn6Fm8gbv1ncTM=;
 b=fg3qpCahXXan7+Olzbs0Pweb8363bklAJdVJ5MV2Hs22atPiw7UGItffufrt9NQZUyYNiI7PwNl6KXOmNM0PK0ggcu9zNJcl3cvj/Y8VZJEgUpiDmC8o/f5RdC5KWduf5GPGHlSozUfe5F81bcFSoQVzW4DYmBnC7sF2X138RjpTijedkslkmDr4Ubm+R55OxUQ8IHUBlt+psms+PG0GOLA8xC0T+WF4ex8uRdxhMjYsfMdJSiKkd6EwmGDNWqiBPW2OkVAys/M9JtL+dhIGw3ydd66AbwZN734DZNSlIGQKk/5r0LLu/y6Ig+iziUN6CqF/VuYXy07lJKm7mOKRbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:06 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:06 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH 00/12] gpu: nova-core: add PRAMIN window support
Date: Wed, 05 Aug 2026 14:44:47 +0900
Message-Id: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwMT3YKixNzMPN3igpzMEl1LU4NUI0ODJLNU4zQloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAEd0VTXAAAAA=
X-Change-ID: 20260804-pramin-split-950e210b6e3f
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Yury Norov <yury.norov@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d2f325-a05b-4f96-4d89-08def2b4b440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|3023799007|10067099003|11063799006|56012099006|921020|18002099003;
X-Microsoft-Antispam-Message-Info: Von0udgR5Dyzacn3BNbOgW/hkbbTQq6lId0vfkYiAt2lqmMds7hD+XIrvOeUcrudxW4oyb64MDyqox3mfDaB2hMULv4Mt5MddI5U9nOwdOguHhdv0BEHYK4SMGcYlyHlSzm+2O5+jk5vM6OJLt8CSon3pMnGYwVnyU2+vlKYVUFfKg1ReUB89GztqFU09CCazNO0Ff8Rk9rVxWlTDpvtyrEQqUnvwr7CMEusbALwsD9oqushEtPvTEE/Ul49NsLlp23dn1Qf52IBgS5p2nIHFmSaIxWn4EEmCt3eppiusLemUU7z2TdHa23nFtXB6CFYkd1kqitwmRkDSwmtN7BB9N665JHcb9PF+0/KnNmBJnYt09rsFL4Oyu5WbTmUnxUMQW9e9GKb1fJS1uEw8lJYrYr1CBZijdXvQOVrCegaoLy0HZd5EJgZpWRcwW14xw14WQSpqiICLgoYKGMfYKeXTsnSZ0pc9WtXbHu38ncwsNFTE1cZ2gk6CS59YT6k520ot73K1PuOcTJ0tgqxcP/46c4L4WCIikAdI7V8fjpWsP1jR9QY004BL25NyHP9J4EXWWIdeC0ZeafzF7AdLK9HpcBPlQMhyj32JRR6uHdzVNBneqw9sv4QzECNeK/zmQcJeHDc5ISQdKEQ4LdZt0xfkXWRCnvfDqZ4/5vRJLbv5W3KuTnfumt4wjIm13hGRTAooDaIg3wQrHu5IiBTCdr6Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(3023799007)(10067099003)(11063799006)(56012099006)(921020)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJJRytEcmV4K3Z5WmQwNSs0T2VTSWUzSVFiRmRSK1JIeDZzN1J3K0pscmlQ?=
 =?utf-8?B?c0J3dkx6NXA2TFRDQ3YzenJ4Zm8rRVFxMWZMa3hJSzhGNUY3U0pqNCtQQ0xx?=
 =?utf-8?B?YlpYYzhiVjBYVVp4bFFmVktHTzlRRDlQWTc0bkVpYVp4TFNLN3FkT2d5eWZF?=
 =?utf-8?B?bEp5U0J3RDJVeGh5cHFtTHg4ek04Y2NxU0dDeXBxUDBBeVFpeWVhcG9PN2wz?=
 =?utf-8?B?U0Vkdjl3a0x5RmlmNEM1WW9yMis4b2NpVVl5Sm9nTWVEbW13Z2pCL2Jtb3pP?=
 =?utf-8?B?RzlrVnVzb1dDWWNEMzgrTGplSG4rMlpTYkhFR1Z6bnl2RUhlQ3plME5QRlN2?=
 =?utf-8?B?T25DQjJyN1hSelFaUWZRYjE1R0lUS0YrSDBVbU4rSWZucktqcTNFVGJSMTlr?=
 =?utf-8?B?aTdCaW1qcHJvQlIrcVNvbC9HcnBmRGMzUTRYSyszTWY0YTYvR2YvdDh4aXJa?=
 =?utf-8?B?Q1dkWGpGOS8zSjRBN0daV3R6bUxUL2Y0bU1SVEFjNXQrWmNLNGhocFl5bi9P?=
 =?utf-8?B?eUZsVWswOHRzWUNwaHNDK3FheGphUXFBc3l6VU5zTHUvM2orYXJQZkdOWm1o?=
 =?utf-8?B?dk00b0ZFWFM4QkMrVkNTWkgzTzh1bHlrZTNkOC8yenN4bWIrMHB3WXBsS3Fh?=
 =?utf-8?B?U3VYdGd4cy9qcDN2UDQyZjMxTnlIN3JHZ0N1ZTFHSEZtMUpGak5XWkcwbFF5?=
 =?utf-8?B?MVpJeUttM2orV01WZWl6NkduRE94dmY5UkxEYnBYdGhTalh0ZnhGa3dUVzNa?=
 =?utf-8?B?ZHJBdm9OUy9nS2JXV2I3cUhmUTk3eExGY0FXUGJ2RTV5b1hZRWVXajdUWnZS?=
 =?utf-8?B?NGw0azlPWngvMC9XWWlQUlNVVnB0TVJGcVU1RERZUkdENXArVVJwQmo3Y0Ny?=
 =?utf-8?B?YWRDbjhUMmxLbG4xb1pXZFJVVXlXbGwvRUlwSUlHdHBKQnY5STV2dkFyVjI0?=
 =?utf-8?B?NFZ6dldtVUJ2eXZhMmxNSkRVcjQrWUZRc3c4cXZhODUzRDd5bTRzcncwSmR3?=
 =?utf-8?B?cVdnOW5VOERVRW16bCtCUTNPSkpWUWxoVnRTQlNVclRRcmhJMENuRG1DVUlh?=
 =?utf-8?B?TXVkTmMwVUY3dGo4N2xhckU3eXk4dXNjMHZoaHlkSSsveEFTcUZLTS9PWE9t?=
 =?utf-8?B?VFd4WW5EUlBrZ096aXZMZUlQUFByWEVaQ0g0cWgxUmtGRGFDcFhGdFhtVVU2?=
 =?utf-8?B?cjUzRDltcmp3WHdmaDRDc3F2dk9RNDdWS1AzTG11NTBXa3Bsa3Q2Y3dvZXN1?=
 =?utf-8?B?VTJqOTQzeENnOEx3MVlRV2N2V2FkNFFkcE1xeG1CNGNTd2dnT3dscXhCR0h5?=
 =?utf-8?B?Y1JKdmVSa2JJazFMVWFJVTk5Q3c0UXBSMm9ZWFZjaWwxVkcxd3V1TElpS1p0?=
 =?utf-8?B?L3RCT09RTXhoZ0g3V0EwWDlwZi8wUndkOFF3R3E4T2sxeVoxSUlzaER3MHNW?=
 =?utf-8?B?Q3ljN3NJQXBFaHUvOEcrTTJuK29EdzUydjdGaFhlaEc2UFJUVCtvVmhKMVVn?=
 =?utf-8?B?YmpoOU11ZGRtajA4MTdqd0NCTlM0d2szbGRYcDE1MGQ2Uy9XSTJMbHFQUllG?=
 =?utf-8?B?aFN0clFOWG45bHY0dEFyMWdiS0JUY0pXN3IzWGhWR25LZmRuQUFndFBjUDhu?=
 =?utf-8?B?VmxkTmFmZGVid0Z5YkFzQi81NEM3ZW9FZld5MmM0UU1RZ3BRZElYcGJTMzEr?=
 =?utf-8?B?MWZzcUtYdzVQMEN5ZnJFeU1rbDVhYmV0Ry9jcDlGMGZKSzZGajFSdS9Vck5M?=
 =?utf-8?B?QVFyWW5XZVRPTjNzQWZPOXZYZTVGVEJCcGYwd2lXTThHMXJWOVJkRVl0OGUr?=
 =?utf-8?B?dHRYVWcvWDdsYWR6eHJZN1NxR1o1MXFaaXoyTEUvNnppNlViV1h2OWt1VHda?=
 =?utf-8?B?dHUzbU4waUpmOEVSd0IvOEhSYWJ6Rlg0dGdvKyt5bGdOV2VEY2lxd2xqbUEy?=
 =?utf-8?B?VnB1Y2JxeEZvT1lmTTRrMkVlTytYS3pnSHVodVhIcDJzOGxzS29odE5yTEV0?=
 =?utf-8?B?QnJsUFFNTkJNWTBiVEpKTjdKM05MYWx1THRlcHNmMUhvdk5nRXdLTnpQdk94?=
 =?utf-8?B?VmY5SnJ0V2hkQk0xNzBmRFdEZm1pUm1Qa2FvZnVFRDgyeFJ4WWRBZGNVMjA5?=
 =?utf-8?B?b3FsSHQ0NUZ5NFJVa3l4ckVSU3VCc1VYOUNIejNQNHlleCtWRXNRMzFScnBt?=
 =?utf-8?B?bVFQcWUyQzZGWmZJLzRwcjNKMGhBbnJkZk00MkFRZGw0R21LOFIrUitXaC9z?=
 =?utf-8?B?dXBJMGE4K01uL1lOYmViUi9ZWm1ES0NXd1dXL3JJMGxUSXNxRnRxWGJvUGFx?=
 =?utf-8?B?bjFoTFR0RU03dUpFdDVKYU9XT1Q2UllqQVpoTTdMZzhRQ1J0dHlyaTVtbzRV?=
 =?utf-8?Q?0xhppaJTq81t4l6uCS0AUFR8DkHa1L1IAS+voNA965ZYe?=
X-MS-Exchange-AntiSpam-MessageData-1: n0XUT10uznNVZA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d2f325-a05b-4f96-4d89-08def2b4b440
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:06.6419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xk6ew58ZoURK+m461uDXBiBlt4ChAQ3qsJFQ66KCDxQDUoRm498lQ8Qu68XCOKQmED48htUPZHRFmF3LT10myw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

This series adds support for the PRAMIN window, plus some documentation.
Some of these patches were originally written by Joel Fernandes [1]. I
have updated them with changelog notes in each patch. For example, I
updated them for the newer IO machinery from Gary Guo.

This series adds a Pramin structure which deals with updating the PRAMIN
window and handing out typed MMIO views. The PRAMIN window is a method
that lets arbitrary VRAM be written over BAR0 by configuring a 1 MiB
window through GPU registers. That 1 MiB window can point anywhere in
VRAM. This is useful for bootstrapping e.g. GPU side page tables.

The Pramin structure hands out typed MMIO views to do writes through
rather than letting callers write directly through it. A follow up
series will add support for GPU side page table entry writing through
this mechanism. This abstraction is important for later since we will
eventually want to write the PTEs via BAR2 not PRAMIN - using a view
that we grab from the Pramin structure can abstract this out.

[1]: https://lore.kernel.org/all/20260518180342.2387845-1-joelagnelf@nvidia.com/

This is based on drm-rust-next.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Eliot Courtney (6):
      rust: io: add Region::try_subregion
      rust: num: reject Bounded::shr overshifts at build time
      rust: num: add Bounded::shr_exact
      gpu: nova-core: mm: Implement Alignable and Debug for VramAddress
      gpu: nova-core: mm: Add the memory management HAL
      gpu: nova-core: Add self-test assertion macros and config option

Joel Fernandes (6):
      gpu: nova-core: mm: Add VramAddress type
      gpu: nova-core: mm: Add PRAMIN window registers
      gpu: nova-core: mm: Add support to use PRAMIN windows to write to VRAM
      docs: gpu: nova-core: Document the PRAMIN aperture mechanism
      gpu: nova-core: mm: Add GpuMm centralized memory manager
      gpu: nova-core: mm: Add PRAMIN aperture self-tests

 Documentation/gpu/nova/core/pramin.rst   | 128 ++++++++++++++
 Documentation/gpu/nova/index.rst         |   1 +
 drivers/gpu/nova-core/Kconfig            |   9 +
 drivers/gpu/nova-core/driver.rs          |   3 +
 drivers/gpu/nova-core/gpu.rs             |  30 +++-
 drivers/gpu/nova-core/gsp/commands.rs    |   4 +
 drivers/gpu/nova-core/gsp/fw/commands.rs |   5 +
 drivers/gpu/nova-core/mm.rs              | 163 ++++++++++++++++++
 drivers/gpu/nova-core/mm/hal.rs          |  56 ++++++
 drivers/gpu/nova-core/mm/hal/gb100.rs    |  35 ++++
 drivers/gpu/nova-core/mm/hal/gh100.rs    |  35 ++++
 drivers/gpu/nova-core/mm/hal/tu102.rs    |  37 ++++
 drivers/gpu/nova-core/mm/pramin.rs       | 285 +++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/mm/regs.rs         |  57 +++++++
 drivers/gpu/nova-core/nova_core.rs       |   3 +
 drivers/gpu/nova-core/selftest.rs        |  64 +++++++
 rust/kernel/io.rs                        |  31 +++-
 rust/kernel/num/bounded.rs               |  31 ++++
 18 files changed, 975 insertions(+), 2 deletions(-)
---
base-commit: 44e7e7f7cffb10a93bb88e7cb59b7b8b3e2deb1c
change-id: 20260804-pramin-split-950e210b6e3f

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

