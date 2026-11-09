Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27F606A336
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cp2tPH0h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3EA10F1F4;
	Mon,  9 Nov 2026 11:54:01 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1824910E8A3
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 11:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xw8Ctgye3LSq5AQFiQeWRjwGiDiLv6QzKSwkBTu50rFEm+0KorBjcT84LQBw2bxrpa4QWysZu5gJTXRHgUB3eqfcVxGFxKjLnGFaIGEwxSkvmj/JCFi+wcLi6arIQJjOTsvl5dgUM+WZWTtQnxEjYvPeIaYh7Ok8GRC6pydlEoWhIDQMvPUK/yvhLc2nyxK17m8gEhu9E/Y9ITsI+gDKIs+ugPexnR5IELYvgbgtkEkvA1erqf7hLSIRU9dpogTkuxGJroGqqAlVbPv0djLwDAtRPJppsayp0nR/1c/aDnvovFLCZGzb1XuG5gBPzhg6BzN0jWEkFGLla3NTvEZEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meXDDHveQHrS/ZdfC+sYeK51/w7twKJdG4w/4gS/ymY=;
 b=lZajn3FuklM2E9+5Y/Zv4IT+PcTs0gNuWO8LW/0bJlhL2y5ZRSreFxZQEuefAeuRUP0vwXJxbQIY42S9hYDCNwuDPalccHDRtBYT/2UQvBZe5uw2N5uRUUzVcnful2oizFAM8ahiQArm9ltjwnWPmQpvhjokEaQtyZtZdUzQD4kcrz2QpmxTHpPhzIvgSeMgZUoiNdo86uo2wHq8sG7xT+TN3hTbFQOL/BqRLVOA3VzKzlwDmVvLGPKEdpu+b6uFWC8klfhITB2B0GlICn2WzOQHZ1iL59jufZjQ4CQdn7Qi0zhYWCs0kKZztDj2gQz/cjaQgDlARN/liGYI6yQI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meXDDHveQHrS/ZdfC+sYeK51/w7twKJdG4w/4gS/ymY=;
 b=cp2tPH0hA/syDzEbOt90QUoj8KwQdeot2upQmsTaFSOeyvlXoL5mLOtFmnNj8K1/OwGeqsAPoY9hRoHaqSapCiREc0lLOSffNwQF8AEWaHwEOOApGh64RL8sW79at0d+0EenNxlnMcd2spFp05XGX+1S4WYVfAgnurYAN3aJtP+jvybVeYpQ1XpxSEWeMUYy/0X/fGZaL28Te63sYLsccItvDuadU/2Z8MHKquC9wgXvX/YSVBv8cbwpsfXH+FxFb7Yj2Q3S1pUdK3IsrHn6QJMan6S9dw4G3UUURneTpPkRYxGWonm5SY1AuONf7uHMMTBVgWjMFB/T5KeJZ85vyg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:53:38 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 11:53:37 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 20:53:33 +0900
