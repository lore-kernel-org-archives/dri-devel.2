Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A30CD5BC9
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 01:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B0AF10E428;
	Tue, 26 May 2026 01:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HN1LNHTR";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46D010E42C;
 Tue, 26 May 2026 01:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H88hZXHoydTSiu9ihtUiOagsC0llqLcuEE5GjJFjZeFhXvArx0US+GNmermabLAqpgLMDd/Uvb+QzfVQ0rYEK9jtFavF42twYcF+l5lVJHx2PZed1pZp4G+IspwV1xkRc8m1tX19oDIEVNlowHTR3K9YW8Dgf1+Dc9eUYQXuXeEmaWoXHNwmY1kqqwBRJHi8wtLR7D0j5AFAJ9tl/B0yv9vopI6vx2JqyTlCfJsKxs0agYCDAt9Km2TiE6Y3hswa3fNggGMmG8j8KOveV358xHx+E8/AcwAt+YyLdE1ZeJt3yWxm7bT5VOYhz9bSUb0xONTN5h5fll2kWlhkQEXE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLYG3e2JDi4yLeGie84a3SyW0pvyP/p8Mz9z2cVD1Ys=;
 b=V+soWlBWvmqD/lVJFQN8wnENzwrqWkTyVMaqxn9QWDtuEUc8ah+ISpA+rm+LntrNbWufPNWSABbZOOc43NZBix0+yZUH2+DqSI7saUCW8E8DkWnpSF6mZ75MO+375HQE9RdcttuqWa+e03EuU+HX3Ffr+O6rHG0Wx/wzKxTyMfSsooomRHPhkeqIuseNRP8vyZugVE03NTXdJub/5jYYoAIY3gitfJ5aRa+/4uPOnU9XgDUvSyRnge6Hk2sMzhS4ruR1lP6cydu6RafoYzbHkN0EBQsHJY4HV/SWQWvLo+s7J8F4YuxodS+Th+sST4gMtmlQG6ctyP+pIRNIe7D3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLYG3e2JDi4yLeGie84a3SyW0pvyP/p8Mz9z2cVD1Ys=;
 b=HN1LNHTRcqKCG+Al0dSIxsZhjdmLHLPLRHn+mUx8kcQgus4ptsnxcWjdT9tpMlBPBCcm306p63PCOnoOzQzngqLyoZ3+TNejszdPmn31WXm1rG8dKesIwt+KZFmIySKvbplGlf/oUGrSwcEhLQZmFx4RwmHFQ9fxdujU7PpFMY9C3cuB3b10MIWgT7q5h3T+Zyu/A054so2N8Z+PtNpode/CPJi/q02Gpnqtm9Naf+KmwdI0lBtSqH3+PK0xtOntOZGw6CGqKX9Oxsur6jrWpvE5Y8sDFuwBHM/EZVsW2miOpYsLQtwdrcwrsc/uNGvFTfjlXtqV1JNhkMFQ/0yK7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 01:05:19 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:05:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 10:05:14 +0900
Message-Id: <DIS7DV2OS6KF.3HDIEU9TOZX5Z@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 13/22] gpu: nova-core: vbios: store PMU lookup
 entries in a KVVec
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
 <20260525-fix-vbios-v5-13-e5e455251537@nvidia.com>
 <f2e3e7e6-3e6c-4a1b-aba5-9be0c41e5c6b@kernel.org>
