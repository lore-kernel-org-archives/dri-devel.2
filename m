Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF57C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA1210F1B3;
	Thu, 13 Aug 2026 07:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="l2cpIKPL";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6331210F1B3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPzPlU7u+0j0w0/Jn0U/BhAu10W+jwq9Rsyy2SvPOKtTi4ab2M3u4Yl433mssRLt4sbtzcqG8soI4kfEQpX2G/xK8v39hCoefJFoXUnQrEchZckOUkhpi3l5p2C7TjLIBWMKSHmoFz4XMGDgg3G5LlAT+qAWbJkxv1IDCm+QIR352OlbB9mKToAWCcxULa8mZ9ARdm2ztmCoqHMThEpvYHwoWL34TSnso8NhqDCjnlxp6YAoF5l+N7wwWgwjhE2ld0VS8HhdIvEdCJk5CjhZxrddzKgAGnG1Ccj5CvPFLxUXc+OVewHBR9ceGG7BlBlmXqxWm04l1xqef0CYMmNCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I012pqT6mkdoXjcF/ipc5gdk7anzSDDp4LB0Ccd0uKg=;
 b=pn8yWyPu8styZXLfxPAR/CX+2ER8QjAFx3hqXt7P0YA1tquqIwxA/JEXRDBI5pe63X5bdJtB8OgJ2weyZ6xmjL+BsQQAFkcxkjCvqShtPFfd0IABB0qub79zKKxr9pbksuy5NSUr6113gmWQ/nCghmZ6VN51i0WJ9QDBnojAiXEE0mFvlwBgUJvztUXx5hCUKIstfD/MNBxw4VxFmFR+Voy5CQvJu1Q4GYvLwU2rxPgdQj5/BEqi27hhITcbrpyHA3TFsx4KFCDW528RCRp82LcdpR6fXTzq6SRF/Y0CpZxM0ZPNu6Ip3Vs/yPSuYc9ocLvTXA3uix61Qbw9WrNnrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I012pqT6mkdoXjcF/ipc5gdk7anzSDDp4LB0Ccd0uKg=;
 b=l2cpIKPLcaAnbaDbhR5uV2VtbEVq+yIIyhC7IMi85PyW5Pzctkf0W8Duwt5DA6h9e9ellsGzLYiM/ptQGe49JDeP6Mmmk3mFtGsj1pSRo9kVKrmr/s0DpkxLfBqfsIaSU8eG7xaFELGLkKDb6ioAiWkl8TLW/YqS2BcMCiftqHWgJsgLQNZtJJLL2Zp5HlUH0YsI4/O85TgXxaEqGZxPU8RhGk5+qP/UpnKkCx/O8udQcrEOOto1kWD9M7NGVFgQq6rG0ceKlkgy2hwF/lzAJ493WGqKMXAxbZErbwzK65xAuCxYNNjItlWp2CVkJ7tggg5On9XX+ouuWRginnJUmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 07:34:42 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:34:36 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v6 0/7] rust: Add support for reserving of ranges of IDs
Date: Thu, 13 Aug 2026 16:34:24 +0900
Message-Id: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XQTW6DMBAF4Ksgr0s1/rez6j2qLvB4XFwpkAJBr
 aLcvSZQlQp5NfJ8b6R3YyMNmUZ2qm5soDmPue/KYJ4qhm3TvVOdY5mZAGHAgKuxzbHmLjVeSTT
 RICurl4FS/nrEvL6t83gNH4TTYpeNNo9TP3w/7sx82VsjLcg1cuY11E4lckJ7UoZeujnH3Dxjf
 2ZL5ix2SvwqURRKTZp8CjL6g5J75TclixKACA6kCAEPSv0px2FTarnlkwCTIgZvD0rvldiULsq
 gNdZaCDKpf+q+ljXQ57VUP60NstCMVJf/c55OlUIfGlWK4o5cpAAmBjRKci5Cgy4pKC95XcLuP
 xzAFGjPAQAA
