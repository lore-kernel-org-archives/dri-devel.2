Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09A1CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4E389FF9;
	Wed, 17 Jun 2026 14:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GIXb1nN3";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2309789FF9
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9XSr3gjFd6mRh3UCVBKKmm7tBbi4ydEnRX8DnwsTIrYAYTtkDVEsnvlt2qxbtPZOLpf5YC4M3IYmNyJybEE7AL7TAqKZV5kZ3aRCoAXxsk7zhmTUFxyhfbp2sq5Hm1P6wqBAnbwqvA7bNOjHRIUjIxH53P2UsKDilLZnZOpazR3B2CS71rW+Ig5VtMh6CWvLFf7098s3EL9NkR9vJvJr7diW3rqmZFnJLa/NwZi+UDo+W6FC+7dyETHXVhAYsOnhMALI5O1d3UstTGPrV8a7ATlJTEyB+mp+OiV7HTstNPG/5jKu5YHK7NgXWFV+xXzZdDzelB8DR8m3CRDxECjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNG7gtmZU+6KuW7KsHAj4xwtihCwFlMe6FIhWrmso3U=;
 b=m/5wIEFDUL2STl6Ia1EHvTzKx8T9kZUg9XYZ3TQTUvkBbV3Ad+KUDwQOV+RyQpemfz7KKzJT6EhYDVDBu4FicSF1GOBZfLrp3cvF5UxXHpOQbJSBSWm1IYXOME2daU1yQmFxCdDGg5z1Ycd4QVOFTrAEnZTHLL/1vWhJs7acOAqWvvwgnqzlTwmJZARsKCO17XuhLaxVweq4TxxfauP8bxJHkhwbOh0Jzsep2NI69ZXdAuOnVmYWVaE+SmTPet1yGfX9B6c48JUSyt0b89DDz0gNEEydqdzjy6xMm3HqrgtyAWr0e+QwP5W8DKeAr8Sv59B+jO8CqZlP66/szKHtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNG7gtmZU+6KuW7KsHAj4xwtihCwFlMe6FIhWrmso3U=;
 b=GIXb1nN36edHciLrypLnXUUe2Z16ILrxiaHrRxK6eoCL2JuMnm7tABQfCVIROyOyH3HPQcFPELsrl+P6v8BGREo6bjP/aHo2o51sPwU2VFWIgBhG3/mRSO5Mro36ysAIMM27a8kS5aCT383+eHWt/WGyN2HX3xF+P5vZ0xAGDrMa1UqdfDKIt6RffiEeZbLvgav4fwGRj1UxMwzWQ1Ya67ho2hOYPK/GtqoT325B1d7RmSK/++Q0OLELHRgjRmfTDu1u6OFfoN2g9mzSFE6uHyKAgyFIOhuVZ3JeNHKmpmt+oLd/WgyxLvhc5uij/bEKFa6KluyI1Jw+CuJ+oviKzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 14:03:00 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 14:03:00 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/2] gpu: nova-core: convert to kernel bitfield macro and
 remove local variant
Date: Wed, 17 Jun 2026 23:02:32 +0900
Message-Id: <20260617-nova-bitfield-v1-0-ec10c6772666@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDWpRurnKmLRYTAiJS0ikd5ds
 fwW793gyTF5qJMbHJ3sebURWZpANxk7kuA+GpRUWuqsEHY9jUDeB6alF0g5IqqqNFJCbDZHA1/
 fr2l/+wNn6vZ3AiE8iBxoXnEAAAA=
