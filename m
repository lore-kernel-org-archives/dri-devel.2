Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A711CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A23610E127;
	Wed, 14 Oct 2026 10:49:37 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7B810E127
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 10:49:31 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso28221535e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 03:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791974969; x=1792579769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u2nQL6bRnFw36T6f08+48z7f5+GEhSRGAmBKimZJZ1g=;
 b=gKVyZ76IfsV4wLrgGd1FUit1TkYMN+QLh6uA/VoD3EGBjhIhjOPUH/kSXYO4EKGRFv
 jSPNSQABMbqX9oqiZLN/GqZCimGqF/Zlj/UKrZk5YLrej2AR+ehcxn1MLjfnb0YUtjan
 E0bRP97RRP0McKgNJ0jEKkiMPDH/2G50WGgpSDG3E4e783GOsfTDWjBy12tSdlIrQB69
 TRIZYeSt3lfDSY9RmmBMjF1R8RYsF73PxwuJx2qHUSNT9AeeJyLsTahYaux9pbvW4pVr
 ho5XV5xxS8vj9dt4QoVT+jLdj5GSWBM9kL9eNyXMro0L8R4LwnYfkyN+DdyiD8DqtSSU
 eUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791974969; x=1792579769;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u2nQL6bRnFw36T6f08+48z7f5+GEhSRGAmBKimZJZ1g=;
 b=WU28F5Bp6yiyFhOGQEdyHm9hTornfYXw2H2vWKtwF3t6OeyaaMb09NskBagsHGK+4R
 ofZUy/ZWv+3dTG2OvLJbnW4/HuK3lmZsdTeX4YT0kkfSS3onYEGjXBtk9koo5a+oN+pQ
 7q1m28prMENvEYNW2h0XUoIs7tiLa1l94CxW8vSqw8xb2JPgSH+05KTb3+kgHObFqi+D
 yFqduIRJzO3oV/yk8B6SiyRXtJEox9qniEx/MUtMKlc5p/0YL+1SFadHgpTejf8WSiDR
 C+faAGuBVM+L1JZFH6EzAJMfDhi+RG3/e42Uct05cVA8nPPi3deBMDR6d0qXJArdZyy7
 kgGA==
X-Gm-Message-State: AFq9FYKDsDZG5wbT/47tW4JHR5udnocHwf5FMkjW/IxgyDes1XDZrEah
 X1T8jNIEXY+7B2rInq8wCc72n5r7KOHwxa+/Lmko/WcMbyJbZvHGziTD8jDGZw==
X-Gm-Gg: AYBFou1EKZmkwqdB66AESy4bQa1glwzvnjEQu268Zzz0BvGHpVyiCWs8QhMbjyBSKQy
 epCpP1TNj9cvK11cK4qzv6PnLLNBFXi+mQv8hVHH1pOZCDmxkrB3r7NFX25D2jwKvEYimwHE0Ss
 sNOC+LPnizyNvMUN3/Ox9AKjw0lVW13mXEBU1voAF4/e+wgV9rdxNBaLvWdpQHioMdmOylLYYHV
 n+lL391kxJeKhvvhJIc5ePVDCzHnysjUWJ5ffK9kAY0FWAGMz62D/yMMl9UpBmEsQJZ9P1jhdBS
 bRMt5q/oVf3bpIWTY485zpm1PA3tFoKt2tjU/Lou6r0MW43cAAdjDR76w2mrDpH2yXkLGN+uFiU
 LoCDCbnWUvhyX4dk3OdDwQ1AdQiiGpUs9tjju9JJVyyvDqZ9t7q42j2Bqf9+rg095bX/08ncbUj
 o32vZemT9Tp/9wRZTp6/oCAR4YcEfD9NErE1lEwb/EvEEdk1RKpkUMdo6L9+Z1S/PJMZqWASMQJ
 GGqqka+7cHeqvbZGB3gXculHefSOfQeWWiGFt4pbKRq1aCmvoBUV/Kd+oCu/8PTRuVCMrqTc9oC
 jS0V6n84Hh8zNOSGRQ16zzsbuvJp64+tJ3uakVGvIgNYGLyVwhifqK+fQ5o=
X-Received: by 2002:a05:600c:1911:b0:49f:faa3:3ca2 with SMTP id
 5b1f17b1804b1-4a18e4aae7emr326111685e9.13.1791974969558; 
 Wed, 14 Oct 2026 03:49:29 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd733fsm11231494f8f.58.2026.10.14.03.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 03:49:28 -0700 (PDT)
Message-ID: <f430200a-c6a9-4e7b-b257-51b3968c2933@gmail.com>
Date: Wed, 14 Oct 2026 11:49:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/13] nvme-pci: implement dma-buf backed requests
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
References: <cover.1791924581.git.asml.silence@gmail.com>
 <a8c9ff112d4295e7a3f7c361e03f03ee5eb42e74.1791924581.git.asml.silence@gmail.com>
 <sashiko-outbox-170530@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <sashiko-outbox-170530@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/13/26 22:23, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] nvme: missing controller state check allows attaching DMA-BUF to dead PCI device
> --
> 
> commit 6741fe43dc1132ae4f51db272567ac5b56987f17
> Author: Pavel Begunkov <asml.silence@gmail.com>
> 
> nvme-pci: implement dma-buf backed requests
> 
> This patch implements DMA-BUF backed requests for the NVMe PCI driver. It
> allows mapping DMA-BUFs on registration and storing them as a PRP list to
> initialize requests. Attached contexts are tracked in a new list
> synchronized with a lock.
> 
>> diff --git a/drivers/nvme/host/pci-dmabuf.c b/drivers/nvme/host/pci-dmabuf.c
>> new file mode 100644
>> index 0000000000000..8dab59d936507
>> --- /dev/null
>> +++ b/drivers/nvme/host/pci-dmabuf.c
> 
> [ ... ]
> 
>> +static int nvme_init_io_ctx_locked(struct nvme_ctrl *ctrl,
>> +		struct nvme_dma_buf_list *buf_list,
>> +		struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct nvme_dma_buf_io_ctx *nvme_ctx;
>> +	struct dma_buf_attachment *attach;
>> +
>> +	nvme_ctx = kzalloc_obj(*nvme_ctx);
>> +	if (!nvme_ctx)
>> +		return -ENOMEM;
>> +
>> +	attach = dma_buf_dynamic_attach(ctx->dmabuf, ctrl->dev,
>> +					&nvme_dmabuf_importer_ops, ctx);
> 
> [Severity: High]
> Does this code allow attaching a DMA-BUF to a tearing-down or dead PCI device?
> 
> If the PCI device is hot-unplugged or its driver is unbound, nvme_remove()
> calls nvme_dev_disable() which cleans up existing DMA-BUF contexts via
> nvme_pci_remove_dmabuf().

Looks legit. Going to send a v11.

-- 
Pavel Begunkov

