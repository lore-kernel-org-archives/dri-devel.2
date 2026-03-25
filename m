Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AB8106B50D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F3ED10E88C;
	Wed, 25 Mar 2026 12:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lDr+aCm7";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2FA610E88C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlltEEvDGD6mHL0jd5fL7YUr/F7qMZAP7z9lMVtpFKWMr2OGM0o8A76D9q+EJ5ut6c/RA9vxpPoVjLvXPhqG1rueu0aWJ+4dWuLyBCiSFgKdvV7GyDseu6mkWcsXOYGMxXI6De1xzcgjodgXMo27ODSdp2ATnu0fbPWxZLuGBDJpHJofzN9TPvxMeN3MZVvPjke3nbAKmtSPHdZsU5LxUD+DZHJZH+BkFIFXSNZwVd1rA6axA+1dDZEWKl7eEav7r9a91l+h+mGzLFGiBBGeHnwpHZKDOAn/zhCh4/5sVMis/3hQtFo/zC2559SKxdHlcliVxft+g3Z8bKZaSB1K6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me+VtVHGjT4TIwO9pRs+ti2OuHqG570QUtf8+F0aNBs=;
 b=nHELhVTUaZMDNRR5gZ7iVMbBuFYr2d4ViwoJiwe+/GBhl595fnfu54msYDQc7zAMIR/Op7bBvybE9uu5HiR8Q/qnNP2uW8cdUk7pIVKvdjiGwq5HXOqqleZKSg4elXVYUhfLZmMmOwe2CSCTuHVU13vLBPjNLqPQw6vwlJavUEcjxohPopnsPaRADvGCcT2gRx+WjmoGZ3MRauQPcZ/c1QEOYDHnoh/zPJazCc3VSqq+MyudlwrsXcPSHf7pm8g1wMpkqwJrjpRhHyDOgkpGTNTopgsS+klzIjS/3NtqGY65Bg7K7d/Z7ZibpSXnV5gbJL0WVntJSAAlJr4tgjfGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me+VtVHGjT4TIwO9pRs+ti2OuHqG570QUtf8+F0aNBs=;
 b=lDr+aCm7NGult8V7V2oMB8NFU8iE2E/ELNQtJx4KTyDYC9NKmPhNBqvUa4OkYigpteN38bSvevtBH9epgIKSTTb+ntmv72eS48ml4wIBwKUNk04iRfjOHxgHdJnr5WYZdjXq1UZYag3ZIuCEVqdhLFLTnjWe90hn4ECpAsFYJB+MIdK3nYzSrtXj4bC8SPunSTOHyJ0ZlcnWLAncBQ/lX//eO4A1nq4BdizEwEbJozp+vp05apXgqftm0yrm5phXeWLaU0lCn6b+6Zc7lGQ9JIfSetMC5X0sWR0gZ8oD2Uguxp61/L9e81Ot952+r/A5gAN6/77yy+IYGDBp8pqkTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:13:54 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 12:13:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 21:13:51 +0900
Message-Id: <DHBUS09H7PT0.2HTW5JX9YDXA5@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 9/9] gpu: nova-core: gsp: add
 CeGetFaultMethodBufferSize RM control command
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
 <20260318-rmcontrol-v2-9-9a9fa6f1c4c3@nvidia.com>
 <DH7N7BE0CQNG.VI8THRIVHONS@kernel.org>
