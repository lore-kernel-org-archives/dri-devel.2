Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC12FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 901FE10EF7D;
	Wed, 29 Apr 2026 11:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HkM0H7Bx";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A467F10EF7D;
 Wed, 29 Apr 2026 11:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HR/OIVIG2sGoEysT2E0TUXt6eV81lNfVZ/hFoKd1BDchHIYzwHYNt4IUBIvIc4Gnxaqcw0s84lu1X5/HbyKVixPT+uDzVrc0Mo/UkerSZWsFq39lwUCP7EUbR6Si0RHrfFdcc1ebM8YjlJ70dCofBI1Ky3x8x2tz3qRGqg2GDNxQgm/0eizgtwlR2ILOx+lOqLi7PpL4i22hIVXucMeDOPZRqc4ZLjIV9D9xAHJoPy8mrSq131MLSfWtykUnw5ymocn7c1wBAiC2gnBSm0Azh9EHiJfJerZZVa8hsU0g3PODiul+J3aGORujl4AaNL0TTdsv6gUuxf5xxlfmZLHKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2yD1/7to5qbQg/PYyOUF0muAwUY9CCEC+4FxiKV0Uo=;
 b=x/2QzWBYI5YIvYWStl2BvEpKC5PQc0rcW9M4alu+dhj3VKTrm3moSAZB278gx2Rf+r3JBx4QwdH934ohhSIE8qVFEOzdK3r9ETTlNQDuErDXxDztS/ThAuJBgq24uhav4MsXYGV23dLXjRXup1rKwDZnJ7PasYWywT8gmjmyT8IE55OLHPUv3fmWOESNGNss8RZIKxfZi1qwr1Zg0R0vVYmqewZ/ksDvHkB0h50SDXUl5B2AMT/Jg/76htdce8KkgSXNePLxMCcF+S0Jl1WT43CylGYT+8EqlIU2ydj+w9c/pZ1GI74rnowiYqQupSVJaNWMHIJ1KynMxSBBG+L8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2yD1/7to5qbQg/PYyOUF0muAwUY9CCEC+4FxiKV0Uo=;
 b=HkM0H7BxCcX8d3fKwbqlfs3Pfb2Yqo51AQY1vXLhBxRRe/04SeDRULTfvfiVK22DOl40XMDOnnxHzKHtNe4CI5c9FOLKMoZZCkhn8dg/usDAigB10rQNQlVJ4287ZVcBVfxXw7328HhVfSPlZqnxvHmNAesLIBJgHNAZD/vg8jjS9acB50SMfH566oEJzNJg8Fx8ok6Tv2cP+xKz9C18STrxS+YaoP510OEB5v6bQVWWe+Is8Ni5WHmw3JCilFhUl0SWbmpmXEysCQLb7KimDlJTNV3aqY1SuKMwKwjc05qq8xbppSMm/B2FB5JrXGhnU3gqAfMt8FWMhbKSl2mqOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 11:24:03 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 11:24:02 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 20:23:58 +0900
