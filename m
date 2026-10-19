Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB23CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1006210E7FB;
	Mon, 19 Oct 2026 07:25:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA2810E81E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:25:45 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4j2GE1553034
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0ZT348g/Ac7kP8wYr12fgEIsNfhFaNR7Am43qhu+KN8=; b=EOjjp3MUSkwizsaF
 IqkUf91goeslH3UufT6jF6APm3EGqyy0/qSkQ6MyvY94WHeIaIiRgDBdJfghrKBW
 7wiPdeFoPW7S23M5fM3jWZ3puEOO5pu0ZZRVbtNEwx+5jhI8M6Ca7KLtx0afIJQ3
 3FHT43/fA0ebJJXNuvJSyyzWUMMoGTZtQycKEgy2ogxNnDG719aRdz+f9nTqfF2m
 bitzrigml7eZzC5+DWB9TYg4vy1FM/+hC9WPLCDR82D3XK52nHyvsvFxUsZr0z73
 xBKknc8RKPp1Yql5Pl0yMzxv71vin9aGfxmFJvFBQIt7nsnEKQfDuyCaV4sKjRpc
 swkLHw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5ur1j6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:25:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35d4538fd74so6678616eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 00:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792394743; x=1792999543;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0ZT348g/Ac7kP8wYr12fgEIsNfhFaNR7Am43qhu+KN8=;
 b=iE2Oi9vafZlVCq6oNwOJEBpWOfd+SdL2nX0Da/UyIOk7hPpECzIBxfeK5KlflAtUi4
 to5KDhYPAsCQUmVl9Qv2IjEYBIlzobjVQRRHKd7COlM5mZd8AxCVX6rm4lJMipqkGOWD
 dA8SZjfWmsLobngjCwXVYPsHRuxtaqAFe/F/MKAUIQb4CF9h/FvAES83N1xt28Sg8kPQ
 CLBkbhIFMiJR2a/clv3MvckerhhQrgoGbEbNqqecH446sqIIjp0GIwHbqrzs+ZF2YIcC
 b/4qmLuHWkmKp/tCu49GfLfPd1/7Gf7yCUCaFMAlP3VjokpuCKPQVVpzOuuKLBkUGZi4
 WCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792394743; x=1792999543;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0ZT348g/Ac7kP8wYr12fgEIsNfhFaNR7Am43qhu+KN8=;
 b=t2ueAnqR7tkryZwv2Kbx0/81VecZRCzbvyKsqOkMCrJQ7zLwTx/UsVPDCUnhtcr6I9
 IO6b1HiU8qDCSBXApx3oOszPBXNNnVCOTm0GOKECyvZi1XMCjfsCzhNtMZuBEHKOB8F1
 8zitPCikjZvLfqnrX3f1+8VBvi+H6SinVI5K0/yBEDbfa8J5wrRJLziKIWQK+2AV2gGj
 VVdaFob/qepkXm0pl/vvkUSX7Z7TaZdDMhARLLrrfPaz21GoxNZIczqKfnPITA3Pmrv8
 bPS4SRwZeZOc6pdyhnH/2qFSxbr2IivCGhnbzBqwgxzlflwst4/QoViD+/FM88dKBUBm
 yaBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5euxTMjruH1tiQMBYTCymbL8BlA2x94eZgN7eWj9sHI/yQWGcztVpAAVQcfUerQDHUBkudQsKxFg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI6Z8fypwN8ETi6dbTw+UFGzYxu6onMimhIU0TqbPkEjU7jXN1w
 Lyrur9d4yejEqyXyhFOdfQ2uglFS44JbTtsaglNQ4r9z6k4DUINW7zCnjsURgkqplmWD115H4L7
 Jc7WlMfqpeyBNvLOPVDrUfu60Jn1usThgLy6diPuFG6MpIf8Bi107SWE9HmmNiWpjJi1qk0M=
X-Gm-Gg: AYBFou3j2rWFXECSEJxh4ZPFeS4S6xoHune01409+mEh1eda9EZ+JGIOS1xRMIgJWxK
 7btxKyujMbYuLRih0Wb4Q6jYV7AuAomcPuM5t0NQhOUm9t27t7Y5Awe3cZXXEU7wzD+i4SDGBRV
 AA/rs1EeLbmYsUtz5C4thnly+e9mmcdY9xzX+lId5HoCMrRBIolpRUfceO+75okwx61Z2nJH6Bs
 EGXBvHgjdh0wExmqPJCrv2hmbJnnFMC2ZuPlj7SQ98TcAfF172e6WsT6k6CwyCmXEeoLcqKh8RX
 2DiykeP9fDYPskgl6HiTex2pz+s2upeetTGR13BWaDH9Bjz8U0AYjz/zyaNGEiPb5UXQuaKhsVL
 AgY+T1gJRqgqQzQ0EJZyVX0hN
