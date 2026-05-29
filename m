Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31782CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 06:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD9F10F9AC;
	Fri, 29 May 2026 06:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gddZHIyO";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA56410F9AC;
 Fri, 29 May 2026 06:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAMcLD+L9q3LDozbAqPlMpes7QhfavL3FXvyhhCRCY7ohxxBOBK0lBUgU1RTjspLEHI2K1X5k41PmUQVGF6O+KoLEmLK9U6TqFTQq6hvs0JzSjC3Yyth7zfe8sg2NsKr5c7ijHA5hRMrxBpjemTkPZzcXDW4llMA0vWzdG6uraOmuE0WrNi6cEYtBmYSTI9E1z4P3QgfETP57MGaYuSBjwHIMiCtk9DPNnB1y3m+GQp+0W+wVRao7ePVdV+uhuXvYMuQWWMf7hPrsXaooa3RRVlnyeqVZ/k0ov9EbWS73mPYp8wmqZXZYpDAphiCw+YJPVAfsGP8j4mDKylHpxE7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w2Q1VC0T4R9C/X8J1bwoq25aYf5MDBeEzSccBJHMp8=;
 b=SrupCj1Nh3LB8SGjPBVRspZbJx05nk2zVFtJsw0xNsvhq2/voAMjFFPSfisg4NgmzHqamQj++awkg53MrPIS8ikdTJ8tMKjkZ7tIbWXlkIXiPdrxIm3y6MFD0fNeQ1kFyI2uRu4xE3ikDYby7bHyIKVTMNbII8ZICSDmXAW2xgVt4cHpwkZDENsRfY67tnZ//FXCXD706IMRHKBlPZpzkD6qzP5nk6BuT5UCObuZ/5uNAz24nJ4s/XyX3uf1QHeWzTBJG6wifS9AuOQx8Jhd7MZkEcKm+OQDRWb9epqpDWY9gpuExMoENt5+j2FsbLP71dCdKI7eOI/5HscQoKCMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w2Q1VC0T4R9C/X8J1bwoq25aYf5MDBeEzSccBJHMp8=;
 b=gddZHIyOoHf/0TReLQDtdyTeaoQ/iPS64g7JWzR2Ber4+JbnjMWCF2525xS7GeT7uqWxRqL8p6+2PG8Di3XGPOZ9lagAWql4906rvcoauuvtLDM9KE3N5k0qVaK8xfluhMZRjVBibS86VUq+w0cIEmgX6mt07cpDSPwpaSnqrLGZt5Mi1RPPQ4LulygcBn4BWRBiNxCnhm/0Dd+IWNMJ0w9GborHFhb0olZoVTIL0B/JRoyRYX/ZnKTM6hAsTROwH3SvXHZogHBcqL4oT423tmyvSQIWwnL2e9wkGX+IKXI8dRek2xoVCUJ1amB0KyB6W0jSF5RIIbPm1q4dZ8zrlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:57:46 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 06:57:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 15:57:42 +0900
Message-Id: <DIUYRD4ZZSKX.QMNH7VQKBDM1@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v6 7/7] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
 <20260521-nova-unload-v6-7-65f581c812c9@nvidia.com>
 <DIP0EROV7VSK.1WYD6SKNI05UD@nvidia.com>
 <DITIJ7IIAK7L.2PKIBC52OS7AG@nvidia.com>
 <DITXLUSX8J8Q.3OXYXGUBILQB2@nvidia.com>
