Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D9CC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0156D10F0D0;
	Wed,  8 Jul 2026 11:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BAtx5+gs";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5527610F0D0
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 11:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cw13LpS5t+bD3KRhHKGwfM8w1QilzctKAy2VeE6Szo30LVjqynU9hLQTkda6IBwILMSMUkDsiutwUL1aWrOlafqqsoW+3hDePqE+16R4h7UPuDVqCSNo0+luCLMTpRe5IX2CfDczaghWkKbppU8jeDidi7QBPRH8U7UKZRHUVgRVmG3yjLMLSJmDHSWkYk/60ccYfZrdtSlErn42IiSaUmbIRUr+Dmw3axl2u8Np7qsj/SY58c2XuqLFiwuB7Edl8/g6PcW80gaR8L5f02lrzLrVr1WK2mNyoY6QdayorbRLULGk+RohUoEpp0Qk8+XYjCT1VKu1/W/80/9f3NS+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCNCaIoB+QLC6ZUuz5YMlbstPducbiG+1nAymTEsEKg=;
 b=dxjVTYx1CrTZr/XxTJHIdSiMb2PExbJ14sre0i2DQxroXtKRU1evGkLnyMEnbgsSbR2m0uy5L+usk6DTKoWg7bz5A8QqqoLnaxcRSXK8CQBWwQe+N/iLFVZ5EDnmZXifl7W6geKLpDUenhSfDfuZVaUlDmnDj6YqLb3cze0pGSELzJKy5Na5HENQrcwOqmkSil6TlK3qXr37YRdnlsgHSrmU2BviwI55tJ+pIQZa2DkbywzcKJS1n5gc/9lkzUhyE0SXfzhZ1mqvQxE3859h/P512qdCFxLORCECZzhyLrcA779I8U568lVGjwg4e2FYtug05rDs+CprfRdKugZtiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCNCaIoB+QLC6ZUuz5YMlbstPducbiG+1nAymTEsEKg=;
 b=BAtx5+gsgskJY8ELxwoVgpn5gAd5ikwA4Hfvm5fhh87FDTg/zISukRqQzYcGslKYajJAHjhbJx6/W3xsw72CluLeTQNz6JJqN1hyzeyAjuFVJ/C+iX2xrgNYwB01lUx5jLFXRf4r7B/2guABETB59HV4Amp1ShZsr9SeSh7jWQhC4GP0k8Bb2TUztQuhNOiBcST6nH6vDHQEjNabuCTZ1cuRkesystS2L/YCdCzreB/piXH+EQadRuj4GkiL/XSudO4p97Zp5UewmLqv36dgv9DvoWvUzGD9OocvqPS3NPANn6+hnxbJrjzndxDc6anD0Ld1XSk9WKB5FLtNqqU7TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 11:28:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 11:28:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 20:28:14 +0900
Message-Id: <DJT5KAE48ORE.28707LMPWN1FZ@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Pedro Yudi Honda" <niyudi.honda@usp.br>
Cc: <dakr@kernel.org>, <apopple@nvidia.com>, <nico.antinori.7@gmail.com>,
 <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <ojeda@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>
Subject: Re: [RESEND PATCH v2 0/5] drm/nova: replace `transmute` with
 `zerocopy`
