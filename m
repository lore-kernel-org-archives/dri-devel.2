Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68C8109E529
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 04:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 414CA10E156;
	Thu, 26 Mar 2026 04:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="U5Hc021d";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11E7210E156
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 04:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4HHWbNUglcyjMbNz+VmLIRV8WpdEKlTw3JzXPbvXcX7pszjrct+BiwofrtN5ow6wrXmSo/qe3RmQcyyTHTdEKZ1nEbSq6htkMQihb+vR+bu/mh5ZomO3CfL9VZey+ejAE3cRrmHVBGUZwHQgODENjIVzV6+nRKJ1J98iV/5yWib2YXlKBC6gty1B7rwC/SKhhB/lo7+ije1ttVBvlsaDAUyFhkDrzRt+kToL3cYD9556VpQk5ENUWpDvzmomo0HhSmdMMFncTuxM74JEQocWMKFri+Ru6fQqaRNH5ZPLJ3+XVTlUIDI1b70/GX9ur07ms9kVFCDCSGA6AByDETJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTi8t9/DvnokjrVh9JdVQLd1hEkzxHCbusCboP2fSrg=;
 b=tcGUl9Ne7cX6mOQJ71QByZ418rNEFrRKabqhyfBbT7w3b9xgXkR/SM8ws78OB4zUdaT5piownYlXVMRMA6xYx8RAwpx68uKk7xPVvB5psE7LxwNCG8tT1p1OorMk7JPVTbM1PLssVa5uQINMN1oBtEvZA2OZiO20YJv1B6EL8lZ2VrwZK027LP3Z7rdml/l3O2opixWa78naWTGQsjkCdpy2tx30DkI0HkiM0a9KTouUMd3Tphkc5/NfT+mfa9rx/7gLhUFGEf3HpMZAbwMEd+PdVBd65vNO4am0KMERZQXNYmMnx++sCZy5HNaDOtaO0T7noO3iJuQTf+bTYqkIXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTi8t9/DvnokjrVh9JdVQLd1hEkzxHCbusCboP2fSrg=;
 b=U5Hc021dTBFG93cadWElzBHDwDraVLMAUyjEGCAHHbfAwzJGfvRP91qoCkb+DlWKFEU5LoH2lYJsZ2T0MBha0WKdLtigErobnlpVCcRx5qy1OUxRkKEUF8wKKsG2zQNsm7wEthJ0I6ZfysOc25pYFZadWfaGKg5DGl/iYxKBuhSeO5R+bYpM8mSYj8ilQ1q2Z5Y0rXxFUkDXd4Q3uyqYuhWhuVzbks/HYrwj8QX9DkrihtG+0QqQa/TsDZMAZecumgxCzCWEsPHbOchAe9gOuWuEfQquAgpJat9g/pANsD1g6juA8xY4FbDYlUTD4dbScJ/gjPNeAbrF/VfRYA1N4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 04:52:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 04:52:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 13:51:48 +0900
Message-Id: <DHCG03J1G63T.1A973DEM7DHQ3@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com>
 <DHAB9Z571FPB.25927BK1RGNGL@garyguo.net>
 <DHB3CGY1Z5HF.1KSJV8SP8YD8A@nvidia.com>
 <DHB40HKJD3OC.OMC04LASMS4G@garyguo.net>
 <DHCFJSHKE4ZB.3M1FFI3K5R670@nvidia.com>
