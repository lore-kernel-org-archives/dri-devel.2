Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC071FD5F7F
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 06:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0774410E525;
	Wed,  8 Apr 2026 06:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CrF2DNrf";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4FA010E0C5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 06:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iD89fxvCZyKIK+xirwXFnytleQyaF2yx/vMddaY/0j+eDbXypAMZnukpFXEGs6bGXxwxctiFVyurmin6Gf+/gfOUxz2XSuvKmoIx7BKpt9aMwBdxii2yGZA4AhJzrklNQb7L3Z3voPFQcJ/SvlDVvKyiTggXkVM5uPFQI/w5axLuNXTCLS9ZQbR9IG8QZOG1EEMBnWq8GDrb1ecZ4doXuLLbCU1ICrs9fwgXz7wnP7yYwol6CerNNOlE/FY7muh5W911bdi4SVoON7Q31/eienylSwS4mgGbUPsNGdm6HyiZRqneBmLSD8/+dDDxWnCP5xPlb9XX6Jpyqf2m5aoPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyiIPzn8L/nfuIxyAeHOzpdcpdrNd9KFtfVVQOqbwt8=;
 b=TKNTIbz08/IAA6jG8dokmja+E5wbLldBDit8nYsY5AQIQBAE+G/oONz97+ThV4AEb69L3J1QnNqt5xW5NRRsSfJa9CSe9wul3Ee/BpFQlmnyru2cJuc+rvwCGypSgJxGBJNyHgi4yAc63LEUQxOECErWnsuVL+BEHdMFT5sXIa93LcXIreJr/f11xQ2mlLtaZ0fwzYYtz0QhGYLFx8EKmtdX/Sdo62cQ0j4gD2nKzl/j74rG6WItiXhwGRdVHA6qCZHfcK5kvYrMPlXAR4Tu56EM/tRO1qNcZ8c/sB5ZkcRzAClHPPu0yVg7TSQci6d545XQr8GzN3IvZoNS3vTRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyiIPzn8L/nfuIxyAeHOzpdcpdrNd9KFtfVVQOqbwt8=;
 b=CrF2DNrfJXZHT+oFrPOvlBiclZj9IIWQBX0pBeRZO9k1L5qP+ilmefewx0BX2TLd3MkGoJFmf3/uVzqjQltuGbf8mjhSWZu+GoKkLesIyzcgtaVX5/OJZEAJaAxmD4MyAR7vDC4Xkv7DLPtnnrvDqjxzC8wrOkfNpiOXm0xtj+tRvPWdFiXoQy0K4v5t5f3gpkcJNB3bm/J1pJsQ7bBe3Db9Vvh54vZlvXRUlNxScUJu8sZQnYW4RcE3mzzfmnby8ypT7EgBxIdmlzpu1A5fzpyKvdUauJ+vu0CE3P3ygrn8S+znHpKnBcf5zX5+8n4EFQydVZMMudnhw9XDMDZX0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 06:47:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 06:47:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 15:47:51 +0900
Message-Id: <DHNKM16OK896.3I9B3CRMZGRL8@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova: require little endian
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
 <DHMZN9TEXQT5.3FIWZRAQKUO9T@kernel.org>