X-Change-ID: 20260617-nova-bitfield-be4bbb298a00
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6bc68e-b65d-4f48-6b85-08decc79241c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|10070799003|1800799024|921020|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: gB4NTHqVY8wq0mfmLo7ulOgDdX70KkiuVDYRG3AQ7IrAmvpD51+0GgbkmPSnmtYKcJJfsqOUQGL2Y9b5jBJHYSZMtyGiH/dUAZvMKA/Jzt4YheEBJ59Hb1igLVX1awGmxgrZuRcpff7xTz6Bth9sI9+U2TTExMpEc5BZvsp9kiLqHho1OqQWlcrSCrD4k3uABl15K0cYq7R8EnJqk1ctbtTzhC1SNvpZZmo2Fap9fk4RywNUBSOEj+dMYHX+PIZJwzRdGFaP5BdxLsVZ9REapmP0T3fawI19c2aMKkzmdb9P0FCfDYGokx2gkCa4D4vdHq3yVl+359PnuSfXXQWVeDHH96qO/qH3zl1dHj6OHY60GE1iEazQ5jfVRJ/M3FQ7UIZHmBW2FtWNWbgFWqDu7PGuPZxNKygWKBa75pDHxITRU3iYAbRFd08Gr09kAJQrvXnmLta0IRTNteL1EipSpI8SDJfA+Ou6XkdARgC1ijPF65RMVao8uAokNS9MzDquN5yZJOXof4p59AnJGSb13O9a274DLgGex6PgkO//os2jDwWM6aWDl8v2oekBGwrStN93r9m0e7RFJPOxBCQMCK0e64HzOxsF0s9PB0qFTzqICSSrjCwLqOkVDNKw6i8SavDOunLpFK81OXF0IMGcjWezlrUCxN6r0/Qi0otHfWQu6X/ggCnuxkycBkYo8bAV20RqvRV7ElVP9mB7DjczU+hmC3YuhFc4FF9pH/nirY4rxGDsIQ2giQFAPaH5LCPp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(10070799003)(1800799024)(921020)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmRPU25YSzhzNEpGSm1iZkIvM3B2bENtZ0RNYXRWbHFhWmtEQWdoM0dudjh2?=
 =?utf-8?B?WmxieWxtVzFoVVljaDd2b3ZpZFhjN0hyRTFjckJWMHNTMnJGL2IwS1FXcjBO?=
 =?utf-8?B?K0VzVE9ja3FxS0h3TWk2RVBoZFM4TU9EVldZYVY1Y2l2TW8wVXJOK1M3K0Zh?=
 =?utf-8?B?UGthaHRsMzRyWW5wKzFZc3BRaVkwY1ZNTWN6RmhQby9Zd2pvN0hFVnAzbWg0?=
 =?utf-8?B?dHdTUDFPZmdjaGR5YUVNT0NMK0NIZmMrMlJGTnhjaFZrTEpyV2lqMTRFWUJq?=
 =?utf-8?B?Zk5zZzRPT1lrMlV2UHA1K3VtVjdueDdlOVlQY0xMWGp1aWx6TDB4a1F4ZzE1?=
 =?utf-8?B?RjA5MzBFWXhoOEhNaXM2cEI0b2lYcmgrWlppYzFoajk4a2pnalVpN0xwSCtE?=
 =?utf-8?B?anpoWm0xUDJ1UDhxd0N4WkJEOE51QmwxcTFFbFAvRmlxSkFOSUM1RjlvVHJR?=
 =?utf-8?B?dk5zaysvRUdveUozd3RjSHliQXc3ZjduTFJHbVpvdkpIRFZ0ZjFRZGZHVVZ2?=
 =?utf-8?B?Lzd1eUI0dS9GcVNnZ2gyMHZ4WWxuNm96V0hEMlVFU0IzNFBvTXZ3bEVQV2NR?=
 =?utf-8?B?NHNWRzBLMS90WExQNHBuYVRBZU94aE5KOWs5YWZCbG5qTlZTWGE0VFBiYnRt?=
 =?utf-8?B?M29sOGJUOTF1RUlPa25nSWh1UFF2anlJRkJ2Z1ZSbE9sbzdERVZoVERrTFF1?=
 =?utf-8?B?SzFkamdJQkQreFJoRjhlR1dZd3RNa09QWm5lRzdaakw3MUFyelpqbHJpMWhH?=
 =?utf-8?B?cVIzNHpJajFEaUtreVhVdWgwU2YvdXUySW9ld0podW91cEZNcjZkVUV3U2k4?=
 =?utf-8?B?TURsOFB6WFUveSt4SS9mdXM4cUFuRlZBakFQeTd0QS9KZXpRelBtNDV2aG5D?=
 =?utf-8?B?ekI0VHhhQXhKNFFheEpxTE1JcFVERkQ5ZHU2SFFwa0NzcFZFNjZUNU8xZ0Rs?=
 =?utf-8?B?bkl5SU02cmM4aXVFQWR2QVdoNWE2bkVMY3J1eTIxaTQxM2VWbXMraWNHN0ts?=
 =?utf-8?B?b3M3YTF6RmVPaWR2S29lTWNKN2EwZm5oYWhibmtuTDk2SEh1VDdSUzQ0NXUx?=
 =?utf-8?B?S3F4L3gzTnhTSEpvNWJpTWt2SXRQQzVidHVzZk5vQXdjaGM1Y09rRmpweFBp?=
 =?utf-8?B?NjZnMDE1RFVwaldyRDlHTnpUKzZKdTZMcHpqNEFqdTdWZ3pzSmxsRGtncFA2?=
 =?utf-8?B?dmtTdW80MnVnSk9INGRUaDFKQ29Xa0wxa1hSVStncUY4dGdBL0EzbXYzeUlW?=
 =?utf-8?B?YTA4K0lUNUJ2Nkt0R2daMkh1c05TNGl4eUFLL3lrWWN5Q2dUYy9qaHlHSmZ2?=
 =?utf-8?B?OXNWNERiWXpGNUh4QTRxV0c1bmhFWjRRZjVWaHY3b1g1SXFkdUltU2FCazNx?=
 =?utf-8?B?eEJZTytKY3Q1aENGeFVFUzNWWEJpck5xVHl2c3liNitPWTVnOG1qblJYS3Rh?=
 =?utf-8?B?WGluTGdWa1plcWlaTzNzaDJXM1BqeUFUZW9MWVpERUJqdTc4YlNSOHJNWHRR?=
 =?utf-8?B?dmxudm5ycEg1VUJGYkdZWUpvbTUybGlJOEM3akRhYis5TFQvVVFMdHJDTTVC?=
 =?utf-8?B?OEpMQ0wyaHJiczJzQkdOajdBdXk3Q0NvTkR0RXFkMldya3BxbE1LaVBraW1s?=
 =?utf-8?B?ZUtjZ1FtbUNDZmZ5dlY0Z3B3cmdMNm00T1ZCKzFJRFRLZVBtUzRUcUtMZkJu?=
 =?utf-8?B?Uys1UWc1OXZyUUthN2RLNDQ2eC9vWmh1b05LU1UrN21NdXdCcDNkL0hJRFlB?=
 =?utf-8?B?VUQxYVlyeC8xOHZsOTVsRndRZGU4NkkrU1pwS0JjNXlQTHV5VEw4NlFmVnAw?=
 =?utf-8?B?NGlSckE5NWc0MWR4MGRGOEdBQkJTQjBpc2NTR2M1dzRMajUzWTY3L20zazMr?=
 =?utf-8?B?ZXkwQXBKck42OTgybWNNcEZlN0dlOFZSV1hqem83V0J4a2REbDgwcVlDQ2Ro?=
 =?utf-8?B?Y2dkcm1yMmhlZlprWVQ4N3FLMDZuUDl3TzdUZXhMcG5YVS9QeGt2RzAvcWh2?=
 =?utf-8?B?N1R3K0pTaHVzUlZLcmk2ZXZ4b3NoZjBhSndTblR4QXNNOXlWRGFlN01oWjVM?=
 =?utf-8?B?WXpTZ1dKeFZmZDF6WjlESHpJemU1Mm0rQnIrc1F0VFRDT3JGdmFlWVJxUjRW?=
 =?utf-8?B?VVhCb0EyT1QxaFVwTjFXamk2QW1MZGpJQ296bjkxemVpRE9sUXZOMlFXZEJK?=
 =?utf-8?B?Q3hxSThyNmJKQjFCbjFEak1LZWxNenRpOG93eW1Xa2FHWDZrWjZOYWtqWHF4?=
 =?utf-8?B?NUJ2VXREY3dmUTA0djExek9aMHdBRm5BYW5MWTdIZE9QbDlXdmJNM3hjSUdk?=
 =?utf-8?B?YkRtcERkTytSZWk0bWZZREpLQ3NUd0hVM3NSSEh4bDJKZlVUS2h0a2tCdlox?=
 =?utf-8?Q?kcGqf4FtYFFHyQi/fkCzN/2quxoGrDrhzkr8+hVC7yx+6?=
