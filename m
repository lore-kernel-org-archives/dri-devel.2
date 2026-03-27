Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C9610AB832
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE62F10EC23;
	Fri, 27 Mar 2026 00:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZFbhNvtm";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF1510EC23
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2k6xEU5e3xA6FY76at0wF+HkjddTGygIs5ed1degHtD573C8O+8NaXrlqjxFHBp9P6nrT+WbSoAMqvHY4PNIfCbN/7vbvi9rtEqhxJUnUib/kSxT6RGuoU1GRTwoHwIYcPoMsv+S7bh7+sCpHU3Cq6BPZEEusQoPorXH1dxzZtEKjapYfL1XvEXlXj9/JitR0tatecUekaTfPH3bqcuygXeKGELqgBJLMuJn/1/uyRuDInVrLp+GuxvdhJu0dSgsy/kOCaYJyxnr4NSYbPSfa4Kn/YZixVyXIZTc6wFDXg31oe70vqeytb6fJNlNxp7+2vdFKuaoFoIw8KVEP3m5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCFO3204hvl/3N6d83jZezZIF+VbkCr6ETrg3vxhS1U=;
 b=B+w6L/hQyijxPl8KGW4wF53bt5SdNhjjL5Rs6NmCOSxgKG7VRNpObjLb6SU9Ut1M7XLD3EAqWVxWD81Yik/CC/yMTnvQXT0DISGCaoh6avkcgtIPqQ73+TD/V4v8GznRpfFQ2dlku1RY/uXZo0B6swiDl6AwJn4+/7GHO8/rBZ6Y7dEeOed+1y8NGPDSXcYuULomOiuvVZczKrboqvEA0DZcamCiip0qk5MoDSyw5ojlwSAHaOeRFYf+7sQb0I6yTlvCkV893G+AQeuKEFh8oI6KdFSFf5bvVYDM0Yi4vmh82B4lvPHpFLQhK1XtUvR5skebOh8fMRneDuGDk9jeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCFO3204hvl/3N6d83jZezZIF+VbkCr6ETrg3vxhS1U=;
 b=ZFbhNvtmFEF9CwTjWPguD/wzHlJ5sUNLhJoUwkhBcqRqStyQv446J3iPXQBVEyGpaT9Sg8vG+rXgZYxn9sfMHTwYyczJ9G5dCcg6sZo04Q54aeN3XFGvL3aZ1r/thgCI5sUFaQuV8DXSG3NSe+d5SQhuet0vlmNwFzinhRSOtNBxsn9kkw+yhERmGPsDT6KBtYFDiHTK61QKvRPB6gy8o5oCNQprode7uMsuU4TotsV3ZIOOKyQfJWdtk6F2jhpul7BY9DgUdWOnEEhkT7MeTFdv8LF37H1loi1QeGF5ezJ85UxG0JDLP90ydDK+ZDiY3abF7plmHusmf5yNXYtY3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 00:47:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 00:47:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 09:47:40 +0900
Message-Id: <DHD5FQ1O1Q60.1C2FZI4A85PQ2@nvidia.com>
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
To: "Gary Guo" <gary@garyguo.net>
References: <20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com>
 <DHAB9Z571FPB.25927BK1RGNGL@garyguo.net>
 <DHB3CGY1Z5HF.1KSJV8SP8YD8A@nvidia.com>
 <DHB40HKJD3OC.OMC04LASMS4G@garyguo.net>
 <DHCFJSHKE4ZB.3M1FFI3K5R670@nvidia.com>
 <DHCG03J1G63T.1A973DEM7DHQ3@nvidia.com>
 <DHCP6NB4HWXT.2L5XXIX1HNPRY@garyguo.net>
