Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40693C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4E310E008;
	Fri, 24 Jul 2026 06:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="f4MryGnE";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B5210E008
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 06:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xy7dh/lTKQGBt6ogcLSjsTDc7B++8engcUhG0taQkBiBX+el01saD66Qt5WG4RCTRDc3dD/RmLgRp54dsPOgpRBV4ipP+FHwDP7bPJ9Djd6lKqj5iyQA097FhTfGNnfwiBSjc946BrbcexkBbElPpcrCKrNa72zcsrZMIFMJz4APgiLc0KTaREQRT6BfNJUbVQ+J/5ZKhMAWTsxMNIHcOLxDaoPSUl/xlDUS6OaWpmj3kg6dwXaQuL9IOCUdxI6TvSjnARb7ZPRzo5+jMVNsvUBYDsSGFvLKpL5z++KT2cLf9o4CnHhFQfRwKkqxaZanh5ZKOf08pKdvCmXVTrLqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8xe9P6d12cKHXrFDS1KbuDMMNCaP/mi3xPk4x6dE88=;
 b=VIdkzjFeMo+oQekFbzsCLfbcnwHp6CN/o22CeWgdE8wIkx8hzP+6PGkSChZMCpIa+t4RyXDnJQL0zH4FN9zTiV9p5cTyDoysMXOATUlHXz/G44kieMmEkJHN7vn5Gz96uvnu3C+sYAKqz3yHdcJzpPPHwM903xVQnmb4k9E3ZcYKYJqXrKl205mULJFJpF1MyCTjPIq2LQw9cm8xS/qdpfLNi8B4qTmn0gv10WSOQjaUrUGFZ9xriMW2stGTEdUSTiT03jYozTu+O1uRgadnNjIOetsThxcEHK06tSmaeckEx1z1TEfobshMD529fznGIko0V/SGJc/9x+T40ULj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8xe9P6d12cKHXrFDS1KbuDMMNCaP/mi3xPk4x6dE88=;
 b=f4MryGnEIA78kt/57QtpXl7yFVlmAZzbIxNF/UgB3/qTWU34s7hLZfYJf4iCr9hhvt1hs78tvCHCpKWw7IHjPpTFPOI/UbRitH0EiZzIRSgoS0hbtRpQo+5v3MK/vqW53UWD5NQS6eGWQz2Dnz+1nh6hyoDJJdw0+pz0FFIknDYx+wAmyRDZU0NK1s8ishfwJ7LAe9NwILG7P7x805fhPhisUwjTPoii2Q4XuboJwL3rSOiX34YUJSH/z3T79nHFCxiLVXIfZDiwTuTN9fDMe5JK2A+Ad0g18wB+++77HLA5FARmYuttMHTF+yS8DUvQ5/5cDYN6JpukE5kGuXkxXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 06:56:32 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 06:56:32 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v3 0/5] gpu: nova-core: blackwell follow-ups and fixes
Date: Fri, 24 Jul 2026 15:56:22 +0900
Message-Id: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XPSw6CMBAG4KuQrq0prUBx5T2Miz6mUkXQFqqGc
 HfLIzHG5Z+Z+WZmQB6cBY/2yYAcBOtt28TANglSlWjOgK2OGVFCc5ITjmUt1PUJdY2NfYHHjKi
 SZVyVRBAUp+4O5kIcOp6W7Ht5AdVNzNRRWd+17j2vDOnUt+pp9qeHFBNsKM8Y7EpjCn1ogtVWb
 FV7QxMf6BcoCPsHaAQ4MM2lYlTK8gcYlwMdPPr4ebdePY4fvP9VcxcBAAA=
