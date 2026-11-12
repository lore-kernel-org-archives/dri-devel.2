Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22E606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2uWE8zM4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8322B10FF7C;
	Thu, 12 Nov 2026 09:36:01 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D232610FF8D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtApe24p04kPirLr96sc0jrhqF461gj5xqAmMhAsh2v3RMDAB7l2vb568KUTGHItpqqlcoW03a6J5zM289vnfOxuv9hX82hnHuWlCUI23IV9x2RAFUW8mLcCXR4V+Y6RHGUXl177QtiEQURJ+nn/pkwP8+APuwJN7qDTLFSyrK68WYgJlrdId8Q+dszVhTq9Y13GTkJQe2fh7lC3bCHwYtQ22xzm4OPgYGH+/SwarnduT7YcDHesj+iDxuaKhpTA8P9Qa5KXVW8GgOm66OhvvNPTWAnFEWdZWqwWJmCPjnPz2YVxUz+nxordRNjiV6sm5xlnUANI8fO4WntkcAAqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jX79YH8ZMFTcmxiD9fK2n3rXH2eSz5N1lvew7717HVo=;
 b=BggisyA8sCZMK3ABYWAu47RPVaufWt59EflM6qs3AiucFboQVDfKnvRwst3IGRuq8E7zTVvHdj12sYtXAozJAQ8ZzgdmwUoWNa4QgXN5oUlewuFu80TnrTumW+5JJSEXc7loORm/9kTeZRu77ylVxogu8DUcr//iJ/cncqqtunIfIlUkYRaw0krckWR9yxL4BxTKDZ3ZvHUMAJXsRNK65xKzpJb8APJwjYxYiVOBmT+TYNusvgesgT8nQjfrELIZM9qtyVEVslRPnVf5/sCeJAsQJB7UPZSvtLdpshdlK3knvH77zdrNUMh4aBwy6gdKn8shAEucMHb+CY1+fW9oxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jX79YH8ZMFTcmxiD9fK2n3rXH2eSz5N1lvew7717HVo=;
 b=2uWE8zM4kSVXCLJmPDygXC2mpaGic1wGxD48nuQ1Q5xsAg8LSBUclM24d2MEmTqcvwOdQtCKgv2A1o4qD8UgFQeihrMyP8ijXs5VeOcPL6QD1mtgRdX33Mw2V2WHW9+hXAYPIzacLuq1VPSIFg5dGys60nC2zWv3+CY03A6f+Ys=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 09:35:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 09:35:52 +0000
Message-ID: <70c7192e-b9e7-4b06-9d78-38e9de85f486@amd.com>
Date: Thu, 12 Nov 2026 10:35:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] selftests/bpf: Test that a drained dmabuf iterator
 keeps returning NULL
