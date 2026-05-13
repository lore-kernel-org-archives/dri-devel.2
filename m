Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A66CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 03:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0924410E2D6;
	Wed, 13 May 2026 03:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="c4G2byJ/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918D610E2D6
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 03:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYscdseC7LsXZx2oIp+wHFjPPTKz1WBOablgs/udxt+qaKUoZIabXhcHGOU9QlSYSSDTuFtvrM8I4lCaVyMq4LXaOkwPMeshhlQ9+ZBkpz75zviklho4OG/FQ4xQyRfnC5md/fKG1XMF5BDDv9xnPgCsvwfABXDrbprbSMVMRbyI6HiYxoS4UA2yDlytrA1TIOoR9ZMu/pN4g2zab/EoFnhmHDebqFmmyM+mhz6XLAdJ1lhDQz3rh/BsQSVRrcYEy6bXP4COtX032DYcywjZuGSicvjs+NrFwxA1VJRgxI63al9XrHyVa4B+vhKPiGrFr9vFAFe7xAVQO4xGBtEECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHdI8UbkJ/xpWydtCGUl7tONksXAo2mgHv9RwBA9TfM=;
 b=CBaDeRt2zomgRZOZid2HXNeUYBR6Jnj/S4kurdXEyH0XL7H6zxT6LuM3XYypspc1R8umt0R7XwSiL84Pa5uGeUIu4ecYQTTg/sRzJTtyDS+WJzCojrrIThjNOtKTE/Q19gyh3shSFlTcQhncH/VEDl87RefTAc//AFywQoFWphjW6AVvzOqB7YMMaWNhAeqTYxuf0NQ5azWPdQkZiN6Ijyhb8nO6ek+di49/IVB5jgM7rTxMSJbYfWjME0AxfLsPohd09KqH3RwZi6Bwdf8m6Q/nyR4w8tHECcYU/D9HH4u+70BvCIqICB+JfM2h8XJnLI419PJhSj5QzaPrdwmxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHdI8UbkJ/xpWydtCGUl7tONksXAo2mgHv9RwBA9TfM=;
 b=c4G2byJ/5OyNJ4RWL+BYcO1CJHyh+2nTPWwmv6FfiLq2MbFSMT3/M547NftRNRBNwnC/Kzi5lNM6enVEQ7D1S0jSsgA7vmq4OumQPu/SIBVLjOuzJFs64kcCIHPxBT4OPInPADH+8aIh+T6tb1FD0E3cKbf8opXFFv/HEY0HtVOsw/oot2ZjjYHKtq06C/uFaWIC+gpVIWkunkgs79fgKggzONGhN04hOv+bzknYODR2OQFPiD6wGO5K7ttwkWHrfEV5QEBt+XBxb4j9P6ON85HyXJPBLaoGSAFwqDceysiMPTrMzFqh1PXDy1GRnjMbJZTlCL2szA5r6mSj8kCk0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:26:14 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 03:26:14 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Aaron Kling <webgeek1234@gmail.com>
