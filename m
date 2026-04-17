Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74ACF8E4A4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28DDD10E27D;
	Fri, 17 Apr 2026 03:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QxwKk1MP";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011004.outbound.protection.outlook.com
 [40.93.194.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED2C10E27D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 03:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3hGIDR+UWpnpHESimH0xVRdLYQH5uRmAyu6E6I2UGeiVbdFKmlTwSz1UoAfef9iPOIEfmjynFjsyEn9X8fNt/BXOMeDzJV/Ywf7mZ4AH3mgnk2kj3usbFZgWo6ppTGAGGh5CRBBroqFuQsd2tjrO6GmXRRVBub2ZenVlePLt9kwJs4aqjab7gYhCfW/OkDxHVUNLUx6uYObsKjG1sfnyAc5ju0gqBkzeswtYKmRxXy1Aj2iqiahvT7t+TEOzkVynK9j5lzKwuoXMbIY5eHuHyzoypm6F4RLTtc+27ZwDNucBnM6xO1cTz0LB57oM/V0BHwzyq52AZp65+xgldzIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFP63I7pZ/UHRgFvh827m1yrWdMSuSMSTIYB701ge9M=;
 b=LbkjT0BB3Qi/G2mklvIp8i/32kZTcpnMznqkqgfj7r60Ink7bnNHO4C1bsgvK8YJBstYVjmGVXFXHN3BcwzzZnppudY3jeWVGKSOz2QV/re54RSrVwi/8xjgR3BUS27uISlW3ldPgxkleSX6sZ84LHCGQmJ6iKW23mbdiZO9WRiV24ot0Z9aOzeib1aciSC9CxdVmvH90AmEAoM+uAE6OqJpjfVIfC3iotRKjO125WzHLNxbPADzj7BMB8ZD/8kPn8sVEDFbNbm5IvjESPQajfC/NdmEpmyz679eYgv3Xi+JNP1dNtpCjvqlFgd7EOxBvewJdPIE6j8fipNNxekdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFP63I7pZ/UHRgFvh827m1yrWdMSuSMSTIYB701ge9M=;
 b=QxwKk1MPSuqmJ1F9oeoAw0Zqv9rBO+c5/pFRs4oshw2D7MOo/BwD8q0n+14CAS+OewJl0ZrBnrJ9CxtMw1p4j/kOwYfpKfoBbULE91zfsbP/CNIQOU+56rSYwzzEmaK6wj+/1AOHuxrQ3INWOkmokwoW6HZO1141BVUbhSksRcotj+SJTg/Y0xPY/sURvbdY+YHKtS2IoVKwT1A6q0jEg2nFT8mAbYr1zhhahWcIxuSDVReIEiZggjRQ5r8+gG/ytDTl4yPdiSPzjyV/rskWHS1m2v/a5x4ezM9SXXdKzNHvcmomOazhk8nAObHoYLXTYZeohChahcpTPL9Z5Mfltg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 03:19:43 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:19:43 +0000
Message-ID: <fc4b9204-b4c5-415f-8435-e7ae03418dcc@nvidia.com>
Date: Thu, 16 Apr 2026 20:19:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
To: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Yury Norov
 <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
 <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
 <DHV1K1097C27.33XRWLMZM6QZA@nvidia.com>
 <DHV3N3R9NJU3.2HXR63MP02NPO@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DHV3N3R9NJU3.2HXR63MP02NPO@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0145.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::30) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: eebc8b46-ca80-450b-bc5c-08de9c302af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: jfBz6BKVfXB+v8fT0btk6/ck/H9dsjyNVZUUQ96lMkcOL/0R4p+pJIFpxXA/+W2o1VB7L3AlvqanWk9w84GphM/mVnnkrtbywpzYcEf+SMiWdosrkIvq59FOY5DJ2BhssdGE3rOt2b2vDq6B0jHpL+EoBNhTnc1kLiAVYKQL9Bu4gsBD7dgYIOhYaLAIgV1wR/ZJ9XbaiFOQpUnJsnipo7GadbtJzGVfPV6rhzyz4blUiO+/zXxSb3K01SRhhtp9r1jQdVP2JxdjUxN3mSfIVho3A1OePiBD3P7lRCVnIQxueZ3ujNOqU1aB4x1BoIVmDv6NIKgX2DBATtgnAf2bik+grflVCGOQqBCgyhPflao4v6NboXvlFL9nKsznRTkfS5cjQ/oUaciNOaBsubH1+KGo3WHeDOgM5gs/qCzWTfuWb2lB01xg1L97Rwtz5O8dmicmdTQ4NJnG5s7KU+Mln6ZD2kPTjgtLEkfb9tzK3XGFPuuF01jcubSsDiPc+GHN09dndDKlpP/moMVtcCNs7Lok7s5CIslQUTN8sotGmkuf2YC8fWHewePEPwWRB8hc6nyrigLFI5ePfcg1uyLvDZJ4xVwdvgzZ5Pidh1sPgdNsM2/pDp909Hwx4I/TY63f9/9yWzwMl3Hx5ETjoa4/jDj+0PjzZnKuuYGtfFCYBp2VWakZzaM9AIrHjAykcW9ygzEEFtmXPpkdyv142Zn6h5Q/+Rx+Cmb1ethID/vZLGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBacDRCNU5DQTBBdXYvOTU4cERmdzVicWg2UVJVSHlVcUNMV0Z3TnlUUXpX?=
 =?utf-8?B?Nk5pTi9aOUFjQlZ1VnF0ZlZDdzhtTWlZSXA2cTFyMk51Q0dINndPRnozOGFp?=
 =?utf-8?B?NEx0V2lncDZTdnhRdWltL1V4QmdDOHB6REp3RFpBZ0FOMFVYY1JJZ2RhaVl0?=
 =?utf-8?B?cHd5ekE4OHBzQTJTeEtXK3Z4YVNVV2hsKzlxSWVCYXAwQ3BtcDBHaGt6Z2o1?=
 =?utf-8?B?ZEQyaS8rcXk5cTRjY3QybkJ3d0FmTE5RdTVSOU9Cb0RDQkc1ekJEaWlaMWhr?=
 =?utf-8?B?QkQ3cVc4UWZMajhhbUpKdXY3Z0U4YmwrZ3l6MEx2M25zQWt2YjZGb0U3SnIw?=
 =?utf-8?B?cURlZkZGZ1c4STdvVXNva09HYWdLMjdwUUw2bDdrKzhEQjhMZVFZNjRLUllj?=
 =?utf-8?B?a3RKeTB3R1dUNHhhYkE2Yno4clN0UXNoWmtFaHFBUHJpTGJHNmVZUVNEMnps?=
 =?utf-8?B?KzRYUEwwekVieDF5M1ZPZUFPeXJHL3YxN0gwaG00QUcrNmczb0E2ZEg2T1Ni?=
 =?utf-8?B?dEJkbHgwNWh5VFYweXZyMEx3SjcwcmI2REYvTkdPZ2tUOHBiKzhsUXNtUTdD?=
 =?utf-8?B?a05IYU9obTh2ZHIxOUw2eDNGWjlGMTJRNmV4ak4wOS84R3prTE1mcCtCSnNH?=
 =?utf-8?B?bEZDb3VVQ2NkNEdUbWovTHlOdm1UK2QzSDVnY3RYZVllMU55QjdZZEgvMDhz?=
 =?utf-8?B?YlBnelQwMllGMTFJa3BWNE5YYU9QTzYwM1dHV292NmcvNnkxQ29MU0lPZTV1?=
 =?utf-8?B?cWRrT1ByZGg3N2U3OFJGMStEQm9QQ08wank5Vkc2MHhQTlBQeTlLQitqSzJs?=
 =?utf-8?B?ZnA5Y3Y0aGF3VCt3bDVlb2lxM0NQQWpCazlZM2YvWWhUY3BDTnRMZVNsaWVv?=
 =?utf-8?B?S0FKRDZhejFaK2ZIdUtQUnNlTEJGV0p3aDB1UldwS0FQNHJ2cFVvazhpTHRS?=
 =?utf-8?B?Z1hMc3NzLzZOeFZNOVAzNjJNTm50SVNJcWtEMHF4V3NlN3ExOUlRUkNkODRD?=
 =?utf-8?B?QWF6dk82dHBHMkZ0ZTY2a3F1S2xxbUh3UzNjRzE4WHhFa2hIeVl5K1IyMUI3?=
 =?utf-8?B?cE1QdzFFUmpja05XY0hyYmgzdkF2RXFxek55MllDVTFaZ25RN3ZWam5IS2VL?=
 =?utf-8?B?Q25UOFYvUjAwcmEyTnNmRzJldDZkL0ZrbFhuN25QeFU5UFovbjR2ZGl0MFVt?=
 =?utf-8?B?bG1PRHhxMmJBVXR2Wk5WTU50OU5nTkVsd2NWbEJFV01ob3B6NVU3UEd6T0FJ?=
 =?utf-8?B?bnp6L2xaYVBNbDhLU2J1ZDA0OEdmQ2ZPbjBMdnEzN0ZQV3VLdzNLWDZOQzky?=
 =?utf-8?B?L09ZNExyY0ppbTcvOHR2cVZ2L2ZxNE9SWm8zRkNaL3FweUt6dUcrbWZxZ2pw?=
 =?utf-8?B?c0pBOW1SOExZWnJLdFFXQ2FiM05GVk8xM3dtZUpiRzk4Qlpob2FDSWVyR1FG?=
 =?utf-8?B?VXg2cmhwM0VoRjVHZGhvVEU4eEpFM1E2ODJmMlJlcXIydUFYYlRHci8wbFpI?=
 =?utf-8?B?MUpwNjVtU3ZHaTdKY0Z1bUlYZnlFTXdqQ2syT0JicVYyMzZuTXd0eCs3OEdj?=
 =?utf-8?B?cXBLbkFhNjZNY0lhQzg2Y0VBZVVXRjRKMThDc0lmTEhkdmlPVzVra045dkdO?=
 =?utf-8?B?bTJsajF6RmNGSTk2SEFQYTF5ZEpjWXg1MmdyRGMrUTZtTy9wZjRFeGRhY1dQ?=
 =?utf-8?B?M0tSbUZtdGlURUI4U2hzekRuZXhSRU1zbUVkSlFRZi96blBicVpSVVVuSFhX?=
 =?utf-8?B?VUFnL1JWZDlIZElBUHU5REwzRlM1VS8vNHp1WVdYYUlMOWNseXRGTFRTM3VQ?=
 =?utf-8?B?RVU2OFI1eUd0aGNkMlJzU2EwZ1ErQ3RINWVPZkFMdWxoUXdFYXRZeDlVSUll?=
 =?utf-8?B?SFZ0QktoaU5FYThiN0ZHa2pVK3M5WFM4TjlnRlhMZXpsMkdzSzhoTjh2M29L?=
 =?utf-8?B?WGNJaVB5SkNSWGpwc1QxcVNnWEtKTzJ1c3dVTmVPSW9vVWJIUjlORmJRMjYr?=
 =?utf-8?B?WW9KY2FYSWVMNmd6WWgzcXI1MmI5SHFzdlVFVEdlcURMWmUraGphcTNnTTlJ?=
 =?utf-8?B?THJIbE9QU2xvKy92dkd4TDBnZWpNUHpTSmh2ODFSbEorclNaK2lKaW5VOFls?=
 =?utf-8?B?NlYzU1pGTzV5cnFWVmNYMmdIYWU1dmdRZDZ5RnhqdWgrTkdjMU9MVUFTR056?=
 =?utf-8?B?dTdZcWd6VmpLNU10VXU2ai8vaDJ5aTVsL2FDZ0RwQ0tiTCswVElibW9QeEVR?=
 =?utf-8?B?d05ycTc4Q2dlWTVQMWU2SCtlNG5tWXl3YmNweWl0OFVzUnd2R3Vsa0pPUTZX?=
 =?utf-8?B?VkR4WTYxeGYvZFo2eFBmSlMzbXB2ZDRsTjN3SU4rcjJnQkNSZ0wvQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebc8b46-ca80-450b-bc5c-08de9c302af8
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 03:19:42.9152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41IKemqWa/4VCKlLrT8xIljzIr2azVC/g8ZYccdIb/+613tNNn7HZv+d6Su3EkQLH3MRvmBrG4Th3tl+spJwOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038
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

