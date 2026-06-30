Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902DDC44500
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD0E10E031;
	Tue, 30 Jun 2026 14:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bKx3BmBa";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE4AC10E031
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 14:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU5kqw4g7+ItY5hGNxc5uadOAy14Z17evP+T15WUx/wPmDroSVycrnd0W3OnTqu7Ra23yz8T02u9AyrX/kpSx1QjsIvaLIj0xBq9ucOHYKvwM5lMhk6O6LxROw43PsgzYEBGUBQlPcOvTlmvhOmulmUH8JRBM1LKlSsGhw+v4sU0AolLlZFcU2DIvwNLGevYENHhrx2mLBJVnGtJKYE+8VCjf+ZKm4Dan04Qhf+P81zw4dmg3Gn1ppp8DNQRffdmMHBVJamxyjiYMir5u2Er24USuLDsubukhyTwt8/YcfuU2JTXcdTtVBsxFsmOQNYrMWA257qybNRUd5kiRMDPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU3UTNCQzemXZKEqlk46G+IGy4Dsdy8MQ2ic/hCkPKU=;
 b=nxHfCqK2m/EzqZiK53jij+lRA8rp3q1R3UKxfu/5TbDlZIbFOsJYT60MOwZ7DCLIb1qw2qPO7qcE67zalAbmzmuOTLSNNkhmj0d5NWe+y56HA8bgwL1MwcdqZiiv4W0C0D0YnGcufSTaG+/Owhb5/fEujBVN5NCaSgUIGUcaF+wK29u5Pz/P330yczZ7UFvf4tQlyT2IvWz+lnHUMDugDnoXIHaoP8qIR7ADQ0ngT93qqtLn9pWUPiW4pPIhRDDKcC3sDM0p6ZJQvwaQX5MTd3l+j/JM/iHg4xdejaQdRjgtEoIGk1vVjU5fPl9zQdHNHGW7R5B4gA3OTxcyqq+kIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU3UTNCQzemXZKEqlk46G+IGy4Dsdy8MQ2ic/hCkPKU=;
 b=bKx3BmBaTIj4uZ9RCCj0uH1U7scIaM5jwR0zYWySlVEzvZ6pEYm+Shz0NFJl/sUMNZpmkqzZYYajMadba/UCt/tykiQSMN+z2VBVyRaSHpnkccVpvJkg3WgFWdhgv4SuJqVUuieJIKSG9x+Hxvt5Tm7gcZ7hnaskNYVmDZslYRs5MV+5D2w+YBH/gdxF9eRLhefXCZMsKUNgJZw9q1JafmeeZkbb4fKrG5eFACDLfTILSkGUuZW0WHojayAIxq7YR2luTWxdDCnjuE44X5pPuvVDNkzZTLbWrAADg54MOg2NkepAwzSK5ubJM1NadnKHJkwTtspmi7tKy59if2qJBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 14:03:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 14:03:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 23:03:40 +0900
Message-Id: <DJMFUXV5YX9Q.3OUBROLD51NM3@nvidia.com>
Subject: Re: [PATCH v2] gpu: nova-core: parse structs via zerocopy
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alistair Popple"
 <apopple@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Tamir Duberstein" <tamird@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Pedro Yudi Honda" <niyudi.honda@usp.br>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-kernel-mentees@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>
