Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD89606A337
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=q9wdIwR4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F7FE10FAC0;
	Wed, 11 Nov 2026 11:08:11 +0000 (UTC)
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022077.outbound.protection.outlook.com [52.101.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B93B10FAC0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2pfHU1iueh8JFpGTrQldz3WDaBYh25MXoTBqBYB1CS0VsSJt6oEi71lBXhA41D/k9LDht9gireOJRMi4LM65USw2gIlMBWQDELpvey46C8QfW5Jlz7UfEoJVUBMvNzSg5gmT4VPyW/9unQCVasLqDxSi9dZEbwTLD7yLaklsQ2fZuN77ui2JdSL0Ukuf6BnQT7PmCIzGqMAV6Xyg8BD4a3jy6GCzcPU9L5AKhumNUDiorABtbE1TVHFxgBWzaC2w/mOiucug54xRlN1HjJ2r8Z9Gl7mf0443RmS+9CoZi5DGL9emWvMkogiMQJCdmouoZoD3OlJ9oA2kd7CuAHbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8NV9H+YXJ+HyEpSqCAMnmrZ/ytEDXcFFEteMqG79eg=;
 b=zFgcMkbO2YLp8luVvyfeYXdRvhbq87PQ8UzgV+LIdpj2Vr1q7sbCa50iB+bpPtypo5YJH+R3MXXW8ZEgf7hJDvNTKqsvYUmr7bX0NrtVCG+1IFOUDeQfHk0Q2TUKzjnz8jVZWGxMWz6306sNOx+ApbINZxVAOX1yj6mELBzTiojajOd8mulDc6hrmczEcDrGfxc7oL5uySfY6yvT37Eu47OKNzkC/C31APRd4/GAXnDrQyyyumsN10yvZQbjeCP5SuWPPQtFI3vJ3bigXJoykYTOub6IMVkXilHCPY8zzWUsCroBfFsVV0aharqPtGFosc73GSiukO7G63iErCRXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8NV9H+YXJ+HyEpSqCAMnmrZ/ytEDXcFFEteMqG79eg=;
 b=q9wdIwR4ddbBarMtznuyj4vSLnY+Jm57ab3rEUonE+xk7T2wJmVfIpjue1y3y+XuwKMObSg/ekxW0PeCLV/aMQSrbsSY1AiBVXWHI0LKWCo24ZTDHp13Z+aSl1ciTNEJ0xwvXfhb87UeT0Y1ksjSeXUmZVBCDP5ZXhnAmUr+2nI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO7P265MB8858.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 11:08:01 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 11:08:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 11:08:00 +0000
Message-Id: <DMSC1FLE123G.216Y0UZY0OKZU@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] rust: drm: make Driver::File lifetime-parameterized
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <daniel.almeida@collabora.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <tamird@kernel.org>, <work@onurozkan.dev>, <brauner@kernel.org>,
 <lyude@redhat.com>, <j@jananu.net>, <alvin.sun@linux.dev>,
 <deborah.brouwer@collabora.com>, <laura.nao@collabora.com>,
 <beata.michalska@arm.com>
X-Mailer: aerc 0.22.0
References: <20261107021427.2105374-1-dakr@kernel.org>
 <20261107021427.2105374-8-dakr@kernel.org>