Message-Id: <DI5LMVWUZFT4.1JJ3YY1NVGR66@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 4/5] gpu: nova-core: use pointer projection for command
 queue code
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <20260415-projection-syntax-rework-v1-4-450723cb3727@garyguo.net>
In-Reply-To: <20260415-projection-syntax-rework-v1-4-450723cb3727@garyguo.net>
X-ClientProxiedBy: TYXPR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:403:a::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 618a7fca-cdf3-4ebb-62fe-08dea5e1d0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y4Egiw4uKazcx4TJWCJP5EUDggzi4EDt0FH8vW++r9mhPTuctSIrbnAzlA7nhXQuj6fbxVyvjX7zEGK5rJGw2UitNliMAPslhG53RGU+7L4aYMHCeXsG1xkKPCBzm5gr0QaW9PT746SzASpnoP/aibuhrsYIG10hj5Ixjb6WmtDVur5ET7GFXcrCW69k2uXZZU4a2YQBnI6Lg2PajpSJHPy0GJ09eKNiU/7r4DUVmQD2bChBJ4M9Ed/bNZV+hOeZpYQqbPgXXNBlEOaVBALo6fpSp/OnYIbgtX1zda6pmaI9A1O85eyFvSa4MzL2Z8+jNY+yN/tI7xDfWGf3t449iscXFv53oZywhvp3ZpJTB9ECN9lCXeq6IIqYAwojKI16noGyr3Nmwu/OErD9EpRYRPFeItnuuEutwfakK6b+2cgtJwVqP6G++NqYaHyLu+caPe/ixZ6jlrUEBoeLxDHd20Dr5tilUeFEftTRO37kX1VWvn1kgoVWV60B5bq1KBMjlwU2WxKTFTgoQNg883lIcRmS+xAnTqeL/CLwQG3zIwlzmR87pbubkpxOffRNlOuVUgsu8+LaRdCR3Kj6BxRIlS64FdlBhTWruuyj5Gj2o6P0YLsXt04u3KQ8MIdElxnjvwxltMx7XCdOzpTkpd4ZqfInIwdXVuBIbRMIMG+Y0g4UOaZM+7AkMI7iyJvkX0po4OYRrOu73ul8FWSsafuMgf5NMsS3DqcL343roEpdcAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU1IYzFjakp4NCtZQStIeGZSOG10WFZsVnp5ZXl0L3BqZjRvMzhnMXBtd1dX?=
 =?utf-8?B?Y1Jmb1QzaUY3K1B2a2Q3amtrbXdLdHFoSDdvVndMeXhyZDdWcDZYRFRXRkVX?=
 =?utf-8?B?UWcvZkR1OXllOGNkUmRKOHdnOXRCa1lDeGpQTmx4NlZiTVJ3cWNtSkFOYURH?=
 =?utf-8?B?cUJMaWg0ajJTV3p3eUhHRW01VVUzNjBUaGprVkh2cjRVWk9XVEdKWldTTDZu?=
 =?utf-8?B?SXVEQmQwYWpwdWI0cEFjYlNFeUVJbXZ1RG01ZzJEcDNDS0g0Mm5oa2V0N3ln?=
 =?utf-8?B?dWpqU1loWEdFZEZVc2s3bWdXcjhXME1rMDc0c0FmZ2xMY1pBQVBZZVBOZ0hh?=
 =?utf-8?B?anVBdXI0TzBvZExFbWoxUkpjMEhSd1M3ZmR4dFc1ZWRJcGxJaTg2K1Rxekpl?=
 =?utf-8?B?RkpXZkdqWkUrWVNUYWlXSjlQMUkzZDZGM09VMFZ2N01OajJWT3dLL1pORGZK?=
 =?utf-8?B?R0hLcVB4Y3pMVEU2S1dQcFZ2U0VtbnQxN0g4bEpZWSt1cUt5NUprK2JEZDBQ?=
 =?utf-8?B?UUkwRUhlWDB3UkxCdDlpbHpOSnNSWXJNUWtBQnlyQ253TkRML2pnbTNQbmtR?=
 =?utf-8?B?VzVTMlBoSkVRbi9PVHVKUWN5aXR5UWd4TGtlKzFpUjlKdzZCQkJnSnNtWiti?=
 =?utf-8?B?SkpQa00wWG96SHpIblIrc3FhaGdBNk1DZFdBTUgzWXlaV2xhUjR4T3FEZ3pD?=
 =?utf-8?B?OVo0VUYvbzZ5SkVnODBlTmpTNUdGdUx6RjJlVUlYOFkrQlJBSlpEbEg4WFhO?=
 =?utf-8?B?cDJ1VzQwbmo5TW05N29jZ2o5WHY2RHg1ZHBmSkhvZXlTNmxPQzh0UkN5cFBr?=
 =?utf-8?B?NzJsM25VSjJQd2JsOGxtcHc3TXJMUVgwL2FZYjJWMzZveEZ0dlFZL0l3aVRp?=
 =?utf-8?B?NlJTeGgrRGNRVVB3d0tVNS9LWHQxR2JjTEpZNHIyKzdpdjNrWi93aHFyZEVC?=
 =?utf-8?B?aXpFSmJEYVBpeW9ndXlqU2JPSzEwN2puZGE0UlVnaHVUUjRBaEtFU3JDMFE1?=
 =?utf-8?B?Ukh1K3Ftckx4empGZm5mWWFHUTJRcjM1NG5OTU95REh4R0JrQ01SS3NnRWJR?=
 =?utf-8?B?VURUZ1cwRjFMRUtqZGZhRG5wOGh5UnB6VXhtbDNCS3NLRjRwNVBreE56UjFP?=
 =?utf-8?B?aUZzUGR3QlFOZFdFaW1UZElTamI5YmF3bGV3bUh6QzM2dU84RE9ucWROT09v?=
 =?utf-8?B?M0xlZDNGdUZTK3d1Y1JaMHJMdXpvR250M1cyemczTHYwdFYvUXBXRmlYamNY?=
 =?utf-8?B?MTR4RzBTcFU3QVU4NC9tMVVCK0FwaU9sM2V0bmV5U0RSSi9jQSsvWEIvMi93?=
 =?utf-8?B?TWhFQ3I4Y3hXaHJXYkg5KzBFZFd1QnlXU0daTEZTTVNYWmZ1TjMweC9kbzJk?=
 =?utf-8?B?VFU4UFdkMk5sZlBJYXRERmtOMU5OZDhKbnozUHVxRHgyK2Znemw1MHE2Uzlz?=
 =?utf-8?B?QkNQNmRhVUx2WUJiNVBFZmx3L084cFIvQUdqZzJiTU4rcDI3UXVoSXZFU29t?=
 =?utf-8?B?bVRWU3Y3NkJVQzFBQWFreXpyYUl2Y3pWb1pjRStiMU9FRzdlaXpVK1VqVjBW?=
 =?utf-8?B?MURYVy9MWEZCQVlnOFdrNzdGMWxMSUwyK29iMVFEeUwrYlRtMlNVVHN4UU5a?=
 =?utf-8?B?OXhFZi84VWhSdExJMk40WEUxUENUN2hEL2hRdUo1c014UTFFRUoyNi9WUU9Q?=
 =?utf-8?B?dkRUR3hVdG8vZlA3bmM3Zi9TNXlrOE9QWTNXMS9DVG9VN01qS09OaWswMDRp?=
 =?utf-8?B?bW9Wc2RLZ20wM0VkV2M1M3UwbjVMdnd3V0VPVm5LY3R1c0s4a2pyOTQ2NnV0?=
 =?utf-8?B?ZXNDV1BYTEthNWwyeFhpbXZpQ21kQWNXK1A3bkQ1MFErU21JVUtOMkw0N3hQ?=
 =?utf-8?B?cDNrRW9vbFNaN3VjbVJsOE5CZi9OSHN4Yy92Z1dPakUrRDV6SWZLRHJnWGMx?=
 =?utf-8?B?WHlzTFczM2ZSOHIwb29OVWNoVmMzakpkR2hFQnRIMUc0K1FuU1VJMG5UL0ZW?=
 =?utf-8?B?K0QxU1p2bGNMSWsyR3dlZFhKRDNhTEEzUkNCYlMySGcxdjdnOE96UTRwM0o4?=
 =?utf-8?B?YWRRTS9Ca2xYeG9tUC9mUGNrWGRaUkloL3V3V3k2UFRxeDNxRXJUemJqZGZI?=
 =?utf-8?B?ZWZySXB1M05TM3VqL2xVdm5XZEx0U3pEeE1SeE9CRjk0Ti9xRWZJMXBxQ0k4?=
 =?utf-8?B?ZCszUWVxLzhsYXk1TUUyelQwbG9wSWVYRHg3OTRxaDBmQmlod1hiMmxRMThX?=
 =?utf-8?B?c01VTnVwajc4UFJ2UlpERzhyVUp5dmE5Y0Mvcmo5NGlHQzFsQnBMeWJMZWw3?=
 =?utf-8?B?LzJqY2xqYXczS2ZOUWJlYzhUU0ltRGZ3K0RIWmtIS2ViTElzTWtaZWRLeUdM?=
 =?utf-8?Q?RDNFXBOH4fouL0yHHPEvok8bKJb0tmjDHFUFYTS7qtDP5?=
