Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D112CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD1110F915;
	Fri,  2 Oct 2026 16:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XbAscd4M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F+kwdBef";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2999710F915
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 16:16:25 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FH5DR1647429
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 16:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JrpZAzOHGpAVYNYwEJvYiv0byu7iGUXkj5JdchsAbYU=; b=XbAscd4MiYbZCvv7
 4gL/ASiAfUD9gUS74XPJOKuIm3ILwO8GGJJ4PvlI9gasjJcT18EjZ7mXIyCa/XLx
 5Z6CNa+s8QhrWIpSCWH6QKbpFhrOfwTRBbrinuhM3Z4a5UZ4iIqdoUaJIavSCXbl
 WpaSUBAqwiL4y75FBJWK2ew969GnCEsTk//r3QZPcUI3ggh57KP/z/jDcP8kkL/y
 d7tfenA8oZnSkOzx6lyOzotPJN5voPvg6tyYkg3b9YH0dlBI9k1/ieFfpf4Yd36l
 OWDECSMYw/n8/fma6pYgJKzy7MqspFDVwG020R1yl9ZQYOsNEWg/RTzm2elPgmY7
 eiHAVQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ec98emv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 16:16:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a47617a0b3so56340a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790957783; x=1791562583;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JrpZAzOHGpAVYNYwEJvYiv0byu7iGUXkj5JdchsAbYU=;
 b=F+kwdBef410fKMYGA7Y93ceRxjhEAhVQzxzH2Wov4E86oLEvfcbu9rFxBvw+vhMdnE
 5aDg4OMDpSsI2VVJ/AskF7hpDp5Ew2TuF/9WcpAFguQBGdN7N/Xtzmg+JyPqK3VvHkPy
 7IDEJanDF0YBYxlkYmYrIxjNRrsa4xmf0sfnFbGTfc7SX0q5ryXrU1pN60TAcqRUTSA8
 NfSWkFgfU8+57bucxigTX70t5MgwrmLehuo9pc9zfmqhplTZDQFz/Oa17/2cparPD0Nr
 fCLVEYeTvmhX1N7W7IQlXRxZQBalQQ+xgARjP47HNsTTHrLIIcJhB+Dd5rKxEFFAHfdf
 J59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790957783; x=1791562583;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JrpZAzOHGpAVYNYwEJvYiv0byu7iGUXkj5JdchsAbYU=;
 b=gMRg5eO8u/TMFN8wmamHBPbDJgFvnpJI/LhTsGtepcwIXBUMKL0vCGYbXRM9MeSANO
 K62Va451G3JCxbLZ7Yt9/KzHJYHPEios8NnncM19TDf3pjxvur69gs6t4n5ghYvTkv+V
 ZDAxYrKfJK2W1GIlmXBBHsZBfM5oOByxNyhhOMmEwZd7mK0Ri9xx0oUia0jOQxm8MULo
 fUX03fqYj3yNR7O2iIabRToCf2ngh6zyWKRl1xSNUUlLjTiw5ixsObfWIDW5LkR+r7sw
 KtyvYBY0vE4CdwTZTw8U5PJIJSuMOFoNFUGuw3Tr+J8yiJEEQ6hGIOhU0QLCjGx2Z0Em
 PZMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhWQhnqpKx1CYhEg2zDv5JAgCnfH6tFCV6VI0k0ajf5RAPgfX91rU0ErwqbTr690nLdWb/j0xdBjw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJeHdRKghSIQfSBcg2UpibDJSkJGYqDrJy1Bk7+P6Pqy8C1ZB/g
 vmZ5wvTnzFw96JpXzitpqnrNvnyLL8cKrPvkfNCp4KHMMYU8E7a60KiDTrKmfMptsLtY5YCLEmD
 z2YbaWixl2rH8yrwRYWqdbbxBWTr9aN0LqfdIP9y1385A268phetokFFbaHVI1FrAIbIxWefN1G
 b9HEo=
X-Gm-Gg: AYBFou26FyWduS3jcMLgmhnG1uuS6WHNQw85cxIhRiINOOiXDE6Nq8ZbvYD417skasG
 Gkwzk+2Hr3NwhvnvXcEV459uiMZp1odbUrp+7QPPVklJfvhkz4EhkoUca9Mh9DyPCKaYVDSw+zr
 df/sPDMCQooHPpMjQTP+HcwP1EWUbJhfec7+v2V5mstTUtf+Nc+6t1i8LHZs4tupkF/rhc5IGgT
 kexLbD6EODk8t0kI/dERZJYbRoAs8fePK2+IqjpMZsnzhJIyAlShL3V3iVT4U3vI8BSNtbpiWmm
 KFa5SP/DbhQ+6FjSaVwnNfaVN6KHeeZiFREJhPJRWZntyLxh+D4d9G1ceQMjkEaFnTcTvDSihl0
 We80OuRWB/YX9tvqUNcmgslH7IHXvoJ/+R7pkyITpP6qscEualQ==
