Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D31606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g/pxS6IE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5734F1123F7;
	Thu,  5 Nov 2026 14:22:11 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F15C011245A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAlDzRdFVLf9Shjr0piNAgGU9X92EtTWeHzR+11JqQpcWHDKmX7jseIUZwhkMFmyuIAEDxfzta/6OYuhfAS+cCzrtfbzvMViN5hvohMm0VsV2J2UoFQPXKxnF5qRSX/Jl13QRB+bqOlAVXnJo1NKNBX04u3rnA7vr9I2g25ci0re5R6+4qdAoEjkMvytO/L364AhddLo+SZy88kKguuQsbWR6EOsqBadPHhzNJf1F0lY+hDIs0ycp1dJ1rFkIVqSpFErZQVWVDb5mW98bNCjKvxd3UfdtloTi4lDGGBdKQVNQVAOSA12qtd7Dy3XAmTJ00z2PPg5FDA4x5UxcPT3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG4goJ2GAf8ezBdXZsZlNKxFxlKChMju9oAaXJ02LZE=;
 b=CT0ncjWfiAyAijRatr6ZliFecvu9XlEBcEe/agukDQmtuT6/P5etWwooP3ZB2yFmJPO9YB9gMPKj1rWJb7PE64SoCwh3zH6iCwRjsYLmbC9LVuEcQXCxkpzF3Ho0TtYWfd8Nu+BLvJyKgJiYM3BY5HGXVXninGgwskaaUCvWNYTlx8FOF0NuB8ZygY0ZrzC0FfzxQdolhs/QkrSYjrqdqzTql8xLeY9WW6jdDxgX1idaL0m/If1+NXMnSuWOpSHc4MAM0IXljRCA8JRJZO0Myt+xn/63BXIEDarWnH0N7iuVz6qrex0/Rg8KZg9B04obtUcnRFDcpQlssZLiRtEibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG4goJ2GAf8ezBdXZsZlNKxFxlKChMju9oAaXJ02LZE=;
 b=g/pxS6IE8It8M8QDmcA8PP7FbXUVoF4CE+kxmBEwtjKW2aj5pT2ee57f6ruEp5Jm6FvVRTSM270pUZkPfKj5+/gU8SX6ZzpKagyhBYwmB0BCJkM6AKL9v6ZNDl4KgXjXsgDq9ZjVTWc6LTHkR/bwKIlvYnwLkPINL2R8Ls9muQsVoUYTPAEaP6Rf43fXL9nYSnLj/ZR2NW4oiTfWLVPHUYBhCJL1DFmaCtg0LlS3xGKuDe89nEnJvCb5Ty+v3N5YuNIraPQoQyEgj3t2pcZnusT08fc/V41HekUvise+7kjnqgx3lMWkHmDTogz/pSoq1DtmYalzCFj2EvlWIup59w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 14:21:58 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 14:21:58 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 23:21:54 +0900
Message-Id: <DMNCEMXOXMWU.33914P6SZI2PL@nvidia.com>
Cc: <airlied@redhat.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 1/2] rust: time: expose as_nanos for clock sources.
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20261105-nova-timer-v4-0-45a7c121d4de@redhat.com>
 <20261105-nova-timer-v4-1-45a7c121d4de@redhat.com>
