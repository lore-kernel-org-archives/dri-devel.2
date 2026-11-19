Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E7606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K4KNmgkd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1EA910EC04;
	Thu, 19 Nov 2026 06:26:29 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E6F10EC04
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 06:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QF09JE2X315WTZ+/8CJEprTb5z8zAo1FjbsS5/RqpJcCiB9hf59jZUcI6yFrYtEh1YvG3yuKSBdNG/tO36CQvwiI8UH6jKYYpZLzcwu7gbUpuIOjZ4lTQU52kyCOovOui7GaHC0hG5m2fipNMAgNmxQkRcJ2vOsrhVS15+S+gBEBSJkREsRJCorvbuj5vCFkK2dGjCccqw1CIjEqpzyRjc664qb6p+I71fpGwCyzxz/4RsOPKUEuBUNBWUr6m8QMwjQ5zKTS8Y7GlrCBF7X2VMIJkDi9IHF2RGP3YC7QsZVZ7FDauUfnZow0iUkvgFd0L+oCwuKfDbciumJjFYf2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nCZp8wV098Ir+sF1wHyLenahVu9oYqiVw2++XUYIqM=;
 b=fsg0IE22coQI3mZXFbshBBGc5Hz6eCgrBtTg0VfRQvhxnq3xYdcQt18cSedmEahhYXMu9LRJoQrAi5DZdixhclhYY6kVHPtJXSaxHaRL3+96eU7GzWjvry67amZW9Wg7fPJa1gXLvjXndiTITSI/J6J7zTCu3VlzdTRSiwy5sKvkYtctgoQNkI6//bFCXl1xRkP2fAD4lx+tT8rsFljRGXgS4jvPDQegQX7E1tWGBVIp9af2WrfMtn8bz5W/wrBQOxd3gYCljJHnAhJLM6KI+breNvpP83lpLVHDMAzXR1cIVTwiAXlHDEv3U2rlAeSC43miZahhBUTOIQrQUaRNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nCZp8wV098Ir+sF1wHyLenahVu9oYqiVw2++XUYIqM=;
 b=K4KNmgkdTAb5HK2VDmGtnRbQHN/4Yksq4taBDX16PiBftHE27iN8+YEagnY//vehe2W+FBkeHOvcOwHqhq9tGjnJNyBLrVwR+XJ59KYdJ82YTj9nQCle0k0Cl2MXYP/x3l+ElhDH7P1dvGdEr7EpBv+1hnzs8L7nKTUBOcEVYoprK7FvvwobE0TjVsFfupr3l4jjOSu4BW4YvuulsoDTQnr4yoCypP9zW0skrSIY9LvvJSno25qKdImT2pjnoZOR2FdFOx9ymgOd+cdh7bwMYwTX67qyIx3Rbh53+JNAQzGtq2lD8jk3o2Edy8uAgRT/CgTui2myxAKuygrhKHrUqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PPF8CAB220A1.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 06:26:18 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 06:26:18 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, linux-media@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Karl Mehltretter <kmehltretter@gmail.com>