Message-Id: <DMQNR8582QRP.LLEWOYGYEA1T@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Simon Song" <xinmengs@nvidia.com>
Cc: <dakr@kernel.org>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
Subject: Re: [PATCH v5 4/9] rust: pci: add num_vf(), to return number of VFs
Content-Transfer-Encoding: quoted-printable
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-5-xinmengs@nvidia.com>
In-Reply-To: <20261030171230.196717-5-xinmengs@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a3e7fa-636e-4051-2c20-08df3e58167e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|6133799003|10067099003|4143699003|56012099006|11063799006|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: fy9AaLySQjmo6I9h5IlCPj78y4yDCdto+W0IWWRc+0Rp38QMw2e43kjsARaSlKipu30iCrkYyLxgUdh8EblDIHwMnKWNlIhBHlQ2+4PxvNcZ301wGhnHkghp8KiB6WKDkAgFGITSnDu3R/b0x1A2R8aFoo7v4fPcqfdhFPTUvPLsqOL3nFoEiVfOe5KKu4HxddBv0bV7yYSJf3uhiRFj/UbZ0NN9lpp2hO9SvSwoLb3UQe6HNCNMU2y63ZHbkeZvDbcYNxC+MijGS/pUvYKHYd4CHO/RQaeQVoL15eOIbhSvfkAWX0JI5KOHEUst2uZa5tzOIoA3e3roO1j70v6lbKSfUecjtyd8bjvN5+chyqigtpqCdr6iL94a/d7xGHY6/S+8n0BzM2uxVStZXqGhYU13nkpBkn8emhonBeRC7f0W0BtA8SDBa8XLOq4ZtttIxHN+E0amaqVsJmNpRhUxPvODFsOPOAJLTe6Bw1F81PVYS/ycg9l1Ggw3VQ4CTwSpjTD8K10xJFRf1s66bnP6dByUbVbtnNKcVmTaoIpyP9bqLgRhb8g9hIkL9K2GViQ55ESPw+pZqAMKlE2w+NGndJNMGy5/xeb+vr/GCl6rXtX7FT6TPi16RfF1I2D+NxRSBXEQXImR3bp6+gZ1a0pKohmJCjRwlfrtGB7ib+CO9TQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmRkdzNGa1lBWWI4RGJXNDlDd3hpUWw5aVFTbnIrZURIanFoMjdvY3RlL3NT?=
 =?utf-8?B?ZjZMQ0pXWnhINURmWXlUTld0RXRtVUJSeWZrWTdqejZaeEFsMXFNNzRiTzNH?=
 =?utf-8?B?cjJraVdEMzBJQ1pxOGJPNkU4dkx1RCtJT3ZLMjZoUXNRNDhLTzVGYTFaeXhJ?=
 =?utf-8?B?N1NzckpVS2xIMWYwL3NaYkNCTGZ2YW9HV2RPTVQwUmVNeEJGNGJhNFFub1JG?=
 =?utf-8?B?SjQ2MnVpdk9NSFM0VFkvVFkzUzVDcHdDOER3bmYrdlIraHVYNnBVakUrRkN6?=
 =?utf-8?B?dVNGS2hvSkpZbTlRNUV3cVBZVVRibExPL2QwQjBwV1JoYkVlb1VrOHV0cTRE?=
 =?utf-8?B?VWJ1ZDFod2JtcDRVbmJXRmFyRDFSbGxwakhKK2N6cFlvbkpzWUlIcjdQbEk0?=
 =?utf-8?B?VDVUYkdXTUgyMVp5UDlWSDVGZjcrRWhYeVU1d3VlTTc1NXVTcXRFbG92VTBs?=
 =?utf-8?B?Q2tlOVJMRlU4N0h3TDBINnlTNDJ3UXVRck9uQUs0WVhQemo0SkxLKzBuMmcz?=
 =?utf-8?B?aklpUTRxU2NGZWkzY2ViVFB5U2VCWFYwWksrMFpsSTFvRDdDU1ZEbVFSOWpP?=
 =?utf-8?B?cm5jT3FoR2VUNXFKL29LS0VaY1M0ckQ3TzFWVGNjaGxZV1A1T0RWU2lWRkxY?=
 =?utf-8?B?VVcvVERIVTZVMjlDREZncnpKUi9OWmc1Uys5VXlSS1lYZk5TdmFCcDI3ZGZj?=
 =?utf-8?B?SG9TMTBGbFExb3VLSkZpbVRRaUhua1lWNjdNS1kvalNhVzUrTE9LYk54dWNW?=
 =?utf-8?B?cjAyZFo4K2NLTjBFMTJFbFRxd01URGtmc1pIdVhPbTlWUU5iNFdQd0NqVDJm?=
 =?utf-8?B?cjc0S1o4LzhLeVMrTExDWXNXWVY3SG9BK29PMmREcWJaRXUzQWQrR0xpT1Y0?=
 =?utf-8?B?UkJ4ZkFFemxOOVpwSzVpNHpjeE14Z3hKd0VaVlZRenRFNXN3NFFHenRyeVNr?=
 =?utf-8?B?aVc5cUVTcEhqS3J2UklxTnhWSzk2LzhveW1ZSHVCSjNqbzV5ZkdiOVFBQU02?=
 =?utf-8?B?WE0rWnlNQ3FkK0tRQnRmWFZRSmVhZDU4eFdUb1o3QTVTT0FmSnU2a1BGdm5C?=
 =?utf-8?B?Lzllb1EvL3lKZVFoYy95MDQvd21HbFRVL3ZYM2Y5Rzk4RlZGbVdtR2FGTjE4?=
 =?utf-8?B?cWVLTVhWMVVqR3h2K2hnY0xTcDQ2TFZCOWFrZkhBbVVXd093Z2E5VGdUdUNE?=
 =?utf-8?B?L1labVdhRThseURiUCtKVVU0NUkzdFFpOWZ5OXd0U1UxT2gwbkhUVlBWVmE3?=
 =?utf-8?B?dnY4dGF4WEpoOTFEem1wM1QwU1BHczBEbDFub3RZYW5NYVpPejk5azBGM3h2?=
 =?utf-8?B?bXZRMUsrQmMxYXRTQkNGQjFvVkRnZ1VORTduU1VBTDRQaWJOSU9RZ0JHOCtq?=
 =?utf-8?B?dEhFZXMwRWtvRmNSYnpPNXQzRlVXZkRqY2tCQ2U0S2YyblB2MTJqWW11eHow?=
 =?utf-8?B?dVBoMENhdXR3bWEwei9BSTVwQzFiQ1JBT3JTV0FMbEp1WUt4ZTMyNHBCUWNv?=
 =?utf-8?B?OXAwYVRVMkVyRnZCRjI1YXdxL2xlM1JkUC9vVHR1MXdaQ2F1bE5wVzg1ZVlt?=
 =?utf-8?B?LzFDVVZhczNZOTRrOWFOYUovZGwyWExVU1c5cXE3Q0tWcFNGMlFxQzhOSkQ2?=
 =?utf-8?B?WU1lUjZtVjB0bnQzdVF2RmRvME1abUpyZ0wrREtpQXp5MHR5dnM5Q0hPZ0hj?=
 =?utf-8?B?R2FRdzAzd2d6VC9nU0FNUHJlNGRTbFQ2d1pNS3krSDhKMHdRMGI2YSsyU0Ra?=
 =?utf-8?B?aHBWZ3lZVllnRVVjRXNsK2pVYUQ1WlpuRW9SQWRlaWlLaWh0ZGxRcXcwZ3Nw?=
 =?utf-8?B?VmNCWCsxdnNkemVlcDh5ZlVtakJqV25pZ0xnSWRFZkkySnR5TlNRQVFUcHhH?=
 =?utf-8?B?RUtDTCsyQkxhcGlCaysvYmlLUmljSldNalh5bHBtY1AvSWxtODNtUUwzVlp4?=
 =?utf-8?B?NDNkNlRhdFJzZ2JqQjVKR04zYkJ6a0dRcGYyeGFDTlZ2c29IS01oa3NVMjM2?=
 =?utf-8?B?eTZaOG1pWHhPNjdsMXNJamFMUEZLcklSRjQwUEFRRGFQaFhpWDQxTWYvZjhx?=
 =?utf-8?B?b3poaStJSk45cTR5bzRvSks5eDg1SmtCQWJ6Q1FXb29kQXZWNlBzNXNBd05N?=
 =?utf-8?B?aFpDTzlOTUcwMjBrSkdCVkFSQ1RiUVQ3MWRXNHQ5dXpLZTRjN094ZE1RbjFk?=
 =?utf-8?B?dDdaUHJIaTZBcWdoOW9iUlFKOFNQU3ZRalJZdDA5TDNkRHFac3cvUUVUajVk?=
 =?utf-8?B?QWJscGEzTXVzRjlvQkdSY1paejBRNm5ZTFpINUhzbm1TNThmb21RNk50ZThQ?=
 =?utf-8?B?Ym5XQkE3U1c0VTA0eTdpZ1BBT1NGUEJoQTA3STFDYUdORVhSTFBKQXNZTGYy?=
 =?utf-8?Q?i99QHgBcUqgU2Ie9ylhwo4nuOIk02nlOS2WfTdwYk6Rl7?=
X-MS-Exchange-AntiSpam-MessageData-1: pojVBXBf27H7iQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a3e7fa-636e-4051-2c20-08df3e58167e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:53:36.7509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSdSenMm/UhKMkyJoWcwPAVN1DtDcq5SluPY0kaXdFDxEsp7E/2caj8qs5leaEFiYRBGd4E+yA/UdXP8YAAiCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat Oct 31, 2026 at 2:12 AM JST, Simon Song wrote:
> From: Peter Colberg <peter@colberg.org>
>
> Add a method to return the number of Virtual Functions (VF) enabled for
> a Physical Function (PF).
>
> Expose the query in the PCI core callback context and return u16,
> matching the type of the VF count stored by the PCI core.
>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
