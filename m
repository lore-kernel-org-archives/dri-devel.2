Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7600F327BD
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A5F10E06E;
	Tue, 21 Apr 2026 09:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sJsbVpJI";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E27AA10E06E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVfoiHVqGa5AP/Ef+Y3vTd9Ae6YOClNKhmrQ5Jr6S/q92KU/R6wXCq6vzGVd0o5dIWjxx1nFc6rQn58laqxRxVbSxyX/Js+bCkAgCvGvERmAImuXJxIjHk2Q8QiZ9+uIM72grk5pZmRbLjDaD0TfwWIZETyQuYK1z4L4SMKf3galP+qVwJIYIjFVJ6Hh4MCyA213wObsGWxlPdTCAkhvyBbEvqX517qNg4R+D5MVmzFnG6mrGKS7n9CZPTjCMn7oRLFeI6bE+9kysoP6yt1J5ho1XfUzH8XedF5V/6JwuInS0k0DntepPVzppxwSd6IPvl5mSapQJA6YSHQPLGgp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCrAoWdenmJ9tkC4PBrBW1CZMH5qT0CJWER0IRQz4mA=;
 b=bEbHQWx6pv6tVF94I4/TQOLOOCS9Tomquw5oTN7KqjkZBnYHoUsztvvBQDq+Z1cIVViHP+Dfo5TaTE/cd3xiZN4WwLANwV/b/8mYPgXG+/Hjc0YLGspCj25YXUOn9VofcERCRSxf05rjjpXf9cFhqh5FyVGaRFruyRQWg4sC6/q0mAO9r2vuI6c+ubrtW9sXJfmgsBbQlb67SiLVL+SPg8BRWAnuojHSOQQ5EpoJLgh3O7K+7kIKkVLIU+BEN9H6v/iJxPakO3XN1M63k8TEFtXJY+IIem4YBqbJznakShhpi2br+XbuFuQfrqXvgJJX90NPuBd3a+KM9JWY1fR0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCrAoWdenmJ9tkC4PBrBW1CZMH5qT0CJWER0IRQz4mA=;
 b=sJsbVpJI0vVQYCQaCrTUIAnE1sY6p1PUdFUE/ffk0/p1XHhQMrs4ynsD6lAylw0BEXolt9riGVqsJchngcvcNldydb9Rb/VqkgCsraj/kusTLTgN3rBgxo/kwgrvtwZqIO1sLIPAELXLTYEdE6fpxy6Hs4HAnuZLCYA3mV5D3KlwRqpVJZKlhNjAUH3FDBcHlV0noTBK18g6o7PwNHBmQQZgp4tVksvidSDlfteOGTz2syZrOWh/vy4kMhvjMB1DQXnOcD25rybSlY4fy9Ouz1Vj7j/DpQZSyswgDDbOLgCFX3DqUL10/6xO04m+CBTaZ9euAtRIPWiajIlgVeEnAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 09:46:08 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 09:46:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 18:46:04 +0900
Message-Id: <DHYQJKFXZ3EB.26LTASWWWS2GY@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/11] gpu: nova-core: vbios: compute FWSEC-relative
 Falcon data offset
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-8-705d30d16bba@nvidia.com>
 <54b13fa0-9405-4fc8-ae41-fd1d310c7aa9@nvidia.com>
 <DHV30FCX4QCU.2QA40VBWESOVU@nvidia.com>
 <e1e869be-a681-420e-8a31-d9857f1c28f4@nvidia.com>