In-Reply-To: <f2e3e7e6-3e6c-4a1b-aba5-9be0c41e5c6b@kernel.org>
X-ClientProxiedBy: TYCP286CA0273.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2008a1-0891-4a9e-31b3-08debac2da79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|56012099003|4143699003|6133799003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r0Ddye+NLiCF3IX10nsnwvdYsNDrFxXorJiV/OmUjYbZo6Ju3v6RMu6CTwt2WlpUL7A02h4a4Op8U33yttIxUIsw1qFsvOIyW5rsCsPM9JL0Z/XvVoIkyuTtZ40fi1Zf33IvhGrew3puBk+g/VkrPD0VLoezI6WojF9PdXrdwYfNCAaQdNA77fDhVcq239Ci3yA2ZpZ9z1TmK6m7H5N1jx43jKjZtM+A0oIdiUDaG3sQp2IYAOfJPKhlbnCAeZmGfZsDwUX9pPqSXwritUQH6ljyVmNdGAD0f9EoDIzZMWb1qZueVa5+keL0LnGLHhdA0llapVSUamh/zBzmRubXI4wAzps4gVDOVoPeFllD1j/b0ZJpd+9/u3e151dmSaDA7DiG4OwtO4XBZUEY5dLQhfmW7P1JHQMJyMKmsdvy42YqGswK18js61oX/NMQDAAK8AwoOW4Cori8oHNlGAk/TUGzJxPsSXSC9R5lAp8jFdLUNCLl2frhbeoWc23gjV3bHZHgfw5Jdn5lp3EnEsq7Zd8MTVC/Qa2XHjyHNht6rsZn/rZqiLTMDjnA/VnJ5Sf5rijTEvQbw9iFV+7zCI2AVr/N/03ZsCdnND+swsyYdnEYruTv8Ov2fiQx2TohlyfAIp5m6KOODAo+BwJaeduuNE9UlnIRDdtGRsNI2BDQ29PhxGVnpzv3G29KyzA76xyu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(56012099003)(4143699003)(6133799003)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG80THJNNE0vNFRBS3MrMG9VUDUybWsrWHp2cXNXV3dNVTlBZUd0ZmhyU212?=
 =?utf-8?B?NjAvKzg4Nm1HOFF0cVFsbFpOdXNVeDlydmJydjI5YXhmU000N2RPVzVxQkJG?=
 =?utf-8?B?ZjBndFl1MkxjdWFDaXZlbUs1Z1VZQlFWTjFpQ2IxV0JxZUtYbFlkbHozTTdV?=
 =?utf-8?B?eHpVaERzVEdJV3lBRlZ6enRncUpTeS85U1N3NlBUM0N6R3dNMVRMM0ZlREVw?=
 =?utf-8?B?cmxNTmp1NjRsV2ZWNU5EK2lhRmdkVGpEL0lFTGtLSXBsa2hnQjExRWtmVHRJ?=
 =?utf-8?B?UVRMTm5KSGZidkllSXdrSzBFd3I1U0RXM3RDNHNLVWtqNGo4elNwNEhsT2du?=
 =?utf-8?B?bk1nVlVFdHpUZHJmaDRNd28ycG1HRlV2d0Y0UjVJcXpOemc0K0hzWUp2eVFX?=
 =?utf-8?B?MDBNOXNOZnkyaWxCWmJSa2EzbGIvZGVBNVNoOGVkdnZFeXI3Y0F0VzFIWUl2?=
 =?utf-8?B?KzlxdVRqYkxTU3JzenZiL2NlZ3ZMK09lbndEKzA0ZVhRMVFEeDdJL0dJa1VF?=
 =?utf-8?B?NU1ZRmFKdXJObXZ1dGJ0Q3J6Rm85MzEydThIaTNvUWN1bi8vRk56VUJsV1BF?=
 =?utf-8?B?ZFJTVlRDdlowUnV2Zkc2K0tlNmFNZXZFNUFEVUNkNytEY2JURFh5Z3JKTmRN?=
 =?utf-8?B?UE8rdFE0SjYvaTlVbkNXOTZ5WmU0Z1ZBYlpWOEhVZXVIMzZOTmZkb2ZDa21M?=
 =?utf-8?B?R0JUajNoVDB3by92VU9KbXRpd1Q4WnBVdGxhbVZiOE11Tk1yMGREN0ZJN1Fl?=
 =?utf-8?B?a1YwbFBPazVRT3JCNGJNSjdGc0trb1FzbXkvN3JKRXd1NDUrejV4STBLWGhz?=
 =?utf-8?B?azV6bjIwZlpvZXhWNlE2S3g4ckEwbng0WXNKd3k3SXZFZVhkN2FLUER4Wm82?=
 =?utf-8?B?RGRaZ0VYQXVUSm8zVk5lQmJOTUcwWE1KTHRNWDU1Q3ZXcU9xSHVVUG9XT3Rx?=
 =?utf-8?B?dzYzaVNwY0grVFYvMWVQU2xSMStsejMweFpleHZGMVROTk1WTWJTdGNUZzIr?=
 =?utf-8?B?L0pHOE9mMUM1WnA5S1VYYXNnb0lGZXQ5R3pPQlhZVDNydytJR21EMHU2Qy9O?=
 =?utf-8?B?L0dtVW1vQTFTUUxsRTJRZlFRTjFuSjUvaUlzODNLRjMzSm9YelpkZDZIaGdr?=
 =?utf-8?B?MlMyTEJuR0lFVXZjMmttOW5Qb3RRYjFFKzlrd1JCWGNRdGFDU0FaOGxKTE5h?=
 =?utf-8?B?TzUwN2g4bmxLVnpIdDBOUmtQQWNlTUlHRGMrR09RVWVlaDE1QVlVTmZ2OCts?=
 =?utf-8?B?R2xYRlM3Z3lBYmNIelBDQUcxdnRHZnhxcVltblpTakN4MDFDZlNlaERUTVh5?=
 =?utf-8?B?eFN1M2FJckV4aTVnN1ovcHV3WVZXRGhpa2VjVFFHbVBCYWVZcnZTWUxGMmpl?=
 =?utf-8?B?WnVyWHhsNUhLQ2x5NUQvWnVUSzVOMUZCMmRzenc2QytGM2NCNWx1MXZNSTlw?=
 =?utf-8?B?K0NsZzNRaGVEV1dEcFU4N0FsajhSYmF0VWg1Y0ltMmRXdGlSd3JkOFN5L1E2?=
 =?utf-8?B?NVZTRG1HVjZlQ2Y2UEt0WTlBdFowMnVCbGlNR0MzeXp5VHczSFZmWFdVdjho?=
 =?utf-8?B?Z1ZnOFlmdldHeGl1WTlRVGhSR0pmTThLQXBOOWUrclM2dll2ak9FVXRLeGl1?=
 =?utf-8?B?bEgwZEs0cnhGVEJkS3dvcTZNdTNjUGxtY3doRllyVjlmOWZoOWtKWmtLSDRw?=
 =?utf-8?B?ck1Scnhqc1Z0bElpVjJOS0NuV1VzSmZVd05RNGRpN29GYmhTdWRrdHFmRkFm?=
 =?utf-8?B?dlZVOUZMZ21qZnlER21aRm9oM0JtVlVCeU93QlJVNFRrN2RaSHk5ZHJtdmk4?=
 =?utf-8?B?ckVuenNRUzVtTXBwSGd0WFBSYm40NkE2c0YxL1NFdkdDeEJnT1R6NURYV244?=
 =?utf-8?B?Vzl2a3cvODFGS0pUNGpqREFsZ1ZWWVNBd1RaQmpta1YrU0lUZFRkTWFod0FL?=
 =?utf-8?B?dHd3NXg4RVBnMjBxNFp0SXNPdnZmVW5qaXBvbWpYMDlKVTRwWUtsdUMzR1Jr?=
 =?utf-8?B?TGJRa0NEUU96d1JVZGd6MHgwRnQrYzhrcjl3TlZSS3k0Q0tWRmx0cCtBQmZt?=
 =?utf-8?B?K1JuM3Z3WDlraXpTNGRBYUQwZ05XVlVVbU5yamlYaHh4bzNVcXZwclQzdTJ0?=
 =?utf-8?B?My9TYnV4bEhwQzJSa2tRUEk1N3lvWGRsOUhFbkY5NU5mL2FzaEJhT2pwdk1s?=
 =?utf-8?B?UDBWaWNBQnZuc2Qybmw4VmZKaDh0eHpkT2FyWE16MVFhNzVLeFBQL2l3aVdh?=
 =?utf-8?B?d3NDREJkTFJzLzZyT2luTlhpL0piQWIvRWVuV3VFajE2cVRPMEhpd1ZmWkh6?=
 =?utf-8?B?QkxhYll0UDFJS3o3YkFPUkZZTTRtVVRBKzQrb3lTbkxBRlZzTmtzcEtaWFpG?=
 =?utf-8?Q?LHUFdp1Dom+X/WBDwrrX3rBJx76THTyBS22QVw6RRDsAz?=
