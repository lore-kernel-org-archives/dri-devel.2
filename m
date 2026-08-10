Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B58C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB7D210E83C;
	Mon, 10 Aug 2026 13:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w8252crd";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B3110E839;
 Mon, 10 Aug 2026 13:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmHwZkWGTHSdDyq6z97qCM/lZaHgn+lRQCu3vs6wqURJ66D8sya9KLdvwR89uVIii9lrHLXDkcuUuBHYV32UPKzibVcVVeVhepscgEyqpgBEhmQn6v8Ecl7m6cl39XXzrxGlxoQvNuXAnrqx1iXnt+5nNRV18nX1gYbZjBDDkZnUNXGUFTMAwFaDfSEUQuE+xGWkesfwH3CwngoicOLiLdLqe0j4BHK4lxZpLk5ISuP1/Qysne7bXermVRGhh4+7YnK6PLoZTeADSAulB6aqAR3K7QnVM8iFFbskoHaUqRAxg7uRkSSLmhUd/72TBHBuuVAIMdudytyh/oeN8k+pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkvAqeQUdI1clSphkC6gkNe2pKCMeu3dHJPH6D3YhN0=;
 b=DCKNJnn59edSpVPorPIuUwRn4D1VykZAhoOirtIpRA6tPJwtNyouixaYYvlieD0S3Z9Dop52D2Ol6bidyTop04Iq9HXFRx+DZXdxD8jNz63e0BCEJhf5NRLJKopNrBz1wfVRdbxq4ckMr7p2NrbkzjE61CGSqLP9fAI1HZCE+tvLIFHZd7aDZfPwpD8tNWp8gWXR1rUt23xM/3qNHJOWV5Wzbp0w3nr/J1OWPAwAOBykwrsGHudGymvSFTEGsYbui4W4KdaL/s7CwckqqJNyxn2p2i0Iq+uEuS+x7ciQ22+VSBemtMsPbKuQEO+PhFTcIO+1LPv/Q2hAGv9i77DMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkvAqeQUdI1clSphkC6gkNe2pKCMeu3dHJPH6D3YhN0=;
 b=w8252crdz3I1qtTk6/NIoDv2UjAK8GCuH496YEolykFiks+u+Po47ByFqD5wx7Q6qhhNh7eBSzlVgt2yBAm4GUUpMKTNyPmIYONViT/C3qsdv9YL2dK4wDA+2G9/5yrvYJeTzkXyyDYomG4GFYq+4qhz28YaSlNIVAJV/IeH3pY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:04:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:04:56 +0000
