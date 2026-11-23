Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC9606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L5eTlCZw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F44B10EA73;
	Mon, 23 Nov 2026 09:10:23 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0741110EA73
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 09:10:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bb2Mn+mATe1VyTn9FbXR1iLXbWs9fk6yXfE5/UtNdiT4AvSqvDHtZtcNcZvBYAAQTQmOZU3MOroWlvE4c2yYVuKx+9eZqwI1TxGhNax3cRqBIIGTv/+weW1vRYGIegGaUltcqAetZHa+n0OYvXfldUgtCjGW+xErzKdZTG+5aLCLjPpXs/O8bEH1v7I6WtqqDfhOLpVl7NQVk6ATlo9v5w9AstkD3HunJGxDXdvbKSDAZJc4Wi+05k4WrBTPsKFmmh8oSuN3SiabPaNqXKyFyRhg53cwNS+pSOYM+Dy9NxWNpECv28DAoxC6OlB5XQeio0CczTMZNZ35MN/wj8dJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ysah7EW+JJVPB+mXDMbQ6SSXvDH2RvPxQ9+WKhWk/ac=;
 b=VKy9mrvo3uumiVwThvQiSEIltIUkjJYChXA/ulwv/rMHIeUwSD4z6f031il+WcutwuqdeO0lozx+49kT8iLj/7EGIVgPz8fI4ElGcF3UQvQIMAoR6irsgHZTTJBcP8glnbpZKbOP5mVESU/8kvOl96miWeJAT4jvVfxKI1ibfWkMRkGXnpOHjOGgeOwbzPNGJHfJRNCIQgsrPOXgaVEHlA1Njmg5VMWD5w7SrPhQGhMRgjXp4RHaTE8C3P6SReJvOSmDEAzZ0xhXZ5uAUAx8wNRCqEuI6t/t3LGTBwk/zrEtQbp210GfCZBGlckGGRbT8cNKw5ANbdV/kHSBogMJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ysah7EW+JJVPB+mXDMbQ6SSXvDH2RvPxQ9+WKhWk/ac=;
 b=L5eTlCZwffNU8rNT/yTf+RYZyCcEQxsfEUJ8sboOYEz221GMvc4sMJJUWUCCuTQHmPktBIZCb/G+huHFu3QbKpP90BtNA/qGLsedlPnS3q9WoBrpSLgZIFFOuunxovDW0smihaErZL9fHmxFK92cbPEf7y2ZeLCMTYvjNWRtgCA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 09:10:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:10:10 +0000
