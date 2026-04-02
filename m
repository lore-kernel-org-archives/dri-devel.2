Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C351112246
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 01:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7348F10EB0F;
	Thu,  2 Apr 2026 01:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WaS/BiQe";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22ADB10EB0F
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 01:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdlmdQ9VDyT3SinXQ/cwoiz6J98qRehjXKWU++nQkyiC1RRqXLZHxjJ5BJqmwqsdhUOWUdxpaJiWOjRDalbZRTu6rp21BTFIpM1bmd13ycf0U65yb5RaKH1aLmYZ3c7+5UInYy6zhickwpZqoF4UBXInwB6jKg/ZfUKht60wnO7xMCqMO4DlQ/+a9Q2RJencWEuDgngGSyHA5PNaKXD3wUTBmsGfnYgoggUBUouZ+nc6bQo7/JQfTArYad93CtDDbYmXT4C7p3HHxE462POJJxCy0p4dgCScZM+TYUy7Oo5O+CV6+ehoiDfYesnljvrbNh4FfIySZnPG3WiHMn+BlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMMXDh3Eo0QasAECJwzKje5WRkjt5/jAeRFWP6Fhsm8=;
 b=xf2uLM5iWWSL6rC1t4bZbvmi4QiFjSRqnkPAYE+IRmxXQKhLGT5DiBrCnjHXxq8oERsGx3UBxxtchvlQl7N2y7GRXgWI/rK3t10YH9lxOOkV1Anarrix1CAzcvS46uEXegrMODfwAq5CZMKvssH4PQmkurb12LwCmgFkhCrSxEtlvsnauCjBa8ovaAbxvVc0+1nA7gn5cCreMDXUGN+h9+BoyKFQxnONmklCEoHHgKmclE9ctnzajV2OvLNamX0MKwS3ElGNfW3IaF7XtWa3ni6qxCR/Ktuxx/HxxJchD59cyuEZPJ8VEuI68O4yd3jy2aQkEgHfx2f19VzAKLAAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMMXDh3Eo0QasAECJwzKje5WRkjt5/jAeRFWP6Fhsm8=;
 b=WaS/BiQenK79cc5akCwlekcbNo317CEo6CXW+weIlKTYrZ3bBW/Wu+RVLvEgSgRzoJeLV3syG66ZAFw42Bzxg5LsIC1any0Jmd5rB9ZKcBRqyeZhRVrYcKk9tgCu29l+xLoiiOKHrldzavEvrckhQGg5u4I07YFTtrKkIOIZv7Dgbuo8wXQbRzJLTuLZLJmeSx83lajok//HJKMTiTP0+eUDbr4COViRDfotTdBm9TjQrlCCFvjIEKD4fFUG6tNZL5p/L5mGcET6bvE+CMHr7YnJH2PaqpzPSkMIDxDlPXNmuExyrnCtsagh7P3fg2oPGPA0XEdcdg/WnXjS2uj85A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 01:03:14 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 01:03:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 10:02:58 +0900
Message-Id: <DHI9IPJEWW6Y.J0ZNXAS9T7AV@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Lyude Paul" <lyude@redhat.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: bitfield: fix broken Default
 implementation
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260401-fix-bitfield-v2-1-2fa68c98114a@nvidia.com>
 <DHHJ82YDW7FP.2ZFKZUQUZZ2H7@nvidia.com>
 <DHHXFZ05SBVH.2MK50Q9PMTVDZ@garyguo.net>
 <96e7ec53-9b98-4203-a011-77241c95ac88@kernel.org>
