Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E3606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jCMrZAE9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B86F10EDCB;
	Mon, 26 Oct 2026 10:46:33 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE6B10EDCB
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrRKLo9rxwaYQMzGgEfxyqXKalRgSr38QONs3MpDlEkdTXFz4KeIVpGvE8aRCdLyY+O4MOhNYvPZcQqPN01m3RpVlb0FCCTQhjRU170g3udAzJk4ofq1Ncs+NHFpg5XRZiJansOPgs98n9FbuIOkRvtmttmYKJ/g46NsCtTIea5uFnPd3JTQFKFdwhY8h+hmMHFkHPSMlg1TMIPEJbag/X0smYOPJmJ8IzPteUhKo006qQgz9mULuYRLKnAaqVycyXsmTnPQdvFtiTI3rPrkOwqpiDLb9xJKU0SGtbrZgF6r2b4scQyBJUvEpcBse0QEow52ChTEwe59eommdw/W/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5UtFe3iQ3jVOlSuFiyJIq6ocLzdpm+IgQ5PhdGzYZk=;
 b=l8y3+RsR7CUYPcdkCi1WHGiwGdWXzCseRg4fREKFwrxJZ+ZUvU9fl/ZL4ApoyBAhAf4fmfox4xt5dECCZbZLXxd0R3gOhbc4NS9pL14EfDOX/a6MxQQPCDpx6hpAHFa2VXGziAEhXknVeBVrTY1Q+NvDLP71ztODq8B5frbE+59ExyrBAi9vs3TvGPRlERooNnOmyo8qG+ZVNtuBuKs8PXVBay1+w/fc8vsDWbGNlgFSLtI1DTGeL38U+3YjYuL+dlOMbmvkkicuZWftzPhlKMvIHklYTnwuZUHc97OIlUnBsRd39ceQDPnbnqgntaK0Z0jkM9fvxyBfYF0+RpIo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5UtFe3iQ3jVOlSuFiyJIq6ocLzdpm+IgQ5PhdGzYZk=;
 b=jCMrZAE9oyXiLD+EjXiXa1zLI9QYCU4ZZHABQAsnmeLMGwC0pN7EkP/fAZS86xMLx2AP0lbtzXs17gz12yYCdV37fUXBo8S8zHVTMlF2Iza9z37EDsMgenJXR4g1+CWpxpLZf8wLsiryS5PDFlN2U1wIB1GgPuocWa/tJTZcuU4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 10:46:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:46:22 +0000
