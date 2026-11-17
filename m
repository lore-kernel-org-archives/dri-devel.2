Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050BC606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IJIfwHeK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jkNUH/hM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0FC10E07B;
	Tue, 17 Nov 2026 15:35:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE0A10E07B
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:35:31 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQMfn923286
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 67Ks5b0HSYrXo9kOcZY2qc0sEU+LdootGD3SBNdOIvc=; b=IJIfwHeKeh1kWGsD
 UR/tfSp6lnTJa42WLngOIKIW1tSHjFKyFl1CY9pStbMnzKmvzz+cwvkWU5qQSH2C
 WgIxsCJ3NNJ6LmQVXKS/oEZJM72aYKkqtm6SC4iSuIJJEXM3MQNbMEgqE7K76ejp
 X3/S9oEgoyYjtkrJd4F9D3P/YBc1T90SSfBhjOwQaG1SnVhI2CaoqVOdOvI2p+Xa
 0czEjLPfAh/8Sm5Q8r5xjStSjaZvUTkoQ5NhpLmeqVd0S6KQbSnfrfQ5p1hrUQ7Y
 wvyVstFbHa2XrbKDWV+ugGBuvdMZ99iAhobVtQfawIpAWdDNa7VyVKGJNiq8SzLO
 9EeVLg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0qms0ne8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:35:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cdaf2073b0cso2402470a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 07:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794929731; x=1795534531;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=67Ks5b0HSYrXo9kOcZY2qc0sEU+LdootGD3SBNdOIvc=;
 b=jkNUH/hMVo0MLUBMWJKuaLTFZH/NBLxvoOhxV1z+0FFaBwlqk9uwWAsGSQKjxeYk1f
 93vwdb8FutjYoLZ81QXY6TEPIHAJG0b4WT+VVtX+GwFVZTx9t+kIsWXuRiglhHlAosIe
 g8h0c7sOzFFpS7QBKLoK9KBdZWT6mXjcsnhsDH3p5FJoMIkK0L9a650h3KHoUIl2FKOw
 uyo2MxFbhJeJo+h8WKrq9csYTnar1kDrYKDT1T89P2gCYV4414UPhKo1f/fFQvfUpbd5
 oupgd6s8QOhNhjUMVvU6bbpEDIuK7dmmw5VtdOZ3aspiqepDgIQXX7x9VpvMrbpg7j0f
 5SCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794929731; x=1795534531;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=67Ks5b0HSYrXo9kOcZY2qc0sEU+LdootGD3SBNdOIvc=;
 b=htvMn2iMSjCGFITeBfp/zeCuxYYhucC8TlxZJILREEfj/eNbJdmslTrfj9qN2Qira8
 34apNxUclBUpXju15pWeOJ8olHPqWDNrVmvLCGwHbjwlq5OvWfyzJxzn7a3obvAeNvNX
 4+rgfGv5j5GM3454MnKHxlYcFZZfRRFdQjmk2DvgLcDkNusWH/xKGJ+iPz8rCKzhsYH3
 qDo/WMUrcKX7nMC+ga2NN1x7LyUdyyTIVBX/6UaVpCVsPb7KCxviiuTmYyGL4rsWC1eT
 w2QXAdRF/gm5dnIcYA+v4BQLVU+Wbf0rbGpnCoKqbbbQSFUI0O5IH+Ddcn5iefwaSZ5P
 tq9w==
X-Forwarded-Encrypted: i=1;
 AL+hErGspgBKU7pU058HrX0IdicSFHCqot6xGChu+qDbZsN3bufrsg9MTignJCBJP2GuKCZLDNmKvx9OYhU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z84s43Omniz/cH9BiLNyfUqk+FbU3nixmz7ApikgGZkytI5SvJq
 Ki0ou04RuL0LPedhq8JlfYVZsd86Ohn8dzRNhj7Tcw/J22zk5P2nUqbhJIZtvV6EtLltkucf2vb
 /dTNy7baSW0/nOKv3coU67FonWZthlEp4AViXcwEKsy3AjCtY5hkktCho9B6YT2p8aOkZKdk=
X-Gm-Gg: AZFdTZcI12qzBoIX7/m28bhqmyg6s68dKRptE+ll503KGf4qfD+pnzvAdpVJ8Ch+kfM
 TdcmSPLEig/Dt/nC/FC9EYfbE89nnuG+r9HbiF/VKOpTqGUG7zXMHiGt9MyL0/oFFn0SHETPVeP
 jTGeRgrq3aBmsvvFrtu1x1CcK7tsB7zWtdua+H3OK4WQ5KPVipPJx9mGr8yMGbkOzbKbuy99/Rz
 nrJ/H+AizGdFazzgnjQVhQodTUEb/i+A4utcEt2YSdPP7KhvNU242qJipNCEqWS5yT/ibxWmG1c
 wOCuc/lyKaeZp6MSkiv8+n+jDfk7enZ2hnKY8O9EiD59b6Xh5raJFbI49GqB/De+yuQKEinTXZi
 gkLXSmRKuEcjbgZTAczg/yaorAHkL8gs1yHVN7B8O0qWFeab9ko3ZSED0uTIfgcvQN8/DBvEEX0
 tDSQ==
