Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9886CC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C3010EDB2;
	Thu, 30 Jul 2026 04:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fir2qQNx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iK0MiFtr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D996D10EDB2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:52:40 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U4ZeQh3459197
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kTnb0bbBTOh0ujs8xWkkOVPWXcBEgS7OoCRQ+dvQBes=; b=fir2qQNxhq8EnkM7
 DvTLumrNy8XRHoHnQEsATqTf0fbMZyUte1xt2nwo8+jSAV5pfVyMsxhXXptxFqD2
 XURBZg3KGec47VkFQjsEzJUWpvTOnQaq00AkH8cO8YavrB7cYzI1pnmZcXaDatPs
 7VIJCzlHL6H3eGfTNCsh4b0x6WJbJ5LWADmMIXovkbOsysT9XnGaij5rNPMQ5iOO
 MagHalEgOEfyYhknPKBMkP5tyNwTOpKvvngGl7WwejYFQ1W3UWWfhr9fjIWgUNNe
 sPLZv5noskD2EB7fMc4gEcYa2cmbljuXCYq3LM9L3OenaXlgvU42Di6rTuBUNRCS
 62u5MA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqyqn821t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:52:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so1408583a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 21:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785387159; x=1785991959;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kTnb0bbBTOh0ujs8xWkkOVPWXcBEgS7OoCRQ+dvQBes=;
 b=iK0MiFtr6Khks8VB6ZXwHTQrOsjVTQfncxoJAyeAcPBUqzmhw4rV+3lIW62tWnLP+S
 tXIpSTHEtxmZxW+pnOwulkp9+od085ESty3Dj6hoqG+vnKJ2NMk6Tuo3XGt2I1NqAxCf
 v92XYRusq8osOHitTNGxecQt22Jo1DamsStab1Z0gJJj97zvf94vLiwYSVcT2np6NORH
 6ea7gFDYO9fs+LCNcEfjot8zgtOtd38wENfsYztwMSApejQnPSjNz6reDWwKXHf7w491
 E/gi1ZvluKe2QHnwJ/bij8To3l4sQEnTZSeiU6WXq85aDpJ88M8cB5S/RBSZxFG9GZNh
 vQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785387159; x=1785991959;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kTnb0bbBTOh0ujs8xWkkOVPWXcBEgS7OoCRQ+dvQBes=;
 b=dOIK2vgPi4uZ4axaMh9YHHeiUIPntEkNs/9j2DUJyQcA+Jupyrr3wF0Tt9vKygdIHj
 uPFtcL5u9HP7aBoLPAKubR9tb5SfF6/wpdQdkjJgFwMi1IJIMp54JTm4I0j4aoFimhl3
 kGyGMuz9sSLhqagIf1krAuRIiH1eS2EfORCpx65pJyQnBLb2BGulm3VfKvLNfKR0K/rN
 CQBYlnshtrqjZX17exrqnJYnj1KB/sLwenjT9po/NR9BJ4v89bLsQkJes9KUM+HPhcAs
 JGrLq2sdfTi1vWvUfkoZNssuYENp7PFZSYeCf57CgCCb3vyoT6k++ztRM4OEICscyio4
 zhEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RohavQERb52Uq7uj9o+rG1ztLvTKqD7HtD8tOsMeP61/i9mYMNRLmX3oM6mCbGU8QgFC6y676rPS8I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzwg49RVbihhU/S8jaZnXEfaKA0X94ViF145lzDnKHcPiyPdPp0
 5dAUCrN5/KjLDOyMtaOi5m1U543MEXv8j5C/jOt2t/12Ln0aldn/U/c/P7zbw1GFDAu9/WprWZ7
 88W/TXHE8GKdDjW8SvjvIvfkIoCMetBg+hShVGQ5J3xF2qjchOzQSWJC/2Wk2/8ezQQtEn6iLdp
 E1JCQ=
X-Gm-Gg: AR+sD13Vwaby/3ZTRGrV8YgkZTXILw8k8RqvdQywdv6cFsyszfD3U7WphsDJDVymxcx
 8fzw2D8+/9y7iGieoqcn7TUpN/Ti9ngW3wedwsPz+V3Ct//1ddqk4shCvI/xjmqtEhd0iUnCZpQ
 G9DWztk5IZGHtWrnvIkjYLGs5XJk1mqB1PEiHXAeW6jUatHPCAAQ9SgXiwCzwe6ZOsXg15so8w1
 ysDR108tP4MUcP29PexttQdWfk5+LX56/i7UKLXgNpKQwxqBgIRPmArKNjypzHIPg3j8rI9rjpp
 HVpKHLoad6KfPcgj0NOklNAe7BvilKHk1UPkPotcos84yK+xTPhlFoDgl4iRJwzFroIBmDjlBrh
 FYyGjl5EpX/DNlm3slaFOV0FjUdLd6A==
