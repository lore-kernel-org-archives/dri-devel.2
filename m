Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D31C44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 04:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86E210E51A;
	Thu, 23 Jul 2026 04:29:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RSYyvgHW";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E45B10E51A;
 Thu, 23 Jul 2026 04:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L95oM7Aohl869vrkDRf3QKE8pW8F/9ni5+6UiaD/cYuEDmwxxOC3oxslQUsKedHoxHpPp5tn857ZQnJMYkS/9qTdneCVd9GG2XJl744WLhAcIvA/2UpXEoV0k77DOFSQvY9WQYgySaq+kViEy3HBOWLDbMe3i8X9rKxcKbkkrglt8lXvFlJi9RWt4KmCmgIoSVCaIj5DIHs1b5aQWDrgGrlXngpYXTEVPBx3Ybcp3lbjyTsWDoXWXCbRqA4Oj9O0dNVpWxXf+E5vyoLjkbrIy8uhDvGQxAKiUc4XPU8W9MG9w3lkOj2MOd+TfiMWdadf5EpcIh8S68ZMZEZW9HVBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmDDCZ2+FuaJtbjZcRJfcGGIpIWIUV7heBr7RP/h3gY=;
 b=wfRxR6A3U4lbTbComuG1GKlcz2t6C6BejKDUQermXscQ8iBFaONvWSDJbjIzQyTufCfDDZu15odBvdREb0GGZY/6qN+xEFitJQoTxjviA894G32xGuo3dKdsiYdR04Xk66YERv1LlQ3aUP9UtHuiDyhu35Furr7TrrCrF6i5IRfBdhJag0Igun40uyIUTvvg/7FpzGY/zbFxPwcL2WhB8LYzn6yaN8dgN6uVFQfgAkVNaBWmu5xchO6CKAoMuufJoRuiMBdW03uVeD2129DjNAxYw8A9oA2Wz7qlNnlkoI8L7kP3fmpAQspBgMUMtwI+XRkULNBa+mOlq9Tw3iCPCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmDDCZ2+FuaJtbjZcRJfcGGIpIWIUV7heBr7RP/h3gY=;
 b=RSYyvgHW5APuabl8Qzj+X1+R90HtE24Q9l2KNSTVExEaIz8OvY9Q4Hyd0fG0AHI3RwWUL79YMxbdffOYra2jZdWMzTYcwd2WtTZAE7/gGLdomq24AyBmMB8JNF7dwQOmlvFZB4Vq277l0JiJn9iBx3yV7ZrQWtmrzlSvIjInyCAL0JWESldzRqU6W5R0/rM/VkD6SStRBH/g9SSzHH/XtTBvxv2+LxJiwLoRJwUs2utjwghnmz1iwi/4oT2XWCbzTc1ls8r45b13mazv4z6lINgyS+8E3bqq+fKMZsiK89ze6Ofi0YLv+5iw6jjeHlI8VmzDjVC1RojAFl5ZiqqR5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 04:29:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 04:29:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 13:29:05 +0900
Message-Id: <DK5O1JF2IXTF.5CW2XOBO2098@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 10/10] gpu: nova-core: wait for RISC-V HALTED on FSP
 unload
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
 <20260703-blackwell-fixes-v2-10-8e3d8bc32bb9@nvidia.com>
 <DK5MRB6JWL34.3IRXDQ8KWWAT7@nvidia.com>
 <DK5NESIUCJZH.CXHNE27Q0OE9@nvidia.com>
