Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26370C531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 03:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0A910E509;
	Tue, 28 Jul 2026 03:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RoxL19td";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LFjROgK5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1105110E509
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:47:41 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aZ7s1714770
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yo/lWxHJw9yNZPh3KLPiwdIL7Wsz2tn7HHED+a/H1h4=; b=RoxL19tdNYhKSsSr
 ivep5JCeOPtMK9paYkEeGCn2c8PH3H6DYpB5QybV5YW6aaAXRKmzqHqpFQHN0swb
 wUhEsoDsx7C+4QIeU8osOvGyk34/YL3cPBwyBgx6lhFk3V/vXIVz7BagSQo3F5WB
 2/P4fndKqM/zv8i5EFQHj6L02N3BJMJeOVac3/AIwmYrCC+R3HzfYMbtEnTzBDb7
 ido4KdQG5JOVRnnIrEgvSnLp+qbln+LDGpPCZx+scYLm0J2hNkDe0otvO+ZARIl2
 eXSwQi0RLsY7FQin4OAgjeI3vu5Hc9pPCQWk0eRVSUijibPIwoqGado8Fav/G4wJ
 go0haQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkjsc3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:47:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-848d21bbb55so5428231b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 20:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785210459; x=1785815259;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yo/lWxHJw9yNZPh3KLPiwdIL7Wsz2tn7HHED+a/H1h4=;
 b=LFjROgK52gRA4N0F67GvqWO4O3YGX88oBj2nm2v0kSTlPHQU4GtviDvkJ7X1hYYYD9
 3JTO1Z4aUXC+GdcKoJf/sFOlq7XAT56Tee64xJPR9IF9J9tAJyDBz9bD02yKBhbm1alm
 pDwupzs19DNMHqIal/FZLyuFmqzgCSA/neMS89avFTTnq2bV+8r0AoD66eF/lNaD5EwZ
 sUuB3JaP+g5PEJ4SdubxdH4h7LN5L3ihut0Z2sAHrvbzKby/g5J+G8N4XIvx4MorLFqt
 yeVs/0v9ExnqQbxrrwb3m507eH+hL2ErCY5lxVbUyCumFuOCUgEtRg7e7q26QTN01TA1
 5bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785210459; x=1785815259;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yo/lWxHJw9yNZPh3KLPiwdIL7Wsz2tn7HHED+a/H1h4=;
 b=h+NkI8L6AekM59aTZWJSfGdYKx9EhB8P4XvMzGdtr0H2y4w/LP+ePCvRnCSW7vJ8/f
 maUhieEPd2wCXj7M2xARvp9uNiAJ4jGgQVO0rXp+p4147bFLR49AvYEJmNv+IwdriWTp
 16oePA6KKtRQCDmyN3Ae8cqtZ1FNgqiw/U+pbXVqqPBS+ILq7pScsiuthV15NttnryfU
 psPu3WbIutFJswpl/SUsLoP4sG3ysYwSM7QjZnJKqvud9N8wI2gQWQpUgvrx9Jpw2D3k
 6DbfE/v+d4e35M7OfIhyFN+PQISg5jYGkvHyMEMJR8kpWBYoCy6QDyVy2xzAH/KDDG/E
 xdBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpgNOJM9n/1tSoSOAfHHEqgTUcAQmTUuGQvllYoQjr3q+8zlf+LcKfSNH3yYmO/l1uTOGiBGtWiE/k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxv3H/BITugsUIbAWM4HfhHUu5hOpxVoAA0RE0x2OZWAc1a5t6Z
 ov3MaewvslqhObg0vlMqK7WRYNap/6xcvZAsmrY20b4YX9UeXZ49rs1dGvVbefGsp6nJaB/Mi41
 fayd2+dFT5c1lyD1V4VM43v0kVi9UKJG3DZC0ZTJ+Wb01AxLJRMOpll93vV28Qq/jSCcjPU0=
X-Gm-Gg: AR+sD13e9qFqs7OzYGiyOFhWeTZ5FsKehbKgiSvCdr1NI3S2I74gyf4xs8XrgKnvzyf
 lhlJgrYLzkzHCGKQk8wTsP8by/jGBfDe+WxA5PSDjo2/nuqnTw0n60j1DsVwuGcu2zLppESa7jw
 fqpSfdURAl2u3m3xmuSx/EP1LxDrmAJvtSc2JrKxhPytGS/EUcL2O5qdhl2ajS2e7Hbpclfm4P1
 Mz9DMHn998g6SaAZQBe9U96rUrhWrobKWsSNwINn3VYT/RVAvcWp//AzvWGFoSHodUM7lmfnBeJ
 7XZUC4yT/R75FXCgj8/HOEdKjIXDNol4Fw9ctnMa96LNo8ZMewBxAPwZHRM2QNmxL3pUSHMLdFj
 0qAD/9nroIjddXAT+FHCHR+2d8xNZUQ==