In-Reply-To: <DHCP6NB4HWXT.2L5XXIX1HNPRY@garyguo.net>
X-ClientProxiedBy: OS0P286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9d::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb41cfd-200a-46f1-c014-08de8b9a75d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pM2tWgx9WVX8aOUQP0zoyQREPSYe4U9cT+2OIfVODwblV6u3401rerrlia1fbkb4QSBFQlwDtnCo9EkqOc9WeCmsZCgHJvcaybnSb0rDU+ar6FFtsLmuDX4qw6iNzQqlSUwRDiGobcsrrE/Ax1Sb8DB7To3l6wrWyh7FJ0mHjp915gkkC5hq0WLTVoM/uPBSPIpAactjzwBxnpyagVhOAMEUY7VMCrQ5R7dgOAjk6S+TahC67JAG+kGoNW1d75hyCXWc7SOh2HIudMNtVhdNlHZQlpzrel1lTuvuRwtMLgX1JPLYs5yv87kjV4KKFLWJAJDaPog2lvJHZGAGYGdRPqrEZ3BczPXHwe2Y2kzo/qI5zPFs5LlNqGAYCDfZllaj1ZGoJ7RElzCiz5OAxabCO3gOqmbwZzYAiBaQ5r2PPgWOplIGk3lx/lIq04xzvzz7PN36AYMwJNSyMlrZVO/lDnMJ0LVMHzf90rYJjlRIE7HXpBwS8mYCw76bytFTgBAjqaVXbl4JtqQYqFY/Z+J+0bLGkA2AxhaqolcosX4GU0wE8c70YiY9nTsaxe6rvn7weM82fs8REVarZQs8tLjxDUC2BD58jQoxK2zLWg7SZ2fKE1liZZZ1UTAV0AY4pF9lR/SEBXEH14Z9ArdpC7z9xJ13MvBwvNUat97xmt0P86TIm+T0JCLERHgiE7PFNEUWqEBTk/k3DXgaP6b1rca91oHLKJs2hIikatsvP8y88R4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUxxbEx5dXNJeDMyRi9VZ1VpNm04bzRvWC9UTzNsTHIrZGROSURJcWRRcjhw?=
 =?utf-8?B?MjZUR2tBdEVZbG1GTGhEbDZRQldzaWFrTnB0NmdYWmEvcWJ3L3cydUZvL0JG?=
 =?utf-8?B?eTdhUGI1d0dPV0F3dFNjZ29reUJXL2FzMEdSTkdvdWR0R1cyNFI4K0pyM2s1?=
 =?utf-8?B?QjRVVDNjTHU0NE9VUENKWHI0aGVBT3hkVGxsa3g0SzV3NFVnR2t0TEpmZ3NI?=
 =?utf-8?B?dS9jRm14cGdQVG95T1lhRVhIL3pPM09vekhLNXZUVlBuOCtvTGdOZWpsTmVL?=
 =?utf-8?B?Y21SSG1MMnozOUs3a204WUp4ZnE3RlpDTW5mRUEvQVBkT2E1QlFjczVSSEMv?=
 =?utf-8?B?RlZ3S2V5OVpnSTNacGJJVndpSnRQT2tuSDlqeDB1bURiWklZY3V2MXhLYXd5?=
 =?utf-8?B?YjlhVk9XZ01UTGtBZ0U2VjlBRHdEd2dOTGlaZGZscDJZVE5XYkpENUZ0S0Nh?=
 =?utf-8?B?ZmlDTWxlVjU4RjU0SzdWc2xMektLY2UwTnF0RmJEWHRQR2xjSnN3QzNHMnZy?=
 =?utf-8?B?dTVrcENQckl6RG92bGNsbXl2U2hiMnJEd0RzUm9qVXptZTZybTdlL0l6a0NV?=
 =?utf-8?B?NmR6blVJTFQzRHlNa3dURlhvY1dRazh3RHdNL3dCeHAzWk5JKzVqNUwwWWQv?=
 =?utf-8?B?VWV2UlBUV0ZvdWRpQXV1ZzlKNmp4UHNXNWllZlEzOVNkemNoVWVoWmIzTS9o?=
 =?utf-8?B?Y1hHSSt3UVdJQ3JqcFpHSU52Q3V3U0dkbmRnMkNxWmJlcnVkZzlnLzIyN25U?=
 =?utf-8?B?TElkVGNmVUhiUVZWL2Vsd3BMY2ZkRXN0SlFPdDFBcDBqR09HNzhyWElYVXh4?=
 =?utf-8?B?K0RtQ0wyTHI4MFN4R2ZTVW5sU1V3UmhxR3Fqak11QzhpUU1BaXNGczl5c1dS?=
 =?utf-8?B?Yy9lUTZGeGNxV3NIQXZUbTdIazNxQ3NDRm5oeTQ3UTdXbDBBS1NXVGxxallt?=
 =?utf-8?B?VUswNTdQSlN6KzFVcSs2U2N4RTEzeDRib01NS01BZlVQQ3k3WEFpZmZBdXZM?=
 =?utf-8?B?TEhISGhNck5NQVBVY1Y1dHN1ZlYyN1ZkdEdzWFVRaHdrZXNiR3crS2ZUWHBt?=
 =?utf-8?B?WmZwSGU2UEN4NG9mUG5IcVI4OFJRcVpHMUxjREFSdFRIaGFoTndKWi9wTTUw?=
 =?utf-8?B?THMzLzZMRkJINGlheE5uZ1lUK1BZdHVsamphbXVoKzd5MFBZZVduUGo5QWNK?=
 =?utf-8?B?NU5Od0dsUkM5WWcrZFpVNlRwU0s4bEZBUi9WQmZTOFlFeGd6TnNmUHErVFIv?=
 =?utf-8?B?TW81TnlLR2JoUXpMdTJ2T055akNqUWt0OVhTcG1iNm81bTd0MmhmWVNzZ05t?=
 =?utf-8?B?L2dMZHQ4aElHTTFpOExoanBKNjZ3Z3ViZzhSUmJpemhyTDJHR2xLaEJwQXpV?=
 =?utf-8?B?Wkl1WWVvTERCM2lmV3ppZlJwbUxkVjcwc21SbXhmeXF0Q0YzVXFpMzFKZU1i?=
 =?utf-8?B?d21JNmxKVWNuME5QVUZZbVRQOTF5c1E5aUNESzA4QjJyVWxoVEl6dUpMVFRD?=
 =?utf-8?B?OUU4OWVWUElndEJxbWZEU1k0LzQxR3RJTTFzOTZuN3lXWWltUDR0bFhwUkpx?=
 =?utf-8?B?SlF6aTVsUk5GVVZPOUgzS2dPOFhwWDdXNG5zR0IyTFQ0Z3FPV2Y2UnpuQlFB?=
 =?utf-8?B?aVNudTNpMmcrSXRpN2ZwUUIvSzlmZTJZazhSbGpXaXBtQzFRNGFzdTdiZldO?=
 =?utf-8?B?aGxXbnFxUHhqREJhNzJUVUxkWVJnRmxXNUVNMTMrd0t2bFhLSVczOXRPclli?=
 =?utf-8?B?SXl2S0ZwR20vOEhWNWcxbCtDU29wV3IxN0lNdW5ObThuS0FXbjVFYmFsS25u?=
 =?utf-8?B?M0g3dTBnb2RwWGF1RFpvbHI1UjNVZTdvRlpEZ1ZGVDJmUjdnR25Sc2dxd3hw?=
 =?utf-8?B?UGxxT3V3UW5zTWY1Y29Kd2xzYmJiUndWeHY2cnpWaEc3bFFxZDJSSERwSlZw?=
 =?utf-8?B?WTY3S3NaSzZ2Nktyd3YvenkrVUdtVXQ1TWY0bGdoNmdCRXF6TkJHUERHb0lv?=
 =?utf-8?B?S09IMC9rQS8zUm5wL1o5QlJHbmpPRjZrM0psWTZVWmlPTDhKNFlEaFhPREtR?=
 =?utf-8?B?RDAxdzZ5R01NRmxSVVREQUJhYWd3dlh5ak5PR0JQSG1ncktqMWZnNHk1cm1o?=
 =?utf-8?B?a1hzYTNYR2lCc2VGenN1cHhkdXdYaVhwWktOMWhGTXgycDZjY2N2SVUwcWtY?=
 =?utf-8?B?RDdySXpIbExWQlVsSG5rZWtQSFBkUXZpRHRDaXg1RjV0STJqaTQ2OTlYYVhF?=
 =?utf-8?B?d1c3ZUo4bllZb2ZxZnVNQk1hajZGOFpYTkN2a3hIcHJuM0dOWFRVS3FieVk2?=
 =?utf-8?B?WVRmYUhndlpVak9tbGRVL015SnBvMGVLQUJ3dElDcjh0U0tFUUZCRURENHp2?=
 =?utf-8?Q?Q0eSiiA4+uSaBipgastMZtYgS2/i4JllTZsUdfDtnTq4I?=