X-Change-ID: 20260608-blackwell-fixes-30c9358c90a0
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0252.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acfb0a7-37d0-47b4-85ad-08dee950b17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: SKJ1NarUkWJ9+SeMgvi8zDVYR+SPUQHkKyfi8lfEsPWmRjURmug1ql2uokeEWZSIIJzt23ibOJKN2BWly92JPOgbbm/r9Zj+cI4IxOy6qbmwjWvHseJjT0ZMaMGB1G81q/tScPoiYi4Ktbk2UvjzSvxzGXB5ZDYN5Zte72N+SOD90YHIdnDkWI4CCmqtAabFx6VkK7bb6Bxygzr6WhCMU/g1DVjKtmkLMGzEMJUPEXoGu3jUhUGrW9qZ0swQxXKoBNEYoYB1cJHzKyR23+6we8TZQhLqBg09XlDiUyMTJeI4K3XHzkiugBH/TMuF8Od6T0qXmxrbRIkcGLWuFuQwZKPhOU9Lm73VT15QLVSU9Kx7/QSY9nzVb5HyziXFS/2LLUvOvx/PQFxyJFnngEAi3bDZ6mv7N0FsxVqr04MMhn+sJgbtRtMGtQKNVo3GK7zTy0SDbXKRrFS/VqTvtEGOgmScnEtTSMEMzhrPSbIlBfzT5M2/gp0CL1bD49n2j99wo+f2Ixhib3zn8pA9sj74vnw/FZgVv5YcGZUYzrDXQh+2nr4C6ywHXeDKW1Myu9CX5s7uo3057cSc1kxJwBlfsqlDN4wuvdr520+ZVZm/XchaMyTzCAq8Z7BnVvMIAXEBzM5e0aiSo8XMy11T+jfHHrLEr53fEl5oSJu1mItUfyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWloT1kzQ3c4S1YxOUFwZ0dSTFkvMHdvcEE2L1ZoNUJCNEtTWWZhSElZTzhp?=
 =?utf-8?B?SytMZHp0d1VaVTFJbXNqMFZwWWNPVGVmaHoyNVRiMFZhNkdkTUpCSVUveGlo?=
 =?utf-8?B?MlBRRThPcHEzaVJjRWNRNkd2WG5uMjU3emcvRGduZU04UVFKYy9uMThkNzc2?=
 =?utf-8?B?cXZ5bTI5cEI2MDNHbXhyUTBNaVE1SFpzcVVXSjJ2aHRVK0Rrd291aGEvZnl6?=
 =?utf-8?B?U2FOTyt5UXdWMXlDZG5qZkFkSmlmbzB6ZkF0NEUwRno2OGtqS2VsVXEvWTBF?=
 =?utf-8?B?eFBnT0QvUlczVDNRcDM3b1Yxd3ZuYjRpV1JuV3BPUy8vWjB3cUFiWVRaREhu?=
 =?utf-8?B?ZUNma05keHFSNWJ0MjBnVDFzc0lhK1ljdmxlajQyMHAxSEVUc20wdGZFckkr?=
 =?utf-8?B?Znlra3FqOXVKcWpKM3ZOeXUzTjRvMXRqRm5kVndrb2lJY1RxVjdMbVZudjhF?=
 =?utf-8?B?Nm94ZzFucFRzWmpJcXJOYmVMVDhrWTI0WXdmcE9wSEE1ajdFTzBwWFJlajZF?=
 =?utf-8?B?MGtLRWtlMnJONUdUTlNBTE1XWjNnM0NKWEtRV2N0bDJKSVh5MmhxRzUwVTZC?=
 =?utf-8?B?SHdQRm53cjFzcnlRTEp4Ti9mZjZ0c25vQ2VxeUJBazRtVHExdDFYOXQrbnZi?=
 =?utf-8?B?WnljU0xxcXNScUJ1WjVvNVp6OVA5ZGZiVVAzWStjajVvUWluWjVYSHZPb1o2?=
 =?utf-8?B?bFFrSFpobjVoRitFR0d5Mnh0c2VGbG1Ya2laWTkrL1A2K09kMW9hRFFQQnNr?=
 =?utf-8?B?OHhSV2NOS2JWZGFNNUdqUkZDVTNHYnhLSWZXemNrMkI4cTNLRmh1S0thUzQx?=
 =?utf-8?B?VlZrcmlXUVZ1QWwxOHZJMVYxTk9TdWFkLzhxbGVoTnE1NThSb3BuWEh0azJq?=
 =?utf-8?B?OWxvdkFTYlJTY1BRaHJ2SEsyMXBGeXB6RzJ0UGdHeXFKNGNRazhuV29ZeExj?=
 =?utf-8?B?M1hpdUNZdmN6d3ZUQzhzMEhQOTdKakgyaTRTcjJjVFJVQjdKRmZEM1RIN2du?=
 =?utf-8?B?OS9IeTR1RHZreHdVZ3lDU3FSZjUzYUxrSzJCc3IwTGNYUlpnaTBTZFdxVzhy?=
 =?utf-8?B?S2FBdTgxWXJZWHZKeWpzZEZ4MjZXbUdYUXhQNjBDdXRVNWNDb3RURG5FQjJG?=
 =?utf-8?B?SHpzUzc0R2hQWExaMmpjNlZlQ3FJQ2I0eTJ3eTU1ZkthYTJIZGxJRGQ5Qy9F?=
 =?utf-8?B?dlNXZVp3bkdYdC95NGdocGEwMnc0OURjRHpHbFRra2U5NUdSVW5OaEZRS1dy?=
 =?utf-8?B?eHFoaEpPc3pzRUVrUkZYQTMwMm45dXZiRGJTdkFSSWs4bVBSS1hBQnlTM1Fz?=
 =?utf-8?B?a0Y2ako3Z2JtT2hLZzF4cWZVZHFobG1PSnlUQTNRSFp2bjZDWjJuUXgvcHpr?=
 =?utf-8?B?ZkRaVGE3RjdvVm9LWitnSW9GeEIxUHFEc0lRRmJLcDNPaFNUYnVCNkI5YldC?=
 =?utf-8?B?eWk2SU5qejZFd25KZ2xhWDFmSlEyTUp2RkxBV2V1Smg3NUdqOEhIZkhQNDZh?=
 =?utf-8?B?eTVsRlI0NldscU80N3pnRFloeVZFcDlLbGJlbVpCTmZBekxWclhLbXVFVW1D?=
 =?utf-8?B?bndEZHJLMUJidjFyWkpwNXhNQ1dHSm9sUE5wOHZxUFlMZEgweEFucTIvVTlV?=
 =?utf-8?B?K3pBcmpMMXNBcEVpeEhQd1JDSExGOXBjUWhMSzZWeWY1QWwrQ2EraTNIYUFp?=
 =?utf-8?B?ZnpjUFV4YXU4RGxpc3N0dDFRY3ZRL2Y5UTBIL3dwZjRKY1QyT2NSVDNlSzl4?=
 =?utf-8?B?YUtTUkxBSitwMmh4SFA1YnVwa3FUUFZNWXovelJSdUhpb3BiT3c0Nlg2bVJa?=
 =?utf-8?B?UzRnZ1hyT1Q4b3RLcjQyT2xvSkJFZWVMZ1UwUi82QmY0ZW5HYUlCalZXMXhZ?=
 =?utf-8?B?bHluaWhmRURaMzF1L3FqWnVncVJlL2MvblBRV2ZGdTJYS3Fwenc4dGJ3cWZH?=
 =?utf-8?B?RGF5bnlBcW9lY3AyaFUxM28vR3ZlMmJXeXVCLzFCQVl6YXd4Qm9jYjhUV1My?=
 =?utf-8?B?QmlTY2xWNnRrKzFLRVcxRG1xWmltNTRXMFVONHA2Q0F4OVE2UGtRdFYvaXcx?=
 =?utf-8?B?dU9hN2E5cVZ3aitQdUs3ck5YU25lcm5YanlaVWtneXRmclFYS1FNRlB4ZGMy?=
 =?utf-8?B?dzI2ZEFmVWdNa0FkNk9ZNk12KzlBSTl2ZnQ0NzZzRzBRa1QxNjl0MmFOdFJm?=
 =?utf-8?B?aFo4c1BFdDhaVnZxSkd6VGVrSkozMmdJRVZVU1phZFZobXpYc0pJQlpieHht?=
 =?utf-8?B?UFRPKzFibGg2S0JTSVlNMG5jaElzWkhsWG9OZktHc3ZTNm1yc09rajQrVEdw?=
 =?utf-8?B?WlNYallsMURIenQyaUNJNjArUmJSYnpOcHNLT1hVTlJOL0N5Sm1oYVBYeUhq?=
 =?utf-8?Q?sf+x2ws2+H37z7qBukdkyBhZ2g4FzbEJZdp0rstiQ2ERL?=
