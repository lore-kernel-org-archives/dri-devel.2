Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE09CC44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12FD110E3A9;
	Thu, 16 Jul 2026 21:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VpLXkvVd";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B24510E3A9
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 21:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuZWU/ULapQYyfX+x3V2J6VoDDy5kd2t9+MM5kpWRbP3lTqTn8kcN5lQUD7g9hyHPzRD34LnLyPeMgp3nWWkZNTnPvSKP1kWZWSGzpG767Rmn9K5a0kypH07n0KtZ1rH/DqVd2ozsWO4eyoHJTT3z/RTpXkfdAWZHhlCCZdub9caTor7iDC8DFdmcPX2Cg2ZODOK1KL+I2uwuHhg2KP3J9guLjIwxPs54arPZdP+ItRdcZkDbnTkjbjP3WaWXUa2GTggtHpuddRMQz5Mm9JbO3/nvdjDUY1RBOvWWmPxoAWz1xl6YWxR1ediO21NoNwkBb/pULOKdhE8hReAazORYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfJxVrVS/Xnu5Edks0or2OOYC3PuRogtB69fPa9/hD4=;
 b=fjXoIuDWMmo999Thjjjn/PiujOi6hSePdFHirokeC4zbeMVDSPpcCGjnWc8uUZWE9FpEq8zpZ35KlDL+bG5ZbWtOIcyf9EpDpW6p7LArSKYmR2rNVKWRvcrGFDSDEPMg7S91v0q03yJfi+Lu18C/Di/HyDjm3xsU4w8VNtkRbkDY2TFzqDyR0uOxqUFRw1Srd1WyplWSr0Aww4XMPkRcFchGHJsoy+jkAdfYgKUVlSB18+tKHXShTXyxHtmAiK/8ER9YPK2kF1Tc6LmmvmmsXnIYGwnwM5ivPonasUXAmD1hj7iIPstt2t2HXGHkfteJPo6BTKxfXcc9RDh6/zQa+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfJxVrVS/Xnu5Edks0or2OOYC3PuRogtB69fPa9/hD4=;
 b=VpLXkvVdoaXW/d0ajYlG/uFCMvrjCGbsSGzrHGW6zAZ0g9uYfXo2Csy0lpLxrEB0id8EVsDcso7JXs/S6xbqc6GPE+BffxFVha+In6wNFP0J7E2dPZTigvT12VpY7nOWiwgNfzpo4Le/71HqwTNKwZkYBUI+gysy48g7d2i9a4V5WmAPc8Jg887Irs/lVIEhgRp6+RRiDT5x5TB6W0ULb+GEiL3iglzRpn/Lj5TtpJLXUvNHGaBJdahkYEwDzF3RifQqJyS1OrPAIDXEsi1lq/1+AJoWZ9X+JXqoEgcKgr4RU+gH9nPJxUcG3A29WLvdsxfekLJqb1FsR2aKfIkDOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 21:14:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 21:14:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 14:14:29 -0700
Message-Id: <DK0B1IJJKTYK.1Z27RGR81Y7VM@nvidia.com>
To: "Gary Guo" <gary@kernel.org>
Cc: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] rust: drm: fix non-const `read8` in unit test
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260716142545.3622278-1-gary@kernel.org>
 <20260716142545.3622278-2-gary@kernel.org>