In-Reply-To: <20261105-nova-timer-v4-1-45a7c121d4de@redhat.com>
X-ClientProxiedBy: OS0PR01CA0195.jpnprd01.prod.outlook.com
 (2603:1096:604:1c5::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 30125611-df7e-4f96-a573-08df3b4826d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|10070799003|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: Qg2lshMYjjVx51k/kviLf9MA1PyL1mJ3zKUV7/5VHcr/LR2/PcpWwETUx0KGcvc1fR890fi6yXGHqiYRkRhPdRyqjR+oFAvA4pm0xlDlvmZUOcikypgsZ3Gq9VHbI8V/vaUW6YqyAvZWatlEwVJLiZwCUU+TINW7/q9oshTM6eQKMxWF0/tY7nx23NUmTI0kTlYyGdPE8vuWwiG9tmgui+ipFNG0Sh+edQ2SX6XpCGxsChuM2eWDQDzKh/eHOhlPPfesngoem4h9kAybT1AKxB53GO5N8cAbUymt9uqRSuw7ud/D7jl4f6/Ohm/PqGy9i8ac1Ar2/RTLoBgK9RvbiAfcEy55XVXUcqwL0xgYMIMgoZkmDK4CW+3dgt4c09JsAuLGTE0HEtXwV3VAi5xTKl5myO2jH8lISgzIWH8AyvzqHzfxL5yg7QYr7XeEInR4uS0OIjwhP8ko3kc9dZs4CGmrA8S/z0fGz8EhlZPuU2EQhdrq5OTfcv5UFg3IL5Ze0u4mmkLelmFOHgXdr21A83y2B6erwN+YrfZ0cVJO3UZ4OFqXeVlDpYMrZM7S2wMQk7w6cXgp5uVKnb38tNbL3uCOD/on7q2fBzJBQb4VyEn5K/XarwU0M4Zu68fqLIsi/R2cnjrrq4TWbPpyfpcKi40P1TMaEChV1JLuWQcKTbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(10070799003)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkxBQU1BbjVadXMyY2laUEU4dTM4NjVaMEFHOGVieXB5em1JM3B5aDl0eUc1?=
 =?utf-8?B?dm1iRkE3M3VsaFgwRWVtTCtvSk5iVFp4RURhQ0ZyUktQYW4yK01VeWY1WmNS?=
 =?utf-8?B?SElhVW8vRGZ1RC9iMEg2eHowclZVTjFiSHUxeXIvZVR2VXZaOGc2TWRab2lC?=
 =?utf-8?B?MTVuajZrS3dZNk0vb3B2dTZuUFR2TEQ1ZkVtL3l5aHVMQ2JjQmx2QW5nSmpa?=
 =?utf-8?B?T3lPRnB3NEplOFFnSEdHZGs2REljWW9mU0dMVzdpTFlXcFdjdXp3VWxWRm9D?=
 =?utf-8?B?TG1UOW95NXlSbXNnRXIzQnVlakRGa2pCRlNlc0RMa3JYNXJMemtlemoyaGlu?=
 =?utf-8?B?M1U4TTUrMlExVUFjVTY4Y1QxU09GMEd1MW9hMUh6b3RtUVhQQTEveDBwbmxN?=
 =?utf-8?B?L3BLRzhDck52bGdnSXVENTBMTDB5V05FVVdRYU1rdVZRRDVrRUljYk1yR0FW?=
 =?utf-8?B?cVZCWnVNTU0vTXhxaHdYQnIwS3pTK0ZLYmNpNE41bHYrdnVUK2c2SE11dmpX?=
 =?utf-8?B?cHVTampCVDlNY0xad3VSYUNBc0pCREFvbHl0V1k0NElMNExjUGxUeE5EbGFC?=
 =?utf-8?B?RDV6Mk04dk5ZUjk3YnJCZ0E5Y0ZXdWlZYnhUa1RYWGVtZ1l2ZnJjUy8yNGpI?=
 =?utf-8?B?WGFNRktwRDhXeEFESkd1a3dXWDlXaWRyWGo0Z3lqUGxiWGtxT1hZOGRpZW9N?=
 =?utf-8?B?dXFsT0NGRkxxNkg3bmdqUmN4SjhNY3ZaZnNXUXQ3cXEyekhVcERPWEcybTB6?=
 =?utf-8?B?eHNnckpyVkF1NzFCbGc5Z3E2cnRyaDhRTVhzTTA3WkpsQmlmb3J2ZVZyb2ha?=
 =?utf-8?B?dS9wVHkzY2ZaR3RpZ3grL3pkM3RXK1NRdTcyR0RURU5kODRnaVdOSG1WbmNn?=
 =?utf-8?B?S0xoTmVnQ2pTdVpZeEpBY1JUZXg2U3o2TktEZlRIb2FURFB4N0hxTFhucGNF?=
 =?utf-8?B?OENLeTRkdks2R1gwZFVicFFlc0oyWHdDNUJpL3lMaHJ1ZFcvb096MU5pU2tQ?=
 =?utf-8?B?MnpVQ2UvN1R6dE44UFEySUFEZzhyUzdpZGVaZGtKTXNPZk8xbHNlS2JlWHE5?=
 =?utf-8?B?ams1YkZ6VGI0VkZKY0Y5RU15OUF2L3ZIVnpobXhUNHMxTU1EMHlrZUJ6YjZZ?=
 =?utf-8?B?c3I0bm1DNEJ1cFRFRU42OEd4SVk3ekx0TUh6VUhZYnE3aWh6c3pXQXZvTGRm?=
 =?utf-8?B?a0xFVWN3RGc5eDZTWHM5SkNycXFjQUNNazBQaHRvclZYYVE4OTU2Y2NTVzRk?=
 =?utf-8?B?YTFKZjVZdWZpaEFTTjJseThKbGZjZkVtMlNwK0VuVkFuWFBHQzBRSUo1c2I3?=
 =?utf-8?B?STJtMFgrSEtxWTArZDVKaW9GMGZ2ejRySzhvZUxwT1VwTkpJQmdWdmwwb2J2?=
 =?utf-8?B?QjVMQksyTGVPNnBKeXpvekV2Myt6K2krdEZMa3EvVEgyR3FYbzlyaWlGWDA5?=
 =?utf-8?B?UUF1YkdvQnUzYUR4T0FLQUtCeXhmVkJOYkdYUXM4NUF5OXdrL0tCS1BlTVc5?=
 =?utf-8?B?SzMrc0hHL2F3WDYrbWFZNWlhUUhLMUNVOHBlc2xhRVJjUkh0eEZBQ3BQc0Ns?=
 =?utf-8?B?RXZrMkdFMEZQUWEwZHdwUWZzSFMrM0tqQkRuTlQwUzhCL3FkNGhXb2ZoMHBw?=
 =?utf-8?B?RnVSRmZML3pxMXRkSFpnWlk2cW94RTZjaGRtTVB1R3NMdFFhcVdMZ1hhbmJ6?=
 =?utf-8?B?UjRFVnc2bFFmekhrZGFqdmtNc3ZoTmY0MEFFYVdCRjhLSUZlMll3bnNPOU1k?=
 =?utf-8?B?bnpMYURPVDBNNXJ3REVvSEo4SkhYSmw1OVJLclgzcXV2ZWhnZitob0svdWlT?=
 =?utf-8?B?V2l1ZUZYTTBXQkRheDFQQVFxemRhZnZWS094Y1loUWc2cjR1RkUxSXhHZll3?=
 =?utf-8?B?bVRtQXFCa1hDYSs4TmpDQnFvb1R1bXBKeGZ0Y0xTNjFXUExKemtUOUNvVGV6?=
 =?utf-8?B?Z09Tc1h5OXJvM254dTdsTTN0WVFFU2xmRUphYWZ5RG44eWtJWFM0TEkwUjNz?=
 =?utf-8?B?RiswR1FHK1lMbzB6VnBwbVF6aTQ1NUFVRitTalJFVmVwdmNaYml4aXBWcmc2?=
 =?utf-8?B?VTAvc1pwM0MrOTAwQ2hxQ1h5VlU5Z3FLKzJOQkQ0Z2x1VGZSeTY3RW83SzJB?=
 =?utf-8?B?akFYK0RlYlBaU1U2RWNsVnFpWE1QaERnNnpteTNNSVk0dE1PQlJjYzU4cEdT?=
 =?utf-8?B?NkZDT0thSXk3S2tENU5WMDBlUmR3Z3RQNW9Oc0RJS1VSaTdhRHk2QS9ERXpV?=
 =?utf-8?B?Um1kSlQrOWhuNnJ6VFNpT3RqQ1hBT0xrdGRBNVRLMmVXeU0yckdjOTByTGV0?=
 =?utf-8?B?RlZjTHcvTmFsZ3VnUkNlUVdwK1B2YmMxaDBwQlhIc0hDNGdTazBQMFIrdisx?=
 =?utf-8?Q?Al11d1aq7KLTaBoC++QphsijqMsVkk4OrULVY7tAwIkg/?=
X-MS-Exchange-AntiSpam-MessageData-1: BIkI9LLNd4vFzQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30125611-df7e-4f96-a573-08df3b4826d2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 14:21:58.6571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcLinb3WquFx6139W5ssvi2acnpa4zxbtrpj6p5B8fLjf648bxZyL1bvpI5x4DwZ3JrEmC0o8rkWMBYwl3HEig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
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

On Thu Nov 5, 2026 at 12:07 PM JST, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> The nouveau C driver does ktime_to_ns(ktime_get()) to program
> the cpu ns into some hw/fw, so allow this method for rust drivers.

This sounds a bit like we are making this public for Nouveau. Maybe just
say it is needed for the next patch?

Regardless,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