On 4/16/26 8:11 PM, Alexandre Courbot wrote:
> On Fri Apr 17, 2026 at 10:33 AM JST, Alexandre Courbot wrote:
>> On Fri Apr 17, 2026 at 7:18 AM JST, Danilo Krummrich wrote:
>>> On Thu Apr 16, 2026 at 1:22 AM CEST, John Hubbard wrote:
>>>> Can we please put this into your drm-rust-next-staging ASAP? I don't
>>>> think we have any comments that would really need to hold that up.
...
>>> But now it seems to develop into some semi-official "shadow infrastructure" for
>>> when the drm-rust tree is closed after -rc6 and during the merge window, and
>>> it's not part of the official drm-rust workflow and other maintainers don't have
>>> oversight of it.
>>>
>>> So, in order to not motivate workarounds, starting from the next cycle, the
>>> drm-rust-next branch will be open for new features at all times.
>>>
>>> Consequently, all patches applied to drm-rust-next after -rc6 do not target the
>>> upcoming merge window, but the next one.
>>
>> If that doesn't add any burden to you and Alice, then I think that's a
>> definitely an improvement to our process.
> 
> Actually thinking more about this, this might not be the improvement I
> expected at first.
> 
> Take for instance the current time of the merge window: both `rust-next`
> and `drm-rust-next` have been merged into `master`, which provides us an
> ideal base for sending patches that will target `-rc1`.
> 
> But if we keep submitting to the pre-merge `drm-rust-next`, then we are
> in a situation where the extra patches sent to `drm-rust-next` need to
> be rebased when `-rc1` is released, with a clear potential for
> conflicts.

Yes, some conflicts, but probably not too bad, due to the much
newer base, right?

> 
> So at the end of the day, it would still be cleaner to use `master` in
> prevision of the `-rc1` tagging and we would be in more or less the same
> situation as today. `drm-rust-next-staging` is currently based on
> `master`.
> 
> I guess the problem is that my internal process has leaked a bit, when
> it is really intended to be a temporary convenience (both for me and for
> NVIDIA contributors) and something drm-rust maintainers can completely
> ignore.

The only reason that it leaked is because there was an underlying unmet
need, to begin with, which is: how to continue developing on some
"appropriate" branch during two weeks (20% of the year) when our main
branch is locked down and stale?

There is a real need to do something.


thanks,
-- 
John Hubbard

