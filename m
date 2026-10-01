Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC60CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 04:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE74210E046;
	Thu,  1 Oct 2026 04:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BvQ7NEid";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C01C10E046;
 Thu,  1 Oct 2026 04:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPvwwUtnGzYiWeJ+Gfme2pHkwa5+NEFGif/9swJcdjb2pThCVsD3kSPLMD/vbw/T7ryaWCIT6JzvWiP69/XTKv55mt1tdrhfQnJD6aeXndmLYt7JyozSfB1mxBnwQ++YIg+iEIwDAa4yKAmjCM/YrB8SShxDvE6EcPRgnGdWLpxvfPTAd8ALsoNQ9Xlpk1teaA0FytZEPIPRmdMdLFtZkUY5HVL2RANXreSbFxzqtEj6hvIlE9XdhyqN4+ESkrDqZx63u9UuzV6FLISXPtmPxroLKTW0IVR/zTUcOHy19C9gdcT1SSWkqiZ352OyiMi/F72GIRYDgMaxvRHnrBJaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTyKbxWffL+9+ycYtSYd/BVLI0Js8vlq2vBr0IQZUvY=;
 b=urfD0ULBZnCKiveCeGfg9Ys397dENNrvYDKMSlQ/hlu84LjhoOaxMkrM2juhtqyzzX3N0vDjGjmES62/oi5C+sD1eE5DBhZQQCEqQvIdOQ10ygn9pHEq0RLc+6k4ssWkRBoT19SbiEk2MvPRWALFPiabxdGoJbmhFNiz2jkVCg0MVF7p03t8BzpqpPShQaP4HlDg9YT3BskH/1oE+LQq/tedo7MT6ToWrBctSozIGrGu/Bzyi5J2R/KGEWwbFRj8EUwWcw1E0cqrZrBB3ol2Gq2sCPMX5aUXwVPRyb3Sw07hJuDAP1cO0B9x1s2DQ/BZnZls+QHuzAxZVneX7+YcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTyKbxWffL+9+ycYtSYd/BVLI0Js8vlq2vBr0IQZUvY=;
 b=BvQ7NEidURakBQ3IDNItpLWdYu8h4spr3reTB2Kj61SLZdbcvBpiPd/57/YEJ2i/xnwA8pyGQeKi0jpcfBocS3KVTl8+J2iQBcMTFpB38pGzLGQ2LecsR2RX7AZ5W0QvwvlF1+Iy6BkRS7rgw9Bpt4YmwRcR+aG0myx7MxobGfFT2QMs+4/vP24z/tpjn0MOLpD67YRo82fq3gerLd29vZVMqnvvahcXCno5kIdCSy93mRt0+jh/JcBuC4pK4Q2G8D97duuI0jBl+3FvxtlfOCJG/3ap0TQOHSK5BCd2ZQw7YxFkTWdtXirFjfZI1NBYIN6VFWvW/U71EQuvNYXUDg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 04:04:14 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 04:04:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 13:04:10 +0900
Message-Id: <DLT7CLF1AJVA.3BNA0XWZOZB99@nvidia.com>
Subject: Re: [PATCH v3 5/9] gpu: nova-core: gsp: cmdq: split RPC parsing
 part of the receive path
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
 <20260930-cmdq-rpc-v3-5-91613f06520b@nvidia.com>
