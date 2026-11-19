Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C452B606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=mSV91new
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD3A10E2D1;
	Thu, 19 Nov 2026 02:08:46 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021076.outbound.protection.outlook.com [52.101.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29EBB10E2D1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZiNDKPgy2R+VvnuexcuGxl2za/Zktb+HK99J35HUAy9gD4qx4PQkvVSelj6bx5sElTMuUhtt4ynkmtBM9ugzSPOXbGYL/g1yXkD5wW509g3J2z1t2JF2afKfLOceldxUHSY/vaJJQiR3HM7egCmbs31KssIwfQDCvX/U4gTiAKVAq8qUuSWRapiR8CY3kS+/wbZfx49UbQc/qZqVmtDq8PoE47RaCrFVb+UibMm0BKwZYWJJRPgifJYxYs3qKEGuVJqQjoXJGYKDT4VRySbArGopV9a/8pFZ7RzEXBPw9fvpPIEqprAEMv/9FMBO5iwS+TSHiB6XPfKlsr/ed5zUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNSONpAEqQ6znQ3OKEUMuHW1lhIbZeQ+ct1CWb+XnFs=;
 b=y7q/26+EDKYSauoraJPyGtjTjDAUkzxNUWOkcXyorUFShYpa6CYEcZYQG2l6RjPi7ciKw3WlP+lV7NNJOqaAuQHcs/7lgwl6WOwUmWJs8FL8VvgG2tVQTarZPb/dKzmLl4BqPFVULW4A3fkae2Lv93NlS61RkqCrR6g7Bcu8WWZI8f6eJ4XB/5xvBmiMZltIaVIXvbx4X0/HV7CLR1jR8HlvP1t/tefJsGJZ6XuzS4jO/hbBxA/vIyi6CDFOtqkPHI3ac98FkkCiY4pVBwzfE9twZTw31G7HcJiG3QBnsn6cQyv6waHGxYDQfoQlGi5gUHWpUptaJCUKX5m82qPTEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNSONpAEqQ6znQ3OKEUMuHW1lhIbZeQ+ct1CWb+XnFs=;
 b=mSV91newuatzkCNCUsa7OEaiIhLP9Pbly6fKGAl/vKlDF1pt+67DLdkNt3nelEe3QcRCRjaCfNkzxFNWQ8lOMrhkUcM+IniOYZciMjX+n6Y69GdaxF2528TfaYWyddt1SgA0Pa3RRFZ/FCZMC6iySVhE7PP81gcmi8COvodMiQI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO2P265MB3039.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:17c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.17; Thu, 19 Nov
 2026 02:08:35 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 02:08:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 02:08:34 +0000
Message-Id: <DMYTKRS80NRC.18PBQHK9SZ8K9@garyguo.net>
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/tyr: name resource lifetimes after their types
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <lossin@kernel.org>, <gary@garyguo.net>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20261118233727.3147222-1-dakr@kernel.org>
 <20261118233727.3147222-2-dakr@kernel.org>
In-Reply-To: <20261118233727.3147222-2-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::18) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO2P265MB3039:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2beef3-8d15-4538-2271-08df45e2045c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|10070799003|366016|1800799024|4143699003|22082099003|18002099003|261009223027099003|3023799007|921020|56012099006|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: MF/1Ga3PHynbECb5CAbQ3ngIfPhzvFHHe6FZdv0vytVYADFVkeDJJtWFzCbVCDY7XI5NtP0MskQKg0y76IWEchLOAkVwmZm7Dwgvx31cByqgjHrZT45hB5X5cMaD/R5GY0VheVgmzw1Bq+/4KModAriYDvCi+H9Uh9G3TzMstmzV4mG6rxJO4RyJnPxzHQWdqm83nkP4pYVKBbXsZI2YkKEd6p4u0QJDYUrPqfDwDv9oiczYLOa+ddNMjG0b4g8E6jL8T2QWNP0RzrbEYE79fiXlASxWSXPrgslPv5kr7VaBVJkZMDlkV0luXedtw7eNtKMW+hLV0+xVqnvgoHo9JudEVhYhH+uIxTigz951AYuhRucEW1CAVSiNcUNcn81IdsCwBhqbe4nam8GM7xErZ4/64qu2pcEIcaZDR4rD1YDEE0VBdQZBn2GvHO+yL7hwBiUtyVfO7ElEg7MUots5lq37SKFsQQtsXXsjDqslw2y0KCBnW5OQkl3USkSVFQEYgWQbtWZwrgr7/m1yuKS/m/bZwWz+WcDPnVIRI640OKb3V61+ECm6uizQVekbPMJVs/8/YtEQ+/F6Y9aAoCFdI/zHyb7/SmZuLvFTG29udSKCT5TPTaUfrZhMY0qQTMSftTP+66iJ665zx6TTFgOjWN2gFpPz2nw/R1o+0/vHYqxCY/oEv6Dcswj6e+BYo3jm65g+Jsrf1pSU6yDRARbE4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(10070799003)(366016)(1800799024)(4143699003)(22082099003)(18002099003)(261009223027099003)(3023799007)(921020)(56012099006)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUtNR2t2dkh3YXM2N1FjUUFCZzBVaEFlc0NLMURyMExtUzBCL0ZsM0Y1L3RG?=
 =?utf-8?B?MGk4Rk9lNUhUSWtiUDM0YjJDODc1RENnaVBBa0RkT01WRWpaTllGZU9CTkJK?=
 =?utf-8?B?cUFtSHAweitaWjU4QmpTRTB0ZE5rYkUxMEtNSUY4b2t4emxUVzBLRFZ3OHd1?=
 =?utf-8?B?Q1dQaXExR2Y1V2FNU09tdW42bFVJSnVWYXVVZlFwamxBQmlxVFlHMEMyUVJW?=
 =?utf-8?B?bDdsTXpFMFg1TVRsemhwMXBuamNXTGkwenJtNzZvbmgzclNlc2lBditWc1gr?=
 =?utf-8?B?cDB4d0pDcDJmV0ROZVcreVprb3VSOWlMSmU2QTVTNDZFdWI5ZFlBSnpFNGlu?=
 =?utf-8?B?YXpwc3ZBOXUrOXVLcVFnK1JvZTIxODJxQ0ZqVExSNTRqNXdxZkU0eCtCTDdT?=
 =?utf-8?B?SFdaRlRNdTc2azZSZ0xKOTlaZ3BDTWNXd1ZXNks3b05DVXBvaTJ3ZFhoZFlP?=
 =?utf-8?B?NTl0Qk9BMk5XK01jMjdjM3dzOGVqWHpneW41M0lieHNTM2VBWU1qRU4zQkZh?=
 =?utf-8?B?cVNEdXNLb0JJNW1IMkZQa1lNR1UzZ2NHMFZ1OG5sMkdXc1VlMlR0emV1MWVq?=
 =?utf-8?B?RG9lMC8vTDF0ODlmSGx0cjM5QnZ0V3QvTkpUempBbkhESlFCQ09ZQlZtSU5E?=
 =?utf-8?B?RTdSNUJpWm9ZKys5OThmYm91TDJOc3RXRVlFY2JIQi8zMS95ZVVDWndmaG52?=
 =?utf-8?B?ZzROOFJnRzlUc3pxV01VS2FUNDhLdnRVY2hDSmlESEozQXlFODhWT21NTDFq?=
 =?utf-8?B?d1AwWEd4d2V5cDBRUnViSHAweTVyUTV6bXhEWFRJRXRjSXV3UFRheC9ZM3NQ?=
 =?utf-8?B?Zys4V1dqREpncXNCZHpiN0p5ZDU0eDY3eDFYRXpNczdQeGY5WUFQZXlvNGx0?=
 =?utf-8?B?ODhaZ1EwL0RkY3NlTW5wYjcvV0Z0eGFDdllhekhORVV4dDJMWUY0cHNSelR2?=
 =?utf-8?B?TTNnaWkrUXBDT3gzaTRObEkvWnpONnFSWjdFT0hKeXV0enNweS9qVks0VGVt?=
 =?utf-8?B?NlFldDBHVDJPWlk1QkVUVjlYcTZBWDBMVGxiSlFBci82THAzeTRueUl4TCtv?=
 =?utf-8?B?NWpTbVlxMUxaL2lLOXBvcG1NMDJyUi9xblVrNDlRSWtoc2pkMk9MQmtqL0Qv?=
 =?utf-8?B?NGFTWXB5YndPQkhOTzFDejdzamE1M0tReXpMa1U0TVVtMi9ReTdBWnZUY0lY?=
 =?utf-8?B?T0NXejFnR3pnTmVNU0ZYQno0OXpqMEJuZjIrdTJxS1lndzBZd0ljWUdDWjNU?=
 =?utf-8?B?Uyt6RmRKbE5pTUphNnNwRk1JMFV3S0JFYjdHTzFRcHJvSCsyVnRibjdXM0NG?=
 =?utf-8?B?Z2xIWlVKL1FJUk5wck9ET0dmQm9jM0tUTUh3ampRNGVOK01kTTc1MjB0a0Z2?=
 =?utf-8?B?VTFWaDNDL0o2NVAyc0x5d0Jtak1SZFFycFo1QS9oNkFyWmJJd0MvYXloRGZI?=
 =?utf-8?B?bC8yZk1HQTFkdTVDdWQ3Nm0yd29mV1I4eFJDTHg0bUM0bCs4dTNUcG5xUmFk?=
 =?utf-8?B?bWVxcWlIUW1oRU1wZFdCUjcxajZHLzlFeXhkeXF3RFJOTVhuVThMVS9jMDFU?=
 =?utf-8?B?T09zTjB3b05pbnY3OGVlM0tjUXB1bDcreGFGc241YjlKTUY4ZVNneDZ2WmhD?=
 =?utf-8?B?YzZJaFBka3NpU3lrNzkzVExaMjhNNVhrTGRLWnpUZVg1NEpsZFU3TXR3K2du?=
 =?utf-8?B?M1dVNm9oUzdoMXJuc1dWUmxCTmVIYnIvNWVTTDBZcjZLVkpmanN5VVlrdUgw?=
 =?utf-8?B?QlFaVndaNStMV2RwQUhuK1BSTFdDNExWYkgvRk91eGFSdGdtSDJJcmRwOUtx?=
 =?utf-8?B?RXJzUjFRb0NWMFdkUVE3NkhBelhSSEpVQXl4eXNoYTg4T25mc2ZMN1I5ZTJO?=
 =?utf-8?B?Q0QvdXdCZnBIQkV3VisrZXBnNTJVMFhoUFV2dWVMTC9xZ1BtazlXdUpRWWxZ?=
 =?utf-8?B?R1E1QzRQaytmVUNRVUtITE1OSGdXTjBkQXFuKzF4MXB6N3c4VGNYVHZUZUlx?=
 =?utf-8?B?ZnYzVWFqaWNPcWxTbFdCbVNGMklwU3BDN2IxNDFFSitLaTRCcFhNRFlZczZW?=
 =?utf-8?B?Ylp5d3lXeitUbW5hRXlnc3o0aVBIakRSR2NRWUFhUGRWWmFZNVlEZEFSWUps?=
 =?utf-8?B?MjNadmN3UDIwMXZ0TnJyRWNKdTIvWnZEYnJNUWFwMmw1T3IwcFRtbEsySE1N?=
 =?utf-8?B?Mklmd0hLN1dGdm0xNVdiR2VKbTU1Qzh5djBKMENaTURQa3FxME1KRDQ5R3Bl?=
 =?utf-8?B?MVY3TTNBRCtCY1NSSkZyQjlPRjFMN3BETEVPR2V0azFVUVEzSUJRdDRVQnM1?=
 =?utf-8?B?b0ZsWGpVTnVScjhKMFBoaHJiL1JBMjRTbmVkTG5JNVAvVGR2MkU1QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2beef3-8d15-4538-2271-08df45e2045c
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 02:08:34.9308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhxeweqbyToTHJyxnLtGp0OhbXEvBGBc39zfHhDiZpq7eyyke921zPar4RPuWq4fJQMt1/NvFJjGRKC2OJUl7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3039
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