X-MS-Exchange-AntiSpam-MessageData-1: BbgdgJWuJDBTgQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acfb0a7-37d0-47b4-85ad-08dee950b17d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 06:56:32.0249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FI9SjROkWg6Rs+Mji/dL1sBNZEpHNsPTnEyA+eBTgjgits5ZdrnxPzSRpeM5wVkslPjS+UXeTGkoWCDfRQIfPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
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

Make FbLayout code more obvious and correct.

Currently, the frts vidmem offset is calculated based on the non-wpr
heap size and pmu reservation size, but AFAICT this is not right. The fb
layout actually looks like: | non-wpr heap | WPR2 .. FRTS | PMU reserved
| ... | VGA workspace | It's just by coincidence + generous alignment
that the values happened to match with something more like pmu reserved
size + vga workspace.

`FbLayout` is used for both pre and post FSP architectures. FbLayout
contains ranges for each region of framebuffer, but on post FSP
architectures, only the size is actually used by GSP. The offsets are
not decided by the driver. So, for post FSP architectures FbLayout
contains essentially guesses for the offsets. Instead, make separate
types so that we only store the information that's actually needed. This
includes the actual reserved size after the pmu reservation so we can
properly compute the frts offset.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v3:
- Remove patches merged already
- Move `fb_end_reserved_size` to FspHal
- Move construction of FbSizes/FbRanges into GSP HAL.
- Link to v2: https://patch.msgid.link/20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com

