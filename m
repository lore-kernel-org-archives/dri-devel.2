Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCFF1088E5C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 01:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9886510E432;
	Thu, 19 Mar 2026 01:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jw6EMKab";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3B310E432
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 01:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/X6xYJuT9fO+pCmOSXeO0K5fyZkhKsQYP+zXGHxdxdVVhV5OACZa4VUzNmX96gc7wawOlySsEaazf2BWhneFXW6NhwtvmQvvfKqo1xHXITkkh/2uiUehJo5N7eZh62ZFAg8gO1S3kClpin1I2wKL1EUJ6u3Dj7pBHLE06igy1EPBsEoSuojFSb0FfcdeBs94DfITAUWkadj3XVXFUwLuLyxOUKvd6LsfIjRGDsS3cQFz48SL6/F/DlGsui/YlKLgWmEtjIPlasbj2On9cHYyWF+VGRDzEScFT0HWFkjfgwdo15/dqVyFr2RT/s71pJ/0tMnIO3OZ2Dm4djLGrS0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/e0QAnLRvWBqU3sdACkkoHaJCKX4QYBbDENsJwfyJ0=;
 b=mFaBedoY4UJbQ3kR/BYgWEm5abMvGP0vS3HngmRHxXDsYnZwafX3FW/OaAqz6IeZywrqYFp2hpznzNxkX5o8qV/mIlspvjFUmDZm7L1O7GVSCPDrd5ejpjnCCX1X1H7Wvu+9dKl62PoffnoHcwnKsl9Km9eDbW/3Bn8r3r8zDJoRmBRXFQKCuqz470AaAW45GiU76cN5q1Mx9tGRtumJ0HiPwAosQ7uSHSBo0zZzZ3uFw0C+64MMXvkxM65E2L+f8AedzTOfnMEzreAx2Iqg2UxmudRiZAQMxZqHa50PglT5Sa22nMFx/z1SXmFgeCXxurUSzlwvGGBFB4w18fZM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/e0QAnLRvWBqU3sdACkkoHaJCKX4QYBbDENsJwfyJ0=;
 b=Jw6EMKabBnG9QWqLavgRtooh+wBeb1IovGK3MdwWLY73WX41Xq19shs33IAmc/NOG1/iuMwbXy8Ktogj0pCwaI9ujFt545eqYL2S9Fm0kicGeCw0A4jzyoE8BJVxwCiGqsEn+uBbTG/HZIcyKAqSY+MfZyUD2sov+CTbKdARoue4GH3Kry7uG/+gKzc0xKnd41rOkMo8HnrjapZXXrB93Bt8DbSIQsGexciDnftcpP/eCkdojn8lV7I72j2Xn0n1aDfR67Sexv5WTv+1dqdrsOQRxOmAek53qbre8wDdv5fYiGtrAM40TZRQoEjpUnH0JfsnIjkuWAxw7NlpHKuPVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Thu, 19 Mar
 2026 01:06:24 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 01:06:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 10:06:20 +0900
Message-Id: <DH6CTNJ492WU.2C9VVJGPTY3A3@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: Re: [PATCH v2 7/9] gpu: nova-core: gsp: add RM control command
 infrastructure
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
 <20260318-rmcontrol-v2-7-9a9fa6f1c4c3@nvidia.com>
 <DH5WURVBQNI5.1ZO9K0IR3PEOQ@kernel.org>