Subject: Re: [PATCH v2] drm/tegra: Fix dma-buf reference on import errors
Date: Thu, 19 Nov 2026 15:26:15 +0900
Message-ID: <1IgFo7YmReCFJ-7dn7J0mw@nvidia.com>
In-Reply-To: <20261031104439.91346-1-kmehltretter@gmail.com>
References: <20261031104439.91346-1-kmehltretter@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PPF8CAB220A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f4acbf-2717-484a-56f4-08df46060561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|10070799003|23010399003|11063799006|56012099006|261022075727099003|261009223027099003|10067099003|261022105027099003|261021123027099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: g91NYkqAoig1X+sYT6wmIrPhapGpRnniL/LX40k8b7XoSDxF9KW0ohGlZpkSZ1PIvyat3R8SezPBqOOvz1rsM1byKAE/bpTICN6lMDOLl5+/PY+5H/2Gbfw+fcwZaLWT1ZPVb79CWl9N7TnDVHsksGmJVCDtQJeFSfWVrxeUL9kst8ooAZxb1tdTu3p4Scsef0U+sSIXoKcWHzTrGLh8Ruljzp5Aj4/jcm2pBE+akEBT88HcLTCv2S5Svan3OZeEny+N1Xm1DW9SENOf6Hq4Whp53Ncri1xA456Wm04xWOdRY99epd2XMydFa/6ddkeJNX6dirvc+VGj1JHe4II8469sj+GyiFmPnPVBR+SnDa30gfX7rx70eH8Tcbxa2sYJOSgDgSaWBp5axRuhobtBIy1bwcuawLsRrj984WPNfA81Q1xZNyDic6ajsvNqozoQFherwmBv+0prU//uvbxi/E0jUHaF0O/B0s5TYY0fXMiyt20FzQhkSbpTucjqsfCLfhsUQQw9YuQq67V3gid+Q8644cYYd46yOk64mTOPPHqIBi22GhNS8aLPHfHDUb2ua6w46tERMOZ5DyhIXCAuNXFevOiWPXkWoNBWftMOvgmKbfw5XqQV6G3UxXuseKI32YW5IQ6E/9VJKEvbXAdBEYas1HqEILN83RheyZiSlTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(23010399003)(11063799006)(56012099006)(261022075727099003)(261009223027099003)(10067099003)(261022105027099003)(261021123027099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHR1a3d1OXNUWk5oQUg3VU1qMmZzekxuNW5DQlpOWFJYUm1HRmVHbUQ3TEZs?=
 =?utf-8?B?SE5hOUNIZkp1MVl4RW10c0RXQ3BjcWtlbTEzMkc5L1Zlc3FaY2M1aDlOckd6?=
 =?utf-8?B?cm5zdUdSZVJoWFFtUjJYMzVpOWFBUnZrbHYvdTQxMk9mU2VYbElCakpxcXR0?=
 =?utf-8?B?T0V4Q25Hcnl3T2lsZlpmZVhIbzVLUTdURUF6Qkl1OGdST0xJaXpncVpDUmg1?=
 =?utf-8?B?QmxtbHBqQmlyN3YyNjdrYk9yOStNSkhrQ2tqUml6Z3g1VUdtVE40eWRhTWdD?=
 =?utf-8?B?eCtnazZSa1VHUTVUM1ZvRlgwQmlVeDVnV1R6ZkZpbzFDWENLNFUwN1NjZzNv?=
 =?utf-8?B?UUh1YmY5SjArK0JGWGEveFpWOHBoc3FMS0tZQnUySktFTVFQMUJpRENYc0VU?=
 =?utf-8?B?TEU5K0F0THorSTVMTWo2R09SMlpzRGZiQjV4NmJ0UitvbzlvUXdOVGVzNytt?=
 =?utf-8?B?eUhjMUdOMjlSdVNVbGU3UGhNTXNpZFRBWnVaYmdvelFZem1zSmpLLzRSbisr?=
 =?utf-8?B?OE5oNmFpb1VSY3dJekR0WDVuNXZRWW9uL3htZXhQNFhTQzNMN0NRMHQ4Smg3?=
 =?utf-8?B?L3ZYWld1Rk5hNDRyTHZlYytxTW1RczZNYmpxS1JxUllEWndsSmJ5bkI3a09G?=
 =?utf-8?B?MTM3VE5La2YvY1Q1VmtzVGtwN3BLd1J0dHFaVVpzVE9ERG90QmVmTjNDTmZK?=
 =?utf-8?B?UkVvUGxvbzBPWjh4M3JDVUM3MDRTUllQSWRiY3kxKzNWbVNKM3R2TnhXcUZV?=
 =?utf-8?B?QUk0K3RIb0hRc1NRa3B5dEhFb3d4NDhKT1Q1MS9YM2RhYys2SGZGMlU3RGND?=
 =?utf-8?B?YlUyZVFWcmlmVy8vMDNyNGJ0cUhZNGh4NWRpazZNVWxBeGRmczJkUHRpVXJT?=
 =?utf-8?B?YWpacXF4bnhaWjRoTVRJdm56UW5yU2taaStKL2haSW5aaTNNQU9LZjhDVmFT?=
 =?utf-8?B?T3VzT1VZQ0oxS3U1NkxHYnZka1NGbXp4QUZLUkR2eUlFMVFVQnNhSHBLOFJX?=
 =?utf-8?B?WHJIazFrNFdlWGcwaFJOUEZYS3hZYktuTXVlV1EySUFXQ2FyWHhFSG9nMnJt?=
 =?utf-8?B?cVUwYkJZclRmaGZOaE1vU3FNMnZkYUY2Z2ZaS2Q0Q2c5RGpDcngxdGZVSUhq?=
 =?utf-8?B?QnJOWmtHckJGd1JmUjQra1M3bU9CSzFoNUE3UUZobXc0UDBFa0o3YU43K05w?=
 =?utf-8?B?WldXVTM4SS83eGVha1o4MmM0bEJGLzZBZFZDME9MazlQc3RVMjVPSDN6Ym5Q?=
 =?utf-8?B?M3BiTVV1WTU4S0hmNzVkOUlDVzdWdkpWYnZRNVFaODZUZ1FTZnRaeWl6eFBj?=
 =?utf-8?B?YjkvTGF5bFNsUlZnZnNOUHRPOFlFRXorSlFsMnJvY1ZLQ1o1eWNIMWVRVWtL?=
 =?utf-8?B?QTBudGxyMzJBVkI2VVdCNTFLdlZzbHNCdHlVc3BVejVWR09uRVVoNG1HZUJy?=
 =?utf-8?B?dkdrMURMeVlTeWRqMWxMSTlZU0RqK1VQQzBySXYzZXQ2ejF1RUZNV1BvZTQ2?=
 =?utf-8?B?bDdKdW5aS1N1UEwvcGhpbkFINXBVTnk1WmwzVng2L20xWHlXdE80d200cXVL?=
 =?utf-8?B?MXNtczRhSko3K2VSZitaMi9zV3ZCUXJUdG0yNlRWRlJTU2J6UjlZVEo5V3NX?=
 =?utf-8?B?cHI5VTI3WHlRM0xub1pOSmMrbGQ3Y1dGQkFiNUkxMWsyUWY0TEg1ekwydlNE?=
 =?utf-8?B?RTZuRFZWQ1hEUlM3cThYWDFFZEIwWjJza3piQmFHdTYxVHphaEJ2RDZTZmVB?=
 =?utf-8?B?Q2JXLzd5U25UbTRRdDVKY05sVEkyb28zQXRsSUdMaStwN25xd2RhRlBKY1I4?=
 =?utf-8?B?V0xteWd0MmVKLzFnSFk0dzJVWm41QnRBbnBaUW52Y3hheU5aSjhzUXowRDZu?=
 =?utf-8?B?aDU2WUgvODg1bEg2VDY3TmZOVXB3UWNiUFZkK0tIUnlqMXFiSklpRitoU1VI?=
 =?utf-8?B?eHArdk9NZ3paU3FtdEV1SWNNeUtXMk9tZiszdGpINFpDZDJiaHZzcTN6N29F?=
 =?utf-8?B?YTBsbTYwNXJ3eE40dC83QWpLQ3N0RUNvQWxCQmoyTlcwTlVUZnhNczdVc1hz?=
 =?utf-8?B?VUFEWWdOWlZrOWZWRkc0bzg0T2tjZE1mT3o4SG9hYllxWEk5dUpFaGxTRUt1?=
 =?utf-8?B?SE5WaGsyZi96blJGSlVlK3R0dVpjODIycm1CVEUxWmFYZ3c4TllIcEZMcy9y?=
 =?utf-8?B?c3VDVWVpRGxwREx5b3JOMmc1VkQzZHdVN1ZuYUpzY1RRZ2pkYTkwTTZjcmJh?=
 =?utf-8?B?WGphSlMyQzc0bnR2OFBJa1pzLzlENDVrS0RKZzJjYW80RnNJT3BKYU03YWFs?=
 =?utf-8?B?ZWNXSHZNWnZQZWY3U2ZhWVYydnZ0QURwWUg2WWsrNnkyYTJ3bmprQjhNQS9P?=
 =?utf-8?Q?+QMinudUMYtjj4QdoeqUShQCHgrcxFWsfgakyXLpHrPTJ?=