X-Change-ID: 20260608-chid-18fa943c6d6c
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>, Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0372.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f96d8b0-7305-4e2a-2c15-08def90d537e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|921020|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 5pYClkNDlNNfHSb5mlP6Bhriu+JBL5ZT+OKUVpb/WJzSB7/joBnHxIbnBTKmfUdba/F61mmQ6CqiqNYeL6vGrMHW2XWJEe5RwUNeE9M/Kv85xfLlbZi/0PcxM+IGmIPYiyhG4GKnMQHESF3t74uRiX9bEzOK2Jj4rjhcVr1j+r7eceRMCOCEcKt4VbffrqPI76ZADwL9GDN+PPI9K33avHScvobzGTr5lDolji+dAmUXefLWziqYkwbpcpEh7bP5X6+NMWVUkJNkRX5EvqckbtCSlSQXsO8nXyvozFMti57uwp/js/fHuOiM96relDEu59g3rcCX+1sgSDLq5WrzBMd0qvLHrV4goy31dFerf4iyyyLUOOu8Bw5GkRsMnuXETGS3szbhIQ+PDAuG2IUHSnPOInFJAyRq1nudBRXcIC28m3HQzdIyOF/SCFGSEERwNkAjLGVdVzORE9lOtMClyGN1r7i0RjvavHeTMAlH5shcPRyBp8RBIDS4AlmYKllHDdYr9SvOdLYyJMs6ypGNfJfpASMDWtBdO14+Ois6qqvTfhwFRs3YmVNKHKnPEZxUMYeulA0cobwStcEhSFQWe03ANGRaljb2vAC41tMhHpxlnVW6UtgcdJHDjmd5T37lia16NR8oEtSo+RrPRujVdKP0DhtJZE2imsOUGWQTkmD3Lnpf8NePILq9k460lc9PpSciJd2RfGPBcTTNO4cDWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2ErcFBMK2xqVFIxekFVUHhtNUxTRmZrajVLbFh6K2d3N293S3U4MjlvOHVR?=
 =?utf-8?B?bkpTemRsaU9ralQ0OU9PLzBVbFFJL1BUOGFQZ2RpYXpMVU9qcjV1ekUzQW5W?=
 =?utf-8?B?LzlsdThVZnFpM1A5RnIzWkpaUlFCVyttcTlnTHU1NkhEOHU1YVNFWEJxcVVI?=
 =?utf-8?B?VzRkdVNhdklDYUZLMERISU8zWlVpQ1RqbncyQnhiZDcwNmtDaHprc0FGQnZH?=
 =?utf-8?B?cHlTQzlnKzhGZXp5ait2N2VhaDZuVWtTeTFwNzMyYUlSdVdzODcrcEE5QUg0?=
 =?utf-8?B?QmJpMXBxZ014UGpVSWIyR2ZtUW82OGM3OUNXTXZ3Vm5TelNHUzE1dFNsanU1?=
 =?utf-8?B?K0Q3bGJRczJ1b0N5Q3FZOHNIdnoxZitvNSt1Z3BJaVBxbnJhSDVSd0FlZW16?=
 =?utf-8?B?Y1o2a1FPZ28yU25FVlZ3MDNYTkN2dnRqNmZUZkYxV1pHcFR2T2ZTMDFEVjcv?=
 =?utf-8?B?RklkSnN3dXlTK2tkSzNSU0NCbTU3VXFRSmV1VkM0Rkp4T2FTZGJqQzdvS2Ix?=
 =?utf-8?B?WnlkZEN5THowNXBZbm1EL3JNcGZra3pDbGwzaytrdG5HZjJxUFFNbENtUHZq?=
 =?utf-8?B?SU9nU05OcW4xQXdXcldWRytMa3ViTTdsdVZITllmNDBNdjRWWnNwSjhlZ0xS?=
 =?utf-8?B?bFhXcUx5SEdyWUJHdkI0RExrYTQ5VW9GaGE0Vm82cjQwSGZYaWdKWjdiMnBH?=
 =?utf-8?B?R29mblcwMnJXQWpCL3JkVjlGbGZIdWxhUXdsMjhVVURyOTJVM0RsTXpkMlE4?=
 =?utf-8?B?V0tLYTZpSlR6RWx3Rk9IVTUzZWREeUVXUFdOdDdtbVhudmpSMTVIR0gxS2Y0?=
 =?utf-8?B?QjZhMVg1SzYvSDdSVFQ4Qml6SzB4Wk14WUIxQm9xZTNSQ2Mzc0xJRkQwZ3Fa?=
 =?utf-8?B?aFVmRkpWSlhISnBiSzB5VmxQUjJ1SWZRNU8zV3NFR0VtTDJxZm1QNUVrUjZH?=
 =?utf-8?B?cWpUUzV2Z1REeXlFY05qbDZNczhkZzFEOGFpZDJDcTd3U1g5dmtSb3drSEpJ?=
 =?utf-8?B?QkVzNExaWHAza002V2Z6TTBkYkEzRWtENk1jT2pYSXlaR09xZHBHVnkwV0Uw?=
 =?utf-8?B?N0RmT0RpbUtGU0ZNbi9xWHhsZUZLakVxN3hwUjI5WmJHTmVEMnRjR1FzZDVC?=
 =?utf-8?B?RGdvMnZWcGFCTGlXWjY3aC9rK1luZ2Z6d1JPLyt2ZXN5UjlzOGhzR1V6WWxk?=
 =?utf-8?B?T2NCSzdNTGhwUERTUmRxamtvZTBKVC9GMndZMHpMZ0VNeVNDL0F3ajdiK0Uz?=
 =?utf-8?B?UFU2ZUhtRFR3NnRmM2JrVFhZRVp0YndWUUpYbFM0R0lLMnl2cmw4d1IwbHpS?=
 =?utf-8?B?aGd4ampoOGlyQ3FOYUxPZXVNeWNnZVVqMVhKNE5FV3hONVJUT2duSnBMNCs2?=
 =?utf-8?B?bk1ES29xRTBIYUVybUhmVEZEYm9SRk9LQzduMWYyMkE3d05DQUVaTG5LOWdi?=
 =?utf-8?B?ZWF2Y05zbWI1WWZIZGlvcXdtRzg1V1FlNmNRQXlJZnNQN1EvY09FU2Z0SkJN?=
 =?utf-8?B?K2ZUUDFoblVDQTd2TVFWaitpY3d5dWE0eFoxclZOSjhMUEhUV0JiSjZxbGRK?=
 =?utf-8?B?U0xnK3ZZWWs1Ym8yM1daSUdpNjFrYVZ2S1dvRVhMOS9XUmFTUnZTUENVUDVV?=
 =?utf-8?B?Z1VrT3lZVmhvakVQU3QrYlpiWmVwMkFXbi9iY3ZtZlZFL0hwZ2JKaXVWbmtn?=
 =?utf-8?B?ZUdRMmZsWm5GOVltZHhkaWFya2RTT1hrcWl5VkFCZUlOQXhKYVhYMnM4VXpM?=
 =?utf-8?B?WWV6aXVuWXdJUnFNajh6K0JlSU9GT25LYVN4c2g2WWE0NU4vZkgwRXU4azB1?=
 =?utf-8?B?OXN6MVBhNjNJa3VUM3A1T1o2WVllalpBdmp2K1dvNEhEMXllZnVoSlYvcFNB?=
 =?utf-8?B?YlVkREJsTVU3T2pHVENXUkx0cFpQc1FNZ0NlZ2luTFNMTERYSkxDRWZyNi9S?=
 =?utf-8?B?UXBadFQ1WGlVcGJRTVV2QmJsVjMyWm0reEhEQWlqSEZpalgxK0w2U2JHNC9U?=
 =?utf-8?B?aFYvN2VxYXBnblAzM3hxU2htRG44YWFKU2o2Z256UjRaWENvY0N0YzNRUGNs?=
 =?utf-8?B?eWZMUGN4dkxWOURodjlRajhhaGJjRGhVelQvcGoyNVREaFBKREsxU3dBUjlZ?=
 =?utf-8?B?eit0SmhScC80NFFEV1Y4SllPY3ZhVlQyQkJXRFRTZ3VVRmV2eWpXdXNhY2pD?=
 =?utf-8?B?OFY0TUlSVFF1ZkVVamhuL3ZOUEwzU0JOL0xNZmsrSmFtZlJwZ3dxWk1PRnhr?=
 =?utf-8?B?L3JMYUNvL2JYWklSTjNHUjJ0UURibk5UNjZYZXE5Vm5IYUVFRW1SSHFtdzRD?=
 =?utf-8?B?amN2ZUdubVJmem9OWE8wT3ZpVDhxdXptajU2QURNMlRPa09uSC8wS0Q1VERp?=
 =?utf-8?Q?9O0p51edqG2mKx4WqwgT6gLIt2drDpQSK5gugoCnmBAtX?=