References: <20260702120324.40388-1-niyudi.honda@gmail.com>
In-Reply-To: <20260702120324.40388-1-niyudi.honda@gmail.com>
X-ClientProxiedBy: OS3P286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f4::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6c6749-6209-4945-766b-08dedce40237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|7416014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: /rbPF8lcDR4HrotYZsn3yHNLckZV9Hrsjn9wXCbVgWgAubq1NceYdz/mAsUAZrWVf9/mvjknQGkslVwc00QyoshRpKeJBamztnoMLSqYCl1s6S4F9ov5C2kYXrK3k738J5eo5SDuU7G0uUSTYmMHnU/8fRILUpP3lJlOFnp3NzyUKeb0roPHxSIc9zRQabIB6qWg+/TfwxBIiunVNRRvfbdVQKAK5v+0P/LI3gz+HFYkv7OhztIonDlwgkyBm68E7DLWX76YA+urRP8iIOm+6Y6HNFxbsF/wCljsjbMls+919ccnCVzsBwOZUqvIXDnvQmPu6lH73w/T+wp3J9aGggk+TCDkrqDTVVepJ5QeL1iEoWdP48o/HdpiWdYn6AmoHAQdhhCZ4bkQXRvqITEdYxshych5cnKenrF/sVH25gSdGprfWNn+S+ih6KpWGII8d2vVNJqlBeviQEygzgq6psI0DHpJwXPKcqexIRhYo0iKoXpF/gUEL6a+KMT/jYg81y1cbCecb0TCPzuZMBoEGlgWFONIL7ygyQGFjmmww8V7K6Y7IKTjnccdC5IftqHnogCdhm6ZiaqeQZ2/N1FynnejdwkNzvWFESK5HIJW2N4Hc8nI+I5qCiuTMxQ4S9MNrLOR8lwGdwerZbl7pRsJUwTOYZQd3P3gwINUvlhuqqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlpaRUlWR1hWRk9leWg3WUppOW8rUHBSRG9SMTJxelNwYld3dFpJSTlLTjNl?=
 =?utf-8?B?TkYweFNwRWd1RDdyWHdHd2ZaVzB6WitKK3AyRERvSnBaRnY0SEJJejR6Y1Vn?=
 =?utf-8?B?aGZFdzNiS0I5eUQ1dHJEYmdHNElHQ0RlaUtySHEzZG9MMHNIQytnSENqNkFD?=
 =?utf-8?B?dU1GWmRBdVE4OVcvejI3c2Q5bVFWUFlRYUd0VHJFTXE1OVZ0ZjNmWll6Rnkw?=
 =?utf-8?B?ODVIQS9zVktKZ0FiK2JpRTdjaUtRWXppeWFiTWdSV2Q5amdER2hPeG5LVzBi?=
 =?utf-8?B?aFh5UkdtMFZoMjdpcEpWUjZ3WjlldlR3WE14ekNub0NmZk1pOENqYVpsM1E5?=
 =?utf-8?B?ME1EaytxVDhZb3FzZ1FKWCtUcktoYUF2NmhJL3JNRmI2bDAzMHc5Y0FKaHpK?=
 =?utf-8?B?c1pKNVNNTVRobGN2Vk1QSlR0N0JtWlZvY3pSRGdZTFVZZnQreWh0dGlvSllZ?=
 =?utf-8?B?MUtFNnZBWGx5MkNzV0RkWkYzTzl0ZjRuYnExSzR6M1FaZEhEd24wdHRuN3Mv?=
 =?utf-8?B?RlEyQ2dmUnlhVC9RWEcweHZkeS9wQWZ1VHVOS09sUWdydGpBaHdtcDRKZHA4?=
 =?utf-8?B?cXZwWVNpbU5ad1Z4bE10VEtEZFVRdk10Zk9qMmp5QXZ1czhRZGVLOEhjRTMz?=
 =?utf-8?B?THFRenBLd25vOHN4N21KT3VNV2hEOUJsK3RVaGdDQTUyWVpSVlhDdDNzVndw?=
 =?utf-8?B?dFZGRzFZZkxHNWd0aERoTlAvRWxIZFczN2syajRCbUFnN2ovaWx0OEpXbm5v?=
 =?utf-8?B?RmEvNW0xbHY3MGNsQjNmRHlVQkZXTzk1bWVVVmNadVZRSFB2aXBhVXppQjJi?=
 =?utf-8?B?Q2lNL2wybkgyS3YzSCswcktNc3NwQ2t0dytDZ3JIRXVjR3pUMGRGVWM2dk83?=
 =?utf-8?B?ZGdPSWtwSDFGd0tSdmVBRzlyVTZaWXF4N0dQN1dsWW1BejkzQllMTnZqb0Nx?=
 =?utf-8?B?RVVuYW5Yb1RGLzFlck5XemxIZzh6b1BqVDk0RGhkY01FSktScW9mNGg5Zk8x?=
 =?utf-8?B?L3p1RHpWWVlzM1ZWQ2E5MjVqUUJzSjUvenROSy9XSy9TbHBUclZXcXhQUmtC?=
 =?utf-8?B?bW1IZTFyUW9jamVOTlU5N1laRnI5WmxNRUkxRUZPZVlYTzBrR3ZGV1F4L2cy?=
 =?utf-8?B?bEpqdzROaHNmSXB5UnYwWU00NCtSYVBrcUpxMFc1eE1DUmNoNEtsTUVWWGNV?=
 =?utf-8?B?TVRlSitoSXNWUzNTRS9pejJwN3BoTmY4K0tiNHBlTzZIcHp5ZHNGUzNQMUJK?=
 =?utf-8?B?NzdCVTMvZHJpUnNhOU5ZNjJ2OG5zYUVEczh4R0JiaTdmTG05TDZKUzd1akJr?=
 =?utf-8?B?dnIraU1mZklOUkludHBRQmJxdzRQQXR1cHdESEIrTFR1QmhkYWc0ZmpTMFJB?=
 =?utf-8?B?Vy9GNWFHeUJEaWg1ZjN2ZlBSUnJ5M3FLR25oWnVMUkhVU1hqWGVFeTRYQXJu?=
 =?utf-8?B?aFpZcUN2cHNvdFdWaVF0aWJ4TlhMUjZsS2wxSW4rVHNXcHhCK29KeU9lQVpY?=
 =?utf-8?B?dlRUZ1VKckpYUEI2ZVMrUkphQWVQK3NGY2VYdnJnUkdSTlprR0pNRTdjYkIy?=
 =?utf-8?B?YlN3MXdwNmlkcXh5c21VQkczd0dVa2N4aHJZem03SE5qL1lBWVpwcWlZREdH?=
 =?utf-8?B?WTRsWElLYTBjWTN6cDV1b1ZPMHIyVUIvdUxtQmhZYTV3VEVpSk1SVjEzUmZv?=
 =?utf-8?B?Ylh2UUJlVkloWVdqOFppaFZTT3RuZWhkK1NXVU5pMGJnK3lFZkVwOFY3U1JZ?=
 =?utf-8?B?S1VSUmxXNE1PMUVkeUw4TUx1cDB2RTA3Y0VOR0pjVExlSjlKOUN6WGRZK3o1?=
 =?utf-8?B?aVNyajQzb3Urcng0Q20rUzlleHhmM1ZSTzNlYUFXcTkydzFDakFoS3ZkeWdK?=
 =?utf-8?B?T0tjclA5Z3VJb2dZQTdjN2l3MWZlS0VsTXdvakY4aTlhMWhFTVlHaDdVUkhN?=
 =?utf-8?B?YTUrc015T1FMNVptWHNaUVZFV2dKWTNxRlRGTVVJemxYamx4b3ovQWNqOHdS?=
 =?utf-8?B?TGNmRnJXc3hpTFhCYmRRWmEzUnhSUWU2b3RLSFBHS29vR2Ryam01aloyZlp4?=
 =?utf-8?B?SFdvcGF4ZUV0UkVobVZOTGZoanRyOEdkWFlmQnBXYXRBMTVib05zT21XUnNO?=
 =?utf-8?B?dVZzdHc2Vy9aU3UwdVFWQ2pXVG40QU9JQWJrL1p6dElYOUd3cGFjUzA0cHdU?=
 =?utf-8?B?OE5KR3lQNmtnQjQxc1p4OUdaMU1NQ29TblJmTElOaCtHTDFGRWgwQ3ZmVHhC?=
 =?utf-8?B?bzgvOVJ0Qkh0OFV2MTY0d1MzbjBmMm5McHFMa1ZaeFBlMjl2M2ZpYU1lcTNp?=
 =?utf-8?B?Q3dsWnV2M1hTT3pHU210ZllXblVwaG92dEZ2ak5pMndYQ3R6aWJXNlNQRnRF?=
 =?utf-8?Q?uLtp1iHFHIBMf1j1YFJFe3caUiSDYEukTknIXV65NeT1W?=
