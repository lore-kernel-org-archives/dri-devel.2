Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96E606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Q5jGjtGl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C94D10E138;
	Fri, 20 Nov 2026 12:32:48 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011029.outbound.protection.outlook.com
 [40.93.194.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD2510E138
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:32:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPPMLRrDzaPxpiv+G3QGemVjWruF9GZh8nxJ2LuqMTLwtPuTr0HSjAr4WnvoEdtH/m/aouOBhLstBqXNovIMmCtF4grS9HYKWqKfc4XKYgXbDfnaw8iGNLaHm38uxIQa9a3M2Lr9yQ1Yk26g0V3Je4bQaX2TUAfTUG16uI7r190rqW3rGLOR40DLAWMRfIYvxe2V0r5UwotViveG2I3REtVEEaK9+OwXU7JE9Vt9mNsZtLRAhL8y/xUGQfvz0UD2jiNXK5A7NTHBYjrOthXq9h0UQhZ3Y9ugAPPvm6v4MS2mUT3kXAUnzKY/MPs3iuGAclSpg43HljQAiaO4iW7yMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM8zd7mva/7paJ8J9UlH77WsTtA2rrm/e2ObbIB52RA=;
 b=W/PlRnP9/iJLcJf7HVoOj7SsET6GtEf+jOQV0J/cNYrag0V/qnwntM0OJDn7nOVH1le+lkLpr4y7lBgaKTOUVigkv9o/W6p/0Xj4CumIIIxTl5po18PQQSwFIV/SmA70e/V0y88O2ozFb+C6DcBrQtS5+o5rHb9ZtCtm4Dc/Ftc/gI+2T835uS6PX+gC/DzzfEHPE5eTVjorsh+ZpUeT3YCqqhj1YS4+R1za0dAeX0dJz6U0VKfnLX+F7eFuTUVsmKpQvRQ+6/RXkOYTO8mziKdJDeBft3N8dYQlASydKo2tQZ8df2BrGPnk1Y/TNLSfowYOPux1ark/7sOoyBV71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM8zd7mva/7paJ8J9UlH77WsTtA2rrm/e2ObbIB52RA=;
 b=Q5jGjtGlGVcf+g/AOKOSiAA0dBe32LFuvbwWSJ1oVlf6jXyghOJOhR0ZSVbCNWerfAd6AVCAuVCWEDc5ugdbDJbKNDppXz1LgxcPBuIZOdDxoxSha+WygUQ8baR0PCErOnW0zEJoII0A4s1rhAmnAyuO6kAEAOUx3QS0htXgqfQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 12:32:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 12:32:33 +0000
Message-ID: <48d1dd13-9ec6-402f-8a72-ce417f331332@amd.com>
Date: Fri, 20 Nov 2026 13:32:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Reject a zero sized buffer in
 amdxdna_gem_prime_import()
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 mario.limonciello@amd.com, karol.wachowski@linux.intel.com,
 max.zhen@amd.com, linaro-mm-sig@lists.linaro.org
Cc: linux-kernel@vger.kernel.org, sonal.santan@amd.com
References: <20261120023540.888381-1-lizhi.hou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261120023540.888381-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0032.namprd10.prod.outlook.com
 (2603:10b6:208:120::49) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 4846c150-ea42-4305-91ac-08df47025995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|261026121527099003|261021121427099003|261009223027099003|261102123227099003|261102130727099003|10067099003;
X-Microsoft-Antispam-Message-Info: 8PuRhdZa78FEAcKjcON1voiV8afiolppodLfNoI3jdabEaalumLQPiaaDnWd37mOtvXsnjb3UrDSJOCPb5ocDHLPvRmjaBDqDU/593Qd+O7XMdhRWaQ2nmcwBijkuqlFU4afO2uW4rBTg4I5Al6SOdXzIFyBriFLZvO9MppGQhmTb0EFap1aY7cgiRypqnrpYVEI3M+G+z06b0I9umLZeW0jlCO9yVyBoa+9oQ45FgNvT/4kRHWeI7SV8IRyIN7E6qwHIiHTVGNhdoiDbUEOtBfZXlClulne/mukg2PKt2+9R8/nc1diB3kAaqFLRG9pnIVKqYhrx5PznF5MTrNKYtNN2xDiPn8y9Q1aSOMqByZ8Us51TUHUUwKNwfIKUYcG2yRYaam7ViPLzEJhEAjqTUqOIufVtpTDe9iprPoKhYUgafv9lUNaMcF/i/Dm9T43TkCg+iL+lV3VgPvDXyXEoN6YzCwsnE6FLtaTJAJUcGQwD+lokje3GfOjAI+bPv9X0dk90RV6tL1wWRPdmQLIQsBmM+z/HEZwDb+CXtLCfyANO7N2/JP38421vPPpbOouSIUXkznMApBtsWn9CBMehg6Yfe1oIXujEG1KaIOkLqvSBkbdZY47EAjWYpx7W6l4BL0X4lFW/aBUXBlCUqoXVMBDOmExV3xTu/8FwUOW3Q4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261009223027099003)(261102123227099003)(261102130727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmQ3Ry9kQ1poYTlkT2lqNXJMMTJId1V1SGZtV3RJcHplVFkycTBkVmFnLysw?=
 =?utf-8?B?L3V1OUd1dWNCN2YyWi8xcUlvTWNmaTQ2VkQ0NEN4a0NuMG9EeEI4ZWxOODE1?=
 =?utf-8?B?ampoN1NzS0RuMFJXK0hDOHBtd09KdEZCVUlUNjJiUTdnNWJWcGpIWW1kQy9T?=
 =?utf-8?B?QXE0ZzA3WTVHNm9USGhmbnh5WXkwcm1ZamJIVktLQ0lxcjFyY2ljajJ2S0xs?=
 =?utf-8?B?dTN4UjBtZlNYWW40VWdVODdRVU8rUndXTEFpWHJYRmhzOHkxdXhqM05UR29k?=
 =?utf-8?B?YjMrVDZORDNSc2NZTG40N0U1d3NiR09vRDdHMXF5bWxSMlZCbE81OC9kZEZ3?=
 =?utf-8?B?UXgrYlB1Ny8xOFQwMlZJdEt3d0k1Mm5ZTmozaXZ4dHo5RFUxMHdhMW95cXJI?=
 =?utf-8?B?RUhhWFpHQWs2TmtmUTVodTU0RWkwb2dqYWszdityMzA5aW1tUld6U0RFYzh5?=
 =?utf-8?B?K3dqKzYrTmhEYjFIRUJlYmtGUjYzYjV5a2tzbGtqR0pJSUNkL3RlSC9UUU1B?=
 =?utf-8?B?UUpic1FlYlZXSVU1Tzh5N1JHY1dGZDhWY2ZUZWdab3hmeHI3STViTFNjME1p?=
 =?utf-8?B?ZXBBM2FqeVJkVkxHRDRmQXByMHBTVjJXZUxTdVVFU0hsRVpBYXNsR3hmWSs2?=
 =?utf-8?B?TDFVTm9EaU5IQTAwMmQ1bVduVE5BcU9zZStHanNETW5selgraWptU3NlRThK?=
 =?utf-8?B?VnUxZjJWUzc3M0dYUHBqVmhiY3p2dHBGWEJUTXNIVDJFWmc1eTJ4amhVTXF0?=
 =?utf-8?B?U3FwTzNnSUhDRVhNeGpteXllVXBnTnR2aEdnWHRYMnVPbWxDcjJnNjdUdTNV?=
 =?utf-8?B?SkQwcXNDUzNPUGFYT1lQZFZRTHI4TEF2V3F3SzRZUGtRdFNDYUFDVGEvMHBh?=
 =?utf-8?B?MklZWGtsbk9LekZZamIrNXVLNjhHRCtuRENYcjhobVFxdkxuam5tay81RW0v?=
 =?utf-8?B?Z3ZPUy9rQmNaR2pNemIxN0FOK21ST095WUM2UnZqVzR0VGp2UUNUM2tubXJ2?=
 =?utf-8?B?VHNlN2dwV3ZFcjh1OW5tTGZLT3E4L2RYeW1xWVdtek81ek9SRTNMdDlzcWNJ?=
 =?utf-8?B?ZExkVEp4cmdUaENyYmRtS2FpdWlROUhiTTRyb0UrTGxGRFRyTTVPS1Nqajk1?=
 =?utf-8?B?T3IxY1JlVDhNbWdzWHM4a0ZsQnRmdmd3QkJ1MWJCU0ZzWG1kdVRLdzFUR0J2?=
 =?utf-8?B?WXRsOXQrdXM5cGV6S05BeFJldURtaUZmcUdGTis2MHFJeTFmcFcyZStYYXJQ?=
 =?utf-8?B?NWVndUhjTElwRUNpaUdhS3E1eVQ0TzYrMUFJYis3anE2VWdzZnlaUWM4QUNs?=
 =?utf-8?B?aGJmNExwdnZLU0RtYVRRWkRCNlNUQWlZbksyOXg4RXpGaFlyanVNMCtwUjRK?=
 =?utf-8?B?MGF4MVF3cThocUkySHI2dGxWUnBsdDU2amlTSm1IOWxTZmxsdUpGd2Q3VlRv?=
 =?utf-8?B?UE9mMEdCYzZQT2U0d3ZjUXkxT1c4aEJlcmhIc1U3NzFTRFQ0Y1IvUVU1a3hX?=
 =?utf-8?B?SDBUaE0rZWFFSDVjWHdkQjdEUjQ2WWJFOW0zNjcxUGFyRDRLam5aSXk4TSt0?=
 =?utf-8?B?U05yN2s3NDB4RWFTMTV1U2RRWlc0VTloVGY3aTF6K01FTDkzUkdDQ3FqblBX?=
 =?utf-8?B?aXBLL3Z3R2N0VmpHS2wzVGE3WFlrUmd2SmxienBhZENLV0dLQUhLM3FHUHhJ?=
 =?utf-8?B?TDJZTVpXRDdpUmVEN0JYejlMTWJjaTZROGRYaHZ3ZFROem44a1VoQ3Z2MC8r?=
 =?utf-8?B?RXZpbE5HalhqenM5cWh4Ty85NXVEalB0ZEhkZlZ3WXBNT3hhL3JGNFVDNDYw?=
 =?utf-8?B?V0xzM0x5dGdnVjFJQzNuYUR4VmQ2eW5ESEMvTlZWYkN3UytubXRGbytVKzdz?=
 =?utf-8?B?ckwzTTB1MTB2VVNjcTIzSnVienhaQTRMQ2hhNkNSQmdUZ2hodlN2MWZVNVBh?=
 =?utf-8?B?WVEybVJIeUVlRjg0NHo2WnVhNUcxQXBPN0hWUHU0L3k5ZEN5a2RkbU5rMWg5?=
 =?utf-8?B?VDI0RGR0UG5EL09iQlAydW55MnViS1pnQ0p2K2NvVTZ0TDR6K1pRNmQxOGdu?=
 =?utf-8?B?ZCtRVGZlK0xtTEovWVpNRFArOWNJelJWM0oydkE5OTNlcFVISmRjaElIMTlU?=
 =?utf-8?B?aE5YS0RybzlOOFc2OGZIeXZ6a3piQ3VKUzV3TGIzeG1paHlsRXk5WFo0Sm9S?=
 =?utf-8?B?eUFvdHZrNWZoV0ZFVDlWY0xYNEVneC9mMU1ySks0NktxcmxiajdtNGtGVWpL?=
 =?utf-8?B?UVExZUhMN29YYklMTVF3NXAwTGNhNXdOb2RlaHkvYnh4UHFRdGhsTWpGN3JW?=
 =?utf-8?Q?cX0QVWjp92IhEHQb5V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4846c150-ea42-4305-91ac-08df47025995
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:32:33.1155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsHv9tfRtw32v2ZgLSAW1MuYgKNCnIqcX3rKD0q40d2pob6RW3C+cy0JS/TxHNwp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
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

On 11/20/26 03:35, Lizhi Hou wrote:
> Zero sized buffer is not supported. Check the buffer size and return
> -EINVAL if the size is zero.

Oh that is surprising a zero sized buffer shouldn't be supported by DMA-buf in the first place.

Doesn't DMA-buf check that somewhere?

Regards,
Christian.

> 
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/accel/amdxdna/amdxdna_gem.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index ffe12a722dfe..4d7f3de88cd3 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1133,6 +1133,9 @@ amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
>  	struct sg_table *sgt;
>  	int ret;
>  
> +	if (!dma_buf->size)
> +		return ERR_PTR(-EINVAL);
> +
>  	get_dma_buf(dma_buf);
>  
>  	attach = dma_buf_attach(dma_buf, dev->dev);

