Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF53606A332
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=SrI6B9Rr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7BC10E906;
	Fri, 27 Nov 2026 14:32:20 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8CC810E906
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795789926; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VDJenMUGCxMYbbi1tIZ5vUH5bIfnpXpyi64KZvys2WATQxZLJ/ZN7wp44T5c+wMi7b6TMocbG0nezaUoSBeD0f7pOhEafK0EGTEaeamzR2gBoO1NqKreTVKLxBSeGw1f6Le0NP7IPMkPzx687Q4wTmRkUtNI94jCijrcbGiGs7o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795789926;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2aBCFCTbBvxpXomypl7B95nglL+nlWfk31gcjZu/DpI=; 
 b=XSTb9+og9p4FkcVVKVYp4xUSFHSbrqPO9xVEZ05f5MezQNgbSvhYDFFqhV7R/AxFM9NI3m49VKRNEOUGcp/8wnqNmMnpkI6VPDIlUF82eYDLK7650tCu+pIBIT6xk3axpUVBT+zRyA44qiBchV7sgSYKX4PbOBrH9h2W7TOqzWw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=SrI6B9RrxfzAem+fDD1WawCBZ18NkTHs+cGuM1AaKyASlQF8Ff6q8sS1Vcu+jifYXj8+NTxctInsN6bQFoiJ8p+9JskLOzi4ud9iCfuhZt1XOZZd1UKrHh6TxAQ9V6y/hI9Qw7Z0xK2Z6Bk6JWgK6oJC/KQrm1VRsOOS+FCebQI=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=2aBCFCTbBvxpXomypl7B95nglL+nlWfk31gcjZu/DpI=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795789924543373.26687838343344; 
 Fri, 27 Nov 2026 06:32:04 -0800 (PST)
Message-ID: <ef65b7ae-3d02-46ee-ad2f-b260156ef96e@collabora.com>
Date: Fri, 27 Nov 2026 17:32:00 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 0/4] drm/virtio: userptr blobs for native-context
 compute
To: "Huang, Honglei" <honghuan@amd.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261106082625.812860-1-honghuan@amd.com>
 <baa471a6-502d-41ac-9ef3-cbac35a103e0@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <baa471a6-502d-41ac-9ef3-cbac35a103e0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/25/26 09:41, Huang, Honglei wrote:
> 
> 
> On 11/6/2026 4:26 PM, Honglei Huang wrote:
>> This series adds virtio-gpu userptr support for ROCm native compute
>> contexts. The guest kernel pins an existing userspace mapping with
>> FOLL_LONGTERM and exposes it to the host as ordinary CREATE_BLOB
>> backing entries, avoiding a second shmem allocation and memcpy.
>>
>> A non-zero userptr field selects that path. Probe
>> VIRTGPU_PARAM_USERPTR before using the field so an older guest kernel
>> rejects the request instead of silently creating a shmem blob.
>>
>> See overall detail in virglrenderer pr [1]
> 
> Hi all，
> 
> Any review comments on this series? includes code for the kernel, QEMU,
> and other components.
> 
> Open to any review.

I want to see ack on VIRTIO_GPU_FLAG_BLOB_READONLY_ENABLED and userptr 
patches from Akihiko before merging since he requested the RO 
enforcement feature and reviewed userpatch patch.

BTW, you may drop RFC, this is already v10. RFC usually comes before v1.

-- 
Best regards,
Dmitry
