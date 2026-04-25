Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBB9FF885A
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 02:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 159EE10E08B;
	Sat, 25 Apr 2026 02:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LR53k0IF";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA2E10E08B;
 Sat, 25 Apr 2026 02:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFRs05UJh9kFRMfNmbLm2MX/9obMqOE++n85K4UoZ+nHvDgL95x2G8Du1PgA17GgfpnRb3FSxO+zBH2GN2PNUsCsyh/ivVq9luHkRWAYQHGmfsTKVh1ZEJJvpSYp9qJ2Mx3D6yklInSwO2HozJKelW/ont3ONTH+Mq9eYbS82Jw1ugZcXOBv2FEnYXRDY9WGOZUrGujI9+ZX9wzKTF9nEgUTZRuCsjmJa8p5YQmQZEeZ/k4kbtqk8jHXElXnQ85rWQzgWovE10tFU1dC0Q2NoL8kc/bbrGvpCUZN28jQblNgZQFWaISLM4CkEg/PpgTKh/Ijw/K40vGzLb4EGd0/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q6t2h4PNYRXhd/4VhMpjcHBZevAaEvZEwMyDNHHXBo=;
 b=Cawz795AkHNaE+ZVqNWJ1jTkOyFP2d7JZJLLLrAxTRFBkuNkGO3mb4zJbVTYfYHPtuJvEaWl+tsu3mXLePithzKnP7pNrbdfaVpdE82BOLaikT8S0vEdNJVcvEz5yvJ9j08SNZgftdejCKVPL/+4hEN4uOFkBNVXVbJdY99hE+ZWRInZVfRCyCXEwxPubgMQ/KoYjb27284awTpNmcZZ/8OAYX9jkF4zI35M5JVGOUvFMIHZbSW71igwagLdIN6g5ZW7ztpeGd3dWEjVjwo4kNxAUheDSCmvg98OvYoJcGBtOpipnZcfzdY38BkJFecq7ekCbn5FEVR330C9JHNQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q6t2h4PNYRXhd/4VhMpjcHBZevAaEvZEwMyDNHHXBo=;
 b=LR53k0IFL71b6jPdB8LiyQFeTBJjcPILDi93VyFIs1zwawaljlY3OJ0yjBlE//Ok7KNt89StaJCCF3mycP2kd2qmQnlYzul42jTvbzc0IJYLdunTtCZc2To1ZGB3/tF69tVU3RtqyrC//hpvRJIEUxZMBA6tdvOC67ytm2zEutJBL1s12bFz+AXT5nwqTxa71v2PKQRxgQa6LTC8njYGrJ/xabx0upzDVgenXNV5ows6u3UaZ2sV3OJzysY51gHPcg62lAsKMgeaqCi+h1UtNgt4yCnXLHsPXjYrPlFBCq+6FhH7zNCwvniQt1k6NlA57niXISANpvmO3B7ZkmsuxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 02:39:00 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 02:38:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Apr 2026 11:38:54 +0900
Message-Id: <DI1VYOJKCD2G.1RB25DXWO0OK6@nvidia.com>
To: <lyude@redhat.com>
Cc: <nouveau@lists.freedesktop.org>, "Gary Guo" <gary@garyguo.net>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Matthew Maurer" <mmaurer@google.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, <christian.koenig@amd.com>, "Asahi Lina"
 <lina@asahilina.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Alice Ryhl"
 <aliceryhl@google.com>, "Boqun Feng" <boqun@kernel.org>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, "Krishna Ketan Rai" <prafulrai522@gmail.com>,
 <linux-media@vger.kernel.org>, "Shankari Anand"
 <shankari.ak0208@gmail.com>, "David Airlie" <airlied@gmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 <linaro-mm-sig@lists.linaro.org>, "Asahi Lina" <lina+kernel@asahilina.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, <kernel@vger.kernel.org>
