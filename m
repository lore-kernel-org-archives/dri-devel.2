Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D322FD8779
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 00:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231F510E307;
	Wed, 18 Mar 2026 00:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="X09encvG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1AB10E074;
 Wed, 18 Mar 2026 00:56:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8UAstx+oy8+PGDs3TG0GTOmaxYnlPY3QWb989VVOvpeUd15eg5Ter7MME1MCsJ96qiAF7xV64Ktd0PPCBl+WnliPDH8WM+M28gQNdRviRYjg6dpEI7fRZmF+9+itS/P/Z/WV4KTDX+k4YKVQrRViJrtjJg7IpPTy/5d9YqAx/3oBDXaWn2WoLjCjVzhuUUKnVc76ILvD+2TafdN7oELgYSPsYEVQqh2lH0l29e2KLud34pyzcdTIAZiQy+VmBA3YL+YIbvX6JLETA+x3rsxs3x0PHeLs7SO9Z2DNX+XyLv/AgqxQn1Xfug52X/uN7nUkGXidve/gO4nHiHfOPQLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbAzbxpo71YCKoW8r6nyTZewz7/2oNkUZ36o8uU+gjg=;
 b=qZQf789NMPtcPOI+t+34Y/0jL4UZ04agdEKffAkqOTRYCGAQUgH/jr6AKsMEdCWAAoZKvUqldUhbIvhr+1IKANqwySZ7fudKF7Ya5vKuOwzegMuFNn8s/qU2hjUqwubJG2ZobXq//VKxS1SKUH4mp2zfAxTHgxQRaGfVzczH93vi0yOPp+u6qKioheQO7RRXpEfjMkqxpBtNfLWv2vOZfzSrgsFGtW7EDIucvaoeGkn3tZ6ahPAbIuqGOac8qvUNrzy+n6cI3MuKoQUQhe9EK0lHtySfGkR9RFNf1aaoS/czUoNHUHN15kZiwQQkV/YLGStIr2e2385yAqWN1fKuvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbAzbxpo71YCKoW8r6nyTZewz7/2oNkUZ36o8uU+gjg=;
 b=X09encvGzGAjxrP2gs4u8kK9tkOrvEgGv7QLwUSerd7iFEJf9+qUWwpKJ/aVR4Xp+mnHyCB4zRLlyfOiG6O6YuHLIWv1fIt9H093mrd0I8pgzFc4twIoHsQrVkuhYCXi6KRfaZDSU8RMO39oMms/r4Vq8UhD5gblp0vTOsP+RIo2sFbWHMLeczNI4MeyE6dAW3GEjxIMatwBhWW6iE5ALV0jEX+37xUwbpWkEzPAGY8GyKwjXJMNVr+87nRsF1fF9MaBKxZoFVRGxLGmASMTxsuLbpUQAji7wcNPCAmhnf2Vo/QJfu8AM06vMpL2AK5M0IZQmSr7y4L5aFPFAw5ZVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 00:56:36 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 00:56:36 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 09:56:32 +0900
Message-Id: <DH5HZM2YNL83.3C1BPIJQMIU7A@nvidia.com>
Cc: "Cheng-Yang Chou" <yphbchou0911@gmail.com>, <aliceryhl@google.com>,
 <chia7712@gmail.com>, <dri-devel@lists.freedesktop.org>,
 <gary@garyguo.net>, <jserv@ccns.ncku.edu.tw>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <simona@ffwll.ch>
Subject: Re: [PATCH v3 2/2] gpu: nova-drm: rename nova to nova-drm
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <e7539fd5-9a0d-4a06-aa02-ec3dcd235926@nvidia.com>
 <20260317092304.424377-1-yphbchou0911@gmail.com>
 <DH536IWQDX23.22R0P6FT091LH@nvidia.com>
 <DH53WAJHTQFS.ZSO15BGJLQ8M@kernel.org>
 <DH55S9CU9YCB.2Y3G50LUGSAZF@nvidia.com>
 <DH560ZMNK76A.1YFRKZ6FDU4I2@kernel.org>
