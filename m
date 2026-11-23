Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47D606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bZ3EBCOV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE7F10EB6D;
	Mon, 23 Nov 2026 09:16:32 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B464910EB7D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 09:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sv9b03zWJH9F2dGx+pk0jGGj2u5bnBKFLqmo9OAp+yJKjnhTErFjsfSDLZgRrY1AscesuYGqQQlKLJFmkTYQv4DNk932jurqTaDUqQ8z4s4MvJa83Bz1IJxfO7dCvqpPVAOHg7XhsrzJXbk267u2ZXIVaQiuwDr9N2Gj/DfEjv7iT135DFTPkw8lzCcg/72WlPJWURgX3VLKObCiYGemhkjsTu6OnH6raxMR7KRc5YcmqtxHPuC7ZKzDRap+tAfWXITfHW1ZJomipPyTdU/oUdvqFXK1kIQsAcQetbGK2znwo0TyMv6fpweyiBmqDF+8P+JVe7BzpnnieDyYHFF9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pPlie6jD8tf7aBjNcRGiCnZbjLLtP2caQghIpmYvHc=;
 b=pwZzwWjgosvcSkejABdMLXRGHVwb3JJsTwvYxLtT4ZnU4xeQaEYXWkaSJPX3BZwcWcsUnyUnkVPqb0vYQo4czBQt7P3XTCIy+nTqa5sD8soBSGB+HdCG0iVOI77YS6rxHDZa4C3bTIHOz/nZ5iEoOhmSrTkNyMlwLKO7ne+Dc395eGBGT5B70tBHz+ZpFTDFB/IYC2T8jTdyH1L5sQv+16LKZnZ6raf0G6cYpRQ5WG7kslW2uQ6i9kFKTcJu+04uhVgL3QeZ3FTN0OsEU5gTkh3xaIxmPpLmBV8idCdWvNX6lW40fM7GTvzwbkaNpN01p65wiz/C5N/8jsXrRhPJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pPlie6jD8tf7aBjNcRGiCnZbjLLtP2caQghIpmYvHc=;
 b=bZ3EBCOVNSZub0+BMuojVU1Ekn8oQ3PZB6Js+tQNGjcO6H170yQXZOY0ebIqtKcowr46r2yO5fNwAN+S3FbSSz/JSxq+mD6b4GZIHv+vHpD8Ogq9PkDn+SkS5Ej1ONckwI8evHWsoYWkdiPHA8Ajm7MR9ee2GLuCOa6c3yrBHbg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 09:16:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:16:23 +0000