To: "T.J. Mercier" <tjmercier@google.com>, k.chen@smail.nju.edu.cn,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, shuah@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 sumit.semwal@linaro.org, phasta@kernel.org, tj@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
 <20261111195942.1283060-1-tjmercier@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261111195942.1283060-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: b15e7eb1-d7df-41db-b549-08df40a05789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|6133799003|261009223027099003|56012099006|4143699003|11063799006|261028144727099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: sQ3+rfV++2qPefenNJslLJ5OPD9o5Kpy2Qj9nAks2Tg8xB4tN/HGjFwiUghUulgYIWgKwjRcwdt3SHSHLl7FOzn3HvPEbRneP4QPxNypd2YIugfqIClt8+TZgZxf0bLvlp3uuLeYf0bfBi3/9k6qT0pXBwcVap/i4MnhioZBk8MvYwlGH2325Wdl5Srn/3DAgoisp1NJq6Zrb9JBpCyWHtZYWSC/VMnh98XApYedb73RfCKWGew/PeCIKscMM6F6h/gVVlC9MLqa6m8fyLZ6RfPVVC5hJQSX6rqLSTrqd4j+xNtq3QuuV1dGBxIB9ZtkRYfMQFezDp+mSV+g69RlmGKQVpIBRA3WrpODK+pfOW7noMnNs9OKK7wbLjT3PVZN429UQncoeAWspCCHzlXxN/xn7uGJFQ0shGhTbSIujjTSfdLjLdeNx+2nrrOcLQcJuSc6MBEBsxQm4/+JZwXQyDLvPkCaWbDZ6He0D38VtZOiswDSGkptqGnD1VJjjFtrQaQ2GDkkkKRl+HEef2yLMJ1xNfKjGcnKWs0IdaLjMzCf++VVFZNOjTgnqzwje8R5Tuqj0WUm9o/S3dxrWrcdgh53BQHRVQzgFiHmVrQKRm6eBRFeLBiadJX7VwvCtFB/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDJLRFdPc1N5a29Qb1ZFdk1Fd0dNNXVFVDFkQmVmQ3ltd2lrdmhsSEV3MHhS?=
 =?utf-8?B?a2NNR3R1Q1dpQWdGQlRQb3cxRVAxZ1dyZEFGWGQyOXViNGZxclVKa2pjT21L?=
 =?utf-8?B?UWxOQkdzVkZqaWp0eVRwdHhyRXRTWitaL1V3SFpzTytwMjJOS2x6ZHk4cTdu?=
 =?utf-8?B?RmNkeTl2dnNjREVFV0t1NUsvWlRBZHlHRUdwWVVnQTQzR3ArMWdwQXNpSmRJ?=
 =?utf-8?B?NmRiNDRCVGt3LytlM09lWUhpTXhTdUw2eDFNL09PY2IwWTFBN1c2ZFdIRURk?=
 =?utf-8?B?Slh6Rmpxem92N0x3TmlOdC9jNFlsbFpjRWIyd0hkcVJlUG1xNE8yMXlWbGMv?=
 =?utf-8?B?Z0MzeTF0dlRYQWxDSTg3N2xRR0JDRDRDdHY2ajZiT0dNT25neDZzS2JSM2xx?=
 =?utf-8?B?a1A0azMxYmhXOVZnZGxRQzdzYVFKL0Z4UXp1R3BLeHl1d0JUSmorUjN2ZmFp?=
 =?utf-8?B?Y3M2dnIxbktFekNMcVdOK3NuWThHcm5jNE1WSjZGRlJDTG5zWUhNM2l3MDJj?=
 =?utf-8?B?SHEwNWhjYVBUZENTRUN2ck1RTTlHc25PcmU1aDVVZXczTmk2Zlg3eGxEanZU?=
 =?utf-8?B?RHFnZk5nS3p3b3hhOFlQdU9jNS9aTXJIOTFqWTJRS0N2NEVVR2c3aDRSck9h?=
 =?utf-8?B?SGptWUVUWGJEVjR6REZHTGRNbnloM2RCNGlTSERyUlhPWlVwVW4rV1RCb1Jk?=
 =?utf-8?B?b0NSZGk1NmFFcm9mSGtMK0dHcG5tUmI4SEpPaXhIN0dxN0JLUHErSjU1QTh3?=
 =?utf-8?B?ejZ6alJUZlEzT3UyWlpyTUpKd1N1UzRTQVVsWjFoMSt3TVIxZHVYT1N4QU9h?=
 =?utf-8?B?a3RlbHB1NGdsMnUwcDVvVnFUR3d3a0FwaitXckw2c1VmNUxISFdqN20vQU1o?=
 =?utf-8?B?YVZaTmRiQjczem9KSDQ2VmRaZE9wL004TjVsV1ozQlNiZDZJS2w0RzltTUpx?=
 =?utf-8?B?aHRFMTcxMHYyejdTM3ppcHJKOERycVl2ZWI4WFB0SXExam0wQWFJVHlkSnJk?=
 =?utf-8?B?MXJqbE5GUXFDRm9La3FDZW1CODlRK2l0TlhJOWFtWnRXYUdHMkMxbjZUVU9G?=
 =?utf-8?B?QmdXdXhRK2VmbkpPNWJITlVLRGN1TXlVVHhYelZxd1BtS3Z4RDNiUmNPenh6?=
 =?utf-8?B?WWVCdys1UUlDQ1Y4dHNRVnBNYWxZMldXMkxvRy90TllsUG8yclpyaW40WDZE?=
 =?utf-8?B?SXpoNitYMzF4MmlEL3lDaU9qNEVldFpRbEhob01WRENhcFYyTldmUyttSlQv?=
 =?utf-8?B?NStoaXFmK3Nua1haVUNzc2VlTW9zN0h6TnJMVm5Zb1hSWm96K0NvWmpxZ3Zu?=
 =?utf-8?B?OXV5QVBwNG1KVkZ4NHdBSndKRGZONzFiWmJmUGc2WlBvMVhJYkZidWd2alJJ?=
 =?utf-8?B?QVgvUndidlF4OEw1SUp0QytCSm5mNFpYdFNEcUZSc2NFTVN0eTNWR3pSa0th?=
 =?utf-8?B?d2EyeGxJeW9XMGlIdTFxSW50YmpjeXVHVUpVKzRhUTY1Wk1PNFRsVVp3b3g5?=
 =?utf-8?B?SDZocTlxUmlQVVpjSmRTS0dGWGo5dnR2NE5rOUM3akhlOThORCtBakN3Q0pm?=
 =?utf-8?B?eW1ISjVFSWdpNlU3WnQ5eHFURDQ0UnVqd3VHQVhaU3NDekVBL2VxZldtWGRJ?=
 =?utf-8?B?M0ZiN2dVUjVTMHF2WWlESndVVW91SitUbkJHZDNhenVheU9ka1diVGVjVnlm?=
 =?utf-8?B?NXhIeXdCQzRnTzNTbFUzem5NTEhLQmxrUWpTSWY1OXU5VC9ueEUza01rZktK?=
 =?utf-8?B?OWUzUFJmNE1QdWVMZnhZTTJlUFpFVGxtT2kzOWxReEljbnpwNm5oMmZvTExP?=
 =?utf-8?B?Qi9uOW9WNm1NWFdGVE9IODZGbDdrQTE3NEhieTJ5by94bzNuOWxhRWxrL3VG?=
 =?utf-8?B?VjlaV1ZMNVh1UENxK29xMTNzTEd3dmovOUd5elVPNHlpRk9ZWGExTUFuOUFN?=
 =?utf-8?B?U3JDeUhWL0RSay9lcGhDMUR5Ylh5TXdCRnJwMTdJYUIvYkN4eXlpUXhwTHN4?=
 =?utf-8?B?QjVhS3VPdjR0T014S21yejdERWxZYlNGamtaSWdjek0rWFJHQy9scHRsZEQz?=
 =?utf-8?B?ZmxZWlE0WVJ3enZnZk1SS0ZQRWpUTndmcGltNGZNUnhTZXE4dUsyL081bVUr?=
 =?utf-8?B?amJHM3d2VlVCSnBON0hqS0xNUXpNTGdXVWFXQ3JNeWVvczBSSjZPY3IrcnZo?=
 =?utf-8?B?TnIzQ2J4RVdkVzJWWU9CU2tGQ2RyamFuaFZ5KzJLeUNXbVk3NjZWVXhyemY0?=
 =?utf-8?B?Vlh6Nm9yUlZrMzZhcGxJVnBKMWhDWGdyMXc4RmdESThSZjRzcWd1cDcwSlhs?=
 =?utf-8?Q?ZUdCTxLw8DwgAUuRrx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15e7eb1-d7df-41db-b549-08df40a05789
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 09:35:51.9086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imH/VpW02MPFZxyK5aU8ni/o9A+5VlmfGwd5A4Gy4aJQ3r3IW2Okx8fI5Mb/t8h/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 20:59, T.J. Mercier wrote:
> The BPF iterator docs in bpf_iterators.rst specify that the next
> function of an open-coded iterator should keep returning NULL after it
> has been returned once.
> 
> Add a subtest that checks this for the dmabuf iterator. It drains an
> iterator, calls bpf_iter_dmabuf_next() once more and checks that the
> result is NULL. The dma-bufs the test creates keep the list from being
> empty, so an iterator that starts over would return one of them.
> 
> The existing open_coded subtest uses bpf_for_each(), which stops at the
> first NULL and never calls next() on a drained iterator.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Acked-by: Christian König <christian.koenig@amd.com>

