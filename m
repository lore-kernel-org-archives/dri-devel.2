Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973F3F46456
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 11:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC3E410E4BF;
	Mon, 16 Mar 2026 11:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pKAIA0YB";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F84C10E4BF;
 Mon, 16 Mar 2026 11:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5jpema5mIIACecE7ov0xItuTZ3ejGkCLy594NfFXLLTbutBK36NfM/mBvE3mnGVgvoso6JaTcx0VLJLZbchmvMDRReWxinFcxeTfZ4dDkRHO+i89GaVQQ6pjx3Qvue1xz+cBVXtp852HoTLFs6JxpZNJEjhP39GWcBX/BpTxGaaof5RWPTsSY3/MQDjoikOLNtkfNdNRad+jeaU+UXkU62rGUWtrU47pmSScgthM0OEjrRkgQIvRZeKeMH8AdYDFviveK69xieLJQaGep4czGbDY0FaG9rtYBw9beXOm2KDWpr0ZtdJsGdRHGnGu5GEm5bPOUdipODyM6IJPkHXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6qqhZo4K8WFmY6HJPlKjJ+Av9sK5YoXORwE6lC3IeI=;
 b=b059mf/UWibhDZSNo+ki4fL9azPzxlqnpAc4sLoEMasyh1tLwPZWRp4XX8AbPpUEvmI17Rme7LRkdWPRJRD11uB+6g9ANszQ3OHsoNdyvUmRMNj4igjWQb/fGE75EDBseFKH+zOEWBtkhojuoNpd+eNly++JObXfDTY1lH+5bKIsOELgQvdw+IXMQsmk78KbYtAsd9jUfJGW/v26nGBn/q1ISMjXcgW9JL70gS7lKXkOHpsIww2YRC+rYPKFpMjbqqEC5otcG3N9uomOIgjOt2QS1wKXK7SBlqmXWjbLPin5QLHCaLijlEe5ze1S87XSQwOy0lyyPG3RVMVrZTCRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6qqhZo4K8WFmY6HJPlKjJ+Av9sK5YoXORwE6lC3IeI=;
 b=pKAIA0YBZwowvjTTRIy2TYS4TICbtEZNk0xJ5+aJioUBUi/WeKpMFYXmntC21UK/cnNYFqsYz6TIN9p6kfDdDhLGgszB4eJM7i4WeDxEUg1mWWHNy0Dvs1xsIdkyZ5NHfzExefdUU3qc3mN6TPiWWJr8MzSVPhnrvQMKGkP0dnItUBlnIjXGIAzRtaU8oAOeatIu2/ebweCS8lUalIAefl88bkOBH/DFkWU/DgRzX6riUhcdRh0TYXdL/6mdMCuM8eilC5xomDuTzR+YEexO9HHl8sJKU4V5C5xN/fOwLmktzxCwVq+IP7crqEUZHfBUBvBq1C2C0/QkgzK+sLfkvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.12; Mon, 16 Mar
 2026 11:42:27 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 11:42:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 20:42:24 +0900
Message-Id: <DH46H12EEO1D.15SP7TVY8J12U@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 5/9] gpu: nova-core: gsp: add types for RM control RPCs
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260227-rmcontrol-v1-0-86648e4869f9@nvidia.com>
 <20260227-rmcontrol-v1-5-86648e4869f9@nvidia.com>
 <0bdb9aa3-976a-45ec-91cc-0f5396a69fe3@nvidia.com>