X-MS-Exchange-AntiSpam-MessageData-1: jNu9zRVZySSCkw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb41cfd-200a-46f1-c014-08de8b9a75d1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 00:47:45.4858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9W4JVt5Z3U7F5wTQds/xLjkw39Hx9DKWn8enVL8cI1iz2IU429xD++PhPmoqO5W5Ju9vBwjw+F8e53O+67oNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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

On Thu Mar 26, 2026 at 9:03 PM JST, Gary Guo wrote:
> On Thu Mar 26, 2026 at 4:51 AM GMT, Alexandre Courbot wrote:
>> On Thu Mar 26, 2026 at 1:30 PM JST, Alexandre Courbot wrote:
>>> On Wed Mar 25, 2026 at 12:15 AM JST, Gary Guo wrote:
>>>> On Tue Mar 24, 2026 at 2:44 PM GMT, Alexandre Courbot wrote:
>>>>> On Tue Mar 24, 2026 at 1:44 AM JST, Gary Guo wrote:
>>>>>> On Mon Mar 23, 2026 at 5:40 AM GMT, Alexandre Courbot wrote:
>>>>>>> `driver_read_area` and `driver_write_area` are internal methods tha=
t
>>>>>>> return slices containing the area of the command queue buffer that =
the
>>>>>>> driver has exclusive read or write access, respectively.
>>>>>>>
>>>>>>> While their returned value is correct and safe to use, internally t=
hey
>>>>>>> temporarily create a reference to the whole command-buffer slice,
>>>>>>> including GSP-owned regions. These regions can change without notic=
e,
>>>>>>> and thus creating a slice to them is undefined behavior.
>>>>>>>
>>>>>>> Fix this by replacing the slice logic with pointer arithmetic and
>>>>>>> creating slices to valid regions only. It adds unsafe code, but sho=
uld
>>>>>>> be mostly replaced by `IoView` and `IoSlice` once they land.
>>>>>>>
>>>>>>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bi=
ndings and handling")
>>>>>>> Reported-by: Danilo Krummrich <dakr@kernel.org>
>>>>>>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kern=
el.org/
>>>>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>>>>> ---
>>>>>>> I didn't apply Eliot's Reviewed-by because the code has changed
>>>>>>> drastically. The logic should remain identical though.
>>>>>>> ---
>>>>>>> Changes in v2:
>>>>>>> - Use `u32_as_usize` consistently.
>>>>>>> - Reduce the number of `unsafe` blocks by computing the end offset =
of
>>>>>>>   the returned slices and creating them at the end, in one step.
>>>>>>> - Take advantage of the fact that both slices have the same start i=
ndex
>>>>>>>   regardless of the branch chosen.
>>>>>>> - Improve safety comments.
>>>>>>> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f=
9f6e8f3ce3@nvidia.com
>>>>>>
>>>>>> Here's the diff that fixes the issue using I/O projection
>>>>>> https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary=
@kernel.org/
>>>>>
>>>>> Should we apply or drop this patch meanwhile? I/O projections are sti=
ll
>>>>> undergoing review, but I'm fine with dropping it if Danilo thinks we =
can
>>>>> live a bit longer with that UB. It's not like the driver is actively
>>>>> doing anything useful yet anyway.
>>>>
>>>> I want to avoid big changes back and forth. We could use raw pointer p=
rojection
>>>> today, which could be fairly easy to convert to I/O projection:
>>>
>>> Thanks for the diff. I have adapted it to work on top of Danilo's
>>> suggestion to compute the end indices first as it works just as well an=
d
>>> is cleaner. I have been running into a link error with this conversion
>>> applied though - let's discuss that on v3.
>>
>> Mmm, I guess this was because the optimizer could not prove that the
>> slices were within the bounds of the command queue as the expressions
>> passed to `ptr::project` were too complex with that version and this
>> makes the `ProjectIndex` check fail. I have better luck when doing
>> something closer to the diff you pasted.
>
> I'm considering switching the projectiong `[]` syntax to become panicking
> instead, given that the slicing use case quite often is indeed hard to pr=
ove
> (and also, we already have panicking comments).
>
> One option is to just change `[]` to do that, another option is adding a =
new
> `[]!` syntax to denote panicking projections. I'm more inclined to just t=
he
> first one to keep consistency with Rust slicing syntax, but the second on=
e is
> okay to me too.
>
> Thoughts?

If the slice's validity is hard to prove, then the caller should
probably rework their code towards something simpler (like we did with
this patch). Allowing a potentially invalid slice to build is just
inserting a kernel panic mine, and as you might have noticed from LPC I
am not a huge fan of those. :)

I think hammering the point about slice validity in the documentation
should be enough. We *want* build to fail if the slice can be invalid.
