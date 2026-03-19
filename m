Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32457103E19B
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37B8310E84F;
	Thu, 19 Mar 2026 06:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MZUATd1Z";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011020.outbound.protection.outlook.com
 [40.93.194.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C2E10E84F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:09:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kza1qA3kVhGoE4Q7EIqcl8XRmnavOkclvHewoLUTJdZhCU4HH9byxn79tCokk/i2bhTJCj6HB4kbfYidvkdVOjqjaIkVuMQ7c7q25NO8lYkKsaR6zbg5RDok8UTLoij1lzRb3A9yLMsX5mK7cxlpcAiz+uyV29gFpw29Q98T8jFIKgixa8IFpyPeJDeoCOumhFwnOYJ4uw/WQTKmbeviZFjhYI+RgQwCiyj5A/4+fzM/TI1YbC0ryO+puOQd0Mlw3XdeqzqqYCKMkHwBhAIG4tQJkZzE1K1sIxyuXKwCHDBhHlT/02UWr64dbydXHI2/PMO13KM3XotgUmOhGR674w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5HOR/AULqLVRmWI0MElwcEFoYot4Ac9L5Ei/ZkYFgI=;
 b=HgpR5NoJpIP6lZ5kalUzUNiX36MgLadH0xt2CL902nSUuKGoyz6mf4itU8WW5OYmYd6y2YPC8pucOYIL+eQNSGHzBNen8ncfGWpG87S4O13LbyJQr+iL6UkEsNlE82dyH8nj9O9sPECvApFe2CEMwlfOhLL9NsXFiwA+b3Cuqmoz/IIyCbVwWvGZ76fN4VlRZYsocR4a4lDFsVn/LVXveDU6ZfHzVnzu2wT+mhoLddNcjMqoBfqYytLX7Ep00pHEwA6jFzbfQlJTWlxzu4LCpxm8ZwvymIovh/48rBXJHoFwzyp90e8WsS/JkNKwBF6ZSzOSwXAGSI9mK9JrTt/TUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5HOR/AULqLVRmWI0MElwcEFoYot4Ac9L5Ei/ZkYFgI=;
 b=MZUATd1ZAGkVRa50X424cXiPEqZLaBi+RFi2gqt9miadIW4sfDB8GuDJXEPZCIv6HxzV94K3IWxwChVow0/D/ro+I4tvgsE9lkWl40S6XVrWo2/TkB8TcXUkqe0reKPNobenWeYNdgiw5imKj3T73SRn3EoqgR7pDb0lnS2hX1ghSVZwqsvjZcKPBfAFTb3M4yQqeZvD/2xZkvVlvi8AVoGvZiWE5ZXEMAq5qlh+UdAU7TcDodQVg7uRQXBZex8wSrMI4cwa3Gdevg5VE0pmDNX7SMimZz5uN9xGYxRGqRvArJAC6y4iGfM9lgvjl40MTne63ITTckKTTVre1cojpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Thu, 19 Mar
 2026 06:08:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 06:08:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 15:08:51 +0900
Message-Id: <DH6J9A1Q7R46.136W5DTNUBJ4H@nvidia.com>
Subject: Re: [PATCH] gpu: nova-core: gsp: move Cmdq's DMA handle to a struct
 member
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260319-b4-cmdq-dma-handle-v1-1-57840b4a4f90@nvidia.com>
In-Reply-To: <20260319-b4-cmdq-dma-handle-v1-1-57840b4a4f90@nvidia.com>
X-ClientProxiedBy: TY4P286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: d867ce1e-ceac-4d19-467a-08de857e0046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: VXpGmyckAIYGacY6506v/5y5o5UZc3gZECStfNsr4Vuf4b+T2TqdDLpEzQy25vsgq9srxT4J9J1lCtvDABELIyIXyO5eQxlkospGEI8ZahRTH4CB6uO3PeigI7Gslen/d3Opu29Nw9mhAoKee/1PzYtK/Nji9KPm7R37S72V1S6fqoEm38T02+ZO2yN+cfSPPYgACVjTQ7o4eetXsiekVgbug/QPIFLhUEvKeRiuuRKyHre+KZcTpxcYgH8QE+n6B01nyrayfd9K9s+C7rWAJKGXs+GMM5WXx2tSxc8aGM+2R1Q8nAG6uSJBKaA8wsf6ElyinvaaPMlpOhFN9As2owBpvZRObNJ5VlcJDfCGkNjX6DqNuQQijv7JehBycIsdN0FSWxF6akbS1d20TwTcNmOq14lgoH1kMD03ByI4x2V8LwMKYLPmaiHaFQm4SsRPVVh97QdV7TpojnGppNwavAyzi4ZRWSA/MoOuTBqDI5T2a+kQs6DbGBRmmyQs7z8GAKfdjdf7sXAcuYwgBW6oQCv2/QQzfPGSKW3Qg7HmcRoqWGJG4Xo5rDEQHbsxG0TsV2ClMDRWvVDJgdfovRvey/C7sN8SFJaV+Af1BSyssoqX+/V/cyKv8qWVHCOmlz9FbASdnbE+yKDkbbUZXieyo4+mfYyUHa0G415qZv//Le+hbwSfkfAfZwf9q8qzqf2J4aA08c3uyGjvZlj3RdLoRflSZ1jm2rQKRKwWwoqnW2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlNFa2g4QTlpbEtOclM2MjgrTU96T0hIQ2Uzd28rQ2F0YkxnNG5KSzJ6TUtZ?=
 =?utf-8?B?V0pYUFBVOTdlUFdZUmxUSDNLTmZXZ1AzbDZTb3pMZkRaTElNVytLcWRIbFY5?=
 =?utf-8?B?d0RRaVRudUtnMTFjaVFoZWlrTWRzV3J5OFNYNzQwak9IYXUyMHdQWnJ6SzNR?=
 =?utf-8?B?SXYxSGVKTGFPaXp3RG1sQlE1bWRmc1gvMGVGZlNtckRYTjdOT0paQWpleEdZ?=
 =?utf-8?B?M1NBRVNERFZwVG5nU2MyaTJ1WnRLNU1EN29oeHlabTRMdEdRN2w4MjMyOFVQ?=
 =?utf-8?B?SnZUMm5nWXVnVWlEZVpSbThiRHFUM3V5VVBMc3huTlhMRjFZQ2loWE1NV1U3?=
 =?utf-8?B?NkZBRjQxcUZOUHhXU01jS1hKSXZ3Sll6UGRUK1BnNHRnSWtaV2xzWVNEZ3E4?=
 =?utf-8?B?RFprMHVabHhPcEtoa3oyMTF6dVNlZVJ4MUVhems5SER4WU5YUW5wSGE3TnJG?=
 =?utf-8?B?NDhVQTlIZDExUHY3ODFxUWs3ZlVXZDZabnZQeHMxWk10YmZWR21tSldObkhK?=
 =?utf-8?B?ZFQ3VkJvc2Fnc1FFaXJNTnllMmt5TkN5MVVWWU5aNkFFZHBpZHNaOXJUSkNK?=
 =?utf-8?B?UFU1RnZ3SFhhN0NrbkN6V2NkMUI1Z3E2ZFI0ZEw3dTlGK1RTbnVpTzZCeGFq?=
 =?utf-8?B?MHBycnZOQUlsZGNuZFQ2aEVtTlI4dUtsZllINldnVUx2cENSZUJYV1YzaTNV?=
 =?utf-8?B?SXp6b1RVWFJHRWVNVzc0TjBpSC9TZ1lWdXZmMWE1d1ZCTGNOajBqbyttZzcx?=
 =?utf-8?B?UUF4UXBJaFVHRXpOMFo3ZkpHTVl2MGFUdnhSV2t4YkxIOTJRdTI0OVh2WmFs?=
 =?utf-8?B?eGFtWjBJc0h0Zlg5RWhESVJDNkMxTEdFSlJBOGR0eWY2Q1R0Y0FqVDR3RG9H?=
 =?utf-8?B?VHU4dVZEKzFnYlBZRTN6VFF0MmtoV0hiUVFMSkczY2d3OVpqcWF1c3dZTzZC?=
 =?utf-8?B?cUg1ZGMvei95bHlSNkovQnVwNTNZZGl5Ym43NmJvenRKUW9OWXZVSnhwcG1X?=
 =?utf-8?B?RUkxUGU0WGwwV0ZUY1ROS2V0eDZUTURVenEweUpDV0xLeVVQTlFnejdqbG5y?=
 =?utf-8?B?VEp0TGhUTUpsOUxEOXVObXpoVnBNNTVjWVo4YVBrbUVtWGJlR2JNY0FtY2pw?=
 =?utf-8?B?WUlxdDVCa3lzRStnQklFK2wrVE42RGRaZGtmV3dXRjNiQWlhNmp4UWxTaytK?=
 =?utf-8?B?TnBjR056WVA2OWNpQ2xHYWxzRlZROTJEYnpnTjJ4UUZudURUNXpwYkRLeDJy?=
 =?utf-8?B?ZUhBVWE1R0VtSVN1OGNiZmF3UXZPUVgzYW82UTU3L1MzZFk5VU10WUtCa0g1?=
 =?utf-8?B?a3pOVzR5UWNoT2tjQjVkd1J3Slo3NlVKeXZBend1bXBEQ2c3UDBCejdhUXph?=
 =?utf-8?B?L1V6ZHloN3NGT3RWSmk2dS9uRWZKaFluZHU2dFFka2VJb0lrUWJVM2YxWHh1?=
 =?utf-8?B?RWk2MHZYejhQT25VdUJNdHVWeE9qL2lxam4xZldJeWJSczRaSGNmM095bEU1?=
 =?utf-8?B?Tk9wcm1OOU1WeUhqZmxwZnNZd3F1OHRKUnVhVnVwY1RES0RJeU51bHRoeHdk?=
 =?utf-8?B?YnF3UWs4Yk1OSzVXZHBidDAwdkI3c0lLNzF6cWFvbzAyZWNWaUdIVDRlbGxs?=
 =?utf-8?B?bUJ6YzA3bjBRa3FJQkhYWTVHMkVVWE94U0lobjdqWXZ4c292RHl3WXBhNlFN?=
 =?utf-8?B?ZnV1WG9qd0hEZTBSdHJwVndzcXFwcFBnRGw5WEdtM1o4aGFvOGtERlRCTjRN?=
 =?utf-8?B?cWRDWHN1MHBZL0ExNUxKLzJtQ2lyM09sMzBmTkVlZGltUmR6NkpKenl3RDNL?=
 =?utf-8?B?MXZhRzVxQ0FFTWNrKzJYQTJFNzFYbmlRN3ZKNEV0aEFsRnpmZXowaUlRZExY?=
 =?utf-8?B?VGFNRlB0SmtObUxUbjUwR0FIZGJ2bnluNXRKblUrVGMyUHBkNmtJK3NJcGk2?=
 =?utf-8?B?cHJUTXB2MzNRcHZWbXdQTkp5R1NSaXFhRURGaEo4QUMzcTBtWktMYzErd0ZD?=
 =?utf-8?B?OTdrQllGcDg4UHMvWnhndUtuVS8xb1J2SGhIK2l1NHFlaERhNHpEbUdCcjE5?=
 =?utf-8?B?Wk9uTmU5Wjlqa0R1aVIvMHVDbW9lTWpKdzlHOFM5V1dsYUdaaFJXcnVGM3I4?=
 =?utf-8?B?UmYwSFhVZmM3aEN1enFRWWFmK3BOampnMjh5RnlLZUpuVzhManpKaytUVGdJ?=
 =?utf-8?B?OWI5MmxEWllPdkp6b3ZaNzhKeGdCY0trS2RRY3BjajlTT0dpNHMwbHhmR24x?=
 =?utf-8?B?Tng0TS9wM2VUOExTQkduNGltTzZFUVo0eTFjSHdlSG5tVENGN0pGRGhmSGRT?=
 =?utf-8?B?QWlnYmZzODRtMzA0cXMrNmEwdWxKQjlselI3Tmw0dUNUMkEvOXJ3VjRyZUUy?=
 =?utf-8?Q?ldw6S+qzghZW1UW9bVP+PrNWaXxIul7+K/4+EiPMwdq8e?=
X-MS-Exchange-AntiSpam-MessageData-1: sQ26SY3hJiKcfw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d867ce1e-ceac-4d19-467a-08de857e0046
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 06:08:55.1396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTnBrb5DjY3qjy+svysQNnDjjOYM+bi8tqh1y1DYMzBekqnDGATQwrBYv6CQ+ApfqWBCYLeOMIFt2Cqk1nlCRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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

On Thu Mar 19, 2026 at 3:00 PM JST, Alexandre Courbot wrote:
> The command-queue structure has a `dma_handle` method that returns the
> DMA handle to the memory segment shared with the GSP. This works, but is
> not ideal for the following reasons:
>
> - That method is effectively only ever called once, and is technically
>   an accessor method since the handle doesn't change over time,
> - It feels a bit out-of-place with the other methods of `Cmdq` which
>   only deal with the sending or receiving of messages,
> - The method has `pub(crate)` visibility, allowing other driver code to
>   access this highly-sensitive handle.
>
> Address all these issues by turning `dma_handle` into a struct member
> with `pub(super)` visibility. This keeps the method space focused, and
> also ensures the member is not visible outside of the modules that need
> it.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