X-Received: by 2002:a17:90a:f947:b0:3b1:2810:dfdb with SMTP id
 98e67ed59e1d1-3b1b0b86ae0mr13484103a91.48.1794929730674; 
 Tue, 17 Nov 2026 07:35:30 -0800 (PST)
X-Received: by 2002:a17:90a:f947:b0:3b1:2810:dfdb with SMTP id
 98e67ed59e1d1-3b1b0b86ae0mr13484075a91.48.1794929730181; 
 Tue, 17 Nov 2026 07:35:30 -0800 (PST)
Received: from [172.20.15.99] ([195.50.164.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abec8092sm4658652a91.17.2026.11.17.07.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 07:35:29 -0800 (PST)
Message-ID: <443de2a5-d6ca-461e-b842-47b3acbf4031@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 21:05:15 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] misc: fastrpc: remove dead context drain in
 fastrpc_user_free()
To: Anandu Krishnan E <anandu.e@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 quic_bkumar@quicinc.com, quic_chennak@quicinc.com
References: <20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com>
 <20261117-interrupted-invoke-v4-v4-1-2320a8a7eda2@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261117-interrupted-invoke-v4-v4-1-2320a8a7eda2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfXy1XO3uXdWI22
 IwjBfOiP500PpXWPuZd34sBPYFMD62lrvSBjhmNubxB2aeywVeLSyKLaj03j1oKZio/WDEMe3YA
 vAPpsa3uu5GxMlXzHXiF8ELWCNoDumc=
X-Proofpoint-ORIG-GUID: xcj0FwJh_mLCfPt8uJdHiyvQk5n8z65v
X-Proofpoint-GUID: xcj0FwJh_mLCfPt8uJdHiyvQk5n8z65v
X-Authority-Analysis: v=2.4 cv=BIEmP1QG c=1 sm=1 tr=0 ts=6afc7443 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=tAvVqsXYnFiDWnUM2kgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX8ULtPLvk9Gmu
 Ny20HMH/hS7KKg4LIXnapii+WNho+LN+aN5A63FqcyAZovvR8EnKoy4pcDjDxp8UdEPBbLbt/RO
 UqucWJUYa8cQGeWNQYwvOHR7+Hinu22NjY6umTtWRphl/u5ZRN0T1mA9OiXvdyznbjSLAyB1BLh
 cctsd4vtfgLrmyXTux/mNld8kOeYceNQlM6anraSx7tEjHqvC7OIXu0vz5kaFDuCQlEQ6WNJQLk
 37GE27yZGpcK+UTwENMmUvXNx60NhcwtMyDCNZj7OCVt7GFsxdT6y0X5YF9kjWkDDDAuKu/1H9S
 QyEJYkpTY9abDraChmBAupHQbj3v1AIvy/784dNMM0RudXEBrnxb1HR8Iv1kk14t0/AbjtOddJr
 VrtgpEKWrcuyrs/ygxJrvqh15a+tz+O270o/KRuwxIvjTvwdWJ6qe9A4qZwUVSr+VfevCZHSvKN
 oj7IajTAynadIJ41DQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170061
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17-11-2026 15:09, Anandu Krishnan E wrote:
> fastrpc_context_alloc() takes a reference on fl via fastrpc_user_get()
> for the lifetime of every context, and fastrpc_context_free() always
> unlinks the context from fl->pending before releasing that reference
does it? I don't see this in the driver code
> with fastrpc_user_put(). This means fl->refcount cannot reach zero -
> and fastrpc_user_free() cannot run - while any context is still linked
> on fl->pending: whichever context's release happens to be the one that
> drops the last reference has, by construction, already removed itself
> from the list a few lines earlier in the very same call.
> 
> The list_for_each_entry_safe() loop over fl->pending in
> fastrpc_user_free() can therefore never find anything to iterate. It
> has been unreachable since fl's own lifetime was switched from
> file-close-synchronous teardown to kref-counted teardown; it was never
> updated to reflect that the list it walks is now guaranteed empty by
> the time this callback can run. Remove it.
> 
> Fixes: e85eb5feca8e2 ("misc: fastrpc: fix use-after-free of fastrpc_user in workqueue context")
> Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 9e760f68bc..bb0c304196 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -568,17 +568,11 @@ static void fastrpc_context_put(struct fastrpc_invoke_ctx *ctx);
>  static void fastrpc_user_free(struct kref *ref)
>  {
>  	struct fastrpc_user *fl = container_of(ref, struct fastrpc_user, refcount);
> -	struct fastrpc_invoke_ctx *ctx, *n;
>  	struct fastrpc_map *map, *m;
>  	struct fastrpc_buf *buf, *b;
>  
>  	fastrpc_buf_free(fl->init_mem);
>  
> -	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
> -		list_del(&ctx->node);
> -		fastrpc_context_put(ctx);
> -	}
> -
you should also remove the forward declaration of fastrpc_context_put().

>  	list_for_each_entry_safe(map, m, &fl->maps, node)
>  		fastrpc_map_put(map);
>  
> 