In-Reply-To: <DH560ZMNK76A.1YFRKZ6FDU4I2@kernel.org>
X-ClientProxiedBy: TY4PR01CA0016.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bbdc7d-c632-4777-d462-08de8489345d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: QnXGLSus8P1BXI0daeq5wEhuLrO7UUCc8NXUvqGo34X/t/ywrkusfE/ruAx1cEtvan6crrRF/3ZjYk+hI7v79ABh3D14pSXnfm1V5a+VOYoXn3AhRMA9zvwpe166E3E/Xhalqu3rOJ8E0UkWFCA3vT0Vdk3PlJClbVKzJ68Ul/QVpT3qQ87jmEFabS6iZAAAQRI31P8I1hbN7NcgTJgx8qRFrWVPrmZTvSLzuuUwT8yzBbtlzT0yyxaEZTGyenC52eXpg3l79w0nMULpdu+XYeFrhRe2wQ2DIIJTgacWAai0HlDu5aKjbEA37ZgcbCA9afqBpt7okK8rNoK5I3BD0fWws2nLt4xsO+QIUnf0zO6kVUSPBWSpkDh7WqswBRVsAil3ddTPuLNGVB9IfYpkaOpLVoUG8HuXyoPoM19gI3e9+YJAqrw5picLtEWz8ML4hcJ/yrHSRlpYDZekdKKw7C+iHOPXIWVIGm4TJLfCN9bkWtQ/jyfenOJ9zKr9hA6KdzB9eflih3GfvEa1eEnqzT7tjVAivs22sdKhAeYffRHV3mdU9ql6dv6DqYPYfRHol43uEAYv868trSBkvDVb+XbzGICCvydK6tCHx9kXbwLj7yrYLUfEztpsSSfLdTMuBOSPI0pbyrfFSvRHd1dizlDg2k9jM3s9aEeiuZprYIUvCcIl+CErfiY3GE0yoMEBvWKObHFlztroUBvC52xRviwJdjN+7w1AMIZpp+W72UM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlNCSmVoWHpxUXNCeVhKZGZtSVlCdlV0SG51eGdsTWlwMDdyb2I3OVdoQlBh?=
 =?utf-8?B?OXl1cTNka3A0SUtERkZIYllYeXFjb2dOdHpXQnpSNy93dXkwM1JQYnl1bWpo?=
 =?utf-8?B?TVpGRVYyRStXTXB5dTgvdWlRZ3E1SXFEczY1V0lhcWh3Ym9iVTBjc3UxUFVB?=
 =?utf-8?B?WU02YjgzVU53RG1DWnMwUmliaC9OQXRoS284dTg5di8rS3dlZ3dwVkxOZWZF?=
 =?utf-8?B?S2lsRzFVcVNORVE3aXVpckFoZFJEWU1jU21oOWtJSFV0SHZRaTZEOHhGMEVz?=
 =?utf-8?B?Q0NQTGpzbUNFMGNMeS80UzJNZjU5a0U4MjlEUzhWcWN0TnJRWE5TSDN0bVFC?=
 =?utf-8?B?RmljNUxvMERWdVRHczZvTU1ObTJiT29Ic25tQk9SMGN3T1ZhUGhBV3l0RzNM?=
 =?utf-8?B?SGtZMnZDZnFXbkFWL3RtL1RhMXhDZEdRM3BXVUZzNmNhekhrUlJUejVhQjgv?=
 =?utf-8?B?cTJFZExzNEd0azkwbHdsM3RuL0wvZmNDajlGcW5nbjlGeUh3UUp3NG90c0Q5?=
 =?utf-8?B?czVicE1ld0QwNzlvMWsyNFhsR1hDMmV5NmM1VG1IZCs3aXFBOGw5MFBBTERr?=
 =?utf-8?B?OXdFY2lZKzFHdTBhZ1JLc3o2RGhac0lyR0tEQnZhRUsrZHlqMWk0WHVJYzZt?=
 =?utf-8?B?T1JPTTZBZm14dlFmelNpTk5CVzhZeEFYaXRPL0FKTFhVYTVhZVk2dUtRc0hG?=
 =?utf-8?B?TjBrZ3YrU01WdlgwM1gwVmxDNmN2L3hKc0hkak11Ny9EVWdGenBUTCt3MTNp?=
 =?utf-8?B?SHZ1SWQvTWR0djJ2aU9xbU5QYm0zNFNCK2srekE3cWNXVGk0dkd0OVFiZm9F?=
 =?utf-8?B?ck1EUkczKzdZaUM4azg3a3FIZVptT3dvM3NUUFQwdHB3U0tVcDNxeGtaR2d1?=
 =?utf-8?B?NnFuYVdMRmFqckJ1ZFloZ243K3BsOVRxUnVlaG8yWVJselAyUk9CVzUvSHVL?=
 =?utf-8?B?Z3NWcVlXR0tNeC84ZmU0Qlo5WHRhRU9JMExxNjBvN3Qwa0tzY0MwSHozMDla?=
 =?utf-8?B?bHZXdWFaTHZkeERSODYrTTkwVGtHSlF4QndTcHk2UlFRRFc4WFNVM2RUTzB3?=
 =?utf-8?B?VGZ2bEczUnUzQllhZDhVN0lRbDBJaGZrMGZvamV0clh2eUNTOWYzcm9Td3NJ?=
 =?utf-8?B?ZEJVVWs4K1ByUnQzaTRhVHpxQjBQb0orcThNeC9mN1EwTUxTMEdkc3BHenA0?=
 =?utf-8?B?NU80N1J1OXlXM3Q1YmlBeVRHM1R4UkRkZFdCWWM2Rk8rbDlsSnNZVXJzMjlC?=
 =?utf-8?B?WjI4djA4VjRZRHExbWVNeFM1QmNld2lqNHpDY3UwbXVJbEFEL0tWN0RnWkox?=
 =?utf-8?B?U0RwNUx0TkN1cTlyU1kyKy9MR2d4cGN0eEErM1U3QVNGT05rcXh2YjgzS3VI?=
 =?utf-8?B?Z241bVpMZmpsUmlZbXk2bzhCTzdLRFpTZ2NaNTYwKzM4OXZQbFNyS2NBdDVj?=
 =?utf-8?B?cVExUVFLSXFFTlU2RmExWmZuMzcyRUpSZU9LTjV0cW41NXdiTno5c1NvSlBP?=
 =?utf-8?B?eUM2YWVpYnN0a0NEREp5djZ2ZkVhOVRWYjRTMHJiQWRiQytDWGNkVm80VFJS?=
 =?utf-8?B?S0JOWjZ4VTlBbmEraFVHRnl0VkRaWVNjaDVUeEFweGtvaDFSR2RDVDB2M2Rv?=
 =?utf-8?B?VExoejFFR0E3Rmd1MUlxaEs1TTMzQmhCNmJ0eDhTUU4xQXZLRFZqZmlsTVF0?=
 =?utf-8?B?VlFEZEZ5SWVNb2xpbHpvd29FK1E3d0dtTE80Rmg4cGpYSVFlRllhWDVwR0J5?=
 =?utf-8?B?bU1UZ1lnZWJMWWVjZFVTM1F4bDM5cUJIVjJmbEpXUGlvVk1GL3l0bTFRMWxj?=
 =?utf-8?B?K01tT0kxaFQzZmpjWmtrd1VOZHR1RTVGOW9TSmNXVzJMR2hieUhvOWNOSktE?=
 =?utf-8?B?TnhuUThwQTI5bXNjY0lvZDJOeUFZNFBsRVpnUWUzcFVKZlMwK0FXQVlkRzNq?=
 =?utf-8?B?UU9Jdkh6bGxaa1VyVTBlN1VhUUVCd1FFRWtWVnRjeUJKc2VXWEJMakIwZno0?=
 =?utf-8?B?Y2Judmp5elZ2WS9VZ2UrbjgvQzBHQm8xNWNEcnUxYnk0andycGg5MGttOVc1?=
 =?utf-8?B?cVBPMERYRGJVS0k1Yklmc1JtZXY0VGQxcFZDdTlXcVVDQUpYK25YR2R1Mk1q?=
 =?utf-8?B?Sy9kNXJRMjhGaUJWS0h0eU5wNXlDaTVLSGEzWnRSSzN6RnZYbndQbld3WXF2?=
 =?utf-8?B?YXhTRWVZQlJoSWNubG9sVG5ac2F5T1hUWXBYeDZGVzFSTnVsQ0hXNERoL1ZT?=
 =?utf-8?B?ZXp3L2t6NmFGS0tsbnZ1OE1hWXZSNmlBQU54N1ZjOXZudVBmdjFjUnduL0ND?=
 =?utf-8?B?Q3lkb3oxY2owRi9FQWdONWw2K1JySFpQck1ucThqUkdUbERNSmdIT3NSekFs?=
 =?utf-8?Q?TLhrwWR9mMdZZg9K5UGP2u9hYcpBQbaW6PPFn+WKdGD+6?=
