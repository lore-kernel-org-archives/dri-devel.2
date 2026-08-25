Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45800C61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A1DC10E246;
	Tue, 25 Aug 2026 21:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KIO5VB/X";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA15C10E246
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 21:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDe1GfTSBpheKxNCcLTp1KjTPLxDlQoIF4nYNtk13wCKT2x5TX9FjZ/yidXnsE40AAiU2wldyaz/dsv1pMjNrbxTqQcMxWvKr3mpVdRAqDTcRCAD5eRNKF8xSr7Z2ccH/dqYr+/nrQS2zSo/FiQIxrpyKhXce100Ub88vL1Gez0u2MtiU/duUyopeHlEWwCebublOb/oP8f457Ls9L1bEpcdPYQqRYP6RBNg5sJ1m2njxBrd+cf6ZtyH+1lloE68ZEY1s/M+7V47ZNZF3t7sefz410SXTZdxWX57JjQuhU/b/SpEAz7z7YMdJCdFnFD1j9bZJqxOrMPDZm2Nk8icRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtBBfdQ9wl//E3dPMvOJnhbv5IMdEDbpNcJudAL7sD0=;
 b=ob2tPmUGX/R9Wi0XInDv+X/CJXLkZHPNK/2SrgIJuVktLypAbbROByf2zqJRPHDr5xeP2UUcDvBATR57KyuyqYxmZgblw/tbmBYUWI8HdjNdAmimCSpguTIMYW7YmGobnxXZNOqT5wN6Bv0s4B1vz1vxAOgjaSqROeiVANClhntnZq14ENP5LlZ8SSHwQdZ0whisa9RKLOVtomP71KFY1gtj4RVEZYGuIvWk9M2CNbgybUJiB48gzlqEoqLSVXRYXcoBF2POv0mZsPGHqC7ghshilkTp2mtsVnPagHdOC2f+XjSVLZ6RlE3V5pmOpCAIZa/NcmSQEK4PE68Ae/MHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtBBfdQ9wl//E3dPMvOJnhbv5IMdEDbpNcJudAL7sD0=;
 b=KIO5VB/X2CsXqwAkP+arHQIK2Py1xu5nnSyQEXiGF/gO/xjQ5AkvaUPcH5nCFDn72DZVDxHqgLpvVldRWZmnizNYNAQm5afTAAH6gPvbxZlIOVRpG4+u1DfM+mJeyAYoATT8WHShfuc5MCv14YAanBoT9sqx8dEs1P2JAjfArHtufKN1LhOkVTs0q0ikqoI1JSGBwF7yzDOp7vbsgiMXQscymzWE0b7R+XYJtE/P8mGbA0xUPaycpBdBQ9O5iAVOSzlYUmrAB3FtdYf4HPdH7CEKRJtrVMeME9mA3/jlylobEklJdAeymb7J3tNLOzw4RRaso60MoVmjYGmeoC3wcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 21:13:36 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 21:13:35 +0000
