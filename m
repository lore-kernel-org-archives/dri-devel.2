Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E79C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 05:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98C9110E439;
	Thu,  2 Jul 2026 05:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bsRCdg6p";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39FC610E439
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 05:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bt6NK0K8i6a7rpz2Ak4RNZ8qr9dCQqR9FQky0Y1P6F0joMKMFZroOHCCvBen60tIiEtx3ILxlrLrqBNb3PKO+cg0oi3d2GPZ2A3O7tA8AWv6c34sDxXm1i7kCovGy1qJbMKLWDlvEO6859MAeQA0O5pIufQ0QzCB8sE24obHIpJYSdC66gTzFN63d0c7ZXiPqvWLC3jrGieSndgp0tUVh0snuEywATeg48JNh5PPhxe1+OcMk+5MPGjL9mZ+NhzH/MwPJIq4swYHhMhPSYWu+zyfCp4P/IupoEjxZehqHj5E0nSNkWPMRBlRDN1Fp3d4DUs+qIRgtyoi0TFUJDQzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGHKT7iXAmIaJN3GicheL+pXix5apBcm/tJd3X0Hw1g=;
 b=p7VAIqafW7xg8liv0VJ0UKW0ObVufYx9H1xq5XCwR5yQxmSFG4JjvjcyGnBh/pDl3cpJ3xXvGRdXj/r5of3YGDAk69okIQ0nTjNnmjL3Ks/MWrF3EC4W0AwU3vinXEAua1JpgU7qZTIEs4H4V6bPCG7f0o59BMP/c7XtC23qJBZGxnyPHu+OEyy65Y1NftwhV4dX2gzANd4mzoWygbwgdJrZmj8MbCBhQauTAubbnp7qKWUmMv3s6KWzyJUOFzHpGiffRaMzX9QQ5tKQY6hMvlt5gFpy1/oBgqQHtgGS8CZAEi/LWJvdmgT/pmIj1K5yItamgKH6isv8ypkfq1VcDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGHKT7iXAmIaJN3GicheL+pXix5apBcm/tJd3X0Hw1g=;
 b=bsRCdg6pPhd/AUwgaf1oKhV9RaASEiXxRSotHkR96avO5xrh79e13JuixRysBMZeytZE6d1HkdA6DJr7OUKV0OmnuyNS7jB3o+Rhz0P8gaChgMebSvLLi3PFk9ddaqVoL8oU28Uz1MFK2Yxwie/m0AF48ggH/BhinMkgxb/DIJL0BfBWEBAwEW477c2lWQVhso6nOKn3WcjVWchtHg9GxDifpctc/m5FPI2yjLXOSWgE0XdBmTOjq7LuGB+2dB//4+aum05iD2UlFyTMPH5NL00EZk0tCoKxBnHPd8YjGPba1uRgFGjjvsu3aN+H4DzWpWtTfBNW8uHe2YDjM8/E2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 05:04:25 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 05:04:25 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 14:04:21 +0900
