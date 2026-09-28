Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E28FCA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 17:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A49C10E951;
	Mon, 28 Sep 2026 17:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="PlrWdOy4";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021077.outbound.protection.outlook.com [52.101.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE11110E951
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 17:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ku7kZGYg9ewDOcG/4+iveo15O1AedeR2LYNX+apvgl9H006YME8R/ItYf7Q67600wPQm2RqEF48PbB8oKKSF6UBhF4tP9UTSneaL9Rvt34hhtBzTdxHSHZQOamVDKJGJmiTKGyeaRxsnmC19rFpDAFVc0i9j9RPDkQFnlcdkiUJRRAMNH+tYYJOJicFzPCkDJj0Z8sqCdf8Wut5mUblXocCzhNkQbosY27FJxv933BfEokDJdKHTzbUOt1siz+1T9L/x3N/PPKuZRBxdX+YQKkYct4nbBPWCaOTOXDO+klWw41LjarZZ+PVSKHXQdkQRYoQRqEDgFw3Z0ikale98Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxJS/+91w9weshBNSYqTOLIW63VifjRMMR4S8CwXFlw=;
 b=UCvt7oj5xCD92XhxfdZzuGnoIC4Cak8ucMLw3RRr8t1qdLBVhPtUz96IbhB6PIYcCUlFLvORVd0xhZG5qO/uRDpRsdJ6nmuPyu7hdXUTQE7lldZUl+lbn2fw4BBED3YUBij6cyAVimoQEZe8FLz2fbv241g1d9OBl6UjzfF5kJHIxTOO3RhggSLdnLbOtF5FGewwph06xbfQU0SiE2y7n8bFh1927cHJVyRaMtuqxHmH/cnnsjA0gq/M/DWwjkSGWfWmvBRUrywVPy8T82AbW3VNRF4cN9fiv4VYxELJZkOO1sbsSzpq4rR5gXFnR3osGTHefGGd/wkWFe7lD3hK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxJS/+91w9weshBNSYqTOLIW63VifjRMMR4S8CwXFlw=;
 b=PlrWdOy4eSRC4GFH/U5CouhiCVtGkNfQ1lqn50Pq2YQyCH2x++RguU5cWi50gcnIkzQWSOX+53GaO3v2VgKc1jKIS30zDbK6GJbue0SQVDVldJLICTAqlOMNo09+M2H0++PHvfO+LZrx050sy+9xrx2dA6TrBF5RaZoNPz4ySs4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB5178.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:195::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 17:39:55 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 17:39:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 18:39:54 +0100
Message-Id: <DLR4TIXBL0K0.3GNRPD2HU6S4T@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Robin Murphy" <robin.murphy@arm.com>, <aliceryhl@google.com>,
 <ojeda@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <a.hindborg@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Matteo Kloiber"
 <kernel@matt3o12.de>
X-Mailer: aerc 0.22.0
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
 <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com>
 <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
 <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
 <ea8caba1-eb78-40cd-b025-e8c02009f2d7@arm.com>
 <DLF2GNSEGHKR.2UI219W5RK94F@garyguo.net>
 <DLF3BLOLU8HS.1AXNNXWVQUFNU@kernel.org>
 <DLHH0K25NLX5.616R4D860TXU@nvidia.com>
 <20260927224446.1053037-1-kernel@matt3o12.de>
 <DLR1JCUWS824.35QJU45D2W9ZE@nvidia.com>
In-Reply-To: <DLR1JCUWS824.35QJU45D2W9ZE@nvidia.com>
X-ClientProxiedBy: LO4P302CA0030.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a88409-acb2-4561-7fdf-08df1d8781ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10070799003|10067099003|56012099006|4143699003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NyFwSqBJr/fD6QoBOFC0pEqy+hxx4Y6lS4nANS9j941+JL5VllhoF6BKu9bNW30ciYUX5bmjyg4nxVg9FEct7t067Tu6lkdYqXwGZoY4iVFPjgEwyM9msQ7k3ua0P2NpbMnTuf0+WyY70a6wDbXWmgH1gm2WwHcFkX6/B0w5MvuHsbK5j8mD1U33YEwZOcdirnX17cwMUG3+rzRkThu/N0BbdLLpsSI2/pmsID4TKDpywxDmwvbweMfza68EnWa3deB3+P/DTNUC9p9P/WK7ll3LwDLA8ZUtHSldJad/9WCjbKLq+S8LcFpczF3QSqChEb6nAK+e8lmuR24ZntfRBNOaFwFS/cytYYG/WOOw5LTWGf+olX/2VwIKp/kj5DL/jRGQ/EwuRns+GpFLpdjwDJceqTYofvqd62IzFael3b5aFcUzHdJ21Qu4qft8OX9orUAuOMeS5EydDBJqrinf/j3+jgLB/aWNQptZB0Xe/7M1TU5OhuaZfuTmcSmeeQspAi5mwuKegVV9o4E4jEvz+HO9a0WVAc4SmSvBJPNqnBIU9P8iOxV76P/79oZ272j2NQEge7JxVY5sYnGZCMbGAxyQH2EFQYqSBZCQ4trNxsJnnumJ4eXKwWTfnrdrpM4R6UVDUAhk+6uSJGE5HGrVC3mXXuand6Wx3tLL9Ds7GQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10070799003)(10067099003)(56012099006)(4143699003)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmQwNTM1cy8zY3VwTGJTd0t4MGdGbFc4a3pwUzQ2VzhJZURqWHpWb05HeG5w?=
 =?utf-8?B?V0Z1ZndzNkZNa0tRWFErc3IwOGpzdnpGSWhYMjZrVFYvOXNKWWxJcFpaNjNi?=
 =?utf-8?B?d09lOTEyZU9tUk1RNFdXSXAvblRyYzdTLzNPWGEzOGg5TmI0dS9TS1JBbUQ0?=
 =?utf-8?B?bURJM2t6bmJnK0laQy9sNDhPVlBSYUVqSFh1UU5ySjhSQitkS1hiWDMxYTFS?=
 =?utf-8?B?cG1jM21RRmtjLzdjYzNDQ3hmU1RYNms2bGlXZ2p6QXlLUTBkeFRhZ0xYRmMy?=
 =?utf-8?B?VHN2bnc4Z3BaYm8rZDJVcUhoSSs5bkxlN2FkSjlyYkZmTFRaSG9PWGJCNlVB?=
 =?utf-8?B?SjAyZ2NKNVpGbzJHWjVGVjBoTHVSRkR4bEhTNWFvaTJCVHRXWWpQY1VBOURQ?=
 =?utf-8?B?L1I0ZC94dUJZaitoc3pFTzgrYWw4ZkdBUmU1QW5lMDdqR2loeCt0YXBkT2NQ?=
 =?utf-8?B?Y3lYQ0loRHdRL2MrMUE2NFlNV1BwbjVYRE8rU3dNRHRETE9BQkVNZXI2bVJp?=
 =?utf-8?B?cDBpQThlT3FCVUZBNlNpLzdERW1VKytzbjBkUTJmUmFySXpBUDFMSFZsUnM3?=
 =?utf-8?B?L2NjSXp0KzhIMElwaUFEL1IvRld0Zk96V1VKTDFVeVNpdVhrMnZCa3VIeFFp?=
 =?utf-8?B?WHIrSkNOT2pIL3BFbHdBdFFCRytib09ZSFpIS2tIS0lDMndJWWpiT2RoeHRR?=
 =?utf-8?B?dnpiYlRSN25Wc3lUdUE2RFFQcW1mTkdxSnMzdGE3akJ0V1luZHNlcXB5enFN?=
 =?utf-8?B?WXE5Y1dDcGZ3R1dPVkk5c052Z3djTGdoTzB1MHhZcUpWMklzTjl1R0xJQ3FO?=
 =?utf-8?B?cWJNTkRnRzZrL05yb0JCQW00K0RFSzRRNjRJMlVnY1psVFk3Y1lWQ3pSUkx3?=
 =?utf-8?B?TlMzOTNwSkNFWE5GdzdGbzI3Mmk3VlRzMkFFS1Bnb3hDOTNrTUZWODdnOWph?=
 =?utf-8?B?T05xZlV0V2NJQ2lValorY1g1M1lRRHU3bmRzcnJWODlIQ0Frb3VCZk5JTHZW?=
 =?utf-8?B?YXlpNGFCcy9Bbk94OE1FOUMzM0h2VFZOa1IvaWZNWlBJSkxRY2ltUkRWN0hF?=
 =?utf-8?B?aUxucnMyY2k3UW1TSXFuU2ovZkRhNFdxNGVaZnRZRTU4K1ZnRWNZNWU1Mk1P?=
 =?utf-8?B?RTJrUjE0RzRDeUw2QTA3UUlpamNFWXRXMHhKZWMvSmg0R2xoYXQ1T2xYZG5m?=
 =?utf-8?B?aE5wVXRqR1k1UGhWUXNLeDZjNkYrUlJyMWE0MS9Uei9nRXNJM1lWS3dGWFA3?=
 =?utf-8?B?bzEycDJIbFd5Z2pNZHg0YjBWZlRRck5KYlIrMnVtbDhXT09GYm9DcnF5L3d4?=
 =?utf-8?B?V3NxaE93VnpLeDFuR1NpWXV2aTNGaDRTb3JQWG1LWmhpTW9ydzAvNHdHbUpZ?=
 =?utf-8?B?TS9yM0dxWkV1QVBzYm1VZVZUaFU0QjZNNGx3aG1haDRJNEhyODFnQldpeHN5?=
 =?utf-8?B?dXFQeXVHZitTeEZWejJpNjcvcDlycmpFZnY2M2IyNy9qSk5UODlwbTdNSG1O?=
 =?utf-8?B?Qk4wQlJPTHdDd2pkL1ZDR21TeC9aK2RzK1dpd0FvT3JRUVFPRHRmOTZ4OUM3?=
 =?utf-8?B?NEFwQndQMjNMdytkbnNhL3hBZzJ3QjdQK0pqbjNqVWpWblVpRHhXQU1tcGwz?=
 =?utf-8?B?TlNjWDljNDBtMGFzWTBYcVkyM01UdGxXVG15OWVBRHVNcGFCalh4OWNOSWxh?=
 =?utf-8?B?bklOdndBNExFYmVlbmNIZ1N1OWxCUlJtTVM5aGkvMmxlSzRMemRPVjYrTWhx?=
 =?utf-8?B?emRXalRrRmtjYk5PMk0vRXQ0U0hqbnUyWldlNDdKb3lJUkI4TVl2empTTHln?=
 =?utf-8?B?K0xTYjJaQ1dyUmliVytCd0M1SGFnMmMwejVPSzFpYjNiaDh3MkwyUklyRmFy?=
 =?utf-8?B?UmNrK1E0TGtpMGFGdkJCNmtnT3Z2VXFYc0xmV3BZNFQrWlNYcXB1L1liYWRG?=
 =?utf-8?B?ZnJDSjRNQ2pZeDIxZy9jQThEY3ZZdGxGTnhmWHk1L2pneGNab2xuQUdGVWZr?=
 =?utf-8?B?bUlkUytpMnI3ZWV5VW5UUDhNN0kzVVdiYXBWa3VjMC84WVFyd1JuV0xxMG52?=
 =?utf-8?B?V2Y1SmtzUWdBZ2Z6L3Nqc1hPcXh5ZDRDTjBUcWFONHpTRWZKRVRLTTFXcS9M?=
 =?utf-8?B?bnBHRkg3Z0JwSGF2MHdVWFBZMUtNM1h3eFh4V1JTdDFCdVNRQ3Y5YU5PcCs2?=
 =?utf-8?B?TVNwWDIzejVPMTVZQUNvbjlOMzVrTkozQVJzVC9aV001c1hNZkhsaXVVMFZC?=
 =?utf-8?B?Qm1sWDZ5V1BUMzQzSXVSM1lMSExiV1NZT0k3RkowQVA4c2o4VkdodXE5dndx?=
 =?utf-8?B?cUxWaWVxNnpRWGZheUZZamFWOXdUNFplRFErZXJuWGNmc0pjTmkrQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a88409-acb2-4561-7fdf-08df1d8781ef
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 17:39:54.8548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvKuWJyAmL8eXxVeYPZdEDCV6b8RFMx/Q2MAV4NQ2EemHv5UKXF/IedAm2bDhjJbxYw8FBU+WzXgCKxMIeK8jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5178
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