X-Received: by 2002:a05:7301:2a9b:b0:35f:6d9d:af68 with SMTP id
 5a478bee46e88-361a1f4fa38mr9834551eec.23.1792394742995; 
 Mon, 19 Oct 2026 00:25:42 -0700 (PDT)
X-Received: by 2002:a05:7301:2a9b:b0:35f:6d9d:af68 with SMTP id
 5a478bee46e88-361a1f4fa38mr9834518eec.23.1792394742408; 
 Mon, 19 Oct 2026 00:25:42 -0700 (PDT)
Received: from [192.168.1.7] ([101.0.62.42]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608258aa66sm37292247eec.20.2026.10.19.00.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 00:25:41 -0700 (PDT)
Message-ID: <dfe968ea-d123-4e94-9a6a-5dbc21ae431c@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:55:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] misc: fastrpc: wake poll-mode waiters on SSR
To: Jianping Li <jianping.li@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
References: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
 <20261007084447.922-3-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261007084447.922-3-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyOSBTYWx0ZWRfX2Y79EZNlVf+r
 BKUZbZ2Kvd433QtzuSGHdcnfKgLOZD7dblLzBReqfZ38st1jsxDIKgrA/T+vQVdLUBfhqBVcn6S
 Uhc+c+1mP648Xq5qln+N+l/jUBYwCpU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyOSBTYWx0ZWRfX1GRxUygldTvr
 besoHoU2LfRvzYR1AO5Aqyez7jZfytDKPFA5Lgp4EHLJ6H15aTYJOuUALsB7Fskr656Vx1Y+FQL
 Ku3nYdT6B54K3XkB753c0qMJVWTfCmQ0chmYAK3pasPJMTnQw6Uxy7gC8wh9ljBarBWmnKaRqIk
 QNr05z3lHaKADaNlZ6OH6qTfbUHZIT5J1QWFykpX6aOhblz32lvH39wuRN5SOGGh3VtmEU5aQL/
 /9TV4o7NtgFgPEPoPLR+ULi5wJDw8aYpeY46prWsVCqD/XGgZtgTaDN5AS9eAnZQwOEJK6yNUS6
 xeQjHBZvK4Dgupc9D5UoObNQc8n9Q56aSDClZ3I2JsPzmt0n8kUhsSHJaa05986auoiWbANShfD
 ddwseWVov4dAWjK+bLFSWUA51XYfJLFHCE+ToQ0bSKlHzBFakVT2NYjtSZrZLPAYy20+Wj6SwnX
 zq0yiJdj4k7Bb+LtOvw==
X-Proofpoint-ORIG-GUID: gFrKdnd5MwPNAS9TOX8_7bT9ZBf5LDIa
X-Proofpoint-GUID: gFrKdnd5MwPNAS9TOX8_7bT9ZBf5LDIa
X-Authority-Analysis: v=2.4 cv=CP6/zhrD c=1 sm=1 tr=0 ts=6ad5c5f8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=sC8K8RXUWm68HHFV/PXcoQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Ibi0DqZ3yaYieqUivDkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190029
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

On 07-10-2026 14:14, Jianping Li wrote:
> fastrpc_notify_users() sets ctx->retval to -EPIPE and completes
> ctx->work for every pending and interrupted context, which is enough to
> release a thread blocked in fastrpc_wait_for_response().
> 
> A thread using polling mode does not wait on that completion. It spins
> in poll_for_remote_response(), whose exit condition is:
> 
>   (val == FASTRPC_POLL_RESPONSE) || ctx->is_work_done
> 
> Since the DSP is already down, it will never write FASTRPC_POLL_RESPONSE
> into the poll address, and is_work_done is left untouched by
> fastrpc_notify_users(). The thread therefore keeps spinning until
> FASTRPC_POLL_MAX_TIMEOUT_US expires instead of bailing out immediately.
> 
> Worse, the poll address lives inside ctx->buf, so a polling thread that
> has not been told to stop is still reading a buffer that the SSR
> teardown path is about to reclaim.
> 
> Set is_work_done along with retval so polling waiters observe the
> termination on their next iteration, exactly like completion waiters do.
> 
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>

This looks to be a bug fix, can you please add Fixes: tag?

> ---
>  drivers/misc/fastrpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 05b2e7e4ad3b..c54c450cb571 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2663,6 +2663,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
>  	spin_lock(&user->lock);
>  	list_for_each_entry(ctx, &user->pending, node) {
>  		ctx->retval = -EPIPE;
> +		ctx->is_work_done = true;
>  		complete(&ctx->work);
>  	}
>  	spin_unlock(&user->lock);