Message-ID: <7fb27655-6a7b-474e-995c-ace5936509c1@amd.com>
Date: Mon, 23 Nov 2026 10:10:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma-buf: align large mappings to PMD boundaries
To: Qiliang Yuan <qiliang.yuan@linux.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>, Philipp Stanner <phasta@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261122-feat-udmabuf-huge-pfnmap-v1-0-dcba888940c2@linux.dev>
 <20261122-feat-udmabuf-huge-pfnmap-v1-1-dcba888940c2@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261122-feat-udmabuf-huge-pfnmap-v1-1-dcba888940c2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 1717c4e9-a39b-4558-d3b3-08df4941936a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|56012099006|11063799006|4143699003|261026121527099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: MUtU3wxHvaBqhNaCh4i7UB4z2vfjsm5JLGSevfcGyGz0OU6MYN+9ZeyJjDNwXf5WYKThuvhK7JFTiRqn8qjGM38Oum59Jcacp/UrWr5Nmsz7kHLiFA5fQ8w/YBSSmuCA148qEQ32FYcvsFBeba+s4KOOr/Mk9+lAQ8RM1AaTNUZpXwGiDt0a0D2km2FRXkDU2iByo+l4K1Z8w+8ziR5wRoK9BUMNagA5Wi4R9TMqJWq1Ht6VoXIAyN7/TuSOhcdzI1txz/gdtRK3inb9RVNelXOGc7Pjmn45BlS0DoKiOIXSmAuDhA6F3AadpGZhkFTt9G5RYZaRWiALyZZ5pMpjVbineiAaYZqXxtiPYUYfLWZ02BGGHMJut2hVPFxKkkleVADSOCg2wkzrhWD2ASB27ZLlu+56V+3bx5i3zpWPWtAMa9bt7ZcGgRolFG8TsgXzDgj26hRZNlLyXEwzFG8sLDaNoiiyD2q5Fpr+3Re3vl0nK276dhbf6GWntqbKVK5eUXT3d96NPgtarVdR2KMkLK9TAyN5yBennhDoBYIdX079MEf1nkWSjmXsmEu9qYVJmSjsblzhzjzEst37DZaEB4gGnzuQhvEGFbzJ8pKoV1VJD3fc4r3jktQszGu7ZFaR0pI7NHdzs6edr6+V8TD7YfC0Cy49Vy2oixC5SIuB0Cg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUt1TkJjZFZHd29OZVlBY2kzMGdBMzRoTnBzS1p6TUtQSjkyaWFtbG9EanJv?=
 =?utf-8?B?MlAxbFpSZDEyc3hIZ0pmWGtLQXFpUXVZaTBhbGpndU5KREluOFhoMFNGWTF4?=
 =?utf-8?B?Tk1DTWc2eTl1UTFuMEcvSWZXanowbzlRNHRHYUVhWHVyVUJPcDg3MTJsMm8z?=
 =?utf-8?B?enpDNDZQcWFQc1EwZ2Jrb2d1SVYyRzRuNEJ3WW81akNWT0lZVnhRWS9rMDZ0?=
 =?utf-8?B?c0NhTVY0ME5MM3pVbEJNRVlxZTJBRjNlelR1eStQVHVLQlNNNjVCMHJ1Z1FI?=
 =?utf-8?B?REtiblRVMGd0MVNqMlUzR2lhb1hwWHhndEZCTjZDYzVVSUZKNUZwOHZrN2FI?=
 =?utf-8?B?aVVpRytLTzBiUG1rWWtFSmdPeU0vOGVRV3lPUUsyZVVIZlhxWVRBaGtNcHNB?=
 =?utf-8?B?SVE2dnN2SFlvU2ZjdEpSbHVsUDdoeUdHU2k2Q01CTVhOVzJJMGZKTUtrVlRZ?=
 =?utf-8?B?c0UwRmpxQnlPcVhFUUM3VjZKZlRlVWx1OTRuQ3VsUVBnSmZEL0hLY3hJamlM?=
 =?utf-8?B?NmdON1RMcHl1VVdrOEJ4bDFWdG9nSXp3WjNYTGNvdGxIclpiZURaVm5mblBE?=
 =?utf-8?B?ZGZyUzIvbzErZ21GY1NZL0YxeFB4SmhGVWJYQzVrVDZkUGtqMDQwekRxUHdT?=
 =?utf-8?B?dnZKNFlsbk05QUtFQ05MRUg1TG52eWk5OVJ6TzBNRHV4ZFRzbDF0aWVJRkpx?=
 =?utf-8?B?V1pKdW1IWFdjUkhQYUdKVWZ5RnYvaHlJQkt6SGRmZHErM3NzTGlqU2FTbFZS?=
 =?utf-8?B?ekRNL1VoWUd6SWJiWEtQZThacW9nLzBUUVhxVzFvZEhjZElHZjl4d3h0anNJ?=
 =?utf-8?B?Q3F3OGxkbENuV08wb0p0VDFZdFRGYUt0cGVtcHRzbUs5bkpnT0RIOGd5WU50?=
 =?utf-8?B?TWEvb2srbHI4dXZjSU5UMEVHQU5rYjdEejhNQkhVRVk0N0k3M2Y5a2ZZbHBU?=
 =?utf-8?B?LzhMLzhPT3lUSEhQaG1lSkV3eEJPaGMwc3Z6RVBYOENzZlQ1dXl4eFBMcDFH?=
 =?utf-8?B?eWNGaGFlV3VXTVZPaW1ZNi91ZjM2VWlyMVRKZ2V3NnhKcjIyZXBSL1h4bFN1?=
 =?utf-8?B?WE4yNVBMOFFjY0FhOTh5WGh3VUtBOWF5Wk1sVDE2ZEczYjVsVWI2S0oyLytt?=
 =?utf-8?B?dGZSNHJBOUxWZUxQeldTV0sraWRtanFsay90VWR3Z08vUTNML2JiRWUrK1dC?=
 =?utf-8?B?aVg5VXhZTkNoaDVRNkxrZGZVdW5lVDdKVGYwWHo3VlBtdzQrRE1yMzZmZk1l?=
 =?utf-8?B?cGNCWmQ4YnBFM0RZWkF3RHY1aDVjUlk2NVUzVDQrbmFHeitqLzdYNUtjdjBX?=
 =?utf-8?B?cU15aStUbEcvbElPN1lrbm5uTS93TzcrUW5FUlg0ZW54T0phSkJGRXRxUU1F?=
 =?utf-8?B?MXFlZTNNVExnNGdsMmpYT2VzTXE4T3BQZFN5U3RJSE93RDNMakxVNlJsdTNW?=
 =?utf-8?B?R2xEQmVETVE3M2hGTWVLVmxwU3l3SzFMb1hwVjhXVmsyc3V3bUlsTlpTdU5N?=
 =?utf-8?B?aU1YZWE1MnhBSDJhNUxuSWVMVnI5SmJKQkYwN09XWnpsWWozNlNTSEpwM3Vj?=
 =?utf-8?B?UmdpR2JaSFBPaUFFQWtJUm0xdkVZTGk2ZDZ2UVB3OHBkc0R1aEtkTlUvQU83?=
 =?utf-8?B?Z1ZGMjJGODBCZmtPZEdicW1XWVcxU0Y1WWM3aW9UamlyQ0ZTYWdxWEVvR1kw?=
 =?utf-8?B?a2gybjA5VVUrMnFORjZ5TVZXK1c4OFVDUzhNODEwbEU4T3FIN2o3bzVSZFBn?=
 =?utf-8?B?eHVFQWVjcjcrdzhZUFNqVVZDVnpWbjQ3Z01yQVgwWW5ITTVGeG93b1V1cjRP?=
 =?utf-8?B?Qk1lemZqRUhGZG5EUmxEQjF5ZDM5bjhQY1JsTkU0ajNvWVlRVHNMalZxSFNi?=
 =?utf-8?B?TXBaeS9NNG1xRnJFdFJGZDRyU1AxVnhkdzAzVkF6Vm1yNHl1cjIwZmF0Nnhp?=
 =?utf-8?B?OVd5UWtETUFaL1lGczFiMmhYRUczWkxUby83SXNPMStCWjZUcEU1WmsxeFFV?=
 =?utf-8?B?dHIxakhmWFR0V1pvZmtxVm9ZU0hDTndYYlhVT1dkdTN1QnNsa3N3Y3lOZGNK?=
 =?utf-8?B?VitDU0lXMkRkT0wwSWh0M0JWWlU2VmxYN2N1VzIwYUg3OHlTNHpYM2JoWXNv?=
 =?utf-8?B?anNtNXR2Tm5uYlg1WkJyTlYySTVHSXJQbWZYalc4ai9PQnFHclRrdittNnlx?=
 =?utf-8?B?eXlHY01vUnU2VnlWUTZxMndYaUt5dExBZXhkOC8vY2NrVXdKZjBVMlptVGpJ?=
 =?utf-8?B?dTNxaTIya21jMXQ1aEVhaVpBZGhCakZTT0VpSm1HdCt5TVE1S2NPVUVlZ1NS?=
 =?utf-8?Q?QPkE6Hr1XwZ99qQvHN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1717c4e9-a39b-4558-d3b3-08df4941936a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:10:10.7784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKuia29Tfbeq7KhFjkcdL4ndfVlN+ZXx1ObxZo3uz9FXZo4QCl3Wq0Ip2iq4va6y
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