In-Reply-To: <DHCFJSHKE4ZB.3M1FFI3K5R670@nvidia.com>
X-ClientProxiedBy: TY4P286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: a378cd2b-61cb-4022-e9e5-08de8af36556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Tc0twMcd+SZ3myUWmDYhrI9uhWaC5DT6h3cpdup56dU7GDKhXuDkFaKyp78m0AmIQ9yJyR8DHRBM0qYc3QQJP5VN2H8Qn/DlDYERy/9xh9cCat+NxJ2LAI8y9sYpRUh61LhBpSb8L5WkNwcmTo5P/VYsqUpNU3JCMhknaeKEPCAMIGueG2XMEc5QJEuDMa30IEg5aTwGRh0EzqBj35E7x95H5PMuUR1AbIhmOCTMD8M2ZkumEx35G8jwb4Q0+iyH7EGjEQZvIY+GzGUR2E+D9vqvj2T29Y/3PYj1xLQaTohSSQQUqsmKj6r7lVQ604LkhriFoCztQ80rB2PC7HANmXpBAyBkQXwDvBsS9WRS0JHiVf3OccwKXv92rWFi3eShxmkEGS9/K3KfRejO9KfYX8Gur5eNDTIPu7MxcNSHq/pQ2+8VaBZSk2G2npPDzmJTeNSbXdwAfuXh0sFN0ZfzL0QmX3cZy4IS9FjqhIl2bo2V39lqWT0fuczTgY7OpyVl9Jc9u7YIrThUhn9Uc55m3uhgYrtNSpwuqY/6XV8jZq4kP2Lkl49Uo5Qx88YjaFr0K81FHDV0bK/2V5Z32tRD7Z7J+FX+1ZliTV/4S3+yrARya9mhXxnfZ4uHGyQSGT5+rX8w+sj7L2CY93wmnhYznVjDKQ1fgMKjbuvyr42SE46hAC0BRmWdLd6ZkqwFp5lKDwc3rW515xYTJ288jjSSr2yoyDVT96BeJX8s1HEX7J4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxsaERYaG55SmsyL2oycDh5eDZpa0lBVko4Tk01M1lzTUYra0JFRFRRRnlL?=
 =?utf-8?B?VjZRREkrUXQ3QWF0OVJESUF3dklkQ1hLOUZnS3JMMzMrRHBqdjNmRG90aUxW?=
 =?utf-8?B?VVIvbHM2Zzg2bmhWYlg3cHpMeThKcHZySWljSHhzTGZYS0tPVXlhN1ErWHk0?=
 =?utf-8?B?TjF4VlpBN0tEZFlXRXF4eU81ZmpzWTNGTGNWYzFUTjkweHNXWEp1TE9oWjds?=
 =?utf-8?B?VHZhL0lYenNaNFYzNnZqK1Zha0lkaTYwQ1hzRXBJMWRscENrOVhnTDJHVC9D?=
 =?utf-8?B?cFhOQmdvdlp2eCs1MU9xV1ZSenhVR2RtUHBKOGJMT3pBWkhzeDN3dm1OcHVw?=
 =?utf-8?B?WGllR2QrdXdvR3VYaVdjWUtFQ2RvenFRTkhOUTN6dGVqcC9ia252WURaSU8x?=
 =?utf-8?B?RURFSGpKSWZ4eEJsWnJINGVSRjJSSmVsTlhIZkpZU09rOTZ2NlhsM2VVSktT?=
 =?utf-8?B?MllnTjZIL3pvKzlYRzUrUThTd0w0aHVadUVBY01tNHZqSlBxcnFOR3ZwSDBV?=
 =?utf-8?B?ZkdaSlBvNk9uSkt6NjRTL29ZcmVva1VxMzQzeGR3UC9yZEoxYXdna0JqWDk0?=
 =?utf-8?B?ZG8zak9CVUlCc1hrdDhHTnZrbFFpU2Z4RklSZVp3dlVTRy9LS1ptVjFQQW1l?=
 =?utf-8?B?d0JkdFhVVExXalkvUWpGY2p4Z0lSWGNCSlVmWkJDTGgvd0NZWTFHemFUczI2?=
 =?utf-8?B?QUs4UTR5cmRCZXhzMXhCTGRmY3cxSVBnczdwNHowR3hHMi9ZZW93aHJ3b0R1?=
 =?utf-8?B?R2VsTGJxZWtRNjZndUlHenk4cjdJSjZXQlBsUG5YOTIyeTlXMXh6Zm5uR0J4?=
 =?utf-8?B?RGdIVkJPakZNcjdZbE52Z21yY216NlZkckJzdHJPQk54QmRuNUx3ZGhiRWdh?=
 =?utf-8?B?S2dZYzhWZ3ppSUZuRE1iV2NFMURHd2QzelJXMzVOcURjb0hzTXhNTmo3ZThp?=
 =?utf-8?B?RnB2c2hPTThVTURXT3FQOFd5NzFwMGErVTJxVjFhQlVSdXBMM3dqbWtuSUoz?=
 =?utf-8?B?cnBWL1FIT29aZzdIb1YxaUtMb0Z6WFQ2dXFRbFFVWElMU0tza3pMTVRnS1di?=
 =?utf-8?B?RkRvQ2pCMTVKSTZSVG1INHVmODJjUXhDM2xQbTBHSncyNUkzQ2F0QkNaMHl2?=
 =?utf-8?B?c0RLVW9GQXlCNGMraFZ2dWdzbmE4K2JDWGI2Tnh2K1ptKzJ1RHNJK3hPRnlH?=
 =?utf-8?B?cDRGSlczcldsLzNmTGRiSE1yL0JkYVY2NkZwd25ZeVgwU1A0M0xUTFJqZ3dx?=
 =?utf-8?B?VjNMME8rU0FYQzhoMUlhaTRBVGt5TGlVRzNrcElreUhrRjdkR1pzbzRabk1L?=
 =?utf-8?B?RTc5R094NzF6dG0vclhZQlN2RjAxM3dVeExlOU5lYXhORGlRV1VMbG5zMlhv?=
 =?utf-8?B?QzdBZVBoK0dURXl1cFVlSlBPc3VzY1dNOWdoVzZCWDViQkNDRUU5VXVrMUFE?=
 =?utf-8?B?T2RZUlhBRVFxa1JYTnAzeVkxMFNUNXFLcENjNkZnWG9DaXVQdTA2c2hRV2dh?=
 =?utf-8?B?SXEvTm5QVmF1V0hKNnZIWXVTTDBrZGpaK1FDd3B0RFZrL00raFJMS016UDY5?=
 =?utf-8?B?ZjFKRFh1MXpPUUZqQ3BaUFdsQ0ZTL3BPV0g1RlNuL0JBS1BnQU9jN0ZYL3lM?=
 =?utf-8?B?SkFhQ1QxRWxydHpHUzF0VjZPMWxsVDZQRVJxN0E1eUpoSm1yQ2VZMGxvck9n?=
 =?utf-8?B?K3Nkc2M5K0hadzJOYkFoSldvZUp3YXhiTmZramttRmRpMHd5SEJEWFJEU214?=
 =?utf-8?B?SWlrY0NXMldMbTlSZmtza0Z0djV4RW9sZnNxZGR1OVdWeDgyc1YraFBFYzY1?=
 =?utf-8?B?Wk9KcCs5enU2WkVUTSt4TldtUmhnWGwwV1lWQXRDNnZGS3pXcEprUy9NdjVR?=
 =?utf-8?B?K3pScVI0S21QV2xpa0E4Z3FnWEpxNWpwckNmNHJXL3JDVU54WnBEdXA1Zlls?=
 =?utf-8?B?RzdxcDBmS0VzRWRzOXFuU05uNzdLR283T0plUHdNK0VRaHBBRmVSUndJNjky?=
 =?utf-8?B?NzBEQTRxQVA0UkVaS2pOVTJxN2lQUGxqV0RFRzRMbTBDOUkzSW45azN6OXFs?=
 =?utf-8?B?VnlwaTVZRCtQTXhHS0tOclhCbTZsd1lWL0lDYlNhdjRrY3RHaGh4cWVYVEdu?=
 =?utf-8?B?akNQZ3pEZC9ic3FPanBWWDlnQXhIbTNBU000VTB3ZitNUk83bmxSZS9rZkxh?=
 =?utf-8?B?UVBxVFNZS3YxY3hxSFphUkZYeUxyVFFJWkd3VDNDNUtqUEs4SVZySzhJNmV0?=
 =?utf-8?B?V3JtbU1xMFpzei8vZ0p3RG9pQVNkOUo0Z3l1QzV2UkZxMDFrMnJJTDFWdld0?=
 =?utf-8?B?UEUySFhidUYwMEZoSVpmYjZVYVdkRUVheGpPbHB5Ym4yMGd5UzhkMHJHKzZr?=
 =?utf-8?Q?c0nkZBAU7fQeUN7dcCb8TcPIJp3rAJJSPTk/577/nC/x+?=
