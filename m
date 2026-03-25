Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E400FEA802
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CAA10E6C1;
	Wed, 25 Mar 2026 03:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4qCGyL2";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C15DC10E6C1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRq0s1B0/ME5FCwKx/iQBmxDkEFGyF6XEratDOEMsogcZR5OGMPn9hhnQzrOO6kE6LqJ8YVhO9QimM82+U3yDhoXi1nhPhuEGayblJT6zIC+Sr5AjH1oRFYO6UsJSGyYMkjacmuvbQZJEyEhHon4xptDLYfy7WZFBgaszXAv5DtPnyf6xCwgLr5iZAKJ0demEPyftW1PnfPxdw6Ytto8BFKmq/A5PuH5DZTadw6dAs7CjrkovQvWu+ShWE/jSxZEzFhRfB7OJq28PqSOuN7/gaGD2KLHTmgo8+lHUXEKLnlOMTSYk7UzW+ugx/zJ2UTVac8V8eMt48Md1AxVLb312Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFM5IKKb4K0sMLEocCpRimhzuYjIv0YeqGPwoX3XFvI=;
 b=s5UFNDiaZlzZ1pXVfI9WmVOndn9fbi6Q6yfNXqf7ohFvLr4hfhkGxPH7PfNAM4T+RWyvijjUn//B/rUUpHuzX3MyF66J1gQDPrW7ZX0B4hRHK6APsSbtFiBzJnK13I0s0Sl5bJt0oB/ChMYa8sj1CuHjMCx1DvJQhnbaJwZfUma0l4l56nLAKQ8fuLecmWJkvk1hR/HeMrF5GLRem1QfywAkAGqpJieLfOqQsuSlXwuCIiaR88BwdVcFSn9eMFrZRpreTXYFoC/exsnS987OoEW6FTGkZ7OdJgT4oOJKfmwZ720WD/i9jXdhrUGhrB1oDz+rSc5alBuP5/zfLqj7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFM5IKKb4K0sMLEocCpRimhzuYjIv0YeqGPwoX3XFvI=;
 b=O4qCGyL28ukAkYNQFmGvR1kGyaCJneFQFVI7PBnVuU5gIm1C+Kveuxmj7zusHRzTf2ZHhWBFyzdCBIQ1Kmx3VLzTO4bTnIflkbjitoFdTvC21rFb0R/luyQi0OvR63VaG372V6PXfxDugrQINPcf69XPtaFAh5qMl3cUiErCHh9lfUQr47SkHxf1MPmCwdZbIOOLkl4xJSShZw6IxXNPM9HbeIHkjDv7GRiB7eavSAjJKsCO+oT0TU0o9Lo7zZi+QghNrAO0nnOjvWht1aTKEvHvJ4Suud0EOUACxRe/rFsNMeMDxXZxUARS5LBCkaxSeX8Xl/rmq+11BxUEBdXcsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 03:28:45 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9745.012; Wed, 25 Mar 2026
 03:28:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 12:28:41 +0900
Message-Id: <DHBJLWSMVYRZ.39JQ5EX4TKAZO@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: Re: [PATCH v2 7/9] gpu: nova-core: gsp: add RM control command
 infrastructure
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
 <20260318-rmcontrol-v2-7-9a9fa6f1c4c3@nvidia.com>
 <DH5WURVBQNI5.1ZO9K0IR3PEOQ@kernel.org>
 <DH6CTNJ492WU.2C9VVJGPTY3A3@nvidia.com>
 <DH7OT1GO2GBU.3SQZM9B451DZR@nvidia.com>