Message-ID: <4f9c0bb3-1de1-4c8a-bce2-436818c61cf3@amd.com>
Date: Mon, 23 Nov 2026 10:16:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] udmabuf: map huge page backed ranges with PMDs
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, "T.J. Mercier" <tjmercier@google.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Qiliang Yuan <qiliang.yuan@linux.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>, Philipp Stanner <phasta@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Shuah Khan <shuah@kernel.org>
References: <20261122-feat-udmabuf-huge-pfnmap-v1-0-dcba888940c2@linux.dev>
 <20261122-feat-udmabuf-huge-pfnmap-v1-2-dcba888940c2@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261122-feat-udmabuf-huge-pfnmap-v1-2-dcba888940c2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d2ebab-0818-4b2e-0a6b-08df49427152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|56012099006|11063799006|4143699003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021135927099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: E3DKU/djzoIr+dVPWD/jfusrs7rw6kjxuUzCSmljm2AccKrCPBgp13XhS60Rnjdi7YqcCZpWyawuSCjmQ41xaQNQdIgjRiHTqqvBICVr5dh/P3J7OCtpXrU5M7NE4WDYARBLS8mArKvSUVsyhJR15DH+xPcII2DFIeJrSr1RAbXHA9kFf7d8VtlTsXot03DrssRxNhwDZtdCGUfrnOOCH+Ndti4vFIRelD0tPG8+DEyzSlzn1cij3WAHRjw4jpqclgyMQVBsm6N32AyFdXDXVmum4pLa12WfIG22f8h+ulJ8EVlSRVKWXDA8dFxFMO1wdbe4hne4OGU6zzKZqx3GAS8tjLRJ94JHpU303Pg2zrPREDJIjq2YD4qWEyzZb60fFCC+fMfDdELTyAQHaesSLtRVx2CS/+UAm1M+TXHwtqsLL3SDXAgZd4h9E/uYI5inIYsAM1qFkxcXB37B+7xV8Uqg/WMO1Di1uvuQUCJnBtHO+PciO6lNrhaLizRMMwlCm6EVfgSk1msyl8bh+pdh8QD2S/BZ0c/VCkkd0NH/jJALRjrwvrjdw2lSNDqsjNUIdJqYZSSB6DYtSlzuadx7Sl20wZK6isczUbhkayuaMQO64MtGDzYTgFFHdbq4CinYMZGR3tw6J5A3MiRXDyqeqh/KM5BsYvB0SwjiSnggTqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021135927099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpoUktVemdKeUR3R3grK3VIZ2pVbHBqN0JCSzBvcmpyMUhUSVZ5MHF2Q05K?=
 =?utf-8?B?dDl4WTRVU0orNE5rejA0NWw4RkdNdk8rUUJKYUJkZ1lhMW1HTHNOeFhQdHha?=
 =?utf-8?B?SDJvazRIeHhhVitwQUdCVDRwZFd0Y0ExeVMyOVpKUEtHdGo2YVBOSW5BbDZZ?=
 =?utf-8?B?OEhJcG9RMnQ3YWJua0xQUElCMk5qa0FUOUFxOHJQbDhrbjk3MEltTzRJV1RB?=
 =?utf-8?B?aHVOazVWNGR6UUt5ZWR6SXRpU2tDUkkvSk1KRmN5N2szODUzeVlNM25pMC9j?=
 =?utf-8?B?SkZVVlZHZUhCQ3NpNHora0xURzNRbUNVWUpyWVppV0VWU0VOK2E1ZUFtZ3ZW?=
 =?utf-8?B?ZmdqOHQ5aGxzdEpPREY4b1NJUWFRNXc3M3Yzb09paFhjdi8wQktwVkp0bUU2?=
 =?utf-8?B?VnA3djlCNTF2MUxzM1U2dUliYzczVmp1NzJ1eE9zRkdlUTM0dWpIY093Z3lv?=
 =?utf-8?B?RklidUIyMi9NSG9CUDZUaFdUWlQzc0psV3NFcitRb3dvTFdsOHZQOWl6UGFk?=
 =?utf-8?B?SjNQWWtiRDVtWkk3RzBOZmRsZFRFYjM3T09mU3p3NjFwcWVNcnF6c25BKzJp?=
 =?utf-8?B?UW5iMkIxbnhiYXl1eXV1WDFmNG44UTBzQUhWbHlkMDlJN3VITzZiZVZ1cXhs?=
 =?utf-8?B?bzFFUFVRTnUrZnJtQm1Va3BSK01XcVVmK1pNMDlKN0dXc2Vyc2hKa09NajJl?=
 =?utf-8?B?UmE4SjZJL0hyd2E4MnBxWkNBRUNRcE43a0ZYS3M4NitCcFNwdzFxWEh4T1lj?=
 =?utf-8?B?N0dFbGlqN21qVExCRzBhQ1Vnakw4cTQwdGZManVPOXJIaGN2R1FOdjNOV1Fk?=
 =?utf-8?B?Ujl3a1Zlak5DUmZMVUM4MFpyRXczT0I0a2Vua3ZwcW9hRlJXRGZQcTRlUmdK?=
 =?utf-8?B?bmlkYXYxQXhFdHNFcEt3VHRING9HdVIvNURkbXVRL2UrcC94SVhZZ05kVnFE?=
 =?utf-8?B?VzhBeGZOVXVvcWxDVzgrNlNtK09rc2tVV1ZiLzk0OVNiTGFMd3RmcVBLRUlL?=
 =?utf-8?B?MW5sM1ViVVZ3WldPRkxaWFdkUzU1aVFWYVBlZWtKc1ZkZXl5bnp6K2o2SXl5?=
 =?utf-8?B?Mzk0cHRTcHRWdE05U0ZUcCtvK3NDMkVGSXJ4eEVyblFnc2FlKy9rVUE5dGxG?=
 =?utf-8?B?VzAvVWlpMXlvdTRlNllQTTVsNVd2NmlDU2xPTTkwSS83UVJSTFdTRFdBb3Ar?=
 =?utf-8?B?RDU1Vk9LYkVxK3BNK3ptSmFWYUgyQWdkQk1VSHNhN0ZPQ0ZRSm4xZURZODV0?=
 =?utf-8?B?ODRhRy96Ui9SL0dxUmpmSGdWaGxjTmZERW9rQ0JmUSt0eTNwd3ZocDk4Wkh6?=
 =?utf-8?B?cTVLWlFoL3krR3RKcHppTWk3VWxHZkJGc2ZjSlJjVzBGUHhwcy83NW5za2dr?=
 =?utf-8?B?dFdmeVdrOFhna1ZmOVhVSUtNSXpTdUNCeGsvckhMV3BTVkVnQk9ZdDRoWmRa?=
 =?utf-8?B?QUMzMmt5b0hTV2t2bENBZDJXZi81bHVTbzdqTE9vbjUvWS9aZ3piVWhQQ0hH?=
 =?utf-8?B?S2l4c3k0aGpaSkxST2JqODRlcHZuSENrRHVoOVZYdFovak5jSHQ4VnoyZ0Y0?=
 =?utf-8?B?UzhaaHhkNStSQ1RYTDFHS096ZkkxdXRrYXgxWnhIUVlpallUNmU5YmFIc3Jl?=
 =?utf-8?B?Um91dGpXSlVjYnBtWlpmK0RhUHkySUZZY2RHdjlnbWtxTGVJanlISHg3dXRn?=
 =?utf-8?B?UjNRZFp3eVFiVjZPcVFSNzhOSjFuNkVkTHpTYjA4SzdQTDVqWGZxVmZCN3NK?=
 =?utf-8?B?elcyRjNwK0g0REh0NUkwRldselh3dVBIZlNDS3dOL3k5SUk1Y1pvaFVnQWM0?=
 =?utf-8?B?aW1HSy96MW93TXBSeDBoS3VjWVpJL2dMN0ZzbEFPUURCd2F1YXdSOFhPR2JL?=
 =?utf-8?B?NDRsTk5aazZ1cllTN3J3ckJVZ3J4T1QzOEhHVmhDaDNEbnRudUpDK3NCQ0RH?=
 =?utf-8?B?a2xhV3Zkb2lHZzM3ajZFR0E1czF4azAwQUMrNmlGU2x4NjlSb1RrVDV4SXd3?=
 =?utf-8?B?WFVWbzI5bmRwWDdNaTJRRUQzSk02MlBHZ29pc1VPOENsYlFUanJieVl6QnFD?=
 =?utf-8?B?cUl3VWNybUE3MEU3VkRFS0RtMjd0SFUwOGtJOGtEZFBhSzJrWWtOVmhlV2RB?=
 =?utf-8?B?aElpdlR2eFM5anp4cXZTdmR0L085UUxvTTVRZnd0SUt6aUtHY08ycWNzOHR3?=
 =?utf-8?B?eXFrcDNlajlNQ0hOZHJaUk44T2NxdlNZclVPQXB6V0ZNaXR3bGZtY0sxcWd6?=
 =?utf-8?B?RThrR0xFcDd5akIyRDFrZmJTa3hQaW1xLzBTRXg1S09rUG9qeTVqaXk1bzhx?=
 =?utf-8?Q?IuxAVED1/JgdC/wBOe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d2ebab-0818-4b2e-0a6b-08df49427152
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:16:23.1785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuXtSclDgUGOIh1K2bhitejeVC2Q5XHE8ZxW6MrPknJw+rutWInJ5PZeWxG1UuSV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224
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

