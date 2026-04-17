Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47897F8E4A1
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5E510E283;
	Fri, 17 Apr 2026 03:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HXtdhiao";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CCCB10E283
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 03:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGE4c1WEXlQ3OqZoiP0bYq40klcpGZFSP5IPF5jTh21ZBb4mA7ZZacYljI6Px2rZxn8ukvFC+6D4cEvEJuTEtIwnwihxg5aeR7Wl6TybASpknPeX16UPRBG3WG2emtuuPzuNjUtTtrOrnFVaQ+s/bNTRyt8rB7h0CF6KZy3YszSpkHKeBdfL6wmGGt+ZKiOc224f+nSmEmTuu0bg9IWSk9AEL3eg+DgaLYWmEvGEIYkNauR08tVSI0C+tfD/x3IpqcOqm/bhq5gRawmliUNFQQeGGvLH9Jvl8d4rGsL/lm9NIiLkXsrR5IMQzcuAk7AuYDjsPz6OdZlktMA9fkJGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNgZTEwQzo/5lSWOxZ5WAhq3h/Wt4Y6x9ToCdA0ccsQ=;
 b=dU4WYFgcLtNTcaHoglbXt75CPPDr+wC/JERBmX1nEnvztQ4R8FShCZdR4xSWIeBFBZMA71Z4ymT+iJBnQL0OI9K/czsK3YumX06sMw98HbjQH1fp+Pvyq99q7xT7xDSJltR/dtl9LoArW6lzZhXrQ9rKuz2XsibLzuxHdR88YRhAwQfQJZ2EByqlvBqWV03l+IbgL45ny+HemT++hV144oveVtWQXkqFfGCySJTAqkmsrpNSh8gBiMIeqQUGt37FZ3uFCzaaoJo5wOMqczfAoX3aKpH58HdRBhau+IPLvKiCALYvwpSQX8jHIqwLkra1eZBk0fVppY4gg/GCWC3QSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNgZTEwQzo/5lSWOxZ5WAhq3h/Wt4Y6x9ToCdA0ccsQ=;
 b=HXtdhiaogsPZkrQ4sGssucYvQ5Y8PG1Xzg1Fde2qsAOpwMeipRlxWRrK17D3r1bhE06jQ1LpybtDeJj/uSUxGj5Lv1qDDrRX8aJwq0iVgg+civKqN/uCdbdwx6p9ZY2kyfr20qm0KsE+7TX2duxMCBYPmqUUYr20IoQMbUJqHg9XgvVNDUI6yMWuBOzDA2WGSF5cgUmL9K+IwYWSua+Uh/y0XVCD9ixNRIazVfkRggJ+AtHxqD6hCrEBq1gDosk+c4w5sjtIFLbxp/+74X1jjxUSVoCkiYIPWp6hoTQEU5695uTn7yHZgXKQKYtiATKGiYRl649QbgnN13jhhpb8hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:57:34 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 03:57:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 12:57:30 +0900
Message-Id: <DHV4MIBWUT0S.2S1QWXGU4LFK3@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
 <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
 <DHV1K1097C27.33XRWLMZM6QZA@nvidia.com>
 <DHV3N3R9NJU3.2HXR63MP02NPO@nvidia.com>
 <fc4b9204-b4c5-415f-8435-e7ae03418dcc@nvidia.com>