Message-Id: <DJNTN3MEEYDZ.1PSWARQKO5TPO@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 11/19] rust: drm: add Ioctl device context typestate
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-12-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-12-dakr@kernel.org>
X-ClientProxiedBy: TY6PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: c39d4809-3bec-4455-6b1d-08ded7f76327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|10070799003|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wKw1HAzQZeoMEqrrN63ns9XC6QGUrRSQn2/avkEJ5rUW/1fmSF+yZKAsL4ggTHjZZQwqsmnWVXZEkjuHHvD0shZK/w9LEXeOL1EPvbYfw4o+HTG6Em2ra2ujlU99dfX0iin41fUIQJqVjv2Vu9orForIAQGOrQa6zMQwAQfF/UK1CbouoXM9BIyq5GxxcY8FYf3ffkzfsybOvo8F8lh3kWraKUtgDqEIYrHhwVys1Nafx5duTferpC0pysP05O8WoKegYditgzK6ken4idp3aaikV1CNdDaX0K5xZ9GzN1N0SFSRauZV1Bn2WbcCCVF3CojnMDO3KgRj6hSo1RgVS52cEaSpzxf8XQgC/0W0FXCMUp6ISVDkINpTvQrqwyQgw0OmPkE3z+tAcNEBUdrAjmG+dFm1LB+veBDlfHWlEUIdVp8b3gu4iuxI//qs0tPP+0rgA4fhUAt4yvbdteShZqhmiq7tzAzSMFPeQ8UA0hBBdqxuAXKB5fw0UFsi7U0IIIFXeAXStxUz7/KNUd0SgorZmCSoJdxmtNEgAA0hGnRIwhcxO+5bGN4kcZcZ03wpnLC7nJB44RYWkso6ySDq6s0TqSm30FEHVfNS3+6VDSOoI2RdSm2Cp8xxt1QiuoJ4gL2MlzginnreXj+xk6Twc31Azv+0d59Y2lFNjUmuh5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10070799003)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHkvYkJsNUpnT2x1djNuUDdBMEROTzdDQkZVb0VoQ3gwU1lHckRBdnFNTzVm?=
 =?utf-8?B?Z3Q1TjJoT1AxdndtdU9KSUhDbWZMcDM4aDZjNVBzMnZ3SG5sL1p1UWU4MEsr?=
 =?utf-8?B?STFRZ29yM0M1RWlOR2x5SHFzTVY0bHdhRnhMem5uak9ZbFczYUlmRndTQzBK?=
 =?utf-8?B?WjZqOHI4YVk0RnhSM21uc1Z3a0RRb1owNW4zQU1CVkpHNHU5RTZlVWd2NkY1?=
 =?utf-8?B?d25CZm0wdGk4T0dYbk1oTytvOEtacVlCT2wrODNGYkc5d2ZwYWY2MlhwWkNF?=
 =?utf-8?B?SldhankxQUU4UHhiY0svTU8zajhHajdTa3dOSk11cm41V3A3bGJvVW5LR1A2?=
 =?utf-8?B?L3FuUVNtRFhJUlFqbDJpRE9QY0hRQ25YekdoeTltUW5qV3F1dXBLY0pXV0Fi?=
 =?utf-8?B?N3lERncrM3dMdjZZYUtxMVNLMGZGaHVyOGhEd1RzMis1N3dPZWVCRVo0U2hM?=
 =?utf-8?B?clEzK2R5c1RXbWhIc0F3dnQ1N1FEakFNOTloTDRQdjhYRW9kdytzaFFadzVT?=
 =?utf-8?B?KzZ2OGFkWloveWhoRzRERDhaMEhYbHoyZzRSNWJQZDVGZ0VBM3lncm9lOVhy?=
 =?utf-8?B?R2lDbCtuVXN5NHlHQVVieGNmQ0J1a0FVL1E4aSsxZndtSjRkK0FzWWUwT2ZT?=
 =?utf-8?B?Zms2T0NpTkZ1a3RVK2IvM1pNVEYwMm1LYTdPTjlzTGF4U3BpYk9Jc3hZay95?=
 =?utf-8?B?UXhCUnhnWHdGellscWhRU2g5ZnhPTzM4S0JoVlNMZnN4RXc2cldJaTF6cXpW?=
 =?utf-8?B?bEtyODF2aFI1MElrbHBYOW5HQW5VNFVRZzgwa1BHcEkrL090MlIraXRQRWV6?=
 =?utf-8?B?MjFidG43Q09aV21Jdnl6aG85V2ZsNm5qNVMzbG5XY2J6QlBpVy9NMDZZNUxy?=
 =?utf-8?B?aWV2VWNSZUFyTnBzNWszT0w4dTlXc29MdXk4SUd6b0ovdlBDSnNBSkNXOW11?=
 =?utf-8?B?T1FVVUkvaHJXUWlVNFo2T1Y4ZWFRWkJtSGVETElOS2ZuU25Eb0pNUmZQd0FJ?=
 =?utf-8?B?c0hUT29DMVlFWTNQU3VEOHdQSzJMMG9WUDJybXJ6dlVKQnhyeVNwdVpNOFBU?=
 =?utf-8?B?VTZRWFY0Kzg3eGEvdmgvMG5IQi9EeXNvZ0dycmo4YlRydFhKcytCb2N6UW9s?=
 =?utf-8?B?RWVXd3pKbkIyYkFGb05VU3duQlBLT3Y0NWk4cjZ2aEhiUWRuR1g4UEpQNXRK?=
 =?utf-8?B?RGlnRXRockgxL1lRT2NXOWd3N2phbVdSMlcrOWgxQ1BkYXdUMGtlYjlWTjdr?=
 =?utf-8?B?a2MzRlphWnB1NGxXN1dwcFpkVUlFdmFNUGpSb1J4aVVkeng2T3p0YmQvd1VM?=
 =?utf-8?B?cVZhWTJodUxsWXVsNzhPdDhJUUVpTWlXRzZXQWxyR2hIbmNoczNtS2lQRDJL?=
 =?utf-8?B?Z2ovcFEzcGpFNVQ0cC9qYUp1VHA3cENnS3hMMllza29EQ3FXM1Q0N3dCZEQv?=
 =?utf-8?B?WnZ5OW5RUFVNWXV3aHA1NXh4ZTJSdGIvOWZEbUo3Nmxpa2RKdGtuUGVDdEts?=
 =?utf-8?B?VENCd1lsSzV6NlVOVnh1d21qbWZ0aWJ0cFVIdkJvS0xlSzM4Qm9vbCtsU2hO?=
 =?utf-8?B?TTgreEJDZjlVbEFWaytsak92bXQ5a2pRajVQblpBUjA4VVQzTGdScGpKajV2?=
 =?utf-8?B?RUlrNmZsUjdSbHZsNXNwV2lrZ1ozbUFUdDdkTHVOT0ViMVZOeHFYZUZYOGZG?=
 =?utf-8?B?RTJNb2tTZlhGRVQ3NElUbEVKZ3JIM0xvWHNvZXUySEZpZ0NLRWRUdkxjRDB3?=
 =?utf-8?B?ektIUGdYbmhQenZIR3JSQTJVVkZKbUxMdENJOENWUXJGbFZBTDVwa2xhd1Nk?=
 =?utf-8?B?VW1ESWZQeGx6NHVXMGpwWFJZdnZMdnAwSGJDNDF5RXBFakYyTEF4aUorUWo4?=
 =?utf-8?B?YzBiOEpNNTZBdDViSk5xaGE5R3doUFluT2FzOHFyZlhNZCtaN3hwTVZkL0lr?=
 =?utf-8?B?NUtLbTdaY1ZSQXNidVg1VUZxTlRrdlNEZ2paQTZsbkNNbXQ5d25OTHpLeHBL?=
 =?utf-8?B?QW1JM2Y2NDg5TUhjS3pwL0NSMnkrNXd6d2xsWW1NdWRWVlFNR2RDSXBua2J2?=
 =?utf-8?B?ODNWb1NQR3BsblZIMjBKaWQ2OUl5aCt3Y0V6VHNBYkxMMmYycTFuOHZ4dXl1?=
 =?utf-8?B?UjdDK0c1ZHkwaXlMak8wdmt4bDM0eHJyTUJCbkxEU3had1h0WGhHeWsyeHVE?=
 =?utf-8?B?cVJ6ZFpZaDh0UEhQMjgxMy8vaWVzUzUzOURGN3pzY0k2YThVNTNad0kra2xE?=
 =?utf-8?B?WjZGTEJ5Rm91WmlHNUV1MEV2VEdsNWgvK2lLYno4Sm9TUVB4OEpic0FwdFZy?=
 =?utf-8?B?NjVoKzh0UDZZTHY3K3JLTHBDdHZtNWtwVXkrTDNvbnhkQ3ZITGZYRFlqUGI3?=
 =?utf-8?Q?JjOUllnX956mebA1kiRKHkEKBr4NJX01eXVWmU+9IJkAZ?=
