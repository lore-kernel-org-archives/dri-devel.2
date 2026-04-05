Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFC7E63FF9
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 02:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A2810E00F;
	Sun,  5 Apr 2026 02:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jTJ6Y1Tu";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E6B10E00F
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 02:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/ada7vmIgD4qN/BCezoC/0m2fVtoj0QvSK7sJHZ+idM7BYvREDf+V91fCBWA9/bVfbm4FGtTRvSV5xc0TyJXh5v+cqIDGsrG0lsP/JhpyYRxhAAtHB+HWbfYLXFppPg8CQaOYIZb1yqkIH7Tj7b5jNX/BguZDDNCbTU1KAbhVyYzckc5epASKP/UwOqPq4W65E2mEKnmI3vAaHbdGGxyyCE872qfUd0iFUU45YQU4//xTWddJr/wUkPG8m2vwbBGfS0GlX32HkfcppTZIyIBuOeQDdt2+xtntzER8mwMOT0rJ3sL+RXEV1w472GnUKorf8HFcbm5fieLYrBlsXXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CDOdwadUj4ser+e/ydtv+zWx5vnYrT6aEruDrKQ8CU=;
 b=uQCWLGgSfiT6fOH6hYpM1i+tqe7qpJ0CqYwwvrHvYz4cYudkanY+LYqPafJu4aNkkVGRFKGjPzuK4rvyQUx8F4hdeDLAtkz25ibauo4K7Uk/llU6zR0Nb3P7m+2lB9S1Wfv9jn2qNfCj1ziAi3qJ6X+K6DXe3x4fgGtiWl4TI48rmldEmKKWcEA1mGCPdgQ5KAwbqBlGy/2SRHEvWOovhuOxFqtcbss5ZOP2kiSpGA5M8Qd7V30wNgedKmOe3k7SjhTL9+u6hGkO0y67+gedOOdyErR6UdmQscoPgWEkdoyX/9OwS0raE0F6V2Wzam0nt3LKYIPNR55ukC6QA3BMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CDOdwadUj4ser+e/ydtv+zWx5vnYrT6aEruDrKQ8CU=;
 b=jTJ6Y1TuUW+1QKpoIceZzVFe13QaJweUz9TqrhrPyfOiMokZk3jUWeXUR7KatuEuOfogvlSe+PX35mT1x3DoM0OSlR8oSUvOxf7MZJa4wTVrMYe3q4UIhrdtJ6IPzxpHG+O79Y5Gu0cs0rs4yrZlKPr9MIc0MhV9fy2vD/ku6TP7OvHQoTNMEQBKqHT6pblp/Wsr5LpQabQirzRfF5Wby993a4KMZN8eLtUoZVKJ84O5f/g5bBGU0PZXWHI1lBePp16V97nGGrEOFTb1aa/svRxKRJxytyhzlIU2cSuzas/ZXPyNQhVdhmPB3zJgEGserfNWIQqlNGwh3J8wY+nzVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sun, 5 Apr
 2026 02:12:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Sun, 5 Apr 2026
 02:12:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 11:12:28 +0900
Message-Id: <DHKUVJPFY5TD.210EGM8FP4IHG@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: falcon: align firmware DMA object size
 to required block alignment
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>
References: <20260404-falcon-dma-roundup-v1-1-1f56d808b091@nvidia.com>
 <f7cdbcf5-0df0-4cf3-9710-31a5415973e7@nvidia.com>
