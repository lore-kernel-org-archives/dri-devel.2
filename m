Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1CA606A337
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cWzOig87
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC1410EFA3;
	Tue, 10 Nov 2026 10:35:30 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44B4010EFA3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 10:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSFy6+HiXzorWbAb3DTc5jCo+3Qzki/vyxPDtZxq2Nj3dSRdCIOKUuKcytpWgBFaMHy90A+zXpH0fe6OJzHR9MC0bNVIWh015HGJbhDh64ac7Sk0m1ZIUgfDKVEheoIu0oJcvhLq1dDKaIZljU688A1rg7ZieTdHgtwT6AicVqs0A6e8fRtpuKh7HkSGAdkfHkW+ROe3e6TLts4pm0VIqCe5+PUP7y/s+ADxuYMrXxJzUt2vg5/5mdmITObshR/cXkTbiLNW3PhkKl6lewpbJR9crFqtMonmV28oGO0ElIvDbKDna/mZgbqbBfPve6s1aIBFp7r57qj1n+3sWLp6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwfYXsIdfpmBf4/2YepCLwVvS24ohMONopp8RJiFIjY=;
 b=AUaCMh2xHtGxGH4+VagkzdH7RuG3Aee7s2Dx/DwywfaQEtrmty9G0QYfn4+9geF9DKihg6O0heJoxTBCam3kSWxzDeSBqUVDr2/0o3gS8wvr7TDX/Z+gbRrHJqSibx29qtncgO89hJzHWge37J6WZsZ2qwpi1f/qKEiz61KT7RnaxuhIo+JVGbro8FTXQsiWTqrxZwUtRB4/HD9Jm8ebW6JPplZQoC44pvXzVlPRkvU8/ZZ9ljDijr59FYSkMneG7Bgf5wci2gsJiUSoi25OvLmRwCTQi3521W41HbZ46i+H+P/wm1imefWD9A6dv2rQFAMaaLFdEZwWNpOFYUXpSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwfYXsIdfpmBf4/2YepCLwVvS24ohMONopp8RJiFIjY=;
 b=cWzOig877yawnBfw3XTm9MaPfHfltNr3pJ175ZrL1IIiW31bRL1CL/ftT0C0ijKNXUiZH6SwZk6RCa9+0AeCxmpZ+fV5bGH41tICaKIerWGsIZ5fBujnUsbOAz7/V5hNfzFI2yEfenHV+XeACtXEEUYTr0IMWN3u3NOSk7PrzGUdxfFloek6ZPDGGXZ588Hx5m7I3Y2/5uXL8m3JeWgJmdA9XmIncpjtcI4V9zE0ti6ky67V+UudfUboiQYlpIcCneI/q3iFyRzbu9Yh5N2/RQF8LUeUR8XAdWnlg0UaUntjvig9ct1ncKBKP3vU/nPdz2wRqBThIW1Nof9Luv26WQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 10:35:19 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 10:35:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 19:35:15 +0900
