Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11866606A33C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=smM7CAl5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F62010E131;
	Mon,  9 Nov 2026 15:27:02 +0000 (UTC)
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020127.outbound.protection.outlook.com [52.101.196.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C0F10E131
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 15:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzqGJFveI6ZKyYaYT3gKw6Wwdy0KiriaLJBJXikh4ccA3X2iNAUZ6+9cAcZOVxVoJSqTTFyBeNP+dFTCKRyfsgtuY7U/giFfDJ10uUvZLES9yroAFhc6qJpZf1dIjzGKWORGOlnrRiHkQt8RwX7V9AOEV+39aQkA/abT2y2KU/1nGvwDkx9gdhkwuissLUUBT9xFwgbZ18t40+P1lDmR4tJhgfDe8ubfOaGi8z5bDTJSuEc2Ifq+G5lDpQz3ZY63s5s+D0nHJNh/Rn2B27nI72eVf2RKiPrcIeTyfqbx2MvwX9mjgB6qxTMAsNLJunGWOB4aYnYBe0/T/5Md7SBxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGuNxmUiUOX5X3BhBg+UxWeDlVqB4Is2LbBb+jXxk/o=;
 b=LzeCjpKhTebeG7siXy/eMNUj5ehIBdd0VnHwGCwDjrlOBWosBhsiX0ZG5RU6PEML3fNQOxs15UQ2yCPuc3EAWMU2s6OpNs/cQjQrOXmVZ3r0SvwJTL3aI2XVy038JfPDPC26wEDNV9iav1H7AwElrMWV7nzsviZpXkRAmQtrr6p/PXYvLl8va1lujMKqa8k+SCRuhET9UBxXJZ36B866CSwLRKU5TPs20evnza7wW1SC7UKhSSKB+7CjY4sL2pExWh6LeZMzg+GMruMMOmkWmXmBIt2G2XvwLrPBgxizGsdp14fOiqiAstnMJYoLMtFyaNtAUpvd8GSt7mcvvE0vgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGuNxmUiUOX5X3BhBg+UxWeDlVqB4Is2LbBb+jXxk/o=;
 b=smM7CAl5mG20z3NkvEJo3K8PmWzx5YIiv6QnR1RIkYhRYYgkKJ5S0csMK+0vrTQswckRNtagHRTAnWUiohEcMn0lou5flXzAcB7hRskAFZCxQ5ObWRIMdORF0ZXQZqwKIKTBCLeA/U5+F8lMGCP6aJwudMk5W5mZTTiBG4eO2sc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LOVP265MB8774.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 15:26:52 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 15:26:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 15:26:51 +0000
Message-Id: <DMQSAJDM77O0.Z9EITIPLTKHP@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/2] rust: impl_flags: add conversion functions
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20261105-impl-flags-additions-v3-0-5b17c01c2b15@kernel.org>
 <20261105-impl-flags-additions-v3-1-5b17c01c2b15@kernel.org>