In-Reply-To: <DH5WURVBQNI5.1ZO9K0IR3PEOQ@kernel.org>
X-ClientProxiedBy: TY4P286CA0059.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: cedbc72e-43b4-4569-d819-08de8553bd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TWORaYlW2aH0GjsKKf//f5Byg5Pg8UopxITEFnkFjEZ5UWLsLBjqdsJj3ULCif4rQsJgw1T00eHo1OCsv6pzw89QtoA1kusIX0G1fI4aoudpLJLs9Jnjao9TeijQEoFF9XBCwkCv1zDZrY3VCJrsg2lRXrgU0orKStBzLkAoSvGhxl4St8m+fzUxnN6JdKyPX5mStN5h4St0PmGPiZkP0G5IuAHDBQtUEvCnPTXsRpy0tLcWIDv0cqOhc8KnECMLGmi+YgTFBze6JL/N4bVlho2RQRbLKN0K7lv6DK0lMizDQXDhA9FFCVksGxcuJH8TJtRzRgF6cnqgMVImlBTh35cwit+Ma4z/U4tpP2Kz4at6u99boleRlpP5q2jA2VAwlK6JlpBpvQGh3qN0u/GxvrBB9Qts/LXPhPETW8n3R1xnqaNo9KJORLkG15On7a9voHn/n/f4Yst7omyzViMWRCvz+1IQraTIJ8OTr6c5rzBz6TiQZ9kpH5LggrH1jgnmD9F7nRpzPmdMmvs2ONs3KrGVazRwpiSUJTNI/H6+91CyAwTu/XUxv1Gz1LPMy0jxNWtXOJZBZEbMxIU9glbM2MttzmwwE9H+3p52f9UJJ3cBq7lxEO/giD6pZPnve/qUYWUbCe4OVskUG/y0gDwja8mcd2XYOZn3KqBIvIc+mxvXy/6PEGIS3kdG25nPql+IY1GOauSJw5RmXe5CiRYdDbo0H0fdCKstSrL+W37amkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFhmSm0zNnRTUWpqNGhURlEvR0tBTmNMMjUydzg5aXYwbndsQ3VTZjIwVGlK?=
 =?utf-8?B?ci9zQytNWWFTa3RBdm1mVmRRUzAxY3NkUVZuZTJsUnAzbnAxcEtGd2o1am9Z?=
 =?utf-8?B?eWdvMkQ4OUV5S0gybmtzMmo4T2RSdDRTN1hRUUI4V013QXdXMWExdFlQc1pO?=
 =?utf-8?B?T0gxVmNXOS80WFh4TDFsSFhvbmVpWjFQdkdZdWFsUzRhdC9UcVRVYjBQR2NM?=
 =?utf-8?B?bGdNWTE0ckRQREFQT2k0UDRKSWZHR2N6Z1c2R1pzQXBYUVhCcmhwMnVndGo3?=
 =?utf-8?B?MFJGbkIzSjA5aEt4MmtKTC9vTmVadWcrL01kVmhFendwa1ZIU3JVWEVtbmdl?=
 =?utf-8?B?UENNMHJzMlpobzJKVVgyamlGQjJMckNSMUNCVDBwbDluQ09oakw3SnZ4THc3?=
 =?utf-8?B?TFQ0RHQ5SVB4d3VaSGtCMGQwS1A2QmNYRmdSTUx2QVhHYWFzZUJjaUl4RXZq?=
 =?utf-8?B?QXlwS1d3cjd2K2JpdmtRWHlBN3dtLzFuT2tneWZQRk9KaTdhTWlDamR6clZF?=
 =?utf-8?B?ZDM2MVZYNktrWGZlNVpMV08vNllrdHFLbzdjV29mR0JYWFdxeWF6ZTkxaFZN?=
 =?utf-8?B?cDgvOU4vZW9EeUxqcDJWUjA0bW9IRHUzTXV0TmIxaXJpV1o0QnhZaklySUZl?=
 =?utf-8?B?L0NkQ2UxS0c5VWc1Ym41a0Naa2w5Mkp5V2kxOXhSeU9vbzBGck1oV3E4VjZN?=
 =?utf-8?B?cG9uSGxzT1ZjNlN3aEEyNk1tby9wcTB4RzlYM2cwblB1WUhzTExNL3NDZkxH?=
 =?utf-8?B?SEhqS0t0VnlCb3Jnd0k0a3dyRTZRbTJtT1lSQUR2aDIyM1pONnIybVdsdzNF?=
 =?utf-8?B?NTMwUFlpeE91M3UxdnVpMG96YTlpKzVhZkZyOWhmSktNRWN1cUgwSlMxSDFG?=
 =?utf-8?B?U2Y2alFnSytoMkEzNmdnTzh5aXFQc3ZaWHRWUU02KzU2STV0WmIzanFYLytj?=
 =?utf-8?B?SGhuSGZFVm95dktiRXRtQjN5bHAvS1k2bXU1RGw0SDJ4Z1hFRHhNWlhabExQ?=
 =?utf-8?B?T0JzTG9lSTg2TjZveEhkOFN1TEwyTDZ2cUx4WlJ0dTM1MTNvS3pKR2FuOTV5?=
 =?utf-8?B?UGh2eU9pVFBRSzBQVEZPQlR5aC9sMkZwY2s0QzMzRlFTSDVYRzRQU3d2ZTF4?=
 =?utf-8?B?NHhzWExMRlBmZ3VmSE5Mdldqc3VQbXZjdnZvdmxnb2J4Q1pvQnZ6S0Zua2Ny?=
 =?utf-8?B?VW5QWXlCOU83VjZhYnpxRVBIQms4d0pvaGhRS1liNTgrMUUvemt0OW8zRDlF?=
 =?utf-8?B?Z21XdzFWTVh5STNERWZZWjJkT1htWVR3V0dac3oydjZvTWc2QUVqNDhaOGov?=
 =?utf-8?B?QzV2MFRZNzNPWFVBVWtRTjJqd2hHckhiWUxkcUNCelI0SXMrNXByb0gvZHB5?=
 =?utf-8?B?VFZEU0xvVHl4TExWU1JveHJMSTNPWlNNOUNhMDhxOUVLNk12N2J3azJZLy9X?=
 =?utf-8?B?TGVkbHg1MWhsa1FQQjNaMlZrRTVObmxwS05UM2xHQU9oKzI2R1dSSGFjQ0Vq?=
 =?utf-8?B?ZFdLMFlJQlNxZ1FUTG5EaTFHcElRQWR1RkhQVFl0bjhuQkllWUNKRTYzTnJw?=
 =?utf-8?B?djNVazZ2WXFsdm55bkRQYmF4WVZoZTFDMVlsMUlpNVVKOHB3Q1Vua0lwMG9P?=
 =?utf-8?B?M3hPMTdqMHlvT3RMUDU5TEpYYnlkVmFCTU5McUgxWjVoNkxOc2Zxd3J5VXQ3?=
 =?utf-8?B?SzJObktkVHRrV2pERkdsZ29pNTVDRkI2RkFtc0NiZmw2U1pEVDlhTTJKRURZ?=
 =?utf-8?B?UDJlemY1MEk3NEdrV1dSSjQzR0JWR3g3bjhnNWF5cDdkU1FKUjZRemZXNng5?=
 =?utf-8?B?c0IvdnRoaDlXdlRDVitVZ1JxQU13TjAwWFU1MHJSRGIxdkhKRHpNM1dYbzM4?=
 =?utf-8?B?ZlN0dDZBL1BxTExRczZSalROR1N0NEc0bmhtcXlYbXgxbkR4TXR4MkF1elZu?=
 =?utf-8?B?T2gyU0FmblJXM1dtbVhzOXNWemh6d2YrTlBnalNQbk90Z3dtOUdSd1M5NFNa?=
 =?utf-8?B?L0k4bUdma0hEQ3daUXluUWVIOUE5djhmaitrd0FuaTRmY3BndXVzazhqVFp3?=
 =?utf-8?B?NU8xR2Q3QzVVQ3hSbXpRazBkMDZ3YXFBdU9yRnF3YkRSVlVRNDVlMUUvOWFB?=
 =?utf-8?B?Nmg3bzg1OUJPUmNSUTlFZUZaWE1xcTlMWGcvWnpOZU9ET0dCaFA2Q0pJdXM2?=
 =?utf-8?B?U1dEVzRkcHJiRW5xUWFpV0p6VU5WM3Z3cGZHQWZZZ3ZSTVJaNU01bVl1aDRK?=
 =?utf-8?B?elFqZlN5Z2lIdlNReTRUSGJPemtLSVhjbm9NZktJbTA5amdMd0hXdFFlWHhF?=
 =?utf-8?B?MngzeUIwMHVWYWRhWWs0RlNUdWFFRzdFTVZtSlVLSnFSZkN1SFl6em9LUTJB?=
 =?utf-8?Q?OS08fd008nJqjhtQwnCD3khGg4eu+zQboQVpAvb45q0jG?=