Subject: Re: [BUG] drm/tegra: DMA buffers are not always freed
Date: Wed, 13 May 2026 12:26:03 +0900
Message-ID: <I47hlmySTbquW1VgZFOofQ@nvidia.com>
In-Reply-To: <CALHNRZ9mmf_4OagcooO-s+SU1KrggT5_ZwM--ambxZKXN-oQDg@mail.gmail.com>
References: <CALHNRZ9mmf_4OagcooO-s+SU1KrggT5_ZwM--ambxZKXN-oQDg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYWPR01CA0007.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff5860b-8787-4943-2ea1-08deb09f6350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: lMXu0+phUNkJwSjCtbA76ZSyuCDrdYW1++M1YQsVIRj7SsS5ivRIoTR9QkbAUbGCfDsTLIPTQd/lRhgfgXc/b7sMd2FmujSNz+EfNb6kedaNZsTayWB2UBJXqMYe6Rf9FhQOy2EhUl4Q7xINmRxI3OzK9baPGfcPEaxjxXNSRu0lmaDXi4B6L843qjF8bZa2BnGTpBOnNYSncm/gpKhzQoWMROa/f8N+d6a2DLKUF7oa+w/9Ddf7XEAyLTJEJo7NVmPlr+5atn0tzwD+VWoD8dA04IydRA6WFhdt/Uytl+Ln2cK0BeQk/UhA5YQ/WS7QTMo5doJ0gCIb+5qpHRApY5KotFUJAFMHJBb8V+TlY2pX+js0fGayAbnJy5GcGa7gjkvhyN2f2T3M6IZdKlpLPPhZAArdJ4uRRz5pHB7H4lIhmOMu8qtUdHROoy2nz8YgFbTvEUHxjoHINcINqzzMgpNHs41PgCssJ0h/sZrJySnaA4ji545o3dixyC+6k0huaMXPY88z/xMJAHtiwPBJYB9Mvs5YUJVtzNBb4IRODKNMz7YlmQCcIz5x8qALwtpFM87LDzPHzSquc6X6HOoUDNO+IYlDxZkPc8QxZ+htuu9UIx1STKV6/uYZl2WczXbRdU0HPc6Oozv1ywdVAJ+Io0igdvhdLDxLLqhZ4q9lbGEWpo/wl8aWOan7kn19E39a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNXVmEwRDFOOGw3S25vSGlLRGJlaVY5Wk5VaVMxQ05kVjc2alpjTG44TVoz?=
 =?utf-8?B?SkFaS2JqZUp2eU5qVWtpeWljQWdYT3NCVzRqYmV6bnB2amhmdXMwNW5mMWIy?=
 =?utf-8?B?VHJ6d3JZNVJPWW1CUDdCdHNWeVZkcjNxSCtyVFFTeWJSdGxwQkQxQUd5Qkpj?=
 =?utf-8?B?TS9xRndtS243cEU5NTZLTE9NaStMTUcxQlVZajkzZmtxRmlhR2h5OWowMWht?=
 =?utf-8?B?aS91ZDhCNTdHRU9Nb3BVd3ArOUV6UlJxOWhUSnhEeUVnTko0Y1k2Y0pRTmFo?=
 =?utf-8?B?RzB0S0RhRGNPall5Z2J3RmgzN1ZYMTFKM1ljbWFFKzdPR3N0QkZ4Ymw0TDJp?=
 =?utf-8?B?OGk2VlpIUHplWWVXM3FBUzdlYVU0N0ZacjVmdFNCeHlPZk0wQzNHS1czdy9Q?=
 =?utf-8?B?TEh2MmtDcU14QlNKK0FoQXRsWGJDVkRnZlVxVC9Ua0F4OFFlMXdVT1RUN3Yv?=
 =?utf-8?B?TW1MM2s5ajMwUmJ5eHN0VDdjUmlBMmxSd1pEL2dFcGYyd1FXQU03WWQ0TnA1?=
 =?utf-8?B?cnRUSjFyWnVMOFdyUFFFRmpoQWJXa3MyVUxpc3RDaE9TV28vcGZVcXFZbFlR?=
 =?utf-8?B?Y1VpeFFaZWNvbWxjMHFxblBNNWFzMDdvbU50b3pkRFgxWUdQTGxzcVEwelQ3?=
 =?utf-8?B?QjN2OTg1WDN0RlRuSERIb2pvTC9EL2VWL21sUWx1UDZkc3ZVMURwQUF2S0I0?=
 =?utf-8?B?NTZsM1RBQngybE5nY3BHU0Jtc3c4KzltMHpLZ0FQZm5kVkpFZzFnV1NBRVNC?=
 =?utf-8?B?Q1FMSW5MTHNET3YzNTBMWkM3V1lJeE1RZmlXclRSdFZKSWJlekt0WUdpMmMy?=
 =?utf-8?B?UlFkWWlMOFF0TjYwb2ZLSHdFQXFsOVRsSnI0MVkzR2IveE44NnNHS295M0Yv?=
 =?utf-8?B?cDl6aUdDTjBjdTBuQzRmbS9FZTRqNlN0Ry9wSGJLVk1EK2dNZ1h2OHNtd3Y5?=
 =?utf-8?B?UlJLWklnTGdoRC9lRkkrNDdFMFVJU0pyK0orTHBlL0txbFdXUkYzbXQ2Qitm?=
 =?utf-8?B?V3YyY2FlaUdUVVFkdFFRZUg4TzNjM3R1d0FoM05ONkh3SnBWK0ZqN2NYcGZR?=
 =?utf-8?B?UkNYV3IyNXNySVRTTTlKV2lHMFRPeGxHYVNtQ2wvZ1NZTmU1N1FqY1dTWDRO?=
 =?utf-8?B?V1pRazBBcDBPZzRSRmg2TktydER3dnloUXlEK0Y0ZVYyQVlRZlJGL3JZaktx?=
 =?utf-8?B?dWZaUkhUWGE0T05kczlQZFBtKzRmekpYM0hhMml1UjcwOWluL0phTDJGY3gw?=
 =?utf-8?B?WmdSbWgxajdWTWtEck1LaTAvd2pLNTV2N2RrSllJc2lKQkVOaFRuVy9sanU1?=
 =?utf-8?B?TmtYWGs0ZWFWcm5aZVNKLzFuM0lBT0trd2xRNHArcGgwaWVSODJQb292TDFn?=
 =?utf-8?B?RHRoZjU4WFlEOStRNHhPNHFIZ1BSNU50WGJYT1VyQndaYngyZmFmNDlRU2Ny?=
 =?utf-8?B?Njd3WnFhdjE3N1h6T1M0ZktLcVRZRmt0cHFaTFdVU2dQbUlEc0xENHc0akNZ?=
 =?utf-8?B?T0xweGVNWmVqRXB2Q2FPbzduV1lsNlRSdjIvQXYrcmhCK2F6OU43RmswRy9y?=
 =?utf-8?B?WFMxTGhvSUhsNTZJamRhZ0NaK0pya1JQcUd4cDlyRnZhalBuU0tTZGQ5Y2NE?=
 =?utf-8?B?QWRBd3ZRSG0ySlpaaE1EZ0VjWXBSWEE0UFBaUlZyVUcrQjc3aVVGQXpFNlZz?=
 =?utf-8?B?RFJ3YlFYeXNNQjU1QlIySC9PK1RRY1dHRzhLZXRha3kreXFlNDZQWG95THpP?=
 =?utf-8?B?SUprTWVwUzJ2cDNFbVlQY0Jvc3dtZE1RYW5iWlp2d3ZtTVNDY2xVNFM2dTVj?=
 =?utf-8?B?U0Jna3EwZjBHUXN1YVg1NHdQZWVpQ3FaNlBxdXNEam1TSUlhNmlzaGNjS2dk?=
 =?utf-8?B?cGdtckxOVVhSZXhsZG10L3pyWko5NGlxTnEwZTVuUlI2TDdDNzU5cHFiV3dS?=
 =?utf-8?B?cFNLbmRBUFBGZXRqQ2ljNWt0akpVZm4weHN2SnpzNk0zUytJS09qRGFieFZP?=
 =?utf-8?B?a3ZEbEFJWnZYSHR5ZGI5UE1IMy9Db2hFcERNNmJUMTFDSndIUURYUCtaZDRt?=
 =?utf-8?B?eFU4Yk4yMElOWE4vQ05kWnJudHdrT1VMUjg5a2JINUJxaVVJbkhlRFlrUklr?=
 =?utf-8?B?Y0pvNUZWRFJWMUlEZVNJc043TmxwOEtJaU5hNHVmZG9NK1RSQjdCRENaMzdl?=
 =?utf-8?B?MUtJcXRhd2c4c2N1SVQxTkZkaEZIRnNLbGpCNSt5WmpQR0d3VGVsUFRwV2kr?=
 =?utf-8?B?OXJnK0poRlNGSnRTQW41eER3NCs5TzVZcTB0dElXUTk0T0wzVWFMcjFEZU9n?=
 =?utf-8?B?MlAyME9vUE9RY3pvV0Vma1VsWVlSd1AzYnVnam5NaDFsYXJzT2JuM3BvMlpC?=
 =?utf-8?Q?bO2Id0Oe0usXjPxbhh4bbWEc9oGPcNImeWbD4l4uLb8oc?=
