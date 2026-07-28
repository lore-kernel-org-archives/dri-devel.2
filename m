Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D822EC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A7010E09F;
	Tue, 28 Jul 2026 15:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SbDL25U/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jyvq8Clt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFBF10E09F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 15:06:54 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SEcddT3412678
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 15:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jzk0wHYCJIe5nmkz4JIZUJPyE7lMjwoFgqtF0y0W4q4=; b=SbDL25U/2geADA3b
 dKw6KHKUZwwavaLllYw87lhC807pNZQInF/NISCbqsGjKfZNA8qbHgKqy5iYF034
 V6jkmWwP/qvrCq9uk9g3PA/yx1DmcQ82UmefVy1mfWgTrEhTDvcCMrEVYu2LBT1c
 9mJxEtnZN9Ezns1wxIuDd1bHpd+LOI7eH0CgfYiQy4rSvBoNyoe0qQvfLMU7sSEX
 2YuVwWR8ekBc1K9hoZrL35It/acpc/RBcyhBgJkVSfMRNzdSf/a4jDXSo0v6cQxQ
 DIufxOC4g0owA2a0/F59Tz9bxl6wXE7Ndx8r35Ib1/JxDtZtJY4h0HNTSwy6oZqi
 hZt/FA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy12spk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 15:06:53 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-737d2f02d2fso3467127137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785251212; x=1785856012;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jzk0wHYCJIe5nmkz4JIZUJPyE7lMjwoFgqtF0y0W4q4=;
 b=jyvq8Clt3s0B6mSHSrXqraxh/0nO/+OnvFYeeviW0PSwOnFxfI3gMjRL9fbFOUbpzY
 mGFTULpv1a5QTcMHA/PIQaEHaBOCV7pppJR63b3lUE8eNlBR2C/y9FeI/S0EC60c+Mgw
 IEqL73GbJW1rk0Es9mSqPJWnG79k/mYX9/t4ew/OW9rYGuip6ofwnGl+14GXnt+itUpx
 bcoRpqx3YQ9CH9tD2Q7EBhRod4vcITuROwhvgfZK7/YJHEAtezXVoDx4xsA4KUNDe9GY
 F6wwmaoihPTIkXKQpAiUX8an29TEluCnM1i0aJDpMvGXkWimbWkFwV+w5MdxXac+3W53
 Vx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251212; x=1785856012;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jzk0wHYCJIe5nmkz4JIZUJPyE7lMjwoFgqtF0y0W4q4=;
 b=JhFMFN1d2p5y3u+khOt3WWgKc3oRmoDXqI7rk+0A+gPFqwNDvo+eRhKc0FzgtJ9yQf
 P5FpMf64DX8o1hbDA+nCMye7rweVsCr+nkQxoAt5+Temq2yn5ghbJ0uU7FZYwiIjPyAN
 UVUcZKiVGln8l8kpL+GFHU9iOh+ig5jZ4/+r1jA6VOt8k8viRpGBm3SeBdEVCLL7vLvM
 D6AEuB0+XjNOqqkRF2To6b90mRqu7N+ob5/FmFckPe9cHb7DzT+dpiOaOopFQ6+d4vaO
 N5LAcmRTeh8hX3oAp57zc/umELt85CqEI67dJz7RYVYqFzbvLful/AMi7e9Yv0E7DZMl
 56Cw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkoBZ4kziH8iT0N2OOeEcCpd+59zBnPOVyVWz7fzpPREJTfSRpgKZ+N6IBmYfXgXY6OXMkydXVOqk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSgJcWsnRiX7jnf+NRwA9P1VZo7lw4/3oRKmFZ++aavWDIaOJJ
 1B70p2zsDynzIWuJS3qHr/yhxZhcZgl9fpJr+zaeiP+7cR7SvBrJXchgBFylgfVht+Z8bWQrXYW
 5Dk3ir0DAlEFpwNYu/tLvQR1a+ySJKAiRGyd3eB7dyb4jfCPMi+N1qXjHMfYVeDzVC2Q98rU=
X-Gm-Gg: AR+sD112yAmx2xb+5xA70kdt7DwpjMTj4rR2fkarzc7Kz/F9MEua89MipUYzwAAT3Wd
 AZCh+45GCFcPNVQVgncn7Fq3joYqXNCcC4t4FF8MscBrvmWIs0ZypY2cadETAklkLRd5xRYwmgL
 f9C9yfT8YNScvs4UZhLVyML23SqiBdWwgYiILlIy2R4xYf0/K+NEdWI683fwZpfJOKPMst6tnav
 zGqOJeMMLSawtU2OuRdED7dYBrG7FQivm8sk5JMBxgl/giD5JjLrvMo5hxPLUKtTwUT7szBSudl
 q/iBXOlxRaMWJOcaEu0FFZIAXBnTm6NCxQ6QtbH6pIbw/14O1X0tdBbyJNs+XZZvE2lFlnJt9/q
 VHYDF45Idb+4ReBO7MeM96GO+Dgw=
X-Received: by 2002:a05:6102:3f13:b0:727:fb8:f269 with SMTP id
 ada2fe7eead31-754a1fc3789mr1383404137.22.1785251212268; 
 Tue, 28 Jul 2026 08:06:52 -0700 (PDT)
X-Received: by 2002:a05:6102:3f13:b0:727:fb8:f269 with SMTP id
 ada2fe7eead31-754a1fc3789mr1383369137.22.1785251211806; 
 Tue, 28 Jul 2026 08:06:51 -0700 (PDT)