X-Received: by 2002:a17:90b:584e:b0:39e:6c69:7777 with SMTP id
 98e67ed59e1d1-3a6cec2c08emr1780038a91.32.1790957783157; 
 Fri, 02 Oct 2026 09:16:23 -0700 (PDT)
X-Received: by 2002:a17:90b:584e:b0:39e:6c69:7777 with SMTP id
 98e67ed59e1d1-3a6cec2c08emr1780016a91.32.1790957782566; 
 Fri, 02 Oct 2026 09:16:22 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6e7776003sm1535408a91.0.2026.10.02.09.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 09:16:22 -0700 (PDT)
Message-ID: <ad9beb13-92d3-4131-86a2-e7684fc1647c@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 10:16:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/rocket: Fix use-after-free in
 rocket_ioctl_create_bo()
To: Wentao Liang <vulab@iscas.ac.cn>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, ogabbay@kernel.org, tomeu@tomeuvizoso.net,
 stable@vger.kernel.org
References: <20260917180013.2166025-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260917180013.2166025-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eJQKxu4WYLdmCdAGcJ7MYZe9PSjhpXao
X-Authority-Analysis: v=2.4 cv=Ie8Symqa c=1 sm=1 tr=0 ts=6abfd8d8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MWBjQOLh__yZfO8ecwsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NCBTYWx0ZWRfX33obNJYmxHYy
 lgbNOOAImjbYKAurOrScfGQ8w4YgIC7IxcUGV3belJvGhCvMIlokzBumoB4gUx0xI1fJIhpESub
 CuSFx3uB34z5BmfVo4XshDI3lsyVbzM=
X-Proofpoint-ORIG-GUID: eJQKxu4WYLdmCdAGcJ7MYZe9PSjhpXao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NCBTYWx0ZWRfXzyQv+Y2cNBjO
 vVq1PIZjw3qH7uO9E0sqQby3016AEEGLlf6958quqxJ7ArykFvX7j+G77nKAZX5cW41ERurfAVh
 0I6eCJidJGngxXAM3HyIE/CY/yiC0lw7EJFl7Q+m1gKaFcr+yBUrEypn3O0ubpGRX58MZMtIp6H
 7uy9gjiaKBzFgC4ZRPlf617ILObX64r6UGBwyHd3pSoohiFQHYCxoXGhJfIh0MdKN5xKfOKsh+f
 ky1/OdmWk2/iXYeJ5SbmwB44A/5gQ2oiqy1W7b2o+8HhfoZSAFIEl2aQlHn3wMbw1SVhR0hcGPj
 PG3a3ildjVKNfUOf5UvNBRQBz67lkTiFF5lkeOu8g4gPwOz96SF0Sh5kk7duqQi/DzH8cMcQ0w+
 ynrEDmNIu7DMS3NhDAt7b+GfTzBAn51ivXqQ7pkXkTtkMZQfp52Pr+cbrkprMCpVYqrHjczK7Mk
 N4XTdO06FgS23UTXKbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020064
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

On 9/17/2026 12:00 PM, Wentao Liang wrote:
> If drm_gem_handle_create() fails, it takes and then releases its handle
> reference internally, leaving the creator's reference as the only one
> held.  The drm_gem_object_put() then drops that last reference, freeing
> the object via rocket_gem_bo_free(), and the subsequent goto err makes
> drm_gem_shmem_object_free() run on the already freed object.
> 
> Return directly on the error instead: the put has already released
> everything the function acquired at this point, so there is nothing
> left to clean up on the err path.
> 
> Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/accel/rocket/rocket_gem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
> index 91095d1b3066..521819041475 100644
> --- a/drivers/accel/rocket/rocket_gem.c
> +++ b/drivers/accel/rocket/rocket_gem.c
> @@ -82,7 +82,7 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
>   	ret = drm_gem_handle_create(file, gem_obj, &args->handle);
>   	drm_gem_object_put(gem_obj);
>   	if (ret)
> -		goto err;
> +		return ret;
>   
>   	sgt = drm_gem_shmem_get_pages_sgt(shmem_obj);
>   	if (IS_ERR(sgt)) {


Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