Subject: Re: [PATCH v12 4/5] rust: drm: gem: Introduce shmem::SGTable
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260421235346.672794-1-lyude@redhat.com>
 <20260421235346.672794-5-lyude@redhat.com>
 <DI0MI6UF325Y.2TDWZGCN3WGIG@nvidia.com>
 <ed26658c461020547e058b237575324adcbaca59.camel@redhat.com>
In-Reply-To: <ed26658c461020547e058b237575324adcbaca59.camel@redhat.com>
X-ClientProxiedBy: TYCP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 90966965-151e-4dca-0419-08dea273cdad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: mGVCEupSKjNRLrQmOY3/DeQv63XaN3e0+DxI+e/C0nq4RZRfOKuTJHCwGe5aix5y+OLxlKFb+V0oxZbehQvPtxoqJEy40hPFdTGOI3XPodnkdq75yn2QOgyKlsJrg35FVjtI16wZjCdcU9BFe9s0xguZmXOlVNNh55YjxXd5m+tOstr5aQh7P6zR3YebsQM4bqrnEmGcpuXor///fB4DgVzoGXCf3aJSncGrL2CljGaN5DVPUa4MKFD6NfioXGQOCfHKn2hOp3ioYtgBQpR2C8y+uG42xPKFYB9e9pCkpYRxnxmRm5uKGlHwgVxE63LZ4kWLw4pB0l3qaVHx6VbcUdhQ2XGRFPmK/NzdiSUhdKqPdVrthur5xPx/XKMRhOeuL4NHTHStgFsTrqRZgQMKP4Ww9kA68HjwWKwfmG/sezf7SUzK7dTo2cV723/ydtKdaTo7GLcrKR14wGHS1LC+iIUu+6VTnNQXK71cAFdlkfUCex4Q6HOaIJa8oTcYIu5Wr+1CiObXHqMij7XvtuM/noHb4oBatzNe+h3lhTPl4TtCVMu7PXQBrldoNdI8nZjJvQqZLIj0xx+WYFdM5PbtZZHW7UUfxbBP1DG59ggFEdLPUBfLbz87I00YPiwFqa/U/8wPx2tDZkuGutCHIC8IugG7QgWl7y/aCaByXOyRt8FECFwXhMey96SrQHqP8EqcCfDJv8oTgPWnuqVjJBVDwxJ1GF425qsSUBuALO1hcZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEMwS2NyMFFuMG1jM1QyMUdyNnNFUXFHcmh2K0toTkV5aUdhWWRoQm5HampF?=
 =?utf-8?B?ckRidHM4clBtMkhKL1ZmU1d5V0l3SWFZNWNmSXJRTUNMYmMwYkN4bUo3UDR0?=
 =?utf-8?B?YjZrT0FnNm82dUc1bWhDc1F3REhNbkdkVSt6UWhFdy9OSFIvS0JKeGlxVXVZ?=
 =?utf-8?B?OHdLdkt0VnJVRUJVdFd0TFNhZGpYbFVOM3JGcE9FYVFiZk15LytLYmhzUWRz?=
 =?utf-8?B?RTZDOFA4NFZyYkJJTDlzNTBzRFg3b2grcis3ZnB4c0haRTJjWVErM2JDcVA0?=
 =?utf-8?B?RGt5ZUpsZGNRcElVUnQ0dTVzV2twWEl5UHV2U25wVnZ2dHJ2UG1WaHNiODBr?=
 =?utf-8?B?ekQwODR0bWdxdm9XWDNjUWFMUlVqaUpVM0l3dldrWURTR1VrejdnMC9xQnRQ?=
 =?utf-8?B?aDh4QkhUMzVKTmFvU3dsTlNtbnhBYkxvTktiSzZYNmp5ay9RZFFYY1NtSmNk?=
 =?utf-8?B?N1h0NXphcjFWOW5iWjhwZFZoNEoxbEQySndvNnpackc5MVg2NHF2YXl3UDJY?=
 =?utf-8?B?cG5wdlFCWVNES0FHSkthYldGRlJhWXkwWkhhZmNFeDdwVXNVTUUzRUVrVmhR?=
 =?utf-8?B?YkNTaS90N0w0U2VZOUMvcU5iQmZnRkhrdkxUTHpHNVVGdjl1Q0l5aUdOQmNB?=
 =?utf-8?B?OUN1bnRPZkt4blRSSEdJN0FWTUNKVzczL3JGbmkvb1FrZXJ4YTFnbnpUejl0?=
 =?utf-8?B?UXc3SC9OYm91NWwrMkZkUEVjY3Q2YXJ0QVJtM296NUY5UDVIdFRtK1NmYWtD?=
 =?utf-8?B?aXZad0dVbk0veFZDZStBTERxR1Nubk0zUmp2L3I4VVJpR0xFSVVoTHdQTlEy?=
 =?utf-8?B?NVdBUXZUSXk1MitUMW5ieU1HVkczWE8vaHNEMHplNXBBcDd5UnBtbjd6eWlW?=
 =?utf-8?B?cmNnR2ZZaEZIVFFlSVdzNkZwZjdyNnExSzJ6cVVLZDJ4YkpnWHdHOUMwVGJC?=
 =?utf-8?B?cWRzUWV6SXY3N0t4V2VQRlBCK2haNHNqbE0vVVBhbTNyVjAveWZrNkRtdGky?=
 =?utf-8?B?ZEIrREdCeE1DaWtZbTJjZUNjWmhUYll1SVN1Z3Ywc1hyK0RQSllLN1BjNWdn?=
 =?utf-8?B?ZXB6MEQ5N3RVcnlza1dNbjJiVU9HUHNuWWQ0TFdudEpPRUNLa0owQVBlSjk3?=
 =?utf-8?B?YXUwcGJab1FEWFNoaWovQzdMQ2ZlYUtYbEJmS3lnMWtaUTFwQmxidGRxZ3p2?=
 =?utf-8?B?NnlEdzdOdG1kMVNpWVF4RldzcUtFeGw0Z09za2xIMXZrUGtlTTFnd01ianFQ?=
 =?utf-8?B?dE80VUNqZkZNU2VNRU1wckhLakN6UjcyWVlvQktsY0xMUVhTWkJZSGpzZExR?=
 =?utf-8?B?WEVNMWRMOW5hdXZxL2JIcElYa1FLSjFWMzdMZUN2dEluakRPNlV3QXBVR2hj?=
 =?utf-8?B?VHhKNzRCbG1TN3hZL1F4SUhjejZqNWoySS9sdGhHa1hLMytRQy9QT2lPQXE3?=
 =?utf-8?B?dGNvVTcxa0JPQTdiaGI4UVZ6aTJ4YjZiL2lNZ0puc0FHK095Snk0SjJkMGk1?=
 =?utf-8?B?Uzd4MCt2OEM3dk0za3R6WW83S3FQN2ozL2RqUXhMYS9qV2VwWVJ5TlJ0bml2?=
 =?utf-8?B?UHU1Um1QT01KQjIzcU15aU9KM3I2RXpXdlNFVUVWRm9YVHJCRUlTOUJlRndl?=
 =?utf-8?B?cEpONDg0NHhaUGp5aGovNmVESW9hNExTcWQ4RFZIOUhTdDFrNzNWRUNoK2N3?=
 =?utf-8?B?ZXBlc2RCc2U3d3kyNDR2UFdWQ1psNjZsTTZxK1dteGdxaTZMTmNPa1hOYWVh?=
 =?utf-8?B?aUovNXNDYWdTU2VJdGJnWmlYeld2R0JmTG9HVWFjc3Q3R0IyWTRXN1FTNjlO?=
 =?utf-8?B?b3ZwbGZXVFJqemFZa0pIbnV2M1hjQUJUVkdkR1I0cWYxcWZXZHBaeGk0bjhp?=
 =?utf-8?B?S3RMeDBDTEFRZWFBU3FjOVFNaDVackJ0QVNXdkYrVklkU2N1U1lPcDVvN3E2?=
 =?utf-8?B?cjlTVk1EWXlCdklJb2lwVTNGM3RsczhrNnppVjd3d2FFL1FFSEdLTWQvUnRF?=
 =?utf-8?B?Q0pDN0k3LzJHTXIrdEQ5WGRsYy80R05xOVJnZHdXazZmSk91YTk2UldkVDQw?=
 =?utf-8?B?b2NMOE85QlVNL09qcUlBNGtmWndsbWE0SFF5b2pTQzJ6VStlRHNQbUhtaTNo?=
 =?utf-8?B?UTh6ZGJwa3h0RllUQXJWeVZIRlBUWXA5SlJaZkhzQWtJUmJPWnh1U2x1ZmlN?=
 =?utf-8?B?b250OSsxTk1EQjIvcHU4OVJNMFFkV0pwcmRHQzNTSHhWc0ZvRzlzekdkQ3VQ?=
 =?utf-8?B?TlJvSzFkaGZncmJDdEtDQm8xYlJRSzNac0YybEp4c3dGMXVxNEJibEFLR2tH?=
 =?utf-8?B?Y0MxYXB4Y3NoVzQvNTR6eDhDb0J0K0wrM3FHNVlVd1c2QnIzbkozb2U1ZWhz?=
 =?utf-8?Q?RollLVCqNebKjwo9Iu3BGrLMxOf2sabbxPDdepjUCKrHd?=
