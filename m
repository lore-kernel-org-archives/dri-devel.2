Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C671FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D0010E0B5;
	Mon, 27 Apr 2026 12:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="wVT3yWhV";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020110.outbound.protection.outlook.com [52.101.196.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65EDA10E0B5;
 Mon, 27 Apr 2026 12:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqJLot80+C0GYxVyJb1ZJUK7DMdS0rr3GHvZ6HCMr60ssO1SLbGM3igMpYeVE70iVcvxbA+tJjAQhc9Dq25/UXvxIQEuHz8m1E1+IOkE1Ixz1C/hySYTNFjiUkJ6NMZoHGof3eMTF8Ch3rtsX2OPpaxVJkxyNIz9SnADZxsEwiMXmGV1UGxmZ3x+BB1lT2xoV38bcS0Eopw6pMzK22E7kB/Vom+Ovb6YQxjlPJikpKmfKhW5vy4KWuD+z7I+rbPtcLIEvJmlAZm9oq7DWDf3XZBJY4IIDLK75PrneoExDSpdgzL03ee4byTbHtc5bifmXJ28znaMIBQcliRpjjkqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iHVBJhs/o8gE8jQywXKLpuBwriRI5nRa8l9be1IwwI=;
 b=rxi5/HgOGSy8mk2w3hYCuvPR91c32U1KrLSggbXdPXCJf6wJkNXrIkOytu8I3Wvew0k5ICedJ+CE0O2SWnhZqY8BWN5aHNjD5tIBcYexqEFfGRPsRZFvPyuS9JlJ2+05U5lg3p5sb/MJooAWD/tg+UkKBSR+Qrmg1juU8g1AdsIt4Iq9j61WN0Rb5Urpucus5C5y5g+URqRLkN1VkA+KcxbE0nOtBDOKZpuSK00aV5+T7dAwPRhVUgaTNZ5Ydo0gqiwEpxU9WciRzXmY7xv+IItVm1YTWwYAKUQG5IztU5FPgYDsLSLRIis9Csg9nv9I8giV0DLmIfNZ2PttGNhH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iHVBJhs/o8gE8jQywXKLpuBwriRI5nRa8l9be1IwwI=;
 b=wVT3yWhVK6WiXj1Zu6gp+7x55QjRIR99vY6P9aJH+uUUSHHXlsFi0ibAzXTXjbPgzePNlyRjQeT2JZspUUK8Qak3yAZ3hH9Qv5OcZNu+QtT/DoLuK/MGIeLRqYngb5JYkVFcQhJQIFxghCGJ5JybKbl95JKSGjPPLea8rFHZIU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB7292.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 12:45:18 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 12:45:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 13:45:16 +0100
Message-Id: <DI3Y41UDFMAX.3M1CRGCMVKT4C@garyguo.net>
Subject: Re: [PATCH 1/5] rust: ptr: add panicking index projection variant
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.21.0
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <FW-izTUZJ5UeE_3CsMTwNT-XlxQHmovjhfdXQpTE9Eb5aInlYy8Tj1H94gLDiBEOXlVVwadom47wXriTOW0iQQ==@protonmail.internalid>
 <20260415-projection-syntax-rework-v1-1-450723cb3727@garyguo.net>
 <87qzo0r6hu.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87qzo0r6hu.fsf@t14s.mail-host-address-is-not-set>
X-ClientProxiedBy: LO4P123CA0630.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: ae16173c-9a50-4358-9b69-08dea45ad604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|10070799003|376014|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: Ac4KVZLEd+2LnvI+jFFV9fYliv59jAuVmAHVBHiuZURJ3fAcFav7bYTXUV2qyTqxf2GaBoCcLrjdb3jeArIH+rh1r4S2e2CrdYUhUSm1R1QmcQs3egXuf0GW3wLmoGgJYXJ17dNwfgPl9TjagGqbou4qo2nD8+uW9LZEDE72NhSMqFP+EMqXI0IYha1/bO/wNbB1Rk0IoUREIKIW8g7aFLNAMbVaFK7qHZQuJLiVWpyojrRZUw6frLwKG6ZPvvd/63sq2Q1gfkSxmEEcN6aqgw75+93qQHjEDgRxwQEdGj0TlDCCxDZ75IVt6WGHIYVbwUlG59/06s42G0Jlr3iQH6trOyuX4TisMtKJ3B+PndwFYD/yHo6vEgHv4A2BP/3K63lhPTETtCUSn+E3hjZNtk821/Es/ccZ/MFrta3ARCcItrCpWbtwWu+0xedGAvha3zAGXQ9Knsc15hGkFt5ALxM+qebpZV54E1LZBXlYrMxc67eU7AeDv+WlY5u5k2XWZzQk/zxZBQrPi1cGFIVdd/HT9iYPlpYVS+tq9IMJiWpgP49r0GoN5xuuf7odjs75pqdKpOiN2orX/grfxSINHycnU3O4jyonwriQ/U7+8uU49yl2oL9OUVVJbneb2vnyd0PEZBUqpNqM0VEOA4Tp58Pb4RcrLNWABjEdDGxeFxbBi7o6QshEDUeUCaAGDocbGmlkweAwr3fPt8Ca6bFBHW/KRqxgK07Ii0O9nuZgI3xVsx03ceWzVIOyQXyAvvnNOAxZ+I1yMIspPZuWNvZ8/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(10070799003)(376014)(56012099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJ4NlZBR1JiaDlnVDRQTzVGdEN3d1dRaUJMRnNkOERLVWVpMVdPbTRWSmEr?=
 =?utf-8?B?S2krS2tnb01nd0NJYUI4ZThaemZYc0tVSUsyWEx5c1NodXRBUTFYNktrcFpR?=
 =?utf-8?B?bW52b2ZXMEtBQzlZOGVYNFdHbUZJQ1NScUcybHY1SUQxb250UHNRU3M2d3Ju?=
 =?utf-8?B?Tk1BUFRSRE9sc0o1RWpmTm5CWFpZSmU1cFFGdGxsK0xpbjVLMWt1Ny82VWNx?=
 =?utf-8?B?MHNoeFZGVWpaVXpOUkp4bklOaGZSSzFsLzAvSVFQVHZLdDZqcXBScGlXa0Zu?=
 =?utf-8?B?dG9UREZrNWJUdWplU0RUK3hlR2FyM1B3bmZEaDZQK0hMWVhJR3BTSTNDMnRo?=
 =?utf-8?B?ckFVUlU5Qy9SVy9MZEJ2RCtXdEN4cm51cWppTmpmK1k4Y2ZJREJVWGhqVFB1?=
 =?utf-8?B?dFFtSkFTK2J1Q2gyaFRtYUVUS3pVbkNZVUxJQ1d3M2lZb0IwenBmamFnb2pa?=
 =?utf-8?B?cWV1V1VNaWhZK3MyNkZmQWFiaXQ1L3RkczA0Q21ZNEZJVW9BNmo0Qy9OY05T?=
 =?utf-8?B?cVhGd0dyL2tNdmRVdFF6OEd5YjFzUy90MlFmQWtMWlZwOXVvQS9jSXh3YkJG?=
 =?utf-8?B?R1BEbWpmd2JDQy9MM2RaY1dsOHpoZm9hU2xza1FPRGZMSXNDR3FGeGNzZ0Fz?=
 =?utf-8?B?Qm9uRzMycVByT2FXVXVFR3BVdDJXOUJoZ2dNYnpodjdHRUVmbnpLSXFocit2?=
 =?utf-8?B?UUdOc3hObHJvUzVFVE1YYm1oQXpCTmEwWERKQnowQ1dyM1ZYdHNTZE1iVDk1?=
 =?utf-8?B?QjdSYlZHVy84M0lQaXNHTExOWlppdUNhTUtET0EzRHpScUZPc1M5TU5EemZN?=
 =?utf-8?B?c3psRS9TUFJzbHhGS1Z0RWJhbmNDYnVyQ2xRVDk2ZVN3Y0ZPS2lsVHNGam9D?=
 =?utf-8?B?YXFpL0tDUm9WWHAvVzB6elFkeXZ2U2FtdTBrUGovWng4SlNsVHRMeWhINGdt?=
 =?utf-8?B?SG1yQXMzY2NGcFI1TTlta09FK0JCWC9FNHJqQm1NMFZZd3kvRXc4TnJMN29y?=
 =?utf-8?B?YWpKYjI5Qmk3d00zMmgzWSsvWERtME5YNCtqamRrdGR2VVdtak9WYkVSMjEz?=
 =?utf-8?B?enFOV2RKQlRlcXhwQmFkbWlSWG05WWtLNm9tazZJOFI3bmlOM0svTk9XQlBa?=
 =?utf-8?B?Q0U2bFJ0YjlhNjJ0TGhQTmpIeUNGMndjS1I2bnAzSmlQWHk1SkdPdU1IZW1v?=
 =?utf-8?B?Y3N3clUzakVVdyt1QXJseFJpRFVLb2xiSnZ4OGVydWtHdnFVMUxQUEZjaGsz?=
 =?utf-8?B?eUVGQkpObnd1OFZJT2lEK1paSlptY1dMZ0FTcGs0YkRmT3k0QVRta0xEeFRW?=
 =?utf-8?B?azlJZFFUS2xUcjArZHNWSy91eTRsM3F6MjczZ08zOUZTOUdzcXNVd29CRVNm?=
 =?utf-8?B?RzdOakVZNGhpOXdIU2xVc0pvZUorYVZaYnFpWFUzY1JLN0NJUWZZRXlkb0hs?=
 =?utf-8?B?UDZad3NSaUxVU3ZORTZMZ0N3bG1sNVprcHBDWmlwWlVlU2tLem54N2pBeFRt?=
 =?utf-8?B?WDF2Vk5pY1JpT0dlQnUxdDdQYmhUZHBLNFA0MGZVY0ZNelR4RmFTYkhRQTBZ?=
 =?utf-8?B?WXUzMzhNZWcwdkFmcTQ0T0g1UWM1YTQzNEFjTTlBblpSTy9oSHljYlRZS3c5?=
 =?utf-8?B?L3QzTlZWVTNuSjBCcWt0K2dVRnlVanVUR2FOK2liU1lXVTFiMWNPc2tYTmFW?=
 =?utf-8?B?Uy9XU3ZnTFBISi9COHlEUmIxTk1WcnJEVlo1VStTKzJyZkZvQ1d4TXVQZFhP?=
 =?utf-8?B?dlYxNmR1SkVCck1iTUF5ajd5UjJyZHJSTmRldVp2VFF0Qnc4Q1BCOEdZemhT?=
 =?utf-8?B?QkdaRWJ6eC9PNzEvSkhrRkFtbXpVQVBncE5aZXljZ3ptY2xHazN4RVVCeWt0?=
 =?utf-8?B?b1JML3lNai84YzVteVpjbkM0REZXdjJzNnRmczUrUjRQWmVkREJiL3ZjMmZG?=
 =?utf-8?B?YThoZE9ZV3Y2TE1kM0p1d1lyOWlocU1uVWpGU0lTdVowdXRuTGxyZnZzcDJz?=
 =?utf-8?B?NG1wdUZnd2dhU1RxVHN1VnhqRXhiVEQ4dEJEOU9GS0EzdkQxeExRaDg5WjR1?=
 =?utf-8?B?c3JZMUZsMEVXM0NXbnROODJnU3hjeHJNSWZQTzFQRFdRMjRUYm52cFZweDE1?=
 =?utf-8?B?amNxVENsbUI0Sm9STzBqeFg0VGZ2QmFhSjBzeHZhcmFvOXBsMzlERXZESitm?=
 =?utf-8?B?dWltY3pWTjU0U0xLblJqdHoreWZubDdYNXhsTFZtTTIvdklrWWFPUTBScDk1?=
 =?utf-8?B?Y2xIc2hkZ2EvSXN2Z1pUWW9xUWV6VXN6YlRJb3QwUVhlTmRmeXBnUS8vVmRC?=
 =?utf-8?B?clc3bUtIWWg2R3NnRm80WFFENyt0aTJrdWcwQm1sd0psaDJkNVpIZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ae16173c-9a50-4358-9b69-08dea45ad604
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 12:45:17.9572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4haEIaEK/y7ocSWpTraTMgyLUHJjLtDRmv1cipe5bfxRMuFFZUx6JqaFTQtuc+XKzdGJk6t9YA1JtCXP9p+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7292
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

On Mon Apr 27, 2026 at 12:24 PM BST, Andreas Hindborg wrote:
>> +
>> +    #[inline(always)]
>> +    fn index(self, slice: *mut [T]) -> *mut T {
>> +        // Leverage Rust built-in operators for bounds checking.
>> +        // SAFETY: All non-null and aligned pointers are valid for ZST =
read.
>> +        unsafe { core::slice::from_raw_parts::<()>(core::ptr::dangling(=
), slice.len())[self] };
>
> I think this would be more readable if you move the indexing operation
> out of the unsafe block:
>
>         // SAFETY: All non-null and aligned pointers are valid for ZST re=
ad.
>         let slice =3D unsafe { core::slice::from_raw_parts::<()>(core::pt=
r::dangling(), slice.len()) };
>         // Leverage Rust built-in operators for bounds checking.
>         slice[self];
>
>> +        slice.cast::<T>().wrapping_add(self)
>> +    }
>>  }
>>
>>  // SAFETY: `get`-returned pointer has the same provenance as `slice` an=
d the offset is checked to
>> @@ -100,6 +116,18 @@ fn get(self, slice: *mut [T]) -> Option<*mut [T]> {
>>              new_len,
>>          ))
>>      }
>> +
>> +    #[inline(always)]
>> +    fn index(self, slice: *mut [T]) -> *mut [T] {
>> +        // Leverage Rust built-in operators for bounds checking.
>> +        // SAFETY: All non-null and aligned pointers are valid for ZST =
read.
>> +        unsafe {
>> +            _ =3D core::slice::from_raw_parts::<()>(core::ptr::dangling=
(), slice.len())[self.clone()];
>
> Same comment regarding moving indexing to next line.
>
> Side question: Why do you need to explicitly discard the return value
> here (`_ =3D ...`) and not above?

Because the result of indexing is a slice, which is unsized.

Best,
Gary

>
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>
>
> Best regards,
> Andreas Hindborg