In-Reply-To: <20260930-cmdq-rpc-v3-5-91613f06520b@nvidia.com>
X-ClientProxiedBy: TYCP301CA0060.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca3cc0a-5551-40fc-34d4-08df1f710e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|376014|7416014|1800799024|22082099003|18002099003|3023799007|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +qEknAk13WDOJaFV4nDOA/wNmAavRaUGlUCxEBU+JsImoxzWvMEyc6A050Fu3KauKv9K7tWY4BHkdC8bcBakazTthUWo8qetpslFtzKbFxYXasw+QxKir2nvDzo6ytpWr6yOZ1pTIohyV0Gw8tjqYbVqjIElmQXWr6OkV4Tu1mZZ/qUuohckMqAnnd1k+u/yWRdjCzrnGwoTNqVIh9GAVhjnheYTXVfNbnrSeExCFl3xIRnYu91AoZNBgmuqPtKJ6gC4ivFfWwcPAu846x1yiotkZ0DiTB+r/RnzDaOvjuuumL0JB/eTJyKX0B/3FTlxBoAmCzrEaFWXJGbtiETKhPWfDAwuPYVVSgy8cKWO9rfr0X7XzJ7st+QESNmkRFrH/HGUxTMchhrSUNAM1h77pTpK+KEqZH5IvCmKW2AGShNHzkFMgm54IPpRAFLxtE2RR+C6ZVnDlNrNpREjpBBQEgxoy+sBk9uQz2lMpIwQ7vbQw0vnfra4ifEXGOf4ZUzVicY+Pj8PB8Q71yetnPEUFUqsTvHGzqd6IUF5FiKYGj2tgAnU/rNTFBv/o1K9nrZz+T0nLIedPvz4RFYGs/OnlI3yGHHnICxTQ9ncaA9hrjgFlfevTQHlyqsGQivaRAvu76B1r8O9zThVGc2SHf5/GxX5S3GVa54nRvuu6WnYhfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(3023799007)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkhkWDF0MHN4dGM2di9udllTMDNYUlR3UUl4TFQ2Y1F5QlBVZlh6Z2w3RXJH?=
 =?utf-8?B?dFF3WE5nb0Q0TGptSHB4cWxJcTZIN2VhYjRrVnhaSmNDRmV2RC9xU0Zhb3M5?=
 =?utf-8?B?UmpXdy9zdU9seHVCWWJKcmw3TUd3U05mdU5sK3g2RS9QQi9IQ3FUbXl3YUxU?=
 =?utf-8?B?UDRTTFh0RDVTT0ErYmhvRm12cWMwUnFBb1haWGowMnhYS1A3S0pLVm9FcU40?=
 =?utf-8?B?MnpDNllETUdFWUhQQVRaaHJGV0tLOEFBcHZ4TmFYSVc3TWlvWE16aWt1WjAv?=
 =?utf-8?B?bFE5WDJ1Y1JLNjJjSDY3VXFxUUhTMTZodW1za3dBRGoybGhWVUFQM3VBVVgv?=
 =?utf-8?B?dkZ4b1oyVDh5cmdpQjFMTkVSM0I2a2cxaThha3ZKTUNJQUgrbjlsYllzZ09s?=
 =?utf-8?B?TzU3NFJDMUZ4djIwQncxNXhnUER6Zm5obVpHdXVDbDBXNHQ0SzE2RHcyQjdx?=
 =?utf-8?B?U3U2ZzNYUERtZWtKZzNsVjVhQmpsb2ZWMWlSVEJIdjBndEsyUXUxVGs2c0Vx?=
 =?utf-8?B?blRQSVdHVThsUzNwb2xwWEwvN2lyV29FTGFaVmRpdWd4a2NaNWprU01uaFpL?=
 =?utf-8?B?N1JsS3lrdVhsSUFUcFdyeG9weHQvekNGcFhtWGVCZ0JWcUNlOW1MTWZKdWM5?=
 =?utf-8?B?eVVLcXRZdWtmSGZKdmMyMjQra3ZId2VIQTF1cVl0Tmc0eGh3V2xRTVQ2V09q?=
 =?utf-8?B?aFIyeVFMVzZLZlZ4dXdSanRRcmJaOFlBeGE1aXJVUDVOWStCZlNRaFA5Z2Qw?=
 =?utf-8?B?Z2hOUU56ek1CM3dDU09NdVRiUitkbWJiV3NlOE8xZ3Y1QU5ZN1VPalRKcHl2?=
 =?utf-8?B?YWFVUDFPaUlRRjBHMThuTHBwL1JjeXZmOVkvQWtQN0xpSjhac3BCUHpoeTh1?=
 =?utf-8?B?WDlFZk0xOUg1eXlZakhvSU8veThNRk9iWDdlWEx6SkR5b1J2b2lRcm8xam55?=
 =?utf-8?B?M1RUMktoK1NTTzdZZ3Fia3JRQXZzSzNoMTlNSUdhVDlyYkJTQ3VMRlpQQm5z?=
 =?utf-8?B?UHZtZktVWklvUURPVVVSZ3lKU1ZGdzNCa3BzMDQ0Kys3QTNKRElIU1ZvMFI4?=
 =?utf-8?B?b1NoL2NEbzk0SDhLZzhGRTJzNEU5emlDekV4MWtaY05ibUxKa1N4VHcwMjVy?=
 =?utf-8?B?Y3B3TGJwVEhLYTJlM2libFJBVjF0QU85cDhDREZabCtrSzJtYUpOK21qd3dM?=
 =?utf-8?B?SkoxZjF1Q3dDZWVudkZYT2xGY1pJV2FRQnBRYW1NQlVpc01ldWZ3SXVTUXlE?=
 =?utf-8?B?UnQrUUdUZ2g5K3QrTFk5NTZoSzduWittYmZOTnk1UTVJMzhadEVQQTNzWURY?=
 =?utf-8?B?VDJOTlZZRHNCSjB0OXJVRGNmTTNzR2RSUnFteW1MMVZicWhBNEFqWUZWZ0dF?=
 =?utf-8?B?cEF3WWZLdkFwWGNlRHV6N0dtT21ueVRoTUQ3dG5idUhlWFI5dFhyMWk2VzVw?=
 =?utf-8?B?eXdnTThvMFkreFprZzZaUk5qNzdXNzUwT3g3T1l1dVl2VE1QYnUxdjZXbXVM?=
 =?utf-8?B?amZqRDBhNzYrQkdvbGdWUStCOEF2WE5kazlVUkozNTRjbi9uS3FCeDVZbVhG?=
 =?utf-8?B?cHNRQ29YeGthZFUyLzExQmE4RzlpRXA2M01mZ1U4LzhkRUZheHQyQXhvOUhy?=
 =?utf-8?B?UURydnQ5MTRtb1pEcmgvWkZ4RitqUWtQMnRZM0FJOHdmbEduOWNaQ0FWVG4v?=
 =?utf-8?B?b0ZhTXBZNXlTTSs2UjNrZkdLU0oyWXZybUdCK3dvYWl5emYyTGJ3WGdaODhV?=
 =?utf-8?B?dkFsT25Na2RRTkxCd2xxVzlUVDBxUTJROW04K2tGbGNxMWpNOFBKbG94NDJx?=
 =?utf-8?B?MWU2b3hQSk4rWmR1RVFESHM4VlEvUzRiQ2VBcER1dkh4aTR0d2RpNFhnQTFV?=
 =?utf-8?B?MXMvYVZ5eU5jZEl6K25Lc3Y4WGh0cS81SWdodzRsZXRJdzF5cXlSazFLS3Y2?=
 =?utf-8?B?aDlvRFpoOUI0OFlEbExkM0VHNGJ4eFllSmlTbEszWmtTV3ZQSkpxcFU3dDVQ?=
 =?utf-8?B?M00xbktxUXRIdmNmT1lCbms0b0lseXlDeVF5MWtqTzJFOWt1ZzBoNTE0Sjlr?=
 =?utf-8?B?bW16Ky9zWW9XcVdYV2dnNCtHeWtCZnFsQW1WZnVUMjFjclFZUTlIb2xONW50?=
 =?utf-8?B?RFJYblJqb3ozVjh3OVZra1l4cHc5NmlyQ0NMUHFISm95RW95NHArWU9LNHhi?=
 =?utf-8?B?eTVidzJjKzY2cFRodGY5MHh4bkV1Q2t3ZkJmMk13WGQ0cVo3eHgweHlIakZq?=
 =?utf-8?B?YUdlTFFkVXU3Wkg1amdiS0Z2cnVEbG1XSUZMckVXRmF5eFR5SnlhZzJacE1k?=
 =?utf-8?B?L2xtTzBxNE5xbTVTNkZpMG5heEVqbGFDZjFXQnB6UTBucDloZmk2bHVMYmV2?=
 =?utf-8?Q?rBvqEBdyXbv9qFitx8cY2KH0P3nbaLLnNOYUtBLqpnwBc?=