In-Reply-To: <DK5NESIUCJZH.CXHNE27Q0OE9@nvidia.com>
X-ClientProxiedBy: TY4P286CA0034.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: c1348d83-17f7-4915-e568-08dee872f090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|10070799003|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: coxaYwXscuFjZgIS53TLrc4WDhnggNxztbGg2p46LV4ZkdzFvzhR9vk8qzmTLp6h1E3LoV+wvSDVFwqSx3vW1r3bDCd5nrV1fNKTKVvI+HZl5O+WkZHC21yli7auF02nKL9edKHDdCDVKG7wF8uGUhC3+QA5MESW98iP0y9qIa/GCbMUCVu6QQDZOU7y3pKalMHKvwdlMkIaTEEGBccWeE8hj3M9LmfDbA58WhLQoVdvl1GdjhDPRXYDtqmaAZhwXIasAtUOdIoQNLTuUBoMQ+mpsVrsfz3ELNWQAvJsajFHxI8e54dq4G3k9SASjcxgjBVkk2jX3rNj8LIwHwgKOPi3jBzNtPiNffkSbAq5ibmvvthLGXK4db2jXfA+yotgES+DGi0EK3GjHt/X3eGH5TPeFenwXQpU2hx3lWsLez2u0gmUC33q9neAUB9GbvqGsqpAs1vAKM6AxSaIhHtxdFtY73/bUxbgjTPygeEE67yeRR1eq8MGgRyzhDHHQCeAX5Fv9/m+zjjfrBMK4u8dgxfMBikLmugsyAV9+ij/Iz0Q9dnneFLrPTELLx59d2HAm2tS+aWh9xruiDsAva0+YD4C7cVQJunXbYGPFkPIjwN+nOafdYtdDksooRl8/SIlsJ96HRwr9TN86NTG6qEBjCqYiZfipdDfBaoxqitLEro=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10070799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlFEM2NHNUFmOHBCdXhxK0E2K2l2NkhJZ1B5NjlqdUxJcThFaXJGY2ZIay9j?=
 =?utf-8?B?V2hDa1U2eWdTZllGdUpJay9rRDVZYjl3VytWckMwMVlORXpEaHcyTEpmRVp1?=
 =?utf-8?B?d3FjOUREcGdyZnU5NUtwaVI5VmROc3Y3dHBnMG1PVHI3L1dkSDRXUmVIa1R4?=
 =?utf-8?B?UFhpR01tTE1Ua0Q2SmY3eVd4eXF6emszVXMvOFVjeWhBOFBOWVVYMFJCZDFU?=
 =?utf-8?B?RXB3KzZVbUVhR0NGQVNVNm4zTmdvTWJnQmkxREpEZHAvUjBESmhHdGEzS2Z4?=
 =?utf-8?B?ZFdseXZmeU9GZk9OSk1hRHNNK2F1V2JhR1MyUjlVWjQ0c0w3NTVUM3ZKOEMv?=
 =?utf-8?B?Vnc3dVlJYnVZVzhjVzNkTWxqbjdlRWpwL2ZoM0JrOTd3Z0NLYithd3JGS2p5?=
 =?utf-8?B?NnhnV0dGVTh3N0d1ZytFVk85YlZNN3J3K3dLU0Nja3RBYjhWeFMrb1dSNytN?=
 =?utf-8?B?RHFGK3ZtK3dQMUdlQWs2b2NsRnNnVUlOajhWRVczbEhxalJEZEw4ZG85dzhO?=
 =?utf-8?B?ZVZIUHRxWTFmWXc4dElSalA0dGlOeVZwOEF3Q1pWRjBpenZlb0JEVHlUME5m?=
 =?utf-8?B?bGVXSzFJaHNla2lqQU1PVVNXOURBQm10MW5pQnZzS0dIdkF6ZUppOXQxalN6?=
 =?utf-8?B?MktISVJmRUloS1N3YVJnWnhOeUNDU0diblRqSUhCRWFQWXZLMVpWNkxWRzkr?=
 =?utf-8?B?Rm1FUjd4aUVyMStpMEswMXdTbitwWnVpRUIzNFBrQWZ4dnppVHBKYVFTc1V3?=
 =?utf-8?B?WHJyVm5DTTFTaFVPOHNqVzF6dkkyWExiSjhYaUxWeHByWExuZDBQSTVLdWIz?=
 =?utf-8?B?dURTVGYweEZEbkVTZWtsdU02ZXdreUEyazY2UWQyMDM0YVpEU3FNVU96Q3M4?=
 =?utf-8?B?SC91b2dkRWpFV2hFU1E0ZjRvSVRWVWFXU3hyYWtVK0pnZlJsMDhGUC9yZERa?=
 =?utf-8?B?aXlUWUJHOGJPT3B2QkNocy9rOHlhU1U3Y3lOdExCaWNmWkZBMXFqclZPL0U5?=
 =?utf-8?B?WkJzNWIxY1hZa2ZtTFVodXAxMStOU2w4STA1TCtMbVhWT2ViTjhva3I2YXJN?=
 =?utf-8?B?QWYzeEtycTJGOFVPY2duWVZwTGk5TElsZVVLREh6YmxGWmtzODA5UnVXVTdC?=
 =?utf-8?B?UmlHTnhsYTV4N3g5Q0E5RWxsMjd1NzZPME9iQjN0RURIaHFlTnplRWtEM2ta?=
 =?utf-8?B?V3FxcnpmOGYxbCszWWVidEtKNDJqV2VpVDRJSW9jYmJ0Ri9iMlc5Nlp4ZFZC?=
 =?utf-8?B?a214eWJFQTNHTXN3emRReFJXc2oybzVBbjg3dXVzYkluaStqM2tPOWZtS3NN?=
 =?utf-8?B?NkpUMHIwalh6ZVh5VFhNb1Vhc1YxVUl1Q1BzODZjMUJyVEtCajJTeC9Iaktn?=
 =?utf-8?B?cFgwTjRobHl6RkVmbWY2L0s2dkpiZ0VSM3J3Nm9ya3FNRi8wd2hwdDErdmtL?=
 =?utf-8?B?WnZBbVFGUktRLy9xY255VGsvbGpRYTYrbWUxbnFXNGNhTy9wbyt4cWtNcGwz?=
 =?utf-8?B?aFRjSDJlMXp2RTJ3UnF4SWhQcDR4L1o5YkxMRVIwRVQ0OE1VYTdNVTM5YWJs?=
 =?utf-8?B?aS9LdDN5NXRYcFI5VURTUzYrei9ycEE3eWc2eXR4RUgrdUwzM3B6dnVPTFgx?=
 =?utf-8?B?WFNnRXhoV0I5MXd3ZmVrS0Z1YXhSb1ppZzlqdG90YnpYSlhYM0pEZmJDWWV2?=
 =?utf-8?B?NVY2ZEkyRDBTOEJwOFNvWFdoTVBRQmt1TnRIQmRyNTdSWVRNaDd6MzV2Tng3?=
 =?utf-8?B?ellCZUJrQTlJTmpaZHVTQlZwdzNEeDg3MExrRU1KRnhMT0FKSzI3YnZqTlFT?=
 =?utf-8?B?TDRVWFFPYk9GdWRYOXNDYVRKUE9kY0YxMXBydE5wcjhHQTd5RVNyN1F3a0Y5?=
 =?utf-8?B?RE1FV0ZtSzAxWm5zMVV5bjQ5OFJMYWFCREF0VVpBUG5zMUZQY2ZRcHBLMnB0?=
 =?utf-8?B?SThHRUtSRU5TZXdmTUJjNnNKUkdUZjZUUTlWT2VBMlF2VFdka3ZhdTVqOHEy?=
 =?utf-8?B?M0xGZmtkeDlwUU56aitBM2ZtZHdGNWVjSjhtdkVyTzJvZ1hqM0NZUitTN0R4?=
 =?utf-8?B?ZVdVeGVoeFg4Q3R5MDZLcmRsM29Nd014M2p0WS94MzJXK0VMZWZKTTVZVGxV?=
 =?utf-8?B?RnRhbndyUkREVm05bkJrSFNFMFVvWUdPYmkwSW1xUXVWZVluOHBCbWwwTnc5?=
 =?utf-8?B?RkdJV3Y3TlRnNG1MckY2bG5nWThWMkFDeUZVY2tGcFk5am5NUEFpZk83ak5t?=
 =?utf-8?B?VGRTNjZ5UzU4MEpNa2g4QWRYZmNMVkVyQnI1Y05DSFRiZUo5cnpuTm1LdjQr?=
 =?utf-8?B?emdWOHR4UStPR0IzZmN5Tnp6cEluWFo3SVhvWXhRYmNtVXJueE5zSWpDbGp6?=
 =?utf-8?Q?8QzjWcbRtILslcSnlDJya+i+DH8NNjekQ8lrf+GA2BxPB?=