On Mon Sep 28, 2026 at 4:05 PM BST, Alexandre Courbot wrote:
> On Mon Sep 28, 2026 at 7:44 AM JST, Matteo Kloiber wrote:
>> First of all, thanks for merging my first two patches and sorry about my=
 late reply.
>>
>> What I think Alex meant and what I agree with is that the new API should=
 focus on
>> making semantic bugs harder, not to necessarily make it easier to write =
safer
>> drivers. That being said, I think we can do both with this change.
>>
>> The key change here is that we introduce a structure that defines dma
>> parameters for a device. This structure deliberately has no default
>> implementation and new fields should be added even if they require chang=
es for
>> all dma drivers.
> <...>
>
> Thanks for the detailed plan; I think it mostly makes sense.
>
> A few details that we have discussed offline with Danilo:
>
> - The `probe` methods should not take the `dma::Setup` token directly,
>   but rather a bus-specific struct that contains it and can be augmented
>   with other capabilities. Drivers would have to deconstruct it using
>   the `..` operator to make sure code doesn't break if we add new tokens
>   to it.

I was quite skeptical whether the complication of adding the dma setup toke=
n is
worth the effort, but the capacity struct sounds like a very nice design as=
 it's
infinitely extensible. I can foresee that we might want to eventually get r=
id of
the special `Core` typestate and just replace everything with setup
capabilities.

Best,
Gary

> - The token should not assume default parameters and only call functions
>   corresponding to parameters explicitly set; converting the token to a
>   handler means the driver acknowledged all the settings, so we should
>   not make any parameter mandatory (the doc should of course detail what
>   drivers *should* do).
>
> With that and your plan I believe you have a solid basis to send a
> RFC/PoC. :)