X-MS-Exchange-AntiSpam-MessageData-1: GeuLBMfllpsPWA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6c6749-6209-4945-766b-08dedce40237
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 11:28:18.2801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wU1Ast3r31RDHNW5RFAOSu+CpXJFQE68sjv0aDeh1ci9T7Ps4FqqSd6GxNZh5HRUp6KAis9APmyiZ8a+UoGETg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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

On Thu Jul 2, 2026 at 9:03 PM JST, Pedro Yudi Honda wrote:
> From: Pedro Yudi Honda <niyudi.honda@usp.br>
>
>
> This series follows the introduction of `zerocopy` to rust-next and
> replaces `transmute` traits with `zerocopy` traits. These changes are
> mechanical and don't alter functionality.
>
> This series is built upon Nicol=C3=A1s' recent patch, and does not touch
> gsp bindings.
>
> Specifically, the trait `transmute::FromBytes` is replaced by
> `zerocopy::FromBytes` and the trait `transmute::AsBytes` is replaced
> by `zerocopy::IntoBytes`. Additional traits such as
> `zerocopy::Immutable` and `zerocopy::KnownLayout` are implemented as
> necessary.
>
> Resent because of wrong target list and wrong email in "From:".

A couple of things for v3 so I can apply the patches as-is:

- The subject prefix for nova-core is `gpu: nova-core:`. In particular
  there is no `drm` in the path.
- Make sure to collect the `Reviewed-by`s you received.
- Optional, but see if you can make the commit logs less mechanical,
  notably the single-item lists - that feels very AI-generated.

With these I think the series should be ready to apply. Thanks!
