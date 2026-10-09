Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B726DCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D1010EAD3;
	Fri,  9 Oct 2026 18:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="LXgUIK4u";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F65810EAD3
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791570779; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ndIOPv8r0Hu3BFCMKBBrrCeakt4nEErRREnecNyS2TD0emNOMXOgEj3qaHSBVT4IEJBp21Yn+w/EmgPMrPhruiRUnqIL9/hrAHjKNGovL5h+frJb1Kuw+JvQglHVjnJFCtenJNm4N1PLYOmtgHR/gDBes6fKRr3f37Kvf9JBmOg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791570779;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SNDtFTIyhLZv5ilCpSSEHjpugz1pSbUUO54QyH+Q/rY=; 
 b=Lcw7CPUxK4WV5N3wsUGlD6JKtBwQyje7X88VVly6l01BnF85vQbZb+59u38fVliJi0T9dvIIHKB5WYKo2C0fQuBIWS4OjljUY1cOUhQ9E07/jq/FYlpFTDoukLP88MoockrU0mZaCv0gL2900U54iwmghOhRiy4G12CSS6uo0P8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791570779; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=SNDtFTIyhLZv5ilCpSSEHjpugz1pSbUUO54QyH+Q/rY=;
 b=LXgUIK4u2x1Pvt2tgngFsxStsuP3qyLB3SAQFibqGi6n//mxCqKNKLq4EJ80Fwg9
 Vx+FozcIJVndIouC7AlWshTIBcQ1d9QZXgawV+0/6FNk5hQZIK1732BZTwIrmy0NDYo
 MFWihW3TGZEih6iQ2YEe1hkzgWOuEfBvdNQ+0CFw=
Received: by smtp.zohomail.com with SMTPS id 1791570778259984.4383563393213;
 Fri, 9 Oct 2026 11:32:58 -0700 (PDT)
Message-ID: <69e33ec9-a0bc-4d02-b20d-9c0c03236a42@collabora.com>
Date: Fri, 9 Oct 2026 21:32:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: Honglei Huang <honghuan@amd.com>, odaki@rsg.ci.i.u-tokyo.ac.jp,
 airlied@redhat.com, kraxel@redhat.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260924095556.1326164-4-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

24.09.2026 12:55, Honglei Huang пишет:
> +static struct dma_buf *
> +virtio_gpu_userptr_prime_export(struct drm_gem_object *obj, int flags)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static const struct drm_gem_object_funcs virtio_gpu_userptr_funcs = {
> +	.open = virtio_gpu_gem_object_open,
> +	.close = virtio_gpu_gem_object_close,
> +	.free = virtio_gpu_userptr_free,
> +	.export = virtio_gpu_userptr_prime_export,
> +};

Is virtio_gpu_userptr_prime_export() optional?

-- 
Best regards,
Dmitry
