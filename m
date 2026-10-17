Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABEBCCA46C
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 01:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E3F010E07D;
	Sat, 17 Oct 2026 01:37:09 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA3B10E07D
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 01:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6Ab3nV7Ok0XH/YK6/R/Zn9hTfSQNiVKn5qcjAOiDNXndMPbJisopwN/8Sc7Uu5urjw37zRLx1eUYJPvN/nXeZf+ljyBeFi7Qrz18PJqTaM1Zd0XekqXh3KqLtrWVqKetEal02KRMdVx1FnP6Ayk47lSP76HNe/KLgZ+NJkOx5vVuQey79ZoJkJbNOcPhzQbNmdzLpYqKubIldpBiPoXeS07AylrtE7ief2lbjHEYSg0EMPrJCN1ytes0syYbuvD+2llWqxFKAzVRpqgdr6z3EWLmeeqZIDDXzmegfHvE3tMOvJf5Hc4/Lr9aYquSUS+JHL1qqUdDoeec4cpfuobQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMQkXDjEQEMUoWqCSyi7yTea55+kgCAgyIlcGhjjiLQ=;
 b=CaMr0kStAH8gc+R5E1YwwhdvGfzQXss10NSJSp6dZIMRVlUWAftZplD4ifKKs7273xLLwzbZb9QELcW0u84XAbLyZR43gYgP1KTmf4sVroygGNuhCnSSF2W4I7rYkks1B2Op9S491rjH0uFRBI2qjWwOm5qEJV+/V8rhf9UrpZI2i5EdaqrfANLlL/jGXFoAxjawZELctrWlcOU95aoTzeFkeaV3h9yvOpmzIQYeWeQnUEgq2T5la3MUsSlQSw14IHhJMToZbM7cPLwX5cj8n7Xg+lO9BDKCx0afP20SyU876dmm+AYHqVM3hC5K/rSHC/ONED5aoMh/y/dJSQedsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMQkXDjEQEMUoWqCSyi7yTea55+kgCAgyIlcGhjjiLQ=;
 b=WOWmLTfJe2qSV2JZwcrMGFZ1vkq3L6iilWxy+/CKTEO30Xvku2aeFjQ12H+ei6HKiochprkF/IQZKuhcGyVXuKW7yD43kl6PseEz46JZtzVHWnUNKOsIuha6J5oo3y4CC9YKFxfrOmUXyfw2GxYvRVdo0o3+HMYk0N0f/D8dycVvtwVZl9/4BmAhnGSTTC0ctRWr70CZ3hzcl82iOsxZdSCtfl3XysXMB2LI7cjyZh8dxgH8QbGDK9LU7jzSa/6cBFgbNtAth/pZgj7VGT0u5uzZ947Z0vNaSxB8LSzIL4+XqnyijHL7k2kJmIpZ+gIOpgPKMJKTkO2nv7347Y+EKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH1PR12MB9624.namprd12.prod.outlook.com (2603:10b6:610:2b3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sat, 17 Oct
 2026 01:36:52 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Sat, 17 Oct 2026
 01:36:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 10:36:49 +0900
Message-Id: <DM6Q8HOV2J6Z.19M92D448I2JQ@nvidia.com>
Cc: "Deborah Brouwer" <deborah.brouwer@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/2] drm/tyr: allow userspace buffers to be mismatched
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20261015-b4-dev_query_fixes-v2-0-e3e6d25050cb@collabora.com>
 <20261015-b4-dev_query_fixes-v2-2-e3e6d25050cb@collabora.com>
 <atHwZg245MM7l9Ty@google.com>