Message-ID: <bbdeba76-a655-490e-8b5e-1e17f5f2bf43@amd.com>
Date: Mon, 10 Aug 2026 15:04:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix GTT manager warning message
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260808121745.72691-1-kmehltretter@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260808121745.72691-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0434.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fd9013-dfd9-4918-517b-08def6dff9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vmtDNZ+wQX8JhllFgQNLNUKZK3nMsgtGl1xbogSUdtuzzqjq2nG0yHA4nmYNvABIaZXJCa7l6aI/TxrBxKOyXnOr0eAFbyFgyjUIWg9eWkpUlNKcDi7r1R1yA0BeZBH6CfeVymDJ0TL9b34hoyvGPhM1cisAKp9bopfXvHfdI2iSk0kUbZ5oKugChooNgf2IaCQhqofMmCZ7Uej8Tw3NKeKDlYunVMzQFYlhN8rKu+Ke9MmyLlAezXHMVvFRN98p/8DArRVxrLYpCMeDWvOn7GQkA7Ae1q97ENOeVIZOisUJouWXyX6q06/EFKfW3rQzQyT8vd4U7I95klDtlbMCfELaO9c4Xqj5AtHEV5piNL99QFnDlgeUouanIOqoqEN2eeWSUGlSiycSDxChZl6Ver69TG40iTLD0Br0fVsOgu3LV/o+y9W3z7vy7Bi1Dnk6u6j2g1f/eFgI4yfeMn9n+TACuc/bzQUuoMGOdVLPrX8vA32CfGmeP9fIHpphL91RnLkEcYjAp2vRrqSGe0a+3Dct/0PZljfnWCjcCOITPkOnPOtf1ZXkIeSo3IQcAInwJ90xeaMqzgjop7oUHbPZ5ZMXZlYgnOLfkuHdVo34pZq3XR+4f+6EmUVGXFaDlNccZkuzecgB/+4PRYvhEgQmTj20afcXt5n3GWy72hik0po=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGV2TkgzeUZMR0RQWWNMT2tUYVdHK01YNHJjdGlxb1ViU0ozYnVSaXp4SkNk?=
 =?utf-8?B?TFk1a2kwQWpMUDBRQ090WDFSSStLQnZzQ3NNeFgxeW9rWElQTXNhTWh5UXU4?=
 =?utf-8?B?Z0lYRmhlc3EweVJNWDNXRlJqZ3hjdTZ0L21Va2libTlDR29peWdZUEkrNFZ3?=
 =?utf-8?B?emU0TXAxYnJuQThaMis2V21SK292VEN6SG9kNlBzeG9KSFR3TldQRVpPYVdN?=
 =?utf-8?B?dktxQW8wMm50Z2MyYkRINkRIMmQ5ZkEzdHluMEVmRXE3NlU3YVVhd0Irbi9Y?=
 =?utf-8?B?QUZUM3BScHEvaUdxREhrK3ArU0hpSExFWWZ1NWtJQStYK3V2WXdTNkZDTTUw?=
 =?utf-8?B?c0kyTkNVOTJXNUxTUm05OFF6STRRNlpmYUlUZVd0UlptZDQzanQxc1dTWlRY?=
 =?utf-8?B?WnI0TTZDUU94RGd3L1BIeFUxMzhiZy9RRFVreEd6bU5Nb0dkSHRJR2FFam9C?=
 =?utf-8?B?VjFRcmZ0VVhROXpSbGRMRVlEOWRkNnhhejUzaW05QXhYQ1BIT2hFbTJQcFUy?=
 =?utf-8?B?QjF2aHFhK1B2L1VWRGtGTXl6M2RybUg1eWd5T05JQW5YZXh4UkRzNFRuSldO?=
 =?utf-8?B?WElldnM3VWNtSXhFZTZRdUdJYTlibXl4UmpFV3NhbUlYOGJQN3VNcnQ5VHlF?=
 =?utf-8?B?Z0xMa3owSlY5c3I2Y1czUUFmNjhKc2V4dVlaSzU0MmdRWjhMSlY4bjB6R0xT?=
 =?utf-8?B?R0t0S1pzVndaUThZdmw5NEszaW1PNkNrVzV1cXVReUZkb2xHQkpUVTZWc3Zn?=
 =?utf-8?B?VEJkVmZyUFNEdEZ2cEJjQzdNYzJnd2hvbS9JbnFTbzdHSXg4K3hOWjB3eDRN?=
 =?utf-8?B?bDIzUWp5bExMVmhGUUt5eFRvR3ZZYTBEUDBQTGtvMWRpcU9Gb1VJUVlzWnpn?=
 =?utf-8?B?bE1GWHJpYjZtcXBNdmE4M2hNWnFMQldyOERXM2FVblphblhSeG8rUjhkU3BD?=
 =?utf-8?B?OEZ2RjdPVlMzQlNiSG9zQnRVSlFtMDlheU5VN094aUcwLzJubTJsdW1MWjB6?=
 =?utf-8?B?VjNmcnJBdFlCRlc0MndnZjlQVE1ZT2xaRW1rbTB6NnRhUytBOERFdXpZSG5h?=
 =?utf-8?B?L2FZTUlaYzdRVnZQY1I4dExXWUZHbmg2MlRpMnVjZHZUVlJoMTlkQmtYV3Rm?=
 =?utf-8?B?VXhCNHpyTjByeCtnRkNJS3EzcnNZSHNzK3FXamR0UWdMZkV2Rlh1QWFFdk9J?=
 =?utf-8?B?T01MUHRxYWZiM0NpUnBPRjVrK1l5eGpVUVdZWloxcnpsUit4MUNISWZ6YW9J?=
 =?utf-8?B?bkpFcDB5ZkxybWhMdmdSU3h4dWEwenV6Nkg3b1F5NFI0aWgyTDZtcVUyL1FO?=
 =?utf-8?B?emVoU0ppa3F2c2gwYk9sQXdDVjlkZzYxU3RMZ0ZteDcyVmZjQVI0Mi96Rjhq?=
 =?utf-8?B?a0gwdzkyL1VRVkdkR0ZRenA2bUN3dUVPaEM2bk80UnVKTDBjUCt3akxsb3hr?=
 =?utf-8?B?VzdmR21BTDllSmxtQ3lGYTVxb0w2d3BMK0ZiN0djN0xHYXJyUmZqSUNLckhC?=
 =?utf-8?B?NFR6TlJTSUpCWURFV2cvMkVCb0lhcVlKb0tjZFVTdFlZZldEZnVlY2V6M01S?=
 =?utf-8?B?UkZoaHlMS1RwOFVJTllBT1lkZ1JiZjVTVzJKM053UUxPWlhzdUFaengyZUFl?=
 =?utf-8?B?SVVmNkdLUXJ3MUxDRVppemZuY3ZSZHdUc09wS05QMXR1RENIMzNDRHM2T3VV?=
 =?utf-8?B?SmMwUktNdGlIdWhmZUJNcnhYbE1ybjRrWk1kamtDVG83clRkMVlpV1cvK2M2?=
 =?utf-8?B?ZEd1eVM4bVF5WlBYazhOWGw1VHA3WWU1QkRjdFlUNjE5elVWTGNES09zRmR1?=
 =?utf-8?B?MzhkN3Y5UlBGbkdSYXJUNWhVdXR2VUU2MTBoWHFObVRpd09KZ04yYkhGcS9F?=
 =?utf-8?B?aGZUZDRHbXNyTUg3M1R3ZlAxbm1XUGdjWHJXOVUzMHY3eVhkYkkwRVdrZ25u?=
 =?utf-8?B?cHk3UVlvZDlYcy9rdTAveHdMV3R5eXZYVEVpSExyUENkZVhidCt6TS9rOEFF?=
 =?utf-8?B?TGdqSDFkL0QybE5USENxb3JZL0tyYjdnTVY4aWdnZFdHTGNQUmJLT1JmcklZ?=
 =?utf-8?B?aWczM0lySWlibi9KY0tIS1Z4UlhZd3BtM3RTZCtNL2NEN000SG5TK0pLYm9t?=
 =?utf-8?B?N25uUUxQTFdKcDIzUmk1TXRJUytkQ2JzbGYzc0RNdDdGOFJmTW9kYnNxcXNl?=
 =?utf-8?B?WHc3NDhWTU9jUm9tdm0yTEgyeUNGN1lNQnRhN1hhc0kxSkMvakswL0RFR1BS?=
 =?utf-8?B?bWVnUjdwdmhsWjhPaTFsajJydGlINUFaSE04MEhEd05MNUNoWWdma2JtbDVw?=
 =?utf-8?Q?SgfsNULOQbuj6pAWEr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fd9013-dfd9-4918-517b-08def6dff9be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:04:56.2969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9wYXf+HiACoU+cwa5p2hwjSFvscKmO11dv3HvYR/FVzN5esACmjf2x3mq2fCpZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505
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



On 8/8/26 14:17, Karl Mehltretter wrote:
> [Sie erhalten nicht häufig E-Mails von kmehltretter@gmail.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> WARN_ON_ONCE() takes a condition, not a message. The string literal is
> always true, so the warning still triggers but the message is never
> printed.
> 
> Use WARN_ONCE(1, ...) instead to print the message and keep the
> once-only behavior.
> 
> Found with a Coccinelle script. Clang's -Wstring-conversion also flags
> such calls but is not enabled in kernel builds.
> 
> Fixes: 7554886daa31 ("drm/amdgpu: Fix size validation for non-exclusive domains (v4)")
> Assisted-by: Claude:claude-fable-5 coccinelle
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index f98bfba59a2c..f2ea881d39e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -565,7 +565,8 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
> 
>         if (!man) {
>                 if (domain & AMDGPU_GEM_DOMAIN_GTT)
> -                       WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
> +                       WARN_ONCE(1,
> +                                 "GTT domain requested but GTT mem manager uninitialized");

As far as I can see that warning is completely superfluous to begin with.

GTT is mandatory to load the FW so we can't enter this without any GTT manager.

Regards,
Christian.

>                 return false;
>         }
> 
> --
> 2.39.5 (Apple Git-154)
> 