X-MS-Exchange-AntiSpam-MessageData-1: 2Z6JPPtJZwXWDA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a378cd2b-61cb-4022-e9e5-08de8af36556
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 04:52:10.9114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp/QZCkZ8txpZ7bGGPAK1ogQbfOApr6u2pmqKfc4JpQfV82shRfmh4PB+Nm6emRJcO4ZV0QqTcSXKQyj8xwajA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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

On Thu Mar 26, 2026 at 1:30 PM JST, Alexandre Courbot wrote:
> On Wed Mar 25, 2026 at 12:15 AM JST, Gary Guo wrote:
>> On Tue Mar 24, 2026 at 2:44 PM GMT, Alexandre Courbot wrote:
>>> On Tue Mar 24, 2026 at 1:44 AM JST, Gary Guo wrote:
>>>> On Mon Mar 23, 2026 at 5:40 AM GMT, Alexandre Courbot wrote:
>>>>> `driver_read_area` and `driver_write_area` are internal methods that
>>>>> return slices containing the area of the command queue buffer that th=
e
>>>>> driver has exclusive read or write access, respectively.
>>>>>
>>>>> While their returned value is correct and safe to use, internally the=
y
>>>>> temporarily create a reference to the whole command-buffer slice,
>>>>> including GSP-owned regions. These regions can change without notice,
>>>>> and thus creating a slice to them is undefined behavior.
>>>>>
>>>>> Fix this by replacing the slice logic with pointer arithmetic and
>>>>> creating slices to valid regions only. It adds unsafe code, but shoul=
d
>>>>> be mostly replaced by `IoView` and `IoSlice` once they land.
>>>>>
>>>>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bind=
ings and handling")
>>>>> Reported-by: Danilo Krummrich <dakr@kernel.org>
>>>>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel=
.org/
>>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>>> ---
>>>>> I didn't apply Eliot's Reviewed-by because the code has changed
>>>>> drastically. The logic should remain identical though.
>>>>> ---
>>>>> Changes in v2:
>>>>> - Use `u32_as_usize` consistently.
>>>>> - Reduce the number of `unsafe` blocks by computing the end offset of
>>>>>   the returned slices and creating them at the end, in one step.
>>>>> - Take advantage of the fact that both slices have the same start ind=
ex
>>>>>   regardless of the branch chosen.
>>>>> - Improve safety comments.
>>>>> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f=
6e8f3ce3@nvidia.com
>>>>
>>>> Here's the diff that fixes the issue using I/O projection
>>>> https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@k=
ernel.org/
>>>
>>> Should we apply or drop this patch meanwhile? I/O projections are still
>>> undergoing review, but I'm fine with dropping it if Danilo thinks we ca=
n
>>> live a bit longer with that UB. It's not like the driver is actively
>>> doing anything useful yet anyway.
>>
>> I want to avoid big changes back and forth. We could use raw pointer pro=
jection
>> today, which could be fairly easy to convert to I/O projection:
>
> Thanks for the diff. I have adapted it to work on top of Danilo's
> suggestion to compute the end indices first as it works just as well and
> is cleaner. I have been running into a link error with this conversion
> applied though - let's discuss that on v3.

Mmm, I guess this was because the optimizer could not prove that the
slices were within the bounds of the command queue as the expressions
passed to `ptr::project` were too complex with that version and this
makes the `ProjectIndex` check fail. I have better luck when doing
something closer to the diff you pasted.

Let me refine a bit and send v3.