In-Reply-To: <0bdb9aa3-976a-45ec-91cc-0f5396a69fe3@nvidia.com>
X-ClientProxiedBy: DM6PR08CA0042.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: d848a27f-56f1-4cc4-509a-08de83511925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: RE4g3mmhkN+HyT1CLNlX05LU6PMv/AA+c91soZcaA1zDE4bLds7HFiXXCxvv0aemxAu+EEKMxruVSTTqJMQhDuAJ/NhTN1oaiOz3widwWNTAUgIH6nTGxlTldYPEHe0dwbTKb/Wy+Jb0whF9eXn+uztiNYuecHF0fDbAO3tb+Q1SaX7jqCVsEbHd/yfqh7X7l77FeEQUti2MWem7yIOAWOIYooctxQ1jAqyOiHZC1NCtLLuJ1ICgVmB1lZQU55W68Ln4sabxhzJfLWypjjjugMjW1Pl77aJ4EZ78jICo+xpXcQdXRMy6vMgaSagEVDWYAJb51kQvjITSil+cy9i/v36llZfipQedZQYh82CIz8h5qH4d1f2aEAQz+Qim+PoqwNrNUVMLkDc0MpV8sMAigteBrRFiyjHjh6vFtqPe8LlWEZgAaUUTKadPBLDVLbvBDB025ktoAi1G5LYbOLrMv9Im8Jcdz+61wsoUCFu/Y88CIvscK4J1okh53M22YyXpbqMq85Iym1T1x13XYqP4hVu5IBdFB5joMt829ZogLofZ0kOTenHZncZsuVG1KiPigymXwEWmjuNTmFQUXOg2Y6WL14ZI5lTild/MH6xPGoQ/xknlVuymWdd8TYpC1jeAVGEVYSC49N6NczVUBr3EJ4mxD91M7RwO/r/zXyBhMdKtD9uXBTPFo0xAVK8v6WpdfXWp4QRkr2UEYhUX0E9lPJ5CuwQqByx+XIA1w/vCLJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RURGQndFaFJvanYrdzhWU09FbnFXNWVWaktEYTJxSlZFOC9PMUpKRHNyVXNX?=
 =?utf-8?B?MDk2QmhpLytTT3pVazdGMzlMU0R0amVaWVZBN2NsM002YW10R0g3SkFjZFZj?=
 =?utf-8?B?dU81ZlphUC8xWlQ3N0JRTUF3Z3FhM0ZlcTh3Q2hJcUw4TEN6cTZsY1FLdFlr?=
 =?utf-8?B?bXliSEtHU2tPaG1Ia2tUemV6bVdHb0VnODkwT2dmWXdFZkE2YzBRV1M2clNU?=
 =?utf-8?B?Y3Q3U0xTZ1ZrTUVlbVVSdzU5aW1MRzdGak9UbkNhdWVEK2lKdk1nYUJXSzBl?=
 =?utf-8?B?TWdLMzl1Nm9rdEM4ZXVEMDk4SHF0OEI2K0lRUDBjR1BvS3Y1bUIwNVd1YjU2?=
 =?utf-8?B?Y0MzU0hocXl1OGJtdHhzT0p2eElEcmg3MW1mZURZYVFEL05hNDN0dEoxbUo1?=
 =?utf-8?B?ZDVMdUJMQ2t5Z2VEMlhNSnRES3hCcjY3d3BrTGN2R3N4VjhiV1B0ZE9YWUM5?=
 =?utf-8?B?dUUvclNyM3dMWFE5WW9MN2NZbVc0ZjQzalc4Y2kwOWtxMU9qY0tpRXR5Sm9r?=
 =?utf-8?B?TkNjb0ZzdlZxUW5rZFEwM2FjTVpxckFyTXBjSEpXeGRVbjZ0Z3R0dzA0L2NS?=
 =?utf-8?B?VkRmWXhCNE9NeDN5Zmk3WHRJRmxLVVBZeWpFQWx6em8wcDRtN3ZBa0FPTzBE?=
 =?utf-8?B?UzRvTlcwTkpsandweks0RlhTQ0RQU2tvOTBVM0I0cWFkb0J6WHhkZWpPeml2?=
 =?utf-8?B?YUgycm92dUlsTWZPSmxSKzRnbTVOMWZYQklwRVBGRUNpQ1AzWTVQNDgvM09m?=
 =?utf-8?B?VmJueHZTMFFoMzl5akd6Z2laR01Icm1JN1g5S2k3V0F1amttOHZPbVIxVk8r?=
 =?utf-8?B?N25WakdaWGlaa0VCaEhuVXR3TW5oYUF5SWM0WVRMUlY1NWxCUnlzZFVqZ1Bv?=
 =?utf-8?B?b0p3K244b1BOanBXMUlwNWVCQzRTTDkzcmdSdTdQaHM2a3ArMklTUk96YTdu?=
 =?utf-8?B?RnhyQUhOU0RnV0ZUWXMycmx3Zng1WDg3dXZYbWNNUkdHUmNvZ3hsVlc4SlFL?=
 =?utf-8?B?VnlyWDQ5b1ZBTjhWaENta3JMS0c0aUVSNUFvQnBzTnN1RDZ1SzdiYVRqREc5?=
 =?utf-8?B?QVdwa1hEVUYvNU8zY3QvZ1VmVnRvdk5oQzM5eVI3a0kyK1JhWDRXdmg5N2wr?=
 =?utf-8?B?WkxpNGw3L0g5dURvZUQvRC9jVzlPRkR0MEI1Vjk4eGZ5TVRUZktMSndLN0Zr?=
 =?utf-8?B?THBjR3JjSjhldTNLbmFycytoVzdlVi9ZczRUbVVvdTJaclNtRW5BMHdKa0dC?=
 =?utf-8?B?bG84eGRzNVNWU0RIT0tFOTZKMkdseVUwQW9PZW8yRnFWdjhjc2o2eEtMbmVQ?=
 =?utf-8?B?Ujg1aVR6QW5PcmtRSW1oOHRLVUovRVdwenhZZC9zaXlUVWVyKzMxNFlESkFN?=
 =?utf-8?B?aG0yKzk5aUZNNkVrTE5wc3pXUjgyTkx5aVBDdDlRMzlBd3RDMndVOFFGSHR1?=
 =?utf-8?B?RE5UQTJHUHh1RWM3VmNLMmlDYW4rWU5YMHkvRFJMOFY1VCtYVEhkZmNMY01Z?=
 =?utf-8?B?dlVrRWcyaDhFRWdCMTdxS05Db0JtcW5sME5jQjJLV2RjNHdjOVZja2YyeUpM?=
 =?utf-8?B?ZytZOVlMMU1lc3BsWUhwTk5rcCtNN3dzWk1iQklscEhzbXhQWmZ0b3d2OHcw?=
 =?utf-8?B?ZDNoRXR4N05yczNSNFc1Y3VVbUVyU3ZpeXdnWHpNeGFuV24wTGNNT1E3NUFG?=
 =?utf-8?B?MlMrNmFEUkE4YVlmRXQ5UVlTOGtQaVFRTlZvTkUwb3Vkd3FSaUZuWnIwZklh?=
 =?utf-8?B?TFVQT1ViL2VCMGF0KzUxNnREWTZyakd5S0FCd2tPaEF4ZUtwcVptUjBuMitr?=
 =?utf-8?B?cjBUQ0hRc2JyTllrM0F0djA0UG5FY1Y4TFJ4bi9ENUljMytCbitIcDBJWWlX?=
 =?utf-8?B?a3RSSHpiSnprbmRhV2NuYUxsTEdGdkNhK2hUa2gxUjl6TkFhMDFnb0pQZWFt?=
 =?utf-8?B?ZFNNbDZYZzN6ajg5L295ZjFVSWFuMGhLMUpacW1pd1d2NkVoNHZ2d0ttOGgr?=
 =?utf-8?B?Z0wxUkV1SEx0SFZZejFMSUgyRi82NUgzTUxkUXJMWVY4QTkyTzRIaWRick5m?=
 =?utf-8?B?eng4M1E1dXlIakVudGF1aVdKZWs4Z1ZpeTljZHg3SEI0bG9XRVZIYndvZk4z?=
 =?utf-8?B?K0ZMbWFtQ2NJc1BrK3g1WFA3NkpwaHRGVURWNXhRMi9RYld4SFhyM1JsY3JQ?=
 =?utf-8?B?UUJwS2gyQ0hXV3pmTC8xT29PblVvY0Y5aTJCdWU3allQTHVaN01vU2ZwMGda?=
 =?utf-8?B?YVJoU01MaDc1akJNQ3UwQUhwWjlYdzFBYThGRWNNS1U4ZFExVmRKMkJ2R2pD?=
 =?utf-8?B?b1ZMMDRBME5VbFNiQlhSKzdDbG1aMHdPQjNGR01iUGJLdUNVaGEwUDNwbGto?=
 =?utf-8?Q?PjTNPk1OTC69IBn1lYMMm/OtY+2vJFxtBLnnTki/HPvdi?=