X-MS-Exchange-AntiSpam-MessageData-1: zjPqzXB/HZ4JwA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2008a1-0891-4a9e-31b3-08debac2da79
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:05:18.6280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L9DNkt7GUT9mTQYQId1NX/jZLz898mQcrJDK063Hnm+TNN/689PX/KVZYKMnfCyC2Eq4KiVfp59RDonD+I0FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
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

On Mon May 25, 2026 at 11:29 PM JST, Danilo Krummrich wrote:
> On 5/25/26 3:57 PM, Eliot Courtney wrote:
>> -    table_data: KVec<u8>,
>> +    entries: KVVec<PmuLookupTableEntry>,
> Here an in at least one other place the patch series changes kmalloc() to
> kvmalloc(). Do we really expect this to potentially exceed KMALLOC_MAX_SI=
ZE?

It won't exceed KMALLOC_MAX_SIZE, AFAICT. IIUC KVVec tries kmalloc
first then falls back to vmalloc. Is there a disadvantage to using KVVec?

In this case we don't need the memory to be physically contiguous, so I
thought it would be best to try to document that in the type.

But yeah please LMK if the above reasoning is wrong, I can change it
back to KVec. I didn't see any existing guidelines for this for rust -
if we want to choose based on the expected size of the allocation, then
I think KVec is the right choice. If we want to choose based on the
guarantees/contract (physically contiguous memory) then I think KVVec
makes more sense.