X-MS-Exchange-AntiSpam-MessageData-1: hK8mZ7ZVfm+kbg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bbdc7d-c632-4777-d462-08de8489345d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 00:56:35.9093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3HExNenAy9ktIwZ8iKqPlLm/iiVDyGY9dIB+WeX5K9lBmZygUkjef1NobhISXqnYNT3VRA4DMrR1e0pVHQGJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
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

On Wed Mar 18, 2026 at 12:34 AM JST, Danilo Krummrich wrote:
> On Tue Mar 17, 2026 at 4:22 PM CET, Alexandre Courbot wrote:
>> On Tue Mar 17, 2026 at 10:53 PM JST, Danilo Krummrich wrote:
>>> On Tue Mar 17, 2026 at 2:20 PM CET, Alexandre Courbot wrote:
>>>> On Tue Mar 17, 2026 at 6:23 PM JST, Cheng-Yang Chou wrote:
>>>>> Rename the nova-drm driver directory from drivers/gpu/drm/nova/ to
>>>>> drivers/gpu/drm/nova-drm/ and the top-level source file from nova.rs
>>>>> to nova_drm.rs (matching the object name nova_drm.o) to follow the
>>>>> kebab-case naming convention already used by the auxiliary device nam=
e.
>>>>>
>>>>> Update MAINTAINERS, Kconfig, and Makefile references accordingly.
>>>>> Update the Kconfig help text to reflect the new module name nova-drm.
>>>>>
>>>>> Link: https://github.com/Rust-for-Linux/linux/issues/1228
>>>>> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
>>>>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>>>>> ---
>>>>> Changes in v3:
>>>>> - Rename subject line (John Hubbard)
>>>>>
>>>>>  MAINTAINERS                                            | 6 +++---
>>>>>  drivers/gpu/drm/Kconfig                                | 2 +-
>>>>>  drivers/gpu/drm/Makefile                               | 2 +-
>>>>>  drivers/gpu/drm/{nova =3D> nova-drm}/Kconfig             | 2 +-
>>>>>  drivers/gpu/drm/nova-drm/Makefile                      | 3 +++
>>>>>  drivers/gpu/drm/{nova =3D> nova-drm}/driver.rs           | 0
>>>>>  drivers/gpu/drm/{nova =3D> nova-drm}/file.rs             | 0
>>>>>  drivers/gpu/drm/{nova =3D> nova-drm}/gem.rs              | 0
>>>>
>>>> That `drm/nova-drm` reads a bit awkwardly to me and feels unnecessary.
>>>> Even `tegra-drm` is in `drm/tegra`.
>>>
>>> Well, that's why I named it "nova" in the first place, but I don't want
>>> KBUILD_MODNAME to diverge from the directory name and I also don't want=
 the
>>> driver name to diverge from KBUILD_MODNAME.
>>
>> What is the rationale for that? I like consistency too, but also think
>> it is not particularly difficult to figure out that "nova-drm" resides
>> in "drm/nova".
>
> It is consistency. But why are we discussing this, what is the concern be=
ing
> consistent here?

I just find the repetition of "drm" unnecessary. That's not a big deal
though and I can definitely live with it.
