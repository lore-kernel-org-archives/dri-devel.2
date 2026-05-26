Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A56FCD5BCF
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 07:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95B5910E4BB;
	Tue, 26 May 2026 07:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="kD/jx9pL";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD4D10E4BB
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxU5r0u4bIalQUKKTnKkTUIJNX4Wx2dYybKsIl7p/EZLsaa1Lc6Qh4Dpter+68g4f+wXlwOH9MJxn0geTeZlPrMGx8xu9XuDHdaKsmf7L9vtZMzpxiwJQFnXZ6PDoctfBiSbBJz6eWKjw2rq+8dwSJrcxyBww5zkBF9jWl+Naa9h6mbjv2j0vaWSN+rfo4SFOIcdLNJmlbAEc41Tno6zjubhyhiINpnk/nQKJjlhl2gIMgxaw6f3vBh+/1rhvk/FfVIeZPveyALfjR1SOX+gbSd6dysuqdUtp4eEDrzPLtq2OIMiS4T3eTjrFYjmDniKJTKDj2kPQgPri0W3j519fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+HWiRAqRtBfOaXmuh2QJS7WmDkjKePAwSeCSiwY06I=;
 b=P0049wijYeSt85S/3+/8tN18HdkILzcXlZGfJzb50THXgYPfAuq5VdhCW7rD3FjjXcz+ZpaC3ZO0708MuUJvRMkF1dwEnLTiiNuZhAh+3qE2sTUt5mW32S2aH8GGrip6/Cip6alhOyJqEsrK48XQEtrLS77vrPKdX9N/K6TbDEUXbqxdU4JpKI/s8vpLdI5sCUneAR2R+FyszpLQ3CNCPzU2HWakKTNPrtU3VCjjHHHVPODDLfMNHs4jWVqiGd9OJMgHgYUH+217zUbb9PRjGED+8WIcvDtNoC35GHtaU3SO8WKNfkeKdKSpND0PtyvoWFQGHI4Hqj98Z6kYRPvLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+HWiRAqRtBfOaXmuh2QJS7WmDkjKePAwSeCSiwY06I=;
 b=kD/jx9pL0AsMM0XyNLcgNulnEPcZ+/XB4bnhpVjZ7U31fmbHNWKg79fNfjY3MwpziBy9SyOYQxjDwneNFGDDX8OJyvVl1FqSpkvr20WtG79SqlOmLDLtFTAeok6nHUJUP+LPREx0aiIqBDgPQ1dEhZPvQwuMOOAukd8qcXKnjW3aBBRGfVaxVaTX+idxyxNdydwePFd/m2OMFnai6wwBFZElacQPige6Zn4zts3oJbeiCdadeeaBs/rlpfeYZRgAvidun+/E0btNjrpHaYLSgV2GUlITn3BpDZKjtu8vqfni2hwOQtXaXA23P2sgDFwsjz9kFR0gkBGz0fK7NMgbow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:12:00 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 07:12:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 16:11:55 +0900
