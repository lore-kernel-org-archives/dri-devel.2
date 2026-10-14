Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA69CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C4110E0DB;
	Wed, 14 Oct 2026 13:07:10 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5367C10E0DB
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:07:03 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so35042455e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791983222; x=1792588022; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k5Xx2GBklmLYql9VZXZ+CeE2dU9lwoFm77pkgYHcd38=;
 b=GdRm/ikw+5657eCP1QIt/Oy7I8fSOOS2+Q2lvlZwB+C9qTSzxg4YYGTcfpSUEcrWbX
 5WI2MZZju+wke4GJqKP4bqQiV64fa12zelk8g50SKz1J28C2cMPA6WkwLujyN/eiz7eB
 r/FknksLH7RWVeTTXIRNfHzTHY5PUeH0OayfDXadZ1IOCNChbXiz6sHDVVxmt3bTb5J9
 bmjczAmLVdbiMLStMqnsqG8Np8rrn/vqOgCVsYBDH9ykBCOYQgEt2FLzMv5Vfr/HNbSj
 ry/XaLH5ZCKNicbj3U2GMN5x1xeW6RxuVtw+3dETh2ALs7SzoPbD6BwI4b0fk61ORJe2
 +u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791983222; x=1792588022;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k5Xx2GBklmLYql9VZXZ+CeE2dU9lwoFm77pkgYHcd38=;
 b=2FB/617XuyWMVNNarCeXgXDt6t1gZIj2R4iK+c5qtLku5kubAaOrPBmvJvdtcarW1V
 /HCL/1BLiHIY662zgrtXG1CdwQgR8cLjV9WM8VUG+aOnRt4XiVRCCPqyja9N0GTL9kbC
 UwvCYtv4RRRJrYaTWs+0421bxjZ4ICHEMy4+WLZg8yAnzrSV7a1Nwwc3jMav7L3BqZkj
 3QMAHAS+STAkLD+yIVe4pTalauZgZ3pjo8Ag83RiIlCb4NzchgxAYPVixeqe4CQ5O1w1
 ILXXPA7Yy7T29fGinI2ujGmTGo394qSHklL+iTe0A2iKElbI/Y6/K02sMLUgWctk9YLn
 HIhA==
X-Forwarded-Encrypted: i=1;
 AKwUvByLOwPEcWKELa78Hxgp/qHywWz8GPsSA6bRnpCScIS0UX3xK+kward8pduAQmFmRZUFDVqYx6wvs8s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI6dYn3qznnKnDddNTUj0bPDeQiF/UbHIf/BmSWRLaLAxYPSU1i
 ErHTgnVSv9QDpfrlNKplpXOZKv+asT/OLcOc9zSOzbIf1d1TMNZ/Mbvg
X-Gm-Gg: AYBFou0bhjTcdtAIgTE2d8vipJDUYVXn+3ctFcV7CsV01mXjI72RBRbgDFevb1eKVHP
 terh/kDspbjn2wj5EwxV3ruaDw6SXX30EfUprCINZza9A1TFM63ZU0nzpwh+pk1+VR0M/3/Hlux
 SpT0GUrvDiTqpW55CobOx7838yuj/8lquoE0fxsex5FxZSUZrkZDreUvWdJikzRlvfHCjOgCeko
 /IrfxiWCDqjLuZF/iylrM03i+s5r0GlTAWKijspNBJgS4rqrc6Jfuj90nvTt0DGc1u2/qU84K2r
 Qai98JrxKmlzQSW545Ahxxd2//O6R5cc2gRouqmTyuJWRkn03ZBH7ubn3PsFZ2haC+kDzy6dfwZ
 VNR4oN7yzqqEXAxMGoXdzVGLFwDppZSQYdtiZAHpaRMge1UnwwX+7Ss0G0HV+GrdYwDI4yng5xV
 Sf3/2LACjunqWlyPbFGoAb7BoUg/+w58Ci98oRQMNrqLiU5uTioL8BYilqYh9vLfmBoFuD+0PMO
 vI2rNUlpNs45R1YPFVx7zh9V4aixWEKVRwduNLQr2eJZXf6FX98/zQyzpfbRT0RJwRoBuIHymF2
 wUz71EwVnb9jw+JGFqZ5/fJuTLXe7XXf/OoKGmAqJPndCCLaZw==
X-Received: by 2002:a05:600c:6994:b0:49c:dada:30b7 with SMTP id
 5b1f17b1804b1-4a18e446f3bmr313643615e9.2.1791983221508; 
 Wed, 14 Oct 2026 06:07:01 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b3602990sm52779585e9.0.2026.10.14.06.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 06:07:00 -0700 (PDT)
Message-ID: <8d0e7d1e-086b-413a-87de-20e21f519daa@gmail.com>
Date: Wed, 14 Oct 2026 14:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, dm-devel@lists.linux.dev
References: <cover.1791975048.git.asml.silence@gmail.com>
 <49e24334953262e85d5616c9afde88c680e4f3a3.1791975048.git.asml.silence@gmail.com>
 <b461d367-8965-4798-b7ac-cffd4301cd1b@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <b461d367-8965-4798-b7ac-cffd4301cd1b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/14/26 13:30, Christian König wrote:
> On 10/14/26 13:01, Pavel Begunkov wrote:
...>> +static void dma_buf_io_kill_map(struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct dma_buf_io_map *map;
>> +
>> +	dma_resv_assert_held(ctx->dmabuf->resv);
>> +
>> +	map = rcu_dereference_protected(ctx->map,
>> +				dma_resv_held(ctx->dmabuf->resv));
>> +	if (!map)
>> +		return;
>> +
>> +	rcu_assign_pointer(ctx->map, NULL);
>> +	percpu_ref_kill(&map->refs);
>> +	/* make sure the map is not visible via ctx->map */
>> +	synchronize_rcu_expedited();
>> +	wait_for_completion(&map->drained);
>> +	dma_buf_io_map_release(map);
>> +}
>> +
>> +int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
>> +			struct sg_table *sgt)
> 
> You somehow forgotten the kerneldoc I asked for here.

Ah yes, missed that function. I'll add it but perhaps in a separate
patch, if you don't mind, depending whether we queue it for 7.4.

> Apart from that still looks good, but I had only time to skim over it.
-- 
Pavel Begunkov

