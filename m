Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97623C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE27510EF01;
	Wed,  1 Jul 2026 11:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RQrSVr5q";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B5D10EF01
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:30:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrb6Q4Qn8vs6mMWAgCk/baK9dfte6e1ZhrQ5ujzATs2ANofRrgI+iRhcIt5hdGbdaWyK3Jl1W7RPLn/CQJg6JP7BWbiRS7Auno6NzObGiSf25gZgLpA2LDfFSZazkIfQaXyU2+m5VGy/whIfRq71dIbPe6uyjYY21bJ5bnxCGPyOUQR6TJGoWuRxOTn77EGrzNmLHeiMkSMCa3AXxQuUVVJ5k04I1jFCD8Y8iclLvuM6Pltl6DlfWSnUj9JrI0luY8nczG4BktthcRSOWwSdh4zI7F7WoW1y2BYkhZ54+bMkp48gssPAzxucqc/rHg+b3OS55TSWe4GE73Fy/zwX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5JFsPDCMgc4jskOTnyG5/Qs8wAT2Nqzm/TMwhjUX8Y=;
 b=hqg6aG/30/1l9bMtCB3Fq7Gw9OayKLcC9DJVtHj87R6JoEptV0zCsFm7QeZ0uw+gt6vOIzKfEVx1OgszwJQ1ZmeyEQ1bnAV0Opv1LLCeS06buHsXLAt+KLZtjz/ufukYGnrUiap1FMrSAlBpqXyvz0/K2an0u2Tbi02D517DWIPxrsrjIBJIRrBipacTULoS4bJVFKq1v8gP+G0ndiopWSUSieY1gk7T1brtlB46/EFnRH5E7YuYmMpRsR0P21OhNOumemrAR+JS+H6DPQzG3wwb2MesK2/1qxKkX99hFkhmnbfQ/lkT7b1pR3qaFyR+rezO3UhPIB1Ph6XSyzE3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5JFsPDCMgc4jskOTnyG5/Qs8wAT2Nqzm/TMwhjUX8Y=;
 b=RQrSVr5quv1N0xt/+xWUkykqLDj/mRixDRyD63cu3e4QD50whP/o3A+uZj6yxAT3X1kpty6jRNI8kmSQoGEGKMsmAPkfXhNwY/S8PDz6X048fMQWJSwFIdOhdrZButxutSZe2svPFmFaCAtTB/9nl9qx2tvJ3wAfwjveed9L/B96EBzEWxNxiN4wnzA3eqG+Kx28pUtjVOQLFpvUrzicczzSE96OLQlGbAehCzI2KKNapY0ScqWyCCfmOwJVQ10Z0hBgPAMtMe3mBdm8JOuh4AE7GHVh6/74KC+t3qG2gqNAhzw6TZj+xr1d01EKHjkxeBcYJpfO7sYzxRL6LF+K2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 11:30:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 11:30:07 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 20:30:03 +0900
Message-Id: <DJN77VD45F7T.2UKN9BKJCOMUU@nvidia.com>
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
Subject: Re: [PATCH v5 03/19] rust: faux: add Device type with AsBusDevice
 support
