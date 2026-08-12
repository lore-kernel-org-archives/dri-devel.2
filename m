Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F1CC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F91910EEFB;
	Wed, 12 Aug 2026 08:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J/BScv94";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28BF010EEFB
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuaYLYjhAB0q3BEE5P+m2V53hZOjP486grdXT1ED6oR+wl01Nz1YbT0m5PSxSOcD89tYeeUuOoKzoMkGSIsHmVdSIBRvgAfFpBVPySMFYGHASBiaEXkwi3syv6YZrN6rbeZQJO2r/DSMqEC1IV5FpFw2OTQY0xL1R9l9nKwesPyKvrSfzAP8rzBkOm66IeEPvFQEWO7ur9ixbgaCsfPRLW8VnNFyMdvQIXja6ZtlGP9kvuZQZ5/eXjSfeK1NsqQjDai202GZyOQnioD+ubVj5iKnlGxOiDEnXSasRg1YD1qiwE8gc+wnnk8RoXB3Z6BtxccQ5/k0SSCSwszpB4MOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGj2W1+KxTlK3KVOWrhuLC+4xFnSsZlhbQcPhQv18iw=;
 b=bz2W4q3iXjbmp8zdwbNqkEGgXmkTD3SfgRgS5wTyQ98qWrw2oZgvjSRakbzKqoAlVJX8RUwIuIpZg6CU8OcmI2ScMqavkdkeGT+Y7H6FHZqV9D6iyEGSoOrWPofazlJBdUk0KeHfMBeiExB7ziJ7Hl531L5EkcylN/yMF8ppBz/ywTSGPutbKcy0ox4X49Qjb8Ta6I986KEYqehCpijRgZljUTMM6Nbd/ABvZB7VF6CCcZLV2lI6wgL6tdvtRGcPmFts2kmry1b4kA+ssL/MbClvscwxxDGPPY/iL58I59ts7zdg5nPvr2pewZgFqa4X1GXDbP/Cl935JnsRzh8Jbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGj2W1+KxTlK3KVOWrhuLC+4xFnSsZlhbQcPhQv18iw=;
 b=J/BScv94GnH8dU7N0qwGwlEZBOGtskBPJs+u4fE9Z7/IXBh8jPKKjKP9dNy1L/xb4xtYge+Pc8iBfGNuXFplbpZtrXDfvojito3AOpLqpGDU+hEXRTZMn9zhsCGsIlojiykDhsf2E9FrwckyWDxp9n82Rt7aMXayQkFPpAJsK2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 08:52:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 08:52:04 +0000