In-Reply-To: <atHwZg245MM7l9Ty@google.com>
X-ClientProxiedBy: TYCP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH1PR12MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: 647ed8e4-463e-48b8-a2ed-08df2bef1e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|10070799003|7416014|376014|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9SWzmncpCHiCmLD8SxTQ+Il0XcW+7HcjKff2pJTNlD2P6MeWMU1QsOerLhtcromuujiOjkFXbFBK48vZOr4xq7zqFzetgddgH8CjKjmS58GmwBybf7SofGkoSwHlYxT00C/CJc0RH508OuZhey599/3SmydmrVVWgMrZj/wJfoS4c8xry620ORvJOhoZvcqQf0PBnighHDvmQS96lgF+dCZeSQRDj6qwbxd4/owSCPmeWhD4jjUvAmoHC+XoHVx3K0BVC2UxWuTVWqsRcrqdMimuZk1zEUENJwrTL+QICAXNlvqZiwvg1ZkfABCxqrjMCV6vRZScDsyzYlPMXi9Sj8gnzvlLRdUzUCx29zTwBNrscVkT9ZimmOoHgtxqW/sTwIhQxvUEMZDammM54QK9V9CiqzzVHkVg3GmFXeywxqyy3eGCLYNrbzi7r5iztJTrMEMtTLJviGI5agg3BFcdcQrcKeazv3O5WpnX2GUXHw7sizWfCWo6dNuqcxziiLwDlc/UqPcuH7zne9/WcKPjHidKAwpJkwvTia1wJhP6H8O+/5o2bBtoF2GzuuLNxtoQoHHFWaqObnN8fdfWhSrK6hfooZmkbySzOncyZXKY9HNrpITIiA0tquwtVsj30Mh3P/TJneRb8Op9slUCjaN8U6ohDKtQY4rBM/QNPyHqmgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(7416014)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cER4NmlGTmZ5M0JvYkFLcld1UC9GR3Azb3ZCM2MzQ05UdlRjSkJlQ21EME1B?=
 =?utf-8?B?MjBpU3IrU1Nuc0ZDVldMSWgwaEl0b01qR3dXL0ZnRHVNTzA3cm5uS09reXNX?=
 =?utf-8?B?aUV1WUtMMngzWXlSSEhmeVFIWlpJZnlmbTM4WkRxUUN5MEkzUjk4c1ZnVFQ0?=
 =?utf-8?B?dVhJYnNKczFMZ0VMbTFrNnF3N2RHMkoyZ2Z2SlBZTklraWRSMzR5RFdoR0Qy?=
 =?utf-8?B?U0I4TTVqTjh1aytvNTNvWFp1RlYrZTg3QlNhbkhCODBpM2c3MkRwL04rcTd2?=
 =?utf-8?B?aDN3aC93c08wdzV6Ui83amNUTWJBbDJCRlluNkZObk1oS3VRWnQ5VlhYTlZW?=
 =?utf-8?B?djhUWk1FYzYzNjFONFFaMGRzRkpPM296UDRRaHNxOWc0eEQyTjNNN1pKRjVs?=
 =?utf-8?B?UnV2R0J0bHVGUUx4a3EwbzcxdGZPcGpDdkVTb2kvQzd1YloxOXFvSkhiQlVr?=
 =?utf-8?B?QWViQUVvOUFJSU95VFJEQ2UvaElOYWJIV0lRQ3NjMkNKRFRIV0R4NWQrajVr?=
 =?utf-8?B?b1dZZXE1TzVYZ0M1RWNRZnNtSjhJS1JwWC9wZGJCNHI2YUhVM1BpaWVXL2ti?=
 =?utf-8?B?L0l6Vnh6OVVLNVBLRE1ySGdSb1orMHZDcVhvUzRmTlR5ZVFZWk9id1ZndXFY?=
 =?utf-8?B?VVBhRTV0Z2UvU0k3Mi9RVVN1eEdnQ2JaN3lObFhOcURoN09sT0h5SjNlV1Jn?=
 =?utf-8?B?OXBETGhqLzd3ekVUR3FmdXd6N1VtR2xlVUIwTVRtSVdJRktqUzVYalFEbDRM?=
 =?utf-8?B?ZWs5TGpNajQ2V1dlMGl6dE5jcENxTUtFRloxTUxtSEo2OVlLeXhENTYvcDVL?=
 =?utf-8?B?MnVETk5kV0FObjErWWY1RVlGT0JPYkR0MU1UZldCWGJML0svY3VYaXRiYjVW?=
 =?utf-8?B?MnhScGVZcnVNQnZ3Y3grOGJBU1ZnaFMzQ0d6SjkyeGl2azE0eEgwb3BobVRj?=
 =?utf-8?B?dW1DdFRxRmt3U3pGQjZHbEJESyszTFNvTWRCOXd6TzNibDIvc2xVQW9xem1q?=
 =?utf-8?B?UHBvWFRZdFY2QjhJYzJpTHBFTXhKUjZBd0g5UDJIdjMvZmJWKzFwWmdFeHUr?=
 =?utf-8?B?ZXRqKzlkQjBBT0xVNWcyRFNrdkYyT05ybUt5dmZISFJjd0l0OFRtSEx6ZG5n?=
 =?utf-8?B?dGYwcmFPOVZ6cGFCN2NGa2JvdG80Wm1Ud0wzMVg3T21rVzNoa0VQZjI1Qzcz?=
 =?utf-8?B?MUlZTHhYemNwSTlTRmY2QkhUWTduczFabnQxWDlhMCttZ0R4ZStNTUtJTXJB?=
 =?utf-8?B?WWIreHpUTGRFZFVPVUR4YllMTkhKMzBpMDFndjhPSjlyZFlaMElxSnQ4dUIz?=
 =?utf-8?B?UWVNSTNhQXpiRzBUVHhCNDExejdOZCtOS1BEL3ZTT1NVRUVOU01kcU9uS2JE?=
 =?utf-8?B?QlVRRnNjZlUrZVNvUHNadEIzN2xSSWplKzhxc0FUamxhK0ltT3I4NVp5Yzk3?=
 =?utf-8?B?YVVBUjlNYzg5RUlhU0FEaUVCUU9HMTIyTEpZMnlMNVlTMHpOT1BxVUptUXgx?=
 =?utf-8?B?WUJZVllnTUtweEgrSVZJWkd6dWRyNEIxRVBBckFzeTIyZFpKR1h1TWJxUXNx?=
 =?utf-8?B?UEVyOWNVZTV4bER6ZmlRRlUzWVJwcUR5NzRTYUdHQ2VlNm1acFlneXZHSURF?=
 =?utf-8?B?dVYrMzk5eGpkOTFOZ0dyV2dsdE5xZmZ4bm1Va0lDYWdJb2NuYWZhWDVDemhm?=
 =?utf-8?B?aXJwdFo5SGpBTW5PTlQ2RWpudmJOL2NWRzJ6SFRGdG9QMmZLNlppTlRKZGVF?=
 =?utf-8?B?cGdCMGRVOUVwRSsvTEt0Z3pQM3NpQlRGb2o4WThpdmN6OFFwUGZZSkZMOVZs?=
 =?utf-8?B?TDV2RUhwcTFjdEtZUEd2OTliRWU5cWxxZkw4N1JVaXFZNTJ5bWlmazNtdzBT?=
 =?utf-8?B?M2UzRUQrZzI5clBjNUlzR3BkNXIyN2thbFRxK3Y2NXBRd0pXbTEyelhaWGlE?=
 =?utf-8?B?ampMbnduajZCbjlOTHI2VWhLQkVGSlYxV3h3YzQwY1dYUHBVVDNBYmdGYk1T?=
 =?utf-8?B?aHZZLzRKeFRIY2hRZGhhb2RGNXFsdkF1U2E5b2FHaFgrV05jTDFOSDZDaENa?=
 =?utf-8?B?NlZUOXZhY0dtd3h1MjFxYis4U3ZIbENCaWxxaHBwcmMzM1Q1Vm5IS0Fpd0xz?=
 =?utf-8?B?SjV1d2twd3JjZ3g4OFVobWJYSHJTR2lWa1ViZHU0QlVQMEdldHNYcC8yS1Vj?=
 =?utf-8?B?VmlrSHo3SkZBYlVDbTVHZTUrYUNPQnV1dVpsY1hXVE9RRVRlb2lHd1RkVHF3?=
 =?utf-8?B?L28xNHhWTGlUdFVuTEc5WG9iNGZIMHhXLzA3RThKVWRJMU42ZG5OZlRLellZ?=
 =?utf-8?B?Mm9BSXlxdldRWURLUXg1aTJhbW0xNEJBb0lzZktKckJ0UThtOEtBRjVZdjhE?=
 =?utf-8?Q?6jPWFGovGYYSlinS0XTRhrwc1zesM5YAg5FOMSGKCWZ15?=
