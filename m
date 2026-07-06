Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F49C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8EF10E91A;
	Mon,  6 Jul 2026 11:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="kCPTib+4";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021088.outbound.protection.outlook.com [52.101.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C85B10E917
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIgpFxlC2tPXihRrXOLrjba1NMXlRAg9h1CAE1hqkgJ5w0mvxFjHQexMwGNKqODht6DolMxQK8EjVk1xJ+cCGeZ9w5JliqmoqVN2YH07euUOxA1lYoM1Ts4E8K1/QckXHxu4mvAWBNWm2f6YReJprs+9mShjRdIei4GML3Ryc1LC/vRNpiUpFk7TbYS7r0F1YV7ugX3WTDUAHqNhH3W4QZDHrz4NyTD4ZARDt+ienUVt9Zd3EXrQ77+z/ygNAFeVSgcv41KA0AjX12HoA650+n0nHAzdz/vnwRuODd4n5f5VnjDNXxsd4smM7ZUZVDKZ0UPw4Holy+i7kOcCIk6IRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LbckhpD0qhz7qg1cg0ip87zc0vznypv3t6bfsQ2ZX4=;
 b=VDWbS6I4x0d3/hRfxdrLErVT35HeOhZSTeCy9mWz5Wp3l0YvlW5Q7ppzRK64C3LRoePSzAsPFXgvkz2i7Eota/R73NH/5rjctjaONpp+1MspIn965TOUoMi7lbuoH1FShYYfuTHcP3l0Y7yIPPqMEZKezX6Vup8I/nWw1tHkhCroXBT4GWgKtUQC2tKqZ6S3GN1VxRJ0dqPcbpRDg20YoYH2gcl7WbybjBSpH5UsyzNnnBnMs80N9cBfAWuwnb2NUe/F3dPfRlxHgIzf09Q13F9V8Yy0nSLikOOawhsJsswBdTIjSxXVrHT2JNRw4dhxMCrQ9CtDBNM5bsrvdy6t5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LbckhpD0qhz7qg1cg0ip87zc0vznypv3t6bfsQ2ZX4=;
 b=kCPTib+4yZbECfrnmM5WMXqahqP6Qt0T7AyRqy/stg9zon5u5tCZeedySLnMD526g3zdyY9mtBqNS1UJT1mz0nw76UPN1rLV8DkthfULk4/PJR2umvsb9AmALLjMbW2p4dpWuxAwUwL3HFF2HCB2FRKWvG7h4otZRP2veFJ15nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7966.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 11:53:25 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 11:53:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 12:53:24 +0100
Message-Id: <DJRGUGMD8CNG.8DWRHJ3PRH3Q@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Burak Emir" <bqe@google.com>, "Yury Norov" <yury.norov@gmail.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 0/4] rust: Add support for reserving of ranges of IDs
X-Mailer: aerc 0.21.0
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <akuV_GRAM4QPqf-o@google.com>
In-Reply-To: <akuV_GRAM4QPqf-o@google.com>
X-ClientProxiedBy: LO4P123CA0603.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 12702f04-27b0-4502-5d83-08dedb552f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: IvPZxypExuhMeWXwu2bXz6XBVUacTB0mfK5aroKdnJfkdhwmNiGh2pFtxUAC0InfFXqmFHEkXz92xaPpIUpVRMzwMorJHBOX6DzGhVzxVgFiPfuV9pjbqjRrHI6d5gegkCfKdX7dQXqfTyRo/OEktNjM3khsVxDJNQcCoopz+p7XyhsQ5CLuBX6+RVZs/Vp2mwRdQXZzOrOKCzNRef+F+0r11GwyK5NSzwBbcA0OG6Q+D20845z5ZtEXLdTodnT+Uh6PwXbAX7omlj5kSbKeeZ3kU2HwM9L8A2aQkNfMGFsdy1ZCH6TZXchI+c6N35klfRdoJXeduihfq9AHcTN1xRP4BGztploEAhkM7/onuhnu4m/zJZpqHL0zU5Qf8UGSzHVCK431D3GJO3S+dlAAkzd37hnsi7q3NqiUK5ocBe+tLcw9BkjxgLmccbLfxzU1PSV5uX6m1V7APZHr10RbeBzdixjcKgKgb6//4CVxqQLw5ijZrBOAC9v9Gzi6BS4dsLwEwIlEudXU2PhHFRq6mp58zUjlPeKx1D0aUvTYJd3RsoYGsF7UzZfMfxKxBfQsI8NTDVlhYc1fli3OFJ4kdPeIHi1YzUqDeIB9q9dHrME9GXjB23MO57M2LQ+iUU95M1LoKRiIPU8i6EfSFQKNfguMF+JJsO6gOtHSN/MK03I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGl4MHJCeHJlOHQwZ1pvcGp0cC8wejNQaFo1aXNNRERLc3J3VkJ0U3U4bFMv?=
 =?utf-8?B?dUNMUnJta2Z5aHpIYkhBUXdiN0tkSUNqeVFCNDljOVZ1bk4wSWdGbVFGOWJl?=
 =?utf-8?B?TldoK1VqN2dyM2dCdEM3c0tKS1BwWGJBZUc3OWsxZmFnV3BtekhVdlhiVGRX?=
 =?utf-8?B?Ni9Pcnh3a056aWQveE5UeHhmU1U3eHJhWlhITmZhS0E0U3BtZ1NCak1hcGEw?=
 =?utf-8?B?ejdZdTg3cjNwSnJzdkpRSUlPZEo5a3ZkSkM0OHA1RWFuc243cTNtMjl2KzYx?=
 =?utf-8?B?QWFYeVZpS2xaSVlIUnBlM2UzTFFjSWxJbWhLM2VwK1BWQmNZeGxTME94aTNY?=
 =?utf-8?B?S0tlbG9WOFRmdFd1M0wrZjVYYTl1R3JJRGE1QUxwTGRRaFRyN1FqMnFRcURt?=
 =?utf-8?B?d3hxRCs0dzhhaU5xTEI2cUNUREQ5emJyd1dFblRDUFBHanpqcHRJUytqM0Rr?=
 =?utf-8?B?RGFKLzBjaENjbVdJdDJ2MU1vVnhnS3BoS3JjUDJoU21BMlQxek5VNWV6TFVz?=
 =?utf-8?B?STV6Q2czdmxqZHhGYVBKM1Z6aG5vSGhyb2ZuN3ZJQVI5Q08yMDJmVzNGY0xx?=
 =?utf-8?B?OU5aZDNiVDEraVRVQ1lHdVJUSEdFbDZKT2NwS0wzMmh6d0RWc0x3cUw4ZXF4?=
 =?utf-8?B?b1g4UERyelNFdG1yOVVxK2IxYUdNUTJ4Z2Q3OUlnNzZic2dKVytOb256cUxp?=
 =?utf-8?B?ZWdrb29FOVpDaUtOMFV6cG9BOG1vWGNnTWV0WnpxRUZrWHh5WjB2RCtEWXI2?=
 =?utf-8?B?RVBxVnhQMDRqTFdLc2VWR0RnYUpxVUEvS3BDWEFjUnM0RHFteURNZFRpMDIy?=
 =?utf-8?B?L2JoR1Z5dmNoanorenpqUkV4VDlTRlBlNVRuVUcrdWpicnI5RExPWDd6bUZL?=
 =?utf-8?B?MGJCa2E4TjhFNGY4NW41eWRmeWNDUEIyYi9QeTFWQ3d1THdtMUE1eDI2Tmd1?=
 =?utf-8?B?aVEzUm5BK0tTWEZSSlNTeFhCQTQzTWsyNk92Y3ZIbmY3ejU2S1VSa2YvN3Rq?=
 =?utf-8?B?aklDQUt2Zm93d2cxbGlTQ2swdXVpWExlcWpRWHZIai9ZNEJEVFRrTm8yZUhm?=
 =?utf-8?B?ZWozUHZLcEJxb2ZUVmZ5aDBqYngxRFM4Y0FnUFM4RDhGTG9ab3pDQ3dIb3hu?=
 =?utf-8?B?NlZiT3hZME1hclE2ajdRNXltZ0o5MDVTU21pdkZNL1FHTXVEQVk5Y2o0R2JH?=
 =?utf-8?B?RTZlcjhhTTlQRlhRT3lUcncxZGxzZmpqZWhwYTRHdGhaWHNsK0ZhVlNhVi9B?=
 =?utf-8?B?S0lrZDJXdVdjK0FtaFJ1dkQ0Sm9Odk1DUFJoK0MyTHlwTkt0ODZQTjhWZEgy?=
 =?utf-8?B?aHJyZWVQNStSakFQRFRDblFuN1MraStvam5UT0lsbTl1bGRMTDNvMlBzRlhN?=
 =?utf-8?B?UExCUTVYMldDb3pGV0ZOUlJkZG1qdlBlQmpETXNOWkVCVmFRL0ZYTzQrMmZ0?=
 =?utf-8?B?R2dwWVBpSEdDNmNlaTVXSysvd25jTFJyaWhyVks0cnhIS2JmUXdmMXpjQ2dv?=
 =?utf-8?B?RGhRWUhjS3dwTzREMU56OVNTVkh0YjNjVGZRUEd3dE5LcjZZS2xQaXdTWE1x?=
 =?utf-8?B?cHE0c3BsZUN4QjlzQmExMlZKaEZEc2hSWFJDYUkyNzRIK1Q5ZXFMTzZTOFBX?=
 =?utf-8?B?YXBJL2kyNUZSSC95cVNXdGFwTUNlUVFMYkx4SlA5ZkRpeU1YWS8xUE02V2pG?=
 =?utf-8?B?OGlqYXFCVXRDdHhrQllIQlBNN0xsaXBTTThCTGxSem8yZ0tISFg5UG5HZHZk?=
 =?utf-8?B?cDdOOEthYityOEN1QmdTejlQOURrdHliUVJKcG81NVhzUzhDTVFUOXVIY1Bi?=
 =?utf-8?B?U0RWVnlwV3lXZElzN2Y5b2kwS2lqMm92Y3dZbTdxTmtkcjhEMEdCdWJRV3Va?=
 =?utf-8?B?dGUxY1IxOEw0OW9RTjdSVXBWYXVaN3VLSlVuVnYvNmVtQ2FkU1Fpd2hGUjdX?=
 =?utf-8?B?T1l1VGo5WEpYVC9TWk1BcUllS3lvc041T1B3UHFCVDRIY2g0b3J2WjZNNktK?=
 =?utf-8?B?VG9tdmc5a3JPcTg2eVRRKzBnUVlXTTdsZUZjam4vNkpWMXFjV2JpZFhKb0NC?=
 =?utf-8?B?OVZvY1JzakNEeU9kZ3VwUFVhOFRuZERQTHZ3VS9nT1ZOdkxFNUpTemxRdXZ3?=
 =?utf-8?B?b1NHV21qam1QcjJHNXJ4bHhQTW5wTE5CRVl1ZjRxRzBSZnkvUnEzY3kwNUhV?=
 =?utf-8?B?VmlNUit3VGZIZFkvcjZxc0JrL0xWMVpoMGNabHkzdUZhWTRBbm5TazVqaTdH?=
 =?utf-8?B?ZHlJZGtOZDE0TURpalZqRU9PcGtjejE5NWVmckVtNVVaWGVvbHpIMnV4MjFl?=
 =?utf-8?B?M3BwbFB6bHYybWVvdG9EcUhKWUp1VS8wVWoveWdSMXhKUE5wbnhzQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 12702f04-27b0-4502-5d83-08dedb552f7e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:53:24.9540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkCxUWR2TSZiQ6qLlWDlMnLZI9lhfaQ3ySpwj/uc0LLRp25wYN1cUMgU7px0f1iQRdzP3k4BncRMaCIOOtFN0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7966
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

On Mon Jul 6, 2026 at 12:48 PM BST, Alice Ryhl wrote:
> On Fri, Jul 03, 2026 at 07:16:03PM +0900, Eliot Courtney wrote:
>> Add support for reserving of ranges of IDs, with a usage in nova-core
>> for channel IDs. This entails adding the helpers+users of the C bitmap
>> API for ranges of bits, then users of that in `IdPool`, and finally a
>> user of `IdPool` in nova-core, `ChannelIdPool`.
>
> If you need ranges of IDs, perhaps you want the maple tree instead?
>
> Alice

Any reason that the current ID pool is implemented directly on top of bitma=
p
rather than using IDA?

Best,
Gary