X-Received: by 2002:a05:6a20:6f93:b0:3c3:bbe6:95c9 with SMTP id
 adf61e73a8af0-3c8aaf877a9mr932516637.16.1785210459482; 
 Mon, 27 Jul 2026 20:47:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f93:b0:3c3:bbe6:95c9 with SMTP id
 adf61e73a8af0-3c8aaf877a9mr932490637.16.1785210459089; 
 Mon, 27 Jul 2026 20:47:39 -0700 (PDT)
Received: from [10.204.78.209] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc59cfb4sm37084511eec.26.2026.07.27.20.47.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 20:47:38 -0700 (PDT)
Message-ID: <3a83e00a-9e4c-4411-b554-1edb9d02c799@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 09:17:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: Ignore unsolicited DSP response sentinel
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260727130940.577721-1-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260727130940.577721-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Zu5lIrUFzHzS5Jb21oMwhMJwlpfQ5GuG
X-Proofpoint-GUID: Zu5lIrUFzHzS5Jb21oMwhMJwlpfQ5GuG
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a68265c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=RR3Qzd7dXdH_FvX10yoA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAzMSBTYWx0ZWRfXyCijMAT2svsz
 84bCAUmv28NyTW3EIRkGkxT87yrZ+c0rZqGLo6dCI0NOxby8DYGD9X3WT7+Mtdjb1Y97R6W4TlP
 yuExS2EcOlVZHBOmu/I37VoDG+g4uQyu3mSh4fFBZMrQ7rc0f+upz6Jf+uZYNWNpHjcAZuFEDQm
 OsxeDkqHl+PSt0VTV8dDwWOF2HfYh2b1+DuGZY/vn3JgXoX0v9757vJInzj7myvMvS0p9QUqcLv
 ZjigScPVrU7Ws3QPgyHtdt3slrYmZOilmD1PVr0QEU/Oz/XiHdP7EWA2ehx/mfzDepKtu3eQ2yg
 HiTMeBr5NhJciksEg0a7GeCM8Kj3InCXKzCpOI0GhCXmkBlDPl56lPCIyQ/9nII+lKI/wpdbeJO
 lSfCnB+TnfBdAbjI+JH+Wr/vTDmPB6NKYXs3pJvQz7HFlu6q2+NnWgTUlfNWi9SSlFZfHaF7egX
 ntpA3Kpjm+YN4z4/RVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAzMSBTYWx0ZWRfX/xZoyR192lrp
 dSfNFplljnYhjnmRXKylqMEnRC8zSCGbgGY5PVdOaNRTGjOsDD3he0SC4Vn6bf9jx+arqzZYzzD
 wkmIPVZ8/5XF9sqNXwdtRG0IqzNHSd0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280031
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

On 27-07-2026 18:39, Shawn Guo wrote:
> The DSP firmware on Nord targets emits an unsolicited glink message
> during process teardown whose context field holds a fixed sentinel
> (0xABCDABCD) rather than the context of an outstanding invocation.
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
> into that unrelated in-flight invocation and it is completed early. That
> is a latent, timing-dependent bug that just does not happen to trigger in
> current test runs.
> 
> Drop the sentinel before it is ever turned into a context lookup.
> This removes both the log spam and the mis-completion race. A genuine
> response can never be masked: a real context is (idr_index << 4) | pd
> (at most 0xFF3) and can never equal the sentinel.
> 
> Lemans and other targets are unaffected: their DSP firmware does not send
> this message, so the new check never fires.
> 
Sharing more details for this context:

On newer firmware, there is a support for DSP PD notification where DSP
sends PD state notifications on certain states as per user request. PD
exit notification is always sent by DSP which is with context id
0xABCDABCD. As of today, DSP notification framework is not supported by
fastrpc lib or driver and it's safe to ignore this callback.

With this,

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d86e79134c68..be9f102690f6 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -38,6 +38,15 @@
>  #define FASTRPC_INIT_HANDLE	1
>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
>  #define FASTRPC_CTXID_MASK (0xFF0)
> +
> +/*
> + * DSP firmware on some targets (e.g. the Nord remoteproc) sends an unsolicited
> + * message during process teardown that carries this sentinel in the context
> + * field instead of the context of an outstanding invocation. It is not a
> + * response, so it must be dropped rather than matched against the context idr.
> + */
> +#define FASTRPC_RSP_CTX_SENTINEL	0xABCDABCD
> +
>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
>  #define INIT_FILE_NAMELEN_MAX (128)
>  #define FASTRPC_DEVICE_NAME	"fastrpc"
> @@ -2552,6 +2561,14 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>  	if (!cctx)
>  		return -ENODEV;
>  
> +	/*
> +	 * A sentinel context marks an unsolicited message from the DSP rather
> +	 * than a response to an outstanding invocation. Drop it: a real context
> +	 * is (idr_index << 4) | pd and can never collide with this value.
> +	 */
> +	if (rsp->ctx == FASTRPC_RSP_CTX_SENTINEL)
> +		return 0;
> +
>  	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
>  
>  	spin_lock_irqsave(&cctx->lock, flags);