X-Received: by 2002:a05:6a20:7f99:b0:3c4:42d9:58e3 with SMTP id
 adf61e73a8af0-3c90066b1c6mr1078121637.13.1785387159500; 
 Wed, 29 Jul 2026 21:52:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f99:b0:3c4:42d9:58e3 with SMTP id
 adf61e73a8af0-3c90066b1c6mr1078107637.13.1785387159035; 
 Wed, 29 Jul 2026 21:52:39 -0700 (PDT)
Received: from [10.204.78.242] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb78ae98asm1601217a12.1.2026.07.29.21.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 21:52:38 -0700 (PDT)
Message-ID: <7942487a-1a1c-41bd-850b-25f1f4bb0773@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 10:22:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fastrpc: fix UAF and kernel panic during cleanup
 on process abort
To: Jianping Li <jianping.li@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
References: <20260630063409.475-1-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260630063409.475-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMCBTYWx0ZWRfXxuC3EwKxpVdZ
 LFBzT16dqHVibIZJqZGCnUmXUa9/vX0lIP2iQUcaNtfWBueYBreJOtaeUsOzsVPySScfg5RnjEX
 1PpP8vOCGVmO/vnnw75geXZq7NTHvV0=
X-Proofpoint-ORIG-GUID: tBI5maMA4lCpKaDrl0dPS7RsZgO4iha8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMCBTYWx0ZWRfX9wDnIVPpk+Yw
 3T1UXNKUfscAV59rYP/GK9OCYVbqjC/xyXM5i+apFpZm8BkuNzx/YenNBpEFbANwbhImcknFzp0
 H9SXHIkk/C8FJETuNxulPv5w4hm4sqoYcMnC6W6ldK3RTIg8AGwy5c8VQ44ehsgKTAvnwgKT4UE
 p5SEVaVkbVhSlrkKEKTAaNeXvBTKChHG0m18CVy94jatxLsLhnW7r840plGK70eiDX1BLzt6mMw
 bZr/kIK9mHWTX5HO00pH9nFXWtzWQkReTUc5JBs4z65gTM99tefeODstcXuLC8mVlyEUU5GfPTz
 nURo8smP8JnJto+peZ+dC4Cue7MLCTeZidb7S+r+zlQHs1ney3K+MrJC/XX2dPtSiZgLCQVheBi
 LBTtoYhjB7EAx+8PzE4YmJn50nlSu6oc3O3b01Mtkj/XEl84ihBBPfdBspkdz2cZamRVTIMpg3l
 OEs9cfNNcIm2sW0LQYw==
X-Proofpoint-GUID: tBI5maMA4lCpKaDrl0dPS7RsZgO4iha8
X-Authority-Analysis: v=2.4 cv=QdRWeMbv c=1 sm=1 tr=0 ts=6a6ad898 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IFEFMmON-DzK0gGTnVEA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300030
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