On Wed Nov 18, 2026 at 11:37 PM GMT, Danilo Krummrich wrote:
> The firmware, buffer, VM and MMU types use 'drm for their resource
> lifetimes, even though each parameter is local to its type.

This doesn't make any sense, a lifetime on a type by definition cannot refe=
r to
a scope of itself.

`'sec` is not the lifetime of `Section` and `'fw` is not the lifetime of
`Firmware` and I think this is just confusing.

Best,
Gary

>
> Rename these parameters to reflect the respective type's scope in
> preparation for converting the resource ownership to self-referential
> pin-init.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/drm/tyr/fw.rs                | 26 +++++++--------
>  drivers/gpu/drm/tyr/gem.rs               |  8 ++---
>  drivers/gpu/drm/tyr/mmu.rs               | 24 +++++++-------
>  drivers/gpu/drm/tyr/mmu/address_space.rs | 30 ++++++++---------
>  drivers/gpu/drm/tyr/vm.rs                | 42 ++++++++++++------------
>  5 files changed, 65 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
> index aea151ff1f93..16c6aca3d3f1 100644
> --- a/drivers/gpu/drm/tyr/fw.rs
> +++ b/drivers/gpu/drm/tyr/fw.rs
> @@ -131,7 +131,7 @@ fn try_from_fw(value: u32) -> Result<Self> {
>  }
> =20
>  /// A parsed section of the firmware binary.
> -struct Section<'drm> {
> +struct Section<'sec> {
>      // Raw firmware section data for reset purposes
>      #[expect(dead_code)]
>      data: KVec<u8>,
> @@ -139,23 +139,23 @@ struct Section<'drm> {
>      // Keep the BO backing this firmware section so that both the
>      // GPU mapping and CPU mapping remain valid until the Section is dro=
pped.
>      #[expect(dead_code)]
> -    mem: gem::KernelBo<'drm>,
> +    mem: gem::KernelBo<'sec>,
>  }
> =20
>  /// Loaded firmware with sections mapped into MCU VM.
> -pub(crate) struct Firmware<'drm> {
> +pub(crate) struct Firmware<'fw> {
>      /// Iomem need to access registers.
> -    iomem: Arc<IoMem<'drm>>,
> +    iomem: Arc<IoMem<'fw>>,
> =20
>      /// MCU VM.
> -    vm: Arc<Vm<'drm>>,
> +    vm: Arc<Vm<'fw>>,
> =20
>      /// List of firmware sections.
>      #[expect(dead_code)]
> -    sections: KVec<Section<'drm>>,
> +    sections: KVec<Section<'fw>>,
>  }
> =20
> -impl<'drm> Drop for Firmware<'drm> {
> +impl<'fw> Drop for Firmware<'fw> {
>      fn drop(&mut self) {
>          // Stop the MCU before releasing its firmware mappings and memor=
y.
>          let _ =3D self.stop();
> @@ -165,8 +165,8 @@ fn drop(&mut self) {
>      }
>  }

