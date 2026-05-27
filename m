Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7E5CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 14:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43BE010E09F;
	Wed, 27 May 2026 14:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LHW/N/lY";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E44710E07D;
 Wed, 27 May 2026 14:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENhbuQpW0YGkpyeNjZzJtfiB4R+Ca0C8xwbM6enuBd0x/8zzFT1ZbrOH5MajfLeZKfm+hRExpon+1F8/6P/1qx4u9z0T6xmrtZulsV1VSGUzqgybLKM7Hw/NQ6Y9/Vd8fQNXBWxM+TteuweU+Yw2/y/vIwyIcoSnVdV52q1M4BymLMuiecUd5Ga0TjOrE42Flm8sbPBe4HTGqJD5ZODP7bkGgPAnVA6oQlfcOHbkq8KGyCGSEDjQAG4W06CScNEaiT2/m2ticmFBsdY7a4b9dWiSZADYd151+WnFAf1RR69momrIABiLu5REwIoCzj5OVFjp+Ow3UGPKotX9SW2Naw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxuSX5diE/pJLWPm9cOnamM4FTNchLQxTyzxwUz+2LA=;
 b=b8CKPO7YGEu9Ai7x4Lk64LqiiksfA1Km5ceHirl3amsOjNcUfHhov4ry2lWkM5aBEMqUljDrMXF8MFVdH6yTSF30qnoTgYb6RU8Xo+r0BVOCjBY7NuD6Zh+6NiiosmxowyWG0fmnrzxA6rAlqaMhNBDs2GdSZAscc+m7CvFILKaFDDlh27ov6V67rf6C/kL2k74QoHm2pZ3xdmG3zTYuXQ1hpaRkMYa6EJ8R6XGf3IZEA/lvnRJygthkPmPTMaeD2/ncWvmUCpNjv3J9KSVATXcElfAIedY3dVYGd93TbTEhwq8mZYbdE+q2U/exgl2psmOC+BjECGGIUTHQVQM1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxuSX5diE/pJLWPm9cOnamM4FTNchLQxTyzxwUz+2LA=;
 b=LHW/N/lYNGuXvuwYyWAcUXu1rs7INohATdCLRrdgNEEV3pEN8LJlSgPfotzlIlHbu0EtC1kdY8Qz+8zWKNAK+CzmcoFdY8fTon8yiCe01nTH/2aPDVfeJY8ArcPXx57fgpBzGeweQj4jx2nJH+iEN83NVobDvKflvf3cI0vZNtH2abzH3mR99gPJgobpcpg81a6bMk3mNc2Xu7IofAqOUvf0nj5hkDJk050aF56D2sMSxjuFMrSJEliSp7RYFtF8NtNAUxIp0202fDQqlwWXNvzHC/11YsLRlLig+Ej+6kfz3nwqNWvLfBqs2ZA5Avv1BxHQOxaBMGzYEq+7e4Ejdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 14:02:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 14:02:09 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 23:02:05 +0900
Message-Id: <DITIJ7IIAK7L.2PKIBC52OS7AG@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v6 7/7] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
 <20260521-nova-unload-v6-7-65f581c812c9@nvidia.com>
 <DIP0EROV7VSK.1WYD6SKNI05UD@nvidia.com>
