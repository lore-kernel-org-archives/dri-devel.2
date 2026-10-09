Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC80ECA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9B610EB0C;
	Fri,  9 Oct 2026 18:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="KOt+7J33";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122D710EB0C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791571616; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bgSl2cLdivPj0FGLrRjRXccvLNkUXeT8tdAb122PXeae/keTuv4+QZSIIPKfHD1GvjehpWdNOI7G9QGhXDigTq6z4Bmp9dZsmgDgG5LGOQ/PyKjJzf3ngXFn5rVMMbTjevMjL2dyKBpoRHkYzDxvXtJetJuL5/NluyJIQHHNb2A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791571616;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=sNaQMcbvojwqaa6CpBCGayYt2Qv26FQpb2UDUBNOFG8=; 
 b=BfZyZ2/bM2OAAcoVcnOZ01Xq2K5WG7KIYNZ2ufp6e1A7/PbafYKNnDHCC05InIKai7f2WAaa6OsWH8zUqP7uYpqwasP1PEKlnVxuXLdK8ivxdZcKvK2+NyExpTukh0n+iNTfRBK1xEcdxYL2Elr2493sSsKhC8r0CDEP6NsNWGI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791571616; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=sNaQMcbvojwqaa6CpBCGayYt2Qv26FQpb2UDUBNOFG8=;
 b=KOt+7J3380H/WWmsyxhoxHbmGrc1pwnr9bBQgY9PXU4jnGjfRXCF+P1/eFRl1u3q
 Yey7EY0mfrjpjQbtBOYFKbCb43xufiJ18ZSu2sbUfynrVyPVHnuYzh77Orc+Z48dcja
 zUNaIOdIpl3PtfFtb6MePPhaKtWoguZm6nUBEJmw=
Received: by smtp.zohomail.com with SMTPS id 1791571615413714.4154527093252;
 Fri, 9 Oct 2026 11:46:55 -0700 (PDT)
Message-ID: <f0c5d61a-d4bd-4f92-aba9-50c67cef74c6@collabora.com>
Date: Fri, 9 Oct 2026 21:46:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Honglei Huang <honghuan@amd.com>, odaki@rsg.ci.i.u-tokyo.ac.jp,
 airlied@redhat.com, kraxel@redhat.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
 <f2e66335-5538-442f-80ad-94626a66b4d0@collabora.com>
Content-Language: en-US
In-Reply-To: <f2e66335-5538-442f-80ad-94626a66b4d0@collabora.com>
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

09.10.2026 21:38, Dmitry Osipenko пишет:
> 24.09.2026 12:55, Honglei Huang пишет:
>> +	mm = current->mm;
>> +	mmgrab(mm);
>> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>> +	new_pinned = atomic64_add_return(userptr->npages, &mm->pinned_vm);
>> +	if (new_pinned < 0 ||
>> +	    (new_pinned > lock_limit && !capable(CAP_IPC_LOCK))) {
>> +		atomic64_sub(userptr->npages, &mm->pinned_vm)
> 
> At a quick glance over other kernel code touching pinned_vm, nobody else
> check for new_pinned < 0 and then doing atomic64_sub() for the negative
> value will be incorrect.
Though no, negative will restore pinned_vm. Still neg looks confusing
and shouldn't be needed as such overflow shouldn't be possible.

-- 
Best regards,
Dmitry