Hi Thomas, Natalie, T.J. and Philip,

could you guys take a look at this?

IIRC we wanted to do the same thing for TTM and DMA-buf heaps, but at least the TTM approach failed and we had to revert it.

If I'm not completely mistaken it should now work fine and is quite a nice performance improvement when mapping large stuff into the CPU page tables.

Regards,
Christian.

On 11/22/26 08:37, Qiliang Yuan wrote:
> QEMU and crosvm hand guest memory to the host renderer and display as
> udmabufs for virtio-gpu blob resources. The guest memory is a memfd that
> is often backed by 2 MiB huge pages, and the host process mmap()s the
> dma-buf to access it with the CPU.
> 
> udmabuf maps every page with its own PTE: the first fault inserts a PFN
> for each 4 KiB page of the whole VMA. Mapping and touching 4 GiB this way
> takes over 200 ms and a million PTEs, although the memory behind it is
> 2048 huge pages.
> 
> Add a ->huge_fault() handler that maps a PMD-sized range with one PMD
> when it is backed by an aligned run of contiguous PFNs, and falls back to
> PTEs otherwise. Have the pre-mapping on the first fault skip the ranges
> the handler will map, so that their PTEs don't take the place of the
> PMDs, and keep pre-mapping everything when the VMA can't have PMDs.
> 
> Mapping a udmabuf over a memfd filled with data and reading a byte of
> each 4 KiB page through the mapping, base and patched kernels alternating
> over 3 rounds of 5 runs (7 for shmem 4K), median of the per-round medians
> and range in parentheses:
> 
>   backing    size        before (ms)         after (ms)   change
>   hugetlb    256M   13.3 (13.3-13.7)      1.7 (1.7-1.8)     -87%
>   hugetlb      1G   53.6 (53.0-53.7)      6.5 (4.2-6.6)     -88%
>   hugetlb      4G      211 (211-212)   23.6 (17.6-25.2)     -89%
>   hugetlb      8G      423 (422-424)   45.8 (45.8-47.2)     -89%
>   shmem THP    1G   52.8 (52.5-53.1)      6.3 (5.8-6.8)     -88%
>   shmem THP    4G      210 (207-214)   20.7 (19.5-21.1)     -90%
>   shmem 4K     1G   52.0 (51.6-52.7)   51.8 (51.5-52.9)       0%
>   shmem 4K     4G      209 (209-211)      208 (208-209)       0%
> 
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> ---
>  drivers/dma-buf/udmabuf.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 018937435356e..f9c908f8b53a2 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -44,12 +44,63 @@ struct udmabuf {
>         struct miscdevice *device;
>  };
> 
> +/*
> + * Return whether the PMD-sized range of @vma at @addr is backed by one aligned
> + * run of contiguous PFNs, which can then be mapped with a single PMD.
> + */
> +static bool udmabuf_pmd_mappable(struct vm_area_struct *vma, unsigned long addr,
> +                                unsigned long *pfn)
> +{
> +       struct udmabuf *ubuf = vma->vm_private_data;
> +       const pgoff_t nr = PMD_SIZE >> PAGE_SHIFT;
> +       unsigned long first;
> +       pgoff_t pgoff, i;
> +
> +       if (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP))
> +               return false;
> +
> +       if (!IS_ALIGNED(addr, PMD_SIZE) || addr < vma->vm_start ||
> +           vma->vm_end - addr < PMD_SIZE)
> +               return false;
> +
> +       pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +       if (pgoff >= ubuf->pagecount || ubuf->pagecount - pgoff < nr)
> +               return false;
> +
> +       first = page_to_pfn(ubuf->pages[pgoff]);
> +       if (!IS_ALIGNED(first, nr))
> +               return false;
> +
> +       for (i = 1; i < nr; i++) {
> +               if (page_to_pfn(ubuf->pages[pgoff + i]) != first + i)
> +                       return false;
> +       }
> +
> +       *pfn = first;
> +       return true;
> +}
> +
> +#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
> +static vm_fault_t udmabuf_vm_huge_fault(struct vm_fault *vmf,
> +                                       unsigned int order)
> +{
> +       unsigned long pfn;
> +
> +       if (order != PMD_ORDER ||
> +           !udmabuf_pmd_mappable(vmf->vma, vmf->address & PMD_MASK, &pfn))
> +               return VM_FAULT_FALLBACK;
> +
> +       return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
> +}
> +#endif
> +
>  static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma = vmf->vma;
>         struct udmabuf *ubuf = vma->vm_private_data;
>         pgoff_t pgoff = vmf->pgoff;
>         unsigned long addr, pfn;
> +       bool pmd_ok;
>         vm_fault_t ret;
> 
>         if (pgoff >= ubuf->pagecount)
> @@ -61,7 +112,12 @@ static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
>         if (ret & VM_FAULT_ERROR)
>                 return ret;
> 
> -       /* pre fault */
> +       /*
> +        * Pre-fault the rest of the VMA, except for the ranges that
> +        * udmabuf_vm_huge_fault() maps with a PMD once they are accessed.
> +        */
> +       pmd_ok = thp_vma_allowable_order(vma, vma->vm_flags, TVA_PAGEFAULT,
> +                                        PMD_ORDER);
>         pgoff = vma->vm_pgoff;
>         addr = vma->vm_start;
> 
> @@ -69,6 +125,14 @@ static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
>                 if (addr == vmf->address)
>                         continue;
> 
> +               if (pmd_ok && IS_ALIGNED(addr, PMD_SIZE) &&
> +                   (vmf->address & PMD_MASK) != addr &&
> +                   udmabuf_pmd_mappable(vma, addr, &pfn)) {
> +                       pgoff += (PMD_SIZE >> PAGE_SHIFT) - 1;
> +                       addr += PMD_SIZE - PAGE_SIZE;
> +                       continue;
> +               }
> +
>                 if (WARN_ON(pgoff >= ubuf->pagecount))
>                         break;
> 
> @@ -89,6 +153,9 @@ static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
> 
>  static const struct vm_operations_struct udmabuf_vm_ops = {
>         .fault = udmabuf_vm_fault,
> +#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
> +       .huge_fault = udmabuf_vm_huge_fault,
> +#endif
>  };
> 
>  static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
> 
> --
> 2.43.0
> 