In-Reply-To: <20261107021427.2105374-8-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::20) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO7P265MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 21860560-3fc2-410f-96aa-08df3fe40ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|10070799003|1800799024|18002099003|22082099003|6133799003|921020|4143699003|10067099003|56012099006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021135927099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: qbGz4bZ19091kewJgf4IM+szy8AbFCBke17sKZu1xrZwA4vNhZScBZPj5G+fPWgMKo9OdZHtMBeO0xrL+mUXvrxU9nflsJAzu2O8GadzWLR8NuCXPCmUOVfZsOwRT9u4xdOVimNrW/THGBZvVm+wwTWbmmSFjNesTZ63ACBigm3aN/Bp8joUBYhfd9k4OSTV8j4gUymms4M5cz/yTSjOyDjymdM5hkvRUH96GIxrR6WwPLmn7wgOXURW2GF7tfTjEPSX27IqcqD8QOwrrYUEmCViWmIOq6XaHBwk+rQ/QljJvgkM41GAd16P/NaR4s1VqfriFUGLL+ro3kXG4+y5FASJMT15fDxAbY9kR15Qa5Dbn6dckhjSvJy+ZBpc/2+0J+j6+8b6aFR+Cr6/bUQTs3gVWyBMXlY7o6dNVsNhqWnCkdFg1719HWQlAa3aYmdZrtHy2hHdEWRYtdjzm2Z9/dBQmgM5023Xu2xrWh7cLHFryC4YfH2SAXkkdEFIkoNZ9JZuN+1bsv9dixqsWP1bx9OUsot937I8N7O8MZclMK94J5FxxnCztFgIh0F16Bg4MWUBb8ZsFDTlREBRyo8BXkgdAIAS2ErSSG5xjiVoNh2SdBYtLE/X4BTob5of/4LPP9EFmir34YbZ0VzimcCO2OJIqlszsNu/rMRF7ruIVF4a4u98oMMkxk2UcFpWmZOsqL0ZlcaMxXh9UsHVnR/kZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(10070799003)(1800799024)(18002099003)(22082099003)(6133799003)(921020)(4143699003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021135927099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXRKa08xYTdkUlZnNVhCOWhRWlhna2VDaWxLRW0wbWloc1dBUmNsZ0R3NVlR?=
 =?utf-8?B?S2dPazZ3ODdSVFg0UFR3emFadEJZOHpMcDJqOUx4c1h1UFdZalZFdng0cGc5?=
 =?utf-8?B?UktFV3Z3eTBaS216cjhrMHMwT0YxYTh3SGdMRnVadEZZRnlIMFhjMmJxcTho?=
 =?utf-8?B?SlAvVndMY0xna3dQdzBpU1A2azFiL2VYTGxxcTRoVFppZFVEUFNvNklLR1Iz?=
 =?utf-8?B?cllod3NXUEt4N1h6MUwvWXNnSjRVVDhUSDhxbURCaHB5MTYrUWhsbEpPRGlR?=
 =?utf-8?B?SURoT1pDRlJTSDdKMG5nOWlveU56MExnN0lzSG00MmlNcUJ3djJSUWMrUU90?=
 =?utf-8?B?bDlTdjl3TFlleUtadTFCTnBXSE9YSXp4a3NrRW9HN1J2YzVLS3JtSTBEdEds?=
 =?utf-8?B?cGMxZHBITHkxcENxYUxXMlJ4U05nSHRkU0xBSFE3T3dsM0VSMGc3WlgvQlNa?=
 =?utf-8?B?N3M3RHV6bFFnQ1dGbEhBQ29qbGxaVXhFVHFUZWM5V1BDdHZNWU5TbEhIUGxr?=
 =?utf-8?B?QmNiZ0t3Nm5USjNMUWM3elNsVm1ZaUhtTlJPdzhDakRRTWxHcnFVWEd0SW9Q?=
 =?utf-8?B?N2c1ZDRNRERlSDVWbEVsZld6RzU3WWE0QnpVd05YclFuU2xubUVWSUZDZVNv?=
 =?utf-8?B?YStUQkNQYnNXWjVUMFdDTVIyTnNOcGpzSUsxc0dyY2cybHVwejNoY1lsUkdJ?=
 =?utf-8?B?RElNblk4QlovVjRwcDNzY0dqSXk5M2dBZmtDc2VNT1ZJbXpLUHpmSW5uMmlt?=
 =?utf-8?B?R0ZaZEhxMVkyRDg3Qm1sME5TWWdKUkZic2xLeFhMUklaY3JVMG5jbDV4OHEz?=
 =?utf-8?B?Mk1sSW5mVjYwZFhpTHl4SGw3UFhVblVhZmdnbXg3S2JmM1dBOE80ZDZrUjlP?=
 =?utf-8?B?WkNEdG9DeHE0bDc3WUR3OHpsTlhTVGY4bzFxNVRrVWwwK1VpY3pOendrc1Q4?=
 =?utf-8?B?VkRLK2tYSzQ2QWdMVUdmcXJJQXV3VkFPTmV2bzR3ait1bVNXVnc3dytNditN?=
 =?utf-8?B?T08vbjVhNDRseHZDOUdtTFY0VzJHWkFQV3JGZ2pYellZVUh4azZEd1BZS1B5?=
 =?utf-8?B?bkJqNXhTR1ptYS9JUFRXdXdnY0NLdENrZ3pxaDhRcDBOK1FIRFRxak43bEUr?=
 =?utf-8?B?WHBxaUpiY1RTVnh2UmdHYmpSdFNFL3daRU4zVEFiajAwbzV5ck8yc1MvSjhn?=
 =?utf-8?B?Z1FmOHl4MkliWTRMRFpScWtvTUs1ZFBHaHdlNkZWYjhxSkNVTms1TlFnWXYv?=
 =?utf-8?B?U1F4KzdOYlh0MFFrSk83Wmd5WEZ3anJWTkZvMkRrU0RyOUlPR1NMWnhNdms2?=
 =?utf-8?B?WVo5SmRMVnF3T2FsYjVIQXVNQWw4MURBRHh1QUV6NVVQcHltcGJXYVVXdEtv?=
 =?utf-8?B?a3A2dUhWeFRJZlI5MXB6Zk5vbGI5WnNaWFROZVJPRmVuSVZVTnVpWjFnTTFN?=
 =?utf-8?B?ZTRFV3ZvU3BRM1NyQkNKTTNaeHJCekVsNCtYcmN1TWhkeC94NTNCNFpJOFg1?=
 =?utf-8?B?QysvZmtCaVJBQ3R4NldtNi8wZ0RZekpmYVF6a1pROG1pdkNNbEkyRFQ2emJt?=
 =?utf-8?B?a0NvRVJ1cWNMNzV3MkdoTTdXaGllWStUQVp2dzU5QnI1Yzh4MGhCRkZONnAw?=
 =?utf-8?B?UkpWS3dlRXBRK2JpVTZseXY4WHNZcFpXMzR3dXdlUkUwMUpXRDI3K3hlbjRi?=
 =?utf-8?B?TlRnWnRzMnBPMnUzeVZaSG44WitJWTA3Y1pLb0dSVFp0eUdDMVNEemlIVGht?=
 =?utf-8?B?MlhORVRJSTZVM2lib0NyOWFCNFBZaXZ4OTFBZDhRNnp2L3ZmdnVsNnl6b0Q4?=
 =?utf-8?B?MThiUW9nd1NURG5TbEIxbHliblhqZS9WUmZSZ0VydGFOSEpTMFpUV1NqTzlW?=
 =?utf-8?B?eEowTjNNV2xTUE41ZTdpQTNacWlFZkVKM051UGw2dGp6a3ZSSFFMZWJkM1J5?=
 =?utf-8?B?RnlGOVljbk1aTzlzNDV1bW9XMlVIVnJaSUE0UGphSlhNZjVnNmpIVHdRbjJa?=
 =?utf-8?B?blRDenNOUGlMQWREV0xqWjAwVTUvRnJ4K0dORlYwYlQ4bUw5VTV6dG8wemh0?=
 =?utf-8?B?RFVhQWczc1hkbmdURWtGclI1V2hFRTVZMXhBdlZ1a0czMm9aZjNmU1IyOEQ5?=
 =?utf-8?B?czQ2aUNSM3VLLzZwdjJMcEJEVU5VV05IeHZoOTluYzZ3WDl6Vm9GdFZ2alo0?=
 =?utf-8?B?WmJGam1STEU3NVkvQVNuWU1ockNmSHRjTFpwcWdUTFFxMEVuOExLKzQ3cDFJ?=
 =?utf-8?B?bjE0MDNKSUNSRytXOUx6SU1WMWJHTkhrQXJtWGJxeStxTGtKd2cwaGh2OGJ5?=
 =?utf-8?B?aFdsVllrRzg3UkIvaHgyR29vMzlYMHBRR2dwL014WitZQmdiRnlUdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 21860560-3fc2-410f-96aa-08df3fe40ca0
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 11:08:00.8827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVRudlwcA6Eer4N255e3Bmd2qS53b2xKaojY48Qr8AwXJxAHtdOmuZ2E2OeTQ6qDwcD930VWzNv1YGc5iUBSqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB8858
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat Nov 7, 2026 at 2:03 AM GMT, Danilo Krummrich wrote:
> Make the DRM file private data lifetime-parameterized, allowing drivers
> to borrow from RegistrationData in their per-file data.
>
> Introduce DriverFile<'a> as a lifetime-parameterized trait that receives
> both the device and registration data in open(). Parametrize File<D> on
> the driver type rather than the file data type, deriving the concrete
> file type through Driver::File<'a>.
>
> Add inner_with() to access the driver file data from a File<D> reference.
>
> Ensure file data is always dropped before registration data:
>
>   - In Registration::drop(), detach driver_priv for all open files under
>     filelist_mutex, then drop the detached data after releasing the mutex
>     and wait for file-data destruction in concurrent postclose_callback()
>     calls via an open_count / WaitQueue pair on drm::Device.
>
>   - In postclose_callback(), skip the drop if driver_priv has already
>     been NULLed by the filelist iteration. The NULL write is visible
>     through the filelist_mutex acquire/release chain in
>     drm_close_helper().
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/drm/nova/driver.rs |   2 +-
>  drivers/gpu/drm/nova/file.rs   |  13 ++-
>  drivers/gpu/drm/nova/gem.rs    |   8 +-
>  drivers/gpu/drm/tyr/driver.rs  |   2 +-
>  drivers/gpu/drm/tyr/file.rs    |  11 +-
>  rust/kernel/drm/device.rs      |  36 +++++--
>  rust/kernel/drm/driver.rs      | 113 +++++++++++++++++++--
>  rust/kernel/drm/file.rs        | 180 ++++++++++++++++++++++++---------
>  rust/kernel/drm/gem/mod.rs     |  44 ++++++--
>  rust/kernel/drm/gem/shmem.rs   |   9 +-
>  rust/kernel/drm/ioctl.rs       |   6 +-
>  11 files changed, 330 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
> index 2b6fe9dc0bfa..2a21ff8ba579 100644
> --- a/drivers/gpu/drm/nova/gem.rs
> +++ b/drivers/gpu/drm/nova/gem.rs
> @@ -11,9 +11,9 @@
>      sync::aref::ARef,
>  };
> =20
> -use crate::{
> -    driver::{NovaDevice, NovaDriver},
> -    file::File,
> +use crate::driver::{
> +    NovaDevice,
> +    NovaDriver, //
>  };
> =20
>  /// GEM Object inner driver data
> @@ -43,7 +43,7 @@ pub(crate) fn new(dev: &NovaDevice, size: usize) -> Res=
ult<ARef<gem::Object<Self
>      /// Look up a GEM object handle for a `File` and return an `ObjectRe=
f` for it.
>      #[inline]
>      pub(crate) fn lookup_handle(
> -        file: &drm::File<File>,
> +        file: &drm::File<NovaDriver>,
>          handle: u32,
>      ) -> Result<ARef<gem::Object<Self>>> {
>          gem::Object::lookup_handle(file, handle)
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.r=
s
> index c2b99d67369f..46caf7b336d9 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -209,7 +209,7 @@ fn drop(self: Pin<&mut Self>) {}
>  impl drm::Driver for TyrDrmDriver {
>      type Data =3D ();
>      type RegistrationData<'drm> =3D TyrDrmRegistrationData<'drm>;
> -    type File =3D TyrDrmFileData;
> +    type File<'a> =3D TyrDrmFileData;
>      type Object =3D Bo;
>      type ParentDevice<Ctx: DeviceContext> =3D platform::Device<Ctx>;
> =20
> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> index 6850708cfcdd..933a365cb016 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs
> @@ -19,13 +19,16 @@
>  #[pin_data]
>  pub(crate) struct TyrDrmFileData {}
> =20
> -/// Convenience type alias for our DRM `File` type
> -pub(crate) type TyrDrmFile =3D drm::file::File<TyrDrmFileData>;
> +/// Convenience type alias for our DRM `File` type.
> +pub(crate) type TyrDrmFile =3D drm::file::File<TyrDrmDriver>;
> =20
> -impl drm::file::DriverFile for TyrDrmFileData {
> +impl drm::file::DriverFile<'_> for TyrDrmFileData {
>      type Driver =3D TyrDrmDriver;
> =20
> -    fn open(_dev: &drm::Device<Self::Driver>) -> impl PinInit<Self, Erro=
r> {
> +    fn open(
> +        _device: &TyrDrmDevice<Registered>,
> +        _reg_data: &TyrDrmRegistrationData<'_>,
> +    ) -> impl PinInit<Self, Error> {
>          Ok(Self {})
>      }
>  }
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index b8444499b39c..bd66e55b6e17 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -15,9 +15,13 @@
>      },
>      error::from_err_ptr,
>      prelude::*,
> -    sync::aref::{
> -        ARef,
> -        AlwaysRefCounted, //
> +    sync::{
> +        aref::{
> +            ARef,
> +            AlwaysRefCounted, //
> +        },
> +        atomic::Atomic,
> +        WaitQueue,
>      },
>      types::{
>          NotThreadSafe,
> @@ -190,7 +194,10 @@ fn deref(&self) -> &Self::Target {
>      }
>  }
> =20
> -impl<T: drm::Driver> UnregisteredDevice<T> {
> +impl<T: drm::Driver> UnregisteredDevice<T>
> +where
> +    for<'a> T::File<'a>: drm::file::DriverFile<'a, Driver =3D T>,

Hmm, shouldn't this bound be on drm::Driver?

Does

    type File<'a>: DriverFile<'a, Driver =3D Self> + 'a;

not work?

> +{
>      const fn compute_features() -> u32 {
>          let mut features =3D drm::driver::FEAT_GEM;
> =20
> @@ -203,8 +210,8 @@ const fn compute_features() -> u32 {
> =20
>      const VTABLE: bindings::drm_driver =3D drm_legacy_fields! {
>          load: None,
> -        open: Some(drm::File::<T::File>::open_callback),
> -        postclose: Some(drm::File::<T::File>::postclose_callback),
> +        open: Some(drm::File::<T>::open_callback),
> +        postclose: Some(drm::File::<T>::postclose_callback),
>          unload: None,
>          release: Some(Device::<T>::release),
>          master_set: None,
> @@ -333,6 +340,21 @@ pub fn new(
>          // SAFETY: `raw_drm` is valid; no concurrent access before regis=
tration.
>          unsafe { (*raw_drm.as_ptr()).registration_data =3D UnsafeCell::n=
ew(NonNull::dangling()) };
> =20
> +        // SAFETY: `raw_drm` is valid; no concurrent access before regis=
tration.
> +        unsafe { (*raw_drm.as_ptr()).open_count =3D Atomic::new(0) };
> +
> +        // SAFETY:
> +        // - `raw_drm` is valid and `open_count_wq` is uninitialized; no=
 concurrent access
> +        //   before registration.
> +        // - The field is pinned because the Device is pinned (refcounte=
d, allocated by
> +        //   `__drm_dev_alloc()`, never moved).
> +        unsafe {
> +            pin_init::raw_init(
> +                &raw mut (*raw_drm.as_ptr()).open_count_wq,
> +                crate::new_waitqueue!("drm_open_count"),
> +            )
> +        };
> +
>          // SAFETY: The reference count is one, and now we take ownership=
 of that reference as a
>          // `drm::Device`.
>          // INVARIANT: We just created the device above, but have yet to =
call `drm_dev_register`.
> @@ -357,6 +379,8 @@ pub struct Device<T: drm::Driver, C: DeviceContext =
=3D Normal> {
>      dev: Opaque<bindings::drm_device>,
>      data: T::Data,
>      pub(super) registration_data: UnsafeCell<NonNull<T::RegistrationData=
<'static>>>,
> +    pub(super) open_count: Atomic<i32>,

32-bit open count is enough if you want to skip the overflow checks. Consid=
er
change to `Atomic<i64>` or `Atomic<u64>` instead.

Or is DRM somehow enforcing that no more than 2**31 files can be open again=
st a
device?

> +    pub(super) open_count_wq: WaitQueue,
>      _ctx: PhantomData<C>,
>  }
> =20
> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index f6db91e81e79..92055c4f9e00 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -7,10 +7,22 @@
>  use crate::{
>      bindings,
>      device,
> -    drm,
> +    drm::{
> +        self,
> +        file::FileData, //
> +    },
>      error::to_result,
> +    interop::list::clist_create,
>      prelude::*,
> -    sync::aref::ARef, //
> +    sync::{
> +        aref::ARef,
> +        atomic::{
> +            Acquire,
> +            Release, //
> +        },
> +        Mutex, //
> +    },
> +    types::Opaque, //
>  };
>  use core::{
>      marker::PhantomPinned,
> @@ -120,8 +132,14 @@ pub trait Driver {
>      /// The type used to manage memory for this driver.
>      type Object: AllocImpl;
> =20
> -    /// The type used to represent a DRM File (client)
> -    type File: drm::file::DriverFile;
> +    /// The type used to represent a DRM File (client).
> +    ///
> +    /// File data may borrow from [`RegistrationData`](Driver::Registrat=
ionData). File data is
> +    /// guaranteed to be dropped before registration data, either when t=
he file is closed or
> +    /// when the device is unregistered, whichever comes first.
> +    ///
> +    /// Drivers implement [`DriverFile`](drm::file::DriverFile) for thei=
r file data type.
> +    type File<'a>: 'a;
> =20
>      /// The bus device type of the parent device that the DRM device is =
associated with.
>      type ParentDevice<Ctx: device::DeviceContext>: device::AsBusDevice<C=
tx>;
> @@ -197,6 +215,13 @@ pub unsafe fn new<E>(
>                  // SAFETY: `drm` is a valid, initialized but not yet reg=
istered DRM device.
>                  let ret =3D unsafe { bindings::drm_dev_register(drm.as_r=
aw(), 0) };
>                  to_result(ret).inspect_err(|_| {
> +                    // SAFETY:
> +                    // - Failed registration unplugs the device and drai=
ns registration guards.
> +                    // - `data` remains initialized until this closure r=
eturns.
> +                    // - Failed initialization does not run `Registratio=
n::drop()`, so this is
> +                    //   the only file-data cleanup for this device.
> +                    unsafe { Self::drop_file_data(drm) };
> +
>                      // SAFETY: `drm_dev_register()` synchronizes SRCU on=
 failure, so no
>                      // concurrent access to `registration_data` is possi=
ble at this point.
>                      unsafe { *drm.registration_data.get() =3D NonNull::d=
angling() };
> @@ -209,6 +234,75 @@ pub unsafe fn new<E>(
>      pub fn device(&self) -> &drm::Device<T> {
>          &self.drm
>      }
> +
> +    /// Detaches and drops file data, then waits for concurrent postclos=
e destruction.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `drm` must be unplugged with all `RegistrationGuard` sections =
drained.
> +    /// - Its registration data must remain alive until this function re=
turns.
> +    /// - This must be the only call for this device.
> +    unsafe fn drop_file_data(drm: &drm::Device<T>) {
> +        let raw =3D drm.as_raw();
> +        let mut files =3D None;
> +
> +        // SAFETY: `filelist_mutex` is initialized by `drm_dev_init()` a=
nd remains valid for
> +        // the lifetime of the `struct drm_device`.
> +        let filelist_mutex =3D unsafe { Mutex::from_raw(&raw mut (*raw).=
filelist_mutex) };
> +        {
> +            let _guard =3D filelist_mutex.lock();
> +
> +            // SAFETY:
> +            // - `filelist` is initialized and protected by the held mut=
ex.
> +            // - Its entries are `drm_file`s linked through `lhead`; `Op=
aque` has the same layout.
> +            let filelist =3D unsafe {
> +                clist_create!(
> +                    &raw mut (*raw).filelist,
> +                    Opaque<bindings::drm_file>,
> +                    bindings::drm_file,
> +                    lhead
> +                )
> +            };
> +
> +            // Detach the allocations so `postclose()` sees NULL and lea=
ves their destruction to us.
> +            // After `postclose()` returns, the DRM core can free the C =
file, so the detached list
> +            // must not depend on it. All `RegistrationGuard` sections h=
ave already been drained.
> +            for file in filelist.iter() {
> +                // SAFETY: `file` is a valid `drm_file` on this device's=
 filelist.
> +                let priv_ptr =3D unsafe { (*file.get()).driver_priv };
> +
> +                // SAFETY: Setting `driver_priv` to NULL is visible to `=
postclose_callback()`
> +                // through the `filelist_mutex` acquire/release chain in=
 `drm_close_helper()`.
> +                unsafe { (*file.get()).driver_priv =3D core::ptr::null_m=
ut() };
> +
> +                // SAFETY:
> +                // - `priv_ptr` comes from `KBox::into_raw()` in `open_c=
allback()`.
> +                // - The file is still in the list, so `postclose_callba=
ck()` has not run. Clearing
> +                //   `driver_priv` transfers ownership here and makes a =
later postclose skip it.
> +                // - Only the owning pointer is moved; the pinned alloca=
tion is dropped in place.
> +                let mut data =3D unsafe {
> +                    Pin::new_unchecked(KBox::from_raw(
> +                        priv_ptr.cast::<FileData<T::File<'static>>>(),
> +                    ))
> +                };
> +                *data.as_mut().project().next =3D files.take();
> +                files =3D Some(data);
> +            }
> +        }
> +
> +        // Run driver destructors without `filelist_mutex`. Take each li=
nk before dropping its
> +        // allocation to avoid recursively dropping the entire chain.
> +        while let Some(mut data) =3D files {
> +            files =3D data.as_mut().project().next.take();
> +            drop(data);
> +            drm.open_count.fetch_sub(1, Release);
> +        }
> +
> +        // Wait for file-data destruction in concurrent `postclose_callb=
ack()` calls. No new opens
> +        // can succeed after unplug, so `open_count` is monotonically de=
creasing.
> +        drm.open_count_wq
> +            .wait_event(|| drm.open_count.load(Acquire) =3D=3D 0);
> +    }
>  }
> =20
>  // SAFETY: `Registration` doesn't offer any methods or access to fields =
when shared between
> @@ -230,8 +324,13 @@ fn drop(self: Pin<&mut Self>) {
>          // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The =
existence of this
>          // `Registration` also guarantees that this `drm::Device` is act=
ually registered.
>          unsafe { bindings::drm_dev_unplug(self.drm.as_raw()) };
> -        // After drm_dev_unplug(), the SRCU barrier guarantees that all =
RegistrationGuard critical
> -        // sections have completed, so no one holds a reference to reg_d=
ata anymore.
> -        // reg_data is dropped here automatically.
> +
> +        // SAFETY:
> +        // - `drm_dev_unplug()` has unplugged the device and drained reg=
istration guards.
> +        // - Registration data remains alive until this destructor retur=
ns.
> +        // - Registration succeeded, so this destructor performs the onl=
y file-data cleanup.
> +        unsafe { Self::drop_file_data(&self.drm) };
> +
> +        // Registration data is dropped here automatically, after all fi=
le data has been dropped.
>      }
>  }
> diff --git a/rust/kernel/drm/file.rs b/rust/kernel/drm/file.rs
> index bd5e4ca2977f..2dd0e61718fb 100644
> --- a/rust/kernel/drm/file.rs
> +++ b/rust/kernel/drm/file.rs
> @@ -45,60 +75,110 @@ pub(super) fn as_raw(&self) -> *mut bindings::drm_fi=
le {
>          self.0.get()
>      }
> =20
> -    fn driver_priv(&self) -> *mut T {
> -        // SAFETY: By the type invariants of `Self`, `self.as_raw()` is =
always valid.
> -        unsafe { (*self.as_raw()).driver_priv }.cast()
> +    /// Returns the registered DRM device this file was opened on.
> +    #[inline]
> +    pub fn device(&self) -> &drm::Device<D, drm::Registered> {
> +        // SAFETY:
> +        // - The open file keeps its minor and device alive.
> +        // - By the type invariants, the device uses driver `D`.
> +        // - The type invariants require a `RegistrationGuard` for the d=
evice throughout this
> +        //   borrow, satisfying the `Registered` context.
> +        unsafe { drm::Device::from_raw((*(*self.as_raw()).minor).dev) }
>      }
> =20
> -    /// Return a pinned reference to the driver file structure.
> -    pub fn inner(&self) -> Pin<&T> {
> -        // SAFETY: By the type invariant the pointer `self.as_raw()` poi=
nts to a valid and opened
> -        // `struct drm_file`, hence `driver_priv` has been properly init=
ialized by `open_callback`.
> -        unsafe { Pin::new_unchecked(&*(self.driver_priv())) }
> +    /// Access the driver file data through a closure.
> +    ///
> +    /// The closure receives a pinned reference to the file data.
> +    ///
> +    /// The outer reference carries the `&self` lifetime while the inner=
 type carries the HRTB
> +    /// lifetime `'a`, implying `'a` outlives `&self`. This allows the c=
losure to coerce covariant
> +    /// sub-fields (e.g. `&'a T` to the caller's lifetime) and return th=
em directly in `R`.
> +    #[inline]
> +    pub fn inner_with<'this, R, F>(&'this self, f: F) -> R
> +    where
> +        F: for<'a> FnOnce(Pin<&'this D::File<'a>>) -> R,
> +    {
> +        // SAFETY: By the type invariants, `self.as_raw()` points to a v=
alid `drm_file`.
> +        let ptr: *const FileData<_> =3D unsafe { (*self.as_raw()).driver=
_priv.cast_const().cast() };
> +
> +        // SAFETY:
> +        // - The type invariants keep this file's pinned `FileData` allo=
cation valid for `'this`.
> +        // - The `data` field is structurally pinned.
> +        // - The HRTB `for<'a>` prevents the caller from choosing a conc=
rete lifetime, so shortening
> +        //   is sound regardless of variance.
> +        let data: Pin<&'this D::File<'this>> =3D unsafe { Pin::new_unche=
cked(&(*ptr).data) };
> +        f(data)
>      }
> =20
>      /// The open callback of a `struct drm_file`.
> +    ///
> +    /// Called from `drm_open()`, which is itself called from `fops_open=
()`. The latter holds a
> +    /// `RegistrationGuard`, so the device is guaranteed to be registere=
d for the duration of this
> +    /// callback.
>      pub(crate) extern "C" fn open_callback(
>          raw_dev: *mut bindings::drm_device,
>          raw_file: *mut bindings::drm_file,
> -    ) -> core::ffi::c_int {
> -        // SAFETY: A callback from `struct drm_driver::open` guarantees =
that
> -        // - `raw_dev` is valid pointer to a `struct drm_device`,
> -        // - the corresponding `struct drm_device` has been registered.
> -        let drm =3D unsafe { drm::Device::from_raw(raw_dev) };
> -
> -        // SAFETY: `raw_file` is a valid pointer to a `struct drm_file`.
> -        let file =3D unsafe { File::<T>::from_raw(raw_file) };
> -
> -        let init =3D T::open(drm);
> -        let inner =3D match KBox::try_pin_init(init, GFP_KERNEL) {
> -            Err(e) =3D> {
> -                return e.to_errno();
> -            }
> -            Ok(i) =3D> i,
> -        };
> -
> -        // SAFETY: This pointer is treated as pinned, and the Drop guara=
ntee is upheld in
> -        // `postclose_callback()`.
> -        let driver_priv =3D KBox::into_raw(unsafe { Pin::into_inner_unch=
ecked(inner) });
> -
> -        // SAFETY: By the type invariants of `Self`, `self.as_raw()` is =
always valid.
> -        unsafe { (*file.as_raw()).driver_priv =3D driver_priv.cast() };
> -
> -        0
> +    ) -> core::ffi::c_int
> +    where
> +        for<'a> D::File<'a>: DriverFile<'a, Driver =3D D>,
> +    {
> +        // SAFETY:
> +        // - The DRM core guarantees that `raw_dev` is valid.
> +        // - `fops_open()` holds a `RegistrationGuard`, satisfying the `=
Registered` context.
> +        let dev: &drm::device::Device<D, drm::Registered> =3D
> +            unsafe { drm::device::Device::from_raw(raw_dev) };
> +
> +        dev.registration_data_with(|reg_data| {
> +            let init =3D try_pin_init!(FileData {
> +                next: None,
> +                data <- <D::File<'_> as DriverFile<'_>>::open(dev, reg_d=
ata),
> +            });
> +            let inner =3D match KBox::try_pin_init(init, GFP_KERNEL) {
> +                Err(e) =3D> return e.to_errno(),
> +                Ok(i) =3D> i,
> +            };
> +
> +            // SAFETY: The allocation stays pinned until `postclose_call=
back()` or
> +            // `Registration::drop_file_data()` drops it in place.
> +            let driver_priv =3D KBox::into_raw(unsafe { Pin::into_inner_=
unchecked(inner) });
> +
> +            dev.open_count.fetch_add(1, Relaxed);
> +
> +            // SAFETY: `raw_file` is a valid pointer to a `struct drm_fi=
le`.
> +            unsafe { (*raw_file).driver_priv =3D driver_priv.cast() };
> +
> +            0
> +        })
>      }
> =20
>      /// The postclose callback of a `struct drm_file`.
>      pub(crate) extern "C" fn postclose_callback(
> -        _raw_dev: *mut bindings::drm_device,
> +        raw_dev: *mut bindings::drm_device,
>          raw_file: *mut bindings::drm_file,
> -    ) {
> -        // SAFETY: This reference won't escape this function
> -        let file =3D unsafe { File::<T>::from_raw(raw_file) };
> -
> -        // SAFETY: `file.driver_priv` has been created in `open_callback=
` through `KBox::into_raw`.
> -        let _ =3D unsafe { KBox::from_raw(file.driver_priv()) };
> +    ) where
> +        for<'a> D::File<'a>: DriverFile<'a, Driver =3D D>,
> +    {
> +        // SAFETY: `raw_file` is a valid pointer to a `struct drm_file`.
> +        let driver_priv =3D unsafe { (*raw_file).driver_priv };
> +

I think it's non-trivial on why this code here is correct, so might worth a=
dding
a sentence or two about the case when this happens (because drop_file_data =
runs
first) and why the access to driver_priv is sychronized (because the pointe=
r is
protected by filelist_mutex, and postclose_callback runs after the file has=
 been
detached from the list).

Best,
Gary

> +        if driver_priv.is_null() {
> +            return;
> +        }
> +
> +        // SAFETY:
> +        // - `driver_priv` comes from `KBox::into_raw()` in `open_callba=
ck()`.
> +        // - The file is not on the filelist, and the NULL check rules o=
ut ownership having been
> +        //   transferred to `Registration::drop_file_data()`.
> +        // - The pinned data is dropped in place while registration data=
 is still alive, since
> +        //   registration cleanup waits for `open_count` to reach zero.
> +        drop(unsafe { KBox::from_raw(driver_priv.cast::<FileData<D::File=
<'static>>>()) });
> +
> +        // SAFETY: `raw_dev` is valid for the lifetime of the `struct dr=
m_file`.
> +        let dev: &drm::device::Device<D> =3D unsafe { drm::device::Devic=
e::from_raw(raw_dev) };
> +        if dev.open_count.fetch_sub(1, Release) =3D=3D 1 {
> +            dev.open_count_wq.wake_up();
> +        }
>      }
>  }
> =20