In-Reply-To: <fc4b9204-b4c5-415f-8435-e7ae03418dcc@nvidia.com>
X-ClientProxiedBy: TYCP286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: b4aa610a-dd88-4d0b-638f-08de9c3574d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xBiLzM7qNp2bcvf985Sn5WiUCGidTTYX2DYE0Sg5gMLXIxavCzhcdj8qci0IH5WpP1nYjDaeZvW8tgyOY9OhOqfTyQK4vvuLhom//WqpzxyArMgpWpvvEmMR93LNaucsQN26YlvU2Mz9CX+IAOcVVF/VBQwP1ksrRB6nTgBkUaHeOkKsNZQS0QXsGp9/wvVCec/GXGyE2PyOcI++2FQKSfuiJQ+YAa3QftraJ281aQM3uqS9BstgBnt2lNU7NKP7POvEA0NCmM75ZXQejxua1w+dNAVLNZMeBCM8yhtvfN03dRyt2YX1ubs0WwNlLvH0i7s/bxbjAjlGUa0OrSAwoAi0446GpiBOv5xzv6SxegRSvKy2CinEmwSGnzOVKTYyff/ohsQK9O+4o16/RkJxKMTpLo7KBHPVBtEyDaepm2HJAZiMHjBeDoyY/pg1yVGolI348BIrTlQPVARvoYcuo2zepjUjd63n3AnYp1yIIRpy0deqS3Y7iMgde63MRn76jEPhK7w9cNu9bGI/82B2Pb8g5RDC7KObjHwaqKi04ylzp4uhE60RlPnzowlPNfv6utJthZvhP/lSJKgEmc8XixM8xsmPeU8ZktP290ZTqhMBB7m0O66HRcPbSN1cRVZYhrF+jHFeje89gtsf0kRxTGe2S4cok2IErwXcbruaguP4hx0L+6YjlQAVxm2go6dXnUfgPtt/Vir37s7SHktSyr84Iwc4RtX7p7kj5RCNazA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FyMHBxMDZETEpWcVVXSXpneDRtZENUYmlvZWl0TitGUnhsb2lHVzFTTnEv?=
 =?utf-8?B?YytZZTRtaHpINGtzN3Fsd2FVT09rYlFSejVCVHBYeW9XVEJLdnViWHVvcTkr?=
 =?utf-8?B?MlBZOFRaMmx5UTgrclpXSGJQMUZKc0x0Qm80Z0t0UkRRU0h5MzQxNHFCUU5n?=
 =?utf-8?B?YzZSRWp6SXoyZlMxbXVqd1czZVJlYWhjU2pPTlRldURkK1lOWk1qdC9SNVhp?=
 =?utf-8?B?VWFTTVpkQ3pyeGFMMThCN0V4WmdLNXpTN2xHMG56L0hXR3Q2aVhzM1ZhL09l?=
 =?utf-8?B?VFNpZVU3S1RsOUl0K2k1ZGE5ak4rMFFoRFJzdlRpQlVVaWZmMkNpZ0tvLzJB?=
 =?utf-8?B?eXViUW5TNTZ5cXF3NkFiU2dEQzc5L1lGL2RuOE5URDhBUlQ0Mi94RU9PU2ZM?=
 =?utf-8?B?Rk1RMVVsckJrdCt4R1gzS0NJaW1pajh6TDNDeHNoU08yRWNzK1pZOC9Yc1RG?=
 =?utf-8?B?c1J4VzVZVk5HMFZVWlNpd0QzZkRXZGxWcFkvU1Y4aC92UENBb3owNXVteEVO?=
 =?utf-8?B?ZlQ4dVhsOVJwSEwvbnJLTUovSXQ2bEhpVzdWUWpmMXpFbjgxNTVSSmxIKzZp?=
 =?utf-8?B?Z0JDWGp1Qk1VUVI3SFVhTC9zNGhNVk1pN0tCeEFNdXkyVEgyRTlaWGRMNmM2?=
 =?utf-8?B?SFJ3QWkvRzBoNmQvdXQyc2k1R0N2S0htODRmYm1xc2dMVVJSc094V2J2OE00?=
 =?utf-8?B?Y29QaURpaC96aUVoRjRzUDZzOWJObk5DcW1ueE16b0FuazUrRDlhTWJmZVRW?=
 =?utf-8?B?ZTdoTThLaHdUdnQ2VkN3MTdPandqdzd5STVCWGV5YlhRZHgyc0dYZnE5S1M0?=
 =?utf-8?B?dExibTA5RklsR0tabThRSHVyWnpGTjN3cFBnNnYzS0szbDQ2QXNtTmNkdmxR?=
 =?utf-8?B?djBGNEZocjRzWncvNFIyZU5hclRXM0p2Z1ZRais0UkJjTjJNdUNaeEpnNUdn?=
 =?utf-8?B?a1FqZlMrNDBiemk1bUUyKzlMTDRrMWNDemFQenVaVHRZZHJFd3hGTnYrNnR5?=
 =?utf-8?B?UUZ5SGh4U0xLeTc4MmRSRUFRMlBXQWdQR0NpM3c2czhMSlRCS1lPNDJpUTBF?=
 =?utf-8?B?UWpDSExGVDM4TEZkeXdLS25DVGF3MXROWXRPRmpVVjNQSmsxakNWTnQwR0tT?=
 =?utf-8?B?ekwzekRwZ2JVd0dMekVTa21xV3lzQWpITWVQZE55NnRCelJPbnZZVThtampP?=
 =?utf-8?B?b3JHcjNGc1kyaU9ITTljRkROOHF4VkdaSHlqK1QyZDNnUmFKRCtIem90clQ4?=
 =?utf-8?B?UGNFL090SGNaM0MrclhwaXN1ZEJxUkV0elo2Y25JbDdENWY0bC9UcGpvcWlJ?=
 =?utf-8?B?eXFUK2xnZENqVTgwaXV1QW01VUJLL0s5UFRjazVLNWhtUU40bkY0QXRQSlZp?=
 =?utf-8?B?YUcwUkhGOE1Qek9FZU92SGxqSzk3SjZ4L0xtaktBaE9lMU1FbS9ZakJlRE5U?=
 =?utf-8?B?RG1qOXFoa0ZNdGdneFNWdHpmeDgySHRTdGMrNDBzMVBHdmFpay9ZemlTd2RI?=
 =?utf-8?B?MVp0RVVmb2tjUTZDZWk3YzJmbUFjejY2TzBpODhzcGF3dUtaYzQ5eGloTWRl?=
 =?utf-8?B?VkpCSlVjai9ndUptNUNWeWcyOVhuMHExbDFDdVcvVFEwbExsZG5BTkJTVDM5?=
 =?utf-8?B?QTd0TENJK0g0YU5FWDBZM0R5VVArd05LYnNJTEVaUjBBTjVGdVp5WHloZ3Z2?=
 =?utf-8?B?eDMzYXI4NHNyQjI3bFVoK29xaWczSU8vVUp4MGNTUTR2SUduTXpYN01NWWor?=
 =?utf-8?B?cmJvbXdrSVJXZVgzOTJMTVR2Yy9NU3BGc2dVOGRmdDVPZGpwazhJTVVzT0pM?=
 =?utf-8?B?UHF5bFFVbFNvQnhNTjFUczZsK3VoeGVzOFlmZ2d4TVdUdVBuUlFSZ0tZdVZp?=
 =?utf-8?B?Mnp0QThPODR0a3g3MnRDbGxjK0xaajFPeW9qaXRzaXZCWDR3WTBLR00vaHl1?=
 =?utf-8?B?QWdZME85T3UwdG11OVYvU25wZTJwbXJ1dXk5dzliRUlKNHJPNzBxTjFUZVRz?=
 =?utf-8?B?SHdVaG5URDJnc054RXFHN2VIanVkUElJRnA2OG9ubk5vNWhEQitOdHl4T3hM?=
 =?utf-8?B?WHRkUVZqOEIrRnQyR2Q2NzVwdEVYK3VLcWpESE5jem5QQ2dGZEVabDhtNjl2?=
 =?utf-8?B?SnV4dXJhdGVPbC82QXh5N1pWd21wV0ljMGVwcEZxc013SGpXNjV0OVMwaFhV?=
 =?utf-8?B?UWl4MWdvMEVtTVVuT08wejF3d2VWbU9sL1FtUVBEVzdoVG4rbllScytoQUhw?=
 =?utf-8?B?eGt4Nnp5WHRjZTlpMG5ocW85Sjc5T1lVU2VFMFpSRTM2WEpjOWorQjJMdGZ3?=
 =?utf-8?B?dk5VMTZRY3VnY0daSVd4ME91cER5M0lLZW5MRUJJYjRQZ2ljZ0tmeWJ6V1hj?=
 =?utf-8?Q?HlIW2WRig8gPK33+5LDDr05uCrBWhez8QDZPdstcev3/U?=