In-Reply-To: <DITXLUSX8J8Q.3OXYXGUBILQB2@nvidia.com>
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: f1be384b-f9ff-4b82-0c42-08debd4f96af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|11063799006|3023799007|6133799003|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: Ndi5tr984rdiheT2PVc+7OkyGu/axi2fkrx0rwcfqDzOeTFtRRhqvP8Mfw8Z8ncYxgGSpbX5+W+63vRnsf5VKTLnKB0eT1scOUdZei4K20sCXcf5NZHYd7+sZ+txl2oWS2ARS6nxfqB/5Mn2kANweiVIlhghnfAMJ6Ih3D5Npmjf2r0BJkQIak3bl2Fb/R6gh3FuR9iBEp5W5qctXfswuZhW+6AdxhPYMdThgkdLA0C8SdDuK/KancAf9w2LEMlZW8Nd9aXDlQlUbchTO+MpELBBh22jnfkrCjcpAaT6iSli4zVk/zL8/UAKUJ5gt+K1nkjsGwN+OFbnZPeLIBt4GmE/3IFfTvpBv9PB80arK5ewYlucBw5AwuErr1nRRidIi9LgOYEqeMxRMjbvKBj/BbU477eLl+FyL+auA0kuTqMknJPSz9/Tf26Kktj6/VnkYPMHijfNHOR1zXhovsD1D0eYTtyhEHshFGLiEDiAtOoqjSJiKv5fNgbXO+T8yu/JVJ47QNjOjU9fqm5KSjjPWk9bdn9gSiaQ/6nC4e5rs6NIaHlLM9RPzr9sr2LCpZfjyKjorI2TWSFaUZYZ0/bXdDrIDGuNBoV1hs6FjwcTlscW+B4OuASKbqJZzgiVgNRmErkLPAirfPqOMRzl3sBvN8G0SnHveRR0oHxw0wQhnbkRCT585p+aQzP/7c168ae6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(11063799006)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC92SnFRNDFLUjdCeGZNRVlmRFlqeXJTdFQ1dkRKL2x6KzZYWTU4SVVycUtt?=
 =?utf-8?B?aUlxdTd1UDBTNUpKSlNvSVhxaG5FOCszR2ZVUG1ZK09LTXVrTUFMbUp4K0wr?=
 =?utf-8?B?ZVBBNzBZbmNzcTlQUmFhdjBqYmc5NTV2aGRFTkNHZkxMRFlwTGtmMzZZdStH?=
 =?utf-8?B?KzlnWk1xbVdCeVBtY1JSK00wLzFXazI2djExK1NWakdPaGNmNytpcXAyTkt2?=
 =?utf-8?B?VS9NR3VZTDA0YnIyN1B1cWtER3hIN3Q1bEZFei8rck1WSXJ3dFJrN0tTa2RG?=
 =?utf-8?B?UVJaUFV0d3FhaUJxSlFma1IyQlZNbTd4T3dlN3FjRDBmWWlEM2wram9VU3Z3?=
 =?utf-8?B?bVphbGJGd1NaZ1pyTXZTbXFORlRTMVVTcEJ4cVhldDh6OS9ZZUtZWSsySm1V?=
 =?utf-8?B?SGxIanFIUElaUjNTUVlFdm5QNElKYnZFcFN6VzhUb1ZxajBYMmMzL3RoaEQ2?=
 =?utf-8?B?NVlnaFBoL0Z0OTM1NUoyUHBodGl5OXpNT2M5UDJ3K081bmF6SmR6bG9yb0dL?=
 =?utf-8?B?a29raUl3RXkydnFyQVR3MzlvSUlmbWliS3BZYzcya2oxUjJEaVR1STltOVlj?=
 =?utf-8?B?Um5XYWdKMmZEYmh3UTlRSEJaRzJTeWFXUDVSZE9PTndwVEplZWhxY2JKeTVK?=
 =?utf-8?B?SllFZkQ2QVZpVHcxOXNMc1pkR0xUellVb1UyL0pnK1o5SDNLTGxlcFZyWXAv?=
 =?utf-8?B?TEYveUMrVmhUNitiaTZXcDMyYmNvTi9aYy9yYk1QMGdTZElxakRqQVUrV04x?=
 =?utf-8?B?S1RuM1VaQS8vOXFVT2NBQzhEeVhtUkJ6aG9aejE2U0h0NGRwZHo2WkdueFdm?=
 =?utf-8?B?RVI0blUrSEY4WW56VDFQOFRyYkZUeEpjVXc3VER4dld1a2JzckswcnZpQmFR?=
 =?utf-8?B?czRBTzhtb2hOOFBsUmFWK0hmVVNSRXg1R1l0a1FacnN3MU54eVhoYWY0ck5z?=
 =?utf-8?B?dzBYSnNKSFNvZXlVV3hGcHI1cmFDVGtQKzFaWHgzWGF4WTRXZ3pZUmg4N3Vi?=
 =?utf-8?B?WnNsNVhSRzhWVVYxR0MwVmRKaTBJNk1FUGlFWFNxZnAxbThCSERtdlhSK2lV?=
 =?utf-8?B?UFI1b2E1TGtPY003NXpISGZpMWovb0ZhbytlaUlsOG9zU3Ztem82MTFwZXdm?=
 =?utf-8?B?aG04Mm1MU1pXVVpPaVhxRzI1QzZVN2tKMlBQNFA0M3dVRG4vWE1jbmxLWStm?=
 =?utf-8?B?eEtzYUdMaXRTaEhzM2E4WHVTcnRpclpsMHArQlFPZVVnZG9qREJaVXRaWTNn?=
 =?utf-8?B?SEtBYkRIVmNPVkQ3aitqN2p5NUNOcmxKNi96QmxoWFpvQ1hOV0JLUEJzTlBs?=
 =?utf-8?B?aWxIc3hvQW41UTdudGZ6WlFOS0FUdXBQM1VZTFUzcWVXWURab2lJSWd3NTdT?=
 =?utf-8?B?TE5FNXlSaUhRY0ZRYlQ1Z0tWcFhEakdqbVp2RDdzbWw1ek1IbU02cDhJam56?=
 =?utf-8?B?U1NMN1NoaVloNHlmNnphUC85TVdmRFdFeWNtUHY3N3FaYkR1cFBKY2x5UFFI?=
 =?utf-8?B?ck0wUkpUYmRlcnM1VnFaZVllcFV2bFhXc2xob2c0RDhnUjh4OVBSS2RmdkYz?=
 =?utf-8?B?NFJZaHRwaXYwbTErMWJEaGxDL0xTU3I0S1h5aEdNSE9uMTdwY3VJUXk3Z2RV?=
 =?utf-8?B?NG1ZVE5MTVAvTmxaRWYyOWtXYkF5TWduenY1MngwTjdXSGU0TXhVKzFpSm1Q?=
 =?utf-8?B?amhpeW16NGFOMVIwOHBoOFhFL3JvL2g1aVpqU0dhOFBZbktFaWdmbmduV2g4?=
 =?utf-8?B?akowakdwSDhIUnV5TlhEWk0yN1JQdWtRbXVIYnUrbENucG1pZWNvOUNlZ1dT?=
 =?utf-8?B?ZXZqbTBTQlJtNklNdUpGM3NYNjVXS09NSTcvdDlGeG9CWmVlb3doeFB2SURw?=
 =?utf-8?B?ZWkvZjd0ekNzN1htQXNOaEY3UEY5dWEzOU8vY2ZyeFpRYmJwM1d6bk9KZDNC?=
 =?utf-8?B?Z3U5Ui9RWW5lSjdSaEwyVFB0SHA4R21uNTdCaklYc2lmRTFDR28rRWxrYWlJ?=
 =?utf-8?B?RFpzRjZLV1pjTlcwNUMvQmw5cjU1K0UvZVNqVnNPTkp5c1FWOHoxanRJUXZz?=
 =?utf-8?B?Smtaa0Y3cG5CRDY1OFkrUTZiSEdkUmQ5bk1KQWk5UmhrRTlzb3l5YlFtZmhL?=
 =?utf-8?B?VkhDZ0ZEY0Q0WFIycld0cGhuR0ZaVWtLeURyZG1zRi9qWWJUUzFzdmE1Qm1V?=
 =?utf-8?B?c0NTS2tWNVJnNkJ1MVVUN0M5U3VNaWx1QW5jeG5YdnI4cStHeWtKTTJOZGx2?=
 =?utf-8?B?SUdiQmN1dXNwdGUyTzQyUCt6dmN0VTIyU2l6TDBvOE9XL0QvbmtNNU9TN3l3?=
 =?utf-8?B?SnVqR1BoYXkrOXF5VXZnQ0NzZEJra2l1MkV3SDRML0l1eWoyYmJOMHZOK20r?=
 =?utf-8?Q?voOEd7+Ewup3PipcPVseafNQnj32MPXJTxEFzwVbq99Ge?=