On 11/22/26 08:37, Qiliang Yuan wrote:
> A dma-buf exporter whose buffer is backed by physically contiguous memory
> can map it with PMDs from a ->huge_fault() handler, which only works where
> the user address and the buffer offset are aligned alike to PMD_SIZE.
> 
> dma_buf_fops has no ->get_unmapped_area(), so mmap() places a dma-buf at
> whatever page aligned address the default allocator returns. A 4 GiB
> udmabuf, for one, lands 616 KiB past a 2 MiB boundary, and then none of
> its PMD-sized ranges can be mapped with a PMD.
> 
> Use thp_get_unmapped_area(), as filesystems that support huge mappings
> do. It aligns a mapping that covers at least one whole PMD to the buffer
> offset and leaves smaller mappings where they would be placed anyway.
> 
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/dma-buf/dma-buf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 5c6957f8839a8..015a03c8d04db 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -608,6 +608,7 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
>  static const struct file_operations dma_buf_fops = {
>         .release        = dma_buf_file_release,
>         .mmap           = dma_buf_mmap_internal,
> +       .get_unmapped_area = thp_get_unmapped_area,
>         .llseek         = dma_buf_llseek,
>         .poll           = dma_buf_poll,
>         .unlocked_ioctl = dma_buf_ioctl,
> 
> --
> 2.43.0
> 