Content-Transfer-Encoding: quoted-printable
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-4-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-4-dakr@kernel.org>
X-ClientProxiedBy: OS7PR01CA0097.jpnprd01.prod.outlook.com
 (2603:1096:604:256::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: d88968f5-ca2c-4153-16e7-08ded7641a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 8v+mQKXeMj/pJc0jcrzQrqxmTUkBmjO1H9+nKGUmLS+QCCCfz16q5FJ0Kf0q22KNXGsxt9Q84LRoS9HUzsgxqQ5weddtZ4dzVsQpC/93RjOm+G3uBqUaozGhUbo5ozfW9bw/TLepdYOzWwiHfJKFClMVzXCePsNE3ogcv4tKIRi9yg94EKyg/6T6h0K4VmJtnRJxCrVtVZarS8Rl5MRMgCXmDmvarYPjQFh712OLlN82BlElml2GCI73eAIsq5G7aJWJGyPcj0tNIqSKvb9CFmX2KB03QsMKBGb6Fya0D8vY3zGsIis/14/qcbqHT537Sh2H5huWigf2mypFO+HXtm/CLzRmk7CDUBlqEXxlmJA3j9BbHvFhedUdnJxEVj5NtfEc2kX+XY5SQ3HOlywhEB1XK0J2+kIfHv2pKarg2g5xv4hIiu9FRIZ2HeA5JRFZT6XbJqP+S5gJMvlpmAksnQYz1pIpurY/ekDlq5gXKZEnSX3v2OskOX5DawJUhAdNzeP5g+uUKYTV5w9vlmAm4jnC1WuhUdXT1gn+mh0LD+EQTnXTFUaH02YhcrTM1BzkDXgQqARfrpDrntOCvnF+xz73CLHAkORTo4fW60MVeRGJ3GoF/IgOky2RR0EMYeWQltxsNDDTVWA360ZsHFI21MNh7l2dCesix9jDXkzunrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJ4SWYyajJKRk9YemhuRUJHanZTMVBkRUVXektqZkwzSkpiWTY5V0pJYzFv?=
 =?utf-8?B?UE01TWh5cUQvQ2h1NXhNVXRLSjlkTXFYVGNSdnhkcTZXVXlaMSs4ZVVzd2RL?=
 =?utf-8?B?UUdVMFhETFZKQm9uMHpDNlZFTFVJdGxVWlRLc0RBSUNuQzErZnQvYzZudU5C?=
 =?utf-8?B?aEloNzdQbldnQzc0MHNBclNYRDdBSnUrZVJ5c3RVTHFCc1pLaVNoWm93aUZ1?=
 =?utf-8?B?RDA2cTZGS3JMZDdZbG1PMUJYeE5EVjdrS21oMmdQUXpFVlNTd0pYM3R4RzNG?=
 =?utf-8?B?VTUvd2ZnbkhNNFkzSVNVMmtITXJJTDRiMUFGcU5pdGNIZnRkY0NNRExuNVRD?=
 =?utf-8?B?Y0ZSZThSYnhybTVKMWdkUWQ2c2F5YkIzVFZvTGRDZ3ZZK1RvNk9mSDlzVUlW?=
 =?utf-8?B?VEp4bHVWalJ6UWRpdUt5YTFHUEp4UEw2SHEwQ3ZnRENhTFRqYWVleGdaeTZl?=
 =?utf-8?B?TUw5ajRBVHVOM2FFdk42YW9weXRxZDM4RW5ic00xaktJeTlFTmtyMVlYTkJC?=
 =?utf-8?B?ZGNRQmVLK0EzcmFEckIxUHFrWlpMYStQMElkN2ZHWXhZd2gwQzJKMk1RT2FF?=
 =?utf-8?B?Z2ZBbXlvei9iUlBCd2xqZ2ZIOXBqeVlQYi8yOFJpaWxVZU44dEdVbGh6d1hj?=
 =?utf-8?B?V1Zwdk0zUVFkQnFtSlZSaEsvTmZwTk1xMExMUTh1N2c4bWlLVnNUNUJNa1dF?=
 =?utf-8?B?dFp1SEJQS0tIT0VHT2pqKythUkxXUTUvVERmRXphWFlGUVVEN2ZENjdCQVM2?=
 =?utf-8?B?cjFNK2RYNlViN2V6UmpJRHY2UkwvOVpMWjNySXdKUHFJVXdvTEVma090Z2J0?=
 =?utf-8?B?cWx1bno2ZkFUeGt1VzF2cDhuREFpMlFVRGxaOEN0ZDZaa2tVOWNZaExnWVFQ?=
 =?utf-8?B?TXJ2dEdLV3FNUTkxTHlvVFJxUG1NenV5UGVQRlRPTTAxRi9idXRja1RhdFRp?=
 =?utf-8?B?bzZ1Y3RhTWM4ZGNXQnFxcDc2VjZaU3Znam5LTGJKKytWVitjZkFSaDZaZ2F3?=
 =?utf-8?B?K3JyQWQyOXhkcmlYcFN5NWhWeXdWNEcvSzNqaGM2YzVTRkdNeEU3V1h4bTdG?=
 =?utf-8?B?N1AwcnlQYmdSS1l3VFhTZVFCbFM5VUFNOURILzlDZlR4NG9FT2pTNFdMU2pC?=
 =?utf-8?B?NXh0bjhpMDFyaDhNK011Z1RyanRiYWRJY0dZRXFmSWowVFZWb28wVUJSWG5D?=
 =?utf-8?B?UU5PVWo4TW5kQjVSVytQTWNJci9sRFQ1ejJPRG1pQjlGSm5lb01TbTlmd0Vu?=
 =?utf-8?B?emlsZkNYM290TlJ5ZXVCREdYQ1VTR1Y3bkgxU25tZGN5VHBaZ01NVkVBMk5J?=
 =?utf-8?B?RllsbjdPRDIzSTNXQXJNZ200RUY2UGwrSndZVWE5bS8xQXpvdVJxTHVuY2tN?=
 =?utf-8?B?NTAxOEVFbGJjcVhCTGNlZlNJeXgwUUVSSHkyenNHY3BZTFd4MlJ6MWxGT3Ft?=
 =?utf-8?B?TXVFaGZTNmRBSGhlWVF5T05LZDdXT0ZtYXRMakkwcUNScXFkeFY3eHkvUDlr?=
 =?utf-8?B?aTYybnVIUGJOVFBkZklub3U0YXQwbnV0S2dKUjlkR0d6VFZmeEhjZHNZTElJ?=
 =?utf-8?B?Q3FndkpPdnJQVlhvQnhaQ0tXckRBZysrOUNQRFVnODhOYW4wbi9hbVNRdjBK?=
 =?utf-8?B?UG9RY1ZHNmg2dEgwVFc4OU5KVWg4ZnUydDNjTHFSQnhIbFg0Mm1GSHJYdGxL?=
 =?utf-8?B?N1dHQjVDekhvK1hnMVpkQ0JScVd1UzltbzU4SEw0MlhrM3hMSDRhcjZYM0tB?=
 =?utf-8?B?MTBoVXVqN1BWbjVqRWJLaHhwOVJPbTVvY1grSEhFL2c4YTk5WjJURHE2b09w?=
 =?utf-8?B?czkrcnRQN296cFdPOWlWbExvVEpqM3RzVjAyYkhkTFZFbTU3Q1RIbXdibXI1?=
 =?utf-8?B?dnVIS0xQWlpYbFlrUmNaaGpxbDVqMlVzT284NHBYK1BrM3l6Q0xNVmxQaG1X?=
 =?utf-8?B?WDRueXZuRkxzN0I0dllkMlNOWUgzNnEyYzB3WnZkNEtFOFhJVTVDcXQ2U0RK?=
 =?utf-8?B?b3hHUmF5TWYveUVpMTdrQ0lOdFAydkljczNQME9Oc2lmUUVTQVFhNnd1TDA4?=
 =?utf-8?B?NU9RSHFjbFRDLzYxV0s2RjcrZ0lPK0ZaVmRkdDkxUHBDdDNJNU02QWEwWVRu?=
 =?utf-8?B?OGZod2J5TUI3WnplUkNRR2NWRWJYUVZydlAwMjN0QWU1VlJpOXZoOEJkUTlV?=
 =?utf-8?B?M1lmWTlud29KcTlCa3lEOW5nazUvSDNwMnR4TGNkZVB4ZlB2TVhJU0ViclFy?=
 =?utf-8?B?Y1dKWjdPaVc3VVNmOFg1TjRQQk1ieUE2bFkyV21FbnBHS2RSc1VRajB1V2Zk?=
 =?utf-8?B?eGtINW1Fd1F0UVluN2k1WU9jMEwwQWtuLytxWUJTUEQvQUJhRmMxSG1LWDVx?=
 =?utf-8?Q?Xzj5q8czWT5x48Kt965641y+BWVJQFPITix8ilLLYmH57?=
X-MS-Exchange-AntiSpam-MessageData-1: pt0/Hy/AIIB1DQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88968f5-ca2c-4153-16e7-08ded7641a4f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 11:30:07.3174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fQH81D8uzOaKtEoSDPu4AH8GReEgl7E+IURV9YQkOzqMTbgbVlZYhwLMYa+ADNliCFiyaODdbHn1Om27x380w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997
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
> Add a faux::Device type that wraps struct faux_device and implements
> AsBusDevice, enabling faux devices to be used as parent devices for
> subsystems that require a bus device, such as DRM.
>
> Update Registration to return &faux::Device<Bound> via AsRef.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

(one small comment below)

> ---
>  rust/kernel/drm/gem/shmem.rs     | 11 +++--
>  rust/kernel/faux.rs              | 69 +++++++++++++++++++++++++++-----
>  samples/rust/rust_driver_faux.rs |  3 +-
>  3 files changed, 68 insertions(+), 15 deletions(-)
>
> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index 3ee19ef6264e..52de59b14dad 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs
> @@ -692,10 +692,12 @@ impl drm::Driver for KunitDriver {
>      fn create_drm_dev() -> Result<(faux::Registration, UnregisteredDevic=
e<KunitDriver>)> {
>          // Create a faux DRM device so we can test gem object creation.
>          let data =3D try_pin_init!(KunitData {});
> -        let dev =3D faux::Registration::new(c"Kunit", None)?;
> -        let drm =3D UnregisteredDevice::new(dev.as_ref(), data)?;
> +        let reg =3D faux::Registration::new(c"Kunit", None)?;
> +        let fdev =3D reg.as_ref();
> +        let dev =3D fdev.as_ref();
> +        let drm =3D UnregisteredDevice::new(dev, data)?;
> =20
> -        Ok((dev, drm))
> +        Ok((reg, drm))
>      }
> =20
>      #[test]
> @@ -755,7 +757,8 @@ fn vmap_io() -> Result {
>      #[test]
>      fn fail_sg_table_on_wrong_dev() -> Result {
>          let (_dev, drm) =3D create_drm_dev()?;
> -        let wrong_dev =3D faux::Registration::new(c"EvilKunit", None)?;
> +        let reg =3D faux::Registration::new(c"EvilKunit", None)?;
> +        let wrong_dev =3D reg.as_ref();
> =20
>          let obj =3D Object::<KunitObject, _>::new(&drm, PAGE_SIZE, Objec=
tConfig::default(), ())?;
> =20
> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> index 36c92ae2943c..cd0724af446b 100644
> --- a/rust/kernel/faux.rs
> +++ b/rust/kernel/faux.rs
> @@ -9,15 +9,63 @@
>  use crate::{
>      bindings,
>      device,
> -    prelude::*, //
> +    prelude::*,
> +    types::Opaque, //
>  };
> -use core::ptr::{
> -    addr_of_mut,
> -    null,
> -    null_mut,
> -    NonNull, //
> +use core::{
> +    marker::PhantomData,
> +    ptr::{
> +        null,
> +        null_mut,
> +        NonNull, //
> +    },
>  };
> =20
> +/// A faux device.
> +///
> +/// A faux device is a virtual device backed by the faux bus, primarily =
used for scenarios where a
> +/// real hardware device is not available or for testing.
> +///
> +/// # Invariants
> +///
> +/// The underlying `struct faux_device` is valid and the embedded `struc=
t device` is initialized.
> +#[repr(transparent)]
> +pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
> +    Opaque<bindings::faux_device>,
> +    PhantomData<Ctx>,
> +);
> +
> +impl<Ctx: device::DeviceContext> Device<Ctx> {
> +    #[inline]
> +    fn as_raw(&self) -> *mut bindings::faux_device {
> +        self.0.get()
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `ptr` must be a valid pointer to a `struct faux_device`.

The invariant for `Device` also says: "... and the embedded `struct
device` is valid". IIUC this requirement should also be mentioned here,
unless we consider that a valid `struct faux_device` also implies that
its embedded `struct device` is initialized, in which case that bit can
be removed from the invariant section of `Device`.
