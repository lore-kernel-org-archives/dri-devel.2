Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633901098787
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1BD410E208;
	Fri, 20 Mar 2026 13:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BLrutBRr";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1B0D10E208;
 Fri, 20 Mar 2026 13:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSgFikQXg9rBjDRrhsmHMHP+MZykSTeBLIcF+wuFAtI6Yj1VI6cWssEbJsO1cgHySIz7bJ42VbOJQ7rUxjOIbrBURMvrY6sDrA5f3If7xEV08LGycdzqItNjQVu5Re970lx75SxgLIQ/aXiUeCO84VZcpo8he6qKk7h3yFH4wkcG8ff1pxCA0JAePcOkkmkfevOC8xnPXHIJ5tV1tfHE4sQNXT34GCMm54d3st3Y5MWt6KPuPwSmCjTJ8Ga6F5+sII4+JLrtixFQgxZOc9MMzfv4wOC8KQN1QUeZ+GUVKns2cf4fgmrUKGEMHgFve/3z7VG6PIXm1DauoHKaxMP+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3rO3t+XCQ8/LgTOiMvJ0OFzPAVSyrRZKCHT5r2yU5w=;
 b=g30BoaHyuMkF1QgfSzQ9hNPWYbn+7WAhMuAq4a7izUTaDCA0SpKe5+mtZaXcqLQ0IhEoSfHij2jUaPT44Mh5OG3T3SCFCIjK2dUNLRbgm1X1xvQml4aEY4rk2bS8ajHXO7ziq5fp1hR/npEHpBujGyVSgf/niZgi5nXiLDdZjqKDDMC6KmoHBlsHIyiv5N0Q/mF7aa7+FTswRFMJ2DiwX82ZNUrYsm7Gb9DHWbgIBWy9PH7s0p4QiohRFVM2TGfb+n4TPyQdUDvH3otPYGYQYopZb8vweaSyDyzgpmCY1Yk5ZxylQdMWm3dVXbvQ0jzE9KGwjIuse15SUIx/DB1jnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3rO3t+XCQ8/LgTOiMvJ0OFzPAVSyrRZKCHT5r2yU5w=;
 b=BLrutBRr465lhrFT2XTwtSgiW2qbBluCk5X+ceHNLPMD8Lsm7+EqXuvtT/8SmpGesvpas7v7rgJAuntRBY1ZWcIIP5RiNJbigRngdmx0FvWKX27tSG+lYnA+z9ALjX3mIC8KdQjTgxvoAqUKrC9H+0GEomlahP9FJFi+ar5gk0MmzdyTJXRFEZHfvOSssU0dSY7GGMRzczXLflC3/d+8VdZvJ8SKAO1AEeC1DlbVwRmJFd5HK2mgUyQAP8e2WPKyPljPV9sg7B1pP/4WU6Pk4TP/V7Q9p6BhF0yYNMfrp75Mmk2pSkCLguXXscbeZ+N6YsKJlYWZJqwvvlRTb/fLEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 13:58:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 13:58:11 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 22:58:07 +0900
Message-Id: <DH7NV48P5SVF.2YKX6XR2RBONA@nvidia.com>
Subject: Re: [PATCH 2/8] rust: dma: add generalized container for types
 other than slices
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260303162314.94363-1-dakr@kernel.org>
 <20260303162314.94363-3-dakr@kernel.org> <abj5mOYQAY290nqY@google.com>
 <DH52NZ8L28QN.JTWZP7UBYL8Q@garyguo.net>