In-Reply-To: <e1e869be-a681-420e-8a31-d9857f1c28f4@nvidia.com>
X-ClientProxiedBy: TY4P301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 1479fa9d-e02c-4561-2694-08de9f8ad045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: udQZEjidtnk8ccgtv3I8hNGjarhiaeklOeBDQPZb2mpZGR0pSJwRXJgU20iQkNXgYAOf5vLMPzY+sVpWBk9HqcxOfCLUywcMl0cUgNKXmlbrYlFMSR9JGFxNbuXh1WjNlzUx2x3wwr0nCJ/sotuT7k7QEXMlU4++wMtgz/hSYxpsMI1e+aYTeZiKtM7i/1fhrsjEw5lbBD6+mXMIoBytif9vUBrcNjlFNsDbnCOfjy6Sw7SvfK21YNWHgdpAD1yYK6R8AocgIt2bV/2nbbJuBfLrJaVZ2G23H+8kXeZCuulcPfkUDx2SoaPWfmB5labdXGoKBRFpV/3unxJgkmy/U96IQxhWADDXo1dKOaPUfj84TDwc8el3hDeCnH5uzssoVTZAwKSMCSFh1feNbGgAggxIofKu6vPjmh65mVU7Y+lzVEdm6hCJy6u8ydZddfH7xk3ZuLWWI525+rIzCrcK1y0qL6ScKeDl3PJBe/Sb7tjG/y1DjnX9PgbtiXmPGB13o27vFG6/+1ap2cBLODfBSfjftFXMbufQ8bEiftOOXj9cqRXVT0jd2D/Bs0w6hwPLU0iF1GtHawMyhl/CQGP2xVjAslmpA8DKmKk5DXDMiRSe5w+ENxePMbfH0jO+HTAkMafmmt1Fxw4eqs8inMQ84bbDkrcaQs7GLqoXexODet/BfviWjHhbNkwvMjYUYzOklJKteJjxnqsSyWJhr67ULHCRwq+Znku3A5U8Y0PpRpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJOdjUvUWd5SWpndTN1WStxYmIybWMzRHJUb2dyblNXd2V0ZldrVlRNWC9N?=
 =?utf-8?B?T3kxcEZxRFAxdy9aYnhhR3NCV0tGSEFqOFcvUyttQUVCSjc5dmg0N2hxNVAy?=
 =?utf-8?B?TlNmMEhkaVJORmFwdTdLT2p0SHVpbzV3MnR0dTl1S1lqWTRoOTlFR1B3L2c5?=
 =?utf-8?B?MVRxNUFBVThHcEVYMU5NN0RHb2VaRDlVMXRwNGRGeURnY0FoWVVxaldiVEZ2?=
 =?utf-8?B?bUtPc2k5TUQwUlFiZVFqZEx4d1lybmdWNUhzVS9lWkNjbjRaV3RmQXJyOGRI?=
 =?utf-8?B?MHVZK284M2pUQXdWWWRPZ1dqcE5nYnZQdGt5aVllV2xEM3h4anhIWnQ5N0Zs?=
 =?utf-8?B?TjVOc3ZyYVU0bnQ0QjNIZERkY2tFQ3lyVGJEMFhDUG9NYXg2MjRsa0F4QTVq?=
 =?utf-8?B?aUxmSmRJbEo5emdadmh4dlVrT1lpRDA0SFVub2pWRTE1aGpYOXZuOXhCOWE4?=
 =?utf-8?B?eVM1dWp0by96aU5xcEtiaXN2TXZ0UlZsemFKeWFPQWtwTXVQSGlCRjJEMUpI?=
 =?utf-8?B?ZURwdGlmeEJwbE42V1F5SUE2ZWZLTWxkSGR3QjlwakhHOTFlcmdDRVU3b0Nm?=
 =?utf-8?B?bXZKRUlzczY4MFN5bzFsdGJyVjZaNFdSVmM4RHVwejM5WisreG9idDJOYzFF?=
 =?utf-8?B?K2F1ZGpEN0IzelRCSjJlS1BDN1g2R2RIWFdSclBJNXlpZWMwazBtQXBOeUNY?=
 =?utf-8?B?eForNUdaZ0lkaktrS21TRWlzdXJtRjRvUHlhNUVCTE1aOFJ0cmhxMW5EU0Ir?=
 =?utf-8?B?bVZESjFNRzFRSitaWG54eHhaMjZEbE05SXkwOG5nTDF5NHF2Z1JIcFJzbW15?=
 =?utf-8?B?OE1WMTJ4MEZaMnpseWd4WVlsMDRTTXhUUkZZZXc4cWdJaVZoUmNGUTU0SXpT?=
 =?utf-8?B?VmpWOTJySFMwcXZZZ2tZeElweVlnNkhocDhrVm1Sbm01d1I4UmxDaWJjQXV3?=
 =?utf-8?B?M3F0WGFKWk5uRDhsblk4emJ3Z0R3b3dTNlExYk5pbHU0c1RLcW1BNlJrV0ZU?=
 =?utf-8?B?S1d3dWVDbFRuaDZLTldGTU9ad0YybG9zdzRIZjZSSEVHc04wR1lFVDdxb2Ix?=
 =?utf-8?B?bDhuMVhkUGQvcUZmQWhqdFdaWFVDbTl2dkxpRGN6WVBUVm9ibVp2OGI2QXFv?=
 =?utf-8?B?d0VNRmRmcU94STFzaDg4TlI3WnBiVGZhVGFpZkQ5b2YrVSt0WEIxMjQrbEhq?=
 =?utf-8?B?RGh3Z09YWFdRajJDclNxWkRROHBHN3ZSbWFSd1I3amlBYldMOCtmUDMzWE1s?=
 =?utf-8?B?cHNTdytacjAzRGs1MkNHd0NlenpMWlNKRTY1c3hhV0F1ZGNkTWZKN3BVV3RU?=
 =?utf-8?B?cHNBeEF1VWtwRFIydldzQjZPekZ0ZGh6S1h3MTVYQnAxU3ZrOXJneWRDZGtN?=
 =?utf-8?B?bnBOeXk3dzd5UzljNHBhRUhGK0t3S3hLKzZHWjJ1UTlkUTVGOGc0QVB3Tk51?=
 =?utf-8?B?WHorMEF6QkkrenZ2SFdJRllwV0wyZkR3Q2RCT2FzbVYxb2J4eEp2cXVDQzhJ?=
 =?utf-8?B?TUpMdzdlQXNNeldqSmpLR21adHdnZnVnYVBnajdDUVFZV1MrWEs2UDhmbjFX?=
 =?utf-8?B?QjFMQ292ck1GVmJyczBMZElBUHJMR0pRTkJhd3VHaVdVZE9mejZNdysyNWFZ?=
 =?utf-8?B?WUlVcmRlTE9GdUM0UnVEd2pWbnBmeDU1VFhsWjIyaFhwdlU5NkJVWG12ZHRk?=
 =?utf-8?B?aWNBTnNac3BCd1YzZXd6QWRhaURQSnJNWHJ1T1VDTkw1YTJmaEhrZzRrdHlx?=
 =?utf-8?B?dWpnZkViODhTOEg0TjMydlFIMU5uNHQ4dmxvNTZkSE1wNERuKzBFT09BMUtH?=
 =?utf-8?B?Ykh0Q0dQL2s4YjdOYWFrMmlZMHNRR1N3cFBsbVc4azQzNkpWNkpXNWw3UGNa?=
 =?utf-8?B?RUdYTklqWktLQXBEcVVKK1VuV1JuZitQZkUwaEZybzlyZldieTZONXR0QlRv?=
 =?utf-8?B?S0F0NUJjOUNyRjVJM01tU2k5aCtKN1BuNUh4OFdsMHhERk4zeXBWdlp3Snhp?=
 =?utf-8?B?WkFFd1dtWGVOTTQwYkVEaWxoVy9peGk2eHE0bkk2SnFZWFUwSDkzRFlwZmE1?=
 =?utf-8?B?VjRTVGVVcGxMUWE5eXpEVi9OY1M0TVAvdDdQRUh6YnVnd0g2aDdQV2VtdkJN?=
 =?utf-8?B?WG56TWJRWUlralNCcms2Y2dFQlZBZjIwalBIb2lkdXJUTGRlaldma2ZxcnVR?=
 =?utf-8?B?OWt4SnBzb2hNeVMvejc0T0I4ejJQaUdWS2M5Tk12SnFZNE1VY3hiMk1SYmNF?=
 =?utf-8?B?QzRUcmsvZUVzeDViL3BMMTJFc2E0VVpWTllTUktSY0VZMjJ0QnRkWklhb1By?=
 =?utf-8?B?dHc0a3MrSENEdmplL20xS2xUSlkzREg5MjFlbDY4SkFIaEdycjR0YUhTRHVk?=
 =?utf-8?Q?Ix+htRIIvk9NGsa0DAp9r4UUSVWrXlo2wrZBvVtc0kb4g?=