X-MS-Exchange-AntiSpam-MessageData-1: Y1GfqIgfBrXIiA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647ed8e4-463e-48b8-a2ed-08df2bef1e9c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 01:36:52.2819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxTrW4l/+zMnvosB+jDbNNDglsbYF9dp3MKskthebOqnMLUr3jfDjxcg7Uk8z/uzweDRpKhfPR3zy0/yHntcsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9624
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

On Fri Oct 16, 2026 at 6:37 PM JST, Alice Ryhl wrote:
> On Thu, Oct 15, 2026 at 11:35:21AM -0700, Deborah Brouwer wrote:
>> +// If the user buffer is at least the minimum required size, then
>> +// copy as much of the kernel object as will fit into the user buffer.
>> +// Don't fail if the user buffer is smaller than the kernel object.
>> +// If the user buffer is bigger than needed, zero out the remainder.
>> +fn set_uobj<T: AsBytes>(usr_dst: u64, size: u32, min_size: usize, src_o=
bj: &T) -> Result {
>> +    if (size as usize) < min_size {
>> +        return Err(EINVAL);
>
> Use `kernel::num::casts::u32_as_usize` here.
>
>> +    }
>> +
>> +    let mut writer =3D UserSlice::new(UserPtr::from_addr(usr_dst as usi=
ze), size as usize).writer();
>
> Avoid casting to usize twice.
>
> 	let size =3D kernel::num::casts::u32_as_usize(size);

Or `usize::from_safe_cast(size)` after importing `FromSafeCast` -
`u32_as_usize` is useful in const context, but for regular conversions
the `FromSafeCast` trait looks slightly better.

