Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FE8C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7078310EC98;
	Tue, 30 Jun 2026 13:17:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="SoZFKDcP";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D094110E212
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782825458; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FfUKkEaCXJeFEQNUxbJo3AZ1UNgYjnFvHWqO2RjDUFGEkoj1L10m5n9f5Zh1rs42wGR/YL2KNjuPD9VNC/DiBuK3BTq/QKVzeOFbOFcg6TI6Vao9sccNXENsI6zJcRXq/atYzSQvQTFALmrAuvtlh3FlbQbehuFySZBPoFKpFqY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782825458;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=l/Gb2r1RUizRn8tgbt0oiaU7MKiOg59aENHKzJck/80=; 
 b=AMz/8tr1qyWeZOnaQWpo6WmLkdI0PhCcuHXVTtfO/SLGbhJ5TaptPMjNu0bJ0VSiKmNbLNVYSpjxnKWcZY7rYh1+OrqrKLXcqv/sV5p/k9rU6venxvskiipDvHhywTFG5Nx2Mhn9Y1Ol0JlSofUxluHmkyLYtNejHyQdGP2ctLk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782825458; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=l/Gb2r1RUizRn8tgbt0oiaU7MKiOg59aENHKzJck/80=;
 b=SoZFKDcP3STBZcAKh3qM2yEjfpRJmHCFcNOk7/PlRTeh4yJbcq/haBtVU8LVn98y
 TO+qrudh+y9PlHZnDoHsoEDQJZbZ2wVVEUp0+jlq+R2fqLCaMkPZGt1K6PTPMuGeKtq
 UY6MfNe4YK75XMSyQZAlyi1MVxMigaxYskOGUOfI=
Received: by mx.zohomail.com with SMTPS id 1782825456755695.4332253165277;
 Tue, 30 Jun 2026 06:17:36 -0700 (PDT)
Message-ID: <36a2a25f-c73c-491f-b889-5a0c4662bced@collabora.com>
Date: Tue, 30 Jun 2026 16:17:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: bound EDID block reads to the response buffer
To: hexlabsecurity@proton.me, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
References: <20260620-b4-disp-22bba7bf-v1-1-b95924cee742@proton.me>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260620-b4-disp-22bba7bf-v1-1-b95924cee742@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

On 6/21/26 05:43, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> virtio_get_edid_block() validates the read offset only against the
> device-supplied resp->size field, never against the fixed-size resp->edid
> array. The EDID block index is driven by the device-supplied extension
> count, so a malicious virtio-gpu backend can advertise a large size
> together with a high block count and read far past the array into adjacent
> kernel memory, which is then surfaced in the parsed EDID (an out-of-bounds
> read / info leak).
> 
> Also reject any read whose end exceeds the size of the edid array.
> Conforming EDID responses stay within the array and are unaffected.
> 
> Fixes: b4b01b4995fb ("drm/virtio: add edid support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 67865810a2e7..c8b9475a7472 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -897,7 +897,8 @@ static int virtio_get_edid_block(void *data, u8 *buf,
>  	struct virtio_gpu_resp_edid *resp = data;
>  	size_t start = block * EDID_LENGTH;
>  
> -	if (start + len > le32_to_cpu(resp->size))
> +	if (start + len > le32_to_cpu(resp->size) ||
> +	    start + len > sizeof(resp->edid))
>  		return -EINVAL;
>  	memcpy(buf, resp->edid + start, len);
>  	return 0;

Applied to misc-fixes, thanks!

-- 
Best regards,
Dmitry