X-MS-Exchange-AntiSpam-MessageData-1: laIWx2YqOiYxlw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca3cc0a-5551-40fc-34d4-08df1f710e53
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 04:04:14.4574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IbLAuV8MiOIoMjnxo2mTBp/t6yJQbA7Vc1rFRVYMnYqXeZN0QTgvPnfp0uR+qW419YA1XufU5wG1TMW89W4vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
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

On Wed Sep 30, 2026 at 11:55 PM JST, Alexandre Courbot wrote:
> The RPC parsing should not be done in the same method as the transport
> header parsing. Split it out and introduce a `RpcMessage` type to
> indicate messages that have been successfully parsed as RPC. This makes
> the code easier to move around into its new destination.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 37 +++++++++++++++++++++++++++++++++=
----
>  1 file changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index d8a7716fc500..b8a9e02b76fe 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -553,6 +553,17 @@ struct GspMessage<'a> {
>      contents: (&'a [u8], &'a [u8]),
>  }
> =20
> +/// A RPC message ready to be processed from the message queue.
> +///
> +/// This is the type returned by [`CmdqInner::parse_rpc_message`].
> +struct RpcMessage<'a> {
> +    // Reference to the RPC header of the message.
> +    header: &'a RpcMessageHeader,
> +    // Slices to the contents of the message. The second slice is zero u=
nless the message loops
> +    // over the message queue.
> +    contents: (&'a [u8], &'a [u8]),
> +}
> +
>  /// GSP command queue.
>  ///
>  /// Provides the ability to send commands and receive messages from the =
GSP using a shared memory
> @@ -794,7 +805,7 @@ fn send_command<M>(&mut self, command: M) -> Result
>      ///   message queue.
>      ///
>      /// Error codes returned by the message constructor are propagated a=
s-is.
> -    fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
> +    fn wait_for_msg(&self, timeout: Delta) -> Result<RpcMessage<'_>> {

This gets changed back to `GspMessage` return value in the next patch,
and also introduces a bug [1]. What about just keeping return
`GspMessage` here? You can move RpcMessage to the next patch.

[1]: https://lore.kernel.org/all/DLT4O89RYP29.UKGBMIJD8ZSC@nvidia.com/