X-MS-Exchange-AntiSpam-MessageData-1: JoBOQfxGN9E3cg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1be384b-f9ff-4b82-0c42-08debd4f96af
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:57:46.3808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKlMR7B9Ifly5QISk3NnpRYdKbQ8LgGEZZj+ut5iKpyGaradb/CWdWF+cveah7Gaz0CtnW/UXmOu7R2yOp5opw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265
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

On Thu May 28, 2026 at 10:50 AM JST, Eliot Courtney wrote:
> On Wed May 27, 2026 at 11:02 PM JST, Alexandre Courbot wrote:
>> On Fri May 22, 2026 at 3:59 PM JST, Eliot Courtney wrote:
>>> On Thu May 21, 2026 at 10:50 PM JST, Alexandre Courbot wrote:
>>>> When probing the driver, the FWSEC-FRTS firmware creates a WPR2 secure
>>>> memory region to store the GSP firmware, and the Booter Loader loads a=
nd
>>>> starts that firmware into the GSP, making it run in RISC-V mode.
>>>>
>>>> These operations need to be reverted upon unloading, particularly the
>>>> WPR2 secure region creation, as its presence prevents the driver from
>>>> subsequently probing.
>>>>
>>>> Thus, prepare the Booter Unloader and FWSEC-SB firmwares when booting
>>>> the GSP, so they can be executed at unbind time to put the GPU into a
>>>> state where it can be probed again.
>>>>
>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>> ---
>>>
>>> After seeing the bundle moved outwards, I realised that it has the same
>>> issue that SysmemFlush does, i.e. if probe fails it does not reset the
>>> GSP. A lot of the time during development I will break things badly
>>> enough that probe fails, so it would be nice if this is supported. OTOH=
,
>>> this gets the probe suceed and unload case working which is important
>>> and this is a definite improvement, so for this version and the previou=
s
>>> version of the patch:
>>>
>>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>>>
>>> I also had a brief go at making this work on Drop, here is the diff on
>>> top of this series. I can send this as a follow up if you would like
>>> after cleaning it up, or lmk wdyt:
>>
>> This is clearly better. It guarantees that the unload sequence is run
>> when the `Gpu` is dropped, while preserving its one-shot nature. Also,
>> no `Cell` and no awkward output parameter to `Gpu::new`.
>>
>> The only blind spot remaining would be to also cover the case where a
>> failure occurs during `Gsp::boot`, but that's for `Gsp::boot` to handle
>> itself imho.
>>
>> Would you be ok if I folded this into this patch for v7, with your
>> `Co-developed-by` and `Signed-off-by`? Then I'll also try to tackle the
>> `Gsp::boot` failure scenario using a drop wrapper or something similar.
>
> Yerp that is fine of course. For Gsp::boot it should handle unwinding if
> there is a failure but I agree it is orthogonal to this case, so
> addressing in a follow-up SGTM.

I will add a patch that takes care of that using a drop guard in v7.

While doing so, I noticed that with the current state of the code we
could also perfectly store that drop guard into `Gpu` itself, and get
the behavior we want without implementing `PinnedDrop`. However, this is
only possible because `Falcon::run` and `Falcon::load` do not take
mutable references, which they should do eventually for soundness - once
we do the switch, storing the drop guard won't be possible anymore as
that would mean keeping mutable references for the full life of the GPU.
So `PinnedDrop` is necessary.

I mention this here preemptively lest it is raised in v7. :)
