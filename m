Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11061094481
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 00:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 860B110E2C5;
	Sun, 22 Mar 2026 00:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="MiBIgTKF";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022119.outbound.protection.outlook.com [52.101.96.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5042010E2C5;
 Sun, 22 Mar 2026 00:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcAMkHygnRLuRZTp1fPDkAe3joS51f7fTb1cqwcMIQOteyiDEVz+8MFYl9Ya0x23U7Y0z3yuiuaBi312hCfVBnXbpr9JnVBjB/AaeUu9xwdISPaKdQoRQba0LJKEHb8pbHcsZIgRuep+Am3H+SnDzmrZLz3E5wx9x0pcdFIrUZVnMKFZF2OxxIjih3+3p7ibqiJteVarH4Obai6AqVIUPZGCZUuQJRlLJgFvjzau4kiDCINxr6cnt/KHczl5BDJPt5UzNQm+79+7/XumL485VoKVo7HVIRkIc/ytGJFMILFbkw1K140Z4X1h+Dl+I4F2hiJKLy/YfVvXuY+ZMXNoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MqJbYfyAXF1BIRawIJFHfk096aiIgx6wnrV+28u7CM=;
 b=jLdeOrwHJLUlVVZ7pjk3y7ZO9hQkpnuX1aGBABqF4utxZXH+lMTcio0FqlkxTuIjmvDb3yFEjufls6t1jotGyfoTzej+U5kX2yNyx6qT2nMubM/js7t88IUieo04YTg48V11YqmpR7LxeqI0CfcLoOuIWmPMe14/yy/Y8CBMk6KjBzmYqtgBqUXd3xjHo3KQrnoDmoIZuCzsIuRSXSoqvwYUThC5xT/Vms13+cLBDEWV0fb5nT+4ZC2RludXJvTYxRi9lzLesJDE+PpWRH14RxGK+4mpzSXXYXrr+sNwe0IGC58SmCTUUJcuHWsRq+X480BiNw2/DN7tJF8h9XGHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MqJbYfyAXF1BIRawIJFHfk096aiIgx6wnrV+28u7CM=;
 b=MiBIgTKFetkRP1ulho48JDLxR3AIL+zd3YHHQ8oysxc1AcXQBuA/Sw0MnmNaqfDHS2mEjkClMPPr2YP0vAaFj6Oq/NRVxljeBbWFhtak4WCbop+ZBFWcWVOntbPwALo56w6XLci663KpPYSOmerTr4OMGh8eYlbv9yfJjjDGkV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7480.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:41c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sun, 22 Mar
 2026 00:47:26 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Sun, 22 Mar 2026
 00:47:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Mar 2026 00:47:26 +0000
Message-Id: <DH8WATAVCH33.19JPYBAOILCZE@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] rust: dma: add generalized container for types
 other than slices
From: "Gary Guo" <gary@garyguo.net>
To: "Aditya Rajan" <adi.dev.github@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, <aliceryhl@google.com>, <acourbot@nvidia.com>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>
X-Mailer: aerc 0.21.0
References: <20260320194626.36263-1-dakr@kernel.org>
 <20260320194626.36263-3-dakr@kernel.org>
 <DH8UHISTLOA4.934370PUTLB4@gmail.com>