X-MS-Exchange-AntiSpam-MessageData-1: Sx2pjShurd5Brw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1479fa9d-e02c-4561-2694-08de9f8ad045
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:46:08.3143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SAh/WYw7KS4QH5u8vcSu6aMDVksstubR4TBHYpsleXzipm8p3qBwRBowCoXQtL1c7t+WaZGHObGufkzrTD3uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

On Tue Apr 21, 2026 at 6:46 AM JST, Joel Fernandes wrote:
>
>
> On 4/16/2026 10:41 PM, Eliot Courtney wrote:
>> On Fri Apr 17, 2026 at 1:13 AM JST, Joel Fernandes wrote:
>>> On 4/14/2026 7:54 AM, Eliot Courtney wrote:
>>>> Push the computation of the falcon data offset into a helper function.
>>>> The subtraction to create the offset should be checked, and by doing
>>>> this the check can be folded into the existing check in
>>>> `falcon_data_ptr`.
>>>>
>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>> ---
>>>>  drivers/gpu/nova-core/vbios.rs | 48 +++++++++++++++++----------------=
---------
>>>>  1 file changed, 19 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vb=
ios.rs
>>>> index 01f65d50cbb3..0c0e0402e715 100644
>>>> --- a/drivers/gpu/nova-core/vbios.rs
>>>> +++ b/drivers/gpu/nova-core/vbios.rs
>>>> @@ -765,33 +765,29 @@ fn get_bit_token(&self, token_id: u8) -> Result<=
BitToken> {
>>>>          BitToken::from_id(self, token_id)
>>>>      }
>>>> =20
>>>> -    /// Find the Falcon data pointer structure in the [`PciAtBiosImag=
e`].
>>>> +    /// Find the Falcon data offset from the start of the FWSEC regio=
n.
>>>
>>> The comment change is incorrect, this subtraction is just for normalizi=
ng.
>>> It basically normalizes the pointer wrt the PciAt image.
>>>
>>> It is only after the following in the caller that we get the true offse=
t
>>> within the FWSEC.
>>>             offset -=3D first_fwsec.base.data.len();
>>>
>>> I suggest, let us rename falcon_data_offset() to
>>> falcon_normalize_fwsec_offset() and update the comment above.
>>=20
>> Thanks for your reviews! W.r.t. this, my understanding is that the
>> layout is something like:
>>=20
>> PCI-AT | Efi? | FWSEC | FWSEC
>>=20
>> And that the falcon data pointer that we get out of PCI-AT starts off
>> like this (indicated by ^):
>>=20
>> ^ PCI-AT | Efi? | FWSEC | FWSEC
>>=20
>> But the actual "address space" it's in is:
>>=20
>> ^ PCI-AT | FWSEC | FWSEC
>>=20
>> Because it doesn't count whatever images are between PCI-AT and the
>> first FWSEC as part of that space. So by subtracting the PCI-AT size, we
>> convert it to this logical space:
>>=20
>> ^ FWSEC | FWSEC
>>=20
>> Based on the above understanding doesn't it make sense to say that
>> `falcon_data_offset` transforms the pointer to be relative from the
>> start of the FWSEC region? Once we subtract off the first fwsec image
>> length, it's then relative to the second FWSEC image. Please LMK if I've
>> missed something. We could also emphasise in the doc that the "FWSEC
>> region" means the contiguous region defined by the first two FWSEC
>> images. WDYT?
>
> You did not miss anything, your explanation above is spot-on.
>
> You could also keep your function name and add a comment on top of
> `falcon_data_offset()`. Something like "offset from the end of PCI-AT
> (i.e., the start of the combined FWSEC region)". Sounds good?

Yerp SG. I realised I sent the next version without applying this
feedback, sorry! But I do agree. I think we can strengthen it by saying
the offset from the /combined/ FWSEC region like you suggest, and maybe
mention that there may be an EFI after the end of PCI-AT.

thanks
