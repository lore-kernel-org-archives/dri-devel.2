Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8D1E88D7A
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 04:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF07C10E0B0;
	Sat,  4 Apr 2026 04:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iToimRMt";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B154310E0B0
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 04:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpiPSlxEXgqDsEycee7dE1+Ml7b7X7GDJDAzoKxXlAt5ks3bLoTkCb3QNjdNyItVxtVc0WPDs15hahS8VMNngPbA1kKo4oh8XzYVUTl/Gts7Y2RN4MQecD67UVweuF8pjOgdf0f8L8gYkFdtxGfpi6/b23dZyz2o9E1k/eimCtU9LNLKzQ52+XR50HdOuYL1zwOIb2jYe6ob8E+Dwriv28vcM2fOY1mkGVYtHu84caqeZSRtTlnJjx2Tb7Ab14fF6b/ZaKNlxpCoirLw2v52bdw8jAHTjRXfFNzqPRhTTsmuuuFW4f/WAAIECuwDpsIRd2yCtzTCeqo3Fqmbn1sauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwAKv2EbwgchIrTuv7RNZSsvA54ntyMBzQLaqdNbpxg=;
 b=Ykw8Ci8WU3Jf5j1zyFd8uOaVrYvL2vPpHNG0AVY0Bt9M++iblmzab65OOO2K0tcciDRAmIsv0D2OWxBgTqzIxVZS14LFP3V2ms2fl2HVr26b032C+jMLTYwq97aUfLIiWnp6+VngvAHun2X/UYCEaiMLRE9nIuVZ9DapJI3j57YfYTowlimc2XdWEMCF/+v617BQVJuRmL8o3lm3DuYGY5Cd8x+XbafE+2TN0ES+cPotZv/HR8/FTHwGPiIUo4dHcw+T749dqZaPx5SyeC508W/Sz/nB8HcjrrR25gq9lWr+JlCQO7fqaNIscDilwT9tYeDEps0R6ot88uhYnkj1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwAKv2EbwgchIrTuv7RNZSsvA54ntyMBzQLaqdNbpxg=;
 b=iToimRMtWyKertJPahhfkMF5UKm00V22B+IVcRAGWt1MkrpqeRooLC4IXkWLjxwY5Wjek8AhAeGMSunsld8sajXe5BXuQ60s473G+LeVC4tlHp3ujhP7ZQRUWsLhFTr6s1j/lWS8+DH7Y8k0ovXPwIpCoThEib3n9TDdStDc8h3qvsd6mrjoQC2ZljlFJNvs+Y7kSnxN8hcuO/VFVLdAsIpoeBoih4YIr4+KxdkJIi2NMLQAiZCRU9u2cJeI1PZa1azR8IBk9QDjP0iFORLVWCaYHwzFJ6PfmDJxqxXxaywCKPFwgqaPu0k2lN4B7OI9IL8DGIWFWc8ZOBVaNfiaFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Sat, 4 Apr
 2026 04:37:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Sat, 4 Apr 2026
 04:37:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 13:37:27 +0900
Message-Id: <DHK3C0Q5NX6J.UGQ9SCBYSCRJ@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
References: <20260401-cmdq-ub-fix-v4-0-a9a9cf982485@nvidia.com>
 <20260401-cmdq-ub-fix-v4-2-a9a9cf982485@nvidia.com>
 <11466450-aeb3-48d3-a86f-934346fd4172@nvidia.com>
 <DHJXK4PAD7V0.3UYK35FDHRNIK@kernel.org>
