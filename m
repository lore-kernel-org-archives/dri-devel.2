Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC41C54FD4
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 21:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED3710E041;
	Wed, 29 Jul 2026 21:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kJq8jUPO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GdLgPjVz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F3810E041
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 21:19:43 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TL7rPe2995358
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 21:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wkr/IHbH/vmkP6F8QZmjiDF071+OEQwubDm18Vb8qFo=; b=kJq8jUPOh41Wutg/
 mB0hRRG0yHeTfgaI96Erp4IhZ1LWAuN8TST2hVvko/nMfHQqx5FAQymf2+j4AY+Q
 1yVfSmdL8iyPrNTWxhx2qEpY1Wp4VsQ/YmA9HdjhxC5PVWm4pWlwXy7h4Rw9E5J5
 dxJ4CCGG9Czj/nfkclzs4TbqsMT3Nhhs7I5upnkaODA24t5un3i/Nsn5P1JxutGq
 IKa7jjVHg4Z53GcbTil9ot2xFBQQg4jShvc2XEu5vfl0gK82obsUVsYt4+wZ7ZgR
 7CM4t4ljQLlIUzO6tl0KJ+6D4VAyLD+BJX6hwKJA/7mzV3/dUPRfT3Uv1Wg1COLJ
 41J7EQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqs5g816r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 21:19:42 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84885a4fcabso1656771b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785359981; x=1785964781;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Wkr/IHbH/vmkP6F8QZmjiDF071+OEQwubDm18Vb8qFo=;
 b=GdLgPjVzYn9DMtLZm1vR7/6/XtQ5SoAREPEh4pmHVameNnGZ7cOtNcOPuZlYxI8fA9
 S459pF8/2GGZUA8TSaD2EvowvlEmmU5wyTn7qvbU89FqyyshPtftQNWph8EHUma0A3FC
 ABi/joUiOdhToCbRDgRksXYYyqYLIekrbxbPCdRS08rJ5xAmCScG7N6yEhwdjMLHqvEz
 JDimzo8rQqekYYljALBk/YxTuwNRMe+qXokKFjaebO3wdfOkU2nN9cbICRjctwRDadx8
 eV0OsbdYl3mMtCq0kQ0LNf0QSwwt2xru5JyZfpzMEYT95GGbLUzDAdK2XOeQPFr8/Lo/
 CfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785359981; x=1785964781;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wkr/IHbH/vmkP6F8QZmjiDF071+OEQwubDm18Vb8qFo=;
 b=mpixpkCfF7aMYcHw/n5ZK9qWQpDPCiC/Ta/mN9cjB/EjBI3JvMcveP4yGZFl0E8G+u
 me1togez1pprXJnZc+U6fgOYBjhA8/wOlooIGsf98ES39lkPjPTnxLG8/cMSE0Esq2S/
 54DltqD1pyW4LJtPybeW0DoG5mBKodaiT+hXqox52kcVwe2ptGty44hP6xMGjIEVb5Fu
 Cu9eG61lCyqay4NsokJW/KMS9wkftIGrWUdkdW1cu3MyvCvv3hz0o//q9KLJq34d6UGS
 7WrwvghudHnuYmj17AHSOLROEqP6sO+loyPAI7ffM2ovd5vJec3ol9gVEqvKOLS6J420
 FWdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBFiuvDLGfAkxwDJV/yxz7esgnfFhWAVtUMLKNHPf8mFKDiwP0nRcYb0+MWiQzEhI4R6z2qiMyaOE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIDUwAjPrBP3lEsCBg9wJctmRspPiDb+A0SFA96tE25tkL5l1i
 DLDPIJHtAf1FcWnPCjx/oPBf469tFE6bC/KFyI1BD3liqmM934t0HwWutgtr+ytFOmLTErr0B3/
 g8uX4DvmFqbMTj2idR0qRVwm0xwUBFfOEL4J3ZPV/JGuiI59Z8+GIzgOeTcsO8XoqYuuzugE=
X-Gm-Gg: AR+sD11fOez7ydxbAsUXOh0fmEYLfBOKHsOJC2UyJpWqkZJ4NMua8pzRjcF6EojxPUr
 q++EVsQFMndXHLXACCXpmOy7qwVM+7SL3hqvu0AJIwX4B+Gju2gZySLkAVAIJek0U9Aht1acsus
 SrcP30C6e/XXEbQj0lnF7vxWGr0kC+gfD/5gad9l9svLjgHqY5DkLO0y9GwKQ/mBXlp2mOogrcK
 DzDYzOjHTsWLQ84GfCtRsg7XqxXDe1XmRVIHNeAwuxjIadCOIQWPA43jxIsVQY1dmfZF2T2sNSd
 1gxzTLYEVbaBs1rF/flGM3kMWwVhrj+RbNx25RdHTXOONfW3s+0REd1y1YNRwvGXRUHNDlbZVNb
 40FtwnJg8dqoh66MsL9GshspShkeSK08iaQ4hAB7dvYkadu4DT0lQEQ==