X-MS-Exchange-AntiSpam-MessageData-1: J1D0BNg123DPGw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d848a27f-56f1-4cc4-509a-08de83511925
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:42:27.2848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEEvhPODsWUSXxaNGe17h6q2HRYg1g9QQXdiorxAzoa4poP12ZVtCRh7ZkEk+4B+EJ+teqm0vU+l5GEYNELGfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
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

On Tue Mar 10, 2026 at 6:45 AM JST, Joel Fernandes wrote:
> On Fri, 27 Feb 2026, Eliot Courtney wrote:
> [..]
>> +/// Command code for RM control RPCs sent using [`MsgFunction::GspRmCon=
trol`].
>> +#[derive(Copy, Clone, Debug, PartialEq)]
>> +#[repr(u32)]
>> +pub(crate) enum RmControlMsgFunction {
>> +    /// Get the CE fault method buffer size.
>> +    CeGetFaultMethodBufferSize =3D bindings::NV2080_CTRL_CMD_CE_GET_FAU=
LT_METHOD_BUFFER_SIZE,
>> +}
>> +
>> +impl TryFrom<u32> for RmControlMsgFunction {
>> +    type Error =3D kernel::error::Error;
>> +
>> +    fn try_from(value: u32) -> Result<Self> {
>
> Other similar impls in the driver carry a TODO[FPRI] comment. Please add =
one
> above this impl:
>
> // TODO[FPRI]: replace with `FromPrimitive`.
>
>> +        match value {
>> +            bindings::NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE =
=3D> {
>> +                Ok(Self::CeGetFaultMethodBufferSize)
>> +            }
>> +            _ =3D> Err(EINVAL),
>> +        }
>> +    }
>> +}

Will do, thanks.

>
> Nit: the braces around the single-expression match arm are unnecessary:
>
>     match value {
>         bindings::NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE =3D>
>             Ok(Self::CeGetFaultMethodBufferSize),
>         _ =3D> Err(EINVAL),
>     }
>
> thanks,

This does not pass rustfmtcheck, probably because rustfmt wants braces
on multilines like this.