Message-Id: <DMRGPTJ9CH1A.2M8LD751KZRIB@nvidia.com>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <ojeda@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Matteo Kloiber" <kernel@matt3o12.de>
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
In-Reply-To: <20260831233215.287881-3-kernel@matt3o12.de>
X-ClientProxiedBy: OS0P286CA0101.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:b1::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS0PR12MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e630b4-8eb9-48d5-abc3-08df3f1650cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|10070799003|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006|261022075727099003|261022113327099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: cRpI0GrYeMKlBFr+eY+PCZroof8B921FwzHHjwzZQULdX9c9bRTbX/Zio+CY3evYETO323W437Y1QIStnN2Hqd32yDhsXxLHh81yMe/lBPmuhNTtGNN3Eq5CrHK0x6j/G6+NclMm4lS9P1vvdEiO3LZfQO4FR4cZYKIzZQnxRwm2qegCd3l1oaRA8VR3XdLy0v1evklXPkHAjRAPhrk4WKzu/e5yJasy2yqgG2S29aYaCeSu2cbkHW6HOCVj9A/FMaFS0KvkKMTP1VaBeJSFqXVI4iYBdQc2XBSAhMe1mtfuNSJ5etteU0TGB9VXudax+K0xoy9DneuYUmq9etV2Qd10ahnflrjsPvc00XU9mprVNk3XHT8zVie5xyeI7GTmbrFjfagDqEM9P/F5q7O0DkNKLLaE77umXUjzq1RRD9jwpdFTDTbl2H3ETniEA+QaovZ+6pimNpffCBboUHFlF4qPmpM76RqiWVHMGAgOpyzt8YXRcjB8Iq1qSOFi5UT3ngNMkvd/4SzyMsmSxaYCqfZiUuhDC6USuxcX2RL/PcxDnasC09J+KDtJ73sH8oDe6MADG0PJIZgmDj0kgIZEY5S/FD4kJQpj2nsrK2rGJnzZUIcTeaQl4nubYfpb8p2yJNemZ7nCZXrShLzAToVQPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10070799003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261022113327099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hXNStFKzB4TlllVXpLQ2w2K0FJTmY4NjRreGQwNXE3eXUvNHkvUVRiTUR2?=
 =?utf-8?B?Smxmd1pVbVRDOWdERHlNWmJFNXdaSkdaM2RTMDFWMTNkNGdZcWNMMXNjSU9E?=
 =?utf-8?B?OEtNK25BVDFEMGhXZStCYnAzZWNEcFRpb21CbDhuejJnTVJ6dGZYMXd5OUhm?=
 =?utf-8?B?NWtMb1N4blJ4TXE0ZTNtYzAxR2k4NkYwVHRrODV1c3NzbGZJUW9leWlJbTlJ?=
 =?utf-8?B?NHRjREUxWXFrUWgrVmtDU202ZGlOSDlCSzI0N2ZHSUd1TEVwNVZxWVJEYUR0?=
 =?utf-8?B?RXdBSUZCMzVaM3JLL0l1R3VyZjZMN0NLY0YyTDlNTytkZ0FHbmc2cmUrNHh1?=
 =?utf-8?B?cUZVMlYyM1h2WGdkZEJhd2ZUaEYxRDhvMndueHVxTTBIWVN2eUhiMktDVkov?=
 =?utf-8?B?UEwxU1RwVWFZZDhSUW90YlR3aUc3UnIzcmI2bmF3WDVoUGN3WTJicS84dXcz?=
 =?utf-8?B?VFBpY09Bc2hWOVJxRXovRTc4UlpWSWROMWdZd1VlaDBRbkpuRWplZ1o1YkRr?=
 =?utf-8?B?WHBTYzU2Skg1RnZwNFlwMUdqN2svS3VHaW9LYzRDREVONXl0M2pabnBqY3JT?=
 =?utf-8?B?bXJRbFgrZEEvK1JySFJSUTA1RUM1ZnlMYjdzQm1QVnI1d3BHYjFhVWJyOHAy?=
 =?utf-8?B?TDNEZFRWZ0pyekl5TDkveHQyMDJleHgvY0lhTVk4UHdNM1NmMm1Ub2dlMElh?=
 =?utf-8?B?Z1NHUnFhM0NSQkx1MUhNM2dyUjBwVVdnTWorTG8zM3NUMitEWStVUXJ0aEk2?=
 =?utf-8?B?VmowczhiamhSM3JIRGs4SG5yR1NCYUlpM1d2YkI0bklETWI2bVBneG9Ra0dY?=
 =?utf-8?B?cHJKNXdWVi9scHBucXFETHVqbUZMUVJ2TmU4ZDZoY0RFYVlhOEhqMTZRdVVO?=
 =?utf-8?B?UDRBbyttc3ZDNGRyVXA1anIzYTFacEs4UzhveWlhS2hBdUl6OTJPR0xVMFIw?=
 =?utf-8?B?L21ZRlJyZkhiTU1MbFVBdlZ2aVlGc0MrMkF6R2hBWkdKM3crb3FwQkdYQkVY?=
 =?utf-8?B?WTRYdGVNblp0NlpyVUVOZnVtNXhUSEFsSzNnZXFBQk42ckRFTHovVUNLR25h?=
 =?utf-8?B?WXJ5Qk9uWUtoaHBlL242UXdtbC95cDVCdDdiSlVNZ0ErbUE4UVBpZzRVc3dq?=
 =?utf-8?B?cy96Nmh4c2J4cWpjNllMTFRYS20vdEdEeCtGMzRTTHRJK2FFdEdJSTJFVzJ4?=
 =?utf-8?B?NkwyQktjUUNPZGFwR1ZDMTRpR0JzZVg5WnRETThPeTIveElvQzJFbGtiQllU?=
 =?utf-8?B?U2p1V2pEZVpqMkxWMElZQzh1TW5TNDBuZjdUQ0pDeWtuL2t5VGQzSGVCdm9F?=
 =?utf-8?B?UFRRYUJ3QWEweXV4WlJSSTIvZlh1UVhGMEtaOFpjNmdkTDNUUDBUYjUzdkdR?=
 =?utf-8?B?ZnRBbFdDVm83dWZvRGo2TzBCS3VNMEZ0ZUROdTlDa1M2WG1ncm85c2txVlgr?=
 =?utf-8?B?Y09hYU5vQUQ0ZFBWdXc4dTlOT2VkT1VHU2sreHBBV2Zwc2x0M1Q0dDQwSDJz?=
 =?utf-8?B?YS9ZYlVIRHdSMUlDZytiT0E0ZFVhVWx2TlhWdEo3d2p4eUJMbGF0VTk1eEl6?=
 =?utf-8?B?eVoxTWEycWUvYXFUY0JMY0Y2ZFNHUnNCUTJ5bHRvVldnNkVCVWxHYWt4cEEx?=
 =?utf-8?B?bUVJSS9WMTlkVWxDbDZTZEVUMFEvT01VT05aL0dsY3RNcTFCcmtzcGRMc1M0?=
 =?utf-8?B?TXNFbGIzUFVnOGs5NGxPOHQyRTUvLytVL0pHbVhyd2RqQXQ3S0hTY1I0bE9y?=
 =?utf-8?B?L0xacEJuWGhSU1FOS0dmYWRXTTJpZDdXcTZWMjc4K3ZPMTV4T0NhdytkdkpW?=
 =?utf-8?B?N0VlQXpuWmtFcDcrRGMxcmgwTWNkZzlQZFhQQW50ZUxuQjFCT2p0dTR2akNZ?=
 =?utf-8?B?UU0rTCtMRkxsUTBwVWVnSlZoUzdkK3hLYWYxMFNEdmluQ3czVUVKSzUrdHVl?=
 =?utf-8?B?QTROclJxMGpCNFl1OFRxbmo1ejFTK3NYVXlSQ20ycWt3WGtxVXp4MnlnWFRq?=
 =?utf-8?B?NC9CTllFVmFwYU95aGxiSEVZQ29oSFU3cFRNNlArNHIvbnRZd3NrR0I2NllO?=
 =?utf-8?B?SUp5Tk5KSjNoVGJtQ2FrZmp6N0VwWWV3RUltUGZaZjVoQUZrUTROcCtybEJC?=
 =?utf-8?B?bGc4d21ZYkZvTEV3V1MvV1NETVA3S04xMHlPQ0IzZXFnN1dIRXJMbjg2Zlpz?=
 =?utf-8?B?MUtYUERsWW5zNHd5MVdXQVFLc0pHMnBUbjBJRlB6aHFIRlRzTTNPYjNaS2Jy?=
 =?utf-8?B?WEdWWTBHQlRVeFpoa00xazcyc2lKbE53WkJHbVExVEdFc0Fja04zSmk4bGFB?=
 =?utf-8?B?bnRUd3dEemhsTTNhVmlCK1BxalBJeEtBMEFON1dZT1NjQkdzdFpuaGhjU1FZ?=
 =?utf-8?Q?vH7K82K+L+hONNxNZ0LRXfZVlOzk1Z2CgZIkiSABotbjn?=
X-MS-Exchange-AntiSpam-MessageData-1: kN+vnwsEI9/Gpg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e630b4-8eb9-48d5-abc3-08df3f1650cc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 10:35:18.9113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RisSVmuTpKcGfF7xvXbxfXGN0igRU4/V1/eWL4lNnqUzt8Kqxxwc6jAv/ujHFKSjI3jC7X5s3hapEtIwaVX/gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Sep 1, 2026 at 8:32 AM JST, Matteo Kloiber wrote:
> SGTable::new() caps segment length at dma_max_mapping_size() only, which
> limits the DMA mapping path (e.g. swiotlb), not the device itself. The
> per-device limit from dma_set_max_seg_size() is ignored, so contiguous
> page segments can be longer than the declared max segment size,
> potentially causing problems for future drivers that use this
> abstraction.
>
> nova-core declares an unlimited segment size, so this does not change
> its behavior.

Hi Matteo,

Do you have plans to keep working on this and follow up on the feedback
received on this revision?