In-Reply-To: <20260716142545.3622278-2-gary@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: a9466e3a-298f-451e-a720-08dee37f3a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MeG76qp7Byhxp1mJES92WOW5tn0i678Tq/y4sdpTlkETJnXZE/kSEgq4WY1SoC6Mw60bi79KQtr1tWCYggZvyH+ZUMQJhvnmkawpeYaJui2/Tdle8TZ10wpUQK/hTxXhElky2tPEFaS4H3pWxYt2WEc+lG+StABpb+CsA+hJGwpu94WvOcJCpWrOzMGfc7WCwVjt6xfmEwNgI9whPanyHTZt2cODSfhDQ5FEvQHwdms9Le9RvOLufkHPoYrs2YSNRy9ID3GJTpknDRo5bRWH/erLtVfNPr1/zxPIEs7Ip0B9u05bwwo7j/aqGzoJ9a6xEvcU/7GR7tETjAlR2qX58flJ5KDKTLO/tVQJEu+cMVgpRDVBtFTlJYTqC1mus3N38VdRzUkGpI9WrOxbqCASRD765Z3/3J1xVROqvnS67inMVr4NSpndImfJ8IHpEicbeww6pHJj5ytYvIwTfmYnrjxnVonN7d3dvsXP1L3PSVelermLo9P7Dlp2AeS3L8eBdmddhcbPUyjw/hH3Uvz0NZBLFes/A5v1vKU+NvuUNPkg9uAgGH1rBUH4UsWoLxT+vBqf1hnOyjd4RcAof6/vU6W/NO5z8J1DZunk7KAEJ4tFegJLGwdaj2ygahWCL9oR7FLvuevU/tYwZXqvtoDCB5xlmyAMW05NTpJ7FaubQC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhQRWdqbWRHcGhyWDd2NVBwT2I3ZVNNSGJyLysxbVl4a2s0TWhHellvZnNL?=
 =?utf-8?B?NEtMR3Q4UlFwcmkybHkzbFhUamNtS25uL2VzYm9qS3dFMHpaaFF1Y0EyQzA2?=
 =?utf-8?B?ZE4rOHpNUXovL3VMTGpGWTJGVnJnRFR3dGx4bHBhQmlRbHpXYzlBMkorbG5B?=
 =?utf-8?B?RXRMbGNJMW5qanlMTDN6b0tYbmZNNmNTT01PeDF2T3c4VW1mOVdKMjhRVHd4?=
 =?utf-8?B?QnhxSWFYczRIVHN3WmVsSnluNUlESkFjdGFFWUxvVjk1QjRudXJ1Y1N4a2hQ?=
 =?utf-8?B?czlzSWFnZDRvc1d1YVExNjltWEZWSEFqd2tNM2gzR1JrYzdGRVJFd1ZwOFVC?=
 =?utf-8?B?R2pYN1hYZjlVT2h2Rlp4QWxYRjAxY2xLbU04R3RyUlpIR1ZMN1ZMN1p3VnpK?=
 =?utf-8?B?bUpiYTBQeHdCOHRMK3pxanBWbW5Halg0c2tyL2thMHEvcHN5cnRvWkV0QnhD?=
 =?utf-8?B?eWRLWSt3RmsrT3BTUkJPN1ZFRlZ5OVdnMFVuUWtaNGZLZCtnUmpHeFFmYWVD?=
 =?utf-8?B?dERBNk9xTlhmNVloTm9ISWlKRzJLODFuSzhjQ2VDa0JJQ0lQOWFGL1pNK0I0?=
 =?utf-8?B?aUhPWjRnVmFncXJFNVRjdjU5U2hOYmRlQXIxdFBmM2tRckhORGlFbjhEWExk?=
 =?utf-8?B?YyswTWZLS09oaFNWamt2ZnZYSmFKRlh2ejFZRWJWL0xwS0xzbWpXdnNjR1R3?=
 =?utf-8?B?WHR0b0tHUUhNTll5MzBqUnozMktDR2ZMZ25pNVVYenBLVWp0MjF3c1JORW1p?=
 =?utf-8?B?NXZtMG9scEdCRkcxMkJ5TlAwWGQyaTlzaVpzK29PN0J5d3hnVVZjTWxad3VY?=
 =?utf-8?B?VHRqaUMyNFBmWnUxejNHeC91WFZoSFRFcG8yaEV5S2hpdjZldGhRQVJZYXpm?=
 =?utf-8?B?c2FkN21vMzBoT0YrbGo3NnJmSjVmT0dBaXhTRk9JWVJEVFUyS21xeVdyaTBN?=
 =?utf-8?B?aWgvMnc3Si8wSFM3M0VYZUx3QmV1ejBNYTY3ekJzNVVuNTNDR0VobDY2WmpY?=
 =?utf-8?B?TTUzSUtRNjJGMUlEZ0x5OEdLTnNTTE1vQUhYQWozYmgxOFB4amp5Umc5WU9v?=
 =?utf-8?B?TGR3SHE0ODkvTXg1MEdoaDJyM1J4SUdta1A4NXFLazdVUXB3NjlEdDlQcGpJ?=
 =?utf-8?B?SEhzaER5VHJJVFpsMHZHQVZFNDMrZU1uaDQ4TWIyR0VPUXhYUytFWU1kSVR3?=
 =?utf-8?B?NWVVMG0wMU94eStzWWhLZTNTOS9saWJvb05lR2s1U3BkMmEydERhbmpWbnNP?=
 =?utf-8?B?QjVVOEhCVlJlSDY1SGYweDZiRG80bGpsdGo3cU12L3RBeU9XTXhxNXdQRGJB?=
 =?utf-8?B?N2FHUlVkdmxabkFXeDczRC9kNkFldjN0bmthWlJRemgrUjU5cjM0Wk9GRzI4?=
 =?utf-8?B?bjh5YVJJRmx1YURUTGV1bEhaUi9JT0ZGUTVwNDJhMG0wN2toeEluUXkzSmxm?=
 =?utf-8?B?KzF3cm9YYkxLTDNOMHFWYUJ4MGFoQzlML1gya2NJUHVza0tIMXFtajNYRGQr?=
 =?utf-8?B?VG1rZHpxcXJBN1pLVHR2WDVWS09WVDJhb3dPeHE2eFpLbVRpRnJCYVZWMjhP?=
 =?utf-8?B?MjFmRENKNUFRY2h1Zk1ZZTFycnZqd2srUEJReGJFZURoamptVGIrM0FtcVVj?=
 =?utf-8?B?a1k3Ry82WkRWZU1YcWljWHpoUTV2bS9NNFpuWUhNL2lDclpTTlJGaWQzYlNW?=
 =?utf-8?B?Nkg1dGMzcnZheXFmTnNmVWVFTVFnZVphd1VvNmhHcVcxOFgzTWh5b0pPcWYr?=
 =?utf-8?B?SGZtOFhxd0dTYkZyTEwwRlduZENMY3orZElESUZGMWlsZ0VMSGdCNFZSc0VF?=
 =?utf-8?B?N1NGMGhVenkyakZLNWFvNHcrdms4TmFEN0JLVC9FK25XYlN2bnQwTXorbU43?=
 =?utf-8?B?MGhpSmF0YzFQby9Fb0gwSXJlb0hTc0dmV25RaWI0cjNLS2VRejRyMzVmNlp4?=
 =?utf-8?B?anljTHlMN0FHTEFoQlhYakl1R0RoVCt6b2wwUHhRUWh6RXZPdjR0RUVxUmND?=
 =?utf-8?B?Tk02aDhGY0pKRTdHVEtaMEU1Z2Q4TmcxcHFFdHU3QU5PaGJxODcvQU9XY2NG?=
 =?utf-8?B?bHcxK3BVdSs1UVpOVUNINXFrZmF0Rk45VGJZMlB5L1pkdnlMZThRWFVuUzVn?=
 =?utf-8?B?bEJiTmRNeER6ZWhhVzFsOFZMa1hISUNFc3BEd2hxa3h3eWoyN2JobTVoUUta?=
 =?utf-8?B?UjFGMjJqMVA5Snd4MXRyRDFPRUMrT0grSU02RWRuMWFnamxrOWdGK2dsbFhq?=
 =?utf-8?B?ODEyMHBWQWVvRXBDUWt5Qk9XZVhTaGN2bEpPUFlWNmxJSUhiWHIrNUViTWNa?=
 =?utf-8?B?a1luQWthTzBmTTFocmh1ekduc2pFenMyY0xOU0N1OEUwUkdHV0NkQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9466e3a-298f-451e-a720-08dee37f3a5b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 21:14:31.3988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtAqpbV8QRAleIDVS/cnZG3G56mMIjfeQ88V6iVdgn4b84cc4TQZ1a1qSQIu7N8NMw/RuEZSowWowmDsky2KKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521
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

On Thu Jul 16, 2026 at 7:25 AM PDT, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> With CONFIG_CC_OPTIMIZE_FOR_SIZE, the address validity check in non-const
> `read8` invocaction is not optimized away, leading to build failure.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