In-Reply-To: <DHJXK4PAD7V0.3UYK35FDHRNIK@kernel.org>
X-ClientProxiedBy: TYCP286CA0347.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ce609e-992b-49fa-8bdb-08de9203e254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IcsdF9X3ErytKPtnt7w/Xfhjc3ub87u/KftPycKh+p/iH8ZM5r0XBB7tjylvpYZxp4PTbsrbjrsWWxPX0tCWSlGPfGMwgMXvh5K6wtLRLe1muGDv4NKuZtVAgeAGctxYJHPuexnf682UmEiVhIOE2+yT9haXa9o2RAzO9DIUOQi8MKqvc5nuWvPx1Cqft2Qqhqr9CX/Vpf8Eq7C5BNJRIIg2kIyaz6xottduf29GgrBHKTsdV06MRCK0WqMbmbzWOaBY4Wxx3fEA63qxKPVMXkMQkqvNFSC9tT8kP3FkZqg2Tk7IbEHcZRcA/IfXmStBsylmBt7vUX8AzotmG2K+k5y4bxMnXqansNBgZaT1nyp/SZUQ0yv4wrUuUCHecViNVe+j8CfQnb0Hg6cxQShxKtEnxdejb56JzUvN5OuozoiAvoEGI+F+IYUpp1iFyiGPa7CIAMgBz7Q5i5m8w3RKGJud4dXsoZllpAK1DUJlp4hHmaBsTrk9BFtCX5GcfAI0sIsxfeYxF2fleWIkV81HwaopLhs0dCd60KjKdSHmPjMu/9LWVVxOcRI/YMVnrPrzq0d3md4gFc5Jx3btQrScgejf5/NFi2zYijCCfvalBz4ymID5elUumZ5uJaQiAHXD68YapmlNIeGaEkuRyJ1hauuXgS96mwtbRuR64VpMFxeVl+s1liAzxIihdmKjS11n0ZDIH35e8lIdJNMhlklku2WytC2oXRsikceijCdd3zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGMzOHlZNGdYb0lGaFg0TXFMVzRycmF2cS80a3BlUytlS3RlSmNYNVpzYndO?=
 =?utf-8?B?T1lVWHc2bFRaTjJkeXBYOGxsYmxjR0h3M05VcDV4L3FxajgxSGxIOVg1MmJK?=
 =?utf-8?B?VTM4eW9Xbm1ORi9QL3lVL2ZBeWtzMUFVNWV1di9iUFZteUM3NzRBNFBhTVBB?=
 =?utf-8?B?RHZPQ1N6b053TTJISXhmNjZnZnpWaVdBWWpCUzFrUFFlcEZmU2FVRzNnTTNG?=
 =?utf-8?B?blAydm91M0NDZHhpbmJzZjFQUEcxa2N5M25GNnVrYW5nbmVaZXFFWnhYQ0tN?=
 =?utf-8?B?cVoxNGlKSlpCbHUvUldvL2RMRkM4Z3NPRGxUbk02cjdvNTE5cU4zR09vb1g2?=
 =?utf-8?B?RnM5dnRUZDl3SnJ2Y2h3R3Z0aVc4eVRiZGJwRG1UQm1MUGZ0SlAwUkpKU0xy?=
 =?utf-8?B?QnY2WWFDUzBUa1lmTUs1WWY3Z2tOaHJOU3lkSXl5STNWdkRHbFlLbUNUTkZW?=
 =?utf-8?B?TVFodWVadzRxWnRnTXVzVmpkc3poc3ZqYVJ4K0pzcThkYmozV0JDZVlnYVhN?=
 =?utf-8?B?TEVBajdSQlFtM2h6QmdabHRibmtaVGRrSzVycGNjTzBQVHdnOW5kZGpKTWE3?=
 =?utf-8?B?S0d5QXEvRzJJTHY3czMrUXFyY2NJQTdPejlEMTBQUC9kVTNHWVV4Ui84Q2Yr?=
 =?utf-8?B?dWs4YUkxaE8rVTNudWR5bHhzaVBzZEZrdDE2bE5hcXFDQWw2aDFLdU9XQU1G?=
 =?utf-8?B?c1o0OUhkN0lVWWQvZVJwTkt3SzZoOVYwcW81YlZiUFRYb01tM25MNUVpdzVO?=
 =?utf-8?B?cUtkNG1TMytQWkxFakdoK3dqRlZhYnI2N2pGb1BnVkxkcURubXJBTGFPQ04x?=
 =?utf-8?B?QkZhc0dmWFBFcFdKczE1OEZ3dTd5dzJhNUltRDQwOWxMWFpWeEp6SzNTQ0hq?=
 =?utf-8?B?YlF2Wjd4MGxNUkJJMDY1S3doZXQ4cnRQNzJjL1ozVVhuU0pHTjBNby9wTEo5?=
 =?utf-8?B?TDhVeTNPVmp0elp0cFVENDRsWTd5enAwaU5zNm5xZlZ4SnlkUHFoN2N4SGYv?=
 =?utf-8?B?V0JMcmtOOHNncjNkRDNNS01HZHFlUGF1UnNBWlo4ektmbU5IUEpGWWF5OHVQ?=
 =?utf-8?B?blBnWTBYeURuanRYem5PU1VoY05lWVlzSG1QdzBVUWFxWTNKeG9raUYrWE4y?=
 =?utf-8?B?SEhkanhXbTNCeDcwTnZhOEhkcHQ1U1FnRW9mYm55a0JzU09qcnFWSlNxRHdw?=
 =?utf-8?B?Vy9IbUw4MjJJbkk1a0dZUThCVkNLb2ttalVhVWQzdjZYWGgzU0xPWXY4K0k4?=
 =?utf-8?B?VHczTUFWaXVHa1hsdkx3a09XNjE5dmYyaEUrVmRHNFJJVDN4aUJPWmE4R1Jz?=
 =?utf-8?B?cXVocjNXSTdGTXFYUTVEYmNhTS80TThnTjJKL3lTc3BXQzB1Z2VPT29ScFNK?=
 =?utf-8?B?UGptNExNSDhlTnp5MmhXZEJoQ0gwTUlQSFl3c0kwdFRpSm1VdlZNNmFNSlNt?=
 =?utf-8?B?c2xjaStkUld6emdKMEZ3Y0RZWFMxLzZOQjMwTGZjTytHUmpJbDlSZmJQUkpO?=
 =?utf-8?B?T1U3ZXltZzc0cytaMEFsMVA5cy9uWGw4azNmYWVDTVd0RjJTQUE0K3V2Zmx3?=
 =?utf-8?B?QW5EbW5ScU5BWFFGRHB0OU5CcElEdHVzRDB4K3BFTncwK2p1OVo1MGhSUlRl?=
 =?utf-8?B?TmJsSCt5Nm5xQ0p4YU8wTy9IOVFZUzBMakdZV0pFQmxCaVFEYWpnNm9wN0t3?=
 =?utf-8?B?WEFCbzZkd0ZDd0w2S2FHK1VYTTYyL3NjTVlQc21acHFCMXhaQ0tsUVFyK0tN?=
 =?utf-8?B?ajdndWw4dHRVNWhJTmpNRTlmL2wvUFhzbDdoWDhsQjNONWRuNGhQWkRJYUxJ?=
 =?utf-8?B?K0xsK2ViWFA5NGthaE8yNUpVbmkyWFpsSDRDWTJ4VHlKakg2THl6RGZ4cmpi?=
 =?utf-8?B?Wm9BRXd4WUtpZEY5eEJWUUxnTW5XVldUV1dFVlM1ckh0MkZIb3NnS05rMnpW?=
 =?utf-8?B?T00yeGtvMjlIMFlkTnVzM3V4aFhidFp4QzFhcDZQUURTczBSUXNoOFpocjM2?=
 =?utf-8?B?b3BVWnR2SEpIRXlXZEhPQUtmUnduNTZPL1IyczJzcmo2K2lnUjhzYm1wNGVE?=
 =?utf-8?B?R3VHYW9IM3l5OTFTNDV4Y0wrRWs4WVNDbHcyYWovYW9vYXZ0a3R6ckJGb3Fs?=
 =?utf-8?B?UHdTNXJ1TnJNZ0wvMXNEY1JLZTJ0Mjl4dXg2dVNHd2ZSZnd6cjAwWFN6L2ZB?=
 =?utf-8?B?ZEFwMWEwemJNWWt6amcxL25paTNSOWVjcUF0UHgveUF4enFHdTZ1alVYeENB?=
 =?utf-8?B?ZlJPTEx2WlVPRldSVDJvd2JkL1hWQ2NQRXVQVXYwd0ViYVFQMk5iUCs5ZWdj?=
 =?utf-8?B?V0djcUoyT3I1c2FvN3lnOWVHSE8wK3JlU0ZUem52OC85eEFjUFZoYmt6VTBB?=
 =?utf-8?Q?2HqKeAqwcwSmRSabnCVFkofoybBW68qXFQOWSmowWj274?=