X-MS-Exchange-AntiSpam-MessageData-1: zjs+E8ysj/ZaJQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedbc72e-43b4-4569-d819-08de8553bd2b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 01:06:23.9396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uce7/IOYsLBkpXQF38oSXfxilSNZE8/CybDDSzYJPi7zrHyGIA6AkAjgX9ck3L75z8JjtB4hU1Pw5/S9Va3Y0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
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

On Wed Mar 18, 2026 at 9:35 PM JST, Danilo Krummrich wrote:
>> +/// Sends an RM control command, checks the reply status, and returns t=
he raw parameter bytes.
>> +#[expect(dead_code)]
>> +fn send_rm_control<T>(cmdq: &Cmdq, bar: &Bar0, cmd: RmControl<'_, T>) -=
> Result<KVVec<u8>> {
>> +    let reply =3D cmdq.send_command(bar, cmd)?;
>> +
>> +    Result::from(reply.status)?;
>> +
>> +    Ok(reply.params)
>> +}
>
> It still feels wrong to me for this to be a standalone function.
>
> It should either be a method of Cmdq, or it should be a method of RmContr=
ol,
> that takes self by value, i.e. either Cmdq::send_rm_ctrl() or RmControl::=
send().
>
> Please choose one of those options.

RmControl::send() seems good to me, will do that one.
