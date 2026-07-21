Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE71C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240CC10E30C;
	Tue, 21 Jul 2026 15:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="gnzgDNT5";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D55D10E30C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784648666; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=O1kG6NT9WOyzOQ3Ab2sOFzfAgxyHepiApDdSRC/EX2qL4Krtz6mCO5avBhNNckkkSfG2jLWk7/W4rp1mNGWFcS2AYbiqlzP53tbLlauf3PzZC8M0a43qmLBA5Z2KQKzwj7u+iEr0GR+d1DZrt0PHtaulvrSP6b5ga9t34dKXJFM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784648666;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=D8PBYrQ4YPcunm4lLG2ndQFB30ddKR6a6PQEpXHHZvo=; 
 b=hwftvQ6To9nv/AFCbXo2d4T3pXJynY6dVSV+ZlBVatSr7tVvexYJeS6uK2jMMTQ9fK9kSeJK6QFanNHgwBiaIzSVd37rGv8s3cxMTX4G5kjkgsJZSI/ED27tyqkKs0fHqQUCuC85cq3uQI5U0eLKlmSFrkeZKUfjl2ZCabXGp8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784648666; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=D8PBYrQ4YPcunm4lLG2ndQFB30ddKR6a6PQEpXHHZvo=;
 b=gnzgDNT5eMjlFXedAXMDkCcxKfnlx24aHka4VRyh79ZO9t30K4Eg1sBwYGb283Ui
 7ktkE8mRpYkYpuIp1ufQ0TvavTPNToYOMdQncFbNavZZylidQXFQUUvTC2WY8GpCVnG
 eWZ7aKJG92sVV5Tfy+zn+wn5zJBOn3pBkSeHMZh4=
Received: by mx.zohomail.com with SMTPS id 1784648664929838.4168152345043;
 Tue, 21 Jul 2026 08:44:24 -0700 (PDT)
Message-ID: <87b82d38-fb6a-44ed-abad-e5a3ac9add1e@collabora.com>
Date: Tue, 21 Jul 2026 17:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] software_isp: debayer_egl: Re-add log for failing
 DMABuf import
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260721130839.85262-1-robert.mader@collabora.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260721130839.85262-1-robert.mader@collabora.com>
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

P.S.: this should also help with testing the CAMSS pipeline handler 
(https://patchwork.libcamera.org/cover/27426/), which *should* be able 
to accommodate requested strides - and thus always allow dmabuf import 
\o/ (I haven't tested that yet, will try ASAP).

On 21.07.26 15:08, Robert Mader wrote:
> The log was introduced in commit
> 93f0db167a8d ("debayer_egl: Implement dmabuf import for input buffers")
> and dropped in the commit mentioned below. Let's readd it as failing
> imports majorly impact performance and indicate actionable issues in the
> V4L2 or GPU drivers. Ensure the log is only printed once, now that we use
> multiple eGLImages.
>
> Fixes: 13f7b921acdf ("libcamera: software_isp: debayer_egl: Implement input/output frame caching mechanism")
> Signed-off-by: Robert Mader <robert.mader@collabora.com>
> ---
>   src/libcamera/software_isp/debayer_egl.cpp | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/src/libcamera/software_isp/debayer_egl.cpp b/src/libcamera/software_isp/debayer_egl.cpp
> index 02651fe87922..8e0a9b79dfa4 100644
> --- a/src/libcamera/software_isp/debayer_egl.cpp
> +++ b/src/libcamera/software_isp/debayer_egl.cpp
> @@ -533,6 +533,8 @@ eGLImage *DebayerEGL::getCachedInputFrameBuffer(FrameBuffer *input, std::optiona
>   		if (egl_.createInputDMABufTexture2D(*eglImageIn, input->planes()[0].fd.get()) == 0)
>   			return eglImageIn;
>   
> +		if (eglImageInCache_.size() == 1)
> +			LOG(Debayer, Info) << "Importing input buffer with DMABuf import failed, falling back to upload";
>   	} else if (!eglImageIn->dmabuf_import_failed_) {
>   		egl_.activateBindTexture(*eglImageIn);
>   		return eglImageIn;

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