X-MS-Exchange-AntiSpam-MessageData-1: 3ftHwHvu+zYkWw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f4acbf-2717-484a-56f4-08df46060561
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 06:26:18.6481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGSL0JQ0INhl6UqEdMJBzAU0D98vEhex7WVWSz/VAPzTvqadRDNtB2aqJ5oaXk8H/XpF5k+DKWbZSDsrs5vd4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8CAB220A1
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Saturday, October 31, 2026 7:44=E2=80=AFPM Karl Mehltretter wrote:
> tegra_bo_import() takes its own dma-buf reference only on success, but if
> mapping fails, its detach error path still calls dma_buf_put(). That drop=
s
> the reference held by the PRIME caller, which then puts it again, and can
> release the dma-buf file while its descriptor is still installed:
>=20
>   VFS: Close: file count is 0 (f_op=3Ddma_buf_fops)
>=20
> Remove the unmatched put.
>=20
> Fixes: f5b8794e17e4 ("drm/tegra: gem: Don't attach dma-bufs when not need=
ed")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> v2: Clean up the commit message (Mikko). No code change.
> v1: https://lore.kernel.org/r/20261026055842.96484-1-kmehltretter@gmail.c=
om/
>=20
> Tested on a Jetson Nano (p3450-0000) with CONFIG_DMABUF_DEBUG=3Dy and a l=
ocal
> change that rejects zero-byte IOMMU mappings to force the error path. Wit=
hout
> this patch the forced failure produced the warning above. With it, 100
> consecutive failures returned -EINVAL, kept the original dma-buf fd and l=
eft
> no dma-buf objects.
>=20
>  drivers/gpu/drm/tegra/gem.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> index f76af73..ed35a34 100644
> --- a/drivers/gpu/drm/tegra/gem.c
> +++ b/drivers/gpu/drm/tegra/gem.c
> @@ -502,7 +502,6 @@ detach:
>  		dma_buf_unmap_attachment_unlocked(attach, bo->sgt, DMA_TO_DEVICE);
> =20
>  	dma_buf_detach(buf, attach);
> -	dma_buf_put(buf);
>  free:
>  	drm_gem_object_release(&bo->gem);
>  	kfree(bo);
>=20
> base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
> --=20
> 2.39.5 (Apple Git-154)
>=20
>=20

Thank you

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