X-MS-Exchange-AntiSpam-MessageData-1: 9SKD0FIlEj9YSA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4aa610a-dd88-4d0b-638f-08de9c3574d5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 03:57:34.1983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+7rcfCB6yYBELXIJ7+UTC6AEy2534w+26v/pzxKxnWOLyUNSXdLRxiZqL8DgtoVW28v2wjuvFqlaAHknBO5Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
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

On Fri Apr 17, 2026 at 12:19 PM JST, John Hubbard wrote:
> On 4/16/26 8:11 PM, Alexandre Courbot wrote:
>> On Fri Apr 17, 2026 at 10:33 AM JST, Alexandre Courbot wrote:
>>> On Fri Apr 17, 2026 at 7:18 AM JST, Danilo Krummrich wrote:
>>>> On Thu Apr 16, 2026 at 1:22 AM CEST, John Hubbard wrote:
>>>>> Can we please put this into your drm-rust-next-staging ASAP? I don't
>>>>> think we have any comments that would really need to hold that up.
> ...
>>>> But now it seems to develop into some semi-official "shadow infrastruc=
ture" for
>>>> when the drm-rust tree is closed after -rc6 and during the merge windo=
w, and
>>>> it's not part of the official drm-rust workflow and other maintainers =
don't have
>>>> oversight of it.
>>>>
>>>> So, in order to not motivate workarounds, starting from the next cycle=
, the
>>>> drm-rust-next branch will be open for new features at all times.
>>>>
>>>> Consequently, all patches applied to drm-rust-next after -rc6 do not t=
arget the
>>>> upcoming merge window, but the next one.
>>>
>>> If that doesn't add any burden to you and Alice, then I think that's a
>>> definitely an improvement to our process.
>>=20
>> Actually thinking more about this, this might not be the improvement I
>> expected at first.
>>=20
>> Take for instance the current time of the merge window: both `rust-next`
>> and `drm-rust-next` have been merged into `master`, which provides us an
>> ideal base for sending patches that will target `-rc1`.
>>=20
>> But if we keep submitting to the pre-merge `drm-rust-next`, then we are
>> in a situation where the extra patches sent to `drm-rust-next` need to
>> be rebased when `-rc1` is released, with a clear potential for
>> conflicts.
>
> Yes, some conflicts, but probably not too bad, due to the much
> newer base, right?

Most of the time, hopefully. But that's still labor shifted from us (as
I would address the conflicts before merging the patches) to the
drm-rust maintainers.

>
>>=20
>> So at the end of the day, it would still be cleaner to use `master` in
>> prevision of the `-rc1` tagging and we would be in more or less the same
>> situation as today. `drm-rust-next-staging` is currently based on
>> `master`.
>>=20
>> I guess the problem is that my internal process has leaked a bit, when
>> it is really intended to be a temporary convenience (both for me and for
>> NVIDIA contributors) and something drm-rust maintainers can completely
>> ignore.
>
> The only reason that it leaked is because there was an underlying unmet
> need, to begin with, which is: how to continue developing on some
> "appropriate" branch during two weeks (20% of the year) when our main
> branch is locked down and stale?

It's actually 4 weeks (from -rc6 to release, plus 2 weeks until -rc1).

I agree it would be nice to improve the situation - I'm just not sure
that keeping drm-rust-next open is the optimal solution here.