X-MS-Exchange-AntiSpam-MessageData-1: 56s6creLdGYDtw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618a7fca-cdf3-4ebb-62fe-08dea5e1d0c9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 11:24:02.3920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkUaknTZOIiR0L3Ds5fwkp6q+hSIEDv0u0WeZCp1EGErGduavWBf1khmfS9NkwXit2bBF7yJKLrN3AyuFsHN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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

On Thu Apr 16, 2026 at 4:57 AM JST, Gary Guo wrote:
<snip>
> @@ -318,39 +331,40 @@ fn driver_write_area_size(&self) -> usize {
>      /// As the message queue is a circular buffer, the region may be dis=
contiguous in memory. In
>      /// that case the second slice will have a non-zero length.
>      fn driver_read_area(&self) -> (&[[u8; GSP_PAGE_SIZE]], &[[u8; GSP_PA=
GE_SIZE]]) {
> -        let tx =3D self.gsp_write_ptr();
> -        let rx =3D self.cpu_read_ptr();
> +        let tx =3D num::u32_as_usize(self.gsp_write_ptr());
> +        let rx =3D num::u32_as_usize(self.cpu_read_ptr());
> =20
>          // Pointer to the first entry of the GSP message queue.
> -        let data =3D ptr::project!(self.0.as_ptr(), .gspq.msgq.data[buil=
d: 0]);
> +        let data =3D ptr::project!(self.0.as_ptr(), .gspq.msgq.data);
> =20
> -        let (tail_end, wrap_end) =3D if rx <=3D tx {
> -            // Read area is non-wrapping and stops right before `tx`.

I find these comments helpful since the logic is a bit convulated - can
we keep them, or at least have something in the same spirit?