X-MS-Exchange-AntiSpam-MessageData-1: Ome7ZGzKBE19Vw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6bc68e-b65d-4f48-6b85-08decc79241c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:03:00.5941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo+BnGyNz3uf5zb7HMrLxKFGb+cW3JJPBo/FAOz3yvH4splPabYly11KED/dJo5H+CftIvowaQ3RcMan3JDPeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
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

Now that the kernel-wide bitfield macro is available, it is time for the
Nova-local version to be removed.

The first patch converts all uses of the local macro to the global one.
This involves redefining all bitfields since the syntax has changed, and
taking into account the use of `Bounded`.

The second patch removes the now unused Nova-local bitfield macro.

This is a follow-up to [1] containing the Nova patches that have been
dropped after [2].

This series applies on top of a merge of `drm-rust-next` and today's
`master`. It is to be applied after `-rc1` is tagged and merged into
`drm-rust-next`.

[1] https://lore.kernel.org/all/20260606-bitfield-v5-0-b92188820914@nvidia.com/
[2] https://lore.kernel.org/all/20260527-bitfield-v4-0-e8821d4efbde@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Alexandre Courbot (2):
      gpu: nova-core: convert to kernel bitfield macro
      gpu: nova-core: remove local bitfield macro

 drivers/gpu/nova-core/bitfield.rs  | 329 -------------------------------------
 drivers/gpu/nova-core/fsp.rs       |   8 +-
 drivers/gpu/nova-core/gsp/fw.rs    |  11 +-
 drivers/gpu/nova-core/mctp.rs      |  86 +++++-----
 drivers/gpu/nova-core/nova_core.rs |   3 -
 5 files changed, 56 insertions(+), 381 deletions(-)
---
base-commit: 31686e06c0342de47f40a0278bfe8126de86c3ec
change-id: 20260617-nova-bitfield-be4bbb298a00

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