X-MS-Exchange-AntiSpam-MessageData-1: H8QjPK/iRax7ZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1348d83-17f7-4915-e568-08dee872f090
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 04:29:09.5440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPCg3joNGY7VSh2JnXAMote1T3n4pUB/NxwEmHiXQbM1ssUXcwY941pOjxbOQ8jSZuLhvU4JwxgaLnIkALwAdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651
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

On Thu Jul 23, 2026 at 12:59 PM JST, Eliot Courtney wrote:
> On Thu Jul 23, 2026 at 12:28 PM JST, Alexandre Courbot wrote:
>> On Fri Jul 3, 2026 at 3:22 AM PDT, Eliot Courtney wrote:
>>> Currently the code waits for "not active" but this is not the same as
>>> halted as there are more than two states. Match openrm here and wait fo=
r
>>> halted instead.
>>>
>>> Fixes: c7fea1f70944 ("gpu: nova-core: add non-sec2 unload path")
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/falcon.rs           | 11 +++++++++++
>>>  drivers/gpu/nova-core/falcon/hal.rs       |  5 +++++
>>>  drivers/gpu/nova-core/falcon/hal/ga102.rs |  7 +++++++
>>>  drivers/gpu/nova-core/falcon/hal/tu102.rs |  4 ++++
>>>  drivers/gpu/nova-core/gsp/hal/gh100.rs    | 11 +++++++++--
>>>  5 files changed, 36 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/fa=
lcon.rs
>>> index 78948cc8bff3..ec286017535f 100644
>>> --- a/drivers/gpu/nova-core/falcon.rs
>>> +++ b/drivers/gpu/nova-core/falcon.rs
>>> @@ -749,11 +749,22 @@ pub(crate) fn signature_reg_fuse_version(
>>> =20
>>>      /// Check if the RISC-V core is active.
>>>      ///
>>> +    /// Note that this does not imply that the RISC-V core is halted i=
f it returns `false`.
>>
>> I would say "guarantee" instead of "imply" here, wdyt?
>
> Yes I think "guarantee" is better here since otherwise you need the
> mathematical reading of "imply" to not think it's an if-and-only-if.
>
>>
>>> +    ///
>>>      /// Returns `true` if the RISC-V core is active, `false` otherwise=
.
>>>      pub(crate) fn is_riscv_active(&self) -> bool {
>>>          self.hal.is_riscv_active(self)
>>>      }
>>> =20
>>> +    /// Checks whether the RISC-V core is halted.
>>> +    ///
>>> +    /// Note that this does not imply that the RISC-V core is active i=
f it returns `false`.
>>
>> Same here.
>>
>>> +    ///
>>> +    /// Returns [`ENOTSUPP`] if the status is not available.
>>> +    pub(crate) fn is_riscv_halted(&self) -> Result<bool> {
>>> +        self.hal.is_riscv_halted(self)
>>> +    }
>>> +
>>>      /// Load a firmware image into Falcon memory, using the preferred =
method for the current
>>>      /// chipset.
>>>      pub(crate) fn load<F: FalconFirmware<Target =3D E> + FalconDmaLoad=
able>(&self, fw: &F) -> Result {
>>> diff --git a/drivers/gpu/nova-core/falcon/hal.rs b/drivers/gpu/nova-cor=
e/falcon/hal.rs
>>> index ee4a017f3a4c..7e532889a1f4 100644
>>> --- a/drivers/gpu/nova-core/falcon/hal.rs
>>> +++ b/drivers/gpu/nova-core/falcon/hal.rs
>>> @@ -53,6 +53,11 @@ fn signature_reg_fuse_version(
>>>      /// Returns `true` if the RISC-V core is active, `false` otherwise=
.
>>>      fn is_riscv_active(&self, falcon: &Falcon<'_, E>) -> bool;
>>> =20
>>> +    /// Checks whether the RISC-V core is halted.
>>> +    ///
>>> +    /// Returns [`ENOTSUPP`] if the chipset does not expose RISC-V hal=
t status.
>>> +    fn is_riscv_halted(&self, falcon: &Falcon<'_, E>) -> Result<bool>;
>>
>> It's a bit unfortunate that we add a runtime error check for something
>> that is essentially known to never fail (the GSP's GH100 HAL being the
>> sole caller of this method). I cannot think of a better design at
>> the moment, but this hints that our HAL could be improved as I think we
>> already have several instances of the same pattern elsewhere.
>>
>> Not a big deal anyway - if you can confirm my wording nit above, this
>> one should be good to merge as well.
>
> Yeah, I couldn't think of a good way to do this either and I was unhappy
> about it. Wording nit sgtm. Thanks!

Pushed to drm-rust-next! Thank you.