Message-ID: <ecb0dc71-84f6-4a0a-8bcd-d38b194630d3@nvidia.com>
Date: Tue, 25 Aug 2026 14:13:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] drm: nova: Add chipid enum to nova-drm UAPI
To: Danilo Krummrich <dakr@kernel.org>, Alistair Popple <apopple@nvidia.com>
Cc: M Henning <mhenning@darkrefraction.com>,
 nova-gpu <nova-gpu@lists.linux.dev>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-4-apopple@nvidia.com>
 <CAAgWFh0VvY4D=-Se+bVO1YonRNFEa28nc7+ZbxEbv6en7oPaDw@mail.gmail.com>
 <DKXF49DF656E.XB24SXGL3RLE@kernel.org> <ao062w9fdaQEEYHy@nvdebian.thelocal>
 <DKYBNF427ALE.1OFETHRT4KNHK@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DKYBNF427ALE.1OFETHRT4KNHK@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::32) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 015a8cc9-54db-423a-5d80-08df02edb97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|23010399003|11063799006|10067099003|4143699003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 10AtEZ/Qc1p+lcMyfS7A3FQoOhz1NbvQJJWTkE1elV1uvPKOhHeBdv8a0drqt3XD1TMOLiyrHhBKzk+HuQqft9fPlYJUsJtxSWeSZt9f6QidRtg0sM2pjo3Xg5eLW5UKPn7oriwxq9r4QompwITiCZX59QZnSOvl5cgev8GosUZPPSLOkbX9jj9Epp0c8wntU30RAq1ULWpEQRttXIgPcpCqlfDDvd/1nOl1C0Bvw4hFnYtRjmLgcZXAmpj9X8vv/7wP4mAFvWbR7qd6Qp2gDeN6LsjhfdXt2Clvh2RKK8lO0U5pQUxSFDDplFgv68Bd+dfgl1bGYmr46Pw/f7rhg7wzLA0mR+zr1WOAxEbBFlJQVShITjrvFEJzn+qxDCP+d4x3H2QK8BhD/aEVBQ46W0Vm9+4y0GAPE+nVRd6ar0PODE7R6HLT41VwsoFw7xNuLqzdy8jz17HG8bkyzsQnQl96RZxVfwPuJIdWGo9DTRNuRL81mRL06woRpNQ3t11G6MGYwkXHa/YBqQodLcMMVTDbNwM2CV8rGOm44+LaA2/wIailAtVt91ZnI1uls4TodjIR5iMcFnmAd0sHZXZ4oDP5FwpDiKUc6f1GcubRIBKC88Xm6lIhrBVgbSb4tKYc/dq2AwrCexOvziufmA+mLoHKX0f8ISltzdhdODFzFMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(11063799006)(10067099003)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21zMDkwMi9kSk1HVjJFZHBKWW82V0trdDl3ZnpEZTdRU2ZUdW9tNFZRV2g4?=
 =?utf-8?B?UmpIMWJGcEdSY2VoTTE1d3U3bE5udlU3aDNISklKbzZjWnFSUHlDRjYyaFZX?=
 =?utf-8?B?M2V0eURFc2E0WlI0NllGZmR4M0hNNEIxeHd5WEt6S1BvZVlzVFE0eldZcmds?=
 =?utf-8?B?YzhSMlpDQk5CalRGTUdBMjlQZEVqekdQTkJXYk96VXBRN2ZiZk5DUDkyeFpT?=
 =?utf-8?B?MGtjOE5nRUc5c3QzeHNHNVlsM1hWNlR5VER6Nlk5WFpvUExuckVUdmxmWFpQ?=
 =?utf-8?B?eFpTMDR5STNmQUJxSm9qSEV6cFZyZDZlSzhXWG85c1F1VENvdjl2ZEhSMk9Z?=
 =?utf-8?B?b2toSWI2RExWcFhyRTd2VGJSSW1WRW1UdHowb251QWFqQzd3OSs2WU96RG1l?=
 =?utf-8?B?MThJNmVUR0pVZFN4aWxCTTVYU2owczJUS3FHL0hvZktYQ3N1YlNFSGIzc1dM?=
 =?utf-8?B?OVZoTXNhSE9xa0Y1Umx4M2ZQNm9NNU5Cc09QN1JZTGlOeFR1Mkd1M003WUs2?=
 =?utf-8?B?K3BONmZDS0Y1MDUwY0ZqREZLU2FrZU5jN3RUZjZobzJxMGVTeFh5bkF5RWE3?=
 =?utf-8?B?SlJFSDA3QzVkMExXWHNUUythbCtaQy9pR3pKNTN3VkZnZnlJc0o0TzlIM1BN?=
 =?utf-8?B?WW02dmR0d2Fhb3FHVkV4R3ZVbjhxRGx1Z0JPNHpRY2NYWFREclUyWC9Ia2RW?=
 =?utf-8?B?SzhYeHA3VnNvMGtuYnQ0MEtldCt3MTNWK2NQbExNRlp1Q3BwSm5CSW1CUmw3?=
 =?utf-8?B?MERoVXF4RUcxNmdrcTR3ZVdzMUtUSGt2dndlWHRrbUVKKytpanZGcDdqVnU0?=
 =?utf-8?B?c1J2WXJjSm5WcnhlL2Q0Rk5YdFk3amJrcGhyU1BHT3djUkRaSExWblNKR2o5?=
 =?utf-8?B?MlBtMElGeHRoY3JkSWJ1czNkai9GMjRZQ1J6UmF3OGFBZUNiNjNSUjN1RHRK?=
 =?utf-8?B?WUhadmc4WE1YaTYrLytCajhwV0FLT0lsVFdXalladXpoV2dZRWpPNVRKU1lH?=
 =?utf-8?B?YzlqU2l4Qk1hai9Wa1c2ODNHNisxUG5TcjBmTTZMLzdOazQyWHhXUk94MjZm?=
 =?utf-8?B?TU1HdE5UTHVqTExhUTUrQjcyWmRta0ZuY2dudE5nZk5hQW5QNzNrTEFGNTVG?=
 =?utf-8?B?aVY5OHIvdFpPS2ZwaFY3QjA1byt6L2l0eWJBejJubW1JNUdWbWhZdUU5RWtx?=
 =?utf-8?B?SG1XQXdlQU9EMGxMRkxIem1JMG85QThTTjh4Q1BkNmFuZWxlQ0lpWWh4RGZZ?=
 =?utf-8?B?SkRuM25PYUpKUUVTUjA0SFMrUUpta05td0d6c2J6QUJHL3lQcGdvRVgvZEVS?=
 =?utf-8?B?alMxV0pJZXEvTmhCNzF4NFRHMDMwSW1lbU5sTWpjMVQxMnlZYkQwYlcrRGFh?=
 =?utf-8?B?RWROQVd4QXRFRWlHd3BiSFlSYWhLQk1FZWYyQVlUbzYwWFE3Nloxb1FONG4y?=
 =?utf-8?B?MlYrNFlSTlozUjR2YnlJcDd2R2FQQnBYcktwRW9ham44UWtid2FORzIyQmUw?=
 =?utf-8?B?MS9vQ2dkMlhMWFdVTHZDM3h6VCtRSGpKMDhQQWpnbExnYzFNUFBDSU1kdkdJ?=
 =?utf-8?B?MUdsVE1wVlA2VVJpSkZTMmR0QU0zRDFNWlhlTHlkRTk3WC9iZ2Q2YXRlM3Nj?=
 =?utf-8?B?UlByZlAzTGpvc2NCUkJ4bEJ6QWMrQ29iLzVzWXFNdi9oTXdBK1pyMXd0OU4v?=
 =?utf-8?B?STFUdGNKcENEWlVrL3EzMU13RTNYZWdiMDArSUVHRWJqT2kreWtiRE9MaVR2?=
 =?utf-8?B?aXlqdHpxTUJLa21PNXRWV1ZSdDBYRGk3WTg0WHg1WWlidzhWTGlQU0lFdkhO?=
 =?utf-8?B?N0tHTndORkw4UUIwa0ZYMUowNUt1VmtvSndVd1VGSmNkRm5vamt3ajRGMXVY?=
 =?utf-8?B?Q0RuM1FLSHZPV1VST1dLSFltM3ZIZGFaRUg0Z2hybWZMSzdJTnpSaWpNWUFT?=
 =?utf-8?B?bFVEajRUclV6cFQyblZROG1iWUFNbmlUNXg5Q3cwaHFqMFZSMFU2dy9yUmxv?=
 =?utf-8?B?ZmlvOUNibDIzdXpuQmJiTlVPK09teE5hVEFzeEhVTnBTaGhwL3JIVUtLY1hL?=
 =?utf-8?B?SGJPbC81d0VNcU9hTmVSRzZzS3k1QXFNTjFlL0IyemZIQU1sN0ZscDJJQnVK?=
 =?utf-8?B?MVlIWWUrZklPc0VtVVF4K1d2NmpQVGMzRlpvZVFIdFlQTi9WN1hGM3lnbWdT?=
 =?utf-8?B?U05ReFNwdEdMRWhrcVY0M2dvb2M5QzhpSlVZWE5UQks3dkRxWWljV0EwcUhx?=
 =?utf-8?B?MnNYWEJwRlhQWksxTVl1Y2ttdXNlMUYyUm9hSmdLdkJWR21MYjViNHYwOW84?=
 =?utf-8?B?WkZkNnRzTmtxa1dLbnlJaVBKK24wU2dMclRMYi9vV2o2N1k1dmExZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015a8cc9-54db-423a-5d80-08df02edb97a
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 21:13:35.4522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5UKlWsrxms7ZjPiv37+QdLzRZnp49frhUSs2CtvPVBuTdB8zdz1s4wCxwhN8tAf8mMTHGenXuNOr3+OykOGog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882
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