Let me know if you already have drm-misc commit rights.

Regards,
Christian.

> ---
> This depends on Kang Chen's fix and fails without it:
> https://lore.kernel.org/bpf/20261110125106.2935677-1-k.chen@smail.nju.edu.cn/
> Kang, feel free to carry it as 2/2 in your v2.
> 
>  .../selftests/bpf/prog_tests/dmabuf_iter.c    | 19 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/dmabuf_iter.c | 19 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> index 1a5dc1adae73..c1f81b5dccdc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> @@ -265,6 +265,23 @@ static void subtest_dmabuf_iter_check_open_coded(struct dmabuf_iter *skel, int m
>  	} while (bpf_map_get_next_key(map_fd, key, key));
>  }
>  
> +static void subtest_dmabuf_iter_check_next_after_drain(struct dmabuf_iter *skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	int err, fd;
> +
> +	fd = bpf_program__fd(skel->progs.iter_dmabuf_next_after_drain);
> +
> +	err = bpf_prog_test_run_opts(fd, &topts);
> +	if (!ASSERT_OK(err, "test_run_opts err"))
> +		return;
> +	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> +		return;
> +
> +	/* The test buffers exist, so a restarted iteration would find one */
> +	ASSERT_EQ(skel->data->next_after_drain, 0, "next_after_drain");
> +}
> +
>  void test_dmabuf_iter(void)
>  {
>  	struct dmabuf_iter *skel = NULL;
> @@ -315,6 +332,8 @@ void test_dmabuf_iter(void)
>  	}
>  	if (test__start_subtest("open_coded"))
>  		subtest_dmabuf_iter_check_open_coded(skel, map_fd);
> +	if (test__start_subtest("next_after_drain"))
> +		subtest_dmabuf_iter_check_next_after_drain(skel);
>  
>  destroy:
>  	destroy_test_buffers();
> diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> index 9cbb7442646e..d5421b75c39c 100644
> --- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> +++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> @@ -99,3 +99,22 @@ int iter_dmabuf_for_each(const void *ctx)
>  
>  	return 0;
>  }
> +
> +/* Result of a bpf_iter_dmabuf_next() call after the iterator was drained */
> +__u64 next_after_drain = -1;
> +
> +SEC("syscall")
> +int iter_dmabuf_next_after_drain(const void *ctx)
> +{
> +	struct bpf_iter_dmabuf it;
> +
> +	bpf_iter_dmabuf_new(&it);
> +	while (bpf_iter_dmabuf_next(&it))
> +		;
> +
> +	/* Store the raw value; the verifier would remove a branch on it */
> +	next_after_drain = (__u64)bpf_iter_dmabuf_next(&it);
> +	bpf_iter_dmabuf_destroy(&it);
> +
> +	return 0;
> +}