Received: from [192.168.68.112] ([5.133.47.210])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c1c32ac0fa4sm782164166b.20.2026.07.28.08.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 08:06:51 -0700 (PDT)
Message-ID: <7761fab5-089a-463a-8de9-1922da2ff602@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 16:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fastrpc: Drop unhandled DSP PD exit notification
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260728073851.682023-1-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20260728073851.682023-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: t3VHVslY1EXdE_WPWKzkgBOjVhG-llrm
X-Proofpoint-ORIG-GUID: t3VHVslY1EXdE_WPWKzkgBOjVhG-llrm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEzNCBTYWx0ZWRfX237aXPqcrvAg
 pGGO3GCzpO88ss+gKmGfeYCCnVJ6AEdcMFT1Wkt8Ocg7aXiQTYJqKSCMgef5hmRPZ1VJ7gDhqFt
 9iXIWncqcK000NqI9gAdbTN3EibwhyxXV0Ld1pJo4+wlUTGYlpBmvaZ8Tg8oBHE2lzD9QF+ZtXV
 2GNzZRRN7Iqie2HIe3LHAXgSPUgTV70ZBKSTpsJBqb8Uag3S++skwskEhic3tMAp3J+J6VFC+Oo
 aVJJmFpXQPzHpntGMYt+NE3ocRGK9G09vLCPQWBG/uf5Ti0wUABAOMXwz+pzSRGIw/weYXvMDqm
 3mZZCeT2zNtWObGzVTFYv440mj8tJvOg01icVZxMcX3j/56Zr6e0L2Uj8LoQut6Acl2r6X40r+r
 ujAYcON3gdg69UsINYPegR4VCRtIM7O+Ny3ZJ+xcrMYlTmrgaD6spFjsVD+MyVhTLkxNOwQ/vJ7
 5c04SvPSaLcsP6wohHg==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a68c58d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RPlQG0zoIX3xp8xdtFQA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEzNCBTYWx0ZWRfX6W8fGNEClBqy
 9Uz5Fo6r5sraTORaxu+ylp1P0Co/btLElDrMZcgBfLLQT3VPDsedsEPOO3qVC6WcMeOiLiNi4Cv
 MPkshklB3lv2MEiMLTB0WEPsM46VLV4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280134
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



On 7/28/26 8:38 AM, Shawn Guo wrote:
> Newer DSP firmware implements a PD (Protection Domain) notification
> framework that sends PD state notifications upon request. The PD exit
> notification is unconditionally sent by the DSP with a fixed sentinel
> 0xABCDABCD in the context field.
> 
> fastrpc_rpmsg_callback() treats every inbound message as an invoke
> response, so the sentinel is masked and shifted like any real response
> ((0xABCDABCD & 0xFF0) >> 4 == 188) and looked up in the channel's
> context idr.
> 
> This is not merely cosmetic. In the common case idr slot 188 is empty,
> the lookup fails, and the driver only logs a spurious "No context ID
> matches response" error on every teardown. But the context idr is shared
> by every protection domain and the listener thread on the channel and is
> filled cyclically over [1, FASTRPC_CTX_MAX]. If slot 188 holds a live
> context when the sentinel arrives, the sentinel's return value is written
> into that unrelated in-flight invocation and it is completed early.
> 
> Since neither the fastrpc library nor the driver supports the DSP PD
> notification framework, it is safe to drop the PD exit notification
> before it is ever turned into a context lookup. This removes both the
> log spam and the mis-completion race. A genuine response can never be
> masked: a real context is (idr_index << 4) | pd (at most 0xFF3) and
> can never equal the sentinel.
> 
> Assisted-by: Claude:claude-opus-4-8
> Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---

Does not apply to linux-next, can you rebase it pl.

thanks,
Srini
> Changes for v2:
> - Update per Ekansh's input about PD state notification (Thanks Ekansh!)
> - Link to v1: https://lore.kernel.org/all/20260727130940.577721-1-shengchao.guo@oss.qualcomm.com/
> 
>  drivers/misc/fastrpc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d86e79134c68..97c60271f94a 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -38,6 +38,17 @@
>  #define FASTRPC_INIT_HANDLE	1
>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
>  #define FASTRPC_CTXID_MASK (0xFF0)
> +
> +/*
> + * Newer DSP firmware implements a PD (Protection Domain) notification
> + * framework that sends PD state notifications upon request. The PD exit
> + * notification is unconditionally sent by the DSP with this fixed sentinel
> + * in the context field rather than the context of an outstanding invocation.
> + * Since the fastrpc driver does not support the DSP PD notification framework,
> + * this message must be dropped rather than matched against the context idr.
> + */
> +#define FASTRPC_DSP_PD_NOTIFY_CTX	0xABCDABCD
> +
>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
>  #define INIT_FILE_NAMELEN_MAX (128)
>  #define FASTRPC_DEVICE_NAME	"fastrpc"
> @@ -2552,6 +2563,14 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>  	if (!cctx)
>  		return -ENODEV;
>  
> +	/*
> +	 * A PD exit notification from the DSP PD notification framework carries
> +	 * this sentinel rather than a real context. Drop it: a real context is
> +	 * (idr_index << 4) | pd and can never collide with this value.
> +	 */
> +	if (rsp->ctx == FASTRPC_DSP_PD_NOTIFY_CTX)
> +		return 0;
> +
>  	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
>  
>  	spin_lock_irqsave(&cctx->lock, flags);