Changes in v2:
- Rebased on top of 20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com
- Dropped applied patches ("falcon: gsp: move PRIV target mask constants"
  and "fsp: move FMC firmware loading into wait_secure_boot")
- Dropped "gsp: keep FMC boot params DMA region alive during error" - 
  will finish discussion/fix on the bootcontext series from Alex
- Drop "fsp: try to enforce exclusive access to FSP channel" as not
  necessary.
- Added some extra fixes around the falcon "halted" state
- Drop "wait for FSP boot earlier" since FSP is now at Gpu level in the
  bootcontext series from Alex
- Don't reset FSP queue pointers on error
- Add r-b from Alistair
- Return EMSGSIZE not EIO for FSP queue return message too big
- Link to v1: https://patch.msgid.link/20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com

---
Eliot Courtney (5):
      gpu: nova-core: correct FRTS vidmem offset calculation
      gpu: nova-core: rename heap size field
      gpu: nova-core: return non-WPR heap size as u64 from HALs
      gpu: nova-core: split FbLayout into FSP and non-FSP versions
      gpu: nova-core: pass WPR metadata ownership to FmcBootArgs

 drivers/gpu/nova-core/fb.rs            | 50 ++++++++++++++++----
 drivers/gpu/nova-core/fb/hal.rs        |  2 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs  |  2 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs  |  2 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs  |  5 +-
 drivers/gpu/nova-core/fb/hal/gb202.rs  |  5 +-
 drivers/gpu/nova-core/fb/hal/gh100.rs  |  4 +-
 drivers/gpu/nova-core/fb/hal/tu102.rs  |  6 +--
 drivers/gpu/nova-core/fsp.rs           | 44 +++++++++++-------
 drivers/gpu/nova-core/fsp/hal.rs       |  4 ++
 drivers/gpu/nova-core/fsp/hal/gb100.rs |  6 +++
 drivers/gpu/nova-core/fsp/hal/gb202.rs |  9 +++-
 drivers/gpu/nova-core/fsp/hal/gh100.rs |  9 +++-
 drivers/gpu/nova-core/gsp/boot.rs      | 28 ++++-------
 drivers/gpu/nova-core/gsp/fw.rs        | 85 ++++++++++++++++++++++++++--------
 drivers/gpu/nova-core/gsp/hal.rs       | 12 ++---
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 21 +++++----
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 32 ++++++++-----
 18 files changed, 219 insertions(+), 107 deletions(-)
---
base-commit: 71d4e7233f235871b13553e504e591ace6b54373
change-id: 20260608-blackwell-fixes-30c9358c90a0

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