In-Reply-To: <DIP0EROV7VSK.1WYD6SKNI05UD@nvidia.com>
X-ClientProxiedBy: OS7PR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:604:254::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: 8351a5b7-9e3d-40f7-2de9-08debbf88b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|11063799006|6133799003|4143699003|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: J4eP6PUiRhRLHVQBGWRqGqc6SY2irWV0/JOpAkt6BYPXFQWPbHtCUtrGvWXS4+lpJAZx0lCUCyznGJj+jeg8MoGEDPy9PUJfkUswJ1ifGuyoGQOsMb/0c6TW01WUg6QwWYi9+mLtoAL5EysfXtmz4Gbwe3dgbV+6Ojsm8WpdIy4U+8i8QEf+egPtK2Cq0p+29+r1WYv84ekfK80/g/DuixHIrvPADQBIXFgNjn0xAobVzdNODl8GpWvljlrtSeYTkEJh4A6V9hkyFcAHG9SHN6J9s6FDbfv5y4k0sUI26jMXZ7bpNCItEixXfDPEih8j3HsoYCQfjJLzCnmERUesN4tAi9WEUndu3Io+tqxzTyfUAZvq+6bpRl4ub6pm211JjA2z6sfhdxdzLzNfzxwoQK+/dc5M890wRt5o+ZZ9KzSc8ey12I64cbhz41AEehYl5Ki/xdwW04UwjzfRCP+ecZDAfb2N7JQnkF8FTgdJxfjC5780QxAJJjsVXhKi58UhviQGBDLW/r1LocqDjRJqpPjxrprtXiMxMdf0vkVe/R5dV8hFNRscWI4Usi2NSqBjpkFA6HsQHXNli5JO+kEVqsY9irBIncSwaUTl8p5a4fuxhMF3CjqhJCmHWKdP61j82RnfJnr8rWtFsBjOw+cUAfEl/teUcRMbYEy2+0rH3KeAMZoMydOzCuWouq+dRJy1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(11063799006)(6133799003)(4143699003)(3023799007)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NC81SzdjNjF6YUFtVDhRMmt5eEx0M2FrTWdQVDkzR0o5YmdkNklwWThZR0lM?=
 =?utf-8?B?K3VrNE5qdy80K21jRHc5Umh0dkd2a1lYc1ZacWVoUDk4MzdZWjVqMVovYmdp?=
 =?utf-8?B?TVVTZkNxMnJNbjhvdHZkczdrZGZ3Z1NCeFZWUE1DSk16UXlLWHRGOE41bm1z?=
 =?utf-8?B?QUNPby9wTTZEWjRzdE91eFh1bnNucytsZWU1ZEFObXFmbjQxQ3JFVlpNT3BK?=
 =?utf-8?B?RXYzb0VqZ3B3T3VqWmJvdWI1RWwyRmRjN0NkMXdXWGlCUS9FQ3FSU040anpT?=
 =?utf-8?B?WTM5czU1b255OXJuTVZQQ1E5aEZXbms2NEwrK0hDbisvd29rdUZHa2xCa0Vl?=
 =?utf-8?B?dnhMNFZDekVKUU8zWUptaUFUbm1ZMHpoa0I4ZHNBa0w2SXB3MEZCQjBSN0lN?=
 =?utf-8?B?cUJIdGFUYnRkdTFUeXAxZmRySEVpUExvK1pqcGlNMXhJTktpMHBVTXVYMEhK?=
 =?utf-8?B?SjFKSlFyR1dxWHJKQ1kzdHhKcy9JcUZnYW9wdjhUUXViLzdLdC9LSUlPejRw?=
 =?utf-8?B?S0Y2T21aS1FGcjRhY3FiWFBpaDlGSW1BSlkzRXZnSFBqWWduVklmSHVCZlMz?=
 =?utf-8?B?b2VaYjE0WDl4UnFXVVpQNk9mWnlnaEc4RElVdUl0RUJ6VTRhdjlVV3hlOGV4?=
 =?utf-8?B?Mys0RWc5SncvWFBNVmZDbEtxU0doWXo2K3lzY0o5ZnE0OFo4aWs2dHJhREhn?=
 =?utf-8?B?dDc1SDlIbW9wK3hzZVo3YjcyYmNNVEwzVXJqeTkyZnh0a0liM2t2a25YeGtP?=
 =?utf-8?B?T2RrbHRrWUdhb3ViSWx6QmUwMEdhd1dvZnM4SUQ1dlNuekE3eTU4cEM5OFR2?=
 =?utf-8?B?YkszYUhFKzFVSGNORUxMU2UwVGVxWUlDTzNnRHRlSjhxZnlQVWZHNmFkY0xu?=
 =?utf-8?B?eTNuR2F0UEpCWTB0MWxxTTdoL3hzRlZWRWFhRnpXczA1WmJFQzc3MWViYk9V?=
 =?utf-8?B?cUh1QTllU3VkLzUwY3NTUmNSMTJzOFFUNGFjYTNmb1ZlUmxjM3RqVjYzSEw4?=
 =?utf-8?B?NEVpVEgyeFJLZldPSWFrb3c0WURnWStoRWszWEMrUTRFR0doS3VnUGRiRFV4?=
 =?utf-8?B?M1F0R2RRbTlXbzEwVXFwdDlNaFp2ZmcyVHlZeTFkRVRTRm0xRXBjQ2VDUzdY?=
 =?utf-8?B?UlRtZlVES2JJdG91WU1uRTFaV0taQXhRelF3WkhMQjhjSUNIcFo5SzJRZGk3?=
 =?utf-8?B?RlpobXpPNm9ZSGsvc25SV1pTQ1RBdGl6c0RBdDlrODE5bnNWRW1wV1BWQysw?=
 =?utf-8?B?emh1YkRVdElhUi9qYXR6SFM3NnpuWnhsb0ZXcGpFYzBlUUJJdlAxdWN2a3hX?=
 =?utf-8?B?Yi96QnMzeVlRQ3UvWXo3TWxDOVlxUnV6VlZ6Mks5amtYUTEwb29rT0tBWC9O?=
 =?utf-8?B?dXBDUndCdVozenZJb0NoWDZ0SXVLWjhIR0NqK1lsRGhUSE1YMk0rSDZ3eU5r?=
 =?utf-8?B?UVhYcWsreDgySzRpSVZSVDRtUWVaby9zWnhJOFIrWkYxUlhiTUhndGxpQjZ2?=
 =?utf-8?B?WVN0TnJtMkhDOXQwTThvV2NmdEZrbndmMzFoNytBQ1orM0ZMclRzaTYyN2JG?=
 =?utf-8?B?R3ZCc0hNUWpPYUxiZFI5TFltandubkhWMjlZckJ6WHBmOTRCUW82SzdhSnJa?=
 =?utf-8?B?OU1VZVVUVHJIL3NDQWZpNHlkOG81VWVjcVN2M1JpL1ExQjdtV3Q2c205dmRX?=
 =?utf-8?B?M2lZSEtDa0RCOXdCVjZqdWlOTDNxUVJ3VUY5N09ORzVDUVlZdlhsMzZYMEl1?=
 =?utf-8?B?TjZ0MFNkV1dLK3J4TTZBWitQT3FCOSt4N3lJU0dZQzlJTWcyeE5KVHY5elda?=
 =?utf-8?B?UjRDNmhpZkVrUmRLTVliY3l0NVJPam54VkFpWkFKZ0RlWGltOFRqc3pOZE1j?=
 =?utf-8?B?dXNQTGtlOHhOWnl2Smt6aHIwdWw5MlFIWDVmZTZTenozaUJNR0w2Y2dzQ3NW?=
 =?utf-8?B?RndHamEyYnZaWTl2Y0xIYUphSTR2ZmtjcXl0b0c1YlNxb2NzQXZFN0JOTGo5?=
 =?utf-8?B?b094M3NPNXZIeVZkTVJyMUpBMmVTUFlNWlJRa2NFY1JPTlNUcjRrYUhIYTc0?=
 =?utf-8?B?TWRLcXUvU09VQjgvSjFqMWlpVFRQZ1AwdGd5TFlXajZ4WmxSaGFKZWZYUTJD?=
 =?utf-8?B?VnEvM1E3R2NHeG5vYlFUbU9JdVBrSnc3bVpBMCt2bXdwMHZOMDN5SE50WWJU?=
 =?utf-8?B?dTdtQzlRMkhHeHJWNDJWeVV6YWJhckJCSkxIcFBrTzNJNWFVaENwbHE2eHI4?=
 =?utf-8?B?cVRSWW9LU3VaU3g1L3FicEJEZDRNU0VCOFFJSVJmU2xnTEliL2ZZTXZTZjIz?=
 =?utf-8?B?M2p1ZzBFbTc2VTl6WnJjWk5OTURobGdEMG9aUGJsbzlDb2EwZ3plUkZHWjNF?=
 =?utf-8?Q?cCZZW4D/NF9Bd5e05j2PlBNQ47dAqng4RXHlEo5F5ei9Q?=