In-Reply-To: <DHMZN9TEXQT5.3FIWZRAQKUO9T@kernel.org>
X-ClientProxiedBy: TYWPR01CA0022.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: b801feb3-6dea-4c93-11f8-08de953ac31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: V3e7HxksrSFs9t0GmuUKee37pYrcefOlh/P4ysn7fNXW7HZMfqH8+pLszJ+w9AusKO9FB6qvabqWvpmQc36mIXJv4DYn3KY9xqKGi2SuyFaSu9RvRG7Wz+3AmYFftb9oJTVr4BjloHixTYWnlGSFayaoPCEfK+RrYvXusxwG2KAbNzDzNE6nfgKCceeKr+67DXeF94vMY+OtZ8o9VvXrFkTBdc3U2yxQPALRWrrRxy+i0Id/jeMLPJajf0AkiPb9IItNR35dROM+8ZmUUNPdUZKqRYiMuDRI4pc2JSCAx35+ohxTaaLb5+lP3RMKnx8afXh1L9k4VzGoOhdNfK4e8uKbIl1nzWQgZH6El0+AmDsvecHemseYtaI4JERQ9TL1s4/Y0jKp1ikgyhifFkj9PD2+q1Ve3ibPacO2naTyvEbxKzBVNR99k1wz0UjZO2C0IyXllHCN36uPGHOI9yJxvzFz5+VzJOKSE3A5LzyB15ZnbDOOLN9yuRd6lz254xVRs1VgXcgeMtEX4BIj5PzRpZZRg/XERQAHkGTNCWJl+wTqlHXNjHq2i6xpwBt8YOUoF7xCKAyc8wiVTHGG0SD0lF9JjhKap8xwNoanAkqwizGd+7l5ixBavX7TnC5xraFWfLvGfYjuKWtHOXATnMLB+8jehX9DY2KCCuWOFSL1IoF7qwzcq62lNHkXU8dRny3ykK4OACwjV38XE3cs42YMpswwRV9+N+xc20Ab0rmU4WU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnRLSEVzWld5c2RoSVZaTkV1bHN3OGRCZStnUWNBSDY2TEtNRVZicFVrTnBG?=
 =?utf-8?B?b3NRVzI3QUpjaHBBUkNGV2RsV2VCTkhaTzhqT0NzVWduRmlOOHZMNkZqOU5v?=
 =?utf-8?B?N2V6Z2x4czl1RXBYTTZwR3JadHMvdGI2VEg0TUZwMmRlMWJEVFZ6N0VEczRO?=
 =?utf-8?B?Z1VwRHFZNUw4TENraUduMjZhWkV4eDRqMlpQZDBTS253dWdwTjRrWXZlTzV0?=
 =?utf-8?B?OGNQSzBsTGhnRTVmZ2oxd1FLTTMrRnhmek91ZnJCd1ljaE1abUVQZENPMWov?=
 =?utf-8?B?U2FrT0Q2QnBOOXU5SWJCc3E4VW9oczBNelVmVDRoeDd1cys4RHpIc0RzM2Q3?=
 =?utf-8?B?T2xKTFBCZGlxSlJLYjdSVXhWVForbmpOTXk0UFo2UjdtbGxpdXppV2EzK2lr?=
 =?utf-8?B?MGpwYkY3VlQwaEZpMjBBTEd5OXVteDFwMWdpT2ZWQlZLYnlDNTZMUm9vUWpU?=
 =?utf-8?B?L3Q5TldVZWFXeThUMVgzTE5KNFM2LzZrdWNvMEFSV09kRmQvSjAzRkwxYURz?=
 =?utf-8?B?N21lb2tQTUNtMmVQbHRhSG50clQ5RjFJYkN6YzFYVWlzSGI0Y1dYd2JBNUZt?=
 =?utf-8?B?VHR5bHdBNUZUdFBiRS9qNWdyUzF2cTVvR2pvQlpBUUxjQW9yNDVoOVRYWTM2?=
 =?utf-8?B?Y1hGVVZhdG1TWHNPVlg2cHVmbTMxa0FZWXE3c3dGRHNpOEFSRVlKM05hektN?=
 =?utf-8?B?bVlsUkVLdlFLRlJNQ0FSR01IcFU4aXcwZ3NYRGhrSWtCUTlBbWtCbnFUcFpa?=
 =?utf-8?B?UFZPYmozeTFROGRaZGkzaTNYSHFmeGlkd290a2ZCUUpaaFRqcm5UNWdzUS9t?=
 =?utf-8?B?RDQwMHFTZTM0YUZQa0VGa1dBSUEzenljNWhBNG9vb20vTUNwSnBsNEtYblBM?=
 =?utf-8?B?Tml0dTRLU2J5M0dtMkpOTUlCeHpIdkp2YlByWE42cFgvV1o3MFhOd3FrOTBk?=
 =?utf-8?B?YjR1bjNGaFNOcTlFeEdxdXVKYmM5dnRyanUwc0gzbFQvWFBiaVJjeTZTaWRT?=
 =?utf-8?B?TGYwUEJoK1g5Y0cxMDF6YTVZRlloRTRLcFA5STRHYmJVK0ZWUzA1cE40VDJw?=
 =?utf-8?B?cStpY01icjkrTytOWCtab2FydHNwZ3R2SkxYV2pwMmVCY1g3cWVHVHhRekRk?=
 =?utf-8?B?TElUVHphcUQ1UHY5VFBhZWFrQytyeEROeTVnbC9acXFTS2l6U3R2ZkV0d3FC?=
 =?utf-8?B?NXkvWGRwY2ZnZEx3ODBKVklxZC9EZ1huOHdkTFVNQnRMTi9mNVo1TjZDeElW?=
 =?utf-8?B?b1grNTc0WXlFazl2WGMzMUJ4ajRZbW4vM21jNlVTMTcvVzRGdnVDcUR3KzQ0?=
 =?utf-8?B?TDA5dm41ZEYwVGMyak9xOENvbEthWVNwZUtQZjEveDdCb0REMW1BSU8vMGlW?=
 =?utf-8?B?VFFwR0FibloyU0k5R0I2M2k5UStIL1RadkhyZkhvdm1DNzF5YlU1S1RjWWFN?=
 =?utf-8?B?ZVh0TDdIL0p5M2N4WE5HREpNYzRNbGJqbnhDVFVraitrTlBqdWdxZnIxczIw?=
 =?utf-8?B?L0NyeWlXRjRRcU5zVlAzNi9iZmtHR1Y2VUJyWmQrdGlTTXJHWUxOSUZxWjVo?=
 =?utf-8?B?WlA0MVRxVnNacnhVWCtnTGpWbUliS3k5WEpHd3lRcDFUd1l6Y1lhbS9UeS9m?=
 =?utf-8?B?bnkvTDNKVlZxaEZjbFNqaTBNSXdaRWdvT1M4QkRwZFNBV0o2TVYxVlcyRG9H?=
 =?utf-8?B?VURjSTBubld5eEhnN1NwMEtjaEtTQWF2aGZTYS9nbkpTbUwzVVIxNEdYaUU4?=
 =?utf-8?B?NEF4c0xoZGEwVlFlcWN2RHhZVXNoSHdhSUFSUVlsQmMxN2hhVmdzVjNtMXY5?=
 =?utf-8?B?R3F2TmdDd0ErYlhMWEFNWHpYcFAzV3prdkJFOWkwaFZFalljVElEWm5hZDhC?=
 =?utf-8?B?Nlc5UnViOW1laHJqRzZlN0tidkRzQWpFaWEvSlJ6SVlpWFlBMGdkZlJMUU1W?=
 =?utf-8?B?ZjQxUThWRE81cHA1OGlEL3NiSjE2TzlNMjRXRzVwWWc5ZnhtTkp6TTdZNW9s?=
 =?utf-8?B?aW9JZGpMUy9RZ1lmaEpZOE9JaTdUeXRFZjl2aGlwWEladkpQNE1UcXZtcWxY?=
 =?utf-8?B?aGZWbno0bDRZS1JMVTJNVXJPYzU3cGxiOFdlSHlEZzVlT0UyalM5Wng4RmpP?=
 =?utf-8?B?VzVodzFrdlhEUmlHcnhpZ0tsZ1NJTm5SaHVRZXVFWUl6ZWw5TVRlWStkM0pI?=
 =?utf-8?B?MFRhWVlSc29WRHVDUHpZTzBHSFAxcnR1T1hvNUNSWlE0azJxVXdydTJkL0dF?=
 =?utf-8?B?V1EvdExtU3ZiSE9xd3YybUZnVkF2dm9FbWNXVW82MVlUWUJNRUdUMW90TnhF?=
 =?utf-8?B?VHBMWUVsaEM0ZC9PTEY3a3MrUDFDbXhtYkRHSHl6ditFbjR3RTBWUmd3ZnV5?=
 =?utf-8?Q?tC3UQVoqwT4t51y/xKyx7RxYVjGjWxD/C5jBalbe6U6kS?=