On 8/25/26 1:53 PM, Danilo Krummrich wrote:
> On Tue Aug 25, 2026 at 9:13 AM CEST, Alistair Popple wrote:
...>> For example if someone plugs a shiny new card with a different chip_id
>> register layout into a machine running an older kernel they could get an
>> incorrect arch which would be confusing. Users would get upset if for example
>> ShinyNewCard got reported as being Turing say.
> 
> If the kernel can't deal with a chip it should never succeed probing and never
> expose any information to userspace in the first place.

Agreed.

We had also some discussion about this point during the BOOT0/BOOT42
change-over. And we arrived at that same conclusion back then: don't
let PCI probe succeed on an unknown new chip.

> 
> nova-core does enforce this already; if a chipid can't be matched against an
> architecture it won't compile, and if the chipid is not known by nova-core it
> will fail to probe.
> 
> Note that nova-core binds by vendor + class, not specific PCI device IDs, so the
> chipset check is our only gate against unknown hardware.
> 
> If we'd hypothetically remove that gate and just allow trying to probe unknown
> hardware with the boot sequence of just assuming some default with the latest
> supported architecture, it would potentially be an even worse user experience,
> where instead of a clear rejection of the hardware a user might experience
> security/stability issues.
> 
>> So I think it makes sense to keep this decoding in user-space regardless of
>> whether that's exposed via documented opaque chip IDs and lookup tables for
>> arch/implementation or by a commitment to keep the chip ID register layout the
>> same.
> 
> I still don't see much value in letting userspace decode this again, nor do I
> think lookup tables are necessary.
> 
> If the driver succeeds to probe for a device we already did decode things, so
> there's no need for userspace to do it again or know about this.

Also agreed here. It's hard to see any advantage in decoding in both
user space and kernel.

thanks,
-- 
John Hubbard

