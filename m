Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6545606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AQ0ELILF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EAF0112765;
	Fri, 30 Oct 2026 11:28:13 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829E0112760
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujUbugVQNv+Oyh2r4chwTv34S+Yz+1c381jXbhuH0NLfVhVWRU7Us0sUBirwfp8rXmYMZmFY5GI1m7keLEwfP98KEIJ6ubXd3sLgV0M9NzvO/mR+YlN3f9rDaKOLaNtARnw/KF59Snaae3/OKUH3RBjhdUfEYAQMBpOvsZ0BfcU/v0p/OEpFAaT9djG3GHnsqltgTRt9/jfPIooCUX/G7j2/t0tNDjz2IyHafj/vMmOyI2/gDPGP2OR4/O6oLNW5Bg9XZuzJ6JOpOfdKOG5UN1abvLCr2t9TK6PUmS/5vjisv1/Sk/tVwGmyB5i5wjAAsqiAB7vNsoC55EzOB9iRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz227rjEiKN5iRDvGjLpgvXzzPLr8OgQbGeRuPq1W7A=;
 b=vdHm/u+19yrBtz8BmgqQ2ppyKwXCUcB0XMX0p1tHeWwSKSgP6LQUPdr2fzpfhsUeAdy2d15407+RIdwOu/2X7bOutWqicQrehvvSx8fv0kVVF+8s4p4p7qmoN+P2AJ1NSHrHB6lcSsS6H/PQ0J+ceVvZI6SQQ0AAuLkuIX7mNPK0M78yjy2cxw5So0CXM80zEkdSaFWYmSUiJeAAexsHtiSWIQDw0ymmzp0sGd2wgNnz2wmK2jhXvsG+moBckKwJ/bYfNlc7O85weGMO4UtG+eEWrHQz2Q7/zLUGtUGf3ZsGwWd8PXRqbEshr843spB/Zo9j3pmn3Lc0/r/78S/+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz227rjEiKN5iRDvGjLpgvXzzPLr8OgQbGeRuPq1W7A=;
 b=AQ0ELILF2gAhDSNDweQUyve3kJ4ozbRmWw/isb+SOxRouYYuaEG1G7t/oTHotmmprzv/w+D/zvj+f+gWA4Zq5AvzGSM8WQBNXlNvZzDYpZzUUFMFy+INUgkZ5m+09oCG10KO/9ggCwd57ns3oaDzY2s5YvPMB6ZVECI5cN8mGHDZN6ZOvlNmi6V6VjdQLHWHrhacIiiJBLPIS6e1fUQLRM6yrEpcpxE06PCH9PVBJIUSS3l/UORtQH8wAEyLPu29MEQRJbZ3pAfU5089eQeqnO3xO66dxlnKgP9vw273WJnm75FBwsOR10qSdFECOULR/nbA1Oh6HxW2jBDNa2QEPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV9PR12MB9832.namprd12.prod.outlook.com (2603:10b6:408:2f3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 11:28:04 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:28:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 20:28:00 +0900
Message-Id: <DMI4Y7JR9W9G.2PLC9QX04QIQ8@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "David Airlie" <airlied@redhat.com>
Cc: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: nova-core: make pramin/buddy optional
References: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
 <DMHV8ZWTAEVB.YC2XG5BHNBN4@nvidia.com>
 <CAMwc25q7=Sy_yoUdSXU1r-KudqG5wGSkK+9k2E8e7PxGSkqhjg@mail.gmail.com>
In-Reply-To: <CAMwc25q7=Sy_yoUdSXU1r-KudqG5wGSkK+9k2E8e7PxGSkqhjg@mail.gmail.com>
X-ClientProxiedBy: OS7PR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:604:24f::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV9PR12MB9832:EE_
X-MS-Office365-Filtering-Correlation-Id: a996df37-7b7f-46e8-e659-08df3678dc8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|23010399003|1800799024|22082099003|18002099003|3023799007|10067099003|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 0sxd8Lx0kC8Y1KBAsC0Pwo78Wi9Py6eHwja1gpUpvaIdv2ues38snjrOxwNJ5x1ODuI1dBGQ2ot1ltC/Ro8dYhjkm5BvUPq9DuzK/8kPDxdf4f+nBGm/MHoZcUM22rPFESlZPOuH9I03R4Dunw1ax6A6uby0tgVGdZfyNtMytcCoDrfqie+2tCTrQfSQ1zO/RtgFuULKcOIR+7QZ/YhqfQOu7XjqlKnzEGJpv7lpBW6FL9WkDJ1y3BDm8ERdtC4vHQYmT9k/a3uezrV7Hyqpngp0ro4zeUoY2c6kH4koEengjtL38tAEZhktfPhQvHv4sFpV4F9nupMI+Nh6ASmxT+vomD2nX+TnG0X3Qhm4TRPKzMS25lcXX9l1kEiH/6EaMVIGYrpjRYURVvjvQMuwFsn1Whwi0Ts8ZyX93i0qYNXFMse5xO/JstReGjFBGqETaUhX3sDa/oBlZPU+M8N2zb4CDFMtH2a5WDcmGPtZU2OhlJhpL+HeE0GUqjCu+nyAvF4UuK/CPuAeuJ9rupEtf8UGq07jH130ZBozrXxhNvbwnHrDrSpndbNnoxKdJJ14MhAoypHimb7t5rz3+vQZ5O2+fiIUeV95GlVsCExlztPtRuISHngG17PX13wAYl54PX/SQVtm8ec+/AS5eExAntDB3UMxlO4PhPLtnw7pTn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHRnQ1Y3RVQrajRPOUhhVjBDcHc0bDJ2b3dMbDdFRWp4dDhudm16RXUzYUtC?=
 =?utf-8?B?ZEt2Q1VaR2JnZ1hBUnNpY3AxKzVpZEhndXZvKzBKNVVOM2w3WGlSMTErbzVz?=
 =?utf-8?B?aWpVSVJ1SjJjY3BlaWNrelBOalUwZlByclVYQlRrSWFRbitYQVpxTFMwaThW?=
 =?utf-8?B?YWFBTFY5WUVsSnp2ZWFWV21PLzVpQVRWWVNGYTRkMmJxeVlOdmU2WkhyVWhJ?=
 =?utf-8?B?cEdMODNyWWxZQmg5dkVrRTZNNnRxTk9iYnZ1bEFvNmhCVkt6VEUvQitFaHQr?=
 =?utf-8?B?aTRsV28veUsrZEd5QThKbUYzdnhGRWZkTkUyRjNPUXZWSEdTdXlvNkNhSlEw?=
 =?utf-8?B?RXZjTFdzcGJwNnFWZlJNTkNNblFsL1REQ0diems1MGNYM1hNS3hheS8wTmxo?=
 =?utf-8?B?MUZ2UlZFMFZOdVhIcDcxQUVQVkZtczJET2FubDg3cEpUbnhVOTBsY2NnaHJN?=
 =?utf-8?B?R3NhTnlIOGxaV1VOS0l6bnhTVkI4ZmxsWmNya0krY2cvYlZyb3VobFBQSkVx?=
 =?utf-8?B?cUVKNDRVdkIrV3FjR29WNmhNRjZHY2M0TUhYLzdBdFNLT0VlZ3doYWxCNmdB?=
 =?utf-8?B?eFZRRlFmbVZ6anhacWNaeFdZdk1vaVhKQWY4a0lLeE9zK0w2bm45WTduenhh?=
 =?utf-8?B?aUc0UndSZXJUQmN3d0pENEVoam94QytVc09NREhUOHhmOGhWZ04yb1JQWlc2?=
 =?utf-8?B?aklMSHUwcUw3cWVwcW5aaXJXZWsrMmJMTVFLSm9QK1pwUEdjYlNkTmllNnRH?=
 =?utf-8?B?V1hENFlrcmRSbi9GN0hPbkNoQUFqalhybURTTDJFeUFjZ2RSVGE4ZEhrOEZM?=
 =?utf-8?B?Y0xHcVUwQnlHeFRYRXlmSUY3UTBXaCszUzRNc3dCMTJNeTRoTzRCc3J2WUlM?=
 =?utf-8?B?MUZxNkhDRUlNSjk2NVVpV2JLenFVNUJJT05jblFCSW1OM21JRE4zWUVuSy9s?=
 =?utf-8?B?NHZpZlpTSjgvQklFTk5KY1JOV1loM1NiaXV3bFp3YzVuM0JYSHEyenBCVE9R?=
 =?utf-8?B?VFFqWTkzdkNQTmtIdGRGWjczR1BqNTBrakxxOCtqOC9DOUhPUHI4UzNYVlJR?=
 =?utf-8?B?TXdiOElMVDlIYTNrSnNaZTlRMU0zUUlJV3lRWk1NTWNkTEVTYTE1bEhrWkpF?=
 =?utf-8?B?SFFDaXJ0L3BFYmtQK2N5QytVTGN4MHBXUXVTcXhDaXJYN09taUJUUjJwdmtM?=
 =?utf-8?B?eTZoK1BYbFJpMlk5Q1JkcFZ1NE13anRHYTRISGVqV2hkamVkZWUrcmlwQ29F?=
 =?utf-8?B?M294aEp1QnFvZ1pnYnNZSGxkaHA1eUZ0NzQ3TGpQZlVFTFRvVUhhMzFwNjFB?=
 =?utf-8?B?R0xCRnpJUnFDQmV2eVZYRGpsUUJDNHlHWVRCaThBbGZ6Q09LYzE4M1gzSW05?=
 =?utf-8?B?eHoxa1c2K0tVSUluUXlaaGdhL0Q4dkF6YlhFbWFyZk5mVlQ2aHNuQWZKQVI5?=
 =?utf-8?B?bExlUWRJcGorKzRxblFkd3RTUjYwckUzMEhqUlcwaHBPSHNSTG5BTTJGT3U3?=
 =?utf-8?B?UlVUelhYaTRyUkxzT1FaWVM0UVdLUVdSbzR1SXUyWFlXRXpTcGloSGpidDRy?=
 =?utf-8?B?ZzBhSGtKbnFad3p6VTdSOGtsa0g5b25DWHFUNGJid0t2WG5rK0xtZzNad2Vn?=
 =?utf-8?B?enFRY2xGVVJrY3FZRGxaK2VLWWxxSzJvMDBNWndxa29jemNUeEVmMzJ0K3g3?=
 =?utf-8?B?YWx3NzZBT2FjUkk2eE9Da2QxZXhuVEtYckJFSUJJUlFIbEpsbWpLdHdGZWF0?=
 =?utf-8?B?enFJaURFb0s1aW53TklhYUhJaTUvRUpPTjVCMmZXeEhlemQrZVhZVEJtZ0dL?=
 =?utf-8?B?eHRMQnEyNENTeXVaUm1iMTY1Zmh1K0htakdRRWE4S3JoOXBJQWlkNlh0VWhQ?=
 =?utf-8?B?RTJOZHIvdDFUMUUzaW4zRmhPWHljSWRGQ01hNmFrMjErVjBrQkZuMFU4V1Jt?=
 =?utf-8?B?VFVRU1JiSmd0M29jYWVnYlhGbGxTaSsyWHJIaHBnNWs5UGVzUmJRaUJlN1FX?=
 =?utf-8?B?aU93Q2lzdFBNWUpDMjZuZVRQK25UUm1XR2dybCtvZzFYd25mbnNGNVBmOWNl?=
 =?utf-8?B?WE1oTGpET3NlMG1ZSmYrN1FkajF5OC94NWFpQlVmcWV0WnNYbGFWSE1jYnJG?=
 =?utf-8?B?bDdxak95bnBwRmpLY1RIMENtQjhTR0tRUENSdHYza1BmRGNXWS8vUWNHNm4x?=
 =?utf-8?B?d2lHVkpoRUlzVTZIZ1dHWGNIbEZLQlc5dGFBeWMrWkpFUmdiQnBjT3VxOXRK?=
 =?utf-8?B?cDlXYjNRZERGcXVEWGlQOVRkOGl6N3g1OURiNFRuU2NNcjZzLzB6bndKZ0Y5?=
 =?utf-8?B?L00wWEt6cVJJbU9pUk5qSGpLNURaa1pUV3g4Nkw3NklWWWdMRmJJOVpSWTRW?=
 =?utf-8?Q?6hptsIQHx4EyxeA/llhouMX3mEUZG2AmqFLS6dhS881Da?=
X-MS-Exchange-AntiSpam-MessageData-1: YyH9H5o5wa9P6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a996df37-7b7f-46e8-e659-08df3678dc8c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:28:03.5090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJHIpw74ceFJFYwr2sAWPOkbyESdqK5oGtNwO+Xk9zDSJz1Q4LI0rdVr2A8LIvnYHhaa9q023UItvk63DQ761A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9832
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 30, 2026 at 3:18 PM JST, David Airlie wrote:
>> This is related to the comment made by Sashiko, but in which cases are
>> we expecting `total_fb_end` to be `None` here? Is this the same set of
>> systems for which `buddy_params` will be `None`? If so both arguments
>> should be merged into a new type to remove the ability to represent
>> invalid state where one is `Some` and the other is `None`.
>
> Indeed I've been working on a patchset to better define the concept
> for total_fb_end, so this patchset can work on top in a proper manner.
>
> The question of whether total_fb_end =3D=3D Some(0) or total_fb_end =3D=
=3D
> None is a sufficient indicator for no framebuffer, and I suppose we
> have to make a choice before we can land this patch, anyone got an opinio=
n?

I don't have a definitive answer to that, only a similar question [1]
for a hypothetical FB HAL method that might also cover this?

[1] https://lore.kernel.org/all/DMI4UK02HZB8.1KEPETWUOZ7E5@nvidia.com/

<...>
>> > @@ -120,7 +120,7 @@ fn ensure_single_pte_path(
>> >          for _ in 0..max_iter {
>> >              let result =3D self
>> >                  .walker
>> > -                .walk_pde_levels(mm.pramin_mut(), vfn, |install_addr|=
 {
>> > +                .walk_pde_levels(mm.pramin_mut()?, vfn, |install_addr=
| {
>> >                      pt_pages.get(&install_addr).and_then(|p| {
>> >                          p.alloc
>> >                              .iter()
>> > @@ -197,7 +197,7 @@ pub(super) fn install_mappings(
>> >          writable: bool,
>> >      ) -> Result {
>> >          {
>> > -            let pramin =3D mm.pramin_mut();
>> > +            let pramin =3D mm.pramin_mut()?;
>> >
>> >              // Drain prepared PT pages, install all pending PDEs.
>> >              let mut cursor =3D pt_pages.cursor_front_mut();
>> > @@ -255,7 +255,7 @@ pub(super) fn invalidate_ptes(
>> >          let invalid_pte =3D M::Pte::invalid();
>> >
>> >          {
>> > -            let pramin =3D mm.pramin_mut();
>> > +            let pramin =3D mm.pramin_mut()?;
>>
>> I'll let Eliot comment on this in more depth as I am not very familiar
>> with this module, but I'd like to avoid these runtime checks if
>> possible. On systems without a framebuffer, we should not even be able
>> to call these methods, so I'd like to enforce it at that level.
>>
>> Ideally, we would consolidate all the state requiring a framebuffer into
>> a new type (i.e. my first comment, but pushed further), and put it
>> behind a single `Option` that solely tells us whether the system has a
>> framebuffer or not. Then methods requiring a framebuffer can be passed a
>> reference to that type and work without runtime checking its presence.
>
> I think we have to get to handling instmem maps in bar2 properly
> before we can completely encapsulate everything.
>
> Ideally instmem would have one API for allocation and it would be
> backed on systems with VRAM with vram allocations, and with dma
> allocations on 0-fb systems.
>
> Then we would have to store the instmem backing in some sort of
> encapsulation that hides the pramin/vram buddy/bar2 handling and
> device handle for dma alloc handling
>
> Does that make sense?

Yes, and especially after Eliot's comment my suggestion seems to be moot
anyway. As long as we have an idea of where we want to take this to
minimize unneeded runtime checks, I think these kind of temporary
workarounds are ok while the correct design comes together.
