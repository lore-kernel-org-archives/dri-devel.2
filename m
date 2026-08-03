Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A34DC5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A6AA10E61D;
	Mon,  3 Aug 2026 12:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YXriw5Kf";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012004.outbound.protection.outlook.com
 [40.107.200.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0AE10E03C
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 12:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUTRgX+n8zFuSQHMVDFrB+PngMuz4NZUyGv+3PHc6z1fYTSISH4ANR2bGA14tG2mZPGcA4uKpNqH1r0togWIUn7l5VOVssIOtXmbHcMRDwCg1ErmcV0mJ7hgF2R4xeg2aaK1EPMz68VoJwqdAQFDmF15cpl1Tlxp83rGYdIL3rN2GOQ+ziQifkHB3VfPtnPGCYTyoUKwcaIquZS0z6lp14dAS7bJn/X/hbLmvkhK2WbM7no/z3y7UfGbClvAvqmunZngs4Bk0yDcSzg+FAdnIGMR5ZJJRnh1GyIJFX7kw+gT2vzvVoDL6LsZwrLvM9Up74PQ8SoWPJxF+kBXNF8SgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG0DhMEhsPeVA03HUBYf1GPPERkT39nbO8S0cTGkXQ0=;
 b=J0nOgsgY2bdHopQtlZD2u/Ch/MX5V1fwDiD3tV0rOTohOEuwnhuEj6VVrTOuD6W/ENSlSt4pWBnId3IRrxNEf0XtpsPR7v89kqksBPulkiJ1qGb41Fl/JfVvIGLYvUgZOWps0w4AENINaeDBgcT65NbOr2DjW1KWVTXayVkdUd1Z5lGiMvzoTFVY9H4RsW4psAXHgOdItPUR65YQQWAn2P+zrZlD+0KZzWWnum65bhXCG1qPhVzIFggfZCknD9sb5K8xNVwe+v+IYvbuUYrZaIyw+8sccNcGdJB/Gv32MU+3USFyAGl4hBLFvYlkIWByY7JSw7eEn2BUgq4nAnNGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG0DhMEhsPeVA03HUBYf1GPPERkT39nbO8S0cTGkXQ0=;
 b=YXriw5Kf/WTdMQHEuUWoT8GBmjkZokHtBHO9EiBhFYCOCOaH0RDMF66hqwcBhALETGm8ILMB/MNeV82GdxCMyAoHs0q9Pz5jU+w4yqrCEfq/CEagIxJjYSfBZzVs6RSfhoHQ5RaacM5KOTvueZ0exz8VfoTIgbGNamx7lD1RZvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Mon, 3 Aug
 2026 12:55:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 12:55:50 +0000
Message-ID: <c9f42173-4ad8-4818-890b-7b0a47c6c6c4@amd.com>
Date: Mon, 3 Aug 2026 14:55:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the mm-unstable tree with the
 drm-misc-fixes tree
To: Matthew Brost <matthew.brost@intel.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Mark Brown <broonie@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org
References: <al4jGBGNG_QACaNL@sirena.org.uk> <20260720144141.GA16699@lst.de>
 <al40qCMTxhEP3Kx8@casper.infradead.org>
 <al6cVnNv2TuhuiV3@gsse-cloud1.jf.intel.com>
 <al+kiyFVgrulSneA@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <al+kiyFVgrulSneA@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 39251f17-5608-4acb-1fad-08def15e8b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4jvctMv0chgknXckk5gXCcRxNI+ii7+pqVAuThTbUF9Ol9/QKmjU2TzFlFrMwFMwYbKKsRX52nj0e7HW/8S0dC0c9KkAObzR9PstZDAL/tZJAW40Ad9Qi76mfyY7ywsLzDvOCRzPJLof6gpnyutsXbG4jaGfx/NrpApa9bKsOkyv0bsePGUjVZ1RxYgCq2jdu6R1TtRkFE7U1V8DdFqJLC6+q3etHPSmtOzS41GQbrvxlejh0SebI7S3LxWj4lZt1b0AUzNHnA+gxHeJFAgRXQ7vQsaI4FgmtIYCHUYT070DNODmAvFfhBOHXArVEwPRZoy9V0MnjEvEBcUg9fcCfTHLHBtvIRiO+Na+LfXfv44qHB4nR1tFY8VcCGHOcRjJDS9+P6O1N9HhLVKNyug/vHKn7Uq1nXG87tftBQNku04ucMoyaAKM4YU/2tMYWNbjKaYU830i52xQww9eohEqOCzuCHM4gEtpmssHy/yRvLBhSanLi0qILhrnOHKUQgXC9BdZFMhaGLpUuoN2adozVzKYXfwyvyrYYbC8NJ8PNpZ+91yRvFqgGlFHHBO69APd9QzWpoDD5MtBXhwp4TAYyOriGX3EYjxV8tliUiWClxDNmQ0rM6SIYrUoHRp+Umuciih3j/OR1s0O+6hqAWlhCtHUEgmjWV3ZxRaYe+OO7sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWN4d09lRkNzWnN6aXRVem15VEtqSEgydVl1bFI2YmpCTzNzNFloOHJJSHRv?=
 =?utf-8?B?VGFHQjZOcWFGbnVDR2xCTlFkdmU4QUU3QzJnNmhFWmh5NklmVjV3aFdhZFVL?=
 =?utf-8?B?bG5Nd0x5VXdkQVcxWS9OZ0NDL3dqWE0zVW5MaFl4T2RHSkQ3ZzExTUk4VHNW?=
 =?utf-8?B?MFVDY3k0MjQwa3FrUTdadDJZVUxWOWVXRTZpZ3ZHZll2dzhFWUp5b3lGaXRK?=
 =?utf-8?B?Z0YyQWR0dUozckxHUXF3S3NjWEQ1eW9KbURhdzMxbEFsMmZ3U09CQUhhc0Rm?=
 =?utf-8?B?Zis4eHJZMWdCUkFTRVh5c0N0VU5KY1JudU1CQnhKR3RkRk11SVJXYTc3UXkz?=
 =?utf-8?B?b212T1E5NFovSVUrcFVXV0oxSTExSGVKVG9XM2pBclNJU056dGpsYXVBZmhs?=
 =?utf-8?B?WTFub1p2a0lKdnV4L1dsc2owazdsdHJEYWZtQmtZWHZiK2pJbVpNczFMeEV0?=
 =?utf-8?B?bjA3WFp6WlNOSitpdnNncDZWeVBlUThTUk5SZHVyYXlEcWZLT3Uzemk5NGNa?=
 =?utf-8?B?Nyt2ZjhGTkFwS09ZOEFhVklkaXBsUFlaZHg4aW54ZGdLbms2dEF3TXN1TFFV?=
 =?utf-8?B?aHgzcUpTbStoekVFdzEzYytSNjZIRTRmMmNFWWVOUWk2OFR4cjI4dHJnaEEx?=
 =?utf-8?B?d0JLdXMzNStxMW5SMHExTUU4Z0dxcFhCYTBCZERMRTQxWU04YlZtdlh0aThD?=
 =?utf-8?B?Q2RUY3d6UHo3SGVXTWNZemlPeFkzVFFidnkzcmQ0WkVCNzJMa3ZuRWUwQ00r?=
 =?utf-8?B?aG9pa21hZlVSV2FtRXVOTzRKS3FIVzJ0elhRNzk4ekxBRE1kMWs0RTN6aGUy?=
 =?utf-8?B?US8ySXhGY0NqTUFnMzdLNmFsMlpzejQzOFpWbWhiSFVhWk0rdTMwVGxRdXpS?=
 =?utf-8?B?SWVXaFJOT05PZllXMGdoYjhPS2hqU2JvTXExOXVVNXhMcEIxVis4Ti9mblFG?=
 =?utf-8?B?Z29pSFdLOHo3TjBoWVV2SFpGU2hQQUJvUTJTdTQvV0JKd0VHNExWR0Rxc0dh?=
 =?utf-8?B?QWl4VDNUei9TTHkxejFDWHJNUmFiK3pQQnFwRFVubXcyWFVUMG1wWmVkSmM2?=
 =?utf-8?B?LzhORGw5WGllTmUrZXBraWtQSFY0cVJ4SUZqL05vSzJuUkJZYlpWS3ZqLzkv?=
 =?utf-8?B?RHVZWnpENHpqdWc0V3JselNIQ3NhbWtrS200VG9mYktHcXdqVHFsSTkvTUZS?=
 =?utf-8?B?ZEh2U0V5ZDBodHNmWkFzQkRweXF0ZEJkaHpnSnpYSi9UQitIYThBTnRmMllK?=
 =?utf-8?B?UER1dGtUR1NNREJXUVd3M2dkVW8rNHFqV0VUQ2pvNUYwc1haZHpZQ20rVklJ?=
 =?utf-8?B?anU1NmRWSFZHcjJLZDZRY1BSSEUzSVhuRVhYaTlaY0pxTWdTNzZmbTlXMzBk?=
 =?utf-8?B?dEVUcHJyTmx6WUwwcjdSeTNkMm50SFVQa3cvbGMyZHFUR01aTkgrZ0NHbWNE?=
 =?utf-8?B?dDc5TFFGTjhvem9CU21LaEpwZ0ZxZUg0OHBmWDEvc3hIVUpZSnovRTRvS2VE?=
 =?utf-8?B?VjRtQWRIT2l2U1Q4Y1p3VmM4cXhGam5VRUcxOUdpMHREOFh0MkxodW1aMXRp?=
 =?utf-8?B?SjQxUG43SnNXb3RrVGVKdzZjUE5rWDJWUjJtVWd4RG9oWTMzbFI2L0VCeXh5?=
 =?utf-8?B?dm1jQ0lMY1JDZkJvWkdHVEtOdFlvL2J4bVlQZ09hOHFQSTA0TDc0Y2dEZ2FV?=
 =?utf-8?B?Q3BEb3FxZEttQUIzQkhTTW1rQjA2T1plb2VrR1lxdjhOYUhnand2cVBiaTNP?=
 =?utf-8?B?YWVDQlRrOGRGMGdFWlNmYksrMHluQ0lyOS9TdVJHMkZKUnlTS1M1dit1U3d2?=
 =?utf-8?B?ZlFKQys5MStLeFlmZWRSd09vN09kTmxjZWhaTmV2alBqckgzcmw4U1AySnN5?=
 =?utf-8?B?VjYyUFYyYjArRW1aMTJQMHM5NitNc0FwVDl5aUwwVENqbEU2Y0srWnI3UGFX?=
 =?utf-8?B?bzlrdCtsUEtxNG1SUWRNSlkrOFVHQklFcEhhM3NEVGtIR29xb01JdmpKb3lh?=
 =?utf-8?B?UUROSVE2M0Z3VHpsajMyWDVaOUp3eW5xMDloekJubWNwZHFPczBEYjBMTVUz?=
 =?utf-8?B?L3owSVl1a2NLc2JvczZlTlRwVHhReGFlTHVHYXMrY3VBNGR2bURqd01mRTE4?=
 =?utf-8?B?UG1KdnJkMFBtU2FrNGpMVVExNWgzb2pIcUpZZkRYUDJRZWl2TG1KeEFUZmJa?=
 =?utf-8?B?dVh6VEJ0VW9YdDR2ZktYU3RmMVllSzY1S2tiQ1JkS3Q5eVlyOHZRTnlwN0Fh?=
 =?utf-8?B?a0p2WUREczUwYmxHSlNlMUw2SWsvTVA1ZWZtb3dLNTFrUU5oM2RuN2F4TFdN?=
 =?utf-8?Q?qf5z+VAA13FzRzkASs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39251f17-5608-4acb-1fad-08def15e8b52
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:55:50.1176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/DmMbsFzDdrqC3ViZoo8na+b0n+dHT73gtyyGM1JFyb71CrLPMFOURnPu0OZ5QE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891
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

On 7/21/26 18:55, Matthew Brost wrote:
> On Mon, Jul 20, 2026 at 03:08:22PM -0700, Matthew Brost wrote:
>> On Mon, Jul 20, 2026 at 03:46:00PM +0100, Matthew Wilcox wrote:
>>> On Mon, Jul 20, 2026 at 04:41:41PM +0200, Christoph Hellwig wrote:
>>>>>   /**
>>>>>  - * ttm_backup_backup_page() - Backup a page
>>>>>  + * ttm_backup_backup_folio() - Backup a folio
>>>>>    * @backup: The struct backup pointer to use.
>>>>>  - * @page: The page to back up.
>>>>>  - * @writeback: Whether to perform immediate writeback of the page.
>>>>>  + * @folio: The folio to back up.
>>>>>  + * @order: The allocation order of @folio.  Since TTM allocates higher-order
>>>>>  + *         pages without __GFP_COMP, folio_nr_pages(@folio) would always
>>>>>  + *         return 1; the caller must pass the true order explicitly.
>>>
>>> Wait, what?  This is just broken.  TTM should change to allocate using
>>> GFP_COMP.  Why can't graphics people ask questions before writing stupid
>>> patches?
>>>
>>
>> To be honest, I have no idea why TTM doesn't set GFP_COMP. This
>> predates my work in graphics by nearly a decade.

Oh, that is a rather long (and sad) story.

TTM (or GFX HW in general) has the requirement that a page once allocated as huge page must stay a huge page as long as it exists, in other words a page split is not possible.

This is not a problem per see because in theory there should never be a page split required for such allocations because we map everything into userspace using VM_PFNMAP and vmf_insert_pfn_prot(), so the special bit is set we don't have any direct I/O, swapping.....

>>
>> I found the following comment in TTM, which was added in this patch:
>> `git format-patch -1 bf9eee249ac20`
>>
>> As far as I can tell, setting GFP_COMP would make things a lot easier in
>> a number of places.
>>
>> Christian, who maintains TTM, is out for a couple of weeks, but this is
>> something we should probably take a closer look at.
>>
> 
> I have looked into this a bit, changing TTM over to allocations with
> GFP_COMP seems pretty straight forward. I have local patches that are
> working with my driver (Xe), will post something shortly.

Well it should work in TTM. The issue was (is?) that we had multiple other components in the kernel who got that completely wrong.

Especially KVM tried to grab a page reference from walking the page tables, ignoring the special bit in the PTE and then just incrementing the page reference from 0->1 and then later doing a put_page() into the middle of a huge page allocation.

Long story short that already resulted in multiple CVEs.

So yeah in theory we could use GFP_COMP here, but we need to make sure that this doesn't break anywhere else.

Regards,
Christian.

> 
> Matt
> 
>> Sorry for sending a stupid patch.
>>
>> Matt