X-MS-Exchange-AntiSpam-MessageData-1: 4jznhVIb0C/9kg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39d4809-3bec-4455-6b1d-08ded7f76327
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:04:25.7416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2pVaHkNqMx/kcEtf5n324LF21wM57EEW6k8I5kY83WhC0zyHA4GkmEgT1SHhtriRYFdzXjA1/EA/NkozvZKcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099
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
> Add the Ioctl DeviceContext for DRM devices that have been registered
> with userspace previously.
>
> A Device<T, Ioctl> has been registered at some point, but may be
> concurrently unregistering or already unregistered. drm_dev_enter() can
> guard against this, ensuring the device remains registered for the
> duration of the critical section.
>
> This typestate will be used in ioctl dispatch context where registration
> is guaranteed by the DRM core, and RegistrationGuard can safely be
> acquired.
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/drm/device.rs | 34 +++++++++++++++++++++++++++++++---
>  rust/kernel/drm/mod.rs    |  1 +
>  2 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 86a7fca1d33f..d429b4655449 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -74,14 +74,16 @@ macro_rules! drm_legacy_fields {
> =20
>  /// A trait implemented by all possible contexts a [`Device`] can be use=
d in.
>  ///
> -/// A [`Device`] can be in one of two contexts:
> +/// A [`Device`] can be in one of the following contexts:
>  ///
>  /// - [`Normal`]: The general-purpose, reference-counted context. A [`De=
vice`] in this context may
>  ///   or may not be registered with userspace.
> +/// - [`Ioctl`]: The device has been registered with userspace at some p=
oint; used in ioctl
> +///   dispatch context.
>  /// - [`Registered`]: The device has been registered with userspace at s=
ome point.
>  ///
> -/// `Device<T, Registered>` dereferences to `Device<T>` ([`Normal`]), so=
 any method available on a
> -/// [`Normal`] device is also available on a [`Registered`] one.
> +/// Both `Device<T, Ioctl>` and `Device<T, Registered>` dereference to `=
Device<T>` ([`Normal`]),
> +/// so any method available on a [`Normal`] device is also available in =
the other contexts.
>  pub trait DeviceContext: Sealed + Send + Sync {}
> =20
>  /// The general-purpose, reference-counted [`DeviceContext`].
> @@ -113,6 +115,21 @@ impl DeviceContext for Normal {}
>  impl Sealed for Registered {}
>  impl DeviceContext for Registered {}
> =20
> +/// The [`DeviceContext`] of a [`Device`] that has been registered with =
userspace previously.
> +///
> +/// A [`Device`] in this context has been registered at some point, but =
may be concurrently
> +/// unregistering or already unregistered. `drm_dev_enter()` can guard a=
gainst this, ensuring the
> +/// device remains registered for the duration of the critical section.
> +///
> +/// # Invariants
> +///
> +/// A [`Device`] in this context has been registered with userspace via =
`drm_dev_register()` at
> +/// some point.
> +pub struct Ioctl;
> +
> +impl Sealed for Ioctl {}
> +impl DeviceContext for Ioctl {}
> +
>  /// A [`Device`] which is known at compile-time to be unregistered with =
userspace.
>  ///
>  /// This type allows performing operations which are only safe to do bef=
ore userspace registration,
> @@ -342,6 +359,17 @@ fn deref(&self) -> &Self::Target {
>      }
>  }
> =20
> +impl<T: drm::Driver> Deref for Device<T, Ioctl> {
> +    type Target =3D Device<T>;
> +
> +    #[inline]
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The caller holds a `Device<T, Ioctl>`, which guarante=
es all invariants
> +        // of the weaker `Normal` context.
> +        unsafe { self.assume_ctx() }
> +    }
> +}

Since the `Deref` implementation is the same for `Ioctl` and
`Registered`, do we want to add a private marker trait for these two so
we can factor out this `impl` block?

It wouldn't reduce the LoC count, but would make the logical connection
between the two states explicit and set an anchor for potential future
blocks with a similar relationship.

With or without this:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