X-MS-Exchange-AntiSpam-MessageData-1: 4oySEwsIqnkCHg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f96d8b0-7305-4e2a-2c15-08def90d537e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:34:36.4920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQD8Vx0S/4gRsLlf1TUXTaW4fw9Ko/1ta+WdxuhjvjEcHx7dQf6SrygtWpQBme6ooI9wdl/QPxQYThcUnlITPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144
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

Add support for reserving of ranges of IDs, with a usage in nova-core
for channel IDs. This entails adding bindings for the C bitmap
API for ranges of bits, then users of that in `IdPool`, and finally a
user of `IdPool` in nova-core, `ChannelIdPool`.

Channel ID tracking is needed for allotting ranges of channel IDs to
vGPU guests, and later for regular host channel ID reservation.
nova-core needs allocation of a contiguous sequence of IDs with a
specific length and sometimes a specific alignment [1].

About the tradeoffs between different data structures:
- IDA/xarray do not support allocating a contiguous sequence of IDs
  (ida_alloc_range() allocates a single ID within a range, not a contiguous
  sequence).
- A maple tree works, but is not as good a fit. The ID space is small
  (limited to 2048) and aligned allocation needs an alloc_range()+erase() retry
  loop (plus a Mutex around it, or new mas_empty_area() bindings) that
  essentially reimplements bitmap_find_next_zero_area(). See the maple tree
  version at [2]. For 2048 IDs a bitmap is also considerably faster and smaller
  [3].