Message-ID: <1a76be29-7c68-47c9-9c76-443a409db151@amd.com>
Date: Mon, 26 Oct 2026 11:46:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/dma-fence: Document why signaled-bit is set early
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261023100047.2589846-3-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261023100047.2589846-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: d8fda0dc-e038-43d1-3c8c-08df334e6046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|261021121427099003|261022075727099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yni1WaQhhLV2uSW+HUfYx6oaikm/pDferSLbgzFv6QtUgdJVdnEigVtpmIb4xHhGyTjLqyiIfbhaNffIYYJpeCi083VYmqM7wVMFnDXX3AWjT0pl4ZQyszU4l1FrN4uGG2A1iAjy2kkb9PuLC8+aICqNqK24nz3Sm4O9apcZtSb49CffKAyTt/SLF8DVN4rWY8DUY5EA2jQv7chTQzJA//BVU0qztphwvFiOnOIpkL+VC0BgcAqK6Hf9EcqPxvip+R6VDBraSaQQAIPzv897Jopbsb7uCLkBYNK8ZHgaMR0VJnQOGTgcQcsnEm4OAzvxGZHK+y9xDbxXJguIvyNgK3RbnzTgZWlknI0ckbcXtvBaaAP9lD+o6ccVb/oEx4zPq4FDvLrSJ/929nTZUqjH4X9sOb/2m3SICo5kihZw8Jmt7LGb0sIBrx4LCaWx4t5x23rqIWW9A1lFJcbnp0t9e2UjIZcD1hXYuWTgHEs6vbR/lyXVFbw+LMZdVvBUsaWHiv3BxrYw4R5cHfSY0ft9NwaAFkbNm5ChTlHrUWBmIt1nXal1kgogiVXLzlg4nf96jOrypeSqKHWhtkAAg5Cq91QxXzTjyz3xRpcOnmU3yI2fm6u/Nip0JSGxLBWGXVreUvGeLc8fo6Uo5+LfYaRWaJ1BOYr7XIjDaNR9glfBHfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWwyczgyZk9UdVByQk5xekJKWDNYVk9KbEJsWWxQRjFBbnRzbkxKNXIxR3A4?=
 =?utf-8?B?USsvQ3dNOEdzQSthZ1hEd3gzWnRBYkNTUGRiZkg1d2ZpNWFJc0liNXE0U2J4?=
 =?utf-8?B?Q0JiVWRneTdWSnhPYzZibUxzNUlKNG9JZXJVZGRkZUVGejlIdTJrQlFYeks4?=
 =?utf-8?B?bkUvUDBsK0lCRDRpWnVZNGVjbGNWNk04QmN2VlcrdE5iamIrTCtFZzBLMHJy?=
 =?utf-8?B?ZzQrekg3Z3RlcnRkQU1GWFRpZDNWUWcycjBJL0FyQ21veGNaWFVKeW1VaDBZ?=
 =?utf-8?B?MUNyZkZGYzVpa2NVcWpXSzEzM3lkck9qU1FNbStEZ0VJWmN3QXdYTUxWU1Nq?=
 =?utf-8?B?UlRWeVNveXM2bStUQ3dKTGQ1Vk5vOTdyajdrS05zekxpdHVKL1hxSmRWcUd3?=
 =?utf-8?B?WFVXQmRpRjhnQkthaXdSODd0Ym44ZjQzM3VBdXZERFRrZFN3dDh1MnBzQVdq?=
 =?utf-8?B?bFk3bmdEakhEUXdIWHZ3VFF2NUxEWWt6dW1QK2xtL1FzSFhmQnRUd0FtYm9Y?=
 =?utf-8?B?OWJRZWVidkJFUWxKWENaM1ZKekhlWEkwUUVzek5IbmxtQ2s1dzdYbGtMcW9m?=
 =?utf-8?B?czRrQTZDSEJIRnVRK3NFK3JrSUJqYUtlZ3pnR1NTdUp2WGJ1N1g1a0NkeGhR?=
 =?utf-8?B?bFRtRVZURDhBL0JYYWwyMkpzbDVxckh5TzRQMEVSdEwxVlAyY2FlZXE5UWNu?=
 =?utf-8?B?UklvVnpHN0pXVGw3bVNHbGNxd0RPTHR2U3F2T0RaM0RIY3ZJSkZsL1BrSjIx?=
 =?utf-8?B?Z0hDaTVpS1h6bytBYTdoeERkd1pqNTd4MnE2dDIxVHlTZ3JnaUtpZFlvUkhI?=
 =?utf-8?B?VUZOM0lHRWJyT3M0amUyamZCcUUzQlViYzVwZkVLSnJja2lOL0J4Qk83V2RE?=
 =?utf-8?B?dUtBSmhRUEppclp0cGozaHV4RFVKb25QKzRlZkxFaFJBZjc0aFB2MURMMVht?=
 =?utf-8?B?ejRrbThJS2ZmanpkQ1dJNFZsOXMzb3NZelNTV016YVBYVkNTandGRVZ1TlVq?=
 =?utf-8?B?WlUyRXFITEJyOENZMDlsdjJzRkFRcU9ONEhPaXVQRVdScnkyc200WVFuTGg2?=
 =?utf-8?B?QWxxcHdmeXhVUVc4bjRhUE9wdHJjTzBiT2Ixaks4QUFKRVN3VVRjMTVleFdI?=
 =?utf-8?B?Qy82dW91OE1DQUFHczl0M3B4ekd2b1lPRGdiR0ZlSHp3SVRUaWR4dzE2dUdw?=
 =?utf-8?B?SlpGdThrSDd2NGNyWkF3aUhLdGVkdWdzNWlEd3JEdm9QbGt6dk5xSHAreHYy?=
 =?utf-8?B?cEE0RTdqTlNvNVlPc3lxb2JZeDJ0aVplZGNWTVNPcXN1SE90U2R4RlpwdlJE?=
 =?utf-8?B?MEpmL3lpbTVIUGVwTk5jODBpL0VlVTZzNWpYNFBDVmtVRHNyS01yTk82K1Rr?=
 =?utf-8?B?enNKZEVoV1dwdVB4SFZJcjRaN2dPeko1QXY0dnRJKzVJa1ZkWTU5VUxmWlpM?=
 =?utf-8?B?L2JFWnhKZTdqWlcrU3g2L20zR0JoZ2NDNjRqczVtWGs0YnNjbmtmWWNSWmNk?=
 =?utf-8?B?VVliMTA4ZERsM2ZncXVwaS9wUE9IZW5lNEZpQzF4YWZKT0phNUJtSS9UejdV?=
 =?utf-8?B?Zm55VTFndTlrTnlWbFJZTFpKTTFFWitJZW5wRE5GOFpWcmFjYTIzS0czemdU?=
 =?utf-8?B?L1diYzZYTEtWcXM3RGVpa2NKVFRrK205dklha1hoYUEzbThCNVZEQVJ6Ykt4?=
 =?utf-8?B?aUhYVzRUQ2VyeVlkVzU4OWhRMlU2ZkJMZjVJRVZaQjY3Sm96bDdCVmt3cXlC?=
 =?utf-8?B?MkFzSlNYb3pVakw0a2dkUUNTSmFmcVFmbHFXWm4rZmIyaUwvb2xod3hzMWdZ?=
 =?utf-8?B?VGpTTWxqczcwU0dRSmN0Nm9KODZlbkNYU2FmSFFtZDQxYWcrWmRFNGV5UHRU?=
 =?utf-8?B?eWJlUmN1bFdXYmNUdTlXN0VFbXVDSHdrbUUrdW14N0pJcGtBcXZDVmVBL0xD?=
 =?utf-8?B?TVpxcW5zMkFhL0dXRWdUOU1SODNQaGlvK1pySUU0U01xQThVV0NENkNPQXEz?=
 =?utf-8?B?K3dMaG9KV1l4UEl4eWRWVVZtbzRkeHhleXV6MGplT2hCczZCQkkyeFliaEJs?=
 =?utf-8?B?VmF5Rld5eUVqVUpweDNtUHFKVllxL1J6UHY1ZmFGb1Y2aWJZVEN1R08vSHhO?=
 =?utf-8?B?bVZaNGo5eWVjOG16YXhyd2RwOFp5eEpVaGpFQ1Y4MW5iOE4reGUwL090Mmtj?=
 =?utf-8?B?NFY1Z0dDL2lWcXRoTW5yUUorbDdJSmxFUHZxdHA2cks3R2h1czhSWk9UdkNm?=
 =?utf-8?B?L0VrS1FINjVZVWRhZHFUeFJiM3daTTBIRVBHTllWTWJVL2huTk54aVcvQWZk?=
 =?utf-8?Q?dd3yUzm5NKfCG1NL07?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fda0dc-e038-43d1-3c8c-08df334e6046
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:46:22.6780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q++CI7Qh+wD8k2rluoCsmCHN2tYRnekbJ7LYPVnZ79ZNQwrMpXJy0kvRajBwOCrU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 12:00, Philipp Stanner wrote:
> There have been repeated discussions about why the signaled-bit is set
> before a fence is actually done signaling. Repeatedly, people try to
> change that.
> 
> As long as the bit can be read locklessly, for example by
> dma_fence_is_signaled(), the bit cannot be set at any other place.
> 
> Document that to reduce further noise about the topic.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> I thought that if people repeatedly try to make a change, and it
> repeatedly gets rejected, then we can all save ourselves time and work
> by quickly documenting it :-)
> 
> This way, we also remember in 5 years *why* something was or wasn't
> done.
> 
> Philipp
> ---
>  drivers/dma-buf/dma-fence.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index bd58688b81a7..a71e18a9e346 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -359,6 +359,16 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>  
>  	dma_fence_assert_held(fence);
>  
> +	/*
> +	 * It would be better to set the bit after the callbacks ran so that the
> +	 * fast-path-check in dma_fence_is_signaled() cannot return true while
> +	 * they are running.
> +	 *
> +	 * That is, however, impossible because many parties now check for the
> +	 * signaled-state of a fence in their callbacks (or in the work_items
> +	 * kicked by them). So we have to keep setting it here as long as the
> +	 * signaled-bit is read locklessly by anyone.
> +	 */
>  	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
>  				      &fence->flags)))
>  		return;
> 
> base-commit: cf5d8e390e2ac2cfa24a50645efdbb9f0eebe65f