In-Reply-To: <20261105-impl-flags-additions-v3-1-5b17c01c2b15@kernel.org>
X-ClientProxiedBy: LO4P123CA0383.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::10) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LOVP265MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff3a91a-eb52-4a81-a19e-08df3e75e158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|18002099003|22082099003|6133799003|10067099003|3023799007|921020|4143699003|261028144727099003|261102130727099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|56012099006|261026140227099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: GE2g02BPSe6N49Gvr3Rj/u+PXxisB60oGSdZ1QCd37kEHNa0w479IqA4jH2ikg3G05ykE7oYVQ3Y/b7FbIpn0J/vBXRTX2MkGWELat8FQc9QiHRs+iiBXhwMKw7KH+EAUP2MkLUwlADohwloK39vpC6gww1SUU44aZghi8JPs1CNxTYN+Rfs9Z8wPpDbIQHqd9h0NgD5gHDCC96KPy1Lsbx7DPDsVr24ji4uyRzStH06n3AvhBA8iBFgTjeS0GPg41jXv/NDEAAv1ET7cxlTd29g7dWQueP1znSKMS3yYRLDsu6MrQg9vMyucNLfvAFBvbelzUOYb81uDgO1OMMAqEpoUSxmArXcYEMESuHyOlDgRfOtc7mZXEhcqRaCVM6rLiWUdyh0fLLco2VydE7/tsDbahPn3erYU5GoIIhxJH1TuZ3JietNnHSeOOe49/sKkcasRLwjQ7iD9TVjcKLaDz8cuspcbEGpQK26f9yFBnw2ts973Mn8QyUNhmHg78+2NphvcDHLH8RfILSj0DiWLX6M6b8q3gRqVOrKo1AACSQgBGKM4Rq2x3HKUPM6avYK76j2CmgeZi5jNo007E04XjUsj3C5X4hiSqhMCbUZJ8ThzhGOuuQgamBpkGPPlHsurtqBj/3HaKz9N0oVgFrEdProLkaNJ43GySesoss8AwLUj3Pz3koskzAW+J6gY6AojrXq9faMdMPJglOD133xsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(921020)(4143699003)(261028144727099003)(261102130727099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(56012099006)(261026140227099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDExYWVHOTZ4UnA5L2lTSUdBLzZvUlF2a1pjb21nUiszY0U3WFo5b0xwYmlJ?=
 =?utf-8?B?eGtRK1JGKzQwaXcveHRWenFTdHlkNHgyZ2RLcW5DNy9Bc2l5WUdzQytCZFVN?=
 =?utf-8?B?MmtIdFUzZk4yRmRoM2Y1WWdrWXZlcDlBT3hhbmVGdmxKTEJyaHhTRjJzVzRt?=
 =?utf-8?B?Tlg5REkyQWgrUUhNUlZZSXZZQ0NVaGFjNnhRVFZ6NnVQUzFVUHNWV3JnR2xT?=
 =?utf-8?B?cmF2aUZqMHRXakxiU0Q2enNRT2FCdmdYUjdLeGFSb3V3dXVXMkc3R21EN0Qy?=
 =?utf-8?B?aTZ2SGEvMkZKME5jTGhHQWFMd3BsRWtYYmFDN0wyL3VMaFdHdEExd3lkWjgr?=
 =?utf-8?B?L1F0RWplMDQzK2tyT1UrZ1JybE5WRmo0eUFMVlkrTnFyQjY0a1M3L2dBWHhF?=
 =?utf-8?B?bmpNTlZIazJuQ0Z2MjM5c2dFTndoQUxYWmVHVzNLR0pCVlNHWm1PYTR2TFpj?=
 =?utf-8?B?YzRwSld3K3A3VGoyYWtQZW54SllTcFMyMDdXVmN5ZHJQTC9zdHdaMlZWSG1j?=
 =?utf-8?B?OFI2VDFvMXZWU01IQnNiRHVRUGJPSkp4UVMzNFZ4ZFlocDFCSUtBaG9oek85?=
 =?utf-8?B?d2hJUXpBc1pVbndONDVQMnV4Vng0a1lCNy9UWGNYWXFNUnJqTWdyODFWTlFu?=
 =?utf-8?B?NGlKNEFNZnRBbTZrZjM5QmZzajRWMEdmbUcvTGFUQlh4cURGY0xWWGtpZFZh?=
 =?utf-8?B?TkF0TytUU09UTWdPMGNmYlZrUUxnakxUTitNOFdGVHhCZmJHTkZEWHhxckhH?=
 =?utf-8?B?aUs1VGVmay8wTk12S3FISFgxK1Q1MWZ3VVk0U21Wdjg2U01IbENQYkVrRjR4?=
 =?utf-8?B?Z0NLZ1BUc1phYkVXanBCZSs3WnAyQXlGSE1vU1JhT2lLNjZPVUNPRzl5ZjdN?=
 =?utf-8?B?bWlvNWI3MmJ2WUc2eFV6ZUZ1OUNmWFZGL0FMWXNtZ0d5RnM0akNlY2pCM21x?=
 =?utf-8?B?b2hwZW9ObDV1d2ZTVlU1LzZiSlhWMUdwTXM2bVJzSmZPblIwWkZSNERJZTNM?=
 =?utf-8?B?T3V6enV0V0treUJjYmRzZjgzN2hVU1hqWFBRcTBTeDNzT3Q4YXBCMFlWbUEw?=
 =?utf-8?B?Y2ZqMG1KNWJndUpqN3dsWXh2eU1KSXBteWkvSWVReW9lbmdTOVlLOG5SWVVs?=
 =?utf-8?B?aldOOTZyQ2JDcFphOC9nLzdQdmcyZjRJOGJhSkxxS2FadHNVNTY0dnliUlJK?=
 =?utf-8?B?dk9TTUN4bTE5b0k1clVEMklZQkZrRDI1enlzSTJLYmpncWFaUXo5UGhLcFk4?=
 =?utf-8?B?MmZGa0JHOVBrMWhib2p2ayt1TFFZM1VlVjN4eEFlNFhqVHlXSE9XbitWWG5Y?=
 =?utf-8?B?N3E3T3J3TnJ4T1FieWZ4Y3RETENRdkNpSmFyWmR0QVZJZUlTR0JMNzd0dkND?=
 =?utf-8?B?RjZ0N0Nrd1FQVEhudGFMR0tqWEtOWGR3aHVDOHRVRGV1Y2hPMXBTQk13Ym5s?=
 =?utf-8?B?RE9VZDkwV2FBTWpJS0pjTUthSTByUFk3RUIxNTVNNUdEYlk4dXFyS2RwMGJH?=
 =?utf-8?B?WDIxN1JBZi9GU1FNSDJVVE81WGVwR2M2L0FXTzJSRFBtUmw5c0M4aFJ6MEJw?=
 =?utf-8?B?ZDRJZVdWeGxlUGRheVoxTmJNakVtR3pieXp0VDNsbjllREE0NE1LTCs5ZGhT?=
 =?utf-8?B?VUxhTEJkdVkxTHF2QUhwekhYWHc5WEVwczhMdU1MQWthd282RzlMMXNWZWFk?=
 =?utf-8?B?WmVDYVZvTDNDeWFzemR3NnprMUlOUnFBK3MrNytvMEkwMkFIdis3M3htZjRE?=
 =?utf-8?B?SXJ3TXJFNFlRZmIwVDJXelRKYW9pWW9DY25td253dXIyNVpEaXNXdTF1a2JE?=
 =?utf-8?B?OFV3a1FaTTRRSEc0alVYaDBReTk1bjQxQVVFQVNubWF5RE5CbVF4aHcyWUZ2?=
 =?utf-8?B?cjRBeFhVODFEK3M1OTFNeE1ERHFIZ3BHVzBoNWQwMDJnSk5WOUtqU0t5Kzh2?=
 =?utf-8?B?NHhrUC9YdmlYUmZFWWZ5eGdtZWppZ1dvTHdCbUFNUzBqdVdMdmtEdVJhcTA4?=
 =?utf-8?B?VzNFWW5WMCtwZ1VTVjY1Y0M0TUE2STMvU2xlbHZOTnp3dzVScU15NkY4RVc3?=
 =?utf-8?B?NjVueDU0WUtoSHdpY1RwZUE0bUkzKzhmU3dNVk5CZS9ZcnRiMVdsWkd6bjcr?=
 =?utf-8?B?ZFg2RzNLRGxSYjlkWm5FaXJSQ2g4SitKU3hST3E4cURMbkkxbk1RVXMwQmhV?=
 =?utf-8?B?OHF2N1kxcVBnMzFMU2dNcVJnQWFwUlVIMDR1ZVloWjNDYVpMYmNGc25zK3Z0?=
 =?utf-8?B?SmJ2RVNEQTdVdml4d0ZJSWxBOHdzbmVJYTZnKzdoS2VvVGNiNTFFeFhNNUEx?=
 =?utf-8?B?cDB5VVRsWGtOc2RVYjlVVnNsMVNlQ3RVZDJnRTdQZCs0SWl5R21mQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff3a91a-eb52-4a81-a19e-08df3e75e158
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:26:52.5331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOjrnhLwEUjww5+zsFi/NPrc7GyTIDMB5uq7YKBM+dgbc1CvjPN9QG4K0l5dlBFkJT2imUDLH/PRUXbOpgsaYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP265MB8774
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

On Thu Nov 5, 2026 at 3:42 PM GMT, Andreas Hindborg wrote:
> Add two conversion functions to the `impl_flags!` macro:
>
>  - A `From<_>` implementation to convert from the flag value enum to
>    underlying type.
>
>  - A `TryFrom<_>` implementation to convert from the underlying
>    representation to flag container type.
>
> Drop the hand-written `TryFrom<u32> for VmMapFlags` in tyr, which now
> conflicts with the implementation generated by `impl_flags!`. The two are
> equivalent.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  drivers/gpu/drm/tyr/vm.rs | 13 -------------
>  rust/kernel/impl_flags.rs | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> index 1dd11b2b1253..0d6e841a31ed 100644
> --- a/drivers/gpu/drm/tyr/vm.rs
> +++ b/drivers/gpu/drm/tyr/vm.rs
> @@ -141,19 +141,6 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Re=
sult {
>      }
>  }
> =20
> -impl TryFrom<u32> for VmMapFlags {
> -    type Error =3D Error;
> -
> -    fn try_from(value: u32) -> Result<Self, Self::Error> {
> -        let valid =3D VmFlag::Readonly as u32 | VmFlag::Noexec as u32 | =
VmFlag::Uncached as u32;
> -
> -        if value & !valid !=3D 0 {
> -            return Err(EINVAL);
> -        }
> -        Ok(Self(value))
> -    }
> -}
> -
>  /// Arguments for a virtual memory map operation.
>  struct VmMapArgs<'drm> {
>      /// Access permissions and caching behavior for the mapping.
> diff --git a/rust/kernel/impl_flags.rs b/rust/kernel/impl_flags.rs
> index 6051487f6e28..052759b8038d 100644
> --- a/rust/kernel/impl_flags.rs
> +++ b/rust/kernel/impl_flags.rs
> @@ -73,6 +73,17 @@
>  /// // useful for passing the value to a C API.
>  /// let raw: u32 =3D read_only.bits();
>  /// assert_eq!(raw, Permission::Read as u32);
> +///
> +/// // Convert a single flag value to its underlying integer representat=
ion.
> +/// let raw_read: u32 =3D Permission::Read.into();
> +/// assert_eq!(raw_read, Permission::Read as u32);
> +///
> +/// // Construct a `Permissions` value from a raw integer. `TryFrom` rej=
ects
> +/// // integers whose set bits do not all correspond to declared flags.
> +/// let parsed =3D Permissions::try_from(raw_read | Permission::Write as=
 u32).unwrap();
> +/// assert!(parsed.contains(Permission::Read));
> +/// assert!(parsed.contains(Permission::Write));
> +/// assert!(Permissions::try_from(1 << 7).is_err());
>  /// ```
>  #[macro_export]
>  macro_rules! impl_flags {
> @@ -115,6 +126,26 @@ fn from(value: $flags) -> Self {
>              }
>          }
> =20
> +        impl ::core::convert::From<$flag> for $ty {
> +            #[inline]
> +            fn from(value: $flag) -> Self {
> +                value as Self
> +            }
> +        }
> +
> +        impl ::core::convert::TryFrom<$ty> for $flags {
> +            type Error =3D ::kernel::error::Error;
> +
> +            #[inline]
> +            fn try_from(value: $ty) -> Result<Self, Self::Error> {
> +                if value & !Self::all_bits() !=3D 0 {
> +                    return Err(::kernel::error::code::EINVAL);

IMO this should be a new type, perhaps something like
`kernel::bitflags::UnknownFlags`.

Best,
Gary

> +                }
> +
> +                Ok(Self(value))
> +            }
> +        }
> +
>          impl ::core::ops::BitOr for $flags {
>              type Output =3D Self;
>              #[inline]