In-Reply-To: <DH7N7BE0CQNG.VI8THRIVHONS@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0142.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::27) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4ed4dc-437a-4804-1044-08de8a67fb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Sz0sc+/gEOwoXzr41QQYm3AfdDdVrFpvz2Atlk3j0loDA+oWODgbsv2BkX0vF6g9VRohLmmDu2Ogt2w4uXa9PJkKfFYRHXzwKbgItUYTAPZBampf+pdCQH5Z7qVcx5iFh+1qlnkt0O5w2aZskFKKUrjGQ9jqCR5F6RYGCIVVw930futhX26aU9EHZfAK57arzmj3psW9jxZ61mG60mphZWv5vy9WuYhoKPr+19XVUJyK87Ip3RTWKkf0Oha62EhIpnMlqwht9uPTrCXFG/0hEp9CscPP17NFTLTb1LihIEY24r9HjWntoMKeMv95Del6a/bES9VYASppFj1tODMAO5oFVKl5wGfOOg8yWaDWWU63Dy7AHDcnhjEXhvmGMhaTbX6UHPyYLKf57LrkLTEorhnrDalIacqDsUCu3saClKgYRRhfyjmjqbqtl7mxuo6RqKFCh95MZ/u0JvFRkYm8GMBJ7M4rOxq2xBdfimrS9sFXT81W1cu7WwzZ3jdGxdkyvTJEX6QR1129GKqBPt9UDudU4TeA1jG3jzp0nzsSLoFG7dNKrTZNL6TNdoZpUK6SMgq2O4/utuCMedd5g/QRtSODPHS50mryYsIA+9mvzo7W7FuYzz6BSnRmOMr/rN7YsvRR7e7ur5s3dSTtODrZ+giTAqLB7WXBPVd2Wj6I6StLfUt/w2GjLIc+7X3qA3/UKzCmPrUn8D84CjhHgIM/+x58J/iz7r9sYYMCINFDkRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFl3RnF0Yk00aVA3REhxcUZNNHF2UEx0NGZlUDVzN255VUxYZVlGbFlxb3BV?=
 =?utf-8?B?TXY1REZzbG1aN00raFJhbW9hSWxjUXkyYTkvbUZLZEF0SUczQTBOblZBeVZP?=
 =?utf-8?B?Ry9nRjRYUVVKaG9CTG45Q2JtUnFHdDMrcWFPNEcrVmZ0M01EaHYxekx4dVB2?=
 =?utf-8?B?eGRYRmczMVMzaG1TRS9LMWd1YzY2NzU0M2Q0czdTVUNxajZ6eGRjZTc0VlJu?=
 =?utf-8?B?dkFmelRtaisxS1V3bHowanlkL0VFU1JoSzN4ZG9WdnU2YWVNTndSNVZ0Ym9I?=
 =?utf-8?B?cWludEo4Q1RlTy90T3dONllaSFplbWUvU052ZFBZQnUrTVpyUWlBN3h1aldj?=
 =?utf-8?B?SFVZdkJrQlhsT0hrMHEvTExvSy84WFFZOXFMZWtldFJETmNHRGV5TFh0MnNn?=
 =?utf-8?B?TG81K1hGc0dWTnVsb2w5WU9vRGhwRlowSlBHOXhoR05xbFZJZGwrUUFXVjBO?=
 =?utf-8?B?bG9QUy9Zc3IvaFlCdHpiem9QTTgxU3RoeU5JQ3lITmxURWtRQUVqelBlMlh6?=
 =?utf-8?B?UEtvQ1FveUFyWGp0MnhFY3U3MTVZb2xMSjF4T0w0NTIwTWtnb045KzIzZXZE?=
 =?utf-8?B?M1dwd2NmVFhEQW5iSGdhRXU5U2RnNVp3c3lnMXA2dFRFMThBYVQyY0o2ZnpV?=
 =?utf-8?B?bnZyY1JPRnd5RGxUUDlMOGw2bzhSZ0M5cmltZ1FyaHRRcUlmZWpjeGcwdGxW?=
 =?utf-8?B?QTRaRWlXcFljZ1owTHIwL0VOVmcyTVJuOTR3ZFNPRWRDRm56c3o5djUwd2c0?=
 =?utf-8?B?WU8xbU5SWnhMNHRybjYwdEgwNU5DLzVCNUtGc3JHMHFuTGc2YTJHZkliSjRW?=
 =?utf-8?B?a2pLb1ZrTWV5MVFVbjM0d2VoNFp1Y3N3eUZhOUJlK2c4ZnlyRHY1dHRYRXNu?=
 =?utf-8?B?WWZycWJmcUpXSHpYdHViNSs0eHFtYS85UjJrcGhBNGluOHpVMmtEZmpkSUtv?=
 =?utf-8?B?K1dOUFlaaWV5S1V1MW5tWWkyWnk4ZGxhZlR0N3UvRFIyK1J1Z3RtSTlydVJ6?=
 =?utf-8?B?MVF3NDdueWFldXRjajlwakdrYW4rRkkxQzlZb0orZ251bzg0R3RBUmtpc2Qy?=
 =?utf-8?B?MzJqMXkrd2NsWTUrTW1CUDEwYjRIUit0c1pPWTRaZ0NaRVFUQ251Ykk5OXYv?=
 =?utf-8?B?Y2E1UHlNRnRmaE5ITTFlSzJqK2loK2ljOVZtLzdWYlo5RnB6ZnZRUmV1UC82?=
 =?utf-8?B?QURLYUROVGkwNnlaYU4rVnRSYzFqRUpJS3A2SkFHR0ZUd3pDamRBaUdDRS9h?=
 =?utf-8?B?SThTVnlFRFVNUlNVUGMwTlg1c0JRVUdIYVVlYXdIWS9NTWxOSXRFQ3dZdlNE?=
 =?utf-8?B?SlZRTkp3UDlpREYrbDd5eUlIc3pTcFU5YnA4bnBPMytHRk10aTcyOTNnV0VF?=
 =?utf-8?B?djZNeHp0ZGFlclNhRDRMT0dUelNPYU5seW1CZHk4STNvQXpuM3VGUkg0d0hW?=
 =?utf-8?B?aFVkcnhSOVpwQ2V2TFVWQVNoK3BseGhrakdCd2hMdzJiRll0SFl6SXJWbndo?=
 =?utf-8?B?bDRlNExhT0hwUFR1Z3dvNU9sdm44TVkxRkFGdkJnWnFnWHp3VWtBOVJsRFp0?=
 =?utf-8?B?aDBlWlYrRlNaeUNQR01JYlE3cWxSZGdnaTZuK2xjczh4eGpGb2pneWVJRGxk?=
 =?utf-8?B?NFV5dXh0ckljQjI0Y3pEaHY0b05ZUXIyMEhQaTl5UFhQVGttSzBUdE9oVzhz?=
 =?utf-8?B?VmVkTk5ZZWdWbzZqbjdyWFRrU1Q2Q0FrR2lVSlBWTWlMaUIwVldIYm85MjFz?=
 =?utf-8?B?YjJyMkdLYkp0NTJDTGpSU0w0YVRub2ZwWHR2RE1aeCtkSzJzOFp1ZWlJVkFW?=
 =?utf-8?B?bkloakdDRDN6MkpjUCswSkhMWVhzMnlXb3NBNVJ5bGN2T0xrRCtSL1YzNSsx?=
 =?utf-8?B?STYzRzdJZUNRYzY4cytMMHZ6aGNqcXI1S1ZoMXNVS05VbDdLVHppbDN0T2xr?=
 =?utf-8?B?V05yNU9DNE9qS1hYaWJtSFVYMk85dXRZN2lXTUVBRnVjTzZQRkdRMGZiM1NL?=
 =?utf-8?B?TmdpNFFBZ2dBOWZYZC9reTlub0hJckxVVTM5TEoyWHNkVW14MWRtd0pGSUdj?=
 =?utf-8?B?cnZRKy9uRWp5bHRxY2c2bFJQSUZrYlRoWWRLV1o4am80ZEVOeXZuN1ZuVnYv?=
 =?utf-8?B?Q000K1A0cVl3aXVJc1RIZjErS1RUZmZrNG1QQS9IdHVQRnZGTFhxSkpGdWxQ?=
 =?utf-8?B?dUpHaTd6YWNiRzNkQkJDM1ZMSWl3WTkyVjN1MTIwWjVFaTNiakMrcVN4REl4?=
 =?utf-8?B?Ni9iRExrY0Z1WHJTaGZrK0Z0b3RrQnkvQmhlcDRrdWFiQnFmOUQ2YnBYcnhl?=
 =?utf-8?B?ZktkcUJVWEJrYU03V0hCVjFGQ3hsL0w3VllmdU1uM2xHMG9ndE9VeWc3MmR2?=
 =?utf-8?Q?djXBLQY0QSfe+uAstEVo+nJ7sVPHKbST3bHxX//IQAjh5?=