X-MS-Exchange-AntiSpam-MessageData-1: NUtcD6p44izxXA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90966965-151e-4dca-0419-08dea273cdad
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 02:38:59.3013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOI19q/7DZHI4YDE7O7Sp8pVFYGYqln0SRfhwWUKQFNKxsxhXKG1+m8TcYpX2KQUtXb3jHv3jKm/HnI6Af0r+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
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

On Sat Apr 25, 2026 at 8:10 AM JST, lyude wrote:
>
> On Fri, 2026-04-24 at 00:01 +0900, Alexandre Courbot wrote:
>> There are 4 sites where we acquire and release the DMA resv lock,
>> each
>> of which require unsafe blocks and carrying the risk that we forget
>> releasing the lock in the end. For this method in particular we need
>> to
>> jump through hoops a bit and store the return value into a temporary
>> variable so we can unlock the DMA reservation.
>>=20
>> Let's do ourselves a favor and implement a small, private guard type:
>>=20
>> =C2=A0=C2=A0=C2=A0 struct DmaResvGuard<'a, T: DriverObject>(&'a Object<T=
>);
>>=20
>> =C2=A0=C2=A0=C2=A0 impl<'a, T: DriverObject> DmaResvGuard<'a, T> {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn new(object: &'a Object<T>)=
 -> Self {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SA=
FETY: This lock is initialized throughout the
>> lifetime of `object`
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsaf=
e { bindings::dma_resv_lock(object.raw_dma_resv(),
>> ptr::null_mut()) };
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(=
object)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0 }
>>=20
>> =C2=A0=C2=A0=C2=A0 impl<'a, T> Drop for DmaResvGuard<'a, T>
>> =C2=A0=C2=A0=C2=A0 where
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T: DriverObject,
>> =C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SA=
FETY: We are releasing the lock grabbed during the
>> creation of this object.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsaf=
e { bindings::dma_resv_unlock(self.0.raw_dma_resv())
>> };
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0 }
>>=20
>> There here you would just do
>>=20
>> =C2=A0=C2=A0=C2=A0 let _dma_resv =3D DmaResvGuard::new(self);
>
> I thought of doing this but lost track of how many times I was actually
> grabbing this lock=E2=80=A6
> BTW - want me to just give you authorship on the patch for adding
> DmaResvGuard? Since on my branch I've pretty much only just added two
> inline annotations, it's otherwise identical to what you wrote here.

You should remain author since I didn't formally send a patch - but if
the code remains that close, and you are comfortable with it, then a
Co-authored-by would be appreciated. Feel free to also add my

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