In-Reply-To: <96e7ec53-9b98-4203-a011-77241c95ac88@kernel.org>
X-ClientProxiedBy: TYWPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: e2aa1abe-e11f-4d31-46f3-08de90539713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: modyFCoLkgS1i9FFSG/ePJ27RKDjjsT/DTNr697hmTuHLJsJ7JZ2Cj7CTSQPy3EVHLhXsi0lHp8qAOne5tJWnAgcxlW2vPFX548C7GN2xeB/zBe1S0RsqShs82JcppxYZ9d+Y3+19D3TviFhVRVz71tm9cNAgI309/w/Ceu0Gnd43XhuyEE/A5jlexDnbGMbceJIKJBe8Otnaeil6r+OX9fe6FyYzF+JvJ3QbzsblrZpjNW8i1i2rOoBOVEJkNY/xyITJ5fp1oQZWO6yxypGH3JOM6RilJO8hOYswKB8MpItT2g+EBTwyawIkfrwB0V9ncb1KitTXykLRpZIAQaWkqsof+mt9WFUxDaBbz+6gBaSPMc2jePSLI8Xo4LwbpejbQN2wD3rllkHW4bw7sfn/uHwS2GgRrzJcv8PLGSJovfsK/48kWLdiu+f+j1M7II+liwY7Xb1joPDHh4J1P7wkpxPwUJnSKXkEEAB5XNOK+uzKT6XznpLiPZId2cfYt0AYimQ0jUQolWFqDx6JSAEiUpK+7itPHYAw9QdOqL0efsoNHr/8Ubuj7lZRAGXgElF7secJ+Hb8u8w11doYllyaXwO4WvcTpi75rOb7SgblCJy/qets8FHXUf5LIlGoXQ1WX4Zjl/FQUzYorqZqXZ/V3L51m5LHW0mMd6iaVw0rDNlhzyEeHcVr+k3Vw7pEPHxsjeL/fX88q07TUSag/+b+JoetXc+3MsIbhw0Y9tcj/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0EyR1NOV1VqbkhRbC84MGdmSS83RXVlVTI3WVpWUXhOOHJrWTRyaDdkRTV3?=
 =?utf-8?B?eGcxeUxNcExrTzc4SEJIZFI2cUFVSmg2a001ZDBZQ2FHbERtL28rMlFsN255?=
 =?utf-8?B?NzZSQktQZ1hTZkdVbjBJcWFocE9oMm1GS0NrVWNSanBEQmJpVmhrTzU0a3ha?=
 =?utf-8?B?eUlrRzlJZUJIV0dYbCtUcW5IU1VpSHovSVN6UU9lUERIMWxwSnZ3T0NDdkt4?=
 =?utf-8?B?alh1QWVlR2Q1ek9vRHpKSUVEck8vYmJjaU11WnFOOVRXNkN0MGUxTzZWb2hz?=
 =?utf-8?B?S25kQ0tsUHcyb2VHWEdzTS92K0N0blJLUjFSUW1WdGlNRHZxMktDSmlRVjZy?=
 =?utf-8?B?dW55UHoxOTFxb2VOaGZKNkozR25YT3dGcTNFWVI5d3hTTnhNZGIwQmJoZmc0?=
 =?utf-8?B?S2RjTFhLZm9aTVF5Zk9ickM4TTZCU1RCTkMvWUlrc3JNVWQrNzcxYXJENWpP?=
 =?utf-8?B?ajdQQmZHQ3UveVRoYmwzdGc3ZmdXcmcrZXE0Q2tDUXlNcUtZY0hVT0FrSW9H?=
 =?utf-8?B?YnFDU09SV1MvejZDL1loS1luSk5HMVJnU0tXeHJia2xrOWREa2xIN2FGdmFD?=
 =?utf-8?B?UnZnWHlvRm9xVkxQUW5WM0tWbmRUU2M5SnNhMlVEN2p5aS95TWdPVnJWcVRL?=
 =?utf-8?B?cE81QTA3N3dWSC9NZkpjK3VYbzNrNHlRQkREektkdHMwSnNSd08vdkpnSE5S?=
 =?utf-8?B?WXlKYmUwK0ZScE9OSytCTnFkVmQ5V2doRy9BMmRoSHBvZHlQWG5rOStJWHpC?=
 =?utf-8?B?WElNTmR6VmcrR1JmK0p5VkZUaGFXbG1EeW9RZ3Q4aUtrTWhvcGF6U3N2QTBh?=
 =?utf-8?B?RW5mMzFTOVdtOU0wNHhkcG4zRVZiOEVVMHlJbXJweGNQbk1sNklGaE9XNVN4?=
 =?utf-8?B?VWEwd0kwVC8wTzRvQmR0Yk1SRE1TS3N0cHRpMDJ4ZS9reUxKSUtYVkdqZGhr?=
 =?utf-8?B?R2QvVWZpRVZRRUs4aDhGL245ci9MREJPNGI4NC9KQmlTOHlDaVpTODViWmpu?=
 =?utf-8?B?ejlraDhNbytBNVA3OE91YXU5RnJybFdzWVlGT2NYWTA2d2hmb0RuWnJheWN3?=
 =?utf-8?B?RmpqOUhhTjV4NGRwUXI4Z3lZYnUwbTZUS0FlY09GWUFwNU5NeEc1aVl3Ti92?=
 =?utf-8?B?VVFab0JMZlliQ0xrdWQ0d1oxTTIwQzFCY01xSVg3bXNxS084R21FZ1dMMmRN?=
 =?utf-8?B?aHVYc1JWZVA3d0MvYndZVUNTM3k4a0FpS3J1akJ1R3g2V3VoOWlsSTdDOVhZ?=
 =?utf-8?B?d2JscVpLd0x0S2VQSUNkVlVMNTJmSlFxbnZ5dVhKN0t0TlJQMnU0OVpwWVN4?=
 =?utf-8?B?akY3V25Hc25wNUZ3Szk0SU1WR24yY0JBaSt3TlZFL2tsc0RIVE8wZHo2SC91?=
 =?utf-8?B?cGZveDh4RDVmUU1sTEovOGFKTHo5eTF2UXEzTS9PamY5ZmRVenVEdFhmMzJ0?=
 =?utf-8?B?d0g0cS9tOU5lWkNRdXNGaW4yRkRKWUNGSWZjM0dTKzQyUHlBWFB6Rm9oV0pa?=
 =?utf-8?B?Y2IzcGRXcURmL3VsSmlGdWVkcWR5b3JQZEFneWZzYVhBMFlOWFp1NjR3WGF6?=
 =?utf-8?B?MHp1SWZSakpxQlI5dnVaWjZGY0V6N1RwWUNjazg1Q0ZmaWsxOFQ0bW4xblBE?=
 =?utf-8?B?VEhZOXlyZkFaaWRuUkRicUdhOGxuSEFScEU2WFV3dXNEQzdza21TUkdOR3RL?=
 =?utf-8?B?M0U0N0E5eGIwSlZ5UVdhMFMzZURjbEwvazFDcDhXVTR4T0tMVTM5L25RWTN0?=
 =?utf-8?B?SGdncUtjajdjMTl6c0tkVHBmQ1FvQzUyVDdETUlUdmNzcEVkUHRDaWhsNUs3?=
 =?utf-8?B?M1BKYkF1OUovN0lyeGYya0lrRzdsYmF0Y3N0VGJzZVRVQWxxcHpTdHUxb1Vo?=
 =?utf-8?B?bERvMzArZ0llZUZqU24vYmtwelUxc3B4bzBiSmFDU1ZQVjhaS0ZJT0szR2dJ?=
 =?utf-8?B?YUlqZGFxdlViRStPczg5ZmJUcE9LY3V1N0tBemFWamhBQURNWDZ2VFNMa1h6?=
 =?utf-8?B?SnovVksvdjVPZVFHNUk4YkoxdDNDOURBSHhISEd3Vmd6ZXJ4YTBmczZVVisv?=
 =?utf-8?B?R0FXZ2t3NmRMcjFXVi9hQUhHWFN4TlhhOE85ajAvVE1JUkhpaWNXamVTZ1hG?=
 =?utf-8?B?ZXBiRnRTUmM4WlZiQVpSaWZkM3NGWERVdHdMWnJjaVRWSm1tVDladzhtWS9q?=
 =?utf-8?B?dGhiQmI3VVA2Mk9JeVBOT0x3ak5ac29hay9yZldyUndwU2lQMy81MGR0UldZ?=
 =?utf-8?B?eVdqSUg4TEtmbDd4RWZaYnJEcWZJb2RJQ2syS0NteFhyNGlDT2RLejdGWDl1?=
 =?utf-8?B?eGNyMUgwcG4wOExWb0FOMDl4bEJEdFk3RGp3cGwxeFg2QTJhYU9STW9TVklZ?=
 =?utf-8?Q?0PYwmmAtZwYDr9zdbcdecUmKkf8XKKriI2t3p0PQLz0yE?=
X-MS-Exchange-AntiSpam-MessageData-1: edTw59k+BghHBg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2aa1abe-e11f-4d31-46f3-08de90539713
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 01:03:11.5395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KK6YEM++oCUVaRMHH8fplnSfKZPkQrJrPSs/lRv3L9KGWmaL6ale0pHPz40IHAHYKUyMscCk5drVyh/N2r9/5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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

On Thu Apr 2, 2026 at 12:44 AM JST, Danilo Krummrich wrote:
> On 4/1/26 5:35 PM, Gary Guo wrote:
>> This could go via drm-rust-fixes?
>
> It seems there's nothing actually broken due to that, so no need to take =
it
> through -fixes. But we can pick it up before drm-rust-next opens for new
> features as I will send another -next PR for the unsoundness fix anyways.

Yes, nothing actually broken from this right now.

Thanks all