In-Reply-To: <DH8UHISTLOA4.934370PUTLB4@gmail.com>
X-ClientProxiedBy: LO2P123CA0092.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 587ba811-090e-4e68-a5bb-08de87ac96ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: DZsWP3+/z1NeBV6XW1rWeErxjjOboFtTe1yQ49257QJEkqJNyCNAuCj9DjvvCgfsXtJOJa+d3btUP+C8ZUc4fs4xbtJIKdl+mU/pRskEst3tfNDQWmkRSeL7BsCk54s2438vLNT9787L+EpbVvlSRv5N4GaBAZsWAsBq5pr0LXEnuCC+gFmptW40foZdVqpf6KTivZeIzAav0rfoD8Lvh/b+MB42q08pMnE7O0Cg/0gm9w4QMekMm0bSxoGwgKXOMoRhZi50OQSEhRqoIUdYznDcRLgS60Ql6p8QgKI/mhwwhcvXGYvWa6Ws1tNrTVRwulx/KfaiSxIz1W7zjAyZvVvIJxCc/mUXFuAiDgJsq4w4BGjOfoK8wbgOkb5dutPgkQeOvhjdiTh43siXDeDKd2liNCK4/FATX3JFZHSY8Q3us/cc/pzu/5zTFLTH1z760X8GYZVIeyLBtExgQpsK8TjTSt/YU96iPyUgtGV+aVWx/qpcqR2zLIaDbu0DaV+TqJV2977qcRb06QTSk6swUvxkQUYBpKnBEHjWgWO3vc/I9XhQlSx1bZT+TS+DAIUie5LzQnOXA/zawlL48iN6tE4aoN/EMIQr8lKSxGK1ICQ8fFMLswvfRrRXOlGN3fqa/W94R5VsuSyy74SvAX3i57gogXCiwcWFhemwJfKg5UhEtqE+/37pgw9mtLrSGraZYtA+L3iRHSTflMAiuWIYLs/rnT3LVC+H9IrPJbmBbAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm9MQzAzMjFjRE1kWFV5ajR5bnNBSzBFNDFYck1QTmdvN09EcmxXWTVPUklB?=
 =?utf-8?B?TmJPWmxlS25rYkNiOUxRTUVBOVJmWVRhY1RwVUxXeStXVTFUWVRPNldTdlZS?=
 =?utf-8?B?bWtJZUVRWDc2bjNvalE5L201eUVZWlZqaUxoRHNXVnBXY3NRemJ2b1lMSnpX?=
 =?utf-8?B?bld1ZkVkTnVpMzFncnlteFc0RTJvZSt2eWZudnExMWJ3K1J3T2pPRjJoeWpz?=
 =?utf-8?B?cHJ2VzEwYnpZdktDQVJxQThkaU5Yd0lXUWhRM3ZnL3dHd2pNcGF2L3N0cEkv?=
 =?utf-8?B?aE1vSDg0eHBhNWlIQWFLMHR2M1VwVWNHcVFZMk5XajRWYTZBM1JCdHNXaU1I?=
 =?utf-8?B?SHppMWpxbEt1MW85STRmaHJBVHZHVkk1cnkvQ0o5Sk9UMW45SDYrUTdVQ2Ry?=
 =?utf-8?B?VEJWM2xVK2UzT1E5Y2FwT0pmL0UvQjRIV3hrU2x3aTJmc0tLZldnU0pwaDFG?=
 =?utf-8?B?R0QvQksrak8zb0RFejVRVEZUY0dkK2s3YlFtQ080a1BWYTcydE0yY2U1V2lu?=
 =?utf-8?B?UHhsREk1OE5HQXBXalNCV2diME4zMTF1anlRMjQ4U1NGWXQ3ejFHUVZuVlZZ?=
 =?utf-8?B?dE5YQW41K1BmL0RRNUFBWmZTZ01UV2VCWEpTWitpQUhrSG5UdjF3ZGpHd0xx?=
 =?utf-8?B?RnBUSHdtUjVJVW85MUsrUElwbFgzaWkyOExOUzZRUWhReWl2bXJLRXZYenp1?=
 =?utf-8?B?ZTdrZ1l3ZGZKalY1UnZNM2ZuTmlYaWx3MWs5aEZOSGIybDAreStKL1psVnJn?=
 =?utf-8?B?VHVLZGNLaFJuVlZiREd3VGMvbGZBb1VvUzErU3VFeUVtd1FHSERnK2xLc3Rt?=
 =?utf-8?B?ZWdVbzJOMVUrS3N4Um5tU1dybXI4ZzlidFE5bGlvOTRDT0pqTTRjRjBEL2ph?=
 =?utf-8?B?eUhpRDFXaTlhc1pUWTZWbWVRVFBhK1I3ODNoOTJkODlWRjYxNHlraE0zUFVn?=
 =?utf-8?B?bjMzb0RIb21PU1pzYkhOamFEaUVXWWtRRUFTMm5oU3VReDJDQ25kdDg3UjUv?=
 =?utf-8?B?NTFuR3pnaUpNWklkQXk5azdiTHRIL3ptb2xJcTRSUTdKN3l3YVJuYmZsVmM5?=
 =?utf-8?B?MDZyN2NiMlZRMytFTmVQSVphZFdwRENzQjg4YlJNalFZOVdVd2F1Wjd5M1lM?=
 =?utf-8?B?OHRRQndGOEowcTdLVEUrU1hrZ1U5dnU2ZmZNTW9Ib0hOY0w5R3M0eTZ0OHBz?=
 =?utf-8?B?L0o4Sm5aSjVoUUJnbHpJb0NkZSt5NlZLeE1wbHJ1UEczd0ZqbTRBbzZXT1l2?=
 =?utf-8?B?YVZaZ1V5UE9ib2J1aEJoNkdaNTRLcnl3aTBjdVI3cHMvaXp0VE1ZSjMwZzZt?=
 =?utf-8?B?ekp6L2h6Q3BQL2Y2eTNySVdhMVpuVFI4NXIzZTdHYTd5RDIyN25FZk5YcWo3?=
 =?utf-8?B?Ums3aEI3RTBHUzZKcFNHVmkwVEpPbVdvNTkwbGdZKytNYndYMVVmUFN1Rzg4?=
 =?utf-8?B?MFJQSGxiYStvdk9hSktmUmJicUdja1hHWkR6VlMrOHovcTlHdDlQZGlQMHdz?=
 =?utf-8?B?Mk45N09ubzNKbjhmaGJNZ040TkU2OUs4aFlUUkd6YVc4NGdTeWgxNXUrSlBh?=
 =?utf-8?B?Y2Y4ck0zWWpwVURiZTN5Ryt2bHZuQ2E0NVJZU3k0TWFqRkZ1V2dDVkYyeXZG?=
 =?utf-8?B?dTVpbFNpcWcwRGxZWTN4eGpFL1ZYZkRyUit1U1BBbHpSRWlSTkJCL0JncnBV?=
 =?utf-8?B?ZDloU3g5VW8rZUk0N3FOUUdRSk8yM0syME9ybVh6VlhySmpRd0tkbGJxMUdY?=
 =?utf-8?B?M0k5VmdlT2FKQ1Y4TEJlbkVSeW5LU2FhVkJhWEhhOHZhUytDZnExZ0ZKd2ZN?=
 =?utf-8?B?MGt6bGdPWlN1OWMvT3R5YkY0Uy80Sm1kUW1tcUFQOFdvMG93eWlCd1pxRnJR?=
 =?utf-8?B?a3gvTjlxNzlaZGwyeVNFeVJCMlVmUFU1eCtmVStSNXBwUFJBWU5hNitmQXk1?=
 =?utf-8?B?NGh6a1FhNzlnUDdIRUp3cGZDdWF3ck05NVVXN1JrN2ZRbW1XYnhBeWdBWHk0?=
 =?utf-8?B?ZGp0VWJXaTdxNFZMMlZhQ0lhL2YvZlh1TXk3Mk1JV3E5SGJLRUZINTVBTGVC?=
 =?utf-8?B?RDZLdVZSY2lEUXQvQUh5bFBvUWFSUjBzYnhKVEpqdEpwbU9rbEdFbFp5MXZU?=
 =?utf-8?B?cmdwSk9INmI0RU1Ca0QzTHJiWmtvRFJqZDVLWkdKTlUvSGRZT2djb3BsbUc2?=
 =?utf-8?B?VWtqeThRN0xCbkEvQVpGWUVlaStRenVJaFIwWmtXSU8wT1JTbzdxV3pQSHdk?=
 =?utf-8?B?VzNwTGk5OGR1T3gyR2lGRVBrSVUwUHhualVUTVlxSjNGYWpVSmRReUZ1aTcx?=
 =?utf-8?B?N3pENGFITHBSOXZLVWY2SmR3bCtjTGcrQ1NMZktjZXpPNW9Xd0lyUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 587ba811-090e-4e68-a5bb-08de87ac96ac
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 00:47:26.6184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEfxsxFhBLD8Sb9MdsLXHxXjw9y0jt6KnlYGmTV+jFKr4awwAtYGYRlSWOWW50zaO1JenOJVVMKzaOB3xgL0cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7480
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

On Sat Mar 21, 2026 at 11:22 PM GMT, Aditya Rajan wrote:
> On Fri Mar 20, 2026 at 12:45 PM PDT, Danilo Krummrich wrote:
>> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
>> index 2eea7e2f8f04..ff3e147f1a23 100644
>> --- a/rust/kernel/dma.rs
>> +++ b/rust/kernel/dma.rs
>> +impl<T> Coherent<[T]> {
>>      /// Returns the number of elements `T` in this allocation.
>>      ///
>>      /// Note that this is not the size of the allocation in bytes, whic=
h is provided by
>>      /// [`Self::size`].
>> -    pub fn count(&self) -> usize {
>> -        self.count
> There is still a mention of `self.count` in the safety comments; perhaps =
that should be changed to `self.len()` ?
> For example, see the safety comments in the following functions: `as_slic=
e`, `as_slice_mut`, and `write` in same file.

They're going to be removed later, see https://lore.kernel.org/rust-for-lin=
ux/DH87CCNRR5EC.2SK3IT6N6Q8V5@nvidia.com/T/#m30142b65bb87af64860838565c784c=
304e02b563

Best,
Gary
