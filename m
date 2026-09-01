Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2190C624D4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5FC10ED15;
	Tue,  1 Sep 2026 14:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SpXqayWN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C3710ED0D;
 Tue,  1 Sep 2026 14:07:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B89741A73;
 Tue,  1 Sep 2026 14:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6C51F000E9;
 Tue,  1 Sep 2026 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788271677;
 bh=dOFHe9qy1FZ9AF7sT7V/8hJAwDE8aQjo4Sa9CzpQyek=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=SpXqayWNt+PO/X6NDg09ZCcJ7lHRUQ/2K46HBjqYSObsNhAQptkcFYcbB6YEvLbFF
 kNK6Ci3Ls4HI8VXFRbDxa/TL7v4SKF4170GWynJ7a+Idu7Ofz+tioACRnAQlMtKrxX
 pdEPo6Vikx4ZKHGsXA4h6RcG1vyoDFl6LAwpSdw9ghO/GBDZNNdMQPCNd0SrPCfR2C
 soWF9BoDtgFC+7RKtccvM4lG2iWvCWV6JdHvVqUtsf+QvN9QJK2vxFlnyI5Anmhfu1
 WiybX0lRfZSAeoFgTHjDphX/6qLBX9Z6jrgspOGZpPBxDnDSaIp5Fo1DDddItnjOjT
 0owUZHSaKERJQ==
Message-ID: <8cb96c08-2d1e-459e-b356-c6fd97ef869e@kernel.org>
Date: Tue, 1 Sep 2026 16:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/nouveau: Use write-combined maps for coherent
To: webgeek1234@gmail.com
Cc: Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Faith Ekstrand <faith.ekstrand@collabora.com>
References: <20260821-tegra-coherent-wc-v2-1-2b1ddb67bf18@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260821-tegra-coherent-wc-v2-1-2b1ddb67bf18@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 8/22/26 6:42 AM, Aaron Kling via B4 Relay wrote:
> From: Faith Ekstrand <faith.ekstrand@collabora.com>
> 
> On Tegra devices, uncached maps traslate to device memory, causing
> unaligned accesses by userspace resulting in a SIGBUS. Instead, use
> write-combined maps to ensure proper access.
> 
> This would also affect discrete cards on any Arm device. It was
> determined that discrete cards regardless of cpu arch should use
> write-combined maps for coherent anyways. Thus this change is made for
> all gpu types.
> 
> Signed-off-by: Faith Ekstrand <faith.ekstrand@collabora.com>
> Co-developed-by: Aaron Kling <webgeek1234@gmail.com>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
Can you please provide a Fixes: tag? Also, please remember to Cc: stable if necessary.

Thanks,
Danilo