In-Reply-To: <f7cdbcf5-0df0-4cf3-9710-31a5415973e7@nvidia.com>
X-ClientProxiedBy: TYCP301CA0085.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: a0123fd4-6af6-4d42-b8a5-08de92b8cb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dEnjlkA5M9/w8zu9SEyez92bx3R7NyrPlKetHf7n9q6nMkKNRmndo6ChydQCDwC3L8JYXCY2U5gD8TfG3YQqdkKle5tv5kJmInHXLk0I8tpFU5ycyGHdKUo7XQC58y495MEEAEKa2q+n8sQ3GZDIFGwemI3dmC/0+WoFM4z15K2zwsYfzl+RCV3ZnB0C1/CEKT7+h0qc+KOFeVRPe0yGFsCnSrplEe5KFA+BggQLmojjAikwnFfhoHV8CudW64mUwOJ4B3cbBxS2MLOaBkWikbm2LoOyJSEmbgjA3nxJr0TGMiE093GMUZipNWRu1qiDCDgaJ+AGeR4tiNkqyz/HahuFo3d0OuWu6DlUEZgjWxGziCFQaWSMwhDYMRULK4ToepNt9dDuxqDqPEYTuUXKdkZL7tXQjgbJBSQlb4Hl9vAjnZANd80U1ZdT0OC99JJLjTgB4ESnb4qRGhy0cq2nVWBAVCtYtz3zbkS+WbhY+Th4uvOUS1IwqCUgCOQmIeddna7VpSKaPokI4vz79M06fXBRqkkfCF/8v5BqrKCpjQ/+73RnZTqgmeeyq+JeT4QpaNZcLX5VLWgnydZpvDMjalKuShpThLdLWTVPXuxtmMTTbCbfA1zvnyIgofX1i02cO6vLx9gc+EEbT4FozcOJ3jitIetviPhJZuBkwsFqmFDKhqrS+5QjpzncVeJ8McYiFVxWeOOPrJnprqDTv9QHtr1aDJdf+xUi21HSk5YZ/Mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJWb05aMmpMYmJsM3cxSWJNNW1lMHltUWNOdWFtY1paNW1OcVVCN3hvOUJX?=
 =?utf-8?B?OXo2SS95TVpoUWpaazJ0ZnFHWklndG42QzV4NmpoUFFhbEtldU9OZHF2a3pE?=
 =?utf-8?B?amovc3NqSjdSNmFSZERkdGd0ZE12SDlDTmc5VjJJVEo0QUNyZmNRT2dXNCtO?=
 =?utf-8?B?ZzQ2R2VaL3BzQ2t2SERGaWZOZWdxUGJpeTZFUUowSVlCcVdEdXc2VzBrZytu?=
 =?utf-8?B?enVJVnphUy9sYWNPRjJIMTAyekp3M0pKckRWRXpqL1l2OVoyOWYySVJ4M296?=
 =?utf-8?B?SWVHK2tiY3NVZnNJKzkzTVFyQVYwWGo5YkFReGNzWW5TWVdhM3Evc3ZBdXFh?=
 =?utf-8?B?TEF3ek1zRGQrem4vbHY2bWdUY09TRFR0YnkvV0cvZnRLbXpSYkVyekdRaFVD?=
 =?utf-8?B?MWhGY2lUU1h3Y09sYnpjTWFLUFhlVTVJZ25FTmdhNElnWituYnJxQzIzdlMw?=
 =?utf-8?B?TS9ZTjBKSmVOeXdrbE9zd0V4ZW5SdkVRV3VURnMveE02RUpXeUdZUFhDeGQy?=
 =?utf-8?B?Nm9XSSt2RTdUdXZyeVpPOWNVTDV5d0ZoV1JyYVpKbFZ2VmVUVlhRM1NuM2VO?=
 =?utf-8?B?eWxTY0toaTVOblJwdVF6UllQUHZiMGNZaHpUNmhMU0tzZmFuSmw4UEUwVHFB?=
 =?utf-8?B?cUJMSVNsRGowWU1PV2RxU1ZZbmc3ZUk4LzZwSzFERlRGckphb2RZT2Vkd09M?=
 =?utf-8?B?Q2Z3OGRyM3YrWnNjbUMwWTRnT1BvaGd5ZFBNTDFGK2pkM1B3N3hhMmxGdnBw?=
 =?utf-8?B?cEhzMG5YaXF1eWVJNGtQNktLMUZybEtGOTZ5Y2dhM3RPVk1BM1V0enlrSnM2?=
 =?utf-8?B?NXFFVDZrY0IzZzkzKy9wNmlSWnFzdzhVa3M3YXUxWkRHVWxqZmlEUlBxVVBn?=
 =?utf-8?B?cmRpZXcxSllkZ0J5eE5wTVBDa2dyR3FzTnhydTBqZy9Zbkd1Vll5V1hDN2pV?=
 =?utf-8?B?eDJTWHJ1RE1Kbkg2ZWpxejErRTRYUmJaenZKM3FFejJPakFhYlZjYWkzUGZx?=
 =?utf-8?B?S3E5emlpdUY0NHl6MElNcEZSUFZGL2dwMWV0QzlkdmYybUcvUzR4U3JTbGhx?=
 =?utf-8?B?YVdrN0QxbnBMSVJ2Ni9oL2dEaW81ZE41a093WExuL3NpdkM2UFZTV1BCL2x2?=
 =?utf-8?B?MzUyMTVKR1Y1dk5SMzdVeWRJZWNRS21WSy9ZK3RxVFNtamhSNFhINDZCZXUv?=
 =?utf-8?B?bWExdVUrZXZ5MGJsQkJqQ1V0VGMrR0JHNDBMNFNtaS9pWVpuUFhRa2N4WDJ5?=
 =?utf-8?B?SFA4ajNlSGI2SWREbTkzQVIxL3ZBbUhNOUxlYm9HcHV4VlVyck1zQTN1ZHl2?=
 =?utf-8?B?QWJiSHRFL09GcnB1NXJOR3kwMWtlbUlYZzh4NDNybWRyYXk5WTIxMVNNSCtW?=
 =?utf-8?B?T01Kc0gzMHRyNEdoZUlJMVhXSVd3dVkvb3p5bTJUbGRGZFJXWVNWQzFrSitz?=
 =?utf-8?B?Rm1ybHJqYlRmS0NzVzdqSndRbnVSYUlwR0JLMS9QdnUvUk9FbmlzcjFQNU05?=
 =?utf-8?B?UytWcHRIeGFVZW4zM2pXak9GZTlFL0ZpUzAyaXJXU3ZyVmRIVmtLUnkxYS9G?=
 =?utf-8?B?NXA3Z1lMQzVITnRUUUV2aGovTTc2WmoxSnJqdkc3bmYyUnJoRUJqYkZjRHZY?=
 =?utf-8?B?U3JqUGcvU0tMRCtWa2I3SHE1bzlsSUtLZy85MVhQb1N2OWk1RjV5b01RSUow?=
 =?utf-8?B?WUwwQ2xoZk1TbGNuNkJZSkhuQlI2Qmp6Zk1vRUV6V01MVHozRndreUQvWVFE?=
 =?utf-8?B?MVQwUDVNL3JDcmc0K1dYN3B2TFVYRFpkb3FrN05HWjJhbllJekpQak5TaWZS?=
 =?utf-8?B?UFJEbTJCQTFKS0toSUJ1Z20yejBDdkFNZUJ6RVFObDRsbUR3ZkNBelRFM21k?=
 =?utf-8?B?ekZmTzZWd2VvbG1ZalQ5cXNkbGFCMXhqQUJuR0N5N291M1dRQVl0VWR0bWpP?=
 =?utf-8?B?cTIwekp6cC9HWGM3VlpybjBtMzV5Ukd3SDV5Nm9hS24yamlrdDN4d1VKUGNq?=
 =?utf-8?B?VjdMN0NGbjdwaUNSUWZQZkMrZmttVXpBdzBid1A1WElVT3ZId0pQVlk3NVZa?=
 =?utf-8?B?cjFTRFQvYnAvZEJtWWwrN0s5eFFPdHZLc0JDN2RhSHg3U0hFMG1Wa2cwZERB?=
 =?utf-8?B?OWZheDhYT1Q2WSs3S093T3V5TjVHZ0Ywd0xXU1M5QXlYb0Q5UVJnejFMQnQ4?=
 =?utf-8?B?QXNLclRsOG1QN2t4NFJiNWVxeUhuUHJwTTRuT1Y3L0I5N3ZPL0FtR3NHMWlO?=
 =?utf-8?B?MTM1NmI3a3pQR0RLU2toNTlGc05zM3NFK0VSMmtoZXdNMXlrbStQMzdVTW95?=
 =?utf-8?B?ckVGak0rSi9SczhwalIxcWVFdjg2eHNzRkZoQ0ptcm02VmhsczNmVzZLTkZu?=
 =?utf-8?Q?sDo43dQlcDsILBFRMufjv+SzvP3Js79qvgUjQ+GCifHX9?=
X-MS-Exchange-AntiSpam-MessageData-1: sKv+BQNf6td4Eg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0123fd4-6af6-4d42-b8a5-08de92b8cb41
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 02:12:31.8608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2CdI/xB/kEnESLVWGVhrzmXLip9D8woAwXF/Ofn/8dM0GUYK1eaw7cG/PQq7yM9u1lh6yoa2JakKkXHxNOfiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
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

On Sun Apr 5, 2026 at 7:24 AM JST, John Hubbard wrote:
> On 4/4/26 5:14 AM, Alexandre Courbot wrote:
>> Commit a88831502c8f ("gpu: nova-core: falcon: use dma::Coherent")
>> dropped the nova-local `DmaObject` device memory type for the
>> kernel-global `Coherent` one.
>
> Hi Alex,
>
> The diffs look good, so:
>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>
>
> A small typo in 3 places changes the meaning enough to throw
> things off:
>
> The subject line should s/align/pad/. Alignment normally means
> adjusting the starting address, whereas padding is what you are
> doing here.

Oooh indeed that's a bad one. Thanks for catching this - I'll send a v2
to make applying easier.