Message-Id: <DISF6M0KLXI7.37BSIAI0X0S3P@nvidia.com>
Cc: <aliceryhl@google.com>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <ttabi@nvidia.com>, <joelagnelf@nvidia.com>, <gary@garyguo.net>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 0/5] gpu: nova: adopt driver lifetime infrastructure
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260525225838.276108-1-dakr@kernel.org>
In-Reply-To: <20260525225838.276108-1-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0330.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8a3c69-1733-49d8-6b56-08debaf613f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 71j1FEEYFy9kdHJflCAP+i8D+tHZuwVz5OW2yn1ruDwqo0xWVpgYDzBNsHbh0DEXIPsCaNnzJARwB6alLoeYdJrZjCUmhR1UMrjC5XyBpqplDGqly51ZVV2wMvZoJ3yl3hk2AC2P0YfIeUbp2BJSpjPetI8imUpZG2VgsOUx5trTrVOG45JvAu/HQC8YhliPmFV3ELDWbFx2pRxDIl+QyovgyptyxxCAAhAicjMoXhOhqsv9Kz32wzWNDmVYRQ++o2vwaUfL80SDttSdsgQxa+danRFlDqsHKVVZ+57GB+KcDTqsBX9G/VN4LYSBHOwN9RoZd/umw2wyY6tXtorXUHChxVmH3iM2nC1vYBBkNgJ/WCxXiOTRjoDnJwQXwj+nLIzxgIDY1R2vq1MgKCzvNWV4JLV0xYV/9HISJ7U0Rp14XrEHTKYXsst1GrTwQmQKGyGP7Q9J2i5n98BmJJyF8hyU4yvIs4bkEXkJKJAYZlLCrBPnskCE1lXTsns697nkM1GG7OHxDjSSN+RWZSJNAXLah/Od4r5t6x18YPXpCWSOvBHH8ls1zOUsg8b+f0UwhP+4qdMJzGtsd5ilz8knLSe1NldfDHVEWDRMa89k9dI9obNtyvoFXNFuQACRCOGyW6jdWCJpLht90cLsbWpmTKj9VTnt7QuuL0iFUFDYzUI1aSdlup1wF8u5C53EHdrX+NbolPqiTQV6K7cN2NrTQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUE2RXdLaVV1cC9tQzEyclZGYjhJQTJ3cERxOGFWNk95bVArMXdBOXY4dlBV?=
 =?utf-8?B?Uy9sbVVJRmxCbU9maURXcWlWYk1zc3I1Vzg2bjlmSVNhSTNnNUNDQzhoTVlT?=
 =?utf-8?B?TWNxaWc3YlFIamxVRjdEY3ZROEJuZ01BZ21iS2pyYjEzWTh4TmhtKzFMUlZO?=
 =?utf-8?B?RHBxOWtVTTVGcGpDV0ZmRVQwTDdEcVFKTmxlMGdmWGZOWkFacDErbk9PTFZP?=
 =?utf-8?B?K2IvWW5UVTV0SGloUG9SYWtrOFpRenNBZ0pPY1pFUzZXZjB0VUVCaElwZWRY?=
 =?utf-8?B?VzEwaTN6SUtGQldLcklBaFRubjVKZWZ4SndseU5qTFhRaTFjTjFReTFwVlM5?=
 =?utf-8?B?aWJ2RFBSSjZxRG1SOTNpQzl2SSsxbGlRU3hGdHpkMStEVU96WTd5ZVpMSHZm?=
 =?utf-8?B?azFKc2o5d3NrVWJONGNGdmpoRjNLVlk4d3ZqM2VXc3NwckFuVWlIb21WYWRN?=
 =?utf-8?B?N21vS3lMaVpBMnY5bEZxRnNZNFg4Q1BLL0FwR2lpRHM0NnVOU0FUVHNBQndM?=
 =?utf-8?B?My9nZ2hINFFab2pQNnBkWVYySHB4MndrdFVjbXVGRk5NVFMvcEh3dmJuamEx?=
 =?utf-8?B?Y1ZFbC95ai9wQUcxSjdYTGdsK0hPdDhoYy8yZGxPZ3hrRnBLRSt5UWdLN2FH?=
 =?utf-8?B?YUFQckZic3pwWVNlcHJ5RC8vT1JUVXNaUVZUMmxPM293ZW4wcWNtSldrQ0RO?=
 =?utf-8?B?OVNicnludElhSTJCemltRnFDZklaL01GZWFsTlY1d0NIUCtIdkY0SFB1S0t0?=
 =?utf-8?B?WVNrT1g5a3lNbU50L1kzVGZ0MnZCdUdhTHBLZ3ZGaWdCTEJ6dnVubHQxcDlG?=
 =?utf-8?B?emh1NHJ5ZkFBM01ORmZuYjd2TGc0UlljVFF6ejhmaGYvRnd0YmNxb2ptQW5L?=
 =?utf-8?B?Y0RHSFppcER0UjFFa1RIQjRuNzQvZjJ0Lzg3bFRiMGxkcTJvQ0JOdDlyOE9q?=
 =?utf-8?B?SndRQi85TERPZGEvNXNWNUR0TTZEdURoRXp5YW9hK2NpV1VLaklKRWd6YVVz?=
 =?utf-8?B?Y3dWSi9qbVNoRzhuT3AvSFVYYnZaMGdmakNGYzVFV3NhcUU0aDNBM3diZlRu?=
 =?utf-8?B?OEJ2TUFtanBUYVBJTmhnSi9SdTVEUWVPdXQzQzhGZGJrMnUyWjdXeDZTUk9O?=
 =?utf-8?B?dUNBM3ZBSi9MT2lTNXZiaHBhSU5rN2psbE5ZeWxJZG13cVpzU2pDQmRxT3JX?=
 =?utf-8?B?N2oxQThnVWdvUERYVU9zbGF2bG9XTU5ic012aWlaMjhCN0pWdWg4M0daQUJE?=
 =?utf-8?B?b2xocWxJRlpaYkNSbzlPbG1ZWmRITVg1NkcxMDh0cFJkcVYrWGUvQUxhTnRw?=
 =?utf-8?B?MXJwSmpTWjBNQ0pQTEhGTFFFYnh2UnR2c3MwQ2ZJcVREdHk1Q2FaRm1OTXdQ?=
 =?utf-8?B?cThEbU1WTURDVmNsenJ0MnNyS21zL0x3NVBmUXRMODExNDA1bnV4aWlLVENl?=
 =?utf-8?B?Mkx4SEZYM1ZNcTdLcUdLc0hVMy92amhWTjhjVmZ4QU9ITW5sNjZyYkp0NWhi?=
 =?utf-8?B?NnorZFVpMk01VnRFRVlHZjh4WHlCSEhjVUNpTnVWNEdSREx0MzZjT1JVZmZq?=
 =?utf-8?B?TC92T3RXbEJMWko1UFpvM3FHdVBGRVQ0WVZHUjF1ZzZ2a2lBZ1lnQ1dnMDlD?=
 =?utf-8?B?b0hVU205YjhweTE2UmFacDZDRElka3JOS2NsNDRXS25JcXdTUnVzalhBZi9M?=
 =?utf-8?B?Q0gyZzBxSUpXUTloY3hjU0x3eSs0RzdCOElJWjladmJ6dWovbUliRjR0b0Vt?=
 =?utf-8?B?M2kyN3ZpMkZJanVZZWZnL2F4Ym5uZFM4L3hjT0RqU20zeWZ5Z20xMUVYZk0w?=
 =?utf-8?B?UzhhMm5LQzkzZm8wdTk5Zi9ZeHk4VTVjczJ6L3ZmYTltclhSb3ZLUDJaQWo5?=
 =?utf-8?B?Z25obVdERFZBVGlIeDlLZzM1TTRrbGVFUkZyclp5MXVsMHBoei9WeXk3NnBR?=
 =?utf-8?B?QUZjNWNwdDlIVDYxMlRRd3dtSDlZTjVLSHAvTmp2dVhTc2N4cVlYVWpZRExo?=
 =?utf-8?B?RW96bUU0NEI0NlEvSjRrUEFNQW5Dd2VjNHZ2cHUwejIvMXk5NkRwaldzaVo5?=
 =?utf-8?B?Nk01UFRZOEM5YVZFanZXNWdGRWRHc0hYQUNZVXB1akpxN0l3TEJHaHRnaXU4?=
 =?utf-8?B?Qk9oc3FUSDVrdmdFbUlEblo3d0FuV1h1RHZleGxwQ25vMDlldUcxN3BnWjhH?=
 =?utf-8?B?eGhTbVBiUW1oUU9pN015ZkxxNDd0NG4rcHJlcVV0TTh0NWI1ejAydk5haVFz?=
 =?utf-8?B?czZyT1g3NFc2eHVWVzEyNnZhN2RJUm11N1MveXRVZU5tNS9tdHpjMW9NeUVa?=
 =?utf-8?B?NXY4Y1J2eE1MM05LWkl5YTJ6SE83WHBESXkyR1k1Yis4MnU2SXI1SXBVM1hX?=
 =?utf-8?Q?EqZuSq9wJfCEx4rozC480EyPMCELikux7J5Hw0lG7TYSi?=
X-MS-Exchange-AntiSpam-MessageData-1: LICGsOMABIj+AQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8a3c69-1733-49d8-6b56-08debaf613f9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:12:00.1361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOxk0Qkx+lJ+AGq63056CWOO7FGFhZFi7aH26VOZmAWzpIaTIUKVVkShrG3PeVS+aZjV/XwqWOnOSxMSQU0aCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
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

On Tue May 26, 2026 at 7:58 AM JST, Danilo Krummrich wrote:
> Adopt the driver core lifetime infrastructure for nova.
>
> Use the lifetime-bound pci::Bar directly in NovaCore, eliminating the
> Arc<Devres<Bar0>> indirection. This lets SysmemFlush borrow the Bar and
> implement Drop for automatic cleanup.
>
> Replace ARef<Device> with plain borrows in SysmemFlush and the GSP sequen=
cer,
> where the structs are already lifetime-parameterized.
>
> Separate the driver type from the driver data to allow the private data
> to be lifetime-parameterized via the Data GAT.
>
> This patch series is based on [1] and drm-rust-next.
>
> [1] https://lore.kernel.org/driver-core/20260525202921.124698-1-dakr@kern=
el.org/

The series,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Tested-by: Alexandre Courbot <acourbot@nvidia.com>
