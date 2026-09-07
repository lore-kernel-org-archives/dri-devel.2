Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3759C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E84E10E36C;
	Mon,  7 Sep 2026 13:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="L0QgZmHM";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A26E10E36C
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788786358; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kMXbtxrRPaJ+E3qhYLoNEm2le+buDeOVUx7X76PuBvAW03+pMY2a66PLSguK7z3W5SXXfK2Xirkv8GAnpZKMcyhBvwD4f+y8Ye67YCEzVVQpgzeTbYPTl+i4HPPsgDswvnOrsnh5CP+ZloejpY+sqzW/4ZCoJZrbkb2jsO85cPU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788786358;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Gf8VYP7N4hATDrTiZzU5GMGZ3enK1g/UcrmTROQWkzM=; 
 b=R/FHwu1RHXN279+TiOJtsYuWr36uyF3EOyacGEGIDaX011iSQDCNhZpbhBqG+PyuQ4ae4GTbL9OPEtdhZpfeNuSjnokGtVfESiRiCvwxGZsYRDjA8eyx4zfjSWZyeWYVgWCP1MxIbHiqpQ1QGMSMbMWGEMeqvDo7FrXE7cBayE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788786357; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Gf8VYP7N4hATDrTiZzU5GMGZ3enK1g/UcrmTROQWkzM=;
 b=L0QgZmHM3nOkKdD2ye4+33yWNIVb/yG0ENQNb169/2jnPHALzTEAqkvSNy29UfVh
 /upEar/QwWHOOC8aVuNkCxMGuETikiKJ1KiFcg12CWaCH6vomcrtXFkzQyU2BuPeyc7
 6IkcntT6ZoBDsc+SCRi0O6EOf+iVQduIu4CnG0Ww=
Received: by mx.zohomail.com with SMTPS id 1788786355604643.0054626038584;
 Mon, 7 Sep 2026 06:05:55 -0700 (PDT)
Message-ID: <fc5c5bc5-d3a5-47f4-8a86-bcd531f0803c@collabora.com>
Date: Mon, 7 Sep 2026 16:05:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About new backend for GPU compute ROCm in qemu
To: "Huang, Honglei" <honghuan@amd.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Airlie <airlied@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 Honglei Huang <honglei1.huang@amd.com>, Huang Rui <Ray.Huang@amd.com>
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
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

On 8/17/26 06:19, Huang, Honglei wrote:
> Hi Michael, Alex, Dmitry, Akihiko,
> 
> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm over
> virtio
> implementation to virglrenderer nine months ago (MR !1568 [1]). The ROCm
> side has
> been supportted by ROCm offical.
> 
> Current implementation is a virtio gpu context type capset handled inside
> virglrenderer, sharing the display path. That's an awkward fit, many
> compute GPUs have no display engine at all.

The headless context type is totally fine with virtio-gpu. For example,
ChoromeOS wirh crosvm disables display entirely even on guest side by
building virtio-gpu kernel driver without KMS support. This is something
to improve in QEMU to make it work without GL context.

-- 
Best regards,
Dmitry