Message-ID: <01e64e83-486f-49fe-aa1f-c28ab0bf66ee@amd.com>
Date: Wed, 12 Aug 2026 10:51:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftests: dmabuf-heaps: Open heap device files O_RDONLY
To: "T.J. Mercier" <tjmercier@google.com>, sumit.semwal@linaro.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260811204123.3198370-1-tjmercier@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260811204123.3198370-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0045.namprd20.prod.outlook.com
 (2603:10b6:208:235::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: da298b4c-aa0c-4f14-3b23-08def84efb34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: OOjnyBpfFv/eEogXC4j0eEf6ZjCvgmZKgkRyDhST1x87Ba/Z7Ha3x/idMvVftI4nKzc93CfwO7eoj1G99ypDGoweW3UmQyh6oZPJkniBdIht27jkYtUPCQYFcNt0D2kDgRdvuPN16PEdBvwg+B5tk0y58kR68PthlbaeBKOPkwo6VhkWTVu4qeLScxSH3GjigHyNSZt87QYOh9pkQVnWAM7G68Zi+3LhtjuVN5PI14KxyKg+xR65jpFRLVPmxyGM3imrHdbz6tdXCWhU32zT3vxR+BhVg7kKhSYsSxG/BpKwozOcSbVWQ/DJlregweg83Q/wg/brf3XtKlT9jpduJibIrrn+E+9ZXEFaj+Zqeb7STNjNPlqAWMM7cmAw1a+ETBGC2CJi5g1CIxFiyV4iV82GGPaFsdFh74vX98LGnfUgn53RRUPaCsgBzkRbBKF4QZ8wHJKj9/2X58ByIZK3D1EZF8b731Nrd+Elgrk3JmWY2Qhuugmlo/PwCkG6nKl+Cy8q2czMUVBPyNWJYK4OTKgsQR+ZoTrVKb0G9DtQ4WVKSUaf9Uyl5mCcmVu6IMrvSA9WXjv96f3gRqpJMQK0oSKb+t0IneZirzA0FIlrAE3uYLyzrqNHzDU0Cv7rMngT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2xlNXFOU0ZnL2NvOW83SFFxQzUvLzZsTm5zNlJLK1kwT3M3Y09ycWpHanhB?=
 =?utf-8?B?dUNsUUhnQkFvcHEzZUxSbXpsaVlybjBCUzhjUzROWDVsTFFEM2luZWJXSTBL?=
 =?utf-8?B?RTNDMEdBZlB3bURKWEJhTjliZUJDMkV3Umg4ZnkwTERhTnFqeGhMNHJuVits?=
 =?utf-8?B?bFVRWmpWK2YwTloyeGNJOVFmdEJBTGNrem81ZFZOY3hiL05OY0ZEQjR5K0tT?=
 =?utf-8?B?b21Kd29RMlp0VW1wNmYzSzE1MmJFZmFFRXBRRWd2Rmg1VFczSm5qT1BkTWpK?=
 =?utf-8?B?c0ZnY0ZtSjh4dVdmRmJsTk82UkVFenJtRkt5VStVN2VveEdlUm5LTTFoOTB6?=
 =?utf-8?B?dWxSTDNoYi9SclRobTQvZkhQWDJrekpuUXAvRTNpZjB0Y0REVzBnYVpFN0NY?=
 =?utf-8?B?T0tqV1FoSGY2T1EzVHFtYkpTWTc0NVdOY2MrQXUzbW55ZU1TbVhCTHZaK3g5?=
 =?utf-8?B?M2t3WVpzK2lkNFk4cndDNG1qd1Z3OEJOdVhDN3V5aHoza2lXZE45MVplanVy?=
 =?utf-8?B?OW1Vd3pLcm40eUlRd1NMUUVKNlFDSjFJQ3UwdXV1cmN0b3JndFFvank2eFFa?=
 =?utf-8?B?eHRnakJLWEdVd250clBZN1Z3Z1RudE9YRmp1ZUZBVlFDVVQyRGFBREdVT3BN?=
 =?utf-8?B?UU9QTFVVdC9aVjIzcGIwa2F2U3BBOGFsbklKZ24yVG9xaDFmQlVxL3VPY1JP?=
 =?utf-8?B?RjlySnhkNWRUNzVrWUlGdTRISW1xSU5JZmduNUN1bExqZjBnTGNKaW1TOWJt?=
 =?utf-8?B?VENwaHhXVGdaR2FhMXVHK1FvT2JaeUx1ek9UZlZFZWFZWDBabnpWamhuSTJ5?=
 =?utf-8?B?MERDb0VHSlZyQWU2RkQrckN0dFZibXFVOUJqdHBGdnFUTVNMWWppNFF1Rjdn?=
 =?utf-8?B?U0J1R0V6bVpURmZNTUcwYWZHM1JPSjlBSU9JZFpGU1JLTGEreU9PeTBPOW9s?=
 =?utf-8?B?djVUa25WM3RZRUp2eENBODh6OHJVT29sUlEwK05iOWs1NWVEaDlOR1c5Vjl2?=
 =?utf-8?B?eXEzYnFDMTRiZnNzMUE2VnljOGJ0RVZDRFJJVDlqc0xCa1VmaE5RVWxlcnVt?=
 =?utf-8?B?MytYWkpGUExZRmd1ZEtpeC9PeU9Ld2plYnNDekVlMnBjNHVJcmN6MXloS1k5?=
 =?utf-8?B?bVZkamNndGR1Skx5YWlxVE9udnI5d000WTdtWENjT2lJc05kdVhML3FpMGtB?=
 =?utf-8?B?bUl5UWJHMURHNVZVWjl2ZVE4bU1ycjdjR1JVdkpmenp6cnpnTmVJRUxqWkZL?=
 =?utf-8?B?NWUrTW5aQ2dhQkUvcVpTQ3JEbTRvUXpBTW5SWnI3RkRYbnNBd3BEODFNbXJp?=
 =?utf-8?B?aXRBdlRRNUpmQzlxWlVLNlk1cyswQlQvRkxRbEcyd1ZpNGVXL3QwY3k5NnMw?=
 =?utf-8?B?Vjl1TG04OTMvUVdaQmdzMUdHbHRzbEhYOXM5RGRld3hpZE9OMVZ0WVhKQW44?=
 =?utf-8?B?RDB5elBZeXhCd3hwN1hsMmZMeERraTN1bUNhSExKek9nTkoxMXBNOUcrRGJU?=
 =?utf-8?B?TWZHR0V5L3BoT2M5dmkvWG9Pd05PVlpVc2VVVE1lVU81N0VyczNnRVU4T3Zn?=
 =?utf-8?B?MDhKdmttMmpWS2VFUUJ3K01hNkQvd2NzWVZJKytSRnhPa3gwNStBN2RBREpF?=
 =?utf-8?B?dlZ3bkM0OFdXUVF0UGRNWGhNRHNERUU4c3RpUzJ4dHpscG9BUUpUejBmY0dx?=
 =?utf-8?B?bFdUTjVHTGYwQmg2eFJ1OE9pOWZUTDBXZ0luV3BCZjZPT2Z4Sy9yNldqTXBs?=
 =?utf-8?B?Q2Nvb1dad3RsNFROTTk4TzdkdGlkVE9YdkVEbnovWldXRmVDQXA5QXdXV2dL?=
 =?utf-8?B?dG5jbmYrWWVoVlczYWdnUnFiZmN6cDVvc0M2SUZTQ0t0Z0RGR2JSQzB0M3ls?=
 =?utf-8?B?OGVZTk9kbk5IRWtFME1WSlMxZ2ZGeG5wR2ZQQkxKTStxOU1mUkJQUS9nNlN1?=
 =?utf-8?B?Rm5RRm5YQUFKcGpqV3F2SGVPMk4ySk9IWHhYRWcyakhXbUlheWVndWpCOFFR?=
 =?utf-8?B?MHg2MXJIZEdzMFBKMDdaaVF2a2ZHOTBheGxZNHU1UUdpajNVUjRyT09jMkFN?=
 =?utf-8?B?T1N6c1J1TUdEMkNQWlRxaG1GdXpHNUgvOUZ4ZGt5Y090cUtHWEZ6WFhHSGF5?=
 =?utf-8?B?OWcvZXBkL1ByY0RHS3prb0NXTkRWeHlNTkE1TWZFOE83N0oxeUE4SEJUdU9l?=
 =?utf-8?B?SmFuQWlCNk42L01lOGFBNTBGWkhJb2FUaWV5eCtvSzdFV0hGNUw3bGNHS2VC?=
 =?utf-8?B?MHYvbkVqTW5ITU5QMzUzNFBTd3BuS09PTzFndjB6ZG1kRHJZeWFSOTRxM1ZR?=
 =?utf-8?Q?pbDAgqAEKDkQa8LRwp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da298b4c-aa0c-4f14-3b23-08def84efb34
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:52:04.1083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rNUx6owjXWL3Rwa7YXKZAxTLOYUXtEoV5+/Cwzxu3tY76h11m8i+oawv1e+Zvx7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
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

On 8/11/26 22:41, T.J. Mercier wrote:
> Write permissions on the /dev/dma_heap/* device files are not required
> to issue ioctls and allocate dmabufs. Applications should be opening
> these file as O_RDONLY. The BPF dmabuf_iter selftest already does
> this. [1]
> 
> Users are pointing to these selftests as examples of how use dmabuf,
> and encountering permission errors on systems where write permissions
> are not available on /dev/dma_heap/*. Apply the principle of least
> privilege to selftests which open dmabuf heaps by removing the write
> access mode and using O_RDONLY for the open() instead.
> 
> The same is true for the vgem test using /dev/dri/card.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=v7.1#n49
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> index fc9694fc4e89..45b420e37c97 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -48,7 +48,7 @@ static int open_vgem(void)
>  
>  		snprintf(name, 80, "%s%u", drmstr, i);
>  
> -		fd = open(name, O_RDWR);
> +		fd = open(name, O_RDONLY);
>  		if (fd < 0)
>  			continue;
>  
> @@ -96,7 +96,7 @@ static int dmabuf_heap_open(char *name)
>  	if (ret < 0)
>  		ksft_exit_fail_msg("snprintf failed! %d\n", ret);
>  
> -	fd = open(buf, O_RDWR);
> +	fd = open(buf, O_RDONLY);
>  	if (fd < 0)
>  		ksft_exit_fail_msg("open %s failed: %s\n", buf, strerror(errno));
>  
> 
> base-commit: 9a11db68872055e6ead919bad04d6330851c522d