X-MS-Exchange-AntiSpam-MessageData-1: Mfe/a7NNJ8qcTQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff5860b-8787-4943-2ea1-08deb09f6350
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:26:14.7146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnzIK12fcUxTtzpWaJU9DaewBNA0dGxKWyxct36HFhC9IZ+2NWOh1pIFEyCVQ68YVx6alx2L+P/6FmUziBwzPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
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

On Tuesday, May 12, 2026 2:29=E2=80=AFPM Aaron Kling wrote:
> There is an issue with tegra-drm where some buffers get created, then
> freed, but the dma buffer never gets freed. Causing display controller
> memory allocations to start failing after the leaks fill up cma.
>=20
> I created an issue on the freedesktop issue tracker [0] with a patch
> with some debug logs I added, then a log from Android that contains
> these logs. CMA is set to 512MB, and when allocations start to fail,
> the unfreed allocations add up to just shy of 500MB, where it's
> reasonable to expect that 8MB contiguous is no longer available. The
> log was generated on a Jetson TX2 NX, but I have seen this leak on
> other archs as well, this also does not appear to be limited to soc's
> with nvdisplay.
>=20
> This does not appear to be a userspace issue. The graphics allocator
> works as expected for other soc vendors. And as the logs show, the
> delete dumb buffer ioctl is called, but is not always followed by the
> dma buffer getting freed. I have also observed this issue with a
> gralloc that uses the tegra gem create and such, this is not unique to
> dumb buffers, that's just the last log I had when deciding to post the
> issue to lkml.
>=20
> What I primarily intend to ask here is how to further debug this
> issue. I'm not finding any direct path between the delete dumb ioctl
> handling and gem release or tegra bo free. Can someone point me to the
> pieces in the middle I'm missing, where the logic is to decide is a
> buffer should be freed?
>=20
> Aaron
>=20
> [0] https://gitlab.freedesktop.org/drm/tegra/-/work_items/9
>=20

If the issue is specific to buffers that get used with display, I have
an idea of what the issue is -- there is some circular reference
counting with the BO cache in the host1x driver, and that means that
BOs that end up in the cache never get released.

Let me do some testing locally and I'll send out a patch once ready.

Thanks!
Mikko