In-Reply-To: <DH7OT1GO2GBU.3SQZM9B451DZR@nvidia.com>
X-ClientProxiedBy: TYCP301CA0047.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af3c9d1-fac1-465e-ecba-08de8a1e9e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: gcoQPntY1kGrh+4Pa6Ip8aiy29EXRR9hkygFNjZ0lvX962h5Eo56TY1Ip/lB44EnLGwcVmfk5N5C3vZsekSEbULcu07KLGWapDUYj9MLzn64nF9mchkfhH6r5FLh8wG/UIesx5gpPaYwcRds1Dc4orQ+4F9z1jTmnaf0ILX/P0CYrIm2Gty1XeHexdrKjCMCNm+qfnoafBQI0g8X+d0Oys6m2ItbferpwviOQLoLxjfrH0W7B4is9XtsdYO+CBqG5HAPQZG6lSMgZvQhgnwMqV90i3LXowNhfpuwHMerVV98jPMcVOmQ1/UvHlSF86y55NWYlkozcijuo41TSC3P7M8+yKEachYJ0CodhmHdOp1wKccH6F7M4Av2Guoqg2qHEd6C+mIqjCno5XMJ/5m7ZCOUDGqkN7VS8c4HCF7U1UyPtKe2m/WOSnXrTE8I2EjfEcp5dWg1LwAmZ7nxqEbdrEr6zAouDedlaZzE6eHLkt2DR6oBxd+DYn527CKRTb0WbB6oQOVOoEQEHhTKP2M6JAkSOhem7r8xnk2fJzcCwDH+IbAdVOeNMHMxyPv4AodN3HU1e4f1zstzIWdsMvtBW8qqv3uKhQmq7nDidSjqhjlPMk+QQ4MrPXZ67avHIDUP84gfNknFH6I/sysTYvWdQr1hpanI/D2xtgi7kWs6TsVXofEJMndshZ/3WKa6acULKOYaIdJ763AYidFBObiMuw3PDqIJknx60108ueupMDkPW0SIPmznpVLXkAm5lpPk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZiaG56TklnaitQYnR4YTFLY0JyYm5odWorakxuSkJBZmk1NFYwTE9JUm11?=
 =?utf-8?B?Vi9KbVhvNU9ZQ0VrVTlPQnZJcmFyR1dSNmxKMDgwSUV3VGpPTHhCa2VsZU1V?=
 =?utf-8?B?eUhMRTZhN2czWFBqZGRGdjhoNFBlWFBLUUVIQW51SktNdDVSOVpRRWdKZjM5?=
 =?utf-8?B?UGFaNXNjM2J4WXZHNVd4aXZUWGVtZUZMUE02RVprRmc2Q0d4OXhIdEFCUjRI?=
 =?utf-8?B?VHoxQmRRcHpNdlZxRzhXeEE3TmlDZDFDVUxQU0ZKUk9aTUsvZHZ1Q0NLUDgw?=
 =?utf-8?B?Z2VWZFJUZ2tqMkhhSWZiZDhwZkUrazR2V2xCWlFyUG1qR2Z1WDFHc05wODV3?=
 =?utf-8?B?YlJEM054cjV5c0hhZDNJQWZBN3ZtaERmRUM5MWlpTURFekNLa3VxZDNTbTAv?=
 =?utf-8?B?eXhsVlVPWHZLcVh0dnZ6a2Y4YVFjcVE4NElyS0hMRmdCUkNlREhRNXkzTTc3?=
 =?utf-8?B?Si9FQ0ZQSmZVZjdMbEM3eWp1Wmk2MXBwTmVRVWU2aEJMNEY5ZFo0akNDRGNu?=
 =?utf-8?B?ZzA3TFRpdWN1anYzd2l1QUhBeE1hZGZOQXU4VS8wNk9COHlVQ1JoSStrdlEz?=
 =?utf-8?B?NGJRNnFRWnBuZ0Q2SE1FN0c2QW1saGFQOUh4Ry9BbjZHdFUwQzZOSEZ1UW15?=
 =?utf-8?B?dTk0NkZPM0R4L2VCTHJCcGh1WEVYZ3VuZTlDSU80ZmoxN09aWWxtdlA1WmtO?=
 =?utf-8?B?N29xQWM4Q2ZyZkppZzVBMy93aHFLa0pWaXY4ZnhzMTgyRlF1ZXdSK0tPUjJo?=
 =?utf-8?B?VVRseFppV2dHWWJHZUNNclZUNnJvS01BaGh2bWdOa3Zzd3JrS0xnN1hNMEpH?=
 =?utf-8?B?VkZBQThac1pmQkhaaGNQSHgzcmRVMFVRNHVEVmhBZ1JrT1dSTHVZV3drb0gw?=
 =?utf-8?B?WnZnS1hwM0RLbURPQ2pZdUo2OFVhaTVyNDZsbWZka2hPKzBCc3M1a29KOFlk?=
 =?utf-8?B?VTFZMkU5dk1PcFd6VytBanJrTFZrYjQ5OTVOak9SWEtaMUJjYW9nZFd0Smhv?=
 =?utf-8?B?dkFIME4xVTNqd2ZsRFJBUkVJd1ExZ1NRdmxWK2hLRUsxbzVwemswNjRWNEFX?=
 =?utf-8?B?MHp4dTVpdjhlekQ4ZGFQTkptM2puQnc0Y1YyQ0N6TVd4cTJkRVlzclE5aGVS?=
 =?utf-8?B?aDFMWjVmcUlCOW5HZHl3T2Z5NzZpbzVzUC9EcVJuTk5na3VHeHZCZ0FsWE9J?=
 =?utf-8?B?b25yeld2NllzME4wSXoza0dJdWNaQ2NXa2pMaHJ4NFRYOTUzVUhWOVRJQzl2?=
 =?utf-8?B?Y0lMOXY5Q0ZlbGJDcW1oV2wvaWNzbnVHU1diaUpYWEFsQzg2a2h3RVcvMVJD?=
 =?utf-8?B?Q1ZNbHVmNXJIclI2V2JMN3dybndyQTNQWnR0YS9YbnJkOUVycjVoTHovdzBG?=
 =?utf-8?B?OE96OGNNanNQWS9pSlBpM0kvZzloQXZwb3JOdmwyQUdzdlUwNzRmd0ZtN1NJ?=
 =?utf-8?B?dkNhVUhJNFFLT2xCdk9wMG5LN1RwMEpYTmoxcWJsZXBwSWZrMWlrS3hlOXFx?=
 =?utf-8?B?L1h1MU1CVnd3WXZVd2VOTFFVcG5HdmJFVzVNWEsxT0dkbXlwSk91Q1J4T0ph?=
 =?utf-8?B?aGkwa0ppQmJzbjllOThra0sxK2p6V1VtQUQ3ZmQrY2Q1MkNXdkNNRlcrNGJG?=
 =?utf-8?B?SlhROFBIUDFVNGlxYzlQcFE2U3pDWDVoVUk2cU1xY2sxdE1rVzc4S3ZRYUNZ?=
 =?utf-8?B?RU9VU1NBL0d2N2JBaVM0ZWlGM2dvamtTdlI4eWlicDNuL1JIQnYzMC9qREJC?=
 =?utf-8?B?bnMxVU5hSysxTEU0OHF0cjA1Y0RQR1dnSHIyZ1c3czVBZFRIazNTMGZVeVhO?=
 =?utf-8?B?SXdMMTl0aGdkb3hKUFFMMXNQMTZZY1lUUGNtajA2aEhIL2pqNEYwOWhrQU56?=
 =?utf-8?B?VysxZWlHQ09WUEl4NDdYVmhKZnhZblQwRG5sMUs3ZXp0YkZwcVoydDcybEpt?=
 =?utf-8?B?SUI2dTlMVGpaZk0wbFdZR0FUZ1BhZkdURWdKYnlJdHJmQTFJemYvQTlObEVR?=
 =?utf-8?B?SFhsMUt1bGZXZlI1Vi90cnJ1Z0tqUzVuUkFBdVZkbDhzci9sZVFmRUFuOWhK?=
 =?utf-8?B?Z2Z3UGlkZjBSZG0rb0ZpQUI0c2tNQmtDMG9EeXJLMDF6aHR4c0xIdDNNTnl0?=
 =?utf-8?B?RlJWTEliUnR2SFhGUHk5aUwrUWNZWDBWeDZZeVA0eHNKS3Yrek1XeG01Yk5x?=
 =?utf-8?B?L1NFazY1QWVlZmZkRU1WRzJ1YzlLeFd1WmMwZll6TDZaTG11cWdTNjdHNmh6?=
 =?utf-8?B?dW5zODdEZ1BrY01iOXBNQ2pKOCtYYzNpNXkwYTVUKzkxUTJZTTg4dlZYekhM?=
 =?utf-8?B?T081b2UwK3JSVmk5TndLWll5R0NYQ1Z6eUtJMWY2QmZOMFNoTkQwZ2E3QTlw?=
 =?utf-8?Q?bhOktXla4CiECneBcRTvwutFa6t7FBLP1KG5QD2xf91mN?=