X-MS-Exchange-AntiSpam-MessageData-1: YCuHL78blowkjA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4ed4dc-437a-4804-1044-08de8a67fb77
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:13:54.0970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12jGArcHR5xVnlnSVDU+3/AVMk7w+kt797njzAJMX0cO1P247mtIiHUNTKrSHRCT+cmud7iECvPeV7NPCNR0oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

On Fri Mar 20, 2026 at 10:27 PM JST, Danilo Krummrich wrote:
> On Wed Mar 18, 2026 at 8:14 AM CET, Eliot Courtney wrote:
>> +/// Sends the `CeGetFaultMethodBufferSize` RM control command and waits=
 for its reply.
>> +///
>> +/// Returns the CE fault method buffer size in bytes.
>> +#[expect(dead_code)]
>> +pub(crate) fn get_ce_fault_method_buffer_size(
>> +    cmdq: &Cmdq,
>> +    bar: &Bar0,
>> +    client: Handle<Client>,
>> +    subdevice: Handle<Subdevice>,
>> +) -> Result<u32> {
>> +    // Stack-allocate the request; CeGetFaultMethodBufferSizeParams is =
small (4 bytes).
>> +    let req =3D [0u8; size_of::<CeGetFaultMethodBufferSizeParams>()];
>> +
>> +    let cmd =3D RmControl::new(
>> +        client,
>> +        subdevice,
>> +        RmControlMsgFunction::CeGetFaultMethodBufferSize,
>> +        &req,
>> +    );
>> +    let reply =3D send_rm_control(cmdq, bar, cmd)?;
>> +
>> +    let params =3D CeGetFaultMethodBufferSizeParams::from_bytes(&reply)=
.ok_or(EINVAL)?;
>> +
>> +    Ok(params.size())
>> +}
>
> This is similar to send_rm_control(), I think RmControl should be generic=
 over
> the control message type, so you could just write something along the lin=
es of:
>
> 	RmControl::<CeGetFaultMethodBufferSize>::new(...).send();
>
> Admittedly, CeGetFaultMethodBufferSize is a bit long, but that's GSP nami=
ng and
> get_ce_fault_method_buffer_size() isn't shorter anyway.
>
> (Btw. please try to avoid building functions named get_*() or *_get(), th=
ough
> I'm aware that it is part of the struct name in this case. Yet another re=
ason
> not to solve this with a helper function. :)
>
> Alternatively, you could also consider a builder pattern approach.

I agree with this, and after thinking about it I also think we should
get rid of the other helper type methods like `get_gsp_info`. I was
trying to make this consistent with the existing way it's done (the
helper methods) but it does look increasingly bad.