X-MS-Exchange-AntiSpam-MessageData-1: oFSGhbLz4EiCLw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b801feb3-6dea-4c93-11f8-08de953ac31d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 06:47:55.0542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSdJAWLHY1FgLD621iCol0ELksCdqUwi1F6hEl5oNtJc5Q6xndJYeTaNV0REZRVs1Hy6cgRTfgvpz+XDV33iug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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

On Tue Apr 7, 2026 at 11:22 PM JST, Danilo Krummrich wrote:
> On Tue Apr 7, 2026 at 5:59 AM CEST, Eliot Courtney wrote:
>> The driver already assumes little endian in a lot of locations. For
>> example, all the code that reads RPCs out of the command queue just
>> directly interprets the bytes.
>>
>> Make this explicit in Kconfig.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>> The current code assumes little endian in a bunch of places. I think we
>> should either explicitly decide to be generic on endianness or explicitl=
y
>> decide not to - having some handling sprinkled around in various
>> locations seems confusing to me.
>>
>> I believe that currently e.g. `RUST` transitively depends on
>> !CPU_BIG_ENDIAN, so this is more about making the decision explicit for
>> nova-core rather than fixing any kind of hole.
>> ---
>> Changes in v2:
>> - Also add to nova-drm (Thanks Danilo)
>> - Did not take Reviewed-by + Acked-by because commit changed
>>   substantively
>> - Link to v1: https://patch.msgid.link/20260406-fix-kconfig-v1-1-8f63449=
9f7f0@nvidia.com
>
> Thanks for the new version -- I have one additional question in [1]. Othe=
rwise,
> going to pick up once -rc1 is out.
>
> [1] https://lore.kernel.org/all/DHMVA3S2MZWV.1JN7WUBZLRWLV@kernel.org/

Thanks. I think others have answered the question (Thanks Timur and Joel)
so hopefully all good.