X-MS-Exchange-AntiSpam-MessageData-1: LCdiTfoKRxSlKg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af3c9d1-fac1-465e-ecba-08de8a1e9e81
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 03:28:44.7887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4z0F/i0A2PcJrNfX5WeaX8mRQQ/wocB8WbCeY4ysuFn3zd+TySo65DB4pQee98ypwxIoxzi9H8XSOwJbkegXiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
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

On Fri Mar 20, 2026 at 11:42 PM JST, Alexandre Courbot wrote:
> On Thu Mar 19, 2026 at 10:06 AM JST, Eliot Courtney wrote:
>> On Wed Mar 18, 2026 at 9:35 PM JST, Danilo Krummrich wrote:
>>>> +/// Sends an RM control command, checks the reply status, and returns=
 the raw parameter bytes.
>>>> +#[expect(dead_code)]
>>>> +fn send_rm_control<T>(cmdq: &Cmdq, bar: &Bar0, cmd: RmControl<'_, T>)=
 -> Result<KVVec<u8>> {
>>>> +    let reply =3D cmdq.send_command(bar, cmd)?;
>>>> +
>>>> +    Result::from(reply.status)?;
>>>> +
>>>> +    Ok(reply.params)
>>>> +}
>>>
>>> It still feels wrong to me for this to be a standalone function.
>>>
>>> It should either be a method of Cmdq, or it should be a method of RmCon=
trol,
>>> that takes self by value, i.e. either Cmdq::send_rm_ctrl() or RmControl=
::send().
>>>
>>> Please choose one of those options.
>>
>> RmControl::send() seems good to me, will do that one.
>
> Honestly if we can just extend `Cmdq` with a RM-dedicated impl block in
> `rm.rs` and make these regular `Cmdq` methods, why are we jumping
> through hoops?
>
> RM commands are one kind of command, I don't see why they need to be
> sent through an associated function that takes a `Cmdq` as the first
> argument anyway.

I posted my reason for not wanting to do this here[1]. But TLDR is that
these RM control commands are built on top of the Cmdq transport. They
don't need visibility into the Cmdq implementation; they're at a higher
level of abstraction. But let me think if there is a nicer way to do all
of this.

[1]: https://lore.kernel.org/all/DH46ZI0CRRKZ.1UZTS1TIWPRTQ@nvidia.com/
