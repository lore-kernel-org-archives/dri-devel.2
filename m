Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFEF606A329
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=S0qevYvT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85439112942;
	Fri, 27 Nov 2026 13:59:32 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7091C112942
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 13:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795787960; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=l6K5E+wchjbGdxPQMjhGwJbtozTQtl3Sx1j3oHpqu3m9iqbSFjLsdUwqk7k5YU/cmOkVtG4GmPHGxGcXFiuS5PS7G2/TDJqFV4zsHL1Q7kHDxOxAPD+dgu5os7Q4WOlO8g+gX2EzkCdmarnjO1w9h7fGG1YZleFMSNTWyWpXzXc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795787960;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tKSwWGPywgAjoaUngfywEwxme3HZ7cIz0HVuvH/8oME=; 
 b=b46ellFmGAKLvMElBM/OGIxrqvVJgR9y+JyvknSGGnEY82aRSZKPxmNhpANToO5nFiNTyRDj51toYBuMBK/ID+Rvs8bPEh8ENxnwVFLUdqVq6cq7twNA8hj4XiiXPX1kCTZonNhJC43BP/6Gkxkol6Ym+F5ThfcKTlVZc3rW70E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=S0qevYvT2Vk8RwgmpyY2Ia+nYGL/aDmP19PyAw8f1SagRxdqlEscYL6jukFjX1ArZbaGwVaZnuFwzxliLsUbVKPhP2yU/hCRVlPMU7v3jJoyWWkizXv2QBzn4q2S32j0rAlfGroTQt7AahpC/9HGGo4x0CZgmrMMgh2KcCucG6I=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=tKSwWGPywgAjoaUngfywEwxme3HZ7cIz0HVuvH/8oME=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795787958047954.779870201865;
 Fri, 27 Nov 2026 05:59:18 -0800 (PST)
Message-ID: <e658ea49-9307-4abc-a579-224e8342ff41@collabora.com>
Date: Fri, 27 Nov 2026 16:59:13 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 4/4] drm/virtio: wire blob ioctl creation to
 userptr objects
To: Honglei Huang <honghuan@amd.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Val Packett <val@invisiblethingslab.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261106082625.812860-1-honghuan@amd.com>
 <20261106082625.812860-5-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261106082625.812860-5-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 11:26, Honglei Huang wrote:
> @@ -495,10 +516,15 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
>   	params->blob = true;
>   	params->blob_flags = rc_blob->blob_flags;
>   	params->blob_hints = rc_blob->blob_hints;
> +	params->userptr = rc_blob->userptr;
>   
> -	if (vgdev->has_blob_alignment &&
> -	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
> -		return -EINVAL;
> +	if (vgdev->has_blob_alignment) {
> +		if (!IS_ALIGNED(params->size, vgdev->blob_alignment))
> +			return -EINVAL;
> +
> +		if (!IS_ALIGNED(params->userptr, vgdev->blob_alignment))
> +			return -EINVAL;
> +	}
>   

There was a bug reported RE the alignment check on [1], my proposal 
there is to align allocated size to host page size.

[1] 
https://lore.kernel.org/dri-devel/20261006154913.2689067-2-val@invisiblethingslab.com/

In virtio_gpu_userptr_create() I see it rejects size that is not aligned 
to PAGE_SIZE, but for VRAM and shmem BOs the driver code implicitly 
aligns size to PAGE_SIZE. Could we do the same for userptr for consistency?

-- 
Best regards,
Dmitry