X-MS-Exchange-AntiSpam-MessageData-1: zx2wihcWJZ8wUQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ce609e-992b-49fa-8bdb-08de9203e254
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 04:37:31.8074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29BANat1fLhdR0CH0f6cjV3FX0GdSpVJOci04iECXIVJf/StUcu49ejuN20Kzps411u20XvHtckEcKhplrbnYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177
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

On Sat Apr 4, 2026 at 9:05 AM JST, Danilo Krummrich wrote:
> On Sat Apr 4, 2026 at 1:47 AM CEST, John Hubbard wrote:
>> On 4/1/26 7:29 AM, Alexandre Courbot wrote:
>>> `driver_read_area` and `driver_write_area` are internal methods that
>>> return slices containing the area of the command queue buffer that the
>>> driver has exclusive read or write access, respectively.
>>>=20
>>> While their returned value is correct and safe to use, internally they
>>> temporarily create a reference to the whole command-buffer slice,
>>> including GSP-owned regions. These regions can change without notice,
>>> and thus creating a slice to them, even if never accessed, is undefined
>>> behavior.
>>>=20
>>> Fix this by rewriting these methods to use pointer projections in order
>>> to create slices to valid regions only. It should eventually be replace=
d
>>> by `IoView` and `IoSlice` once they land.
>>>=20
>>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindin=
gs and handling")
>>> Reported-by: Danilo Krummrich <dakr@kernel.org>
>>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.o=
rg/
>>> Reviewed-by: Gary Guo <gary@garyguo.net>
>>> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/gsp/cmdq.rs | 114 ++++++++++++++++++++++--------=
--------
>>>  1 file changed, 65 insertions(+), 49 deletions(-)
>>
>> This is causing a build_assert failure in the latest drm-rust-next, with
>> rustc 1.85.0, and also with 1.78.0.
>>
>> rustc 1.93.0 does not show the problem.
>
> Odd, it did pass all the testing at my end. Anyways, it only proves once =
again
> that this is pretty fragile.

Same here, although I did not test with all the supported rustc versions
(but pretty sure I did test 1.78). This seems to be heavily
configuration dependent.

Gary, do you know of a way to restrict the `project_pointer` macro to
only take constant values as indices? That problem is pretty sneaky and
likely to happen again, so we should probably harden that part a bit.