X-Received: by 2002:a05:6300:2288:b0:3c0:9c19:b275 with SMTP id
 adf61e73a8af0-3c8ba6550f3mr9253698637.67.1785359981404; 
 Wed, 29 Jul 2026 14:19:41 -0700 (PDT)
X-Received: by 2002:a05:6300:2288:b0:3c0:9c19:b275 with SMTP id
 adf61e73a8af0-3c8ba6550f3mr9253685637.67.1785359980956; 
 Wed, 29 Jul 2026 14:19:40 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504927a7bsm14864812eec.0.2026.07.29.14.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 14:19:40 -0700 (PDT)
Message-ID: <19305f3f-7567-48d3-a0b2-6597fdc3c314@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 15:19:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/qaic: fix GEM object refcount leak in
 qaic_attach_slice_bo_ioctl
To: WenTao Liang <vulab@iscas.ac.cn>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, carl.vanderlip@oss.qualcomm.com,
 ogabbay@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20260628115119.44215-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260628115119.44215-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rHMGBeK_kiGMbT_7KkK0g01OaC1MmSbi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE2MCBTYWx0ZWRfX6F7Krm5chlUy
 SU84pZ4Whk86mkgKG9x6BB3v5KFrjKu5gOeVF6ec+aOWk/W4Q2sWk0FwJU1v7GdEJZv2AXAGCMt
 nxesjXLC7QUmSdn8btjs9IfQfQWgBR8=
X-Authority-Analysis: v=2.4 cv=OJEXGyaB c=1 sm=1 tr=0 ts=6a6a6e6e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=mPBHZ_2hYfeim0CFHOkA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: rHMGBeK_kiGMbT_7KkK0g01OaC1MmSbi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE2MCBTYWx0ZWRfX7IodP6ZiDpTT
 66PHg8q/BE8RiIvH8eSNx4KklVG4ckgWF9vrToDPBFJ1qnyCa4hPb0cPr7+GS4GVIq9uw+PgTok
 p1ffyyV5PlJXDuQpA+Mil99K5g1c00DkhAN+SIHUSSECd1+fMDM1441bxlee1xWzsPq5KS3jVNF
 blbzIPC8O9fX2vBWM+2s82kwGqhsNb8VPsoUQP2nNKm1Sp3vHGsAfC8l9NTVKlxGaAgerCyXOCQ
 LaKa7ocb/EhZf0G2lbd1a2RltgsXRhLbH3fuY13jg72i9xPvU27Qr9qqovgVmbq9xGEJinIA12U
 3w+YsyU3JxoO0SKw6Y2hoKxB0qX2Y/2A78r/F0GO+Wxrd6So4I7rPkYg/JNe2BQFubGyjTdWUFz
 A7lLmfLgRpBwQUDRatdRxNJHCLs0mm+cdyey/Lpf/Ju1vwTe1NzL97XEHerETQXgMm61JDhPbrg
 nUv+Y/bh7NcClmL6j4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_08,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290160
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

On 6/28/2026 5:51 AM, WenTao Liang wrote:
> drm_gem_object_lookup() acquires a GEM object reference on success. All
> error paths correctly release it via put_bo, but the success path returns
> without calling drm_gem_object_put(obj). Since list_add_tail does not
> transfer ownership, the GEM object reference is permanently leaked on
> each successful call.

NACK.

put() is specifically not called in the success case as data structures 
which depend on the BO are not released until detach_slice_bo(), which 
happens to be where the corresponding put() is.  It is also not possible 
to successfully call attach_slice() more than once without a 
corresponding detach_slice_bo().

The get() and put() operations for the concerned paths are currently 
balanced, but this patch will actually introduce an unbalanced state 
(extra put() operations).

As far as the impact of not having this patch per the commit text 
(memory leak) I'm aware of many memory stress tests, yet I recall no 
reports of memory leaks from attach_slice().  You will need to provide 
proof, from actual testing, that this is an issue.

> Suggested-by: Greg KH <gregkh@linuxfoundation.org>

This tag seems wrong, as there was nothing I can find on V1 in Lore 
which indicates this tag is appropriate.

> Fixes: 75af0a585af9 ("accel/qaic: Grab ch_lock during QAIC_ATTACH_SLICE_BO")
> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
> - Fix patch format based on reviewer feedback
> ---
>   drivers/accel/qaic/qaic_data.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
> index 1e4c579d2725..b17df7bf565d 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
> @@ -1084,6 +1084,7 @@ int qaic_attach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
>   
>   	bo->sliced = true;
>   	list_add_tail(&bo->bo_list, &bo->dbc->bo_lists);
> +	drm_gem_object_put(obj);
>   	srcu_read_unlock(&dbc->ch_lock, rcu_id);
>   	mutex_unlock(&bo->lock);
>   	kfree(slice_ent);