- The bitmap API natively supports aligned contiguous area allocation
  (bitmap_find_next_zero_area()).

This is based on drm-rust-next.

[1]: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/
[2]: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/
[3]: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v6:
- Take a NonZero nbits in `next_zero_area_off`, `set` and `clear` (Yury)
- Remove `UnusedArea`, `IdPool::alloc_area` now allocates directly (Yury)
- Add patch: take a NonZero capacity in `IdPool::with_capacity()`
- Add patch: do not round the capacity up to `BitmapVec::MAX_INLINE_LEN`,
  which also removes the bounds check in `ChannelIdPool::alloc_area`
- Add more testing of Drop for `ChannelIdPool` (Yury)
- Link to v5: https://patch.msgid.link/20260812-chid-v5-0-6c767770b3f4@nvidia.com

Changes in v5:
- `bitmap_assert!` i32::MAX length for Bitmap::from_raw* (Yury)
- Only run overflow check on 32-bit (Yury)
- Link to v4: https://patch.msgid.link/20260810-chid-v4-0-c9f206fdcb97@nvidia.com

Changes in v4:
- Add `next_zero_area_off` to match C code (Yury)
- Replace overflow checks to match C code in bitmap-for-next.
- Tighten `Bitmap` unsafe contract to disallow Bitmaps larger than i32::MAX
- Link to v3: https://patch.msgid.link/20260729-chid-v3-0-20cc08032bbc@nvidia.com

Changes in v3:
- Use `Alignment` type in id_pool and bitmap (Alice)
- Remove hang check on the basis that it's extraordinarily rare.
- Link to v2: https://patch.msgid.link/20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com

Changes in v2:
- Collected Alice's Reviewed-by on patch 1.
- Address Yury's comments w.r.t. using __bitmap_set etc directly.
- Address Yury's comments w.r.t. following the C names
- Additionally check for an overflow case that causes a hang
- Added more info to cover letter + patch 4 w.r.t. channel ID allottment
  requirements
- Add align parameter to ChannelIdPool::alloc_area() plus an aligned
  allocation test
- Add missing INVARIANT comment when constructing UnusedArea
- Link to v1:
  https://patch.msgid.link/20260703-chid-v1-0-84fe8259e46e@nvidia.com

---
Eliot Courtney (7):
      rust: bitmap: use function-level cfg on kunit test
      rust: bitmap: restrict bitmap length to at most i32::MAX
      rust: bitmap: add contiguous area operations
      rust: id_pool: add contiguous area allocation
      rust: id_pool: take a NonZero capacity in with_capacity
      rust: id_pool: do not round capacity up to BitmapVec::MAX_INLINE_LEN
      gpu: nova-core: add ChannelIdPool

 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 201 +++++++++++++++++++++
 rust/kernel/bitmap.rs                | 341 +++++++++++++++++++++++++++++++----
 rust/kernel/id_pool.rs               |  47 ++++-
 4 files changed, 546 insertions(+), 45 deletions(-)
---
base-commit: 4c9ba407018e8deb06dbc643112bac8f40404f95
change-id: 20260608-chid-18fa943c6d6c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