References: <20260629142007.269873-1-nico.antinori.7@gmail.com>
In-Reply-To: <20260629142007.269873-1-nico.antinori.7@gmail.com>
X-ClientProxiedBy: TYCP286CA0346.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 301fe514-2d2c-4b24-bd40-08ded6b06584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|1800799024|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: OFfqkUtpCHXjoGTgyVzBC/e28VsYOCwCeTGwoeHAgN8Ty86hpFY8dWvWnDLAdoY+F09A04ezNK+36epDs4KdFlDVuhqfRBSt91rbbqrSi1u/qbLGA12SeddJhsLCB8Zj1XK9A2mchYo2i2jbSJU+Ix0Xe4yoU28U0eBFnwkAIV8jasvLBm8G9IZUZiRiUDlVk+gM7vG6KtAXoMEeWjH4YxSYZtAdcKGVVTqBd13jbu7GIPmnNkM5T+wei0nFzVqc07mO2b0uC9qC881Eq6JTmpBB57dDg3/oRcJueEPamdXqUAU/9OX5SyJIvd3BSV6m+yYl1bU4niGpz1Hjz0idBJHuMLsDyK5p/xoqKiyP+JnFwMmy/c+8DncA9QidKUjENIFIwZSwBd0lOeTpp1AoiV4+RJAQVG0+o45iJWA9m7CiWC3TUDcQrecXZjVH/NgYwZjnzbrIh1ERsvl5m2hg+2L9g7lm/vZuGwBpbDGckB8ui1ndVwYqJA7gIhVz3uqAxut57PG6lofbCbTSGdbInpuAMPIfrKhSDKhlprLhnhAOFIFcLFEvomgsT9+35bIcWtT7ut7BNXlAcrIeVhqAsiZnoPgdSw+xBC+pcryW4RdT++9RsVZAnROOAHoqd4duqLF0vRKk+JTQL5Ke5WSzgkoKqbbOzzA52jbcUl31zTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzhIYnY2UGYvM2xLS2R4VkVSOGtGOGVmVU04eTRsTlVSNUZIbWFBS0VRbWNw?=
 =?utf-8?B?c2pHV210Q1ZONy8xZkpSVEFPUk1kUlkraDVlUUxIeU5pbGt1MkZzL0NCcm9p?=
 =?utf-8?B?azkxVWpzb0JiQkJXZmI4SzE1dnkrSXF4T3pVSys5TDEwSzYvUXIwaVY0RFRt?=
 =?utf-8?B?SnM4NW9OK2JzWHhzdjhiTVM5RktuVkUrUjRXbFM3Snlyd29YTVhaYVBzT0lG?=
 =?utf-8?B?Y1d5b1FXM0VMUjBVNDloMmFyTTVuTUNsN05wOVRCeXNWQXhuZXJFTXFQbzFl?=
 =?utf-8?B?YXhYdU1OSFlmOXhPemVWNnRabFdKY2JOYUJERUQyMklYSjN4N3lTajBMQkVh?=
 =?utf-8?B?dVFkZVJWdTBXOVJuNDBqWCtJN1JrZk9qT2JaMWhUa254U2tOTE9idXVKNWRp?=
 =?utf-8?B?U09WaFBKem9ZOFdDS00vT2wxOVdQZE9RUW5UZm9BU25xMy9PME11eSthc0FC?=
 =?utf-8?B?RzY0eUUycWpxbDY0clZMd3psaFB0WnFyQ1JnRVR1NksxZUk5VFczeHozQjBj?=
 =?utf-8?B?bWgwcDJ6UEJNdHVhSjJjQmdUS1lQM2RJTnB4WFJubVkyWWlySHdDWUpWdlpk?=
 =?utf-8?B?ZDErYXpwYWp4NHBKZXRLS0ErVU1QWlBWQi84SUY3MGVCM0VieFprYmtPdFRZ?=
 =?utf-8?B?QXhhc1NuZGxFVXA3UEV0ZGZRQnlsRVMyOTlCOUM4RUExRDNVUGMxajY5MVZ6?=
 =?utf-8?B?OEdBOGxVOTdVcWgvRHZnMUxFOE55VTlKVHM3Zit4b1pqMitHUlFOWFJsNW9C?=
 =?utf-8?B?cUtJRjRBU3kxTlVUWWc3WllKcXdQMHlET2lxdno5TFhlTnJSVmU4RmRyNGhJ?=
 =?utf-8?B?bmtQVE5xdGxOYWE2RVlUMWR0UE9oQmpUaFpoUWMrZGRTTWdXQUZyVXh4emVX?=
 =?utf-8?B?L09vbHM4NkRNQmI2eWdSVUVzcFlrRkdNVUFIdWFDMHdmdjZCRk1xcVZqSjdI?=
 =?utf-8?B?Y1NrblI3L29BNWpFa1FCdGEyN01tRXNNQlpiekV5NVB6QnYvNUZWL0tEdmdU?=
 =?utf-8?B?TU5kU3g0UXV0MHFCUkxqZ0c0czA1Lys2WldTS2VzZHBWTUNJTE1iaTlxVUlm?=
 =?utf-8?B?UlZpVGtFNVVlYlhzS1dEak5FWVFsS1ZhOFlGVkZianBLNWo4Q3VpOWIrdDdw?=
 =?utf-8?B?ZldOcEFIM09ubEdjT0FUdTgzU29oSFdQaHRLcUtpMGlScjZxRUxYUkV1ejNB?=
 =?utf-8?B?Wm9sMTFTUjFwQWZjOGV1OXNRRjd5cEJGZzB3djNDYmdzdmtBUjB1YWx4amV0?=
 =?utf-8?B?UnBYY1hlZ0U3bjMrU05MMWgzV1hUZkxpd01ZZFhseThEQ3V5Ym01cDAveWg0?=
 =?utf-8?B?bXNGN3Mxb1Q0UEp1RUlvNFV2T2h3TnFmZktxeXkxc2IzSkx5bmp6QXlCa3ZH?=
 =?utf-8?B?YjViNko1UmVlZW1qUThKOSt1bmRYVy91OENxL1pGTUVVNmRhb3BKdEFtdlpw?=
 =?utf-8?B?MHBwR1NUbUpydFR6d3I5K1VNZWxlTHFvZlJCendqeFpWL1RzUVlFK2ZwNDBy?=
 =?utf-8?B?WGpneEZ0MkEvV2JJeXJ6Q2RUL3ExK3QzQWVqV1RsdzRhMEdMbkxPa2E3ZnVa?=
 =?utf-8?B?NnFMVjE2SldpRHdncFNmdVA3UkdzdkJaWmo5M1k3dlVENGRNVExlcWgyR2xk?=
 =?utf-8?B?L1NQcTJWZWhXQ2VWTVJ4MVArVEp4cnlWM3luODlZWTBEUk5VdW9vNUQvTkVh?=
 =?utf-8?B?WFRIcU9xMUpQY1ZLT08weEp4K3B2clRpL1hvVmhYdDdUU29kNi9PeWhEYWdJ?=
 =?utf-8?B?THJKTm43c2lNTzlzWHJKOGxQMG5YTlFoU2kzVDYvR0xNSk5LRlNwUFFYSkJO?=
 =?utf-8?B?aWZXd0ZIZGMyM01MMFRhcncrUzdRMWVmNjlINC9MbEVOeDJEdkpxblFOY2FB?=
 =?utf-8?B?T21Say9TOWRKakNKWTFORXJyaThVSWZhMGozMkJIV1RMTTFSNkdwdWJ2ZXYz?=
 =?utf-8?B?eHg0OFhZTWtYcmRnUVBTWkVvendxQ2VGcjRTKzVjTitPVmpzN2xXaEdqODMv?=
 =?utf-8?B?cEk5MHBZU1A4ZEsvaWh3RXVmejIwNnEvVUtJOTduMjRhY0ltUzlzdHhZcit0?=
 =?utf-8?B?QTZhNE9UUW5LSmdUd2pXYnVUVFZpRE02bHlXc1VmRjJESkNMQjJZdnNRT1Q4?=
 =?utf-8?B?NzVBa1VObThPNVpGeWpVWjFWb3h6VWtBdlZYbUZBR0Ztbndqc2k4d0pDVlN2?=
 =?utf-8?B?S29nMjFnRTNvOG5aU0tadzkxKzJTdCtQL1JwNTlBOS9KTnc3NVBTdEQveGNW?=
 =?utf-8?B?VFpwY08wZkp4bmN2cmJ2NnkvM2l1ZE1DRlF5YkVscGt4SUlIWnliRk9XTTl0?=
 =?utf-8?B?MnYwVWk1WlJvNGd0K1FHblJFTmtpYzgrWERRZ1JQeEZkS0Jnam00aVlDNUl0?=
 =?utf-8?Q?KvqFSSQNyAoEmFU5xOhKj6PiJgaUfK+obdHVMuEBTVLgI?=
X-MS-Exchange-AntiSpam-MessageData-1: zqNKIFWLwCLrKA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301fe514-2d2c-4b24-bd40-08ded6b06584
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:03:44.1073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeuutC4/Y+e/gqh8w/Vjvu3sr8kWCd8R5VEPkA+/ZLTvr2B0S+5qhMS5mB+2Tx6r/L5X40mn8PQDrLpHQMgPjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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

On Mon Jun 29, 2026 at 11:20 PM JST, Nicol=C3=A1s Antinori wrote:
> Replace the unsafe `kernel::transmute::FromBytes` trait implementation
> for the `FalconUCodeDescV3`, `PcirStruct`, `BitHeader`, `BitToken`,
> `NpdeStruct`, `PciRomHeader`, `PmuLookupTableEntry` and
> `PmuLookupTableHeader` structs with the derivable `zerocopy::FromBytes`
> trait.
>
> This change eliminates the manual unsafe implementations in favor of a
> derivable trait. When this trait is derived, validity checks are
> performed at compile time to ensure that the type can safely implement
> `FromBytes`.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1241
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>

Pushed to `drm-rust-next`, thanks!

  [acourbot: add `vbios:` prefix to commit title.]
