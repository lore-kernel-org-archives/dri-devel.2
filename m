Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC697CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4232A10E5F5;
	Mon, 18 May 2026 15:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ni3U/lAC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F00010E5F5
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 15:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4m+qjzCCIuM8nmlSTZI/AWmoRRUuCoz7bW+kic89E+RwchKyDlxE2Bs/Ittth/nskCzyIi7fZO4J4GN1qvvTVoXA9kP1VrlruQPuuC8mLZUxPL62pDvWRF9Q7shsZ+gstLw4Wve151bpoXCEgm3azlEVQ/o2o0KJlxwtio9fPrZSBJODKOz6DTYTJYayxoBNMa0RIopXH5vHtYqBUAiy59eWXxWokE/TE4ghD8HtzskrmxgoPLn2sxDYPyHwf5QqnHimEzY8+XagLBEw5+TYsM9tH0dNYa8lu2xm0/tien8pc5/xPuszfTWtWXxG/NDEoC3sUrDFBHiPXh667Hv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+jhm9xMp9PEoKgy1p/chvasKXDb+lOKSNBgEQBOedU=;
 b=AzHS6hbiNw5n4pEAwzgNt41GDS9KdDQYLrjZ5ERhCisXJ5seCA0x0pqOmMTwn8GpUEPE1+Q4zgjSTyrvo++3x1JsYlABGQq2+UCzp6+4RcHcawUQNhom6tgp42OnfzySQ3dgp5aPsK4Ib8JHwomu3gxin+JGbaxKZaqjsxUxfGC74StCM+n9hYOTcuGx03zIUKnAWCSUF8saMSKF2NzrPFvul+/XugMnjLHJDBpSPN3zDDvvD+Zu/4R5YwZTVvAVd4KA+nlApivsNvTHRpE5keuUgAbUQUdjP4LnRvPPSwpRPFz8FT3pUySk96wmRXvDLBCArSVJk8ep6yI/4poqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+jhm9xMp9PEoKgy1p/chvasKXDb+lOKSNBgEQBOedU=;
 b=ni3U/lACfCnV63fFqEGFm2XnlRwoWTji7PUCORYxBFN5wp6sIqXR9YNqNPRWuqt38cODCUge8bHPG95qejrzWEs8fXtCWfuiLkfdiyaHkaoLlH8q6NtQxr0tRkLv0Mw/rqRhqW7Im2GafdvOklQL0E+kfk+CZBTJg+l9cANPxBnkuBhMD5IRzzFI3c+tzY6u2KDZvvkMG5GRpouAq/DY+Qw8ozluOQlMohJRyYni44R5+Y92Isn04UtvHNWO/iPagDa7p8grnqzscmfYUruGOD/xSufiLgx2RwPHiVQb15sZwLZodHBr2Tm5PeKEgVmS2Vp8kyvsUrquabURmbitFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9823.namprd12.prod.outlook.com (2603:10b6:8:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 15:39:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 15:39:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 00:39:06 +0900
Message-Id: <DILWYKXB7N09.154ECUXJ92BOT@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 12/27] rust: auxiliary: make Driver trait
 lifetime-parameterized
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-13-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-13-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0363.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b3f7a9-a192-4144-f037-08deb4f39a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|22082099003|18002099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: 1x6zSItbL2pOOfICIWqPtjeD98G0Ma55EcW0mCB9PO6xYsXzZ6QwQFWGm+nPErTKvnF6ropOYEK9NeijvpYPLaV9rQ6E76ruHcXwbD/iZS6gWNXLewJ+4S1PvmbYlhFw8t6AsvJI96KjLXTG3JmLKbChDng17KYLhcbHauwpWvaJ5aVYbl+kwRYOgC2XLjeqKX1IZ24XG2UedEU/orl6B0axuG/74v4Fil7vCBy72+1VfMcGyV2YRsdT003lwDwy6PwIeBgfnW6LZpBX2JDfNG/Tm1CXThKzXUDsRS31mccRCQegkQ6fTM1GwZdPCyk2N9wX9Cge5yh//fl1HHaAOjholefldWZP7hXFLwuG6qI7E6U/6WzsEPGVRUVD5iwetbSyDDhMYrCbtRayVBW42pmb7YSNV88HzaPFp9zyrv+EeykgY2ZvyFquUMZ584c8Qjfl8+H/iCeaUx3EEBfae7F60NBOmLXPkl7pniQLkYs9PoXei4zXEYIccP6zaysDI2woZt31OwdAh7fA58GpXBaZWHErUA1opo8St15cO6e4IJ+ESlpSX8j3mqtW/aVzap5mSBKDqMiqkmmkR66/aV11d1PqJyJnOo21ZZzGvJH0O3DrHgCLgQcb9rF1dQyJswoqQ6G+pnCpQ+5GTdrzCAceP6RQ/HMn/0pkqArW7Sjvc39FlDWXv09YzH5JbNVq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2JqeTdBQmRGWEhtY05ic2dTTm9URjErWXhFVFFuZXU5bUFiK0JTMHNQYjYx?=
 =?utf-8?B?TE55aDRHWnVzT21NQi9FcXl3R3h2RHlvSThYMlpuMDBCVmIzQXFVc1lTZkx0?=
 =?utf-8?B?YVNad0pWamk3WmFpL1ovVHNnNjJkb3E0TGcwUFF6b3hwT3NyWUltMHFYc1Z6?=
 =?utf-8?B?NXlKQlEwa3RzTmlsTmpSMVJOOFo2RkZKY0dzU0NMN1lodExJUGlqV2tsdGdu?=
 =?utf-8?B?Rmh5NE96UWV2SnF1QkFvZktpUG9tOUtwNGVyUzhGaVFqeGI1QjVIMDlCeVV3?=
 =?utf-8?B?MkZoMmZrTUVwMFVaR2RrcDhWdm1wVnorQkg4S0ZCSG1IcHA4WGVlbzZvUG1R?=
 =?utf-8?B?RDJlUDRPa3R2dW5hUWJjZmpVRjZ2QkZnVlJ0NWR2L253OUVHMHBrcGJKRnox?=
 =?utf-8?B?LzlRQnFvMUV3Q1laY1c0dW5VMzZORUhTL2c5blBuWlEyL0lYKytNZ285cjJ1?=
 =?utf-8?B?RUlVY21CTGxFZDBiVFVDcXB0b0gzMmpzRXdsT3pFSzhvWmVLNit1eVY3MWRJ?=
 =?utf-8?B?d1RNeGY5L2JMTkh0WWhtR2RxTnRoTG8yOU84bkxQK1dJV3NqNS9lYklidEpJ?=
 =?utf-8?B?U1dCRFdlRGRjYUNveEQ4MkZPVFpMeWlNSUEyZnp6R002SnFoRHJwNk90d2VG?=
 =?utf-8?B?VFN0bjJPTDRpaHRVT0EyOTVRMms0TDdObSt2UnlXV0doeG9QMzgrMkdVTFVO?=
 =?utf-8?B?RWJ0czQ0eTc1S25hbFJXNTRPZVcwYjgwMVJBOHIzUkN3M2RKd1VsZnNqUFdT?=
 =?utf-8?B?MkhrdFQ3TGl5WTNmTUs1NnVzZU9JL0FtZXlCZXFueU1xN2lwams3bnEvbENZ?=
 =?utf-8?B?ZER4Y25zRGNUV3FiTVQwOEhvYnE2a3dVQzhEY0NCQmtVNDljT05ZS1RLcE9H?=
 =?utf-8?B?bU5zWlNWSmFHdHo4aGJsMVk4Z1RHdXpxRjE1bzk0aWlhZjZQbUx6U0QxS2RW?=
 =?utf-8?B?dnZKcjE2L1BOTGduZm92V1RvekxtRlExUWJOV3dKOG1rOWJ2QUM3azB2T1dY?=
 =?utf-8?B?QzBvSDJXVmtuOFdtRDZOMExFaHJSMWRxUXAyNk1QQlRLNEExMVdDWjNEMzRZ?=
 =?utf-8?B?VnNKYnJGajgwNFg0NDRpTzg2K3YrTCttTVVmcllTNkJIbVlhU2NDUXVRUXhS?=
 =?utf-8?B?WDRtZWRZdVl0Mk5DWWZ0Ym5vQVRIZlM1SVpMZkdKWTM3ZUpwQ3FqWnpFcHVQ?=
 =?utf-8?B?ZlVzWThqajJwUnk3T1FMVmU2bnM3OGdnUnl1WlY0VGExMmRMWG5MYXloa3dH?=
 =?utf-8?B?aTR0OXpkYVJFY2ZyZ1U1M28xNjZLaWluV0JiZmxJZmlvM3IzWjRuMUZCS3pJ?=
 =?utf-8?B?QUh1U0hQWlVDcTljcHdBOEdYZEJEMmNSUmthL1NJaG91aUtiUnZwT1AxdmZG?=
 =?utf-8?B?R1lJMmZIZE1VSkNBbkk1R1Q0djdQYjZlcTR6bjNFclRHeTFYUTlIbHFGeVRJ?=
 =?utf-8?B?RjZzdHFvdHhpZ3Bnc28rYzVhKzVwYjg1TjBZZG5GNUxqMW55emo4Q2Rxek5X?=
 =?utf-8?B?d2pBcGplaVd6ODdWN253ZFBvZWtja0NKSFdFT0phVXpKY2Vlc3FyencvTG9p?=
 =?utf-8?B?NTVXVTRPVUloUEdsQnNiWmY4a2lhd1hOeC9aZkNZK1JTRjZBQVpPVHpZbEJ5?=
 =?utf-8?B?M0hKd3RnVHJNcmxJVGVnYVQ3eXNFZ3FraG5Zd2htSFVRNFZKNGVUdWVhM21K?=
 =?utf-8?B?WFJzdzIxblRoeWVvdUQ4Vm5MQUNibzFKTzNhWkhPd2cvdEkzaStnSmU0OGMv?=
 =?utf-8?B?cDhkN2NKZ2dFZk51ZXR1TFJNMFM1QnJXajNJdFp6NkYrZkNkVVBtSm10SGJ2?=
 =?utf-8?B?RCtrZkd1NEd4alpNd1FSZ21GN0JRY2lydHBrd1EzbEdGcUNRMEQ1ZFJXR0Jv?=
 =?utf-8?B?em1KTUZYUGl5U3V2b2F6VjBXRXluSjQxVExiQ0haWGRLd0VMOHJEWmVKVDZH?=
 =?utf-8?B?Vko2M1JVVWxXRVVmYjdEdldUbXF1SWZVS1dCcXNSSTJvS0R0RGFhVnRmNStU?=
 =?utf-8?B?YTc0TXN3bWtpYzRzYis2WktSN29yUy9ad1Zyd2VtbkhsbFE2WjNCNTBseDFL?=
 =?utf-8?B?TS9PYnJidStpRUdhQ2FkNHdGak1lV0VuOEF3NFFTNXJMM2FsVlVwd0dZU1Br?=
 =?utf-8?B?K0s4NDJvZzlLZEJIM0VaZUx2a3M3QXN3aHpZaHkyc21QOUZDR0c2Y0RFVHFZ?=
 =?utf-8?B?eDh5V28xQk11ZGZHVEU0bDZVWjY2cHBoK3BvUnhRVlV5YTFwckpLSFlObURj?=
 =?utf-8?B?MCt0NlVSWnVEMVdqQkEybVJBbW04YStDcUpZelU4REgyUEtRSllaSTd4WUhx?=
 =?utf-8?B?ZlVQL3hab1VwQ1Zrc0RsWlVkVGs1TTRiRk44dzJXd1BWU0FhT1dVaHhMM0Fz?=
 =?utf-8?Q?X3xKbTjOpg7GrLvAv0mOCmTySeJaJQC+PzZ14yRsh1ldv?=
X-MS-Exchange-AntiSpam-MessageData-1: CeR9tGqzs+ql9g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b3f7a9-a192-4144-f037-08deb4f39a6b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 15:39:09.7982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfIDb0C8n2YLAEaSGFC8u7gzv6H4DfmyZS/FvNA9uCIbmQtEsQPukEs040U8+j1qOvbcCdVOGQY9vDTonJ5C6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9823
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

On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
> Add a 'bound lifetime to the associated Data, changing type Data to type
> Data<'bound>.
>
> This allows the driver's bus device private data to capture the device /
> driver bound lifetime; device resources can be stored directly by
> reference rather than requiring Devres.
>
> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.
>
> Existing drivers set type Data<'bound> =3D Self, preserving the current
> behavior.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
