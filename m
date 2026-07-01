Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E96C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B30810EF07;
	Wed,  1 Jul 2026 11:38:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WZcf0lvs";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6923310EF07
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQT3WuJnru7J2bBDW33/hcQrz9WXcol89iWZnZLKkmSVpxDSrr9HK6L9mUdlmqSvUJ022c7T/ihfMx/3B5pbz2Kts/oDlGvW6kAmGWGazHjAJsJOIwsh6xdNrvxt8IsDLCt9k1+wUccNHCbIfGvdzn5y8fbGO9NYZ/9F1Ok2xiXeM+CmS0goK5iTGfWx0NzuU+9xStSbDnn4LkocYYaNEeAdIFr7xH5MnhBsNMdR0s27hhZIIEz7fq6jMu/GYw8yAfLLp2JiwnuY4SI13+F9zqSc7a4o0vkCOwR29CdU3KEWyf/4VcBwVpxfQX+gRcOJtPkCQGrLePbXwiqZDngsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXTHwx9sWUR7ubchWiKmKpNqrKsRIOUPyrgwzEWldTE=;
 b=aGyMMv897lZQLkQ0HzhJM+Us8daCmAfgefPQn4zqmO+Rb3VrZQWvuV4O2+ItdYVuGnxCHU6SdkWUiNK424c115Vdx9fiCMmDLoyWa+Z68a1cn6yRENoMr0jhXmH4bm8KGqlGEKtWVF1FN2SLzge93hZAH71CbBGS1Yqug2cWU4XFO7m9i4IqYut644JOm2ayG8KihW0lGCxlruf0DBJK+DSXSJEMg/FpJVsaRfc65biIWsPx+3cKmQTp7cMTeQ6xhJmJHTJQD5eQTJF/CBc12Dknxk/Wn4WVHRt/dUclKHbCDGtpK4nBmPura1OULiYQQT6hCzgp2GChdHIDUT1Evw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXTHwx9sWUR7ubchWiKmKpNqrKsRIOUPyrgwzEWldTE=;
 b=WZcf0lvsA+/PIpGEMcNIb3ZdWO5AILFqIve/0vRUXRaQSesElKu2VXdMCtq21JHibM4nx+tqYl+2Q1cBCbP02rzwSH9siBbBZcKA6vTuCMqr93Nj4tqvIC2uPjSGza45EmRQYGBC4VPnJl+VJ7608yPmhVDM1tcnlQyMHVliFwNdS6IERs0uLfbCDQMjaT/K/bm+whmfg91PbS6EOC6UxZB9BO86m93CVyGECBtseM3cLwUqbRoT27AGwP86IjMVtm5D1wmPRSxLK0ZWYpqeNsDrslzkIpxLeCc/7FbBbOVfEKc3AwL/d73KxNtP6sU5L5pVCTJOzMqdBQ+7Cgds/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 11:38:48 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 11:38:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 20:38:44 +0900