On 30-06-2026 12:04, Jianping Li wrote:
> When a userspace FastRPC client is abruptly terminated, FastRPC
> cleanup paths can race with device and session teardown.
> 
> This results in kernel panics in different release paths:
> - fastrpc_release() when using remote heap, originating from
>   fastrpc_buf_free()
> - fastrpc_device_release() when using system heap, originating from
>   fastrpc_free_map()
> 
> In addition, fastrpc_map_put() may trigger refcount use-after-free
> due to concurrent cleanup without proper synchronization.
> 
> The root cause is that buffer and map cleanup paths may access map
> and buf resources after the associated device or session has
> already been released.
> 
> Fix this by:
> - Introducing mutex protection for map and buf lifetime
> - Serializing buffer and map cleanup against device teardown
> - Skipping buffer and map operations when the device is already gone
> 
> These changes ensure cleanup paths are safe against unexpected
> process aborts and prevent use-after-free and kernel panic scenarios.
> 
> Fixes: c68cfb718c8f9 ("misc: fastrpc: Add support for context Invoke method")
> Cc: stable@kernel.org
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 57 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a9b2ae44c06f..3521518f9fe5 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -255,6 +255,8 @@ struct fastrpc_session_ctx {
>  	int sid;
>  	bool used;
>  	bool valid;
> +	bool allocated;
> +	struct mutex mutex;
>  };
>  
>  struct fastrpc_soc_data {
> @@ -335,9 +337,14 @@ static inline u64 fastrpc_sid_offset(struct fastrpc_channel_ctx *cctx,
>  static void fastrpc_free_map(struct kref *ref)
>  {
>  	struct fastrpc_map *map;
> +	struct fastrpc_user *fl;
>  
>  	map = container_of(ref, struct fastrpc_map, refcount);
>  
> +	fl = map->fl;
> +	if (!fl)
> +		return;
> +
>  	if (map->table) {
>  		if (map->attr & FASTRPC_ATTR_SECUREMAP) {
>  			struct qcom_scm_vmperm perm;
> @@ -356,10 +363,16 @@ static void fastrpc_free_map(struct kref *ref)
>  				return;
>  			}
>  		}
> +		mutex_lock(&fl->sctx->mutex);
> +		if (!fl->sctx->dev) {
> +			mutex_unlock(&fl->sctx->mutex);
in this case, should you still delete map from fl->maps list?
should you still do dma_buf_put to remove dma_buf reference?

Also, there was a recent change where fl refcounting was added[1]. Can
you see if you can take use of that mechanism instead of adding checks
at all these places?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/misc/fastrpc.c?id=e85eb5feca8e254905ffa6c57a3c99c89a674a0f>
+			return;
> +		}
>  		dma_buf_unmap_attachment_unlocked(map->attach, map->table,
>  						  DMA_BIDIRECTIONAL);
>  		dma_buf_detach(map->buf, map->attach);
>  		dma_buf_put(map->buf);
> +		mutex_unlock(&fl->sctx->mutex);
>  	}
>  
>  	if (map->fl) {
> @@ -422,9 +435,18 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
>  
>  static void fastrpc_buf_free(struct fastrpc_buf *buf)
>  {
> -	dma_free_coherent(buf->dev, buf->size, buf->virt,
> -			  fastrpc_ipa_to_dma_addr(buf->fl->cctx, buf->dma_addr));
> -	kfree(buf);
> +	struct fastrpc_user *fl = buf->fl;
> +
> +	if (!fl)
> +		return;
> +	mutex_lock(&fl->sctx->mutex);
> +	if (fl->sctx->dev) {
> +		dma_free_coherent(buf->dev, buf->size, buf->virt,
> +				  fastrpc_ipa_to_dma_addr(buf->fl->cctx,
> +							  buf->dma_addr));
> +		kfree(buf);
kfree should happen unconditionally here, it's a leak if you skip it.

//ekansh> +	}
> +	mutex_unlock(&fl->sctx->mutex);
>  }
>  
>  static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
> @@ -447,8 +469,11 @@ static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
>  	buf->dev = dev;
>  	buf->raddr = 0;
>  
> -	buf->virt = dma_alloc_coherent(dev, buf->size, &buf->dma_addr,
> -				       GFP_KERNEL);
> +	mutex_lock(&fl->sctx->mutex);
> +	if (fl->sctx->dev)
> +		buf->virt = dma_alloc_coherent(dev, buf->size, &buf->dma_addr,
> +					       GFP_KERNEL);
> +	mutex_unlock(&fl->sctx->mutex);
>  	if (!buf->virt) {
>  		mutex_destroy(&buf->lock);
>  		kfree(buf);
> @@ -491,6 +516,10 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
>  	struct fastrpc_channel_ctx *cctx;
>  
>  	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
> +	for (int i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
> +		if (cctx->session[i].allocated)
> +			mutex_destroy(&cctx->session[i].mutex);
> +	}
>  
>  	kfree(cctx);
>  }
> @@ -855,19 +884,28 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
>  		goto get_err;
>  	}
>  
> +	mutex_lock(&fl->sctx->mutex);
> +	if (!fl->sctx->dev) {
> +		err = -ENODEV;
> +		mutex_unlock(&fl->sctx->mutex);
> +		goto attach_err;
> +	}
>  	map->attach = dma_buf_attach(map->buf, sess->dev);
>  	if (IS_ERR(map->attach)) {
>  		dev_err(sess->dev, "Failed to attach dmabuf\n");
>  		err = PTR_ERR(map->attach);
> +		mutex_unlock(&fl->sctx->mutex);
>  		goto attach_err;
>  	}
>  
>  	table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);
>  	if (IS_ERR(table)) {
>  		err = PTR_ERR(table);
> +		mutex_unlock(&fl->sctx->mutex);
>  		goto map_err;
>  	}
>  	map->table = table;
> +	mutex_unlock(&fl->sctx->mutex);
>  
>  	if (attr & FASTRPC_ATTR_SECUREMAP)
>  		map->dma_addr = sg_phys(map->table->sgl);
> @@ -2246,6 +2284,8 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	sess->used = false;
>  	sess->valid = true;
>  	sess->dev = dev;
> +	mutex_init(&sess->mutex);
> +	sess->allocated = true;
>  	dev_set_drvdata(dev, sess);
>  	sess->sid = sid;
>  
> @@ -2260,6 +2300,8 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  				break;
>  			dup_sess = &cctx->session[cctx->sesscount++];
>  			memcpy(dup_sess, sess, sizeof(*dup_sess));
> +			mutex_init(&dup_sess->mutex);
> +			dup_sess->allocated = true;
>  		}
>  	}
>  	spin_unlock_irqrestore(&cctx->lock, flags);
> @@ -2282,6 +2324,11 @@ static void fastrpc_cb_remove(struct platform_device *pdev)
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
>  		if (cctx->session[i].sid == sess->sid) {
> +			spin_unlock_irqrestore(&cctx->lock, flags);
> +			mutex_lock(&cctx->session[i].mutex);
> +			cctx->session[i].dev = NULL;
> +			mutex_unlock(&cctx->session[i].mutex);
> +			spin_lock_irqsave(&cctx->lock, flags);
>  			cctx->session[i].valid = false;
>  			cctx->sesscount--;
>  		}

