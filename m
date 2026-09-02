Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7CDC61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B817410F0BD;
	Wed,  2 Sep 2026 08:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oPI9JuYx";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011003.outbound.protection.outlook.com
 [40.93.194.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1F810F0BD
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 08:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfal0l3NiESThs1PILCwWA/XgL+Z92BBs8BjdfIEXa6Cc9demsUCtovMnqB/6ECOLqohokIic+AiYXC2fJctlhqYo+CZUaIGGzLXMKyJ08PZBtFD5WkjPSkPP7lGIhzV4AXok1ancpg0C7o7bUoYITIkkRc2Yx5+b2sI4xglcMSQQMz4A18BhM8wWraGnnbGbGELqZ7lkJUdiacj6sRjmZv4TqfnC+lAAuGDhKYDpVBVO4q641Nc5PbQ4UORxVC9kJrDmaZiBDv9TtfpBtyS182I5r+LvHu/xaL8NkgYYGcpzfNPcIgYVwpja5PV+bcsEEFHmk3TGFtqYTpBdIWIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjvECUsSrquvbHNmE0kdgnsSjIkv8cm5j6ga58trHoQ=;
 b=FseTZZvuGivEas1pbuGlJ8GVaGCllK24vzNf5nFk79rVQvu1MdbC3DQGh/Y0FzYflRHqtbcdib9hCar1wJsKx6dBE2gTXA+yonvltYm/Qn8E65W5/V5WENoQDLKdcZfYo8Jc4rKC5gesbGruFZyvciieoj2LAKxQFOtaN8zbanb/716Uf8V4KIHTI8DBJ7NjFHvtWE9mtzozAmfwGHKCOfDH4VOsn7kJ76MWq99iyKx2Ifi692qtVsyu/3KjdMI49qdVuKhhw5pY8fhOh1ZihVa8XOVbDInUvAmJj0vZqVKr+7v+q71EcXU2nDs8hwvdphwvyCOdYTgzp1dWzdsE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjvECUsSrquvbHNmE0kdgnsSjIkv8cm5j6ga58trHoQ=;
 b=oPI9JuYxVMp4AX/sDnDEkeD9VK8q6LtkBVgxHDrbzSfuSA30muv530RLTe9xnP0EmDEX2vaJrP/ucyZEEYZ6iVdFHbSlOfgwApglzCHW+66bNKFNrmVUkyFvHUcWtS8TW7xpXLywhH40sguBNJLRI64wVdVZejvJPRBJuZ4LhxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB707735.namprd12.prod.outlook.com (2603:10b6:408:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:52:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 08:52:28 +0000
Message-ID: <06f2207d-b5eb-4507-a7b7-c88cd8923e43@amd.com>
Date: Wed, 2 Sep 2026 10:52:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: fix comment in dma_buf_llseek to match
 implementation
To: Haojie Li <lihaojie@kylinos.cn>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260825064041.328640-1-lihaojie@kylinos.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260825064041.328640-1-lihaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0053.namprd15.prod.outlook.com
 (2603:10b6:208:237::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB707735:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0eb46b-0180-4b8e-bc54-08df08cf8411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5AF/w2uUnQ6uOILsOIBlU8j/K+cQGXIFNGkR/CB/PXLxWIi3VORRQPygDKbFobRcLo5hZe+tfXXo7OmyK3heNNXSKQ9Iv1solotGm3scU2+Pv5Aihhc6BW/oSdShy5KWpE2PvPEzLxUACJ+CDarjFZzblLRcCGA/g+6YjnfKA9SCQJSsDtCfK7CjZeM4wb/8qntzD2ZUlJP8ZBIVPCX9F7C9n4MzMcNdDw42WpQfE8dtFAhk3YLtObmBS8zSQeQwWIAM56L8u6a4fLJHwj+xMHreQ50AVHy2DHNhEbLpFtHEWMpVszHGXbs2dg2sxpPkcFRjDbpt0w4TnO6xLsxTDoe0Cktplr3KmmXEk/776WK4lwcVIRS3ECdJ44w2VT8aPZQQ07Wdr86ALZsu+ZSfAcDdQElwFb0ZM6zSPGFHp+YimIZchFiuT95WihuUJW2DLWnz8PhiHtTwlacIQxmX1zM/VPECi5n6JYXHfknqAXcMsuUEWNuVr/ytO1mWqOKlVe7OqAputyIvNu+t01Yc0XJCMlRF9S59urCMajudB9pSfAwMGTzJ7gT0M29Cnduav04auPVCVU/QVMUfZ1I7pS4TiiaEeiP8uu+23Byf2BZePPqkKLT078jR7ZlMs8iUqDUZ2pNvJQKG4CzGEM+RZqTo6s5cxAElSgJ0QXaN7L4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFY1SC9JK09FQzg0ejhUTlYxSHJ2cTQrNEpVQy94cG9xRFpKdnh4NjcyN1hK?=
 =?utf-8?B?UUE0dk04a3UrWUJvQW11QlBDcDF3OHVGa2Y2aHg0YUtWZDBsbkxaSENobHVB?=
 =?utf-8?B?NE4yRGJPL1dRK3RXSkFJRFJLbEc1ZVpVUS9zZHdHclgrZTlMU2tOc0hjdnpC?=
 =?utf-8?B?U3lZZEltY3hZVnlxVFFaTGhnVTcxMlR6Sm9CeFk2YW5vWlhaYmdoWFRCbHNx?=
 =?utf-8?B?NTZZdlZVa1daamEwalNidnpYdDJhTkN2eTdHNCsyV0xncFladU5YSkFtSUlT?=
 =?utf-8?B?SjViMHJmQ3JqZVBuTFNkejB4Rmh6QTNOYWZ0RnJHUG55ZmNjWEVFYkY3aE1M?=
 =?utf-8?B?WU5GSzI5MzgyVXB2SW4xdk1mT1NRendUQ1drZUVqeWtVbWNGWXJsMFN4b1Ba?=
 =?utf-8?B?TGlkRUMvWnF0bS9rQzBkL3lkenlRcDY5QXZyYW5sa0c0UC9EbWJHOEt3MEdn?=
 =?utf-8?B?bW1SQVk3OWU5bHdyVXBPRGpLbGZ3ZFR6REZpeGtCT2dxa2EwUGtGZUxwQVl6?=
 =?utf-8?B?NzhvMHJyMzlyZnlGYmJwWUtDMC9MbGlsbExZamZVTUFZWTZkZndiY2g3YUZB?=
 =?utf-8?B?Ni94Mlk5NXpUM3FHM1BPTUlDUEJoN3hINkIwSDM3SGtIZm41anBvZzRLRVRo?=
 =?utf-8?B?N2l4d2lwKzJ0T2JndXEyaERCMWpRd1dQT2kwNXRrWVlQYlgvTEd2L2lzcVFP?=
 =?utf-8?B?STNrVW9ncDhURWdRQlFGZUYyMmxYOTBWa09iUG5EZHFiMWM2RnBFaWFMVDBM?=
 =?utf-8?B?bmIxU0pRdm5ZWmM1a29vZlFZM3BkTlcrakJ3Zk4vNFJOclNSdGcrbVl6ZFB5?=
 =?utf-8?B?VlNZRjJCTVNTM2pDUXJFU01KQnJvbFdSM0VLRkJxYi9TMU84cDBpdTZGb3d3?=
 =?utf-8?B?eWkzaHZWbnZQWlBSb2ZIeUc2amxVenFoOWhVMU1SVHRLSndxNXdrUEovazhW?=
 =?utf-8?B?UlI4MTVEMUtYTWY2Ym55bzY3dG90cm91SmVvNEk4bVlaMG9BaTNSZE9tNWg4?=
 =?utf-8?B?dzVVL3JNa09FUDhXbmhtdEhPRWdEZmxQVko1N1hPOHVaTzBWUG1HVktXNnpV?=
 =?utf-8?B?M0dZVzhaelVUTnl5OGZBdWJJYlllUHFuc0hFWXczRDliRmVtajdSQldWdXVX?=
 =?utf-8?B?RkxMaUVRYzAwOEc1ZFVuS3JiendaZVRNcUMxaVc3TmhrS1pQem9XYjhZeklF?=
 =?utf-8?B?SDVpbmc2bUNJYzRJcUdYRzdCVkFqemhCQmVjQWdFMkI3NWdWZGZGT29UdFZW?=
 =?utf-8?B?WW5NaGRDYmI4c2gyTVIrVzlWZ1dMTW5GU1YzWWVXK0RSUDlYMHdpcDdjOXZ3?=
 =?utf-8?B?dG05Q1hlQ3k0eWIxTmh6cmN2WkdGcjlJaXhKdVprQVArWGg4ZWgxVllCeFZv?=
 =?utf-8?B?UW50ckFPVmx5ZGdFNHRFZElDRGFiMndRODQwWFlTWlM4N0ovWjBjLzRjS0xt?=
 =?utf-8?B?REhuaTY2VDQ1YlJHSTVmRzBiMVYxdFVjRGY0QWJLSGdPY1JMNlpiNlJJckt5?=
 =?utf-8?B?ZHoyUkFqZGg5dEZISkhjWGFmOEtHZkQwaExGNitiMktVTUxycVlpcjZaVTUx?=
 =?utf-8?B?aDNUUVRPM0UxN3kzQm10WnVIK3Bkd090OVpwL0ROem84WVA3YldZYWZ0OGQr?=
 =?utf-8?B?em1QZ0d3b0c3SmpLSlNmNU16RnF2emU2cWEyYU1ST1BTcjAzMk9GQ21MRG4y?=
 =?utf-8?B?aTF5RmdEV1l6V09SSFhDU0JNS041ajViSytUYkNvaUlWUGljeU12UXlQN0Rm?=
 =?utf-8?B?dFBIeGEzUlJQYnNUeis3cEE1YURBMmJ1ZTUzclpWUHBlRE5NcWhBUTBKb0tk?=
 =?utf-8?B?Y3ZraHBoVHZmektCRTlDMys4OWNkTTFhS1lVOFBGTi80Q29Bc2lkOVZIYThX?=
 =?utf-8?B?Q0VvVjhDTkJTMUlKNUtVSytjM2RneUtVQmhaSUdoVGN4RUFibXlsSWVMdHMw?=
 =?utf-8?B?NTBaME4wOTk4bGlPSThjYzhzektYUTBuUUNjMlhvUCtsNDFsRFk0K1VPMGVa?=
 =?utf-8?B?WUFxUnhreWdpQ0s3U1RWeVgrUkRQSFAvQUsvMEdVMEJPbWRwdGd0UzB5d0Vh?=
 =?utf-8?B?Q1VOZVpvUEtxeXlGQ0dHTng3REllbi9SR01URjN4Y2VuRFd0VUhCYytpVlBJ?=
 =?utf-8?B?T0VwYVJ6SmszQ0xpYjFVWFlXMkZ3d1Y4ajdQcGZ4UVVudk9jNzVRQnp4YTZv?=
 =?utf-8?B?cXl4YzI5anBidnhTN1BDWCtGWnBCYXpydEUxWHdKdjJLQkZtbFNNejVlR0dY?=
 =?utf-8?B?YmVKRm9UOThXYSsySms4eldZNXZHWTJuZjBpVEFRRFVNRmFOWHJ2dWk5dU5Z?=
 =?utf-8?Q?76oQ6eljVNZe+ryEEY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0eb46b-0180-4b8e-bc54-08df08cf8411
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:52:28.0093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dk6NVlKLun6KZPOM4mN+pVR+KwCFm+pxzrwVWSoHZmZmwTTqrYGPBo5ZSV61PNDO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB707735
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

On 8/25/26 08:40, Haojie Li wrote:
> The comment in dma_buf_llseek() referenced a "SEEK_END(0), SEEK_CUR(0)
> pattern", but the implementation does not support SEEK_CUR - it only
> handles SEEK_END and SEEK_SET, returning -EINVAL for anything else.
> 
> Replace SEEK_CUR with SEEK_SET in the comment so that it accurately
> describes the supported idiomatic pattern.
> 
> Signed-off-by: Haojie Li <lihaojie@kylinos.cn>

Reviewed and pushed to drm-misc-next.

Thanks,
Christian.

> ---
>  drivers/dma-buf/dma-buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc29..60571a2ecc23 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -260,7 +260,7 @@ static loff_t dma_buf_llseek(struct file *file, loff_t offset, int whence)
> 
>         /* only support discovering the end of the buffer,
>          * but also allow SEEK_SET to maintain the idiomatic
> -        * SEEK_END(0), SEEK_CUR(0) pattern.
> +        * SEEK_END(0), SEEK_SET(0) pattern.
>          */
>         if (whence == SEEK_END)
>                 base = dmabuf->size;
> --
> 2.25.1
> 

