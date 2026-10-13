Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E763CA9EC5
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D62510E501;
	Tue, 13 Oct 2026 00:29:49 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012031.outbound.protection.outlook.com
 [40.93.195.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE8910E501
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 00:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnjIHQPZpeGV6poeb0fhs2+Yp2zFyRVYQTKZxmMUJ+g4k7ldpHTOP9zNZ99yFmYPGDLj9+F3m8rakyGu6Knc5NI/jjvsCuv92j6M322O4kLKEoRSCryQgLyRp36PpiiMWNtSiAd0miPNuF2ZRduROM6vQwptrQXO67oKW1/T8Zqf+6xB6OMOZyuDu8jPa6QdSmO8yuhEkGxxg+fZ+oBblOtQlxnIolGhBDq5vRBGr5z1tn3a50R9fLLdSwhVh9kU8VBq2kwjmugaOnfxwfbJ5UsNf29bav862pu1zF7FpTshmzPhITSbOxyo+bxfGhI1qyMk7UO8Q8RftOX/kAueUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4u0y2UMMasYYCUMo8kD6Df52UC5F1F7EKZDZti3EQI=;
 b=MWNw7wpZ3uqmU5u7ltEPzoWQ8Op1PzcwwGEYsqsfRTArPehGw1rSsc1d6ltKaVQcxKnXGyyKUM96wjEmRC5ClfAyUBMGOTXR6BRbuTuSFsK9VCdFSAkOAyTcp2uVreeoQBQshhhakGrYh5q39YZjA8rKVz7RhFhkr6r5gPZtMwPYPbLVMORY/LM9S3k3l8E2yTcoJpli13YRtnkqD2S4BCY07MSq3nPzfQ+1K+EDkgE+3T0vM/Esdy3rL0PQ17zWuQTCKGgUAoqQ3djbMNZawq0qFQmCfj7VyvFS5JcAxM4Llkhag1OxQUI21ck8afpZB2Lgk4dcLs0Og7NptEUXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4u0y2UMMasYYCUMo8kD6Df52UC5F1F7EKZDZti3EQI=;
 b=pW95oiFc0JDsQTgVFZ7MK4O4Ao4epGYyiU1EytVZtGNA/GU6ca/41j30+zXrMVVRXDoctEcV61fcN2Wip5Og5UULmAfvOC7NKwHl1fiBfPrCob4IdGwVzXGgolr2e+1Whfb55mXmQYJJYdWhf8+XyvCGVgkhoiwARlFpEG3tQaHItkEi2hsp1D59zkcGjK5LLHA/wOO80EyBl0rzzNvcc7E5RYUfEFeChVC8wsNt04aGEFr/j1/Cami6yJ8MXAWWHwFfpZj0VtGrkIfv0lrk6qfsVA7rcMvPLf08gk6h6UPrUVw/P50KVL0mgVqpktz9SH1W2hZYp2uG5+higG+rUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 00:29:39 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 00:29:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 09:29:35 +0900
Message-Id: <DM3AAU5883WA.2GX2D1DA6IY34@nvidia.com>
Cc: <dakr@kernel.org>, <apopple@nvidia.com>, <ecourtney@nvidia.com>,
 <jhubbard@nvidia.com>, <aliceryhl@google.com>, <gary@garyguo.net>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: gsp: zero-pad command queue elements
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "haider" <soka11223344k@gmail.com>
References: <20261011145105.20829-1-soka11223344k@gmail.com>
In-Reply-To: <20261011145105.20829-1-soka11223344k@gmail.com>
X-ClientProxiedBy: TY4P301CA0095.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d715d2b-3053-4aed-4d02-08df28c11151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|376014|366016|6133799003|10067099003|18002099003|22082099003|3023799007|11063799006|261009223027099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: Rn7jO06LBTOVb00YJ0IiUMxdn/C+EyY+pIzb3P7fXESwAn+TAnkjU4RvO+pn4esRNrtLphU1+Eby0PFNmjr8GrSwWZ2YeYfEcV3ygPoLHmcHRhUOisC0IC8oYuj11S4Qt2xO8mjM0wv23Rqa7PfD2CebOAlaNcudtkRb/SUSglS19PJH1zZLzpHADY7jCYyIVqaOF7kIXDTjtTWIWmbcbk1Woxblf2Vrpn1T6dHqxSEY4rRfSNP90H+uVu++qNG9x83jPjLeqXrQn0ahF2YtBdRQk1/BOHd7lpLqWnAZB8+8h7zpfHf71h96bHR+QSizQByz0YvDzfI0rNDMrOlwUXIOmH8a0YlMLWBjfk7/G9NiRMeDQ2WrW9jLBITy9bLqco6hiz3R5O0vE3vSmIzsh9tk67+WAuDMH0KGBTaFtt537QWH81jNH2/nIFa7iKmu1/HgbQx665dX4rjK6JDCILg+WdDqpECoghBttar4efpcVTpUaIPUvCQlQDRKOmInPEsynyxA6N0R9L5O4WHpJxtcZXc+86FwlGsU01X18sBXGBJF0cQ2MUb6shX5VGMiJtWSbUBBdCNE0EWi5PoL5rxWazDnQgPhAkfAY261RpbMLLoRA8cBpBDM78zV8MsbIAcNpB0ZpKla99tszD+VVEko90wALFbGhzLFROYUvD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(261009223027099003)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T09rVzBLZUdoZE9wampRQjZzbEZrS1AxUWNuQzdlbHlPRzlPYUlsSFlBRlNj?=
 =?utf-8?B?WTRpTlRVZFpJTUZnVkxBU3NaUytuV2RRclVSZWU4N1RtUGVnNXJRb0JFK0o2?=
 =?utf-8?B?OXRjR3NrRVhYaW5OVkMzcncvRk1EdWZWbWVGVjdaM3l6ZFoxUWtwV29mdldq?=
 =?utf-8?B?TTBtUkd3RWpvV1orVCs5MWVTUStuWThhVW5ja3h0enFFcURWNXdvVXhUZkhS?=
 =?utf-8?B?QkVhNDlVSVZ4Qk1MUi8rcHR6NGtPVjhaeDl1Sy8wT0lqaUg1VkVlZkR5YjdL?=
 =?utf-8?B?VjE3cmJtWGM3MWNndnV4c01ReHpaOFNxVW1kVTR3dldqME5HUmdrRUxjTDQ2?=
 =?utf-8?B?UVBSZ0ttMElnTlRpZHpDZWtnek9LdmFSQURhRjJNU0taRHgyM0hoTnFSY04y?=
 =?utf-8?B?OER4TCtTYXR5WUJKbkduVzMwNVlpUWFCQU11MnV1eUY3V216a01qVnZjT1U3?=
 =?utf-8?B?bk1aalREUmR2VnZOVHdDUlpydXg3NUVhZUFVUXcxcStFemtmdkZGU1IxVytX?=
 =?utf-8?B?RGc3ZTBRK0hyVWptSkFkeEpvK1IybDdoeEdLMWNpbVRVdGN5bWpEZEI5bnRn?=
 =?utf-8?B?MStDTTJEWUZBZWgyR0Y2UlZTaFFQVmtSKzZadTFiYyt1dEtpa1Z0bGJsMlZt?=
 =?utf-8?B?SFVqdzFRVCt6R2ZGYUpTZi9KaURNQkJ4bXlxN2d1eDU4bk9pYmVaZThVQy9Z?=
 =?utf-8?B?T1ViTjBCSHR5R0JlUUhUT3NhMUVaZ1VvdVA0cVBSSk4vRjZHOVRLeE9lRGVZ?=
 =?utf-8?B?ek9EeE5Vdm1RMlFPbFBsQkgzMXVpR2R1d0d1QmFBRWZIVlp3S2N5ZUNxZnZl?=
 =?utf-8?B?d3hKODRteCtZSE96WUVmdWZrYlRBVkZqSjhYVmxkYnRNRlNTQ1RmbFd3VjBu?=
 =?utf-8?B?Vmt4NFdyZEwwVEg5ZXdGQytDMEtQT2Fqdi8zclI5L2w5bGxUZnZjaC9NWkpu?=
 =?utf-8?B?ZUw1T2xpaWFja2p2QVFNSjVSYzVFaDhneE5aajdZaG13eUlwUTV1SWZFdzRR?=
 =?utf-8?B?a0l0dTFPdGZtQ1BScjZ5T29wVU4wVUU4SlJEaDkrREZsdFg4UWdhSDkrZm1R?=
 =?utf-8?B?UGxIRTBXemZXbmZIU0xneittdlQ2MjBFRzBSaXRnSStuekRoU3hRdXhwMi9X?=
 =?utf-8?B?c1JhZWF3VUYxelVTWnhaVnY4dmQydjF2SUhTMU1YVXVxR2pEejFENEFjaEZS?=
 =?utf-8?B?SFJzSjZsMnA0TUd4Q2VPdzRscGhIV0hQQkw2OHI4NndlU2NSZFZSMW9vSEF5?=
 =?utf-8?B?VFJUdFNXaGw0YVl2QkUrdTVTQVFzcWZVL1gzd092VlNlVTN1TVJWSHVDZjBZ?=
 =?utf-8?B?ODFiMTVYSjlLNHFlTnFicG5UdFJJN0lDUDZOVE11a095THdjR0VWM0lROUFh?=
 =?utf-8?B?NFdSMmZiQmNqdW1CeWMrYmVKQVVETHJrQ0JIRmZsSFNpd3ZzVGUxazV5RTh2?=
 =?utf-8?B?anVpaUEzWDRxSGFWelZOQU5JV0ZTM0piQituNVpqYlFnTGpwTHlTRTRYeWZH?=
 =?utf-8?B?UzdDK1N1NXF1SXJLY1V4L3VRcEFBdy9OZy9tWU1TYWttV0I2am5uMzFhOXNz?=
 =?utf-8?B?ZmlGMThQU01jSDJQU2Y0OXFYS1ZFMmh5U21yWmFGb3Vrbm9LQmVWVUI2eEJC?=
 =?utf-8?B?YkUyNlhqYXV6QUYzUkhFU1pkTXhERzdlV2QwSXQ1Wlk3RUN4ZXl2aElTWXhY?=
 =?utf-8?B?SnBBMzRrdnJUQlo3WEh6RUNCT2Y0R1ROa2dSN1pwRmM5ZHZtWkNqUGEweFdl?=
 =?utf-8?B?cWJmOXFnZXkxV2FRSVFvc0QxQjV3TzFiemVyK3VNcHdUdjQxRWdzVTI3SnA0?=
 =?utf-8?B?TkdOc3pCMDE0NVIxRDVlN0ZCd1hVMGxHR05YSlV5VlV1aVE1Si9DeUNSUW5v?=
 =?utf-8?B?WEgvRnFrR0hidGVHSGh4eENaeUErcGt3VmpORExqbDlSZFdET2hPWS8xWTVp?=
 =?utf-8?B?MS96SXR0bU45VFF0VFplN3RJcmFtTytOOXBhSExGRXRKbmx5ejlMczRtVW5N?=
 =?utf-8?B?Y2tlODRHbDY4ZWZLVnNIR0s5UThZcWZTSGttNXhldnNubk5rVkNiZDhpdmw5?=
 =?utf-8?B?ZmpwQ2RZSU9oMkpmK3crTkI4WG0vazRvZHFmdjNjaytiMFFXazNYdXNKV3k4?=
 =?utf-8?B?MCtYQnhqUmRwZ1hIWkJvRWJZMWRLakpyOVpTYXRZK01wM2phYitCVXdoQWxr?=
 =?utf-8?B?N0xSd3hVVEhSQnFKZTNZenZaMzZka1NCVVFpRHhmZjkrYUR1ajRTQzV1RkhC?=
 =?utf-8?B?bWVYWEFzSzRhb2pWL3E0QVFWV1F1TFJDRkFSUWNFNUhCU0N4bzlUZEJzbVlx?=
 =?utf-8?B?UlZvTVg2UmpYV2tkT29LSHVwUGdmR3I4RlgzeGNrK3hmaC80QXNNdFQwdVF2?=
 =?utf-8?Q?QnI4/zFMk223qm8vcSxZjOaZ0c1W+84jGZ6jpo7/0+kV7?=
X-MS-Exchange-AntiSpam-MessageData-1: Zf/kJ3RNlxDAWg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d715d2b-3053-4aed-4d02-08df28c11151
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 00:29:39.5576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGPgHeFgxqv7e/mBvd7lUVQ1tPT00WFGe0ObzRmyRzhNdgGAtMUgoFzWico6v0tn4gt9EruIo2TxDbf6o9U5IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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

On Sun Oct 11, 2026 at 11:51 PM JST, haider wrote:
> GSP-RM checksums a command queue element by XORing it in 64-bit words,
> so for an element whose size is not a multiple of 8 it also reads up to
> 7 bytes past its end, and expects them to be zero: its _checkSum32()
> "assumes that the data is padded out with zeros to the next 8-byte
> alignment". NVIDIA's kernel driver zeroes these bytes before computing
> the checksum, and nouveau builds each element in a zeroed buffer.
>
> allocate_command() hands out the queue slots as they are, so these bytes
> still hold whatever an earlier, longer element left there. Once the
> queue has wrapped, a command of such a size can then fail GSP-RM's
> checksum: GSP-RM never answers it, and soon stops answering at all.
>
> Nova does not send enough commands for the queue to wrap yet, as it is
> zeroed at probe, but this will break as soon as it does.
>
> Clear each element and its padding before writing it.

The checksum code is imminently going away with the switch to the r000
firmware version, so I don't think there is much value in fixing it now.

>
> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings=
 and handling")
> Assisted-by: LLM
> Signed-off-by: haider <soka11223344k@gmail.com>

For future contributions, please use as real name as per the
contribution guidelines [1].

Also as a general comment, both the commit log and code comment are
unsufferably long and tedious. When working with a LLM, please
edit/rewrite its output to something concise and to the point.

[1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#d=
eveloper-s-certificate-of-origin-1-1