Message-Id: <DJN7EIICLI25.2WMZ73O4BY3TZ@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 05/19] rust: drm: change default DeviceContext to Normal
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-6-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-6-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0071.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d80ff2-7255-4047-c423-08ded76550aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JFxLeJXYKlCUHHaeZhSLod6bES8S/ydDzOIRwDjTEirNDHGyjGRccWDo5hO5bgDlFjyDVUYmNOhHcuXZ90Rdh02SukQpCBwC6XCc8sR0dY5uTvIx/+P+Lo3n7n/0dLEGdzW09BMSC5/1VveeNf4bbFnMZ2onXyz3gC8veMUnRaichaQ+kRWfzBb7NZc8cHfqIN42pTotgKjOQPQIEXsed0l9QOuky+Or4kwRupwAkLKjaxB/f4/Ubu2YBlDlLTaSOwx3VCbFQl2rowaNXYBME3QFJoLaiWgaw0KL5HIno41rxCh7E+5InO9mQgT6Md9go2gzw+L/7lvBivjhr33csRjbW4uw9oj34pOxYA7MnWIS/wE1IDx/YoYS6YX/39umtXasSejPTHvFe0nk8WiF6JW+2LlTyelvRuglIPyD7Md/IkK0sivDFcqgW9UG2RWMJBTdNVMFd7bpw2R+9Hgb2cEfrm+EveZei6p6IN3bZSUH20KhJ0eejujomraLu7LPyp8A+uQRRTnh4OPza+tLBbsLsRqBG886VXDAihN+gvZqy/kHcJSim7sNHoqbrH8P537ZDZONZLq8Rv6PH4+ab2+iGMnMEM+xfpq4Disk2beMRuo8gB9FP9ttlg11ZxP0/QvoIRh5CoOiK3dvw0jwTtynNjVR+z/k9A/0LDSBv0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDlaRVFKY2Z1S0UvbFBFR1E1TGMzMUhmR3FUaGhwY2lCWlNhQ0N5SlI0TVdy?=
 =?utf-8?B?ZFpsenI1angwaVdCT0IvbEFyM3NVYnJpM1k0cWlSYTlkMmFqNTk0VUhoRU9s?=
 =?utf-8?B?UVZIMlUvQUlEYTh5MERneDEyekZEdEdyS3FiQy9DYTdPT1h0VGRmS1FneTM3?=
 =?utf-8?B?dWFNNk9VV3ZJY3FhMFpFRDZtUytRUEl2bytuUVN6NWRhSzgwa0UxZjVmQ2M0?=
 =?utf-8?B?ZFd1YXJLdHIyb3FBRmlROEhyQTlYMlk3VU9UUWF6ZG1Gb1U5RWowV1NldUtJ?=
 =?utf-8?B?SDJiWlkveFRuNis0b0RpNHBDMmpwRXRqU2huTnZZSG93K1htYzAxTHJSUzY5?=
 =?utf-8?B?ZlM1RmgwS3FwK3h0ajNOamg2ZFpwd0hnMG1pQWlhYi9HRXhuaDdVTTFxbm9y?=
 =?utf-8?B?VEJleXpqaUxQRW9kbzhMTzltNTdsSE5ST2ZFUnI0Z2RRdWpiU0FZdERpbFFU?=
 =?utf-8?B?SjlkLzErS0tWYXlBVGs3emNJVFBPTzdMd0t6bDErNEFLOXp0SkJtZjlKdEhN?=
 =?utf-8?B?RDVkZEo4SHhqcmwzWE9UMG5PSDZUUkhZVDRTWk1KMFBXY1YxYm5OMjErdmZz?=
 =?utf-8?B?cUc2b2tQbnBKUEFjeFNqVmN1ak9aSDJyRDZWaGhYYzJIc01sVkUxaTBkOTBi?=
 =?utf-8?B?eEZjQTRMa1VEKzFORVpLVnN0L2pySHZsam5teEM5dmVmeXd5cFBscnpVeUpJ?=
 =?utf-8?B?OENtWkppUnViZXZxNTEzRFhaSktKL01VVFdlVktRa2E3cEhaM2JVMHZyU2g2?=
 =?utf-8?B?ZDFKdExOckwyVFE0a3NFQVViaXE5ckxSallIeWpFZlZDb1FwdG9VcEhOL1dz?=
 =?utf-8?B?dlBGWlpGOVd3cnZ4UXJrOUhoV2toYlJtZXZDU1lpTEZwYWdnWDAwalVnQld0?=
 =?utf-8?B?QUE4dXRoeWJQWVdDSFdCRkdMTzNORCt2T2pjc0swWjB4NkxsWlFXTG9vd3pv?=
 =?utf-8?B?SE5OczlQVk96UUZ5UmVDKzFtOFBmZTI0V2crOCtFRHQ3UkRhaDBzZWJNN3NW?=
 =?utf-8?B?UWdrQVNwUjRPcUsvOUsvT1QzbWwyVUxQV3RVRVZoRkN5OEFscDZPQ01QQ1pu?=
 =?utf-8?B?MTljMDErZTlVTlA4YytYNXpNVy80ZFY4UWhhdmFONGJOMVV2YmZ2ZkJIWE9w?=
 =?utf-8?B?SXRBMGJxQnRoL0xDdjM0ODJVSk0wd2ZJY3FTYitNdkZ5b001aXlYRTlvRW1P?=
 =?utf-8?B?MUkwdDM3NURVTis0clRpRWRzWktoZVBVb3RCQWFEWFNDZ3lxQnZpWEVYYW5G?=
 =?utf-8?B?bGVwU2l4WFMybjRmcWhPVDBDTmNkUDZUU2YvOUt6M09KM3dOeFFpSDFzSXZo?=
 =?utf-8?B?SlBpdmxBdzk5dittM3AwTFY4R3pYb1gwUkZ3ZG1lZ3FoT1hENUFnV3d2akp4?=
 =?utf-8?B?TXhIS2FiYU9oazB5ejl2aDlzOUhmS1FVSzZ1dmR6NFRsd3pGdmhGUVJQaWpv?=
 =?utf-8?B?S2hlNExnMGV5Tm4wRU9uUVlRcWlkbE5SQkluaU5mMjRyUFh4d3RhZDJBd1R3?=
 =?utf-8?B?L2FDckx4RjZJbjU1anZHSVJkSEdnd1BnUE9QRTFLYmFsNXY2azVhdkxiaHYr?=
 =?utf-8?B?d1QzdVlUL3NFVitxenZSTGxtZ1dDdnd1K0dUMWIwL3JNRExwUzJqdFlHbEQz?=
 =?utf-8?B?czd6M0ZHbXhIU2VwN1F1U2w5bGlyVEp5Qi9rNmRGOE9uR2x2cy9Zc2JRL1FO?=
 =?utf-8?B?T21CQWRFYmY1cUo2Q29IT0lhYTZnYURKQU9OQ1lKeTF5NG5YTXNZcU1zeWFW?=
 =?utf-8?B?cGtIbHFBVHN3NFR6UEFBOFJqVjl3QTJKb1hIMld2SHlVam1RTjZPc3VMZE5N?=
 =?utf-8?B?TGJqdkVzZmVFOFM4M0h5NXlkUGNJQ1puZUhkd0FKaGJ2ZDVYR3RPbklaRjBM?=
 =?utf-8?B?cWpwTmc1TW5URXd5RkNXSzBJdmtieHZVenlCZTNsVE1vRStTUlEvUEI1SlhQ?=
 =?utf-8?B?TUJCRWFjZXhQOThoOHk4dzZ0VVRxSGNaR2pLMzlWYytOOGQ3N3pBdHU0VFJU?=
 =?utf-8?B?aWxXRFB3QXQ3YkQxR2tUbURlbWxFY1hpVkZURmtZeGY5RlhCNThoY0hRL2dQ?=
 =?utf-8?B?RE9oenEyczZELzdXYVlubDVuWkFiSndKSWZsb3pUOWNQVEQ3UlVjSTdFdERL?=
 =?utf-8?B?dE5DT1N3MFZ6Nko3b2lxZzB5bWtyd0RoVmc3RnQ0aW5SVUpqeXQ3VDBFZTlm?=
 =?utf-8?B?NXBkWGJTcG1XOHpDRS9nd2RUenFsdTl1V3ZrZVJoN256TkszSm5HemdueC9l?=
 =?utf-8?B?YmUvUkU4ZW04M0NOZS9mUUI3MlZkOThmdTdNMnM0ZnFWbkdDZkMxQkEyaCs1?=
 =?utf-8?B?YUplOFR4YnpTNFdwMXRacjdYVTVDeGJaZWhjdmI3ejhiUXl6cklhenJjb0l2?=
 =?utf-8?Q?61JqtpDqA1/0IdbhPu3RPfQzH8C41haLqjdRBEgqtO4rd?=
X-MS-Exchange-AntiSpam-MessageData-1: AA0d09C1rX0iQA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d80ff2-7255-4047-c423-08ded76550aa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 11:38:47.9570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV2bBENJkjQokc9ZAmbi09Q1rzmLYiqHt2gPX4WUDCTaKuBoWUVI86Wqi4VOk1Cz8tSqjYlzZZfo+3rvC/1wMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117
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

On Sun Jun 28, 2026 at 11:53 PM JST, Danilo Krummrich wrote:
> Change the default DeviceContext from Registered to Normal for
> drm::Device, gem::Object, gem::shmem::Object and
> gem::shmem::ObjectConfig.
>
> Normal is the general-purpose, reference-counted context suitable for
> most uses; Registered represents a device that was registered with
> userspace and will become a non-owning context obtained through a
> RegistrationGuard.
>
> Update the create_handle/lookup_handle bounds from Object<Registered> to
> Object<Normal> to match the new default context of GEM objects, and
> update the driver device type aliases (NovaDevice, TyrDrmDevice) to
> default to Normal.
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