In-Reply-To: <DH52NZ8L28QN.JTWZP7UBYL8Q@garyguo.net>
X-ClientProxiedBy: OS7PR01CA0291.jpnprd01.prod.outlook.com
 (2603:1096:604:25a::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: f000b4ed-7420-469b-3df4-08de8688b8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|1800799024|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: l3CaULEL6QO12AXxHXtLAFxcQhzErH/3osii+0t+yhuoKv/carWSBtVZDcm+sjrIyu4oBY09oMf9kH0a29A49zPzAn9G2JSHVfX1aZY23gDjVB7XPhS3Oj9PKG8GJ279Svgr21G5eGqzDmtkfYyyb8KvrRdwpVA9xV+5GSJq/WtpszlJsJMXyzE1EfZhew8RrtHw7Y1p1nxYplQp5tx3hQBIM23mekGTK7IFI0zZw4W9XC4djaSNo3ylWXOjBfq1UpQ11aDzOchfe6/6du/1icVQ9NcOcIiHW+Jvnn+dKHdBpOg88EecJVYAruCmfoBvyMnFWvsgI9HluzrzygZY0rshs0hV4M5bRG7KRYhftoUKZm1r06xGVM4RMaC8NFQFxgphHqaBUdecG6tWn4zBJhGV7ZmcTzDNHH53LL4zH7X1tiC0rVyp+h0OlZzPNTzbqyUja4DBcJSv6ZDae5khxhpmuICprdydNOiT09mV1XoLb1ETti606O8XUNEpL4qo5WIo1hqJaRBhUrbX8iELS4ZstY0+x/yBynhgv0NosLE5my5GgLZcG+f9z3HrU1sH0f0/xg09NfBDz3eeB7vqqNst9iHiSTnmugp4sls9rQb3eQ6FgwENjfib2Ai+FzGeGCtmDiUavxKCz88iHhWwUN0+uFfvEZwnlA1i33lEYwhEoPxINfcjl4+LmfBBNn53Eq81ZUJ2GQ2NY2To5PSLivb+EyT3oHhBzcOqejY1gts=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(7053199007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2RmdGh2T1RGOU91cnJCa0Q4cEdkNGtLelVZcG9kd0FjRlEwYTJnQndHNTNS?=
 =?utf-8?B?eWJ6R1BFMW9UTFFJNjlPT1hucDlVbWxFdVpmSW9qcHk0RThWRjVORUs1Z3Zn?=
 =?utf-8?B?THo4OExjUEVETXdocjl1dCtoZC9BK2xzM0xZem9EQVZPUUlBNU9oVHJLbW5i?=
 =?utf-8?B?MlQzenhpU2hMaTVvbTIxTlZsMEpiTllHSlJJb2paV2NVTk45YTBOZ1p3aFJm?=
 =?utf-8?B?WjI3OVJadU9Ld1pqaDJjMjlheVJEeWFwYkdqcWt0K1NOVWNnWVM3eGJCWjlo?=
 =?utf-8?B?ZjBLMUhIWUp2WWR0MGhJemhlQTR6S1EvZFh4LzFubk1BaEJkM2tObHljaTNh?=
 =?utf-8?B?ZENQM2RWN05uSkxRTitmY00rdTdLcUxGWlRCcEpaNHNmc1dCZk9aV0tKalVn?=
 =?utf-8?B?aGo3SzFYaHJ2dmZyZWtrYjJsNWpjSVRCMTJUWWN3bGJSTWR3dXFwcEhuMVZR?=
 =?utf-8?B?My9na1FGZGJSZGs2RkNXc0drcFgxdWU1NjBDTkFPS29zeWdpUTFKbXA3cW1y?=
 =?utf-8?B?VUdkZTZsQjVneExKSVB0RGM3T1BqdU9zN3FzbExUSmVZek42K1E1WjZRajZh?=
 =?utf-8?B?YktRclpvdjJYOVcyTlNGdG12YzN3R09NZ2tyY1Zva094Vng4bkR5MFFTc2M0?=
 =?utf-8?B?UGE5emFGUWh0ekNXVnV4QmpEWjJnelVMc2drZmpqWHNKbEhSVVdxN2xKUFlN?=
 =?utf-8?B?b2RsSzg0VmRCNy9JdWRGRCtxZUhzS1loVVBuM1MxNW9FcXgyM1ptaTVyUW9j?=
 =?utf-8?B?NHJHeW9LaDlxVDhMZTFLYUR0NkdNYzdOaUdoODZOWEdVZzZDSXY3bFRtT0ZE?=
 =?utf-8?B?WUNUQjNIYUNjS0NHRUxFK2hIQW5wR1pMeTBuUE5mODNFNFFhcFJ3VDMzVHNq?=
 =?utf-8?B?UzNnWkVoL2ZaaU0ycUszRVlYYVJ3Q3NDOHB6UlR2WFVvOGVOd1drZFJ4OCtL?=
 =?utf-8?B?UWcxallnMlVKdEhFU3RJRGtGNUhJSlhTT2NBTEZna2lucXZoekYySzZtN2ZE?=
 =?utf-8?B?NERwYng0ZGpPQUN3dXlCL2RHSmdlME1SdTVMWGFZbUdIUHI3OHhweW5qRnYv?=
 =?utf-8?B?bnJaM2ZScjlrOVpWNEE3MkwwTitKNmNTYWc0a3RKbUloaTExRUNMRWtGemQ5?=
 =?utf-8?B?ajhaZUp1YldJMm44VUtPck0xU2pqVWFiUmNlNGtKRXlheGVSMDNzd3NNaDU2?=
 =?utf-8?B?SjBQaVV5Y3hvTi9keEcwMzZGL2diaUd4TmZTaFJYL3EvQmtPREF3WEJFQlll?=
 =?utf-8?B?amIwMmFuL01FSUlIeFNBRldCTm1iZE9KTVJYd2hqTkZNemxKbjlLVHBWTWZH?=
 =?utf-8?B?R3ZUMStjYm10R3p0Rm5qMkxpQms0RW43Ymx2NS9OM09nOG1FL0xORmpxUEN3?=
 =?utf-8?B?UTdFUGNWNnRnSlRRVytOUDlUN2hmdVFmelU2Wm5zTXZmcnh3K3ZvMmVGcVBI?=
 =?utf-8?B?T1FaZGZqbnAzTkJySENnRzc4a2NTNzVOcmZHcFZuZE13SmhGMGxDYlkwUnAr?=
 =?utf-8?B?Q2ltTThiZUQ2cHY2K3RxcVBhWGFNdlVzRnN5V1NER2lTaVZEKzQyeDRwS2JM?=
 =?utf-8?B?U2VhRmhaUzN2UzBiM0ZmcEx1b2NxZ0ZKZEZmSGdRbHdmZkxRY3lmZ283eG5D?=
 =?utf-8?B?U3VTOE9yd2svekwwd3lraE4wellPWjhvajg2empBZkZPUTROUi9FdTE1Y1R0?=
 =?utf-8?B?aHhQM3dienYxb2tFaFU0dkFkcWZxQ3R3RmJMbDRDWVc5NXpOMUhmbkorY1JF?=
 =?utf-8?B?WUdoZHN4Q1BMVmRLVWxWaXhnSjlaRFBDV1VYWnhwKzVlSTNiNVFQZisxY0JY?=
 =?utf-8?B?RDBrMXV3NUJxYWRldVJPcUk2VithdU5VVjRsUUxJZUVDTXg3Qlc3TEF1bzJl?=
 =?utf-8?B?VFBiNGhJZFNHQi9MZXdMN0ovc0hIdUNRd3NYWmNyL1dOQVRRcklOQlg4aENL?=
 =?utf-8?B?YUtwS25sRzFKWXEzbm01bXU0cUVXZlJkSm5KbG1iOURCKzhWYUt5VlZtSjZX?=
 =?utf-8?B?VTduMUVMditwQzZpN1AydFZPN1VHdnluclo4MFcvVnJ4OGRDMldXUlpkT3FD?=
 =?utf-8?B?UXc1ekNTN3RacnQrSkVwSEx2ZDI3YTQzQXlqaEY4ZUZkM2hOaWFLTDJjbHFv?=
 =?utf-8?B?OXJpRHo5YldKajVnODcyYjhtWUNQcXM4dG92clFOOUpXN2xmQkpGZUpUN0lM?=
 =?utf-8?B?L2wzTzhacmZ1Mmc5MHNMb3NmcUtMRFZVV2NReVE1NktpZ3gwR0tZM0xUVllP?=
 =?utf-8?B?bjFxemt3OWxyK3pIVjdicUdBdjc0SkhpeEU1ejNKdHd5dDBWZXk5M2drTkUr?=
 =?utf-8?B?L2l5ejFvdndPUjB0aFhVN0FWdWt6dEI3b0tHVTIwOHl2QlpaOFlvNUJJblE1?=
 =?utf-8?Q?rS6YidMXoLtwZBh29frL8T5v8pz7z8Bs8g5rJ4fZPocDe?=
X-MS-Exchange-AntiSpam-MessageData-1: NqriBi45XweAtw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f000b4ed-7420-469b-3df4-08de8688b8cc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 13:58:10.9202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubdw6xWIlEQdYmMyovJ4mb8nwp7VYytPWWp81m5PDa5eWjEM+xUk5iP9btHB6grw2dVBvxRNJWLp/Ksw19rOVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
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

On Tue Mar 17, 2026 at 9:56 PM JST, Gary Guo wrote:
> On Tue Mar 17, 2026 at 6:50 AM GMT, Alice Ryhl wrote:
>> On Tue, Mar 03, 2026 at 05:22:53PM +0100, Danilo Krummrich wrote:
>>> From: Gary Guo <gary@garyguo.net>
>>>=20
>>> Currently, `CoherentAllocation` is concecptually a DMA coherent contain=
er
>>> of a slice of `[T]` of runtime-checked length. Generalize it by creatin=
g
>>> `dma::Coherent<T>` which can hold any value of `T`.
>>> `Coherent::alloc_with_attrs` is implemented but not yet exposed, as I
>>> believe we should not expose the way to obtain an uninitialized coheren=
t
>>> region.
>>>=20
>>> `Coherent<[T]>` provides a `len` method instead of the previous `count(=
)`
>>> method to be consistent with methods on slices.
>>>=20
>>> The existing type is re-defined as a type alias of `Coherent<[T]>` to e=
ase
>>> transition. Methods in use are not yet removed.
>>>=20
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>
>> I see you have both `size()` and `len()`. I think it would be clearer to
>> rename `size()` to `len_bytes()`.
>
> This is an API that already exists and I simply moved it around so it is
> implemented for all types, not just `[T]`.
>
> I also think that `size()` quite unambiguously means the size in bytes (l=
ike, in
> all allocation and I/O APIs, `size` means size of object in bytes); I don=
't see
> much benefit in renaming it `len_bytes`.

Agreed, furthermore `len` is used in the standard library so the pattern
of it returning a number of elements is pretty established.

Generally speaking I tend to prefer having the units mentioned in the
doccomment rather than the method name.