X-MS-Exchange-AntiSpam-MessageData-1: S+iWCEB/WTzEkg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8351a5b7-9e3d-40f7-2de9-08debbf88b2c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 14:02:09.7681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+lc+sbZtjLpnVdFUgkm5RTKCidR8Tzea4Vuz1f7KYSvUJ0hDmTBpuAF5Vl6c00+ryvznx9j847GAzDi8JNzrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565
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

On Fri May 22, 2026 at 3:59 PM JST, Eliot Courtney wrote:
> On Thu May 21, 2026 at 10:50 PM JST, Alexandre Courbot wrote:
>> When probing the driver, the FWSEC-FRTS firmware creates a WPR2 secure
>> memory region to store the GSP firmware, and the Booter Loader loads and
>> starts that firmware into the GSP, making it run in RISC-V mode.
>>
>> These operations need to be reverted upon unloading, particularly the
>> WPR2 secure region creation, as its presence prevents the driver from
>> subsequently probing.
>>
>> Thus, prepare the Booter Unloader and FWSEC-SB firmwares when booting
>> the GSP, so they can be executed at unbind time to put the GPU into a
>> state where it can be probed again.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>
> After seeing the bundle moved outwards, I realised that it has the same
> issue that SysmemFlush does, i.e. if probe fails it does not reset the
> GSP. A lot of the time during development I will break things badly
> enough that probe fails, so it would be nice if this is supported. OTOH,
> this gets the probe suceed and unload case working which is important
> and this is a definite improvement, so for this version and the previous
> version of the patch:
>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>
> I also had a brief go at making this work on Drop, here is the diff on
> top of this series. I can send this as a follow up if you would like
> after cleaning it up, or lmk wdyt:

This is clearly better. It guarantees that the unload sequence is run
when the `Gpu` is dropped, while preserving its one-shot nature. Also,
no `Cell` and no awkward output parameter to `Gpu::new`.

The only blind spot remaining would be to also cover the case where a
failure occurs during `Gsp::boot`, but that's for `Gsp::boot` to handle
itself imho.

Would you be ok if I folded this into this patch for v7, with your
`Co-developed-by` and `Signed-off-by`? Then I'll also try to tackle the
`Gsp::boot` failure scenario using a drop wrapper or something similar.
