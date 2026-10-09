Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E049CCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C5E310EAF9;
	Fri,  9 Oct 2026 18:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ZnuaAN0r";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6096310EAF9
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791571092; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Tr40Pw/N1/p1xdjaB+TrQFX+EkUgx+GJ16h7TdmRNNE8Njkhq9ZeJenec5nbW027f6NxNoUhX75LGM4FVqmVjW+Wnr+O9LeBYnculGRhTF5isE3m6mk5HaiG8v0Oge+CBZMEQEoGaC1tBVuvtJGkU7gBwD7pjPA+79QR0diNLOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791571092;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QuWSPsqQUuQxbHw42K0AOt4zUancOykowkLmXiRZhhY=; 
 b=VvWLyNYQsCC0VzKGn16+h8HnTrTjlVHWcAakb7vf45FFng6SRP4xTUFOKOQwOOok6S8UDd5bmzYohOz6PqBRhOp6wcfgSV7XzFJk+u8aMfXrfOhaQrKPTXHhU4BB9Kf+JDS4makQWzsdf4V8VJGb8LMBCM2j5vhBZOmfGB9PduY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791571092; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=QuWSPsqQUuQxbHw42K0AOt4zUancOykowkLmXiRZhhY=;
 b=ZnuaAN0rNkLIPRCr8UKYQYCmsV8oYOzOf0c5beJJadzYmRxt6qXTWc5jURrg+RxN
 Tf+ZzuZZOZcHtpajF52Ehh6KjQJb7u2ftk2uwrefgR9x23MxdYT6SfU9w4hYoU8mfSj
 CQ8UPFlrFESOreca1+z0ZERA9ADYd9nC8HUW1nMA=
Received: by smtp.zohomail.com with SMTPS id 1791571090915569.1520305278708;
 Fri, 9 Oct 2026 11:38:10 -0700 (PDT)
Message-ID: <f2e66335-5538-442f-80ad-94626a66b4d0@collabora.com>
Date: Fri, 9 Oct 2026 21:38:07 +0300
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
> +	mm = current->mm;
> +	mmgrab(mm);
> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	new_pinned = atomic64_add_return(userptr->npages, &mm->pinned_vm);
> +	if (new_pinned < 0 ||
> +	    (new_pinned > lock_limit && !capable(CAP_IPC_LOCK))) {
> +		atomic64_sub(userptr->npages, &mm->pinned_vm)

At a quick glance over other kernel code touching pinned_vm, nobody else
check for new_pinned < 0 and then doing atomic64_sub() for the negative
value will be incorrect.

-- 
Best regards,
Dmitry
